Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A7CA9EB5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 16:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D26B20842
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 16:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D26B20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47B06E5D6;
	Mon,  4 Nov 2019 16:06:06 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740054.outbound.protection.outlook.com [40.107.74.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB60C6E5D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 16:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz/zXQIM7bPt1HPOuBsrDB272+bSsFgHg2seg8/CKUKO57pPiiIDGQrBzyPfQZXv9G0tsdBh7lsqaLcJB2OmqfywgG3geBzFgj215CNIngVWgQAkCckQAZXjczJ06IebF8yDVrbbm8gvOj99nJv4+EoYrR8e2Mqrq6pwRgXL6jPxClLN9QTKcrxHhi8g/UUsBfxOIiKuvLTsIipwade4Yv+2AlrIzNDn+TmoyVWfhpfjkeASNuRccU3sjkc1igxmEuYGdc0QJMEN56Mxpg6aPxcPvA0ilfUsY7XevoqmSNSL5UhlUJCsc3jDam4Ev1Pr7xbqgfTnvfhJf/zPkJjODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbAKEM7lAw48ET/DNpv7Pb6yLE03UKX2Bhr3/5vwPZM=;
 b=ibVXMCWfDaQAw7tdRsLqbpjV+e8j1d1XNi4qxG6hdVm5aaF28ZDepXj0mzeoDymg3c0HIrMGWNxy59iNuuuM/N7jY/w0V8mpSRT1cs5RIFwz2flLbE3EALlru/eBQA4ko0n8VfAn2DpNetd9JdJ7O9MFHpUFxGCS+EGGVwsPuasCF6MwQINJzk09SlfV9CEco9bFIai3QKbHQPfwip0HVfuJHhWUdxzrcsPu8LrL6Sc5bV+bFgmdhJNXsizkVs/9rT3Z4FfrAqBsKwM+m044bdL0EmmdPlNEBbVvu1rBunc+FrS7GEPanSmUIsoaiOEdSO+8G+zxgle0YirfR84+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3836.namprd12.prod.outlook.com (10.255.173.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 16:06:03 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::4831:3ea2:2d94:66d3]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::4831:3ea2:2d94:66d3%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 16:06:03 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu,
 Hersen" <hersenxs.wu@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>
Subject: [PATCH] drm/amd/display: remove "setting DIG_MODE twice" workaround
Thread-Topic: [PATCH] drm/amd/display: remove "setting DIG_MODE twice"
 workaround
Thread-Index: AQHVkymI1xwlEiK2sE2bB6BNavcbhg==
Date: Mon, 4 Nov 2019 16:06:03 +0000
Message-ID:
 <DM6PR12MB3466E5EF19CE8BBD78AC6BBE9E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52b3e913-10ee-4e36-0364-08d76140e447
x-ms-traffictypediagnostic: DM6PR12MB3836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3836218710036076CD4AF7D39E7F0@DM6PR12MB3836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(316002)(66476007)(86362001)(14454004)(478600001)(7696005)(66556008)(64756008)(66446008)(8676002)(76116006)(91956017)(5660300002)(110136005)(2906002)(25786009)(99286004)(2501003)(6506007)(8936002)(81156014)(81166006)(26005)(71200400001)(55016002)(71190400001)(66946007)(102836004)(52536014)(3846002)(6116002)(9686003)(256004)(476003)(6436002)(33656002)(486006)(66066001)(186003)(305945005)(7736002)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3836;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKLM58Obs/5Ga7wnM4QHeRH1FYpvlXgc3GQF3mB6LAgEXgRLKXZVv5pwL8/9txKRmn+jJlQ6lB4ARZ3dooaCIC5o3CW+6NDK2gi30JInM7WZ6w1SO2dZ/LHoTHjz5I2ONQPSgklvzU2K5tMZ/5E0ybgLqCxxUEdeUHfz2xAZmywnpeCgo3kLznmUByK4heLVzzMfIsue+V6DbQ2A9VtfnAtGk37VIiggZXujOMi0YANjYXDQdRyf1qPuKn9Kk4+hO8im5H45J/DCc1gksJrec0dEdSiYD4y5Ukz7UpwPrtNnzGnFcLKeG297jBLq++fHtY/eXN6xJUMpKRcAXEIjSkpjQbWMGF/TffyOics9KD07JIswpDCar/I325jX+584xQ7vM+s9NjxfiGfdahCE6D1SAwe1Qw4JyCd1X7cuehLFEvA4i9AWqRy/8SZDiBcw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b3e913-10ee-4e36-0364-08d76140e447
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 16:06:03.1155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwnCVsxBuyXddVIn5zzmA01ePVbuCxFNoh4/JcY2RGZWqrum+36EalH6pElAUBRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbAKEM7lAw48ET/DNpv7Pb6yLE03UKX2Bhr3/5vwPZM=;
 b=RwRtJxU69chK0wu8Fer/dlgs0BqchqeHNlTG2UhMVplJ3glomFNBjqJ0VxKuEw4RJTJwiP6H1chvJvzM1B1514a2W/ffguv971VHsqfewbJR3YgSsy2bpU1mOy2Gd4N+i1DdwhP5CgO0u6UfiPQlDngYC6diqIisxCB7EbKt31M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Message-ID: <20191104160603.Qf4y_A8hlmr2jajSLf6U2dqOZfgZ-UC0SJOgNOBbVP8@z>

W1doeV0KVGhlIHJvb3QgY2F1c2Ugb2YgTmF2aTE0IEhETUkgcGluayBzY3JlZW4gaXNzdWUgaGFz
IGJlZW4gZm91bmQuClRoZXJlIGlzIG5vIG5lZWQgdG8gc2V0IERJR19NT0RFIHR3aWNlIGFueW1v
cmUuCgpbSG93XQpSZW1vdmUgInNldHRpbmcgRElHX01PREUiIHR3aWNlIHdvcmthcm91bmQuCgpT
aWduZWQtb2ZmLWJ5OiBaaGFuIExpdSA8emhhbi5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCA5IC0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jCmluZGV4IGNjOTRjMWE3M2RhYS4uMTJiYTZmZGY4OWI3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCkBAIC0zMDI3
LDE1ICszMDI3LDYgQEAgdm9pZCBjb3JlX2xpbmtfZW5hYmxlX3N0cmVhbSgKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENPTlRST0xMRVJfRFBfVEVTVF9QQVRURVJOX1ZJ
REVPTU9ERSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENPTE9SX0RF
UFRIX1VOREVGSU5FRCk7CgotICAgICAgICAgICAgICAgLyogVGhpcyBzZWNvbmQgY2FsbCBpcyBu
ZWVkZWQgdG8gcmVjb25maWd1cmUgdGhlIERJRwotICAgICAgICAgICAgICAgICogYXMgYSB3b3Jr
YXJvdW5kIGZvciB0aGUgaW5jb3JyZWN0IHZhbHVlIGJlaW5nIGFwcGxpZWQKLSAgICAgICAgICAg
ICAgICAqIGZyb20gdHJhbnNtaXR0ZXIgY29udHJvbC4KLSAgICAgICAgICAgICAgICAqLwotICAg
ICAgICAgICAgICAgaWYgKCFkY19pc192aXJ0dWFsX3NpZ25hbChwaXBlX2N0eC0+c3RyZWFtLT5z
aWduYWwpKQotICAgICAgICAgICAgICAgICAgICAgICBzdHJlYW0tPmxpbmstPmxpbmtfZW5jLT5m
dW5jcy0+c2V0dXAoCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyZWFtLT5saW5r
LT5saW5rX2VuYywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaXBlX2N0eC0+c3Ry
ZWFtLT5zaWduYWwpOwotCiAjaWZkZWYgQ09ORklHX0RSTV9BTURfRENfRFNDX1NVUFBPUlQKICAg
ICAgICAgICAgICAgIGlmIChwaXBlX2N0eC0+c3RyZWFtLT50aW1pbmcuZmxhZ3MuRFNDKSB7CiAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChkY19pc19kcF9zaWduYWwocGlwZV9jdHgtPnN0cmVh
bS0+c2lnbmFsKSB8fAotLQoyLjIxLjAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
