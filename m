Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B71D7788E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3F110EB73;
	Fri, 23 Jan 2026 17:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvnaMVsY";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F8A10EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePLXwb5gL/xd6whrd3zUtWuVrLT9Q2Ac+JGRrmI765eD56+4bCnvXuFcCPNJaW1ALxKjpqID4p4+yokhegetSTZRaiXPGIsj58wXddyMwZCrqauPTjMCelozaTvNRZtb88zK8nze5DOk+hQlNZBV+lZrY96oBCkQkx/DkCeiioZwIOouWoqI3ILvuNW321Dm+ip/X6F+cafZ/35AWefsA9OUg2Yjnafh67+ogii1e1/sgoalxLMd/+cKok13TAuHnq3qjptocWNE8E2dHtNVf3iQKoHNXyTXm29nmIi/csz9grWW/Bfo5gIoAlTUjjVP3bnxMJGCv57hdlYHL9jw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CIhiTw1/sbAmEuYdT42flDeiC/f9gotI+Gt1jU3I2k=;
 b=Qx6CG2wNPF32Ct8Oa5YZKVYm88udvJhqoYz8tBNJYfBpi5B40xndZlEH8lMZUGbNyPjxpYDt0SK06dJPglyuy6QKtEEAjXPpkM4qWJihI1b5uO/xuBmUrUcto0geKtAUYI8uKr8xdJ1HP4A1dNcywaR+b5nvYcdlqqVYt//GYXgXeziGeTUThKoVmCXgW98YFad7/n1/UtEwgEEdz9vMGh2qXFXoVdv0LTbel1jZSK1Ss38S5a7nqPO1e6j3dkScef6yI7W1s1vBchllxq7H23Wb8omvDMXPJbNrNgX1xa0aV3c0Bi3SJoqHhGttobpAWPQA4cFTAikGTAfARphAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CIhiTw1/sbAmEuYdT42flDeiC/f9gotI+Gt1jU3I2k=;
 b=uvnaMVsYqXblWh/fZTvmJJWaEXavo82pH8/YDlv15+3EBcHLhgOdcGX4Db0Uu2mpWRjSnJkPUAAGV+4fActkwCpFiA3VyqSFsHaBOjFi7VBnYDZdF0iLmDl8FMj/9qxX8rLoDrh9u30Yr73S7amMqFq2NnXQtTFHgBsrbkvsouo=
Received: from CH2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:610:54::35)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:49 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::2f) by CH2PR11CA0025.outlook.office365.com
 (2603:10b6:610:54::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Jan
 2026 11:19:45 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 02/11] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Fri, 23 Jan 2026 12:19:28 -0500
Message-ID: <20260123171938.16814-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc6153b-a27a-434e-7297-08de5aa39d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SFGGDaJbdBeagesBWULJhmI6Clzf6p8aYtqODI9pp7HH7zjOUg9wuqicSvFK?=
 =?us-ascii?Q?cxG9UschctHFPPIE2E3iv8S2o0rtzMtnWEwsg3V1WaLInMF2Af5M2DoADyum?=
 =?us-ascii?Q?W+zyqOG3A0fa075XYTn0kmQrmbFaDD5nQaCteDJ1Uhz5RM+SygQP/bRUn+HO?=
 =?us-ascii?Q?E5P8oqZWWT1gEVwWs/SxdcmlLYUTPr/lbFbBXVIrbDsbCw3CBCUbE1SMLIz9?=
 =?us-ascii?Q?gRQqOHpLd1h6OkaDgfKuGLEgCQPuzYNx7yzX8OhLhmDiQqjzDpfNbCCNnvdc?=
 =?us-ascii?Q?VdOK5XFcjgSfaAy2wkT7aTgUjP8p1bmFDNdGSW/jD5jjC6+oPML1qB67zu1u?=
 =?us-ascii?Q?5wINLSobRYvuS2S1Ss/+yIhZEKIpXe89paroDJvrQtN3/c2zWbkLSFkAIluX?=
 =?us-ascii?Q?FwK2G7tEvr47FxyF6PDgbvfupEpSgFOIgNmlIggv13IxHPPWIKIgWGzCGiTG?=
 =?us-ascii?Q?DdI3q2j8B0g2DxQfhPi0SZAQyKMiQNE4PNep9Idcy58t0NEDpx+YSWygbwAV?=
 =?us-ascii?Q?eQAVmTlR36aLq1j8Pe7P6I+s8q+B88co+WgHsTTIKuJzmh6RsUsMgDmeiP4m?=
 =?us-ascii?Q?amYcFUD57wM4KSxIeJ0w33xHANe0vcTWdhHjzjOyfEItZGUmPQAKfk03PPjQ?=
 =?us-ascii?Q?eOUSTiALoxO3+WGQBJY1QCm2eI0gSNEEaWgQVSHVJDf/F/bSSF2r75oRjyt5?=
 =?us-ascii?Q?yCCKCDdJvyAyDo/aIOmyJ9lV5kKe4Vr7RDZbjRJB0H8QiXGLsKAFY0AmiCg+?=
 =?us-ascii?Q?NKBjv0eTArKuRqWT4Pnu1SEjLMkMV8zPHmW5cL5qWdJBWVU9yj9cXjbHNtjZ?=
 =?us-ascii?Q?eW4u7L3IW9O956RUxUDQVl7kUOg7QKf3lCVovOV5tSGbbHZM1oAOhZycpTZJ?=
 =?us-ascii?Q?31chechdBAU/aGHQ+jDn3IwqEf/O2//B6kbONTCDoDxp9sMCYh5RVJQlXMak?=
 =?us-ascii?Q?TRiYCxfOYfky8Oqpazter3D5twz/iz4bN8GJwDFhOG/BdFe1lla+NJ3knLN1?=
 =?us-ascii?Q?ZE+vh2iw/o/ZR3m3bKsWDRVZujbn8C7Wqbpd7E8+6xYBoU3UBJwVblmglSq7?=
 =?us-ascii?Q?um0YbMvu3gJmWKmCw8inUjbAC1yEbItX40lipoBOgdysFkbsairYpy9RRWyU?=
 =?us-ascii?Q?bWLa2v+3TJ7kCO7jHTuCc5YBwWYfRZwOag+1eCxO0SL8AMDR0/Nw4Q1gL4Vs?=
 =?us-ascii?Q?7OfIOazX/2iYbTMCg3OOZjNP1obNjK21wuoZkFLUl+lQm5FXyK3dCeQE6i+O?=
 =?us-ascii?Q?IlE/Q93vZy3dT0B8Bd1TvbjY6Xtz3yNf1Y8CNrWJsc3lGSSFvlJGHoTzrtxO?=
 =?us-ascii?Q?Pcm/zUscFTuaba2osMlc1OKiXBc/nZMtSCqkx6D+etUFg1ISiHe535YYHP/k?=
 =?us-ascii?Q?KY7KwVPHdKd9B7TamacvFhyuOVhcyB0QLEGyQPw518jnHOfzWfI6b70r0zNX?=
 =?us-ascii?Q?jsPDhR2I+0vN/BEAcvGjRTSpvTlVn+M4j9YTL+0bEWYPAFjZvohL+c+olomN?=
 =?us-ascii?Q?qZzDGpCVtnQceXJQr37ZeFQytZ75CGc7OG5572B2dr7MjY3xfsclVtd9rR90?=
 =?us-ascii?Q?y8FLl75nBAIW59stE5GVvwZGpHlQq93YCh8ChG6aT1TBVLvbjoIxqOcuaxfV?=
 =?us-ascii?Q?MENz0xeiERbk0Xef8F14I4bqQ41O8qPKd+AFl8MxNa7FP2yNardOsS3dsycU?=
 =?us-ascii?Q?EKMhig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:49.4174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc6153b-a27a-434e-7297-08de5aa39d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

