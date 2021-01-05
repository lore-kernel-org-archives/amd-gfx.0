Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C9C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 03:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51AA22573
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 03:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51AA22573
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59FD896F7;
	Tue,  5 Jan 2021 03:13:32 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680050.outbound.protection.outlook.com [40.107.68.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A819896F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 03:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIpgERZpePZ937CuNkAwzoc8TUbNlYBSKjhvSC0Uh9/HGJ6RyVus5eBgbiLg0chMhVzI2pktCME9fjNjTE2zkvMtooeDKXdMvXG5GvrYI/0XZ4mWQ4D4svycCP4PShFChwP9ulYIxppHb2V6+aKYJQkVYASFnGc/8K6SjqH9GBiVtL0rZsCaYuklkHCJD8xHwpnnvCpK7NDH6IX8V7RAOfIoK1Xebu69CfgYpih6JYkIFhuI6hd0OhiA8Jg2Jtlcs7/JvMBUz4yEnKU3TM4UAMuKeYtR1E1bduch4qj1MRp/BudOuiUM6LqdUOYeTbRbul9OQrMvc3m10LsxHkiH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+B4imy5z/5WO74LK9T7BFfwx457SPzUJdsB6nFrYXA=;
 b=O9m12yQsd4iwBSYsNq1cYNLu2jBheqYG8EgaYgA/SMFTi1c0H48qh068N7kRwH/45GPrQ44T0k8rXZHcj2QpZBGV8dT9uEEuXjRLa8o9N7Udv+KIJw1y74KnRwSfCYzqrIuToKUqutZqx3Wq2w4VOae+SMgcGcQG1zHVpaCaml9SeBErk/XQjN+6jeR+gLYCJIJskEnAncUVamOegt4O1s112GcZ4IvsDFulOFadBgqANH80441PjR0zQHa7ru7m90qV/oyTFNaezJdDz1q0HzmVPxbk29os13PGVPk2ks77gMmGhVfc/L/rEvBrKcGxBygS9OWIGxlsZy6qTWL5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+B4imy5z/5WO74LK9T7BFfwx457SPzUJdsB6nFrYXA=;
 b=gH4/hLtM1X3xvEGwWi5SLWBK9tyz2i0chFOwMQlI1n/ZlAI9bS6byF6R7fGvGMLmgj/WCR+F2BsHsZbf8Jp4OWC8LrBvP4ZoPBgmrMHbHxlavaSSWMCdSevs7O8tPyWAZtXjH+6m9k4yUmN2z6SSnWFX2Hlva+KrmGZzOd6frR4=
Received: from MWHPR18CA0056.namprd18.prod.outlook.com (2603:10b6:300:39::18)
 by BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 03:13:28 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::e9) by MWHPR18CA0056.outlook.office365.com
 (2603:10b6:300:39::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Tue, 5 Jan 2021 03:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Tue, 5 Jan 2021 03:13:26 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 4 Jan 2021
 21:13:25 -0600
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 4 Jan 2021 21:13:24 -0600
From: Victor <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp: fix psp gfx ctrl cmds
Date: Tue, 5 Jan 2021 11:13:13 +0800
Message-ID: <20210105031313.4888-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92fc1d9d-12af-4597-b0ee-08d8b127de46
X-MS-TrafficTypeDiagnostic: BYAPR12MB4695:
X-Microsoft-Antispam-PRVS: <BYAPR12MB46958578DE5D088831BADED4FAD10@BYAPR12MB4695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tM5oagbwOaYbOVD8sHUCd2qApV/tgnkB1m078qniHpqZ8Xb+CL6QNLKoyAGnx+uwFD3OfBjsAiw844v88BZiJV9Bw2x6P5UIzUyZ9HJAyP7sfA8+K8W5u1QIPbtb1ICQJhHFseTql7o3rFusY8potGZzWljedJsJENmH6VnX0p4m4ZbMS+9tQEHnkAkY63z/i1P7T9KJLfiLPU2C86LZolqDEsYqRcvoGAWF0xKIwqidlj2Cu1nR5XKxvWYqSx9LF0oKeAwoegjIGdfL9N6uJWG1NyqtWbZT3TzQmAzaKT0FwFtOT1HDXgvw2QWGm2+AAaPO2fH6gxJFpFwm+JPajEz35i2wjvdqcysDk+yrbvoX3doQjoNYEdL1vTN9KhA1eN3XPtCSZVQg2o9uoraNbZb146atiy/Ql2bI6DC8MPKJUmoabE/emZEzWEjygBHn3Jc2ZVX8dTjQJ20hjym8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(2906002)(356005)(86362001)(478600001)(426003)(4326008)(81166007)(6916009)(1076003)(7696005)(36756003)(26005)(336012)(8676002)(70206006)(82310400003)(82740400003)(6666004)(70586007)(186003)(5660300002)(2616005)(8936002)(316002)(47076005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 03:13:26.2191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fc1d9d-12af-4597-b0ee-08d8b127de46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
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
Cc: Victor <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

psp GFX_CTRL_CMD_ID_CONSUME_CMD different for windows and linux,
according to psp, linux cmds are not correct

Signed-off-by: Victor <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 26 +++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index d65a5339d354..602ea5cd9f3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -39,18 +39,20 @@
 */
 enum psp_gfx_crtl_cmd_id
 {
-    GFX_CTRL_CMD_ID_INIT_RBI_RING   = 0x00010000,   /* initialize RBI ring */
-    GFX_CTRL_CMD_ID_INIT_GPCOM_RING = 0x00020000,   /* initialize GPCOM ring */
-    GFX_CTRL_CMD_ID_DESTROY_RINGS   = 0x00030000,   /* destroy rings */
-    GFX_CTRL_CMD_ID_CAN_INIT_RINGS  = 0x00040000,   /* is it allowed to initialized the rings */
-    GFX_CTRL_CMD_ID_ENABLE_INT      = 0x00050000,   /* enable PSP-to-Gfx interrupt */
-    GFX_CTRL_CMD_ID_DISABLE_INT     = 0x00060000,   /* disable PSP-to-Gfx interrupt */
-    GFX_CTRL_CMD_ID_MODE1_RST       = 0x00070000,   /* trigger the Mode 1 reset */
-    GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
-    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x000A0000,   /* send interrupt to psp for updating write pointer of vf */
-    GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
-
-    GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
+    GFX_CTRL_CMD_ID_INIT_RBI_RING       = 0x00010000,   /* initialize RBI ring */
+    GFX_CTRL_CMD_ID_INIT_GPCOM_RING     = 0x00020000,   /* initialize GPCOM ring */
+    GFX_CTRL_CMD_ID_DESTROY_RINGS       = 0x00030000,   /* destroy rings */
+    GFX_CTRL_CMD_ID_CAN_INIT_RINGS      = 0x00040000,   /* is it allowed to initialized the rings */
+    GFX_CTRL_CMD_ID_ENABLE_INT          = 0x00050000,   /* enable PSP-to-Gfx interrupt */
+    GFX_CTRL_CMD_ID_DISABLE_INT         = 0x00060000,   /* disable PSP-to-Gfx interrupt */
+    GFX_CTRL_CMD_ID_MODE1_RST           = 0x00070000,   /* trigger the Mode 1 reset */
+    GFX_CTRL_CMD_ID_GBR_IH_SET          = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
+    GFX_CTRL_CMD_ID_CONSUME_CMD         = 0x00090000,   /* send interrupt to PSP for SRIOV ring write pointer update */
+    GFX_CTRL_CMD_ID_MODE2_RST           = 0x000A0000,   /* trigger the Mode 2 reset */
+    GFX_CTRL_CMD_ID_DESTROY_RBI_RING    = 0x000B0000,   /* destroy RBI ring */
+    GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING  = 0x000C0000,   /* destroy GPCOM ring */
+
+    GFX_CTRL_CMD_ID_MAX                 = 0x000F0000,   /* max command ID */
 };
 
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
