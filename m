Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB66FFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799D010E7A6;
	Wed, 25 Mar 2026 07:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CrHJqlqG";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB2810E7A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFbqOzlyZ4iuiJWhO+d47d2huRX902VPUT9HM4bVb+18cGOtgLY90RTqeWDezwENr7+eJdxOCOeG4jVWS3BC4FMBy7S5NmaJ63dpjXUc2dUF64Zagl3c89hg+RqFolaF48/Fkqzu8yQG05WcDsj+jZovbtRd71hznv95bS+KrThcqjN/CBZDCD0SU7jamfSLMtS+4nfqjXfxMhMeNeR/8tPHkiTIXRdkwJFh2NNCw2irOpWxBLGho5eqb4nSVw8tuvWzaY6Gef5sajACgk6nCp/Qfz5UrIbNhLm9y4WuA6Z1iPWJzNdRxE0yZhapK7qNa8ZVo1rS1n1NooZlUot6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEumZ5H1XLutsnbkQGNkCpU4XqoUGDX2NR+RgUgh4uw=;
 b=Jlp3THt0qoxpIQXiGFMQeL57o2cjiQI6UwmNNuxxVi0LN9LhIMwaVoJXW+Xk70OnJ0pOnLqZmmuslZu7kIZJb9KT6R5HNgPscouGQpsinJM/CcKBGctYX4ON+GAF2qjU8ByI1YTQPqcv4b9yeExwzXP+pFMfbbBwVVSe7yCtTq+kHxC4cvzbovlVDFD7+FqxcRfU4cUokKsIABeEEBJqLORvkf75PXr6FAdu5UAsB0JrKXeuW5c1GWwd9HZt1mj3NKb3vLk01RBtwYFe6HHsPJo8wX+rzpes6prtLPyrjH57/wci3aC5zB/aAeUVrokSDb6rF5wj+d0NDJeKVJ382g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEumZ5H1XLutsnbkQGNkCpU4XqoUGDX2NR+RgUgh4uw=;
 b=CrHJqlqGgx5sP5qrZZiHCsTnfsSASj76IMPuxOmtS/jQXPjzZ9TqyeBqzHsZ+paOq4a7/QTZZn4FfTLNUCzr5ILFcqVR+IVq+O55eowsQbtKn/FecL/grc5hY7kRPMg7e43rHZJwX2Oa6cgO6GZZ84QlE4jBzEcGpZFXNxmQEKg=
Received: from MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:36 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::33) by MN2PR07CA0030.outlook.office365.com
 (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:36 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:32 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mohit Bawa <Mohit.Bawa@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 16/29] drm/amd/display: enable eDP DSC seamless boot support
Date: Wed, 25 Mar 2026 15:06:22 +0800
Message-ID: <20260325071003.4022594-17-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 2635d683-2bd5-4292-8047-08de8a3d7951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V5y/tetXhgduRDYQXvs9EZui0sV0R1kNs+kRbSn+VZgDKwhpwERdvJeicb3FcwNRCCXpiAEwqWJ3mBzg8fxAhB0NatbmxY9sIRM/VABsUqCErb6Lu31dinXztpYqX/xYqHycf4s2nwNJGK4ajReaZc5wVVnNTlJxQc63iIrYG6qDl9ErjCnhiarqQSwQOrrYblPZ634ZO2hJ6PjYRtEB5hX1Wqf1urUt72PttDZV2S+gHWEym8WbwPBBVe1IWqodE5Ie1K//0gZiChpKUzi15ACVjzEnZAKbDWz2GshKdAgSkqo1WKgugYCdIIUXzc4WI4aXaJvZTPdKDoqVR7MiG6TvrlV+IcyJN51Vx+7W9U5ArFFg4He2cohObyRv5LVCdg6ZxoO3mu06HvFlYp7Xmf8PDJYleLXAGrf329viYt+wsrUGqC1WpZpMYB3d80MDhL2ely6+PXaJH/lOFog2l1biC8Y0LfLGM3kDtt3WW/ARzFEwsEneBX3jGg5+pqDJM9hjng3DMxklJuSaxgJ0th4yRTLrd2U1X93DVQSVwcz7VPRaZ9/tZAI/M+BipJG8/6Py7ZVXvUxXxdcYPJayTl6pGT9CEH7OXBJQPYeKZNAF8wQBzcvbArmnVzpkiGTeJZ7IjhEhh4UOVOP7GBHgTBi58w+yzqne+jya3H/AQsjLfy8z/jsWmlMsOGe4DJ9xvX24PmzFNlinocMBgqkBHVvYj94E4NrklSBPG1HZwy+hBdZ2auiUh7PvQJxwd74WLC8Q+EaqE3C0YFDz6Xmzag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0BGnFx+e8JQcZS6f2iJ5Z2T1x28Kc2xShxt8poVEwv1POcP6++HF4i6fd8iJ/ei1KMxndg9GMP4TAD04YZy0AxP0xUX0+fo1WX7b2b4np8S1wjlsD3gK6lrWlMLB2XPcQNBvzW+qQTEspNtojzTBO8g0rr65iex/U59B2vAwGdR6UW+P+OQXgZS1pzrtHUTfjnvD3m/N48R1a/XNemtYn8Gu4E1g3BSRWcdOFMMYkSDaWVin7f4niriaYBoRiaWe4Zp6eAXQP1imXVmrs7K/OjSyydtHeLtAgOoq8BJDQcfVKfscFtTgBeaLRWVThTmO1v+JEBo64jcfQJbXMB8h2EKO1lX5ybBjJwt73xsEIHCj8x3Rq/0Q0eTqhfHWAyHF/niFeLBbpcXBdPX0jm1I2CoCPM/UbAo9YmHX2V7/QmFSP3auqc8IFmEPApt3cF3V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:36.5775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2635d683-2bd5-4292-8047-08de8a3d7951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

From: Mohit Bawa <Mohit.Bawa@amd.com>

[Why]
VBIOS supports DSC for seamless boot on newer hardware.
Reading hardware state allows proper DSC validation without breaking
existing boot display.

[What]
Remove DSC block for boot timing validation and implement hardware state
reading to populate DSC configuration from VBIOS-configured state.
Enhance dsc_read_state function in DCN401 to read additional
DSC parameters.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Mohit Bawa <Mohit.Bawa@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 73 ++++++++++++++++++-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  5 ++
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |  5 ++
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6ff1377c4dc5..1db99c14876a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1922,10 +1922,77 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
-	/* block DSC for now, as VBIOS does not currently support DSC timings */
 	if (crtc_timing->flags.DSC) {
-		DC_LOG_DEBUG("boot timing validation failed due to DSC\n");
-		return false;
+		struct display_stream_compressor *dsc = NULL;
+		struct dcn_dsc_state dsc_state = {0};
+
+		/* Find DSC associated with this timing generator */
+		if (tg_inst < dc->res_pool->res_cap->num_dsc) {
+			dsc = dc->res_pool->dscs[tg_inst];
+		}
+
+		if (!dsc || !dsc->funcs->dsc_read_state) {
+			DC_LOG_DEBUG("boot timing validation failed due to no DSC resource or read function\n");
+			return false;
+		}
+
+		/* Read current DSC hardware state */
+		dsc->funcs->dsc_read_state(dsc, &dsc_state);
+
+		/* Check if DSC is actually enabled in hardware */
+		if (dsc_state.dsc_clock_en == 0) {
+			DC_LOG_DEBUG("boot timing validation failed due to DSC not enabled in hardware\n");
+			return false;
+		}
+
+		uint32_t num_slices_h = 0;
+		uint32_t num_slices_v = 0;
+
+		if (dsc_state.dsc_slice_width > 0) {
+			num_slices_h = (crtc_timing->h_addressable + dsc_state.dsc_slice_width - 1) / dsc_state.dsc_slice_width;
+		}
+
+		if (dsc_state.dsc_slice_height > 0) {
+			num_slices_v = (crtc_timing->v_addressable + dsc_state.dsc_slice_height - 1) / dsc_state.dsc_slice_height;
+		}
+
+		if (crtc_timing->dsc_cfg.num_slices_h != num_slices_h) {
+			DC_LOG_DEBUG("boot timing validation failed due to num_slices_h mismatch\n");
+			return false;
+		}
+
+		if (crtc_timing->dsc_cfg.num_slices_v != num_slices_v) {
+			DC_LOG_DEBUG("boot timing validation failed due to num_slices_v mismatch\n");
+			return false;
+		}
+
+		if (crtc_timing->dsc_cfg.bits_per_pixel != dsc_state.dsc_bits_per_pixel) {
+			DC_LOG_DEBUG("boot timing validation failed due to bits_per_pixel mismatch\n");
+			return false;
+		}
+
+		if (crtc_timing->dsc_cfg.block_pred_enable != dsc_state.dsc_block_pred_enable) {
+			DC_LOG_DEBUG("boot timing validation failed due to block_pred_enable mismatch\n");
+			return false;
+		}
+
+		if (crtc_timing->dsc_cfg.linebuf_depth != dsc_state.dsc_line_buf_depth) {
+			DC_LOG_DEBUG("boot timing validation failed due to linebuf_depth mismatch\n");
+			return false;
+		}
+
+		if (crtc_timing->dsc_cfg.version_minor != dsc_state.dsc_version_minor) {
+			DC_LOG_DEBUG("boot timing validation failed due to version_minor mismatch\n");
+			return false;
+		}
+
+		if (crtc_timing->dsc_cfg.ycbcr422_simple != dsc_state.dsc_simple_422) {
+			DC_LOG_DEBUG("boot timing validation failed due to pixel encoding mismatch\n");
+			return false;
+		}
+
+		// Skip checks for is_frl, is_dp, and rc_buffer_size which are not programmed by vbios
+		// or not necessary for seamless boot validation.
 	}
 
 	if (dc_is_dp_signal(link->connector_signal)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index c1bdbb38c690..3bf737195bac 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -107,6 +107,11 @@ void dsc401_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_sta
 	REG_GET(DSCC_PPS_CONFIG7, SLICE_BPG_OFFSET, &s->dsc_slice_bpg_offset);
 	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &s->dsc_fw_en,
 		DSCRM_DSC_OPP_PIPE_SOURCE, &s->dsc_opp_source);
+	REG_GET(DSCC_PPS_CONFIG1, BLOCK_PRED_ENABLE, &s->dsc_block_pred_enable);
+	REG_GET(DSCC_PPS_CONFIG0, LINEBUF_DEPTH, &s->dsc_line_buf_depth);
+	REG_GET(DSCC_PPS_CONFIG0, DSC_VERSION_MINOR, &s->dsc_version_minor);
+	REG_GET(DSCC_CONFIG1, DSCC_RATE_CONTROL_BUFFER_MODEL_SIZE, &s->dsc_rc_buffer_size);
+	REG_GET(DSCC_PPS_CONFIG0, SIMPLE_422, &s->dsc_simple_422);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index ad7ef83694ea..a16c60d8532f 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -64,6 +64,11 @@ struct dcn_dsc_state {
 	uint32_t dsc_chunk_size;
 	uint32_t dsc_fw_en;
 	uint32_t dsc_opp_source;
+	uint32_t dsc_block_pred_enable;
+	uint32_t dsc_line_buf_depth;
+	uint32_t dsc_version_minor;
+	uint32_t dsc_rc_buffer_size;
+	uint32_t dsc_simple_422;
 };
 
 struct dcn_dsc_reg_state {
-- 
2.43.0

