Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6CDF53D81
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE2A10E283;
	Mon, 16 Mar 2026 18:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="INpQLgTc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FCE10E283
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOKppUmelkZyjnAF9TXLa0JgEznH+buM4uuU2PKe1d+uv4lD/j/ZkujpTUXh306iqVL/cCtJgXFfiPkGupJDicaxl8//oPJInrdoGsak1E7ZCzHs6kdK/2Z/ulRlsy1zZ5MH4u6Z/SYv9Y99jp2LEOVixuJ81qOg89rVYOP3+kFiDQQgCVZPYiYDDfjtdt78LPR8fOlBk7yYA+DqLlbtSkaXbybq3Nb6YSs3krWp6nCOxbliC55opvSn8tgKASxYf4wwVbTsRpz55N3/M5uEcspoG2B5vE2FE7Q0bHknSLGesAW7HWEp64bq26936pTfpWzX7aKFP/sTxiNraYQd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9XTjtiSsclmUxOCxq4eDz9WJRrI9DU1JY6ZH7qNQa0=;
 b=gyC+YCpPGl//0nnzyczjMUpYI8oL6fGukYpE2Sxh7CG5IsZZPcpwLkub1DGWljp3Y//uDh/hQiDcgBB6CZTIwIPOsx/K3vzTlvCQDpPNlKALGkgPiCdllBbRL4+Hn+vKe80BqXeVsz3Ofc9sbHuFHGGOCdO1Dp+lJj68KabeyurUyfZxgP+Y+Ji2oTk9pBBda8dVzlXCm4lprNTNpVH7cZKVKWRVpqscu69Pilc+yPaZRgXH86iNMdjy0nLElwFSCU3jKiCWycm2AJOVcwffUnWouMLQEZ+QJbM4DuZvG535g8QIP3aq1D/LzA3S6vJtzEBcWN3lGGmantsu+oSI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9XTjtiSsclmUxOCxq4eDz9WJRrI9DU1JY6ZH7qNQa0=;
 b=INpQLgTcGY9u5DKBEXEh21VB8/0YdDTwPxHl2S7oVRdg/Qbiz+YYcVhw4XI6z1Fm24l4xJj3LooTy3b+Zvw8b9deKuxaRuNTSIfcGD0cf7imys2qMjp+95sL8JChOgbJ5yOFaR+ipjKhqJ33h46gOK64JBgWeycUm98WTxPhUpc=
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 18:16:57 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::93) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 18:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:16:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 13:16:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 13:16:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 13:16:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/7] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Mon, 16 Mar 2026 14:16:42 -0400
Message-ID: <20260316181648.2005897-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e326ee-b540-42e2-9be3-08de83883528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aD1yRlltOUok+IAIYYDlKQ8zVsd4oEcqIzgYceEYkyna8hZW/9d7ZO9eg/R3oiRwC6sO0bclXUbyIxU10DW/oXgAEyXPfUZrdTmPGoIyEGklEiHxEtVWu6sA6X43lvRlNQhGPdaPTuDZsL9F/s2Z1cGv0+ubo92ETQg2xt6O7FrqpK+xN0a+dorkIkNSdC6zVyyhrDLF2KrZSzrhg+c+zI8bjXbDqROqWg/P7K0adQbluT3s5HFB1ew+QPptw5noJxtCdn3zELmZ6KLMWyQYsybCakBX24hSBg3V3jfRbizwvfmKFxBUmw/3wqR6pWOpVYXdIfg1s00eiyQMygoJgcg+86WPZ6J1c1bLTQ9uJmraezA+G3cCpdkyInuvMeCO86g46y0fkjhz3pipXB5VN1nR7B5szNh8JnYKKR7S2Akwt80PUtUYQkRkzqEu/GufynBe4xKspEy2/UYpB7LQi7lNlkmXmRTjs/1EbNQUYReFualtmIKbxjp/Nu+luORegY0jaK02jmZGC/nBdf+fVq4rwjnWqOyp4eQQjia7+w7H+w2W8dBEyTgA2mySYZARRU/R0sAfa9GLOn4fshK9f7KS8qD6TakP9m89pN9p4kxh6UTURw+dCaBIiuo7i0CHub0yU70UmRZKeQFCqcnGyrItygSLq4vE7FVD81CS4ZQpiYjxXmnEdJ29NLx9gdclDgpHElwAkO9hcfWn22yuSbMZcIdhV9lYKxGM0ouMw44U/Bg+3gs2Djuxto2YfA24DLavWReqLfossACL1xiChw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cp2BSOl2r2r6oe6UlK4UI8ESXV1Y5iwGl3LQjkBhXOAg1aDI/dbnFOYSVuJ2q+hoMg7GaZ2wjFzLeN2+xd01y2o2R+2xQrDLOd29EQypTUIhhCwRk53LM6/7DpViVIU7utvbXqPPfwoHZEr5PK25zue5L6uZiinotNc1flEIYclAf14qdoAcrqKzBjMI1WbX9Nf5E5kfp3ELCnhIVhtY1G/rsQmW6M/+yq7kbKSCNgir6O7dZVm7qrFoJ6akIgd0jH08k5ahPUXhvsmopQTaQPN1ZZ9lPC2+W/9b0A/lg/Y8H8V7SIsnj6SBQrJtAC1XXvFKJ/YH4cJ4B98wuKC+K/45TLbZ4FmoAAuK5oeBNPdDKacalsJH6JdZgb67M1SbrrmSuLIM4pbESqEBJTZXJVk0UkEEPLCvaRsYQjdc2j900U2rcJ370gRlybuLlXTL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:16:56.3405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e326ee-b540-42e2-9be3-08de83883528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
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
index 3bfd79c89df32..823b92005689a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -671,7 +671,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 		goto err;
 	}
 
-	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0);
+	ret = amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0, false);
 	if (ret)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b8d23a9f6dd36..53e2eec734b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -275,7 +275,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	for (i = 0; i < p->gang_size; ++i) {
 		ret = amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
 				       num_ibs[i], &p->jobs[i],
-				       p->filp->client_id);
+				       p->filp->client_id, false);
 		if (ret)
 			goto free_all_kdata;
 		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f1ed4a436f5b4..80565c4a31bdf 100644
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
index 55172c2dcc355..95aa87b4406eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -188,7 +188,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job,
-		     u64 drm_client_id)
+		     u64 drm_client_id, bool need_atomic)
 {
 	struct amdgpu_fence *af;
 	int r;
@@ -196,18 +196,21 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -246,7 +249,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
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
2.53.0

