Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C734BC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5240710EE5B;
	Wed, 26 Aug 2026 23:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d1XwzJP2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1195A10EE5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPcjDuOKaRg4GUgKxHMBTqlzv0iCMs1SNF5VPhg3Lzh+7ivtO80yXmm4qh7m1+i9rYitgO5ir4lwODptiHUMts/hKxIvOJsDi2/o3SklFebX9+TLtziyHqEZCI1dWG59Xy24oo+7UB1SKkcr7BmZocThEq4N4sCgtIvnjkD9B460f7TD9674gHxfxO1yl9edbE4H1f2gghxEWCyxrjD9Wb/3CRV1MzYfeY6pRbBfREbrAvRpJCrgPvLhHj9v9f+qS8l5n8F7Kb4XhBEuZvJpDhcf1jOcoBtuXK8ESoRBNb5RxTIupook1x+3r32smrzGTjPZyvjOL7mjVr9/FlvX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljmKsngu9WrLT8SvoB9bwxksDcE+cad7UC5bJ+B+da4=;
 b=Slshvuf6uG91WfSaLdh3piZOcoDP3CnFejCG47Knew1sxYHFrt/o9ZsDulEsla3s9FexmkBwyEVMO+84ThWJKx82fIaK2zxbBQV3mi7PAXsphUmL45Gauq+lyRvXjMp4nDrS9oORHI98DH0ABNar+diMLzba0oIh36WNFm5SCJHx4yf80Mnv2vpIDS44S0VYB+XDghkTuwKhkSh4qb8y9KxFgskSPPr6M/xj2Lhwr5gECimQHofmn7qFy4k3A5JKx1ueQiSGfiJzg6cGQ56brIO5bL6AZdUTB8d9TUmeErKxjNlkIY2VwnMCYvcMDcL3go2aoB6A826jrpCt+liAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljmKsngu9WrLT8SvoB9bwxksDcE+cad7UC5bJ+B+da4=;
 b=d1XwzJP2zG6ZouH+JSg/T14facNmbGnH20kavYVjPdtnlVEWW11elxf9M2N4Ioclhfp6jbVSFLO5n5Zw8emlH6SUqQjpzYBsJL9ZUlqTp0jjY57liKfZTpe8pCifDTHQTI9F24Lf0S2wiTjiyDzaVJWZtz1Auga5GOwU3WtFYDE=
Received: from SA0PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:d3::16)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 23:29:52 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::4f) by SA0PR11CA0011.outlook.office365.com
 (2603:10b6:806:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:29:52 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:29:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 42/59] drm/amd/display: Test IP block teardown and link
 emulation
Date: Wed, 26 Aug 2026 17:05:13 -0600
Message-ID: <20260826231519.881949-43-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e40019-a219-4efe-baae-08df03c9edf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 53DmErAWZ96hLUv9tgLzFogloMgAUl/C1bcp1GEc0PKJx7tHsJdTkTSfbehbUrhu6jBdhWpcr+Ds70XREjVHOVrAPYWwZBBbf8222p3uhPLyrVIXft8SCfaczKZ8+LeV4ILk9VW19pMh3TsH9wK4P8v3VrtRnVrcgro3Wu0vo5YZK54VtJ7zNckkFG3/LHVRySOXrIosLHFljLAMk2Cwk5af77/4wSDXHZXV106cNnpE5dzcsFuTcnbLyllgVozHgryqmvlvnU9Nhb7WkORzH/7ciFnN99r04J8E2Yafbrty9DAn61IfXg85I2koyBMv4BmhWNIjzrlvOpuFZVM/D6wdv7lOEe6YbFuapAGXtk2i0DV7MkA97bgLgCagJ0GSSt3kSvuvB043FZf1/278YR8v4BeiTtajxgUyyLmEjANxm7VK/cerJ1uAvhjoW+XUMQJzwLf3+eFaqgxlf7t2Tjc0HvUl9hWl5rORfty2fynaeCsp6iVqGx3U9Rc3zwM6RLsSRoIY4xlHqFXp/mlOVXvKA+kdNYmgM941E1rzUWNHoYuS+OkYmGWcHpittD0OotOj43RxMFmXTIKAbq8hFRtfiA6WCBZapDcyPrIM3uJHUGi8zmelFK5l0qg4Ex85rJDRDGOKwO1ppx0088XcYskohkp9xPnDIX03ktKjvQUrnxBQLrHvPOHojhgy7OrfNZZnI5ABXQjlXKCBQLut9Q==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V+oWSlkL7rUu3CZC+dzi7Au/Ge0JInJk04s+ofxgE6hX0zmkILsb1MrNhqLHlV4nDC3x7Q8ODzP/FuToPgWKYF7qgio2HZYxfizNWG9Aye2aWGWscgvkfGuQhTUNnUmfewBvNK80eofMeURRiRJbGzmoEvRphSlc+EyNxj/hIXsP8UqQmaS0ryK45XaM5OnDOr7GkllUmxSWRdHDNd361UY5B8jwjNcZlysZbgr5cbsa8iS3d89vjR5GkEnRueoP+TX9ZfcBV5ZAvChIO8A9FFaa801Hhf/bQdfwjwXgGPtaPgQ2XH9g9YleIwVNXn+Y5N/jFxDwIsPNt7QEaWEsyjr2xsUbmIb9wdkIjv2OBNeOhAgbHg7xlzUzCC8qbKAvCCw7tLQziGcKDMGaDPS2csD7SMAOeKqw/EunIJpknL/oFG045beYkLlSa/Oup2h0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:29:52.4224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e40019-a219-4efe-baae-08df03c9edf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820
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
Add KUnit tests for amdgpu_dm_early_fini() with audio never enabled, for
dm_sw_fini() releasing the DMUB software state, for dm_oem_i2c_hw_init()
when the resource pool has no OEM device, for dm_gpureset_commit_state()
with an empty DC state, and for amdgpu_dm_emulated_link_detect() rejecting
an unknown connector signal.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 86 +++++++++++++++++++
 3 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 13afd787c1b4..2085625f8509 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -830,7 +830,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	return -EINVAL;
 }
 
-static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -838,6 +838,7 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_early_fini);
 
 static void amdgpu_dm_fini(struct amdgpu_device *adev)
 {
@@ -1078,7 +1079,7 @@ static int dm_sw_init(struct amdgpu_ip_block *ip_block)
 	return load_dmcu_fw(adev);
 }
 
-static int dm_sw_fini(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct dal_allocation *da;
@@ -1108,6 +1109,7 @@ static int dm_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_sw_fini);
 
 
 static void amdgpu_dm_boot_time_crc_init(struct amdgpu_device *adev)
@@ -1302,7 +1304,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 	drm_connector_list_iter_end(&iter);
 }
 
-static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct amdgpu_i2c_adapter *oem_i2c;
@@ -1328,6 +1330,7 @@ static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_oem_i2c_hw_init);
 
 /**
  * dm_hw_init() - Initialize DC device
@@ -1710,9 +1713,10 @@ void amdgpu_dm_emulated_link_detect(struct dc_link *link)
 		drm_err(dev, "Failed to read EDID\n");
 
 }
+EXPORT_IF_KUNIT(amdgpu_dm_emulated_link_detect);
 
-static void dm_gpureset_commit_state(struct dc_state *dc_state,
-				     struct amdgpu_display_manager *dm)
+STATIC_IFN_KUNIT void dm_gpureset_commit_state(struct dc_state *dc_state,
+					       struct amdgpu_display_manager *dm)
 {
 	struct {
 		struct dc_surface_update surface_updates[MAX_SURFACES];
@@ -1748,6 +1752,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 					 bundle->surface_updates);
 	}
 }
+EXPORT_IF_KUNIT(dm_gpureset_commit_state);
 
 void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 											   struct dc_sink *sink)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index cec86779b959..35b8725a63af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1205,6 +1205,10 @@ void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev);
 void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state);
 int do_aquire_global_lock(struct drm_device *dev,
 			  struct drm_atomic_commit *state);
+int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block);
+int dm_sw_fini(struct amdgpu_ip_block *ip_block);
+int dm_oem_i2c_hw_init(struct amdgpu_device *adev);
+void dm_gpureset_commit_state(struct dc_state *dc_state, struct amdgpu_display_manager *dm);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index f5c054422346..27182f65e5c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3094,6 +3094,86 @@ static void dm_test_acpi_phy_transition_interlock(struct kunit *test)
 	dm_acpi_process_phy_transition_interlock(NULL, params);
 }
 
+/**
+ * dm_test_early_fini_audio_disabled - Test early fini with audio never enabled
+ * @test: The KUnit test context
+ */
+static void dm_test_early_fini_audio_disabled(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_ip_block ip_block = { .adev = adev };
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_early_fini(&ip_block), 0);
+}
+
+/**
+ * dm_test_sw_fini_releases_state - Test sw fini drops the DMUB software state
+ * @test: The KUnit test context
+ */
+static void dm_test_sw_fini_releases_state(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_ip_block ip_block = { .adev = adev };
+
+	INIT_LIST_HEAD(&adev->dm.da_list);
+	adev->dm.dmub_fb_info = kzalloc_obj(*adev->dm.dmub_fb_info);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dmub_fb_info);
+
+	KUNIT_EXPECT_EQ(test, dm_sw_fini(&ip_block), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.dmub_fb_info);
+}
+
+/**
+ * dm_test_oem_i2c_hw_init_no_device - Test no OEM I2C device leaves the bus unset
+ * @test: The KUnit test context
+ */
+static void dm_test_oem_i2c_hw_init_no_device(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	dc->res_pool = kunit_kzalloc(test, sizeof(*dc->res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc->res_pool);
+	adev->dm.dc = dc;
+
+	KUNIT_EXPECT_EQ(test, dm_oem_i2c_hw_init(adev), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.oem_i2c);
+}
+
+/**
+ * dm_test_gpureset_commit_state_no_streams - Test an empty DC state programs nothing
+ * @test: The KUnit test context
+ */
+static void dm_test_gpureset_commit_state_no_streams(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_state *context = dm_kunit_alloc_dc_state(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, context);
+	adev->dm.ddev = &adev->ddev;
+
+	dm_gpureset_commit_state(context, &adev->dm);
+}
+
+/**
+ * dm_test_emulated_link_detect_bad_signal - Test an unknown connector signal is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_emulated_link_detect_bad_signal(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_link *link = dm_kunit_alloc_link_with_ctx(test);
+
+	link->ctx->driver_context = adev;
+	link->type = dc_connection_single;
+	link->connector_signal = SIGNAL_TYPE_VIRTUAL;
+
+	amdgpu_dm_emulated_link_detect(link);
+
+	KUNIT_EXPECT_EQ(test, (int)link->type, (int)dc_connection_none);
+	KUNIT_EXPECT_NULL(test, link->local_sink);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3248,6 +3328,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_trigger_timing_sync_streams),
 	/* dm_acpi_process_phy_transition_interlock */
 	KUNIT_CASE(dm_test_acpi_phy_transition_interlock),
+	/* IP block lifecycle helpers */
+	KUNIT_CASE(dm_test_early_fini_audio_disabled),
+	KUNIT_CASE(dm_test_sw_fini_releases_state),
+	KUNIT_CASE(dm_test_oem_i2c_hw_init_no_device),
+	KUNIT_CASE(dm_test_gpureset_commit_state_no_streams),
+	KUNIT_CASE(dm_test_emulated_link_detect_bad_signal),
 	{}
 };
 
-- 
2.43.0

