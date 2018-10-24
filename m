From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/3] drm/amd/powerplay: added hwmon interfaces for setting
 max/min fan speed
Date: Wed, 24 Oct 2018 08:47:52 +0000
Message-ID: <SN6PR12MB26563DA5F631ECD8A372CDE0E4F60@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <20181024081141.18647-1-evan.quan@amd.com>,
 <20181024081141.18647-2-evan.quan@amd.com>
 <BYAPR12MB2775F650496C7DA583461501FBF60@BYAPR12MB2775.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684684474=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2775F650496C7DA583461501FBF60-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1684684474==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB26563DA5F631ECD8A372CDE0E4F60SN6PR12MB2656namp_"

--_000_SN6PR12MB26563DA5F631ECD8A372CDE0E4F60SN6PR12MB2656namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhpcyBjYW4gYmUgcGVyZm9ybWVkIHVuZGVyIGF1dG8gbW9kZS4NClRoZSBzZXR0aW5ncyBhcmUg
YWx3YXlzIGVmZmVjdGl2ZSB1bmxlc3MgdXNlciByZXNldHMgdGhlbSBiYWNrLg0KDQpSZWdhcmRz
LA0KRXZhbg0KRnJvbTogWmh1LCBSZXgNClNlbnQ6IDIwMTjE6jEw1MIyNMjVIDE2OjM2DQpUbzog
UXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGRybS9hbWQvcG93ZXJwbGF5OiBhZGRlZCBo
d21vbiBpbnRlcmZhY2VzIGZvciBzZXR0aW5nIG1heC9taW4gZmFuIHNwZWVkDQoNCg0KT25lIHF1
ZXN0aW9uOiBob3cgdG8gZXhpdCB0aGUgbWF4L21pbiBmYW4gc3BlZWQgYW5kIHJldHVybiB0byBh
dXRvIG1vZGU/DQoNCg0KDQpCZXN0IFJlZ2FyZHMNCg0KUmV4DQoNCg0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4+IG9uIGJlaGFsZiBvZiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPG1haWx0bzpl
dmFuLnF1YW5AYW1kLmNvbT4+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjQsIDIwMTggNDox
MSBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4NCkNjOiBRdWFuLCBFdmFuDQpTdWJqZWN0OiBbUEFUQ0ggMi8z
XSBkcm0vYW1kL3Bvd2VycGxheTogYWRkZWQgaHdtb24gaW50ZXJmYWNlcyBmb3Igc2V0dGluZyBt
YXgvbWluIGZhbiBzcGVlZA0KDQpOZXcgaHdtb24gaW50ZXJmYWNlcyBmb3IgbWF4aW11bSBhbmQg
bWluaW11bSBmYW4gc3BlZWQgc2V0dGluZy4NCg0KQ2hhbmdlLUlkOiBJYzllYzlmMjQyN2M2ZDM0
MjVlMWM3ZTdiNzY1ZDdkMDFhOTJmOWEyNg0KU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFu
LnF1YW5AYW1kLmNvbTxtYWlsdG86ZXZhbi5xdWFuQGFtZC5jb20+Pg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5oICAgICAgIHwgIDYgKysNCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyAgICAgICAgfCA1NiArKysrKysrKysrKysrKysr
KystDQogLi4uL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oICAgIHwgIDIg
Kw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYyB8IDQ2ICsr
KysrKysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9od21nci5o
ICAgICB8ICAyICsNCiA1IGZpbGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RwbS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5oDQppbmRleCBm
OTcyY2QxNTY3OTUuLjEyYzRlNDYxYTdiYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcG0uaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RwbS5oDQpAQCAtMzY0LDYgKzM2NCwxMiBAQCBlbnVtIGFtZGdwdV9wY2llX2dlbiB7
DQogICAgICAgICAgICAgICAgICgoYWRldiktPnBvd2VycGxheS5wcF9mdW5jcy0+ZW5hYmxlX21n
cHVfZmFuX2Jvb3N0KFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAoYWRldiktPnBvd2VycGxh
eS5wcF9oYW5kbGUpKQ0KDQorI2RlZmluZSBhbWRncHVfZHBtX3NldF9mYW5fc3BlZWRfbWF4X3Jw
bShhZGV2LCBzKSBcDQorICAgICAgICAgICAgICAgKChhZGV2KS0+cG93ZXJwbGF5LnBwX2Z1bmNz
LT5zZXRfZmFuX3NwZWVkX21heF9ycG0pKChhZGV2KS0+cG93ZXJwbGF5LnBwX2hhbmRsZSwgKHMp
KQ0KKw0KKyNkZWZpbmUgYW1kZ3B1X2RwbV9zZXRfZmFuX3NwZWVkX21pbl9ycG0oYWRldiwgcykg
XA0KKyAgICAgICAgICAgICAgICgoYWRldiktPnBvd2VycGxheS5wcF9mdW5jcy0+c2V0X2Zhbl9z
cGVlZF9taW5fcnBtKSgoYWRldiktPnBvd2VycGxheS5wcF9oYW5kbGUsIChzKSkNCisNCiBzdHJ1
Y3QgYW1kZ3B1X2RwbSB7DQogICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3BzICAgICAgICAqcHM7DQog
ICAgICAgICAvKiBudW1iZXIgb2YgdmFsaWQgcG93ZXIgc3RhdGVzICovDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uYw0KaW5kZXggOGU5NDI1NTY1NGVkLi45MmRhMzdiYjUxYmEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMNCkBAIC0xMjY1LDYgKzEy
NjUsMzIgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X2h3bW9uX2dldF9mYW4xX21pbihzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQogICAgICAgICByZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIl
ZFxuIiwgbWluX3JwbSk7DQogfQ0KDQorc3RhdGljIHNzaXplX3QgYW1kZ3B1X2h3bW9uX3NldF9m
YW4xX21pbihzdHJ1Y3QgZGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQorew0K
KyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KKyAgICAgICBpbnQgZXJyOw0KKyAgICAgICB1MzIgdmFsdWU7DQorDQorICAgICAgIC8qIENh
bid0IGFkanVzdCBmYW4gd2hlbiB0aGUgY2FyZCBpcyBvZmYgKi8NCisgICAgICAgaWYgICgoYWRl
di0+ZmxhZ3MgJiBBTURfSVNfUFgpICYmDQorICAgICAgICAgICAgKGFkZXYtPmRkZXYtPnN3aXRj
aF9wb3dlcl9zdGF0ZSAhPSBEUk1fU1dJVENIX1BPV0VSX09OKSkNCisgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCisNCisgICAgICAgZXJyID0ga3N0cnRvdTMyKGJ1ZiwgMTAsICZ2YWx1
ZSk7DQorICAgICAgIGlmIChlcnIpDQorICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCisNCisg
ICAgICAgaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+c2V0X2Zhbl9zcGVlZF9taW5fcnBt
KSB7DQorICAgICAgICAgICAgICAgZXJyID0gYW1kZ3B1X2RwbV9zZXRfZmFuX3NwZWVkX21pbl9y
cG0oYWRldiwgdmFsdWUpOw0KKyAgICAgICAgICAgICAgIGlmIChlcnIpDQorICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZXJyOw0KKyAgICAgICB9DQorDQorICAgICAgIHJldHVybiBjb3Vu
dDsNCit9DQorDQogc3RhdGljIHNzaXplX3QgYW1kZ3B1X2h3bW9uX2dldF9mYW4xX21heChzdHJ1
Y3QgZGV2aWNlICpkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1ZikNCkBAIC0xMjg1LDYgKzEzMTEsMzIgQEAgc3Rh
dGljIHNzaXplX3QgYW1kZ3B1X2h3bW9uX2dldF9mYW4xX21heChzdHJ1Y3QgZGV2aWNlICpkZXYs
DQogICAgICAgICByZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlZFxuIiwgbWF4X3Jw
bSk7DQogfQ0KDQorc3RhdGljIHNzaXplX3QgYW1kZ3B1X2h3bW9uX3NldF9mYW4xX21heChzdHJ1
Y3QgZGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQorew0KKyAgICAgICBzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KKyAgICAgICBp
bnQgZXJyOw0KKyAgICAgICB1MzIgdmFsdWU7DQorDQorICAgICAgIC8qIENhbid0IGFkanVzdCBm
YW4gd2hlbiB0aGUgY2FyZCBpcyBvZmYgKi8NCisgICAgICAgaWYgICgoYWRldi0+ZmxhZ3MgJiBB
TURfSVNfUFgpICYmDQorICAgICAgICAgICAgKGFkZXYtPmRkZXYtPnN3aXRjaF9wb3dlcl9zdGF0
ZSAhPSBEUk1fU1dJVENIX1BPV0VSX09OKSkNCisgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCisNCisgICAgICAgZXJyID0ga3N0cnRvdTMyKGJ1ZiwgMTAsICZ2YWx1ZSk7DQorICAgICAg
IGlmIChlcnIpDQorICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCisNCisgICAgICAgaWYgKGFk
ZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+c2V0X2Zhbl9zcGVlZF9tYXhfcnBtKSB7DQorICAgICAg
ICAgICAgICAgZXJyID0gYW1kZ3B1X2RwbV9zZXRfZmFuX3NwZWVkX21heF9ycG0oYWRldiwgdmFs
dWUpOw0KKyAgICAgICAgICAgICAgIGlmIChlcnIpDQorICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gZXJyOw0KKyAgICAgICB9DQorDQorICAgICAgIHJldHVybiBjb3VudDsNCit9DQorDQog
c3RhdGljIHNzaXplX3QgYW1kZ3B1X2h3bW9uX2dldF9mYW4xX3RhcmdldChzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjaGFyICpidWYpDQpAQCAtMTYyOCw4ICsxNjgwLDggQEAgc3RhdGljIFNF
TlNPUl9ERVZJQ0VfQVRUUihwd20xX2VuYWJsZSwgU19JUlVHTyB8IFNfSVdVU1IsIGFtZGdwdV9o
d21vbl9nZXRfcHdtMV8NCiBzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHB3bTFfbWluLCBTX0lS
VUdPLCBhbWRncHVfaHdtb25fZ2V0X3B3bTFfbWluLCBOVUxMLCAwKTsNCiBzdGF0aWMgU0VOU09S
X0RFVklDRV9BVFRSKHB3bTFfbWF4LCBTX0lSVUdPLCBhbWRncHVfaHdtb25fZ2V0X3B3bTFfbWF4
LCBOVUxMLCAwKTsNCiBzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKGZhbjFfaW5wdXQsIFNfSVJV
R08sIGFtZGdwdV9od21vbl9nZXRfZmFuMV9pbnB1dCwgTlVMTCwgMCk7DQotc3RhdGljIFNFTlNP
Ul9ERVZJQ0VfQVRUUihmYW4xX21pbiwgU19JUlVHTywgYW1kZ3B1X2h3bW9uX2dldF9mYW4xX21p
biwgTlVMTCwgMCk7DQotc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUihmYW4xX21heCwgU19JUlVH
TywgYW1kZ3B1X2h3bW9uX2dldF9mYW4xX21heCwgTlVMTCwgMCk7DQorc3RhdGljIFNFTlNPUl9E
RVZJQ0VfQVRUUihmYW4xX21pbiwgU19JUlVHTyB8IFNfSVdVU1IsIGFtZGdwdV9od21vbl9nZXRf
ZmFuMV9taW4sIGFtZGdwdV9od21vbl9zZXRfZmFuMV9taW4sIDApOw0KK3N0YXRpYyBTRU5TT1Jf
REVWSUNFX0FUVFIoZmFuMV9tYXgsIFNfSVJVR08gfCBTX0lXVVNSLCBhbWRncHVfaHdtb25fZ2V0
X2ZhbjFfbWF4LCBhbWRncHVfaHdtb25fc2V0X2ZhbjFfbWF4LCAwKTsNCiBzdGF0aWMgU0VOU09S
X0RFVklDRV9BVFRSKGZhbjFfdGFyZ2V0LCBTX0lSVUdPIHwgU19JV1VTUiwgYW1kZ3B1X2h3bW9u
X2dldF9mYW4xX3RhcmdldCwgYW1kZ3B1X2h3bW9uX3NldF9mYW4xX3RhcmdldCwgMCk7DQogc3Rh
dGljIFNFTlNPUl9ERVZJQ0VfQVRUUihmYW4xX2VuYWJsZSwgU19JUlVHTyB8IFNfSVdVU1IsIGFt
ZGdwdV9od21vbl9nZXRfZmFuMV9lbmFibGUsIGFtZGdwdV9od21vbl9zZXRfZmFuMV9lbmFibGUs
IDApOw0KIHN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFIoaW4wX2lucHV0LCBTX0lSVUdPLCBhbWRn
cHVfaHdtb25fc2hvd192ZGRnZngsIE5VTEwsIDApOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oDQppbmRleCA5ODBlNjk2OTg5YjEuLjFhZjU1OTk3
YmRiOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50
ZXJmYWNlLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJm
YWNlLmgNCkBAIC0yNzYsNiArMjc2LDggQEAgc3RydWN0IGFtZF9wbV9mdW5jcyB7DQogICAgICAg
ICAgICAgICAgIHN0cnVjdCBhbWRfcHBfc2ltcGxlX2Nsb2NrX2luZm8gKmNsb2Nrcyk7DQogICAg
ICAgICBpbnQgKCpub3RpZnlfc211X2VuYWJsZV9wd2UpKHZvaWQgKmhhbmRsZSk7DQogICAgICAg
ICBpbnQgKCplbmFibGVfbWdwdV9mYW5fYm9vc3QpKHZvaWQgKmhhbmRsZSk7DQorICAgICAgIGlu
dCAoKnNldF9mYW5fc3BlZWRfbWF4X3JwbSkodm9pZCAqaGFuZGxlLCB1aW50MzJfdCBycG0pOw0K
KyAgICAgICBpbnQgKCpzZXRfZmFuX3NwZWVkX21pbl9ycG0pKHZvaWQgKmhhbmRsZSwgdWludDMy
X3QgcnBtKTsNCiB9Ow0KDQogI2VuZGlmDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvYW1kX3Bvd2VycGxheS5jDQppbmRleCA1ODZmMWZmOWY3M2UuLmYxMDIzN2I0ZDA1NyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jDQpAQCAt
NjAzLDYgKzYwMyw1MCBAQCBzdGF0aWMgaW50IHBwX2RwbV9zZXRfZmFuX3NwZWVkX3JwbSh2b2lk
ICpoYW5kbGUsIHVpbnQzMl90IHJwbSkNCiAgICAgICAgIHJldHVybiByZXQ7DQogfQ0KDQorc3Rh
dGljIGludCBwcF9kcG1fc2V0X2Zhbl9zcGVlZF9tYXhfcnBtKHZvaWQgKmhhbmRsZSwgdWludDMy
X3QgcnBtKQ0KK3sNCisgICAgICAgc3RydWN0IHBwX2h3bWdyICpod21nciA9IGhhbmRsZTsNCisg
ICAgICAgaW50IHJldCA9IDA7DQorDQorICAgICAgIGlmICghaHdtZ3IgfHwgIWh3bWdyLT5wbV9l
bikNCisgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCisNCisgICAgICAgaWYgKGh3bWdy
LT5od21ncl9mdW5jLT5zZXRfZmFuX3NwZWVkX21heF9ycG0gPT0gTlVMTCkgew0KKyAgICAgICAg
ICAgICAgIHByX2luZm8oIiVzIHdhcyBub3QgaW1wbGVtZW50ZWQuXG4iLCBfX2Z1bmNfXyk7DQor
ICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KKyAgICAgICB9DQorICAgICAgIG11
dGV4X2xvY2soJmh3bWdyLT5zbXVfbG9jayk7DQorICAgICAgIHJldCA9IGh3bWdyLT5od21ncl9m
dW5jLT5zZXRfZmFuX3NwZWVkX21heF9ycG0oaHdtZ3IsIHJwbSk7DQorICAgICAgIG11dGV4X3Vu
bG9jaygmaHdtZ3ItPnNtdV9sb2NrKTsNCisNCisgICAgICAgaWYgKCFyZXQpDQorICAgICAgICAg
ICAgICAgaHdtZ3ItPnRoZXJtYWxfY29udHJvbGxlci5mYW5JbmZvLnVsTWF4UlBNID0gcnBtOw0K
Kw0KKyAgICAgICByZXR1cm4gcmV0Ow0KK30NCisNCitzdGF0aWMgaW50IHBwX2RwbV9zZXRfZmFu
X3NwZWVkX21pbl9ycG0odm9pZCAqaGFuZGxlLCB1aW50MzJfdCBycG0pDQorew0KKyAgICAgICBz
dHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyID0gaGFuZGxlOw0KKyAgICAgICBpbnQgcmV0ID0gMDsNCisN
CisgICAgICAgaWYgKCFod21nciB8fCAhaHdtZ3ItPnBtX2VuKQ0KKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KKw0KKyAgICAgICBpZiAoaHdtZ3ItPmh3bWdyX2Z1bmMtPnNldF9mYW5f
c3BlZWRfbWluX3JwbSA9PSBOVUxMKSB7DQorICAgICAgICAgICAgICAgcHJfaW5mbygiJXMgd2Fz
IG5vdCBpbXBsZW1lbnRlZC5cbiIsIF9fZnVuY19fKTsNCisgICAgICAgICAgICAgICByZXR1cm4g
LUVPUE5PVFNVUFA7DQorICAgICAgIH0NCisgICAgICAgbXV0ZXhfbG9jaygmaHdtZ3ItPnNtdV9s
b2NrKTsNCisgICAgICAgcmV0ID0gaHdtZ3ItPmh3bWdyX2Z1bmMtPnNldF9mYW5fc3BlZWRfbWlu
X3JwbShod21nciwgcnBtKTsNCisgICAgICAgbXV0ZXhfdW5sb2NrKCZod21nci0+c211X2xvY2sp
Ow0KKw0KKyAgICAgICBpZiAoIXJldCkNCisgICAgICAgICAgICAgICBod21nci0+dGhlcm1hbF9j
b250cm9sbGVyLmZhbkluZm8udWxNaW5SUE0gPSBycG07DQorDQorICAgICAgIHJldHVybiByZXQ7
DQorfQ0KKw0KIHN0YXRpYyBpbnQgcHBfZHBtX2dldF9wcF9udW1fc3RhdGVzKHZvaWQgKmhhbmRs
ZSwNCiAgICAgICAgICAgICAgICAgc3RydWN0IHBwX3N0YXRlc19pbmZvICpkYXRhKQ0KIHsNCkBA
IC0xMzQyLDYgKzEzODYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZF9wbV9mdW5jcyBwcF9k
cG1fZnVuY3MgPSB7DQogICAgICAgICAuZ2V0X2Zhbl9zcGVlZF9wZXJjZW50ID0gcHBfZHBtX2dl
dF9mYW5fc3BlZWRfcGVyY2VudCwNCiAgICAgICAgIC5nZXRfZmFuX3NwZWVkX3JwbSA9IHBwX2Rw
bV9nZXRfZmFuX3NwZWVkX3JwbSwNCiAgICAgICAgIC5zZXRfZmFuX3NwZWVkX3JwbSA9IHBwX2Rw
bV9zZXRfZmFuX3NwZWVkX3JwbSwNCisgICAgICAgLnNldF9mYW5fc3BlZWRfbWF4X3JwbSA9IHBw
X2RwbV9zZXRfZmFuX3NwZWVkX21heF9ycG0sDQorICAgICAgIC5zZXRfZmFuX3NwZWVkX21pbl9y
cG0gPSBwcF9kcG1fc2V0X2Zhbl9zcGVlZF9taW5fcnBtLA0KICAgICAgICAgLmdldF9wcF9udW1f
c3RhdGVzID0gcHBfZHBtX2dldF9wcF9udW1fc3RhdGVzLA0KICAgICAgICAgLmdldF9wcF90YWJs
ZSA9IHBwX2RwbV9nZXRfcHBfdGFibGUsDQogICAgICAgICAuc2V0X3BwX3RhYmxlID0gcHBfZHBt
X3NldF9wcF90YWJsZSwNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9pbmMvaHdtZ3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9od21nci5o
DQppbmRleCA2ODdmNzNmZTRjZjUuLjAyNDJiYzAzOWE0OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9od21nci5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaA0KQEAgLTI2OSw2ICsyNjksOCBAQCBzdHJ1Y3QgcHBf
aHdtZ3JfZnVuYyB7DQogICAgICAgICBpbnQgKCpnZXRfZmFuX3NwZWVkX3BlcmNlbnQpKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IsIHVpbnQzMl90ICpzcGVlZCk7DQogICAgICAgICBpbnQgKCpzZXRf
ZmFuX3NwZWVkX3JwbSkoc3RydWN0IHBwX2h3bWdyICpod21nciwgdWludDMyX3QgcGVyY2VudCk7
DQogICAgICAgICBpbnQgKCpnZXRfZmFuX3NwZWVkX3JwbSkoc3RydWN0IHBwX2h3bWdyICpod21n
ciwgdWludDMyX3QgKnNwZWVkKTsNCisgICAgICAgaW50ICgqc2V0X2Zhbl9zcGVlZF9tYXhfcnBt
KShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1aW50MzJfdCBtYXhfcnBtKTsNCisgICAgICAgaW50
ICgqc2V0X2Zhbl9zcGVlZF9taW5fcnBtKShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1aW50MzJf
dCBtaW5fcnBtKTsNCiAgICAgICAgIGludCAoKnJlc2V0X2Zhbl9zcGVlZF90b19kZWZhdWx0KShz
dHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsNCiAgICAgICAgIGludCAoKnVuaW5pdGlhbGl6ZV90aGVy
bWFsX2NvbnRyb2xsZXIpKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpOw0KICAgICAgICAgaW50ICgq
cmVnaXN0ZXJfaXJxX2hhbmRsZXJzKShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsNCi0tDQoyLjE5
LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFt
ZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCmFtZC1nZnggSW5mbyBQYWdlIC0gZnJlZWRl
c2t0b3Aub3JnPGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeD4NCmxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KVG8gc2VlIHRoZSBjb2xsZWN0aW9uIG9m
IHByaW9yIHBvc3RpbmdzIHRvIHRoZSBsaXN0LCB2aXNpdCB0aGUgYW1kLWdmeCBBcmNoaXZlcy4u
IFVzaW5nIGFtZC1nZng6IFRvIHBvc3QgYSBtZXNzYWdlIHRvIGFsbCB0aGUgbGlzdCBtZW1iZXJz
LCBzZW5kIGVtYWlsIHRvIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4uIFlvdSBjYW4gc3Vic2NyaWJlIHRvIHRoZSBsaXN0
LCBvciBjaGFuZ2UgeW91ciBleGlzdGluZyBzdWJzY3JpcHRpb24sIGluIHRoZSBzZWN0aW9ucyBi
ZWxvdy4NCg0KDQo=

--_000_SN6PR12MB26563DA5F631ECD8A372CDE0E4F60SN6PR12MB2656namp_
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
<p class=3D"MsoNormal">This can be performed under auto mode. <o:p></o:p></=
p>
<p class=3D"MsoNormal">The settings are always effective unless user resets=
 them back.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
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
=DA&quot;,sans-serif">=C8=D5</span> 16:36<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amd/powerplay: added hwmon interfaces f=
or setting max/min fan speed<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">One question: how to exit t=
he max/min fan speed and return to auto mode?<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Best Regards<o:p></o:p></sp=
an></p>
<p><span style=3D"font-size:12.0pt;color:black">Rex<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
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
<b>Subject:</b> [PATCH 2/3] drm/amd/powerplay: added hwmon interfaces for s=
etting max/min fan speed</span><span style=3D"font-size:12.0pt;color:black"=
>
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">New hwmon interfaces for=
 maximum and minimum fan speed setting.<br>
<br>
Change-Id: Ic9ec9f2427c6d3425e1c7e7b765d7d01a92f9a26<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 6 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 56 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; |&nbsp; =
2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 46 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 &#43;<br>
&nbsp;5 files changed, 110 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.h<br>
index f972cd156795..12c4e461a7bc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
@@ -364,6 &#43;364,12 @@ enum amdgpu_pcie_gen {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;enable_mgpu_fan_bo=
ost(\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev=
)-&gt;powerplay.pp_handle))<br>
&nbsp;<br>
&#43;#define amdgpu_dpm_set_fan_speed_max_rpm(adev, s) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_fan_speed_max_rpm)((a=
dev)-&gt;powerplay.pp_handle, (s))<br>
&#43;<br>
&#43;#define amdgpu_dpm_set_fan_speed_min_rpm(adev, s) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_fan_speed_min_rpm)((a=
dev)-&gt;powerplay.pp_handle, (s))<br>
&#43;<br>
&nbsp;struct amdgpu_dpm {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ps&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ps;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of valid power s=
tates */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 8e94255654ed..92da37bb51ba 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1265,6 &#43;1265,32 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_=
SIZE, &quot;%d\n&quot;, min_rpm);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static ssize_t amdgpu_hwmon_set_fan1_min(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct de=
vice_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const cha=
r *buf, size_t count)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v_get_drvdata(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card=
 is off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; A=
MD_IS_PX) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ad=
ev-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtou32(buf, 10, &amp;v=
alue);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return err;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&=
gt;set_fan_speed_min_rpm) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_min_rpm(adev, value);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&#43;}<br>
&#43;<br>
&nbsp;static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
@@ -1285,6 &#43;1311,32 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_=
SIZE, &quot;%d\n&quot;, max_rpm);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static ssize_t amdgpu_hwmon_set_fan1_max(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct de=
vice_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const cha=
r *buf, size_t count)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v_get_drvdata(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card=
 is off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; A=
MD_IS_PX) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ad=
ev-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtou32(buf, 10, &amp;v=
alue);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return err;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&=
gt;set_fan_speed_max_rpm) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_max_rpm(adev, value);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&#43;}<br>
&#43;<br>
&nbsp;static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
@@ -1628,8 &#43;1680,8 @@ static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | =
S_IWUSR, amdgpu_hwmon_get_pwm1_<br>
&nbsp;static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, amdgpu_hwmon_get_pwm1_mi=
n, NULL, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO, amdgpu_hwmon_get_pwm1_ma=
x, NULL, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, amdgpu_hwmon_get_fan1_=
input, NULL, 0);<br>
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, amdgpu_hwmon_get_fan1_min, NU=
LL, 0);<br>
-static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO, amdgpu_hwmon_get_fan1_max, NU=
LL, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR, amdgpu_hwmon_ge=
t_fan1_min, amdgpu_hwmon_set_fan1_min, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO | S_IWUSR, amdgpu_hwmon_ge=
t_fan1_max, amdgpu_hwmon_set_fan1_max, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, amdgpu_hwmo=
n_get_fan1_target, amdgpu_hwmon_set_fan1_target, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(fan1_enable, S_IRUGO | S_IWUSR, amdgpu_hwmo=
n_get_fan1_enable, amdgpu_hwmon_set_fan1_enable, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, amdgpu_hwmon_show_vddgf=
x, NULL, 0);<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 980e696989b1..1af55997bdb9 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -276,6 &#43;276,8 @@ struct amd_pm_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *clocks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_smu_enable_pw=
e)(void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*enable_mgpu_fan_boos=
t)(void *handle);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_max_rpm)(void=
 *handle, uint32_t rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_min_rpm)(void=
 *handle, uint32_t rpm);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 586f1ff9f73e..f10237b4d057 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -603,6 &#43;603,50 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, =
uint32_t rpm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int pp_dpm_set_fan_speed_max_rpm(void *handle, uint32_t rpm)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
fan_speed_max_rpm =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func__);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;=
set_fan_speed_max_rpm(hwmgr, rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM =3D rpm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int pp_dpm_set_fan_speed_min_rpm(void *handle, uint32_t rpm)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
fan_speed_min_rpm =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func__);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;=
set_fan_speed_min_rpm(hwmgr, rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMinRPM =3D rpm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int pp_dpm_get_pp_num_states(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_states_info *data)<br>
&nbsp;{<br>
@@ -1342,6 &#43;1386,8 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D=
 pp_dpm_get_fan_speed_percent,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm =3D pp_=
dpm_get_fan_speed_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm =3D pp_=
dpm_set_fan_speed_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_max_rpm =3D pp_dpm=
_set_fan_speed_max_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_min_rpm =3D pp_dpm=
_set_fan_speed_min_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_num_states =3D pp_=
dpm_get_pp_num_states,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_table =3D pp_dpm_g=
et_pp_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pp_table =3D pp_dpm_s=
et_pp_table,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 687f73fe4cf5..0242bc039a48 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -269,6 &#43;269,8 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_fan_speed_percen=
t)(struct pp_hwmgr *hwmgr, uint32_t *speed);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_rpm)(s=
truct pp_hwmgr *hwmgr, uint32_t percent);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_fan_speed_rpm)(s=
truct pp_hwmgr *hwmgr, uint32_t *speed);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_max_rpm)(stru=
ct pp_hwmgr *hwmgr, uint32_t max_rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_min_rpm)(stru=
ct pp_hwmgr *hwmgr, uint32_t min_rpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*reset_fan_speed_to_d=
efault)(struct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*uninitialize_thermal=
_controller)(struct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*register_irq_handler=
s)(struct pp_hwmgr *hwmgr);<br>
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
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1540369=
8863000.14269909928300328">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0cm 0cm 0cm 0cm">
<div id=3D"LPTitle_15403698863000.9916224528545828">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot;,=
sans-serif;color:#0078D7"><a href=3D"https://lists.freedesktop.org/mailman/=
listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decoration:none">am=
d-gfx
 Info Page - freedesktop.org</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_15403=
698863000.39120505537129757">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">lists.freedesktop.org<o:p></o:p></span></p>
</div>
<div id=3D"LPDescription_15403698863000.17702711523041492">
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

--_000_SN6PR12MB26563DA5F631ECD8A372CDE0E4F60SN6PR12MB2656namp_--

--===============1684684474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1684684474==--
