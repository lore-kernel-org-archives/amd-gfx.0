From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: remove some unneeded code
Date: Mon, 6 Nov 2017 12:59:29 +0100
Message-ID: <f1752f40-42fc-7c3e-38ae-50e1d3b1617b@gmail.com>
References: <20171106114422.sd5zoah6k6eaww4e@mwanda>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171106114422.sd5zoah6k6eaww4e@mwanda>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>

QW0gMDYuMTEuMjAxNyB1bSAxMjo0NCBzY2hyaWViIERhbiBDYXJwZW50ZXI6Cj4gV2UgYXNzaWdu
ICJ2X2luaXQgPSBhc2ljX2JsYW5rX3N0YXJ0OyIgYSBmZXcgbGluZXMgZWFybGllciBzbyB0aGVy
ZSBpcwo+IG5vIG5lZWQgdG8gZG8gaXQgYWdhaW4gaW5zaWRlIHRoZSBpZiBzdGF0ZW1lbnRzLiAg
QWxzbyAidl9pbml0IiBpcwo+IHVuc2lnbmVkIHNvIGl0IGNhbid0IGJlIGxlc3MgdGhhbiB6ZXJv
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUu
Y29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEw
L2RjbjEwX3RpbWluZ19nZW5lcmF0b3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24xMC9kY24xMF90aW1pbmdfZ2VuZXJhdG9yLmMKPiBpbmRleCAxOTk0ODY1ZDQzNTEuLmM3
MzMzY2RmMTgwMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMTAvZGNuMTBfdGltaW5nX2dlbmVyYXRvci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3RpbWluZ19nZW5lcmF0b3IuYwo+IEBAIC0yMzYsMTMg
KzIzNiwxMCBAQCBzdGF0aWMgdm9pZCB0Z24xMF9wcm9ncmFtX3RpbWluZygKPiAgIAlpZiAodGct
PmRsZ19vdGdfcGFyYW0uc2lnbmFsID09IFNJR05BTF9UWVBFX0RJU1BMQVlfUE9SVCB8fAo+ICAg
CQl0Zy0+ZGxnX290Z19wYXJhbS5zaWduYWwgPT0gU0lHTkFMX1RZUEVfRElTUExBWV9QT1JUX01T
VCB8fAo+ICAgCQl0Zy0+ZGxnX290Z19wYXJhbS5zaWduYWwgPT0gU0lHTkFMX1RZUEVfRURQKSB7
Cj4gLQkJdl9pbml0ID0gYXNpY19ibGFua19zdGFydDsKPiAgIAkJc3RhcnRfcG9pbnQgPSAxOwo+
ICAgCQlpZiAocGF0Y2hlZF9jcnRjX3RpbWluZy5mbGFncy5JTlRFUkxBQ0UgPT0gMSkKPiAgIAkJ
CWZpZWxkX251bSA9IDE7Cj4gICAJfQo+IC0JaWYgKHZfaW5pdCA8IDApCj4gLQkJdl9pbml0ID0g
MDsKPiAgIAl2X2ZwMiA9IDA7Cj4gICAJaWYgKHRnLT5kbGdfb3RnX3BhcmFtLnZzdGFydHVwX3N0
YXJ0ID4gYXNpY19ibGFua19lbmQpCj4gICAJCXZfZnAyID0gdGctPmRsZ19vdGdfcGFyYW0udnN0
YXJ0dXBfc3RhcnQgPiBhc2ljX2JsYW5rX2VuZDsKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
