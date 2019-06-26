From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Set queue_preemption_timeout_ms default value
Date: Wed, 26 Jun 2019 22:19:02 +0000
Message-ID: <651064ae-f112-de81-f477-1af0a469127f@amd.com>
References: <1561562565-24858-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1561562565-24858-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <711766C87F10504E88A0EB05FEEC54BC-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Li,
 Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wNi0yNiAxMToyMiBhLm0uLCBaZW5nLCBPYWsgd3JvdGU6DQo+IFNldCBkZWZhdWx0
IHZhbHVlIG9mIHRoaXMga2VybmVsIHBhcmFtZXRlciB0byA5MDAwDQo+DQo+IENoYW5nZS1JZDog
SWY5MWRiNGQyYzJhYzA4ZTI1ZDc3MjhkNDk2MjljYmFlYzBkNmM3NzMNCj4gU2lnbmVkLW9mZi1i
eTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kcnYuYw0KPiBpbmRleCA3Y2Y2YWIwLi5lNzRhMTc1IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+IEBAIC03MDAsNyArNzAwLDcgQEAgTU9EVUxF
X1BBUk1fREVTQyhod3NfZ3dzX3N1cHBvcnQsICJNRUMgRlcgc3VwcG9ydCBnd3MgYmFycmllcnMg
KGZhbHNlID0gbm90IHN1cHANCj4gICAgICogRE9DOiBxdWV1ZV9wcmVlbXB0aW9uX3RpbWVvdXRf
bXMgKGludCkNCj4gICAgICogcXVldWUgcHJlZW1wdGlvbiB0aW1lb3V0IGluIG1zICgxID0gTWlu
aW11bSwgOTAwMCA9IGRlZmF1bHQpDQo+ICAgICAqLw0KPiAtaW50IHF1ZXVlX3ByZWVtcHRpb25f
dGltZW91dF9tczsNCj4gK2ludCBxdWV1ZV9wcmVlbXB0aW9uX3RpbWVvdXRfbXMgPSA5MDAwOw0K
PiAgIG1vZHVsZV9wYXJhbShxdWV1ZV9wcmVlbXB0aW9uX3RpbWVvdXRfbXMsIGludCwgMDY0NCk7
DQo+ICAgTU9EVUxFX1BBUk1fREVTQyhxdWV1ZV9wcmVlbXB0aW9uX3RpbWVvdXRfbXMsICJxdWV1
ZSBwcmVlbXB0aW9uIHRpbWVvdXQgaW4gbXMgKDEgPSBNaW5pbXVtLCA5MDAwID0gZGVmYXVsdCki
KTsNCj4gICAjZW5kaWYNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
