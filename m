Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AE2CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 05:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852BC10E04A;
	Wed, 20 May 2026 05:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QrYdEJ1o";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F8A10E04A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 05:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYehKClXTgrd4xOgTVUQgH0mhB7xW0GKd7OvnnNB7++F3kX+KKaBpdOLk3bKQrDe7TkZK27fr272g/r9xoTAe4aq9By05azj+hzGA0mkTVG0/k43LRWJgMT58pF8Miwatbtxv1ZySomRa6LNmpxuMGeAUH6ONV+0hwPZFNBPi9i5jzouDku7WG14XIpIoIz6pU6lXaxu1FObMeVw8R+sDQty9ZT6uk6BgzCIzkDZ9r6oLLRERcZApK/n7iE1OqLV8ZRb+c0CXP2Ol7sqSCgRiZd0RbwPokuMm/kyl58LZdZqt0EcKb1s+nszJsYxI3PdyOxBaDpjRzd1OTVYSw3ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVQQXbyGnQXDvBdyMZGr+jzJfpnimo0hdhuDeuiefdU=;
 b=Y71R0tXaUeP/VIduXmWAVX6bKwVJRj5xj7RtEqQOYeJAGKqZmZ2WsOCQ+7voPVbiVCiTLdkquZ5kBswxV8LfnkHW83SWBQaaNgymVjmDrniZXKCXOqnagZlZnEDcPhG/kbkGk/lcV1fjN+C9GtorZaJDw4+jVRgUSwt7x0aKbMOWR+XhVqdPBiJkiOW2cRBv/ebVSFLOQp4sV8Cn73EOOikGfmxRg/npRbKf21y7dUmbmlKS/0LjiMG9dcw0v/wDWSsAtIeKL8Hnjxq1jVHTP79vQNJRFU2f2icebGnXkrIMKCAO4sLj/XbegAWUA4SSRIAsNH6UKr/4yaJgS8QH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVQQXbyGnQXDvBdyMZGr+jzJfpnimo0hdhuDeuiefdU=;
 b=QrYdEJ1oHukG16eeXQYC3/Fq7tg44BKhbRhjwM3bWgB6Am8zo9+MaBwXonAurGX/T+s3bqGJizcqfSe4+mkRi2F5ZPCqilXtuDMICbR7GYLygy24MOdX02gScYLSPQHhXMnW7zfDcNICRyTdKqflOgO43WLA5a9f2vPwu6y+BwQ=
Received: from DS7PR05CA0044.namprd05.prod.outlook.com (2603:10b6:8:2f::10) by
 MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 05:50:29 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::99) by DS7PR05CA0044.outlook.office365.com
 (2603:10b6:8:2f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Wed, 20
 May 2026 05:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 05:50:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 00:50:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 00:50:27 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 00:50:20 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Ray Wu <Ray.Wu@amd.com>, "Ray
 Wu" <ray.wu@amd.com>
Subject: [PATCH] drm/amd/display: Fix amdgpu_dm KUnit allmodconfig build
Date: Wed, 20 May 2026 13:50:16 +0800
Message-ID: <20260520055018.800558-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: c01e6a19-8418-49bd-d3fc-08deb633b26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|3023799007|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: R2N5nbSTKRkzQtz9eIkphFVQOjVOg4ZfPyBXDRQ1L0vsz2vFVZc2jS8tY6iBYfhMbJlQbk1AlfrQc97397Hn/uFSGW6BkZWaDGYhV0EO5VC3JMPsHbfkfpALU1j5bhlId3CaP9D3OyeVsl6oy20kENl+jsWazWhmYAmn2kdBmi5NND1+H0R+f3v+spgyn98FCJxqwgq7pQAz3gUw4hwC+kbhZUu+qarEspmY5/MW/9GkCTxxsSNWPSBn1DfmVkYIuuXlPgLTrU9k76OW8wDuQyNYrynBEyOIqCm2q8kvJAB/0H073FwjmjyqCr9pw7NZvv2pDmBJodMlhdzNB6laeHIRT2FToOUIw3Dvjz3GXn99ZKFUbXGZb3oZOd3SX5YbCM/ZgpHwi74gTHocfkfveHnBMeUtp/JfCnU2s5U3XWN/bitJPKN2hvpzwqiAe94AMX5bgqYOiKIrADLORDIxt6LI0PRyKignx+yJnTOOuyp+vxNnae7GPOSTFuGFbJB71KqP/F1E9f5c4HzlurYZMvkibUK6PIIt4ykbZf+px96MfarF4ydfAd/tG85w2hBbcZ9xujmQjTdJK68sRSf7YXIlDpAFCHRuGhFHTSFpW4l6PJ9Cei4Q9mNTorM0Ndd343gtdgvoJMTtr9fNy6UK/t7XhYYGHYogUb9Ck1rMdL+F+LhLdwr1LtGWxa9VYlRCkYsLn+QChPcgQ66s0UeQDVz8LFqmYPwz91Ri+5ZKlhM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(3023799007)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AKKMkOVQ4gNgmQagnGmC/9JbGs0EdBJxoBmV6uqUuRpC1gKKR09hTZx+nD31yRFmkcLcaGppVn4jpPY1Cv4OcTUSy+y2W7cvAZwis/3OdKlVvfh8qvkH0vnQZTn2njlih8pVK+O8YD4X/zKGQqOf5Lo81O0p1uhZNutdJak8f0spWi2+gxIlLsyrOoshu2yp8V3BqWO56kwfbz3xbD171yXApnWGdxhYHjgBV1QibwOmNJ4o+q9E6t4TH/BkGG8HGfjV/TKWquwTAPRJbG3704ILqr3TyMtvd+jzpzvtAS/kg7K1GxbL4SmXtJXDPbg5zXx2wGo6ejQ+ghXVECcd6aR230kZuofCkd3JQVDOpsVP6/7lygfbo55GyifHe0VadQ5Nst9Ojw9B9tTossJQ9//dN/basYWMzxMc/IIrucNZfDFENUL/+PDojUsbbTRj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 05:50:28.5720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c01e6a19-8418-49bd-d3fc-08deb633b26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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

[Why]
With CONFIG_DRM_AMD_DC_KUNIT_TEST=m, allmodconfig only defines the
_MODULE variant. Four KUnit helper headers gate their declarations
with #ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST, so the declarations vanish
while the matching .c files (driven by IS_ENABLED() via
STATIC_IFN_KUNIT) keep the functions non-static. The build breaks
with implicit declarations and -Werror=missing-prototypes.

amdgpu_dm_crc.h additionally uses symbols that its test file does not
pull in indirectly, amdgpu_dm_colorop_test.c has a copy-paste
duplicate function, and the three colorop TF bitmasks are not
exported for modpost.

[How]
- Switch the crc/hdcp/color/psr KUnit guards to IS_ENABLED().
- Make amdgpu_dm_crc.h self-contained (dc_types.h + forward decl).
- Rename the duplicated shaper test back to its intended name.
- Export amdgpu_dm_supported_{degam,shaper,blnd}_tfs via
  EXPORT_IF_KUNIT().

Assisted-by: Copilot:claude-4-opus

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h      | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c    | 4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h        | 5 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h       | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h        | 2 +-
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c | 2 +-
 6 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index 5e484359b8a7..19d3a13572f5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -42,7 +42,7 @@ struct dc_rgb;
 struct fixed31_32;
 struct tetrahedral_params;
 
-#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 /*
  * Prototypes for functions exposed to KUnit tests. The enum types
  * used below (dc_transfer_func_predefined, amdgpu_transfer_function,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 212c13b745d0..7c83fe6df395 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -31,6 +31,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_dm_colorop.h"
+#include "amdgpu_dm_kunit_helpers.h"
 #include "dc.h"
 
 const u64 amdgpu_dm_supported_degam_tfs =
@@ -38,18 +39,21 @@ const u64 amdgpu_dm_supported_degam_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+EXPORT_IF_KUNIT(amdgpu_dm_supported_degam_tfs);
 
 const u64 amdgpu_dm_supported_shaper_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+EXPORT_IF_KUNIT(amdgpu_dm_supported_shaper_tfs);
 
 const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+EXPORT_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
 
 #define MAX_COLOR_PIPELINE_OPS 10
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 76731ee44e13..c9aa0c82038f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -27,8 +27,11 @@
 #ifndef AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_
 #define AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_
 
+#include "dc_types.h"
+
 struct drm_crtc;
 struct dm_crtc_state;
+struct amdgpu_device;
 
 enum amdgpu_dm_pipe_crc_source {
 	AMDGPU_DM_PIPE_CRC_SOURCE_NONE = 0,
@@ -148,7 +151,7 @@ void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev);
 #define amdgpu_dm_crtc_secure_display_create_contexts(x)
 #endif
 
-#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source);
 bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src);
 bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 4bb072cfac1e..90b18c450ca6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -94,7 +94,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *work);
 
 struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc);
 
-#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 void process_output(struct hdcp_workqueue *hdcp_work);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 1a41d9b99eb4..9f3e22520ca0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -40,7 +40,7 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm,
 		struct dc_stream_state *stream, bool set_event,	enum psr_event event,
 		bool wait_for_disable);
 
-#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 8bdebcaf42b2..30b5adb23570 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -72,7 +72,7 @@ static void dm_test_supported_shaper_tfs_has_gamma22(struct kunit *test)
 			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
 }
 
-static void dm_test_supported_degam_tfs_no_extra_bits(struct kunit *test)
+static void dm_test_supported_shaper_tfs_no_extra_bits(struct kunit *test)
 {
 	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
-- 
2.43.0

