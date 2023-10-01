Tractable Shader Framework (TSF)
====

複数レンダーパイプラインで動作するシェーダーを作成するためのフレームワークです。これは現在開発中で破壊的な変更が行われる可能性があります。

## 実装済みの機能

## 実装予定の機能
- Built-in Render Pipeline対応
- Universal Render Pipeline対応
- High Definition Render Pipeline対応
- 頂点座標、UV座標（UV0～3）、法線、タンジェント、頂点カラーへのアクセス
- 頂点シェーダーでの頂点IDへのアクセス
- ピクセルシェーダーでの面の向きへのアクセス
- Transform系関数の提供
- M行列、V行列、P行列へのアクセス
- Time変数へのアクセス
- カメラ座標へのアクセス
- 画面解像度へのアクセス
- VR対応
- ライトごとにカスタムしたシェーディングを行えるようにする
- ノーマルマップ展開用の関数の提供
- 任意のInterpolatorを追加可能にする
- Vベクトルや深度の提供
- GrabPass、_CameraOpaqueTextureを用いたカラーバッファへのアクセス
- _CameraDepthTextureを用いた深度バッファへのアクセス
- 上記テクスチャ2種の有無を判定する関数の提供
- 視錐台がカメラに対し傾いている場合でも正常に復元できるLinearEyeDepth関数の提供
- マルチパスシェーダー対応（最大2パス）