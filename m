Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137C9D1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203E210E763;
	Thu,  8 Jan 2026 14:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzhbDTRE";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1115E10E760
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OosDRxWhjt0+wdjyoloFDLXmZ84HY35W6TS3Pt/bq4JbRCEHYmeiND0iyIu/Hih7BpD8f5MTFYPtxZ5fLiNxOZ6twXCaYTSqdLo8VS5Yrdjjcls5V+PjlEhV/9+qYePGNmZpTDmgGtSzpewChIDDeG5deEgV3d1UqFjlTc+UgR/yz9byycEbQkzZankVZCazSTc3uuCtSzYzMsedskq4UXtJqDyt2JI8zQN6pSj5xr8j+aeejb2pzd9es7H6TMMbbR4BkKqTTHvzDXGjSKs+u6GPnyRkMHmrC/Pb2lsDQ/NxIUSGn+fZ1qFcdGbqwzExNxCy3PU3FtpHNakMr2gaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqfcrG+/EwWHRTVggIY/58ob8BziQJulMWQ4PRXDGVo=;
 b=H2qkGPeuEpA9L0VyJGAcOhcYtKK9lnKvZpHTOKvJtQYrmPWgd/CU0c6RmIuXKwmpSEAqwa/FQXT3Up26wOqf8tIWZn9hs4TBkZuqzdh6OfNFmr3HY5UmfUQz9NXKZZmsPzEAIH1u8REO2wDDh4YR9jul8r98nnHD3SLKg45d2hZ5zYA7aksboMv5ptxRpjLESneX5Ymp4uMDRohlPs/zuZsraNzuE9nQGR0l4+Ki7n2NgDxlliGvtH6vPMMROevjP1PYjY0p89Z39WicunDpAs6eCyvxNdHgriENNO3ybINM/pfAoQzxPMDnL7rVGTYqjy2mvMiJmQsmFK5WrBCbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqfcrG+/EwWHRTVggIY/58ob8BziQJulMWQ4PRXDGVo=;
 b=NzhbDTREXfT3ChvBfBDDGawKdGUxjRWeGEyvAz35hIDf5g0rOr6xwnjtnG57h78blbGVZINe8x6U6DtbDr8IDt13bp5K/bBlZ9T1bYvOyV+dflmzEV4MZFIOrvAwo7OB17ACBeJqLRqmIBTTC76Gz+hO/p496dvgJGya28ipwqM=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:48:57 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4d) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/42] drm/amdgpu/gfx9.4.3: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:11 -0500
Message-ID: <20260108144843.493816-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ea2a6e-2d9f-44ee-a9ee-08de4ec50cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cV3/7SoP3vqiiGHQK42UAQNjXUY9pa0FDZzyHXHx7N8b2HNSeRSa3v9k5mT7?=
 =?us-ascii?Q?kAXlrQ4jN71JtOaIMeMIrHE4oKHqrr/BgviW/klHh3Z/bV2sJshPgyebcvke?=
 =?us-ascii?Q?NFPtJbqOjlEAfjbqSV9A6wyZXotDetmdDZLbLyUeUh+UhJRiTHv7YmoTLFuJ?=
 =?us-ascii?Q?3BYOAWTDnC85d0RiQamuCqdOvYiLcSDoN8qRxkDXZglzE2Tpa9De0YAAjgj9?=
 =?us-ascii?Q?RNasobEM67ojiVrXjEyFh1IluhUsTMPKzJilqHI003aTijTb4f1E03+8uBEG?=
 =?us-ascii?Q?NmdVyShARga7G9/vD1Ws1/hp7PQTAvhOJCTLeW6aVWve28JReYrznrJ1WMrh?=
 =?us-ascii?Q?SvMXEngFuthNP9qPHEvdZY91G73PkySbjwTqmH+ae5Jbl+jRioEKfBNQDtnW?=
 =?us-ascii?Q?YEXzAHjgF4W2nTpuEgXqn5hRHi9AAkd8MIqAZbq12QLgIiKji2Qs0idGDdwB?=
 =?us-ascii?Q?OCdn2CxRUsWHVZzJKB5nfB4xYoo2VZ9GlDyq9+rS4DY8EAYxTdce8YzVhVIs?=
 =?us-ascii?Q?gw35sclbrm3Iybm42sKdzfd4pdQfHdNlD83LliY9Q996F6pwYVBCC1e+EbwM?=
 =?us-ascii?Q?aX53GClQ+yqfs2eK1ImUM4xiU57dCGyiW0XTdvq4+yRgzlfjlwxafcpb9viS?=
 =?us-ascii?Q?KI8J8Xns9Jc7AdxZwgw/dF90XEsvbFovN+/lzZD1+6m9EZHrYYY+C/6X8bu9?=
 =?us-ascii?Q?ewh6jPyGk1SVaMJPhE5K42W+5ITuH7dGLZci6btn2q6a59seDbtPxyQthr7P?=
 =?us-ascii?Q?180IcBvRiawwdroJ8MLCaZtU3xCKqJMBNxjuElpj7jIq1raEeOgIbUlPv2Q4?=
 =?us-ascii?Q?3SyoW+OjgxQ4ziak6Qpp11AzGzK9jTF8vcD6RvX/dEHFpUmhD2/DXy0oC5L+?=
 =?us-ascii?Q?qVuTPGXeC1dq59BYVeVFjEYqg0JEg304++I8kvjrE288dNsI9cR2JhQyl5BW?=
 =?us-ascii?Q?jjnbW65lfJF3VVEBgyspCNMVfuobKJafhgm2dG+JoV+Ild7hAQuBN5zNtWTy?=
 =?us-ascii?Q?cCtqBdL44itN58oyFPqZWkSryEu4eINFkQmXuAWJzE7IVPeAMK+qtrSniXal?=
 =?us-ascii?Q?IFrqB/XSOfsFSfVH0GvyT35y8AZkqnE3cwi7j3hebzWIq5VkAXZ+9EXDl823?=
 =?us-ascii?Q?lLReh5tmFbf1v9kyOs9O+HG1eUat/sm0bP6FBm8PoAPC8juOhlIVmKY1uI85?=
 =?us-ascii?Q?+JStLWRVh1NetvCN3sYXRKPrHidKD+6bN0PJ+9uozPykpRwpWTc9Pv0nTqTf?=
 =?us-ascii?Q?/mfe1PJ5u2cBb7Bxxfce/fWviHrdpgGVgO+mU7LijnJf5mwPaGX3H6gtFVEz?=
 =?us-ascii?Q?9QVkWEm1i809SaGY/JhbNm2qCnaDCI7bf50A4kMlVZuVOk70NbFS/6mhnmS9?=
 =?us-ascii?Q?vbm7LybpziTrR8NMQMvQwBrlEUDYWeGAwGxz5F18MnCTs98/T4x3oZ2djQdF?=
 =?us-ascii?Q?2roM4/lOKXj1TRZ6wsVGC80zNsrY6hAnhYyOV5s3ToftC2to3AONBv7ib8/u?=
 =?us-ascii?Q?OGwAxsKn7Ztsf+/9q2ALlkGHj4rEoTqtjrFK12oDVfqbxsMgLBDRffe6HXFz?=
 =?us-ascii?Q?quTveWUCOfmjdUsPnAU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:56.1621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ea2a6e-2d9f-44ee-a9ee-08de4ec50cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345e..d78b2c2ae13a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -451,9 +451,9 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
-
 	unsigned index;
 	uint64_t gpu_addr;
 	uint32_t tmp;
@@ -465,22 +465,26 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		goto err1;
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -497,7 +501,6 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

