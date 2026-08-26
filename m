Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87432C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BBD10EE68;
	Wed, 26 Aug 2026 23:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2s6UNH/q";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E1110EE68
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClcLhINJ7ZgCsUaMQbtF0Zt1ePVWRttqaldjDVlWXeplkJ4ievZ3uoPdSw9L3f2A8XhMTBwXKTTL/dIAmqzkQLgFriXAoLVhq2CYjlx4KKmt2l0T8qOabikPs1c3EhPqu8+Pt3VQc2os5zNwCk+3rhaHphuHQvm7ms7DSYKTS3NjHvfGzW4joKHVqqfGqGkFXIk7cWoM5sp4iRJuL6aRjN8g4nOVhncIe+jrJemBkLvztfPvc7xoHxi/7ltb6s0g1ujc8LRZbHouW6wzWdovkG0zRnaLhpU8BUpSuHNR0IXEBBtKuU6yhMWiZjQxOM0jHHrsMnPA5pS2m86FmubSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im/W61U7RZdk0LXdgT0dPa0Ql3FGNkht1KnZBE1XrqY=;
 b=l/eZ/R54GPvpOD0J56CCGWj6tKM/GO0QOGei8GVKJ0Te67OTyzMmBmB9j/7v/xECGD7M0F3v/jNMUXk2rvvAh74UA+dQc76PFaz7odrskb4NEjd7BgWGR1wurtYwQqzxOCeBdTS2jMG6D2QeBw9qVgI+nB426PUIlGYbxNi0q18Ao14t5SqagT3ybyq/7UEBdBQDdLHLLc5I4SrsCOCjtR3HocclnV3voHYT4yoJszpnWigVOars89YCJr+XYzOnL7LnteobjGPV1hfYxFiTXx4dyrYGOe+iJu4KYr+c+Iq79P6NFMX0dro1FlOGYEO/QbnOqepslILIL7JuCcmjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im/W61U7RZdk0LXdgT0dPa0Ql3FGNkht1KnZBE1XrqY=;
 b=2s6UNH/q3G/FLGAACFsqwp0n5wg+fAzZ8xM3D+yluI4oAQFV0ZfHbiNz5xtWzInby+p+13Mv0gUyq2bowMJuwhSb704rZZi9BHf0jnxt9XYOR6vDqg0wJKCnTeUpKkju5Ty+0w/yNqgOPjisCjQjITCYjaMOYQFPx7SVuKSTNc8=
Received: from SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::18)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 23:34:21 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::9c) by SA1P222CA0158.outlook.office365.com
 (2603:10b6:806:3c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:34:21 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:34:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 55/59] drm/amd/display: Test MST VCPI slot calc
Date: Wed, 26 Aug 2026 17:05:26 -0600
Message-ID: <20260826231519.881949-56-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: af0d7710-f6bd-49a8-30d2-08df03ca8e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|11063799006|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 0i89IFHanUTNFvEX5N1YXUhR9Kvp9sz1uo0QZMGe5qKYzPjGZuAPkvojNi1eHyCOMQk2IRY72Gjxbro52FpJTjIQhtzSBYqPLEEBbHFc/MOzZAhwH/0rf57sSm5xbGRu/4nWoxeX/unqeb9FjGT1JhgADF4WAmJq/4g7O0JQA3QZPWNR8AM+FL3NgRJs9++EUby1Ik0HHSsEjI73x6I5NMRgdzVl7V6F93PUXl0LaAqeUjtD1LhvWAL2Z7GvCiY2EIN4lPgXci5nKANsHpfutWjKHnIE2kN818x/Dc6zoziwaRAkLle/s4uIDl1jCGr5zHKjJWuuPs27hGS5UP28AKMNOM/ZwIe6usKsfURlyIu5W/sy3x4JxRbKdh5RAa4i7r2AfwUv8lwNENKj/6oJr1o7eGczw7CfJjiQuSrHmE86qTzfOs+ORJPp6D9xEgWxIACc0qhUJZyHKQWLyxVEjXzbF9x2oJKHWZjyFSC8TQsCUHQ60iO9Be4chZdRejoADCVGaq8ebGYoiQz9eXHV+hd8ZzV1a7MAaEbTxh0N+3lYuJAjhgZ1vZkr+Ye5ikeX8T7tNSm/+Qzg0Kq1Femck4fC1pXDw+plp7xH8Z92SVzdStBkqzyD+cwtffBqS0KgMBVFxM2UB509zEko2UGFrvTiCTNHFwcdOPQGfP88zeZ/XnIc+KjqKyfgwmRlVs0PcXPWeG1m8TduB/WeVq/4sQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(10067099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H+RZ9Rix6Hj4lsOT+zaTQWgH1dmPoV6P9uhs6ECL5d9FQZSChLDyDQGHfDnAkSuG4KRY81Uu41No1uEVHk9V396vdVYDXKvFNT/TRMfflxofGBeyTwUXZQYC21PJp3adIDvKEsEBkRUBykBoQppDOlzUWyGEj5cRwEG8w4kgl2iIYWphlkarYAPs3UXnoOYvgNJUJH+9qz/gvZ5OioT6zsJHcye2U7+rEk9dN3hsYhRXSa4G5vj6dU0nzDVVvQ8B5TghqzFb+54psgBrbCK2DPe01KCNvFg+lKEgkOsXdaPcnLfxR45P+gb3USC3AiSx2isc5XNt3xyks8AArNPVT/PGBDixwx7zmrsT2r8yiRQsbikxS1JJlTIi4LnnuPryHbrtGk6zVUVlX43OnGAWG3YorFShn0Jbn7/w3xWmGgxjh/zBwSqZFYOUmowil+Vl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:34:21.0630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0d7710-f6bd-49a8-30d2-08df03ca8e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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
Add KUnit tests for dm_update_mst_vcpi_slots_for_dsc(), covering an
empty commit and the writeback, non-MST and unmatched stream skips.

[HOW]
The tests build a commit holding a single connector and vary its type
and MST output port so every early-skip branch is reached without an MST
topology or a matching DC stream.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 109 ++++++++++++++++++
 3 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a97caf7e1d33..e5c8f8a2ea3e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3296,9 +3296,9 @@ STATIC_IFN_KUNIT void fill_dc_dirty_rects(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(fill_dc_dirty_rects);
 
-static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
-					    struct dc_state *dc_state,
-					    struct dsc_mst_fairness_vars *vars)
+STATIC_IFN_KUNIT int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
+						      struct dc_state *dc_state,
+						      struct dsc_mst_fairness_vars *vars)
 {
 	struct dc_stream_state *stream = NULL;
 	struct drm_connector *connector;
@@ -3372,6 +3372,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
 	}
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_update_mst_vcpi_slots_for_dsc);
 
 static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b1db78e79015..089741ba0619 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1252,6 +1252,7 @@ struct dc_phy_addr_space_config;
 struct dc_plane_address;
 struct dc_plane_cap;
 struct dc_plane_info;
+struct dsc_mst_fairness_vars;
 
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
@@ -1261,6 +1262,8 @@ int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 				const struct drm_plane_state *plane_state,
 				struct dc_plane_info *plane_info,
 				struct dc_plane_address *address, bool tmz_surface);
+int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state, struct dc_state *dc_state,
+				     struct dsc_mst_fairness_vars *vars);
 int load_dmcu_fw(struct amdgpu_device *adev);
 int dm_sw_init(struct amdgpu_ip_block *ip_block);
 int dm_late_init(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index f8c540a6cdee..a67774e6db36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -35,6 +35,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_audio.h"
 #include "amdgpu_dm_hdcp.h"
+#include "amdgpu_dm_mst_types.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 
 /* Tests for simple DM callbacks */
@@ -3964,6 +3965,109 @@ static void dm_test_early_init_unsupported_version(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, adev->dc_enabled);
 }
 
+/* Tests for dm_update_mst_vcpi_slots_for_dsc() */
+
+/**
+ * dm_test_mst_vcpi_slots_no_connector - Test an empty commit allocates no slots
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_vcpi_slots_no_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {0};
+	struct dc_state *dc_state = dm_kunit_alloc_dc_state(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, dc_state);
+
+	KUNIT_EXPECT_EQ(test,
+			dm_update_mst_vcpi_slots_for_dsc(dm_test_alloc_commit(test, adev),
+							 dc_state, vars),
+			0);
+}
+
+/**
+ * dm_test_mst_vcpi_slots_skips_writeback - Test writeback connectors are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_vcpi_slots_skips_writeback(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {0};
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_state *dc_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	dc_state = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_NULL(test, dc_state);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
+	state = dm_test_state_with_connector(test, &aconnector->base, crtc);
+
+	KUNIT_EXPECT_EQ(test,
+			dm_update_mst_vcpi_slots_for_dsc(state, dc_state, vars), 0);
+}
+
+/**
+ * dm_test_mst_vcpi_slots_skips_non_mst - Test a connector without an MST port
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_vcpi_slots_skips_non_mst(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {0};
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_state *dc_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	dc_state = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_NULL(test, dc_state);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	state = dm_test_state_with_connector(test, &aconnector->base, crtc);
+
+	KUNIT_EXPECT_EQ(test,
+			dm_update_mst_vcpi_slots_for_dsc(state, dc_state, vars), 0);
+}
+
+/**
+ * dm_test_mst_vcpi_slots_no_matching_stream - Test a connector with no DC stream
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_vcpi_slots_no_matching_stream(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {0};
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_port *port;
+	struct dc_state *dc_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	dc_state = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_NULL(test, dc_state);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	aconnector->mst_output_port = port;
+	state = dm_test_state_with_connector(test, &aconnector->base, crtc);
+
+	/* No DC stream references the connector, so the slot update is skipped. */
+	KUNIT_EXPECT_EQ(test,
+			dm_update_mst_vcpi_slots_for_dsc(state, dc_state, vars), 0);
+}
+
 /* Tests for fill_dc_plane_attributes() */
 
 struct dm_test_plane_attr_ctx {
@@ -4626,6 +4730,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_early_init_legacy_asics),
 	KUNIT_CASE(dm_test_early_init_dcn_versions),
 	KUNIT_CASE(dm_test_early_init_unsupported_version),
+	/* dm_update_mst_vcpi_slots_for_dsc */
+	KUNIT_CASE(dm_test_mst_vcpi_slots_no_connector),
+	KUNIT_CASE(dm_test_mst_vcpi_slots_skips_writeback),
+	KUNIT_CASE(dm_test_mst_vcpi_slots_skips_non_mst),
+	KUNIT_CASE(dm_test_mst_vcpi_slots_no_matching_stream),
 	/* fill_dc_plane_attributes */
 	KUNIT_CASE(dm_test_plane_attributes_success),
 	KUNIT_CASE(dm_test_plane_attributes_bad_scaling),
-- 
2.43.0

