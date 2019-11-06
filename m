From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 01/15] mm/mmu_notifier: define the header
 pre-processor parts even if disabled
Date: Wed, 6 Nov 2019 13:36:10 +0000
Message-ID: <20191106133606.GC22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-2-jgg@ziepe.ca>
 <770248ae-efa1-efae-a978-f52d8510f7b1@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <770248ae-efa1-efae-a978-f52d8510f7b1@nvidia.com>
Content-Language: en-US
Content-ID: <79E66DC5C25B0D4EBC7ECCB2D81D0009@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Dennis Dalessandro <dennis.dalessandro@intel.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@ora>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBOb3YgMDUsIDIwMTkgYXQgMDE6MjM6NDZQTSAtMDgwMCwgSm9obiBIdWJiYXJkIHdy
b3RlOg0KPiBPbiAxMC8yOC8xOSAxOjEwIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4g
RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPg0KPiA+IA0KPiA+IE5vdyB0
aGF0IHdlIGhhdmUgS0VSTkVMX0hFQURFUl9URVNUIGFsbCBoZWFkZXJzIGFyZSBnZW5lcmFsbHkg
Y29tcGlsZQ0KPiA+IHRlc3RlZCwgc28gcmVseWluZyBvbiBtYWtlZmlsZSB0cmlja3MgdG8gYXZv
aWQgY29tcGlsaW5nIGNvZGUgdGhhdCBkZXBlbmRzDQo+ID4gb24gQ09ORklHX01NVV9OT1RJRklF
UiBpcyBtb3JlIGFubm95aW5nLg0KPiA+IA0KPiA+IEluc3RlYWQgZm9sbG93IHRoZSB1c3VhbCBw
YXR0ZXJuIGFuZCBwcm92aWRlIG1vc3Qgb2YgdGhlIGhlYWRlciB3aXRoIG9ubHkNCj4gPiB0aGUg
ZnVuY3Rpb25zIHN0dWJiZWQgb3V0IHdoZW4gQ09ORklHX01NVV9OT1RJRklFUiBpcyBkaXNhYmxl
ZC4gVGhpcw0KPiA+IGVuc3VyZXMgY29kZSBjb21waWxlcyBubyBtYXR0ZXIgd2hhdCB0aGUgY29u
ZmlnIHNldHRpbmcgaXMuDQo+ID4gDQo+ID4gV2hpbGUgaGVyZSwgc3RydWN0IG1tdV9ub3RpZmll
cl9tbSBpcyBwcml2YXRlIHRvIG1tdV9ub3RpZmllci5jLCBtb3ZlIGl0Lg0KPiANCj4gYW5kIGNv
cnJlY3QgYSBtaW5vciBzcGVsbGluZyBlcnJvciBpbiBhIGNvbW1lbnQuIEdvb2QuIDopDQo+IA0K
PiA+IA0KPiA+IFJldmlld2VkLWJ5OiBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+
DQo+ID4gIGluY2x1ZGUvbGludXgvbW11X25vdGlmaWVyLmggfCA0NiArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgbW0vbW11X25vdGlmaWVyLmMgICAgICAgICAgICB8
IDEzICsrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAy
OSBkZWxldGlvbnMoLSkNCj4gPiANCj4gDQo+IEJlY2F1c2UgdGhpcyBpcyBjb3JyZWN0IGFzLWlz
LCB5b3UgY2FuIGFkZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBKb2huIEh1YmJhcmQgPGpodWJiYXJk
QG52aWRpYS5jb20+DQo+IA0KDQpUaGFua3MNCg0KPiBkaWZmIC0tZ2l0IGEvbW0vbW11X25vdGlm
aWVyLmMgYi9tbS9tbXVfbm90aWZpZXIuYw0KPiBpbmRleCAyYjc0ODU5MTllY2YuLjEwN2Y5NDA2
YTkyZCAxMDA2NDQNCj4gKysrIGIvbW0vbW11X25vdGlmaWVyLmMNCj4gQEAgLTQ3LDYgKzQ3LDE2
IEBAIHN0cnVjdCBtbXVfbm90aWZpZXJfbW0gew0KPiAgICAgICAgIHN0cnVjdCBobGlzdF9oZWFk
IGRlZmVycmVkX2xpc3Q7DQo+ICB9Ow0KPiAgDQo+ICtpbnQgbW1faGFzX25vdGlmaWVycyhzdHJ1
Y3QgbW1fc3RydWN0ICptbSkNCj4gK3sNCj4gKyAgICAgICByZXR1cm4gdW5saWtlbHkobW0tPm1t
dV9ub3RpZmllcl9tbSk7DQo+ICt9DQoNClRoaXMgaW5saW5lIGlzIHBlcmZvcm1hbmNlIHNlbnNp
dGl2ZSwgaXQgbmVlZHMgdG8gc3RheSBpbmxpbmVkLi4NCg0KSmFzb24NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QK
WGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMueGVucHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
