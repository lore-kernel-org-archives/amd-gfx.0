Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC4D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F4A10E660;
	Wed, 14 Jan 2026 16:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EqsE5wkE";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F3B10E660
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjPq47gq8HPQl0lAF7HMMljHaBCXvM5+SxsU1AvhtpPSRKKH411dHykwSjFRloGhQTrOVFeTNqehFJhT2xu0aw3uODuAiL4hwmxMgn+5/FeupY/BO+09zCzxyPSK8IALAroU8/RPQV0XigCx/yMM6+oD1xgc30UrNaVrQ53IP5LPCmxuVupkXggk8NUhYQf2kY6bkD+uwKG7xDBXpp7fgVYb8Pzdr5S4N+fz0OnDVJX9ZXgbdc88s59FbjIa4m91EgymTyQV2YwNdLXDzuA12Mrhas8jYmrTOsUmrHZFkdF71RGJ2AuvlNxYpbolznehahu5a0GGdF3gKut+FazZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKQrEwNSKoPbHsM/Q68UnEhc6ry3HRza4pLl0vuHhB8=;
 b=FYOWm/I5AJgkt9e5+4KOqYy8mOhnX3Czvf5QngMcuzFXMkD0kTdT31Bga74rQUtKYVCaw51faReav+aERvzBOHgxGFbo2YMDKVWoBmS8W3XgmcMjue6A9I485PSomHIrYPAWeKPvoMdfTVX7r17qnORnTMsVV3Nnt21VLTHwuh/f1cMb9xXjg1+TSTmkizzckZj5leph4ux0NJikQvw04cHMjauvB0ts3IpSfAodwzMWYo56a6VBakz7C2mlXoRm6JuHu0kXTGRbjsoOIaXUdB6JyVleEVgaDQty+9o3g7hWGlrGFv9QbTlQZE+DYouOi9SL5s3Nrl3npBdi+lMrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKQrEwNSKoPbHsM/Q68UnEhc6ry3HRza4pLl0vuHhB8=;
 b=EqsE5wkErGTrhg8QRxYzQkHFRmFKoLSGwkTZxpOuFP9nqF27RW2H3E0gRnss0AluvC7b9ZfOL2cSvey8nNkLiT1GzbCL7bMJ4xtCLzYttT8FingxYsDY2JbrZedAfZX0d2PsAA5PYmxs9eKyINAut47FKQZOLXjIX+IjnlOM86U=
Received: from DM6PR01CA0005.prod.exchangelabs.com (2603:10b6:5:296::10) by
 SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:48:26 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::3) by DM6PR01CA0005.outlook.office365.com
 (2603:10b6:5:296::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 16:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/42] drm/amdgpu: simplify per queue reset code
Date: Wed, 14 Jan 2026 11:47:27 -0500
Message-ID: <20260114164727.15367-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9a47bc-83d2-4153-1693-08de538cbd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiEy9ohpK/jXe27uHDTfR5WiXfiH4xC994dapDU9WwS7YdrN7UDqpXeEWeUe?=
 =?us-ascii?Q?Sp07hrcmBsYtLGjwwklKi6qJ/C4Yo1uXSXgVV7+ErEz2iVCu6MO86rRnb1l0?=
 =?us-ascii?Q?+S2+33t69xJcSilVjApCXEhU2OVY7Fh1lm+n3W0QsKSE0UoPh4JD7iU0YI2R?=
 =?us-ascii?Q?yQIn0EJACoxvz2TVeAc8m7VAag/Q6nHzmTelcmaB05WiWZOOIphD0GGEkz3i?=
 =?us-ascii?Q?jw+RVZHiTqIjzhgM7gYvZsDzI2XfSgrXD7SIhO5KscHYy88OVESMM2doKSg2?=
 =?us-ascii?Q?Q1GIp5A+0k+jZi3i/Pj6rNoJIPvuLUqEPpth/vu5aV+/Swm8DXlFJHQj4Jq8?=
 =?us-ascii?Q?px1/BAMjAyGRQwK7VzChDaepHJUOGTWiT7+PxQ+uOalym+z1bg8i/9izXmJm?=
 =?us-ascii?Q?T+spBT7fDNSuufjUY6BmMt6fTtnI1gEcRzrtOMYA4p8zq48MqhxKyobd4H0V?=
 =?us-ascii?Q?6fAzQIoJidKK8dEXObHC+dI7Cyo+JoL4n2x/Sfq/m9nhpA3fLZJw+FrJkYWc?=
 =?us-ascii?Q?QJ5HJG5Oq8at2gQE3ppNE7KuSgj0MHhCNJ0qOf5wre0o+snki+82UujGMaA2?=
 =?us-ascii?Q?PyU1xLXv6rw0y20I6OIBfsZq2BLgskFZuJfUBVKK95Ygs/4kFmfZGBW6p4o+?=
 =?us-ascii?Q?bouTGojaIREEu5khLSEjGAU91S7G+V1okSwcKbvn/eXfeDAPUiFO3/uOGxpj?=
 =?us-ascii?Q?sXe29ZfjqsuN8mrYfRxDJ0doo3rTzhP5yib7r3vT9XOyFkybIfuH5czYF7os?=
 =?us-ascii?Q?++YbkInnqjZyBG1sdXgo0LMupk2NJiwsrrZrt1k9Bqce/umVmlG0gFKfMoAp?=
 =?us-ascii?Q?Q9RzNm7m6Cp5k1Z8SDxu7USdobV1VHT9yi65O6oyy46qbNic8VikH59aGZ4c?=
 =?us-ascii?Q?SbW4/cInaVDcJntM/dQQ3sNJa9ZQXEU+BF3gVTiKu7Dg7Z+MLzBplixHHVRc?=
 =?us-ascii?Q?ojx67p1Mi3HI37e0HLo77LyvcLgymJ030rh711gDniu3HgMY/t6X7GK72eIV?=
 =?us-ascii?Q?xFxwVeQslwzIFUK735a9Kz3tiowE8tC9n9RYEco9QDQaYzO2DWSf3j+mMKEC?=
 =?us-ascii?Q?ErHZBdm48D1u3yCzKM/SFdNXysLgrL4wI+MqiJr+zRMoZnejKBnCP7HtifiF?=
 =?us-ascii?Q?n8R0KKifypk7sVMIp+CzwGggDFoHq8bTL4xnpae9vc0M9/a3XGACzLgFM2aN?=
 =?us-ascii?Q?7AWoBDL/ECvCWutBaPL8eE+huvHqc0qCytCNMEUTRhP1cSPXUNI/0EZtFiew?=
 =?us-ascii?Q?7WeAgQ4fyLw36h9k0lYOTw12JWSRhQ5BynGImLzNfM+LNjokav+UwYwh0Uim?=
 =?us-ascii?Q?2FFZaSUUwcq7QFUlf3kM87w/ssjnS/8k6XlObsvAnBSiE33LyO8cSpcpCPDp?=
 =?us-ascii?Q?9jljtnyeFaBHBKT3FogZq1yDR/L8pWtsu5lHv0zOjqUMrFT/mwkuluZrML6N?=
 =?us-ascii?Q?XCDG4JTFPTOrzwwv3yOpdZqZ/XvJI89G69bYI27ITuSZLC/UyLr0TXP6SjPF?=
 =?us-ascii?Q?aExabzUWWUQRCMcduVm5qVJfFbzQpkPU/K2UAXlX3pc/koL16/ncjD6YxMBV?=
 =?us-ascii?Q?Q5EJYw2rdUQRl5k/hSp1TAj1WQMxK8GvKKh3PpRAvbuQhS+6HdcoYhB8QvcS?=
 =?us-ascii?Q?RKwJ30qh0MokAnTJrhLzNPda9qyP6x2wQQZOEkVoCKfSllAfpdGrPAXSDima?=
 =?us-ascii?Q?Y1ap6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:26.6094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9a47bc-83d2-4153-1693-08de538cbd24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

Drop the helpers and move all of the logic into the
common code.  The reset callbacks just reset the
ring.  All of the other logic (reemit, fence error
handling, etc.) is handled in the common code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  8 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  8 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  8 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  8 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  5 +----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  4 +---
 28 files changed, 31 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 887bfd40b9bfa..69161a6c3ce91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -168,6 +168,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (!ring->all_instance_rings_reset)
+			amdgpu_fence_driver_update_timedout_fence_state(job->hw_fence);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r)
 			r = amdgpu_job_reemit_jobs(s_job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 3a031649f6c97..be14afc88b3c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -833,21 +833,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 	return true;
 }
 
-void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
-				    struct amdgpu_fence *guilty_fence)
-{
-	/* set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
-}
-
-int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
-				 struct amdgpu_fence *guilty_fence)
-{
-	/* verify that the ring is functional */
-	return amdgpu_ring_test_ring(ring);
-}
-
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e935159a61a3f..314f06cf3dbb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -573,10 +573,6 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
-void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
-				    struct amdgpu_fence *guilty_fence);
-int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
-				 struct amdgpu_fence *guilty_fence);
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type);
 void amdgpu_ring_save_state(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 54ee78c034cdb..e1bcf8a5a36d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -911,8 +911,6 @@ static int vpe_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
 						   AMD_PG_STATE_GATE);
 	if (r)
@@ -922,7 +920,7 @@ static int vpe_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e0e125eef9ac5..73f709fe293d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9517,8 +9517,6 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7)) {
@@ -9566,7 +9564,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9582,8 +9580,6 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -9636,7 +9632,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index cc9ac87c5be02..8019cac16a181 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6833,8 +6833,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false, 0);
 	if (r) {
 
@@ -6856,7 +6854,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -6996,8 +6994,6 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
@@ -7017,7 +7013,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cbe175145286b..0afca15c5cd15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5308,8 +5308,6 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false, 0);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
@@ -5330,7 +5328,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5423,8 +5421,6 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
@@ -5444,7 +5440,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 07fe959abe0d7..f5d8e7cb78f04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7211,8 +7211,6 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
 	u32 tmp;
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, 5)) {
@@ -7261,7 +7259,7 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
@@ -7277,8 +7275,6 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -7334,7 +7330,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fb731e877c99c..f26569ca03d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3560,8 +3560,6 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -3624,8 +3622,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 			goto pipe_reset;
 	}
 
-
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 9fe8d10ab2705..9f3e042e13745 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -772,14 +772,13 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v2_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v2_0_start(ring->adev);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 20983f126b490..0db65c58b67a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -650,10 +650,9 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 98f5e0622bc58..f8e09bbf7ff1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -564,14 +564,13 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v3_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v3_0_start(ring->adev);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0bd83820dd20c..c7b0b1773d3e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -729,14 +729,13 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v4_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v4_0_start(ring->adev);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 50ed7fb0e941c..daddfbf6e2d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1145,10 +1145,9 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 54fd9c800c40a..96b8cbba382b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -774,14 +774,13 @@ static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v4_0_5_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v4_0_5_start(ring->adev);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 46bf15dce2bd0..43cff4db2c153 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -650,14 +650,13 @@ static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v5_0_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v5_0_0_start(ring->adev);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index ab0bf880d3d8a..146ec7b1d0ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -844,10 +844,9 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 1821dced936fb..56c4a37520925 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -633,14 +633,13 @@ static int jpeg_v5_3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v5_3_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v5_3_0_start(ring->adev);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index c5dc727c7b448..c983cadbdb808 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1557,15 +1557,13 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	amdgpu_amdkfd_suspend(adev, true);
 	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 3076734462d25..cc9ecfa8673bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1473,15 +1473,13 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	amdgpu_amdkfd_suspend(adev, true);
 	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index fbac29485d0c8..69aa10265891e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1602,8 +1602,6 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true, 0);
 	if (r)
 		return r;
@@ -1612,7 +1610,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index bb9fae2c8dee0..1425c0c2ca9a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -814,8 +814,6 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true, 0);
 	if (r)
 		return r;
@@ -824,7 +822,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 5efdb4dcbed97..95768ff7f9985 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -805,8 +805,6 @@ static int sdma_v7_1_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true, 0);
 	if (r)
 		return r;
@@ -815,7 +813,7 @@ static int sdma_v7_1_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d17219be50f39..151da0e405a80 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1964,14 +1964,13 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v4_0_start(vinst);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index cb7123ec1a5d1..68cfa648a82c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1605,8 +1605,6 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
 
@@ -1621,7 +1619,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1f6a22983c0dd..c9c32ef1f1317 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1469,14 +1469,13 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_5_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v4_0_5_start(vinst);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 0202df5db1e12..34459b4b9b987 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1189,14 +1189,13 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r;
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v5_0_0_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v5_0_0_start(vinst);
 	if (r)
 		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8bd457dea4cff..06b4399ef295a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1310,8 +1310,6 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
 
@@ -1323,7 +1321,7 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	vcn_v5_0_1_hw_init_inst(adev, ring->me);
 	vcn_v5_0_1_start_dpg_mode(vinst, vinst->indirect_sram);
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_ring_test_ring(ring);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
-- 
2.52.0

