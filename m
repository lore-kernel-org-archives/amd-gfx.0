Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A04D2ECFE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F76B10E549;
	Tue, 20 Jan 2026 01:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLnFekNg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C2310E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucBlrzv4SuQkkV2ZQGX+La1HTPTToRx7313n4MZuUN71wQcgXq8neQbw2/X50S1tULTCmOrP+UZELLz+AzSic71un9aOREGNQWeeFIn7xCKmk5kq+CxLRlDtQl40ijM8D5qTcqvm0ODMO29+Sq3gDioTOhYqGmwKGdrkdORzepK9yPhUp3Ay5XjR//o7lMCUM9uJjXNQL0l6ZFbR2ROcnz9FYgmXdogEje/m/abgV90bLhA6q4xn2SxmwvuqPVSuL+pnwHrxaCDUQgsxtvK1aIAAzIjVhYx3q/ciDq4Fd9isZLs6vWoHVXmEF3RU2r062eiMaTZFtUmAilh/YzC/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFPaV3V5Plo0l+A4JjEvbVRYZVZdhujdSVPggmGbwZg=;
 b=j8KHiogzX9Fcg3BhmtZVE2IVnc52c6dpriC4snQg9mWdtoKFDe0F/VsGdd3iauuQeMoCdDNDsgr+/wGVeD1FaBPfOQtH7y9UYrq1A29Ajr/kAfH2ifFBw8voHCKSmHbteO8zs6nsPI5JrT/YX+Wcm0vrENIT098YkNVf+6LEJBaaW2REn0OY0eDcQQqZA2BAphOQ3Ia1oejC8lL7181bIJfagFULmjAmWEgOVSofoPr2yMlmrX5+lMgQrgiY790UOwepbPAte3nkb2Gre8XAf9NGGofUUNn0KwLfd0Rs3ywhBV807EehuumCIRqb5eh3LCUThLhE28etVJwn6nSw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFPaV3V5Plo0l+A4JjEvbVRYZVZdhujdSVPggmGbwZg=;
 b=GLnFekNg+2/m9iMB7/dMX96JwRwLt9ldEQaMyDEbekcsUJkb1cQsK0mzk6eOtFZHhymw/XqXiesWXha5SMe3aPuQbatq2Dt9E3UKzwxR4WZIPkq2iWJSZaqXE+/NWAd3PW6gfICgzBj5fTFXvqFbjS85gOR/x4rtbEnwFS2wxuM=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:34:22 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::24) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 01:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:19 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:19 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/10] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Mon, 19 Jan 2026 20:34:03 -0500
Message-ID: <20260120013411.15659-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fdf972-3414-4b0e-4f0f-08de57c409d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfggONbdBNzb+Tm5iBcZrB7FN2kdY690AZpTY2E3p67HOgMdhKReSNNXFCGL?=
 =?us-ascii?Q?pej7dNAgz82+hFo9tqIKjEFqr/304zC+nc50Sv8rLUJMpLYshmYQnReeaDaz?=
 =?us-ascii?Q?Dyt4jGBVQGL1TQnGmaU29sNbARp2EmLKgvU73TzIj50TVGi8uD8OfrrsL7WU?=
 =?us-ascii?Q?TQy8ksEkC6vw5p3j/EgtpvSv7IYtsq+cmDorx8f6gqiNLghGGMqmVH2yA9S1?=
 =?us-ascii?Q?bz023sEepTRdAd1FsUGO33PLT5SZD4G/aJ5P2MaHsEKn8uCLrudY4p5HNkzL?=
 =?us-ascii?Q?YCd+Oq46bob/ofBh2u0LYxfT/n3MG0KtDxrR0moSyRR82VNoQ7IkCysvtFrd?=
 =?us-ascii?Q?MXnXKFlLJPHhAjeNrUzUrqNqR6fR8DY/ECgxNuXkTH+s4a8/dj28ZuUqg3y2?=
 =?us-ascii?Q?NVt5A+tmzjyPMwWGVBQ2CrqMrW521ho0+jvIgS4Q/T9OZkHjKrd2TYQraNE5?=
 =?us-ascii?Q?KsEE1B+XD4XpBj3wmDVUs6uCcdwAXcMjZb/QD0ukDCavKqD18DD/OfwGpXbo?=
 =?us-ascii?Q?r2tZQNJJD9xJzgpARpOCGZwyNihQRr4waWbzYxf8nSP6/7X/KmKDGZr8phVr?=
 =?us-ascii?Q?E56WjmVjoUQow6UXl0aSjGAFmrLvC/ZM2fPhHaD7ucADsWts1BAeHOg8xRiq?=
 =?us-ascii?Q?jvezds1ATqQQR/tBdloZ7DOgazeiYnALugXj69G6K402CStMhS0oDAGd8cpv?=
 =?us-ascii?Q?hlhMaE01L5HEpfYgr2x+Kna5FClxrQv8/63xuWPlV/vpUWWWd+32eS4gQ04y?=
 =?us-ascii?Q?lT5VAjkmITRJXnhdFPDu6T8XZOj1+XVkrrZVUrV9nmHNlHfXnj/pydvS6ZFB?=
 =?us-ascii?Q?mHvINtiY7GoXLHuMmuJzf5hTiEU4UWKTSm4nMMhSUw1GH9R79Y4UQhPjrHDJ?=
 =?us-ascii?Q?bT9Fd/flrx1KRhflV33k4g7loMUZBsiWGlQb+gCnKphopD69cB/JNLywND8N?=
 =?us-ascii?Q?qt5Kwm6LMOhin4wFBzOzNHm+SbBtlLW2wnMYUrKrxi3STX58gPF/P7vmN970?=
 =?us-ascii?Q?d/nogaa3kyZaRpPmIOCmoTtNHUIHOkQndq+HMSmyKLMl0+lOyoC3CIEWRrti?=
 =?us-ascii?Q?JtXOoxVfnUB3unXyj2dPu7q83CxHHypudYSG0pRLoUHBpEEeBoCAOOk8Ef23?=
 =?us-ascii?Q?s/GuG5IdBPkBnKE9Goq/kelGbpig4ERJSrCY7I23pM3XFg3GeZutkZy8k6Be?=
 =?us-ascii?Q?uQyxutlY+bN1iE4XhPMz2NgMEYlabje5+EMa9ThlC3JJoDlU4rE+dLgxqQLH?=
 =?us-ascii?Q?BppV9/IjB8VQQv0hfuLDKwvtIn1HXbK9xqs1en1Et8jFY2xp7XF2/pr0niQS?=
 =?us-ascii?Q?htD+HftejyCjtsngRzORxnZuqk5uVu24YFAjayojiRvvqmwQsoic2SegSAGg?=
 =?us-ascii?Q?MxKNxEEMFfgoYOUlgeo5GrG83thPZ0UKIyOdb0z+Y01WUCGbXY4NHDFb6TzH?=
 =?us-ascii?Q?DTf0B4+fuSdAjSVr5lPUFC8hMAhwX9NIWeRgjrdABW2UZ5kD2Yr0vTNIMfp6?=
 =?us-ascii?Q?e28zbUeXjgwxNPhEJop5xUBYqs1W1UrV2OUuzmr/m74Pk+SO/54tlND++dC9?=
 =?us-ascii?Q?rPgT0tZsTi92iuGLzPxeeQHAaoAR4JNOBjKtT+W4vXhxQbM5wo9BTLq54EgR?=
 =?us-ascii?Q?8w8iOMblJaxAhHA9oG15nEiRErLGpbsGWu7qinGGe7sQtCfP6RokV4aMuIh0?=
 =?us-ascii?Q?D3hUWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:22.1960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fdf972-3414-4b0e-4f0f-08de57c409d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If we need to allocate a job during GPU reset, use
GFP_ATOMIC rather than GFP_KERNEL.

v2: use pool type it determine alloc flags.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 13 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c     |  5 +++--
 7 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 877d0df50376a..89df26dd5ada7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -672,7 +672,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 		goto err;
 	}
 
-	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0);
+	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0, false);
 	if (ret)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d591dce0f3b3c..4d53d9cb8490d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -282,7 +282,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	for (i = 0; i < p->gang_size; ++i) {
 		ret = amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
 				       num_ibs[i], &p->jobs[i],
-				       p->filp->client_id);
+				       p->filp->client_id, false);
 		if (ret)
 			goto free_all_kdata;
 		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 72ec455fa932c..d90966daf52fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -69,7 +69,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (size) {
 		r = amdgpu_sa_bo_new(&adev->ib_pools[pool_type],
-				     &ib->sa_bo, size);
+				     &ib->sa_bo, size, pool_type == AMDGPU_IB_POOL_DIRECT);
 		if (r) {
 			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ec8d74db62758..8660e3d1c3088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -190,7 +190,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job,
-		     u64 drm_client_id)
+		     u64 drm_client_id, bool need_atomic)
 {
 	struct amdgpu_fence *af;
 	int r;
@@ -198,18 +198,21 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (num_ibs == 0)
 		return -EINVAL;
 
-	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
+	*job = kzalloc(struct_size(*job, ibs, num_ibs),
+		       need_atomic ? GFP_ATOMIC : GFP_KERNEL);
 	if (!*job)
 		return -ENOMEM;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence),
+		     need_atomic ? GFP_ATOMIC : GFP_KERNEL);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_job;
 	}
 	(*job)->hw_fence = af;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence),
+		     need_atomic ? GFP_ATOMIC : GFP_KERNEL);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_fence;
@@ -248,7 +251,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 	int r;
 
 	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
-			     k_job_id);
+			     k_job_id, pool_type == AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 56a88e14a0448..9de2cae966fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -113,7 +113,7 @@ static inline struct amdgpu_ring *amdgpu_job_ring(struct amdgpu_job *job)
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job,
-		     u64 drm_client_id);
+		     u64 drm_client_id, bool need_atomic);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 912c9afaf9e11..8abff5fdae81d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -341,7 +341,7 @@ int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
 				      struct amdgpu_sa_manager *sa_manager);
 int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 		     struct drm_suballoc **sa_bo,
-		     unsigned int size);
+		     unsigned int size, bool need_atomic);
 void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
 		       struct dma_fence *fence);
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 39070b2a4c04f..1d44b95de7e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -78,10 +78,11 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 
 int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 		     struct drm_suballoc **sa_bo,
-		     unsigned int size)
+		     unsigned int size, bool need_atomic)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, false, 0);
+						   need_atomic ? GFP_ATOMIC : GFP_KERNEL,
+						   false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
-- 
2.52.0

