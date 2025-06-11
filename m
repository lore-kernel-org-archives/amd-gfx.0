Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F1BC71149
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3DF10E6FD;
	Wed, 11 Jun 2025 18:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jvdgBPh9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D74B10E6E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdnitWV0jH3MtIBh4RtikUE/SlUEyRq01XF7R8aG77IJyhMH8cAtN5yxw3iD1X2R+Bj/w/WaM8B0N/vHIOswukmdKCFayXl0OBi3KorUSBuVdNrmzy9jH5H7jY6sKfFoeO7Gv0w1GArEZNLL9BpAIfK6D3vn1TH2jfvZqQtWaqZmnPVXLKvhb89ukmnUHQF4ywHQfPaM7F+Kr7NSYwAmRaFtCWgOtDtKsZvBtoCUN1nIfQo9BZsOR+npDq16khWx8mLCHs7NxHVMl/04u0gLXvjGE9UiyCxCJVEEprBsV+FRlFwj6VpZWmcebk+JYt2Ia7PgTgpk/jFSvqdC1b+RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZStQ6OWawQOjNzXaDFTQgYwv5wXLLETUnsNlTF9utXA=;
 b=Yh/P3fH/WnGN0oYWBsi9DfAClU61XxgkkW+AjXkzXg6MsDvopgd6J65yevDqyF5mgVWlKoVt8dMje6ix5KYhvUzd6IUnB45EAaAXwrpFbPe/o9gZXoGe+cuXwEw+68GjpmaAxK6ArbmulYr+PCU8jP6ETpCT32XGe7C4vj5SLe+s+tPDvVErmDFfcBJSvIZqQ0LY/hpCF7/aVadNYJp3kVPvUryf9eVdZ8OjJl+GE5iL59nc32yNT7m7QXRnFRueKhWyztzeWsE+fvYtItXlwTnDn3lo6CtfYyoBy5RW7P/muA9X0CKlFcBpj+MBvqb4WiAowcyMC5lHqcj1DeCAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZStQ6OWawQOjNzXaDFTQgYwv5wXLLETUnsNlTF9utXA=;
 b=jvdgBPh9wyB8JZJ+VFCXHTt2zyZOI7KopZ6uBiOamdHFr+IdVQP+dWBDvEZQVI8a00UiUC0YsZ+w1CECAbJgk0rJslt/TDfahbvxEL7rp7AZLW0L7iPXF0VAjfIjbcWndKsRbOb9dAppvicA4mvDaL3AnfWmrXtpFKP5PMPsMgk=
Received: from BN8PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:70::14)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Wed, 11 Jun
 2025 18:41:17 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::3a) by BN8PR04CA0001.outlook.office365.com
 (2603:10b6:408:70::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Wed,
 11 Jun 2025 18:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:13 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Yan Li <yan.li@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 02/10] drm/amd/display: remove use_native_pstate_optimization
Date: Wed, 11 Jun 2025 14:39:52 -0400
Message-ID: <20250611184111.517494-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecc324c-9a9c-4280-d77e-08dda9178cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?llp7fC5LyPUmcb/QvfUCqj5dmsiset+ESRlo8bWrEndbdSUaIR0Wh99G9aTR?=
 =?us-ascii?Q?r7bkYd1HLOcJQrqlmsSuCBgk9h4t4iDggYV2tkto+5bb5LNzYCI9VDtrGxWC?=
 =?us-ascii?Q?L/WxU6PO9/xX0XzabyVkIROn6WEHJt8gIjRu8UDYQiOW8iv/F6m9QpBnK7so?=
 =?us-ascii?Q?tL4lKQhnBNDRFMxzuh4PZtUi9I0wv3WTznTEdDVFHRqiwBoNcen0eqJWGMBf?=
 =?us-ascii?Q?odxGCh2DOc5oy0/UPhmhEa4wXIq/oiCgSE9LdkPwwbI1brH+mSoBiADR3mV6?=
 =?us-ascii?Q?8O/W54Ib56dCgMlAO0WGrwflok/sKKCnyPiQjCvM9hi1xC+S1AKM9e7DHCt4?=
 =?us-ascii?Q?sonFSbr5t8D2p2vndRzFx7QaNDDGZY2w0MvS0SJqLM6dH5ABAwcasdnnyWFa?=
 =?us-ascii?Q?H2Uv0z5+im8iKOr+8XmBXkv+8jitlsaM49UhSHPANG2PTG+YSZust0L6dNfo?=
 =?us-ascii?Q?AMDRxLZG6ox/YsHIffth7iFptsWX4DFWZ2rjwDRh9ou7WC8ooxZpuIMGFXvQ?=
 =?us-ascii?Q?w2cQAwfCt0koiHmsLieBsgdBSD/xf8H2fw/5AahvoopX9lXmjwF/LZ3ZTh5h?=
 =?us-ascii?Q?Srz8xcbFQjy02a6bDsR3TUbW/Br0Mu01HNnIDwbrIh/zWErLy+Jaa7CWRn+x?=
 =?us-ascii?Q?AtgcHyDhsofJ3pgGCPVN5HvdoxK67MSahlB2Y4IZA0PX8x6iCJA9m1FuspTJ?=
 =?us-ascii?Q?6h7Ue2oVLO3YBQ8u5O7qMUCIBbGrIHjANRzGNQU5osn/993svo82jX99suTo?=
 =?us-ascii?Q?dy9iA0D4TkS2d/RI5BfUyViMJNDsXI7Y/tH5d7YNpQ8e38zK/6lAhNSkFNTr?=
 =?us-ascii?Q?2xA1avOHtjaLGErOrrGMJcP5eGPqmO2b+xzwWyoyqVjd2Sqr/KXrdl+ohy+F?=
 =?us-ascii?Q?glEV7wibu1HI5wUuM/ILoz5iDzWAQFt48qbq+YskVlTUkKGzLV+10NqFx7O4?=
 =?us-ascii?Q?+dsrSfMgq+Xu2pUe3RfDZjs3/YiflcYwGMnNUGZLXFeoFyxe1R8u118/soPU?=
 =?us-ascii?Q?95TvnGqdoRvFt9cy8XgUMyMdjj4rnRRTcvvmNfyn19vlfOJE38oHcygKJFai?=
 =?us-ascii?Q?UGKXVBvKHtsSUt6FCm7jeSsRxb116zAVyetOk/v8rT3MxRYHs0JJBdSoYGFt?=
 =?us-ascii?Q?sW9NaI5PPZBz5kdX7c1moLReiyLfFthm8dJYE8LaZyXcf7xpDySjr2EguIdW?=
 =?us-ascii?Q?h0dfJiJ9wjtCZdCg0KWeV9Ve3VNsqTVNs9DF9xAiBLEQUwiOVmHR+rHBU0gD?=
 =?us-ascii?Q?MwXOOegwi/kF0mU5anhIDbaUz+fw5M76mwNej+TemBsTmW98NzyF6u7h3sdS?=
 =?us-ascii?Q?kwTldtdf1+nZx2dP2jK/m3lTVzU8C483mXjF3rfk2v9suY9wqEXqChrTkaSC?=
 =?us-ascii?Q?2PGC744TgJE5MQ8VCvoIE9sQLX5DLV7FMJvbuY39+SwbixPCg4ViNfOs3Ox8?=
 =?us-ascii?Q?ERznUtVIrIVszglliccJA++phdPaOTZVfKaDu39+guzwsGdWl0C9sIasuK8K?=
 =?us-ascii?Q?0VzAv6HkD7f0CHniP+vVxSWBoCY8ilPzQdbA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:16.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecc324c-9a9c-4280-d77e-08dda9178cb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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

From: Yan Li <yan.li@amd.com>

[Why]
In DML2 (not DML2.1), DCN35 and DCN351 have the
default value for use_native_pstate_optimization
set to true. The code path where this bit is
false is not used.

[How]
Remove the bit and the corresponding code path
when it is set to false.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Yan Li <yan.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c |  19 --
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 198 +-----------------
 .../dc/resource/dcn32/dcn32_resource.c        |   1 -
 .../dc/resource/dcn321/dcn321_resource.c      |   1 -
 .../dc/resource/dcn35/dcn35_resource.c        |   1 -
 .../dc/resource/dcn351/dcn351_resource.c      |   1 -
 .../dc/resource/dcn36/dcn36_resource.c        |   1 -
 .../dc/resource/dcn401/dcn401_resource.c      |   1 -
 8 files changed, 3 insertions(+), 220 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 208630754c8a..3b866e876bf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -1189,22 +1189,6 @@ static unsigned int map_plane_to_dml_display_cfg(const struct dml2_context *dml2
 	return location;
 }
 
-static void apply_legacy_svp_drr_settings(struct dml2_context *dml2, const struct dc_state *state, struct dml_display_cfg_st *dml_dispcfg)
-{
-	int i;
-
-	if (state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
-		ASSERT(state->stream_count == 1);
-		dml_dispcfg->timing.DRRDisplay[0] = true;
-	} else if (state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid) {
-
-		for (i = 0; i < dml_dispcfg->num_timings; i++) {
-			if (dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i] == state->streams[state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index]->stream_id)
-				dml_dispcfg->timing.DRRDisplay[i] = true;
-		}
-	}
-}
-
 static void dml2_populate_pipe_to_plane_index_mapping(struct dml2_context *dml2, struct dc_state *state)
 {
 	unsigned int i;
@@ -1437,9 +1421,6 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 			}
 		}
 	}
-
-	if (!dml2->config.use_native_pstate_optimization)
-		apply_legacy_svp_drr_settings(dml2, context, dml_dispcfg);
 }
 
 void dml2_update_pipe_ctx_dchub_regs(struct _vcs_dpi_dml_display_rq_regs_st *rq_regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 6c7e8aa85e7b..0524a33a88b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -115,10 +115,8 @@ static unsigned int pack_and_call_dml_mode_support_ex(struct dml2_context *dml2,
 static bool optimize_configuration(struct dml2_context *dml2, struct dml2_wrapper_optimize_configuration_params *p)
 {
 	int unused_dpps = p->ip_params->max_num_dpp;
-	int i, j;
-	int odms_needed, refresh_rate_hz, dpps_needed, subvp_height, pstate_width_fw_delay_lines, surface_count;
-	int subvp_timing_to_add, new_timing_index, subvp_surface_to_add, new_surface_index;
-	float frame_time_sec, max_frame_time_sec;
+	int i;
+	int odms_needed;
 	int largest_blend_and_timing = 0;
 	bool optimization_done = false;
 
@@ -133,79 +131,6 @@ static bool optimize_configuration(struct dml2_context *dml2, struct dml2_wrappe
 	if (p->new_display_config != p->cur_display_config)
 		*p->new_display_config = *p->cur_display_config;
 
-	// Optimize P-State Support
-	if (dml2->config.use_native_pstate_optimization) {
-		if (p->cur_mode_support_info->DRAMClockChangeSupport[0] == dml_dram_clock_change_unsupported) {
-			// Find a display with < 120Hz refresh rate with maximal refresh rate that's not already subvp
-			subvp_timing_to_add = -1;
-			subvp_surface_to_add = -1;
-			max_frame_time_sec = 0;
-			surface_count = 0;
-			for (i = 0; i < (int) p->cur_display_config->num_timings; i++) {
-				refresh_rate_hz = (int)div_u64((unsigned long long) p->cur_display_config->timing.PixelClock[i] * 1000 * 1000,
-					(p->cur_display_config->timing.HTotal[i] * p->cur_display_config->timing.VTotal[i]));
-				if (refresh_rate_hz < 120) {
-					// Check its upstream surfaces to see if this one could be converted to subvp.
-					dpps_needed = 0;
-				for (j = 0; j < (int) p->cur_display_config->num_surfaces; j++) {
-					if (p->cur_display_config->plane.BlendingAndTiming[j] == i &&
-						p->cur_display_config->plane.UseMALLForPStateChange[j] == dml_use_mall_pstate_change_disable) {
-						dpps_needed += p->cur_mode_support_info->DPPPerSurface[j];
-						subvp_surface_to_add = j;
-						surface_count++;
-					}
-				}
-
-				if (surface_count == 1 && dpps_needed > 0 && dpps_needed <= unused_dpps) {
-					frame_time_sec = (float)1 / refresh_rate_hz;
-					if (frame_time_sec > max_frame_time_sec) {
-						max_frame_time_sec = frame_time_sec;
-						subvp_timing_to_add = i;
-						}
-					}
-				}
-			}
-			if (subvp_timing_to_add >= 0) {
-				new_timing_index = p->new_display_config->num_timings++;
-				new_surface_index = p->new_display_config->num_surfaces++;
-				// Add a phantom pipe reflecting the main pipe's timing
-				dml2_util_copy_dml_timing(&p->new_display_config->timing, new_timing_index, subvp_timing_to_add);
-
-				pstate_width_fw_delay_lines = (int)(((double)(p->config->svp_pstate.subvp_fw_processing_delay_us +
-					p->config->svp_pstate.subvp_pstate_allow_width_us) / 1000000) *
-				(p->new_display_config->timing.PixelClock[subvp_timing_to_add] * 1000 * 1000) /
-				(double)p->new_display_config->timing.HTotal[subvp_timing_to_add]);
-
-				subvp_height = p->cur_mode_support_info->SubViewportLinesNeededInMALL[subvp_timing_to_add] + pstate_width_fw_delay_lines;
-
-				p->new_display_config->timing.VActive[new_timing_index] = subvp_height;
-				p->new_display_config->timing.VTotal[new_timing_index] = subvp_height +
-				p->new_display_config->timing.VTotal[subvp_timing_to_add] - p->new_display_config->timing.VActive[subvp_timing_to_add];
-
-				p->new_display_config->output.OutputDisabled[new_timing_index] = true;
-
-				p->new_display_config->plane.UseMALLForPStateChange[subvp_surface_to_add] = dml_use_mall_pstate_change_sub_viewport;
-
-				dml2_util_copy_dml_plane(&p->new_display_config->plane, new_surface_index, subvp_surface_to_add);
-				dml2_util_copy_dml_surface(&p->new_display_config->surface, new_surface_index, subvp_surface_to_add);
-
-				p->new_display_config->plane.ViewportHeight[new_surface_index] = subvp_height;
-				p->new_display_config->plane.ViewportHeightChroma[new_surface_index] = subvp_height;
-				p->new_display_config->plane.ViewportStationary[new_surface_index] = false;
-
-				p->new_display_config->plane.UseMALLForStaticScreen[new_surface_index] = dml_use_mall_static_screen_disable;
-				p->new_display_config->plane.UseMALLForPStateChange[new_surface_index] = dml_use_mall_pstate_change_phantom_pipe;
-
-				p->new_display_config->plane.NumberOfCursors[new_surface_index] = 0;
-
-				p->new_policy->ImmediateFlipRequirement[new_surface_index] = dml_immediate_flip_not_required;
-
-				p->new_display_config->plane.BlendingAndTiming[new_surface_index] = new_timing_index;
-
-				optimization_done = true;
-			}
-		}
-	}
 
 	// Optimize Clocks
 	if (!optimization_done) {
@@ -428,119 +353,6 @@ static bool dml_mode_support_wrapper(struct dml2_context *dml2,
 	return result;
 }
 
-static int find_drr_eligible_stream(struct dc_state *display_state)
-{
-	int i;
-
-	for (i = 0; i < display_state->stream_count; i++) {
-		if (dc_state_get_stream_subvp_type(display_state, display_state->streams[i]) == SUBVP_NONE
-			&& display_state->streams[i]->ignore_msa_timing_param) {
-			// Use ignore_msa_timing_param flag to identify as DRR
-			return i;
-		}
-	}
-
-	return -1;
-}
-
-static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct dc_state *display_state,
-		enum dc_validate_mode validate_mode)
-{
-	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
-	bool pstate_optimization_done = false;
-	bool pstate_optimization_success = false;
-	bool result = false;
-	int drr_display_index = 0, non_svp_streams = 0;
-	bool force_svp = dml2->config.svp_pstate.force_enable_subvp;
-
-	display_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
-	display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid = false;
-
-	result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
-
-	if (!result) {
-		pstate_optimization_done = true;
-	} else if (s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported && !force_svp) {
-		pstate_optimization_success = true;
-		pstate_optimization_done = true;
-	}
-
-	if (display_state->stream_count == 1 && dml2->config.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch(dml2->config.callbacks.dc, display_state)) {
-			display_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = true;
-
-			result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
-	} else {
-		non_svp_streams = display_state->stream_count;
-
-		while (!pstate_optimization_done) {
-			result = dml_mode_programming(&dml2->v20.dml_core_ctx, s->mode_support_params.out_lowest_state_idx, &s->cur_display_config, true);
-
-			// Always try adding SVP first
-			if (result)
-				result = dml2_svp_add_phantom_pipe_to_dc_state(dml2, display_state, &s->mode_support_info);
-			else
-				pstate_optimization_done = true;
-
-
-			if (result) {
-				result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
-			} else {
-				pstate_optimization_done = true;
-			}
-
-			if (result) {
-				non_svp_streams--;
-
-				if (s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported) {
-					if (dml2_svp_validate_static_schedulability(dml2, display_state, s->mode_support_info.DRAMClockChangeSupport[0])) {
-						pstate_optimization_success = true;
-						pstate_optimization_done = true;
-					} else {
-						pstate_optimization_success = false;
-						pstate_optimization_done = false;
-					}
-				} else {
-					drr_display_index = find_drr_eligible_stream(display_state);
-
-					// If there is only 1 remaining non SubVP pipe that is DRR, check static
-					// schedulability for SubVP + DRR.
-					if (non_svp_streams == 1 && drr_display_index >= 0) {
-						if (dml2_svp_drr_schedulable(dml2, display_state, &display_state->streams[drr_display_index]->timing)) {
-							display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid = true;
-							display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index = drr_display_index;
-							result = dml_mode_support_wrapper(dml2, display_state,
-										validate_mode);
-						}
-
-						if (result && s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported) {
-							pstate_optimization_success = true;
-							pstate_optimization_done = true;
-						} else {
-							pstate_optimization_success = false;
-							pstate_optimization_done = false;
-						}
-					}
-
-					if (pstate_optimization_success) {
-						pstate_optimization_done = true;
-					} else {
-						pstate_optimization_done = false;
-					}
-				}
-			}
-		}
-	}
-
-	if (!pstate_optimization_success) {
-		dml2_svp_remove_all_phantom_pipes(dml2, display_state);
-		display_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
-		display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid = false;
-		result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
-	}
-
-	return result;
-}
-
 static bool call_dml_mode_support_and_programming(struct dc_state *context, enum dc_validate_mode validate_mode)
 {
 	unsigned int result = 0;
@@ -561,11 +373,7 @@ static bool call_dml_mode_support_and_programming(struct dc_state *context, enum
 		ASSERT(min_state_for_g6_temp_read >= 0);
 	}
 
-	if (!dml2->config.use_native_pstate_optimization) {
-		result = optimize_pstate_with_svp_and_drr(dml2, context, validate_mode);
-	} else {
-		result = dml_mode_support_wrapper(dml2, context, validate_mode);
-	}
+	result = dml_mode_support_wrapper(dml2, context, validate_mode);
 
 	/* Upon trying to sett certain frequencies in FRL, min_state_for_g6_temp_read is reported as -1. This leads to an invalid value of min_state causing crashes later on.
 	 * Use the default logic for min_state only when min_state_for_g6_temp_read is a valid value. In other cases, use the value calculated by the DML directly.
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index d2d321eec221..9ffa10189eee 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2514,7 +2514,6 @@ static bool dcn32_resource_construct(
 	}
 
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
-	dc->dml2_options.use_native_pstate_optimization = false;
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index c2f12030928f..c53266e16c58 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -2013,7 +2013,6 @@ static bool dcn321_resource_construct(
 	}
 
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
-	dc->dml2_options.use_native_pstate_optimization = false;
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 353189ac0d53..145c66898577 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2157,7 +2157,6 @@ static bool dcn35_resource_construct(
 	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
 
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
-	dc->dml2_options.use_native_pstate_optimization = true;
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = false;
 	if (dc->config.EnableMinDispClkODM)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index f9fd36567130..dfd5aa6ba165 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -2129,7 +2129,6 @@ static bool dcn351_resource_construct(
 	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
 
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
-	dc->dml2_options.use_native_pstate_optimization = true;
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = false;
 	if (dc->config.EnableMinDispClkODM)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 37b18575c376..beecc0180071 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -2130,7 +2130,6 @@ static bool dcn36_resource_construct(
 	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
 
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
-	dc->dml2_options.use_native_pstate_optimization = true;
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = false;
 	if (dc->config.EnableMinDispClkODM)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 14f478df268a..a9d989f20405 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -2208,7 +2208,6 @@ static bool dcn401_resource_construct(
 		dc->config.sdpif_request_limit_words_per_umc = 16;
 
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
-	dc->dml2_options.use_native_pstate_optimization = false;
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = true;
 	dc->dml2_options.map_dc_pipes_with_callbacks = true;
-- 
2.49.0

