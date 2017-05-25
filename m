From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: Tweaks for high pressure on CPU visible
 VRAM
Date: Thu, 25 May 2017 13:24:36 +0200
Message-ID: <CAAxE2A6YFjK1VPuxW=HROqKX+-ejvVJ=YneULp+cDkj033YAbA@mail.gmail.com>
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
 <0535f00f-9095-6209-72e9-e6bb46569a63@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0535f00f-9095-6209-72e9-e6bb46569a63-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBNYXkgMjUsIDIwMTcgYXQgNTozMSBBTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4gT24gMjQvMDUvMTcgMDg6MjcgUE0sIENocmlzdGlhbiBLw7Zu
aWcgd3JvdGU6Cj4+IEFtIDI0LjA1LjIwMTcgdW0gMTM6MDMgc2NocmllYiBNYXJlayBPbMWhw6Fr
Ogo+Pj4+Cj4+PiBJIHRoaW5rIHRoZSBmaW5hbCBzb2x1dGlvbiAoZG9uZSBpbiBmYXVsdF9yZXNl
cnZlX25vdGlmeSkgc2hvdWxkIGJlOgo+Pj4gaWYgKGJvLT5udW1fY3B1X3BhZ2VfZmF1bHRzKysg
PiAyMCkKPj4+ICAgICBiby0+cHJlZmVycmVkX2RvbWFpbiA9IEdUVF9XQzsKPgo+IEkgYWdyZWUg
c29tZXRoaW5nIGxpa2UgdGhhdCB3aWxsIHByb2JhYmx5IGJlIHBhcnQgb2YgdGhlIHNvbHV0aW9u
LCBidXQgSQo+IGRvdWJ0IGl0J3MgcXVpdGUgdGhhdCBzaW1wbGUgb3IgdGhhdCBpdCdzIHRoZSBv
bmx5IHRoaW5nIHRoYXQgY2FuIGJlCj4gaW1wcm92ZWQuCj4KPgo+PiBJIG1vcmUgb3IgbGVzcyBh
Z3JlZSBvbiB0aGF0LCBidXQgc2V0dGluZyBwcmVmZXJyZWRfZG9tYWluIHBlcm1hbmVudGx5Cj4+
IHRvIEdUVF9XQyBpcyB3aGF0IHdvcnJpZXMgbWUgYSBiaXQuCj4+Cj4+IEUuZy4gaW1hZ2luZSB5
b3UgYWx0K3RhYiBmcm9tIGEgZ2FtZSB0byB5b3VyIGJyb3dzZXIgYW5kIGJhY2sgYW5kIHRoZQo+
PiBnYW1lIHJ1bnMgd2F5IHNsb3dlciBub3cgYmVjYXVzZSBCT3MgYXJlIG5ldmVyIG1vdmVkIGJh
Y2sgdG8gVlJBTS4KPgo+IFJpZ2h0LCBwZXJtYW5lbnRseSBtb3ZpbmcgYSBCTyB0byBHVFQgbWln
aHQgaXRzZWxmIGNhdXNlIHBlcmZvcm1hbmNlIHRvCj4gZHJvcCBkb3duIGEgY2xpZmYgaW4gc29t
ZSBjYXNlcy4gSXQncyBwb3NzaWJsZSB0aGF0IHRoaXMgaXMgaXJyZWxldmFudAo+IGNvbXBhcmVk
IHRvIGV4Y2Vzc2l2ZSBidWZmZXIgbWlncmF0aW9uIGZvciBDUFUgYWNjZXNzIHRob3VnaC4KPgo+
Cj4+IFdoYXQgd2UgbmVlZCBpcyBhIGdsb2JhbCBsaW1pdCBvZiBudW1iZXIgb2YgYnl0ZXMgdHJh
bnNmZXJlZCBwZXIgc2Vjb25kCj4+IGZvciBzd2FwIG9wZXJhdGlvbnMgb3Igc29tZXRoaW5nIGxp
a2UgdGhhdC4KPj4KPj4gT3IgbWF5YmUgYSB0aW1lb3V0IHdoaWNoIHNheXMgd2hlbiBhIEJPIHdh
cyBtb3ZlZCAoZWl0aGVyIGJ5IHN3YXBwaW5nIGl0Cj4+IG91dCBvciBieSBhIENQVSBwYWdlIGZh
dWx0KSBvbmx5IG1vdmUgaXQgYmFjayBhZnRlciArbiBqaWZmaWVzIG9yCj4+IHNvbWV0aGluZyBs
aWtlIHRoYXQuCj4KPiBJIGFsc28gZmVlbCBsaWtlIHNvbWV0aGluZyBsaWtlIHRoaXMgd2lsbCBi
ZSBtb3JlIHVzZWZ1bCB0aGFuIHRoZSBudW1iZXIKPiBvZiBDUFUgcGFnZSBmYXVsdHMgcGVyIHNl
LiBCdXQgSSdtIGN1cmlvdXMgd2hhdCBNYXJlayBjb21lcyB1cCB3aXRoLiA6KQoKSSBkb24ndCBo
YXZlIGFueSBiZXR0ZXIgaWRlYSBhdCB0aGUgbW9tZW50LiBJdCBsb29rcyBsaWtlIEpvaG4gQnJv
b2tzCmhhcyBhbHJlYWR5IHNvbHZlZCB0aGlzIGlzc3VlIGJhc2VkIG9uIGhpcyBJUkMgY29tbWVu
dHMuCgpNYXJlawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
