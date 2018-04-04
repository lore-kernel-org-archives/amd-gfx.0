From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 5/7] drm/amdgpu/vce4: add emit_reg_write_reg_wait ring
 callback
Date: Wed, 4 Apr 2018 12:44:04 +0800
Message-ID: <1522817046-19436-5-git-send-email-Emily.Deng@amd.com>
References: <1522817046-19436-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1522817046-19436-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKVGhpcyBhZGRz
IHN1cHBvcnQgZm9yIHdyaXRpbmcgYW5kIHJlYWRpbmcgYmFjayB1c2luZyB0aGUKaGVscGVyIHNp
bmNlIHRoZSBlbmdpbmVzIGRvZXNuJ3QgaGF2ZSBhIG9uZXNob3QgcGFja2V0LgoKUmV2aWV3ZWQt
Ynk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y2VfdjRfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3Y0XzAuYwppbmRleCA3M2ZkNDhkLi44ZmQxYjc0
IDEwMDc1NQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMKQEAgLTEwODEsNiArMTA4MSw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgdmNlX3Y0XzBfcmluZ192
bV9mdW5jcyA9IHsKIAkuZW5kX3VzZSA9IGFtZGdwdV92Y2VfcmluZ19lbmRfdXNlLAogCS5lbWl0
X3dyZWcgPSB2Y2VfdjRfMF9lbWl0X3dyZWcsCiAJLmVtaXRfcmVnX3dhaXQgPSB2Y2VfdjRfMF9l
bWl0X3JlZ193YWl0LAorCS5lbWl0X3JlZ193cml0ZV9yZWdfd2FpdCA9IGFtZGdwdV9yaW5nX2Vt
aXRfcmVnX3dyaXRlX3JlZ193YWl0X2hlbHBlciwKIH07CiAKIHN0YXRpYyB2b2lkIHZjZV92NF8w
X3NldF9yaW5nX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
