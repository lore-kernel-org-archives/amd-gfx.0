Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBEED1D46B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7284310E762;
	Thu,  8 Jan 2026 14:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3CqTRfCN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07ED210E75F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3weopfNHy7nBnHFtzEyt7v5o4GlaF2eFgZdqlPir7T2TW8e1Phxax3h+T8jYygU9XXZWe8DoRRuX64yRsrnrGV3XdcgGmh8a6iHAtU3myEumQMhYPH67dWhnhgDnXKKvYjiY9L1WLenvLMlhJX7SYsuRREeF9/BSq2kgsQoT4M6AZNV3hGGy+wSN+AihMVgxMsXXGfYvtYSoLqk6GG/QHcBTbe3tH0TIErNR/aQ4rzdXuYjR3khcqQJTEjtsD+zZgfoA1jNSvlcVUJd7oLJ5jbk3GEeJQzTKBcDKuILH1ldIYCUq/9VF/EHdOG8YXA5LcAYklYKIvjeWUBaN0tFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPd2REzmd3dd6mLFQmZUhqOHi+jyCry97KG2ukxXeRk=;
 b=b2LPC/isxcH023K6EvbpWbO5M65NqvA/5ZmjRCHbIYPM5p6aIeEN7kmNmTUkwoCTiYzWcVOM+IqmKp0Gzgf6rounXTvQROqawBd9jm/bMQWfGomECaoNQu5tuXxQX271BbojYIjyzMnaKCj+2c3++jaI5eHa5ToLXxypnDge2WMwyQeO2rlYICXT4tK1KHpiyqeE6ptJXQ6xGlTgKTy2ivdu5EiDvrLCW7HEOiRMb7rCFDA3WLORMAbcMpDehqKBsQREwrIns32GmaFiQYeInSy+9VV4cCOimEIVRJPH11XO0wPVygvcchF6QXAbm6UemSKg7pN7kvjm3isi2XJ5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPd2REzmd3dd6mLFQmZUhqOHi+jyCry97KG2ukxXeRk=;
 b=3CqTRfCNZhAb19YQQ4aix7sGDC5lfHI0pN4XQUyrOYzqVKkC2/yAMfIr0yi0zUtDP4wtc15Xj+5w468YzVmSOWXAUVAM6dEilY07iH2qKZWMi79ZB0oTUX0K9BMkMPyFCq31Y69OdxhQmgHoVwL2xdPcEynG6rE5L0T2qQcaRtw=
Received: from SJ0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:a03:39c::34)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 14:49:00 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::69) by SJ0PR03CA0359.outlook.office365.com
 (2603:10b6:a03:39c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:58 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:58 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/42] drm/amdgpu/sdma3: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:19 -0500
Message-ID: <20260108144843.493816-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: f769b4e9-1946-46c0-c2e4-08de4ec50f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?syir9+McB6RwQ/TpukTWw20oN5y9kNhiQC9YVAwsDDvRl/cpudLQZ3ZVlTHG?=
 =?us-ascii?Q?JDkhjJF4RnGpwNvb5dzdrtCBBKi7e4X1QFTgxEQBJYKBhqNifQgOKx44GHP9?=
 =?us-ascii?Q?5TqI62gu/oD4dc4nRQcndZWd+bvDx9g/YqXofUj9w5qbYG7g6yQorVtrFrGl?=
 =?us-ascii?Q?2Tmiir5Dlq7Vk9c3TjFdtkNHG8GP9uKS7vm7rqCss9DfUNk92bFeS0IM7Zf3?=
 =?us-ascii?Q?bHNpQhzQDcoaVNRN9bAoGOHe91sy6B9OA8NMOotHFcGDP9/ypG/U7WYF9wwN?=
 =?us-ascii?Q?VuDlshj5CO9qQrBprRH3hItjHxeLNwY35PhAOg85d6ta0Wb6Wi/gVZ9ACZ1j?=
 =?us-ascii?Q?hpzmowdpZ9a+gw20Um9DU1u4R5hCRatitKXQ0WuX7dzyU4/dWYF5wBDGg1Xt?=
 =?us-ascii?Q?q9Hh9/IxTBAkhfIsst8T66wkqWCyrhuBk39yL/lTxN3Wiig3/PC5j7r9TUxJ?=
 =?us-ascii?Q?+4rLBXaKGneJ4ncCVTkmIXs84ZaTE5d203dCYEhXRqBUEods5sHHAgJyYOWU?=
 =?us-ascii?Q?RivJdc74uz1gfR/suoWvd6cusii6R+R94tAkTb811Qh0Kmiolh1RfBpc32oO?=
 =?us-ascii?Q?xFLyZsp8YT2ExaGfeCUekJiaSO/W7m3Uvfb6f+J5SeriytCQh9fU1E4eoXzH?=
 =?us-ascii?Q?YqPuN3vKdl9ZizEoAQxf+fQljcPRkGMc4e74bT7QaGpH9Rk0mtTJsHv4h5gu?=
 =?us-ascii?Q?icc/Ky9QEkh2qdp3zy/2zkGWtwvo0vNbEXvAFgfcFie/fFtYKPRwf5aoROkQ?=
 =?us-ascii?Q?hfH5sEBAE6hiVFOgUlA8hqAu+Pgstlug8ElANEAJ0ORSrl/i5ucuGIRqxzMr?=
 =?us-ascii?Q?eTvb36p1dxEBejyFt5VR6J8vzq9MY4nBzsubYdZE3mjefXsF6yO/vIQVhOPv?=
 =?us-ascii?Q?L8WekqI3wyJ8nf5+HC4al0xRIfiC32vLWWTbz5BbPSjBsCe85SSwL0X3oPwG?=
 =?us-ascii?Q?eWtb4KGUGgIFTkXDXfUknAtgulQsKlDcwEIrSmNVcXzpGnwUjkvmzMNSwGji?=
 =?us-ascii?Q?u9VqZF733/nU59/6prMeEju1YpGMD6LbLCVOySDScWUKsoVCQt6vCC1GQqMM?=
 =?us-ascii?Q?k+8EETF0+yHheA1CwldJku74OzEmUk1u/J/E1dR9FtmzstICiyQugOvJUK2W?=
 =?us-ascii?Q?64KY6c2ZG+52FuhvBu3VgsDs/rfn3ysZWtXx34/HOXiPY17iSWFNuc4umfb5?=
 =?us-ascii?Q?9uVh5Lc9N6wTYX1iMFr6i9jzVTdznEF4DxRdd3Ydvf9IGwo/x003784yhD7M?=
 =?us-ascii?Q?TvGVXzonAoigVX41RF/q+8ffIjUvtZUxAkNzaP/QCR53y5QgOVGUhjzJ2NPO?=
 =?us-ascii?Q?dsKQNAMoMShLdXDFK3RbWI/Zin2IuIczQpxcwgtEa9stedhb5UxAUQBg2GIq?=
 =?us-ascii?Q?NXR3TLigYwb2HSmA4HshMPf3pbokHofhV6oYz6zfNTYNHadVHStjWD4z1rLb?=
 =?us-ascii?Q?eauBEZGnS8hNVuJdAPiAzlm51yBFkzih8OsjLx8zXrOjPbnAekT6Bkkmq1V8?=
 =?us-ascii?Q?Y2mU34nSp21eI5S6ZVGynaU/dR5pItFi/lQfDSyYK0H3nyUWYkJ5xpGZfWuQ?=
 =?us-ascii?Q?T92MxyflBtGGOQ5SdS4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:00.3200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f769b4e9-1946-46c0-c2e4-08de4ec50f3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 1c076bd1cf73e..f9f05768072ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -858,7 +858,8 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -872,26 +873,30 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
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
@@ -906,7 +911,6 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

