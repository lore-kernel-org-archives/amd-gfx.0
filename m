From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 02/13] amdgpu: don't initialize range->list in
 amdgpu_hmm_init_range
Date: Wed, 31 Jul 2019 13:25:06 +0000
Message-ID: <a4586f5c-0ae4-8cbd-65ff-dfe70d34f99b@amd.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-3-hch@lst.de>
Content-Language: en-US
Content-ID: <5232542593C7E848A01B5283F83332DC@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wNy0zMCAxOjUxIGEubS4sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGUg
bGlzdCBpcyB1c2VkIHRvIGFkZCB0aGUgcmFuZ2UgdG8gYW5vdGhlciBsaXN0IGFzIGFuIGVudHJ5
IGluIHRoZQ0KPiBjb3JlIGhtbSBjb2RlLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIGluaXRpYWxp
emUgaXQgaW4gYSBkcml2ZXIuDQoNCkkndmUgc2VlbiBjb2RlIHRoYXQgdXNlcyBsaXN0X2VtcHR5
IHRvIGNoZWNrIHdoZXRoZXIgYSBsaXN0IGhlYWQgaGFzIA0KYmVlbiBhZGRlZCB0byBhIGxpc3Qg
b3Igbm90LiBGb3IgdGhhdCB0byB3b3JrLCB0aGUgbGlzdCBoZWFkIG5lZWRzIHRvIGJlIA0KaW5p
dGlhbGl6ZWQsIGFuZCBpdCBoYXMgdG8gYmUgcmVtb3ZlZCB3aXRoIGxpc3RfZGVsX2luaXQuIElm
IEhNTSBkb2Vzbid0IA0KZXZlciBkbyB0aGF0IHdpdGggcmFuZ2UtPmxpc3QsIHRoZW4gdGhpcyBw
YXRjaCBpcyBSZXZpZXdlZC1ieTogRmVsaXggDQpLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uYyB8
IDEgLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5jDQo+IGluZGV4IGI2OThiNDIzYjI1ZC4uNjBiOWZjOTU2
MWQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4u
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uYw0KPiBAQCAt
NDg0LDYgKzQ4NCw1IEBAIHZvaWQgYW1kZ3B1X2htbV9pbml0X3JhbmdlKHN0cnVjdCBobW1fcmFu
Z2UgKnJhbmdlKQ0KPiAgIAkJcmFuZ2UtPmZsYWdzID0gaG1tX3JhbmdlX2ZsYWdzOw0KPiAgIAkJ
cmFuZ2UtPnZhbHVlcyA9IGhtbV9yYW5nZV92YWx1ZXM7DQo+ICAgCQlyYW5nZS0+cGZuX3NoaWZ0
ID0gUEFHRV9TSElGVDsNCj4gLQkJSU5JVF9MSVNUX0hFQUQoJnJhbmdlLT5saXN0KTsNCj4gICAJ
fQ0KPiAgIH0NCg==
