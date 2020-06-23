Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F8BC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 17:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C1C20781
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 17:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="blTfYctl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C1C20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BD26E28A;
	Tue, 23 Jun 2020 17:18:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C1D6E28A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 17:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvIefD/3tqNixiGMZrurqiMe75yi6zapZpw51LYjFUa8wmaIGBjv90ql+594bMOhszSaSIboTW1w31Xc7fmQCg1YozTuH8rzwaDH89vIgHlD2oqiwZ6TrivVj+gt+r5cwXlXOzldX2OcupcjCpKzHtMh2XJyebrn56M3Csywnirw4UrrbK6bOaObIgHxS6AqPEzqpWAXPbh2Af9uOkGdluFCDnh23q9DCM//v8xMb9XHc9mwEcTx7vCiuJszInxaIM9EQEse0cJN41LKHMnpXZ3EYn4WuU4xYOgmfnJSJo1ULbnTocTn+kpqNmMr7cywqNkR0QGB10j3oysE7OYVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJkzGirdZUKcQCt84KYfYEHVofbk+vNx7qOTsJeyGs8=;
 b=XBby906R+5Kv7OCzpEgJ8gDfdhbM9fm7BSeHTns8AAyHxGWHC1YBK6IqjKt5IEpzKQzssMz1IV9E1LazfulxfDaHBEnHfw9hZr6JdGr9q8k3W96n1s8ZYUJs1bZZgicelPW7+zdO5Vawt17pCRK9GncautIkTVdgh2RDntBoEDzpUozF8VVkTqB+tbmhhsjA9zq7IMdhoYgn9aZmqwB0YOeWfXKQcI5MZB/IQuVup/lbaZLKhc2H7UwxihJoUrymgF1XHCMU+KWjyxn+y7sQtEmCZ02Q/aRfoStT9iZIcykmI0c/ca8ifWSt6xw7u/Gys9uv9j9jW39kJhLec4OWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJkzGirdZUKcQCt84KYfYEHVofbk+vNx7qOTsJeyGs8=;
 b=blTfYctlmMbS7I9Ch945ewZTwJMLEGlDI6HQA8KI8k4ggKveELXxo2/VBEJ8iMJGKdNCHn1OwBukkIucFrvLGtY1Z83LV0vd2ADE+YuLjWRrE2E8yV9QkKoqGDh4WHbO4guI9AC7OyvEjmwbAW6QN1mtu+bL9tTVpgteksye0L4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3166.namprd12.prod.outlook.com (2603:10b6:208:106::14)
 by MN2PR12MB3070.namprd12.prod.outlook.com (2603:10b6:208:c1::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 17:18:57 +0000
Received: from MN2PR12MB3166.namprd12.prod.outlook.com
 ([fe80::984b:26b2:8963:b15c]) by MN2PR12MB3166.namprd12.prod.outlook.com
 ([fe80::984b:26b2:8963:b15c%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 17:18:57 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Fix circular locking dependency warning
Date: Tue, 23 Jun 2020 13:18:39 -0400
Message-Id: <20200623171839.304-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To MN2PR12MB3166.namprd12.prod.outlook.com
 (2603:10b6:208:106::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 17:18:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db9818dd-6299-4e09-08dd-08d81799836d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB30701C83CB532F8A2C3810EBEE940@MN2PR12MB3070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/b1be4eA/11McmdJTE/hwxT57sEaCK8Up3ZEO7Em+RioeeBYXq9OuxnASGbFdl6lp81Z26OkySzdc6bKNUEBlDvEZz6EHi60+8poKdk3XKAojiI0CCHL5dRBznDKygin7oA/btze5fcy7zh883JUGkDAI8t7z0XQ9Mz8O8Lzz1YffsF2lzHM3mdUU7xIqm0/XkJPTft9Z6LQWWPVfY3pDsCyj4iKTTpipRF4Xe28Q40686E+LCzcCQjoQuWmOs9WohD62tiZRfFHNfHn9t0Bhttme0m90saxt9hMdkckhPq7JZsmcrHycDYCngMMnXboDCgJhuwGHt5ZQp+gkUZAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3166.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(16526019)(186003)(2906002)(8676002)(6916009)(4326008)(6486002)(5660300002)(86362001)(1076003)(30864003)(36756003)(83380400001)(6666004)(8936002)(26005)(2616005)(44832011)(956004)(316002)(52116002)(66476007)(7696005)(66556008)(478600001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vehmErgfemLlq2vS2looFETzRbjL4gF5Drc73tThcqqpTUlQymxs1xIiXDprlRHQoKhRIgTKblIXBE2GPy67+gcW4K5xuGGk0gNBNq05Nlrr4ns9NtNgkZrkNX9LXQPFrVHQELUGOiYvj89nnbxGgOVaP1Lk6eT9WKZ8P5VzFS1yk/VGW5K9GDMauBoF+jvT5OuK0GM3c71CE2GLSIbGHyh9rVgxxLWehN3TNnAHNLKZsiVswdwD7b3Bv6xnPeVnb42i8JaslwW9tHTEUcf+A/dJVBH506gumKM28VQE8XyGiAxKRgTH0P8aSpuKMih2/QzAnf4+VpWG2eOOq4J5LVee/AAaf59F0UtbH2G35T5e+EmliuCcG/dffwUu/IX4oBnRgBrGxC7rULz7P1Zedyx7vT9ULQAeSjks55uPOwKl9pZBHuu9lE378vFogwEkkeoNmJzqHJCh0XIb3XWpdrIrgK5tKp3G+ECavPaAHJm4DSj7BBeTq8D4PtGU8LSb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9818dd-6299-4e09-08dd-08d81799836d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 17:18:57.6940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExaYOitz1dwOWvaV6dVZSNvVPkXgKknlER+xnQfkbjYY3N+G81RNGQnbCSW14BsthIqKzoDVuarTT6xnXFJVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3070
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Lockdep is spewing circular locking dependency warning when
reading SDMA usage stats.

  150.887733] ======================================================
[  150.893903] WARNING: possible circular locking dependency detected
[  150.905917] ------------------------------------------------------
[  150.912129] kfdtest/4081 is trying to acquire lock:
[  150.917002] ffff8f7f3762e118 (&mm->mmap_sem#2){++++}, at:
		__might_fault+0x3e/0x90
[  150.924490]
               but task is already holding lock:
[  150.930320] ffff8f7f49d229e8 (&dqm->lock_hidden){+.+.}, at:
		destroy_queue_cpsch+0x29/0x210 [amdgpu]
[  150.939432]
               which lock already depends on the new lock.
[  150.947603]
               the existing dependency chain (in reverse order) is:
[  150.955074]
               -> #3 (&dqm->lock_hidden){+.+.}:
[  150.960822]        __mutex_lock+0xa1/0x9f0
[  150.964996]        evict_process_queues_cpsch+0x22/0x120 [amdgpu]
[  150.971155]        kfd_process_evict_queues+0x3b/0xc0 [amdgpu]
[  150.977054]        kgd2kfd_quiesce_mm+0x25/0x60 [amdgpu]
[  150.982442]        amdgpu_amdkfd_evict_userptr+0x35/0x70 [amdgpu]
[  150.988615]        amdgpu_mn_invalidate_hsa+0x41/0x60 [amdgpu]
[  150.994448]        __mmu_notifier_invalidate_range_start+0xa4/0x240
[  151.000714]        copy_page_range+0xd70/0xd80
[  151.005159]        dup_mm+0x3ca/0x550
[  151.008816]        copy_process+0x1bdc/0x1c70
[  151.013183]        _do_fork+0x76/0x6c0
[  151.016929]        __x64_sys_clone+0x8c/0xb0
[  151.021201]        do_syscall_64+0x4a/0x1d0
[  151.025404]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  151.030977]
               -> #2 (&adev->notifier_lock){+.+.}:
[  151.036993]        __mutex_lock+0xa1/0x9f0
[  151.041168]        amdgpu_mn_invalidate_hsa+0x30/0x60 [amdgpu]
[  151.047019]        __mmu_notifier_invalidate_range_start+0xa4/0x240
[  151.053277]        copy_page_range+0xd70/0xd80
[  151.057722]        dup_mm+0x3ca/0x550
[  151.061388]        copy_process+0x1bdc/0x1c70
[  151.065748]        _do_fork+0x76/0x6c0
[  151.069499]        __x64_sys_clone+0x8c/0xb0
[  151.073765]        do_syscall_64+0x4a/0x1d0
[  151.077952]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  151.083523]
               -> #1 (mmu_notifier_invalidate_range_start){+.+.}:
[  151.090833]        change_protection+0x802/0xab0
[  151.095448]        mprotect_fixup+0x187/0x2d0
[  151.099801]        setup_arg_pages+0x124/0x250
[  151.104251]        load_elf_binary+0x3a4/0x1464
[  151.108781]        search_binary_handler+0x6c/0x210
[  151.113656]        __do_execve_file.isra.40+0x7f7/0xa50
[  151.118875]        do_execve+0x21/0x30
[  151.122632]        call_usermodehelper_exec_async+0x17e/0x190
[  151.128393]        ret_from_fork+0x24/0x30
[  151.132489]
               -> #0 (&mm->mmap_sem#2){++++}:
[  151.138064]        __lock_acquire+0x11a1/0x1490
[  151.142597]        lock_acquire+0x90/0x180
[  151.146694]        __might_fault+0x68/0x90
[  151.150879]        read_sdma_queue_counter+0x5f/0xb0 [amdgpu]
[  151.156693]        update_sdma_queue_past_activity_stats+0x3b/0x90 [amdgpu]
[  151.163725]        destroy_queue_cpsch+0x1ae/0x210 [amdgpu]
[  151.169373]        pqm_destroy_queue+0xf0/0x250 [amdgpu]
[  151.174762]        kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
[  151.180577]        kfd_ioctl+0x223/0x400 [amdgpu]
[  151.185284]        ksys_ioctl+0x8f/0xb0
[  151.189118]        __x64_sys_ioctl+0x16/0x20
[  151.193389]        do_syscall_64+0x4a/0x1d0
[  151.197569]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  151.203141]
               other info that might help us debug this:

[  151.211140] Chain exists of:
                 &mm->mmap_sem#2 --> &adev->notifier_lock --> &dqm->lock_hidden

  151.222535]  Possible unsafe locking scenario:

[  151.228447]        CPU0                    CPU1
[  151.232971]        ----                    ----
[  151.237502]   lock(&dqm->lock_hidden);
[  151.241254]                                lock(&adev->notifier_lock);
[  151.247774]                                lock(&dqm->lock_hidden);
[  151.254038]   lock(&mm->mmap_sem#2);
[  151.257610]

This commit fixes the warning by ensuring get_user() is not called
while reading SDMA stats with dqm_lock held as get_user() could cause a
page fault which leads to the circular locking scenario.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  36 +++---
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 120 +++++++++++++++---
 3 files changed, 124 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 21eb0998c4ae..204612de3dbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -153,24 +153,23 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
 		dqm->active_cp_queue_count--;
 }
 
-int read_sdma_queue_counter(struct queue *q, uint64_t *val)
+int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val)
 {
 	int ret;
 	uint64_t tmp = 0;
 
-	if (!q || !val)
+	if (!val)
 		return -EINVAL;
 	/*
 	 * SDMA activity counter is stored at queue's RPTR + 0x8 location.
 	 */
-	if (!access_ok((const void __user *)((uint64_t)q->properties.read_ptr +
+	if (!access_ok((const void __user *)(q_rptr +
 					sizeof(uint64_t)), sizeof(uint64_t))) {
 		pr_err("Can't access sdma queue activity counter\n");
 		return -EFAULT;
 	}
 
-	ret = get_user(tmp, (uint64_t *)((uint64_t)(q->properties.read_ptr) +
-						    sizeof(uint64_t)));
+	ret = get_user(tmp, (uint64_t *)(q_rptr + sizeof(uint64_t)));
 	if (!ret) {
 		*val = tmp;
 	}
@@ -187,14 +186,15 @@ static int update_sdma_queue_past_activity_stats(struct kfd_process_device *pdd,
 	if (!pdd)
 		return -ENODEV;
 
-	ret = read_sdma_queue_counter(q, &val);
+	ret = read_sdma_queue_counter((uint64_t)q->properties.read_ptr, &val);
 	if (ret) {
 		pr_err("Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
 		return ret;
 	}
 
-	pdd->sdma_past_activity_counter += val;
+	WRITE_ONCE(pdd->sdma_past_activity_counter,
+			pdd->sdma_past_activity_counter + val);
 
 	return ret;
 }
@@ -533,11 +533,6 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	if (retval == -ETIME)
 		qpd->reset_wavefronts = true;
 
-	/* Get the SDMA queue stats */
-        if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
-            (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-                update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
-        }
 
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 
@@ -578,6 +573,12 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	retval = destroy_queue_nocpsch_locked(dqm, qpd, q);
 	dqm_unlock(dqm);
 
+	/* Get the SDMA queue stats */
+        if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
+            (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
+                update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
+        }
+
 	return retval;
 }
 
@@ -1520,11 +1521,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		}
 	}
 
-	/* Get the SDMA queue stats */
-	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
-	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
-	}
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
 	 * type
@@ -1535,6 +1531,12 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	dqm_unlock(dqm);
 
+	/* Get the SDMA queue stats */
+	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
+	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
+		update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
+	}
+
 	/* Do free_mqd after dqm_unlock(dqm) to avoid circular locking */
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 894bcf877f9e..49d8e324c636 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -251,6 +251,5 @@ static inline void dqm_unlock(struct device_queue_manager *dqm)
 	mutex_unlock(&dqm->lock_hidden);
 }
 
-int read_sdma_queue_counter(struct queue *q, uint64_t *val);
-
+int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val);
 #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8616a204e4c3..07286b535b20 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -86,6 +86,13 @@ struct kfd_sdma_activity_handler_workarea {
 	uint64_t sdma_activity_counter;
 };
 
+struct temp_sdma_queue_list {
+	uint64_t rptr;
+	uint64_t sdma_val;
+	unsigned int queue_id;
+	struct list_head list;
+};
+
 static void kfd_sdma_activity_worker(struct work_struct *work)
 {
 	struct kfd_sdma_activity_handler_workarea *workarea;
@@ -96,6 +103,8 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	struct qcm_process_device *qpd;
 	struct device_queue_manager *dqm;
 	int ret = 0;
+	struct temp_sdma_queue_list sdma_q_list;
+	struct temp_sdma_queue_list *sdma_q, *next;
 
 	workarea = container_of(work, struct kfd_sdma_activity_handler_workarea,
 				sdma_activity_work);
@@ -109,7 +118,59 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	qpd = &pdd->qpd;
 	if (!dqm || !qpd)
 		return;
+	/*
+	 * Total SDMA activity is current SDMA activity + past SDMA activity
+	 * Past SDMA count is stored in pdd.
+	 * To get the current activity counters for all active SDMA queues,
+	 * we loop over all SDMA queues and get their counts from user-space.
+	 *
+	 * We cannot call get_user() with dqm_lock held as it can cause
+	 * a circular lock dependency situation. To read the SDMA stats,
+	 * we need to do the following:
+	 *
+	 * 1. Create a temporary list of SDMA queue nodes from the qpd->queues_list,
+	 *    with dqm_lock/dqm_unlock().
+	 * 2. Call get_user() for each node in temporary list without dqm_lock.
+	 *    Save the SDMA count for each node and also add the count to the total
+	 *    SDMA count counter.
+	 *    Its possible, during this step, a few SDMA queue nodes got deleted
+	 *    from the qpd->queues_list.
+	 * 3. Do a second pass over qpd->queues_list to check if any nodes got deleted.
+	 *    If any node got deleted, its SDMA count would be captured in the sdma
+	 *    past activity counter. So subtract the SDMA counter stored in step 2
+	 *    for this node from the total SDMA count.
+	 */
+	INIT_LIST_HEAD(&sdma_q_list.list);
+
+	/*
+	 * Create the temp list of all SDMA queues
+	 */
+	dqm_lock(dqm);
 
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
+		    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
+			sdma_q = kzalloc(sizeof(struct temp_sdma_queue_list), GFP_KERNEL);
+			if (!sdma_q)
+				return;
+
+			INIT_LIST_HEAD(&sdma_q->list);
+			sdma_q->rptr = (uint64_t)q->properties.read_ptr;
+			sdma_q->queue_id = q->properties.queue_id;
+			list_add_tail(&sdma_q->list, &sdma_q_list.list);
+		}
+	}
+
+	dqm_unlock(dqm);
+
+	if (list_empty(&sdma_q_list.list)) {
+		workarea->sdma_activity_counter = READ_ONCE(pdd->sdma_past_activity_counter);
+		return;
+	}
+
+	/*
+	 * Get the usage count for each SDMA queue in temp_list.
+	 */
 	mm = get_task_mm(pdd->process->lead_thread);
 	if (!mm) {
 		return;
@@ -117,33 +178,60 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 	use_mm(mm);
 
-	dqm_lock(dqm);
+	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
+		val = 0;
+		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
+		if (ret)
+			pr_debug("Failed to read SDMA queue active "
+				 "counter for queue id: %d",
+				 sdma_q->queue_id);
+			else {
+				sdma_q->sdma_val = val;
+				workarea->sdma_activity_counter += val;
+			}
+	}
 
-	/*
-	 * Total SDMA activity is current SDMA activity + past SDMA activity
-	 */
-	workarea->sdma_activity_counter = pdd->sdma_past_activity_counter;
+	unuse_mm(mm);
+	mmput(mm);
 
 	/*
-	 * Get the current activity counters for all active SDMA queues
+	 * Do a second iteration over qpd_queues_list to check if any SDMA
+	 * nodes got deleted while fetching SDMA counter.
 	 */
+	dqm_lock(dqm);
+
+	workarea->sdma_activity_counter += READ_ONCE(pdd->sdma_past_activity_counter);
+
 	list_for_each_entry(q, &qpd->queues_list, list) {
+		if (list_empty(&sdma_q_list.list)) {
+			break;
+		}
+
 		if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 		    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-			val = 0;
-			ret = read_sdma_queue_counter(q, &val);
-			if (ret)
-				pr_debug("Failed to read SDMA queue active "
-					 "counter for queue id: %d",
-					 q->properties.queue_id);
-			else
-				workarea->sdma_activity_counter += val;
+			list_for_each_entry_safe(sdma_q, next, &sdma_q_list.list, list) {
+				if (((uint64_t)q->properties.read_ptr == sdma_q->rptr) &&
+				     (sdma_q->queue_id == q->properties.queue_id)) {
+					list_del(&sdma_q->list);
+					kfree(sdma_q);
+					break;
+				}
+			}
 		}
 	}
 
 	dqm_unlock(dqm);
-	unuse_mm(mm);
-	mmput(mm);
+
+	/*
+	 * If temp list is not empty, it implies some queues got deleted
+	 * from qpd->queues_list during SDMA usage read. Subtract the SDMA
+	 * count for each node from the total SDMA count.
+	 */
+	list_for_each_entry_safe(sdma_q, next, &sdma_q_list.list, list) {
+		workarea->sdma_activity_counter -= sdma_q->sdma_val;
+		list_del(&sdma_q->list);
+		kfree(sdma_q);
+	}
 }
 
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
