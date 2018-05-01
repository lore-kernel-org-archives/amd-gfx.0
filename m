From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag
 TTM_PAGE_FLAG_TRANSHUGE
Date: Tue, 1 May 2018 15:59:06 +0200
Message-ID: <023175f7-53a0-c85b-f4db-e7d3e3da8691@daenzer.net>
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
 <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
 <d5f9459e-801c-e592-d06d-c9052ef3ad4d@amd.com>
 <e5256136-6da0-cc5e-9490-5a70c89dfd83@daenzer.net>
 <361a765a-f491-4450-867e-fa88857827ee@gmail.com>
 <CAPM=9tzmmT5G5a_2WCH5xpRr6rhY6sHdi-Kg5my0az_=haVZTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tzmmT5G5a_2WCH5xpRr6rhY6sHdi-Kg5my0az_=haVZTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjAxOC0wNS0wMSAwMToxNSBBTSwgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4+Cj4+Cj4+IFllcywg
SSBmaXhlZCB0aGUgb3JpZ2luYWwgZmFsc2UgcG9zaXRpdmUgbWVzc2FnZXMgbXlzZWxmIHdpdGgg
dGhlIHN3aW90bGIKPj4gbWFpbnRhaW5lciBhbmQgSSB3YXMgQ0NlZCBpbiBmaXhpbmcgdGhlIHJl
Y2VudCBmYWxsb3V0IGZyb20gQ2hyaXMgY2hhbmdlcyBhcwo+PiB3ZWxsLgo+IAo+IFNvIGRvIHdl
IGhhdmUgYSBnb29kIHN1bW1hcnkgb2Ygd2hlcmUgdGhpcyBhdCBub3c/Cj4gCj4gSSdtIGdldHRp
bmcgcmVwb3J0cyBvbiA0LjE2LjQgc3RpbGwgZGlzcGxheWluZyB0aGVzZSwgd2hhdCBoYW1tZXIg
ZG8gSQo+IG5lZWQgdG8gaGl0IHRoaW5ncyB3aXRoIHRvIGdldCA0LjE2LngrMSB0byBub3QgZG8g
dGhpcz8KPiAKPiBJcyB0aGVyZSBzdGlsbCBvdXRzdGFuZGluZyBpc3N1ZXMgdXBzdHJlYW0uCgpU
aGVyZSBhcmUsIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC8yMTk3NjUv
IHNob3VsZApob3BlZnVsbHkgZml4IHRoZSBsYXN0IG9mIGl0LgoKCj4gWy4uLl0gSSd2ZSBubyBp
ZGVhIGlmIHRoZSBzd2lvdGxiIHRoaW5ncyBwZW9wbGUgcmVwb3J0IGFyZSB0aGUgZmFsc2UKPiBw
b3NpdGl2ZSwgb3Igc29tZSBuZXcgdGhpbmcuCgpUaGUgaXNzdWVzIEkndmUgc2VlbiByZXBvcnRl
ZCB3aXRoIDQuMTYgYXJlIGZhbHNlIHBvc2l0aXZlcyBmcm9tIFRUTSdzCnBlcnNwZWN0aXZlLCB3
aGljaCB1c2VzIERNQV9BVFRSX05PX1dBUk4gdG8gc3VwcHJlc3MgdGhlc2Ugd2FybmluZ3MsIGR1
ZQp0byBtdWx0aXBsZSByZWdyZXNzaW9ucyBpbnRyb2R1Y2VkIGJ5IGNvbW1pdAowMTc2YWRiMDA0
MDY1ZDY4MTVhOGU2Nzk0Njc1MmRmNGNkOTQ3YzViICJzd2lvdGxiOiByZWZhY3RvcgogY29oZXJl
bnQgYnVmZmVyIGFsbG9jYXRpb24iIGluIDQuMTYtcmMxLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
