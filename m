Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF7F109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D02410E93A;
	Thu, 26 Mar 2026 03:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sOulRjbc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6906110E93A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWWHtWyOuFSTin5Oq151Ru5jh1DTsLAvzRrkU0G7bvYZc1vu/aCGSDoQHGd9R5MGlKuo1UTgeDSsUP8+DgWnodvLF3/X6PDbc4/hPEZPqU8v6k+ozcW1/xk/dR/PGe83kK3S4keE4WebMWhYo+qSNPJsT6KOgoI8gr1qv+A+M2bYX92Z08HHc0+P4wQr7WLUTugPuqiCgmFd03H3HU0HjPnsXEuw285sfHFTkmyZs+87uArM9JlBOjej9PWvgNZXvbE7z5objiRZF/LVZJ3q3GjXjc34dCVcofTbhCL7Q8sn85P2hT6UpRT4cd0qiYp0BW7a7Q+IEa9n+577T1qCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEumZ5H1XLutsnbkQGNkCpU4XqoUGDX2NR+RgUgh4uw=;
 b=ypkC1qFpbVttHhfeWl5v/lEWnxcuXsF2wKaAIOxNaZ1yI3JcwHhquIDYvks01DEIq7G+8KCR1ip7n9/9oGG+agNutgW2xivGZ0462QiPVyR4Y4/YUsKEd2pUEBsM1XJqtFesqufoP2u9LUjwihngOTSLMwuY8fG2AhqsosiUkMAi1amtUQEYr5Girt05uDlOomRimiXoNGlaHPdrHMyAopKVSL1Tr5wl5l9K9w0KFCfYHgQ30XRTOAKiyxrWqCRImg4dEycQeA72/8fC3XronlMv9PD8OyuWOsNav1tfGsNgc9iI7GpzaA3GELWIc5kzvii6pYJPnJUTkp5u6pk6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEumZ5H1XLutsnbkQGNkCpU4XqoUGDX2NR+RgUgh4uw=;
 b=sOulRjbcKew+RzblZJ6OtCNT6/XYC2j+066eLO6UzYuWGX34neX7JoqLQWLvM8mVfEuvrM6nGbzY2W3W8KJ5sF+99xBatQhur67hBJoKMb4H5lCQJOD4T3Ol2hJgWLkUyBjumsWT0zvuWSsc7N4Jk2LbpzkARk3mQxdT6IjLDkY=
Received: from BL0PR0102CA0008.prod.exchangelabs.com (2603:10b6:207:18::21) by
 DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Thu, 26 Mar 2026 03:01:36 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::ea) by BL0PR0102CA0008.outlook.office365.com
 (2603:10b6:207:18::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:36 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:32 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mohit Bawa <Mohit.Bawa@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 17/30] drm/amd/display: enable eDP DSC seamless boot support
Date: Thu, 26 Mar 2026 10:57:08 +0800
Message-ID: <20260326030153.406612-18-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eaf992b-45a6-4799-09f4-08de8ae3fe4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CWnZENFbF73+mEGtP8FI0KKo9sm1bA/gvfj8UU/5vdHH3Vbwy3LbhxAFP0IUbWvn4tfPGrAfjkWteG0yfD00CR44ik2ThZJ/nDsqQEIKqcCmw6n9g3hSLIRqCLm4yD6DO0+N07+Y4Q9ZgkXJ3HbQEkw4w5zdpMwc+4nq7WyWMgqYu0xgHJQ5LGPuzmgDkzOMCnaP+QLS3gj/hrv4mA7pdxEahAJpefFd6zhASdystljKqlb1KF03dowD8/NVgcuTbU3fzzSsum/lgbEK/x116DBruf9mtM1jijlgwHOwbujlIyTlvAx37K5aYogzKMz0aCXUBxNep5Yg3skD2WkWDjiuumCcwDveu3pV1sGZMjsaB+D8Lmiga30X9wPnLqmM8EzeU9DEPzv/kVbUF1oLYWVjzcLxVjBqNIsCn+P1oOOaAqYwJyig00bQHaMMJeChbTf+9yGFmgpi/7c9YbQ+IQ/T1iBw2lwOdhKDeAQZJQ0QWio9++uQkryqRPfzF3UVjHt9twsyiRCF2gKpBX29mkLsCAuAwhQLsNrmTYgi5nz1eEbuSw5TrqeUoHoS/l3giL3pUO1m0/geDJRdevHcC6Vlfvq6cJqiUR2W2lomvV+c2abGIDi82U5pNa8sy+1u+9WrOi4y5dxwtQSoZOiZAi4vidx0QfZ4+nK8eLdXhKVC9LEJDXILExGZYaBz1sRKkVzGC+7RvTQFHhVlGIdilMvgZb8BZedFgctU5o7gLwuteOBG2p0U4NkzVy+BWpJhXtrNzO4/RtBe5QaiYk8QOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t6EOSCag8lFJXWZr5RMP/wHRkIdjQHif7NT/bSCnMG9KIw/plkMutxzRd3bkK3IkbhhyuVGlw4JgGalayk6Qh4XgHyP2KJgJEU+coEMkxmxHoqj+CtSWO01C3HQC0kbw0dDufCwFRyTN/qq5iXl9TRJcfeJlUeJaoQ7JvmjnzUNAyNYJ6GD0V7nmbK9zDPrwo6nmCZ9fPNe1RsopdoCEzbg1QZDVGzfo7umXok3bs5G5ot0Swnu4PspFaPbVcEgfOs2YB43k4iugYyE5E5K8xAeWDfxtRq9wG0GQbIP3y3VtbbLkIbIdsCWKAyu2eXBvXrradVskuPfHja4oKgs3heuiadg3Yaf8vDVqkmWb/j++whJ/dfHONcmB8MNWt90xjM+p25FQBJrywCoPC1dHuLYIDrznIJtB9WNv8yAqJKnNErr/6Ylnqg0uHPTDa7vn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:36.1134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaf992b-45a6-4799-09f4-08de8ae3fe4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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

