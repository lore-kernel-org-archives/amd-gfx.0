Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B79DC5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 07:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C4B20650
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 07:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C4B20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C6E6E194;
	Wed,  6 Nov 2019 07:51:53 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820082.outbound.protection.outlook.com [40.107.82.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA846E197
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 07:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjqcuFnpqOxAhtJrNnQHKM0Gh9nw0sPPLWtCnZNYIU74TjtWsIOsQI3O8SvOO+/vgAG2f9OGmEobjxPnFitgYTuSK598J3I2nI2GBXiEbY7ohHjV7LaruZHjR6a2qAmsXApSkuH6z+BrxbbZLw6jzIEieufe8I3aOQSyl+AwGtVhwQRdC8oYFPbJQ3G6EsFRLHy/UH/KzAKC9KiwVK/7mye7EllTg4G97tQK7Hl30oBizCSMxe7/mVF6QROOLiptjypGyIs2JuWNjQJ5SyYMe3I/1H/szq0m/+SQJGYuz+LirJLZHYRbJySwvbS785Le2PkCK0Fltbtly2GM6p/vhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tue03YiCoQlg178qqzDvhzN2TE/atx5OGfTl1/NLRMQ=;
 b=SGlu8ImHM6Fiop4HT+BtpLXvZbmM1VouGyAn9EVwjuRwhLb5LUuiCvxH3kWaIODO2uUnJ4OVdkKGoZdwUwyjKCf4PziRhiyHTa7mW/Lv9RwuEQNifCZoQBOQBxL97KZaSXPTX2HcfB7EWklKHClG3aeQ/PZs00tIH30LR+zakbCH10w92PhxA3lVc7sr1Q86n0WG3HcSHP4OBomu2195Mr0bdSOfXJfMCq2jZRuJDkDqx0oN5Pvc5KVi3gadtBlNU7bHDV3wENP2P6pxNE0ZhWfr7KW3qXPlSfaWc0M0EHkOQWfFCOGAGre+unPI5084vV/qB3EydCATdK5a2Wkbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) by
 MN2PR12MB4078.namprd12.prod.outlook.com (52.135.51.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 07:51:50 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::94fa:9f2f:f308:5c20]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::94fa:9f2f:f308:5c20%5]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 07:51:50 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix deadlock on setting
 power_dpm_force_performance_level
Thread-Topic: [PATCH] drm/amd/powerplay: fix deadlock on setting
 power_dpm_force_performance_level
Thread-Index: AQHVlG9vOwTE4toRzkyDWNP6u9w9wqd9xSyg
Date: Wed, 6 Nov 2019 07:51:49 +0000
Message-ID:
 <MN2PR12MB3775604BF829ED0FC0A22362FE790@MN2PR12MB3775.namprd12.prod.outlook.com>
References: <20191106065700.6525-1-evan.quan@amd.com>
In-Reply-To: <20191106065700.6525-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82e4af04-1449-443c-5956-08d7628e2e8f
x-ms-traffictypediagnostic: MN2PR12MB4078:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4078B2CB8CE8107293BF3D13FE790@MN2PR12MB4078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(13464003)(11346002)(316002)(476003)(110136005)(33656002)(446003)(7696005)(486006)(305945005)(9686003)(2906002)(6246003)(8936002)(4326008)(71200400001)(6436002)(229853002)(186003)(71190400001)(86362001)(26005)(6306002)(102836004)(66066001)(99286004)(2501003)(53546011)(76176011)(256004)(14444005)(6506007)(52536014)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(25786009)(76116006)(6116002)(3846002)(478600001)(966005)(74316002)(81166006)(81156014)(8676002)(55016002)(7736002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4078;
 H:MN2PR12MB3775.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kf9EwGostDecXdfiB/I+Tb6PD/ijMyWQAGvnDBa+kD/pr1C6Fmt3NycmxaKuFlhBz4jzEv9QdMriZsxAu/HlXzdOwb6CriNbbS3qFmtVuMW4oLPAdSJC+U1A9L13kcWTCkSiQclbiQthVcCIuEuPZb7xpsYAOFDGqClmKIALUXy5LnjR7dAFy5FE5LL6zdtwEisHI5DO6LhtxejMFHrVU6P2b1sBsZQp0JOYHr/SHCOFPcAD5bToIIdbvFot1pqAAGsQlKVvmK8eCJHzgqlC+A/+96TCxeZvaNQjebvwJ7oyJPQMzKlMRS4fz8FETK4MaDGcKuz7bO4WqVYHF4d2KG8GQTgLi2n4yriw46Y6/3C5LW0mmYAkYuq67dxLyCVkT93S7gwP9rR+glaLB+2lS6Ze5//eUadEKi+U/93Of18eJGr+mGlUWqCT4VkOEa/kTce1gMU7IBO1eMpAtrTxv2Lwky4dy+gWwdYaL7ELMxE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e4af04-1449-443c-5956-08d7628e2e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 07:51:50.0440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrMaYUUI2t4ZzpNX0nKq20znRiQNwOLaTFwgTTyoEfbM8XBjYTY8C4zItQLSEerc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tue03YiCoQlg178qqzDvhzN2TE/atx5OGfTl1/NLRMQ=;
 b=T+irCR4slpccNXE8SvkQo2K3HCQFjOD2y7nS4+XL570ENmfLjNkGBQVlv7iwAfy/j58wtoCsLdICWN+ei1/po3hZ0jfofLLO4Lmtkcbm0iq7+LLgyiT5jL+L55dTeefG5yZ4qVKfZyiiijgsHr1odmgX4x2lAJ/ik+x2Qwmj2+Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106075149.aaE9nlF9pRTEhcqTbEH_poaPNvT3JTbxyB16KKYCwH0@z>

DQoNClJldmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIFF1YW4sIEV2YW4NClNlbnQ6IFdlZG5lc2Rh
eSwgTm92ZW1iZXIgNiwgMjAxOSAyOjU3IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCkNjOiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZC9wb3dlcnBsYXk6IGZpeCBkZWFkbG9jayBvbiBzZXR0aW5nIHBvd2VyX2RwbV9m
b3JjZV9wZXJmb3JtYW5jZV9sZXZlbA0KDQpzbXVfZW5hYmxlX3VtZF9wc3RhdGUoKSB3aWxsIHRy
eSB0byBnZXQgdGhlIHNtdS0+bXV0ZXggd2hpY2ggd2FzIGFscmVhZHkgaG9sZCBieSBpdHMgcGFy
ZW50IEFQSSBzbXVfZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwoKSBvbiB0aGUgY2FsbCBwYXRoLg0K
VGh1cyBkZWFkbG9jayBoYXBwZW5zLg0KDQpDaGFuZ2UtSWQ6IEljNGQzYzdkMDZlYjQ3ZWFiMmVh
NDJiOThmMzk5Y2Q5NWFiMzIwZjBjDQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVh
bkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jIHwgMTkgKysrKysrKysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jDQppbmRleCBmYWNjMTljYWU3ZTUuLmMyMWZlN2FjNWRmOCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQpAQCAtMzgzLDE0ICszODMs
MjUgQEAgYm9vbCBzbXVfY2xrX2RwbV9pc19lbmFibGVkKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LCBlbnVtIHNtdV9jbGtfdHlwZSBjbGtfdHlwZSkNCiAJcmV0dXJuIHRydWU7DQogfQ0KIA0KLQ0K
Ky8qKg0KKyAqIHNtdV9kcG1fc2V0X3Bvd2VyX2dhdGUgLSBwb3dlciBnYXRlL3VuZ2F0ZSB0aGUg
c3BlY2lmaWMgSVAgYmxvY2sNCisgKg0KKyAqIEBzbXU6ICAgICAgICBzbXVfY29udGV4dCBwb2lu
dGVyDQorICogQGJsb2NrX3R5cGU6IHRoZSBJUCBibG9jayB0byBwb3dlciBnYXRlL3VuZ2F0ZQ0K
KyAqIEBnYXRlOiAgICAgICB0byBwb3dlciBnYXRlIGlmIHRydWUsIHVuZ2F0ZSBvdGhlcndpc2UN
CisgKg0KKyAqIFRoaXMgQVBJIHVzZXMgbm8gc211LT5tdXRleCBsb2NrIHByb3RlY3Rpb24gZHVl
IHRvOg0KKyAqIDEuIEl0IGlzIGVpdGhlciBjYWxsZWQgYnkgb3RoZXIgSVAgYmxvY2soZ2Z4L3Nk
bWEvdmNuL3V2ZC92Y2UpLg0KKyAqICAgIFRoaXMgaXMgZ3VhcmRlZCB0byBiZSByYWNlIGNvbmRp
dGlvbiBmcmVlIGJ5IHRoZSBjYWxsZXIuDQorICogMi4gT3IgZ2V0IGNhbGxlZCBvbiB1c2VyIHNl
dHRpbmcgcmVxdWVzdCBvZiBwb3dlcl9kcG1fZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwuDQorICog
ICAgVW5kZXIgdGhpcyBjYXNlLCB0aGUgc211LT5tdXRleCBsb2NrIHByb3RlY3Rpb24gaXMgYWxy
ZWFkeSBlbmZvcmNlZCBvbg0KKyAqICAgIHRoZSBwYXJlbnQgQVBJIHNtdV9mb3JjZV9wZXJmb3Jt
YW5jZV9sZXZlbCBvZiB0aGUgY2FsbCBwYXRoLg0KKyAqLw0KIGludCBzbXVfZHBtX3NldF9wb3dl
cl9nYXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCB1aW50MzJfdCBibG9ja190eXBlLA0KIAkJ
CSAgIGJvb2wgZ2F0ZSkNCiB7DQogCWludCByZXQgPSAwOw0KIA0KLQltdXRleF9sb2NrKCZzbXUt
Pm11dGV4KTsNCi0NCiAJc3dpdGNoIChibG9ja190eXBlKSB7DQogCWNhc2UgQU1EX0lQX0JMT0NL
X1RZUEVfVVZEOg0KIAkJcmV0ID0gc211X2RwbV9zZXRfdXZkX2VuYWJsZShzbXUsIGdhdGUpOyBA
QCAtNDA4LDggKzQxOSw2IEBAIGludCBzbXVfZHBtX3NldF9wb3dlcl9nYXRlKHN0cnVjdCBzbXVf
Y29udGV4dCAqc211LCB1aW50MzJfdCBibG9ja190eXBlLA0KIAkJYnJlYWs7DQogCX0NCiANCi0J
bXV0ZXhfdW5sb2NrKCZzbXUtPm11dGV4KTsNCi0NCiAJcmV0dXJuIHJldDsNCiB9DQogDQotLQ0K
Mi4yMy4wDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
