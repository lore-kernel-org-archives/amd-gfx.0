From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU
Date: Sat, 10 Dec 2016 06:34:17 +1000
Message-ID: <CAPM=9txML=Go-CaFzEbm2AkWKKdOKMySa+GMLaQ=Q9kBJx93=Q@mail.gmail.com>
References: <55d5e664-25f7-70e0-f2f5-9c9daf3efdf6@amd.com>
 <20161208095952.hnbfs4b3nac7faap@phenom.ffwll.local>
 <CAPM=9tw=OLirgVU1RVxfPZ1PV64qtjOPTJ2q540=9VJhF4o2RQ@mail.gmail.com>
 <CAPM=9tzqaSR3dUBV9RUmo-kQZ8VmNP=rdgiHwOBii=7A2X0Dew@mail.gmail.com>
 <MWHPR12MB14069887D43D80E37F6A133A98870@MWHPR12MB1406.namprd12.prod.outlook.com>
 <CAKMK7uGDUBHZKNEZTdOi2_66vKZmCsc+ViM0UyTdRPfnYa-Zww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKMK7uGDUBHZKNEZTdOi2_66vKZmCsc+ViM0UyTdRPfnYa-Zww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Cheng,
 Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T24gMTAgRGVjZW1iZXIgMjAxNiBhdCAwNTo1OSwgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPiB3cm90ZToKPiBJIGd1ZXNzIHRoaW5ncyB3ZW50IGEgYml0IHNpZGV3YXlzIGJ5IG1lIGFu
ZCBEYXZlIG9ubHkgdGFsa2luZyBhYm91dAo+IHRoZSBtaWRsYXllciwgc28gbGV0IG1lIGZpcnN0
IHN0YXRlIHRoYXQgdGhlIERDIHN0dWZmIGhhcyBtYXNzaXZlbHkKPiBpbXByb3ZlZCB0aHJvdWdo
IHJlcGxhY2luZyBhbGwgdGhlIGJhY2tlbmQgc2VydmljZXMgdGhhdCByZWltcGxlbWVudGVkCj4g
TGludXggaGVscGVyIGxpYnJhcmllcyB3aXRoIHRoZWlyIG5hdGl2ZSBlcXVpdmFsZW50LiBUaGF0
J3Mgc29tZQo+IHNlcmlvdXMgd29yaywgYW5kIGl0IHNob3dzIHRoYXQgQU1EIGlzIGNvbW1pdHRl
ZCB0byBkb2luZyB0aGUgcmlnaHQKPiB0aGluZy4KPgo+IEkgYWJzb2x1dGVseSBkaWRuJ3Qgd2Fu
dCB0byBiZWxpdHRsZSBhbGwgdGhhdCBlZmZvcnQgYnkgb25seSByYWlzaW5nCj4gd2hhdCBJIHNl
ZSBpcyB0aGUgb25lIGhvbGRvdmVyIGxlZnQuCgpJIHNlZSBteXNlbGYgYW5kIERhbmllbCBoYXZl
IGtpbmRhIGZhbGxlbiBpbnRvIGdvb2QtY29wLCBiYWQtY29wIG1vZGUuCgpJIGFncmVlIHdpdGgg
ZXZlcnl0aGluZyBEYW5pZWwgaGFkIHNhaWQgaW4gaGVyZSwgYW5kIGNvbWUgbmV4dCB3ZWVrIEkg
bWlnaHQKdHJ5IGFuZCB3cml0ZSBzb21ldGhpbmcgbW9yZSBjb25zdHJ1Y3RpdmUgdXAsIGJ1dCBi
ZWxpZXZlIG1lIERhbmllbCBpcyB0b3RhbGx5CnJpZ2h0ISBJdCdzIFNhdHVyZGF5IG1vcm5pbmcs
IEkndmUgZ290IGEgd2Vla2VuZCB0byBkZWFsIHdpdGggYW5kIEknbSBnb2luZyB0bwp0cnkgYW5k
IGF2b2lkIHRoaW5raW5nIHRvbyBtdWNoIGFib3V0IHRoaXMuCgpJIGFjdHVhbGx5IGxvdmUgYmFu
ZHdpZHRoX2NhbGNzLmMgSSdkIGxpa2UgdG8gbWVyZ2UgaXQgZXZlbiBiZWZvcmUgREFMLCB5ZXMK
aXQncyB1Z2x5IGNvZGUsIGFuZCBpdCdzIGhvcnJpYmxlIGJ1dCBpdCdzIGEgc2luZ2xlIHBpZWNl
IG9mIGh3IHRlYW0gbWFnaWMsIGFuZAp3ZSBjYW4gaGlkZSB0aGF0LiBJdCdzIHRoZSBzdyBhYnN0
cmFjdGlvbiBtYWdpYyB0aGF0IGlzIG15IGlzc3VlLgoKRGF2ZS4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
