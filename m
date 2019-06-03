From: Helen Koike <helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v4 0/5] drm: Fix fb changes for async updates
Date: Mon,  3 Jun 2019 13:56:05 -0300
Message-ID: <20190603165610.24614-1-helen.koike@collabora.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org
Cc: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Sean Paul <seanpaul-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, daniel.vetter-/w4YWyX8dFk@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, Mamta Shukla <mamtashukla555-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Helen Koike <helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Maxime Ripard <maxime.ripard@bootlin.>

SGVsbG8sCgpJJ20gcmUtc2VuZGluZyB0aGlzIHNlcmllcyB3aXRoIHRoZSBhY2tlZCBieSBpbiB0
aGUgbXNtIHBhdGNoIGFuZAp1cGRhdGluZyB0aGUgZG9jcyBpbiB0aGUgbGFzdCBwYXRjaCwgdGhl
IHJlc3QgaXMgdGhlIHNhbWUuCgp2MyBsaW5rOiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvZHJpLWRldmVsL2xpc3QvP3Nlcmllcz05MTM1MwoKVGhhbmtzIQpIZWxlbgoKQ2hh
bmdlcyBpbiB2NDoKLSBhZGQgYWNrZWQgYnkgdGFnCi0gdXBkYXRlIGRvY3MgaW4gYXRvbWljX2Fz
eW5jX3VwZGF0ZSBjYWxsYmFjawoKQ2hhbmdlcyBpbiB2MzoKLSB1c2Ugc3dhcCgpIHRvIHN3YXAg
b2xkIGFuZCBuZXcgZnJhbWVidWZmZXJzIGluIGFzeW5jX3VwZGF0ZQotIGdldCB0aGUgcmVmZXJl
bmNlIHRvIG9sZF9mYiBhbmQgc2V0IHRoZSB3b3JrZXIgYWZ0ZXIgdm9wX3BsYW5lX2F0b21pY191
cGRhdGUoKQotIGFkZCBhIEZJWE1FIHRhZyBmb3Igd2hlbiB3ZSBoYXZlIG11bHRpcGxlIGZicyB0
byBiZSByZWxlYXNlZCB3aGVuCnZibGFuayBoYXBwZW5zLgotIHVwZGF0ZSBjb21taXQgbWVzc2Fn
ZQotIEFkZCBSZXZpZXdlZC1ieSB0YWdzCi0gQWRkIFRPRE8gaW4gZHJtX2F0b21pY19oZWxwZXJf
YXN5bmNfY29tbWl0KCkKCkNoYW5nZXMgaW4gdjI6Ci0gYWRkZWQgcmV2aWV3ZWQtYnkgdGFnCi0g
dXBkYXRlIENDIHN0YWJsZSBhbmQgRml4ZXMgdGFnCi0gQWRkZWQgcmV2aWV3ZWQtYnkgdGFnCi0g
dXBkYXRlZCBDQyBzdGFibGUgYW5kIEZpeGVzIHRhZwotIENoYW5nZSB0aGUgb3JkZXIgb2YgdGhl
IHBhdGNoIGluIHRoZSBzZXJpZXMsIGFkZCB0aGlzIGFzIHRoZSBsYXN0IG9uZS4KLSBBZGQgZG9j
dW1lbnRhdGlvbgotIHMvYmFsbGFuY2VkL2JhbGFuY2VkCgpIZWxlbiBLb2lrZSAoNSk6CiAgZHJt
L3JvY2tjaGlwOiBmaXggZmIgcmVmZXJlbmNlcyBpbiBhc3luYyB1cGRhdGUKICBkcm0vYW1kOiBm
aXggZmIgcmVmZXJlbmNlcyBpbiBhc3luYyB1cGRhdGUKICBkcm0vbXNtOiBmaXggZmIgcmVmZXJl
bmNlcyBpbiBhc3luYyB1cGRhdGUKICBkcm0vdmM0OiBmaXggZmIgcmVmZXJlbmNlcyBpbiBhc3lu
YyB1cGRhdGUKICBkcm06IGRvbid0IGJsb2NrIGZiIGNoYW5nZXMgZm9yIGFzeW5jIHBsYW5lIHVw
ZGF0ZXMKCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAg
MyArLQogZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMgICAgICAgICAgIHwgMjIg
KysrKy0tLS0KIGRyaXZlcnMvZ3B1L2RybS9tc20vZGlzcC9tZHA1L21kcDVfcGxhbmUuYyAgICB8
ICA0ICsrCiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcC5jICAgfCA1
MSArKysrKysrKysrLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vdmM0L3ZjNF9wbGFuZS5jICAg
ICAgICAgICAgICAgfCAgMiArLQogaW5jbHVkZS9kcm0vZHJtX21vZGVzZXRfaGVscGVyX3Z0YWJs
ZXMuaCAgICAgIHwgIDggKysrCiA2IGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDM4
IGRlbGV0aW9ucygtKQoKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
