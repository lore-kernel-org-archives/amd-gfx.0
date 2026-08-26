Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2462C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3725410EE5F;
	Wed, 26 Aug 2026 23:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W9raA1RO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A129D10EE5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVgcR0WbIy/lfJfYSrkOylk5EqSt6RwG5HWJyoLxls+wqFzpPE8985yEhN+sXx7zNDSFjsYWryzeAsZ1CxU6GlMQeAKr93xFFgKX/vTh1VaW+gPuVb3vBM5ASPybu18I08Vuk568L+V/lDzyKmYVtQIO0F01HGUlTeRtW9vTSrRW45f/+fLWFpYY1Su9xOtpW/pwI2ovitqogRtxov/yaJ9yCFXd8HILzVUBh8yM9eqot1woiqkbutoz3F3kpjb338MRbv+/w5Nak+vXwVIaNme6JS36oPa5ijN+yd3vxF4tdUmIswm8Zt2EcSK2txH6H9Rm10eJgVUlDRdUrv2OmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGrZzjKjCRCaR/oZlzg7kRnxpHlKexfLO838kPtpTCU=;
 b=Jbz99yEWptkeDzTue2y6b6AoiLfqobmKS6PeOIvfzqeFDCXdrzhMKhm8xfCSY5SL0oXglyNnkI5KJQDUdERq2a36ascQH/jGX/aJVkalhqYfVFFIV8uzICnyMCAuVdXtpZhisengZ8kKmKQGrYhUGHOlWBkKdz+Tljhym57+sLs3KU1ehM2viAaxC3rFNBhqQnCoTt81PyxLKnqKEmGL9OoGff2VDwUxhY3idTXPZxJpETuoGuQnhH8xeYayVDyWQPi6XXw4ari6qdG3E8GZLjS8j/GJDogwzhAhzbFKBKNFEl73BgGQScexKM5xn1lVB83qElbvHktOl/oBjDtLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGrZzjKjCRCaR/oZlzg7kRnxpHlKexfLO838kPtpTCU=;
 b=W9raA1RONvZ1MvijcV34JLAh9cWgtPpZg0q1lXCs+hvOvl8MHxumNfUcjYZXHckmT3dXevuJoOuSjKiP8afIVSS0AIgc6Aj0LBb15FwGDLvWBoGYatMwGPQ/EkmuhD1AXnrSRkZICjcqs8J+cRguhJ1/MoXOawW1U0kAzdpij80=
Received: from PH1PEPF00013312.namprd07.prod.outlook.com (2603:10b6:518:1::d)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 23:31:37 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH1PEPF00013312.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:31:36 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:31:00 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 46/59] drm/amd/display: Test power module init
Date: Wed, 26 Aug 2026 17:05:17 -0600
Message-ID: <20260826231519.881949-47-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6ab647-4f24-4841-0fa5-08df03ca2bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kTBykLu4+r/0U6SXHAO+b08bhoJp6l7I/H59a/umnV310e1VMHuEbvnVDu6o/6DTCh1AaMcUUYTWUN3DZMmOU+Kv8MTsB9CP6XBgUt4V5A83JCikSPsN294js1KntrPoR/gqxxSlGuFOuVf3C/1ZBpUJ3euAWYfE6mea7WPF8/qHJQHUjbnwQBTCWpfu5LCfbRZ7ljfycldVZWQ9UwsWg3g8SpGwJ4lUhKQ4JxFEug6Z0FHZsC5AmCNKyMvMX9POPamLeTkpe/liawoVXLh9EGtWYe/fM9p00Sl/fZyof+faXjW3BdOxzd1zPxuvmIetT6aXco5648JsqCakWBpcE55DnMA3ah16VhPQ9EcFtueXyOJ/LL+SxnoaSQlPFX9Ny3oyhzKPhQI7w0CxEzdHLo1UsNoqEmAYwmE8yRIa7DqQUpP6ua3bAqp34DFgu4tkzu9QEQOAhS/Xmg/NoxUDZ/3vZiJJQifsvSn7m5HnIehO7BAJRGIz2puBmBBY+sViZR/o2tSRcp2iFOYl+fid3Q5up11ylKYsZ2eZoknIL/OD9RTzOMZAHimvfy5cD2C+ncj5rZlGzJVzk7tsA/hJYlerWfy6+nI4icQkpUHyYSBXrHnW8Z82ESjiAKUDLJwnfcWklLc2YrZXaNyZqFGCr69XHJnfvPpSU9BftRZg6L85sYLuprMLZDFImHWqe/sdyH1vtDth0OSoHYCAOP5YtA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nuRel54gmYC5gV3QJtfKdfa6DKBTbBbcoao3fOKm9aJL0bFxjX0xExpDfxmrkE4gQ2oW/sjsuDahbdEl0iuCZrWwk+wqMRKul54sZRuLLnwRlFAIIqulMiI2vNZdAkAJISOBClEq/et1eyhRaGVUZUspJyQj6RjIZ4iZJvVplxdINSwj+p7t0gXEtFCClV+d6w6yxEGuvbHOIM8425vu3OG9oXCq+QRxJx0gc6vssHGnnwxAaTwoQlsErraYHOEaJETBE1sfjcWYU2TMnRR+lEfDEz7RKxfzNMTv2EZ/4f29iCUwY7Zis24bEA6shB6YqsYlJ6rrhDnLIxKi6a9O9h5MqgHdGl8Y24g0pbFMm7LIzI78qmqUs49G3Ga1nNUBvrxZyEbmoNPEqx1+bDxQIGyIgN6quOSajNOFdidohgr9DekwSDbYOizKrRq+DJy6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:31:36.4572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6ab647-4f24-4841-0fa5-08df03ca2bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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
Add KUnit tests for amdgpu_dm_init_power_module(), covering the skip
when no eDP is detected and the backlight parameter setup loop followed
by the allocation failure report.

[HOW]
mod_power_create() rejects a NULL DC, which walks the full parameter
setup loop without needing a live display core.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 40 +++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ffc5cea6b6df..3d2a9e014797 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -407,7 +407,7 @@ STATIC_IFN_KUNIT void mmhub_read_system_context(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(mmhub_read_system_context);
 
-static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
+STATIC_IFN_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 {
 	struct mod_power_init_params init_data[MAX_NUM_EDP];
 
@@ -470,6 +470,7 @@ static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_init_power_module);
 
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a53246040948..5e9d0b203a0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1252,6 +1252,7 @@ struct dc_phy_addr_space_config;
 
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
+int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index bb52da037e69..d1a25b3e68c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3522,6 +3522,43 @@ static void dm_test_mmhub_agp_enabled_renoir(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.end_addr, 0x80000000ULL);
 }
 
+/* Tests for amdgpu_dm_init_power_module() */
+
+/**
+ * dm_test_init_power_module_no_edp - Test no eDP skips the power module
+ * @test: The KUnit test context
+ */
+static void dm_test_init_power_module_no_edp(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->dm.ddev = &adev->ddev;
+	adev->dm.num_of_edps = 0;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_init_power_module(&adev->dm), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.power_module);
+}
+
+/**
+ * dm_test_init_power_module_alloc_failure - Test a failed power module create
+ * @test: The KUnit test context
+ *
+ * mod_power_create() rejects a NULL DC, which walks the full parameter setup
+ * loop and then reports the allocation failure.
+ */
+static void dm_test_init_power_module_alloc_failure(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->dm.ddev = &adev->ddev;
+	adev->dm.num_of_edps = 1;
+	adev->dm.backlight_caps[0].min_input_signal = 0x10;
+	adev->dm.backlight_caps[0].max_input_signal = 0xff;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_init_power_module(&adev->dm), -ENOMEM);
+	KUNIT_EXPECT_NULL(test, adev->dm.power_module);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3699,6 +3736,9 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_mmhub_agp_disabled_raven2),
 	KUNIT_CASE(dm_test_mmhub_agp_enabled),
 	KUNIT_CASE(dm_test_mmhub_agp_enabled_renoir),
+	/* amdgpu_dm_init_power_module */
+	KUNIT_CASE(dm_test_init_power_module_no_edp),
+	KUNIT_CASE(dm_test_init_power_module_alloc_failure),
 	{}
 };
 
-- 
2.43.0

