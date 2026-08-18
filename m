Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73957C5DF8D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BDB10ECC6;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a+Er2iH0";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F0D10E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaak7hWXMbxiidRHsBoAW9YII5wCNEffMAbEegJuDTfbCoOh8T4ak2YTMB88Et+eN0s1m/hxpC8R8rClYQYG3SCgVZwzUg9JGT9umpMKmqrTetaUWv7wmVJBTy60TsrWytyfZiv0AZxttLyNyTdOOD/b5yr3yNbC8I6Wr81Kt5XZZFDqNJNLgGHUt5sBKAET0FBABI+WbbJaynWcVO5rqwcfP1XJ7BAkoc09n0/qFmesToQpBgluC/42zkRX1Tp7MO5FGDw3Oo8wkZpQyrDf4sLrsXzcvbTzIbPhLlK06VVjnAT1pgYHb7Gt2jWJB9swHa2kDmw2/3nKPfkBlohXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9yd+pk0v87xvxB9Sz9oknrW6Exhr2MtqnudCYOvaKQ=;
 b=BmRcMDZi5id+7EFCBy+ybsz/QfrAoAQyNyUKpiB798/0nzAongj9EFs7jXZcEK95DCgP6PSIcsZKifZOoBzf3WIVAmUNN/mdvlG9bPgPIn9Ji8vx28LjrFlpuIjxHAwvn5uZil/cD59bLhfhjRLrL6X8sHSHb9TQUVLEI2pIP1Ab4AqE0PetpZL7oioSBUybet1tqfUEPF6gZCbVNZnPWQKuz92fQjO27Tjm5PrK3ga0dLCPd4vS1ct8hELz+LHTKsrQ548YUZ2KFyEsajHR9htegZgaO+as2EQgNy8S2VnZRsYXgnJ/ZHdMtawqDpH3waK2RIObxlYy14xThvKQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9yd+pk0v87xvxB9Sz9oknrW6Exhr2MtqnudCYOvaKQ=;
 b=a+Er2iH0ZQ/GZUJj6mroiOFKKp+gy4oU15W/pMqyqyF4r1CNU223h4G0p+ibVNguwyZX+B9Dcr0fvXj6j23tHUcYyAVJk34i/NS3u9Vfl8lz6jOTuKDe0Av/FXfS0JK3oxrQZJMuy0HUJcq2utBTOfSK+k4kYROGg4rWl1qO0gY=
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by SAWPR12MB999115.namprd12.prod.outlook.com (2603:10b6:806:4e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:47 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::37) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:45 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:45 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 69/82] drm/amd/display: Test
 amdgpu_dm_dcn10_register_irq_handlers
Date: Tue, 18 Aug 2026 16:16:01 -0400
Message-ID: <20260818202139.4172592-70-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SAWPR12MB999115:EE_
X-MS-Office365-Filtering-Correlation-Id: a2435e62-12e6-4273-885d-08defd6677c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BBh1pISbmuNMk6NF+pBT5sKhV1a4v/s+RP1DrztfSJDzodxJ+wVrhMQMlYzZRgnsTdT+qN+D6NX5rJMvZyWSPno5i2GMQL1GXDK5FA3JTMGvnWvS0Gy8vMkzc3/O1ioAqEy5afGvixRgOUqXlbxVgY1o8tn9bpPu/ooarlmbcEKZpj+WWH94vOd9VkdQt5stGdr8iPJNs/ElD3ghpaJ0cKjSkkTIlHkT1kBAWEZ5agxBQMNsVK4AYjqprFGA0R23eN/cNhA9yD6LdBvPirDpJG9Hl1O/2Cw7xD2DRAIgwOAkdzaeVKpcuURQUb/Hq9GkbxA8MF1DVq/FBVwdjfRFt/vBkmOGDmctBdsfzh9MscuVZj1zbpCu1xQA0IcLe0Sv8Sn4en6j9m6ppgDGsC4JXxn01HuS/pj/7H55ch3N5kbdi5+H2LS+8kcrwSaIBGkWLVifX+PFh83aGe6JUstdkxkXRoCAOzg/X65ZYFZldIYfJXVyfV+WMCUfYS2CwgSR7nfbk75b39doIxXVgwYG36/zQq2USKJpRXPtkOrChhMZ6hM5OTzg+jpodtq0Bgb0tAXHTVF0iwEqSDS0MPb+rB11vpjz5XwhY/TLbJnRSlnwTtHpnQPaJULiFQrdBZ3wnjQ7+JL1ZSC5fcYpWxDjgf++NdBdsF7AVFzJ/HG6zcpDM93bw//vIVUdL+4j5EyanUHHrUik6+gByVoUUoCgUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Wrbg7ZZ4R5wUq3WV7zlV1AYveqQNFuV8nB4q/lWCBm5M3rsVFk9WdIlImWRjgc4JJRWeIzbC50QjbgKOBuSY6XVSZJs1Ni8KEYsWW21SmEWTRhFUsRtKK+EwywGPLVN+Ns2voQewAykx1QWKIltfqMNW5O5dzPL/eigqAYTAZ7C5IBY1RvzE1dXXqgbXoMyOZjK9+U9xYBKupQq4VLM9Oj2nnBMwevtbM0AfxU1z76QUheZgJAzMZpjkbL5fZw5yhM0ok0sXU9rTR54RsXOQwP446lznZULggxo257S3Ad4m6zNGWljt0jp3JqE/wcDpLu6Ry7oLMCOmHQqz0yRDPLmXg9jMO1OWGy6+VX81pkJ6s2cWtEcekrJEW/qg1AdKaGlcO4t/ZZGRJsB5OcgK76A2dEoqJQ+q3Dl/J6p4K8Y+EyoFmXzfXXgs6TDbaRA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:47.0559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2435e62-12e6-4273-885d-08defd6677c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999115
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
Add KUnit tests for amdgpu_dm_dcn10_register_irq_handlers() covering the
add_id() rejections for the VUPDATE and HPD sources and the
invalid-source guard in the VUPDATE_NO_LOCK loop, and for
amdgpu_dm_register_outbox_irq_handlers() rejecting a source with no
funcs table.

[HOW]
Reuse the shared registration fixture and the fake IRQ service that maps
no source IDs.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index a354fa25998f7..37851af59ffe1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -4508,6 +4508,61 @@ static void dm_test_dcn10_register_irq_handlers_one_crtc(struct kunit *test)
 	amdgpu_dm_irq_fini(adev);
 }
 
+/**
+ * dm_test_dcn10_register_irq_handlers_vupdate_add_id_fails - Test add-id failure
+ * @test: The KUnit test context
+ *
+ * A VUPDATE source with no funcs table must be rejected by amdgpu_irq_add_id().
+ */
+static void dm_test_dcn10_register_irq_handlers_vupdate_add_id_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_dcn10);
+	adev->vupdate_irq.funcs = NULL;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dcn10_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dcn10_register_irq_handlers_bad_vupdate_source - Test VUPDATE guard
+ * @test: The KUnit test context
+ *
+ * A source ID that DC does not map to a VUPDATE IRQ source must be rejected
+ * rather than used to index the vupdate parameter array.
+ */
+static void dm_test_dcn10_register_irq_handlers_bad_vupdate_source(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_unmapped);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dcn10_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dcn10_register_irq_handlers_hpd_add_id_fails - Test HPD add-id failure
+ * @test: The KUnit test context
+ *
+ * The VUPDATE loop succeeds, then the HPD source with no funcs table is
+ * rejected by amdgpu_irq_add_id().
+ */
+static void dm_test_dcn10_register_irq_handlers_hpd_add_id_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_dcn10);
+	adev->hpd_irq.funcs = NULL;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dcn10_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 /**
  * dm_test_register_outbox_irq_handlers_without_dmub - Test outbox registration without DMUB
  * @test: The KUnit test context
@@ -4532,6 +4587,25 @@ static void dm_test_register_outbox_irq_handlers_without_dmub(struct kunit *test
 		&adev->dmub_outbox_irq);
 }
 
+/**
+ * dm_test_register_outbox_irq_handlers_add_id_fails - Test outbox add-id failure
+ * @test: The KUnit test context
+ *
+ * Registering the outbox interrupt before amdgpu_dm_set_irq_funcs() has run
+ * leaves the source without a funcs table, so amdgpu_irq_add_id() rejects it.
+ */
+static void dm_test_register_outbox_irq_handlers_add_id_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	adev->dm.dc = dc;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_outbox_irq_handlers(adev), -EINVAL);
+}
+
 /**
  * dm_test_register_outbox_irq_handlers_with_dmub - Test outbox registration with DMUB
  * @test: The KUnit test context
@@ -4871,7 +4945,11 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_dce110_register_irq_handlers_hpd_add_id_fails),
 	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_zero_crtc),
 	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_one_crtc),
+	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_vupdate_add_id_fails),
+	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_bad_vupdate_source),
+	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_hpd_add_id_fails),
 	KUNIT_CASE(dm_test_register_outbox_irq_handlers_without_dmub),
+	KUNIT_CASE(dm_test_register_outbox_irq_handlers_add_id_fails),
 	KUNIT_CASE(dm_test_register_outbox_irq_handlers_with_dmub),
 	/* amdgpu_dm_irq_handler */
 	KUNIT_CASE(dm_test_irq_handler_dispatches_work),
-- 
2.43.0

