Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E9CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC3C10E212;
	Fri, 14 Jan 2022 20:34:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789D410E20E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb7HAAqGfYAGKLFq16g6DiHykfCAiZtKIf1W0YUfNwssmHnXz3h+eolgPlTYFWCo3oXmBW0K6l+Ga9f5aY1hxBgCBouCvEYo7sgOeM+E+1sJl+LcNUgl9ZcMAMZWSSgCRuCi/W989+Z0Ruoz3jJP9L8haU3QuSSqR7ovIO9JpoaQRYAVR1CC+n1B93Yp/VJqpF6tHPDOijjypGtowNiTlXglne7qjgR4duXo4cpVaLZ4sTYc8uGq10bF9xjAb2zGI1bLaxOjMmtITgLwZ3VI08xHYOASzvrV8geLl+JZrI2zA/CEVUIEw1xEbamtikGZ9233leErkBa5pGBApyEG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHscfYTjZevzLkiuYijsLtktf2EmufKo7LzTaRVAmFo=;
 b=BCDc+JVjbVqF8qumNVUBYV1vGbAgagKZYEM+O1MPcSk+SfBZ/phcbhqrmgdhPxXPXjC180vB6TBiBQFQruhgpSa+9X+hpDMKBUf4EUHSfII97sDASnQtBaBTgq232J+NUm0mAurh4+LF/cYu8i0kyu09Iy5uGdMB2aCt7/yhLtUGCOpLGduY+i9nRH7vfb2OaWNTWuTWepLwe5C8s3Pj0MMCDUTgt3T/yzIe/00BczKZn6UQAATxd3FM0FWR3aotnD6zydFHBe8pMN/60YOWPhUpiB9wwtMZSKW21mVqUJzKiOzBzTLMAjD0SSxIw9rPg9EEOwdnf7cYwwj/DJA5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHscfYTjZevzLkiuYijsLtktf2EmufKo7LzTaRVAmFo=;
 b=YKLQqmUvwGno4FMAgLcE0AyNAGJ+gzmvZkoYiFalTJ0voRbe5uNJL1e2SVjH0TytO5WC+TO4t29zPgipvqVZmE6BCPARqzY+OPHyaUJjd+bvvrWpSX/I7Ek6a3+28uxu6QyYTPVOnh65DM43NseGXnXCOVBT0mHGYJoSS2arOEs=
Received: from BN0PR04CA0168.namprd04.prod.outlook.com (2603:10b6:408:eb::23)
 by BN6PR1201MB0097.namprd12.prod.outlook.com (2603:10b6:405:54::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 20:33:14 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::1a) by BN0PR04CA0168.outlook.office365.com
 (2603:10b6:408:eb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 20:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:33:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:33:12 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdkfd: svm range restore work deadlock when process
 exit
Date: Fri, 14 Jan 2022 15:32:52 -0500
Message-ID: <20220114203256.19821-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203256.19821-1-Philip.Yang@amd.com>
References: <20220114203256.19821-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97c472a-1338-4d87-75c6-08d9d79d169c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0097:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00977C78DF8972B28C8CD2ABE6549@BN6PR1201MB0097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8NlKSwR1K+7jxOSdMcB+Or/sdQEAlX5U/368gvHpJeRGQyv5qn11w4a8GT6x7w7ZOTTqSBKIceOJka6XV6LEbRGHxf0/q1oIbkvWtR64O7gNQCJYNfPUEptsiUmppGc+7TAGdc+TLPT2vxAdAzMrJ3G3uolC9XmM4n3RqEvtLEmIZ3V9ysmgDrLnei0lS0gYeDEh7dPgCQvxL/LTgKvZylc/X4xtddVvnJn0Zyk10XXvqUzLI2NTX2sbgjhW2T/DhU45/du8JkqHhwVIXnBGS/ZlxPJrdWsNWYQi+LamJl8/5DP556e21WpOrTmy7C9gQ+9wVASBRMEvymj+0kKlng8yfzTaomnFyWZWTfYV0Q0lOrv60n86OBi0iwZeiYW+Rtuch+7TPGD8EVVUwvIqYJwedtSJQHwaagzGUpRqDBLS+YAvH3WVf3o4n1LC4bqkNJMoEHIDorEBInRI/tGDzsZPEGwrFcupJ7YEvU9tvafhKaheLY6qq76i3X8XJcwNQdoNd9QAMJ7siRXs5dMWOmlZLUvk/ChxR8W8xEAipyn8TrpeBgbLLJzF/mE2yWHxRQyADzQvXMyZY8d8qRfe+7tmYNaxgkUd9Z4KcjKwpR/5+kFIhZ4DMc8cFJOr/arvUz2V7gwwpTJWAmMDB9lVKHSumvWFAL9IBbAOqPGQ/UmSC40bBt9Ps7AFKfv2qZ+iXza2tbbU8vQ0up1LIiw1Q+Zdz0B+A2fATyN3dy3CcZ/tzbPGmucKjteIMzTkyrWmRCRuj2mMNMyOnvmyMDyO/za8R0e4UF73FEzajM/AUc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(4326008)(70586007)(1076003)(70206006)(2616005)(336012)(2906002)(82310400004)(86362001)(40460700001)(356005)(36860700001)(83380400001)(7696005)(6666004)(8936002)(5660300002)(16526019)(8676002)(426003)(54906003)(316002)(186003)(36756003)(6916009)(508600001)(47076005)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:33:13.8513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c472a-1338-4d87-75c6-08d9d79d169c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0097
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_process_notifier_release flush svm_range_restore_work may cause
deadlock, because svm_range_restore_work calls
svm_range_list_lock_and_flush_work which takes mmap write lock. Move
flush svm_range_restore_work to kfd_process_wq_release to avoid
deadlock. Then svm_range_restore_work needs taking mm ref.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reported-by: Ruili Ji <ruili.ji@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 14 ++++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d1145da5348f..74f162887d3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1150,7 +1150,6 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
-	cancel_delayed_work_sync(&p->svms.restore_work);
 
 	mutex_lock(&p->mutex);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2805ba74c80..37b3191615b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1643,13 +1643,13 @@ static void svm_range_restore_work(struct work_struct *work)
 
 	pr_debug("restore svm ranges\n");
 
-	/* kfd_process_notifier_release destroys this worker thread. So during
-	 * the lifetime of this thread, kfd_process and mm will be valid.
-	 */
 	p = container_of(svms, struct kfd_process, svms);
-	mm = p->mm;
-	if (!mm)
+	/* Avoid mm is gone when svm_range_validate_and_map ranges */
+	mm = get_task_mm(p->lead_thread);
+	if (!mm) {
+		pr_debug("svms 0x%p process mm gone\n", svms);
 		return;
+	}
 
 	svm_range_list_lock_and_flush_work(svms, mm);
 	mutex_lock(&svms->lock);
@@ -1703,6 +1703,7 @@ static void svm_range_restore_work(struct work_struct *work)
 out_reschedule:
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
+	mmput(mm);
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
@@ -2830,6 +2831,8 @@ void svm_range_list_fini(struct kfd_process *p)
 
 	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
 
+	cancel_delayed_work_sync(&p->svms.restore_work);
+
 	/* Ensure list work is finished before process is destroyed */
 	flush_work(&p->svms.deferred_list_work);
 
@@ -2840,7 +2843,6 @@ void svm_range_list_fini(struct kfd_process *p)
 	atomic_inc(&p->svms.drain_pagefaults);
 	svm_range_drain_retry_fault(&p->svms);
 
-
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-- 
2.17.1

