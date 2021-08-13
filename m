Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2790C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C626109D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97C626109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3732E6E4CA;
	Fri, 13 Aug 2021 06:16:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9706E4CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCcEXeSa3kZ/BKD09++7sgd96VPoShvf21lp69ikiXK2XwD9lLrD2TACwPtAnw33KPHCzD+8t9KZE6GgpaETWmbSJ7kHFRgFk+e8wxUwv7mEHILm/6MPW8SEGGmPjCy9ly2r7r94rT5WelnLS8rypwQvR5wY+70Y5Drl6P/BuB7KRXr6/fgsfjPFdK38VNXrzQEzVxss4bFDrF8kbJff18s104JV4juRioIcTIVYOaxdh3X4+IXQMSP4e3K3CeVqCDGxM92czz6L0l2LqdQFtUVAoTtN70srsMkNWZ3KQ9uYeBMS3Syx3ta4b1AtiMd+HPIcDCaSrgc2UV8gNijk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi58/tRR2DkPTb2J4yEpkbR3X/mgKxrzu9TqvW38LtU=;
 b=JBeK4WetqxI9E2n+iEKeXtf4PUUT5O39Xe12P56upH6axbfLRh1Ok8Ahp5reyfVfiiK7sWNe/U78xb2EDH9trfFcK2PSnA5N0LkTa2VhyuCINJqaXZcokSXHVbeneq0LMhWIXvj051zQsQ0Q6hQv3OSc+OnDs+WKrGEZGCnQUbO/+MTURmEfCB1a7o3eFVdJN1ktjTcN5gKinc4sBp4heCzvp1Gn5mqn8VjgDMgqVXqhJNdOTaF/b1K7Glzm4WdTWR4igQKjx5BobY+SFQRVpMJJNZ6hM2+YnMGHe76ueG7EcyEasjrITKnNBDYO7yn2pdwP96E5GRz4loozoeYk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi58/tRR2DkPTb2J4yEpkbR3X/mgKxrzu9TqvW38LtU=;
 b=SYytir/54IgEqb49nb0ZyfQpnzNsoeL/nhvAOAjcUqNhfmQSy7bhovFcSlr+7AWXyQSDizOqDsuGZzLHgkQAcBtWnFoB8r54DCPfcgU5UukY57TYHNxaSRdPg8y7A2ay4KGmgZuEkS+XPzaxu2eDuTxuXwv75bWoLNcAPoINid8=
Received: from BN9PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:fa::30)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 13 Aug
 2021 06:16:12 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::74) by BN9PR03CA0025.outlook.office365.com
 (2603:10b6:408:fa::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Fri, 13 Aug 2021 06:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 06:16:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:16:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 23:16:10 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:16:07 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Roman Li <Roman.Li@amd.com>, Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH 2/7] drm/amd/display: Fix multi-display support for idle opt
 workqueue
Date: Fri, 13 Aug 2021 14:15:45 +0800
Message-ID: <20210813061550.3104690-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813061550.3104690-1-Wayne.Lin@amd.com>
References: <20210813061550.3104690-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90e46ec0-abbb-487c-0d6b-08d95e21d910
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0169CC232F0E2523DFEFAD80FCFA9@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eynEpvZktc4zujkmo3k4JXX8sIx1IXLcrPUTXR1M3X0UEx7+URDtkiYZGcZSmiGRP0V4FQ9GWfmaNvzDX1n6b+7icFOUXSJuVpy1SVQ1SlV6ZtyPMzREZlFqxUPWFsyzeErriH5hGDfoqAO1uIpJUKK9vw7Ym/E47DHggpvYOpe5ZP2ST88UJ+ZV2Uagl4srqAMkO9e6dREdF9jA+5WHKIkx5lrKCegptrWl74+BhbML87f+J/GmkDXP46c9XDEuLH3RAoiTSQWg1EO9bi3fFxkMn7fO7AI/PqpdmM0FUyKLjBwcAQUwJAFHXBtUmvqLygzg6SAYKt0SxMFwaJvPwS/p341/mr09aiXoH8NhL2RI48XK/N3foOK4PpgbkxhIWDoJv5px2oW6Srd0E0+ZHtGJw90fUiduHzrelEFlAbLaNJ7rAgoogm6CcWFVU5Diopl/eP3ZpNUHAM8k13ryL+LTB9xm2CNXXKLGgo69/aKMcl2dV6DtlgDHJbm1pGhan3zfWoJv/64oLtvhc30ubRyIXsqGWs7OnGnA1Gj6GEAlDS0xf4X1AOstZuZL37ZsukrndknPdWlDUPUeCluDQvySz8/UhRG3Z+NVELX/2kjJ7sUQSrR02dD74/K59VuFYNqjyT5CiMK/R9hluOgq5yxjyWVaktP/Ez5OQudDdk5NiZ/T2Bn/ygbn56nqzNegqp3p0m6v+h3gkwrQeSz/NwrfbNgNjbX3mWcgHCJ+AxmFCji0OdYMc2Q0BqMYQCI49r/QotAMQqDujS7l9Cuv9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(47076005)(426003)(86362001)(2616005)(186003)(8676002)(36756003)(6916009)(34020700004)(36860700001)(8936002)(336012)(82310400003)(70206006)(70586007)(83380400001)(54906003)(26005)(5660300002)(81166007)(7696005)(478600001)(356005)(316002)(4326008)(2906002)(82740400003)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:16:11.7845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e46ec0-abbb-487c-0d6b-08d95e21d910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The current implementation for idle optimization support only has a
single work item that gets reshuffled into the system workqueue
whenever we receive an enable or disable event.

We can have mismatched events if the work hasn't been processed or if
we're getting control events from multiple displays at once.

This fixes this issue and also makes the implementation usable for
PSR control - which will be addressed in another patch.

[How]
We need to be able to flush remaining work out on demand for driver stop
and psr disable so create a driver specific workqueue instead of using
the system one. The workqueue will be single threaded to guarantee the
ordering of enable/disable events.

Refactor the queue to allocate the control work and deallocate it
after processing it.

Pass the acrtc directly to make it easier to handle psr enable/disable
in a later patch.

Rename things to indicate that it's not just MALL specific.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 62 ++++++++-----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 21 ++++---
 2 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3e28f17c84fa..f88b6c5b83cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1044,10 +1044,10 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 }
 #endif
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-static void event_mall_stutter(struct work_struct *work)
+static void vblank_control_worker(struct work_struct *work)
 {
-
-	struct vblank_workqueue *vblank_work = container_of(work, struct vblank_workqueue, mall_work);
+	struct vblank_control_work *vblank_work =
+		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
 
 	mutex_lock(&dm->dc_lock);
@@ -1062,22 +1062,9 @@ static void event_mall_stutter(struct work_struct *work)
 	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
 	mutex_unlock(&dm->dc_lock);
+	kfree(vblank_work);
 }
 
-static struct vblank_workqueue *vblank_create_workqueue(struct amdgpu_device *adev, struct dc *dc)
-{
-	struct vblank_workqueue *vblank_work;
-
-	vblank_work = kzalloc(sizeof(*vblank_work), GFP_KERNEL);
-	if (ZERO_OR_NULL_PTR(vblank_work)) {
-		kfree(vblank_work);
-		return NULL;
-	}
-
-	INIT_WORK(&vblank_work->mall_work, event_mall_stutter);
-
-	return vblank_work;
-}
 #endif
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
@@ -1220,12 +1207,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (adev->dm.dc->caps.max_links > 0) {
-		adev->dm.vblank_workqueue = vblank_create_workqueue(adev, adev->dm.dc);
-
-		if (!adev->dm.vblank_workqueue)
+		adev->dm.vblank_control_workqueue =
+			create_singlethread_workqueue("dm_vblank_control_workqueue");
+		if (!adev->dm.vblank_control_workqueue)
 			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
-		else
-			DRM_DEBUG_DRIVER("amdgpu: vblank_workqueue init done %p.\n", adev->dm.vblank_workqueue);
 	}
 #endif
 
@@ -1298,6 +1283,13 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 {
 	int i;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (adev->dm.vblank_control_workqueue) {
+		destroy_workqueue(adev->dm.vblank_control_workqueue);
+		adev->dm.vblank_control_workqueue = NULL;
+	}
+#endif
+
 	for (i = 0; i < adev->dm.display_indexes_num; i++) {
 		drm_encoder_cleanup(&adev->dm.mst_encoders[i].base);
 	}
@@ -1321,14 +1313,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (adev->dm.vblank_workqueue) {
-		adev->dm.vblank_workqueue->dm = NULL;
-		kfree(adev->dm.vblank_workqueue);
-		adev->dm.vblank_workqueue = NULL;
-	}
-#endif
-
 	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
@@ -6000,7 +5984,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct amdgpu_display_manager *dm = &adev->dm;
-	unsigned long flags;
+	struct vblank_control_work *work;
 #endif
 	int rc = 0;
 
@@ -6025,12 +6009,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 		return 0;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	spin_lock_irqsave(&dm->vblank_lock, flags);
-	dm->vblank_workqueue->dm = dm;
-	dm->vblank_workqueue->otg_inst = acrtc->otg_inst;
-	dm->vblank_workqueue->enable = enable;
-	spin_unlock_irqrestore(&dm->vblank_lock, flags);
-	schedule_work(&dm->vblank_workqueue->mall_work);
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return -ENOMEM;
+
+	INIT_WORK(&work->work, vblank_control_worker);
+	work->dm = dm;
+	work->acrtc = acrtc;
+	work->enable = enable;
+
+	queue_work(dm->vblank_control_workqueue, &work->work);
 #endif
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ab1670b16b02..c6b8b835b08a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -60,6 +60,7 @@ enum aux_return_code_type;
 
 /* Forward declarations */
 struct amdgpu_device;
+struct amdgpu_crtc;
 struct drm_device;
 struct dc;
 struct amdgpu_bo;
@@ -86,16 +87,16 @@ struct dm_compressor_info {
 };
 
 /**
- * struct vblank_workqueue - Works to be executed in a separate thread during vblank
- * @mall_work: work for mall stutter
+ * struct vblank_control_work - Work data for vblank control
+ * @work: Kernel work data for the work event
  * @dm: amdgpu display manager device
- * @otg_inst: otg instance of which vblank is being set
- * @enable: true if enable vblank
+ * @acrtc: amdgpu CRTC instance for which the event has occurred
+ * @enable: true if enabling vblank
  */
-struct vblank_workqueue {
-	struct work_struct mall_work;
+struct vblank_control_work {
+	struct work_struct work;
 	struct amdgpu_display_manager *dm;
-	int otg_inst;
+	struct amdgpu_crtc *acrtc;
 	bool enable;
 };
 
@@ -380,11 +381,11 @@ struct amdgpu_display_manager {
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/**
-	 * @vblank_workqueue:
+	 * @vblank_control_workqueue:
 	 *
-	 * amdgpu workqueue during vblank
+	 * Deferred work for vblank control events.
 	 */
-	struct vblank_workqueue *vblank_workqueue;
+	struct workqueue_struct *vblank_control_workqueue;
 #endif
 
 	struct drm_atomic_state *cached_state;
-- 
2.25.1

