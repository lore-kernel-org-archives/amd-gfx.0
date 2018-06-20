From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix a loop timeout in
 wait_for_fbc_state_changed()
Date: Wed, 20 Jun 2018 10:12:05 -0400
Message-ID: <846bb208-d6cf-0941-2140-34141c7b211d@amd.com>
References: <20180620120507.qztby4wtgehc65f2@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180620120507.qztby4wtgehc65f2-vMlZ3nK25oGAIHFoDFOv9A@public.gmane.org>
Content-Language: en-US
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wNi0yMCAwODowNSBBTSwgRGFuIENhcnBlbnRlciB3cm90ZToKPiBXZSBjaGFuZ2Vk
IHRoaXMgbG9vcCBzbyBub3cgaXQgbG9vcHMgMTAwMCB0aW1lcyBpbnN0ZWFkIG9mIDEwLiAgV2Ug
bmVlZAo+IHRvIG1ha2UgdGhlIGNvdW50ZXIgbGFyZ2VyIGJlY2F1c2UgYSB1aW50OF90IGNhbid0
IGdvIHVwIHRvIDEwMDAgYW5kCj4gd2UgbmVlZCB0byB1cGRhdGUgdGhlIHRlc3QgYXQgdGhlIGVu
ZCB0byB0ZXN0IGZvciAxMDAwIGluc3RlYWQgb2YgMTAuCj4gCj4gRml4ZXM6IDJiNjE5OWExZDFi
NyAoImRybS9hbWQvZGlzcGxheTogcmVwbGFjZSBtc2xlZXAgd2l0aCB1ZGVsYXkgaW4gZmJjIHBh
dGgiKQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbT4KClRoYW5rcyBmb3IgdGhlIHBhdGNoLiBBbiBlcXVpdmFsZW50IG9uZSBpcyBhbHJlYWR5
IG9uLXJvdXRlIHRvIGJlIG1lcmdlZDogaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3Jn
L3BhdGNoLzIzMDQxMi8KCkhhcnJ5Cgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMKPiBpbmRleCBlMjk5
NGQzMzcwNDQuLjhlODNlYzY2ZmQyMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMKPiBAQCAtMTQz
LDcgKzE0Myw3IEBAIHN0YXRpYyB2b2lkIHdhaXRfZm9yX2ZiY19zdGF0ZV9jaGFuZ2VkKAo+ICAJ
c3RydWN0IGRjZTExMF9jb21wcmVzc29yICpjcDExMCwKPiAgCWJvb2wgZW5hYmxlZCkKPiAgewo+
IC0JdWludDhfdCBjb3VudGVyID0gMDsKPiArCWludCBjb3VudGVyID0gMDsKPiAgCXVpbnQzMl90
IGFkZHIgPSBtbUZCQ19TVEFUVVM7Cj4gIAl1aW50MzJfdCB2YWx1ZTsKPiAgCj4gQEAgLTE1OCw3
ICsxNTgsNyBAQCBzdGF0aWMgdm9pZCB3YWl0X2Zvcl9mYmNfc3RhdGVfY2hhbmdlZCgKPiAgCQlj
b3VudGVyKys7Cj4gIAl9Cj4gIAo+IC0JaWYgKGNvdW50ZXIgPT0gMTApIHsKPiArCWlmIChjb3Vu
dGVyID09IDEwMDApIHsKPiAgCQlEQ19MT0dfV0FSTklORygiJXM6IHdhaXQgY291bnRlciBleGNl
ZWRlZCwgY2hhbmdlcyB0byBIVyBub3QgYXBwbGllZCIsCj4gIAkJCV9fZnVuY19fKTsKPiAgCX0g
ZWxzZSB7Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
