From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: move common function to smu7_smumgr.c
Date: Mon, 9 Oct 2017 17:11:16 +0000
Message-ID: <BN6PR12MB165207C198340A2DA6F24BB4F7740@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1507527263-6297-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507527263-6297-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIFJleCBa
aHUNCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDA5LCAyMDE3IDE6MzQgQU0NCj4gVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBaaHUsIFJleA0KPiBTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvcG93ZXJwbGF5OiBtb3ZlIGNvbW1vbiBmdW5jdGlvbiB0bw0KPiBzbXU3X3Nt
dW1nci5jDQo+IA0KPiBmaWppIGFuZCBwb2xhcmlzIGNhbiBzaGFyZSBzYW1lIHNldHVwX3B3cl92
aXJ1cw0KPiBmdW5jdGlvbi4NCj4gDQo+IENoYW5nZS1JZDogSTgzOTgxMjk2OWY4ODM5ZTE5NmIw
YzA5YzQ5MGI2MjNiMDFmOGFkMjkNCj4gU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBh
bWQuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2Zp
amlfcHdydmlydXMuaCAgfCAyMDA3IC0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL2Zpamlfc211bWdyLmMgfCAgIDQzICstDQo+
ICAuLi4vZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3BvbGFyaXMxMF9zbXVtZ3IuYyAgICB8ICAg
NDMgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9zbXU3X3NtdW1n
ci5jIHwgICA0NiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3Nt
dTdfc211bWdyLmggfCAgICA0ICstDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMo
KyksIDIwOTQgZGVsZXRpb25zKC0pDQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2ZpamlfcHdydmlydXMuaA0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
