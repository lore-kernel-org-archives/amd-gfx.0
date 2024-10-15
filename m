Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D57ECFC271
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E98010E527;
	Tue, 15 Oct 2024 07:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLQXV0dc";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53F210E526
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXfQ74xK6qghsNVKanjPhDDku924UFWV/ix0P3jMhR4OIkDttuZxXRWp1zginf0Luqfbw3eWYJbFT06T8knM0NdQ62XzTOmS/XPL/gCswzbPzJ6cquLjq+P4bUrDkuNyixFFinrNmlR9MdXSgeTFRcv54DhQbdNo0EzHHXuPjFMAonQjdqEZdDsc3Oybxf++s3JOMDo/wNOtbeT1EdPDvV63XwF9E+96XPZvYtSBFYdZShV2k79E+GFfOW3KXsHtcgG6c6r3h0lHu+kFeJDEUN6TM06jKfPXhGvtrCT05gELh6nXuv60mlB2KDyF0AjpZCNK82UNbCfF90JQXbd8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibLN70HoYO6euYppWEv4S2n0NriT5PASLRhMrJGvhVk=;
 b=F71wyGRPNP45f4+9Wk0j9K8bQ+OY/XuA8VnF9jWX+Ndk/pMZHVaTr+7MbIUOhY0jo4arWyMlX8CIOUhT46TqXkVU6UciKoVHH16ozL4q+iMh3qaRKBXqajd+2jrlTtW6JsJxsNzDF0ZUmYgZB4LHLJo0K+xgazP00dZjafhE5nHLOZ2cavwytmVauviUnoB9KXeSpoAl3tvXj1w9Qm8UMjfWchpJgcjyLbsqaEmAXkJrAC6gINmR58SFDEUxRSsgjEtJ9sEfeJfe1O2sRi2w01TM/8hH6qQ+7l/La0marRfCh/ECQ68r3ybgjIiUsFspvYkQB10jPheU4SlJ7UmFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibLN70HoYO6euYppWEv4S2n0NriT5PASLRhMrJGvhVk=;
 b=cLQXV0dcDt8jy7yayKv5ujzd2MMYtI32zlKGljZ0oukwM/7WCCi7enppre6UO0Ukz6aXOc1kCKlNOikHL+IoYzazaCqB/VFe5IU3toV9mVuxsr/vsrjrqwcjwDK3nX1J/5VddPnaUL94K/2tNi/O58gRh/SNGHN1Tl8PHYhI5kU=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 07:43:43 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::f7) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:42 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:40 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 06/09] drm/amdgpu: Few optimization and fixes for userq
 fence driver
Date: Tue, 15 Oct 2024 13:13:06 +0530
Message-ID: <20241015074309.2484264-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4144f954-945f-4577-2335-08dceced179f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnE2R3RDYk1KL1pMRnRnWUxXa2JncWdRb2psYkJlZVBBRXRnc0tpVURLazV3?=
 =?utf-8?B?TXBaWktOMnp4R1praVdia2R3djhBcXI4THgzTWFxZ044WUxkelIxbTh0SnBs?=
 =?utf-8?B?MkJGSjRHZHM0K21OZlVTWmNHbElkVmhqTVArbThLTWVzd2RkL1Bwd1hwT2N4?=
 =?utf-8?B?TmQ4UUFsMk1jcmsrQU5SV01RbHBESE8zT2tXR3JnblphRXVISHRoRStaZFMy?=
 =?utf-8?B?Z1hUbXptSWtEdEN2MDFrMW9Jc2hBUytSZnpKbGVMY0hGeS9EYXBKeUR3NTc4?=
 =?utf-8?B?aCtXVFFqSlk2a1Bjb2l3cFhXRnNKZ05JOUJ0amFWeTZKWHd3My85STZXOW5U?=
 =?utf-8?B?VWZIRkRBb2xaUXhiL2J0emhoRXdrQlN4Y3VHWjBacDJGN3ZFbXdlMTlqNnpX?=
 =?utf-8?B?azBKUEVkUUViKzhEeG5vVHpwSUFBZEhlMFIrMnFyMWViMFpHOUNSeUhSLzRu?=
 =?utf-8?B?bmRIMnVvdnFXMVRMemdCVGUvNEczYklqVkVHbVVsLzlmVWJTT1BTMVc2UHVa?=
 =?utf-8?B?cGV2REduWHpGN0ZKSjAvMzQvQ0ZZSFV5dWs1YkJsSE1QUmU5YmlnRnZXZ0hP?=
 =?utf-8?B?UVpjUWdYR2VzNXhJVVJpM05iSDZpUTlLV0FLTEhsVXNwR1U5Zld6cFBHbUl6?=
 =?utf-8?B?M212UmlWakh0amtLbDJSczVPajhtelZmS2V4TS8rSDNORDVjTGxRUnZNbEFG?=
 =?utf-8?B?QlVBSi9ENEJyOWE5ZE5pc3NxVlVqdmRGTEYvYmk5eThrZkpHOWhxMi9VRkpk?=
 =?utf-8?B?dmVWakVkWlQrUnJ4ZzQvY2w2UUVJMVcyMTM3c0l3N3o5WlFFaFJ1V0F1NVh4?=
 =?utf-8?B?REFRVi9tNnh1R3h2Ym43bmJqZHI4UVpibzBtWHpjMFBEYTRPenJSQk9FbmpG?=
 =?utf-8?B?SFl0ZmZOSUdrK0hCeit0OE54bXlJZEY0KzFEc1UvdUZRSms1WlJocnVmQldo?=
 =?utf-8?B?QXZIdjhYQ0J5Z0hHMUhDd2JPbEw4eFFrc0dBOUEyQXRhc0FyTnc3azE5M3Jm?=
 =?utf-8?B?MmpIckxvZnZRcGlYU05DVEtyVHk5SEVWQUNxM2RTVm80QThMVzNWeDBuRjNr?=
 =?utf-8?B?UHBtazdGcGVYV1pSQ3F0RmI1R2JlaDM2dE1VaTNXS0tzQldxMzNsVFZhM2k1?=
 =?utf-8?B?b2drSktndWFqRGpyMzZqYkYyZG54aHVpSVNnSUZNQ2VvdjZDUTVxTUcrL2NO?=
 =?utf-8?B?dlBHMHJCNnBOL1BCQmgvandhdytmZ2hyRjBNdGhpTFNzTTVtYnYzK3dmSDUz?=
 =?utf-8?B?dUdCdGNZT2ZhVjdPaGJNalBGcXVMNG1XU0dya2pOUzBqMTU2R3ZnRnVnOVhT?=
 =?utf-8?B?S05qSU9SbWk2eThETm41cXg0N1Q5MDdHUVVFNVVxek5rV0orSDZwbjBOT1hy?=
 =?utf-8?B?ay9DRzZuUEJ1dlNWaXJFd3dPdVlXdmVhUXFSYXdRQzNhV09aOTN5OFIyMzBK?=
 =?utf-8?B?NVd0VTI5b3ZTL3p6cjMzSCtXWUszZWVpRWZDYUxFY1lFeTNzd3laSG5pK2pG?=
 =?utf-8?B?ald4YVJnVzJYd3RMajFkbmxDUGtTbUF4MEgvMllUcEpFTXVxZUZwVEk4N05X?=
 =?utf-8?B?bTJoaGhVTjV2SnZTVi9xWTJxZkQ5bnhQb05xMlBrTXJNakRRS3VxZWxjS1Uz?=
 =?utf-8?B?L25BazE5R3IzdTZRSXFPcHBoT0JMT0FVTkR1MWFrR0RTaGZLWjhLVFgzVk5a?=
 =?utf-8?B?UGNFNkdBeXZtV0lFcFErNkVPS1Fad2t2OXZ1SlFNNUJpY3E1U2N1USt6WnpR?=
 =?utf-8?B?cTFDT09pMkZMNXd3MmdlRzNYdUxUYlZ2bENBRkU2V0ZDNXE2bk5SUzdkMm5X?=
 =?utf-8?B?V0hoWUk2M2lNSmJKSW9NdzljTmhxNWMvNmtYelllNUNNQ3ZES1lteVJhbjNh?=
 =?utf-8?Q?76r1m/qRRvte0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:42.6696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4144f954-945f-4577-2335-08dceced179f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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
index 5c395943b50e..b6fcc04a23af 100644
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
@@ -714,8 +724,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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

