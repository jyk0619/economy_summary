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
  const apiKey = process.env.STOCK_API_KEY;
  const symbol = req.query.symbol || 'AAPL'; // 기본값은 AAPL
  const fromDate = req.query.from || '2023-01-01'; // 기본값은 2023년 1월 1일
   const toDate = req.query.to || '2023-12-31'; // 기본값은 2023년 12월 31일
  const apiUrl = `https://financialmodelingprep.com/stable/historical-price-eod/full?symbol=${symbol}&from=${fromDate}&to=${toDate}&apikey=${apiKey}`;

  try {
    const response = await axios.get(apiUrl);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ message: '주식 데이터를 가져오지 못했습니다.', error: error.toString() });
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
    console.log('🔐 API Key:', process.env.RAPIDAPI_KEY); // 확인용
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
