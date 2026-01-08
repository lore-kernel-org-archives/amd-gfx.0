Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D835D1D46C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BABC10E765;
	Thu,  8 Jan 2026 14:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0IQC1j/y";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC97010E766
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJkG8z/Qcpn7bJZfSmuGtnCulqIyfabRYfAupMCKXbfSBnUF/l1RtQEHbY2UJFaWHLycqStQEmCyeNBvtaQsJtfUmXy9CUIxTRi3OReJpeuJq+fOsgJmb7bNDh2Y9oFwHQA0tTmJazKoxuF8/KvjcqADRsfUDPvIL6IXtPQSd1q0VXRnaMl6JU7kaFl/jIsOBN1x6KTgctSWF3nB6YAVxePyb7P36Ssjp28dfYTnOpOIXZPH1m1GMiJXsy7XwQgeCG2b6+FU/Ri6aQsJGEVqFKGAsgXeclnBwp4Hb8YHZzpSjTLEMzJdp4GXvgQqAhuxkMBCJ6EZ2W18SsfZxZrZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIbaSiUtry7zaqeyB3Sj8SNU6pn0dRA8QtY8zD9mM/w=;
 b=OlpCYzqX7jeocc6u7143G+zirw4snbXopi8ZIG1xlk825BEieYzUaq5u23ah/apsaC7l6mCJiJp0Lt0Awz405LzWK/O8PExqwplxsHQftlhZOw3NSZON3h9reSmRfE7blmpVAP8tFSVkiv+ptcp23B3bchteZpxJ7rC7Uzt6eMIuJYGm97PvSyxTwGbqhYb1bJH0wnRapJhfe7RC0yW79OF1l9nI/2BFj9KbWj6r+XuUiWF12FR64vAiebJ414/8rLrBCa/gbt9tLko95ZGzG13PqEsvLfQ3HMB55xug2TYJBia76Ggb/KGgiJsJxI/83XwAboox3muvU6IPmkh5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIbaSiUtry7zaqeyB3Sj8SNU6pn0dRA8QtY8zD9mM/w=;
 b=0IQC1j/yPLMiRliQUywd+3g97rg/d0jaN45Bl7rf4mGo5pdRxV8Ar+JnHJAc/girJJCiQuPvOszzbRf1FAx1lajwMElZsA7wdPT/rtRRWohFwKToGV1c4PjJDigL3HH1lEYemOr2OMVZaqauDM67iceav2fIgkopVTprBeWMAS8=
Received: from BL0PR02CA0116.namprd02.prod.outlook.com (2603:10b6:208:35::21)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:01 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::b6) by BL0PR02CA0116.outlook.office365.com
 (2603:10b6:208:35::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:56 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/42] drm/amdgpu/gfx12.1: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:15 -0500
Message-ID: <20260108144843.493816-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: e01bd5a4-d9b2-47ac-ced4-08de4ec50fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZMVMthOdBo1uGJwQRse7HtrELU2xSLi/L1WxoTxY50Txn861Nx8GZDkfptje?=
 =?us-ascii?Q?OHDVV5sD+G+pjkyyBz+YrQdI+aO7K3Otbb8CxXiW1L2bm4xpJ08lyMLKx6FD?=
 =?us-ascii?Q?Jwg30+2I3xVoGbjpSnKPnitYg1+v6T3Q015P53uB1QbggffYVaT45+bBs6wp?=
 =?us-ascii?Q?mGH4wYYhAgSpgy9/BPrS1Yd6nmV2+t7dXOJWJcFcub/IMHlhrRRMalF9GlGY?=
 =?us-ascii?Q?QkcoyG9xTqeIp21rOEtERSP5yshTKf9Q+i2t3JwgbFUG9ieI9Ig0njOgYjcl?=
 =?us-ascii?Q?lUgvjxH0I54NDEQ0yE5i5v6vndQRoTEoSwfGF1CtAcVHJjglEqlxM9wjozZV?=
 =?us-ascii?Q?dYcPs1XF43XbDhqBxGFXCLVVkNdiiuEzJM66FdjFQ4hYv4YU58zMeLDvX34P?=
 =?us-ascii?Q?qVJ18EtYoQ+mziRpmrfukgg0e6oxidRJ7egamJsfoEWuh+UHzt2GU0E6zi5u?=
 =?us-ascii?Q?mGKWD2fnb0+Z8dtuOpODzh6tRI772HbZX/B37XWAE8dW+Mssjkw1utTClq9A?=
 =?us-ascii?Q?8JI//s4WsqZlv5bE7M1GVoaqPOQDVoR1wZVYCiPBt2vSDM0EyxGEtARsHyuA?=
 =?us-ascii?Q?MIPT52JMdGOjOgD2S9DYLeQd9JZloDMQJtRIIWyoi0BRLaJ8l6lb0tio/f7s?=
 =?us-ascii?Q?oM7K1KkTq6D4G97V8HOu3C8WzB6gDu0EWHTe/V34ZdjHJJPUXCAcf2wI07C7?=
 =?us-ascii?Q?9eNITk1iMmK72JaMKkAkoqA6pgQsW2dJExI5WfOFB9FpeaVpKX0kScEN6hrV?=
 =?us-ascii?Q?t7dyhFsF2kE8XXu5tELNBU0QAJXcPkOCZgJKc1QTrmM47QK3/+1rvCl+iWyA?=
 =?us-ascii?Q?f7Uc4nve+3tEiRYIeSmCkXkFjQqmtExiysbqV6xC++bk2iT2u6n213DegJHr?=
 =?us-ascii?Q?oBMVc+IRl4uFelCcJd+qyhpRh4lyNeeuY5eXvwlFrKrdPo6nPTOwgb5zw8IX?=
 =?us-ascii?Q?scnTYl13jFsU7nxegMjx8da3p9OR3zPvs2UzIAySZ8F+ysF5tdRRHtN0nmJK?=
 =?us-ascii?Q?RiYdNNDUuiD4btZnFPeAuZUHx7DggpwGUL4siXKjfOwimCNH/GE15sSel+4x?=
 =?us-ascii?Q?AUP9GKuUGv4ZJoIFObIveQBBMxTvO7LdfUaGNdGlIH6oON4jAIEQIYtXskPX?=
 =?us-ascii?Q?Ss2jufXgc6mGcO+fWtAwNo5uTthTFPof57yrMul1Q3RDR/dLW1yvsIjW9O6p?=
 =?us-ascii?Q?Zx65k2gAVQFumYYQz3GzP9sJKvc1AeoaUCJx88LrSgAAB4sNvlmv+66nSlS0?=
 =?us-ascii?Q?6ZGpGJCQXTrjU/XrhO7vFXjyIgE5Wh7+80C2/KbCiToZfFzn5WuHAi0iJMTt?=
 =?us-ascii?Q?975UbhzY/vnrAZ6IfnGi4eo4GmVZukqT2QFp4NbyDGUex/pddm9AzVjTDHNJ?=
 =?us-ascii?Q?exCK3y5LzMMVypLo87eTnHlX0mcqtrYtC/b2DlOvxLCspnSCAvLfPQYt7rd9?=
 =?us-ascii?Q?NYw9M+31I3AuEDrJk2NZl3B6A15PimKcKMBdEMiFE65P/5nH2eVValiaUQly?=
 =?us-ascii?Q?ZmdS+ZMurRiG+N6fkhWp77ocQ6A9XwmNo3Rd4y02Gaq5D3L62r+gcZ8qgKQl?=
 =?us-ascii?Q?FyaJNh8Zcq31gBa+lho=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:01.4990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01bd5a4-d9b2-47ac-ced4-08de4ec50fe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 86cc90a662965..7d02569cd4738 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -306,7 +306,8 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -318,8 +319,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -328,22 +327,27 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
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
@@ -358,7 +362,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

