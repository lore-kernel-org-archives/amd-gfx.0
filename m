From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Wed, 12 Oct 2016 09:40:14 +0900
Message-ID: <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
 <20160922063625.GD22164@dvetter-linux.ger.corp.intel.com>
 <b95726e7-6bf6-a1b8-2a63-0758b1b185e2@vodafone.de>
 <CAKMK7uF13M7d8qRRwKs_8M-QHjnuB7k3jshTUDnccTTQf6unog@mail.gmail.com>
 <ddf99e2a-5f9a-41b9-9fde-af7bfd522572@vodafone.de>
 <CAKMK7uEidoKbTO-m3KSz8UmQhF+uorg2-cWY8UpOXjZ_9MCxLg@mail.gmail.com>
 <d2430ff8-43bd-bff2-9b02-847cabfd56c0@vodafone.de>
 <ed1a57a4-1409-6d07-998a-2b54f466f710@daenzer.net>
 <20160923120954.GH22164@dvetter-linux.ger.corp.intel.com>
 <8c21f70a-7f96-480e-9784-93f2d48f52bb@daenzer.net>
 <20160926080419.GV20761@phenom.ffwll.local>
 <CAHbf0-HZ6EotqwgvkxRTdRF97xB3qBA=DRKAzaAXguV_PR_P8w@mail.gmail.com>
 <d74d34a7-5221-d282-d9d1-b0e1007fc0c7@daenzer.net>
 <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTEvMTAvMTYgMDk6MDQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTEuMTAu
MjAxNiB1bSAwNTo1OCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAwNy8xMC8xNiAwOToz
NCBQTSwgTWlrZSBMb3RoaWFuIHdyb3RlOgo+Pj4gVGhpcyBoYXMgZGlzY3Vzc2lvbiBoYXMgZ29u
ZSBhIGxpdHRsZSBxdWlldAo+Pj4KPj4+IFdhcyB0aGVyZSBhbnkgYWdyZWVtZW50IGFib3V0IHdo
YXQgbmVlZGVkIGRvaW5nIHRvIGdldCB0aGlzIHdvcmtpbmcKPj4+IGZvciBpOTY1L2FtZGdwdT8K
Pj4gQ2hyaXN0aWFuLCBkbyB5b3Ugc2VlIGFueXRoaW5nIHdoaWNoIGNvdWxkIHByZXZlbnQgdGhl
IHNvbHV0aW9uIEkKPj4gb3V0bGluZWQgZnJvbSB3b3JraW5nPwo+IAo+IEkgdGhvdWdodCBhYm91
dCB0aGF0IGFwcHJvYWNoIGFzIHdlbGwsIGJ1dCB1bmZvcnR1bmF0ZWx5IGl0IGFsc28gaGFzIGEK
PiBjb3VwbGUgb2YgZG93bnNpZGVzLiBFc3BlY2lhbGx5IGtlZXBpbmcgdGhlIGV4Y2x1c2l2ZSBm
ZW5jZSBzZXQgd2hpbGUgd2UKPiBhY3R1YWxseSBkb24ndCBuZWVkIGl0IGlzbid0IHJlYWxseSBj
bGVhbiBlaXRoZXIuCgpJIHdhcyB3b25kZXJpbmcgaWYgaXQncyBwb3NzaWJsZSB0byBoYXZlIGEg
c2luZ2xldG9uIHBzZXVkbyBleGNsdXNpdmUKZmVuY2Ugd2hpY2ggaXMgdXNlZCBmb3IgYWxsIEJP
cy4gVGhhdCBtaWdodCBrZWVwIHRoZSBvdmVyaGVhZCBhY2NlcHRhYmx5Cmxvdy4KCgo+IEknbSBj
dXJyZW50bHkgYSBiaXQgYnVzeSB3aXRoIG90aGVyIHRhc2tzIGFuZCBzbyBwdXQgTmF5YW4gb24g
YSByb2FkIHRvCj4gZ2V0IGEgYml0IGludG8gdGhlIGtlcm5lbCBkcml2ZXIgKGhlIGFza2VkIGZv
ciB0aGF0IGFueXdheSkuCj4gCj4gSW1wbGVtZW50aW5nIHRoZSBzaW1wbGUgd29ya2Fyb3VuZCB0
byBzeW5jIHdoZW4gd2UgZXhwb3J0IHRoZSBETUEtYnVmCj4gc2hvdWxkIGJlIHNvbWV0aGluZyBs
aWtlIDIwIGxpbmVzIG9mIGNvZGUgYW5kIGZvcnR1bmF0ZWx5IE5heWFuIGhhcyBhbgo+IEkrQSBz
eXN0ZW0gYW5kIHNvIGNhbiBhY3R1YWxseSB0ZXN0IGl0Lgo+IAo+IElmIGl0IHR1cm5zIG91dCB0
byBiZSBtb3JlIHByb2JsZW1hdGljIG9yIHNvbWVib2R5IHJlYWxseSBzdGFydHMgdG8gbmVlZAo+
IGl0IEknbSBnb2luZyB0byBoYWNrIG9uIHRoYXQgbXlzZWxmIGEgYml0IG1vcmUuCgpJZiB5b3Ug
bWVhbiBvbmx5IHN5bmNpbmcgd2hlbiBhIERNQS1idWYgaXMgZXhwb3J0ZWQsIHRoYXQncyBub3Qg
ZW5vdWdoLAphcyBJIGV4cGxhaW5lZCBiZWZvcmUuIFRoZSBCT3MgYmVpbmcgc2hhcmVkIGFyZSBs
b25nLWxpdmVkLCBhbmQKc3luY2hyb25pemF0aW9uIGJldHdlZW4gR1BVcyBpcyByZXF1aXJlZCBm
b3IgZXZlcnkgY29tbWFuZCBzdHJlYW0Kc3VibWlzc2lvbi4KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
