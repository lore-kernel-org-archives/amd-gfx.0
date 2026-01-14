Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC156D38FEF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CB110E645;
	Wed, 14 Jan 2026 16:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mv53iSOM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D3E10E641
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbNi8Fx99YaDleNab0ycB4qN4WqVh292zcVNCutQSFDAVtiIEeYpxtN6az83NuJwV6ohaGQoblw/eG0TQqFgT7b8DXjqyMMozRv9kmqlyzciHD4FT6HM1E/MRme4cwa32ourKxusF27AAHLXeFg8ZDrcK2uKvWt7OiIm+F7m+PcVMTMiANKjvEsKeVJom552EQ9Zam1nan7YGa1eKvmhO1s+nwesRcHJtJcXScjtYxP3Fsn+bmZDp/Gke5GANIrHgE7yWzPsnjh6hERcMEy/0n+L1u3lgr2u8erHdWY+Hm6xFgZdiX7QfntNc+W7+iG+Zdq9ADy/72iY4sfAgE7akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqfcrG+/EwWHRTVggIY/58ob8BziQJulMWQ4PRXDGVo=;
 b=tL/tCOrAUuEoFIYbFJAPyimnzffcfFcgAcb9mD6xpfH115pv/RkGrdX2Yp2IuCmI7eMT6LUkIB9ve/Is+bqQ5IFoIpcxfTNiB3JvCqNTcK64iTAtq2JgqbbwpbNbj6gMGvX1Oq4tMfWARFvEnvOM0lB6cajngtI8EMtA5J8j7X36245GvWab/T0SdisIGk8qZRd2Mg1Uo2flMNcTmg7hDWH9yQMJMurtKwI9ttuoK51pq68oefhnMgoGnWtNRNz8lz+l05oEJJHS6XUFNWJniVcvBwQensoObBQ9WC2NIXMUS7ry/YmuAK2Uh6kCKHBFgiRK4rnNMTzO8jcscyBSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqfcrG+/EwWHRTVggIY/58ob8BziQJulMWQ4PRXDGVo=;
 b=mv53iSOMnMZg1yRn0gdELLVic6h+TF7VNuRZO2YqEqbCRRcck+DrA0VePzUuWxWMaHl8f7GRp4PxnhCOFZN8jYgFcGg/GL3cfEzH7l832J6IJULx9KnRCAGJeA2xZKHnr/PagFcJsCNOGbPwWD8fka7x1L8nUzkVqat7y/6/p2Q=
Received: from PH8P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::8)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:47:48 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::93) by PH8P221CA0019.outlook.office365.com
 (2603:10b6:510:2d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:39 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/42] drm/amdgpu/gfx9.4.3: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:53 -0500
Message-ID: <20260114164727.15367-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fa997f-2bc6-4ee1-c82a-08de538ca545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/zM7vQhxabxJpvuBRPVaGPTZFGrT/NzhtvTGNmz8I9LoBPvRaXGXwBfrxfmf?=
 =?us-ascii?Q?RApjtntdNp7l3ApXBxgCcp3ZCcd5sv2xGMs3Bt8yzRmAQyvPvwKywRC4Acm4?=
 =?us-ascii?Q?nFk6SgnhK6VUOOtZOIMAIxRIeOEVYv5V2WZyzayLlOPy1NYFsdhcWn28j3uD?=
 =?us-ascii?Q?nRK3qnlHJ5ERtxACKtzp8/6WWZXwPhGxnB/akQ1cYyW3R9nTq/hCrA4RCpA0?=
 =?us-ascii?Q?fmkjLGwFszs5sivcmiQ4jRPXQH4YIPGPHezhm/uWXPn2u2mf/npbXOGeUxwN?=
 =?us-ascii?Q?UQ6PoOdphfAY39dRMhFJPHr5xM1jlt4L9KjZ8hhp8OmrTnzvXWEhQGLaKiM0?=
 =?us-ascii?Q?Jr3G5+NtcrfNsWIJO3pTUvbg9oGvNlrhDdPJJV9jX2SsAY7RsFK8DjMYAas/?=
 =?us-ascii?Q?uv7nXCeSjzIf6CaCQY1I3VJ7X0trWlVzjmRYRXSKZywaHePxzJDxoKzLDbSQ?=
 =?us-ascii?Q?LlDSTF1fBMA2vA9K3D67Nx9ygu66HdZCoM19++jmb/5u/ynmqqQpQ2DlkXsj?=
 =?us-ascii?Q?O/LnLBvgtUR9RkXgIqmsu+o6NydDi4Q8SJMV732jvhlsAWoz3GEkwjI0R7pB?=
 =?us-ascii?Q?7OFkVTINvZBURSRLNaH/DY4Cx4788d+rVN1OwyALss8l4ms79MsBVRQjlXd/?=
 =?us-ascii?Q?n5l+EdBmmB82ab51etx1cH+lFJ1Z/6Vxdx9EaJ/llCAk9JgRFIMZkHQoyo66?=
 =?us-ascii?Q?DIOs8HCyq3e4aJkg7jkF5dEVX/EkRLDRwX16/++hwCXfd7tqWYUbfiQqbFcN?=
 =?us-ascii?Q?vdy7TFrdRgxxG/Z5WO6hwP9kxKtKj3d4Z06S4OH3gNxWg1m+V+Bg9wIvrf6R?=
 =?us-ascii?Q?6sULXpcHEPze0MBEQTvmXhiHTGHJbUSFSwzDIuUNAakac8lkJZ4HpsXx2qiX?=
 =?us-ascii?Q?DGooGzky8bRZYa4vzSxCqghfBIXklvCPiiw8si7ZRjlnppf+PoDG7nEbh/QU?=
 =?us-ascii?Q?8i4fNXqwy/aRuTpJulzPZsyR0ricllHrcoEDqzmVCTvuzIS1m+qtJaTXuq2V?=
 =?us-ascii?Q?sp7a2AcQ72+X6Zj1bIC2NnWiGh+0BJdY11HD9crqXfHAYDgy5hNzDxirA0Cj?=
 =?us-ascii?Q?UKv5WJpY9KSsDFNb8KGKU3lr9ydv65FmHMRF2P5LT/DdhvPujem4Wgz1ML29?=
 =?us-ascii?Q?t4kQ1QuHgFoQ3DiRw9v7tucdB0ai5dDmHdE0oS8TrYzfHRO9G+6GF2QJ4NZc?=
 =?us-ascii?Q?w1GeA9xKvc8W2ytzeRZOCH/2Fz6HD++wp707J/k8y7LbFASrq4oV4GHKSawf?=
 =?us-ascii?Q?HUee0ibEfddRa8yFk/EJ0hAvm5WEYkowCL6F0Dh/fLTqrG82vEo9ekpt7Uas?=
 =?us-ascii?Q?U+769brF9zzH9MyGvsm2vkyYvTvqQixjDjgBD0amVVHPM789staBzKNgOS4i?=
 =?us-ascii?Q?f4fRwmCqZsKCCRp9v2o8McQqSM4mcZCPjYa88NKZlQrRJfmlCOYwx8gqK/lB?=
 =?us-ascii?Q?OkgdX0G5PvIPkn0uJOTzGsGRuuldvMTfxjFrhsti/BynSXMQ7vhcCQIJ6KKo?=
 =?us-ascii?Q?u9ZyrK/2hVglHIwOApfwVVACPMvKrc6pJs62NtdBXeYM92PS329IAaMkdofC?=
 =?us-ascii?Q?lnDFzqZ4rp9/u8ffsMBFsZ81pKodlDCfSusYsfBWEn1nSwoCh7o1Wi+uV/B1?=
 =?us-ascii?Q?FcKw9I+hHjUcwmskIOBg8NBM78DIBZ9xpl11Z+iUelcaaJVMXsXnpDqAT7bn?=
 =?us-ascii?Q?wcwadw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:46.5668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fa997f-2bc6-4ee1-c82a-08de538ca545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345e..d78b2c2ae13a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -451,9 +451,9 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
-
 	unsigned index;
 	uint64_t gpu_addr;
 	uint32_t tmp;
@@ -465,22 +465,26 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		goto err1;
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib = &job->ibs[0];
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
@@ -497,7 +501,6 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

