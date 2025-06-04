Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FDC5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 12:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2942210E78F;
	Wed,  4 Jun 2025 12:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oiY5kZf6";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B8CC10E73B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 12:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM8RU2VNzatf2goCfWhBOgpwS/duK/sRcWiZLVnyXT7nFCRcVJ5UFjB0EBmLzXsSQ8Vn6baV8fYvZU9cq6UbZzAwb17anIZgMAU0lHFKX9YXxvvBo/2KjFFfdRu834j9ZJMIpR3MOOIkT8vE5EyAJpPv1H1hpFX1krcHIZQ1XseM8sqlp8uARKcjrDrAVe8KitYkRTAG8H9D0teizEGM5kNtTK1l01JevzqkYE+mo0HayNe2xK4+29GbYQ4DJZ0mFQCgkWR8XzPZTfG9JQNI88bxIgyuN1s5B+pbUaAwM5tijYQihFixgYMUCGtEcKE3ab1A+OtH6k8YxongMTtrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34518CE7ZZcY/+Z9uiUxLD+pDxl7FlCkdZaapTZrT5c=;
 b=vNlvNboD3NXxkOtKjlj2EECr1fpB7O5Z3zqbq+QBQqSQrE5xghDjr6EUYj67vQNcvt5HqGvdhsojqC/tkHpuu02N4uvRhKr1dQEH44NK1Py/K5/DpWXZ52uFTAX9ZwdO64nb3GzQxoXrxMfoODPFqqw4JqGSdIHb/wZ9TUhLZZfVS2mJ6VOKwsw+LFmOPrZEcC1D+jEurr4H/yl5935eyEkN6Cb965IbxX1bmvjatg3wDYd99F+slqLLxi71ipdI+WsCX00Niy5Mf8NfTlJ/W0vdmTB4u7pkiw5HVPK1Jb7FaZxoAW+7u2mjkmteiwgvYX+kF4d9eiK+BiVRDHAIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34518CE7ZZcY/+Z9uiUxLD+pDxl7FlCkdZaapTZrT5c=;
 b=oiY5kZf6UM2QS5N3aJrYxNg4I18mM8mpbG02YHwUrtVdBzWrdj/xSVl6oxUg+ns3JZU3Md5ATPkXqtpdj99lYHBm8jzJCahwKJ4ZAVA8M66At3HCKLVEBGuF5FVnWQ+j2rg1xTIuSeJF2gmiFCI77aYrPl+6qml+XX3snR8rLE4=
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 4 Jun
 2025 12:28:49 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::92) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.14 via Frontend Transport; Wed,
 4 Jun 2025 12:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 12:28:48 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 07:28:44 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1] drm/amdgpu: give each kernel job a unique id
Date: Wed, 4 Jun 2025 14:28:23 +0200
Message-ID: <20250604122827.2191-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0109aef9-626e-4c6d-ea0e-08dda3635b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z64ojhC24J2jwQ/oGW/lmWpxQXFt8w7LBqFi0uRwY/f5Mo3IjAb/5FCDFSix?=
 =?us-ascii?Q?bJDcq+pbY7snz7WvZunR1bq3PDc/0dSreIfW0guxTtpQsOtYbXuIVQSnONSc?=
 =?us-ascii?Q?O9JqtuLwUdij4LnU7qC2XWcXaQ5oBu0Js8MaLloSbw61kMqa09HfkrYyxpBi?=
 =?us-ascii?Q?9keIeiZj13kvM1brbtFXvOpi30bnBM2gOyomb7DIVUvfbQ116kKKvhTqo7gD?=
 =?us-ascii?Q?cq9iQSzfm3ForGdhvkxQtQuZ1lFWP1I3u40eboW4n6CkwYHIf3CPubnOYA4U?=
 =?us-ascii?Q?NvwBKaaH/XIVZjoSzdieH4Z2zlUeACFnMOGifaQCtHl8QhGjaFYVLwWO6sPu?=
 =?us-ascii?Q?O9RZvI7MLdsMYLY7vy0ttsW9slCkZHiGq9zTL+S9BFdmT5BwkvwgbWB6C3hF?=
 =?us-ascii?Q?3lpUYJaOltI2PBkeGfIn681WTlh2oguDBllz4OMcLW8wLXZUbvmjAKsI8MeJ?=
 =?us-ascii?Q?gyoSDDl/OvwPGBKBkGdbQkngxB6xSS9XFkEv89onxR7yAPcN3tSjFve/m04P?=
 =?us-ascii?Q?C/f1e5uXk+I7Zbw5iFIgoLV3Dkn7qLvQ95uu33P41yZ3Tao3fAUVcIx8kEnh?=
 =?us-ascii?Q?t0cadZmbZCs6/pYivXNjMG7TgX0/1XcVcwynOANVY4pjRcae4WhWKCYm9nO/?=
 =?us-ascii?Q?NjtGEllaVqjEdef6fr2nYsEXI6vGtIkl+dvsqk5aDoBSKp/OifQwZ2I35ePt?=
 =?us-ascii?Q?Zu8f7gFVArZCTZ7HvmcWsmWNrZLaDzHsVj9HB91ZHoI7s8zP6Godv9qU5LGg?=
 =?us-ascii?Q?YbdI9lHJU4jAWemR7pauZSFTEmPmPidlLoc/uBYdf3oiPmVqh+aJpSCzoprj?=
 =?us-ascii?Q?BDs7odUxz/MkITK89IIansI+2kktl0625+f9QxUPvn4ZcEYmJ7uNmbgFecN/?=
 =?us-ascii?Q?nVM9Bxksz+ljdw88jHHhEZkpaunkP/JDH6g60rorHUMAdPHblu1b3EGJyCgY?=
 =?us-ascii?Q?yBp6HEk0zA2QDzIV9G4hlzduhoqxYIlMhi5eBeSoO6zSR2SXI5NV308M/E9U?=
 =?us-ascii?Q?uhBmnCthMTWGqsII4NikM7MXDBFrNKbZ8D4bU8llqDyMcn8q5s0PmZwvyI3w?=
 =?us-ascii?Q?m0/bJ6HztREMrsJV31HoEELuu8E/q/++2WSiROc1QejJRxe98rAS7CvbunuS?=
 =?us-ascii?Q?whL04F5tP3rHehg+nTuA4453P0VqBEnGWELe21mDYXKc8NTwj4hXQNbXLSIT?=
 =?us-ascii?Q?eflV/MH3TAA9aTi5AJA6SyotcSpVXhtl4tXcPh/Q1INms+0ouJlqqObbbLhW?=
 =?us-ascii?Q?hRteIufKyJrUshb4BWO8qjjwxG7WEyDRfF4uKQ0wbjmbCNYQBCMsfmvun3Ub?=
 =?us-ascii?Q?DimlUADuncNNx4ZsLTZBNH2rBxVEAIJpdlz6NmJNrv2lD/7MjcsI0mZ7F7kR?=
 =?us-ascii?Q?JiO+W1iczcoxCTNNL5yaSXzf+CEO3qYzAVvfuFZxg4DI2RyvpHPFF0caJREJ?=
 =?us-ascii?Q?F9+ACd7u0Dj8FjLJx6PBulYZlDJS6v0XdKC0IMybb8InOuynutR0JIEdhI4H?=
 =?us-ascii?Q?SDCDtktYsuVx8H+u05sm9DwNHOze2wMoBLiT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:28:48.3095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0109aef9-626e-4c6d-ea0e-08dda3635b3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
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

Userspace jobs have drm_file.client_id as a unique identifier
as job's owners. For kernel jobs, we can allocate arbitrary
values - the risk of overlap with userspace ids is small (given
that it's a u64 value).
In the unlikely case the overlap happens, it'll only impact
trace events.

Since this ID is traced in the gpu_scheduler trace events, this
allows to determine the source of each job sent to the hardware.

To make grepping easier, the IDs are defined as they will appear
in the trace output.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     | 19 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 28 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  6 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 12 +++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  6 +++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  6 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  3 ++-
 19 files changed, 84 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cf2df7790077..adc151183e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1461,7 +1461,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job);
+				     64, 0, &job,
+				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ecb74ccf1d90..66e762c1e43c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -674,7 +674,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB);
 	if (r)
 		goto error_alloc;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 75262ce8db27..9fd5387a0cd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -230,11 +230,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
-			     struct amdgpu_job **job)
+			     struct amdgpu_job **job, u64 k_job_id)
 {
 	int r;
 
-	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job, 0);
+	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
+			     k_job_id);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 5a8bc6342222..6108a6f9dba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -44,6 +44,22 @@
 struct amdgpu_fence;
 enum amdgpu_ib_pool_type;
 
+/* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
+#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER        (18446744073709551609ULL)
+#define AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE       (18446744073709551608ULL)
+#define AMDGPU_KERNEL_JOB_ID_MOVE_BLIT              (18446744073709551607ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER       (18446744073709551606ULL)
+#define AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER         (18446744073709551605ULL)
+#define AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB          (18446744073709551604ULL)
+#define AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP           (18446744073709551603ULL)
+#define AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST          (18446744073709551602ULL)
+
 struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
@@ -95,7 +111,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
-			     struct amdgpu_job **job);
+			     struct amdgpu_job **job,
+			     u64 k_job_id);
 void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
 			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index dda29132dfb2..41e083ed0758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -194,7 +194,8 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0b9987781f76..0ca8f0362354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1315,7 +1315,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (r)
 		goto out;
 
-	r = amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true);
+	r = amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true,
+			       AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
 	if (WARN_ON(r))
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 53b71e9d8076..72db29906c11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -226,7 +226,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
-				     AMDGPU_IB_POOL_DELAYED, &job);
+				     AMDGPU_IB_POOL_DELAYED, &job,
+				     AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER);
 	if (r)
 		return r;
 
@@ -405,7 +406,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 		struct dma_fence *wipe_fence = NULL;
 
 		r = amdgpu_fill_buffer(abo, 0, NULL, &wipe_fence,
-				       false);
+				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
@@ -1509,7 +1510,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
-				     &job);
+				     &job,
+				     AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA);
 	if (r)
 		goto out;
 
@@ -2159,7 +2161,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 				  struct dma_resv *resv,
 				  bool vm_needs_flush,
 				  struct amdgpu_job **job,
-				  bool delayed)
+				  bool delayed, u64 k_job_id)
 {
 	enum amdgpu_ib_pool_type pool = direct_submit ?
 		AMDGPU_IB_POOL_DIRECT :
@@ -2169,7 +2171,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 						    &adev->mman.high_pr;
 	r = amdgpu_job_alloc_with_ib(adev, entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
-				     num_dw * 4, pool, job);
+				     num_dw * 4, pool, job, k_job_id);
 	if (r)
 		return r;
 
@@ -2208,7 +2210,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
-				   resv, vm_needs_flush, &job, false);
+				   resv, vm_needs_flush, &job, false,
+				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
 	if (r)
 		return r;
 
@@ -2243,7 +2246,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 			       uint64_t dst_addr, uint32_t byte_count,
 			       struct dma_resv *resv,
 			       struct dma_fence **fence,
-			       bool vm_needs_flush, bool delayed)
+			       bool vm_needs_flush, bool delayed,
+			       u64 k_job_id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned int num_loops, num_dw;
@@ -2256,7 +2260,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
-				   &job, delayed);
+				   &job, delayed, k_job_id);
 	if (r)
 		return r;
 
@@ -2326,7 +2330,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 			goto err;
 
 		r = amdgpu_ttm_fill_mem(ring, 0, addr, size, resv,
-					&next, true, true);
+					&next, true, true,
+					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
 		if (r)
 			goto err;
 
@@ -2345,7 +2350,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			uint32_t src_data,
 			struct dma_resv *resv,
 			struct dma_fence **f,
-			bool delayed)
+			bool delayed,
+			u64 k_job_id)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
@@ -2374,7 +2380,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			goto error;
 
 		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
-					&next, true, delayed);
+					&next, true, delayed, k_job_id);
 		if (r)
 			goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 208b7d1d8a27..57a1e0b7c1e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -180,7 +180,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			uint32_t src_data,
 			struct dma_resv *resv,
 			struct dma_fence **fence,
-			bool delayed);
+			bool delayed,
+			u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 74758b5ffc6c..5c38f0d30c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1136,7 +1136,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     64, direct ? AMDGPU_IB_POOL_DIRECT :
-				     AMDGPU_IB_POOL_DELAYED, &job);
+				     AMDGPU_IB_POOL_DELAYED, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b9060bcd4806..ce318f5de047 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -449,7 +449,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -540,7 +540,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4,
 				     direct ? AMDGPU_IB_POOL_DIRECT :
-				     AMDGPU_IB_POOL_DELAYED, &job);
+				     AMDGPU_IB_POOL_DELAYED, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 1991dd3d1056..9fc0f7ff6c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -600,7 +600,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     64, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		goto err;
 
@@ -780,7 +780,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		goto err;
 
@@ -910,7 +910,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -977,7 +977,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ce52b4d75e94..a33b177e1d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -965,7 +965,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	params.vm = vm;
 	params.immediate = immediate;
 
-	r = vm->update_funcs->prepare(&params, NULL);
+	r = vm->update_funcs->prepare(&params, NULL,
+				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
 	if (r)
 		goto error;
 
@@ -1134,7 +1135,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		dma_fence_put(tmp);
 	}
 
-	r = vm->update_funcs->prepare(&params, sync);
+	r = vm->update_funcs->prepare(&params, sync,
+				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
 	if (r)
 		goto error_free;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..c1a3257463d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -309,7 +309,7 @@ struct amdgpu_vm_update_params {
 struct amdgpu_vm_update_funcs {
 	int (*map_table)(struct amdgpu_bo_vm *bo);
 	int (*prepare)(struct amdgpu_vm_update_params *p,
-		       struct amdgpu_sync *sync);
+		       struct amdgpu_sync *sync, u64 k_job_id);
 	int (*update)(struct amdgpu_vm_update_params *p,
 		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 0c1ef5850a5e..22e2e5b47341 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -40,12 +40,14 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
  *
  * @p: see amdgpu_vm_update_params definition
  * @sync: sync obj with fences to wait on
+ * @k_job_id: the id for tracing/debug purposes
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
-				 struct amdgpu_sync *sync)
+				 struct amdgpu_sync *sync,
+				 u64 k_job_id)
 {
 	if (!sync)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 30022123b0bf..f794fb1cc06e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_job.h"
 
 /*
  * amdgpu_vm_pt_cursor - state for for_each_amdgpu_vm_pt
@@ -395,7 +396,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.vm = vm;
 	params.immediate = immediate;
 
-	r = vm->update_funcs->prepare(&params, NULL);
+	r = vm->update_funcs->prepare(&params, NULL,
+				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
 	if (r)
 		goto exit;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 46d9fb433ab2..36805dcfa159 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -40,7 +40,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *table)
 
 /* Allocate a new job for @count PTE updates */
 static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
-				    unsigned int count)
+				    unsigned int count, u64 k_job_id)
 {
 	enum amdgpu_ib_pool_type pool = p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
 		: AMDGPU_IB_POOL_DELAYED;
@@ -56,7 +56,7 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
 	ndw = min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
 
 	r = amdgpu_job_alloc_with_ib(p->adev, entity, AMDGPU_FENCE_OWNER_VM,
-				     ndw * 4, pool, &p->job);
+				     ndw * 4, pool, &p->job, k_job_id);
 	if (r)
 		return r;
 
@@ -69,16 +69,17 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
  *
  * @p: see amdgpu_vm_update_params definition
  * @sync: amdgpu_sync object with fences to wait for
+ * @k_job_id: identifier of the job, for tracing purpose
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
-				  struct amdgpu_sync *sync)
+				  struct amdgpu_sync *sync, u64 k_job_id)
 {
 	int r;
 
-	r = amdgpu_vm_sdma_alloc_job(p, 0);
+	r = amdgpu_vm_sdma_alloc_job(p, 0, k_job_id);
 	if (r)
 		return r;
 
@@ -249,7 +250,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			if (r)
 				return r;
 
-			r = amdgpu_vm_sdma_alloc_job(p, count);
+			r = amdgpu_vm_sdma_alloc_job(p, count,
+						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 1c07b701d0e4..ceb94bbb03a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -217,7 +217,8 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -281,7 +282,8 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 9d237b5937fb..1f8866f3f63c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -225,7 +225,8 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, u32 handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -288,7 +289,8 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, u32 handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 79251f22b702..683ff02c45af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -68,7 +68,8 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t npages,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
 				     AMDGPU_IB_POOL_DELAYED,
-				     &job);
+				     &job,
+				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
 	if (r)
 		return r;
 
-- 
2.43.0

