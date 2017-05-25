From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: Tweaks for high pressure on CPU visible
 VRAM
Date: Thu, 25 May 2017 12:31:34 +0900
Message-ID: <0535f00f-9095-6209-72e9-e6bb46569a63@daenzer.net>
References: <20170518090809.15916-1-michel@daenzer.net>
 <CAAxE2A65deE+hue7oPMQ+=K5s8TEGZE+bJMNVOdp=LQuq_RnMQ@mail.gmail.com>
 <a574c18a-0c21-bf85-963f-5df06a0b192e@daenzer.net>
 <CAAxE2A6ZiNSswhArstqHpYnm30ieoDZj=j_-aFvZz1_ByXLOGA@mail.gmail.com>
 <CAAxE2A4zdgFRh-GDqyDRrXmEWqjSrkfCo=Z41hfo-UNY0E5FhA@mail.gmail.com>
 <CAAxE2A67T3Mhw68thNewFtcdua3ufSP-FDX_RN153x-aLKUh1Q@mail.gmail.com>
 <7649341f-6407-1a12-9674-fb65076125fc@daenzer.net>
 <CAAxE2A446KFb+CiwdZusvdgRSfQS8jLgsCy4K7L0_tc00pvWKA@mail.gmail.com>
 <c3dfa73a-e0c1-c6e9-0264-3c52e444c297@daenzer.net>
 <CAAxE2A7tKvvmZ+qf8f06FJODWNLgHcv-XPiJJgLana-PcXBR_g@mail.gmail.com>
 <f04e8239-e8cb-1c6c-a0ae-581facadb3cf@daenzer.net>
 <CAAxE2A5uha-MPx4B=ZeW9kf2qQXOTNcK7sxMJDtEk54S=us47g@mail.gmail.com>
 <eafd4ca6-fbbf-2bb4-be97-16f54fe402dd@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <eafd4ca6-fbbf-2bb4-be97-16f54fe402dd-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjQvMDUvMTcgMDg6MjcgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjQuMDUu
MjAxNyB1bSAxMzowMyBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4+Pgo+PiBJIHRoaW5rIHRoZSBm
aW5hbCBzb2x1dGlvbiAoZG9uZSBpbiBmYXVsdF9yZXNlcnZlX25vdGlmeSkgc2hvdWxkIGJlOgo+
PiBpZiAoYm8tPm51bV9jcHVfcGFnZV9mYXVsdHMrKyA+IDIwKQo+PiAgICAgYm8tPnByZWZlcnJl
ZF9kb21haW4gPSBHVFRfV0M7CgpJIGFncmVlIHNvbWV0aGluZyBsaWtlIHRoYXQgd2lsbCBwcm9i
YWJseSBiZSBwYXJ0IG9mIHRoZSBzb2x1dGlvbiwgYnV0IEkKZG91YnQgaXQncyBxdWl0ZSB0aGF0
IHNpbXBsZSBvciB0aGF0IGl0J3MgdGhlIG9ubHkgdGhpbmcgdGhhdCBjYW4gYmUKaW1wcm92ZWQu
CgoKPiBJIG1vcmUgb3IgbGVzcyBhZ3JlZSBvbiB0aGF0LCBidXQgc2V0dGluZyBwcmVmZXJyZWRf
ZG9tYWluIHBlcm1hbmVudGx5Cj4gdG8gR1RUX1dDIGlzIHdoYXQgd29ycmllcyBtZSBhIGJpdC4K
PiAKPiBFLmcuIGltYWdpbmUgeW91IGFsdCt0YWIgZnJvbSBhIGdhbWUgdG8geW91ciBicm93c2Vy
IGFuZCBiYWNrIGFuZCB0aGUKPiBnYW1lIHJ1bnMgd2F5IHNsb3dlciBub3cgYmVjYXVzZSBCT3Mg
YXJlIG5ldmVyIG1vdmVkIGJhY2sgdG8gVlJBTS4KClJpZ2h0LCBwZXJtYW5lbnRseSBtb3Zpbmcg
YSBCTyB0byBHVFQgbWlnaHQgaXRzZWxmIGNhdXNlIHBlcmZvcm1hbmNlIHRvCmRyb3AgZG93biBh
IGNsaWZmIGluIHNvbWUgY2FzZXMuIEl0J3MgcG9zc2libGUgdGhhdCB0aGlzIGlzIGlycmVsZXZh
bnQKY29tcGFyZWQgdG8gZXhjZXNzaXZlIGJ1ZmZlciBtaWdyYXRpb24gZm9yIENQVSBhY2Nlc3Mg
dGhvdWdoLgoKCj4gV2hhdCB3ZSBuZWVkIGlzIGEgZ2xvYmFsIGxpbWl0IG9mIG51bWJlciBvZiBi
eXRlcyB0cmFuc2ZlcmVkIHBlciBzZWNvbmQKPiBmb3Igc3dhcCBvcGVyYXRpb25zIG9yIHNvbWV0
aGluZyBsaWtlIHRoYXQuCj4gCj4gT3IgbWF5YmUgYSB0aW1lb3V0IHdoaWNoIHNheXMgd2hlbiBh
IEJPIHdhcyBtb3ZlZCAoZWl0aGVyIGJ5IHN3YXBwaW5nIGl0Cj4gb3V0IG9yIGJ5IGEgQ1BVIHBh
Z2UgZmF1bHQpIG9ubHkgbW92ZSBpdCBiYWNrIGFmdGVyICtuIGppZmZpZXMgb3IKPiBzb21ldGhp
bmcgbGlrZSB0aGF0LgoKSSBhbHNvIGZlZWwgbGlrZSBzb21ldGhpbmcgbGlrZSB0aGlzIHdpbGwg
YmUgbW9yZSB1c2VmdWwgdGhhbiB0aGUgbnVtYmVyCm9mIENQVSBwYWdlIGZhdWx0cyBwZXIgc2Uu
IEJ1dCBJJ20gY3VyaW91cyB3aGF0IE1hcmVrIGNvbWVzIHVwIHdpdGguIDopCgoKLS0gCkVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8v
d3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
