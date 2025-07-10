Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A49C83F20
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E853210E972;
	Thu, 10 Jul 2025 21:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnGl2R0b";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DA910E973
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOOP/Z6gdEamZALpMyH9Docdw0Hn2p1a2C+F7tiVy79CPHOnHQK0CbeinyKiZgRQQ4Q6jnx5KO8KpZeAoxM/jkN99nb48fED0Mi+lYHT9iiXrNgncLWqa7WxC4y+kD9MruiBeHQo4rzqLy/s/f47Tp95nmQM+YZjCAN6hhFnYAjhmC8qFZQpF8u6EHP0sehHtK/bq51DJD8FykJGYY+DrLoMud9+j616ZjnE11OYeMLZKzjB34YeWupBSZuglouQnCSc2NVPiudQtuuAB/8ueXqnd70fWXHv5b/TyfmF7x+gB4DjIpsgQ05VKEliT26QwJPzKlL6aX58tQYMk19qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td5aopQKAg5uGa/SDPj+6tNEARVjujHbj2Vd3froyUE=;
 b=EoeOzJIYfYQ9iAqwUMGtHjPS2g5kK1ByiX4DqwfEEFQab9LWid067oMa6dOINOiFCXkowFauiiXYtYKpE04vm5ak71GbIffnaLil4J+Exc5SMwsyr32gvreDTprh1ps0lxvdjVQwMFClGNuvMa5JXIrK784JSE88s0F/XlPRYVoDiRzh8HJkzx+Vh0Fa/FwspibLejZ8QhnenoyZTIOU/FLyN+6FAIMJF0+WdG2AuoRyLUbiIqW2TmzesZTUswtoi09GJ3QwJX+Owmb4DyS+XANodUXoxDq+mhkSiOUdE7QJb0NgFv2C02uH2G1MGAegbBVF60Ox6D9Y4CUaA2puGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td5aopQKAg5uGa/SDPj+6tNEARVjujHbj2Vd3froyUE=;
 b=BnGl2R0bywVwP3XTkdqqJmp2i+K6Q8A0wH1bavmYV/U4QhwvFhlwK92bcmFxdLC1uELnoYPi66U8kVRbUiMM+6QjBz3L4iX4zx6VXrPhFo562ekKRLJkIXqUWnx+yVlXAsHp6GRjZGE+EW+gYENBYkPiUztPlFGybYXEAqzaCzs=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 21:31:32 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::1a) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Thu,
 10 Jul 2025 21:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:14 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:14 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 17/18] drm/amd/display: Revert "Add DPP & HUBP reset if power
 gate enabled on DCN314"
Date: Thu, 10 Jul 2025 17:25:50 -0400
Message-ID: <20250710212941.630259-18-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e6b970-f030-49b9-c8d7-08ddbff923bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HioA5e2MyiASEdwc4/3z1nnZWWuyg5mLeMOVKuzasUole+NP4MZHQyNN4eoe?=
 =?us-ascii?Q?KK4O/D2FRGgMP/ABpmVibn/b/c5oiAdShN+7X9wY2YDa3sURYFCxj8ygsyzu?=
 =?us-ascii?Q?rJjNTQszhItbH1g21dEzplVdTPr0rcxntCmTfmEVhQupeJih2lWGaHnq8ZWq?=
 =?us-ascii?Q?Rt5TmGKPjefEMF+Glk4jIAGIgQ/W3VPHfM+Xt7DZT6b2lpFyy2kY6lO2KKfZ?=
 =?us-ascii?Q?8YA59C7v6ug/0NbEYL1IzBiMBoPOGaLtNZtu7qPptpcb1b2+Le6Xl1hGBWNl?=
 =?us-ascii?Q?46HsarRGvCV7KBZa1siCuHVQE8E8sE5R/F8N96DzOWNZrR8oCKxJaLRZF3uN?=
 =?us-ascii?Q?pi2r2HhMatrzmeKPjUL0nU8pKf32L6u4S2LRIHsOwZq/qX8GW7wQ1w+VQtbN?=
 =?us-ascii?Q?QK6luQAJv4q4kaifFiSZRmOhmYwlNIwXdd8YxsJD1GfToCTUOMcjGmq7641f?=
 =?us-ascii?Q?Alb+2fTyBQ56+diBzi0G3S+X+ay9TxkNDP7vMzMVXqzzUcPcjYdhHkOqmCe/?=
 =?us-ascii?Q?9RAE9G6JUViSNMGrwFq9Iqi/6/9dn0S9CgOAQ+Q7My/JANQWU7qjDWSJsDSA?=
 =?us-ascii?Q?6LwRSyyQW7a6B6sRyqXVmiXrSY2SgDzgaJeUKoDRl+g1RA27oXUwmzk12XlS?=
 =?us-ascii?Q?u51L9wPSp3tl4kTfnJwTFqgM960Y89G0iW45tZZ1HMbVcmn+azgBrb6fyOcU?=
 =?us-ascii?Q?x8nUtSktU7o7mQ5JbriA+WjtM9YtTNTeOgqEPwUfCRF0uQKb5xOr7aPcJWpO?=
 =?us-ascii?Q?GRLGvXTq2KOGv7uTOPvX0ONbeMTUx04/yz/djPQV4Lt/tjlc4B+taeejioCf?=
 =?us-ascii?Q?O/wUvDCazNoA+4DmXe8CIViAizSSzbwHhIy2wcNBoNMcKfn979ffR+kk4fEV?=
 =?us-ascii?Q?hM8fxHvNRKcHXvnyZf3ly0uYyqmYGcUThxXuxDYdl5ca4j/JCtHyh7aNruF6?=
 =?us-ascii?Q?oebvJsayhA540ZfAEAzovnseqRAwLq+Uxd87ebV8BW6+PmkBUyz1FDU3K0ux?=
 =?us-ascii?Q?WLmgAiFAo+dfrNSV7ZMYBWvq/fBME9sEYsLYJksN6e7hhVMU3eZNKxAto0aD?=
 =?us-ascii?Q?qmJU4mpeq+HHG3bn0MrtcFSJQN0jiFoH6+JXKVeAlmmePpRV2kttrKwKDzjt?=
 =?us-ascii?Q?d+rhxjF/UMilNfTYYkTurcjGPLDDFc4ZhYyu+eqUp0rfzQzmrxHW1Qso0jWe?=
 =?us-ascii?Q?saKyWw2PBUXgu3SC/cejtcZbgSBWKshNZ45OIWIdGuNk/K+IuGx+DakH9l5s?=
 =?us-ascii?Q?MxhC/2RGZMHOWHnAaW0r7w5Wg/vvyAkZ30TFUYWBFJZ1eAE/PrbkbdD7YJTY?=
 =?us-ascii?Q?xvh4a/wiusCLk1VDnYErXs6zjX1KEYwRFj90H/HwargmucSFZlemPReY4taf?=
 =?us-ascii?Q?NrExs8LxOrFLqf1xfmAWvt+YiD575IhFSDn27ltxh0URrTerSJfUeiMRrqfL?=
 =?us-ascii?Q?3NWmhp1fww4FeS9ZfBskEpXatfz04gwkcPfQEVlvXUCB3UWOQRqzlr/9ezQ2?=
 =?us-ascii?Q?DcZudWkRRMeiXjg7A5jj3X7MqqEZXb3WF5F9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:32.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e6b970-f030-49b9-c8d7-08ddbff923bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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

From: Ivan Lipski <ivan.lipski@amd.com>

This reverts commit 7edfb158033874d29146eeb457daf080aa4d6aed.

[Why & How]
This commit caused a blank screen on internal display when projecting to
an external display on DCN314.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 37 ++-----------------
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 3 files changed, 4 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index a40e119d8582..e68f21fd5f0f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -55,15 +55,15 @@
 #include "dcn20/dcn20_optc.h"
 #include "dcn30/dcn30_cm_common.h"
 
-#define DC_LOGGER_INIT(logger) \
-	struct dal_logger *dc_logger = logger
+#define DC_LOGGER_INIT(logger)
 
 #define CTX \
 	hws->ctx
 #define REG(reg)\
 	hws->regs->reg
 #define DC_LOGGER \
-	dc_logger
+	stream->ctx->logger
+
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -76,8 +76,6 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
 
-	DC_LOGGER_INIT(stream->ctx->logger);
-
 	ASSERT(dsc);
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		opp_cnt++;
@@ -530,32 +528,3 @@ void dcn314_disable_link_output(struct dc_link *link,
 
 	apply_symclk_on_tx_off_wa(link);
 }
-
-
-void dcn314_plane_atomic_power_down(struct dc *dc,
-		struct dpp *dpp,
-		struct hubp *hubp)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	DC_LOGGER_INIT(dc->ctx->logger);
-
-	if (REG(DC_IP_REQUEST_CNTL)) {
-		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
-
-		if (hws->funcs.dpp_pg_control) {
-			hws->funcs.dpp_pg_control(hws, dpp->inst, false);
-			dpp->funcs->dpp_reset(dpp);
-		}
-
-		if (hws->funcs.hubp_pg_control) {
-			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
-			hubp->funcs->hubp_reset(hubp);
-		}
-
-		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
-		DC_LOG_DEBUG("Power gated front end %d\n", hubp->inst);
-	}
-
-	if (hws->funcs.dpp_root_clock_control)
-		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
-}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index 12a57b79edfb..2305ad282f21 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -47,6 +47,4 @@ void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
 
-void dcn314_plane_atomic_power_down(struct dc *dc, struct dpp *dpp, struct hubp *hubp);
-
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 6963d25608ac..f5112742edf9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -137,7 +137,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.disable_vga = dcn20_disable_vga,
 	.bios_golden_init = dcn10_bios_golden_init,
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
-	.plane_atomic_power_down = dcn314_plane_atomic_power_down,
+	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn31_hubp_pg_control,
-- 
2.43.0

