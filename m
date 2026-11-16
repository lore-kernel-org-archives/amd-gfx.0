Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6016606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TkNCOxXX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4438710F863;
	Tue, 17 Nov 2026 17:17:45 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3055710F857
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYGS6nlQeVPOeKNQfgLFmZOIRZM3W2RXYRJXQEZnlmR6zPBkDFfhszfD/GMwMFbeh6Fyy/syUl25XWdkn/og/7T8pfxoAhYzQvzkeNpzIxw7RkTfBmSiEuNI+B34CF085tktlUZxX3dqL14t0ppCcLaW/FOxD777VaGzmJvMeDX+YIQu1ro/4/d5kEA5MeUV3nM4iLYgW2qz5nT3jMnJQG32NrDPDGVgNCqEilTczLqvbAHSi9qRE5WaLI33gYQP7nqpx+A91rHCMKAuDU5yrF3i9Y7emrCUkeDjB1Ki9PLCuk73o2UD7txxfyDjW6aSsqzewmZfx+5s7T9QjB6E9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Stf1PlW0LYvtaBDoFctL0sYh8Ahlth7XAX1nldOK1ME=;
 b=GyguB1hxWhmZFbOgQZL6wWgj2ohfa4mqrZdGfNFhBnnirtGTe8czE/zOrkYEdip0Yeq474/UTHFLx80qY1l4+PSmK+9shlKLZurne9PYY07S2ty61+8T7UmfOkWyD3aBHDwzjw4qwIp1ONylzHGrYaY9e+wZgiuBdG0x0vBycC9PAHnGih8c8tA0vCvFOsv8vpvdDRQfvBzRXXN2C59aTMbMvlgkppFflDdTnTXoGx/YbE9TZ8F/m4TtqxVDZGnaMJHqUqJvhozIPl8fG3/I9zIF8TC0GbWSuD05vaasrpSaOhNEHSwQBKrUfppui7ffQ0IRIWUMX5OeldbnNQL+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stf1PlW0LYvtaBDoFctL0sYh8Ahlth7XAX1nldOK1ME=;
 b=TkNCOxXXrk9vnkppluLxVygov/14M7i+/lghUNFM1bd1V0v5os+AMtOvnLgAzrSRr5T/wCAIFnSZsSvQA0dl1niRVNvUqcBrI3fJNMwJvO7xL8g2w0mDCUtbYBNUCK9i3ySBoqpiEV0z0Wf3m9QvNykiYHBhNWaKI3Z/+mw9hRk=
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:17:30 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::62) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 17:17:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 17:17:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:29 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:17:20 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 James Lin <pinglei.lin@amd.com>
Subject: [PATCH 31/33] drm/amd/display: Fix DCE crossbar for RGBA8888 surface
 format
Date: Tue, 17 Nov 2026 05:51:08 +0800
Message-ID: <20261116215641.2800595-32-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: b39953f7-dd2c-44ae-9f74-08df44cea8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|261026121527099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: B8m/VEBN7591fHPYFFdKz38m2srG3/docXxs5GS6C7whshTv1NtLJcFi8xNwwWYSyiZzkRczFkUHhG25ekyM6ZB/ociwSAa4J7YQOZdupNxJFuUM6F975hLyAavI3gMkCO2C251Ws7eIWvwUqPxmjjHqw3n+cBJITUfBWVXaH/JL+7jKLh6+bay1MwXFJiImB7SUaYw1w0Q+dRH8mcXtatWi33S6fBi2YRvM2RIbTNcVVIilYSEY4zTrZ9rQgIUFZ512zpfUPJwtjc9/k5Fn3iEGwa9bRD0DW2d+McJy0jbm55webp7zxRsg7Ipe3rj5uDuq+3bQiInuVdY+7Hs9Lx1OcCAqmypiEpWW9YX5ho5S0lRENIydjgsroBaFDUjJ4nGH/Z9ev3I2HCsZ/iOoroucNQl1+3euJQX3eiBAHeb/tf/2v4fR0S/5Kv6myXde8SqPBxht4Xi+GeSWoBCr7KdskPBuVyX/DJ2Pe/GjPDG9w0ckmnj8jP7N4YAf9/qm3Iz2QPF/SXdq0vlVJvNOr127UqR75fxLDO2OWAdn36nrzeP718uXKP42/iKeTmasonAI0YSKUFjP3eVLiBvzZcnjyt40EMPrgME8YRsIBrIhM2VzolfSnrKplvzHa5eTNyzqE3YSijOIxaBbXLj7Lr/zJAC0+jDKaXTUK6Lj6vg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iPy5SyKeOzydcap0KcZca42Gz08utQHr7vUIqW5Z9Isv5iFVs0Ercfaqjj8ROiYybynVJ4EAz4c4k4NFDA5KnDops3aXNSa75liUlGHzahHSLW1x8XWuO7UDjeov6S+BOySImXeWfiulIIjX/6X31a6xU5eFNl8IxOV7YOX4owIL3KsPTzxbpFTGUnBEMDlNgKmKmoQnpRAaVXoWmsGqJeDQBY73mWdajMrS3pNLfJ3Hl0DIpN6Yrgi+F1E3CHqd0OR95rhizu7h7mkvqkNri4ChSGFyfTuzruO+X+oavKqurvRTYylJoizUlmMd3I+HC41NCvNJ0iU2F93eQJweATYr6RC8u9nlY1xbShISLgHI/fmjVWsJCKGYvLTPP2qkj92tP9OZ9qFkh5SnIy4EIn6WMAvJpcm3c7lsb32WbOXq2J0vz/1p41psljQjIOiA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:17:29.8474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39953f7-dd2c-44ae-9f74-08df44cea8fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harry Wentland <harry.wentland@amd.com>

[why]
DCE unpacks all 32bpp graphics formats as ARGB and has no native
alpha-in-LSB encoding. Channel reordering is done only through the
GRPH_SWAP_CNTL crossbar, which programmed just the red and blue
selects. RGBA8888 was therefore scanned out with alpha in the MSB.

[how]
- Program all four GRPH_SWAP_CNTL crossbar selects (red, green, blue,
  alpha) in program_grph_pixel_format().
- Keep the existing R/B swap for ABGR formats.
- Add RGBA8888 with the mapping R<-A, G<-R, B<-G, A<-B.
- Add the GRPH_GREEN_CROSSBAR and GRPH_ALPHA_CROSSBAR fields to the
  DCP register mask and field lists.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5339

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/dce/dce_mem_input.c    | 41 +++++++++++++------
 .../drm/amd/display/dc/dce/dce_mem_input.h    |  6 +++
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 08cde29a4a7a..4f1b8b2750d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -558,25 +558,40 @@ static void program_grph_pixel_format(
 	struct dce_mem_input *dce_mi,
 	enum surface_pixel_format format)
 {
-	uint32_t red_xbar = 0, blue_xbar = 0; /* no swap */
+	/* Crossbar per output channel: 0 R, 1 G, 2 B, 3 A source (see
+	 * DCP_GRPH_*_CROSSBAR in the enum headers). DCE unpacks all 32bpp
+	 * as ARGB, so alpha-in-LSB layouts are reordered via the crossbar.
+	 */
+	uint32_t red_xbar = 0, green_xbar = 0, blue_xbar = 0, alpha_xbar = 0;
 	uint32_t grph_depth = 0, grph_format = 0;
 	uint32_t sign = 0, floating = 0;
 
-	if (format == SURFACE_PIXEL_FORMAT_GRPH_ABGR8888 ||
-			/*todo: doesn't look like we handle BGRA here,
-			 *  should problem swap endian*/
-		format == SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010 ||
-		format == SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS ||
-		format == SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 ||
-		format == SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F) {
-		/* ABGR formats */
-		red_xbar = 2;
-		blue_xbar = 2;
+	switch (format) {
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
+		/* ABGR: swap R and B */
+		red_xbar = 2;  /* R from B */
+		blue_xbar = 2; /* B from R */
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		/* rotate ARGB -> RGBA */
+		red_xbar = 3;   /* R from A */
+		green_xbar = 3; /* G from R */
+		blue_xbar = 3;  /* B from G */
+		alpha_xbar = 3; /* A from B */
+		break;
+	default:
+		break;
 	}
 
-	REG_SET_2(GRPH_SWAP_CNTL, 0,
+	REG_SET_4(GRPH_SWAP_CNTL, 0,
 			GRPH_RED_CROSSBAR, red_xbar,
-			GRPH_BLUE_CROSSBAR, blue_xbar);
+			GRPH_GREEN_CROSSBAR, green_xbar,
+			GRPH_BLUE_CROSSBAR, blue_xbar,
+			GRPH_ALPHA_CROSSBAR, alpha_xbar);
 
 	switch (format) {
 	case SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS:
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index e34e445a4013..a593842ee879 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -189,7 +189,9 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_PITCH, GRPH_PITCH, mask_sh),\
 	SFB(blk, HW_ROTATION, GRPH_ROTATION_ANGLE, mask_sh),\
 	SFB(blk, GRPH_SWAP_CNTL, GRPH_RED_CROSSBAR, mask_sh),\
+	SFB(blk, GRPH_SWAP_CNTL, GRPH_GREEN_CROSSBAR, mask_sh),\
 	SFB(blk, GRPH_SWAP_CNTL, GRPH_BLUE_CROSSBAR, mask_sh),\
+	SFB(blk, GRPH_SWAP_CNTL, GRPH_ALPHA_CROSSBAR, mask_sh),\
 	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_SELECT, mask_sh),\
 	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_R_SIGN, mask_sh),\
 	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_G_SIGN, mask_sh),\
@@ -213,7 +215,9 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_Y_END, GRPH_Y_END, mask_sh),\
 	SFB(blk, GRPH_PITCH, GRPH_PITCH, mask_sh),\
 	SFB(blk, GRPH_SWAP_CNTL, GRPH_RED_CROSSBAR, mask_sh),\
+	SFB(blk, GRPH_SWAP_CNTL, GRPH_GREEN_CROSSBAR, mask_sh),\
 	SFB(blk, GRPH_SWAP_CNTL, GRPH_BLUE_CROSSBAR, mask_sh),\
+	SFB(blk, GRPH_SWAP_CNTL, GRPH_ALPHA_CROSSBAR, mask_sh),\
 	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_SELECT, mask_sh),\
 	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_R_SIGN, mask_sh),\
 	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_G_SIGN, mask_sh),\
@@ -344,7 +348,9 @@ struct dce_mem_input_registers {
 	type GRPH_PITCH; \
 	type GRPH_ROTATION_ANGLE; \
 	type GRPH_RED_CROSSBAR; \
+	type GRPH_GREEN_CROSSBAR; \
 	type GRPH_BLUE_CROSSBAR; \
+	type GRPH_ALPHA_CROSSBAR; \
 	type GRPH_PRESCALE_SELECT; \
 	type GRPH_PRESCALE_R_SIGN; \
 	type GRPH_PRESCALE_G_SIGN; \
-- 
2.43.0

