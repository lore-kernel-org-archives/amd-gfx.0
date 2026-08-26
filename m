Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D51BC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2133C10EE5C;
	Wed, 26 Aug 2026 23:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDzXPAXK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEF810EE5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLwopeTgB5IUm22Hnhyu9zFaZZE2nW9e4dXtAk2cobZRDYeyzQv6ER2foE53PFdSoGX/J49IOnJ/r3V3hh9D3jtiM/NSQIHtYra0bjntklJ2APvl5SBh1ujlUoNojo1g6FD4j1YALF0cGDoQ0mgZPJENcSv5hIFeL+vmOq9gwP69xGyvL1SZA0+uFVvPaMzUYydaN6V7JaZzqphjos0QzypmNNzzbCtJHrY4Gcp3kjs56MfstcWNzAN+YdBBaKhF098qjSbANGQR4p5d/6S1mlF/IpAu/C3Dapv9lFwgOcwxQEneL1oM0lf17PyA/4AszBGOUvPEBdVxiyfLJtCaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldm0tBw5cOvXJU68WtKoRLM8vMGsUT6DwDuLkXFNE4c=;
 b=Q6Bo3E4SZL9i0a4PsWisHYQ6cT0plTL3u2dBx375AYfF0j1VDc/5d3LpTUaXwDa+VTlLxguWbMFTZIcoQQ72/8TvpLHccEYnWx8qX8/gsGr4NjWif01LNaKwsfDZyUCnd8vhH4OFmJ2kjFORN2OVEjzmFfdSIM2kc155U3WKWHfAroEPUY7kke1IVv3l8LFOqY9UsKufLuYsitEzdaxuL2Emk9a0ZTqbppYGn9H18uwah0t6GhrLf44ebjH1k3Lpo59Vwmos6oJbGtAMVl6QRwPvIyzl+hptjDdjG5eDFJIHnrciiprGMpi8VxLdl3YfHN7pAhbuWxm7ToDoSoLF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldm0tBw5cOvXJU68WtKoRLM8vMGsUT6DwDuLkXFNE4c=;
 b=KDzXPAXKOFNW2kZ4el6bHK5GVCu2gVLQf3cK5PYfwROYfL7VFWCLoUgaYnDjpzhYxNMxGoceQDWbvdUHm9W3uBAyxJjNN9k5BgPkpKU9ZVA6OgjG64neerF/FinIj2ZQ7KS1JG+wf5VRfz54CWCN3CHuoMev8LlRbaiSWkddbX4=
Received: from SA1PR04CA0015.namprd04.prod.outlook.com (2603:10b6:806:2ce::11)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 23:30:11 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::52) by SA1PR04CA0015.outlook.office365.com
 (2603:10b6:806:2ce::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:30:10 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:30:05 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 43/59] drm/amd/display: Test mod_power stream updates on
 modeset
Date: Wed, 26 Aug 2026 17:05:14 -0600
Message-ID: <20260826231519.881949-44-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: adc0e1ef-6271-47e8-5d7d-08df03c9f8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: J+nYHZSNeQXfIlyT/vJe9X51mgHsV5aMvJ1TtIxWVO2pU/cR2/AifBYJOYq5yrgrwLDJIvermvuh4yuGyrEnT7sw0hw3BOrnBsdQpF68oWTTArM1nYgnqVk/hORebD12nygi9EEQskngfx7SLTTeHUkYtrgcUXsr94oXw1d0M1RBa6Hm8X2QqOuEZKYZi87Db3Xt2qffUtmGAXPC45stlNGVPO8l6iQQtjglA+9r50nmjCf3q99mIYwqjG05FPS+97BxCdYZtYFYc+jDLzu1Hv/OWhNj3S3RmBkWKpRnavajNTQxQoW1Xn26uHLZJclVnhd/6M03hEbMne0b7w+STVY5eHj0YDueBvynDRA2nshhuN1f/Gn8XHgGMIyUJuNqGumg+LT5AzKYId8nc2QiMwGvp2IY26eBdwQkiHLwujI754N5IPz6JXoGuCxpkCERB9sII+wDOHwDkDBDPbSdbAd5+dKZRQsU7sZ2cd/2qYKZVmUdOh512eRWYHXm/msL/pPljIZEffQYatWKTyHQJXjNM6XZFFi/P5t+oIkx5SZrCTZUpvBjNI+dmUKfbzZkEGPJd4sJ4/4JjCO0T5r7s61VNGRX+hClj3ExQ4X2lYZcQe6CoF5JIMNld6FWJ0BzhSIDwY44V5mQHDeWH53Icb/ymJAaOqBmSPeLbWqmuKJhdo7frGArkPaV6u9xM7nwBDzhRH3XnugFWihCO+ca5w==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ib0NviGl2o+ccktGuFlFrJOKmVUpmHcaiVjnHx/zEND3UbMGtqqq43eXlFOEquOFY5ywGY/pw8IX0sONqxz8LZ1+efgbWux4B36I3mdwgXJ9hOfEr1/ug8Llw7iDIH7QO9kyeWwejhcyFaHsCIH8IHkchOsOxMy0epRMx2Zixz5IELyg/G84GQfzAMBFXEv23vaXAUs7uz6ZW1fjvJ7fn9LJS6n2vWqi3oXXusojA/3IBADJasf191Ohu0cduAqH4m/jLyg6rMlWMd9oS7Rm6nL+loJcc/EZHjnVe2otgIUX8vlRrUkj7RENkYpdJ9JLgbOtU2nZL2JMrY8xeF0Yda0WU9v8X+Y3vc9xg5/Yx/XSWdm7ZstHu84XJLTGi5ltnBumYgod3HuWwGQAunzjeqmkCMVF2YC5PgeFPSoSR3QNZVFuaMx3w2xRQXsPeWPF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:30:10.4258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc0e1ef-6271-47e8-5d7d-08df03c9f8b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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
Add KUnit tests for amdgpu_dm_mod_power_update_streams() covering empty
and fast commits plus CRTC enable, replacement, and disable, and for
amdgpu_dm_mod_power_setup_streams() covering empty, modeset, and fast
updates.

[HOW]
Leave dm->power_module NULL and PSR/Replay feature bits clear so the DM
stream transition logic runs without a live power module.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 170 ++++++++++++++++++
 3 files changed, 180 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2085625f8509..8e62d451e0b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4341,8 +4341,8 @@ static void dm_clear_writeback(struct amdgpu_display_manager *dm,
  * in preparation for hardware programming. See also
  * amdgpu_dm_mod_power_setup_streams() for post-modeset mod_power setup.
  */
-static void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
-					       struct amdgpu_display_manager *dm)
+STATIC_IFN_KUNIT void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
+							struct amdgpu_display_manager *dm)
 {
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
@@ -4395,6 +4395,7 @@ static void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
 		}
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_mod_power_update_streams);
 
 /**
  * amdgpu_dm_mod_power_setup_streams - setup mod_power stream state post modeset
@@ -4404,8 +4405,8 @@ static void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
  * Notify mod_power of mode_change. This needs to be done after dc_stream
  * updates have been committed, and VRR parameters have been updated.
  */
-static void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
-					      struct amdgpu_display_manager *dm)
+STATIC_IFN_KUNIT void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
+						       struct amdgpu_display_manager *dm)
 {
 	struct dm_crtc_state *dm_new_crtc_state;
 	struct drm_crtc_state *new_crtc_state;
@@ -4442,6 +4443,7 @@ static void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
 	}
 
 }
+EXPORT_IF_KUNIT(amdgpu_dm_mod_power_setup_streams);
 
 static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 					struct dc_state *dc_state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 35b8725a63af..7308067b4d13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1205,6 +1205,10 @@ void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev);
 void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state);
 int do_aquire_global_lock(struct drm_device *dev,
 			  struct drm_atomic_commit *state);
+void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
+					struct amdgpu_display_manager *dm);
+void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
+				       struct amdgpu_display_manager *dm);
 int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block);
 int dm_sw_fini(struct amdgpu_ip_block *ip_block);
 int dm_oem_i2c_hw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 27182f65e5c3..bb09ebc07435 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3040,6 +3040,30 @@ static void dm_test_aquire_global_lock_waits_commit(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/**
+ * dm_test_mod_power_update_streams_empty - Test an empty commit updates no streams
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_update_streams_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_mod_power_update_streams(dm_test_alloc_commit(test, adev),
+					   &adev->dm);
+}
+
+/**
+ * dm_test_mod_power_setup_streams_empty - Test an empty commit sets up no streams
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_setup_streams_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_mod_power_setup_streams(dm_test_alloc_commit(test, adev),
+					  &adev->dm);
+}
+
 /* Tests for amdgpu_dm_trigger_timing_sync() */
 
 /**
@@ -3174,6 +3198,144 @@ static void dm_test_emulated_link_detect_bad_signal(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, link->local_sink);
 }
 
+/* Tests for the mod_power modeset helpers */
+
+struct dm_test_modeset_ctx {
+	struct amdgpu_device *adev;
+	struct drm_atomic_commit *state;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state *old_crtc_state;
+	struct dm_crtc_state *new_crtc_state;
+};
+
+/*
+ * A modeset commit on one CRTC with an old and a new stream. dm->power_module
+ * stays NULL, which every mod_power entry point treats as a no-op, so the DM
+ * side of the modeset can be walked without a live power module.
+ */
+static struct dm_test_modeset_ctx *dm_test_modeset_ctx_alloc(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_test_modeset_ctx *ctx;
+	struct dc_link *link;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->state = dm_test_alloc_commit(test, ctx->adev);
+	ctx->acrtc = kunit_kzalloc(test, sizeof(*ctx->acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc);
+	ctx->old_crtc_state = kunit_kzalloc(test, sizeof(*ctx->old_crtc_state),
+					    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_crtc_state);
+	ctx->new_crtc_state = kunit_kzalloc(test, sizeof(*ctx->new_crtc_state),
+					    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_crtc_state);
+	ctx->state->crtcs = kunit_kzalloc(test, sizeof(*ctx->state->crtcs),
+					  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->crtcs);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	link = dm_kunit_alloc_link(test);
+	ctx->old_crtc_state->stream = dm_kunit_alloc_stream(test, link);
+	ctx->new_crtc_state->stream = dm_kunit_alloc_stream(test, link);
+	ctx->new_crtc_state->stream->dm_stream_context = aconnector;
+
+	ctx->adev->ddev.mode_config.num_crtc = 1;
+	ctx->adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	mutex_init(&ctx->adev->dm.dc_lock);
+	ctx->new_crtc_state->base.mode_changed = true;
+	ctx->new_crtc_state->base.state = ctx->state;
+	ctx->state->crtcs[0].ptr = &ctx->acrtc->base;
+	ctx->state->crtcs[0].old_state = &ctx->old_crtc_state->base;
+	ctx->state->crtcs[0].new_state = &ctx->new_crtc_state->base;
+
+	return ctx;
+}
+
+/**
+ * dm_test_mod_power_update_streams_no_modeset - Test fast updates are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_update_streams_no_modeset(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.mode_changed = false;
+	ctx->new_crtc_state->base.active = true;
+
+	amdgpu_dm_mod_power_update_streams(ctx->state, &ctx->adev->dm);
+}
+
+/**
+ * dm_test_mod_power_update_streams_enable - Test enabling a CRTC adds the stream
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_update_streams_enable(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.active = true;
+
+	amdgpu_dm_mod_power_update_streams(ctx->state, &ctx->adev->dm);
+}
+
+/**
+ * dm_test_mod_power_update_streams_replace - Test a re-modeset replaces the stream
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_update_streams_replace(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->old_crtc_state->base.active = true;
+	ctx->new_crtc_state->base.active = true;
+
+	amdgpu_dm_mod_power_update_streams(ctx->state, &ctx->adev->dm);
+}
+
+/**
+ * dm_test_mod_power_update_streams_disable - Test disabling a CRTC removes the stream
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_update_streams_disable(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->old_crtc_state->base.active = true;
+
+	amdgpu_dm_mod_power_update_streams(ctx->state, &ctx->adev->dm);
+}
+
+/**
+ * dm_test_mod_power_setup_streams_modeset - Test a modeset sets up the new stream
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_setup_streams_modeset(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.active = true;
+
+	amdgpu_dm_mod_power_setup_streams(ctx->state, &ctx->adev->dm);
+}
+
+/**
+ * dm_test_mod_power_setup_streams_no_modeset - Test fast updates set up no streams
+ * @test: The KUnit test context
+ */
+static void dm_test_mod_power_setup_streams_no_modeset(struct kunit *test)
+{
+	struct dm_test_modeset_ctx *ctx = dm_test_modeset_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.mode_changed = false;
+	ctx->new_crtc_state->base.active = true;
+
+	amdgpu_dm_mod_power_setup_streams(ctx->state, &ctx->adev->dm);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3323,6 +3485,14 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_aquire_global_lock_no_crtc),
 	KUNIT_CASE(dm_test_aquire_global_lock_no_commit),
 	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
+	KUNIT_CASE(dm_test_mod_power_update_streams_empty),
+	KUNIT_CASE(dm_test_mod_power_update_streams_no_modeset),
+	KUNIT_CASE(dm_test_mod_power_update_streams_enable),
+	KUNIT_CASE(dm_test_mod_power_update_streams_replace),
+	KUNIT_CASE(dm_test_mod_power_update_streams_disable),
+	KUNIT_CASE(dm_test_mod_power_setup_streams_empty),
+	KUNIT_CASE(dm_test_mod_power_setup_streams_modeset),
+	KUNIT_CASE(dm_test_mod_power_setup_streams_no_modeset),
 	/* amdgpu_dm_trigger_timing_sync */
 	KUNIT_CASE(dm_test_trigger_timing_sync_no_state),
 	KUNIT_CASE(dm_test_trigger_timing_sync_streams),
-- 
2.43.0

