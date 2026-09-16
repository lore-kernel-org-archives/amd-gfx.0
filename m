Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF0DC982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DB110ECFC;
	Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBNebsR7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBE210EC90
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwxMJHmIKY6gS7mrg+IvGmrf1M4VPH/eXPj4mdjcYF4inszOhVMML2aMk9+3UDDlYguf6R6S3SlYUdPM3y9ZEGWtXXza6zBJZDq29ufO3NUL0SLQLH+ZmnNIcYmUHkiD4LnjBv/iK/l45AGCl8heeG+mV/HHfe5xyo4QvDv+yuLs7c5rf2Y1kIN7hZ2NaVOkKkyUzhPgX7ylYfgMNWALhFVM+0UxHyEqUXzxf1hFF0bZN60iGAtsPmNIXs84x+V0SI/OpE7c2YBsfOBA+dX9Gcs+Z4lvRJR6VHAYRoICYjCN7Py0tRfo8Df4vMngLa3Yu4+cKfA71hwiMBWwj855Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/soAftpD/Twcodd8HWhEnTO6/2HEOT8PrGme3wanzLU=;
 b=te/fET+3jkUAZWxI5cO8xRDOd0vKci++/Jnjj/CjVDscVCIDLCwdvm+KcLt1MMUwuvBq8MIVUhoFuTZROiZrTiNm00kIxK4wGhbRVClVLBqmDMuPCXbxSBmqYjnUDqn+9D/x9PF4XGBJlOgtnqXtT/gH4fET6b85IfpFeATIQ/DOmsr4vgZFbPA7qLoj6bTWohMo+f7XUjlPIMAnvUhY6G9Z42I+ODj/VyIkd3lVapwaSwRJdOs1dY2wF5O2W4ntFdWLsvEjUOxWzz93cO66MIy4Bs63hNUTs1XNyNnvX4+NQZRdzo/RFVaDXwN6o0UFt04Nj5v5wzn1lWH3hi6V1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/soAftpD/Twcodd8HWhEnTO6/2HEOT8PrGme3wanzLU=;
 b=SBNebsR7FY0QfXS+Q2acAHQBkJ749AHngf2E4ZgirJw2hGlkufrKSrluiyoNIc1gsVrrFgb56UKnVwJ84YGt71QPhBg9LOvnMZ9dJHH9HR1Bclwc8u7VyyG3+3eIcV61BjM28vj1KCXvT2jL8zff4bSiwQyb9rmb8smFvq1lZQo=
Received: from CH0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:610:e4::35)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:52:54 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::3) by CH0PR03CA0210.outlook.office365.com
 (2603:10b6:610:e4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:54 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:42 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 37/64] drm/amd/display: Drop redundant amdgpu_dm_irq tests
Date: Wed, 16 Sep 2026 13:51:52 -0400
Message-ID: <20260916175301.368306-38-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfa2c57-0c5b-4569-0bf9-08df141b55f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|5023799004|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XkBT/GgkBLVLlkGCExg+nBKDH/L+zSx7IHur6aMsiv/6QZs8czzRKn9RRMjcA47H5/3pKNZXpt4h3zz/Oqhk849zW6IJMTHXLtCnqpnbV+Qer/oiyG0MJhdvB5BPjOSV25S9OWtbI2h7KVrl90Li4dEi5Px15AtM117ZlYPJC3lfFqqGGnieydU+m/7r/vWy5UCVri/c2nWP3/vxEKtk3fj8cFbA9oiu+lYnaUXXl7tRkWKRotTVVjvu78ZRjjXGJhN6r/vLGI+3aE8iDBH9EB1IKQKbn5ZjIbgLhJt1pINxATLj9H92zlWrZ09K9+O6nPbn5DFS5ydvqtAp+Gh1CgCgsOUbhSCk78bTcdM2zcjiY4N3z8ScQ+C7mE/Vq7CWkSpS0WS/xOweoL1aVoA9NaAnvjIiqGwPqh1l9hkepCVqEHxJ1L7kKnX7vokiLfpWsrS1GzhNVREg7c3MXjWCuY7lP+U0dHgTpjqdM0h66vpcNs3FdAuT4JlJAr1BKjNQVLrcN5ej7J22Fn4HLkafc/FhbS1qpf/SlXsPrj1difTXOfi9Qhhdv2KD1y2PprBpCYjGAxZAcZb1A4FKFrJZ3eEFvS775rAatSurGAg/RTSBUFCuzuQBndgzf7XYa2dh1O9nnNCEHbXFVnAd+n5Z/3u6jIAvQqXLWOrgSmP7UORmkeKIjW+FrEGoEViWn/Laryz47ADtz7QjAwITAvVFPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RfLf0kjSGGBePLWBQTDsLpKqM6GquZ9EDTnC58uDTXPheCAawXncS9l2Bcmc8GuPl4l5JhjLUzgXLYa3jtne0kXcHu7NAK0ZLJkZtHWpd1oxPXd/P9/twMlKDSLqWhAIN6v1hcMIdzzSNnck+g9274XSD+rmfTS5zOEoaHAKknZjmWYZxMpW+GcATMGY8Lbfb+kLZg/rvMxl9dvuAn7ExWsMyPTsR5e3UiBHhh4JIWuplBRmHgjGIpv4BhDS/9ROQiPiW8Cy6QdLj5cjG67jac3tIO11nL2s73bkTG3YLnhQpqUOHlB8Ou5qtDWD/9SmuHvdu6TD9rj9dZrTwVg4ZB7RKujzrXy7qNCTE+Uwfqs7tiEwu7cxNJizhwE/VOen5BJTUkm3vlI+xLZMAB6ZWfkpmccPJJlNIIT9/BAjjNg00K+hFRh0HhPTu/dS1a/X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:54.7886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfa2c57-0c5b-4569-0bf9-08df141b55f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
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
Thirteen tests in the amdgpu_dm_irq suite only re-ran a path that
another test already covered, and five more repeated setup that the
fixtures added by the preceding patches now provide.

[HOW]
Delete the tests whose executed path is a strict subset of
another's, and fold the remaining duplicated setup onto the shared
fixtures.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 499 +-----------------
 1 file changed, 11 insertions(+), 488 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index a4fd30613419..72207eb4e076 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -266,7 +266,6 @@ static const struct timing_generator_funcs dm_test_tg_funcs = {
 	.get_scanoutpos = dm_test_tg_get_scanoutpos,
 };
 
-
 static uint32_t dm_test_dmub_get_outbox0_wptr(struct dmub_srv *dmub)
 {
 	return 0;
@@ -666,27 +665,8 @@ static void dm_test_hpd_to_dal_irq_source_invalid(struct kunit *test)
 			(int)DC_IRQ_SOURCE_INVALID);
 }
 
-/**
- * dm_test_hpd_to_dal_irq_source_out_of_range - Test Hpd to dal irq source out of range
- * @test: The KUnit test context
- */
-static void dm_test_hpd_to_dal_irq_source_out_of_range(struct kunit *test)
-{
-	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_hpd_to_dal_irq_source(99),
-			(int)DC_IRQ_SOURCE_INVALID);
-}
-
 /* Tests for are_sinks_equal() */
 
-/**
- * dm_test_are_sinks_equal_both_null - Test Are sinks equal both null
- * @test: The KUnit test context
- */
-static void dm_test_are_sinks_equal_both_null(struct kunit *test)
-{
-	KUNIT_EXPECT_FALSE(test, are_sinks_equal(NULL, NULL));
-}
-
 /**
  * dm_test_are_sinks_equal_first_null - Test Are sinks equal first null
  * @test: The KUnit test context
@@ -778,29 +758,6 @@ static void dm_test_are_sinks_equal_different_edid_data(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, are_sinks_equal(sink1, sink2));
 }
 
-/**
- * dm_test_are_sinks_equal_identical - Test Are sinks equal identical
- * @test: The KUnit test context
- */
-static void dm_test_are_sinks_equal_identical(struct kunit *test)
-{
-	struct dc_sink *sink1, *sink2;
-
-	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
-	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
-
-	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
-	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
-	sink1->dc_edid.length = 4;
-	sink2->dc_edid.length = 4;
-	memset(sink1->dc_edid.raw_edid, 0xAA, 4);
-	memset(sink2->dc_edid.raw_edid, 0xAA, 4);
-
-	KUNIT_EXPECT_TRUE(test, are_sinks_equal(sink1, sink2));
-}
-
 /**
  * dm_test_are_sinks_equal_zero_length - Test Are sinks equal zero length
  * @test: The KUnit test context
@@ -1044,105 +1001,6 @@ static void dm_test_irq_register_rejects_invalid_source(struct kunit *test)
 						   dm_test_irq_handler, NULL));
 }
 
-/**
- * dm_test_irq_register_adds_low_context_handler - Test register adds low handler
- * @test: The KUnit test context
- */
-static void dm_test_irq_register_adds_low_context_handler(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc_interrupt_params int_params = { 0 };
-	void *handler;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
-
-	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
-	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
-
-	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
-						    dm_test_irq_handler, adev);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
-	KUNIT_EXPECT_FALSE(test,
-			   list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
-	KUNIT_EXPECT_TRUE(test,
-			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD1]));
-
-	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
-						dm_test_irq_handler);
-	KUNIT_EXPECT_TRUE(test,
-			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
-}
-
-/**
- * dm_test_irq_register_adds_high_context_handler - Test register adds high handler
- * @test: The KUnit test context
- */
-static void dm_test_irq_register_adds_high_context_handler(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc_interrupt_params int_params = { 0 };
-	void *handler;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
-
-	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-	int_params.irq_source = DC_IRQ_SOURCE_HPD2;
-
-	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
-						    dm_test_irq_handler, adev);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
-	KUNIT_EXPECT_FALSE(test,
-			   list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD2]));
-	KUNIT_EXPECT_TRUE(test,
-			  list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD2]));
-
-	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD2,
-						dm_test_irq_handler);
-	KUNIT_EXPECT_TRUE(test,
-			  list_empty(&adev->dm.irq_handler_list_high_tab[DC_IRQ_SOURCE_HPD2]));
-}
-
-/**
- * dm_test_irq_register_multiple_handlers - Test register keeps multiple handlers
- * @test: The KUnit test context
- */
-static void dm_test_irq_register_multiple_handlers(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc_interrupt_params int_params = { 0 };
-	struct list_head *hnd_list;
-	void *handler1, *handler2;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
-
-	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
-	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
-
-	handler1 = amdgpu_dm_irq_register_interrupt(adev, &int_params,
-						    dm_test_irq_handler, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler1);
-	handler2 = amdgpu_dm_irq_register_interrupt(adev, &int_params,
-						    dm_test_irq_handler_alt, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler2);
-
-	hnd_list = &adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1];
-	KUNIT_EXPECT_EQ(test, list_count_nodes(hnd_list), 2);
-
-	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
-						dm_test_irq_handler);
-	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
-						dm_test_irq_handler_alt);
-	KUNIT_EXPECT_TRUE(test, list_empty(hnd_list));
-}
-
 /**
  * dm_test_irq_register_separate_contexts - Test register same source in two contexts
  * @test: The KUnit test context
@@ -1870,48 +1728,6 @@ static void dm_test_set_pflip_irq_state_disable(struct kunit *test)
 			amdgpu_dm_set_pflip_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_DISABLE), 0);
 }
 
-/**
- * dm_test_set_vline0_irq_state_enable - Test vline0 irq state reaches DC (enable)
- * @test: The KUnit test context
- */
-static void dm_test_set_vline0_irq_state_enable(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct amdgpu_crtc *acrtc;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
-
-	acrtc->otg_inst = 0;
-	adev->mode_info.crtcs[0] = acrtc;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_set_vline0_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
-}
-
-/**
- * dm_test_set_vupdate_irq_state_enable - Test vupdate irq state reaches DC (enable)
- * @test: The KUnit test context
- */
-static void dm_test_set_vupdate_irq_state_enable(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct amdgpu_crtc *acrtc;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
-
-	acrtc->otg_inst = 2;
-	adev->mode_info.crtcs[0] = acrtc;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_set_vupdate_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
-}
-
 /**
  * dm_test_set_crtc_irq_state_allows_idle - Test the idle-optimization branch
  * @test: The KUnit test context
@@ -1971,34 +1787,6 @@ static void dm_test_irq_immediate_work_empty(struct kunit *test)
 	amdgpu_dm_irq_immediate_work(adev, DC_IRQ_SOURCE_HPD1);
 }
 
-/**
- * dm_test_irq_immediate_work_invokes_handler - Test immediate work calls handler
- * @test: The KUnit test context
- */
-static void dm_test_irq_immediate_work_invokes_handler(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc_interrupt_params int_params = { 0 };
-	int count = 0;
-	void *handler;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
-
-	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
-	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
-						   dm_test_irq_handler_count, &count);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
-
-	/* High-context handlers are invoked synchronously, in-place. */
-	amdgpu_dm_irq_immediate_work(adev, DC_IRQ_SOURCE_HPD1);
-	KUNIT_EXPECT_EQ(test, count, 1);
-
-	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1, dm_test_irq_handler_count);
-}
-
 /**
  * dm_test_irq_immediate_work_invokes_all - Test immediate work calls all handlers
  * @test: The KUnit test context
@@ -2449,52 +2237,6 @@ static void dm_test_hpd_rx_offload_work_no_connector(struct kunit *test)
 	dm_handle_hpd_rx_offload_work(&offload_work->work);
 }
 
-/**
- * dm_test_hpd_rx_offload_work_no_connection - Test no connection early exit
- * @test: The KUnit test context
- */
-static void dm_test_hpd_rx_offload_work_no_connection(struct kunit *test)
-{
-	struct hpd_rx_irq_offload_work_queue *offload_wq;
-	struct hpd_rx_irq_offload_work *offload_work;
-	struct amdgpu_dm_connector *aconn;
-	struct link_service *link_srv;
-	struct amdgpu_device *adev;
-	struct dc_link *link;
-	struct dc *dc;
-
-	adev = dm_kunit_alloc_adev(test);
-	mutex_init(&adev->dm.dc_lock);
-
-	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
-
-	aconn = dm_kunit_alloc_connector(test, adev, NULL);
-	mutex_init(&aconn->hpd_lock);
-	offload_wq->aconnector = aconn;
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
-	link_srv->detect_connection_type = dm_test_detect_connection_none;
-	dc->link_srv = link_srv;
-
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
-	link->dc = dc;
-	aconn->dc_link = link;
-
-	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
-	offload_work->offload_wq = offload_wq;
-	offload_work->adev = adev;
-	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
-
-	dm_handle_hpd_rx_offload_work(&offload_work->work);
-}
-
 /*
  * Build a queued hpd_rx_irq_offload_work for dm_handle_hpd_rx_offload_work():
  * an adev that is not in reset, an offload queue owning a connector with an
@@ -2656,58 +2398,15 @@ static void dm_test_hpd_rx_offload_work_msg_rdy(struct kunit *test)
  */
 static void dm_test_hpd_rx_offload_work_automated_test(struct kunit *test)
 {
-	struct hpd_rx_irq_offload_work_queue *offload_wq;
 	struct hpd_rx_irq_offload_work *offload_work;
-	struct amdgpu_dm_connector *aconn;
 	struct link_service *link_srv;
-	struct amdgpu_device *adev;
-	struct dc_context *ctx;
-	struct dc_link *link;
-	struct dc *dc;
 
 	dm_test_automated_test_count = 0;
 
-	adev = dm_kunit_alloc_adev(test);
-	mutex_init(&adev->dm.dc_lock);
-	adev->reset_domain = kunit_kzalloc(test, sizeof(*adev->reset_domain),
-					   GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->reset_domain);
-
-	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
-	spin_lock_init(&offload_wq->offload_lock);
-
-	aconn = dm_kunit_alloc_connector(test, adev, NULL);
-	mutex_init(&aconn->hpd_lock);
-	aconn->timing_changed = false;
-	offload_wq->aconnector = aconn;
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
-
-	link_srv->detect_connection_type = dm_test_detect_connection_single;
+	offload_work = dm_test_setup_hpd_rx_offload_work(test, &link_srv);
 	link_srv->dp_handle_automated_test = dm_test_dp_handle_automated_test;
-	dc->link_srv = link_srv;
-	dc->ctx = ctx;
-	ctx->dc = dc;
-	link->dc = dc;
-	link->ctx = ctx;
-	link->aux_access_disabled = true;
-	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
-	aconn->dc_link = link;
-
-	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
-	offload_work->offload_wq = offload_wq;
-	offload_work->adev = adev;
+	offload_work->offload_wq->aconnector->dc_link->aux_access_disabled = true;
 	offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST = 1;
-	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
 
 	dm_handle_hpd_rx_offload_work(&offload_work->work);
 
@@ -2757,58 +2456,16 @@ static void dm_test_hpd_rx_offload_work_timing_changed(struct kunit *test)
  */
 static void dm_test_hpd_rx_offload_work_link_loss(struct kunit *test)
 {
-	struct hpd_rx_irq_offload_work_queue *offload_wq;
 	struct hpd_rx_irq_offload_work *offload_work;
-	struct amdgpu_dm_connector *aconn;
 	struct link_service *link_srv;
-	struct amdgpu_device *adev;
-	struct dc_context *ctx;
-	struct dc_link *link;
-	struct dc *dc;
 
 	dm_test_handle_link_loss_count = 0;
 
-	adev = dm_kunit_alloc_adev(test);
-	mutex_init(&adev->dm.dc_lock);
-	adev->reset_domain = kunit_kzalloc(test, sizeof(*adev->reset_domain),
-					   GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->reset_domain);
-
-	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
-	spin_lock_init(&offload_wq->offload_lock);
-
-	aconn = dm_kunit_alloc_connector(test, adev, NULL);
-	mutex_init(&aconn->hpd_lock);
-	offload_wq->aconnector = aconn;
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
-
-	link_srv->detect_connection_type = dm_test_detect_connection_single;
+	offload_work = dm_test_setup_hpd_rx_offload_work(test, &link_srv);
 	link_srv->dp_parse_link_loss_status = dm_test_dp_parse_link_loss_true;
 	link_srv->dp_should_allow_hpd_rx_irq = dm_test_dp_should_allow_hpd_rx_irq_true;
 	link_srv->dp_read_hpd_rx_irq_data = dm_test_dp_read_hpd_rx_irq_data_ok;
 	link_srv->dp_handle_link_loss = dm_test_dp_handle_link_loss;
-	dc->link_srv = link_srv;
-	dc->ctx = ctx;
-	ctx->dc = dc;
-	link->dc = dc;
-	link->ctx = ctx;
-	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
-	aconn->dc_link = link;
-
-	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
-	offload_work->offload_wq = offload_wq;
-	offload_work->adev = adev;
-	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
 
 	dm_handle_hpd_rx_offload_work(&offload_work->work);
 
@@ -2870,35 +2527,8 @@ static void dm_test_hdmi_hpd_debounce_detect_false(struct kunit *test)
 {
 	struct amdgpu_dm_connector *aconn;
 	struct link_service *link_srv;
-	struct amdgpu_device *adev;
-	struct dc_context *ctx;
-	struct dc_link *link;
-	struct dc *dc;
-
-	adev = dm_kunit_alloc_adev(test);
-	mutex_init(&adev->dm.dc_lock);
-
-	aconn = dm_kunit_alloc_connector(test, adev, NULL);
-	mutex_init(&aconn->hpd_lock);
-	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
-			  amdgpu_dm_hdmi_hpd_debounce_work);
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	link_srv->detect_link = dm_test_detect_link_false;
-	dc->ctx = ctx;
-	dc->link_srv = link_srv;
-	ctx->dc = dc;
-	link->dc = dc;
-	link->ctx = ctx;
-	aconn->dc_link = link;
+	aconn = dm_test_setup_hdmi_debounce(test, &link_srv);
 
 	amdgpu_dm_hdmi_hpd_debounce_work(&aconn->hdmi_hpd_debounce_work.work);
 	KUNIT_EXPECT_NULL(test, aconn->hdmi_prev_sink);
@@ -2919,43 +2549,19 @@ static void dm_test_hdmi_hpd_debounce_reallow_idle(struct kunit *test)
 	struct amdgpu_dm_connector *aconn;
 	struct link_service *link_srv;
 	struct dc_dmub_srv *dmub_srv;
-	struct amdgpu_device *adev;
 	struct dal_logger *logger;
-	struct dc_context *ctx;
-	struct dc_link *link;
 	struct dc *dc;
 
-	adev = dm_kunit_alloc_adev(test);
-	mutex_init(&adev->dm.dc_lock);
-
-	aconn = dm_kunit_alloc_connector(test, adev, NULL);
-	mutex_init(&aconn->hpd_lock);
-	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
-			  amdgpu_dm_hdmi_hpd_debounce_work);
+	aconn = dm_test_setup_hdmi_debounce(test, &link_srv);
+	dc = aconn->dc_link->ctx->dc;
 
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
 	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
 
-	link_srv->detect_link = dm_test_detect_link_false;
-	dc->ctx = ctx;
-	dc->link_srv = link_srv;
-	ctx->dc = dc;
-	link->dc = dc;
-	link->ctx = ctx;
-	aconn->dc_link = link;
-
 	/* DC_LOG_* dereferences ctx->logger->dev, so wire a real drm device. */
-	logger->dev = &adev->ddev;
+	logger->dev = aconn->base.dev;
 	dc->ctx->logger = logger;
 
 	/* Make reallow_idle true and keep dc_allow_idle*() a safe early return. */
@@ -2965,7 +2571,7 @@ static void dm_test_hdmi_hpd_debounce_reallow_idle(struct kunit *test)
 	dc->debug.disable_idle_power_optimizations = true;
 
 	/* A cached previous sink must be released and cleared. */
-	aconn->hdmi_prev_sink = dm_test_sink_create(link);
+	aconn->hdmi_prev_sink = dm_test_sink_create(aconn->dc_link);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn->hdmi_prev_sink);
 
 	amdgpu_dm_hdmi_hpd_debounce_work(&aconn->hdmi_hpd_debounce_work.work);
@@ -3206,37 +2812,13 @@ static void dm_test_handle_hpd_irq_helper_debounce_release_prev(struct kunit *te
 	dm_test_sink_release(link->local_sink);
 }
 
-/**
- * dm_test_handle_hpd_irq_helper_detect_false - Test immediate detect branch
- * @test: The KUnit test context
- *
- * With no force, no debounce, and detection stubbed to report no connection,
- * the helper takes the else branch: dc_exit_ips_for_hw_access() is a safe
- * no-op (no IPS support) and dc_link_detect() returns false, so the connected
- * if (ret) block is skipped. fake_enable must still be cleared.
- */
-static void dm_test_handle_hpd_irq_helper_detect_false(struct kunit *test)
-{
-	struct amdgpu_dm_connector *aconn;
-	struct link_service *link_srv;
-
-	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
-	link_srv->detect_link = dm_test_detect_link_false;
-	aconn->fake_enable = true;
-
-	/* No debounce delay and no force -> immediate-detect else branch. */
-	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
-
-	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
-}
-
 /**
  * dm_test_handle_hpd_irq_helper_detect_type_fails - Test detect failure logging
  * @test: The KUnit test context
  *
- * When dc_link_detect_connection_type() itself fails the helper logs an error
- * and carries on with the connection type left as none, so it still falls
- * through to the immediate-detect branch.
+ * When dc_link_detect_connection_type() fails the helper logs an error and
+ * carries on with the connection type left as none, so with no force and no
+ * debounce it still takes the immediate-detect branch.
  */
 static void dm_test_handle_hpd_irq_helper_detect_type_fails(struct kunit *test)
 {
@@ -3497,24 +3079,6 @@ static struct amdgpu_dm_connector *dm_test_setup_hpd_rx_irq(struct kunit *test,
 	return aconn;
 }
 
-/**
- * dm_test_handle_hpd_rx_irq_no_left_work - Test HPDRX early out (no left work)
- * @test: The KUnit test context
- *
- * When dc_link_handle_hpd_rx_irq() reports no left-over work, the handler
- * jumps to out and returns without scheduling any offload work.
- */
-static void dm_test_handle_hpd_rx_irq_no_left_work(struct kunit *test)
-{
-	struct amdgpu_dm_connector *aconn;
-	struct link_service *link_srv;
-
-	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
-	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_no_work;
-
-	handle_hpd_rx_irq(aconn);
-}
-
 /**
  * dm_test_handle_hpd_rx_irq_automated_test - Test HPDRX automated-test path
  * @test: The KUnit test context
@@ -3579,34 +3143,6 @@ static void dm_test_handle_hpd_rx_irq_link_loss(struct kunit *test)
 				->dm.hpd_rx_offload_wq->is_handling_link_loss);
 }
 
-/**
- * dm_test_handle_hpd_rx_irq_downstream_change - Test HPDRX post-detect block
- * @test: The KUnit test context
- *
- * A handled HPD RX IRQ on a connector that is not an MST root means a
- * downstream port status change, so the handler must re-detect the link.
- * Detection is stubbed to fail, leaving the connector untouched, and a
- * non-MST-branch link also exercises the trailing CEC IRQ dispatch.
- */
-static void dm_test_handle_hpd_rx_irq_downstream_change(struct kunit *test)
-{
-	struct amdgpu_dm_connector *aconn;
-	struct link_service *link_srv;
-
-	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
-	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_result_true;
-	link_srv->detect_connection_type = dm_test_detect_connection_single;
-	link_srv->detect_link = dm_test_detect_link_false;
-
-	aconn->mst_mgr.mst_state = false;
-	aconn->dc_link->type = dc_connection_single;
-	aconn->fake_enable = true;
-
-	handle_hpd_rx_irq(aconn);
-
-	KUNIT_EXPECT_TRUE(test, aconn->fake_enable);
-}
-
 /**
  * dm_test_handle_hpd_rx_irq_detect_type_fails - Test HPDRX detect failure logging
  * @test: The KUnit test context
@@ -5548,15 +5084,12 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd5),
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd6),
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_invalid),
-	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_out_of_range),
 	/* are_sinks_equal */
-	KUNIT_CASE(dm_test_are_sinks_equal_both_null),
 	KUNIT_CASE(dm_test_are_sinks_equal_first_null),
 	KUNIT_CASE(dm_test_are_sinks_equal_second_null),
 	KUNIT_CASE(dm_test_are_sinks_equal_different_signal),
 	KUNIT_CASE(dm_test_are_sinks_equal_different_edid_length),
 	KUNIT_CASE(dm_test_are_sinks_equal_different_edid_data),
-	KUNIT_CASE(dm_test_are_sinks_equal_identical),
 	KUNIT_CASE(dm_test_are_sinks_equal_zero_length),
 	KUNIT_CASE(dm_test_are_sinks_equal_full_edid_identical),
 	KUNIT_CASE(dm_test_are_sinks_equal_full_edid_last_byte_differs),
@@ -5576,9 +5109,6 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_irq_register_rejects_null_params),
 	KUNIT_CASE(dm_test_irq_register_rejects_invalid_context),
 	KUNIT_CASE(dm_test_irq_register_rejects_invalid_source),
-	KUNIT_CASE(dm_test_irq_register_adds_low_context_handler),
-	KUNIT_CASE(dm_test_irq_register_adds_high_context_handler),
-	KUNIT_CASE(dm_test_irq_register_multiple_handlers),
 	KUNIT_CASE(dm_test_irq_register_separate_contexts),
 	/* amdgpu_dm_irq_unregister_interrupt */
 	KUNIT_CASE(dm_test_irq_unregister_rejects_invalid_source),
@@ -5617,12 +5147,9 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_set_crtc_irq_state_otg_disabled),
 	KUNIT_CASE(dm_test_set_crtc_irq_state_enable),
 	KUNIT_CASE(dm_test_set_pflip_irq_state_disable),
-	KUNIT_CASE(dm_test_set_vline0_irq_state_enable),
-	KUNIT_CASE(dm_test_set_vupdate_irq_state_enable),
 	KUNIT_CASE(dm_test_set_crtc_irq_state_allows_idle),
 	/* amdgpu_dm_irq_immediate_work */
 	KUNIT_CASE(dm_test_irq_immediate_work_empty),
-	KUNIT_CASE(dm_test_irq_immediate_work_invokes_handler),
 	KUNIT_CASE(dm_test_irq_immediate_work_invokes_all),
 	/* amdgpu_dm_irq_schedule_work */
 	KUNIT_CASE(dm_test_irq_schedule_work_empty),
@@ -5646,7 +5173,6 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_hpd_init_skips_connector_without_link),
 	/* dm_handle_hpd_rx_offload_work */
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connector),
-	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connection),
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_detect_type_fails),
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_in_reset),
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_msg_rdy),
@@ -5662,7 +5188,6 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_handle_hpd_irq_disabled),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_schedule),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_release_prev),
-	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_false),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_type_fails),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_pending),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_hdcp_reset),
@@ -5670,11 +5195,9 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_true),
 	/* handle_hpd_rx_irq/schedule_hpd_rx_offload_work */
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_disabled),
-	KUNIT_CASE(dm_test_handle_hpd_rx_irq_no_left_work),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_automated_test),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_msg_rdy),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_link_loss),
-	KUNIT_CASE(dm_test_handle_hpd_rx_irq_downstream_change),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_detect_type_fails),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_forced_detect),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_detect_true),
-- 
2.55.0

