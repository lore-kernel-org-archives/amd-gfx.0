Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE0FD38FF0
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111DF10E652;
	Wed, 14 Jan 2026 16:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFUPnnau";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184B010E646
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZecu+a2lApMJySaHMWjrnqOuzxi9X7sWcwfWAIwKldV7PmCV/9+MUbOJRc8WB33/i3asS2zwLk782A84y4ea1lYVASts/IbWc32Z5H+/jDLkInrEXE7oYgZKCJ39Ns8/qzI0hMRppVSNec4DUatNfq8VCFSf8lYppdPZf433q2uw3HJvGt5+JrH+ti2e7A1sBQ6rpFwPgFV7YupBSieUVEX1f9Ubjv++mh8h44ox+ycUE+yNs3nVdRdEmsgA7xDPcKCW7NUjXJlkvp6cJNmxUZlQ0wbWmHQUPE0ynsa3VcSkNxM+1Hw2tlADKjyW/6q1SICc9+gJXEEEKXggV2bjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH7Nv5WshC+pPRLCYDNAfELJjhz9RQ0WarKmvDNJzMA=;
 b=y7Lzb3Hy+Lbnx1mkjRK3p3tC24JE3+Nh8idgnLZ7XCyguGXUFyWGOjmcxnzRpEY/ngmklEBLH4cPmUxXLgd2i+hcr/LKnMJGVaQmCaV0D457n7TJ61JaQpVzXvCh0Y7A8qQs5U2Geud5GkMtPAqr+1kwQAKcpDFz1B2aSNkK8772N3IirUgr4QO51PSfvQe2j+f/Sb8le2jEqf35fQuwFgVxiVJixlNOVODnhwN9wpARXAJ6qZkL30Igdo8DcjxqaaucmrhwDrfJ0qg/iZk38Wzpu+D8VB9KzuvRauAz99DVcaZWphvw9XxxwC5d1ANob/fr9EpB6x7zi2uLv03Qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH7Nv5WshC+pPRLCYDNAfELJjhz9RQ0WarKmvDNJzMA=;
 b=AFUPnnauFetLckXVxDFm7z6dYCwqb57jh1wnkoSA6W4MG7JDMZZ6qO4JGK6H5UTvHzT/cQjk745v1UZ1R/irZUuXJktWdToLo1Arf90EE0UNcqzuq+/tMRt/HJuRh9nEaqOi6rEzwMIWZeWxloRH6NmtgI8SD9NYFHvICrepPfw=
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Wed, 14 Jan 2026 16:47:50 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::5e) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/42] drm/amdgpu/sdma7.1: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:08 -0500
Message-ID: <20260114164727.15367-24-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 049ad75f-d0eb-4f26-bb08-08de538ca751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TyxI8qtggFsWgk08aAv1mTVgHdwgbp/kw3bDKdYcwa2K7J4TA3NqJQqljJ/t?=
 =?us-ascii?Q?wMu+J/YkOOpvcTFLwmNZK+StTIkLHuyAszRGQEZDgwhbiIxe9sFYUc+6thRc?=
 =?us-ascii?Q?DLdp0djf6cAhTLY4OouM5xPhqhxJUsVEkHIIwHWKn7WvNljQPUiGJ6c9i7A6?=
 =?us-ascii?Q?eed9c2lJXUuaJtQP8npTo4FoieOIXUPn4+9Vlavww9eljThUfSTX5DtSrAJk?=
 =?us-ascii?Q?d7ITWsiyccFQqAykNfyo4SZPFQtLJiuwKKvFlTMGNzQHMZRoDs51qzLJ/olt?=
 =?us-ascii?Q?bdo598EFDYsylAs1wmjr9uc5/MO/3CG9PLiE+I20sUd6ZH4Vwn4+PgjYzXmp?=
 =?us-ascii?Q?5gCI+uW8NVuviP+6w3d3s/KLgTOptSHP5Zl1DjfBXvEQeeBX+5ox/aanCYUu?=
 =?us-ascii?Q?92ezFV8+Nvl4nnjADHPOguo93JlqW7EqGMe8DqOu6h/FaBeGdBi0/vIcxLci?=
 =?us-ascii?Q?hRXGkhMBh0ymTPeqZiivFUI3NdW85T3PJQDEbByIjvDj4+PFgsCE1VIzfNnX?=
 =?us-ascii?Q?IjVZWG2PyQiw4RJXAZypYdD8NxsMfcw6ZrUOsj66aI94CK4+5M9zZU7CX+Vx?=
 =?us-ascii?Q?gEBaHuDn6lVa3jsFiXXv2wNhx6UoH7OstWkDluzJL2dtVgRBz68tjsal0lR7?=
 =?us-ascii?Q?+JHnRHsB05QWR8Dc11d6omc8ytLyGbm/2ESHehn7jgtZEp2kiEjHbke8q/FU?=
 =?us-ascii?Q?Jyu/Pu/EIAyrzjXT9PHWR34CVVI+MpNmWjGm1ccDYxgUhQwzdQxXVOqzew1W?=
 =?us-ascii?Q?cMm0jjQcY/o2vhZI4+6qZ+z17uQzDQQK+QxzI7Jj2Ct13bZqkWjU+6xiwtat?=
 =?us-ascii?Q?oML+WpLCju6HVqcv2b0wyHk9cI11ldOnDefp8Rg19dq8MjCkRDLnZtqs0hyY?=
 =?us-ascii?Q?BdMdBoQ21phwX4R/14zMKjuI72RR+LLuphnuu9QTJVDAyNr4npLfYBPAxgWT?=
 =?us-ascii?Q?I1b7KpA6/exrR7od7Xle3lPFwx+Q52uWZJL2XwbizVaWnohCgd3CM8vofAzu?=
 =?us-ascii?Q?y3rKaExPgWCjHaEQr5ZIqdQxy0gxUnklfppLmFnMuc+pWnab7wUWaVnGYwi3?=
 =?us-ascii?Q?Ed1BaZTjKWiZqMAuUCh8KinIvljLF6qxnfoumONAR+ADiBR37V1w9wZwVTs0?=
 =?us-ascii?Q?FZ8ia/xX1IFPaRmQTkaktjxIGwNTfYxjlL68buUHVW7ewEbqLDEIlW/O+ko3?=
 =?us-ascii?Q?aPTmxXkH9FUq3+SrJ/yWEd7tCQ5GGOn9NXxhoSaxplbQyyTDxgsyXz9HELKo?=
 =?us-ascii?Q?Lu1SxNxNgD2aWZfTSdQ0PNLldm6O0zlvvCZvEm9yLjFjDI5s/CSqBFFPXxYR?=
 =?us-ascii?Q?UXxdmYwxhRUMI/YmjrgW7A4PM+UyIc89fGEpqgFUJLodaGdmezxbJE76Mqrc?=
 =?us-ascii?Q?0vOMUZPm3YJRpwwH2b0z9xkEsVB3karjPCZ1U6QGi3pN/fX0a6nQo3nwPZjx?=
 =?us-ascii?Q?UdMz9xAOIWrZQBPZhjj0nx2La/C/3kR8w8p/Muc1QGRnFNqaygLJ4MvDfeVo?=
 =?us-ascii?Q?j4GFq0lOLW2aSSD5Kd2+wXVuge0ugcz14LE9d4hsaKGVeysokYCX0lO42hP9?=
 =?us-ascii?Q?k0ri4Fn+tyax+yh0+Kh/JQyNTkPu7JHJax/Ikx28Axa/zaC10qMIC+74t5lN?=
 =?us-ascii?Q?x+IcewX0hHQLQz09GUSn2jYsW6whC30xziaYP9KFEEBWgN5XcKHyre3gTglH?=
 =?us-ascii?Q?rXAWlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:49.9533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049ad75f-d0eb-4f26-bb08-08de538ca751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 36 ++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 5bc45c3e00d18..d71a546bdde61 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -987,7 +987,8 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -995,7 +996,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1006,26 +1006,31 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
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
@@ -1045,7 +1050,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

