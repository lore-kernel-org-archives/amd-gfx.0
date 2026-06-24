Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C0ACDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AD510E10C;
	Wed, 24 Jun 2026 18:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="enjZa59f";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B699C10E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsyoeoxvMBL8kd2bDSqELLtWPPsKmzZ2Cf4iqNaMeTWkrpAoWsY2ZLFKUL56/lw/Ws0oGdRrTIbFpv2AR6Ruj2F8OmCfiMmIhAnCg5ibiubk9pB4tCXMi9ZzimPjDWYEOa3rrJdtXCzXhWMyTaRS3icmNrslXCAfhGkI5F1jEYJPBK1CqyWmtYsx8fV66vtZOPBMi1IPZfgJxt9EXfotR5rcJSGCybUikin3aVJds/AomPvdyYNBWoFH8jjxNYVW4D8oEE2Aslp027d21McECF045566tF4Wx8H18smqw3e8xwcjQJYjnKyuyc5BN38MXM+n1D8uThbp5pkjFziOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+0S2t/thHRmLlWYd9rQdVIgy6MbZ01Td0FGc6i0wqI=;
 b=GQYzl4oWcq63Tus+qKhINKkrFDL03J0jflRVC6+pf44NYkOxieaeRQtjF4PKrnPbEE4cFWJD+nIrh7k20Ca0Jm18zI7YLPCwAsoRG/z93gy/lYxUK2haAtFo3XX/CGwa+kQ76XYdwqEzs9WIhHr+hMPMNPg6t3QbJS5OlO3DoxMBTh2hivsc0+14iiayjtDFmziP3nH8sGorgyoNGYrwAbCmoWlkTYyvtaQvyIEyGtexYut+U5ubKfTeuLsJWY2xriVUgfinAghGAzbMhrZBa9fxtqScW1YBOZizTeXRJYXlG5VUldhNHzsjHokaSiJlEqhVtTQjKPu7D4mZbQON5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+0S2t/thHRmLlWYd9rQdVIgy6MbZ01Td0FGc6i0wqI=;
 b=enjZa59fBRJS/z8/726bbbZ2MBNbIomRVPqTTpEjaINYtJYe4jrC2YmhBEirFunWorHO9QBDST3JvORELRekmZSR6+UXCNaJWDSkDQmRxmHcpXRXxf96dW9zfqp8EeGAGDPfgU9tydgo8W6SG9rXCp24zU5RE8nJ4spzIoGhBpA=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:12 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::18) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Wed,
 24 Jun 2026 18:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:11 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:09 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 05/28] drm/amd/display: Add kunit tests for amdgpu_dm_plane
Date: Wed, 24 Jun 2026 14:03:03 -0400
Message-ID: <20260624180829.4775-6-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: a94703dd-7500-4b98-117f-08ded21bb187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|18002099003|22082099003|6133799003|11063799006|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: DV9+uEL/c9OqNmc7QAYqxgfigD+d8K2H+N/cn2Eq3WPQj6+wUlXtKqC2JRSI6qAHXE9SCvsAiaWx1wC2F2gh8TXgvBEy+BN8U79sywjs1cwzuDkhh1Jr3stEibdZid9GDIEnFYef+Q7fQbmHB1J12M59Qv8m0CvM5AylwZY5Qbf10gc/tCbVwmKRp9SXJeJtGivKr+8WbKLHKutWeLlmTR7o1T0Ypz5Y+Mz+pY5VLzrvE8WgZD6XWLxdIBCdQSWt94/O9JIyzTpS20FaPDnuydcDCUPkKqi56GnWKucfAgAG4sSuaC+G5SqQzW5TAfd5PEqxYBskCdVHbBaHci7m0QXQB8S6/ioN+FxtM6WYr2nW76ywsw9Op7i/M2H+M7hmFJMe8mAeuIDRQeoZz9cQgz1FZA3zAGi1xmcZUmvZ0TSaxNp9f64J40t8vRMKqNt2/RltRfP4jBd7ST98H7nBniNbgQG9K0FBXV9m8wwChHXkTmtj+xgFvNFjPmIDDnklsducP6zTNrCdve9MOoLhuPaeXlmfdNXP3zdBecLmuIU9PS7+OjOSmYIKTcieNJqdpU+/ZXOd023N2OVfwhQwma3zuhX4atfcfSefQjprELx+xoBbeH/himAYvU4LZdVRutYH990siqyJikc1VqsAOIhH7aGV+Wi3hsxXcI3ICPqspOWLMQSmnLx+yZTly8Ykr6a8TXXv5lSu3J5ti7a9UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QRCj68Ov2IXF40SKrbJ/MNfkeBuz7ZuDBfEOXb1z7LqMugfo0hy0pKcqBryNv/aAEdC3TyIkYce4FavVMbBfk5UzJpWVYBDMSS6SeOitab+yjZ9qqGgzMMFhqbxT58Z4f4Too/5H2mNOqMi1DXM1Xaa0a37v/fRDEebP2eUACK5+Rc9JgXPNovYmCzMagoow6hokKiE78FK6/2i6ln9DiAKgh1E8oe5TfdsN/1e9ICNR/EqVIq06n/diHpbqIkGt6EnyZdyStHde+qGB8Bq+rOx2ru8fyM3JPFvdFvirMZJquaTvovkihX7av2aEeH72O2qyFOWIwqhF7EnfOF3T5QkJSApWTJ5SQJZ1BuFYOhF7ELZMHXwyqhU2a/wlUh86VSD4Orw3Tws2jMStys5Hx9YkYx6Vgv+Q0OWvZ5b2Vr5bDiuYGRweJrHY8LuEbMT5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:11.6726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a94703dd-7500-4b98-117f-08ded21bb187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add kunit tests for some functions in amdgpu_dm_plane.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  115 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   51 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |    2 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 1204 +++++++++++++++++
 4 files changed, 1325 insertions(+), 47 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b122bdd3ea6a..20bac36be335 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -37,6 +37,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_kunit_helpers.h"
 #include "amdgpu_dm_colorop.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
@@ -97,6 +98,7 @@ const struct drm_format_info *amdgpu_dm_plane_get_format_info(u32 pixel_format,
 {
 	return amdgpu_lookup_format_info(pixel_format, modifier);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_get_format_info);
 
 void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
 			       bool *per_pixel_alpha, bool *pre_multiplied_alpha,
@@ -139,8 +141,10 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 		*global_alpha_value = plane_state->alpha >> 8;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_blending_from_plane_state);
 
-static void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
+						   uint64_t *cap, uint64_t mod)
 {
 	if (!*mods)
 		return;
@@ -164,27 +168,29 @@ static void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size, uint64
 	(*mods)[*size] = mod;
 	*size += 1;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier);
 
-static bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
+STATIC_IFN_KUNIT bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
 {
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_has_dcc);
 
-static unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
+STATIC_IFN_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return 0;
 
 	return AMD_FMT_MOD_GET(TILE, modifier);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_gfx9_swizzle_mode);
 
-static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
-							     uint64_t tiling_flags)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
+								       uint64_t tiling_flags)
 {
 	/* Fill GFX8 params */
 	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
 		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
-
 		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
 		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
 		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
@@ -210,9 +216,10 @@ static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_in
 	tiling_info->gfx8.pipe_config =
 			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags);
 
-static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
-							      struct dc_tiling_info *tiling_info)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
+									struct dc_tiling_info *tiling_info)
 {
 	/* Fill GFX9 params */
 	tiling_info->gfx9.num_pipes =
@@ -231,10 +238,11 @@ static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgp
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0))
 		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_device);
 
-static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
-								struct dc_tiling_info *tiling_info,
-								uint64_t modifier)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
+									  struct dc_tiling_info *tiling_info,
+									  uint64_t modifier)
 {
 	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
 	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
@@ -259,14 +267,15 @@ static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amd
 		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
 	}
 }
-
-static int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
-					const enum surface_pixel_format format,
-					const enum dc_rotation_angle rotation,
-					const struct dc_tiling_info *tiling_info,
-					const struct dc_plane_dcc_param *dcc,
-					const struct dc_plane_address *address,
-					const struct plane_size *plane_size)
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier);
+
+STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
+						  const enum surface_pixel_format format,
+						  const enum dc_rotation_angle rotation,
+						  const struct dc_tiling_info *tiling_info,
+						  const struct dc_plane_dcc_param *dcc,
+						  const struct dc_plane_address *address,
+						  const struct plane_size *plane_size)
 {
 	struct dc *dc = adev->dm.dc;
 	struct dc_dcc_surface_param input;
@@ -307,15 +316,16 @@ static int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 
 	return 0;
 }
-
-static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
-								     const struct amdgpu_framebuffer *afb,
-								     const enum surface_pixel_format format,
-								     const enum dc_rotation_angle rotation,
-								     const struct plane_size *plane_size,
-								     struct dc_tiling_info *tiling_info,
-								     struct dc_plane_dcc_param *dcc,
-								     struct dc_plane_address *address)
+EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
+
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+									       const struct amdgpu_framebuffer *afb,
+									       const enum surface_pixel_format format,
+									       const enum dc_rotation_angle rotation,
+									       const struct plane_size *plane_size,
+									       struct dc_tiling_info *tiling_info,
+									       struct dc_plane_dcc_param *dcc,
+									       struct dc_plane_address *address)
 {
 	const uint64_t modifier = afb->base.modifier;
 	int ret = 0;
@@ -358,15 +368,16 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 
 	return ret;
 }
-
-static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amdgpu_device *adev,
-								      const struct amdgpu_framebuffer *afb,
-								      const enum surface_pixel_format format,
-								      const enum dc_rotation_angle rotation,
-								      const struct plane_size *plane_size,
-								      struct dc_tiling_info *tiling_info,
-								      struct dc_plane_dcc_param *dcc,
-								      struct dc_plane_address *address)
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers);
+
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+										const struct amdgpu_framebuffer *afb,
+										const enum surface_pixel_format format,
+										const enum dc_rotation_angle rotation,
+										const struct plane_size *plane_size,
+										struct dc_tiling_info *tiling_info,
+										struct dc_plane_dcc_param *dcc,
+										struct dc_plane_address *address)
 {
 	const uint64_t modifier = afb->base.modifier;
 	int ret = 0;
@@ -398,6 +409,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers);
 
 static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *adev,
 						  uint64_t **mods,
@@ -724,7 +736,7 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 
 }
 
-static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
+STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
 {
 	uint64_t size = 0, capacity = 128;
 	*mods = NULL;
@@ -777,10 +789,11 @@ static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsig
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_get_plane_modifiers);
 
-static int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
-					     const struct dc_plane_cap *plane_cap,
-					     uint32_t *formats, int max_formats)
+STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
+						       const struct dc_plane_cap *plane_cap,
+						       uint32_t *formats, int max_formats)
 {
 	int i, num_formats = 0;
 
@@ -836,6 +849,7 @@ static int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
 
 	return num_formats;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_get_plane_formats);
 
 int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const struct amdgpu_framebuffer *afb,
@@ -922,6 +936,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_plane_buffer_attributes);
 
 static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 					     struct drm_plane_state *new_state)
@@ -1042,9 +1057,9 @@ static void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 	amdgpu_bo_unref(&rbo);
 }
 
-static void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
-					 struct drm_framebuffer *fb,
-					 int *min_downscale, int *max_upscale)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
+								   struct drm_framebuffer *fb,
+								   int *min_downscale, int *max_upscale)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct dc *dc = adev->dm.dc;
@@ -1088,6 +1103,7 @@ static void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 	if (*min_downscale == 1)
 		*min_downscale = 1000;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_get_min_max_dc_plane_scaling);
 
 int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
 				       struct drm_crtc_state *new_crtc_state)
@@ -1142,6 +1158,7 @@ int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
 	return drm_atomic_helper_check_plane_state(
 		state, new_crtc_state, min_scale, max_scale, true, true);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_helper_check_state);
 
 int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 				const struct drm_plane_state *state,
@@ -1225,6 +1242,7 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_dc_scaling_info);
 
 static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 					struct drm_atomic_state *state)
@@ -1343,6 +1361,7 @@ int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_get_cursor_position);
 
 void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 				 struct drm_plane_state *old_plane_state)
@@ -1546,9 +1565,9 @@ static struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct
 	return &dm_plane_state->base;
 }
 
-static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
-						 uint32_t format,
-						 uint64_t modifier)
+STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
+							   uint32_t format,
+							   uint64_t modifier)
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
@@ -1607,6 +1626,7 @@ static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_format_mod_supported);
 
 static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 						    struct drm_plane_state *state)
@@ -1982,4 +2002,5 @@ bool amdgpu_dm_plane_is_video_format(uint32_t format)
 
 	return false;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_is_video_format);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index ea2619b507db..911fb2d73e22 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -28,6 +28,8 @@
 #define __AMDGPU_DM_PLANE_H__
 
 #include "dc.h"
+#include <drm/drm_plane.h>
+#include "amdgpu.h"
 
 int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 					struct dc_cursor_position *position);
@@ -65,4 +67,53 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 				    bool *global_alpha, int *global_alpha_value);
 
 bool amdgpu_dm_plane_is_video_format(uint32_t format);
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
+				  uint64_t *cap, uint64_t mod);
+void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
+						      uint64_t tiling_flags);
+void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
+						       struct dc_tiling_info *tiling_info);
+void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
+							 struct dc_tiling_info *tiling_info,
+							 uint64_t modifier);
+int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
+				 const enum surface_pixel_format format,
+				 const enum dc_rotation_angle rotation,
+				 const struct dc_tiling_info *tiling_info,
+				 const struct dc_plane_dcc_param *dcc,
+				 const struct dc_plane_address *address,
+				 const struct plane_size *plane_size);
+bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier);
+unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier);
+int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev,
+					unsigned int plane_type, uint64_t **mods);
+int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
+				      const struct dc_plane_cap *plane_cap,
+				      uint32_t *formats, int max_formats);
+int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+							      const struct amdgpu_framebuffer *afb,
+							      const enum surface_pixel_format format,
+							      const enum dc_rotation_angle rotation,
+							      const struct plane_size *plane_size,
+							      struct dc_tiling_info *tiling_info,
+							      struct dc_plane_dcc_param *dcc,
+							      struct dc_plane_address *address);
+int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+							       const struct amdgpu_framebuffer *afb,
+							       const enum surface_pixel_format format,
+							       const enum dc_rotation_angle rotation,
+							       const struct plane_size *plane_size,
+							       struct dc_tiling_info *tiling_info,
+							       struct dc_plane_dcc_param *dcc,
+							       struct dc_plane_address *address);
+bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
+					  uint32_t format,
+					  uint64_t modifier);
+void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
+						  struct drm_framebuffer *fb,
+						  int *min_downscale,
+						  int *max_upscale);
+#endif
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 168ad064e7cb..4d89ad8a6df6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_irq_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_wb_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_plane_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
@@ -31,3 +32,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_services_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_helpers_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_quirks_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_plane_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
new file mode 100644
index 000000000000..deec75857c0e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -0,0 +1,1204 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_plane.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+ #include <kunit/test.h>
+ #include <drm/drm_blend.h>
+ #include "link_enc_cfg.h"
+ #include "amdgpu_dm_plane.h"
+ #include <drm/amdgpu_drm.h>
+ #include <drm/drm_plane.h>
+
+
+struct dm_test_dcc_cap_ctx {
+	bool callback_ret;
+	bool capable;
+	bool output_independent_64b_blks;
+	bool called;
+	struct dc_dcc_surface_param captured_input;
+};
+
+static struct dm_test_dcc_cap_ctx *dm_test_dcc_ctx;
+
+static bool dm_test_get_dcc_compression_cap(const struct dc *dc,
+					    const struct dc_dcc_surface_param *input,
+					    struct dc_surface_dcc_cap *output)
+{
+	if (!dm_test_dcc_ctx)
+		return false;
+
+	dm_test_dcc_ctx->called = true;
+	dm_test_dcc_ctx->captured_input = *input;
+	output->capable = dm_test_dcc_ctx->capable;
+	output->grph.rgb.independent_64b_blks = dm_test_dcc_ctx->output_independent_64b_blks;
+
+	return dm_test_dcc_ctx->callback_ret;
+}
+
+static void dm_test_init_validate_dcc_inputs(struct amdgpu_device **adev,
+					     struct dc **dc,
+					     struct dc_tiling_info *tiling_info,
+					     struct dc_plane_dcc_param *dcc,
+					     struct dc_plane_address *address,
+					     struct plane_size *plane_size,
+					     struct kunit *test)
+{
+	*adev = kunit_kzalloc(test, sizeof(**adev), GFP_KERNEL);
+	*dc = kunit_kzalloc(test, sizeof(**dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, *adev);
+	KUNIT_ASSERT_NOT_NULL(test, *dc);
+
+	(*adev)->dm.dc = *dc;
+	(*adev)->family = AMDGPU_FAMILY_NV;
+
+	tiling_info->gfx9.swizzle = 9;
+	dcc->enable = 1;
+	dcc->independent_64b_blks = 1;
+	plane_size->surface_size.width = 1920;
+	plane_size->surface_size.height = 1080;
+
+	(void)address;
+}
+
+
+/**
+ * dm_test_plane_is_video_format_known_video() - Verify known video formats.
+ * @test: KUnit test context.
+ *
+ * Verify if NV12, NV21, and P010 are treated as video formats.
+ */
+static void dm_test_plane_is_video_format_known_video(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_plane_is_video_format(DRM_FORMAT_NV12));
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_plane_is_video_format(DRM_FORMAT_NV21));
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_plane_is_video_format(DRM_FORMAT_P010));
+}
+
+/**
+ * dm_test_fill_blending_defaults() - Verify default blending output values.
+ * @test: KUnit test context.
+ *
+ * Verify if default blending output values are used for opaque alpha and no
+ * per-pixel blending.
+ */
+static void dm_test_fill_blending_defaults(struct kunit *test)
+{
+	struct drm_plane_state state = { 0 };
+	bool per_pixel_alpha;
+	bool pre_multiplied_alpha;
+	bool global_alpha;
+	int global_alpha_value;
+
+	state.pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
+	state.alpha = 0xffff;
+
+	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
+						       &per_pixel_alpha,
+						       &pre_multiplied_alpha,
+						       &global_alpha,
+						       &global_alpha_value);
+
+	KUNIT_EXPECT_FALSE(test, per_pixel_alpha);
+	KUNIT_EXPECT_TRUE(test, pre_multiplied_alpha);
+	KUNIT_EXPECT_FALSE(test, global_alpha);
+	KUNIT_EXPECT_EQ(test, global_alpha_value, 0xff);
+}
+
+/**
+ * dm_test_fill_blending_premulti_alpha_format() - Verify premultiplied alpha path.
+ * @test: KUnit test context.
+ *
+ * Verify if premultiplied mode enables per-pixel alpha for ARGB8888.
+ */
+static void dm_test_fill_blending_premulti_alpha_format(struct kunit *test)
+{
+	struct drm_plane_state state = { 0 };
+	struct drm_framebuffer fb = { 0 };
+	bool per_pixel_alpha;
+	bool pre_multiplied_alpha;
+	bool global_alpha;
+	int global_alpha_value;
+
+	fb.format = drm_format_info(DRM_FORMAT_ARGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, fb.format);
+
+	state.fb = &fb;
+	state.pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
+	state.alpha = 0xffff;
+
+	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
+						       &per_pixel_alpha,
+						       &pre_multiplied_alpha,
+						       &global_alpha,
+						       &global_alpha_value);
+
+	KUNIT_EXPECT_TRUE(test, per_pixel_alpha);
+	KUNIT_EXPECT_TRUE(test, pre_multiplied_alpha);
+	KUNIT_EXPECT_FALSE(test, global_alpha);
+	KUNIT_EXPECT_EQ(test, global_alpha_value, 0xff);
+}
+
+/**
+ * dm_test_fill_blending_coverage_alpha_format() - Verify coverage mode behavior.
+ * @test: KUnit test context.
+ *
+ * Verify if coverage mode sets per-pixel alpha and disables
+ * pre_multiplied_alpha for ARGB8888.
+ */
+static void dm_test_fill_blending_coverage_alpha_format(struct kunit *test)
+{
+	struct drm_plane_state state = { 0 };
+	struct drm_framebuffer fb = { 0 };
+	bool per_pixel_alpha;
+	bool pre_multiplied_alpha;
+	bool global_alpha;
+	int global_alpha_value;
+
+	fb.format = drm_format_info(DRM_FORMAT_ARGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, fb.format);
+
+	state.fb = &fb;
+	state.pixel_blend_mode = DRM_MODE_BLEND_COVERAGE;
+	state.alpha = 0xffff;
+
+	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
+						       &per_pixel_alpha,
+						       &pre_multiplied_alpha,
+						       &global_alpha,
+						       &global_alpha_value);
+
+	KUNIT_EXPECT_TRUE(test, per_pixel_alpha);
+	KUNIT_EXPECT_FALSE(test, pre_multiplied_alpha);
+	KUNIT_EXPECT_FALSE(test, global_alpha);
+	KUNIT_EXPECT_EQ(test, global_alpha_value, 0xff);
+}
+
+/**
+ * dm_test_fill_blending_global_alpha() - Verify global alpha conversion to 8 bits.
+ * @test: KUnit test context.
+ *
+ * Verify if global alpha is enabled and converted from 16-bit to 8-bit.
+ */
+static void dm_test_fill_blending_global_alpha(struct kunit *test)
+{
+	struct drm_plane_state state = { 0 };
+	bool per_pixel_alpha;
+	bool pre_multiplied_alpha;
+	bool global_alpha;
+	int global_alpha_value;
+
+	state.pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
+	state.alpha = 0x8000;
+
+	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
+						       &per_pixel_alpha,
+						       &pre_multiplied_alpha,
+						       &global_alpha,
+						       &global_alpha_value);
+
+	KUNIT_EXPECT_FALSE(test, per_pixel_alpha);
+	KUNIT_EXPECT_TRUE(test, pre_multiplied_alpha);
+	KUNIT_EXPECT_TRUE(test, global_alpha);
+	KUNIT_EXPECT_EQ(test, global_alpha_value, 0x80);
+}
+
+/**
+ * dm_test_modifier_has_dcc() - Verify helper detects AMD DCC modifiers.
+ * @test: KUnit test context.
+ *
+ * Verify if DCC detection works for linear and AMD DCC modifiers.
+ */
+static void dm_test_modifier_has_dcc(struct kunit *test)
+{
+	uint64_t dcc_mod = AMD_FMT_MOD | AMD_FMT_MOD_SET(DCC, 1);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_modifier_has_dcc(DRM_FORMAT_MOD_LINEAR));
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_plane_modifier_has_dcc(dcc_mod));
+}
+
+/**
+ * dm_test_modifier_gfx9_swizzle_mode() - Verify swizzle helper for linear and AMD modifiers.
+ * @test: KUnit test context.
+ *
+ * Verify if swizzle mode decoding works for linear and AMD tiled modifiers.
+ */
+static void dm_test_modifier_gfx9_swizzle_mode(struct kunit *test)
+{
+	uint64_t mod = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_modifier_gfx9_swizzle_mode(DRM_FORMAT_MOD_LINEAR), 0U);
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_modifier_gfx9_swizzle_mode(mod),
+			(unsigned int)AMD_FMT_MOD_TILE_GFX9_64K_S_X);
+}
+
+/**
+ * dm_test_get_plane_formats() - Verify plane format counts for key plane types.
+ * @test: KUnit test context.
+ *
+ * Verify if returned format counts match primary, overlay, and cursor planes.
+ */
+static void dm_test_get_plane_formats(struct kunit *test)
+{
+	struct drm_plane plane = {0};
+	struct dc_plane_cap cap = {0};
+	uint32_t formats[32] = {0};
+
+	plane.type = DRM_PLANE_TYPE_PRIMARY;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, NULL, formats, 32), 14);
+
+	cap.pixel_format_support.nv12 = true;
+	cap.pixel_format_support.p010 = true;
+	cap.pixel_format_support.fp16 = true;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, &cap, formats, 32), 20);
+
+	plane.type = DRM_PLANE_TYPE_OVERLAY;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, NULL, formats, 32), 9);
+
+	plane.type = DRM_PLANE_TYPE_CURSOR;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, NULL, formats, 32), 1);
+}
+
+/**
+ * dm_test_get_plane_modifiers() - Verify early-return and cursor modifier list.
+ * @test: KUnit test context.
+ *
+ * Verify if modifier list handling works for unsupported families and cursor planes.
+ */
+static void dm_test_get_plane_modifiers(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	uint64_t *mods = NULL;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_SI;
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_plane_modifiers(adev, DRM_PLANE_TYPE_PRIMARY, &mods),
+			0);
+	KUNIT_EXPECT_PTR_EQ(test, mods, NULL);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	KUNIT_ASSERT_EQ(test,
+			amdgpu_dm_plane_get_plane_modifiers(adev, DRM_PLANE_TYPE_CURSOR, &mods),
+			0);
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+	KUNIT_EXPECT_EQ(test, mods[0], DRM_FORMAT_MOD_LINEAR);
+	KUNIT_EXPECT_EQ(test, mods[1], DRM_FORMAT_MOD_INVALID);
+	kfree(mods);
+}
+
+/**
+ * dm_test_fill_dc_scaling_info() - Verify basic error and success paths.
+ * @test: KUnit test context.
+ *
+ * Verify if scaling info rejects invalid sizes and accepts valid sizes.
+ */
+static void dm_test_fill_dc_scaling_info(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane_state state = {0};
+	struct dc_scaling_info info = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	state.src_w = 0;
+	state.src_h = 100 << 16;
+	state.crtc_w = 100;
+	state.crtc_h = 100;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_fill_dc_scaling_info(adev, &state, &info), -EINVAL);
+
+	state.src_w = 100 << 16;
+	state.src_h = 100 << 16;
+	state.crtc_w = 100;
+	state.crtc_h = 100;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_fill_dc_scaling_info(adev, &state, &info), 0);
+}
+
+/**
+ * dm_test_get_min_max_dc_plane_scaling() - Verify format-specific cap selection and 1->1000 conversion.
+ * @test: KUnit test context.
+ *
+ * Verify if min/max scaling values are correct for NV12 and XRGB8888 formats.
+ */
+static void dm_test_get_min_max_dc_plane_scaling(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct drm_framebuffer *fb;
+	int min_downscale = 0;
+	int max_upscale = 0;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	adev->dm.dc = dc;
+	dc->caps.planes[0].max_upscale_factor.nv12 = 1;
+	dc->caps.planes[0].max_downscale_factor.nv12 = 1;
+	dc->caps.planes[0].max_upscale_factor.argb8888 = 1600;
+	dc->caps.planes[0].max_downscale_factor.argb8888 = 250;
+
+	fb->format = drm_format_info(DRM_FORMAT_NV12);
+	KUNIT_ASSERT_NOT_NULL(test, fb->format);
+	amdgpu_dm_plane_get_min_max_dc_plane_scaling(&adev->ddev, fb, &min_downscale, &max_upscale);
+	KUNIT_EXPECT_EQ(test, min_downscale, 1000);
+	KUNIT_EXPECT_EQ(test, max_upscale, 1000);
+
+	fb->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, fb->format);
+	amdgpu_dm_plane_get_min_max_dc_plane_scaling(&adev->ddev, fb, &min_downscale, &max_upscale);
+	KUNIT_EXPECT_EQ(test, min_downscale, 250);
+	KUNIT_EXPECT_EQ(test, max_upscale, 1600);
+}
+
+/**
+ * dm_test_fill_plane_buffer_attributes_gfx8() - Verify graphics path and GFX8 tiling fill.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX8 plane buffer attributes and tiling fields are filled correctly.
+ */
+static void dm_test_fill_plane_buffer_attributes_gfx8(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_framebuffer *afb;
+	struct dc_tiling_info *tiling_info;
+	struct plane_size *plane_size;
+	struct dc_plane_dcc_param *dcc;
+	struct dc_plane_address *address;
+	uint64_t tiling_flags = 0;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	tiling_info = kunit_kzalloc(test, sizeof(*tiling_info), GFP_KERNEL);
+	plane_size = kunit_kzalloc(test, sizeof(*plane_size), GFP_KERNEL);
+	dcc = kunit_kzalloc(test, sizeof(*dcc), GFP_KERNEL);
+	address = kunit_kzalloc(test, sizeof(*address), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+	KUNIT_ASSERT_NOT_NULL(test, tiling_info);
+	KUNIT_ASSERT_NOT_NULL(test, plane_size);
+	KUNIT_ASSERT_NOT_NULL(test, dcc);
+	KUNIT_ASSERT_NOT_NULL(test, address);
+
+	adev->family = AMDGPU_FAMILY_SI;
+	afb->address = 0x12345000ULL;
+	afb->base.width = 1920;
+	afb->base.height = 1080;
+	afb->base.offsets[0] = 0x1000;
+	afb->base.pitches[0] = 7680;
+	afb->base.format = drm_format_info(DRM_FORMAT_XRGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, afb->base.format);
+
+	tiling_flags |= AMDGPU_TILING_SET(ARRAY_MODE, DC_ARRAY_1D_TILED_THIN1);
+	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 5);
+
+	ret = amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb,
+		SURFACE_PIXEL_FORMAT_GRPH_ARGB8888, ROTATION_ANGLE_0,
+		tiling_flags, tiling_info, plane_size, dcc, address, true);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, plane_size->surface_size.width, 1920);
+	KUNIT_EXPECT_EQ(test, plane_size->surface_size.height, 1080);
+	KUNIT_EXPECT_EQ(test, plane_size->surface_pitch, 1920);
+	KUNIT_EXPECT_EQ(test, address->type, (int)PLN_ADDR_TYPE_GRAPHICS);
+	KUNIT_EXPECT_TRUE(test, address->tmz_surface);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info->gfx8.array_mode, (int)DC_ARRAY_1D_TILED_THIN1);
+	KUNIT_EXPECT_EQ(test, tiling_info->gfx8.pipe_config, 5U);
+}
+
+/**
+ * dm_test_get_cursor_position() - Verify cursor clipping and off-screen handling.
+ * @test: KUnit test context.
+ *
+ * Verify if cursor clipping, hotspot adjustment, and off-screen disable behavior work.
+ */
+static void dm_test_get_cursor_position(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct drm_plane plane = {0};
+	struct drm_plane_state state = {0};
+	struct drm_framebuffer fb = {0};
+	struct dc_cursor_position position = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	amdgpu_crtc = kunit_kzalloc(test, sizeof(*amdgpu_crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, amdgpu_crtc);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 0);
+	amdgpu_crtc->max_cursor_width = 64;
+	amdgpu_crtc->max_cursor_height = 64;
+
+	plane.dev = &adev->ddev;
+	plane.state = &state;
+	state.fb = &fb;
+	state.crtc_x = -5;
+	state.crtc_y = -7;
+	state.crtc_w = 32;
+	state.crtc_h = 32;
+
+	KUNIT_ASSERT_EQ(test,
+			amdgpu_dm_plane_get_cursor_position(&plane, &amdgpu_crtc->base, &position),
+			0);
+	KUNIT_EXPECT_TRUE(test, position.enable);
+	KUNIT_EXPECT_EQ(test, position.x, 0);
+	KUNIT_EXPECT_EQ(test, position.y, 0);
+	KUNIT_EXPECT_EQ(test, position.x_hotspot, 5);
+	KUNIT_EXPECT_EQ(test, position.y_hotspot, 7);
+	KUNIT_EXPECT_TRUE(test, position.translate_by_source);
+
+	memset(&position, 0, sizeof(position));
+	state.crtc_x = -64;
+	state.crtc_y = 0;
+	KUNIT_ASSERT_EQ(test,
+			amdgpu_dm_plane_get_cursor_position(&plane, &amdgpu_crtc->base, &position),
+			0);
+	KUNIT_EXPECT_FALSE(test, position.enable);
+}
+
+/**
+ * dm_test_format_mod_supported() - Verify key format/modifier acceptance and rejection paths.
+ * @test: KUnit test context.
+ *
+ * Verify if format-modifier support checks match accepted and rejected cases.
+ */
+static void dm_test_format_mod_supported(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane plane = {0};
+	uint64_t listed_mod;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	plane.dev = &adev->ddev;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_XRGB8888,
+							       DRM_FORMAT_MOD_LINEAR));
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_XRGB8888,
+							       DRM_FORMAT_MOD_INVALID));
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_XRGB8888,
+								DRM_FORMAT_MOD_VENDOR_AMD));
+
+	listed_mod = AMD_FMT_MOD |
+		     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+		     AMD_FMT_MOD_SET(DCC, 1);
+	plane.modifiers = &listed_mod;
+	plane.modifier_count = 1;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_NV12, listed_mod));
+}
+
+/**
+ * dm_test_fill_gfx12_plane_attributes_from_modifiers() - Verify GFX12 DCC mapping path.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX12 modifier parsing enables DCC and sets expected DCC block mode.
+ */
+static void dm_test_fill_gfx12_plane_attributes_from_modifiers(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct dm_test_dcc_cap_ctx ctx = {
+		.callback_ret = true,
+		.capable = true,
+		.output_independent_64b_blks = false,
+	};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_GC_12_0_0;
+	adev->dm.dc = dc;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 256;
+	adev->gfx.config.gb_addr_config_fields.num_se = 1;
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 2;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 1;
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	afb->base.modifier = AMD_FMT_MOD |
+			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
+			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
+			     AMD_FMT_MOD_SET(DCC, 1) |
+			     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 1);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
+			adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+			ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc, &address),
+			0);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxAddr3);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_128b);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx9_plane_attributes_from_modifiers() - Verify basic GFX9 linear modifier path.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX9 linear modifier handling keeps DCC disabled.
+ */
+static void dm_test_fill_gfx9_plane_attributes_from_modifiers(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 256;
+	adev->gfx.config.gb_addr_config_fields.num_se = 1;
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 2;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 1;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 2;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+
+	afb->base.modifier = DRM_FORMAT_MOD_LINEAR;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(
+			adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+			ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc, &address),
+			0);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion9);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.swizzle, 0U);
+	KUNIT_EXPECT_FALSE(test, dcc.enable);
+}
+
+/**
+ * dm_test_helper_check_state_viewport_reject() - Verify viewport outside screen rejects state.
+ * @test: KUnit test context.
+ *
+ * Verify if plane state is rejected when the viewport is outside display bounds.
+ */
+static void dm_test_helper_check_state_viewport_reject(struct kunit *test)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+	state->plane = plane;
+	state->fb = fb;
+	state->crtc = crtc;
+	state->crtc_x = 200;
+	state->crtc_y = 0;
+	state->crtc_w = 100;
+	state->crtc_h = 100;
+	new_crtc_state->mode.crtc_hdisplay = 100;
+	new_crtc_state->mode.crtc_vdisplay = 100;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_helper_check_state(state, new_crtc_state), -EINVAL);
+}
+
+/**
+ * dm_test_validate_dcc_disabled_returns_success() - Verify disabled DCC is accepted.
+ * @test: KUnit test context.
+ *
+ * Verify if DCC validation succeeds when DCC is disabled.
+ */
+static void dm_test_validate_dcc_disabled_returns_success(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+
+	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+					 &plane_size, test);
+	dcc.enable = 0;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+			ROTATION_ANGLE_0, &tiling_info, &dcc,
+			&address, &plane_size),
+			0);
+}
+
+/**
+ * dm_test_validate_dcc_video_non_gfx12_fails() - Verify video format restriction on pre-GFX12.
+ * @test: KUnit test context.
+ *
+ * Verify if video format DCC validation fails on non-GFX12 devices.
+ */
+static void dm_test_validate_dcc_video_non_gfx12_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+
+	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+					 &plane_size, test);
+	adev->family = AMDGPU_FAMILY_NV;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+			ROTATION_ANGLE_0, &tiling_info, &dcc,
+			&address, &plane_size),
+			-EINVAL);
+}
+
+/**
+ * dm_test_validate_dcc_missing_cap_func_fails() - Verify missing capability callback fails.
+ * @test: KUnit test context.
+ *
+ * Verify if validation fails when DCC capability callback is not provided.
+ */
+static void dm_test_validate_dcc_missing_cap_func_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+
+	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+					 &plane_size, test);
+	dc->cap_funcs.get_dcc_compression_cap = NULL;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+			ROTATION_ANGLE_0, &tiling_info, &dcc,
+			&address, &plane_size),
+			-EINVAL);
+}
+
+/**
+ * dm_test_validate_dcc_success_and_scan_mapping() - Verify success path and rotation-to-scan mapping.
+ * @test: KUnit test context.
+ *
+ * Verify if DCC validation succeeds and rotation-to-scan mapping is correct.
+ */
+static void dm_test_validate_dcc_success_and_scan_mapping(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+	struct dm_test_dcc_cap_ctx ctx = {
+		.callback_ret = true,
+		.capable = true,
+		.output_independent_64b_blks = true,
+	};
+
+	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+					 &plane_size, test);
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+			ROTATION_ANGLE_90, &tiling_info, &dcc,
+			&address, &plane_size),
+			0);
+	KUNIT_EXPECT_TRUE(test, ctx.called);
+	KUNIT_EXPECT_EQ(test, (int)ctx.captured_input.scan, (int)SCAN_DIRECTION_VERTICAL);
+	KUNIT_EXPECT_EQ(test, (int)ctx.captured_input.format,
+			(int)SURFACE_PIXEL_FORMAT_GRPH_ARGB8888);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_validate_dcc_independent_64b_mismatch_fails() - Verify 64B compatibility check.
+ * @test: KUnit test context.
+ *
+ * Verify if validation fails when independent_64b_blks values do not match.
+ */
+static void dm_test_validate_dcc_independent_64b_mismatch_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+	struct dm_test_dcc_cap_ctx ctx = {
+		.callback_ret = true,
+		.capable = true,
+		.output_independent_64b_blks = true,
+	};
+
+	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+					 &plane_size, test);
+	dcc.independent_64b_blks = 0;
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+			ROTATION_ANGLE_0, &tiling_info, &dcc,
+			&address, &plane_size),
+			-EINVAL);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_add_modifier_appends_value() - Verify one modifier append.
+ * @test: KUnit test context.
+ *
+ * Verify if a modifier is appended and size is updated.
+ */
+static void dm_test_add_modifier_appends_value(struct kunit *test)
+{
+	uint64_t size = 0;
+	uint64_t cap = 2;
+	uint64_t *mods = kmalloc_array(cap, sizeof(*mods), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+
+	amdgpu_dm_plane_add_modifier(&mods, &size, &cap, 0x1234ULL);
+
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+	KUNIT_EXPECT_EQ(test, size, 1ULL);
+	KUNIT_EXPECT_EQ(test, cap, 2ULL);
+	KUNIT_EXPECT_EQ(test, mods[0], 0x1234ULL);
+
+	kfree(mods);
+}
+
+/**
+ * dm_test_add_modifier_grows_capacity() - Verify add triggers growth and preserves old data.
+ * @test: KUnit test context.
+ *
+ * Verify if modifier array growth keeps old data and appends new data.
+ */
+static void dm_test_add_modifier_grows_capacity(struct kunit *test)
+{
+	uint64_t size = 1;
+	uint64_t cap = 1;
+	uint64_t *mods = kmalloc_array(cap, sizeof(*mods), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+	mods[0] = 0xAAULL;
+
+	amdgpu_dm_plane_add_modifier(&mods, &size, &cap, 0xBBULL);
+
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+	KUNIT_EXPECT_EQ(test, cap, 2ULL);
+	KUNIT_EXPECT_EQ(test, size, 2ULL);
+	KUNIT_EXPECT_EQ(test, mods[0], 0xAAULL);
+	KUNIT_EXPECT_EQ(test, mods[1], 0xBBULL);
+
+	kfree(mods);
+}
+
+/**
+ * dm_test_add_modifier_noop_when_mods_null() - Verify helper is a no-op on NULL mods list.
+ * @test: KUnit test context.
+ *
+ * Verify if add_modifier does nothing when the modifier list is NULL.
+ */
+static void dm_test_add_modifier_noop_when_mods_null(struct kunit *test)
+{
+	uint64_t size = 3;
+	uint64_t cap = 7;
+	uint64_t *mods = NULL;
+
+	amdgpu_dm_plane_add_modifier(&mods, &size, &cap, 0x55ULL);
+
+	KUNIT_EXPECT_PTR_EQ(test, mods, NULL);
+	KUNIT_EXPECT_EQ(test, size, 3ULL);
+	KUNIT_EXPECT_EQ(test, cap, 7ULL);
+}
+
+/**
+ * dm_test_fill_gfx8_tiling_info_2d_tiled() - Verify GFX8 2D tiled flag parsing.
+ * @test: KUnit test context.
+ *
+ * Verify if 2D tiled GFX8 flags populate expected tiling fields.
+ */
+static void dm_test_fill_gfx8_tiling_info_2d_tiled(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+	uint64_t tiling_flags = 0;
+
+	tiling_flags |= AMDGPU_TILING_SET(ARRAY_MODE, DC_ARRAY_2D_TILED_THIN1);
+	tiling_flags |= AMDGPU_TILING_SET(BANK_WIDTH, 2);
+	tiling_flags |= AMDGPU_TILING_SET(BANK_HEIGHT, 1);
+	tiling_flags |= AMDGPU_TILING_SET(MACRO_TILE_ASPECT, 3);
+	tiling_flags |= AMDGPU_TILING_SET(TILE_SPLIT, 4);
+	tiling_flags |= AMDGPU_TILING_SET(NUM_BANKS, 2);
+	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 7);
+
+	amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(&tiling_info, tiling_flags);
+
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion8);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode, (int)DC_ARRAY_2D_TILED_THIN1);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.bank_width, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.bank_height, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_aspect, 3U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_split, 4U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 2U);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.tile_mode,
+			(int)DC_ADDR_SURF_MICRO_TILING_DISPLAY);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.pipe_config, 7U);
+}
+
+/**
+ * dm_test_fill_gfx8_tiling_info_1d_tiled() - Verify GFX8 1D tiled flag parsing.
+ * @test: KUnit test context.
+ *
+ * Verify if 1D tiled GFX8 flags populate array mode and pipe config.
+ */
+static void dm_test_fill_gfx8_tiling_info_1d_tiled(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+	uint64_t tiling_flags = 0;
+
+	tiling_flags |= AMDGPU_TILING_SET(ARRAY_MODE, DC_ARRAY_1D_TILED_THIN1);
+	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 5);
+
+	amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(&tiling_info, tiling_flags);
+
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode, (int)DC_ARRAY_1D_TILED_THIN1);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.pipe_config, 5U);
+}
+
+/**
+ * dm_test_fill_gfx8_tiling_info_other_mode() - Verify non-1D/non-2D mode handling.
+ * @test: KUnit test context.
+ *
+ * Verify if unsupported array mode keeps preset fields and updates pipe config.
+ */
+static void dm_test_fill_gfx8_tiling_info_other_mode(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+	uint64_t tiling_flags = 0;
+
+	tiling_info.gfxversion = 0x7f;
+	tiling_info.gfx8.array_mode = 0x7f;
+	tiling_info.gfx8.tile_mode = 0x7f;
+	tiling_info.gfx8.num_banks = 0x7f;
+
+	tiling_flags |= AMDGPU_TILING_SET(PIPE_CONFIG, 6);
+
+	amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(&tiling_info, tiling_flags);
+
+	KUNIT_EXPECT_EQ(test, tiling_info.gfxversion, 0x7f);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.array_mode, 0x7f);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_mode, 0x7f);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 0x7f);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.pipe_config, 6U);
+}
+
+/**
+ * dm_test_fill_gfx9_tiling_info_from_device_pre_10_3() - Verify GFX9 field copy before 10.3.
+ * @test: KUnit test context.
+ *
+ * Verify if pre-10.3 device fields are copied and existing num_pkrs is kept.
+ */
+static void dm_test_fill_gfx9_tiling_info_from_device_pre_10_3(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_tiling_info tiling_info = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 8;
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 256;
+	adev->gfx.config.gb_addr_config_fields.num_se = 2;
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 1;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 3;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 2, 9);
+
+	tiling_info.gfx9.num_pkrs = 0x5a;
+
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(adev, &tiling_info);
+
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pipes, 4U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_banks, 8U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.pipe_interleave, 256U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_shader_engines, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.max_compressed_frags, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_rb_per_se, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 0x5aU);
+}
+
+/**
+ * dm_test_fill_gfx9_tiling_info_from_device_10_3_plus() - Verify num_pkrs update on 10.3+.
+ * @test: KUnit test context.
+ *
+ * Verify if 10.3+ device fields are copied and num_pkrs is updated.
+ */
+static void dm_test_fill_gfx9_tiling_info_from_device_10_3_plus(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_tiling_info tiling_info = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 128;
+	adev->gfx.config.gb_addr_config_fields.num_se = 1;
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 2;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 1;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 6;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(adev, &tiling_info);
+
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pipes, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_banks, 4U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.pipe_interleave, 128U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_shader_engines, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.max_compressed_frags, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_rb_per_se, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 6U);
+}
+
+/**
+ * dm_test_fill_gfx9_tiling_info_from_modifier_linear() - Verify non-AMD modifier keeps device values.
+ * @test: KUnit test context.
+ *
+ * Verify if linear modifier path keeps values from device configuration.
+ */
+static void dm_test_fill_gfx9_tiling_info_from_modifier_linear(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_tiling_info tiling_info = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 8;
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 256;
+	adev->gfx.config.gb_addr_config_fields.num_se = 2;
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 1;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 3;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, &tiling_info,
+							    DRM_FORMAT_MOD_LINEAR);
+
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pipes, 4U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_banks, 8U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.pipe_interleave, 256U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_shader_engines, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.max_compressed_frags, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_rb_per_se, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 3U);
+}
+
+/**
+ * dm_test_fill_gfx9_tiling_info_from_modifier_pre_nv() - Verify AMD modifier updates banks on pre-NV.
+ * @test: KUnit test context.
+ *
+ * Verify if AMD modifier updates pre-NV pipe, engine, and bank fields.
+ */
+static void dm_test_fill_gfx9_tiling_info_from_modifier_pre_nv(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_tiling_info tiling_info = {0};
+	uint64_t modifier;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_RV;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 16;
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 256;
+	adev->gfx.config.gb_addr_config_fields.num_se = 2;
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 1;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 7;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 2, 9);
+
+	tiling_info.gfx9.num_pkrs = 0x5a;
+
+	modifier = AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, 7) |
+		    AMD_FMT_MOD_SET(BANK_XOR_BITS, 3) |
+		    AMD_FMT_MOD_SET(PACKERS, 2);
+
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, &tiling_info, modifier);
+
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pipes, 32U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_shader_engines, 4U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_banks, 8U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 0x5aU);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
+}
+
+/**
+ * dm_test_fill_gfx9_tiling_info_from_modifier_nv() - Verify AMD modifier updates packers on NV+.
+ * @test: KUnit test context.
+ *
+ * Verify if AMD modifier updates NV+ pipe, engine, and packer fields.
+ */
+static void dm_test_fill_gfx9_tiling_info_from_modifier_nv(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_tiling_info tiling_info = {0};
+	uint64_t modifier;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 9;
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 128;
+	adev->gfx.config.gb_addr_config_fields.num_se = 1;
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 2;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 1;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 2;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+
+	modifier = AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, 6) |
+		    AMD_FMT_MOD_SET(BANK_XOR_BITS, 2) |
+		    AMD_FMT_MOD_SET(PACKERS, 3);
+
+	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, &tiling_info, modifier);
+
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pipes, 32U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_shader_engines, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_banks, 9U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 8U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
+}
+
+static struct kunit_case amdgpu_dm_plane_test_cases[] = {
+	/* amdgpu_dm_plane_is_video_format() */
+	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
+	/* amdgpu_dm_plane_fill_blending_from_plane_state() */
+	KUNIT_CASE(dm_test_fill_blending_defaults),
+	KUNIT_CASE(dm_test_fill_blending_premulti_alpha_format),
+	KUNIT_CASE(dm_test_fill_blending_coverage_alpha_format),
+	KUNIT_CASE(dm_test_fill_blending_global_alpha),
+	/* amdgpu_dm_plane_modifier_* helpers() */
+	KUNIT_CASE(dm_test_modifier_has_dcc),
+	KUNIT_CASE(dm_test_modifier_gfx9_swizzle_mode),
+	/* amdgpu_dm_plane_get_plane_formats() */
+	KUNIT_CASE(dm_test_get_plane_formats),
+	/* amdgpu_dm_plane_get_plane_modifiers() */
+	KUNIT_CASE(dm_test_get_plane_modifiers),
+	/* amdgpu_dm_plane_fill_dc_scaling_info() */
+	KUNIT_CASE(dm_test_fill_dc_scaling_info),
+	/* amdgpu_dm_plane_get_min_max_dc_plane_scaling() */
+	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling),
+	/* amdgpu_dm_plane_fill_plane_buffer_attributes() */
+	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx8),
+	/* amdgpu_dm_plane_get_cursor_position() */
+	KUNIT_CASE(dm_test_get_cursor_position),
+	/* amdgpu_dm_plane_format_mod_supported() */
+	KUNIT_CASE(dm_test_format_mod_supported),
+	/* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() */
+	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
+	/* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
+	/* amdgpu_dm_plane_helper_check_state() */
+	KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
+	/* amdgpu_dm_plane_add_modifier() */
+	KUNIT_CASE(dm_test_add_modifier_appends_value),
+	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
+	KUNIT_CASE(dm_test_add_modifier_noop_when_mods_null),
+	/* amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags() */
+	KUNIT_CASE(dm_test_fill_gfx8_tiling_info_2d_tiled),
+	KUNIT_CASE(dm_test_fill_gfx8_tiling_info_1d_tiled),
+	KUNIT_CASE(dm_test_fill_gfx8_tiling_info_other_mode),
+	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
+	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_pre_10_3),
+	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_10_3_plus),
+	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier() */
+	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier_linear),
+	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier_pre_nv),
+	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier_nv),
+	/* amdgpu_dm_plane_validate_dcc() */
+	KUNIT_CASE(dm_test_validate_dcc_disabled_returns_success),
+	KUNIT_CASE(dm_test_validate_dcc_video_non_gfx12_fails),
+	KUNIT_CASE(dm_test_validate_dcc_missing_cap_func_fails),
+	KUNIT_CASE(dm_test_validate_dcc_success_and_scan_mapping),
+	KUNIT_CASE(dm_test_validate_dcc_independent_64b_mismatch_fails),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_plane_test_suite = {
+	.name = "amdgpu_dm_plane",
+	.test_cases = amdgpu_dm_plane_test_cases,
+};
+
+kunit_test_suite(amdgpu_dm_plane_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_plane");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.53.0

