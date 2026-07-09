Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED416C44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7492610F6E7;
	Thu,  9 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3g25nfZ2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D407E10F6DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMqDZecqa8A7P1GynYITS24uUkVQdM1zd8cnyq96Shuqj8k/Zr/lbwWr3rVlVzyNcDvJfVOgaAhRW7csAhVDn4aqfk0z6Hm1gSf8PkqbI3V80pKi+n9psK4XAjEwcLo4r4hK4OMIihm/EM/Lin7ZgYOkfKbR5fApt959Ah3VH81YejSKxDTzj8o8WF9q77z3rxbiAo/05RZGmN/4YkxvmM9lCUvmRYS8MOntiXGRADTi6OAbOmHMzTKzjdXMzLLhQsrQM277rbE/t/UDXrMU/sUi0zA/buTOFH6I4dsKg/MEwImkbpyIDfjN5X2yEFor9fgyAbuYw9CWStkU/e1iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqzOuaei6ysPvr0iyFayTx6PGe9I+rYxSbnesr/S67w=;
 b=ZmBg1lVELVkiFVPfZ4KKBzg9g/wobTOw1ATaoOh2+QK8WHQOICUxAn7RjbLiEd7+OEEFdnPB6CoSJx1X905gQmRuK3vH7LXxA8tAqRqde2HBvClKeWMTaqsulZjJa9ENRJrpKVCcvKCRJLtd67GZv4eh72R/3+mM0zf0rzbDDlWuIhSQwixo7XdsfESH/G8vDGZ7G1vePGVkanvx8lUdF1YgBbmTYKX6Vvjr9197OGkGsFs8m2Hn8VJY6Qz7OCmdD04N+Csd/p7HM71biGwiDfejMPgMZK7gO4ABfH4qTuULfa33bBByVGkkTTTvH5URtJZRMmMBUnljQIZ6l/Q9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqzOuaei6ysPvr0iyFayTx6PGe9I+rYxSbnesr/S67w=;
 b=3g25nfZ2jGQWJ0StzZ/q5wOHM8+VcpqDDjnNQ/7z1VvWzuu1dgvpSlCfm2mjktFZvfi+HaZhWjA5sJOdUZXiodw9tjebAZTy0uWaTeKA7xUW+/+CAKsbBqwd6Vwa95FEKryeJZEAIva03LZjwRh0fMY2dVLr6XRa8Huko4tCYsU=
Received: from BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::8)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 21:02:17 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::87) by BL1P223CA0033.outlook.office365.com
 (2603:10b6:208:5b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:17 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:56 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 26/80] drm/amd/display: Test MST start/stop and panel settings
Date: Thu, 9 Jul 2026 16:47:54 -0400
Message-ID: <20260709205936.5719-27-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bff441d-def5-4997-bdf4-08deddfd5c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WJpQPZik52Ijx7MDrNC6TN7VR2Q5WHkWf+yIqkOpfBwZMOWPkoB2oyIbqdw8JS+AtuF9bCc2fKWLfDwjvjoMJAx4+g/w5GECIlDTxEu7NJN6pze5sTygER5jXTEbmLclMSRvaNJXdaddQwzLRipgWcY4OSdUkei2xbuJ7mhBbCTyOycYSmMOPsYXAqw7ULrBltXhIdx8J59XvjCbC6aMyZMoXwtLUfeSPuiZJYywzNp8Y/O4zbYTVgMSihbfEZ2XQHlT6vWcdFKfuTdm+NPlU1/Raow2BWwz+wbWty93STrE6GhhXx3+tlpgpqeXVrvY1Uprml4oOzcC26dshiEzOf4pmkc4IH2ga99rASf9p9EQfovkskHXIQ8yFri67qc6YYaIc+aguYcKsvuT4jqd0ujt3cdlULNsE6AAaJl9EuVvlJH4C7aeq9BgJPKIIDYbVgcp/6tgDkYYXimGtmCO30SyujU7sjXlrQeiF7/170siGUZHWLp6ystl3RUBtdUee3PN/cG5isT1U/HKi+MScsFJ30Fg08U7Q6zvwJ/D/E0OBqJSnI+O3h1DXq6lBxJIm2Px4qmGQotmH2vqJ6gjiVqTAvcFxYV0KAJEmaXsigBC6mJNXhEKGvQT8ehIcNeZ/MCuyi7PjDWDfG+qUglpK0QFiscI64CADrV4Ji9X5Q6MazURnCSS9WRjpcI072++/pJWIiSrvnDsFir6k3hFzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iMBIgjXlBBqid+stuP/C9ZrHE2CCdY7xlTROiDwPDld6SRYxLdDITJ7mNduYLZO7mPlsLhS+Hh121hyxfDTMCzQW3122K4G6IPG+rAN8fZB9h6DTXJ7SR5p41nV9/De+XpZsjrEIo0r6wEsoUumxfF/CGjaQbcRWGqYyIpti650nbAhWFmr308QtTrzSdmIDw/bI4k2jNCs64viWbPpbQd4u9Zw4GigUYk8iKT6z1MmpCbFUTRPVZHfWt1Zp9c2dPuRr4jTLorDpzkl0NZbZQhZcFx4L/NQNLKw0aw2i6qS816EueO4aNPI39yOTygSfTzMSSwlKWe/a7Sa6IHN7M5WqYajZwupYWsnmBhgc2sKliZ+LLvYzhPQF9k5AyQn0SqCGSkfQPybNufMBdBtDcEdqjlEsMuy0oyBNnGxtqFRrPwPk05C0y+rSUsVbtfjk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:17.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bff441d-def5-4997-bdf4-08deddfd5c4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8
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
Add KUnit coverage for dm_helpers_dp_mst_start_top_mgr and
dm_helpers_dp_mst_stop_top_mgr, dm_helpers_dp_write_hblank_reduction,
get_dsc_max_slices, dm_helpers_init_panel_settings,
dm_helpers_override_panel_settings and
fill_dc_mst_payload_table_from_drm.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |   5 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 295 ++++++++++++++++++
 3 files changed, 306 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 804a95a19acf..aa4bd99528a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -240,7 +240,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 }
 EXPORT_IF_KUNIT(dm_helpers_parse_edid_caps);

-static void
+STATIC_IFN_KUNIT void
 fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 				   bool enable,
 				   struct drm_dp_mst_atomic_payload *target_payload,
@@ -290,6 +290,7 @@ fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 	/* Overwrite the old table */
 	*table = new_table;
 }
+EXPORT_IF_KUNIT(fill_dc_mst_payload_table_from_drm);

 void dm_helpers_dp_update_branch_info(
 	struct dc_context *ctx,
@@ -1149,7 +1150,7 @@ STATIC_IFN_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_pe
 }
 EXPORT_IF_KUNIT(get_max_frl_rate);

-static uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
+STATIC_IFN_KUNIT uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
 {
 	uint8_t dsc_max_slices;

@@ -1172,6 +1173,7 @@ static uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)

 	return dsc_max_slices;
 }
+EXPORT_IF_KUNIT(get_dsc_max_slices);

 void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
 {
@@ -1354,6 +1356,7 @@ void dm_helpers_init_panel_settings(
 	panel_config->dsc.disable_dsc_edp = false;
 	panel_config->dsc.force_dsc_edp_policy = 0;
 }
+EXPORT_IF_KUNIT(dm_helpers_init_panel_settings);

 void dm_helpers_override_panel_settings(
 	struct dc_context *ctx,
@@ -1371,6 +1374,7 @@ void dm_helpers_override_panel_settings(
 		link->panel_config.psr.disallow_replay = true;
 	}
 }
+EXPORT_IF_KUNIT(dm_helpers_override_panel_settings);

 void *dm_helpers_allocate_gpu_mem(
 		struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
index 343650b50707..e256e1e12422 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
@@ -25,9 +25,14 @@ u32 edid_extract_panel_id(struct edid *edid);
 void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		       struct dc_edid_caps *edid_caps);
 uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane);
+uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice);
 bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id);
 extern const uint32_t dm_freesync_pcon_whitelist[];
 uint32_t dm_freesync_pcon_whitelist_count(void);
+void fill_dc_mst_payload_table_from_drm(struct dc_link *link,
+					 bool enable,
+					 struct drm_dp_mst_atomic_payload *target_payload,
+					 struct dc_dp_mst_stream_allocation_table *table);
 bool dm_helpers_dp_write_dsc_enable(struct dc_context *ctx,
 				    const struct dc_stream_state *stream,
 				    bool enable);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index eed941a889e9..599de8240bee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -1746,6 +1746,282 @@ static void dm_test_dp_write_hblank_reduction_false(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_write_hblank_reduction(NULL, NULL));
 }

+/* Tests for get_dsc_max_slices() */
+
+/**
+ * dm_test_get_dsc_max_slices_1_340 - Test 1 slice at 340 MHz
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_1_340(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(1, 340), 1);
+}
+
+/**
+ * dm_test_get_dsc_max_slices_2_340 - Test 2 slices at 340 MHz
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_2_340(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(2, 340), 2);
+}
+
+/**
+ * dm_test_get_dsc_max_slices_4_340 - Test 4 slices at 340 MHz
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_4_340(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(4, 340), 3);
+}
+
+/**
+ * dm_test_get_dsc_max_slices_8_340 - Test 8 slices at 340 MHz
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_8_340(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(8, 340), 4);
+}
+
+/**
+ * dm_test_get_dsc_max_slices_8_400 - Test 8 slices at 400 MHz
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_8_400(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(8, 400), 5);
+}
+
+/**
+ * dm_test_get_dsc_max_slices_12_400 - Test 12 slices at 400 MHz
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_12_400(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(12, 400), 6);
+}
+
+/**
+ * dm_test_get_dsc_max_slices_16_400 - Test 16 slices at 400 MHz
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_16_400(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(16, 400), 7);
+}
+
+/**
+ * dm_test_get_dsc_max_slices_unknown - Test unknown combination returns 0
+ * @test: The KUnit test context
+ */
+static void dm_test_get_dsc_max_slices_unknown(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(3, 340), 0);
+	KUNIT_EXPECT_EQ(test, get_dsc_max_slices(1, 400), 0);
+}
+
+/* Tests for dm_helpers_init_panel_settings() */
+
+/**
+ * dm_test_init_panel_settings_pps - Test panel power sequence settings init
+ * @test: The KUnit test context
+ */
+static void dm_test_init_panel_settings_pps(struct kunit *test)
+{
+	struct dc_panel_config panel_config = {0};
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	sink->edid_caps.panel_patch.extra_t3_ms = 100;
+	sink->edid_caps.panel_patch.extra_t7_ms = 200;
+	sink->edid_caps.panel_patch.extra_delay_backlight_off = 50;
+	sink->edid_caps.panel_patch.extra_t12_ms = 300;
+
+	dm_helpers_init_panel_settings(NULL, &panel_config, sink);
+
+	KUNIT_EXPECT_EQ(test, panel_config.pps.extra_t3_ms, 100U);
+	KUNIT_EXPECT_EQ(test, panel_config.pps.extra_t7_ms, 200U);
+	KUNIT_EXPECT_EQ(test, panel_config.pps.extra_delay_backlight_off, 50U);
+	KUNIT_EXPECT_EQ(test, panel_config.pps.extra_post_t7_ms, 0U);
+	KUNIT_EXPECT_EQ(test, panel_config.pps.extra_pre_t11_ms, 0U);
+	KUNIT_EXPECT_EQ(test, panel_config.pps.extra_t12_ms, 300U);
+	KUNIT_EXPECT_EQ(test, panel_config.pps.extra_post_OUI_ms, 0U);
+}
+
+/**
+ * dm_test_init_panel_settings_dsc - Test DSC defaults in panel settings init
+ * @test: The KUnit test context
+ */
+static void dm_test_init_panel_settings_dsc(struct kunit *test)
+{
+	struct dc_panel_config panel_config;
+	struct dc_sink *sink;
+
+	memset(&panel_config, 0xFF, sizeof(panel_config));
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	dm_helpers_init_panel_settings(NULL, &panel_config, sink);
+
+	KUNIT_EXPECT_FALSE(test, panel_config.dsc.disable_dsc_edp);
+	KUNIT_EXPECT_EQ(test, panel_config.dsc.force_dsc_edp_policy, 0U);
+}
+
+/* Tests for dm_helpers_override_panel_settings() */
+
+/**
+ * dm_test_override_panel_settings_debug_mask_disables_dsc - Test DSC mask
+ * @test: The KUnit test context
+ */
+static void dm_test_override_panel_settings_debug_mask_disables_dsc(struct kunit *test)
+{
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+	uint old_debug_mask;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	link = dm_kunit_alloc_link(test);
+	ctx->dc = dc;
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	old_debug_mask = dm_helpers_get_dc_debug_mask();
+	dm_helpers_set_dc_debug_mask(old_debug_mask | DC_DISABLE_DSC);
+	dm_helpers_override_panel_settings(ctx, link);
+	dm_helpers_set_dc_debug_mask(old_debug_mask);
+
+	KUNIT_EXPECT_TRUE(test, link->panel_config.dsc.disable_dsc_edp);
+}
+
+/**
+ * dm_test_override_panel_settings_second_edp_disables_psr - Test eDP index 1
+ * @test: The KUnit test context
+ */
+static void dm_test_override_panel_settings_second_edp_disables_psr(struct kunit *test)
+{
+	struct dc_context *ctx;
+	struct dc_link *first_link;
+	struct dc_link *second_link;
+	struct dc *dc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	first_link = dm_kunit_alloc_link(test);
+	second_link = dm_kunit_alloc_link(test);
+
+	ctx->dc = dc;
+	dc->link_count = 2;
+	dc->links[0] = first_link;
+	dc->links[1] = second_link;
+	first_link->connector_signal = SIGNAL_TYPE_EDP;
+	second_link->connector_signal = SIGNAL_TYPE_EDP;
+
+	dm_helpers_override_panel_settings(ctx, second_link);
+
+	KUNIT_EXPECT_TRUE(test, second_link->panel_config.psr.disable_psr);
+	KUNIT_EXPECT_TRUE(test, second_link->panel_config.psr.disallow_psrsu);
+	KUNIT_EXPECT_TRUE(test, second_link->panel_config.psr.disallow_replay);
+}
+
+/* Tests for fill_dc_mst_payload_table_from_drm() */
+
+/**
+ * dm_test_fill_mst_payload_table_enable - Test payload table fill on enable
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_mst_payload_table_enable(struct kunit *test)
+{
+	struct dc_link *link;
+	struct drm_dp_mst_atomic_payload payload = {0};
+	struct dc_dp_mst_stream_allocation_table table = {0};
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* Pre-existing allocation in the link table */
+	link->mst_stream_alloc_table.stream_count = 1;
+	link->mst_stream_alloc_table.stream_allocations[0].vcp_id = 1;
+	link->mst_stream_alloc_table.stream_allocations[0].slot_count = 4;
+
+	/* New payload to add */
+	payload.vcpi = 2;
+	payload.time_slots = 8;
+
+	fill_dc_mst_payload_table_from_drm(link, true, &payload, &table);
+
+	/* Should contain both the pre-existing and new allocation */
+	KUNIT_EXPECT_EQ(test, table.stream_count, 2);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[0].vcp_id, 1);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[0].slot_count, 4);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[1].vcp_id, 2);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[1].slot_count, 8);
+}
+
+/**
+ * dm_test_fill_mst_payload_table_disable - Test payload table fill on disable
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_mst_payload_table_disable(struct kunit *test)
+{
+	struct dc_link *link;
+	struct drm_dp_mst_atomic_payload payload = {0};
+	struct dc_dp_mst_stream_allocation_table table = {0};
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* Two existing allocations in the link table */
+	link->mst_stream_alloc_table.stream_count = 2;
+	link->mst_stream_alloc_table.stream_allocations[0].vcp_id = 1;
+	link->mst_stream_alloc_table.stream_allocations[0].slot_count = 4;
+	link->mst_stream_alloc_table.stream_allocations[1].vcp_id = 2;
+	link->mst_stream_alloc_table.stream_allocations[1].slot_count = 8;
+
+	/* Remove vcp_id 1 */
+	payload.vcpi = 1;
+	payload.time_slots = 4;
+
+	fill_dc_mst_payload_table_from_drm(link, false, &payload, &table);
+
+	/* Only vcp_id 2 should remain */
+	KUNIT_EXPECT_EQ(test, table.stream_count, 1);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[0].vcp_id, 2);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[0].slot_count, 8);
+}
+
+/**
+ * dm_test_fill_mst_payload_table_empty - Test payload table fill when empty
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_mst_payload_table_empty(struct kunit *test)
+{
+	struct dc_link *link;
+	struct drm_dp_mst_atomic_payload payload = {0};
+	struct dc_dp_mst_stream_allocation_table table = {0};
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* Enable on an empty table */
+	payload.vcpi = 5;
+	payload.time_slots = 12;
+
+	fill_dc_mst_payload_table_from_drm(link, true, &payload, &table);
+
+	KUNIT_EXPECT_EQ(test, table.stream_count, 1);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[0].vcp_id, 5);
+	KUNIT_EXPECT_EQ(test, table.stream_allocations[0].slot_count, 12);
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -1832,6 +2108,25 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_mst_start_top_mgr_boot),
 	/* dm_helpers_dp_write_hblank_reduction */
 	KUNIT_CASE(dm_test_dp_write_hblank_reduction_false),
+	/* get_dsc_max_slices */
+	KUNIT_CASE(dm_test_get_dsc_max_slices_1_340),
+	KUNIT_CASE(dm_test_get_dsc_max_slices_2_340),
+	KUNIT_CASE(dm_test_get_dsc_max_slices_4_340),
+	KUNIT_CASE(dm_test_get_dsc_max_slices_8_340),
+	KUNIT_CASE(dm_test_get_dsc_max_slices_8_400),
+	KUNIT_CASE(dm_test_get_dsc_max_slices_12_400),
+	KUNIT_CASE(dm_test_get_dsc_max_slices_16_400),
+	KUNIT_CASE(dm_test_get_dsc_max_slices_unknown),
+	/* dm_helpers_init_panel_settings */
+	KUNIT_CASE(dm_test_init_panel_settings_pps),
+	KUNIT_CASE(dm_test_init_panel_settings_dsc),
+	/* dm_helpers_override_panel_settings */
+	KUNIT_CASE(dm_test_override_panel_settings_debug_mask_disables_dsc),
+	KUNIT_CASE(dm_test_override_panel_settings_second_edp_disables_psr),
+	/* fill_dc_mst_payload_table_from_drm */
+	KUNIT_CASE(dm_test_fill_mst_payload_table_enable),
+	KUNIT_CASE(dm_test_fill_mst_payload_table_disable),
+	KUNIT_CASE(dm_test_fill_mst_payload_table_empty),
 	{}
 };

--
2.55.0

