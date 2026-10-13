Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFF1CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C3CA10E7AF;
	Tue, 13 Oct 2026 11:16:27 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B69D10E7A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB+Amyj+Qm4b6qM7iUX3Ayq8AI0fIQInVgPx/OPngdMbMVDklc2eCR4J0aweoAT2DgM2jz4mAMA+4duMoyyFlYaBfgZbMbt6CqJwvXSmPw3618tPg03+eVRb82nXTwWgpL/XiGuet+uMCnKg9UvLQZEWUwDlDlF4TP44x9i3VYhZbFno7Eyaue3kzGKbuqYEJIzvvcPdrjBusrICBQpCn6bNufDiyV702X8U45/79iyGb/GRxz/++a68mbbIJfYWIFSMzF5aZpL2y8csRpDh9egNbBf+Y/WVGH51WtHzECD+5SrvyLq+Cu6AXTXu5Dn5SbHoSeQV5oqZ1Lj33jAogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hBlGrWHu26b8xzDE7IduJCqfxDb6dSPpr4Gw/Enq5U=;
 b=v2oWAlOw2VxUjKadRiE45Z+m5bqGH+5Old8cftzkoerEInAaR6t+20xdm6byGXETLDfamBuewdH0MnBKVicA7F6vgmi969FFlgAMsW6hiF39AWw/bRDfqbXrhnWdTEBQfbm1zWL8pWt0RKM/D6V/Paqn4Ipw3YAuR8LMbHyBA5jMRpDP/hMnuR4jfAj++t1Bzl46E5OwHUQrAJQgR2vttF/l5nt0RxacNI20oewIIXC6bf/4PWx9LocN5kZ74Y4n4tIeHo8HrfzsJtR2xCpHGWaVnjVKhgGxuYOeO4WbWmt4IQxjkTA/wax10gxPnPbf7wF4sdiYgL7RpY0kJxjubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hBlGrWHu26b8xzDE7IduJCqfxDb6dSPpr4Gw/Enq5U=;
 b=diGUOhDvTuoeE9/T9yXKDwOvayrrL7SOTDuvqDjvZRrxAbkkWi3Xr4nfKRg7XLi1jRGE0ku7TMiwD9a+7qhdXHPDeU4g9QMVqQjBR8mE58EVxt1oqWexVaM3Jiv4UBXQShe9piN3Ja4xnd15rVH6wwp/UHAvizMfy1ZXZoepFTI=
Received: from DS1PR03CA0001.namprd03.prod.outlook.com (2603:10b6:8:450::14)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:16:16 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::a3) by DS1PR03CA0001.outlook.office365.com
 (2603:10b6:8:450::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:16:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:16:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:09 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:16:01 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 02/30] drm/amd/display: Align eDP DSC link policy to minimize
 lane count
Date: Tue, 13 Oct 2026 19:07:49 +0800
Message-ID: <20261013111616.2267344-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: f163a262-fbaa-4637-9837-08df291b65c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: v3jxiR6wxGhHlwjc1bCpf58dUZ0pzRj7ZQD9RTGL32mW2JTw9jl4P4+x6iJNCXyFAl9IqZxq7W/ifTnDgdNOh8LOxwsLCbJmtJy7Ya4O9t/NUvZ2dqd5O5RZblRtEw1XU6c4kh0XQ99Vnzj3BU0NIwakPNJUx/kHSARlXRP6qcldUBnmgD65RpwgRXt3jxQFQaNkPcCAQbUhrvyIZ6fbm/NhklgkPssiuBCbSfl2NINDAjXkSwQQNgixS75JKcLdSZWOKRGoMC5agnaSFBeFwJB/VwHlhd9imgT6E5YQwRFtifxoxCzMO3rNjWiAyIfjIi2lbHWp00MSfvfhhZ78uWSgzn6YBtPJXHt2EHwcDlZ4C5ndjH1D7Mh1muVDq1Cn8/jrus0TcYTe8if+Sjp0SVe1dbGDpzt3GW25LPWklrd/Ay2EExY1IsrEikgRYrHJ9SRaDmFSGbRJpYefRUuBGlW0GcE2guEYS+59v/wRC/ieU4pdMFq1uPZXU+q+LkdL1JmMlAAROB574yiYX4o/vTpQDGML2UhPq22eGX6m+pk1RaSYF/MOwnk5oTWx20ksWVncVoB6FV/Aoe7dnCqhaM4cdNQbe9mpaDrmb83r0XMzYxqxFOeuazsPb3LvAFWVYfK4GgNA4bBM4QMlsePFnYgmq/YeE67rVpOO8x1QgiJb28Ny0PItwrHJY4Hy1FEWQuoJ/ON+giLD6HVjPyb/dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(261009223027099003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1/5o9jaR+CVzcx0ywv+iLicxNLByLiE5Nk4VSbhPC0n3Zd2B0DNV+d6kS29YPjUErfEUE8lHxpkA7vrTMDXk00zH5jW9yMZ5eu1lzDAeW+yX9lMzjurYkkP+wWVlWEKyEWcxesygOk3pfkx1M3pC5yGZAmv7LnvA24MVQFG3C5EslekObw6pvJIjXPJbCbAukTjXmUfMvPFPJqt0TlPY6H4e86HzThhdR/OFUMcp5EonfUiGtYya3UAQJ3cCJvcYM61m/K273jcUeclrnqq6cIYO2Nhu9fTGGpFZodv7u9vwW1ZqhM1IoeDZIwLD8+OfMkgWur4jxAl+XKHSW8rv1+Dbprv77bRmQySNYxYggbcN/rzc8U0tpPD81DYODFo5LqvW7Tt8c6hxl9sKt0Uo85WYf+qKbbdWB4fVFmfY6N8+WCMkhdE82cEOPg30VcAi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:16:15.7664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f163a262-fbaa-4637-9837-08df291b65c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660
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

[Why]
The defaults eDP DSC link policy to minimize the link rate,
while the preferred policy is to minimize the lane count.

[How]
Use the minimize-lane policy by default.
Fall back to the minimize-link-rate policy when FEC is unavailable
or disabled. Update the KUnit expectation accordingly.

Assisted-by: Cursor:Claude-Opus-5.5
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  5 ++++-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 20 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3217aa82bea2..2f9c98a89c94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1423,7 +1423,7 @@ void dm_helpers_init_panel_settings(
 	panel_config->pps.extra_post_OUI_ms = 0;
 	// Feature DSC
 	panel_config->dsc.disable_dsc_edp = false;
-	panel_config->dsc.force_dsc_edp_policy = 0;
+	panel_config->dsc.force_dsc_edp_policy = 1;
 }
 EXPORT_IF_KUNIT(dm_helpers_init_panel_settings);
 
@@ -1437,6 +1437,9 @@ void dm_helpers_override_panel_settings(
 	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
 		link->panel_config.dsc.disable_dsc_edp = true;
 
+	if (!dc_link_should_enable_fec(link))
+		link->panel_config.dsc.force_dsc_edp_policy = 0;
+
 	if (dc_get_edp_link_panel_inst(ctx->dc, link, &panel_inst) && panel_inst == 1) {
 		link->panel_config.psr.disable_psr = true;
 		link->panel_config.psr.disallow_psrsu = true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index d37fe26eecea..38f53c596f0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -2092,7 +2092,12 @@ static void dm_test_init_panel_settings_dsc(struct kunit *test)
 	dm_helpers_init_panel_settings(NULL, &panel_config, sink);
 
 	KUNIT_EXPECT_FALSE(test, panel_config.dsc.disable_dsc_edp);
-	KUNIT_EXPECT_EQ(test, panel_config.dsc.force_dsc_edp_policy, 0U);
+	KUNIT_EXPECT_EQ(test, panel_config.dsc.force_dsc_edp_policy, 1U);
+}
+
+static bool dm_test_dp_should_enable_fec(const struct dc_link *link)
+{
+	return true;
 }
 
 /* Tests for dm_helpers_override_panel_settings() */
@@ -2106,14 +2111,20 @@ static void dm_test_override_panel_settings_debug_mask_disables_dsc(struct kunit
 	struct dc_context *ctx;
 	struct dc_link *link;
 	struct dc *dc;
+	struct link_service *link_srv;
 	uint old_debug_mask;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dc);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = dm_kunit_alloc_link(test);
 	ctx->dc = dc;
+	dc->link_srv = link_srv;
+	link->dc = dc;
+	link_srv->dp_should_enable_fec = dm_test_dp_should_enable_fec;
 	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
 
 	old_debug_mask = dm_helpers_get_dc_debug_mask();
@@ -2134,15 +2145,22 @@ static void dm_test_override_panel_settings_second_edp_disables_psr(struct kunit
 	struct dc_link *first_link;
 	struct dc_link *second_link;
 	struct dc *dc;
+	struct link_service *link_srv;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dc);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	first_link = dm_kunit_alloc_link(test);
 	second_link = dm_kunit_alloc_link(test);
 
 	ctx->dc = dc;
+	dc->link_srv = link_srv;
+	link_srv->dp_should_enable_fec = dm_test_dp_should_enable_fec;
+	first_link->dc = dc;
+	second_link->dc = dc;
 	dc->link_count = 2;
 	dc->links[0] = first_link;
 	dc->links[1] = second_link;
-- 
2.43.0

