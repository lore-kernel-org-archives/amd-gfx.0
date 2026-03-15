Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95DEF30271
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Mar 2026 14:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1984710E002;
	Sun, 15 Mar 2026 14:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAZtW+Ir";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3D710E002
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 14:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rv7XNtPdfRONY4kwjX6LVwPEOh0cRNVF1cauoU0okjmcUt3ITeZiuZdqa11wwBAEbm7MypIGBO8Z2xK+OtRWNo3D+wpvQhLENWhGN/8b+qfl+uDmWhFZJjJDwODtpbXeiwULdM+SFRlb0rDnYatV1eBVfxI5/QgEsefbiQnzwhP9OgkVrlvCXQALMZ3b3hGMPttJgkLGnU+3fcoruReR3eRYhMji2EC93dH4Tt3OCLICNNK6qsNkQaQJ7x2xscoS4QKJ+7FoNbWDffelXWI/SB2ZPTic+cSEV54KOp0maNnluOjbi4yJBb0aJnur2qllJRyK4x2OCqFXhB9XQJBF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSJXbSbLwujS2/5lIqFdG9nDQYaR8BK/bmE4M1FiJW8=;
 b=XJ4iGYVnLFaw75ZLMJdvSEg8ssRcN4BRw8fXJC/tsLX6jCNtSKymXwnyMorR6y+OfR4KHie8ioiAZpA1KqYUepdmpn3t7uo9hhVgHwt2M0gloi96exnyUeSl+vdLPpGHveNicUYok29+lHjlOhfCad72rPRJict/oO6fm66ZpqL7P7tbfPIRYjS/Ndm5A3HzAhHiNG4xiVj06uSXV3HAKTo+HZcLZ6XDJnZIemzLybJOxZdWIpiLNDQ11QAeBCc2y/JUpG9Vyo+FXHuylDFBjyNizlfDNnx1VAz+ZZ6/XhTZdDdFb8cDcBFYRvakE9Dc2W7M3y7D1JHJJQHIKYMSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSJXbSbLwujS2/5lIqFdG9nDQYaR8BK/bmE4M1FiJW8=;
 b=wAZtW+IrV4OUy7YeZ+WdJi6ZwG6j3puhHLKCxz01pRlslMhLawYI2OC+iPZ6HTO25TsglaXVP52zRcr63YujbeVZL4bYAxujBZdu948hCrQ9XeRrXWPLOnMz6owfg1j1ThSl8Iff+zFFOsynSyEKb4hjC9Fu9y0xgHv8P3g6/mw=
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.9; Sun, 15 Mar
 2026 14:42:10 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::29) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Sun,
 15 Mar 2026 14:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 14:42:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 15 Mar 2026 09:42:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jerry Zuo <jerry.zuo@amd.com>, Sun peng Li
 <sunpeng.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add clk_mgr NULL checks in
 dcn32_initialize_min_clocks()
Date: Sun, 15 Mar 2026 20:11:54 +0530
Message-ID: <20260315144154.1935224-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 686336c9-4de5-4daf-b651-08de82a109fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: v5S5N8yNC9UEStnGYAgFaCqPGaYppZvn0+bxDlBrdyYHCRfFAKB/y073rXtcb3OGhb4A7+nm/AvV40U+LPCQXcjYATMATeG6YFz0bffiy22S6wNmE3g0TKogeUJ1rEpMf4zENzR21EXLKoVZ5xvJxrKlkvar26XitcZqnAvtHZdlOcq3NOVb1lCYhzDKSS3pNOJ3fvMxTSh+wXN7r7aZEYHvnEeiA+SOvLiEMAoPaJeBLa32ZYPVlUNJCPPvPfcnuOTtGqF4dfCzrMQoqGaACR4R17K1bN8y60BwITczBYvQO+RXZ8/0S/wK3DYsEnqmnIAK9UDS6OmfMchW8f5sBviiFXKjdeINYY1liNI+u6i0NLpEudRbbgzxYh0UixVyj1jCU1RvJBSn4/NUQkqfyyREyHiCvX33jpxIupaK10ci1bi5d5YD1tb2FU9+jx/hGEVtG+eDpYwYkANPNit9HTuO13d2nc/Z/JSqk2KCpcOCnpG+g1EQf2caIXLoRcp7guEpQN6yFvk0J6l9/HUR64HVElQnJ9m3DHL8CXKEzJo40ZSvnVFFLNN214C6xcrKQxUwEgIOtnJxkGyvX8gM5QgEqLw/4pmSpH2zSzmU+Ar7MO3j23EIn+7ptS+XsGMhGNGwUpPx3FyyGuvPRVqBmLfa1YMUGJqiyljVRHRHWVD4S8p8OxvL523ZWknZ1al+QMFu9165UaBMJpXB/zA4y88rTdclShcQT2y84tUooYB01NRfu7ZVm1BLq/+8ivpIQtsvVcQvSypyzhkpGgeAHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EhLJQtu3MZgLHplyveLx3cjOaeSPHeiinayqDSsTnmsfvk5DNOKKE+yrWsLMgCn8Lb0bKNl85tTIIRldLnmXEkpC0OPZKLkah5TseDuHluej3jFDdPogo6s2c1Oy0iidSREBg9Ac1wGlMrpKg+56fodtHbL/WqZPmbQ/RZGAda9cV43kdWe+Pe7fegs4cfUJ3al9blg/HMxC1O9f0zh3/tS4pGfQgEyhJZzUHVYMgVdUUomT1p/PcA9n1UGrtsQNBbRsE4p+/NnHEik9Bf0xa8NpjDJDzL40Vdc7JtoZr9ohJo3qvOEm2IUmfwvs+/CE1y0i/WPaex0ecuu0uQzrYEnexZTFonK1D4KXVaKeNRlYzc0N/hDS3lTl+lDHnDP0U8oAXoN3wI/GdVotbQ9vn0njZYsgq/8GQipCMDg1K5rTYsOACteIYxvEE2ZPyYoY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 14:42:10.1339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686336c9-4de5-4daf-b651-08de82a109fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dcn32_init_hw() checks dc->clk_mgr before calling init_clocks(), so the
clock manager is not treated as unconditionally present on this path.
However, dcn32_initialize_min_clocks() later dereferences dc->clk_mgr,
bw_params, and clk_mgr callbacks without validating them.

Add the required guards in dcn32_initialize_min_clocks() before
accessing clk_mgr-dependent state, and check callback presence before
calling get_dispclk_from_dentist() and update_clocks().

Also guard the later update_bw_bounding_box() call in the FAMS2-disabled
path since it also dereferences dc->clk_mgr->bw_params.

This keeps clk_mgr handling consistent in the DCN32 HW init flow and
avoids possible NULL pointer dereferences reported by Smatch.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:1012 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 978)

Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Sun peng Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a0aaa727e9fa..e5d93dd348dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -757,6 +757,9 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
 {
 	struct dc_clocks *clocks = &dc->current_state->bw_ctx.bw.dcn.clk;
 
+	if (!dc->clk_mgr || !dc->clk_mgr->bw_params || !dc->clk_mgr->funcs)
+		return;
+
 	clocks->dcfclk_deep_sleep_khz = DCN3_2_DCFCLK_DS_INIT_KHZ;
 	clocks->dcfclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz * 1000;
 	clocks->socclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].socclk_mhz * 1000;
@@ -765,9 +768,10 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
 	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
 	clocks->fclk_p_state_change_support = true;
 	clocks->p_state_change_support = true;
+
 	if (dc->debug.disable_boot_optimizations) {
 		clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
-	} else {
+	} else if (dc->clk_mgr->funcs->get_dispclk_from_dentist) {
 		/* Even though DPG_EN = 1 for the connected display, it still requires the
 		 * correct timing so we cannot set DISPCLK to min freq or it could cause
 		 * audio corruption. Read current DISPCLK from DENTIST and request the same
@@ -776,10 +780,10 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
 		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
 	}
 
-	dc->clk_mgr->funcs->update_clocks(
-			dc->clk_mgr,
-			dc->current_state,
-			true);
+	if (dc->clk_mgr->funcs->update_clocks)
+		dc->clk_mgr->funcs->update_clocks(dc->clk_mgr,
+						  dc->current_state,
+						  true);
 }
 
 void dcn32_init_hw(struct dc *dc)
@@ -1007,7 +1011,8 @@ void dcn32_init_hw(struct dc *dc)
 				DMUB_FW_VERSION(7, 0, 35)) {
 			/* FAMS2 is disabled */
 			dc->debug.fams2_config.bits.enable = false;
-			if (dc->debug.using_dml2 && dc->res_pool->funcs->update_bw_bounding_box) {
+			if (dc->debug.using_dml2 && dc->res_pool->funcs->update_bw_bounding_box &&
+			    dc->clk_mgr && dc->clk_mgr->bw_params) {
 				/* update bounding box if FAMS2 disabled */
 				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 			}
-- 
2.34.1

