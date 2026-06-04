Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B607CD6E6D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1604611284C;
	Thu,  4 Jun 2026 14:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DHXZ89eV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC10A112851
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pB6Xergp1VvPNF7hChj9Ypd7w4frRCdw182W6qN51Bp77pfkk8Nbn2xF2tGxZL29883kpYBlhJzRutZfJ0Bz2Cwd1EWDsGUvfq6H87hyQMmdzZp2NQD0CZi6rWKwrrqY+IB3BrtMbLqEHDbkKRWti/jn548tJRydoZBJA9VBGb5vFEfluOeA51qUENYdWXB+aMfpz7WHz+v9pMbAiQbPAoJZsgzeBUh1jkwctCmYon2GHtjXsWYkMbw5hheQ+1HssFD+EWVVEkcOJ6/H6mF9EvmydJPg6jVVPhNfO+aqZjxZfa9OS+5XoSRI2p6jB7Cz1CJbO2GUa8WONwZQLCkWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN+b3Ml0LQ2UEHtpHn4snrkfymzC6PP7D0kuQ82QXSU=;
 b=HGPhdU/VBQnkZqCJT+5MdwCePXzYVAZOP+GDHs70+xMTv2PauveMXpnxKaeBtRTwFBZjPOA0kiaSl8ibiu5OSRGML7KBYLSKCBEMRqO42PRTNXbdtxbNPm6OetFi1V5SEy9VW25vYPsanqWY2cH0J+K7vKzyNnBWIefp377z+jQcwQxuXMhWjiJVsJH0OfUkWKSgC9IMf7Sq3oBoY+iTb3EECS7yH1JaMZ5FupHdakvlr/GInWhWD8xrNP1l1Q+gLpxz4hEEYJU9IeN13/jQpAwYbCS3ApDFMuObquYz6ExzqIhwvxg+8+iuZyRac3p3tlnH4qpPfBO/K9ER5Op66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN+b3Ml0LQ2UEHtpHn4snrkfymzC6PP7D0kuQ82QXSU=;
 b=DHXZ89eVGpDNPh8hW7Y3aKON0Q8hRtcfE/nTMkdHbYQqngvMGCJbe6KHIJklg6wR1KgvxVNhSr05c11j2/rk24Fe3UlG1/IehUshh22i9tSOsuHuQnKRWUykdowvz+Z0SEjnwbWJh0nICloV+kGsYaNNcMbrNffByGXyIn1xZbM=
Received: from BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::10)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 4 Jun 2026
 14:54:54 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::8c) by BL1P223CA0039.outlook.office365.com
 (2603:10b6:208:5b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:48 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:48 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Add KUnit tests for writeback connector
Date: Thu, 4 Jun 2026 10:52:00 -0400
Message-ID: <20260604145428.809959-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd285fd-cf9d-4850-2aec-08dec2493d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qbpbbvJ8RckspbcOEAi8c0PDF1R4lHswgQ5S99QI+HxZkvdn65TtI2HzvyAgqtGs7HGqo7zTKAsUMtr2YXgzvdwwgkKZBTtQlbo7HNDpew5XoCJwK7ngAM7CpHRuy0Q6ce5EXxmUnj9J2VOzUGwsTBqiUWZUcdbN+icHb1wpKgWJFD5vHlu6kIcGlOW2WkwHIl8lTawsMzEgmDSa8mxua6+oHYNm+x8Gk8q7k/oTCCrFyewPYPtZR/s6tPgDuvtvj0uYQTcdw7eJSQH94XU2q0qTNwhqY+e0QfOAaeB+WPqdVJlvlP12SXFT0MiF7sb1Dwh6/SUBYyMyeYa4QKYADFDJjmtVUji0Kg+fywemvjm5iJ806aW9/z4g+4tLvcAKjfNQ/nLjqR9DnY/v7dGvp/4hQpLbw2i9zX3GvF/RvDQ4+g6ny1dOJJNPYkU/wDj5J5V+PUGd+Xt7C9AaJkZOPvsHm5zkqrhfzkSdV0oSIdCtx0nIdMyYiNR10su6uSAgd3ThdU8PAAJ/PivIdp62r8Iac8BGmcSfidCWWYfUlmtEcHRb0NJbxwl6cHPT0f1A66l08CXAlRmNWPgrQ6751ZHkIVd7QBOGlatNc0i8/Ez9WXypWSfZLcX4KdDnPSVF5EGKQ/haSrQJi8sb2Tas1EoAuoTy4Cd4IK3l8jFat4o22sBZju7M4urcyd0nuJIFV0muAMtiR69A5BgCLTXmK5GtAhMik23wj2AyFKife8k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dSwixBi7d13OC0rDjz3Yz30TSpz42StwKuMgNI44g0B0mkVLLFhlwrgPgDAuo+N5M/wzsZfOTa1aDdLvSesK+CHDLhPohh4JXVtI9mmnxZfc7NrFtjgdixAk2NQbxNoLotkNWsFPlc4Sv0cDOSORu/mv5M9uIqoltTPk8ks1aXJabXkzZmOveG5Rn5Ekx2pv4DOUVA1FpCWgv3Z6lop2hH6PwgklYZ7h39v+BoqAqtFMjH9Dyi5QD8FSOeMixPuvqUDAJulDoD/HGvA6IXPiAidDeF33KsrqUzs8bVQsU4B77Hgq6Gj5IDiq0cJPy0zp4KgZkww7UPXdnVwQp8ALVx6hxHt9C4d0WC2CWA69f1eX+yx/ul2F5DSPAgB3EgfZr0QjeE0DbIG5X/8ZMhPY8OQj41jVuVnFVLAwZxMy9PI9IljRP8JeqCHsN+pGWaj/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:54.4773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd285fd-cf9d-4850-2aec-08dec2493d03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for amdgpu_dm_wb_encoder_atomic_check() and
amdgpu_dm_wb_connector_get_modes(). Tests cover null job,
null fb, size mismatch, format validation, and mode count
bounds using DRM KUnit mock devices.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  13 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       | 336 ++++++++++++++++++
 4 files changed, 355 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index ead3d0bb052f..058d478a073d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_wb.h"
+#include "amdgpu_dm_kunit_helpers.h"
 #include "amdgpu_display.h"
 #include "dc.h"
 
@@ -40,7 +41,7 @@ static const u32 amdgpu_dm_wb_formats[] = {
 	DRM_FORMAT_XRGB2101010,
 };
 
-static int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
+STATIC_IFN_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
@@ -74,13 +75,15 @@ static int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_wb_encoder_atomic_check);
 
 
-static int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
 {
 	/* Maximum resolution supported by DWB */
 	return drm_add_modes_noedid(connector, 3840, 2160);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_get_modes);
 
 static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 			       struct drm_writeback_job *job)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
index 13d31c857dee..7e9fd7a036fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
@@ -29,8 +29,21 @@
 
 #include <drm/drm_writeback.h>
 
+struct amdgpu_display_manager;
+struct amdgpu_dm_wb_connector;
+
 int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 				struct amdgpu_dm_wb_connector *dm_wbcon,
 				uint32_t link_index);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+
+int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state);
+int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector);
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 768f9bbc50e1..ce1e46acb7af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_psr_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_wb_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
new file mode 100644
index 000000000000..b8ad4b87163a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_wb.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_mode.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_writeback.h>
+
+#include "amdgpu_dm_wb.h"
+
+
+/* Helper functions */
+
+static struct drm_crtc_state *alloc_test_crtc_state(struct kunit *test,
+						    int hdisplay, int vdisplay)
+{
+	struct drm_crtc_state *crtc_state;
+
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	crtc_state->mode.hdisplay = hdisplay;
+	crtc_state->mode.vdisplay = vdisplay;
+
+	return crtc_state;
+}
+
+static struct drm_connector_state *alloc_test_conn_state(struct kunit *test,
+							 int fb_width,
+							 int fb_height,
+							 u32 format)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_writeback_job *job;
+	struct drm_framebuffer *fb;
+	struct drm_format_info *fmt_info;
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, job);
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	fmt_info = kunit_kzalloc(test, sizeof(*fmt_info), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fmt_info);
+
+	fb->width = fb_width;
+	fb->height = fb_height;
+	fmt_info->format = format;
+	fb->format = fmt_info;
+
+	job->fb = fb;
+	conn_state->writeback_job = job;
+
+	return conn_state;
+}
+
+/* Tests for amdgpu_dm_wb_encoder_atomic_check */
+
+/**
+ * dm_test_wb_atomic_check_no_job - Verify early return when no writeback job
+ * @test: KUnit test context
+ *
+ * When conn_state->writeback_job is NULL, no writeback is requested and the
+ * function should return 0 without further validation.
+ */
+static void dm_test_wb_atomic_check_no_job(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	crtc_state = alloc_test_crtc_state(test, 1920, 1080);
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	/* No writeback_job — should return 0 */
+	conn_state->writeback_job = NULL;
+	ret = amdgpu_dm_wb_encoder_atomic_check(NULL, crtc_state, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_wb_atomic_check_no_fb - Verify early return when job has no framebuffer
+ * @test: KUnit test context
+ *
+ * When a writeback job exists but job->fb is NULL, the function should return 0
+ * without validating dimensions or pixel format.
+ */
+static void dm_test_wb_atomic_check_no_fb(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	struct drm_writeback_job *job;
+	int ret;
+
+	crtc_state = alloc_test_crtc_state(test, 1920, 1080);
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, job);
+
+	/* writeback_job exists but no fb — should return 0 */
+	job->fb = NULL;
+	conn_state->writeback_job = job;
+	ret = amdgpu_dm_wb_encoder_atomic_check(NULL, crtc_state, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_wb_atomic_check_valid - Verify success with matching size and supported format
+ * @test: KUnit test context
+ *
+ * When the framebuffer dimensions match the CRTC mode and the pixel format is
+ * in the supported formats list, the function should return 0.
+ */
+static void dm_test_wb_atomic_check_valid(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	crtc_state = alloc_test_crtc_state(test, 1920, 1080);
+	conn_state = alloc_test_conn_state(test, 1920, 1080,
+					   DRM_FORMAT_XRGB2101010);
+
+	ret = amdgpu_dm_wb_encoder_atomic_check(NULL, crtc_state, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_wb_atomic_check_size_mismatch - Verify rejection when both dimensions differ
+ * @test: KUnit test context
+ *
+ * When both framebuffer width and height differ from the CRTC mode, the
+ * function should return -EINVAL.
+ */
+static void dm_test_wb_atomic_check_size_mismatch(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	/* FB is 3840x2160 but mode is 1920x1080 */
+	crtc_state = alloc_test_crtc_state(test, 1920, 1080);
+	conn_state = alloc_test_conn_state(test, 3840, 2160,
+					   DRM_FORMAT_XRGB2101010);
+
+	ret = amdgpu_dm_wb_encoder_atomic_check(NULL, crtc_state, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_wb_atomic_check_width_mismatch - Verify rejection when width alone differs
+ * @test: KUnit test context
+ *
+ * When only the framebuffer width differs from the CRTC mode hdisplay, the
+ * function should return -EINVAL.
+ */
+static void dm_test_wb_atomic_check_width_mismatch(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	/* Width doesn't match */
+	crtc_state = alloc_test_crtc_state(test, 1920, 1080);
+	conn_state = alloc_test_conn_state(test, 1280, 1080,
+					   DRM_FORMAT_XRGB2101010);
+
+	ret = amdgpu_dm_wb_encoder_atomic_check(NULL, crtc_state, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_wb_atomic_check_height_mismatch - Verify rejection when height alone differs
+ * @test: KUnit test context
+ *
+ * When only the framebuffer height differs from the CRTC mode vdisplay, the
+ * function should return -EINVAL.
+ */
+static void dm_test_wb_atomic_check_height_mismatch(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	/* Height doesn't match */
+	crtc_state = alloc_test_crtc_state(test, 1920, 1080);
+	conn_state = alloc_test_conn_state(test, 1920, 720,
+					   DRM_FORMAT_XRGB2101010);
+
+	ret = amdgpu_dm_wb_encoder_atomic_check(NULL, crtc_state, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_wb_atomic_check_invalid_format - Verify rejection of unsupported pixel format
+ * @test: KUnit test context
+ *
+ * When the framebuffer dimensions match but the pixel format is not in
+ * amdgpu_dm_wb_formats[], the function should return -EINVAL.
+ */
+static void dm_test_wb_atomic_check_invalid_format(struct kunit *test)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	/* Correct size but unsupported format */
+	crtc_state = alloc_test_crtc_state(test, 1920, 1080);
+	conn_state = alloc_test_conn_state(test, 1920, 1080,
+					   DRM_FORMAT_XRGB8888);
+
+	ret = amdgpu_dm_wb_encoder_atomic_check(NULL, crtc_state, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/* Tests for amdgpu_dm_wb_connector_get_modes using DRM mock */
+
+static const struct drm_connector_funcs dm_wb_test_connector_funcs = {
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.reset = drm_atomic_helper_connector_reset,
+};
+
+/**
+ * dm_test_wb_get_modes_returns_modes - Verify at least one mode is returned
+ * @test: KUnit test context
+ *
+ * Uses a DRM mock connector to verify that amdgpu_dm_wb_connector_get_modes()
+ * populates the connector with at least one display mode.
+ */
+static void dm_test_wb_get_modes_returns_modes(struct kunit *test)
+{
+	struct device *dev;
+	struct drm_device *drm;
+	struct drm_connector *connector;
+	int count;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*drm), 0,
+						   DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+
+	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
+			    DRM_MODE_CONNECTOR_VIRTUAL, NULL);
+
+	count = amdgpu_dm_wb_connector_get_modes(connector);
+
+	/* drm_add_modes_noedid should return at least one mode */
+	KUNIT_EXPECT_GT(test, count, 0);
+}
+
+/**
+ * dm_test_wb_get_modes_bounded_by_max - Verify all modes are within max resolution
+ * @test: KUnit test context
+ *
+ * Uses a DRM mock connector to verify that all modes returned by
+ * amdgpu_dm_wb_connector_get_modes() have hdisplay <= 3840 and
+ * vdisplay <= 2160, matching the DWB hardware maximum.
+ */
+static void dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
+{
+	struct device *dev;
+	struct drm_device *drm;
+	struct drm_connector *connector;
+	struct drm_display_mode *mode;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*drm), 0,
+						   DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+
+	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
+			    DRM_MODE_CONNECTOR_VIRTUAL, NULL);
+
+	amdgpu_dm_wb_connector_get_modes(connector);
+
+	/* All modes must fit within 3840x2160 */
+	list_for_each_entry(mode, &connector->probed_modes, head) {
+		KUNIT_EXPECT_LE(test, mode->hdisplay, 3840);
+		KUNIT_EXPECT_LE(test, mode->vdisplay, 2160);
+	}
+}
+
+static struct kunit_case dm_wb_test_cases[] = {
+	/* amdgpu_dm_wb_encoder_atomic_check */
+	KUNIT_CASE(dm_test_wb_atomic_check_no_job),
+	KUNIT_CASE(dm_test_wb_atomic_check_no_fb),
+	KUNIT_CASE(dm_test_wb_atomic_check_valid),
+	KUNIT_CASE(dm_test_wb_atomic_check_size_mismatch),
+	KUNIT_CASE(dm_test_wb_atomic_check_width_mismatch),
+	KUNIT_CASE(dm_test_wb_atomic_check_height_mismatch),
+	KUNIT_CASE(dm_test_wb_atomic_check_invalid_format),
+	/* amdgpu_dm_wb_connector_get_modes */
+	KUNIT_CASE(dm_test_wb_get_modes_returns_modes),
+	KUNIT_CASE(dm_test_wb_get_modes_bounded_by_max),
+	{}
+};
+
+static struct kunit_suite dm_wb_test_suite = {
+	.name = "amdgpu_dm_wb",
+	.test_cases = dm_wb_test_cases,
+};
+
+kunit_test_suite(dm_wb_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_wb");
-- 
2.54.0

