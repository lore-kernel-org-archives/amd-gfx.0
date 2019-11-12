Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E93EC17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697652184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697652184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3926EA3C;
	Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800087.outbound.protection.outlook.com [40.107.80.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C436EA37
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlT2fSyKixEARw5/xoGow+cAHJaPcvK/sXQdyRmY3JSUWqPnt1AoJmXE2e30j95Oy5wzkNb7mZwkeL8PAKFDoJFUKoLHRBVu5BglD4TlShLknvZpPvF8OusrAf6BWrpT4CiUIgUKXCgp4kF8eQuPAsHwPNVVOZPxwsz45MWJK77mETojq3cHnOWPJjj8RzLRgbQHLq760g0qqqZHSpW8CIknWJnW9UNNGL8V8AmKPJG43/tiBj4ac7IZ0jwEwR58rZV0Ft3+XRwrT0G9PQaS5imIoBiZifiBY1qK6OH11hCuf6UiLMkYXABJN4aT+01QABqQV+aq39TxVrar0FP8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqCCjeTLMsBnhgGPu5awakhD3dBoSsIsiiAREM3rwvo=;
 b=ZfBupHSnxV1Goi22sVoO4CfUrR8m+f2mbNLx6eSKjb2Hnb54hEHUHtmGonRSuYPm89oJjb7sH/ZFw7vFArp3e1QPN+ttgIHOmGDgJRGO6FXraHR4Y1M+hvnSojExogbzURbnbNlA6IDoqth7ouEgcpF581c8SngTYc9ipzw2Jwl8sjnJGWuDLA9uhaN2WhH2taBx49dESeSgKkNWrNueVDCTan0qVMfFRR0pdB317te3lQL/lP2mcqsczKMfFz8nBCKnA2S4cB5vr7ZUKPIWHExDpZ0m75p//qYqy7QnfqyPKbjMzDXURXGyGuIbshDe1dr+Wqkg1jK77eCBO5PoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:58 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/30] drm/amd/display: Adjust DML workaround threshold
Date: Mon, 11 Nov 2019 19:33:13 -0500
Message-Id: <20191112003324.8419-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cb2c2bd-fbdb-4f36-2a97-08d7670801c0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554E342379E672D8A8C387398770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwMSt63N7N7hwbcUHjFnur07ZWTEIjNfq2aYu1cL6vkLg5Yvnb5r+vdK3h3fvKYV7rBEeySgOlbpVPMA98EtZmAw5XTMpX2/qGPysk54LqcUkIl+tWpvwwk0JklEhugIVQMPN3U/Bo7HVAgT6pgW1ilr6Ld4NnFgEBHOIOV5bC1svkVurYCiqHj+EldkpqznhQPw0EJilKfERr61SB7FIa16ABH/z3uBABJIanfdgjRrUlY2VURBPOKZt/uXIlB96T2yscb/QkDSuDhrZEWQnORLgXi8b6XCbsuFHMaK5s7uU7tPH/mQp9Ckzfsm+18cREL7te6EH498symZzIgW+1U0XPFsMqxfYMfuSbAqd/stiVqQSQ7zm284XZKcXHDHQmTaWB0z7IYLDqUj+VDeM82/AwBA03ZMcYbJ3GZHtRqx7vXdJmEW5mhF/xuuT+d8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb2c2bd-fbdb-4f36-2a97-08d7670801c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:58.4893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO4FltJ+GEBAFYXAxvMQXm9xVbAGvzIbWyc2N6oY5WIiQZ2WQ4W7JScfa5DPW9PMeTXbCUWRvId+3cDktDngmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqCCjeTLMsBnhgGPu5awakhD3dBoSsIsiiAREM3rwvo=;
 b=LbCfj5oIM605OjSuWVLwYkbPfVWznkGkm6I1oJcZYHdqPdSY2n34t+siSNDUhandCs/2D528F43APlDrjC4srwnL/gw7SuHN7kyzFHoxJP6G65fUiaUtSEJyazu/5EOiNKFfn9sIddMrVhPLOpzIpBTZzH2tnZp40azLR+p92es=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Aric Cyr <Aric.Cyr@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003313.CFVfT3P0fGaKpQ8Pnx85lccdpUBrNQ5MVMirxWgfdlA@z>

RnJvbTogSm9zaHVhIEFiZXJiYWNrIDxqb3NodWEuYWJlcmJhY2tAYW1kLmNvbT4KCltXaHldClRo
ZXJlIGlzIGEgY2FzZSB3aGVyZSB0aGUgbWFyZ2luIGlzIGJldHdlZW4gNTAgYW5kIDYwLCBidXQg
YXBwbHlpbmcgdGhlCndvcmthcm91bmQgY2F1c2VzIGEgaGFuZy4gQnkgaW5jcmVhc2luZyB0aGUg
dGhyZXNob2xkLCB3ZSBhcmUgYmxvY2tpbmcgbW9yZQpjYXNlcyBmcm9tIHN3aXRjaGluZyBwLXN0
YXRlIGR1cmluZyBhY3RpdmUsIGJ1dCB0aG9zZSBjYXNlcyB3aWxsIGZhbGwgYmFjawp0byBzd2l0
Y2hpbmcgZHVyaW5nIGJsYW5rLCB3aGljaCBpcyBmaW5lLgoKW0hvd10KIC0gaW5jcmVhc2UgcmVx
dWlyZWQgbWFyZ2luIGZyb20gNTAgdG8gNjAKClNpZ25lZC1vZmYtYnk6IEpvc2h1YSBBYmVyYmFj
ayA8am9zaHVhLmFiZXJiYWNrQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBcmljIEN5ciA8QXJpYy5D
eXJAYW1kLmNvbT4KQWNrZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rp
c3BsYXlfbW9kZV92YmFfMjAuYyAgfCAyICstCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
bWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMHYyLmMgICAgfCAyICstCiAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3Zi
YV8yMC5jCmluZGV4IDc3Yjc1NzRjNjNjYi4uM2IyMjRiMTU1ZThjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlf
bW9kZV92YmFfMjAuYwpAQCAtMjU3OCw3ICsyNTc4LDcgQEAgc3RhdGljIHZvaWQgZG1sMjBfRElT
UENMS0RQUENMS0RDRkNMS0RlZXBTbGVlcFByZWZldGNoUGFyYW1ldGVyc1dhdGVybWFya3NBbmRQ
ZXIKIAkJCQkJKyBtb2RlX2xpYi0+dmJhLkRSQU1DbG9ja0NoYW5nZUxhdGVuY3k7CiAKIAlpZiAo
bW9kZV9saWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VTdXBwb3J0c1ZBY3RpdmUgJiYKLQkJCW1vZGVf
bGliLT52YmEuTWluQWN0aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luID4gNTApIHsKKwkJCW1vZGVf
bGliLT52YmEuTWluQWN0aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luID4gNjApIHsKIAkJbW9kZV9s
aWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VXYXRlcm1hcmsgKz0gMjU7CiAJCW1vZGVfbGliLT52YmEu
RFJBTUNsb2NrQ2hhbmdlU3VwcG9ydFswXVswXSA9IGRtX2RyYW1fY2xvY2tfY2hhbmdlX3ZhY3Rp
dmU7CiAJfSBlbHNlIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMHYyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jCmluZGV4IDYyZGZk
MzZkODMwYS4uNjQ4MmQ3Yjk5YmFlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMHYyLmMK
QEAgLTI2MTIsNyArMjYxMiw3IEBAIHN0YXRpYyB2b2lkIGRtbDIwdjJfRElTUENMS0RQUENMS0RD
RkNMS0RlZXBTbGVlcFByZWZldGNoUGFyYW1ldGVyc1dhdGVybWFya3NBbmRQCiAJCQkJCSsgbW9k
ZV9saWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VMYXRlbmN5OwogCiAJaWYgKG1vZGVfbGliLT52YmEu
RFJBTUNsb2NrQ2hhbmdlU3VwcG9ydHNWQWN0aXZlICYmCi0JCW1vZGVfbGliLT52YmEuTWluQWN0
aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luID4gNTApIHsKKwkJCW1vZGVfbGliLT52YmEuTWluQWN0
aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luID4gNjApIHsKIAkJbW9kZV9saWItPnZiYS5EUkFNQ2xv
Y2tDaGFuZ2VXYXRlcm1hcmsgKz0gMjU7CiAJCW1vZGVfbGliLT52YmEuRFJBTUNsb2NrQ2hhbmdl
U3VwcG9ydFswXVswXSA9IGRtX2RyYW1fY2xvY2tfY2hhbmdlX3ZhY3RpdmU7CiAJfSBlbHNlIGlm
IChtb2RlX2xpYi0+dmJhLkR1bW15UFN0YXRlQ2hlY2sgJiYKLS0gCjIuMjQuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
