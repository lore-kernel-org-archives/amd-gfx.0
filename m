Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE10C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31DA20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31DA20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477966E2CF;
	Mon,  2 Dec 2019 17:35:17 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7861B6E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK/eI8ChakXGTpLLETNDhQunV8s7J2aJzXBU8NR2Nb/ltG6BxqUndkSi/vKCYJHAyf2GpUf4kJNDI1cDWDS3nYnoWHT0s0fgTEQGaAovivI4ZA6hw/DkJY7QYEQ2ruu9eOrKTvma4IAC0Ym17vA59+j9BxyKoic2EhUAp+Z+tmkq31rSifagD8eTajl7p5Pjk8MrSHlwQ3RGM/QKZYn/d1lx6ZVSlbl0fAL5FbALnDTpY6hfAw8eF4zMY/DB2x5vRwvtfhBEX333dMHrgkAdf/5Z8G7CmuaAyGk8Ejg2I+tKblpOJvyPNHM0EAzDa74Mo96bJ4nSX0x3VoXYpjsFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwOmGZDQw3LUYzZp82I6c5TCP/ZCBHuaKyExZJxqZM8=;
 b=kcyKceOnJQ+dpPQSeKKekI0FYxo2HN4J/GWIqaJiMl/ccHuU1YNIYqiE7bQsb/lAo/t50ry3Zfgvyyg4chCOfG3OX/sVS8Cy/87SlbR5Et/WNIHOrH8PBNE3ygYMdGem4QcPY+kXyaP30H1L4tFPcEyMzFmMRuw3z1EMmj7xmDF1xBFgvGmIVfkMpxdKaO/LQnH59Jf4a9VpvBpNaakIIxU3wpxiCOy4+gUGEk2PUquTVAVBI4oV0O/ONkLOaZ0WFZy/PgVRHBgNsmxQelz4g+bBcx4+waKgz1hVsR26SY6QEknI5nNsYBICZfNmvD/WgCG1+JXv4D+ITLUiKMpQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:12 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:12 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/51] drm/amd/display: add DP protocol version
Date: Mon,  2 Dec 2019 12:33:41 -0500
Message-Id: <20191202173405.31582-28-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a50b1af-74a5-4b47-76dd-08d7774dfc2c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB261092D4ED17C138B881BE9682430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAq/iGdBF44mcCCjVFg5/8wzecybShGd2k1YmNaW7H8+cbaE3gD/c5UrxIwcSUmdJWlrw8mY44zylCwgKVRr6cr2Oq9DvxpZfwSmOVBMmAVlwwIkKNQ3MlXRLNoNUo4STL2jwc7vdfm+ZeJSzHUu90yg/Cl/Le6RQCjeIMSFOxrgmearxJ60Xx5eCXdYYc1wSzyxW1+w/Oh0waQhg0l9Q8gZCivVL6LSFQX9XZg2BxyUgcVqA1aVKOcwEqFn/ZZQfZMj4y7J683h2W/aGtWaqflyXLGZrEoLtAj6Q2gU4xRZwQQTjCgLOHC5ynrDC4Mxb2z2UxmFLzalflNfGFQvlybA6f+Fx2pv92+rbk8K+VtBSD3+nzXp6Oq4NNlr5dSiCuHa0RrraAEr65+o1ycehrrzyXMkN070hk7RjyCiTXWQ4SiWgq+g1TDcfIQkpQKU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a50b1af-74a5-4b47-76dd-08d7774dfc2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:12.6812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJt/UfjYc/UOeYewM418MWLgxIGeTo8/lLiSohARhFQEfAEx1I2AJAbU48d741vU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwOmGZDQw3LUYzZp82I6c5TCP/ZCBHuaKyExZJxqZM8=;
 b=V87g6suzIv976RSDNOvw8KMPUUnGsCzEK4gHWUqLPEbf12w0u3U3kAu/9BjizMp9cvvHFxJPSdUc84V89IfcFs0Yc2qOwdyGu0c0qu7PYRmA46G3W6zIE47vGav26o4njuC56+5brjxn9Z5Ws3dyyd+R2IGP3KhGZ+VhYARkIdI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com, bhawanpreet.lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CgpbV2h5XQpXZSB3YW50IHRv
IGtub3cgRFAgcHJvdG9jb2wgdmVyc2lvbgoKW0hvd10KSW4gREMgY3JlYXRlIHdlIGluaXRpYWxp
emUgYSBjYXAgdG8gaW5kaWNhdGUgdGhlIG1heApEUCBwcm90b2NvbCB2ZXJzaW9uIHN1cHBvcnRl
ZAoKU2lnbmVkLW9mZi1ieTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+ClJldmll
d2VkLWJ5OiBBcmljIEN5ciA8QXJpYy5DeXJAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3Vu
cGVuZy5saUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjLmMgfCAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAgIHwg
NSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwppbmRleCAwNjFlOGFkZjc0NzYuLjU1ZjIyYTFjMGFh
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC04MDksNiAr
ODA5LDggQEAgc3RydWN0IGRjICpkY19jcmVhdGUoY29uc3Qgc3RydWN0IGRjX2luaXRfZGF0YSAq
aW5pdF9wYXJhbXMpCiAJZGMtPmNhcHMubWF4X2F1ZGlvcyA9IGRjLT5yZXNfcG9vbC0+YXVkaW9f
Y291bnQ7CiAJZGMtPmNhcHMubGluZWFyX3BpdGNoX2FsaWdubWVudCA9IDY0OwogCisJZGMtPmNh
cHMubWF4X2RwX3Byb3RvY29sX3ZlcnNpb24gPSBEUF9WRVJTSU9OXzFfNDsKKwogCS8qIFBvcHVs
YXRlIHZlcnNpb25pbmcgaW5mb3JtYXRpb24gKi8KIAlkYy0+dmVyc2lvbnMuZGNfdmVyID0gRENf
VkVSOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCmluZGV4IDM0YjgyNDI3MGM4NC4u
NGM3YTI4ODJhNTEyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaApAQCAtNTQsNiAr
NTQsMTAgQEAgc3RydWN0IGRjX3ZlcnNpb25zIHsKIAlzdHJ1Y3QgZG1jdV92ZXJzaW9uIGRtY3Vf
dmVyc2lvbjsKIH07CiAKK2VudW0gZHBfcHJvdG9jb2xfdmVyc2lvbiB7CisJRFBfVkVSU0lPTl8x
XzQsCit9OworCiBlbnVtIGRjX3BsYW5lX3R5cGUgewogCURDX1BMQU5FX1RZUEVfSU5WQUxJRCwK
IAlEQ19QTEFORV9UWVBFX0RDRV9SR0IsCkBAIC0xMTQsNiArMTE4LDcgQEAgc3RydWN0IGRjX2Nh
cHMgewogCWJvb2wgZXh0ZW5kZWRfYXV4X3RpbWVvdXRfc3VwcG9ydDsKIAlib29sIGRtY3ViX3N1
cHBvcnQ7CiAJYm9vbCBod18zZF9sdXQ7CisJZW51bSBkcF9wcm90b2NvbF92ZXJzaW9uIG1heF9k
cF9wcm90b2NvbF92ZXJzaW9uOwogCXN0cnVjdCBkY19wbGFuZV9jYXAgcGxhbmVzW01BWF9QTEFO
RVNdOwogfTsKIAotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
