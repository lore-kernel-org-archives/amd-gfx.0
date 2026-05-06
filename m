Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C8CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944A810ECE5;
	Wed,  6 May 2026 07:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqQufp8x";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C2110ECE6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVmFPfLPpg7Xnic9PNfXKtqq3EZLiihB9lC/Gq+OuWcTV0Zbg3nVkiMLRad0ghpq2UIid/Pt14InVGOWbhi3I04XiiFX+7R5uNxAkvosyUdFbQqwJhWXnEP60INn4tKFrMkbUUrOP2BimdXk+Luum6Mr1NbmLE43bfHp02+LKNvRaTeGpSbbNIKdP0BsFRPHHrJwpI1jgCrqjeaN5SbsUOcJPVS0nSaVr6cdT4Az7BOrW0n0LxzePpkLknf5ElFnx6I7RxCJW7RojnlG4PgmzfkvZ/XHk+pW0waDBomst1IQOHV7uEDqFrcwXh1Sro+L30+vl2jDlcp4o30+phBO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlwfLO9WP9uZy/ZlrESKK5/7D/+3Gt4B3F4nKQ5D8vs=;
 b=tKUXKRCOkY1SaK2pF8zLQs32Huj7n72Taq5jb1Ag1vDAHpb/VggBDZ39dhsKh0c5c2l5Vis4ad6NDDWx7xwrywIxwA04K4KAuqgnYkbpCwOTZOucXSkbkYLpzQTU43otxHeP6m/Ah5OJL7u8Tkgvg/t244bzDXCvyxuI6roXFkrgrOk4YMtVdtZFAKq8fZv3QuHM9897M7/AqsEEVlpWjFfTgtRGKhZVWLzhXq6JcVZo6v238aTDCNhNyFm4sYaNm/J5jJnIwte20s+y4DMCY69sJHKmgCkAEArV+GooOsPmvRF3E5HvYX76u84usvF57Mbo7o99HvPmoztNcNLfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlwfLO9WP9uZy/ZlrESKK5/7D/+3Gt4B3F4nKQ5D8vs=;
 b=wqQufp8xUoz6vZUT+FgD1xFJYuwfRzO3id1ax5jZ483+RlSSUYPTAzNrL7OssMVMWK0BFeQQ4FqObSRCEx0d6+g9cnZKCOcB/FgiDyJK3JpjVRXOLPoMNOmJdZgt/LW4R3BxTo2Yywm9aM93uGEwPDXW2fwsmP67YNSO/pIimO4=
Received: from BL1PR13CA0185.namprd13.prod.outlook.com (2603:10b6:208:2be::10)
 by DS5PPFE52C859EE.namprd12.prod.outlook.com (2603:10b6:f:fc00::666)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:05:34 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::71) by BL1PR13CA0185.outlook.office365.com
 (2603:10b6:208:2be::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:05:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:05:30 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:05:22 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 15/20] drm/amd/display: enable ODM 2:1 on single eDP based on
 pixel clock
Date: Wed, 6 May 2026 12:31:13 +0800
Message-ID: <20260506043342.2164710-16-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS5PPFE52C859EE:EE_
X-MS-Office365-Filtering-Correlation-Id: 137d487c-b8e2-4905-701c-08deab3dddf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sOJA+9T2t5+5jvJw5IS8gVl6DlFv+U5dCXLUtAXMcT79MenV2QKVHwNaWWIyFp/e92fUd6/JM6+tXHgP4GhRz46RydhlhZtuoQb2c01zZmDeFtelsDxKm19c6gSaEyr4Ch7e80xDh5bYfNY0Pnd1RnfGKvpOsyRC5L5G6XSUTHnE1Lw3dTp6BDunneENVFM8L8uZJiQWHcQEyOyo4IYu/9JVzi9M9gzonHIwVuV4CylfuUO5Unn7JFr7N+oN8sOXWGLJINmjL/T+OsgL08ciyu0swuQl4c7GfrGAEs0JD3ADLN4TOHb6sQgOnCU6ubkTaabUwoexBH64U+rkTVgva4WtHXJ9z5cnmjx17l47a1WJeOEhsHEtAWZsldtkHVVDuRgILh47FCMy0faOJbyAw6ez9kJs4ID/kYYi/S/cZhmvut5Bpnpe7J+XsUGFGy2NyT/LMjLhMQ1/8Y1n6YTgSIcyJL8emSZfpTDQsHVZNeZzKrBypUZLcCDqkb7iGOw1517wysW4VZdjBh1wUkOubo61Gu7WrnNVBcQ610iqoWcUPvKNpjJUDJyRvy/KDD7in42pCRKqbQHRYlVDPr33fA1BJDWQwXRCU58q81tjVAOo8BX0g98GQ6me9i6ab3Mh5/i78pg7k5c+z+W0Ks/gEpXbVSD+F1Iy6drrIt+OtMCthIArsFzL99l84NDVWpHuS4GVxLpYYnXpYZyAq2pFMQzsp7CL1s4HNHow+QgSaYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4iKZzMmcftM/MsRwxnao30W2eG5vblU6tdoR9/DI0IWZGmWHQDH0Eig4Wc/95VA/UX82V6ybJRKjgbMz2WuFlV+Us/TDBe0fNY83eXm8WAydUHXuUotFNcPvf0HsDv38vbcAVqmqBdzfaW3I19zMXhfefT29YF2++nj1LWjicX3xas3zw/YG5eg1M7EoHvnzkaTO07pqj9mrJvfPlGs12iPVt2g67b2TSixE6YCthnTPODGCHCgcoitki+8FpRj5UNAp1JcqnOdGsq3EhSy8w5IpsHBQ/yXR1V24F1M60PlQNSp1E8tP2bv2YsAWpKPmNEgBQxEkXj9Qna/NPrdt3uRtyuYRsBuELEAvGLqFbMN/faKqsLmIFBBLQSTmgEgRNJAmJ0xVU4AK8nbYeN6J6kZtUviThZpHIs/8BegKyBneVpoU3ey1tracGtcoqahX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:05:33.7859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137d487c-b8e2-4905-701c-08deab3dddf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFE52C859EE
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
this is to force ODM 2:1 on single eDP to lower dispclk/dppclk.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../dc/resource/dcn42/dcn42_resource.c        |  4 ++++
 .../dc/resource/dcn42/dcn42_resource_fpu.c    | 22 +++++++++++++++++++
 .../dc/resource/dcn42/dcn42_resource_fpu.h    |  2 +-
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e5933e3a8206..30ff7f1b9513 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1219,6 +1219,7 @@ struct dc_debug_options {
 	unsigned int force_vmin_threshold;
 	bool enable_otg_frame_sync_pwa;
 	unsigned int min_deep_sleep_dcfclk_khz;
+	unsigned int force_odm2to1_for_edp_pixclk_mhz;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 57c6e81280bc..01a7639da80b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -765,6 +765,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_deep_sleep_dcfclk_khz = 8000,
 	.replay_skip_crtc_disabled = true,
 	.psr_skip_crtc_disable = true,
+	.force_odm2to1_for_edp_pixclk_mhz = 550, // Force ODM 2to1 for eDP when pixel clock is above 550MHz
 };
 
 static const struct dc_check_config config_defaults = {
@@ -1721,9 +1722,12 @@ enum dc_status dcn42_validate_bandwidth(struct dc *dc,
 
 	DC_FP_START();
 
+	dcn42_decide_odm_override(dc, context);
+
 	out = dml2_validate(dc, context, context->bw_ctx.dml2,
 						validate_mode);
 
+
 	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING) {
 		/*not required for mode enumeration*/
 		dcn42_decide_zstate_support(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
index 33b9775420d3..ee330559c233 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
@@ -45,3 +45,25 @@ void dcn42_decide_zstate_support(struct dc *dc, struct dc_state *context)
 	context->bw_ctx.bw.dcn.clk.zstate_support = support;
 
 }
+
+bool dcn42_decide_odm_override(struct dc *dc, struct dc_state *context)
+{
+	bool odm_override = false;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+	if (dc->ctx->dce_environment == DCE_ENV_DIAG)
+		return false;
+
+	if (context->stream_count == 1 && context->streams[0]->signal == SIGNAL_TYPE_EDP) {
+
+		if (dc->debug.force_odm2to1_for_edp_pixclk_mhz != 0 &&
+			context->streams[0]->timing.pix_clk_100hz > dc->debug.force_odm2to1_for_edp_pixclk_mhz * 10000) {
+			odm_override = true;
+			context->streams[0]->debug.force_odm_combine_segments = 2;
+		}
+		DC_LOG_SMU("odm_override: %d, eDP pixelclock: %d, force_odm2to1_for_edp_pixclk_mhz: %d\n",
+			odm_override, context->streams[0]->timing.pix_clk_100hz / 10000, dc->debug.force_odm2to1_for_edp_pixclk_mhz);
+	}
+	return odm_override;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h
index e32103220507..aff7be777681 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h
@@ -29,5 +29,5 @@
 #include "core_types.h"
 
 void dcn42_decide_zstate_support(struct dc *dc, struct dc_state *context);
-
+bool dcn42_decide_odm_override(struct dc *dc, struct dc_state *context);
 #endif /* _DCN42_RESOURCE_FPU_H_ */
-- 
2.43.0

