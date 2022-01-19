Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 16:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F48C10E3A2;
	Wed, 19 Jan 2022 16:23:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4362E10E3A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 16:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjF4paju1eHSJOdGUce/S9mIqPNnnFWHS6P2DoaCxJkKywlBIh0XaqrJSiA5EGMEFVXRHdnVbupF/q5wV9Lc99zUNbTCChUhFo8+it1axxZ16akmZE7hxBt3B1jTeiplikSNL8B6APLloeSH8MKDhkynubuOC2C/aVyIzODelrP+2w/iqwwNh5kGeW2SyDTjFuonJ5LgFnosYcI++5cSAnzeXGtXcYS5R39htYYBZhryB7UHlz2rXR1zMxftlxk48oocBbDcKYvKHJMQIgM/EhO6p5t9hu1Q0Pp9bWli5otEZhgz72oOBrzJuJAvqVG0/2BPfaGL2/4IOlwIvS2U/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1PdnpjciXjURM+ETwBB3lfN/9NzW6gXLRDRFKC1FX0=;
 b=MgxoulFFJEs29/h4Yvc2qBHiBjmEBX5aN8InKllaCLQiXOsDFGYSmRNsxDUcmL9MFJT/lVqp8f3uzlKjl1X4B4yzMpsaMdug9aLkRVwSgw/tCr3fRIX9+avSjW/fAGuuWwW7avQw18clRX2car6TExDQnFL4XAfJyzzn2XtxNmWoNiZx8ohNB5M8k0sUiUvllsWQ92WJzfMgNhnH6GNdtFMgTwjg1IzLAn9KueDWRwlpMC4uU6hsLw7USVbJk+CiE/ROatxY2xl+hyevKGWla86woWagn12E3DYI01Y/iNlwo3pL4ixY8yIn9k2+mq8IA7BMC2DREmBYRnN0VMWd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1PdnpjciXjURM+ETwBB3lfN/9NzW6gXLRDRFKC1FX0=;
 b=WCJoX/owI6vZLW5M+WApm6nGura4p+Cr6jjI2sE4HL2D6uBZQRi1Rv814NUZ79A41Nayl4wdhtrj5ckCovtdrZtos+6BzhwQ0DuVHgMNAU2+z6XIeUc7KcbKtj1wpMUQ0a4oKH5IGOEYPk8wOuYSZSML/83Icu+s7E+WW3JjPbw=
Received: from MWHPR02CA0020.namprd02.prod.outlook.com (2603:10b6:300:4b::30)
 by MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 16:23:16 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::b8) by MWHPR02CA0020.outlook.office365.com
 (2603:10b6:300:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 19 Jan 2022 16:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 16:23:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 10:23:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: svm deferred_list work continue cleanup after
 mm gone
Date: Wed, 19 Jan 2022 11:22:45 -0500
Message-ID: <20220119162246.21457-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d11393-1133-418b-4d73-08d9db67ff4b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3053:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30538912A0B199A1B87206A6E6599@MN2PR12MB3053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRHH2UgGVkXKZaNk/KMUkN4vMhjSiY2sjMlJ8JrMgxgEeSzgtlhPxTCJemckQiEfA0E9aNtNZ4OFxR7BhfTPyzUmAxcUZcJApA8Z5z2qUzZEJPyderXn+aR0P9VvqHO2KbfqdY9WQgOvU/Lmgjz3alo0Kbj+oLw+M0Gwspiu0diaPAddYu5Rrnh4+6M2Jwj/uUwrHer9eHaI+FjAAE086BHB7HVmzn+Ym54gH4uw7ooomffs388muav+OZh967fmhpNJh+mfq7P11ZkVXpkWFL8hRDspRebBV7lTE+GWLpB30nCClGnoQAzkTEYfwMkMhOAVg7+vRa+cqgfi7Iv8x6Bz7shU5e2+9Ks9gnGi5/oVa/jJhOruUeMoqGmnQBE/zzLCmjaWzoSEOVKma1aoTNkWaVTjQQFixlD4adtTAIylVR9CJxj69nSF9CIrAa6da/tG89gZ5I+kLUfdD2LzZUprr1hI4nfxHPTdyt5z2lbY+0jIJbw03Fp6MP+9s/3TaVIGHYRW4n5DFvBwRgLzTzsob2LZme4jUm3e7WSnwj8dLrZkU2wmrGyPf0P8CxwK0iwaCxKJ/9WVk8izLIYM5CrQ1bq5AlCCtrgLuEqV/f4Kh1dqfunfevADLCGISmaVXNYV7zoNnqSvlHXGDH3cvrl5X3K/nejWxl+kZMqbCV9CzmQFGtcEMIyEAfRyFRrCNlcche59Q4NfGZnKMx7qx+bwk0tQ+ppXjpYKxiSMBRlskwtgNOUDfGZeBQv3HTUnixv0PoInpFTJpbv6TaX2LiYJf393m7Al0E3C728Nx3vw6Nh4cB81mbtEz0ftYjIj96vAYsl3t/f5xdZgRbyi53Vp7O3TfCkkunn45/6Ha20=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(36756003)(426003)(508600001)(186003)(54906003)(16526019)(83380400001)(82310400004)(70206006)(2906002)(336012)(4326008)(70586007)(26005)(47076005)(40460700001)(81166007)(2616005)(6666004)(36860700001)(5660300002)(8936002)(1076003)(6916009)(7696005)(8676002)(86362001)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 16:23:15.9156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d11393-1133-418b-4d73-08d9db67ff4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
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
Cc: ruili.ji@amd.com, felix.kuehling@amd.com, Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After mm is removed from task->mm, deferred_list work should continue to
handle deferred_range_list which maybe split to child range to avoid
child range leak, and remove ranges mmu interval notifier to avoid mm
mm_count leak, but skip updating notifier and inserting new notifier.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reported-by: Ruili Ji <ruili.ji@amd.com>
Tested-by: Ruili Ji <ruili.ji@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 41 ++++++++++++++++------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2805ba74c80..9ec195e1ef23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1985,10 +1985,9 @@ svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
 }
 
 static void
-svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
+svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
+			 struct mm_struct *mm)
 {
-	struct mm_struct *mm = prange->work_item.mm;
-
 	switch (prange->work_item.op) {
 	case SVM_OP_NULL:
 		pr_debug("NULL OP 0x%p prange 0x%p [0x%lx 0x%lx]\n",
@@ -2004,25 +2003,29 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
 	case SVM_OP_UPDATE_RANGE_NOTIFIER:
 		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 svms, prange, prange->start, prange->last);
-		svm_range_update_notifier_and_interval_tree(mm, prange);
+		if (mm)
+			svm_range_update_notifier_and_interval_tree(mm, prange);
 		break;
 	case SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP:
 		pr_debug("update and map 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 svms, prange, prange->start, prange->last);
-		svm_range_update_notifier_and_interval_tree(mm, prange);
+		if (mm)
+			svm_range_update_notifier_and_interval_tree(mm, prange);
 		/* TODO: implement deferred validation and mapping */
 		break;
 	case SVM_OP_ADD_RANGE:
 		pr_debug("add 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms, prange,
 			 prange->start, prange->last);
 		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		if (mm)
+			svm_range_add_notifier_locked(mm, prange);
 		break;
 	case SVM_OP_ADD_RANGE_AND_MAP:
 		pr_debug("add and map 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms,
 			 prange, prange->start, prange->last);
 		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		if (mm)
+			svm_range_add_notifier_locked(mm, prange);
 		/* TODO: implement deferred validation and mapping */
 		break;
 	default:
@@ -2071,20 +2074,22 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 	pr_debug("enter svms 0x%p\n", svms);
 
 	p = container_of(svms, struct kfd_process, svms);
-	/* Avoid mm is gone when inserting mmu notifier */
+
+	/* If mm is gone, continue cleanup the deferred_range_list */
 	mm = get_task_mm(p->lead_thread);
-	if (!mm) {
+	if (!mm)
 		pr_debug("svms 0x%p process mm gone\n", svms);
-		return;
-	}
+
 retry:
-	mmap_write_lock(mm);
+	if (mm)
+		mmap_write_lock(mm);
 
 	/* Checking for the need to drain retry faults must be inside
 	 * mmap write lock to serialize with munmap notifiers.
 	 */
 	if (unlikely(atomic_read(&svms->drain_pagefaults))) {
-		mmap_write_unlock(mm);
+		if (mm)
+			mmap_write_unlock(mm);
 		svm_range_drain_retry_fault(svms);
 		goto retry;
 	}
@@ -2109,19 +2114,21 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			pr_debug("child prange 0x%p op %d\n", pchild,
 				 pchild->work_item.op);
 			list_del_init(&pchild->child_list);
-			svm_range_handle_list_op(svms, pchild);
+			svm_range_handle_list_op(svms, pchild, mm);
 		}
 		mutex_unlock(&prange->migrate_mutex);
 
-		svm_range_handle_list_op(svms, prange);
+		svm_range_handle_list_op(svms, prange, mm);
 		mutex_unlock(&svms->lock);
 
 		spin_lock(&svms->deferred_list_lock);
 	}
 	spin_unlock(&svms->deferred_list_lock);
 
-	mmap_write_unlock(mm);
-	mmput(mm);
+	if (mm) {
+		mmap_write_unlock(mm);
+		mmput(mm);
+	}
 	pr_debug("exit svms 0x%p\n", svms);
 }
 
-- 
2.17.1

