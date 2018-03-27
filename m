From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/8] drm/amdgpu/vce4: add emit_reg_write_reg_wait ring callback
Date: Tue, 27 Mar 2018 17:32:56 -0500
Message-ID: <20180327223258.10638-6-alexander.deucher@amd.com>
References: <20180327223258.10638-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180327223258.10638-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

VGhpcyBhZGRzIHN1cHBvcnQgZm9yIHdyaXRpbmcgYW5kIHJlYWRpbmcgYmFjayB1c2luZyB0aGUK
aGVscGVyIHNpbmNlIHRoZSBlbmdpbmVzIGRvZXNuJ3QgaGF2ZSBhIG9uZXNob3QgcGFja2V0LgoK
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMgfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZjZV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5j
CmluZGV4IDczZmQ0OGQ2Yzc1Ni4uOGZkMWI3NDI5ODVhIDEwMDc1NQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y2VfdjRfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZjZV92NF8wLmMKQEAgLTEwODEsNiArMTA4MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X3JpbmdfZnVuY3MgdmNlX3Y0XzBfcmluZ192bV9mdW5jcyA9IHsKIAkuZW5kX3VzZSA9
IGFtZGdwdV92Y2VfcmluZ19lbmRfdXNlLAogCS5lbWl0X3dyZWcgPSB2Y2VfdjRfMF9lbWl0X3dy
ZWcsCiAJLmVtaXRfcmVnX3dhaXQgPSB2Y2VfdjRfMF9lbWl0X3JlZ193YWl0LAorCS5lbWl0X3Jl
Z193cml0ZV9yZWdfd2FpdCA9IGFtZGdwdV9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0X2hl
bHBlciwKIH07CiAKIHN0YXRpYyB2b2lkIHZjZV92NF8wX3NldF9yaW5nX2Z1bmNzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQotLSAKMi4xMy42CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
