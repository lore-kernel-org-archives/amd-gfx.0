From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: add baco smu reset function for smu11
Date: Thu, 4 Jul 2019 05:08:47 +0000
Message-ID: <DM5PR12MB1418237449E535A95A23E566FCFA0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20190703030931.27890-1-kevin1.wang@amd.com>
 <MN2PR12MB3296575FE79BC02F2E406C64A2FA0@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1504976355=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3296575FE79BC02F2E406C64A2FA0-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

--===============1504976355==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1418237449E535A95A23E566FCFA0DM5PR12MB1418namp_"

--_000_DM5PR12MB1418237449E535A95A23E566FCFA0DM5PR12MB1418namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KRnJv
bTogV2FuZywgS2V2aW4oWWFuZykgPEtldmluMS5XYW5nQGFtZC5jb20+DQpTZW50OiAyMDE5xOo3
1MI0yNUgMTE6MTMNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5n
LCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9A
YW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8
S2VubmV0aC5GZW5nQGFtZC5jb20+OyBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgYmFjbyBzbXUgcmVzZXQg
ZnVuY3Rpb24gZm9yIHNtdTExDQoNCg0KcGluZy4uLiwNCg0Kd2hpY2ggb25lIGNhbiBoZWxwIG1l
IHJldmlldyB0aGlzIHBhdGNoLg0KDQp0aGFua3MuDQoNCg0KDQpCZXN0IFJlZ2FyZHMsDQoNCktl
dmluDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBXYW5nLCBLZXZp
bihZYW5nKQ0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDMsIDIwMTkgMTE6MDk6NDUgQU0NClRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+DQpDYzogWmhhbmcsIEhhd2tpbmc7IFhpYW8sIEphY2s7IEh1YW5nLCBSYXk7IFdh
bmcsIEtldmluKFlhbmcpDQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQg
YmFjbyBzbXUgcmVzZXQgZnVuY3Rpb24gZm9yIHNtdTExDQoNCmFkZCBiYWNvIHJlc2V0IHN1cHBv
cnQgZm9yIHNtdTExLg0KaXQgY2FuIGhlbHAgZ3B1IGRvIGFzaWMgcmVzZXQgd2hlbiBncHUgcmVj
b3ZlcnkuDQoNCkNoYW5nZS1JZDogSTc3MTRlZDAzYWQ4N2MxM2U5M2NhMWE3ZTZhZWY4MWViYTE0
NjY3YzgNClNpZ25lZC1vZmYtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb208bWFp
bHRvOmtldmluMS53YW5nQGFtZC5jb20+Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMgICAgICAgIHwgIDYgKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9udi5jICAgICAgICAgICAgICAgfCAgOSArLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZGdwdV9zbXUuYyAgICB8IDE0ICsrKw0KIC4uLi9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aW5jL2FtZGdwdV9zbXUuaCAgICB8IDI2ICsrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVfdjExXzAuaCB8ICA4ICsrDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvbmF2aTEwX3BwdC5jICAgIHwgIDggKysNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVfdjExXzAuYyAgICAgfCA5MSArKysrKysrKysrKysrKysrKysrDQogNyBmaWxlcyBj
aGFuZ2VkLCAxNTkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCmluZGV4IGI0MTE2OTI2MWY3ZC4uNDVkZDIyYTFlZjc3
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQpAQCAtMjQ0LDggKzI0
NCwxMCBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwNCiAgICAgICAgIG11dGV4X2xvY2soJmFkZXYtPm1tYW4uZ3R0X3dpbmRv
d19sb2NrKTsNCg0KICAgICAgICAgZ21jX3YxMF8wX2ZsdXNoX3ZtX2h1YihhZGV2LCB2bWlkLCBB
TURHUFVfTU1IVUIsIDApOw0KLSAgICAgICBpZiAoIWFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzX2Vu
YWJsZWQgfHwgIWFkZXYtPmliX3Bvb2xfcmVhZHkgfHwNCi0gICAgICAgICAgIGFkZXYtPmFzaWNf
dHlwZSAhPSBDSElQX05BVkkxMCkgew0KKyAgICAgICBpZiAoIWFkZXYtPm1tYW4uYnVmZmVyX2Z1
bmNzX2VuYWJsZWQgfHwNCisgICAgICAgICAgICFhZGV2LT5pYl9wb29sX3JlYWR5IHx8DQorICAg
ICAgICAgICBhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9OQVZJMTAgfHwNCisgICAgICAgICAgIGFk
ZXYtPmluX2dwdV9yZXNldCkgew0KICAgICAgICAgICAgICAgICBnbWNfdjEwXzBfZmx1c2hfdm1f
aHViKGFkZXYsIHZtaWQsIEFNREdQVV9HRlhIVUIsIDApOw0KICAgICAgICAgICAgICAgICBtdXRl
eF91bmxvY2soJmFkZXYtPm1tYW4uZ3R0X3dpbmRvd19sb2NrKTsNCiAgICAgICAgICAgICAgICAg
cmV0dXJuOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jDQppbmRleCA4ZjYwNTQxN2I0MGEuLmNjNWQw
NjcxOGU0YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMNCkBAIC0zMSw2ICszMSw3IEBADQog
I2luY2x1ZGUgImFtZGdwdV92Y2UuaCINCiAjaW5jbHVkZSAiYW1kZ3B1X3Vjb2RlLmgiDQogI2lu
Y2x1ZGUgImFtZGdwdV9wc3AuaCINCisjaW5jbHVkZSAiYW1kZ3B1X3NtdS5oIg0KICNpbmNsdWRl
ICJhdG9tLmgiDQogI2luY2x1ZGUgImFtZF9wY2llLmgiDQoNCkBAIC0yNjYsOCArMjY3LDE0IEBA
IHN0YXRpYyBpbnQgbnZfYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCg0K
ICAgICAgICAgYW1kZ3B1X2F0b21iaW9zX3NjcmF0Y2hfcmVnc19lbmdpbmVfaHVuZyhhZGV2LCBm
YWxzZSk7DQogI2VuZGlmDQorICAgICAgIGludCByZXQgPSAwOw0KKyAgICAgICBzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSA9ICZhZGV2LT5zbXU7DQoNCi0gICAgICAgcmV0dXJuIDA7DQorICAgICAg
IGlmIChzbXVfYmFjb19pc19zdXBwb3J0KHNtdSkpIHsNCisgICAgICAgICAgICAgICByZXQgPSBz
bXVfYmFjb19yZXNldChzbXUpOw0KKyAgICAgICB9DQorDQorICAgICAgIHJldHVybiByZXQ7DQog
fQ0KDQogc3RhdGljIGludCBudl9zZXRfdXZkX2Nsb2NrcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgdTMyIHZjbGssIHUzMiBkY2xrKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYw0KaW5kZXggYjI4YTkyM2Y5OThkLi5mYzQxNmM2ODYxNTEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KQEAgLTYzMyw2ICs2MzMs
MTEgQEAgc3RhdGljIGludCBzbXVfc3dfaW5pdCh2b2lkICpoYW5kbGUpDQogICAgICAgICBiaXRt
YXBfemVybyhzbXUtPnNtdV9mZWF0dXJlLnN1cHBvcnRlZCwgU01VX0ZFQVRVUkVfTUFYKTsNCiAg
ICAgICAgIGJpdG1hcF96ZXJvKHNtdS0+c211X2ZlYXR1cmUuZW5hYmxlZCwgU01VX0ZFQVRVUkVf
TUFYKTsNCiAgICAgICAgIGJpdG1hcF96ZXJvKHNtdS0+c211X2ZlYXR1cmUuYWxsb3dlZCwgU01V
X0ZFQVRVUkVfTUFYKTsNCisNCisgICAgICAgbXV0ZXhfaW5pdCgmc211LT5zbXVfYmFjby5tdXRl
eCk7DQorICAgICAgIHNtdS0+c211X2JhY28uc3RhdGUgPSBTTVVfQkFDT19TVEFURV9FWElUOw0K
KyAgICAgICBzbXUtPnNtdV9iYWNvLnBsYXRmb3JtX3N1cHBvcnQgPSBmYWxzZTsNCisNCiAgICAg
ICAgIHNtdS0+d2F0ZXJtYXJrc19iaXRtYXAgPSAwOw0KICAgICAgICAgc211LT5wb3dlcl9wcm9m
aWxlX21vZGUgPSBQUF9TTUNfUE9XRVJfUFJPRklMRV9CT09UVVBfREVGQVVMVDsNCiAgICAgICAg
IHNtdS0+ZGVmYXVsdF9wb3dlcl9wcm9maWxlX21vZGUgPSBQUF9TTUNfUE9XRVJfUFJPRklMRV9C
T09UVVBfREVGQVVMVDsNCkBAIC0xMDU3LDExICsxMDYyLDIwIEBAIHN0YXRpYyBpbnQgc211X3N1
c3BlbmQodm9pZCAqaGFuZGxlKQ0KICAgICAgICAgaW50IHJldDsNCiAgICAgICAgIHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0KICAg
ICAgICAgc3RydWN0IHNtdV9jb250ZXh0ICpzbXUgPSAmYWRldi0+c211Ow0KKyAgICAgICBib29s
IGJhY29fZmVhdHVyZV9pc19lbmFibGVkID0gc211X2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsIFNN
VV9GRUFUVVJFX0JBQ09fQklUKTsNCg0KICAgICAgICAgcmV0ID0gc211X3N5c3RlbV9mZWF0dXJl
c19jb250cm9sKHNtdSwgZmFsc2UpOw0KICAgICAgICAgaWYgKHJldCkNCiAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCg0KKyAgICAgICBpZiAoYWRldi0+aW5fZ3B1X3Jlc2V0ICYmIGJhY29f
ZmVhdHVyZV9pc19lbmFibGVkKSB7DQorICAgICAgICAgICAgICAgcmV0ID0gc211X2ZlYXR1cmVf
c2V0X2VuYWJsZWQoc211LCBTTVVfRkVBVFVSRV9CQUNPX0JJVCwgdHJ1ZSk7DQorICAgICAgICAg
ICAgICAgaWYgKHJldCkgew0KKyAgICAgICAgICAgICAgICAgICAgICAgcHJfd2Fybigic2V0IEJB
Q08gZmVhdHVyZSBlbmFibGVkIGZhaWxlZCwgcmV0dXJuICVkXG4iLCByZXQpOw0KKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCisgICAgICAgICAgICAgICB9DQorICAgICAgIH0N
CisNCiAgICAgICAgIHNtdS0+d2F0ZXJtYXJrc19iaXRtYXAgJj0gfihXQVRFUk1BUktTX0xPQURF
RCk7DQoNCiAgICAgICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9OQVZJMTAgJiYNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaA0KaW5kZXgg
MjgxOGRmNDY0ODFjLi5jOTczMjRlZjdkYjIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oDQpAQCAtMjQxLDYgKzI0MSw3IEBAIGVudW0gc211
X21lc3NhZ2VfdHlwZQ0KICAgICAgICAgU01VX01TR19Qb3dlclVwSnBlZywNCiAgICAgICAgIFNN
VV9NU0dfUG93ZXJEb3duSnBlZywNCiAgICAgICAgIFNNVV9NU0dfQmFjb0F1ZGlvRDNQTUUsDQor
ICAgICAgIFNNVV9NU0dfQXJtRDMsDQogICAgICAgICBTTVVfTVNHX01BWF9DT1VOVCwNCiB9Ow0K
DQpAQCAtNDg5LDYgKzQ5MCwxOSBAQCBzdHJ1Y3QgbWNsb2NrX2xhdGVuY3lfdGFibGUgew0KICAg
ICAgICAgc3RydWN0IG1jbGtfbGF0ZW5jeV9lbnRyaWVzICBlbnRyaWVzW01BWF9SRUdVTEFSX0RQ
TV9OVU1dOw0KIH07DQoNCitlbnVtIHNtdV9iYWNvX3N0YXRlDQorew0KKyAgICAgICBTTVVfQkFD
T19TVEFURV9FTlRFUiA9IDAsDQorICAgICAgIFNNVV9CQUNPX1NUQVRFX0VYSVQsDQorfTsNCisN
CitzdHJ1Y3Qgc211X2JhY29fY29udGV4dA0KK3sNCisgICAgICAgc3RydWN0IG11dGV4IG11dGV4
Ow0KKyAgICAgICB1aW50MzJfdCBzdGF0ZTsNCisgICAgICAgYm9vbCBwbGF0Zm9ybV9zdXBwb3J0
Ow0KK307DQorDQogI2RlZmluZSBXT1JLTE9BRF9QT0xJQ1lfTUFYIDcNCiBzdHJ1Y3Qgc211X2Nv
bnRleHQNCiB7DQpAQCAtNTA1LDYgKzUxOSw3IEBAIHN0cnVjdCBzbXVfY29udGV4dA0KICAgICAg
ICAgc3RydWN0IHNtdV9wb3dlcl9jb250ZXh0ICAgICAgICBzbXVfcG93ZXI7DQogICAgICAgICBz
dHJ1Y3Qgc211X2ZlYXR1cmUgICAgICAgICAgICAgIHNtdV9mZWF0dXJlOw0KICAgICAgICAgc3Ry
dWN0IGFtZF9wcF9kaXNwbGF5X2NvbmZpZ3VyYXRpb24gICpkaXNwbGF5X2NvbmZpZzsNCisgICAg
ICAgc3RydWN0IHNtdV9iYWNvX2NvbnRleHQgICAgICAgICBzbXVfYmFjbzsNCiAgICAgICAgIHZv
aWQgKm9kX3NldHRpbmdzOw0KDQogICAgICAgICB1aW50MzJfdCBwc3RhdGVfc2NsazsNCkBAIC02
ODAsNiArNjk1LDExIEBAIHN0cnVjdCBzbXVfZnVuY3MNCiAgICAgICAgIGludCAoKnJlZ2lzdGVy
X2lycV9oYW5kbGVyKShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7DQogICAgICAgICBpbnQgKCpz
ZXRfYXphbGlhX2QzX3BtZSkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KICAgICAgICAgaW50
ICgqZ2V0X21heF9zdXN0YWluYWJsZV9jbG9ja3NfYnlfZGMpKHN0cnVjdCBzbXVfY29udGV4dCAq
c211LCBzdHJ1Y3QgcHBfc211X252X2Nsb2NrX3RhYmxlICptYXhfY2xvY2tzKTsNCisgICAgICAg
Ym9vbCAoKmJhY29faXNfc3VwcG9ydCkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KKyAgICAg
ICBlbnVtIHNtdV9iYWNvX3N0YXRlICgqYmFjb19nZXRfc3RhdGUpKHN0cnVjdCBzbXVfY29udGV4
dCAqc211KTsNCisgICAgICAgaW50ICgqYmFjb19zZXRfc3RhdGUpKHN0cnVjdCBzbXVfY29udGV4
dCAqc211LCBlbnVtIHNtdV9iYWNvX3N0YXRlIHN0YXRlKTsNCisgICAgICAgaW50ICgqYmFjb19y
ZXNldCkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KKw0KIH07DQoNCiAjZGVmaW5lIHNtdV9p
bml0X21pY3JvY29kZShzbXUpIFwNCkBAIC04OTIsNiArOTEyLDEyIEBAIHN0cnVjdCBzbXVfZnVu
Y3MNCiAgICAgICAgICgoc211KS0+ZnVuY3MtPmdldF9tYXhfc3VzdGFpbmFibGVfY2xvY2tzX2J5
X2RjID8gKHNtdSktPmZ1bmNzLT5nZXRfbWF4X3N1c3RhaW5hYmxlX2Nsb2Nrc19ieV9kYygoc211
KSwgKG1heF9jbG9ja3MpKSA6IDApDQogI2RlZmluZSBzbXVfZ2V0X3VjbGtfZHBtX3N0YXRlcyhz
bXUsIGNsb2Nrc19pbl9raHosIG51bV9zdGF0ZXMpIFwNCiAgICAgICAgICgoc211KS0+cHB0X2Z1
bmNzLT5nZXRfdWNsa19kcG1fc3RhdGVzID8gKHNtdSktPnBwdF9mdW5jcy0+Z2V0X3VjbGtfZHBt
X3N0YXRlcygoc211KSwgKGNsb2Nrc19pbl9raHopLCAobnVtX3N0YXRlcykpIDogMCkNCisjZGVm
aW5lIHNtdV9iYWNvX2lzX3N1cHBvcnQoc211KSBcDQorICAgICAgICgoc211KS0+ZnVuY3MtPmJh
Y29faXNfc3VwcG9ydD8gKHNtdSktPmZ1bmNzLT5iYWNvX2lzX3N1cHBvcnQoKHNtdSkpIDogZmFs
c2UpDQorI2RlZmluZSBzbXVfYmFjb19nZXRfc3RhdGUoc211LCBzdGF0ZSkgXA0KKyAgICAgICAo
KHNtdSktPmZ1bmNzLT5iYWNvX2dldF9zdGF0ZT8gKHNtdSktPmZ1bmNzLT5iYWNvX2dldF9zdGF0
ZSgoc211KSwgKHN0YXRlKSkgOiAwKQ0KKyNkZWZpbmUgc211X2JhY29fcmVzZXQoc211KSBcDQor
ICAgICAgICgoc211KS0+ZnVuY3MtPmJhY29fcmVzZXQ/IChzbXUpLT5mdW5jcy0+YmFjb19yZXNl
dCgoc211KSkgOiAwKQ0KDQogZXh0ZXJuIGludCBzbXVfZ2V0X2F0b21fZGF0YV90YWJsZShzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwgdWludDMyX3QgdGFibGUsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50MTZfdCAqc2l6ZSwgdWludDhfdCAqZnJldiwgdWludDhfdCAq
Y3JldiwNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211
X3YxMV8wLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgN
CmluZGV4IGQ5M2NkNzYyNjliNC4uMmZmZjRiMTZjYjRlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdV92MTFfMC5oDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgNCkBAIC0xMDUsNiArMTA1LDE0IEBAIHN0
cnVjdCBzbXVfMTFfMF9wb3dlcl9jb250ZXh0IHsNCiAgICAgICAgIGVudW0gc211XzExXzBfcG93
ZXJfc3RhdGUgcG93ZXJfc3RhdGU7DQogfTsNCg0KK2VudW0gc211X3YxMV8wX2JhY29fc2VxIHsN
CisgICAgICAgQkFDT19TRVFfQkFDTyA9IDAsDQorICAgICAgIEJBQ09fU0VRX01TUiwNCisgICAg
ICAgQkFDT19TRVFfQkFNQUNPLA0KKyAgICAgICBCQUNPX1NFUV9VTFBTLA0KKyAgICAgICBCQUNP
X1NFUV9DT1VOVCwNCit9Ow0KKw0KIHZvaWQgc211X3YxMV8wX3NldF9zbXVfZnVuY3Moc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUpOw0KDQogI2VuZGlmDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvbmF2aTEwX3BwdC5jDQppbmRleCAzNzNhZWJhNDRmMTYuLjc1NzRhMDIzNTBjNiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jDQpAQCAtMTE1LDYg
KzExNSw3IEBAIHN0YXRpYyBpbnQgbmF2aTEwX21lc3NhZ2VfbWFwW1NNVV9NU0dfTUFYX0NPVU5U
XSA9IHsNCiAgICAgICAgIE1TR19NQVAoUG93ZXJVcEpwZWcsICAgICAgICAgICAgUFBTTUNfTVNH
X1Bvd2VyVXBKcGVnKSwNCiAgICAgICAgIE1TR19NQVAoUG93ZXJEb3duSnBlZywgICAgICAgICAg
UFBTTUNfTVNHX1Bvd2VyRG93bkpwZWcpLA0KICAgICAgICAgTVNHX01BUChCYWNvQXVkaW9EM1BN
RSwgICAgICAgICBQUFNNQ19NU0dfQmFjb0F1ZGlvRDNQTUUpLA0KKyAgICAgICBNU0dfTUFQKEFy
bUQzLCAgICAgICAgICAgICAgICAgIFBQU01DX01TR19Bcm1EMyksDQogfTsNCg0KIHN0YXRpYyBp
bnQgbmF2aTEwX2Nsa19tYXBbU01VX0NMS19DT1VOVF0gPSB7DQpAQCAtNDc4LDYgKzQ3OSw3IEBA
IHN0YXRpYyBpbnQgbmF2aTEwX3N0b3JlX3Bvd2VycGxheV90YWJsZShzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkNCiB7DQogICAgICAgICBzdHJ1Y3Qgc211XzExXzBfcG93ZXJwbGF5X3RhYmxlICpw
b3dlcnBsYXlfdGFibGUgPSBOVUxMOw0KICAgICAgICAgc3RydWN0IHNtdV90YWJsZV9jb250ZXh0
ICp0YWJsZV9jb250ZXh0ID0gJnNtdS0+c211X3RhYmxlOw0KKyAgICAgICBzdHJ1Y3Qgc211X2Jh
Y29fY29udGV4dCAqc211X2JhY28gPSAmc211LT5zbXVfYmFjbzsNCg0KICAgICAgICAgaWYgKCF0
YWJsZV9jb250ZXh0LT5wb3dlcl9wbGF5X3RhYmxlKQ0KICAgICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCkBAIC00ODksNiArNDkxLDEyIEBAIHN0YXRpYyBpbnQgbmF2aTEwX3N0b3JlX3Bv
d2VycGxheV90YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCg0KICAgICAgICAgdGFibGVf
Y29udGV4dC0+dGhlcm1hbF9jb250cm9sbGVyX3R5cGUgPSBwb3dlcnBsYXlfdGFibGUtPnRoZXJt
YWxfY29udHJvbGxlcl90eXBlOw0KDQorICAgICAgIG11dGV4X2xvY2soJnNtdV9iYWNvLT5tdXRl
eCk7DQorICAgICAgIGlmIChwb3dlcnBsYXlfdGFibGUtPnBsYXRmb3JtX2NhcHMgJiBTTVVfMTFf
MF9QUF9QTEFURk9STV9DQVBfQkFDTyB8fA0KKyAgICAgICAgICAgcG93ZXJwbGF5X3RhYmxlLT5w
bGF0Zm9ybV9jYXBzICYgU01VXzExXzBfUFBfUExBVEZPUk1fQ0FQX01BQ08pDQorICAgICAgICAg
ICAgICAgc211X2JhY28tPnBsYXRmb3JtX3N1cHBvcnQgPSB0cnVlOw0KKyAgICAgICBtdXRleF91
bmxvY2soJnNtdV9iYWNvLT5tdXRleCk7DQorDQogICAgICAgICByZXR1cm4gMDsNCiB9DQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQppbmRleCBmZjA0N2FiZDhk
OTIuLmM2Nzk1ZGU3MTc3ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3NtdV92MTFfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVf
djExXzAuYw0KQEAgLTM3LDYgKzM3LDcgQEANCiAjaW5jbHVkZSAiYXNpY19yZWcvbXAvbXBfMTFf
MF9vZmZzZXQuaCINCiAjaW5jbHVkZSAiYXNpY19yZWcvbXAvbXBfMTFfMF9zaF9tYXNrLmgiDQog
I2luY2x1ZGUgImFzaWNfcmVnL25iaW8vbmJpb183XzRfb2Zmc2V0LmgiDQorI2luY2x1ZGUgImFz
aWNfcmVnL25iaW8vbmJpb183XzRfc2hfbWFzay5oIg0KICNpbmNsdWRlICJhc2ljX3JlZy9zbXVp
by9zbXVpb18xMV8wXzBfb2Zmc2V0LmgiDQogI2luY2x1ZGUgImFzaWNfcmVnL3NtdWlvL3NtdWlv
XzExXzBfMF9zaF9tYXNrLmgiDQoNCkBAIC0xNjM3LDYgKzE2MzgsOTIgQEAgc3RhdGljIGludCBz
bXVfdjExXzBfc2V0X2F6YWxpYV9kM19wbWUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQogICAg
ICAgICByZXR1cm4gcmV0Ow0KIH0NCg0KK3N0YXRpYyBpbnQgc211X3YxMV8wX2JhY29fc2V0X2Fy
bWQzX3NlcXVlbmNlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV92MTFfMF9iYWNv
X3NlcSBiYWNvX3NlcSkNCit7DQorICAgICAgIHJldHVybiBzbXVfc2VuZF9zbWNfbXNnX3dpdGhf
cGFyYW0oc211LCBTTVVfTVNHX0FybUQzLCBiYWNvX3NlcSk7DQorfQ0KKw0KK3N0YXRpYyBib29s
IHNtdV92MTFfMF9iYWNvX2lzX3N1cHBvcnQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQorew0K
KyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRldjsNCisgICAgICAg
c3RydWN0IHNtdV9iYWNvX2NvbnRleHQgKnNtdV9iYWNvID0gJnNtdS0+c211X2JhY287DQorICAg
ICAgIHVpbnQzMl90IHZhbDsNCisgICAgICAgYm9vbCBiYWNvX3N1cHBvcnQ7DQorDQorICAgICAg
IG11dGV4X2xvY2soJnNtdV9iYWNvLT5tdXRleCk7DQorICAgICAgIGJhY29fc3VwcG9ydCA9IHNt
dV9iYWNvLT5wbGF0Zm9ybV9zdXBwb3J0Ow0KKyAgICAgICBtdXRleF91bmxvY2soJnNtdV9iYWNv
LT5tdXRleCk7DQorDQorICAgICAgIGlmICghYmFjb19zdXBwb3J0KQ0KKyAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCisNCisgICAgICAgaWYgKCFzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNt
dSwgU01VX0ZFQVRVUkVfQkFDT19CSVQpKQ0KKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsN
CisNCisgICAgICAgdmFsID0gUlJFRzMyX1NPQzE1KE5CSU8sIDAsIG1tUkNDX0JJRl9TVFJBUDAp
Ow0KKyAgICAgICBpZiAodmFsICYgUkNDX0JJRl9TVFJBUDBfX1NUUkFQX1BYX0NBUEFCTEVfTUFT
SykNCisgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCisNCisgICAgICAgcmV0dXJuIGZhbHNl
Ow0KK30NCisNCitzdGF0aWMgZW51bSBzbXVfYmFjb19zdGF0ZSBzbXVfdjExXzBfYmFjb19nZXRf
c3RhdGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQorew0KKyAgICAgICBzdHJ1Y3Qgc211X2Jh
Y29fY29udGV4dCAqc211X2JhY28gPSAmc211LT5zbXVfYmFjbzsNCisgICAgICAgZW51bSBzbXVf
YmFjb19zdGF0ZSBiYWNvX3N0YXRlID0gU01VX0JBQ09fU1RBVEVfRVhJVDsNCisNCisgICAgICAg
bXV0ZXhfbG9jaygmc211X2JhY28tPm11dGV4KTsNCisgICAgICAgYmFjb19zdGF0ZSA9IHNtdV9i
YWNvLT5zdGF0ZTsNCisgICAgICAgbXV0ZXhfdW5sb2NrKCZzbXVfYmFjby0+bXV0ZXgpOw0KKw0K
KyAgICAgICByZXR1cm4gYmFjb19zdGF0ZTsNCit9DQorDQorc3RhdGljIGludCBzbXVfdjExXzBf
YmFjb19zZXRfc3RhdGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVudW0gc211X2JhY29fc3Rh
dGUgc3RhdGUpDQorew0KKw0KKyAgICAgICBzdHJ1Y3Qgc211X2JhY29fY29udGV4dCAqc211X2Jh
Y28gPSAmc211LT5zbXVfYmFjbzsNCisgICAgICAgaW50IHJldCA9IDA7DQorDQorICAgICAgIGlm
IChzbXVfdjExXzBfYmFjb19nZXRfc3RhdGUoc211KSA9PSBzdGF0ZSkNCisgICAgICAgICAgICAg
ICByZXR1cm4gMDsNCisNCisgICAgICAgbXV0ZXhfbG9jaygmc211X2JhY28tPm11dGV4KTsNCisN
CisgICAgICAgaWYgKHN0YXRlID09IFNNVV9CQUNPX1NUQVRFX0VOVEVSKQ0KKyAgICAgICAgICAg
ICAgIHJldCA9IHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsIFNNVV9NU0dfRW50ZXJC
YWNvLCBCQUNPX1NFUV9CQUNPKTsNCisgICAgICAgZWxzZQ0KKyAgICAgICAgICAgICAgIHJldCA9
IHNtdV9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX0V4aXRCYWNvKTsNCisgICAgICAgaWYgKHJl
dCkNCisgICAgICAgICAgICAgICBnb3RvIG91dDsNCisNCisgICAgICAgc211X2JhY28tPnN0YXRl
ID0gc3RhdGU7DQorb3V0Og0KKyAgICAgICBtdXRleF91bmxvY2soJnNtdV9iYWNvLT5tdXRleCk7
DQorICAgICAgIHJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBpbnQgc211X3YxMV8wX2JhY29f
cmVzZXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQorew0KKyAgICAgICBpbnQgcmV0ID0gMDsN
CisNCisgICAgICAgcmV0ID0gc211X3YxMV8wX2JhY29fc2V0X2FybWQzX3NlcXVlbmNlKHNtdSwg
QkFDT19TRVFfQkFDTyk7DQorICAgICAgIGlmIChyZXQpDQorICAgICAgICAgICAgICAgcmV0dXJu
IHJldDsNCisNCisgICAgICAgcmV0ID0gc211X3YxMV8wX2JhY29fc2V0X3N0YXRlKHNtdSwgU01V
X0JBQ09fU1RBVEVfRU5URVIpOw0KKyAgICAgICBpZiAocmV0KQ0KKyAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQorDQorICAgICAgIG1zbGVlcCgxMCk7DQorDQorICAgICAgIHJldCA9IHNtdV92
MTFfMF9iYWNvX3NldF9zdGF0ZShzbXUsIFNNVV9CQUNPX1NUQVRFX0VYSVQpOw0KKyAgICAgICBp
ZiAocmV0KQ0KKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorDQorICAgICAgIHJldHVybiBy
ZXQ7DQorfQ0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc211X2Z1bmNzIHNtdV92MTFfMF9mdW5j
cyA9IHsNCiAgICAgICAgIC5pbml0X21pY3JvY29kZSA9IHNtdV92MTFfMF9pbml0X21pY3JvY29k
ZSwNCiAgICAgICAgIC5sb2FkX21pY3JvY29kZSA9IHNtdV92MTFfMF9sb2FkX21pY3JvY29kZSwN
CkBAIC0xNjg1LDYgKzE3NzIsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbXVfZnVuY3Mgc211
X3YxMV8wX2Z1bmNzID0gew0KICAgICAgICAgLnJlZ2lzdGVyX2lycV9oYW5kbGVyID0gc211X3Yx
MV8wX3JlZ2lzdGVyX2lycV9oYW5kbGVyLA0KICAgICAgICAgLnNldF9hemFsaWFfZDNfcG1lID0g
c211X3YxMV8wX3NldF9hemFsaWFfZDNfcG1lLA0KICAgICAgICAgLmdldF9tYXhfc3VzdGFpbmFi
bGVfY2xvY2tzX2J5X2RjID0gc211X3YxMV8wX2dldF9tYXhfc3VzdGFpbmFibGVfY2xvY2tzX2J5
X2RjLA0KKyAgICAgICAuYmFjb19pc19zdXBwb3J0PSBzbXVfdjExXzBfYmFjb19pc19zdXBwb3J0
LA0KKyAgICAgICAuYmFjb19nZXRfc3RhdGUgPSBzbXVfdjExXzBfYmFjb19nZXRfc3RhdGUsDQor
ICAgICAgIC5iYWNvX3NldF9zdGF0ZSA9IHNtdV92MTFfMF9iYWNvX3NldF9zdGF0ZSwNCisgICAg
ICAgLmJhY29fcmVzZXQgPSBzbXVfdjExXzBfYmFjb19yZXNldCwNCiB9Ow0KDQogdm9pZCBzbXVf
djExXzBfc2V0X3NtdV9mdW5jcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCi0tDQoyLjIyLjAN
Cg==

--_000_DM5PR12MB1418237449E535A95A23E566FCFA0DM5PR12MB1418namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:=CE=A2=C8=ED=D1=C5=BA=DA;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@=CE=A2=C8=ED=D1=C5=BA=DA";}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>7<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>4<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 11:13<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Xiao, Jack &lt;Jac=
k.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt=
;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: add baco smu reset function =
for smu11<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">ping...,<o:p></o:p></span><=
/p>
<p><span style=3D"font-size:12.0pt;color:black">which one can help me revie=
w this patch.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">thanks.<o:p></o:p></span></=
p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Best Regards,<o:p></o:p></s=
pan></p>
<p><span style=3D"font-size:12.0pt;color:black">Kevin<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Wang, Kevin(Yang)<br>
<b>Sent:</b> Wednesday, July 3, 2019 11:09:45 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Hawking; Xiao, Jack; Huang, Ray; Wang, Kevin(Yang)<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: add baco smu reset function for =
smu11</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">add baco reset suppor=
t for smu11.<br>
it can help gpu do asic reset when gpu recovery.<br>
<br>
Change-Id: I7714ed03ad87c13e93ca1a7e6aef81eba14667c8<br>
Signed-off-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang-5C7GfCeVMHo@public.gmane.org">kevin1=
.wang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 14 &#4=
3;&#43;&#43;<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; | 26 &#4=
3;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |&nbsp; 8 &#43;&#43;<br=
>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
8 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 9=
1 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;7 files changed, 159 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index b41169261f7d..45dd22a1ef77 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -244,8 &#43;244,10 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;m=
man.gtt_window_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(ade=
v, vmid, AMDGPU_MMHUB, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_enabl=
ed || !adev-&gt;ib_pool_ready ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic=
_type !=3D CHIP_NAVI10) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_e=
nabled ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt=
;ib_pool_ready ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
asic_type !=3D CHIP_NAVI10 ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
in_gpu_reset) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB, 0);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;mman.gtt_window_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 8f605417b40a..cc5d06718e4c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -31,6 &#43;31,7 @@<br>
&nbsp;#include &quot;amdgpu_vce.h&quot;<br>
&nbsp;#include &quot;amdgpu_ucode.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp.h&quot;<br>
&#43;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &quot;amd_pcie.h&quot;<br>
&nbsp;<br>
@@ -266,8 &#43;267,14 @@ static int nv_asic_reset(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_re=
gs_engine_hung(adev, false);<br>
&nbsp;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;=
adev-&gt;smu;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_baco_is_support(smu)) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_baco_reset(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int nv_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u3=
2 dclk)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index b28a923f998d..fc416c686151 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -633,6 &#43;633,11 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.supported, SMU_FEATURE_MAX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.enabled, SMU_FEATURE_MAX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.allowed, SMU_FEATURE_MAX);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;smu_baco.=
mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.state =3D SMU_BA=
CO_STATE_EXIT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.platform_support=
 =3D false;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;watermarks_bitmap =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode=
 =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;default_power_prof=
ile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
@@ -1057,11 &#43;1062,20 @@ static int smu_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D &amp;adev-&gt;smu;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool baco_feature_is_enabled =3D =
smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_system_feature=
s_control(smu, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset &amp;&a=
mp; baco_feature_is_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, t=
rue);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quo=
t;set BACO feature enabled failed, return %d\n&quot;, ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;watermarks_bitmap =
&amp;=3D ~(WATERMARKS_LOADED);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt=
;=3D CHIP_NAVI10 &amp;&amp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 2818df46481c..c97324ef7db2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -241,6 &#43;241,7 @@ enum smu_message_type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_PowerUpJpeg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_PowerDownJpeg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_BacoAudioD3PME,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_ArmD3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_MAX_COUNT,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -489,6 &#43;490,19 @@ struct mclock_latency_table {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mclk_latency_entrie=
s&nbsp; entries[MAX_REGULAR_DPM_NUM];<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum smu_baco_state<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BACO_STATE_ENTER =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BACO_STATE_EXIT,<br>
&#43;};<br>
&#43;<br>
&#43;struct smu_baco_context<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex mutex;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool platform_support;<br>
&#43;};<br>
&#43;<br>
&nbsp;#define WORKLOAD_POLICY_MAX 7<br>
&nbsp;struct smu_context<br>
&nbsp;{<br>
@@ -505,6 &#43;519,7 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_power_context&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_power;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_display_conf=
iguration&nbsp; *display_config;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *od_settings;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate_sclk;<br>
@@ -680,6 &#43;695,11 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*register_irq_handler=
)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_azalia_d3_pme)(s=
truct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_max_sustainable_=
clocks_by_dc)(struct smu_context *smu, struct pp_smu_nv_clock_table *max_cl=
ocks);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*baco_is_support)(struct sm=
u_context *smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_baco_state (*baco_get_st=
ate)(struct smu_context *smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*baco_set_state)(struct smu_=
context *smu, enum smu_baco_state state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*baco_reset)(struct smu_cont=
ext *smu);<br>
&#43;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define smu_init_microcode(smu) \<br>
@@ -892,6 &#43;912,12 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;get_m=
ax_sustainable_clocks_by_dc ? (smu)-&gt;funcs-&gt;get_max_sustainable_clock=
s_by_dc((smu), (max_clocks)) : 0)<br>
&nbsp;#define smu_get_uclk_dpm_states(smu, clocks_in_khz, num_states) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;g=
et_uclk_dpm_states ? (smu)-&gt;ppt_funcs-&gt;get_uclk_dpm_states((smu), (cl=
ocks_in_khz), (num_states)) : 0)<br>
&#43;#define smu_baco_is_support(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_is_supp=
ort? (smu)-&gt;funcs-&gt;baco_is_support((smu)) : false)<br>
&#43;#define smu_baco_get_state(smu, state) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_get_sta=
te? (smu)-&gt;funcs-&gt;baco_get_state((smu), (state)) : 0)<br>
&#43;#define smu_baco_reset(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_reset? =
(smu)-&gt;funcs-&gt;baco_reset((smu)) : 0)<br>
&nbsp;<br>
&nbsp;extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t =
table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *size=
, uint8_t *frev, uint8_t *crev,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index d93cd76269b4..2fff4b16cb4e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -105,6 &#43;105,14 @@ struct smu_11_0_power_context {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_11_0_power_state =
power_state;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum smu_v11_0_baco_seq {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_BACO =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_MSR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_BAMACO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_ULPS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_COUNT,<br>
&#43;};<br>
&#43;<br>
&nbsp;void smu_v11_0_set_smu_funcs(struct smu_context *smu);<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 373aeba44f16..7574a02350c6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -115,6 &#43;115,7 @@ static int navi10_message_map[SMU_MSG_MAX_COUNT] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerUpJpeg,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Powe=
rUpJpeg),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerDownJpeg,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerDownJpeg)=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(BacoAudioD3PME,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_BacoAudioD3PME),<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ArmD3,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_ArmD3),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static int navi10_clk_map[SMU_CLK_COUNT] =3D {<br>
@@ -478,6 &#43;479,7 @@ static int navi10_store_powerplay_table(struct smu_=
context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_=
table *powerplay_table =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
table_context =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table_context-&gt;pow=
er_play_table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -489,6 &#43;491,12 @@ static int navi10_store_powerplay_table(struct smu=
_context *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_=
controller_type =3D powerplay_table-&gt;thermal_controller_type;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_=
caps &amp; SMU_11_0_PP_PLATFORM_CAP_BACO ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay=
_table-&gt;platform_caps &amp; SMU_11_0_PP_PLATFORM_CAP_MACO)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_baco-&gt;platform_support =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index ff047abd8d92..c6795de7177f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -37,6 &#43;37,7 @@<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/nbio/nbio_7_4_offset.h&quot;<br>
&#43;#include &quot;asic_reg/nbio/nbio_7_4_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/smuio/smuio_11_0_0_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/smuio/smuio_11_0_0_sh_mask.h&quot;<br>
&nbsp;<br>
@@ -1637,6 &#43;1638,92 @@ static int smu_v11_0_set_azalia_d3_pme(struct sm=
u_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, =
enum smu_v11_0_baco_seq baco_seq)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg_with_para=
m(smu, SMU_MSG_ArmD3, baco_seq);<br>
&#43;}<br>
&#43;<br>
&#43;static bool smu_v11_0_baco_is_support(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool baco_support;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; baco_support =3D smu_baco-&gt;pla=
tform_support;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!baco_support)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_feature_is_enabled(smu, =
SMU_FEATURE_BACO_BIT))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmR=
CC_BIF_STRAP0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (val &amp; RCC_BIF_STRAP0__STR=
AP_PX_CAPABLE_MASK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&#43;}<br>
&#43;<br>
&#43;static enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context=
 *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_baco_state baco_state =
=3D SMU_BACO_STATE_EXIT;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; baco_state =3D smu_baco-&gt;state=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return baco_state;<br>
&#43;}<br>
&#43;<br>
&#43;static int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_=
baco_state state)<br>
&#43;{<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_v11_0_baco_get_state(smu)=
 =3D=3D state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state =3D=3D SMU_BACO_STATE_E=
NTER)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, =
BACO_SEQ_BACO);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg(smu, SMU_MSG_ExitBaco);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;state =3D state;<br>
&#43;out:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int smu_v11_0_baco_reset(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_baco_set_armd3_=
sequence(smu, BACO_SEQ_BACO);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_baco_set_state(=
smu, SMU_BACO_STATE_ENTER);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(10);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_baco_set_state(=
smu, SMU_BACO_STATE_EXIT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct smu_funcs smu_v11_0_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D smu_v1=
1_0_init_microcode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_microcode =3D smu_v1=
1_0_load_microcode,<br>
@@ -1685,6 &#43;1772,10 @@ static const struct smu_funcs smu_v11_0_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D =
smu_v11_0_register_irq_handler,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu=
_v11_0_set_azalia_d3_pme,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clock=
s_by_dc =3D smu_v11_0_get_max_sustainable_clocks_by_dc,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D smu_v11_0_bac=
o_is_support,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_bac=
o_get_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_bac=
o_set_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_reset =3D smu_v11_0_baco_re=
set,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void smu_v11_0_set_smu_funcs(struct smu_context *smu)<br>
-- <br>
2.22.0<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1418237449E535A95A23E566FCFA0DM5PR12MB1418namp_--

--===============1504976355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1504976355==--
