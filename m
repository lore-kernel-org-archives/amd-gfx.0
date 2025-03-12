Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AEDC2BA1B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3118D10E333;
	Wed, 12 Mar 2025 18:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f6/8koy3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A5F10E234
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2/bEPsY+LqmwekT7H/K/cXPjSBKZsnCyl+f0aDpUHRVdNfkfK3Qzb0txSH9d3T9Fd0Fl/l440sNSTqfVtsswufy/F8dLP6AeSi9Utu9rLyYFhlYGM6jbGHuxBgYpfnPNhNy6ePLNRdHxuikwXmRLigacacvN+XBEZkHwpFBMMj2FTOUq7XhjPckj2NG7qEg825cs8kKrYcQDkJS1crL1HArlH3q+wIE0ZJO0IQiM1++aq7B8hICPQF0O79roLt0+XX/JHNPlhGJSvQU9zRNxsRZJzK2TaeFXtC44NU8LkJt8Rvnfrt9pnGvLRSQKZhvKEm0bHLIQyCpnP1QYtjF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLqMimFHlkya5+8BLYW3w9jPVLmBVdCdNqOneyxZhxI=;
 b=aeJ9cPjUWmyKa8e9PNJNAKveQQQQmcKHSGFnkWbOajKdOaXsABkGHh7TEooCvrGdhDmGnrQ31iIjiw3+CEXo3TUEjswvb8Wft5NtjkdJtS0JL4QTJ95qUSga0Ee3F8zgw4oZlQ+RuIAwWRXZc/9WFUyvpmDAeDf4N8WJLnB4L8YxtRUZA0awDyJbNIvHwEkGX8gZYIpk9MEyDpeuLfLKttsdlMQrP8DTROQULPRhbMmkunR+1/Hh6e+UuQQ8OlpIaffK9NK53W2ut70MeQ2M6qwe3m155jFffQ2kYvGv/yPf/UspwIcTiD8/7gJDUbmvgv/d38+aPmSXFWsZiIGJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLqMimFHlkya5+8BLYW3w9jPVLmBVdCdNqOneyxZhxI=;
 b=f6/8koy3974V2LDiF2mZ57Kf/6Puw5orst+wxseKxx/bib6ixIrlzig6DLqQg5zfp0F/FNLQ8mKQVKi/MvV4E4GomY+WmeMkKqzH9HtJqU/YjKpqXPZ0ui4QmO3K9IaVW0FiyHDTAu9gsevrlEw+7/NuUgWDMhp6meubgnDF/B4=
Received: from DS7PR03CA0211.namprd03.prod.outlook.com (2603:10b6:5:3ba::6) by
 SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 18:57:49 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::63) by DS7PR03CA0211.outlook.office365.com
 (2603:10b6:5:3ba::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 18:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Date: Wed, 12 Mar 2025 14:57:22 -0400
Message-ID: <20250312185731.211350-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: d76f44fa-3c67-4215-b41a-08dd6197c85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q4c6erKVUzPYEQPSX84Etamj+Kev6cHZQ4GayRA7TxP2SswqKfxRpSKyO5TF?=
 =?us-ascii?Q?r0p7iQlhG/ZPtEK/Iz5JTTtL0kSKm8TLaJuOMeiu1l997hfROod/vX6dgrgT?=
 =?us-ascii?Q?SE88Y9zYKoQTyJd7JL9oJxylccpj58nNwH8B0t2+QUWPl9lkUSElU+KtM0wc?=
 =?us-ascii?Q?dfxs7cEEvVR581OpJ6y9FwLu/RDxjz4yQInnY9cLOPDxgbQqkfS9CjPXZtBo?=
 =?us-ascii?Q?7cmq1GHz/87h7cxfFlIZEXapGARcLxhjSp6/PAlNhjHyf3iSSjlf2WVPnHE4?=
 =?us-ascii?Q?erdnkuzsh6X1oE/lg5qm4TDQkSjEjCmEG48asHy057ozMGmDFnd4777QHvHB?=
 =?us-ascii?Q?GJKwdHSjUYjW9EB2I227Sc4jKhOgVtINUF7KE2nY5DlQquF8bRVskJM9fA6Z?=
 =?us-ascii?Q?BI8LG2IxDFPkb68Uf1hH6lG3+IPoKrxES677+fmyRn/VhDJU05qJkG3QvUIv?=
 =?us-ascii?Q?8ST/zANDWu4uZpJCGSgCEr9GEWMfxHVWYLwm7cYE8e2QbtnvNG+Yq9wBPkH1?=
 =?us-ascii?Q?wF3Gy3mH2iBhr6O9rEAZ32xI3avQ4RZwl6BlwvRDny/aTDoZTzDhzNNJhmQx?=
 =?us-ascii?Q?v7sOKqQtKh2o9k6YOWLsyfyKS+9srjSyNMOQonxQIf6nT4Fbo4xY3S9B4x9E?=
 =?us-ascii?Q?204YPhh9P6G0iqvYg9ZtOuVKlw2bPLVU8EgsV2oP2zXJki6filQKw6kSBSWm?=
 =?us-ascii?Q?k+szMD63Vd4ktBPM89z/u9XiMLrHVVCK+3+qpB1bcjchVElC/ShAlQUx0/fq?=
 =?us-ascii?Q?ICbmWa3D3t0o5p1/DBvS5KG324q+/uHpcHwlXsachBiLS+AVuEiCMfIWz1lr?=
 =?us-ascii?Q?3ad0xPWMzBvkvMlJB9ONL543bDkUFgrxwCoLbkPrwYLZX7jvLanDi4gvyQGW?=
 =?us-ascii?Q?GIL+71XS/ifPl5K9ugT0RD717JIq7r1wzxfKQCZqT3JqyGsPj28Y2ITxx6FX?=
 =?us-ascii?Q?Y2ncEoeDggZZFa7/t7u/83oXDBOvtu5kfNBB8yNvjbF+MvrU4cw21+LJp5ED?=
 =?us-ascii?Q?5BssolV/PC0UI+qhIb6O4Oqi2bID3hTuoBxMyrtPIq/t3vNKJvH2qpO2d3u6?=
 =?us-ascii?Q?dW4rzS8gLKnaRDEJqTjcSKdRdty78gzITeKHoQ6QBEEmywRP1p0NSM30/HTZ?=
 =?us-ascii?Q?b6cnSeIVNCrKqkQhqJc1cmStIMdlnyPHC2mLFF95lN3mmJ+ky+Kchq+r6TBI?=
 =?us-ascii?Q?xgBJkt4tMhEbh8UoLRjQtn9krPqO84CUeiN4gLYTgkI8UuCWtEz9eKdB/U4l?=
 =?us-ascii?Q?1D4kqcFTVMcnTBnl3+2hzjN1dae2CoAxO+b6R44tFUfm6NVb5SaIK9avrC8+?=
 =?us-ascii?Q?Edl6vghxeaPczIzOVhD/2y+vIcb0/Kxamt8+cRqo1xF0w/zPNXk6p3rl3G9G?=
 =?us-ascii?Q?Tp2Mdl5m3UEXgEpJQkl2YygHUj6z/xELr+ne0TzBeT30+zwkaUOfxAl3GnPT?=
 =?us-ascii?Q?gWxNbYGFTy5z+GggC4m1ZwHMyxrC97iZQYMzW7lpy6Mwl/n/aMKRAh48C+Th?=
 =?us-ascii?Q?VT5YcY2kfyvs2DI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:48.5262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76f44fa-3c67-4215-b41a-08dd6197c85b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
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

