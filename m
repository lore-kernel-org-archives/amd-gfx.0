From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/10] drm/amd/amdgpu: cleanup gfx_v9_0_gpu_init()
Date: Wed, 5 Apr 2017 09:26:10 -0400
Message-ID: <20170405132610.26075-10-tom.stdenis@amd.com>
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
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCAyZGQzMjQ2
NjkxOWQuLjMzZGYwZGJlNzA1MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
CkBAIC0xMjg4LDkgKzEyODgsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjlfMF9ncHVfaW5pdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl1MzIgdG1wOwogCWludCBpOwogCi0JdG1wID0gUlJF
RzMyKFNPQzE1X1JFR19PRkZTRVQoR0MsIDAsIG1tR1JCTV9DTlRMKSk7Ci0JdG1wID0gUkVHX1NF
VF9GSUVMRCh0bXAsIEdSQk1fQ05UTCwgUkVBRF9USU1FT1VULCAweGZmKTsKLQlXUkVHMzIoU09D
MTVfUkVHX09GRlNFVChHQywgMCwgbW1HUkJNX0NOVEwpLCB0bXApOworCVdSRUczMl9GSUVMRDE1
KEdDLCAwLCBHUkJNX0NOVEwsIFJFQURfVElNRU9VVCwgMHhmZik7CiAKIAlnZnhfdjlfMF90aWxp
bmdfbW9kZV90YWJsZV9pbml0KGFkZXYpOwogCi0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
