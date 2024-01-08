Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FB0C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 21:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1688D10E330;
	Mon,  8 Jan 2024 21:38:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEB810E330
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 21:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/KlIw6zC0W+X21UfNSiWjw9iZ0pVU8/ZMAukKRF1xP8V3wrM47+h3slTvoYGgFXw/4iajNzg5RfM1ooKPVY8BtGHA5gV2nPvTbjHvToyhe0pWt+rRrRDnbmCIbAtm0E9gtff1o+XputWkkJ8Xhg4kIQRd0nrbx83e69/6WzJDTticzHdstfPWndhnCTaHrclZmd+ubjkDLFFwKuKxnoo7timfVyvV5yvxA2BCuc8l2KfCqJcb3kjnVjpSthNnooH+I6C8/wAu/Y8sGy+sCH2lGUUgnN2ECm9c9+E6t1YQZ9EycOn0GATOyURuuvxCXPprogZ8rsXDl8qB86mXYO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNOM3Kk3AMIjgKyv3rt1WfKaU6x+Td9Jwaihlb8jjiE=;
 b=AHR9kAPexMQ5l3TxsX8AjVOSsuF33xU17PN7VMX/pYHF1UcD2SuHeOvqx7JIudLW3DOM8BmSz1fG62EkGa+6I66yI10BCSsTJqAwEPSj0PJSbtdXwQZIupa4v1usil3nIiuptkLujRgZN1YYbgxArz0CU++TNNFTmQPJwfkCO6HjDTKeJCASBJ9SDFk33Tsrrw0r0yfM2PNUWT84pZe1zXz6tIKbul1BAmgYW+f68A9b8UFb8aPuBVdMP/tI1hnY81aB7Xh9Q3kFPQotGTDfrKFOhRGu6del614Aoth0x8RG0acTCdWk4UXpei5t8Is+de+8qc23X3apyROvJqL61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNOM3Kk3AMIjgKyv3rt1WfKaU6x+Td9Jwaihlb8jjiE=;
 b=TI1a+Wa9mtSYE9JMVJTyZ5xoxr3k1fk+OEoU5nuSuy8dGw2FzQsUXGVCx48qzGzrk1puR+/HXE1MPXkHNpTKl7WQ8XOS0Q0YY2o0f2xQIpXPcKEuRLbYQSzc++vbvWZa+0g4abl2fS99GC/B1aEWVU4ItZIxASpW5vAJKuOf9Wo=
Received: from MWH0EPF00056D0E.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:12) by SN7PR12MB6691.namprd12.prod.outlook.com
 (2603:10b6:806:271::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 21:38:26 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2a01:111:f403:c903::) by MWH0EPF00056D0E.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.15 via Frontend
 Transport; Mon, 8 Jan 2024 21:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 21:38:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 15:38:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move kiq_reg_write_reg_wait() out of amdgpu_virt.c
Date: Mon, 8 Jan 2024 16:38:11 -0500
Message-ID: <20240108213811.18711-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cd2ec1-5d3f-43b2-34b2-08dc109225d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGoSrj/iWd/r3MBaAp/1/yryLMzKP5IS7A5tTFTIzRT2rKN92jA0+kHs4OWruVKoMH0c9Fb2bTY/N1cN9Y8xz2zW0Dhhon2XWkxhWcR9oW/kHoBqTl+PSFLONLaUS5KSNCJ+C9+35LPSbDud0hY68kZXjHqwvJkbITgtBtZNO2zLcnOgBBxviwcZxEfe6MlDyEGDJ0EO7ZBWJkGmHSu+g67Y201tsPmMxKIY28Cd/OrkEy7toKoMimXx3nvrQzsR6yJBFm+Ee8uq4g5oabycRia8863N6wy0gaFfGJAEwzzjXe53DA9DGpqGA6SQfEn2K//Z3iSY1E9Q59jVJNOZ5oSFr0WoFP1ufdqHhclLLOC5cGvXHL7UlcjVJJF1/GEDw3ZQjo8t8GwvutrTyst3L3edsJLUhBKHDQFJf09qSm6G7KwGFnjx2cuXpkFnYQhUQS6z6wh+yUyl8jSGzJmOZBAS8/jTVox6r4nO+x/hiepmu/AfT72d5IaU0Ymtyo2/xSXvj2+Amoa2xVsQZI0uSu6C8BNR9BRlUPxUS/IwKYugrix+Pqz+uI+YnhJUvUc70fU5h/DSFxf5zgIXuktWyNctYrqrRWGQUas2lcndGAWAtjCTWB1tcEROL3PLVaezw6JeNkmqBrYKYwTJ/Z+K6sGXQgsPPlVGUJ2fSvP+06Tq00/0ZSyMDBXzxCdMUinaOLKNnrVjJMWHBVGD+n2cpcGiYXUArbtA2Vf+R6JxOTaZmUi2vEB0D7zq9nZoPXfrYQRO6MhzCr70PYxoJUjF6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(356005)(82740400003)(81166007)(36756003)(8676002)(8936002)(426003)(316002)(83380400001)(54906003)(5660300002)(336012)(16526019)(478600001)(6916009)(7696005)(4326008)(6666004)(26005)(1076003)(70586007)(70206006)(2616005)(41300700001)(2906002)(47076005)(36860700001)(40460700003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 21:38:26.4335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cd2ec1-5d3f-43b2-34b2-08dc109225d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian.Koenig@amd.com,
 Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's used for more than just SR-IOV now, so move it to
amdgpu_gmc.c and rename it to better match the functionality and
update the comments in the code paths to better document
when each path is used and why.  No functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Shaoyun.Liu@amd.com
Cc: Christian.Koenig@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 53 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 53 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  4 --
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  9 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  9 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 12 +++---
 7 files changed, 74 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d2f273d77e59..331cf6384b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -746,6 +746,59 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	return r;
 }
 
+void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+				      uint32_t reg0, uint32_t reg1,
+				      uint32_t ref, uint32_t mask,
+				      uint32_t xcc_inst)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
+	struct amdgpu_ring *ring = &kiq->ring;
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+
+	if (adev->mes.ring.sched.ready) {
+		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
+					      ref, mask);
+		return;
+	}
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
+					    ref, mask);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for IRQ context */
+	if (r < 1 && in_interrupt())
+		goto failed_kiq;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq;
+
+	return;
+
+failed_undo:
+	amdgpu_ring_undo(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq:
+	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
+}
+
 /**
  * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e699d1ca8deb..17f40ea1104b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -417,6 +417,10 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst);
+void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+				      uint32_t reg0, uint32_t reg1,
+				      uint32_t ref, uint32_t mask,
+				      uint32_t xcc_inst);
 
 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
 extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0dcff2889e25..f5c66e0038b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -71,59 +71,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 		amdgpu_num_kcq = 2;
 }
 
-void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
-					uint32_t reg0, uint32_t reg1,
-					uint32_t ref, uint32_t mask,
-					uint32_t xcc_inst)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
-	struct amdgpu_ring *ring = &kiq->ring;
-	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
-
-	if (adev->mes.ring.sched.ready) {
-		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
-					      ref, mask);
-		return;
-	}
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
-					    ref, mask);
-	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-	if (r)
-		goto failed_undo;
-
-	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-	/* don't wait anymore for IRQ context */
-	if (r < 1 && in_interrupt())
-		goto failed_kiq;
-
-	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
-
-		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-	}
-
-	if (cnt > MAX_KIQ_REG_TRY)
-		goto failed_kiq;
-
-	return;
-
-failed_undo:
-	amdgpu_ring_undo(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-failed_kiq:
-	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
-}
-
 /**
  * amdgpu_virt_request_full_gpu() - request full gpu access
  * @adev:	amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d4207e44141f..1b49c007ff62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -332,10 +332,6 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
-void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
-					uint32_t reg0, uint32_t rreg1,
-					uint32_t ref, uint32_t mask,
-					uint32_t xcc_inst);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6c5185608854..db89d13bd80d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -262,16 +262,17 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* flush hdp cache */
 	adev->hdp.funcs->flush_hdp(adev, NULL);
 
-	/* For SRIOV run time, driver shouldn't access the register through MMIO
-	 * Directly use kiq to do the vm invalidation instead
+	/* This is necessary for SRIOV as well as for GFXOFF to function
+	 * properly under bare metal
 	 */
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid, GET_INST(GC, 0));
+		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+						 1 << vmid, GET_INST(GC, 0));
 		return;
 	}
 
+	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c9c653cfc765..6c68135cac9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -223,16 +223,17 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* flush hdp cache */
 	adev->hdp.funcs->flush_hdp(adev, NULL);
 
-	/* For SRIOV run time, driver shouldn't access the register through MMIO
-	 * Directly use kiq to do the vm invalidation instead
+	/* This is necessary for SRIOV as well as for GFXOFF to function
+	 * properly under bare metal
 	 */
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid, GET_INST(GC, 0));
+		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+						 1 << vmid, GET_INST(GC, 0));
 		return;
 	}
 
+	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f9039d64ff2d..9bff72356a37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -829,23 +829,25 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
-	/* This is necessary for a HW workaround under SRIOV as well
-	 * as GFXOFF under bare metal
-	 */
 	if (vmhub >= AMDGPU_MMHUB0(0))
 		inst = GET_INST(GC, 0);
 	else
 		inst = vmhub;
+
+	/* This is necessary for SRIOV as well as for GFXOFF to function
+	 * properly under bare metal
+	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
-		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-						   1 << vmid, inst);
+		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+						 1 << vmid, inst);
 		return;
 	}
 
+	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	spin_lock(&adev->gmc.invalidate_lock);
 
 	/*
-- 
2.42.0

