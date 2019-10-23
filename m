From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: remove assignment for return value
Date: Wed, 23 Oct 2019 15:09:40 +0000
Message-ID: <2bed3fab-e84d-226d-b552-1ac088fc5d9c@amd.com>
References: <20191019073242.21652-1-wambui@karuga.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191019073242.21652-1-wambui-bg2bBxPYEmlRKH5a5HGb4w@public.gmane.org>
Content-Language: en-US
Content-ID: <02F5B14052661E4FAD9585FB77B7C616-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Wambui Karuga <wambui-bg2bBxPYEmlRKH5a5HGb4w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "outreachy-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <outreachy-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0xMC0xOSAzOjMyIGEubS4sIFdhbWJ1aSBLYXJ1Z2Egd3JvdGU6DQo+IFJlbW92ZSB1
bm5lY2Vzc2FyeSBhc3NpZ25tZW50IGZvciByZXR1cm4gdmFsdWUgYW5kIGhhdmUgdGhlDQo+IGZ1
bmN0aW9uIHJldHVybiB0aGUgcmVxdWlyZWQgdmFsdWUgZGlyZWN0bHkuDQo+IElzc3VlIGZvdW5k
IGJ5IGNvY2NpbmVsbGU6DQo+IEBADQo+IGxvY2FsIGlkZXhwcmVzc2lvbiByZXQ7DQo+IGV4cHJl
c3Npb24gZTsNCj4gQEANCj4gDQo+IC1yZXQgPQ0KPiArcmV0dXJuDQo+ICAgICAgZTsNCj4gLXJl
dHVybiByZXQ7DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXYW1idWkgS2FydWdhIDx3YW1idWlAa2Fy
dWdhLnh5ej4NCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KDQpSZXZpZXdlZC1ieTogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQoNCkhhcnJ5DQoNCg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgfCA4ICsrLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Np
ay5jDQo+IGluZGV4IDYyZWFiODJhNjRmOS4uZGFmZjlhMmFmM2JlIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vY2lrLmMNCj4gQEAgLTIyMSw5ICsyMjEsNyBAQCBpbnQgY2lfZ2V0X3RlbXAoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYpDQo+ICAJZWxzZQ0KPiAgCQlhY3R1YWxfdGVtcCA9IHRlbXAgJiAw
eDFmZjsNCj4gIA0KPiAtCWFjdHVhbF90ZW1wID0gYWN0dWFsX3RlbXAgKiAxMDAwOw0KPiAtDQo+
IC0JcmV0dXJuIGFjdHVhbF90ZW1wOw0KPiArCXJldHVybiBhY3R1YWxfdGVtcCAqIDEwMDA7DQo+
ICB9DQo+ICANCj4gIC8qIGdldCB0ZW1wZXJhdHVyZSBpbiBtaWxsaWRlZ3JlZXMgKi8NCj4gQEAg
LTIzOSw5ICsyMzcsNyBAQCBpbnQga3ZfZ2V0X3RlbXAoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYpDQo+ICAJZWxzZQ0KPiAgCQlhY3R1YWxfdGVtcCA9IDA7DQo+ICANCj4gLQlhY3R1YWxfdGVt
cCA9IGFjdHVhbF90ZW1wICogMTAwMDsNCj4gLQ0KPiAtCXJldHVybiBhY3R1YWxfdGVtcDsNCj4g
KwlyZXR1cm4gYWN0dWFsX3RlbXAgKiAxMDAwOw0KPiAgfQ0KPiAgDQo+ICAvKg0KPiANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
