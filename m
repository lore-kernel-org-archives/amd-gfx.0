From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 3/3] drm/amd/powerplay: support hwmon max/min fan speed
 setting on Vega20
Date: Wed, 24 Oct 2018 08:53:56 +0000
Message-ID: <SN6PR12MB2656C84D3FDFB470BC17653DE4F60@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <20181024081141.18647-1-evan.quan@amd.com>,
 <20181024081141.18647-3-evan.quan@amd.com>
 <BYAPR12MB277564C5DF32AFE83E33F7D8FBF60@BYAPR12MB2775.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1253123602=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB277564C5DF32AFE83E33F7D8FBF60-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1253123602==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2656C84D3FDFB470BC17653DE4F60SN6PR12MB2656namp_"

--_000_SN6PR12MB2656C84D3FDFB470BC17653DE4F60SN6PR12MB2656namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

U3VyZQ0KDQpGcm9tOiBaaHUsIFJleA0KU2VudDogMjAxOMTqMTDUwjI0yNUgMTY6MzcNClRvOiBR
dWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZC9wb3dlcnBsYXk6IHN1cHBvcnQg
aHdtb24gbWF4L21pbiBmYW4gc3BlZWQgc2V0dGluZyBvbiBWZWdhMjANCg0KDQotICAgICAgIHBl
cmNlbnQgPSBjdXJyZW50X3JwbSAqIDEwMCAvIHBwX3RhYmxlLT5GYW5NYXhpbXVtUnBtOw0KKyAg
ICAgICBwZXJjZW50ID0gKGN1cnJlbnRfcnBtICogMTAwKSAvDQorICAgICAgICAgICAgICAgaHdt
Z3ItPnRoZXJtYWxfY29udHJvbGxlci5mYW5JbmZvLnVsTWF4UlBNOw0KDQoNCkJldHRlciBjaGVj
ayBod21nci0+dGhlcm1hbF9jb250cm9sbGVyLmZhbkluZm8udWxNYXhSUE0gbm90IGVxdWFsIHRv
IDAuDQoNCg0KDQpCZXN0IFJlZ2FyZHMNCg0KUmV4DQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPG1haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPj4gb24g
YmVoYWxmIG9mIEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb208bWFpbHRvOmV2YW4ucXVhbkBh
bWQuY29tPj4NClNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNCwgMjAxOCA0OjExIFBNDQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPg0KQ2M6IFF1YW4sIEV2YW4NClN1YmplY3Q6IFtQQVRDSCAzLzNdIGRybS9hbWQv
cG93ZXJwbGF5OiBzdXBwb3J0IGh3bW9uIG1heC9taW4gZmFuIHNwZWVkIHNldHRpbmcgb24gVmVn
YTIwDQoNCkFkZGVkIHN1cHBvcnQgZm9yIGh3bW9uIG1heC9taW4gZmFuIHNwZWVkIHNldHRpbmcg
b24gVmVnYTIwLg0KDQpDaGFuZ2UtSWQ6IEllYWI0MmM3NDRkNmM1NGY4Yjg1YTcxYmU4MGY3YzY4
MzJhZTczNTJiDQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPG1h
aWx0bzpldmFuLnF1YW5AYW1kLmNvbT4+DQotLS0NCiAuLi4vZHJtL2FtZC9wb3dlcnBsYXkvaHdt
Z3IvdmVnYTIwX2h3bWdyLmMgICAgfCAgNCArKw0KIC4uLi9kcm0vYW1kL3Bvd2VycGxheS9od21n
ci92ZWdhMjBfdGhlcm1hbC5jICB8IDU2ICsrKysrKysrKysrKysrKysrKy0NCiAuLi4vZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX3RoZXJtYWwuaCAgfCAgNCArKw0KIDMgZmlsZXMgY2hh
bmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3bWdyLmMNCmluZGV4IDU3MTQz
ZDUxZTNlZS4uMjUxM2U2YmUzMjE5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3bWdyLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jDQpAQCAtMzUzOSw2ICszNTM5LDEwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgcHBfaHdtZ3JfZnVuYyB2ZWdhMjBfaHdtZ3JfZnVuY3MgPSB7DQog
ICAgICAgICAgICAgICAgIHZlZ2EyMF9nZXRfZmFuX2NvbnRyb2xfbW9kZSwNCiAgICAgICAgIC5z
ZXRfZmFuX2NvbnRyb2xfbW9kZSA9DQogICAgICAgICAgICAgICAgIHZlZ2EyMF9zZXRfZmFuX2Nv
bnRyb2xfbW9kZSwNCisgICAgICAgLnNldF9mYW5fc3BlZWRfbWF4X3JwbSA9DQorICAgICAgICAg
ICAgICAgdmVnYTIwX2Zhbl9jdHJsX3NldF9mYW5fc3BlZWRfbWF4X3JwbSwNCisgICAgICAgLnNl
dF9mYW5fc3BlZWRfbWluX3JwbSA9DQorICAgICAgICAgICAgICAgdmVnYTIwX2Zhbl9jdHJsX3Nl
dF9mYW5fc3BlZWRfbWluX3JwbSwNCiAgICAgICAgIC8qIHNtdSBtZW1vcnkgcmVsYXRlZCAqLw0K
ICAgICAgICAgLm5vdGlmeV9jYWNfYnVmZmVyX2luZm8gPQ0KICAgICAgICAgICAgICAgICB2ZWdh
MjBfbm90aWZ5X2NhY19idWZmZXJfaW5mbywNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfdGhlcm1hbC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX3RoZXJtYWwuYw0KaW5kZXggZWRlNTRlODdlMjg3Li5k
YTlmZDIxNjhkY2IgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9o
d21nci92ZWdhMjBfdGhlcm1hbC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci92ZWdhMjBfdGhlcm1hbC5jDQpAQCAtMTE4LDcgKzExOCw2IEBAIGludCB2ZWdhMjBf
ZmFuX2N0cmxfZ2V0X2Zhbl9zcGVlZF9wZXJjZW50KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsDQog
ICAgICAgICAgICAgICAgIHVpbnQzMl90ICpzcGVlZCkNCiB7DQogICAgICAgICBzdHJ1Y3QgdmVn
YTIwX2h3bWdyICpkYXRhID0gKHN0cnVjdCB2ZWdhMjBfaHdtZ3IgKikoaHdtZ3ItPmJhY2tlbmQp
Ow0KLSAgICAgICBQUFRhYmxlX3QgKnBwX3RhYmxlID0gJihkYXRhLT5zbWNfc3RhdGVfdGFibGUu
cHBfdGFibGUpOw0KICAgICAgICAgdWludDMyX3QgY3VycmVudF9ycG0sIHBlcmNlbnQgPSAwOw0K
ICAgICAgICAgaW50IHJldCA9IDA7DQoNCkBAIC0xMjYsNyArMTI1LDggQEAgaW50IHZlZ2EyMF9m
YW5fY3RybF9nZXRfZmFuX3NwZWVkX3BlcmNlbnQoc3RydWN0IHBwX2h3bWdyICpod21nciwNCiAg
ICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQoNCi0gICAgICAg
cGVyY2VudCA9IGN1cnJlbnRfcnBtICogMTAwIC8gcHBfdGFibGUtPkZhbk1heGltdW1ScG07DQor
ICAgICAgIHBlcmNlbnQgPSAoY3VycmVudF9ycG0gKiAxMDApIC8NCisgICAgICAgICAgICAgICBo
d21nci0+dGhlcm1hbF9jb250cm9sbGVyLmZhbkluZm8udWxNYXhSUE07DQoNCiAgICAgICAgICpz
cGVlZCA9IHBlcmNlbnQgPiAxMDAgPyAxMDAgOiBwZXJjZW50Ow0KDQpAQCAtMjA4LDYgKzIwOCw1
OCBAQCBpbnQgdmVnYTIwX2Zhbl9jdHJsX3NldF9mYW5fc3BlZWRfcnBtKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IsIHVpbnQzMl90IHNwZWVkKQ0KICAgICAgICAgcmV0dXJuIHZlZ2EyMF9mYW5fY3Ry
bF9zZXRfc3RhdGljX21vZGUoaHdtZ3IsIEZET19QV01fTU9ERV9TVEFUSUNfUlBNKTsNCiB9DQoN
CitpbnQgdmVnYTIwX2Zhbl9jdHJsX3NldF9mYW5fc3BlZWRfbWF4X3JwbShzdHJ1Y3QgcHBfaHdt
Z3IgKmh3bWdyLCB1aW50MzJfdCBzcGVlZCkNCit7DQorICAgICAgIHN0cnVjdCB2ZWdhMjBfaHdt
Z3IgKmRhdGEgPSAoc3RydWN0IHZlZ2EyMF9od21nciAqKShod21nci0+YmFja2VuZCk7DQorICAg
ICAgIHN0cnVjdCB2ZWdhMjBfb2Q4X3NldHRpbmdzICpvZDhfc2V0dGluZ3MgPSAmKGRhdGEtPm9k
OF9zZXR0aW5ncyk7DQorICAgICAgIGludCByZXQgPSAwOw0KKw0KKyAgICAgICBpZiAoKG9kOF9z
ZXR0aW5ncy0+b3ZlcmRyaXZlOF9jYXBhYmlsaXRpZXMgJiBPRDhfQUNPVVNUSUNfTElNSVRfU0NM
SykgJiYNCisgICAgICAgICAgIChzcGVlZCA+IG9kOF9zZXR0aW5ncy0+b2Q4X3NldHRpbmdzX2Fy
cmF5W09EOF9TRVRUSU5HX0ZBTl9BQ09VU1RJQ19MSU1JVF0ubWF4X3ZhbHVlIHx8DQorICAgICAg
ICAgICAgc3BlZWQgPCBvZDhfc2V0dGluZ3MtPm9kOF9zZXR0aW5nc19hcnJheVtPRDhfU0VUVElO
R19GQU5fQUNPVVNUSUNfTElNSVRdLm1pbl92YWx1ZSkpDQorICAgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQorDQorICAgICAgIHJldCA9IHNtdW1fc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFy
YW1ldGVyKGh3bWdyLA0KKyAgICAgICAgICAgICAgICAgICAgICAgUFBTTUNfTVNHX1NldEZhbk1h
eFJwbSwNCisgICAgICAgICAgICAgICAgICAgICAgIHNwZWVkKTsNCisgICAgICAgUFBfQVNTRVJU
X1dJVEhfQ09ERSghcmV0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgIlNldCBGYW5NYXhScG0g
RmFpbGVkISIsDQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0KTsNCisNCisgICAg
ICAgaHdtZ3ItPnRoZXJtYWxfY29udHJvbGxlci5mYW5JbmZvLnVsTWluUlBNID0NCisgICAgICAg
ICAgICAgICAoc3BlZWQgKiBod21nci0+dGhlcm1hbF9jb250cm9sbGVyLmZhbkluZm8udWxNaW5Q
V00pIC8gMjU1Ow0KKw0KKyAgICAgICByZXR1cm4gcmV0Ow0KK30NCisNCitpbnQgdmVnYTIwX2Zh
bl9jdHJsX3NldF9mYW5fc3BlZWRfbWluX3JwbShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1aW50
MzJfdCBzcGVlZCkNCit7DQorICAgICAgIHN0cnVjdCB2ZWdhMjBfaHdtZ3IgKmRhdGEgPSAoc3Ry
dWN0IHZlZ2EyMF9od21nciAqKShod21nci0+YmFja2VuZCk7DQorICAgICAgIHN0cnVjdCB2ZWdh
MjBfb2Q4X3NldHRpbmdzICpvZDhfc2V0dGluZ3MgPSAmKGRhdGEtPm9kOF9zZXR0aW5ncyk7DQor
ICAgICAgIGludCByZXQgPSAwOw0KKyAgICAgICB1aW50MzJfdCBwd20gPSAwOw0KKw0KKyAgICAg
ICBpZiAoKG9kOF9zZXR0aW5ncy0+b3ZlcmRyaXZlOF9jYXBhYmlsaXRpZXMgJiBPRDhfRkFOX1NQ
RUVEX01JTikgJiYNCisgICAgICAgICAgIChzcGVlZCA+IG9kOF9zZXR0aW5ncy0+b2Q4X3NldHRp
bmdzX2FycmF5W09EOF9GQU5fU1BFRURfTUlOXS5tYXhfdmFsdWUgfHwNCisgICAgICAgICAgICBz
cGVlZCA8IG9kOF9zZXR0aW5ncy0+b2Q4X3NldHRpbmdzX2FycmF5W09EOF9GQU5fU1BFRURfTUlO
XS5taW5fdmFsdWUpKQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KKw0KKyAgICAg
ICBpZiAoc3BlZWQgPiBod21nci0+dGhlcm1hbF9jb250cm9sbGVyLmZhbkluZm8udWxNYXhSUE0p
DQorICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQorDQorICAgICAgIHB3bSA9IChzcGVl
ZCAqIDI1NSkgLyBod21nci0+dGhlcm1hbF9jb250cm9sbGVyLmZhbkluZm8udWxNYXhSUE07DQor
ICAgICAgIHJldCA9IHNtdW1fc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgUFBTTUNfTVNHX1NldEZhbk1pblB3bSwNCisgICAgICAg
ICAgICAgICAgICAgICAgIHB3bSk7DQorICAgICAgIFBQX0FTU0VSVF9XSVRIX0NPREUoIXJldCwN
CisgICAgICAgICAgICAgICAgICAgICAgICJTZXQgRmFuTWluUHdtIEZhaWxlZCEiLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldCk7DQorDQorICAgICAgIGh3bWdyLT50aGVybWFs
X2NvbnRyb2xsZXIuZmFuSW5mby51bE1pblBXTSA9IHB3bTsNCisNCisgICAgICAgcmV0dXJuIHJl
dDsNCit9DQorDQogLyoqDQogKiBSZWFkcyB0aGUgcmVtb3RlIHRlbXBlcmF0dXJlIGZyb20gdGhl
IFNJc2xhbmRzIHRoZXJtYWwgY29udHJvbGxlci4NCiAqDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX3RoZXJtYWwuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF90aGVybWFsLmgNCmluZGV4IDJkMTc2OWJi
ZDI0ZS4uZGRmYzk1MGU5MGNhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3IvdmVnYTIwX3RoZXJtYWwuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvdmVnYTIwX3RoZXJtYWwuaA0KQEAgLTU2LDYgKzU2LDEwIEBAIGV4dGVy
biBpbnQgdmVnYTIwX2Zhbl9jdHJsX2dldF9mYW5fc3BlZWRfcnBtKHN0cnVjdCBwcF9od21nciAq
aHdtZ3IsDQogICAgICAgICAgICAgICAgIHVpbnQzMl90ICpzcGVlZCk7DQogZXh0ZXJuIGludCB2
ZWdhMjBfZmFuX2N0cmxfc2V0X2Zhbl9zcGVlZF9ycG0oc3RydWN0IHBwX2h3bWdyICpod21nciwN
CiAgICAgICAgICAgICAgICAgdWludDMyX3Qgc3BlZWQpOw0KK2V4dGVybiBpbnQgdmVnYTIwX2Zh
bl9jdHJsX3NldF9mYW5fc3BlZWRfbWF4X3JwbShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLA0KKyAg
ICAgICAgICAgICAgIHVpbnQzMl90IHNwZWVkKTsNCitleHRlcm4gaW50IHZlZ2EyMF9mYW5fY3Ry
bF9zZXRfZmFuX3NwZWVkX21pbl9ycG0oc3RydWN0IHBwX2h3bWdyICpod21nciwNCisgICAgICAg
ICAgICAgICB1aW50MzJfdCBzcGVlZCk7DQogZXh0ZXJuIGludCB2ZWdhMjBfZmFuX2N0cmxfZ2V0
X2Zhbl9zcGVlZF9wZXJjZW50KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsDQogICAgICAgICAgICAg
ICAgIHVpbnQzMl90ICpzcGVlZCk7DQogZXh0ZXJuIGludCB2ZWdhMjBfZmFuX2N0cmxfc2V0X2Zh
bl9zcGVlZF9wZXJjZW50KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsDQotLQ0KMi4xOS4xDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1h
aWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8bWFpbHRvOmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4DQphbWQtZ2Z4IEluZm8gUGFnZSAtIGZyZWVkZXNrdG9wLm9y
ZzxodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng+
DQpsaXN0cy5mcmVlZGVza3RvcC5vcmcNClRvIHNlZSB0aGUgY29sbGVjdGlvbiBvZiBwcmlvciBw
b3N0aW5ncyB0byB0aGUgbGlzdCwgdmlzaXQgdGhlIGFtZC1nZnggQXJjaGl2ZXMuLiBVc2luZyBh
bWQtZ2Z4OiBUbyBwb3N0IGEgbWVzc2FnZSB0byBhbGwgdGhlIGxpc3QgbWVtYmVycywgc2VuZCBl
bWFpbCB0byBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+LiBZb3UgY2FuIHN1YnNjcmliZSB0byB0aGUgbGlzdCwgb3IgY2hh
bmdlIHlvdXIgZXhpc3Rpbmcgc3Vic2NyaXB0aW9uLCBpbiB0aGUgc2VjdGlvbnMgYmVsb3cuDQoN
Cg0K

--_000_SN6PR12MB2656C84D3FDFB470BC17653DE4F60SN6PR12MB2656namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"Microsoft YaHei";}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Sure<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Zhu, Rex <br>
<b>Sent:</b> 2018<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>10<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>24<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 16:37<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/powerplay: support hwmon max/min fa=
n speed setting on Vega20<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"color:black">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percen=
t =3D current_rpm * 100 / pp_table-&gt;FanMaximumRpm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D (current_rpm * 100) /=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM;</span><span s=
tyle=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">Better check </span><span s=
tyle=3D"color:black">hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM</span><s=
pan style=3D"font-size:12.0pt;color:black"> not equal to 0.<o:p></o:p></spa=
n></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Best Regards<o:p></o:p></sp=
an></p>
<p><span style=3D"font-size:12.0pt;color:black">Rex<o:p></o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br>
<b>Sent:</b> Wednesday, October 24, 2018 4:11 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/powerplay: support hwmon max/min fan sp=
eed setting on Vega20</span><span style=3D"font-size:12.0pt;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Added support for hwmon =
max/min fan speed setting on Vega20.<br>
<br>
Change-Id: Ieab42c744d6c54f8b85a71be80f7c6832ae7352b<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; |&nbsp; =
4 &#43;&#43;<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_thermal.c&nbsp; | 56 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;-<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_thermal.h&nbsp; |&nbsp; 4 &#43;&#4=
3;<br>
&nbsp;3 files changed, 62 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 57143d51e3ee..2513e6be3219 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -3539,6 &#43;3539,10 @@ static const struct pp_hwmgr_func vega20_hwmgr_f=
uncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_get_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode =3D<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_set_fan_control_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_max_rpm =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_set_fan_speed_max_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_min_rpm =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_set_fan_speed_min_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu memory related */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_cac_buffer_info =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_notify_cac_buffer_info,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
index ede54e87e287..da9fd2168dcb 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
@@ -118,7 &#43;118,6 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp=
_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *speed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =
=3D (struct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pp_table =3D &amp;(data-&g=
t;smc_state_table.pp_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t current_rpm, perc=
ent =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
@@ -126,7 &#43;125,8 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp=
_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D current_rpm * 100 / pp_ta=
ble-&gt;FanMaximumRpm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D (current_rpm * 100) /=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *speed =3D percent &gt; 10=
0 ? 100 : percent;<br>
&nbsp;<br>
@@ -208,6 &#43;208,58 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hw=
mgr *hwmgr, uint32_t speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega20_fan_ctrl_set=
_static_mode(hwmgr, FDO_PWM_MODE_STATIC_RPM);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int vega20_fan_ctrl_set_fan_speed_max_rpm(struct pp_hwmgr *hwmgr, uint=
32_t speed)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D (st=
ruct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_settings *od8_s=
ettings =3D &amp;(data-&gt;od8_settings);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((od8_settings-&gt;overdrive8_=
capabilities &amp; OD8_ACOUSTIC_LIMIT_SCLK) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (speed &g=
t; od8_settings-&gt;od8_settings_array[OD8_SETTING_FAN_ACOUSTIC_LIMIT].max_=
value ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spe=
ed &lt; od8_settings-&gt;od8_settings_array[OD8_SETTING_FAN_ACOUSTIC_LIMIT]=
.min_value))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc_with=
_parameter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Se=
tFanMaxRpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; speed);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Set Fa=
nMaxRpm Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanI=
nfo.ulMinRPM =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (speed * hwmgr-&gt;thermal_controller.fanInfo.ulMinPWM) / 25=
5;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;int vega20_fan_ctrl_set_fan_speed_min_rpm(struct pp_hwmgr *hwmgr, uint=
32_t speed)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D (st=
ruct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_settings *od8_s=
ettings =3D &amp;(data-&gt;od8_settings);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pwm =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((od8_settings-&gt;overdrive8_=
capabilities &amp; OD8_FAN_SPEED_MIN) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (speed &g=
t; od8_settings-&gt;od8_settings_array[OD8_FAN_SPEED_MIN].max_value ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spe=
ed &lt; od8_settings-&gt;od8_settings_array[OD8_FAN_SPEED_MIN].min_value))<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (speed &gt; hwmgr-&gt;thermal_=
controller.fanInfo.ulMaxRPM)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm =3D (speed * 255) / hwmgr-&gt=
;thermal_controller.fanInfo.ulMaxRPM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc_with=
_parameter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Se=
tFanMinPwm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Set Fa=
nMinPwm Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanI=
nfo.ulMinPWM =3D pwm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp;* Reads the remote temperature from the SIslands thermal controller.<=
br>
&nbsp;*<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
index 2d1769bbd24e..ddfc950e90ca 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
@@ -56,6 &#43;56,10 @@ extern int vega20_fan_ctrl_get_fan_speed_rpm(struct =
pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *speed);<br>
&nbsp;extern int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t speed);<br>
&#43;extern int vega20_fan_ctrl_set_fan_speed_max_rpm(struct pp_hwmgr *hwmg=
r,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t speed);<br>
&#43;extern int vega20_fan_ctrl_set_fan_speed_min_rpm(struct pp_hwmgr *hwmg=
r,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t speed);<br>
&nbsp;extern int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwm=
gr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *speed);<br>
&nbsp;extern int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwm=
gr,<br>
-- <br>
2.19.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<o:p></o:p></span></p>
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1540370=
1438120.35346562924862934">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0cm 0cm 0cm 0cm">
<div id=3D"LPTitle_15403701438100.6054106554689949">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot;,=
sans-serif;color:#0078D7"><a href=3D"https://lists.freedesktop.org/mailman/=
listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decoration:none">am=
d-gfx
 Info Page - freedesktop.org</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_15403=
701438120.035970050768817985">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">lists.freedesktop.org<o:p></o:p></span></p>
</div>
<div id=3D"LPDescription_15403701438120.9681582559548375">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">To see the collection of prior postings to the list, visit the a=
md-gfx Archives.. Using amd-gfx: To post a message
 to all the list members, send email to <a href=3D"mailto:amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>. You can subscribe to the list, or change=
 your existing subscription, in the sections below.<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SN6PR12MB2656C84D3FDFB470BC17653DE4F60SN6PR12MB2656namp_--

--===============1253123602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1253123602==--
