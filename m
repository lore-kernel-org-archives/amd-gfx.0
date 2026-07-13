Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC86C4450C
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7300910EAAB;
	Mon, 13 Jul 2026 18:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpFR4xMb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7123410EAAB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVKfd4EYXvboEaLAj8U7nClxY98W/dP4yVIo+g/rAnVIoSQ5balgfPeAcrQydaA65g9bmisSbgoHiv8Y1T+7glmkgcOwkoEjtTVn8r85o/uyol4c540+wjif+HxOu/NAmZMJU3MzpwVpJBgNEd2mw9rKTKc3jWmBfnYgHyrO3hZ5gG5TXVyNf3oo44n4zH230EFlbCVyXHyF0I9arifx/m3E/qTGuqxRMeMIPoIxSSGAN79OmtTb1xrcFBoNW0YhaLCzJ0yIs6XEF7aVo8f1brW4gjEFc1bQCUubdiNHorx6EwfTIMckCcOc4vOIjQgi9Jpr3gV3CWaH4VbXc3j38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb2ZqF6QUGx+VfRCc4up23+R2ig30FZ2Cr3fltiQcjg=;
 b=JSd+Dfh8R063SabizJid39PX8acyQ0ajhXrtoCWgou662FlzeH1E0u+FpocZ9jVmTZ5rsSS3Y/Z8j8ETTNRdVlb/ZX63s1WU/Sl9dE1WI2SZSFeLwI84QIXKFI+p0+ySQUJ+t3MY4+YjPmS+T/n193rPHxGi8VJ+sqXZJbZ37Tl2z93SM4YwVtlvY2PB5tYcrdrZWg/auyy7Wj2+mJLGCYHqjLnzq0tOrYqq/R7uL7tX/cjCUJNg5VkMzFKEbHPoTf6fk3EWGmfdO1iORG/OnVpvhXJbuJPmKDQUICcav1DU8orRt+U97IZ5F6FYIFeUegqpRO6r1cBN+pciw++A9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb2ZqF6QUGx+VfRCc4up23+R2ig30FZ2Cr3fltiQcjg=;
 b=wpFR4xMbqBkPMyOizfDt9eK/o4Yfw+kr8NVnB6DmlVBRJWBDoVHj+mnOWAFqZ1Tz7zcB3Cm1H3eG6NQA0WFouD3AqUYQsY0JQ4HfaXXPcgLeUwvYqXl9D+gUVN455by+F5fa4s1op0RD4EjrP+kvVrad4Ogcty64l0E2daSO1qI=
Received: from SA9PR13CA0038.namprd13.prod.outlook.com (2603:10b6:806:22::13)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:48 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::a3) by SA9PR13CA0038.outlook.office365.com
 (2603:10b6:806:22::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 18:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/14] drm/amdgpu: add core helper to do TLB invalidation via
 SDMA
Date: Mon, 13 Jul 2026 14:27:28 -0400
Message-ID: <20260713182732.630947-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: e69b9b03-35cb-4fef-c14a-08dee10c70bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2gIihnQ2Z9UO7Mlsp6cu1DbNHIZPx2BdP9B+bkTl03FBkw39XQ56Lsi9GXuUFt0ElbZwWL/RPSHMrpLVA72g+PhMDr/bGRT1fGpbwQaAw/NQVNFMFEWDpbIICqRqpNe03mhWcNYVHdiqJn+nVDsqwPsVyHHX0nz8pWtihfpV6rpZXI+BOc62fXuGE7zPFCvQpDBvHiqD1Myonpqn5pyhj5wSklgcTDBRH3bl/wAiaST8unxGGk0nQueyZj11viUOixeBPxxcPLUfViEGsQ4IfHWhSDCbEhdIC7w1fXWGcQa2p3sea8SGAjp7WyPPyfS+U/cd+JifL0uFFo+RGiuHeFbZkfhVfUi1lfenwkSxKRNz3XpjtW3C7mWIv6kswUPiJ6BwbvEvNJ4kmhNCma7eU+OV7jGZPxR0Ozdag5tlGyhIvxEi++FIz8s+UYLooO9sWdiSFa063Et56mtVSVn39JLhuHZHyedDwij30RHOPYylj1Cz0iLaadxpdSnVzKbRO62J8B/zta2k9e0dFcsZOGb+GX/4/+N+nkCCVW2tHO91/S7WSSyQFSN0XSvxxJ6rrMJxLMBFOdOYGhhHcdxXFs6gQJk+/V757Kux3ZdCt+KJWT5q8iiTn0o80PeJj5GN/URANmeoFkR9irr3L0GBrRFZYLvM3r0ApVaZg3Km18KrhNK/xyMOnXOnmpKHJUFIMJlCrA7I/rDlmG9Pi33mzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l6BNZ66xyNTaGOwDWUoTtHOtnKAoUQaNNg0/SUvA4Qc9YfOJ0OIE597iV1DmYtppL5hpDvAidOpsEIrZKwMse3kWigjgsSh5B1Tta9dj0i2qLT4qdyURlmP8OlwdmJX7VtflXUt9Fu5q7Y0vhmOEVCEuOsl9dYcDiCoDlvAfi4CZiHjbl469pFvQTScJDDnLCIefcKbsk2Uhdyoipx2JeCpviMN9wLlnc1kJpez2n9jByX7DNOXLnOLfuGe70m4OcNiKZoFpEOhDXsICPVv5ymHmkovsFyVxknjxspnA62aNauS/ExzXi1KNy2aBB9YnwdKC+mVxkWSdOsEEP2iTZfdYnGwqV3XJr7JCXLXt//ir9yvGfCBhdsPmzE0eebpbMRnyohUY8Oppw2zT4cMlxPoPySY2tvb9um8SU/b+PnTOrARlV4LZ6bN1YBP6WELO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:47.9806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69b9b03-35cb-4fef-c14a-08dee10c70bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

Adds a new helper to do TLB invalidation using SDMA.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 36 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  6 ++++
 4 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3f0b1b7a557b9..5c1237a30b865 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -928,6 +928,42 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
 }
 
+int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
+				    uint32_t vmhub, uint32_t flush_type)
+{
+	struct dma_fence *fence;
+	/* Use register 17 for GART */
+	u32 inst, eng = 17;
+	int r;
+
+	if (AMDGPU_IS_GFXHUB(vmhub) && !adev->gfx.is_poweron)
+		return 0;
+
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = 0;
+	else
+		inst = vmhub;
+
+	/* flush hdp cache */
+	amdgpu_device_flush_hdp(adev, NULL);
+
+	mutex_lock(&adev->mman.default_entity.lock);
+	r = amdgpu_ttm_tlb_inv(adev, vmid, vmhub, eng, flush_type, inst,
+			       &adev->mman.default_entity,
+			       NULL, &fence);
+	if (r)
+		goto exit;
+	r = dma_fence_wait(fence, false);
+	dma_fence_put(fence);
+	if (r)
+		goto exit;
+
+exit:
+	mutex_unlock(&adev->mman.default_entity.lock);
+
+	return r;
+}
+
 /**
  * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 3ca187f5ade85..0135be1418a91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -450,6 +450,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
 				      uint32_t xcc_inst);
+int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
+				    uint32_t vmhub, uint32_t flush_type);
 
 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
 extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 74ada995bd8e5..03e74b7ca0003 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2513,6 +2513,48 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_ttm_tlb_inv(struct amdgpu_device *adev,
+		       unsigned int vmid, u32 vmhub, u32 eng,
+		       u32 flush_type, u32 xcc_inst,
+		       struct amdgpu_ttm_buffer_entity *entity,
+		       struct dma_resv *resv,
+		       struct dma_fence **fence)
+{
+	struct amdgpu_ring *ring;
+	struct amdgpu_job *job;
+	int r, num_dw;
+
+	if (!adev->mman.buffer_funcs_enabled)
+		return -EINVAL;
+
+	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
+
+	if (!ring->sched.ready) {
+		dev_err(adev->dev,
+			"Trying to inv tlbs with ring turned off.\n");
+		return -EINVAL;
+	}
+
+	num_dw = ALIGN(adev->mman.buffer_funcs->tlb_inv_num_dw, 8);
+	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
+				   resv, false, &job,
+				   AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
+	if (r)
+		goto error_free;
+
+	amdgpu_emit_tlb_inv(adev, &job->ibs[0], vmid, vmhub, eng,
+			    flush_type, xcc_inst);
+
+	*fence = amdgpu_ttm_job_submit(adev, entity, job, num_dw);
+
+	return 0;
+
+error_free:
+	amdgpu_job_free(job);
+	dev_err(adev->dev, "Error scheduling IBs (%d)\n", r);
+	return r;
+}
+
 static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 			       struct amdgpu_ttm_buffer_entity *entity,
 			       uint32_t src_data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ff9e2e3466099..f6a69c5a5ee86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -195,6 +195,12 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
 		       struct dma_resv *resv,
 		       struct dma_fence **fence,
 		       bool vm_needs_flush, uint32_t copy_flags);
+int amdgpu_ttm_tlb_inv(struct amdgpu_device *adev,
+		       unsigned int vmid, u32 vmhub, u32 eng,
+		       u32 flush_type, u32 xcc_inst,
+		       struct amdgpu_ttm_buffer_entity *entity,
+		       struct dma_resv *resv,
+		       struct dma_fence **fence);
 int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 			    struct amdgpu_bo *bo,
 			    struct dma_resv *resv,
-- 
2.55.0

