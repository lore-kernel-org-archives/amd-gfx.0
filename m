Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21336EF8FF3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 15:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AAD10EA47;
	Wed,  4 Mar 2026 15:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fn9qkQrv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE2A10EA41
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 15:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGSWNVf5uq+7fxE/cl0E7cPLO0GeS6p79pTDN4ySRWFJKV54JVq+SU0aCaDcjlaOzIUMLVfe7v2aji76klbovO46SOkB+d0wuTcipZcBYCjeWE8D4/TVPpW+VjTQKPzNtQxg9tsPxsLagXXoMtpnKVdAt8DbJuwjXsNjrds0ty8hZkgeCWYXrr+C8cZaq66PXpIMpe0RZuJwi7zILM5nKvE0wLhmSzaNOlDh/07GooNebTra9irQBy7mri4rK/SVFGn++tp7FHYr7Kbp+Qm+rkJsEBLQbmbrqpVz/LyTmP9CYeoH+CCIqZ89fo10BklYVOaIAFtNGMt9e8T8qb+K7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZkpMjs5uyWrvnYoKR5/308adiWUp3c8L+AGv1lpi3E=;
 b=V6u0X668kJePEPZh1cAuuuFZgHA+xKeH8iz9c5KGLGkRSxhzRG93z4/l12Z282a9aFvPZj6HfyZEOtELbgIoKibV0uJtA9TX3rLcLvRxwKQOdKCuEp/+apd4UJTM+GmDpB8KGIDcJtzScSS+yCvy3g4uZqNOwGZMd9hqz/QF6urJv7b7QZYNQppI9UmxdMaIyA249n/TdYUuba7htg6W4VgvtfB2hevmtkUlMtEt8oKPTLqGLhWxkL5loRzPokX2r8iz4iN9Jisue0Xy+bgcHaTOo+Tud8xtGc2pyeHS0W+z5S3CVSRdrSR6MMx01pUYHpQBmMORyonRWySiQ8JuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZkpMjs5uyWrvnYoKR5/308adiWUp3c8L+AGv1lpi3E=;
 b=Fn9qkQrvZ5jK7VunpxZSheTjj80S86G1NGqfABlz1AiyACE9mcJpWfOlC9LcvpI0aWlkT5xAmFstdxr3uF+KBXHEiEZ1blpLDXzoe9cZzZl17xVEYQxCmt8aLdJcIHVcRKCtf3i0eK3lsvCERNqXYR+uqNp7mhq3BLaDh+AahY0=
Received: from BL1PR13CA0182.namprd13.prod.outlook.com (2603:10b6:208:2be::7)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:13:10 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::99) by BL1PR13CA0182.outlook.office365.com
 (2603:10b6:208:2be::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.17 via Frontend Transport; Wed,
 4 Mar 2026 15:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 15:13:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 4 Mar
 2026 09:13:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Mar
 2026 09:13:09 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 09:13:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12.1: add support for disable_kq
Date: Wed, 4 Mar 2026 10:13:02 -0500
Message-ID: <20260304151302.62594-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304151302.62594-1-alexander.deucher@amd.com>
References: <20260304151302.62594-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db92df2-7073-4ff7-581a-08de7a008c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: 67YFMITWDr2p/nZgc4gPSL/Y7YFklDclBcnV+VnvFr1K6OVupK7gaJ442fydPLQGMXVJcmZv4cjB0eb0yKVp2/OPUb7bdmS7bfBx3cHVOABiNCpFcuJTC5314Cqz42Xvp57kt+uMmkIruvXkijBSvb/npyUF7hhq2sWJ6GH2Ev1xxJInTPcaluuKir1/5zQC0KOQ+Two18RBJhdXsPBheZQB9JQTKBhtwas07y6j7gdEMN93VyT4wcvbTaFdFdw+Ma0nnY5fagEnVQW7kcg3r1keGdIBXUb9bfUmM02Mfvp4OGwycx9afIYvt47NoJ55wfM2W/w0DrcGPbbPyt0O9MStROas/IPaZUsZZNUgRFpSSqa8LlteOCrQ4gfLch60ZXKUoHiA6ArBv6Q7lyTJaes3PFUamD8iXTFk/HYZK0SNgTjPiKrguflyKIC1YOO4I4AbKtY04rkCDg58iJPUpOF1uYUE+6EBdkxbVQaGAZKadxn+1USt6pXhWROkYKkqCx4VEKvtCueDs1pepclvWACdSAsDY5+YjhOUeB/cbGaKQS0Kc7HUvCijTA1qYWcvhzbTZ9tyDPtOv+pfX5Iu8uBoRzWX7H6w0MlTCDP+BVzWZm6Rr0ryQn8Ippp4P8cwmREPyMyHVzimTz5uKZbFRpYbAx6b4B61R5U2iCXLj5nBjRJXy/5A32FLPXVfV+AcEDbeRQzfg6oHQrV5wImC3YkWaqt6/Yg3doxQ9gSSojp9p9LPni/r2H3XaSgtKV78fud8QHvFDnwaUWfpuwfFyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zukZ3gXckZu8Rd+g+rsOFpfsabJ1RnnZYv5zODK7fC+7f/AHLIeG14vD1zpfyN+WVEmGkVYJz9KHWWlGaR4U/p8BA37zjOtKCwYfzUXgKeBq8M371fqOt/OQKD3FJd+IedUXH0CF9mvO1+9drOq0EX1hqhFgqWe7lgs2moOYQ6f7vbL+Aph/35DnaQRMl3rV2fY7SRLGlmBYV0zuEwy6NP59VrXLXLWMw1sVk4xcjOiJEFByzMsoUfcESmCRegUlYVJHQHtc10C7TL5tXFraJ7oh7X+T5QChgEv/p8uKADvAc4BwGMySCjEe0vmQr0xXnixuV4DrtlApvN9AdTPBdBhK9NAWTyNkEJOOTqhQH4Kpe1gI8rrptoilp+ClbLqZK3I/2O3Yxf1aD0wHNGDrnZef7yMS3YrFon7KZK1ILsTglq/PYTq1pvkHXt/X1UIs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:13:10.4950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db92df2-7073-4ff7-581a-08de7a008c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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

Plumb in support for disabling kernel queues and make it
the default.  For testing, kernel queues can be re-enabled
by setting amdgpu.user_queue=0

v2: integrate feedback from Lijo

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 90 ++++++++++++++++++++------
 1 file changed, 71 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index a0ec38f35c449..c5caed86f1ac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	/* recalculate compute rings to use based on hardware configuration */
-	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
-			     adev->gfx.mec.num_queue_per_pipe) / 2;
-	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
-					  num_compute_rings);
+	if (adev->gfx.num_compute_rings) {
+		/* recalculate compute rings to use based on hardware configuration */
+		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+				     adev->gfx.mec.num_queue_per_pipe) / 2;
+		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+						  num_compute_rings);
+	}
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
@@ -2794,6 +2796,33 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_device *adev,
 	gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 }
 
+static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	unsigned int irq_type;
+	int m, p, r;
+
+	if (adev->gfx.disable_kq) {
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ (m * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2801,6 +2830,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	gfx_v12_1_set_userq_eop_interrupts(adev, false);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
@@ -2868,10 +2898,26 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+
+	switch (amdgpu_user_queue) {
+	case -1:
+	default:
+		adev->gfx.disable_kq = true;
+		adev->gfx.disable_uq = true;
+		break;
+	case 0:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = true;
+		break;
+	}
+
 	adev->gfx.funcs = &gfx_v12_1_gfx_funcs;
 
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq)
+		adev->gfx.num_compute_rings = 0;
+	else
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
 
 	gfx_v12_1_set_kiq_pm4_funcs(adev);
 	gfx_v12_1_set_ring_funcs(adev);
@@ -2898,6 +2944,10 @@ static int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = gfx_v12_1_set_userq_eop_interrupts(adev, true);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -3715,21 +3765,23 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
 	if (xcc_id == -EINVAL)
 		return;
 
-	switch (me_id) {
-	case 1:
-	case 2:
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring
 					[i +
 					 xcc_id * adev->gfx.num_compute_rings];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
 		}
-		break;
-	default:
-		BUG();
-		break;
 	}
 }
 
-- 
2.53.0

