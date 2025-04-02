Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FA5C36017
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C08510E828;
	Wed,  2 Apr 2025 16:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJjrMIQY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E000110E837
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn1f4XNGBRCLUeUXqwTL80PIFmxQ/DvRTm8upgx5cTf3lCwfE94JH5hmBvO6igwuk8yLmI6HEhlaLzLCS/2CIlh86lL1Txeap7OHfPDqAunMcHCA56Og5Qop1SmF8RJRk0DOxbUV5e4nQN/dPlQg+y558b9g/HxsEajx61jmGpjTpiDIdY4Spd1Aal05Hex2PQh33Nrp4dKTA0gO/Kcjsl564XgxxBuShAa6tYxI5YhX3TsFD74zqgdNgCOWwWCcIldPCvA8wi6yu/ulmFdktmEEqxNckp1KQ+BltVyTt4ZvyaJ9SIZTkMH1ysJRvVkGgM2UobPpM8rw/QQVzDxoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9s3p6Z44sI14ALNXROsFpQ7gJJlMfOO8d4m9ME5N6U=;
 b=PTPp09CcoF0DgCgJjBu+/+EiQsnxydv/PlczRwW20mvm352AKqL0N7XwE/pmzslSM/WLj3ZCJDAtQadjvYmyu11YNfbkg/cPZ9oRhp1iOrIWQlW/QPlSDoxREYiwTMgVtxa1PrahtUfEqgH5ifDm22ur34FEa8hi80QGpXeWdMnk5JycJuLxg8UpfNCITjaPI0ee5Js67l3/3YZxk7Xc8YmlLSMDg/UDIcYUUpknnbirqEbGIzJEqatimGlxB/t61iAssjFBUgrHKAi5ZVxHBSQNUVU03D9hjjTW9tiLhmCV5KuEqcqpbJJrLUFwZ4AgnGmHTrOuKquXxQE3IlkXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9s3p6Z44sI14ALNXROsFpQ7gJJlMfOO8d4m9ME5N6U=;
 b=TJjrMIQYluZi3ymXA+DWpFG9j003XBJwqZ5efAeoO9LJ1bt3KYYzJABYpZIYzKlQ1XxhhjjtqQIICujBAzU3wuYsTWHeeVCYHDLchq4j8vwAToCyQgwriFlcxSXvXVttAXAuu1rS74SlALnl1RT9xxyU8bHFdjRZIxV2qG87U5g=
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:13:52 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::45) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:50 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Dillon Varone <Dillon.Varone@amd.com>,
 Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 13/16] Revert "drm/amd/display: Fix VUpdate offset
 calculations for dcn401"
Date: Wed, 2 Apr 2025 12:13:17 -0400
Message-ID: <20250402161320.983072-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dc36c6-fe13-48d5-1e04-08dd72015bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uDXSDfA4kN/Rqq/xdAdJBSbwdbhFOOW4N4Bmd60Kbe4by6B1rlGvaKb9UDPF?=
 =?us-ascii?Q?f2V3irda7H5AIaGe5nOaSxmLakspX7MNFRF1omPP4BScmOuKewyLU3B4GXk6?=
 =?us-ascii?Q?Msp6OtuQaEwvw4EiTOhINIdTbPne5i18RCh2/c84kMPu1WCG/UaaOI5yQaQ0?=
 =?us-ascii?Q?zEovR9eY4jyWRfmAmGlRelRocpMIQ7OKUi6O093rSJCiX5ctd4ixPV8APt9w?=
 =?us-ascii?Q?rrxAsXK7vaXMqiUFG/HHRdZ9Bazv2H+kCAHK+HpRlOXWViGWMpl3yP0mDClU?=
 =?us-ascii?Q?gFRhSL6Gfjx8WEd64Tv9u8GCT0RePtJFp03c1n6asWlYHc/PAP1SURK0IBeW?=
 =?us-ascii?Q?CiVscx5TgkGlnZONnGxMprYXQ6PC+dseIPoXSN3jHRxgPmhQsz3+IwuYEd2C?=
 =?us-ascii?Q?quKH9NuifD6MFVKdg6foq5V0cGUXoAgsPzDsHO6U1DsATQ6ipyc17VNNyLz0?=
 =?us-ascii?Q?jCeoQODWeFU8Y5VizipExM2rD1GqEUJ4E+ij9GSDgFgOr3bn+pGId9+IQMad?=
 =?us-ascii?Q?s63NsMIa6vQgoKBTdLQfxKDkS3PROnaQfecLXoE2mrkEiuWvPdOOGAs7MCxi?=
 =?us-ascii?Q?Lh867mZvVgvndcos5pIh29lvw/LQVp4wJjnfyVPfGz7TyqBoP+Gv9XhWUkI2?=
 =?us-ascii?Q?m1tI6mCCU/Db/JJ56eS5FO3iWo1CDBiqR8QoInSGZQHojWq/AnMrzb6dX1k0?=
 =?us-ascii?Q?A0GElqjBygZ+7wbmEv4xtzc5+d1z9ESwLK/b+4b60Xuc7Wm7sAmq7ZJpuZTP?=
 =?us-ascii?Q?sgJt+yMZFvC3SdATLhliSuXMlqTJ1+3XFTByEDLot4oWB48IHFG7uRVLdrS2?=
 =?us-ascii?Q?8VU/8tAurMtYv8t14txzWihgHr9avXwSJfBEv/QyECN2LnAer18JnIWF/OUg?=
 =?us-ascii?Q?zTklYMAmOm90F3e0fd5NJ40saSwR+KljYhOMnK0jYrR709RW0fa8+7ZR+rFU?=
 =?us-ascii?Q?9QRW7SPs03p+8nuUtQ3YdVlldpZndejLny7pHKo5yMoMQgveLXHGo4mXShQ9?=
 =?us-ascii?Q?YPuW5iCfCQPGNio9vFmEHU64KPl8W/VCPW24paW4q4sgH4N+Er07O0i7fxlg?=
 =?us-ascii?Q?S4YBAj8ifBXeydHBKNXlDRNUaZfCPtu4eu27mWrUgHfSuO7T5JdufcheFuqX?=
 =?us-ascii?Q?MtYhbdG5n5bd5xNs+wIK8pos8/+0zpv7N2YQJbOIazFSxeCwBBa1MkudDb8o?=
 =?us-ascii?Q?m+liyIwMx1fRmgZNNUCO62lMas2heOzw3FvnccUSQQeNnIjT6mEZWljD07Ml?=
 =?us-ascii?Q?9hybAh/H5KIw0QeLJjASYN/TXhI83aPtP/aVV+ZU4ZFRVPdlY8Scp5zon6sM?=
 =?us-ascii?Q?5zQnjRH9OV/AQI2yGf44RRZM7/J5H3/ZDL46t8+MBJ32xxzwIz5t83kpie8U?=
 =?us-ascii?Q?x/5t55Hl9G5BYDfuvXHibf6EbYT+d/UK6hmqD6yehQGlKMiMmEWSSiG0i2Ak?=
 =?us-ascii?Q?0noQ7GQqnPdrSdMzDFeuTIHM8U3iCTrboILLC+ycwX2X+Ki9TXCmGT8WzOmg?=
 =?us-ascii?Q?vDje0EGMNS7uIis=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:51.5442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dc36c6-fe13-48d5-1e04-08dd72015bbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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

This reverts commit 3ad2d94de0c72e31105cb8e607e7ca19f579bf4b.

Reason for revert: it causes stuttering in some usecases.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 44 -------------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 3 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 79f4eaf8fc52..5489f3d431f6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2646,47 +2646,3 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	if (hws->funcs.dpp_root_clock_control)
 		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
-
-/*
- * apply_front_porch_workaround
- *
- * This is a workaround for a bug that has existed since R5xx and has not been
- * fixed keep Front porch at minimum 2 for Interlaced mode or 1 for progressive.
- */
-static void apply_front_porch_workaround(
-	struct dc_crtc_timing *timing)
-{
-	if (timing->flags.INTERLACE == 1) {
-		if (timing->v_front_porch < 2)
-			timing->v_front_porch = 2;
-	} else {
-		if (timing->v_front_porch < 1)
-			timing->v_front_porch = 1;
-	}
-}
-
-int dcn401_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx)
-{
-	const struct dc_crtc_timing *dc_crtc_timing = &pipe_ctx->stream->timing;
-	struct dc_crtc_timing patched_crtc_timing;
-	int vesa_sync_start;
-	int asic_blank_end;
-	int interlace_factor;
-
-	patched_crtc_timing = *dc_crtc_timing;
-	apply_front_porch_workaround(&patched_crtc_timing);
-
-	interlace_factor = patched_crtc_timing.flags.INTERLACE ? 2 : 1;
-
-	vesa_sync_start = patched_crtc_timing.v_addressable +
-			patched_crtc_timing.v_border_bottom +
-			patched_crtc_timing.v_front_porch;
-
-	asic_blank_end = (patched_crtc_timing.v_total -
-			vesa_sync_start -
-			patched_crtc_timing.v_border_top)
-			* interlace_factor;
-
-	return asic_blank_end -
-			pipe_ctx->global_sync.dcn4x.vstartup_lines + 1;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 37c915568afc..781cf0efccc6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -109,5 +109,4 @@ void dcn401_detect_pipe_changes(
 void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
-int dcn401_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index aa9573ce44fc..fe7aceb2f510 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -73,7 +73,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.init_sys_ctx = dcn20_init_sys_ctx,
 	.init_vm_ctx = dcn20_init_vm_ctx,
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
-	.get_vupdate_offset_from_vsync = dcn401_get_vupdate_offset_from_vsync,
+	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.apply_idle_power_optimizations = dcn401_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
-- 
2.34.1

