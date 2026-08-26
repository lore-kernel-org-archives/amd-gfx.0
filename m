Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AC3C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8982310EE62;
	Wed, 26 Aug 2026 23:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OOwRVTaK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B2C10EE62
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHM5SoQDxK9fzswDUqVu7UthAdybxL1/r8enqNW3eyzK9LkOltgNe5ClA9beZZgm2XRCmZEA11KiLwwhvyBKyIiDzMoN3rQJWlGKOvQMvIRyk4hRACmPTqiiF4a8atAa8EWP3m23BGBgEcwZjXpdESMiCUI7zCeiidENkLhKZWU5Yqkoz+j6Ohtnm4YizM75Mw9h4vc8FHoeiEE4co7z8uxcnYy+U9E9bxZi2F88YIvswMm39sYRdkihUUbzug4xZqrY9Za6L2ZHf87wuCowRdiuUTFwp5M7DP6ko/qrMqSVLUWn5bCU5w2IiBZQrIup5nggImRoDFSLYPUyXLc2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFq/TM19bCPCdO50VbVYb6EFbSoWrpqt/QDypxNxxZ0=;
 b=T5RPU3uYPtF+XXIzjU9kHzU24gqHbDFOLeWe2L1ihL+BYqR35K4JM+jTGG++g5GDfCcywgKaupKDYF1bbqE+Ixt7Y+i/RpiXUTEuvTIeOQiZ1wfl+qJSMB8w4BlNGdcM2ELoEF0gHq/sQQ2FUW+U0z6iVTt5TRJdKPuWw6JmuXESzenq64Yk3hkIzCa8pPN78OzHtw15Z5xU/GLIn8BDJ4gkFiMEvKeHDTwtxpVbyBa2qvUhs8Kcbdit12rJeoAFlvm2sN0jVOjaWP9ESZQGbmv5CxCjUmfj6YBWr0qcs5HLb/uUJxt9a2Jn/N82kMCykH5wTqjZ2fwDg9VIvvrEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFq/TM19bCPCdO50VbVYb6EFbSoWrpqt/QDypxNxxZ0=;
 b=OOwRVTaKn9DfKEpEfLvuJLogmqoaUDL1ku/bVHRg9korGjWS5faZROCgh16gBmLquUIBznUXwUgqHyarmn9ClBJrXEoEbZFKI40DTVe37bsRmJYTSgXYK1KPN8emb6biLL33rTOUIdPIrLSCib4UhDrD5Dke/gNP13gotP3ozIk=
Received: from SA0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:130::21)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:32:27 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::71) by SA0PR13CA0016.outlook.office365.com
 (2603:10b6:806:130::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 23:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:32:26 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:32:21 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 49/59] drm/amd/display: Test SW init and fini
Date: Wed, 26 Aug 2026 17:05:20 -0600
Message-ID: <20260826231519.881949-50-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd29ad7-7751-43e3-da3a-08df03ca49ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6r/uJeRuipheG7HMvEfAvn0XsKBtlRl4SCx9Pikszy3noJu8VmCQ8XO+i8VJ8LH0OVRbdGMlGmhJSWo6WMsheSPYtsD1l5H6bdkd+ntr7c/POADG8eUGTAaulVvIQtgqblMrbHErwaKKPaCcKlVx4pwqbrMYRd2ycsPttk81MN4OdL3cmIc9eOIa8elbLF0L7iUgUN9X3MFIq8QAPniqNgGeOS78O4bnkAsMpkQdsw5VVyvAr3TDgzO5+TSBwHQ3qjhPAUpA7uGTwQy24SwfiUYgtE58ybeqO7W1A822H4hZmd0fKAChJIEnreRo6Oatez/OJ/9hPqRc/e2MKluSluKisVw0FiNlPuAgEfyRWfeatucz1XfTBspYTxQbu9a/x7OQ7zQub5QPcBU0RaVe5qfR4DNTJj6h4D8xHUk8QeqiMi4Ie4+hPeeBoiw9qmS/qoT4tSso+lUcYYWfXuwg1ueypi1nbzHOHG/4s+1qkslWVzpF+qRDDLgbIxU3peykHr3DAipyhwpz7smqlinlj+nFVwkdL45Fstlj8f3p8wwaE4dUdYz7TMGHR+QGnJTIeLxFVZlnkEBEnBGpu5P/dRQjyHYXBIgOeUsn7jD4tU+1dbn3/EM4gnG5ccvHuvIHL+3qa+H9K2h7YnFZ+eIh4LoiG+pX6meTlWuzKr9c+xA1R37cyhuZ/ZQ+XHNNcRX4fXu+tWhO8sjxHc7Cf3Rt4w==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XzdPOTQ9IGOVSomG/FV2BgAWs/z1kqBB5yuoFcAHunfTc+1MfhYjU/wecUEPSDgJoJ+TSeGSgIxZtpSSVeBw1HEUfOuMuS63/BCzuYbgPsHBpis9bY9fWsKTb/jQfUklfX0xkjDXYyt1THQeRvLebSavc5W/7efqMr03+w/u9mob+spxNfVtUn8Kl7OiWkn2/KuoJjJ6IMGAyFkDjmf47Jb1XVfRqPBj36gW9UBMoSL17sdG1Nq5QFdxP1JVKZfvxiUWFfVlYuZQlvh+4Cs4ec2wblOvE481PfF+lsERFclD9tzIZYTjhIt94s/ZgEW1v95M/AAUCmFfxOOHOE4j0bfDDGaFWAn8dTJsAbEi8bE8cTWl6/MiBPp1qAMAuPkgBr3LukLEryH0gnLa5fx66lMSxSLn/2jGXz52v8Ozenbt6xbVeFV44RF+fIW5cAOi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:32:26.3445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd29ad7-7751-43e3-da3a-08df03ca49ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531
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
Add KUnit tests for dm_sw_init() on an ASIC without a DMUB, and for the
DMUB bounding box release in dm_sw_fini().

[HOW]
An ASIC without DMUB support makes dm_dmub_sw_init() return early. The
bounding box allocation is left without a buffer object, which
amdgpu_bo_free_kernel() short-circuits.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 51 +++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 128b12a945fc..8b4d01d97ea4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1079,7 +1079,7 @@ STATIC_IFN_KUNIT int load_dmcu_fw(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(load_dmcu_fw);
 
-static int dm_sw_init(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
@@ -1100,6 +1100,7 @@ static int dm_sw_init(struct amdgpu_ip_block *ip_block)
 
 	return load_dmcu_fw(adev);
 }
+EXPORT_IF_KUNIT(dm_sw_init);
 
 STATIC_IFN_KUNIT int dm_sw_fini(struct amdgpu_ip_block *ip_block)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 858fe967046b..80da5a378d73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1254,6 +1254,7 @@ void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 int load_dmcu_fw(struct amdgpu_device *adev);
+int dm_sw_init(struct amdgpu_ip_block *ip_block);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index f0cd2de97faf..8ad6cf0eaa6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3654,6 +3654,54 @@ static void dm_test_load_dmcu_fw_missing_firmware(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.fw_dmcu);
 }
 
+/* Tests for dm_sw_init() and dm_sw_fini() */
+
+/**
+ * dm_test_sw_init_no_dmub - Test software init on an ASIC without a DMUB
+ * @test: The KUnit test context
+ */
+static void dm_test_sw_init_no_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_ip_block ip_block = { .adev = adev };
+
+	adev->asic_type = CHIP_BONAIRE;
+
+	KUNIT_EXPECT_EQ(test, dm_sw_init(&ip_block), 0);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.cgs_device);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+
+	/* amdgpu_cgs_destroy_device() is not exported and is a plain kfree(). */
+	kfree(adev->dm.cgs_device);
+}
+
+/**
+ * dm_test_sw_fini_releases_bounding_box - Test the DMUB bounding box is released
+ * @test: The KUnit test context
+ */
+static void dm_test_sw_fini_releases_bounding_box(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_ip_block ip_block = { .adev = adev };
+	struct dal_allocation *da;
+	void *bb;
+
+	bb = kunit_kzalloc(test, sizeof(*da), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, bb);
+	/* Freed by dm_sw_fini(), so it must not be KUnit-managed. */
+	da = kzalloc_obj(*da);
+	KUNIT_ASSERT_NOT_NULL(test, da);
+
+	INIT_LIST_HEAD(&adev->dm.da_list);
+	da->cpu_ptr = bb;
+	list_add(&da->list, &adev->dm.da_list);
+	adev->dm.bb_from_dmub = bb;
+
+	KUNIT_EXPECT_EQ(test, dm_sw_fini(&ip_block), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.bb_from_dmub);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3840,6 +3888,9 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_load_dmcu_fw_unsupported),
 	KUNIT_CASE(dm_test_load_dmcu_fw_raven),
 	KUNIT_CASE(dm_test_load_dmcu_fw_missing_firmware),
+	/* dm_sw_init / dm_sw_fini */
+	KUNIT_CASE(dm_test_sw_init_no_dmub),
+	KUNIT_CASE(dm_test_sw_fini_releases_bounding_box),
 	{}
 };
 
-- 
2.43.0

