From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 4/7] drm/amd/pp: Disable OD feature on CI/Iceland.
Date: Fri, 19 Jan 2018 16:10:08 +0800
Message-ID: <1516349411-18102-5-git-send-email-Rex.Zhu@amd.com>
References: <1516349411-18102-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516349411-18102-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJOWJiNDJkNzBiNmE2YjMxYzBlZWNjM2VlMmZhZjQ4Nzk4Mjk1NzM1NgpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9o
d21nci9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3Iu
YwppbmRleCAyNjkwNDQ2Li5jNTQxMWZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2h3bWdyL2h3bWdyLmMKQEAgLTE2Nyw2ICsxNjcsNyBAQCBpbnQgaHdtZ3JfZWFybHlfaW5p
dChzdHJ1Y3QgcHBfaW5zdGFuY2UgKmhhbmRsZSkKIAkJaHdtZ3ItPmZlYXR1cmVfbWFzayAmPSB+
KFBQX1ZCSV9USU1FX1NVUFBPUlRfTUFTSyB8CiAJCQkJCVBQX0VOQUJMRV9HRlhfQ0dfVEhSVV9T
TVUpOwogCQlod21nci0+cHBfdGFibGVfdmVyc2lvbiA9IFBQX1RBQkxFX1YwOworCQlod21nci0+
b2RfZW5hYmxlZCA9IGZhbHNlOwogCQlzbXU3X2luaXRfZnVuY3Rpb25fcG9pbnRlcnMoaHdtZ3Ip
OwogCQlicmVhazsKIAljYXNlIEFNREdQVV9GQU1JTFlfQ1o6CkBAIC0xODEsNiArMTgyLDcgQEAg
aW50IGh3bWdyX2Vhcmx5X2luaXQoc3RydWN0IHBwX2luc3RhbmNlICpoYW5kbGUpCiAJCQlod21n
ci0+ZmVhdHVyZV9tYXNrICY9IH4gKFBQX1ZCSV9USU1FX1NVUFBPUlRfTUFTSyB8CiAJCQkJCQlQ
UF9FTkFCTEVfR0ZYX0NHX1RIUlVfU01VKTsKIAkJCWh3bWdyLT5wcF90YWJsZV92ZXJzaW9uID0g
UFBfVEFCTEVfVjA7CisJCQlod21nci0+b2RfZW5hYmxlZCA9IGZhbHNlOwogCQkJYnJlYWs7CiAJ
CWNhc2UgQ0hJUF9UT05HQToKIAkJCWh3bWdyLT5zbXVtZ3JfZnVuY3MgPSAmdG9uZ2Ffc211X2Z1
bmNzOwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
