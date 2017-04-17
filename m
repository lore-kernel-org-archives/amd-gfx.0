From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re:  [PATCH] amdgpu:fix incorrect use on the remap_mutex
Date: Mon, 17 Apr 2017 18:58:56 +0000
Message-ID: <MWHPR1201MB0045DCD6259FF9CFFA1D7EC0F2060@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <DM5PR12MB1610218713CEFD162C7ADFF684060@DM5PR12MB1610.namprd12.prod.outlook.com>,
 <DM5PR12MB161008BD772B4BF0A0D03D9584060@DM5PR12MB1610.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0087710398=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB161008BD772B4BF0A0D03D9584060-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "'amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org'" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--===============0087710398==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0045DCD6259FF9CFFA1D7EC0F2060MWHPR1201MB0045_"

--_000_MWHPR1201MB0045DCD6259FF9CFFA1D7EC0F2060MWHPR1201MB0045_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

UmV2aWV3ZWQgYnk6ICBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4NCg0KDQpQbGVhc2Ug
bm90ZSB0aGF0IHRoaXMgaXMgcGF0Y2ggaXMgbm90IGZvciBhbGwgb3BlbiBsaWJkcm0uDQoNCg0K
VGhlcmUgaXMgbm8gcmVtYXBfbXV0ZXggaW4gbWFzdGVyIGJyYW5jaCBvZiBhbGwgb3BlbiBsaWJk
cm0uDQoNCg0KVGhhbmtzLA0KDQpBbGV4IEJpbiBYaWUNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCkZyb206IExpdSwgTW9uaw0KU2VudDogTW9uZGF5LCBBcHJpbCAxNywgMjAx
NyAxMToxMiBBTQ0KVG86ICdhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZycNCkNjOiBicmFo
bWFfc3dfZGV2DQpTdWJqZWN0OiC08Li0OiBbUEFUQ0hdIGFtZGdwdTpmaXggaW5jb3JyZWN0IHVz
ZSBvbiB0aGUgcmVtYXBfbXV0ZXgNCg0KQW55b25lIHJldmlldyBpdCAgPw0KDQotLS0tLdPKvP7U
rbz+LS0tLS0NCreivP7IyzogTGl1LCBNb25rDQq3osvNyrG85DogMjAxN8TqNNTCMTfI1SAxNDox
Ng0KytW8/sjLOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K1vfM4jogW1BBVENIXSBh
bWRncHU6Zml4IGluY29ycmVjdCB1c2Ugb24gdGhlIHJlbWFwX211dGV4DQoNCltQQVRDSF0gYW1k
Z3B1OmZpeCBpbmNvcnJlY3QgdXNlIG9uIHRoZSByZW1hcF9tdXRleA0KDQp0aGlzIHBhdGNoIGZp
eGVkIGEgbXVsdGktdGhyZWFkIHJhY2UgaXNzdWUgYnkgZXhwYW5kIHRoZSBwcm90ZWN0aW9uIHJh
bmdlIG9mIHJlbWFwX211dGV4IHRvIHRoZSB3aG9sZSBMSVNUIHdhbGsgdGhyb3VnaCwgYnkgdGhp
cyBmaXggdGhlIENUUyB0ZXN0Og0KImRFUVAtVksuYXBpLm9iamVjdF9tYW5hZ2VtZW50Lm11bHRp
dGhyZWFkZWRfcGVyX3RocmVhZF9kZXZpY2UuZGV2aWNlX21lbW9yeV9zbWFsIg0KY2FuIGFsd2F5
cyBwYXNzIG5vdywNClByZXZpb3VzbHkgaXQgaGFzIDEvMTUgY2hhbmNlIHRvIGZhaWwgd2l0aCBh
IGhpZ2ggcGVyZm9ybWFuY2UgSTcgQ1BVIHVuZGVyIHZpcnR1YWxpemF0aW9uIGVudnJpb25tZW50
Lg0KDQpDaGFuZ2UtSWQ6IElmODhiOWQzNWU3OWZlMWNiNmViMGUzMmM2ODBiYzQ5OTZjNzkxNWJj
DQpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4NCi0tLQ0KIGFtZGdw
dS9hbWRncHVfYm8uYyAgICB8IDI5ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogYW1k
Z3B1L2FtZGdwdV92YW1nci5jIHwgIDUgKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9i
by5jIGIvYW1kZ3B1L2FtZGdwdV9iby5jIGluZGV4IDMzY2I3MDUuLjg5NjA3MjggMTAwNjQ0DQot
LS0gYS9hbWRncHUvYW1kZ3B1X2JvLmMNCisrKyBiL2FtZGdwdS9hbWRncHVfYm8uYw0KQEAgLTk4
OSw2ICs5ODksOCBAQCBpbnQgYW1kZ3B1X2JvX3ZhX29wX3JlZmNvdW50ZWQoYW1kZ3B1X2Rldmlj
ZV9oYW5kbGUgZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
ICAgICAgICAgfQ0KDQorICAgICAgIHB0aHJlYWRfbXV0ZXhfbG9jaygmZGV2LT5yZW1hcF9tdXRl
eCk7DQorDQogICAgICAgICAvKiBmaW5kIHRoZSBwcmV2aW91cyBtYXBwZWQgdmEgb2JqZWN0IGFu
ZCBpdHMgYm8gYW5kIHVubWFwIGl0Ki8NCiAgICAgICAgIGlmIChvcHMgPT0gQU1ER1BVX1ZBX09Q
X01BUCkgew0KICAgICAgICAgICAgICAgICBMSVNUX0ZPUl9FQUNIX0VOVFJZKHZhaGFuZGxlLCAm
ZGV2LT5yZW1hcF9saXN0LCBsaXN0KSB7IEBAIC05OTgsMTUgKzEwMDAsMTUgQEAgaW50IGFtZGdw
dV9ib192YV9vcF9yZWZjb3VudGVkKGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIHRoZSBvdmVybGFwIHZhIG1hcHBpbmcgd2hpY2gg
bmVlZCB0byBiZSB1bm1hcHBlZCBmaXJzdCAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmFvID0gdmFoYW5kbGU7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ID0gYW1kZ3B1X2JvX3ZhX29wKHZhby0+Ym8sIHZhby0+b2Zmc2V0LCB2YW8tPnNpemUsIHZhby0+
YWRkcmVzcywgZmxhZ3MsIEFNREdQVV9WQV9PUF9VTk1BUCk7DQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChyKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
cikgew0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0
ZXhfdW5sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH0NCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogSnVzdCBkcm9w
IHRoZSByZWZlcmVuY2UuICovDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRn
cHVfYm9fcmVmZXJlbmNlKCZ2YW8tPmJvLCBOVUxMKTsNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIHJlbW92ZSB0aGUgcmVtYXAgZnJvbSBsaXN0ICovDQotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0ZXhfbG9jaygmZGV2LT5yZW1hcF9tdXRleCk7
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2RlbCgmdmFvLT5saXN0KTsN
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHRocmVhZF9tdXRleF91bmxvY2soJmRl
di0+cmVtYXBfbXV0ZXgpOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJlZSh2
YW8pOw0KICAgICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAgfQ0KQEAg
LTEwMjEsMTIgKzEwMjMsMTggQEAgaW50IGFtZGdwdV9ib192YV9vcF9yZWZjb3VudGVkKGFtZGdw
dV9kZXZpY2VfaGFuZGxlIGRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgICAg
ICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAgaWYgKHZhbykgew0KLSAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGJvICYmIChibyAhPSB2YW8tPmJvKSkNCisgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChibyAmJiAoYm8gIT0gdmFvLT5ibykpIHsNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcHRocmVhZF9tdXRleF91bmxvY2soJmRldi0+cmVtYXBfbXV0ZXgpOw0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQotICAgICAgICAgICAg
ICAgfSBlbHNlDQorICAgICAgICAgICAgICAgICAgICAgICB9DQorICAgICAgICAgICAgICAgfSBl
bHNlIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYt
PnJlbWFwX211dGV4KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Ci0gICAgICAgfSBlbHNlDQorICAgICAgICAgICAgICAgfQ0KKyAgICAgICB9IGVsc2Ugew0KKyAg
ICAgICAgICAgICAgIHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQorICAgICAgIH0NCg0KICAgICAgICAgLyog
d2Ugb25seSBhbGxvdyBudWxsIGJvIGZvciB1bm1hcCBvcGVyYXRpb24gKi8NCiAgICAgICAgIGlm
ICghYm8pDQpAQCAtMTAzOSwyNiArMTA0NywyNSBAQCBpbnQgYW1kZ3B1X2JvX3ZhX29wX3JlZmNv
dW50ZWQoYW1kZ3B1X2RldmljZV9oYW5kbGUgZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAg
IC8qIEp1c3QgZHJvcCB0aGUgcmVmZXJlbmNlLiAqLw0KICAgICAgICAgICAgICAgICAgICAgICAg
IGFtZGdwdV9ib19yZWZlcmVuY2UoJmJvLCBOVUxMKTsNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAvKiByZW1vdmUgdGhlIHJlbWFwIGZyb20gbGlzdCAqLw0KLSAgICAgICAgICAgICAgICAgICAg
ICAgcHRocmVhZF9tdXRleF9sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICBsaXN0X2RlbCgmdmFvLT5saXN0KTsNCi0gICAgICAgICAgICAgICAgICAgICAg
IHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICBmcmVlKHZhbyk7DQogICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAob3BzID09
IEFNREdQVV9WQV9PUF9NQVApIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBidW1wIHRo
ZSByZWZjb3VudCBvZiBibyEgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgICBhdG9taWNfaW5j
KCZiby0+cmVmY291bnQpOw0KICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGFkZCB0aGUgcmVt
YXAgdG8gbGlzdCBhbmQgdmFvIHNob3VsZCBiZSBOVUxMIGZvciBtYXAgKi8NCiAgICAgICAgICAg
ICAgICAgICAgICAgICB2YW8gPSAoc3RydWN0IGFtZGdwdV92YV9yZW1hcCopY2FsbG9jKDEsIHNp
emVvZihzdHJ1Y3QgYW1kZ3B1X3ZhX3JlbWFwKSk7DQotICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoIXZhbykNCisgICAgICAgICAgICAgICAgICAgICAgIGlmICghdmFvKSB7DQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYtPnJlbWFwX211
dGV4KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0K
KyAgICAgICAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgICAgICAgICAgIHZhby0+
YWRkcmVzcyA9IGFkZHI7DQogICAgICAgICAgICAgICAgICAgICAgICAgdmFvLT5zaXplID0gc2l6
ZTsNCiAgICAgICAgICAgICAgICAgICAgICAgICB2YW8tPm9mZnNldCA9IG9mZnNldDsNCiAgICAg
ICAgICAgICAgICAgICAgICAgICB2YW8tPmJvID0gYm87DQotICAgICAgICAgICAgICAgICAgICAg
ICBwdGhyZWFkX211dGV4X2xvY2soJmRldi0+cmVtYXBfbXV0ZXgpOw0KICAgICAgICAgICAgICAg
ICAgICAgICAgIGxpc3RfYWRkKCZ2YW8tPmxpc3QsICZkZXYtPnJlbWFwX2xpc3QpOw0KLSAgICAg
ICAgICAgICAgICAgICAgICAgcHRocmVhZF9tdXRleF91bmxvY2soJmRldi0+cmVtYXBfbXV0ZXgp
Ow0KICAgICAgICAgICAgICAgICB9DQogICAgICAgICB9DQorICAgICAgIHB0aHJlYWRfbXV0ZXhf
dW5sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAgICAgICAgIHJldHVybiByOw0KIH0NCg0KZGlm
ZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVfdmFtZ3IuYyBiL2FtZGdwdS9hbWRncHVfdmFtZ3IuYyBp
bmRleCBiM2Y1Mzk3Li5jNWE3ZjQxIDEwMDY0NA0KLS0tIGEvYW1kZ3B1L2FtZGdwdV92YW1nci5j
DQorKysgYi9hbWRncHUvYW1kZ3B1X3ZhbWdyLmMNCkBAIC0zMiw2ICszMiw3IEBADQogI2luY2x1
ZGUgImFtZGdwdV9kcm0uaCINCiAjaW5jbHVkZSAiYW1kZ3B1X2ludGVybmFsLmgiDQogI2luY2x1
ZGUgInV0aWxfbWF0aC5oIg0KKyNpbmNsdWRlICJzdGRpby5oIg0KDQogLyogRGV2aWNlcyBzaGFy
ZSBTVk0gcmFuZ2UuIFNvIGEgZ2xvYmFsIFNWTSBWQU0gbWFuYWdlciBpcyBuZWVkZWQuICovICBz
dGF0aWMgc3RydWN0IGFtZGdwdV9ib192YV9tZ3IgdmFtZ3Jfc3ZtOyBAQCAtNDg4LDYgKzQ4OSw3
IEBAIGludCBhbWRncHVfdmFfcmFuZ2VfZnJlZShhbWRncHVfdmFfaGFuZGxlIHZhX3JhbmdlX2hh
bmRsZSkNCiAgICAgICAgIGFkZHJlc3MgPSB2YV9yYW5nZV9oYW5kbGUtPmFkZHJlc3M7DQogICAg
ICAgICBzaXplICAgID0gdmFfcmFuZ2VfaGFuZGxlLT5zaXplOw0KDQorICAgICAgIHB0aHJlYWRf
bXV0ZXhfbG9jaygmZGV2LT5yZW1hcF9tdXRleCk7DQogICAgICAgICAvKiBjbGVhbiB1cCBwcmV2
aW91cyBtYXBwaW5nIGlmIGl0IGlzIHVzZWQgZm9yIHZpcnR1YWwgYWxsb2NhdGlvbiAqLw0KICAg
ICAgICAgTElTVF9GT1JfRUFDSF9FTlRSWSh2YWhhbmRsZSwgJmRldi0+cmVtYXBfbGlzdCwgbGlz
dCkgew0KICAgICAgICAgICAgICAgICAvKiBjaGVjayB3aGV0aGVyIHRoZSByZW1hcCBsaXN0IGFs
cmFlZHkgaGF2ZSB2YSB0aGF0IG92ZXJsYXAgd2l0aCBjdXJyZW50IHJlcXVlc3QgKi8gQEAgLTUw
MCwxMiArNTAyLDExIEBAIGludCBhbWRncHVfdmFfcmFuZ2VfZnJlZShhbWRncHVfdmFfaGFuZGxl
IHZhX3JhbmdlX2hhbmRsZSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBKdXN0IGRyb3Ag
dGhlIHJlZmVyZW5jZS4gKi8NCiAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfYm9fcmVm
ZXJlbmNlKCZ2YWhhbmRsZS0+Ym8sIE5VTEwpOw0KICAgICAgICAgICAgICAgICAgICAgICAgIC8q
IHJlbW92ZSB0aGUgcmVtYXAgZnJvbSBsaXN0ICovDQotICAgICAgICAgICAgICAgICAgICAgICBw
dGhyZWFkX211dGV4X2xvY2soJmRldi0+cmVtYXBfbXV0ZXgpOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgIGxpc3RfZGVsKCZ2YWhhbmRsZS0+bGlzdCk7DQotICAgICAgICAgICAgICAgICAgICAg
ICBwdGhyZWFkX211dGV4X3VubG9jaygmZGV2LT5yZW1hcF9tdXRleCk7DQogICAgICAgICAgICAg
ICAgICAgICAgICAgZnJlZSh2YWhhbmRsZSk7DQogICAgICAgICAgICAgICAgIH0NCiAgICAgICAg
IH0NCisgICAgICAgcHRocmVhZF9tdXRleF91bmxvY2soJmRldi0+cmVtYXBfbXV0ZXgpOw0KDQog
ICAgICAgICBhbWRncHVfdmFtZ3JfZnJlZV92YSh2YV9yYW5nZV9oYW5kbGUtPnZhbWdyLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgIHZhX3JhbmdlX2hhbmRsZS0+YWRkcmVzcywNCi0tDQoyLjcu
NA0KDQo=

--_000_MWHPR1201MB0045DCD6259FF9CFFA1D7EC0F2060MWHPR1201MB0045_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Reviewed by:&nbsp;<span>&nbsp;Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</span=
></p>
<p><span><br>
</span></p>
<p><span>Please note that this is patch is not for all open&nbsp;libdrm.</s=
pan></p>
<p><span><br>
</span></p>
<p><span>There is no&nbsp;<span style=3D"font-family: Calibri, Arial, Helve=
tica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI =
Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emo=
ji&quot;, EmojiSymbols; font-size: 13.3333px;">remap_mutex in master branch=
 of&nbsp;all
 open libdrm.</span></span></p>
<p><span><br>
</span></p>
<p><span>Thanks,</span></p>
<p><span>Alex Bin Xie</span></p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Liu, Monk<br>
<b>Sent:</b> Monday, April 17, 2017 11:12 AM<br>
<b>To:</b> 'amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org'<br>
<b>Cc:</b> brahma_sw_dev<br>
<b>Subject:</b> =B4=F0=B8=B4: [PATCH] amdgpu:fix incorrect use on the remap=
_mutex</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Anyone review it&nbsp; ?<br>
<br>
-----=D3=CA=BC=FE=D4=AD=BC=FE-----<br>
=B7=A2=BC=FE=C8=CB: Liu, Monk <br>
=B7=A2=CB=CD=CA=B1=BC=E4: 2017=C4=EA4=D4=C217=C8=D5 14:16<br>
=CA=D5=BC=FE=C8=CB: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
=D6=F7=CC=E2: [PATCH] amdgpu:fix incorrect use on the remap_mutex<br>
<br>
[PATCH] amdgpu:fix incorrect use on the remap_mutex<br>
<br>
this patch fixed a multi-thread race issue by expand the protection range o=
f remap_mutex to the whole LIST walk through, by this fix the CTS test:<br>
&quot;dEQP-VK.api.object_management.multithreaded_per_thread_device.device_=
memory_smal&quot;<br>
can always pass now,<br>
Previously it has 1/15 chance to fail with a high performance I7 CPU under =
virtualization envrionment.<br>
<br>
Change-Id: If88b9d35e79fe1cb6eb0e32c680bc4996c7915bc<br>
Signed-off-by: Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;amdgpu/amdgpu_bo.c&nbsp;&nbsp;&nbsp; | 29 &#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----------<=
br>
&nbsp;amdgpu/amdgpu_vamgr.c |&nbsp; 5 &#43;&#43;&#43;--<br>
&nbsp;2 files changed, 21 insertions(&#43;), 13 deletions(-)<br>
<br>
diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c index 33cb705..8960728=
 100644<br>
--- a/amdgpu/amdgpu_bo.c<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_bo.c<br>
@@ -989,6 &#43;989,8 @@ int amdgpu_bo_va_op_refcounted(amdgpu_device_handle=
 dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_lock(&amp;dev-&gt;r=
emap_mutex);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* find the previous mappe=
d va object and its bo and unmap it*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ops =3D=3D AMDGPU_VA_O=
P_MAP) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; LIST_FOR_EACH_ENTRY(vahandle, &amp;dev-&gt;remap_list=
, list) { @@ -998,15 &#43;1000,15 @@ int amdgpu_bo_va_op_refcounted(amdgpu_=
device_handle dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the overlap va mapping which =
need to be unmapped first */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vao =3D vahandle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_va_op(vao-&gt;bo=
, vao-&gt;offset, vao-&gt;size, vao-&gt;address, flags, AMDGPU_VA_OP_UNMAP)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pthread_mutex_unlock(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Just drop the reference. */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reference(&amp;vao-&gt=
;bo, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* remove the remap from list */=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_lock(&amp;dev-&gt;remap_mutex=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;vao-&gt;list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_unlock(&amp;dev-&gt;remap_mut=
ex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(vao);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1021,12 &#43;1023,18 @@ int amdgpu_bo_va_op_refcounted(amdgpu_device_ha=
ndle dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (vao) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo &amp;&amp=
; (bo !=3D vao-&gt;bo))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo &amp;=
&amp; (bo !=3D vao-&gt;bo)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_unlock(&amp;dev-&gt;remap=
_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mute=
x_unlock(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pthread_mutex_unlock(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we only allow null bo f=
or unmap operation */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bo)<br>
@@ -1039,26 &#43;1047,25 @@ int amdgpu_bo_va_op_refcounted(amdgpu_device_ha=
ndle dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ju=
st drop the reference. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_bo_reference(&amp;bo, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* re=
move the remap from list */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_lo=
ck(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
del(&amp;vao-&gt;list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_un=
lock(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(=
vao);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else if (ops =3D=3D AMDGPU_VA_OP_MAP) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bu=
mp the refcount of bo! */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomi=
c_inc(&amp;bo-&gt;refcount);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ad=
d the remap to list and vao should be NULL for map */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vao =
=3D (struct amdgpu_va_remap*)calloc(1, sizeof(struct amdgpu_va_remap));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vao)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vao) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_unlock(&amp;dev-&gt;remap=
_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vao-&=
gt;address =3D addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vao-&=
gt;size =3D size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vao-&=
gt;offset =3D offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vao-&=
gt;bo =3D bo;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_lo=
ck(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
add(&amp;vao-&gt;list, &amp;dev-&gt;remap_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_un=
lock(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_unlock(&amp;dev-&gt=
;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/amdgpu/amdgpu_vamgr.c b/amdgpu/amdgpu_vamgr.c index b3f5397..c=
5a7f41 100644<br>
--- a/amdgpu/amdgpu_vamgr.c<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_vamgr.c<br>
@@ -32,6 &#43;32,7 @@<br>
&nbsp;#include &quot;amdgpu_drm.h&quot;<br>
&nbsp;#include &quot;amdgpu_internal.h&quot;<br>
&nbsp;#include &quot;util_math.h&quot;<br>
&#43;#include &quot;stdio.h&quot;<br>
&nbsp;<br>
&nbsp;/* Devices share SVM range. So a global SVM VAM manager is needed. */=
&nbsp; static struct amdgpu_bo_va_mgr vamgr_svm; @@ -488,6 &#43;489,7 @@ in=
t amdgpu_va_range_free(amdgpu_va_handle va_range_handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address =3D va_range_handl=
e-&gt;address;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size&nbsp;&nbsp;&nbsp; =3D=
 va_range_handle-&gt;size;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_lock(&amp;dev-&gt;r=
emap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clean up previous mappi=
ng if it is used for virtual allocation */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LIST_FOR_EACH_ENTRY(vahand=
le, &amp;dev-&gt;remap_list, list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* check whether the remap list alraedy have va that =
overlap with current request */ @@ -500,12 &#43;502,11 @@ int amdgpu_va_ran=
ge_free(amdgpu_va_handle va_range_handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ju=
st drop the reference. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_bo_reference(&amp;vahandle-&gt;bo, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* re=
move the remap from list */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_lo=
ck(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
del(&amp;vahandle-&gt;list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_un=
lock(&amp;dev-&gt;remap_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(=
vahandle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_mutex_unlock(&amp;dev-&gt=
;remap_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vamgr_free_va(va_ra=
nge_handle-&gt;vamgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_ra=
nge_handle-&gt;address,<br>
--<br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB0045DCD6259FF9CFFA1D7EC0F2060MWHPR1201MB0045_--

--===============0087710398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0087710398==--
