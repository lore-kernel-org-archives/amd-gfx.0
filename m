Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42F5C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 03:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F644222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 03:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F644222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B056EC60;
	Wed, 13 Nov 2019 03:52:45 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790089.outbound.protection.outlook.com [40.107.79.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485366EC60
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 03:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSHdLmHP/KcpZ1bmQqXy6YnW9ekgZGng31GbYrB9p1kfajTNpZRRUtH+pAyLVUjzrET3PkYx0QQ202yO0G+p59VCdLKXm5jjOB7SnepCW5uJVYWKeKyLQnHr1lu0kCICo8YLMZWwE8yffgydZFiQZjtvnkA/iTGXXTFG+LNMXugGbc4JvJ22u58Cm7fZLCXoZGZkxZqHsAkXrSmNB6c9+h5z09QRuvLOORpqadjTfQ+JQQ43uERqusp446AvX1uvWhxDj/P5vBLntnifrkXrgLTQpi7KuI796bXhzVyXxXjCwNLbK2q5BomtSpeGx3FxPjAOPIpUkwKdq0CsMJvVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWsqUddivjyetX2w4maNjCH2htxejZ/ICGefmsx4U/s=;
 b=gvf9jA+POgdBFwcL8YvdmUYb/ubnILZrCiJulXY2fZHs3yaXHTwA3KxCBHu5h3zPHZZjZJEZIF83eM0WtWBOVCXKLvqZ6eVHDamfxfLJgxG5RKCFp3wWKyIlURJFaaFrfmYwMNcdNke9gLNATXzSTkTuEO1LfAcugGiMOkFKQNSVTjlHMevq3Dut7pfnqFt+ZkJoecc7whMAAuSfl9BQUQOa7SSY7Rlxj+qAlCWwOhf4pKjwSgwKKo/lO6G55d7kH9v12+x9C8QYOf0n/2VzI/HvwOeTML4PSLhGBpjuq7UQXS4jachem0LFQBQ84BppB4oIQr5yvwXdr9hK024EzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4286.namprd12.prod.outlook.com (10.255.125.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 03:52:42 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 03:52:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 14/21] drm/amd/powerplay: add JPEG power control for Renoir
Thread-Topic: [PATCH 14/21] drm/amd/powerplay: add JPEG power control for
 Renoir
Thread-Index: AQHVmYOjljGEVUji/0SGiIczpFRiwKeIeImQ
Date: Wed, 13 Nov 2019 03:52:42 +0000
Message-ID:
 <MN2PR12MB33441423271152C265C4C792E4760@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <20191112180329.3927-15-leo.liu@amd.com>
In-Reply-To: <20191112180329.3927-15-leo.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d2178c3-f451-492a-f8e1-08d767ecef85
x-ms-traffictypediagnostic: MN2PR12MB4286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4286F5D9DF820D19F518D61BE4760@MN2PR12MB4286.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:369;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(13464003)(8676002)(74316002)(4326008)(8936002)(76116006)(305945005)(81156014)(81166006)(7736002)(33656002)(229853002)(3846002)(6116002)(55016002)(6246003)(2906002)(6436002)(6306002)(9686003)(478600001)(52536014)(66446008)(64756008)(66556008)(66476007)(66946007)(966005)(99286004)(316002)(110136005)(256004)(14444005)(25786009)(5660300002)(6506007)(71190400001)(26005)(186003)(76176011)(86362001)(7696005)(53546011)(102836004)(446003)(486006)(476003)(2501003)(66066001)(71200400001)(14454004)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4286;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s1SNa7ObfAUfMov5pVuXtza0oGQ8LARImGUY3+9rWB7x+EGaFXE0ifWF6sWkQp0Hc9GrnrQL/idfKHtxlI0F4oNV9ZEEzUB0qyaGWX9bXzgnXZtIeFjXEaSW85/FnFAzlXWFKxennwKBZ5uIvbYATJiELueJsyg8jEZT0JWob2cYifXkkGrl4dSJbs4XasgJw84rw56KwBINS9wuNAvkGE6mNKve0G/yZPnVzT2pqIMB9njC0uUutnC8994ciimOrFkEzXmGVabjoi3OYTKCl3F/zGOaclIFUDwKpMn0gnJrFar64h5XQ84lODb7jDmtnMJ7Y9TmMaR02UsPMixh8/qYJaR9k3FQUePmBIftNDnakmZ25XiRej3RPP5bYnsOGRxcP1jkICH9NEjnyyHOOrK5KyIWM6KXau9/b/8j5x6I5a7ZMa4lf13pJZrdMkk+
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2178c3-f451-492a-f8e1-08d767ecef85
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 03:52:42.1473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kvp2NRwSMjpaH/fQi4AXpXhArTvvEuF0Xwf2NifAI0mD5mAF22JRy4/0le5FWDzH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWsqUddivjyetX2w4maNjCH2htxejZ/ICGefmsx4U/s=;
 b=OkBPg8geZ+OKwAxA2FZPhc20tHjtbteahnV/UEp7Zjn0yhEi5WoFS8A8n4GcxacMzfKw5yt2UUYJgoqCjS0O+OLJq5AIcPVqM1hl6uaeFFFjf+5yUXmnFdyHHkZYyOMnYE8CxurVqN3/6Gl3tl50peHZiTwSHuUfB1Aogu84ZtM=
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
Message-ID: <20191113035242.MyQzmnAypikN28PhyhfKF67JUbtCHFuVRThlvlWQdWQ@z>

T24gUmVuaW9yLCBib3RoIFNNVV9NU0dfUG93ZXJEb3duSnBlZyBhbmQgU01VX01TR19Qb3dlclVw
SnBlZyBuZWVkIGFuIGFyZ3VtZW50Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZiBMZW8gTGl1DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMTkg
MjowMyBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IExpdSwg
TGVvIDxMZW8uTGl1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxNC8yMV0gZHJtL2FtZC9w
b3dlcnBsYXk6IGFkZCBKUEVHIHBvd2VyIGNvbnRyb2wgZm9yDQo+IFJlbm9pcg0KPiANCj4gQnkg
dXNpbmcgaXRzIG93biBKUEVHIFBvd2VyVXAgYW5kIFBvd2VyRG93biBtZXNzYWdlcw0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYyB8IDI2ICsrKysrKysrKysrKysr
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jDQo+IGluZGV4IDQ5MmEy
MDE1NTRlOC4uZjU2MWZiOWNjOTUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9yZW5vaXJfcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvcmVub2lyX3BwdC5jDQo+IEBAIC0zMDEsNiArMzAxLDMxIEBAIHN0YXRpYyBpbnQgcmVu
b2lyX2RwbV9zZXRfdXZkX2VuYWJsZShzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSwgYm9vbCBl
bmFibGUpDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaW50IHJlbm9pcl9k
cG1fc2V0X2pwZWdfZW5hYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sDQo+ICtlbmFi
bGUpIHsNCj4gKwlzdHJ1Y3Qgc211X3Bvd2VyX2NvbnRleHQgKnNtdV9wb3dlciA9ICZzbXUtPnNt
dV9wb3dlcjsNCj4gKwlzdHJ1Y3Qgc211X3Bvd2VyX2dhdGUgKnBvd2VyX2dhdGUgPSAmc211X3Bv
d2VyLT5wb3dlcl9nYXRlOw0KPiArCWludCByZXQgPSAwOw0KPiArDQo+ICsJaWYgKGVuYWJsZSkg
ew0KPiArCQlpZiAoc211X2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsDQo+IFNNVV9GRUFUVVJFX0pQ
RUdfUEdfQklUKSkgew0KPiArCQkJcmV0ID0gc211X3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNt
dSwNCj4gU01VX01TR19Qb3dlclVwSnBlZywgMCk7DQo+ICsJCQlpZiAocmV0KQ0KPiArCQkJCXJl
dHVybiByZXQ7DQo+ICsJCX0NCj4gKwkJcG93ZXJfZ2F0ZS0+anBlZ19nYXRlZCA9IGZhbHNlOw0K
PiArCX0gZWxzZSB7DQo+ICsJCWlmIChzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNtdSwNCj4gU01V
X0ZFQVRVUkVfSlBFR19QR19CSVQpKSB7DQo+ICsJCQlyZXQgPSBzbXVfc2VuZF9zbWNfbXNnKHNt
dSwNCj4gU01VX01TR19Qb3dlckRvd25KcGVnKTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJcmV0
dXJuIHJldDsNCj4gKwkJfQ0KPiArCQlwb3dlcl9nYXRlLT5qcGVnX2dhdGVkID0gdHJ1ZTsNCj4g
Kwl9DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHJlbm9p
cl9mb3JjZV9kcG1fbGltaXRfdmFsdWUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgaGln
aGVzdCkNCj4gew0KPiAgCWludCByZXQgPSAwLCBpID0gMDsNCj4gQEAgLTY4Myw2ICs3MDgsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3MgcmVub2lyX3BwdF9mdW5jcyA9IHsN
Cj4gIAkucHJpbnRfY2xrX2xldmVscyA9IHJlbm9pcl9wcmludF9jbGtfbGV2ZWxzLA0KPiAgCS5n
ZXRfY3VycmVudF9wb3dlcl9zdGF0ZSA9IHJlbm9pcl9nZXRfY3VycmVudF9wb3dlcl9zdGF0ZSwN
Cj4gIAkuZHBtX3NldF91dmRfZW5hYmxlID0gcmVub2lyX2RwbV9zZXRfdXZkX2VuYWJsZSwNCj4g
KwkuZHBtX3NldF9qcGVnX2VuYWJsZSA9IHJlbm9pcl9kcG1fc2V0X2pwZWdfZW5hYmxlLA0KPiAg
CS5mb3JjZV9kcG1fbGltaXRfdmFsdWUgPSByZW5vaXJfZm9yY2VfZHBtX2xpbWl0X3ZhbHVlLA0K
PiAgCS51bmZvcmNlX2RwbV9sZXZlbHMgPSByZW5vaXJfdW5mb3JjZV9kcG1fbGV2ZWxzLA0KPiAg
CS5nZXRfd29ya2xvYWRfdHlwZSA9IHJlbm9pcl9nZXRfd29ya2xvYWRfdHlwZSwNCj4gLS0NCj4g
Mi4xNy4xDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
