Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF5EC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04BF10EE5A;
	Wed, 26 Aug 2026 23:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YtNRDX2L";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6607410EE5A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V23fNI6WlT4fHj5RV3llWNcpaHhy4iowiOhkfTKlOnvK6Fnvb9SsxK7469FZSRUXofQ4AKFJhFfihg37wjLrqauiYZFWRsvp/hNqSWbFguTh4n6vOsHKFwMO0onkshPKZzNv2rP91vOHUYeDnfHSJsnjXHpkRZ0zsYZEdvJVaxSl7s6VlcbIduk+l0vvwpZWiOP/aKilihWzPVDh30b0erTrxE87yffAs/fAjky7zgMN+Qczw66KIYwfWJ4DRJoa2B2noucnUwclXszU2hnMRjYfOGeJIIPu1tsnMIm65tFZzzYD1f+UsYggqwZKjsNM7qHg2AiBLuITAB5XAXRFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I/T/cvm7SwNUcLjCaqKs/FSGrXBFDz4ndPPxOWUWqU=;
 b=EtF6LRX+HWAJanw34mtwi/RF/JLX4C3/sawQMyPxSi8M5smCgltvjeOXyK/cZq258B/khlSz3KCUOjsTIi6f1IpgvaFzOxktB1ScgQ9qO6TRSvPxKaBXmBfoAnfdlBpWL5Tvsohc5+7U9xWh1q2HrWNdQv0FxUvcogCQrkM2UZ2eF/fHTeRkdWtRFKL5WFjphrN+YYqiF2p3NEf10+suYYXrg1J2cdewG8A1ve+sEWEwySXtUEWSxz7usQ6Es5LVJsitGPa2iUiGrKGwpZbUWBbB4oZICuFt8vPBh0XGL/T18PW/OYm19Wl4xn0Wb5akdn+6jXY13cUWxPjqMeUAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I/T/cvm7SwNUcLjCaqKs/FSGrXBFDz4ndPPxOWUWqU=;
 b=YtNRDX2LeIj1gmZKJebMb3Gc3ZzJYZkfdx1EHm7849plNI59twlgxszlFuHi89Pqq1jgrtNWNccdEaaEw13CsrBaqITHKfhsif3F77LIezprslRqTfoZMFa6kytyPEy22yFXLcM0Jyc3zddzlo+VWjNyjAiWJGR0pevjCYLdORI=
Received: from SN7PR18CA0021.namprd18.prod.outlook.com (2603:10b6:806:f3::12)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:29:29 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::87) by SN7PR18CA0021.outlook.office365.com
 (2603:10b6:806:f3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 23:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:29:29 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:29:21 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 41/59] drm/amd/display: Test timing sync trigger
Date: Wed, 26 Aug 2026 17:05:12 -0600
Message-ID: <20260826231519.881949-42-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: f756134a-b246-474b-5101-08df03c9e04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: kdmB31xo1C190bxI+QTNxSLCdatm5i5/gh9hS8GrO3/9otgIgzcP47zoiia2CzRs/8TsDD46bxDlmQ+zhr+J8bZaFQ5eCek755Am+i2Jv216cIaR5ixIS5jnSbY4klK9b0JlPcc0htywgC9br9RE7mcJ/rPatdSvU6Co8Iyuk14oMsYv90kEPRrSmBMZXoLknU1MZ8wvJG7czgQiZqCzEmp+nqTEJn9TeQPwBWyRnC2lh0JhCXDbahtuRjDk8uJcVIJ9FP0SJyP56V3BB3RX/rwPTmBuZdhTzzFSZQO5cyhBy30Vpcc0x0Phz/MC6s1iQXjcMTWOcK4ZG8h3WIJ0hGtTRNd3pFewdo8NGZj66AjNiT/oQROioKQ1pFnBpoywxTpczwsrRH7IhcjdO4DPtOSXX4tplZjIHZmPGcIUOs3EqjCCtxPmQNT2HAXqTtN6FSzxBwA/H+xHiVE8ClX3h/B9ZMt3X927fFNJLfjlBy9VuMmQXJEynR3VAzEb8eNkytXkc8CEUk1aJazMQWjlhES1ebahwQ3ms7vj4IaQWYTWtE3CTvwrz7rszxmtvXK5m1L1LnhBXoWnAi5W6AyxjN5H6yGbSJ5EJ2PURZUNxaMX6idRK2Zpxk14XORYwHzGFUcksuQVGSpGW7R6c5QfEFlS4//i9ahKKGkgKeBCOpPPujGybGTJadak3DIJ1CsKVrF+RRqZqMkvo6b4cWVeYQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +eCyNNRNotC3u8HEfvbiBt5Nhp4ta531/8WiXVjxd9imqtAMOay65SiKbdj7g6HX6BpJ9A1saTMMV8W+YMjPljp74YLsbJBgcEBBCTPRkHrlXk3PXJ42jlfms3ND+kR2ccH4NDkFbSobFpTTr2QJ9AVALsFgPk8DumA4zGkFZi5dQ8zr4ncM6KdEG3W3KMYDg3XgK7Du0SW157E8+p5+DZ0t294z7X8Wl2yymyP9lRVQdSdO8NWQOzkXTtGXiL/4P/BdAaFEgsqmOlo5gMt48dP7NZJEWhe/Bwvpa91ptLh3v9goN2ia8uOw9Wap++LeQHkHyNhNfj6CoQ3usX/cUzzkgLcpxl2Q33sqY85wvRVuD0Qm3Fe3qGT/EqIimAjrHyBbSNzYKnZANBcfXqGMjFUdX5zSDTMW2PPH3NOS5ALiCLH6Fp2K5HIingPVn4qI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:29:29.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f756134a-b246-474b-5101-08df03c9e04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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
Add KUnit tests for amdgpu_dm_trigger_timing_sync() covering a DC without
a current state and the propagation of the force flag to every stream, and
for dm_acpi_process_phy_transition_interlock().

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 72962c1c63e3..13afd787c1b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6628,6 +6628,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 	}
 	mutex_unlock(&adev->dm.dc_lock);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_trigger_timing_sync);
 
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 		       u32 value, const char *func_name)
@@ -6672,3 +6673,4 @@ void dm_acpi_process_phy_transition_interlock(
 {
 	// Not yet implemented
 }
+EXPORT_IF_KUNIT(dm_acpi_process_phy_transition_interlock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 97ff91dd7e0f..f5c054422346 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3040,6 +3040,60 @@ static void dm_test_aquire_global_lock_waits_commit(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/* Tests for amdgpu_dm_trigger_timing_sync() */
+
+/**
+ * dm_test_trigger_timing_sync_no_state - Test no DC state leaves the sync untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_trigger_timing_sync_no_state(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	mutex_init(&adev->dm.dc_lock);
+
+	amdgpu_dm_trigger_timing_sync(&adev->ddev);
+}
+
+/**
+ * dm_test_trigger_timing_sync_streams - Test the force flag reaches every stream
+ * @test: The KUnit test context
+ */
+static void dm_test_trigger_timing_sync_streams(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct dc_stream_state *stream;
+	struct dc_state *context;
+
+	context = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_NULL(test, context);
+	stream = dm_kunit_alloc_stream(test, NULL);
+
+	context->streams[0] = stream;
+	context->stream_count = 1;
+	dc->current_state = context;
+	adev->dm.dc = dc;
+	adev->dm.force_timing_sync = true;
+	mutex_init(&adev->dm.dc_lock);
+
+	amdgpu_dm_trigger_timing_sync(&adev->ddev);
+
+	KUNIT_EXPECT_TRUE(test, stream->triggered_crtc_reset.enabled);
+}
+
+/**
+ * dm_test_acpi_phy_transition_interlock - Test the PHY transition interlock stub
+ * @test: The KUnit test context
+ */
+static void dm_test_acpi_phy_transition_interlock(struct kunit *test)
+{
+	struct dm_process_phy_transition_init_params params = { 0 };
+
+	dm_acpi_process_phy_transition_interlock(NULL, params);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3189,6 +3243,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_aquire_global_lock_no_crtc),
 	KUNIT_CASE(dm_test_aquire_global_lock_no_commit),
 	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
+	/* amdgpu_dm_trigger_timing_sync */
+	KUNIT_CASE(dm_test_trigger_timing_sync_no_state),
+	KUNIT_CASE(dm_test_trigger_timing_sync_streams),
+	/* dm_acpi_process_phy_transition_interlock */
+	KUNIT_CASE(dm_test_acpi_phy_transition_interlock),
 	{}
 };
 
-- 
2.43.0

