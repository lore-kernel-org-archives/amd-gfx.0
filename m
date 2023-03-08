Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDFAC678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 22:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F132A10E727;
	Wed,  8 Mar 2023 22:04:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF84D10E730
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 22:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RECuBPicQ+af67T3ltLfOOJfIU8tdZdTCY5eOFkOXyZv1pHTjMdV1A86TBVcZI7HxXZ476axmxv0s47NiFvTUT/eXi8C3Rg3amQ7u19HT7M8weHN+HmxX9dIsYzFUSCOPROLnWHkKiiOU82TTvaStCsDKK1SMw1yL44lhJFANwZHNSE777+o2kbH/jsgvyb6hm0o5Lx7bunio4q42jrBCVtQWTn5yy/UGYkAa13esWuoIkXssUTcTjyn8asbsHI9nV8TiKUeLzOJgv1PzLHpGq2G1RrmQdiCSILRoJgqsaubVlLLIxYjEpyGkYTuBp8EcxS82DT9BodUHxIDltou2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJpLaDmv06mSunkGPVzIA6M/UWabkqk0+8NBaudN/Qc=;
 b=CTqLKk/pooiAep0OCwdZp7ReN3i4WY6f48OV+gWL8Ni+FwB51PuxFuKog4hAgzoo371BPSoQP8RbGlu0RV2oVZxnvAxQP0StQasOc/RDZC34SjTnsdmBTYqM5TuX6TAM3BsRNwYhfrQEUSv4eeIlZSyRUclFLWr5hUTHHOsRPntws/N6RP00c30BHk5PVOA3YyIDkWCf/Nzc6TYeLrw5jc0FJ/sl3n+Boc7sh9XAfAHO2rhykDYqVzSni/b63YPSLXXUbx6n7DpxSx9DnL86Pj5g3kzkHZek6oOmSKxXECvSC/t4GnMRnYjkbJKPr4yKuA14dADZiILhLHVr5np42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJpLaDmv06mSunkGPVzIA6M/UWabkqk0+8NBaudN/Qc=;
 b=MxyW9bIa8e5AyetBsV7eLHfE43NK1gbOqvYXOAa1r8Qum5r4WIU0yGJnTRnxrceQRsq3DpaMTHXt5aC2A90AbFrZuCLML/82e3uFJKlIFCL3CD4qZt+K/LvChZSA/kddIBXHpnrzauqjrbBs/hy5H6WqNdvJ7X3gZ32DnNqzgsk=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 22:04:35 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5::4) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 22:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 22:04:34 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 16:04:33 -0600
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Date: Wed, 8 Mar 2023 17:03:57 -0500
Message-ID: <20230308220357.3092295-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 7106eeab-baf6-4da6-a3ae-08db202119f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aa+NcBmZy9RmdOCiROVdvqYLz2XaKNWQgLhlCMcSy6uaUnC9ABuRbZNlMeuJlNifNKgpsnYY23t19elnW+MLqqroCpiXGgsVCh0tsNnjJ+7RKwq5J+PHPy4TUYFGFEOtmCFd8AltNvPgY14aAvSWqNBI27zG1qu87tXxmge5Da9yGQVWqUCEU235SML6TKc23Li94eNrczpm1JoE9gZJih1TMH9JKKc5ISzAmfhZfG+YPAmDupFEcKINrPNOnmNIxe6OfdNqOQS/6F3oHrNuY2/ptvGEG9vVk27M/zhNqRCh/1xdoTZ1+GbsnvG9sP4z1bc5FadGz8hJjE1iIx5oOdLwr7rW28M+058j+/2VuOj3GpWAaMeAQ9vK0hhxF4ZgGXs8p8LEfKCfK38laCNKOdYfib5jxZOjHUQXvbrsdo/vdTpvSjl1qLkK9kXmkMteD7wqh/n/E3u5pCEfkMgUPJeJQO5oZ9rx5fN3lEOW9HBmLN6BtVfjezPIzcXYOpknU51KdeyNMfPPsHman2hNihSjfaCaTmevYrQNEfroGGp03kJ/xtx/723X2DDPnTVZZ8Q3Bfa2wZcKPWYOiQXGzd6ZbZyJeEPNtn1JvkfuDC6KB3Vyx58rTD4tbV0bdnOlhPq0scALF3SEUAn+SPwTy3lxnQAupgDjTJbbRqaT3JeypCTw6UXbLNiZ6MPY1yNZr4ULEkJF6hu23B7OgYXxgpTTahjrunz1b5KD26uId4I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(36860700001)(356005)(81166007)(82740400003)(4326008)(36756003)(5660300002)(8676002)(2906002)(41300700001)(40480700001)(44832011)(6666004)(8936002)(6916009)(70586007)(70206006)(82310400005)(16526019)(336012)(40460700003)(2616005)(186003)(83380400001)(47076005)(426003)(1076003)(7696005)(316002)(478600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 22:04:34.3385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7106eeab-baf6-4da6-a3ae-08db202119f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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
Cc: David Belanger <david.belanger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Handle case when module is unloaded (kfd_exit) before a process space
(mm_struct) is released.

v2: Fixed potential race conditions by removing all kfd_process from
the process table first, then working on releasing the resources.

Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 80 +++++++++++++++++++++---
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 09b966dc3768..8ef4bd9e4f7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -26,6 +26,9 @@
 #include "kfd_priv.h"
 #include "amdgpu_amdkfd.h"
 
+void kfd_cleanup_processes(void);
+
+
 static int kfd_init(void)
 {
 	int err;
@@ -77,6 +80,7 @@ static int kfd_init(void)
 
 static void kfd_exit(void)
 {
+	kfd_cleanup_processes();
 	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
 	kfd_procfs_shutdown();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ebabe92f7edb..dd396a93a68d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1167,6 +1167,19 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
 	kfd_unref_process(container_of(mn, struct kfd_process, mmu_notifier));
 }
 
+
+static void kfd_process_notifier_release_internal(struct kfd_process *p)
+{
+	cancel_delayed_work_sync(&p->eviction_work);
+	cancel_delayed_work_sync(&p->restore_work);
+
+	/* Indicate to other users that MM is no longer valid */
+	p->mm = NULL;
+
+	mmu_notifier_put(&p->mmu_notifier);
+}
+
+
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
 					struct mm_struct *mm)
 {
@@ -1181,25 +1194,78 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 		return;
 
 	mutex_lock(&kfd_processes_mutex);
+	/*
+	 * Do early return if p is not in the table.
+	 *
+	 * This could potentially happen if this function is called concurrently
+	 * by mmu_notifier and by kfd_cleanup_pocesses.
+	 *
+	 */
+	if (!hash_hashed(&p->kfd_processes)) {
+		mutex_unlock(&kfd_processes_mutex);
+		return;
+	}
 	hash_del_rcu(&p->kfd_processes);
 	mutex_unlock(&kfd_processes_mutex);
 	synchronize_srcu(&kfd_processes_srcu);
 
-	cancel_delayed_work_sync(&p->eviction_work);
-	cancel_delayed_work_sync(&p->restore_work);
-
-	/* Indicate to other users that MM is no longer valid */
-	p->mm = NULL;
-
-	mmu_notifier_put(&p->mmu_notifier);
+	kfd_process_notifier_release_internal(p);
 }
 
+
 static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.release = kfd_process_notifier_release,
 	.alloc_notifier = kfd_process_alloc_notifier,
 	.free_notifier = kfd_process_free_notifier,
 };
 
+
+void kfd_cleanup_processes(void)
+{
+	/*
+	 * This code handles the case when driver is being unloaded before all
+	 * mm_struct are released.  We need to safely free the kfd_process and
+	 * avoid race conditions with mmu_notifier that might try to free them.
+	 *
+	 */
+
+	struct kfd_process *p;
+	struct hlist_node *p_temp;
+	unsigned int temp;
+	HLIST_HEAD(cleanup_list);
+
+	/*
+	 * Move all remaining kfd_process from the process table to a
+	 * temp list for processing.   Once done, callback from mmu_notifier
+	 * release will not see the kfd_process in the table and do early return,
+	 * avoiding double free issues.
+	 */
+	mutex_lock(&kfd_processes_mutex);
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		hash_del_rcu(&p->kfd_processes);
+		hlist_add_head(&p->kfd_processes, &cleanup_list);
+	}
+	mutex_unlock(&kfd_processes_mutex);
+	synchronize_srcu(&kfd_processes_srcu);
+
+	/*
+	 * Release resources for all outstanding kfd_process collected.
+	 */
+	hlist_for_each_entry_safe(p, p_temp, &cleanup_list, kfd_processes) {
+		kfd_process_notifier_release_internal(p);
+	}
+
+	/*
+	 * Must be called after all mmu_notifier_put are done and before
+	 * kfd_process_wq is released.
+	 *
+	 * Ensures that all outstanding free_notifier get called, triggering
+	 * the release of the kfd_process struct.
+	 */
+	mmu_notifier_synchronize();
+}
+
+
 static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 {
 	unsigned long  offset;
-- 
2.38.1

