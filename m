Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FA0C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 20:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9896010E153;
	Mon, 13 May 2024 20:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="biZiA+9j";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DFD10E942
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 20:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzCiaAaLOBefJB8uN399AruvD1Ivicpb7czV5kILleD4Va5NvKDlOQQYo1oFW1RK1ad9AiGzNEoPUEqktreiGTGbJ3T2YRHiu6FrZIYn2muAAhveJsOOojBxhpXaEeIS/x+yj7sK9guiybaiq6orIXgrRfEWJcB4OYg8N5mbWjudiZTDkRgEJivHlibEvsVGrUne7jL3ax3EkuQIUjQYQYCo7TxqqyLztEhu+XWB4ytsmRg36nRiexGSEIyL62Z73mZZ6roqBH+qUWOtzkse9VgCoLMRxDJQ28LwO/qH9kMjVfwbg8EiEVruVfbNk05njgJRV1iq0QRK71HtGXVDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL3Kg6mcMqv6eQ5aAybJCBz6K8wwwbWo7ka6nCsAkw0=;
 b=B6jtXj2HLjSVox68EZw8T4kxTVBvMPaHG9S67W0MbMZUrBOYymHlUQz58UKTmZWT1h89cPvp2dPSgYFP7MtDdZMDROkFQh+z6fMlNDzG3d0wNGu2WPuMEARiKMR0r421kMrFod6OddmJJZzWG+tBb9hVARmPcYsaUAURvxXYhQcYe7QkjnDNLdAFJHQKJ7FjrCsmv4hes3ZmXAlXXgEfpMMybYR42R/sYPXu5pp0LkIloFPWnPvaiuUWNta9Mw0OhiA27QTQXmgi0kkSJKzvz4ITLNHe/Yng2ugSFjhD/L8KlPHfZW6RduoO9MukfqR5xXjQ8t/W12s+gz2u6IyO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL3Kg6mcMqv6eQ5aAybJCBz6K8wwwbWo7ka6nCsAkw0=;
 b=biZiA+9jVWliJbvea5Ygup2qxcJZoN0p+Ze6yxb3Ug2xnc3ylWYiV2mOZtb1DG98amTVpgT6UyJquwrh6BJL8CB4ZLpiR9WEdWG1ojMkrlg7c43UMkNTwr/xgVu4+Swse9sTZZYw5aTMqnMOEdQ3641SD6AnluRk+h2VtGPq+YE=
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 20:25:34 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::6c) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 20:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 20:25:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 15:25:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: handle priority setup for gfx pipe1
Date: Mon, 13 May 2024 16:25:13 -0400
Message-ID: <20240513202514.141828-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513202514.141828-1-alexander.deucher@amd.com>
References: <20240513202514.141828-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 422d35ba-fbda-4573-5e9b-08dc738ad804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p76cmaDBh378D/kZyMQ1TxYnp5PbwdWdvPOxnp2GgBkjEbjEPrMS3sXcnm7b?=
 =?us-ascii?Q?NxjhXKbFG5Z/A5q58PBMWwnMHDrmWZf6Vq+qw5/Jig8zUwzL4O0z6D7pM3o2?=
 =?us-ascii?Q?1xC+eS3k9jdZX6p5D7HQKOtGxzJ8v+xcvU9HMgSI5c7vNngaXIgf4JPI7/I8?=
 =?us-ascii?Q?QOljdvrQ+4TFMiFrkDOf2inUyzveNziNWNaSeeTscUxbkbgh3Yc8FcCEj47N?=
 =?us-ascii?Q?tNtBp493Vje0OKGk0jrUhcJ32mcjdTvaOM+9PPXXdRCgjcO7A82w76/VyF5/?=
 =?us-ascii?Q?7s+IzwqRy3L2lFY7LeYOj27YuUNANBrSDgxZ6aPo67lJ7e1hJy7zNmMVrfdE?=
 =?us-ascii?Q?FTNpT7hzeBYiysiVYcWigGSgo997LbsSCVkiUv8ePPUahnoHra3qao2U8320?=
 =?us-ascii?Q?KRzPIWDYhO+l7S9yEGQn1RYOfC5FEXNOsQ7uwTu3K/4iVeZ5T2CH+MlCKVAC?=
 =?us-ascii?Q?qO5NSV795jy4RJN00uVqfYeREyOgl1oIiFoWhTEZFwGDofJDDiLPTv8iH/9a?=
 =?us-ascii?Q?htyBjs0IgsZ3eFZ4rn9yZ20slEX1YoZTBmm+waJNf/2gydIv/4ohdGhONmIE?=
 =?us-ascii?Q?tt0TEnWotUhkLaBadpLh1VbSRff+fzAjjTPrc14/B399H6MWiBpofWgar4YZ?=
 =?us-ascii?Q?RK3sCOwp8fNwkufbhYVJNkfIEYTNytEyCdedjnFqAjmepwaaPTf1z/DkrteV?=
 =?us-ascii?Q?O6wD8mLoWBgImOOFCAVFzMQgbkh7H8xvz3a89l8XzYMiqyPMGFvLC0KnnfYn?=
 =?us-ascii?Q?bRa0lHxakhI8Ysf8k1JhibaOFX1L13m3qY8VIc50GIDP8ClqHy1nT37VDJ8v?=
 =?us-ascii?Q?/qawp4wr58WgPYcR1AgRCX2OnNQw1D6YUV6qmjQL1Vo3Pb7WyHYYj5x4Wt8d?=
 =?us-ascii?Q?z3z2HstTMq+HuMAxCeW68bj3b45y+25maE7Jp5QxTbNCA/m44s+sOTkpC+Ha?=
 =?us-ascii?Q?9hveelZPtUWrgfGcwr7WzHzg069yU+s71k8a7HkMrOwY1EldXSs0AyqIeXws?=
 =?us-ascii?Q?pMszbuC91jlco6Y/b59ryhKuCTtg+lYFAF7KB4DAeKsckHnRxFU/JmZab9R0?=
 =?us-ascii?Q?nKJuDBHcxp17KXGwCFbC7LgtIM/QWsjbE1S5/ADeeJKFvxmudEYaydIexBAF?=
 =?us-ascii?Q?Zw8b19PppW/2V5QstGKbormzcNHrSV3VRhe/nYsaET6JTpB7nxpJmylOUcAb?=
 =?us-ascii?Q?M2xXRF/INmEmLMXck8cLDF8zhORWBefk+RJUsk1sI1hEdS2nVaJbtYeu1LXF?=
 =?us-ascii?Q?glCNkAF8f4+jtexVvidnlF6+YsoBLYLrerKpG3pt6k0729vRjbm2M5uY+AiN?=
 =?us-ascii?Q?DXpMdU7NVT1sBDRY1TI3OMS7wV6p/6ofa9hAbICCojrUs316uqQ96NrE4K3e?=
 =?us-ascii?Q?XhRevo8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:25:34.5051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 422d35ba-fbda-4573-5e9b-08dc738ad804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

Set up pipe1 as a high priority queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 36 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c8c055ef2f3c2..d750ab86e4b27 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -930,9 +930,9 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 				   int me, int pipe, int queue)
 {
-	int r;
 	struct amdgpu_ring *ring;
 	unsigned int irq_type;
+	unsigned int hw_prio;
 
 	ring = &adev->gfx.gfx_ring[ring_id];
 
@@ -951,11 +951,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 	sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
-	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
-			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r)
-		return r;
-	return 0;
+	hw_prio = amdgpu_gfx_is_high_priority_graphics_queue(adev, ring) ?
+		AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	return amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
+				hw_prio, NULL);
 }
 
 static int gfx_v11_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
@@ -3616,6 +3615,24 @@ static void gfx_v11_0_cp_set_doorbell_range(struct amdgpu_device *adev)
 		     (adev->doorbell_index.userqueue_end * 2) << 2);
 }
 
+static void gfx_v11_0_gfx_mqd_set_priority(struct amdgpu_device *adev,
+					   struct v11_gfx_mqd *mqd,
+					   struct amdgpu_mqd_prop *prop)
+{
+	bool priority = 0;
+	u32 tmp;
+
+	/* set up default queue priority level
+	 * 0x0 = low priority, 0x1 = high priority
+	 */
+	if (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH)
+		priority = 1;
+
+	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, priority);
+	mqd->cp_gfx_hqd_queue_priority = tmp;
+}
+
 static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 				  struct amdgpu_mqd_prop *prop)
 {
@@ -3644,11 +3661,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
 	mqd->cp_gfx_hqd_vmid = 0;
 
-	/* set up default queue priority level
-	 * 0x0 = low priority, 0x1 = high priority */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
-	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
-	mqd->cp_gfx_hqd_queue_priority = tmp;
+	/* set up gfx queue priority */
+	gfx_v11_0_gfx_mqd_set_priority(adev, mqd, prop);
 
 	/* set up time quantum */
 	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
-- 
2.45.0

