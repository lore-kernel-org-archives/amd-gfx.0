Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99880C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 21:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9E210E12E;
	Mon, 24 Jan 2022 21:12:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50EA610E12E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 21:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9YVHsjCFq3bK+TXByJ7NHKzQ2ImokkWwtKMC3TAemcZTTYv/R1803cthlbjsxDY12wt81Y4I4Zcd+QRIweK+8GveNhzn9aVCbMlp32+Tin4HTa7zhG+n0uu7woX7/WP+ez5Z93H93Hx9TNl+b5OMf0+GyWndD0J4mW5Phrbl5N9/Z0uSXaSHBrpqoIkzFwtie1oOVQzcS8T68TTGJUD8XFIrZKGozlOglwNXZbUVY8OwaXp6m/0R0oxQGXuMEAsPnUEw41z/OChydYqug2X4GNKgR8SauTpJlZ03jPyYN8BTlIbHWcupui6f9512q+el50OwFueizEfA+8h4INXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LUaAPOde1DywUxdnF80dMMqSxrd5Cm6ntNohrAIZSA=;
 b=N2Ji2Bl3Wj7I9n9cUuOCMHLWQEQLmuo1L4vhGa79qQSoPGdcl8HhyX//m7W5+D4+29r3ZPARdBcUQP+A+10PV7QU4Li2dhL1kVfoSTKLnI1lkfri2tIL7Bg+xyv/Pwy7IwNfhTSwcw6Iw23RUzYmbsmyZnrSOrfJGNhrTqtGJQisiosy/yfTiYjjXUGRm11O99qO2meBDs8IUwCfzJDHb77yKF2Dl8EOqr1AYd688w0WceQX7x5jwC3ScptFffFixHagnPbZJRR1jxYkoSb7wj9C2qRaQKhMVedX+xbG+ii3dA4w6qZO2fOkkznIzMw7wCeOGVaQzOMqoiHgMeeFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LUaAPOde1DywUxdnF80dMMqSxrd5Cm6ntNohrAIZSA=;
 b=cxt0G2jRHfQD6eb0Fx4pIynmPJM5suPjjOhgZwjw+f/Mz6WR34CxzKlyHv3gFxX5C80LHfuVuck/YBuNk1oPv4NtCUx1nNXtm5x6rXgpeiwHfmDrxQgOOFIf3EGoHaMjRgtB2odkNReAbJ7jRpjeSNazWI+l3vB7B/rh7vQ9+eY=
Received: from DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 21:12:11 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::a8) by DM6PR02CA0120.outlook.office365.com
 (2603:10b6:5:1b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Mon, 24 Jan 2022 21:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 21:12:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 15:12:10 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdkfd: svm range restore work deadlock when
 process exit
Date: Mon, 24 Jan 2022 16:11:44 -0500
Message-ID: <20220124211144.15161-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124211144.15161-1-Philip.Yang@amd.com>
References: <20220124211144.15161-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61303ffa-e3b2-4df9-2668-08d9df7e2fe2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55075748DF1B1ED141F7DC40E65E9@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQGVxXg7zUNEWSeC3sRtC34jk2gqbGIBIVWD4dxHuX//rNeqTJwT1XCUKwQMVMlbBQx0YB06p8k65E3+z+sP/uK7XBJ4t3b1p0rIwSR1t5ZcOhbNQiLjH0ubugssA7Rwm2x4dh+KuM1MlMk6WPua2CfIHGmXnUOybUj+l4D7D5YpiOUwN7KAdWkGru9UbucPXo2ZtqYqpORpL52ZyKFyQaJgbtMVfspIm/W/l84bxvOdO1DdsEXtV6CuG5jdoWYUgUlWJbkwQb2OgG86gHdf0ojGvW6/DFZPEPRtjfqIYVyFge7Rcn4E6PZV/wxQkmj/AqiyPoWkyDsQAQabW0oQ2L1G46CM+/DdRysN+0lF7k4sS1iVtR9ycJnDvXoQkaobhOGmfPfPtCyAlNFB4Lq71Y4ek2RNS/FduiZXUm+/7hi0yI03svO5OVYe1ItBgphKwtkVIIaB1jDjWtzfHQSdGTtpNpHJehCIxMYjBRhtZ+KGTeShz2O8slYcwpO/CLJNzzDufcbo5z+4qdKXye92ECGSX5m2nWtUecCGR92j7YikJcFpQbWHIZiuCj/ziy5CaFRcSgi/AQ/5DP9TtKGlQoISr9B6Z0lRzHx+NomP5xsfcmOy3PYaL+YI95SuTqQfkB/NMqzQwvaH+giApqJakaBfuZanc2zgXZb/DpaJTxVafaUGRDIVC5q9CsW+2E6OIalR6x4C04MzvoLBlAz874vnAIq4KBqk6mprgdNpwxHHo3hkLfMAioXerQEO4jfTjbP//2NyjZcJMC3rps4D96boPrQXBKPNEz+MkQmTiwg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(1076003)(86362001)(83380400001)(70206006)(40460700003)(70586007)(7696005)(6666004)(316002)(2616005)(4326008)(54906003)(356005)(2906002)(336012)(508600001)(426003)(36756003)(26005)(47076005)(186003)(16526019)(6916009)(8676002)(8936002)(36860700001)(82310400004)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 21:12:11.1078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61303ffa-e3b2-4df9-2668-08d9df7e2fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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

kfd_process_notifier_release flush svm_range_restore_work
which calls svm_range_list_lock_and_flush_work to flush deferred_list
work, but if deferred_list work mmput release the last user, it will
call exit_mmap -> notifier_release, it is deadlock with below backtrace.

Move flush svm_range_restore_work to kfd_process_wq_release to avoid
deadlock. Then svm_range_restore_work take task->mm ref to avoid mm is
gone while validating and mapping ranges to GPU.

Workqueue: events svm_range_deferred_list_work [amdgpu]
Call Trace:
 wait_for_completion+0x94/0x100
 __flush_work+0x12a/0x1e0
 __cancel_work_timer+0x10e/0x190
 cancel_delayed_work_sync+0x13/0x20
 kfd_process_notifier_release+0x98/0x2a0 [amdgpu]
 __mmu_notifier_release+0x74/0x1f0
 exit_mmap+0x170/0x200
 mmput+0x5d/0x130
 svm_range_deferred_list_work+0x104/0x230 [amdgpu]
 process_one_work+0x220/0x3c0

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reported-by: Ruili Ji <ruili.ji@amd.com>
Tested-by: Ruili Ji <ruili.ji@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

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
index 225affcddbc1..1cf9041c9727 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1643,13 +1643,14 @@ static void svm_range_restore_work(struct work_struct *work)
 
 	pr_debug("restore svm ranges\n");
 
-	/* kfd_process_notifier_release destroys this worker thread. So during
-	 * the lifetime of this thread, kfd_process and mm will be valid.
-	 */
 	p = container_of(svms, struct kfd_process, svms);
-	mm = p->mm;
-	if (!mm)
+
+	/* Keep mm reference when svm_range_validate_and_map ranges */
+	mm = get_task_mm(p->lead_thread);
+	if (!mm) {
+		pr_debug("svms 0x%p process mm gone\n", svms);
 		return;
+	}
 
 	svm_range_list_lock_and_flush_work(svms, mm);
 	mutex_lock(&svms->lock);
@@ -1703,6 +1704,7 @@ static void svm_range_restore_work(struct work_struct *work)
 out_reschedule:
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
+	mmput(mm);
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
@@ -2840,6 +2842,8 @@ void svm_range_list_fini(struct kfd_process *p)
 
 	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
 
+	cancel_delayed_work_sync(&p->svms.restore_work);
+
 	/* Ensure list work is finished before process is destroyed */
 	flush_work(&p->svms.deferred_list_work);
 
@@ -2850,7 +2854,6 @@ void svm_range_list_fini(struct kfd_process *p)
 	atomic_inc(&p->svms.drain_pagefaults);
 	svm_range_drain_retry_fault(&p->svms);
 
-
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-- 
2.17.1

