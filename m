Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF03CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BD810E4CC;
	Tue, 26 May 2026 07:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJzBbODw";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2326510E4C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRQ+Amxc40msme9aCNxf/2nJZAqdDF2G7GgGeWtjvZ8p+Ls50G0P7eRjav9HiZOcIn9sN4XtyTKxZ5VINWUK2+/oAQTaRUk2Zoo8Ki8oG0dYJd5fjKcJ3wZIZc6cMUV4pZkKSiWMeiMOAJEFtkKQ5jncU5ARUzVhfEaJpWcBq7+HzbWRiQsHBEzOYwRnkGzv4XmwNxIzifV7eZMm0r9fT3V/2PNoiNYgUjCW9rw6MyRRf4DMjY47BvLW287wEFiA69MyxXgYpB+asdri5iSt2lPT0DXPoGRNzpY/W3j2C/ECY479yKQfNKMgpE4Dkb9YszCki99lpEidt4zeZ5SSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3MXOYD1V8kXDKfj7wkIkKkNAVbLc/h5xg0iKqcNV7k=;
 b=YReL4Mj0f1Wuc8Sfo8sQjstlbEpgD2j0d1hlyqD64W94XLTEOqKA3QSqzY++T0ICGDlhn5G55jqfsfX3OyKTNjQn+SvckdMrc/JA2MowdwT6yiD2VmZvZF0Cvr8UuQ/rcuycSXLm4y3ME+jYWp+35jvhXMOCnR25xKAgat06ctkU68PRoNkYkbWhyDHxlBl3yxm/QN74a8NyWtHwJBTDT2GGpML/hbcPMYqYM/xEjoOrGk4wYM4WL1j046EFvs6cvu6lpTHHBbzrqgIHDNIRUzDIx9hKXf4Cj2k+jD5bSxIhN2sscV/bsT23kFlHUmOtljBVxTNox8dmX/FLMkhqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3MXOYD1V8kXDKfj7wkIkKkNAVbLc/h5xg0iKqcNV7k=;
 b=uJzBbODwrTVpM3Al3WCzXEc5bZv7jF7375p0BitejTwK8MgykxBTQixtwHo+t5YFLALzp9i/8/afxr30+TVxHBO2T3JlXSZB8uS6aU7H8toCEgpyYn+GPEx5e+EdD8gvPkdyG5F64lYAPwFLEPW+lI2iCc3UPWPX2F6na6Wb8Lk=
Received: from PH7P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::26)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:15:18 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::11) by PH7P221CA0031.outlook.office365.com
 (2603:10b6:510:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:15:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:15:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:15:10 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:15:01 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 06/41] drm/amd/display: Add DCN42 PMO init_for_pstate_support
Date: Tue, 26 May 2026 15:01:29 +0800
Message-ID: <20260526071413.2181251-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f424cb6-64fb-44aa-a4b5-08debaf68a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|3023799007|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: pId5Qh/d+9Cv9WoAH2DwLerY6Xpu66ZBHuGudgTVhIfdES+PYEzcAyoL5cdfyuas8yTfuvYiiYXvDMdEZYEz30u+qSRU0EDcxHP5j9tlUUUQjkXkuFyK9rT1DKd2hcSfCku0YdU/dZoSRnjdUoa/0bm51da/6jBkKW2v7KQKeVEYC5c91Q2t53T4qIMXDLieBHHQw3VJj2NPhVNmS/EBg4sLeuL0AHvltDHsTZ77YdEP0fg0et1Wa2F3wpWch9FX7mtUEkGJ3A8/KfFe7oe7DM6U4RcdfPnC6o8Bkbuwl2GJ4hYDfNjlCbZ7eOxT3gRKtWo6/VHzqBE/qY96aXnlyMJNhYVPDR571S6zvh/9F7SsG83/giN5SOPSnDcB4A74MBa3NpNN8bmj01r79e76eRlo3KmmNSqodjM2rXxnnknpvwEjGJ1Rn5dQk2O6a870Aa7Cj163DBOj9dvgSxDOXmp926dmo/hurHBsriYgROTdQEVteuzxbsHIg2VnBM/NP3H6Zfkg0v+2R/hLSDvskM8yk67SCptGpMWwdQu25Us0lcGI2iZ8FZcisdtjaLQF8oEfj91Xs4/vc8yvb1kW4tJLK1bQ/HeziAWrVwy7WWkyxWp6PF0kBKX89Rlm6wWQuWN+tMr+Jj0Nxr6/WoM9B2lUWTn6d6MbFwPP+AQG9o3JDHvckybx8MeAKNUvb50n+GDdCiG5i6iBTjtEQHYdepOlv/UIS34RRYQtbdCj85k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(3023799007)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9XMsNIPjV/1rvC1bEFjIWFecTqpLNBnEoJWMpTDcJqeEmoXOF0tjGyXT5HBXNFWrtLkYBUe/si6TAptSLwQ8/GHrW1Jj9pi+rvWjKdqsRikdGySKMBiQv5ZrX/zZ4eAx/4PPA+q62y41OtWcZ7y7YW0TS3TKkgL1S/7RjAMYcLaU+XIj4gZLIq42Jm5ERK1PdT1g3lIrc/3MXH9d/zNkxVNOsugbHWhacG6p7cvrRj6udoyXK4cNphM753v8DGV16lwOR+pHvl34zxdgX0mnrbzP3Gqbx0m/qRPQKfuAHBtz0OZhm/GDFn6+TWEYTNzbXyj/+JfaDSdSwQRgkluGZPcll6lumDQqCWGfexUCcPO2n8XAUDJ9zG7ST0pXxeiNo7mQRcixBtILaZ3/oSv57hgPEcGAxCU5FR54sMmAUatXGaEu5DiRDrSAf4glh8AV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:15:17.9163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f424cb6-64fb-44aa-a4b5-08debaf68a61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why & How]
Add pmo_dcn42_init_for_pstate_support mirroring the DCN4 FAMS2 version,
but dropping the meta build for scheduling check that is unnecessary and
skipping the cofunctionality check.

This solves vrr validation issues in multidisplay configs.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       | 107 +++++++++++++++---
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  34 +++---
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |  46 ++++++--
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   2 +-
 5 files changed, 152 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
index 4e0d757388ca..790aef95caa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
@@ -63,25 +63,24 @@ static bool is_bit_set_in_bitfield(unsigned int bit_field, unsigned int bit_offs
 	return false;
 }
 
+static void dcn42_set_bit_in_bitfield(unsigned int *bit_field, unsigned int bit_offset)
+{
+	*bit_field = *bit_field | (0x1 << bit_offset);
+}
+
 static void setup_planes_for_vactive_by_mask(struct display_configuation_with_meta *display_config,
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
 {
 	unsigned int plane_index;
-	unsigned int stream_index;
 	struct dml2_plane_parameters *plane;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
 		if (is_bit_set_in_bitfield(plane_mask, plane_index)) {
 			plane = &display_config->display_config.plane_descriptors[plane_index];
-			stream_index = display_config->display_config.plane_descriptors[plane_index].stream_index;
 
 			plane->overrides.reserved_vblank_time_ns = (long)math_max2(pmo->soc_bb->power_management_parameters.dram_clk_change_blackout_us * 1000.0,
 					plane->overrides.reserved_vblank_time_ns);
-			if (!pmo->options->disable_vactive_det_fill_bw_pad) {
-				display_config->display_config.plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us[dml2_pstate_type_uclk] =
-					(unsigned int)math_floor(pmo->scratch.pmo_dcn4.stream_pstate_meta[stream_index].method_vactive.max_vactive_det_fill_delay_us);
-			}
 
 			display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_vactive;
 		}
@@ -118,7 +117,6 @@ static bool setup_display_config(struct display_configuation_with_meta *display_
 {
 	struct dml2_pmo_scratch *scratch = &pmo->scratch;
 
-	bool fams2_required = false;
 	bool success = true;
 	unsigned int stream_index;
 
@@ -134,15 +132,96 @@ static bool setup_display_config(struct display_configuation_with_meta *display_
 		}
 	}
 
-	/* copy FAMS2 meta */
-	if (success) {
-		display_config->stage3.fams2_required = fams2_required;
-		memcpy(&display_config->stage3.stream_pstate_meta,
-			&scratch->pmo_dcn4.stream_pstate_meta,
-			sizeof(struct dml2_pstate_meta) * DML2_MAX_PLANES);
+	return success;
+}
+
+bool pmo_dcn42_init_for_pstate_support(struct dml2_pmo_init_for_pstate_support_in_out *in_out)
+{
+	struct dml2_pmo_instance *pmo = in_out->instance;
+	struct dml2_optimization_stage3_state *state = &in_out->base_display_config->stage3;
+	struct dml2_pmo_scratch *s = &pmo->scratch;
+
+	struct display_configuation_with_meta *display_config;
+	const struct dml2_plane_parameters *plane_descriptor;
+	const struct dml2_pmo_pstate_strategy *strategy_list = NULL;
+	struct dml2_pmo_pstate_strategy override_base_strategy = { 0 };
+	unsigned int strategy_list_size = 0;
+	unsigned int plane_index, stream_index, i;
+	bool build_override_strategy = true;
+
+	state->performed = true;
+	in_out->base_display_config->stage3.min_clk_index_for_latency = in_out->base_display_config->stage1.min_clk_index_for_latency;
+
+	display_config = in_out->base_display_config;
+	display_config->display_config.overrides.enable_subvp_implicit_pmo = true;
+
+	memset(s, 0, sizeof(struct dml2_pmo_scratch));
+
+	if (display_config->display_config.num_streams == 0)
+		return false;
+
+	pmo->scratch.pmo_dcn4.min_latency_index = in_out->base_display_config->stage1.min_clk_index_for_latency;
+	pmo->scratch.pmo_dcn4.max_latency_index = pmo->mcg_clock_table_size;
+	pmo->scratch.pmo_dcn4.cur_latency_index = in_out->base_display_config->stage1.min_clk_index_for_latency;
+
+	// First build the stream plane mask (array of bitfields indexed by stream, indicating plane mapping)
+	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
+		plane_descriptor = &display_config->display_config.plane_descriptors[plane_index];
+
+		dcn42_set_bit_in_bitfield(&s->pmo_dcn4.stream_plane_mask[plane_descriptor->stream_index], plane_index);
+
+		state->pstate_switch_modes[plane_index] = dml2_pstate_method_vactive;
+
+		build_override_strategy &= plane_descriptor->overrides.uclk_pstate_change_strategy != dml2_uclk_pstate_change_strategy_auto;
+		override_base_strategy.per_stream_pstate_method[plane_descriptor->stream_index] =
+				dcn4_uclk_pstate_strategy_override_to_pstate_method(plane_descriptor->overrides.uclk_pstate_change_strategy);
 	}
 
-	return success;
+	// Figure out which streams can do vactive, and also build up implicit SVP and FAMS2 meta
+	for (stream_index = 0; stream_index < display_config->display_config.num_streams; stream_index++) {
+		if (dcn4_get_vactive_pstate_margin(display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) >= (int)(MIN_VACTIVE_MARGIN_PCT * pmo->soc_bb->power_management_parameters.dram_clk_change_blackout_us))
+			dcn42_set_bit_in_bitfield(&s->pmo_dcn4.stream_vactive_capability_mask, stream_index);
+	}
+
+	if (build_override_strategy) {
+		/* build expanded override strategy list (no permutations) */
+		override_base_strategy.allow_state_increase = true;
+		s->pmo_dcn4.num_expanded_override_strategies = 0;
+		dcn4_insert_strategy_into_expanded_list(&override_base_strategy,
+				display_config->display_config.num_streams,
+				s->pmo_dcn4.expanded_override_strategy_list,
+				&s->pmo_dcn4.num_expanded_override_strategies);
+		dcn4_expand_variant_strategy(&override_base_strategy,
+				display_config->display_config.num_streams,
+				false,
+				s->pmo_dcn4.expanded_override_strategy_list,
+				&s->pmo_dcn4.num_expanded_override_strategies);
+
+		/* use override strategy list */
+		strategy_list = s->pmo_dcn4.expanded_override_strategy_list;
+		strategy_list_size = s->pmo_dcn4.num_expanded_override_strategies;
+	} else {
+		/* use predefined strategy list */
+		strategy_list = dcn4_get_expanded_strategy_list(&pmo->init_data, display_config->display_config.num_streams);
+		strategy_list_size = dcn4_get_num_expanded_strategies(&pmo->init_data, display_config->display_config.num_streams);
+	}
+
+	if (!strategy_list || strategy_list_size == 0)
+		return false;
+
+	s->pmo_dcn4.num_pstate_candidates = 0;
+
+	for (i = 0; i < strategy_list_size && s->pmo_dcn4.num_pstate_candidates < DML2_PMO_PSTATE_CANDIDATE_LIST_SIZE; i++) {
+		dcn4_insert_into_candidate_list(&strategy_list[i], display_config->display_config.num_streams, s);
+	}
+
+	if (s->pmo_dcn4.num_pstate_candidates > 0) {
+		s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.num_pstate_candidates-1].allow_state_increase = true;
+		s->pmo_dcn4.cur_pstate_candidate = -1;
+		return true;
+	} else {
+		return false;
+	}
 }
 
 bool pmo_dcn42_fams2_optimize_for_pstate_support(struct dml2_pmo_optimize_for_pstate_support_in_out *in_out)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
index 5db7877bb8ca..5b11c47874bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
@@ -12,6 +12,7 @@ struct dml2_pmo_initialize_in_out;
 struct dml2_pmo_test_for_pstate_support_in_out;
 
 bool pmo_dcn42_initialize(struct dml2_pmo_initialize_in_out *in_out);
+bool pmo_dcn42_init_for_pstate_support(struct dml2_pmo_init_for_pstate_support_in_out *in_out);
 bool pmo_dcn42_fams2_optimize_for_pstate_support(struct dml2_pmo_optimize_for_pstate_support_in_out *in_out);
 bool pmo_dcn42_test_for_pstate_support(struct dml2_pmo_test_for_pstate_support_in_out *in_out);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 8301e23ab89f..d5f20c85006e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -391,7 +391,7 @@ static enum dml2_pstate_method convert_strategy_to_drr_variant(const enum dml2_p
 	return variant_strategy;
 }
 
-static struct dml2_pmo_pstate_strategy *get_expanded_strategy_list(struct dml2_pmo_init_data *init_data, int stream_count)
+struct dml2_pmo_pstate_strategy *dcn4_get_expanded_strategy_list(struct dml2_pmo_init_data *init_data, int stream_count)
 {
 	struct dml2_pmo_pstate_strategy *expanded_strategy_list = NULL;
 
@@ -415,14 +415,14 @@ static struct dml2_pmo_pstate_strategy *get_expanded_strategy_list(struct dml2_p
 	return expanded_strategy_list;
 }
 
-static unsigned int get_num_expanded_strategies(
+unsigned int dcn4_get_num_expanded_strategies(
 	struct dml2_pmo_init_data *init_data,
 	int stream_count)
 {
 	return init_data->pmo_dcn4.num_expanded_strategies_per_list[stream_count - 1];
 }
 
-static void insert_strategy_into_expanded_list(
+void dcn4_insert_strategy_into_expanded_list(
 	const struct dml2_pmo_pstate_strategy *per_stream_pstate_strategy,
 	const int stream_count,
 	struct dml2_pmo_pstate_strategy *expanded_strategy_list,
@@ -478,7 +478,7 @@ static void expand_base_strategy(
 
 			if (i >= stream_count - 1) {
 				/* insert into strategy list */
-				insert_strategy_into_expanded_list(&cur_strategy_list, stream_count, expanded_strategy_list, num_expanded_strategies);
+				dcn4_insert_strategy_into_expanded_list(&cur_strategy_list, stream_count, expanded_strategy_list, num_expanded_strategies);
 				expanded_strategy_added = true;
 			} else {
 				/* skip to next stream */
@@ -539,7 +539,7 @@ static bool is_variant_method_valid(const struct dml2_pmo_pstate_strategy *base_
 	return valid;
 }
 
-static void expand_variant_strategy(
+void dcn4_expand_variant_strategy(
 		const struct dml2_pmo_pstate_strategy *base_strategy,
 		const unsigned int stream_count,
 		const bool should_permute,
@@ -599,7 +599,7 @@ static void expand_variant_strategy(
 					expand_base_strategy(&variant_strategy, stream_count, expanded_strategy_list, num_expanded_strategies);
 				} else {
 					/* no permutations allowed, so add to list now */
-					insert_strategy_into_expanded_list(&variant_strategy, stream_count, expanded_strategy_list, num_expanded_strategies);
+					dcn4_insert_strategy_into_expanded_list(&variant_strategy, stream_count, expanded_strategy_list, num_expanded_strategies);
 				}
 			}
 
@@ -639,7 +639,7 @@ void pmo_dcn4_fams2_expand_base_pstate_strategies(
 	/* expand every explicit base strategy (except all DRR) */
 	for (i = 0; i < num_base_strategies; i++) {
 		expand_base_strategy(&base_strategies_list[i], stream_count, expanded_strategy_list, num_expanded_strategies);
-		expand_variant_strategy(&base_strategies_list[i], stream_count, true, expanded_strategy_list, num_expanded_strategies);
+		dcn4_expand_variant_strategy(&base_strategies_list[i], stream_count, true, expanded_strategy_list, num_expanded_strategies);
 	}
 }
 
@@ -1180,14 +1180,14 @@ static bool all_timings_support_svp(const struct dml2_pmo_instance *pmo,
 	return true;
 }
 
-static void insert_into_candidate_list(const struct dml2_pmo_pstate_strategy *pstate_strategy, int stream_count, struct dml2_pmo_scratch *scratch)
+void dcn4_insert_into_candidate_list(const struct dml2_pmo_pstate_strategy *pstate_strategy, int stream_count, struct dml2_pmo_scratch *scratch)
 {
 	(void)stream_count;
 	scratch->pmo_dcn4.pstate_strategy_candidates[scratch->pmo_dcn4.num_pstate_candidates] = *pstate_strategy;
 	scratch->pmo_dcn4.num_pstate_candidates++;
 }
 
-static enum dml2_pstate_method uclk_pstate_strategy_override_to_pstate_method(const enum dml2_uclk_pstate_change_strategy override_strategy)
+enum dml2_pstate_method dcn4_uclk_pstate_strategy_override_to_pstate_method(const enum dml2_uclk_pstate_change_strategy override_strategy)
 {
 	enum dml2_pstate_method method = dml2_pstate_method_na;
 
@@ -1884,6 +1884,10 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 
 	memset(s, 0, sizeof(struct dml2_pmo_scratch));
 
+	if (display_config->display_config.overrides.all_streams_blanked) {
+		return true;
+	}
+
 	pmo->scratch.pmo_dcn4.min_latency_index = in_out->base_display_config->stage1.min_clk_index_for_latency;
 	pmo->scratch.pmo_dcn4.max_latency_index = pmo->mcg_clock_table_size;
 	pmo->scratch.pmo_dcn4.cur_latency_index = in_out->base_display_config->stage1.min_clk_index_for_latency;
@@ -1898,7 +1902,7 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 
 		build_override_strategy &= plane_descriptor->overrides.uclk_pstate_change_strategy != dml2_uclk_pstate_change_strategy_auto;
 		override_base_strategy.per_stream_pstate_method[plane_descriptor->stream_index] =
-				uclk_pstate_strategy_override_to_pstate_method(plane_descriptor->overrides.uclk_pstate_change_strategy);
+				dcn4_uclk_pstate_strategy_override_to_pstate_method(plane_descriptor->overrides.uclk_pstate_change_strategy);
 	}
 
 	// Figure out which streams can do vactive, and also build up implicit SVP and FAMS2 meta
@@ -1920,11 +1924,11 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 		/* build expanded override strategy list (no permutations) */
 		override_base_strategy.allow_state_increase = true;
 		s->pmo_dcn4.num_expanded_override_strategies = 0;
-		insert_strategy_into_expanded_list(&override_base_strategy,
+		dcn4_insert_strategy_into_expanded_list(&override_base_strategy,
 				display_config->display_config.num_streams,
 				s->pmo_dcn4.expanded_override_strategy_list,
 				&s->pmo_dcn4.num_expanded_override_strategies);
-		expand_variant_strategy(&override_base_strategy,
+		dcn4_expand_variant_strategy(&override_base_strategy,
 				display_config->display_config.num_streams,
 				false,
 				s->pmo_dcn4.expanded_override_strategy_list,
@@ -1935,8 +1939,8 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 		strategy_list_size = s->pmo_dcn4.num_expanded_override_strategies;
 	} else {
 		/* use predefined strategy list */
-		strategy_list = get_expanded_strategy_list(&pmo->init_data, display_config->display_config.num_streams);
-		strategy_list_size = get_num_expanded_strategies(&pmo->init_data, display_config->display_config.num_streams);
+		strategy_list = dcn4_get_expanded_strategy_list(&pmo->init_data, display_config->display_config.num_streams);
+		strategy_list_size = dcn4_get_num_expanded_strategies(&pmo->init_data, display_config->display_config.num_streams);
 	}
 
 	if (!strategy_list || strategy_list_size == 0)
@@ -1946,7 +1950,7 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 
 	for (i = 0; i < strategy_list_size && s->pmo_dcn4.num_pstate_candidates < DML2_PMO_PSTATE_CANDIDATE_LIST_SIZE; i++) {
 		if (validate_pstate_support_strategy_cofunctionality(pmo, display_config, &strategy_list[i])) {
-			insert_into_candidate_list(&strategy_list[i], display_config->display_config.num_streams, s);
+			dcn4_insert_into_candidate_list(&strategy_list[i], display_config->display_config.num_streams, s);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h
index f0afa8002a2f..7828fe5a4232 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h
@@ -9,14 +9,6 @@
 
 struct display_configuation_with_meta;
 
-int dcn4_get_vactive_pstate_margin(
-	const struct display_configuation_with_meta *display_cfg,
-	int plane_mask);
-
-int dcn4_get_minimum_reserved_time_us_for_planes(
-	const struct display_configuation_with_meta *display_config,
-	int plane_mask);
-
 bool pmo_dcn4_fams2_initialize(struct dml2_pmo_initialize_in_out *in_out);
 
 bool pmo_dcn4_fams2_optimize_dcc_mcache(struct dml2_pmo_optimize_dcc_mcache_in_out *in_out);
@@ -40,4 +32,42 @@ void pmo_dcn4_fams2_expand_base_pstate_strategies(
 	struct dml2_pmo_pstate_strategy *expanded_strategy_list,
 	unsigned int *num_expanded_strategies);
 
+/* Helpers shared with derived PMO implementations (e.g. DCN42). */
+int dcn4_get_vactive_pstate_margin(
+	const struct display_configuation_with_meta *display_cfg,
+	int plane_mask);
+
+int dcn4_get_minimum_reserved_time_us_for_planes(
+	const struct display_configuation_with_meta *display_config,
+	int plane_mask);
+
+enum dml2_pstate_method dcn4_uclk_pstate_strategy_override_to_pstate_method(
+	const enum dml2_uclk_pstate_change_strategy override_strategy);
+
+struct dml2_pmo_pstate_strategy *dcn4_get_expanded_strategy_list(
+	struct dml2_pmo_init_data *init_data,
+	int stream_count);
+
+unsigned int dcn4_get_num_expanded_strategies(
+	struct dml2_pmo_init_data *init_data,
+	int stream_count);
+
+void dcn4_insert_strategy_into_expanded_list(
+	const struct dml2_pmo_pstate_strategy *per_stream_pstate_strategy,
+	const int stream_count,
+	struct dml2_pmo_pstate_strategy *expanded_strategy_list,
+	unsigned int *num_expanded_strategies);
+
+void dcn4_expand_variant_strategy(
+	const struct dml2_pmo_pstate_strategy *base_strategy,
+	const unsigned int stream_count,
+	const bool should_permute,
+	struct dml2_pmo_pstate_strategy *expanded_strategy_list,
+	unsigned int *num_expanded_strategies);
+
+void dcn4_insert_into_candidate_list(
+	const struct dml2_pmo_pstate_strategy *pstate_strategy,
+	int stream_count,
+	struct dml2_pmo_scratch *scratch);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
index a1164de13a05..21109a19f177 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
@@ -67,7 +67,7 @@ bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *
 		out->test_for_vmin = pmo_dcn4_fams2_test_for_vmin;
 		out->optimize_for_vmin = pmo_dcn4_fams2_optimize_for_vmin;
 
-		out->init_for_uclk_pstate = pmo_dcn4_fams2_init_for_pstate_support;
+		out->init_for_uclk_pstate = pmo_dcn42_init_for_pstate_support;
 		out->test_for_uclk_pstate = pmo_dcn42_test_for_pstate_support;
 		out->optimize_for_uclk_pstate = pmo_dcn42_fams2_optimize_for_pstate_support;
 
-- 
2.43.0

