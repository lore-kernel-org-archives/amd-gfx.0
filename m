Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A35CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8FA10E9B4;
	Thu,  3 Oct 2024 23:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MWxS8bSd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D74A10E9BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUO8hmMzuZcxjtJ80RwxJMz9PnWClNoYO/6Nbx/Qw6qcUpJkUMvTeM9q2oq0XOEk1WkSLi2FbY9+nQukm7O5T/FC2hp5pCEffAeA+FGWl2Si5tIbdVvLGXj7kIIeJ4cOOU4fRJ93jlCIkNRodLd83MmBcnPipzMz4TsvUJ+eMwSD1PI5B7hSsIQMcun/pdI7TDnrtVBu0UqAN2ubJtvYm4n2arYEqTv6a60ZgN6SAnzmdAHD0OHU4n6a046eZrE3WWKVlt1YDq3loq/laRB3L1Lp3Pn1ab2dcqAoWz7fYF4gTHuSAKVwQ0VSsKItBGzVDIQsTrz8GCYqqm8x5jSseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFK0w+owQ9HXEqj64WB3F2PspnwTvNt69hToHYxkKEE=;
 b=WomJKGO4t4ZNozUYbShxa7TBKzzXcLEuhFqQeiw9N6gCnTE4WSKAVrP0Aruaclzb2WhJb0b6Gyi4v6o8jxybx+3JgYKpg7bro6v1SzrEkRNmyf0JWgKCnJOOClcgvlF+ez8d7Ug2QH45lSFkQRZJpQ6R+Xaqgh/3AkO3sjmljMn6ZD+9OmUv/Y+zAffc63fV0jkbFNPyUWKeeGH9DFlx5OvaC/bZR53fmihsdrV/6IJJwFD6Wd6JATG0PkeLpZUMmI/B4wnfPgrfe8ymzt5G8aZ3DMuATo0lz0U26NQGPX/qWTJGnwQNrdyUiYCdcRJmOjIgjkyvpEDUCG1WH5RN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFK0w+owQ9HXEqj64WB3F2PspnwTvNt69hToHYxkKEE=;
 b=MWxS8bSd0BsBJ0Gx0dNWK2zFzoVfc8zWz2hMWv8YT9fug3AXy2HE9vju1+k6H6+Leo300sSZkT4nSeT0hY/A3knNNBChr+nsQyMwCNvtE777RWeJF6d4YYRW7zIfCVETvHkUpboyFPcbF+KpGujLzvck2lYBKaoQdIXYFLX3VE8=
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:36:21 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::32) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:17 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Kaitlyn Tse <Kaitlyn.Tse@amd.com>, "Harry
 Vanzylldejong" <harry.vanzylldejong@amd.com>, Iswara Nagulendran
 <iswara.nagulendran@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 25/26] drm/amd/display: Initialize new backlight_level_params
 structure
Date: Thu, 3 Oct 2024 17:33:43 -0600
Message-ID: <20241003233509.210919-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: d740e7a4-5f86-47ca-251f-08dce4042faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0IlBbIA+KLoXApGGh7uX9CH6l3Vd0MNOWDdRFP+oWR5BX2AS1RMBHrUw+d+a?=
 =?us-ascii?Q?WaAoOSKqpzOa23l1TpJDaAKY87jkrrC52iAKWzmS907SS3iLTas/4UjlHtaY?=
 =?us-ascii?Q?ZgjueMLwLY5/P9zupzFqkMPAqqe1mPvBLjPP2M+9O5GtHz0BFD47jgQlrQgA?=
 =?us-ascii?Q?SEJjAYSpGg+tVfgdlu4MVzZbDQMWqa61c/JfxW8CpME2soIYvyAFGcF0yxxa?=
 =?us-ascii?Q?sg7/M2vViUpo+s5z7Ww8xrtYl6l5k5bxyGBwmTe1YNDRQaAdRqefjQ2/NwzZ?=
 =?us-ascii?Q?eNlAXDhRxv+NUElWJQQFXZhz+aku9Lb4W+fO/MV2k2zxTx4Y2LkFiqInZMbF?=
 =?us-ascii?Q?t8hcxYwQP2b8OjTKbdKYash3mIyJixhDyruoPUU3533u8msvWw9GxJ8+lZA8?=
 =?us-ascii?Q?2G/S64r98hND/oJFnHVO6aCL1MS6h0NFaTVlbNJsTGocLwkTKk9jTbA3sDFP?=
 =?us-ascii?Q?pd7xWwMhSKUx02p4hKd/YV6sjkNcVJMCcyaFGUErNzhBSzDYrmG/mZCf5lV/?=
 =?us-ascii?Q?+F+Fx9eGFOYjEktigZXSPr+wcOiEuRDnA7Yn+Cw1gaANUp3m/O4QkX+fcgVe?=
 =?us-ascii?Q?tpYHsglpV83qSlDyGnFvpR6/FJO/Ahm2ZhUWRVSa+yeLBE/lel0yz8osDbxo?=
 =?us-ascii?Q?rcQLgA87cKElbzuMrPUUNqcVJ8dhsLWHkzAv8+2zav5BAYJQsWxPZqloyvf3?=
 =?us-ascii?Q?dSNAfWsDRnpTnPwQw1H5B4njIspuGpH+oVnpNmeucfPwR92rTXse8ll6lE+f?=
 =?us-ascii?Q?orrIUUHaRpdRHMKcj1Guh5e4RL0tS+7GukKrQlaLZPOsJxFLvVwV4CodbKfU?=
 =?us-ascii?Q?EWCU/02BFgWtZVwIMR29C3Z01plCf0mrp6HTt7wBwW3UmbDAjF28UH7mn3mE?=
 =?us-ascii?Q?gnIGM7XhsiwsY/wGV6ACpENNSPmHRHPVuL6Os5gTtm7iXbdDdZiJrX8fXAX2?=
 =?us-ascii?Q?FqoR/C5iDJq804YvBfB4wUpSgNZSBSZy3Q4qp+mbXn5N0S4XbnrvYK1NGn8L?=
 =?us-ascii?Q?EdEFZ/Ge6I9id1SDD6bMhhtaRySZmCeYbdFPRUdaUGhwcMWZ/LJJ7ydCArR6?=
 =?us-ascii?Q?ms1e96jUouxB/zMbvltVO2qlOG7s38daMHndHgPgshiN9neILbc+ZKl4azNe?=
 =?us-ascii?Q?s0PbdARFU9cDwm+v1veg3PQainxSJOAF0JYTOsbcguQK1dYWLpdedWbxxHGT?=
 =?us-ascii?Q?OBLEabUJwubKalgovEgzk3drhVX3MbU/6XQfPoCDkRFp5Y6EJEJVlDdh0Ruk?=
 =?us-ascii?Q?pqJrMenU593dXwBOxzMYLwwAKqxosGhgjPB69dgj90i0Yjttty5wwJQ/IXXu?=
 =?us-ascii?Q?4EIJtBERLStsKusQXz0BRh0ADsFtT3KGeSau+0x0UYWxu9hPQHQ00tQw60dt?=
 =?us-ascii?Q?7pQrKA43mgEruRg5QLxBpSAkyXiR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:20.8902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d740e7a4-5f86-47ca-251f-08dce4042faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

From: Kaitlyn Tse <Kaitlyn.Tse@amd.com>

[Why]
Initialize the new backlight_level_params structure as part of the ABC
framework, the information in this structure is needed to be passed down
to the DMCUB to identify the backlight control type, to adjust the
backlight of the panel and to perform any required conversions from PWM
to nits or vice versa.

[How]
Created initial framework of the backlight_level_params struct and
modified existing functions to include the new structure.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Reviewed-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Kaitlyn Tse <Kaitlyn.Tse@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h | 3 +--
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 7 ++++---
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h   | 3 +--
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h        | 8 ++++++--
 .../display/dc/link/protocols/link_edp_panel_control.c    | 8 +++++---
 6 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 9d00d8dc5ae8..c31ec44ccd8c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3142,9 +3142,10 @@ static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 }
 
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp)
+	struct set_backlight_level_params *params)
 {
+	uint32_t backlight_pwm_u16_16 = params->backlight_pwm_u16_16;
+	uint32_t frame_ramp = params->frame_ramp;
 	struct dc_link *link = pipe_ctx->stream->link;
 	struct dc  *dc = link->ctx->dc;
 	struct abm *abm = pipe_ctx->stream_res.abm;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index ed3cc3648e8e..06789ac3a224 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -88,8 +88,7 @@ void dce110_edp_wait_for_hpd_ready(
 		bool power_up);
 
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp);
+	struct set_backlight_level_params *params);
 void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 void dce110_set_pipe(struct pipe_ctx *pipe_ctx);
 void dce110_disable_link_output(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 1ea95f8d4cbc..630e05f32c80 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -242,14 +242,15 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 }
 
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp)
+	struct set_backlight_level_params *params)
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	uint32_t otg_inst;
+	uint32_t backlight_pwm_u16_16 = params->backlight_pwm_u16_16;
+	uint32_t frame_ramp = params->frame_ramp;
 
 	if (!abm || !tg || !panel_cntl)
 		return false;
@@ -257,7 +258,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	otg_inst = tg->inst;
 
 	if (dc->dc->res_pool->dmcu) {
-		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
+		dce110_set_backlight_level(pipe_ctx, params);
 		return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
index 9cee9bdb8de9..a7eaaa4596be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
@@ -50,8 +50,7 @@ void dcn21_PLAT_58856_wa(struct dc_state *context,
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx);
 void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp);
+	struct set_backlight_level_params *params);
 bool dcn21_is_abm_supported(struct dc *dc,
 		struct dc_state *context, struct dc_stream_state *stream);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 2f56c36e4251..1df17c54f3a9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -174,6 +174,11 @@ union block_sequence_params {
 	struct fams2_global_control_lock_fast_params fams2_global_control_lock_fast_params;
 };
 
+struct set_backlight_level_params {
+	uint32_t backlight_pwm_u16_16;
+	uint32_t frame_ramp;
+};
+
 enum block_sequence_func {
 	DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST = 0,
 	OPTC_PIPE_CONTROL_LOCK,
@@ -365,8 +370,7 @@ struct hw_sequencer_funcs {
 	void (*clear_status_bits)(struct dc *dc, unsigned int mask);
 
 	bool (*set_backlight_level)(struct pipe_ctx *pipe_ctx,
-			uint32_t backlight_pwm_u16_16,
-			uint32_t frame_ramp);
+		struct set_backlight_level_params *params);
 
 	void (*set_abm_immediate_disable)(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index cbea36916d35..43a467f6ce7b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -521,13 +521,13 @@ bool edp_set_backlight_level(const struct dc_link *link,
 		uint32_t frame_ramp)
 {
 	struct dc  *dc = link->ctx->dc;
-
 	DC_LOGGER_INIT(link->ctx->logger);
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
 
 	if (dc_is_embedded_signal(link->connector_signal)) {
 		struct pipe_ctx *pipe_ctx = get_pipe_from_link(link);
+		struct set_backlight_level_params backlight_level_param = { 0 };
 
 		if (link->panel_cntl)
 			link->panel_cntl->stored_backlight_registers.USER_LEVEL = backlight_pwm_u16_16;
@@ -542,10 +542,12 @@ bool edp_set_backlight_level(const struct dc_link *link,
 			return false;
 		}
 
+		backlight_level_param.backlight_pwm_u16_16 = backlight_pwm_u16_16;
+		backlight_level_param.frame_ramp = frame_ramp;
+
 		dc->hwss.set_backlight_level(
 				pipe_ctx,
-				backlight_pwm_u16_16,
-				frame_ramp);
+				&backlight_level_param);
 	}
 	return true;
 }
-- 
2.45.2

