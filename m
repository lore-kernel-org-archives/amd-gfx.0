From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Mon, 31 Oct 2016 15:44:38 +0900
Message-ID: <c45e2f4c-c075-47b6-7e02-3bd98748c83a@daenzer.net>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
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
 <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
 <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q@mail.gmail.com>
 <720351a2-7597-aee3-58ce-9d65cad5762f@daenzer.net>
 <7eb19a73-a558-d2e6-bd8d-34fe95045dfd@gmail.com>
 <CAHbf0-H0owRAp_VXWd84E03OiPKXSE0jZ1=+OAtvoKuoSyt_=A@mail.gmail.com>
 <CAHbf0-EY2OM_HgxTjmMi4-f5TQ8fkqf5XYBxHZtJVsnSpxPyyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-EY2OM_HgxTjmMi4-f5TQ8fkqf5XYBxHZtJVsnSpxPyyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjkvMTAvMTYgMTA6NTggUE0sIE1pa2UgTG90aGlhbiB3cm90ZToKPiBJIHR1cm5lZCBvbiB2
c3luYyBhbmQgZXZlcnl0aGluZyB3b3JrcyBncmVhdCBpbiB0b21iIHJhaWRlcgo+IAo+IDpECj4g
Cj4gVGhhbmtzIGFnYWluIHRvIGV2ZXJ5b25lIHdobyBtYWRlIHRoaXMgcG9zc2libGUKPiAKPiBP
biBGcmksIDI4IE9jdCAyMDE2IGF0IDE5OjM3IE1pa2UgTG90aGlhbiA8bWlrZUBmaXJlYnVybi5j
by51awo+IDxtYWlsdG86bWlrZUBmaXJlYnVybi5jby51az4+IHdyb3RlOgo+IAo+ICAgICBIaSBN
YXJpbwo+IAo+ICAgICBUaGF0IGZpeGVzIHRoZSB0ZWFyaW5nLCBpdCdzIGJlZW4gcmVwbGFjZWQg
d2l0aCBhIHN0cmFuZ2Ugc3R1dHRlciwKPiAgICAgbGlrZSBpdCdzIG9ubHkgc2hvd2luZyBoYWxm
IHRoZSBudW1iZXIgb2YgZnJhbWVzIGJlaW5nIHJlcG9ydGVkIC0KPiAgICAgaXQncyByZWFsbHkg
bm90aWNlYWJsZSBpbiB0b21iIHJhaWRlcgoKSSB3b25kZXIgaWYgdGhlIHN0dXR0ZXIgbWlnaHQg
YmUgZHVlIHRvIHRoZSBkR1BVIHdyaXRpbmcgYW5vdGhlciBmcmFtZQpiZWZvcmUgdGhlIGlHUFUg
aXMgZG9uZSBwcm9jZXNzaW5nIHRoZSBwcmV2aW91cyBvbmUuIENocmlzdGlhbiwgZG9lcyB0aGUK
YW1kZ3B1IHNjaGVkdWxlciB3YWl0IGZvciBzaGFyZWQgZmVuY2VzIG9mIHNoYXJlZCBCT3MgdG8g
c2lnbmFsIGJlZm9yZQpzdWJtaXR0aW5nIGpvYnMgdXNpbmcgdGhlbSB0byB0aGUgR1BVPwoKCi0t
IApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
aHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAg
fCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
