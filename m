Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8B0CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C160910F701;
	Wed,  7 Oct 2026 17:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWzgv97W";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CFB510F6E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZOL0VTfVku4lH/BCCxB0LPpGQonJdQ3e8E8PUjDi36hyMozuHvcm7SBuMOoHTg+00zJVBn7bPR00dr2eNrZEqJzeXgRlYDrDoWr5nQFUd3FdO4WZBjFVkITzknvCPPSXAgvV1GwFupfseHCCYKOPGD+kvN4X+s/yoOdGgA2T5dcPM1KfgA/srNC0TylNM0jadxtt4p9Zlued9v8M96THNOsJ9S7MIAEXsoUjFBVDGynvJtWvowGnOH1DervgUljn62oQNl0iXxQ8jR/l87PpXwQTCxOUOdxZnFLGTDDS//ZWFIYYGPQNwPDBW8/yENZTwnV6AWw67Kktcunf557iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCAJeqlGghp6z1E1fHRyblBr7U+AdrA3/udufEerKcA=;
 b=MU1NqgNmEINdED7knqA6k7vV6hzBZ+/m8Tq6a2HkNRZfYd88trVux7KjCShjWoAj+aoNPG5SV23mOkAmNiHhGT7S45H1AEfqw9OXilXRRRe9a5AE1nGN37z0/ZwofYyB3S4g7KPRxwF/pRSh1i/O1LWb0nkxM52xL+K9UE+KplWz34VjHK7iD1n3zA1VgIf0jD5XsB308Lul5gwWooK05gu/cluVpbLwKIQFqeQsp/nqeRQFnAnQ0//0v1174+LABogP6XpgNLCnihT5ZGIGSzR43CfkJQRUnfsU/KyGTpkG6dyBtwm8f8ENpwb5aDeHUiqA9Vyjh+dPdQvopLka6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCAJeqlGghp6z1E1fHRyblBr7U+AdrA3/udufEerKcA=;
 b=NWzgv97WxqBjlyOuYEhb8AXBRS3JNcyVEZugfQS3btP0IqjAoUYoBN5aZWlmSnxnEGSmcC4tP7uhsymO3LDivTH8TiCJKxlHs6KtNOaFUaImUhy5kcU1Npy5q8KBXo/RyHkJjPFbNSi3AffTV5DddRMgqY7r0Uc/+ro4u4BrS1c=
Received: from SJ0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:a03:39e::26)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 17:04:36 +0000
Received: from MW1PEPF0001888E.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9b) by SJ0PR03CA0291.outlook.office365.com
 (2603:10b6:a03:39e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888E.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:30 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:30 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 12/19] drm/amd/display: Program HDR visual confirm based on
 per pipe info
Date: Wed, 7 Oct 2026 12:59:45 -0400
Message-ID: <20261007170412.1898315-13-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888E:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aedf887-40ad-4a11-959f-08df249510ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8jb/uYtTdGcx+wyBQFD/xmWsBm3AISFI09iNlinCowPLmeQCm9+YZm5fN7SMXHvBmRU0dENFZVyy5SawKVoXQGMitmoV0SbR2aSyFN77oifHd4L6f7QycRfO2XZHXCOzNy8JKVCJ4smvvH5/M4rb2Bq4JvosRSU/fmrX5FwheSqluClsWmf+JWV66Bf0TyQ4dWGZwglxwjHhSLKZkWIm9X3CHyMghNpZopiCP4CRQxO6vLdbQkmDibMa8IObEx67JsKWYtpEousVWYAog8MVH0E2V0ZUd0cPHlo1OW9Gb+6XH/E91rE4C5DFfQgtR7ukDdLOdx3ojjN346iVB5i21jovene1MIEs00YOCX+n1dkqvV13MjepZsDUfhsXY7aYE0na/Zl5cOXunksjCAw/c98pbXYqiv2KGiIWHQG1IiEHsuvj23ujax1UiN5GWOYk8+oGotoLV4esm7a02SwZvDtSOstozHxk2BwH/FQDP5eQ+OelXjcOmUp0qPc+Sg0nT2O820UkjkXECfHaeEbezF1leadRUhEERWabAMy3qRopQ/r1l7eAVA2QdM6/VGiN3aMB9RNxcw+4KeOvBtev1Yp8YVWRoLCOGkCPcY/mvjo9AidM5e3k22HutOS53tUXdQG6A0U2qil9kwfWe+ed6UPQ9fDul3esXqLmrf8YKb1rW0W6r5r84QD8A7xhCq1dFdHw/AuGnC6nr2q8TTi9Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tSETtMiuCy5lVAyS1KlWk6+JfLIILUE/4uGzWOpng0iFgsjH+tCluTHjTCE9dFRTqoZIzN7/SrC7A13gcfjKzGD/igu11yehBOm0qL83otbX4R0HIJEvl7kFqE1RrpJmte7crZ+W4pZgTeL4jVHnckVJmZEsCZiEA6jlt7O5bpanofzJk//fK5Le16hyb6GEWS1Mhki+0/rMYUB4Y4sGLo9aiIDqbwcBVOy4K25tJnVbNnHKLdRBW8sMbIBjH6cAgw4bUJV2jjzQWjqjO4/D1wur8tyfWbM9SVRKDl2CdMLahL0+TVqhy38TSTm/rxwZGpzpIqN669UVkNjoCJKR+RJMmc6d738PCR2AkyDEkwUEjtm6ircMlWdjwOTSnA5W4k235aGIQRUM4v+6qyx6s2qSun3f/+skvCgcNhSvrbCRypVCf/p7kzXF0/HOTBBj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:36.1845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aedf887-40ad-4a11-959f-08df249510ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001888E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
HDR visual confirm should be programmed based on per-pipe info, not
top pipe info. There exists scenarios where an HDR app has a desktop
plane still active (due to SW cursor) which is ARGB8888. Taking the top
pipe info will give the wrong visual confirm color.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c    | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index f881a3be6f0a..d6177463c0a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -450,18 +450,12 @@ void get_hdr_visual_confirm_color(
 	uint32_t color_value = MAX_TG_COLOR_VALUE;
 	bool is_sdr = false;
 
-	/* Determine the overscan color based on the top-most (desktop) plane's context */
-	struct pipe_ctx *top_pipe_ctx  = pipe_ctx;
-
-	while (top_pipe_ctx->top_pipe != NULL)
-		top_pipe_ctx = top_pipe_ctx->top_pipe;
-
-	switch (top_pipe_ctx->plane_res.scl_data.format) {
+	switch (pipe_ctx->plane_res.scl_data.format) {
 	case PIXEL_FORMAT_ARGB2101010:
-		if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
+		if (pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
 			/* HDR10, ARGB2101010 - set border color to red */
 			color->color_r_cr = (uint16_t)color_value;
-		} else if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
+		} else if (pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 			/* FreeSync 2 ARGB2101010 - set border color to pink */
 			color->color_r_cr = (uint16_t)color_value;
 			color->color_b_cb = (uint16_t)color_value;
@@ -469,10 +463,10 @@ void get_hdr_visual_confirm_color(
 			is_sdr = true;
 		break;
 	case PIXEL_FORMAT_FP16:
-		if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
+		if (pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
 			/* HDR10, FP16 - set border color to blue */
 			color->color_b_cb = (uint16_t)color_value;
-		} else if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
+		} else if (pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 			/* FreeSync 2 HDR - set border color to green */
 			color->color_g_y = (uint16_t)color_value;
 		} else
-- 
2.43.0

