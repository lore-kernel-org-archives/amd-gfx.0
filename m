From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Remove unused variable in
 amdgpu_device_gpu_recover
Date: Wed, 23 May 2018 13:08:19 -0400
Message-ID: <20180523170819.18775-1-harry.wentland@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

SXQgdGhyb3dzIGFuIHVudXNlZCB2YXJpYWJsZSB3YXJuaW5nLgoKU2lnbmVkLW9mZi1ieTogSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRl
eCBjMTY1NGE0ZGZkODIuLjU3YTRmMzkzYWRhMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzE3OSw3ICszMTc5LDYgQEAgc3RhdGljIGludCBhbWRn
cHVfZGV2aWNlX3Jlc2V0X3NyaW92KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogaW50IGFt
ZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iLCBib29sIGZvcmNlKQogewotCXN0cnVjdCBkcm1f
YXRvbWljX3N0YXRlICpzdGF0ZSA9IE5VTEw7CiAJaW50IGksIHIsIHJlc2NoZWQ7CiAKIAlpZiAo
IWZvcmNlICYmICFhbWRncHVfZGV2aWNlX2lwX2NoZWNrX3NvZnRfcmVzZXQoYWRldikpIHsKLS0g
CjIuMTcuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
