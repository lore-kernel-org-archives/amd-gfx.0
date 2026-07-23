Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC67C531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650AA10F1C5;
	Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XKy7js9m";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2934810F1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkduUGKE0Oy/ky18k0pTqtzHAr/YOcYa/nZjr7aeDqiEzA1AQ0Z+0BgebAEZkNCgbRDw300jQu4CZZTe9hqu5w7LVe2REm2ZC1R7qM1iXRldSmqAE9qaXuqm6pIY9Kh1sKMSkXorXTwujh/wnDRFxHDfM4DAyBlVYPg+GoXmyzh1TJndCfuP2ySrtpxA1Oq6SNe9Z/mIDx7YWydV0yj2vjQOnESqIPd1GCc1xLjxocfyyCLDqGvKtv5mdiUjd8hnQbY2ZPuiCqRHo2IXJcvNRFNJO/WqKF0r1sdhfiw/FX2/l5by8pvVeNPFIZ24CvpRKGCCBCBVczyi1zIVb+GaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o+eUWCjjimLPeZM3zDC+t4YKokqzxR/IG2WuLJzmF8=;
 b=Eyfj9j9eSa9T8fQUAr7FUkMWm5xSNp5icJpshgvqej289GYAHzeBfWoYCECEx8YUv309wUB7yHd/NMblTs3r21ETlvncbXNGP6R3N6e5QlbkL3TQmH1CPZD+1qQ1HdlVYRrIcFTPXHdQCdhmt3QTMACijNkHRfqJ8+y40m40UOX18guP51J+DtEamZQu3Rh8hRpnl5weJocYh6FwRqDiECPsuoeuP30iXcyYOjfW17S1mEqkh/tcFsiVYRDP7x8rWv7Y8N9M9pxKBI10YDnMY4BXN+8bGA9RDtG/qDPME7GhYAGzAU4kyDefox10/8R4IuWQEwoMcy7Ekj77eaJA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o+eUWCjjimLPeZM3zDC+t4YKokqzxR/IG2WuLJzmF8=;
 b=XKy7js9mD5ZOmzBw2HAzP0mtVLDTuBSm6VPePkleS1B1hZeMcEZFq1Y7nSYJcOSJV32M0fnGJa3qcOMu0RNzXO9pPobhLmvTLKoEuDKABEJZujgpPj5HC5lTU32tSHEOFEzfXWzGFimHWr5MoW3acfgZqw4cZzZIn5cL3vKM/0A=
Received: from MN0P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::20)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:00 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::6b) by MN0P223CA0025.outlook.office365.com
 (2603:10b6:208:52b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:00 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:57 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 12/49] drm/amd/display: move scaling helper to connector
Date: Thu, 23 Jul 2026 16:13:20 -0400
Message-ID: <20260723201908.373300-13-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cff9506-fa88-45e3-137b-08dee8f7a226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: WowkccKXmOA9GCoTpfrhJpee3gaPhDTWZKaAsN2k5CkAq2E3OY2KpTL/14ps04tGNL40KA8wXJdYaqe6BEqWbviXbQ0KhbJfXeyyMD0Niql62YShN8RCCMKqRg7N3nucoIdez3T4y7t07yis/Td1bf6uaSwH+7j02tY0AEkLXQQtYF5+Xlrgeke9BnCVQ+zdvRhI8oQKBxJKb8KzwsjH8HfOioP7HFqs+SzxfbqcGWl4HbDEHNlqusaHc2HiKBW9FQtZB+U0IPzQ/Lt7PCssya8u1L8DHccdclMbrhSi6JWy/7XJ/ggKTUOSw5dkRPfqyJ8HfCE0ktCUzvYz/2/4IGazxfFg41WOI+4nynJE1wGAaXuASGq9YEBXaTMygmQAAfxN4FTQqUcTnEb7t/4M3ryAEKO8nG5i3rI6BovStYG0GHOzzMvZgFH9fvnHYhRrUqho79S2k+KoKgvBzLQI0Xv3i0AljTv6ONMIXWhvsAIUbqeuQ2rSlYQ5u3V3R1adE8vtKe/6Hiqkl+Ney2YCdIvtcIgEmHMxARQnb98Zt+VK/fk47lSf57qh95VJkSzcL4lXqD49hVJO4PNN7uNXmfc0ah7y89VlVWZTd+WWs2MPCFTW3XIm6aakEvptPFXyyndSMsWFUlgU5Kb6TjhC6JHRc23X4k748spReA91QsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d5mw9KDkxlv1PBli6qfz+6kIr8ZYXCDm7d2lGh9mry7GRimq2g+47ut/YC3i4ihNm+VMfbPvBmPq6AwWon9YnEny4y30Mr/j5sUtsanIFIRCtZcvt7mZU4wEUHBY7tbnaQKU8EGzeRWUJjMA5mw677Pz8aqhqX44envb7mFrcWPzwxSzUC5Q/By1dZkwfZQ/w/2VZnuuJ5W3Em6UNCDdIxlY/6ksUjvAfS0geM5UDij0srFr8iws55D7cTIEk/r1I/nWbqbF72Pjtj8Bm2eoSJ10hcTf6bOhqp43xfoB+nM361BdN14yqwA8ureLaWGnoO9sfDIqAcf3EUehxoxPMGYUCdsGRLTjIEhYCVmvoQO/T2MgN/pccFM5ZbWXbDNmAloy69bvkx4GxmcqJd9SwEPjQ0OrsE7rSz9N55SvDOw9Xqx+OP22BWOaT6svGjje
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:00.7734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff9506-fa88-45e3-137b-08dee8f7a226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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
amdgpu_dm_update_stream_scaling_settings() computes the stream src/dst
rectangles for a connector's scaling mode. It is already declared in
amdgpu_dm_connector.h and consumed by create_stream_for_sink(), so move
its definition out of the oversized amdgpu_dm.c into
amdgpu_dm_connector.c where it belongs.

Relocate its KUnit tests from the amdgpu_dm suite to the
amdgpu_dm_connector suite accordingly. No functional change.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  57 -----
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  57 +++++
 .../tests/amdgpu_dm_connector_test.c          | 209 ++++++++++++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 208 -----------------
 4 files changed, 266 insertions(+), 265 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 111cdd66fe93..e6452237ba70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3405,63 +3405,6 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 			   &flip_addrs->dirty_rect_count, true);
 }
 
-void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
-					   const struct drm_display_mode *mode,
-					   const struct dm_connector_state *dm_state,
-					   struct dc_stream_state *stream)
-{
-	enum amdgpu_rmx_type rmx_type;
-
-	struct rect src = { 0 }; /* viewport in composition space*/
-	struct rect dst = { 0 }; /* stream addressable area */
-
-	/* no mode. nothing to be done */
-	if (!mode)
-		return;
-
-	/* Full screen scaling by default */
-	src.width = mode->hdisplay;
-	src.height = mode->vdisplay;
-	dst.width = stream->timing.h_addressable;
-	dst.height = stream->timing.v_addressable;
-
-	if (dm_state) {
-		rmx_type = dm_state->scaling;
-		if (rmx_type == RMX_ASPECT || rmx_type == RMX_OFF) {
-			if (src.width * dst.height <
-					src.height * dst.width) {
-				/* height needs less upscaling/more downscaling */
-				dst.width = src.width *
-						dst.height / src.height;
-			} else {
-				/* width needs less upscaling/more downscaling */
-				dst.height = src.height *
-						dst.width / src.width;
-			}
-		} else if (rmx_type == RMX_CENTER) {
-			dst = src;
-		}
-
-		dst.x = (stream->timing.h_addressable - dst.width) / 2;
-		dst.y = (stream->timing.v_addressable - dst.height) / 2;
-
-		if (dm_state->underscan_enable) {
-			dst.x += dm_state->underscan_hborder / 2;
-			dst.y += dm_state->underscan_vborder / 2;
-			dst.width -= dm_state->underscan_hborder;
-			dst.height -= dm_state->underscan_vborder;
-		}
-	}
-
-	stream->src = src;
-	stream->dst = dst;
-
-	drm_dbg_kms(dev, "Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
-		    dst.x, dst.y, dst.width, dst.height);
-
-}
-EXPORT_IF_KUNIT(amdgpu_dm_update_stream_scaling_settings);
-
 static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
 					    struct dc_state *dc_state,
 					    struct dsc_mst_fairness_vars *vars)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 931f653ebdec..135107c73971 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1371,6 +1371,63 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 }
 #endif
 
+void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
+					   const struct drm_display_mode *mode,
+					   const struct dm_connector_state *dm_state,
+					   struct dc_stream_state *stream)
+{
+	enum amdgpu_rmx_type rmx_type;
+
+	struct rect src = { 0 }; /* viewport in composition space*/
+	struct rect dst = { 0 }; /* stream addressable area */
+
+	/* no mode. nothing to be done */
+	if (!mode)
+		return;
+
+	/* Full screen scaling by default */
+	src.width = mode->hdisplay;
+	src.height = mode->vdisplay;
+	dst.width = stream->timing.h_addressable;
+	dst.height = stream->timing.v_addressable;
+
+	if (dm_state) {
+		rmx_type = dm_state->scaling;
+		if (rmx_type == RMX_ASPECT || rmx_type == RMX_OFF) {
+			if (src.width * dst.height <
+					src.height * dst.width) {
+				/* height needs less upscaling/more downscaling */
+				dst.width = src.width *
+						dst.height / src.height;
+			} else {
+				/* width needs less upscaling/more downscaling */
+				dst.height = src.height *
+						dst.width / src.width;
+			}
+		} else if (rmx_type == RMX_CENTER) {
+			dst = src;
+		}
+
+		dst.x = (stream->timing.h_addressable - dst.width) / 2;
+		dst.y = (stream->timing.v_addressable - dst.height) / 2;
+
+		if (dm_state->underscan_enable) {
+			dst.x += dm_state->underscan_hborder / 2;
+			dst.y += dm_state->underscan_vborder / 2;
+			dst.width -= dm_state->underscan_hborder;
+			dst.height -= dm_state->underscan_vborder;
+		}
+	}
+
+	stream->src = src;
+	stream->dst = dst;
+
+	drm_dbg_kms(dev, "Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
+		    dst.x, dst.y, dst.width, dst.height);
+
+}
+EXPORT_IF_KUNIT(amdgpu_dm_update_stream_scaling_settings);
+
 STATIC_IFN_KUNIT struct dc_stream_state *
 create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 75f6be829f24..0e6fbc4b70f4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -27,6 +27,7 @@
 #include "amdgpu_dm_connector.h"
 #include "amdgpu_dm_backlight.h"
 #include "include/grph_object_id.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
 
 /* Tests for get_subconnector_type() */
 
@@ -5060,6 +5061,206 @@ static void dm_test_update_after_detect_sink_unchanged(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, aconnector->dc_sink);
 }
 
+/* Tests for amdgpu_dm_update_stream_scaling_settings() */
+
+/**
+ * dm_test_update_scaling_null_mode - Test NULL mode leaves the stream rects untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_update_scaling_null_mode(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+
+	stream->timing.h_addressable = 1920;
+	stream->timing.v_addressable = 1080;
+
+	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, NULL, NULL, stream);
+
+	/* NULL mode: early return before touching src/dst */
+	KUNIT_EXPECT_EQ(test, stream->src.width, 0);
+	KUNIT_EXPECT_EQ(test, stream->dst.width, 0);
+}
+
+/**
+ * dm_test_update_scaling_fullscreen_default - Test full-screen default with no dm_state
+ * @test: The KUnit test context
+ */
+static void dm_test_update_scaling_fullscreen_default(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct drm_display_mode mode = { 0 };
+
+	mode.hdisplay = 1920;
+	mode.vdisplay = 1080;
+	stream->timing.h_addressable = 2560;
+	stream->timing.v_addressable = 1440;
+
+	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, NULL, stream);
+
+	/* src = mode, dst = timing addressable, no centering without dm_state */
+	KUNIT_EXPECT_EQ(test, stream->src.width, 1920);
+	KUNIT_EXPECT_EQ(test, stream->src.height, 1080);
+	KUNIT_EXPECT_EQ(test, stream->dst.width, 2560);
+	KUNIT_EXPECT_EQ(test, stream->dst.height, 1440);
+	KUNIT_EXPECT_EQ(test, stream->dst.x, 0);
+	KUNIT_EXPECT_EQ(test, stream->dst.y, 0);
+}
+
+/**
+ * dm_test_update_scaling_rmx_full - Test RMX_FULL keeps a full-size, centered dst
+ * @test: The KUnit test context
+ */
+static void dm_test_update_scaling_rmx_full(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode mode = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	mode.hdisplay = 1280;
+	mode.vdisplay = 720;
+	stream->timing.h_addressable = 1920;
+	stream->timing.v_addressable = 1080;
+	dm_state->scaling = RMX_FULL;
+
+	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
+
+	/* RMX_FULL: dst stays full addressable, offset 0 */
+	KUNIT_EXPECT_EQ(test, stream->dst.width, 1920);
+	KUNIT_EXPECT_EQ(test, stream->dst.height, 1080);
+	KUNIT_EXPECT_EQ(test, stream->dst.x, 0);
+	KUNIT_EXPECT_EQ(test, stream->dst.y, 0);
+}
+
+/**
+ * dm_test_update_scaling_rmx_aspect_pillarbox - Test RMX_ASPECT preserves aspect ratio
+ * @test: The KUnit test context
+ */
+static void dm_test_update_scaling_rmx_aspect_pillarbox(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode mode = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	/* 4:3 source on a 16:9 panel -> pillarboxed */
+	mode.hdisplay = 1024;
+	mode.vdisplay = 768;
+	stream->timing.h_addressable = 1920;
+	stream->timing.v_addressable = 1080;
+	dm_state->scaling = RMX_ASPECT;
+
+	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
+
+	/*
+	 * src.width*dst.height (1024*1080) < src.height*dst.width (768*1920):
+	 * width scaled to src.width*dst.height/src.height = 1440, height stays
+	 * 1080, centered horizontally at (1920-1440)/2 = 240.
+	 */
+	KUNIT_EXPECT_EQ(test, stream->dst.width, 1440);
+	KUNIT_EXPECT_EQ(test, stream->dst.height, 1080);
+	KUNIT_EXPECT_EQ(test, stream->dst.x, 240);
+	KUNIT_EXPECT_EQ(test, stream->dst.y, 0);
+}
+
+/**
+ * dm_test_update_scaling_rmx_aspect_letterbox - Test RMX_ASPECT letterboxes wide sources
+ * @test: The KUnit test context
+ */
+static void dm_test_update_scaling_rmx_aspect_letterbox(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode mode = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	/* 16:9 source on a 4:3 panel -> letterboxed */
+	mode.hdisplay = 1920;
+	mode.vdisplay = 1080;
+	stream->timing.h_addressable = 1024;
+	stream->timing.v_addressable = 768;
+	dm_state->scaling = RMX_ASPECT;
+
+	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
+
+	KUNIT_EXPECT_EQ(test, stream->dst.width, 1024);
+	KUNIT_EXPECT_EQ(test, stream->dst.height, 576);
+	KUNIT_EXPECT_EQ(test, stream->dst.x, 0);
+	KUNIT_EXPECT_EQ(test, stream->dst.y, 96);
+}
+
+/**
+ * dm_test_update_scaling_rmx_center - Test RMX_CENTER centers a 1:1 dst
+ * @test: The KUnit test context
+ */
+static void dm_test_update_scaling_rmx_center(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode mode = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	mode.hdisplay = 1280;
+	mode.vdisplay = 720;
+	stream->timing.h_addressable = 1920;
+	stream->timing.v_addressable = 1080;
+	dm_state->scaling = RMX_CENTER;
+
+	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
+
+	/* RMX_CENTER: dst = src, centered on the addressable area */
+	KUNIT_EXPECT_EQ(test, stream->dst.width, 1280);
+	KUNIT_EXPECT_EQ(test, stream->dst.height, 720);
+	KUNIT_EXPECT_EQ(test, stream->dst.x, 320);
+	KUNIT_EXPECT_EQ(test, stream->dst.y, 180);
+}
+
+/**
+ * dm_test_update_scaling_underscan - Test underscan borders shrink and offset dst
+ * @test: The KUnit test context
+ */
+static void dm_test_update_scaling_underscan(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode mode = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	mode.hdisplay = 1920;
+	mode.vdisplay = 1080;
+	stream->timing.h_addressable = 1920;
+	stream->timing.v_addressable = 1080;
+	dm_state->scaling = RMX_FULL;
+	dm_state->underscan_enable = true;
+	dm_state->underscan_hborder = 64;
+	dm_state->underscan_vborder = 32;
+
+	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
+
+	/* Full dst, then underscan: x/y += border/2, width/height -= border */
+	KUNIT_EXPECT_EQ(test, stream->dst.x, 32);
+	KUNIT_EXPECT_EQ(test, stream->dst.y, 16);
+	KUNIT_EXPECT_EQ(test, stream->dst.width, 1856);
+	KUNIT_EXPECT_EQ(test, stream->dst.height, 1048);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -5339,6 +5540,14 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* amdgpu_dm_update_connector_after_detect */
 	KUNIT_CASE(dm_test_update_after_detect_mst_noop),
 	KUNIT_CASE(dm_test_update_after_detect_sink_unchanged),
+	/* amdgpu_dm_update_stream_scaling_settings */
+	KUNIT_CASE(dm_test_update_scaling_null_mode),
+	KUNIT_CASE(dm_test_update_scaling_fullscreen_default),
+	KUNIT_CASE(dm_test_update_scaling_rmx_full),
+	KUNIT_CASE(dm_test_update_scaling_rmx_aspect_pillarbox),
+	KUNIT_CASE(dm_test_update_scaling_rmx_aspect_letterbox),
+	KUNIT_CASE(dm_test_update_scaling_rmx_center),
+	KUNIT_CASE(dm_test_update_scaling_underscan),
 	{}
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index f967eced6dbb..88ac5e4f6c04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1225,206 +1225,6 @@ static void dm_test_master_stream_defaults_to_first(struct kunit *test)
 			    stream0);
 }
 
-/* Tests for amdgpu_dm_update_stream_scaling_settings() */
-
-/**
- * dm_test_update_scaling_null_mode - Test NULL mode leaves the stream rects untouched
- * @test: The KUnit test context
- */
-static void dm_test_update_scaling_null_mode(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
-
-	stream->timing.h_addressable = 1920;
-	stream->timing.v_addressable = 1080;
-
-	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, NULL, NULL, stream);
-
-	/* NULL mode: early return before touching src/dst */
-	KUNIT_EXPECT_EQ(test, stream->src.width, 0);
-	KUNIT_EXPECT_EQ(test, stream->dst.width, 0);
-}
-
-/**
- * dm_test_update_scaling_fullscreen_default - Test full-screen default with no dm_state
- * @test: The KUnit test context
- */
-static void dm_test_update_scaling_fullscreen_default(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
-	struct drm_display_mode mode = { 0 };
-
-	mode.hdisplay = 1920;
-	mode.vdisplay = 1080;
-	stream->timing.h_addressable = 2560;
-	stream->timing.v_addressable = 1440;
-
-	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, NULL, stream);
-
-	/* src = mode, dst = timing addressable, no centering without dm_state */
-	KUNIT_EXPECT_EQ(test, stream->src.width, 1920);
-	KUNIT_EXPECT_EQ(test, stream->src.height, 1080);
-	KUNIT_EXPECT_EQ(test, stream->dst.width, 2560);
-	KUNIT_EXPECT_EQ(test, stream->dst.height, 1440);
-	KUNIT_EXPECT_EQ(test, stream->dst.x, 0);
-	KUNIT_EXPECT_EQ(test, stream->dst.y, 0);
-}
-
-/**
- * dm_test_update_scaling_rmx_full - Test RMX_FULL keeps a full-size, centered dst
- * @test: The KUnit test context
- */
-static void dm_test_update_scaling_rmx_full(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
-	struct dm_connector_state *dm_state;
-	struct drm_display_mode mode = { 0 };
-
-	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_state);
-
-	mode.hdisplay = 1280;
-	mode.vdisplay = 720;
-	stream->timing.h_addressable = 1920;
-	stream->timing.v_addressable = 1080;
-	dm_state->scaling = RMX_FULL;
-
-	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
-
-	/* RMX_FULL: dst stays full addressable, offset 0 */
-	KUNIT_EXPECT_EQ(test, stream->dst.width, 1920);
-	KUNIT_EXPECT_EQ(test, stream->dst.height, 1080);
-	KUNIT_EXPECT_EQ(test, stream->dst.x, 0);
-	KUNIT_EXPECT_EQ(test, stream->dst.y, 0);
-}
-
-/**
- * dm_test_update_scaling_rmx_aspect_pillarbox - Test RMX_ASPECT preserves aspect ratio
- * @test: The KUnit test context
- */
-static void dm_test_update_scaling_rmx_aspect_pillarbox(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
-	struct dm_connector_state *dm_state;
-	struct drm_display_mode mode = { 0 };
-
-	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_state);
-
-	/* 4:3 source on a 16:9 panel -> pillarboxed */
-	mode.hdisplay = 1024;
-	mode.vdisplay = 768;
-	stream->timing.h_addressable = 1920;
-	stream->timing.v_addressable = 1080;
-	dm_state->scaling = RMX_ASPECT;
-
-	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
-
-	/*
-	 * src.width*dst.height (1024*1080) < src.height*dst.width (768*1920):
-	 * width scaled to src.width*dst.height/src.height = 1440, height stays
-	 * 1080, centered horizontally at (1920-1440)/2 = 240.
-	 */
-	KUNIT_EXPECT_EQ(test, stream->dst.width, 1440);
-	KUNIT_EXPECT_EQ(test, stream->dst.height, 1080);
-	KUNIT_EXPECT_EQ(test, stream->dst.x, 240);
-	KUNIT_EXPECT_EQ(test, stream->dst.y, 0);
-}
-
-/**
- * dm_test_update_scaling_rmx_aspect_letterbox - Test RMX_ASPECT letterboxes wide sources
- * @test: The KUnit test context
- */
-static void dm_test_update_scaling_rmx_aspect_letterbox(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
-	struct dm_connector_state *dm_state;
-	struct drm_display_mode mode = { 0 };
-
-	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_state);
-
-	/* 16:9 source on a 4:3 panel -> letterboxed */
-	mode.hdisplay = 1920;
-	mode.vdisplay = 1080;
-	stream->timing.h_addressable = 1024;
-	stream->timing.v_addressable = 768;
-	dm_state->scaling = RMX_ASPECT;
-
-	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
-
-	KUNIT_EXPECT_EQ(test, stream->dst.width, 1024);
-	KUNIT_EXPECT_EQ(test, stream->dst.height, 576);
-	KUNIT_EXPECT_EQ(test, stream->dst.x, 0);
-	KUNIT_EXPECT_EQ(test, stream->dst.y, 96);
-}
-
-/**
- * dm_test_update_scaling_rmx_center - Test RMX_CENTER centers a 1:1 dst
- * @test: The KUnit test context
- */
-static void dm_test_update_scaling_rmx_center(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
-	struct dm_connector_state *dm_state;
-	struct drm_display_mode mode = { 0 };
-
-	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_state);
-
-	mode.hdisplay = 1280;
-	mode.vdisplay = 720;
-	stream->timing.h_addressable = 1920;
-	stream->timing.v_addressable = 1080;
-	dm_state->scaling = RMX_CENTER;
-
-	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
-
-	/* RMX_CENTER: dst = src, centered on the addressable area */
-	KUNIT_EXPECT_EQ(test, stream->dst.width, 1280);
-	KUNIT_EXPECT_EQ(test, stream->dst.height, 720);
-	KUNIT_EXPECT_EQ(test, stream->dst.x, 320);
-	KUNIT_EXPECT_EQ(test, stream->dst.y, 180);
-}
-
-/**
- * dm_test_update_scaling_underscan - Test underscan borders shrink and offset dst
- * @test: The KUnit test context
- */
-static void dm_test_update_scaling_underscan(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, NULL);
-	struct dm_connector_state *dm_state;
-	struct drm_display_mode mode = { 0 };
-
-	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_state);
-
-	mode.hdisplay = 1920;
-	mode.vdisplay = 1080;
-	stream->timing.h_addressable = 1920;
-	stream->timing.v_addressable = 1080;
-	dm_state->scaling = RMX_FULL;
-	dm_state->underscan_enable = true;
-	dm_state->underscan_hborder = 64;
-	dm_state->underscan_vborder = 32;
-
-	amdgpu_dm_update_stream_scaling_settings(&adev->ddev, &mode, dm_state, stream);
-
-	/* Full dst, then underscan: x/y += border/2, width/height -= border */
-	KUNIT_EXPECT_EQ(test, stream->dst.x, 32);
-	KUNIT_EXPECT_EQ(test, stream->dst.y, 16);
-	KUNIT_EXPECT_EQ(test, stream->dst.width, 1856);
-	KUNIT_EXPECT_EQ(test, stream->dst.height, 1048);
-}
-
 /* Tests for is_content_protection_different() */
 
 struct dm_test_cp_ctx {
@@ -2113,14 +1913,6 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* set_master_stream */
 	KUNIT_CASE(dm_test_master_stream_highest_refresh),
 	KUNIT_CASE(dm_test_master_stream_defaults_to_first),
-	/* amdgpu_dm_update_stream_scaling_settings */
-	KUNIT_CASE(dm_test_update_scaling_null_mode),
-	KUNIT_CASE(dm_test_update_scaling_fullscreen_default),
-	KUNIT_CASE(dm_test_update_scaling_rmx_full),
-	KUNIT_CASE(dm_test_update_scaling_rmx_aspect_pillarbox),
-	KUNIT_CASE(dm_test_update_scaling_rmx_aspect_letterbox),
-	KUNIT_CASE(dm_test_update_scaling_rmx_center),
-	KUNIT_CASE(dm_test_update_scaling_underscan),
 	/* is_content_protection_different */
 	KUNIT_CASE(dm_test_cp_diff_hdcp_type_change),
 	KUNIT_CASE(dm_test_cp_diff_reenable_mode_changed),
-- 
2.53.0

