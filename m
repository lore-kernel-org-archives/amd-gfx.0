Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE608E6BF30
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABED10EA2B;
	Fri, 30 Jan 2026 17:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4wrxOdG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52DF10EA2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m230hsG8GAzSwLT4tEnwYbLWRRhh/1hfgUhRUMGYLcWB7JR8VpMOXxXIs69LkLu9m7XAQJfaUQd+G8c1E3YgFsMM9+wYKYLpQykuZqsXoK7VUKdhB47rugC7tgRKRfAUmVtKMPgf4BIymNxy27DiPcdtLrQXrXhRHSkOsz01l83KreejFdZB9aWyxl/sKljBotcJ1b54m/xJIsqNeY/U8M0lF/DVK3IO7bKTZGMMJ3+pxncjH7k6evyU5nZa3IZMqtWbhlmxURNL6ruF74ZP5LWzuxkjKGBy1zRjBYQl50bk03pngbAzlZxgOM79CC+0vMLFhhFqHMDRWp9v8UZvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYM6gxfIERQzTKNPtxCJPwn0Vpav+53F3WV38QehG60=;
 b=eIps+fL2IhWH/+dnmf/a/B8+o+VE9zl6xJ2UWPDRc/cIKDFa6/y3ihk1Lm3zG0+00O36Vs/x/NaYZK+1EqcAxHjubdG5c2mjTf3bq0bzTEPO/ftkiOAyq7xFYlyAqRn8XeNUt4uu99KusLjqG4F7hxttUOlJi7I2R91AQ1957BBagnDFVNLnUlaQ7Q8Vvycxz6iQ0+zau9qNW+Fk1nxqkD2BxVjp7yMnSI8ZD6KQjODmth3XkcGlcNNzRPi0SRGelrTT7VumKOx+adUE5XbcTbpu9oFAiIK5J50tNfcwMbZqTsmC8AuOcVv32xj8+lNK2yXWx5lUoAfo9CQeltwQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYM6gxfIERQzTKNPtxCJPwn0Vpav+53F3WV38QehG60=;
 b=N4wrxOdGAdx96wp71Zl3yIkv68hHewJuXFeyWCGsavKsbWMpdZrWoYroAyPAeW6z9WdI8YpH2FcoMHc1OE9xK6jmiF3trrpUlhh7oO85rYfYKgrLDnzVNW+jzkSi1PYcH5RnY28WGwiltK/S2FbfhX4zYYmx2vaLDCZkde9e1sY=
Received: from SJ0PR05CA0123.namprd05.prod.outlook.com (2603:10b6:a03:33d::8)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 17:30:59 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::36) by SJ0PR05CA0123.outlook.office365.com
 (2603:10b6:a03:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Fri,
 30 Jan 2026 17:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:30:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:30:56 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:30:56 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 02/12] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Fri, 30 Jan 2026 12:30:32 -0500
Message-ID: <20260130173042.15008-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 976f37e8-e922-437a-d9a6-08de6025555a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sm0O6C01Th6docXV+WSifPexXqCTrpIq1I6XiLIOYjSAH0kjQ+TFul4Bf9RY?=
 =?us-ascii?Q?U5+3/I2+yG1MwbpIOSwYMwf1sfwrwVhQfnqOjORMciBtIo7WrjlISKhurcgf?=
 =?us-ascii?Q?692iTthjJQIPovPofDpBNAIr1ipObHyeJRzYi3Xc+hGIP2qi+P4dPq8Qvqls?=
 =?us-ascii?Q?mUUiuMNKDC8t0Qr4x0Go0MhFxvUff15m82PapU34H4jjzwQo4cI06w1Lwgyi?=
 =?us-ascii?Q?guEWr0OVKKNzj4GcwVw3SEjMpR5PqhOTq2obVvCeldeLjYYuHRlOQXiL4+Hk?=
 =?us-ascii?Q?X+WiB6aJ7AwKZ1ThOtI7IYD47sHQgdCCUDqbnf34EUfOKChx8Q0WW15mPpPI?=
 =?us-ascii?Q?cqt3KbUZkXS9zl7wb5HtOPpBIwlqGc0rGTq5kWTu2TwiCZcIvubMSr6TRzce?=
 =?us-ascii?Q?d8k16G4uklf7fSmFs7XRhPYC3Pbycx/t6gclC2wKBxNOnnXJag+ed5XLBUoN?=
 =?us-ascii?Q?0pZ3HxZ0WI1uSUcV2Do4kK/VEo/i9oQ9guC6SIy/ezelSnUxMRxrphjiOBPZ?=
 =?us-ascii?Q?y4jc4hNxmwAj+URySSYw1aRaQTMiAhtE/VKOES3gBU8bhWYzCegAthJVihAr?=
 =?us-ascii?Q?24FYlQ1GYlL5En/XCs6OFl5YN4a73Wj/7rBUHR+6EEsFiKFkYcczZw34L22C?=
 =?us-ascii?Q?05xtXqxSrOAWUSpB5rwbWJ/yDs5g5abZEcYpFYO1BPlP9g9df86wqiQfPSSV?=
 =?us-ascii?Q?h1NVcAbpcxIhdpBtELweyEXjXmgkM1uR722vHPf3N9SnERuwyMr/70eOj+Qg?=
 =?us-ascii?Q?UpJSqBXtV/uHmqc/MMg0rXiuCkQm2V9P5O6cErbr09TE69gFmaRpGYf22Di6?=
 =?us-ascii?Q?KS/Qtw2dDauxSgV8hVHarspE3Xs/5J4f13B+4Gd9FnJXZS8tKLDNq4rSEQrF?=
 =?us-ascii?Q?5PqUHI70gTNMtiHywpG2HjLNcnhJu44jIGGLivin31gv/xbrnJvrPtkeWXSa?=
 =?us-ascii?Q?LMXb6GIHgkECS51U3T1/egz49R72om71RHbnW3s36XrC2za22H7LJS+BzD80?=
 =?us-ascii?Q?1+btTdSnti1Yzi3Rpa/qQumFLcJkQDIjPvJmk+o226bWkVndbSnL88mbymZj?=
 =?us-ascii?Q?B4bGjkxz2kMHrDgS0NLlGiZ+YtkQsC50ybbctDMJyFPbNp+d+/oBwYTprnhg?=
 =?us-ascii?Q?hBr6UimvZI/9sZqv7dOQY+Ede3BZnwyFWX6zEjCIC7JPXlaTgI2F8LiRIHfY?=
 =?us-ascii?Q?/jv8lfCOPW3g5tsLZphod5/w60KEO30TPKgnAW0s+L1zZBVISUz5Ez/Wm1bR?=
 =?us-ascii?Q?FDX48TL5a5cjPnwqEcQRpdynntdKpfd6whOi7PDjh7LnR9OS61uh3iugkfc/?=
 =?us-ascii?Q?qodVc+gA7hh0L/ni96ccR0ZjmYDJAPTYM1xg5RBr6keijyhTixYrSJT+Ox4o?=
 =?us-ascii?Q?roYuHVsSPQFkdpM7hpEh/zAVSSB5Pu5fRUXIk6fQiSUvWnCERS8+A/7n6CkT?=
 =?us-ascii?Q?ktQUYPv3o4ENfIPIpsCZH7A/st9DWWfzXL4Eh5rkiy/BDrWMTG3U1P1G4z5y?=
 =?us-ascii?Q?xx00znfKvW3+hoCQmXrC8aE+59vK/ilw2hIERA1usE739HACWRFmVh5KyzXh?=
 =?us-ascii?Q?jhqkQiQWF8Y1L8oTNWcSFNzIfAo2v9f7kaHdNL7vbsn++LC16YttlEAkDzt5?=
 =?us-ascii?Q?6YsfmBMnss0hcKfuSWMTm0RAX+G76L/JEo6zOqWqa+AhSUV14IvWuoXa07zA?=
 =?us-ascii?Q?GuW4ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wET/Nd119RlENWr18m/2eDtY9KxqfOv15b3e7M5mmlZPSTNHA6UzZiHo7lw2UGSrmLcd3IACZmsctacN9PfgBWbDTatVcQ63C13A++TKXG7SDwS6UgMoA+jcCCAkK5/M1056jf41bYN8z/NICGg9uBfReuLqauAz4RX0ZuNIcWrdUV5a0rR7+MacB/AW8tdbT/Fd9tMQKinQnje6o2K11rWBYSrSDhvvqOQ8w4MTMwOypXT/qANxh6SImq7XTiBtGt2nWGw8vIA5UHyzgh+dQmaeKYOXj3P5sQ2gpBBDsT/V4T7l2LA0N918eHE10U9Yytz17Amvttnk2ntIhPfnrdzGPnjgf7bXOoZuMeI81MGL2oNWvW24Es1O2WtXL8Q21CTf/tPdBYmXG+5HJ2zp4bHpmA0TIVfkHQsNi/w/RpnhzuLvqBs6xs9lFuTMxqex
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:30:59.3928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976f37e8-e922-437a-d9a6-08de6025555a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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
index 2c82d9e8c0be1..9870dbefe414b 100644
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

