From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/6] drm: fourcc byteorder: add DRM_FORMAT_CPU_*
Date: Mon, 24 Apr 2017 08:25:28 +0200
Message-ID: <20170424062532.26722-3-kraxel@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170424062532.26722-1-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

QWRkIGZvdXJjYyB2YXJpYW50cyBpbiBjcHUgYnl0ZSBvcmRlci4gIFdpdGggdGhlc2UgYXQgaGFu
ZCB3ZSBkb24ndApuZWVkICNpZmRlZnMgaW4gZHJpdmVycyB3YW50IHN1cHBvcnQgZnJhbWVidWZm
ZXJzIGluIGNwdSBlbmRpYW5lc3MuCgpTaWduZWQtb2ZmLWJ5OiBHZXJkIEhvZmZtYW5uIDxrcmF4
ZWxAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL2RybS9kcm1fZm91cmNjLmggfCAxMiArKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9kcm0vZHJtX2ZvdXJjYy5oIGIvaW5jbHVkZS9kcm0vZHJtX2ZvdXJjYy5oCmluZGV4IDY5
NDJlODRiNmUuLmNhZTA1MTUzZTggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9mb3VyY2Mu
aAorKysgYi9pbmNsdWRlL2RybS9kcm1fZm91cmNjLmgKQEAgLTI1LDYgKzI1LDE4IEBACiAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4KICNpbmNsdWRlIDx1YXBpL2RybS9kcm1fZm91cmNjLmg+CiAK
Ky8qCisgKiBEUk0gZm9ybWF0cyBhcmUgbGl0dGxlIGVuZGlhbi4gIGRlZmluZSBjcHUgZW5kaWFu
IHZhcmlhbnRzIGhlcmUsIHRvCisgKiByZWR1Y2UgdGhlICNpZmRlZnMgbmVlZGVkIGluIGRyaXZl
cnMuCisgKi8KKyNpZmRlZiBfX0JJR19FTkRJQU4KKyMgZGVmaW5lIERSTV9GT1JNQVRfQ1BVX1hS
R0I4ODg4IERSTV9GT1JNQVRfQkdSWDg4ODgKKyMgZGVmaW5lIERSTV9GT1JNQVRfQ1BVX0FSR0I4
ODg4IERSTV9GT1JNQVRfQkdSQTg4ODgKKyNlbHNlCisjIGRlZmluZSBEUk1fRk9STUFUX0NQVV9Y
UkdCODg4OCBEUk1fRk9STUFUX1hSR0I4ODg4CisjIGRlZmluZSBEUk1fRk9STUFUX0NQVV9BUkdC
ODg4OCBEUk1fRk9STUFUX0FSR0I4ODg4CisjZW5kaWYKKwogc3RydWN0IGRybV9kZXZpY2U7CiBz
dHJ1Y3QgZHJtX21vZGVfZmJfY21kMjsKIAotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
