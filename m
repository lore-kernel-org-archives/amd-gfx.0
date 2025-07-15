Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342BBC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 16:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D453B10E38F;
	Tue, 15 Jul 2025 16:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5EOk/uVz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B2F10E38F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 16:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apd3VUUfCYfq1A9uETK7ZuOIfXIKlp1Q+oZLDmqqyVguEslcaRcoNZMT7VagBxE1DUVvuxorOTH1V6K2BO5RrYR5Yd/PSKauwZMlGqwGZFw3GVaddC8QI2N8SeG2zN9Shm1kovoEmG43br80k7vPPK/5gKwT+1ooqrotN5zBdgIrZMO+uSEttFfWed0JcUfp+1r/y1Uq6+u04je98MPWm2OzCd+CRUxX9Ceos++Zh8+Nk1M4ZCn7lWHCXEzL4K8OH3e7f5VTDXfmfrzlTNYMWqGsEtvI2tiSJ2MTHhpXcG04mnPKvTyP6r/oUGeUzbGwdas2mtGyacAgBGdxXDkPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEleai5OkuzWhepsxLsiC4vA/pSpkEyv42fuU/irRAI=;
 b=DGNr+ViyOpjzvxGKQmOQgfv9smaFXhAVrYvm7Vx7+Ur1GOI2TNA1Kc/pRXhRcjviCK53ElJUO6xdJi19YQhDC9yGEXnXrt/pQSKNkws+4JGxv7UtqlEoL2Ho2VXdP0Iv7oMdsvHooacs0UYzMwQ7Px3bp7japm1F0qx0DzFNdOKdgJLmYZW11aMGOfP/7GsyRaPvkurORLhF4ABRYd/DX5PRxeAzQSYeaZgd27uX6430dpKaSkH4wdI1cMtYaepzBfTGHguEwWnmPahg1TvewyFjrqBcbXlG2XFlv3luV0iybrzwFeDzufEUxWuapkEljHv3/xHW6BYoRE2S4oqT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEleai5OkuzWhepsxLsiC4vA/pSpkEyv42fuU/irRAI=;
 b=5EOk/uVzec8v3qO9H5prYWYIlSRjXvkd+4AJUdUV/ibn3KJzZu0XrCI2ECnmm8H9AOLV8uzaNpC5v/SU8O/lwqRZfvImbHXKsJBpAa+sSk2Ju8CwQ+D6HfXLuMs2CWSY1jf3uJz/079UeNkPR4rwA5X4vq2YyQ8SK9NaAEIbjok=
Received: from MW4PR04CA0386.namprd04.prod.outlook.com (2603:10b6:303:81::31)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 15 Jul
 2025 16:01:10 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::8d) by MW4PR04CA0386.outlook.office365.com
 (2603:10b6:303:81::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 16:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 16:01:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 11:01:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: move reset support type checks into the caller
Date: Tue, 15 Jul 2025 12:00:51 -0400
Message-ID: <20250715160051.533747-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715160051.533747-1-alexander.deucher@amd.com>
References: <20250715160051.533747-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 230bc62d-54ae-4d2e-de35-08ddc3b8d082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?giVSZKgLpyRitj/L16zZRu8ibo26dbVo1w8rF+zhsh9IWoSaWjxhJdKNJmFS?=
 =?us-ascii?Q?bSHCQJHmBfXqVi1PykIuDDvyH0bgrNBJZlmiyKWAnJU84WlSbDm+jD0IjYc+?=
 =?us-ascii?Q?zy+ZO3zK2iiLdi48HMuBAGQ95NYmlYpU9q0IO0UwsWoI5fHaQTNlt197zCWU?=
 =?us-ascii?Q?fHVlQMc1gfS3Nf3B+yk0oTkEt9Lhq2DfORPhu1WGcRwzGe0MBZk0S/kAi2N/?=
 =?us-ascii?Q?ooCo1S8GDoCD9OzaQB4qhnY+jnK+stLgB8SRA7T6kTqSpcrKsSjOVmh3LLMa?=
 =?us-ascii?Q?AaGP+ZcY5xk5obdjYH4ElVavkbgVK5oDReirccK59UXrUV8BsfOrAdEAsyif?=
 =?us-ascii?Q?giCy9W2pBm93GrW9f1BuqDyY+ICsIwLrWh7U8+oev/76CCpZeVTgwFOlaHhd?=
 =?us-ascii?Q?pBxiQrDGJqdrmHuNI4bA84W5cTbZWb50F4YMI3wsxGR4FQ00fzu4JSjyElyI?=
 =?us-ascii?Q?OCsgeqy40GQ7GdDDg4itrGaEyBmB7dYsQymQkUEc1G4Bfwr8473nzyn1/Jkm?=
 =?us-ascii?Q?shUAVgiBlqzJIQPP8OknRUdPzZT3I9khqXhGBmCunYmpCpwA5JBMHL/o4oI0?=
 =?us-ascii?Q?nSbLWYiFbR9DgZVMkSsibbcTyZy/JA8kFSnpHWgyJQ/hl4wmzY3tdwk25Dc2?=
 =?us-ascii?Q?vJPzImjVBGPjaseboIACsFftO1nkLQG3yUdtI4VIzV2ZqK9BMPWbGpH20i/l?=
 =?us-ascii?Q?eBJhdpzQ5tXjbE83W2vyqk8Z3bXw4hMh8DcWeACe9p17nThBq761mj9WzY7F?=
 =?us-ascii?Q?GFBH+M6KZDwRGPArc82C6ED8mFufvW96VcQ+R/3+uOaiGdRQMotNPhry5mUg?=
 =?us-ascii?Q?YOvUJI4TZgwb8Pa+k9I+kNiylg0X/1a15BU2gazK4zFTyq3k/zitWJqWGiGT?=
 =?us-ascii?Q?XPaho2zpSNV87lN1lywEPPKjwTbYg9FgE/48S07T3dLDBseaVvUeTbPlLwS2?=
 =?us-ascii?Q?AYSUoR+usggMUUafMX2r5re5c26NdoVG4pjyKi6qdcGKXPeOGwCfRevMLTE9?=
 =?us-ascii?Q?rZUmkgFNjfWGts/GfppAAYBFe7ANBBqNfOgROYdevD/zwJWFjdBEhQlOm8MD?=
 =?us-ascii?Q?FokDI8xNLFeX1Aq8XDmDvmIwUVp5wO1DT8SRYm9e7234wsINTMKkJx76/14W?=
 =?us-ascii?Q?1r1AKPoToFdXrsbiasgEA6CufxTIC8tj4O6yJ18h0QDBQp7sRs7SO6qldS2K?=
 =?us-ascii?Q?CB/A0i/iRfmkASs5IKGwf2XDtwBYb/hJOdpDICrhOGQP/mT336H93l5kUobo?=
 =?us-ascii?Q?wPOfrAj9b0cjfDSbFOleQZseocyl2ynfBDfcuFLTqoyaaJuZ6knW2AHAvy7r?=
 =?us-ascii?Q?Yd+M16Z5LeWbRSQ1b57aCfJo/64eR4KHg/y2HB0xfJvN9LedxOCWe1rfEDjZ?=
 =?us-ascii?Q?MAXqQ/NWyB6ifMDBGTqO+Bk087K1Sydf8llFFgR4JSkMSAV1VNkNoTox6q5t?=
 =?us-ascii?Q?zqZCfTwidXuViUOz7JJIFsWL9uYa3/6/pvhxaqOHiSfi82d1tC2C2q62KKFO?=
 =?us-ascii?Q?Je74tIjrMvx8FoJLxoIv+6zn5Z1daW4jHnhc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:01:09.4700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230bc62d-54ae-4d2e-de35-08ddc3b8d082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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

Rather than checking in the callbacks, check if the reset
type is supported in the caller.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 31 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  6 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  6 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  6 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  6 -----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ---
 25 files changed, 37 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 45febdc2f3493..8635f66921335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -111,6 +111,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		amdgpu_job_core_dump(adev, job);
 
 	if (amdgpu_gpu_recovery &&
+	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RESET) &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
 			s_job->sched->name);
@@ -132,7 +133,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	/* attempt a per ring reset */
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
-	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
+	} else if (amdgpu_gpu_recovery &&
+		   amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
+		   ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 09d7681b7a754..4f69aa60478a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -820,3 +820,34 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
+
+bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
+					 u32 reset_type)
+{
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_GFX:
+		if (ring->adev->gfx.gfx_supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		if (ring->adev->gfx.compute_supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		if (ring->adev->sdma.supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_VCN_DEC:
+	case AMDGPU_RING_TYPE_VCN_ENC:
+		if (ring->adev->vcn.supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_VCN_JPEG:
+		if (ring->adev->jpeg.supported_reset & reset_type)
+			return true;
+		break;
+	default:
+		break;
+	}
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 309e7bb6001bd..7670f5d82b9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -568,4 +568,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence);
+bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
+					 u32 reset_type);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d799bc74936c0..f1f67521c29ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1522,9 +1522,6 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 744f51a6f522d..7bd506f06eb15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9523,9 +9523,6 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	u64 addr;
 	int r;
 
-	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
@@ -9591,9 +9588,6 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
-	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 465fcd6503735..c01c241a1b063 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6808,9 +6808,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
@@ -6974,9 +6971,6 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
 
-	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 5d32ae4b1a4c9..09bf72237d1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5303,9 +5303,6 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
@@ -5421,9 +5418,6 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9c0cdf4dde714..20b30f4b3c7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7183,9 +7183,6 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
-	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d80f1fb261d1e..e2a726669f7e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3563,9 +3563,6 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int r;
 
-	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index b93d6af8f6e54..58239c405fda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -773,9 +773,6 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v2_0_stop(ring->adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index b6d5ba0bdc143..3e2c389242dbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -650,9 +650,6 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a229d7eb900c9..a44eb2667664b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -564,9 +564,6 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v3_0_stop(ring->adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f3a9073b8b243..da3ee69f1a3ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -729,9 +729,6 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v4_0_stop(ring->adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 1892c278ea3c4..481d1a2dbe5aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -774,9 +774,6 @@ static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v4_0_5_stop(ring->adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 0b4de0c6476ae..e0a71909252be 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -650,9 +650,6 @@ static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v5_0_0_stop(ring->adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index e622db1f818bf..54523dc1f7026 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -836,9 +836,6 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	if (amdgpu_sriov_vf(ring->adev))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c0c418aa2c299..0fe0f371f6fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1664,9 +1664,6 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 	u32 id = ring->me;
 	int r;
 
-	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_amdkfd_suspend(adev, true);
 	r = amdgpu_sdma_reset_engine(adev, id, false);
 	amdgpu_amdkfd_resume(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d8c19601dd2e6..7dc67a22a7a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1547,9 +1547,6 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (ring->me >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 5d56029e88a62..3bd44c24f692d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1461,9 +1461,6 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (ring->me >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5d31f318cb3c7..e6d8eddda2bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1578,9 +1578,6 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (ring->me >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 13abc0c46eab0..b8b06d4c5882c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -809,9 +809,6 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	if (ring->me >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index f642a06a77b56..1924e075b66f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1976,9 +1976,6 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r;
 
-	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_stop(vinst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3bda19b92cde7..2a3663b551af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1603,12 +1603,6 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 
-	if (amdgpu_sriov_vf(ring->adev))
-		return -EOPNOTSUPP;
-
-	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 039989ab452ad..caf2d95a85d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1474,9 +1474,6 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r;
 
-	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_5_stop(vinst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index ec0268b5666cc..07a6e95828808 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1201,9 +1201,6 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r;
 
-	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v5_0_0_stop(vinst);
 	if (r)
-- 
2.50.1

