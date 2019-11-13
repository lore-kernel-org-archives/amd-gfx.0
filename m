Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F84FC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 03:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA82222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 03:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA82222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206316E566;
	Wed, 13 Nov 2019 03:52:32 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790089.outbound.protection.outlook.com [40.107.79.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5E46E566
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 03:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6qK0Jmb62Cvtj1IIHseTJJjo3AjvDZBz8aLB25/2B/LOM7YTqEMhWUrgnGd/eCVy5HG6bENc8DW5IEXl6s+c1cWRKE1XBThrXW1AVfRpdbaCsHDWhlaxEYssC55v5eknmYLbsPdOlXS/t082XDxhCztVHVIc8XkMmE0OBGD4yzhS8eJaQ1HozGbV59ae7MaO43i6xE7JXqXvC9UGwkPyP2zbgvZ/PUUqAZsnNaZqaQPZfP37D1hCzYekCsv9wbRjzl7+tvXH9F+kSe0YgqZ77R0WkKZMvJyU0xJTEjMsqmQsEc9e3l+ZVCgSaebyxFaCY3SENLHarCxV60GudisQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVcWdBOMBt6Ad810ZyDd/FUUVEBgAsWvMfe9+3WEfPY=;
 b=TxMtUud1TUq/I2eVurSuf2l9eylNS+hI5fnMkLDHt7geKFJpkxoeY4xU/x9qXEiWKcebv9BCfe3BKRyEMpNv7P2qRSrFjpM+F3Fb8oGzrx90YJN8kBOfQTarzTE5brq44hQRGEL5H83UAaeGZQqDfOOgaXo5QYv4vPKEHxasVyfXrzBLcf9tu5r6t07ltkDW1YOdCvB7tokiInwoiMxUODts/LAGYD0IKt3HlbnvdR43eo1E0W5y8vdyHCxAV1X03jo1ToVZM0AtJXPa6FR+dqrtJC3LJbdNn4+dtHDddXSG6bKTZ+5CzyGiJcPeiNASzrbLYLylqEWS/4taOliReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4286.namprd12.prod.outlook.com (10.255.125.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 03:52:27 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 03:52:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 13/21] drm/amd/powerplay: add Powergate JPEG for Renoir
Thread-Topic: [PATCH 13/21] drm/amd/powerplay: add Powergate JPEG for Renoir
Thread-Index: AQHVmYOc9EoHaqAuL0yl42IPbIThgKeIeCSw
Date: Wed, 13 Nov 2019 03:52:27 +0000
Message-ID:
 <MN2PR12MB3344E08F1C57B71C77AA37CBE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <20191112180329.3927-14-leo.liu@amd.com>
In-Reply-To: <20191112180329.3927-14-leo.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae424067-2f46-4650-052b-08d767ece6ca
x-ms-traffictypediagnostic: MN2PR12MB4286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42865C1E8A3D9CFCD773E484E4760@MN2PR12MB4286.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(13464003)(8676002)(74316002)(4326008)(8936002)(76116006)(305945005)(81156014)(81166006)(7736002)(33656002)(229853002)(3846002)(6116002)(55016002)(6246003)(2906002)(6436002)(6306002)(9686003)(478600001)(52536014)(66446008)(64756008)(66556008)(66476007)(66946007)(966005)(99286004)(316002)(110136005)(256004)(25786009)(5660300002)(6506007)(71190400001)(26005)(186003)(76176011)(86362001)(7696005)(53546011)(102836004)(446003)(486006)(476003)(2501003)(66066001)(71200400001)(14454004)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4286;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jvg9E/bSLEtX+KN79BfYwUacqD50vYNRPvsIecaJMqsgm13sbybg2kSIYL6YDF0mHyEn/6hYfiv0wjVG+UbEkSeZ0ENoSai6wCiL74aG/MXfKo2WQk2iClf4QtqyBNmgr216XO2INHYbqq51q1EYM5F/eXQejRFYIGATW7tRCTW6nrCiVYRENx25mqt7eX6//N3Gnrv+RnRBKotcAbXwI2eahIpuAiGl08EqJJuuntBwfsdUavqAdfSqw26O8RKiSDB8IjCe4KllyY3A+cpmlPJd4u+5y0x4Uv7yzx0NQrSuVsiMRw8c/Q1OYokd8LpW9SKRNJ+d4OE9Zz4dv8TKlcUlaymwMiyC+HEZP+nO55Z5abOR+y+huth9nNeAnTMCsub4UL6G6rNOdMUGYdxy8TvZxBy+PqBJNJYfcgGosboqrY+KFregCnW1MNVAnAfD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae424067-2f46-4650-052b-08d767ece6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 03:52:27.5847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCRrH4NXvTJprE/lp/rIzRIPYclFUYp59ULyGzs6Rl1Emtouq8krPnhdIkbpKKDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVcWdBOMBt6Ad810ZyDd/FUUVEBgAsWvMfe9+3WEfPY=;
 b=qZv3xLHYS/X4mZ/j2ht2Hf/F6fe+pVqvF8ewOftefE5wBRN7+wy9qHe6Qz5FmKAATzyilYNLQOT5cLuzbFvA5671vzWjnYFtCjBQdoBNp4i66LQaRAJv613/yPrkFzlfShCtxVvHOK02Ig+p/8wzwobgIY3JUhvQaW7iIblmgas=
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
Message-ID: <20191113035227.DBKF3mExnXCbhj_LNC5FtQ3vtPMTmlTzI8aP7ydGPKA@z>

T24gUmVuaW9yLCBib3RoIFNNVV9NU0dfUG93ZXJEb3duSnBlZyBhbmQgU01VX01TR19Qb3dlclVw
SnBlZyBuZWVkIGFuIGFyZ3VtZW50Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZiBMZW8gTGl1DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMTkg
MjowMyBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IExpdSwg
TGVvIDxMZW8uTGl1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxMy8yMV0gZHJtL2FtZC9w
b3dlcnBsYXk6IGFkZCBQb3dlcmdhdGUgSlBFRyBmb3IgUmVub2lyDQo+IA0KPiBTaW1pbGFyIHRv
IFNETUEsIFZDTiBldGMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFt
ZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jICAgIHwgIDIgKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVf
djEyXzAuaCB8ICAyICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJf
cHB0LmMgICAgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfaW50
ZXJuYWwuaCAgfCAgMiArKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3Yx
Ml8wLmMgICAgIHwgMTEgKysrKysrKysrKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9z
bXUuYw0KPiBpbmRleCA2OTI0M2E4NThkZDUuLjIxMTkzNDUyMWQzNyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiBAQCAtMTIyOSw2ICsxMjI5
LDcgQEAgc3RhdGljIGludCBzbXVfaHdfaW5pdCh2b2lkICpoYW5kbGUpDQo+ICAJaWYgKGFkZXYt
PmZsYWdzICYgQU1EX0lTX0FQVSkgew0KPiAgCQlzbXVfcG93ZXJnYXRlX3NkbWEoJmFkZXYtPnNt
dSwgZmFsc2UpOw0KPiAgCQlzbXVfcG93ZXJnYXRlX3ZjbigmYWRldi0+c211LCBmYWxzZSk7DQo+
ICsJCXNtdV9wb3dlcmdhdGVfanBlZygmYWRldi0+c211LCBmYWxzZSk7DQo+ICAJCXNtdV9zZXRf
Z2Z4X2NncGcoJmFkZXYtPnNtdSwgdHJ1ZSk7DQo+ICAJfQ0KPiANCj4gQEAgLTEyODcsNiArMTI4
OCw3IEBAIHN0YXRpYyBpbnQgc211X2h3X2Zpbmkodm9pZCAqaGFuZGxlKQ0KPiAgCWlmIChhZGV2
LT5mbGFncyAmIEFNRF9JU19BUFUpIHsNCj4gIAkJc211X3Bvd2VyZ2F0ZV9zZG1hKCZhZGV2LT5z
bXUsIHRydWUpOw0KPiAgCQlzbXVfcG93ZXJnYXRlX3ZjbigmYWRldi0+c211LCB0cnVlKTsNCj4g
KwkJc211X3Bvd2VyZ2F0ZV9qcGVnKCZhZGV2LT5zbXUsIHRydWUpOw0KPiAgCX0NCj4gDQo+ICAJ
cmV0ID0gc211X3N0b3BfdGhlcm1hbF9jb250cm9sKHNtdSk7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMl8wLmgNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMl8wLmgNCj4gaW5kZXggOWI5ZjVkZjA5MTFj
Li4xNzQ1ZTAxNDZmYmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2luYy9zbXVfdjEyXzAuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9pbmMvc211X3YxMl8wLmgNCj4gQEAgLTU4LDYgKzU4LDggQEAgaW50IHNtdV92MTJfMF9wb3dl
cmdhdGVfc2RtYShzdHJ1Y3Qgc211X2NvbnRleHQNCj4gKnNtdSwgYm9vbCBnYXRlKTsNCj4gDQo+
ICBpbnQgc211X3YxMl8wX3Bvd2VyZ2F0ZV92Y24oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJv
b2wgZ2F0ZSk7DQo+IA0KPiAraW50IHNtdV92MTJfMF9wb3dlcmdhdGVfanBlZyhzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwgYm9vbCBnYXRlKTsNCj4gKw0KPiAgaW50IHNtdV92MTJfMF9zZXRfZ2Z4
X2NncGcoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZW5hYmxlKTsNCj4gDQo+ICB1aW50
MzJfdCBzbXVfdjEyXzBfZ2V0X2dmeG9mZl9zdGF0dXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUp
OyBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3Bw
dC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jDQo+IGlu
ZGV4IDA0ZGFmN2U5ZmUwNS4uNDkyYTIwMTU1NGU4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jDQo+IEBAIC02OTcsNiArNjk3LDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBwcHRhYmxlX2Z1bmNzIHJlbm9pcl9wcHRfZnVuY3MgPSB7DQo+ICAJLmNo
ZWNrX2Z3X3ZlcnNpb24gPSBzbXVfdjEyXzBfY2hlY2tfZndfdmVyc2lvbiwNCj4gIAkucG93ZXJn
YXRlX3NkbWEgPSBzbXVfdjEyXzBfcG93ZXJnYXRlX3NkbWEsDQo+ICAJLnBvd2VyZ2F0ZV92Y24g
PSBzbXVfdjEyXzBfcG93ZXJnYXRlX3ZjbiwNCj4gKwkucG93ZXJnYXRlX2pwZWcgPSBzbXVfdjEy
XzBfcG93ZXJnYXRlX2pwZWcsDQo+ICAJLnNlbmRfc21jX21zZyA9IHNtdV92MTJfMF9zZW5kX21z
ZywNCj4gIAkuc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0gPSBzbXVfdjEyXzBfc2VuZF9tc2dfd2l0
aF9wYXJhbSwNCj4gIAkucmVhZF9zbWNfYXJnID0gc211X3YxMl8wX3JlYWRfYXJnLA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X2ludGVybmFsLmgNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfaW50ZXJuYWwuaA0KPiBpbmRleCA4
YmNkYTc4NzEzMDkuLjcwYzRkNjY3MjFjZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvc211X2ludGVybmFsLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvc211X2ludGVybmFsLmgNCj4gQEAgLTQyLDYgKzQyLDggQEANCj4gIAkoKHNt
dSktPnBwdF9mdW5jcy0+cG93ZXJnYXRlX3NkbWEgPyAoc211KS0+cHB0X2Z1bmNzLQ0KPiA+cG93
ZXJnYXRlX3NkbWEoKHNtdSksIChnYXRlKSkgOiAwKSAgI2RlZmluZSBzbXVfcG93ZXJnYXRlX3Zj
bihzbXUsIGdhdGUpDQo+IFwNCj4gIAkoKHNtdSktPnBwdF9mdW5jcy0+cG93ZXJnYXRlX3ZjbiA/
IChzbXUpLT5wcHRfZnVuY3MtDQo+ID5wb3dlcmdhdGVfdmNuKChzbXUpLCAoZ2F0ZSkpIDogMCkN
Cj4gKyNkZWZpbmUgc211X3Bvd2VyZ2F0ZV9qcGVnKHNtdSwgZ2F0ZSkgXA0KPiArCSgoc211KS0+
cHB0X2Z1bmNzLT5wb3dlcmdhdGVfanBlZyA/DQo+ICsoc211KS0+cHB0X2Z1bmNzLT5wb3dlcmdh
dGVfanBlZygoc211KSwgKGdhdGUpKSA6IDApDQo+IA0KPiAgI2RlZmluZSBzbXVfZ2V0X3ZiaW9z
X2Jvb3R1cF92YWx1ZXMoc211KSBcDQo+ICAJKChzbXUpLT5wcHRfZnVuY3MtPmdldF92Ymlvc19i
b290dXBfdmFsdWVzID8gKHNtdSktPnBwdF9mdW5jcy0NCj4gPmdldF92Ymlvc19ib290dXBfdmFs
dWVzKChzbXUpKSA6IDApIGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVfdjEyXzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92
MTJfMC5jDQo+IGluZGV4IDEzOWRkNzM3ZWFhNS4uZjVkODcxMTBlYzM0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYw0KPiBAQCAtMjAzLDYgKzIwMywx
NyBAQCBpbnQgc211X3YxMl8wX3Bvd2VyZ2F0ZV92Y24oc3RydWN0IHNtdV9jb250ZXh0DQo+ICpz
bXUsIGJvb2wgZ2F0ZSkNCj4gIAkJcmV0dXJuIHNtdV9zZW5kX3NtY19tc2coc211LCBTTVVfTVNH
X1Bvd2VyVXBWY24pOyAgfQ0KPiANCj4gK2ludCBzbXVfdjEyXzBfcG93ZXJnYXRlX2pwZWcoc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZ2F0ZSkgew0KPiArCWlmICghKHNtdS0+YWRldi0+
ZmxhZ3MgJiBBTURfSVNfQVBVKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlpZiAoZ2F0ZSkN
Cj4gKwkJcmV0dXJuIHNtdV9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX1Bvd2VyRG93bkpwZWcp
Ow0KPiArCWVsc2UNCj4gKwkJcmV0dXJuIHNtdV9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX1Bv
d2VyVXBKcGVnKTsgfQ0KPiArDQo+ICBpbnQgc211X3YxMl8wX3NldF9nZnhfY2dwZyhzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpICB7DQo+ICAJaWYgKCEoc211LT5hZGV2LT5w
Z19mbGFncyAmIEFNRF9QR19TVVBQT1JUX0dGWF9QRykpDQo+IC0tDQo+IDIuMTcuMQ0KPiANCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
