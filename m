Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CFCC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB5B10ECBB;
	Fri, 14 Feb 2025 15:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQwg93sx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D65410ECC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCU6nfyiNvfuIKvyf0e3FPfBH9a5/AsaWdc+5ukppN9UyDsny/eCovDPye2gEnozUB20+OA2PtZQZrkCGbJ+7AKFjG8fFLYReyYsy4wajF0Out+vZfcV84ysOFr47sMXw9wUQgkxM5Iid++EcTso7cb13IN5T1+r7kb00Q2ekUfg7tNFJOmatsQIDn1jIESIoSNF8vrUakrqt1zQwJLQIpMYXERB8qhS8xTmcG9GeKQOwtENlZZk9kMwKdHu0S7r4apApoVrDfJEiUzDg3o3hlUBuPFDY6sTtvtGkoiN2NbkwVlwP3QkBfZyuCUrXvOFovauLyi1I58uzvwFKVdxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7de3p3vJeCcEtOh+CAzascawRikb8rAaCHmbc6S/p5M=;
 b=Ni2W4GjrYG295lVfSt+BKWyQPN5d7O8age1K/4rbi8NOq02AzQdt8M2bwsl43ZVwUAqvLnzzt8SWC9GbJig1Bm6JwoILk9jWEuUDWw0z94BacDu4IAPuQvZ8Kgu+K+CgpBtCVuIs9GKjZyOCHzFk2zYvZoBYafed8HVuzsv1d35qlC87Dtu+APgV7Vzz+J7Z08vrmAj5olGgK9AGYVSWhPCAEe5zXOQfhqh2sC/xDXBROFMhw8/l7GWU3/3JygL6zFTiZEt9sxneisZ5fGvaq8lvcMI1LFb+k/chsCjIxZNW8GEXI1VKhCl7TwjRHwzlvCabAh82MGRfdV0vFdvohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7de3p3vJeCcEtOh+CAzascawRikb8rAaCHmbc6S/p5M=;
 b=hQwg93sxpHKGP2z76ssZUB8D4QIqFowOyAHFI1OtN7M+yEqoVs7M1Hi/kJao12aRinUFpQ8Y4oJeKJr2F+H7viaQvzKpJXDhfTtQhhIGrjgajhPoHUzbSHLAETkL2iEFaaydywnn9uPkNsuokrkIRxvw7QeI/jNJGQCawCMnbLg=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:01:38 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::da) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 15:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:35 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:35 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Rodrigo
 Siqueira" <Rodrigo.Siqueira@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Add clear DCC and Tiling callback for
 DCE
Date: Fri, 14 Feb 2025 10:00:24 -0500
Message-ID: <20250214150033.767978-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e51022-e590-474e-ddf9-08dd4d087b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCcCFj3op5qHPoN1au1hQTSHd5DrurUMEXQSgivqIoJyz6oyzlTh5/1Yc+2a?=
 =?us-ascii?Q?LZCE2HeYDse0A28N7JxRLoD0EoGOhD//RoSiiLiBf0/DrHwsjLuKKUTh4PIx?=
 =?us-ascii?Q?cXFZOifYhe+xc6pyow1fK7AtLPD3B9AIYhHkJH/Z1SNYdRRLocXqzWlzIJr6?=
 =?us-ascii?Q?x0flMHeWi6Ub4bb1D8t3njqLqFxKMIUrzDxK7NauYTVaKMFND8ETmMitYzXC?=
 =?us-ascii?Q?r3Im5d3n1BZLwCmr5v3G6PVzBn840ww2uoHg0F7BF5FT/r+e5YVzwNTssb3A?=
 =?us-ascii?Q?5mPmGnk6tD3DBDfzusQAHCxtRKgpCaZxrw7EpkL4HXsnbHQVjJhjRH+ooylQ?=
 =?us-ascii?Q?VJxdWAJLeUect6uSob95uy2FIa2e07N2++XCtrVJj8NoG2hJDj/D6BnC7bsE?=
 =?us-ascii?Q?HwnIJneNK1x3YWA7XPN/SoVzUpGaBzvPRZyjpAzgiG0ADt4af9mCSSp2Tbs+?=
 =?us-ascii?Q?WsdTDjLFGB6wWjOMf4Uxy9/Yy4GAqK2sJWG1jHrjsy6j/nF+dJu7YUI9C5fD?=
 =?us-ascii?Q?YxT33POrZXrSphUViXQzzAbX/9b419mCBXQsFCkPeOKnnYBs+wtFQm8ljOm3?=
 =?us-ascii?Q?beRaL9g5aKmv3WesW8E/aq5yryNyc0OF3exdCE24oWf4yOUG4nrFmidAEGqx?=
 =?us-ascii?Q?se0ka3zIpF140rlGkyYegHW6nx5/Y9h65ToJ0tcG0rfx6GvEfdMh+FEkHdGZ?=
 =?us-ascii?Q?YCARnUebMNmoGK+zkP8Omoofef5r3jnXCwIO10tEKD8NLf8SiPfisiNW2BSn?=
 =?us-ascii?Q?AcVPeRY1kEtmStG0Kkhca2ckhuaTGbD2To+raFzGgJwdrtih76g7V8wBUMEu?=
 =?us-ascii?Q?FOhRf4eRcIRHbd1+0li894yZmN4UAulMp8PmwOAGKJ+4YnuD4RECyKkjdqMs?=
 =?us-ascii?Q?/IZQdz382WTI9YIB/tSkhFjtFmBtGjRkiusCXmtO/NPhrhLHJyk2bNBgFqOW?=
 =?us-ascii?Q?anojwL1Yk1nU06SYvE6lKlDpPTm3h/c/9stx4FxxNEg34mMTcPaT9lVIoZeS?=
 =?us-ascii?Q?5FGPAyZ1iEwI798BVTL8kEPPcVmD8LUJ0Ne7j4qlMKKpAr5ACWJG45woOJbk?=
 =?us-ascii?Q?9lhZnK+nAc/G+jX9ToqWshTryWJh60LRWOPhSG1Swp0PYGhw/QCO5qFJsHZ+?=
 =?us-ascii?Q?Mv9kWYbuSLjaJOK9rautVAlWc4HxjYdvL5PKXrUILnuXB53ZDmLRb9asK3TE?=
 =?us-ascii?Q?BIRjbRDsjoUmRLprWKg5fhCj4yFil1jRVi6IMEXw0RlCzz1ox8mgiyCBG7XA?=
 =?us-ascii?Q?BjQyO2yR9by/e+NVeXenL2J/BnISvOzMoKDCWkhrgJRaZEXlvgq3UltGYyAF?=
 =?us-ascii?Q?jw81zsfuU99GpbTdTl51huog8ZAHH1nnfZU5Z39l59+boVx+bjP+g/Q81U9d?=
 =?us-ascii?Q?u7W4H1xyNQ3m5y8agz0/WszyumFfOKfzGHSta7aNGmGSgi1JJT9FWjwsXPYM?=
 =?us-ascii?Q?MsWsuisylBgbo+0SpedHrTV8JFwiuK4xl2dCM0qbnl819WqsbpSGl/Br8aFD?=
 =?us-ascii?Q?kfexO2B6Z26dTyM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:38.0916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e51022-e590-474e-ddf9-08dd4d087b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Introduce the DCC and Tiling reset callback to all DCE versions that can
call it.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_surface.c   | 18 ++----------------
 .../amd/display/dc/dce60/dce60_hw_sequencer.c  |  1 +
 .../amd/display/dc/hwss/dce100/dce100_hwseq.c  |  1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c  |  2 ++
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c  |  2 ++
 .../amd/display/dc/hwss/dce80/dce80_hwseq.c    |  1 +
 6 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 691b4a68d8ac..e6fcc21bb9bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -290,21 +290,7 @@ void dc_plane_force_dcc_and_tiling_disable(struct dc_plane_state *plane_state,
 		if (!pipe_ctx)
 			continue;
 
-		if (dc->ctx->dce_version >= DCE_VERSION_MAX) {
-			if (dc->hwss.clear_surface_dcc_and_tiling)
-				dc->hwss.clear_surface_dcc_and_tiling(pipe_ctx, plane_state, clear_tiling);
-		} else {
-			struct mem_input *mi = pipe_ctx->plane_res.mi;
-			if (!mi)
-				continue;
-			/* if framebuffer is tiled, disable tiling */
-			if (clear_tiling && mi->funcs->mem_input_clear_tiling)
-				mi->funcs->mem_input_clear_tiling(mi);
-
-			/* force page flip to see the new content of the framebuffer */
-			mi->funcs->mem_input_program_surface_flip_and_addr(mi,
-									   &plane_state->address,
-									   true);
-		}
+		if (dc->hwss.clear_surface_dcc_and_tiling)
+			dc->hwss.clear_surface_dcc_and_tiling(pipe_ctx, plane_state, clear_tiling);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
index 1fdeef47e4dc..44b56490e152 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
@@ -428,5 +428,6 @@ void dce60_hw_sequencer_construct(struct dc *dc)
 	dc->hwss.pipe_control_lock = dce60_pipe_control_lock;
 	dc->hwss.prepare_bandwidth = dce100_prepare_bandwidth;
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
+	dc->hwss.clear_surface_dcc_and_tiling = dce100_reset_surface_dcc_and_tiling;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
index b76350a9cf5f..0d7e28260db1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
@@ -138,6 +138,7 @@ void dce100_hw_sequencer_construct(struct dc *dc)
 	dc->hwseq->funcs.enable_display_power_gating = dce100_enable_display_power_gating;
 	dc->hwss.prepare_bandwidth = dce100_prepare_bandwidth;
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
+	dc->hwss.clear_surface_dcc_and_tiling = dce100_reset_surface_dcc_and_tiling;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 935d08d3a670..8280e3652171 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -33,6 +33,7 @@
 #include "dce110_hwseq.h"
 #include "dce110/dce110_timing_generator.h"
 #include "dce/dce_hwseq.h"
+#include "dce100/dce100_hwseq.h"
 #include "gpio_service_interface.h"
 
 #include "dce110/dce110_compressor.h"
@@ -3332,6 +3333,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.post_unlock_program_front_end = dce110_post_unlock_program_front_end,
 	.update_plane_addr = update_plane_addr,
 	.update_pending_status = dce110_update_pending_status,
+	.clear_surface_dcc_and_tiling = dce100_reset_surface_dcc_and_tiling,
 	.enable_accelerated_mode = dce110_enable_accelerated_mode,
 	.enable_timing_synchronization = dce110_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dce110_enable_per_frame_crtc_position_reset,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
index 22ee304ef9cf..2a62f63d0357 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
@@ -29,6 +29,7 @@
 #include "dce120_hwseq.h"
 #include "dce/dce_hwseq.h"
 
+#include "dce100/dce100_hwseq.h"
 #include "dce110/dce110_hwseq.h"
 
 #include "dce/dce_12_0_offset.h"
@@ -264,5 +265,6 @@ void dce120_hw_sequencer_construct(struct dc *dc)
 	dce110_hw_sequencer_construct(dc);
 	dc->hwseq->funcs.enable_display_power_gating = dce120_enable_display_power_gating;
 	dc->hwss.update_dchub = dce120_update_dchub;
+	dc->hwss.clear_surface_dcc_and_tiling = dce100_reset_surface_dcc_and_tiling;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
index 0a054e880801..76fd45550c5e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
@@ -50,5 +50,6 @@ void dce80_hw_sequencer_construct(struct dc *dc)
 	dc->hwss.pipe_control_lock = dce_pipe_control_lock;
 	dc->hwss.prepare_bandwidth = dce100_prepare_bandwidth;
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
+	dc->hwss.clear_surface_dcc_and_tiling = dce100_reset_surface_dcc_and_tiling;
 }
 
-- 
2.34.1

