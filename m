Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222DCCA9ED3
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 03:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC84420659
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 03:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC84420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864706E8E5;
	Tue,  5 Nov 2019 03:28:10 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740040.outbound.protection.outlook.com [40.107.74.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648406E8E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 03:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C49mrHBCVs5VxhuDIfayCn2hjqsaHWRWAk5OVhgr2IRkuGQQHsoD3fcV2gi17QDVitPAqDVWOJkA/r+MAvo3fBkQLxehJ9C/ZVESS5+0ChS2XBcqkBm3+/g+pTap4x3VgnrW+EBaxe3YIQsV+noj/Q8vvNtLhSwrpk3mYYeBMnKtayPgDkljiSrlduTIkGZ9sTXkjf0YCFiCdtolYQrLkmp4cp90Tt1MC+O9FIFKJaxzxxUcWPRe093KFC3ZW9TwjNz7n4Mxlz/JB5Z/8a4oeoStUDv9gNdjvrbaGNL4AjP6KLZ73Pk2nzMuow211w85PT0v0Aemw9dFX4Pc6cJNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57JZ6wMnqa9t+VlMsSQjTWMo5ni0NUo9aV0vHjxjDzI=;
 b=hPgNYoqO9Jt6MgfAS3aUOrduDgrpDZJXvOznLXVv42u8g3Hf5Mx45qh59UcP03QC8j6sIOHAW50SOQE7iHzayVN0hne0u5l0w8lOcXregk2kWj9k15KcY8Or/biSz6XNg7Cc3mj/l7/n12Te75k3YG8XsN8PSyMTkI6CFN1wkQjFF9pA8Vg7AQsuKVuxP96E1d90sTQKpSSuNyxf72vWINveSVh3GUA7m8wOsLqFaz4ETJRpLyrpCAtdw1SYtrhy0nO2Fobu1dWQwZwzIEMy8A1/8a4UfubeMlEsU5v8vsJAwvX6mSQcsWZ8lfgYmy/f5D4IMH+9y73HIWzeSaDjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2603.namprd12.prod.outlook.com (20.176.116.84) by
 DM6PR12MB3211.namprd12.prod.outlook.com (20.179.105.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 03:28:07 +0000
Received: from DM6PR12MB2603.namprd12.prod.outlook.com
 ([fe80::7d1b:b86b:1b2f:9893]) by DM6PR12MB2603.namprd12.prod.outlook.com
 ([fe80::7d1b:b86b:1b2f:9893%7]) with mapi id 15.20.2387.027; Tue, 5 Nov 2019
 03:28:07 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, Clements John <Clements.John@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disallow direct upload save restore list from
 gfx driver
Thread-Topic: [PATCH] drm/amdgpu: disallow direct upload save restore list
 from gfx driver
Thread-Index: AQHVkvkftadqxiIw4U+4xNZyuolLG6d768ng
Date: Tue, 5 Nov 2019 03:28:06 +0000
Message-ID:
 <DM6PR12MB2603C84C4624114BC6EF62AD917E0@DM6PR12MB2603.namprd12.prod.outlook.com>
References: <1572862661-3254-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1572862661-3254-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fb4df48-295d-4e42-8211-08d761a02cc5
x-ms-traffictypediagnostic: DM6PR12MB3211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB321198A292784CFA309976C1917E0@DM6PR12MB3211.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(15404003)(199004)(189003)(13464003)(99286004)(7736002)(186003)(102836004)(26005)(66066001)(25786009)(71200400001)(14444005)(256004)(86362001)(8676002)(81166006)(81156014)(52536014)(14454004)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(478600001)(476003)(305945005)(76116006)(71190400001)(8936002)(446003)(76176011)(11346002)(2906002)(486006)(6636002)(9686003)(2501003)(6246003)(55016002)(7696005)(6436002)(3846002)(33656002)(110136005)(316002)(74316002)(6506007)(53546011)(6116002)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3211;
 H:DM6PR12MB2603.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5yWW8kibEGVqYvDje88Tb1vntyPLF9gRGaU42W5EGB5fT0G75FaDeZY8par+9rQvp/GRSBbBgllJ8JmBumgRyvI2TWg+ihDzsfcfckTrvYnYCIRfSQv3OAA0v/WA2TprldH0v/SeZ3VRRLAd1vrn5ZihqFI7BGxXcTp2BtUZ52VzqfHvAB10UaDDeZWudZoK4wAwNflEQ9i2D4ItOf9d5nkZ2PRnmc6oecildSItn1pZBY3p+j36VamAArFTOxAjt49RcV8HZnBIdFI8gh7mg0MaS+vkmoHkh/HMvlnuBeqq11t/U3iuyDLEM9Kiklbr2a6PgloUfzzrigjjO+Gue4s3DnZr3b1dkZZCXCiBsyleUn7JGtY9ZrWtRkNABNGDtmj85kc9rN6Mzj5Qm0Y7CWBpEAviEyCzVx71MHyxST9Q5S0MYwSvBwE7aISjTohY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb4df48-295d-4e42-8211-08d761a02cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 03:28:06.3911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRxRD02zYVB6h5axVEO7SYACTDRkycRSfGvZm6WV2KgYbLdrBU3id/tCVBO8Q15V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57JZ6wMnqa9t+VlMsSQjTWMo5ni0NUo9aV0vHjxjDzI=;
 b=HFJyQhARbT90liD0j9SN4/I9NrXCowweoFZmnSojrlMbFHazWtIv/9br/3LvqBy1IMOP//LM0A7OqgjkkfyjPleid07XYctOPjwEqaeeIUVSuj1auXscVjLI8Hbn0n1WFs/GwwrH8go4IiH66/hRUUdyKk4wf7oHUG5KMNsBtkw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Candice.Li@amd.com; 
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
Message-ID: <20191105032806.n4iAkgAldlQNs-nv7pB0EOhNxTKlKiQbH7FVsMnC7Do@z>

UmV2aWV3ZWQtYnk6IENhbmRpY2UgTGkgPENhbmRpY2UuTGlAYW1kLmNvbT4KCgoKVGhhbmtzLApD
YW5kaWNlIExpCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9tOiBaaGFuZywgSGF3a2lu
ZyAKU2VudDogTW9uZGF5LCBOb3ZlbWJlciAwNCwgMjAxOSA2OjE4IFBNClRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgQ2xlbWVudHMgSm9obiA8Q2xlbWVudHMuSm9obkBhbWQuY29t
PjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT4KQ2M6IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZGlzYWxs
b3cgZGlyZWN0IHVwbG9hZCBzYXZlIHJlc3RvcmUgbGlzdCBmcm9tIGdmeCBkcml2ZXIKCkRpcmVj
dCB1cGxvYWRpbmcgc2F2ZS9yZXN0b3JlIGxpc3QgdmlhIG1taW8gcmVnaXN0ZXIgd3JpdGVzIGJy
ZWFrcyB0aGUgc2VjdXJpdHkgcG9saWN5LiBJbnN0ZWFkLCB0aGUgZHJpdmVyIHNob3VsZCBwYXNz
IHMmciBsaXN0IHRvIHBzcC4KCkZvciBhbGwgdGhlIEFTSUNzIHRoYXQgdXNlIHJsYyB2Ml8xIGhl
YWRlcnMsIHRoZSBkcml2ZXIgYWN0dWFsbHkgdXBsb2FkIHMmciBsaXN0IHR3aWNlLCBpbiBub24t
cHNwIHVjb2RlIGZyb250IGRvb3IgbG9hZGluZyBwaGFzZSBhbmQgZ2Z4IHBnIGluaXRpYWxpemF0
aW9uIHBoYXNlLgpUaGUgbGF0dGVyIGlzIG5vdCBhbGxvd2VkLgoKVkcxMiBpcyB0aGUgb25seSBl
eGNlcHRpb24gd2hlcmUgdGhlIGRyaXZlciBzdGlsbCBrZWVwcyBsZWdhY3kgYXBwcm9hY2ggZm9y
IFMmUiBsaXN0IHVwbG9hZGluZy4gSW4gdGhlb3J5LCB0aGlzIGNhbiBiZSBlbGltbmF0ZWQgaWYg
d2UgaGF2ZSB2YWxpZCBzcmNudGwgdWNvZGUgZm9yIFZHMTIuCgpDaGFuZ2UtSWQ6IEk4Y2M4ZTAx
MjZmNzQ2YWFlNDNiOTExNGUwNWJjMTExZWU3YjIzNTMxClNpZ25lZC1vZmYtYnk6IEhhd2tpbmcg
WmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCAw
NTI1ZmM2Li5kMTRjNGQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAg
LTI3MjUsNyArMjcyNSw4IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX2luaXRfcGcoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJICogQW5kIGl0J3MgbmVlZGVkIGJ5IGdmeG9mZiBmZWF0dXJl
LgogCSAqLwogCWlmIChhZGV2LT5nZngucmxjLmlzX3JsY192Ml8xKSB7Ci0JCWdmeF92OV8xX2lu
aXRfcmxjX3NhdmVfcmVzdG9yZV9saXN0KGFkZXYpOworCQlpZiAoYWRldi0+YXNpY190eXBlID09
IENISVBfVkVHQTEyKQorCQkJZ2Z4X3Y5XzFfaW5pdF9ybGNfc2F2ZV9yZXN0b3JlX2xpc3QoYWRl
dik7CiAJCWdmeF92OV8wX2VuYWJsZV9zYXZlX3Jlc3RvcmVfbWFjaGluZShhZGV2KTsKIAl9CiAK
LS0KMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
