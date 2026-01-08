Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7E7D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935A010E772;
	Thu,  8 Jan 2026 14:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1oyhFcfS";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051C410E76B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYC6aIERd58Ev9a9iUJFNY4OEktQZdxyxHkWKMEZAGmv/MLx4+pg31yoORlPrU7F6ZinWOBqATCUqSchJNtLrwYx9N2jKDystHF9r6dFjitwuv63qXRwveN4f3RfblxvcIK+Nyqv/1UEizjWAQc4SX14ICfJ4VkTNycKvCFDTyo9o+Et9bHMXdhWp6KI7mspBMUlVbl4tSdW0UTGxSXHS0xnsc9ZKScDg7X6BuRBgLJdvJLrLE4/GSPOdcZTScXw1OW7ffYEhNwFpzO9WqGg2SPaHVtbYnRIAOV0lQ3Sj92Yt6iJGhwScIFFaXQ6sqvvGdQ3xuk0tLTMpAALU0/aIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a5ApWLpbn03hkGGEajPn7nsxGvw1MmwlDMQTlWJWjA=;
 b=tZKdaVDjM0uLDD1+E54swuQoconF7ozrwFnciiq0SKV54ZmXq6khs3KZhnWQLSohWR9eLIbNteWxgOHLiTh7k9UsAD6Y77SpD7pSQkYdwtDT1qwXYxytaI08RzrvyWEWNMtQ3lHVRYYCA1k3g/ahvm8cp1gJ9lsh0xW9QTApUpj5735lLX/IfDrImdzscsv3UL5gLABMq1qsHCnxBwCdlBd9dM1vtYkRewsG6Ox5tNEHM1RsWczcinapMAZFvx3gu43akd/sI0txNSfHDsW15AAZKJhFnyY2uhz6R4cRP8DLSsfkzHIOMB0diiFRme8zyr1+PSX9vgg8M5aCpeGjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a5ApWLpbn03hkGGEajPn7nsxGvw1MmwlDMQTlWJWjA=;
 b=1oyhFcfSUzRagQrUaxb+QLBf+3vbShsXImOxzTa4PwOC9vwX3b067UPMxcJhcGQ3jPoOMf4KHnTW3l5aj/sO4onEq3yJyQ9xxgUiVnUC+8xW5JC1xZa2qCie1LvELH0kP2JOJvGafORcfdBnr96zF2YsZu4HceLGN5y54n5096s=
Received: from BL0PR02CA0120.namprd02.prod.outlook.com (2603:10b6:208:35::25)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:49:10 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::42) by BL0PR02CA0120.outlook.office365.com
 (2603:10b6:208:35::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:01 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/42] drm/amdgpu/sdma7: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:25 -0500
Message-ID: <20260108144843.493816-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: b05097e5-7f60-4536-0ff8-08de4ec514a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zaucd04ogGmDQ/e/miVjbc0r9ftLg7yuoOMuseD2PEMSjBshETnAmXpHCxZr?=
 =?us-ascii?Q?cpGtHXTinQcNWw6IyKg1P8Ml2sCtuc29qArct5fXNnADkFkgD1e/4i4MG1pu?=
 =?us-ascii?Q?8ejSzLT6GQtWLfjbl70M6AdQ49oXvFps7Y9CtBM7L9YAaz9+BEEaJBfF8gIi?=
 =?us-ascii?Q?QnqCO5CANmW7Ixk8i4uu12KEKO+Th4cUv7Mu4Md3HleC9Hrd/5FlTd0R6LzJ?=
 =?us-ascii?Q?e+VAPYABWlXOCWmSowSmiqc4Qf+1fy8T/HUj9HaC4pPlroo5upXdc2SJMI/j?=
 =?us-ascii?Q?qsyRANLp25+mHa5biHw0ATpc8F45inCZQLrSZETvO210Hg4XwpmssaCJrODd?=
 =?us-ascii?Q?1Vip0RZoBJVJjRkIcfsSlLjY+a0PgT1u0YmX8IVGrf8j0wgYOie8zTVsArOJ?=
 =?us-ascii?Q?isWz609cRojGadUe4GgLG7cxzakFsqSXpSk0+pP72ZJa6NmBpC/ieX001kTL?=
 =?us-ascii?Q?hLscoxAk0dBZVqJnniiWwyuMmJEDsVYow8um4tdDjJnZkKECTOOH9vDfX+ju?=
 =?us-ascii?Q?7/GkKC7eEBYLBqfi51jhNzYixF9sluqxIrxfgHhkcMyrW9jxQ/bTe/fRr1q8?=
 =?us-ascii?Q?6wnmuUF6oncPUDCf6hbjyhTCFHcn+mQuIDbyGrdxzMLg6+QtNhsq6dLMfVBm?=
 =?us-ascii?Q?Xtlznam+xjGxQ6go6Xb0yxHUPpQo7eHLEMCgJ7NQ/Y6SpKgOy0lZDbvvyiFo?=
 =?us-ascii?Q?r0ZFkiqcB92ar7CyM1+8j5iXenf4vDhLph7B1oUoC9ItUY4v7c4gXpXbN4ub?=
 =?us-ascii?Q?zqv/yMW0REYG5wwJ01TFGEuA5p2k9ofWCsXCp4+RfL+LER/cla6KZPwwFrZX?=
 =?us-ascii?Q?oDg6nzGzuJ59MgA5k0lsHztHrqaT+r+P08X+bg3hPJjkOwTi6Vn2uTJFZ1uj?=
 =?us-ascii?Q?cy3tpH4noi98xCzdIruyjstrsFrHXXyXiZUWvq90fora/3XP66YFq7C4EKmi?=
 =?us-ascii?Q?swWvfS+Y40aDzixVVz6A7Xd/QdOndmc5ukRTUppjOn07F93VOJdd5drDmkyl?=
 =?us-ascii?Q?0+kD40abDtk0uLdlUoISSbJ+a0fnjO+DAIVPpTWsumMYKWWyutZRNHqgcHwr?=
 =?us-ascii?Q?gge7TG3DhP0wAMKv/w0ZZLa2LlpgvLxhR9JStkpcz4DWx4PZkllkCcoQr4BI?=
 =?us-ascii?Q?MOqX/D4MhBFJZABYMGIQE4C7bgSRHvbQKfUlpdprtQQ+e8kEyVhrr5RHpfE+?=
 =?us-ascii?Q?3Ay11mkID8X/H5yntxAle0z7gnZde6OHoSK73Zr7AzXR1OS5dSPkR1rU8JuG?=
 =?us-ascii?Q?u3yD1T4XslHpu2xh9MGjmo863S/ktstICRC3uElzPXrXmMb4kcPRvcPYO7kZ?=
 =?us-ascii?Q?weQkPJ8l1rEET42AwYwIP+V9GMAzCQAR8EYJFSXsrjNrvP1P2KF1j3bo2uez?=
 =?us-ascii?Q?4KvbtUUasIWu/mVD5QmJ68DqumuPTy5cxgpeIVbYKsoidgHzL1xMKBFNdPBH?=
 =?us-ascii?Q?HgAmDKCU7/CoV9TbBsfhuV9dc0xim16lIUB6DQAWCwXEkA0Sk/FlP0Eoxp46?=
 =?us-ascii?Q?iI3NMN8ji3cePriV1uUqxMkqYmQQFXQ+SUUBMySo0sxfo+p/t34dwt3nnLkI?=
 =?us-ascii?Q?+ZR1dPjfn3jUinhku4M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:09.4771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05097e5-7f60-4536-0ff8-08de4ec514a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 36 ++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 8d16ef257bcb9..3b4417d19212e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -997,7 +997,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1005,7 +1006,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1016,26 +1016,31 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1055,7 +1060,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

