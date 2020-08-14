Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00FFC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C334920768
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eWkw4KAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C334920768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0576EC07;
	Fri, 14 Aug 2020 19:14:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23096EC06
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 19:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0QJQT20ZnzViF5UfogKu0cPtmqSCB2qoMGmjFVFLGaBgKHQWT+T47rme7Si3KCJltPYAHNNsKL5xeQ5pQLy5zITmp6Cu25okbeL7fvjY4Pz7QzU6o2/v6nB5+FMw0dZw+YsG1Ga4WquQRTfQzi7QM3DHIQf/KAtdk4P1rCTEuJccwPy5xlcrBjkY4qy9aPT2xs1xjsHrOqvPFX6DgGDSWuCwYBJUxwHGpYy+UTVsufwdZLVZ8KxoaxaHQ1gHRXOCMtQkxpe6J9RUxOrIFyxYm2yqCi63TLpRYSCBWnXmjh4M5E0H8sOMRZlyVQZ6pztumwi7ylvv4XdCUpofmRH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKKz6vwbE9E7vXCK1hFUd9LwekKWRpm+Os1TauzIqf8=;
 b=Ez6VLM12ps0uQHgf+/gPgJ1DUsWsUvk52XitwW2bxakgY1jP2CRYTjmjMCvVTw2gWdxXroW7/9Si7IMZyQx0TajKu9hwOfmhdoPVPNPY/qp8gQemyz4pEE6Son8Rr3TK2ezxFsy2H0AohVKhuArMN9KDO9ffzBmbYfJpOicoCTXUVLZYfy2prCPEQlPuyLUmnPnlTMDgPwjRRCH1ZRAUiuprNsC/kESeBCweL3xyNtbYC82y3AY/hGi5tWMapf0ihyljHQVOnRt8Yrxz3+rMwRPRUzsLvixHsz4YyRtNgjH0h2yOYQfD7A6fpNxm5HWD6TpxyVpMZ3EwZcnrdk5hAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKKz6vwbE9E7vXCK1hFUd9LwekKWRpm+Os1TauzIqf8=;
 b=eWkw4KAYUWBaNjp+Wodj/g6d9Tqp+XffjcTlm39qtSsn7mPbR2BRmOop1Ul7OnQsUuI9+TrFOIG7sWyxvZXNxvvTdxkZQ1+uGZxwoaqHy1c1fgPXf+Qu/B4DW89OaGpCeaK6Y2Zg64EgpDC/0LNvcRwCUJgZG0oJWc7EJfV0mAk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 19:14:23 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 19:14:23 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/scheduler: Scheduler priority fixes
Date: Fri, 14 Aug 2020 15:14:00 -0400
Message-Id: <20200814191401.25606-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.215.g878e727637
In-Reply-To: <20200814191401.25606-1-luben.tuikov@amd.com>
References: <20200814191401.25606-1-luben.tuikov@amd.com>
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 19:14:22 +0000
X-Mailer: git-send-email 2.28.0.215.g878e727637
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11ca90ee-59ef-400f-94e8-08d8408640df
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4217611539F7BA1CFBD6525299400@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17h5km2HUXA0XIQIL05hmemylsQIVCB4GGlmJfDzyHLBN+/LKF1fhvwQ8oBArE+Qv0rgBDDMwSOFbfCNLPRENy9XZIirmeajCqoeNaEy9vm97HG0kQGG8giAaynKW20KEFMKPWQHKFTj42gJOrr/3gTKs9xqnUdSY+gcOGX3Iu6OxuHlirjsPDrgU0baRV5uziyCedcIKL9zR//97QS6FfyiN2ns9XixEXK55yidR2+JizPYq94OzgdHSBfHdAaq47mgBZoPOmkTVeWIgGFo8Iu8GpeX23DWQIFCv1mJLTNvVAlBD8U/MFCYXgNbM13xFhHnqCeVTu9XENOwBymdjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(6486002)(4326008)(7696005)(86362001)(36756003)(186003)(52116002)(956004)(16526019)(2616005)(1076003)(44832011)(26005)(66946007)(5660300002)(8676002)(8936002)(2906002)(83380400001)(316002)(478600001)(66556008)(6666004)(6916009)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: f94EN4+T1PpB3ETxTAdKj0L8hrS7PCpVzRAgKCg67RTU9UT7cFjDU8mcl3dRUdGYHNUizyrkyvc1hY5WgMG/Cb3Ooc9NJo0ROIUSz/Xi7l4GXO0tUApAoEVs+97wMIJVQJKSDgjpXH18oMnaUyZmSPTbfo9BWqLOZFAFa04pUjFHb6hpfqhQGvLxX+JtRkn0K+umHPKHoo4iPY9Uum7pNr/WtIRn1iBHGvkltCMhnYBBBwxc6nQ7f6/mxK1gfeTpInB8Iii2/R37iALGCE/e9FkQj37I0Nq/yQgcNrFPIWJX/JnSOiXIzgC55banVWRokKSmM2mtn3vqVH+VMydQYZPYoPqE5QesqkfhRdP1MTNHwU6dtCulqd43DgxBiYHGx2wxkN5tcgAZbo3xL2z6VC7O5SXRYw+1v5vkNb15CYc4jZQeVEfxwS+wnueiIKWq53ZZHCQuHgB8AFjgoWXLmiquhzOyG42/sWHoI1GGvh1nJ52lQxLR3eJ9S6Nr/0cThOpglMc72z2pCTuu2ep0u9Z9aogGvxyRI3Ka16yiIzAquJGgoQGVV+gXPBZEIONlbKUltfbhOHBKmY3/PjoAJuCzm4+8PEkwHNnjWeqaSc5BmuLXZ8Q1gDwegiSRplqipHAm7af5LVM8UkE4h3LTzQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ca90ee-59ef-400f-94e8-08d8408640df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 19:14:23.2913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5vpb4FM2iDm5z9TcBRHL20bWefBbT0LRp55LfKqVw+1DkDn1rK+lLp/uMgvArJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove DRM_SCHED_PRIORITY_LOW, as it was used
in only one place.

Rename and separate by a line
DRM_SCHED_PRIORITY_MAX to DRM_SCHED_PRIORITY_COUNT
as it represents a (total) count of said
priorities and it is used as such in loops
throughout the code. (0-based indexing is the
the count number.)

Remove redundant word HIGH in priority names,
and rename *KERNEL* to *HIGH*, as it really
means that, high.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c    |  8 ++++----
 include/drm/gpu_scheduler.h               | 15 +++++++++------
 8 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d85d13f7a043..fd97ac34277b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -46,7 +46,7 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
 static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 				      enum drm_sched_priority priority)
 {
-	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
+	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
 		return -EINVAL;
 
 	/* NORMAL and below are accessible by everyone */
@@ -65,8 +65,8 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
 {
 	switch (prio) {
-	case DRM_SCHED_PRIORITY_HIGH_HW:
-	case DRM_SCHED_PRIORITY_KERNEL:
+	case DRM_SCHED_PRIORITY_HW:
+	case DRM_SCHED_PRIORITY_HIGH:
 		return AMDGPU_GFX_PIPE_PRIO_HIGH;
 	default:
 		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 75d37dfb51aa..bb9e5481ff3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -251,7 +251,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 	int i;
 
 	/* Signal all jobs not yet scheduled */
-	for (i = DRM_SCHED_PRIORITY_MAX - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
+	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
 		struct drm_sched_rq *rq = &sched->sched_rq[i];
 
 		if (!rq)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 13ea8ebc421c..6d4fc79bf84a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -267,7 +267,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			&ring->sched;
 	}
 
-	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
+	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; ++i)
 		atomic_set(&ring->num_jobs[i], 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index da871d84b742..7112137689db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -243,7 +243,7 @@ struct amdgpu_ring {
 	bool			has_compute_vm_bug;
 	bool			no_scheduler;
 
-	atomic_t		num_jobs[DRM_SCHED_PRIORITY_MAX];
+	atomic_t		num_jobs[DRM_SCHED_PRIORITY_COUNT];
 	struct mutex		priority_mutex;
 	/* protected by priority_mutex */
 	int			priority;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index c799691dfa84..e05bc22a0a49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -36,14 +36,14 @@ enum drm_sched_priority amdgpu_to_sched_priority(int amdgpu_priority)
 {
 	switch (amdgpu_priority) {
 	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
-		return DRM_SCHED_PRIORITY_HIGH_HW;
+		return DRM_SCHED_PRIORITY_HW;
 	case AMDGPU_CTX_PRIORITY_HIGH:
-		return DRM_SCHED_PRIORITY_HIGH_SW;
+		return DRM_SCHED_PRIORITY_SW;
 	case AMDGPU_CTX_PRIORITY_NORMAL:
 		return DRM_SCHED_PRIORITY_NORMAL;
 	case AMDGPU_CTX_PRIORITY_LOW:
 	case AMDGPU_CTX_PRIORITY_VERY_LOW:
-		return DRM_SCHED_PRIORITY_LOW;
+		return DRM_SCHED_PRIORITY_MIN;
 	case AMDGPU_CTX_PRIORITY_UNSET:
 		return DRM_SCHED_PRIORITY_UNSET;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 20fa0497aaa4..bc4bdb90d8f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2114,7 +2114,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 		ring = adev->mman.buffer_funcs_ring;
 		sched = &ring->sched;
 		r = drm_sched_entity_init(&adev->mman.entity,
-				          DRM_SCHED_PRIORITY_KERNEL, &sched,
+					  DRM_SCHED_PRIORITY_HIGH, &sched,
 					  1, NULL);
 		if (r) {
 			DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 2f319102ae9f..c2947e73d1b6 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -335,9 +335,9 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
 	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
 	 * corrupt but keep in mind that kernel jobs always considered good.
 	 */
-	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
+	if (bad->s_priority != DRM_SCHED_PRIORITY_HIGH) {
 		atomic_inc(&bad->karma);
-		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
+		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_HIGH;
 		     i++) {
 			struct drm_sched_rq *rq = &sched->sched_rq[i];
 
@@ -623,7 +623,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 		return NULL;
 
 	/* Kernel run queue has higher priority than normal run queue*/
-	for (i = DRM_SCHED_PRIORITY_MAX - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
+	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
 		entity = drm_sched_rq_select_entity(&sched->sched_rq[i]);
 		if (entity)
 			break;
@@ -851,7 +851,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	sched->name = name;
 	sched->timeout = timeout;
 	sched->hang_limit = hang_limit;
-	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_MAX; i++)
+	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
 		drm_sched_rq_init(sched, &sched->sched_rq[i]);
 
 	init_waitqueue_head(&sched->wake_up_worker);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 26b04ff62676..8ae9b8f73bf9 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -33,14 +33,17 @@
 struct drm_gpu_scheduler;
 struct drm_sched_rq;
 
+/* These are often used as an (initial) index
+ * to an array, and as such should start at 0.
+ */
 enum drm_sched_priority {
 	DRM_SCHED_PRIORITY_MIN,
-	DRM_SCHED_PRIORITY_LOW = DRM_SCHED_PRIORITY_MIN,
 	DRM_SCHED_PRIORITY_NORMAL,
-	DRM_SCHED_PRIORITY_HIGH_SW,
-	DRM_SCHED_PRIORITY_HIGH_HW,
-	DRM_SCHED_PRIORITY_KERNEL,
-	DRM_SCHED_PRIORITY_MAX,
+	DRM_SCHED_PRIORITY_SW,
+	DRM_SCHED_PRIORITY_HW,
+	DRM_SCHED_PRIORITY_HIGH,
+
+	DRM_SCHED_PRIORITY_COUNT,
 	DRM_SCHED_PRIORITY_INVALID = -1,
 	DRM_SCHED_PRIORITY_UNSET = -2
 };
@@ -273,7 +276,7 @@ struct drm_gpu_scheduler {
 	uint32_t			hw_submission_limit;
 	long				timeout;
 	const char			*name;
-	struct drm_sched_rq		sched_rq[DRM_SCHED_PRIORITY_MAX];
+	struct drm_sched_rq		sched_rq[DRM_SCHED_PRIORITY_COUNT];
 	wait_queue_head_t		wake_up_worker;
 	wait_queue_head_t		job_scheduled;
 	atomic_t			hw_rq_count;
-- 
2.28.0.215.g878e727637

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
