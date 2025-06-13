Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702C0C7114A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8DA10EA6A;
	Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uoc3XTdK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EAA10EA64
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmgYP1ShU8KmJLFW/Nfw+O2izAdLCtc4chbeep+UzSaEfVt8UlPjhhdw+si6C5zDFPzH7Nlh4RA2VBygvknPaaaLgNcKnRglRQDhi0Kv/b4cEjCYeufgL2+kCPObRXgvpjdpIdMH3lvgcb0YqIn4DNoPDB4R5LdTSYMvTtBWEBoVqB6GAWMQ8F0PmEy5clwFdmMGbH9q+S8bAARKmv0E+LuabA8El3mS+LHlhe2VCzsmGvEBZiMmgQ3cs4cn8ZZMPb1yY+PrkqgsrBBpY+H69uj45Xc5ES4fe/G7llcGVf2HCxD4zlyqglKlQ411AOV90ToG5TP33BV88vU+NLUsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQADdnkrp8Fpr48JJEdM04KmBFFvZm1CBm6RADngpII=;
 b=FXhByD3scr6oauJdovj9vtfkctRm4vzJFaJji0++T+RO/Dg4vTRIbDLyuLOvFVZpkPsUZbzeUKFrn9Sa3r6oQkNhgkS/jhETzGPjPRVU0FCq9bep5Ov6qVKk020m4MjueiF5b1gPfq/zmxuNpsyJC+OR52SB9KeuMVKXTGPd9xe51SQki5hbiJr2EMiqskLPphX4TRwlnY86sn8wKOOitOuBK+V+zTcDOc65Kd5vJia+7WMdxE4VnmxG8dP6zQPqywhouSHq0uI16++1/NBXfCpUbBI0YFIzc9aOdlUyoEPpGPCttUDccprafDiH+T59wo7uuRVUZxy7pZymP8XDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQADdnkrp8Fpr48JJEdM04KmBFFvZm1CBm6RADngpII=;
 b=Uoc3XTdKlBEAqW0NAPI0icyQOFbd1A8Vu+E16eefc3KpxMhxmmX5a4PvUvlaj4SYBG3/Pxc/MkCqoGjo/vuhaEAOCPXIEyb1yGUl8deTWQMqOfGXIAj0s75oc8yO0QNALb/XTu8kHCK/Jd+bfSzgqbKDcueLfJv8G1ZqepIfdX8=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:09 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/27] drm/amdgpu: move guilty handling into ring resets
Date: Fri, 13 Jun 2025 17:47:28 -0400
Message-ID: <20250613214748.5889-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 441628b9-c53e-499b-b183-08ddaac3fd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hwq1jRpzUscTFiBmQMekEGyX/TR2RggswyLqiw1NCd7HVE0ilq5tYl1Q7+uV?=
 =?us-ascii?Q?2LGrll/W1RRoFbTC0WtGvFDw5kbYym3W3vYBGVqYHjzWSWd4j61KwCYsgu26?=
 =?us-ascii?Q?5nC8/rW/b5bxvGndezngn0GYMgSlhQL92dxtwQvwFuqw19Ii+O8mz1tPn/Bt?=
 =?us-ascii?Q?IglIqT4wU1Ed2q40FCnCNynQ3CHNzIAPvulAL9VYlO7M74tOqqdLeCTu5lvs?=
 =?us-ascii?Q?ITP2GDgEVZqJttwwto9fGxLpo9AA63o15FGSgJENg6B0K+X3NSBsscY6iuOi?=
 =?us-ascii?Q?Z/DtR1v4uEWR2DskFvHAIACLsfp8QpvECwuvdoAIirUIedvpBCkFrQzZTkZB?=
 =?us-ascii?Q?IlDUWaeXYjBdW9ZOIpmK4xSSgqtjCZNfCXCgTzCpSZEM6TxbH08NYZslea9F?=
 =?us-ascii?Q?4l/RjuhTckh/GKSEo96BbKIsJoSLjguQnTO2T0/PYp40u8lOaenObFwXcvwn?=
 =?us-ascii?Q?S+G4miTO1CH/YpU9pgkBk56E7mmapVmmQmS85mYCC88TRu0+wtyegm6nG3is?=
 =?us-ascii?Q?H8T29uCGNmBgGPtF9HGPb7dSlOcqu3kYD+JZ9we3TQrJ4Y+GRE7y3xJ0SwmH?=
 =?us-ascii?Q?ejyZ/4Dr2wzuS0lZh8FRUmdWWO5rCCCG8puF1qMcqTeE+V3D5Qt/5EEyolK3?=
 =?us-ascii?Q?y371jQ+anYdN70cCnKlnLM96Mo5WiEnqKv3qrRCQLkcO3R+ErgSvku7dNUHj?=
 =?us-ascii?Q?3G+GY8+EeZXGbChS5rCIsRS+nVj+m0je7XfRc64x9tEicds+jW2idrLEkG0e?=
 =?us-ascii?Q?DokMDD3ZsbHWGvPIfbJGLwM6NMTNF29bdb1DhtvK1uMlh7vkwdcgg73HWiAa?=
 =?us-ascii?Q?t3IePbIFgXUXLP9kcusNiH64v4gyBLsXpRgdc7bhMs8mdZVEvQFkqNcmTAd2?=
 =?us-ascii?Q?6X+KC4VckYmWG6b+YrfLn52x854nryY63klKUDj5at9jPp9RqzqRoFCRCUjB?=
 =?us-ascii?Q?QeHpc2A8fjOqP7RYSWdFHkylB2k3Sq4ZS2bGFQCjYYzGJi422omqkrcWUMIB?=
 =?us-ascii?Q?bQJkZChF11uQF/u/z8QqZxJzT7Gyq+/uqNuk9k2eycPjONjqoueV8OXLH+qo?=
 =?us-ascii?Q?WUhjCAA2NOsJjpWFE3tygOaz1vnVs88F/oDAkuA1EY+hW6xGmIbgBKAgXgP+?=
 =?us-ascii?Q?jYvxYkV9A/XI93B3DFDEGlk+tMyRrQ0z14PvJ+c1P+LF5i3hhjBIypSeLxKG?=
 =?us-ascii?Q?8jj5imNEIofiZUu1WW8I4ssXbXknNX5Xm+2uEnzR7hjZ917BhpjCQ0Vfwa+3?=
 =?us-ascii?Q?kXFzet6xBAMrcOYg6kgwgytNZDUxqZJ9OIJD+lzbg4fjO0vZQbtPgb5YMwm3?=
 =?us-ascii?Q?+Q91TvuiOFFZuhlED75M8CsNVsr4pWz/qt3aoVlpBwzZwhGII6A56ioB8CA/?=
 =?us-ascii?Q?VpuRpFDsXVgfR8NCAEJGC+aigivWI2MFfacf14N2a7KOeFQQhwoRiEeW8mrM?=
 =?us-ascii?Q?ppTAjEM4Djycp+NCJW9aj10QxIdsjqNxCJXz0lMahV+d8wm+L/P9+J/7ThOX?=
 =?us-ascii?Q?h/C18j/yYAV4/g5VkAq6nP8TNLrPKtdEH8mE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:09.6064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441628b9-c53e-499b-b183-08ddaac3fd02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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

Move guilty logic into the ring reset callbacks.  This
allows each ring reset callback to better handle fence
errors and force completions in line with the reset
behavior for each IP.  It also allows us to remove
the ring guilty callback since that logic now lives
in the reset callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 22 +---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 52 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 23 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  1 +
 22 files changed, 89 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 177f04491a11b..680cdd8fc3ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,7 +91,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	bool set_error = false;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -134,8 +133,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
-		bool is_guilty;
-
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 
@@ -145,24 +142,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
-		/* for engine resets, we need to reset the engine,
-		 * but individual queues may be unaffected.
-		 * check here to make sure the accounting is correct.
-		 */
-		if (ring->funcs->is_guilty)
-			is_guilty = ring->funcs->is_guilty(ring);
-		else
-			is_guilty = true;
-
-		if (is_guilty) {
-			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
-			set_error = true;
-		}
-
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (is_guilty)
-				atomic_inc(&ring->adev->gpu_reset_counter);
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
@@ -173,8 +154,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
-	if (!set_error)
-		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ff3a4b81e51ab..c1d14183abfe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -271,7 +271,6 @@ struct amdgpu_ring_funcs {
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
 		     struct amdgpu_fence *guilty_fence);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
-	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b4f4ad966db82..a9d26d91c8468 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9581,6 +9581,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
@@ -9658,6 +9659,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5707ce7dd5c82..3dd2e04830dc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6846,6 +6846,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
@@ -7012,6 +7013,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 259a83c3acb5d..d2ee4543ce222 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5341,6 +5341,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
@@ -5460,6 +5461,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e0dec946b7cdc..1b767094dfa24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7228,6 +7228,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5fcc63cd99df..05abe86ecd9ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3625,6 +3625,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 0b1fa35a441ae..dbc28042c7d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -776,6 +776,7 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 7a9e91f6495de..f8af473e2a7a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -655,6 +655,7 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 81ee1ba4c0a3c..83559a32ed3d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -567,6 +567,7 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 06f75091e1304..b0f80f2a549c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -735,6 +735,7 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 10a7b990b0adf..4fd9386d2efd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1158,6 +1158,7 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 88dea7a47a1e5..beca4d1e941b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -849,6 +849,7 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c5e0d2e730740..0199d5bb5821d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1651,37 +1651,21 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
 	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
 }
 
-static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
-}
-
-static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	if (!adev->sdma.has_page_queue)
-		return false;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
-}
-
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *guilty_fence)
 {
-	bool is_guilty = ring->funcs->is_guilty(ring);
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
+	bool is_guilty;
 	int r;
 
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	is_guilty = sdma_v4_4_2_is_queue_selected(adev, id,
+						  &adev->sdma.instance[id].page == ring);
+
 	amdgpu_amdkfd_suspend(adev, false);
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, false);
@@ -1689,7 +1673,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 		return r;
 
 	if (is_guilty)
-		amdgpu_fence_driver_force_completion(ring);
+		atomic_inc(&ring->adev->gpu_reset_counter);
 
 	return 0;
 }
@@ -1735,8 +1719,8 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_mask;
-	int i;
+	u32 inst_mask, tmp_mask;
+	int i, r;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1753,7 +1737,25 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 		return -ETIMEDOUT;
 	}
 
-	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	if (r) {
+		return r;
+	}
+
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask) {
+		ring = &adev->sdma.instance[i].ring;
+
+		amdgpu_fence_driver_force_completion(ring);
+
+		if (adev->sdma.has_page_queue) {
+			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
+
+			amdgpu_fence_driver_force_completion(page);
+		}
+	}
+
+	return r;
 }
 
 static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
@@ -2159,7 +2161,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2192,7 +2193,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 09419db2d49a6..4a36e5199f248 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1538,18 +1538,34 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool sdma_v5_0_is_queue_selected(struct amdgpu_device *adev,
+					uint32_t instance_id)
+{
+	u32 context_status = RREG32(sdma_v5_0_get_reg_offset(adev, instance_id,
+							     mmSDMA0_GFX_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	bool is_guilty = sdma_v5_0_is_queue_selected(adev, inst_id);
 	int r;
 
+	amdgpu_amdkfd_suspend(adev, false);
 	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, false);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	if (is_guilty)
+		atomic_inc(&ring->adev->gpu_reset_counter);
+
 	return 0;
 }
 
@@ -1617,7 +1633,10 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	return r;
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 365c710ee9e8c..84d85ef30701c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1451,18 +1451,34 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+static bool sdma_v5_2_is_queue_selected(struct amdgpu_device *adev,
+					uint32_t instance_id)
+{
+	u32 context_status = RREG32(sdma_v5_2_get_reg_offset(adev, instance_id,
+							     mmSDMA0_GFX_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	bool is_guilty = sdma_v5_2_is_queue_selected(adev, inst_id);
 	int r;
 
+	amdgpu_amdkfd_suspend(adev, false);
 	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, false);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	if (is_guilty)
+		atomic_inc(&ring->adev->gpu_reset_counter);
+
 	return 0;
 }
 
@@ -1529,11 +1545,12 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
-
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
-
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	return r;
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 746f14862d9ff..595e90a5274ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1565,6 +1565,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 2e4c658598001..3e036c37b1f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -830,6 +830,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 0d73b2bd4aad6..d5be19361cc89 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1985,6 +1985,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index bf9edfef2107e..c7c2b7f5ba56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1626,6 +1626,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 3a3ed600e15f0..af75617cf6df5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1483,6 +1483,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c7953116ad532..64f2b64da6258 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1210,6 +1210,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
-- 
2.49.0

