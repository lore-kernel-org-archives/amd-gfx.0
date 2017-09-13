From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Change vram debugfs to NO_KIQ for VM
 environments
Date: Wed, 13 Sep 2017 15:14:33 -0400
Message-ID: <d4125c48-e280-db5c-507f-a1d1ba8bd856@amd.com>
References: <20170913163829.14248-1-tom.stdenis@amd.com>
 <BN6PR12MB1652385B5D4D403E8F4532F3F76E0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <6f02d915-9b5f-7345-5d3a-e12603e02853@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6f02d915-9b5f-7345-5d3a-e12603e02853-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTMvMDkvMTcgMDI6NDcgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTMuMDku
MjAxNyB1bSAxODo0NyBzY2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoKPj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tCj4+PiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1kLWdmeC1ib3VuY2Vz
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmCj4+PiBPZiBUb20gU3QgRGVuaXMKPj4+
IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDE3IDEyOjM4IFBNCj4+PiBUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IENjOiBTdERlbmlzLCBUb20KPj4+IFN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IENoYW5nZSB2cmFtIGRlYnVnZnMgdG8gTk9fS0lR
IGZvcgo+Pj4gVk0gZW52aXJvbm1lbnRzCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogVG9tIFN0IERl
bmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+PiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IAo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gCj4gQlRXOiBUaGVyZSBhcmUgYW5vdGhl
ciBpbnN0YW5jZSBpbiBhbWRncHVfdHRtX2FjY2Vzc19tZW1vcnkoKSB3aGljaCAKPiBuZWVkcyB0
byBiZSBmaXhlZCBhcyB3ZWxsLgo+IAo+IE1pZ2h0IGJlIGEgZ29vZCBpZGVhIHRvIHNlcGFyYXRl
IHRoYXQgaW50byAKPiBhbWRncHVfdnJhbV9yZWFkL2FtZGdwdV92cmFtX3dyaXRlIGZ1bmN0aW9u
cyBhcyB3ZWxsLgoKClN1cmUgSSdsbCBjcmFmdCBzb21ldGhpbmcgdXAgdXBvbiB0aGUgbW9ycm93
LgoKQ2hlZXJzLApUb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
