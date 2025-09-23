Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7289CCAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4A810E575;
	Tue, 23 Sep 2025 07:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQlV9I9+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDA510E578
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5WQO9avJXXGtXqaTTQ1Ijeq0EN3geWZHp7mlIeoGN7rKrbokIweMFlZT7MPpefYF0TiZgfSbGhTm4g1S43imVGsz5Z/7udyZzYlaSJuN9nhvuVTnkEc7LEOpqUktbydQnFBfxiKi9fS5zRX/kkwhFCS2cvMczziRcaEkBoFFF8cuT40gZcius1AM1zj4pi2xSHMuW1Ndqf3Pb2uvrVpxTfiGbp1AE8hHJyNyKc2ceX8D7OeTax/5LIcUS0u6rmx1T99Ve5Hu5XbdBzSfIvWcocEOhZIrqZNv4ddgCKHGvV9UdTqDI4oXrqXvEQsoRXXbhlf2MNIRCshHNnl+j87JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lDJ9oKZU2TKkxIJyo6R1Cq6lMvpFxbae7QpicxqA8M=;
 b=R0YaDMH9B1sKxThdh46nyynFhteAkHF5Nw89v3wqMkb4muv9tv8LG8OBYRbTd7+Nj8vNS828OzJqm1pQCHwANr113qXe4ljYa6mq1SgJZEvNeNmR8H55LDqCqQQzc2aoQAsZaYXXJXRcPYYARwkfWHuKQRLbPTbm7V7Ncgnwd/PBa2Vm9F4sQvJsjzgz0HmCclqs469liDH7FTNmESC0Mw0yiPc4Sj0DObYhrZp2dWR8iwkANBWIK7cl5Z+Abk1ic/9bsvOd3DEeOhyxJ1ExAPDbbEIH4S2XYGZYbvzSAQnow2DRiq55NXEyZMA8a/VwFcZmw/yAG50sGevJABhtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lDJ9oKZU2TKkxIJyo6R1Cq6lMvpFxbae7QpicxqA8M=;
 b=uQlV9I9+0xmslKf/whynj7CtGPGtxJGcjaqAkA/L+47G57mdVM8Nn+4q8OeeN+iFZb4TVzYgou9yV08rT1QOq2c/f1Irpjsl9Tt3RB3ssGjuwBHyaKzHKLMQ4TuDOso2reMTadxo7brnKA9TJU6Cye8cpiD4yk6SzOy8yXl2VNc=
Received: from SJ0PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:33f::24)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:26:48 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::d7) by SJ0PR05CA0049.outlook.office365.com
 (2603:10b6:a03:33f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 07:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:47 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:38 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 05/18] amdkfd: destroy kfd secondary contexts through fd
 close
Date: Tue, 23 Sep 2025 15:25:55 +0800
Message-ID: <20250923072608.252345-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d894f83-c251-4123-5dca-08ddfa728e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GKcjdCyrgaLemJG6zUhG6ka32NeypQpINB6LmgI9we7lv8dWpcZsvwqy1TBA?=
 =?us-ascii?Q?SPRf52ObDexy6i5vsM9hYLI8dppFltt6Fi3aix5H9xISfpvFBUQ4W/+RpjV8?=
 =?us-ascii?Q?sZ4OAQzyQarCEdW5q/OjxRBzR2CUvX6XCLSUWhJXz2dPBhx19kJZ80qqJAf2?=
 =?us-ascii?Q?Lmwsv/hq72dHm5xcTQaziHE+eQ3U4eZY2qgKZX/T4Ai58ZPhfqXenuq5Md0D?=
 =?us-ascii?Q?QcFvIQ/A7nepMsdZ9JmKWrb45TiZGiWaIpEyMBp6mMRnWBv3rvnWKvRoARQN?=
 =?us-ascii?Q?2OnKTm22rWnFpA391jIz107lZI2QjKlBVoR/aM2M1vR2t1ErrbfgauCshnne?=
 =?us-ascii?Q?KXheALpKkkGnu0seRdjs7+RapIt8VUxDBHuX7LXO+bkU95I/9dgNfUYA+nkR?=
 =?us-ascii?Q?vrHoaiWA1kvgr2QmWp7bgq235GoWoyWAkrON0nSL9xBkAC6gRy/vCQj1/Iax?=
 =?us-ascii?Q?X2NRog7oG92HBT9S8jri2MUfk2Glf3Q0lnpHo6oJBwl55gWfDxDUOgiQ/XY4?=
 =?us-ascii?Q?KKMgPKtxBKGVIM7ryEcDrs1O/jvP1HuVwqiPZXW77LIh9btostgSlSAuQnpe?=
 =?us-ascii?Q?8k4t7TwQReriduLI9YjwSKkeMZ7uWq7mQFlFzDAJ5qrBreRLFleIAwlt5Ks0?=
 =?us-ascii?Q?oDguQvo+dsRp0RsmSCTmMcXcM+kr1tes9PNK3Dp7XKx1DgkH1VNRhn7mZJRG?=
 =?us-ascii?Q?Y+goftB9jcvOxCxr3b37ofF4QICp5rKESAry0uYBN036GFDSRtd9x1eLh/v6?=
 =?us-ascii?Q?LgkjUwY1uPTlyFeD7bp+KlXEySE6PvrXCiIKvZ/65s2pERSfCMP/qpTVZvc0?=
 =?us-ascii?Q?d1OD4byr9y46Kis9qJk90iP+VRb097TFRaYhB/nsojS3sW9FxSEbxTQ6TwCA?=
 =?us-ascii?Q?JpB6Tb/tIaWFQ1rlxLi7HL4NF2WpHgYz1fGQJ7wXgJfq/+CsZObnVj16vsG/?=
 =?us-ascii?Q?ARrQn0s5oOwXYpPMhfKqigIQFw6iFww+qJIM8KT9ayAHiwrkMqDsLjeEPvEz?=
 =?us-ascii?Q?SQvN7IkKuOAW2UfJkyJ5yq3DfOHC6H9NZ09RDwT6aqjBKGomrva1xKVZseEM?=
 =?us-ascii?Q?oiDhfh7xmsHQjsssXujmsZj2F4huAoLIGp+/NevMcni80KrP9URrvzt4XGFg?=
 =?us-ascii?Q?ptPMerjjlQHgTWdqMOnsijIkhyOgwrQIjHrnYRgJimXO09pOm882AMW5aG0m?=
 =?us-ascii?Q?DEfTAFaE5y1TyWj3yvxZ5BtXotfddSY89gKCj2QxktHntfp0GeFSHN1h0dt5?=
 =?us-ascii?Q?131lk/tVwS0soOpSUC5Ow4wt+W4dFD8wF/GFRyaEzOVJ2NmrGa5zdH6iHumj?=
 =?us-ascii?Q?j0NJU0pfrYS6Ftd0O5+6zwng3lHLJs1a8u0ygssSZVcv+5bPLKhAYkX6b7Q3?=
 =?us-ascii?Q?50l8zMZEw9Q+W2gaozPvQRDJxwg+ZZ0emGhF4TdKKqD+ZVnfcybmemhIYi+X?=
 =?us-ascii?Q?oMCdejkIGGi27uqBVM1G8sFg2VRDf4yX5QGpvka3oUJW4YzgPU7L3hfUhBx7?=
 =?us-ascii?Q?/M0CGGyXo5Alf4gu3JGkg34joLCIqe+jat17?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:47.7633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d894f83-c251-4123-5dca-08ddfa728e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  9 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 41 +++++++++++++-----------
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..e8c6273de99b 100644
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
+	if (!process->primary)
+		kfd_process_notifier_release_internal(process);
+
+	kfd_unref_process(process);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0818705820c6..d1436f1f527d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1085,6 +1085,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
 
 int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 			  struct vm_area_struct *vma);
+void kfd_process_notifier_release_internal(struct kfd_process *p);
 
 /* KFD process API for creating and translating handles */
 int kfd_process_device_create_obj_handle(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index bce7e35a15c9..5d59a4d994d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1233,10 +1233,30 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
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
 
@@ -1270,7 +1290,8 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
 		srcu_read_unlock(&kfd_processes_srcu, idx);
 	}
 
-	mmu_notifier_put(&p->mmu_notifier);
+	if (p->primary)
+		mmu_notifier_put(&p->mmu_notifier);
 }
 
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
@@ -1286,22 +1307,6 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
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

