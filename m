Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382D606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PpAcC9bE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918D410F8AE;
	Tue, 27 Oct 2026 23:25:29 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27B910F8AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vskBzxPW4toPaQ7vCt1AdHEtARYeonqK3s7E8pmlcbE/KeKffRRMfUxzS0gPU3qMjauVJVMUpW17ODKlB64CHtrJqe6/xSuJrAyOD5nN95QLaarYTq4zEGpE0iEKa0afle1O7kDj0RrfioTFU9z1aSltLqgFi6fVG9MQ0HSuaFxChGziVuFUfdg8F6P+stxvvkrWztZLfdRyfv+BVrPv4kv7ywfPaSPoN1QDQDr0Gu/y+HiqCbFzL2V0YrIEem4RJXg5BddXObt5usI3e6+8BW/mRw8XtiZ0x5cowGIdIDJQX+bkTmh9Gsgyh0ugDcSiB+sOsRGaKv7C1ZWRgMQddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3rWxfxFOV4Yrc6UpL25hV3azWY5V++1kWYNmnabm7o=;
 b=UfX67txnNXDrMDA4Z304DS9W3c+DcuMNnt4xOTqTv6ECO/XokZLU9NCenGU7kTfbCIGlu1KaRSCg875XQ+vhe0r/YhCzp/Sr73wMEVky6Sj8L2edgnH4WUVPq/MyQ19A2hh1crDYO4C7yHp3H0nx89AWAKx7bJYa3vqS785JjLU31/y1YDjyLkl5Rj5DSk2DTdxwCTpsCuimmg+G/HUV2xGpZ50BXRpmcclamIH/S6HpjFz5Y6wHW3Ip+bcgsPn6LkOmqk9P9dXYuTfPxSvE01D3DRbif052z82k0K1dzj4lQy/4piYqzgWfna3PJUqSA5RDYU7Fb/YKMcxoFCiMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3rWxfxFOV4Yrc6UpL25hV3azWY5V++1kWYNmnabm7o=;
 b=PpAcC9bEd3DSBxNWpp1cF7KPLHsBGejW9nci0CWkmtS9Z2fmsjgEr8kqWp1SWq64P9h+NBv2OCwPMhB0mx5pEb0u9lZfgpl3cKH3KYAcSzF3OwI45xCLxnEs6BECtxvK4Beqoc0C/Ve9s0Sn40kVz3zVE5cVQHl0mCtJ9SjiiCE=
Received: from CH2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:59::24)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:25:19 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::aa) by CH2PR03CA0014.outlook.office365.com
 (2603:10b6:610:59::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:25:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:25:18 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:25:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 22/28] drm/amd/display: Add more backlight Kunit tests
Date: Tue, 27 Oct 2026 17:17:18 -0600
Message-ID: <20261027232005.2879750-23-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5b8a72-4a9b-4c90-c7e1-08df34819072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|261026121527099003|261026135527099003|10067099003|261021133027099003|11063799006|56012099006|261021121427099003|261022113327099003|261021130227099003|261022105027099003|261022075727099003|261009223027099003|261021135927099003|261021123027099003|261022115727099003|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: +FVucCV4PBYqK9WRCpal55NlSXtYGf08YYuSSstJNeWopm+zRtgTzsUdZb9BzZ8I0E06ZD6w7LpsPZe2ypbE2AoFQC7ZWMOyv8mrxjlzQvXgI1t4OvHsj4RZ8zK91N2/nwPFYkSNpC4Da28KQzEaaMZWpycXBkoCHsnfdy0IrYNuU7uqYstQ6HQ5n5Lii8zf+VCcLJmKm5ahAu07SmsXWMBKS1zySdiGaOi4JjErt03ThEnl024EabBk9Kr0mQTglLe6vTR2Ts46nyz+ymKBwgKyK3aVSCHlMrsGP5cK3Ske+BG2bHux5Qcm51Jun06jZC2JR04Pkp2jBGhch/qkZWQIf4e6RabwI5V80US3CDlmM06XLM81W/PNrJa1e5kR6vv0b7bDzLcDYPC4nkkQvNgPxLgAIdJkyBeC2ubTXFDUJvEUsB9KI9fcB0NwG43lRibmvlvhxKpkOYxbFZ9+eb8tyeKdLa59HdMVlOpHtJ8EwevESIu7qs1vSKJtp+HUr7/aEgIvsk/dCD8Ooi0KvW1upc6EgtHwn/Cm6lD9PJ2roZlbm28VOE/2sM3kzhMRBF+TwHlemvF9QWJ+J4/pUBXmXZAFIBi+KsLiSLUhVWBHSB50EhGWvlWWS3HgScAr0v024e7Hd6GIx2noFdabd/FRwnYSA5eIFEuaL141b448Bkjn33NyI3MNjBpnNIwfsbWMyzVFgQ9EQmzS+xu4og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(261026121527099003)(261026135527099003)(10067099003)(261021133027099003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261021130227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261021135927099003)(261021123027099003)(261022115727099003)(261026140227099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rmXLZDzEMoq7J3C8Ly4YY/tpTxZC0FHss81PFCuuMrk+0N24+fdnr0SSa2uJ+/+JUKJWyDAbOw+9r2/+LHvId+m4028OG95hbicd6d5CarHAuW/2QheHXBcAmLr6mlUH95PBivp9oCnxU2vjgIj9fXDxIL1utqku7kooHOchN98+2vPDmzkAVxewtMMnysEn2VWCz75n+WR8vgL+znjWG8oJMWAJUQinUBxBvffx4idbrc2qZ393F2ode6dqokHZ0f9Q8zDD1IVG4QfkQCybpZ/WBi6wSoHUVVYZAI0TqFTF8DTdRhbYkzlWIr6m/sD7rX3aU5IupgVCdOvgPqdhe3BlcYbJTngH6pRB0dOwsFtfGR4c72chcP61Nf96+qTQ8oElELAdwfUvJuusQ1j6kN9h8BNCtfG32zkDo6uyWTDueKMTvhmRNhj+xy1YAks5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:25:18.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5b8a72-4a9b-4c90-c7e1-08df34819072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[WHAT]
Add KUnit tests for amdgpu_dm_backlight.c:
- amdgpu_dm_backlight_set_level(): the PWM custom luminance curve
  (below, between and above the data points, and a zero-width last
  segment) and the DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE bypass.
- amdgpu_dm_register_backlight_device(): the non-linear backlight
  scale and a hardware readback that differs from the initial
  brightness.
- amdgpu_dm_update_connector_ext_caps(): VESA AUX backlight control
  when the panel reports DPCD panel luminance control.

[HOW]
Extend the existing PWM set_level test with a table of data point
counts and brightness values, then repeat the call with the debug
mask set. Add a register test with one curve data point that reuses
the mid backlight level fake. Re-run the OLED ext_caps test with
panel_luminance_control set.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../tests/amdgpu_dm_backlight_test.c          | 79 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index c6d15fb8ad98..a60c0fbf519d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -197,12 +197,25 @@ static void dm_test_backlight_set_level_aux_programs_power_module(struct kunit *
  *
  * With aux_support cleared, set_level() takes the millipercent branch:
  * get_brightness_range() + mod_power_set_backlight_percent(). A NULL
- * power_module keeps the call a safe early-false.
+ * power_module keeps the call a safe early-false. The cases walk each segment of
+ * the custom luminance curve; DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE then bypasses it.
  */
 static void dm_test_backlight_set_level_pwm_programs_power_module(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data curve[] = {
+		{ .input_signal = 50, .luminance = 10 },
+		{ .input_signal = 100, .luminance = 40 },
+		{ .input_signal = 200, .luminance = 80 },
+		{ .input_signal = 255, .luminance = 90 },
+	};
+	/* { data_points, brightness }: no curve, below/between/above points, zero-width end */
+	static const u32 cases[][2] = {
+		{ 0, 2000 }, { 3, 0 }, { 3, 38550 }, { 3, 65535 }, { 4, 65535 },
+	};
 	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
 	struct dc_link *link = dm_kunit_alloc_link(test);
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+	int i;
 
 	setup_test_dm_ddev(test, dm);
 	mutex_init(&dm->dc_lock);
@@ -212,10 +225,20 @@ static void dm_test_backlight_set_level_pwm_programs_power_module(struct kunit *
 	dm->backlight_caps[1].aux_support = false;
 	dm->backlight_caps[1].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	dm->backlight_caps[1].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	memcpy(dm->backlight_caps[1].luminance_data, curve, sizeof(curve));
 	dm->backlight_link[1] = link;
 	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 0, link);
 
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		dm->backlight_caps[1].data_points = cases[i][0];
+		amdgpu_dm_backlight_set_level(dm, 1, cases[i][1]);
+		KUNIT_EXPECT_EQ_MSG(test, dm->brightness[1], cases[i][1], "case %d", i);
+	}
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
 	amdgpu_dm_backlight_set_level(dm, 1, 2000);
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
 
 	KUNIT_EXPECT_EQ(test, dm->brightness[1], 2000U);
 	KUNIT_EXPECT_EQ(test, dm->actual_brightness[1], 0U);
@@ -514,6 +537,54 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
 			adev->dm.backlight_dev[0]), 0);
 }
 
+/**
+ * dm_test_register_backlight_device_custom_curve_readback - Test curve + readback
+ * @test: The KUnit test context
+ *
+ * Custom curve data points select the non-linear backlight scale, and a
+ * hardware readback that differs from the initial brightness must update both
+ * the requested and the actual brightness.
+ */
+static void dm_test_register_backlight_device_custom_curve_readback(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_backlight_caps *caps;
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct backlight_device *bd;
+	struct drm_minor *primary;
+	int ret;
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_mid;
+	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, primary);
+	adev->ddev.primary = primary;
+	adev->dm.backlight_link[0] = link;
+
+	aconnector = dm_kunit_alloc_connector(test, adev, link);
+	aconnector->bl_idx = 0;
+	aconnector->base.kdev = adev->ddev.dev;
+	caps = &adev->dm.backlight_caps[0];
+	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->data_points = 1;
+
+	amdgpu_dm_register_backlight_device(aconnector);
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+
+	bd = adev->dm.backlight_dev[0];
+	KUNIT_ASSERT_NOT_NULL(test, bd);
+	ret = kunit_add_action_or_reset(test, dm_test_unregister_backlight_device, bd);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, bd->props.scale, BACKLIGHT_SCALE_NON_LINEAR);
+	KUNIT_EXPECT_NE(test, adev->dm.brightness[0], (u32)bd->props.brightness);
+	KUNIT_EXPECT_EQ(test, adev->dm.actual_brightness[0], adev->dm.brightness[0]);
+}
+
 static struct drm_connector *setup_panel_power_savings_connector(struct kunit *test,
 							 struct device **device_out,
 							 struct dm_connector_state **state_out)
@@ -1567,6 +1638,11 @@ static void dm_test_update_connector_ext_caps_oled_defaults(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fixture.adev->dm.backlight_caps[0].aux_max_input_signal, 512);
 	KUNIT_EXPECT_EQ(test, fixture.adev->dm.backlight_caps[0].aux_min_input_signal, 1);
 
+	/* DPCD panel luminance control selects VESA AUX over AMD AUX. */
+	fixture.link->dpcd_caps.panel_luminance_control = true;
+	amdgpu_dm_update_connector_ext_caps(fixture.aconnector);
+	KUNIT_EXPECT_EQ(test, fixture.link->backlight_control_type, BACKLIGHT_CONTROL_VESA_AUX);
+
 	amdgpu_dm_set_backlight_param(saved_backlight);
 }
 
@@ -1934,6 +2010,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	/* amdgpu_dm_register_backlight_device */
 	KUNIT_CASE(dm_test_register_backlight_device_negative_index),
 	KUNIT_CASE(dm_test_register_backlight_device_success),
+	KUNIT_CASE(dm_test_register_backlight_device_custom_curve_readback),
 	/* panel_power_savings_show / store */
 	KUNIT_CASE(dm_test_panel_power_savings_show_maps_disable_to_zero),
 	KUNIT_CASE(dm_test_panel_power_savings_show_reports_level),
-- 
2.53.0

