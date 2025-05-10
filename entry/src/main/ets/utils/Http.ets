import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

const service = axios.create({
  baseURL: "https://api.ownthink.com",
  timeout: 10000
})
//请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  AlertDialog.show({
    message: '1'
  })
  return config
}, (error: AxiosError) => {
  return Promise.reject(error);
});
//响应拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  AlertDialog.show({
    message: JSON.stringify(response)
  })
  return response.data.data
}, (error: AxiosError) => {
  return Promise.reject(error);
});

//自定义请求
export class Http {
  static get<T>(url: string, params?: object) {
    return service.get<null, T>(url, {
      params
    })
  }

  static post<T>(url: string, data?: object) {
    return service.post<null, T>(url, data)
  }

  static put<T>(url: string, data?: object) {
    return service.put<null, T>(url, data)
  }

  static delete<T>(url: string, data?: object) {
    return service.delete<null, T>(url, data)
  }
}

export default service

