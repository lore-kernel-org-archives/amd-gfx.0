From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/display: include slab.h in dcn21_resource.c
Date: Mon, 23 Sep 2019 17:54:11 -0400
Message-ID: <CADnq5_NK57bqucbjp9Dn73kKPnhAqEvVHO68vZOvatOZ4pwCyw@mail.gmail.com>
References: <20190923205804.12300-1-alexander.deucher@amd.com>
 <9ad314e5-1a6f-f17f-ac1c-ec33aed2912e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9ad314e5-1a6f-f17f-ac1c-ec33aed2912e-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBTZXAgMjMsIDIwMTkgYXQgNToxNCBQTSBIYXJyeSBXZW50bGFuZCA8aHdlbnRsYW5A
YW1kLmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDE5LTA5LTIzIDQ6NTggcC5tLiwgQWxleCBEZXVjaGVy
IHdyb3RlOgo+ID4gSXQncyBhcHBhcmVudGx5IG5lZWRlZCBpbiBzb21lIGNvbmZpZ3VyYXRpb25z
Lgo+Cj4gQ3VyaW91cyB3aGljaCBjb25maWcgZmFpbHMgYW5kIHdoYXQgY29tcGlsZXIgZXJyb3Jz
IHdlIGdldC4uLiBTb3VuZHMKPiBsaWtlIG91ciBpbmNsdWRlcyBhcmUgbWVzc2VkIHVwIHNvbWV3
aGVyZS4KCk5vdCBzdXJlIGV4YWN0bHk6Cmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzkvMjAv
OTk4CgpBbGV4Cgo+Cj4gSGFycnkKPgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jIHwgMiArKwo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwo+ID4gaW5kZXggM2Nh
NTEzOWYxMjczLi5kZTE4MjE4NWZlMWYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKPiA+IEBAIC0yMyw2
ICsyMyw4IEBACj4gPiAgICoKPiA+ICAgKi8KPiA+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4KPiA+ICsKPiA+ICAjaW5jbHVkZSAiZG1fc2VydmljZXMuaCIKPiA+ICAjaW5jbHVkZSAiZGMu
aCIKPiA+Cj4gPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
