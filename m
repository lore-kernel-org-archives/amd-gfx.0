Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F425CDB46D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEB310F5EE;
	Fri, 19 Jun 2026 13:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="felrA2Gy";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3105610F5D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT/EXQh6nZfx2yc76yy7iCVZfY/SZcVsvjS6+TGD228zXyWZPHh9aoL0T7KSzkFB7PYfKFudlvxvseMXcS6q+FpON21yqaACpamBGSSwVoGe9fufhBDQZ3oeBA01ivfNMWmWlwAJoOkImO3BGEkLDDTFAy+K/4si6mbcOld+Ol8IBikcW2XTnFv2zes46OIYMc3i/g8etGeyHDRpvkqhlqNZCUAucBOEcBVOoyd/z6mecJdN6w+X9Ei90iqykd34soTes/xgszyKRSB6huGp+cqVjtuH4gQfY7mBxtQtYkeD3iX84AtCtGJ49FHrGglP7vhayr+wIrNS1ijyboTrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PGVHeRypSIeIAsIPJ0+LhEpvmZnni16hMEqY5J927Y=;
 b=xAzZ22wkED35IWuQg6oEzv5m/hnzTGxDGIPzrsiyV2Pb0tu4/DJY2M3vK832W+Y1MT1YENWriiGvKjfn/JgEWLuVghMWDKIga+KqxAD6BKFlkIrFo+2StFctp+DdqeQZ5VIBeJKfJtXK85bJlIKoTYKadMw0AW0qDXL5lQhu9+5s2N9mmzsphJwdiA+JfCYwpkmyF6X06pb+vBDeYR0QKEQp1mOZBBjI8+olwIif4mNUh/VjeqyzPfY0kHHswXOGkp/SGzdGYFDWpRuR0C2uZvpgM5uXov3EYG+aUhqAhm0q2s0jqvzJ/s8o4oSsPFVbW9boZq8zH7KPhiI8/eivVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PGVHeRypSIeIAsIPJ0+LhEpvmZnni16hMEqY5J927Y=;
 b=felrA2GyQ6TT1WfWO9IGTNZhhDceygFrcoBbHDBR4rF4DNLZ1BJWitiB+J3ckU2207OgUGgyxJ/jnZ8u9d/+4NvnNZ255W1A6tuZAV6WmZzpvnnDiX9JZSMN+fABl1yOYFdOX1MyczespyJOvHoz4f24VsQNYQOkj9zSgi6hU/Q=
Received: from BN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:e6::25)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:32:24 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::95) by BN0PR03CA0020.outlook.office365.com
 (2603:10b6:408:e6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Fri,
 19 Jun 2026 13:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:23 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:23 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, "Relja (Reggie) Vojvodic" <relja.vojvodic@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Reintroduce "Force validation link
 training on all ASICs"
Date: Fri, 19 Jun 2026 09:21:21 -0400
Message-ID: <20260619133154.116746-7-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 0403ce08-0344-4c0c-f29e-08dece073274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: clWwcz/Vp0O7lusOO4+Q3C0D07DoXuw5m5u06swq0OcDNTNxTjx8Olxx52IIWzwjIfJHPshFXtGDnvmSZ3QGZHGc4z5Nvx3LmrjrpRMlAY7Y9bBoRWVn9Dz+EkVxkFNREmNYe5HsJ53ILhWQn3Mc7qB3MAj0k9xzUNE+MFalpMpx8hp66ll7O5SkyOuItbo+CvP6IbQXGoaS3y+EmnoN4t12I8ztkVVdvgMc3nOW2cfliEM7GfXZER2oPMy4f/IvbyJgjUW7Gf8c2OZbjiWbLuBSdk6Qj4pocT7VI1YtoEeJRnZbsIzXTmDWgtoBBE844LwfI+hBuH4dQeAwv51J2zJA23hK8z4GUndsarApfEelxBv+ACUog0CdBt14S2TrG25ncwsMzMExevt1qbM8kQnDminfUMbUVi85oRrtnf/HKVrFGkxlWujG7dUHXyjv3VBvoLqf2zO5SeamW6j8qcInk5IfweZjva8e4kqzl58Xlb2zDAoyDK47Nfa2P46cMfBiL9QN6buN7JFWfwhTJjVjSZTvrArFHQEn+DHB4anbgVLpdL1fm+rfQD76Lb0gU7IM//+sLk7eX063hfyA7F1nP6H2tYEI+3T1jWLRaeSP0wl2Qwia0rhhl40qHaV8mgXEhPfBBpOZPFkZfSfqQi2IM85NuddsvxglyuCO3enne4Bj6D5b8is6Rwv5KO+S/DLjmlm+bnNV+v5+nMY7Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z+hwjIEfWQcKg3B1O2m1YIB5SmGlO64IhEeRrvTXy8pzrNtGYbvqw/u3fqGD60YVxAaUAWF7O4bXG08kKFUkXQbN7NmItC7AuZ8Du1uZYYmYXn3rqte+U4d+2gglSBPhP+x8D+ilmO67dUHxhCef5KE2Rr7Sm3palhZku4SAxJsjvzlupCP2XJ3/OasYDfi6bipE5YnfoijZrhFaqVcOp/Bd/vbg+2150ANzgzTrRKn/IgiASKg7J82Me+z94606PMdSC60TLCQk4HjaEJuloJ2MCaJR0mCGkvUUHbCRUqPsKejKcWnk6seaxCroaiVmsjwo51jlAW/IZP5EEvkCn7W8DhjhhC0MG30v1f/oaKjzKV+aPDbJfVTTMwUEu3rYqU+Jw/PcV9WgiGFuWfv/VHJ6n4E6ZlAHHuCLIHnxJ8YgZFRNKlqEVDT+pmNmrKgJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:23.9381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0403ce08-0344-4c0c-f29e-08dece073274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
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

[Why & How]
'skip_frl_pretraining' was introduced and enabled along w/ HDMI 2.1
initial upstream, but is causing HDMI validation link training to be s
kipped on short hotplugs and compliance issues.

Remove this behaviour to force link training on all hotplugs for all
ASICs.

Reviewed-by: Relja (Reggie) Vojvodic <relja.vojvodic@amd.com>
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                             | 1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h                       | 1 +
 drivers/gpu/drm/amd/display/dc/link/link_detection.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c  | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c    | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c    | 1 -
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c  | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c    | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c    | 1 -
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 1 -
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 1 -
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c  | 1 -
 14 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2de0f9cf8264..b21fdea5fca3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -591,7 +591,6 @@ struct dc_config {
 	bool enable_mipi_converter_optimization;
 	bool enable_frl;
 	bool force_hdmi21_frl_enc_enable;
-	bool skip_frl_pretraining;
 	bool use_default_clock_table;
 	bool force_bios_enable_lttpr;
 	uint8_t force_bios_fixed_vs;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index db6a89d938b6..90dd1ae7e953 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -183,6 +183,7 @@ struct dc_panel_patch {
 	unsigned int force_frl;
 	unsigned int vsdb_rcc_wa;
 	unsigned int delay_hdmi_link_training;
+	unsigned int skip_frl_pre_training;
 	unsigned int skip_avmute;
 	unsigned int skip_audio_sab_check;
 	unsigned int mst_start_top_delay;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index a3212fd151d1..24b191d39777 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -933,7 +933,7 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 		destrictive = true;
 		if (is_hdmi_frl_in_use(link)) {
 			destrictive = false;
-		} else if (link->dc->config.skip_frl_pretraining) {
+		} else if (link->local_sink->edid_caps.panel_patch.skip_frl_pre_training) {
 			for (i = 0; i < MAX_PIPES; i++) {
 				if (pipes[i].stream != NULL &&
 					pipes[i].stream->link == link) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 70eacb0edfd9..ec74538472ee 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2483,7 +2483,6 @@ static bool dcn30_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index caeb001dd7de..106f04efed1f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -1378,7 +1378,6 @@ static bool dcn302_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 58c314237ce6..f41926eb0761 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -1322,7 +1322,6 @@ static bool dcn303_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 15730fe1b9db..97c2cd7045b5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2081,7 +2081,6 @@ static bool dcn31_resource_construct(
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 0f800f586e08..4e283e4c238c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -2057,7 +2057,6 @@ static bool dcn315_resource_construct(
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index efbc2a506046..0c8b37520ec3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1931,7 +1931,6 @@ static bool dcn316_resource_construct(
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index e03dc966e121..697463622a10 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2409,7 +2409,6 @@ static bool dcn32_resource_construct(
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 65f445f38cfb..6ebab0f185c9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1901,7 +1901,6 @@ static bool dcn321_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index baf00942b8f3..c94136bf2dcf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2031,7 +2031,6 @@ static bool dcn35_resource_construct(
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 75a0a3dc3052..42c8c01efb0b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -2004,7 +2004,6 @@ static bool dcn351_resource_construct(
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 8e84abdff57a..b7afba548fd4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -2001,7 +2001,6 @@ static bool dcn36_resource_construct(
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.hdmi_hpo = true;
-	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;

--
2.54.0

