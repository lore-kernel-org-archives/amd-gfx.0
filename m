Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC361C4450F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D11D10F08C;
	Wed, 15 Jul 2026 13:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgbIQ+y5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D5E10F08C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjFXX+CbvG3nKAybKrBCUdAxMs1lnGecLSKRHhhnNjjs83exYSZz2Fa2jAqrvXdukcHjX8Jvf82oI9uvxAAzDvUu+ie9lua7RnMk0RvkI6/ZPCibNRLT631AsPzV7y5FQE54Gm+9xC+Om2SvUf9r9IWH2gtzDiwpWRedY7rmtp46zu0gnCa/5/FvSO9XC1xY0Ygb22YL7LSrrwHXE/iV2x6dtCczcW5Q1MbvdiQXimDbdv6HCV5YTy8Vg/FPPdIlT+4wmQxDYV2OpWh4USigVOHDu5MnUOYiM0s0DfLAUFyT6U28I6FnLvMG5iFyO+hTCllqdh3oSX6DRQr+wqy5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSPYxSRFsTgNEyez7C55FyNiZe+jup9y+AvEY1qGJ6o=;
 b=vT2HGYZ3GXrkV6ak5C2a+s1A4bkqssmMLNWS64Iy5MuTfurB1AWo6KCASjWkqG5hPyN7SNshe4tdVly19IdS1eu05Jxqf0Mr24OoGekrxgEVmb/25lg5IFmhU3KgAS3rmtcodIsfKb5scoJSyTGCdlmul70/WBNJPdhyYfBmKfRBVsMzFTnGQzCdoLNOIXAAj/bPMwRdJ2qOgUSV+bmQMnLV95a8FJ+OFO21acn8UbJFvRGse1wcINAnB2DhEfaaPx4/S1Jym/V89UlDHG4YePhCir4t4LWSr83+yXm+gI5XJg1cc29T7CrnbI4FopjNkPC4z3pdxlmncWYGUzW6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSPYxSRFsTgNEyez7C55FyNiZe+jup9y+AvEY1qGJ6o=;
 b=lgbIQ+y5keIYkTsEnnpqGjo6RyyWPsIgUQRf6cjB+yKqZp2Gp886Dy6YXOal/EOL5HkSSWyXAH0/Fvhg9zDi9voRD/l8jU0rQzetRPm5EWagp8h/CEDKT17zcc8pTbukxuUg01dnlcMiXTXJs3ufSKmPgMdE0dkTtKvqpkp/Yyc=
Received: from PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::27)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:46:58 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::8f) by PH0P220CA0029.outlook.office365.com
 (2603:10b6:510:d3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:54 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 32/70] drm/amd/display: add KUnit tests for DM atomic state
 helpers
Date: Wed, 15 Jul 2026 21:37:42 +0800
Message-ID: <20260715134432.1975118-33-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: a0517888-f45f-4f0c-8760-08dee2778852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|22082099003|18002099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: NH3Sik8OpdKoIvMgEz/zpAHSvP4KpZ5apO1eT6s6PksIdJrTwrbP2JLWebbYzLGSSti0wYvwc1q6T2v+f/3R7CfU0XhJvMkhfydUIQSyVkk2cx2YvzSrwMxEjN3zX0cM32ynwc1XTZh2wczKgGD4JLJy1jFJdtLh0W+NoeDzqZbOogQrsLSDMtFVQ65YJSi6zi3C9MEWYCtGnnrtghRuVhLadbHoFn1BpNug39b7hTe6URTt0dOUD6NCecl0w04kwMpX6PhjCPs8a/Flckv5hdv0HQojf6U37c//0TemYdiQaGCUFJyQ6o5Fz2g5U9vvG6kpCEqUYdmLF27kQPca+j6BWWwUnZH9n3khyb5JILb8jNrKw8vylmbnE9co8WUvVrsh4kRHx1t9qRnNLTKSi3H7Nt0J22k1/ogIdd0fBdoxbKCJCBTVrQhDtuJtvHFILQcGPMSQ9IHfEbhSYi0yoBhm0RHn/D5P636x++ooRCqBqmvkJRmx+tV4fniXq5Agmdnx5dquURTqIVliSPlZ1+zJkPn3nPRQ/RFGcewIXhKEBFihRx2Er32PrAB+eILF5RoZOTpCn9O/VzAIKIfmkX24Vk/ZR9RkDBfw659VS8NXBysLT2oVNPt27ujCrFHOjiSeoISPvHi9RTWAIbgvVFkYmOr/X2ZTKN+ZKCVpXzTSkLRyoTVwBYr8JcLHYEqEXTPHVashLKqohVN6yrk2iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7HD2iA0//Urex2bDJmiRdd7I6erSDjIVoWIYs0AtKmINyLe/MEDJnvwJ/CgGgyQM6Lp795r2JTh36naBKEfxyETSq//EESqpgc465NQ/i/g+EluwGapUDSGhZy8xUkdwZjsHj+cVwJ54YxeQEuPpSZJvRWtL65wteJz2Gc8pFxOUSdLP2Pc1uj17+V+YJfp3YJs02kcL4Xm3SgEg3aKSfVsJKdpFZ1Hj6IPzQH9Jkr/KMJARxluZX880di4VppdYOgF1lfHJ0DLXVJSv9c07oR3FBahe8TI1eASX6T/tUcZmaVeUzaOTGrw8YVfvEyoO2qmdgyd1Ozm4Dbnmi1sgHZ27VUUc1Wy84eoPwPOZxqHhL8Tjuxpb5w/IpM0WnO9PyidED5jmvWkLefaqE3N/7Ea5sAsgMV1y+vSq/tt/uuTk8LbqmKDxfnCQi0zTVLFU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:54.8408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0517888-f45f-4f0c-8760-08dee2778852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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
Add KUnit tests for the DM atomic private-state accessors
(dm_atomic_get_new_state, dm_atomic_destroy_state), the native
cursor-mode selector (dm_should_update_native_cursor) and
amdgpu_dm_smu_write_watermarks_table. Cover the empty and matching
private-object lookups, the NULL-context destroy path, the NULL,
native and overlay cursor-mode paths, and the non-Navi1x watermark
table early return.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  20 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 155 ++++++++++++++++++
 3 files changed, 175 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b60d7343dec..7806b3405c3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1404,7 +1404,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 	drm_connector_list_iter_end(&iter);
 }
 
-static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
@@ -1454,6 +1454,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_smu_write_watermarks_table);
 
 static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 {
@@ -2285,7 +2286,7 @@ int dm_atomic_get_state(struct drm_atomic_state *state,
 	return 0;
 }
 
-static struct dm_atomic_state *
+STATIC_IFN_KUNIT struct dm_atomic_state *
 dm_atomic_get_new_state(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
@@ -2302,6 +2303,7 @@ dm_atomic_get_new_state(struct drm_atomic_state *state)
 
 	return NULL;
 }
+EXPORT_IF_KUNIT(dm_atomic_get_new_state);
 
 static struct drm_private_state *
 dm_atomic_duplicate_state(struct drm_private_obj *obj)
@@ -2327,8 +2329,8 @@ dm_atomic_duplicate_state(struct drm_private_obj *obj)
 	return &new_state->base;
 }
 
-static void dm_atomic_destroy_state(struct drm_private_obj *obj,
-				    struct drm_private_state *state)
+STATIC_IFN_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
+					      struct drm_private_state *state)
 {
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(state);
 
@@ -2337,6 +2339,7 @@ static void dm_atomic_destroy_state(struct drm_private_obj *obj,
 
 	kfree(dm_state);
 }
+EXPORT_IF_KUNIT(dm_atomic_destroy_state);
 
 static struct drm_private_state_funcs dm_atomic_state_funcs = {
 	.atomic_duplicate_state = dm_atomic_duplicate_state,
@@ -6360,10 +6363,10 @@ static int dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
 	return 0;
 }
 
-static bool dm_should_update_native_cursor(struct drm_atomic_state *state,
-					   struct drm_crtc *old_plane_crtc,
-					   struct drm_crtc *new_plane_crtc,
-					   bool enable)
+STATIC_IFN_KUNIT bool dm_should_update_native_cursor(struct drm_atomic_state *state,
+						     struct drm_crtc *old_plane_crtc,
+						     struct drm_crtc *new_plane_crtc,
+						     bool enable)
 {
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
@@ -6388,6 +6391,7 @@ static bool dm_should_update_native_cursor(struct drm_atomic_state *state,
 		return dm_new_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
 	}
 }
+EXPORT_IF_KUNIT(dm_should_update_native_cursor);
 
 static int dm_update_plane_state(struct dc *dc,
 				 struct drm_atomic_state *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index cbe95fb3c0d6..bef9663caf6e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1152,6 +1152,14 @@ void dm_bandwidth_update(struct amdgpu_device *adev);
 u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc);
 int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 			   u32 *vbl, u32 *position);
+struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_state *state);
+void dm_atomic_destroy_state(struct drm_private_obj *obj,
+			     struct drm_private_state *state);
+int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev);
+bool dm_should_update_native_cursor(struct drm_atomic_state *state,
+				    struct drm_crtc *old_plane_crtc,
+				    struct drm_crtc *new_plane_crtc,
+				    bool enable);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 7b92078d95bc..92056f4147d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -183,6 +183,154 @@ static void dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, position, 0U);
 }
 
+/**
+ * dm_test_atomic_get_new_state_empty - Test empty atomic state has no DM state
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_get_new_state_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	state->dev = &adev->ddev;
+
+	KUNIT_EXPECT_NULL(test, dm_atomic_get_new_state(state));
+}
+
+/**
+ * dm_test_atomic_get_new_state_match - Test atomic state returns matching DM private state
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_get_new_state_match(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dm_atomic_state *dm_state;
+	struct drm_atomic_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	state->private_objs = kunit_kzalloc(test, sizeof(*state->private_objs),
+					    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->private_objs);
+
+	state->dev = &adev->ddev;
+	state->num_private_objs = 1;
+	state->private_objs[0].ptr = &adev->dm.atomic_obj;
+	state->private_objs[0].new_state = &dm_state->base;
+
+	KUNIT_EXPECT_PTR_EQ(test, dm_atomic_get_new_state(state), dm_state);
+}
+
+/**
+ * dm_test_should_update_native_cursor_without_crtc - Test NULL crtc cases update native cursor
+ * @test: The KUnit test context
+ */
+static void dm_test_should_update_native_cursor_without_crtc(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, dm_should_update_native_cursor(NULL, NULL, NULL, false));
+	KUNIT_EXPECT_TRUE(test, dm_should_update_native_cursor(NULL, NULL, NULL, true));
+}
+
+/**
+ * dm_test_should_update_native_cursor_disable_native - Test disable path reads old crtc cursor mode
+ * @test: The KUnit test context
+ */
+static void dm_test_should_update_native_cursor_disable_native(struct kunit *test)
+{
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_state *state;
+	struct drm_crtc *crtc;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
+
+	crtc->index = 0;
+	dm_crtc_state->cursor_mode = DM_CURSOR_NATIVE_MODE;
+	state->crtcs[0].old_state = &dm_crtc_state->base;
+
+	KUNIT_EXPECT_TRUE(test,
+			  dm_should_update_native_cursor(state, crtc, NULL, false));
+}
+
+/**
+ * dm_test_should_update_native_cursor_enable_overlay - Test enable path reads new crtc cursor mode
+ * @test: The KUnit test context
+ */
+static void dm_test_should_update_native_cursor_enable_overlay(struct kunit *test)
+{
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_state *state;
+	struct drm_crtc *crtc;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
+
+	crtc->index = 0;
+	dm_crtc_state->cursor_mode = DM_CURSOR_OVERLAY_MODE;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	KUNIT_EXPECT_FALSE(test,
+			   dm_should_update_native_cursor(state, NULL, crtc, true));
+}
+
+/**
+ * dm_test_atomic_destroy_state_no_context - Test destroying DM atomic state without a DC context
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_destroy_state_no_context(struct kunit *test)
+{
+	struct dm_atomic_state *dm_state;
+
+	/*
+	 * Use kzalloc(), not kunit_kzalloc(): dm_atomic_destroy_state() frees
+	 * the state itself, so KUnit-managed memory would be double-freed.
+	 */
+	dm_state = kzalloc(sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	/* context == NULL: dc_state_release() is skipped and the state is freed. */
+	dm_atomic_destroy_state(NULL, &dm_state->base);
+}
+
+/**
+ * dm_test_smu_write_watermarks_table_default - Test watermarks table skips non-Navi1x IP versions
+ * @test: The KUnit test context
+ */
+static void dm_test_smu_write_watermarks_table_default(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	/*
+	 * A zeroed adev reports DCE IP version 0, which is not one of the
+	 * Navi1x versions handled by the switch, so the function returns early.
+	 */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_smu_write_watermarks_table(adev), 0);
+}
+
 /* Tests for dm_plane_layer_index_cmp() */
 
 /**
@@ -1069,6 +1217,13 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_vblank_get_counter_no_stream),
 	KUNIT_CASE(dm_test_crtc_get_scanoutpos_invalid_crtc),
 	KUNIT_CASE(dm_test_crtc_get_scanoutpos_no_stream),
+	KUNIT_CASE(dm_test_atomic_get_new_state_empty),
+	KUNIT_CASE(dm_test_atomic_get_new_state_match),
+	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
+	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
+	KUNIT_CASE(dm_test_should_update_native_cursor_enable_overlay),
+	KUNIT_CASE(dm_test_atomic_destroy_state_no_context),
+	KUNIT_CASE(dm_test_smu_write_watermarks_table_default),
 	/* dm_plane_layer_index_cmp */
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_descending),
-- 
2.43.0

