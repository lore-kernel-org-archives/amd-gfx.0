From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: hmm cleanups, v2
Date: Wed, 7 Aug 2019 18:17:39 +0000
Message-ID: <20190807181733.GL1571@mellanox.com>
References: <20190806160554.14046-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
Content-Language: en-US
Content-ID: <B71F314D18668A44A07719FC1462D90A@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>
Cc: =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBdWcgMDYsIDIwMTkgYXQgMDc6MDU6MzhQTSArMDMwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6DQo+IA0KPiBIaSBKw6lyw7RtZSwgQmVuLCBGZWxpeCBhbmQgSmFzb24sDQo+IA0K
PiBiZWxvdyBpcyBhIHNlcmllcyBhZ2FpbnN0IHRoZSBobW0gdHJlZSB3aGljaCBjbGVhbnMgdXAg
dmFyaW91cyBtaW5vcg0KPiBiaXRzIGFuZCBhbGxvd3MgSE1NX01JUlJPUiB0byBiZSBidWlsdCBv
biBhbGwgYXJjaGl0ZWN0dXJlcy4NCj4gDQo+IERpZmZzdGF0Og0KPiANCj4gICAgIDExIGZpbGVz
IGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKyksIDIxMCBkZWxldGlvbnMoLSkNCj4gDQo+IEEgZ2l0
IHRyZWUgaXMgYWxzbyBhdmFpbGFibGUgYXQ6DQo+IA0KPiAgICAgZ2l0Oi8vZ2l0LmluZnJhZGVh
ZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0IGhtbS1jbGVhbnVwcy4yDQo+IA0KPiBHaXR3ZWI6DQo+
IA0KPiAgICAgaHR0cDovL2dpdC5pbmZyYWRlYWQub3JnL3VzZXJzL2hjaC9taXNjLmdpdC9zaG9y
dGxvZy9yZWZzL2hlYWRzL2htbS1jbGVhbnVwcy4yDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0K
PiAgLSBmaXggdGhlIGNvdmVyIGxldHRlciBzdWJqZWN0DQo+ICAtIGltcHJvdmUgdmFyaW91cyBw
YXRjaCBkZXNjcmlwdGlvbnMNCj4gIC0gdXNlIHN2bW0tPm1tIGluIG5vdXZlYXVfcmFuZ2VfZmF1
bHQNCj4gIC0gaW52ZXJzZSB0aGUgaG1hc2sgZmllbGQgd2hlbiB1c2luZyBpdA0KPiAgLSBzZWxl
Y3QgSE1NX01JUlJPUiBpbnN0ZWFkIG9mIG1ha2luZyBpdCBhIHVzZXIgdmlzaWJsZSBvcHRpb24N
CiANCkkgdGhpbmsgaXQgaXMgc3RyYWlnaHRmb3J3YXJkIGVub3VnaCB0byBtb3ZlIGludG8gLW5l
eHQsIHNvIGFwcGxpZWQgdG8NCnRoZSBobW0uZ2l0IGxldHMgZ2V0IHNvbWUgbW9yZSByZXZpZXdl
ZC1ieXMvdGVzdGVkLWJ5IHRob3VnaC4NCg0KRm9yIG5vdyBJIGRyb3BwZWQgJ3JlbW92ZSB0aGUg
cGdtYXAgZmllbGQgZnJvbSBzdHJ1Y3QgaG1tX3ZtYV93YWxrJw0KanVzdCB0byBoZWFyIHRoZSBm
b2xsb3d1cCBhbmQgJ2FtZGdwdTogcmVtb3ZlDQpDT05GSUdfRFJNX0FNREdQVV9VU0VSUFRSJyB1
bnRpbCB0aGUgQU1EIHRlYW0gQWNrcw0KDQpUaGFua3MsDQpKYXNvbg0K
