Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A5CD38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C792B10E64E;
	Wed, 14 Jan 2026 16:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMacIz1C";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7506E10E655
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNIoQVVEIGXBMl9LX1BmAHcLNzMyxXbZg61T/Fw0W1h+IU6c0wQ2Y5M/LRONWqrbbYBlkg5pr8NuDUluvzX/lijjfex1CuCB16C9YKgHsL2/YBuXm5ofNIe9I9F0t8LMVaG2rvQGYiEMK/SxK+NCV/IW4gwEcvw7BUmSmIe1id5m6AkNkr+6l5kber1VHN4KM1V4g1Ev7y21O6J4tBpKV+PNwAtGJrAPhNCxo8VITMlo4VEhZsSG2+ERJuqqT4icJyFA1Br8vsNPVHy/FCCGw0IoAHjaE4DqGs2c2JE8RmclhIrlT+Nk8hZt2DXJTtmmPj5G3q479lL5hO4oE2+6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd9/3qs7nmmyKxOV0C4ubEP0KMKKaMtJd6v0BIT1nTQ=;
 b=jdgK5+sS5tgk0+iiB7ypf9R/p0HuXwUxDFDP1KZC/hc2wN3QKRpmnvxGI7jhfHa72Bos2dvABvK97IZ3JdKQ0VnbqwIIMwtZG/4ruVFlZE4Glf2vjW5TDKJjIAhKL822PJl0/gfc6SKbMbtPkOplFTsKHhBp5BvjZWE5C/BVKP0pB//iOXdFXKehCsLf4PLuNUTjjDclk1HCHaYtvV7jwMb3zEMP+qvsDZaefe8a5GC6SbO4dcBTlyUZqr/7q3oWm6Ce6JnUUoWNqXQ8R8waTr9lawMTZoid1CKZuRHeXxfumn0OGIV8yQAC9+ZligYSaDFdFkHbAfSLowgmT3mNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd9/3qs7nmmyKxOV0C4ubEP0KMKKaMtJd6v0BIT1nTQ=;
 b=cMacIz1C1FkNTEkg8a7nrDIdJqzOtWA6yqunpORr/AJ9qeqxLFUCfjQ13CAJDU0mlcja5LJ7hQyx6HA5AZZ+kFFoWZAeKYbhEOf9I28S7EQ+g6bb+LURQo0MrYLWXIAmFjhGc45OBpFsYiWssrdLlpWEhs20uxt2i4XgK7dHNio=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:48:06 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::2a) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:43 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/42] drm/amdgpu/sdma2.4: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:00 -0500
Message-ID: <20260114164727.15367-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: de18aaf9-8084-4ddb-9537-08de538cb0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3oG+Pipp9bNG1FnpQ92sKjXojKqkOjFv2d2w/opwzpalxFcsv98fEd3fIyOs?=
 =?us-ascii?Q?e9PJcIMYGP8UoxnUjyz8UYdjhd92MVzefQlW3zBY35TFuOi8DH/bfsAFVqFU?=
 =?us-ascii?Q?CQ4k6KrYMuEG+E0muOFNTTI0n3QY8rX3QsWHKcA7La/tquTRJJmo0mJLRfBt?=
 =?us-ascii?Q?AP6Ug5h5Qqc974PhtPpANtuc+f1cF4N7WBM3QDqUgKg9uA2YSrSme1TLPLQw?=
 =?us-ascii?Q?sFW2KSQF3Jxj5/sYnzAuS9LNFOAfBZj3KZ0z6VwTLhVBkZgX+wj+kn29tyf2?=
 =?us-ascii?Q?IEuEwb2D3baELloIVDdbUFqNWPUdsAuwetsAwU1vlMTheYDrdSSfT71YDCkl?=
 =?us-ascii?Q?mspSTpgUQhQT7t+qb0UgsmJSJPjDIA+AHq8Lv4kiiQgx5l0VWWZQDsJ/VvbC?=
 =?us-ascii?Q?bszPyHUh3vx7YaB7XXILdr19BivuM8ArZ9z1/b/JbUPehFBJlsbt2+Wix6h+?=
 =?us-ascii?Q?vESCEVTNry7C4ta3alOyzH7XkpsMB9EL04zxi6pNWIm8bzChIvxDKm10XCkL?=
 =?us-ascii?Q?NibL0IcSqJ5bwEO6fbucF7DcTYfj+LOMoHM0IxjV66MSWTdmVPPjHU07uSBK?=
 =?us-ascii?Q?AU1sHrr4F1eNYgBfUhzjCgqyjG6Yrud0bhVCTrXjJC0L4kLc2f6PyCsTxWSM?=
 =?us-ascii?Q?MLHIQXw1ULH2iXD/KHJ7iSnPg9/UH04Lt89jmZ8PoKsneUo3BDoEJm6rXIvf?=
 =?us-ascii?Q?FCU8024PtIiaOTDES/BVGQ4sPclUPAFTpXqY+wxyvB+3X8cmXh5pbovra4fD?=
 =?us-ascii?Q?JXFYOKt5cy2KMXRFz7jpC3rWfKdyizQbiNKT6qe3vB61b4YtlKc1qQZYMP2N?=
 =?us-ascii?Q?WbtXML3MctDcFUCiHBPS8wj+n8fVLsL21ZR9HbbV5TH60Uav1vGFJcn7FGTo?=
 =?us-ascii?Q?pranUrgl/NM1gx5hXABEbx/QtvNmqa2WOKbRtp1jyLkA+u7x2zwpsysEvpl4?=
 =?us-ascii?Q?M75wE2gM1C881vykvHmKEBCxyGOJ0nPGpwZBj6YdxPHhO3n99tftlSxgBdVg?=
 =?us-ascii?Q?CmazaGDPOwN0cdkG1UF7W8OkHNNIx7hdnKZmGYAG1MTcPXOHngkgWcMkqEbU?=
 =?us-ascii?Q?qfEwz34kBNRvvGzlJEKf/TPInkzHnlGQjjUasi6/RVcXd0we33JNM+lEyN6i?=
 =?us-ascii?Q?6vvUbIgsdJXZ4MHotf5cbyf9Gp9gs6HUDaNbjUKBy9wKamngR0Hk5CjlxFxz?=
 =?us-ascii?Q?vdzGP4PYFKsXOhCGf38xrfj1KLaqCOpBfdOsm7V36rMZavA4zAwDzEjwsw46?=
 =?us-ascii?Q?7yumsu5FiqaOmrFjXhypkkHrXodNWqZnsxa7DBOFskMdndufd84KDqBygMDs?=
 =?us-ascii?Q?sHVIt9e4Pni4rdZ423XYHE0+cFvk+Oj4S5ArjjACnMwxNPqh791VCp/GqNo5?=
 =?us-ascii?Q?eQLdtLIz2hzeyKme1PSpztjB2WYdOtuS3T2eahhX4hGu4VKOeQqf5njcTruN?=
 =?us-ascii?Q?/wFWPpeY/sbsV/26rR7I6BuHPmZXcHroRQ1Xqi1z1ZT/J14fggVCiejJRT6N?=
 =?us-ascii?Q?3sb5+xhc7AoOY9FJXQimHFPB1hTMboFJE5aYfdOpYb1sw6nE1GdC1GgtGbgK?=
 =?us-ascii?Q?Jl0MkrbKDjOw8DTYymoVb4O/2YiCFi+Hs51stc7jz26qvwon7ipMAL3sonCe?=
 =?us-ascii?Q?0zdTeRs4ePdWxR1zUZ1jG5n2+clq9w5Sqmliwma6VhsKVMzLEmtH+os0zh1m?=
 =?us-ascii?Q?lgWJQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:06.1760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de18aaf9-8084-4ddb-9537-08de538cb0ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 92ce580647cdc..46263d50cc9ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -584,7 +584,8 @@ static int sdma_v2_4_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -598,26 +599,30 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -633,7 +638,6 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

