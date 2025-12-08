Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D76D3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950EC10E405;
	Mon,  8 Dec 2025 17:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7Oys1Jq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A052910E46A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbdvANlQPFXWly2tiNsoLfSzvRZH4NaVSWBwGPfGm4vDlghL6dbmpjFGhWESoaPX5ovsjPlTApcOd6gMnD3qoalehhU3uRRCYVMGFpnVufB42P5DvRym5TW9OpLsb6SFfxVGOGmNGqKy+sNPDarzyRKkIDw1jz/k5f8rhxM+fPTpQ2nUX6Xm1X7zes3K/IOwICoCyRntNIZ1RLRUqV5VZCSelioYHgHT7iobLfObj3nEt+3c1m48QuqonT/RnOT4RE2ZWPfrzvwyqpwJaN5xdsuS4FE2fE/pijYfl4pIxqJgic/d/sLyzDp3MZW/xX9pGkeAgYuSzQFAc+Fw+t5+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa4cQ3L69SaxFFHm1rVPLsjtK69yz/cXfrXg3OGsZnc=;
 b=A0+wCd0geOk7ePhnZYyo9XdLJWg6GWiVeoaxK2kQcf/n6+dz6xV3nL6vFIg6JaA8CMLME3bUJWSjq2UGWN9vdX60VB9wafFFYo109dLhceX9L8rCsHNi8akh6bMpeg4QTvx/W8NyVeIVtt4Dm7n6BLrjHHFol5Ar1rWpyzPLxiTyNgcvp/nLF68o6pvkHsw2qqcfpX1iz89we1mxrnvmoCBq5OKqeba9e/eVzhjiBPFxDBGiPzS/zPJHhpohQjbM10fW6/Nvy/uquIQPenXMG/9EfXAaB9VDk0AVp0mG69KJiIze3AD1RNviUqmbjI293lrMpui8ln81JKYEr+tAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa4cQ3L69SaxFFHm1rVPLsjtK69yz/cXfrXg3OGsZnc=;
 b=V7Oys1JqLFhYrX5TU0yse7revUxX5twgVSlwn7GUAJJRRfnEe/GyALJP9fl7J0g3kdTL3VTMo7JIrNxvNUugv9VzEvhCFpULdBwXD4d+kBCk9NdctEzJ0DH3AMRNAjXIMiM7N9+r0ZiCcwubhbpGvs5RJfODhJ7+ZThk47qEzz0=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Mon, 8 Dec
 2025 17:17:43 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::f5) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Mon, 8
 Dec 2025 17:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:43 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add IH node-id to XCC mapping
Date: Mon, 8 Dec 2025 12:17:03 -0500
Message-ID: <20251208171720.153355-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: e13cba90-6d61-433d-fc7e-08de367db2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5YYQK8friv8UtTNXzfaJfRXzQR75FJ0heQBwneasFgW967duutdp1V4lqCrt?=
 =?us-ascii?Q?zomOxY9ZUH9WGyM2FdEAmrjuWesokwG2FaRmuEHzT0kBfimogbchW9g3TJXN?=
 =?us-ascii?Q?EER3xOULwYCI0HNXUQrlyrwPUGSYWxa9h5Fvi3I+1ZrkghTGb328oTqIbPah?=
 =?us-ascii?Q?eDqcIYaD0PNV4Q2FI+995uNpbEcjeKNdVccnoBj0amtvyV4ope2yzihFh2MR?=
 =?us-ascii?Q?E+2YOgLJcD/B6n53o/LlboSBpOqyShlBeXQPKs3KJD8CV7Z1Xo+VPWMTnqLp?=
 =?us-ascii?Q?5Y1MiIjSLPM54Guv1P+58WypP12UnGqOcI7DiO5nOoeAR94BTl9+lvEnfeeJ?=
 =?us-ascii?Q?iPfHcSfAzalp/16ike6AKhMSz68uOU46tdAlQbcLXt8iL9We7rUBsWkPwZwh?=
 =?us-ascii?Q?qCBgmOvSTj0smeIdA5uuMIqQVr6kWhGtTCdjC3sczawKi7Bk8psi1AnYJmIP?=
 =?us-ascii?Q?c2XXUC3FeWgHoftO3zoxIjilMDzbHMXs4REbkltnuOdGwvV1duzgsNZb1IRx?=
 =?us-ascii?Q?X+9Re6d51UtLLfnWh6QGoT1UsjTdgon+UqPFGl22BnP1OfnGdCvnrHf5MhQX?=
 =?us-ascii?Q?rbgkXZzw8g/H+yCiTuJjqY2F4dtihNJVRf4m3Kqi7pBxjTjRvA1QR92sbQzg?=
 =?us-ascii?Q?5St6PfpLyxcVkKxTOKqi7MR2hb0misHGgpoVB6+/XoZBgQ6Gpz+0g1wbckEs?=
 =?us-ascii?Q?5ZhPas1iBAGPJWh0BaS6WdjwUZkPx8pEGNAnZCBrsUFKXjXW4RYsRTuGmxUh?=
 =?us-ascii?Q?sqOFQzDF6CUfthYeMfP9sCzRPiBrIdB8bk8GU/Gutv+2U6tWTGHQOqt3Kq+B?=
 =?us-ascii?Q?r2Y5/Onn5eQ+QwKcpomSy7XckZvCnaVbTbhXp63TiOF7M0caiymGByX4re+4?=
 =?us-ascii?Q?TDhk0YSL5YSSQ3ahg9Hh0LZ46sT49faY5ekNKIm7vnI7el5jUsz8D5U6vXc6?=
 =?us-ascii?Q?2gRv53/+FoOHhZx6ZAryBFw9thqNWZ72vwjObMGca+c/ApG4vC/cvcX6O4bf?=
 =?us-ascii?Q?0rFGJQGAFkHyAXIcLjFtLP3ctsgAhAiAT/FesMafG6/BTiVLSSLw9ZSdj5q2?=
 =?us-ascii?Q?T9ZduLOX3TFq+JQpgv+yc0keE7uWbUJqcIMKos83+1vVRaJ89f0TN6Nloy2R?=
 =?us-ascii?Q?cxD287xBzHGBeHGwxMe8CfMPv7y3jcuhguMvnefMFfu7W8eQiwVTklVA86KN?=
 =?us-ascii?Q?8amQZ8S+vuRqZ4CyFY9jlTatb4SSYS6UndzETFShTlCYZ51prP6bKDFEI842?=
 =?us-ascii?Q?+sFuHIaRQRvh6uqbOmvuAdU0BAjBtV/RbIzIW/RLBsy+BTiW/KjgHHPTOg99?=
 =?us-ascii?Q?DOFKY9AFN8uVbTav4gOTVthu8Cde3THQMCYpYWLJn26bSLYs5IQtOwTMEwol?=
 =?us-ascii?Q?1MUjk1u1uO/f3L9JiK/9/MggNP8EbDsaFvFOC2iIH/lIp3Vpxkr3UXI7GRBI?=
 =?us-ascii?Q?NfgRF5RglVnEr7Dn0zIXL1Ik3vtpDX7FXys8fiiAG1p1+o3YN+lc59AqfjeY?=
 =?us-ascii?Q?wubBSjLmJ2LhYV0KRA1aagl5KOhqzcXLERMrADBI2dafYNuOdk/A+UJNZ+7v?=
 =?us-ascii?Q?L3mw9XY0Uvn2QAkgjMU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:43.3264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13cba90-6d61-433d-fc7e-08de367db2f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add a generic function to map IH node-id to XCC instance.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 33 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 453520d374a08..d9af479bafb78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -692,6 +692,18 @@ static void gfx_v12_1_select_me_pipe_q(struct amdgpu_device *adev,
 	soc_v1_0_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));
 }
 
+static int gfx_v12_1_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
+{
+	int xcc = (ih_node & 0x7) - 2 + (ih_node >> 3) * 4;
+
+	if (xcc < 0 || xcc >= hweight8(adev->gfx.xcc_mask)) {
+		dev_err(adev->dev, "Couldn't find xcc mapping from IH node");
+		return -EINVAL;
+	}
+
+	return xcc;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v12_1_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v12_1_xcc_select_se_sh,
@@ -700,6 +712,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v12_1_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v12_1_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_1_update_perf_clk,
+	.ih_node_to_logical_xcc = &gfx_v12_1_ih_to_xcc_inst,
 };
 
 static int gfx_v12_1_gpu_early_init(struct amdgpu_device *adev)
@@ -3407,7 +3420,7 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_irq_src *source,
 			     struct amdgpu_iv_entry *entry)
 {
-	int i;
+	int i, xcc_id;
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
 	uint32_t mes_queue_id = entry->src_data[0];
@@ -3430,6 +3443,10 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
 		queue_id = (entry->ring_id & 0x70) >> 4;
+		xcc_id = gfx_v12_1_ih_to_xcc_inst(adev, entry->node_id);
+
+		if (xcc_id == -EINVAL)
+			return -EINVAL;
 
 		switch (me_id) {
 		case 0:
@@ -3441,7 +3458,9 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 		case 1:
 		case 2:
 			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
+				ring = &adev->gfx.compute_ring
+						[i +
+						 xcc_id * adev->gfx.num_compute_rings];
 				/* Per-queue interrupt is supported for MEC starting from VI.
 				 * The interrupt can only be enabled/disabled per pipe instead
 				 * of per queue.
@@ -3509,11 +3528,15 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
 {
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
-	int i;
+	int i, xcc_id;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
+	xcc_id = gfx_v12_1_ih_to_xcc_inst(adev, entry->node_id);
+
+	if (xcc_id == -EINVAL)
+		return;
 
 	switch (me_id) {
 	case 0:
@@ -3527,7 +3550,9 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
 	case 1:
 	case 2:
 		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
+			ring = &adev->gfx.compute_ring
+					[i +
+					 xcc_id * adev->gfx.num_compute_rings];
 			if (ring->me == me_id && ring->pipe == pipe_id &&
 			    ring->queue == queue_id)
 				drm_sched_fault(&ring->sched);
-- 
2.51.1

