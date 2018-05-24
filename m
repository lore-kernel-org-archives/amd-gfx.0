From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/17] drm/amdgpu: add vcn jpeg ring
Date: Thu, 24 May 2018 16:15:14 -0400
Message-ID: <1527192929-2480-2-git-send-email-boyuan.zhang@amd.com>
References: <1527192929-2480-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527192929-2480-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, peter.fang-5C7GfCeVMHo@public.gmane.org

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCBqcGVnIHRvIGFt
ZGdwdV92Y24KClNpZ25lZC1vZmYtYnk6IEJveXVhbiBaaGFuZyA8Ym95dWFuLnpoYW5nQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHwgMiArKwog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uaAppbmRleCAyZmQ3ZGI4Li42NDhmNjYyIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCkBAIC01NSw5ICs1NSwxMSBAQCBzdHJ1Y3QgYW1kZ3B1X3Zj
biB7CiAJY29uc3Qgc3RydWN0IGZpcm13YXJlCSpmdzsJLyogVkNOIGZpcm13YXJlICovCiAJc3Ry
dWN0IGFtZGdwdV9yaW5nCXJpbmdfZGVjOwogCXN0cnVjdCBhbWRncHVfcmluZwlyaW5nX2VuY1tB
TURHUFVfVkNOX01BWF9FTkNfUklOR1NdOworCXN0cnVjdCBhbWRncHVfcmluZwlyaW5nX2pwZWc7
CiAJc3RydWN0IGFtZGdwdV9pcnFfc3JjCWlycTsKIAlzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSBl
bnRpdHlfZGVjOwogCXN0cnVjdCBkcm1fc2NoZWRfZW50aXR5IGVudGl0eV9lbmM7CisJc3RydWN0
IGRybV9zY2hlZF9lbnRpdHkgZW50aXR5X2pwZWc7CiAJdW5zaWduZWQJCW51bV9lbmNfcmluZ3M7
CiB9OwogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
