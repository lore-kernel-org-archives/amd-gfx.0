Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B6DD38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274A510E646;
	Wed, 14 Jan 2026 16:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xthbqcZW";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A414C10E641
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOQ8XgJKS1h7G52fZkmoXtPE2tcoBRDK0uwZPw9r9zSKs9dF3WBFunRNrp/RCBRTZkCGQpyvrgGlqNTOsCUOSzoaAD8edQVJy3DuV02gAVfDbuwpFFgwDhen99YhwHFcKd379L4k/aliMzootUyQ/PKEPDrgNlj8ZaDDASqLHSg+0EMtmny9aPZY9PRpaYxaCYKaDn8zsijuTeK/W5PpPpV0ZrkeaGi+vCouzwLkYTCooQRK7lumGOhnJhsjRKRLHWPIAFlo4eh/g9MMzbmJWZIwYJfzAYRvPa2zH8VsFo0v1NTvXieblnN85VVpj8rAfSjGfFdoV6Mm1BPSQVHhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk3lCu1WmT8HfMVXlHM64aU+6FouJiW1FtbMnxYv00g=;
 b=c/IzXzwaH5QQPsRGWh3RPbVGyJhj15RCA6cQCYHW2bUMoPU5O5/dBfRGGDPAxoA6A2A+krpVAsxRlpTYFKDbi7iz2Pj0d0LgQJHfooxacrL07PlScqPAnp8EfBAGY0VzXb3epLAvLCA1tLxzidvhck30bmr22X4f2WYxnwG9yD6XhWEQ7KjAuaGi63JhAKZ4fdjz2paBRbGqFE7TJ5LVyx2uEv5fK+UhyKTneQGFasJNOIwkbBKqFR9yDgbmKIYgD83ckOffFsc46yotHI6XNWxdS4PkpUu9OADFEHmceNqSVP+uCpx/vwEcp+gsIWC1OxqZdW69Q9hp08pooUlymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3lCu1WmT8HfMVXlHM64aU+6FouJiW1FtbMnxYv00g=;
 b=xthbqcZWGcPvmp9RjSZXi9s6wDkv13mbnU37SUj6xzfDB9ffhEkkd/uOTnwx3Vukm7HPkZ/9A1KbvH63hy6TkIsrHdRB5SsHyihHgTIm6EorNIXPJWpsdSHPs7rH+NyPwd41NkOQF+zpY0aqcHTX9xcJjvC60FJR58+pNns8fIo=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 16:47:48 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::fb) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:44 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/42] drm/amdgpu/sdma4: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:02 -0500
Message-ID: <20260114164727.15367-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: e07734ae-c221-41e8-e2e5-08de538ca5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XwH58w8OCuNVeoXHvNzBfDnNrHi5YkQFmOc451iCKAshTuEUn+dK7kKV5gkY?=
 =?us-ascii?Q?CjVJbblwS4jOORxLn39iIu3jsf7qboQ92sTB/eERkX6EOihnzOC3a+tKpOXr?=
 =?us-ascii?Q?oeScVJUFBCJm8hLEbOGRyeuYJhJ9J1uWjiBLxN8vM22EBxQK/Uy+Qc0oNAOQ?=
 =?us-ascii?Q?fcyk8XkqN+i7yM5r0vfKWgAG4BPoit4LfeXN/9wH079l0NRsOxhnTOCHgUQm?=
 =?us-ascii?Q?2odoHKoqZT/r1bI7X3KZXC0ME80Be4jx/qfKUwD21moRkPm1w8vodMDE4pv3?=
 =?us-ascii?Q?tY+IbbMInjmk/2hcGsspiCLk9zwxoG5QXiL4thkUB4MDJ/ka1IAVQveCxK53?=
 =?us-ascii?Q?i09r+OzbXEoWkNEwsQTrRHdEQEYKNLy6hf5BzRqAi+6GmZ5ZxEJ4p6JTjiOE?=
 =?us-ascii?Q?HK3xLeD9kBeLY1A1KjjoA3A4u/2rIzNjcJq9b7Yr0LH1nrCWhiT5vyYMCH2v?=
 =?us-ascii?Q?PG1gDUOedMMWvxzsQ0jY6hf1BvRN83PNTNVYLrgidQXcvQTirgoOiAV7gyFF?=
 =?us-ascii?Q?WiCRX5PWF2QN7kNdHEMAKy49R7My88fLVdLh87BrqF+n43iFMh3ffgv23L+d?=
 =?us-ascii?Q?Jjfh6rjK+fGYFAESFSB+kvxDLKzhmVqm1kktF1CXSwNW+4xI3rKoaTU35rup?=
 =?us-ascii?Q?i+czE4SXxtUui6NQQZq2hVhIwFEKeTitsmJ79RRSnne9A96vTihIGuL9CQzP?=
 =?us-ascii?Q?xCV5bMwOvkAI2zK2S48QjnlUkfd9EsR6jppCemGR730rqR6HHI4UDF3le9sh?=
 =?us-ascii?Q?MC9P76iQ+cgwLR6NIUUjrgmfXxooClZxsVE46Ufx1MtWjpvM4Z9lLOmTRmvN?=
 =?us-ascii?Q?0Ibu8Ee3fL8ROlFjjlZZnZn3CezXiHPabZtoJXR0d+N9XGv5C8f0lw/6W8Gl?=
 =?us-ascii?Q?Ob9bg3asfKi8774Lbqg0efLxPPvaOFQIf16RnJko9qjOYpQYCr14rAeGJx34?=
 =?us-ascii?Q?bCUC90TsAKcxsR9lFaVKV1dLRAxyFn0u6JmFPTtknj+b/esko8PXRgIYxLWZ?=
 =?us-ascii?Q?sjHklOqX1AfY0nZ6GkdyFWLrDTXSbjdbDtAQith8AOHI7NkW6dYVcrxWEul2?=
 =?us-ascii?Q?di4/XOuBDDKxwepdqy8ro+n/8YdBcCWc9PbJSh6bTtXwpaq8O6EOncsXiYDj?=
 =?us-ascii?Q?xn4rAqAA3rKQkxVJbH/AaELC65WgFMxlW28+i6+4r3sb8AEWZ2a5iPAU1Jk4?=
 =?us-ascii?Q?R92HMi3Jwtf41pGjT/8apjkscRSDcZ4rVXVO3tGSdmPtJrXwWnRPfPdCYdyS?=
 =?us-ascii?Q?WuoC+BokbgG3QnqomcXYffRz2JMZmxUFvypmQS1qPg1yQPSQ4+e7UMdSpeWH?=
 =?us-ascii?Q?aVxtXa3ZHFT7gLs6jYtk4x8d9TFeoQcJhP51EHgepyrsqxRYOPZy27KEYrgS?=
 =?us-ascii?Q?gOhyPUH7lfCKXBgy6/Jwtws4jVHL4LQeefTBcqgYlKpUh9JpxOPBoCZ4vQdY?=
 =?us-ascii?Q?2MLT+aBZaZ1z81JgPUh+NUV0OZZb2fDmsyMNzL42i7H0PZoMY0Ry8SA5NyNp?=
 =?us-ascii?Q?pcfNtUr7WiXqkpzxO+5/4MWpC67Kk663PiuRUF3iCgFdf9K47+Dj8PXgVlT/?=
 =?us-ascii?Q?W1KV9bgxcMSmPa/rAFSrbGd0mqKprWON8jSdSrElKeNWuQWYv5ppYX66kHFk?=
 =?us-ascii?Q?6pRWG6w+nFdtWdYPMFmpianG/SwcA3kzV811kPJLd+Od0potAbwISrQ9RnAe?=
 =?us-ascii?Q?0RiajQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:47.5957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07734ae-c221-41e8-e2e5-08de538ca5e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f38004e6064e5..56d2832ccba2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1516,7 +1516,8 @@ static int sdma_v4_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1530,26 +1531,30 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -1565,7 +1570,6 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

