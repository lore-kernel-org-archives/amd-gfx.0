From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 26/26] drm/amd/powerplay: use REG32_PCIE wrapper instead for
 sw smu
Date: Mon, 25 Feb 2019 20:12:32 +0800
Message-ID: <1551096752-18205-27-git-send-email-ray.huang@amd.com>
References: <1551096752-18205-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1551096752-18205-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCB1c2VzIFJFRzMyX1BDSUUgd3JhcHBlciBpbnN0ZWFkIG9mIHdyaXR0aW5nIHBj
aV9pbmRleDIgYW5kIHJlYWRpbmcKcGNpX2RhdGEyLiBUaGlzIHNlcXVlbmNlIHNob3VsZCBiZSBw
cm90ZWN0ZWQgYnkgcGNpZV9pZHhfbG9jay4KClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5
Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMg
fCA3ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwppbmRleCAzZDI5
YWZkLi5lZjI1ODg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9z
bXVfdjExXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
YwpAQCAtMjAxLDE0ICsyMDEsMTMgQEAgc3RhdGljIGludCBzbXVfdjExXzBfY2hlY2tfZndfc3Rh
dHVzKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gc211LT5hZGV2OwogCXVpbnQzMl90IG1wMV9md19mbGFnczsKIAotCVdSRUczMl9TT0MxNShO
QklGLCAwLCBtbVBDSUVfSU5ERVgyLAotCQkgICAgIChNUDFfUHVibGljIHwgKHNtbk1QMV9GSVJN
V0FSRV9GTEFHUyAmIDB4ZmZmZmZmZmYpKSk7Ci0KLQltcDFfZndfZmxhZ3MgPSBSUkVHMzJfU09D
MTUoTkJJRiwgMCwgbW1QQ0lFX0RBVEEyKTsKKwltcDFfZndfZmxhZ3MgPSBSUkVHMzJfUENJRShN
UDFfUHVibGljIHwKKwkJCQkgICAoc21uTVAxX0ZJUk1XQVJFX0ZMQUdTICYgMHhmZmZmZmZmZikp
OwogCiAJaWYgKChtcDFfZndfZmxhZ3MgJiBNUDFfRklSTVdBUkVfRkxBR1NfX0lOVEVSUlVQVFNf
RU5BQkxFRF9NQVNLKSA+PgogCSAgICBNUDFfRklSTVdBUkVfRkxBR1NfX0lOVEVSUlVQVFNfRU5B
QkxFRF9fU0hJRlQpCiAJCXJldHVybiAwOworCiAJcmV0dXJuIC1FSU87CiB9CiAKLS0gCjIuNy40
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
