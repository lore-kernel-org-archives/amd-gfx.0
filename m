Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CD6D1D46A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A948310E76C;
	Thu,  8 Jan 2026 14:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EFl3s8qh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DA010E772
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7fD6XlJR3fJHN3cpr5GDG7w+KTZOkpFVa8RcpxCV1WlFlZF/xE5uP76rHV5GM/ZnZTsWWXHNNq6SQVSdFbVUv9MxszvnDt2AJYyYksUekGKbcy0EMkPBaJEayg5zrPbOYoJgYVa0mRu8W/dcRYtRFL32ScZrmAG9hJJEzqThuMl1OwnoNJo/tZ4QOWoBhEJrwbPV3Z6UECFdWPEM2yn+e1/9AtYCAjMYbgRLPDDK+ZUeZD0xsQQbJ37J9ZfQyGSx1P1i87Gt7xqblq72GJH/HZL/2H8gGp5ZCIukRm0kAl+idDGt1PBMkE/FIqDEOrD663SX+51frXvRIHZKZSSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPL/oONtEIUQqyo4GDNx8jq3sfTxFTlMMnadjGsVAlU=;
 b=vAULfwZzR8mntczvNmGEXpeS1lC6SWkyM/a2oX9zV9bMssx8QqqJaNBYEdrkdtS0XdJX9kNRctjTDLn3tADpcCCoc3jxNM1JuM3wVKrlBOkLkcnJfVvZYAT14UyRVNLoSUtQBdiBMg7MITUpeCM7a9T2R8W9ZJTkrXox4wOGOgDEg+A8ne+2wMHbtwq5eav4THU9UJnWlVvHrMUg/djkkGDMn9zl7X82TwUFib2NBYuCMnfp/nJNPNNWXL75+/oSZYezsTvoZ9O6Bc++XTsyKiPm3s5dIoxu/Bn+aVXLz1Uczaka23whF0e8RpoervAZoZC0gmjHPF33sYfcMqdwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPL/oONtEIUQqyo4GDNx8jq3sfTxFTlMMnadjGsVAlU=;
 b=EFl3s8qheY6WUQhA82rUXEi5YIrmZnjnZLk9nqRseU03ZXpUAIIZ5ZW5CJ2CFDLKZudvvvM86KpNHPTotAvMyG5vGj/q+s0JVEMSAYtMGw4NbdohbhJ67lskeCT30lPQd+ESX1qkm2fxqmC01biPliFEQeaAYss+xRb7zZZw4VU=
Received: from SJ0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:a03:39c::35)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:07 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::67) by SJ0PR03CA0360.outlook.office365.com
 (2603:10b6:a03:39c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:00 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/42] drm/amdgpu/sdma5.2: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:23 -0500
Message-ID: <20260108144843.493816-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaef5d2-21aa-4fdf-cc12-08de4ec51355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MwN9EBxVkU8GPTJvl5XaFF1ho5IITn/g1EIrWZaW1U9QBC28Dh9PdQ1GBxea?=
 =?us-ascii?Q?m4uLUaiFJ4B6HpkmTnQDFFJb6G5DMkqvf3Us4iCQlq81bnQ9LDL4XXCKi5c9?=
 =?us-ascii?Q?2zt2gjCajrxIn9sn6EZg+JIYmTekuAQf1GiVuIYZ5HOve5MB0CA5LAI/uC0p?=
 =?us-ascii?Q?UoxG47Weg9S+OsaATBgAIMY8ohQn1ltTEbP9J2t71z26W0eOrAdXOE/mJpza?=
 =?us-ascii?Q?Dsq03XvUZ6DUXLAjXH3/FsxH1qIOFLJsbFVqAcwuN/DXiLFiaWMrQXYP6UFg?=
 =?us-ascii?Q?Km/31Whgcqxg9YH8Nd1m/P9iYmandX0/hl6bjcb0KFsZzYsXB4qXR7zhMFwo?=
 =?us-ascii?Q?Bg1EY17kaf/U5aDJcUJX6imABXGeL/+v6JUjdwF+O2UVOulKAcmD1ZYKu7Vb?=
 =?us-ascii?Q?t5N6cXeRLtZxh+LkyE2BoGDuHYBhgq+my0GvvmnbrUlCs9Yvv8mHityID08m?=
 =?us-ascii?Q?A0EUPghZrMiId0aBkC1qfeFA2iORrpnZBlc/ynvQbFJ0ZZK+SEJCxQtvRsRZ?=
 =?us-ascii?Q?9SuOdKPNzUausv+Eqt9IBusmLbNLnP4/RdEteGO0LFowPbnjtg6z+Zq8MP5Y?=
 =?us-ascii?Q?tY6u3SaNR89/ZfYrFTwFVFJm8+Ieh5bHZy4O0kZ/y9PFtE+zccPO+rAfw949?=
 =?us-ascii?Q?B9qFR1lGZspshhwSUEMaiCkIfAZaivWzXdtekVGGmd9yAt0EW0RNdovmUxJq?=
 =?us-ascii?Q?jxG7SiLhqNIUqO6izS/CRxixzTv3+OTpUW+XgCUbFr9L1v1nxzkV5RYnDruk?=
 =?us-ascii?Q?LQQEhn85KK3Gt9VnocKwEm2I12rLQo4bZJ5UXG4DAGxCXVkmvfkqSOUF8P7e?=
 =?us-ascii?Q?djASG8uvLlmWzsKGRDRDn14sixUGCIDylI+yY1XZ/pg9x1Orz+o0x0J8gzaT?=
 =?us-ascii?Q?d0XTk1LkQ/flPPRLjts2tkal5dzX2p6Qowol6jICFSuKiuOvqKBdZY4Kh1nB?=
 =?us-ascii?Q?+klGpdKAX+duDU/hqx7dVSlPE7MlFT0J8mSzRIKhG+YmIgv/5TH/Xs0/mJi6?=
 =?us-ascii?Q?pGKRLEYtisTd10pdhI6JOmGShFCfhGrZQetgzswn5LLh9o3OIuW9daB2jlaT?=
 =?us-ascii?Q?70jDrPvpRPP0xoFoskQl06maY58FC5usDN2Z2QSRatuZELHjTFbI+TI+8LSS?=
 =?us-ascii?Q?GG3Tv9K8TlQrisNHYcWYxL9mZ+AZqvI043lroUYekWQLyHKHR8aFe7GkJ2kh?=
 =?us-ascii?Q?O70qEBSglvW5nT7EZ87/39LyHrbl0lGz3TBRL8AX2L+4gAXBpQI/YihIulyk?=
 =?us-ascii?Q?2pFmknklU5fK3bGKdoTtfHxTHUxGzo7YrlejpkMw4M32qadmTUD7JQDgrHdE?=
 =?us-ascii?Q?eZH/xbFAMPAKU91wLZCAXlJk8WIWYZV6B1tDoHu/a34J/YYnWySarwE6RNGp?=
 =?us-ascii?Q?imnsjytQX/s4OA7FYFH/Vm+cRM42BTbxtlydDYLxT9YGInbUCi4uErO5hsyN?=
 =?us-ascii?Q?LABWArSGyN4ZtckfxNexXON99W1tmCaGxIf/aqewzdTiw87cC6ssNcirPOJm?=
 =?us-ascii?Q?2+8dScek+7GdOnhpYZPWIYaEFJemvfUOY4DYeUJaMpbfa9VJAVhPOTxMvLrK?=
 =?us-ascii?Q?ynRdhbUpz57MOyqzQAE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:07.1686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaef5d2-21aa-4fdf-cc12-08de4ec51355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178
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

