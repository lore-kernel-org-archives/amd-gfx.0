From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/22] Associate ddc adapters with connectors
Date: Tue, 2 Jul 2019 16:08:30 +0100
Message-ID: <CACvgo502Yt90z9Tf+a8f_n3pgFa_NxFQ1LnEGmukT_jB2XaFzA__4037.95814361132$1562080110$gmane$org@mail.gmail.com>
References: <3fb19371-db7d-f9dc-31a7-1ccd126f6784@collabora.com>
 <cover.1561735433.git.andrzej.p@collabora.com>
 <20190628164514.GS12905@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190628164514.GS12905-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
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
To: Andrzej Pietrasiewicz <andrzej.p-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.h>
Cc: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>

T24gRnJpLCAyOCBKdW4gMjAxOSBhdCAxNzo0NSwgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPiB3cm90ZToKPgo+IE9uIEZyaSwgSnVuIDI4LCAyMDE5IGF0IDA2OjAxOjE0UE0gKzAyMDAs
IEFuZHJ6ZWogUGlldHJhc2lld2ljeiB3cm90ZToKPiA+IEl0IGlzIGRpZmZpY3VsdCBmb3IgYSB1
c2VyIHRvIGtub3cgd2hpY2ggb2YgdGhlIGkyYyBhZGFwdGVycyBpcyBmb3Igd2hpY2gKPiA+IGRy
bSBjb25uZWN0b3IuIFRoaXMgc2VyaWVzIGFkZHJlc3NlcyB0aGlzIHByb2JsZW0uCj4gPgo+ID4g
VGhlIGlkZWEgaXMgdG8gaGF2ZSBhIHN5bWJvbGljIGxpbmsgaW4gY29ubmVjdG9yJ3Mgc3lzZnMg
ZGlyZWN0b3J5LCBlLmcuOgo+ID4KPiA+IGxzIC1sIC9zeXMvY2xhc3MvZHJtL2NhcmQwLUhETUkt
QS0xL2RkYwo+ID4gbHJ3eHJ3eHJ3eCAxIHJvb3Qgcm9vdCAwIEp1biAyNCAxMDo0MiAvc3lzL2Ns
YXNzL2RybS9jYXJkMC1IRE1JLUEtMS9kZGMgXAo+ID4gICAgICAgLT4gLi4vLi4vLi4vLi4vc29j
LzEzODgwMDAwLmkyYy9pMmMtMgo+ID4KPiA+IFRoZSB1c2VyIHRoZW4ga25vd3MgdGhhdCB0aGVp
ciBjYXJkMC1IRE1JLUEtMSB1c2VzIGkyYy0yIGFuZCBjYW4gZS5nLiBydW4KPiA+IGRkY3V0aWw6
Cj4gPgo+ID4gZGRjdXRpbCAtYiAyIGdldHZjcCAweDEwCj4gPiBWQ1AgY29kZSAweDEwIChCcmln
aHRuZXNzICAgICAgICAgICAgICAgICAgICApOiBjdXJyZW50IHZhbHVlID0gICAgOTAsIG1heCB2
YWx1ZSA9ICAgMTAwCj4gPgo+ID4gVGhlIGZpcnN0IHBhdGNoIGluIHRoZSBzZXJpZXMgYWRkcyBz
dHJ1Y3QgaTJjX2FkYXB0ZXIgcG9pbnRlciB0byBzdHJ1Y3QKPiA+IGRybV9jb25uZWN0b3IuIElm
IHRoZSBmaWVsZCBpcyB1c2VkIGJ5IGEgcGFydGljdWxhciBkcml2ZXIsIHRoZW4gYW4KPiA+IGFw
cHJvcHJpYXRlIHN5bWJvbGljIGxpbmsgaXMgY3JlYXRlZCBieSB0aGUgZ2VuZXJpYyBjb2RlLCB3
aGljaCBpcyBhbHNvIGFkZGVkCj4gPiBieSB0aGlzIHBhdGNoLgo+ID4KPiA+IFRoZSBzZWNvbmQg
cGF0Y2ggaXMgYW4gZXhhbXBsZSBvZiBob3cgdG8gY29udmVydCBhIGRyaXZlciB0byB0aGlzIG5l
dyBzY2hlbWUuCj4gPgo+ID4gdjEuLnYyOgo+ID4KPiA+IC0gdXNlZCBmaXhlZCBuYW1lICJkZGMi
IGZvciB0aGUgc3ltYm9saWMgbGluayBpbiBvcmRlciB0byBtYWtlIGl0IGVhc3kgZm9yCj4gPiB1
c2Vyc3BhY2UgdG8gZmluZCB0aGUgaTJjIGFkYXB0ZXIKPiA+Cj4gPiB2Mi4udjM6Cj4gPgo+ID4g
LSBjb252ZXJ0ZWQgYXMgbWFueSBkcml2ZXJzIGFzIHBvc3NpYmxlLgo+ID4KPiA+IFBBVENIRVMg
My8yMi0yMi8yMiBTSE9VTEQgQkUgQ09OU0lERVJFRCBSRkMhCj4KPiBUaGVyZSdzIGEgbG90IG1v
cmUgZHJpdmVycyB0aGFuIHRoaXMgSSB0aGluayAoaTkxNSBpcyBhYnNlbnQgYXMgYW4KPiBleGFt
cGxlLCBidXQgdGhlcmUgc2hvdWxkIGJlIHRvbnMgbW9yZSkuIFdoeSBhcmUgdGhvc2Ugbm90IHBv
c3NpYmxlPwoKV2hpbGUgSSBmdWxseSBhZ3JlZSB0aGVyZSBhcmUgbW9yZSBkcml2ZXJzLCBhdCB0
aGUgc2FtZSB0aW1lIEkgd29uZGVyLgpJcyBpdCBhIGdvb2QgaWRlYSB0byBleHBlY3QgYWxsIG9m
IHRob3NlIHRvIGJlIGZpeGVkIGluIG9uZSBnbyBhbmQKYmxvY2sgcGF0Y2hlcyBhZGRyZXNzaW5n
IDE1KyBkcml2ZXJzPwoKUGVyc29uYWxseSBJIHRoaW5rIGl0J3MgcmVhc29uYWJsZSB0byBoYXZl
IHRoaXMsIGFsb25nc2lkZSBhIFRPRE8KZW50cnkgZm9yIG90aGVyIGRyaXZlcnMuCgpIVEgKRW1p
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
