Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D5C43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 10:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F130E208C3
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 10:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vr9HFg5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F130E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584256E139;
	Fri, 18 Sep 2020 10:13:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50A16E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 10:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/+p56uOZpv8xT65u2+Ad3hCNHoN38jYOgcet8EU+plgLF5nV9dE8Fgo5Y652V3XksYwB0HvG+mSY4W7IncOIQxiSqlcklxiKQTI2EDEjj4/5uc0YI/6QC+WwkpwWKDm2l98xnnWtHU5xdAQ4Pk/jZJUDvETqg7mpbHD1/8VcDhBVfAXJZmFwazHN2+B0dVq9WYCve3lJic5uTp5jGBULtwPlxd+IIxvjaaAK51TEv7xBRNCPVHfEH8kufRFL+AqGWcjjX7+gtgrH4FfIJYWFx0looRU+nr2xx5pr/v9ZAIaVOqCJLYLhEb4JO37nfMhJ436I4Jy7QD/priQ0xA0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7If6jKBdVc2soKPqoQ4VPVx00vVGPUGJHIlrZwW6vI=;
 b=Py9o1zWEyx3GeS36xmVuu2SO8hpUlY7lNsDJqcQ4/Q+w6A/TGlrGBCQDn3Ha0hX7Csb+On32nNi0QgE0hRIuQa1HLtln0mKJsWZQo+pMQ2FVh1sAYD5f4ewTbVum8FHcUJCYcgKuUAewK659zZafTtGnEBSvZVcp9d7IqR0kSM2O1C5MhTdeIXseB2nOIc3uom1JOoJVTcXvwxF5i0mZQWhw2U/9uBbrd/d+REACD+yX15ANXSFpPU1t3wFT5wsb7HtYtYQvHlX3KK/HPoVCuR0CfJkree8sjxRueKxuaIKrHAXZzd3t5WEwMokPGH+JGT7ObuZeZvI3ZMtZmEy77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7If6jKBdVc2soKPqoQ4VPVx00vVGPUGJHIlrZwW6vI=;
 b=vr9HFg5sKK6yRxl/B27dt2ClOR3GRfsa+2LuG4bCa5OxSbVajFdjWsVb+QCddpFB0GYPyPamx4/lv6ldX9bmgoSqqMUY4gHdumqLaB5VyxP5vil+Gowvlr0/aLuhmzBC+Zl0D/KxjeD7dql6RgJaNN8mZMemvIim6ty80moXPJI=
Received: from BN8PR15CA0025.namprd15.prod.outlook.com (2603:10b6:408:c0::38)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 10:13:37 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::be) by BN8PR15CA0025.outlook.office365.com
 (2603:10b6:408:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Fri, 18 Sep 2020 10:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 10:13:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Sep
 2020 05:13:36 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Sep
 2020 05:13:35 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Sep 2020 05:13:35 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Date: Fri, 18 Sep 2020 18:13:27 +0800
Message-ID: <20200918101327.986586-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a141af65-e389-4554-db1f-08d85bbb81b7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25838C263E88BBDD4AEAF7C78F3F0@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gy7H+K/0c1Th6ut2w4XyroxOk+ocJZg5+U+DLAz4s7wFOMbqwqdr7dxbhOiTEKoCAWJyXAdq0BZv1hOlEJqQ34epnzYE/ctekVTFwqtVMDPuFoPsZtRqnRkFytXFfmqUKpjq2MCHjAkbSiJa2Ony+bdbGhquaxKK8Ykfce3TK2kA6iBdQC9uRATBC8BlQWr8UFvTiMn6xi4d8nux4qvSqWZFgBQwToSvRtKltcqBmy9gqo4WyUBuDMDiL/DtcQpif/BPAgI+VgHwv16wkDvqg/DYu1eR2M6PhXoNvTOn1AdLk0/h0pBUJfCwsXKNz02PiiyaDbEDcRxyd1HbJKM6y3IkwLpghiP+S0loH83TPU5YotsdMZEVwOQjigzxp1kGPX+PIE4q76gNMMnBLVghVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966005)(8936002)(186003)(5660300002)(7696005)(70586007)(1076003)(478600001)(316002)(86362001)(70206006)(81166007)(356005)(36756003)(4326008)(2906002)(26005)(82310400003)(8676002)(83380400001)(426003)(336012)(6916009)(2616005)(47076004)(6666004)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 10:13:36.5807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a141af65-e389-4554-db1f-08d85bbb81b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always start vblank timer, but only calls vblank function
when vblank is enabled.

This is used to fix the dead lock issue.
When drm_crtc_vblank_off want to disable vblank,
it first get event_lock, and then call hrtimer_cancel,
but hrtimer_cancel want to wait timer handler function finished.
Timer handler also want to aquire event_lock in drm_handle_vblank.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I7d3cfb1202cd030fdcdec3e7483fcc4c9fa8db70
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 35 ++++++++++++------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index cc93577dee03..469c05fd43d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -47,6 +47,9 @@ static void dce_virtual_set_display_funcs(struct amdgpu_device *adev);
 static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev);
 static int dce_virtual_connector_encoder_init(struct amdgpu_device *adev,
 					      int index);
+static int dce_virtual_pageflip(struct amdgpu_device *adev,
+				unsigned crtc_id);
+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer *vblank_timer);
 static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 							int crtc,
 							enum amdgpu_interrupt_state state);
@@ -247,6 +250,11 @@ static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_virtual_crtc_helper_funcs);
 
+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_set_expires(&amdgpu_crtc->vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD);
+	amdgpu_crtc->vblank_timer.function = dce_virtual_vblank_timer_handle;
+	hrtimer_start(&amdgpu_crtc->vblank_timer,
+		      DCE_VIRTUAL_VBLANK_PERIOD, HRTIMER_MODE_REL);
 	return 0;
 }
 
@@ -476,7 +484,7 @@ static int dce_virtual_hw_fini(void *handle)
 
 	for (i = 0; i<adev->mode_info.num_crtc; i++)
 		if (adev->mode_info.crtcs[i])
-			dce_virtual_set_crtc_vblank_interrupt_state(adev, i, AMDGPU_IRQ_STATE_DISABLE);
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	return 0;
 }
@@ -698,9 +706,15 @@ static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer *vbla
 						       struct amdgpu_crtc, vblank_timer);
 	struct drm_device *ddev = amdgpu_crtc->base.dev;
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_irq_src *source = adev->irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources
+		[VISLANDS30_IV_SRCID_SMU_DISP_TIMER2_TRIGGER];
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
 
-	drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
-	dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
+	if (amdgpu_irq_enabled(adev, source, irq_type)) {
+		drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
+		dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
+	}
 	hrtimer_start(vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD,
 		      HRTIMER_MODE_REL);
 
@@ -716,21 +730,6 @@ static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *ad
 		return;
 	}
 
-	if (state && !adev->mode_info.crtcs[crtc]->vsync_timer_enabled) {
-		DRM_DEBUG("Enable software vsync timer\n");
-		hrtimer_init(&adev->mode_info.crtcs[crtc]->vblank_timer,
-			     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		hrtimer_set_expires(&adev->mode_info.crtcs[crtc]->vblank_timer,
-				    DCE_VIRTUAL_VBLANK_PERIOD);
-		adev->mode_info.crtcs[crtc]->vblank_timer.function =
-			dce_virtual_vblank_timer_handle;
-		hrtimer_start(&adev->mode_info.crtcs[crtc]->vblank_timer,
-			      DCE_VIRTUAL_VBLANK_PERIOD, HRTIMER_MODE_REL);
-	} else if (!state && adev->mode_info.crtcs[crtc]->vsync_timer_enabled) {
-		DRM_DEBUG("Disable software vsync timer\n");
-		hrtimer_cancel(&adev->mode_info.crtcs[crtc]->vblank_timer);
-	}
-
 	adev->mode_info.crtcs[crtc]->vsync_timer_enabled = state;
 	DRM_DEBUG("[FM]set crtc %d vblank interrupt state %d\n", crtc, state);
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
