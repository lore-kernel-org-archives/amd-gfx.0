From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: Regression caused by "drm/amdgpu: get display info from DC when
 DC enabled."
Date: Thu, 30 Mar 2017 03:19:21 +0000
Message-ID: <BN6PR12MB1652A69F5052FDBB3EE89D2EF7340@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <4bf14806-e715-5206-bee1-2fb0ffb35e27@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4bf14806-e715-5206-bee1-2fb0ffb35e27-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?J01pY2hlbCBEw6RuemVyJw==?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIE1pY2hl
bCBEw6RuemVyDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjksIDIwMTcgMTE6MTEgUE0NCj4g
VG86IFpodSwgUmV4DQo+IENjOiBBbmR5IEZ1cm5pc3M7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IFN1YmplY3Q6IFJlZ3Jlc3Npb24gY2F1c2VkIGJ5ICJkcm0vYW1kZ3B1OiBnZXQg
ZGlzcGxheSBpbmZvIGZyb20gREMgd2hlbg0KPiBEQyBlbmFibGVkLiINCj4gDQo+IA0KPiBIaSBS
ZXgsDQo+IA0KPiANCj4gQW5keSBiaXNlY3RlZCBhIHJlZ3Jlc3Npb24gdG8geW91ciBjb21taXQN
Cj4gOTE1NjFhMzlmYTc0ZTc5Yjg4ZTBlOWQ3MGYzMDcyNTAxYzhkZjJjZSwgc2VlDQo+IGh0dHBz
Oi8vYnVncy5mcmVlZGVza3RvcC5vcmcvMTAwMzk1IC4gQW55IGlkZWFzPw0KDQpodHRwOi8vb250
cmFjay1pbnRlcm5hbC5hbWQuY29tL2Jyb3dzZS9TV0RFVi0xMTcwOTcNCg0KQWxleA0KDQo+IA0K
PiANCj4gLS0NCj4gRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQ0KPiBMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXINCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
