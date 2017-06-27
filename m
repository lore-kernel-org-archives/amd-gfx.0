From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Wed, 28 Jun 2017 06:40:47 +1000
Message-ID: <CAPM=9tw-E39oQ1gRPJs3oZBniALzgoa53ErF-trgxiN8Z9xyww@mail.gmail.com>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
 <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
 <CAAxE2A7ic2YLmnkzM0Faa3bO9-GwWRTHRc0EUVej5UU7Yhs4Qg@mail.gmail.com>
 <efc2289a-382d-8443-8419-da2d0cadfd77@amd.com>
 <e23f64c3-6abf-ff65-2300-5c44d242f4df@amd.com>
 <CAAxE2A61KqM9gr=Zoo5PHFNb8gWp74RG9KOs=efWzf1dMKBwSA@mail.gmail.com>
 <7134d81f-a60f-7093-d2a3-70edde23cdb2@amd.com>
 <3436ae97-39b1-4a3f-bb73-2991adad5715@vodafone.de>
 <594CBEBC.5010703@amd.com> <0d847baf-8296-f3ce-7a8d-8823f33e392e@vodafone.de>
 <594CD8E0.3080702@amd.com> <594CDA92.1060809@amd.com>
 <CAPM=9tzXrih9qpkOY+OGC1TF8nD0ZmwNnxXiRbMtcO7tR1-m1Q@mail.gmail.com>
 <5950CFA0.90906@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5950CFA0.90906-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>, axie <axie-5C7GfCeVMHo@public.gmane.org>, "Xie,
 AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

T24gMjYgSnVuZSAyMDE3IGF0IDE5OjEwLCB6aG91Y20xIDxkYXZpZDEuemhvdUBhbWQuY29tPiB3
cm90ZToKPgo+Cj4gT24gMjAxN+W5tDA25pyIMjbml6UgMDM6NDgsIERhdmUgQWlybGllIHdyb3Rl
Ogo+Pj4KPj4+IERvIHlvdSBub3QgdXNlIGJvIGxpc3QgYXQgYWxsIGluIG1lc2E/IHJhZHYgYXMg
d2VsbD8KPj4KPj4gQ3VycmVudGx5IHJhZHYgaXMgY3JlYXRpbmcgYSBibyBsaXN0IHBlciBjb21t
YW5kIHN1Ym1pc3Npb24uIHJhZHYgZG9lcwo+PiBub3QgdXNlIGFuIG9mZmxvYWQgdGhyZWFkIHRv
IGRvIGNvbW1hbmQgc3VibWlzc2lvbiwgYXMgaXQgc2VlbXMgcHJldHR5Cj4+IHVuLXZ1bGthbiB0
byB1c2UgYSB0aHJlYWQgZm9yIHRoZSBxdWV1ZSBzdWJtaXNzaW9uIHRocmVhZCB0aGUgZ2FtZQo+
PiB1c2VzLgo+Pgo+PiBJIGhhdmUgY29uc2lkZXJlZCBpbnZlc3RpZ2F0aW5nIHRoaXMsIGJ1dCB3
aXRoIHZ1bGthbiBpdCdzIHByb2JhYmx5Cj4+IG9wdGltaXNpbmcgZm9yIHRoZSBzaW5nbGUgdGhy
ZWFkZWQgY2FzZSB3aGljaCBpc24ndCB3aGVyZSBhcHBzIHNob3VsZAo+PiByZWFsbHkgYmUuCj4+
Cj4+IEF0IHRoZSBtb21lbnQgd2UgcmVnZW5lcmF0ZSB0aGUgYm8gbGlzdCBvbiBldmVyeSBDUyBp
b2N0bCwgd2UgcHJvYmFibHkKPj4gY2FuIGRvIGEgbG90IGJldHRlciwgSSBrbm93IEJhcyBoYXMg
bG9va2VkIGludG8gdGhpcyBhcmVhIGEgYml0IG1vcmUKPj4gdGhhbiBJLgo+Cj4gVGhhbmtzIERh
dmUgZm9yIGlucHV0dGluZy4KPgo+IENvdWxkIEkgYXNrIG1vcmUgYWJvdXQgcmFkdj8gSG93IGRv
ZXMgcmFkdiBtYWtlIGJvIGxpc3QgZm9yIGV2ZXJ5IGNzIGlvY3RsPwo+IEFkZGluZyBmaWx0ZXIg
aW4gZXZlcnkgb3BlcmF0aW9uLCBhbnkgcmVsYXRlZCBibyB3aWxsIGJlIGFkZCB0byBibyBsaXN0
Cj4gZHVyaW5nIG1ha2UgY29tbWFuZCBzdWJtaXNzaW9uPwoKV2hlbiB3ZSBjcmVhdGUgY29tbWFu
ZCBidWZmZXJzIHdlIGFkZCBlYWNoIGJvIHRvIGEgbGlzdCBmb3IgaXQsIGJ1dCB3ZQpkb24ndCBj
YWxsIHRoZSBrZXJuZWwgaW9jdGwuCgpXaGVuIHdlIGdldCBhIFF1ZXVlU3VibWl0LCB3ZSB1c3Vh
bGx5IHN1Ym1pdCB0d28gSUJzIHRvIHRoZSBrZXJuZWwsCm9uZSB3aXRoIHNvbWUgY2FjaGUgZmx1
c2hlcyBhbmQgb25lIHdpdGggdGhlIG1haW4gSUIgaW4gaXQsIGhvd2V2ZXIgYXMKd2UgaGF2ZSB0
byBnaXZlIHRoZSBrZXJuZWwgb25lIGJvIGxpc3Qgd2UgaGF2ZSB0byBjb21iaW5lIHRoZSB0d28K
bGlzdHMgKGV2ZW4gaWYgdGhlIGNhY2hlIGZsdXNoIGxpc3Qgb25seSBoYXMgb25lIGliIGluIGl0
LCBpdHNlbGYpLCBzbwp3ZSBjYW4ndCBjYWxsIGNyZWF0ZSBibyBsaXN0IGVhcmx5LCB3ZSBoYXZl
IHRvIGRvIGl0IGp1c3QgYmVmb3JlCmNvbW1hbmQgc3VibWlzc2lvbi4gSG93ZXZlciBJIGRvbid0
IHRoaW5rIHdlJ3ZlIGhhZCBhbnkgcHJvYmxlbXMgd2l0aAp0aGlzIGJlaW5nIG91ciBzbG93IHBh
dGggeWV0LCBidXQgdGhpcyBtYXkgY2hhbmdlIGluIHRoZSBmdXR1cmUuCgpEYXZlLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
