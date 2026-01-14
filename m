Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2828D31A29
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 09:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5090710E3A1;
	Wed, 14 Jan 2026 09:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0N9bjLIj";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DE310E3A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 09:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eci02CINp6/QqKjNnITb+ZF3FTWb926hJ51x10su5hDXLeLSmIWzubgvslt1BKbapHCYqF0sAbYcVHRvRvCDtKAnNCHLQ/QPI1x2ZzHdMcYsPR6ga3ghFWYbmYQpB+acY35hjrCr7hOLflEPe0Az6U94mq+1Ow5amDsfGc07DJXGPzAdVN7YszqD5boN/Wn5U3OLFSjZTgbwZ2Fzd+znds72syBsZnS08A6Om/HzQ98ec4wvPsHhW7T6YPXhJgHn0WWFapVG9jpisd14eZYdmTP1JIvleYc2Bs9pLe95RytTe82EHClf+Gfmbkm8WJWOCecXStVVW7cgtQy4+7nIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg4gbWCmWmoP5ceAMVuJHZyaFSfNCSoU5FiHRtJG3ZM=;
 b=mBFur+EONj3O/qwsEmsFlpRUE91POvnukWmnkRcXquBYK+IBCETBwWdaRFEBdvWAMclqeXA0ad+C52C3/DBM8Pvrt5hBPyms2s4pXStslB71r1lgPuctjvdlm1CpXFFu1OEGFm48Kjcx8yBYbnQnL2l64bNh+cgd8q8Ldf6fbASHwWbr4dXKupWvTjtWVriZQHorELKt6ZkQEmyaRWGpiq6QBGiS9wzSLgtmvVy1ZVOFbrY3voQsoYSk66H/DcPTTXSfir+4ObI9u597oOEqYH1hU3eqAKsuQgIQKVLNvstHsi7tpmAxfHv5jdtEUKznQok2ufDd2u5eYVT7qc2XVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg4gbWCmWmoP5ceAMVuJHZyaFSfNCSoU5FiHRtJG3ZM=;
 b=0N9bjLIjSZS0tiqwINQzWUdCcr4H98YjkYjhgsRGt7fQ7mZHhb5Xvb5bMawKoIWQkt0mtMMS0cg6lYzZeRirO+0A9u0LQ1kJqJDaV8B+h3gOX3DvNGu6BxzcnPBMHkAlA+0igHkEQsxDgOOYwO5esq314z43gG81gjvIYpU+UR0=
Received: from CH2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:610:50::12)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:01:27 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::3e) by CH2PR16CA0002.outlook.office365.com
 (2603:10b6:610:50::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:01:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 03:01:26 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 03:01:03 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 14 Jan 2026 03:00:57 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/vcn4.0.3: rework reset handling
Date: Wed, 14 Jan 2026 16:59:19 +0800
Message-ID: <20260114090056.356633-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: c548ccaf-2355-4567-90f4-08de534b8094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pl9UpzuYKLDcoCJINXgzS0OAlQdc5taq9h0rVaAELwo9qFJHYuzB+oSlmHEs?=
 =?us-ascii?Q?atC4+uhd2mYG25qAYBi5RbuRytk6o00yVD32lhF83McO1a4Ph8xOl98sXIpe?=
 =?us-ascii?Q?BeG8XjJznxb0ghhGNP8lT4q/XDSUFuKPhCBZWskhPh24QysQEW4iN3MdEGKq?=
 =?us-ascii?Q?Mo+0Wbwo0xdq6L48G7YilkzRfQK3BoJvNKGmugf2tQBRvzzTlQjjtZyD+hvH?=
 =?us-ascii?Q?+CytUmUks4SGE5Yqt2kEBdA8pthFujzUDRX+dn1vuNZ62iPHnL4zUH8iMPGw?=
 =?us-ascii?Q?8KAXLOwp4KNTVABWFvJlbvgvKlfyGIvlSexB23MO6eHKmVAf1fM6jVsZAJwA?=
 =?us-ascii?Q?02QJO4U9xHmirrNdh4EMz0fkfluxN2qooPkf7kCr/q3t0uKfcS/XEEpx5/Oy?=
 =?us-ascii?Q?VLFrLYsOWqixedFNs43F7/qsg3lBGVognywB1t6k5hjMWzYkIDuxC992Ovg+?=
 =?us-ascii?Q?fQU4WgWbSlAZEqYxj2+EtkYg8j7xxvKKb10EfCiPzjfOKbDYM8cVPcGx75sn?=
 =?us-ascii?Q?rSjBzB/5wh1BL2T9kIVyUDxV9Yq3iCtrRvRY3VMTaUXuemxExfrtagEiYZih?=
 =?us-ascii?Q?ECe3Ltc5z7+wUUfg/AkNmiLmjkLaaICepIKuDBFzK6+zFHgaJzZlWBDVNrMz?=
 =?us-ascii?Q?SC0M0yW7512WArPL+LfyD7vrjnJUhGSeXAyy10WVQfInMT3ihh5vCQUEy2sy?=
 =?us-ascii?Q?9bDN6SuN/3c8BM8ETu5dZQCjPV8bhV+vRcU/S1iWSxiiklBxs5XemE/RXMAm?=
 =?us-ascii?Q?bDE8kPqTTS83V2RKA+INMI7SW7ALG3YHd7VFE0j0rP6V4z+4Y2RzB1a/q8g6?=
 =?us-ascii?Q?+HHh1HqYuqrcQ+Ecdk8h29fPAeeGnC27ezfJfapJH2la8xy8tw9cO+w5BW3+?=
 =?us-ascii?Q?2ROn2W+oyizzhgSzdt0OXJDgg7wpMRN4amvG2tOrW2oYH1sz4EmhQIYWP3ZA?=
 =?us-ascii?Q?fgS492RpAAq68IMuX4cOyKWtMvrujVRVp/6ahjMaywAN5GmPT9SBstZh1jkk?=
 =?us-ascii?Q?VYxxnayBBtVV4KD8vhRDfrutZf3sDE2musCEhmEvL/B6SSKS0nJ7JPvzue0M?=
 =?us-ascii?Q?XZUU3NGIlKZ2T77UPn0CNRO9vk+U2DZqgI7X+oj5jnAl/X0L2xyTmZbOmC8B?=
 =?us-ascii?Q?AsqrwgUKYPz6v6TNNdy1g4MCCfY4jF1X+qvAy4aMZ03aOLwmhaOzmgRW62le?=
 =?us-ascii?Q?oV7X5uIF42kyinGv8ZRPKZgBHCukNb1OAAFntlPQxmawEKADk9990GljhCpH?=
 =?us-ascii?Q?zFm0V68VJbZaEvlaSofJhEJKU3R9LcuyBs4EZ0K4Jy7OzSE72Fi4cbOuAFhh?=
 =?us-ascii?Q?1S5FIpAnnSdAeYIxk/LOKkefhyusjUaOmYYOznKc9CydEp1/mC/JjJZjTt5J?=
 =?us-ascii?Q?ZkkiSbWwowRbmu64uX82+6VcEvQElAzID81WJ4kkRpeyCdZhYc5BpoePW14c?=
 =?us-ascii?Q?9FtOYXV0RkMivOUjq8zxXDJCVyaJjCm2h+Mtpc2qayxRs3xWQCrGVvpTP5k1?=
 =?us-ascii?Q?RXB/nKldtgD5WcmN9RcvEGUBgS+99c9QbZ4xnH8zrfQJDBIITu4veIyK6u/2?=
 =?us-ascii?Q?GPecioWJ2Nv9TOP6WHk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:01:27.6427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c548ccaf-2355-4567-90f4-08de534b8094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 +++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 42 ++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

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
index cb7123ec1a5d..31d93c10dfb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1596,6 +1596,32 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v4_0_3_reset_jpeg_helper(struct amdgpu_device *adev,
+					int inst)
+{
+	struct amdgpu_ring *ring;
+	int i, r;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		ring = &adev->jpeg.inst[inst].ring_dec[i];
+		drm_sched_wqueue_stop(&ring->sched);
+		amdgpu_fence_driver_force_completion(ring);
+		if (ring->use_doorbell)
+			WREG32_SOC15_OFFSET(
+				VCN, GET_INST(VCN, inst),
+				regVCN_JPEG_DB_CTRL,
+				(ring->pipe ? (ring->pipe - 0x15) : 0),
+				ring->doorbell_index
+				<< VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+				VCN_JPEG_DB_CTRL__EN_MASK);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+		drm_sched_wqueue_start(&ring->sched);
+	}
+	return 0;
+}
+
 static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1605,6 +1631,9 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 
+	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
+	mutex_lock(&vinst->engine_reset_mutex);
+
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
@@ -1612,7 +1641,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
-		return r;
+		goto unlock;
 	}
 
 	/* This flag is not set for VF, assumed to be disabled always */
@@ -1621,7 +1650,16 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	if (r)
+		goto unlock;
+
+	r = vcn_v4_0_3_reset_jpeg_helper(adev, ring->me);
+
+unlock:
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.49.0

