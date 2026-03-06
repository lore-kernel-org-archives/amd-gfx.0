Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770E5F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9E410E2F5;
	Fri,  6 Mar 2026 03:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gAcsrxo5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6587F10E2F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dyj+hfOkhVD0iVpa4XkBJwH2ueIqzJpvEoCcIHa3pb5Kdx1sfXvoo8JUU+Q7XNJKbUxdiVLyuvjKMEaZRVGovWyX2VGnUGvUeuqtOIpns0vYQNyUgOK9Ugv9ODsBO8SpHuGNsQtYifkijZ8G0OqaG039m6wD4Ckn+JucdVDL7eqV14fi/h5Vo2caPiyeELoWlI9/22JKetIINDb+cYstF5GqW5tu7YUTnYY2u7xUGswRMsW11xhCsx9P/M/Wt7TWiVhzIYYWfvKJkThtsyvKLpsY1UpIUMWvy+3U/VwWMo5Eex7GTqsMmI2uAgGw+HFCnYL4yLQvH7ncw0JkYeUWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuThdPlgz6Gsn4HA4tC9FCKoP8Iyg77xgtb62XgR8eY=;
 b=qAYXgPG6rOvEurdQFr8leUkAO/KfqulYYPcx3HtCdYxOzqmPRajpDUyNFr2uUDGUfR+JXgTWTQNkThYGVId2zU4414Y7W+5ChY4bnfGigLEBn39/d8gjjS8fLmv5x8O9o8ix/kZ/QenLSy/SqGduxdTq2FxwDVzrGyW7II99yS1vwhD8HtcPtgbeD/rFMLxyj6f2qkRa+i9RIWvqslB1aji9GKAmJ/9K8mi7urAJCtjzoucmMPVC+1grWARGZKBYoIhUSQW+gLn0xaDPkLuy20k2Kitx9QweIX5z1yxH9O0EmlUZz81n7yz85BwHiOHeebS2Ved3Znn6IzNPb1/FWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuThdPlgz6Gsn4HA4tC9FCKoP8Iyg77xgtb62XgR8eY=;
 b=gAcsrxo5cYatoPWiZIxT69egGqsv9SWwQ86DMgfDYVsikrviXk38TszTGBWQ+sfx+NNAfIUWv4NkvWfDoHjR7CuwV5IQjBxPXKzMCpz4aiu6ZNTflOzJp+OjI4hg/UlEcsmm//BG9z4KrUjq09TnHsDPvNhroU39dviJe8VXWyQ=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:24:27 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::43) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:24:26 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:24:24 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 03/21] drm/amd/display: Add min clock init for DML21 mode
 programming
Date: Thu, 5 Mar 2026 20:13:29 -0700
Message-ID: <20260306031932.136179-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 4446d1e1-36e6-4fa3-077e-08de7b2fdef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: atrdNDf92K7FXDevJlp4+pgbo7yuo6JlLcbPW8FSDnwHDSTl/wW8+wNWBvKKOXoP0UukWoaLODCRJALt3W3+2I+U4KSloRPlSormSMwtFiBdkl64Y61U/4EHwcD9yM0EucG6lv51pq9FJTOOEUJ6KPL2jZY2QcqfQt3EXItkPk2H3ugKkaSv2p8gwkD+8QEWc5ZhsrWmbOL5/1ufEYZ5sZ2xW8IOXL8Y1B2kLot0F0mWkoKuQa1/ZZf0DOApqkg+HTfq7KcWwO4pU2s0Ca7tKpT+pSR/z2C5BFsEVuRmpQT4P2qls5ajOxuojgvHCNb7M7ae95sXRs3umCBEYw6Q1HryIOGrOHaG/IOvFKn/V2hOBAz85kQ3W/VQqiph+Za/lg3+KvCIqmnCDFFXhMXKp+MuvUKxzi59g4q2ITAzjPEQSDo3P/IEJhzWskMlh3UtMxJJ4bakjeODdcCsdTmtAUNsTiFqs2BdYI5DYzMkS3Yx3puPW1H5WFxlgJJ6SHnJi8Yu+EwPixjgybaOzWcwq6CYjbWfKqCNfkLjSVNROmC6qHsW/IjYCScKbVuMLda3yV4tCI2VrXCV0kVpd05W5riocFMDaYaiaqtDxFyz3JOKAhc7Jw8md9ncrmxnqS+OGMpFuOcbdIxsb6H2oq5KHuIj3N8EvOHaGM4AZP7BdLw2v39O9vC/WLMTOl6EV4Y0e8DtWOpoUrRJHMMW74TjdWxsCx/5Vtzp7i5SOfABPfyorrLSw8TppiFCBRPHUBpM92rKxOkxJIrX6qrxWKkuzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TTaZ1B/9wTndoYNsRuGVQz8wo6a2bGsRACZbBJ5JHCS7hEBzFyjEejhTk7e9PNYtkoVpCSk9F/hhC8pLcHGdCKl2Qoxtkp22FD0oYqSgEhmR4CgaTgiDZ39gpgxzj2XhxujyAqPxq5bxCxvLeKYDfExR2x3VJ/nkC7NHUbLaU7Lm+Kz5v6n9FarfmlK8CB9Pi6tBjiwsj3gVmodeJ15E3OdTu1E5Gtd15NqXQSlQ7r3bgOXVYdq5oyzZ3dkJ5JUL7MqnnRoLa9fQe+Ot5VQ5k4Fmux6rzuHHxMaGVvfAINnLDIgIryQosnfAh93QYeJyEdi3xsRiPRKY6QSEhbM4I0CzxvFI/EBrob5awJl5N66qUfgrs0ApaRocRVuBa/o38RpAxYZPvk1mN1TfClXbsZbZUwVjx6Y3LbTtVItVotnB31A5+5yweeCSMIUFJLEw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:24:26.6111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4446d1e1-36e6-4fa3-077e-08de7b2fdef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[WHY & HOW]
0 stream cases do not go through any DML validation which leaves DCN
clocks in unoptimized states.

If requesting DML validation or programming with 0 streams, program
DCN clocks to lowest DPM state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 25 +++++++++++++++++++
 .../dml2_0/dml21/dml21_translation_helper.h   |  1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 75a279997961..cd12b7a6da65 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -931,3 +931,28 @@ void dml21_set_dc_p_state_type(
 	}
 }
 
+void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_state *context)
+{
+	unsigned int lowest_dpm_state_index = 0;
+	struct dc_clocks *min_clocks = &context->bw_ctx.bw.dcn.clk;
+
+	min_clocks->dispclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dcfclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dcfclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dramclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.uclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->fclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.fclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->idle_dramclk_khz = 0;
+	min_clocks->idle_fclk_khz = 0;
+	min_clocks->dcfclk_deep_sleep_khz = 0;
+	min_clocks->fclk_p_state_change_support = true;
+	min_clocks->p_state_change_support = true;
+	min_clocks->dtbclk_en = false;
+	min_clocks->ref_dtbclk_khz = 0;
+	min_clocks->socclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.socclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->subvp_prefetch_dramclk_khz = 0;
+	min_clocks->subvp_prefetch_fclk_khz = 0;
+	min_clocks->phyclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.phyclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->stutter_efficiency.base_efficiency = 1;
+	min_clocks->stutter_efficiency.low_power_efficiency = 1;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
index 9880d3e0398e..f51d3d8a52c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
@@ -25,4 +25,5 @@ void dml21_map_hw_resources(struct dml2_context *dml_ctx);
 void dml21_get_pipe_mcache_config(struct dc_state *context, struct pipe_ctx *pipe_ctx, struct dml2_per_plane_programming *pln_prog, struct dml2_pipe_configuration_descriptor *mcache_pipe_config);
 void dml21_set_dc_p_state_type(struct pipe_ctx *pipe_ctx, struct dml2_per_stream_programming *stream_programming, bool sub_vp_enabled);
 unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx, unsigned int stream_id, const struct dc_plane_state *plane, const struct dc_state *context);
+void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_state *context);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 798abb2b2e67..96c62bd6a37b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -215,6 +215,7 @@ static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_s
 		return true;
 
 	if (context->stream_count == 0) {
+		dml21_init_min_clocks_for_dc_state(dml_ctx, context);
 		dml21_build_fams2_programming(in_dc, context, dml_ctx);
 		return true;
 	}
-- 
2.43.0

