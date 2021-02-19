Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0233C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F7864E12
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F7864E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAEF6EC34;
	Fri, 19 Feb 2021 22:17:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C666EC50
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFpG8o+ZCO4NPJZGR1eg4yS2sXuqx0vx3ONOfuBCKXMYb30WWg5gZLWuV9rDnDUaFif4ilWLC8IlmKpz7GusNi9D1win5Hu3VGo1YqSkLuV1b7/X6IiZpCQG8R6/7zvACy0rAFhQgdh0Fafn36wh8C/x9av5jrI6+9ntEkTYxIHGUm5GUMTmCUus6GEigTbIB7gnmstOxLudeS1v0fftq/xrelslnJkND6CFQIkmdMRn9T/6/aHcXkLBHuh89Jr7DX9hSO3Tl3nldXUVvGgMqZCxVZ933lvJVR+5ZMtIQpPWfprWFykMqENK8E3PKcbS7CyPBAjIyHfEzmWHtol8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6EAvifnFI9VNWvDWPZ5hxZ5FTZxsaKYHOIZ3QF4T7E=;
 b=VhhaWZADTg61fXLLDyWgzqlYj/zT+PqdUXzN+A4ldhRdzn+1YJY09VEoyyHfKLmUALIXuieoKWdjX6nyY7M3nPFctIuzJAyoe7+GrnCdK2fCnnjJxUSaBVn0LhE5/wb/Sf+SESJEkqfTrwQx57jGgP2l1buOp1SoYdMyljMaPeiQv7cgTMhdPG2RTaWuP1Usmo5XrTfwcCwSxPZGPZOTFbrQos7bq1ywZCXY3YDxRNpEP1ZvBL16/u7Mw5cSoFM2hZmxmJRG5O1yIdiEOyXPoEMR1qyMLsh4xLxJDQGWYHcyVrOJIub+M2i3g0BbleE+mLw52kXolQI1LCjz1tU5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6EAvifnFI9VNWvDWPZ5hxZ5FTZxsaKYHOIZ3QF4T7E=;
 b=ogRooGxSlmaiCv7Ub2cz9uTzp4uRTKsc8Yqqhz7+VVZRh1M5JBcM8azS7TiEywEPdcyCJAKAEUPkuVw9x8/mTFIowLdZXobIqLEfQVJ0qe6mf9T7vfmvvc/o9jxtHZhgyC5TPBEu3sPXzfnxjp9ruS8/HLUFw5Rpa7ieFAY7Moc=
Received: from BN6PR11CA0071.namprd11.prod.outlook.com (2603:10b6:404:f7::33)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 22:17:10 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::17) by BN6PR11CA0071.outlook.office365.com
 (2603:10b6:404:f7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:17:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:17:00 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:59 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:54 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amd/display: Fix system hang after multiple hotplugs
Date: Fri, 19 Feb 2021 17:16:12 -0500
Message-ID: <20210219221612.1713328-14-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94203df-1e05-4d6c-4d2a-08d8d5241933
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688D08D193D86BBB4405252F5849@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ph0iuT740V/BHAYtA/ys1bKwjSE/y8j87awwvEUy/nXHyPGU54UkDMK8+AF3y/h7dZmJqffZDjhTfC6qO85l4RHTMfX8cNSyAgZ5uFN8F/kNUMRLJYYh5VOYUCI2K0pi5gs+JWdMpC6nNF8iqEg7h9q3ph1jHcF99Yas6lQqGwy8uQDSmsqLHQnsMPI0WF3h8pP9T9irFS0ekHUCgDz3pC5LJif3dg2QsNDX2nUJQ3A+1o8vBKbJxPLM9VIIHLTk66zPpNgDqXGPS0BGmF9/kazkVOBjG/2ZkBluLO6N0u5Z1A3wfOftOxbhD2ZbIiRlOdH2/uW4A8o55n+z4RruNmB6bfPFsMKalVqZs+gvf7gYsavBZ/BcXs2TOc99Oab+/Eu6GbF0pGUO0SyV0dS5s6l1DfIqOoLzb2fd/6KltGML2HnNb6RGV68pxMFWjfbvCIgww0JI+OajbfoQvQqMnWkk8WoPwNCZz+CLBpqHM3jixgL/Cqml+HEUghqCkDtYWW3xFaHfuIo5bhx9rMSeiQOtARjLfS+Nb4tWtjDolDCdiCKZXAxFjAG5dU5y6/83TOLpDox5SWXA9VVHAbHPIA9mcUiJfGzINmgaOVH52CZ1fLyoH+huaWAnk4MOMjMS0oqnJhOK84DjUtx+TqMp5igdDh39yeLaFD2zItE6Lp6SE4aYZMspZztaaxr4zg+8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(478600001)(316002)(26005)(54906003)(5660300002)(2906002)(4326008)(6666004)(336012)(8676002)(426003)(2616005)(186003)(6916009)(1076003)(47076005)(8936002)(70586007)(86362001)(82740400003)(83380400001)(81166007)(7696005)(36860700001)(356005)(82310400003)(36756003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:17:09.0816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94203df-1e05-4d6c-4d2a-08d8d5241933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
mutex_lock() was introduced in dm_disable_vblank(), which could
be called in an IRQ context. Waiting in IRQ would cause issues
like kernel lockup, etc.

[How]
Handle code that requires mutex lock on a different thread.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 80 +++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 27 +++++++
 2 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0970d9c14889..223bbb34f1a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -938,7 +938,49 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+static void event_mall_stutter(struct work_struct *work)
+{
+
+	struct vblank_workqueue *vblank_work = container_of(work, struct vblank_workqueue, mall_work);
+	struct amdgpu_display_manager *dm = vblank_work->dm;
+
+	mutex_lock(&dm->dc_lock);
+
+	if (vblank_work->enable)
+		dm->active_vblank_irq_count++;
+	else
+		dm->active_vblank_irq_count--;
+
+
+	dc_allow_idle_optimizations(
+		dm->dc, dm->active_vblank_irq_count == 0 ? true : false);
+
+	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
+
+
+	mutex_unlock(&dm->dc_lock);
+}
+
+static struct vblank_workqueue *vblank_create_workqueue(struct amdgpu_device *adev, struct dc *dc)
+{
+
+	int max_caps = dc->caps.max_links;
+	struct vblank_workqueue *vblank_work;
+	int i = 0;
+
+	vblank_work = kcalloc(max_caps, sizeof(*vblank_work), GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(vblank_work)) {
+		kfree(vblank_work);
+		return NULL;
+	}
+
+	for (i = 0; i < max_caps; i++)
+		INIT_WORK(&vblank_work[i].mall_work, event_mall_stutter);
 
+	return vblank_work;
+}
+#endif
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -958,6 +1000,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	mutex_init(&adev->dm.dc_lock);
 	mutex_init(&adev->dm.audio_lock);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	spin_lock_init(&adev->dm.vblank_lock);
+#endif
 
 	if(amdgpu_dm_irq_init(adev)) {
 		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
@@ -1072,6 +1117,17 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	amdgpu_dm_init_color_mod();
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (adev->dm.dc->caps.max_links > 0) {
+		adev->dm.vblank_workqueue = vblank_create_workqueue(adev, adev->dm.dc);
+
+		if (!adev->dm.vblank_workqueue)
+			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
+		else
+			DRM_DEBUG_DRIVER("amdgpu: vblank_workqueue init done %p.\n", adev->dm.vblank_workqueue);
+	}
+#endif
+
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (adev->dm.dc->caps.max_links > 0 && adev->asic_type >= CHIP_RAVEN) {
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
@@ -5449,6 +5505,9 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 	struct amdgpu_display_manager *dm = &adev->dm;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	unsigned long flags;
+#endif
 	int rc = 0;
 
 	if (enable) {
@@ -5472,21 +5531,12 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (amdgpu_in_reset(adev))
 		return 0;
 
-	mutex_lock(&dm->dc_lock);
-
-	if (enable)
-		dm->active_vblank_irq_count++;
-	else
-		dm->active_vblank_irq_count--;
-
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	dc_allow_idle_optimizations(
-		adev->dm.dc, dm->active_vblank_irq_count == 0 ? true : false);
-
-	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
-#endif
-
-	mutex_unlock(&dm->dc_lock);
+	spin_lock_irqsave(&dm->vblank_lock, flags);
+	dm->vblank_workqueue->dm = dm;
+	dm->vblank_workqueue->otg_inst = acrtc->otg_inst;
+	dm->vblank_workqueue->enable = enable;
+	spin_unlock_irqrestore(&dm->vblank_lock, flags);
+	schedule_work(&dm->vblank_workqueue->mall_work);
 
 #endif
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5f9950fd216c..b0d137998169 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -92,6 +92,20 @@ struct dm_compressor_info {
 	uint64_t gpu_addr;
 };
 
+/**
+ * struct vblank_workqueue - Works to be executed in a separate thread during vblank
+ * @mall_work: work for mall stutter
+ * @dm: amdgpu display manager device
+ * @otg_inst: otg instance of which vblank is being set
+ * @enable: true if enable vblank
+ */
+struct vblank_workqueue {
+	struct work_struct mall_work;
+	struct amdgpu_display_manager *dm;
+	int otg_inst;
+	bool enable;
+};
+
 /**
  * struct amdgpu_dm_backlight_caps - Information about backlight
  *
@@ -243,6 +257,15 @@ struct amdgpu_display_manager {
 	 */
 	struct mutex audio_lock;
 
+	/**
+	 * @vblank_work_lock:
+	 *
+	 * Guards access to deferred vblank work state.
+	 */
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	spinlock_t vblank_lock;
+#endif
+
 	/**
 	 * @audio_component:
 	 *
@@ -321,6 +344,10 @@ struct amdgpu_display_manager {
 	struct hdcp_workqueue *hdcp_workqueue;
 #endif
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	struct vblank_workqueue *vblank_workqueue;
+#endif
+
 	struct drm_atomic_state *cached_state;
 	struct dc_state *cached_dc_state;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
