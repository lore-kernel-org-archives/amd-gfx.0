Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96440C4450A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3219210EE0C;
	Tue, 14 Jul 2026 15:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2QrlhNK";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E21F10EE0C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm0qFij5EQC83AbyS+tyPJFjZ9d7FDJMBoGUDA4QoEZ3iBZxVOFYx3C+v/ncoyEbCbJrpJxBmll+mSuFmzu6rY584ukz0rMdcZSZ75P791kGdxEGTYfMNBaLYmeBFJjdAJILjlrpt8GrUcQ3GjD6l52Po2+aVKNv4uATGNmECJxPThzU8xHQmuuBc8FM829y/XPp2DhjKAaARzNG8dGIzcty01kbh8hGTLHjjcg+Bf1unBdG77VHyQfVUKgFtoEa2gAFR45trdvNUm97q4Aj0NpEQsiUn2FpR3pgGnoFtkWlEOhy25I+k+jXpQbhFu/yD6Ivxt7siPMCVjh6KC3G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0+YCj5Bg7TajHugkscKDD8SL2p+fM2o6EgVHvsgilU=;
 b=rFL/ficgipLbpQVJCIjT6hB6HNL1fUCYCDpxKzP1u+WAOCq8PdKDr6F/O1m1asvFi0B+B2sq719oxaeEJDHiVs8tRiKL/qlBgVECA13jubyf942Yy7wDh+whu5zWWYwOPXrXnkqyYEmKLLlCnkkYiSuUBPcM3Kk47QjtTkDA22MiHqoJDgi7woQRN/vHu6ZpbluB2cmBMoetf8X3y1nRSN3zlVrTHeAE6XFlU33BVBdy4nk03nq+KJQtBKiX4HDkWIF+C3Q2cMFFzvycAkcOUXTQUOpTD+2xRr30G0Wh7INFlrkufAg/XrPfy8n/tjaZxzqNOXomtKVdcdtzB35czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0+YCj5Bg7TajHugkscKDD8SL2p+fM2o6EgVHvsgilU=;
 b=O2QrlhNKdYkbxSNKvPk1osAzaEz8IadladhHj7ln4YyLpROyqx0zqJjmCsJbuHE2F4QteNgR//gIU74RMbBGOug9sD9JOXqQ4P6XB36X+Ob1M9DXDNddhI0X9f7WUxWmZrO26Zj975tK6cOMNpnuxayIvWlOzjcwqSKMTqDa3kk=
Received: from PH8P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::24)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Tue, 14 Jul 2026 15:55:25 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:2db:cafe::2f) by PH8P223CA0019.outlook.office365.com
 (2603:10b6:510:2db::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 15:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 15:55:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 10:55:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 10:55:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 10:55:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Prike Liang <Prike.Liang@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: [PATCH V2] drm/amdgpu: properly account for resets with user queues
Date: Tue, 14 Jul 2026 11:55:16 -0400
Message-ID: <20260714155516.684775-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e640d4c-1fc8-43a3-fc1f-08dee1c05141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: WLmZpHP3K2ZithzIfDgX0voA0xT+xK7M8ljx2yB5DtZAlOPS3vy1cXR8fCJUMKn/p1FDXhGfBs0Ga5Ahf9D9+nAesA2hPlgJhiI+rND6PBAIHtUSKKbpPfrAOKawVcl24ie0yyC35t5sou/1ziG02BrWuJKqcmQRjWoKRKXDbbbnawdUPx1Q1kHl6yUwogqdJ3Q/C3x6Ks4NfuUWEqLwDuaFqB/5C4Q0mJ70y7eTVcwBPKBVrRFj3p1+oOo/yWWKc9Kzqdon0ufYLdKyocEC2RGx0h3cryiEKGcLizKOn3IMkp0d0FQHBmBFYVT5ONOeaIZ6ZnuPxkBnDs8vWgbpUOSPgF6kC90okalEcWM8gp3aUAXFMbyTqcv2CWmUQiRd3a9pPfGzixJQUznapm6wX0Qnn5rLwBICiSUsxZgvF83jtT8YobzJLlfvrhlyx+AJw+zpBf8vRSIjaeGdn3Mmrtl8Sbs2jesRD+PWSumEUrp/E5nzmD5igPMcLYc/69+jZRJleGctQmAdpMCKddweXCdE8c7HReK2yrwgLJftkVu+AsX2fM/S+9YQsrFljnLZsuwaErB6BP/JfTDH024M3vMX9iI/r+q9zQBm7mUVmDf4XYNsxwMO4B2fNrzyVChfeyJcfuDg9hCdMSrSefQGffihMisgfhDue3BJLmfXddsIXlLVz/eXVKMY9zDGOD048e798UA8UkB21dcsoFoxoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HnSvw6k5W8gLTjficNl3heImIPfv7krKF6v6gMR4yxQnsHQ9cOV+nlfShGfPBRKCDUWUyix2z/hyFiK/w1clvysA5Pv6PacfRcutuQEiR+v8BPAXF87uX4hoRO1vpdrSKaFiaFEGG29VQ0xUQURSK6dUJSLepa+8LL5EnEgHMwoczd0zPMqWkk8UQtlp5t9erdXaIXi9Yd/cgI/7hQofyVzcVL1zJMlJX0vZsZeha6ebKOM5jGhRQK/C29TB67WLl2SyJe26X53zEZDZp6eVlifeChzjwH6588myr5ilFz1RCu7agUXPkkFSCHC6RcLKrfciL5s9uI1YcdsGPVKNOoJJHqStQzemyvsGJhA/k1icgNQRAEU8JzmKk2ToSI0BPGs668LhFBDJDYhDFQINtT6nj+VS0zwBAHY3nmJ/jNsyGUNDeb+8vr48N+M2vgkY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:55:24.5177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e640d4c-1fc8-43a3-fc1f-08dee1c05141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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

We need to increment the reset counter, force fence completion,
and set the wedged event when a user queue is reset, but only
for the guilty queue.  We don't want additional events for
collateral damage.

Only increment the reset counter and set the wedged event
in the top level userq reset callers (both KGD and KFD).
This aligns with how this is managed for kernel queue resets.

v2: fix task info refcount handling, align with
    kfd error reporting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Lazar, Lijo <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c     |  2 --
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 17 ++++++++++++++++-
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6aa75da27f912..58754fc41bb6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -123,6 +123,8 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	struct drm_wedge_task_info *info = NULL;
+	struct amdgpu_task_info *ti = NULL;
 	bool gpu_reset = false;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
@@ -137,6 +139,14 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	if (!amdgpu_gpu_recovery)
 		return;
 
+	if (queue->vm && queue->vm->pasid) {
+		ti = amdgpu_vm_get_task_info_pasid(adev, queue->vm->pasid);
+		if (ti) {
+			amdgpu_vm_print_task_info(adev, ti);
+			info = &ti->task;
+		}
+	}
+
 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
@@ -146,11 +156,17 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
-		if (r)
+		if (r) {
 			gpu_reset = true;
+		} else {
+			atomic_inc(&adev->gpu_reset_counter);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+		}
 	} else {
 		gpu_reset = true;
 	}
+	amdgpu_vm_put_task_info(ti);
 
 	/*
 	 * Don't schedule the work here! Scheduling or queue work from one reset
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d3d79bbaf9eb7..a1371a9f961d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -234,9 +234,7 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 				r = mes_userq_unmap(uq);
 				if (r)
 					return r;
-				atomic_inc(&adev->gpu_reset_counter);
 				amdgpu_userq_fence_driver_force_completion(uq);
-				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0419fe869d4b0..58ccbf955f287 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -448,6 +448,9 @@ int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	struct drm_wedge_task_info *info = NULL;
+	struct amdgpu_task_info *ti = NULL;
+	struct kfd_process_device *pdd;
 	unsigned int num_hung = 0;
 	int r = 0;
 	struct mes_remove_queue_input queue_input;
@@ -476,13 +479,25 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung, &queue_input);
 	if (r)
 		goto fail;
+	pdd = kfd_get_process_device_data(q->device, q->process);
+	if (pdd) {
+		ti = amdgpu_vm_get_task_info_pasid(adev, pdd->pasid);
+		if (ti) {
+			amdgpu_vm_print_task_info(adev, ti);
+			info = &ti->task;
+		}
+	}
 
 	dqm->detect_hang_count = num_hung;
 	/* When MES doesn't detect any queue hang, no reset happens. Don't signal reset
 	 * event.
 	 */
-	if (dqm->detect_hang_count)
+	if (dqm->detect_hang_count) {
 		kfd_signal_reset_event(dqm->dev);
+		atomic_inc(&adev->gpu_reset_counter);
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+	}
+	amdgpu_vm_put_task_info(ti);
 
 fail:
 	dqm->detect_hang_count = 0;
-- 
2.55.0

