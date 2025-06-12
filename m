Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCFBC71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 19:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAFF10E1C4;
	Thu, 12 Jun 2025 19:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCr9fN8W";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2C510E1C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 19:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkQpKj83WPVc6unIiX3+KlqM8HvSFpA6NWs/58YXsVZoUaYGUWT14pxxqfACZtTG8+RqnMTkbLLPNgJc/awDSjhVAJosFqOivM6jb/vHyIHMLfqF75rGLj4eixzdXsKmRLy0IFZpMC2eGPtwjGa0CJApZw3nxVN5CdNshCiJ5s7eypXxoBi+K3O3yyQF6Sf6VIwyrOMBOStC02F1zJmUPSGH1+EJoGz1LZaSaprYKaxjSGw1Ui8+rY8Gl+Fx5arLDpxWBbQ2TTI/cxptVc1bDjTqxfHL2o04k0pEOawkZEEQwYD3z0qhiQzJGxLSKPft6+5TSHvC9/12x4z1oOAZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiAiiIE7uvNarf9LyeAK/gU9xZkj7zp7yHEg/hLOIik=;
 b=LdrJ5jRG8YLa8ciU7HWM4KJ23f7qKN/EfhNK4bQRi+hbpbSRv31ja+NCwY50b/US/AntopxWRDPpHdhWPWP92rjeTvpxZvh2CXNcjGHv3FqOqOXdr97G8/vr4HOPtjpgGNq+q/28+q8nr1dcxSosK9FN5ffpwJLKB5IuXlAHIS2ad+TscHhLsQVR+2/C0EtrAEywUf0tOCOfPXMR4QF6jTsg3KvYCAGPgcGYnJiY9g9wbyjmh07eBPmoycvDaQN+Df58QGTVDHZB1LsTNtmiciNsvwBlsXh/7uNGNMvzHT9/n0yMGaATeEzvjLWXWwflPgS6Qt09a92PH88tVx6OAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiAiiIE7uvNarf9LyeAK/gU9xZkj7zp7yHEg/hLOIik=;
 b=cCr9fN8WnfaaDTEMqIVglccTr3QQrm2Kzlt2Z07TkCHaLb0xrXbkOojAgQgo2OedGCQQzY2T983EnDhTyL0j23Um8lFKoAJocl3e0N9R90FpT2mToduzShno/M97d9Nt7ageqpDtphAXQzjJtsOiIRAZoT/a9IBTzL9+hSYwco8=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 19:53:17 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::a0) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 19:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 19:53:15 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 14:53:14 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <philip.yang@amd.com>
CC: <Felix.kuehling@amd.com>, <christian.koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2] drm/amdkfd: improve performance with XNACK enable
Date: Thu, 12 Jun 2025 15:53:05 -0400
Message-ID: <20250612195305.57598-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508144651.16745-1-James.Zhu@amd.com>
References: <20250508144651.16745-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: fd71a5f6-7262-4dc9-8e44-08dda9eac592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QpQjFydqRsEGUQLo82bYu4zxAEGRg2ckdwz87U8gdcB+QkIXd1oVwo2l+6fb?=
 =?us-ascii?Q?5kLFOJx/0R1UKw9kDljj9ti7OG3ILUE2sZ6kk/sarg5YzFq6PuYI0JkTISzq?=
 =?us-ascii?Q?4nXoBz4h+on3eTdWpOtHQvKO/kjBLe5dC8xxmAwo4+VuZad1Ydlk1sF8H8RH?=
 =?us-ascii?Q?h8Y1FD4fA4oxPoSt2hbqu/0pBtpYCCNTaNmwbfjGMuHl5IHe5qOYZdqY0Q5b?=
 =?us-ascii?Q?e6ywQNDzG9RaWGAUSicHEkUrbEHO05cCVVh+CFsShQC37PLkyow809cQxJlL?=
 =?us-ascii?Q?GnSg/LYKFn1+44g21RU0ssVRBMZ80KZ1VICNB62hqVtz7Twtlatydgs0XesX?=
 =?us-ascii?Q?pZiw5QWbu9mkgdC3oexQbaV5Axd1ecdDfP8EEBEviB4XCyPZ8Dg6Lbz87qFn?=
 =?us-ascii?Q?BhivU52IwWGnsScSHpyjKq/Yjt/WEQEZxHpFlR/sfFZ2rXCijhS07OqWlqiL?=
 =?us-ascii?Q?isRp4+SWBQ0ViArIHsrkf0hTazZ+hCEK/mZh8J+clDE3qWEkQ6vYs5JRO1rz?=
 =?us-ascii?Q?+KKfG6dZnTLpxnVcRDWXt2caPWJlek3dNA4DabnOiaH1auEmWBK1OQkLtKJZ?=
 =?us-ascii?Q?/ACpXv/FA7BGJb8HR1/+tiTqK9B8TbZ+iI1ZJ/Q3M06p8l0lOXsx0zHiu3Qi?=
 =?us-ascii?Q?78KDJtlsTSA1bYkJmSnjrBLHAs09VFrj2U7Cd0c96fdrx5Cjgi5QCOlyb3H4?=
 =?us-ascii?Q?/8grWZxYei8tTqbXnQ78AbFDEiOGsgpyXTeAo0Gm3mZ5vGZMIxu7EguKN4SM?=
 =?us-ascii?Q?I76vAGOhJDTnjfX+RhpM25VemcwMiiTNwvomOq9LfB8swOY/wxTmsZ6RIffC?=
 =?us-ascii?Q?XvLPZ9hNIhQTCzkkMt4xfgOuKI0gmTSofkiQPJbZGTWUCA+juIVj/V7YnrTx?=
 =?us-ascii?Q?cpfYDDZhx2q23xYx2mTekp2X3OqGKejtakEEudtH1xkbigWfsLTOa6mimMyD?=
 =?us-ascii?Q?kfm3Z0xjkFItKcWR/hUNa++SuS3jjB8obzRkyxsDtc4cvK1N1AvhmZRTQGwL?=
 =?us-ascii?Q?oxuqapci0cGNtv9Nit0xEVs+CElIEgcG6vKNsiuK6nedBBwZJyHmlGRTZkTd?=
 =?us-ascii?Q?SOITa/hNQ3TFMmWBhUXGOcYwXU2qazxx+7qabWpKikxe8qB/SZkeIBovtd7x?=
 =?us-ascii?Q?7TYJhql/O3muRaaPPoULA7cU4cLY6GFTmtDXvLWlb8KgODZEsiOsXv7bxmpv?=
 =?us-ascii?Q?gKXtawe9RUp7qx2M4pAhH5CgFh2vvEZao8RurNwapHuBeGC92+iLgra0S9J7?=
 =?us-ascii?Q?w3d7g6Rai7jvM4lwLRKq+ZWZDUfnAGnl4ycv5+LKOSEFVwYplkJH8gwmFEVU?=
 =?us-ascii?Q?nxr+2SIsj/+ylARor3Dgs6KtsnflXZiuPjsNxQL6cOhD7xSikt9QzNEDtSAq?=
 =?us-ascii?Q?i1Jn0b+QVE5udbxEV0mdWhNAMSWNklSAjlh3RW1lL5oeYSEFaIJph1OGO+2J?=
 =?us-ascii?Q?TTZUXVPdbkpfi1oW2qN9sBj1JeokGrPsa1pqGDsPSG64JfU6zopPS6ktmujV?=
 =?us-ascii?Q?2OwHRQrWcls0tC3Vpo5+je8/GoAyQQxmKYSZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 19:53:15.7324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd71a5f6-7262-4dc9-8e44-08dda9eac592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

When XNACK on, hang or low performance is observed with some test cases.
The restoring page process has unexpected stuck during evicting/restoring
if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
1. when xnack on, retry pagefault will invoke restoring pages process
2. A. if there is enough VRAM space, simply migrating pages from ram to vram
   B. if there is no enough VRAM space left, searching resource LRU list, and
      scheduling a new eviction work queue to evict LRU bo from vram to ram
      first, then resume restoring pages process, or waiting for eviction
      timeout and try to schedule evicting next LRU bo
3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
   queue eviction will be triggered.So restoring work queue will be scheduled.
4. step 1, restoring pages process will hold one mm->mmap_lock's read until
   restoring pages is completed
   step 2B, evictiion work queue process will hold one mm->mmap_lock's read
   until evicting bo is completed
   step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
   write after the above two mm->mmap_lock's read are released, and in the
   meantime which will block all following mm->mmap_lock's read request.
5. in step 2, if the first eviction bo's size is big enough for step 1
   restoring pages request, everything is fine. if not, which means that the
   mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
   eviction bo's restoring work queue will compete for mm->mmap_lock's write,
   the second and following LRU bo's evictiion work queue will be blocked by
   tring to acquire mm->mmap_lock's read until timeout. All restoring pages
   process will be stuck here.
Using down_write_trylock to replace mmap_write_lock will help not block the
second and following evictiion work queue process.

-v2: just return if failed to get write lock, lets caller decides if retry.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 19 ++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index a2149afa5803..ba232cc13e9b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1068,7 +1068,9 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
 	 */
-	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
+	err = svm_range_list_lock_and_flush_work(&p->svms, current->mm);
+	if (err)
+		return err;
 	mutex_lock(&p->svms.lock);
 	mmap_write_unlock(current->mm);
 	if (interval_tree_iter_first(&p->svms.objects,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 865dca2547de..d4eccc6567ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1785,16 +1785,21 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
  * @svms: the svm range list
  * @mm: the mm structure
  *
- * Context: Returns with mmap write lock held, pending deferred work flushed
+ * If gets write lock, returns with mmap write lock held and pending
+ * deferred work flushed, otherwise return -EAGAIN, lets caller
+ * decides if it needs retry to get write lock. Since busy wait for
+ * write lock here properly blocks restore pages process which held
+ * read lock in the beginning and asks for read lock during migration.
  *
  */
-void
+int
 svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 				   struct mm_struct *mm)
 {
 retry_flush_work:
 	flush_work(&svms->deferred_list_work);
-	mmap_write_lock(mm);
+	if (!down_write_trylock(&(mm->mmap_lock)))
+		return -EAGAIN;
 
 	if (list_empty(&svms->deferred_range_list))
 		return;
@@ -1833,7 +1838,8 @@ static void svm_range_restore_work(struct work_struct *work)
 	}
 
 	mutex_lock(&process_info->lock);
-	svm_range_list_lock_and_flush_work(svms, mm);
+	if (svm_range_list_lock_and_flush_work(svms, mm))
+		goto out_reschedule1;
 	mutex_lock(&svms->lock);
 
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
@@ -1885,6 +1891,7 @@ static void svm_range_restore_work(struct work_struct *work)
 out_reschedule:
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
+out_reschedule1:
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
@@ -3638,7 +3645,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	mutex_lock(&process_info->lock);
 
-	svm_range_list_lock_and_flush_work(svms, mm);
+	r = svm_range_list_lock_and_flush_work(svms, mm);
+	if (r)
+		goto out;
 
 	r = svm_range_is_valid(p, start, size);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 01c7a4877904..c8c9bc7eead9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -196,7 +196,7 @@ int kfd_criu_restore_svm(struct kfd_process *p,
 int kfd_criu_resume_svm(struct kfd_process *p);
 struct kfd_process_device *
 svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
-void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
+int svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
 
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
-- 
2.34.1

