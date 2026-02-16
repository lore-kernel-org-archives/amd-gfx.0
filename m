Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D318DE8383C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A3410E3F0;
	Mon, 16 Feb 2026 21:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DuRYiKER";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACFA10E0E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNyuCQby490H565F4mYaw708wlRQ6n50eHSgUEWmcKtE67On9JuQ8rooSnUDqWJM32c33XVwoAYrUKdz4Mkp14jILNaHwSTBOv1TYlR2byyXNnq9HbRq7xDqZbkCmTYNn33oAZbcsoU5PfzVGzwd32W8F9NVf0DbQKzzazEk1thPhtjl0EEnjHD1mJvFyWQsETNqs7Gb41oofPKu6w0bSCG8IARuPf3bpnWQe5noUMxyCIP22ErgODLQyg+z9NFmvMBBSEXPDRA+PoBt7Xurz5QjlS3VSKwdsMWnjkJzLn7gZ7bY19olnbUPwnq8IcTO/pWPhH9JYOKgWc2ZpR082Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViYSrixmCEYh2dd1vktMhd1E/dKoNhhX6CAJestqpsk=;
 b=flC9MhyzNjyrtoOeiqig8Cy844wmVTSXLin/wNWWWwojo0a8cU+7sKO5UQq68W2uoggl/Dwvpp/fwMGfCCUhM0LZS4U7T+5J4TRTUEcVGNUcxMCDdI5lua2IdtW9kRuOKr4geecQK6+hpRBcchcEMMgAu/yRqkxvjpeMgaB4jFYym4SOQLmDI2hNcM6n9lYRRmMV9Zfu5nwFP3rmW/WrOn+XRHBkbOGXW2K1L4HBJ1jhFb+3mxlrDwpBjlSCrb4uDQwL9iwraAf2450+cCf2haa671nySQzSX5MiYOlwh5qjqgzkznUBdnqOGiFFQVz8llDpL/t9vf6CvuqTnQlhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViYSrixmCEYh2dd1vktMhd1E/dKoNhhX6CAJestqpsk=;
 b=DuRYiKEROVkfbCcRO5MgAUtWYFBdrsyNsi6ffATHHiMqr53OOe9wM2YzOFcqTT2TTIkR8SRugWrAtkQNMn7r24iTbyvzDT15bvbGJ8GdHI0ctrPGHMAN/GGqNhryR/p3gAqoM2nMgYEo+dAAW4STt4RXNe7QqAiuVL+NCbdkHNE=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:13:52 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::ca) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 21:13:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Mon, 16 Feb 2026 16:13:34 -0500
Message-ID: <20260216211340.16364-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216211340.16364-1-alexander.deucher@amd.com>
References: <20260216211340.16364-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc7b35e-b43a-49f7-00b2-08de6da048cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tef96LQtye/lfuC3bC9zkvkikVhI7Ul9uW+mrofk3TzWv8hnuAJhVHH0J6Xd?=
 =?us-ascii?Q?7dSALF1SC/jZonHSaV571lTWvxIBciaMIhznNVnbCPG+69rQmB+jEFTcCDeZ?=
 =?us-ascii?Q?382vP5gFQmkGJLOI0D2Es8hY5tFVDro/5RkUz6NdSMPyb/6/7eRZrEVgGxfx?=
 =?us-ascii?Q?5sCyAGm1W5hqmUz1tK2LHRJ6W+zHrtmhlqlESkzHYzVVKBwwX6D8fuguGcBW?=
 =?us-ascii?Q?1zAXa2RRxHs5nsMgosqDHSPAqkFQp+Ac8578I8npTaDBEZcuocUQWFDxCkMJ?=
 =?us-ascii?Q?yNe90eoyERy07Y4RsV6enjMB+DgRlPYD1GfL7zDfCtCkb/spGALx6F5gTvqn?=
 =?us-ascii?Q?oTUdXPbqJV97IDPSjeAdQYOx9Nm5pKlfJN46FjKlqNs7YZIjTRT9S2/K/SOP?=
 =?us-ascii?Q?FxqjnbDPTZjS+xbHeU0TFCo3vW8d3odRkDa+bTosCrBv//xcgXUJLTRjkCHR?=
 =?us-ascii?Q?bUboczHw+9odn/StWTpvyhIlnG6QqJyqQmQDCjolCAebVC2YioruEaY9qmd0?=
 =?us-ascii?Q?UhM+qHEgpPZCYd9S6E3DdCw2mP99xTWNA2PAOxJXMzpKzpOHaWbjNX1me9/R?=
 =?us-ascii?Q?c6jjEPOqCKX9Auy+YQNE2Zgol2RF3Z8F9b1hFf7hUr9emX3ppSI62qa/Tekr?=
 =?us-ascii?Q?lF0hPtHU3DanaA9Z/W9miz2npBbMgfOy/p55QlAYHrdM+VXRzY1X2NaU4y5L?=
 =?us-ascii?Q?jDiA2R0lMjzsdOQjTkUBG7JI4xhbrD2ceQQgGINOeRj/yfk4PEuXbuJEf+Pi?=
 =?us-ascii?Q?Hpejbqbc4o7YBqMdO9Q9s/o0TWCXxHfQZYvft98GYxhu88Dck8cMms8MAtcm?=
 =?us-ascii?Q?ckixKNBDN4tdA4Wt/C21o1vABpAU89rvZlh0N5yqH7Ndl5SFW/veiKhx1+ql?=
 =?us-ascii?Q?Gyyd7WTByLHGsORrLCi1PTfj4lVChy3U/m1+3vVVL+V2px5M/f7mj2Zy0847?=
 =?us-ascii?Q?NPxklmch/TUaSnHcvp9MRYmWLkf+ofRZzNFKRVLpEO56ADHGH3qBYYekpgJb?=
 =?us-ascii?Q?PIwMKubZMLc9OhiNk8KYjlQTNZcl4ZNRAjxttBdDeURZozy6zzU1STipsEqX?=
 =?us-ascii?Q?HLSFsBLbXvVTSLqWVzH3fOsZAIKNuFGbkXCAY9BMnfHIOnt3pTkQTzXvQhL7?=
 =?us-ascii?Q?wGvWhUhIGQt5aln2SFXR0UdJjoxvsLZyMxS64GAaBAV0YMNIb4qM2O8iPJ/w?=
 =?us-ascii?Q?Cmxfnkfrc9UNj/bEBUU2OF7iHTgmxfiy0fCQ5fgBSkThwIj3MHdNgTKx/+je?=
 =?us-ascii?Q?Vaz5vudRJvBm4I49tIJ1jIgthV35Jzu2UmB7WHAEi6lA3BjmkmwiHqOa48O4?=
 =?us-ascii?Q?bY9NTh1cuHisWsjcHw/hRMhaCGomiBFfDFq9xJsjJPaSPZVUlnCHdxgVnOwE?=
 =?us-ascii?Q?JO8cQTUPhPh7/28T36y7U4Bl5cV18IjOJBbnff6hcqfBLDObjLuktzbw769U?=
 =?us-ascii?Q?yjuKPosWhmYniKP+GbixFOlFOrP4FsfwDAEgZ1TQOODe1KdV3LAUFgFsvP5J?=
 =?us-ascii?Q?DSyZZ9IgDQILXd58yhaNjHQzoDvxDV/GO1QlViZIMjivQjKb7YWHEX2wHIUM?=
 =?us-ascii?Q?rQX3eUKZosF8k1Cidv5M+MX0eNxxTML6GhllLdrCnnwKY7DFSEpMPqQubaUh?=
 =?us-ascii?Q?vvjhrlTCV//agKig50Bj3h488lNQhBQw6PSUJ4pCCNEBAcERf72HYDrkv6Ea?=
 =?us-ascii?Q?2C94iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QdNvs4URGY9BZWDNiT66WHqfSylR7rvwz1Ld9V+lD7OxmZASagANtU5R34m0yG2DxWtVPtgbXhb6IvIDYx3ctgQX7IVKjX8jaduxao8yiaF9zUAmIyedY3qTwAqF3VL1BlKr2LWIpgZmCLHXoDvvDQfUjtliYLwshi6HCGXC5ohlNHI4ULUwDxaW9Vscr3qL8UKM0Yvs4F1BTeUOEHDjD2/mPL4Yhe7Lf1DgALcRvqZLBEJk5EiDIJ+QZ+2ylQMEOCmzQQbrcMitbJjHUfOs4w3vDyC093oSSQaU1Ajfoka7E7XgYi6zs6Zu5jH2KsY6Yd+ecYXML65G8/aZm4r6FQQrOlgfXEOEbhOpLAX9noxgKCk7cmv/wGjpSmWiK/DPOoeq5qymZ//7VfMGGg8cfKsoW9JiXCIz5GHjfQy8uc3aVPAR0xH+beggNBEzIPLq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:51.5548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc7b35e-b43a-49f7-00b2-08de6da048cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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
index f3b5bcdbf2ae6..6b494e4e8c0e9 100644
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

