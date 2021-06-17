Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C6C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 12:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2A361059
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 12:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2A361059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AA38986D;
	Thu, 17 Jun 2021 12:03:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16048945A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 12:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8zJV6JLQa7vqtCAFAjbXBt3P3SSRv1Yi9cymMZZ3/KfzLjPxQDZNHaBNp5LZqdaFZIMC6q46EoWnTMju7KIUdVzOEqT4neliFQdHuZ62dKrzuvZXEF5IDK4LQwHe1E7w8OV2AJig06m4btEkVnTYk50DOGs5JbWnSR9KaP7ok652UxV+uVXs19uqr6wU4IlYy6w+tUrbmReRFFQY5xPZD6PyW1yqu+Sgzmq7St0dJ0ebccKPoVUWM0p4eZYYg94bErh7xteyPTW71qWBX3+zef7lN0G7nZT73G7EiR/9OhOobCBbOAIAXLeK6TLK2O8qvT9ygwBp1C0RnJCsK/XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUOVFQ8TkEadJFSEO0t4307H1SRfhWnv0Qq5jfouNqE=;
 b=AbW0TcEx6XvWsJ+jCTNbgA9WygzjdRCZoXyulLaZQ8H5rz80/D89GuUhwKsT/O1A2/JzDsXdn2eb3mT904fcKpi7fnQhlWuv4vEcwsfwfYDjhoSKWq5buLIiz4jsQGZtzVJ3brRNAGJA+JmZNIAaVVs9mGdSRz2fgNi9v02/sUSkZ+rAo21QUCUn6EOgqB4AUA+JbaOuLIYteAHY8cC0Af2hAcpNZ7rgzOodLEQJ/ZFUHJ1ZXts6Z0udJsD04Brwbo1uRgSmZWlTrW8Tknk1v7TPslE/J8L7fk5XVOLW/cAKSlHiugHoDnFS0zWcxudnn85h1Q+pBrmT8vm1G0rGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUOVFQ8TkEadJFSEO0t4307H1SRfhWnv0Qq5jfouNqE=;
 b=vRbEbSVEDIKZjvRWs14UZHp9ygiNTV9SXNjsBVj2HLlsgngcLZiM1qaQ2Gj+bCZayj/OPVTH5rIlY1tE7pdixySkNsVA6Cwl2yP5R+R0k2T6ojmk3q61wnsbvap3zo9USwzKqMibsqdJMfcN1kCOjgn+B7ChBgrhrKy4VZ/En7M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15; Thu, 17 Jun 2021 12:03:22 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 12:03:22 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdkfd: Fix some double free when destroy queue
 fails
Date: Thu, 17 Jun 2021 20:02:45 +0800
Message-Id: <20210617120246.1730-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK2PR0302CA0018.apcprd03.prod.outlook.com (2603:1096:202::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 12:03:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8d0bae0-b445-42f8-c874-08d93187e780
X-MS-TrafficTypeDiagnostic: DM8PR12MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB544601753FB564E73150B7F5870E9@DM8PR12MB5446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZUJZxf0xIM6F9RdtiiH3dXIZBdvooEN9tZFX+tfK8U4En6z5qw2RRm7aCD/6JvThe7L3PBDUypAYJLXRnoFbFZ8CbbzdoRVYiZfm1jtj0VDw9++bvMuVT8ODAK4Jcuo3Fs3XZK5lbrBcmZf5A+Ju1bOO8JEq/vt4ga8MBP9jruiR0hXYmzB1OaXkfXQmrCOKR8froHtiQJTvzDb4hTn/tgYeDcptMZdKl9p16lBXdS0e7USbYR1gxq5vXnpsECbSCdfvV6Ky64Y47cMmyc/J3C2q1oCrx+qJJaZ0+SBxOQiQYIpTOBMyKT2Sb9KqyPS0tbdqCaS/ulEMNdzh5lglLrjdk8FKVHrCEVhMN/FWqm2S9psiGHvWzbkuuw+xGsLxH+WxPA5SK8y21DWG+hA0qPgyy1iH5mhBdsACtvvTLFelxh3Lv9/mm13d6XA8wxMOJDGcr3dyo6n90nYxoY/2C8Dp6j0Q0kT2C/rmnSgQ+0uy3YyqbtYr+DFvMUvaMPDILSjaOqlk2Z8ZE0O3xzzh9KhQ0IZRBa8Jw+jBMg6csEjHcMD8PsOnV3a6YrHCVTs+1p4CjEWzM1hH8V2ZCtltqs3FmGNtWreJE/hQlrQu8KldnwIxbwv2WU3zcOYIHbfJv0n67RN1fZQUhiM6Kyu0cPPsgR9L+x6pUUneHCYeMuM+9IlukqLiobvODPoloH8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(478600001)(186003)(7696005)(16526019)(5660300002)(26005)(38100700002)(316002)(1076003)(52116002)(8936002)(66476007)(66946007)(66556008)(36756003)(2906002)(6916009)(6486002)(86362001)(2616005)(956004)(8676002)(2304002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4h1GE6b0shHJqUUGTuYw3ZZPKFpPWfJXkBuAJboA/7eFGFtPHAC1Be7ULnYH?=
 =?us-ascii?Q?3gmRAKSYKpx9C4vunJWnXMIAdkPUWpbPstkTnry9p9rARVjrIJUZWzMsLHXg?=
 =?us-ascii?Q?QwhONAWIH6GMafg4Tg52EZtdCuYD/9rdCoMtrmaOSrux7GjhdVQwu88m6sgm?=
 =?us-ascii?Q?1ETrIhcFgsRUbYnrLmgCK8d/RyZG3+aUWGVR5qIua32EZBvlikZVgANET+V3?=
 =?us-ascii?Q?y2DDgpSH8zkGdZC2aO3uiyGQ7zWcu6wvHcKFRrbH33OH2rmGKPXvXv0pcIOQ?=
 =?us-ascii?Q?imXkReWKMJXZc4Ry77toUENmQ5rRAolv5DFAmgAHjEE6rr/WgegEa0I2mI81?=
 =?us-ascii?Q?pbkRuPCmUyhpCR9oM4sO8BFV8JNb8+pvQXCDvCnvH8s+UdGbyFv6ejjUl8QP?=
 =?us-ascii?Q?6XW8I+My23zf8q4A0JuTqZy9tJ9fGy9G7vz8x4GAdukp/g5hAiQnov7kXl9k?=
 =?us-ascii?Q?tGfxuL202IbQ+9TIvJSk6RI7H6hJNie5zAERG/xmfR+zzwAB1ab+8aUMsq2I?=
 =?us-ascii?Q?6C9T7qtKw7yxTvLILLN+bWJIJq+dlo3GI3AuJtSmBKrq4PTwa3hkWJ64u1bJ?=
 =?us-ascii?Q?+Rnt/ZcSxCrJZcfbXir6Lor2N720Ka3kAxqp39vvzj/uyzInMGlJ7utnsGR+?=
 =?us-ascii?Q?G0sdq8ul4ujKHYPW+yhXzwhFb5AhjjO8J0Pm30QM90AdaY+ZdnZE1cCnNdRL?=
 =?us-ascii?Q?72lufG+PixlDv3vUIyx5+A0RS5wTQ/O2rtJhbV86wvldPnf66baBaS855IyT?=
 =?us-ascii?Q?NyKfbqjJ93VxDdvYKmBppqFpQD5Ml1LkrPwrimI17Nw4hwWF7me5u6cmAt7R?=
 =?us-ascii?Q?S1aybI/Y81nRETFd7HgLAse7hpmMOQAmU2WlCQNCxCQJP0JQa48xVGly6HDy?=
 =?us-ascii?Q?o4zrKxQuHt+e7RE0cxAosHtuTt8yOCu7wR4Q7oJgbhKn4EzoBnCRKVSukimA?=
 =?us-ascii?Q?ZVCtFAZvALuowF3T4Y4Uza1Aig6UCxDP25xqu3NCT64DeH03DbgyTn6wQaFQ?=
 =?us-ascii?Q?4d5uH4JGe1s09yYayllOw9nurP/cXQkRCMS0Fg2wonUzfbbpDRVzfIAxYBmd?=
 =?us-ascii?Q?1qZyEF+sSICbOed62HVEEf7jjEHs7wS+Tj3WLO256iLX6Id6yqf7NTM9hqhU?=
 =?us-ascii?Q?jH2YITSn7+Xr70eCaDRnnrn4El+KJQq3xrikIjGjs0HGLJSMr4IYIJFvane8?=
 =?us-ascii?Q?V2lxmUicTu/+KDkMdryEcyzY0kvbj+QLWUcV3EyIqk0/kEyZ8bMFU1GhxMGm?=
 =?us-ascii?Q?0Ejn/pqD2t1mH80nQ0e/ebOCK1tAy8CJ2RHQj9J1DiTBTpFXgW1xijx4mGjN?=
 =?us-ascii?Q?Dw/Dt3KOOkXLhq4Un92+xxnn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d0bae0-b445-42f8-c874-08d93187e780
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 12:03:22.6955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzUZcKRqIJvsUksFBXTrRYizdLK3U6ROBbEWLka2lgcubHg6vjQWu//6GNLJsZN1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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
driver touching the queue. As we leave the queue as it is, we need keep
the resource as it is too.

Regardless user-space tries to destroy the queue again or not. We need
put queue back to the list so process termination would do the cleanup
work. What's more, if userspace tries to destroy the queue again, we
would not free its resource twice.

Kfd return -EIO in this case, so lets handle it now.

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
pid=2511
 __slab_alloc+0x72/0x80
 kmem_cache_alloc_trace+0x81f/0x8c0
 allocate_sdma_mqd+0x30/0xb0 [amdgpu]
 create_queue_cpsch+0xbf/0x470 [amdgpu]
 pqm_create_queue+0x28d/0x6d0 [amdgpu]
 kfd_ioctl_create_queue+0x492/0xae0 [amdgpu]
INFO: Freed in free_mqd_hiq_sdma+0x20/0x60 [amdgpu] age=2537 cpu=7
pid=2511
 kfree+0x322/0x340
 free_mqd_hiq_sdma+0x20/0x60 [amdgpu]
 destroy_queue_cpsch+0x20c/0x330 [amdgpu]
 pqm_destroy_queue+0x1a3/0x390 [amdgpu]
 kfd_ioctl_destroy_queue+0x57/0xc0 [amdgpu]

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c            |  4 +++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c069fa259b30..63a9a19a3987 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1530,6 +1530,11 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 		if (retval == -ETIME)
 			qpd->reset_wavefronts = true;
+		/* In gpu reset? We leave the queue as it is, so do NOT
+		 * cleanup the resource.
+		 */
+		else if (retval == -EIO)
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
index 95a6c36cea4c..0588e552b8ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -373,6 +373,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		dqm = pqn->kq->dev->dqm;
 		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
 		kernel_queue_uninit(pqn->kq, false);
+		pqn->kq = NULL;
 	}
 
 	if (pqn->q) {
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
