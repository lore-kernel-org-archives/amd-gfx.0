From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 15/15] amdgpu: remove CONFIG_DRM_AMDGPU_USERPTR
Date: Tue, 6 Aug 2019 17:51:42 +0000
Message-ID: <587b1c3c-83c4-7de9-242f-6516528049f4@amd.com>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-16-hch@lst.de> <20190806174437.GK11627@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806174437.GK11627@ziepe.ca>
Content-Language: en-US
Content-ID: <253371366C4977429E154A1B7CA108CB@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wOC0wNiAxMzo0NCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUdWUsIEF1
ZyAwNiwgMjAxOSBhdCAwNzowNTo1M1BNICswMzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToN
Cj4+IFRoZSBvcHRpb24gaXMganVzdCB1c2VkIHRvIHNlbGVjdCBITU0gbWlycm9yIHN1cHBvcnQg
YW5kIGhhcyBhIHZlcnkNCj4+IGNvbmZ1c2luZyBoZWxwIHRleHQuICBKdXN0IHB1bGwgaW4gdGhl
IEhNTSBtaXJyb3IgY29kZSBieSBkZWZhdWx0DQo+PiBpbnN0ZWFkLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAyICsrDQo+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L0tjb25maWcgICAgICB8IDEwIC0tLS0tLS0tLS0NCj4+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgIDYgLS0tLS0tDQo+PiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaCB8IDEyIC0tLS0tLS0tLS0tLQ0K
Pj4gICA0IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+
IEZlbGl4LCB3YXMgdGhpcyBhbiBlZmZvcnQgdG8gYXZvaWQgdGhlIGFyY2ggcmVzdHJpY3Rpb24g
b24gaG1tIG9yDQo+IHNvbWV0aGluZz8gQWxzbyBjYW4ndCBzZWUgd2h5IHRoaXMgd2FzIGxpa2Ug
dGhpcy4NCg0KVGhpcyBvcHRpb24gcHJlZGF0ZXMgS0ZEJ3Mgc3VwcG9ydCBvZiB1c2VycHRycywg
d2hpY2ggaW4gdHVybiBwcmVkYXRlcyANCkhNTS4gUmFkZW9uIGhhcyB0aGUgc2FtZSBraW5kIG9m
IG9wdGlvbiwgdGhvdWdoIGl0IGRvZXNuJ3QgYWZmZWN0IEhNTSBpbiANCnRoYXQgY2FzZS4NCg0K
QWxleCwgQ2hyaXN0aWFuLCBjYW4geW91IHRoaW5rIG9mIGEgZ29vZCByZWFzb24gdG8gbWFpbnRh
aW4gdXNlcnB0ciANCnN1cHBvcnQgYXMgYW4gb3B0aW9uIGluIGFtZGdwdT8gSSBzdXNwZWN0IGl0
IHdhcyBvcmlnaW5hbGx5IG1lYW50IGFzIGEgDQp3YXkgdG8gYWxsb3cga2VybmVscyB3aXRoIGFt
ZGdwdSB3aXRob3V0IE1NVSBub3RpZmllcnMuIE5vdyBpdCB3b3VsZCANCmFsbG93IGEga2VybmVs
IHdpdGggYW1kZ3B1IHdpdGhvdXQgSE1NIG9yIE1NVSBub3RpZmllcnMuIEkgZG9uJ3Qga25vdyBp
ZiANCnRoaXMgaXMgYSB1c2VmdWwgdGhpbmcgdG8gaGF2ZS4NCg0KUmVnYXJkcywNCiDCoCBGZWxp
eA0KDQo+DQo+IFJldmlld2VkLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+
DQo+DQo+IEphc29uDQo=
