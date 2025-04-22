Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE97EC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 10:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A660910E1C9;
	Tue, 22 Apr 2025 10:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eL4oG4E9";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87A110E1C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 10:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtMnUkML3EHVcCPvxoNtvxrFMf1YRsrsZowVCnQyH5uALcLcVamj+bWFpsIcpAMszoAuMsqeLzclj7zA5/Ymddw1XpYR+NYEHlYRpZCVbvDFgQhmjOlQMLr7lfyL4mQhJTskM/+3ZVYGYJVLdSbpPwBykE54UBAvAf8VKBtvcTvpaRUXFz/RmoueGJSfM+D8UY1071j1GV/i2YNVV98UAqtwWTSkzvwGtVX5Ff7wKKj+4PGRPO+d7X66khH0+ZgjNmG5sgp1z73AmitsV98/M/E26csNJFDbAUpuI5wa00dV7NRj5rgtdlgFFcnVTIGcitOT0CsBlWikKUnOwQR7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSoGDqKtEswh+rIpg8EApoPNrj7m2ZdRaG5UvVtKtr8=;
 b=HYJ79bCOdx7Bq7DtlhLMjhnLuSjiUMLiO7QvLry3MmUs+g8fkpu4DC9IObh7hw5fVUjSPl7UpST8su3VfGttLwZt1QcxVA76QzjPDVMPmsaZNDSInsx28esAoFWmkGS96wjbOIoGVJVg7cNPqDH00WVwcNgVUs/q0mYMow7PkqclL9EhegRM5FjWpQ1uWcBUqpBaeJxh+RsswPj5kxZZ0mcnelAWeXofL9GAqIfgQPW1oFru5ZFfqNvAucuvdxqjozC2t2m0y7R+g1Iw0kEvbPRaVmvSNko6762cwXZW2sDOwviVEIKr6OHzFMqxmqrLGanRZkMR84YyVfFa0YwuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSoGDqKtEswh+rIpg8EApoPNrj7m2ZdRaG5UvVtKtr8=;
 b=eL4oG4E9bv+Cnk8c/AVdV3te1t1SdxxuDjjkoWmiKBDW2+49KdGrFFZIDoTf9uaiyTHUOQXQ+FiGPfbkiUN+P4klE2g0Prwy5mTWiovhN4EYkiU2Hgqa1f7ZMCeuR3sEHcZh1a4Thrs29hzILcAwelXD78RIF80HDrN9asZi+2g=
Received: from BN0PR04CA0162.namprd04.prod.outlook.com (2603:10b6:408:eb::17)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 10:33:13 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::51) by BN0PR04CA0162.outlook.office365.com
 (2603:10b6:408:eb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Tue,
 22 Apr 2025 10:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 10:33:13 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Apr 2025 05:33:10 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: remove DRM_AMDGPU_NAVI3X_USERQ config for UQ
Date: Tue, 22 Apr 2025 16:02:32 +0530
Message-ID: <20250422103232.145823-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fc40a3-3812-40bd-5fda-08dd818915ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ym1eHX3wYNyu4jWeswG+qkGc0OqqDaPGAQWvi+XVAeNg+aCuumZ6+yg9cpLW?=
 =?us-ascii?Q?0jgNJnSnZgkDQoTq/r3FlhLqAtlwiHIZx/cCf9utzB/LBaA7gxKvmTS8UKNY?=
 =?us-ascii?Q?f2YwJ/iBUO5ZmNS9k6Cy0wD5tcKQ4zOI7+WuXrcd6wy/l3bzO3sbqk9LKuoz?=
 =?us-ascii?Q?JK91unvwHKQzKcb1iCS1YynsqeU8tPNPsovH/Tm9hp34Zf+t/Bg9ECYRy04W?=
 =?us-ascii?Q?NsmoxHX9pri8/kvcKd+DvuGrYaFjtmmko+j0U/n+RiRR+faTEBFP7xzaK+17?=
 =?us-ascii?Q?6sk+yjo3s9xHmW44L20G9yJnL0HgPRMuTj0jEOqgde0wHSCPOayaIVCfyryU?=
 =?us-ascii?Q?45qsLJkcj4nmMIuzLLQh7nKTHIEPPMJ3PZTqb25QITn0semt8OjQahuStg7P?=
 =?us-ascii?Q?ugE/B8TFM+WqQfdiP6vn9ZcyVrNWWMUsaHc/T1tgeoux+03LDAYBAnY18hyM?=
 =?us-ascii?Q?6wYNLEPg0Jw8fFdwhKXxhlcGAC1KrE95qR9/f9iaTxys1IP+sb0wU8VF1QP8?=
 =?us-ascii?Q?6b9HOoIl6OUYf9jV20H003VcQpbYhyhxdKXJNyN1j5UM895sr+Br+oajwz6a?=
 =?us-ascii?Q?DBZ6JHb/15d9GkfAcUKROQhzo1db5IUAdXnrhvgQhPAfSQWd9pZEYPQOyIVp?=
 =?us-ascii?Q?kiNC/JCoTrH2tVT4vmMHx0JpyKNNezSRTnn1K2Z+Wwg3CV4R6rF5EowCFjNq?=
 =?us-ascii?Q?7VXpPw5fJZc8b+o1God6au0m2GjKpBWc8nl21WF0TWXK4QO4C6PSrAnP6CyT?=
 =?us-ascii?Q?XyXDAxtIRBaIuVgnwgddTNPzPkMQGG8ktRMidJIsc2Qf9MrS7QHNAOFOR+1C?=
 =?us-ascii?Q?D2efJD2Zu99ZfFOSs4wnoOFKxmdZ7UYmhqv3HVCj3t3QPyzo/3ohUMmnxMv0?=
 =?us-ascii?Q?hT+zyKjpu/6gdJUN1xMBOujc+1Gc51V7BLPE/5ku7h1MCr8azCUg+EQAyZym?=
 =?us-ascii?Q?cBVm7Ue1g4kbtrtWD8mYbxJAN6+2KSlb+ll0q7vVpWZx+bF6wF6jBjHu1wis?=
 =?us-ascii?Q?1VBOVqWvOsN0T/LkpfdRUfvIZfeet2ecgn5BjP+bxccTDcVK1y0+dXSJChsI?=
 =?us-ascii?Q?pHWaHwuhItymJ3LYD4JGMhoi1fYI5cVub0o65PHFd/Fft7mlk/ffBOLYvoZR?=
 =?us-ascii?Q?75TpHH5+HKVHNSlZNYGuj/IBEegUvkCOQ6Y6WmVx9T1sbBj4AYcUNF0LhcT/?=
 =?us-ascii?Q?lDo0u1oWxtW/kWHu2JNtyBB22XMvmQ6eO/YN6n4fCRU+iJngNXwjgZOIlFHD?=
 =?us-ascii?Q?Y24Y8ajKOYf9SNtNpy8iOoesaQIG6yvV63qrQNSqd0cwrkfwE/vPgbir9emM?=
 =?us-ascii?Q?N36bnxVNxdT/X7QxlWC3fqpyv+H+1exS+pRjZkPa0bYzwyAVuWduYS4gxpKV?=
 =?us-ascii?Q?w+mP7o5rKBn+Njm5TiiPPj8AapXl5Jb1E0WujbhmTFHJrmeR1nXuSnHDYmDj?=
 =?us-ascii?Q?lRzHM0Xp3MBW+Vaq6MVVqlx3awAxl8KsHOBw6ZCunRaajg220Uncm3puQKNe?=
 =?us-ascii?Q?QQFf62vXh8RJvKZO1dpsFeBJ7kUM4fLJmzSb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:33:13.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc40a3-3812-40bd-5fda-08dd818915ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642
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

DRM_AMDGPU_NAVI3X_USERQ config support is not required for
usermode queue.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig             |  8 --------
 drivers/gpu/drm/amd/amdgpu/Makefile            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c        |  5 +----
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c  |  8 --------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c         |  3 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c         |  3 ---
 10 files changed, 4 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 7b95221d2f3d..1a11cab741ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -96,14 +96,6 @@ config DRM_AMDGPU_WERROR
 	  Add -Werror to the build flags for amdgpu.ko.
 	  Only enable this if you are warning code for amdgpu.ko.
 
-config DRM_AMDGPU_NAVI3X_USERQ
-	bool "Enable amdgpu usermode queues"
-	depends on DRM_AMDGPU
-	default n
-	help
-	  Choose this option to enable GFX usermode queue support for GFX/SDMA/Compute
-          workload submission. This feature is experimental and supported on GFX11+.
-
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 513c4d64f554..7efa36367697 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -177,7 +177,7 @@ amdgpu-y += \
 	mes_v12_0.o \
 
 # add GFX userqueue support
-amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) += mes_userqueue.o
+amdgpu-y += mes_userqueue.o
 
 # add UVD block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b96e0613ea7e..fe68ba9997ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3513,9 +3513,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	amdgpu_amdkfd_suspend(adev, false);
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	amdgpu_userq_suspend(adev);
-#endif
 
 	/* Workaround for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
@@ -5086,9 +5084,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	if (!adev->in_s0ix) {
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		amdgpu_userq_suspend(adev);
-#endif
 	}
 
 	r = amdgpu_device_evict_resources(adev);
@@ -5156,11 +5152,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			goto exit;
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+
 		r = amdgpu_userq_resume(adev);
 		if (r)
 			goto exit;
-#endif
 	}
 
 	r = amdgpu_device_ip_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e1dca45a152b..4c8091cfd137 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1970,9 +1970,7 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 		if (adev->gfx.userq_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
 			if (!adev->gfx.userq_sch_inactive[idx]) {
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 				amdgpu_userq_stop_sched_for_enforce_isolation(adev, idx);
-#endif
 				if (adev->kfd.init_complete)
 					amdgpu_amdkfd_stop_sched(adev, idx);
 				adev->gfx.userq_sch_inactive[idx] = true;
@@ -2030,9 +2028,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 		/* Tell KFD to resume the runqueue */
 		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
 		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+
 		amdgpu_userq_start_sched_for_enforce_isolation(adev, idx);
-#endif
 		if (adev->kfd.init_complete)
 			amdgpu_amdkfd_start_sched(adev, idx);
 		adev->gfx.userq_sch_inactive[idx] = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 0a3032e01c34..265dd4c0dc66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -217,7 +217,6 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
 }
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
 {
 	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
@@ -289,7 +288,6 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 	return 0;
 }
-#endif
 
 static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
 {
@@ -344,7 +342,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.release = amdgpu_userq_fence_release,
 };
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
@@ -595,15 +592,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
-#else
-int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
-			      struct drm_file *filp)
-{
-	return -ENOTSUPP;
-}
-#endif
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
@@ -964,10 +953,3 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
-#else
-int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *filp)
-{
-	return -ENOTSUPP;
-}
-#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 4e02d6cc66b5..36cf84c74f20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -73,7 +73,6 @@ amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 static struct amdgpu_usermode_queue *
 amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
@@ -465,13 +464,6 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
-#else
-int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
-		       struct drm_file *filp)
-{
-	return -ENOTSUPP;
-}
-#endif
 
 static int
 amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ac7ac58e25a6..519b82f77cff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1630,7 +1630,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		if (!adev->gfx.disable_uq &&
 		    adev->gfx.me_fw_version  >= 2390 &&
 		    adev->gfx.pfp_fw_version >= 2530 &&
@@ -1639,7 +1638,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-#endif
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1647,13 +1645,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
 		if (0 && !adev->gfx.disable_uq) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-#endif
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index dfa0830a4eb1..f09d96bfee16 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1416,7 +1416,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		if (!adev->gfx.disable_uq &&
 		    adev->gfx.me_fw_version  >= 2780 &&
 		    adev->gfx.pfp_fw_version >= 2840 &&
@@ -1425,7 +1424,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-#endif
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 6bb36187a53d..da5b5d64f137 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1363,11 +1363,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
 	if (0 && !adev->sdma.disable_uq)
 		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
-#endif
+
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 943c6446a0a7..befe013b11a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1338,12 +1338,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
 	if (0 && !adev->sdma.disable_uq)
 		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
-#endif
-
 
 	return r;
 }
-- 
2.34.1

