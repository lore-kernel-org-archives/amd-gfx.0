Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D8D1D469
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A7710E76D;
	Thu,  8 Jan 2026 14:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yEzOz6Om";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580D210E76D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXhbf6+CBP1mFqGPBayVAVqPESQWxKc3SttAjuwuxGSQZRMSRamWVaWCckohMruW03DBf0YYZIm2ZP8jqBWYosTngvsBIkVwRFJdjGxl53Y9HF9PzNKJzSWGT2iF4DEJmLvmgOhiadxgHImqkhFBaFQThIIkQYOdsdfw9wvsFloj9ehXiXTHDSvSs9Oo+Kw2w8euF6Rki9wCpLKvf1BPFdEWuNYYk+JJ2QJw0texm8O4PgsJxRPsEKUuMYS+jpNpiD+0uaPDJEAGpki8TpN5QxYzMW5XjFQOUTrar/6on5Qfj0LBHvUtv6dC+IO5iJJlPeyQP3JUNVeeXM9ezUi0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk3lCu1WmT8HfMVXlHM64aU+6FouJiW1FtbMnxYv00g=;
 b=ig4uLNpj/iFZzUhHKX1Iu5z/us1fmFwNXEQszVnOtDLTLs/a9oBWvN3BlmbJ9JnJ0M95F3VeZn14S7hlNPQVYIFXY3j22MIPC/1wplkWVZb1Qam26XoF7Qwn78T4NQl3kc0TpLZXfwfB0XwVJJGRY4CBnwDHlGRLGV3LMSlMo/d6lvRwjjprTs4Io4efg42fXLwB4Z4EJJ3fpUXuA+EFOtcSkldVBcy25M6tbk8so/8iCtAoP9H4e3utA8Dy03J8nWOOq1YUJHEiQMh080SPjl5GQGhzztbY1H8qJU1DdI8yvQvZfBZfvkd//Wrp8p/NF+9cpd1nkjxDlbZH72KFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3lCu1WmT8HfMVXlHM64aU+6FouJiW1FtbMnxYv00g=;
 b=yEzOz6OmbOm8uu3m88+0vKBiY/bQOAR17IbElTLXCvQQQU9b4UMuMhIXxFRjs5vkLwxLrMya/Q1Yq/4oLavVt1qy9vtGzPlmsfJ/Wvpp66csZcIC7T7MNsluwZGdqhyH5xgBI5jKBPnrhzbHY3+6V6VSz0lk0iEPTZiGW/qmBjI=
Received: from BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:49:08 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::5) by BL0PR02CA0125.outlook.office365.com
 (2603:10b6:208:35::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 14:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:59 -0600
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
Subject: [PATCH 19/42] drm/amdgpu/sdma4: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:20 -0500
Message-ID: <20260108144843.493816-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fa2abb-5a4c-4465-0be4-08de4ec513a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vxMXbMWMZA8KREyxPLn7HwVxQYT1lFPggj+GB9RmSodsPQthfGlKkT1FfVny?=
 =?us-ascii?Q?cdFev4s4/yEzWzV05mCEKN2/osl4F0Z5ra/8jJiZPONIqh2SO0zTyC1E8V/j?=
 =?us-ascii?Q?pyB2tXKqbR74UieyvPb/I6+mWPZ+il8L9Ftac0mYoqtWy3VO17KpihSUdWdo?=
 =?us-ascii?Q?anCjRbMVETKbUkN6bsm91UgPdQtmpb3GUqMA5GDE2Tn/lMIYrFsoaX34YC+x?=
 =?us-ascii?Q?VukYkkfUs07EjB5iVSdSo/skTFzWCFGwJ7maI05a+r+a831w9UiDr60WKvF2?=
 =?us-ascii?Q?cHgHY0jWtT//KF6symrl3BcbIM1DncQvLL2Y0bLmk/UB0FvwssWozh3CqjgU?=
 =?us-ascii?Q?cqDpo/m3CmULF0rpn2OGyx5vDYsQfxgk2SBBi8VyjUPPBMdFjVvytZjgC7Yg?=
 =?us-ascii?Q?28HCVM6bif4eZh4RE5jqwTiuGbBiR15jZKKXVl5SHpcSl72MbkVM5g45/Yq7?=
 =?us-ascii?Q?DsCrWLpn/nQUad3lGjm4ti75B9S3Bl2NUAz6wmkIeYnnkXEcxxnU7LjegtMg?=
 =?us-ascii?Q?EU4hlWEBDYh6LcIqm3Th7tozjImAX1LkvL5/LX5faR3ZXVt/gBZiOtyvR67I?=
 =?us-ascii?Q?xITZO/Euc8/Wl/UA7y9Y4cSQ3NxUolHA74f374QMnTqEVy4GsaOTfpjYpaM9?=
 =?us-ascii?Q?ykAZimQy/ZxqvidXO4HoV9DZjlIQwAbzyAsh+fzytPOzJ2jSdlnwwbmL14Kz?=
 =?us-ascii?Q?X1tHPVG68oYJzTXxUacdDh0kfg/8Y+dOlxdIiluY207JUc/jP4PZ3bb7XoA2?=
 =?us-ascii?Q?W/fKhb8oiighjoPnJL1PKhJf0uddrad+Oe3uYsIGIuZAVaxWdy9VO/GpdqnK?=
 =?us-ascii?Q?EnbxcwjAg8N6xMN+JWGMV3TXUDztCGLRF5wWim8bzZ3FEjwc6w8KlzxhD1Ab?=
 =?us-ascii?Q?o4IHwjgz0ZwPgGgjzePbI5dbtAUolrDlBjqs0PPbfeSZSkQLTRaHGhUC4Kr7?=
 =?us-ascii?Q?QrFWYRTkPeYOwI98mh3iRViIcZqF4rMQUkTBQtph2uJJf1aPJ/hhk0KOdxMo?=
 =?us-ascii?Q?8QwtHeH0G6Rd65zpjA1llPEzxTpybSNWis4g5v834LFvlXrK8GLW5qa7RIwK?=
 =?us-ascii?Q?zsjdWt8UPGqSwJjd3SRTZ7xnKlrb4kVOx6jnszFkL724Eg47qljqXmDfCGpq?=
 =?us-ascii?Q?f587fit8q3nkC0AXUk1aDMfRIeafKOFvzgGINm741PEDmcoTm/BjITtXegYp?=
 =?us-ascii?Q?XIEOB1akbPO+8zqcza3JUiU54E3+s0up7H4g9BDhdABEnULFim7Xfpu57vyl?=
 =?us-ascii?Q?A9/Tu562+z54aEZ6pw1aWU1ZXTer2XNGaipcjQZNxGS49Qod4PnYNPoSMuKM?=
 =?us-ascii?Q?ixEjy3V2zfljpeNQgkNksQEIC3ChfYRCjZP/MTQn3TWbK4SH71wpJAcUJAQW?=
 =?us-ascii?Q?LjyhDWcn6W2L5f8dxjU/c2UA4gASrIgsvvY6mt26DXTYsOLr0m28YcXE+smV?=
 =?us-ascii?Q?Ef9bopMbXzFd4bZoLBrE8WkU7MhNxZJRRSNVynt1oh0rS+jE5s96Lh7bf1N+?=
 =?us-ascii?Q?VF/nBgzI2Xm8d11l+G3csiE56VEfd4R1iPDg4qVop3De8KML6MMoh6GStEfd?=
 =?us-ascii?Q?aD6IbVtEn9+oNbOEQ9k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:07.7734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fa2abb-5a4c-4465-0be4-08de4ec513a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

