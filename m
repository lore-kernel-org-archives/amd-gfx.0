Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF51C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 21:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE49C10E397;
	Thu,  2 May 2024 21:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egerzYp+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E34510E397
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 21:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu0SErG9W0Si6keH97qlxDsGIlYSon+5AErqIRH6o+WeF76UnRPC2/ZjAVXhqunAdofdXrsqOzkRm5kDXuGuUXCELfMXAKE0rC7FXOdcBGk63k1YWtQh6ayVfoc4kneH1RwVHqYLSlpHgssS4ComUwS/aOJGYiD7CBjhagbLeaXwEUpSpcwBDyuN0/tHI7XQo4xaPK3bFLcUcVkBBEF961pXxqJSTX7ANsrbwg2BmwRW2m62dojIwpQ1phng4DODvE2yNwLPCWLromWTRWXi8TRGT9bVjk8kTYA/qOFFcU8+tQpt3Am2jvON5Jj42nXsyD0nQNOFDA9GLIikvzuDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrlX3NzPutYUz/bHjsf63wmkND8YuCAypHoay6MdbSA=;
 b=eYEnC3YrW893SqGE5QjwI8JQzzDJYZaYI0i7RTPr0u2gNJVYAVoa+yI9CJmeaKjlVHgS9517mshhqiXHvxxGoUc/Jf5BtX645dN74pB3w4U+WVMVoyHRwdV4Pt3iqE2TdJT8MhOFgpZGJvPNs21r/57GvcNhkaMTKRYdUz2PZDkLro+gbT51HO0WwgIMS52urY4KXW2aTnbpyIIb0Q1bKTOENxxo7xpmE9538lGvNM3EUaiXHpA/4TyiFJGuuXNbz9PRTHIJhKAp1ha9cOR+xzUCPfpw407e5REiSs8TtVpviJ5laJapN0xmXTf9s42HfsjqGI3yvvQWLtWupGHRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrlX3NzPutYUz/bHjsf63wmkND8YuCAypHoay6MdbSA=;
 b=egerzYp+GCwY2l6e2qlPcnOw7jDJXanQalH2dNU1ZpUGz+YTvwd6f46RDp6dS0mKBWMf6plvxGC/KTI3xBQ5qXokOVjY5v/hU9+cGuV2ircqy2OBEw6FQx+8vQ4tpYTrxCKdbhPY2JTqsupJty/taMQYwEawMfZjk/lbU+rarig=
Received: from BN9PR03CA0375.namprd03.prod.outlook.com (2603:10b6:408:f7::20)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 21:42:40 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::29) by BN9PR03CA0375.outlook.office365.com
 (2603:10b6:408:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Thu, 2 May 2024 21:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 21:42:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 16:42:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: handle priority setup for gfx pipe1
Date: Thu, 2 May 2024 17:42:24 -0400
Message-ID: <20240502214225.8101-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502214225.8101-1-alexander.deucher@amd.com>
References: <20240502214225.8101-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcb97fc-2079-4af5-dace-08dc6af0ca6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SjfJKaU15fN+XUDEvzFpH9hZQ3hvtQwwf9E0Qqxe6N6rpqk3qygbzRhtwOZe?=
 =?us-ascii?Q?R5sCl13IVa9vPVZ5pyL7WtT6kwLYjTPvgTrtw0j9F3Ml4DbmjR+xCTFbcWMd?=
 =?us-ascii?Q?bKlN7mRRu/ly4jX3rwroy7q0jN4iyje8Q7A893hn79ZCps6Ry8708zBs+Khc?=
 =?us-ascii?Q?e7KWIKtfUbBr92J/F/qR9X+XyFhQ45l7ZgyIqHBGaoMNCo8f2ZYA+nfTaRye?=
 =?us-ascii?Q?HwBWe6opog5nkKrjLz1XBwBfvR/ogwluNw3BsyieqI/DidRcDpLD17oWZm4J?=
 =?us-ascii?Q?UocTn4OM3aB+V0v6h2o/Jifkza23QWuBeja6gv1Sesc5SodM1ZX/nHOIjhAi?=
 =?us-ascii?Q?QQzQaHSBfzdwhnZlDsmxlYNOUiVFLHgcPt2mpgLxwURWJ2iBik+XI/4RZGC3?=
 =?us-ascii?Q?WbZpsx7sS/cebyqinuFbt0WxSW+pNe4EEzpQZXo+7+I5GhlqmMcOEItM+tqK?=
 =?us-ascii?Q?IVryfbqa1vZZgf8YJ8KcUKSdBGva0DdI0C0ItG/1c3lbwMewxy4Z86BlSc2B?=
 =?us-ascii?Q?U5d/uQal4E28EeqVkyuo4ImTPKRlEM2NXLLiq9VySrEI1o8v9G2IkQl4+/t/?=
 =?us-ascii?Q?ArWl1GaKws0SF/TLXLjzR943s4FuzsudYTuATZjv90Sc5RtcLoXi1v1PE2yi?=
 =?us-ascii?Q?3fdJKHqzAi0Qn0A8LNvdvSdMNiQIwhKAyj9yw7QK7BBpvb7yGGWsR4VvLeRB?=
 =?us-ascii?Q?H3OJAhdRzhf4RVnMm0TtIrxXeee/omQYZGvVvMG7Dr1/Nl1gcuEt9auCdtq8?=
 =?us-ascii?Q?rt8KsgqD7peo0qnnqLvMmwdiMN9IFbPn48AHoche9wtuHnLkyj4UphigVPEb?=
 =?us-ascii?Q?3SQW/WJJbhB32vcdl1zKAHGWX6S/DX1By8M1z+kS1ULFwMAYR0Icz7z277VA?=
 =?us-ascii?Q?frFWc9Tly9UTa48XqyfP1X8GfkvEwayoTgCQK4x+5iigNyI4crEktWYZV7zI?=
 =?us-ascii?Q?HMQ3RA8yh0dIfBPllFLQ8pVebu2X1TGNwX8RyJAyovRkHqiZUNqaxF3gEqv6?=
 =?us-ascii?Q?LviMUy7qy/wkMrqO47akZckkzi1OtT6YggxNp2rjq4gziOvToQtbfCt2rcmB?=
 =?us-ascii?Q?cIYwxHagfC5CKkjZnOlg0is4N3Cw2/IJcVhkgP1v903NIeZl44hIoZvLUWzA?=
 =?us-ascii?Q?XOFbvogXicfKdvhn08TufMOyd2OuEhei3FYM3d4AfAlsvx30MN8JfBN3TmaK?=
 =?us-ascii?Q?7c1vpGuC8fASbjaIOfqMfdpmvgtqNjB9OKUIXSueRUyStt9Kr+t29+CXl3fM?=
 =?us-ascii?Q?tlK6D+0637lObG4QJaEQYcd4VGLFaNDO8b1aeQHw3dFt7ub5+Dyk9POmg27J?=
 =?us-ascii?Q?8RZ+1PaJu9XZzU18CHQhFVLRqFKl9CIH2sUfA/wVJPV9NwQzV12fHDc+ALzY?=
 =?us-ascii?Q?LUgbHUg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 21:42:40.0125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcb97fc-2079-4af5-dace-08dc6af0ca6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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
index 81a35d0f0a58e..75157e0196d22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -929,9 +929,9 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 				   int me, int pipe, int queue)
 {
-	int r;
 	struct amdgpu_ring *ring;
 	unsigned int irq_type;
+	unsigned int hw_prio;
 
 	ring = &adev->gfx.gfx_ring[ring_id];
 
@@ -950,11 +950,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
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
@@ -3615,6 +3614,24 @@ static void gfx_v11_0_cp_set_doorbell_range(struct amdgpu_device *adev)
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
@@ -3643,11 +3660,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
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
2.44.0

