Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E125DC3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B09A10E8A1;
	Wed, 10 Jul 2024 19:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tpdn4hKW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A5110E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB+1QS1eLC83iJUHgj3P0//Kb+PAHFDUM4IKNwwwxN6vauR++SJaNJ1g3BrSS3WinevBl1namurDkq47SLzPu2zDK2+gxUxO05qWqWDGRPyhrv90c3yF1+9ilj0XxeetmP/I2ylESvhXvjR+nBs4O4ym6tSewj0VidmV9h2MrXZAS8BOnuJ6htBzB2BZfCTlwCCA4Ap5mF5C2IooBSPaN0TyQabostplXwRuviwMDdu8HX8k7Rn3WOk9/39Pev9WSMjppBC6iG3Em9Jo/R/UsxNec2FliMbw/rdfCwPE9j8bQP38MTcG7uVoZ857qD+NgopkDC5yGQ2BRSzXCbwqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/Gt5iyvIWGAv0Cjyp02LPLKz0TKYyW3e4nY4AVp+NE=;
 b=UcbWNDJNvdT9/nNxJC1ed/BWPweX4WXH3J+4nlis0lhh4wjv3UzoJl68UzqmqR8iaOOkPUissdYunnYcWQh52StouC/TKJbm3GaluECEzIbYrkDFtrAqkTcl8YZl3/U4QgLg+7vIRFanGJrCvkDcP5Dm+n9T+/0wP34NQoXUD6/GkC7V9wIE9CSMoQ4p3ao7Rtyac1F3DFMOzGd5wNxbH8bvss7NJ7tZONfIPVPD6T5XA415JY3GwgiAFkWDkRlIaVkffhgiejj1oV0F3+e/1uoNh9R0f+YRxg43s6HFHudhkXJMXWhp7kCfKWoiB6MF/PW/kgB1SZWJZayUr6Wpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/Gt5iyvIWGAv0Cjyp02LPLKz0TKYyW3e4nY4AVp+NE=;
 b=tpdn4hKWWE0Guxm3HkNIDNNc/TRAv1org4UIJyrJmGgj29G3C6h3e6ymm6C8z6b4a6lltZ7yHWHRt8rF3ci/QCf2hpf+ZdDnR0EFE7sBeTcrrh+tkFZCMLmxhGNKYIz2flzXDRdKdDWP4SYTE+e9oFjhi0kpRXbdJKFO745pdpE=
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:37:32 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::c3) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:30 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:30 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ryan Seto <ryanseto@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 05/50] drm/amd/display: Added logging for automated DPM testing
Date: Wed, 10 Jul 2024 15:36:22 -0400
Message-ID: <20240710193707.43754-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6a7928-dc42-4382-d36b-08dca117bdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m/wASZVaTcY6xbgJm3c9bs6xUL954RKgvjppFX9CO5Au3olBuJ1KJz0TxAHB?=
 =?us-ascii?Q?Nz6wsOQFh0duNvGosrQ6i6ZliWyNu8VcGcQIaifohYe1uqCl7s8kzZHL8xnV?=
 =?us-ascii?Q?6zz8Zwv3l7H7wCN1v+VYewyXyL1qpIAR++CpLAjf23DL/3OR8u0pEFPr+Raj?=
 =?us-ascii?Q?iVg62xY9W/w6U9+ABK7K3wDBJ3HDrchUdkhOp8oe/KoRyocLDF04ogiRjqXP?=
 =?us-ascii?Q?TwVFR12RYYwszI565ncV0h9Mc7Mr8WpLp0SyTk1S1XOiogFES2q8fYmHwfJC?=
 =?us-ascii?Q?UZ5dY+MtFoOsmPhS2INQo3db+3Z933tnU6Spki7OCpAvOl1VnonmHjvBQNg+?=
 =?us-ascii?Q?RKuCDcL7R5vpFO5rSGpv8bFhL04ofJyNxm/Cjp/qRrH9lPyRG7gjK4Iw4QgV?=
 =?us-ascii?Q?yffnRYloVvnOB10td+KQWbPoTZUNFGgl3oGl+/tdq4ghPz238voLwU+XLSRs?=
 =?us-ascii?Q?mqaWhY+7EzSm9TgMVZw9I2zD9WVeiiXE7nNXMlrzP5eEGhduV9B35iqdD1JM?=
 =?us-ascii?Q?KL6lHJ9hZcE5Rs3FbgpNoHo6ZIMqcK8OLDXuDx9h8WOXywElvRn+QG1GPUAs?=
 =?us-ascii?Q?73ilBdrnDubzh87Kkxy2MZG2WvotqDurZYq6MQFI2YAxm+K+sanXgHaKRF7u?=
 =?us-ascii?Q?imvhTaLyfc2+NjLDA06b3G231XyqIHTydjZwc6lAoWT0ebgNvksk521BSH3a?=
 =?us-ascii?Q?mPxYs1pplk//9RjXZrx0LWZnlpUSFFcCEKaAOzRnp3O8YuTDaTb6FcltEw/H?=
 =?us-ascii?Q?zxO268olH1fFfuehjpXut5N7uiy9hc4UoyWsSo0T7LLHngIHAsyZJlliL+fx?=
 =?us-ascii?Q?ALQ51v9+e7P5KiaIF2FVZVh8hrSTwQG6r3AYzQwG8Dv6m21WTv9JjcPMMyK2?=
 =?us-ascii?Q?zDXtGmoCOodi1JNk3la5cvsYVxzmSWKIMT02EDdqarCpbAo6DoI6sCGc/7yx?=
 =?us-ascii?Q?BCvq4VtX2zqAOTCvPMO3dHCbkw6Y3nzaD0uXFIkTUdifwAQHjE3ZPMs1x1XH?=
 =?us-ascii?Q?q+0aPGRJaxcF66DOomYMgLL/kckdTEaRHR0431kXIT1QgZ/Dx32HNgn+13Lv?=
 =?us-ascii?Q?EBl8pT0FgBfWsL0oF2xrnI0P4sKakO6SLvroqC7WiuNNpJHeENr7DX/DDS7C?=
 =?us-ascii?Q?Efv7Mzd06TmtIcgVRNQwbvn5TbJe91q6Fct1QGk4VY/3Mz5Z9t43P5UPBp/i?=
 =?us-ascii?Q?qdFKXgCdvSC96gPR5poTFcZXMUngRpKzqRgQyDS4Po1ZOmHdHpAD3OTogbtb?=
 =?us-ascii?Q?oABP2DE8k7ZeN5UmfxUA5izp5XIcC9UCfeUQyd33mRvJJ2pCZNpxPvyRAaCj?=
 =?us-ascii?Q?sgfwxd4Wx/4ZRIbD2gl6WF9duh1w4cv1rFnjJUOhvjNlPrOo8B0FOhWorg1W?=
 =?us-ascii?Q?gprPf3tvSx6QwpRXTTtB/cWes4fhcF77WhTIvsWi+r302yT+P41E4j2tulav?=
 =?us-ascii?Q?rbmyb/4so4AfgFVyycT4ZRy3ytui6/a5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:31.9548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6a7928-dc42-4382-d36b-08dca117bdf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
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

From: Ryan Seto <ryanseto@amd.com>

[Why]
Added clock logs to automate DPM testing

[How]
Added logs and helper functions to output clocks

Co-authored-by: Ryan Seto <ryanseto@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 250 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   9 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  27 ++
 .../dc/dml2/dml21/dml21_translation_helper.h  |   1 +
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |   2 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   4 +-
 7 files changed, 237 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 45fe17a46890..c453c5f15ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -14,6 +14,7 @@
 #include "core_types.h"
 #include "dm_helpers.h"
 #include "link.h"
+#include "dc_state_priv.h"
 #include "atomfirmware.h"
 
 #include "dcn401_smu14_driver_if.h"
@@ -29,6 +30,7 @@
 #define mmCLK01_CLK0_CLK2_DFS_CNTL                      0x16E6F
 #define mmCLK01_CLK0_CLK3_DFS_CNTL                      0x16E72
 #define mmCLK01_CLK0_CLK4_DFS_CNTL                      0x16E75
+#define mmCLK20_CLK2_CLK2_DFS_CNTL                      0x1B051
 
 #define CLK0_CLK_PLL_REQ__FbMult_int_MASK                  0x000001ffUL
 #define CLK0_CLK_PLL_REQ__PllSpineDiv_MASK                 0x0000f000UL
@@ -302,6 +304,197 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn401_build_wm_range_table(clk_mgr_base);
 }
 
+static void dcn401_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
+{
+		struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+		uint32_t dprefclk_did = 0;
+		uint32_t dcfclk_did = 0;
+		uint32_t dtbclk_did = 0;
+		uint32_t dispclk_did = 0;
+		uint32_t dppclk_did = 0;
+		uint32_t fclk_did = 0;
+		uint32_t target_div = 0;
+
+		/* DFS Slice 0 is used for DISPCLK */
+		dispclk_did = REG_READ(CLK0_CLK0_DFS_CNTL);
+		/* DFS Slice 1 is used for DPPCLK */
+		dppclk_did = REG_READ(CLK0_CLK1_DFS_CNTL);
+		/* DFS Slice 2 is used for DPREFCLK */
+		dprefclk_did = REG_READ(CLK0_CLK2_DFS_CNTL);
+		/* DFS Slice 3 is used for DCFCLK */
+		dcfclk_did = REG_READ(CLK0_CLK3_DFS_CNTL);
+		/* DFS Slice 4 is used for DTBCLK */
+		dtbclk_did = REG_READ(CLK0_CLK4_DFS_CNTL);
+		/* DFS Slice _ is used for FCLK */
+		fclk_did = REG_READ(CLK2_CLK2_DFS_CNTL);
+
+		/* Convert DISPCLK DFS Slice DID to divider*/
+		target_div = dentist_get_divider_from_did(dispclk_did);
+		//Get dispclk in khz
+		regs_and_bypass->dispclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+		/* Convert DISPCLK DFS Slice DID to divider*/
+		target_div = dentist_get_divider_from_did(dppclk_did);
+		//Get dppclk in khz
+		regs_and_bypass->dppclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+		/* Convert DPREFCLK DFS Slice DID to divider*/
+		target_div = dentist_get_divider_from_did(dprefclk_did);
+		//Get dprefclk in khz
+		regs_and_bypass->dprefclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+		/* Convert DCFCLK DFS Slice DID to divider*/
+		target_div = dentist_get_divider_from_did(dcfclk_did);
+		//Get dcfclk in khz
+		regs_and_bypass->dcfclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+		/* Convert DTBCLK DFS Slice DID to divider*/
+		target_div = dentist_get_divider_from_did(dtbclk_did);
+		//Get dtbclk in khz
+		regs_and_bypass->dtbclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+		/* Convert DTBCLK DFS Slice DID to divider*/
+		target_div = dentist_get_divider_from_did(fclk_did);
+		//Get fclk in khz
+		regs_and_bypass->fclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+}
+
+static bool dcn401_check_native_scaling(struct pipe_ctx *pipe)
+{
+	bool is_native_scaling = false;
+	int width = pipe->plane_state->src_rect.width;
+	int height = pipe->plane_state->src_rect.height;
+
+	if (pipe->stream->timing.h_addressable == width &&
+			pipe->stream->timing.v_addressable == height &&
+			pipe->plane_state->dst_rect.width == width &&
+			pipe->plane_state->dst_rect.height == height)
+		is_native_scaling = true;
+
+	return is_native_scaling;
+}
+
+static void dcn401_auto_dpm_test_log(
+		struct dc_clocks *new_clocks,
+		struct clk_mgr_internal *clk_mgr,
+		struct dc_state *context)
+{
+	unsigned int mall_ss_size_bytes;
+	int dramclk_khz_override, fclk_khz_override, num_fclk_levels;
+
+	struct pipe_ctx *pipe_ctx_list[MAX_PIPES];
+	int active_pipe_count = 0;
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream && dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+			pipe_ctx_list[active_pipe_count] = pipe_ctx;
+			active_pipe_count++;
+		}
+	}
+
+	msleep(5);
+
+	mall_ss_size_bytes = context->bw_ctx.bw.dcn.mall_ss_size_bytes;
+
+	struct clk_log_info log_info = {0};
+	struct clk_state_registers_and_bypass clk_register_dump;
+
+	dcn401_dump_clk_registers(&clk_register_dump, &clk_mgr->base, &log_info);
+
+	// Overrides for these clocks in case there is no p_state change support
+	dramclk_khz_override = new_clocks->dramclk_khz;
+	fclk_khz_override = new_clocks->fclk_khz;
+
+	num_fclk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1;
+
+	if (!new_clocks->p_state_change_support)
+		dramclk_khz_override = clk_mgr->base.bw_params->max_memclk_mhz * 1000;
+
+	if (!new_clocks->fclk_p_state_change_support)
+		fclk_khz_override = clk_mgr->base.bw_params->clk_table.entries[num_fclk_levels].fclk_mhz * 1000;
+
+
+	////////////////////////////////////////////////////////////////////////////
+	//	IMPORTANT: 	When adding more clocks to these logs, do NOT put a newline
+	//	 			anywhere other than at the very end of the string.
+	//
+	//	Formatting example (make sure to have " - " between each entry):
+	//
+	//				AutoDPMTest: clk1:%d - clk2:%d - clk3:%d - clk4:%d\n"
+	////////////////////////////////////////////////////////////////////////////
+	if (active_pipe_count > 0 &&
+		new_clocks->dramclk_khz > 0 &&
+		new_clocks->fclk_khz > 0 &&
+		new_clocks->dcfclk_khz > 0 &&
+		new_clocks->dppclk_khz > 0) {
+
+		uint32_t pix_clk_list[MAX_PIPES] = {0};
+		int p_state_list[MAX_PIPES] = {0};
+		int disp_src_width_list[MAX_PIPES] = {0};
+		int disp_src_height_list[MAX_PIPES] = {0};
+		uint64_t disp_src_refresh_list[MAX_PIPES] = {0};
+		bool is_scaled_list[MAX_PIPES] = {0};
+
+		for (int i = 0; i < active_pipe_count; i++) {
+			struct pipe_ctx *curr_pipe_ctx = pipe_ctx_list[i];
+			uint64_t refresh_rate;
+
+			pix_clk_list[i] = curr_pipe_ctx->stream->timing.pix_clk_100hz;
+			p_state_list[i] = curr_pipe_ctx->p_state_type;
+
+			refresh_rate = (curr_pipe_ctx->stream->timing.pix_clk_100hz * (uint64_t)100 +
+				curr_pipe_ctx->stream->timing.v_total
+				* (uint64_t) curr_pipe_ctx->stream->timing.h_total - (uint64_t)1);
+			refresh_rate = div_u64(refresh_rate, curr_pipe_ctx->stream->timing.v_total);
+			refresh_rate = div_u64(refresh_rate, curr_pipe_ctx->stream->timing.h_total);
+			disp_src_refresh_list[i] = refresh_rate;
+
+			if (curr_pipe_ctx->plane_state) {
+				is_scaled_list[i] = !(dcn401_check_native_scaling(curr_pipe_ctx));
+				disp_src_width_list[i] = curr_pipe_ctx->plane_state->src_rect.width;
+				disp_src_height_list[i] = curr_pipe_ctx->plane_state->src_rect.height;
+			}
+		}
+
+		DC_LOG_AUTO_DPM_TEST("AutoDPMTest: dramclk:%d - fclk:%d - "
+			"dcfclk:%d - dppclk:%d - dispclk_hw:%d - "
+			"dppclk_hw:%d - dprefclk_hw:%d - dcfclk_hw:%d - "
+			"dtbclk_hw:%d - fclk_hw:%d - pix_clk_0:%d - pix_clk_1:%d - "
+			"pix_clk_2:%d - pix_clk_3:%d - mall_ss_size:%d - p_state_type_0:%d - "
+			"p_state_type_1:%d - p_state_type_2:%d - p_state_type_3:%d - "
+			"pix_width_0:%d - pix_height_0:%d - refresh_rate_0:%lld - is_scaled_0:%d - "
+			"pix_width_1:%d - pix_height_1:%d - refresh_rate_1:%lld - is_scaled_1:%d - "
+			"pix_width_2:%d - pix_height_2:%d - refresh_rate_2:%lld - is_scaled_2:%d - "
+			"pix_width_3:%d - pix_height_3:%d - refresh_rate_3:%lld - is_scaled_3:%d - LOG_END\n",
+			dramclk_khz_override,
+			fclk_khz_override,
+			new_clocks->dcfclk_khz,
+			new_clocks->dppclk_khz,
+			clk_register_dump.dispclk,
+			clk_register_dump.dppclk,
+			clk_register_dump.dprefclk,
+			clk_register_dump.dcfclk,
+			clk_register_dump.dtbclk,
+			clk_register_dump.fclk,
+			pix_clk_list[0], pix_clk_list[1], pix_clk_list[3], pix_clk_list[2],
+			mall_ss_size_bytes,
+			p_state_list[0], p_state_list[1], p_state_list[2], p_state_list[3],
+			disp_src_width_list[0], disp_src_height_list[0], disp_src_refresh_list[0], is_scaled_list[0],
+			disp_src_width_list[1], disp_src_height_list[1], disp_src_refresh_list[1], is_scaled_list[1],
+			disp_src_width_list[2], disp_src_height_list[2], disp_src_refresh_list[2], is_scaled_list[2],
+			disp_src_width_list[3], disp_src_height_list[3], disp_src_refresh_list[3], is_scaled_list[3]);
+	}
+}
+
 static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 			struct dc_state *context,
 			int ref_dtbclk_khz)
@@ -1194,6 +1387,10 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	/* execute sequence */
 	dcn401_execute_block_sequence(clk_mgr_base,	num_steps);
+
+	if (dc->config.enable_auto_dpm_test_logs)
+		dcn401_auto_dpm_test_log(&context->bw_ctx.bw.dcn.clk, TO_CLK_MGR_INTERNAL(clk_mgr_base), context);
+
 }
 
 
@@ -1218,59 +1415,6 @@ static uint32_t dcn401_get_vco_frequency_from_reg(struct clk_mgr_internal *clk_m
 		return dc_fixpt_floor(pll_req);
 }
 
-static void dcn401_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
-		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	uint32_t dprefclk_did = 0;
-	uint32_t dcfclk_did = 0;
-	uint32_t dtbclk_did = 0;
-	uint32_t dispclk_did = 0;
-	uint32_t dppclk_did = 0;
-	uint32_t target_div = 0;
-
-	/* DFS Slice 0 is used for DISPCLK */
-	dispclk_did = REG_READ(CLK0_CLK0_DFS_CNTL);
-	/* DFS Slice 1 is used for DPPCLK */
-	dppclk_did = REG_READ(CLK0_CLK1_DFS_CNTL);
-	/* DFS Slice 2 is used for DPREFCLK */
-	dprefclk_did = REG_READ(CLK0_CLK2_DFS_CNTL);
-	/* DFS Slice 3 is used for DCFCLK */
-	dcfclk_did = REG_READ(CLK0_CLK3_DFS_CNTL);
-	/* DFS Slice 4 is used for DTBCLK */
-	dtbclk_did = REG_READ(CLK0_CLK4_DFS_CNTL);
-
-	/* Convert DISPCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dispclk_did);
-	//Get dispclk in khz
-	regs_and_bypass->dispclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
-
-	/* Convert DISPCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dppclk_did);
-	//Get dppclk in khz
-	regs_and_bypass->dppclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
-
-	/* Convert DPREFCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dprefclk_did);
-	//Get dprefclk in khz
-	regs_and_bypass->dprefclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
-
-	/* Convert DCFCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dcfclk_did);
-	//Get dcfclk in khz
-	regs_and_bypass->dcfclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
-
-	/* Convert DTBCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dtbclk_did);
-	//Get dtbclk in khz
-	regs_and_bypass->dtbclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
-}
-
 static void dcn401_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
 {
 	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 85a2ef82afa5..387b392f4c0d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1254,7 +1254,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
 
 			if (pipe->stream && pipe->plane_state) {
-				set_p_state_switch_method(dc, context, pipe);
+				if (!dc->debug.using_dml2)
+					set_p_state_switch_method(dc, context, pipe);
 				dc_update_visual_confirm_color(dc, context, pipe);
 			}
 
@@ -3704,7 +3705,8 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->stream && pipe->plane_state) {
-			set_p_state_switch_method(dc, context, pipe);
+			if (!dc->debug.using_dml2)
+				set_p_state_switch_method(dc, context, pipe);
 
 			if (dc->debug.visual_confirm)
 				dc_update_visual_confirm_color(dc, context, pipe);
@@ -3839,7 +3841,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->stream && pipe->plane_state) {
-			set_p_state_switch_method(dc, context, pipe);
+			if (!dc->debug.using_dml2)
+				set_p_state_switch_method(dc, context, pipe);
 
 			if (dc->debug.visual_confirm)
 				dc_update_visual_confirm_color(dc, context, pipe);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index a50fe3ec79c1..7c73efe19525 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1172,3 +1172,30 @@ void dml21_get_pipe_mcache_config(
 	mcache_pipe_config->plane1_enabled =
 			dml21_is_plane1_enabled(pln_prog->plane_descriptor->pixel_format);
 }
+
+void dml21_set_dc_p_state_type(
+		struct pipe_ctx *pipe_ctx,
+		struct dml2_per_stream_programming *stream_programming)
+{
+	switch (stream_programming->uclk_pstate_method) {
+	case dml2_uclk_pstate_support_method_vactive:
+	case dml2_uclk_pstate_support_method_fw_vactive_drr:
+		pipe_ctx->p_state_type = P_STATE_V_ACTIVE;
+		break;
+	case dml2_uclk_pstate_support_method_vblank:
+	case dml2_uclk_pstate_support_method_fw_vblank_drr:
+		pipe_ctx->p_state_type = P_STATE_V_BLANK;
+		break;
+	case dml2_uclk_pstate_support_method_fw_subvp_phantom:
+	case dml2_uclk_pstate_support_method_fw_subvp_phantom_drr:
+		pipe_ctx->p_state_type = P_STATE_SUB_VP;
+		break;
+	case dml2_uclk_pstate_support_method_fw_drr:
+		pipe_ctx->p_state_type = P_STATE_FPO;
+		break;
+	default:
+		pipe_ctx->p_state_type = P_STATE_UNKNOWN;
+		break;
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
index 4cc0a1fbb93d..97a8f51b7780 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
@@ -26,4 +26,5 @@ void dml21_extract_legacy_watermark_set(const struct dc *in_dc, struct dcn_water
 void dml21_extract_watermark_sets(const struct dc *in_dc, union dcn_watermark_set *watermarks, struct dml2_context *in_ctx);
 void dml21_map_hw_resources(struct dml2_context *dml_ctx);
 void dml21_get_pipe_mcache_config(struct dc_state *context, struct pipe_ctx *pipe_ctx, struct dml2_per_plane_programming *pln_prog, struct dml2_pipe_configuration_descriptor *mcache_pipe_config);
+void dml21_set_dc_p_state_type(struct pipe_ctx *pipe_ctx, struct dml2_per_stream_programming *stream_programming);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index d276458e50fd..622c98f4b7fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -316,6 +316,8 @@ void dml21_program_dc_pipe(struct dml2_context *dml_ctx, struct dc_state *contex
 
 	dml21_populate_mall_allocation_size(context, dml_ctx, pln_prog, pipe_ctx);
 	memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[pipe_ctx->pipe_idx], &pln_prog->mcache_allocation, sizeof(struct dml2_mcache_surface_allocation));
+
+	dml21_set_dc_p_state_type(pipe_ctx, stream_prog);
 }
 
 static struct dc_stream_state *dml21_add_phantom_stream(struct dml2_context *dml_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index d5fefce3e74b..c55d7279fe51 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -180,6 +180,7 @@ struct clk_state_registers_and_bypass {
 	uint32_t dispclk;
 	uint32_t dppclk;
 	uint32_t dtbclk;
+	uint32_t fclk;
 
 	uint32_t dppclk_bypass;
 	uint32_t dcfclk_bypass;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 12282f96dfe1..c2dd061892f4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -191,7 +191,8 @@ enum dentist_divider_range {
 	CLK_SR_DCN401(CLK0_CLK1_DFS_CNTL,  CLK01, 0), \
 	CLK_SR_DCN401(CLK0_CLK2_DFS_CNTL,  CLK01, 0), \
 	CLK_SR_DCN401(CLK0_CLK3_DFS_CNTL,  CLK01, 0), \
-	CLK_SR_DCN401(CLK0_CLK4_DFS_CNTL,  CLK01, 0)
+	CLK_SR_DCN401(CLK0_CLK4_DFS_CNTL,  CLK01, 0), \
+	CLK_SR_DCN401(CLK2_CLK2_DFS_CNTL,  CLK20, 0)
 
 #define CLK_COMMON_MASK_SH_LIST_DCN401(mask_sh) \
 	CLK_COMMON_MASK_SH_LIST_DCN321(mask_sh)
@@ -235,6 +236,7 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK2_DFS_CNTL;
 	uint32_t CLK1_CLK3_DFS_CNTL;
 	uint32_t CLK1_CLK4_DFS_CNTL;
+	uint32_t CLK2_CLK2_DFS_CNTL;
 
 	uint32_t CLK1_CLK0_CURRENT_CNT;
     uint32_t CLK1_CLK1_CURRENT_CNT;
-- 
2.34.1

