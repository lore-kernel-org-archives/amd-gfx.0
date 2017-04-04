From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: Fix psp_v3_1 compare sram
Date: Tue, 4 Apr 2017 12:05:10 -0400
Message-ID: <20170404160511.25102-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

SGFkIHRoZSB3cm9uZyBzZW5zZSBpbiB0aGUgbG9vcAoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERl
bmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3BzcF92M18xLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNf
MS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YzXzEuYwppbmRleCA1MTkxYzQ1
ZmZkZjMuLjA5MDBmZGYwNjUxYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvcHNwX3YzXzEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5j
CkBAIC00OTEsNyArNDkxLDcgQEAgYm9vbCBwc3BfdjNfMV9jb21wYXJlX3NyYW1fZGF0YShzdHJ1
Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAogCXVjb2RlX3NpemUgPSB1Y29kZS0+dWNvZGVfc2l6ZTsK
IAl1Y29kZV9tZW0gPSAodWludDMyX3QgKil1Y29kZS0+a2FkZHI7Ci0Jd2hpbGUgKCF1Y29kZV9z
aXplKSB7CisJd2hpbGUgKHVjb2RlX3NpemUpIHsKIAkJZndfc3JhbV9yZWdfdmFsID0gUlJFRzMy
KGZ3X3NyYW1fZGF0YV9yZWdfb2Zmc2V0KTsKIAogCQlpZiAoKnVjb2RlX21lbSAhPSBmd19zcmFt
X3JlZ192YWwpCi0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
