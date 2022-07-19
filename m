Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E33C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 18:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A777B8B22B;
	Tue, 19 Jul 2022 18:35:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE468B1A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 18:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgyac5b8qNK1BfWpWLUxS/ER08DOJ3tLbmROt1E7pCP2HkBsZ0aUx+qQX0JVPzLPy4iiFzUy90b7nCGbrZh71DTZzXZcTahBe6KWGAK9sILqq1Kox4CKSe+VTFoBY1mfx4+VE33QJt3l+H/MStKaYRa6EXEM0qhfBzC1dUT5Sm3RfE9WRFnhdBdeqPiSGghbIash0UCZ1zklVJafr+01RC6EwGvFH7VTg9eDEQZx9+/PB91vuHNAyRQpL2dROyTLBGcJ1xq+625wG2jYzjUM3RVcdP4KBrICvXwLmV9FRtcV5ITtIvcUlbMW09y/L+F3pMcETA+7drufbXoHLi2eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9LuwI69zpZMS8dHTGVqx2xXG2ExZtwQqLxl+/SHvD4=;
 b=Y53HcVMt9ciAx3Mnxl6Nx1FZsxzz01LpVjE2BgB7uVSIWTalgeVLLsObYrL13daLnxjArOCuq69/2XTdQ5dMzz7zEDxy349LG3gCbGu6vAcVqdcQeinta2yCOPhQuObJorw7VU3NuI36E5FbnX7zRKCdj9SZyYNpJcnCizy9QBoeGcBAFQSByq+K6lIWfkxcM9XNiLD3PW+MWoT6b92bXhr8VgaJZg+tGMQ2tWd0ttKUdhf1B9QacCjuWeiadwQyUr5QrB9oC2IGHfhjS6/6A7BTaUN3kwQ1gGO5i/K9HzTuqGBGQCgAUepOtTv8/OAPmdxhmjiEPuacwlwkZFr0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9LuwI69zpZMS8dHTGVqx2xXG2ExZtwQqLxl+/SHvD4=;
 b=4gfCTJC6tezEfYLt+/Ip7zdZTQtfg0bkuI5V2xGt65xD0R6vmHje6XvpntIctmibDHC+WzK9UuL23w/XbpWrYf4qyyZr3tC50t/Dv0LVhxHfVNNBaUlS0zwm7YZLfhA2BkxlQALjuOqbVljpXC9AfnAibjXDUBEhsYCUfG2v5Uk=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by DM5PR12MB1257.namprd12.prod.outlook.com (2603:10b6:3:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 18:35:07 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::1e) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Tue, 19 Jul 2022 18:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 18:35:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 13:34:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: move non-DC vblank handling out of irq code
Date: Tue, 19 Jul 2022 14:34:35 -0400
Message-ID: <20220719183436.1705006-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220719183436.1705006-1-alexander.deucher@amd.com>
References: <20220719183436.1705006-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e6558c-ec08-47b8-4b2b-08da69b567a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ckxc5JxSfAccYyVCR6fLueA4JxxMybIeN+cctw9a3i1EquGNEgaHTKnp0g8pIydC1mKl7xNmAc9dBcg/8VoEwtQZDzrNV+94kmKUDqYBhcwTd5YYusWZIsXZyLuGbr4sraVU9TPo7peFD1iaRGgRljtWAMu8ltTYelWCRr/yPkfSMgsTlQdUSMVCo1BHlE6DoPaHSG0tJ7i9kdsQVStkccaIZyUsWo6uq6nfr2A6KaI9Y+ktaCWhzUmVDOavtAy4squhNHEOoSnGZQNq6Xwout4uTgulu5yyYvweFQevPlrcG9AbSdTXbWGB5U+JMQUm49ZmSlX3JIU+FeGJXJx4ICtL9K7USlbUf//kAwGkUNqxfqqaw4SRBLl+SzSsysvBAT74bTCyRe+Amo7AFIl5MlLe82AmJfMlJCmoTOTFpmsKt9tiYyPmBvuPXYtNLSQMLxjzxXCEzRLvOm+yTSa2j+tE66ooWQgzMgMGONyiEStN8u6SQkfPaGvHlcB9zOKSWOmssqiJmZsBt/kkauLe7OAoIE2HqUFUxA85blgnL0KdhSAGdvne9yLbPQ6gcnQ+0WzbRp8PKCoav1afXtJ8094DR6nU8Qga3CV+ivwjAg0tn0/P3A9XP9zQkkF0SoqOMwGAYGfdtw92l4J8j9Z4/kGrwVZRz+PmgpVBbceDKhTaWsB7cVVRtRWFGh4uuuCeJY2m/cUR+vWODiuFHLHP/yXczl189tc8+/ZUVTy/dwmyk92OQ+UsoI8oTYyjZdXWrOwffsvByLROf9flon1HAxizej8qKIefeBL7smvtO2nY5/XCbu4kZivsYHXZdan6ntQ5LvNGZW3RvPTZ9f8gUfHZLMLWXp5gpGWW2gDdohY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(1076003)(2616005)(6666004)(41300700001)(186003)(83380400001)(86362001)(2906002)(5660300002)(336012)(26005)(81166007)(30864003)(16526019)(36860700001)(47076005)(426003)(40480700001)(478600001)(70206006)(4326008)(82310400005)(8936002)(8676002)(70586007)(6916009)(316002)(40460700003)(7696005)(356005)(82740400003)(36756003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 18:35:07.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e6558c-ec08-47b8-4b2b-08da69b567a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
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
index 108e8e8a1a36..327166f2f35c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -512,6 +512,15 @@ static int amdgpu_vkms_sw_init(void *handle)
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
@@ -584,6 +593,9 @@ static int amdgpu_vkms_hw_init(void *handle)
 
 static int amdgpu_vkms_hw_fini(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	flush_work(&adev->hotplug_work);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 9c964cd3b5d4..2e90cd828895 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2831,6 +2831,17 @@ static int dce_v10_0_sw_init(void *handle)
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
@@ -2893,6 +2904,8 @@ static int dce_v10_0_hw_fini(void *handle)
 
 	dce_v10_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index e0ad9f27dc3f..b32acbaad293 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2950,6 +2950,17 @@ static int dce_v11_0_sw_init(void *handle)
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
@@ -3023,6 +3034,8 @@ static int dce_v11_0_hw_fini(void *handle)
 
 	dce_v11_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 3caf6f386042..1d33bb4acf10 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2707,6 +2707,18 @@ static int dce_v6_0_sw_init(void *handle)
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
@@ -2765,6 +2777,8 @@ static int dce_v6_0_hw_fini(void *handle)
 
 	dce_v6_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 7c75df5bffed..62bd00c3c4f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2728,6 +2728,18 @@ static int dce_v8_0_sw_init(void *handle)
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
@@ -2788,6 +2800,8 @@ static int dce_v8_0_hw_fini(void *handle)
 
 	dce_v8_0_pageflip_interrupt_fini(adev);
 
+	flush_work(&adev->hotplug_work);
+
 	return 0;
 }
 
-- 
2.35.3

