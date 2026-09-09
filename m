Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5433C79FAA
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 07:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604C910EF86;
	Wed,  9 Sep 2026 07:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNqaTDQT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761C610EF86
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 07:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZcSXfE7znQk+O8kQOPYsehcS2USfHVfXzqIvG33Ji7Gi6X2k5Qeu9GDabvA4P5kCItg9k3GjuWqwvp0JZoj9/ZPetpT35/brhVmD/za9Ojmyp0sEgbiFpFP69nhZ3BgDqycofNfLCTmjt3m+KVFgjctoVm/lX2qcgUp8oo8lmgO4BtXVGPmPg3NtgoDs9BWXcVH2OXgYydvoz1gxhU7ryfXoAdCUDW2299wKvcm4L8tYdQMw8f2rZJKU1OvuciiwFatAuI6Mk9u3MpBOipuVUyNJdoZ150CJJpuqiDfQNSWigY0Go6uHyFlNlAr7G96L+Eol03fqAG0Nq8+rCX4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02yhlGSwQGGFShJ0Cd2hYa2xYT7fkzMx6pce5H4EGFI=;
 b=IlOH56A1UBEm3KlAAHqZeJV4PZB0Akla8VdhmVfej9PiANaz4MAObSiW8+2sH8efjCxaIjqmuRZSPPUWkCvThJinaMXbCBL4NiDXV5XDDNB+oO5Jo4cC4ugsRQeZd9eizPG0tck0X+kCA+rcfQcD90Nr+VtH4aKiTvykgEn7z0mOnXAe9Xizne0vH3AIinuj30Sc5W60b1w+Rp83RNsjcgjNquqj4o/lRwAzJZjVUX/YpI5dXzjW4EUnvF32wJgEb9YQ3m9IZ2CpyQWdavWZ86I0faZR7dAB1e0YTyn+OOlopQFPSDURHIoqvVlFfPLMK/Qr8zLpZhPD2oJjkQ3b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02yhlGSwQGGFShJ0Cd2hYa2xYT7fkzMx6pce5H4EGFI=;
 b=WNqaTDQTrg2J4m3v3ORM7uz9/7fSxy/JFVMJEu9XQ1i2kNxlU1aKPxf0kAzqEgd2BiJsZvvYxY6PdKdUgK111Jce6ZotFSeDyqeVcKFjqeUJFu10KVOdjwPtVd73I4dlhEE/WQHtGaw9Jk2LKNOv4CXgcrqsDSUGA9NewF/FYqM=
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 07:51:41 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::8e) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 07:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 07:51:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 02:51:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <mukul.joshi@amd.com>, <Xiang.Liu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
Date: Wed, 9 Sep 2026 13:21:20 +0530
Message-ID: <20260909075121.598208-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a15d30-1653-4139-8ce2-08df0e472f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RHE6l/Ydxg7s3fJWD+32//6QhWxBQvtD+pzoCj+gDQCPbV+HxtqwFSW/CrGfS3JuyGuWw0gsfrZueGzFAAw9/C9GhUv5s4wiZWK+iNRKnHC/6I5OsyMwVlNycOkL1Z0ajsmP3mn8K8rB1WOZb1s4VG2PECtP32bthPldhMvcZ79yWi70C7vFBhLbxGuFjFchCiknIQfYzU1+Xx5NWo98I5yxLME9fkyBQ7RTvLwbgvCIkoqhy00dX2rmHSxWDkDBkueJFraT5sW79DrN70aUujno4yeTryrE8WTLhm6YLi5SyPpkvdOb63x8eatC9pOhG/PWGLuy+thKSJ/gIVn2gn/CBWx0/VOposuN4FVBnGzKGEW6i6KA/+BmQ2rtOAUy1xxQOV6iSs0G/UKNWwVB/8ayGHrmnp+vw+nRT1IpdD/sehWiOWyOr7641ZLLmM96K/TFOm2wG9wcliHu2LO4+q2+VH21xhmoql22aSm5DaIW3gqUmmRCxYllDTJTKsp9WoqrHTRBZZL2fo/uwFj5YQmxzIUO3vNTwCaSR9aIJpvbNvBlN1T7xLRvw/f+SsRMjsqOtWGI2kVyUqSOkfClI4AX/iNper1Oc6hLe1U3huxWI8EDX3ekissVtLQBAxE7REoL2EuwNrAx7m/Q0hbapEZbQ8LWuI8H1VzY9ZbJsTshYnhfRG7LhaccdcX4U3pnODxEVWoRh+NwVKxNb6ncrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J+j6flH6NFERyqZ3HlAanuOOnnQ6Cnu4xZqwVc93GEBxLsmLYbcwtOUVz4dH0Jy4+uk+RYuEPvG8CHNX8ZfuEBsmx84LGtO+iY507FYKU75nAtfEzJ7WldmIPAUZ2541cHvnDt3XrRv8/WaY6mzUceHrpxIew5JVShNDyo4i3IQDeT2Dg+03bNXeyHL/fa35hCNsOuw1LCJ99X+7UJajIqesHcZBMp0huAKMu1MlNX1BMmNnpyZZFrymjrj9ioYU/FzCdHHi0bfo/A5f9bJRooUVeJGxyyYCabQ7fyGMjfVCuOjugQ5pqQImR2lPmnTW31SB7ClkLCLh32Bl8W1pZEYcHsv4pD0J3E9bhZBzp0yMoTQZnNZNlMTUqnpfhJS+obuu0UZi6cJaP9xXH/K5fq8YuKS82awyG2vnNqjiDBHoTiwczxUtxK2Jz2qo+bno
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:51:40.9862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a15d30-1653-4139-8ce2-08df0e472f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

The compute partition switch locked the kfd device, freed it during the
pre-switch teardown, and then unlocked at the end - by which point
adev->kfd.dev referenced the newly reinitialized device, so the unlock
landed on the wrong object and the per-device lock was never balanced.

Add a dedicated prepare function to unwind and clean up kfd device.
Don't use the global lock during teardown. A new device is created after
partition switch; hence there is no need to do 'unlock' on a different
object after the switch.

User is not supposed to run any process on the device during partition
switch. Keep acquire/release semantics for init_complete so that the
device remains unavailable for a process till its reinitialization is
complete.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c      |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c   | 11 +----------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c        | 11 +----------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c      | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  6 ++++++
 7 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 09feb45584ba..a2a368f1e290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -245,6 +245,25 @@ void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev)
 	}
 }
 
+int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device *adev)
+{
+	struct kfd_dev *kfd = adev->kfd.dev;
+	int r;
+
+	if (!kfd)
+		return 0;
+	r = kgd2kfd_check_and_lock_kfd(kfd);
+	if (r)
+		return r;
+
+	adev->kfd.init_complete = false;
+	kgd2kfd_device_fini(kfd);
+	adev->kfd.dev = NULL;
+	amdgpu_amdkfd_total_mem_size -= adev->gmc.real_vram_size;
+
+	return 0;
+}
+
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		const void *ih_ring_entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1b7dc0d3963b..36e222f3ac5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -170,6 +170,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);
+int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device *adev);
 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
 void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);
 int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
@@ -431,6 +432,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
+void kgd2kfd_device_fini(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc);
 void kgd2kfd_suspend_process(struct kfd_dev *kfd);
@@ -485,6 +487,10 @@ static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 }
 
+static inline void kgd2kfd_device_fini(struct kfd_dev *kfd)
+{
+}
+
 static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
 {
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index a8c79a66df1d..92fa15ace438 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -694,14 +694,16 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 
 int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 {
+	int ret = 0;
+
 	/* TODO:
 	 * Stop user queues and threads, and make sure GPU is empty of work.
 	 */
 
 	if (flags & AMDGPU_XCP_OPS_KFD)
-		amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
+		ret = amdgpu_amdkfd_prepare_partition_switch(xcp_mgr->adev);
 
-	return 0;
+	return ret;
 }
 
 int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index cddfe4015f53..699e797679ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -391,15 +391,9 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		!adev->in_suspend)
 		flags |= AMDGPU_XCP_OPS_KFD;
 
-	if (flags & AMDGPU_XCP_OPS_KFD) {
-		ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
-		if (ret)
-			goto out;
-	}
-
 	ret = amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
 	if (ret)
-		goto unlock;
+		goto out;
 
 	num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
 	if (adev->gfx.funcs->switch_partition_mode)
@@ -413,9 +407,6 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
 	if (!ret)
 		__aqua_vanjaram_update_available_partition_mode(xcp_mgr);
-unlock:
-	if (flags & AMDGPU_XCP_OPS_KFD)
-		amdgpu_amdkfd_unlock_kfd(adev);
 out:
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 757da0a30fdc..28eca48c6596 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -1097,15 +1097,9 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
 		flags |= AMDGPU_XCP_OPS_KFD;
 
-	if (flags & AMDGPU_XCP_OPS_KFD) {
-		ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
-		if (ret)
-			goto out;
-	}
-
 	ret = amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
 	if (ret)
-		goto unlock;
+		goto out;
 
 	num_xcc_per_xcp = __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
 	if (adev->gfx.imu.funcs &&
@@ -1126,9 +1120,6 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
 	if (!ret)
 		__soc_v1_0_update_available_partition_mode(xcp_mgr);
-unlock:
-	if (flags & AMDGPU_XCP_OPS_KFD)
-		amdgpu_amdkfd_unlock_kfd(adev);
 out:
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 1c1e7878a2a7..76b308286095 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -952,7 +952,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_range_set_max_pages(kfd->adev);
 
-	kfd->init_complete = true;
+	/* Release pairs with the acquire in kfd_init_apertures(). */
+	smp_store_release(&kfd->init_complete, true);
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
 
@@ -977,7 +978,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	return kfd->init_complete;
 }
 
-void kgd2kfd_device_exit(struct kfd_dev *kfd)
+void kgd2kfd_device_fini(struct kfd_dev *kfd)
 {
 	if (kfd->init_complete) {
 		/* Cleanup KFD nodes */
@@ -991,6 +992,11 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	}
 
 	kfree(kfd);
+}
+
+void kgd2kfd_device_exit(struct kfd_dev *kfd)
+{
+	kgd2kfd_device_fini(kfd);
 
 	/* after remove a kfd device unlock kfd driver */
 	kgd2kfd_unlock_kfd(NULL);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 04c5e26f01ed..da61d939b35c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -396,6 +396,12 @@ int kfd_init_apertures(struct kfd_process *process)
 			continue;
 		}
 
+		/* acquire pairs with the release in kgd2kfd_device_init() */
+		if (!smp_load_acquire(&dev->kfd->init_complete)) {
+			id++;
+			continue;
+		}
+
 		pdd = kfd_create_process_device_data(dev, process);
 		if (!pdd) {
 			dev_err(dev->adev->dev,
-- 
2.49.0

