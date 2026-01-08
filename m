Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C41D1D46A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FC010E766;
	Thu,  8 Jan 2026 14:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6HyPHbj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A43510E765
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgVZrsEjE+fc317gsNneL5g4tPb3WEURUI50TRngPB9LNlGcGJnMQ50Srps4onxNHH/w+J/j+J/I5f4MNc6WkEdfsIMahbD7OmAzurYIzSE+MH0uj7RtOr3x23P8z0Y0VxfTyEsJqYNfDAIN0W8cciH98PeMC9IvuRoV1ir9gmeQYRuilJ9xFMD5DvcwO6NX6uulDpi27IrBvRLxHiwNIsZcgDkSQPE4ioBxFoJSx3A9ZNyKfFTKoSHZWbjP/kuQEkR/bIu7bDpS48/DXHARlcXUEFBTMOumCS0aQu5wlV98xkZa/XvAZ9Hb2pQztpLQF1pzCVPdhdxb36a4zNPK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf0IMo5hDqxNB7Su/mBBHNz2TM25HrGsmOw+clFyh8M=;
 b=wq35fFnNt5WODdirdfATNu0AT+dlVNGydNYDn5lqESmWtTWoQ9ra03Pz9+1Ao4EsN5EhugpQd4uxxStrO7d1VWptqh4L5T1pnbYYYh5R0OXeDCzUXKLcn2eSRSawQ7hoFD7u29hCMz2eZ4d0uiuVDr4blPOoIPwn6Nly8EDmT+C2UXz2YXEZjT45tqhz7xRUsFozBcgYp1c9QvsQISoO3eN+oVUFAMQNyDuJuFBy1WFtayCPsUF9j6IFFoADBqcy8CrkNM8ZIhOfQD25U6xIUVNRNcFdxwedO7QAxvk5v7sgFj++kFVKAn90GU/KpCvn4YSyIFegO4FZ2I9v8JUqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf0IMo5hDqxNB7Su/mBBHNz2TM25HrGsmOw+clFyh8M=;
 b=B6HyPHbjws9eY8OfdvKCyDTvIa9qygDvjWjNGRhv4zVv7E4RgbDWu+0XB8QGzqyQic/ci0CPVUTu5zWLy45sSueQ0EX3BHukjugU5ySwBkJkb9wetybZ5WYDJowehTNdEyZUh6ntDS8SyUoAj77CMAk3XNXPTGz1Cr3rhp6qeAc=
Received: from SJ0PR03CA0339.namprd03.prod.outlook.com (2603:10b6:a03:39c::14)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:01 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b2) by SJ0PR03CA0339.outlook.office365.com
 (2603:10b6:a03:39c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:59 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/42] drm/amdgpu/sdma4.4.2: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:21 -0500
Message-ID: <20260108144843.493816-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: f34094d6-f286-427c-9b34-08de4ec50fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q6lU43QMpoxy1l+9aJHK/zWV3XJvbL4cNvVbQm0IMnJAB/+NLArnT9oWRcp6?=
 =?us-ascii?Q?16yjQm9aBmKyyAvpon43r03boXkqudfoWokeQ+QxpgamuAjrDhYKwNNReiGC?=
 =?us-ascii?Q?OzbiXqJlsw5fWcDP5JyZtuWmLt0FtCk9lOIKPuA3uFFpeY1SbLibiVPrTryQ?=
 =?us-ascii?Q?+4O3Yk3S3lhIC0FMtbI6HMdtdzouq8kJkfX3FkjfkNGk8mz4tyKEMkljLPCu?=
 =?us-ascii?Q?zPVCrxhNlG8QV5mL0vUaDLV8crilPZsE2/Wfv3i8WT+vMKPzmBDTBkkJiVDT?=
 =?us-ascii?Q?8AfJWu+Bj+Vyx8BIQ5I3eDuMp2bVD3FfjbSutw0+hvG++Y3HXOH20OW2gyUc?=
 =?us-ascii?Q?R+98abZ662rYEveReYbx2hpedfKyiBHitZVMPY4Q2RXq9Aljsw6JsQPsEiJd?=
 =?us-ascii?Q?0/Bh19xlq3PCaleBMzcN0vYEWAJLIMvv1UTSzAY2L9xTrJ2tsxwM3GTPSSw9?=
 =?us-ascii?Q?bH5cdsHDoFU2afDHHCYg6dUGKcUT6IE1n2371wo8Os8cmRwRVC04ouQCHCei?=
 =?us-ascii?Q?ntgtafjHu29GtKPUxQzzd5qLGAqkQzKQ2DxdfpSBR2p2Z1zyUFMIUsbGwUfn?=
 =?us-ascii?Q?rxtfUK3u7EwAgdi7+tfh96uE6KVUUfyqmIr3jQ9tJodMtNcXCkifXVhumYdE?=
 =?us-ascii?Q?dUWW/5C0dp6Q/OHwGVrrTgRnDOfJYI+yGGhV2a5u/Z6hxV9lflAS8bA7dD/e?=
 =?us-ascii?Q?dxXKkUjiNFa7T54DZgcKAIYb5DB5v/6MDvY1Wudo5supbI68EQ+9SJB5rOh5?=
 =?us-ascii?Q?WzkQBOmpMTQlfDW8LnkqXQKNmcJweHx2xWQBFwrPxZqiUmSjTWDAiZ+XlzNz?=
 =?us-ascii?Q?rc6O6zyjNxr6/xXNZ2vPkDJhmS5OogB60ttvR8oAmjkt5307SNBRPZFLNp4F?=
 =?us-ascii?Q?OI/AZo9IzfaDFDVCipYwcVJyZmhIW33uaBjXvTbHBgPT6n0IWEs01O9sm9Xg?=
 =?us-ascii?Q?mu3kLd0Vag385m5dW0xd6inzv1eTXzdFQHOEP+Dh/rQMIlv+D9Fug4Rx/QNe?=
 =?us-ascii?Q?pakZ3BdaB9guaKAGP4cOi29wly+93nJM30XHR/O871cbAsyQCZOFfq1fFGP7?=
 =?us-ascii?Q?TkdSzXJe0aAG3GC6dEufwzHd2EwDECYrb9KV9XYClZFTIJ7PiARmuBVxWWsO?=
 =?us-ascii?Q?bwHvtxvvKEBsXBsoBd3g7d23kTo0C3aPKL6xwk4VrBZSR1hp2doZJSK3H5pO?=
 =?us-ascii?Q?1vAWFBtOqvh/kZjz1aFSrMYfBJaRH4c97/kT2FJ9Pq2yu8kJR3JFoMDK0JFI?=
 =?us-ascii?Q?4Cblb3JEBL+c+11Rk0hKKv8WS3UIgDi5L+0cTG2e3UNbWcY/e+B1lGYGKPxz?=
 =?us-ascii?Q?0uPXpLSj0xcNkQoa55JcH93PrvrIKumR1WY0zV7owj2hBd5uKM36qTcj0ol9?=
 =?us-ascii?Q?sc41rizF323fBifTwlz6gjYJLGGpjKUtsniIvVFgXOtCuKz3naxWVkBQQvba?=
 =?us-ascii?Q?KFS2S6BiEn+VSdXVrQOxS9jgdgd4UykLk/lJYmJ5yDoEmGx+6Co+aTmkZiBw?=
 =?us-ascii?Q?VlzZtu4fTNsch2o6O01P9rXOJTPcjg0p+6PeZNL3AChbGR+mO+RyfPK2mwQq?=
 =?us-ascii?Q?fVh0RioT1mmC2SfLpAQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:01.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34094d6-f286-427c-9b34-08de4ec50fbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 38 +++++++++++++-----------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index a1443990d5c60..dd8d6a572710d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1112,7 +1112,8 @@ static int sdma_v4_4_2_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1126,26 +1127,30 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -1161,7 +1166,6 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

