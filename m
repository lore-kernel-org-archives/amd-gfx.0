From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [Regression] "drm/amdgpu: enable gfxoff again on raven series
 (v2)"
Date: Thu, 8 Aug 2019 08:14:53 +0000
Message-ID: <MN2PR12MB3309A9960E429AA5B0A8AD19ECD70@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com>
 <MN2PR12MB330979BAFF5BCC758258D54CECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
 <624BFB8F-B586-492E-BEA6-4B138DAEC831@canonical.com>
 <MN2PR12MB3309680845257BC66644133CECD70@MN2PR12MB3309.namprd12.prod.outlook.com>
 <615a4948-d0f9-46fc-f43e-2025455e9af6@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <615a4948-d0f9-46fc-f43e-2025455e9af6-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWlj
aGVsQGRhZW56ZXIubmV0Pg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDA4LCAyMDE5IDQ6MTAg
UE0NCj4gVG86IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgS2FpLUhlbmcgRmVuZw0K
PiA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KPiBDYzogWmhvdSwgRGF2aWQoQ2h1bk1p
bmcpIDxEYXZpZDEuWmhvdUBhbWQuY29tPjsgTEtNTCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBBbnRob255IFdvbmcN
Cj4gPGFudGhvbnkud29uZ0BjYW5vbmljYWwuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtDQo+IGdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JlZ3Jlc3Npb25dICJkcm0vYW1kZ3B1OiBlbmFi
bGUgZ2Z4b2ZmIGFnYWluIG9uIHJhdmVuIHNlcmllcw0KPiAodjIpIg0KPiANCj4gT24gMjAxOS0w
OC0wOCA4OjI5IGEubS4sIEh1YW5nLCBSYXkgd3JvdGU6DQo+ID4+IEZyb206IEthaS1IZW5nIEZl
bmcgPGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4gYXQgMDA6MDMsIEh1YW5nLA0KPiA+PiBS
YXkgPFJheS5IdWFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4+IE1heSBJIGtub3cgdGhl
IGFsbCBmaXJtd2FyZSB2ZXJzaW9uIGluIHlvdXIgc3lzdGVtPw0KPiA+DQo+ID4gU2VlbXMgdG8g
dGhlIGlzc3VlIHdlIGVuY291bnRlcmVkIHdpdGggSU9NTVUgZW5hYmxlZC4gQ291bGQgeW91DQo+
IHBsZWFzZSBkaXNhYmxlIGlvbW11IGluIFNCSU9TIG9yIEdSVUI/DQo+IA0KPiBUaGUgZHJpdmVy
IG5lZWRzIHRvIHdvcmsgd2l0aCB0aGUgSU9NTVUgZW5hYmxlZC4gSWYgbm90aGluZyBlbHNlLCBS
T0NtDQo+IG9ubHkgd29ya3Mgd2l0aCBJT01NVSBJIHRoaW5rLg0KPiANCg0KWWVzLiBST0NtIGlu
IEFQVSByZXF1aXJlZCBJT01NVSB2Mi4gU28gZmFyLCBJIGFtIGFza2luZyBLYWktSGVuZyB0byBk
byBzb21lIHRlc3RzIHRvIG1ha2Ugc3VyZSB0aGUgaXNzdWUgdGhhdCB3YXMgZW5jb3VudGVyZWQg
YnkgdXMgYmVmb3JlLiAoKyBNYXJlaykNCg0KVGhhbmtzLA0KUmF5DQoNCj4gDQo+IC0tDQo+IEVh
cnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgIGh0dHBz
Oi8vd3d3LmFtZC5jb20NCj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8
ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
