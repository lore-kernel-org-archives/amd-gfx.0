Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E824C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EF421823
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EF421823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C046F9B4;
	Fri,  6 Dec 2019 10:12:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65FD66F9B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 10:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLreH1yDmWqjR0/KRVPJevKOlquQY6enRP5p4INhPC51CP7LEe16aMdp72cmv8w8oWXALPCgWGQmSUpZ+0LjTH/J81G6UrRBuJqFAcRVv5z/5gK2Tj7GMtyyCwvao6vJRBMfAjog0FZq0Pwze/BD2mmPR14ZX2WOqE+wGca/RDaEn6jwMCTujPJ4KHIsipSx0KTdDtsHlJc94wyhPB+ju6SWH813c35Q+xVfqzX8Rb30OruW6WbioXXQfFfM6NsNtWYC973f6Y1RAH6adDH2jZ5vDvJJgisFYKde4LM4q4FyfumyyqtENd1C4pK7G0p/38tmkkSyckfxtlGordPn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z+5Fpvgl/37SfnABIY7gXts9ZLopVw99OX+8ykCYUs=;
 b=A5lMyW5AD5eLVOnHKSKixzMy8cPSa1LX2EuV5OxpFzh3CcR0xRnGgF/NgvCcvRxkvDoMDmoORHswWKoLPJ47u3xj3YLCfk2/BvJu9SrwbyXXh7bKy6pIQCz06X1gTMRv70mAloHMZ30CuGJFYCzGJ/zGwk6qdCUyCloF6B5OB2BR6XrC1tSVephW/RRgc678HMJ9knS5nlY6DnAQ6x3N7lQ7m3rDAWa/z3i6nzDCbrtq3jMswhA5Yjpq79Md0UmLYZzVkvOwwvVmcLZsQDiDsBw35/AuzHQrI2s7e2e/CyVXlSYlsYmozk/2iZl8mH8WkNm5L23CW2Ze6IjGU4nYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1466.namprd12.prod.outlook.com (10.172.38.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 10:12:30 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2516.017; Fri, 6 Dec 2019
 10:12:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ma, Le" <Le.Ma@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v2)
Thread-Topic: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v2)
Thread-Index: AQHVrBnnAIRc1ctszUygUtpM/trcdqes3VsAgAAEgUA=
Date: Fri, 6 Dec 2019 10:12:29 +0000
Message-ID: <DM5PR12MB1418C751EDC965361C5E7F3FFC5F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191206094523.5069-1-Hawking.Zhang@amd.com>
 <BYAPR12MB2806C707634DDD7F30DFB891F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2806C707634DDD7F30DFB891F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-06T09:47:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6e9103a3-4ada-4427-bbbb-000035d1711b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 120f326c-78c8-4062-cef2-08d77a34cd7d
x-ms-traffictypediagnostic: DM5PR12MB1466:|DM5PR12MB1466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1466451EC129D55C90930DF3FC5F0@DM5PR12MB1466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(13464003)(52536014)(5660300002)(66446008)(6636002)(81166006)(71190400001)(71200400001)(2906002)(14444005)(11346002)(478600001)(9686003)(33656002)(86362001)(186003)(26005)(76176011)(99286004)(7696005)(74316002)(8936002)(25786009)(66946007)(316002)(76116006)(305945005)(229853002)(102836004)(81156014)(66556008)(64756008)(14454004)(66476007)(53546011)(6506007)(8676002)(110136005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1466;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6m1OdN0ZKyV5cuaAQQvGFvflaU9QM9BA5M1mvaxiUp373LVTD5bobJ9IhvIg4BVvdXkGqwaDp8Et+cHSQ3dDvv/oJT1lJfxNyIGRqqimGmeza442DanhEGaBduUB2nFI7yBXYkBqM78Hx7zWeuVqasHHwXhxesgPp9nuZAbd2hgO/8+jUz7vGSrBsuEl5+u42j8fyU3FdGoKil6nB3Oqquy360GhjH59Y/mSXeKyquIkue9JG7uEthVvrFIGD4vDF5nJoBUdLtRDZ8KbGPAuH75Wk/TAXZE9yJoErFVTkYwI+VqBpPIfNuZbIhLioSl3tuizO0Ef8nAZF8CzUpt/JgYPTQEfZ6Cesrc4VAa7QC3wSMMxsbDj45xkgWjE8D+uKqwYpb4VGrFKg8Vn2uQEZ4o7RR+nKjhbBhLn+usHTHoccl1yVPakEgNjxsoqhrtHSHrVE0u4e3QjH3vHlIL+QZD7CKTJyYymaLERkVStAaucLw4NG3c6Kzae6rD5UeO
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120f326c-78c8-4062-cef2-08d77a34cd7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:12:29.5858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3QzuB51S2WEkSXjpEG2NUnQGH7C60+4h884ZC8TVAcLWdG1d6vxNss4P/UBR5paBgCbW1qJfoIA7D4xYQj15A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z+5Fpvgl/37SfnABIY7gXts9ZLopVw99OX+8ykCYUs=;
 b=qyxWWDeBdlNq8JnesuCifGPH7CfXp+Neqk1ctbsYe11IzPCzamQNXLO6Ve+BhsSuDFSBK8SE/cghwbGCIleHAO8hK7EY0XWZB3/yQxspcfOGxbnwxA3J50SDJUEbQW5vsL3dhCgWJwANg0FcwOrU4vgdVLHshZxJuEjys4OqDmw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSdtIGZpbmUgd2l0aCBpdC4gUGxlYXNlIGNoZWNrIHYzDQoNClJlZ2FyZHMsDQpIYXdraW5nDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+IA0KU2VudDogMjAxOeW5tDEy5pyINuaXpSAxNzo1Mg0KVG86IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgTWEsIExlIDxMZS5NYUBhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVu
dHNAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4NCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDog
UkU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IHJlc3VtZSBmYWlsdXJlcyBkdWUgdG8gcHNwIGZ3
IGxvYWRpbmcgc2VxdWVuY2UgY2hhbmdlICh2MikNCg0KW0FNRCBQdWJsaWMgVXNlXQ0KDQpJIHJl
Y29tbWVuZCB3ZSB1c2UgdGhlIGV4aXN0aW5nICJnb3RvIGZhaWxlZCIgZm9yIHBzcCBsb2FkIGZh
aWx1cmUgY2FzZSwgaW5zdGVhZCBvZiBhZGRpbmcgb25lIG5ldyBtdXRleCB1bmxvY2sgYmVmb3Jl
IHJldHVybmluZy4NClRoaXMgd2lsbCBoZWxwIHJlZHVjZSByZWR1bmRhbnQgY29kZSwgYW5kIG1v
cmVvdmVyLCB0aGVyZSBpcyBvbmUgZXJyb3IgcHJpbnQgIiBQU1AgcmVzdW1lIGZhaWxlZCAiIGlu
ICJmYWlsZWQiIHJvdXRlLCB3aGljaCBtYXkgYmUgY2FwdHVyZWQgZm9yIHRyYWNlL2RlYnVnIHB1
cnBvc2UuDQpIb3cgZG8geW91IHRoaW5rPw0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+IA0KU2VudDogRnJpZGF5LCBEZWNlbWJlciA2LCAyMDE5IDU6NDUgUE0NClRvOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWEsIExlIDxMZS5NYUBhbWQuY29tPjsgQ2xlbWVu
dHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNv
bT4NCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDog
W1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggcmVzdW1lIGZhaWx1cmVzIGR1ZSB0byBwc3AgZncgbG9h
ZGluZyBzZXF1ZW5jZSBjaGFuZ2UgKHYyKQ0KDQp0aGlzIGZpeCB0aGUgcmVncmVzc2lvbiBjYXVz
ZWQgYnkgYXNkL3RhIGxvYWRpbmcgc2VxdWVuY2UgYWRqdXN0bWVudCByZWNlbnRseS4gYXNkL3Rh
IGxvYWRpbmcgd2FzIG1vdmUgb3V0IGZyb20gaHdfc3RhcnQgYW5kIHNob3VsZCBhbHNvIGJlIGFw
cGxpZWQgdG8gcHNwX3Jlc3VtZS4gb3RoZXJ3aXNlIHRob3NlIGZ3IGxvYWRpbmcgd2lsbCBiZSBp
Z25vcmVkIGluIHJlc3VtZSBwaGFzZS4NCg0KQ2hhbmdlLUlkOiBJNjc4ZjgyYjVkZDU1MmQ3MDQz
NWJmZGJkMDEwYzRlZDg1MzYzMTRjOQ0KU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAzNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMNCmluZGV4IGNlZWE4MzE0ZDg4ZC4uMDNjNGEyMjNjMDVmIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCkBAIC0xNzAyLDYgKzE3MDIsNDAgQEAgc3RhdGljIGlu
dCBwc3BfcmVzdW1lKHZvaWQgKmhhbmRsZSkNCiAJaWYgKHJldCkNCiAJCWdvdG8gZmFpbGVkOw0K
IA0KKwlyZXQgPSBwc3BfYXNkX2xvYWQocHNwKTsNCisJaWYgKHJldCkgew0KKwkJRFJNX0VSUk9S
KCJQU1AgbG9hZCBhc2QgZmFpbGVkIVxuIik7DQorCQltdXRleF91bmxvY2soJmFkZXYtPmZpcm13
YXJlLm11dGV4KTsNCisJCXJldHVybiByZXQ7DQorCX0NCisNCisJaWYgKGFkZXYtPmdtYy54Z21p
Lm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsNCisJCXJldCA9IHBzcF94Z21pX2luaXRpYWxpemUo
cHNwKTsNCisJCS8qIFdhcm5pbmcgdGhlIFhHTUkgc2Vlc2lvbiBpbml0aWFsaXplIGZhaWx1cmUN
CisJCSAqIEluc3RlYWQgb2Ygc3RvcCBkcml2ZXIgaW5pdGlhbGl6YXRpb24NCisJCSAqLw0KKwkJ
aWYgKHJldCkNCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LA0KKwkJCQkiWEdNSTogRmFpbGVk
IHRvIGluaXRpYWxpemUgWEdNSSBzZXNzaW9uXG4iKTsNCisJfQ0KKw0KKwlpZiAocHNwLT5hZGV2
LT5wc3AudGFfZncpIHsNCisJCXJldCA9IHBzcF9yYXNfaW5pdGlhbGl6ZShwc3ApOw0KKwkJaWYg
KHJldCkNCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LA0KKwkJCQkJIlJBUzogRmFpbGVkIHRv
IGluaXRpYWxpemUgUkFTXG4iKTsNCisNCisJCXJldCA9IHBzcF9oZGNwX2luaXRpYWxpemUocHNw
KTsNCisJCWlmIChyZXQpDQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwNCisJCQkJIkhEQ1A6
IEZhaWxlZCB0byBpbml0aWFsaXplIEhEQ1BcbiIpOw0KKw0KKwkJcmV0ID0gcHNwX2R0bV9pbml0
aWFsaXplKHBzcCk7DQorCQlpZiAocmV0KQ0KKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsDQor
CQkJCSJEVE06IEZhaWxlZCB0byBpbml0aWFsaXplIERUTVxuIik7DQorCX0NCisNCiAJbXV0ZXhf
dW5sb2NrKCZhZGV2LT5maXJtd2FyZS5tdXRleCk7DQogDQogCXJldHVybiAwOw0KLS0NCjIuMTcu
MQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
