From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Tue, 11 Oct 2016 14:04:55 +0200
Message-ID: <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8@vodafone.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d74d34a7-5221-d282-d9d1-b0e1007fc0c7-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTEuMTAuMjAxNiB1bSAwNTo1OCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDA3LzEw
LzE2IDA5OjM0IFBNLCBNaWtlIExvdGhpYW4gd3JvdGU6Cj4+IFRoaXMgaGFzIGRpc2N1c3Npb24g
aGFzIGdvbmUgYSBsaXR0bGUgcXVpZXQKPj4KPj4gV2FzIHRoZXJlIGFueSBhZ3JlZW1lbnQgYWJv
dXQgd2hhdCBuZWVkZWQgZG9pbmcgdG8gZ2V0IHRoaXMgd29ya2luZwo+PiBmb3IgaTk2NS9hbWRn
cHU/Cj4gQ2hyaXN0aWFuLCBkbyB5b3Ugc2VlIGFueXRoaW5nIHdoaWNoIGNvdWxkIHByZXZlbnQg
dGhlIHNvbHV0aW9uIEkKPiBvdXRsaW5lZCBmcm9tIHdvcmtpbmc/CgpJIHRob3VnaHQgYWJvdXQg
dGhhdCBhcHByb2FjaCBhcyB3ZWxsLCBidXQgdW5mb3J0dW5hdGVseSBpdCBhbHNvIGhhcyBhIApj
b3VwbGUgb2YgZG93bnNpZGVzLiBFc3BlY2lhbGx5IGtlZXBpbmcgdGhlIGV4Y2x1c2l2ZSBmZW5j
ZSBzZXQgd2hpbGUgd2UgCmFjdHVhbGx5IGRvbid0IG5lZWQgaXQgaXNuJ3QgcmVhbGx5IGNsZWFu
IGVpdGhlci4KCkknbSBjdXJyZW50bHkgYSBiaXQgYnVzeSB3aXRoIG90aGVyIHRhc2tzIGFuZCBz
byBwdXQgTmF5YW4gb24gYSByb2FkIHRvIApnZXQgYSBiaXQgaW50byB0aGUga2VybmVsIGRyaXZl
ciAoaGUgYXNrZWQgZm9yIHRoYXQgYW55d2F5KS4KCkltcGxlbWVudGluZyB0aGUgc2ltcGxlIHdv
cmthcm91bmQgdG8gc3luYyB3aGVuIHdlIGV4cG9ydCB0aGUgRE1BLWJ1ZiAKc2hvdWxkIGJlIHNv
bWV0aGluZyBsaWtlIDIwIGxpbmVzIG9mIGNvZGUgYW5kIGZvcnR1bmF0ZWx5IE5heWFuIGhhcyBh
biAKSStBIHN5c3RlbSBhbmQgc28gY2FuIGFjdHVhbGx5IHRlc3QgaXQuCgpJZiBpdCB0dXJucyBv
dXQgdG8gYmUgbW9yZSBwcm9ibGVtYXRpYyBvciBzb21lYm9keSByZWFsbHkgc3RhcnRzIHRvIG5l
ZWQgCml0IEknbSBnb2luZyB0byBoYWNrIG9uIHRoYXQgbXlzZWxmIGEgYml0IG1vcmUuCgpSZWdh
cmRzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
