From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/ttm: split BO structure initialization into a
 separate function
Date: Wed, 15 Feb 2017 14:54:33 +0100
Message-ID: <ebfcc8e0-794b-6f90-1584-ff35e7ea9591@amd.com>
References: <20170214103744.4133-1-nhaehnle@gmail.com>
 <b9c665fe-4e9a-7163-aa8a-0c9ce73a78a0@vodafone.de>
 <9229e0d9-4e9d-0233-4ba2-c54c7192acfa@amd.com>
 <f43631b3-2527-54c1-d0bc-98460772b77b@vodafone.de>
 <06a90674-9f46-e646-9893-8b2748ddd9e4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <06a90674-9f46-e646-9893-8b2748ddd9e4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTUuMDIuMjAxNyAxNDozNSwgTmljb2xhaSBIw6RobmxlIHdyb3RlOgo+IE9uIDE0LjAyLjIw
MTcgMTM6NTEsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE0LjAyLjIwMTcgdW0gMTM6
MDAgc2NocmllYiBOaWNvbGFpIEjDpGhubGU6Cj4+PiBPbiAxNC4wMi4yMDE3IDExOjQ5LCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDE0LjAyLjIwMTcgdW0gMTE6Mzcgc2NocmllYiBO
aWNvbGFpIEjDpGhubGU6Cj4+Pj4+IEZyb206IE5pY29sYWkgSMOkaG5sZSA8bmljb2xhaS5oYWVo
bmxlQGFtZC5jb20+Cj4+Pj4+Cj4+Pj4+IEFsbG93IGNhbGxlcnMgdG8gb3B0IG91dCBvZiBjYWxs
aW5nIHR0bV9ib192YWxpZGF0ZSBpbW1lZGlhdGVseS4gVGhpcwo+Pj4+PiBhbGxvd3MgbW9yZSBm
bGV4aWJpbGl0eSBpbiBob3cgbG9ja2luZyBvZiB0aGUgcmVzZXJ2YXRpb24gb2JqZWN0IGlzCj4+
Pj4+IGRvbmUsIHdoaWNoIGlzIG5lZWRlZCB0byBmaXggYSBsb2NraW5nIGJ1ZyAoZGVzdHJveSBs
b2NrZWQgbXV0ZXgpCj4+Pj4+IGluIGFtZGdwdS4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTog
Tmljb2xhaSBIw6RobmxlIDxuaWNvbGFpLmhhZWhubGVAYW1kLmNvbT4KPj4+Pgo+Pj4+IFBsZWFz
ZSBzcXVhc2ggdGhhdCBpbnRvIHlvdXIgb3RoZXIgcGF0Y2guIEl0IGZpeGVzIGFub3RoZXIgYnVn
LCBidXQgSQo+Pj4+IGRvbid0IHRoaW5rIGZpeGluZyBvbmUgYnVnIGp1c3QgdG8gcnVuIGludG8g
YW5vdGhlciBpcyByZWFsbHkgYSBnb29kCj4+Pj4gaWRlYS4KPj4+Cj4+PiBJIGRvbid0IHVuZGVy
c3RhbmQuIEknbSBub3QgYXdhcmUgdGhhdCB0aGlzIHBhdGNoIGZpeGVzIGFueXRoaW5nLCBpdAo+
Pj4ganVzdCBlbmFibGVzIHRoZSBzdWJzZXF1ZW50IGZpeCBpbiBhbWRncHUgaW4gcGF0Y2ggIzIu
IEkgZG9uJ3QgdGhpbmsKPj4+IHNxdWFzaGluZyB0aG9zZSB0b2dldGhlciBpcyBhIGdvb2QgaWRl
YSAob25lIGlzIGluIHR0bSwgdGhlIG90aGVyIGluCj4+PiBhbWRncHUpLgo+Pgo+PiBPaywgZm9y
Z2V0IGl0IEkndmUgbWVzc2VkIHVwIHRoZSBkaWZmZXJlbnQgcmVmZXJlbmNlIGNvdW50Lgo+Pgo+
PiBXaXRoIGF0IGxlYXN0IGluaXRpYWxpemluZyBiby0+a3JlZiBhbmQgYm8tPmRlc3Ryb3kgYmVm
b3JlIHJldHVybmluZyB0aGUKPj4gZmlyc3QgZXJyb3IgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnCj4+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lgo+Cj4gVGhh
bmtzLiBEb2VzIHRoaXMgYXBwbHkgdG8gcGF0Y2hlcyAjMiBhbmQgIzMgYXMgd2VsbD8KCldlbGws
IHRoZXJlJ3Mgc29tZSBtaW5vciBuZWNlc3NhcnkgcmViYXNlIGZpeGVzLCBzbyBJJ2xsIHByb2Jh
Ymx5IGp1c3QgCnNlbmQgb3V0IGEgbmV3IHZlcnNpb24gb25jZSBJIGdvdCB0byB0ZXN0IGl0LgoK
Tmljb2xhaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
