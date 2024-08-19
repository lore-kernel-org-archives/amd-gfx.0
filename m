Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D53C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 17:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BBA10E33C;
	Mon, 19 Aug 2024 17:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ny9HPenD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7369010E33C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 17:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HftpA3kWEEq2q/R3R4crX0kHkD8tJ70UM7ABfTfSnf/u8mcw3tDIL9YWbe0ijuvUawIG+GNXI6v28oD5h1WTccdDeokuo1fvKJHem5tRNXKvbBw75j5J/k+jcgOGNlcMwLxQ89z/uYWrFlcxGbSjpAaijXkKYQJrWyZoYSIriOaIJfKbJ+qbtrPk8bAyu3I+wmUHiFRQ8bhyZUmlvS7TIjAecjicX5zlicglx4hjFNa8Y7ZTGtqVCDHiBkZsM1iUW6erOV+ih3gCRt/fv1TrOzLK6NT2N0jVdgoPlatBlZtJUiF4DokS5z1DvDP9jO3EAZAl7f5PCcU3opMRpvWesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBxL3hnfF4d3B46mmpZ2cYXtSKP/2nR1xTb3dO0tnS4=;
 b=mJU+ZT3XEJ4dwuqEZpiSLg7WZHEerw03r/xoRbW90armZw95u10E0g1c212SGx+j6bdq9Z8v7aZorc443F+8SA9+7kiD8tw+9i34GwX9itLvQRLrYzNq+tAKE+5r3A/IOm0STPdqw2pN1mfib56Umr5cE6u/4EMRvI7jb6Qs7osK5vJrbEHFZh95m07PYsCV8v1m/a+CfqdrJntH+2JmOYLDEQfCFh9v3gr0oT4J7hnQnow3f0mF4EoXj7HNqlwiYnAEkvnJsvyg5RtsNEPjgywJsNXTKkAImPmwnfZYtQOOw6gZeqxPWAHvkVTx+mRELBVzxZrdXgwzqjaHBlODQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBxL3hnfF4d3B46mmpZ2cYXtSKP/2nR1xTb3dO0tnS4=;
 b=Ny9HPenDeIf0r7WplCHgQ8xqfdFPDGdJjcl3wMIZTKmEzLi3OiQvlx0IH35TLWEAAR5p2jgsvpH/XzML+09DeGPUJHJO+YxTQQ7ChLnruaeoxUcjM7DWHJy5wqpem5LFCD1nZd034pBp1nJi326l/eSORJw4+70X9BR3tMt4qZQ=
Received: from MN2PR17CA0013.namprd17.prod.outlook.com (2603:10b6:208:15e::26)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:59:43 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:15e:cafe::98) by MN2PR17CA0013.outlook.office365.com
 (2603:10b6:208:15e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 17:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Mon, 19 Aug 2024 17:59:43 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 12:59:42 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <Mukul.Joshi@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix vm-pasid lookup for multiple partitions
Date: Mon, 19 Aug 2024 13:59:35 -0400
Message-ID: <20240819175935.4014241-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: da47536d-388d-4494-771a-08dcc078b449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yao0OEttV+Ghgxda055g0ofzr4KwPeNwURkv2dQAZo2zKARMMoH/CT+Sjpde?=
 =?us-ascii?Q?o9bqVAKHMvNWphzPg8xpVEPbKxY7tF/bE9qU88cHdsmKba4k4kufD1MmOdHT?=
 =?us-ascii?Q?y6jssd9/T2gAwASGfMRDmfwmGhXQqTa78DbsXu8PMkrJUoJcVkLQM3NaF0Vj?=
 =?us-ascii?Q?kQNI6EWSeZTLe7dn8ZIAO/asG4SY2OvRBzp58p6OyeGrbaWcSYgXcnSRJRnI?=
 =?us-ascii?Q?Wnqd+YVtwPfCcDWHil/rodvajf9VP5HH6lNe+FuiQvHVcLo2H11r4oyR1tzH?=
 =?us-ascii?Q?QuvcvG+RgngqWeacaSoPL26y3jxnwG/vZRXFibHYs2BChKoA0UK1b8p+BOm/?=
 =?us-ascii?Q?jiGOl1BvrBRCvtGu6CpfJ8kApt7o35IAZCKqsFWJGYxZeo3xHYzMIhv8ArKI?=
 =?us-ascii?Q?UNqqVLePvomvwUoGtc3rZft0Y6+sRDuEeMGqiBorFMvvC/voBLN1ryg8k375?=
 =?us-ascii?Q?q+3h675kfaOlOadke5jh5069rNa2X7yXbTd+xEEsl0ay4jJfAUCSoexugjZA?=
 =?us-ascii?Q?DEdxJqaPp2taWyjE66uLB2K4VNoRgxUejItSt4Wjah7OLRC9OdRV+f9s5O3b?=
 =?us-ascii?Q?Wo043A6OSzo4IrAyy+iY0jOruxXxgbStm+LtBfpqhPv0XryWBeHaoIVsLtuj?=
 =?us-ascii?Q?ZmemkU8/udP1GuLnMIVdip4mRKoHxdgn/Z0hq2pH8Kp7yL5a14D2djOYUCPA?=
 =?us-ascii?Q?3zR23bWb1kTUfXLjhL9lPPI/C8JH1W66hpEJBpN4cOdo6tgteVstsv/5qRe/?=
 =?us-ascii?Q?31h7T77RVPDaDePxcBh6FA0bYJfNhJKd4ayMTvfY4C09mGnyXoup/qgvZqeh?=
 =?us-ascii?Q?rvQ7cZPGaTzwvk86f0a4NqYjN+rZTcF6A9nWw8xCyvc1+ddhyzHLgJYwpAVk?=
 =?us-ascii?Q?5AVI8Ra8/yc3rPpLF42USEoH81h6Xs777uwKvadUsEhO2qH0h3TEjI4QkgNN?=
 =?us-ascii?Q?NSynyT5pB8ThuHeP/3wyCNWCcz5AIqXJfzeD9Xtysx8rjoAOHsNq9rizBbGv?=
 =?us-ascii?Q?IexI+xZwk/Ft8ohn05vFB5BBDFVgu9PHd+XtkSaNKPyM+vRCO7jfiHH5ShYR?=
 =?us-ascii?Q?wIRb201OFxQGZ2kG2PRlyC6UYSHv3dp95sMnJRGSVqxRwTlkr1YL2B8QJOx9?=
 =?us-ascii?Q?MlFeO2YqxVDJNxOpeSFSonkppcAUzg78f7HEXMJrGQEPO/o6/jE4NP0lAFPn?=
 =?us-ascii?Q?kdtJkp5061gz1vljS1C7KB5S/iW+Mz8lC0UX8S0vGuTn+TkxBxYYbUvxKKjH?=
 =?us-ascii?Q?Rq8YUdGy/X4pOizUb+aUty3w5EzN0PyS18ntjrRx4DO0GeNc80KMZbGri+Vx?=
 =?us-ascii?Q?GpjgAa5WzxULzlYuT7haJSVBOTTBQpkQ9v1dZ8HGoNyE9cQN+sZzYXBdXji/?=
 =?us-ascii?Q?8mDOdEBgjIJbh2Yq9JtwNmFKqZy2g+zelnzj9SYHlbfvSrtmS1UN1oCXOKU1?=
 =?us-ascii?Q?bkdqthSVj8J1Pi6r3Z8WRppgWLbc/gyg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:59:43.2464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da47536d-388d-4494-771a-08dcc078b449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

Currently multiple partitions will incorrectly overwrite the VM lookup
table since the table is indexed by PASID and multiple partitions can
register different VM objects on the same PASID.

This results in loading the wrong VM object on PASID query.

To correct this, setup the lookup table to be per-partition-per-PASID
instead.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 55 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 11 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 16 ++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  |  8 +--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  8 +--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  3 +-
 18 files changed, 92 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c272461d70a9..28db789610e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -887,3 +887,15 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 
 	return r;
 }
+
+int amdgpu_amdkfd_node_id_to_xcc_id(struct amdgpu_device *adev, uint32_t node_id)
+{
+	if (adev->gfx.funcs->ih_node_to_logical_xcc) {
+		int xcc_id = adev->gfx.funcs->ih_node_to_logical_xcc(adev, node_id);
+
+		if (xcc_id >= 0)
+			return xcc_id;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4ed49265c764..bf8bb45d8ab6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -356,6 +356,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 
 u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
+int amdgpu_amdkfd_node_id_to_xcc_id(struct amdgpu_device *adev, uint32_t node_id);
 
 #define KFD_XCP_MEM_ID(adev, xcp_id) \
 		((adev)->xcp_mgr && (xcp_id) >= 0 ?\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c6a1783fc9ef..bf9f8802e18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -37,7 +37,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	int idx;
+	int idx, xcp_id = !job->vm ? 0 : job->vm->xcp_id;
 	int r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -62,7 +62,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
 		ring->fence_drv.sync_seq);
 
-	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
+	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid, xcp_id);
 	if (ti) {
 		dev_err(adev->dev,
 			"Process information: process %s pid %d thread %s pid %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d9fde38f6ee2..e413bf4a3e84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1275,17 +1275,20 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		struct amdgpu_vm *vm = &fpriv->vm;
 		struct drm_amdgpu_info_gpuvm_fault gpuvm_fault;
 		unsigned long flags;
+		int i;
 
 		if (!vm)
 			return -EINVAL;
 
 		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
 
-		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+		for (i = 0; i < adev->xcp_mgr->num_xcps; i++)
+			xa_lock_irqsave(&adev->vm_manager.pasids[i], flags);
 		gpuvm_fault.addr = vm->fault_info.addr;
 		gpuvm_fault.status = vm->fault_info.status;
 		gpuvm_fault.vmhub = vm->fault_info.vmhub;
-		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+		for (i = 0; i < adev->xcp_mgr->num_xcps; i++)
+			xa_unlock_irqrestore(&adev->vm_manager.pasids[i], flags);
 
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bcb729094521..f43e1c15f423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -146,7 +146,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return 0;
 
 	if (vm->pasid) {
-		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
+		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids[vm->xcp_id], vm->pasid));
 		if (r < 0)
 			return r;
 
@@ -154,7 +154,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	if (pasid) {
-		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
+		r = xa_err(xa_store_irq(&adev->vm_manager.pasids[vm->xcp_id], pasid, vm,
 					GFP_KERNEL));
 		if (r < 0)
 			return r;
@@ -2288,14 +2288,14 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
 }
 
 static inline struct amdgpu_vm *
-amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
+amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid, u32 xcp_id)
 {
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], flags);
+	vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], flags);
 
 	return vm;
 }
@@ -2343,10 +2343,10 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
  * referenced down with amdgpu_vm_put_task_info.
  */
 struct amdgpu_task_info *
-amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid, u32 xcp_id)
 {
 	return amdgpu_vm_get_task_info_vm(
-			amdgpu_vm_get_vm_from_pasid(adev, pasid));
+			amdgpu_vm_get_vm_from_pasid(adev, pasid, xcp_id));
 }
 
 static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
@@ -2481,6 +2481,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
 
+	vm->xcp_id = xcp_id < 0 ? 0 : xcp_id;
+
 	return 0;
 
 error_free_root:
@@ -2695,8 +2697,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
-
-	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+	for (i = 0; i < MAX_XCP; i++)
+		xa_init_flags(&(adev->vm_manager.pasids[i]), XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -2708,10 +2710,15 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
-	xa_destroy(&adev->vm_manager.pasids);
+	int i;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		WARN_ON(!xa_empty(&adev->vm_manager.pasids[i]));
+		xa_destroy(&adev->vm_manager.pasids[i]);
+	}
 
 	amdgpu_vmid_mgr_fini(adev);
+
 }
 
 /**
@@ -2778,17 +2785,18 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	unsigned long irqflags;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
-	int r;
+	int r, xcp_id;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	xcp_id = amdgpu_amdkfd_node_id_to_xcc_id(adev, node_id)/adev->gfx.num_xcc_per_xcp;
+	xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], irqflags);
+	vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
 	if (vm) {
 		root = amdgpu_bo_ref(vm->root.bo);
 		is_compute_context = vm->is_compute_context;
 	} else {
 		root = NULL;
 	}
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], irqflags);
 
 	if (!root)
 		return false;
@@ -2806,11 +2814,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unref;
 
 	/* Double check that the VM still exists */
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], irqflags);
+	vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
 	if (vm && vm->root.bo != root)
 		vm = NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], irqflags);
 	if (!vm)
 		goto error_unlock;
 
@@ -2968,14 +2976,15 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  unsigned int pasid,
 				  uint64_t addr,
 				  uint32_t status,
-				  unsigned int vmhub)
+				  unsigned int vmhub,
+				  uint32_t xcp_id)
 {
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], flags);
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
 	/* Don't update the fault cache if status is 0.  In the multiple
 	 * fault case, subsequent faults will return a 0 status which is
 	 * useless for userspace and replaces the useful fault status, so
@@ -3008,7 +3017,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
 		}
 	}
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], flags);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 046949c4b695..1499f5f731e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -35,6 +35,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
 #include "amdgpu_ids.h"
+#include "amdgpu_xcp.h"
 
 struct drm_exec;
 
@@ -418,6 +419,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* XCP ID */
+	int xcp_id;
 };
 
 struct amdgpu_vm_manager {
@@ -456,7 +460,7 @@ struct amdgpu_vm_manager {
 	/* PASID to VM mapping, will be used in interrupt context to
 	 * look up VM of a page fault
 	 */
-	struct xarray				pasids;
+	struct xarray				pasids[MAX_XCP];
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
 };
@@ -550,7 +554,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
 struct amdgpu_task_info *
-amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid, u32 xcp_id);
 
 struct amdgpu_task_info *
 amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
@@ -649,7 +653,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  unsigned int pasid,
 				  uint64_t addr,
 				  uint32_t status,
-				  unsigned int vmhub);
+				  unsigned int vmhub,
+				  uint32_t xcp_id);
 void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
 				 struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f0ceab3ce5bf..24b042febf5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -151,7 +151,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
-					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0),
+					     0);
 	}
 
 	if (!printk_ratelimit())
@@ -161,7 +162,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 		entry->vmid_src ? "mmhub" : "gfxhub",
 		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
-	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
 	if (task_info) {
 		dev_err(adev->dev,
 			" in process %s pid %d thread %s pid %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2797fd84432b..3507046d33e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -122,7 +122,8 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
-					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0),
+					     0);
 	}
 
 	if (printk_ratelimit()) {
@@ -132,7 +133,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 			entry->vmid_src ? "mmhub" : "gfxhub",
 			entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
-		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
 		if (task_info) {
 			dev_err(adev->dev,
 				" in process %s pid %d thread %s pid %d)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 60acf676000b..9844564c6c74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -115,7 +115,8 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
-					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0),
+					     0);
 	}
 
 	if (printk_ratelimit()) {
@@ -125,7 +126,7 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 			entry->vmid_src ? "mmhub" : "gfxhub",
 			entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
-		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
 		if (task_info) {
 			dev_err(adev->dev,
 				" in process %s pid %d thread %s pid %d)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 994432fb57ea..2cdb0cbb7c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1268,7 +1268,8 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_update_fault_cache(adev, entry->pasid,
-				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
+				     AMDGPU_GFXHUB(0), 0);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v7_0_set_fault_enable_default(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 86488c052f82..6855caeb7f74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1437,7 +1437,8 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_update_fault_cache(adev, entry->pasid,
-				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
+				     AMDGPU_GFXHUB(0), 0);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v8_0_set_fault_enable_default(adev, false);
@@ -1448,7 +1449,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
 			entry->src_id, entry->src_data[0]);
 
-		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
 		if (task_info) {
 			dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
 				task_info->process_name, task_info->tgid,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b73136d390cc..e183e08b2c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -556,10 +556,12 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	unsigned int vmhub;
 	u64 addr;
 	uint32_t cam_index = 0;
-	int ret, xcc_id = 0;
-	uint32_t node_id;
+	int ret;
+	uint32_t node_id, xcc_id, xcp_id;
 
 	node_id = entry->node_id;
+	xcc_id = amdgpu_amdkfd_node_id_to_xcc_id(adev, node_id);
+	xcp_id = xcc_id/adev->gfx.num_xcc_per_xcp;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
@@ -572,12 +574,6 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		vmhub = AMDGPU_MMHUB1(0);
 	} else {
 		hub_name = "gfxhub0";
-		if (adev->gfx.funcs->ih_node_to_logical_xcc) {
-			xcc_id = adev->gfx.funcs->ih_node_to_logical_xcc(adev,
-				node_id);
-			if (xcc_id < 0)
-				xcc_id = 0;
-		}
 		vmhub = xcc_id;
 	}
 	hub = &adev->vmhub[vmhub];
@@ -631,7 +627,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		retry_fault ? "retry" : "no-retry",
 		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
 
-	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, xcp_id);
 	if (task_info) {
 		dev_err(adev->dev,
 			" for process %s pid %d thread %s pid %d)\n",
@@ -675,7 +671,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!amdgpu_sriov_vf(adev))
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
+	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub, xcp_id);
 
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 23ef4eb36b40..1ac4224bbe5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2182,7 +2182,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 			   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
 			   entry->pasid);
 
-	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
 	if (task_info) {
 		dev_dbg_ratelimited(adev->dev,
 				    " for process %s pid %d thread %s pid %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 57f16c09abfc..c8b5c0302ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1683,6 +1683,8 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	int instance;
 	struct amdgpu_task_info *task_info;
 	u64 addr;
+	uint32_t xcc_id = amdgpu_amdkfd_node_id_to_xcc_id(adev, entry->node_id);
+	uint32_t xcp_id = xcc_id/adev->gfx.num_xcc_per_xcp;
 
 	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
@@ -1698,7 +1700,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 			    instance, addr, entry->src_id, entry->ring_id, entry->vmid,
 			    entry->pasid);
 
-	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, xcp_id);
 	if (task_info) {
 		dev_dbg_ratelimited(adev->dev, " for process %s pid %d thread %s pid %d\n",
 				    task_info->process_name, task_info->tgid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ea3792249209..c098fbaf0e1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1262,8 +1262,9 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 
 		if (dev->dqm->detect_hang_count) {
 			struct amdgpu_task_info *ti;
+			uint32_t xcp_id = dev->xcp ? dev->xcp->id : 0;
 
-			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
+			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid, xcp_id);
 			if (ti) {
 				dev_err(dev->adev->dev,
 					"Queues reset on process %s tid %d thread %s pid %d\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 8e0d0356e810..d7cbf9525698 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -377,12 +377,8 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		struct kfd_hsa_memory_exception_data exception_data;
 
 		/* gfxhub */
-		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
-				node_id);
-			if (hub_inst < 0)
-				hub_inst = 0;
-		}
+		if (!vmid_type)
+			hub_inst = amdgpu_amdkfd_node_id_to_xcc_id(dev->adev, node_id);
 
 		/* mmhub */
 		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index a9c3580be8c9..4708b8c811a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -437,12 +437,8 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		struct kfd_hsa_memory_exception_data exception_data;
 
 		/* gfxhub */
-		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
-				node_id);
-			if (hub_inst < 0)
-				hub_inst = 0;
-		}
+		if (!vmid_type)
+			hub_inst = amdgpu_amdkfd_node_id_to_xcc_id(dev->adev, node_id);
 
 		/* mmhub */
 		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index ea6a8e43bd5b..b5f2f5b1069c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -251,8 +251,9 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 {
 	struct amdgpu_task_info *task_info;
+	uint32_t xcp_id = dev->xcp ? dev->xcp->id : 0;
 
-	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid, xcp_id);
 	if (task_info) {
 		/* Report VM faults from user applications, not retry from kernel */
 		if (task_info->pid)
-- 
2.34.1

