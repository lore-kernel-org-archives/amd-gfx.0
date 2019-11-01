Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E744FCA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 15:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F4720650
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 15:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F4720650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CA26F825;
	Fri,  1 Nov 2019 15:30:48 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686E46F825
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 15:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMrKi1r71b4GtUhCvb76KZ1TUKbAR6nEUbzWY3FkXvvEFzrHDjeXbYzjQ+AP4rJDBIzoxTTyJ5qZm3Sul5DrP5OOY2ofh0a3JbjjyvivZhbEA7UVGpPpY8TiYWcmFPZ4tcCcSnmBe+1nSaXREOpPxwGs4KIft+wq+3mnhL7dG75bXQZIEERhsJiCXA8oFgpDwG0gqlSGOewFM+SD95dqYiyufPH39znKlbKhfehJngo/Nr8ttbclGhGYL5A73oSIoU6CQbaBS9Nl2jGYGrmYP9OSRUnCpWXVHpJdkEfgeg7I0K/+wuf9CmNXOu7C6vlAZYNH64NDXFh+I+b6JSxf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7dUdbK/XA4hOt8/UrVZZBuIXvhCSyv7zgULzaYENpg=;
 b=S51hL9xA9HtPDYh73Lmw0jyqHSIq819sUKA+/NO22Pzl7I8BgnlCTjZGktSg/Y/tJRbOm/BLvmLH7364E3Kd+tbks6xvPliSgbK0uQlHn7qb9t0S36KmpJPZuEjxQ3jcQWcv9qtw5mqUFWQZdOvC+YXlpV++DTDsKGsJjmN4z7fVr7RPa9P5Qt6VKQ4MZ/LYVTHll6Al1cVTmy89bpd0e/lfIVbL6n0TyPY3bpxYby4LOQvqx8nsbci9hi1kOAEXstt5G7DVKefbQlo/56J6HHyiRmgGWEI2hJBW555Vq37RFnRRio2DESQ7gE2gW/dF2mw3adQEgshxsvKmCA6hcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1131.namprd12.prod.outlook.com (10.168.236.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 1 Nov 2019 15:30:45 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 15:30:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Need to free discovery memory
Thread-Topic: [PATCH] drm/amdgpu: Need to free discovery memory
Thread-Index: AQHVkJPWSTGGyV+j1UeZb3VtRe82z6d2bLAAgAADeyA=
Date: Fri, 1 Nov 2019 15:30:45 +0000
Message-ID:
 <DM5PR12MB14186397FD9D1A95ACA5F6C7FC620@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1572599256-24993-1-git-send-email-Emily.Deng@amd.com>
 <BN8PR12MB36021054CEA4EF2DD94CFEE989620@BN8PR12MB3602.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB36021054CEA4EF2DD94CFEE989620@BN8PR12MB3602.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48bd911e-4aa9-432c-611f-08d75ee076b6
x-ms-traffictypediagnostic: DM5PR12MB1131:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1131BF612C8EF5F2A661243BFC620@DM5PR12MB1131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(13464003)(199004)(189003)(25786009)(66446008)(76176011)(966005)(14454004)(66556008)(2501003)(26005)(33656002)(64756008)(2906002)(81156014)(76116006)(486006)(3846002)(8676002)(186003)(53546011)(81166006)(66476007)(305945005)(6506007)(66946007)(476003)(446003)(7736002)(7696005)(6116002)(102836004)(74316002)(11346002)(6246003)(52536014)(66066001)(9686003)(5660300002)(55016002)(6306002)(256004)(478600001)(8936002)(71190400001)(14444005)(99286004)(71200400001)(316002)(110136005)(86362001)(6436002)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1131;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9v/Z14anBqZvf7lXPobGPK6HHt5+19NN1xVUZVjTjd5HTzYJ3rk7Og8rxGn89uCJ9dzJEU7EMicq3L6oME2gsXzN41JQKSI+MdKlvoyQBAuzi2WkYEajc5Fxp28hd6WsGLhZGkkquG7cArjRlfQGqIVj2CnhRg+i+HV5SxUhPxF7MlFh5RfKNEm7ExhZqgei7RCsCNV00GToQMeOgapc6iMcNNcRsl99mODo3IOjgiwwpwMItlpS6KrEzGslW4L4bhb6r0UoydYaPBegsjjJI1SQWvGFzH7R+YZ9AJhNGXNtgUvD/JpeLMzjCaqp5z370BaAVlPEoOY6D6CcrPFk/shMhfYhoJBfH3wbP314Yu717NOvbFRBc8cz18p+SAHuLVymLAbk3ytCMzfZlFN39J237v1cIsQeeFH2wXatRY7h40MTiFIBU6/og/V1B0o75OSXzTCwWHa8pZy7bNDvCB5ExDTkjkM6ohkd0cdi9Eo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bd911e-4aa9-432c-611f-08d75ee076b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:30:45.2214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wGAjmQKCW8rLnrgc7zRjXGFSNNCxwKR46HJcp5YZk9vujOCVDj8U9APhX03YzL9bxJZ/Z7E3zIUGnX6/mL0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7dUdbK/XA4hOt8/UrVZZBuIXvhCSyv7zgULzaYENpg=;
 b=rWrabSDt5OalJh6km1l1QhOVf8rTeAfmNqHjQ7PMx5+y1I8/LqSAaI6s+EKCOjq8YAEW2AxM1IWz6TDoO7sYdVnvKTdRAP7X+igcUWx3xw2xOYZVfG9rdKylKxx6b/yuRansQ24lIEasY5MGrCw3t+YsQ8M1jACTmGNeCt7GJek=
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
Message-ID: <20191101153045.NLa6B5tEhp_-gGLIAAxwBq_kGndSh7cniZBX-HISRk8@z>

QmVzaWRlcywgdGhlIGJvIGZvciBpcF9kaXNjb3Zlcnkgb25seSBuZWVkIHRvIGJlIGNyZWF0ZWQg
YW5kIHJlc2VydmVkIGZvciBOYXZpMTAgYW5kIG9ud2FyZHMsIGFsdGhvdWdoIGl0IHNob3VsZG4n
dCBiZSBhIGJpZyBpc3N1ZSB0byByZXNlcnZlIDY0SyBtZW1vcnkgaW4gdG9wIHZyYW0uDQoNClJl
Z2FyZHMsDQpIYXdraW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQt
Z2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2Yg
WXVhbiwgWGlhb2ppZQ0KU2VudDogMjAxOeW5tDEx5pyIMeaXpSAyMzoxNA0KVG86IERlbmcsIEVt
aWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogTmVlZCB0byBmcmVlIGRpc2NvdmVyeSBt
ZW1vcnkNCg0KSGkgRW1pbHksDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4NCg0KSSB0aGlu
ayBmcmVlaW5nIERpc2NvdmVyeSBUTVIgYm8gc2hvdWxkIGJlIHB1dCBhdCBhbWRncHVfdHRtX2Zp
bmkoKSBpbnN0ZWFkIG9mIGFtZGdwdV90dG1fbGF0ZV9pbml0KCkgYmVjYXVzZSB1bmxpa2UgVkdB
IHN0b2xlbiBibywgdG91Y2hpbmcgUFNQLXByb3RlY3RlZCBEaXNjb3ZlcnkgVE1SIGJvIHdpbGwg
Y2F1c2UgR1BVIGhhbmcuIFRoZXJlZm9yZSwgaXQgc2hvdWxkIGJlIHJlc2VydmVkIGFjcm9zcyB0
aGUgbGlmZS1jeWNsZSBvZiBhbWRncHUgZHJpdmVyLg0KDQpQbGVhc2Uga2luZGx5IHNlbmQgdjIg
cGF0Y2ggd2l0aCB0aGlzIGNoYW5nZS4NCg0KQlIsDQpYaWFvamllDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IG9uIGJlaGFsZiBvZiBFbWlseSBEZW5nIDxFbWlseS5E
ZW5nQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEsIDIwMTkgNTowNyBQTQ0KVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGVuZywgRW1pbHkNClN1YmplY3Q6
IFtQQVRDSF0gZHJtL2FtZGdwdTogTmVlZCB0byBmcmVlIGRpc2NvdmVyeSBtZW1vcnkNCg0KV2hl
biB1bmxvYWRpbmcgZHJpdmVyLCBuZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeS4NCg0KU2ln
bmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDUgKysrKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y5XzAuYw0KaW5kZXggOWYyYTg5My4uNTBkNmVkMiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMNCkBAIC0xMDkxLDggKzEwOTEsMTEgQEAgc3RhdGljIGludCBn
bWNfdjlfMF9zd19maW5pKHZvaWQgKmhhbmRsZSkNCiAgICAgICAgYW1kZ3B1X2dlbV9mb3JjZV9y
ZWxlYXNlKGFkZXYpOw0KICAgICAgICBhbWRncHVfdm1fbWFuYWdlcl9maW5pKGFkZXYpOw0KDQot
ICAgICAgIGlmIChnbWNfdjlfMF9rZWVwX3N0b2xlbl9tZW1vcnkoYWRldikpDQorICAgICAgIGlm
IChnbWNfdjlfMF9rZWVwX3N0b2xlbl9tZW1vcnkoYWRldikpIHsNCiAgICAgICAgICAgICAgICBh
bWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPnN0b2xlbl92Z2FfbWVtb3J5LCBOVUxMLCAmc3Rv
bGVuX3ZnYV9idWYpOw0KKyAgICAgICAgICAgICAgIC8qIHJldHVybiB0aGUgSVAgRGlzY292ZXJ5
IFRNUiBtZW1vcnkgYmFjayB0byBWUkFNICovDQorICAgICAgICAgICAgICAgYW1kZ3B1X2JvX2Zy
ZWVfa2VybmVsKCZhZGV2LT5kaXNjb3ZlcnlfbWVtb3J5LCBOVUxMLCBOVUxMKTsNCisgICAgICAg
fQ0KDQogICAgICAgIGFtZGdwdV9nYXJ0X3RhYmxlX3ZyYW1fZnJlZShhZGV2KTsNCiAgICAgICAg
YW1kZ3B1X2JvX2ZpbmkoYWRldik7DQotLQ0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
