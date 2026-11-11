Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35912606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W8J/Hj5c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2F810F8C8;
	Wed, 11 Nov 2026 01:42:01 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6A010F8C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkDESkiWyq49OlQ+csL4hirniHLAPHr1YqTbO9Ton5N+Ji0FiNqjGwhl4kjfMJO2EmeZHyz0Lp3J9An3Wyla88Nq5to29lM8PsCB4vWUNkJH954t55/629lKU2RA96x9Awm+PjJSOER+5fV+RpjlxxZjxYXJsA45RW0c+S7skpSALWS5ylJwGqGn56cX0BYBelt1pEO/xZWIUOsjCNAsu7twenVbnOgkI+ilNoLzm2p4M3L9gR0WpoXsJqucDHbqiXmeLHupPf6LqxpNQ0lABNewLEPjkeHQg1CGJUy8b5fqmPcCjlnIJes4jUBNJEi+SodU8iZtSaQmoaP6ReTj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti2vjsE+CGSUaULvY6IzGyE3erAAZIR36zKe2BjagXU=;
 b=s0aCuFUhmrbcVKi7lfB4alT8Co2I86XqbTJirfknZY385fC8a4rKpPkyj8/BLcN8jKofrblQV6nzIEXAIHPxsuvvybvkvm/IZd85vVBMOF6q2MizGCRcaBL0MU0zntyvQlPK40YQRSUaBwIrd/EL9Y+6zNfKuif8cJkblkKXR+IsbcLHDcaG2bOEy0U0B/+afhkUHXKITCuR0nCBKnjS0zG1wGxeoa/QagaXY1H15hOzXeF7qdSaIQZwRJpzwh74ifCYNBpfK4K2q5dkpISXvq4IpV7aJCWxX+/HA2Bn8eQjR/xwjYgWNO5jQIz22LtUtHSxGs+l27fYw0g7nGEK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti2vjsE+CGSUaULvY6IzGyE3erAAZIR36zKe2BjagXU=;
 b=W8J/Hj5cPIYP1yThlXnN30YnQH4KZ1LN5NJ+njt5xrA0By7cVbibvo0L8P3ZuTpGVaCRqIy49VfN4D1Md+8GCUGN2QIHFDLc6J+xZm9QxFIG1dDDiObS4vFEEViyURdL0JblxzrOnNd+KQkbBuIXV8vTTnTw+JdmY9xuPy0v6Vo=
Received: from BY3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:254::13)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 01:41:52 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::86) by BY3PR05CA0008.outlook.office365.com
 (2603:10b6:a03:254::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:50 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:47 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 23/74] drm/amd/display: cleanup tiling and address formats
Date: Wed, 11 Nov 2026 09:28:29 +0800
Message-ID: <20261111014100.3596072-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 7237e976-33c7-4d6e-7be9-08df3f94f5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261021130227099003|261022113327099003|261022105027099003|261026130827099003|261021121427099003|261021123027099003|261021133027099003|261022115727099003|261026140227099003|261009223027099003|261022075727099003|261026135527099003|261021135927099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: T7u5Q0Vn0CdINLG32a2141onimp6MIa7G0hPPmR9ANUDiq2suo8b5klEfOXDGE1cOFJrP/jOEU9zoKe+w+1Tp7lI8JMw/fj1j3uEoeY/bqhs5l3xCiu5IzLioQ1CI/7INg5kd3+TjgTXo9CIYiwFYugNpsEKK43VFrAiNDgLmJavOnnJOZVtoVA9us3lLxE1rTfEc9LgT1FbrzKDtdgGVMpu3SVfqnVre7qY1qRJmcQRZoHFv9FikieTJRm30hXUP4C1jSc2JdvVAcVVjWylVQEdSDmIo6P215KBvog3daUI+aGLPDhWJMPGtCF15YdF/T5QDaHoGEDDq1W7nOc8YAUp6F+229JG3YIDIQvOaRq6rp3ldwmx65BVbbGX/qg6uOvRc6kKtMCfymQIIHZLlD5DEUsQO7YVPn24TNkXkMRRIpu/Ezv9AoBeI+uIhoQP5XuWAnf7sK+AMPLSf3N42QMtKy1i+5BmI1VM+zXxwkVjMtm2p8+kr+65CGEaKPahQaqW7BeSW9Z9Cx/tmvCS5if2a9L59LGXrigXh9yoyaAT77MEyeYl0RZ4kq2k1T+4RuRNp/Byw5ZiMbmTjL7arWvtpxLxhhqatf4z+2DekbD1RN/xRlGntg+S4xPksJjybNEIytF+1qdCwNUlYQ380Bl8ce+MPX9WNUQYkEqfRx/URpgF4jFOd7bAhH9cYWiSOAHJ8bEXJisEdE3xGGgbag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021130227099003)(261022113327099003)(261022105027099003)(261026130827099003)(261021121427099003)(261021123027099003)(261021133027099003)(261022115727099003)(261026140227099003)(261009223027099003)(261022075727099003)(261026135527099003)(261021135927099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hHz7FYs22BaXKo6Tfa6adVk92EoHclwDrxSrcyswrAcG3h3jMns6NeI8COSfjrgu4UcFJvcw10xblcXd4NUuP6+pafyZL6Atc0wLA8fc4G7VsLJeg6fzlC9ddwFRZ4HpIzaH+3ABNDf5848nk7S9y6uooOSmKff4lPoKoF3X6weCzfrqKfSa1YfOiNxVGgII2t4c+GNh/sI4mRY2JZMXnM2rf+NCqvIWkqY9CPtZ9Qv2TBMaSB5cz0+VCdbCN9f+xD7EIcoatCHuGgHaIJ74Pzhs6+tj+opGBxQEa9YylIIMxcQ05BCyIzqZq7zFpeG9Zv4yKFJUYqvsbWT8rRaSJXamxZXnbsMO6EPT6voQq3eg0vBE0cd8RtVvzbaxpbkTmr7VE5VViB7coxZU3AbJ8JkXN02lokXS660g4wGHxGH7Sg415BWLMPSP1gzxSSjI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:51.8523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7237e976-33c7-4d6e-7be9-08df3f94f5b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Cleanup unused tiling and address cases and improve version enum.

Cc: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 16 +++---
 .../dc/dml2_wrapper/dml2_mall_phantom.c       |  1 -
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    | 52 ++-----------------
 3 files changed, 13 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index eb9effb22658..20504dfb1b13 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -390,14 +390,14 @@ enum swizzle_mode_addr3_values {
 	DC_ADDR3_SW_UNKNOWN = DC_ADDR3_SW_MAX
 };
 
-enum dc_gfxversion {
-	DcGfxVersion7 = 0,
-	DcGfxVersion8,
-	DcGfxVersion9,
-	DcGfxVersion10,
-	DcGfxVersion11,
-	DcGfxAddr3,
-	DcGfxVersionUnknown
+enum dc_gfx_addr_version {
+	DcGfxVersion7 = 0x0700,
+	DcGfxVersion8 = 0x0800,
+	DcGfxVersion9 = 0x0900,
+	DcGfxVersion10 = 0x0A00,
+	DcGfxVersion11 = 0x0B00,
+	DcGfxAddr3 = 0x0C00,
+	DcGfxVersionUnknown = 0xFFFF
 };
 
  struct dc_tiling_info {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.c
index edc4dcdde952..bd2c2b82b176 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.c
@@ -808,7 +808,6 @@ static void enable_phantom_plane(struct dml2_context *ctx,
 		memcpy(&phantom_plane->tiling_info, &curr_pipe->plane_state->tiling_info,
 				sizeof(phantom_plane->tiling_info));
 		memcpy(&phantom_plane->dcc, &curr_pipe->plane_state->dcc, sizeof(phantom_plane->dcc));
-		//phantom_plane->tiling_info.gfx10compatible.compat_level = curr_pipe->plane_state->tiling_info.gfx10compatible.compat_level;
 		phantom_plane->format = curr_pipe->plane_state->format;
 		phantom_plane->rotation = curr_pipe->plane_state->rotation;
 		phantom_plane->visible = curr_pipe->plane_state->visible;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
index ba86e30b1180..ceea0b766f5b 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
@@ -217,57 +217,15 @@ static void hubp50_program_tiling(
 	const enum surface_pixel_format pixel_format)
 {
 	(void)pixel_format;
-	/* Tiling address-generation compatibility level programmed into the
-	 * DCSURF_TILING_CONFIG.COMPAT_LEVEL register field:
-	 *   0 - gfx8 bank_height == 1
-	 *   1 - gfx8 bank_height == 2
-	 *   2 - gfx9/10/11
-	 *   5 - gfx addr3
-	 */
-	unsigned int compat_level = 0;
+
 	enum swizzle_mode_values swizzle_mode;
 
-	switch (info->gfxversion) {
-	case DcGfxVersion7:
-	case DcGfxVersion8:
-
-		REG_UPDATE_8(DCSURF_LEGACY_ADDR_CONFIG,
-			LEGACY_NUM_BANKS, info->gfx8.num_banks,
-			BANK_WIDTH, info->gfx8.bank_width,
-			BANK_HEIGHT, info->gfx8.bank_height,
-			MACRO_TILE_ASPECT, info->gfx8.tile_aspect,
-			TILE_SPLIT, info->gfx8.tile_split,
-			MICRO_TILE_MODE_NEW, info->gfx8.tile_mode,
-			PIPE_CONFIG, info->gfx8.pipe_config,
-			ARRAY_MODE, info->gfx8.array_mode);
-		if (info->gfx8.bank_height == 1) {
-			compat_level = 0;
-		} else if (info->gfx8.bank_height == 2) {
-			compat_level = 1;
-		}
-		break;
-
-	case DcGfxVersion9:
-	case DcGfxVersion10:
-	case DcGfxVersion11:
-		REG_UPDATE_4(DCSURF_ADDR_CONFIG,
-			NUM_PIPES, log_2(info->gfx9.num_pipes),
-			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
-			MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags),
-			NUM_PKRS, log_2(info->gfx9.num_pkrs));
-		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, info->gfx9.swizzle);
-		compat_level = 2;
-
-		break;
-	case DcGfxAddr3:
-		swizzle_mode = hubp50_addr3_to_swizzle_mode_mapping(info->gfx_addr3.swizzle);
-		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, swizzle_mode);
-		compat_level = 5;
-		break;
-	}
+	ASSERT(info->gfxversion == DcGfxAddr3);
 
-	REG_UPDATE(DCSURF_TILING_CONFIG, COMPAT_LEVEL, compat_level);
+	swizzle_mode = hubp50_addr3_to_swizzle_mode_mapping(info->gfx_addr3.swizzle);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, swizzle_mode);
 }
+
 static void hubp50_program_pixel_format(
 	struct hubp *hubp,
 	enum surface_pixel_format format)
-- 
2.43.0

