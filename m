Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA6ECD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE2810EECD;
	Wed, 13 May 2026 14:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iLP4dcA0";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F19910EEBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMcYNvnnL5XMFehExlxwQaotOHLYZ4i+mrHWfvdv11VNp308oAUvG4Yudkg9hOoHqm4TXYaw8yG5h1FxLgdteLtyEEzyFBJg1dtlMgSykATv8aciWbP2LIGcR4je7toEtGdn415GVixZ4gZnHmuLNLVaeqqzHJIhyPFHKank4mOC91MOs+/1UWoY5lWoFzy7i1ixeYUCk3gn8uC8CGc08Zs0W7n1+gKFNJJhNtVOweyN30O6wGQIFHUIdEG2WxXAYsz/Ji6s589Wkx2I2bePxdWVjEnczPLSHgJZkDhrw6TvREJPY9cdQzHPgdCREyrhaCkFYqjU1jZihirWOryCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh2o+QU4Xa95t3O2w3RRHCYBGv0DKsOQ8G//q7698fA=;
 b=NaLbK2Qqx2MoysX6nSLt2+qKQ0WNT5ucE2Vnxp7UeoMSW3rdQLWuTgcFT5aZBjOYqM6TG8y1lQrTqlRl6ymukibI8urBxi+Q4IkN2JPNK0NVKoPDUvUeclDAsKLtnMijepkThfvWK8hrnGPaK7vz9Ael9eKfEa+CCkXNisaZ3AJhnMgVNK7sq645/D/Xx/lsg2vV10sPro0Xv8Us/tOANwmeloSsphydxHOMetXzsiDvj4D6qDq5JHtGv4q+PX1Ni+p02T5kTYfoDYpYHwd+z7W9KvqlkX3FEyWyc5KQlwiUtLglGXC9nl0id+r8rsjfVdD77MGASv/CtFVOJ7bnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh2o+QU4Xa95t3O2w3RRHCYBGv0DKsOQ8G//q7698fA=;
 b=iLP4dcA0Mpf6beShTS1BPwpvt5PiL6HLyY0MGyg5R3WXB9Zruw7uH3WXCDcnakbK4O6LqwRnnbaTULWFHJ0/p+YQdXKcQ66OHyyAycb2OCoxmm+rWUpEKn/5hKOwGAYvId7E/fyHt83W9zurZDSnnkDJon08LG0WgkAZaFjEIto=
Received: from CH2PR18CA0034.namprd18.prod.outlook.com (2603:10b6:610:55::14)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:33:20 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::db) by CH2PR18CA0034.outlook.office365.com
 (2603:10b6:610:55::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:18 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:17 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 05/28] drm/amd/display: Add KUnit test for CRC function
Date: Wed, 13 May 2026 10:29:27 -0400
Message-ID: <20260513143213.1852892-7-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a24ca3e-0df8-4ca5-f5a5-08deb0fc9457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yG1Fh2hgWSjSPCqgwB1l8jffsXwBu4QQudOwzQsxt1Up6P4nsLBDocxr41LHJhztaHvjk1r0hh7AM16JORTc6w7USYborw736O7l1UAZRLNd5Pqb7yL+J2kIUbJMj+VHtJBrnY1iluyluoutkin56MR+hQxukAJNdRSsq7XnMhXUeEba1ffpXeXF6b/O/54FtcY1r2sRLWVlIimuNw5dG3WCi4F0cwWDU688OMjqFoBNCCAmEJtJPKs8m0NY77h5Tvlhg+8BFiUAc16hmeNKtYZjkXM2jvvbWP/Mw1Fehf9fmm9eqmPWT2WGKvUsSMVBzsotPASXBsbowzda8fe2eSJusBRB2cWsEHBJxLRWGSP6nqDoab/4xkgqVWf97xWSGMhtsfDlRHMBX3i+KP/0p60rHy9K+HsamhSVdGCNDBvC9hV8/sa4Q+mEDV+NvefvY1Xxbdk3IDseZAIGGKzUysyjdyUdKwSIE1mYOTOPhnMlyz2ONocaXop6QhMWu/6hYKi1uOdIA2VfL66h+/nYY64rZ0tme7RJ0WVazQg8d3sKuSOQ+R0ArvURLFFv2UQv2WyReI1Qxz3D4jZSDvxHQzNQUT5IDDYSJv7mcE2/JcHzHIjxcT3HGhz7FjuDy1LcvtArfv6esc5uCKj2g3cbL1rpdnBdW23teGE0k87ZP+C9ciuAwDsvYWIofp/hV1dRPibHgcWCdCxZnw3Pk8yVF3l6mDsyXw/rJr8MW0Xf3E4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4+BNCGLPZz4Zq+EvYA8UR815SMPtzf1y6heXgBK9zn2bfJ8Y1cL5Yq/aBx6j+06pmz2dpIiRPRsRP7XdRkZf95GKizdfiTcVG6oBLIxwiMZYYL+iMmMAtXqYYrYwdwwoVFEiXrpz8nko7cb7+6Nk83YnNQiPkuiByGkiQTCMJntSBJtb1EzO0jDg9z6kRBdl7f2RPOvDKuDgOG4UTknLESU4ut1XzSadRPu68IraLo4HgJhfa96unbibV1yPH7wN8qUQS+qiV7cilWykPtZ251pmJhsU20ZOK+AMUi351rhM5uY/OjxBpNoXWUfpLO3vo3S9C5ePsZmT/DdEbfLtCg56ogzG8V0T3agVzbpPq65YWumpEWMXRT7r14PCO8ay/dazCfbyxUUNMkIy25AaSpVoppp7ZinfsRc/gJgk3aWM8gLx5NQ7Lu4mIzp0IWNc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:19.9976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a24ca3e-0df8-4ca5-f5a5-08deb0fc9457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

DM CRC parsing functions are an easy candidate for exploring the use of
KUnit unit-testing frameworks. Add a few tests for the same.

The test file and .kunitconfig are placed under amdgpu_dm/tests/ to
follow the convention of keeping test code separate from production
sources.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  12 ++
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  17 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   7 +
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |  19 +++
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |  14 ++
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   7 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 121 ++++++++++++++++++
 8 files changed, 198 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index abd3b6564373..38323e574c6b 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -56,4 +56,16 @@ config DRM_AMD_SECURE_DISPLAY
 	  This option enables the calculation of crc of specific region via
 	  debugfs. Cooperate with specific DMCU FW.
 
+config DRM_AMD_DC_KUNIT_TEST
+	tristate "KUnit tests for the AMD DC display driver" if !KUNIT_ALL_TESTS
+	depends on DRM_AMD_DC && KUNIT && DEBUG_FS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests for the AMD Display Core driver.
+	  These tests validate core functionality like CRC source parsing,
+	  color management, and other utility functions.
+
+	  For more information on KUnit and unit tests in general, please
+	  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 endmenu
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 89350aa9ca7e..914f89af047c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -59,3 +59,8 @@ AMDGPU_DM = $(addprefix $(AMDDALPATH)/amdgpu_dm/,$(AMDGPUDM))
 
 AMD_DISPLAY_FILES += $(AMDGPU_DM)
 endif
+
+# KUnit tests as separate module
+ifneq ($(CONFIG_DRM_AMD_DC_KUNIT_TEST),)
+obj-y += $(AMDDALPATH)/amdgpu_dm/tests/
+endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index e9834d7b6534..3613e67d1085 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -33,6 +33,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_dm_psr.h"
 #include "amdgpu_dm_replay.h"
+#include "amdgpu_dm_kunit_helpers.h"
 
 static const char *const pipe_crc_sources[] = {
 	"none",
@@ -43,7 +44,8 @@ static const char *const pipe_crc_sources[] = {
 	"auto",
 };
 
-static enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
+STATIC_IFN_KUNIT
+enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
 {
 	if (!source || !strcmp(source, "none"))
 		return AMDGPU_DM_PIPE_CRC_SOURCE_NONE;
@@ -58,25 +60,32 @@ static enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
 
 	return AMDGPU_DM_PIPE_CRC_SOURCE_INVALID;
 }
+EXPORT_IF_KUNIT(dm_parse_crc_source);
 
-static bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
+STATIC_IFN_KUNIT
+bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC) ||
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER);
 }
+EXPORT_IF_KUNIT(dm_is_crc_source_crtc);
 
-static bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
+STATIC_IFN_KUNIT
+bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX) ||
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER);
 }
+EXPORT_IF_KUNIT(dm_is_crc_source_dprx);
 
-static bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src)
+STATIC_IFN_KUNIT
+bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER) ||
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER) ||
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
 }
+EXPORT_IF_KUNIT(dm_need_crc_dither);
 
 const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 						  size_t *count)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 8538513ea879..76731ee44e13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -148,4 +148,11 @@ void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev);
 #define amdgpu_dm_crtc_secure_display_create_contexts(x)
 #endif
 
+#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source);
+bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src);
+bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src);
+bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src);
+#endif
+
 #endif /* AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
new file mode 100644
index 000000000000..4b2864375105
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef AMDGPU_DM_KUNIT_HELPERS_H
+#define AMDGPU_DM_KUNIT_HELPERS_H
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#define STATIC_IFN_KUNIT
+#define INLINE_IFN_KUNIT inline
+#define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
+#else
+#define STATIC_IFN_KUNIT static
+#define INLINE_IFN_KUNIT
+#define EXPORT_IF_KUNIT(symbol)
+#endif
+
+#endif /* AMDGPU_DM_KUNIT_HELPERS_H */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
new file mode 100644
index 000000000000..36676326ade4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
@@ -0,0 +1,14 @@
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_DRM=y
+CONFIG_DRM_AMDGPU=y
+CONFIG_DRM_AMD_DC=y
+CONFIG_DEBUG_FS=y
+CONFIG_DRM_AMD_DC_KUNIT_TEST=y
+CONFIG_FW_LOADER=y
+CONFIG_DRM_KMS_HELPER=y
+CONFIG_DRM_TTM=y
+CONFIG_HWMON=y
+CONFIG_I2C=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_CRC16=y
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
new file mode 100644
index 000000000000..1238d8832fa3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for amdgpu_dm KUnit tests.
+
+ccflags-y += -I$(src)/..
+
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
new file mode 100644
index 000000000000..bba8b1a8fa1c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_crc.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "amdgpu_dm_crc.h"
+
+static void dm_test_parse_crc_source_none(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_NONE, dm_parse_crc_source("none"));
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_NONE, dm_parse_crc_source(NULL));
+}
+
+static void dm_test_parse_crc_source_crtc(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_CRTC, dm_parse_crc_source("crtc"));
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_CRTC, dm_parse_crc_source("auto"));
+}
+
+static void dm_test_parse_crc_source_dprx(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_DPRX, dm_parse_crc_source("dprx"));
+}
+
+static void dm_test_parse_crc_source_crtc_dither(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER,
+			dm_parse_crc_source("crtc dither"));
+}
+
+static void dm_test_parse_crc_source_dprx_dither(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER,
+			dm_parse_crc_source("dprx dither"));
+}
+
+static void dm_test_parse_crc_source_invalid(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_INVALID,
+			dm_parse_crc_source("invalid"));
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_INVALID,
+			dm_parse_crc_source("unknown"));
+	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_INVALID,
+			dm_parse_crc_source(""));
+}
+
+static void dm_test_is_crc_source_crtc(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, dm_is_crc_source_crtc(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+	KUNIT_EXPECT_TRUE(test, dm_is_crc_source_crtc(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER));
+
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_crtc(AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_crtc(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_crtc(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER));
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_crtc(AMDGPU_DM_PIPE_CRC_SOURCE_INVALID));
+}
+
+static void dm_test_is_crc_source_dprx(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, dm_is_crc_source_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+	KUNIT_EXPECT_TRUE(test, dm_is_crc_source_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER));
+
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER));
+	KUNIT_EXPECT_FALSE(test, dm_is_crc_source_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_INVALID));
+}
+
+static void dm_test_need_crc_dither(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, dm_need_crc_dither(AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+	KUNIT_EXPECT_TRUE(test, dm_need_crc_dither(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER));
+	KUNIT_EXPECT_TRUE(test, dm_need_crc_dither(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER));
+
+	KUNIT_EXPECT_FALSE(test, dm_need_crc_dither(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+	KUNIT_EXPECT_FALSE(test, dm_need_crc_dither(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+	KUNIT_EXPECT_FALSE(test, dm_need_crc_dither(AMDGPU_DM_PIPE_CRC_SOURCE_INVALID));
+}
+
+static void dm_test_is_valid_crc_source(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER));
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER));
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_MAX));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_INVALID));
+}
+
+static struct kunit_case dm_crc_test_cases[] = {
+	KUNIT_CASE(dm_test_parse_crc_source_none),
+	KUNIT_CASE(dm_test_parse_crc_source_crtc),
+	KUNIT_CASE(dm_test_parse_crc_source_dprx),
+	KUNIT_CASE(dm_test_parse_crc_source_crtc_dither),
+	KUNIT_CASE(dm_test_parse_crc_source_dprx_dither),
+	KUNIT_CASE(dm_test_parse_crc_source_invalid),
+	KUNIT_CASE(dm_test_is_crc_source_crtc),
+	KUNIT_CASE(dm_test_is_crc_source_dprx),
+	KUNIT_CASE(dm_test_need_crc_dither),
+	KUNIT_CASE(dm_test_is_valid_crc_source),
+	{}
+};
+
+static struct kunit_suite dm_crc_test_suite = {
+	.name = "amdgpu_dm_crc",
+	.test_cases = dm_crc_test_cases,
+};
+
+kunit_test_suite(dm_crc_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_crc");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

