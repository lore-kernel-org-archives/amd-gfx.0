Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22346D4A5EB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 05:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F0C10E35C;
	Mon, 19 Jan 2026 05:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3mr8OOQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B355B10E35C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 05:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kirAZo8KVW1Ns7nj0xdX4SAmMXsp2L2uV/L0cf+zhl+nad2tAQYdsOTt+i/V9k1/K4KiCelWWzpsOFuSpzAUIJAXTKOO9OH+Xdsr+BZ+/+ehi0S8EInlgltZfm6GbunmHoJVSiJfVhvlL/joj3SL1OAyAHOY6R88e8gTya5MHjeBxMi08lemr4yDixT5IKwmFbOH67tuUtn9LPLpf+feoxoL7t3zPpM3EWWqSV4Gfutk8XjmeJpLtNNSRWCx/ZQ7ZSiBCg9NuYLBvpwYLpU62I4ssqInU4bvA0vPh0IoAHe3tYJSy906y4nr85dkuBuwfe3J1xtlfecZIo4iGzeWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsZKiMwXCUnBWk8JdAiIdJmaIh5UtGbDpFWcAuz/9lU=;
 b=dGikUKL04bObtaKz+6CViom7bl55NFOxqK85NjjBiglSR+cLIQIn+SaqeRrr1YdZsjbv6lxINEjK/x3woPdFr2ggcbEyb/XLOUPcfNmo3s6dHL8WL+FuXISnSAlyydElMGnAuH7Iua1mAXPGLPFoWNnmQD2hlRCiRPs2/8uxNK92IFGyJvZsIpVHcAXdNJidrZxhbVndt119viDtoTvRyvjb11F1LqV6o4PgaDaERAIQeNBk8LmsYaLjDzlT6SjfUMGa5EVlmwIfKFeUmiI+i++1LMVZChFHrWg7pk3wNtt8xd+olB63VFcDCyLGf5c6V5kwMguPeZRGDadeKy/s1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsZKiMwXCUnBWk8JdAiIdJmaIh5UtGbDpFWcAuz/9lU=;
 b=d3mr8OOQqfrjKSnxnevWnCZWPjkW2wQAYHJOGO9eeRt5H6y35c34yW07vGz+K9oY5sqwOOGod6va9SkAQhh4TKWFJrmAFjRnptvgN1+KIeSoeXoeWG29nqxvLKNVPxU03qYXJ5hIPqKHw2zXKfXPB4+CaAzmT8oNtnYZj02Cysk=
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 05:35:24 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::45) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.5 via Frontend Transport; Mon,
 19 Jan 2026 05:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 05:35:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 23:35:23 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 21:35:22 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 18 Jan 2026 23:35:16 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu/vcn4.0.3: rework reset handling
Date: Mon, 19 Jan 2026 13:34:02 +0800
Message-ID: <20260119053515.893663-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 65861303-6bb2-4d7c-09ec-08de571c8b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?38nNEsefopaFYTpka+zN5xCii+j88Cp2mnFmmlY5R7EAqDIFpLqSZhw328sT?=
 =?us-ascii?Q?I+HIPGWbXU0Bjdhdn/Za5eMd/mLJlKuMZXLGPvap4KShLKP0DvUaaN15TcMk?=
 =?us-ascii?Q?EvO+9MwKKI6mGVGl1f3zcqhP3+A3izvru843X6WkVecvxuch5Na301x8GCma?=
 =?us-ascii?Q?Gss97O4JnHy+/EN5eLWLVt8ZklSrPLu+8gjcDzN71WWgfJ5bGP2AJuiA8UXD?=
 =?us-ascii?Q?zAi7sIRVx08ccRX9FycYFZ2fQrodvo7cdghBOkE0f8ZM3ycpEDYV8Kd6Uf/i?=
 =?us-ascii?Q?+h56y640/v6NnrafjGlRM4l7fq3lynPOJ1m+7arei+uHT6+ct++muzrw4mpY?=
 =?us-ascii?Q?QK3WHRbrhmLp4zdRxG2pg9UQGupW3ahI8tI2u80Kt08WmXjnbDE19u/ISVEf?=
 =?us-ascii?Q?HVPcaXWVMirZjYKsiUvpHwdKthUStoN1KoqdUohmOWQJt636S6duZ9HtOs0j?=
 =?us-ascii?Q?PYrYfnfEVfwOvWPZ+LCm2CSzwInFTrGjLOh3aQ2/kpW1n3Tr285B1uDI0kWS?=
 =?us-ascii?Q?FfcMX5DlCiVlRxovmqd+OhJVMKHgeZAEF6ajaJFB+8Bi7aiujnJGtI6kCxcD?=
 =?us-ascii?Q?L+PaX8fJ8HwI1ecMfISkFK4S3JwEDbFT1fBJj7DSsgIvMim3+eBc4pv6jcvW?=
 =?us-ascii?Q?u6DjQRBYzBIa53DSEEA3YB6O0tLquZACZg/P8hgwXkc7V54jDWgHLNLsi5Wx?=
 =?us-ascii?Q?V2sCnvsGuYYxvZdK7NiE+ysTus6iGLfOZ9vzRn3+7g5ka7PWFTH9usTO7wqg?=
 =?us-ascii?Q?P+CDuGAdFcCtxMvMtPx7BVNjpn6griT8mOShMCKQ9Y/i4pKrES5L4TCuD56s?=
 =?us-ascii?Q?HyeX5xYYO57wFtdiTerO54uMpgfvV2hCx/mMMeysDvlERbq5971XzuJcG32O?=
 =?us-ascii?Q?SVvxiRKOBfbVVQ7TBI0+xSPtaw/epTLmL3EYJ66jnZTZ5UdwB/b3iu5c5Z9F?=
 =?us-ascii?Q?wX+S7JqpCHIoU0TqTheZglFIUqdmQW5gW7McwROdmPkf0f608YdL6mdBywBH?=
 =?us-ascii?Q?3lGcrdf189ur/gbiMjVfAu0EphANjUavlNq63j4YQ/dCWcabNI0ubr86P05J?=
 =?us-ascii?Q?cPN3I8+7O8551AaFEuA+cEuslPArfIfkWK0dKgTk7pX7e8rydek/SmEDJcg/?=
 =?us-ascii?Q?sgcFDM9s2+h/htRi+XGiHbyBenHsjvBMBnel9aUwbHYbE2TmxnoFDfyJcG2R?=
 =?us-ascii?Q?PBkRJ0/putNHky2uklhXPCYUdxYk0QXbva2qSlRMF/vFeFPhiQjDxtSk9UDl?=
 =?us-ascii?Q?Ok5bon7kDeDjPA/10agZ7R+0ZrVExHQZTRDrbgY70aTC37a9omFoey54GR2V?=
 =?us-ascii?Q?dzjoO+pFw1y8vxF8/C1EdTT9BS9MrvfGABUyZPRZYmxsgMkAJOHgEK4bS74s?=
 =?us-ascii?Q?o2UUo9Hh4fiR1NbJnGixEadMsKkSaG7rbdP64I5ruTyJZOB2ZIefeLRtEXqF?=
 =?us-ascii?Q?tJWZBx+pAvS3yPlX231MNadaWu+sYuxnvfFXA5I5LyUGyFQUUXnNHNR/V94M?=
 =?us-ascii?Q?bsre/gSzV26AYfnI4ljagR/MHIUW9Vt1WF5Z1oMmhujhFNbVSoLQtRg7IJlq?=
 =?us-ascii?Q?69LdnDUnZ2KEHAQHYNo2hgHfsNypgxSfu5oGZ8uNS1KXfQ+dUcTyt1K/6UFT?=
 =?us-ascii?Q?ZLJ2YyK6v/LQMtP+BB4jtMTDckS20C7jYpZ9GMuocKGzZky7TP55rWhKMSfb?=
 =?us-ascii?Q?QLJt3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:35:23.7152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65861303-6bb2-4d7c-09ec-08de571c8b27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 70 +++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index aae7328973d1..1a32dadf8c5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1145,13 +1145,20 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
+
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
-
+	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
+	mutex_lock(&vinst->engine_reset_mutex);
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	mutex_unlock(&vinst->engine_reset_mutex);
+	return r;
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index cb7123ec1a5d..c7f94976ce6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1596,6 +1596,60 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v4_0_3_reset_jpeg_pre_helper(struct amdgpu_device *adev, int inst)
+{
+	struct amdgpu_ring *ring;
+	uint32_t wait_seq = 0;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		ring = &adev->jpeg.inst[inst].ring_dec[i];
+
+		drm_sched_wqueue_stop(&ring->sched);
+		/* Get the last emitted fence sequence */
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
+static int vcn_v4_0_3_reset_jpeg_post_helper(struct amdgpu_device *adev, int inst)
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
 static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1605,6 +1659,9 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 
+	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
+	mutex_lock(&vinst->engine_reset_mutex);
+	vcn_v4_0_3_reset_jpeg_pre_helper(adev, ring->me);
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
@@ -1612,7 +1669,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
-		return r;
+		goto unlock;
 	}
 
 	/* This flag is not set for VF, assumed to be disabled always */
@@ -1621,7 +1678,16 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	if (r)
+		goto unlock;
+
+	r = vcn_v4_0_3_reset_jpeg_post_helper(adev, ring->me);
+
+unlock:
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.49.0

