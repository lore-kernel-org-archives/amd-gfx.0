Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6C8D1D469
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CAB10E768;
	Thu,  8 Jan 2026 14:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NUNi7oI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC70D10E766
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYFGi+k0AWz4dhS08AARSZchd+LuRJXNCJNqdLbfaj8z7NcwDBib5hUyEAcAwMZwWc+Ou+5+4SQgqJVvuRgpeD7ISfTjFDxKtPHHMBz6jxzncsPl5kTGnGGSJ2WmQGOISkcedX9fNWF2Y7fQItihsXo0psG4PGS8mtc7DD1jhif5GAT/G/M3t/fUNl99arYyqWWQPeXp505j8Xs1ROWgUkqN5+2QNnvzkFmKXUodAIxW+WIT7h74yjEjzQ5TLN/oubaLaAY94FCk+nk3bau4Tjq6XelN6f0Bz210zSwXvg11sc1OfurxnYkjsoVWQUbMD3xI/X8ATPPClSu4KNSd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCMhjV0YyDqQpkN2jjl8tyFfdZUNjIPi0MyDAvZUw/g=;
 b=BJXI4CDy66fNNBJrPzMyD2yOdQRtoGj+7NOJj4w8GgSr9voIDDLkGSSrw8uCagFCE/YhSCfDDyGVcaVI4g07XbaAZrlVDfg/QQmKODfX4HeeBYRR2msPTsmjLuqGtDMboNlT61P47zE3agau5bvbX1uFZH30Hgvqe/PweoQy0jMxdbg7kw+Rhi8eYo0xNbcujFYwOuiha7OjphZsAuxy3D4oGA5yE/U19pwMLZo7KPBSN5ySTGuwd4H0m0q/JnfTRkGkwZ6GCGK5RU8XOVT36XBhxiAN2QCuySQxDYnkjmix+72wMe0bepr7RhS93tE/XRUl/6zzySRtxrbJvlYI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCMhjV0YyDqQpkN2jjl8tyFfdZUNjIPi0MyDAvZUw/g=;
 b=3NUNi7oI0WlVB0KDXGR7kAXLwZViKeevtfMRtxwyF+Sw37girCyRP5n7X/JVLRWzhgfSqNeAEElz5evJyudgm+L8ICkjSEGEEXbGUVjlDaxMpTQhykkkENbvKTsl+uT3tjuHfK8GlumnHOunnI8kQs6PpmXBg57nkLl9KOLqbFI=
Received: from BL0PR02CA0115.namprd02.prod.outlook.com (2603:10b6:208:35::20)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:03 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::e7) by BL0PR02CA0115.outlook.office365.com
 (2603:10b6:208:35::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:57 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/42] drm/amdgpu/si_dma: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:16 -0500
Message-ID: <20260108144843.493816-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7868a99c-5f5b-4a5f-7feb-08de4ec51052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7bMbFeYO6sD+3RRYYxLllefgdW7Jv7IKIRqPeW1CvzkHUBGybFQ9Q1I6DcCL?=
 =?us-ascii?Q?GFjFNdjueC+2Wltk1IyajghftaMhw6qmW2qPmejRaod2oQe7LXQ1V6tTWc1M?=
 =?us-ascii?Q?YICUajMoarJuAziYxURoF1hAx4Oj6LaEikswuMdflkCLOdFRvlkPdGM2J+Kk?=
 =?us-ascii?Q?g0n6fjft0y4IUSblA+qKYtXF7qOzMgO19s4FyaTmFyV72K70WixJggtPaV8K?=
 =?us-ascii?Q?5+kcS5NJSbVHsmWc1/epI8BusIiHOpSzvFPLHwis6LLT/2rO9xDJQFkps+bC?=
 =?us-ascii?Q?Rewrg2etMPR9MKWPoa8fET8p0W0AIu1jk2osDRitQnY1Fkz8ngEUrDIpQrMo?=
 =?us-ascii?Q?myRF1KIB9VjzJIoeScgA5jRebGx9fXIZtdLYQ5Xp1x9ctQcSlcDVx9beGOAH?=
 =?us-ascii?Q?eCcQySE/dwvptlraP3+RKWN/xYLTRVLW5wOv/INNP3fHCLOtmP1V+HZCGIwp?=
 =?us-ascii?Q?KKCEBGAeaTAhr72xnBPrblckUFUAEGdGBXboi6g45YsVJR6q3V0orL73l6Dr?=
 =?us-ascii?Q?L3zBW/9H6lmIZ/UVqUwI8Nikb0sgH4UyDYgqgWyxj5Ex3f/rgLOhwUpTEvE/?=
 =?us-ascii?Q?GxMprFdZKusYHscip8istSoHSWbZjPLwbAwhHUwACh5TyLUtr1VurzhFY8kD?=
 =?us-ascii?Q?g5hjvCnUGVvQbL8rVljNoQndJzbz7uHJC/lM29zqrgLqIvDVc4k6hg2sTOq2?=
 =?us-ascii?Q?nHzzX5cBOJDPXKuVnNNXJNjv4KDl0+VGXWP6eu1ZgqoQ4IFLh6LV6T6XOlZX?=
 =?us-ascii?Q?z6MtRC8Kgzu9ce6haOtan7ugfML4ZGEj/KtnS/5rd1xgKEC820s0DlIsofdd?=
 =?us-ascii?Q?C/GzLlmaKlcxRTMZeyjpWb2nIUWJZ1qu5Q7lzLjRz+bVkioMDf9Z9oZi7ZLY?=
 =?us-ascii?Q?XG/gZTrFoBaGFEiqrq1ncGwjO1u3WgKsA0LaKWZISQQnhjYx0vcTqh7VuYjc?=
 =?us-ascii?Q?PUYWwnNsId/v6ar5UlXqRFlzKdqbDYLyUMVU/PNpiL9yrM7kEHCBROYzxJaR?=
 =?us-ascii?Q?25bURCCb+GbBGosTbC37QK5aUcYVMFrSXd+4jBzpfIF1kN2iWtVXobmssQOr?=
 =?us-ascii?Q?lifs694bXN8ZEtgoVohdRpMkdcvIOI2LBNwZoNTxgAPETERiZ/eqRKypYyW4?=
 =?us-ascii?Q?Jov70/yF6/nidjNnqtGsp3nPe9MP1sHPN+0wM2Hkoj/r0gzE8vAfrcK6xncR?=
 =?us-ascii?Q?026E0T5IcyDcf/cUqqIe8P40tNFEwdW3r9R9ZlvZjo2I9jMktFm2bV3H+kCL?=
 =?us-ascii?Q?krNOxQDAF5E5SMfm7tyQiPUCUV32Uhb7zFu6vbWEBySx4Rdc11mb9ZcSx3wX?=
 =?us-ascii?Q?qL6mPfHRBqCBDwSP0bIYiJxlVXkMCwevs44nDkWAj25awjfIJY28esrAKEuk?=
 =?us-ascii?Q?rlqWlLD2syZg0Jdqge8pQfdC01xJBbrxjVZAVue3fvc3GUAibefXGSt2sMev?=
 =?us-ascii?Q?kO0Jp9/nnwdBJszhrBM0d0gz2+39yobNVx3OCzUNuJgff16RwgztOS6Yj5zF?=
 =?us-ascii?Q?LD5BFpphpOG8EC/MzidiJKD78RdLAH2ultZBM7QfZ5S7UHEHgLJYifNLg7JS?=
 =?us-ascii?Q?8IWo/a10FMJ+LKApzU8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:02.2125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7868a99c-5f5b-4a5f-7feb-08de4ec51052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 74fcaa340d9b1..b67bd343f795f 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -259,7 +259,8 @@ static int si_dma_ring_test_ring(struct amdgpu_ring *ring)
 static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -273,20 +274,25 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr) & 0xff;
-	ib.ptr[3] = 0xDEADBEEF;
-	ib.length_dw = 4;
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib = &job->ibs[0];
+	ib->ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr) & 0xff;
+	ib->ptr[3] = 0xDEADBEEF;
+	ib->length_dw = 4;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -302,7 +308,6 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

