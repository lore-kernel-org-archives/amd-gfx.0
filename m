From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 051/120] drm/amd/display: reduce 40s time out to 1s in disable
 crtc
Date: Wed, 9 Aug 2017 11:01:37 -0400
Message-ID: <20170809150246.8835-52-harry.wentland@amd.com>
References: <20170809150246.8835-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170809150246.8835-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eric Yang <Eric.Yang2-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkzZWJhMjA3
MGZmNDA5YWY0ODIzODQxYmViNTM2OTYyMDBiNWFlYzhjClNpZ25lZC1vZmYtYnk6IEVyaWMgWWFu
ZyA8RXJpYy5ZYW5nMkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVu
Z0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3RpbWlu
Z19nZW5lcmF0b3IuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24xMC9kY24xMF90aW1pbmdfZ2VuZXJhdG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMTAvZGNuMTBfdGltaW5nX2dlbmVyYXRvci5jCmluZGV4IDBlZjVkOGYwNjI1Yy4u
ZjRkY2UyODA2YWUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMTAvZGNuMTBfdGltaW5nX2dlbmVyYXRvci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24xMC9kY24xMF90aW1pbmdfZ2VuZXJhdG9yLmMKQEAgLTQyOSw3ICs0Mjks
NyBAQCBzdGF0aWMgYm9vbCB0Z24xMF9kaXNhYmxlX2NydGMoc3RydWN0IHRpbWluZ19nZW5lcmF0
b3IgKnRnKQogCS8qIENSVEMgZGlzYWJsZWQsIHNvIGRpc2FibGUgIGNsb2NrLiAqLwogCVJFR19X
QUlUKE9UR19DTE9DS19DT05UUk9MLAogCQkJT1RHX0JVU1ksIDAsCi0JCQkyMDAwLCAyMDAwMCk7
CisJCQkyMDAwLCA1MDApOwogCiAJcmV0dXJuIHRydWU7CiB9Ci0tIAoyLjExLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
