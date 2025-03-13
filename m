Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A59BC35FF4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5585510E8D9;
	Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bRReryYN";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4199610E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhZEi7urpm5yG73aDolirTaaCSdv5I1aUHjUZt/y1+NUPA/ihNtIQmceGEQvcMOKLYFiuIfvzJHgvnZbpeQYqDfi9GpOAxr+JrmaHI8v2hNvmW+e6P6T0s9nYkA6bONvnTAZ2DWHgFMKL3OExqS4ImPyvAd+PfK31wm6JaWBJQt0brv6IAVdASen4filCkh9RABAirTt0d/dCsDhyau0W5nlvEU5DdBAnJqM01jdPOAvEkHPn01DjATxwSj6E1s/I3l9aqh0TYh8Zj/kn7dKUMHlhbtjZSzFQzDxdFrTuKeKIr/B/NESyopd4qJQnJbOgzDbrYHkLrUq8DV9Pv2fLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLqMimFHlkya5+8BLYW3w9jPVLmBVdCdNqOneyxZhxI=;
 b=yLGGINWIvTufbLIqCNIO8HKErH2f+C5/IVqJVhQP70cM0ILQJED2Ko45zsMNFzTf9AUQRMTHWp3UyfH14sK0PSayZNVTyDN/aT43YlmAqembX2TjB9hM0QiF5MB2sSiWCgM9xHKWMkt4Zm7mQ8D0ab9vBtFwD1T3WGaCQd8Riez86m3b2A3BsEgfvH/Hceu1aqJDRrTIo6YGimUkTDzgFaDsN9Qj1WuqVWv3TbS3iCqRyt99qVdaAVPCKWeMOL7jJLu6mAM9w09FucD07lZm+LCMCImAf0wAmtsRR2wOebCJQlWuKNHOF6wW+xhuwQvxdMDaibDiUE97oYJPXOphCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLqMimFHlkya5+8BLYW3w9jPVLmBVdCdNqOneyxZhxI=;
 b=bRReryYN9eASh2GpisvQDb0jg7BvUX5m65PnoqtkZrNp7hb4qaQ29t2CIB8Iv7X0xT6xSfPgh6/RWTYETY4aFDBjXE513EoXdjCkpDyy0C+KTBJu2KwfuLWnJWqIQvJ/wN8uM/FeY5uCTV4SxedtOMUfhyLHXmHDQi30h+G3pPs=
Received: from BL1PR13CA0353.namprd13.prod.outlook.com (2603:10b6:208:2c6::28)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:41:54 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::f3) by BL1PR13CA0353.outlook.office365.com
 (2603:10b6:208:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Thu,
 13 Mar 2025 14:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Date: Thu, 13 Mar 2025 10:41:27 -0400
Message-ID: <20250313144136.1117072-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c19059-d8a7-46df-4fe9-08dd623d32ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?znkd5oOBz/ItvfuwI7kOu6TsAivMGM9JYShFU7yVudjDDPAI5sodIG+HFC1k?=
 =?us-ascii?Q?+iXcFX/YEdkZCOjdEOH7v9TtnPeX1pD3ytM7F0JHVwFX2t3hB1fDAeLTN1VT?=
 =?us-ascii?Q?n0MOeYtWvF/6AnJYQKhAkZFDg8H8pDqeEBV35j5bLm/m4i6l4mtamdAqm2Qb?=
 =?us-ascii?Q?rvUFuMnqMPseInAXufYEO5AS/cIB78sI0lQkWVxGcd8GQxxq+szXqlVT+RRm?=
 =?us-ascii?Q?BS2i98SvXCWovFp2Slc4hrsNwzIMp6ZJvRgJeoM86TruvDSWtOq92HwRzY32?=
 =?us-ascii?Q?jOmpB3foxqOhTF44QuorHNbfmBrgdbE3Fa4cITKDyZOJobWqXCjRPJAlumaD?=
 =?us-ascii?Q?W9riBAdNxUXsErTOow5SkyvZhFTofeCYxIicJ3Ew11W56Qr+rRWug8Qb0q7L?=
 =?us-ascii?Q?RJGNBP9JxlwHpP9+o2Zi1ZP8sukCqPAETaX5RLp62qIvhVxhAe2aHwpvPCeD?=
 =?us-ascii?Q?D9uxymqcfnDgBd2I6objCvmLotMyolM3TXYzRJdpSe2zKgZM2vpkhPYHMKM7?=
 =?us-ascii?Q?YXPY3t8v1VSlT02K1UWeK69XsUukWM9dsrWdmzvjA14dRaO38PLkUW+ycdXD?=
 =?us-ascii?Q?AHeybX/XldZYJF4aVmTZ9UERjXLNVzXghEUc/UjbbA3Mlc0ClgHBjNhs0Ezw?=
 =?us-ascii?Q?2DChwPMC1WxDcq/iwHYtQkxBwGYLuKt/sqKPzYVzI/BnxF8hH5+Fvnt5i7z9?=
 =?us-ascii?Q?e+pbbwof3XxykYq0U7WESaMi7lPKIoLKj8OLT/+5sxOD0ok/LV+pBMos+AUX?=
 =?us-ascii?Q?1nUvKOXT+eyRAXkjrJKR5eOuyBmQKTd/sPcXMEHTsE239rhX2wsC8P9Oqkpp?=
 =?us-ascii?Q?R70Q+tZJCSZEnHq0H0iRoei9QZxYeu46Hk6xTynByFSSII7fiq9S8Q7kl0UY?=
 =?us-ascii?Q?1lRSRN2tBtZJW92CLIPqe+lQ0BCHX2mvHEcCZcTQf5E6vcVtC4le/GANadVp?=
 =?us-ascii?Q?N/bgutGKG0DcoUNElvqyuKjj+SxP5JjGpWZ8lI0lO8zTqbQjmYNfAO7nfCX/?=
 =?us-ascii?Q?4lvuqiloP3+wTyJ/+NvMQY+rujmZ4/hGmCSakAphgBsVl6WkKyCXni/8n3rb?=
 =?us-ascii?Q?2ABt48KpVd222eKXDNcj47lIsT8lInzSvSlTahKo/pkrhPa8LBfmcMTILY8H?=
 =?us-ascii?Q?xlb5EFZlMSDet0H9u7AiyjpuHrqbWKw527f6HtqiQozyDDcQLZTDqnuL9zt4?=
 =?us-ascii?Q?M8F4EflgXEqkWYvwYhKSSonyzIiAcJH6j36IDekRLaauTVhy2m7QiynbgOh6?=
 =?us-ascii?Q?BdSZxnzXV2VWdAD7P2xj8Mgoc+DGffBs9IlvNtfzjYzn2hSpyx//4+pxOwPn?=
 =?us-ascii?Q?7LvomAe+261WZP6NIRnGEg417/965hwTWSVZ3dnCKElFddK5YcZ/U+1VZZiM?=
 =?us-ascii?Q?LO3rmVp0E0Y9Vq+MsjMUmB7kKUBEqhmI+xFK3ud5IUtGRJge0UDklVdOOAZm?=
 =?us-ascii?Q?A4K8d4roObacMbW/g7opK1RmbwFlCCnSPbM1fEeSF/woIHMxdmdBLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:54.3237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c19059-d8a7-46df-4fe9-08dd623d32ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
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

Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
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

