Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2935AC5DF8F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838BE10ECC2;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsOKJjR1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C89F10E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6off4GTAuo4P0yi3GQOtho/bH/k+bNHW1NSClDIGq6JC2oRBmkUipgbFMvZMb/3LuPewaqLyae1+iJFxDc062JBVQIXNFyinm2/WSgH2T3CDDxQ5Sb34d82aKwu6HpauZVTG9IbSfxgXecoXhRE7E5ZDVkA+awtkk+auSj25VaxVOak3lH1DGeCGGaiU5uE5wkK6ocwyZz3MyjVdB0GEY0jmhspayk56pH+69MAGfONDwwD2rL2edYN6Uodcs8tYNVvtbFngSO2u9uzAcJSvF+zTy2fffyp4/l/QqHPKS6PnbY1MoE/Yt4N+66Pf7lxfjGEZH/YCUYKVz1ZRDZrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWvXa+9Gw9I309wLg/8qVpNTW+r1TVh0hT5RSi+8rAU=;
 b=DGNeoOhE1ui6UKfzDSwKa4KdQXHOtTTvUZi0azdFXUFzc9CUWJKL8IfPrMXIKuhk9bnlvkCsNXNqKgA+sA1izKWeQ2QooaT2XZy28KbfbTLDUJRQoMZXd1ENOLE90PiymIoTOKMcbdTfXfZGPeJTGru8zqnD+O/gSbLgFsGFLPDsUeB+jwSmdkakXt6mPN2UDTD6fiuZRS487MMSacRiCQ2Hl3GAsa7OOV/9LpwWKZA3K53kpZ2VcHV095DCJ43WlKKisNRbYEStOEsOBR6Y0jjftXKl2kKsm0lhA1QQknY3+rO0KTrllkkQ52iNPuw7dxhMLYkEekNOWtBAB0aE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWvXa+9Gw9I309wLg/8qVpNTW+r1TVh0hT5RSi+8rAU=;
 b=fsOKJjR11lvcLhuQ0TixIdo5t+j1/TeYOJqtJAI5jhgF0OWW7su0Y+lGMIv7dkXG1tQFY7MW6JMT3bnb6dxbzDdv0p3TxOksaA97/+16YHejnvNPrs2R0PQZcsr9iXYHmTIgYv1vxV0evuEehxJSSZrSJT+PaKMctF+rUhtpn0Q=
Received: from BL1P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::30)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:45 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::2e) by BL1P221CA0018.outlook.office365.com
 (2603:10b6:208:2c5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:40 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:40 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 64/82] drm/amd/display: Test schedule_dc_vmin_vmax
Date: Tue, 18 Aug 2026 16:15:56 -0400
Message-ID: <20260818202139.4172592-65-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e4136b-e0ad-465a-cc1b-08defd667702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|6133799003|56012099006|10067099003|5023799004|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: q1YmmRa12P/JrmKMt3G+kLwsSZxu55DV6TcN868r+FN5ydGOnCeL2bo9ceQlYv5NpfZmtwgbszP+LdBRXulbM7qeL+n2AIB8ivLoGGUuO8Eut4D+jrRE23vwvsTpuC+fuKNuseXED6jGd+Nk6SDr3sYomfqtAPxgwRHn2SPSkprBb9ju/CyIxvQVaWaYd+61xhcKPnoOt5AWJBbrsRckl4LRVJm+ance9qHP2bN71v39PTI6JOUpNPaM9fFd+KfmHUed2kEkUcNnYlGy2bM0BS+jlFUxbhi5DvdOr8Lnsm3azXSrQfMsUn+xo1hHnqaKHmKc/a01nUYWxQnqDDCGzwOAo+00DZEUyeHES6i8LMBPdwW2jHbRAHwEL7DA+HghCA2snPP/U7fNEYBwdSbxn9UHTDZrI+qGtLOKC7qsdG3t8py1R23h7cGhvAQgbpOQhvEkt3HZNKrY4Q2+GS7oDDCcajERcI+D8KE2jM7ISzNy3a1j4MF3ypEoRKUtRh/ZYo82N56KPXNZuD+rly/A4eRmyvycCVIKe4P5ZmunqATAQj6VWq7ZulNOHr/2fmhwuWXSX8gsSRPKddzcZBLr0dGxJw2+xCShS5phM+n0P3UvH/XLZejchzC+jotDF4txTLvnrhKSyTcRqYb4+5kb0+B8Ft2jXLyAWmug4hubp9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M61lrWnVFZrqxXec2ap5YRnSHZJ0z4TQkC9VxTJ54EQiy2q+K1ru+IeljKZGxpqeIK5dK/Z70vgzxt07gRCRNEM7YEX/xMn1XKe7xa2zYemdAH0PBbMjo8NJrxgkg4hVvg848vVwsKUq6W64xj+DiJIEEbaApqEB0CbDJ3Rk0OdD53CN/dR2Cfai53W5dpsRhnJE/rzicqjdJ96UQ7hFrRGmYNs0Tkw8UG+qhskAvRJt6ry4QyzJSpocv0IqM9bGfZIoAnuGEF7dvr8Eo9L9HchuR3scSCv1eibRtFKXIndsdYav5SRm6qNGTo7L2DGp8ZyyeFqoo98fdIKrYfdAgHTfshiQoyuW3OmZ9LAPkowRgO4qLBCcJ1fTbFajfdEAHbAV6Q9HCjdL3rMp6cG0KfeQLHfi9E6gDDZIp8spMG+JCuUxWaaTIsZlQuhghSo5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:45.7914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e4136b-e0ad-465a-cc1b-08defd667702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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
Add KUnit tests for schedule_dc_vmin_vmax(), which had no coverage. Both
callers are exercised: dm_crtc_high_irq() on an AI+ family and the DCE
path of dm_vupdate_high_irq() on a pre-DCE12 family.

[HOW]
Add a dm_test_setup_vmin_vmax_crtc() fixture building a CRTC with an
active VRR stream and a vmin/vmax work queue. Each test flushes the
queue and checks the worker applied the adjust and dropped its stream
reference.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 4cb52093987f3..b398be878c932 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -3450,6 +3450,83 @@ static void dm_test_vupdate_high_irq_dcn_no_active_planes(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
 }
 
+/*
+ * Build a CRTC with an active VRR stream on a device whose vmin/vmax updates
+ * are offloaded to adev->dm.vmin_vmax_wq, seeded with the given timing adjust.
+ * Caller sets adev->family to select the DCE or DCN path, then invokes the
+ * handler and flushes the queue.
+ */
+static struct amdgpu_crtc *dm_test_setup_vmin_vmax_crtc(struct kunit *test,
+							unsigned int v_total_min,
+							unsigned int v_total_max)
+{
+	struct dc_stream_state *stream;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	dc->current_state = kunit_kzalloc(test, sizeof(*dc->current_state),
+					  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc->current_state);
+	adev->dm.dc = dc;
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	acrtc = dm_test_add_crtc(test, adev);
+	/* VRR active so the !vrr_active vblank handler is skipped. */
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+	acrtc->dm_irq_params.stream = stream;
+	acrtc->dm_irq_params.vrr_params.adjust.v_total_min = v_total_min;
+	acrtc->dm_irq_params.vrr_params.adjust.v_total_max = v_total_max;
+
+	return acrtc;
+}
+
+/**
+ * dm_test_vupdate_high_irq_dce_vrr_btr - Test DCE vupdate BTR handling
+ * @test: The KUnit test context
+ *
+ * On DCE (zero DCE IP version) with VRR active and a pre-DCE12 family, vupdate
+ * runs the below-the-range section: it handles the vblank and offloads the
+ * vmin/vmax update, which the worker then applies to the stream.
+ */
+static void dm_test_vupdate_high_irq_dce_vrr_btr(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct dc_stream_state *stream;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = dm_test_setup_vmin_vmax_crtc(test, 2000, 2200);
+	adev = drm_to_adev(acrtc->base.dev);
+	stream = acrtc->dm_irq_params.stream;
+	/* Pre-AI family so the BTR block inside the DCE path runs. */
+	adev->family = AMDGPU_FAMILY_SI;
+
+	adev->ddev.vblank[0].time = ktime_get();
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VUPDATE;
+
+	dm_vupdate_high_irq(&params);
+
+	/* The offloaded worker applies the adjust and drops its stream ref. */
+	flush_workqueue(adev->dm.vmin_vmax_wq);
+	KUNIT_EXPECT_EQ(test, stream->adjust.v_total_min, 2000);
+	KUNIT_EXPECT_EQ(test, stream->adjust.v_total_max, 2200);
+	KUNIT_EXPECT_EQ(test, kref_read(&stream->refcount), 1);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 /**
  * dm_test_crtc_high_irq_no_crtc - Test crtc high IRQ with no CRTC
  * @test: The KUnit test context
@@ -3619,6 +3696,41 @@ static void dm_test_crtc_high_irq_writeback_completes(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, acrtc->wb_frame_done);
 }
 
+/**
+ * dm_test_crtc_high_irq_schedules_vmin_vmax - Test the freesync BTR update
+ * @test: The KUnit test context
+ *
+ * On an AI+ family with an active VRR stream, the handler must run the freesync
+ * v-update and offload the vmin/vmax programming, which the worker then applies
+ * to the stream.
+ */
+static void dm_test_crtc_high_irq_schedules_vmin_vmax(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct dc_stream_state *stream;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = dm_test_setup_vmin_vmax_crtc(test, 1000, 1100);
+	adev = drm_to_adev(acrtc->base.dev);
+	stream = acrtc->dm_irq_params.stream;
+	adev->family = AMDGPU_FAMILY_AI;
+	acrtc->dm_irq_params.vrr_params.supported = true;
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VBLANK;
+
+	dm_crtc_high_irq(&params);
+
+	/* The offloaded worker applies the adjust and drops its stream ref. */
+	flush_workqueue(adev->dm.vmin_vmax_wq);
+	KUNIT_EXPECT_EQ(test, stream->adjust.v_total_min, 1000);
+	KUNIT_EXPECT_EQ(test, stream->adjust.v_total_max, 1100);
+	KUNIT_EXPECT_EQ(test, kref_read(&stream->refcount), 1);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 /* Tests for dm_handle_hpd_work() */
 
 /**
@@ -4246,11 +4358,13 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_vupdate_high_irq_no_crtc),
 	KUNIT_CASE(dm_test_vupdate_high_irq_dcn_completes_flip),
 	KUNIT_CASE(dm_test_vupdate_high_irq_dcn_no_active_planes),
+	KUNIT_CASE(dm_test_vupdate_high_irq_dce_vrr_btr),
 	KUNIT_CASE(dm_test_crtc_high_irq_no_crtc),
 	KUNIT_CASE(dm_test_crtc_high_irq_vrr_pre_ai),
 	KUNIT_CASE(dm_test_crtc_high_irq_vrr_ai_no_stream),
 	KUNIT_CASE(dm_test_crtc_high_irq_writeback_disables),
 	KUNIT_CASE(dm_test_crtc_high_irq_writeback_completes),
+	KUNIT_CASE(dm_test_crtc_high_irq_schedules_vmin_vmax),
 	/* dm_handle_hpd_work */
 	KUNIT_CASE(dm_test_handle_hpd_work_out_of_range),
 	/* dm_dmub_outbox1_low_irq */
-- 
2.43.0

