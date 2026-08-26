Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9446CC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1780A10EE63;
	Wed, 26 Aug 2026 23:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="is0H3zq3";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B3910EE63
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmvI7kJx8zwiUA47tjDUNZ6TytUHrsQHEepjH/1rfR/KMseM5DsuiRPz/S1W3GrcpYsNPXMCcSywInAAyMklpFOdgm8QNFH8SIU0d0HPj4KF8r0JyQ6emjpMR/ttyVaDxGwh1581QTIvvroeyTscoOasM4WTxMzKgZhAWgJIbd9h5ZE/ELOfI6Z5YdLUonQNZYwADcwQum1gAlOqt8CPPiwzuuNAlrzOhIqAUbUcrdkBcq4bbvzn6Q3648f/dpjWi3msPU7o9V0VX8/d56VNQts62EVuc7AnqPUc6OUQvqdnQdaOBl1Z/3tDlaIPrZRy9zItk6HkOnPWXdeYxMLEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gphOxlP1fAaSKSd4zF7y1YrTImxyRc3FsYfy/Wlk/Rg=;
 b=uakeMkydvjLg6afdzO65GDPw0qIbaetZnKDhzMBU0nYrPK7NqcJWjwQo89qn6sMJTRHH7zIsQdxpLS8scFQsp/Cp365SB5OUMJODFNLxtLQ02/IOCOxmFdMjwQhuiydABj6bW1j2z/RkNfjMJhCNCCKJZ0o71Gqpu2OrZqstpEl2EUwB3FAJXvchpZJkAFdEGJ1VvANLRZiDAnhLLV3p3rWwORJYN+dB71QU3aqxDCCzoN2LZ1XsFE6BdthJpMkVogwqQFfHqH+M2JBpMXcgbATfIx9Auq+IAEEiatZIit8CvJCZBKa1CHAEMgATNfCOcL5kRChXAbyX9NvMhe/qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gphOxlP1fAaSKSd4zF7y1YrTImxyRc3FsYfy/Wlk/Rg=;
 b=is0H3zq38OtmAs5P9zl37Nc5La5BvV+5xbvr+5FAVlGjhr+1Y3b8yFeMuL7U52zo13TK/Htheqt0GbZ+gv1jjA42uuOGhYQ4TZW5KtW6x+C2h72bXZL/58gGzDxtyRb2fcC6oVNYQ2C0hsC66eogkD82Yhi3VKdfbJ0+bLViq3Y=
Received: from PH7P220CA0158.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::34)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 26 Aug
 2026 23:32:46 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::3a) by PH7P220CA0158.outlook.office365.com
 (2603:10b6:510:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:32:45 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:32:40 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 50/59] drm/amd/display: Test DM late init
Date: Wed, 26 Aug 2026 17:05:21 -0600
Message-ID: <20260826231519.881949-51-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: d65e68cb-d7d3-4056-a8f4-08df03ca54d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|6133799003|10067099003|11063799006|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: wY8/6ZwIP/iEWbEXV5HO4ojXq/HajuhG2pk2QAdQStKxIenBJ78+O/X0kX1o9sblbR104JqNu0eEjQfoH3XhVMW6OTO+XUl667Uw/ptwAG4h6qvBv4xsAm3PxDbvFdaHGU6543KDyrMPBP3yHA4m3kswBzwSkwN0aUa7Hz0ghK3VqceE8Kn3fen09uRIpam16SZgZMQ4i8cH7WJnfnh54QHG/mopZkIN6Awjj1XLYpcNTZJmcl+NgnIE2ia7BSvUlbdwo6OA7uKMx/+is38taEVIeyeSO65Jq4L95SocmICt+hTxjRgVdbSugMorLEZIEDvpcEucmavrFKENsGY6H8IPCFDXi85c2IVP7WW5zoCkfXYsZOYOwGzrfSWD/ihUpSHmHM01UkJjx16+ptZuxgRAAgjdEXLeySc8eG+YPPP0YKiTBbnHtZeRigPKPw2/A9V+/wuS5++6zah8Pw0y+kMiyPRddIh4PEBKcSmNGSHwuTNKhiR+xClQtynfBOky6JNzMfj9o7Ghqt3/UrRfH7pEYEEkPzXjc/0y1OHP12Vx8smzlpPgYhe2TemPB2TjQxyPFgQCGEaEArxDPvqVb0sKaIvkIZBrgerxHYTmrZLS+DixLPpusGtYewZqAm5heIYabYfQEIln2JQle672Q4y/6RAFPD446+Q5MdwrCOCBO/M05eyk/y9D/0T+VkrQe7EGu8dzg3TpXbTN1+mzaw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(6133799003)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eJtNCklARgDt8cwe0DubFcHePEqbIT9p68CEHAZSeu9R9zoEg7By89DeI65ClEF4TLipWhCGUgugKEOt4RGEyafbOQ2m0x0yom3LbrJiEBcZ94/wKDYs2pEUIKJh4wTEPC0sYRmJ8PCFOvwzLfAmkQNDTGnJj5bdBy4GMmYP7iQ0xu3nlOnXgiukMuyZbCw3ZovjvIzzjYIYWEw9iizFtNl+B03sMO4rgOaj3j+sf3UGCsf8cVrrPfyty06o+XukqO6b49734GIYzT8HnevYTrOwL3BoCNE2l8py6AjwLFNpKES8UwW/UVWxYkAvy1Y8HFtdburaR13Ofbb2YBXCNI9Tr7Wjhn7FnqMU7k/tqiGrn0UgqAfdcio3PR7h2VD0/dmV6koQackL3x7r7Tgu0LUSxA9oaqmJo/96kWqu+4ZS8b7fAZXhP7tZwaz6uFvm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:32:45.0751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65e68cb-d7d3-4056-a8f4-08df03ca54d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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
Add KUnit tests for dm_late_init(), covering a DC without a DMCU, and
the boot time CRC init with and without a DMUB service.

[HOW]
An empty resource pool leaves the DMCU NULL and an empty link list
leaves no eDP, so the ABM configuration is skipped and only the MST
detection sweep runs. A stub reports the boot time CRC as disabled.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 87 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b4d01d97ea4..0393ec122f26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1183,7 +1183,7 @@ static void amdgpu_dm_boot_time_crc_init(struct amdgpu_device *adev)
 	}
 }
 
-static int dm_late_init(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -1233,6 +1233,7 @@ static int dm_late_init(struct amdgpu_ip_block *ip_block)
 
 	return amdgpu_dm_detect_mst_link_for_all_connectors(adev_to_drm(adev));
 }
+EXPORT_IF_KUNIT(dm_late_init);
 
 static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 80da5a378d73..c662c39416d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1255,6 +1255,7 @@ void mmhub_read_system_context(struct amdgpu_device *adev,
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 int load_dmcu_fw(struct amdgpu_device *adev);
 int dm_sw_init(struct amdgpu_ip_block *ip_block);
+int dm_late_init(struct amdgpu_ip_block *ip_block);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 8ad6cf0eaa6c..432e4cd2803d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -21,6 +21,7 @@
 #include <drm/drm_writeback.h>
 
 #include "dc.h"
+#include "dc/dc_dmub_srv.h"
 #include "dal_asic_id.h"
 #include "dm_services_types.h"
 #include "dmub/dmub_srv.h"
@@ -3702,6 +3703,88 @@ static void dm_test_sw_fini_releases_bounding_box(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
 }
 
+/* Tests for dm_late_init() */
+
+/*
+ * A DC without a DMCU and with an empty link list, so the ABM configuration is
+ * skipped and only the MST detection sweep runs.
+ */
+static struct amdgpu_device *dm_test_late_init_adev(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	dc->res_pool = kunit_kzalloc(test, sizeof(*dc->res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc->res_pool);
+	adev->dm.dc = dc;
+
+	return adev;
+}
+
+static int dm_test_run_late_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ip_block ip_block = { .adev = adev };
+
+	return dm_late_init(&ip_block);
+}
+
+/**
+ * dm_test_late_init_no_dmcu - Test a DC without a DMCU or DMUB
+ * @test: The KUnit test context
+ */
+static void dm_test_late_init_no_dmcu(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_late_init_adev(test);
+
+	KUNIT_EXPECT_EQ(test, dm_test_run_late_init(adev), 0);
+}
+
+/**
+ * dm_test_late_init_boot_crc_no_dmub - Test boot time CRC needs a DMUB service
+ * @test: The KUnit test context
+ */
+static void dm_test_late_init_boot_crc_no_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_late_init_adev(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 6, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_test_run_late_init(adev), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.boot_time_crc_info.bo_ptr);
+}
+
+static union dmub_fw_boot_options dm_test_fw_boot_options;
+
+static union dmub_fw_boot_options dm_test_get_fw_boot_option(struct dmub_srv *dmub)
+{
+	return dm_test_fw_boot_options;
+}
+
+/**
+ * dm_test_late_init_boot_crc_disabled - Test a disabled boot time CRC allocates nothing
+ * @test: The KUnit test context
+ */
+static void dm_test_late_init_boot_crc_disabled(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_late_init_adev(test);
+	struct dc_dmub_srv *dmub_srv;
+	struct dmub_srv *dmub;
+
+	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dmub_srv);
+	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dmub);
+
+	dm_test_fw_boot_options.bits.bootcrc_en_at_S0i3 = 0;
+	dmub->hw_funcs.get_fw_boot_option = dm_test_get_fw_boot_option;
+	dmub_srv->dmub = dmub;
+	adev->dm.dc->ctx->dmub_srv = dmub_srv;
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 6, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_test_run_late_init(adev), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.boot_time_crc_info.bo_ptr);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3891,6 +3974,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* dm_sw_init / dm_sw_fini */
 	KUNIT_CASE(dm_test_sw_init_no_dmub),
 	KUNIT_CASE(dm_test_sw_fini_releases_bounding_box),
+	/* dm_late_init */
+	KUNIT_CASE(dm_test_late_init_no_dmcu),
+	KUNIT_CASE(dm_test_late_init_boot_crc_no_dmub),
+	KUNIT_CASE(dm_test_late_init_boot_crc_disabled),
 	{}
 };
 
-- 
2.43.0

