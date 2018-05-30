From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/18] drm/amdgpu: add vcn jpeg ring
Date: Wed, 30 May 2018 16:27:17 -0400
Message-ID: <1527712053-15027-2-git-send-email-boyuan.zhang@amd.com>
References: <1527712053-15027-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527712053-15027-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCBqcGVnIHRvIGFt
ZGdwdV92Y24KCnYyOiByZW1vdmUgdW5uZWNlc3Nhcnkgc2NoZWR1bGVyIGVudGl0eQoKU2lnbmVk
LW9mZi1ieTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAppbmRl
eCA3NzMwMTBiLi42ZjNiZWQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5oCkBAIC02Niw2ICs2Niw3IEBAIHN0cnVjdCBhbWRncHVfdmNuIHsKIAljb25zdCBzdHJ1Y3Qg
ZmlybXdhcmUJKmZ3OwkvKiBWQ04gZmlybXdhcmUgKi8KIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcJcmlu
Z19kZWM7CiAJc3RydWN0IGFtZGdwdV9yaW5nCXJpbmdfZW5jW0FNREdQVV9WQ05fTUFYX0VOQ19S
SU5HU107CisJc3RydWN0IGFtZGdwdV9yaW5nCXJpbmdfanBlZzsKIAlzdHJ1Y3QgYW1kZ3B1X2ly
cV9zcmMJaXJxOwogCXVuc2lnbmVkCQludW1fZW5jX3JpbmdzOwogfTsKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
