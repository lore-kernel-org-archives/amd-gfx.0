Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20962C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A559E10F0A0;
	Wed, 15 Jul 2026 13:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CAm7wkNZ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4708610F09F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QG+qjZHpV2E7wM8mWq/Co+5vfxFv+6Llyqf5xye6bMjff4/mw/tfEZzT1tAriWyzWwOfWY6PN66YURQlfd3ymmHEfXSGZTqiERgjtwUVDffjg3Sub8ZkxbP0U0AGUraNoqgiwmyh4ynapkdx/J94cU4cxoP3wVb3uvSDG7YddNRzgiWxy3hV3TNL1TpaIuRceKzWP91kY1kyB740tYvpcw8/UEqV9QMt/StZuntDmW5J8IlhGOjec4Xilp+0tpLDnljIfKmhPORv/taBqjgnwSUg5wWGS06jBLfIzxqmHQnC/N3Hz3ARil3w1LdWGpvVZ/aq9RqXpmHjPhHg3gIqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68vQUrDEqYzYKNtVetC+zRSCkuB1JU6wGua9THMzm/Y=;
 b=ww1O9jRUWLA6351muNadgb91ecsACqSqgA+g5cafEl7TEEps2lm22xG7amznkVI+FbG38/ZdeRwKu3B/Io1OcOZAl6B4eN1LZv8h0S4tAWfSnxpKdq8DSKf4T6gOzAMna3BzSLflOMZHG09JRAwic7uk1dDSwIDJt4kSFjmks2gAINdXLK6TvLZ5iCzY8H9/d65VGAO07Ms8BmqDDp0psB9PG5iL3bwqWPyaeOANECBnqPPtHYrYGaufCpr1aW4WEmtWgo99KoBNzhEnmWm9Smi6IwWUFocNJdOV41FNA3RBDkcdD2ehrNSZEdpIwjXynPrarGU2Xx7mpenJoF0Bkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68vQUrDEqYzYKNtVetC+zRSCkuB1JU6wGua9THMzm/Y=;
 b=CAm7wkNZpjWb4nkxg9tXw64WpHiK8I0GfZCI4GPlwXAxY7o5ouPq0q8N2e/IK1y6p8B1S4teLy4k1m7sSmWQ1rowTBp/9Pc3jLWVK8vWiE9xg31AzxftllxBKM8iVXztutTzZ/yWT0IeUEwCkHSuclVQxy/S+/scqkUZtDn+YDQ=
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:48:14 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::8) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:47:49 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 47/70] drm/amd/display: Add mode validation and CEC tests for
 connector
Date: Wed, 15 Jul 2026 21:37:57 +0800
Message-ID: <20260715134432.1975118-48-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 385e746d-ca50-41a3-da7f-08dee277b78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6KPHbTd2pHEtlwEAzIubNVAA3SrxhqGqPOhnh6y6okTcKhbWewLq3WhuGEVHPl7d8uDaQpp4cqBE4GeyDoBK3WiAU8i7JWB/rXU255RnJZdt4mD0Jr9XPYV6CcVG4ad5KVf2BaVXkSuoGacwle7rdLbd97EQ+lLx9j90p602aqjGUFA4PrX+3aDAEDJsCcl0/+ExoIJsby0bl+Uzrqq1huvQOY6fAq6QwkXoEj5HMYXOC5uZHLR//nq1L8eNJUVoa5C75ao+yZht1td7oh5/S01zVNMeqeR5EwevJrvWGpY0q6g40nehz6XLDKBHtexXCT1LNM/IqtKMXYTV4i7jf9Grju5IrQEv/05cnZOTHnlgGNqT7sbftR6OrkEpFoFi9mHgbGhaXDckXtJCVGb7Ep0m7BVxtY5OEn6JI9zA794NG+8qhffDtLtF+Z88aXDv4slxMeydakehhu+S/486AAoCTjQHZb46qPj2Za7+bSUjg4+NVAtSf4khJEWGwTFg5p90XBlXNvMbZK4aOt4k27mklXFObB+RUiIXqTbf0oR2gKqbK1eb4NnVzphr+gvnLwIN1jdj63QD+Lq8NSd8vv2QE9qrMId6vpf8uRWWSsQIV0V2PuY0amKSdx5nuOr6bAAW5pPOT3v47cATTvj6GSDV2zJCN5KL+r1IT2vIwiKh/Io47cmbJ2PT+hO9o5tOX5zcgfii9iqmwsWw5J8IbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 05AgGKbgo5K+qIo+gJqfnd3tI9mO5ENkLYNr35sPbZ810EesTRhvz1wFsQiGmcJbTGk0ZCd2iTjFqzuc7c7WmTCmT4qASO7nRVG5Sr6IJ++h1txnz7imsqObcAR7oNi10xRgXHnSNc83lZVNfKT0qqyM9yW4b6V2ziUYFMhDJp3JXwpPrfCNlwOYX4P7zZIMHDvTqbuuiF4G4Tsh8nBD28WXrsT4AwXHBqGFXHe9D1mpLj9E4u1odbabT8dwQ1A+f42j6IELfebsy5+fqejLTm6enidC+Eg6px4/svaTgf3h0TcVdgtOE5I0HUbG1v2b05o8H+Jvdtmilx3+TUnpASn6nvuEjWkGyH8jgjGJBLV7prbu5phUYML1ErntBy4O0zBMkf7XOTjn5IkfoNxgScRMu01m8wbzHPDxkK1qJuqzkcIvmVasCFuNvE60Iht8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:14.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385e746d-ca50-41a3-da7f-08dee277b78c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit coverage for connector mode validation and HDMI CEC:
mode_valid rejects interlaced and doublescan modes, set_edid with no
notifier, and the S3 suspend/resume CEC handlers.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +
 .../tests/amdgpu_dm_connector_test.c          | 105 ++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 72c12484d218..3fa2392549eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -356,6 +356,7 @@ void amdgpu_dm_hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
 	cec_notifier_set_phys_addr(n,
 				   connector->display_info.source_physical_address);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_hdmi_cec_set_edid);
 
 void amdgpu_dm_s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
 {
@@ -376,6 +377,7 @@ void amdgpu_dm_s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_s3_handle_hdmi_cec);
 
 
 struct drm_connector *
@@ -2254,6 +2256,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 	/* TODO: error handling*/
 	return result;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_mode_valid);
 
 int amdgpu_dm_fill_hdr_info_packet(const struct drm_connector_state *state,
 				struct dc_info_packet *out)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index f60ce381683e..cfb114d5b879 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4900,6 +4900,103 @@ static void dm_test_parse_displayid_vrr_sets_range(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 144);
 }
 
+/**
+ * dm_test_mode_valid_interlace_rejected - Test interlaced modes are rejected
+ * @test: The KUnit test context
+ *
+ * Interlaced modes are rejected up front with MODE_ERROR before any sink or
+ * stream validation is attempted.
+ */
+static void dm_test_mode_valid_interlace_rejected(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode *mode;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	mode->flags = DRM_MODE_FLAG_INTERLACE;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_connector_mode_valid(&aconnector->base, mode),
+			MODE_ERROR);
+}
+
+/**
+ * dm_test_mode_valid_dblscan_rejected - Test doublescan modes are rejected
+ * @test: The KUnit test context
+ *
+ * Doublescan modes are rejected up front with MODE_ERROR.
+ */
+static void dm_test_mode_valid_dblscan_rejected(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode *mode;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	mode->flags = DRM_MODE_FLAG_DBLSCAN;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_connector_mode_valid(&aconnector->base, mode),
+			MODE_ERROR);
+}
+
+/**
+ * dm_test_hdmi_cec_set_edid_no_notifier - Test the no-notifier no-op path
+ * @test: The KUnit test context
+ *
+ * With aconnector->notifier NULL the function returns early and must not crash.
+ */
+static void dm_test_hdmi_cec_set_edid_no_notifier(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	amdgpu_dm_hdmi_cec_set_edid(aconnector);
+}
+
+/**
+ * dm_test_s3_handle_hdmi_cec_suspend - Test the suspend pass over connectors
+ * @test: The KUnit test context
+ *
+ * Suspend iterates all connectors, skipping writeback ones and calling the
+ * unset path on the rest; with NULL notifiers this is a crash-free no-op.
+ */
+static void dm_test_s3_handle_hdmi_cec_suspend(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+
+	dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_WRITEBACK);
+	dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+
+	amdgpu_dm_s3_handle_hdmi_cec(drm, true);
+}
+
+/**
+ * dm_test_s3_handle_hdmi_cec_resume - Test the resume pass over connectors
+ * @test: The KUnit test context
+ *
+ * Resume iterates all connectors, skipping writeback ones and calling the set
+ * path on the rest; with NULL notifiers this is a crash-free no-op.
+ */
+static void dm_test_s3_handle_hdmi_cec_resume(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+
+	dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_WRITEBACK);
+	dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+
+	amdgpu_dm_s3_handle_hdmi_cec(drm, false);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -5166,6 +5263,14 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_parse_displayid_vrr_null_edid),
 	KUNIT_CASE(dm_test_parse_displayid_vrr_no_displayid),
 	KUNIT_CASE(dm_test_parse_displayid_vrr_sets_range),
+	/* amdgpu_dm_connector_mode_valid */
+	KUNIT_CASE(dm_test_mode_valid_interlace_rejected),
+	KUNIT_CASE(dm_test_mode_valid_dblscan_rejected),
+	/* amdgpu_dm_hdmi_cec_set_edid */
+	KUNIT_CASE(dm_test_hdmi_cec_set_edid_no_notifier),
+	/* amdgpu_dm_s3_handle_hdmi_cec */
+	KUNIT_CASE(dm_test_s3_handle_hdmi_cec_suspend),
+	KUNIT_CASE(dm_test_s3_handle_hdmi_cec_resume),
 	{}
 };
 
-- 
2.43.0

