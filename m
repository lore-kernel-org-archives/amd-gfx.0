Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F63C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572B820848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572B820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6EE6E2D5;
	Mon,  2 Dec 2019 17:35:49 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680070.outbound.protection.outlook.com [40.107.68.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765F06E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAZwMpSw/rx07lfPXyVmUvZtN15pAMIX8bVk+NMQL9qxFpCeXxr8na90fRs2esX6mc41fxIxjC+ECsV1TQJ3JliZ9OTtuZr8qsoIogvRccpU1oDOYupk8mMtBOTYPPJuedwB4Qk7s269z4waNFmcv7/An1LvAAKbjYydNQ+zqpwnucEO3adWiZnB9BMtGPihfQAxXSzI5lHoIUlkV1kDfITKLL1BXCLN5CJvXkZtQrWeLfuIZ+hpQcXsVMM49GopgaJhBcDocwjqVEJLsynbkFNBiPi8GgV1jbHfMWdJkz4qSqoUxW6w7RubHJ6bx+IK1fbrs46xYLvn2MGzEUoTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPZV3ttFgGhfpUhbMXcgXmeQPjQGrEMIUhVyhEJlsZM=;
 b=E1Sdzrf0tP1WnakWS16TA9zWqOwZ0htvKpMz+EKLz7t57AvlJqA0DvxPyWRwtm+cbn0/qgqm4bCFUJeFZVJrVw2vhId72z99Dn6CuU+gpD1oze4gqhNdmCnzUzSfOQOGQr4XuSKjtiYKKtTVc7wG9NPNC/OXZdXczaW7edmU1sWrUaz0918W86T5z2eRsukmO6Upo6Vc+/OYK0/0tSpgwVeugpZ4SRdP8I1ZmKLj86B3h7nfL4odsoYcvXKWsreNGz9EuV3NtmmQjI21dvFtTRRRteWDRYt8ekg/9kSEVN9HVUEhCcZ/zyH05WBZutmwQlb4NJVHcE3RWhdaSH47mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:46 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:46 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/51] drm/amd/display: update sr latency for renoir when
 using lpddr4
Date: Mon,  2 Dec 2019 12:33:46 -0500
Message-Id: <20191202173405.31582-33-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d02b0fa-0fbe-47c1-2603-08d7774dfecd
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26106A7020EEC003106C6FFE82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fLg571snLtBlaDABNm3nQhq8DsyUDnHenLQ+M8wiz/+mULADl+l7USiAnboWmQ/8YhVhQPHM381Q6XiWw6/qbM3vUhGPyg+qZcLIM0xl0IuZWWH2KaNeIv4+zmkCFemMudNFwG6HuQm5LBBmbbyY0tnK+hbRgZ1wZKSp1XKLGRqsSO1lHmkp9hOQ4O9zmCX1V3H52+PkRdgKS690FEkIspLZLl4q580qWCfkFe+LPUJCH6jgSqidM+GaqAwTMa8K2y8658qai+LLpUCVu5IH39X/M/LZcC64+lY64a6nD0BxGcErsMMqSAQGG8Y9Kty18Uz55OIotmY6YF8ocFcztsP4Fz5HbyboP9IfNzl2kuwG7iuA6AApvq9k2D+43pATKf+Pl9SSykIxG31gaINkVka809Gkp3554k3LXFDnrCPucMlCE0FWbYKjGqkY5Bf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d02b0fa-0fbe-47c1-2603-08d7774dfecd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:17.0487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeG7U7JK5dSB3175sco82kCfC2FHli7idOX1a6XACyuv+leX7EOPrHZ2qD5zye93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPZV3ttFgGhfpUhbMXcgXmeQPjQGrEMIUhVyhEJlsZM=;
 b=oXLOQeO98Jxjg/f4cz22bc65QRRb1lBdnSeuOCLQiHQfD64OwJWFzxSBhWbuMMfO99HAmqx0d7/k0DFQP+7FRbYbUpzRkz6GP5/ijLHAAcEBM+nu6WNOoQp8zyAb551iPenaLp/Hk2hDQVXsSvq7Z10JYwkWXlvivIwvqfyYynY=
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
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 rodrigo.siqueira@amd.com, Joseph Gravenor <joseph.gravenor@amd.com>,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KCltXaHldCkRG
IHRlYW0gaGFzIHByb2R1Y2VkIG1vcmUgb3B0aW1pemVkIHNyIGxhdGVuY3kgbnVtYmVycywgZm9y
IGxwZGRyNAoKW0hvd10KY2hhbmdlIHRoZSBzciBsYWVuY3kgaW4gdGhlIGxwZGRyNCB3bSB0YWJs
ZSB0byB0aGUgbmV3IGxhdGVuY3kKbnVtYmVyCgpTaWduZWQtb2ZmLWJ5OiBKb3NlcGggR3JhdmVu
b3IgPGpvc2VwaC5ncmF2ZW5vckBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9u
eS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0t
LQogLi4uL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjEvcm5fY2xrX21nci5jICAgIHwgMTYg
KysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xr
X21nci9kY24yMS9ybl9jbGtfbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y2xrX21nci9kY24yMS9ybl9jbGtfbWdyLmMKaW5kZXggOTAxZTcwMzViZjhlLi4zNzIzMGQzZDk0
YTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2Rj
bjIxL3JuX2Nsa19tZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xr
X21nci9kY24yMS9ybl9jbGtfbWdyLmMKQEAgLTU2MywzMiArNTYzLDMyIEBAIHN0cnVjdCB3bV90
YWJsZSBscGRkcjRfd21fdGFibGUgPSB7CiAJCQkud21faW5zdCA9IFdNX0EsCiAJCQkud21fdHlw
ZSA9IFdNX1RZUEVfUFNUQVRFX0NIRywKIAkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9IDExLjY1MzMz
LAotCQkJLnNyX2V4aXRfdGltZV91cyA9IDEyLjUsCi0JCQkuc3JfZW50ZXJfcGx1c19leGl0X3Rp
bWVfdXMgPSAxNy4wLAorCQkJLnNyX2V4aXRfdGltZV91cyA9IDUuMzIsCisJCQkuc3JfZW50ZXJf
cGx1c19leGl0X3RpbWVfdXMgPSA2LjM4LAogCQkJLnZhbGlkID0gdHJ1ZSwKIAkJfSwKIAkJewog
CQkJLndtX2luc3QgPSBXTV9CLAogCQkJLndtX3R5cGUgPSBXTV9UWVBFX1BTVEFURV9DSEcsCiAJ
CQkucHN0YXRlX2xhdGVuY3lfdXMgPSAxMS42NTMzMywKLQkJCS5zcl9leGl0X3RpbWVfdXMgPSAx
Mi41LAotCQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTcuMCwKKwkJCS5zcl9leGl0
X3RpbWVfdXMgPSA5LjgyLAorCQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTEuMTk2
LAogCQkJLnZhbGlkID0gdHJ1ZSwKIAkJfSwKIAkJewogCQkJLndtX2luc3QgPSBXTV9DLAogCQkJ
LndtX3R5cGUgPSBXTV9UWVBFX1BTVEFURV9DSEcsCiAJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAx
MS42NTMzMywKLQkJCS5zcl9leGl0X3RpbWVfdXMgPSAxMi41LAotCQkJLnNyX2VudGVyX3BsdXNf
ZXhpdF90aW1lX3VzID0gMTcuMCwKKwkJCS5zcl9leGl0X3RpbWVfdXMgPSA5Ljg5LAorCQkJLnNy
X2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTEuMjQsCiAJCQkudmFsaWQgPSB0cnVlLAogCQl9
LAogCQl7CiAJCQkud21faW5zdCA9IFdNX0QsCiAJCQkud21fdHlwZSA9IFdNX1RZUEVfUFNUQVRF
X0NIRywKIAkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9IDExLjY1MzMzLAotCQkJLnNyX2V4aXRfdGlt
ZV91cyA9IDEyLjUsCi0JCQkuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMgPSAxNy4wLAorCQkJ
LnNyX2V4aXRfdGltZV91cyA9IDkuNzQ4LAorCQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3Vz
ID0gMTEuMTAyLAogCQkJLnZhbGlkID0gdHJ1ZSwKIAkJfSwKIAl9Ci0tIAoyLjI0LjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
