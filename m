From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/10] drm/amd/amdgpu: cleanup gfx_v9_0_rlc_start()
Date: Wed, 5 Apr 2017 09:26:08 -0400
Message-ID: <20170405132610.26075-8-tom.stdenis@amd.com>
References: <20170405132610.26075-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170405132610.26075-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

VXNlIG5ldyBXUkVHMzJfRklFTEQxNSBtYWNybwoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlz
IDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCA2YmM5ODU2
ZTY3YTcuLjgwNzAwMzU2NDc0YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
CkBAIC0xNDEwLDEwICsxNDEwLDggQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfcmxjX3N0YXJ0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogI2lmZGVmIEFNREdQVV9STENfREVCVUdfUkVUUlkK
IAl1MzIgcmxjX3Vjb2RlX3ZlcjsKICNlbmRpZgotCXUzMiB0bXAgPSBSUkVHMzIoU09DMTVfUkVH
X09GRlNFVChHQywgMCwgbW1STENfQ05UTCkpOwogCi0JdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAs
IFJMQ19DTlRMLCBSTENfRU5BQkxFX0YzMiwgMSk7Ci0JV1JFRzMyKFNPQzE1X1JFR19PRkZTRVQo
R0MsIDAsIG1tUkxDX0NOVEwpLCB0bXApOworCVdSRUczMl9GSUVMRDE1KEdDLCAwLCBSTENfQ05U
TCwgUkxDX0VOQUJMRV9GMzIsIDEpOwogCiAJLyogY2Fycml6byBkbyBlbmFibGUgY3AgaW50ZXJy
dXB0IGFmdGVyIGNwIGluaXRlZCAqLwogCWlmICghKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkp
Ci0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
