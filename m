From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix build without CONFIG_HMM_MIRROR
Date: Tue, 9 Jul 2019 09:08:38 -0400
Message-ID: <CADnq5_OTri_FzBHUSzKDPrMMAx2fDj8Mx67qHSofo+Hx7Q+60Q@mail.gmail.com>
References: <20190709091048.35260-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190709091048.35260-1-yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBKdWwgOSwgMjAxOSBhdCA4OjU1IEFNIFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVh
d2VpLmNvbT4gd3JvdGU6Cj4KPiBJZiBDT05GSUdfSE1NX01JUlJPUiBpcyBub3Qgc2V0LCBidWls
ZGluZyBtYXkgZmFpbHM6Cj4KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1Lmg6NzI6MCwKPiAgICAgICAgICAgICAgICAgIGZyb20gZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jOjQwOgo+IGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5oOjY5OjIwOiBlcnJvcjogZmllbGQgbWlycm9yIGhhcyBp
bmNvbXBsZXRlIHR5cGUKPiAgIHN0cnVjdCBobW1fbWlycm9yIG1pcnJvcjsKPgo+IEZpeGVzOiA3
NTkwZjZkMjExZWMgKCJkcm0vYW1kZ3B1OiBQcmVwYXJlIGZvciBobW1fcmFuZ2VfcmVnaXN0ZXIg
QVBJIGNoYW5nZSIpCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3
ZWkuY29tPgoKSSBhbHJlYWR5IGFwcGxpZWQgYSBzaW1pbGFyIHBhdGNoIGZyb20gQXJuZC4KClRo
YW5rcywKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9t
bi5oIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uaAo+IGluZGV4IDI4MWZkOWYuLmIxNGYxNzUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmgKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uaAo+IEBAIC02NSw4ICs2NSwx
MCBAQCBzdHJ1Y3QgYW1kZ3B1X21uIHsKPiAgICAgICAgIHN0cnVjdCByd19zZW1hcGhvcmUgICAg
IGxvY2s7Cj4gICAgICAgICBzdHJ1Y3QgcmJfcm9vdF9jYWNoZWQgICBvYmplY3RzOwo+Cj4gKyNp
ZiBkZWZpbmVkKENPTkZJR19ITU1fTUlSUk9SKQo+ICAgICAgICAgLyogSE1NIG1pcnJvciAqLwo+
ICAgICAgICAgc3RydWN0IGhtbV9taXJyb3IgICAgICAgbWlycm9yOwo+ICsjZW5kaWYKPiAgfTsK
Pgo+ICAjaWYgZGVmaW5lZChDT05GSUdfSE1NX01JUlJPUikKPiAtLQo+IDIuNy40Cj4KPgo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBt
YWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
