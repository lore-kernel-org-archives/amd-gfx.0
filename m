Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CEFF31E29
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B67710E813;
	Thu,  9 Apr 2026 15:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqjcCwij";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AEB210E816
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRuNbY+R+fViirQKw35LoWuxFupDkKGNvtFzedwog4mfnIbjmaBgQCWbG9VLQ8aiWlRUMTJLNdsKZUJEeh5LfvCpJ3Ljqi/rq/QZ4bwrS2xjv+rWlm+LhmYJR5lQ87GLlSXZEnsLWp7RNcFCfD+UgtGXp8uG0i8dWDrTOpw+E7uLHZdvUU/xXmiQoDGF0wlwK+3XAm+yftTITiiOBfkMs/Lmy8LozQjXC5WTxL4EbnkTg1N4E5Og30Jibk8MAkB2jl2BLKIysN5ZfTzgFu7iRgpe5PwC/fg8d4NAuKzC2RrOPe9T9eh5zT0dJ7MD5LRSMjIlwqXInTE8L6oCdv9pXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0ULK3Ht8pfeg1wVZh8LjpzkOPFkx030BypyhVqTzQc=;
 b=WB+mpKq0js/W9SmtpQteKbibqx3FT2JhBrXb3A9EV0Ge8Nol5TljcZQintN+imFdcnUcXrsFezDyR6fuY4DDTqwEXvbGDVmoXlXLXhFbGU5naSeOOJz/8MgKMUTDZmahIehdAc0gRAfctiTxCxKd7HY0SkEkmZ73X+sr3dB1jb8CAyVNahvwduEbBPJiyZJfJPePRIfaiS68OC+i3M/zjL5aWfOOMKpsSnSUJjtCry1xNDGm4Z30AuPXRz5WsziCKfqPevIht64FhGiAv9Y9HW9N0+sjyrvkPm56aLFmfS3V+1RLozh9CKL1KANyKxTydjhBrEuR2DdOQqR4M2TMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0ULK3Ht8pfeg1wVZh8LjpzkOPFkx030BypyhVqTzQc=;
 b=iqjcCwijT8FgMbnEAlmKtK/36OgGHINjWh/0jmh/Ue/TsQtjga1F9+i+oHL91ZX4E2o7OKZKAjcDOVQFcEsfJ/Tvd1j3LcwQnofaXLPuNmuuIpfBK1PQNegwZCIoh8bl7hBCF+dQveCcSlU/hxQjDkKdYuaVnJu7uLpTM88gY70=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 15:04:24 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::bd) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 15:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:04:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:17 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 9 Apr 2026 10:04:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 5/6] drm/amd/display: add pstate schedule admissibility flags
 and frame-time utility
Date: Thu, 9 Apr 2026 11:03:13 -0400
Message-ID: <20260409150413.34779-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409150413.34779-1-aurabindo.pillai@amd.com>
References: <20260409150413.34779-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c3f519-d682-4122-71fb-08de964948c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BhjQuXYX6eOFvh6I7/XOth7XwDOjsvjoSpI5mzZD3rYvrkeO2WYImdqQh5QdC32zWoi0U/wQ/ygAB61ZsaCxhlSZUcevqWc/6lbUf8B1dyFLBRXnBphRjemq43un6KpttuEfMSX+QJy6A9u9Zn9odWa73Ym7jSLv1SSiQSPqQknQNNvF8JShyaa+OHsf0gGeIbrtxGvZVAsW5KutSeHWgzuwL9VWtoC8gHSXbrnlV6frIOXDlUDmEOzokPc+zvxg8X3djKRUd9ybqj3pCH3sAGmuvOZEffNM9cVH4ufRGr2/zkwzf5iKWs7z11JZ2fMEBmFUaYf6PvUUQFj4tcOSb8x/SQFcYzWH55zxWAir8ohGUmYxMcpsf80/ZnhcvTyi9Mn15j1h+NN1R6djwxiAzdnCcCgTc0SmWQuw4dnmPgodg0eez8RIx1AIL/HB9ctKtfsOtN7PdDXre8PMDwJOPVcTulBf+bUR15xQ6SKitnZyOJtEKKeaXXu1wwVbZq2LA/+OxqvgOLkIBUbEDTMpBWho/Vf5XYU4BQhBvhGO52L6Toi7DEY51bw3N+Hf6cfQr/7fUMzo58VU086Rjsi3P/ERSsdd7WIpzxYQZCVwEFa5BbpQ1z+OK0JYu9Pnj3aJjb4OKFd6zPMQNFdSyBAR2uiBFpSYm4Gmf2+w2AVONv84eioBi/r7ygKQLGLWugdBVgyfPL9cilyL5GvyZDG8Zo/7A/B4nvHZiwQkVOXqFF4kDvioNJhkORqmdTvYEBMbMKrVf+EAKUjAvCMNb6/UbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tVOpulEH82AvybNB0BLuPX3L22EI8+48A5+mCSPqgBekYfL+oeRpQcJvkmcVBaoZ3XZXA73k2N5+hjiqyshBSFqY9FbQtHGcpySyhXyQWvnlabZyIhINVISUoHk4QoTLHgo4liUuGNoTXIBDyMF1ZjU+ncZ6pm8MXCC5asVZEFN1d8RMX74YT6ne+Xpar89rDFvzyyhVH+OO9LzfbtR/0n/xNNo/usAh432W+BJrjXtV46heBimXiggRpo2HfhfWto0Y4XgIWcn/J7TQLXTSKaVdihLb0Tl8+z8Mpg0qYl2ld5eUYVu6huBdp6sewC4pGT/EQ3kuwvdAjhaxdjk1QO6NdgQ7C47JnR82O/Z3Yr1S2d6+pqKPZderrK4vbQqFsTUDzqNgy/8C4rYN7ZvQyRGMYK153GIgExp8AXmRO7VIKz6N3wTkxnkqIO9jpQsT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:04:22.9886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c3f519-d682-4122-71fb-08de964948c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Core needs to track pstate schedule admissibility for different global
change scenarios (fclk, temp read, PPT) and requires a reusable way to compute
per-stream frame time from timing parameters.

[How]
Extend dml2_core_internal_mode_support_info with:
fclk_pstate_schedule_admissible
temp_read_pstate_schedule_admissible
ppt_pstate_schedule_admissible
Add dummy_double_array[3][DML2_MAX_PLANES] to
dml2_core_calcs_mode_support_locals.
Introduce dml2_core_utils_get_frame_time_us() in dml2_core_utils.c and export
it in dml2_core_utils.h to compute frame time in microseconds from stream
timing (vline time * (vactive + vblank)).

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h   | 5 +++++
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c       | 8 ++++++++
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h       | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 987b29808ca4..080bc3c3d244 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -269,6 +269,9 @@ struct dml2_core_internal_mode_support_info {
 	bool global_dram_clock_change_supported;
 	bool global_fclk_change_supported;
 	bool global_temp_read_or_ppt_supported;
+	bool fclk_pstate_schedule_admissible;
+	bool temp_read_pstate_schedule_admissible;
+	bool ppt_pstate_schedule_admissible;
 	bool USRRetrainingSupport;
 	bool AvgBandwidthSupport;
 	bool UrgVactiveBandwidthSupport;
@@ -1063,6 +1066,8 @@ struct dml2_core_calcs_mode_support_locals {
 	bool dummy_boolean_array[2][DML2_MAX_PLANES];
 	double dummy_single[3];
 	double dummy_single_array[DML2_MAX_PLANES];
+	double dummy_double_array[3][DML2_MAX_PLANES];
+	enum dml2_pstate_method dummy_pstate_method_array[DML2_MAX_PLANES];
 	struct dml2_core_internal_watermarks dummy_watermark;
 	double dummy_bw[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max];
 	double surface_dummy_bw[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max][DML2_MAX_PLANES];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
index 5dc846802c53..4f5533dc0430 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
@@ -786,3 +786,11 @@ bool dml2_core_utils_is_odm_split(enum dml2_odm_mode odm_mode)
 		return false;
 	}
 }
+
+double dml2_core_utils_get_frame_time_us(const struct dml2_stream_parameters *stream)
+{
+	double otg_vline_time_us = (double)stream->timing.h_total / (double)stream->timing.pixel_clock_khz * 1000.0;
+	double non_vtotal = stream->timing.vblank_nom + stream->timing.v_active;
+	double frame_time_us = non_vtotal * otg_vline_time_us;
+	return frame_time_us;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
index 95f0d017add4..60fa2abfef85 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
@@ -39,5 +39,6 @@ bool dml2_core_utils_is_hpo_dp_encoder(const struct dml2_stream_parameters *stre
 bool dml2_core_utils_is_dp_8b_10b_link_rate(enum dml2_output_link_dp_rate rate);
 bool dml2_core_utils_is_dp_128b_132b_link_rate(enum dml2_output_link_dp_rate rate);
 bool dml2_core_utils_is_odm_split(enum dml2_odm_mode odm_mode);
+double dml2_core_utils_get_frame_time_us(const struct dml2_stream_parameters *stream);
 
 #endif /* __DML2_CORE_UTILS_H__ */
-- 
2.53.0

