Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A9C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 02:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2787B2078D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 02:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2787B2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA796E891;
	Thu, 20 Aug 2020 02:49:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B9D26E891
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 02:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQa4zMu0lwMvOO0a6l+nE1MD8JlnbZ/aTiNp0ihX/jljnV7MbIF3VOE/jZYkKfwvyBT3tntLpn2MfLwcZVN/a3fQtq1mkC185TJeH9Go2fuwR0oiTJUP9lmxjuxAC4M7eS+2C6Sc9vRC7t4JbjYXgqnZGQg9Xx/eKg255f1N5VgKeCJChzGeHCn+HmmtjPiVDeR9gpla6+R7LSWSJ46bB11hV1gGqA+raqmAm7zi13OEqNIzba38glzwREBx0UrqQXAWiI3iewQZAc7PR8dnsXNld1VSPdzjWx68tZ0qnrUQdvNyXtRG+YWBDDFxuhZHaj1Pw7nm0CIzf98PNvK8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GThDi8LtqMcwlIMzVb5xJLvSYnuKl7yUg3GQdRE3VSc=;
 b=ORJW0eydOc07JrYXzC/imZlusNIpmhNlVavEtuixBqodNDZX4AwWRSRjFTUcXg2PJz0bFMq60fwi5qU3irrOCghJZZN6TWpghg30D8oZtRFqfFDo9TH+VFpm2cawvePZNyehCrCHQj2vVI1IVeGyrB0bEn+QqltBcFIeYkEN/JtAq0D/+VHbjESd4928Nimw8Z3fDawD1aZKEOaKrtMXfNfsp9YXg4zXEaANp7PWxkuF7ILWGMPVdnzEr4hDIKNUq/mXMkYTZyzadPQwYsIJG7PsWI17DYT2mge0dF6Ljt7xLBmdqTg+00sYRdG/UmGCpqw3wDtiY+cbkKHGcaIXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GThDi8LtqMcwlIMzVb5xJLvSYnuKl7yUg3GQdRE3VSc=;
 b=a56GQ4j3C4JtYaK5+Sq1/hb3JUR03QuJ2vwLkl8rPwqGYhMvwDAvJraQx9X6CyhP0vBdyOD/4U/arf7JoCMr59TKfRrUBAM00Hxciu4pVM1Hz0u6Uffl2S9l7bD9/M0JGByXbalZdXwJP0WAgx0ZlTBO8cECoDJooN1NeXrb+Kg=
Received: from DM5PR15CA0062.namprd15.prod.outlook.com (2603:10b6:3:ae::24) by
 MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:11::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 02:49:21 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::52) by DM5PR15CA0062.outlook.office365.com
 (2603:10b6:3:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 02:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 02:49:19 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 21:49:18 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 19 Aug 2020 21:49:17 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: refine message print for devices of hive
Date: Thu, 20 Aug 2020 10:49:08 +0800
Message-ID: <20200820024908.667-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c845821-9fac-4c59-ff52-08d844b3a2de
X-MS-TrafficTypeDiagnostic: MWHPR12MB1454:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1454F90A0A842B982A7F4384ED5A0@MWHPR12MB1454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: End93aeWP27vaUwHiS1r3KDFVSZ60fHny1HxBXPPIZn0EoV/HVR4Po6Xgkb853Xym2hAZJ0nDPI+GixwpCt8FjsutqN6o2qkQpHmWcrH5SremxgWIYsMTsldqu2RH/pEPymcs0m3HVrNeww3eju6JOnFupikVPLi1ZsC5Ur0RDUfqRasoU7QiQFQNURTj1gMNT8H16T0yEyOb+qUZsWkiMEsk9ckEL0wUphS3O7QCimNyJ0h0na3x28SfqWcqlPTmeGiAsJhX6C+UCjmnyZJ5NdZgtqHcsyr2wrZ9Bdqe/WPclyuYLl6fCH1DXmNeFnqcil5z7nS9R3ZxxcsOnNjSHklQ7WWOmKnyvLPpSH6o1sfB5aeIQIAJHSK7QcLUPwfn51EqQDSTWUshvvMYFufWyFySI6rZLrGWD6E94OFUDSxB3zzfq4yaSpoNgx0T0cX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(336012)(5660300002)(70586007)(70206006)(82740400003)(8936002)(8676002)(81166007)(2906002)(47076004)(426003)(4326008)(82310400002)(83380400001)(6636002)(356005)(26005)(2616005)(86362001)(478600001)(1076003)(186003)(316002)(15650500001)(7696005)(6666004)(36756003)(110136005)(21314003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 02:49:19.4153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c845821-9fac-4c59-ff52-08d844b3a2de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using dev_xxx instead of DRM_xxx/pr_xxx to indicate which device
of a hive is the message for.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 81b1d9a1dca0..08548e051cc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3370,7 +3370,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 {
 	int r;
 
-	DRM_INFO("amdgpu: finishing device.\n");
+	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
@@ -3555,12 +3555,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
 		if (r)
-			DRM_ERROR("amdgpu asic init failed\n");
+			dev_err(adev->dev, "amdgpu asic init failed\n");
 	}
 
 	r = amdgpu_device_ip_resume(adev);
 	if (r) {
-		DRM_ERROR("amdgpu_device_ip_resume failed (%d).\n", r);
+		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		return r;
 	}
 	amdgpu_fence_driver_resume(adev);
@@ -3584,7 +3584,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 				if (r == 0) {
 					r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 					if (r != 0)
-						DRM_ERROR("Failed to pin cursor BO (%d)\n", r);
+						dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
 					amdgpu_crtc->cursor_addr = amdgpu_bo_gpu_offset(aobj);
 					amdgpu_bo_unreserve(aobj);
 				}
@@ -3674,7 +3674,7 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hang =
 				adev->ip_blocks[i].version->funcs->check_soft_reset(adev);
 		if (adev->ip_blocks[i].status.hang) {
-			DRM_INFO("IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
+			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
 			asic_hang = true;
 		}
 	}
@@ -3735,7 +3735,7 @@ static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) ||
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
 			if (adev->ip_blocks[i].status.hang) {
-				DRM_INFO("Some block need full reset!\n");
+				dev_info(adev->dev, "Some block need full reset!\n");
 				return true;
 			}
 		}
@@ -3823,7 +3823,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	else
 		tmo = msecs_to_jiffies(100);
 
-	DRM_INFO("recover vram bo from shadow start\n");
+	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(shadow, &adev->shadow_list, shadow_list) {
 
@@ -3859,11 +3859,11 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	dma_fence_put(fence);
 
 	if (r < 0 || tmo <= 0) {
-		DRM_ERROR("recover vram bo from shadow failed, r is %ld, tmo is %ld\n", r, tmo);
+		dev_err(adev->dev, "recover vram bo from shadow failed, r is %ld, tmo is %ld\n", r, tmo);
 		return -EIO;
 	}
 
-	DRM_INFO("recover vram bo from shadow done\n");
+	dev_info(adev->dev, "recover vram bo from shadow done\n");
 	return 0;
 }
 
@@ -3962,7 +3962,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 {
 	if (!amdgpu_device_ip_check_soft_reset(adev)) {
-		DRM_INFO("Timeout, but no hardware hang detected.\n");
+		dev_info(adev->dev, "Timeout, but no hardware hang detected.\n");
 		return false;
 	}
 
@@ -4002,7 +4002,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 	return true;
 
 disabled:
-		DRM_INFO("GPU recovery disabled.\n");
+		dev_info(adev->dev, "GPU recovery disabled.\n");
 		return false;
 }
 
@@ -4041,7 +4041,7 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			r = amdgpu_device_ip_soft_reset(adev);
 			amdgpu_device_ip_post_soft_reset(adev);
 			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
-				DRM_INFO("soft reset failed, will fallback to full reset!\n");
+				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
 				need_full_reset = true;
 			}
 		}
@@ -4077,7 +4077,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 				r = amdgpu_asic_reset(tmp_adev);
 
 			if (r) {
-				DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
+				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
 					 r, tmp_adev->ddev->unique);
 				break;
 			}
@@ -4111,7 +4111,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		if (need_full_reset) {
 			/* post card */
 			if (amdgpu_atom_asic_init(tmp_adev->mode_info.atom_context))
-				DRM_WARN("asic atom init failed!");
+				dev_warn(tmp_adev->dev, "asic atom init failed!");
 
 			if (!r) {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
@@ -4369,7 +4369,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (!amdgpu_device_lock_adev(tmp_adev)) {
-			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
+			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
 			r = 0;
 			goto skip_recovery;
@@ -4444,7 +4444,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 						 &need_full_reset);
 		/*TODO Should we stop ?*/
 		if (r) {
-			DRM_ERROR("GPU pre asic reset failed with err, %d for drm dev, %s ",
+			dev_err(tmp_adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
 				  r, tmp_adev->ddev->unique);
 			tmp_adev->asic_reset_res = r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ebea3f655826..d6981425ec51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -743,7 +743,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 failed_kiq_read:
 	if (reg_val_offs)
 		amdgpu_device_wb_free(adev, reg_val_offs);
-	pr_err("failed to read reg:%x\n", reg);
+	dev_err(adev->dev, "failed to read reg:%x\n", reg);
 	return ~0;
 }
 
@@ -796,5 +796,5 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	amdgpu_ring_undo(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
-	pr_err("failed to write reg:%x\n", reg);
+	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ae720a6dc5a0..d84649b4d51a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -93,7 +93,7 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	amdgpu_ring_undo(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq:
-	pr_err("failed to write reg %x wait reg %x\n", reg0, reg1);
+	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9d3b1245a339..ad9ad622ccce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -390,7 +390,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		spin_unlock(&adev->gfx.kiq.ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
-			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 86f20426c4af..e1a0ae327cf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -633,7 +633,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		spin_unlock(&adev->gfx.kiq.ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
-			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
 		}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
