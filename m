Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B6EC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8273510E6F1;
	Wed,  2 Sep 2026 05:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tdFm7yiI";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD9610E6F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfEdCRfSMtUiZCCXKv7NLPDGm/KqoYTkSj8YRZiKmOLUKNiVstoA8y11zDiGSmNZBXji4oHbqJtQbNGa3fjDuxCE9lSIAPdyv9v4B8hJ7TOU63iCKAHhzTwI7RK4fggMQQuK1IvWGylgAlkwfRiJd7yBVQ4YBxYwOGl1Hq5663TXdg/IeGRlKiJhRZKCQyKlKv3psc5Bz+MEAHSyH3X5WhrxatkknszvnC2CmDD39hjvvL6Q/LCLNN78uuHqt6J1ev7MyUtiKSwrdvOLQ+BjLoJ6fLmml2UlaB9PlqNvWVb0vrmASBgdxYac39TzqeNpW0ZrJt/gSmHAFZZl3jAOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRPCWEjGBc6Pm6kbdkbNnH53uIcQ+7a8Z/nHwJHcx3I=;
 b=rdSw5kNxs6F0H0xzk1c/Otmj1cJbf9svdKQPFBKbYbmLhbrEFO/hDyZK2EyfYn9cqjCxFnRPsR1twmmJczNSTyJCzSFjAU6lT66mxv+iQn9KvJ8LargieZi55YmzDr6EBC3IGr9sXelDpj4Wsw8uhjqn5d4ly0v/TUV+jBK7rzvl8cVBZxm+4AkVKyEtx8DHnzwKE+YbPnCjknCu8rpkJPZxJVrWLBHjAj2EIlD+jBYrPinlhoowteKkY6IBJC4uEfWd85rZv/G0KVXQiYFAfvL6Hl0SPqje2Vq5MC7UZE+ZrDv5wDTxCyQxzeO1oyukbv8CJySpu9dU+57xX+Kh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRPCWEjGBc6Pm6kbdkbNnH53uIcQ+7a8Z/nHwJHcx3I=;
 b=tdFm7yiIJ9Qbc5DFdpScEYnwj37zane+tpEQXx7uu4DBqrI2JFhUUKoET97dKUSCwEHievrPbae8JQqlnLKkf68mhR24oGBYK+DmWdcYwy7SQW7PWu7EW7mth4Wz1+YQ7QoaP93IvgOWaeHIAh1MktYd0vyUxqoJNj5lhDRApNA=
Received: from BL1PR13CA0195.namprd13.prod.outlook.com (2603:10b6:208:2be::20)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:05:28 +0000
Received: from BN1PEPF0001854B.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::1) by BL1PR13CA0195.outlook.office365.com
 (2603:10b6:208:2be::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 2
 Sep 2026 05:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0001854B.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:05:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:26 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:05:17 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 07/40] drm/amd/display: Test plane update adapter
Date: Wed, 2 Sep 2026 12:58:29 +0800
Message-ID: <20260902050411.3473916-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854B:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 87356059-f79d-437e-8998-08df08afcde1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l9+ac500v+x5Z5Ps2jlMCPlQC4Ug62Rfnhw/HGXyBC85HwjzK4djQStyE9h7ugXf6bVe9A4VyHzh2IW+1KorLvzGKJNPHTlCDUI97OGuehEEaD94zwri9JzIUfqbJEYthia8yhu+DFQ9ilaa6S8pTqhPnNoMcHOAl8FZ732e/3gVFkEcmKL5ZwMp1g+7el0Iitrx9PCR9OIgMqiFOdTytZge++TSwZBx6WyympKFLceyXpx3/TirfOTkXJ2YtOvdaLSLZaIEXQRphsrGxu9ruDyijPtELpKIBi51dcOfHDCUQJ1QpfbvUychgSso11iZTB14AE/DvbTBdm7S/yRqOAPhA026uQeBtk5xxYsZGO7MsaDeSJUqw4yOsiCcPd/EzKpisqf7s3vIMYBWQe/dvuAvkaWHB/rOc7+olhKmZZeUiddJavwFLAJXRR3144so8p7s44LVf4o6r0I04sgO56vIwAEjQaLGlG9xnPoa8lXLO59FUHM6Fev3evsgLwMBg9xXGaLAJWvVwSWss297/ju+6u90vniash0OQ1T04n4rPDOO705Oa0GZGT4zgxBZ/MvXAotxduXeRl1/jS1s0NqgxY39azUqNiiphH/5saYAi3HZAEG9cMKeTyM6WDdBKgFeX/S9X7wX5po2hvvGzyLe6DpvETDD4XNkMfmnhwCYXu6+E4QuHpV99ZCVjoA7eNvqYwHRtcDS5/EklwE25g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bIizlBgYElBijvBh1dyKgEB97R0dLkTSNSAKmVj+n5oVQVto0jHPMLKcYHkVJIhUrDZ2GYZbTQjVX/1YrOSn3QUBXxShQ7rFeNa4xZL/WyfUa2YRg5MpA8PtpVCSX4BaCIfd1Hhy4Q7o64Kp54ELhcCHUEJKF3M+0GAtEwANvGsfpV0EOxWm0xcG7jg7RU1jQ/LRdgO8ZOwP4fgFDYIylreC7qX02RReT0V65rdXKt8UHTqR60PLyKtKQpkOakwVkuJfDuc1ocXsIZvVUV9APZLzJBGgKyQEuiDdsAvZnF/3jGMahjKYpKay9fU9pGv9rCFPLlvyW2Zj231LUMDo1UaUQC5TMHAyjRQuZDcJ1Zx4fAMmyTpyZRVb4IK9zrsm7Xu7XvAtJtemfhD0FydT64kjkcWZFyZI9cj5PfFKKGvleGaAwKi2zR0oU1P4MQn1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:05:27.5929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87356059-f79d-437e-8998-08df08afcde1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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

[Why]
Add KUnit tests for update_planes_and_stream_adapter() covering
descending plane sorting, argument forwarding, call ordering, and
DC failure propagation.

[How]
Extend the existing DM KUnit ops table with the two DC calls and use
spies to observe inputs and ordering. Reuse one ops installer for the
adapter and MMHUB tests.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 ++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  15 +++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 123 +++++++++++++++++-
 3 files changed, 158 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bd087155aac2..0eb813206837 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -253,6 +253,16 @@ STATIC_IFN_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *b)
 }
 EXPORT_IF_KUNIT(dm_plane_layer_index_cmp);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+static const struct amdgpu_dm_kunit_ops *amdgpu_dm_ops;
+
+#define dm_post_update_surfaces_to_stream	amdgpu_dm_ops->post_update_surfaces_to_stream
+#define dm_update_planes_and_stream		amdgpu_dm_ops->update_planes_and_stream
+#else
+#define dm_post_update_surfaces_to_stream	dc_post_update_surfaces_to_stream
+#define dm_update_planes_and_stream		dc_update_planes_and_stream
+#endif
+
 /**
  * update_planes_and_stream_adapter() - Send planes to be updated in DC
  *
@@ -270,12 +280,13 @@ EXPORT_IF_KUNIT(dm_plane_layer_index_cmp);
  * @array_of_surface_update: dc surface update pointer
  *
  */
-static inline bool update_planes_and_stream_adapter(struct dc *dc,
-						    int update_type,
-						    int planes_count,
-						    struct dc_stream_state *stream,
-						    struct dc_stream_update *stream_update,
-						    struct dc_surface_update *array_of_surface_update)
+STATIC_IFN_KUNIT INLINE_IFN_KUNIT
+bool update_planes_and_stream_adapter(struct dc *dc,
+				      int update_type,
+				      int planes_count,
+				      struct dc_stream_state *stream,
+				      struct dc_stream_update *stream_update,
+				      struct dc_surface_update *array_of_surface_update)
 {
 	sort(array_of_surface_update, planes_count,
 	     sizeof(*array_of_surface_update), dm_plane_layer_index_cmp, NULL);
@@ -283,14 +294,15 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 	/*
 	 * Previous frame finished and HW is ready for optimization.
 	 */
-	dc_post_update_surfaces_to_stream(dc);
+	dm_post_update_surfaces_to_stream(dc);
 
-	return dc_update_planes_and_stream(dc,
+	return dm_update_planes_and_stream(dc,
 					   array_of_surface_update,
 					   planes_count,
 					   stream,
 					   stream_update);
 }
+EXPORT_IF_KUNIT(update_planes_and_stream_adapter);
 
 STATIC_IFN_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_clockgating_state state)
@@ -312,6 +324,9 @@ STATIC_IFN_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block);
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static const struct amdgpu_dm_kunit_ops amdgpu_dm_default_ops = {
 	.gmc_pd_addr = amdgpu_gmc_pd_addr,
+	.post_update_surfaces_to_stream = dc_post_update_surfaces_to_stream,
+	.update_planes_and_stream = dc_update_planes_and_stream,
+	.atomic_helper_suspend = drm_atomic_helper_suspend,
 };
 
 static const struct amdgpu_dm_kunit_ops *amdgpu_dm_ops = &amdgpu_dm_default_ops;
@@ -322,9 +337,11 @@ void amdgpu_dm_kunit_set_ops(const struct amdgpu_dm_kunit_ops *ops)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_kunit_set_ops);
 
-#define dm_gmc_pd_addr		amdgpu_dm_ops->gmc_pd_addr
+#define dm_gmc_pd_addr			amdgpu_dm_ops->gmc_pd_addr
+#define dm_atomic_helper_suspend	amdgpu_dm_ops->atomic_helper_suspend
 #else
-#define dm_gmc_pd_addr		amdgpu_gmc_pd_addr
+#define dm_gmc_pd_addr			amdgpu_gmc_pd_addr
+#define dm_atomic_helper_suspend	drm_atomic_helper_suspend
 #endif
 
 /* Allocate memory for FBC compressed data  */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 645b39e4223b..df2e4d60e85a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -86,7 +86,9 @@ struct dc;
 struct amdgpu_bo;
 struct dmub_srv;
 struct dc_plane_state;
+struct dc_stream_state;
 struct dc_stream_update;
+struct dc_surface_update;
 struct dmub_notification;
 struct dmub_cmd_fused_request;
 
@@ -1215,6 +1217,12 @@ int dm_sw_fini(struct amdgpu_ip_block *ip_block);
 int dm_oem_i2c_hw_init(struct amdgpu_device *adev);
 void dm_gpureset_commit_state(struct dc_state *dc_state, struct amdgpu_display_manager *dm);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
+bool update_planes_and_stream_adapter(struct dc *dc,
+				      int update_type,
+				      int planes_count,
+				      struct dc_stream_state *stream,
+				      struct dc_stream_update *stream_update,
+				      struct dc_surface_update *array_of_surface_update);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
 				enum dc_color_space *color_space);
@@ -1244,6 +1252,13 @@ void amdgpu_dm_services_kunit_set_ops(const struct amdgpu_dm_services_kunit_ops
 
 struct amdgpu_dm_kunit_ops {
 	uint64_t (*gmc_pd_addr)(struct amdgpu_bo *bo);
+	void (*post_update_surfaces_to_stream)(struct dc *dc);
+	bool (*update_planes_and_stream)(struct dc *dc,
+					 struct dc_surface_update *surface_updates,
+					 int surface_count,
+					 struct dc_stream_state *dc_stream,
+					 struct dc_stream_update *stream_update);
+	struct drm_atomic_commit *(*atomic_helper_suspend)(struct drm_device *dev);
 };
 
 void amdgpu_dm_kunit_set_ops(const struct amdgpu_dm_kunit_ops *ops);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 7a79aee057f8..ed53bfa5a8c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -327,6 +327,119 @@ static void dm_test_plane_layer_index_cmp_ascending(struct kunit *test)
 	KUNIT_EXPECT_LT(test, dm_plane_layer_index_cmp(&sa, &sb), 0);
 }
 
+struct dm_test_plane_update_ops_ctx {
+	struct dc *dc;
+	struct dc_surface_update *surface_updates;
+	struct dc_stream_state *stream;
+	struct dc_stream_update *stream_update;
+	int surface_count;
+	unsigned int call_seq;
+	unsigned int post_update_seq;
+	unsigned int update_seq;
+	bool update_ret;
+};
+
+static struct dm_test_plane_update_ops_ctx dm_test_plane_update_ctx;
+
+static void dm_test_post_update_surfaces_to_stream(struct dc *dc)
+{
+	dm_test_plane_update_ctx.dc = dc;
+	dm_test_plane_update_ctx.post_update_seq = ++dm_test_plane_update_ctx.call_seq;
+}
+
+static bool dm_test_update_planes_and_stream(struct dc *dc,
+					     struct dc_surface_update *surface_updates,
+					     int surface_count,
+					     struct dc_stream_state *dc_stream,
+					     struct dc_stream_update *stream_update)
+{
+	dm_test_plane_update_ctx.dc = dc;
+	dm_test_plane_update_ctx.surface_updates = surface_updates;
+	dm_test_plane_update_ctx.surface_count = surface_count;
+	dm_test_plane_update_ctx.stream = dc_stream;
+	dm_test_plane_update_ctx.stream_update = stream_update;
+	dm_test_plane_update_ctx.update_seq = ++dm_test_plane_update_ctx.call_seq;
+
+	return dm_test_plane_update_ctx.update_ret;
+}
+
+static const struct amdgpu_dm_kunit_ops dm_test_plane_update_ops = {
+	.post_update_surfaces_to_stream = dm_test_post_update_surfaces_to_stream,
+	.update_planes_and_stream = dm_test_update_planes_and_stream,
+};
+
+static void dm_test_restore_dm_ops(void *ctx)
+{
+	amdgpu_dm_kunit_set_ops(NULL);
+}
+
+static void dm_test_install_dm_ops(struct kunit *test,
+				   const struct amdgpu_dm_kunit_ops *ops)
+{
+	amdgpu_dm_kunit_set_ops(ops);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_restore_dm_ops, NULL), 0);
+}
+
+/**
+ * dm_test_update_planes_adapter_sorts_and_forwards - Test sorting and call order
+ * @test: The KUnit test context
+ */
+static void dm_test_update_planes_adapter_sorts_and_forwards(struct kunit *test)
+{
+	struct dc_surface_update *updates;
+	struct dc_plane_state *planes;
+	struct dc_stream_update *stream_update;
+	struct dc_stream_state *stream;
+	struct dc *dc;
+
+	updates = kunit_kcalloc(test, 3, sizeof(*updates), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, updates);
+	planes = kunit_kcalloc(test, 3, sizeof(*planes), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, planes);
+	stream_update = kunit_kzalloc(test, sizeof(*stream_update), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream_update);
+	stream = dm_kunit_alloc_stream(test, NULL);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	planes[0].layer_index = 1;
+	planes[1].layer_index = 5;
+	planes[2].layer_index = 3;
+	updates[0].surface = &planes[0];
+	updates[1].surface = &planes[1];
+	updates[2].surface = &planes[2];
+	dm_test_plane_update_ctx = (struct dm_test_plane_update_ops_ctx) {
+		.update_ret = true,
+	};
+	dm_test_install_dm_ops(test, &dm_test_plane_update_ops);
+
+	KUNIT_EXPECT_TRUE(test, update_planes_and_stream_adapter(dc, UPDATE_TYPE_FAST, 3,
+								 stream, stream_update, updates));
+	KUNIT_EXPECT_EQ(test, updates[0].surface->layer_index, 5);
+	KUNIT_EXPECT_EQ(test, updates[1].surface->layer_index, 3);
+	KUNIT_EXPECT_EQ(test, updates[2].surface->layer_index, 1);
+	KUNIT_EXPECT_PTR_EQ(test, dm_test_plane_update_ctx.dc, dc);
+	KUNIT_EXPECT_PTR_EQ(test, dm_test_plane_update_ctx.surface_updates, &updates[0]);
+	KUNIT_EXPECT_EQ(test, dm_test_plane_update_ctx.surface_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, dm_test_plane_update_ctx.stream, stream);
+	KUNIT_EXPECT_PTR_EQ(test, dm_test_plane_update_ctx.stream_update, stream_update);
+	KUNIT_EXPECT_LT(test, dm_test_plane_update_ctx.post_update_seq,
+			dm_test_plane_update_ctx.update_seq);
+}
+
+/**
+ * dm_test_update_planes_adapter_propagates_failure - Test DC failure is returned
+ * @test: The KUnit test context
+ */
+static void dm_test_update_planes_adapter_propagates_failure(struct kunit *test)
+{
+	dm_test_plane_update_ctx = (struct dm_test_plane_update_ops_ctx) { 0 };
+	dm_test_install_dm_ops(test, &dm_test_plane_update_ops);
+
+	KUNIT_EXPECT_FALSE(test, update_planes_and_stream_adapter(NULL, UPDATE_TYPE_FAST, 0,
+								  NULL, NULL, NULL));
+}
+
 /* Tests for fill_plane_color_attributes() */
 
 /**
@@ -3422,11 +3535,6 @@ static const struct amdgpu_dm_kunit_ops dm_test_dm_ops = {
 	.gmc_pd_addr = dm_test_gmc_pd_addr,
 };
 
-static void dm_test_restore_dm_ops(void *ctx)
-{
-	amdgpu_dm_kunit_set_ops(NULL);
-}
-
 /*
  * A device whose AGP aperture is disabled (bot above top), so the frame buffer
  * alone decides the logical address range.
@@ -3435,8 +3543,7 @@ static struct amdgpu_device *dm_test_mmhub_adev(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
 
-	amdgpu_dm_kunit_set_ops(&dm_test_dm_ops);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_restore_dm_ops, NULL), 0);
+	dm_test_install_dm_ops(test, &dm_test_dm_ops);
 
 	adev->gmc.agp_start = 0x2000000;
 	adev->gmc.agp_end = 0x1000000;
@@ -4868,6 +4975,8 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_descending),
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_ascending),
+	KUNIT_CASE(dm_test_update_planes_adapter_sorts_and_forwards),
+	KUNIT_CASE(dm_test_update_planes_adapter_propagates_failure),
 	/* fill_plane_color_attributes */
 	KUNIT_CASE(dm_test_fill_color_attr_rgb_format),
 	KUNIT_CASE(dm_test_fill_color_attr_bt601_full),
-- 
2.43.0

