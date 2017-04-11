From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati] Set correct DRM event context version
Date: Tue, 11 Apr 2017 14:58:31 +0900
Message-ID: <c5212a12-8908-38ef-5e29-bdce48116817@daenzer.net>
References: <20170410083751.19692-1-michel@daenzer.net>
 <20170410083751.19692-2-michel@daenzer.net>
 <CACvgo503KR+UdfiXQBuy7753tDhOSaF4yXP5vUvbFsw5L1ma-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo503KR+UdfiXQBuy7753tDhOSaF4yXP5vUvbFsw5L1ma-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Stone <daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTAvMDQvMTcgMDY6NDIgUE0sIEVtaWwgVmVsaWtvdiB3cm90ZToKPiBPbiAxMCBBcHJpbCAy
MDE3IGF0IDA5OjM3LCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToK
Pj4gRnJvbTogRGFuaWVsIFN0b25lIDxkYW5pZWxzQGNvbGxhYm9yYS5jb20+Cj4+Cj4+IERSTV9F
VkVOVF9DT05URVhUX1ZFUlNJT04gaXMgdGhlIGxhdGVzdCBjb250ZXh0IHZlcnNpb24gc3VwcG9y
dGVkIGJ5Cj4+IHdoYXRldmVyIHZlcnNpb24gb2YgbGliZHJtIGlzIHByZXNlbnQuIFdlIHdlcmUg
YmxpbmRseSBhc3NlcnRpbmcgd2UKPj4gc3VwcG9ydGVkIHdoYXRldmVyIHZlcnNpb24gdGhhdCBt
YXkgYmUsIGV2ZW4gaWYgd2UgYWN0dWFsbHkgZGlkbid0Lgo+Pgo+PiBXaXRoIGxpYmRybSAyLjQu
NzgsIHNldHRpbmcgYSBoaWdoZXIgY29udGV4dCB2ZXJzaW9uIHRoYW4gMiB3aWxsIGF0dGVtcHQK
Pj4gdG8gY2FsbCB0aGUgcGFnZV9mbGlwX2hhbmRsZXIyIHZmdW5jIGlmIGl0IHdhcyBub24tTlVM
TCwgd2hpY2ggYmVpbmcgYQo+PiByYW5kb20gY2h1bmsgb2Ygc3RhY2sgbWVtb3J5LCBpdCBtaWdo
dCB3ZWxsIGhhdmUgYmVlbi4KPj4KPiBTaG91bGQgYmUgc2FmZSBzaW5jZSB3ZSB1c2UgeG5mY2Fs
bG9jIFtpbiBSQURFT05HZXRSZWNdLgoKVGhhdCdzIGEgZ29vZCBwb2ludCwgdGhhbmtzIChhcHBs
aWVzIGVxdWFsbHkgdG8gdGhlIG1vZGVzZXR0aW5nIGRyaXZlcgpBRkFJQ1QpOyBJJ2xsIGRyb3Ag
dGhlIHNlY29uZCBwYXJhZ3JhcGggZnJvbSB0aGUgY29tbWl0IGxvZy4KCgo+IFJlZ2FyZGxlc3Ms
IHRoZSBhbWRncHUgYW5kIGF0aSBwYXRjaGVzIGFyZQo+IFJldmlld2VkLWJ5OiBFbWlsIFZlbGlr
b3YgPGVtaWwubC52ZWxpa292QGdtYWlsLmNvbT4KClRoYW5rcyEKCgotLSAKRWFydGhsaW5nIE1p
Y2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1k
LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAg
TWVzYSBhbmQgWCBkZXZlbG9wZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
