From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Fri, 10 Mar 2017 10:12:45 +0100
Message-ID: <b78a28ce-2191-58a2-868a-029ebf7a2ad8@amd.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
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
 <CAPM=9tzoqKE=F+JjWwUXv7cGTxwJ1u15jTNuTxqL_jSQwQMRAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tzoqKE=F+JjWwUXv7cGTxwJ1u15jTNuTxqL_jSQwQMRAQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui,
 Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

QW0gMTAuMDMuMjAxNyB1bSAwNTo0MyBzY2hyaWViIERhdmUgQWlybGllOgo+IE9uIDEwIE1hcmNo
IDIwMTcgYXQgMTQ6MjcsIERhdmUgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNvbT4gd3JvdGU6Cj4+
IE9uIDEwIE1hcmNoIDIwMTcgYXQgMTM6MjUsIERhdmUgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNv
bT4gd3JvdGU6Cj4+Pj4gQXMgZmFyIGFzIEkgY2FuIHNlZSB0aGUgb25seSBmdW5jdGlvbmFsaXR5
IHdlIGFyZSBtaXNzaW5nIGhlcmUgaXM6Cj4+Pj4KPj4+PiB2b2lkIHN5bmNfZmlsZV9zaWduYWwo
c3RydWN0IHN5bmNfZmlsZSAqc3luY19maWxlLCBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSkKPj4+
PiB7Cj4+Pj4gICAgICBkbWFfZmVuY2VfcHV0KHN5bmNfZmlsZS0+ZmVuY2UpOwo+Pj4+ICAgICAg
c3luY19maWxlLT5mZW5jZSA9IGZlbmNlOwo+Pj4+IH0KPj4+Pgo+Pj4+IFdlIHByb2JhYmx5IHNo
b3VsZCBkbyB0aGlzIGF0b21pY2FsbHksIGJ1dCB0aGF0IGlzIG9ubHkgYSBtYXR0ZXIgb2YgdGFr
aW5nCj4+Pj4gbG9ja3MvYXRvbWljIHBvaW50ZXIgb3BlcmF0aW9uLgo+Pj4+Cj4+Pj4gVGhlIHdh
aXRpbmcgaXMgZG9uZSB1c2luZyB0aGUgbm9ybWFsIHN5bmNfZmlsZV9nZXRfZmVuY2UoKSBmdW5j
dGlvbi4KPj4+Pgo+Pj4+IFRoZSByZXN0IGlzIERhdmlkJ3MgcGF0Y2ggdG8gaW1wb3J0L2V4cG9y
dCB0aGUgZmQgaGFuZGxlIGludG8gYSBsb2NhbCBpZHIKPj4+PiBiYXNlZCBoYW5kbGUuCj4+PiBB
cmUgeW91IHN1Z2dlc3Rpbmcgd2Ugc3RhcnQga2VlcGluZyB0cmFjayBvZiBzeW5jX2ZpbGUgb2Jq
ZWN0cyBpbiBhIGxvY2FsIGlkcj8KClllcywgZXhhY3RseS4KCj4+PiBBcyBjdXJyZW50bHkgdGhl
eSBhcmUgb25seSB0cmFja2VkIGFzIGZpbGVzLCB3aGljaCBpcyBwcm9iYWJseSBub3Qgd2hhdCB3
ZSB3YW50Cj4+PiBmb3IgZXZlcnkgdW5zaGFyZWQgc2VtYXBob3JlLCBvciBhcmUgeW91IHRoaW5r
aW5nIG1vcmUgdGhhdCB0aGUgYW1kZ3B1IGxvY2FsCj4+PiBzZW0gc2hvdWxkIGJlIGp1c3Qgc3Rv
cmluZyBhIHN5bmNfZmlsZSBwb2ludGVyLCByYXRoZXIgdGhhbiB3aGF0IGl0IGRvZXMgbm93Lgo+
PiBPa2F5IGhlcmUncyBhIGZpcnN0IHBhc3MgYXQgd2hhdCBJIHRoaW5rIHlvdSBtZWFuLCBpdCdz
IG1pc3NpbmcKPj4gdGhpbmdzLCBidXQgdGhlIGlkZWEKPj4gc2hvdWxkIGJlIHdoYXQgeW91IHNh
aWQuCgpZZWFoLCB0aGF0J3MgcHJldHR5IG11Y2ggd2hhdCBJIGhhZCBpbiBtaW5kLgoKSWYgd2Ug
Y2FuIGZpbmQgY29uc2Vuc3VzIHdpdGggdGhlIEludGVsIGd1eXMgb24gdGhpcyB3ZSBtaWdodCB3
YW50IHRvIAptb3ZlIHBhcnRzIG9mIHRoZSBpZHIgaGFuZGxpbmcgc3R1ZmYgaW50byBjb21tb24g
Y29kZS4KCkFuZCBJIHdvdWxkIGdpdmUgaXQgYW5vdGhlciBuYW1lLCBzb21ldGhpbmcgbGlrZSBz
eW5jX2hhbmRsZSBvciBzaW1pbGFyLiAKQXMgZmFyIGFzIEkgY2FuIHNlZSBpdCdzIGp1c3QgYW5v
dGhlciByZXByZXNlbnRhdGlvbiBvZiBzeW5jX2ZpbGUgCnN0cnVjdHVyZXMgdG8gdXNlcnNwYWNl
LgoKPiAoVGhpcyB2ZXJzaW9uIG9vcHNlcyBvZiBjb3Vyc2UgZHVlIHRvIE5VTEwgaW50byBzeW5j
X2ZpbGVfY3JlYXRlLAo+IGJ1dCB0aGF0IHNob3VsZCBiZSB0aXJpdmFsIHRvIGZpeCBuZXh0IHdl
ZWssKQoKWWVhaCwgd2Ugb2YgY291cnNlIG5lZWQgdG8gZmlndXJlIG91dCBhbGwgdGhlIGltcGxl
bWVudGF0aW9uIGRldGFpbHMuIApCdXQgSSB0aGluayB0aGF0IHdvbid0IGJlIG11Y2ggdHJvdWJs
ZS4KCkNocmlzdGlhbi4KCj4KPiBEYXZlLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
