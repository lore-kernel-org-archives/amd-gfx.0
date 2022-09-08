Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00894C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 14:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 813AB10E66E;
	Thu,  8 Sep 2022 14:39:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8BD10E66E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 14:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6BR3t7xAjn0zN7aq7UWhbaK+YtReFloLqCTZpkX6fp+kZeZuTwZ5j/OE3CP6af6K+Id160M/ROEG28kS9/RXYh1zmtI6pf1ECUH94zPoFS9kUVXhS+pvDy9uaS6GCfjCawqBlrEbamnYGMrGhe7Wo6ivE/vixWwl7WhIvL4tXIDeQ0qUSmAt7acUEVM5pgFXALUHvtPnJfmZN1fNA0Pk0dTWH69kdelodOh1eb9VQop73p3FF+WTRlFUM8EXTRLyHVSIurkxgX65gwo3kErLunlnI8gBKZSvc7hGGcL5gJ+vJXGgS+CVNlsQxBd7C64nkSfmn7RfT6q3y+LqW7Tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtncfqDNKzKYC2aVwlrE8TC4GgEm7XUljCaOCAQ4h20=;
 b=mJMMb+63SUWFcIOEeebHATtZXQxwDqdYL3gm07+bWN6VS8Fmca7NmMX9S+K08qH05XQtGJDMiwJ5r2D7P+5zNYmB/AF012ffYZwf4gQLcLdipOrRbYb7f5J8/PtMg0x2DIYt0nzFqjq7fZHEFjJz7p+lQwi/kuBvtqoZCmYBaNjaRdfSvm4W4fbD05uHrxE+/OEm+I+H4RDvJPumGiB/97aKxbO4p8eGPZ6q0bxXndl2cxcmAWefd7XQstLRI+soJAhRxQ7bcZTQUCqXK4+WXUXGm+q+RbZ9TxNH0YtYmZmq3MIwDK6V7u0+YpWqvWqiZvOlLt8JPH2ayg/vxPk82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtncfqDNKzKYC2aVwlrE8TC4GgEm7XUljCaOCAQ4h20=;
 b=mMt+qFruDfjinibuLjZb/ARdjvMwe2fOFJ8XfI1s06a+zZHr4Vq/Ykb5d7vpDiNIIyEuP1tDQ/mCFrNxR67Wiudj+iZ0Cz246fqZuqDTzgdztw+3uNDJk5yfK8wI2YxVNu/PcrHt0xfOJlDiLil7/5t+UEBXhkvY+HJvdXb/I8w=
Received: from BL0PR0102CA0015.prod.exchangelabs.com (2603:10b6:207:18::28) by
 LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 14:39:17 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::85) by BL0PR0102CA0015.outlook.office365.com
 (2603:10b6:207:18::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15 via Frontend
 Transport; Thu, 8 Sep 2022 14:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Thu, 8 Sep 2022 14:39:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 09:38:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: move non-DC vblank handling out of irq code
Date: Thu, 8 Sep 2022 10:38:07 -0400
Message-ID: <20220908143808.53981-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908143808.53981-1-alexander.deucher@amd.com>
References: <20220908143808.53981-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2f1e80-d752-494f-2e2c-08da91a7e84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjopJ75eHpDURhXcswv4N1+1dnzoyH5BZmeHyyGDW7vV927RlSpkv3WtbpEfqSYjrrGU2aOdPK/5prKBTUlza+pALMfkDifAby3FysY83UV8EoIPhjwsdOsWeh0m+Ej+oJ4U7LSzV+LwAdJA0+CWO+zwfKVqazxcCvBT/HlbpF+opkWAWTwicZPFjYGQo8MCmveLSpTvaIUijKgU0TibMuS8fULMS0r/esSww3EX34PCgccZJeibBA78u9tbDyZ3i/hid6RDUvTXo26qDTl2/J2ENylsH7/9bE5hhUYX0W29V9wlY2iEcrxU7jxM6LozJ6TwW8aEjRf+7WcAm25K4eY2XJK35TkWk+kejr5qmhMwx73tMrRFAOQT5xhZQ3oxLPj+9T16j8wtjm6esAcKGtzm64lwQEDF5lS8bXSB2DjvBoQ0pdzZrapt3Nyy2Z4Q7c4xKPSKHRz3FwQcHq1zbqlNl51j36qs6IkS8MX+RjGHDfeI0ZmSf4DroPLZU8doORneQIV0wn8Q5UAMmvuObYnth4RCXOpF9LOQeu2pB6CUQexYIGZg4lkQxHXhg+I64DrZswUo8IQLYU1hzdfZu/PJY/89xPOPldWHkcuaCr2LhWjutk+7RKzVBzE6odsY8yjpu6Rq6Sbggf5pv9TJLTW7L9dHWl1GhvU9U5It8LaklMHKJqRWY4v48DuvMoPYkK7LH0h3zla1JCUd7yS7E4Sa6ySm1wunVvAt0H3cg1olJupWOcQLfMwUIXWsFZFBSJJY51hTKiQ5FxSLyPHdgotJvSfnhQuWrkYHBAxbzNWSNYLutNnJ9Vo7FTWrtChMnQz9gGF6QTpaPMb9nC3ueA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(40470700004)(7696005)(26005)(81166007)(356005)(86362001)(82310400005)(6666004)(478600001)(36860700001)(82740400003)(41300700001)(40460700003)(186003)(1076003)(16526019)(47076005)(2616005)(336012)(83380400001)(426003)(4326008)(8676002)(30864003)(8936002)(5660300002)(6916009)(36756003)(40480700001)(316002)(70206006)(70586007)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:39:16.8306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2f1e80-d752-494f-2e2c-08da91a7e84a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move it into the DCE code for each generation. This avoids
confusion with the different display paths.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 35 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c     | 58 +--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    | 12 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      | 13 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      | 13 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       | 14 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       | 14 +++++
 8 files changed, 103 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index b0fa5d065d50..220554e7c548 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -44,6 +44,41 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
+/**
+ * amdgpu_display_hotplug_work_func - work handler for display hotplug event
+ *
+ * @work: work struct pointer
+ *
+ * This is the hotplug event work handler (all ASICs).
+ * The work gets scheduled from the IRQ handler if there
+ * was a hotplug interrupt.  It walks through the connector table
+ * and calls hotplug handler for each connector. After this, it sends
+ * a DRM hotplug event to alert userspace.
+ *
+ * This design approach is required in order to defer hotplug event handling
+ * from the IRQ handler to a work handler because hotplug handler has to use
+ * mutexes which cannot be locked in an IRQ handler (since &mutex_lock may
+ * sleep).
+ */
+void amdgpu_display_hotplug_work_func(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  hotplug_work);
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_mode_config *mode_config = &dev->mode_config;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+
+	mutex_lock(&mode_config->mutex);
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		amdgpu_connector_hotplug(connector);
+	drm_connector_list_iter_end(&iter);
+	mutex_unlock(&mode_config->mutex);
+	/* Just fire off a uevent and let userspace tell us what to do */
+	drm_helper_hpd_irq_event(dev);
+}
+
 static int amdgpu_display_framebuffer_init(struct drm_device *dev,
 					   struct amdgpu_framebuffer *rfb,
 					   const struct drm_mode_fb_cmd2 *mode_cmd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index 560352f7c317..9d19940f73c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -35,6 +35,7 @@
 #define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.funcs->add_encoder((adev), (e), (s), (c))
 #define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r) (adev)->mode_info.funcs->add_connector((adev), (ci), (sd), (ct), (ib), (coi), (h), (r))
 
+void amdgpu_display_hotplug_work_func(struct work_struct *work);
 void amdgpu_display_update_priority(struct amdgpu_device *adev);
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 89011bae7588..a6aef488a822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -100,41 +100,6 @@ const char *soc15_ih_clientid_name[] = {
 	"MP1"
 };
 
-/**
- * amdgpu_hotplug_work_func - work handler for display hotplug event
- *
- * @work: work struct pointer
- *
- * This is the hotplug event work handler (all ASICs).
- * The work gets scheduled from the IRQ handler if there
- * was a hotplug interrupt.  It walks through the connector table
- * and calls hotplug handler for each connector. After this, it sends
- * a DRM hotplug event to alert userspace.
- *
- * This design approach is required in order to defer hotplug event handling
- * from the IRQ handler to a work handler because hotplug handler has to use
- * mutexes which cannot be locked in an IRQ handler (since &mutex_lock may
- * sleep).
- */
-static void amdgpu_hotplug_work_func(struct work_struct *work)
-{
-	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
-						  hotplug_work);
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_mode_config *mode_config = &dev->mode_config;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
-
-	mutex_lock(&mode_config->mutex);
-	drm_connector_list_iter_begin(dev, &iter);
-	drm_for_each_connector_iter(connector, &iter)
-		amdgpu_connector_hotplug(connector);
-	drm_connector_list_iter_end(&iter);
-	mutex_unlock(&mode_config->mutex);
-	/* Just fire off a uevent and let userspace tell us what to do */
-	drm_helper_hpd_irq_event(dev);
-}
-
 /**
  * amdgpu_irq_disable_all - disable *all* interrupts
  *
@@ -317,21 +282,6 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!amdgpu_device_has_dc_support(adev)) {
-		if (!adev->enable_virtual_display)
-			/* Disable vblank IRQs aggressively for power-saving */
-			/* XXX: can this be enabled for DC? */
-			adev_to_drm(adev)->vblank_disable_immediate = true;
-
-		r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
-		if (r)
-			return r;
-
-		/* Pre-DCE11 */
-		INIT_WORK(&adev->hotplug_work,
-				amdgpu_hotplug_work_func);
-	}
-
 	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
 	INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
 	INIT_WORK(&adev->irq.ih_soft_work, amdgpu_irq_handle_ih_soft);
@@ -345,11 +295,8 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	/* PCI devices require shared interrupts. */
 	r = request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_drm(adev)->driver->name,
 			adev_to_drm(adev));
-	if (r) {
-		if (!amdgpu_device_has_dc_support(adev))
-			flush_work(&adev->hotplug_work);
+	if (r)
 		return r;
-	}
 	adev->irq.installed = true;
 	adev->irq.irq = irq;
 	adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
@@ -366,9 +313,6 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
 		adev->irq.installed = false;
 		if (adev->irq.msi_enabled)
 			pci_free_irq_vectors(adev->pdev);
-
-		if (!amdgpu_device_has_dc_support(adev))
-			flush_work(&adev->hotplug_work);
 	}
 
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 576849e95296..d68233dc772c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -511,6 +511,15 @@ static int amdgpu_vkms_sw_init(void *handle)
 			return r;
 	}
 
+
+	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
+	if (r)
+		return r;
+
+	/* Pre-DCE11 */
+	INIT_WORK(&adev->hotplug_work,
+		  amdgpu_display_hotplug_work_func);
+
 	drm_kms_helper_poll_init(adev_to_drm(adev));
 
 	adev->mode_info.mode_config_initialized = true;
@@ -583,6 +592,9 @@ static int amdgpu_vkms_hw_init(void *handle)
 
 static int amdgpu_vkms_hw_fini(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	flush_work(&adev->hotplug_work);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 288fce7dc0ed..bdd3aef6d071 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2830,6 +2830,17 @@ static int dce_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Disable vblank IRQs aggressively for power-saving */
+	/* XXX: can this be enabled for DC? */
+	adev_to_drm(adev)->vblank_disable_immediate = true;
+
+	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
+	if (r)
+		return r;
+
+	INIT_WORK(&adev->hotplug_work,
+		  amdgpu_display_hotplug_work_func);
+
 	drm_kms_helper_poll_init(adev_to_drm(adev));
 
 	adev->mode_info.mode_config_initialized = true;
@@ -2892,6 +2903,8 @@ static int dce_v10_0_hw_fini(void *handle)
 
 	dce_v10_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index cbe5250b31cb..328d9e16668a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2949,6 +2949,17 @@ static int dce_v11_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Disable vblank IRQs aggressively for power-saving */
+	/* XXX: can this be enabled for DC? */
+	adev_to_drm(adev)->vblank_disable_immediate = true;
+
+	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
+	if (r)
+		return r;
+
+	INIT_WORK(&adev->hotplug_work,
+		  amdgpu_display_hotplug_work_func);
+
 	drm_kms_helper_poll_init(adev_to_drm(adev));
 
 	adev->mode_info.mode_config_initialized = true;
@@ -3022,6 +3033,8 @@ static int dce_v11_0_hw_fini(void *handle)
 
 	dce_v11_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index b1c44fab074f..d101ceb8c2a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2706,6 +2706,18 @@ static int dce_v6_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Disable vblank IRQs aggressively for power-saving */
+	/* XXX: can this be enabled for DC? */
+	adev_to_drm(adev)->vblank_disable_immediate = true;
+
+	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
+	if (r)
+		return r;
+
+	/* Pre-DCE11 */
+	INIT_WORK(&adev->hotplug_work,
+		  amdgpu_display_hotplug_work_func);
+
 	drm_kms_helper_poll_init(adev_to_drm(adev));
 
 	return r;
@@ -2764,6 +2776,8 @@ static int dce_v6_0_hw_fini(void *handle)
 
 	dce_v6_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index a22b45c92792..2bee8343782d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2731,6 +2731,18 @@ static int dce_v8_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Disable vblank IRQs aggressively for power-saving */
+	/* XXX: can this be enabled for DC? */
+	adev_to_drm(adev)->vblank_disable_immediate = true;
+
+	r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
+	if (r)
+		return r;
+
+	/* Pre-DCE11 */
+	INIT_WORK(&adev->hotplug_work,
+		  amdgpu_display_hotplug_work_func);
+
 	drm_kms_helper_poll_init(adev_to_drm(adev));
 
 	adev->mode_info.mode_config_initialized = true;
@@ -2791,6 +2803,8 @@ static int dce_v8_0_hw_fini(void *handle)
 
 	dce_v8_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
-- 
2.37.2

