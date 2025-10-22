Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74EFCCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6398210E6DA;
	Wed, 22 Oct 2025 07:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJQXiG/X";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABB410E6DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuolQ0Z5VoWEjD85SBx/DeNh9AyotvUXnbKLuM1q2b69oFNyOSD02XJru7toO+Cjc01GvrqMwkCLiNn4znlDYKMdG5LwICfQd4gW5Zf8UCXSsbk5Jy3Ob4JuVYBl3GAmJdboHtiX8LEVwQ9m83bAruRIvGCjTeYayrmcH1beDAgmT22AX1bcPK1+TIQVs53makuEvm/nEEAFSuzzDWYBq0ITIoW3Y/IafHlnzQFGrBfvqtdAUlNowlYeFMVIr4yee7Bcs+oDgBrOvkopCQLIn2iB9+Ln4+cBP5TTmg1oEy6YSNReXlGsYtg8xLOspWLh0Nxv319wgTWYqlaiBb3Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErIyOEds1cS2YnbwMAfHz9eNzCGz8gTtCackS0P24JQ=;
 b=xHwyH1U+AaE8ymMrQn63xFrcKq4zNB2Dakp8Meh0FPTZ6OuMvByT4rrsZbx/cwvr/DDQtH64w64OSSNYIitZzZJpJXnIWZGOg8+JT4jE7rBMAo8Y225iB8DBgHvFkNI5UUoQ4xDHVzpAfqzHnPTG02FbzYEg/ofXwFs+E2AXBnAfug9nZ8Xc7LZO46Ebsyis2N00bMH2tJqJ6OWBiGWsooBJmHwdzrWkopCMvkZpqHi+SmgK6nFN8XByp4rRkXsOqFwhcp7cWPfH5JlKY01SRcTyXqSBGCWqrTyehGLVXWNgWkpYHQGoyl8vH7ZC2XhCClRvsIBGc77GX3/8fx2oUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErIyOEds1cS2YnbwMAfHz9eNzCGz8gTtCackS0P24JQ=;
 b=ZJQXiG/X52sfxPX+DxL66Z+rxMqhWW7BPXoK/k6VqtWKhBAtAlVS8v62/9C13LZu5fH/tfJ0S6rDO1xMFkVkMRZFexr1jUTQFYSTZE9+KM8Bf8TiIJL+gxSBA2+ZNR62/vHdN5S+mbg9ivbvKLXKcr2yIh3NRvpnHMPXo892n5Y=
Received: from BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:17 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::6c) by BYAPR07CA0050.outlook.office365.com
 (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:17 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:15 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 05/18] amdkfd: destroy kfd secondary contexts through fd
 close
Date: Wed, 22 Oct 2025 15:30:30 +0800
Message-ID: <20251022073043.13009-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 655f23aa-17cd-4525-699a-08de113cfd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2atyy8eJh6EmpuHkCrikM1Q1bv/PCqLZV1I7h+ftlJYBeYhtl1mu1+/u7l/5?=
 =?us-ascii?Q?Od3XujKirOYPR5VkGHHoToGuXRR8aguGZqOuOvsBYELHKCApFLUztJAbCNA9?=
 =?us-ascii?Q?ZzIMCyVnXH35U7luKSV6I9r7QHgGmO7NYwcXGY3BNhRK5aIvhgcE08SUxHel?=
 =?us-ascii?Q?/g+vqket2J7JWQ5chNMqSIQWwq8s3N971gklx1cU2Neh5AJSdIgWpLTWD3xY?=
 =?us-ascii?Q?A124KS1seTkVT09+sjLHUAr9STjsYvRcE3R/8iBoTh2pJpQfkGJR4lOKjMGB?=
 =?us-ascii?Q?bL7x2UbQ8BE3kXArjBbqy9jlfJQYOLvhVmg5Qqh9yZg/Q3sxrY93LpRPdF+3?=
 =?us-ascii?Q?KGegWe76PeQ5c80pzuNiWkAUdNTis68M1i3+kgNeGGACk+CQsvgf3wA7CtrW?=
 =?us-ascii?Q?TbIzz1AlDzV7uHF4FmHX8G0x2Y6vXOK5uR3rcU8Ksh1awMIMub3xrdpxDMHU?=
 =?us-ascii?Q?OFQWDQQ+Dy4nPvS3glJpVu6VhVYIM3nkUOttvN8oBHnBwRVJi1uS2FU2DC8/?=
 =?us-ascii?Q?WLHd7TOsL9CJ47edDxGyyEc7k4r5Tmu+cESA2DQhqjBTVdxQ2tiGS5bEofZR?=
 =?us-ascii?Q?xCLC4I1tel/9uUgehlTDgaE+Hih/s/kuUnoC4FesecmIJJymHKZMkszkqOOa?=
 =?us-ascii?Q?PqfwnSoWb4vWGRTQ1H0EuGARf+BQl8Qj5A0MBENs++cmvgHYoGrlHFILYmJw?=
 =?us-ascii?Q?arwIjhz1l718NBduLTH/kZdX2v452yJlXDBWkpSwxPf0U8EAxwUYNnSg4O0z?=
 =?us-ascii?Q?vFSMYYownKad/qxoFJoTlQ/cfNwZKLgjkq0FoJ+/66OWDbrYiApjnI6iF5/4?=
 =?us-ascii?Q?PcOnj3hklNLvLUziKzDldBYHkp+ahLx/Yhiwffod2AB9uLNlZ5ZR6dIVpYk+?=
 =?us-ascii?Q?TlGb+9pJPBuhzvriWmWH+3xSXhfZpbgERawXSi3C1yTR2Ev7b4l87xVElC84?=
 =?us-ascii?Q?QN63k2Rb0D2LjH4UD16bGpgUI4YxHsG9HIwf5AAyyFFSgnTg4bW1caGd+hp7?=
 =?us-ascii?Q?SDaOrPdB9lvB5+dWbfHPl6TRCkdszClIXYIzGAEMtXpE9N82NvnbNkgtiGDr?=
 =?us-ascii?Q?6FNH5sxN8J2X6hZ6yCm8M/FLMYbtDodMj8RK7Cj8tCFseD7gO1xRCYpakHlZ?=
 =?us-ascii?Q?/M+1lUPLWxruIO2i0J7+JymMrF5GxzznGBcrfksf+MUln7togf/XrcB3cH/Z?=
 =?us-ascii?Q?jAVxus+3eSVTIWPGuke+Mc0d6TY9AhlIrVtzA6LqoEm+hYro7so7+V8ZgsB3?=
 =?us-ascii?Q?zxYSjUFDjtqfFAJWr2ZvHtza5oDVPlgi1QykWz4qUJUaWHOVmx1WHN/4MySv?=
 =?us-ascii?Q?V9b4XO7YI4D4OHlPwtr+XsxSS+RfSK/Vc7wcmZExa7RHfPcsdbuUvkUkecns?=
 =?us-ascii?Q?2eGDygIA6D6tatC/A9D9IIdcuzDW1Kb8QtmmjxAidxNn0O6od/j4duBVWptW?=
 =?us-ascii?Q?i07C6NTKKKxiiRHIQa2tiWHmnsioEPO2nFZj9DDxy8bXQuDxPfKlBEcfO1T+?=
 =?us-ascii?Q?1LvajvBA4PHE/vSytEol4R2RN5Afy7kfboWS4uchTKgv2dTTz1VdiuU4uwJ9?=
 =?us-ascii?Q?yyS5ustcHdL9QfoB5yQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:17.2800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655f23aa-17cd-4525-699a-08de113cfd09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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

