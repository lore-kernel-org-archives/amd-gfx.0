Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BDBC5DF88
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0598A10ECC0;
	Tue, 18 Aug 2026 20:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5JYLVCE5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1933A10ECC0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEZPyvTdpfHYC/FCTd0m6GGK8MgX5yueY+AaK5DVnA3T+xuSSAK99fRl4322S1md/bliXk/gb8BJZDjxe1kkLESb3LpcANKT3c+BQh2cdBOVTT0J9ZYzO0dazoW9d/4XvHh0mbxgjIoknbxJ6OwRtQ6pesVhGcL5wfk/eBqZd8gb2vvZOyLGejbqD0rug3/K9Xvjx8ab3Mi1mI6oUQ+1jDll3XvSlKGK5NxwYkcCAquSaH7Yaqmd+Y8lYIgwWRtQK1ccOxtEBa4aH+aKgHg/XxdcVZybyDDTIukBOHlTgxfHITuZ5pOoZkPyqyOFE1RPcR4Hr+QErAMRPLJB/aLbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9cJXqDplEXf/y7ROtLyH+sIppbPrX/+dlTSPTHHGOs=;
 b=V/EthC3G3t//bmcy0JiiFPyG2DAo6uhU3HPwF32WI341yM5PYqBCyC8owqPA7TVjVb+7NF6sPJWKeOk2fgehVVbjiIvmmDe29Q0fqNUhI6MUBZGcqv+OFyNGglnbuuTP1AWHl1Fm7N50mGC6dKHzYgajf7n+oZ9+RmMSiMbBkUM1SqETbBzqc6btCfWbRPbNNJ3qvuWVH1IiJqU8f7ZcSSi/hg3MHwGuInesR+ma0ThC4fEDmSinLVO1r4i7/Lv9t0NDoFMtVC8jXrfJq3aBsgpZjTHHIJIct7PD0Isd8wo51iPoaGDqG92vxOaZsx+Qe4dKdTWgqR7ac5ryTV+C4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9cJXqDplEXf/y7ROtLyH+sIppbPrX/+dlTSPTHHGOs=;
 b=5JYLVCE5lkQCUE3FzkNblcH50ZIx6hVAFdlKjexJf4UVFlVKoy0UgrBTSkMtFYGfywD8xXyIEqzz23iKVxbpmJmVJ7g2B7bFyzOBarkW2GvQLMQKsZiXw3K4Ghv9dx1cXT4JbQZUGSay+TAWUcb6ld6yfokgs+ecvZ0tTLB0MVQ=
Received: from BL1P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::35)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:44 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::3b) by BL1P221CA0017.outlook.office365.com
 (2603:10b6:208:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:38 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:37 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 62/82] drm/amd/display: Test pageflip completion in the high
 IRQ handlers
Date: Tue, 18 Aug 2026 16:15:54 -0400
Message-ID: <20260818202139.4172592-63-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: acfa9d30-485c-4350-c450-08defd66764a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x+VVPFLQmBMLg1CLGKqSlL+Mqr6X/3k1DzQYIOVAxudv0u8mkXZsvw4MSOUd5NWmPJrG4VTFzuQSICWsO/MTRwFVR7zHsJ8O0BvALY83jVq7uK+qx557707P43IDpbWE4J7eaB4NbohSXjC1KJlvBKkgpZBQg5k/NLtm5g/IlodM1sooqlO3PKOTj9CGHOrwea/kiSyH2atU76rscc6nL2BBr8CKfXoMkl+nio2pBZkc3Xm4jt0FamA3jUG42ScT9l+QO7ecLAbZAue1UnE660tXSDirBv+XecLlniligFhsg5m9I1hEqfR0iA2DPw7asLM/Ch5DGvJ9/o+WqyYfpRmkiUdHyCMuZN3OblHF+pXYzDZLmCm/fFSXR0MZRg7+s2lkNv/qLpExp8BIA2vyEreAtU7CsrPm3S/ODKPW9rW0FdTOPOZLuqsdkywOKc6JgmQfnVufcyF380lKR+feVzAEy/hHbcP9mU8zm07ngBkFaR83Ts4KeT546KJ23lC7XpUe0nIRZ45tN7zhbtlVPH5KeQPgwB9yA0x9lxzoiSe4eN6m3OEGB+wk9ABf/aqaJGPmRyZLfzcapJLZWJujtk/XijXFO7jCx7hiJ/8ral3XLMC3P1TSrWRPOitY8BpCJPdUPxaNS/2bXT+slK+EgJNTYZ0PwXCAl3SmwcEiRr4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bNDkrpkwZdAgMHqF/ITYHhUbAiar2Qusow8g3a73fr8spQoFgP/Or4bnTEmRI6hF/MuZ/NgMbiIA4PlvQapBWe8yUAWsa60cGHqSn5TqUN+TsBjBMxT2E0H1t7Dd8zAII0DtZlzUFEE3INSYWax37qYiGkmK5xq7U+tnBq0oZb+6QPAxdiQEgd8+sI+iW1d1BjtTtvQttfI1CXnFT2lxUoL2rXgP3rrgqN8xu+kp8Vx1sApLAaWP6KQR6orTZjh8AVm7Aho8+prDBcPVf8OJkIsiyBn3r6TCvS7Fw13AP2poqyxtGqgrpHiOzFny+Vc5UKfBHsVqzGZlDCTmxD9XS/6qSbVFfLE+UuNvBWXkgqQA76WHZIx93LKjxlmKP0IjGSObkJm+cNKccQaRKjh7XSCo67xAa93V63Axm9XLOKhaszoO08IAGKJLc9lTicfF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:44.5864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfa9d30-485c-4350-c450-08defd66764a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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
Add KUnit tests for pageflip completion: the non-VRR path in
dm_pflip_high_irq(), and the DCN VUPDATE_NO_LOCK paths in
dm_vupdate_high_irq() that deliver the event once the OTG reports no
flip pending, or retire the flip when there are no active planes.

[HOW]
Initialise DRM vblank and hold a reference to balance the handler's
drm_crtc_vblank_put(). A non-zero DCE IP version selects the DCN path,
and a NULL adev->dm.dc makes dc_get_flip_pending_on_otg() report no
pending flip.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index fbe37bb0a39d6..0bf46e856f5a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -9,6 +9,7 @@
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "dc.h"
 #include "inc/core_types.h"
@@ -3318,6 +3319,45 @@ static void dm_test_pflip_high_irq_not_submitted(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
 }
 
+/**
+ * dm_test_pflip_high_irq_completes_flip - Test pflip high IRQ completes a flip
+ * @test: The KUnit test context
+ *
+ * With a submitted flip and an armed event on a non-VRR CRTC, the handler must
+ * send the pageflip completion event, drop the vblank reference taken when the
+ * flip was queued and return the CRTC to AMDGPU_FLIP_NONE.
+ */
+static void dm_test_pflip_high_irq_completes_flip(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	acrtc = dm_test_add_crtc(test, adev);
+	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
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
 /**
  * dm_test_vupdate_high_irq_no_crtc - Test vupdate high IRQ with no CRTC
  * @test: The KUnit test context
@@ -3334,6 +3374,81 @@ static void dm_test_vupdate_high_irq_no_crtc(struct kunit *test)
 	dm_vupdate_high_irq(&params);
 }
 
+/**
+ * dm_test_vupdate_high_irq_dcn_completes_flip - Test DCN vupdate flip delivery
+ * @test: The KUnit test context
+ *
+ * A non-zero DCE IP version routes vupdate to the shared CRTC handler. With a
+ * submitted flip, an armed event and no DC (so no flip is reported pending),
+ * the handler must deliver the event and clear the flip state. A non-zero last
+ * vblank timestamp also exercises the refresh-rate tracepoint.
+ */
+static void dm_test_vupdate_high_irq_dcn_completes_flip(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 0, 0);
+	/* AI+ family so the handler does not return before the flip block. */
+	adev->family = AMDGPU_FAMILY_AI;
+
+	acrtc = dm_test_add_crtc(test, adev);
+	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
+
+	event = kzalloc_obj(*event, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	acrtc->event = event;
+
+	adev->ddev.vblank[0].time = ktime_get();
+	adev->ddev.vblank[0].enabled = true;
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(&acrtc->base), 0);
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VUPDATE;
+
+	dm_vupdate_high_irq(&params);
+
+	KUNIT_EXPECT_NULL(test, acrtc->event);
+	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
+}
+
+/**
+ * dm_test_vupdate_high_irq_dcn_no_active_planes - Test DCN flip with no planes
+ * @test: The KUnit test context
+ *
+ * With no active planes the DCN HUBP may be clock-gated and the flip-pending
+ * status is undefined, so a submitted flip with no armed event must simply be
+ * retired rather than waiting on the OTG.
+ */
+static void dm_test_vupdate_high_irq_dcn_no_active_planes(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 0, 0);
+	adev->family = AMDGPU_FAMILY_AI;
+
+	acrtc = dm_test_add_crtc(test, adev);
+	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
+	acrtc->dm_irq_params.active_planes = 0;
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VUPDATE;
+
+	dm_vupdate_high_irq(&params);
+
+	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
+}
+
 /**
  * dm_test_crtc_high_irq_no_crtc - Test crtc high IRQ with no CRTC
  * @test: The KUnit test context
@@ -4032,7 +4147,10 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* pflip/vupdate/crtc high IRQ callbacks */
 	KUNIT_CASE(dm_test_pflip_high_irq_no_crtc),
 	KUNIT_CASE(dm_test_pflip_high_irq_not_submitted),
+	KUNIT_CASE(dm_test_pflip_high_irq_completes_flip),
 	KUNIT_CASE(dm_test_vupdate_high_irq_no_crtc),
+	KUNIT_CASE(dm_test_vupdate_high_irq_dcn_completes_flip),
+	KUNIT_CASE(dm_test_vupdate_high_irq_dcn_no_active_planes),
 	KUNIT_CASE(dm_test_crtc_high_irq_no_crtc),
 	KUNIT_CASE(dm_test_crtc_high_irq_vrr_pre_ai),
 	KUNIT_CASE(dm_test_crtc_high_irq_vrr_ai_no_stream),
-- 
2.43.0

