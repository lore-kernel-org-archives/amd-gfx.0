Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A56C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E4510E8CA;
	Wed, 10 Jul 2024 19:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1hAB9WK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A296D10E8CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYXcGRduCIZOwJSrH9U2+KKih84WUHTPM11pDrwtvHGDBUj5SvDP8MZDfMt0AdiHyj4EMcr3GJe2mG8qhHtAVtXb879P2cbevky9jWpIF2Uv1QcYfMhCVvoOGGQcIkUgIhO+9BWiye9kTRP+Cm8nj13rSXJF6/WXrVXvS0iez97G3Fl9Uh+PLyrhAYhG+UpC5XzqyffEvr/hq+DuMm5asZtVbzbHb0skha3WqFP7G+nYl0TSFv1AiiiDvKmMQ8h+/BqfuJDzQpttBXyzMk2E97d5doBKRMStdQ600eXgUAZDXQD4373chHosM7kfAIM9dqngqfWfxzfzWIgnbyy8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+sD5dfzyUPglTxksQ5BHEDW+eBwfDN8sqvgOyX63wQ=;
 b=KAUFOtZ9ewGpslpqtuQ1Yn67O+OYmv7OVUMP/0HMc4KJpKnqOV4aSdVK3vBvr/lvuPG9jMhEFvxEgNLMcSyt4ZDnt+/niz2IBzUVCgsbz0A9ZLzLuOeu/SWLm1UhyFGMrvVHPcEelpOM4neD6e5sd1HfQwG6iUWvrJdLZGGi2Kag+PvHNyRCb7ylWULWTA5TAPCu36fjVVZyzLDdLwZIrs/NO6NqfU8pqmGO3qkLP7tGMdvogZAqZPFlv+BvbTBbi+SB3reyCwZtESpZhOaYWxKTv4DadmikVZrHph5rIa1eshK1l5vY/X+hlgJs2aSeBvX55FdDb0iK1DZ0ykPpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+sD5dfzyUPglTxksQ5BHEDW+eBwfDN8sqvgOyX63wQ=;
 b=k1hAB9WKaIMfh9q5T59v59V/gymiFOR3qiq9AmGUryUekvY6Y+ZkWHgA1mTGrBAY+kcca2k+MjM8ZRJozSRHoZqbZ/nfxwhZ0DIoy5h+mbfdTXHcqtNYmfpKVd5ho3zA5aBmGOf87tlLphfFqKQ/FIuQzUOtlvoZM79XsajMqpE=
Received: from BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14) by
 SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:25 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::a9) by BYAPR01CA0037.outlook.office365.com
 (2603:10b6:a03:94::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:20 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:20 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Duncan Ma <duncan.ma@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 44/50] drm/amd/display: Add visual confirm for Idle State
Date: Wed, 10 Jul 2024 15:37:01 -0400
Message-ID: <20240710193707.43754-45-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 6067d265-2954-4f62-90d1-08dca11824a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x/VFSHXmhHN2CvXZPirgTCntI7yNVHSz9Q1ruIsABpgLbiP8i7m2IhJPvpKD?=
 =?us-ascii?Q?8nteojVS0dZsqb0Oj8g50n5NIhYSCkG5WpUnaFQPabFay4x+1+B0ShrBg6EQ?=
 =?us-ascii?Q?MNCGwzmcqjBZaGBiJBYG2TV3BCVEDtTL8efoPGtVKur11OV3NO9+fUfM8439?=
 =?us-ascii?Q?u4RHQxPPnsRdGjR/qFvF07FqSo0bsVPp5+iSI1va+eSYNjuNJLPfBwVcGYfr?=
 =?us-ascii?Q?7S1mKS/m6AXMIYo+4kbem2WstpL+OgCLTdklnLbmrN+ybdJ5U/f0BrvAf3+i?=
 =?us-ascii?Q?811ioT06JHB2jUsfcjHYfFi7It1cR0ghVsjS6fgxlok9mEPovatyUfLh3soc?=
 =?us-ascii?Q?m3jkasUGwOqs1mR9X38MaCdy+6vvcRn4YPHzgCGRfwPB55gVldr2O3s2HxEM?=
 =?us-ascii?Q?Kl/sXVeA5tZfOiAirBLXggK8T0AO6sSEaTUnaLTbrpgDM1wdwboDMSTG8sVg?=
 =?us-ascii?Q?+jPk7AZfYwMKq3hr2kJx9ImBNgs89Cc3xoI60mO+YKBgn2LLWdM3J5whedy9?=
 =?us-ascii?Q?BR0Zmgzgc54noBfckkFj273SpvMZDN8qapzTQdBqE/FE0pxuk6b3i5aLpGEY?=
 =?us-ascii?Q?tt9Ybg7TDKaA+ofpYluyN9m+FKK1RDYgxBI28UvEz21eZmgYfUXH5tcBSE3N?=
 =?us-ascii?Q?/FvuU2e+UQz4COLTFcqYnHzML4RGbxi4kilXklzxG0JIGgdUBrSi/8uxoWRh?=
 =?us-ascii?Q?DmyFlJxQBTj+SbPwGh4jFApayysQIOEW7h8GcW694bq/TMHeldfpeLoai3MO?=
 =?us-ascii?Q?5jSnNihcXImkceLYQLFibc6qqWQEfkkDJxbK6y4yR4GX5uq1BZh+BOrMi+bI?=
 =?us-ascii?Q?6QdaMPwLKU7hnuYgd5PXrE2E+/hN9ckfm18623yFiP9Lz7IZn3Fdw1/3MSY4?=
 =?us-ascii?Q?ekyCf1zVxdrMcAVuWZrD5+pMuuNT8ySi67Rqxi4+rSjKl5rkQwobPZ1xXPIp?=
 =?us-ascii?Q?d0jgUsjlKd3srUBhK9XHS1gBldJllT/pOTRkw2/2VuPAgO5hpn2xM5T/1rfn?=
 =?us-ascii?Q?l8Y+l5uG/dYPUfqnTDfQ2u2GY3SzYSQDK2fCFC2RwqoLouRDqRO+a1pdXjRp?=
 =?us-ascii?Q?jFLysdq0G6MBFyCckxPNCuR9/UaWpz7+0PvcOnhbZHqYcFTy+b/kcoCqit9f?=
 =?us-ascii?Q?TQkTPKbAvk1iIZXpr6JDY8Tyl8LQNYHEDFrqpK08uxjKZMXirqaVlGwxzEKu?=
 =?us-ascii?Q?yxNY36rfGJzTCpW2FPQMyF7YwdxiLy/nE/Ijf/JyFbB1ugIm2AYW4rthUX2s?=
 =?us-ascii?Q?JQVsbiaFXQ5o1NpiELhVYvJKvTYioNf6aQOIYI7T+jcnNNpv5yY7LVmmDywG?=
 =?us-ascii?Q?fVZ/r+fuHr4ZzSiiUHNIecjpkl0MKTq2+vhd3Wg6ldngyB4zPGTN8p4aJuAN?=
 =?us-ascii?Q?9OBb+P4us5rCQyMUWeyMB8fMcr4Y4oFMtqXZS7Y921eobJNo/W7iqSJsnKw4?=
 =?us-ascii?Q?oXQGGCdP/csQnPpjLJc+sKGdLTSaixsD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:24.2760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6067d265-2954-4f62-90d1-08dca11824a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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

From: Duncan Ma <duncan.ma@amd.com>

[Why]
Visual Confirm would tell us if it ever
entered idle state.

[How]
Add debug option for IPS visual confirm

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c    | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 2 ++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h  | 4 ++++
 4 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 83fe13f5a367..9d4b821ab219 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1056,6 +1056,7 @@ struct dc_debug_options {
 	unsigned int force_sharpness;
 	unsigned int force_lls;
 	bool notify_dpia_hr_bw;
+	bool enable_ips_visual_confirm;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index ccf153b7a467..0f3d15126a1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -363,6 +363,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
 	copy_settings_data->debug.bitfields.force_full_frame_update	= 0;
+	copy_settings_data->debug.bitfields.enable_ips_visual_confirm = dc->dc->debug.enable_ips_visual_confirm;
 
 	if (psr_context->su_granularity_required == 0)
 		copy_settings_data->su_y_granularity = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 2a21bcf5224f..44df9e2351c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -167,6 +167,8 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	copy_settings_data->smu_optimizations_en		= link->replay_settings.replay_smu_opt_enable;
 	copy_settings_data->replay_timing_sync_supported = link->replay_settings.config.replay_timing_sync_supported;
 
+	copy_settings_data->debug.bitfields.enable_ips_visual_confirm = dc->dc->debug.enable_ips_visual_confirm;
+
 	copy_settings_data->flags.u32All = 0;
 	copy_settings_data->flags.bitfields.fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5ff0a865705f..7c3838362c49 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -336,6 +336,10 @@ union dmub_psr_debug_flags {
 		 */
 		uint32_t back_to_back_flip : 1;
 
+		/**
+		 * Enable visual confirm for IPS
+		 */
+		uint32_t enable_ips_visual_confirm : 1;
 	} bitfields;
 
 	/**
-- 
2.34.1

