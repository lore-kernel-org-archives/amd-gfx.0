Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201D2D38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBB110E65B;
	Wed, 14 Jan 2026 16:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L3lvxf1v";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5F310E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soQ8H9gFtuMNUI4GeZNstTVHJhmkM741vKHXFPU+tkcFCiDMUoT/2tJOOgqkxhqwwWjMLtfOj3x0gBDl+haA56h01n7MmmtlZ2Lz0T+ZWwRNThyr2b5/Agb9iHnpTyZgaXaFNwblFDjYr1wJK13BvBB6d30N2BKIYQfY02w/v007vZ6zxK8/k9xf2QQUb9Ooazd1qpXz1M4K8sea9tltIArN4XCR0HeGn57Rxx1N1sA5OMjcZF79XSvsdfj4dw7uFGTS/m7XyXr6pakGZ7nGpZTkXlFW4VkNheAEsioTi3lKRCCTO42yBcDReOPk2JwX+DLJkXxuRfL1vrkBnXzN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a5ApWLpbn03hkGGEajPn7nsxGvw1MmwlDMQTlWJWjA=;
 b=eUqYQI7WKvOcOxNAuqaPZT5zdQZW7Mt/Q0/3odYmJpwTk41t8uHtctGtXDiWGo5YpNjXvxOp/ZDTW998DY8UpsnrsZjaCnPEQ/1G8uhFQfeSPA8XS3l/sW6tCt+QZctZ4A6nBDqjjmkTwf4OxJp+sje0xo8Fu9ka+py6fSLxeC8KktVQ0cxOHdOduVXnWnrCWpqaVMr1raxA5HJG6dteFp1J8mMvDq4FBPF8zgVf4R2ibNEimgz9q8gf/VSSKnhKDvrsbLGCo/e0WTg5vBgj1WxBo7oQZaZd1xZc+TTiUL0SKEgseFjZk8A235TC59Kv8yT+vPeZdAgE2mpB6rIh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a5ApWLpbn03hkGGEajPn7nsxGvw1MmwlDMQTlWJWjA=;
 b=L3lvxf1vtAMoBRnvP3YlQg5FR2rkShnrKgkP727DHsV8yT2fpvpXuovCZQQQ1zXrIIZs60eTh547cl5XtFsM0Sg2vuTbKJLgv5LWuVnX7bG3evlO3tB+TRQSHh99/p87ldgVbgpyA/bfxoEs3DzJPoLjr19jodrgoX5aEzibHMs=
Received: from PH8PR02CA0019.namprd02.prod.outlook.com (2603:10b6:510:2d0::27)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:48:09 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::55) by PH8PR02CA0019.outlook.office365.com
 (2603:10b6:510:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:46 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/42] drm/amdgpu/sdma7: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:07 -0500
Message-ID: <20260114164727.15367-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: d38b5255-2205-4f99-44f3-08de538cb2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QChwy+GNEjNj8MD6L+6/s2iV8lpPhAaPu1GY/qem3OKn/urebKnrQ4MZlP+1?=
 =?us-ascii?Q?WxrJwPfi1xMb6Hf8EI+B+oFQHeztNrgE2ignsqSvkSzpyaSMoNLWWtle8xaz?=
 =?us-ascii?Q?r4N4EjgpqojKM6TuKEBhiDAHj5vtHSbK6YHcTXxxqj1T1iOd+6PF8S+/n0QG?=
 =?us-ascii?Q?FFyHWHrMecciUhq2JsjKYrWquQq04Ujp0jaulP0BeQ0D7eHj5E0jtS/5PKOC?=
 =?us-ascii?Q?TJHGyT+ft8660peIUXhHWrH0u5igDbPUJXxCCzjVUJm4zPhfZZMSQV6D4ixB?=
 =?us-ascii?Q?bksXh/q1IS+QvGrHblvSrk1SJMQtHXccHXRjIx0WtgIIfTnszYaFT0Lw71c1?=
 =?us-ascii?Q?I5M5qHfn2OJVsYR60cw0vxf81vZlM5NPedO+rfIyaRW2xwZYLYZw09X4F2FN?=
 =?us-ascii?Q?yB4RHwusrb051qUS8hexnr+aDnzahzkG8hsC8QK9aXzD8+09M3NEWkhx4auV?=
 =?us-ascii?Q?N9cLCxf+pz/HdPB20v/ljz4pm1rSediYB36ysIQtZo7u2RTFAV6apFuBPfqv?=
 =?us-ascii?Q?4Wu2KaeFTWkkSHza8vaYKEA8offeH57dlJ/Sq7knr/syJbHUO0Q7in1I672V?=
 =?us-ascii?Q?TBaVh/6h5kdPb4COaCfYFyORp/WMBwgRQqGDsX7yQv9p253O1N/arn50pnPe?=
 =?us-ascii?Q?R1xdV4doEhnf9y4ru04D/IZ7PA4P48dvpnvNmg4JWRGhU5O3hRDCTduIJdfk?=
 =?us-ascii?Q?R93I/MIwe1K6+ONl887XlxrCeXjUiWcdUrY/Y4P+ROFYbtcQAaK4B95M9UXY?=
 =?us-ascii?Q?OpiiP1xccKAQ2fsAzbt3yiP+HTLRY7qua+xWnGBcH7LvnxYkVxDgQ6y6Npw6?=
 =?us-ascii?Q?ahuJJjpQvm+x6imUHseB5J/NvCOUIuL2FQ9ZAbkNjepVqow9fsgvGWvS4db2?=
 =?us-ascii?Q?/7cK0d52He+Sjy2JuD1HwR32Eq0KxSEemAthZq8QeRdSxNhQso23pFFClxpC?=
 =?us-ascii?Q?E+71XaQmE+G7UbYT9KjNUtVMq0XneX7TG5WOy1Ebe6i3ddZiFCr4Rd4zy9TD?=
 =?us-ascii?Q?IfnguLpwhbcOmLqFqUCXUSTrA7zWgLCWbMppIC4hzdk30sfhQZRmTZr1RbCJ?=
 =?us-ascii?Q?xtS18j8olWGnOH3V/zGWFqngfHqKiKesm/4xDDWS1+8KGyeMVNRMZS+/q73F?=
 =?us-ascii?Q?Q6TL7UBvTql0CORwNVDflNcsD1LTn91bcmoxJilqa1RdyZB7Ic+RIJ7hT76B?=
 =?us-ascii?Q?GMAlPn2Xk6hh/60V8JD2ZFj0jDKe7bsbySACQuLYZzYcFgS1+N7wEh2QNAMb?=
 =?us-ascii?Q?h4e5slTrkiEgPiQav9RMWuCRUKpAMmqAka7O2U4yOwxvajM4y08No8wknUJ5?=
 =?us-ascii?Q?J2domnu28mUbRJLkjaV71zT/57FKdAoSw9abeY2jTk4PeENmuTTJRkwQMmav?=
 =?us-ascii?Q?VBePSULwHwWYopnFCtx88f3F0HZVJQdLpBe5do0psC95kwE+CzJk1Qj/5Gnd?=
 =?us-ascii?Q?97pDmnGmDCj2Mz03LniBwdiE7fVsEiYkW1atH9ml4vImfTKNk364kUYaXST9?=
 =?us-ascii?Q?+18q80gBACFnPObH/LsgkjgQwy7LbUa9JPJykqqbr/sCJliSyEG9bM+psynv?=
 =?us-ascii?Q?xHb/tjrgnaRFwcmX00xVaV8g8FTzaZtKhiXz7rbrr0SFe3DX/qSpm2HzvN7M?=
 =?us-ascii?Q?k7C+h3V5Jh2/Qzxsl8kv474I7uP7hyiWu3fTQuAcW8DjATkzLtHiQx9X6aFo?=
 =?us-ascii?Q?kiHLLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:09.5396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38b5255-2205-4f99-44f3-08de538cb2f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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

