From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Fri, 10 Mar 2017 14:43:24 +1000
Message-ID: <CAPM=9tzoqKE=F+JjWwUXv7cGTxwJ1u15jTNuTxqL_jSQwQMRAQ@mail.gmail.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
 <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
 <a25fdfeb-be5d-2d23-d7b1-ef14891ba6d5@gmail.com>
 <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
 <58B4D68E.5080606@amd.com>
 <CAPM=9tw3nbGe+gaOpoBZeXfmS5+C3R4eK=uT8AL3krL0PMR0LA@mail.gmail.com>
 <CAPM=9twMvVoKCCmQUVsB6uD18j1e9cNq9eNqviVFy6F8v7OdOg@mail.gmail.com>
 <58C0FD86.8040808@amd.com> <d5a5f1ba-4bcb-f374-f18e-b060cc40aa9e@amd.com>
 <CAPM=9twfZhb7vt_gEBE6LaUfthseX_PC_BZctCyu520MK32QCQ@mail.gmail.com>
 <37118a87-28f2-c96d-18dc-a71292ea35d4@amd.com> <58C123A6.70209@amd.com>
 <a6a3ea27-aae2-dc69-1ec2-f463d8417712@vodafone.de>
 <CAPM=9tyn1gvTW5W3JbbxmzkN3PTwJjmOKCHiiU52ZOqGDJf_6A@mail.gmail.com>
 <85322d42-e585-659d-6f98-fc5baf0d6b14@amd.com>
 <CAPM=9tz+3DB8zZTH1kRUt8KE-wU7RNeoOE6zQWn_dWDvVRSBMA@mail.gmail.com>
 <CAPM=9tyDjtgzYEo7FET6jY9zZrWEd1LoLGWLNRkbbRnWTsnzkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tyDjtgzYEo7FET6jY9zZrWEd1LoLGWLNRkbbRnWTsnzkw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui,
 Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

T24gMTAgTWFyY2ggMjAxNyBhdCAxNDoyNywgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29t
PiB3cm90ZToKPiBPbiAxMCBNYXJjaCAyMDE3IGF0IDEzOjI1LCBEYXZlIEFpcmxpZSA8YWlybGll
ZEBnbWFpbC5jb20+IHdyb3RlOgo+Pj4KPj4+IEFzIGZhciBhcyBJIGNhbiBzZWUgdGhlIG9ubHkg
ZnVuY3Rpb25hbGl0eSB3ZSBhcmUgbWlzc2luZyBoZXJlIGlzOgo+Pj4KPj4+IHZvaWQgc3luY19m
aWxlX3NpZ25hbChzdHJ1Y3Qgc3luY19maWxlICpzeW5jX2ZpbGUsIHN0cnVjdCBkbWFfZmVuY2Ug
KmZlbmNlKQo+Pj4gewo+Pj4gICAgIGRtYV9mZW5jZV9wdXQoc3luY19maWxlLT5mZW5jZSk7Cj4+
PiAgICAgc3luY19maWxlLT5mZW5jZSA9IGZlbmNlOwo+Pj4gfQo+Pj4KPj4+IFdlIHByb2JhYmx5
IHNob3VsZCBkbyB0aGlzIGF0b21pY2FsbHksIGJ1dCB0aGF0IGlzIG9ubHkgYSBtYXR0ZXIgb2Yg
dGFraW5nCj4+PiBsb2Nrcy9hdG9taWMgcG9pbnRlciBvcGVyYXRpb24uCj4+Pgo+Pj4gVGhlIHdh
aXRpbmcgaXMgZG9uZSB1c2luZyB0aGUgbm9ybWFsIHN5bmNfZmlsZV9nZXRfZmVuY2UoKSBmdW5j
dGlvbi4KPj4+Cj4+PiBUaGUgcmVzdCBpcyBEYXZpZCdzIHBhdGNoIHRvIGltcG9ydC9leHBvcnQg
dGhlIGZkIGhhbmRsZSBpbnRvIGEgbG9jYWwgaWRyCj4+PiBiYXNlZCBoYW5kbGUuCj4+Cj4+IEFy
ZSB5b3Ugc3VnZ2VzdGluZyB3ZSBzdGFydCBrZWVwaW5nIHRyYWNrIG9mIHN5bmNfZmlsZSBvYmpl
Y3RzIGluIGEgbG9jYWwgaWRyPwo+Pgo+PiBBcyBjdXJyZW50bHkgdGhleSBhcmUgb25seSB0cmFj
a2VkIGFzIGZpbGVzLCB3aGljaCBpcyBwcm9iYWJseSBub3Qgd2hhdCB3ZSB3YW50Cj4+IGZvciBl
dmVyeSB1bnNoYXJlZCBzZW1hcGhvcmUsIG9yIGFyZSB5b3UgdGhpbmtpbmcgbW9yZSB0aGF0IHRo
ZSBhbWRncHUgbG9jYWwKPj4gc2VtIHNob3VsZCBiZSBqdXN0IHN0b3JpbmcgYSBzeW5jX2ZpbGUg
cG9pbnRlciwgcmF0aGVyIHRoYW4gd2hhdCBpdCBkb2VzIG5vdy4KPgo+IE9rYXkgaGVyZSdzIGEg
Zmlyc3QgcGFzcyBhdCB3aGF0IEkgdGhpbmsgeW91IG1lYW4sIGl0J3MgbWlzc2luZwo+IHRoaW5n
cywgYnV0IHRoZSBpZGVhCj4gc2hvdWxkIGJlIHdoYXQgeW91IHNhaWQuCgooVGhpcyB2ZXJzaW9u
IG9vcHNlcyBvZiBjb3Vyc2UgZHVlIHRvIE5VTEwgaW50byBzeW5jX2ZpbGVfY3JlYXRlLApidXQg
dGhhdCBzaG91bGQgYmUgdGlyaXZhbCB0byBmaXggbmV4dCB3ZWVrLCkKCkRhdmUuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
