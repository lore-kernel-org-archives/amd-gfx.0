From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add the checking to avoid NULL pointer
 dereference
Date: Fri, 23 Nov 2018 13:27:14 +0000
Message-ID: <9350d13a-e745-f284-1c49-785fe523773d@amd.com>
References: <20181122065523.5510-1-Deepak.Sharma@amd.com>
 <b8284caa-3f1d-5672-6317-36be83907e9d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b8284caa-3f1d-5672-6317-36be83907e9d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <E04DD3450183C24597568D1296290DA1-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

DQoNCuWcqCAyMDE4LzExLzIyIDE5OjI1LCBDaHJpc3RpYW4gS8O2bmlnIOWGmemBkzoNCj4gQW0g
MjIuMTEuMTggdW0gMDc6NTYgc2NocmllYiBTaGFybWEsIERlZXBhazoNCj4+IHdoZW4gcmV0dXJu
ZWQgZmVuY2UgaXMgbm90IHZhbGlkIG1vc3RseSBkdWUgdG8gdXNlcnNwYWNlIGlnbm9yZWQNCj4+
IHByZXZpb3VzIGVycm9yIGNhdXNlcyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQo+DQo+IEFn
YWluLCB0aGlzIGlzIGNsZWFybHkgaW5jb3JyZWN0LiBUaGUgbXkgb3RoZXIgbWFpbHMgb24gdGhl
IGVhcmxpZXIgDQo+IHBhdGNoLg0KU29ycnkgZm9yIEkgZGlkbid0IGdldCB5b3VyIGhpc3Rvcnks
IGJ1dCBsb29rcyBmcm9tIHRoZSBwYXRjaCBpdHNlbGYsIGl0IA0KaXMgc3RpbGwgYSB2YWxpZCBw
YXRjaCwgaXNuJ3QgaXQ/DQoNCi1EYXZpZA0KPg0KPiBJZiB5b3UgaGF2ZSBhbHJlYWR5IHB1c2hl
ZCB0aGUgcGF0Y2ggdGhlbiBwbGVhc2UgcmV2ZXJ0Lg0KPg0KPiBDaHJpc3RpYW4uDQo+DQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogRGVlcGFrIFNoYXJtYSA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPg0K
Pj4gLS0tDQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDIg
KysNCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgDQo+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQo+PiBpbmRleCAwMjRkZmJkODdmMTEu
LjE0MTY2Y2Q4YTEyZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jcy5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Y3MuYw0KPj4gQEAgLTE0MDMsNiArMTQwMyw4IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2ZlbmNlIA0K
Pj4gKmFtZGdwdV9jc19nZXRfZmVuY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiDC
oCDCoMKgwqDCoMKgIGZlbmNlID0gYW1kZ3B1X2N0eF9nZXRfZmVuY2UoY3R4LCBlbnRpdHksIHVz
ZXItPnNlcV9ubyk7DQo+PiDCoMKgwqDCoMKgIGFtZGdwdV9jdHhfcHV0KGN0eCk7DQo+PiArwqDC
oMKgIGlmKCFmZW5jZSkNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRUlOVkFM
KTsNCj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIGZlbmNlOw0KPj4gwqAgfQ0KPg0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
