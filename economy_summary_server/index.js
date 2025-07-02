require('dotenv').config();


const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors()); // 모든 요청에 대해 CORS 허용

// 프록시 라우트

//환율
app.get('/exchange', async (req, res) => {
  const apiKey = process.env.EXIM_API_KEY;
  const apiUrl = `https://oapi.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=${apiKey}&data=AP01`;

  try {
    const response = await axios.get(apiUrl);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ message: '환율 데이터를 가져오지 못했습니다.', error: error.toString() });
  }
});

app.get('/stock', async (req, res) => {
  // symbols=AAPL,TSLA,NVDA 형태로 받기
  const symbolsParam = req.query.symbols || 'NVDA';
  const symbols = symbolsParam.split(','); // 문자열 → 배열

  const headers = {
    'X-RapidAPI-Key': process.env.RAPIDAPI_KEY,
    'X-RapidAPI-Host': 'apidojo-yahoo-finance-v1.p.rapidapi.com'
  };

  try {
    // 각 symbol마다 요청
    const requests = symbols.map(symbol => {
      const url = `https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v3/get-chart?interval=5m&region=US&symbol=${symbol}&range=5d&includePrePost=true&useYfid=true&includeAdjustedClose=true`;
      return axios.get(url, { headers });
    });

    // 병렬로 요청 후 응답을 기다림
    const responses = await Promise.all(requests);

    // 결과 매핑
    const results = responses.map((response, idx) => ({
      symbol: symbols[idx],
      data: response.data
    }));

    res.json(results); // 배열 형태로 응답
  } catch (e) {
    console.error('💥 Error fetching stock data:', e.message);
    res.status(500).json({ message: '여러 주식 정보를 가져오지 못했습니다.', error: e.toString() });
  }
});


app.get('/indexs', async (req, res) => {
  const url = 'https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=%5EIXIC%2C%20%5EDJI%2C%20%5EGSPC%2C%20%5EKS11%2C%20%5EKQ11';

  const options = {
    headers: {
      'X-RapidAPI-Key': process.env.RAPIDAPI_KEY,
      'X-RapidAPI-Host': 'apidojo-yahoo-finance-v1.p.rapidapi.com'
    }
  };

  try {
    const response = await axios.get(url, options);
    res.json(response.data);
  } catch (e) {
    console.error('💥 Error fetching data:', e.message);
    res.status(500).json({ message: '지수 정보를 가져오지 못했습니다.', error: e.toString() });
  }
});

app.listen(port, () => {
  console.log(`Proxy server running at http://localhost:${port}`);
});
