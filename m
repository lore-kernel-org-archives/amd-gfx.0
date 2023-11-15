Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA183C54FB9
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4155F10E588;
	Wed, 15 Nov 2023 19:44:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E4510E583
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nre5hG6d63KGMc/e1XXgG7adhxpg+4JuK/IwCBT3TsITXBYdUPmhlpGmOLyqLC19vv+dbeNn7xuyK2u+lKwBMyaXuYd0d9wMS9NRshC95MRYzMh6BzzeEmUHvKECpGi4gmo6N8B5otEq9OmmTvdKETnVYRcHr4gObAH4vinl3i12Ux7+318jTKShknj+g6B0ZYcZ65KPioAI6HK7gfmtYX46LX+9yrIZZTLoVQtp940vLOHBTmnHLnCKKhzsskxJSByx87lQiis6aZoeIu0retTblalR4KvIH5wj/1C9VaBrELqh195fsQNVClLOgYa7XVyT2iVj/gALXo1nZwrwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n+ZuVAK/GEXVD5syziglSB1kjIUt40j5YUcjykueFM=;
 b=lhX+BmZlIGkgU8TgVW85qIazGZCafAcO0K6UBrYmu4uygM0A/vQq7DTsEI1F/EF6kEPcHceTRAqMisGmWJseamzdT5en6o00hD9171A/svpV1LwT5i5+W1k9mV1e9ygTpAOtA3dYRhvJVuSE0i1a2TSUdgWVZ1xrfBqVXlQdf2rhh6PQBf5686spRw8mZ0rWXCgfZsd4ozc8DjBrffcem9NswnZyyluG6lSA5/n6R50tX9i9VqG4iTfOchW4C8Nz5tDPyCEyiCnc/71FP7S5SY2oloh+C5FLlrini1tgOs7Sp3nY5NgljVBrFFeFHTjMsNQgKlb0WLz1F3bP9kraEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n+ZuVAK/GEXVD5syziglSB1kjIUt40j5YUcjykueFM=;
 b=AeBXDSxadThlB+/CSV19T4zf3j2oXNT+7EeJ7SyPEY0tmMlSzUKWvD/Drc98wOQ944nYKAqvXRDtBKQKtRofQVNT0aqcnwUn8sdo5g5VmL05BA4Ko/AlCbKc3bwLFaY4ENI8MCOk4m6FD0FjzrLfUJdcU5a9YPF5YKQVEQIoHw8=
Received: from BL1PR13CA0118.namprd13.prod.outlook.com (2603:10b6:208:2b9::33)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:34 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::83) by BL1PR13CA0118.outlook.office365.com
 (2603:10b6:208:2b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:34 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:31 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/35] drm/amd/display: Enable SubVP on 1080p60 displays
Date: Wed, 15 Nov 2023 14:40:34 -0500
Message-ID: <20231115194332.39469-22-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2745c44a-cdc1-49e5-f06e-08dbe6134b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYmWblArE0eCPM0347HEkYOMCalZNyfEv0bMc/ZxO9oCrXs8hJqt1l+JfuXRk74ujT2Mrse3BrG7OwK2IgYPbVC2hVOp4HlmKDqIvQSjuqc6cVt6/ixmUYv+GhYagXc6T8rP9JtDdGpvoY49ibVKXdvtW79y2umMsgy77MsUl1uFspFYAxQxo96LCL6NNtus0cCKfkYNyDaM4X5Wd1qeOoje/jdP9UNZMxmdd7P81GCebQvagbo8Iu/6JNCk7J80wZ3EjJlSpRjtHeS+b3jqrHC+1JOeldhQis9RP/Z2BmcS/+n+VXvpbNn/mef6A+hWappXbMXRJPn8eSpGu2XRgNOCcGfVCzrai2pAsAnphZSjX95gugwhGZn+c7Glo0Xj5tOu6y45gEt7YoWAgyM3hL2n7Vcpn5wsc5yUOsh+f6qmYCsMMTkiTEd8A5A/DNLZJ4N4A70wJh6wm8YulYQvczkiYYWkB9Opq2czvbixgdFpYSDxsP1kQ0KYXbO0ikIyc4R1SUtAHeL+QEKE6UJHMmvTHEkccbGzEFCvtk5N+2aK5cCQ0szwN5Mhf+ifLqy83SciZL6R1Fl2wtJjjoaPqw+GtD0WX62AxQJqjMUWYxXEh10kuRTFfKxXKwcsTPI2cF5RBWtBxZGNtjxJpZNn55Q5Jmju5eBEV4UnXF70zuLGVkihNe8UJJN+T557CiLYxIMSOvXn/Mf8E0AW0A565h8jFARmUi4IVvur6mys3yghpF3TFhpPy0gR+r7glWf4HRaXkpgAZtiYX118Dz6fHIQ3p9E7MfbrtHnR2+ca1jX0HUTdipmsM2YUy9+aEn2E
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(356005)(40480700001)(81166007)(83380400001)(36860700001)(54906003)(8936002)(8676002)(4326008)(70586007)(70206006)(336012)(426003)(36756003)(41300700001)(47076005)(1076003)(16526019)(26005)(2616005)(478600001)(2906002)(40460700003)(44832011)(82740400003)(6916009)(316002)(5660300002)(86362001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:34.7562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2745c44a-cdc1-49e5-f06e-08dbe6134b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Previously SubVP would never be selected on 1080p60 displays because
  it has too much vactive margin. However, implement a change to allow
  it like how 1440p60 is allowed.
- Add a new struct such that we have a list of allowed modes for
  enabling subvp with vactive margin (currently 1080p60 and 1440p60)
- Also ensure to block drr + vblank cases to prevent unexpected
  enablement of new display configs
- Update SW cursor fallback for these new potential cases as well

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 32 ++++++++++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 41 +++++++++++--------
 .../dc/resource/dcn32/dcn32_resource.h        | 10 +++++
 4 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 84d632700949..f3a9fdd2340d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5316,7 +5316,7 @@ bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_st
 	if (dc->current_state->stream_count == 1 && stream->timing.v_addressable >= 2880 &&
 			((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
 		return true;
-	else if (dc->current_state->stream_count > 1 && stream->timing.v_addressable >= 2160 &&
+	else if (dc->current_state->stream_count > 1 && stream->timing.v_addressable >= 1080 &&
 			((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
 		return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index ef0a2b01734d..389ac7ae1154 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -665,6 +665,30 @@ bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int widt
 	return is_native_scaling;
 }
 
+/**
+ * disallow_subvp_in_active_plus_blank() - Function to determine disallowed subvp + drr/vblank configs
+ *
+ * @pipe: subvp pipe to be used for the subvp + drr/vblank config
+ *
+ * Since subvp is being enabled on more configs (such as 1080p60), we want
+ * to explicitly block any configs that we don't want to enable. We do not
+ * want to enable any 1080p60 (SubVP) + drr / vblank configs since these
+ * are already convered by FPO.
+ *
+ * Return: True if disallowed, false otherwise
+ */
+static bool disallow_subvp_in_active_plus_blank(struct pipe_ctx *pipe)
+{
+	bool disallow = false;
+
+	if (resource_is_pipe_type(pipe, OPP_HEAD) &&
+			resource_is_pipe_type(pipe, DPP_PIPE)) {
+		if (pipe->stream->timing.v_addressable == 1080 && pipe->stream->timing.h_addressable == 1920)
+			disallow = true;
+	}
+	return disallow;
+}
+
 /**
  * dcn32_subvp_drr_admissable() - Determine if SubVP + DRR config is admissible
  *
@@ -688,6 +712,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 	bool drr_pipe_found = false;
 	bool drr_psr_capable = false;
 	uint64_t refresh_rate = 0;
+	bool subvp_disallow = false;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -697,6 +722,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				subvp_count++;
 
+				subvp_disallow |= disallow_subvp_in_active_plus_blank(pipe);
 				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
 					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
@@ -713,7 +739,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 		}
 	}
 
-	if (subvp_count == 1 && non_subvp_pipes == 1 && drr_pipe_found && !drr_psr_capable &&
+	if (subvp_count == 1 && !subvp_disallow && non_subvp_pipes == 1 && drr_pipe_found && !drr_psr_capable &&
 		((uint32_t)refresh_rate < 120))
 		result = true;
 
@@ -746,6 +772,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	bool vblank_psr_capable = false;
 	uint64_t refresh_rate = 0;
+	bool subvp_disallow = false;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -755,6 +782,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				subvp_count++;
 
+				subvp_disallow |= disallow_subvp_in_active_plus_blank(pipe);
 				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
 					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
@@ -772,7 +800,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 	}
 
 	if (subvp_count == 1 && non_subvp_pipes == 1 && !drr_pipe_found && !vblank_psr_capable &&
-		((uint32_t)refresh_rate < 120) &&
+		((uint32_t)refresh_rate < 120) && !subvp_disallow &&
 		vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_vblank_w_mall_sub_vp)
 		result = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 92e2ddc9ab7e..c4ffb4b92b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -45,6 +45,14 @@ static const struct subvp_high_refresh_list subvp_high_refresh_list = {
 				{.width = 1920, .height = 1080, }},
 };
 
+static const struct subvp_active_margin_list subvp_active_margin_list = {
+			.min_refresh = 55,
+			.max_refresh = 65,
+			.res = {
+				{.width = 2560, .height = 1440, },
+				{.width = 1920, .height = 1080, }},
+};
+
 struct _vcs_dpi_ip_params_st dcn3_2_ip = {
 	.gpuvm_enable = 0,
 	.gpuvm_max_page_table_levels = 4,
@@ -3295,25 +3303,24 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
 {
 	bool allow = false;
 	uint32_t refresh_rate = 0;
+	uint32_t min_refresh = subvp_active_margin_list.min_refresh;
+	uint32_t max_refresh = subvp_active_margin_list.max_refresh;
+	uint32_t i;
 
-	/* Allow subvp on displays that have active margin for 2560x1440@60hz displays
-	 * only for now. There must be no scaling as well.
-	 *
-	 * For now we only enable on 2560x1440@60hz displays to enable 4K60 + 1440p60 configs
-	 * for p-state switching.
-	 */
-	if (pipe->stream && pipe->plane_state) {
-		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
-						pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
-						/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
-		if (pipe->stream->timing.v_addressable == 1440 &&
-				pipe->stream->timing.h_addressable == 2560 &&
-				refresh_rate >= 55 && refresh_rate <= 65 &&
-				pipe->plane_state->src_rect.height == 1440 &&
-				pipe->plane_state->src_rect.width == 2560 &&
-				pipe->plane_state->dst_rect.height == 1440 &&
-				pipe->plane_state->dst_rect.width == 2560)
+	for (i = 0; i < SUBVP_ACTIVE_MARGIN_LIST_LEN; i++) {
+		uint32_t width = subvp_active_margin_list.res[i].width;
+		uint32_t height = subvp_active_margin_list.res[i].height;
+
+		refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
+			pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+		refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
+		refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
+
+		if (refresh_rate >= min_refresh && refresh_rate <= max_refresh &&
+				dcn32_check_native_scaling_for_res(pipe, width, height)) {
 			allow = true;
+			break;
+		}
 	}
 	return allow;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index b931008114c9..b2f20e6cfb38 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -39,6 +39,7 @@
 #define DCN3_2_MBLK_HEIGHT_8BPE 64
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
 #define SUBVP_HIGH_REFRESH_LIST_LEN 4
+#define SUBVP_ACTIVE_MARGIN_LIST_LEN 2
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
 
@@ -57,6 +58,15 @@ struct subvp_high_refresh_list {
 	} res[SUBVP_HIGH_REFRESH_LIST_LEN];
 };
 
+struct subvp_active_margin_list {
+	int min_refresh;
+	int max_refresh;
+	struct {
+		int width;
+		int height;
+	} res[SUBVP_ACTIVE_MARGIN_LIST_LEN];
+};
+
 struct dcn32_resource_pool {
 	struct resource_pool base;
 };
-- 
2.42.0

