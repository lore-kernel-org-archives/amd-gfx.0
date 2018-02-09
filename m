From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: replace iova debugfs file with iomem
Date: Fri, 9 Feb 2018 15:56:15 +0100
Message-ID: <db481ed0-1c0a-1844-ffeb-4ebb445bf604@amd.com>
References: <20180202190948.2654-1-christian.koenig@amd.com>
 <20180202190948.2654-5-christian.koenig@amd.com>
 <9b2c3354-ea82-722d-a6d2-42e2cf1e6540@amd.com>
 <5f37bea8-a6a3-c879-e8ec-f24948647a3e@gmail.com>
 <d6176df1-81dd-1bd8-577d-f962960ab173@amd.com>
 <ae110a8d-b1a3-7ce3-6a0d-a5bb41c48952@amd.com>
 <bb5cd938-c9cc-5a72-a7e7-269c14d6dabb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <bb5cd938-c9cc-5a72-a7e7-269c14d6dabb@amd.com>
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
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDkuMDIuMjAxOCB1bSAxNTo1MSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAwOS8wMi8x
OCAwOToxMiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gTm8sIHRoZXJlIGlzIHNpbXBs
eSBubyBuZWVkIHRvIGluaXRpYWxpemUgdGhlIHN5c3RlbSBkb21haW4uIFdoYXQgYXJlIAo+PiB0
aGUgdmFsdWVzIG9mIHAtPm1hcHBpbmcgYW5kIGFkZXYtPm1tYW4uYmRldi5kZXZfbWFwcGluZyB3
aGVuIHRoZXkgCj4+IGRvbid0IG1hdGNoPyBNYXliZSB3ZSBhcmUgYWxsb2NhdGluZyBtZW1vcnkg
YmVmb3JlIGluaXRpYWxpemluZyAKPj4gYWRldi0+bW1hbi5iZGV2LmRldl9tYXBwaW5nLgo+Cj4g
SW4gbXkgdGVzdCBzZXR1cCBJJ20gcnVubmluZyB0ZXN0IDMgZnJvbSBsaWJkcm0gKHN1aXRlIDEp
IHdpdGggYSBwYXVzZSAKPiBiZWZvcmUgdGhlIHVubWFwL2ZyZWUgY2FsbC7CoCBTbyB0aGUgSUIg
c2hvdWxkIHN0aWxsIGJlIG1hcHBlZC7CoCBJbmRlZWQgCj4gdGhlIFZNIFBURSBkZWNvZGluZyBo
YXMgdGhlIFYgYml0IHNldC4KPgo+PiBPciBkbyB5b3UgaGF2ZSBtb3JlIHRoYW4gb25lIEdQVSBp
biB0aGUgc3lzdGVtPyBFLmcuIEFQVStkR1BVPyBDb3VsZCAKPj4gaXQgYmUgdGhhdCB5b3UgcmVh
ZCB0aHJvdWdoIHRoZSB3cm9uZyBkZXZpY2U/Cj4KPiBJIGZvdW5kIHRoZSBpc3N1ZToKPgo+IMKg
wqDCoMKgd2hpbGUgKHNpemUpIHsKPiDCoMKgwqDCoMKgwqDCoCBwaHlzX2FkZHJfdCBhZGRyID0g
KnBvcyAmIFBBR0VfTUFTSzsKPiDCoMKgwqDCoMKgwqDCoCBsb2ZmX3Qgb2ZmID0gKnBvcyAmIH5Q
QUdFX01BU0s7Cj4gwqDCoMKgwqDCoMKgwqAgc2l6ZV90IGJ5dGVzID0gUEFHRV9TSVpFIC0gb2Zm
Owo+Cj4gImJ5dGVzIiBzaG91bGQgYmUgbGltaXRlZCBieSB0aGUgJ3NpemUnIHBhcmFtZXRlciBw
YXNzZWQgaW4uwqAgV2hhdCBpcyAKPiBoYXBwZW5pbmcgaW5zdGVhZCBpcyBpdCdzIHJlYWRpbmcg
dGhlIGVudGlyZSBQVEIgdW50aWwgaXQgaGl0cyBhIFY9MCAKPiBwYWdlIGFuZCB0aGVuIHJldHVy
bnMgYW4gZXJyb3IgYW5kIGluIHRoZSBwcm9jZXNzIGlzIGRvaW5nICJmdW4gCj4gdGhpbmdzIiB0
byB0aGUgdXNlciBtb2RlIGFwcGxpY2F0aW9uIChieSBjb3B5aW5nIG1vcmUgZGF0YSB0aGFuIEkg
Cj4gYXNrZWQgZm9yKS4KCkFoLCBvYnZpb3VzIHByb2JsZW0uCgpEbyB5b3Ugd2FudCB0byBmaXgg
aXQgb3Igc2hvdWxkIEkgdGFrZSBhIGxvb2s/IFlvdSB3YW50ZWQgdG8gYWRkIHdyaXRlIApzdXBw
b3J0IGFzIHdlbGwgYW55d2F5IElJUkMuCgpJJ3ZlIGp1c3QgcHVzaGVkIHRoZSBmaXJzdCB0aHJl
ZSBwYXRjaGVzIGZyb20gdGhhdCBzZXJpZXMgdG8gCmFtZC1zdGFnaW5nLWRybS1uZXh0LgoKVGhh
bmtzIGZvciB0ZXN0aW5nLApDaHJpc3RpYW4uCgo+Cj4KPiBUb20KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
