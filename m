Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D0DCA9ECF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2E6217F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2E6217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CEF6E9AE;
	Tue,  5 Nov 2019 10:18:20 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800074.outbound.protection.outlook.com [40.107.80.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AB96E9AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 10:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHliaKHGeU9V1yynNejnnMB0cMbih2G32wPqMH7g8KxXUcAFKwtKoy44i7XHkb9Ah7GLaejuE+9iIijhnJOyHZoylHBrHO5LSr5qZHyKtJzNepnHDDoGridwJ30KGQdkNJy0xxfYPcP2QClbqo+B3+qUVII+py3uqN7F0Fk0rGeFOFLcYS79wKXaxLzQNuk5RfBd0Xy0WhjL89shSX/gzZzoM1OtosBvNNeiK+EZ2WZs+HYHAbPSgnPk42jDgMhos0EBHxdKchI/nUjmj9sYTzY4k1+ZiDjM307Mzex7v98yiR/phup87d3jl7gG3k5rlBAGimhBf2Ag4i4FQBAHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dO6hCiWm+Le/GCsuBKIWlT3ixpOTAVd5B5IhTrz6X8=;
 b=mybqsniNqGqGKlOw7ntBzVehpYoC1epYB0IiVUCDH0SO0z7ZqOZjc6T1JwhE/WHU8UDARhGR8kyAdfOITM9K85gHcBKORVwCgdBsdcWz5GSi2V8ispqzDRlCabGbPWVIsXgbjuMI0/NkiBLjvpUSCgJX2pvJ5iASzvP4eChh+djD8PzTpTWcx9UEHM19qeL5OeqpneAYsISbX6jity6WetW49k3HpmFrMRCvsRzlYHpfYhCVVwVj08kdq2Np5Npc/mCdBwBspdyaOfUCMcYc8qVtJabkpqyLkljSdeDwYkNP/e6XpDK/zktUcUCM2gjcX9KQFlN2qkRWK6euQe748Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3680.namprd12.prod.outlook.com (10.255.238.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 10:18:16 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 10:18:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: register gpu instance before fan boost feature
 enablment
Thread-Topic: [PATCH] drm/amdgpu: register gpu instance before fan boost
 feature enablment
Thread-Index: AQHVk8JWWrJMFrql3UuN7eSaSxL7Hw==
Date: Tue, 5 Nov 2019 10:18:15 +0000
Message-ID: <20191105101755.16511-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:202::26) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80f220b2-da73-4594-2abf-08d761d978a9
x-ms-traffictypediagnostic: MN2PR12MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36806DC908C9ECEA38189027E47E0@MN2PR12MB3680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(186003)(66556008)(25786009)(66446008)(14454004)(8676002)(50226002)(81156014)(2351001)(2501003)(1076003)(476003)(14444005)(5660300002)(256004)(66066001)(6116002)(3846002)(8936002)(102836004)(316002)(6486002)(2616005)(86362001)(54906003)(6512007)(66476007)(6916009)(64756008)(52116002)(81166006)(99286004)(7736002)(26005)(5640700003)(4326008)(2906002)(71190400001)(71200400001)(6506007)(486006)(305945005)(386003)(478600001)(6436002)(36756003)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3680;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqIlf651WkkhykiuPsZxwgmMpl0JvIBw00XGHMAFHj00Kod/uuW7cqxUcJxtuYcxynX7JJqrUBTDie4HjClGaI+HA/xR6E9sp0iOpEqLyzy8tvNKeZ9bHLN0rkXjih+bnVKQKnFSy4SgRvFuOe0GOnUB+s7594BE+061HthnYQgl1Y+pSRliu6tEG4nYUo7MmDA2clsMWb5xZgTQDjuUMkEAimMdO4SQrxhTI4/qbj47Zom44m7G3pOiDxDf8dSD1aSKGJZkojvQkFmRuXJIRxLik9GrF6xm/VTzP7bKA++3amtkrkxB/kDuQQVPWL3FTry5lzjcogWZewtuGlBNu/DBy6XbigHZ1m/wybcCz+SI9vE6Z0geAtxTXHabmLnRvqbZX7HW2mqIp7w7CixR5GZSNLFTlLDvvG7YHSp9UWgIRkOcZi3bzJj/XEoJZhXq
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f220b2-da73-4594-2abf-08d761d978a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 10:18:15.9262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/lWzzUiooBDZFpSOwFNGm0R3AGUd3v7HyXkgxjC2jSa1SJL9v8vFoEw09x0oTjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dO6hCiWm+Le/GCsuBKIWlT3ixpOTAVd5B5IhTrz6X8=;
 b=E3LEqhI3hRoWO+hbPV4SgwQq8gsQSv6ZvcJ/dstYHIrSw6PwBOA4zz2Ufo89cgmwlGH2lSXTmUu88JD/2g5Fezm1KW2W65T/U18an7J1h2AHgOcLWVuvme6Wyeso2QMxrZrW9TGbC5tFIL6bC7dsI08Vrb/uku9ABxbMq8mL898=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105101815.ZdOz6G85Hf1LYzMmtYd7ITt2i63PtDb6UfSTLYcBsxU@z>

T3RoZXJ3aXNlLCB0aGUgZmVhdHVyZSBlbmFibGVtZW50IHdpbGwgYmUgc2tpcHBlZCBkdWUgdG8g
d3JvbmcgY291bnQuCkNhdXNlZCBieSAiZHJtL2FtZGdwdTogZml4IGEgcmFjZSBpbiBHUFUgcmVz
ZXQgd2l0aCBJQiB0ZXN0ICh2MikiLgoKQ2hhbmdlLUlkOiBJZDU3NjA5MGQ3Y2U3NjQ1YTVjOThh
YzE2MGUwYWY3MzBhNTE1MjZiMApTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8
IDcgKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jICAgIHwg
MSAtCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCAyZDcyZDIwNmNl
YWQuLjAyY2NhZGJmZDg5ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwpAQCAtMzA4Nyw2ICszMDg3LDEzIEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQlEUk1fSU5GTygiYW1kZ3B1OiBhY2NlbGVyYXRp
b24gZGlzYWJsZWQsIHNraXBwaW5nIGJlbmNobWFya3NcbiIpOwogCX0KIAorCS8qCisJICogUmVn
aXN0ZXIgZ3B1IGluc3RhbmNlIGJlZm9yZSBhbWRncHVfZGV2aWNlX2VuYWJsZV9tZ3B1X2Zhbl9i
b29zdC4KKwkgKiBPdGhlcndpc2UgdGhlIG1ncHUgZmFuIGJvb3N0IGZlYXR1cmUgd2lsbCBiZSBz
a2lwcGVkIGR1ZSB0byB0aGUKKwkgKiBncHUgaW5zdGFuY2UgaXMgY291bnRlZCBsZXNzLgorCSAq
LworCWFtZGdwdV9yZWdpc3Rlcl9ncHVfaW5zdGFuY2UoYWRldik7CisKIAkvKiBlbmFibGUgY2xv
Y2tnYXRpbmcsIGV0Yy4gYWZ0ZXIgaWIgdGVzdHMsIGV0Yy4gc2luY2Ugc29tZSBibG9ja3MgcmVx
dWlyZQogCSAqIGV4cGxpY2l0IGdhdGluZyByYXRoZXIgdGhhbiBoYW5kbGluZyBpdCBhdXRvbWF0
aWNhbGx5LgogCSAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCmluZGV4
IDY4OGJiNGFiY2NmNS4uY2JkNGE1NzA5NDcwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfa21zLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ttcy5jCkBAIC0yMDQsNyArMjA0LDYgQEAgaW50IGFtZGdwdV9kcml2ZXJfbG9hZF9r
bXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdW5zaWduZWQgbG9uZyBmbGFncykKIAkJcG1fcnVu
dGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2LT5kZXYpOwogCX0KIAotCWFtZGdwdV9yZWdpc3Rlcl9n
cHVfaW5zdGFuY2UoYWRldik7CiBvdXQ6CiAJaWYgKHIpIHsKIAkJLyogYmFsYW5jZSBwbV9ydW50
aW1lX2dldF9zeW5jIGluIGFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcyAqLwotLSAKMi4yMy4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
