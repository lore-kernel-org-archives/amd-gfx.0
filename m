Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844FDC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0071F10EE61;
	Wed, 26 Aug 2026 23:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FhEDDk12";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA26510EE61
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpJFqbUG64GpqYxSP+ply8WObU1R5vjwk6rcAMjMItM0sETvAQkSk/iGov7V+XKfn6BnjzkFSjQz9ZDGCmUeQGueL00ADU4P8WJtX9WIn626jwWg7IyQZS6Dx1vLM4SRtFJeXw+Sz8BNYgWgrmkcZ/bq+A3AL3Y/nUUKhGHdRUpZ/OTqOJIhkh2CoU/isYLBphQk5/buSzyx2lNOJpTOK3obu5mgFu1HSPryVHLjT2ulnjfT/49ZdtdsYhBuz51+4YLRr+hc/92l8S6xPHgVVgrvfY+dXpz5dKkHM429uSid+pUI5zVb7PdFszwoPqp6Lg4HfDncDjOSpO+ANrBTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90k44fqrKKlBg8MSP+4KcNhv/fB+rVJUVXZjsPo1+HQ=;
 b=TNG5LfC8xZziCROJfmOP2m1ru3Cd+wwnwVOLlNyDeHu2x1Kbl3rRg9L1kCDy2UsRsf78UrwpvsX4WI/1Hb6PUFlUSaF07ZB9YvsVrjAbv8K/mSRYWnRt+LPRDvrirjEs7/aT46wDaI5DRVWmXQ1oQIKEww47FgNgDDJGzZtNOPrCzMLv2bjH8dond3VU4h2pCMPLoljjHSfoeoJqOYIKspPQScCHyBEwtOZt6vrnsPq5b1FSOrjWgPg1tfz63gAjC1MmYnIkQ5wpFhHt+YxFZA86HurZMlf/5ggPoYGn1SFem1MqgDZ9W0MFeoVcjo0JIH0Hrei2fDhOmBqFt3w7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90k44fqrKKlBg8MSP+4KcNhv/fB+rVJUVXZjsPo1+HQ=;
 b=FhEDDk12H+apIepAT4/M+9LewevQyGnYUWgjIKsP5eDh7re8WBgZ8iqAzpTQOOekiGIZhN8TPDGHDmAkVq9kw1iQiAvW6JWZj6M76FR31LK2/VnBfAqQ8Vb7Y1attiysXafnX4nVVHr/FlDKkws3nHo+zw60zlqlupao6ciGhAQ=
Received: from CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::18)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:32:09 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:610:ef:cafe::5e) by CH0P220CA0012.outlook.office365.com
 (2603:10b6:610:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:32:08 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:32:03 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 48/59] drm/amd/display: Test DMCU firmware load
Date: Wed, 26 Aug 2026 17:05:19 -0600
Message-ID: <20260826231519.881949-49-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c04605-a79c-47a0-d03d-08df03ca3ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TW0z956dXwMIw7rnGvRYjlqcMLpLAFnZ7Yga/UvrseV9fWBB+eecymX+u0tv/liC/RY0MuPUd+CDpEnK6teeVYmX+0kRSkaSllAXWeyqn49V5MnYpqMLFYE7L9HYJNXNo6xFcOqYVurnVHKT6Yi5SzNLgSAaUfRhTCnezEVmb9s1vrzK40UAzj9H8drBLG+rmwsrApoyfSd695aYL+zPsuKQXIpi9ZrQpemhdJFYjSCDF2LgXnsNthG5Lop9wLCnCBBibZoH4HU2eKUxJGi9zd97ff+Jmu79pJZMoebcXL0mfM7GtuNg0ds47l7kSMJrPKvSThNaK27e4eu8A/H6BlVhOrs8xiaDIG16l1zzEzOMJ2U4roS7+k88Qnh3ZiEI5V3UCIYFV6Xh+dKBXkLuWffA+z/vEpR38LRzDiyC5J5V6rZ57dGt2X0flvKjU/PdhZsd7ZNKiiThJiXrIsdIdHAHH+pMceebpfCwY/6gSNC6UqUjA5oSiUd3o0ujrSJ/m75spRRmBBHUgITd78Am9LcM6kPl4X/BD2rWuHZr3dm5vszSaPOo6b/ein2hmWu76u/CtJNFiooYCnOgmlHibi4GL9RzUHxSFTJi4JAr6rl7G6N67SVoxdyLroAz8Wf90fFc8XzMrh9E/Hki5isqDEtVn3ZOqgwMYA9Af3AcNjjM7tB7sOAWXmtURfN7C8SDqz52EGThFz+mgNFpPRzIpw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V6T+WICDVRDfZn2kCjTcESs22pA6HYWwxK3WfiP4LegDSuVp53NP6ZTk0lCWArydHmd7m0cOSxMdqLDwim+UxI6XjhycjhpwZ8FaW67y1Tr9QddbkiUdY9my/ZWA0QexAQG6AR2/KWEyqvAjpkGKh/+2tF+H9Gafi7iy+JTHN8FSONRiPhqlShvrG4NiZzGANpIvQIoNQMJ59DMPdKjai1nwEv31jkn8ONW51IcLTAPq174ldaiAQNWvnXSG5jqaxObeVt9CnEgcz+OsbjBQLWWNb+J6VttZvNcXv2lzfczhJfod0xXC8ErTowlr01OlehoqsWxJmSQGfLp6JEqFMxFtZO5I+zfqgGZlSsba2hW58YnHy6ezWMwFkienqYM0TAofeFmIJ32qGsOZCW+lD0gdUI3di28rcmdsYCBqqmhPwl3NCmPZI3cnw7X8AR4r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:32:08.1213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c04605-a79c-47a0-d03d-08df03ca3ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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
Add KUnit tests for load_dmcu_fw(), covering the ASICs and DCN IP
versions without a DMCU, an unsupported IP version, the three Raven
revisions, and a missing firmware image.

[HOW]
No firmware is installed in the test environment, so
amdgpu_ucode_request() reports -ENODEV and the missing image is treated
as non-fatal.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 101 ++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3d2a9e014797..128b12a945fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -967,7 +967,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->dm.dpia_aux_lock);
 }
 
-static int load_dmcu_fw(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int load_dmcu_fw(struct amdgpu_device *adev)
 {
 	const char *fw_name_dmcu = NULL;
 	int r;
@@ -1077,6 +1077,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(load_dmcu_fw);
 
 static int dm_sw_init(struct amdgpu_ip_block *ip_block)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5e9d0b203a0f..858fe967046b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1253,6 +1253,7 @@ struct dc_phy_addr_space_config;
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
+int load_dmcu_fw(struct amdgpu_device *adev);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index d1a25b3e68c5..f0cd2de97faf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -21,6 +21,7 @@
 #include <drm/drm_writeback.h>
 
 #include "dc.h"
+#include "dal_asic_id.h"
 #include "dm_services_types.h"
 #include "dmub/dmub_srv.h"
 #include "inc/core_types.h"
@@ -3559,6 +3560,100 @@ static void dm_test_init_power_module_alloc_failure(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.power_module);
 }
 
+/* Tests for load_dmcu_fw() */
+
+/**
+ * dm_test_load_dmcu_fw_no_dmcu - Test ASICs and IP versions without a DMCU
+ * @test: The KUnit test context
+ */
+static void dm_test_load_dmcu_fw_no_dmcu(struct kunit *test)
+{
+	static const enum amd_asic_type cases[] = {
+		CHIP_BONAIRE, CHIP_HAWAII, CHIP_KAVERI, CHIP_KABINI, CHIP_MULLINS,
+		CHIP_TONGA, CHIP_FIJI, CHIP_CARRIZO, CHIP_STONEY, CHIP_POLARIS11,
+		CHIP_POLARIS10, CHIP_POLARIS12, CHIP_VEGAM, CHIP_VEGA10,
+		CHIP_VEGA12, CHIP_VEGA20,
+	};
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		adev->asic_type = cases[i];
+
+		KUNIT_EXPECT_EQ_MSG(test, load_dmcu_fw(adev), 0, "asic_type %d",
+				    cases[i]);
+		KUNIT_EXPECT_NULL(test, adev->dm.fw_dmcu);
+	}
+}
+
+/**
+ * dm_test_load_dmcu_fw_dcn - Test DCN IP versions report no DMCU firmware
+ * @test: The KUnit test context
+ */
+static void dm_test_load_dmcu_fw_dcn(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->asic_type = CHIP_IP_DISCOVERY;
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+
+	KUNIT_EXPECT_EQ(test, load_dmcu_fw(adev), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.fw_dmcu);
+}
+
+/**
+ * dm_test_load_dmcu_fw_unsupported - Test an unknown IP version is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_load_dmcu_fw_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->asic_type = CHIP_IP_DISCOVERY;
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(9, 9, 9);
+
+	KUNIT_EXPECT_EQ(test, load_dmcu_fw(adev), -EINVAL);
+}
+
+/**
+ * dm_test_load_dmcu_fw_raven - Test the Raven revision selects a DMCU
+ * @test: The KUnit test context
+ */
+static void dm_test_load_dmcu_fw_raven(struct kunit *test)
+{
+	static const u32 cases[] = { PICASSO_A0, RAVEN2_A0, 0 };
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	unsigned int i;
+
+	adev->asic_type = CHIP_RAVEN;
+	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
+
+	/* Picasso and Raven2 name a DMCU; a bare Raven has none. */
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		adev->external_rev_id = cases[i];
+
+		KUNIT_EXPECT_EQ_MSG(test, load_dmcu_fw(adev), 0, "rev 0x%x",
+				    cases[i]);
+	}
+}
+
+/**
+ * dm_test_load_dmcu_fw_missing_firmware - Test a missing DMCU image is not fatal
+ * @test: The KUnit test context
+ */
+static void dm_test_load_dmcu_fw_missing_firmware(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->dev = adev->ddev.dev;
+	adev->asic_type = CHIP_NAVI12;
+	adev->firmware.load_type = AMDGPU_FW_LOAD_PSP;
+
+	/* No firmware is installed in the test environment. */
+	KUNIT_EXPECT_EQ(test, load_dmcu_fw(adev), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.fw_dmcu);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3739,6 +3834,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* amdgpu_dm_init_power_module */
 	KUNIT_CASE(dm_test_init_power_module_no_edp),
 	KUNIT_CASE(dm_test_init_power_module_alloc_failure),
+	/* load_dmcu_fw */
+	KUNIT_CASE(dm_test_load_dmcu_fw_no_dmcu),
+	KUNIT_CASE(dm_test_load_dmcu_fw_dcn),
+	KUNIT_CASE(dm_test_load_dmcu_fw_unsupported),
+	KUNIT_CASE(dm_test_load_dmcu_fw_raven),
+	KUNIT_CASE(dm_test_load_dmcu_fw_missing_firmware),
 	{}
 };
 
-- 
2.43.0

