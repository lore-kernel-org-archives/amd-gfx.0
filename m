From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: Re-enable PG for GFX on Stoney
Date: Sun, 24 Jul 2016 19:20:27 -0400
Message-ID: <20160724232027.5604-3-tom.stdenis@amd.com>
References: <20160724232027.5604-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160724232027.5604-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

V2l0aCBTTVUgU0NMSyBhbmQgQ1AgUEcgZGlzYWJsZWQgdGVzdGluZyBwYXNzZXMuCgpTaWduZWQt
b2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmkuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCmluZGV4IGI5MTJm
YTNlZmQyZC4uNjM4NTBkZGQ5NTVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKQEAgLTE2MDIs
NyArMTYwMiw5IEBAIHN0YXRpYyBpbnQgdmlfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxl
KQogCQkJQU1EX0NHX1NVUFBPUlRfSERQX0xTIHwKIAkJCUFNRF9DR19TVVBQT1JUX1NETUFfTUdD
RyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX0xTOwotCQlhZGV2LT5wZ19mbGFncyA9IDA7CisJ
CWFkZXYtPnBnX2ZsYWdzIHw9IEFNRF9QR19TVVBQT1JUX0dGWF9QRyB8CisJCQlBTURfUEdfU1VQ
UE9SVF9HRlhfU01HIHwKKwkJCUFNRF9QR19TVVBQT1JUX0dGWF9QSVBFTElORTsKIAkJYWRldi0+
ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0+cmV2X2lkICsgMHgxOwogCQlicmVhazsKIAlkZWZhdWx0
OgotLSAKMi45LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
