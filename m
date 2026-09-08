Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99468C79FAD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3406110EB4C;
	Tue,  8 Sep 2026 11:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xRu7pAt6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F1510EB4C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5CaOCYm2SbEIHwQ40ZvxTUjx0dZVkc8p1vfNEh5kJe1jkSIu02+tuvrw7TQnEf1WyVJGT+Q7ef/7utIghGllH60yckNMi9pv/bbO0hF7EbxeYLaAR2UPUr7QqMG21qbXQZYG6Dyi9k7bN5GhiGbZa68UyXxdxbhuopZ9SASsCG1XjiurlffjkdNs8VLmU0Vis/lX2EjoZ4wAtM0eSeLcC7tX2R9p4lkhziIM9rneL36hKzoUgU4NB6lTq/FYkZDupVdooQg+N3B+PzmrYEatW6u8RWxqrgLlzD70rnKJSrvbdDJ76h43lOtBpKnLayOqFXn/Qc8xIe3uIuFHMTjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCvM41SKJxFp1peoKaIWcwW235ZfueDqeN4EEPiimCw=;
 b=pjLd8kcEWYthYhX7ED95PDVwS2c4RvOPRgr2YcX5JTLKbDVfd2psQSJW1Vzl6XPSWSxBj3PGHho33FXmE4GPMqiOmRp/oIwgjTdHdpBg8ivwJoeaip+8c2iu4+37fOKyDULENau3NUabX58OiWJiB+uzL76iXMskxS1ELMoNX8EJ4QTCm887hsnpnnIRIy+KR+S+cRG9qIQ+UPPoSO+mL6dcFqZYzd90ZXjAwPqclO73UvrHxizSKmUB4H80Q1lUk6Gup1j9RsMA1+ecOMF+4X7hvTWq4ogkyvMqFIWK8RsNuW4JuQaSqSym7jugnoHi/kzhtyw/Wcg1F7G5l+7A7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCvM41SKJxFp1peoKaIWcwW235ZfueDqeN4EEPiimCw=;
 b=xRu7pAt6mPk0kzhXpnQawk+588D4o5Wgfj5SpyMKgt3bzIADure8jzz151oQeehN/+7I+9Cp4eZKpyO4YVJ8UfjdwpzxAXvrBNC2hhFns2ax4WC0DlztXicPTJMO+XFKyNkQK7vmt9LEhNzlKGBTKFa9UmvCWQPcEStPRIWDomU=
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:37:15 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::ac) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:37:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:11 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:37:02 -0500
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
Subject: [PATCH 23/66] drm/amd/display: Test cascaded Panamera check
Date: Tue, 8 Sep 2026 19:31:16 +0800
Message-ID: <20260908113338.2433445-24-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 001d74eb-0879-45c1-572e-08df0d9d8801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: EIQd1phgs1Rlin4yYGtS04a10EzYqAyYcfEJ2SkuGkQLUymSFS/QVZxxe9k02R8mbi9Ed2QBD9Qpm0vBLB1uRh4yCz6urCmbMnQwsZ6hmzr3ZMCeTNxwxKJ50ebQx4mdxhQFd17YAaU0QsSGkGKqy5w/wruNAMqDrxocfH+R9SObwjqHT4W7CFxE5TYroK5z8MGt4yHxGk3nsbRs8EDN1hKLBrJTvt0y1aKOnsblITbzzs7Wz/t0QzwP02XgGlkE4sMPQhg+Z7/WktFLhllcW80LsLFI0wpp6IZ6X4UUonpAW9H+GVvEoJGgBTVPv+SILtUO+9M05rJY3N4iY6nHDpqz+OxOmmyrXmEZuUmbvLBlqcnt1EE2oml2sUt0dfE/qcTnhCSz77KL8G5zOYlczFf24bX60CKW/jDHgCT16nk7hQ18qLtwyRKZhFD7jcmluP6JWHvZnbH4GBxtkJyldYY7NW7YiySp+bJSrWJZ24u5As5Lt8oub1Ayvvi+9uqazNAqhVmW7b/KCWaT7zZVD3tf/Fwp+KLhuIK7/na/3VuUecSylWuHflq5A5J7SJIkB3x3ZbrWQ20LL/Wk8IcbyayoERtnuTYG8H97ECY5oSdaQwnh1vc2t1eu81u7y53eMxIsWvO7WVZvygux3YppgeDWRbcYbQTOT9DhY1Q7ePk93IYHAsbxzqHUHmpMQXiFBTJcW3WtNSs7y+amjFx+Fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L0zPfaM5W2MVkns0Xbq6sUO5icKv6ERU9idYF8NAczLoTGjgihWSKMubQfA3yFkT1JGJqlkxAZER+9z4QyiFl56046cOjSDk0rJkole2OQhTRMv08NSywc4vWhz0dr318osZuLxAFG8wpHNFOZfaVGaoSNOv6XY7Z86kK3VNPymdquIE6RFHxntHIU7OpCjcmDS7IzfzpsHkvCF9oOlfUVoVPkZxKYqqy+Qfj4kNvl/fbFCF/qnWQJ3oMmZOMfmBAsxLd8I9xt6DpjHkHN5rCxbEW2nC5CVFB18hkEk9cxGmM03Iov+ypHyVZQkLMZLsmi+e3Ig62TdXz+Rf+MsYwL+wy2tSq4zLx51u7dQblbobuKuAAAsKu2YzuCj9ydApHFqGAaM6aVvXzYmuhVjna8wCcjmLQwqY8lYINyfd7XDp+7oSkhdiLxiVErZs3+jV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:37:15.2087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001d74eb-0879-45c1-572e-08df0d9d8801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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
Add KUnit tests for is_synaptics_cascaded_panamera() covering a
matching cascaded hub, a non Synaptics branch, a non Panamera device
ID, an unsupported branch firmware revision and a port without a
parent branch.

[HOW]
Allocate an MST topology manager with a branch and a port, and drive a
table driven test that fills in the branch OUI, device ID and firmware
revision for each case before checking the returned verdict.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  1 +
 .../tests/amdgpu_dm_mst_types_test.c          | 81 +++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e8f4ca7e1f2a..c584906c8bb0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -279,7 +279,7 @@ bool needs_dsc_aux_workaround(struct dc_link *link)
 EXPORT_IF_KUNIT(needs_dsc_aux_workaround);
 
 #if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-static bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port)
+STATIC_IFN_KUNIT bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port)
 {
 	u8 branch_vendor_data[4] = { 0 }; // Vendor data 0x50C ~ 0x50F
 
@@ -293,6 +293,7 @@ static bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_m
 
 	return false;
 }
+EXPORT_IF_KUNIT(is_synaptics_cascaded_panamera);
 
 static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 4af3aac31223..f2e36807f0da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -105,6 +105,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 void amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector);
+bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port);
 bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 58a4bbb31e79..2e562c545c30 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -2394,6 +2394,85 @@ static void dm_mst_test_link_current_set_bw(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cur_link_bw, param->cur_link_bw);
 }
 
+/* Tests for is_synaptics_cascaded_panamera */
+
+/*
+ * A Panamera hub is identified by its branch device ID plus the high nibble of
+ * the fifth branch device name byte; the cascaded variant additionally reports
+ * SYNAPTICS_CASCADED_HUB_ID at DPCD 0x50e.
+ */
+static void dm_mst_test_set_panamera_ids(struct dc_link *link, u32 branch_dev_id,
+					 u8 dev_name_4, u8 cascaded_id)
+{
+	link->dpcd_caps.branch_dev_id = branch_dev_id;
+	link->dpcd_caps.branch_dev_name[4] = dev_name_4;
+	dm_mst_test_dsc_dpcd[DP_BRANCH_VENDOR_SPECIFIC_START + 2] = cascaded_id;
+}
+
+static struct drm_dp_mst_port *dm_mst_test_alloc_mgr_port(struct kunit *test)
+{
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_port *port;
+
+	mgr = kunit_kzalloc(test, sizeof(*mgr), GFP_KERNEL);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mgr);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	mutex_init(&mgr->lock);
+	mgr->aux = dm_mst_test_alloc_dsc_aux(test, "dm_mst_test_mgr_aux");
+	port->mgr = mgr;
+
+	return port;
+}
+
+struct dm_mst_panamera_param {
+	const char *name;
+	u32 branch_dev_id;
+	u8 dev_name_4;
+	u8 cascaded_id;
+	bool aux_fails;
+	bool cascaded;
+};
+
+static const struct dm_mst_panamera_param dm_mst_panamera_params[] = {
+	{ "cascaded_hub", DP_BRANCH_DEVICE_ID_90CC24, 0x50,
+	  SYNAPTICS_CASCADED_HUB_ID, false, true },
+	{ "wrong_dev_id", 0x001122, 0x50, SYNAPTICS_CASCADED_HUB_ID, false, false },
+	{ "not_panamera", DP_BRANCH_DEVICE_ID_90CC24, 0x40,
+	  SYNAPTICS_CASCADED_HUB_ID, false, false },
+	{ "not_cascaded", DP_BRANCH_DEVICE_ID_90CC24, 0x50, 0, false, false },
+	{ "dpcd_read_error", DP_BRANCH_DEVICE_ID_90CC24, 0x50,
+	  SYNAPTICS_CASCADED_HUB_ID, true, false },
+};
+
+KUNIT_ARRAY_PARAM_DESC(dm_mst_panamera, dm_mst_panamera_params, name);
+
+/**
+ * dm_mst_test_synaptics_cascaded - only a cascaded Panamera hub is detected
+ * @test: KUnit test context
+ *
+ * All three conditions must hold: the Synaptics branch device ID, a Panamera
+ * device name and the cascaded hub ID in the branch vendor data. A failed
+ * vendor read leaves the hub undetected.
+ */
+static void dm_mst_test_synaptics_cascaded(struct kunit *test)
+{
+	const struct dm_mst_panamera_param *param = test->param_value;
+	struct drm_dp_mst_port *port;
+	struct dc_link *link;
+
+	dm_mst_test_reset_dsc_dpcd();
+	port = dm_mst_test_alloc_mgr_port(test);
+	link = dm_kunit_alloc_link(test);
+	dm_mst_test_set_panamera_ids(link, param->branch_dev_id, param->dev_name_4,
+				     param->cascaded_id);
+	if (param->aux_fails)
+		dm_mst_test_dsc_aux_fail = port->mgr->aux;
+
+	KUNIT_EXPECT_EQ(test, is_synaptics_cascaded_panamera(link, port), param->cascaded);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -2480,6 +2559,8 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_connector_destroy_releases_sink),
 	/* dp_get_link_current_set_bw tests */
 	KUNIT_CASE_PARAM(dm_mst_test_link_current_set_bw, dm_mst_link_bw_gen_params),
+	/* is_synaptics_cascaded_panamera tests */
+	KUNIT_CASE_PARAM(dm_mst_test_synaptics_cascaded, dm_mst_panamera_gen_params),
 	{}
 };
 
-- 
2.43.0

