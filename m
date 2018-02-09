From: Tom St Denis <tom.stdenis@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: replace iova debugfs file with iomem
Date: Fri, 9 Feb 2018 11:23:11 -0500
Message-ID: <dc8de536-fa18-1c68-dfa4-9af9bf4ed693@amd.com>
References: <20180202190948.2654-1-christian.koenig@amd.com>
 <20180202190948.2654-5-christian.koenig@amd.com>
 <9b2c3354-ea82-722d-a6d2-42e2cf1e6540@amd.com>
 <5f37bea8-a6a3-c879-e8ec-f24948647a3e@gmail.com>
 <d6176df1-81dd-1bd8-577d-f962960ab173@amd.com>
 <ae110a8d-b1a3-7ce3-6a0d-a5bb41c48952@amd.com>
 <bb5cd938-c9cc-5a72-a7e7-269c14d6dabb@amd.com>
 <db481ed0-1c0a-1844-ffeb-4ebb445bf604@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <db481ed0-1c0a-1844-ffeb-4ebb445bf604@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMDkvMDIvMTggMDk6NTYgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDkuMDIu
MjAxOCB1bSAxNTo1MSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4gT24gMDkvMDIvMTggMDk6MTIg
QU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBObywgdGhlcmUgaXMgc2ltcGx5IG5vIG5l
ZWQgdG8gaW5pdGlhbGl6ZSB0aGUgc3lzdGVtIGRvbWFpbi4gV2hhdCBhcmUgCj4+PiB0aGUgdmFs
dWVzIG9mIHAtPm1hcHBpbmcgYW5kIGFkZXYtPm1tYW4uYmRldi5kZXZfbWFwcGluZyB3aGVuIHRo
ZXkgCj4+PiBkb24ndCBtYXRjaD8gTWF5YmUgd2UgYXJlIGFsbG9jYXRpbmcgbWVtb3J5IGJlZm9y
ZSBpbml0aWFsaXppbmcgCj4+PiBhZGV2LT5tbWFuLmJkZXYuZGV2X21hcHBpbmcuCj4+Cj4+IElu
IG15IHRlc3Qgc2V0dXAgSSdtIHJ1bm5pbmcgdGVzdCAzIGZyb20gbGliZHJtIChzdWl0ZSAxKSB3
aXRoIGEgcGF1c2UgCj4+IGJlZm9yZSB0aGUgdW5tYXAvZnJlZSBjYWxsLsKgIFNvIHRoZSBJQiBz
aG91bGQgc3RpbGwgYmUgbWFwcGVkLsKgIEluZGVlZCAKPj4gdGhlIFZNIFBURSBkZWNvZGluZyBo
YXMgdGhlIFYgYml0IHNldC4KPj4KPj4+IE9yIGRvIHlvdSBoYXZlIG1vcmUgdGhhbiBvbmUgR1BV
IGluIHRoZSBzeXN0ZW0/IEUuZy4gQVBVK2RHUFU/IENvdWxkIAo+Pj4gaXQgYmUgdGhhdCB5b3Ug
cmVhZCB0aHJvdWdoIHRoZSB3cm9uZyBkZXZpY2U/Cj4+Cj4+IEkgZm91bmQgdGhlIGlzc3VlOgo+
Pgo+PiDCoMKgwqDCoHdoaWxlIChzaXplKSB7Cj4+IMKgwqDCoMKgwqDCoMKgIHBoeXNfYWRkcl90
IGFkZHIgPSAqcG9zICYgUEFHRV9NQVNLOwo+PiDCoMKgwqDCoMKgwqDCoCBsb2ZmX3Qgb2ZmID0g
KnBvcyAmIH5QQUdFX01BU0s7Cj4+IMKgwqDCoMKgwqDCoMKgIHNpemVfdCBieXRlcyA9IFBBR0Vf
U0laRSAtIG9mZjsKPj4KPj4gImJ5dGVzIiBzaG91bGQgYmUgbGltaXRlZCBieSB0aGUgJ3NpemUn
IHBhcmFtZXRlciBwYXNzZWQgaW4uwqAgV2hhdCBpcyAKPj4gaGFwcGVuaW5nIGluc3RlYWQgaXMg
aXQncyByZWFkaW5nIHRoZSBlbnRpcmUgUFRCIHVudGlsIGl0IGhpdHMgYSBWPTAgCj4+IHBhZ2Ug
YW5kIHRoZW4gcmV0dXJucyBhbiBlcnJvciBhbmQgaW4gdGhlIHByb2Nlc3MgaXMgZG9pbmcgImZ1
biAKPj4gdGhpbmdzIiB0byB0aGUgdXNlciBtb2RlIGFwcGxpY2F0aW9uIChieSBjb3B5aW5nIG1v
cmUgZGF0YSB0aGFuIEkgCj4+IGFza2VkIGZvcikuCj4gCj4gQWgsIG9idmlvdXMgcHJvYmxlbS4K
PiAKPiBEbyB5b3Ugd2FudCB0byBmaXggaXQgb3Igc2hvdWxkIEkgdGFrZSBhIGxvb2s/IFlvdSB3
YW50ZWQgdG8gYWRkIHdyaXRlIAo+IHN1cHBvcnQgYXMgd2VsbCBhbnl3YXkgSUlSQy4KCll1cCwg
SSBjYW4gdGFja2xlIHRoaXMgdGhpcyBhZnRlcm5vb24uCgpJJ2xsIHRha2UgeW91ciByZWFkIG9u
bHkgcGF0Y2ggYW5kIG1ha2UgaXQgZG8gYm90aCByZWFkL3dyaXRlIChhbmQgZml4IAp0aGUgbWlu
b3IgZXJyb3IpLgoKVG9tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
