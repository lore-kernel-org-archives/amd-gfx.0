Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C1C433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 06:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C0621527
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 06:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0OiUASKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C0621527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF876E09F;
	Fri,  9 Oct 2020 06:17:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C62A6E09F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 06:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fvi3K6tlcOnwPwZvcGWUFjzp60fwQTDA/kIuezPCbOkLup5QNyP0OGJgw/hwWNbXw7WoLNjXjmAQHfrUbWsE0An1Ik83OlVhvy+haVZYNV3sz2ouIiAXOAaplNey3ubiuZvlHNHnk65m5B/naoiBmvFE0d01FmH21XROk9ERtfFoAXyo+z28ixAya/Tptc53FKrylvEUA96JBWkNYWx2KpWvsg+0Ksprpz8XPlfuqBMLj+P7knIMqwGNS/dbLegSfbEmNhMJiZ7PE0KxCY1/BVXCjNO2jyntpTKdiOnD6L1ytSr3j6b9L87jeqUWQXBfUFggobXGoaD6zin8VT2mbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8xUzasUaX2UpsmIPc17NRb+QEJWf4ulrAYnDWueYVY=;
 b=Cnq8KAunWp91E8BCt81cxkM786DYBZHoJMOMg8Jkym6fC6EY98e3gIrO0sVagw8s9x5xpJFwJhsofS3XAHecLF6WH2fK0VA12hqZHCzHeuzsPO8Y6L81mhzelWLUmzQ8C1Qbvkey+3+pUrv7HlSHjPq62DKv2+SxwOUeHf60/0FGueSt9m1/yYZquuxbbTZV3xMJ7e9gn9vwBg1DTmWtKG2Kj02J2QLObla3DrjK9icx39LYsbnZa9V4JBm7T3ZUi4zMi8kSDqrOUZkUtw/W50P8umPiMkc+7jtT+dfXRBcPOizy4R9zMUlAVDz371jUj9zd0CeJZFcGTFeWDK6y8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8xUzasUaX2UpsmIPc17NRb+QEJWf4ulrAYnDWueYVY=;
 b=0OiUASKMglENWoadoPNf2RLIbtZPLwT6Ek1OLIVMJHcVP04Xg1O0wX2C1a3zzzPDmA2WsRbvsjE2kVYBGcoJ0nt6DvsRsc9pJpZdumvKiZHYimdcPmbeABfllxuULhujiXstHmdRO/H4AJzVosB14dHkOTGo2h3v6pdmHimVTp8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Fri, 9 Oct
 2020 06:16:59 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6%4]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 06:16:59 +0000
From: Changfeng <Changfeng.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Aaron.Liu@amd.com
Subject: [PATCH] Revert "drm/scheduler: improve job distribution with multiple
 queues"
Date: Fri,  9 Oct 2020 14:16:31 +0800
Message-Id: <20201009061631.15383-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR04CA0066.apcprd04.prod.outlook.com (2603:1096:202:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 06:16:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5d3bf40-4209-410d-b44d-08d86c1aede5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4011A6980E4DA93958764A8EFD080@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsn0eSHwFDe5Jgkc3nZNMjItNsHmuxUS248QdqyQKWWIo1oHUy7uY+XZAOzqliMz+XKj99x/721mgyZxlOmgO8eCGQoITZBTBuJUVsDVivAzgL67caJ+onQyObMhFKqYbQbWpfVaQdUWlJinIE/6inbx4o6WFuc1M9cswe++I7K5M7cH6BtpjosYu4fpjG78ls+LudJ709RGOAybIDM8PjNZfMdOGLkhiQFXJbJL0zR0dRYtN7VYx3Iq+ZBIjw7rBoEUOtqT/GhWlp94L7ZDjDBQQ10CFrXMidZbuk3iWOH4CkRf03Ln/dvoFka+8kub8f2ix+q06z8eH5Nn2Rgn1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(36756003)(6636002)(4326008)(186003)(478600001)(86362001)(16526019)(83380400001)(5660300002)(66476007)(52116002)(8936002)(66946007)(66556008)(6666004)(1076003)(26005)(2906002)(7696005)(8676002)(6486002)(956004)(316002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zpPWNoykBIwDm3zYSfa3EL4SqX6YUBCidntJsmxlptZRL3WlOfILKh10hgy7Xb26reVJ+w+Hg1hZ+VCl3h9StTOCOLp9G2fSZNE+m8yLz0tVEWJko3ZI5qU0VoyVsxQW594Vxqk3MlD1+4COKeJzI5WS50V8EjQyE8aNl7U0HHDxixISc08PYExKGssK39/NDMmVkHSxhdQbOEQlayrSQNOg3fmv3zbOJggrhUpBTT5cbCtQzomap7onieKNTBZ5PF/qTegRaHLWt02dCk3mbkeV8CjN4x2EkPvjV9cwRX+0GRVSfip66zgNJiLvCWln80Oy45SxHxYTfoOpzkoRhIHSOsclkWhqqJu9Mj1IuHDmezPlNyFnkJkUlo1JbQjMzbjHFWCkEXcJRdKhOMdoj3JVV/HBMdkJlu0YRAm52ngCKhCNA79Vm6wKyBVQC7lHgrZr81ccob0MQ/8taRkILKwi48LveJgrWt7G2wDFK4tHWeizSHjwwmlzURLifWFHLuY2wXvydc4Edxc9yWpSYimLctEmkbp+KAm/mHDozt4O4ellgnGiLWyBm8SfR9mkJRPkRIUkuv5G5U877/vq7Wnd2pG5maPma//5mWfCVwzPly/bVLlh9BpzoeJZf3sZFME/5l6n90mor9Ry4jdWcg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d3bf40-4209-410d-b44d-08d86c1aede5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 06:16:59.2226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PpO5Vp7gEAD/Kde2MpA0V4eR+J3OqpozN9mwf95WzAzFAILl9iMKwYS9eJOjfh+cv0njHiLD6Gc74cgC+POHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It needs to revert this patch to avoid amdgpu_test compute hang problem
on picasso/raven1

Change-Id: I5c298bb0c6cd64c67de712db551d15974c41493e
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c   | 14 ++++++--------
 include/drm/gpu_scheduler.h              |  6 +++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 146380118962..c803e14eed91 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -486,7 +486,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
 	bool first;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(&entity->rq->sched->score);
+	atomic_inc(&entity->rq->sched->num_jobs);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 9a0d77a68018..851443a19ee0 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -92,7 +92,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
 	if (!list_empty(&entity->list))
 		return;
 	spin_lock(&rq->lock);
-	atomic_inc(&rq->sched->score);
 	list_add_tail(&entity->list, &rq->entities);
 	spin_unlock(&rq->lock);
 }
@@ -111,7 +110,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 	if (list_empty(&entity->list))
 		return;
 	spin_lock(&rq->lock);
-	atomic_dec(&rq->sched->score);
 	list_del_init(&entity->list);
 	if (rq->current_entity == entity)
 		rq->current_entity = NULL;
@@ -649,7 +647,7 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
 	struct drm_gpu_scheduler *sched = s_fence->sched;
 
 	atomic_dec(&sched->hw_rq_count);
-	atomic_dec(&sched->score);
+	atomic_dec(&sched->num_jobs);
 
 	trace_drm_sched_process_job(s_fence);
 
@@ -714,7 +712,7 @@ drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
 {
 	struct drm_gpu_scheduler *sched, *picked_sched = NULL;
 	int i;
-	unsigned int min_score = UINT_MAX, num_score;
+	unsigned int min_jobs = UINT_MAX, num_jobs;
 
 	for (i = 0; i < num_sched_list; ++i) {
 		sched = sched_list[i];
@@ -725,9 +723,9 @@ drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
 			continue;
 		}
 
-		num_score = atomic_read(&sched->score);
-		if (num_score < min_score) {
-			min_score = num_score;
+		num_jobs = atomic_read(&sched->num_jobs);
+		if (num_jobs < min_jobs) {
+			min_jobs = num_jobs;
 			picked_sched = sched;
 		}
 	}
@@ -861,7 +859,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	spin_lock_init(&sched->job_list_lock);
 	atomic_set(&sched->hw_rq_count, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
-	atomic_set(&sched->score, 0);
+	atomic_set(&sched->num_jobs, 0);
 	atomic64_set(&sched->job_id_count, 0);
 
 	/* Each scheduler will run on a seperate kernel thread */
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 92436553fd6a..a33590e62108 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -264,7 +264,7 @@ struct drm_sched_backend_ops {
  * @job_list_lock: lock to protect the ring_mirror_list.
  * @hang_limit: once the hangs by a job crosses this limit then it is marked
  *              guilty and it will be considered for scheduling further.
- * @score: score to help loadbalancer pick a idle sched
+ * @num_jobs: the number of jobs in queue in the scheduler
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
  *
@@ -285,8 +285,8 @@ struct drm_gpu_scheduler {
 	struct list_head		ring_mirror_list;
 	spinlock_t			job_list_lock;
 	int				hang_limit;
-	atomic_t                        score;
-	bool				ready;
+	atomic_t                        num_jobs;
+	bool			ready;
 	bool				free_guilty;
 };
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
