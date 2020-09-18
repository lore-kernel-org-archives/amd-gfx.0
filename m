Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F6C43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 03:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39710206FC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 03:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kmvn6VUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39710206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30C96EC91;
	Fri, 18 Sep 2020 03:27:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B637E6EC91
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 03:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHVNXXsqstE3Uu4RvtWO81s1y8chqLto4cdeFRq4Pf9BeOzGEns/JI/QWRkH0KCKxabbQGsYWAl7bA0ax8tq2OzbHgub4luFWfQvI2R6DVoJyX3Mnb18Qu7oYL07QDhX9YQwnNmi0XqMai9g91kpNNP3D+MZJxeTK8lV/Cn7n5BcPMiETg1caAX3rg1KVuD7jzzVMb0c79a3W6LROXIPdQrfQdmBjIA2d0E7uW5PV3z+17nXHrDTyHNbc/7R23IweQvfUn1GM+mNLbhARM+cKXyMETSAq1SRnAYjCRQ+iY3SOcutUn2Y/Yy3Kil4JJ+XmCjUDQciV5Jm5R00pjKzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS8pxwO4JEYctMNj9YWVuh1GkJNlXOJGA1x+S+0iTU4=;
 b=c3qME9uiUjAA/CjnFpRzirp5pBna04BB89+AOlA2uO4ksfpMvYwgTetTwHwMBYfqPoFntVuViKu3hHIi8jLyf4hM2CKWOAPCqpkkNFc86oNuIwveJxDP1FkUhqwWgwbERtLqPfr/weVnHikhVp99xaSnlaZ5yt8wJihvpfiuQiIYAsDzV7nSI5Rl/KAzOEo86/5H3hGPaIT2dH89M4EogZxCw+nF0RIh3zHTSWgPFFvIezjTGsBlSoH3XQzu9FTCcjRhShva4Y7U1gEtmlOqJBiV/kgEuFWP46cbQyHe7l7/22lx5nei9YmhanY1a44uOwP4vp5h6A8JNY5urgwARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS8pxwO4JEYctMNj9YWVuh1GkJNlXOJGA1x+S+0iTU4=;
 b=Kmvn6VUU8cMhKnp2ghQaKW/NNXPqmIxeXGkS0MNhJ08YmminF9tUi1ZTqwGLoQGvnrWInHmhPWYsMvqaFTDwF36LerZ/CbhlrlilZ4ts8P+fz/LKN7ttZ8fX8p3Y1egZY88eQShnkEFYnPdv9TP7Zl5h2GOOHbEU6q/ineUIj5Q=
Received: from BN6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:405:70::21)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 03:27:29 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::7b) by BN6PR12CA0035.outlook.office365.com
 (2603:10b6:405:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Fri, 18 Sep 2020 03:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 03:27:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 22:27:28 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 22:27:28 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 17 Sep 2020 22:27:27 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank
Date: Fri, 18 Sep 2020 11:27:17 +0800
Message-ID: <20200918032717.184758-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918032717.184758-1-Emily.Deng@amd.com>
References: <20200918032717.184758-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e834c230-32ea-48e4-5553-08d85b82c598
X-MS-TrafficTypeDiagnostic: CH2PR12MB4182:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41828C5F8EE8DF72E77FB3A38F3F0@CH2PR12MB4182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAyyOdIRPhHLXiZjWep53OHvWx40l/Yjec+UnfcR4K8OQPq3iZ4QrT3Q+ZlmmRBrwpcrPQDF3/a0pQqJEb09YodJn+Vo4hz0KQxnujMgrl7IBYXoVHNNxB84h/xeIlBlq96GsRGseZSWyKZz/SJroy4SPM1NOc/FyP97bI6K77KITuxwVPIXPP08DyTaphpiyyBAlDUdQR+dPskMhM7ZdBdwrmPklyBcNPA2QZOQvPk0+jfmrgeZRdt1Ps1Z2llBq69Py8JcNIhY9ajrwln9jT+ZJlPdqimA9lsbfiSA0qc9aK+uYntqWuOti68KG/IjFGkgF2gopKPei8E0mDT7VLy7DgDu2fQ+kTsHrzfU3Gims3NOCcljFYE+wNhkXoxk2MbgK4x7CSODCRjoimqW4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966005)(336012)(316002)(6916009)(70586007)(186003)(86362001)(70206006)(426003)(6666004)(5660300002)(1076003)(82310400003)(2906002)(36756003)(4326008)(2616005)(8936002)(8676002)(47076004)(81166007)(26005)(7696005)(356005)(82740400003)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 03:27:29.1466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e834c230-32ea-48e4-5553-08d85b82c598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 155 +++++++++++------------
 1 file changed, 77 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index cc93577dee03..8c02ab74c1de 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -226,6 +226,74 @@ static const struct drm_crtc_helper_funcs dce_virtual_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static int dce_virtual_pageflip(struct amdgpu_device *adev,
+				unsigned crtc_id)
+{
+	unsigned long flags;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_flip_work *works;
+
+	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
+
+	if (crtc_id >= adev->mode_info.num_crtc) {
+		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
+		return -EINVAL;
+	}
+
+	/* IRQ could occur when in initial stage */
+	if (amdgpu_crtc == NULL)
+		return 0;
+
+	spin_lock_irqsave(&adev->ddev->event_lock, flags);
+	works = amdgpu_crtc->pflip_works;
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
+			"AMDGPU_FLIP_SUBMITTED(%d)\n",
+			amdgpu_crtc->pflip_status,
+			AMDGPU_FLIP_SUBMITTED);
+		spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
+		return 0;
+	}
+
+	/* page flip completed. clean up */
+	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
+	amdgpu_crtc->pflip_works = NULL;
+
+	/* wakeup usersapce */
+	if (works->event)
+		drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
+
+	spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
+
+	drm_crtc_vblank_put(&amdgpu_crtc->base);
+	amdgpu_bo_unref(&works->old_abo);
+	kfree(works->shared);
+	kfree(works);
+
+	return 0;
+}
+
+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer *vblank_timer)
+{
+	struct amdgpu_crtc *amdgpu_crtc = container_of(vblank_timer,
+						       struct amdgpu_crtc, vblank_timer);
+	struct drm_device *ddev = amdgpu_crtc->base.dev;
+	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_irq_src *source = adev->irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources
+		[VISLANDS30_IV_SRCID_SMU_DISP_TIMER2_TRIGGER];
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
+
+	if (amdgpu_irq_enabled(adev, source, irq_type)) {
+		drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
+		dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
+	}
+	hrtimer_start(vblank_timer, ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD),
+		      HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
+}
+
 static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -247,6 +315,14 @@ static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_virtual_crtc_helper_funcs);
 
+	hrtimer_init(&amdgpu_crtc->vblank_timer,
+		     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_set_expires(&amdgpu_crtc->vblank_timer,
+			    ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD));
+	amdgpu_crtc->vblank_timer.function =
+		dce_virtual_vblank_timer_handle;
+	hrtimer_start(&amdgpu_crtc->vblank_timer,
+			      ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD), HRTIMER_MODE_REL);
 	return 0;
 }
 
@@ -476,7 +552,7 @@ static int dce_virtual_hw_fini(void *handle)
 
 	for (i = 0; i<adev->mode_info.num_crtc; i++)
 		if (adev->mode_info.crtcs[i])
-			dce_virtual_set_crtc_vblank_interrupt_state(adev, i, AMDGPU_IRQ_STATE_DISABLE);
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	return 0;
 }
@@ -645,68 +721,6 @@ static void dce_virtual_set_display_funcs(struct amdgpu_device *adev)
 	adev->mode_info.funcs = &dce_virtual_display_funcs;
 }
 
-static int dce_virtual_pageflip(struct amdgpu_device *adev,
-				unsigned crtc_id)
-{
-	unsigned long flags;
-	struct amdgpu_crtc *amdgpu_crtc;
-	struct amdgpu_flip_work *works;
-
-	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
-
-	if (crtc_id >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
-		return -EINVAL;
-	}
-
-	/* IRQ could occur when in initial stage */
-	if (amdgpu_crtc == NULL)
-		return 0;
-
-	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-	works = amdgpu_crtc->pflip_works;
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
-		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
-			"AMDGPU_FLIP_SUBMITTED(%d)\n",
-			amdgpu_crtc->pflip_status,
-			AMDGPU_FLIP_SUBMITTED);
-		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-		return 0;
-	}
-
-	/* page flip completed. clean up */
-	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
-	amdgpu_crtc->pflip_works = NULL;
-
-	/* wakeup usersapce */
-	if (works->event)
-		drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
-
-	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-
-	drm_crtc_vblank_put(&amdgpu_crtc->base);
-	amdgpu_bo_unref(&works->old_abo);
-	kfree(works->shared);
-	kfree(works);
-
-	return 0;
-}
-
-static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer *vblank_timer)
-{
-	struct amdgpu_crtc *amdgpu_crtc = container_of(vblank_timer,
-						       struct amdgpu_crtc, vblank_timer);
-	struct drm_device *ddev = amdgpu_crtc->base.dev;
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-
-	drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
-	dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
-	hrtimer_start(vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD,
-		      HRTIMER_MODE_REL);
-
-	return HRTIMER_NORESTART;
-}
-
 static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 							int crtc,
 							enum amdgpu_interrupt_state state)
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
