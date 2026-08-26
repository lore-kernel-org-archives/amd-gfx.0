Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088EAC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8820510EE65;
	Wed, 26 Aug 2026 23:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1HiIW44s";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD8610EE65
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+LwMpet2fxIXmF4CMRk/NgQCvWBEOL7sr06udcPdUJU6R+Et20bIyAcsADN1VTdqZT3VWKKmeBGPudeQ4VZNrNzzPBqvJGw8rnq0Y5befgCBuCearV45xGC0T1FtGTCZ1ihZ4S1aG+15Lh09eJS3TtAOprKpzMFsA+RaQtMhkkjWUkuz1cL5PeKebm392bfgsLR8A5FcLVpzxjZzyXiJ0KGeZDhcqDXxAA3+cXJrnD/md9JI+0GCnr1eoHHJOVHTRHq7oQHjujIbp+GQ1G+2cIrW0jvxTHbKn5W+34nP9M8tfFpoF3+dHoVq/tm28JQyOss5LtslNnF0ErVbW9zhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg30WpTrvIHiSiF+7SkjAOwhZI/OYDpqv/4YfjEBGYk=;
 b=t+TME+3p7r/YR7gq4TR78DQfYi/tKCOQLNpuAUtiv0xeBlssxJrvccXcIIgIN5ZRUOQxiL+53zpoIAvWqiExNonfemMz9pKwZRxBJ3ycmtiQslwkShe6bl61HzpA3SScTwFo9rDuNAPtXj819P6EKQRTKJxOS2M93FGgERCdpL20b7o5rQpptpgDFgiAvzlaMBu2/55Nkt0ixMJ+RVXyj+1uNlWsPRxaPyEAxwh+9k3Xhj7q//9Af0QbRl81fXsClHJPuYogmMdfZD6FeincVTFP97FmmDYhyAzOW4XM03tKfMbWCuuALTbs8mj/x3KCZUUpnApGC1+JbhGo6qWvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg30WpTrvIHiSiF+7SkjAOwhZI/OYDpqv/4YfjEBGYk=;
 b=1HiIW44sWnkwVC2IO+NA0seQ8J1NKVd/dikEx8ifUBL4IAKFlJr6PXMHBtC0bGY5asIhk6MKOtNijgzrB10sQNmAb04K+XBHmzTIvuN2sf0FDIhmFxyjGeWHVQiH5kAsA0771YWGLVOvCzALXfQWtjYxFVV87VKqLK6bGbieV2s=
Received: from SA1PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:2ce::7)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:33:22 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::79) by SA1PR04CA0003.outlook.office365.com
 (2603:10b6:806:2ce::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:33:22 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:33:17 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 52/59] drm/amd/display: Test DM early init
Date: Wed, 26 Aug 2026 17:05:23 -0600
Message-ID: <20260826231519.881949-53-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: f59d1948-ba9a-4d52-40d4-08df03ca6b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4iSnMXKo1WjlJ6hHwayaP9nY3iGame1nelWikAuZLCumDfObu4pGkCCMNzx6jC+tPkUjSufPev8KYEQiS9p97OzFzeutah4vTic+KRqaMTLDFKVAijFfZkXKD48eL4L0se62pA7+F7NBgxP4o6du/b+PP2ySt0EhyGLB+Qlfw96nV1uwIkqq1tx7MKbQd68GtQ34lmNzV292my2Hnqwbj3heOVQuLN9pLs1g5rIRbag/ZSmFO5nG7qQyiwraZQNGZ47Hq6Lny0aXSx62Jmk2v/dVGggc/aF3/cVLAof8i0RUOSqIufYNZsSUM62m8eFMT6WPrj3bkrOg9Y8MvmHQZx5h9QpqPusdzZLh1qBu1w1vEMEvSReprQPcvHYwg7mKwaO0+DAPXMEeFMfQSEVEoFEgfqceQv7x/Un7KrZfoqAcYfjq5E7nSVTcwMFsek9bRCIkZKfvrUvIqYejQ1YPO6g2uQOoYGjSycPsc6Ej3IfXHEfPZoGEQPYH2f15i6dC2p54aumMK2VSI9mldkyBqTYpaxGL1w5wgS0yIE41De9Kkm8gEneMqmXFdPNl/cWKtz8TsO6e4RL0QwNZoqnbpApB9xmfw4HiFJwAkYaiIXgUc9deQbNMy3J5SjV1j0+awZTtFqEfCM+YZi9j10FyVDpY8W7GVW5cO7CFVS2w05I+cvLO4FwjMQQJayeOIY0ufvxsDpPeNvFUbIAJkt6t4A==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NkeYC7o/x5TdcqNYsTYbSu4g+ClDDDpfDE+9HbTvBsJT//apVmxH5uxCgUt1ggYKjt73AfNA4I/nZI3A8TzSEGH1D9Ugr/Cn+S89wiTjLUTD4ooDZQLq91EVMA1o6VPqyLpnx0nu07sM6B8nDqzckjRpiMDoqtEQc1CE8793fa3T2e+vnyZtUo6WgWCmQ4m40qZ2Xt6K4mW1ZMp/6+ITfsj+ypE8TC7uwlWVs64jblgx3HRdOpbGXFK7iUMe2IZ10rHPqUnkPGndVuZkhkc0L2Z7dIeweu76L4Ke3HnVAxvQ4xIr3FHZaoJOm/WR2f332shNJtYLHMnDGHvaeMiDwySLaXLwZhderZehpcvLUafvppvy8HS8x2uV/bLQ85C5TmKWOcPvpXob53NeO1MsDegdomLivFjRbX0iWa4327BWlKCFcGNh4twaxO2/Jgzv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:33:22.3613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59d1948-ba9a-4d52-40d4-08df03ca6b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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
Add KUnit tests for dm_early_init(), covering the display counts of the
legacy ASICs and the DCN IP versions, a BIOS without an object header,
and an unsupported IP version.

[HOW]
Add a fake ATOM BIOS image whose master data table reports a present
entry, which is all amdgpu_atom_parse_data_header() checks here. Only IP
versions without DMUB firmware are used, so dm_init_microcode() does not
reach a firmware request.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 168 ++++++++++++++++++
 3 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd9f44326ae3..0ac4711b62e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -307,7 +307,7 @@ STATIC_IFN_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 EXPORT_IF_KUNIT(dm_set_powergating_state);
 
 /* Prototypes of private functions */
-static int dm_early_init(struct amdgpu_ip_block *ip_block);
+STATIC_IFN_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static const struct amdgpu_dm_kunit_ops amdgpu_dm_default_ops = {
@@ -2751,7 +2751,7 @@ DEVICE_ATTR_WO(s3_debug);
 
 #endif
 
-static int dm_early_init(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
@@ -2901,6 +2901,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 
 	return dm_init_microcode(adev);
 }
+EXPORT_IF_KUNIT(dm_early_init);
 
 STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 19c6b29947f6..88fa4292c5cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1254,6 +1254,7 @@ struct dc_plane_cap;
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
+int dm_early_init(struct amdgpu_ip_block *ip_block);
 int load_dmcu_fw(struct amdgpu_device *adev);
 int dm_sw_init(struct amdgpu_ip_block *ip_block);
 int dm_late_init(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 58472b4d5388..7d0b5d8f06a1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -30,6 +30,7 @@
 #include "amd_shared.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
+#include "atom.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_audio.h"
 #include "amdgpu_dm_hdcp.h"
@@ -3562,6 +3563,168 @@ static void dm_test_init_power_module_alloc_failure(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.power_module);
 }
 
+/* Tests for dm_early_init() */
+
+#define DM_TEST_ATOM_BIOS_SIZE	512
+
+/*
+ * A fake ATOM BIOS image. Every byte is non-zero, so the master data table
+ * reports a present entry for whichever index the object header lives at,
+ * which is all amdgpu_atom_parse_data_header() checks here.
+ */
+static struct atom_context *dm_test_alloc_atom_context(struct kunit *test,
+						       bool object_header)
+{
+	struct atom_context *ctx;
+	void *bios;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	bios = kunit_kzalloc(test, DM_TEST_ATOM_BIOS_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, bios);
+
+	if (object_header)
+		memset(bios, 0x01, DM_TEST_ATOM_BIOS_SIZE);
+
+	ctx->bios = bios;
+	ctx->bios_size = DM_TEST_ATOM_BIOS_SIZE;
+	ctx->data_table = 0;
+
+	return ctx;
+}
+
+static struct amdgpu_device *dm_test_early_init_adev(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->mode_info.atom_context = dm_test_alloc_atom_context(test, true);
+
+	return adev;
+}
+
+static int dm_test_run_early_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ip_block ip_block = { .adev = adev };
+
+	return dm_early_init(&ip_block);
+}
+
+/**
+ * dm_test_early_init_no_object_header - Test a BIOS without an object header
+ * @test: The KUnit test context
+ */
+static void dm_test_early_init_no_object_header(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->mode_info.atom_context = dm_test_alloc_atom_context(test, false);
+
+	KUNIT_EXPECT_EQ(test, dm_test_run_early_init(adev), -ENOENT);
+	KUNIT_EXPECT_TRUE(test, adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK);
+	KUNIT_EXPECT_FALSE(test, adev->dc_enabled);
+}
+
+/**
+ * dm_test_early_init_legacy_asics - Test the display counts of legacy ASICs
+ * @test: The KUnit test context
+ */
+static void dm_test_early_init_legacy_asics(struct kunit *test)
+{
+	static const struct {
+		enum amd_asic_type asic_type;
+		u32 num_crtc;
+		u32 num_hpd;
+		u32 num_dig;
+	} cases[] = {
+		{ CHIP_BONAIRE, 6, 6, 6 },
+		{ CHIP_HAWAII, 6, 6, 6 },
+		{ CHIP_KAVERI, 4, 6, 7 },
+		{ CHIP_KABINI, 2, 6, 6 },
+		{ CHIP_MULLINS, 2, 6, 6 },
+		{ CHIP_FIJI, 6, 6, 7 },
+		{ CHIP_TONGA, 6, 6, 7 },
+		{ CHIP_CARRIZO, 3, 6, 9 },
+		{ CHIP_STONEY, 2, 6, 9 },
+		{ CHIP_POLARIS11, 5, 5, 5 },
+		{ CHIP_POLARIS12, 5, 5, 5 },
+		{ CHIP_POLARIS10, 6, 6, 6 },
+		{ CHIP_VEGAM, 6, 6, 6 },
+		{ CHIP_VEGA10, 6, 6, 6 },
+		{ CHIP_VEGA12, 6, 6, 6 },
+		{ CHIP_VEGA20, 6, 6, 6 },
+	};
+	struct amdgpu_device *adev = dm_test_early_init_adev(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		adev->asic_type = cases[i].asic_type;
+
+		KUNIT_EXPECT_EQ_MSG(test, dm_test_run_early_init(adev), 0,
+				    "asic_type %d", cases[i].asic_type);
+		KUNIT_EXPECT_EQ_MSG(test, adev->mode_info.num_crtc, cases[i].num_crtc,
+				    "asic_type %d", cases[i].asic_type);
+		KUNIT_EXPECT_EQ_MSG(test, adev->mode_info.num_hpd, cases[i].num_hpd,
+				    "asic_type %d", cases[i].asic_type);
+		KUNIT_EXPECT_EQ_MSG(test, adev->mode_info.num_dig, cases[i].num_dig,
+				    "asic_type %d", cases[i].asic_type);
+	}
+
+	KUNIT_EXPECT_NOT_NULL(test, adev->mode_info.funcs);
+	KUNIT_EXPECT_TRUE(test, adev->dc_enabled);
+}
+
+/**
+ * dm_test_early_init_dcn_versions - Test the display counts of DCN IP versions
+ * @test: The KUnit test context
+ *
+ * Only IP versions without DMUB firmware are used, so dm_init_microcode() does
+ * not reach a firmware request.
+ */
+static void dm_test_early_init_dcn_versions(struct kunit *test)
+{
+	static const struct {
+		u32 ip_version;
+		u32 num_crtc;
+	} cases[] = {
+		{ IP_VERSION(2, 0, 2), 6 },
+		{ IP_VERSION(2, 0, 0), 5 },
+		{ IP_VERSION(2, 0, 3), 2 },
+		{ IP_VERSION(1, 0, 0), 4 },
+		{ IP_VERSION(1, 0, 1), 4 },
+	};
+	struct amdgpu_device *adev = dm_test_early_init_adev(test);
+	unsigned int i;
+
+	adev->asic_type = CHIP_IP_DISCOVERY;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		adev->ip_versions[DCE_HWIP][0] = cases[i].ip_version;
+
+		KUNIT_EXPECT_EQ_MSG(test, dm_test_run_early_init(adev), 0,
+				    "ip_version 0x%x", cases[i].ip_version);
+		KUNIT_EXPECT_EQ_MSG(test, adev->mode_info.num_crtc, cases[i].num_crtc,
+				    "ip_version 0x%x", cases[i].ip_version);
+		/* Every DCN entry keeps hpd and dig in step with the CRTC count. */
+		KUNIT_EXPECT_EQ(test, adev->mode_info.num_hpd, cases[i].num_crtc);
+		KUNIT_EXPECT_EQ(test, adev->mode_info.num_dig, cases[i].num_crtc);
+	}
+}
+
+/**
+ * dm_test_early_init_unsupported_version - Test an unknown IP version is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_early_init_unsupported_version(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_early_init_adev(test);
+
+	adev->asic_type = CHIP_IP_DISCOVERY;
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(9, 9, 9);
+
+	KUNIT_EXPECT_EQ(test, dm_test_run_early_init(adev), -EINVAL);
+	KUNIT_EXPECT_FALSE(test, adev->dc_enabled);
+}
+
 /* Tests for load_dmcu_fw() */
 
 /**
@@ -4091,6 +4254,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* amdgpu_dm_init_power_module */
 	KUNIT_CASE(dm_test_init_power_module_no_edp),
 	KUNIT_CASE(dm_test_init_power_module_alloc_failure),
+	/* dm_early_init */
+	KUNIT_CASE(dm_test_early_init_no_object_header),
+	KUNIT_CASE(dm_test_early_init_legacy_asics),
+	KUNIT_CASE(dm_test_early_init_dcn_versions),
+	KUNIT_CASE(dm_test_early_init_unsupported_version),
 	/* load_dmcu_fw */
 	KUNIT_CASE(dm_test_load_dmcu_fw_no_dmcu),
 	KUNIT_CASE(dm_test_load_dmcu_fw_dcn),
-- 
2.43.0

