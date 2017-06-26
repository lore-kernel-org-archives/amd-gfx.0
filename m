From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Mon, 26 Jun 2017 17:10:56 +0800
Message-ID: <5950CFA0.90906@amd.com>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
 <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
 <CAAxE2A7ic2YLmnkzM0Faa3bO9-GwWRTHRc0EUVej5UU7Yhs4Qg@mail.gmail.com>
 <efc2289a-382d-8443-8419-da2d0cadfd77@amd.com>
 <e23f64c3-6abf-ff65-2300-5c44d242f4df@amd.com>
 <CAAxE2A61KqM9gr=Zoo5PHFNb8gWp74RG9KOs=efWzf1dMKBwSA@mail.gmail.com>
 <7134d81f-a60f-7093-d2a3-70edde23cdb2@amd.com>
 <3436ae97-39b1-4a3f-bb73-2991adad5715@vodafone.de> <594CBEBC.5010703@amd.com>
 <0d847baf-8296-f3ce-7a8d-8823f33e392e@vodafone.de> <594CD8E0.3080702@amd.com>
 <594CDA92.1060809@amd.com>
 <CAPM=9tzXrih9qpkOY+OGC1TF8nD0ZmwNnxXiRbMtcO7tR1-m1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tzXrih9qpkOY+OGC1TF8nD0ZmwNnxXiRbMtcO7tR1-m1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>
Cc: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, axie <axie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Xie,
 AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

CgpPbiAyMDE35bm0MDbmnIgyNuaXpSAwMzo0OCwgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4+IERvIHlv
dSBub3QgdXNlIGJvIGxpc3QgYXQgYWxsIGluIG1lc2E/IHJhZHYgYXMgd2VsbD8KPiBDdXJyZW50
bHkgcmFkdiBpcyBjcmVhdGluZyBhIGJvIGxpc3QgcGVyIGNvbW1hbmQgc3VibWlzc2lvbi4gcmFk
diBkb2VzCj4gbm90IHVzZSBhbiBvZmZsb2FkIHRocmVhZCB0byBkbyBjb21tYW5kIHN1Ym1pc3Np
b24sIGFzIGl0IHNlZW1zIHByZXR0eQo+IHVuLXZ1bGthbiB0byB1c2UgYSB0aHJlYWQgZm9yIHRo
ZSBxdWV1ZSBzdWJtaXNzaW9uIHRocmVhZCB0aGUgZ2FtZQo+IHVzZXMuCj4KPiBJIGhhdmUgY29u
c2lkZXJlZCBpbnZlc3RpZ2F0aW5nIHRoaXMsIGJ1dCB3aXRoIHZ1bGthbiBpdCdzIHByb2JhYmx5
Cj4gb3B0aW1pc2luZyBmb3IgdGhlIHNpbmdsZSB0aHJlYWRlZCBjYXNlIHdoaWNoIGlzbid0IHdo
ZXJlIGFwcHMgc2hvdWxkCj4gcmVhbGx5IGJlLgo+Cj4gQXQgdGhlIG1vbWVudCB3ZSByZWdlbmVy
YXRlIHRoZSBibyBsaXN0IG9uIGV2ZXJ5IENTIGlvY3RsLCB3ZSBwcm9iYWJseQo+IGNhbiBkbyBh
IGxvdCBiZXR0ZXIsIEkga25vdyBCYXMgaGFzIGxvb2tlZCBpbnRvIHRoaXMgYXJlYSBhIGJpdCBt
b3JlCj4gdGhhbiBJLgpUaGFua3MgRGF2ZSBmb3IgaW5wdXR0aW5nLgoKQ291bGQgSSBhc2sgbW9y
ZSBhYm91dCByYWR2PyBIb3cgZG9lcyByYWR2IG1ha2UgYm8gbGlzdCBmb3IgZXZlcnkgY3MgCmlv
Y3RsPyBBZGRpbmcgZmlsdGVyIGluIGV2ZXJ5IG9wZXJhdGlvbiwgYW55IHJlbGF0ZWQgYm8gd2ls
bCBiZSBhZGQgdG8gCmJvIGxpc3QgZHVyaW5nIG1ha2UgY29tbWFuZCBzdWJtaXNzaW9uPwoKVGhh
bmtzLApEYXZpZCBaaG91Cj4KPiBEYXZlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
