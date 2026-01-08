Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5996BD1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC6410E76F;
	Thu,  8 Jan 2026 14:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S27CztD6";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F03C10E770
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajUMIqGcRxWFf1xaYWZxKCjgDMuThiGPn/kpLStyR9lnZgFnFcxaOGqQwrFSSRwuDMLtdN6HYrxXFR9/jQmWC7WGIg5+JBvjsiLrs7yGuo9m75+2WbDdoBLMoB3+/BqXDJeJIBOua9fQ1WlA68VJpGK2drqUui/5SQlZ4X5HIU2I/YEDAKou/0HX+KbC+5kNAAg90N7JxfczBDLaburkMn1S1Q+3HLzvjZfz4pP/UOlz/Kf4BlWpAHqQFNHgSKazH3dPS5LAuzJFzC3Nm5qN5XoPwdLF5DTZYJ4kCD/bIpKf7P301XJ1rFkdIiZ3tx9ob4CRugR/EpFCt+45wkM9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrjefFgZCTbboZkbIbsn1K4lQjeLn5oLfKVZY3ZqSGc=;
 b=GCop2WN1AOh3Q3EvuVBzJ8MtfXAn7HseXi3b1AIChf/YpeMoECT5ierphqUK0CUdkcsoQqnvdTpZ4ii5fRuMSF8iF5VZWBeKFs9q5rCoJO0Pk9MBLIzHJQAkHOauP6/gu8XBHV7XkIh8l/fLYS0NCuAVYoO03tCxdvdBM3E6SAbM3ZSwUbqH6WiNnLdc2d6bGXTdfe11xu/YguXH/EbU/N1TF8dvzhJc0fGtCs8YMMr3GRXuUSZTE1OZWQo8syZm9FeEveRR+RqIME0X7kgUAz+clSa+W0eKA1KYtMt26nz5nidwzVMPCoHO8SOwXN69rZeb0Hq8kKRKH4sb8rwlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrjefFgZCTbboZkbIbsn1K4lQjeLn5oLfKVZY3ZqSGc=;
 b=S27CztD6W7xxIGxoxVuWAafH7MgeK50Xelr+7nZLz3q6Z7VcPVHdKP8gLZvvWu/E9SSRqNniY0MzpgITLAfUZS16T2VufpicBLVZ5MNc2eNQo6/+75Ov0v3DKrh5wkatbpZesWnLDB2wuMO/Bfy6FCgnKTXg1pKZpgnEeObuObw=
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:06 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::50) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:48:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/42] drm/amdgpu/sdma5: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:22 -0500
Message-ID: <20260108144843.493816-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c51c4e-4723-495b-5659-08de4ec512f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UIzg1VNTFwcUaR8exYXIl9w519kJRAy8NHv4QeYky0afSOyUW6vt+k6GVWz4?=
 =?us-ascii?Q?nEczkmeXzH35hzIFQaFk/oxWQNuU9xF8jeO8lmc3dY2LWvlb8c091OUuj8zF?=
 =?us-ascii?Q?ZCxT7i7L/sQL34sPH+G/D6+xihoS7zQgrvsP5AcjIN/6OU/XPhsxVY6ZfxD/?=
 =?us-ascii?Q?CGVpB9Z86urIYdypP3aeBB77CdkmIHNmlRGzQg30FYheFZdLL5xUyydgnSwF?=
 =?us-ascii?Q?eZldkuR5b3HoFPAsrDiBTfvXw+uXLEAkXrCKkn0UGxWkjBP7pQkvQGROoamg?=
 =?us-ascii?Q?PBAxTQzHYtdKn7dzWWSpzOwK2bxkT0HWGyeaIaICtF4nCoM8ZOHD5dF00bLl?=
 =?us-ascii?Q?kX9evGyHavajjSPjocvugpnJF65BlUOMt/3d0uJ6u/+6HmP9e+/7UHyct57m?=
 =?us-ascii?Q?GAS6p4tCt1ta+F3g+2a9lJe1PaSD3iTiDFOPFCU1dlw6ps4E1FeFvfLR2rSk?=
 =?us-ascii?Q?AnQSJVvPtLnuaHRs9zu75F54F3r+zOIuuaDXhZ4oNwwOvLGTgsQvz0B4Jp8L?=
 =?us-ascii?Q?2NekSbn8DVA7glIpnj5itd0UDPKhZb0i1YfmrLtLig3NO/qhljZwD+Hz6y33?=
 =?us-ascii?Q?i8o+N73EAaCv4C6xZ8v6f3caWglWtx/gj0jnXx8BiP71WoIxI31Fs2+O4qKv?=
 =?us-ascii?Q?GyJB+E9K8I1gghH0ASZ3kOyrkA4rY6ofPsjJJv6by0egFPGYEGdMZnPzRW9B?=
 =?us-ascii?Q?brMUXIhOccxEjbNaCSMH8qG+ExD0LF486vL/mqjBmRvdRv0kmH8XyhyT6x07?=
 =?us-ascii?Q?/ELq3t231aUM8gyIOii64j7MYV3RWxme1AKMH6Dkhah+48qFm3TpS+0dD2Uz?=
 =?us-ascii?Q?b491hHLGRP3L8GGdhz2gXimHCxaOirsRF1P5IOMSvpe7390vC2A+88MhxlBf?=
 =?us-ascii?Q?Wn3X7Y5Yu7eIK4eyf0tPlInv3clq3Cj9Hvb/JaJhF2rHRzY6i9IiB1vieqK4?=
 =?us-ascii?Q?iq15AAdlv9JKRAS+kJ+yFu/E5wX+a3OH6xUk7469jLnoRhpVHruKIZHsIb6F?=
 =?us-ascii?Q?d53IduqDX5WSK8chm8HaBOuOcWmucAV2b6N/8fXmro2xsDW4VPG5wIL536RZ?=
 =?us-ascii?Q?WlUFUUXPE9H4gVBhyKaJKQ95Thdj+DHsCKcySxPtERuh0rfEmJ8xhUCeHzd0?=
 =?us-ascii?Q?qKnWTW63wmG9sPu5av5ad46mt69QsKYOWaL8kcc+3suc3gqHawNopT4cBNhc?=
 =?us-ascii?Q?kpCLUsXMTu4yoPzmTJHruFlEWMrgwS9PMVZ2fCMXU0i1sZ4oesr3cSHWs9q8?=
 =?us-ascii?Q?U0zoxddt0oLSzicBaNbo7g0RwC3v9ZhI5zrXsidvzXpM1+OOI2wrqq56Om2c?=
 =?us-ascii?Q?8yduvO4QMNxLllcEx+rdsmaOCGiqR3YEH4XW51uBcArtnZfwOfHY8+TXKJ+0?=
 =?us-ascii?Q?EJMfiJEQSC8b3D3ZZcieb7NlfAObjHcezu5bFtDvu+m6LNvwnPP3K0ml85x9?=
 =?us-ascii?Q?1Lk3eqiDgW50GZLdBHAXnytHTD5AFK2i6Lfe1MF/ZNzjEU9+wLJ2NVUKes5c?=
 =?us-ascii?Q?xQyfrOuC1OwB1Ozy8lpwNJg0AyOORzn6IDIEbIrWfustN+gHRB2Z7t3q8mLV?=
 =?us-ascii?Q?D/XxdY0IrWioU7flkbE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:06.5413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c51c4e-4723-495b-5659-08de4ec512f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 37 ++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 7811cbb1f7ba3..786f1776fa30d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1074,7 +1074,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1082,7 +1083,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1093,27 +1093,31 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256,
-			  AMDGPU_IB_POOL_DIRECT, &ib);
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
@@ -1133,7 +1137,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

