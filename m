Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C66C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 03:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC05222CE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 03:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC05222CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9C16E047;
	Wed, 13 Nov 2019 03:50:32 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740049.outbound.protection.outlook.com [40.107.74.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5AE6E047
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 03:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgKqXbIjghWqXydePNbIHXVMkF3jkxg+ZNrwUKgWG2mdEe5oN1ExJzHDQyKKtV0EYpE62XMqtVctD++fJQmCsvn9xd6X19STIbsaKKCFI1KyeObJhSCqIdRvvwqro62Z8r5bAOqE9BSI21x7tL0gCT40pNrsmMpNMZA4+2p+N5zkKOQApDbmOAQ+qzlDBHdjqK8nb/9uPdPlwiYKCA8oFmbZHTvGqT+y7GVXeUbUFic63umbBbi+goEranZ1fJ3nDUfW+I7+UTmS45xWK/+4m50TsNVR1+Ccd6RJz67WsPZeuJCOUozyrp3Yp73DJkEYRH69g3ttqjIkdLudrdUAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+ZSe8LZ1nkbT0nOEPb/CW9tIDqoUN6uqa6x+e1DwLQ=;
 b=c5PMbYkl4UQjI3iYPQ52oSzH3ErzITTosHkyRfC+04AYI42RV8DyTwHvKd9aCpCd84JzBliyz9xX25CjmUCpQVWW1k2LFXNUSFbJjQ966HoNLdu1t6ksI+EUD8C+i2Q01Kd53pI2ofkiUQWzQonoJVjk/JZi90irKVYXecdUXKYNIumBQaYuXyYzEADXWP/bdM/oFb26noAok9rlsH1QjFHUGTveYajhWamb8JsdpWZzxz/bm2b833NCgBJW9VUoTTtj0ZePo0V/2JVDaGmijg8RnxvHRexYl9uOAP8tJ8NnfqY1QkOHs6zT4UTTzgEnANGbbXLbE6rs+buTW0LdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4160.namprd12.prod.outlook.com (10.255.125.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 03:50:29 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 03:50:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 12/21] drm/amd/powerplay: add JPEG power control for Navi1x
Thread-Topic: [PATCH 12/21] drm/amd/powerplay: add JPEG power control for
 Navi1x
Thread-Index: AQHVmYOa5FIzY/ga+EC+NzB2qkkU5qeId8Jg
Date: Wed, 13 Nov 2019 03:50:28 +0000
Message-ID:
 <MN2PR12MB334438FF2957ED7C7C8E226FE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <20191112180329.3927-13-leo.liu@amd.com>
In-Reply-To: <20191112180329.3927-13-leo.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cb1990c-e9d3-45a3-9029-08d767ec9fed
x-ms-traffictypediagnostic: MN2PR12MB4160:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB416095A83A9B776A1CB0255CE4760@MN2PR12MB4160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(13464003)(199004)(189003)(7736002)(33656002)(81166006)(486006)(66446008)(476003)(110136005)(4326008)(14454004)(66476007)(66946007)(8676002)(99286004)(2501003)(9686003)(6306002)(55016002)(11346002)(6436002)(81156014)(6246003)(64756008)(966005)(305945005)(229853002)(446003)(74316002)(66556008)(256004)(25786009)(6116002)(3846002)(76116006)(76176011)(316002)(71190400001)(71200400001)(186003)(53546011)(6506007)(86362001)(66066001)(52536014)(26005)(8936002)(7696005)(5660300002)(102836004)(2906002)(478600001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4160;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObpPdBqUI1yP+Ct/hinzRSk/sgNlI5lERWKUySb/5N297WTLTFVQyA/GSoiSSWTAWIOHlqIxjbKzWa21elOI0XTwhuvFshBV9k3YMhLiYAlDNL31Wz1w887+hp0skSECGStkZ/3btPq5KLzMDVRXDY37CQSyXkv3KR3mYl3g47OzlQCwQXmPznDIs0ld/+7SLsiHLP74+4YUnNJCW39coYEBbzClx/bPn67Vm7UlWbju0z2sGLrCozhso0rc0JssjfzwPIIZrGlvkF5P7SyHiU83uWj9WCLKoEcauKA1LDJGbaeobdjUoNcnM2FDTN41GR3cgsLbVO9PgMMhj9ZW19oVxrGzIXutHEoZymiLwktryLhmHMT9Fb+oB2Ke78AsgewKSDOsFNYhUrZBZE3xMKRKKDZfGvsZCrYOrlPkBz+aAG0gDvoY+0t69YlHh0mNPD1cp5D8gxrVtP9HDRyW9To3evytEhH+VbaR1plOIIU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb1990c-e9d3-45a3-9029-08d767ec9fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 03:50:28.6645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gk1ewg5II68y1HB9QeIZUg3N9Q77xNRH1ZfohH1yJx74X0Cn5XA1h/Btmhq+mXNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+ZSe8LZ1nkbT0nOEPb/CW9tIDqoUN6uqa6x+e1DwLQ=;
 b=P4ltHB4M9zvHT/PjgKizXO7XnIh3Zxl0UYrwpowvAeS6sLjBzsnTLkOF343FIrD4vl2Ql7B+/6qjIPzPKH0gEjjSSP7JPCN8QiOrhBFt08hp+Fn1c2VBvbO+sL6IE+P6VAWEvtYRJlZC9G6794qU7KG3FO5W3tcjxA+W3Lw3gy8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113035028.QGqEifnVeNsTu91_4X8w07amkqn2eQT7B1WG8nw7m2o@z>

Rm9yIE5hdmkxMCwgU01VX01TR19Qb3dlclVwSnBlZyBtZXNzYWdlIGRvZXMgbm90IG5lZWQgYW4g
YXJndW1lbnQuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdm
eCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIExl
byBMaXUNCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAxOSAyOjAzIEFNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGl1LCBMZW8gPExlby5MaXVA
YW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEyLzIxXSBkcm0vYW1kL3Bvd2VycGxheTogYWRk
IEpQRUcgcG93ZXIgY29udHJvbCBmb3INCj4gTmF2aTF4DQo+IA0KPiBCeSBzZXBhcmF0aW5nIHRo
ZSBKUEVHIHBvd2VyIGZlYXR1cmUsIGFuZCB1c2luZyBpdHMgb3duIFBvd2VyVXAgYW5kDQo+IFBv
d2VyRG93biBtZXNzYWdlcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBh
bWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9w
cHQuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KPiBpbmRleCBhZWI5YzFlMzQxYzcuLjc2MDU2OGRl
YmU2YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEw
X3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQu
Yw0KPiBAQCAtMzg0LDggKzM4NCwxMCBAQCBuYXZpMTBfZ2V0X2FsbG93ZWRfZmVhdHVyZV9tYXNr
KHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiAgCQkqKHVpbnQ2NF90ICopZmVhdHVyZV9t
YXNrIHw9DQo+IEZFQVRVUkVfTUFTSyhGRUFUVVJFX0FUSFVCX1BHX0JJVCk7DQo+IA0KPiAgCWlm
IChzbXUtPmFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOKQ0KPiAtCQkqKHVpbnQ2
NF90ICopZmVhdHVyZV9tYXNrIHw9DQo+IEZFQVRVUkVfTUFTSyhGRUFUVVJFX1ZDTl9QR19CSVQp
DQo+IC0JCQkJfCBGRUFUVVJFX01BU0soRkVBVFVSRV9KUEVHX1BHX0JJVCk7DQo+ICsJCSoodWlu
dDY0X3QgKilmZWF0dXJlX21hc2sgfD0NCj4gRkVBVFVSRV9NQVNLKEZFQVRVUkVfVkNOX1BHX0JJ
VCk7DQo+ICsNCj4gKwlpZiAoc211LT5hZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX0pQ
RUcpDQo+ICsJCSoodWludDY0X3QgKilmZWF0dXJlX21hc2sgfD0NCj4gRkVBVFVSRV9NQVNLKEZF
QVRVUkVfSlBFR19QR19CSVQpOw0KPiANCj4gIAkvKiBkaXNhYmxlIERQTSBVQ0xLIGFuZCBEUyBT
T0NDTEsgb24gbmF2aTEwIEEwIHNlY3VyZSBib2FyZCAqLw0KPiAgCWlmIChpc19hc2ljX3NlY3Vy
ZShzbXUpKSB7DQo+IEBAIC02NjUsNiArNjY3LDMxIEBAIHN0YXRpYyBpbnQgbmF2aTEwX2RwbV9z
ZXRfdXZkX2VuYWJsZShzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpDQo+
ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaW50IG5hdmkxMF9kcG1fc2V0X2pw
ZWdfZW5hYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sDQo+ICtlbmFibGUpIHsNCj4g
KwlzdHJ1Y3Qgc211X3Bvd2VyX2NvbnRleHQgKnNtdV9wb3dlciA9ICZzbXUtPnNtdV9wb3dlcjsN
Cj4gKwlzdHJ1Y3Qgc211X3Bvd2VyX2dhdGUgKnBvd2VyX2dhdGUgPSAmc211X3Bvd2VyLT5wb3dl
cl9nYXRlOw0KPiArCWludCByZXQgPSAwOw0KPiArDQo+ICsJaWYgKGVuYWJsZSkgew0KPiArCQlp
ZiAoc211X2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsDQo+IFNNVV9GRUFUVVJFX0pQRUdfUEdfQklU
KSkgew0KPiArCQkJcmV0ID0gc211X3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gU01V
X01TR19Qb3dlclVwSnBlZywgMSk7DQo+ICsJCQlpZiAocmV0KQ0KPiArCQkJCXJldHVybiByZXQ7
DQo+ICsJCX0NCj4gKwkJcG93ZXJfZ2F0ZS0+anBlZ19nYXRlZCA9IGZhbHNlOw0KPiArCX0gZWxz
ZSB7DQo+ICsJCWlmIChzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNtdSwNCj4gU01VX0ZFQVRVUkVf
SlBFR19QR19CSVQpKSB7DQo+ICsJCQlyZXQgPSBzbXVfc2VuZF9zbWNfbXNnKHNtdSwNCj4gU01V
X01TR19Qb3dlckRvd25KcGVnKTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJcmV0dXJuIHJldDsN
Cj4gKwkJfQ0KPiArCQlwb3dlcl9nYXRlLT5qcGVnX2dhdGVkID0gdHJ1ZTsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG5hdmkxMF9nZXRfY3Vy
cmVudF9jbGtfZnJlcV9ieV90YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gIAkJCQkg
ICAgICAgZW51bSBzbXVfY2xrX3R5cGUgY2xrX3R5cGUsDQo+ICAJCQkJICAgICAgIHVpbnQzMl90
ICp2YWx1ZSkNCj4gQEAgLTE5OTYsNiArMjAyMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0
YWJsZV9mdW5jcyBuYXZpMTBfcHB0X2Z1bmNzID0NCj4gew0KPiAgCS5nZXRfYWxsb3dlZF9mZWF0
dXJlX21hc2sgPSBuYXZpMTBfZ2V0X2FsbG93ZWRfZmVhdHVyZV9tYXNrLA0KPiAgCS5zZXRfZGVm
YXVsdF9kcG1fdGFibGUgPSBuYXZpMTBfc2V0X2RlZmF1bHRfZHBtX3RhYmxlLA0KPiAgCS5kcG1f
c2V0X3V2ZF9lbmFibGUgPSBuYXZpMTBfZHBtX3NldF91dmRfZW5hYmxlLA0KPiArCS5kcG1fc2V0
X2pwZWdfZW5hYmxlID0gbmF2aTEwX2RwbV9zZXRfanBlZ19lbmFibGUsDQo+ICAJLmdldF9jdXJy
ZW50X2Nsa19mcmVxX2J5X3RhYmxlID0NCj4gbmF2aTEwX2dldF9jdXJyZW50X2Nsa19mcmVxX2J5
X3RhYmxlLA0KPiAgCS5wcmludF9jbGtfbGV2ZWxzID0gbmF2aTEwX3ByaW50X2Nsa19sZXZlbHMs
DQo+ICAJLmZvcmNlX2Nsa19sZXZlbHMgPSBuYXZpMTBfZm9yY2VfY2xrX2xldmVscywNCj4gLS0N
Cj4gMi4xNy4xDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
