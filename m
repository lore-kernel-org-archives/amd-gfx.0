From: "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH] mm/hmm: hmm_range_fault handle pages swapped out
Date: Fri, 16 Aug 2019 16:02:30 +0000
Message-ID: <6a694960-51c8-532c-6dfd-f3479d680510@amd.com>
References: <20190815205227.7949-1-Philip.Yang@amd.com>
 <20190816005429.GD9929@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190816005429.GD9929@mellanox.com>
Content-Language: en-US
Content-ID: <E92A600FBFA46949A579DE30B5045F72@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jason Gunthorpe <jgg@mellanox.com>, Ralph Campbell <rcampbell@nvidia.com>
Cc: "alex.deucher@amd.com" <alex.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "jglisse@redhat.com" <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

DQoNCk9uIDIwMTktMDgtMTUgODo1NCBwLm0uLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9u
IFRodSwgQXVnIDE1LCAyMDE5IGF0IDA4OjUyOjU2UE0gKzAwMDAsIFlhbmcsIFBoaWxpcCB3cm90
ZToNCj4+IGhtbV9yYW5nZV9mYXVsdCBtYXkgcmV0dXJuIE5VTEwgcGFnZXMgYmVjYXVzZSBzb21l
IG9mIHBmbnMgYXJlIGVxdWFsIHRvDQo+PiBITU1fUEZOX05PTkUuIFRoaXMgaGFwcGVucyByYW5k
b21seSB1bmRlciBtZW1vcnkgcHJlc3N1cmUuIFRoZSByZWFzb24gaXMNCj4+IGZvciBzd2FwcGVk
IG91dCBwYWdlIHB0ZSBwYXRoLCBobW1fdm1hX2hhbmRsZV9wdGUgZG9lc24ndCB1cGRhdGUgZmF1
bHQNCj4+IHZhcmlhYmxlIGZyb20gY3B1X2ZsYWdzLCBzbyBpdCBmYWlsZWQgdG8gY2FsbCBobW1f
dmFtX2RvX2ZhdWx0IHRvIHN3YXANCj4+IHRoZSBwYWdlIGluLg0KPj4NCj4+IFRoZSBmaXggaXMg
dG8gY2FsbCBobW1fcHRlX25lZWRfZmF1bHQgdG8gdXBkYXRlIGZhdWx0IHZhcmlhYmxlLg0KPiAN
Cj4+IENoYW5nZS1JZDogSTJlODYxMTQ4NTU2M2QxMWQ5Mzg4ODFjMThiNzkzNWZhMWU3YzkxZWUN
Cj4gDQo+IEknbGwgZml4IGl0IGZvciB5b3UgYnV0IHBsZWFzZSBiZSBjYXJlZnVsIG5vdCB0byBz
ZW5kIENoYW5nZS1pZCdzIHRvDQo+IHRoZSBwdWJsaWMgbGlzdHMuDQo+IA0KVGhhbmtzLCB0aGUg
Y2hhbmdlLWlkIHdhcyBhZGRlZCBieSBvdXIgR2Vycml0IGhvb2ssIEkgbmVlZCBnZW5lcmF0ZSAN
CnBhdGNoIGZpbGVzLCByZW1vdmUgY2hhbmdlLWlkIGxpbmUgYW5kIHRoZW4gc2VuZCBvdXQgbW9k
aWZpZWQgcGF0Y2ggDQpmaWxlcyBpbiBmdXR1cmUuDQoNCj4gQWxzbyB3aGF0IGlzIHRoZSBGaXhl
cyBsaW5lIGZvciB0aGlzPw0KPiANClRoaXMgZml4ZXMgdGhlIGlzc3VlIGZvdW5kIGJ5IHRoZSBp
bnRlcm5hbCByb2NydHN0LCB0aGUgDQpyb2NydHN0RnVuYy5NZW1vcnlfTWF4X01lbSBldmljdGVk
IHNvbWUgdXNlciBidWZmZXJzLCBhbmQgdGhlbiBmb2xsb3dpbmcgDQp0ZXN0IHJlc3RvcmUgdGhv
c2UgdXNlciBidWZmZXJzIGZhaWxlZCBiZWNhdXNlIHRoZSBidWZmZXJzIGFyZSBzd2FwcGVkIA0K
b3V0IGFuZCBhcHBsaWNhdGlvbiBkb2Vzbid0IHRvdWNoIHRoZSBidWZmZXJzIHRvIHN3YXAgaXQg
aW4uDQoNCj4+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29t
Pg0KPj4gICBtbS9obW0uYyB8IDMgKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykNCj4gDQo+IFJhbHBoIGhhcyBhbHNvIGJlZW4gbG9va2luZyBhdCB0aGlzIGFyZWEgYWxz
byBzbyBJJ2xsIGdpdmUgaGltIGEgYml0DQo+IHRvIGNoaW1lIGluLCBvdGhlcndpc2Ugd2l0aCBK
ZXJvbWUncyByZXZpZXcgdGhpcyBsb29rcyBPSyB0byBnbyB0bw0KPiBsaW51eC1uZXh0DQo+DQpP
aywgdGhhbmtzIGZvciBoZWxwaW5nIHB1c2ggdGhpcyB0byBobW0gYnJhbmNoIGF0IA0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmRtYS9yZG1hLmdpdA0K
DQo+IFRoYW5rcywNCj4gSmFzb24NCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWw=
