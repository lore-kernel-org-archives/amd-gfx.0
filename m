From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Wed, 18 Jul 2018 17:55:23 +0200
Message-ID: <b2335e6f-0553-a3a8-0157-f4dc99ac9cea@daenzer.net>
References: <20180712004750.2024-1-maraeo@gmail.com>
 <9a8d8f7f-a468-fd5b-dec5-472ce9c88483@daenzer.net>
 <CAAxE2A6Vz08sWXiaB6B-F4_P7Fy6uDuJ7aF2gHLXZ4N3zj9sXw@mail.gmail.com>
 <a291b3b5-25bc-385a-5242-9bd75ec423e9@daenzer.net>
 <CAAxE2A7ffmO=Tv_DSWhPciF+y5q_wbaBYgcqHvxQVkeVfhBhdg@mail.gmail.com>
 <31980a46-1d16-8ead-cc2b-5a5b9eb4d530@daenzer.net>
 <CAAxE2A5SUypT+huhKKdSAWXZ8x+wgPSy2FGqLRTj_io+L1qLqA@mail.gmail.com>
 <97d0f539-1a98-f9fc-1ed5-5de7c5a8c3d0@daenzer.net>
 <CAAxE2A5ij49A-62_wqD6923nn1w6gT6iY-jeC2HUP3ksYacZQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A5ij49A-62_wqD6923nn1w6gT6iY-jeC2HUP3ksYacZQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNy0xNyAwODoxNCBQTSwgTWFyZWsgT2zFocOhayB3cm90ZToKPiBNaWNoZWwsIEkg
dGhpbmsgeW91IGFyZSB3YXN0aW5nIHlvdXIgdGltZS4gVGhpcyBjaGFuZ2UgY2FuIGJlIG1pc3Vz
ZWQKPiBhcyBlYXNpbHkgYXMgYW55IG90aGVyIEFQSS4gSXQncyBub3QgbW9yZSBkYW5nZXJvdXMg
dGhhdCBhbnkgb3RoZXIKPiBhbWRncHUgbGliZHJtIGZ1bmN0aW9uLgoKVGhhdCdzIHRyaXZpYWxs
eSBmYWxzZS4KCj4gWW91IHdvbid0IGFjaGlldmUgYW55dGhpbmcgYnkgb3B0aW1pemluZyB0aGUg
aGFzaCB0YWJsZSAoPSBsb3NpbmcgdGltZSksCj4gWy4uLl0KCkkgdGhpbmsgeW91J3JlIGZvY3Vz
aW5nIHRvbyBtdWNoIG9uIHlvdXIgaW1tZWRpYXRlIGRlc2lyZSBpbnN0ZWFkIG9mIHRoZQpiaWco
Z2VyKSBwaWN0dXJlLgoKRS5nLiBJIHNlZSBhbWRncHVfYm9fZXhwb3J0IGdldHRpbmcgY2FsbGVk
IGZyb20gc3VycHJpc2luZyBwbGFjZXMgKGluClhvcmcpLCBwZXJmb3JtaW5nIGEgaGFzaCB0YWJs
ZSBsb29rdXAgZWFjaCB0aW1lLiBGaXhpbmcgdGhhdCB3b3VsZAphY2hpZXZlIHNvbWV0aGluZywg
dGhvdWdoIHByb2JhYmx5IG5vdCBtdWNoLgoKQW55d2F5LCBhZGRpbmcgZGFuZ2Vyb3VzIEFQSSAo
a2VlcCBpbiBtaW5kIHRoYXQgd2UgZG9uJ3QgY29udHJvbCBhbGwKbGliZHJtX2FtZGdwdSB1c2Vy
cywgb3IgZXZlbiBrbm93IGhvdyB0aGV5J3JlIHVzaW5nIGl0KSBmb3Igc29tZXRoaW5nCnRoYXQg
Y2FuIGFsc28gYmUgYWNoaWV2ZWQgd2l0aG91dCBpcyBqdXN0IGEgYmFkIGlkZWEuIEF2b2lkaW5n
IHRoYXQgaXMKYWNoaWV2ZW1lbnQgZW5vdWdoLgoKClRoaXMgaXMgbXkgb3Bpbmlvbi4gSSBkb24n
dCBoYXZlIHZldG8gcG93ZXIgb3ZlciBsaWJkcm1fYW1kZ3B1LiBBdCBsZWFzdApDaHJpc3RpYW4g
c2VlbXMgaW4gZmF2b3VyIG9mIHRoaXMgY2hhbmdlLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETD
pG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxp
YnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFu
ZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
