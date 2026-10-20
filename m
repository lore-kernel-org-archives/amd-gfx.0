Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75A606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fQmRygoX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F2C10E4D3;
	Tue, 20 Oct 2026 16:31:40 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFBF10E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 16:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb1HwkJxU2c4JqyJ967yRfi8bl5DEsNUCiaKgyY0G3Y8LQJ3/Qljne4IiVMc/SohomnyFOf+X7YkQ1fpWbSQwuBtqcya9XrQ+zpdT6SiTF6brtO7wz6Ir/7yGyH/G+8L9ibhhIfkhnSecm58GWe+VGgz5ZKnH4j7AJCvIywH2cdilHOPxM6s5EZtouO4v282+FhfCVShzEmWXPp7Z9y5kAkMwrLY5Gaok2psJtQwq613if6N0iqAGQW8brBeXG0cny/Q+jY2ZXHsYZqVNrOkz7S0HDmxUICeG/DxIo1E/L1Oy4lVyJPTpkhDhEBR/7HNV9TF86wtqBiaS1AyqyZirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wae4VAIsO5lZbvOp3k3CIuDUy4aOobbxJoaJLBf5ftU=;
 b=GeJglOlEVR2UNCs11fYIKCLMLljGubEJEEwqxwHkOiHCk6SaGHKbFayEOO3rNxukEhUgTQFVtXwzswb5f4kjpBrWp3aCtq3pdLAcBFGzKI3ag4bHGrcXmO/Hz+b5Vy6c0Am0BefeCYOwAn/Lb+auhlxg8uQyBG6/4ydDQYaGvso0iIcuUKVEjwjEpvNRbnXXWxH0cp/hKPSRtHN+flAGQXeLxb8ZC0Nte6TIDY7Zyc0QPzlJFFEjfOzitY9i/ZKL+R1KP/Avxt8/cpIiT/uFaZAfjgmewGYlbvCi0j2oLy4vp2ZeMEVKryE3gQr09LaW6tmmOknL2ozaFImJ1oD+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wae4VAIsO5lZbvOp3k3CIuDUy4aOobbxJoaJLBf5ftU=;
 b=fQmRygoXp0j94AxmTATX3JJvh7Yn6dNizUwdeu4NWa8sf5HHcJTA3TkRqQQsWAlZkvstv90SvMH+LsxrdURlphuqpidGYhsy42s5adI1l8CeLwHS6afvKWn8VxIi20IKOXgRqHD+KmmYLz5su2BQPJRHYI54+lQJnOvU85gfEuc=
Received: from PH7PR10CA0008.namprd10.prod.outlook.com (2603:10b6:510:23d::14)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 16:31:28 +0000
Received: from PH1PEPF00062F29.namprd02.prod.outlook.com
 (2603:10b6:510:23d:cafe::5b) by PH7PR10CA0008.outlook.office365.com
 (2603:10b6:510:23d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 20 Oct 2026 16:31:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F29.mail.protection.outlook.com (10.167.243.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 16:31:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 11:31:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Back off SVM restore work retry
Date: Tue, 20 Oct 2026 12:31:15 -0400
Message-ID: <20261020163116.1069749-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F29:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: c80fc7d3-f7ec-4fc2-8281-08df2ec79772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|11063799006|56012099006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: TFlkdg6KFVLJhc4D9uNwYCEjoM5qAADS9EXc0VdLUJF7HpId969kpFPbRhrByzlfaSNtU3HIp06DscIg4Hm94JuFTxnRldHrvN3LIVXW3yCPDHbci7LtBAi64ATo/sGaODFKlvyjTcm0lvcUpJfcXITtb8AMI6V2IC+XOHwHltz0MPN26dIqNUVo2QvFHjw+fWe3MF1mGgiB+QbN9tM0MayyIbf7Zu1L/+OQ+Y/7pbX6MTZUUcOcrex0+E0sJswmlD3Qq1eiVmIzp+I5UtOu7pCoIlx6tuinGBN0VpxYmu1YHRbCEdryyAstpXrQxd7K2BfG5LNMmWwSrVxJSxEAUsOUqP23wM15tQd3N7ilx9qrPIaWK9YpmzudjRnZdTQWNR11+yRdrMBXkWS5rM2y3GRDDMjViIkYQ9zNZeCl5MXQoFVmLQMTJ0NolJ+jYbEspAEQowF2j6tnWWtC8MxpvXS0HqzEtvv3oREcguk7TBz4VLNWzvAPDPQt5kajWp7pJgWxwEmuGoAJnQoV2uDaZQ6qbrTk1d3BVGlfqT6gTlvf+uuXAofFTP+hegnQHm3Rzm9qupizi2O/0xJOcpe5GqR5jYkoBmd4EGM4V4lLcrKrr65dWAcmBaXB9BltvAEzmfffci22Si0Mx0Mijs75IIh3gcHEjwpMxor85mUdqizQC/Ju7NpiJmxTt4Py09piznJH6F+kPMvRAUVb1RhWiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hbK69PW9/n7YYnob6IYLoT2M629KqCTz9EmUEtqrO60kvm2MD7cHYtzbuxSVHsZOnRer5xJ4GHzKcp1g13Ave0yy4F1ntX2sSP/FOg4l+6xWmmyccehB6/VQFr5lVOnFDLh7BQq8GPpgo8R76tT0HsA3iqpYEPmOLyTlOrf7D/YW4+jbahVHWT7RVL5Jgzqwa3WNcXy4YdE0tYfgJauuEhYRqjVvZixYgVbzfVsu7kFQsucGryH7Al/2C56InPczrfcuZx44mXo6qYDjrgVIFIraC4E5rXTEfK8LW1sgUpYyAbWPdHLiawmATf6wC+FCiUE5KqsYUroZX//HSpuULfbEGkIIxRCWxtjdy3hOY2wci9rJmlCOLWDgRwicNoZppW1KJNhMdpCHJG4vFSsPUEAkTk5U/3VUcPFoNi8Asb0Vj0oQskm2jLY6IDvYH9Ow
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:31:28.3539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80fc7d3-f7ec-4fc2-8281-08df2ec79772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F29.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

svm_range_restore_work retries every AMDGPU_SVM_RANGE_RESTORE_DELAY_MS,
1ms, as long as validation keeps failing. Each attempt takes
process_info->lock, the mmap write lock and svms->lock, so a restore
that cannot converge, for example while memory reclaim keeps
invalidating the ranges, starves everything waiting for the same locks.
svm_range_set_attr cannot add a new range until the retries stop.

Double the retry delay on each failed attempt, up to 128ms, and reset it
when a new eviction cycle starts. Retrying 1000 times per second does
not help a restore that is failing, and the backoff leaves gaps for
other users of these locks to make progress.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4ba72c6069e5..8ed25a92cd89 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1060,6 +1060,8 @@ struct svm_range_list {
 	atomic_t			evicted_ranges;
 	atomic_t			drain_pagefaults;
 	struct delayed_work		restore_work;
+	/* Retry delay of restore_work, doubled on each failed attempt */
+	u32				restore_delay_ms;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 40f5b2ee0cfd..28b687133cf8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -46,6 +46,7 @@
 #define dev_fmt(fmt) "kfd_svm: %s: " fmt, __func__
 
 #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
+#define AMDGPU_SVM_RANGE_RESTORE_DELAY_MAX_MS 128
 
 /* Long enough to ensure no retry fault comes after svm range is restored and
  * page table is updated.
@@ -1964,6 +1965,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	struct mm_struct *mm;
 	int evicted_ranges;
 	int invalid;
+	u32 delay;
 	int r;
 
 	svms = container_of(dwork, struct svm_range_list, restore_work);
@@ -2034,15 +2036,23 @@ static void svm_range_restore_work(struct work_struct *work)
 	pr_debug("restore svm ranges successfully\n");
 
 out_reschedule:
+	/* Back off on repeated failures, retrying at the shortest delay keeps
+	 * retaking the same locks and starves everything else waiting for them.
+	 */
+	delay = svms->restore_delay_ms;
+	if (evicted_ranges)
+		svms->restore_delay_ms = min_t(u32, delay * 2,
+					       AMDGPU_SVM_RANGE_RESTORE_DELAY_MAX_MS);
+
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
-		pr_debug("reschedule to restore svm range\n");
+		pr_debug("reschedule to restore svm range in %u ms\n", delay);
 		queue_delayed_work(system_freezable_wq, &svms->restore_work,
-			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+				   msecs_to_jiffies(delay));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
 	}
@@ -2117,6 +2127,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			pr_debug("failed to quiesce KFD\n");
 
 		pr_debug("schedule to restore svm %p ranges\n", svms);
+		svms->restore_delay_ms = AMDGPU_SVM_RANGE_RESTORE_DELAY_MS;
 		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	} else {
@@ -3420,6 +3431,7 @@ int svm_range_list_init(struct kfd_process *p)
 	INIT_LIST_HEAD(&svms->list);
 	atomic_set(&svms->evicted_ranges, 0);
 	atomic_set(&svms->drain_pagefaults, 0);
+	svms->restore_delay_ms = AMDGPU_SVM_RANGE_RESTORE_DELAY_MS;
 	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
 	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&svms->deferred_range_list);
-- 
2.50.1

