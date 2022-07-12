Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F24FC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 05:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942BF10FC5A;
	Tue, 12 Jul 2022 05:39:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03CF10FC5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 05:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY+QP9uUhrKnnTMSlmlYpf1JOe8RI4ZjX0zsmOGZ0LjuABLCvMqBvjQwSTZej2HrVbarcT9XDDvIL05osZCVrWnAj8MMI+3T2ycfOkiQvsGD6/TF2/EWanQWbMZFIxKlBkwBtEBMTcyWvtGt8Cqt+J2GLC+oP16MMsnc2HVykERsbOFbS7akIMhTuiZFXauVZoyQjEdZo67difXEJOH8qKCh9Cv8SwvyMjw3Uv2iRpCbcW+MG6cbXfc7l27ujQTgdFsoJCozQdOWf433srAv5WOKti1yBRpeiQz+MlvkrapK/9Rvi+WXAdXMJNoVkN1PKn5eRcJUcrXHulXti8pxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT2fSV21ouK95ZTOXoeTqZKo6Ey4xSR7Z/0UPjMJVHI=;
 b=CwsP00lFkVHYwkHFrfbBeAokeEMwdDJdhalRUK3oWASeSh7u8zewUgt3H6aqRnJ30MSUDj4G9uEovHqyTTzK98h7PY5rqMBmWok/+tqquhj1URoVyFMxwiVhp0BszoGL/CzmsvVo+rFsQCPSp3FOOff7mkoCsbVtW4xnguiGY5PqfnL4ISGPpLj10u/LvGwmVV3B1BCNrXzdPAEvSCxS4rw1ka3X+Kx+dPPz7y5LnMuKFLHQ2O0Dv56Rau/7RdWMToCKXAJSxEglIiakl/g8RyS8mZHncd7t04eY/5j6b5mjsI7lHY7RNPOCc8XY97Q9nOa//Y+XCv8pgSv52hS83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT2fSV21ouK95ZTOXoeTqZKo6Ey4xSR7Z/0UPjMJVHI=;
 b=IsSXisfykuzAh6wkQnOdfEoiLyHOsHxo77gHusU3ev9A99QPv4wdEm+Rd+kE1Ek1M1wWER6iloF0is/e6Qxw+XiJjyB0jZFUIVzMQjo110jEnUaNU27IKNwSytYN0VwR6wQ5RRtjjQIldKsTViynvEMHNJSNTLeMp1fzcKWLKBM=
Received: from MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26) by
 DM5PR12MB1161.namprd12.prod.outlook.com (2603:10b6:3:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Tue, 12 Jul 2022 05:39:49 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::a2) by MW2PR16CA0013.outlook.office365.com
 (2603:10b6:907::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 12 Jul 2022 05:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 05:39:48 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 00:39:46 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 1/1] drm/amdgpu: Protect the amdgpu_bo_list list with a
 mutex
Date: Tue, 12 Jul 2022 01:39:24 -0400
Message-ID: <20220712053924.91960-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
In-Reply-To: <20220712053924.91960-1-luben.tuikov@amd.com>
References: <20220712053924.91960-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c1ccdf4-b06e-440e-198b-08da63c8efa5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1161:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByaCyzEe9+CnfGyPRqQKLmS4RavzOKXq+p9XtNX1I9SLMdQBnW6Xlm5bcE8dsG9voKFbKbHapdkf+Z8Zoi1TKNuAnz1nIc+wX0ry1i61u1Uc+2jeV10icUOBdGpIVd8/QVRPcBcq30hmn3PenpMd2R2MsbcVpEZ9JDILUahyWaIgctrD8U0LmIEOu8aD4nU17pKSN5OoKh9GYvl+dko/rLsTIvmZh3VIMULivYVCVPDCpCQq3rD72PeIhn1moRhRaL+GI12Y2r+QS0wwjIitbm4Dck8r/uBKq2657v5qp2V+eyILQWSxt8dll6StS/OV29Ew/5WsgDI6SPh8in2QvheUSduef47QgTvp1THZ3it2q38d8/DGj59ouksbbT6/H+h/0FkNxxl+1W2IWr/LvYeKWcTmF5QyScNDVJimByZ5dXHT1cIhxGInknTx0nR11O59yT/WM30MFkPk4g6Px0/l2Hgv5ExFXQjpsXz8t/vp0JfrzlQDvz8zfkqTcqqyl1CeGrJxH3dzdTGsi0k4HOFavAEF+vRqLqgd8Z1US8izqnxomDHCGopujKoc5/jhyP2ZAnvN5l2eRZgNT5VBCun/dRUNJ26QTvLNMhmLWCvHyHFEfgMzv1Y3ERaJ3Xb2Hul0Eh/Re64xmODX8Pm5cl31yJKnQBGE/kXM74h+nXgGcnF6Q+E1CM/89d0a0UGtKk7jeGjnlf7a4jHZgDubgnQdUcE+IIlNhSE8mqNiy91iIOvRwJeBCzAEjCnPodNTpdUNwuC1/JhqwVp9fTlDDQmmgK63v7Eas7iyJJDjRQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(83380400001)(40480700001)(426003)(66574015)(16526019)(36756003)(336012)(8676002)(81166007)(186003)(54906003)(316002)(36860700001)(4326008)(70206006)(70586007)(82740400003)(356005)(6916009)(47076005)(40460700003)(82310400005)(478600001)(966005)(1076003)(86362001)(7696005)(2906002)(26005)(6666004)(41300700001)(5660300002)(2616005)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 05:39:48.9655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1ccdf4-b06e-440e-198b-08da63c8efa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1161
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Protect the struct amdgpu_bo_list with a mutex. This is used during command
submission in order to avoid buffer object corruption as recorded in
the link below.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 31 +++++++++++++++++++--
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 714178f1b6c6ed..2168163aad2d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -40,7 +40,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
 	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
 						   rhead);
-
+	mutex_destroy(&list->bo_list_mutex);
 	kvfree(list);
 }
 
@@ -136,6 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 
 	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
 
+	mutex_init(&list->bo_list_mutex);
 	*result = list;
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 044b41f0bfd9ce..717984d4de6858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -48,6 +48,10 @@ struct amdgpu_bo_list {
 	struct amdgpu_bo *oa_obj;
 	unsigned first_userptr;
 	unsigned num_entries;
+
+	/* Protect access during command submission.
+	 */
+	struct mutex bo_list_mutex;
 };
 
 int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 36ac1f1d11e6b4..0b2932c20ec777 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -517,6 +517,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			return r;
 	}
 
+	mutex_lock(&p->bo_list->bo_list_mutex);
+
 	/* One for TTM and one for the CS job */
 	amdgpu_bo_list_for_each_entry(e, p->bo_list)
 		e->tv.num_shared = 2;
@@ -544,6 +546,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		if (!e->user_pages) {
 			DRM_ERROR("kvmalloc_array failure\n");
 			r = -ENOMEM;
+			mutex_unlock(&p->bo_list->bo_list_mutex);
 			goto out_free_user_pages;
 		}
 
@@ -551,6 +554,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		if (r) {
 			kvfree(e->user_pages);
 			e->user_pages = NULL;
+			mutex_unlock(&p->bo_list->bo_list_mutex);
 			goto out_free_user_pages;
 		}
 
@@ -568,6 +572,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
 			DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
+		mutex_unlock(&p->bo_list->bo_list_mutex);
 		goto out_free_user_pages;
 	}
 
@@ -580,11 +585,14 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			e->chain = dma_fence_chain_alloc();
 			if (!e->chain) {
 				r = -ENOMEM;
+				mutex_unlock(&p->bo_list->bo_list_mutex);
 				goto error_validate;
 			}
 		}
 	}
 
+	mutex_unlock(&p->bo_list->bo_list_mutex);
+
 	/* Move fence waiting after getting reservation lock of
 	 * PD root. Then there is no need on a ctx mutex lock.
 	 */
@@ -607,6 +615,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		goto error_validate;
 	}
 
+	mutex_lock(&p->bo_list->bo_list_mutex);
 	r = amdgpu_cs_list_validate(p, &duplicates);
 	if (r)
 		goto error_validate;
@@ -614,6 +623,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	r = amdgpu_cs_list_validate(p, &p->validated);
 	if (r)
 		goto error_validate;
+	mutex_unlock(&p->bo_list->bo_list_mutex);
 
 	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
 				     p->bytes_moved_vis);
@@ -644,15 +654,18 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 
 error_validate:
 	if (r) {
+		mutex_lock(&p->bo_list->bo_list_mutex);
 		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
 			dma_fence_chain_free(e->chain);
 			e->chain = NULL;
 		}
 		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
+		mutex_unlock(&p->bo_list->bo_list_mutex);
 	}
 
 out_free_user_pages:
 	if (r) {
+		mutex_lock(&p->bo_list->bo_list_mutex);
 		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
 			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 
@@ -662,6 +675,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			kvfree(e->user_pages);
 			e->user_pages = NULL;
 		}
+		mutex_unlock(&p->bo_list->bo_list_mutex);
 	}
 	return r;
 }
@@ -704,6 +718,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 	if (error && backoff) {
 		struct amdgpu_bo_list_entry *e;
 
+		mutex_lock(&parser->bo_list->bo_list_mutex);
 		amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
 			dma_fence_chain_free(e->chain);
 			e->chain = NULL;
@@ -711,6 +726,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 
 		ttm_eu_backoff_reservation(&parser->ticket,
 					   &parser->validated);
+		mutex_unlock(&parser->bo_list->bo_list_mutex);
 	}
 
 	for (i = 0; i < parser->num_post_deps; i++) {
@@ -839,6 +855,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
+	mutex_lock(&p->bo_list->bo_list_mutex);
 	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
 		/* ignore duplicates */
 		bo = ttm_to_amdgpu_bo(e->tv.bo);
@@ -850,13 +867,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			continue;
 
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
-		if (r)
+		if (r) {
+			mutex_unlock(&p->bo_list->bo_list_mutex);
 			return r;
+		}
 
 		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
-		if (r)
+		if (r) {
+			mutex_unlock(&p->bo_list->bo_list_mutex);
 			return r;
+		}
 	}
+	mutex_unlock(&p->bo_list->bo_list_mutex);
 
 	r = amdgpu_vm_handle_moved(adev, vm);
 	if (r)
@@ -874,6 +896,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 	if (amdgpu_vm_debug) {
 		/* Invalidate all BOs to test for userspace bugs */
+		mutex_lock(&p->bo_list->bo_list_mutex);
 		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
 			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 
@@ -883,6 +906,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 			amdgpu_vm_bo_invalidate(adev, bo, false);
 		}
+		mutex_unlock(&p->bo_list->bo_list_mutex);
 	}
 
 	return amdgpu_cs_sync_rings(p);
@@ -1249,6 +1273,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	 * added to BOs.
 	 */
 	mutex_lock(&p->adev->notifier_lock);
+	mutex_lock(&p->bo_list->bo_list_mutex);
 
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
@@ -1308,12 +1333,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
+	mutex_unlock(&p->bo_list->bo_list_mutex);
 	mutex_unlock(&p->adev->notifier_lock);
 
 	return 0;
 
 error_abort:
 	drm_sched_job_cleanup(&job->base);
+	mutex_unlock(&p->bo_list->bo_list_mutex);
 	mutex_unlock(&p->adev->notifier_lock);
 
 error_unlock:
-- 
2.36.1.74.g277cf0bc36

