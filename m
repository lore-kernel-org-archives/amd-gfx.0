From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Mon, 31 Oct 2016 09:00:32 +0100
Message-ID: <c8b4f6fe-4348-f264-3ea2-ab7e105c1d78@vodafone.de>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
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
 <c45e2f4c-c075-47b6-7e02-3bd98748c83a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c45e2f4c-c075-47b6-7e02-3bd98748c83a-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMzEuMTAuMjAxNiB1bSAwNzo0NCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDI5LzEw
LzE2IDEwOjU4IFBNLCBNaWtlIExvdGhpYW4gd3JvdGU6Cj4+IEkgdHVybmVkIG9uIHZzeW5jIGFu
ZCBldmVyeXRoaW5nIHdvcmtzIGdyZWF0IGluIHRvbWIgcmFpZGVyCj4+Cj4+IDpECj4+Cj4+IFRo
YW5rcyBhZ2FpbiB0byBldmVyeW9uZSB3aG8gbWFkZSB0aGlzIHBvc3NpYmxlCj4+Cj4+IE9uIEZy
aSwgMjggT2N0IDIwMTYgYXQgMTk6MzcgTWlrZSBMb3RoaWFuIDxtaWtlQGZpcmVidXJuLmNvLnVr
Cj4+IDxtYWlsdG86bWlrZUBmaXJlYnVybi5jby51az4+IHdyb3RlOgo+Pgo+PiAgICAgIEhpIE1h
cmlvCj4+Cj4+ICAgICAgVGhhdCBmaXhlcyB0aGUgdGVhcmluZywgaXQncyBiZWVuIHJlcGxhY2Vk
IHdpdGggYSBzdHJhbmdlIHN0dXR0ZXIsCj4+ICAgICAgbGlrZSBpdCdzIG9ubHkgc2hvd2luZyBo
YWxmIHRoZSBudW1iZXIgb2YgZnJhbWVzIGJlaW5nIHJlcG9ydGVkIC0KPj4gICAgICBpdCdzIHJl
YWxseSBub3RpY2VhYmxlIGluIHRvbWIgcmFpZGVyCj4gSSB3b25kZXIgaWYgdGhlIHN0dXR0ZXIg
bWlnaHQgYmUgZHVlIHRvIHRoZSBkR1BVIHdyaXRpbmcgYW5vdGhlciBmcmFtZQo+IGJlZm9yZSB0
aGUgaUdQVSBpcyBkb25lIHByb2Nlc3NpbmcgdGhlIHByZXZpb3VzIG9uZS4gQ2hyaXN0aWFuLCBk
b2VzIHRoZQo+IGFtZGdwdSBzY2hlZHVsZXIgd2FpdCBmb3Igc2hhcmVkIGZlbmNlcyBvZiBzaGFy
ZWQgQk9zIHRvIHNpZ25hbCBiZWZvcmUKPiBzdWJtaXR0aW5nIGpvYnMgdXNpbmcgdGhlbSB0byB0
aGUgR1BVPwoKWWVhaCwgdGhhdCBzaG91bGQgd29yay4gV2Ugd2FpdCBmb3IgYm90aCB0aGUgZXhj
bHVzaXZlIGFzIHdlbGwgYXMgYWxsIApzaGFyZWQgZmVuY2VzIGJlZm9yZSBDUyBvciBwYWdlZmxp
cC4KCk9ubHkgb24gQ1Mgd2UgZmlsdGVyIHRoZSBzaGFyZWQgZmVuY2VzIHNvIHRoYXQgd2UgZG9u
J3QgbmVjZXNzYXJ5IHdhaXQgCmZvciBzdWJtaXNzaW9ucyBmcm9tIHRoZSBzYW1lIHByb2Nlc3Mu
CgpDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
