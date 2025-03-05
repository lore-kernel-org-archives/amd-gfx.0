Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A99C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCAC10E002;
	Wed,  5 Mar 2025 20:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZrJ3TEuo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A94610E328
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW4AvHwwM8mTFIOcqmQ3sCSA1jUseR4qcYwtiPiu4YzpzEyaGGrukWBFe3ef54XYddpqwTPzTM1kRA7dcWwAR83GiIBYyDDlkzT3GrTQlYBk8oxcB+35fe1ez6bfTIcR4VBzhdGZW3vkTNrNg1dYM+sWJ7aCwprq7a8hKL+Kx3evOGHbxvH9x/JLRJGTWWvgRHXRX3CLHCUQx/KIpAKBnqWB9tHLDj7U+3Hy2QN4Su7YjzIF90mx/MJICQgqBolYsaUjLLpaEXQYG7cuoHXpB5ugNevmH4xTmxfyFIezb5Pp8P1HrdsVQOzS55m5TMwK+XbDrawrSlSOBr67I5weMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pEAdS17UvgPcn7uZrUuTdz4d6nVdIPH8G44H5SHGhQ=;
 b=DqJtY1TUrQtCgnVEPiizClRNd8wwRvS9meh3buSyR1Ili1Uu65dByU4Ekz2GqimFc7JrMTlovJWGbNdn/qN0hkULoPo1dDyoxQ1pMtiaDpyDj49pl6toGG+UsRoyrNSrgXy6i5vD5KwhWEHYts82NgJ3+2cLD5aXEoik9u/AGc7oWHSd9xYcOkYOgBmzx3vQFPstoU6eLCXr+UUpg49OPIpxofyhUxyLyiBS4q9CdFgefLzE4uy9GFAg+s0OL1md3Abn+5ZxmjDFl0p9wE3d/1x8B3s80mEJ6/voTZq5kjkC4yjbYvs+Ny26ghuDha0Cr0Vj7DPv6YnxZUTyR7+wqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pEAdS17UvgPcn7uZrUuTdz4d6nVdIPH8G44H5SHGhQ=;
 b=ZrJ3TEuoh6wFKYUI70NbIQ2JX/fBL9fc+BKydKPYr/LdXdf6sZSO5GY9wYOGdGbKgA/jVLImffCF/zMmxcqrWQGFQGDKc1UNQ8/GZAlXX8X8n15+m3YF3mtBL5igrffSPCXZryVcl+w5Kb2iuPOMnWlVlmnOIV1Os7MMYBtTy4Q=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 20:47:38 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::c1) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 20:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Date: Wed, 5 Mar 2025 15:47:12 -0500
Message-ID: <20250305204721.1213836-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4261da4e-e471-4e6d-2e95-08dd5c26f749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y2ZelrdmN8LQfrDy7Vz2fpuh6xvUGJLy2jVrgfqv2LOSfhfXau9/zt+Ei012?=
 =?us-ascii?Q?IER5bc/LPvijvOqpXSnjdZr/s2IBjkbNLFv8sgFWbVFF8WK/Z3iKHpYBX4SG?=
 =?us-ascii?Q?Yd4sZB6sBcHtnB+6/22y2Lws6qwegTRK//tLBxSUIJxef8bZGAHIBMpXQCwC?=
 =?us-ascii?Q?q8qkZeF4F+GrsdcbgBJaV8FA3WgPZdoN1yX0DJD48BLMrVrTkcSckFS41mqC?=
 =?us-ascii?Q?Rqzd8yAz69mLL2U8Cbeu+Wnc3SWzqPaRi2ybtQ+CwTBw+PmozYf7CfLXgChL?=
 =?us-ascii?Q?U+4iL+Eluj7+275f9cSQrh45RdcesR9fnMF9hMW8LxX6UDQyyzbZtYfMP2xh?=
 =?us-ascii?Q?mrQd6b7VFNBKY85nFJ1kF2AxdlN0887oY9AstlFaOfURFQNw5ecDidT9biGI?=
 =?us-ascii?Q?sVRygOYopFFloAeESIpXOFxzVnSdL2c8JhetTTuHoU7LV3oAFhx6K3I1Pvv8?=
 =?us-ascii?Q?PiGOLzV16UKXgQ0G8sUf0J/Ql7eQliNWB1huAE8DO2waxMCMZkx4AC0uDbcZ?=
 =?us-ascii?Q?AFExI1TfzBPR2Ta0LQ1GUxCXZz/SpE74esAn/9mczBspY+JwzcztiNVsgcc7?=
 =?us-ascii?Q?Z0LCTep/IonZvr30P8yYxZBcBTfpWqUanBewPF7PRdeIbR45W89P8Jv2+NQy?=
 =?us-ascii?Q?3+/ZoMNIeGtrWhCt4oZSunF89+mlFpi9gUTIYaK1SB83hYkbMzPHthTFuIok?=
 =?us-ascii?Q?o2xoGpFN4PIK0aGzHl0qoapw1BHDjoNg1ajmf3okVAz6BUaj0PDsGwOQ5MSe?=
 =?us-ascii?Q?vLSVQ5X5u+7bLPH5ayVr6j47MgxF6HBxnRb7WicH0+q3nzmQtmJZbIbsN0iN?=
 =?us-ascii?Q?kLln8sLrpgQQ0Dpce4Q+CWhM50fFc+BHHD3kdtyU0FoHiRx0yfFtHinx/G1m?=
 =?us-ascii?Q?ZucBlkLmOfSZF+Td3MLraGzMDosuqiLUbJVfypcTfLhJThvwTJj3RKehFkOU?=
 =?us-ascii?Q?jeaNV1Ej7BFYj6ENKdox6fpkuc1xRPnPzRAa8QkMqImHA5z/StZ1dl4PvEHv?=
 =?us-ascii?Q?zaGnJpfYshvbM1Irxf5LwWNePcj1vtYklqsl2q7v56PVTx11qzqDM5zLPl7j?=
 =?us-ascii?Q?AQIYB1CMo7aSvutsEPhq5+OrsLomm3//EleZnbUp0+ctcNzndKhSxsEhaFnr?=
 =?us-ascii?Q?lk0PhDXIl0G0q8YZLEcjpFv6yZ99x23GzaAE8RD7l8Dby5qjMhYuHud/by+/?=
 =?us-ascii?Q?1SJpYA3z4plYBLZckpKsVv1XDMP1KrPDtVc6JCcsdhj6qBM+QCv8e46G5F2+?=
 =?us-ascii?Q?9kDVRf9kdjU55vnO0HT0a3/EZitQWO4CwW0JCrb60hd3RzMNG5OxDFRNB5qX?=
 =?us-ascii?Q?WTuvgSgkpwN5F6dfOnVH2Q8FxfTswSeSOA8hh7eGsufVzzM9T37TB+C75DlS?=
 =?us-ascii?Q?U8CaKBtygkH3lOGjmkOtv6vWzK0ywOr9Wej7gVAh9PhgJCf1jNV0uyeVGVrC?=
 =?us-ascii?Q?em3oHeQ7dn9Wm9Boav9u7rFBnfQqPP+kJIvzVbQIeiEVUZQyzWwnbfldlx9Y?=
 =?us-ascii?Q?dfq0kZBhGkCOnxc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:38.1884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4261da4e-e471-4e6d-2e95-08dd5c26f749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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

This would be set by IPs which only accept submissions
from the kernel, not userspace, such as when kernel
queues are disabled. Don't expose the rings to userspace
and reject any submissions in the CS IOCTL.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5df21529b3b13..5cc18034b75df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	ring = amdgpu_job_ring(job);
 	ib = &job->ibs[job->num_ibs++];
 
+	/* submissions to kernel queus are disabled */
+	if (ring->no_user_submission)
+		return -EINVAL;
+
 	/* MM engine doesn't support user fences */
 	if (p->uf_bo && ring->funcs->no_user_fence)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_GFX:
 		type = AMD_IP_BLOCK_TYPE_GFX;
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-			if (adev->gfx.gfx_ring[i].sched.ready)
+			if (adev->gfx.gfx_ring[i].sched.ready &&
+			    !adev->gfx.gfx_ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
@@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_COMPUTE:
 		type = AMD_IP_BLOCK_TYPE_GFX;
 		for (i = 0; i < adev->gfx.num_compute_rings; i++)
-			if (adev->gfx.compute_ring[i].sched.ready)
+			if (adev->gfx.compute_ring[i].sched.ready &&
+			    !adev->gfx.compute_ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
@@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_DMA:
 		type = AMD_IP_BLOCK_TYPE_SDMA;
 		for (i = 0; i < adev->sdma.num_instances; i++)
-			if (adev->sdma.instance[i].ring.sched.ready)
+			if (adev->sdma.instance[i].ring.sched.ready &&
+			    !adev->gfx.gfx_ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
@@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
-			if (adev->uvd.inst[i].ring.sched.ready)
+			if (adev->uvd.inst[i].ring.sched.ready &&
+			    !adev->uvd.inst[i].ring.no_user_submission)
 				++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VCE:
 		type = AMD_IP_BLOCK_TYPE_VCE;
 		for (i = 0; i < adev->vce.num_rings; i++)
-			if (adev->vce.ring[i].sched.ready)
+			if (adev->vce.ring[i].sched.ready &&
+			    !adev->vce.ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
@@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			for (j = 0; j < adev->uvd.num_enc_rings; j++)
-				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
+				if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
+				    !adev->uvd.inst[i].ring_enc[j].no_user_submission)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
+			if (adev->vcn.inst[i].ring_dec.sched.ready &&
+			    !adev->vcn.inst[i].ring_dec.no_user_submission)
 				++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
-				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
+				if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
+				    !adev->vcn.inst[i].ring_enc[j].no_user_submission)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
-				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
+				if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
+				    !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_HW_IP_VPE:
 		type = AMD_IP_BLOCK_TYPE_VPE;
-		if (adev->vpe.ring.sched.ready)
+		if (adev->vpe.ring.sched.ready &&
+		    !adev->vpe.ring.no_user_submission)
 			++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e9..4a97afcb38b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -297,6 +297,7 @@ struct amdgpu_ring {
 	struct dma_fence	*vmid_wait;
 	bool			has_compute_vm_bug;
 	bool			no_scheduler;
+	bool			no_user_submission;
 	int			hw_prio;
 	unsigned 		num_hw_submission;
 	atomic_t		*sched_score;
@@ -310,7 +311,6 @@ struct amdgpu_ring {
 	unsigned int    entry_index;
 	/* store the cached rptr to restore after reset */
 	uint64_t cached_rptr;
-
 };
 
 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
-- 
2.48.1

