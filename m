From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/7] drm/ttm: user reservation object wrappers
Date: Thu, 9 Nov 2017 18:13:34 +0100
Message-ID: <a1a67543-30e4-9d09-e587-1d95f5f34593@gmail.com>
References: <20171109085909.1653-1-christian.koenig@amd.com>
 <20171109085909.1653-4-christian.koenig@amd.com>
 <93f5f720-2de8-ce5c-2b4e-946f6e21bd90@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <93f5f720-2de8-ce5c-2b4e-946f6e21bd90-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Hongbo.He-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDkuMTEuMjAxNyB1bSAxNzo1MCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDA5LzEx
LzE3IDA5OjU5IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBDb25zaXN0ZW50bHkgdXNl
IHRoZSByZXNlcnZhdGlvbiBvYmplY3Qgd3JhcHBlcnMgaW5zdGVhZCBvZiBhY2Nlc3NpbmcKPj4g
dGhlIHd3X211dGV4IGRpcmVjdGx5Lgo+Pgo+PiBBZGRpdGlvbmFsIHRvIHRoYXQgdXNlIHRoZSBy
ZXNlcnZhdGlvbiBvYmplY3Qgd3JhcHBlcnMgZGlyZWN0bHkgaW5zdGVhZCBvZgo+PiBjYWxsaW5n
IF9fdHRtX2JvX3Jlc2VydmUgd2l0aCBmaXhlZCBwYXJhbWV0ZXJzLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gWy4uLl0K
Pgo+PiBAQCAtMTgyMyw3ICsxODIzLDkgQEAgaW50IHR0bV9ib193YWl0X3VucmVzZXJ2ZWQoc3Ry
dWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykKPj4gICAJCXJldHVybiAtRVJFU1RBUlRTWVM7Cj4+
ICAgCWlmICghd3dfbXV0ZXhfaXNfbG9ja2VkKCZiby0+cmVzdi0+bG9jaykpCj4+ICAgCQlnb3Rv
IG91dF91bmxvY2s7Cj4+IC0JcmV0ID0gX190dG1fYm9fcmVzZXJ2ZShibywgdHJ1ZSwgZmFsc2Us
IE5VTEwpOwo+PiArCXJldCA9IHJlc2VydmF0aW9uX29iamVjdF9sb2NrX2ludGVycnVwdGlibGUo
Ym8tPnJlc3YsIE5VTEwpOwo+PiArCWlmIChyZXQgPSAtRUlOVFIpCj4+ICsJCXJldCA9IC1FUkVT
VEFSVFNZUzsKPiBUeXBvIGluIHRoZSB0ZXN0LCBtdXN0IGJlCj4KPiAgICAgIGlmIChyZXQgPT0g
LUVJTlRSKQo+Cj4KPiBUaGlzIGJ1ZyBjYXVzZWQgdGhlIFhvcmcgcHJvY2VzcyB0byBoYW5nIGZv
ciBtZSB3aGVuIHRyeWluZyB0byBydW4KPiBnbHhnZWFycywgcmVxdWlyaW5nIGEgaGFyZCByZWJv
b3QuIERpZCB5b3UgYWNjaWRlbnRhbGx5IHNlbmQgYW4gdW50ZXN0ZWQKPiB2ZXJzaW9uIG9mIHRo
aXMgcGF0Y2g/ClllYWgsIGp1c3Qgc3R1bWJsZWQgb3ZlciB0aGlzIGFzIHdlbGwuIEkgYWNjaWRl
bnRhbGx5IG1lcmdlZCB0aGUgZml4IGZvciAKdGhpcyBpbnRvIGEgbGF0ZXIgcGF0Y2ggd2hpY2gg
SSBkaWRuJ3Qgc2VuZCBvdXQgeWV0LgoKQ29uc2lkZXIgaXQgZml4ZWQsCkNocmlzdGlhbi4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
