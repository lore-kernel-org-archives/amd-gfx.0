From: "Chen, Horace" <Horace.Chen-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: add contiguous flag in ucode bo create
Date: Fri, 9 Jun 2017 13:45:25 +0000
Message-ID: <MWHPR12MB1629B8FDE5C086109492DCB1E1CE0@MWHPR12MB1629.namprd12.prod.outlook.com>
References: <1497009541-2635-1-git-send-email-horace.chen@amd.com>
 <4c9e08c4-0d9e-17b4-e3df-30e447c34ea0@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_MWHPR12MB1629B8FDE5C086109492DCB1E1CE0MWHPR12MB1629namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4c9e08c4-0d9e-17b4-e3df-30e447c34ea0-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--_002_MWHPR12MB1629B8FDE5C086109492DCB1E1CE0MWHPR12MB1629namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQ2hyaXN0aWFuLA0KDQpTb3JyeSwgaXQncyBteSBmaXJzdCB0aW1lIHRvIHN1Ym1pdCBjb2Rl
IHRvIHRoZSBzdGFnaW5nLiBJIGhhdmUgZG9uZSB0aGUgZml4LiAgQXR0YWNoZWQgdGhlIGZpeGVk
IHJldmlldy4NClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KUmVnYXJkcywNCkhvcmFjZS4g
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIFtt
YWlsdG86ZGVhdGhzaW1wbGVAdm9kYWZvbmUuZGVdIA0KU2VudDogRnJpZGF5LCBKdW5lIDA5LCAy
MDE3IDg6MjUgUE0NClRvOiBDaGVuLCBIb3JhY2U7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpDYzogSHVhbmcsIFJheQ0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRk
IGNvbnRpZ3VvdXMgZmxhZyBpbiB1Y29kZSBibyBjcmVhdGUNCg0KQW0gMDkuMDYuMjAxNyB1bSAx
Mzo1OSBzY2hyaWViIGhvcmNoZW46DQo+IFVuZGVyIFZGIGVudmlyb25tZW50LCB0aGUgdWNvZGUg
d291bGQgYmUgc2V0dGxlZCB0byB0aGUgdmlzaWJsZSBWUkFNLCANCj4gQXMgaXQgd291bGQgYmUg
cGlubmVkIHRvIHRoZSB2aXNpYmxlIFZSQU0sIGl0J3MgYmV0dGVyIHRvIGFkZCANCj4gY29udGln
dW91cyBmbGFnLG90aGVyd2lzZSBpdCBuZWVkIHRvIG1vdmUgZ3B1IGFkZHJlc3MgZHVyaW5nIHRo
ZSBwaW4gDQo+IHByb2Nlc3MuIFRoaXMgbW92ZW1lbnQgaXMgbm90IG5lY2Vzc2FyeS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogaG9yY2hlbiA8aG9yYWNlLmNoZW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMgfCAzICsrLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jIA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jDQo+IGluZGV4IGNkNmQzZDAu
LjNiMWVlMDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91Y29kZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29k
ZS5jDQo+IEBAIC0zNzksNyArMzc5LDggQEAgaW50IGFtZGdwdV91Y29kZV9pbml0X2JvKHN0cnVj
dCBhbWRncHVfZGV2aWNlIA0KPiAqYWRldikNCj4gICANCj4gICAJZXJyID0gYW1kZ3B1X2JvX2Ny
ZWF0ZShhZGV2LCBhZGV2LT5maXJtd2FyZS5md19zaXplLCBQQUdFX1NJWkUsIHRydWUsDQo+ICAg
CQkJCWFtZGdwdV9zcmlvdl92ZihhZGV2KSA/IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gOiBBTURH
UFVfR0VNX0RPTUFJTl9HVFQsDQo+IC0JCQkJMCwgTlVMTCwgTlVMTCwgYm8pOw0KPiArCQkJCWFt
ZGdwdV9zcmlvdl92ZihhZGV2KSA/IEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElHVU9VUyA6
IDAsDQo+ICsJCQkJTlVMTCwgTlVMTCwgYm8pOw0KDQpNaG0sIGRpZCB5b3UgbWlzc2VkIG15IGNv
bW1lbnQ/IFlvdSBjYW4gYWRkIHRoZSBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMg
dW5jb25kaXRpb25hbGx5IGhlcmUsIGUuZy4gd2l0aG91dCBjaGVja2luZyBhbWRncHVfc3Jpb3Zf
dmYoYWRldikuDQoNCldpdGggdGhhdCBmaXhlZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uDQoNCj4gICAJaWYgKGVy
cikgew0KPiAgIAkJZGV2X2VycihhZGV2LT5kZXYsICIoJWQpIEZpcm13YXJlIGJ1ZmZlciBhbGxv
Y2F0ZSBmYWlsZWRcbiIsIGVycik7DQo+ICAgCQlnb3RvIGZhaWxlZDsNCg0KDQo=

--_002_MWHPR12MB1629B8FDE5C086109492DCB1E1CE0MWHPR12MB1629namp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Fri, 09 Jun 2017 13:45:22 GMT";
	modification-date="Fri, 09 Jun 2017 13:45:22 GMT"

Received: from MWHPR12MB1629.namprd12.prod.outlook.com (10.172.56.18) by
 MWHPR12MB1629.namprd12.prod.outlook.com (10.172.56.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12 via Mailbox Transport; Fri, 9 Jun 2017 13:42:41 +0000
Received: from MWHPR12MB1341.namprd12.prod.outlook.com (10.169.205.142) by
 MWHPR12MB1629.namprd12.prod.outlook.com (10.172.56.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Fri, 9 Jun 2017 13:42:41 +0000
Received: from SN1PR12CA0041.namprd12.prod.outlook.com (10.162.96.179) by
 MWHPR12MB1341.namprd12.prod.outlook.com (10.169.205.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Fri, 9 Jun 2017 13:42:40 +0000
Received: from DM3NAM03FT022.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by SN1PR12CA0041.outlook.office365.com
 (2a01:111:e400:5174::51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1157.12 via
 Frontend Transport; Fri, 9 Jun 2017 13:42:39 +0000
Received: from hybridsmtp.amd.com (165.204.84.17) by
 DM3NAM03FT022.mail.protection.outlook.com (10.152.82.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1143.11 via Frontend Transport; Fri, 9 Jun 2017 13:42:39 +0000
Received: from SCYBEXDAG04.amd.com (10.34.11.14) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.339.0; Fri, 9 Jun
 2017 08:42:38 -0500
Received: from horchen-brahma-dev.amd.com (10.237.75.36) by
 SCYBEXDAG04.amd.com (10.34.11.14) with Microsoft SMTP Server id 14.3.339.0;
 Fri, 9 Jun 2017 21:42:35 +0800
From: "Chen, Horace" <Horace.Chen-5C7GfCeVMHo@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
CC: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Chen, Horace" <Horace.Chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: add contiguous flag in ucode bo create
Thread-Topic: [PATCH] drm/amdgpu: add contiguous flag in ucode bo create
Thread-Index: AQHS4SZEFbkaIZ7HeEKpoqtqXn4ltg==
Date: Fri, 9 Jun 2017 13:42:32 +0000
Message-ID: <1497015752-1327-1-git-send-email-horace.chen-5C7GfCeVMHo@public.gmane.org>
Content-Language: zh-CN
X-MS-Exchange-Organization-AuthSource: SCYBEXDAG04.amd.com
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id: 188b789f-5a99-4b00-273c-08d4af3d65ac
X-MS-TNEF-Correlator: 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-organization-originalclientipaddress: 10.237.75.36
x-ms-exchange-organization-originalserveripaddress: 25.152.82.180
x-ms-publictraffictype: Email
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1629;27:TmyQVwsY3aFDXn2JVFK50vbw7vt0xHILX6ynNbL+ZOuHirHiI6slSuzWSNZoXj/dh9+pMDB2xiiDE7u8ZpJ1NOJQaDNpHS6tVCA3hmRKYyOtC7O8CwAxCNYuooe4IXsPWpcIwK1hBcYtxZFiLDD6lg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Under VF environment, the ucode would be settled to the visible VRAM,
As it would be pinned to the visible VRAM, it's better to add
contiguous flag,otherwise it need to move gpu address during the pin
process. This movement is not necessary.

Signed-off-by: horchen <horace.chen-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index cd6d3d0..4f50eeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -379,7 +379,8 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)

        err =3D amdgpu_bo_create(adev, adev->firmware.fw_size, PAGE_SIZE, t=
rue,
                                amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_V=
RAM : AMDGPU_GEM_DOMAIN_GTT,
-                               0, NULL, NULL, bo);
+                               AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
+                               NULL, NULL, bo);
        if (err) {
                dev_err(adev->dev, "(%d) Firmware buffer allocate failed\n"=
, err);
                goto failed;
--
2.7.4


--_002_MWHPR12MB1629B8FDE5C086109492DCB1E1CE0MWHPR12MB1629namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_002_MWHPR12MB1629B8FDE5C086109492DCB1E1CE0MWHPR12MB1629namp_--
