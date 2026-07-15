Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F6BC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB3A10F09B;
	Wed, 15 Jul 2026 13:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26NGIa3e";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7638A10F099
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHpWh8loU1vLRIV3NEF2iXOzs3OouJrc+ehY5vHyekgan7nSydyKiyNW3w3khVttNUbTsX/Xy8nkyhsjfcwmO82quNthKam59+q+5XH2RTTSEGnB8UnwRI9k0RWos0hJUWeEplSwVfvFl4cWyqv0fGbIWVg8+GrWZ69cZ4Gbdd9u1tdHz9xp02ySddb3/u/LDsEQ7AXUCDfrHqly3xeXnrjrJQitURTVBWphv7NLyICKgzaJk+ev8rkTGUODLQMnXv92FLJBJJWbcEsesPgS1fmLgTl7L1C9tgl3+/ioCs9TzEtg6YP/p5dSxrAahXjcfGsT55Jl5kzsDOaZAi3RwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYYAgon2HCgJm0ACR32Qa4bQdhVS61P/EotoJrlrELE=;
 b=V4yGAnRMPKO66nsXJFuyFHtJRd8XLc+tklSL4goAg+tO3FsRZK6+xrXic/OHHfWgkx1raHuvQ2Qlb/KmYf0npG/At417IBkV4Luyze9GARhsp6Wh2+K7FBimqSHGWV73ru7GCNCuSwKVCQ7yj9XU/3oJDx0EtjL+ekXEEdSvs1OP9iRR1kDcp1GTou+5vQD2QQvZ/U0upHolXM8wFMSUM3iTXsPbFCp6IGXC276jbQTaedCLF2omuDuTbadE8PPh2Li/Z8F2f5z4hYlHQgjM4HGwlN3HMW0RtPsLvvtkgP4DVzI5IVXILYlEssqwKPr6WIoVMp9SocH8SL5rB86/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYYAgon2HCgJm0ACR32Qa4bQdhVS61P/EotoJrlrELE=;
 b=26NGIa3eW8cO0Td7kiXsq1F9O2eDcecTHN4mWjvsqcJj6on3hFVwGYYHnHA0tWd5CQuPEEOb3fr0ZsHwTS3663AZ2S7jBhPypJdYbzJBouur4uEqJpZm/ZrxV3vSuLfeezGKzR9fFHQcwfbxAza3+Jf9mNidWlYd53KDj2PlC70=
Received: from CYZPR20CA0022.namprd20.prod.outlook.com (2603:10b6:930:a2::21)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:47:36 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::19) by CYZPR20CA0022.outlook.office365.com
 (2603:10b6:930:a2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:34 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 43/70] drm/amd/display: add CRC IRQ handler KUnit coverage
Date: Wed, 15 Jul 2026 21:37:53 +0800
Message-ID: <20260715134432.1975118-44-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: ff72c062-89e1-4a39-1fbf-08dee277a0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: WWLJ5Q2tHh7h99Bq4fReqILnoqewEYT/siWV2xCv3j5VMSAX2D3Qb7idGYtVX1E473xsiqmq21+7jIEgDb8U0LLEALUSuYKnJofZ5IVb5B+Z30JsGwd6o7GA/J6ER+oXZ3j3zZZxFmAsgsebwV+CW+v+/zD3SCKSNNAJDj+WpxJTmVbrOWE2AePAjsZ+xZPqx6J4Whk0pXvuxkgfYLRPkbrFr/Tt+A+rkNm2PHpaczmLH/ShV+zUdehQ+X66oE05aEuwH2CNAU3OaDCjZiFsm/DwSVzv0xerTPYoxQ4Prnxall3D1UCDjI0mTgOkP6M/drxCfqVNEKMTHzpd5qhbbKezsy2RyRgyS2FH48kH2pwaFdhf0pMaLnawb36lP01wwvO4PzBI1sgyOIB5CkbGx4P3mkkC2vqKMi0l8LcMPCTgpzZcko2Caq+qNXi8dtoYXQMQjOsTU+pvmAYjm6yrwHjllqPxAWNnZBNA8Pi06m95O73weREoGRgZnYoz9Xd5nQ8db+yI14KRQElpzF9qKn66px9gn/fDtaA9lNYDojhCG8m4aHQjL3ZaCxzimc2YcyqI8wj8kBK8EkS03NxVw7wy5ZJKMfEgfgZNAFzG3HOCPiJfVmzSvh5OFZMgEJgsL1zxC9UcQVDaF5wnpEDdkijXyrW9MqfeMFbN62Ml3QgknL3v6zP1Hy2cY2BmE0hvOqRkUNgifm2D6Gp+whSWJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hhFMFmsJcgl9yXX9Zg9udcMe65f82G/5TXnDloKdYEblRr0tN7cCY9IDzvodc0j7M3LxYV8XhUKQOPOZrvBTltA+g6rmm1B8y61BfTZQ5VO2NHnY7OVqqwN9O4Fyr2h7eYl+KKkRT2mZFi4rJ3p7blt6AdlcqwBz1DLBpY6DlLp21MV89KwVX1NMmBUh+5cWfMLGY3seRynIWKJaroomkJjfuw0s9dl/tbfCOltnpJjy9aHfCxeV4vC2nSwxJdE6aqCDcohaFZTFUVZeDcvmlq1Fu2JnV7kjmBfT3Xk7+CNKOeqxocfo7Z7xr56GLSWHm3sgCwNyGeEtSMjBNIgeIrBGIDCcfY2Md1/CzZiAcM44aKwpUpIfyvg8hvz+k5I5aZvhQbBfvb7arGij3oEa0Ld5cNcYgMVxiEsevKfW9oJGO5WawrSP0ZGAjAikzarw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:36.0603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff72c062-89e1-4a39-1fbf-08dee277a0e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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
Expose amdgpu_dm_crtc_handle_crc_irq() for KUnit and add tests for the
incomplete-CRTC early returns, the disabled-source exit, the initial
two-frame skip window, the DPRX post-skip exit, and the failed
dc_stream_get_crc() path that stops before delivering a DRM CRC entry.

These tests reuse the fake DC fixture introduced with the CRC configure
coverage.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 132 ++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 0e896aab098a..078d2b589ec4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -874,6 +874,7 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 				       drm_crtc_accurate_vblank_count(crtc), crcs);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_handle_crc_irq);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 96bdb83317ec..29a513dab9cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -673,6 +673,132 @@ static void dm_test_crtc_set_crc_source_dprx_no_connector(struct kunit *test)
 			AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
 }
 
+/**
+ * dm_test_crtc_handle_crc_irq_early_returns() - Test null/missing state exits.
+ * @test: KUnit test context.
+ *
+ * Verifies that the CRC IRQ handler safely ignores incomplete CRTC objects.
+ */
+static void dm_test_crtc_handle_crc_irq_early_returns(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_crtc_state *dm_state;
+
+	amdgpu_dm_crtc_handle_crc_irq(NULL);
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	acrtc->base.state = &dm_state->base;
+
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+	KUNIT_EXPECT_EQ(test, dm_state->crc_skip_count, 0);
+}
+
+/**
+ * dm_test_crtc_handle_crc_irq_disabled_source() - Test disabled source exit.
+ * @test: KUnit test context.
+ *
+ * Verifies that a present stream does not advance the skip counter when CRC
+ * capture is disabled.
+ */
+static void dm_test_crtc_handle_crc_irq_disabled_source(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_crtc_state *dm_state;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	dm_state->stream = dm_kunit_alloc_stream(test, NULL);
+	acrtc->base.state = &dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_NONE;
+
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+
+	KUNIT_EXPECT_EQ(test, dm_state->crc_skip_count, 0);
+}
+
+/**
+ * dm_test_crtc_handle_crc_irq_skips_initial_frames() - Test initial skip logic.
+ * @test: KUnit test context.
+ *
+ * Verifies that the first two enabled CRC IRQs only increment crc_skip_count,
+ * avoiding the later DC CRC read path.
+ */
+static void dm_test_crtc_handle_crc_irq_skips_initial_frames(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_crtc_state *dm_state;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	dm_state->stream = dm_kunit_alloc_stream(test, NULL);
+	acrtc->base.state = &dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_CRTC;
+
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+	KUNIT_EXPECT_EQ(test, dm_state->crc_skip_count, 1);
+
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+	KUNIT_EXPECT_EQ(test, dm_state->crc_skip_count, 2);
+}
+
+/**
+ * dm_test_crtc_handle_crc_irq_dprx_after_skip() - Test DPRX post-skip exit.
+ * @test: KUnit test context.
+ *
+ * Verifies that enabled non-CRTC CRC sources do not call into DC CRC reads
+ * after the initial skip window.
+ */
+static void dm_test_crtc_handle_crc_irq_dprx_after_skip(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	fixture->dm_state->crc_skip_count = 2;
+	acrtc->base.state = &fixture->dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_DPRX;
+	dm_test_crc_dc_ctx = fixture;
+
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_FALSE(test, fixture->get_crc_called);
+	KUNIT_EXPECT_EQ(test, fixture->dm_state->crc_skip_count, 2);
+}
+
+/**
+ * dm_test_crtc_handle_crc_irq_get_crc_fails() - Test failed DC CRC read.
+ * @test: KUnit test context.
+ *
+ * Verifies that the IRQ handler exits after dc_stream_get_crc() returns false,
+ * before attempting to deliver a DRM CRC entry.
+ */
+static void dm_test_crtc_handle_crc_irq_get_crc_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	fixture->dm_state->crc_skip_count = 2;
+	fixture->get_crc_return = false;
+	acrtc->base.state = &fixture->dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_CRTC;
+	dm_test_crc_dc_ctx = fixture;
+
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_TRUE(test, fixture->get_crc_called);
+	KUNIT_EXPECT_EQ(test, fixture->dm_state->crc_skip_count, 2);
+}
+
 /**
  * dm_test_need_dp_aux() - Test dm_need_dp_aux().
  * @test: KUnit test context.
@@ -818,6 +944,12 @@ static struct kunit_case dm_crc_test_cases[] = {
 	KUNIT_CASE(dm_test_crtc_set_crc_source_none_no_stream),
 	KUNIT_CASE(dm_test_crtc_set_crc_source_none_commit),
 	KUNIT_CASE(dm_test_crtc_set_crc_source_dprx_no_connector),
+	/* amdgpu_dm_crtc_handle_crc_irq() */
+	KUNIT_CASE(dm_test_crtc_handle_crc_irq_early_returns),
+	KUNIT_CASE(dm_test_crtc_handle_crc_irq_disabled_source),
+	KUNIT_CASE(dm_test_crtc_handle_crc_irq_skips_initial_frames),
+	KUNIT_CASE(dm_test_crtc_handle_crc_irq_dprx_after_skip),
+	KUNIT_CASE(dm_test_crtc_handle_crc_irq_get_crc_fails),
 	/* dm_need_dp_aux() */
 	KUNIT_CASE(dm_test_need_dp_aux),
 	/* dm_crc_source_should_start_dprx() */
-- 
2.43.0

