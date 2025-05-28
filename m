Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226EEC5B55A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CFA10E1C3;
	Wed, 28 May 2025 04:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DwdmBfp6";
	dkim-atps=neutral
Received: from outbound.mail.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A1710E1C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSedBwoy33NHpbsmvC8hR4tskFnJ76KSfqas5x0cniVigg6vvN8RRS7eBEy7TPHBh7Ojoil2yRt/+Nqe84100OnipAys6XjbLgihUZUP2Ta5+VljvgMmlUW6GSgEOZRs0TgUY1GdCJlpA7ZtE8WK4zTetI8w6plAYBtRXUtEgCGo5FkqEngAoWcnvAiqrhzq0Ui/6DM22QyO88dygdxSJzvxRhvSN6z3LWYN35Pu2LfdF0BfEWWTQdH/8a+4RBJ2pe2TOds4ZVA8chQFzi4lQSg24/9NhGhPc/27RAXdof3CPD79XF2jpEq+fohVa/quc4+ZGOTNbE1Xhr0BczO38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSAMioWHvV4U7c2GZnhShuCXje/PwJn2bkmcTkzxWcE=;
 b=VtipEgM8O8YO4e6Q1r2UrxVtgBCwHCWAk4AZw23vMqoTnWLEcBGw780lJ03DNlMdwTdmuPcpPbVmwBogHPwQNGAJmbVCXDJGERvb5ngYB3vbE7AtMzF+Y3CpZsB/+rmHS0kozT2sZc1/OoJwR2VwLXdVGUdw3ZHBodGJm8XjG5JuXmJBoVB+tIeMiBhAYqRQmGBTen5viDjO7+VU0YVSrsRuG1jJgzbBf4deR5pMtLD2uRzEuJthWWHwOtQCMcD3wBlK15ukrQBo9XIKOtfiXQMZlOtk33O0LpSIiG0aT45IHVfbU5KtErfZ89EtKy3EIFQCY4Lcv+UqmCfpHLctbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSAMioWHvV4U7c2GZnhShuCXje/PwJn2bkmcTkzxWcE=;
 b=DwdmBfp666QXZgWBBd5pIlpJ7s64ySchpvHpqbwC16/QhY5SCUSFAaWjB2tm22Gh6w7BzM7ldbxTVIU91zQwqFuDPalfmlirKZwPDvvizgkW36qDzOk+OWJX+8Gelb2RYNUQfjnyYsOjIdIlBocJSwtzLjidIZs7Zn0OpojWEic=
Received: from DS7PR05CA0053.namprd05.prod.outlook.com (2603:10b6:8:2f::34) by
 SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 04:19:36 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::cd) by DS7PR05CA0053.outlook.office365.com
 (2603:10b6:8:2f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 28 May 2025 04:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/19] drm/amdgpu: track ring state associated with a job
Date: Wed, 28 May 2025 00:19:06 -0400
Message-ID: <20250528041914.5844-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: dacb470c-6134-46d0-369a-08dd9d9edb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JR5xC5VlNHbXS6qsuMkre77QPDYgFtIlqA6OPMjD5vo6IlCTVAtc+VLSfKFA?=
 =?us-ascii?Q?ejXxZgVvbfWMgoKr7YesOoyc0cBynr1wHjN8nj/GaSLCaf5SKA96CpGTbqH6?=
 =?us-ascii?Q?VTu+VssWz6qCpafoIN6Mh3CHucDwCiEA9uiCy0qTEXus4NqPkfUEkeWkuh1p?=
 =?us-ascii?Q?RWqyPEkZDohH0XQUtez5VShHSsX8CeCLPHU0IpPAc5JA5oYetLotOO9zQWc4?=
 =?us-ascii?Q?y9T8VZpu7vN8PpXZCZGszdPGOHkLM0LK7DTeyoQVgrVX3/TbI7EReZqewjSE?=
 =?us-ascii?Q?SF5UX3gAvRWQ03wp4ZcTpR0QTGRanXIAwiSldDfpk0IMvaEtx765k2BmS/1A?=
 =?us-ascii?Q?P2MnlzC+vmjRWKHrrU5Ip4asYsgwD8jwrN7IvUCqs3GTsUOneNdDWQYxMrtm?=
 =?us-ascii?Q?Cfj6GAQRS12XQE9fTwmMxy4Z8Cj3JsBagDC/ICSG3iFymOIq//ZIMQArdqZX?=
 =?us-ascii?Q?K8WTuI8BSZ8bRDviJFG1cSBxPxFwbTBkT1CYLKqqzWg1by6j5rfW0x1czOD1?=
 =?us-ascii?Q?xzpTIxP+BAdRpel5AbYVqiA+Msx0iIsH+2c2mfCFDYHyw2dQxCo+bkiZgL1E?=
 =?us-ascii?Q?kQTVp3oyr2P2Vq4cUgLpw8pfIXCgnyfcaNJGd88juDFITcmae2EOLde7X93l?=
 =?us-ascii?Q?4pX1S9tD4URWSfDvJu66OABRVWsqOmUBJb1yPuv6YjLHpDOfYwBRq+igRGQz?=
 =?us-ascii?Q?OaOsceV1t1UmLkgZvoBCeVr4w6XMvdHAQg4hc7RisID1m5nilg494QMB0WT3?=
 =?us-ascii?Q?o8TTVqyi2/IRsFu/VQTR7n2JCvIL6LlyNJmfpy4p3snkN+SLJCew/JGpzPJ6?=
 =?us-ascii?Q?xRYaxRBjZlMR8RwKYTjmrcfUheBWxUXmbYTREOW5g6A9o0nGDNIKM65Ob5K+?=
 =?us-ascii?Q?IwwJLkzEtyTklX0Z5Xl6Ea6Q8KNdD6fQF+AdXLzoWBuKMh/YOsSbk9/PeBXC?=
 =?us-ascii?Q?GNjwM7Yg28ONldgt57f0sfI8zEwbhPGqs+T5hn3GES71Dk5nI/3QJ/y17rEG?=
 =?us-ascii?Q?oEhXZe6egoDF+N2QDTVAq7tOC9I99OTa9WIS5gRYBaZGSVp1JU7bjegPA8FB?=
 =?us-ascii?Q?6zx6oZbkRlhPY3zoCZLwJx0ELzh00C+tSrAOI8MMQ3Mnkfv4ZFjBzi9BR0Ag?=
 =?us-ascii?Q?a9hUXTASIZI9YdZREbCYyHkludYMsRYr3m6k0kwhr2H1dHstkCI+xjxyxX09?=
 =?us-ascii?Q?EBt6fe/FP0rK2DtMrNvG24KIaddkr421Qzl2K84GpDVVAiha1LRjVUV6SWoI?=
 =?us-ascii?Q?yO7Ev/Yd9niH3pmmWqyUaFEjQgiL9aGOShgPAT79EFG0nxcqoESNwDdCKZlB?=
 =?us-ascii?Q?/G49iTY6M1tKy6vpMRDX/AnFUuhjsaj+IZ2BUBBwq+WbBjO0Ws7pivQAW5VY?=
 =?us-ascii?Q?vjnfvShQyQBxVdiBcLgajleWdcqO3Oc0lrFkEULHXPWNBaK3QV4wBthpT24i?=
 =?us-ascii?Q?GP29FT3DxNi2ZxxNhsTICU1PXwKL8hTI000txc32t3Fx24aKqc3Pn3Z+Bb7U?=
 =?us-ascii?Q?QrYKy/3DIrc95i7ZX+4UH/II9rvMLVSMfPCX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:36.5010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dacb470c-6134-46d0-369a-08dd9d9edb48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
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

We need to know the wptr and sequence number associated
with a job so that we can re-emit the unprocessed state
after a ring reset.  Pre-allocate storage space for
the ring buffer contents and add a helper to save off
the unprocessed state so that it can be re-emitted
after the queue is reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 3e05e8bfaca4a..948bb0dade62f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -306,6 +306,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_pad_to_fetch_size(ring);
 
+	/* This must be last for resets to work properly
+	 * as we need to save the wptr associated with this
+	 * job.
+	 */
+	if (job)
+		job->ring_wptr = ring->wptr;
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0b9086a747c0a..c549e7c598459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
+	struct dma_fence *fence = &job->hw_fence;
 	int idx;
 	int r;
 
@@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
-		if (is_guilty)
+		if (is_guilty) {
+			amdgpu_ring_backup_unprocessed_jobs(ring, job->ring_wptr, fence->seqno);
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+		}
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index f2c049129661f..c2ed0edb5179d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -79,6 +79,8 @@ struct amdgpu_job {
 	/* enforce isolation */
 	bool			enforce_isolation;
 	bool			run_cleaner_shader;
+	/* wptr for the job for resets */
+	uint32_t		ring_wptr;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6a13ef9145447..c0664fe71bed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -346,6 +346,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	/*  Initialize cached_rptr to 0 */
 	ring->cached_rptr = 0;
 
+	if (!ring->ring_backup) {
+		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
+		if (!ring->ring_backup)
+			return -ENOMEM;
+	}
+
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
 		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
@@ -355,6 +361,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    (void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
+			kvfree(ring->ring_backup);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
@@ -398,6 +405,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
 			      (void **)&ring->ring);
+	kvfree(ring->ring_backup);
+	ring->ring_backup = NULL;
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
@@ -766,3 +775,17 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
+
+void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
+					 u64 bad_wptr, u32 bad_seq)
+{
+	unsigned int entries_to_copy = ring->wptr - bad_wptr;
+	unsigned int idx, i;
+
+	for (i = 0; i < entries_to_copy; i++) {
+		idx = (bad_wptr + i) & ring->buf_mask;
+		ring->ring_backup[i] = ring->ring[idx];
+	}
+	ring->ring_backup_entries_to_copy = entries_to_copy;
+	ring->ring_backup_seq = bad_seq;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 235af37145dd3..14a4b34de9966 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -268,6 +268,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	uint32_t		*ring_backup;
+	uint32_t		ring_backup_seq;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -535,4 +538,6 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
+					 u64 bad_wptr, u32 bad_seq);
 #endif
-- 
2.49.0

