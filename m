Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EE8C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5426B10EEDF;
	Wed,  2 Sep 2026 05:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ZwrQBQT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367DE10EEDF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXegIQJyGE8u46ZJCel/wXdW9BZo3ONt1VE7yLOdGfsXCLlHE/lvdqihsusiT4A3obH2MckuZf9WsfMilmAIsM3QptZ6Z5CI12cBT/bZlug4zmVodhbO+VEvqAkEJLnQ+Z2CTN5xhxibja4gbLVERG4owfq4TkYRSV/XDgjGj+tqWqrMPtIKDS2lZjGeviV/CWdQev8hAvYH5X57abulwGkqweg8LGWrosI9wgTLUm6BJ1MazhxhzKtdcyzBT4J8VKdTmpq7a/Kd3ErwMEKy5JdCI5V/jJgX3zEa/KMI+Bjqz0ZR4AE6U5dTRx8DNKMX2w7SvgOQkJrC05zcEu7qYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoB0y7XjONrI/Y0zgI/Nhyta6Ls2tEfitXZDAte79s0=;
 b=pY3gYDNyecuN+VwnVFzeoNKTvMw6+wSN+XZMeZyByOAoMefkQqwSVPlTL+riTAovKUhAb9z79RMOcOPe6mb1Cu2CFJSsvz8xnRvqzjG1Ca7PMfc7fZTPuJdLhJpx5KeviA1tupm82CC/sxcd8pwMNvgyyhnkSqIGIhWZrZ7YK50Xpyto4k/5RtB5T7yztmAHsXO5nMCVUmo6o4kSiL578f9LUbD07pxwOQjqpD0SaFG6OwIc1J6X4TPEUzELGOi+Bx9m6ysq8nnmvSg+W/4nF0mxVqUDYGlabffhL4YNew5Bq5hYtm9vAWCfLw50fyDcwitdQT+QskP+61T+jRy0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoB0y7XjONrI/Y0zgI/Nhyta6Ls2tEfitXZDAte79s0=;
 b=4ZwrQBQTHRaFJpPh/vBjzKWjC2SjgDhjEn2kZU4VA6+n1CXdDtmkYhi4mNNc0vW2LwbvyWWpO8Xo5AdZ80L6pkYSPhh302wNVP5I3OpltXALAbdY5Mjn4uFu4e381kCPX11l4LyULXIKrL7EqAuTyXV0Hl2FZ5dlYIOV5TmrwjA=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:08:26 +0000
Received: from LV8PEPF00000068.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::98) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000068.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:08:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:08:24 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:08:16 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 27/40] drm/amd/display: Test DM IRQ handler source guard
Date: Wed, 2 Sep 2026 12:58:49 +0800
Message-ID: <20260902050411.3473916-28-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000068:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6c0a1d-2d1c-4aa3-512c-08df08b0380b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: P0SST5SLyIVQtppqh7tnSQJcoAS7shKAUlvCsD0CuBFkeuREsa8ugyqoZ0Hm2QYJU6ZEuWeM5qztz8uG9wRIxXcMmnmGS4l321OYSrCYVhCXYheKVcpuF73bO++Crqu5Vzi35KFcFD5KwRKXlk9De3d+Ox0aO2eaWlQ8OGFA+Zme3I3g0xu892D5MpNhNTdNtZjQh8DjHkCf8HMELI0q34pU1VugKNgDNbf4U9AOGVycspyvav6nKmmFK2AOxq2pvhv9OQOXV/zdLmLLN5gndpYp6CY/qfXV3PVi6dxMute20KgOJLFCN2csS5TgJDUWDWI/Ug3rBrfJ0Q5GoJ8dlUwZhaj6nBJ7UUQ16MSADu4zoZegze1YQSytx/M5qKY7Hr1IrCzldI4sVd83jaHNf4vYJgZWtnnR8BgtZj4I/ifRyuoGnd0ab25xwVM0S2WBzfEfR/UP5wQwVIEInRuEQroRqlQS20DhSqweYNDZznZXK6Jjp1w/IkFPbI9lQwfLK+FeIykzV1FzIPNpaiWNaBxFD4+3Hie0Bs0eBhtM5SUM2RU1+jquaLr/DRi8VtMUmEu9Z/0ZP72fcUv73ULc6MGFbkO9fhihdooaNLeHMTOyngJtQ9qfadK5uk8GyzuT4MbpelMSjypjVcs7fw9iETtOBZOaQz0g4vNRz+F/6+WJlHPxHXNNh+8TODq0KGobKRpSdi3Q4aV/LvijSXMLAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9fHKovFlZmCLF9XUf5qPYsnaGmFuTK2BIwSio3Sq2wLjLXVFlnRCcCXYymERcHprhE11jyiRsdhhZb2Obtxd4eTyTOLvWbYYrc6t23J5t6TbGyVCsHkoyevk/bMCsZnAile0FK0pTah2h+ywqdKkJzCKH19YYV/qYtArzoaks2j67aTi/hwm8cesufVaFjrFkM5lNVw/xuxgfkbOSfCGmUa5zsrBChPZKTV5/MkDsbq5KLb9jF2yMN6wR6LZepg7WfjFiBaCkzKv91eZk/L9//eK2Yr3Z1bDA6jFFDuJ0en1Dr2gyhKRVXInbStbvF3UPgE6XGmNU8hEf7NsFO/jkQiv0FgUwuikHMQU77+ce0V5gGDmzji1cqLr2+0BQ4BTHEYir5uqUI3HUYsBbCMW8qAAA6ouQbNcoZ1FK+yTzYH5geVvaED76InhR1ea0BM/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:08:25.7000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6c0a1d-2d1c-4aa3-512c-08df08b0380b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000068.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

[Why & How]
Add dm_test_irq_handler_invalid_source to cover the early return in
amdgpu_dm_irq_handler() when dc_interrupt_to_irq_source() cannot map the
hardware entry.

Reuse the existing unmapped irq_service stub and assert that neither the
high- nor the low-context handler is dispatched.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 37851af59ffe..d7d2dd49b1f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -4710,6 +4710,50 @@ static void dm_test_irq_handler_dispatches_work(struct kunit *test)
 	amdgpu_dm_irq_fini(adev);
 }
 
+/**
+ * dm_test_irq_handler_invalid_source - Test the IRQ handler source guard
+ * @test: The KUnit test context
+ *
+ * When dc_interrupt_to_irq_source() cannot map the hardware entry it returns
+ * DC_IRQ_SOURCE_INVALID, which must not be used to index the DM handler
+ * tables. amdgpu_dm_irq_handler() should bail out early without dispatching
+ * to either the high- or low-context handlers.
+ */
+static void dm_test_irq_handler_invalid_source(struct kunit *test)
+{
+	struct dc_interrupt_params int_params = { 0 };
+	struct amdgpu_iv_entry entry = { 0 };
+	struct amdgpu_device *adev;
+	int high_count = 0;
+	int low_count = 0;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	/* This stub maps every src_id to DC_IRQ_SOURCE_INVALID. */
+	adev->dm.dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_unmapped);
+
+	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_VBLANK1;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test,
+		amdgpu_dm_irq_register_interrupt(adev, &int_params, dm_test_irq_handler_count,
+						 &high_count));
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test,
+		amdgpu_dm_irq_register_interrupt(adev, &int_params, dm_test_irq_handler_count,
+						 &low_count));
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_irq_handler(adev, NULL, &entry), 0);
+
+	flush_workqueue(adev->dm.irq_wq);
+	KUNIT_EXPECT_EQ(test, high_count, 0);
+	KUNIT_EXPECT_EQ(test, low_count, 0);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 /* Tests for dm_handle_vmin_vmax_update() */
 
 /**
@@ -4953,6 +4997,7 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_register_outbox_irq_handlers_with_dmub),
 	/* amdgpu_dm_irq_handler */
 	KUNIT_CASE(dm_test_irq_handler_dispatches_work),
+	KUNIT_CASE(dm_test_irq_handler_invalid_source),
 	/* dm_handle_vmin_vmax_update */
 	KUNIT_CASE(dm_test_handle_vmin_vmax_update),
 	{}
-- 
2.43.0

