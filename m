Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F40C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B20310F063;
	Wed, 15 Jul 2026 13:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IgkVnvlh";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0784C10F063
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+6cud3OpsGfXEw/55ktLGl8HSueVQe6Y8dOyiFfmW1f8jTmY39MaAoJTnl5/dNy6OUl8IFZcMJv0wajNOt6f7oNA8KkuWUVncY7cscxTpIvJwgCMBF00VU4nkvH0QMuxBIYnswW3ppAxfrfS6wzfsB7xpz1vjhq9FKLQ2bUjFp8uZCw02PWmXNJ6AO5AEBiLVls45/m4Ait/nLsO2DE80/LXPqUUriy7XoVxiyxmtWlqPGPOvLrs2qgJMCUbmjvKheIj4qVAI3ZANFnwgnOUt9Xb71RX9Ok0hlfeZsi1hsgeOTf2zPUVcvXrO406gxwqBLW8i0Lv51GJg9AK61Wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDUbuGOhkt95Ls4+6+SrV5D9b3Ut38m+by0PRyPs5M0=;
 b=Yj7Ek0XPJIJDacnRBXGDob7UKze1HGTfe9zOU+s+NsYH8KFp+VOGIbvR0aCrCR7BpDoomtNG1c+MPgxZh7Wmqr65l/jndzejrIY4JLO63ihi6/+wlI5e6CJGptUE1AKxqcFB/oCZwx0/qZ10lGCi7bcXaKfcQtNx593NgSZ6mH5ejI6mSqNcSiYN4O9eRLS4B56sUgfhD4KZjTeraHId6UCW6i4FL6a4Ns1lMTd+r9f16zRA9Nj/vdJjoA3d5gZaisTZDBNkgAlkeanHElyW+vvzOz2rAyOUtLCfpAk1NFcSO0JYjp/a9swFKX4z5YWdAzhxfZYkzrdluQO46Cx/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDUbuGOhkt95Ls4+6+SrV5D9b3Ut38m+by0PRyPs5M0=;
 b=IgkVnvlhiFYsPGEdiizWwkJC8dnRHKlfVxVli/uDg1IJe9U8YyeKEQ33XZsf4f5EvMD7zn5/19WhPghbHtaazBSFlGNk85g/ZxyYT2xNu5+11NcTOslvisBayoWvfUe85R68T+vkfN5exavgoMHb+360+nYckrn+ejpsML40v2M=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:45:01 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::7c) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:44:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:44:59 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:44:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 03/70] drm/amd/display: Add MCIF ARB programming structures
Date: Wed, 15 Jul 2026 21:37:13 +0800
Message-ID: <20260715134432.1975118-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: c01a3d61-5090-44fd-858f-08dee277442d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|30052699003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: MnSOcA5xUIc0rxdVcms2jfH9zDagPt35gC7n2l1lq7gyra3kr5QC958dXXR55Dhp1NE0SFRgwH8a85qlGsuol1kY3YkiAYB4BK4fZPhezwV62ea0ntac1Kb5ANVBKEIvV2RoslSA20CZz56mfHd1copIfjphfLbS/caaRN2ZPqDMAMUUjdPONmrttcZY3Q1RpFFcpJwmAPAE5MOoOTQ827xPNpCO5z0lA+rF9PJpzAoBNFMkjMptw02FxlMe2nz/yxciSbb3T9Vkmf+Mj+2EWQ2LmfhXePu8rZ7qLMtSvKLmqu1wiezrn7MsJvCM2uGo2cLim+K/dg6/kob6mI2xLWNdBOWzpwIj+acGmHbpoTNoOERJziTjQY834GGdZsDe6j6LiiNg/d9Yf6UhEGXnSO3/tCbmJQlXbUqoi8Tw8Z2IvOkZPMM/65i/O9WVYSlGpFE/VaVgN++N+0QqWIJvDbXqDXiZdG4gzjs98R7lrck0PEFtaklQ5/vud3CbegTo2xLQlJv3PS8G2s79P9m0NuBDNeJ0rv3MXA7cmHcqZlTZDCMR4ZcbP/Q6I78B3LhGqwoofyX4mPWfPJMZPkMg7vwv4f5KVS0gCDHF0L8f6ohX7pQzzZl/MRHi6/x65hu3syh5eHhHVNM9IgjZ32WHx3MSHP4dCvWM7XljYFcskRnwRgmUEdf1SaWvDiJKvvya
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(30052699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vVgz1e429++8h7yeMz1OfVc4BcGVMwQO1KqDPWtSgWLG/B8pQYvkafBfKCXACy+dTTXA6ltsLJki/EvejW0nSdQBz7ejTRvWFqD2i4jFABBtYt6Y0wh0VIMylmX7jRIy6Alo2njdBsaye9YgrV++Jm9MzR6IqyCaOZ0ZoNb7IPMUsJJcha7746Y+kHvEjqh0JHEAx9rhSQ2ax3BHz06xNp7Pzji7n8mjAwo4QnVx1h+3jZHadNMtrskryLa/5MAfv5Cn6OGGo0oNpVIn0v4yE8oA2sKhZu7UjzWvBOTVCAYNGaW8s3NYcAxIsjqE6D+oHBejP89UV3DBbWg2Wkyv/UHKkiPCQI/CcBVgnox1upipVaq3DGyIiuE1SkXdTtmLdkGUswuq9dMNGG9obpdx+0eycjYBplY2iv/RybgEilq7nM++gzotBGutLh9i8JI5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:00.4720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c01a3d61-5090-44fd-858f-08dee277442d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Adds required structures to configure MCIF ARB for DWB.

Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../dml21/inc/dml_top_dchub_registers.h       | 20 +++++++++++++++++++
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
index bf57df42d1d9..5669be0a7340 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
@@ -153,6 +153,13 @@ struct dml2_dchub_per_pipe_register_set {
 	uint32_t det_size;
 };
 
+struct dml2_mcif_per_pipe_register_set {
+	unsigned int time_per_pixel; // U6.6 format
+	unsigned int arbitration_slice;
+	unsigned int slice_lines;
+	unsigned int max_scaled_time_ns;
+};
+
 struct dml2_dchub_watermark_regs {
 	/* watermarks */
 	uint32_t urgent;
@@ -188,4 +195,17 @@ struct dml2_dchub_global_register_set {
 	unsigned int num_watermark_sets;
 };
 
+struct dml2_mcif_watermark_regs {
+	/* watermarks */
+	uint32_t urgent; /* (CLI) */
+	uint32_t uclk_pstate;
+	uint32_t fclk_pstate;
+	uint32_t temp_read_or_ppt;
+};
+
+struct dml2_mcif_global_register_set {
+	struct dml2_mcif_watermark_regs wm_regs[DML2_DCHUB_WATERMARK_SET_NUM];
+	unsigned int num_watermark_sets;
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index cdfb5cd09edb..bd0d7549d20f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -436,12 +436,14 @@ struct dml2_display_cfg_programming {
 	} z8_stutter;
 
 	struct dml2_dchub_global_register_set global_regs;
+	struct dml2_mcif_global_register_set mcif_global_regs;
 
 	struct dml2_per_plane_programming plane_programming[DML2_MAX_PLANES];
 	struct dml2_per_stream_programming stream_programming[DML2_MAX_PLANES];
 
 	// Don't access this structure directly, access it through plane_programming.pipe_regs
 	struct dml2_dchub_per_pipe_register_set pipe_regs[DML2_MAX_PLANES];
+	struct dml2_mcif_per_pipe_register_set mcif_regs[DML2_MAX_WRITEBACK];
 
 	struct {
 		struct {
-- 
2.43.0

