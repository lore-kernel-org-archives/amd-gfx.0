Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3835C25B5F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 20:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4779A112976;
	Wed,  8 May 2024 20:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B3p0oQxq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7239411296B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 20:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DClgsTaz1UVzeJzVyayMDm7ehYQHUwdpUD5XzfV8nTE86ObcbrS+rICa/+9uliZuU2IBgZSj3Ua3gFCk5D4pW6XYREiykzN6H5vpqhRTzQ3+GvJ9VgIS/Lu0BO7izDm6N6hZ/wdQo/dut4Zbz61Hu/26vBvM4JIJowhrcSyWANEoqYCN2GSsuPZ6Udh3tA3CSKJ5Bwg+yfWe3mPDhA6/oSfkmovtZY2thMc92dr0Y+BWWOgjbX4Sk7pdqoB54v2j8GWD2MnoIDIhVGes5wkt8RGUF/zXl88hwUDriNiUulbvvINnzg/wSqJWrrzWQgV7OMyIw8doXVQE8j5c71QWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajHcg+x8qNGJ8ZLM/UlLSLb6LgCQk2SADJe/qC3gpQU=;
 b=LtqogoCxR3JJMvbOGFWq6DqgCwARPMfoYLJ1lgkOofej/VH4daIMV+vaVAOSeIbkbYZfRX+ti4Y+DKt59Cx5Fp8o2OrULIEhgZwGcc0//3A2iK8aT4mKtdS9u5cJHIpkYwlt1hb9eVvqVuZkvzBIY8NbfoUYAAF/w7/Jy2fTU4C3o/i2N0PFd5UVhdkVCUs+bVWpDFHSk7dEo3srmsrAfSuE5utw4Y510BG3cNiF5AwWFb6gkYcwNu18AQUOqCOdSer/Ahb0yuQEQJeoF+/9bsi2ZnGbaCnq7akB8wLiU2MCRKlATUeVVngRGL3FLMbZslAwUVNabqPgHZjmBF/Wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajHcg+x8qNGJ8ZLM/UlLSLb6LgCQk2SADJe/qC3gpQU=;
 b=B3p0oQxqloRcOgxFGxjr/A8dBXR0KlZsDbtAwkSwlyQMo/3TLRT+BdJ0EcJDr+4C7KQ//Nff/hiR8Szl6eQLIT9CPe1rFs508gdEiUIxNCRn1OXQTaRG+GVNafShMjDXSz1OTOMVIFtPEWoQby5KXzm1qF8NoS7HGpTGetO+rD0=
Received: from DS7PR03CA0298.namprd03.prod.outlook.com (2603:10b6:5:3ad::33)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Wed, 8 May
 2024 20:29:13 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::e7) by DS7PR03CA0298.outlook.office365.com
 (2603:10b6:5:3ad::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 20:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 20:29:13 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 15:29:11 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add userqueue resume
Date: Wed, 8 May 2024 22:28:37 +0200
Message-ID: <20240508202837.1411-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240508202837.1411-1-shashank.sharma@amd.com>
References: <20240508202837.1411-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe01a02-5345-4280-2fbd-08dc6f9d865f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eYJjINgJcZFGP5XVGg0uY/sC/KTIZ2A6PZ5uUlydmlj7hmfXS1nDmxlO1yzu?=
 =?us-ascii?Q?lpnfTxp1Za17BDiCcVD/Gd9NGEnVTyYUHS8tekpT5LKlO4a14OdlYqT/dHuy?=
 =?us-ascii?Q?ujhgLkSkSdFoT4sOOjh5e5G/Xv/7MIq7UuFX5YSfjRTeDd6nqQrl9ZUWKCj9?=
 =?us-ascii?Q?mLrRfs0PiyBVS6jBaHTQ90pUwsVeV2YlL7ZCRI2DVx6/cyNYIX2kMhsAoN6V?=
 =?us-ascii?Q?mdKbGOy6MOGoZPz2MScJMtM0fnPA1Q/8z1SBNS3ax5rVo1xHbHLto7dtN+ZW?=
 =?us-ascii?Q?XGu1Cb+pKfJMFx871GUERJjFcsSLrY9X2R5sCqhrfAHXLcQ42dQmLEEcjFpg?=
 =?us-ascii?Q?0WGdpE6fqDfH4s/updFLlM3ebr3zUF1J+a+JG2wM5Js6e7z3bDit3HWwjgng?=
 =?us-ascii?Q?n8Gw/cPNrie+nr2sjSKnGCDxpazwoCE5fZgNWoM8JmPr1SRj5ZzXdQgTPwq0?=
 =?us-ascii?Q?uRQxHF87vaXD+aoQ0h2z67sKwdLtgNXZw+O8SDuLuh2pCjd3MIvopgdFYty+?=
 =?us-ascii?Q?KZCTBYwvM8X/4v1dab6o3988bB8WTZZNhr094ZRBalC/iy3mUDY7wj5U4ywD?=
 =?us-ascii?Q?OV8+7P2Y+zGjjRdni2tiXJT6lU4T1iT+LtC0+t6X+VGUq9/KE0xqIpvYxPP7?=
 =?us-ascii?Q?zi7fpTYvODgaMHwih6PhVHD9PgkRTAoH1yDOx698zXsKuu9NqGsE9GMJiWAj?=
 =?us-ascii?Q?wtO/MRw1Og/bcd9kVsI6r0zb5lOU5tClELM0dZryflUNdIQkjHlHKrvRAjpA?=
 =?us-ascii?Q?HEZtb6FWsfUvNg8j1VwnrTaL42Y3fnQbDBihPz6JTKRUL6jJF0TEVcJuYiFt?=
 =?us-ascii?Q?BH2V2VY+93dxCDCn+61CqtCu0Qihn08Hcsk8gddO2e0ofIMyragIEViHuZvu?=
 =?us-ascii?Q?vGd0y/chcg7UOUsCAp0NAP3VsdGuqphJDyZO7JwScGfnOtAzx3XOdEcYAOls?=
 =?us-ascii?Q?c8xd0nHpRsRvuej10UKqTxVEioyKbqO1cuwYleymbLtHjWk4zl6MjRiLiyH2?=
 =?us-ascii?Q?R2FEpemqXlykqy5SwQY3K2dfAauKzzbfbn8CKmlyqcB6TDPoFn7AtQYVgoCs?=
 =?us-ascii?Q?GHZGHNOtzrmfftq8X0Z6F1RdlyylMylDoxL2hzTahgwWlrwPy5Ad9cvY9wJX?=
 =?us-ascii?Q?iPrwPhW0LDF4AG6JmCg084J0UPLeHJfRwRXhmVuDekSJ3gC8vzvMfo9E4a/Y?=
 =?us-ascii?Q?8XjpAPhJpWR3t2g3u0KfcMK9fI5buKYqECQLM7HHcq9OJA0syqVnpm1CqnEM?=
 =?us-ascii?Q?penTEdPqmPZ0ZmEZohL6NC19qMlvWLdbNz0M4ooZNcy63TKmPZopl5ueCiy7?=
 =?us-ascii?Q?KgUvhmgspPykcycXP7gzFX43rNOvrY1Do5p1yM1IR2OUNgBr4yb+CpmX3lLf?=
 =?us-ascii?Q?h6vrPonaX592p+QmY2NO+P3OU11u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:29:13.3920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe01a02-5345-4280-2fbd-08dc6f9d865f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 166 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 2 files changed, 167 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index fdbd542e7f53..02ddd713d068 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -398,6 +398,167 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
+amdgpu_userqueue_replace_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
+				  struct drm_exec *exec)
+{
+	int ret;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_eviction_fence *old_ef, *new_ef;
+	struct amdgpu_bo_va *bo_va, *tmp;
+
+	old_ef = fpriv->ev_fence;
+	new_ef = amdgpu_eviction_fence_create(fpriv);
+	if (!new_ef) {
+		DRM_ERROR("Failed to create new eviction fence\n");
+		return ret;
+	}
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
+		struct amdgpu_bo *bo = bo_va->base.bo;
+
+		/* Skip pinned BOs */
+		if (bo->tbo.pin_count)
+			continue;
+
+		ret = drm_exec_lock_obj(exec, &bo->tbo.base);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to lock BO for eviction fence replacement\n");
+			goto free_err;
+		}
+
+		/* replace the old eviction fence with new one */
+		amdgpu_eviction_fence_detach(fpriv, old_ef, bo);
+		ret = amdgpu_eviction_fence_attach(new_ef, bo);
+		if (ret) {
+			DRM_ERROR("Failed to attch new eviction fence\n");
+			goto free_err;
+		}
+	}
+
+	/* Update the new eviction fence */
+	fpriv->ev_fence = new_ef;
+	kfree(old_ef);
+	return 0;
+
+free_err:
+	kfree(new_ef);
+	return ret;
+}
+
+/* Expects drm_exec_until_all_locked called on this exec */
+static int
+amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr,
+			      struct drm_exec *exec)
+{
+	int ret;
+	struct amdgpu_bo *bo;
+	struct amdgpu_bo_va *bo_va, *tmp;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_vm *vm = &fpriv->vm;
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
+		bo = bo_va->base.bo;
+		ret = drm_exec_lock_obj(exec, &bo->tbo.base);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to exec lock  for validation\n");
+			goto unlock_all;
+		}
+	}
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
+		bo = bo_va->base.bo;
+		ret = drm_exec_lock_obj(exec, &bo->tbo.base);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to lock BO for validation\n");
+			goto unlock_all;
+		}
+
+		ret = amdgpu_bo_reserve(bo, false);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to reserve BO for validation\n");
+			goto unlock_all;
+		}
+
+		ret = amdgpu_userqueue_validate_bo(bo);
+		amdgpu_bo_unreserve(bo);
+		if (ret) {
+			DRM_ERROR("Failed to validate BO\n");
+			goto unlock_all;
+		}
+	}
+
+	ret = amdgpu_vm_handle_moved(uq_mgr->adev, vm, NULL);
+	if (ret)
+		DRM_ERROR("Failed to handle moved BOs\n");
+
+unlock_all:
+	return ret;
+}
+
+static void amdgpu_userqueue_resume_worker(struct work_struct *work)
+{
+	int ret;
+	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct drm_exec exec;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to lock PD\n");
+			goto unlock_all;
+		}
+	}
+
+	ret = amdgpu_userqueue_validate_bos(uq_mgr, &exec);
+	if (ret) {
+		DRM_ERROR("Failed to validate BOs to restore\n");
+		goto unlock_all;
+	}
+
+	ret = amdgpu_userqueue_replace_ev_fence(uq_mgr, &exec);
+	if (ret) {
+		DRM_ERROR("Failed to signal eviction\n");
+		goto unlock_all;
+	}
+
+	ret = amdgpu_userqueue_resume_all(uq_mgr);
+	if (ret) {
+		DRM_ERROR("Failed to resume all queues\n");
+		goto unlock_all;
+	}
+
+unlock_all:
+	drm_exec_fini(&exec);
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
 static int
 amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -442,6 +603,10 @@ amdgpu_userqueue_suspend_worker(struct work_struct *work)
 		return;
 	}
 
+	/* Schedule a work to restore userqueue after 100 ms */
+	schedule_delayed_work(&uq_mgr->resume_work,
+			      msecs_to_jiffies(AMDGPU_USERQ_RESUME_TIME_MS));
+
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
@@ -475,6 +640,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	/* This reference is required for suspend work */
 	fpriv->ev_fence->uq_mgr = userq_mgr;
 	INIT_DELAYED_WORK(&userq_mgr->suspend_work, amdgpu_userqueue_suspend_worker);
+	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userqueue_resume_worker);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 647e63bf03ab..2e3fe784188e 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -73,6 +73,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 
 	struct delayed_work		suspend_work;
+	struct delayed_work		resume_work;
 };
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-- 
2.43.2

