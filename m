From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 7/9] drm/amdgpu: enable sdma clock gating for Arcturus
Date: Thu, 8 Aug 2019 18:21:54 +0800
Message-ID: <1565259714-30357-7-git-send-email-le.ma@amd.com>
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

SW5pdCBzZG1hIE1HQ0cvTFMgZmxhZwoKQ2hhbmdlLUlkOiBJNjAwYjhjNjdiMWRmYTc0MjQwMjY5
ZjJmMDI4OTYwYjJjOTNhMGVjMgpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgNCArKystCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzE1LmMKaW5kZXggNjAzOGRjZS4uYWQ2NDk3NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MxNS5jCkBAIC0xMDE5LDcgKzEwMTksOSBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9l
YXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCUFNRF9DR19TVVBQT1JUX0dGWF9DR0xTIHwKIAkJ
CUFNRF9DR19TVVBQT1JUX0dGWF9DUF9MUyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9IRFBfTUdDRyB8
Ci0JCQlBTURfQ0dfU1VQUE9SVF9IRFBfTFM7CisJCQlBTURfQ0dfU1VQUE9SVF9IRFBfTFMgfAor
CQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9NR0NHIHwKKwkJCUFNRF9DR19TVVBQT1JUX1NETUFfTFM7
CiAJCWFkZXYtPnBnX2ZsYWdzID0gMDsKIAkJYWRldi0+ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0+
cmV2X2lkICsgMHgzMjsKIAkJYnJlYWs7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
