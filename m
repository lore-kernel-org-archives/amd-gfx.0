From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: add FENCE_TO_HANDLE ioctl that returns
 syncobj or sync_file
Date: Wed, 13 Sep 2017 16:16:08 +0200
Message-ID: <be64ba03-3aa9-6eaf-9267-c3ec51882c12@vodafone.de>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <1505248934-1819-3-git-send-email-maraeo@gmail.com>
 <7413e296-b7f5-5963-b477-b04acfb4bb91@amd.com>
 <CAAxE2A7aR15Y9C2r_V_+6fTp-kEuFKwDApQRCnx_rxdsDOKtmw@mail.gmail.com>
 <MWHPR1201MB020689874960A24D32C4A39CB46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <CAAxE2A5UKZTuseX1Sqggc-XRprnfG+eQSZqbiytRyge5KJrCUg@mail.gmail.com>
 <MWHPR1201MB0206A14F0D2148D5036A9485B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <8927d6b6-f87c-00d9-57af-fdf4fb6dfcb8@vodafone.de>
 <MWHPR1201MB0206CBA3C079C15A7EAC6117B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <CAAxE2A72RAC61KOF10GTuged-pM4kpKGnnMJh-nmtF-xM4f9AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A72RAC61KOF10GTuged-pM4kpKGnnMJh-nmtF-xM4f9AQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTMuMDkuMjAxNyB1bSAxNjowNiBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4gT24gV2VkLCBT
ZXAgMTMsIDIwMTcgYXQgMzo0NiBQTSwgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpCj4gPERhdmlkMS5a
aG91QGFtZC5jb20+IHdyb3RlOgo+PiBGb3IgYW5kcm9pZCB1c2luZyBtZXNhIGluc3RhbmNlLCBl
Z2wgZHJhdyB3aWxsIGRlcXVldWUgYW4gYW5kcm9pZCBidWZmZXIsCj4+IGFmdGVyIGVnbCBkcmF3
LCB0aGUgYnVmZmVyIHdpbGwgYmFjayB0byBhbmRyb2lkIGJ1ZmZmZXIgcXVldWUsIGJ1dCBuZWVk
Cj4+IGFwcGVuZCBhIHN5bmNmaWxlIGZkLiBJZiBnZXR0aW5nIHN5bmNmaWxlIGZkIGZvciBldmVy
eSBlZ2wgZHJhdyBhbHdheXMgbmVlZHMKPj4gc2V2ZXJhbCBzeW5jb2JqIGlvY3RscywgdGhlIGlv
IG92ZXJoZWFkIGlzbid0IHNtYWxsLiBCdXQgaWYgd2UgZGlyZWN0bHkKPj4gcmV0dXJuIHN5bmNm
aWxlIHdoZW4gZWdsIGRyYXcgQ1MsICBpc24ndCBpdCBiZXR0ZXI/Cj4gWW91IGhhdmUgYSBnb29k
IHBvaW50LiBJJ2QgYmUgT0sgd2l0aCBlaXRoZXIgYXBwcm9hY2gsIG9yIGV2ZW4gd2l0aAo+IGhh
dmluZyBib3RoIG9wdGlvbnMgaW4gdGhlIGtlcm5lbC4KCkkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBv
cGluaW9uIGZvciB0aGUgQ1MgSU9DVEwgZWl0aGVyLiBJZiBpdCBzYXZlcyB1cyBhbiAKZXh0cmEg
SU9DVEwgd2hlbiB3ZSBkaXJlY3RseSByZXR1cm4gYSBzeW5jZmlsZSBmZCB0aGVuIHdoeSBub3Q/
CgpCdXQgd2UgcmVhbGx5IHNob3VsZG4ndCB1c2Ugc3luY2ZpbGUgZm9yIHRoZSBWQSBJT0NUTC4g
VGhhdCdzIG5vdGhpbmcgd2UgCndhbnQgdG8gc2hhcmUgd2l0aCBvdGhlciBwcm9jZXNzZXMgYW5k
IHRoZSByZXR1cm5lZCBmZW5jZSBvciBzZXF1ZW5jZSAKbmVlZHMgdG8gYmUgbGlnaHR3ZWlnaHQu
CgpJZGVhbGx5IEkgd291bGQgc2F5IGl0IHNob3VsZCBiZSBhIHNlcXVlbmNlIG51bWJlciwgc28g
dGhhdCB5b3UgY2FuIHNheSAKbWF4KHNlcTEsIHNlcTIpIGFuZCBhbHdheXMgaGF2ZSB0aGUgbGF0
ZXN0LgoKVGhlIG5leHQgYmVzdCBhcHByb2FjaCBJIHRoaW5rIHdvdWxkIGJlIHRvIHVzZSBzeW5j
b2JqLCBjYXVzZSBpdCBpcyAKc2ltcGx5IHJhdGhlciBlYXNpbHkgdG8gaW1wbGVtZW50LgoKQ2hy
aXN0aWFuLgoKPgo+IE1hcmVrCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
