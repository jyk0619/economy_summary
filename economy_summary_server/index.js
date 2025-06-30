require('dotenv').config();


const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors()); // 모든 요청에 대해 CORS 허용

// 프록시 라우트
app.get('/exchange', async (req, res) => {
  const { searchdate } = req.query;
  const apiKey = process.env.EXIM_API_KEY;
  const apiUrl = `https://oapi.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=${apiKey}&searchdate=${searchdate}&data=AP01`;

  try {
    const response = await axios.get(apiUrl);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ message: '환율 데이터를 가져오지 못했습니다.', error: error.toString() });
  }
});

app.listen(port, () => {
  console.log(`Proxy server running at http://localhost:${port}`);
});
