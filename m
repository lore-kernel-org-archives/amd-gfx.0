Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034DFCCD1A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501F610EB6D;
	Fri, 17 Oct 2025 08:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AqkWpYSk";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8CC10EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvPnhIb8vD0++kNmAkrNRaET2evJQh2ZaksqgHT6u19/LTiVaPrU46ia1x/UVlniynmOEWGft/rkoWyO8StSVfWo2l9ntsx2IjDgpl9Pv9/UOLFJy6qVHaOtjxsReQlZ396mBIKakAgIAqpHg+jo3O9vznam8YzQeE0h4m+TTIc6VBR60izj2tXnNXCmX11fj3zXN8WAnB8xWX7ySXZ0X2p6JPSqPOBeshHFNjuPDShmEtsCFYrixJudDvNILeGYjJ7izzGk2x7ireedarr+FVE7GyDDy/0SNOr28vgcjNoKUzqVotb6Kfi4mlwVNLQrbnuvgFuQo2RMB1tPs5mmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlSkeC+u7BZ3jkcPF5A6CRZ0/wnA8dMDxvtYt99YbTM=;
 b=IqamS4mwdAyiJ6AdhyxWA5sPaYdN8/6rBLJMJnQDWKb037CTe6eF7qOL9X0DTlyEsOtl/jiWB+2IW1aHJB3Disks+ew0NgNpUOpALwfch4wuAXEZ0gOe1qk2mJ4REojAzeI6x4xsFpOSdlGwbc+M5TX0wqLFigmwFzdq7LpC76jJub6KKGoNzOMOK68Msb6vz9s1Q0ZNp7/22aj6pnWOzO7Hq/z4sUHLiPvOAo6ub0JwqR1YwoiSZ2i4VfgOitrRGevaJCgubI4NZ8QOFCJcEV71Gmv5t783D0w61CFil85MMh2yvRrU2HePdM+eaHJiZ6FIKtu71Uzdl/tekgYaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlSkeC+u7BZ3jkcPF5A6CRZ0/wnA8dMDxvtYt99YbTM=;
 b=AqkWpYSkfx0bYniuDyHVhsSsygBFiwe2G3ATCA24v1w6Y0uEXMP5TozuLR0oi+I3I9IZUqVE/1jj58rcPXeF1wC5JtGUMUOPs4117qIYttg1cUAy98Ll/G3eAu5Rqx3IPuhtZrZqcTqrhp/iwCPuz0hcdmGfGWQ1non7GwFTyXM=
Received: from DM6PR01CA0023.prod.exchangelabs.com (2603:10b6:5:296::28) by
 SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:43:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::c7) by DM6PR01CA0023.outlook.office365.com
 (2603:10b6:5:296::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:21 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:14 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 05/18] amdkfd: destroy kfd secondary contexts through fd
 close
Date: Fri, 17 Oct 2025 16:42:09 +0800
Message-ID: <20251017084222.54721-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c5e828-9f86-4354-f741-08de0d593a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKzozOUeCvG5TQMIMFXCXRXBZ4VdJpFVhTjMaMGDEp2lKUexNpGKhDVZgE2G?=
 =?us-ascii?Q?27ypodrdfLUw13jSQMEQ4/X9B/sHhj1ZZJWYSPe3ZaUVOMnCFLO+vw3jnhPF?=
 =?us-ascii?Q?6Zg39L7vVN1s9cvIxQwiYNZWxMv4GFh4HD4wilM51cK5HFVznlaRjILaj3GM?=
 =?us-ascii?Q?dZ9z8jG6lY+ttxB3RP+LvOiUA49mYfufG0A4wP4vW6A3Ofz4/pp3Ph7m6Jt/?=
 =?us-ascii?Q?wqF9dp61fdoKvXybDRGcohfptnMfCNDeUcTEmz6Wst5frDpJ+BedUy3c5vRa?=
 =?us-ascii?Q?w2t3a1XEHzSqvxPKi/Z66c6SRi6PXEiFJoNsvI/isF2WgKMqZbvUm76FblqI?=
 =?us-ascii?Q?E8kEDAnNKMov09Bvwmc4wwAFnJWkEqXtPVW1B7PBTxrpkF+2ouLGvJqyth6I?=
 =?us-ascii?Q?tkDx4MmOrtwk2VlMldLrhVv6QlcrK1ZX6pfNVHXY4n5Uy8Vg2KoCX88Df/uM?=
 =?us-ascii?Q?gQmCkCXSP0uMSevlK95hujL0HLNmVRc6pCfsCUus+z+j1RcaajRnpGv0O4KR?=
 =?us-ascii?Q?Jcqlj0OC4tR2NMBNH/Q9WsYI7FxmL9SIE7ntfdKEw2n4f04XPY7PKxK2o9RJ?=
 =?us-ascii?Q?OJ9ONeb8FtV3jWFF2J1EAFY6QIh/duJNts0gG1ZAy6VA39AFz/u4Ka5hMBml?=
 =?us-ascii?Q?uyxwJRtkuNG0/20xrzrus8h5HsvdCd9PqRz9QjocO9716TmGHXTyjsHVGFbS?=
 =?us-ascii?Q?NSkAPsHOfidlH97JN6Ml8Qkor8kJ9Wm8Mj2BL5gg4bAHfu2oKP7R0xmfR8r0?=
 =?us-ascii?Q?rD3Dow7bIiydicWO07HLFeJGmhSqy0z5YmJMU7STmrwekhPHYeHDS9C8Wm7v?=
 =?us-ascii?Q?O6POuHFD13mXzrCUoqH7Dy5TIkgGpNgOfEf8eWUFIP8t9HE0E3cdOjmVUGg5?=
 =?us-ascii?Q?xIrJ/GDMaL2uIMZ4Nb2RurY7CdOkGj2gouR+WrNq1cecgthAAKcOn4IKGTyD?=
 =?us-ascii?Q?NSOg+v9ZUBn4a0919YeiQ7Tq8uSXwIIsOW6MtnwvcG6hKDIJnUQoWclDr9rd?=
 =?us-ascii?Q?znzD2e2di9ghKgQ6ndZWDo+H7Jf42KYyX7v/r4/IrBCTICp5vD1GMEIx9NeQ?=
 =?us-ascii?Q?k5XpBPHleytPsGGDaau5F1Prk9rsvIb2IikcQirOtnGiz8mFgeDNo+6gDEhQ?=
 =?us-ascii?Q?nbf6SaxRFUUyZlQLoWAbOIftgkfAReuiNQ9RO0yiFMjxJNN1FcdschFrHVAd?=
 =?us-ascii?Q?YWDum+9wBJjd5DMisZtG1t5BGw744nr0sJl6WGgE0BoPeV7gpbwfLisiydXo?=
 =?us-ascii?Q?zjB3vN1kl4XWvrQdTfeK6kjKbOWl+MjUy9uDm1oJ7xaCVJWMp1TS1qPjf45L?=
 =?us-ascii?Q?wBEYjjZow1E5gCeffdn45abkA2RZ0nNG4NQAzcMLFW81NwymPQ9EWP/K/dAm?=
 =?us-ascii?Q?U5UWmMnTybFAz7eMLYGA/97QwfZIK2mWsCXFiwbDJFc1oAUtoArnuypPGZcU?=
 =?us-ascii?Q?FinQFp+wlTAA2VjgEzIMI/aI6oC2XHdceDUXzGVuAl9phmSNmsBLLAelF5an?=
 =?us-ascii?Q?kdnmc7VhlD/gd52h2+aYRvJXF4t3C/q5iNmw7ZQopbzuzTpGDQN1hMH12o+O?=
 =?us-ascii?Q?K3eWoXa+SUHJNvwlOyo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:21.0076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c5e828-9f86-4354-f741-08de0d593a12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904
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

Life cycle of a KFD secondary context(kfd_process) is tied
to the opened file. Therefore this commit destroy a kfd
secondary context when close the fd it belonging to.

This commit extracts the code removing the kfd_process
from the kfd_process_table to a separate function and
call it in kfd_process_notifier_release_internal unconditionally.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  9 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 41 +++++++++++++-----------
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 0f0719528bcc..158e75975557 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -164,8 +164,13 @@ static int kfd_release(struct inode *inode, struct file *filep)
 {
 	struct kfd_process *process = filep->private_data;
 
-	if (process)
-		kfd_unref_process(process);
+	if (!process)
+		return 0;
+
+	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
+		kfd_process_notifier_release_internal(process);
+
+	kfd_unref_process(process);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index cfedc0c5892c..919510f18249 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1096,6 +1096,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
 
 int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 			  struct vm_area_struct *vma);
+void kfd_process_notifier_release_internal(struct kfd_process *p);
 
 /* KFD process API for creating and translating handles */
 int kfd_process_device_create_obj_handle(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 83fe571b801c..995d27be06e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1235,10 +1235,30 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
 	kfd_unref_process(container_of(mn, struct kfd_process, mmu_notifier));
 }
 
-static void kfd_process_notifier_release_internal(struct kfd_process *p)
+static void kfd_process_table_remove(struct kfd_process *p)
+{
+	mutex_lock(&kfd_processes_mutex);
+	/*
+	 * Do early return if table is empty.
+	 *
+	 * This could potentially happen if this function is called concurrently
+	 * by mmu_notifier and by kfd_cleanup_pocesses.
+	 *
+	 */
+	if (hash_empty(kfd_processes_table)) {
+		mutex_unlock(&kfd_processes_mutex);
+		return;
+	}
+	hash_del_rcu(&p->kfd_processes);
+	mutex_unlock(&kfd_processes_mutex);
+	synchronize_srcu(&kfd_processes_srcu);
+}
+
+void kfd_process_notifier_release_internal(struct kfd_process *p)
 {
 	int i;
 
+	kfd_process_table_remove(p);
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
@@ -1272,7 +1292,8 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
 		srcu_read_unlock(&kfd_processes_srcu, idx);
 	}
 
-	mmu_notifier_put(&p->mmu_notifier);
+	if (p->context_id == KFD_CONTEXT_ID_PRIMARY)
+		mmu_notifier_put(&p->mmu_notifier);
 }
 
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
@@ -1288,22 +1309,6 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 	if (WARN_ON(p->mm != mm))
 		return;
 
-	mutex_lock(&kfd_processes_mutex);
-	/*
-	 * Do early return if table is empty.
-	 *
-	 * This could potentially happen if this function is called concurrently
-	 * by mmu_notifier and by kfd_cleanup_pocesses.
-	 *
-	 */
-	if (hash_empty(kfd_processes_table)) {
-		mutex_unlock(&kfd_processes_mutex);
-		return;
-	}
-	hash_del_rcu(&p->kfd_processes);
-	mutex_unlock(&kfd_processes_mutex);
-	synchronize_srcu(&kfd_processes_srcu);
-
 	kfd_process_notifier_release_internal(p);
 }
 
-- 
2.51.0

