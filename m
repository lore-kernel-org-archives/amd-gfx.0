From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/9] drm/amdgpu: enable hdp clock gating for Arcturus
Date: Thu, 8 Aug 2019 18:21:51 +0800
Message-ID: <1565259714-30357-4-git-send-email-le.ma@amd.com>
References: <1565259714-30357-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565259714-30357-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>

SW5pdCBoZHAgTUdDRy9MUyBmbGFnIGFzIFZlZ2EyMAoKQ2hhbmdlLUlkOiBJYTMzY2EwNjRmNzlh
YzQwOWM1M2QzYmViNmYwMWI2ZTgxNGE5MjA0MQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgNCArKyst
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggNGZiYWNhMy4uNjAzOGRjZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jCkBAIC0xMDE3LDcgKzEwMTcsOSBAQCBzdGF0aWMgaW50IHNvYzE1
X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCUFNRF9DR19TVVBQT1JUX0dGWF9N
R0xTIHwKIAkJCUFNRF9DR19TVVBQT1JUX0dGWF9DR0NHIHwKIAkJCUFNRF9DR19TVVBQT1JUX0dG
WF9DR0xTIHwKLQkJCUFNRF9DR19TVVBQT1JUX0dGWF9DUF9MUzsKKwkJCUFNRF9DR19TVVBQT1JU
X0dGWF9DUF9MUyB8CisJCQlBTURfQ0dfU1VQUE9SVF9IRFBfTUdDRyB8CisJCQlBTURfQ0dfU1VQ
UE9SVF9IRFBfTFM7CiAJCWFkZXYtPnBnX2ZsYWdzID0gMDsKIAkJYWRldi0+ZXh0ZXJuYWxfcmV2
X2lkID0gYWRldi0+cmV2X2lkICsgMHgzMjsKIAkJYnJlYWs7Ci0tIAoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
