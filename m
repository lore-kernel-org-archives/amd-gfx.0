From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Wed, 28 Jun 2017 10:00:25 +0800
Message-ID: <59530DB9.4000901@amd.com>
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
 <5950CFA0.90906@amd.com>
 <CAPM=9tw-E39oQ1gRPJs3oZBniALzgoa53ErF-trgxiN8Z9xyww@mail.gmail.com>
 <CAP+8YyGouX0AeBxj+UNmb1Q7iwAzt0Z_hx__hf1Bb=YqC55J_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAP+8YyGouX0AeBxj+UNmb1Q7iwAzt0Z_hx__hf1Bb=YqC55J_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, axie <axie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Xie,
 AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

CgpPbiAyMDE35bm0MDbmnIgyOOaXpSAwNDo1MCwgQmFzIE5pZXV3ZW5odWl6ZW4gd3JvdGU6Cj4g
T24gVHVlLCBKdW4gMjcsIDIwMTcgYXQgMTA6NDAgUE0sIERhdmUgQWlybGllIDxhaXJsaWVkQGdt
YWlsLmNvbT4gd3JvdGU6Cj4+IE9uIDI2IEp1bmUgMjAxNyBhdCAxOToxMCwgemhvdWNtMSA8ZGF2
aWQxLnpob3VAYW1kLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gT24gMjAxN+W5tDA25pyIMjbml6UgMDM6
NDgsIERhdmUgQWlybGllIHdyb3RlOgo+Pj4+PiBEbyB5b3Ugbm90IHVzZSBibyBsaXN0IGF0IGFs
bCBpbiBtZXNhPyByYWR2IGFzIHdlbGw/Cj4+Pj4gQ3VycmVudGx5IHJhZHYgaXMgY3JlYXRpbmcg
YSBibyBsaXN0IHBlciBjb21tYW5kIHN1Ym1pc3Npb24uIHJhZHYgZG9lcwo+Pj4+IG5vdCB1c2Ug
YW4gb2ZmbG9hZCB0aHJlYWQgdG8gZG8gY29tbWFuZCBzdWJtaXNzaW9uLCBhcyBpdCBzZWVtcyBw
cmV0dHkKPj4+PiB1bi12dWxrYW4gdG8gdXNlIGEgdGhyZWFkIGZvciB0aGUgcXVldWUgc3VibWlz
c2lvbiB0aHJlYWQgdGhlIGdhbWUKPj4+PiB1c2VzLgo+Pj4+Cj4+Pj4gSSBoYXZlIGNvbnNpZGVy
ZWQgaW52ZXN0aWdhdGluZyB0aGlzLCBidXQgd2l0aCB2dWxrYW4gaXQncyBwcm9iYWJseQo+Pj4+
IG9wdGltaXNpbmcgZm9yIHRoZSBzaW5nbGUgdGhyZWFkZWQgY2FzZSB3aGljaCBpc24ndCB3aGVy
ZSBhcHBzIHNob3VsZAo+Pj4+IHJlYWxseSBiZS4KPj4+Pgo+Pj4+IEF0IHRoZSBtb21lbnQgd2Ug
cmVnZW5lcmF0ZSB0aGUgYm8gbGlzdCBvbiBldmVyeSBDUyBpb2N0bCwgd2UgcHJvYmFibHkKPj4+
PiBjYW4gZG8gYSBsb3QgYmV0dGVyLCBJIGtub3cgQmFzIGhhcyBsb29rZWQgaW50byB0aGlzIGFy
ZWEgYSBiaXQgbW9yZQo+Pj4+IHRoYW4gSS4KPj4+IFRoYW5rcyBEYXZlIGZvciBpbnB1dHRpbmcu
Cj4+Pgo+Pj4gQ291bGQgSSBhc2sgbW9yZSBhYm91dCByYWR2PyBIb3cgZG9lcyByYWR2IG1ha2Ug
Ym8gbGlzdCBmb3IgZXZlcnkgY3MgaW9jdGw/Cj4+PiBBZGRpbmcgZmlsdGVyIGluIGV2ZXJ5IG9w
ZXJhdGlvbiwgYW55IHJlbGF0ZWQgYm8gd2lsbCBiZSBhZGQgdG8gYm8gbGlzdAo+Pj4gZHVyaW5n
IG1ha2UgY29tbWFuZCBzdWJtaXNzaW9uPwo+PiBXaGVuIHdlIGNyZWF0ZSBjb21tYW5kIGJ1ZmZl
cnMgd2UgYWRkIGVhY2ggYm8gdG8gYSBsaXN0IGZvciBpdCwgYnV0IHdlCj4+IGRvbid0IGNhbGwg
dGhlIGtlcm5lbCBpb2N0bC4KPj4KPj4gV2hlbiB3ZSBnZXQgYSBRdWV1ZVN1Ym1pdCwgd2UgdXN1
YWxseSBzdWJtaXQgdHdvIElCcyB0byB0aGUga2VybmVsLAo+PiBvbmUgd2l0aCBzb21lIGNhY2hl
IGZsdXNoZXMgYW5kIG9uZSB3aXRoIHRoZSBtYWluIElCIGluIGl0LCBob3dldmVyIGFzCj4+IHdl
IGhhdmUgdG8gZ2l2ZSB0aGUga2VybmVsIG9uZSBibyBsaXN0IHdlIGhhdmUgdG8gY29tYmluZSB0
aGUgdHdvCj4+IGxpc3RzIChldmVuIGlmIHRoZSBjYWNoZSBmbHVzaCBsaXN0IG9ubHkgaGFzIG9u
ZSBpYiBpbiBpdCwgaXRzZWxmKSwgc28KPj4gd2UgY2FuJ3QgY2FsbCBjcmVhdGUgYm8gbGlzdCBl
YXJseSwgd2UgaGF2ZSB0byBkbyBpdCBqdXN0IGJlZm9yZQo+PiBjb21tYW5kIHN1Ym1pc3Npb24u
IEhvd2V2ZXIgSSBkb24ndCB0aGluayB3ZSd2ZSBoYWQgYW55IHByb2JsZW1zIHdpdGgKPj4gdGhp
cyBiZWluZyBvdXIgc2xvdyBwYXRoIHlldCwgYnV0IHRoaXMgbWF5IGNoYW5nZSBpbiB0aGUgZnV0
dXJlLgo+IFllYWguIElJUkMgdGhlIGJvIGxpc3QgY3JlYXRlIGlzIHR5cGljYWxseSA8IDEwJSBv
ZiBvdXIga2VybmVsIHRpbWUgZm9yIHJhZHYuCgpUaGFua3MgYSBsb3QgZm9yIGFsbCB5b3VyIGlu
cHV0LgoKUmVnYXJkcywKRGF2aWQgWmhvdQo+PiBEYXZlLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
