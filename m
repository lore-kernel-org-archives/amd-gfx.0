From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH libdrm 0/4] Dynamicly disable suites and tets.
Date: Mon, 13 Nov 2017 12:32:10 +0100
Message-ID: <7a5b2721-5938-c865-27b0-47dae1ad5883@daenzer.net>
References: <1510288203-21716-1-git-send-email-andrey.grodzovsky@amd.com>
 <fbf19682-a259-4105-7f4b-193524fe2dae@amd.com>
 <407f0a79-e15b-61b7-2e3a-8f4b680c9c6c@amd.com>
 <ebac16f5-4d16-d6e9-8bc0-5ee0de061719@amd.com>
 <58c5d164-078d-74cc-b3ab-07bf6d39287c@amd.com>
 <1245c92c-bfc4-d343-c752-17fa036e1bad@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1245c92c-bfc4-d343-c752-17fa036e1bad@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMTIvMTEvMTcgMTA6MzUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQSBmZXcgY29t
bWVudHMgb24gdGhlIGNvZGU6Cj4gCj4+ICsvKiBWYWxpZGF0ZSBibyBzaXplIGlzIGJpdCBiaWdn
ZXIgdGhlbiB0aGUgcmVxdWVzdCBkb21haW4gKi8KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBhbWRn
cHVfYm9fdmFsaWRhdGVfYm9fc2l6ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+PiAqYWRldiwKPj4g
K8KgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqAgdW5zaWduZWQgbG9uZyBzaXpl
LCB1MzIgZG9tYWluKQo+IERyb3AgdGhlIGlubGluZSBrZXl3b3JkIGFuZCB0aGUgc2Vjb25kIF9i
b18gaW4gdGhlIG5hbWUgaGVyZS4KPiAKPj4gK3sKPj4gK8KgwqAgwqBzdHJ1Y3QgdHRtX21lbV90
eXBlX21hbmFnZXIgKm1hbiA9IE5VTEw7Cj4+ICsKPj4gK8KgwqAgwqBpZiAoZG9tYWluICYgQU1E
R1BVX0dFTV9ET01BSU5fVlJBTSkgewo+PiArwqDCoCDCoMKgwqAgwqBtYW4gPSAmYWRldi0+bW1h
bi5iZGV2Lm1hbltUVE1fUExfVlJBTV07Cj4+ICsKPj4gK8KgwqAgwqDCoMKgIMKgaWYgKG1hbiAm
JiBzaXplIDwgKG1hbi0+c2l6ZSA8PCBQQUdFX1NISUZUKSkKPiAKPiBEcm9wIHRoZSBleHRyYSBj
aGVjayB0aGF0IG1hbiBpcyBub3QgTlVMTC4gV2UgZ2V0IHRoZSBwb2ludGVyIHRvIGFuCj4gYXJy
YXkgZWxlbWVudCwgdGhhdCBjYW4ndCBiZSBOVUxMLgo+IAo+PiArwqDCoCDCoMKgwqAgwqDCoMKg
IMKgcmV0dXJuIHRydWU7Cj4gTWhtLCBkb21haW4gaXMgYSBiaXRtYXNrIG9mIGFsbG93ZWQgZG9t
YWlucy4KPiAKPiBTbyB3ZSBzaG91bGQgY2hlY2sgYWxsIHZhbGlkIGRvbWFpbnMgaWYgdGhlIHNp
emUgZml0LCBub3QganVzdCB0aGUgZmlyc3QKPiBvbmUuCgpBc3N1bWluZyBWUkFNIDwtPiBzeXN0
ZW0gbWlncmF0aW9uIG9mIEJPcyBsYXJnZXIgdGhhbiB0aGUgR1RUIGRvbWFpbgp3b3JrcywgSSdk
IHNheSB3ZSBzaG91bGQgb25seSByZXF1aXJlIHRoYXQgdGhlIEJPIGNhbiBmaXQgaW4gYW55IG9m
IHRoZQphbGxvd2VkIGRvbWFpbnMuIE90aGVyd2lzZSBpdCBtdXN0IGFsc28gYWx3YXlzIGZpdCBp
biBHVFQuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAg
ICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
