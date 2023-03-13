Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241ECC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 18:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C017310E5FB;
	Mon, 13 Mar 2023 18:35:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CD810E5FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 18:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7iXeZZcjR6te5LcpCS6n4DdX+Dw2VYOY24JEowf6sI/fv1t79E1xfrOxng5Acmt1UsyU9l5rOTrE3VrKp4goK984FLtXZSS8Yrd12nOXrcv0D2HpC9w2x2Tpq6M8zD1/hmexOOP2BwfT8tg/WVgEssrWSz0I6C/GaoY2K/Ij2qHq6aB/SVSGw5pmD1rBS9MNnxu1RdBoq7lU0Cc7yp0MO1749ulDRfamIaTyR+/IpKUuYDPait9JATb8XkimSEBxJs1vd6enUvTqXrl9jd2T7Ho33+d+g8rZAeDyuaU9LsoVcOMWccgTVkvDgVqV+Cr6Fua0dcGl1fSOs/UFY6exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty/Pgl7xaw+0de2NpHNvRTb7fUKbhfcL9GBrjRGjwEo=;
 b=gYDpTTMDNbtbA/KG/AQM8R1BqvogOKXkHZDgi06PYpEaagXcFnqThs0flaW3+IdKbbjEt/u1VUUCZ51bSpzFU7LxV/Yf5/MKQxweWwPIT6xGK7hOfvhOD6jNNdfLVpeWWsu84TeWmTQ2QVh+UsUqK2C+Xq35uMGoEwzx9TNRRp+f+SDYdBexzG/AuXLvUZnsNdX1KvuVGiQ3bYRJ9cfOCZt1a2iDG6Go/ELZO2bwrJYqTrZ8bYRgsYEqxqKGSZm5TFsiq2zYTXUtG/sPlyTV52EHBwc2jFFDZG1UlwBHkCS7nepbKUaoz7lI7DPgTTzulVjDBeAHN5OUaNSWn7Ajig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty/Pgl7xaw+0de2NpHNvRTb7fUKbhfcL9GBrjRGjwEo=;
 b=CgW10XTiYXEa8k4IWpeZODz74gsrZrAKwnW+UbwqipatHWinimPlGxU5W+idYlcf2QRE6NzM514h82a3zzdwpKYsr/bpFbdBtLrSPBCsY/uLd5nE9wfLGV6giX9Pc0csvgyfCAIzAh33TbstufOdS0s38J/nT7eneNtzmFhI/EQ=
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 18:35:23 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::64) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 18:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.11 via Frontend Transport; Mon, 13 Mar 2023 18:35:22 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 13:35:22 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Date: Mon, 13 Mar 2023 14:35:06 -0400
Message-ID: <20230313183506.3374202-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ad1c63-d5b6-4b5a-2901-08db23f1b4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfvQK9LA0oJAV1tIz/e6G7G2E3A4mPlfuaIN8Abie+zhyy0GJ5SMQIO03bCQgcEtEzDgXkZROxDAcD6PckY5O2Mt9W7CyhuTBapSXsp88T0cnkZBLAQ2Mxnzn1PIXY6f7CVO6o39wJcMmHEzeyMJgc7OwQ4/PNfuOykj6tNU6g8NO7CPx0Mv0Mc/Dkzgmm8+7Nk95IV//rn6qYF4kYUB3gq5ukMI8vkJbcEdYOaBnkreDHm7bFL/SZHSKPzXK6hbwVOydqo4X36rMErW0Hd+oPu+KbEbl3wGfUA+8klBi4lFDNPr6zi/7eJTr9kb6kppow4P/N0cGchejW6LVRQ5e8d706iiFgBJccY2nnUwiO0zEd2tZPNIX9B9M9T/eENVS5zScAuFrFTXMKHbLDN4ozjGf0osOLa99ujMingckmLZdmrB8Ui0Dzmhm1z8KeV/qxPfMrl4Cyllc09biz9nxPjtFZAIw9YEeEgAyYPeYEttNZCWvmxQbaHihET3g4OGm5Il3L6qfQyWs7w0qbC1zfk6QXMyZadARINYA4eXkczZ7H3wggBb2OHmwLhUPNLnsNV8Z4yllThsZio7jDifccnZl81dtcrn5W6xmwFbgPTqwmorGxXHPan4VtQOcE9VbLygK1W2AIIESaotEvpuB1hLcJbwzbpnip+2Uz8EMBq8Mbs3v2m3tECxQRORCxzzgbQ6FH9did39u4VOxUO9S175jbtAbsYqZwZ4IFC6XIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(83380400001)(6666004)(7696005)(40460700003)(26005)(44832011)(36756003)(6916009)(356005)(16526019)(40480700001)(8936002)(1076003)(86362001)(41300700001)(2616005)(4326008)(186003)(47076005)(336012)(70586007)(70206006)(426003)(8676002)(478600001)(82740400003)(316002)(36860700001)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 18:35:22.8541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ad1c63-d5b6-4b5a-2901-08db23f1b4b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
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

v3: Fixed loop element access / synchronization.  Fixed extra empty lines.

Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 75 +++++++++++++++++++++---
 3 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 09b966dc3768..aee2212e52f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -77,6 +77,7 @@ static int kfd_init(void)
 
 static void kfd_exit(void)
 {
+	kfd_cleanup_processes();
 	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
 	kfd_procfs_shutdown();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bfa30d12406b..7e4d992e48b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -928,6 +928,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev);
 
 int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
+void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct file *filep);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ebabe92f7edb..5614ef2ac49e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1167,6 +1167,17 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
 	kfd_unref_process(container_of(mn, struct kfd_process, mmu_notifier));
 }
 
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
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
 					struct mm_struct *mm)
 {
@@ -1181,17 +1192,22 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 		return;
 
 	mutex_lock(&kfd_processes_mutex);
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
 
 static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
@@ -1200,6 +1216,51 @@ static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.free_notifier = kfd_process_free_notifier,
 };
 
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
+	hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_processes) {
+		hash_del_rcu(&p->kfd_processes);
+		synchronize_srcu(&kfd_processes_srcu);
+		hlist_add_head(&p->kfd_processes, &cleanup_list);
+	}
+	mutex_unlock(&kfd_processes_mutex);
+
+
+	/*
+	 * Release resources for all outstanding kfd_process collected.
+	 */
+	hlist_for_each_entry_safe(p, p_temp, &cleanup_list, kfd_processes)
+		kfd_process_notifier_release_internal(p);
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
 static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 {
 	unsigned long  offset;
-- 
2.38.1

