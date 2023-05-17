Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F8C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D1F10E400;
	Wed, 17 May 2023 11:40:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BA710E400
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJNLSnzFvykXs5jDkEfUPhoHu7OkQkOKXZd2sRYSXCYlTZcc2pdTpiuoUpfLZbWlPAYme3oz17KqW2kXGoGYk3YBuV9+oZpXzGTmTKZ8RsW9HqT2TkCMlf8unEuJv26W/Ol5hkV/UFZi1fJixCr5bGc/CzIY6vQhg7Zl+foAa4y8NuHYWBgbv5P9FBMpFW++BAleeGTYgR+gTfwqo65DV+IDwvoVEr4IPCstqas0oyTBvQQTzYKMkc1Gas0tE8qW9fBAw9x4lf0BYriCCgUXFEsDYCw0xNXBVKBAe7fS8J6u3/GiJt+OVWEw40CbDpxZy4X26OW3nPp1QUe1//qRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MksdOzyoVm3s2jMozlhCJ25HbHvuL2MVNYWLSMZgU74=;
 b=X9IVFBpd9P0xtVgML/LYIc8Dvr1x7dzwNiyPKLQjkpW6Xag1LgDvN/Ts+2G8cuUI1xAWgxd7uv5KTp63M1ziq4TKJwfcWL20ISItkk7EHGWeoWtt140kQkw6hT3wOhIB6sA5FXomcUAJV6T5vbM8Q5e0yBoEkgOeRE1qiBHz9ylr4p7m3w2R064cSFqas0PDno+GsuUmmEH598limDrsOI2sdDC+shWC31qzqKqvP1shfOgCf+dheyJLS5qcpWSUtAHI90cDwzoFb8NW6G4xTxojy0k3NPB15xmkxGUGonJ654saTnAnnKn24juaCLmtEP5Et6UhdGGWZzTNmXWd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MksdOzyoVm3s2jMozlhCJ25HbHvuL2MVNYWLSMZgU74=;
 b=oBGGXNHMEyGFAJm6TilA00GqxH8Cjv6MJ1v9QV5UxTemODGO5ISUJbzMCSs8hVvJ84IwcTYGC8CiJNvLl+uoPQjDMKExK5IvcnFO1AEAYwwDhFChlxhN3PDFK9b5PCYFtkG0piNCOcJUK/ri8rcYI48AW6S4v+iUKcFGc4iBxoo=
Received: from BN9P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::19)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 11:40:25 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::4b) by BN9P223CA0014.outlook.office365.com
 (2603:10b6:408:10b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:40:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:40:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:40:06 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:40:02 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/18] drm/amd/display: Clean FPGA code in dc
Date: Wed, 17 May 2023 19:37:18 +0800
Message-ID: <20230517113723.1757259-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c4f54f-5c94-4574-e719-08db56cb811d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRH0073inU+dphCCietyA0fCgMVecvBXYPw4v0C8trPR1WsPPY1diQlA94CTjmRVDEsU66RWMGCGxzgVwutm4kj2PtcuG64uMH/0aZ+zztAPqq/T+5aoBSG+OLXl0aRtYjUXEBeKjlWxaQgAmHbFvzBAXccg8HrN4ZH7BrnOMvvvzVefi+gW4lROmeB7ZCz3DRTVIfzWGyU+ibflAB+xpWhEbkAbI13UnxLSx8egC1ZwlQ/fk5b6tN8pBteMUMrPqh8rUr3qAI7F7o3sCevyrlG/O1R90ba8y0wpqLK2q3Jqvj1YObl7i6VPFAul76f3fo7xGGW+dHGgQd2XLVNzQLlyYX1pLt2vhgG7dFEF/I3jc7qwU9Gg2Ivlb8wXeVSt6N8yiW7QMrGuud5NWqqoW6TRQfwCGDGd4+ytp9JYyW5VPeccQ7cGHOPLdnsz3LH0bHCS2J47wlXdAPGV14z087C3dq4G1BvTLzynS8G4MT60fa9PMtaY2yjHiIMKTJ0GbscG0Vhu0W8E96Y4C9RmZIhgRtKMz7cT+JBi3oJHDMjd0z0k+zl93l+md00PQy5RAuzv59LNKGIRF8pMRkYk9ftvBmslDrOBfIoK7aO0LjsnhchtEprCyDkYgTYDZA3yUl91iTz57r6JJ6W4ol4mlX9cGWv+SbjBk1QhqmdjSsbkypljc1PcfbliS16MHBGASMOgFzRvXCx3BvILznHjWFAwW5ccPoNkStwgvE8c8x2qgANn6kwQr9tGavw+yDdxS/CA/V3GAS+OKpohp+0nCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(47076005)(426003)(336012)(478600001)(7696005)(54906003)(2616005)(6666004)(1076003)(26005)(186003)(2906002)(30864003)(8936002)(8676002)(5660300002)(36756003)(40460700003)(41300700001)(81166007)(356005)(82740400003)(6916009)(4326008)(40480700001)(70206006)(70586007)(82310400005)(86362001)(316002)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:40:24.7158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c4f54f-5c94-4574-e719-08db56cb811d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <eric.bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
Drop dead code for Linux.

[How]
Remove all IS_FPGA_MAXIMUS_DC and IS_DIAG_DC

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  8 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |  2 -
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 22 +++---
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  6 --
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 13 +---
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  5 --
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 10 +--
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 18 +----
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 10 +--
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 10 +--
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 10 +--
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        | 11 +--
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 30 --------
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  7 --
 .../drm/amd/display/dc/dce/dce_clock_source.c | 38 ----------
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  2 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |  3 -
 .../display/dc/dce112/dce112_hw_sequencer.c   |  3 -
 .../display/dc/dce120/dce120_hw_sequencer.c   |  3 -
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +--------
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  2 -
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  5 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  5 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  4 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 15 +---
 .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  | 20 +----
 .../drm/amd/display/dc/dcn201/dcn201_optc.c   |  1 -
 .../amd/display/dc/dcn201/dcn201_resource.c   |  5 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  4 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 10 +--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 28 -------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  4 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  8 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   | 10 +--
 .../amd/display/dc/dcn302/dcn302_resource.c   |  5 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |  5 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 31 +-------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  4 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 17 +----
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  4 -
 .../amd/display/dc/dcn314/dcn314_resource.c   | 10 +--
 .../amd/display/dc/dcn315/dcn315_resource.c   | 17 +----
 .../amd/display/dc/dcn316/dcn316_resource.c   | 17 +----
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  4 -
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 11 +--
 .../amd/display/dc/dcn321/dcn321_resource.c   | 11 +--
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |  2 -
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 17 +----
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  8 --
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  6 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |  8 --
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  4 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  4 -
 .../drm/amd/display/dc/dml/display_mode_lib.c |  1 -
 .../drm/amd/display/dc/dml/display_mode_lib.h |  1 -
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   | 73 -------------------
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 35 +++------
 .../dc/link/protocols/link_dp_capability.c    |  3 +-
 63 files changed, 78 insertions(+), 597 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index 934e6423dc1a..734ac929ff12 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -111,13 +111,11 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 
 	bp->funcs->set_dce_clock(bp, &dce_clk_params);
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 			if (clk_mgr_dce->dfs_bypass_disp_clk != actual_clock)
 				dmcu->funcs->set_psr_wait_loop(dmcu,
 						actual_clock / 1000 / 7);
 		}
-	}
 
 	clk_mgr_dce->dfs_bypass_disp_clk = actual_clock;
 	return actual_clock;
@@ -149,17 +147,15 @@ int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
 	 * from power down, we need mark the clock state as ClocksStateNominal
 	 * from HWReset, so when resume we will call pplib voltage regulator.
 	 */
-	if (requested_clk_khz == 0)
+	if (requested_clk_khz == 0) {
 		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
+	}
 
-
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 			if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
 				dmcu->funcs->set_psr_wait_loop(dmcu,
 						actual_clock / 1000 / 7);
 		}
-	}
 
 	clk_mgr->dfs_bypass_disp_clk = actual_clock;
 	return actual_clock;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
index 450eaead4f20..7d9272165673 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
@@ -135,13 +135,11 @@ int rv1_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_di
 			VBIOSSMC_MSG_SetDispclkFreq,
 			khz_to_mhz_ceil(requested_dispclk_khz));
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 			if (clk_mgr->dfs_bypass_disp_clk != actual_dispclk_set_mhz)
 				dmcu->funcs->set_psr_wait_loop(dmcu,
 						actual_dispclk_set_mhz / 7);
 		}
-	}
 
 	return actual_dispclk_set_mhz * 1000;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 650f3b4b562e..2bc74820b4d0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -531,6 +531,11 @@ void dcn20_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	int dprefclk_did;
+	int target_div;
+	uint32_t pll_req_reg;
+	struct fixed31_32 pll_req;
+
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->pp_smu = pp_smu;
 	clk_mgr->base.funcs = &dcn2_funcs;
@@ -547,19 +552,12 @@ void dcn20_clk_mgr_construct(
 
 	clk_mgr->base.dprefclk_khz = 700000; // 700 MHz planned if VCO is 3.85 GHz, will be retrieved
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		dcn2_funcs.update_clocks = dcn2_update_clocks_fpga;
-		clk_mgr->base.dentist_vco_freq_khz = 3850000;
-
-	} else {
 		/* DFS Slice 2 should be used for DPREFCLK */
-		int dprefclk_did = REG_READ(CLK3_CLK2_DFS_CNTL);
-		/* Convert DPREFCLK DFS Slice DID to actual divider*/
-		int target_div = dentist_get_divider_from_did(dprefclk_did);
-
+		dprefclk_did = REG_READ(CLK3_CLK2_DFS_CNTL);
+		/* Convert DPREFCLK DFS Slice DID to actual divider */
+		target_div = dentist_get_divider_from_did(dprefclk_did);
 		/* get FbMult value */
-		uint32_t pll_req_reg = REG_READ(CLK3_CLK_PLL_REQ);
-		struct fixed31_32 pll_req;
+		pll_req_reg = REG_READ(CLK3_CLK_PLL_REQ);
 
 		/* set up a fixed-point number
 		 * this works because the int part is on the right edge of the register
@@ -582,7 +580,6 @@ void dcn20_clk_mgr_construct(
 		/* Calculate the DPREFCLK in kHz.*/
 		clk_mgr->base.dprefclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
-	}
 	//Integrated_info table does not exist on dGPU projects so should not be referenced
 	//anywhere in code for dGPUs.
 	//Also there is no plan for now that DFS BYPASS will be used on NV10/12/14.
@@ -590,4 +587,3 @@ void dcn20_clk_mgr_construct(
 
 	dce_clock_read_ss_info(clk_mgr);
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index 811720749faf..bb735ebb6092 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -190,11 +190,6 @@ void dcn201_clk_mgr_construct(struct dc_context *ctx,
 	clk_mgr->dprefclk_ss_divider = 1000;
 	clk_mgr->ss_on_dprefclk = false;
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		dcn201_funcs.update_clocks = dcn2_update_clocks_fpga;
-		clk_mgr->base.dprefclk_khz = 600000;
-		clk_mgr->base.dentist_vco_freq_khz = 3000000;
-	} else {
 		clk_mgr->base.dprefclk_khz = REG_READ(CLK4_CLK2_CURRENT_CNT);
 		clk_mgr->base.dprefclk_khz *= 100;
 
@@ -206,7 +201,6 @@ void dcn201_clk_mgr_construct(struct dc_context *ctx,
 
 		if (clk_mgr->base.dentist_vco_freq_khz == 0)
 			clk_mgr->base.dentist_vco_freq_khz = 3000000;
-	}
 
 	if (!debug->disable_dfs_bypass && bp->integrated_info)
 		if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index bd9fd0b54f46..a5140a0783a2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -705,6 +705,7 @@ void rn_clk_mgr_construct(
 	struct dpm_clocks clock_table = { 0 };
 	enum pp_smu_status status = 0;
 	int is_green_sardine = 0;
+	struct clk_log_info log_info = {0};
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
 	is_green_sardine = ASICREV_IS_GREEN_SARDINE(ctx->asic_id.hw_internal_rev);
@@ -725,12 +726,6 @@ void rn_clk_mgr_construct(
 
 	clk_mgr->smu_ver = rn_vbios_smu_get_smu_version(clk_mgr);
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		dcn21_funcs.update_clocks = dcn2_update_clocks_fpga;
-		clk_mgr->base.dentist_vco_freq_khz = 3600000;
-	} else {
-		struct clk_log_info log_info = {0};
-
 		clk_mgr->periodic_retraining_disabled = rn_vbios_smu_is_periodic_retraining_disabled(clk_mgr);
 
 		/* SMU Version 55.51.0 and up no longer have an issue
@@ -766,7 +761,6 @@ void rn_clk_mgr_construct(
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
-	}
 
 	clk_mgr->base.dprefclk_khz = 600000;
 	dce_clock_read_ss_info(clk_mgr);
@@ -786,9 +780,8 @@ void rn_clk_mgr_construct(
 		}
 	}
 
-	if (!IS_FPGA_MAXIMUS_DC(ctx->dce_environment) && clk_mgr->smu_ver >= 0x00371500) {
-		/* enable powerfeatures when displaycount goes to 0 */
+	/* enable powerfeatures when displaycount goes to 0 */
+	if (clk_mgr->smu_ver >= 0x00371500)
 		rn_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(clk_mgr, !debug->disable_48mhz_pwrdwn);
-	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 27fbe906682f..50460d7ab5c7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -147,16 +147,13 @@ int rn_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dis
 			VBIOSSMC_MSG_SetDispclkFreq,
 			khz_to_mhz_ceil(requested_dispclk_khz));
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 			if (clk_mgr->dfs_bypass_disp_clk != actual_dispclk_set_mhz)
 				dmcu->funcs->set_psr_wait_loop(dmcu,
 						actual_dispclk_set_mhz / 7);
 		}
-	}
 
 	// pmfw always set clock more than or equal requested clock
-	if (!IS_DIAG_DC(dc->ctx->dce_environment))
 		ASSERT(actual_dispclk_set_mhz >= khz_to_mhz_ceil(requested_dispclk_khz));
 
 	return actual_dispclk_set_mhz * 1000;
@@ -221,14 +218,12 @@ void rn_vbios_smu_set_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phy
 int rn_vbios_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_khz)
 {
 	int actual_dppclk_set_mhz = -1;
-	struct dc *dc = clk_mgr->base.ctx->dc;
 
 	actual_dppclk_set_mhz = rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDppclkFreq,
 			khz_to_mhz_ceil(requested_dpp_khz));
 
-	if (!IS_DIAG_DC(dc->ctx->dce_environment))
 		ASSERT(actual_dppclk_set_mhz >= khz_to_mhz_ceil(requested_dpp_khz));
 
 	return actual_dppclk_set_mhz * 1000;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 3908e7cfd6cb..3ac4c03b3543 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -521,6 +521,8 @@ void dcn3_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	struct clk_state_registers_and_bypass s = { 0 };
+
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn3_funcs;
 	clk_mgr->regs = &clk_mgr_regs;
@@ -537,13 +539,6 @@ void dcn3_clk_mgr_construct(
 
 	clk_mgr->base.dprefclk_khz = 730000; // 700 MHz planned if VCO is 3.85 GHz, will be retrieved
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		clk_mgr->base.funcs  = &dcn3_fpga_funcs;
-		clk_mgr->base.dentist_vco_freq_khz = 3650000;
-
-	} else {
-		struct clk_state_registers_and_bypass s = { 0 };
-
 		/* integer part is now VCO frequency in kHz */
 		clk_mgr->base.dentist_vco_freq_khz = dcn30_get_vco_frequency_from_reg(clk_mgr);
 
@@ -557,7 +552,6 @@ void dcn3_clk_mgr_construct(
 		//ASSERT(s.dprefclk != 0);
 		if (s.dprefclk != 0)
 			clk_mgr->base.dprefclk_khz = s.dprefclk * 1000;
-	}
 
 	clk_mgr->dfs_bypass_enabled = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 01383aac6b41..742a697074a9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -117,7 +117,7 @@ static void vg_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			display_count = vg_get_active_display_cnt_wa(dc, context);
 			/* if we can go lower, go lower */
-			if (display_count == 0 && !IS_DIAG_DC(dc->ctx->dce_environment)) {
+			if (display_count == 0) {
 				union display_idle_optimization_u idle_info = { 0 };
 
 				idle_info.idle_info.df_request_disabled = 1;
@@ -151,10 +151,8 @@ static void vg_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		if (new_clocks->dppclk_khz < 100000)
 			new_clocks->dppclk_khz = 100000;
-	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
@@ -664,6 +662,7 @@ void vg_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct smu_dpm_clks smu_dpm_clks = { 0 };
+	struct clk_log_info log_info = {0};
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &vg_funcs;
@@ -703,12 +702,6 @@ void vg_clk_mgr_construct(
 
 	ASSERT(smu_dpm_clks.dpm_clks);
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		vg_funcs.update_clocks = dcn2_update_clocks_fpga;
-		clk_mgr->base.base.dentist_vco_freq_khz = 3600000;
-	} else {
-		struct clk_log_info log_info = {0};
-
 		clk_mgr->base.smu_ver = dcn301_smu_get_smu_version(&clk_mgr->base);
 
 		if (clk_mgr->base.smu_ver)
@@ -728,7 +721,6 @@ void vg_clk_mgr_construct(
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		vg_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
-	}
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
@@ -746,12 +738,6 @@ void vg_clk_mgr_construct(
 	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
 		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
 				smu_dpm_clks.dpm_clks);
-/*
-	if (!IS_FPGA_MAXIMUS_DC(ctx->dce_environment) && clk_mgr->base.smu_ver) {
-		 enable powerfeatures when displaycount goes to 0
-		dcn301_smu_enable_phy_refclk_pwrdwn(clk_mgr, !debug->disable_48mhz_pwrdwn);
-	}
-*/
 }
 
 void vg_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 3c743cd3d3f0..5e78e8c3ce7b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -205,10 +205,8 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		if (new_clocks->dppclk_khz < 100000)
 			new_clocks->dppclk_khz = 100000;
-	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
@@ -672,6 +670,7 @@ void dcn31_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dcn31_smu_dpm_clks smu_dpm_clks = { 0 };
+	struct clk_log_info log_info = {0};
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn31_funcs;
@@ -711,11 +710,6 @@ void dcn31_clk_mgr_construct(
 
 	ASSERT(smu_dpm_clks.dpm_clks);
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		clk_mgr->base.base.funcs = &dcn3_fpga_funcs;
-	} else {
-		struct clk_log_info log_info = {0};
-
 		clk_mgr->base.smu_ver = dcn31_smu_get_smu_version(&clk_mgr->base);
 
 		if (clk_mgr->base.smu_ver)
@@ -733,8 +727,6 @@ void dcn31_clk_mgr_construct(
 		dcn31_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 					 &clk_mgr->base.base, &log_info);
 
-	}
-
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 2a0c696f5861..46007ed49509 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -241,10 +241,8 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		if (new_clocks->dppclk_khz < 100000)
 			new_clocks->dppclk_khz = 100000;
-	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
@@ -724,6 +722,7 @@ void dcn314_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dcn314_smu_dpm_clks smu_dpm_clks = { 0 };
+	struct clk_log_info log_info = {0};
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn314_funcs;
@@ -763,11 +762,6 @@ void dcn314_clk_mgr_construct(
 
 	ASSERT(smu_dpm_clks.dpm_clks);
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		clk_mgr->base.base.funcs = &dcn3_fpga_funcs;
-	} else {
-		struct clk_log_info log_info = {0};
-
 		clk_mgr->base.smu_ver = dcn314_smu_get_smu_version(&clk_mgr->base);
 
 		if (clk_mgr->base.smu_ver)
@@ -785,8 +779,6 @@ void dcn314_clk_mgr_construct(
 		dcn314_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 					  &clk_mgr->base.base, &log_info);
 
-	}
-
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 300c6a5872d0..b3f4920c994b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -184,12 +184,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		if (new_clocks->dppclk_khz < MIN_DPP_DISP_CLK)
 			new_clocks->dppclk_khz = MIN_DPP_DISP_CLK;
 		if (new_clocks->dispclk_khz < MIN_DPP_DISP_CLK)
 			new_clocks->dispclk_khz = MIN_DPP_DISP_CLK;
-	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
@@ -600,6 +598,7 @@ void dcn315_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dcn315_smu_dpm_clks smu_dpm_clks = { 0 };
+	struct clk_log_info log_info = {0};
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn315_funcs;
@@ -639,11 +638,6 @@ void dcn315_clk_mgr_construct(
 
 	ASSERT(smu_dpm_clks.dpm_clks);
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		clk_mgr->base.base.funcs = &dcn3_fpga_funcs;
-	} else {
-		struct clk_log_info log_info = {0};
-
 		clk_mgr->base.smu_ver = dcn315_smu_get_smu_version(&clk_mgr->base);
 
 		if (clk_mgr->base.smu_ver > 0)
@@ -658,8 +652,6 @@ void dcn315_clk_mgr_construct(
 		dcn315_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 					  &clk_mgr->base.base, &log_info);
 
-	}
-
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 538126cefd4d..67db818b1246 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -207,12 +207,10 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		if (new_clocks->dppclk_khz < 100000)
 			new_clocks->dppclk_khz = 100000;
 		if (new_clocks->dispclk_khz < 100000)
 			new_clocks->dispclk_khz = 100000;
-	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
@@ -616,6 +614,7 @@ void dcn316_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dcn316_smu_dpm_clks smu_dpm_clks = { 0 };
+	struct clk_log_info log_info = {0};
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn316_funcs;
@@ -655,12 +654,6 @@ void dcn316_clk_mgr_construct(
 
 	ASSERT(smu_dpm_clks.dpm_clks);
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-		clk_mgr->base.base.funcs = &dcn3_fpga_funcs;
-		clk_mgr->base.base.dentist_vco_freq_khz = 2500000;
-	} else {
-		struct clk_log_info log_info = {0};
-
 		clk_mgr->base.smu_ver = dcn316_smu_get_smu_version(&clk_mgr->base);
 
 		if (clk_mgr->base.smu_ver > 0)
@@ -683,8 +676,6 @@ void dcn316_clk_mgr_construct(
 		dcn316_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 					  &clk_mgr->base.base, &log_info);
 
-	}
-
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn316_smu_get_dpref_clk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 1df623b298a9..20bff6a346ba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -941,7 +941,6 @@ void dcn32_clk_mgr_construct(
 			clk_mgr->base.clks.ref_dtbclk_khz = 268750;
 	}
 
-
 	/* integer part is now VCO frequency in kHz */
 	clk_mgr->base.dentist_vco_freq_khz = dcn32_get_vco_frequency_from_reg(clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 32bc268a7138..7109344c3bc3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3588,7 +3588,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		for (i = 0; i < surface_count; i++) {
 			struct dc_plane_state *plane_state = srf_updates[i].surface;
 			/*set logical flag for lock/unlock use*/
@@ -3611,7 +3610,6 @@ static void commit_planes_for_stream(struct dc *dc,
 				plane_state->flip_immediate = false;
 			}
 		}
-	}
 
 	// Update Type FULL, Surface updates
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 72b261ad9587..0d3ec50b1385 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -490,25 +490,6 @@ bool dc_stream_add_writeback(struct dc *dc,
 		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 		dwb->otg_inst = stream_status->primary_otg_inst;
 	}
-	if (IS_DIAG_DC(dc->ctx->dce_environment)) {
-		if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
-			dm_error("DC: update_bandwidth failed!\n");
-			return false;
-		}
-
-		/* enable writeback */
-		if (dc->hwss.enable_writeback) {
-			struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
-
-			if (dwb->funcs->is_enabled(dwb)) {
-				/* writeback pipe already enabled, only need to update */
-				dc->hwss.update_writeback(dc, wb_info, dc->current_state);
-			} else {
-				/* Enable writeback pipe from scratch*/
-				dc->hwss.enable_writeback(dc, wb_info, dc->current_state);
-			}
-		}
-	}
 	return true;
 }
 
@@ -553,17 +534,6 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	}
 	stream->num_wb_info = j;
 
-	if (IS_DIAG_DC(dc->ctx->dce_environment)) {
-		/* recalculate and apply DML parameters */
-		if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
-			dm_error("DC: update_bandwidth failed!\n");
-			return false;
-		}
-
-		/* disable writeback */
-		if (dc->hwss.disable_writeback)
-			dc->hwss.disable_writeback(dc, dwb_pipe_inst);
-	}
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 3db7a2e11af5..ceba3da85a6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -464,8 +464,7 @@ void generic_reg_wait(const struct dc_context *ctx,
 		field_value = get_reg_field_value_ex(reg_val, mask, shift);
 
 		if (field_value == condition_value) {
-			if (i * delay_between_poll_us > 1000 &&
-					!IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
+			if (i * delay_between_poll_us > 1000)
 				DC_LOG_DC("REG_WAIT taking a while: %dms in %s line:%d\n",
 						delay_between_poll_us * i / 1000,
 						func_name, line);
@@ -477,7 +476,6 @@ void generic_reg_wait(const struct dc_context *ctx,
 			delay_between_poll_us, time_out_num_tries,
 			func_name, line);
 
-	if (!IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
 		BREAK_TO_DEBUGGER();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 150c19286d67..6b4731b5e975 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -69,13 +69,6 @@ enum dce_environment {
 	DCE_ENV_VIRTUAL_HW
 };
 
-/* Note: use these macro definitions instead of direct comparison! */
-#define IS_FPGA_MAXIMUS_DC(dce_environment) \
-	(dce_environment == DCE_ENV_FPGA_MAXIMUS)
-
-#define IS_DIAG_DC(dce_environment) \
-	(IS_FPGA_MAXIMUS_DC(dce_environment) || (dce_environment == DCE_ENV_DIAG))
-
 struct dc_perf_trace {
 	unsigned long read_count;
 	unsigned long write_count;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 462c7a3ec3cc..ed8936405dfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -920,25 +920,6 @@ static bool dce112_program_pix_clk(
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 
-	if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
-		unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
-		unsigned dp_dto_ref_100hz = 7000000;
-		unsigned clock_100hz = pll_settings->actual_pix_clk_100hz;
-
-		/* Set DTO values: phase = target clock, modulo = reference clock */
-		REG_WRITE(PHASE[inst], clock_100hz);
-		REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
-
-		/* Enable DTO */
-		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
-			REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
-					DP_DTO0_ENABLE, 1,
-					PIPE0_DTO_SRC_SEL, 1);
-		else
-			REG_UPDATE(PIXEL_RATE_CNTL[inst],
-					DP_DTO0_ENABLE, 1);
-		return true;
-	}
 	/* First disable SS
 	 * ATOMBIOS will enable by default SS on PLL for DP,
 	 * do not disable it here
@@ -1015,25 +996,6 @@ static bool dcn31_program_pix_clk(
 			REG_UPDATE(PIXEL_RATE_CNTL[inst],
 					DP_DTO0_ENABLE, 1);
 	} else {
-		if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
-			unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
-			unsigned dp_dto_ref_100hz = 7000000;
-			unsigned clock_100hz = pll_settings->actual_pix_clk_100hz;
-
-			/* Set DTO values: phase = target clock, modulo = reference clock */
-			REG_WRITE(PHASE[inst], clock_100hz);
-			REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
-
-			/* Enable DTO */
-			if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
-				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
-						DP_DTO0_ENABLE, 1,
-						PIPE0_DTO_SRC_SEL, 1);
-			else
-				REG_UPDATE(PIXEL_RATE_CNTL[inst],
-						DP_DTO0_ENABLE, 1);
-			return true;
-		}
 
 		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
 			REG_UPDATE(PIXEL_RATE_CNTL[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index e74266cc0098..433f10bb839a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -1093,11 +1093,9 @@ static void dcn21_dmcu_construct(
 
 	dce_dmcu_construct(dmcu_dce, ctx, regs, dmcu_shift, dmcu_mask);
 
-	if (!IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
 		psp_version = dm_read_reg(ctx, mmMP0_SMN_C2PMSG_58);
 		dmcu_dce->base.auto_load_dmcu = ((psp_version & 0x00FF00FF) > 0x00110029);
 		dmcu_dce->base.psp_version = psp_version;
-	}
 }
 
 struct dmcu *dce_dmcu_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 1a0be40d125c..c6fe2c00aedb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -209,9 +209,6 @@ static bool dce110_enable_display_power_gating(
 	struct dc_context *ctx = dc->ctx;
 	unsigned int underlay_idx = dc->res_pool->underlay_pipe_index;
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
-		return true;
-
 	if (power_gating == PIPE_GATING_CONTROL_INIT)
 		cntl = ASIC_PIPE_INIT;
 	else if (power_gating == PIPE_GATING_CONTROL_ENABLE)
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
index 19873ee1f78d..690caaaff019 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
@@ -120,9 +120,6 @@ static bool dce112_enable_display_power_gating(
 	enum bp_pipe_control_action cntl;
 	struct dc_context *ctx = dc->ctx;
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
-		return true;
-
 	if (power_gating == PIPE_GATING_CONTROL_INIT)
 		cntl = ASIC_PIPE_INIT;
 	else if (power_gating == PIPE_GATING_CONTROL_ENABLE)
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
index d4afe6c824d2..45e08c4d5861 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
@@ -159,9 +159,6 @@ static bool dce120_enable_display_power_gating(
 	enum bp_pipe_control_action cntl;
 	struct dc_context *ctx = dc->ctx;
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
-		return true;
-
 	if (power_gating == PIPE_GATING_CONTROL_INIT)
 		cntl = ASIC_PIPE_INIT;
 	else if (power_gating == PIPE_GATING_CONTROL_ENABLE)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 905246a2ece4..05fbec58288f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1012,7 +1012,6 @@ static void dcn10_reset_back_end_for_pipe(
 		return;
 	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		link = pipe_ctx->stream->link;
 		/* DPMS may already disable or */
 		/* dpms_off status is incorrect due to fastboot
@@ -1038,7 +1037,6 @@ static void dcn10_reset_back_end_for_pipe(
 				pipe_ctx->stream_res.audio = NULL;
 			}
 		}
-	}
 
 	/* by upper caller loop, parent pipe: pipe0, will be reset last.
 	 * back end share by all pipes and will be disable only when disable
@@ -1499,28 +1497,6 @@ void dcn10_init_hw(struct dc *dc)
 	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->dccg_init)
 		dc->res_pool->dccg->funcs->dccg_init(res_pool->dccg);
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-
-		REG_WRITE(REFCLK_CNTL, 0);
-		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
-		REG_WRITE(DIO_MEM_PWR_CTRL, 0);
-
-		if (!dc->debug.disable_clock_gate) {
-			/* enable all DCN clock gating */
-			REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-			REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
-
-			REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
-		}
-
-		//Enable ability to power gate / don't force power on permanently
-		if (hws->funcs.enable_power_gating_plane)
-			hws->funcs.enable_power_gating_plane(hws, true);
-
-		return;
-	}
-
 	if (!dcb->funcs->is_accelerated_mode(dcb))
 		hws->funcs.disable_vga(dc->hwseq);
 
@@ -1532,7 +1508,6 @@ void dcn10_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 			if (res_pool->dccg && res_pool->hubbub) {
 
 				(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
@@ -1549,7 +1524,6 @@ void dcn10_init_hw(struct dc *dc)
 				res_pool->ref_clocks.dchub_ref_clock_inKhz =
 						res_pool->ref_clocks.xtalin_clock_inKhz;
 			}
-		}
 	} else
 		ASSERT_CRITICAL(false);
 
@@ -3067,10 +3041,10 @@ void dcn10_prepare_bandwidth(
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	int min_fclk_khz, min_dcfclk_khz, socclk_khz;
 
-	if (dc->debug.sanity_checks)
+	if (dc->debug.sanity_checks) {
 		hws->funcs.verify_allow_pstate_change_high(dc);
+	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (context->stream_count == 0)
 			context->bw_ctx.bw.dcn.clk.phyclk_khz = 0;
 
@@ -3078,7 +3052,6 @@ void dcn10_prepare_bandwidth(
 				dc->clk_mgr,
 				context,
 				false);
-	}
 
 	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
@@ -3107,10 +3080,10 @@ void dcn10_optimize_bandwidth(
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	int min_fclk_khz, min_dcfclk_khz, socclk_khz;
 
-	if (dc->debug.sanity_checks)
+	if (dc->debug.sanity_checks) {
 		hws->funcs.verify_allow_pstate_change_high(dc);
+	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (context->stream_count == 0)
 			context->bw_ctx.bw.dcn.clk.phyclk_khz = 0;
 
@@ -3118,7 +3091,6 @@ void dcn10_optimize_bandwidth(
 				dc->clk_mgr,
 				context,
 				true);
-	}
 
 	hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index c9e53dc49c92..23132803a035 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -653,8 +653,6 @@ void optc1_lock(struct timing_generator *optc)
 	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
 			OTG_MASTER_UPDATE_LOCK, 1);
 
-	/* Should be fast, status does not update on maximus */
-	if (optc->ctx->dce_environment != DCE_ENV_FPGA_MAXIMUS)
 		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 				UPDATE_LOCK_STATUS, 1,
 				1, 10);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 21ec1ba5ed75..a0625209c86d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1651,9 +1651,8 @@ static bool dcn10_resource_construct(
 	}
 
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto fail;
+			&res_create_funcs))
+		goto fail;
 
 	dcn10_hw_sequencer_construct(dc);
 	dc->caps.max_planes =  pool->base.pipe_count;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e74c3ce561ab..6d7ba98e7ebc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2480,7 +2480,6 @@ static void dcn20_reset_back_end_for_pipe(
 		return;
 	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		/* DPMS may already disable or */
 		/* dpms_off status is incorrect due to fastboot
 		 * feature. When system resume from S4 with second
@@ -2506,10 +2505,6 @@ static void dcn20_reset_back_end_for_pipe(
 				pipe_ctx->stream_res.audio = NULL;
 			}
 		}
-	}
-	else if (pipe_ctx->stream_res.dsc) {
-		dc->link_srv->set_dsc_enable(pipe_ctx, false);
-	}
 
 	/* by upper caller loop, parent pipe: pipe0, will be reset last.
 	 * back end share by all pipes and will be disable only when disable
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 4192c522e59a..e4b44e691ce6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -145,8 +145,4 @@ void dcn20_hw_sequencer_construct(struct dc *dc)
 	dc->hwss = dcn20_funcs;
 	dc->hwseq->funcs = dcn20_private_funcs;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->hwss.init_hw = dcn20_fpga_init_hw;
-		dc->hwseq->funcs.init_pipes = NULL;
-	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index a08c335b7383..2961528d22cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -391,7 +391,6 @@ void optc2_triplebuffer_lock(struct timing_generator *optc)
 	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
 		OTG_MASTER_UPDATE_LOCK, 1);
 
-	if (optc->ctx->dce_environment != DCE_ENV_FPGA_MAXIMUS)
 		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 				UPDATE_LOCK_STATUS, 1,
 				1, 10);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1d8c5805ef20..7dcae3183e07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2488,15 +2488,9 @@ static bool dcn20_resource_construct(
 
 	dc->caps.dp_hdmi21_pcon_support = true;
 
-	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
+	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	} else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		pool->base.pipe_count = 4;
-		pool->base.mpcc_count = pool->base.pipe_count;
-		dc->debug = debug_defaults_diags;
-	} else {
-		dc->debug = debug_defaults_diags;
-	}
+
 	//dcn2.0x
 	dc->work_arounds.dedcn20_305_wa = true;
 
@@ -2734,9 +2728,8 @@ static bool dcn20_resource_construct(
 	}
 
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	dcn20_hw_sequencer_construct(dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
index 75472d53ff52..6c6ac1a2544f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
@@ -228,26 +228,16 @@ void dcn201_init_hw(struct dc *dc)
 	if (res_pool->dccg->funcs->dccg_init)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
+	}
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
-		REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
-
-		hws->funcs.dccg_init(hws);
-
-		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
-		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
-		REG_WRITE(REFCLK_CNTL, 0);
-	} else {
 		hws->funcs.bios_golden_init(dc);
 
 		if (dc->ctx->dc_bios->fw_info_valid) {
 			res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-			if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 				if (res_pool->dccg && res_pool->hubbub) {
 					(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
 							dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
@@ -262,7 +252,6 @@ void dcn201_init_hw(struct dc *dc)
 					res_pool->ref_clocks.dchub_ref_clock_inKhz =
 							res_pool->ref_clocks.xtalin_clock_inKhz;
 				}
-			}
 		} else
 			ASSERT_CRITICAL(false);
 		for (i = 0; i < dc->link_count; i++) {
@@ -276,7 +265,6 @@ void dcn201_init_hw(struct dc *dc)
 		}
 		if (hws->fb_offset.quad_part == 0)
 			read_mmhub_vm_setup(hws);
-	}
 
 	/* Blank pixel data with OPP DPG */
 	for (i = 0; i < res_pool->timing_generator_count; i++) {
@@ -362,10 +350,6 @@ void dcn201_init_hw(struct dc *dc)
 		tg->funcs->tg_init(tg);
 	}
 
-	/* end of FPGA. Below if real ASIC */
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		return;
-
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
index 730875dfd8b4..c7be91458b2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
@@ -55,7 +55,6 @@ static void optc201_triplebuffer_lock(struct timing_generator *optc)
 	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
 		OTG_MASTER_UPDATE_LOCK, 1);
 
-	if (optc->ctx->dce_environment != DCE_ENV_FPGA_MAXIMUS)
 		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 				UPDATE_LOCK_STATUS, 1,
 				1, 10);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 6ea70da28aaa..212c475d95cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -1272,9 +1272,8 @@ static bool dcn201_resource_construct(
 	}
 
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	dcn201_hw_sequencer_construct(dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 8b58ce1db035..f024157bd6eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -151,8 +151,4 @@ void dcn21_hw_sequencer_construct(struct dc *dc)
 	dc->hwss = dcn21_funcs;
 	dc->hwseq->funcs = dcn21_private_funcs;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->hwss.init_hw = dcn20_fpga_init_hw;
-		dc->hwseq->funcs.init_pipes = NULL;
-	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 19aaa557b2db..76268a7b7934 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1503,11 +1503,6 @@ static bool dcn21_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		pool->base.pipe_count = 4;
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
 
 	// Init the vm_helper
 	if (dc->vm_helper)
@@ -1721,9 +1716,8 @@ static bool dcn21_resource_construct(
 	}
 
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	dcn21_hw_sequencer_construct(dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3303c9aae068..acc07a108ded 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -330,10 +330,6 @@ void dcn30_enable_writeback(
 	DC_LOG_DWB("%s dwb_pipe_inst = %d, mpcc_inst = %d",\
 		__func__, wb_info->dwb_pipe_inst,\
 		wb_info->mpcc_inst);
-	if (IS_DIAG_DC(dc->ctx->dce_environment)) {
-		/*till diags switch to warmup interface*/
-		dcn30_mmhubbub_warmup(dc, 1, wb_info);
-	}
 	/* Update writeback pipe */
 	dcn30_set_writeback(dc, wb_info, context);
 
@@ -447,28 +443,6 @@ void dcn30_init_hw(struct dc *dc)
 	if (res_pool->dccg->funcs->dccg_init)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-
-		REG_WRITE(REFCLK_CNTL, 0);
-		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
-		REG_WRITE(DIO_MEM_PWR_CTRL, 0);
-
-		if (!dc->debug.disable_clock_gate) {
-			/* enable all DCN clock gating */
-			REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-			REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
-
-			REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
-		}
-
-		//Enable ability to power gate / don't force power on permanently
-		if (hws->funcs.enable_power_gating_plane)
-			hws->funcs.enable_power_gating_plane(hws, true);
-
-		return;
-	}
-
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
 		hws->funcs.bios_golden_init(dc);
 		hws->funcs.disable_vga(dc->hwseq);
@@ -491,7 +465,6 @@ void dcn30_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 			if (res_pool->dccg && res_pool->hubbub) {
 
 				(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
@@ -508,7 +481,6 @@ void dcn30_init_hw(struct dc *dc)
 				res_pool->ref_clocks.dchub_ref_clock_inKhz =
 						res_pool->ref_clocks.xtalin_clock_inKhz;
 			}
-		}
 	} else
 		ASSERT_CRITICAL(false);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 18e94d8ae54f..3d19acaa12f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -151,8 +151,4 @@ void dcn30_hw_sequencer_construct(struct dc *dc)
 	dc->hwss = dcn30_funcs;
 	dc->hwseq->funcs = dcn30_private_funcs;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->hwss.init_hw = dcn20_fpga_init_hw;
-		dc->hwseq->funcs.init_pipes = NULL;
-	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 34b08d90dc1d..8b41ac93f7ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -55,7 +55,6 @@ void optc3_triplebuffer_lock(struct timing_generator *optc)
 	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
 		OTG_MASTER_UPDATE_LOCK, 1);
 
-	if (optc->ctx->dce_environment != DCE_ENV_FPGA_MAXIMUS)
 		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 				UPDATE_LOCK_STATUS, 1,
 				1, 10);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 67a34cda3774..cd94b5f5fdb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2376,10 +2376,7 @@ static bool dcn30_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
@@ -2577,8 +2574,7 @@ static bool dcn30_resource_construct(
 
 	/* Audio, Stream Encoders including DIG and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
+			&res_create_funcs))
 		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5ac2a272c380..1cf84a086fec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1513,10 +1513,7 @@ static bool dcn301_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
@@ -1710,9 +1707,8 @@ static bool dcn301_resource_construct(
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
 	dcn301_hw_sequencer_construct(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 9f93c43115ba..efd98d64588d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1309,8 +1309,6 @@ static bool dcn302_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else
-		dc->debug = debug_defaults_diags;
 
 	// Init the vm_helper
 	if (dc->vm_helper)
@@ -1489,8 +1487,7 @@ static bool dcn302_resource_construct(
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, pool,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-					&res_create_funcs : &res_create_maximus_funcs)))
+			&res_create_funcs))
 		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 7f72ef882ca4..fcd126602178 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1232,8 +1232,6 @@ static bool dcn303_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else
-		dc->debug = debug_defaults_diags;
 
 	// Init the vm_helper
 	if (dc->vm_helper)
@@ -1400,8 +1398,7 @@ static bool dcn303_resource_construct(
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, pool,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-					&res_create_funcs : &res_create_maximus_funcs)))
+			&res_create_funcs))
 		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 55494730e500..5a4d7c8f80d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -117,28 +117,6 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-
-		REG_WRITE(REFCLK_CNTL, 0);
-		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
-		REG_WRITE(DIO_MEM_PWR_CTRL, 0);
-
-		if (!dc->debug.disable_clock_gate) {
-			/* enable all DCN clock gating */
-			REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-			REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
-
-			REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
-		}
-
-		//Enable ability to power gate / don't force power on permanently
-		if (hws->funcs.enable_power_gating_plane)
-			hws->funcs.enable_power_gating_plane(hws, true);
-
-		return;
-	}
-
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
 		hws->funcs.bios_golden_init(dc);
 		if (hws->funcs.disable_vga)
@@ -154,7 +132,6 @@ void dcn31_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 			if (res_pool->dccg && res_pool->hubbub) {
 
 				(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
@@ -171,7 +148,6 @@ void dcn31_init_hw(struct dc *dc)
 				res_pool->ref_clocks.dchub_ref_clock_inKhz =
 						res_pool->ref_clocks.xtalin_clock_inKhz;
 			}
-		}
 	} else
 		ASSERT_CRITICAL(false);
 
@@ -549,11 +525,11 @@ static void dcn31_reset_back_end_for_pipe(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 	pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 
-	if (pipe_ctx->stream_res.tg->funcs->set_drr)
+	if (pipe_ctx->stream_res.tg->funcs->set_drr) {
 		pipe_ctx->stream_res.tg->funcs->set_drr(
 				pipe_ctx->stream_res.tg, NULL);
+	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		link = pipe_ctx->stream->link;
 		/* DPMS may already disable or */
 		/* dpms_off status is incorrect due to fastboot
@@ -580,9 +556,6 @@ static void dcn31_reset_back_end_for_pipe(
 				pipe_ctx->stream_res.audio = NULL;
 			}
 		}
-	} else if (pipe_ctx->stream_res.dsc) {
-		dc->link_srv->set_dsc_enable(pipe_ctx, false);
-	}
 
 	pipe_ctx->stream = NULL;
 	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index ba9e7dee6e5e..fc25cc300a17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -154,8 +154,4 @@ void dcn31_hw_sequencer_construct(struct dc *dc)
 	dc->hwss = dcn31_funcs;
 	dc->hwseq->funcs = dcn31_private_funcs;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->hwss.init_hw = dcn20_fpga_init_hw;
-		dc->hwseq->funcs.init_pipes = NULL;
-	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index ff8cd5076434..9c637c895f91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1341,13 +1341,6 @@ static struct dce_hwseq *dcn31_hwseq_create(
 		hws->regs = &hwseq_reg;
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
-		/* DCN3.1 FPGA Workaround
-		 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
-		 * To do so, move calling function enable_stream_timing to only be done AFTER calling
-		 * function core_link_enable_stream
-		 */
-		if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
-			hws->wa.dp_hpo_and_otg_sequence = true;
 	}
 	return hws;
 }
@@ -1988,10 +1981,7 @@ static bool dcn31_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
@@ -2195,9 +2185,8 @@ static bool dcn31_resource_construct(
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
 	dcn31_hw_sequencer_construct(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 90be62c05822..86d6a514dec0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -160,8 +160,4 @@ void dcn314_hw_sequencer_construct(struct dc *dc)
 	dc->hwss = dcn314_funcs;
 	dc->hwseq->funcs = dcn314_private_funcs;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->hwss.init_hw = dcn20_fpga_init_hw;
-		dc->hwseq->funcs.init_pipes = NULL;
-	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index abeeede38fb3..2483d37e425d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1375,13 +1375,6 @@ static struct dce_hwseq *dcn314_hwseq_create(
 		hws->regs = &hwseq_reg;
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
-		/* DCN3.1 FPGA Workaround
-		 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
-		 * To do so, move calling function enable_stream_timing to only be done AFTER calling
-		 * function core_link_enable_stream
-		 */
-		if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
-			hws->wa.dp_hpo_and_otg_sequence = true;
 	}
 	return hws;
 }
@@ -2101,8 +2094,7 @@ static bool dcn314_resource_construct(
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-				(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-				 &res_create_funcs : &res_create_maximus_funcs)))
+			&res_create_funcs))
 		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 95fd3d087ea3..e6d87c162d26 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1342,13 +1342,6 @@ static struct dce_hwseq *dcn31_hwseq_create(
 		hws->regs = &hwseq_reg;
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
-		/* DCN3.1 FPGA Workaround
-		 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
-		 * To do so, move calling function enable_stream_timing to only be done AFTER calling
-		 * function core_link_enable_stream
-		 */
-		if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
-			hws->wa.dp_hpo_and_otg_sequence = true;
 	}
 	return hws;
 }
@@ -1947,10 +1940,7 @@ static bool dcn315_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
@@ -2131,9 +2121,8 @@ static bool dcn315_resource_construct(
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
 	dcn31_hw_sequencer_construct(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 9ead347a33e9..a3be61cc541f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1340,13 +1340,6 @@ static struct dce_hwseq *dcn31_hwseq_create(
 		hws->regs = &hwseq_reg;
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
-		/* DCN3.1 FPGA Workaround
-		 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
-		 * To do so, move calling function enable_stream_timing to only be done AFTER calling
-		 * function core_link_enable_stream
-		 */
-		if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
-			hws->wa.dp_hpo_and_otg_sequence = true;
 	}
 	return hws;
 }
@@ -1844,10 +1837,7 @@ static bool dcn316_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
@@ -2028,9 +2018,8 @@ static bool dcn316_resource_construct(
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
 	dcn31_hw_sequencer_construct(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 24a890d879b8..6f9a165c1eab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -161,8 +161,4 @@ void dcn32_hw_sequencer_init_functions(struct dc *dc)
 	dc->hwss = dcn32_funcs;
 	dc->hwseq->funcs = dcn32_private_funcs;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->hwss.init_hw = dcn20_fpga_init_hw;
-		dc->hwseq->funcs.init_pipes = NULL;
-	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 98c394f9f8cf..ab75bb25f272 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2260,10 +2260,7 @@ static bool dcn32_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
@@ -2319,7 +2316,6 @@ static bool dcn32_resource_construct(
 	}
 
 	/* DML */
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_2_soc, &dcn3_2_ip, DML_PROJECT_DCN32);
 
 	/* IRQ Service */
@@ -2457,9 +2453,8 @@ static bool dcn32_resource_construct(
 
 	/* Audio, HWSeq, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	/* HW Sequencer init functions and Plane caps */
 	dcn32_hw_sequencer_init_functions(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index f4cd9749ffdf..66651df0178e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1801,10 +1801,7 @@ static bool dcn321_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-		dc->debug = debug_defaults_diags;
-	} else
-		dc->debug = debug_defaults_diags;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
@@ -1860,7 +1857,6 @@ static bool dcn321_resource_construct(
 	}
 
 	/* DML */
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_21_soc, &dcn3_21_ip, DML_PROJECT_DCN32);
 
 	/* IRQ Service */
@@ -1993,9 +1989,8 @@ static bool dcn321_resource_construct(
 
 	/* Audio, HWSeq, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
-			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
-			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+			&res_create_funcs))
+		goto create_fail;
 
 	/* HW Sequencer init functions and Plane caps */
 	dcn32_hw_sequencer_init_functions(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 422f17aefd4a..ed9291d44924 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -333,7 +333,6 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	memcpy(s, dcn3_01_soc.clock_limits, sizeof(dcn3_01_soc.clock_limits));
 
 	/* Default clock levels are used for diags, which may lead to overclocking. */
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
 		dcn3_01_ip.max_num_dpp = pool->base.pipe_count;
 		dcn3_01_soc.num_chans = bw_params->num_channels;
@@ -372,7 +371,6 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
 			s[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
 		}
-	}
 
 	memcpy(dcn3_01_soc.clock_limits, s, sizeof(dcn3_01_soc.clock_limits));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 19d034341e64..19e2bf7034e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -582,6 +582,7 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	struct _vcs_dpi_voltage_scaling_st *s = dc->scratch.update_bw_bounding_box.clock_limits;
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	unsigned int i, closest_clk_lvl;
+	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 	int j;
 
 	dc_assert_fp_enabled();
@@ -589,9 +590,6 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	memcpy(s, dcn3_1_soc.clock_limits, sizeof(dcn3_1_soc.clock_limits));
 
 	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-		int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
-
 		dcn3_1_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 		dcn3_1_ip.max_num_dpp = dc->res_pool->pipe_count;
 		dcn3_1_soc.num_chans = bw_params->num_channels;
@@ -642,7 +640,6 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		if (clk_table->num_entries) {
 			dcn3_1_soc.num_states = clk_table->num_entries;
 		}
-	}
 
 	memcpy(dcn3_1_soc.clock_limits, s, sizeof(dcn3_1_soc.clock_limits));
 
@@ -655,10 +652,7 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		dcn3_1_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
 	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31);
-	else
-		dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31_FPGA);
 }
 
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
@@ -719,10 +713,7 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		dcn3_15_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
 	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN315);
-	else
-		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31_FPGA);
 }
 
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
@@ -738,8 +729,6 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	memcpy(s, dcn3_16_soc.clock_limits, sizeof(dcn3_16_soc.clock_limits));
 
 	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-
 		dcn3_16_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 		dcn3_16_ip.max_num_dpp = dc->res_pool->pipe_count;
 		dcn3_16_soc.num_chans = bw_params->num_channels;
@@ -803,7 +792,6 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		if (clk_table->num_entries) {
 			dcn3_16_soc.num_states = clk_table->num_entries;
 		}
-	}
 
 	memcpy(dcn3_16_soc.clock_limits, s, sizeof(dcn3_16_soc.clock_limits));
 
@@ -817,10 +805,7 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		dcn3_16_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
 	}
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31);
-	else
-		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31_FPGA);
 }
 
 int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index fcde8f21b8be..4113ce79c4af 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -1432,14 +1432,6 @@ static void dml_rq_dlg_get_dlg_params(
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_flip    = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_flip);
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_flip   = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_flip);
 
-	// hack for FPGA
-	if (mode_lib->project == DML_PROJECT_DCN31_FPGA) {
-		if (disp_dlg_regs->vratio_prefetch >= (unsigned int) dml_pow(2, 22)) {
-			disp_dlg_regs->vratio_prefetch = (unsigned int) dml_pow(2, 22) - 1;
-			dml_print("vratio_prefetch exceed the max value, the register field is [21:0]\n");
-		}
-	}
-
 	disp_dlg_regs->refcyc_per_pte_group_vblank_l = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) dpte_groups_per_row_ub_l);
 	ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)dml_pow(2, 13));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 554152371eb5..318b9c2bc9be 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -190,8 +190,7 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	dc_assert_fp_enabled();
 
 	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment) && dc->config.use_default_clock_table == false) {
-
+	if (dc->config.use_default_clock_table == false) {
 		dcn3_14_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 		dcn3_14_ip.max_num_dpp = dc->res_pool->pipe_count;
 
@@ -267,10 +266,7 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 
 	dcn20_patch_bounding_box(dc, &dcn3_14_soc);
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN314);
-	else
-		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31_FPGA);
 }
 
 static bool is_dual_plane(enum surface_pixel_format format)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index 61ba3e33bb11..b3e8dc08030c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -1520,14 +1520,6 @@ static void dml_rq_dlg_get_dlg_params(
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_flip    = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_flip);
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_flip   = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_flip);
 
-	// hack for FPGA
-	if (mode_lib->project == DML_PROJECT_DCN31_FPGA) {
-		if (disp_dlg_regs->vratio_prefetch >= (unsigned int) dml_pow(2, 22)) {
-			disp_dlg_regs->vratio_prefetch = (unsigned int) dml_pow(2, 22) - 1;
-			dml_print("vratio_prefetch exceed the max value, the register field is [21:0]\n");
-		}
-	}
-
 	disp_dlg_regs->refcyc_per_pte_group_vblank_l = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) dpte_groups_per_row_ub_l);
 	ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)dml_pow(2, 13));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index d8d8fcd5ef1f..3104b672d2e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2530,7 +2530,6 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 {
 	dc_assert_fp_enabled();
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		/* Overrides from dc->config options */
 		dcn3_2_ip.clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
 
@@ -2602,7 +2601,6 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 
 		if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
 			dcn3_2_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-	}
 
 	/* DML DSC delay factor workaround */
 	dcn3_2_ip.dsc_delay_factor_wa = dc->debug.dsc_delay_factor_wa_x1000 / 1000.0;
@@ -2614,7 +2612,7 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
 	/* Overrides Clock levelsfrom CLK Mgr table entries as reported by PM FW */
-	if ((!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) && (bw_params->clk_table.entries[0].memclk_mhz)) {
+	if (bw_params->clk_table.entries[0].memclk_mhz) {
 		if (dc->debug.use_legacy_soc_bb_mechanism) {
 			unsigned int i = 0, j = 0, num_states = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 342a1bcb4927..b9b02c6f69b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -471,7 +471,6 @@ static void dcn321_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
 void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	dc_assert_fp_enabled();
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		/* Overrides from dc->config options */
 		dcn3_21_ip.clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
 
@@ -543,7 +542,6 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 
 		if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
 			dcn3_21_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-	}
 
 	/* DML DSC delay factor workaround */
 	dcn3_21_ip.dsc_delay_factor_wa = dc->debug.dsc_delay_factor_wa_x1000 / 1000.0;
@@ -555,7 +553,6 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
 	/* Overrides Clock levelsfrom CLK Mgr table entries as reported by PM FW */
-	if ((!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) && (bw_params->clk_table.entries[0].memclk_mhz)) {
 		if (dc->debug.use_legacy_soc_bb_mechanism) {
 			unsigned int i = 0, j = 0, num_states = 0;
 
@@ -699,6 +696,5 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		dml_init_instance(&dc->dml, &dcn3_21_soc, &dcn3_21_ip, DML_PROJECT_DCN32);
 		if (dc->current_state)
 			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_21_soc, &dcn3_21_ip, DML_PROJECT_DCN32);
-	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
index bdf3ac6cadd5..da0cfbb071e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
@@ -113,7 +113,6 @@ void dml_init_instance(struct display_mode_lib *lib,
 		lib->funcs = dml30_funcs;
 		break;
 	case DML_PROJECT_DCN31:
-	case DML_PROJECT_DCN31_FPGA:
 	case DML_PROJECT_DCN315:
 		lib->funcs = dml31_funcs;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
index a9d49ef58fb5..5edf69fa40d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
@@ -41,7 +41,6 @@ enum dml_project {
 	DML_PROJECT_DCN30,
 	DML_PROJECT_DCN31,
 	DML_PROJECT_DCN315,
-	DML_PROJECT_DCN31_FPGA,
 	DML_PROJECT_DCN314,
 	DML_PROJECT_DCN32,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index edd7d026a762..34fcffcb7dd7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -28,24 +28,6 @@
 #include "dccg.h"
 #include "clk_mgr.h"
 
-static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
-{
-	switch (link->link_enc->transmitter) {
-	case TRANSMITTER_UNIPHY_A:
-		return PHYD32CLKA;
-	case TRANSMITTER_UNIPHY_B:
-		return PHYD32CLKB;
-	case TRANSMITTER_UNIPHY_C:
-		return PHYD32CLKC;
-	case TRANSMITTER_UNIPHY_D:
-		return PHYD32CLKD;
-	case TRANSMITTER_UNIPHY_E:
-		return PHYD32CLKE;
-	default:
-		return PHYD32CLKA;
-	}
-}
-
 static void set_hpo_dp_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -120,44 +102,12 @@ static void setup_hpo_dp_stream_attribute(struct pipe_ctx *pipe_ctx)
 			DPCD_SOURCE_SEQ_AFTER_DP_STREAM_ATTR);
 }
 
-static void enable_hpo_dp_fpga_link_output(struct dc_link *link,
-		const struct link_resource *link_res,
-		enum signal_type signal,
-		enum clock_source_id clock_source,
-		const struct dc_link_settings *link_settings)
-{
-	const struct dc *dc = link->dc;
-	enum phyd32clk_clock_source phyd32clk = get_phyd32clk_src(link);
-	int phyd32clk_freq_khz = link_settings->link_rate == LINK_RATE_UHBR10 ? 312500 :
-			link_settings->link_rate == LINK_RATE_UHBR13_5 ? 412875 :
-			link_settings->link_rate == LINK_RATE_UHBR20 ? 625000 : 0;
-
-	dm_set_phyd32clk(dc->ctx, phyd32clk_freq_khz);
-	dc->res_pool->dccg->funcs->set_physymclk(
-			dc->res_pool->dccg,
-			link->link_enc_hw_inst,
-			PHYSYMCLK_FORCE_SRC_PHYD32CLK,
-			true);
-	dc->res_pool->dccg->funcs->enable_symclk32_le(
-			dc->res_pool->dccg,
-			link_res->hpo_dp_link_enc->inst,
-			phyd32clk);
-	link_res->hpo_dp_link_enc->funcs->link_enable(
-			link_res->hpo_dp_link_enc,
-			link_settings->lane_count);
-
-}
-
 static void enable_hpo_dp_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings)
 {
-	if (IS_FPGA_MAXIMUS_DC(link->dc->ctx->dce_environment))
-		enable_hpo_dp_fpga_link_output(link, link_res, signal,
-				clock_source, link_settings);
-	else
 		link_res->hpo_dp_link_enc->funcs->enable_link_phy(
 				link_res->hpo_dp_link_enc,
 				link_settings,
@@ -165,36 +115,13 @@ static void enable_hpo_dp_link_output(struct dc_link *link,
 				link->link_enc->hpd_source);
 }
 
-
-static void disable_hpo_dp_fpga_link_output(struct dc_link *link,
-		const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	const struct dc *dc = link->dc;
-
-	link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
-	dc->res_pool->dccg->funcs->disable_symclk32_le(
-			dc->res_pool->dccg,
-			link_res->hpo_dp_link_enc->inst);
-	dc->res_pool->dccg->funcs->set_physymclk(
-			dc->res_pool->dccg,
-			link->link_enc_hw_inst,
-			PHYSYMCLK_FORCE_SRC_SYMCLK,
-			false);
-	dm_set_phyd32clk(dc->ctx, 0);
-}
-
 static void disable_hpo_dp_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
-	if (IS_FPGA_MAXIMUS_DC(link->dc->ctx->dce_environment)) {
-		disable_hpo_dp_fpga_link_output(link, link_res, signal);
-	} else {
 		link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
 		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
 				link_res->hpo_dp_link_enc, signal);
-	}
 }
 
 static void set_hpo_dp_link_test_pattern(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 2267fb097830..b61a2cd28e88 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -765,7 +765,7 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	bool result = false;
 
-	if (dc_is_virtual_signal(stream->signal) || IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+	if (dc_is_virtual_signal(stream->signal))
 		result = true;
 	else
 		result = dm_helpers_dp_write_dsc_enable(dc->ctx, stream, enable);
@@ -778,7 +778,6 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
@@ -816,8 +815,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
 		/* Enable DSC in encoder */
-		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)
-				&& !dp_is_128b_132b_signal(pipe_ctx)) {
+		if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx)) {
 			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
 			dsc_optc_config_log(dsc, &dsc_optc_cfg);
 			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
@@ -843,19 +841,18 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 		/* disable DSC in stream encoder */
 		if (dc_is_dp_signal(stream->signal)) {
-			if (dp_is_128b_132b_signal(pipe_ctx))
+			if (dp_is_128b_132b_signal(pipe_ctx)) {
 				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
 										pipe_ctx->stream_res.hpo_dp_stream_enc,
 										false,
 										NULL,
 										true);
-			else if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+			}
 				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
 						pipe_ctx->stream_res.stream_enc,
 						OPTC_DSC_DISABLED, 0, 0);
 				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
 							pipe_ctx->stream_res.stream_enc, false, NULL, true);
-			}
 		}
 
 		/* disable DSC block */
@@ -2271,9 +2268,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
-	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
-			dc_is_virtual_signal(pipe_ctx->stream->signal))
-		return;
+		if (dc_is_virtual_signal(pipe_ctx->stream->signal))
+			return;
 
 	if (!pipe_ctx->stream->sink->edid_caps.panel_patch.skip_avmute) {
 		if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
@@ -2358,6 +2354,8 @@ void link_set_dpms_on(
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	bool apply_edp_fast_boot_optimization =
+		pipe_ctx->stream->apply_edp_fast_boot_optimization;
 
 	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
 
@@ -2375,9 +2373,8 @@ void link_set_dpms_on(
 		}
 	}
 
-	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
-			dc_is_virtual_signal(pipe_ctx->stream->signal))
-		return;
+		if (dc_is_virtual_signal(pipe_ctx->stream->signal))
+			return;
 
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
@@ -2402,10 +2399,6 @@ void link_set_dpms_on(
 
 	link_hwss->setup_stream_attribute(pipe_ctx);
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		bool apply_edp_fast_boot_optimization =
-			pipe_ctx->stream->apply_edp_fast_boot_optimization;
-
 		pipe_ctx->stream->apply_edp_fast_boot_optimization = false;
 
 		// Enable VPG before building infoframe
@@ -2527,14 +2520,6 @@ void link_set_dpms_on(
 
 		dc->hwss.enable_audio_stream(pipe_ctx);
 
-	} else { // if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		if (dp_is_128b_132b_signal(pipe_ctx))
-			dp_fpga_hpo_enable_link_and_stream(state, pipe_ctx);
-		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-				dc_is_virtual_signal(pipe_ctx->stream->signal))
-			link_set_dsc_enable(pipe_ctx, true);
-	}
-
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		set_avmute(pipe_ctx, false);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index f46864630506..3a5e80b57711 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -326,8 +326,7 @@ bool dp_is_fec_supported(const struct dc_link *link)
 
 	return (dc_is_dp_signal(link->connector_signal) && link_enc &&
 			link_enc->features.fec_supported &&
-			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
-			!IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment));
+			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE);
 }
 
 bool dp_should_enable_fec(const struct dc_link *link)
-- 
2.25.1

