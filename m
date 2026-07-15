Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE05FC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B13510F069;
	Wed, 15 Jul 2026 13:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXjz9gcG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA2510F069
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdPQrqwZjAxPa5iUXcAM3rSsvpB14BOVx+9KVi3KiGC6VqwdiCc5Wqb1H4g/QYMX0Vx1KhIjs/s31DHIt0w8TfW56EL8XAVH5lRV6Pe6y5K2pDNELRhtjUA3gvhvSWaRvXb5OX6GXCtioYUnIFP86nECDoreIWWvkVfu5/SRUQ6hSxZGWN8XxL/MvU4rWGSY8O2ykO/pc5xR+yps3slSFRrDXcYOfVuYvxfi9e+xvekecGx5vb6dg+sq+KXkBSuHEV6fHu+YBJUVv9KtwzgVdVlfijQZssksP/wLuzrIFJiUYvRpCRpeKgnEGg9cr27DNAyVd3QJSREdmcq3mZJbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KQ1CVW9Gf7RwNIQJVKEXe4KcH3GFoK7wIujQiI4YX8=;
 b=it0+N1tYi0P7l8uuBC0FAApoakF9mWCU/kh7TH5UxVMZhjepGkGAGQ9bPcVt0czcwBgLG4nsIgIYhrENm51uov/rEsy2VoypMa6CqaRS/2Iyjc1MMYPM7aJQngOMgk0fz177erw9xqS8+RmbUdoOHx/qOz8C+n9SA53XI+vsk5tjcCIoBeVYe2DlSRgTZqiq/YeowFwfQoAQG2Ew/eR4BCoeRC7+kgO6QTgf/A7ZR3nSG2HPgBpnZ9SQu2oUhfjzMLRp/wQeA0vIbJBCwQiH5/dgNxWbXSMRxz3HSMvA+EoPcze3HieeeFp0T9JsMFTsO333J3O6b4s0UH590daJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KQ1CVW9Gf7RwNIQJVKEXe4KcH3GFoK7wIujQiI4YX8=;
 b=EXjz9gcGcEetfy53vNIq3s0mNww1qOF6+vFF5UuOqewavPJrGAjrO3ehzW/R2TtQgG17NiQmpXdZt8z98hIuoa3pibdwZDkJH5WBXHt2j024a9YR5nlH7pVEVaC4dA8GBzZ2xQ61SrhPiJ6xI3qdxekXRJbV9E5DCq+u62i3u24=
Received: from DS7P220CA0074.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::9) by
 SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:45:21 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::2b) by DS7P220CA0074.outlook.office365.com
 (2603:10b6:8:259::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 06/70] drm/amd/display: add dm_dmub_hw_resume KUnit coverage
Date: Wed, 15 Jul 2026 21:37:16 +0800
Message-ID: <20260715134432.1975118-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 0351b9d0-9cfa-402c-2894-08dee2774ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v9y+Hn42NZLtvtacp7rhjvOQY34Rh/a4g02QYHI5cK/FwflU0mC51sh6RsHFJ1EIF5qB3h9KwnZvWNphAFZ8QOIUXkMzzRvaNpFZSHYDbjvtqJaIHPEuAv7k3KqyAxo+1y750KjITp3wJo/itLJDP2GP5Be/FU5QwOz/NTLyu+Nf4DB8ub6buXFG/Yehice73A+/vCtRFiQymYkLB/yti0twMRDg8KdiPNhv2BNhH3oQPPU2Z5FJqvfXbuhUAh0KXlPsGAQXafcN4jwK5Zw+7WmAPmgaP/kWTgbsC9iuKPSAKTcAvzXGsUTa2YZtyaAMeeqUKaHo26DHz7UhWwtYnyQs4Xgdr62bPN3HkhxjVF76foELwgMBK28mesw78OZjk8WK98QrsY95yy/Ffl3AI6JphJkI+75gi333evK651TdjeA6VVXavgl527fcRSvMXykbk8FyrS60jSv+Oy2L29PefQNt8Ux5aPVpjcGmZb54I/FPtjmrrE7JYxYqr9nI2adx8vcsmw7ucM3lbtPdkSfNmRUwo1UbwxZjhwwcKQ+7E6LwwLHqRQEYFIgz1MQS85lePKngnPR7bBMy4ybb32NfjCZOtDxYwkCrw6glCklN8JLBZ7fs9cvH2t7hFvghHW6HgZOMeuWYyUgOldA8uzgqpUlthMniuYyBdGrA/uimOnuMAQCInDvRXk06P3cDgCgRjtkKDjDpEmSihTjzqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /UGgk5s9oVZMWkdrFhqAPXeNVsQACNRzpyUDCze0Y4tLwkR8VReJXo6SyJh0P1rNkfibH/zocDLZH3PLPlYQjoqhBZWoP5IyEc++1WGqraiX437PQDdihWycbahSHWEUE047QOUJ/eI4Vs9UVYnhBY7vQaSgM5wuMiKZFNOxVbZZ8KuDQjCqLq8X7AzTAsmAW3HBSKrIsNrDXATjLJSgImOGgRo+y66PpX8m6aPhxNWRqvm+zeJAN/1MZdO29xeVNxg6slyVdolgtWl2uWdr8U698u09B7JpHsXphpH0yBZzXiCSy8mdht+3jSM3oId1Ce0IPrVMnlX8/s90zzMWB44VyFRwEIpaMpLwj3m3vOWguF8GGYAw7zIbhH/ZS7qk/TT9vTB/hO2nPsMJwQfHip/GoC0BCh1YpP2/I9/W33z1vsmxdiFlqG7T4+wLBW5h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:20.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0351b9d0-9cfa-402c-2894-08dee2774ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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
Extend KUnit coverage for dm_dmub_hw_resume() using the fake-DMUB
fixtures. New cases cover the already-initialized wait path, the full
reinitialization path, a failed init-state query, and an auto-load
timeout, none of which require real hardware.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 4c01f7919170..bae34436c89e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -801,6 +801,79 @@ static void dm_test_dmub_hw_resume_no_dmub_srv(struct kunit *test)
 	dm_dmub_hw_resume(adev);
 }
 
+/**
+ * dm_test_dmub_hw_resume_initialized_dmub - Test resume waits for initialized DMUB
+ * @test: The KUnit test context
+ *
+ * When the fake DMUB service reports hardware already initialized, resume
+ * should only wait for firmware readiness and skip full reinitialization.
+ */
+static void dm_test_dmub_hw_resume_initialized_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc(test);
+
+	adev->dm.dmub_srv = dm_test_alloc_dmub_srv(test);
+
+	/* Must not crash. */
+	dm_dmub_hw_resume(adev);
+}
+
+/**
+ * dm_test_dmub_hw_resume_full_init - Test resume performs full init when uninitialized
+ * @test: The KUnit test context
+ *
+ * When the fake DMUB service reports hardware not yet initialized, resume
+ * should continue into a full dm_dmub_hw_init() and create the DC DMUB
+ * server.
+ */
+static void dm_test_dmub_hw_resume_full_init(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->dm.dmub_srv->hw_init = false;
+
+	dm_dmub_hw_resume(adev);
+
+	KUNIT_EXPECT_NOT_NULL(test, adev->dm.dc->ctx->dmub_srv);
+}
+
+/**
+ * dm_test_dmub_hw_resume_init_check_failed - Test resume handles a failed init check
+ * @test: The KUnit test context
+ *
+ * When the DMUB service is not software-initialized, the init-state query
+ * fails and resume continues into dm_dmub_hw_init(), which also fails; the
+ * call must warn and return without crashing.
+ */
+static void dm_test_dmub_hw_resume_init_check_failed(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->dm.dmub_srv->sw_init = false;
+
+	/* Must not crash. */
+	dm_dmub_hw_resume(adev);
+}
+
+/**
+ * dm_test_dmub_hw_resume_auto_load_timeout - Test resume tolerates an auto-load timeout
+ * @test: The KUnit test context
+ *
+ * When the DMUB reports hardware already initialized but the firmware never
+ * signals ready, resume's auto-load wait times out and only warns; the call
+ * must not crash.
+ */
+static void dm_test_dmub_hw_resume_auto_load_timeout(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc(test);
+
+	adev->dm.dmub_srv = dm_test_alloc_dmub_srv(test);
+	adev->dm.dmub_srv->hw_funcs.get_fw_status = dm_test_dmub_fw_not_ready;
+
+	/* Must not crash; auto-load times out and only warns. */
+	dm_dmub_hw_resume(adev);
+}
+
 /* Tests for dm_dmub_sw_init() */
 
 /**
@@ -878,6 +951,10 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_dmub_hw_init_dmcu_abm),
 	/* dm_dmub_hw_resume() */
 	KUNIT_CASE(dm_test_dmub_hw_resume_no_dmub_srv),
+	KUNIT_CASE(dm_test_dmub_hw_resume_initialized_dmub),
+	KUNIT_CASE(dm_test_dmub_hw_resume_full_init),
+	KUNIT_CASE(dm_test_dmub_hw_resume_init_check_failed),
+	KUNIT_CASE(dm_test_dmub_hw_resume_auto_load_timeout),
 	/* dm_dmub_sw_init() */
 	KUNIT_CASE(dm_test_dmub_sw_init_unsupported_asic),
 	/* dm_init_microcode() */
-- 
2.43.0

