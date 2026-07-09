Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB41EC44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CF310F70B;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rEttHxNm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE6210F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTaTJQ4OtTe5mOTnT7eq71VJFfKZhhirZr8zpH3GsaWdKkgeXm5wu0ceJMYIY5mb0BSedKi0sNcB5bUMQfuK6Qxwc8pgr2I08KbJAud6mdfhb7UbETmQ9OSW5XUu0OxOM91zicW7Oz1dI59HM03FNeUHX0jOj5U/JJiLN0PxIBeMH0F5R23sC3O+ElJLUa4Q9fuXtA8/aJLCa+TLf3sVoPxRpoEsP7kIE3nYMVU16Ulw90vdHODSKUneSnbCwlEbQZzp0zXytPBcKhSBWicH11Ci9v04vk5aHI1MJawHp3JE1lb5Yohm9w8qGBOM1sWw7zfoGBf83xw7e/VZ6JkJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWhsNb2dRm1YI8Sorx2AJZ2gbOshwWzzXg9mBgeMsu8=;
 b=t0FdCjJ6UG2MxhSDrlgXAUs6NgW5cbYSJaJb0YMnn6m9FIAgJD2z9OpG84m3Sjm6PEQz7X+1HVOb6TaogDV8jEfQQZ4aHFhREeC3iaZS5PYc8BE6SboMDkUBH71Taybf5C5YabxZJh8d0iwmusqLmee/kqNYk7wODLkIplM349ATJMzVbEU0YWoFHPSuvstpa+htM9Qt5bN+BzKVCBFT1is84UtFMxYMca/yWXjLrqygyTXrZQ+lyEVYttGA+bvxf6mpbIoM0w5twoB3ovplEzFD+EI0S0ZDUriQHB7fcjeIUPlFo8SY4U82Jt91G7DA4k2nHVVRnP9OmgnIMKV47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWhsNb2dRm1YI8Sorx2AJZ2gbOshwWzzXg9mBgeMsu8=;
 b=rEttHxNmIf6eidiqUP1LUKGap+nOeIsOYlv8MfqVzTzQa1rQBIfhDdXZdrakpG6VMMhtiCKw+UqiB1IghXw4MxSEHe6FLWYwRmUQcobwCLrGCF4D3jsU1+/EeakS/2BQqPwcDJMv0kzWjnkOFQQ+iw3ieSiwa3XVbaPV7NNVd0Q=
Received: from BN9PR03CA0488.namprd03.prod.outlook.com (2603:10b6:408:130::13)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:37 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::24) by BN9PR03CA0488.outlook.office365.com
 (2603:10b6:408:130::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:36 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:29 -0500
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
Subject: [PATCH 69/80] drm/amd/display: Add MST link detection tests for
 connector
Date: Thu, 9 Jul 2026 16:48:37 -0400
Message-ID: <20260709205936.5719-70-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: fa12e525-2d99-4dee-bc55-08deddfd67b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cASMDzofiwBRK/k2Tl7rScCoLNEH8ilq5ui2NnPXaoRhL4qPaJi+0dJ4fa9ki3D/m+NRKDx9l5o1HQv5WmtPQCb92i4XGWyfsc1qIYUyyjI2YLZ9idppPz3QC4rjw+qaoQN93UDKs0E2ASFlEPW0aGRlvKnOkKuK8OV8VFNljXM7K1zsCEN0xriBw1daP1ZMx/EGYWFe/RoJh0i2T/vSxb0BimJU+bEDsVm6fgVcuc3E2ZRyMxLgMbCpjBOxyyDWd0vBmFjidaxLqumC9NbCWzfuJoSv1LE6Uwgh5e8A4Hl/G/CbP5eM4jRFRRktHmeizVit3vQywMI97a7GnDUGj1t1JHd5d6EEGL6Hi22QHSOltSELw5qn+ngTLeWqhi8diuxdLWqc56pHT2AEf07rCSnbyGUCG/YRQKEETUb9Y6/S+XJYMfK7JP+5sIHDAHF8ZN2YvTIT5F6c4hxRwggsL4MUV7rO+mO6Pqh1wslbpN78uqGIqiC8eTNyEi6hiW14q0BNsXCbOLsRT9cPL6vDroAOUjdDBISw2VuMwmdFeWda8MxvscuWSDPm5v/XqKsoUwqsJuzDKNZQ3uhdrsPGkp5wQwPEnhMJ9ZA4UOMuZyeQLl9iufyyxuR6yvspOoIygyh8/lsmlIFwQQ2AS/JUJlqYfLRNhuCmeGsZS/+38q5T5rj4riXFeggW6UptvqNQY/aWharC1uUKVKLdbqEidQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AXuptIS8wobDL9mWHXBu9X14MJXUTu8hTGXqOdbOqAS0u9D4tAHE3m/+NaoMvR6rZeuCGpiB3X4A0UwgZ1Ab6xfoJlYzrx8dmj7sLB5OGp0BooFqCsuyTIfcFP5I/EFIxmGTcxXf5M+Kk5Is5at48bVDIem1wliT7f+MUBcyT5TAbg3FU3qr38kWvDm9l7jKBc6oKiXDPHpKjy9J3VrAphkd55uMV762F84oajFJYmpQRWYOZ7PZCyioPljcuW2BohtAL1VO552xNB7yNjOFDP5xdnKb76hhw0Y/i1ks3UYz38EhJr4yRV8QHRtHkOd7gbx8BoCIbnl9cdAGgE2XAyDgdie9QQ5mvjBU8fqrJjboE1kTLLJwJ6j2/Dl79r2G5O0moEG2L4DaRi60ZP6RpTJwuOM5I+mfGBwFu53bMMUhigpXVSi5qW8aJCEDgskB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:36.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa12e525-2d99-4dee-bc55-08deddfd67b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
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

Add KUnit coverage for amdgpu_dm_detect_mst_link_for_all_connectors()
to the amdgpu_dm_connector tests:

- No connectors registered: iteration body never runs and the call
  succeeds.
- Writeback connector: hit by the early continue
- Non-MST link
- MST branch without aux: NULL mst_mgr.aux

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 129 ++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index e018cf639909..2c213bed8a6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -331,6 +331,7 @@ int amdgpu_dm_detect_mst_link_for_all_connectors(struct drm_device *dev)
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_detect_mst_link_for_all_connectors);
 
 static void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index aa274f5e4b84..0dcc13e7f0af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2772,6 +2772,130 @@ static void dm_test_fbc_init_no_modes(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, ctx->adev->dm.compressor.bo_ptr);
 }
 
+/* Tests for amdgpu_dm_detect_mst_link_for_all_connectors() */
+
+/* Allocate a bare drm_device suitable for registering connectors against. */
+static struct drm_device *dm_test_alloc_drm(struct kunit *test)
+{
+	struct device *dev;
+	struct drm_device *drm;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,
+						  DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	return drm;
+}
+
+/*
+ * Allocate an amdgpu_dm_connector and register its embedded drm_connector with
+ * @drm so that drm_for_each_connector_iter() and to_amdgpu_dm_connector() both
+ * resolve to it.
+ */
+static struct amdgpu_dm_connector *dm_test_add_connector(struct kunit *test,
+		struct drm_device *drm, int connector_type)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	KUNIT_ASSERT_EQ(test,
+		drmm_connector_init(drm, &aconnector->base,
+				    &dm_test_connector_funcs, connector_type,
+				    NULL), 0);
+
+	return aconnector;
+}
+
+/**
+ * dm_test_detect_mst_no_connectors - Test the no-op path on an empty device
+ * @test: The KUnit test context
+ */
+static void dm_test_detect_mst_no_connectors(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+
+	/* No connectors registered → iteration body never runs */
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_detect_mst_link_for_all_connectors(drm), 0);
+}
+
+/**
+ * dm_test_detect_mst_skips_writeback - Test writeback connectors are skipped
+ * @test: The KUnit test context
+ *
+ * A writeback connector is hit by the early ``continue`` before its dc_link is
+ * ever dereferenced, so leaving dc_link NULL must not crash.
+ */
+static void dm_test_detect_mst_skips_writeback(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_WRITEBACK);
+	/* dc_link intentionally left NULL: it must not be touched */
+	aconnector->dc_link = NULL;
+
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_detect_mst_link_for_all_connectors(drm), 0);
+}
+
+/**
+ * dm_test_detect_mst_non_mst_link - Test a non-MST link starts no topology
+ * @test: The KUnit test context
+ */
+static void dm_test_detect_mst_non_mst_link(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_DisplayPort);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* Not an MST branch → the topology manager is never started */
+	link->type = dc_connection_single;
+	aconnector->dc_link = link;
+
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_detect_mst_link_for_all_connectors(drm), 0);
+}
+
+/**
+ * dm_test_detect_mst_branch_without_aux - Test an MST branch with no aux is
+ * skipped
+ * @test: The KUnit test context
+ *
+ * The condition short-circuits on a NULL mst_mgr.aux, so the real
+ * drm_dp_mst_topology_mgr_set_mst() path is never reached.
+ */
+static void dm_test_detect_mst_branch_without_aux(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	aconnector = dm_test_add_connector(test, drm,
+					   DRM_MODE_CONNECTOR_DisplayPort);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	link->type = dc_connection_mst_branch;
+	aconnector->dc_link = link;
+	/* mst_mgr.aux is NULL (kzalloc) → second half of the && is false */
+	KUNIT_ASSERT_NULL(test, aconnector->mst_mgr.aux);
+
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_detect_mst_link_for_all_connectors(drm), 0);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -2934,6 +3058,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_fbc_init_non_edp),
 	KUNIT_CASE(dm_test_fbc_init_already_allocated),
 	KUNIT_CASE(dm_test_fbc_init_no_modes),
+	/* amdgpu_dm_detect_mst_link_for_all_connectors */
+	KUNIT_CASE(dm_test_detect_mst_no_connectors),
+	KUNIT_CASE(dm_test_detect_mst_skips_writeback),
+	KUNIT_CASE(dm_test_detect_mst_non_mst_link),
+	KUNIT_CASE(dm_test_detect_mst_branch_without_aux),
 	{}
 };
 
-- 
2.55.0

