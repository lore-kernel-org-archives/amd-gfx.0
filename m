Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E06C5321D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 19:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A5710E0AE;
	Fri, 23 Aug 2024 19:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UqaRchhN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D50010E0AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2kAYLKJyfoyw973Y7ntRiFDGS0VbKgmLgLdp8XvDr8/ParyEmvwc3ftvvbevKAJaCw3blHMAlBG6Pp+jgr2cETUuZIejsx8nt1XqhqBeVu8vwN0SpVFpNelxH5e4z6tf3Rx1v373/fiC3Lxd3+sCjKIYvGKWIzjB3LjrH3xcOyR097MQ5/wh8iFlJrblvxpv6djW3Ky1XnkpdxlLsyF1ME5ErSAsadFFMswUni5qjFvOA8e1JkpWEDjVfsTts4GHzFKyA5ziMUSHQ6924NlcxNxg/GNx5ljmLCa7ooN5c/XP0Osa184FErg+5E/MAj1XUeMsKWAMgCJ6EpDURCNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnslTKijdk5+DjKcEZbeU1ZDYD4Lmtiar9n3XZspOag=;
 b=bh62MIjyWyP8K5y3dTwnJsHnkfj0SPRNo5JLYFkwQBE70lS1XtiluAmoXj49kex03BJt3Mc+JdVEAb5KUYnRsdSPKEc64Sk9aclcx+8CrJDKgiLXB1ou+Z5+oGqen4LJheGMF8lIsFFyU51I36XanEYHnhSmyeyigPruZjPmugdoIvHj/UJxeudX2nU0jUZsjgy+iiHnXBz/wM60Zvs+xROtvUl2ISE+mR+JEIM15Fu60T2zhUifSEeAaZkPirkqjJJwhWEhAhH7aYp0A1bl8FJwMfjJE48Dyk7W9zYStHc5LtbF0IIhkWZSUzkk0s3IOqjMHkXy/l+jYTr9Ce/ILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnslTKijdk5+DjKcEZbeU1ZDYD4Lmtiar9n3XZspOag=;
 b=UqaRchhNSS8o0rr7nUVG3/s1bGws1z603RAjDchAhCAm7wYI9jAONQHOJrv3YHjfeibc55VV4nH6rNuEc4kWQ+ZpVwKzL0RapecLYuBixTqIFehZQnPBA4COS9J0eo5MaC0qJkuLKgF9wea8r1QI+P99hfyLVq9XuiezOjLFP28=
Received: from BN1PR14CA0018.namprd14.prod.outlook.com (2603:10b6:408:e3::23)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 19:49:39 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::76) by BN1PR14CA0018.outlook.office365.com
 (2603:10b6:408:e3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 19:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 19:49:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 14:49:37 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <lijo.lazar@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: restore_process_worker race with GPU reset
Date: Fri, 23 Aug 2024 15:49:00 -0400
Message-ID: <20240823194901.25068-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f58640-390d-49aa-3005-08dcc3acb910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PXTNziIm2PD7h57p/ojDRUkAGFrM/mpGengLc2wrAgXoBpUCewauVo3RRb+V?=
 =?us-ascii?Q?d4Kvr9Lpzd46qaJxmwTx4u3ci2klEjecfG3gsO3qHv6JL96vjGfipOGEQTdR?=
 =?us-ascii?Q?X0/whrTr7qkQ/UYz8+G58eNyeAzt/BpfECfyQVwg7eKSyz6gKwItAk8hBMBB?=
 =?us-ascii?Q?3VptZSo7Cf30fu+6ao0kQZkWtdlXPxgBNc8kUkXD/ZVzjob8GYEBdNbxzLQK?=
 =?us-ascii?Q?tpPBMRWvMucKlMXmsDAhQR0HYnEuwPDMxGRRVq6Z2XXMFsMPDZgEfax8QG8m?=
 =?us-ascii?Q?siSJISdOYdaKqyaBUawxWIdwWd6o1nhF11lN2bPYUqf5xV/LVGkV4iTUNW2Y?=
 =?us-ascii?Q?qaf2DO3rytE3vc10qBmZupGvO6hD5vFcbooeSpTQAaQ00Lch+/g6ifpeumIY?=
 =?us-ascii?Q?R2DVlbSJm1Gb73x7o3ZntjPLw+c97+MS8lXLZhKKyNGc2cp4mhvfmu4982OM?=
 =?us-ascii?Q?zZ4LV8A2G4yjUEQtTTOUEZLVFB5gT2/xrbDpa/yz5CtHJt4/synQYZ1OZ21u?=
 =?us-ascii?Q?s28SQlsCiWXKcYoK+54Q0gGXPHXPaVTMRmsUZBeW0aIQ+y4f0Bi5RrTmE85x?=
 =?us-ascii?Q?bWDe9fOkzBtTjucT3RBuOWXVICAIKgrFj0kANZ86QCyx6Ozk9NANfQYwyG6p?=
 =?us-ascii?Q?ze7aA5t9kUCqvdJLpLMHi21ABI45GZNifSKDc3dFb6TUhPNNRIgfysDErNnD?=
 =?us-ascii?Q?gthNtiQXIcrByj5vLhyMoAe0UhvNbgxedHnr5cGI+DaTTWjAHgJDg23f9gwD?=
 =?us-ascii?Q?/Qa3OTMAngiGaEPXSVBsd02TzE+ksxNZcMd9Oadtm8dutTFU7/GPE/dRUOg5?=
 =?us-ascii?Q?E6nS6KAFykLRFU96P5t+Zfczt/06fVqVfbQqpXGrYo3PNiGfd+P8PmZCZJdw?=
 =?us-ascii?Q?29VTBAiBxG1OHZLPc2mMXVzY9tWl7PpcPOZ2ojD8KFVZ6ovpjGkTch10u4ZG?=
 =?us-ascii?Q?R1o+6VRGdpS++e8iWReq2iCstsdkjxd+04SAYy/XUIo5YDFAo5sbX0g05TO6?=
 =?us-ascii?Q?rlRaAcznt5SW8zs/IHmvZHrYXaKXtXa7//xdG5+bqgASdh/kKifZmT3zCyfj?=
 =?us-ascii?Q?utrmyWnlWegPbjcuNuuNH8oULaSeUKBdgS9+qnZzwXJoASLk100NZcNungNX?=
 =?us-ascii?Q?PP4E4U48KO/zDWEXLEgkObth6Ds9WmdBy9icox7Nsuspkiuhq/lk+mvs1i3n?=
 =?us-ascii?Q?E/ju+RZja9Pw1xe+hC4Bwd5pBCSoiA5JWRNdIIitE0gErXe6siThuTJNdoax?=
 =?us-ascii?Q?eDovJar1SW0Hxq0PAH7PciKHpFQwqK12dADAlR1AKRuQ6dfNCNdblkabf7Iw?=
 =?us-ascii?Q?vI2kv+utXPaGrP9BR9C64mJpuBsEIlmW+Cz5AYqvEsdlGPsUKWIMgAw+Jx05?=
 =?us-ascii?Q?1Q4FZGBnWT5ITbcTFRTeB3n/GiWtBAGUrwENXtJ83S0FjVXJI6w1/7MV04Pq?=
 =?us-ascii?Q?AY+CynUp/YoL3A87o7zcD8PcTdTbTR09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 19:49:38.5779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f58640-390d-49aa-3005-08dcc3acb910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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

If GPU reset kick in while KFD restore_process_worker running, this may
causes different issues, for example below rcu stall warning, because
restore work may move BOs and evict queues under VRAM pressure.

Fix this race by taking adev reset_domain read semaphore to prevent GPU
reset in restore_process_worker, the reset read semaphore can be taken
recursively if adev have multiple partitions.

Then there is live locking issue if CP hangs while
restore_process_worker runs, then GPU reset wait for semaphore to start
and restore_process_worker cannot finish to release semaphore. We need
signal eviction fence to solve the live locking if evict queue return
-ETIMEOUT (for MES path) or -ETIME (for HWS path) because CP hangs,

 amdgpu 0000:af:00.0: amdgpu: GPU reset(21) succeeded!
 rcu: INFO: rcu_sched self-detected stall on CPU

 Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
 Call Trace:
  update_process_times+0x94/0xd0
 RIP: 0010:amdgpu_vm_handle_moved+0x9a/0x210 [amdgpu]
  amdgpu_amdkfd_gpuvm_restore_process_bos+0x3d6/0x7d0 [amdgpu]
  restore_process_helper+0x27/0x80 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 56 +++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a902950cc060..53a814347522 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 
 struct mm_struct;
 
@@ -1972,8 +1973,14 @@ static void evict_process_worker(struct work_struct *work)
 			kfd_process_restore_queues(p);
 
 		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
-	} else
+	} else if (ret == -ETIMEDOUT || ret == -ETIME) {
+		/* If CP hangs, signal the eviction fence, then restore_bo_worker
+		 * can finish to up_read GPU reset semaphore to start GPU reset.
+		 */
+		signal_eviction_fence(p);
+	} else {
 		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
+	}
 }
 
 static int restore_process_helper(struct kfd_process *p)
@@ -1997,6 +2004,45 @@ static int restore_process_helper(struct kfd_process *p)
 	return ret;
 }
 
+/*
+ * kfd_hold_devices_reset_semaphore
+ *
+ * return:
+ *   true : hold reset domain semaphore to prevent device reset
+ *   false: one of the device is resetting or already reset
+ *
+ */
+static bool kfd_hold_devices_reset_semaphore(struct kfd_process *p)
+{
+	struct amdgpu_device *adev;
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		adev = p->pdds[i]->dev->adev;
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			goto out_upread;
+	}
+	return true;
+
+out_upread:
+	while (i--) {
+		adev = p->pdds[i]->dev->adev;
+		up_read(&adev->reset_domain->sem);
+	}
+	return false;
+}
+
+static void kfd_unhold_devices_reset_semaphore(struct kfd_process *p)
+{
+	struct amdgpu_device *adev;
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		adev = p->pdds[i]->dev->adev;
+		up_read(&adev->reset_domain->sem);
+	}
+}
+
 static void restore_process_worker(struct work_struct *work)
 {
 	struct delayed_work *dwork;
@@ -2009,6 +2055,12 @@ static void restore_process_worker(struct work_struct *work)
 	 * lifetime of this thread, kfd_process p will be valid
 	 */
 	p = container_of(dwork, struct kfd_process, restore_work);
+
+	if (!kfd_hold_devices_reset_semaphore(p)) {
+		pr_debug("GPU resetting, restore bo and queue skipped\n");
+		return;
+	}
+
 	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
 
 	/* Setting last_restore_timestamp before successful restoration.
@@ -2031,6 +2083,8 @@ static void restore_process_worker(struct work_struct *work)
 				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
 			kfd_process_restore_queues(p);
 	}
+
+	kfd_unhold_devices_reset_semaphore(p);
 }
 
 void kfd_suspend_all_processes(void)
-- 
2.43.2

