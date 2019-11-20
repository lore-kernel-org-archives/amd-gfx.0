Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C33C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 03:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23C62240E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 03:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23C62240E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8EA6E471;
	Wed, 20 Nov 2019 03:11:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8CD6E471
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 03:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIsxOCUWwjqAIG7X+reTzjQl1RcfDgB5Uum/QEvyqKKkUwyjNjpA/nebp7tau6m2TPFq9qMVNr1QX5HGahA6gLvz+x+YtDPnOeLdsD5goq1Q+0stYCTLKWyl0FzjIxM7zs9pHsI+5E1FQjrpiU8anQwWY+K7VRsAmhnr6rjmXzU/6NxzJMbaPdcXOa7cts1acAl7JakdrmTnr0zix7pzlLybPfq3lGBTIoTEb46En0n8BFvbdCBUFn0jockGmVqOcWFYB5CCGjX7+duqSMQnscUI3tZk7Cl8HGMJRGo6a1Jajz7j454kcW0TvZ0j7QdxLXm+h2FdW9aiT5GmscH02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7bQbo4Pw5mEo4N8tqgfUzb8cGPfk7KaHFckEKOHqnU=;
 b=Oi0M4h2+Yn6wY0Hk8XpsTJKaTQbwy0lcftQ9qU2yLCepaKR9QH7mVyD3PZ7rkM7kj41wx71wub0UrcF9J2yiH1nYvPYQNoStMWgSdyL8PjEI+JBnu6VA4+XE4MLQd2sXhHcC/C8dNJI3HBKT0hYSuDxMlnstXzgTSyZf5vZZnVC3nHlUuiqglP6VEuO+1XmTMELb2Z0ChEj6DnHu24uEBMEF4jiJIpw9IAQzO5/8uXQlBQ7V/sJp7x1vdPi9E4ftSxtd7GkdmPRn1y9RpCJf66GQH/k4HOkWtL9t2QpoCpLEzVBBL1rtRCwyFfHj2g6zpwe+g5KUEXTIOuUrn3WOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3246.namprd12.prod.outlook.com (20.179.81.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 03:10:58 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 03:10:58 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: enable TMZ bit in FRAME_CONTROL for gfx10
Thread-Topic: [PATCH 5/5] drm/amdgpu: enable TMZ bit in FRAME_CONTROL for gfx10
Thread-Index: AQHVnc+v7pumClvDj0KJ7ANCnBKULqeTLPYAgAA2fCA=
Date: Wed, 20 Nov 2019 03:10:58 +0000
Message-ID:
 <MN2PR12MB38382F2F7E525C5835BAC9C5F04F0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
 <1574054316-2802-5-git-send-email-aaron.liu@amd.com>
 <de8125e7-a483-4701-7d29-2ba33ca3e21d@amd.com>
In-Reply-To: <de8125e7-a483-4701-7d29-2ba33ca3e21d@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cd22081-ac12-4117-3d92-08d76d6743fc
x-ms-traffictypediagnostic: MN2PR12MB3246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB324649B3713A6E9E18D5907AF04F0@MN2PR12MB3246.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(13464003)(189003)(199004)(64756008)(66446008)(7736002)(8676002)(81166006)(3846002)(55016002)(6116002)(99286004)(4001150100001)(6436002)(26005)(25786009)(229853002)(6506007)(53546011)(110136005)(54906003)(102836004)(2501003)(66066001)(6246003)(66556008)(186003)(66946007)(66476007)(316002)(446003)(5660300002)(9686003)(486006)(81156014)(11346002)(305945005)(476003)(33656002)(8936002)(76116006)(74316002)(86362001)(14444005)(256004)(7696005)(71200400001)(71190400001)(76176011)(2906002)(52536014)(14454004)(4326008)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3246;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cgwlniw+um+y31/+hrrITc2c09kyXjYlHqanwRqA1VC/G5ErkeJPxNGwCEALX8zF7jPsNVMjpNnN9ZMhY0ssQnItAGZQ1zJKPXBbbFd/aTA9ya4G9LbxRmxqBjrZdOhPxCd1fAYl2lMQUBqtRteF12A3GO8+TyngrssHEJSAHZIIOk5xxim50vnwB8p3ntwKQfVu5+cUaHJjGT00/+syeV7PVMKtDARK9zM4Oyq59hTHGRR+4A96JnLhvPczdKebgSiMStnrok8M0nUqeEKW//BaQfbDioBVAqrIBBbhu4r80r71jzWbTwuPp53FGrdZObSY3RvBCRF8qdsBHKVj47WrwuomSffNqXyQz4MN+4C4TCcvlwZ4ORuwZSWVV3uphykIkVV/BiibpVVkrQ3D7Qkql35sNZomQIqc4zxdu/nQlqwwy7fxDPzlRoG6P6RW
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd22081-ac12-4117-3d92-08d76d6743fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:10:58.4218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRe7P/syaoUZrIxP5H0X9E4mZbkXA64HSbNkuAoWbVEAwF9LPSVIhWdJ2W+fvSUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3246
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7bQbo4Pw5mEo4N8tqgfUzb8cGPfk7KaHFckEKOHqnU=;
 b=o5J11s/RZ1w3UeZRbWQBU1lMZycrZjH51F7Y9oEOEpcKj8zABByf6ZTox7ZwkmPZwxO3nc968PClEnAPe7RW3Ao29TH9uZ0Ed2nchtu/Jk8KXOnvgfQWq1pIsfHOVd818DTgsQ6UUJwdIY/dJONZzGkNwcVx+dek6z8l2GG7wnc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120031058.lEG_m99lylO9CsXP_yhN8rTR2v-6lIdPS8_iPY7Az2c@z>

DQoNCkJSLA0KQWFyb24gTGl1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgTm92ZW1iZXIgMjAsIDIwMTkgNzo1MiBBTQ0KPiBUbzogTGl1LCBBYXJvbiA8QWFyb24uTGl1
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFJheQ0KPiA8UmF5
Lkh1YW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNV0gZHJtL2FtZGdwdTogZW5hYmxlIFRNWiBi
aXQgaW4gRlJBTUVfQ09OVFJPTA0KPiBmb3IgZ2Z4MTANCj4gDQo+IE9uIDIwMTktMTEtMTggMTI6
MTggYS5tLiwgQWFyb24gTGl1IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggZW5hYmxlcyBUTVogYml0
IGluIEZSQU1FX0NPTlRST0wgZm9yIGdmeDEwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWFy
b24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMNCj4gPiBpbmRleCBkNmUxMWVlLi44ZGNlMDY3IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gPiBAQCAtNDU4OCw3ICs0
NTg4LDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3JpbmdfZW1pdF9jbnR4Y250bChzdHJ1Y3QN
Cj4gYW1kZ3B1X3JpbmcgKnJpbmcsDQo+ID4gIAkJZ2Z4X3YxMF8wX3JpbmdfZW1pdF9jZV9tZXRh
KHJpbmcsDQo+ID4gIAkJCQkgICAgZmxhZ3MgJiBBTURHUFVfSUJfUFJFRU1QVEVEID8gdHJ1ZSA6
DQo+IGZhbHNlKTsNCj4gPg0KPiA+IC0JZ2Z4X3YxMF8wX3JpbmdfZW1pdF90bXoocmluZywgdHJ1
ZSwgZmFsc2UpOw0KPiA+ICsJZ2Z4X3YxMF8wX3JpbmdfZW1pdF90bXoocmluZywgdHJ1ZSwgdHJ1
c3RlZCk7DQo+ID4NCj4gDQo+IERvIHlvdSBtZWFuIGhlcmUgInRydWUiICh0aGUgb3Bwb3NpdGUg
b2YgImZhbHNlIikgYXMgb3Bwb3NlZCB0byAidHJ1c3RlZCI/DQo+IA0KSGVyZSBuZWVkIHRvIGNv
bnNpZGVyIGJvdGggbm9uLVRNWiBhbmQgVE1aLiBUcnVzdGVkIHZhbHVlIGlzIGRlY2lkZWQgYnkg
Y3MuaW4uZmxhZ3MgaW4NCmFtZGdwdV9jc19zdWJtaXQqIGZyb20gbGliZHJtLg0KDQo+IFJlZ2Fy
ZHMsDQo+IEx1YmVuDQo+IA0KPiA+ICAJZHcyIHw9IDB4ODAwMDAwMDA7IC8qIHNldCBsb2FkX2Vu
YWJsZSBvdGhlcndpc2UgdGhpcyBwYWNrYWdlIGlzIGp1c3QNCj4gTk9QcyAqLw0KPiA+ICAJaWYg
KGZsYWdzICYgQU1ER1BVX0hBVkVfQ1RYX1NXSVRDSCkgew0KPiA+DQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
