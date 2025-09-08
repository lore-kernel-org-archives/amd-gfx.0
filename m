Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C345ECAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5BE10E493;
	Mon,  8 Sep 2025 08:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DobmsUNU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C2810E492
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns0tfwTyPuZDStrTCNehFM2TkispFGpvQ6EOXtSdFMNDRfMkq/8QzXy7Oc/bzzdhw661EC8bL80hATjZI3PVJ70kZUthvvgrqmh2ouZyvoHkbU2HO+xZBiBUnK0IaVhwW3pf5zpsIUAM25VR/dEwafzPiKIkOPzPYMBwM9UMc6DYzzcLVDSRNRDuA+OsgFxezgFZLQY7cZW7BrsQu/CKZ+UFYhjC40N08Czrh2Iozgd5+G3Z7L+QSSSoFt7fAkvX2sLSVanQe2mKu3fC5/kNG+C1391tmH8kosMVca2mq+KnLy9FGVT6e+ysprMbGEChXZYUg8OZDn5aYFbR22iLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynyE0qZZkknjz8VmCJ2CEOA40veAn2mQ2IfTDcsxRUU=;
 b=QJpEXKwTK7U3a6GaQykFyAQwpNOFosZiUnJRc8PXSwzz1NdlNzC7nTbUWf35jZ4iYm+DlPp6PblONhXkStydn0QDJfRdI/3WTJQQLbxKP6BDP8f9WGNeq+sDjZnt6gMurEwTaVvsu/0qgxgIyKXx2bM2XJ4VP8y0p5/BpfyVO76ji9EfhteHjAPqU3TBT4k0Rk7IgqffnNIYamFpn01UWHZXtx66rVsd3Wpcfwha5fSf54QXVxBaO4jO03WEpmd5nA/Ii4iTeoqn96D90EFGgsyLL63hmgz8nPxYn2bpu3XeyLrLKKCxG+e6VGbFl3d6xblkL2Uhg5gCXe8SJAK5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynyE0qZZkknjz8VmCJ2CEOA40veAn2mQ2IfTDcsxRUU=;
 b=DobmsUNUP6iMbTPwF84q9sG03a9pkeUHTAJw7NHcKnlKV9VyTT8O36sRvrhR4/ErnKlG2RhD1e4g+H3Nm+00sapm/8SD+z+E1zZqQsKA7MOdVon7uArHcTaqsy5L4EG9Jh1PMWB3863Jf+Pw004yYKCwZXAn7l81Xzn9/s9CiwY=
Received: from SJ0PR03CA0224.namprd03.prod.outlook.com (2603:10b6:a03:39f::19)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:19 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c7) by SJ0PR03CA0224.outlook.office365.com
 (2603:10b6:a03:39f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:09 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v10 07/14] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Mon, 8 Sep 2025 16:48:39 +0800
Message-ID: <20250908084846.1873894-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c10f78-e052-4cd6-813d-08ddeeb4995e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FUWxEQ5heC5JxGvuUFBwK5XMPECAMB5dPUxqHdCfWvbi3G1cg/dqzfIEme2P?=
 =?us-ascii?Q?+23ibH1QQWFi4KuQp2mtXOj6QxoPy/Bxnw2r1XawNgUTgOqr5ifbU7iHAVjw?=
 =?us-ascii?Q?/ob7kcE7F9K2Ag49R85Weqg59ImfdOCZXFTEZbq8fho8zbUqy+/OLiIWca5u?=
 =?us-ascii?Q?aPsESW2izH3pUhBgUqpJCXE1TgJxoFGbtJh2Qs4PKcqo48mzxV2tBsLIfXzh?=
 =?us-ascii?Q?dt0Z2N3ZNKFU2zFvqlmS4n57d5tL3We7Zmt5oHK5+yNOe4lYSPhbWi2QZ8jb?=
 =?us-ascii?Q?XxEoUK+1WV/J5+6sZA8eDfyrD3o3+HIPKC7AT9MK8945DRRJRuJGa7dnb/Vq?=
 =?us-ascii?Q?FYzPfDMdPwfY7/Hcdl0of6U2BsclXuohBfrxbFTRru1qfk21VFAtrqPOjZQ6?=
 =?us-ascii?Q?AeJwH0MJKGE5kCl9uQU3PHayhDdqYYgddzot23mkRlJuhcQZA70nTWwByPIw?=
 =?us-ascii?Q?2qAGCJ4jdTO7Hvfzn1oriY2CDCWXHOuwTel1gdyaqBma2mFfakjx5/T44ees?=
 =?us-ascii?Q?ULMxtaHid7tKtz+UQMYa1cfKdJaHJ5FqyPdHqWWUo8vaWwEaSLcQ6n6FO19/?=
 =?us-ascii?Q?J7XIFA66zvafMTRbGxrQktGcPZMd8AmxcUjeZ03MCtS1i3wTtGKTYiQiKA2g?=
 =?us-ascii?Q?54l+RIsZhxhATQ8OrdGNDDczosIRU2JOssin5lYgmpEuPM/narP16c/mNA6A?=
 =?us-ascii?Q?qmaeup5XIKSw8XHf7j0SfpdIRZspsFgvlyQ5d9HHjyg4v3D8FdCbDvBDptdi?=
 =?us-ascii?Q?GesoSz5/oBepPRX0V2BPfS/TspOkKl1qImMcmmZOHTnCnHMRTrMYYmh+4NAr?=
 =?us-ascii?Q?RF8tkR02DpI1cf0CoWJeZmPd7/7bOiqY3Y01pJ30gLsslcGFT+4itVgbwJtB?=
 =?us-ascii?Q?AbFr6wj9n86l64yyUmMFu8jY4yqRJqfxjLFjJcihPwd5q36LKYHa0y6Lf6zz?=
 =?us-ascii?Q?n7BItTpyM3vqgaqNM5IS6Y3IBGr8gQORsSU3R4CkGZ92wQmJnnMUjdcdkgPF?=
 =?us-ascii?Q?Y/9TNAuRDnH4cCiA050zzltr0Ovt/+14gCj3XB7ra1MO1mFKafOgAiABA+PM?=
 =?us-ascii?Q?4J6S+V0fHBkyCW6h/9DxxvhbWlOywayo4ER5E/duZaCJg9miNIPUoFWkmmpw?=
 =?us-ascii?Q?Xljh0iixdvt5+Fz6tYgDZOi30sa4PY4zVNmF8MWfGdBeJ/Udo1iWaXGnyGI2?=
 =?us-ascii?Q?VaSVTQD6DcrsWipgi1Lj50KLYsiGurUlTwCD5PwJYNQZb9NSx5npQnOchjc2?=
 =?us-ascii?Q?362Ser2pvgOYtTGgL9pxhTOwWhIDrS7QPk9+4zVpqL11gNdh73V5W8rpUnD4?=
 =?us-ascii?Q?gfDz1tMvxm6HRhfSiA/HdMapwjd/hJ7P14MSBpvqkkdE1ZtIJjCGMETYVrRY?=
 =?us-ascii?Q?8Qdt+jnAWJ5poaMENLnPHlIIie7Zbgviv1Cv0WP2BaNxhPe+rxU1vO7UQser?=
 =?us-ascii?Q?GmYWHa/aadlcFhtrCHgp7d01yMlfNlAwOq655JZdTQUqz0TQDFUw7TMOEefH?=
 =?us-ascii?Q?4fjc73NMROW/4YRLeR5qmmdpbU0lLEobuN10?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:19.0236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c10f78-e052-4cd6-813d-08ddeeb4995e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

It needs to validate the userq object virtual address to
determine whether it is residented in a valid vm mapping.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 40 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 +++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8cdb1880315b..739135c3f450 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,6 +44,38 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+				u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 user_addr;
+	u64 size;
+	int r = 0;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!va_map) {
+		r = -EINVAL;
+		goto out_err;
+	}
+	/* Only validate the userq whether resident in the VM mapping range */
+	if (user_addr >= va_map->start  &&
+	    va_map->last - user_addr + 1 >= size) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -399,6 +431,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -ENOMEM;
 		goto unlock;
 	}
+
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE ) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+		kfree(queue);
+		goto unlock;
+	}
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 743f08c9bd71..46e927df67c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -134,4 +134,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+			u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..3bf328eb7b69 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
 	struct amdgpu_mqd_prop *userq_props;
+	struct amdgpu_gfx_shadow_info shadow_info;
 	int r;
 
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
@@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
+	if (adev->gfx.funcs->get_gfx_shadow_info)
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
 
@@ -247,6 +250,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+			goto free_mqd;
+
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
@@ -274,6 +281,11 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info.shadow_size))
+			goto free_mqd;
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -291,6 +303,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size))
+			goto free_mqd;
+
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
-- 
2.34.1

