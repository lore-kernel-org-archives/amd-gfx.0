From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/3] drm: tackle byteorder issues, take three ...
Date: Tue,  2 May 2017 15:34:01 +0200
Message-ID: <20170502133404.15354-1-kraxel@redhat.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

ICBIaSwKCk9rLCBuZXh0IHJvdW5kLiAgUGF0Y2hlcyAxKzIgYXJlIHVubW9kaWZpZWQsIGRyaXZl
ciB1cGRhdGVzIGFyZSBsZWZ0IG91dApmb3Igbm93LgoKUGF0Y2ggIzMgYWRkcyBhIG5ldyBkcm1f
bW9kZV9sZWdhY3lfZmJfZm9ybWF0X2hlKCkgZnVuY3Rpb24gaW5zdGVhZCBvZgpjaGFuZ2luZyBk
cm1fbW9kZV9sZWdhY3lfZmJfZm9ybWF0IGJlaGF2aW9yLCBzbyB3ZSBrZWVwIHRoaW5ncyB3b3Jr
aW5nCmZvciBub3cuCgpDb21tZW50cz8KClN1Z2dlc3Rpb25zIGhvdyB0byBoYW5kbGUgdGhlIGRy
bV9tb2RlX2xlZ2FjeV9mYl9mb3JtYXQoKSBjYWxsIGluCmRybV9tb2RlX2FkZGZiKCkgPyAgQWRk
IHNvbWUgZHJpdmVyIGZsYWc/CgpHZXJkIEhvZmZtYW5uICgzKToKICBkcm06IGZvdXJjYyBieXRl
b3JkZXI6IGRyb3AgRFJNX0ZPUk1BVF9CSUdfRU5ESUFOCiAgZHJtOiBmb3VyY2MgYnl0ZW9yZGVy
OiBhZGQgRFJNX0ZPUk1BVF9DUFVfKgogIGRybTogZm91cmNjIGJ5dGVvcmRlcjogYWRkIGRybV9t
b2RlX2xlZ2FjeV9mYl9mb3JtYXRfaGUKCiBpbmNsdWRlL2RybS9kcm1fZm91cmNjLmggICAgICAg
ICAgfCAxNSArKysrKysrKysrKwogaW5jbHVkZS91YXBpL2RybS9kcm1fZm91cmNjLmggICAgIHwg
IDIgLS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZm91cmNjLmMgICAgICB8IDU3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9mcmFtZWJ1
ZmZlci5jIHwgIDIgKy0KIDQgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkKCi0tIAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
