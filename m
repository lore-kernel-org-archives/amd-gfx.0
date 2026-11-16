Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1D606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qh+34KVc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5863810F832;
	Tue, 17 Nov 2026 17:13:51 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A740510F81F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3AF2jfQcCYCk8Jq7eHxvSCesqyG0Ilb7n13yksOfDBpvKsWsktPK9SPP0WWbAYza1NN5S7JrQtQKYVaoQ45eCEVjseGkdLB6qUC3hjQD7zwkmlZiyb6HG1XiCEPc3CshT/duoatTAI3ObS/QsZz5JM9VcuiEzPw1Vkd6630AcTKWFuHHRpQaonMvzrT2QjCFg8dkIijPwny/OYJ9NI4oUfib6hx5KdkpC8bkxkHmlEG+FfcvizsaIHzv3kP+gLHuiK+rjVM8NWBqTxWH1rfOZAOtko9H+h0IWsHRFuW0PWkXn6qfLotOoryTey1OyR+FtXzn48zBjZ8YaPE7wypVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+JELtKHFsZOfLmYb/TGCFenyk+GYOLYF9VeIbdKpUw=;
 b=Q6WwRpyIS7lfaoJbiXinMiJYPnlTDwRbYiyL8SdoUxA6DDxkkd389mhyDQssnPPhVhmch5Qy3qqzBAco8DK1n7NjaLZQ9VBNTcQ6bZuU5qzmVbhi6e746SHbIm+XbL9hob2ysHZZxodD3VAN30ZJxoJJ5SqekxFvz2mDKhmym7GeLxJ8KHEFh2dyKf9X7ti9x8fR7dTxLR1eloXAwHpMJCTPm9aEgJyN/uTUlPTgS11y29Hw7Z9ORRqRhbJ+ch0c2oa4aPRAKha1qDnkskrjTcwjbKaxxVVVORYST4XhXIVkdCaxZabc1BZs6jmyOdJvSngJq6pDxxMJpEDBlQ8rkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+JELtKHFsZOfLmYb/TGCFenyk+GYOLYF9VeIbdKpUw=;
 b=Qh+34KVczGDrfO7CDz5dkvK3ppBCp1p2B0xF0D+pICpNj/FAuQBqHdZ/zI6RFqSdTpaAXnIwusnG9a2o9XxVPt4YmKkzE9dS3eH7/Pea4gjm2u6bRiHt1gllGzySdi4QPo22XWwPEAwdr7jp6lzuinAM8ynrfaTLgdXNYTS8HUM=
Received: from SJ0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:a03:3a0::31)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:13:40 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::54) by SJ0PR03CA0266.outlook.office365.com
 (2603:10b6:a03:3a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:13:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:13:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:13:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:13:15 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:13:01 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 07/33] drm/amd/display: Use panel luminance range for AUX
 backlight in power module
Date: Tue, 17 Nov 2026 05:50:44 +0800
Message-ID: <20261116215641.2800595-8-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c05160a-a2d5-4aa0-9686-08df44ce1f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|18002099003|261009223027099003|22082099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: oWJJ+p36dmwRqn2mjt/d+E46UUgcQv2lfIar6b5V3IFbiO/G06ec4iZTY+WLu89HpWUtC2Qy42iXZISiy2u6/4VRzPme2zE/IclaGP5NQPsDD033AG2uMUYPdCRd5kfekW8f7kYXy93ttPBsMggeo5f/BG5dgQ9MNgfUQRJBoLneiFrkiaNofKJpCxNmr3Kb+/4rTY0+Ps59qdt9iJtc31EU1xKfloUFhhKAcN0RMtxLtdI2toZSxYmzeqBqWRTJdk4DwI2Y6SScaBDd2EFhkc+DrOamkbr4FekrVBpQ9yURBgTDKGdq33MpwV4GGtC5guyW86XCg7p6UZpHIy/3rv9z0TgTrKHgqgyU69rheul3kWp4Ju5hICLuufhp/sL3jUj8x3IgmKRUlkTNgiYnfo47fc0lvMvxNImJYDQdRj8VDhRIVjSbRHLW1XxsZ5wIHoyKd0rl2AvzQIun7MhSFha0aFWRuUEVSCzPNOBJR3GqpbIUj9HwIf6Qo8qOBUZ0Wo2TZPq2vyOqSB7b/FYvz59Yfm0CA9rHidR0Jny57qDj7nISpfyOGAiLBt9FRZBnxRXsMMPmUK9JNvP113ZQPta9XYQW5BMa2epwZuPOQGzZOQaiQcpjDTY8FHLZxaUdK2m5z5GSeSV75MCQ9zjS72Y+glaw0otVXgNFgnzjB5sDLtlBcJ5i/+G28nO4iKj3fjTo4dsCCoY6kk/tGwcGyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(261009223027099003)(22082099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5cu8Iv85qq4+Uw88bsC7tmmJKnSE5T/Rrmr2kwcl0jr80/dPLQUZFrA/WZ2rGnA7nWHeHPwITrLiD68S0aOoTKAxWMa90LCqjD9KV6q0Ktk7tEdP3BkjPof0NR+m3VSilQWxGpZuVYX1/PdywuK5h46ZUAgG+ldjhQMNdOxkjIfTFMFq+W2pkSQm8jrYefvaeXosIpjPWyqG8h+YhVF9j6+IsFKKimxayHRzWc64MHhgSf9FF3JQHfWYQHD/1li405NI4fC3L32OZG6dHjcK0FnveiTEDDTS7icGgCUWCzayG73ebcF0oklrbtyJ16y5EIN/6VpH9XjeGcur+iHWi6QALklpnq5RI6Lm5Vz9VxqTfu4msgLhRQ7xlAVbRcqea6qruufRYYEEB7U3KqGV1r+4lT2cxF7+DrU1CTjyAxBJqqM9m42EfjWvt1kUEAvZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:13:39.2479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c05160a-a2d5-4aa0-9686-08df44ce1f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ray Wu <ray.wu@amd.com>

[Why & How]
The power module always gets the default 1..270 nits range, so VESA
AUX panels with DMUB aux_backlight_support are capped at 270 nits. For
AUX backlight panels, pass the EDID derived aux_min/max_input_signal
to the power module, and add KUnit cases for it.

Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 73 +++++++++++++++++++
 3 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a7c2b0094944..2f4c6a2dd4ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -417,6 +417,22 @@ STATIC_IFN_KUNIT void mmhub_read_system_context(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(mmhub_read_system_context);
 
+STATIC_IFN_KUNIT void
+amdgpu_dm_fill_power_nits_range(const struct amdgpu_dm_backlight_caps *caps,
+				struct mod_power_init_params *init_data)
+{
+	init_data->use_nits_based_brightness = false;
+	init_data->panel_max_millinits = 0;
+	init_data->panel_min_millinits = 0;
+	if (caps->aux_support &&
+	    caps->aux_max_input_signal > caps->aux_min_input_signal) {
+		init_data->use_nits_based_brightness = true;
+		init_data->panel_max_millinits = caps->aux_max_input_signal * 1000;
+		init_data->panel_min_millinits = caps->aux_min_input_signal * 1000;
+	}
+}
+EXPORT_IF_KUNIT(amdgpu_dm_fill_power_nits_range);
+
 STATIC_IFN_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 {
 	struct mod_power_init_params init_data[MAX_NUM_EDP];
@@ -441,9 +457,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *
 		init_data[i].def_varibright_level = 0;
 		init_data[i].abm_config_setting = 0;
 		init_data[i].num_backlight_levels = 101;
-		init_data[i].use_nits_based_brightness = false;
-		init_data[i].panel_max_millinits = 0;
-		init_data[i].panel_min_millinits = 0;
+		amdgpu_dm_fill_power_nits_range(&dm->backlight_caps[i], &init_data[i]);
 		init_data[i].disable_fractional_pwm =
 			!(amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK);
 		init_data[i].use_custom_backlight_caps = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f8503ebf28f4..761d2b40aece 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1346,9 +1346,12 @@ struct dc_plane_address;
 struct dc_plane_cap;
 struct dc_plane_info;
 struct dsc_mst_fairness_vars;
+struct mod_power_init_params;
 
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
+void amdgpu_dm_fill_power_nits_range(const struct amdgpu_dm_backlight_caps *caps,
+				     struct mod_power_init_params *init_data);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev, struct dc_state *state, bool enable);
 enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index b9272b28f53c..a7618473e207 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -37,6 +37,7 @@
 #include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_mst_types.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
+#include "mod_power.h"
 
 /* Tests for simple DM callbacks */
 
@@ -3802,6 +3803,74 @@ static void dm_test_init_power_module_alloc_failure(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.power_module);
 }
 
+/* Tests for amdgpu_dm_fill_power_nits_range() */
+
+/**
+ * dm_test_fill_power_nits_range_aux - Test AUX passes the panel nits range
+ * @test: The KUnit test context
+ *
+ * The power module sends max_brightness_millinits to DMUB, which scales the
+ * VESA AUX level with it, so it must be the panel range and not 270 nits
+ */
+static void dm_test_fill_power_nits_range_aux(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {
+		.aux_support = true,
+		.aux_min_input_signal = 1,
+		.aux_max_input_signal = 500,
+	};
+	struct mod_power_init_params init_data;
+
+	memset(&init_data, 0xff, sizeof(init_data));
+	amdgpu_dm_fill_power_nits_range(&caps, &init_data);
+
+	KUNIT_EXPECT_TRUE(test, init_data.use_nits_based_brightness);
+	KUNIT_EXPECT_EQ(test, init_data.panel_min_millinits, 1000U);
+	KUNIT_EXPECT_EQ(test, init_data.panel_max_millinits, 500000U);
+}
+
+/**
+ * dm_test_fill_power_nits_range_aux_bad_range - Test a bad AUX range keeps the default
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_power_nits_range_aux_bad_range(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {
+		.aux_support = true,
+		.aux_min_input_signal = 500,
+		.aux_max_input_signal = 500,
+	};
+	struct mod_power_init_params init_data;
+
+	memset(&init_data, 0xff, sizeof(init_data));
+	amdgpu_dm_fill_power_nits_range(&caps, &init_data);
+
+	KUNIT_EXPECT_FALSE(test, init_data.use_nits_based_brightness);
+	KUNIT_EXPECT_EQ(test, init_data.panel_min_millinits, 0U);
+	KUNIT_EXPECT_EQ(test, init_data.panel_max_millinits, 0U);
+}
+
+/**
+ * dm_test_fill_power_nits_range_pwm - Test PWM keeps the default nits range
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_power_nits_range_pwm(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {
+		.aux_support = false,
+		.aux_min_input_signal = 1,
+		.aux_max_input_signal = 500,
+	};
+	struct mod_power_init_params init_data;
+
+	memset(&init_data, 0xff, sizeof(init_data));
+	amdgpu_dm_fill_power_nits_range(&caps, &init_data);
+
+	KUNIT_EXPECT_FALSE(test, init_data.use_nits_based_brightness);
+	KUNIT_EXPECT_EQ(test, init_data.panel_min_millinits, 0U);
+	KUNIT_EXPECT_EQ(test, init_data.panel_max_millinits, 0U);
+}
+
 /* Tests for fill_dc_plane_info_and_addr() */
 
 struct dm_test_plane_info_ctx {
@@ -5390,6 +5459,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* amdgpu_dm_init_power_module */
 	KUNIT_CASE(dm_test_init_power_module_no_edp),
 	KUNIT_CASE(dm_test_init_power_module_alloc_failure),
+	/* amdgpu_dm_fill_power_nits_range */
+	KUNIT_CASE(dm_test_fill_power_nits_range_aux),
+	KUNIT_CASE(dm_test_fill_power_nits_range_aux_bad_range),
+	KUNIT_CASE(dm_test_fill_power_nits_range_pwm),
 	/* fill_dc_plane_info_and_addr */
 	KUNIT_CASE(dm_test_plane_info_graphics_formats),
 	KUNIT_CASE(dm_test_plane_info_video_formats),
-- 
2.43.0

