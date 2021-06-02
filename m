Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB9CC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 19:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6372960FEE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 19:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6372960FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8C76E20A;
	Wed,  2 Jun 2021 19:18:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BA46E20A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 19:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgmHj64s0yTlI9yWPHiFmtGKUBdRNKUKBEB27mI8xTmu+DafiT/Mm7Bozf9HJAFV/2y+rrEoN/rIrTRuiiKQ2ppZKSLcVtunM3cyHX4hEcXhVg0dAPencv4cjruZ5ho23kOJK8eGXq4ZjqEUMrCu0ljJRyDPpaYQz4POwy9/ZS4wKf5fywaig1L4Mear/j8RykndJtieY8RVzdyVmwbls4yqs0DIVyHYm6BLGUKp5H7d8gIp3I1FgLKakMCSSC6tYcna038V1fvpMZSAOA3FDv2dAk+3lLhuetxmx1ZLV0E+aqkcy4Ij75CTWtLiKmh7XvJChhYKI7YyNeblnvoPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcnj+bnqoY6dS1HTbsjqmONlvFEEQ0Lvhsj/yO+gD1Q=;
 b=mav0C7sZaPeNCitk4iKOH+aLJzy4uZtlYpSOpRvC+rzvyKnfgaNgM0oA46OddCkDaRy9mrzWZTd4zY7t7u5AKOnUqtux3sUodGKG3gUwcOOhEoauDbnP8IOcwJG2w43x9SQUPhPo1soyNnLnA0CcxotFOFEuh/7SW8cuP3qIGFxXbohWx4ndcnSSDKsuJ3lprD8lr6hKOPaqPq9Qb587ygwh/GXFO+Zf9jNZO/g/+KO78JH4I2ZGlt+G7pfWUu9zQ3oHZy1TiaZnfP9cap14f8uyB2hf0SMEPZTNvPqUuoeknV6K8c03sQtfjB3CI7fBnIztv4U5PW1F2jiYZ/Mdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcnj+bnqoY6dS1HTbsjqmONlvFEEQ0Lvhsj/yO+gD1Q=;
 b=TXJ3qZSDGQ79WVRKOEFk2A+kLdt9M5yajIyvHTSXTOyX32QGktohqqzYgaFxoAUowftGX8VuFLNVHef1bH7gnP9oCATfh4okX2tHNrd4fhAL4fkepdxugTyD6L4lSscJaM4AQGabGQGPQCBLsJDEZd7cjjDENVIczEoPvpogarg=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 19:18:36 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::f2) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Wed, 2 Jun 2021 19:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 19:18:36 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 2 Jun 2021 14:18:35 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: Don't flush/invalidate HDP for APUs and A+A
Date: Wed, 2 Jun 2021 15:18:20 -0400
Message-ID: <20210602191820.837871-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11bf1bad-bdbd-4740-c200-08d925fb38aa
X-MS-TrafficTypeDiagnostic: SA0PR12MB4448:
X-Microsoft-Antispam-PRVS: <SA0PR12MB444832345CBFD4184DB4934F823D9@SA0PR12MB4448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:38;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lquSIrz74kmEMbHVNZPUH5sdnUBpSelzJr0uLEgG9/Tf2qtI/fmiliw36Mh1oSAWnoCQM7HTJNr/sryaA8nXuvkPn9gFQLi+62fQ4/dxBAB1CfCa0qPex0T83Uky+ian/7Ka8GbDld5VBLquKtifSPpxp+UDVi+uyNmOZWIMRu0TBdhU98pTh6J1+d/6AqGUIgGRZWAuKjx9CznTTwjW1Ux3j9WNtbqDcwoWukoJGX07JXzoQUB2+OuuYVvGgedheYcAy05SOtsFHwVccSgtLxl/kVn+vXPd1w4uGoy4wKSKGYtA3X5KOr2Ptlm4vYxX2PAfCjd1vH37lr5NZmqMyL/q+OMREG8x33s3tV9z9h+RIe3jYLjnJQNyEDjpTMd3xGq6pC1QRB3ELYCLt50Qq7R/ZgHNJi2fQGcZ0zrPl1q4OmcJsB3ZUKpZl0CQosu4o+ZQPksmNJoqB9RLTW0rLAkoA4kZyPfRTlCJNrUUHWyik/fQKtiURyZg5CuNTupvmpJJT4LjRgWqSe3V41fLfO6Y1/2E8xsaq4QxQNhRjAcs5u/qNhbD2ce8Lt6C0RHGhM6pDExiNjd1ahZKESsMg//6VZGUnPKFhqdUUP/c63PE/n1m153Sd8kee7L9DnbumJXkK85aR6Os+jTAEw5r4SgQMN/Dt9DIiGmjmtFJoGIl5Wb2Krxwkl1o62NqVws+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(70206006)(83380400001)(4326008)(47076005)(81166007)(6666004)(16526019)(36756003)(7696005)(2616005)(86362001)(70586007)(26005)(5660300002)(426003)(336012)(2906002)(498600001)(82310400003)(6916009)(36860700001)(8676002)(1076003)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 19:18:36.5740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bf1bad-bdbd-4740-c200-08d925fb38aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Integrate two generic functions to determine if HDP
flush is needed for all Asics.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 15 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c |  2 +-
 7 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7533c2677933..2d5dac573425 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1348,6 +1348,11 @@ int amdgpu_device_baco_enter(struct drm_device *dev);
 int amdgpu_device_baco_exit(struct drm_device *dev);
 bool amdgpu_device_is_headless(struct amdgpu_device *adev);
 
+void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring);
+void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring);
+
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
 void amdgpu_register_atpx_handler(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4c61a67d0016..900c2dbce934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -697,7 +697,7 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
 
 void amdgpu_amdkfd_debug_mem_fence(struct kgd_dev *kgd)
 {
-	amdgpu_asic_flush_hdp((struct amdgpu_device *) kgd, NULL);
+	amdgpu_device_flush_hdp((struct amdgpu_device *) kgd, NULL);
 }
 
 int amdgpu_amdkfd_send_close_event_drain_irq(struct kgd_dev *kgd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9c4d33f649f7..7f687ea58834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -362,9 +362,9 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 		if (write) {
 			memcpy_toio(addr, buf, count);
 			mb();
-			amdgpu_asic_flush_hdp(adev, NULL);
+			amdgpu_device_flush_hdp(adev, NULL);
 		} else {
-			amdgpu_asic_invalidate_hdp(adev, NULL);
+			amdgpu_device_invalidate_hdp(adev, NULL);
 			mb();
 			memcpy_fromio(buf, addr, count);
 		}
@@ -5548,3 +5548,32 @@ bool amdgpu_device_is_headless(struct amdgpu_device *adev)
     /* Check if it is NV's VGA class while VCN is harvest, it is headless*/
     return nv_is_headless_sku(adev->pdev);
 }
+
+void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring)
+{
+#ifdef CONFIG_X86_64
+	if (adev->flags & AMD_IS_APU)
+		return;
+#endif
+	if (adev->gmc.xgmi.connected_to_cpu)
+		return;
+
+	if (ring && ring->funcs->emit_hdp_flush)
+		amdgpu_ring_emit_hdp_flush(ring);
+	else
+		amdgpu_asic_flush_hdp(adev, ring);
+}
+
+void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring)
+{
+#ifdef CONFIG_X86_64
+	if (adev->flags & AMD_IS_APU)
+		return;
+#endif
+	if (adev->gmc.xgmi.connected_to_cpu)
+		return;
+
+	amdgpu_asic_invalidate_hdp(adev, ring);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 5562b5c90c03..0e3a46ff38e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -250,7 +250,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 		}
 	}
 	mb();
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 	for (i = 0; i < adev->num_vmhubs; i++)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 
@@ -328,7 +328,7 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		return r;
 
 	mb();
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 	for (i = 0; i < adev->num_vmhubs; i++)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index aaa2574ce9bc..b0ba8376dc33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -222,15 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (job && ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
-#ifdef CONFIG_X86_64
-	if (!(adev->flags & AMD_IS_APU))
-#endif
-	{
-		if (ring->funcs->emit_hdp_flush)
-			amdgpu_ring_emit_hdp_flush(ring);
-		else
-			amdgpu_asic_flush_hdp(adev, ring);
-	}
+	amdgpu_device_flush_hdp(adev, ring);
 
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
@@ -267,10 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (job && ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
-#ifdef CONFIG_X86_64
-	if (!(adev->flags & AMD_IS_APU))
-#endif
-		amdgpu_asic_invalidate_hdp(adev, ring);
+	amdgpu_device_invalidate_hdp(adev, ring);
 
 	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..f21603a9d07b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -277,7 +277,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		return ret;
 	}
 
-	amdgpu_asic_invalidate_hdp(psp->adev, NULL);
+	amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	while (*((unsigned int *)psp->fence_buf) != index) {
 		if (--timeout == 0)
 			break;
@@ -290,7 +290,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		if (ras_intr)
 			break;
 		usleep_range(10, 100);
-		amdgpu_asic_invalidate_hdp(psp->adev, NULL);
+		amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	}
 
 	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command and PSP_ERR_UNKNOWN_COMMAND in SRIOV */
@@ -2696,7 +2696,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	write_frame->fence_addr_hi = upper_32_bits(fence_mc_addr);
 	write_frame->fence_addr_lo = lower_32_bits(fence_mc_addr);
 	write_frame->fence_value = index;
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	/* Update the write Pointer in DWORDs */
 	psp_write_ptr_reg = (psp_write_ptr_reg + rb_frame_size_dw) % ring_size_dw;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 03a44be50dd7..e3fbf0f10add 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -110,7 +110,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 {
 	/* Flush HDP */
 	mb();
-	amdgpu_asic_flush_hdp(p->adev, NULL);
+	amdgpu_device_flush_hdp(p->adev, NULL);
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
