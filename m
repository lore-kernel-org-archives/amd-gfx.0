Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A7DD38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84FA10E641;
	Wed, 14 Jan 2026 16:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZPf2pU3S";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188D810E644
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3Rzkgyv7HDaafKhRTtp8uHoVvnFAfUYNYszUc43cYH9YTiSILut1IzvtpeRbymKOUaikQSGPe4cIi+ev2VI3o8QTYt2QNJsYF6fTXCp7yGac/6M2+RYjerOvrTQTFe8Tmm9a033gCKKzZMnrmYnIWAKc29cayNe3c+JwRjFhdMKBNaxcuD/AtEMnv8YjKb9hGJBqxmYEetUviEAEegy1lxfpBl4CCfxBGM4t859c2Oc66d1EQd08/UHPuZerEtwgv2/M5KzopLikoL58Rk9fZjVFvEVv1eQ6N3Y0DXevYeZjL73srMd4WKalcyr9sxYFlvH1M6xXAolHzNlCkbhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36XO/5yHycsO0BpfUGL5MUBYAbmsecvoOX2cixyMNOM=;
 b=N8sMQh4Z274iq29IHf99AjiY1ViSdCFzCW52bscTGpCsSyH1087JaoqOjPNF/fUMueXI05nKEvkdYbZgadHXO3ylwTNtCGvxpedpfVhch9h/SabrhS2GVKdpWz3IxmA4pl8+407DZtgPLOEOcIHnmmyjte5fbPRGTthJYKijxP3ez1qCvXFbf6++b5Y3ovrb53DQQLIFiEmZkT+8ERZq+hr9I5L/JgrNjvoR5nLRrnY6OYbUWoHFd0j+/VHUbIXln3hcCJBkQV5Z8HEw4KeS3EvPe3n3IiUJfOBgYp76oZerwsVArdjyyRMI9ozYnp48JOoFCCCamkCffJSWirO9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36XO/5yHycsO0BpfUGL5MUBYAbmsecvoOX2cixyMNOM=;
 b=ZPf2pU3S12PtmgHh3QGA85J0LQjtep6RMPUynkIu0aF4KHUPY6pVLDBrggSsSZiYJHujZJZbIhn+zx+dockUgUyzzDAq+Agq4+WZDk+034AbXPWDsFbvvn6g7DCy37fLXLAA+N3veSAIy3JmBZrMNkCS2D//LN9VVSA4IIA4w58=
Received: from SJ0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:a03:3a0::11)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:47:44 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::3a) by SJ0PR03CA0246.outlook.office365.com
 (2603:10b6:a03:3a0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:41 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/42] drm/amdgpu/gfx12: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:56 -0500
Message-ID: <20260114164727.15367-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 41263ff9-8d09-451a-0711-08de538ca3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+B3FQ7aYFQ4iADopyXb1xnf+aF7moIWLFCdv+juZ3EO5HkSEr8ZhDP3UhNt?=
 =?us-ascii?Q?NBJi6I4T9Hb83v5Kw0bQwy9BQ6aGtPE6LrqetJ7S+ayXgRPOYpX7iOEKBQmA?=
 =?us-ascii?Q?q+zAjyfrBnIy92zz/169+KDKBdgE/XxMQzqSt7REAir1UyiS9C0ARBwNrqup?=
 =?us-ascii?Q?/nxnMDtveIpuYxLONEVS23ggq/LkmLtW+V8zPfql/+Nni4Rpr1bi36wtcETr?=
 =?us-ascii?Q?/YX1dr/6t2uLnAQ6WARdO6ougvSolMy2XKpTe2/TFrA+Gg/WjwnDzs1NcTTD?=
 =?us-ascii?Q?ZTlkgPjpxGIomd8YlXW5byXsv8tgze0M6348AyjYS11XeX19BtVc0jflQbL+?=
 =?us-ascii?Q?UBKJueIIJJyln0gDVKSPqhE2OWMoKcvhR4pglF9bYaDvc8sXYX/Y5fQg0Re9?=
 =?us-ascii?Q?GrFFTEbbD6VtiuXQlrwlenI92bZ0ND/TkUcUSKDbxhJBgHEL2HSsrudxYJu0?=
 =?us-ascii?Q?EfSu4FxOpTcLBri0NtYxRsa3DDwVb1xT+Lqr9j3YDIEXDj0VX1ZXiYfMOtfC?=
 =?us-ascii?Q?k9fAzAzTsNuR62kh16Pn1w4TUvS8aNB7ARcj2b/NhPB6b/dH5qEoyjXaDFgA?=
 =?us-ascii?Q?YVM8AF/YLSFqau4ZKYCd4CeNmISydjA9J5Xcv3+Wd/tCs57EQj4reMNTkJfK?=
 =?us-ascii?Q?OGRlELUjGb4pKGjCcoFsm2oDJzBGoGN6dY5jBwT2KfZQkFMDdgGuhq/EaqBl?=
 =?us-ascii?Q?tzJJApzOoEylzreMPQx5FY6hruo05JR8Hw8KYRPOV5BNQNuPSy8vmbWGqQXw?=
 =?us-ascii?Q?X/PMfEpQECG2qOI+iRrLeOs6lzbTEPQVpS28Kk9184kXPs77VjFJS72muyMH?=
 =?us-ascii?Q?oKOfDXUOAUrHc9UBEiKk2kyMDdJLK9vd/gVg9quBLUXWa1Nkx9UkDpN/ycGG?=
 =?us-ascii?Q?dKyobnsv/YqWI5MEkIbbYpiQEsM46XRrDO1X9/CEJ+JtXNMBEtj6AJ5kQq7h?=
 =?us-ascii?Q?GgqdZ2EnK2SZRcnp2mv9PDd0yqkg0NZqOXP0NDqaOP5+gZIy2SbWPp16guYg?=
 =?us-ascii?Q?N8HUun3STU29lXlkNxEu/lw2vmsiS78uTLmSpTQW/1RGvBEXVZINO0mkHl6h?=
 =?us-ascii?Q?rlhJ24D+b/BSJKHv40lNnd7ZP/u2YpqjbFd6cGYFHvSnaqW2nzbtZL6x9xWg?=
 =?us-ascii?Q?WdQ2LD0a+7OZp3Ewv08ETDTvN6V4OI4ZfwI94CQKESjKohiWI8gS2xshd6DZ?=
 =?us-ascii?Q?FGP9Q4H92Ymry9cErU052Tn6c6Th88VKCAvz90sQBOfNr1WfYkRSPTKsnvp4?=
 =?us-ascii?Q?cP5yCT7N7dLcvL6Pf2MQtmMwgVCTDassCMBzjUi7whUoMovG4h4am2oKgnAN?=
 =?us-ascii?Q?n/K+C/wF1a0wLhy+0kZkty989X0x+M3MELOra3rtysNbkSEf1TVQEtWfwnJM?=
 =?us-ascii?Q?BCEBnYDV47t2GQDqpAJytUT+a6E1By03C9uf/3d+LDY8K1OXtA5JvjvdYSST?=
 =?us-ascii?Q?pb3co88bXGQTXnimE6xrY7ErmhX+zLzFO+tV5mdEW7QQyV8fnOxkgDqDsHZd?=
 =?us-ascii?Q?gBt9BNqbkDwghBZeXdwIF6uBpVM1bqlrhvsFlE4CKGT0jN+lSwZ7SaOVgQ1B?=
 =?us-ascii?Q?QCcy33KlWlngyZL5SiHg88lBKN7buPeQwFwIw9gTZJYEZHGqYPU0vUhni/HQ?=
 =?us-ascii?Q?ddqu1mbMgK4BEpc1AUvKCYAFDC58U7+zDeab9CZYVLY6eF0aymzgrXA6j+yk?=
 =?us-ascii?Q?0KVZGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:44.1885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41263ff9-8d09-451a-0711-08de538ca3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c374..5862b5f60a6ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -494,7 +494,8 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -506,8 +507,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -516,22 +515,27 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -546,7 +550,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

