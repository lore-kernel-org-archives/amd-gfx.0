Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04581C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA9F2051A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA9F2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B976E5E7;
	Thu, 28 Nov 2019 02:21:15 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800052.outbound.protection.outlook.com [40.107.80.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB4B6E5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 02:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWoNNNpf0mBRV43AB4s1XN7sRuNSHRX5QjfvdPfwoRLEOnczYbUrokv+EgvfJqUSh6M3ak9tiW8qFmCsVOSTqd5CTLkWIhKM8j0cvU2i7fCJOv58ZNjN+WXQigG8xNTSMWQx/ua/1/zEtH8G2s3rSgRCy7swm+EQS3donyxLxaGPLUmQYXvQDTMnE+Mp+J4JMyIrC1CsUOP8UfvvjMLA9Vh+Y0MeOjLu0DD+fG5R3pau8Z9VxR5IuEa5q7W2aRcP0WO7MaHmdcCklFUTRoKtz81Hf1Z0Ni7OX9lnNx7SofnYPwFI36zE142tYiH8BtFzB1ddplA+6+Crk4F1+EDwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQxhgU5fKX8aGYawl9iOGX9ue5rurGTTwHZ0NYIPKFk=;
 b=Sog61zx8zj4AqYV1PEXTfZtR2D38ACZU2tc4gUkuc4StFJU0WSBk4oHbZWMlj2VGUKyJiOexNi2rXg9I9YlexIE6HV3BQiJfbE+Q3oAlc3YQsTx8LvcCZC7LEc8VE3TAPPnJmDZflycnsZYDfr5obX/bhLttklIrQju15EjxKMSj2F26LSBLMHRrEDXMOGFO0b+1SM7LSBHM1HnCJOzjVr0J5Zk++0JnbsYZ/Cp7AI6X/axwcsyIKF44ZcUgWUzLGmoMw8xxkii/RRHCH7y8ogd4vAnOK2KaUecJ58u8G33G+xYaPqCwIihYHl7LZjCLH16ufK/ZZs1dyetSBn5dFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 02:21:12 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 02:21:12 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Topic: [PATCH 1/5] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Index: AQHVpE+3AgY3madu2kO2hxUaDxMsjKef3E8Q
Date: Thu, 28 Nov 2019 02:21:11 +0000
Message-ID:
 <MN2PR12MB393348CB640C8EDA130116E884470@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee699e61-6988-4bcb-525e-08d773a9a338
x-ms-traffictypediagnostic: MN2PR12MB4256:
x-microsoft-antispam-prvs: <MN2PR12MB4256BB44F2787344DAD7DA2884470@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(13464003)(5640700003)(6506007)(11346002)(229853002)(6436002)(66066001)(53546011)(9686003)(5660300002)(55016002)(6246003)(99286004)(446003)(316002)(86362001)(26005)(52536014)(2501003)(186003)(14454004)(33656002)(2351001)(2906002)(256004)(76116006)(3846002)(6116002)(478600001)(71200400001)(71190400001)(25786009)(66946007)(6916009)(64756008)(66476007)(66556008)(66446008)(81166006)(8936002)(81156014)(8676002)(102836004)(74316002)(7696005)(76176011)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ppafE3MrvzUR8X73U+LM0KRZFV3Ckpc6/dXLz8yJz/3uXoyEqvcibff4Pm1QL+qWqxQQFzC96Azv/deRLo1vAoZwWtyo+nWJrzALgYe3SHCoWHGiWfEw3gmyEZQhabKZOKDNm5TP6c4oSDbOE1J/WfMXfzId2/x8jcxCXIXBSgx6QyShFkacHtLhsqt5oQGUxwSjwxVJvYMJOMI64iDPdyoqbzyPKQlca1I0On0SOfyt492VyFEDbppmZO4nu1MHd+MKw7vg1/Pf/4wmbE/+ZraH3QiSJ+3QBwZMD5zdS2KI46LamNOsQ79xuT6+XK/8YYsUI2O/aVo89qTMjjga2r1MjVe5ldj6tBt/w0KsrlMSIMlzXLplr959U2lGTqQw6+VAaCETfrtlYQO3f7vUZcUQXMr1g9SXmnHNQ8mCfNIYOnyVmF4PPV1XOrdSIus
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee699e61-6988-4bcb-525e-08d773a9a338
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 02:21:11.9090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5shdHygNwcaCyNZdBuo7PbJgDw8UyR1GtaIj9S5cj7+CB00YC4fnrXSPJzPnugD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQxhgU5fKX8aGYawl9iOGX9ue5rurGTTwHZ0NYIPKFk=;
 b=MjxZ3eySXeH4Dzt9nwyx7AlMKMKSH7ySu9NVDoZ7E8h891xIdSGlXmXqzHL++t4ujM2DIh6CcvRraCKKuIzSTS/9yCgUkg6vI5Np5V2KixvGnTgRNu2jKdiORnbUPaLWEOQo9wMh/kJ//EzpOMYLtK/LyMzf4AdoKE29IGWjmNk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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
Message-ID: <20191128022111.ucGEFmP8kvKYJ7l8iYXy4flBJD4KWrocDq8egZHvUNg@z>

UGluZyAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTW9uayBMaXV8R1BV
IFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRAoKCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZy
b206IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPiAKU2VudDogVHVlc2RheSwgTm92ZW1iZXIg
MjYsIDIwMTkgNzo1MCBQTQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IExp
dSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4KU3ViamVjdDogW1BBVENIIDEvNV0gZHJtL2FtZGdw
dTogZml4IEdGWDEwIG1pc3NpbmcgQ1NJQiBzZXQKCnN0aWxsIG5lZWQgdG8gaW5pdCBjc2IgZXZl
biBmb3IgU1JJT1YKClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgOCArKysrKy0tLQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDRkNmRmMzUuLjg3OWMwYTEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0xOTI2LDE0ICsxOTI2LDE2IEBA
IHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpICB7CiAJaW50IHI7CiAKLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQotCQlyZXR1cm4g
MDsKLQogCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQ
KSB7CiAJCXIgPSBnZnhfdjEwXzBfd2FpdF9mb3JfcmxjX2F1dG9sb2FkX2NvbXBsZXRlKGFkZXYp
OwogCQlpZiAocikKIAkJCXJldHVybiByOwogCisJCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikp
IHsKKwkJCWdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsKKwkJCXJldHVybiAwOworCQl9CisKIAkJ
ciA9IGdmeF92MTBfMF9pbml0X3BnKGFkZXYpOwogCQlpZiAocikKIAkJCXJldHVybiByOwotLQoy
LjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
