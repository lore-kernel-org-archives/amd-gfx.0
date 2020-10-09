Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8964CC433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 07:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1566022267
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 07:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mU6pr09X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566022267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE6F6EC70;
	Fri,  9 Oct 2020 07:56:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FDD6EC70
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 07:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVlELHUIFPf2za3snnSKt/fBF1AHs2rPt/EyvDfkdr7Qx2PAT8DvFXXGOMcnezmOV5Vwmla8QJnYDNzddGAmrXnP/1oA/OjRHYKfk7/9/b9qlodMHUdqNOYpkKo28yfXUjha4AvlN9yiwVu/YBGPa8BrVudXsO346X8Hc3JO8KPaPExr2hHyXNfYLqJajK2CFMz2BibayUrU5EDHTvk888MrT2lPYy8TLD7ondYhyF8KNRN2IeUgwO23cdqqdu+9keFFyu5EB17hn0WbkemqrdC1+hW2qd+jpPizBs25JGea543nCyEvq5+0EF4zt1DpG2P1zoyFyVv1o0Hc9UxArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uXNK7U29vkXmmtAxl3+Q7ilHiCoOvM7bgLZDXAvRiw=;
 b=OIDr0rt+015sLZz0nk70W4wTn6Zw/HsOkqRgwuwmtxboNgb0zcIIk6sqOqHqcTkV7uToB1iffgcRWxFCornNLuIDSX4OkIRbt2UWFVJNBncPbdo8KuKitywxROVDoV9zukQ9LyX0ydndl5g1Fyc03wM4MUDPPEHAN06vYW9rsq7D9iKu7SpF0ayDNftpce/PLEUyIId+M+sZcNPBSQvu7lYfoDkgrxcdjPaw+Dzc+EvR73Jql6W+2XfxiE+5/kxBw88ywgV4BOvzfOiiaeRnNFfb5EGRaE1thPSKf+0HmxTBqj+RGUGEDWrAreSBzHqVAqdbbRg1p+s9+3qIuiazhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uXNK7U29vkXmmtAxl3+Q7ilHiCoOvM7bgLZDXAvRiw=;
 b=mU6pr09XvU3IQrQ3W+5ByOVnB/L23gEEKRxMOxPuuv41kAGEvoUv5hSUGcOXsoZXGi/iNDtj+Jv88RWWscNJYCfxtTV8WIpxyCwX/6aMAtBMgNVO1+MjX9WWnFyWuTCN9JTn6mx/B1kjSPSrUlfyuiFZ2x9u/OSUUdROJKcdOlk=
Received: from BN6PR12MB1425.namprd12.prod.outlook.com (2603:10b6:404:1f::19)
 by BN6PR12MB1345.namprd12.prod.outlook.com (2603:10b6:404:18::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Fri, 9 Oct
 2020 07:56:00 +0000
Received: from BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::753f:8868:aa0e:6918]) by BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::753f:8868:aa0e:6918%12]) with mapi id 15.20.3455.024; Fri, 9 Oct 2020
 07:56:00 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/scheduler: improve job distribution with
 multiple queues"
Thread-Topic: [PATCH] Revert "drm/scheduler: improve job distribution with
 multiple queues"
Thread-Index: AQHWngPNcgOmnEIpVkm1y0QMhHYYeKmO5pzw
Date: Fri, 9 Oct 2020 07:55:59 +0000
Message-ID: <BN6PR12MB1425712D9E63A75FCF1BC3D4F0080@BN6PR12MB1425.namprd12.prod.outlook.com>
References: <20201009061631.15383-1-Changfeng.Zhu@amd.com>
In-Reply-To: <20201009061631.15383-1-Changfeng.Zhu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Enabled=true;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SetDate=2020-10-09T07:55:52Z; 
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Method=Privileged;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Name=Internal Use Only -
 Restricted;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ActionId=d18b1e7e-6274-41b5-b713-0000de614a89;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-09T07:54:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4653c112-47c6-4318-bbd4-00005f608d23
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_enabled: true
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_setdate: 2020-10-09T07:55:55Z
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_method: Privileged
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_name: Internal Use Only -
 Restricted
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_actionid: 7547258f-c968-4a17-9c00-0000244e1117
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5a5bdd9-ba3a-4208-a3da-08d86c28c323
x-ms-traffictypediagnostic: BN6PR12MB1345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB13455B205483A42AE910E191F0080@BN6PR12MB1345.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXtcFlOnJr2FHuI7Eg0bResyHEW2ltoapP/i4PBRtziB6Tn1+CqcQsnCOTZb9T/S+D5nFQAEED0qNUFQv3N+Lt6iUnEv6MNd6YBy+2mtCldVlIqnIEit/lhk8PiITZeCih+6Xf2j2BDjkPdoXEtO88+d1pMJ3kBBY2cLyxpzMjWnZ2yHBd5vmTsJOtmZM6uHeQdi9g3qo1HJMo7LIGBzLEitlRFVZ7UeGiknmQ/uCugZcrfWJE4KMXLD9f64koTUn6fQPySQA8SFv3BVKcnqzZBrJJz9YFb3qfubPpFc2fm0qiZgrUfBS0ShSgEqrioT2FdvT5JbYusVLJzkdxXQXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(478600001)(316002)(8936002)(8676002)(9686003)(55016002)(33656002)(110136005)(5660300002)(52536014)(86362001)(71200400001)(76116006)(64756008)(66556008)(66446008)(66476007)(66946007)(186003)(2906002)(26005)(53546011)(83380400001)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: xcWRswfS4vZoepb8S32D5L4xm0QfTvGAfoWgstmChIaUnr7K0VFmUB4SZ4VZ5mkIVN+PzjcBgg1c9C2b4PQuvEglZSwogne7JWWDsSk0kmnpOdZOt3AFnTh7E26/eyVGWqCWn4giFk/DEH5SnJMmo0enEhtLTE9vVe5USrdgkjkXKoBjrdp6J0zMloXKTKGLYkXJupFDkPv2klQtPKXNtN7US3Z7UlfyKA3Ij+5BCgzKAKbDeJyHeyG1tvr+XdCxyffIYHe4G0FuMlMxj7u5Tp3PFpGZx+hJ7PgcQOQgdaP56v9dqWKJ4mzz/LxLoi/yYnDSJXd6KgwDrXe35q84cRLWcarfcKtEHeTpn5XNSRVymd/bEOKQHR2kMDMtXNzHTy60zaF8wxipGewV7/rDQ5tXD2NuszZ01UH8hWoeMpg9fKtiVonqDIIayo6l0zhSxNwHvLGSwT0RGhUfwj3/XRUbjyDunFTjudSCe/iq7f/rJkWPEfCYkRGRk2WTHWzzngkJmGzCIRzK66SHIelSY4xXGtjI5/2HLAWRXsBHJ5JG4hryP5ipPwd4I1iWgpdwGmLLPtIKsWBESi8BAf22196s5JqSIeqpu970f8VNpAZ/2KuhHjf1PXdKLz51nLmiJPG9FAqlf9nRBSYKr+nBPw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a5bdd9-ba3a-4208-a3da-08d86c28c323
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 07:56:00.0609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZT097NTGlKty/YHTysasOPeXS0Bsk2cm0i2EMoKHDDlpcifQAgpjhlU/9vDqnoc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1345
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Approved for External Use]

Acked-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

-----Original Message-----
From: Zhu, Changfeng <Changfeng.Zhu@amd.com> 
Sent: Friday, October 9, 2020 2:17 PM
To: amd-gfx@lists.freedesktop.org; Liu, Aaron <Aaron.Liu@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] Revert "drm/scheduler: improve job distribution with multiple queues"

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It needs to revert this patch to avoid amdgpu_test compute hang problem on picasso/raven1

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
 
@@ -714,7 +712,7 @@ drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,  {
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
 
 	/* Each scheduler will run on a seperate kernel thread */ diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h index 92436553fd6a..a33590e62108 100644
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
