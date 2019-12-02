Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16043C43215
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E712120848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E712120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444386E2D8;
	Mon,  2 Dec 2019 17:35:52 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800075.outbound.protection.outlook.com [40.107.80.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0324E6E28A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWTJjiefpGIGc+5dU1ls4K7R98nHcNVh9QPJyO7yj1eqQxB+Yt33f6wboZhD1v1PYa1svUJF9BP1GCIvPozY2Px5IVwzCS3rA6evyyRamGQysitw7r9zRLfv4N8FFqhpyZexJZ6v8ikU1oMTneKd1J+ILzdXyEyKok05FYpOE4tV3Gb1Pm5XKS5bERlzEsHC466xjJlcxU3+R0JomHhMCRr7ZPMt0DjQXTXCo/Pc3CqnYtwUD8m68DHqYqQ2K54mRXde8eiGNSH4b1pQ9bgKO3WGIN9SOFbsDoscdfkPN8p7vetahBctgNKjiTSglVc4Hykyf+N5hE0Lus9vlggcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYXJLOb9sV0p5wse957iju/rjhfJDuPF8wrETWIqlys=;
 b=a8kJE5NLNIrHYK5SWYH4s40W85TKP3jdjsA/zLZhc/RYlhk98MxelIHXP/bW8h7ph+2uvksQxdMxduHrzBb9j5Tot0oMbdZom8UshZwpekoC02Yoc1BKGFCtt9u8U0V7AFHLQsaT9Z0Hl94tBSnmL47uHnf115hMvRCPOAJ3NlgNgXm9oxbZYrSujQHreW78xrYjtjrJ0Kz3dmeYnDXEZuaX+6ZexYHLYmHevF+6XwSSeMpr1s8oxEw/UIcNVziVVhPST7sGuoioNe7v+Guft97r1GnmtRM8LyMx+iRFMKgg3t2oda30yINxP213E6JcER3uNKONahVnsDjvoVWZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:49 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:48 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/51] drm/amd/display: Remove redundant call
Date: Mon,  2 Dec 2019 12:33:50 -0500
Message-Id: <20191202173405.31582-37-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 032d9137-2237-4c1d-e039-08d7774e00cb
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610D630EA44D02F585FC0DA82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
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
X-Microsoft-Antispam-Message-Info: kwiMxK9s6eKooc0xTCH7fOH4wHPN/wDPKPfuQjewtr+FoqVfwHJuDt113HCDct2t0NU5NM7z4az862mrJ5xC9z9Nj+VfVEw77Vc1+jXA3tpSrdfMZ3AZN8wF+qisToT24u7/rcDFsFZn96zIEOisGge+SRarxysmPofzYVteHz3ObZM2dqIepaJCFa/LS36IIjkXECfO2C16L8OORRQEad9Q3L1kCIF3D6UjH2FFnib8FUX/bxQ1AmJe//bU9YMktw+R35epS+gkiaAlIG4uERXrvG1pe6QKN2mfDZqRl+FlrjWyeuDaXCBPcEGF+y2bEzankyBFo929HI+Tfo5JuixzltG4lebSmULLRChz7cNneHnZLXTO2x6KF7qzbTdUo1KxFHsoOExg8/++DhfgylLUobPY7rPb1ZzbboXcYDJ3NwNlRdG6jv6tbAneJ3b5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032d9137-2237-4c1d-e039-08d7774e00cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:20.3358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pogoi2d4sB5EXn2yBTFeflR0BUgAeTumDa1yww6PAp6IaGD/gzXATGlXTWT4kaGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYXJLOb9sV0p5wse957iju/rjhfJDuPF8wrETWIqlys=;
 b=EzuSG2ir6YxiCUGPg8T8niAmTrDbCW/PtPMkV7mtivktAbwzlrDyfOb4fQPTLZCGVL5FesG974mOL8zbcCevUQb/+QPF2Z4D0QrMgQ34EZHbJi99AMqdw90n35oB/q2h7Zhjx1+/6+e7DvlSkdTmOERRBX/gfYZIwy2jPBh9OzI=
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Noah Abradjian <noah.abradjian@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTm9haCBBYnJhZGppYW4gPG5vYWguYWJyYWRqaWFuQGFtZC5jb20+CgpbV2h5XQpJIHdh
cyBhZHZpc2VkIHRoYXQgd2UgZG9uJ3QgbmVlZCB0aGlzIGNhbGwgb2YgcHJvZ3JhbV9mcm9udF9l
bmQsIGFzCmVhcmxpZXIgYW5kIGxhdGVyIGNhbGxzIGluIHRoZSBzYW1lIHNlcXVlbmNlIGFyZSBz
dWZmaWNpZW50LgoKW0hvd10KUmVtb3ZlIGZpcnN0IGNhbGwgb2YgcHJvZ3JhbV9mcm9udF9lbmQg
aW4gZGNfY29tbWl0X3N0YXRlX25vX2NoZWNrLgoKU2lnbmVkLW9mZi1ieTogTm9haCBBYnJhZGpp
YW4gPG5vYWguYWJyYWRqaWFuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBZb25ncWlhbmcgU3VuIDx5
b25ncWlhbmcuc3VuQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwgMiAtLQog
MSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjLmMKaW5kZXggNTVmMjJhMWMwYWE1Li4zOWZlMzhjYjM5YjYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwpAQCAtMTE2Nyw4ICsxMTY3LDYgQEAg
c3RhdGljIGVudW0gZGNfc3RhdHVzIGRjX2NvbW1pdF9zdGF0ZV9ub19jaGVjayhzdHJ1Y3QgZGMg
KmRjLCBzdHJ1Y3QgZGNfc3RhdGUgKmMKIAkJCQljb250ZXh0LT5zdHJlYW1fc3RhdHVzW2ldLnBs
YW5lX2NvdW50LAogCQkJCWNvbnRleHQpOyAvKiB1c2UgbmV3IHBpcGUgY29uZmlnIGluIG5ldyBj
b250ZXh0ICovCiAJCX0KLQlpZiAoZGMtPmh3c3MucHJvZ3JhbV9mcm9udF9lbmRfZm9yX2N0eCkK
LQkJZGMtPmh3c3MucHJvZ3JhbV9mcm9udF9lbmRfZm9yX2N0eChkYywgY29udGV4dCk7CiAKIAkv
KiBQcm9ncmFtIGhhcmR3YXJlICovCiAJZm9yIChpID0gMDsgaSA8IGRjLT5yZXNfcG9vbC0+cGlw
ZV9jb3VudDsgaSsrKSB7Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
