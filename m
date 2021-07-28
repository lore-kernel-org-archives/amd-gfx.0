Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F1C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 06:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5150460C41
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 06:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5150460C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F132E6E283;
	Wed, 28 Jul 2021 06:36:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979AC6E283
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 06:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYhLkW1AkYIL3CCAmlb2YOQ8qkpsJlxrxM8t66PBIzznCIIw9eKyInHTxWOHGjdrPqaVwhBPpPE9c4edy2YY1/Ys2sQJTV+NSFWD9a3WTVc+LQazShwvuqnauTSX5gkruIN5pFd9VsM7798F0MBKeMuXqPR5aWdGcfgBEjnBq1O7MUtJwU5jfkV7NSkvgxxujCpiOQFT8hZ/9vypSDyQbLBRc5Iqqa1XWYwdIseEgOFxJ5cmC8/bLXhBf1dwrm3M+PRMaG2QbKGPvMEBNFf7aqNw31JrMwaU9uWbzGGD3itBxKJs2DoRrBC1c0W4Doz8+fntMjdlkONyqpksqu+avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+X9u8ji1oMhkjUt7zZArF6yLvD3ZXIVYPmldYS+w7M=;
 b=FvRs/YaN5iPy3NlfXMfi1nkzxD3Z+PZjHZypyg2yzI0Q5YhNORxbKIsJXY/p8kgXwxp4DsTDrj7Mje0BOgu5eQdx5StYo3dBR4xaO7PU3NkAP6vrq9ujgLadnB7UkihI65UxbNdJG5A8r2l7VOJqqLQsU/7WnT/Rm9NehNUxCCUNX1KifXjnbF8gLgIwO05rKsNyHPuMe8RgGTykIq3uQD6vhUTiaEZ1AYKIdG28AdfPWC0jFqHVJZMnRGGIZUdo+DyQZjyUqpFXsXK6gWrkBLWILcxiUg/LtfSTYdvlna9WLXYbwqGtakAhjBJ7QIRGD/UaQjygUsIykPMyENeUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+X9u8ji1oMhkjUt7zZArF6yLvD3ZXIVYPmldYS+w7M=;
 b=R/bG/Sdw+BbQXUuH+xw4UoWgcZflUtKxh9Jfe0xYu5Md8xakmizqASwhZ+FMB/UfMx6+aVRM985hAIXVEIvT2NpNs8nFCIDSkt18mbc2zxBgbnz3QWvD7h8I+UeDMLoL2b0In5AX/xbJL47ZkQwOgHMxXkapuoMW+86sqTcrM9I=
Received: from BN9PR03CA0906.namprd03.prod.outlook.com (2603:10b6:408:107::11)
 by MN2PR12MB3262.namprd12.prod.outlook.com (2603:10b6:208:102::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 06:36:29 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::2c) by BN9PR03CA0906.outlook.office365.com
 (2603:10b6:408:107::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend
 Transport; Wed, 28 Jul 2021 06:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 06:36:29 +0000
Received: from changfeng-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 28 Jul
 2021 01:36:27 -0500
From: Changfeng <Changfeng.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Ray.Huang@amd.com>, <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: set default noretry=1 to fix kfd SVM issues for
 raven
Date: Wed, 28 Jul 2021 14:36:13 +0800
Message-ID: <20210728063613.3334-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35cf0fb6-b9b9-42e9-27b8-08d951920838
X-MS-TrafficTypeDiagnostic: MN2PR12MB3262:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32625F1C0EB707E7AA8212E0FDEA9@MN2PR12MB3262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DZ7Obk38hOmys4DfvLzxu8mvE4A51BlUgfwa9cjhomxBSXto6mJXTn+yR4JDe4pqC0ZJBAeXNbLRhVCOf8ClLXYgPplnucNg6NJXXZiTpzY6PpDtUd/0aT+3hOP6kTUNy1VGFd+Kp9CIB9RFfE7JMTSYOX3CwEnZKMLWeV0cZvMPmrTUKDyyQtWsZ46Cd8MNI2Zo/bFrXr6Lqm4VD8IaKOJf7QNPQun6f1OSxlUEjA2w6iIi7pyUzpW8wAZViTLNkkk8z3KVPPVGpQhC2wE2nMfYyx9DdEIuo0y6fNtB5idkQGdHO7XVWoSxLjFDxyaoLIzjlaZFkTwbNldubQ7RCWxHTbcrum5SbU6grDWCVVn3ilRsAMZoyVPlcTMix2/Zw45bqrAbv/b63Kw9GsoReGcaL4rywZKpHmQy2/4p4GlWU+k2CjkJ4Sdg2r5teZ2nIXHsXPv0+y1PfYhKXrhKIV06WbzyhEuNGA2ulEsQe0Y8M1AXtAudaepj7F2F+aaOz8B+u/koVe/P/X2/j5ZsH82N/WCNZ+ECoDWNC3SCOsSeT4pNzZqKWqFWNkvK9aMVzRQpyojz5yzeTR60FBBc7A8zzszcJQ+3ln71zSqleiXWR0Qb9FIJf2oLRlyNC2WvbAovBGlkGG4vxogrwgM6Tp29a7YbnuY3Q/NHoL9VS/iqo4bP2hy2sA+k2jegsE+jpZxDvlHLRT8rGAVr4E/xVwYATGVGlU5ethL6FiY1kowHZfjQvvrYcSV7s9dT0eDMv9bvDdHHq4a4q1bdm/IGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(46966006)(478600001)(6636002)(36860700001)(86362001)(8936002)(336012)(2906002)(70586007)(356005)(82740400003)(8676002)(47076005)(81166007)(16526019)(1076003)(4326008)(316002)(2616005)(36756003)(70206006)(110136005)(26005)(7696005)(82310400003)(426003)(186003)(6666004)(5660300002)(83380400001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 06:36:29.4179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cf0fb6-b9b9-42e9-27b8-08d951920838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3262
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It can't find any issues with noretry=1 except two SVM migrate issues.
Oppositely, it will cause most SVM cases fail with noretry=0.
The two SVM migrate issues also happen with noretry=0. So it can set
default noretry=1 for raven firstly to fix most SVM fails.

Change-Id: Idb5cb3c1a04104013e4ab8aed2ad4751aaec4bbc
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 09edfb64cce0..d7f69dbd48e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -606,19 +606,20 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
 		 */
+	case CHIP_RAVEN:
+		/*
+		 * TODO: Raven currently can fix most SVM issues with
+		 * noretry =1. However it has two issues with noretry = 1
+		 * on kfd migrate tests. It still needs to root causes
+		 * with these two migrate fails on raven with noretry = 1.
+		 */
 		if (amdgpu_noretry == -1)
 			gmc->noretry = 1;
 		else
 			gmc->noretry = amdgpu_noretry;
 		break;
-	case CHIP_RAVEN:
 	default:
-		/* Raven currently has issues with noretry
-		 * regardless of what we decide for other
-		 * asics, we should leave raven with
-		 * noretry = 0 until we root cause the
-		 * issues.
-		 *
+		/*
 		 * default this to 0 for now, but we may want
 		 * to change this in the future for certain
 		 * GPUs as it can increase performance in
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
