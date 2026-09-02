Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D133C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66C610E6F5;
	Wed,  2 Sep 2026 05:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="weQ1yEXz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD3410ED42
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjae+QV9kJvneKjKo4E8t84KvrJQijvBIDvPRm7Wri5O6ShRHLhkm00k0DnAsPh0rUGZb3qg+7sOBFYkFFa4/c90NPKs0c32x3gsCb2R1FEjtByMsF6ukYJmWhGw/Z/ZnljGm8zj8egOMhO/5noW9SoI5aRsZvzrFeuXZNGiuYBT7PLU2j5WK/GjeilJZuz7kac8SFXcuffYV/uAE7MQDzdILU6CEj3SCj7APPpwQqPk5IawJIhmOONIrag80Yl7DTGez56Icd1t81J6ZtdftuOgBCMbbhRzsOvhwmEA4vyCdk6ecIpnlFFZGtqezC8YCCAp8pXgkc0xKN0Nxj3/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt4B64ebWky/6Zx952GQa+dvCPcIVkX8C5mX/kb9pKM=;
 b=PF8815dWyUylLUc19rADzrodK65QkCwIwaO/U3v2ulmX+YO6PVQg7cHzQOCEf1xZcRiblpy2qPUkCtX8w8ykO7q/2vBkSz/E8q51TXHBhf5LEs4Ql66jdAmu0kTEGcll9Rr6m3eyxBsijHzC5uLCz4VMu+IuzXEFJbgIg7jyMEA/hSi2NyN7VrS0C9FtjEaOkaTNs4o9rMvmS+WXZvFeAMFJfesbEhrlyg4We2mUP5y6mgZxjunsJPDEssAU1r9zE16z5zy8QGZQRM4PGK5XcokZnC+ydEsJIocQkYGxSjQwGoMb1qfoA7aJvZzkm4HRhDqf6qyVA3wLuM0XYyFNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt4B64ebWky/6Zx952GQa+dvCPcIVkX8C5mX/kb9pKM=;
 b=weQ1yEXzHK7p6lt4dC+NLzPNBIg5ja2d3ST3YAlAcolnzECiG05c4Ny4V7doRg8YQBe6+u+sj9QrJ6Rg6EVQsnIFcumVnT7KMdhhR2zVCv71BO89KcqL90U0FznVZxPX1KW9VgbQew3QtzY7rSFORyV6EFkNYLInch1/S4UGqLE=
Received: from BN9PR03CA0724.namprd03.prod.outlook.com (2603:10b6:408:110::9)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:05:37 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::65) by BN9PR03CA0724.outlook.office365.com
 (2603:10b6:408:110::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:05:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:35 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:05:26 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 08/40] drm/amd/display: Test MST resume guards
Date: Wed, 2 Sep 2026 12:58:30 +0800
Message-ID: <20260902050411.3473916-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5bfda9-4b9c-4d41-e184-08df08afd380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: znsolStNx8fT1iNVjICQcMmgIZ+50uor+C1MIFJOlnppjE1nd/bRULF34eEDxoUCUz32ONwnvzhvRD6VRMQ/SmrqW4Q63AKeuKMKhkRrdc/ulB547UczoViQpZaoDoCAgPAgiLOLgQFHGBi4DI1y68F9Lucbix/cmVddygWcP3bigWAiwZdckmVzFmXhPD8FLDKTbZbNoOEB9OB3Ikaxfuupg+GuaoI/RAQglJs2NM/ohQoqs2EhRZ//skt0elv9iXpUGS14ew3HKh68xXD8bRqEWad+T9gMIcQT5l+5oLtCD905KEP/JAyhucNPJE1vM0pTstinznTS1av45hR1XwaSkr3rtO99mdX08rgRmdF9AuwfYHcMqwYrLDEjtIxZMCjtTzT5tHeaYed2yE8im3Bv5hzCpZQN5/1OmMsyPAAtzr3W0wzZSi8sx0PSFATJMmrdUDlPeJbKYFMzxlthExePtYW9FWDozguw5iQQ2RDIV/0g4JzzDV659jIe8rNY5O5rbSMQPl+YtDkjL4LXZD/1PUo7EuWnsUKvH+t/TuSrEM+8Ga73IVvDOdpCmM6FdSeBv9yT3nFBacy7+H2p8S5Kf8Rv23J/Lk/phx+kCqow1QAIPtAtJTGe/nh61ioG/exB/iHUsHIJt88c/55+u9KjL1o3mPfqRmSBy73Cqd3jVuLCI5VYHvTSDPV1sQEEMDsRX1Oo0f1yfLx9wlIb+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8+ivhArgBcyKnKPqTB6K0AstKpm6ynEegKEnvl35fq2dAL6bHDQX0+OwEiNchLufbPSA10Yz+zq9FWcPXRAmpGnfNyKTDSB/fnFjQ1wRh89SaWwngtahOz1LgupjHHqi99S1RQFtCVTFO7u3l/UO/XRekbD5JB7IYi1uHTYexEXoJKFNBJmztqnn37IjXhlt1Mrdm5VAv7vK2HSFhM/xBVwhhVdG5o8DHksJFygt3yIBdb4mIpu7ZxKlbHQhvsJHiPFEsb65ValGGMIoRqTySMh0yDJ2JXdE+DWacE9aOpOmjiWUMka1oYsazlAI3lkS0A5FSFBKisdSDR+aUF1QO6J/7IqpYDv3EOnw7+EQeiHAVyhilXGM/ErnQGnThHP98kim13aCp+7OPG1nB0+r0+PmmEJx2hAPk6mOosQYyVPJZShUgZcP4UBSSyqQmsnr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:05:37.0242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5bfda9-4b9c-4d41-e184-08df08afd380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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

[Why]
Add KUnit tests for resume_mst_branch_status() without a primary
branch and s3_handle_mst() with an empty connector list.

[How]
Use the real topology mutex and DRM connector iterator. The tests
stop before AUX or topology-manager hardware operations are required.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 33 +++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0eb813206837..9b1ffc04c761 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1252,7 +1252,7 @@ STATIC_IFN_KUNIT int dm_late_init(struct amdgpu_ip_block *ip_block)
 }
 EXPORT_IF_KUNIT(dm_late_init);
 
-static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
+STATIC_IFN_KUNIT void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 {
 	u8 buf[UUID_SIZE];
 	guid_t guid;
@@ -1302,8 +1302,9 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 out_fail:
 	mutex_unlock(&mgr->lock);
 }
+EXPORT_IF_KUNIT(resume_mst_branch_status);
 
-static void s3_handle_mst(struct drm_device *dev, bool suspend)
+STATIC_IFN_KUNIT void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
@@ -1344,6 +1345,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 	}
 	drm_connector_list_iter_end(&iter);
 }
+EXPORT_IF_KUNIT(s3_handle_mst);
 
 STATIC_IFN_KUNIT int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index df2e4d60e85a..739171d5365c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1215,6 +1215,8 @@ void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
 int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block);
 int dm_sw_fini(struct amdgpu_ip_block *ip_block);
 int dm_oem_i2c_hw_init(struct amdgpu_device *adev);
+void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr);
+void s3_handle_mst(struct drm_device *dev, bool suspend);
 void dm_gpureset_commit_state(struct dc_state *dc_state, struct amdgpu_display_manager *dm);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 bool update_planes_and_stream_adapter(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index ed53bfa5a8c3..833f73972ab2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3296,6 +3296,37 @@ static void dm_test_oem_i2c_hw_init_no_device(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.oem_i2c);
 }
 
+/**
+ * dm_test_resume_mst_no_primary - Test a missing primary branch releases the topology lock
+ * @test: The KUnit test context
+ */
+static void dm_test_resume_mst_no_primary(struct kunit *test)
+{
+	struct drm_dp_mst_topology_mgr *mgr;
+
+	mgr = kunit_kzalloc(test, sizeof(*mgr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mgr);
+	mutex_init(&mgr->lock);
+
+	resume_mst_branch_status(mgr);
+
+	KUNIT_ASSERT_TRUE(test, mutex_trylock(&mgr->lock));
+	mutex_unlock(&mgr->lock);
+}
+
+/**
+ * dm_test_s3_handle_mst_empty - Test empty connector lists need no MST action
+ * @test: The KUnit test context
+ */
+static void dm_test_s3_handle_mst_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	s3_handle_mst(&adev->ddev, true);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->ddev.mode_config.connector_list));
+}
+
 /**
  * dm_test_gpureset_commit_state_no_streams - Test an empty DC state programs nothing
  * @test: The KUnit test context
@@ -5127,6 +5158,8 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_early_fini_audio_disabled),
 	KUNIT_CASE(dm_test_sw_fini_releases_state),
 	KUNIT_CASE(dm_test_oem_i2c_hw_init_no_device),
+	KUNIT_CASE(dm_test_resume_mst_no_primary),
+	KUNIT_CASE(dm_test_s3_handle_mst_empty),
 	KUNIT_CASE(dm_test_gpureset_commit_state_no_streams),
 	KUNIT_CASE(dm_test_emulated_link_detect_bad_signal),
 	/* mmhub_read_system_context */
-- 
2.43.0

