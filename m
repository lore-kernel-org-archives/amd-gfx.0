From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 14/14] drm/amd/amdgpu: Enable stoney VCE PG
Date: Thu, 28 Jul 2016 10:19:12 -0400
Message-ID: <20160728141912.18140-15-tom.stdenis@amd.com>
References: <20160728141912.18140-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160728141912.18140-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCmluZGV4
IDI2ZDE1YTQ0NmFkMC4uMzNiYWQ5OTE3NmZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKQEAg
LTE2MDgsNyArMTYwOCw4IEBAIHN0YXRpYyBpbnQgdmlfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAq
aGFuZGxlKQogCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9HRlhfUEcgfAogCQkJ
QU1EX1BHX1NVUFBPUlRfR0ZYX1NNRyB8CiAJCQlBTURfUEdfU1VQUE9SVF9HRlhfUElQRUxJTkUg
fAotCQkJQU1EX1BHX1NVUFBPUlRfVVZEOworCQkJQU1EX1BHX1NVUFBPUlRfVVZEIHwKKwkJCUFN
RF9QR19TVVBQT1JUX1ZDRTsKIAkJYWRldi0+ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0+cmV2X2lk
ICsgMHgxOwogCQlicmVhazsKIAlkZWZhdWx0OgotLSAKMi45LjIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
