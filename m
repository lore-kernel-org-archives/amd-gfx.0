Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C15AC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED43010F08E;
	Wed, 15 Jul 2026 13:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oibTl78E";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C286A10F08E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSsRBw1VHDMik+f95rbfTNv5fUj5a1kR0QfLRlt+cy9eYE7BuQcysWSgCZf/KsupwXGmt2U57tLyYucuCJ7EDuA2J1er17W6QL315GUjw7dWdtg4mn2JfmWR51hWD28/8PQGzzP6HXmeam/+n4aeUoPhLmSpLZps1RsJz+Dt6etRLD1VptdTNVqoY+oJufIlNkPjfLRvItAIv226Ce6TnNy6Yq3fcQT6BE74KDCiD3ev0xIcvxlybU9+IKN+lP/TSZUNOXRTLVbDvDPmzpK3ODpK/fxs/3UgfGHrhp2cAc+K6fB3mBlhfNNC4h5KxFoCclxH9iDL4hCuorAJREmgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehkcoeekICbs20mmgy+3iIGSuZeIvyU87wKPg93zV90=;
 b=C4EVaB636XrC7aSeUErDa3UzM+BJuv/UJfFqaALNT2LyqERzfJdfv/3sB9ZTVWNj3PNr3hOsOic+juzgEuMA+LCO5DWVFrMREVVFTUgi0B97UnQH1y0IgeygNtj5LZ7Pu8Ksj5sJd+nD0EPTMQ47s06/RTfW0G3GfF6BnUWp44PTd8zZ9ZvthUmQ4mXESntE9acQzVfc31iF7S73ib+Tm2rgAwn0sNAgQluVDZBgKFcf8+jccF/qF6AzK8TUCwo4fbW1nN/FFfB85bMvdC7ZP/C8gQiC/cZ7bL+6BN0nvE+VU0OU9HFixG0O12GiGgd2TV/+N+2mudAtN+Pwke7gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehkcoeekICbs20mmgy+3iIGSuZeIvyU87wKPg93zV90=;
 b=oibTl78ERpaU26/qcFdI4PF/AYWMYW8nZqQyuOItii2iACFUq12flEUsDwK4lFIr4rr23goWhgQ94wpa1GJlT/Rrr9Ea2cjRFtmSjjrRAGreg8WyyaLNjIUeszQHxupiRaBwMDJy8tPBlce24OT7XJwsf3rQ6eL2FDoQR8Pb620=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by DSVPR12MB999173.namprd12.prod.outlook.com (2603:10b6:8:38a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:48 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::a4) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:46 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 30/70] drm/amd/display: add KUnit tests for DM IP-block
 callbacks
Date: Wed, 15 Jul 2026 21:37:40 +0800
Message-ID: <20260715134432.1975118-31-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DSVPR12MB999173:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be33462-44ca-4f35-6311-08dee2778417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 0dCVHvNcerdvjo/ZLYZZgYwsHMzN3QV1AUqBFL0OD7PsuESSTttPFC5z3RkN72ltrMS25FLKZyfryvQnMUl6qoFzQJozMKzWitqX+V1SEaQScdqYCO23kyun911N/6R9XPGN971pHdHvu2FSeI5btiWBn0enhgnLy45tiiKQ4sQnpiccCT67LUy6FO4phq1I++lpwmtHVg6f/pZ/lsVbHaqNMw3RQA1MMlmEHDPUoIe8VaPplYownqSEfcJuOECxeQn4PockMdXaGsEhPDSfKDyNRKI4iKq/CXFNwl2vaZStYG+Yv2TncbPVbemATu8xIhJXnE0/9z9FTHt1v2q1TWdNXks0nL2doEpGqnivXUhh3dZRm3oSUVzQ/NWX+z87Mi4BSzZ0ruPgiJ+SO27gREeA47KWCNKUKF3PdW97ubCabtGhIxvjcZQ1NUU61pGd52CdV/BOlAzZubXCAS/TsZigcThHG1kcFHVlsriCH00l1bEkHZe1EPoPZsR3XbEp2FP3iOuZ+syEq+2GNIU+bF7k6opt2vNYN5rplx6Gh1y+9kXr3MgTLUJw8N5JJaLxOxe0gVUd0VeS3zzUcWQtTXywOjVunudwlZgIcs38kl13BgrAENM+KLY6jm3fXbK9ECMej2FdTb4XBFoQT/rzQw/pFGtv/lG4cpGvIyxmwqU+TV4Q3Blhoo4G/826+ZoAcQzz6E08ksY/v8if5nL5zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M+0Li1lT8DgX+Ypf/AUlo16ikGXM5DIddUpm/0TqgYFqna4dHvZRsXdyldxXU7LsarIEOeFr3dm8tRewtnn5dsy0QhrgJfnOw+c4goTuFXc/aEXMYbCqb3GhT3a6N/CeuuWzYVuTwpWwwaWltGlxqKDCD6VmmeBPa/GAhUS8UR9d1BpNbO2/4IYvIKJqHjM7+oJFKeK4pdCa+d356dbO+hzvS29mmLdxVPj2VrU84bsqMq7/VVtzu9B2RxszMrU8yT0rnzHlKL6ZB3hRiHATxg68hszuqW9iIzJsWI8Wg/H500DRXvBJPecbJi8LjnN5B7kTgrjj+Fgg+iV0pLMZ3LfYbUeJ6jufSix0nBebBn6vZoyVMgFGUN68JOMEtdOBj9c1O6nzKmBTLLfMkwNHy/wZFRFQ/dYPNgURjjTjL38q92XwM5+rfTHTRb+Y8z8D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:47.7040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be33462-44ca-4f35-6311-08dee2778417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999173
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
Add KUnit coverage for the simple amdgpu_dm IP-block callbacks
(is_idle, wait_for_idle, soft_reset, set_clockgating_state,
set_powergating_state and the bandwidth_update display hook) by
asserting their placeholder return values. Also add the shared test
include block used by the amdgpu_dm test suite.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 +++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 73 +++++++++++++++++++
 3 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cb10c5fa374e..80778d7e7337 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -224,23 +224,26 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 	return 0;
 }
 
-static bool dm_is_idle(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT bool dm_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return true;
 }
+EXPORT_IF_KUNIT(dm_is_idle);
 
-static int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_wait_for_idle);
 
-static int dm_soft_reset(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_soft_reset);
 
 STATIC_IFN_KUNIT bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 						 struct dm_crtc_state *new_state)
@@ -310,17 +313,19 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 					   stream_update);
 }
 
-static int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
-		  enum amd_clockgating_state state)
+STATIC_IFN_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					      enum amd_clockgating_state state)
 {
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_set_clockgating_state);
 
-static int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		  enum amd_powergating_state state)
+STATIC_IFN_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					      enum amd_powergating_state state)
 {
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_set_powergating_state);
 
 /* Prototypes of private functions */
 static int dm_early_init(struct amdgpu_ip_block *ip_block);
@@ -2795,10 +2800,11 @@ static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
  *
  * Calculate and program the display watermarks and line buffer allocation.
  */
-static void dm_bandwidth_update(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void dm_bandwidth_update(struct amdgpu_device *adev)
 {
 	/* TODO: implement later */
 }
+EXPORT_IF_KUNIT(dm_bandwidth_update);
 
 static const struct amdgpu_display_funcs dm_display_funcs = {
 	.bandwidth_update = dm_bandwidth_update, /* called unconditionally */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f753e90bdeda..7bb552d1ddba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1140,6 +1140,15 @@ void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 											   struct dc_sink *sink);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+struct amdgpu_ip_block;
+bool dm_is_idle(struct amdgpu_ip_block *ip_block);
+int dm_wait_for_idle(struct amdgpu_ip_block *ip_block);
+int dm_soft_reset(struct amdgpu_ip_block *ip_block);
+int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+			     enum amd_clockgating_state state);
+int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
+			     enum amd_powergating_state state);
+void dm_bandwidth_update(struct amdgpu_device *adev);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 0b29bf0a7d04..d4e37580316f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -6,10 +6,76 @@
  */
 
 #include <kunit/test.h>
+#include <linux/pci.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_writeback.h>
 
 #include "dc.h"
+#include "inc/core_types.h"
+#include "amd_shared.h"
+#include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
+
+/* Tests for simple DM callbacks */
+
+/**
+ * dm_test_is_idle - Test placeholder idle callback returns true
+ * @test: The KUnit test context
+ */
+static void dm_test_is_idle(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, dm_is_idle(NULL));
+}
+
+/**
+ * dm_test_wait_for_idle - Test placeholder wait-for-idle callback returns success
+ * @test: The KUnit test context
+ */
+static void dm_test_wait_for_idle(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_wait_for_idle(NULL), 0);
+}
+
+/**
+ * dm_test_soft_reset - Test placeholder soft-reset callback returns success
+ * @test: The KUnit test context
+ */
+static void dm_test_soft_reset(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_soft_reset(NULL), 0);
+}
+
+/**
+ * dm_test_set_clockgating_state - Test placeholder clockgating callback returns success
+ * @test: The KUnit test context
+ */
+static void dm_test_set_clockgating_state(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_set_clockgating_state(NULL, AMD_CG_STATE_GATE), 0);
+}
+
+/**
+ * dm_test_set_powergating_state - Test placeholder powergating callback returns success
+ * @test: The KUnit test context
+ */
+static void dm_test_set_powergating_state(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_set_powergating_state(NULL, AMD_PG_STATE_GATE), 0);
+}
+
+/**
+ * dm_test_bandwidth_update - Test placeholder bandwidth update is callable
+ * @test: The KUnit test context
+ */
+static void dm_test_bandwidth_update(struct kunit *test)
+{
+	dm_bandwidth_update(NULL);
+}
 
 /* Tests for dm_plane_layer_index_cmp() */
 
@@ -884,6 +950,13 @@ static void dm_test_master_stream_defaults_to_first(struct kunit *test)
 }
 
 static struct kunit_case amdgpu_dm_tests[] = {
+	/* Simple DM callbacks */
+	KUNIT_CASE(dm_test_is_idle),
+	KUNIT_CASE(dm_test_wait_for_idle),
+	KUNIT_CASE(dm_test_soft_reset),
+	KUNIT_CASE(dm_test_set_clockgating_state),
+	KUNIT_CASE(dm_test_set_powergating_state),
+	KUNIT_CASE(dm_test_bandwidth_update),
 	/* dm_plane_layer_index_cmp */
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_descending),
-- 
2.43.0

