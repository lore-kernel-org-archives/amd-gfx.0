Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B0DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3052C12A7DA;
	Thu, 30 Jun 2022 18:46:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7155C12A756
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwu2myJcD8ITZQLj1KRh+8E4WecDtMh0I8r772G7Ucc8/C5unFTlD3M8Neirlkm/epOtfsXRLfEJTa1k0TAjNvHQ3RQQQ/snt+FNGNfdxqZHzNeBM2uM9XqPPJsTgIEzjGcKj/+DFX1HL9bhHbmhnz8hTiTgppRkx1+krGsWKsggGhwRqJ1r0iUuqP/5DWeZorVSPP5WRvNnAgwvLp7FzyhmSEwyjacLmoBRhpce8c2x/1jQ9XVJnLv3TNGwuOBun/an7SN/IR2dl06hpj+81CRI9vKXKMCUmArzFB46VqrEGd6ubMuK/DXIg4ZeQ6DjhS1rCoAiAGLtRRzCjHZwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdQgiT87LltjEeJavb1fTOK5zwqt9QeD1asoBdZHCcA=;
 b=LW2QLatbsyMlcC5eHPefuyVpoBiaTTmSlJAeQvU/N9JJvplrK85yGD1dJ37WlA/50O4EosILsS3xtDMCuBYwgThP41HnrIsnkUpPY7qMKZIvJXjlODb9KbVLm3zoHDlkhhao9RXnZZbN4qwNpa8isDfadk+YOJLx74cJBvZiihn0/QVoLghuOp8+xAZXgyjZnKCBn5UVyN/+TvvWHvBf21xLgZpD4azJmvXp7pNRxQcL3341FfmTjU2LGZXtuYPwrg+oQvxcPVIz6kpeLhe+67X2B5dyg7WDQAID8PmxdtG8U++6POpIxkLLaCwRu8ITYMYshcyMcnKS6v9ifue5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdQgiT87LltjEeJavb1fTOK5zwqt9QeD1asoBdZHCcA=;
 b=aSZtUiZjONuiXB7SkK24XJyfJj/m3zOMgNVa5AbtcWDyuE/p0FQdDHxPy4lpgpVn0uTMXvIzvbvtOjqWSqSNKGIDFHZKhtVBoMsYQSDRJJXsGoLMdU65Ul3gFgEbxKUlaWQegYHui/qpge75PQK5dKueyKXlemeDaKlrR5M9p88=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 18:46:39 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::52) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 18:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 18:46:39 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 13:46:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Randy Dunlap <rdunlap@infradead.org>, Leo Li <sunpeng.li@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Fix __nedf2 undefined for 32 bit
 compilation
Date: Thu, 30 Jun 2022 14:46:21 -0400
Message-ID: <20220630184621.874253-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
References: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cef90dd-c92b-4a13-d468-08da5ac8de33
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBDVdzWwkdy3Kx31rUHn1L7XO2HraAggQ3o/oIEZo9Kj0X3QOOFC0Sh8Bbygw1RfKhvfbceyJ0YleY/1EgsPtU8IKxs40aynKZVNDYeGFxbwXxr94tTsdIZVvvyCzjBP7el01G8VG6hs6tR79wiYqUcQW6VWWkTg1frofyAXv0yFz5THyQGJ47RefsNAzEbczQyGc7D0SvWbNEm5+kKpww81A3GLyUfkZ3tW/h6KS4Z20/WR3N7wejDJLZo73yTkxyjP/PmDpSGe+xVQaGqgRgHDqFFQyo6uWsGuD4gnDCALBfEajiRyi/Lc9M1Psz0uBIx7gU4g84l+XW3E3jfWj6MAbiG+zPoHKGc3I+WK6c5NKHFsz4usNpSWUyLxKEw0EOteBE35p/pxeHRxrvPMCap/pcCyU+XJtLltBf4DkwV+iB8iz6c4MROlAV6+nWtk9gv32eLFA67S0JDLU4iUqno4qcS5Iav11rHxX/mm7gikqvN2YdyGHrtdtCBlgBt9nMCNpnLwLKCbaQm/8+f13EoEyFUMOaqQVOkwvZXqD3vDIeW+GhUxIvuzh+/oTF5pNURBAuoJUAM1mocaCVhPw5ZVB3+ZP3zWLX3roq3K2An1aeT9Eg+VEYBaGIn7W7ZvuvhrA5kvd4Z6HmEwtS92XBO2ADnnR2l2B1KRDRekhpK+SgU0YdlTSU5oeleRA1f3SmACOeBZ7htDDJyfcjWc1CPGl/oA9WkamX7kH6LSN6tC096CPRUgStNYXtESJfM1xBuu5On/T5Oe/qptcBqyr+/VfpJEEObhANWVCvu45rtzFdTLn1v2ecEy18ioIFQNk+Sd4CLm0mUEYva1R3LGQCtzCSeOsjvWI6bNAnG1FGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(40470700004)(36840700001)(46966006)(70586007)(8936002)(336012)(82310400005)(86362001)(5660300002)(16526019)(186003)(26005)(426003)(110136005)(6666004)(2906002)(70206006)(36756003)(83380400001)(356005)(7696005)(4326008)(478600001)(81166007)(6636002)(54906003)(40460700003)(47076005)(1076003)(36860700001)(2616005)(8676002)(40480700001)(41300700001)(316002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:46:39.3463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cef90dd-c92b-4a13-d468-08da5ac8de33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3375
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we tried to compile DCN32/321 for 32-bit architecture, we got this
error message:

ERROR: modpost: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

This commit fixes this issue by rewriting a small part of the
dcn32_build_wm_range_table.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Fixes: 9b79abf79c414 ("drm/amd/display: add CLKMGR changes for DCN32/321")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index b49a4e34d39b..1edb5aab8990 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -155,10 +155,14 @@ static void dcn32_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
 	uint16_t min_uclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz;
 	uint16_t min_dcfclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
 	uint16_t setb_min_uclk_mhz		= min_uclk_mhz;
-	uint16_t setb_min_dcfclk_mhz	= min_dcfclk_mhz;
+	uint16_t dcfclk_mhz_for_the_second_state = clk_mgr->base.ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz;
+
 	/* For Set B ranges use min clocks state 2 when available, and report those to PM FW */
-	if (clk_mgr->base.ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz)
-		setb_min_dcfclk_mhz = clk_mgr->base.ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz;
+	if (dcfclk_mhz_for_the_second_state)
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = dcfclk_mhz_for_the_second_state;
+	else
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
+
 	if (clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz)
 		setb_min_uclk_mhz = clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz;
 
@@ -181,7 +185,6 @@ static void dcn32_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us = sr_exit_time_us;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = setb_min_dcfclk_mhz;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_dcfclk = 0xFFFF;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_uclk = setb_min_uclk_mhz;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_uclk = 0xFFFF;
-- 
2.25.1

