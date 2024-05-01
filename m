Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B96C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE461130D1;
	Wed,  1 May 2024 07:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JVTavCzx";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A5C1130D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxcuer0bZuv0BK3Ha6Zi4X+cheCJXO4LilVMa7Op+jEl/us3I3H2zS9WykQbjXFOn8icUFPvpck28bYYs3/TsKA9gqykjCDeSH9kge/ID3QJO2vraMib5Xe6jtzS//jSIxmWcGoL4xYhi7T19KOX+zqnqI/ldKKYPo8luf0l+D5oS3Jv/y2e+BgWO8pQMJH3toU71I5fAtR9qUnZhdxLfD0NixulsRFrcJhXm78655tdqh8+hOaQOLG+lHPzmmBFmM2ZtN/12E7sn8sxmmb3I2Wd/Ic3JgHzacStY90A9eRBhKW8nZY9kY+3pzHxeH+Kg68Kxi7STQOK0i1dcsrN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmuosNOgD3tYJAlZfcqShCQU2Yu1FxyYgu4LkjutHS0=;
 b=MLOHnRo4BCM/Unc6qCmn0RMA9yrSsy9+XPTrtfek0aZ/wvq/J2tq3Y8Zo76OrfVx8ZRHRm2iVdky+1UqtJGPrZLmKCPKzPhMclI5tDx/bIg5PVe9cyvcEFork5x45YKPaaAKOvB6FRCP65JSmweIXY6WbYrms07S59M65045Y4qX2pvO7eLdgv80iVd5EcMSvBEjPq/6QOup6Kbvuq0PxO3LapslVOvFYNzLiOpR92cDHh2Mh51DjkkZhCeDudLt53DAkobsmQkTZ4sUT6KxjgdbwGFkvW3sdOHrR/Wwad+LtteKjbiRxgHkUx241rPcX9+NBic6XsdS16TcIifC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmuosNOgD3tYJAlZfcqShCQU2Yu1FxyYgu4LkjutHS0=;
 b=JVTavCzx8uSS8RA/HtlPnkdYXZgmw3F7j8hAVZ4Y/X4LrrnnA8gCetvX4REbu+MDoga0RzoRkDFBap4D9hFhP8DTnaz0kjoF8EGdSXhdEO1qmnET2WBj2CNxIKCskaJAUGKYXxN0zRtGebp1i7zCbfMIi6Y65r2hBHARZy0M6Ko=
Received: from SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) by BL3PR12MB6593.namprd12.prod.outlook.com
 (2603:10b6:208:38c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:20:17 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::5a) by SN6PR2101CA0017.outlook.office365.com
 (2603:10b6:805:106::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24 via Frontend
 Transport; Wed, 1 May 2024 07:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:16 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:13 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 33/45] drm/amd/display: reset DSC clock in post unlock update
Date: Wed, 1 May 2024 15:16:39 +0800
Message-ID: <20240501071651.3541919-34-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6117eb1c-4eaf-4ed3-c4f0-08dc69af2702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UBeIhuElSlWKGXxKbiV1geViZ7RpMP88x/OfQtbaCgJmvlJLDUuAHdSYcKrE?=
 =?us-ascii?Q?CoBG1b9h0dGyvKd0fnDHyPlf//Wmgl9L8V1+DM/d0vxoloOaFTMeaiUYuCVU?=
 =?us-ascii?Q?VPnBy45EIm7I5tJu+lX9vqLlPlvox17OgwjYkF8UVxk/wZh1hRzftGaIgpWE?=
 =?us-ascii?Q?ATR9qwTVzNcOboD78uwtmt78VRJUAOY84qFxTj/3a1p/Lbx2wN7okCPVMbBg?=
 =?us-ascii?Q?/CQTB/wkmaI+Gg5m3Jg+z1dR+y0DkygjrXOYGyKbjdosFfgMeGxz9orwuMid?=
 =?us-ascii?Q?E0fVC0wc+lVLYtLjFFqDOHY5SZO8BiaOGPxKrOqT6AwkUria0hQGoZDEsHk3?=
 =?us-ascii?Q?7BlaaW4pGkj84fUoDI7aNZatV1EGALQJWDBLD6IwufEFmL4TzEahySeGbH6T?=
 =?us-ascii?Q?Xl/0ZLG0z9N3b9JljbENPmclpXzzI+pR5W9vEz0Ku61Llz1bAiZeDckHrfss?=
 =?us-ascii?Q?iwDR+p3DAabsh0V8eqBOD7NLSs46uMXBY4yacBj72+U7H8NDceZlh2tmez9o?=
 =?us-ascii?Q?t7wB8izAu81JpuYQRo9prKuWNkapGNlIxrn/yjVomtVIJ+KmoA95LvEr4kB5?=
 =?us-ascii?Q?idqJ05h1CPoKJm/w3vcLf20CoraRNpCM9wQWfQrf6WnwqBW6T9qQjmXKd8SY?=
 =?us-ascii?Q?qhcFXl1BXZ5dGTWLkQO+3WUj4fA35iiMUGyfnXcs+suHInHpIopkd5Z2Hzyh?=
 =?us-ascii?Q?IidHZ4UM4KTdoCnXzLtrjGXnmJRbbCXtSik+DK2+oZaJqomNCiOAQHx18yqI?=
 =?us-ascii?Q?DTOe1Fwed5LlU4hzX+W1QZieA5lyD7Rcy15Wz12N+c8FD80+r6f0G4lbtHGT?=
 =?us-ascii?Q?5Z/PzdX9JOic256jU6gDVBK4WQOAwQhPEK7hBOzEre2qX7LLvvN3JT21Nf2y?=
 =?us-ascii?Q?E/fTy3R+VVPukrZBfaLjGgLYJIaF4WaO9V8hRd3f+EOmfpzNxtk0CfQo+5Xq?=
 =?us-ascii?Q?pIhAelwDL9ezDvcHEszes8bTSLOqrRhEufmGMsHdVzfFDCeTWdaNEF9SKuDC?=
 =?us-ascii?Q?7w9zGvH88AAA7qsbwQB+efIkNaK/8JJZN90IL9JlviXz5ka1qVJGHFAKJVcM?=
 =?us-ascii?Q?zSihUXM/0l4lEFZTYQsbO64QzdT2HAedb/2qUoP1wWQH2D97iikXSaDrumSH?=
 =?us-ascii?Q?Df8rcGoEE6Nz3sH6C/nidkXbyQKrZxOR0yZ1XGvBiiBPiBQ3HLjIqe8Vuu71?=
 =?us-ascii?Q?aPZghgknh03A/ehqIs7w2eyLROrMP2/lvR7V3N9Udph8TOBfP8MQ1xaBANm2?=
 =?us-ascii?Q?qgjuPCko7fnsWYDHMqPYwCaV0KERLQJl1wNc5Q5bB1UNWx7MgnP+Sccs6Mi0?=
 =?us-ascii?Q?HZEQEQN0/ZpWf+ebItmO31GBWKoWOJlYJkVnhqfWyx2D2hLskRV76v6KGry6?=
 =?us-ascii?Q?3Kp+XBmbXnEy3gaQmHKelPFNSfdo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:17.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6117eb1c-4eaf-4ed3-c4f0-08dc69af2702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

[why]
Switching between DSC clock or disable DSC block are not double buffered update.
Corruption is observed if these updates happen before DSC double buffered
disconnection.

[how]
Move DSC disable and refclk reset to post unlock update. Wait for DSC double buffered
disconnection and all mpccs are disconnected before reset DSC clock.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn401/dcn401_dccg.c   | 31 +++------
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  | 18 +++--
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |  3 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    | 17 +++--
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |  1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 43 ++++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 33 ++++-----
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 69 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 10 ++-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  1 +
 14 files changed, 180 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.c
index c06bf4a38dbc..72cbff8632dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.c
@@ -726,34 +726,35 @@ void dccg401_init(struct dccg *dccg)
 	}
 }
 
-static void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst)
+static void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst, bool enable)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t phase = enable ? 1 : 0;
 
 	switch (inst) {
 	case 0:
+		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK0_EN, 1, DSCCLK0_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
-				DSCCLK0_DTO_PHASE, 1,
+				DSCCLK0_DTO_PHASE, phase,
 				DSCCLK0_DTO_MODULO, 1);
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK0_EN, 1, DSCCLK0_DTO_DB_EN, 1);
 		break;
 	case 1:
+		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK1_EN, 1, DSCCLK1_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
-				DSCCLK1_DTO_PHASE, 1,
+				DSCCLK1_DTO_PHASE, phase,
 				DSCCLK1_DTO_MODULO, 1);
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK1_EN, 1, DSCCLK1_DTO_DB_EN, 1);
 		break;
 	case 2:
+		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK2_EN, 1, DSCCLK2_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
-				DSCCLK2_DTO_PHASE, 1,
+				DSCCLK2_DTO_PHASE, phase,
 				DSCCLK2_DTO_MODULO, 1);
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK2_EN, 1, DSCCLK2_DTO_DB_EN, 1);
 		break;
 	case 3:
+		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK3_EN, 1, DSCCLK3_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK3_DTO_PARAM,
-				DSCCLK3_DTO_PHASE, 1,
+				DSCCLK3_DTO_PHASE, phase,
 				DSCCLK3_DTO_MODULO, 1);
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK3_EN, 1, DSCCLK3_DTO_DB_EN, 1);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -769,27 +770,15 @@ static void dccg401_set_ref_dscclk(struct dccg *dccg,
 	switch (dsc_inst) {
 	case 0:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_EN, 0);
-		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
-				DSCCLK0_DTO_PHASE, 0,
-				DSCCLK0_DTO_MODULO, 1);
 		break;
 	case 1:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, 0);
-		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
-				DSCCLK1_DTO_PHASE, 0,
-				DSCCLK1_DTO_MODULO, 1);
 		break;
 	case 2:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, 0);
-		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
-				DSCCLK2_DTO_PHASE, 0,
-				DSCCLK2_DTO_MODULO, 1);
 		break;
 	case 3:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, 0);
-		REG_UPDATE_2(DSCCLK3_DTO_PARAM,
-				DSCCLK3_DTO_PHASE, 0,
-				DSCCLK3_DTO_MODULO, 1);
 		break;
 	default:
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index c9ae2d8f0096..d6b2334d5364 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -40,6 +40,7 @@ static void dsc2_set_config(struct display_stream_compressor *dsc, const struct
 static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
 static void dsc2_disable(struct display_stream_compressor *dsc);
 static void dsc2_disconnect(struct display_stream_compressor *dsc);
+static void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
 
 static const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
@@ -50,6 +51,7 @@ static const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_enable = dsc2_enable,
 	.dsc_disable = dsc2_disable,
 	.dsc_disconnect = dsc2_disconnect,
+	.dsc_wait_disconnect_pending_clear = dsc2_wait_disconnect_pending_clear,
 };
 
 /* Macro definitios for REG_SET macros*/
@@ -260,16 +262,12 @@ static void dsc2_disable(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 	int dsc_clock_en;
-	int dsc_fw_config;
-	int enabled_opp_pipe;
 
 	DC_LOG_DSC("disable DSC %d", dsc->inst);
 
 	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &dsc_clock_en);
-	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &dsc_fw_config, DSCRM_DSC_OPP_PIPE_SOURCE, &enabled_opp_pipe);
-	if (!dsc_clock_en || !dsc_fw_config) {
-		DC_LOG_DSC("ERROR: DSC %d at opp pipe %d already disabled!", dsc->inst, enabled_opp_pipe);
-		ASSERT(0);
+	if (!dsc_clock_en) {
+		DC_LOG_DSC("DSC %d already disabled!", dsc->inst);
 	}
 
 	REG_UPDATE(DSCRM_DSC_FORWARD_CONFIG,
@@ -279,6 +277,13 @@ static void dsc2_disable(struct display_stream_compressor *dsc)
 		DSC_CLOCK_EN, 0);
 }
 
+static void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
+{
+	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
+
+	REG_WAIT(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING, 0, 2, 50000);
+}
+
 static void dsc2_disconnect(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
@@ -777,4 +782,3 @@ static void dsc_write_to_registers(struct display_stream_compressor *dsc, const
 		RANGE_BPG_OFFSET14, reg_vals->pps.rc_range_params[14].range_bpg_offset);
 
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
index 59a3f56b8543..a136b26c914c 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
@@ -453,7 +453,8 @@
 	type DSCCIF_UPDATE_TAKEN_STATUS; \
 	type DSCCIF_UPDATE_TAKEN_ACK; \
 	type DSCRM_DSC_FORWARD_EN; \
-	type DSCRM_DSC_OPP_PIPE_SOURCE
+	type DSCRM_DSC_OPP_PIPE_SOURCE; \
+	type DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING
 
 struct dcn20_dsc_registers {
 	uint32_t DSC_TOP_CONTROL;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index b90710726840..845686d57919 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -21,6 +21,7 @@ static void dsc401_set_config(struct display_stream_compressor *dsc, const struc
 static void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe);
 static void dsc401_disable(struct display_stream_compressor *dsc);
 static void dsc401_disconnect(struct display_stream_compressor *dsc);
+static void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
 
 const struct dsc_funcs dcn401_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
@@ -31,6 +32,7 @@ const struct dsc_funcs dcn401_dsc_funcs = {
 	.dsc_enable = dsc401_enable,
 	.dsc_disable = dsc401_disable,
 	.dsc_disconnect = dsc401_disconnect,
+	.dsc_wait_disconnect_pending_clear = dsc401_wait_disconnect_pending_clear,
 };
 
 /* Macro definitios for REG_SET macros*/
@@ -231,16 +233,12 @@ static void dsc401_disable(struct display_stream_compressor *dsc)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
 	int dsc_clock_en;
-	int dsc_fw_config;
-	int enabled_opp_pipe;
 
 	DC_LOG_DSC("disable DSC %d", dsc->inst);
 
 	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &dsc_clock_en);
-	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &dsc_fw_config, DSCRM_DSC_OPP_PIPE_SOURCE, &enabled_opp_pipe);
-	if (!dsc_clock_en || !dsc_fw_config) {
-		DC_LOG_DSC("ERROR: DSC %d at opp pipe %d already disabled!", dsc->inst, enabled_opp_pipe);
-		ASSERT(0);
+	if (!dsc_clock_en) {
+		DC_LOG_DSC("DSC %d already disabled!", dsc->inst);
 	}
 
 	REG_UPDATE(DSCRM_DSC_FORWARD_CONFIG,
@@ -250,6 +248,13 @@ static void dsc401_disable(struct display_stream_compressor *dsc)
 		DSC_CLOCK_EN, 0);
 }
 
+static void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
+{
+	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
+
+	REG_WAIT(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING, 0, 2, 50000);
+}
+
 static void dsc401_disconnect(struct display_stream_compressor *dsc)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index 4b27f29d0d80..1ebce5426a58 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -107,6 +107,7 @@ struct dsc_funcs {
 	void (*dsc_enable)(struct display_stream_compressor *dsc, int opp_pipe);
 	void (*dsc_disable)(struct display_stream_compressor *dsc);
 	void (*dsc_disconnect)(struct display_stream_compressor *dsc);
+	void (*dsc_wait_disconnect_pending_clear)(struct display_stream_compressor *dsc);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 5812b0938cd3..5623a48cf3fd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2158,6 +2158,43 @@ void dcn20_program_front_end_for_ctx(
 	}
 }
 
+/* post_unlock_reset_opp - the function wait for corresponding double
+ * buffered pending status clear and reset opp head pipe's none double buffered
+ * registers to their initial state.
+ */
+static void post_unlock_reset_opp(struct dc *dc,
+		struct pipe_ctx *opp_head)
+{
+	struct display_stream_compressor *dsc = opp_head->stream_res.dsc;
+	struct dccg *dccg = dc->res_pool->dccg;
+
+	/*
+	 * wait for all DPP pipes in current mpc blending tree completes double
+	 * buffered disconnection before resetting OPP
+	 */
+	dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, opp_head);
+
+	if (dsc) {
+		bool is_dsc_ungated = false;
+
+		if (dc->hwseq->funcs.dsc_pg_status)
+			is_dsc_ungated = dc->hwseq->funcs.dsc_pg_status(dc->hwseq, dsc->inst);
+
+		if (is_dsc_ungated) {
+			/*
+			 * seamless update specific where we will postpone non
+			 * double buffered DSCCLK disable logic in post unlock
+			 * sequence after DSC is disconnected from OPP but not
+			 * yet power gated.
+			 */
+			dsc->funcs->dsc_wait_disconnect_pending_clear(dsc);
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
+			dsc->funcs->dsc_disable(dsc);
+		}
+	}
+}
+
 void dcn20_post_unlock_program_front_end(
 		struct dc *dc,
 		struct dc_state *context)
@@ -2167,6 +2204,12 @@ void dcn20_post_unlock_program_front_end(
 	unsigned int polling_interval_us = 1;
 	struct dce_hwseq *hwseq = dc->hwseq;
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++)
+		if (resource_is_pipe_type(&dc->current_state->res_ctx.pipe_ctx[i], OPP_HEAD) &&
+				!resource_is_pipe_type(&context->res_ctx.pipe_ctx[i], OPP_HEAD))
+			post_unlock_reset_opp(dc,
+					&dc->current_state->res_ctx.pipe_ctx[i]);
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
 			dc->hwss.disable_plane(dc, dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index ba4b2786f440..df0fceb11ae1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -60,8 +60,7 @@
 #define REG(reg)\
 	hws->regs->reg
 #define DC_LOGGER \
-	stream->ctx->logger
-
+	dc->ctx->logger
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -75,17 +74,19 @@ void dcn32_dsc_pg_control(
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl = 0;
+	struct dc *dc = hws->ctx->dc;
 
-	if (hws->ctx->dc->debug.disable_dsc_power_gate)
+	if (dc->debug.disable_dsc_power_gate)
 		return;
 
-	if (!hws->ctx->dc->debug.enable_double_buffered_dsc_pg_support)
+	if (!dc->debug.enable_double_buffered_dsc_pg_support)
 		return;
 
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
 
+	DC_LOG_DSC("%s DSC power gate for inst %d", power_gate ? "enable" : "disable", dsc_inst);
 	switch (dsc_inst) {
 	case 0: /* DSC0 */
 		REG_UPDATE(DOMAIN16_PG_CONFIG,
@@ -963,7 +964,7 @@ void dcn32_init_hw(struct dc *dc)
 	}
 }
 
-static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
+void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
@@ -1005,7 +1006,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, true);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
@@ -1013,7 +1014,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, true);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
@@ -1032,15 +1033,15 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 				pipe_ctx->stream_res.tg,
 				OPTC_DSC_DISABLED, 0, 0);
 
-		/* disable DSC block */
-		if (dccg->funcs->set_ref_dscclk)
-			dccg->funcs->set_ref_dscclk(dccg, pipe_ctx->stream_res.dsc->inst);
+		/* only disconnect DSC block, DSC is disabled when OPP head pipe is reset */
+		if (dccg->funcs->set_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, pipe_ctx->stream_res.dsc->inst, false);
 		dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			ASSERT(odm_pipe->stream_res.dsc);
-			if (dccg->funcs->set_ref_dscclk)
-				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
-			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
+			if (dccg->funcs->set_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_pipe->stream_res.dsc->inst, false);
+			odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
 		}
 	}
 }
@@ -1098,7 +1099,7 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	if (pipe_ctx->stream_res.dsc) {
 		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
 
-		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
+		dcn32_update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
 
 		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
 		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
@@ -1106,8 +1107,8 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 			struct display_stream_compressor *dsc = current_pipe_ctx->next_odm_pipe->stream_res.dsc;
 			struct dccg *dccg = dc->res_pool->dccg;
 
-			if (dccg->funcs->set_ref_dscclk)
-				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
+			if (dccg->funcs->set_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, dsc->inst, false);
 			/* disconnect DSC block from stream */
 			dsc->funcs->dsc_disconnect(dsc);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index c510f3a652ad..4621163b4b98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -71,6 +71,8 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context);
 
 void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
 
+void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
+
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
 void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ba9c27e05787..11c20b17a7d0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1541,6 +1541,75 @@ void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool en
 	dc_dmub_srv_fams2_update_config(dc, context, enable && fams2_required);
 }
 
+static void update_dsc_for_odm_change(struct dc *dc, struct dc_state *context,
+		struct pipe_ctx *otg_master)
+{
+	int i;
+	struct pipe_ctx *old_pipe;
+	struct pipe_ctx *new_pipe;
+	struct pipe_ctx *old_opp_heads[MAX_PIPES];
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct pipe_ctx *old_otg_master =
+			&dc->current_state->res_ctx.pipe_ctx[otg_master->pipe_idx];
+	int old_opp_head_count = resource_get_opp_heads_for_otg_master(
+			old_otg_master, &dc->current_state->res_ctx,
+			old_opp_heads);
+
+	if (otg_master->stream_res.dsc)
+		dcn32_update_dsc_on_stream(otg_master,
+				otg_master->stream->timing.flags.DSC);
+	if (old_otg_master->stream_res.dsc) {
+		for (i = 0; i < old_opp_head_count; i++) {
+			old_pipe = old_opp_heads[i];
+			new_pipe = &context->res_ctx.pipe_ctx[old_pipe->pipe_idx];
+			if (old_pipe->stream_res.dsc && !new_pipe->stream_res.dsc) {
+				dccg->funcs->set_dto_dscclk(dccg,
+						old_pipe->stream_res.dsc->inst, false);
+				old_pipe->stream_res.dsc->funcs->dsc_disconnect(
+						old_pipe->stream_res.dsc);
+			}
+		}
+	}
+}
+
+void dcn401_update_odm(struct dc *dc, struct dc_state *context,
+		struct pipe_ctx *otg_master)
+{
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	int opp_inst[MAX_PIPES] = {0};
+	int opp_head_count;
+	int i;
+
+	opp_head_count = resource_get_opp_heads_for_otg_master(
+			otg_master, &context->res_ctx, opp_heads);
+
+	for (i = 0; i < opp_head_count; i++)
+		opp_inst[i] = opp_heads[i]->stream_res.opp->inst;
+	if (opp_head_count > 1)
+		otg_master->stream_res.tg->funcs->set_odm_combine(
+				otg_master->stream_res.tg,
+				opp_inst, opp_head_count,
+				&otg_master->stream->timing);
+	else
+		otg_master->stream_res.tg->funcs->set_odm_bypass(
+				otg_master->stream_res.tg,
+				&otg_master->stream->timing);
+
+	for (i = 0; i < opp_head_count; i++)
+		opp_heads[i]->stream_res.opp->funcs->opp_pipe_clock_control(
+				opp_heads[i]->stream_res.opp,
+				true);
+
+	update_dsc_for_odm_change(dc, context, otg_master);
+
+	if (!resource_is_pipe_type(otg_master, DPP_PIPE))
+		/*
+		 * blank pattern is generated by OPP, reprogram blank pattern
+		 * due to OPP count change
+		 */
+		dc->hwseq->funcs.blank_pixel_data(dc, otg_master, true);
+}
+
 void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 16084ae1d31d..dd5bae93dc05 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -74,4 +74,6 @@ void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool en
 void dcn401_fams2_global_control_lock_fast(union block_sequence_params *params);
 void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *link_settings);
 
+void dcn401_update_odm(struct dc *dc, struct dc_state *context,
+		struct pipe_ctx *otg_master);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 56c4b28c1f2e..b9fcde08fdc8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -124,7 +124,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.enable_power_gating_plane = dcn32_enable_power_gating_plane,
 	.hubp_pg_control = dcn32_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
-	.update_odm = dcn32_update_odm,
+	.update_odm = dcn401_update_odm,
 	.dsc_pg_control = dcn32_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index d4c7885fc916..867bc67aabfa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -208,7 +208,8 @@ struct dccg_funcs {
 			uint32_t otg_inst);
 	void (*set_dto_dscclk)(
 			struct dccg *dccg,
-			uint32_t dsc_inst);
+			uint32_t dsc_inst,
+			bool enable);
 	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 8402ca0695cc..955c720fb565 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -820,14 +820,14 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, true);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, true);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
@@ -879,10 +879,16 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* disable DSC block */
+		if (dccg->funcs->set_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, pipe_ctx->stream_res.dsc->inst, false);
+		pipe_ctx->stream_res.dsc->funcs->dsc_disconnect(pipe_ctx->stream_res.dsc);
 		if (dccg->funcs->set_ref_dscclk)
 			dccg->funcs->set_ref_dscclk(dccg, pipe_ctx->stream_res.dsc->inst);
 		pipe_ctx->stream_res.dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			if (dccg->funcs->set_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_pipe->stream_res.dsc->inst, false);
+			odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
 			if (dccg->funcs->set_ref_dscclk)
 				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
 			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index fd030e5b9de6..099658bcd77f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -456,6 +456,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.set_dwb_source = NULL,
 		.set_odm_bypass = optc401_set_odm_bypass,
 		.set_odm_combine = optc401_set_odm_combine,
+		.wait_odm_doublebuffer_pending_clear = optc32_wait_odm_doublebuffer_pending_clear,
 		.set_h_timing_div_manual_mode = optc401_set_h_timing_div_manual_mode,
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc401_set_out_mux,
-- 
2.34.1

