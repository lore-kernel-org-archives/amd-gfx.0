From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdgpu: Optimization of critical section
Date: Wed, 14 Jun 2017 09:08:27 +1000
Message-ID: <CAPM=9twrh5XDCKj9ozH0syi=33Wvbx4QHwpM1iEZwNqPxkwzyA@mail.gmail.com>
References: <1497299485-7337-1-git-send-email-AlexBin.Xie@amd.com>
 <1497299485-7337-2-git-send-email-AlexBin.Xie@amd.com>
 <0b8a7163-4f3f-d1b3-81ab-b9cb3c2ae9af@vodafone.de>
 <d4a8c004-8a60-83ea-be83-c827115e1a6b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d4a8c004-8a60-83ea-be83-c827115e1a6b-5C7GfCeVMHo@public.gmane.org>
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
To: axie <axie-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

T24gMTMgSnVuZSAyMDE3IGF0IDE2OjU0LCBheGllIDxheGllQGFtZC5jb20+IHdyb3RlOgo+Cj4g
T24gMjAxNy0wNi0xMiAwNjo0NyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4KPj4gQW0g
MTIuMDYuMjAxNyB1bSAyMjozMSBzY2hyaWViIEFsZXggWGllOgo+Pj4KPj4+IE1ha2UgdGhlIGNy
aXRpY2FsIHNlY3Rpb24gc21hbGxlci4gVGhlcmUgaXMgbm8KPj4+IG5lZWQgdG8gcHJvdGVjdCB0
aGUgYm9fbGlzdCwgYmVjYXVzZSB0aGVyZSBpcwo+Pj4gbm8gb3RoZXIgdGFzayBjYW4gYWNjZXNz
IHRoZSBuZXdseSBjcmVhdGVkIEJPCj4+PiBsaXN0IHlldC4KPj4KPj4KPj4gTkFLLCBhIHRhc2sg
Y2FuIGd1ZXNzIHRoZSBuZXh0IGlkIG51bWJlciBzbyBjb3VsZCBnZXQgdGhlIGtlcm5lbCB0byB1
c2UKPj4gdGhlIHN0cnVjdHVyZSBiZWZvcmUgaXQgaXMgaW5pdGlhbGl6ZWQuCj4+Cj4+IENocmlz
dGlhbi4KPj4KPiBIb3cgZGlkIHlvdSBmaW5kIHN1Y2ggYW4gZXh0cmVtZSBjb3JuZXIgY2FzZT8g
SSBhbSBmaW5lIHdpdGggdGhpcyBjb21tZW50Lgo+IFR1ZXNkYXkvV2VkbmVzZGF5IEkgd2lsbCBh
ZGRyZXNzIGl0IHdpdGggbmV4dCB2ZXJzaW9uIG9mIHBhdGNoIHNldC4KPgo+IEN1cnJlbnRseSwg
dGhlcmUgYXJlIDIgb3B0aW9uczoKPiBPcHRpb24gMTogSSBtYXkgdXNlIGEgd3JpdGVfbG9jayBp
biB0aGUgY3JlYXRlIGZ1bmN0aW9uLiBBbmQgcmVzdG9yZSB0aGUKPiBvcmlnaW5hbCBjb2RlIGZv
ciB0aGUgY3JlYXRpb24gb2YgQk8gbGlzdC4KPiBPcHRpb24gMjogSSBtYXkgbW92ZSB0aGUgZnVu
Y3Rpb24gY2FsbCBvZiBpZHJfYWxsb2MgdG8gdGhlIGVuZCBvZiB0aGUKPiBjcmVhdGlvbiBvZiBC
TyBsaXN0IGlvY3RsLiBUaGlzIGlzIG1vcmUgZWZmaWNpZW50IGJ1dAo+IHRoZSBjb2RlIGxvb2sg
ZGlydHkuCgpZb3UgY2FuIGlkcl9hbGxvYyBhbmQgaWRyX3JlcGxhY2UgbGF0ZXIgYnR3LiBXZSBk
byB0aGlzIGluIGEgZmV3CnBsYWNlcyBpbiB0aGUgZHJtLgoKRGF2ZS4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
