Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E989D262B9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4CF10E1ED;
	Wed, 21 Jan 2026 03:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jq8L9yad";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C8F10E1ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAkKpAfN43My7guFedDhNXJkymrJxjvH1xUjzA+Ep12sMpzmCvXqXGr9J/TVBSUSucshg47U+L2w0x9iyFqYpeN0wumO6VkBIdkbCwWgfecBaAEdLxb2kyQRzJnoKzlFA7KfmTAOjRKqlMiKaAVG5S3Uk8LPkKoBeeFLQyHzowUQ8SgRZCdGpBMjcngi2oHwbJtpcZNdrtMQfOlF7Zz46kKuiSUEhgoDcbhsUx9i8YrLTrIuqa0jH/FcZ3pSS7RB/RJFd4RtUsidvPqnyXeh+OsIMSYmtGM3UeiTaLSLIZG2kFN2PJsoHa/JrDAsObbxXBHZE/YRf1wvMS/yF85GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFPaV3V5Plo0l+A4JjEvbVRYZVZdhujdSVPggmGbwZg=;
 b=xVJsPgQCKCNvB/UPbK2tiLiyKZtfKHsVLMbIukkpN3uXylHekFstYNE5Xkoe+uj+HRjf/VRxYTg+bLQQbiVOKNnHiTkyEx1vePPtmBmi365Oat30urdzM+A451TnVcV8j/h44ity3y/A+SCgf3JF4/3a4yxpewPlSJcEGdu0N4F/keUOySFRSLv4aSo26zFcypsgddkYZjlIH+X6ukmtSCuI5CxOYh/goWTFuf+kgwqx415x38aWvkgjn1C6VTRODaVZXf3YY53Jge5IH2e1xm51zIh5Cwja55HxzqlHmavGpjJeiWdHzU7fQP06x+loI8OG//9JAMefewVEdwa7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFPaV3V5Plo0l+A4JjEvbVRYZVZdhujdSVPggmGbwZg=;
 b=jq8L9yadHNr7PVd/n5NrhQOIxNPSSaYNWbtXQIcYfYAIZ80zpMXp3owb2AnLLcN8hjUvC+uR1wN4WAXa7lQ/nI+ly0m8EwkpHR3vU1bSGLQisntEUy4S3RENJEiVYS2EW5Gfz/tKUCjEe+KiPHNwxox6OwXtrtAEmGAQMzSFDf8=
Received: from SN7PR04CA0220.namprd04.prod.outlook.com (2603:10b6:806:127::15)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 03:01:10 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::9c) by SN7PR04CA0220.outlook.office365.com
 (2603:10b6:806:127::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Wed,
 21 Jan 2026 03:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:07 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:07 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/10] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Tue, 20 Jan 2026 22:00:49 -0500
Message-ID: <20260121030057.1683102-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121030057.1683102-1-alexander.deucher@amd.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea35b0c-dabc-458b-2363-08de58995477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?89kgW2XGfYKy04EjSBK7u2oVwcnnaoa5EAE97H8Izb6q5lRlDQgBMoE1AEyb?=
 =?us-ascii?Q?y7pyfqm/z5JrfAznVLxx+NlwBtKi3ltKTIWVadJRKhj3Md3i6rReZhvVR7g+?=
 =?us-ascii?Q?griQYHWT1LQ89YUGcnS1g4TgHcNFx90g3zeZ5/kAqZ1wD81OFV403OCnL5d6?=
 =?us-ascii?Q?hK/oXPj624Pi/FhMcJ8820uNObmgV1wd78CIElE+fD/93vpuw8CKIlXMa0Zf?=
 =?us-ascii?Q?/jeOHP3ADHheMIpZaHzrCXmxJtyaNqceG03FtUAXqbMUielZObnUZD6+SHsT?=
 =?us-ascii?Q?Km4fyLKG/wTIpTF2xdOVvOqflHuwPlV7KUdkkk8X0mMKLYRQdSfY9uM/vALO?=
 =?us-ascii?Q?ASZeyOm9h88+vUv6dIvCztcc6GAgojpZxvTT1D27lyzrsfGKpVkwgVSAyYSC?=
 =?us-ascii?Q?WETfkiZD3knIeRwaVpmkv9JI340i2DwEXPN3JT9oYbGTFJFxRQ7RHfWGoWae?=
 =?us-ascii?Q?VuiiHICr7x8Coxx1J4vc57KG2YoPdOCbrKLBRF02q94hF8HWHcy7Ah8ox6ZR?=
 =?us-ascii?Q?CQTy3EPx/VzNgjh3XMAifzU+8H7KLMaeDcCQvgpaQDnAq/04LsaRF4zt/b74?=
 =?us-ascii?Q?109bLYU/EUmIACUDHupZI5WWoiKr+aQDhHwdKKlb2nL9/wnzyw4Rwf4Qinbz?=
 =?us-ascii?Q?j2w7U2DDNvYZcrgY+pzhUG8oqfrnAU+7yBFCnYSwR3rTBnN37hcbBpK1d6+u?=
 =?us-ascii?Q?ubpeNeBP5PcTE9QwlJsdPOShNbn/7UAtlgydgcUou8X62O11FdMBu4G7KMgA?=
 =?us-ascii?Q?vFzX5OH7HN7gb0P+okH5xko8dPtzXamHJWINKxlMqXtKkW6uq8qg65loEL/h?=
 =?us-ascii?Q?tH2XHgCZOZej2YB8Xy77Fn+OGhglzlesdTj+6a9SJbfByFtU7jnBD9c4+vTp?=
 =?us-ascii?Q?i298e2jEjSFa/lSGypdDXXUlL1s4Us6X729FjL8+EhFuBcJeF3APAKWaEsKd?=
 =?us-ascii?Q?XRDaefEBY5yzFbVL2BP8BAKstmFs1rvma6sdhmz+CQNpu9TdtWy3X8qj7MSa?=
 =?us-ascii?Q?yvJCdS8Or6EnS0CyG2Tzuo+azOOoeuU2IFEwVU2BbDqMQ/r4XC2/J9XpUTq+?=
 =?us-ascii?Q?xHsBhhQXQ8Pn2qT7XSkkgHj7Y4N8OpDK5sT37x3elPyNjx0Hj+vNLFrdZ3sS?=
 =?us-ascii?Q?6ES4cJ6Pp11Q7yRf+/RrBcot+HpfnyZvwfa5ZRZdKMQS8WhKdOBbWG1Et9To?=
 =?us-ascii?Q?CGLa1AgoPXFtbWwOuzkNk0EQ4ycc16NTTGkO7tLYzrNn46wH1+ioqqJnjZLf?=
 =?us-ascii?Q?Hq54teu4EkOOlttgm79lFyLpVsKL2crgHg9uAVo2f3QliNpB+AelZcMYaeJF?=
 =?us-ascii?Q?Cc06qbgBGjWcHy/ykWvaYoh5j/z1TmUSBeQs2cX8tp+Do25DKgBzP+izQwWf?=
 =?us-ascii?Q?KXtTP+24wwcBfIJdT2qJIfEr2hQhB/Ugo63Cn8gMWODAh7PopqrkXxYGnEAk?=
 =?us-ascii?Q?/ibXAaoVFOwXc+luPpPxyBQrMMnebAhah78AAt6JrYJWryce7HnoN7WRB3+B?=
 =?us-ascii?Q?7r+BDyl0ENvmg5NhpPEuwd9P7KpZOq5YVZLWujFadCDRpwDLlRYVZ4gikei8?=
 =?us-ascii?Q?yj2NvEfwoqgWgskHBlTRCl30cA60B38bSD9xKKDNPxy9Kzy00GX1rnm2s4YT?=
 =?us-ascii?Q?e4gFrnRY8WKV4isRM7hyfr1v/SZGPeI+MhjxrNkxBY8NRpPn8oZswK83pF+3?=
 =?us-ascii?Q?Ik51Ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:10.2915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea35b0c-dabc-458b-2363-08de58995477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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

