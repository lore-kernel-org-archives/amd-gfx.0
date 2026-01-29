Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F122D73E88
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A602C10E07A;
	Thu, 29 Jan 2026 20:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IDq+8m+Y";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6244410E07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNyoaJGC35cXrPvD7V6SKuFdKO3pXB1gzRxq2wwObzzf3j4sHCBwtuACFAOvtlhfNVpplKdlwpiH62fiLRRs+0nplav94x3PUszcrltnpbQV0xImI821HtCyPYYo5dlViCpXM3iSPoPHQOffd6NYGtTdrorDwVRdZduZCMRZb6EbHRmHE8+yi5eAslHJdUVzIsoz4R2dJpbZGVdKNYIHyAt8APbITQFXh0slNOWG5aZFA+EM+h+yeLfTloLUz4m0/MR3IvwFjIMwRgsbdQUoJ0I8YZjZqx6Iozi9B0H+HJqxTFdlFpG9hUBjUBhBgN0Kgy6oXSgSGhLA571D3+wCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgtmcnBuDMFhMQ+mTUhFLUZurNj6yZTrfl4QIwY+Yu8=;
 b=VPatTZuUNBss8yHXYDUH+YPumBglaGRdexL8EY/zta2xfspSe3rIlJBpJhANaoV0zSIYOj0/izdvW9a8N1GA3pyp2aJzECQpsHC+mX4XGUsfr4n89ZoV9smOOpGG9rZcFm99ByIu2YunsSs4ISRS87JYKKVzt74SpkrXPdRjgdNNVLQcaTvd243BEa+ChafTiLHmqDsKfsVGalwsGwkCgzw8zzOVsZcsyUbJiF78ZO0sCYKKEE9eoKtUx5J8XWuL4Wi3G5s52QfLb5VPCXuRHk7iTpYdtWg3UdUd8G5d/lX+EjdgnnSI2gDY9/oPlLXpUGFO1WCEqztTYw+WkK2O+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgtmcnBuDMFhMQ+mTUhFLUZurNj6yZTrfl4QIwY+Yu8=;
 b=IDq+8m+YKCIryY0IlaREnAUXjy3Yh0Czu1nN2jvAQY++Cch01D12GmwcELDrvTFmXwVBlt4jruWO/9UkH/gXFZEeiJLPfo3ha9KOMV0MzORihRN5hYhPkHMs0wsjnGilf+5H1rcOZIx8JmeDeqc2qRH69+fbQ3Frs8dJm6c8lME=
Received: from CH3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::17)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 20:37:51 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:1e8::4) by CH3P220CA0003.outlook.office365.com
 (2603:10b6:610:1e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 20:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:38 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 02/12] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Thu, 29 Jan 2026 15:37:21 -0500
Message-ID: <20260129203731.21506-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: f83d4108-9421-4a43-cfbe-08de5f7645e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hl60XMU/VD32aMf1T4ST190wJ3X4N2pfI8mlZZSDp5SldIBrqZqQbIKMne0d?=
 =?us-ascii?Q?ZUiyTwVXoQnrTcRILtMovbzkeESGyM6mffMqQshU/W+y1RovfWvOPkWSvHbC?=
 =?us-ascii?Q?qOKukJWp8MS/hvjBJxAPVdWei+oCGydyS7gw5vZI6341K2FRP+vmv9vEln7s?=
 =?us-ascii?Q?Tbb8N6NHGWMgOgEjGnJHP7mnHkVNagSwHHTYftK9dAFYY9O5vmygBLeN7s7r?=
 =?us-ascii?Q?EFGXKb76lfXJbIL3ytLVqGMOzjblKfwl8xbdZl/OGYNoM+PRQ+ME0LjuflUG?=
 =?us-ascii?Q?rYGiT8OvBg0CbcvXa7VBBc1NnjOMD9hpYX8cGORq8/DtEuDIvxT1QaUUcxa/?=
 =?us-ascii?Q?S0nJYHMSkMm+36/JYWZ2YdneMI93RV9o6m+FDuU0CYk1Ol1sfgd7okYohX/O?=
 =?us-ascii?Q?C5t+p+96wfPryGJT88L5TlSRfjlakgRpl85xbmfuc3EBeoahT/LDAGiaTmUb?=
 =?us-ascii?Q?H52Beo0MRspcyKLPUBz7VkfpHGAx6lO7rui260AVelnN2lZOugUx5Ua9A6bv?=
 =?us-ascii?Q?Gymvrrs23N8cQAfqapWMapB1wVIvxePM95tSAzkrq5y6ZpuztH5zsXU+BNtV?=
 =?us-ascii?Q?y5vnmd7sfg+TD1Z1nt0DNxR0PZkhi7NKK97UPoNCJ/l9Shf0xwB2HA3t29bK?=
 =?us-ascii?Q?aFlVdGRTtuecw4//tpfhYkcLZRNrbmhvQwVer0fQsCz7hxnIYNoUMi4A2t1m?=
 =?us-ascii?Q?k8+42CY+Ac0NXRWxlGGRB2knVfHNmJUQISkiYXjteakT7FfTNir9zofIq/41?=
 =?us-ascii?Q?wZ2zeQ4yv1awdsnAMvxmctB99INPomY81AAPN3gamVgaUbTdyfEQb1Lr0BR/?=
 =?us-ascii?Q?EnC44Omvprza1uYHTn34JBHxhP5T9gQ9aXc4SGuIhiQ4K9J77hgYW8hN8Tux?=
 =?us-ascii?Q?HtLije9BqN4esM/TKx//wfHxzLhMUeu936z9zTLQpmDd7VFMFN50kPgCJ14T?=
 =?us-ascii?Q?qEstntT/O8m7DNFvxkijZ4Ysl85ODB7AS+Akgnkx7dfB5pViOUQn3d8Q6HVH?=
 =?us-ascii?Q?bc1ugEWdBBxudNjkgH5Ee52OTER2+q2g0Ic3cJkWew+fK9aOyDavph5pSDHu?=
 =?us-ascii?Q?cLC7Ir0raU4B/6VaygDyozvmaaevK+nJqdc+2sf5scG2ibsSZAZgp4+vbZ5R?=
 =?us-ascii?Q?SF8K5G9zoG7Qymv3HT0WrE+ctfAJecbJHEamN9F0sW+pzRrFQxZY8Jaeg7VD?=
 =?us-ascii?Q?Y5txY/1kbUjJq5rIqiKA+aqJNZ69IDfTWfPXSSDLwCWTlTaUYJICBjQHbbfy?=
 =?us-ascii?Q?EmFEBNf/xZvXESoYtmeNd6ZRudfD2kSN+0/qedU18CIcTe4AbU4pbB34We5U?=
 =?us-ascii?Q?ivT0M4dlzwNTBlvI7tpQMfht8WMkxy0ro8B1jlGPPKE4JR8FMwEkBJ81GnR7?=
 =?us-ascii?Q?YklnD17qI+N/jispiIQANvLnInTBWFb0LiszgxhWTbGGaN8yiXUqVJrV2r2H?=
 =?us-ascii?Q?UaAuSfNeoLsRn3I2d6ts2H/pSGlFjXY0a++YzUoIuUxr7Xe4NOYunJehRfW/?=
 =?us-ascii?Q?6eF5neuRFxHQL6DurYPkeXmlsfsx9za9WsVy8cCUjjr2jfnG1JAXem3FiBdz?=
 =?us-ascii?Q?4i4jn0BeylTVZAXjqqsmMUeFEI7etDp9nZy9zs7xj4Ha/cZtWUR1snEjlr0L?=
 =?us-ascii?Q?Ca76Q7ZkxyN3j1hq4WW/Dpzcjqod4xOGWr+GuENFMYsoLJm7dXenx8r7KvFj?=
 =?us-ascii?Q?WOoB1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ee6p0jTjeDzMerIS5eyVMCLXPrmRwXK3wZ0iJrKIe8xNoCK3AUeT6Iawlk0Msbffhg6N/m04y00cHJfaJoBPMXKHtUO7P7mrJmo9BxL5ilZjLFKjEgUkAoW1c6plKWoV27s7dUMOGs++T7UkkybmcOPhGNpwqbNQHkvaUPWwUAdTR/hxjkbIKfJEOnUim9SoTQrM4/3LhtrvRt03gh59saoD7e2vB84zWLLNFBOxyliVy+eCIy/s60ckG5bMeviBo9HIq1Q01miCM5nEV7fgJkLtOsVWVuThnFUqiL3ma9vxx68khKs7n0+Vm1iIfh6MBrmEJPLwiDYh+Bkvx3E/mq5aaubbrWc5geUURd1/k/FXPSjDfhoCE5cYW9zOoprLluJyKVN6p289tNLe+NEBUij65xx4RAeZ3MjddENUo4lNXf6cW+VODkfvpj5z6Ah8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:51.6130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83d4108-9421-4a43-cfbe-08de5f7645e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721
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
index 44f230d67da24..23f73958663ad 100644
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
index 9b10470321be3..acf70f42c6e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -189,7 +189,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job,
-		     u64 drm_client_id)
+		     u64 drm_client_id, bool need_atomic)
 {
 	struct amdgpu_fence *af;
 	int r;
@@ -197,18 +197,21 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -247,7 +250,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
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

