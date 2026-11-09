Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96687606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KgO18mwZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F42910E6D2;
	Mon,  9 Nov 2026 21:15:51 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF7410E6D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 21:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o80R/WYMl5Jo7oDOy5OyLFtiUBCHqQtM4de43pOjIp8Lh9jTwOHto3JXPLsV38ykBRY2ShgczzEbOlLsSfIAC4HzhMW8+4ubdDDEkHYrs6lOnGYzKnsW/z6pmskR+4hgMBl0156YKDFKG+8YGtGxPaYAcF2SemK72zvJIqncJJaJTt9oAJD7PTRm05lO35sep3aLI9BSqUn+2Es7OpnWymSft0HTdkn3QX/HBr6eKEIPYfUnhyrXVrqBNe94j6XE4EfmLKjnw5gkHbOq2jGDRUV96IjLuFqXNOiM6cbwKktj2OcgWa0ceHBfe1mBacTLhx3957IK+AFe/FA01hdBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gACn+rteHuKs1aG9ljingrEHdSyPO8T9myAY74quXPA=;
 b=G/FdzBZIBu5RFr7LWSKJLQRwx5myzHCWl0eQkD+7ETBT6vF/1bQcX7bmmnzPhYnbAbnxwQ6HlMb5cpAuCtJCssifoGWHG6SFdR9BsoU3bVs024tJAbnejB80+zNX7JkDLKHp8/S1TNKgxq7zGxm1TnfVRrYPI6pc8oq+5mxjqNYxnpP6dyMgmeReCAtugTAQa9uxpQ7QGfJc9u976lDaeNtuJv+tbGtLczPaV4OXIsjxbRRMSBdYjntVKKWlvjg7TQ+KLrZR0jtjGGrgn80sYaY5sqfmDkamYOxt+h9m1KN5llPnM9EUUj4S5Q8Ol8M6WzB1DReI515W8R6Kj6ySRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gACn+rteHuKs1aG9ljingrEHdSyPO8T9myAY74quXPA=;
 b=KgO18mwZVFu0qRSM+yeIg6E/Sj61ThJt5jVL7Vw1WgYLAa26pPPqH0WB0vPGNtYRIavYHfxRO46/jeea+867RWprAf2reEfF+HxuHIpCxJlmDjd2/a1R2HGmONj31GMLzZ+oqipNDcyGEqfY+fqcRQEq1X0tLukliit+dKLMHPg=
Received: from CH5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:1f1::10)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 21:15:38 +0000
Received: from DM3PEPF000265B7.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::a4) by CH5PR03CA0020.outlook.office365.com
 (2603:10b6:610:1f1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 21:15:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B7.mail.protection.outlook.com (10.167.23.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 21:15:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 15:15:37 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Shashidhar.Gandham@amd.com>, <Qiang.Han@amd.com>
CC: Qiang Han <qiangh@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: wait for the queue quiesce in concurrent SVM
 evictions
Date: Mon, 9 Nov 2026 16:15:14 -0500
Message-ID: <20261109211514.3737466-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B7:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 48063ab6-1136-433c-96f9-08df3ea69a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261026121527099003|261028144727099003|11063799006|56012099006|261021123027099003|261021133027099003|261021130227099003|261021135927099003|261021121427099003|261022113327099003|261022115727099003|261022105027099003|261022075727099003|261026130827099003|261009223027099003|261026140227099003|261026135527099003|261102123227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: kr9tAOYKTScZBFWWYecUf7XXXhwBlQgF9lxjaRBDHWxbbyky/nS7O5LHSjN5k6XDBWIyBRCTvWa5rKer1nZvmWmhRg7q8WM7y9FBssXqtxJCDGGKqypAI5kXgjSPp2sjFgouLsASGso/RQ4qtVY8s2Fry/92b6arAji1hOOy/vxtVr+yMeaL6MjA0g8fMOwLG4nm2VgU2f/GUsgXMHEHTCvexqYr2mnlhXmXkea4VjrG48tADATBU3+ruOy0JMgHX0BvDNZO250uRFSdRA3FZREh2n7pBztzfEzUCqHUW5E9iBH2XJOMh5qB9lV466I8Ms1W1igoH1iUh3Iq11IEKy+NFKzO8g/tH1JDSgqAz79YXH7VCB8r7qSxg2vQtxtJG7dZjDNn06XE9EWPkoE85KAzIknTLyRtjV6hTQP4AN+Emcy1y9ZbEEtklUHudGh4kFJttsFhtNJyoYEyId9Viot5ECFkkG96ywHytBCixGD237lWs798Kk4o7z64efVqy6kZri6hmN4jb9Yp1XkDKe0MeZLPJpJcbfFDoBD83Q1CDF7wRGiIdxtxNNIh/ungpS9AtFRQMI5O+sLaP5RLOnWIkTia34cY6PRktiI20rjKJKO17hJLub+GqAdXpiuHSWLN2XgEQBM3EwyuFzrjSgRu+iYQxAkvdteSkwtm/3ydDO0x6pMmwFEFEoqHmgGjaFFbnFA1+uI+XJa733jTHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261026121527099003)(261028144727099003)(11063799006)(56012099006)(261021123027099003)(261021133027099003)(261021130227099003)(261021135927099003)(261021121427099003)(261022113327099003)(261022115727099003)(261022105027099003)(261022075727099003)(261026130827099003)(261009223027099003)(261026140227099003)(261026135527099003)(261102123227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UWYZt6ac/O1kP6KT9QkrNgo7H070ue4NvMulLF7d6G47cZ5L3SpzAAhf4twxlNEwvnewjf2wZVVltWw/dI0HJBW/7Rt/aOgIUpy5mh/tDpal2RyKA0Ewnr8EwO1mSK96tHwGT3KSrR+nbKkn3ljftdPc6evBiVbY01CabCwsPF0NegqX447NyIGVs9WL8n4tzK9JzkP+UDNBXVV3G4Az1ikm4ZAarnUAxouAlCE9BpwiTb9Hu+jkOJXbR6p2/MGPlGJC0399Zcc7ehA9aT9uMkwWsFeWKE3qnR8aag+EUuPXGFeQeYDmZC/AuN1maA4SiRL0c1lg6gMmsj/bXCajW7LRslLRsaMrHO60nQzFnaBTGJNlDr+c3FpBgkeGWhu+CHemqg/iVL/0DRAhx3QCywhMeo9rgmBbYD2sQ/WfPqSwrNFCyYzD94npXzP2UFDt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:15:38.0015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48063ab6-1136-433c-96f9-08df3ea69a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Qiang Han <qiangh@amd.com>

With XNACK off, svm_range_evict() leaves the GPU page tables in place
and relies on the process's queues being stopped before the MMU
notifier returns.

Only the first eviction (evicted_ranges == 1) calls
kgd2kfd_quiesce_mm(). The quiesce preempts every GPU the process has
opened and takes milliseconds. Any other range invalidated in the
meantime sees evicted_ranges > 1 and returns at once. The core mm then
frees, migrates or reuses the page while the queues still run, and an
in-flight SDMA or blit copy accesses it through the old GPU PTE. The
result is silent corruption of the copy, or of whatever process now
owns the page.

Hold a new svms->evict_lock across the first evictor's quiesce, so that
concurrent evictions return only after the queues have stopped. This is
the scheme amdgpu_amdkfd_evict_userptr() uses with
process_info->notifier_lock. evict_lock nests inside prange->lock and
is taken nowhere else. Under it, the quiesce path takes the dqm lock,
which is already used in MMU notifiers (memalloc_noreclaim).

One way to reach this: a pageable hipMemcpy() larger than 1 MiB. ROCclr
pins the buffer with hsa_amd_memory_lock(), libhsakmt registers it as
a KFD SVM range, and host memory pressure (reclaim, compaction,
allocator purge) invalidates the range.

Fixes: 8a7c184a16d7 ("drm/amdkfd: svm range eviction and restore")
Signed-off-by: Qing Hang <Qiang.Han@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 35 ++++++++++++++++++---------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 158fa70a1a8e..581fb7ceba40 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -909,6 +909,8 @@ struct svm_range_list {
 	struct list_head		deferred_range_list;
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
+	/* serializes XNACK-off evictions with the queue quiesce */
+	struct mutex			evict_lock;
 	atomic_t			evicted_ranges;
 	atomic_t			drain_pagefaults;
 	struct delayed_work		restore_work;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3688ae7ba35e..8b84333a85b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2141,21 +2141,30 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		if (prange->start <= last && prange->last >= start)
 			atomic_inc(&prange->invalid);
 
+		/* The MMU notifier must not return before the GPU has stopped
+		 * accessing the invalidated pages. Only the first eviction stops
+		 * the queues, which takes milliseconds (HWS preemption on every
+		 * GPU of the process). Serialize all evictions of this process so
+		 * that a concurrent invalidation of another range waits until
+		 * that quiesce has completed instead of returning while queues
+		 * still run on stale PTEs.
+		 */
+		mutex_lock(&svms->evict_lock);
 		evicted_ranges = atomic_inc_return(&svms->evicted_ranges);
-		if (evicted_ranges != 1)
-			return r;
-
-		pr_debug("evicting svms 0x%p range [0x%lx 0x%lx]\n",
-			 prange->svms, prange->start, prange->last);
+		if (evicted_ranges == 1) {
+			pr_debug("evicting svms 0x%p range [0x%lx 0x%lx]\n",
+				 prange->svms, prange->start, prange->last);
 
-		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
-		if (r)
-			pr_debug("failed to quiesce KFD\n");
+			/* First eviction, stop the queues */
+			r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
+			if (r)
+				pr_debug("failed to quiesce KFD\n");
 
-		pr_debug("schedule to restore svm %p ranges\n", svms);
-		queue_delayed_work(system_freezable_wq, &svms->restore_work,
-			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+			pr_debug("schedule to restore svm %p ranges\n", svms);
+			queue_delayed_work(system_freezable_wq, &svms->restore_work,
+					   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+		}
+		mutex_unlock(&svms->evict_lock);
 	} else {
 		unsigned long s, l;
 		uint32_t trigger;
@@ -3437,6 +3446,7 @@ void svm_range_list_fini(struct kfd_process *p)
 		svm_range_free(prange, true);
 	}
 
+	mutex_destroy(&p->svms.evict_lock);
 	mutex_destroy(&p->svms.lock);
 
 	pr_debug("process pid %d svms 0x%p done\n",
@@ -3450,6 +3460,7 @@ int svm_range_list_init(struct kfd_process *p)
 
 	svms->objects = RB_ROOT_CACHED;
 	mutex_init(&svms->lock);
+	mutex_init(&svms->evict_lock);
 	INIT_LIST_HEAD(&svms->list);
 	atomic_set(&svms->evicted_ranges, 0);
 	atomic_set(&svms->drain_pagefaults, 0);
-- 
2.50.1

