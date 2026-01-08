Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2F8D1D46B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37CA10E780;
	Thu,  8 Jan 2026 14:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELePFp2w";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012059.outbound.protection.outlook.com
 [40.93.195.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3759810E780
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTZoKY7kRrvOjl97TCWcJspt0g11Q8wuiN58rVBq3ciPinI/rbeZ/dQHWPekE9OFve504F0agUOPovCDNH8zrDhV1OVQtT2Tiy8z6UJqRSenojUlFhdxs6KlPYJ0yveibsKvrCtLm1DFmh6hhHtQwJ1S6MrfJc25gNWggaw1sQ6VhSfGJOMjlMxzGTLw6gNauVfbQ+dFKe3GQE3A23ujBg+K1YJK93Gqf41lssrQxwKiYDbuap32T5SdHT9N4L0NUYi7uNdYv9TCmHFaEdZcZfDKpTCUICj83N/ocJeaM57OEOryPuarjwuYlgBtfxtwAVqGnxbXHCNViBuPyM8aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTF2dqMrwt9WFlAq4MusYbcR3CKJheKW+eBM7tJ+/1M=;
 b=X2waNG5OejoIDp6zdfPEme/K1OHF2BqeQ+dq/LdDCQhImhbWvrJbR5fToHD2LlcxK7J5wWCpKrN6Gzp71KW3Ki0xDrkPbS88HZ5X23afm6GzAg+ic/1HA8BIfJUNRTq67fjyYa2CAJGCeLa7U4sxw3+L2BhIFn6JSfqrQZeD0lTLaqyDSJaBCQC6MoEoE8+ApeqF1+N+SfP6TKSjZMB5B5JqBWY0LFVAVux286mnSpN6CtFNGAOdHp6B5WHQlZWCVxuWPdkB6fxVwdmIczCP0b9t8VTMkFraWnRyfCJJOncoGaxb/hhl7L4Rd58t+Xq0CdEEUjXzmGrfzKFHuyET3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTF2dqMrwt9WFlAq4MusYbcR3CKJheKW+eBM7tJ+/1M=;
 b=ELePFp2waE7Ns0WHfJAiZWhxln6ah8EPich0siGhHJt1QF+R5ey70zJe8EiJlP64EpGQfYsTt4SrQFZkPIYjKwUihJHJUxfRyM+Ah4KrHlJFv0b8s0vWWtSRVkeUVOc8ffnUNWk1/AdFc4ptmI/VTMlESp9JyNng8qysvsRpXKY=
Received: from BL0PR02CA0112.namprd02.prod.outlook.com (2603:10b6:208:35::17)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:20 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::7e) by BL0PR02CA0112.outlook.office365.com
 (2603:10b6:208:35::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:09 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:09 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/42] drm/amdgpu: simplify per queue reset code
Date: Thu, 8 Jan 2026 09:48:43 -0500
Message-ID: <20260108144843.493816-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: beb8b590-60e3-4589-2799-08de4ec51b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xV161vbJQ/ZMEeuy1b9NGBsl1Oet76byFekB/urzQVb/bpoxm84TefsV+Sbg?=
 =?us-ascii?Q?VSeOd+jdruwewFQ+IjuRpM5qOilw+fpDLssAow7KlILoj0EH2XmOEZlk72Yc?=
 =?us-ascii?Q?sBCIUB8VcX6OUJMkGNjl9nEFkHUxIO4g/fhyfgnt29I/nwZtXqiDVP363luz?=
 =?us-ascii?Q?THRtb/F65aS3Zmwu/40OfS6kNYBGCSh6ApxgZUnXIldLWjdFy7YUm7Snd9tl?=
 =?us-ascii?Q?OX4EwtHDIv0QXf7JgK1NTqP1EYefhzJd5lNVioUpwDIB3fXC+956c3n+HyXv?=
 =?us-ascii?Q?NwQLjicx4tHKjMeP/NIbOOUvgnTw5Az2TTZQfMYSfU5rRUNqOCRHD4IgIZuY?=
 =?us-ascii?Q?L8X6Zr5eDAVAhf5Sj/wbpwS3xBNhg91EC94rs3vmOOJMiRWJ1WSy1SlDqhPN?=
 =?us-ascii?Q?IZg0pE+gcAgieWf5Af+Bc7Cm+dqGZtrUbTiTDdXON9+rIAqb7WDrqqYzMBkd?=
 =?us-ascii?Q?UQZSjyHktHWzRpIB55Lpp4ynm0kjXa544ITnD95X6zitNpwbZ/xkKrFe0cuG?=
 =?us-ascii?Q?Rs74qrL+jXjo4kHjKrVOMB44BWvMxm3KEmaGnM2A55Tq/1lXYF0cJE4RKZnM?=
 =?us-ascii?Q?eviRhw6slUcx76Hx88t+j1+ZQs3vxYBTW8+g55NpmL9HM0ekkU8D5xTcD6Pz?=
 =?us-ascii?Q?FBeQ4QGihW/H28KPlGXbdRc9b+VEUvmBzVH3U9xRGIfNPW2JAwjm/Eho2O9c?=
 =?us-ascii?Q?S+1VHMUXUlCDQ5GpcqfSYXAX7lTt2OOsOuVAxof9amcl9gbRrVZf0jzvvchb?=
 =?us-ascii?Q?kZ7lSwVCqGpEhBc46uYffnITpiSnEDi3zUaVyIPLa8IX6CTpxmX3ka4lOr/U?=
 =?us-ascii?Q?v2d+7SuqBp0WRcvNSnIC88PLruG9ItFm2PnUtA3KuFK7sHr9m8r1pXk1G80C?=
 =?us-ascii?Q?cf8lqP9xC45X7wIoaJeYinNAi7CQVH+cumT1vwc2Wr2tF9vJGw6ucJVtfe9d?=
 =?us-ascii?Q?6SOOWPYk1CjcPJ5fJJZUl0D1RuK5YiM0k0a8mscCdXV/mnt/Ay1h8Bf+V0P6?=
 =?us-ascii?Q?48nJwK4+rd/kAEF2AyL4B6pYM0mWh6b8JZswh6u7Y/2NA6QrgFpFTA6UU7Jn?=
 =?us-ascii?Q?4gLdhDOZMRxKPb/n46o5SiZ9+Eviz6kgtmy/zbKGiWRoB2oznOc6w88fhtHz?=
 =?us-ascii?Q?Q//o+dfqYQKNl0ITAEfl67VpM3r/Bww5fehpB9DSjzs7Umy3jEQ2HXI7L4H5?=
 =?us-ascii?Q?Fwm69IlCEkE9KOB1B/mVBcigUNSDlTi8D++5Z7YImNbFd/UpeRKAGPUx23nq?=
 =?us-ascii?Q?xYypK3Uz7+rbfTyTFncfUuChAaSpTA8UcPqRk0GXhmFi6oZzLyzk3K1HqdUn?=
 =?us-ascii?Q?2963TVCwzerRrtcA9vXHtTWT6DyrvgxxO4L5f2ZlO2KhlT4sLXCVGGse+7se?=
 =?us-ascii?Q?fRvsFsHL7MeTdVpCqoKWR6Fhll9g4Q5y7oyc0F+grtPSxH+UbaAaQC95AwvK?=
 =?us-ascii?Q?iUI/lBgI1eAR+BSaofD+pjC6Re1QYyCcIoYWVr+spJKubIgOtZyjc9rsk+7X?=
 =?us-ascii?Q?EmxNjahXj86JoGxWlLZN1/eja8BS2xQgi5qbprTH2Ma5GJJwZA6JQlh8LOJr?=
 =?us-ascii?Q?Av7ctwFlUCKfdqJawR4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:20.1242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb8b590-60e3-4589-2799-08de4ec51b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 16 ----------------
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
 28 files changed, 31 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 91821207636ea..eb0ca53af0ebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -164,6 +164,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (!ring->all_instance_rings_reset)
+			amdgpu_fence_driver_update_timedout_fence_state(job->hw_fence);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r)
 			r = amdgpu_job_reemit_jobs(s_job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 1d94707fc86d9..24ec9fa0fb979 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -833,22 +833,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 	return true;
 }
 
-void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
-				    struct amdgpu_fence *guilty_fence)
-{
-	/* signal the guilty fence and set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
-
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
index eae82b802399f..69395cab9ed3d 100644
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
 #endif
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

