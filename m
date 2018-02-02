From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: fix incompatible structure layouts
Date: Fri, 2 Feb 2018 11:08:03 -0500
Message-ID: <0e880a52-768e-c476-84a5-3e9638b62f1b@amd.com>
References: <20180202123232.477388-1-arnd@arndb.de>
 <5307dea1-61f6-2c7b-75db-4e1a0885de30@amd.com>
 <CAK8P3a3WN6VdJuEt=0nvC-8FCiOAVo8R=aRso4=C-jwM4rdQPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAK8P3a3WN6VdJuEt=0nvC-8FCiOAVo8R=aRso4=C-jwM4rdQPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wMi0wMiAxMTowMiBBTSwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBGcmksIEZl
YiAyLCAyMDE4IGF0IDQ6MzkgUE0sIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQu
Y29tPiB3cm90ZToKPj4gT24gMjAxOC0wMi0wMiAwNzozMSBBTSwgQXJuZCBCZXJnbWFubiB3cm90
ZToKPj4+IEJ1aWxkaW5nIHRoZSBhbWQgZGlzcGxheSBkcml2ZXIgd2l0aCBsaW5rLXRpbWUgb3B0
aW1pemF0aW9ucyByZXZlYWxlZCBhIGJ1Zwo+Pgo+PiBDdXJpb3VzIGhvdyBJJ2QgZ28gYWJvdXQg
YnVpbGRpbmcgd2l0aCBsaW5rLXRpbWUgb3B0aW1pemF0aW9ucy4KPiAKPiBJIGdvdCB0aGUgaWRl
YSBmcm9tIGxhc3Qgd2VlaydzIExXTiBhcnRpY2xlIG9uIHRoZSB0b3BpYywgc2VlCj4gaHR0cHM6
Ly9sd24ubmV0L0FydGljbGVzLzc0NDUwNy8uIEkgbmVlZGVkIHRoZSBsYXRlc3QgZ2NjIHZlcnNp
b24gdG8KPiBhdm9pZCBzb21lIGNvbXBpbGVyIGJ1Z3MsIGFuZCBhIGZldyBkb3plbiBrZXJuZWwg
cGF0Y2hlcyBvbiB0b3AKPiB0byBnZXQgYSBjbGVhbiBidWlsZCBpbiByYW5kb20gY29uZmlndXJh
dGlvbnMgKHBvc3RlZCB0aGVtIGFsbCB0b2RheSkuCj4gCj4gTW9zdCBub3JtYWwgY29uZmlndXJh
dGlvbnMgcHJvYmFibHkgd29yayBvdXQgb2YgdGhlIGJveCwgYnV0IEkgaGF2ZQo+IG5vdCBhY3R1
YWxseSB0cmllZCBydW5uaW5nIGFueSA7LSkKPiAKClRoYW5rcy4gTGVhcm4gc29tZXRoaW5nIG5l
dyBldmVyeSBkYXkuIEkgbGlrZSB0aGlzIGJpdCBmcm9tIHRoZSBhcnRpY2xlOgoKPiBTbyBpdCBp
cyBiYXNpY2FsbHkganVzdCBsaWtlIGlmIGl0IGNvbmNhdGVuYXRlZCBhbGwgc291cmNlIGZpbGVz
IGludG8gYSBzaW5nbGUgb25lIGFuZCBtYWRlIGV2ZXJ5dGhpbmcgc3RhdGljLgoKUHJvYmFibHkg
bm90IGEgYmFkIGlkZWEgdG8gdGhpbmsgdGhhdCB3YXkgd2hlbiBkb2luZyBrZXJuZWwgZGV2ZWxv
cG1lbnQuIDopCgpIYXJyeQoKPiAgICAgICAgQXJuZAo+IApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
