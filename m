Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7089C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3473810ECEC;
	Wed,  2 Sep 2026 05:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O9SKdc5S";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011018.outbound.protection.outlook.com
 [40.93.194.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D4D10ECEC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyP1YPezNGXozC9nXiYYZY4nucnci1pGYEkacsGetE+N46asAtps1vEmRuIOlhm9FG3mdXBaFZLH7Si+6NWqiPxtARxJcFU1ruZIgV72e2iqkSvwFcqGjbN1muI7WmdrtSffBzt+OIAzJsD7bTl40iQBsR3MqGrG2g40RuUAo+JR/PgfuI4xHmc6yh0mJjS/5vChdfJqTaoq3DIxmBdEV0tZeU93yci3tvtHxfXpcUFThy7rojKsbMaZN6FN0aaclSn1W6uacoKGcQEExhZhKa4mIShqaGuVZMvIxZwKAWIsTMhGJnzYgRKVYpILdEWm5MvCalne6bvjdeTOEoI5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5zH743ynQzPutz6TYlbE5paDnV6sit4kc046fWlNso=;
 b=rJoDVW+CUCYfKoXV6JLMxI6U7Nowop1N5wr3qtPlXhyjXzlI3rO/TcOt/GtkCtbMIEd6CB3PFPiDifprw+3oWG5yY1wWqgJrUmRTokc0WxQ6bLHktTf984aZRmQoQZWc9hulGKQEiPP6JW901IumsfwNYeEpni0x+zwtKr6QN2LrCGRcZlcLsapuduSfxmi0AcmERb4sKjSXVl8FEsvxbVpK9UNQw0ELj/Fu5oqIxnDXaCiYKij/gCTROGLvbS2ys8VQluui+1BUaPKXoRDuFnxemc5otc+4DXtD2bVFdQkcib3uyZpn97G5+IdQ8iwG7nxREd4YVakImkN+WCbxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5zH743ynQzPutz6TYlbE5paDnV6sit4kc046fWlNso=;
 b=O9SKdc5SKziSuwCfgcT607yV3Ys8de1snZHRQJY5qUgfEoQt6/ZtX7MPyf3Z1c579FSvQ3bYyBh2EtZe4vrddXDSnyDu8Y/wrtGTFym7u5KRqw29qNnP/S34j4zCscFf9I/UxO89Rl6NHGChy++jlV1TnN3tVcdDywzFBmB4DL8=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:06:30 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::21) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:06:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:28 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:06:19 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 14/40] drm/amd/display: Make sure streamclk gating is off when
 enabling streamclk
Date: Wed, 2 Sep 2026 12:58:36 +0800
Message-ID: <20260902050411.3473916-15-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d25777d-0f58-40e2-85c7-08df08aff372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y2/0tZUtAOJHDto55gS62p26rYIDdiDw3o1AEepV4N9QvS5LCimZGiekoEbH+NXbBCRPvNxHywmXUSbiXfIg/cyk7eLI5LAqjawR8PARwGt/5yO55bskkMV4S90XJ9z51fsotSX2tiKBwPQMtiZDNXzp/JNfUFsexofd9MJctjkOznlqxI7KXhQtwMjwN2JcQFX1TvKZFgWTQUJ7Zyk8VYUggyzmmchoFp9ceFEdB76cuLoU4HA+YCGPCKnEWHgUR4pUxBzt8vgQB5SvaAY34/PkpTMSMbaw0fDZhT8Gj8ByN6kykUZ2rrzHLAxjaDi0CZ1b00fh8n8BYe73ghabUa7mwPAvW6hIm8SzbX08DoIYfxmcMvtP3J5V6weoAkBaASmITyI17vWxEUyndgZzCLfMspwqFTWPqGHktBc6j5Dy4lpQ/Cbf6G6jg//6JfDhNHCI9de5sGKa/qRcg2BaYtTUgX3Q4Ul6KNb211PvoIfltsMWxmZzLgiyNsJB2oSJx9ekGKgiSXutkVmrHkkwhkwJRxT3homuAuCKjpHrqyIxRW7BgUO0hIIlXalH3XR51QTOr3HqBW+qDb8P9xxkbwKfFXtRO2zTd5pPWN1HY+4VElT63E0VYACQJHt+DPoNMUzixa/lMqB3ATyg8UzoP+J6hO/r2AI19GVaB78qIpQLAn7C4EzUBZFVnDLwrtCGfmLgto2iGTb7nEzzWwDBjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E1gJCSaf1lJBv/vKC+sJXlIhjsP3SuWUeN3y3EAAeFg0a+GP9lHfdZc8vlnhMKewdTnu5ZZR8Y1y13hsP/X6/y+xUq2HQBbASljvTngl2+gxBKeSTfaKloYqYe8xzlQU78kkNF6fgq+blbNhh7bhMdmXvQfD6drEdxJbc5J1pGwESJgWNUUfKr8UsYzZYVQkCCTtbb9MS3Bzbvrd7nL1n05/+j8KkHW+C9r61Hq/5b7E7HAYb610DInJcBKRE2SKM4h6J7LhOXKVl7gv65xb0/IR9+xlVQ/7poSLKeh21HiSfHIRNBLd9oVT6s2BGsrLvCDLWIIvH2Q0ud2hOSQSIZgALZje7O3MwlX0WOwilXSQQIREd/rnUMbJkBd4fgZDkoGqc63r4wlRHBDYuUcZLPaZFkRNBtIzSrKdggfgxBQX1itUAyYvrvm8eOLYto5J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:06:30.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d25777d-0f58-40e2-85c7-08df08aff372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
streamclk gating sequence update: disable streamclk gating when using
streamclk

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |  1 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c | 14 +++++++++++++-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 71903a6c63a0..4fbd40b518cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1661,6 +1661,7 @@ void dccg35_set_hdmistreamclk(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	dccg35_set_hdmistreamclk_rcg(dccg, 0, false);
 	/* set the dtbclk_p source */
 	dccg35_set_dtbclk_p_src(dccg, src, otg_inst);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index 3b03b152da22..c9ea3b166876 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -308,13 +308,25 @@ static void dccg42_init(struct dccg *dccg)
 		}
 	}
 }
+void dccg42_set_hdmistreamclk_root_clock_gating(struct dccg *dccg, bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.hdmistream && !enable) {
+		DC_LOG_DEBUG("%s: HDMISTREAMCLK0_ROOT_GATE DISABLE = 0 bypassed", __func__);
+		return;
+	}
+	REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, enable ? 1 : 0);
+	REG_UPDATE(DCCG_GATE_DISABLE_CNTL3, HDMISTREAMCLK0_GATE_DISABLE, enable ? 1 : 0);
 
+	DC_LOG_DEBUG("%s: HDMISTREAMCLK0_ROOT_GATE_DISABLE = %d\n", __func__, enable ? 1 : 0);
+}
 
 static const struct dccg_funcs dccg42_funcs = {
 	.enable_hdmicharclk = dccg401_enable_hdmicharclk,
 	.disable_hdmicharclk = dccg42_disable_hdmicharclk,
 	.set_hdmistreamclk = dccg35_set_hdmistreamclk,
-	.set_hdmistreamclk_root_clock_gating = dccg35_set_hdmistreamclk_root_clock_gating,
+	.set_hdmistreamclk_root_clock_gating = dccg42_set_hdmistreamclk_root_clock_gating,
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg401_get_dccg_ref_freq,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
index ebd3cec1a977..198dc7a6c71e 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
@@ -262,7 +262,7 @@ void dccg42_set_pixel_rate_div(
 		enum pixel_rate_div unused);
 
 void dccg42_trigger_dio_fifo_resync(struct dccg *dccg);
-
+void dccg42_set_hdmistreamclk_root_clock_gating(struct dccg *dccg, bool enable);
 struct dccg *dccg42_create(
 	struct dc_context *ctx,
 	const struct dccg_registers *regs,
-- 
2.43.0

