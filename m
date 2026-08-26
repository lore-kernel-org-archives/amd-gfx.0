Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6E7C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC76D10EE64;
	Wed, 26 Aug 2026 23:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ar+4tUMQ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0960210EE65
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEGbnfAKjj+JH+iYjaKYaHmLNVw7Jm49Blc2aRXPKQNSXdxIRLdFOW+AK8rvPGVbLErMU6YusJ6dwmNRX3sPZ3rDlN+xRxtwGTtAOnKrGeNYdvpFvsNFvkbL0ZkKZtfkx0gzhQfF9VvOHDXnjj9Yvw5obz3Md2K0CJk2nI9jYwxbr/eNX0Hjw7JhHaVrbJNP05BZCGsfiril/BOcriG2ExdyceugUpvWm99Fv+Dx79MtfS397F3nfwbOaTzTn3yxsRU7Qo0Cqu4S8JoJ1gy8lmGGeL522SL7CKrgKjD1ebvyBsZ1+iJ3qMyQw7hWtV3i0RsXjX2JgXeGfQIVl9Fx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr8V9I5p9zJ6RFjPcBCGbNhgNxYQc96FI88n0VvGwLI=;
 b=VQp030CBIsptMZjgNlEUFi4YXnMr46gLmwV6p9+cerKAqJ/BMxKl476UwxwZiNRKCyRZWDg/+AvCf3WWxHYpUvIcEx4s2s7GKrNOBtQeSgMluhrLQGdMnNab+YSFDDe51BQmkvi0BYdVMy8SN8bxBSzfHbSmcmrBQNAfJzbuI3o0qMJIzpdUsuUcvEhJAAKM2PoireDxmQJnYhOhq5uxDsJO2LqtPtu4NJL5Obc7ZbB+uGFIgMvhGi6ZQ1Z5cWxiKTXzXV66ekVgrjEqZBlyE4jaI5YsDWX5ypb3qDhQtcJkxPg93X+z/4MZWbgldQuBmA0AtvUcP0pailtsUToXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr8V9I5p9zJ6RFjPcBCGbNhgNxYQc96FI88n0VvGwLI=;
 b=Ar+4tUMQfyCj8kjK/xySdPbCKwJ5Z6FLx424TQjl+SKGMZ6HO7DZRMkk6z4dtT++l1s0LEMBbNT5eGAv+Hb82EbNCP+iPzygjmC+HU/SLkbOm8cnvldmrVUn3rO6RQBTerWe1ZywyyQW7Ggym6fTy+0GxhYnFKB2YxKQc6lAOhc=
Received: from SA0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:806:130::12)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 26 Aug
 2026 23:33:06 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::91) by SA0PR13CA0007.outlook.office365.com
 (2603:10b6:806:130::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:33:04 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:32:59 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 51/59] drm/amd/display: Test mode and plane init
Date: Wed, 26 Aug 2026 17:05:22 -0600
Message-ID: <20260826231519.881949-52-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b41d9a0-cdf0-4099-e838-08df03ca6041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wdpkQJ5WNy941dKVwAgAf6Ye0z4/C9yq3dOHgXGLg1cL3oRT/e+F5bCyOEIV5m1SlmuaxqMwK7oXZTcEZvhtyhtcMHwjEJk5rF69TbDZu/WYRsxYwbFZ8hXfWWtGG39tFhHTVlLPJ33Y+vTIheBOz7Gk4AmH2asAUzcoPPCumALwIBT5wE4PESN7FgNAaminVzmXwJaYo07PlJdB6+zGqb801Ek5dE6mEyip+I7eTDikLoj3jE8lw4CBrimsXHg56E3BGLOUXLaD7lTv38Ewzw51wct34kRlrzFuNzzJwiOpC8q+EfVQOfOLsH9iM3P/GcPnDVnkC6/1c1P+O+jjKVsuwYgpqkY11p56LH1shDTHoLW2yJzR8OxIUHYRjpvqrcKGBSurOmXJvua1R93Xua6hE5UElzPOLm5GKjt+tgtaTCU1Tli1VRLL5tS3eRXWALx6ZECzLqsV9svSkKQTPTRYppi5nHvwconBuL6i3a1vfqMvNgC/AB0R5mljSau9gJhBKn+cmD5OCvq7Zq3Jd99PBn5zQuTPG4xaR5nIRap051KCS0pCBPO8Sanyr30Pdl6G2EXAb/CMRwWI+n6U3DkwZYvOxpQdcIdC2oKppcYnO8HK9mKT/ABFH6Nz7f1IKZ9g4jJ+Ft96vMOHkLOLRougBvxmRu/wzaU3IwFfXgH1/JglLVAf22sIZge9MKc5ycj5mPXvK8OxJ+t8lIjX1A==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CwqRMN6FcuJqNm+pJR7LIU8XX/Rqow+KnqcioOtoynisLwmoJUwk4ePEwlFnKvJVyEvwALBMbktwn/ttVYmffBud/zWcGdtRiTygb4oJtFKsIN12zo3s7KlRz+CFGq8ttyAO5vL2pGdSBMImu6pOL0VDDUm0c3MFRJGog1KeDGQWPMsjASK12XChuCIbjdaciuaz9YMbadtNiSh9EOKcqws9iwRk7o+X7/d3KbJ7Hfv0iaAzIla5Z3x4mN5B7/6r4ZMR9NXz1AbDkFZc3QwMGJVUUOHbqoMFVOqRgRm0A8rgydk6mkWOCvQG6uPkSpu63OlSOWCpzmpLpeZcIi28aOzCIboa4Mm0FA1VKWX4j2hCNezjLo+J9ZTavcZseuDWx5VnQ6/sOcvrRtacnNFs2ZDvpSqz56US2OqHiZ7aLktSivmt9IjkbOOuA5CosfTt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:33:04.1883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b41d9a0-cdf0-4099-e838-08df03ca6041
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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

[WHAT]
Add KUnit tests for amdgpu_dm_mode_config_init() and initialize_plane(),
covering the mode config defaults, the Hawaii preferred shadow quirk,
the DM private object state, and primary and overlay plane creation.

[HOW]
drm_atomic_private_obj_init() builds the private state through
dm_atomic_create_state(), so a current DC state is enough to exercise
it. Audio is disabled for the duration of the test so no audio component
is left registered on the mock device.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 132 ++++++++++++++++++
 3 files changed, 144 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0393ec122f26..cd9f44326ae3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2253,7 +2253,7 @@ static struct drm_private_state_funcs dm_atomic_state_funcs = {
 	.atomic_destroy_state = dm_atomic_destroy_state,
 };
 
-static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 {
 	int r;
 
@@ -2293,11 +2293,12 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_mode_config_init);
 
-static int initialize_plane(struct amdgpu_display_manager *dm,
-			    struct amdgpu_mode_info *mode_info, int plane_id,
-			    enum drm_plane_type plane_type,
-			    const struct dc_plane_cap *plane_cap)
+STATIC_IFN_KUNIT int initialize_plane(struct amdgpu_display_manager *dm,
+				      struct amdgpu_mode_info *mode_info, int plane_id,
+				      enum drm_plane_type plane_type,
+				      const struct dc_plane_cap *plane_cap)
 {
 	struct drm_plane *plane;
 	unsigned long possible_crtcs;
@@ -2333,6 +2334,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(initialize_plane);
 
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c662c39416d8..19c6b29947f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1249,6 +1249,7 @@ struct amdgpu_dm_kunit_ops {
 void amdgpu_dm_kunit_set_ops(const struct amdgpu_dm_kunit_ops *ops);
 
 struct dc_phy_addr_space_config;
+struct dc_plane_cap;
 
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
@@ -1256,6 +1257,10 @@ int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 int load_dmcu_fw(struct amdgpu_device *adev);
 int dm_sw_init(struct amdgpu_ip_block *ip_block);
 int dm_late_init(struct amdgpu_ip_block *ip_block);
+int amdgpu_dm_mode_config_init(struct amdgpu_device *adev);
+int initialize_plane(struct amdgpu_display_manager *dm, struct amdgpu_mode_info *mode_info,
+		     int plane_id, enum drm_plane_type plane_type,
+		     const struct dc_plane_cap *plane_cap);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 432e4cd2803d..58472b4d5388 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -31,6 +31,7 @@
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_audio.h"
 #include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 
@@ -3785,6 +3786,131 @@ static void dm_test_late_init_boot_crc_disabled(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.boot_time_crc_info.bo_ptr);
 }
 
+/* Tests for amdgpu_dm_mode_config_init() */
+
+static void dm_test_fini_atomic_obj(void *ctx)
+{
+	drm_atomic_private_obj_fini(ctx);
+}
+
+static void dm_test_restore_audio_param(void *ctx)
+{
+	amdgpu_dm_audio_set_param((long)ctx);
+}
+
+/*
+ * A device ready for mode config init: DM creates its private object state
+ * from the current DC state, and audio is disabled so no audio component is
+ * left registered on the mock device.
+ */
+static struct amdgpu_device *dm_test_mode_config_adev(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	long saved_audio = amdgpu_dm_audio_get_param();
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	adev->dm.dc->current_state = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc->current_state);
+
+	amdgpu_dm_audio_set_param(0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_restore_audio_param,
+							(void *)saved_audio), 0);
+
+	return adev;
+}
+
+/**
+ * dm_test_mode_config_init - Test the mode config and DM private object are set up
+ * @test: The KUnit test context
+ */
+static void dm_test_mode_config_init(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_mode_config_adev(test);
+	struct dm_atomic_state *dm_state;
+
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_mode_config_init(adev), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_fini_atomic_obj,
+							&adev->dm.atomic_obj), 0);
+
+	KUNIT_EXPECT_TRUE(test, adev->mode_info.mode_config_initialized);
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.max_width, 16384);
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.max_height, 16384);
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.preferred_depth, 24);
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.prefer_shadow, 1);
+	KUNIT_EXPECT_TRUE(test, adev->ddev.mode_config.async_page_flip);
+
+	/* drm_atomic_private_obj_init() creates the state through DM. */
+	dm_state = to_dm_atomic_state(adev->dm.atomic_obj.state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	KUNIT_EXPECT_NOT_NULL(test, dm_state->context);
+}
+
+/**
+ * dm_test_mode_config_init_hawaii - Test Hawaii disables the preferred shadow
+ * @test: The KUnit test context
+ */
+static void dm_test_mode_config_init_hawaii(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_mode_config_adev(test);
+
+	adev->asic_type = CHIP_HAWAII;
+
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_mode_config_init(adev), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_fini_atomic_obj,
+							&adev->dm.atomic_obj), 0);
+
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.prefer_shadow, 0);
+}
+
+/* Tests for initialize_plane() */
+
+/**
+ * dm_test_initialize_plane_primary - Test a primary plane is stored in mode info
+ * @test: The KUnit test context
+ */
+static void dm_test_initialize_plane_primary(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->dm.adev = adev;
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	adev->dm.dc->caps.max_streams = 1;
+
+	KUNIT_ASSERT_EQ(test, initialize_plane(&adev->dm, mode_info, 0,
+					       DRM_PLANE_TYPE_PRIMARY, NULL), 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, mode_info->planes[0]);
+	KUNIT_EXPECT_EQ(test, (int)mode_info->planes[0]->type,
+			(int)DRM_PLANE_TYPE_PRIMARY);
+	KUNIT_EXPECT_EQ(test, mode_info->planes[0]->possible_crtcs, 1U);
+}
+
+/**
+ * dm_test_initialize_plane_overlay - Test an overlay plane can target any CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_initialize_plane_overlay(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_plane_cap *plane_cap;
+
+	plane_cap = kunit_kzalloc(test, sizeof(*plane_cap), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane_cap);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->dm.adev = adev;
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	adev->dm.dc->caps.max_streams = 1;
+	plane_cap->per_pixel_alpha = true;
+	plane_cap->pixel_format_support.nv12 = true;
+
+	/* Plane id at or above max_streams is never a primary, so any CRTC works. */
+	KUNIT_ASSERT_EQ(test, initialize_plane(&adev->dm, NULL, 1,
+					       DRM_PLANE_TYPE_OVERLAY, plane_cap), 0);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3978,6 +4104,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_late_init_no_dmcu),
 	KUNIT_CASE(dm_test_late_init_boot_crc_no_dmub),
 	KUNIT_CASE(dm_test_late_init_boot_crc_disabled),
+	/* amdgpu_dm_mode_config_init */
+	KUNIT_CASE(dm_test_mode_config_init),
+	KUNIT_CASE(dm_test_mode_config_init_hawaii),
+	/* initialize_plane */
+	KUNIT_CASE(dm_test_initialize_plane_primary),
+	KUNIT_CASE(dm_test_initialize_plane_overlay),
 	{}
 };
 
-- 
2.43.0

