From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH v2] drm: prefix header search
 paths with $(srctree)/
Date: Fri, 26 Apr 2019 12:18:40 +1000
Message-ID: <CAPM=9txpmjQqh0eLA1sMjcDatQG83vk=juLehiUDi=sBO+c9Tg@mail.gmail.com>
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, intel-gvt-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, nouveau <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "James (Qian) Wang" <james.qian.wang-5wv7dgnIgG8@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCAyNiBBcHIgMjAxOSBhdCAxMTo0NiwgTWFzYWhpcm8gWWFtYWRhCjx5YW1hZGEubWFz
YWhpcm9Ac29jaW9uZXh0LmNvbT4gd3JvdGU6Cj4KPiBIaS4KPgo+Cj4gT24gRnJpLCBNYXIgMjks
IDIwMTkgYXQgODozNyBQTSBNYXNhaGlybyBZYW1hZGEKPiA8eWFtYWRhLm1hc2FoaXJvQHNvY2lv
bmV4dC5jb20+IHdyb3RlOgo+ID4KPiA+IEN1cnJlbnRseSwgdGhlIEtidWlsZCBjb3JlIG1hbmlw
dWxhdGVzIGhlYWRlciBzZWFyY2ggcGF0aHMgaW4gYSBjcmF6eQo+ID4gd2F5IFsxXS4KPiA+Cj4g
PiBUbyBmaXggdGhpcyBtZXNzLCBJIHdhbnQgYWxsIE1ha2VmaWxlcyB0byBhZGQgZXhwbGljaXQg
JChzcmN0cmVlKS8gdG8KPiA+IHRoZSBzZWFyY2ggcGF0aHMgaW4gdGhlIHNyY3RyZWUuIFNvbWUg
TWFrZWZpbGVzIGFyZSBhbHJlYWR5IHdyaXR0ZW4gaW4KPiA+IHRoYXQgd2F5LCBidXQgbm90IGFs
bC4gVGhlIGdvYWwgb2YgdGhpcyB3b3JrIGlzIHRvIG1ha2UgdGhlIG5vdGF0aW9uCj4gPiBjb25z
aXN0ZW50LCBhbmQgZmluYWxseSBnZXQgcmlkIG9mIHRoZSBncm9zcyBoYWNrcy4KPiA+Cj4gPiBI
YXZpbmcgd2hpdGVzcGFjZXMgYWZ0ZXIgLUkgZG9lcyBub3QgbWF0dGVyIHNpbmNlIGNvbW1pdCA0
OGY2ZTNjZjViYzYKPiA+ICgia2J1aWxkOiBkbyBub3QgZHJvcCAtSSB3aXRob3V0IHBhcmFtZXRl
ciIpLgo+ID4KPiA+IFsxXTogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85NjMy
MzQ3Lwo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1hc2Fo
aXJvQHNvY2lvbmV4dC5jb20+Cj4gPiBSZXZpZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2
bmJvcmcub3JnPgo+ID4gLS0tCj4gPgo+ID4gSSBwdXQgYWxsIGdwdS9kcm0gY2hhbmdlcyBpbnRv
IGEgc2luZ2xlIHBhdGNoIGJlY2F1c2UKPiA+IHRoZXkgYXJlIHRyaXZpYWwgY29udmVyc2lvbi4K
PiA+Cj4gPiBJZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4gdGhlIGJpZyBwaWN0dXJlIG9mIHRoaXMg
d29yaywKPiA+IHRoZSBmdWxsIHBhdGNoIHNldCBpcyBhdmFpbGFibGUgYXQgdGhlIGZvbGxvd2lu
ZyBVUkwuCj4gPgo+ID4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L21hc2FoaXJveS9saW51eC1rYnVpbGQuZ2l0IGJ1aWxkLXRlc3QKPgo+Cj4gSXMgc29tZWJv
ZHkgdGFraW5nIGNhcmUgb2YgdGhpcz8KPgoKQXJlIHlvdSBleHBlY3RpbmcgdGhpcyB0byBiZSBt
ZXJnZWQgaW4gdGhlIGRybSB0cmVlPyBpZiBzbyBwbGVhc2UKaW5kaWNhdGUgdGhhdCB3aGVuIHBv
c3RpbmcuCgpJJ2QgYXNzdW1lZCB0aGlzIHdvdWxkIGdvIHZpYSBrYnVpbGQgdHJlZS4KCklmIHRo
ZSBsYXRlciwKQWNrZWQtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+CkRhdmUu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyZWVkcmVu
byBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ZyZWVkcmVubw==
