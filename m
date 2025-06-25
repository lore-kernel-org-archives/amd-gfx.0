Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769BEC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E12810E657;
	Wed, 25 Jun 2025 04:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0a9EgLm5";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8184210E659
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxTJIaFHuafIp6VOK9gt02EE9a/wABHJpFepOegQYY5D6s02ToOZKV0Cdyxlg8M+kH7g0hBEIaiHivmvAjol0QF1scUn3ky9ozaYcf22iPztgbZQGg2c2XirPPzp39qNqNHSQoucUqUu4cKa9oQa7m+yMA4E3QHj1j5Ui0D2djK7nEjnJlI0aSthHAbBk+apuxlnhCYWRsp3FgtfVs1h1nnkabDe5avboBKppdHey9CcgxcpC1cM71giFESoipUEBFqslYDWDI/U3N//3wMhIEj0rGYlHrU5Vm50ZaPKBzaylyui9JOiyUQxsoxME7PkXUIqRsf0EO4GmBmIvtkVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PZesYBo6kgzTpd2FjM7tg4eAbb1irRThsvpX1EoEdQ=;
 b=gecR/+BlrZgTiGTnAuuW9vevHT7gZqirjIlIloF0vJWDBZ91zO5pYXV3oX2MHHVDUYbrXTyuq5yt6nAXickdNZHsMfA5s2gjHBFJzgz2Rm61xcJvgPkQM1jEyqojsp/iKApNCWh51TyewViYXiiFMex65wNLIbfhnIfqsziwxaNTQ1eEXFEJpuZLzF939QUUH+287BX9HZx6vugKelQKM2CsvKhkrHsxId8vU9u7H8n3LbDpMVRoCH9EbLG5p5ybqpOmvzv3kgZpGUQ59Ah+4xudVLBvXLn1eein/kW+AypGvTjk/IvrltOe0C/9LdxvHDGZ87Wwl149BISTO4yZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PZesYBo6kgzTpd2FjM7tg4eAbb1irRThsvpX1EoEdQ=;
 b=0a9EgLm53YZZPNWdcbO5B4iIeO3M/G1gWMDh/wettXHfV0dxY+pieihlLl4beszJtTCLxUxMpQXxtE5JEDKncAJl41vowj9lsWzp/AO2m/CvgB+Nm8bi4BPQHdL9FbKUP9GOPb2Du9ZVox0gAA6A8Pn029HmFecmQ6lwbkm3xHM=
Received: from DS7PR03CA0042.namprd03.prod.outlook.com (2603:10b6:5:3b5::17)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 25 Jun
 2025 04:05:44 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::cb) by DS7PR03CA0042.outlook.office365.com
 (2603:10b6:5:3b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 04:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:43 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:39 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Michael
 Strauss" <michael.strauss@amd.com>, George Shen <george.shen@amd.com>, "Mike
 Katsnelson" <mike.katsnelson@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 08/11] drm/amd/display: Fix Link Override Sequencing When
 Switching Between DIO/HPO
Date: Wed, 25 Jun 2025 12:02:26 +0800
Message-ID: <20250625040420.886013-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1e9cf0-f48b-4318-e5a1-08ddb39d8ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukvnpe4wM3zIFKcMof75w1vaPSqFHE+fHJqlEldNw2VjNEPOYuo3EongsHN0?=
 =?us-ascii?Q?hO6rm2NAbDS9JkseoqSf32KCKe6l9ADLpo9tTXWUeMmI5Bfk8e5so2OL0SaH?=
 =?us-ascii?Q?rB+/qVIncc343SrhowtWxQ6A1756TlhUVtSEtgGv679XGWR0GLxG9peMvVIj?=
 =?us-ascii?Q?u/iO6DEU9mEhA52KVu/JQxH82jcQZvrqTrtC16s5x8wcagaxOo1/39ZtZ2qN?=
 =?us-ascii?Q?HhHdk0Rcrzqj6AUZO1pZo5cC4T6VI9ncK7u3q2G9Y7IM9gAK3rsHjKe4MhkK?=
 =?us-ascii?Q?9Gb54YET1noPyNERbWIVWE7E4WiYXQoj/wqSpmIk7fPETmvPDA74vB0/M/9V?=
 =?us-ascii?Q?mws465p55flgL+JfpKq0b6HGr0Bekdu4O3w7AB/Y/7nFJuflTOoTcDq2Qhm/?=
 =?us-ascii?Q?MSYaBLAvedx4+cL6gNp7NDgB9NizK8xVbRhrjf3d0LMvbZ7sTvektwYmicOh?=
 =?us-ascii?Q?jTpyb5+z2jrfMlloe//AghJn9Zd541P8bbHwJ889uDxFLtRkvQvbmuGgtLyU?=
 =?us-ascii?Q?57a36tSa8sP5Mo0LeOeiKPev4f35/yM1nqoC2EGCqbMTQKiPGPO0q2MeWxYz?=
 =?us-ascii?Q?6by+YA2t87uSTeq6NY0gPi7aULMZchskfqdUBcegU0Pp1oVdBe1ujZgzf/jG?=
 =?us-ascii?Q?l1V8McrirPBQ7n9QhZiIBhzrOPkitZEXr8cJTf+fn5q6NS6dYh2bEEE5/+mj?=
 =?us-ascii?Q?8BvFf6c3COvBnw9daDOdC1uWpHJ/JUuFj9nukNNufRsTTAIEP1PtAat0jDWq?=
 =?us-ascii?Q?nrr7KhJLCLlFXpmmj37JAYWrwnYiqY9j2kmbr8scyL4AMV7Gj+eYBAEgSicp?=
 =?us-ascii?Q?YG90j/GgpRTaZ4XUPef/UHOo2BZ4Bm+hWLqm35i5Er8MySBY62JPGSVjo9xI?=
 =?us-ascii?Q?Os/Oj51JL9AgZ57ridZmiktGJzI2kjJgjGXxmpro7n8DTFAZNg7I1u9h6lxU?=
 =?us-ascii?Q?x4q4GshSGeVP5eOaEiRMhOOYvxGJiFnP2SZ5kW+reTQtE8jk7rHyIFm9+oE7?=
 =?us-ascii?Q?QmXILII8LYU6DmTOg3Dv2Jw8dqQNTkpE6qH0mGQjvnhKGmA/w5daJ6jCx26w?=
 =?us-ascii?Q?6PGzjQqhHbjg9CSTtSloqkzonRswj6G9GIBWdPenp2jpIyHwPVSvSffdPbId?=
 =?us-ascii?Q?NGmPptrX9vYhlPSHy8gTCi/GteY3phHtgdC5xa0MNgnAn8MQOoNBOaXiKYUe?=
 =?us-ascii?Q?MKNfig6sJ/7ZqGxO0ZJKi0AbN17ihR/brrt46pos0eOb5CrgNJlGvRReuVkO?=
 =?us-ascii?Q?YrNFFuLZNRhsWFiUC6+bwLJHlXa09/67ItDigygKR00y8a/UtYNCs3iPXsP0?=
 =?us-ascii?Q?uhHoWtGXWoxammxUWCb9lgP2a2dzcVzWpAjTuOMBtOms7OuBug0rfMk94+9S?=
 =?us-ascii?Q?3KD0PajebS8qEl3oztDnDhiMNNRsOrJGckHuKmd+sguDUVwblvU9GOWklEb/?=
 =?us-ascii?Q?cqUNTpiU60I+dV59sS23pO1v8RLfNFP9QzuRsrkrPh2R6Dh7Qa0zP2hRatAZ?=
 =?us-ascii?Q?XdTng5cvzlAMUf4cDvNvTC6Q7rhSH/M0ZnW9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:44.4531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1e9cf0-f48b-4318-e5a1-08ddb39d8ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
When performing certain link maintenance compliance tests or forcing link
settings, changing between 128b/132b and 8b/10b rates no longer works on
some ASICs. Some rate divider updates only occur when we set
timings or validate state, which is not performed currently when toggling
DPMS to change rates.

[HOW]
Re-calculate dividers and reprogram audio when switching between DIO
and HPO through DP compliance/escape code path.
Add OTG disable/re-enable so we don't touch the clock while OTG is active.
Acquire dcLock before forcing link settings to avoid thread synchronization
errors due to added programming in escape code path and potential HPD
interrupts.

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Mike Katsnelson <mike.katsnelson@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |  4 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++
 .../display/dc/link/accessories/link_dp_cts.c | 63 +++++++++++++++++--
 .../dc/resource/dcn31/dcn31_resource.c        | 36 ++++++++++-
 .../dc/resource/dcn31/dcn31_resource.h        |  6 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  4 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  4 +-
 .../dc/resource/dcn316/dcn316_resource.c      |  4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  4 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  4 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  4 +-
 12 files changed, 126 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 542468224789..252e862449a2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1381,7 +1381,7 @@ static void populate_audio_dp_link_info(
 	}
 }
 
-static void build_audio_output(
+void build_audio_output(
 	struct dc_state *state,
 	const struct pipe_ctx *pipe_ctx,
 	struct audio_output *audio_output)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index 06789ac3a224..7cd8c1576988 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -110,5 +110,9 @@ void dce110_enable_dp_link_output(
 		enum signal_type signal,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings);
+void build_audio_output(
+		struct dc_state *state,
+		const struct pipe_ctx *pipe_ctx,
+		struct audio_output *audio_output);
 #endif /* __DC_HWSS_DCE110_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index e88a016fb7a9..c9454fe1cd05 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -223,6 +223,11 @@ struct resource_funcs {
 			const struct dc_stream_state *stream);
 	bool (*program_mcache_pipe_config)(struct dc_state *context,
 		const struct dc_mcache_params *mcache_params);
+	enum dc_status (*update_dc_state_for_encoder_switch)(struct dc_link *link,
+		struct dc_link_settings *link_setting,
+		uint8_t pipe_count,
+		struct pipe_ctx *pipes,
+		struct audio_output *audio_output);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 96febabf464a..2956c2b3ad1a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -34,6 +34,7 @@
 #include "dm_helpers.h"
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "clk_mgr.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
@@ -67,10 +68,17 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 {
 	struct pipe_ctx *pipes[MAX_PIPES];
 	struct dc_state *state = link->dc->current_state;
+	struct dc_stream_update stream_update = { 0 };
+	bool dpms_off = false;
+	bool needs_divider_update = false;
 	bool was_hpo_acquired = resource_is_hpo_acquired(link->dc->current_state);
 	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
+	struct audio_output audio_output[MAX_PIPES];
+
+	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
+	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
 
 	udelay(100);
 
@@ -83,16 +91,59 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 				link->dc,
 				state,
 				pipes[i]);
+
+		// Disable OTG and re-enable after updating clocks
+		pipes[i]->stream_res.tg->funcs->disable_crtc(pipes[i]->stream_res.tg);
 	}
 
-	if (link->dc->hwss.setup_hpo_hw_control) {
-		is_hpo_acquired = resource_is_hpo_acquired(state);
-		if (was_hpo_acquired != is_hpo_acquired)
-			link->dc->hwss.setup_hpo_hw_control(link->dc->hwseq, is_hpo_acquired);
+	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
+		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
+				link_setting, count,
+				*pipes, &audio_output[0]);
+		for (i = 0; i < count; i++) {
+			pipes[i]->clock_source->funcs->program_pix_clk(
+					pipes[i]->clock_source,
+					&pipes[i]->stream_res.pix_clk_params,
+					link->dc->link_srv->dp_get_encoding_format(&pipes[i]->link_config.dp_link_settings),
+					&pipes[i]->pll_settings);
+
+			if (pipes[i]->stream_res.audio != NULL) {
+				const struct link_hwss *link_hwss = get_link_hwss(
+					link, &pipes[i]->link_res);
+
+				link_hwss->setup_audio_output(pipes[i], &audio_output[i],
+						pipes[i]->stream_res.audio->inst);
+
+				pipes[i]->stream_res.audio->funcs->az_configure(
+						pipes[i]->stream_res.audio,
+						pipes[i]->stream->signal,
+						&audio_output[i].crtc_info,
+						&pipes[i]->stream->audio_info,
+						&audio_output[i].dp_link_info);
+
+				if (link->dc->config.disable_hbr_audio_dp2 &&
+						pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio &&
+						link->dc->link_srv->dp_is_128b_132b_signal(pipes[i]))
+					pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio(pipes[i]->stream_res.audio);
+			}
+		}
 	}
 
-	for (i = count-1; i >= 0; i--)
-		link_set_dpms_on(state, pipes[i]);
+	// Toggle on HPO I/O if necessary
+	is_hpo_acquired = resource_is_hpo_acquired(state);
+	if (was_hpo_acquired != is_hpo_acquired && link->dc->hwss.setup_hpo_hw_control)
+		link->dc->hwss.setup_hpo_hw_control(link->dc->hwseq, is_hpo_acquired);
+
+	for (i = 0; i < count; i++)
+		pipes[i]->stream_res.tg->funcs->enable_crtc(pipes[i]->stream_res.tg);
+
+	// Set DPMS on with stream update
+	for (i = 0; i < state->stream_count; i++)
+		if (state->streams[i] && state->streams[i]->link && state->streams[i]->link == link) {
+			stream_update.stream = state->streams[i];
+			stream_update.dpms_off = &dpms_off;
+			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, state->streams[i], &stream_update);
+		}
 }
 
 static void dp_test_send_link_training(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 2a33c82cfedb..88afa59d17b0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1850,7 +1850,9 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn31_get_panel_config_defaults,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
 static struct clock_source *dcn30_clock_source_create(
@@ -2231,3 +2233,35 @@ struct resource_pool *dcn31_create_resource_pool(
 	kfree(pool);
 	return NULL;
 }
+
+enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
+	struct dc_link_settings *link_setting,
+	uint8_t pipe_count,
+	struct pipe_ctx *pipes,
+	struct audio_output *audio_output)
+{
+	struct dc_state *state = link->dc->current_state;
+	int i;
+
+#if defined(CONFIG_DRM_AMD_DC_FP)
+	for (i = 0; i < state->stream_count; i++)
+		if (state->streams[i] && state->streams[i]->link && state->streams[i]->link == link)
+			link->dc->hwss.calculate_pix_rate_divider((struct dc *)link->dc, state, state->streams[i]);
+
+	for (i = 0; i < pipe_count; i++) {
+		link->dc->res_pool->funcs->build_pipe_pix_clk_params(&pipes[i]);
+
+		// Setup audio
+		if (pipes[i].stream_res.audio != NULL)
+			build_audio_output(state, &pipes[i], &audio_output[i]);
+	}
+#else
+	/* This DCN requires rate divider updates and audio reprogramming to allow DP1<-->DP2 link rate switching,
+	 * but the above will not compile on architectures without an FPU.
+	 */
+	DC_LOG_WARNING("%s: DP1<-->DP2 link retraining will not work on this DCN on non-FPU platforms", __func__);
+	ASSERT(0);
+#endif
+
+	return DC_OK;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index 1456bcf01ad2..c32c85ef0ba4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -66,6 +66,12 @@ struct resource_pool *dcn31_create_resource_pool(
 unsigned int dcn31_get_det_buffer_size(
 	const struct dc_state *context);
 
+enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
+	struct dc_link_settings *link_setting,
+	uint8_t pipe_count,
+	struct pipe_ctx *pipes,
+	struct audio_output *audio_output);
+
 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
 #define regPHYPLLF_PIXCLK_RESYNC_CNTL 0x007e
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index cec03e81c6bd..dedf7bce6ece 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1779,7 +1779,9 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.get_panel_config_defaults = dcn314_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn314_get_preferred_eng_id_dpia,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index ac15c7c33abf..d110be626bc2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1844,7 +1844,9 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.get_panel_config_defaults = dcn315_get_panel_config_defaults,
 	.get_power_profile = dcn315_get_power_profile,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 2b7e61622579..939811858ff7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1720,7 +1720,9 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn316_get_panel_config_defaults,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
 static bool dcn316_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 145c66898577..e327dee9be21 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1786,7 +1786,9 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn35_get_preferred_eng_id_dpia,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
 static bool dcn35_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index dfd5aa6ba165..2f2976afc229 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1758,7 +1758,9 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn351_get_preferred_eng_id_dpia,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
 static bool dcn351_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index beecc0180071..5b7848496a70 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1759,7 +1759,9 @@ static struct resource_funcs dcn36_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn36_get_preferred_eng_id_dpia,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
 static bool dcn36_resource_construct(
-- 
2.43.0

