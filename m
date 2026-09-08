Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE257C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6974F10EB4F;
	Tue,  8 Sep 2026 11:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RUuiWYl2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A13C10EB4F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb/V8CJQZ1/R1CurboOgLH2SXujMdIfOqc/Dn7UPVpysBsUdhW5B+g25HzvtQYGqKSMA4UTtj5vUxOwGrnMouzMwpW8dYObxmOv2nnE9jiQypTS0dpUnVVEXWseC1980qk60GADSGcJPuxzKx3Im+hCbunLMkjs/XAliF4I0OLaJtYAe+GjVZSRyBIMFBn3dDcvqNrT8bwIhXJlpfQ5uk8geRsmWJOKmMgG+WQJI+fuTdgANhG135rHoWLel5/8JK3PIZoKRGgHRQnatlXXmfSwPG3If6Yb/D2xO2huxjET6v+gBIQc9CSABfGe1VrIjzoKSl97OyOOTmPxGTgFsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx7IGC7gehsYuKwmoPako89ZtyVFV7wgIxUVyrjVniA=;
 b=K7pVdYK9JYLnfc4oRhYmSoRihPuUmk4bK47aUO/uT260zxWyBM6Tir2t+7ySaJI6K82ixN8Ea+tl7XrW5gvcTv3Nen/5Q+VOnHDuL8+TjZm4kXWcnIDdboLseH9uLsdGI0ueHZHp0yvdwPNXh8ar53fiucjHvwEws7OdYw5yBUPd+gbP2PPJduEE5Eap6VHKlYqfMYpSSvxkBJbeKRcVljnM7v726UB37nl+kkW638kfjK0nstHXKRyeKOTCbCB/Ywd3XgqOctV8DtUkSb0vcLNUvrtJLZluoG9oAjFeABkXI6AzCmbwskmbM12pf2UNjCydruX/QvCzGjsENS4PTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx7IGC7gehsYuKwmoPako89ZtyVFV7wgIxUVyrjVniA=;
 b=RUuiWYl2G0/wW8Bzz/XCIrk03aRtk+WpzcieYzfquwgv14RtqGk4G7v3Hl/n/IgqbkNZaEuNYXsQLksrKhDcWTe5Bt1q1kN9wcxvjxVjKMBCjGm5SRGGcqZgaGQ4fbXbrSAijsbdhrRhORgG7r4bue56+3tWigTyIR9IEaqZxoE=
Received: from BN0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:408:ec::8)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:37:39 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::31) by BN0PR04CA0093.outlook.office365.com
 (2603:10b6:408:ec::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:37:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:37 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:37:29 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 26/66] drm/amd/display: Test FRL bandwidth lookup
Date: Tue, 8 Sep 2026 19:31:19 +0800
Message-ID: <20260908113338.2433445-27-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a869db2-9061-4e97-0527-08df0d9d95cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: y885BV2pc/3OoeM88Zz0lLZcZs0HvNy+LY7n+JNz/CaPDQyQDDvsyOL6zZc4UFc6VVG+e04smu4LC6d4rZqjXaBVSrZEmo1Avs3Wpv3AzhAT75jrFWUdJQRJsFH+f/kn6GAkkObiRWRoZbhVyi7RYJS2k9P6jvV1wwRqua/HgQkQEKzRdeUfsMuH2RSPg7AA9OH5eAfjkfY4qlCxZcm1R/QlQQDtjxM1uLxxsXKKMgLs9+5DxOIZJkxc6GUc7glG9G9uEaJw3LkK49R8BNcTrQef5QiAC8HkB9+cG9L9d9Glg5FHiYqXAGKkE+iujpfb+qbi2mfOsbbdcDJIOFPt/NWTNHllKVySIixAAFDqcTjuL+iSCEKsisJ24ZaUL5M3HV7v4pXHDBivWTemNIdNyiEeEtPfakRIyOv+5QYtBEbZpQf1MY8/NkxLJqbkxcpWSlSxzr14pmZTsnerRZbXyQd9ymixo+eu0h0GuDbizfX0ZVX8kveTSxu4kNy5PkY7QsG/4RYcLP8Vx7l/t6fFTKZ6JmU45B6244m21W21BJgyKjKNPv4iUep+EmrAY2zqASgymfSFA+zZVN7tS3CWnoU4DFANk+6arEpblWlKNuE/IaWrEARp0NmNr6gpN8b681yv8DE1c8IK7cN8ERZxAACXtLlrGF7c2Oq6UhB4HOWcKEpVSkE2JvhFBUaVZ+V5NgxyXAL8FTBhVlu/3M2kpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /ERK7IfcQUJLskOMu5IkI0A9+gfRTDpokmc6uGE3My4gM+tH7HkviOMww2D3o/Kr/3QEklEBWLSWaOCANPNljkp+Ae5NuFSZwI6823R5J61xEG/bhVd82rIyy1CnsDyNpkU5IIY7VnfB/mzuKFKAJdJHVe3gV/MQu2avhBhn4vjE3neZfjyHHoXFIUfylss2dA27Gve82Z2Y3NSXCPzb5okxBbUPBbH48dcjBVAyXWJHtHDwwAzcFwyYY60Qqt7p6PRKC8SSA7zaVQWnZuiPFEycJAtc/S0EgMi37XWCUiAv+FyUWIsDlLMH8bgurqEki9RfbC5VfN1spMR1WHbf7guXuWOahFrDJdHJR5A5Lgx8yexCg5/2qgEXxF68Vz999OA9wk7j6J0lG6nhjuHTshsirZ2sMjouFZEW8fhnoRjGAMssrTSR4g7QYl17RrSI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:37:38.3851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a869db2-9061-4e97-0527-08df0d9d95cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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
Add KUnit tests for get_conv_frl_bw() covering a protocol converter
without FRL support, a downstream port that is not HDMI, a sink whose
maximum FRL rate is zero and the case where the converter rate is the
bottleneck.

[HOW]
Populate the display info and the downstream port capabilities of the
connector for each case and check both the returned verdict and the
bandwidth values it reports.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   5 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   2 +
 .../tests/amdgpu_dm_mst_types_test.c          | 135 ++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index cb202b28a37c..4c6e7c28e4f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1231,8 +1231,8 @@ static int try_disable_dsc(struct drm_atomic_commit *state,
 	return 0;
 }
 
-static bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
-							uint32_t *bw_in_kbps, uint32_t *dsc_bw_in_kbps)
+STATIC_IFN_KUNIT bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
+				      uint32_t *bw_in_kbps, uint32_t *dsc_bw_in_kbps)
 {
 	unsigned int max_conv_bw_in_kbps = 0;
 	unsigned int max_sink_bw_in_kbps = 0;
@@ -1258,6 +1258,7 @@ static bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
 
 	return *bw_in_kbps > 0; // Frl endpoint is detected
 }
+EXPORT_IF_KUNIT(get_conv_frl_bw);
 
 static void build_frl_mst_dsc_params(struct amdgpu_dm_connector *aconnector,
 								struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 76db9a8330e5..e1a25afb570c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -107,6 +107,8 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 void amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector);
 bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port);
 bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw);
+bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
+		     uint32_t *bw_in_kbps, uint32_t *dsc_bw_in_kbps);
 bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 13c141d9963a..0e5dd4ca9aed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -2979,6 +2979,136 @@ static void dm_mst_test_port_mode_branch_throughput_exceeded(struct kunit *test)
 			DC_FAIL_BANDWIDTH_VALIDATE);
 }
 
+/* Tests for get_conv_frl_bw */
+
+/* Deterministic stand-in for the DC raw-FRL-rate lookup table. */
+static uint32_t dm_mst_test_bw_kbps_from_raw_frl(uint8_t bw)
+{
+	return bw * 3000;
+}
+
+/*
+ * Wire up a DP-to-HDMI2.1 protocol converter: the PCON capability lives on the
+ * DC caps, the converter's own limit in the downstream port caps, and the sink
+ * limits in the EDID caps.
+ */
+static struct amdgpu_dm_connector *dm_mst_test_alloc_frl_connector(struct kunit *test,
+								   bool pcon_support,
+								   u8 dwn_strm_port_type,
+								   u8 max_encoded_link_bw,
+								   u8 max_frl_rate,
+								   u8 frl_dsc_max_frl_rate)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct link_service *link_srv;
+	struct dc_sink *sink;
+	struct dc_link *link;
+	struct dc *dc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+
+	link_srv->bw_kbps_from_raw_frl_link_rate_data = dm_mst_test_bw_kbps_from_raw_frl;
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	dc->link_srv = link_srv;
+	dc->caps.dp_hdmi21_pcon_support = pcon_support;
+
+	link = dm_kunit_alloc_link(test);
+	link->dc = dc;
+
+	sink->edid_caps.max_frl_rate = max_frl_rate;
+	sink->edid_caps.frl_dsc_max_frl_rate = frl_dsc_max_frl_rate;
+
+	aconnector->dc_link = link;
+	aconnector->dc_sink = sink;
+	aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE =
+		dwn_strm_port_type;
+	aconnector->mst_downstream_port_caps.bytes.byte2.bits.MAX_ENCODED_LINK_BW_SUPPORT =
+		max_encoded_link_bw;
+
+	return aconnector;
+}
+
+/**
+ * dm_mst_test_conv_frl_bw_no_pcon_support - DC without PCON support finds no FRL
+ * @test: KUnit test context
+ */
+static void dm_mst_test_conv_frl_bw_no_pcon_support(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	uint32_t bw_in_kbps = 0;
+	uint32_t dsc_bw_in_kbps = 0;
+
+	aconnector = dm_mst_test_alloc_frl_connector(test, false, DOWN_STREAM_DETAILED_HDMI,
+						     3, 5, 2);
+
+	KUNIT_EXPECT_FALSE(test, get_conv_frl_bw(aconnector, &bw_in_kbps, &dsc_bw_in_kbps));
+	KUNIT_EXPECT_EQ(test, bw_in_kbps, 0U);
+	KUNIT_EXPECT_EQ(test, dsc_bw_in_kbps, 0U);
+}
+
+/**
+ * dm_mst_test_conv_frl_bw_not_hdmi_port - a non-HDMI downstream port has no FRL
+ * @test: KUnit test context
+ */
+static void dm_mst_test_conv_frl_bw_not_hdmi_port(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	uint32_t bw_in_kbps = 0;
+	uint32_t dsc_bw_in_kbps = 0;
+
+	aconnector = dm_mst_test_alloc_frl_connector(test, true, DOWN_STREAM_DETAILED_DP, 3, 5, 2);
+
+	KUNIT_EXPECT_FALSE(test, get_conv_frl_bw(aconnector, &bw_in_kbps, &dsc_bw_in_kbps));
+	KUNIT_EXPECT_EQ(test, bw_in_kbps, 0U);
+}
+
+/**
+ * dm_mst_test_conv_frl_bw_sink_without_frl - a sink not reporting FRL is skipped
+ * @test: KUnit test context
+ *
+ * Without a sink FRL rate in the EDID there is no endpoint to negotiate with,
+ * so no bandwidth is reported even though the converter advertises one.
+ */
+static void dm_mst_test_conv_frl_bw_sink_without_frl(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	uint32_t bw_in_kbps = 0;
+	uint32_t dsc_bw_in_kbps = 0;
+
+	aconnector = dm_mst_test_alloc_frl_connector(test, true, DOWN_STREAM_DETAILED_HDMI,
+						     3, 0, 2);
+
+	KUNIT_EXPECT_FALSE(test, get_conv_frl_bw(aconnector, &bw_in_kbps, &dsc_bw_in_kbps));
+	KUNIT_EXPECT_EQ(test, bw_in_kbps, 0U);
+}
+
+/**
+ * dm_mst_test_conv_frl_bw_bottleneck - the converter and sink limits are combined
+ * @test: KUnit test context
+ *
+ * The reported bandwidth is the smaller of the converter and sink FRL rates,
+ * and the DSC bandwidth is further capped by the sink's DSC FRL rate.
+ */
+static void dm_mst_test_conv_frl_bw_bottleneck(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	uint32_t bw_in_kbps = 0;
+	uint32_t dsc_bw_in_kbps = 0;
+
+	aconnector = dm_mst_test_alloc_frl_connector(test, true, DOWN_STREAM_DETAILED_HDMI,
+						     3, 5, 2);
+
+	KUNIT_EXPECT_TRUE(test, get_conv_frl_bw(aconnector, &bw_in_kbps, &dsc_bw_in_kbps));
+	KUNIT_EXPECT_EQ(test, bw_in_kbps, 9000U);
+	KUNIT_EXPECT_EQ(test, dsc_bw_in_kbps, 6000U);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -3084,6 +3214,11 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_port_mode_last_link_synaptics_quirk),
 	KUNIT_CASE(dm_mst_test_port_mode_upstream_vc_too_small),
 	KUNIT_CASE(dm_mst_test_port_mode_branch_throughput_exceeded),
+	/* get_conv_frl_bw tests */
+	KUNIT_CASE(dm_mst_test_conv_frl_bw_no_pcon_support),
+	KUNIT_CASE(dm_mst_test_conv_frl_bw_not_hdmi_port),
+	KUNIT_CASE(dm_mst_test_conv_frl_bw_sink_without_frl),
+	KUNIT_CASE(dm_mst_test_conv_frl_bw_bottleneck),
 	{}
 };
 
-- 
2.43.0

