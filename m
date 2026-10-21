Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46365606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oTDERZnF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D682E10F965;
	Wed, 21 Oct 2026 06:27:47 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5EBE10F95B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rThPmV9x5YtMG6LqaUutRP98/XPMgkm+dblDOOz8ersIhSJO5j6vAOUbfbg2kJbPQ5ODxkAJzDVzvOmRFe5wMsx826Sc+RwVbKWa5QgXufSn5zcPjXyVFdCIkCoQD4mzr/TcConoGRNlrIrHRvTFlRtwZkJTI1eZsaYeocpNWPgAW/TUcmZToPZF9+2Cba+Xa3iXBnn8NQnmjxrXfiVZ05WLwBFZfdh1pAqBRv4HGfbFtEtSqKcs9t3d/8qWREehgepObLjLJk2QJqVihm3ZuAwAYEbzxYf1X/MYbP45kTgG6lAXzJvhYhasX2JpyJIBPFOe1P6kgQ5G2UMC2bnyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIiRp9x9dNjzx4GZwOWaWGEDD/OZrThg7P7iccooVG4=;
 b=HC5iu5oBV2+Hid7cVfO6QLQoBYNrtWdu1rTF7YvGKV0FxoswCaA2iwUFjSkNpbysIxAoFy59EafANTubDoqSlRRFm3/7CIboYz8K9fcMlMNxVR7HTagtGn4Sg0Lesm9eBE9SQWMiTKYdRPtlBu/FQkGphkoeTacRVTpNurRJAWTJcL0fYiFnZKwoOTGPyD14eysK1gNhkQZ7VNbNa5aqrra9gDZaS7GF6iDFAgvNFnZcys2dG/Gh6BbsDj4A29pcJjzaBAaz/vlOwjYfZIUmBF1lyDtNR4wW3bSmjsgiFSXVTIRyQLBTDVbf8NxCBOLgILGeEPWRgslT04UVGEn+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIiRp9x9dNjzx4GZwOWaWGEDD/OZrThg7P7iccooVG4=;
 b=oTDERZnFcSd7t8szXbBPxUF+N+Ep6Xkjrpq01AjmGXzB35brTlPYZTDLCfLn67Ndo0WygOuLSRyV+h1zYO9catDex/489myn5fZddGfSkawggq0w4R4X0yChsCUtwa9bSKJBHLf0iqkQQbN77d9JjZgux+lvq7p9mgI7RF55bDk=
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:27:39 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::44) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:27:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:37 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
Subject: [PATCH 36/49] drm/amd/display: remove not used code
Date: Wed, 21 Oct 2026 14:22:42 +0800
Message-ID: <20261021062519.674697-37-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f8d247-25d8-4220-1fda-08df2f3c6734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: 6U1BsACTvUa4h79Hv/0qbd6XOqlNRj4hEmyyryiFqKm1Hl5GOv97TEsz9ArhJmpn1j04GRpoQ/wSvKS1iP1VfKl9Zr1Ou0woyIyqJ6QUuN5gggjNwWsYjQqniUed5TcrVztYaKnCb7aHMEvVCSgmLJURnAkCCUrqv5/jJgVamKR49R4amMYT1POKzn5IeShQZdnmBpoZPs7ZS/Y8jddbTRlfs+8Yt1kIaQZYIYMDJkpbJS4BUFO6z8m3CC2HkYTJuzrVzegmUodNGwk2TP+nub/U03jcpkHvrDHFadX0LxWveEi+vIbRRi1fNFYXHxYCF8+706zDecyPNLot8rFjZ8J+oxHHzkCfY8V2STKHCclGeAl+KQ7R1yGBWW59fdxO2aYh2o3THIM8E6k6IBwIUOV22Q9KkLtmHM2OVs4F1I/4QFvdpHCCUpu/bguCB4rjTGyxabJnqdLoXML0E8BbX2Az/mVApjzIt/qkXrQBPcqsmRqdL2kXTuuN/ri7fXxTGep2mK5rmbPMIbzn4oss+JKGe3lIF8g9w6+2h7meUCDOhHSKS5sM87I6Tv9ziOb8XHPxvoD4pE/sEZgkIMGE3/+KbyPrbKoFiFWZoazfwv0gdgixVS4NHiCApwJF6Nm1me8xco5qQtjDt8TPp9rGhpfdF0w2hduh3bdLynAMMBLRWl+2KYkGuJuNS+AIcwpGnTcHZ4B6bUb2iS2oLR5Vfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KMl7lMZJO+IZOe+BoArlNeSQVXk6/qHhnWn+6k6XjHqix5RKVBkyGytXSye8DY4+61EV4Jq3Xmu3i3oXS1aKcYoFINX7wjczjKQ4YY0MSOFjd0WtvndsczeBBHVHaHfUaUTpum8+zy3AansBDdv9/ejEihgpC8ZwQZlK0uSCc1WLZC9nZldqclCGTCUE4dWZMX1spXmGiSE1QGmM5rhSbrMhSHGVWXiJIhoKhd4uIwRy/ZcJWHwrD7u6I0VyFwMrbzJr3MPHNneqSGoYVRlu9VTu3lsUJ6iIHH6YG9KV2u7UbgI4jbpMDCr89mv5i7mtGS6GeKZIcZXhpDTZ8Wu617YlK3ccZodGGFKz0gaouOlw62OmOQL8p5v1HS3g0U8xIQR5ov5CeE9X7w3kXDi6uDEXjS7veAvc3yYjnZMOIDivFxvCOvObCy5BsgVJFYMe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:38.4655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f8d247-25d8-4220-1fda-08df2f3c6734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
remove dead code

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 -
 .../dc/resource/dcn42/dcn42_resource.c        |  5 -----
 .../dc/resource/dcn42/dcn42_resource_fpu.c    | 22 -------------------
 .../dc/resource/dcn42/dcn42_resource_fpu.h    |  1 -
 4 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7280a422ff0d..7f779e289213 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1325,7 +1325,6 @@ struct dc_debug_options {
 	unsigned int force_vmin_threshold;
 	bool enable_otg_frame_sync_pwa;
 	unsigned int min_deep_sleep_dcfclk_khz;
-	unsigned int force_odm2to1_for_edp_pixclk_mhz;
 	bool enable_replay_esd_recovery;
 	uint8_t iommu_mismatch_temp_wka;
 	bool disable_dynamic_expansion_for_test_pattern;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index a7fdffca8cb9..c01614005281 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -816,7 +816,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_deep_sleep_dcfclk_khz = 8000,
 	.replay_skip_crtc_disabled = true,
 	.psr_skip_crtc_disable = true,
-	.force_odm2to1_for_edp_pixclk_mhz = 0, // disable the policy for now
 	.iommu_mismatch_temp_wka = 0x7,
 };
 
@@ -1889,10 +1888,6 @@ enum dc_status dcn42_validate_bandwidth(struct dc *dc,
 	bool out = false;
 
 	DC_FP_START();
-	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING) {
-		/*only do this when programing HW*/
-		dcn42_decide_odm_override(dc, context);
-	}
 
 	out = dml2_validate(dc, context, context->bw_ctx.dml2,
 						validate_mode);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
index ee330559c233..33b9775420d3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
@@ -45,25 +45,3 @@ void dcn42_decide_zstate_support(struct dc *dc, struct dc_state *context)
 	context->bw_ctx.bw.dcn.clk.zstate_support = support;
 
 }
-
-bool dcn42_decide_odm_override(struct dc *dc, struct dc_state *context)
-{
-	bool odm_override = false;
-
-	DC_LOGGER_INIT(dc->ctx->logger);
-	if (dc->ctx->dce_environment == DCE_ENV_DIAG)
-		return false;
-
-	if (context->stream_count == 1 && context->streams[0]->signal == SIGNAL_TYPE_EDP) {
-
-		if (dc->debug.force_odm2to1_for_edp_pixclk_mhz != 0 &&
-			context->streams[0]->timing.pix_clk_100hz > dc->debug.force_odm2to1_for_edp_pixclk_mhz * 10000) {
-			odm_override = true;
-			context->streams[0]->debug.force_odm_combine_segments = 2;
-		}
-		DC_LOG_SMU("odm_override: %d, eDP pixelclock: %d, force_odm2to1_for_edp_pixclk_mhz: %d\n",
-			odm_override, context->streams[0]->timing.pix_clk_100hz / 10000, dc->debug.force_odm2to1_for_edp_pixclk_mhz);
-	}
-	return odm_override;
-}
-
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h
index aff7be777681..81693c88443e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h
@@ -29,5 +29,4 @@
 #include "core_types.h"
 
 void dcn42_decide_zstate_support(struct dc *dc, struct dc_state *context);
-bool dcn42_decide_odm_override(struct dc *dc, struct dc_state *context);
 #endif /* _DCN42_RESOURCE_FPU_H_ */
-- 
2.43.0

