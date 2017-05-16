From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Tue, 16 May 2017 10:57:52 +0900
Message-ID: <78fe31b2-2a0a-a1af-6af8-954d892e34ba@daenzer.net>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <9220eda1-5176-36cd-e6b3-801c3e4f759a@daenzer.net>
 <78989271-9812-f891-3a00-0d5b39a06b7c@daenzer.net>
 <CAAxE2A60hubc8jbZkO101sxqVZKR8iub=GsfRovj17+P2zKDKQ@mail.gmail.com>
 <aee1e2b7-dd00-e24b-bcfc-e2299e31908b@daenzer.net>
 <CAAxE2A5g7tJG+94XxPr-mdGXkeL1GPMNMaYgc7ATEk7pxsiXfA@mail.gmail.com>
 <c343b89c-318f-d3af-d02e-4e6843c422f6@daenzer.net>
 <CAAxE2A5_tiOEvLVegNvkuvYrFcsU52H6EfCff3faKBZwPfbuYQ@mail.gmail.com>
 <a5a8428e-444a-34b9-7fa9-60e77582819a@daenzer.net>
 <CAAxE2A4ex4e-5ShqesZ8oXJj1CnmH6Enhvu4fXs9kDKu9NHeiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4ex4e-5ShqesZ8oXJj1CnmH6Enhvu4fXs9kDKu9NHeiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTUvMDUvMTcgMDc6MTEgUE0sIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4gT24gTWF5IDE1LCAy
MDE3IDQ6MjkgQU0sICJNaWNoZWwgRMOkbnplciIgPG1pY2hlbEBkYWVuemVyLm5ldAo+IDxtYWls
dG86bWljaGVsQGRhZW56ZXIubmV0Pj4gd3JvdGU6Cj4gCj4gICAgIEkgdGhpbmsgdGhlIG5leHQg
c3RlcCBzaG91bGQgYmUgdG8gbWFrZSByYWRlb25zaSBrZWVwIHRyYWNrIG9mIGhvdyBtdWNoCj4g
ICAgIFZSQU0gaXQncyB0cnlpbmcgdG8gdXNlIHRoYXQncyBleHBlY3RlZCB0byBiZSBhY2Nlc3Nl
ZCBieSB0aGUgQ1BVLCBhbmQKPiAgICAgdG8gdXNlIEdUVCBpbnN0ZWFkIHdoZW4gdGhhdCBleGNl
ZWRzIGEgdGhyZXNob2xkIChwcm9iYWJseSBkZXJpdmVkIGZyb20KPiAgICAgdnJhbV92aXNfc2l6
ZSkuCj4gCj4gVGhhdCdzIGRpZmZpY3VsdCB0byBlc3RpbWF0ZS4gVGhlcmUgYXJlIGFwcHMgd2l0
aCA2MDBNQiBvZiBtYXBwZWQgVlJBTQo+IGFuZCBkb24ndCBleHBlcmllbmNlIGFueSBwZXJmb3Jt
YW5jZSBpc3N1ZXMuIEFuZCBzb21lIGFwcHMgd2l0aCAzMDBNQiBvZgo+IG1hcHBlZCBWUkFNIGRv
LiBJdCBvbmx5IGRlcGVuZHMgb24gdGhlIENQVSBhY2Nlc3MgcGF0dGVybiwgbm90IHdoYXQKPiBy
YWRlb25zaSBzZWVzLgoKV2hhdCBJIG1lYW4gaXMga2VlcGluZyB0cmFjayBvZiB0aGUgdG90YWwg
c2l6ZSBvZiByZXNvdXJjZXMgd2hpY2ggaGF2ZQpSQURFT05fRE9NQUlOX1ZSQU0gYW5kIFJBREVP
Tl9GTEFHX0NQVV9BQ0NFU1Mgc2V0LCBhbmQgaWYgaXQgZXhjZWVkcyBhCnRocmVzaG9sZCwgY3Jl
YXRlIG5ldyBvbmVzIGhhdmluZyB0aG9zZSBmbGFncyBpbiBHVFQgaW5zdGVhZC4gRXZlbgp0aG91
Z2ggdGhpcyBtaWdodCBub3QgYmUgc3RyaWN0bHkgbmVjZXNzYXJ5IHdpdGggYW1kZ3B1IGluIHRo
ZSBsb25nIHJ1biwKaXQgcHJvYmFibHkgaXMgZm9yIHJhZGVvbiBhbnl3YXksIGFuZCBpbiB0aGUg
c2hvcnQgdGVybSBpdCBtaWdodCBoZWxwCmV2ZW4gd2l0aCBhbWRncHUuCgoKLS0gCkVhcnRobGlu
ZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3
LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAg
ICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
