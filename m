From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re:  [PATCH] amdgpu:fix incorrect use on the remap_mutex
Date: Mon, 17 Apr 2017 21:12:04 +0000
Message-ID: <MWHPR1201MB0045DC3C5C6F86F4CF9CDB56F2060@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <DM5PR12MB1610218713CEFD162C7ADFF684060@DM5PR12MB1610.namprd12.prod.outlook.com>,
 <DM5PR12MB161008BD772B4BF0A0D03D9584060@DM5PR12MB1610.namprd12.prod.outlook.com>,
 <MWHPR1201MB0045DCD6259FF9CFFA1D7EC0F2060@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1447585125=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0045DCD6259FF9CFFA1D7EC0F2060-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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

--===============1447585125==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0045DC3C5C6F86F4CF9CDB56F2060MWHPR1201MB0045_"

--_000_MWHPR1201MB0045DC3C5C6F86F4CF9CDB56F2060MWHPR1201MB0045_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgTW9uaywNCg0KDQpDb3JyZWN0aW9uOg0KDQoNClBsZWFzZSByZW1vdmUgdGhlIGZvbGxvd2lu
ZyBsaW5lIGluIHRoZSBwYXRjaDoNCg0KKyNpbmNsdWRlICJzdGRpby5oIg0KDQoNClRoaXMgcGF0
Y2ggZG9lcyBub3QgbmVlZCB0byB1c2Ugc3RkaW8uaC4NCg0KV2l0aCB0aGF0IGZpeGVkLCBSZXZp
ZXdlZCBieTogIEFsZXggWGllIDxBbGV4QmluLlhpZUBhbWQuY29tPg0KDQpUaGFua3MsDQpBbGV4
IEJpbiBYaWUNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IFhpZSwg
QWxleEJpbg0KU2VudDogTW9uZGF5LCBBcHJpbCAxNywgMjAxNyAyOjU4IFBNDQpUbzogTGl1LCBN
b25rOyAnYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcnDQpDYzogYnJhaG1hX3N3X2Rldg0K
U3ViamVjdDogUmU6IFtQQVRDSF0gYW1kZ3B1OmZpeCBpbmNvcnJlY3QgdXNlIG9uIHRoZSByZW1h
cF9tdXRleA0KDQoNClJldmlld2VkIGJ5OiAgQWxleCBYaWUgPEFsZXhCaW4uWGllQGFtZC5jb20+
DQoNCg0KUGxlYXNlIG5vdGUgdGhhdCB0aGlzIGlzIHBhdGNoIGlzIG5vdCBmb3IgYWxsIG9wZW4g
bGliZHJtLg0KDQoNClRoZXJlIGlzIG5vIHJlbWFwX211dGV4IGluIG1hc3RlciBicmFuY2ggb2Yg
YWxsIG9wZW4gbGliZHJtLg0KDQoNClRoYW5rcywNCg0KQWxleCBCaW4gWGllDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBMaXUsIE1vbmsNClNlbnQ6IE1vbmRheSwg
QXByaWwgMTcsIDIwMTcgMTE6MTIgQU0NClRvOiAnYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcnDQpDYzogYnJhaG1hX3N3X2Rldg0KU3ViamVjdDogtPC4tDogW1BBVENIXSBhbWRncHU6Zml4
IGluY29ycmVjdCB1c2Ugb24gdGhlIHJlbWFwX211dGV4DQoNCkFueW9uZSByZXZpZXcgaXQgID8N
Cg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IExpdSwgTW9uaw0Kt6LLzcqxvOQ6IDIwMTfE
6jTUwjE3yNUgMTQ6MTYNCsrVvP7IyzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCtb3
zOI6IFtQQVRDSF0gYW1kZ3B1OmZpeCBpbmNvcnJlY3QgdXNlIG9uIHRoZSByZW1hcF9tdXRleA0K
DQpbUEFUQ0hdIGFtZGdwdTpmaXggaW5jb3JyZWN0IHVzZSBvbiB0aGUgcmVtYXBfbXV0ZXgNCg0K
dGhpcyBwYXRjaCBmaXhlZCBhIG11bHRpLXRocmVhZCByYWNlIGlzc3VlIGJ5IGV4cGFuZCB0aGUg
cHJvdGVjdGlvbiByYW5nZSBvZiByZW1hcF9tdXRleCB0byB0aGUgd2hvbGUgTElTVCB3YWxrIHRo
cm91Z2gsIGJ5IHRoaXMgZml4IHRoZSBDVFMgdGVzdDoNCiJkRVFQLVZLLmFwaS5vYmplY3RfbWFu
YWdlbWVudC5tdWx0aXRocmVhZGVkX3Blcl90aHJlYWRfZGV2aWNlLmRldmljZV9tZW1vcnlfc21h
bCINCmNhbiBhbHdheXMgcGFzcyBub3csDQpQcmV2aW91c2x5IGl0IGhhcyAxLzE1IGNoYW5jZSB0
byBmYWlsIHdpdGggYSBoaWdoIHBlcmZvcm1hbmNlIEk3IENQVSB1bmRlciB2aXJ0dWFsaXphdGlv
biBlbnZyaW9ubWVudC4NCg0KQ2hhbmdlLUlkOiBJZjg4YjlkMzVlNzlmZTFjYjZlYjBlMzJjNjgw
YmM0OTk2Yzc5MTViYw0KU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+
DQotLS0NCiBhbWRncHUvYW1kZ3B1X2JvLmMgICAgfCAyOSArKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLQ0KIGFtZGdwdS9hbWRncHVfdmFtZ3IuYyB8ICA1ICsrKy0tDQogMiBmaWxlcyBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ft
ZGdwdS9hbWRncHVfYm8uYyBiL2FtZGdwdS9hbWRncHVfYm8uYyBpbmRleCAzM2NiNzA1Li44OTYw
NzI4IDEwMDY0NA0KLS0tIGEvYW1kZ3B1L2FtZGdwdV9iby5jDQorKysgYi9hbWRncHUvYW1kZ3B1
X2JvLmMNCkBAIC05ODksNiArOTg5LDggQEAgaW50IGFtZGdwdV9ib192YV9vcF9yZWZjb3VudGVk
KGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCiAgICAgICAgIH0NCg0KKyAgICAgICBwdGhyZWFkX211dGV4X2xvY2soJmRl
di0+cmVtYXBfbXV0ZXgpOw0KKw0KICAgICAgICAgLyogZmluZCB0aGUgcHJldmlvdXMgbWFwcGVk
IHZhIG9iamVjdCBhbmQgaXRzIGJvIGFuZCB1bm1hcCBpdCovDQogICAgICAgICBpZiAob3BzID09
IEFNREdQVV9WQV9PUF9NQVApIHsNCiAgICAgICAgICAgICAgICAgTElTVF9GT1JfRUFDSF9FTlRS
WSh2YWhhbmRsZSwgJmRldi0+cmVtYXBfbGlzdCwgbGlzdCkgeyBAQCAtOTk4LDE1ICsxMDAwLDE1
IEBAIGludCBhbWRncHVfYm9fdmFfb3BfcmVmY291bnRlZChhbWRncHVfZGV2aWNlX2hhbmRsZSBk
ZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiB0aGUgb3ZlcmxhcCB2YSBt
YXBwaW5nIHdoaWNoIG5lZWQgdG8gYmUgdW5tYXBwZWQgZmlyc3QgKi8NCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZhbyA9IHZhaGFuZGxlOw0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgciA9IGFtZGdwdV9ib192YV9vcCh2YW8tPmJvLCB2YW8tPm9mZnNldCwgdmFv
LT5zaXplLCB2YW8tPmFkZHJlc3MsIGZsYWdzLCBBTURHUFVfVkFfT1BfVU5NQVApOw0KLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocikNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHIpIHsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwdGhyZWFkX211dGV4X3VubG9jaygmZGV2LT5yZW1hcF9tdXRleCk7DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB9DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC8qIEp1c3QgZHJvcCB0aGUgcmVmZXJlbmNlLiAqLw0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYW1kZ3B1X2JvX3JlZmVyZW5jZSgmdmFvLT5ibywgTlVMTCk7DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvKiByZW1vdmUgdGhlIHJlbWFwIGZyb20gbGlzdCAqLw0K
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdGhyZWFkX211dGV4X2xvY2soJmRldi0+
cmVtYXBfbXV0ZXgpOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwo
JnZhby0+bGlzdCk7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0
ZXhfdW5sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZyZWUodmFvKTsNCiAgICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgICAgICAg
ICAgICAgIH0NCkBAIC0xMDIxLDEyICsxMDIzLDE4IEBAIGludCBhbWRncHVfYm9fdmFfb3BfcmVm
Y291bnRlZChhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgIGlmICh2YW8pIHsNCi0g
ICAgICAgICAgICAgICAgICAgICAgIGlmIChibyAmJiAoYm8gIT0gdmFvLT5ibykpDQorICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoYm8gJiYgKGJvICE9IHZhby0+Ym8pKSB7DQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYtPnJlbWFwX211
dGV4KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
LSAgICAgICAgICAgICAgIH0gZWxzZQ0KKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KKyAgICAg
ICAgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAgICAgICAgICAgICBwdGhyZWFkX211dGV4
X3VubG9jaygmZGV2LT5yZW1hcF9tdXRleCk7DQogICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQotICAgICAgIH0gZWxzZQ0KKyAgICAgICAgICAgICAgIH0NCisgICAgICAg
fSBlbHNlIHsNCisgICAgICAgICAgICAgICBwdGhyZWFkX211dGV4X3VubG9jaygmZGV2LT5yZW1h
cF9tdXRleCk7DQogICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KKyAgICAgICB9DQoN
CiAgICAgICAgIC8qIHdlIG9ubHkgYWxsb3cgbnVsbCBibyBmb3IgdW5tYXAgb3BlcmF0aW9uICov
DQogICAgICAgICBpZiAoIWJvKQ0KQEAgLTEwMzksMjYgKzEwNDcsMjUgQEAgaW50IGFtZGdwdV9i
b192YV9vcF9yZWZjb3VudGVkKGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBKdXN0IGRyb3AgdGhlIHJlZmVyZW5jZS4gKi8NCiAgICAgICAgICAg
ICAgICAgICAgICAgICBhbWRncHVfYm9fcmVmZXJlbmNlKCZibywgTlVMTCk7DQogICAgICAgICAg
ICAgICAgICAgICAgICAgLyogcmVtb3ZlIHRoZSByZW1hcCBmcm9tIGxpc3QgKi8NCi0gICAgICAg
ICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0ZXhfbG9jaygmZGV2LT5yZW1hcF9tdXRleCk7DQog
ICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJnZhby0+bGlzdCk7DQotICAgICAgICAg
ICAgICAgICAgICAgICBwdGhyZWFkX211dGV4X3VubG9jaygmZGV2LT5yZW1hcF9tdXRleCk7DQog
ICAgICAgICAgICAgICAgICAgICAgICAgZnJlZSh2YW8pOw0KICAgICAgICAgICAgICAgICB9IGVs
c2UgaWYgKG9wcyA9PSBBTURHUFVfVkFfT1BfTUFQKSB7DQogICAgICAgICAgICAgICAgICAgICAg
ICAgLyogYnVtcCB0aGUgcmVmY291bnQgb2YgYm8hICovDQogICAgICAgICAgICAgICAgICAgICAg
ICAgYXRvbWljX2luYygmYm8tPnJlZmNvdW50KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAv
KiBhZGQgdGhlIHJlbWFwIHRvIGxpc3QgYW5kIHZhbyBzaG91bGQgYmUgTlVMTCBmb3IgbWFwICov
DQogICAgICAgICAgICAgICAgICAgICAgICAgdmFvID0gKHN0cnVjdCBhbWRncHVfdmFfcmVtYXAq
KWNhbGxvYygxLCBzaXplb2Yoc3RydWN0IGFtZGdwdV92YV9yZW1hcCkpOw0KLSAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKCF2YW8pDQorICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXZhbykg
ew0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdGhyZWFkX211dGV4X3VubG9jaygm
ZGV2LT5yZW1hcF9tdXRleCk7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVOT01FTTsNCisgICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAg
ICAgICAgICB2YW8tPmFkZHJlc3MgPSBhZGRyOw0KICAgICAgICAgICAgICAgICAgICAgICAgIHZh
by0+c2l6ZSA9IHNpemU7DQogICAgICAgICAgICAgICAgICAgICAgICAgdmFvLT5vZmZzZXQgPSBv
ZmZzZXQ7DQogICAgICAgICAgICAgICAgICAgICAgICAgdmFvLT5ibyA9IGJvOw0KLSAgICAgICAg
ICAgICAgICAgICAgICAgcHRocmVhZF9tdXRleF9sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAg
ICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2FkZCgmdmFvLT5saXN0LCAmZGV2LT5yZW1hcF9s
aXN0KTsNCi0gICAgICAgICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYt
PnJlbWFwX211dGV4KTsNCiAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAgfQ0KKyAgICAgICBw
dGhyZWFkX211dGV4X3VubG9jaygmZGV2LT5yZW1hcF9tdXRleCk7DQogICAgICAgICByZXR1cm4g
cjsNCiB9DQoNCmRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1X3ZhbWdyLmMgYi9hbWRncHUvYW1k
Z3B1X3ZhbWdyLmMgaW5kZXggYjNmNTM5Ny4uYzVhN2Y0MSAxMDA2NDQNCi0tLSBhL2FtZGdwdS9h
bWRncHVfdmFtZ3IuYw0KKysrIGIvYW1kZ3B1L2FtZGdwdV92YW1nci5jDQpAQCAtMzIsNiArMzIs
NyBAQA0KICNpbmNsdWRlICJhbWRncHVfZHJtLmgiDQogI2luY2x1ZGUgImFtZGdwdV9pbnRlcm5h
bC5oIg0KICNpbmNsdWRlICJ1dGlsX21hdGguaCINCisjaW5jbHVkZSAic3RkaW8uaCINCg0KIC8q
IERldmljZXMgc2hhcmUgU1ZNIHJhbmdlLiBTbyBhIGdsb2JhbCBTVk0gVkFNIG1hbmFnZXIgaXMg
bmVlZGVkLiAqLyAgc3RhdGljIHN0cnVjdCBhbWRncHVfYm9fdmFfbWdyIHZhbWdyX3N2bTsgQEAg
LTQ4OCw2ICs0ODksNyBAQCBpbnQgYW1kZ3B1X3ZhX3JhbmdlX2ZyZWUoYW1kZ3B1X3ZhX2hhbmRs
ZSB2YV9yYW5nZV9oYW5kbGUpDQogICAgICAgICBhZGRyZXNzID0gdmFfcmFuZ2VfaGFuZGxlLT5h
ZGRyZXNzOw0KICAgICAgICAgc2l6ZSAgICA9IHZhX3JhbmdlX2hhbmRsZS0+c2l6ZTsNCg0KKyAg
ICAgICBwdGhyZWFkX211dGV4X2xvY2soJmRldi0+cmVtYXBfbXV0ZXgpOw0KICAgICAgICAgLyog
Y2xlYW4gdXAgcHJldmlvdXMgbWFwcGluZyBpZiBpdCBpcyB1c2VkIGZvciB2aXJ0dWFsIGFsbG9j
YXRpb24gKi8NCiAgICAgICAgIExJU1RfRk9SX0VBQ0hfRU5UUlkodmFoYW5kbGUsICZkZXYtPnJl
bWFwX2xpc3QsIGxpc3QpIHsNCiAgICAgICAgICAgICAgICAgLyogY2hlY2sgd2hldGhlciB0aGUg
cmVtYXAgbGlzdCBhbHJhZWR5IGhhdmUgdmEgdGhhdCBvdmVybGFwIHdpdGggY3VycmVudCByZXF1
ZXN0ICovIEBAIC01MDAsMTIgKzUwMiwxMSBAQCBpbnQgYW1kZ3B1X3ZhX3JhbmdlX2ZyZWUoYW1k
Z3B1X3ZhX2hhbmRsZSB2YV9yYW5nZV9oYW5kbGUpDQogICAgICAgICAgICAgICAgICAgICAgICAg
LyogSnVzdCBkcm9wIHRoZSByZWZlcmVuY2UuICovDQogICAgICAgICAgICAgICAgICAgICAgICAg
YW1kZ3B1X2JvX3JlZmVyZW5jZSgmdmFoYW5kbGUtPmJvLCBOVUxMKTsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAvKiByZW1vdmUgdGhlIHJlbWFwIGZyb20gbGlzdCAqLw0KLSAgICAgICAgICAg
ICAgICAgICAgICAgcHRocmVhZF9tdXRleF9sb2NrKCZkZXYtPnJlbWFwX211dGV4KTsNCiAgICAg
ICAgICAgICAgICAgICAgICAgICBsaXN0X2RlbCgmdmFoYW5kbGUtPmxpc3QpOw0KLSAgICAgICAg
ICAgICAgICAgICAgICAgcHRocmVhZF9tdXRleF91bmxvY2soJmRldi0+cmVtYXBfbXV0ZXgpOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgIGZyZWUodmFoYW5kbGUpOw0KICAgICAgICAgICAgICAg
ICB9DQogICAgICAgICB9DQorICAgICAgIHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZkZXYtPnJlbWFw
X211dGV4KTsNCg0KICAgICAgICAgYW1kZ3B1X3ZhbWdyX2ZyZWVfdmEodmFfcmFuZ2VfaGFuZGxl
LT52YW1nciwNCiAgICAgICAgICAgICAgICAgICAgICAgICB2YV9yYW5nZV9oYW5kbGUtPmFkZHJl
c3MsDQotLQ0KMi43LjQNCg0K

--_000_MWHPR1201MB0045DC3C5C6F86F4CF9CDB56F2060MWHPR1201MB0045_
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
<p>Hi Monk,</p>
<p><br>
</p>
<p>Correction:</p>
<p><br>
</p>
<p>Please remove the following line in the patch:</p>
<p><span style=3D"color: rgb(33, 33, 33); font-size: 13.3333px;">&#43;#incl=
ude &quot;stdio.h&quot;</span><br>
</p>
<p><span style=3D"color: rgb(33, 33, 33); font-size: 13.3333px;"><br>
</span></p>
<p><span style=3D"color: rgb(33, 33, 33); font-size: 13.3333px;">This patch=
 does not need to use stdio.h.</span></p>
<p><span style=3D"color: rgb(33, 33, 33); font-size: 13.3333px;">With that =
fixed,&nbsp;</span><span style=3D"color: rgb(33, 33, 33); font-family: Cali=
bri, Arial, Helvetica, sans-serif;">Reviewed by:&nbsp;</span><span style=3D=
"color: rgb(33, 33, 33); font-family: Calibri, Arial, Helvetica, sans-serif=
;">&nbsp;Alex
 Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
<br>
Thanks,
<div>Alex Bin Xie<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Xie, AlexBin<br>
<b>Sent:</b> Monday, April 17, 2017 2:58 PM<br>
<b>To:</b> Liu, Monk; 'amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org'<br>
<b>Cc:</b> brahma_sw_dev<br>
<b>Subject:</b> Re: [PATCH] amdgpu:fix incorrect use on the remap_mutex</fo=
nt>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Reviewed by:&nbsp;<span>&nbsp;Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</span=
></p>
<p><span><br>
</span></p>
<p><span>Please note that this is patch is not for all open&nbsp;libdrm.</s=
pan></p>
<p><span><br>
</span></p>
<p><span>There is no&nbsp;<span style=3D"font-family:Calibri,Arial,Helvetic=
a,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&q=
uot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,E=
mojiSymbols; font-size:13.3333px">remap_mutex in master branch of&nbsp;all =
open libdrm.</span></span></p>
<p><span><br>
</span></p>
<p><span>Thanks,</span></p>
<p><span>Alex Bin Xie</span></p>
<br>
<div style=3D"color:rgb(0,0,0)">
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
<font size=3D"2"><span style=3D"font-size:10pt">
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
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR1201MB0045DC3C5C6F86F4CF9CDB56F2060MWHPR1201MB0045_--

--===============1447585125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1447585125==--
