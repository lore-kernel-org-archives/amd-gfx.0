Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF42FD167F3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 10:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9033510E882;
	Fri,  9 Jan 2026 10:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qcror/i1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BDE10E882
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 10:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQI6ElXWSTFQn41MD1dAQ7iL3jwbqrFuBYc/iAHPCKsVv+7a5R7saCUV72qLIGttyQDELbUYTYzFwS+WpSz0arC/4ZCMowu++Xu1Ys9JIpBpvjBl4yebA1AVGUtVtLmhEHKbS29Ko6spYzlneR91HKDs7GI3TCV8rNrmOzI8a7kvBnFWkQRxMT4XLoiYbqQFcH5iWKiK/CGgKmZNt838Mr/f2SsVBxYI+b3PY++DRAk9HVyBO3Nu680ZdobJTg5k29OpeewAw2Y2DyWa0e3VO/5s0HINRvFf6SkG4V27ciCBizslwKUrFX+5AfwLttffajLMKmket8sNhWS1GIlZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JgYpIveu4GY7BFQmfiNxDEVXjBeLzBGEEl4BFEpUeA=;
 b=f3V5TWcu3sL/MUHPJfYkKuFBN6fl9WG+u4fjZABspvfB2PYZz4IxuL+OTMY//WabTb9EG2eLajoW87RTuSgMtCpzuB8a3G2K7hrEJe0oWKuLSOCQ71ilfMbahOV1uSqaPTI9QbZQZyabniTU34UzOcU6DS4IvEmMia7lCyQ3711FagXbnrK58/xlflxjSxTImen5FAyKRj9VrqKTwQhg2dOKyC2p3g/N288DCfaA+hrkbcF8vURUvn38VckQsjL7HFMpi+XT6xotJqMsjCAVZDj1PB56IucHjSvZrxg2ovVtkYexxBBM9k9P8kxttbo6DMTcafnh/0voLLA6Z0J0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JgYpIveu4GY7BFQmfiNxDEVXjBeLzBGEEl4BFEpUeA=;
 b=Qcror/i1pcsYMoeGXKvFxCN2YxUaCtOspZWdSHhQiuVIeOGq/EyJk6iFPUR06dyxiq4dhXSfRkwUTtF+Ob6zyktVZ0aW8UCzh06b8qDuJcqV/UmL7FX53nvIt4viHFsxXctB0J8eg/DW+S8YIuFrsAkt5dYV8diFNDCyEK3/h3s=
Received: from BN0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:408:ec::12)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 10:09:47 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::3b) by BN0PR04CA0097.outlook.office365.com
 (2603:10b6:408:ec::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 10:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 10:09:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 04:09:47 -0600
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 02:09:45 -0800
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes: Simplify hqd mask initialization
Date: Fri, 9 Jan 2026 18:09:36 +0800
Message-ID: <20260109100936.1163980-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: e1729004-e7b7-4966-3dae-08de4f6737f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HeLf0cXH3V4Oo9uFCYIiO/4tkYxAkAfe0v/lx0H9nLASHNl1UvuwGQH+YSg+?=
 =?us-ascii?Q?mgIx8zIp7PXzM9W33sq1+Wf9Zb3mv4HGg12qK4feXgF5zlgInNE5ovv/bRf0?=
 =?us-ascii?Q?lxiEG29GwAl5+mCYGbaRosPhsA6CPjKs8xxueW4Jgl5b+DG5GPAPGWCJcu/4?=
 =?us-ascii?Q?iuX+AeLRfbRuaJNUisvSdfa+034kkXJm7AKxTY1UFw9c22BIv+iltXs96ZPV?=
 =?us-ascii?Q?S5FJAla0PClJayLc9xCFo93wAMpoPyABp1SQnOqs29ltC1QABsL0jFLnH+cP?=
 =?us-ascii?Q?hPxNBO+D8GBuNVy+tWOxSdLq8COi5iermMbtJXpac+/b9KILQNZPtdDRHs9C?=
 =?us-ascii?Q?RufHI5mFYfiqBNCFgXx16vyxyDZJoP4U9jFf+8+XIQ2hbldqBtgeXCz26vu6?=
 =?us-ascii?Q?uPOqidUlbZdqHXUZCae/RYuV+iEzGSBzzE3W32pDCj5gMQ4xGS4fCbWS/GVs?=
 =?us-ascii?Q?F+el/cny0Ylc7LhsGimOsljYt7eeYikBLIyZ7wIE8jYTZE+jU8xnP5TcxZkw?=
 =?us-ascii?Q?bzOyTErLovB+WZCJQztYq7py6k40MIm3q3pVmswvU9hewtOa8+iJXaZY5Kht?=
 =?us-ascii?Q?WEv4KlrxuTwHH6kKPW1n6o4N1FTYmEya2vn4GZpFraed1LMlI1tYp/VhkOSE?=
 =?us-ascii?Q?MAUqF5WgWzYErti2fNumT9VU2Km1w/DYUui2AsM0cugNHLNu3xUxSjGamjAR?=
 =?us-ascii?Q?+BH0kPbyPm04F0OkxqWaYMlohl3IMrezOsk2sOKJAx5+Z8jLSs3g2OHSYvRB?=
 =?us-ascii?Q?OX1nADJ47bEtHWN5ZfLnEyi0kitqzNAr/6rSHHiI0Pq+xWnMT8nAi8bM31ix?=
 =?us-ascii?Q?zxRXta6DiTVTapGuq+D+K4V0Jat9MpIjpNh//f6/XOHd/bWzyHxiwuj4Sga/?=
 =?us-ascii?Q?c2H8sa2821pH5zm+Juc4/HhueAFlPGJQ7dZR0nXA772y0eT8UwlzuTmkPI/h?=
 =?us-ascii?Q?qhi3VyWkKT9IEHtBIzoSjJAuNiMHHkhkYnENIBQqI2ZmeuubXklrq5xcnI67?=
 =?us-ascii?Q?nlqcEfGESCcQ5ojxhSy4T88idg6T/ydtyEohpZDR7zBmxYaRZiUYUKGngeeV?=
 =?us-ascii?Q?V5Ucn3W8V6JIvWcmlZkWnRFPpKmt4ov8/gwBNAQ9HL5MhCVmympcsCv/pOWO?=
 =?us-ascii?Q?Pa/CkbqB1Nmjwy8BSmdG337p3lUODB4WK24sjKzGKK4llxSuuWUo8MaLst01?=
 =?us-ascii?Q?WTMG7GDtdbQUlJAErppgfIEInEGwOtXI/siBja51V49xmJj4AMDhiPmODhOR?=
 =?us-ascii?Q?o0msrtpUD6SqbkqfG5Ss5vcqjUao1FAUwKFdZP5ElSxl96KsubmdGV69rUGr?=
 =?us-ascii?Q?C2a9vuE0Ww/dEJaEwj4fLl/wVj1ziQqHsyN5IeaHWwj8pthD8zxRvtcSPKnx?=
 =?us-ascii?Q?BBfF34AS0k6ZZz4/Q0P9X5vFfkAPjzdSYwYl9PTk70bREbyCDrNZ2bGSWvvF?=
 =?us-ascii?Q?HXU2Dmh+PND8ky4EGgmfd+/BGLEs32dfrE2bC5cmVJq2yk5sd2djrIExKTMc?=
 =?us-ascii?Q?m5MOhAdX3bWe4pDoXAhXecGxrO2FXfc0hl8KBJNRmX4J3YddXwAA+h0oEM/o?=
 =?us-ascii?Q?rQzqtNvAnvA3nEYeVaU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 10:09:47.1674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1729004-e7b7-4966-3dae-08de4f6737f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
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

"adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF" is
incorrect for MEC with 8 queues per pipe. Let's calculate hqd
mask with number of queues per pipe and number of gfx/compute
queues kernel used, and get rid of version check and hardcode.

Currently, only MEC1 is used for both kernel/user compute queue.
To enable more MECs, we need to redistribute queue per pipe and
adjust queue resource shared with kfd that needs a separate patch.
Skip other MECs for now.

v2: Force reserved queues to 0 if kernel queue is explicitly disabled.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 59 +++++++++++++++----------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index dffa0f7276b7..bed37e50d45b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -31,7 +31,6 @@
 
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
-#define AMDGPU_MES_RESERVED_QUEUES	2
 
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 {
@@ -89,12 +88,25 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
 	bitmap_free(adev->mes.doorbell_bitmap);
 }
 
+static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe, u32 num_hqd_per_pipe, u32 num_reserved_hqd)
+{
+	u32 total_hqd_mask = (u32)((1ULL << num_hqd_per_pipe) - 1);
+	u32 reserved_hqd_mask = (u32)((1ULL << DIV_ROUND_UP(num_reserved_hqd, num_pipe)) - 1);
+
+	return (total_hqd_mask & ~reserved_hqd_mask);
+}
+
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes;
 	u32 total_vmid_mask, reserved_vmid_mask;
-	u32 queue_mask, reserved_queue_mask;
 	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
+				adev->gfx.me.num_queue_per_pipe,
+				adev->gfx.disable_kq ? 0 : adev->gfx.num_gfx_rings);
+	u32 compute_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.mec.num_pipe_per_mec,
+				adev->gfx.mec.num_queue_per_pipe,
+				adev->gfx.disable_kq ? 0 : adev->gfx.num_compute_rings);
 
 	adev->mes.adev = adev;
 
@@ -115,9 +127,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xFF00;
 	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
 
-	queue_mask = (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1;
-	reserved_queue_mask = (u32)(1UL << AMDGPU_MES_RESERVED_QUEUES) - 1;
-
 	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
 	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
 		dev_warn(adev->dev, "more gfx pipes than supported by MES! (%d vs %d)\n",
@@ -126,22 +135,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
 		if (i >= num_pipes)
 			break;
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
-		    IP_VERSION(12, 0, 0))
-			/*
-			 * GFX V12 has only one GFX pipe, but 8 queues in it.
-			 * GFX pipe 0 queue 0 is being used by Kernel queue.
-			 * Set GFX pipe 0 queue 1-7 for MES scheduling
-			 * mask = 1111 1110b
-			 */
-			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
-		else
-			/*
-			 * GFX pipe 0 queue 0 is being used by Kernel queue.
-			 * Set GFX pipe 0 queue 1 for MES scheduling
-			 * mask = 10b
-			 */
-			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
+
+		adev->mes.gfx_hqd_mask[i] = gfx_hqd_mask;
 	}
 
 	num_pipes = adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec;
@@ -150,10 +145,15 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			 num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-		if (i >= num_pipes)
+		/*
+		 * Currently, only MEC1 is used for both kernel and user compute queue.
+		 * To enable more MECs, we need to redistribute queue per pipe and
+		 * adjust queue resource shared with kfd. Skip other MECs for now.
+		 */
+		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			break;
-		adev->mes.compute_hqd_mask[i] =
-			adev->gfx.disable_kq ? 0xF : (queue_mask & ~reserved_queue_mask);
+
+		adev->mes.compute_hqd_mask[i] = compute_hqd_mask;
 	}
 
 	num_pipes = adev->sdma.num_instances;
@@ -167,6 +167,17 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
+	dev_info(adev->dev,
+			 "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
+			 adev->mes.vmid_mask_mmhub,
+			 adev->mes.vmid_mask_gfxhub);
+
+	dev_info(adev->dev,
+			 "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
+			 adev->mes.gfx_hqd_mask[0],
+			 adev->mes.compute_hqd_mask[0],
+			 adev->mes.sdma_hqd_mask[0]);
+
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
 		r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i]);
 		if (r) {
-- 
2.34.1

