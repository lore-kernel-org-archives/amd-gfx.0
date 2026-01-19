Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CC5C98315
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 05:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2C110E361;
	Mon, 19 Jan 2026 05:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELS9TnpD";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0F710E363
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 05:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXXtHhrEEk6wHsyAISaV31qwMzOcCtKt9HseBNf1MFnwhu/BUfJdZ6OpjU/26HMCPoW3LVqgsMA33gjd9gBzS9KN91v4JF14xMHnHzUkGo25tHZ8SnvVeZrBLBtgVMT3GCFP+Asl5+EXCDsjWjWTOtfhmrKjWouTdkqYVAp9LqulcGBAzdzsWCHahNx7z1rE4gv/cbHtKQJ8AJ1hgr/kKLEC0NDs05Nw/RQ3P/NUphrMMYYHDq06BKTFZB3NBydseX1+phm/HzH2QYA3oy3AHZ241LJ7MnCc0cANmT3+6Gkp4Wmr6LPycq9eOoXY13NIPju7quyXepZ+7PpWa6I/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4cGx3G3B/4BBTo9KS04aRuronCHMGjI8c70kgiLsJ0=;
 b=u7PZbmDFRA28dz8+E6WMIT67uCWg+lRe5AKdzICv5nXTr6CAj8b4vFE5Ylwu06HqSucDfiAo6L3qutSYGE+lLvZ/C6OTybs1H77DCZQmi/nrEr7LlnSJVsudgUDwr1X6mE4lq1ooj5nPHNShqR4IEqXnBHNzC0WgapMP58IrbOLQafVrHXhUr8e0PkoRBusXWKiqCqI8xlgco+8Vg4QQ9hj3S2aUTjhH7oFg6LKMsq0+D6wLbyl99tfTRuJ4uGx/Z1QRdvKaX3xvffu9kOWToJHu13lEJLPIekFz1Sk7yR4uw1mawsbi+U5FRkQv76EDddqiz5WWoHZg7ZMGkRhf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4cGx3G3B/4BBTo9KS04aRuronCHMGjI8c70kgiLsJ0=;
 b=ELS9TnpDCtwPZ4bAnCRTHJLGVNMj9M2OY9ITQxBl9kBHD8nb6xgWLsCpeXXQIJfujcgqGnIT3rwHp5fU3w04jn6oOow0fNeMDVvAMW5OdbKXx0DN5ELUKQhStzKGNTLowdSLLxbmYhNpiH1zyzUb/XaRKCdJmx9QgzZkO5ssj9U=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 05:35:45 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a7) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Mon,
 19 Jan 2026 05:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 05:35:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 18 Jan
 2026 23:35:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 Jan
 2026 23:35:42 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 18 Jan 2026 23:35:36 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu/vcn5.0.1: rework reset handling
Date: Mon, 19 Jan 2026 13:34:05 +0800
Message-ID: <20260119053515.893663-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119053515.893663-1-Jesse.Zhang@amd.com>
References: <20260119053515.893663-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: e19de914-55b2-4027-a922-08de571c9732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vAPnxsUQW6FFmi0LFRAQnkhbQ8+VBVqaS+8uWkyukURlyfudiRZDJgKZHed+?=
 =?us-ascii?Q?CngzVASFi7A2pQ1dMd+O82eOPpddb2HINx8R6kDv2hx0CnqaeOXuErlDfh7g?=
 =?us-ascii?Q?6XRbhUC0DNOvYCTwiR+R2Gh2+0Mn0SxvB2V3B+8g487b5LKEsPa2Om8eEq5f?=
 =?us-ascii?Q?WZUfYJ06NfoBKXT2QrEmSLagKR6r4vrV81CVnAvQxLWH+Pxo2jj1vRqcetue?=
 =?us-ascii?Q?SDqJ3neesJDq1xIEVWARlUfk+GlYUwpfUqW7/U6EgFYsJdAHOw4dBX/XRbte?=
 =?us-ascii?Q?m/cVn3MPu6zxK1fDdGvfKj3ar4mnuWdzNGJ4+UjiojBmURCsTwGg8oqnaVOy?=
 =?us-ascii?Q?QlHIJ5TDhx2sWUthEbYzatXL7O8zPnVqcuqHhKw99L0Q7i2YXgKoYOlZGDrj?=
 =?us-ascii?Q?+AFD/5uV3oF7Yu4Q1RE5o+u81YHcdQ2n4WmWy0P9/OYKcNpl40AZabNhS+bh?=
 =?us-ascii?Q?MsAhblRFiKeilGg8RUL9KMH4Xs3UlB4TRrgpmHwvd2MZm/3VkKmutg13Vv3/?=
 =?us-ascii?Q?SwFJRNPgBxwsiIQKEkWnuQmTNeWXf3k6l5xjMIPOTGv6uvQgEnfCUJOsQwyg?=
 =?us-ascii?Q?3Ttlr+Md+A9vGHB9aH0py38yAhNw6YhvFSAeXmHPA2ZztI9OUPC0NxDdDjEn?=
 =?us-ascii?Q?zF92sqRmrpTvsnwTLupficP0Jxm1vMAttQQkCFFwwEpRm/AGh4WAePNrbO8G?=
 =?us-ascii?Q?i96s8cIFv3tDqDxELQ5rKx64F9iKQFpebiheXM+fDILwVfSTA6BJFy21KQ8O?=
 =?us-ascii?Q?hZ6LPlFPJZh+6SGOtENmcJd5aKD13W0OKwwmn2Y96EC+bhdYVTr9Un11faWk?=
 =?us-ascii?Q?8zOfgKYetD2OIQkYhd4WIx5iKwR1VxfwAVHWdobiyrPHC5AJfWpuPwIMsUAd?=
 =?us-ascii?Q?quuVx+WY5Dxl7DQyHhdfDqZtLi8IV1zhQslwWN49XszX/ZFZVtT1NZ8rLneK?=
 =?us-ascii?Q?Dsy2q2zZvYoTCj1SzPkx3fgkyQV/Eq/qpFthYv8/zkzPehQ566iSeuXw7Gj/?=
 =?us-ascii?Q?QqirTZM1zhDJG+/T8GDKWeGnK94lrH42VD9HlYpPHErQ+eZfa3y2nNb5Zyz+?=
 =?us-ascii?Q?wsWtQSgEHzqOBtdj/VEcLqdeNV50zh91a0cMSccLxpWhcL7w5ceQmtEI4doW?=
 =?us-ascii?Q?vDC75a31l/FY7e6AVDunfb+3FMtFcY+emRz5IP3nYcQpdpFdSicz59nhOUms?=
 =?us-ascii?Q?re9NlHvFi8eF+HKMnSLIQ4bQfih8XA0eRNKBEU1gMs6/TwNlPYJ64Je+BLkz?=
 =?us-ascii?Q?zijY/Tj3TDDpaL3OLyDlO5K1oE0d65ujyGcnSOM5uEiUWWu3I82Uj94bu2Dc?=
 =?us-ascii?Q?nEZLZj/WCzLThpJFz0Zq4Kj43GRID8Cr1VoGB3wWdu8a/vdPfJdNsr6PNr8j?=
 =?us-ascii?Q?ygGmgD6SnQNODvqGv9rRs+jxi6TMyxNCiRKXG91ZTj5lZ9lvdA6FwsLqvJJ6?=
 =?us-ascii?Q?T3pPeeNSQkkeRttyniO+rsDzME8raauMySgATF7rTTbVqkTqhveB2sSH25zJ?=
 =?us-ascii?Q?wZ9egpXrSO/Nv6Eek7MWgU5f7JPMnUk6FkU+oL7ebBvwMYh4M8qEn30PI1c+?=
 =?us-ascii?Q?j1pyzWN2g/Jv93EItA9ScnhvdAVpwZnXPaYjbjla5KudsmCohmwvwnOY6TSl?=
 =?us-ascii?Q?DQhHMrO3ZZq64h+w0oMPr5yIv5lvRtkdRXje0dChco6F1APJVqQfjiHiaMU7?=
 =?us-ascii?Q?LrDsbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:35:43.9236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19de914-55b2-4027-a922-08de571c9732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766
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

From: "Alex Deucher" <alexander.deucher@amd.com>

Resetting VCN resets the entire tile, including jpeg.
When we reset VCN, we also need to handle the jpeg queues.
Add a helper to handle recovering the jpeg queues when
VCN is reset.

v2: split the jpeg helper in two, in the top helper we can stop the sched workqueues and attempt to wait for any outstanding fences.
    Then in the bottom helper, we can force completion, re-init the rings, and restart the sched workqueues

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 69 +++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index ab0bf880d3d8..edecbfe66c79 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -844,10 +844,19 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
+
+	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
+	mutex_lock(&vinst->engine_reset_mutex);
+
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	mutex_unlock(&vinst->engine_reset_mutex);
+	return r;
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8bd457dea4cf..db2c8efb112c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1301,6 +1301,59 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v5_0_1_reset_jpeg_pre_helper(struct amdgpu_device *adev, int inst)
+{
+	struct amdgpu_ring *ring;
+	uint32_t wait_seq = 0;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		ring = &adev->jpeg.inst[inst].ring_dec[i];
+
+		drm_sched_wqueue_stop(&ring->sched);
+		wait_seq = atomic_read(&ring->fence_drv.last_seq);
+		if (wait_seq)
+			continue;
+
+		/* if Jobs are still pending after timeout,
+		 * We'll handle them in the bottom helper
+		 */
+		amdgpu_fence_wait_polling(ring, wait_seq, adev->video_timeout);
+       }
+
+	return 0;
+}
+
+static int vcn_v5_0_1_reset_jpeg_post_helper(struct amdgpu_device *adev, int inst)
+{
+	struct amdgpu_ring *ring;
+	int i, r = 0;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		ring = &adev->jpeg.inst[inst].ring_dec[i];
+		/* Force completion of any remaining jobs */
+		amdgpu_fence_driver_force_completion(ring);
+
+		if (ring->use_doorbell)
+			WREG32_SOC15_OFFSET(
+				VCN, GET_INST(VCN, inst),
+				regVCN_JPEG_DB_CTRL,
+				(ring->pipe ? (ring->pipe - 0x15) : 0),
+				ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+				VCN_JPEG_DB_CTRL__EN_MASK);
+
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+
+		drm_sched_wqueue_start(&ring->sched);
+
+		DRM_DEV_DEBUG(adev->dev, "JPEG ring %d (inst %d) restored and sched restarted\n",
+		      i, inst);
+	}
+	return 0;
+}
+
 static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1310,6 +1363,9 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 
+	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
+	mutex_lock(&vinst->engine_reset_mutex);
+	vcn_v5_0_1_reset_jpeg_pre_helper(adev, ring->me);
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
@@ -1317,13 +1373,22 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
-		return r;
+		goto unlock;
 	}
 
 	vcn_v5_0_1_hw_init_inst(adev, ring->me);
 	vcn_v5_0_1_start_dpg_mode(vinst, vinst->indirect_sram);
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	if (r)
+		goto unlock;
+
+	r = vcn_v5_0_1_reset_jpeg_post_helper(adev, ring->me);
+
+unlock:
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
-- 
2.49.0

