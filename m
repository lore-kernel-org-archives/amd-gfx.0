Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C706BC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABAD64EC8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABAD64EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1F46ED24;
	Thu, 25 Feb 2021 21:38:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5ADE6E48F;
 Thu, 25 Feb 2021 21:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSKntVog/o1Ddq5OSmDuP7hVgPEUKTuVJUEoBX9wWKQ8CNziaWTYmYPC8OKMfpTB43bzmzbhpVyJtElVTHhtQHgndfVbEj+ozQ8qWqB7Dd6GEbTe0Xzj4djTkpn7xKL9dutpCCA0Pauwe16zvHzXXNWLzwVG6lHiJo0JmXeRXcNhnc5CwTtzS9yoa0huQDz/EnO1kkIHaPNL+N6FTF/EDRKZXshHen7WSqx2kB2/mze7JyRtwtzZWzWOKpI4rh7DLFDUpyWUmR9VOgjaaCdHM7AQRArPWP6AIkHayGKqv6FMfOMwUipIOYZMdjTaZZEC3A1ffVqXaruynjFLP+vFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jirAo0Vn/irh/tz9uz5OYNTneeUqQb6ATHk6Xp0FylY=;
 b=HcNDKK09M50Z94gS95hmLiE6QSmyyEToYZDq48hgSsg22Ew3vLl1rrv8QMN7m/EYVJ+/iBvzKfWDn3bh5BSFVCLwNg49GPDeP7oKhC+Az/n8p6/eTjjHwIWdsrksSStLBzAsJtD6KWVG3MUBIEpY0asXfj3PJZNRXG9uqwmB1aRgKyqfgMRlP+MOi9La/GVJgQzr7Em98TRX+7/SkYqxUomnRWXwhfW2KpC8CoigQLpXaVlU9UVeY0Kk+X8OPaozUooFdM4G3NMSo7Ccxf2YVyxowMxiUtjcaDkjvE/tDIlfZq+8rspd5v2Zy31Io5MCzonI5DDKr48lx5Buxz6/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jirAo0Vn/irh/tz9uz5OYNTneeUqQb6ATHk6Xp0FylY=;
 b=hcv88GkmoHv/nLUZXAITijKemFAZdG4SCJ+fFz1wAres5aZT/4Y6CXTX7DaVJ2qMN80MBgcNNAHnKKBtPsPF8ubavrK5hArH2wVWWMkmrT2PBR31gOlLF1+eZKeJUWGSeSoHBI/CxP6oJxcztoDFpBfn8omLrY0MCzeFBgbVFdE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Thu, 25 Feb
 2021 21:37:57 +0000
Received: from BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::5cbd:c5a8:779:9672]) by BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::5cbd:c5a8:779:9672%7]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 21:37:56 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org,
	ckoenig.leichtzumerken@gmail.com
Subject: [PATCH v3] drm/scheduler: Fix hang when sched_entity released
Date: Thu, 25 Feb 2021 16:37:36 -0500
Message-Id: <20210225213736.12352-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:3edf:49b0:25f7:b1a0:d070:450]
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To BYAPR12MB4615.namprd12.prod.outlook.com
 (2603:10b6:a03:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home
 (2607:fea8:3edf:49b0:25f7:b1a0:d070:450) by
 YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29 via Frontend Transport; Thu, 25 Feb 2021 21:37:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d706b6e-9b7c-4ffc-6357-08d8d9d59d8f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB417724A6760A74819D68B77AEA9E9@BY5PR12MB4177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6uem8K02UtcQKfiUBEywcK2WnhBpYjz3+oWkzoe1oSL2kilTvhnO0VeJ9A1aIHh+pMgZtHRez44Cdsc7MnHSy6Tq84dfT+C7nMWLVfbhv/MhrZPrj1IGbRB5YQhTL6t/bDCCWaGWJDwxlUlVf5vdwW/djyYUlulbOH292J6rNTx1zSN7gIp4xwtyag29OdtLLFXxhUH+ZcwVDZfJSmCF79z0oLbJXSVBnM+L/Buvwfh65+9eXh9OgKNfiHFJFKrPPDKDR2/M9/f89peUzJPWcg1jvFKJLPqzHZ3vUQ4IqtWohMMeHTJ9BuKMMRnwXWrsA2QRDlSoMEqktPIfvHtSE0pPbyxdtMKy42ZsU+gWqYUDCzfhenP2mjNPKlDoGgz70dUmxL27jrrg8e24C7sJlfFiwjRa2AJehKTqO+ecATUKhAAfWyTHSLQlkEEgHWIfG+8L+N6B+S/n+16610D2xboKpEfb9rjftLwjfTea4phDybxtsFhZ5TCVOzYr2IrH5KSzUuEd8LrAwB2tZ2DPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(6486002)(8676002)(6512007)(36756003)(66476007)(1076003)(52116002)(44832011)(8936002)(2906002)(66946007)(6666004)(16526019)(478600001)(4326008)(83380400001)(5660300002)(2616005)(186003)(86362001)(6506007)(66556008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k8ehvw1xOtS7SdtqMMchkI2CGOdo896gAtTFmR61q56P4MeAXNaLcVOWzgMn?=
 =?us-ascii?Q?NSqDoEqAw7uxPDgS6kXEQcBCfm35d72YDvrf7XPLVvDHqQfqMqxtF51R2S3O?=
 =?us-ascii?Q?d9tPYzdm/gFMbN5vp1lxgJGNP3IKKs6D+GRGyaCKE1Oe6Xi8bzsb0rrSyKvI?=
 =?us-ascii?Q?s1tLeSq7O6hE5VuUtVaAZ/XU37VdkaNkWb6nv1JSz3NAiqBAMTBV+JSdLyYS?=
 =?us-ascii?Q?LSJpPqMpHvh6kW1gzpItuIWfTiaT4yjyDuLTOOqs+IcFJ9TygiQkC6REnh3E?=
 =?us-ascii?Q?WXe1iEMOSfwSg1By0yzCO//yK5/yBeHRMBMwru/nVluUXv0yakxCP8cDiS0g?=
 =?us-ascii?Q?ZFq3px8AJTOOwvoK+vfpqT2wBiFoToCI89BXsqVy/5uAYLn8p1w33VCiUpnd?=
 =?us-ascii?Q?ig/IN64KHV/AYS/D8ovLcdMRA5RcrUncy7sHnEUbaJoTIKOwv1csREXFjqIL?=
 =?us-ascii?Q?4/rPRT89ktK+zKyWcgmvF2QFB70Cec14od0cjinQ53GQO/Q5yD7kbapd6ZVz?=
 =?us-ascii?Q?truG34jreCzKBjmWrx9/JAz3lE06iqBXXlagnf0vp/6gKIF0pHhSp/rTdw14?=
 =?us-ascii?Q?j9UDOWasl4GlzumQTnV3Fom1poCvZAj74RlepHXhTRJUH6codRThXYrm0OEC?=
 =?us-ascii?Q?d05uJihPaHny4snit29gxw65sR1HhX+++SHDEp1LJbfHeSMaU79v2CzooTEz?=
 =?us-ascii?Q?BuwGzUB4GGtuytZYPIs8SAvcPvZo4TegI+uDnZ81ygWmymZ1yT35bB6enGHu?=
 =?us-ascii?Q?rEm/pwBYdjCuUWvIByKZThYbE7TQndRs4qycwKikfEYVqVGJcgigMUdwwid3?=
 =?us-ascii?Q?NucRTUz22E+F8JIcEcushkGGj1YRVFFUIMXdri39K+jIiJOl4IFVRFVmQdNN?=
 =?us-ascii?Q?d+aFCD7fUg4HPgGcFwkTNSpPx4vCacn/kRfRv8wM0ooDQTQIIqrk2+PHBUPi?=
 =?us-ascii?Q?heS+vTA5NZRxNpNixNjtd1QVcI/ZvCMGXgiVvt44dvneEhl9yR7SDTVujGeX?=
 =?us-ascii?Q?FZ5Mjm/52dKzRLJPQ6xSyFDl0BHEUbjeZ2NoqFgTB+qHug9+TYR0dceKx83A?=
 =?us-ascii?Q?4WJZUYM3oqeJkShVkmC9zXGDsemmseYlk36Kz+qh0W4jlTq6HHvU4Blp2aRB?=
 =?us-ascii?Q?YhrLQNPqxOM9Hv4mpmApbqeIwlicW+FUr4/Mhq2qbps1vy6sL43t6qHPgBn5?=
 =?us-ascii?Q?Fi8UJiQMFHe8FXmzKBEeylnVM/S1RaL2jXKJOk73QFCsnA6eyPrwTgTSUepS?=
 =?us-ascii?Q?RufQOSgMTOF/eIvLk4OCyNt0AuVXhIHqm71yhExLqtOoPDhmrb3mEeT/+xf2?=
 =?us-ascii?Q?gQWdnTmbJNHLL7ZQDTWKL7oaT21geBUSgQS2EXCaXOOGxGeuVk9LF6QV6Ruv?=
 =?us-ascii?Q?JPrMT6wfBpVtlYgfbHVIhvT5IxNa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d706b6e-9b7c-4ffc-6357-08d8d9d59d8f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 21:37:56.9225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVJyYm9HYjIfaSSSwStPMEPeMoegQz06xe0ughQcH3OZ5fGSH+G4zis5ST1BXvwc2FL8wh/fsfjfikZwxx/l1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Problem: If scheduler is already stopped by the time sched_entity
is released and entity's job_queue not empty I encountred
a hang in drm_sched_entity_flush. This is because drm_sched_entity_is_idle
never becomes false.

Fix: In drm_sched_fini detach all sched_entities from the
scheduler's run queues. This will satisfy drm_sched_entity_is_idle.
Also wakeup all those processes stuck in sched_entity flushing
as the scheduler main thread which wakes them up is stopped by now.

v2:
Reverse order of drm_sched_rq_remove_entity and marking
s_entity as stopped to prevent reinserion back to rq due
to race.

v3:
Drop drm_sched_rq_remove_entity, only modify entity->stopped
and check for it in drm_sched_entity_is_idle

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c |  3 ++-
 drivers/gpu/drm/scheduler/sched_main.c   | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 92d965b629c6..68b10813129a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -116,7 +116,8 @@ static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
 	rmb(); /* for list_empty to work without lock */
 
 	if (list_empty(&entity->list) ||
-	    spsc_queue_count(&entity->job_queue) == 0)
+	    spsc_queue_count(&entity->job_queue) == 0 ||
+	    entity->stopped)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 908b0b56032d..b50fab472734 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -897,9 +897,32 @@ EXPORT_SYMBOL(drm_sched_init);
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
+	int i;
+	struct drm_sched_entity *s_entity;
 	if (sched->thread)
 		kthread_stop(sched->thread);
 
+	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
+		struct drm_sched_rq *rq = &sched->sched_rq[i];
+
+		if (!rq)
+			continue;
+
+		spin_lock(&rq->lock);
+		list_for_each_entry(s_entity, &rq->entities, list)
+			/*
+			 * Prevents reinsertion and marks job_queue as idle,
+			 * it will removed from rq in drm_sched_entity_fini
+			 * eventually
+			 */
+			s_entity->stopped = true;
+		spin_unlock(&rq->lock);
+
+	}
+
+	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
+	wake_up_all(&sched->job_scheduled);
+
 	/* Confirm no work left behind accessing device structures */
 	cancel_delayed_work_sync(&sched->work_tdr);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
