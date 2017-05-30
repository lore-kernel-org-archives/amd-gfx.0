From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: Remove two ! operations in an if condition
Date: Tue, 30 May 2017 17:47:47 -0400
Message-ID: <1496180868-2617-2-git-send-email-AlexBin.Xie@amd.com>
References: <1496180868-2617-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496180868-2617-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

IE1ha2UgdGhlIGNvZGUgZWFzaWVyIHRvIHVuZGVyc3RhbmQuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5k
ZXggN2EzMjNmOS4uOWZkZWI4MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKQEAgLTY4MCw5ICs2ODAsMTEgQEAgYm9vbCBhbWRncHVfdm1fbmVlZF9waXBlbGluZV9zeW5j
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKIAogCWlmIChhbWRncHVfdm1faGFkX2dwdV9yZXNl
dChhZGV2LCBpZCkpCiAJCXJldHVybiB0cnVlOwotCWlmICghdm1fZmx1c2hfbmVlZGVkICYmICFn
ZHNfc3dpdGNoX25lZWRlZCkKKworCWlmICh2bV9mbHVzaF9uZWVkZWQgfHwgZ2RzX3N3aXRjaF9u
ZWVkZWQpCisJCXJldHVybiB0cnVlOworCWVsc2UKIAkJcmV0dXJuIGZhbHNlOwotCXJldHVybiB0
cnVlOwogfQogCiAvKioKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
