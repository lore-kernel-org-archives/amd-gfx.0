From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/6] dma-buf: add dynamic DMA-buf handling
 v10
Date: Tue, 25 Jun 2019 07:20:12 +0000
Message-ID: <d2933e7a-5dd1-70af-cbb6-69755fcbbc5e@amd.com>
References: <20190618115455.1253-1-christian.koenig@amd.com>
 <20190621092022.GB12905@phenom.ffwll.local>
 <46bc08a3-1b84-c819-dbb5-882e95ab23e5@gmail.com>
 <CAKMK7uE6NUujY0ubOYkux-StOxMT-hYhBdAnQJkDsgEkuDjH9g@mail.gmail.com>
 <78db8951-2e62-2a9d-3d87-3b458fbba880@gmail.com>
 <20190621162753.GI12905@phenom.ffwll.local>
 <4d868c4c-cc00-bfa9-b6f5-969b76497cab@amd.com>
 <1d4f3779-8dc8-14ad-4d20-f7ccee7cea53@gmail.com>
 <20190624144105.GR12905@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20190624144105.GR12905@phenom.ffwll.local>
Content-Language: en-US
Content-ID: <3B0A2450313E0F43823DBCE7D51F8772@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjQuMDYuMTkgdW0gMTY6NDEgc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KPiBPbiBNb24sIEp1
biAyNCwgMjAxOSBhdCAwMzo1ODowMFBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0K
Pj4gQW0gMjQuMDYuMTkgdW0gMTM6MjMgc2NocmllYiBLb2VuaWcsIENocmlzdGlhbjoNCj4+PiBB
bSAyMS4wNi4xOSB1bSAxODoyNyBzY2hyaWViIERhbmllbCBWZXR0ZXI6DQo+Pj4NCj4+Pj4gU28g
SSBwb25kZXJlZCBhIGZldyBpZGVhcyB3aGlsZSB3b3JraW5nIG91dDoNCj4+Pj4NCj4+Pj4gMSkg
V2UgZHJvcCB0aGlzIGZpbHRlcmluZy4gSW1wb3J0ZXIgbmVlZHMgdG8ga2VlcCB0cmFjayBvZiBh
bGwgaXRzDQo+Pj4+IG1hcHBpbmdzIGFuZCBmaWx0ZXIgb3V0IGludmFsaWRhdGVzIHRoYXQgYXJl
bid0IGZvciB0aGF0IHNwZWNpZmljIGltcG9ydGVyDQo+Pj4+IChlaXRoZXIgYmVjYXVzZSBhbHJl
YWR5IGludmFsaWRhdGVkLCBvciBub3QgeWV0IG1hcHBlZCwgb3Igd2hhdGV2ZXIpLg0KPj4+PiBG
ZWVscyBmcmFnaWxlLg0KPj4+Pg0KPj4+PiBbU05JUF0NCj4+PiBbU05JUF0NCj4+Pg0KPj4+IEkg
d2lsbCB0YWtlIGEgbW9tZW50IGFuZCBsb29rIGludG8gIzEgYXMgd2VsbCwgYnV0IEkgc3RpbGwg
ZG9uJ3Qgc2VlIHRoZQ0KPj4+IG5lZWQgdG8gY2hhbmdlIGFueXRoaW5nLg0KPj4gVGhhdCB0dXJu
ZWQgb3V0IG11Y2ggY2xlYW5lciB0aGFuIEkgdGhvdWdodCBpdCB3b3VsZCBiZS4gRXNzZW50aWFs
bHkgaXQgaXMNCj4+IG9ubHkgYSBzaW5nbGUgZXh0cmEgbGluZSBvZiBjb2RlIGluIGFtZGdwdS4N
Cj4+DQo+PiBHb2luZyB0byBzZW5kIHRoYXQgb3V0IGFzIGEgcGF0Y2ggc2V0IGluIGEgbWludXRl
Lg0KPiBZZWFoIEkgbWVhbiBraW5kYSBleHBlY3RlZCB0aGF0IGJlY2F1c2U6DQo+IC0gZXZlcnl0
aGluZydzIHByb3RlY3RlZCB3aXRoIHd3X211dGV4IGFueXdheQ0KPiAtIGltcG9ydGVyIG5lZWRz
IHRvIGtlZXAgdHJhY2sgb2YgbWFwcGluZ3MgYW53YXlzDQo+IFNvIHJlYWxseSBhbGwgaXQgbmVl
ZHMgdG8gZG8gaXMgbm90IGJlIHN0dXBpZCBhbmQgYWRkIHRoZSBtYXBwaW5nIGl0IGp1c3QNCj4g
Y3JlYXRlZCB0byBpdHMgdHJhY2tpbmcgd2hpbGUgc3RpbGwgaG9sZGluZyB0aGUgd3dfbXV0ZXgu
IFNpbWlsYXIgb24NCj4gaW52YWxpZGF0ZS91bm1hcC4NCj4NCj4gV2l0aCB0aGF0IGFsbCB3ZSBu
ZWVkIGlzIGEgaHVnZSBub3RlIGluIHRoZSBkb2NzIHRoYXQgaW1wb3J0ZXJzIG5lZWQgdG8NCj4g
a2VlcCB0cmFjayBvZiB0aGVpciBtYXBwaW5ncyBhbmQgZHRydCAod2l0aCBhbGwgdGhlIGV4YW1w
bGVzIGhlcmUgc3BlbGxlZA0KPiBvdXQgaW4gdGhlIGFwcHJvcHJpYXRlIGtlcm5lbGRvYykuIEFu
ZCB0aGVuIEknbSBoYXBweSA6LSkNCg0KU2hvdWxkIEkgYWxzbyByZW5hbWUgdGhlIGludmFsaWRh
dGUgY2FsbGJhY2sgaW50byBtb3ZlX25vdGlmeT8gV291bGQgDQpraW5kIG9mIG1ha2Ugc2Vuc2Ug
c2luY2Ugd2UgYXJlIG5vdCBuZWNlc3NhcnkgZGlyZWN0bHkgaW52YWxpZGF0aW5nIA0KbWFwcGlu
Z3MuDQoNCkNocmlzdGlhbi4NCg0KPg0KPiBDaGVlcnMsIERhbmllbA0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0
CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZng=
