Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DCDD1D469
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C2710E764;
	Thu,  8 Jan 2026 14:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvF0Q8la";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2ECE10E75F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txWrDahbEo5FvbwOIPj+w6dQeQznfz2PO/yHqBpHyjqnWqHi0WZLyzZxkfJ+DepA4fX5QnB0HsWo1GngXbJspSVr/sdjG8UdJ+wPdHmvK5Z3lKNvTNPspN86kigITdnAifWF8RT6sw9EipE1000Zy3VuEc/1DmLDyXeau21dcPjHp/PzmKo9r8t4qJU8nGl1ohdB1CN2EomQoriBgHWGjj9vtz9rFz8lSWhr6wKqk+Ieb2K6SIqsBnejyxNbWm2sNkSugFctOMY37YY7hkE3omB8NU8ANFWshAlDFtDrt80W+UM199iuyWGGtPnpIh+c68DrSuA85IRV0wHSTyFrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6kzMH4dhC/439IPdi1wsziEZIbnOMq+H3OPCw4i0pQ=;
 b=xw1JtV5BQIBZiQgJ9okpZ+THXLYG6WGHgtSlOa4UFVZBjnASMDdzpAL3tp8bbL6mgoQRLzwx7pwgPJ6FGobF4IvXrp+bo5db0vwH+uRNG8G09WptucKzHRaWPj+H57rsaUGGkdrpsGhMWApCS8J2jbSgbA3fzjIyu0Z5SXlBjPv88Fn1AqpUP+aTxKGGWyfcb8zkfhsgz10IT/FhGJzQTIBlNMqAg6qakjtw1M+V1f7M39gX28u4gR1o9uGkkvF7izG4Pig3gJEIopBVnSN/W+iRydhXWEHWFxyWXBjzaUSGADbmqRgoOZefkzS35Zs43lTsBiZ8Z9Z6fyTkVNovjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6kzMH4dhC/439IPdi1wsziEZIbnOMq+H3OPCw4i0pQ=;
 b=vvF0Q8laqanQwfHq3kKXa6mo8gbbJP1GNPQa0ZtNl3YLfwZFuUvAGK3DzcXwaFezWJppS9t32uMAMSbTMISyS99lTYZNToKbmmPd9GSjyLxjszVqTIFTjDWm24FZ4NR/omYRzU/AEJPP9y26eHLK9D+5x9Ps4Om416UoV/l1fFA=
Received: from BL0PR02CA0113.namprd02.prod.outlook.com (2603:10b6:208:35::18)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:48:58 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::a8) by BL0PR02CA0113.outlook.office365.com
 (2603:10b6:208:35::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:48:54 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/42] drm/amdgpu/gfx9.4.2: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:10 -0500
Message-ID: <20260108144843.493816-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 028a231a-b164-4540-7d25-08de4ec50cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kebI3DvpnSmid1jbywAIBsbw7tKDMveEdKOf2j3vIuE9FPhzhuLAGq+E5DSt?=
 =?us-ascii?Q?3Z/7TWWxNeGJj0xlBJhVeCL8gjXa/zAP9GxTBQY/NIYIcgY6uDBURBa3H3xP?=
 =?us-ascii?Q?aJMbaeOW9AvSu3hRZysdzNCHIk/lJ5UItty9DhPiGW17wpmXTpqTVdOd2NVX?=
 =?us-ascii?Q?aVPUvoBLrbTLXIkNcXnTpuSskEwI9dl8qFXH1M56ONhzC4JYaOMYG3o0DFKm?=
 =?us-ascii?Q?ICgNnNmNsUqJaESyMSIjQc6lDTyP97/bQBEi1wOhxAPsdNzc6/6AQKzHWG5P?=
 =?us-ascii?Q?HxIhHqBgTjx12XEum61/bfYNSkgIbJL3Zc/Zxz6gE1CGIhc/oB2JU/gmD50J?=
 =?us-ascii?Q?aPnKgxs0T3y0LdL/+hV5XOvSD0t94ERQOyXDe9yt58IJcGlIptRZoCZ2Umiy?=
 =?us-ascii?Q?2nhWoo9A77UjATmbwjQkLv5GPN3NPlLeO4fCH/HWcWcvvkw+iG+Spn6Ncw8T?=
 =?us-ascii?Q?sXXNmUGtG5S1MCnQ/m7UtXzYxcZPwwWWNIQpPgvPCyGJnkopXcHal4kVDxp6?=
 =?us-ascii?Q?BF4ZucF5BBePzIpf+BoS5ZnC+xfvgzGH3dNjjs+d4hErM/lsYvWN84lDhZj0?=
 =?us-ascii?Q?S0IKe596NN72nmkew0iRGFPhqfhA2U9mBKLrPDVeufrPOKH3S7LdWb50nuaZ?=
 =?us-ascii?Q?HHDnxZLsCOdChcq3qzGL2R5RSbDt0QWu/0Y1eW2y9JSSIk8P/3HW4ioHl1+f?=
 =?us-ascii?Q?Ilu8UCcxUkoO7y4EdsPN26/iJZScD+4KXubLvxltrATM2KGpH6Nd3TNXxNnK?=
 =?us-ascii?Q?mKX/B/rUD9mSJ+JOBDsXDwwg8CDADmlkjtSu+eQYVr56jMD9YBwyXJjj00G7?=
 =?us-ascii?Q?enMfgp0OaIAypaDGzVQl7WND3hLoTBI6CYPcuG/F9ALc/SfO0HbMT8SCZCnA?=
 =?us-ascii?Q?8EQhFaon4IFDoLhfuc/y4VbMYLp45S1/QDB2Jcm75CSTFRYX0Qnr6kCqlVNO?=
 =?us-ascii?Q?b/21u+TEQZ+PT8CWwep8o07+emOlrn1RuNQIARGgLCqywiBYx5qUpPZczVo8?=
 =?us-ascii?Q?PqpoHOVHBN4GIVICv06dHj/wxdw7qWzipCFuUGuqizZPSNNyX2YzGyfyIdKX?=
 =?us-ascii?Q?usRtJS0STSidWoSbIaanZ6QjIu55Z4aMLiitd0KYKNBKQsE9lJyMP6FSC3NM?=
 =?us-ascii?Q?s2DLLxKwijkrsFyRXNRgFrdDuLmhSPibMFEtax+KX+ffnsNDSXj9mVBUPd+2?=
 =?us-ascii?Q?llyMai1CKPLX7RxSGfRdKYTXfkBwsiWxgkJMDu0rmo5fOTrK3IW7eyZvZVvU?=
 =?us-ascii?Q?4th5vebisHR2d4w5OsVQSmcjknMKlJDpq+lsl9SR92GWwc5wzbWdleiCU6n9?=
 =?us-ascii?Q?6G+rPXV55KM+gLJHuLDwi3f4dizrNBFk7yJKdMHGQ8jJ5sxdVajdkLYcIEtd?=
 =?us-ascii?Q?b0EqPyl4ek4vVl31YmdkSjHk8Zmtj7cCTX+EHDlUjs6/Pjy1WeqinM807Dv1?=
 =?us-ascii?Q?Fg5weJTI5Z7BsHkGqgnwvuKbUuJKl+8PDavFFffN1+IBBhgug9YG+XZNRtnb?=
 =?us-ascii?Q?5RVTLjb5NO0AIROaOqvBJAD6cRq8fpmfltI8J+DIqtOB6cmCxVbUIFrWY8Nw?=
 =?us-ascii?Q?9lJo0THfolvOjlp0Fu0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:56.5237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028a231a-b164-4540-7d25-08de4ec50cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
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

Switch to using a job structure for IBs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 26 ++++++++-----------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8058ea91ecafd..424b05b84ea74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -345,12 +345,13 @@ const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
 
 static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring,
-				 struct amdgpu_ib *ib,
 				 const u32 *shader_ptr, u32 shader_size,
 				 const struct soc15_reg_entry *init_regs, u32 regs_size,
 				 u32 compute_dim_x, u64 wb_gpu_addr, u32 pattern,
 				 struct dma_fence **fence_ptr)
 {
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	int r, i;
 	uint32_t total_size, shader_offset;
 	u64 gpu_addr;
@@ -360,10 +361,9 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	shader_offset = total_size;
 	total_size += ALIGN(shader_size, 256);
 
-	/* allocate an indirect buffer to put the commands in */
-	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, total_size,
-					AMDGPU_IB_POOL_DIRECT, ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
 	if (r) {
 		dev_err(adev->dev, "failed to get ib (%d).\n", r);
 		return r;
@@ -408,11 +408,11 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
-	/* shedule the ib on the ring */
-	r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
+	/* schedule the ib on the ring */
+	r = amdgpu_job_submit_direct(job, ring, fence_ptr);
 	if (r) {
 		dev_err(adev->dev, "ib submit failed (%d).\n", r);
-		amdgpu_ib_free(ib, NULL);
+		amdgpu_job_free(job);
 	}
 	return r;
 }
@@ -493,7 +493,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
 	struct amdgpu_ib wb_ib;
-	struct amdgpu_ib disp_ibs[3];
 	struct dma_fence *fences[3];
 	u32 pattern[3] = { 0x1, 0x5, 0xa };
 
@@ -514,7 +513,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ibs[0],
 			sgpr112_init_compute_shader_aldebaran,
 			sizeof(sgpr112_init_compute_shader_aldebaran),
 			sgpr112_init_regs_aldebaran,
@@ -539,7 +537,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[1],
-			&disp_ibs[1],
 			sgpr96_init_compute_shader_aldebaran,
 			sizeof(sgpr96_init_compute_shader_aldebaran),
 			sgpr96_init_regs_aldebaran,
@@ -579,7 +576,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ibs[2],
 			sgpr64_init_compute_shader_aldebaran,
 			sizeof(sgpr64_init_compute_shader_aldebaran),
 			sgpr64_init_regs_aldebaran,
@@ -611,13 +607,10 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	}
 
 disp2_failed:
-	amdgpu_ib_free(&disp_ibs[2], NULL);
 	dma_fence_put(fences[2]);
 disp1_failed:
-	amdgpu_ib_free(&disp_ibs[1], NULL);
 	dma_fence_put(fences[1]);
 disp0_failed:
-	amdgpu_ib_free(&disp_ibs[0], NULL);
 	dma_fence_put(fences[0]);
 pro_end:
 	amdgpu_ib_free(&wb_ib, NULL);
@@ -637,7 +630,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
 	struct amdgpu_ib wb_ib;
-	struct amdgpu_ib disp_ib;
 	struct dma_fence *fence;
 	u32 pattern = 0xa;
 
@@ -657,7 +649,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ib,
 			vgpr_init_compute_shader_aldebaran,
 			sizeof(vgpr_init_compute_shader_aldebaran),
 			vgpr_init_regs_aldebaran,
@@ -687,7 +678,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	}
 
 disp_failed:
-	amdgpu_ib_free(&disp_ib, NULL);
 	dma_fence_put(fence);
 pro_end:
 	amdgpu_ib_free(&wb_ib, NULL);
-- 
2.52.0

