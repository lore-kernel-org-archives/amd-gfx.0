Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B1C48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 06:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446356109D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 06:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446356109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65F76E856;
	Fri, 18 Jun 2021 06:03:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD2E6E856
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 06:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf3Z6T2WabioCd6OqDvNHIsxEbqpVanlkXYZZukqPKvRW4jqnHbZTbLCHDu5Haot2DWP0IIqyjtRWiQ/gHtrjzFm7VO68kuRSr/zTtKKS8YT5Cnc9CtZJMmWScBGbo4+dh/JeJToGzbry0oyeIeBEv/5ke/EYqjvGoouB8A+PnofrjTUSWzKSGsxtYMijjpNzmnCMIBmZuVRWyvZiQumCj6c6DLjXeE/1YJoIyAao3fXehluVpM6GsO2guVCX/wULfmhr0tbKC6UCp1BTmGWVVEZYg6w2hjOyFooWS8WrCZ6L4xy3NF6qVfpb6ovsfXUksxhJPeoOYaDyfM8d2X46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlbINXqC36AaNYzgG37ZNggoeUCIDWgY2uRv+hCPre0=;
 b=DGmCRTnoD8SN5CEigKC8BdtcI9waQ+kHRaA4kFvnMB1fL9dgCpQc0n50N+q/ZkbFG0lUKLkJPmjeZ53jvPi23v57HrfJ2xrjoqI+ficRW1UsvpnKiOO3U+UZ86sPA5FI3HRIR/Xcg7I5dh4ENbNqq8CFJtqwM2ekPUUlShWGRtsgpzCrIg7hob1SyBhy5EMsCOy1Ttag4p6+ZgcdDmAIZzGN7n5Wx51+Bwz9l8qvO2UWmgIEwdR8PARB+TIvAdsc5H+ZBHhLoV30MDFO6fEiXPP7ELNy9wYGszP8CJ9TLdeT2rz1W3276j+yZc2p/tMQuBRJAsiLELMp8vZHqx95dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlbINXqC36AaNYzgG37ZNggoeUCIDWgY2uRv+hCPre0=;
 b=Gh7xuVtAwLEBDHdRlQu70it3djdIIR1UjazFGP5FWy1GVlSaVYSNZeyj0qZNjQAy41uphe/6YBB3Px8ix0IvXh70sQiJz6/k9shJly+mRLE/BvdqNG+j9+9d+kXw0nxYOcpCFfMJEqnJIuxMmNSG9qqTMJ4NeUgcxK50VNtziTI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Fri, 18 Jun 2021 06:02:58 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 06:02:58 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdkfd: Fix some double free when destroy queue fails
Date: Fri, 18 Jun 2021 14:02:15 +0800
Message-Id: <20210618060215.8142-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK2PR06CA0017.apcprd06.prod.outlook.com (2603:1096:202:2e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 06:02:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1e52857-b6ca-455e-e0aa-08d9321eb912
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54775D95BB377E26D417D798870D9@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgMZi203mw6xtglVIT7rPEvWqcnirnWu84PKXM9lsk8Y0LxxGfn6v3DvlptQ095MtADAJ9sHO5T7W7Y4WhL7RV2SRKTpUB3FviFlzQl7F7iaE+c+JDLKs7SjT07r68bDwSCuKYjwUkfBTnfJZix2kRRvRBaVUOiuoaAo1vm3TMJVSRKwUcU5crTQQy4075GumpIcBzJ7UXh75WAPstfYCt+ySAG5+wN2dXLPIKZTOHBs47hlr5bC6w4OQzagVh1hN8ZbFe8f4F8yZs3S2f+Zr8NmDXs8I4OKYgAxdGLWCME9Kd+iK3ySdqpgQcZLN0LAqZvoZGKutkFR2LRUyvuRYnROZRDo/qP6wPG3GnI1xl3fzlCJNgLRY6HVTxS/3ieREnupLD0lqcwbG3aW2iMU4D4KOTlgUHKOQBBRp+ZqNpHVWEgnjy7a4NQIm3NBq1VSpOxlEw697twGJlSrmtHEnka3lyo6kIdPrZD/ODORBmQQo3uwg2PDraroI2glx0ZdGxdL6iLtNv7ZHkkCgYU4gr1iflNf6j3HQ6K6CEUV4zcd1ZWCB4ieGB30R4h2nKw+s/GMwfjc8oyL9Y8++zTniKHxrz+nr20IKTPjG/bLQEarjfu9hSmllyf6DWh4MQrXKR+7l24YZQU/3ayr5MUGrdukjVIVLvt6EZ6tMST4LFW/EvNwy4rsKZG4JiI2W84b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(316002)(26005)(6666004)(478600001)(83380400001)(6486002)(16526019)(186003)(38100700002)(956004)(1076003)(8936002)(6916009)(36756003)(2616005)(2906002)(4326008)(66946007)(66556008)(86362001)(7696005)(8676002)(5660300002)(38350700002)(66476007)(52116002)(2304002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyZRXO/xfEJ90viy9KEPyOp6aHMnlO/p66pzC+T29V4AVbE8h52S88eCStsb?=
 =?us-ascii?Q?ThpsGdAnBJKfSbrzM3P8Rz27HzXXRLXtzV4Hcj1QjRLBwcQfMiv223pRoRPN?=
 =?us-ascii?Q?P1DCBaPiF8Z4B4RZoGtf7/ReAJ6TI4Y0hw0LkWC8WWn+xCwOkHvTTuLuqCDV?=
 =?us-ascii?Q?FOuxIFa+8sM/K7jS2hfS95EKUtzZNxXro3L+fDvKBA+IEW4L5bqhYUAimsPI?=
 =?us-ascii?Q?w7opAEbTYc2S7Z6jK9qhx2e97HWcButT8HlbapnlavVbTP936B0cbzgGqPD0?=
 =?us-ascii?Q?CSlBgjf13A8Yytzi+KB1Lq7vvah1SiBHPoH24lFuJYeio+aHzmxKT2CddKsb?=
 =?us-ascii?Q?Ctea+zEBxsXJPvBaPGN03UA6v9Ge7wOoxbUlBuKWzSY/EhO6iooFRoAcwi2H?=
 =?us-ascii?Q?vTyv3ay43y9XvagqQkfM9tg+FH9eGarVV2Br5KFvyH+AXc+AlddIDNB1rwon?=
 =?us-ascii?Q?/d3pC7bRJkqglKg7sfYLTDUlM0vmzJQnBp0s89DZsEWEVj372u1+lC3/5y2t?=
 =?us-ascii?Q?+I9U+xZMWCz9iZeNSkpOUcRYIiMWXlbCIdGSJ/XqKFXeoDwDpoIvKwDV5SIo?=
 =?us-ascii?Q?dkQwp+NwePCOo+0JXgDVUUVRrF48rH+D+HjSxpiNOkmQ32MypuqJhIc7dYLS?=
 =?us-ascii?Q?wRDbTa73ZUgwPH0kPH327xxptl7hmGGqy2STJNKe0M0fGXWLwHU2tNVEHfgP?=
 =?us-ascii?Q?WXLa0lMg5D7AqpaXVLBaKDNhsTcU2kEdc+NTYGTlxrOMcdaD9LwdcIMCBAtF?=
 =?us-ascii?Q?u8f1B41Xvm6q93CAKmqj9Nkv9WVpXAiO0CeUcGfcKpHO+qrCdO8rFP/HdjfT?=
 =?us-ascii?Q?nbKgW65jDgBYhfxBo5ZqZZzDBdsKa2nNvmU6jF8nxFYRNMm7suS4xvI9j+8t?=
 =?us-ascii?Q?0fleyWSxtOCyo/bCyfvtqEUWti5eJyBu97WrNjVmFbllN/qrupGUpeopmPTT?=
 =?us-ascii?Q?cCZwk/0mWPnlr8jUBXmn15+zbNKkUSXmrciK9czeQRsw7rjmesOcvAO+A74O?=
 =?us-ascii?Q?Og+BQHKXct2OGBaNWsSO4w7XvOFHZbdvBjf47iSYwnDnud9Pey0peyYjK0oE?=
 =?us-ascii?Q?X14IhU4+tvi72XcKSJfnIXpTOlRqsmd+3s1slk2WKMPyZMXldktvRxPpLSmo?=
 =?us-ascii?Q?8e+t9/1AxqSUtAwvp/VSkV2I7djQdNZ2ZcBchsX7JlDOQ7uXTN/7BBFSt/Tp?=
 =?us-ascii?Q?rA64eKEWETno0tJItfsk1FSBIYj7llOlQ0ZPQWlp6CDIIR//NH/8faXaZHvo?=
 =?us-ascii?Q?oC/8I+PlOrmwbcpdU4nUBtvlxMNt95QsGnRWfqwuMwFHm6rl8VpuJ+I2CzGW?=
 =?us-ascii?Q?vj1cvrzbSC5JSREzeAqi/HW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e52857-b6ca-455e-e0aa-08d9321eb912
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 06:02:58.6718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2ThLGGgTWnr/eKilj+zbyJwNoyIxnQWyWmXKSY1MF/thZ004C0Z6hUy2Mgh/5zF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Handle queue destroy failure while CP hang.
Once CP got hang, kfd trigger GPU reset and set related flags to stop
driver touching the queue. But all usermode queues have stopped, we
actually somehow succeed to remove queue from runlist. So lets do
cleanup work as normal in -EIO/-ETIME case.

For other fatal error cases, say ENOMEM, we have to skip cleanup this
time as queue might still be running. Regardless user-space tries to
destroy the queue again or not. We need put queue back to the list so
process termination would do the cleanup work. What's more, if userspace
tries to destroy the queue again, we would not free its resource twice.

Paste some error log below without this patch.

amdgpu: Can't create new usermode queue because -1 queues were already
created

refcount_t: underflow; use-after-free.
Call Trace:
 kobject_put+0xe6/0x1b0
 kfd_procfs_del_queue+0x37/0x50 [amdgpu]
 pqm_destroy_queue+0x17a/0x390 [amdgpu]
 kfd_ioctl_destroy_queue+0x57/0xc0 [amdgpu]
 kfd_ioctl+0x463/0x690 [amdgpu]

BUG kmalloc-32 (Tainted: G        W        ): Object already free
INFO: Allocated in allocate_sdma_mqd+0x30/0xb0 [amdgpu] age=4796 cpu=2
 __slab_alloc+0x72/0x80
 kmem_cache_alloc_trace+0x81f/0x8c0
 allocate_sdma_mqd+0x30/0xb0 [amdgpu]
 create_queue_cpsch+0xbf/0x470 [amdgpu]
 pqm_create_queue+0x28d/0x6d0 [amdgpu]
 kfd_ioctl_create_queue+0x492/0xae0 [amdgpu]
INFO: Freed in free_mqd_hiq_sdma+0x20/0x60 [amdgpu] age=2537 cpu=7
 kfree+0x322/0x340
 free_mqd_hiq_sdma+0x20/0x60 [amdgpu]
 destroy_queue_cpsch+0x20c/0x330 [amdgpu]
 pqm_destroy_queue+0x1a3/0x390 [amdgpu]
 kfd_ioctl_destroy_queue+0x57/0xc0 [amdgpu]

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c          |  4 +++-
 .../drm/amd/amdkfd/kfd_process_queue_manager.c    |  4 +++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 16a1713808c2..f38f011e6f97 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1528,8 +1528,13 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		decrement_queue_count(dqm, q->properties.type);
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
-		if (retval == -ETIME)
+		/* CP hang and all usermode queues have stopped.
+		 * We are safe to do the cleanup work.
+		 */
+		if (retval == -ETIME || retval == -EIO)
 			qpd->reset_wavefronts = true;
+		else if (retval)
+			goto failed_execute_queue;
 		if (q->properties.is_gws) {
 			dqm->gws_queue_count--;
 			qpd->mapped_gws_queue = false;
@@ -1551,6 +1556,14 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	return retval;
 
+failed_execute_queue:
+	/* Put queue back to the list, then we have chance to destroy it.
+	 * FIXME: we do NOT want the queue in the runlist again.
+	 */
+	list_add(&q->list, &qpd->queues_list);
+	qpd->queue_count++;
+	if (q->properties.is_active)
+		increment_queue_count(dqm, q->properties.type);
 failed_try_destroy_debugged_queue:
 
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 09b98a83f670..984197e5929f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -607,11 +607,13 @@ static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q)
+	if (!q || !kobject_get_unless_zero(&q->kobj))
 		return;
 
 	kobject_del(&q->kobj);
 	kobject_put(&q->kobj);
+	/* paired with the get above */
+	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 95a6c36cea4c..c796c7601365 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -373,6 +373,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		dqm = pqn->kq->dev->dqm;
 		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
 		kernel_queue_uninit(pqn->kq, false);
+		pqn->kq = NULL;
 	}
 
 	if (pqn->q) {
@@ -383,7 +384,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
@@ -396,6 +397,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		kfree(pqn->q->properties.cu_mask);
 		pqn->q->properties.cu_mask = NULL;
 		uninit_queue(pqn->q);
+		pqn->q = NULL;
 	}
 
 	list_del(&pqn->process_queue_list);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
