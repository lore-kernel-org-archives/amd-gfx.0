Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2697ECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862A110E693;
	Mon,  9 Sep 2024 20:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1enWyT8q";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E4610E699
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylaeFwUi6s+sKQgprF27kn8fF9Ir5or4aYtHaw9sDwQpA9maMx80sH+5SCB2XyVC2vDEkyRhXFuGYfJ5gjFED4oMJyk21R9ghcDtvcKvPNxCEF9ICkbpd2dTO7P2DyQwI1CKJW0Lwg6fHp2dgrNVvDAOvvbpN8asIuLShHXLD9q/5JVGrFF7fEyo7AgWGW5Kye+kSzj9Ar6BzIws96Ou4AGTLvSHWPXJUpcr/TDAruTmvPxfVccMGX1ysm2on8TbmwQgxjn4LI4JcaSNqSMFe2RO0mScmjtoJeTjaT9QX9IuGwMAkgjqZ4AXNZriUzqfCbY0/arHBe6ahiwrwSPkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL96f72zknJVQeqnhc7bJuXkC9MUDzmmN8JUcjGjZAM=;
 b=J9/fR8kj8vLA2qtjvAgqyQmhbSx6Qb17A76wO643TRxxjTJ1agyhewMmIwqPQj93rK8pgz/hn8CCN/BbX8Qdc7Qsj694WlUp1/cTnwO4MNUcIZAyFni9dZ9BxCaW8P9ZlTQyjB0Qa+8+BHD/28nNInnqsm6nH2SQwABuxldjX2B4L/V/VYogtdW4hgHcgGuclt2hl91UfSzSsiDhGF4n4B1LmLiSGLvws4qEXNWdr12HK8Hl99WcMFveIgKQWVRn1ZjxgqXH6RtPlM7tgPBcKUMMy9auIZdxdgfOKH1iayWdKErvplMpKuGreXDBRPnZC6tIcjcrbHycS2xDXeW2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL96f72zknJVQeqnhc7bJuXkC9MUDzmmN8JUcjGjZAM=;
 b=1enWyT8q/POI2qyGA7MPOiTA612JKKWlZhnKeMSKZ+i//ctdES5aYAr3Zp/4XeDQPXDLaiAx38r9NYxi4movcxGAiL8GDdEHbcP4Zcaxfr3oCkoxLpIoJXuDP38vQFTQRYukjEqhHlRQnSwX9Lxm7mrOT6cKKqoreCRdUEI7+oc=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 20:07:25 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::59) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:24 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:21 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 24/28] drm/amdgpu: resume gfx userqueues
Date: Mon, 9 Sep 2024 22:06:10 +0200
Message-ID: <20240909200614.481-20-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: d919c78a-67d6-4848-d974-08dcd10b05bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d5VSqYcD94Ur4MlanCCjFOTsJRQGj78irKRx6CHDWIqg5DGjT0Z3qODDmMcn?=
 =?us-ascii?Q?QEnuVUul8RGGrG4mbPAVfcrDA924FGgg0VOzFaKGoILgWmyKx5yULFGsMH5e?=
 =?us-ascii?Q?Kuzy4p+hzSH67cerrs2wVV/kkMuAC4/rxJXHyLFKuMGOjvxADEiifc+rjVLP?=
 =?us-ascii?Q?Pp8ZMmHOY2q5MaIsdb2v7ohFXr9gvRhAim1cLBhxX04xTMFrIsvo630d4TYX?=
 =?us-ascii?Q?dbpoqckEpeC5yEOeeG0XY2P+cMlltb+IPR6yFj8nrpkuQZPb2Z97rxqLOM/F?=
 =?us-ascii?Q?dyV95ATmD5IL2fJTIjFOxQFzubpJyrpUiD3ehTN9SKKkcYgiMM8YhydIG4bq?=
 =?us-ascii?Q?4utZ/B5BJoF+JTuUwph0nu/VsUlqTVRxdUFqLweGxbtp8dGAQQtXddtLlgeH?=
 =?us-ascii?Q?Ylk9ZOVdT1qSP25rwMA0P8V0mton7+SPIOXoHqgNLKz2jH3qJ5pesdwv4dv7?=
 =?us-ascii?Q?qTzEaFUdMCMF7Nz8nw9xjjVi/jOn7VfD64SvCu7kXganTvHXI4GDRIoY/lI3?=
 =?us-ascii?Q?BHx5PnHVMbqeiT3mXcBoXkCAUGzna6vnSGj8E545F+CmhcSQWUN6yBD5Jrz9?=
 =?us-ascii?Q?aH9HDtSj3/gjUO3xjyWXnEZGFyFi9bdqWqhuTbo1cEeuV8Hw1Ziiynos9Lhi?=
 =?us-ascii?Q?kstO8Wj4wvDrgZZmXtRY/25zxChaAtTgSESfV6sErs35ix4jRxFrhttRmmnV?=
 =?us-ascii?Q?pHyxo5LVInxZwNFgM+lvAXHvL4ijCpLg4x79AEAEq3cM0X6s2dNFGhFpGjd4?=
 =?us-ascii?Q?W9yM1bafGkR6XoCM8L/+QLRFpYr7UOAeZrJ4uJH6HZsf48ecyRXGNvWVTMGM?=
 =?us-ascii?Q?/MgTKXbBruckyaPjzHvvRXU98w6PANPQV4rkPFzwq8fvGUEm2csK28xSX7Yo?=
 =?us-ascii?Q?5V4Vpiy0CGbnQ4EBySBkh5/nECXw2nnqm7C/PeoLIFCuF1jYsa0+nAHX5rJm?=
 =?us-ascii?Q?OKoWHks/BzHotDdPUgWboheuwxOhyzMpjIy9fPWkr+ruB2TMT0mAgofGtcV0?=
 =?us-ascii?Q?UHBdoTzQdzo8lw8JiQBsv6tjdiw18FUFM/WJ5NNeZ2XXz52DvpgsBkPbBYw2?=
 =?us-ascii?Q?wxQ9AE9qrqDqKaGjEBJLTM66GHparVwhm458B0756DP/6L0gzSQRWWyMtwsW?=
 =?us-ascii?Q?yoOLV5xZ7qR1dLdK0PCf9UFFxL+X/gvHyWmeZg4xCffuOaWqcyGKM7jEgDt6?=
 =?us-ascii?Q?nKZ/msIimFk23skjM06NtjgzuZ1g3T9NHNLJW04F1N8P1SpBuY0EAytbpzX3?=
 =?us-ascii?Q?WO25hMS1yQG1SEfK4ntHYyfNoTYGhj3vBA4yT7KvjOeMWUqYmINmfcOMJCkE?=
 =?us-ascii?Q?Mhc7vXW/up96MZ/NK/i2k/1nIYQ/EvEhu1akarQ0YvdGx+56SqOI1pUeZBmI?=
 =?us-ascii?Q?i2N1ZAD9gaB5RhKYl/ZQwtzY4JQ01vXzuZuIQezdSR8ftT2Mq2d9dMHTgy3W?=
 =?us-ascii?Q?vl517R3nscx+5U0y0hgS/wwwLmmrH1+7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:24.9157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d919c78a-67d6-4848-d974-08dcd10b05bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

This patch adds support for userqueue resume. What it typically does is
this:
- adds a new delayed work for resuming all the queues.
- schedules this delayed work from the suspend work.
- validates the BOs and replaces the eviction fence before resuming all
  the queues running under this instance of userq manager.

V2: Addressed Christian's review comments:
    - declare local variables like ret at the bottom.
    - lock all the object first, then start attaching the new fence.
    - dont replace old eviction fence, just attach new eviction fence.
    - no error logs for drm_exec_lock failures
    - no need to reserve bos after drm_exec_locked
    - schedule the resume worker immediately (not after 100 ms)
    - check for NULL BO (Arvind)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 120 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 2 files changed, 121 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 979174f80993..e7f7354e0c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -405,6 +405,122 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static int
+amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id, ret;
+
+	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
+
+	/* Resume all the queues for this process */
+	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+		ret = userq_funcs->resume(uq_mgr, queue);
+		if (ret)
+			DRM_ERROR("Failed to resume queue %d\n", queue_id);
+	}
+
+	return ret;
+}
+
+static int
+amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo_va *bo_va, *tmp;
+	struct drm_exec exec;
+	struct amdgpu_bo *bo;
+	int ret;
+
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to lock PD\n");
+			goto unlock_all;
+		}
+
+		/* Lock the done list */
+		list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
+			bo = bo_va->base.bo;
+			if (!bo)
+				continue;
+
+			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unlock_all;
+		}
+
+		/* Lock the invalidated list */
+		list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
+			bo = bo_va->base.bo;
+			if (!bo)
+				continue;
+
+			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unlock_all;
+		}
+	}
+
+	/* Now validate BOs */
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
+		bo = bo_va->base.bo;
+		if (!bo)
+			continue;
+
+		ret = amdgpu_userqueue_validate_vm_bo(NULL, bo);
+		if (ret) {
+			DRM_ERROR("Failed to validate BO\n");
+			goto unlock_all;
+		}
+	}
+
+	/* Handle the moved BOs */
+	ret = amdgpu_vm_handle_moved(uq_mgr->adev, vm, &exec.ticket);
+	if (ret) {
+		DRM_ERROR("Failed to handle moved BOs\n");
+		goto unlock_all;
+	}
+
+	ret = amdgpu_eviction_fence_replace_fence(fpriv);
+	if (ret)
+		DRM_ERROR("Failed to replace eviction fence\n");
+
+unlock_all:
+	drm_exec_fini(&exec);
+	return ret;
+}
+
+static void amdgpu_userqueue_resume_worker(struct work_struct *work)
+{
+	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
+	int ret;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	ret = amdgpu_userqueue_validate_bos(uq_mgr);
+	if (ret) {
+		DRM_ERROR("Failed to validate BOs to restore\n");
+		goto unlock;
+	}
+
+	ret = amdgpu_userqueue_resume_all(uq_mgr);
+	if (ret) {
+		DRM_ERROR("Failed to resume all queues\n");
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
 static int
 amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -486,6 +602,9 @@ amdgpu_userqueue_suspend_worker(struct work_struct *work)
 	/* Cleanup old eviction fence entry */
 	amdgpu_eviction_fence_destroy(evf_mgr);
 
+	/* Schedule a work to restore userqueue */
+	schedule_delayed_work(&uq_mgr->resume_work, 0);
+
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
@@ -508,6 +627,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	/* This reference is required for suspend work */
 	fpriv->evf_mgr.ev_fence->uq_mgr = userq_mgr;
 	INIT_DELAYED_WORK(&userq_mgr->suspend_work, amdgpu_userqueue_suspend_worker);
+	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userqueue_resume_worker);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 8b3b50fa8b5b..d035b5c2b14b 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -76,6 +76,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 
 	struct delayed_work		suspend_work;
+	struct delayed_work		resume_work;
 	int num_userqs;
 };
 
-- 
2.45.1

