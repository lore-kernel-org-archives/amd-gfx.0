Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8780D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2F210E656;
	Wed, 14 Jan 2026 16:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AGeeHsL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEEF10E65B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRVR4dTXR6/s9LXB9krcTjyZ5AtPLLnELjy7qkv+dBUmQg13/ERDGAypNrO2zhcNKcbz+73P/RUnTcTV0fKFt7GkunBLe6v3zjQy7tz8LLAxcHB79uKx/iGJb9O0GPyeaqWjWrzV2UaB0GazPTbCsRmGEjNnXRgnkh8ir1qNK0ZxpQqZTSTF8Ggri1ZrE9YQES5KFPP71vCtJ3RqdJodcfwZIrMjIwwYshWAyidi7E7dKkp8CM7nJ2mftg98RiGixtDGPm04xEIKUlD0QlYuigjPZBCgjVlJgrQTczn6IkdOWhUlOIfG/eJ4gutS/B4Rzvw89ThBbk+9odOdPAE0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPL/oONtEIUQqyo4GDNx8jq3sfTxFTlMMnadjGsVAlU=;
 b=Pqmr/JK+VECybeWqqRlx9LUMDHCSDCOHRy0Rd7KMDmo0V4NDGlK9TBoH2KkPjtErY1XLN20R6ZxgqVenR2QvBTcjsxEYGkp2PWBwrkj9KP+sSxMXV7ZioGPePHuU0TIV7UV6F6pjoUw2U7lq1usODmu7xYsIFOw2XQtyMTGA0wYQnIbXkmyO98Kd2WUFPoobLJcLVKs4any/R8+1lCsu+nl3khyAKeN857Ep+QuFF4oBrWzC1yNg55Tcz0zarh1pQ46/LMJ7l4LSJg7EazQqZlP9qZTg6eicaiq7mxawN3jTmpt5kaiLgbLHvJxtEXe66gQcAD7VC/i3bIr0OldlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPL/oONtEIUQqyo4GDNx8jq3sfTxFTlMMnadjGsVAlU=;
 b=2AGeeHsLXwKJOeJJylfNbYLRY+kDyOsfuBLP4TJ2evo0Ihb6AT6m8y3OlildoOI4Qcf4fcaXz7hL73ilVzKhDrorCkbsYlEAknEiPRpKP1Dcz7TJ5WGfoIhGEyfK4U7Ylw+jUoCRU7LKgExDyMEBNHZxS1PlMsHkMcTQEWOyiT8=
Received: from PH8PR02CA0019.namprd02.prod.outlook.com (2603:10b6:510:2d0::27)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:48:07 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::4c) by PH8PR02CA0019.outlook.office365.com
 (2603:10b6:510:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:45 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/42] drm/amdgpu/sdma5.2: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:05 -0500
Message-ID: <20260114164727.15367-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd129c7-5bf5-4024-bcea-08de538cb1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b6LY9zPbdnqyxgDKQDECHWOmCidKOJ4fZ5MOy+tG8zz21tgpo8KeVVSyBL16?=
 =?us-ascii?Q?+w1H9xIQabTYq1zfkbD05eBd8oj1IdF3UklsqUhx9pAbRmw0ezfKnQ9rLJCO?=
 =?us-ascii?Q?mWLBD8cJdyBs6JX9BO916gBUzBeceYUyNJnPuzfORbw8k8emhXpjsI/G6z3c?=
 =?us-ascii?Q?dM+d0iiA76LV/r/Zx6c0Psyz7ZMYJmIRTeRzjpq/ZfGOHhR1zjfNLk3Are9b?=
 =?us-ascii?Q?VdpyFR/d3ITsei48N0WRGzz8zyT7PR3sp97WHai1uOUJASYTw2kAn2vRT+Vo?=
 =?us-ascii?Q?pzGYQdjXL2EiVZW6YVZTMrbwzRI4Z6d33OkpOYCWzaYbORb9rG7Qtd5eKUr+?=
 =?us-ascii?Q?uLFrblUyYP1FKAu7SkENzbH1+4jRNC9bGy2PxnMJXMbvG3oyWafxAFv6FOK9?=
 =?us-ascii?Q?2bWqjxYUfV/J71HuH1X/dqvyUvBmMzdmmwZLhSn1HLizHHMzmrCcZUmqURCn?=
 =?us-ascii?Q?Q+TzKukcAFdy+Ze3bAJODtgFGK/dBplubClEKbxzhK8hv5Zel3i1pqofInxd?=
 =?us-ascii?Q?OWP03ltqDBoAEeysgCO0i4//usM7Hozl3K3WMrNaO4sRNN5pEthB7BMYpnaU?=
 =?us-ascii?Q?6Euu5nMZeAHAlxdYyf8I1q5Pz5vSZBmx5uRmtaMc1jjUUaNYNIs4FmdJ30vp?=
 =?us-ascii?Q?cGWKpGeMHDX3whCr+RB9B0twMEL4lW+k3+4ZPVI6YxiR+AWDECkLeUKQJMKc?=
 =?us-ascii?Q?ii+Y27MJsrrJC6w3uNzKvaiA1HvVOU4eVNbMnlvoXewDInsdb0RmSEIRRSBr?=
 =?us-ascii?Q?NB2lQMn/GVQmu+dkGPOqxBiXmEQ1SsxOwibFNX0oKwlIFGLwfMCf5ryHWHnq?=
 =?us-ascii?Q?84LudtdgJJDTamXf1ID6UpiYIWNL7HMF7MVbdpnQ39vh82FnArYJx2vvYqie?=
 =?us-ascii?Q?UBwswMjuaMJYHc6ktzRVpbCH1ht4y1YQXX9ySHoYS5IZVCa/GeSYYTH5IJWG?=
 =?us-ascii?Q?+P7SJ+PQwDPoaOSabqy9hUw7T4CNV8kyyhCCEdXP0onBM810kmt8rIABD3gs?=
 =?us-ascii?Q?CrRPM0R89pSyDdksrkQN1f9CgVEp7SVQhD2nsiuxT3msjuIwtueIe95cl62J?=
 =?us-ascii?Q?bExRlM3FnsGNdFv5bbKXui7Z7APtFCrpK0cZgpjZnCR5eX1edO1xcEPq+sHF?=
 =?us-ascii?Q?ZLOGuNBkq4fZtjRSoigN6VMmus8XW6GKnj1pjyHNTlyIVIU6U4Jx53Y+jxBD?=
 =?us-ascii?Q?qi+DIeYWXww5znCr09MxiNORIsT0axq/rMSlxycxM9A2q+Yu+/in6cKW11km?=
 =?us-ascii?Q?dACbiSlLA42qJmhnX9hqfT5gRUepDD4KxA15EkeUM49A3qDtwG/mS45DzG8Z?=
 =?us-ascii?Q?n07g+edI2+ih+zKhCyYsp3BCkXb4Exww6G8ApLh6W8ow9grgG9bcO5NYBpk6?=
 =?us-ascii?Q?UYsb/M2dCstb4nBp0MPvvZ6CYHwgXVwPnn3lKB5GDdYuXgY57anJiV/3ZsGC?=
 =?us-ascii?Q?nwo0oW6j8VAw6ZYKIXyiZCOHfFvcmSzkiqIIvil0JAC4KlEXv80XHuAJlVhB?=
 =?us-ascii?Q?eaOthdD6cfW9xKzIMRh/jhxItAUV4A2Q3W8gWFCc853RWxdHakfJfXRIFBIy?=
 =?us-ascii?Q?HZntXKO6OPWFb8Nr1mXzAe6VINzPw8BcK2mFXOy6Oaax1C0+aPZxcMIxLiCH?=
 =?us-ascii?Q?J3SH8rtcH8nTyJKbWUQWFH21p18qOWu8t3ItNwlYmaxvuV5wXBVBMky2MRx9?=
 =?us-ascii?Q?s4hCBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:07.4199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd129c7-5bf5-4024-bcea-08de538cb1b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 36 ++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index dbe5b8f109f6a..49005b96aa3f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -974,7 +974,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -982,7 +983,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -993,26 +993,31 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
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
@@ -1032,7 +1037,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

