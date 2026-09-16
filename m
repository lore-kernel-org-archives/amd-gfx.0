Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222D2C982D2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0029B10ECB9;
	Wed, 16 Sep 2026 17:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gIB+BfrN";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF35910EC90
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vmw6+Bi45k8Dsaikw6cg1Y3U0XKvnmc2KE9BjXtsHbsrFwJaNWgINVDxwCRzxIJnLQCK3angBdd2E33/yHzhBM2FtiIWNWqJDLQXt3GMnMSa/XR4sPUD+00bpHYMNxCWlsTZavNgjplHC0B9BWIIysxr48waezFFk7FhoY11VvNnpYTEJ0g1+8np38poXP90zEJXYXo7iboVGOiXhPP667jmW89kghFeu2MqNRy45+ne4i7PlU14FpoRZzF2xyO9VWrEivESWTaZxLYM+MQlt010QzpI+4Tbco28mUkG7upjIhryrEDNh7bqqFzcICzBgZWO4sxtQcz5lxzCObA9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDAgpaHv8qe1V/j9u/Uz+7ax/KW7TEVaXZud2b/28mw=;
 b=f7hTqEwqVB7lyZFXVXF5y5vZ+ZzvCiEUwXNOvxLoFak7JXQRDnmifau+qThILxguaZ8RhoHSwbN9VtVxGdexUZIdQIvkCsVMMyxB9I1YfSkgVcTWSuDNNxGIZySj8DOIhgXcRGb8vd2DBvdkS2GaAOqgvd51CorAnKp/GErelcaqtAqd66/DEjr0laRkcifOcr/6caFLYY8913eVUNwriGYYE4WZ3dBO3rOf1uio+/zGKQmZZGUYLUPokAHs7o4TflFDzslA1NN7WCuAgNst6ADVQ4420bSTwerNmO0BlvMOPW2en/RKp11/tUVnTDzQsRlQnTXL8msa98/jroBzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDAgpaHv8qe1V/j9u/Uz+7ax/KW7TEVaXZud2b/28mw=;
 b=gIB+BfrN9lF9i9kN9jgad8tLCQofXnF3AdibbobMYlViX4jJXVl1hrPQWtF3WWUYgvN9GKAIsEf38jHlAPlt8cPJ6zdtupZ3D24oui1hGDC8OnRgRVXNImL9YNaspTySgIZ93T+mfsUcU21QGWvEAN08KSxoym5Nt4fwLOnmTT0=
Received: from CH0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:610:e4::27)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::988) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:52:53 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::8d) by CH0PR03CA0202.outlook.office365.com
 (2603:10b6:610:e4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:52 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:38 -0500
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
Subject: [PATCH 32/64] drm/amd/display: Test VRR pageflip completion
Date: Wed, 16 Sep 2026 13:51:47 -0400
Message-ID: <20260916175301.368306-33-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: b37e337f-38d1-47e8-667f-08df141b54ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KzhFe7UfoBZ3hDzl/r6ET/jfkm3BTvF3xE2n7T3RFvkZjTzBFz1pIXbf7Sl20OFToL+5KGNhGkcBJyZ/qbAa2tQBwXjNql8lVQn7sST8C5+Nzjyp6kSOBOGLoy8yHf+jG3crvfCAFhRruCNhswk+P7uzbkCICXwRSevtqMUUC89xy2H5baNM73YhOdqKII5fcgzH39uS1osUnYlufc83POZKXSLKH3cY848fM2uJ0Ui/vhQYnYMpfHP1D1tJ1RUQ4CbEDj4iaLql3YLlM8PgWRAundlwUSIOa8l1EDEDSMYK89Sx0xrA7wJWG8GM0IGmJSqEWz0HxOPS4CqR+9BdWpPLmCUNXVUXwXeVN9us5AlRUlUywkpaMXzMtKCEIiVwUA4WeLF1LLWhjbcJxMu+11WjsqyyA7YCljufMqMnvDgRt+A2/aD6lsavw8AksXQRy0zx399Z4szZMZ0pY8c9f55NFi0KBR/9KAp5DWL7vc9a2bTQTg8TmRJ3LgG/WryaWtX4efHe5vdqe4f3R3TV6UCDBQbIZxpLCFPOFDcBsGL35EtTKqDmGhdC18rVfgBYcUgj+7wL7aKjx8XsW68ys7sD8pvF/uwzSBVggMUW3btjqa/rcphiNlX6iXYYPiwohCT21+yMBx3Ufn9oAiGcu/KMGZzbm5ALUQtfxQmCIDCAFiyFuhu38bwqhUSZe89wcq3mVUJPmEey0MOLANnGzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ywjZ2ag/8b72D5K8sQf6UYcTPhrDH7vKr16NtO3DILwHR+HMkKVSBG+/WvMwOSrivEYjTYRCR2lMNJCy0xlvAqPFuiyiGTSswqcd4fW/gq+wbNoB06jInTWSWX4Ke/pRgOpYKyikD+sujgcGmtdZHTuOPGCHFvsB684WDAHNGjhcvsCT0qN0m78DcCYDSi2D+h7D+9IykagcHZvzKK9WSHdJ4gfIdyOmlnM9f2btCY8y8E860J1ur74gkVT6pFTznqm2x3FgWH0f0LAkNz25DcHWZnX9lpI3NUkJHu5UxcEMQPDCAAOb+mCCpxufID3yeIFcArgxKWYMDqgxR6rl66Di5rZl9daYUBl0hAoJdVTvd5FEi+wHdypbvh4xgMCBM0tgC85RPNTkhrU7ra7V4tiZqi5fEbtfKIpwV2X+bYFsNE9XzU/XGadNuKxGotuN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:52.8822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e337f-38d1-47e8-667f-08df141b54ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B
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
dm_pflip_high_irq() only ever ran with VRR inactive, so the
scanout position query and the front-porch path that queues the
pageflip event on the vblank event list were never reached.

[HOW]
Add a fake timing generator reporting a scanout position past the
start of the front porch, plus a fixture that puts a submitted flip on
an active-VRR stream.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 28b1eeefb8ec..6299e1fd2fcc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -14,6 +14,7 @@
 
 #include "dc.h"
 #include "inc/core_types.h"
+#include "inc/hw/timing_generator.h"
 #include "irq/irq_service.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
@@ -214,6 +215,23 @@ static bool dm_test_allow_hpd_rx_irq_true(const struct dc_link *link)
 	return true;
 }
 
+/* Report a scanout position past the start of the front porch. */
+static void dm_test_tg_get_scanoutpos(struct timing_generator *tg,
+				      uint32_t *v_blank_start,
+				      uint32_t *v_blank_end,
+				      uint32_t *h_position,
+				      uint32_t *v_position)
+{
+	*v_blank_start = 100;
+	*v_blank_end = 110;
+	*h_position = 0;
+	*v_position = 200;
+}
+
+static const struct timing_generator_funcs dm_test_tg_funcs = {
+	.get_scanoutpos = dm_test_tg_get_scanoutpos,
+};
+
 
 static uint32_t dm_test_dmub_get_outbox0_wptr(struct dmub_srv *dmub)
 {
@@ -3658,6 +3676,124 @@ static void dm_test_pflip_high_irq_completes_flip(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
 }
 
+/*
+ * Build a CRTC with a submitted flip on an active-VRR stream whose scanout
+ * position comes from the given fake timing generator (NULL for a stream that
+ * is not on any pipe, so the position is unavailable).
+ */
+static struct amdgpu_crtc *dm_test_setup_vrr_pflip_crtc(struct kunit *test,
+							struct timing_generator *tg)
+{
+	struct dc_stream_state *stream;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	dc->current_state = kunit_kzalloc(test, sizeof(*dc->current_state),
+					  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc->current_state);
+	adev->dm.dc = dc;
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+	stream->ctx = dc->ctx;
+
+	if (tg) {
+		dc->current_state->res_ctx.pipe_ctx[0].stream = stream;
+		dc->current_state->res_ctx.pipe_ctx[0].stream_res.tg = tg;
+	}
+
+	acrtc = dm_test_add_crtc(test, adev);
+	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
+	acrtc->dm_irq_params.stream = stream;
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	return acrtc;
+}
+
+/**
+ * dm_test_pflip_high_irq_vrr_no_scanoutpos - Test VRR flip with no scanout data
+ * @test: The KUnit test context
+ *
+ * When the stream is not on any pipe the scanout position is unavailable, so
+ * the handler cannot tell it is inside the front porch and completes the flip
+ * immediately.
+ */
+static void dm_test_pflip_high_irq_vrr_no_scanoutpos(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = dm_test_setup_vrr_pflip_crtc(test, NULL);
+	adev = drm_to_adev(acrtc->base.dev);
+
+	/* drm_crtc_send_vblank_event() consumes (kfree()s) the event. */
+	event = kzalloc_obj(*event, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	acrtc->event = event;
+
+	/* Balance the handler's drm_crtc_vblank_put(). */
+	adev->ddev.vblank[0].enabled = true;
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(&acrtc->base), 0);
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_PFLIP;
+
+	dm_pflip_high_irq(&params);
+
+	KUNIT_EXPECT_NULL(test, acrtc->event);
+	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
+}
+
+/**
+ * dm_test_pflip_high_irq_vrr_front_porch - Test VRR flip inside the front porch
+ * @test: The KUnit test context
+ *
+ * A VRR flip that completes while scanout is still in the front porch has no
+ * valid vblank count yet, so the event is queued on the device's vblank event
+ * list for the late vblank handler to send out instead.
+ */
+static void dm_test_pflip_high_irq_vrr_front_porch(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct common_irq_params params = { 0 };
+	struct timing_generator *tg;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg);
+	tg->funcs = &dm_test_tg_funcs;
+
+	acrtc = dm_test_setup_vrr_pflip_crtc(test, tg);
+	adev = drm_to_adev(acrtc->base.dev);
+
+	event = kzalloc_obj(*event, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	acrtc->event = event;
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_PFLIP;
+
+	dm_pflip_high_irq(&params);
+
+	KUNIT_EXPECT_NULL(test, acrtc->event);
+	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
+	KUNIT_ASSERT_PTR_EQ(test, adev->ddev.vblank_event_list.next,
+			    &event->base.link);
+
+	/* The event was queued rather than sent, so the test owns it. */
+	list_del(&event->base.link);
+	kfree(event);
+}
+
 /**
  * dm_test_vupdate_high_irq_no_crtc - Test vupdate high IRQ with no CRTC
  * @test: The KUnit test context
@@ -4981,6 +5117,8 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_pflip_high_irq_no_crtc),
 	KUNIT_CASE(dm_test_pflip_high_irq_not_submitted),
 	KUNIT_CASE(dm_test_pflip_high_irq_completes_flip),
+	KUNIT_CASE(dm_test_pflip_high_irq_vrr_no_scanoutpos),
+	KUNIT_CASE(dm_test_pflip_high_irq_vrr_front_porch),
 	KUNIT_CASE(dm_test_vupdate_high_irq_no_crtc),
 	KUNIT_CASE(dm_test_vupdate_high_irq_dcn_completes_flip),
 	KUNIT_CASE(dm_test_vupdate_high_irq_dcn_no_active_planes),
-- 
2.55.0

