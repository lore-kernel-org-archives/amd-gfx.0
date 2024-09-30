Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B54CF649C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C6F10E404;
	Mon, 30 Sep 2024 12:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5LfLdeq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BF010E403
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM0+MxYihxBYGwrdJmKEsQ7w17yw23DjJ53KrJle10E4VlMnBXGQINVTsQX2kGwyC3vOSGLi82dgeKSkC7BIgAvVKXrhDXJ8A2jgLmXGLifLf7b9l1JPTOnZgryV/iYd8XvFBVVhaAO/+74ft9MBTA6mBYsNlpmiJRwRESY0zeexg1477Igep20rHCjjSA2vkn+w+022kyDidjcc5Qtib6DJqR4+XBVf8eX2IPRzZ4fd9XOx4T3U8yebv/5gQfzRCsnLD2uYAnDZ4xKGC48xxhp71lvFSK7YA2tgKdXugEWVd7j82j3A5/WswLQ3/nAsh8G+li+VqkAZSmapi6dbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfubneREQ/stLuvGXxcvjJLS4NbUPR4GPQSvtosBIkU=;
 b=rFhBt7oLBqqbg639036NehMSD4h6ZKDhEC5LeFknnU9UavZ6RAjfW8O5R8aH119VSAcXNhprYiyfyt0F5hN45eSddE/+c88JTujE7x4yPKtIHy6YJth1o0iJDEYv7YNx9BmUNj8+TYR6qxnudS5WSnn4jbz8Dqcn4yTP13hvXBSnT2bKcro3ojUFahs+IAiArgT3ALQXdI2o9O0akcU/P1O9GodiXuUcr+aEtHrRB5NzsXz8+nl1r/H5wW787CIh3ggR3efLBj7P1QttLl9q4G1qZIGLjcywx8PDCSLNtT7boUQAxK5VRvHvCpTtxYqiAWtrVNoajen49sxF5xXSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfubneREQ/stLuvGXxcvjJLS4NbUPR4GPQSvtosBIkU=;
 b=d5LfLdeq4fCyPXXpItiT5vyP1LXkfof+k+9rcKgn+xEDElwfLFc+MQv1UC9SUsgNUlww8I773hPjPvJyD8N8dX+CFCc6DjfNlthgiCBD5dCUWppRmPSihq/AE5HK+9n30/tjM9sNWz7epCzFaDmOZXULKrRaahSI/q3UGc1t2zA=
Received: from SA1PR03CA0015.namprd03.prod.outlook.com (2603:10b6:806:2d3::22)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:00:26 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::27) by SA1PR03CA0015.outlook.office365.com
 (2603:10b6:806:2d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:26 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:24 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 06/09] drm/amdgpu: Few optimization and fixes for userq
 fence driver
Date: Mon, 30 Sep 2024 17:29:03 +0530
Message-ID: <20240930115906.191060-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: be952d0f-261f-4384-cd79-08dce14778f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDNwS2FNd3NHM2hMSGV3RXovOGIwT3dyQUlNS0p0SDRxN1kvdzFCSHI2WGdE?=
 =?utf-8?B?dnNZZDZ0K3ZqT3ZCM0FzV0J2T1dyeS9HbTZuTkNVU2lEMGdXaS92Um1jekg1?=
 =?utf-8?B?V28yc3d0QkhKYThQT3pRUjFhSUprL29WMm5RclVLbmViMG9DQjFFNEZSc090?=
 =?utf-8?B?cTZDS2U0eis1QjlzYjc1Nlh0akJxU3FNd1FYY2UwbWJTUzBFcjhvREczS1RU?=
 =?utf-8?B?SWlmQjNMSnFtTlhHV1IreTBjOHRpNUdFSm1JTVdYSjM4TkVvcjZsVFIyREJG?=
 =?utf-8?B?WTVGR3pELzd1ejZ4TFprY3ZzMHJ5QUFTMlM0c2RDajNGUzBIU0tidytjaUZo?=
 =?utf-8?B?SFZYcExTZDFxeHgxS1ZTWEtQYTJpY296elRaelhwV1ovSmpvMmdKZ1NGOHJT?=
 =?utf-8?B?N3BqazFCVDBuUlhmOUttWnFsWmhQeU9tRTNBcGo1cWg3ZHVkbFJXbUVQSEpK?=
 =?utf-8?B?dWZaSzF4azZaU0wvcUdhbVo2KzQ1T0JRWmZXcjBQenBueXRFdndHTGFtWThB?=
 =?utf-8?B?UUhLSGxhbnBhZ1RNRGdSY2k5aVdRaklKRDZZZFZzWTdGbkVkMERoeW43Qkgz?=
 =?utf-8?B?d0FPa2pmUGh5SG9MWW9SdFVpa3hGb1hyWENuTVFNcDRpdWVFT1pDY1dnZ0ov?=
 =?utf-8?B?cFFrcTgzUmo4T280LzJQUnY1T3M3dTY4bG80Sy9TSTNjc3pBOFpaS1I2NFR2?=
 =?utf-8?B?djgzcmVKQ24xL28wQzNYNDBDZFFUd1JwQmRjWU5neDRReVlTNzQrdzlWdU51?=
 =?utf-8?B?REFkcE5Mb3VIZEx6cFRSa24xMXJ4NzF5SElZSHdzZVdpT01YNFI3Y1k1Tjhv?=
 =?utf-8?B?QnpLZkVHK0pwSUFSOW9OQkJEV2hEUmdpTkdUUFVnNFp3M3lhZTVkMmFsbnBL?=
 =?utf-8?B?WHIrTlpiZzBaeUUzMzBHNTY2WU5DVWordVNNQkJZdjBXU2ExUWNldmlEcWJt?=
 =?utf-8?B?WjVHSFRmR0xHU1l0dC9oaUxkZFZuRGJ2eXpqYWlsRjFJOE1SSEVnUmVXMVZr?=
 =?utf-8?B?aUxCazArMHFML0VKWlNpaTROUU1QUlZwd0xnQ0lzVVI5Z2JQemRKd2FZTnMv?=
 =?utf-8?B?Mk00bWVPVWlaREs4TDcrT25qamxmb2g4WVRWSE5DWCtjRlJWdWh6MlBrSzlu?=
 =?utf-8?B?RUg5N0JiMDJXbWVjQjRFeW1SSGYvZlF2b0RTSjFqNjduaksrVWpTK2VWeFNY?=
 =?utf-8?B?UnYyWTdqTnlPNzk2M01iempxdW1kaHd6VHpQTlh6anlLTDFtdjVkV0l1ZUg4?=
 =?utf-8?B?dlNYdERMU1RZRmR0V2xsL1BYYWw3V2JndlJ0Wm1BZDBXZkVLd1pVVlZjM3BJ?=
 =?utf-8?B?ZlNCTGpCaDl1Y2pMdThGQlh4SDhkaGliekJ5bjBnSW5peWl3dFFIK1RIOVNB?=
 =?utf-8?B?TUZweHB2ZkpudVk1cFFrbWVSZnJncUhpa1c1MkNIYmpZRnlaMjZ2YmdWbHNl?=
 =?utf-8?B?WXVoRkRMdE9qT1hLUGcwb0xaM2gwS0Z3SlpiSmFzUG8rTXRkMUxCcHZJVmdF?=
 =?utf-8?B?UU1rYVl5YXRMNnNsNGM4dDd4RjR4UnF5VFZYRmxEUDd3blVPTkhyOU9NL1JP?=
 =?utf-8?B?WExwcldxbXJjZHZzbHFDcW8zZVVYUmRRMHd4cWZ2bEhmQS9UMGRZUElxMVRK?=
 =?utf-8?B?cEpmTm5GV0p6dCthSFFJZ1ByQ2VKYlJTbGdpZjh5YWpZMUhyM1JZbjRoWHhz?=
 =?utf-8?B?c3FQdjIwR2ZrcFp0SmZUcmltMjI2bFU5Y05BaXNHNzNZUHdsa0JCV2VaMC9x?=
 =?utf-8?B?OEg4MEZrbmRhbTNDanF4TjdVNXRiMmkrNUNrK1oxWGsxYzVGa1dZcXBBMFMv?=
 =?utf-8?B?NGVTNWFsekNONnFEQ0VlTHZrQXhhcW9RNmh0eGhwY09qVlExZjVqKzZKdHZR?=
 =?utf-8?Q?gJi1lkBJSifcS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:26.7092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be952d0f-261f-4384-cd79-08dce14778f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

Few optimization and fixes for userq fence driver.

v1:(Christian):
  - Remove unnecessary comments.
  - In drm_exec_init call give num_bo_handles as last parameter it would
    making allocation of the array more efficient
  - Handle return value of __xa_store() and improve the error handling of
    amdgpu_userq_fence_driver_alloc().

v2:(Christian):
   - Revert userq_xa xarray init to XA_FLAGS_LOCK_IRQ.
   - move the xa_unlock before the error check of the call xa_err(__xa_store())
     and moved this change to a separate patch as this is adding a missing error
     handling.
   - Removed the unnecessary comments.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 44 ++++++++++++-------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  6 +--
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +-
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index ca8f01b2bd96..56bd870ff15d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -77,7 +77,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
 	if (!fence_drv) {
 		DRM_ERROR("Failed to allocate memory for fence driver\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto free_fence_drv;
 	}
 
 	/* Acquire seq64 memory */
@@ -85,7 +86,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 			       &fence_drv->cpu_addr);
 	if (r) {
 		kfree(fence_drv);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto free_seq64;
 	}
 
 	memset(fence_drv->cpu_addr, 0, sizeof(u64));
@@ -95,7 +97,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&fence_drv->fence_list_lock);
 
 	fence_drv->adev = adev;
-	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
+	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
@@ -107,6 +109,13 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	userq->fence_drv = fence_drv;
 
 	return 0;
+
+free_seq64:
+	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+free_fence_drv:
+	kfree(fence_drv);
+
+	return r;
 }
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
@@ -148,7 +157,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
 	struct xarray *xa = &adev->userq_xa;
-	unsigned long index;
+	unsigned long index, flags;
 	struct dma_fence *f;
 
 	spin_lock(&fence_drv->fence_list_lock);
@@ -165,11 +174,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 
-	xa_lock(xa);
+	xa_lock_irqsave(xa, flags);
 	xa_for_each(xa, index, xa_fence_drv)
 		if (xa_fence_drv == fence_drv)
 			__xa_erase(xa, index);
-	xa_unlock(xa);
+	xa_unlock_irqrestore(xa, flags);
 
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
@@ -213,12 +222,12 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
-	if (!xa_empty(&userq->uq_fence_drv_xa)) {
+	if (!xa_empty(&userq->fence_drv_xa)) {
 		struct amdgpu_userq_fence_driver *stored_fence_drv;
 		unsigned long index, count = 0;
 		int i = 0;
 
-		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv)
+		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
 			count++;
 
 		userq_fence->fence_drv_array =
@@ -227,9 +236,9 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 				       GFP_KERNEL);
 
 		if (userq_fence->fence_drv_array) {
-			xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
+			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
 				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				xa_erase(&userq->uq_fence_drv_xa, index);
+				xa_erase(&userq->fence_drv_xa, index);
 				i++;
 			}
 		}
@@ -379,7 +388,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct drm_exec exec;
 	u64 wptr;
 
-	/* Array of syncobj handles */
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
 				      sizeof(u32) * num_syncobj_handles);
@@ -401,7 +409,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	/* Array of bo handles */
 	num_bo_handles = args->num_bo_handles;
 	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
 				 sizeof(u32) * num_bo_handles);
@@ -423,7 +430,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+
+	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
@@ -528,7 +537,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_timeline_handles;
 	}
 
-	/* Array of GEM object handles */
 	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
 	if (!gobj) {
 		r = -ENOMEM;
@@ -543,7 +551,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+
+	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
 		drm_exec_retry_on_contention(&exec);
@@ -722,8 +732,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * Otherwise, we would gather those references until we don't
 			 * have any more space left and crash.
 			 */
-			if (fence_drv->uq_fence_drv_xa_ref) {
-				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
+			if (fence_drv->fence_drv_xa_ptr) {
+				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
 					     xa_limit_32b, GFP_KERNEL);
 				if (r)
 					goto free_fences;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index f72424248cc5..89c82ba38b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -54,7 +54,7 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
-	struct xarray *uq_fence_drv_xa_ref;
+	struct xarray *fence_drv_xa_ptr;
 	char timeline_name[TASK_COMM_LEN];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index e7f7354e0c0e..9b24218f7ad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -48,8 +48,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 static void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
-	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
-	xa_destroy(&userq->uq_fence_drv_xa);
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
+	xa_destroy(&userq->fence_drv_xa);
 	/* Drop the fence_drv reference held by user queue */
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
@@ -348,7 +348,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
-	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		DRM_ERROR("Failed to alloc fence driver\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index d035b5c2b14b..6eb094a54f4b 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -52,7 +52,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
-	struct xarray		uq_fence_drv_xa;
+	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
 };
-- 
2.34.1

