Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66489C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 16:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA2910E1C8;
	Fri, 14 Apr 2023 16:29:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EA210E1C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 16:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdLIXuhoDPu4WW8AMDROB0WBtoD/Qnre7mg+196z291YBqqAby+4Iz88QD8I/XUtKrUG0OIXwI3jkFIFT9+Ic1mhDJKp1lNH0SXNIcWhp4IwMsXMXI+DbFEC5CJr63ZIFyczHi6A+RVBZfEg94SLJ9IS7ABTJ4Hdb6TBDFHBarf7PMMBA8wf8eiR7MGQYyxBCyleBVtuj4vu2Ly3+fs6HtPAgSMjwilcr86MnDosy3Jon2u+9FCRvnGSL2481Ogafuk0wpebEbSMcHbI2cpumdlVd3ZpBU8jGEqmYn2iE5m0R3x7fNO0PAy19V1OxeiZp5m4SaIA/wx7rNkS6amxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXqZ3mR7aUTAy5CZyYSPyNHrfrn+YJlbfTteAUluKZ4=;
 b=PnZGX5zI4VlNFSIMJS2idvGGSkswnpnJpxlHms7yD4IGXdJOsKf4/VfnyFiyxYsEmmNJMXLtNrFrv1lM3bcnLIrMw5hXPvv9CAbrZN2O3ePt2ADM9rjgFW1py+lz/3U8IZyJ+EsBTx4Gx/k7uGvV6mYJWx+CRI9Nx0uxlxWNnIUN3uHIguiLRAyqUpNnBVjwvp+I8D4mYpkBAhrAgNyIz/RhTxABsi8pJr7irMxTC6t8wtmu8Wr5QYWid6Hzb1J7BylVbjZ64vVwr3rE8erOvlYB7YbTfF4JZ2lXPQGmbxuHvCcIP530CHaLHSw6tP5IrK/Rthmnp8Y6/tN94HgCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXqZ3mR7aUTAy5CZyYSPyNHrfrn+YJlbfTteAUluKZ4=;
 b=cHtnTCtOeB09Jh3KJl6vyjBI68Er9NiwZAbp3ruopYoaCIcJu64NPuiXT3d4fxvcSerDERPmDWB7DNKJCgmxhWZvEl9ecZjNObLi1ftzyDpLUpxRwCdY8D8M519MNHjQqsqxARe5gNW1eevuRzKatrYMGpRI1qN58W4l/E2uhxw=
Received: from BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 16:29:23 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::12) by BL0PR05CA0003.outlook.office365.com
 (2603:10b6:208:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.10 via Frontend
 Transport; Fri, 14 Apr 2023 16:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Fri, 14 Apr 2023 16:29:22 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 11:29:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH v3] drm/amd/display: Add logging when DP link training Channel
 EQ is Successful
Date: Fri, 14 Apr 2023 21:59:05 +0530
Message-ID: <20230414162905.2553157-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3aa989-8d82-42c9-244b-08db3d0567de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dOWIniFAr6H8gifsCLw9d6dFaBPI3dlzezvzP8WgA5xo2P7O9s7TCHKX1L5nhKHS6LjatlbndVPMX9P5okUZOoaBuw6dCx46hbv1TQunjTTT/ldw2QFnkqrWTLYOstyYf39zvVDATaavhLHyO/Pd6zv74AEiQaSnrAfYBHkw/KPTc0eTRvMjSEjvscwo0e+0eWdEVjOoB2KCZbT5MLdCTnKSaeeEsEwvmLMsDzFdPTbE/lkDaIP+NLr0WL76ULwck1JtytsJsrPrW7ZDfnbJ0R0olctp0hOSAe4hP9lviqzy0q3qnGKf8eHMDreaaEB4Sl5VHzBOs5FqIl+CdYAEGZoPTlwhzCEXUup/sAxDzZ2br7EEHfIWknDmuVlbEkGidNRz72WJzbeqBwv6nCNQPYaSBQxKggN/VYs0K8cISXa10FNFVKUz+8Yh7P52D4o5d0AH1ERa9Mz/KR3MrZLa14DXm3xFnZ2ZeMZyW7XdY/2krcbE1fDTVXJoLko1PcjIZoBM4RA/oRo56OZvkffrkJprggglGo8FIcHy5RthTqv49jOAowhaGWK0IZn2hN9H0B6fw/90/yEBWiRcjeiicXaRC6UgXY5yThUfiAZPl3vl/MT4J5fVP/zxFhfOi0Q6lLPQgeW1daSOjFoNo5EWu9wYuGMAIw4G7FcA9DwoJXx8tfffwq5TnIFkAi9YTknLKK9FLpx/4dNcSrrEw3zcNCSqduhjZ2thexqDAyP/ms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(40460700003)(5660300002)(36756003)(4326008)(70586007)(70206006)(2906002)(44832011)(86362001)(81166007)(41300700001)(82310400005)(8676002)(356005)(82740400003)(316002)(8936002)(478600001)(40480700001)(54906003)(6636002)(110136005)(1076003)(26005)(336012)(426003)(36860700001)(16526019)(2616005)(47076005)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 16:29:22.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3aa989-8d82-42c9-244b-08db3d0567de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Log when Channel Equalization is successful,
and DP link training completed.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:

 - For consistency of the printed messages, either drop or keep  %s for both the
   lines - it is dropped (Aurabindo)
 - For 128b/132b, moved the statements after EQ interlane alignment
   is done.

v3:

 - retained %s for both the lines, useful for better debugging

 .../display/dc/link/protocols/link_dp_training_128b_132b.c  | 3 +++
 .../amd/display/dc/link/protocols/link_dp_training_8b_10b.c | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
index 23d380f09a21..a1990118cf50 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
@@ -136,6 +136,9 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 			result = LINK_TRAINING_ABORT;
 		} else if (dpcd_lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b) {
 			/* pass */
+			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
+			DC_LOG_HW_LINK_TRAINING("%s: DP 128b/132b Link Training successful\n",
+						__func__);
 			break;
 		} else if (wait_time >= lt_settings->eq_wait_time_limit) {
 			result = DP_128b_132b_CHANNEL_EQ_DONE_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 3889ebb2256b..104da87f395a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -339,8 +339,12 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 		/* 6. check CHEQ done*/
 		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
 				dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
-				dp_is_interlane_aligned(dpcd_lane_status_updated))
+				dp_is_interlane_aligned(dpcd_lane_status_updated)) {
+			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
+			DC_LOG_HW_LINK_TRAINING("%s: DP 8b/10b Link Training successful\n",
+						__func__);
 			return LINK_TRAINING_SUCCESS;
+		}
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-- 
2.25.1

