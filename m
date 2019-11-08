Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C9C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 03:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CD22084D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 03:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CD22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596676E047;
	Fri,  8 Nov 2019 03:29:55 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820074.outbound.protection.outlook.com [40.107.82.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5F76E047
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 03:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ2GEiE6eInZVs7Jsqg8Oqx2DJ2kDt2xlrDFpSTtRXuCnRZIxjorGeZ7L6p4j7iasiBWWmYXJfzXRAQwp3BNIjmfdsdRTErbdmP8NqQZ6StVGAS5R7w4B8GBVN9ZRhifqD+VnylBxS0PY/JYQCI+H2qLJwYvMkRmpEeQE+hRpKpRF95IFqSr0nBVLODSwFVjc5BP/0gd6e7EvHH4K+2YbRInoTVtuXLTw07DI8eWXvAPGZnjQ6u3XLTh2UUt/3qOqfij24JN0pyqyg25rHCjCWx9al4CUD/j93J+MsCkep52jq3h+xE3DQkbAV1pCcLoJQO7b3GQjKYfeMiFqybrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDwNIbhcWDQtiUNOzp+RWgSwO672k5juPxP7uZC+wS0=;
 b=WKd+h9xyTiKLoJ6pxqMbxepFXVuIXraMZCGqMGxvJKO6YqnPXZVMo7NpsG/rh5HivlesUfxXT0T4Xs6W2wNrIIKiB94fvEsVD7uY4tXkPGF0iT9F8trBN5sCXykmqeJY+8CC/CCzpqE1rnnDh6T9J1Sxi2FS2MBJWayDW9Yh8guKm7qr2rO5gZ/uBtF/0VFOx93E4Hbmp5q/jHK8Yy2c4eXUNEATXcsTEFywlj7BIzXIjY2ALgrtQSaLWIC8jkTGSHrJCWJy9s6AXiu8Y7jSl80le7PLjPxUZQDvd8KxfYMd9EQMX8/oPScw/QuXayo+DsGN0N0TaUg/7NvOeB8sAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4208.namprd12.prod.outlook.com (10.255.224.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 03:29:51 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 03:29:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: fix AVFS handling with custom
 powerplay table
Thread-Topic: [PATCH] drm/amdgpu/powerplay: fix AVFS handling with custom
 powerplay table
Thread-Index: AQHVlaiIz4K0Wvi/DE+/J1AjYVkIw6eAnidA
Date: Fri, 8 Nov 2019 03:29:51 +0000
Message-ID:
 <MN2PR12MB3344B8BFE159D0E22C30A1C8E47B0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191107201821.1252472-1-alexander.deucher@amd.com>
In-Reply-To: <20191107201821.1252472-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96d2383d-ecae-4222-6207-08d763fbea8c
x-ms-traffictypediagnostic: MN2PR12MB4208:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42088E6CC878B48652DDBE7BE47B0@MN2PR12MB4208.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(13464003)(189003)(199004)(2906002)(76116006)(66946007)(186003)(4326008)(64756008)(66446008)(71200400001)(66476007)(71190400001)(966005)(14454004)(486006)(478600001)(66556008)(99286004)(7736002)(14444005)(74316002)(476003)(256004)(6246003)(6436002)(305945005)(6306002)(55016002)(446003)(7696005)(81166006)(316002)(3846002)(6116002)(229853002)(5660300002)(25786009)(8676002)(76176011)(2501003)(6506007)(53546011)(102836004)(9686003)(86362001)(11346002)(33656002)(26005)(66066001)(52536014)(110136005)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4208;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRgtYHhdp8WecBm9oUzUoJQMuIwRm2ZTFMWI1mclxDn4ohHoti1/jNk7ltsjgaBdOcg4LV092eybbqTDjgTJSqnmZujCKSbCOhjhgiX+noMdDdMgK/WHHfdQVjWPLYQ6+cKa27AYUK7n1n2oN7JdXPdR5KOAPJXyAdOS9gulK25OiydNqFmoLoPjW3MzBa6atY2SATyUFufDEr4gyvBuzoHmBjgUu5UuqManmSrpRihPebtn6IYEL1CUtzH0rI0GFn/85D3T7pv1vdJculLCrIHeUlTVMM191i9j5Trm7B4+Amg3KQFd6OafM5EykmfWmlm5N2xpApyBRon9qZWYU8J4Q7VrQyyX7VeBaA6RV9pdm9fxj520rkDIdkGvDQul6Od7VK6dQTZ44TUGHfQJo82O/oQbMU5y2tLT3MkNLhpzBM4ngHolnShBJOihKa8N3qaF2IvUzrZyDFbrOz0BeHjjUaV86+D4XTLivoTV8sY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d2383d-ecae-4222-6207-08d763fbea8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 03:29:51.8364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ec3K8vam8O1itDMQ4m7COhMtt2LGvQa6Nf+orGCd9cXiGFxZr3iqwi0ANhrw9tn4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDwNIbhcWDQtiUNOzp+RWgSwO672k5juPxP7uZC+wS0=;
 b=HNum7Qpb0CrF99k+k9XvR8V30PaxcadMGcVCMpZB43Ld3ju02aLaz2hjIuh5DnewBRUqiWpqUTvcJM3o9IO9YIWMjOVxyGSvZYwWziHsE00OV9qNuIizZYwa8ONskSx8Jq5yvg2kKtmC+bgQsZscBdnoObJGnpngbi5HfvSp4Xw=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108032951.5WD3oe1RQW1cdkVFLLszp6bIbcP9L1Aa3wuovcYGkL4@z>

UmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBG
cmlkYXksIE5vdmVtYmVyIDgsIDIwMTkgNDoxOCBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1L3Bvd2VycGxheTogZml4IEFW
RlMgaGFuZGxpbmcgd2l0aCBjdXN0b20NCj4gcG93ZXJwbGF5IHRhYmxlDQo+IA0KPiBXaGVuIGEg
Y3VzdG9tIHBvd2VycGxheSB0YWJsZSBpcyBwcm92aWRlZCwgd2UgbmVlZCB0byB1cGRhdGUgdGhl
IE9EIFZEREMNCj4gZmxhZyB0byBhdm9pZCBBVkZTIGJlaW5nIGVuYWJsZWQgd2hlbiBpdCBzaG91
bGRuJ3QgYmUuDQo+IA0KPiBCdWc6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9MjA1MzkzDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci92ZWdhMTBfaHdtZ3IuYyB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMNCj4gaW5kZXggNGVhNjNhMmUxN2RhLi5hNGE3Zjg1
MzQ5NjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdy
L3ZlZ2ExMF9od21nci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3
bWdyL3ZlZ2ExMF9od21nci5jDQo+IEBAIC0zNjg5LDYgKzM2ODksMTMgQEAgc3RhdGljIGludCB2
ZWdhMTBfc2V0X3Bvd2VyX3N0YXRlX3Rhc2tzKHN0cnVjdA0KPiBwcF9od21nciAqaHdtZ3IsDQo+
ICAJUFBfQVNTRVJUX1dJVEhfQ09ERSghcmVzdWx0LA0KPiAgCQkJIkZhaWxlZCB0byB1cGxvYWQg
UFB0YWJsZSEiLCByZXR1cm4gcmVzdWx0KTsNCj4gDQo+ICsJLyoNCj4gKwkgKiBJZiBhIGN1c3Rv
bSBwcCB0YWJsZSBpcyBsb2FkZWQsIHNldCBEUE1UQUJMRV9PRF9VUERBVEVfVkREQw0KPiBmbGFn
Lg0KPiArCSAqIFRoYXQgZWZmZWN0aXZlbHkgZGlzYWJsZXMgQVZGUyBmZWF0dXJlLg0KPiArCSAq
Lw0KPiArCWlmKGh3bWdyLT5oYXJkY29kZV9wcF90YWJsZSAhPSBOVUxMKQ0KPiArCQlkYXRhLT5u
ZWVkX3VwZGF0ZV9kcG1fdGFibGUgfD0NCj4gRFBNVEFCTEVfT0RfVVBEQVRFX1ZEREM7DQo+ICsN
Cj4gIAl2ZWdhMTBfdXBkYXRlX2F2ZnMoaHdtZ3IpOw0KPiANCj4gIAkvKg0KPiAtLQ0KPiAyLjIz
LjANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
