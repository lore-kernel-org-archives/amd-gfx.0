Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30587CEE346
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C910110E7E1;
	Wed,  9 Oct 2024 19:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qyu/ExJe";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18C410E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjUzZCrEUVYv42CbNe/tJNN7Yqp361IkrgrdZ7Dm/cbPh1eH0C6q8ZkruPdIbWgVwcX4NsJYrzXXT7hzIOxhWqcPsAbfNj+7JWNlAR6MNUb/6UDXIENT0Vsu9nT9KVvTIZ9c5I8kbKg59FD2SiKkqwFUE9NONiWKzZbdrDE8Z4FQQQENyLoAkjiasVPOlhChvQbrxAZB7CY97sGNwOBBCETTIH+QFoXIOihSmc5EirpTmIo7Pxb6XovhlxW0scGWC9g0vgAbc8N3jjEMdlfRV8b2iQtQYZ3YTxvRsanZfbfNoo7CehgTL/1pA6n4tIjxeLha0q4LoD57vdQmxR6xxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KShfLSQGeKZ7DUQRR9tuZVP7M0u2WfQ4TeudsFxm6ls=;
 b=yTFw2BulUdSmkO57i6rD1OuAQ7WqGGEf49ZYYaRps3Bc9HDnAmETa59R64t6+9rzVGfZckMfGPMMy429TdIvgv4KthV9ScJSLgpKZfQR21iY+dFshtxWxXMIisxTPmg/SkCWnB9vrNy70CZxhZaeTWr5h2IMON1lft+GWAcmIO3sBcftq72kXayElZO9DXx2O4QwpVHG4he/lt+pyW5jMXHgcSuLwqCgGbZ41BH42bfbRgd3HtyWC8WMFT5RrUGHWKucPNWjygdvmWpjoCek7hPfJRFWzvwDc5tRXbrHGhSod9Fjw4oau3GhoaE2bv3XP6pIpaTN2U3/AK09imMPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KShfLSQGeKZ7DUQRR9tuZVP7M0u2WfQ4TeudsFxm6ls=;
 b=qyu/ExJeX34vU/OdI048H/YN16p6Q9JVUAbkRRvHypScPxETuR0mTA0W2pbPCa7HIBbpGFAOF6dhnmqnGP7t2sBxZxHPPtBSzLZqY5wGcr9B56YZfK4FiqtgbuPeRC04Mzw37UC0tzmNo5pJpgqeltSz4Ep7Oo0wU/TTW3rKHg8=
Received: from BL1PR13CA0262.namprd13.prod.outlook.com (2603:10b6:208:2ba::27)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 19:26:02 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::64) by BL1PR13CA0262.outlook.office365.com
 (2603:10b6:208:2ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Wed, 9 Oct 2024 19:26:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:00 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Add 3DLUT FL HW bug workaround
Date: Wed, 9 Oct 2024 15:23:34 -0400
Message-ID: <20241009192344.650118-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: e77cbca2-e0a6-4d75-f161-08dce8983638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q6Rc7fcC6FgkKq6fB65wTDCn16UZtRDY4teHXJelyjT7lVQ7StDvmXgQSc0f?=
 =?us-ascii?Q?Xe7YZueC3ybjr2dYlpfq9eCG9yDPGODy5LsWLH7kvBLz2Pobjv1aZPdzHJ6M?=
 =?us-ascii?Q?lMn2R5kBKcDYStFZPNWPQCzer6hsecJ5Me+eukClxw5oGa6ag65yz67qGrG9?=
 =?us-ascii?Q?LTwT6OZ3c8fCxyeRepCN4Ff343wKEV8dGNdSxilfZ0o455nTkh1wVLerfmAR?=
 =?us-ascii?Q?/MBXhyadmGQltYgRoHbw8w0Y8Z0MnIwK7iCH4IKmEr8m9tFieCDC+67CtTwj?=
 =?us-ascii?Q?v0sKdoZ6JIjHOAw+0Yq330bWqdyYAfeI1LuJBItvjZdOwXsF0q129BSxCqbD?=
 =?us-ascii?Q?DuA/yqkvCBNF02f1UYPho0otCabAR+MimUU7iGzD7sVkHCCqgHpQPdXJS5+U?=
 =?us-ascii?Q?Tb49Lw0wgkW16oukjY8VkeXtCO0DJtsRFJZaQ3uFco0PrDtYS7l6pVYb7XFZ?=
 =?us-ascii?Q?Qtki1eist+4asLASP3kicgUz1OzwkyBufUnneY6M5fW4yN+93z7eaNLmxo/d?=
 =?us-ascii?Q?5mmYpuUAfS8Kr7j3CJjzfnsYMVfeztmQS0ize8A7ODvovRZu2xlUMINk7Y2e?=
 =?us-ascii?Q?Jh2p9ko9omNQT9ORo5SfJBkS9PNjUyR31FeDv5J19u8fuRxVM40izoOEwkQj?=
 =?us-ascii?Q?WwsXfD4V26m4vVq9w8lWeDWfMscJCJNS0CHAzHFLLahsDCwp7DFpx6AnWlbk?=
 =?us-ascii?Q?67Hmp/eGWtxuicrzKXtjQ+jXARLWunsBNphOvgIbBISjahrxQrO/wMEvhhY6?=
 =?us-ascii?Q?10N5B30WCMGsvPPK3sdj9afrnNkOgLkhA7x/Oq4Unafv7hrwfONeoqtTZyVz?=
 =?us-ascii?Q?opIKuY2XBDQo3LZd3Ls/Ekt/s6ygvQ3tqVqgipVQNhVuVy6WoXOe2H7xWaRX?=
 =?us-ascii?Q?LTDhva9pKJBAx8Y5ej4er0gva1TYy6Lpl50TgoasqZRLwFwfFuxJt5jsTwuA?=
 =?us-ascii?Q?jMN7qC7+mim0a+w1kvD20WXowXW/gVnYf1RPUvBi2osVrL+JQs0qvIXiGsbg?=
 =?us-ascii?Q?yLsaLQLmY+lWA+tqpPvOLGfR5L8h8Ki3XiBRn8UYAhnQ4U2V5toBuc2eXv/0?=
 =?us-ascii?Q?23g9WPGagVyuEeSW85D2ts6Ir2TkW0ABfQA6Q6jB3ocp75n0LmZRkjZefnQI?=
 =?us-ascii?Q?9fWmGMsngdK3CfxZIpRsxfKQmB2DMiFPFuHZyiZE6HQHf22qgt0+IR0OwizT?=
 =?us-ascii?Q?ReUcayrLyki7yEh4Jlm4qQuCbYWb1Lm8kbCt8bTpF+Jqtq+VMELfeYFC0tQG?=
 =?us-ascii?Q?KEJmKRMpZaDHpt+4zeUTLH/RGb22gl/WNmICd4tzH4BvjMW0O7iEMYJE//dW?=
 =?us-ascii?Q?5wDMxgGh5ffQao4tUZ0UwMDywN36FE6H9GfOZ/PwtmdBSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:02.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77cbca2-e0a6-4d75-f161-08dce8983638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
There is a known HW bug that causes the internal 3DLUT fetch signal to
be lost at VREADY, regardless of whether the OTG lock is being held or
not. A workaround is necessary to make sure that this internal signal
stays up after OTG unlock.

[How]
Set the 3DLUT_ENABLE bit immediately before and after the unlock. Also
use VUPDATE_KEEPOUT to prevent lock transition in the region between
VSTARTUP and VREADY, which could cause issues with this WA sequence.

Also including misc. 3DLUT DMA-related sequence fixes to address a few
regressions causing corruption.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 30 +++++++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  8 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 60 ++++++++++++++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 31 ++++++++++
 8 files changed, 122 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d1e397d5f84e..743f3292d98e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2650,7 +2650,8 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 		elevate_update_type(&overall_type, type);
 	}
 
-	if (update_flags->bits.lut_3d) {
+	if (update_flags->bits.lut_3d &&
+			u->surface->mcm_luts.lut3d_data.lut3d_src != DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
 		type = UPDATE_TYPE_FULL;
 		elevate_update_type(&overall_type, type);
 	}
@@ -2926,10 +2927,20 @@ static void copy_surface_update_to_plane(
 			sizeof(struct dc_transfer_func_distributed_points));
 	}
 
-	if (srf_update->func_shaper)
+	if (srf_update->cm2_params) {
+		surface->mcm_shaper_3dlut_setting = srf_update->cm2_params->component_settings.shaper_3dlut_setting;
+		surface->mcm_lut1d_enable = srf_update->cm2_params->component_settings.lut1d_enable;
+		surface->mcm_luts = srf_update->cm2_params->cm2_luts;
+	}
+
+	if (srf_update->func_shaper) {
 		memcpy(&surface->in_shaper_func, srf_update->func_shaper,
 		sizeof(surface->in_shaper_func));
 
+		if (surface->mcm_shaper_3dlut_setting >= DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER)
+			surface->mcm_luts.shaper = &surface->in_shaper_func;
+	}
+
 	if (srf_update->lut3d_func)
 		memcpy(&surface->lut3d_func, srf_update->lut3d_func,
 		sizeof(surface->lut3d_func));
@@ -2942,10 +2953,17 @@ static void copy_surface_update_to_plane(
 		surface->sdr_white_level_nits =
 				srf_update->sdr_white_level_nits;
 
-	if (srf_update->blend_tf)
+	if (srf_update->blend_tf) {
 		memcpy(&surface->blend_tf, srf_update->blend_tf,
 		sizeof(surface->blend_tf));
 
+		if (surface->mcm_lut1d_enable)
+			surface->mcm_luts.lut1d_func = &surface->blend_tf;
+	}
+
+	if (srf_update->cm2_params || srf_update->blend_tf)
+		surface->lut_bank_a = !surface->lut_bank_a;
+
 	if (srf_update->input_csc_color_matrix)
 		surface->input_csc_color_matrix =
 			*srf_update->input_csc_color_matrix;
@@ -2957,11 +2975,7 @@ static void copy_surface_update_to_plane(
 	if (srf_update->gamut_remap_matrix)
 		surface->gamut_remap_matrix =
 			*srf_update->gamut_remap_matrix;
-	if (srf_update->cm2_params) {
-		surface->mcm_shaper_3dlut_setting = srf_update->cm2_params->component_settings.shaper_3dlut_setting;
-		surface->mcm_lut1d_enable = srf_update->cm2_params->component_settings.lut1d_enable;
-		surface->mcm_luts = srf_update->cm2_params->cm2_luts;
-	}
+
 	if (srf_update->cursor_csc_color_matrix)
 		surface->cursor_csc_color_matrix =
 			*srf_update->cursor_csc_color_matrix;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 1a32e53c1b22..9da5b50bea8a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1458,8 +1458,12 @@ void dcn20_pipe_control_lock(
 	} else {
 		if (lock)
 			pipe->stream_res.tg->funcs->lock(pipe->stream_res.tg);
-		else
-			pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
+		else {
+			if (dc->hwseq->funcs.perform_3dlut_wa_unlock)
+				dc->hwseq->funcs.perform_3dlut_wa_unlock(pipe);
+			else
+				pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 65176b59dcb2..413dcbf4decf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -506,7 +506,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
 
 	/* 1D LUT */
-	if (mcm_luts.lut1d_func && lut3d_xable != MCM_LUT_DISABLE) {
+	if (mcm_luts.lut1d_func) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 		if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
 			m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
@@ -521,7 +521,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 				mpc->funcs->populate_lut(mpc, MCM_LUT_1DLUT, m_lut_params, lut_bank_a, mpcc_id);
 		}
 		if (mpc->funcs->program_lut_mode)
-			mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut1d_xable, lut_bank_a, mpcc_id);
+			mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut1d_xable && m_lut_params.pwl, lut_bank_a, mpcc_id);
 	}
 
 	/* Shaper */
@@ -669,11 +669,17 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	struct dc *dc = pipe_ctx->stream_res.opp->ctx->dc;
+	struct mpc *mpc = dc->res_pool->mpc;
 	bool result;
 	const struct pwl_params *lut_params = NULL;
 	bool rval;
 
+	if (plane_state->mcm_luts.lut3d_data.lut3d_src == DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
+		dcn401_populate_mcm_luts(dc, pipe_ctx, plane_state->mcm_luts, plane_state->lut_bank_a);
+		return true;
+	}
+
 	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
 	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
 	// 1D LUT
@@ -1814,6 +1820,54 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 	}
 }
 
+void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx)
+{
+	/* If 3DLUT FL is enabled and 3DLUT is in use, follow the workaround sequence for pipe unlock to make sure that
+	 * HUBP will properly fetch 3DLUT contents after unlock.
+	 *
+	 * This is meant to work around a known HW issue where VREADY will cancel the pending 3DLUT_ENABLE signal regardless
+	 * of whether OTG lock is currently being held or not.
+	 */
+	struct pipe_ctx *wa_pipes[MAX_PIPES] = { NULL };
+	struct pipe_ctx *odm_pipe, *mpc_pipe;
+	int i, wa_pipe_ct = 0;
+
+	for (odm_pipe = pipe_ctx; odm_pipe != NULL; odm_pipe = odm_pipe->next_odm_pipe) {
+		for (mpc_pipe = odm_pipe; mpc_pipe != NULL; mpc_pipe = mpc_pipe->bottom_pipe) {
+			if (mpc_pipe->plane_state && mpc_pipe->plane_state->mcm_luts.lut3d_data.lut3d_src
+						== DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM
+					&& mpc_pipe->plane_state->mcm_shaper_3dlut_setting
+						== DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT) {
+				wa_pipes[wa_pipe_ct++] = mpc_pipe;
+			}
+		}
+	}
+
+	if (wa_pipe_ct > 0) {
+		if (pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout)
+			pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout(pipe_ctx->stream_res.tg, true);
+
+		for (i = 0; i < wa_pipe_ct; ++i) {
+			if (wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl)
+				wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl(wa_pipes[i]->plane_res.hubp, true);
+		}
+
+		pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
+		if (pipe_ctx->stream_res.tg->funcs->wait_update_lock_status)
+			pipe_ctx->stream_res.tg->funcs->wait_update_lock_status(pipe_ctx->stream_res.tg, false);
+
+		for (i = 0; i < wa_pipe_ct; ++i) {
+			if (wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl)
+				wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl(wa_pipes[i]->plane_res.hubp, true);
+		}
+
+		if (pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout)
+			pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout(pipe_ctx->stream_res.tg, false);
+	} else {
+		pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
+	}
+}
+
 void dcn401_program_outstanding_updates(struct dc *dc,
 		struct dc_state *context)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 66d679080c44..28a513dfc005 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -95,4 +95,6 @@ void dcn401_reset_back_end_for_pipe(
 void dcn401_reset_hw_ctx_wrap(
 		struct dc *dc,
 		struct dc_state *context);
+void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx);
+
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index a1392e776709..c73305e57d39 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -138,6 +138,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn401_reset_back_end_for_pipe,
 	.populate_mcm_luts = NULL,
+	.perform_3dlut_wa_unlock = dcn401_perform_3dlut_wa_unlock,
 };
 
 void dcn401_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 0ac675456979..22a5d4a03c98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -182,6 +182,7 @@ struct hwseq_private_funcs {
 			struct pipe_ctx *pipe_ctx,
 			struct dc_cm2_func_luts mcm_luts,
 			bool lut_bank_a);
+	void (*perform_3dlut_wa_unlock)(struct pipe_ctx *pipe_ctx);
 };
 
 struct dce_hwseq {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 4e08e80eafe8..b74e18cc1e66 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -345,6 +345,8 @@ struct timing_generator_funcs {
 	bool (*get_optc_double_buffer_pending)(struct timing_generator *tg);
 	bool (*get_otg_double_buffer_pending)(struct timing_generator *tg);
 	bool (*get_pipe_update_pending)(struct timing_generator *tg);
+	void (*set_vupdate_keepout)(struct timing_generator *tg, bool enable);
+	bool (*wait_update_lock_status)(struct timing_generator *tg, bool locked);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index db670fc17264..783ca9acc762 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -430,6 +430,35 @@ static void optc401_program_global_sync(
 	REG_UPDATE(OTG_PSTATE_REGISTER, OTG_PSTATE_KEEPOUT_START, pstate_keepout);
 }
 
+static void optc401_set_vupdate_keepout(struct timing_generator *tg, bool enable)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(tg);
+
+	REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, optc1->vready_offset + 10,
+		OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, enable);
+
+	return;
+}
+
+static bool optc401_wait_update_lock_status(struct timing_generator *tg, bool locked)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(tg);
+	uint32_t lock_status = 0;
+
+	REG_WAIT(OTG_MASTER_UPDATE_LOCK,
+			UPDATE_LOCK_STATUS, locked,
+			1, 150000);
+
+	REG_GET(OTG_MASTER_UPDATE_LOCK, UPDATE_LOCK_STATUS, &lock_status);
+
+	if (lock_status != locked)
+		return false;
+
+	return true;
+}
+
 static struct timing_generator_funcs dcn401_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -496,6 +525,8 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
 		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
 		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.set_vupdate_keepout = optc401_set_vupdate_keepout,
+		.wait_update_lock_status = optc401_wait_update_lock_status,
 };
 
 void dcn401_timing_generator_init(struct optc *optc1)
-- 
2.34.1

