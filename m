From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/display: remove unused function
 setFieldWithMask
Date: Tue, 27 Aug 2019 14:01:24 +0000
Message-ID: <fb49a1d9-8405-4f88-6f9a-af863bd0f657@amd.com>
References: <20190827070925.16080-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190827070925.16080-1-yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <8B18C0D47B26414C958DE53BABAACDFA-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "Koo, Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, "Othman, Ahmad" <Ahmad.Othman-5C7GfCeVMHo@public.gmane.org>, "Bernstein,
 Eric" <Eric.Bernstein-5C7GfCeVMHo@public.gmane.org>, "Cyr, Aric" <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>, "alvin.lee3-5C7GfCeVMHo@public.gmane.org" <alvin.lee3-5C7GfCeVMHo@public.gmane.org>, "Tatla, Harmanprit" <Harmanprit.Tatla-5C7GfCeVMHo@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjAxOS0wOC0yNyAzOjA5IGEubS4sIFl1ZUhhaWJpbmcgd3JvdGU6DQo+IEFmdGVyIGNvbW1p
dCBhOWY1NGNlM2M2MDMgKCJkcm0vYW1kL2Rpc3BsYXk6IFJlZmFjdG9yaW5nIFZURU0iKSwNCj4g
dGhlcmUgaXMgbm8gY2FsbGVyIGluIHRyZWUuDQo+IA0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2Jv
dCA8aHVsa2NpQGh1YXdlaS5jb20+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJp
bmdAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+IC0tLQ0KPiAgLi4uL2RybS9hbWQvZGlzcGxheS9t
b2R1bGVzL2luZm9fcGFja2V0L2luZm9fcGFja2V0LmMgfCAxOSAtLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5mb19wYWNrZXQvaW5mb19wYWNr
ZXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2luZm9fcGFja2V0L2lu
Zm9fcGFja2V0LmMNCj4gaW5kZXggNWY0Yjk4ZC4uZDg4NWQ2NCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5mb19wYWNrZXQvaW5mb19wYWNrZXQu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmZvX3BhY2tl
dC9pbmZvX3BhY2tldC5jDQo+IEBAIC0xMTQsMjUgKzExNCw2IEBAIGVudW0gQ29sb3JpbWV0cnlZ
Q0NEUCB7DQo+ICAJQ29sb3JpbWV0cnlZQ0NfRFBfSVRVMjAyMFlDYkNyICA9IDcsDQo+ICB9Ow0K
PiAgDQo+IC12b2lkIHNldEZpZWxkV2l0aE1hc2sodW5zaWduZWQgY2hhciAqZGVzdCwgdW5zaWdu
ZWQgaW50IG1hc2ssIHVuc2lnbmVkIGludCB2YWx1ZSkNCj4gLXsNCj4gLQl1bnNpZ25lZCBpbnQg
c2hpZnQgPSAwOw0KPiAtDQo+IC0JaWYgKCFtYXNrIHx8ICFkZXN0KQ0KPiAtCQlyZXR1cm47DQo+
IC0NCj4gLQl3aGlsZSAoISgobWFzayA+PiBzaGlmdCkgJiAxKSkNCj4gLQkJc2hpZnQrKzsNCj4g
LQ0KPiAtCS8vcmVzZXQNCj4gLQkqZGVzdCA9ICpkZXN0ICYgfm1hc2s7DQo+IC0JLy9zZXQNCj4g
LQkvL2RvbnQgbGV0IHZhbHVlIHNwYW4gcGFzdCBtYXNrDQo+IC0JdmFsdWUgPSB2YWx1ZSAmICht
YXNrID4+IHNoaWZ0KTsNCj4gLQkvL2luc2VydCB2YWx1ZQ0KPiAtCSpkZXN0ID0gKmRlc3QgfCAo
dmFsdWUgPDwgc2hpZnQpOw0KPiAtfQ0KPiAtDQo+ICB2b2lkIG1vZF9idWlsZF92c2NfaW5mb3Bh
Y2tldChjb25zdCBzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJlYW0sDQo+ICAJCXN0cnVjdCBk
Y19pbmZvX3BhY2tldCAqaW5mb19wYWNrZXQpDQo+ICB7DQo+IA0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
