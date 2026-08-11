Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4E0C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 14:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B8A89864;
	Tue, 11 Aug 2026 14:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MtwWqFqW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8CF89864
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 14:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SggHpkvUH9V9FMHxTUQ/t57ZXzlyy2LnqOXAe0j4+JozHSUFSuGm68RPO9rulmbMHMwJj8K7ujlS/pe00cV/qQ1LxQy8XHLe/bO0dRwmNmrkjI5BQ/+9WnTB0oPbopxTaOkXGrhuyLZ/zO5UlozgIQyy1jq05ctAHd24NM8qForJRXM4bpf3FWdXsPyapmjxw3pgsvvQr9yYQn7q+ZHMWiiKeOiu7drZf+oMLflyr/9JcAwuIqMuL1LmiNF5mDfmxknAf/V/m4Hafz/VQff5RbIMGU+SwQr/s3YYJuMLo96m5zN/u6KgvH0agtJBSPkAzqvJOllQQJJd4MmpiOXcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKc91EEUkPfyRmPgk85lPV3Txfg0xnTrk3lZjIBjxbs=;
 b=hgGcNkOMG5CTGDbsfk+/kGhTK90YLCWx9UoXksI6ggFgkDEbcwYSf8MC1osXiqCH4MxBm1nSJ8ZcJWtv5p/UtwYZ5cZONfRogNfDcfA+CU7+ySJfEqRLNxYAMpa9wB9QjqFYnrNelc/tToUlx13lRY/z9ZTdHoPgLX6nzzNFoQ0qWKQAKwbKahWRgZCPwRPO0neP24dNPHDCuZA8odKKQ/UDck3tLtAaiDGDWv2I45wdyK3+OR29B9tEDbTY6VZZNZF9MP5HOaMgQ3SmBiaDDAVAET+zwU/tTjLi4Mbrk6egfR3VH/pqftb5rDWeCwmnY68uaHqhKeK4fyNKdaYYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKc91EEUkPfyRmPgk85lPV3Txfg0xnTrk3lZjIBjxbs=;
 b=MtwWqFqWuuLQ6H5SIzA8nmy60mh0u+5nvVd0LouR6AniKoj4l7dW+Zk3eH22ti7O+ZVMHBkgayBXFjykoO0Bic6nY4Rn+tkeUcm8YwQqp413P2UPcb0FwxPQr4Wn6hUb1ibuFFeXxrgtNSDFj2OslrGabZqql2i4iwI4DCBwnGk=
Received: from CH2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:52::14)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 14:12:16 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::78) by CH2PR04CA0004.outlook.office365.com
 (2603:10b6:610:52::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 14:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 14:12:16 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 09:12:16 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
Date: Tue, 11 Aug 2026 10:12:01 -0400
Message-ID: <20260811141202.1633727-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 117def65-9723-4c03-3b87-08def7b28c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: iknRPwEbPWx+N7uHGrwA3QUZe7uACDVrdu4Z8tQwT06Beb6SByULMukpJxcrAt1oFm0gK3Vczef/P0fmCgGNI53bwHmnyw/b88fePO5j337FtqX/U++eWZtPyKSzeQ0jbZVH2KYVMDZwl9ikTM2TISjoZNPQirtc97qM8I8Sgd7Je9mFLBsCEBqWk5wB8DV9mDGVcD+gzIDxlm1KdfjELzN8SOeg+3mnx3SWwuQN6zaHKOJCv4GiUDRog1S0uD4TsIi/TK2eGsb0fATZoVxbLw6PZScRoSvNaBU333PQqo79MHTF4iCQQeslalHlOSHKwPI1jfHNHFw51Kp/hwch+eNEtsYUyfwh5J5V8F9E1T98NmZOBc1UydfDCpJwiabAnYRgNgajHafOYX7/OZUaOQj4Rgv1biWBPYMNn2nn9aYuQElnxLIWvPwOdRJelT5r9PEcKLfXosjcwCzNeNqw6n4PPGpYJG+rMquCRBvxZ9VRY5AmvP0f0Iaq9raph9NjjvFWTzpktV0JF/a5Ax52x8U9jUVuvEM/Dj3Pk/mSPjuxpFSfZL+SKoAfEzGYT+gEr83Kiag6bHlazartXnJWdlaMi5PsjFqbY5MxRowysOTJZk6hGC9BV9qHxJhKa6EDHIkhAzUWZR8broz48nXHA1seveITeyYCN/l8SkdrsYBS4AMdCgP76iC4eQDADoO/PhieXolZto4k3BGfXXktAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FbGuHHOQxDGASsHQOpPBKb5lJBLyZOpSrvWooEFMNBJWHBqwzqzPKo1FBdaqkaPFdgfxQ5J0Jj+p8f1KQGQWhXqbV6xgA+XaX9TdkJ/iQWJ8p1agiTs19xVU6xR51QETE1/d1ce8ArotO/vjozdSmY6jRnhs58UfvjYGgktuNALJ38EQvLxDqeobD5LcygEjwA40wD3ib3ZCQvPxAecusdN1WZEjhJeqqZLfpkG99I1KV1BNUfqcrJpekxMDU5LP4uTo4tcEt4zu+sZZJQ+3zK4XoE3DC8m6NhsExxTCB9YsjK+BDs6oGdN7A4OL7XYNEEhk+avrnLT/rQ7uaI5h7wnn4vDSVuLBLMZZWQT5wfjD6mWei2mLvmsQtmY2v68QaFcPMlpttZgJxX/urzbLevrqyZEMgMRwCMJIS/7Tdu4VNJbn4IaU5kRdscRuDLTk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:12:16.6237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117def65-9723-4c03-3b87-08def7b28c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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

Add a new option to ioctl USERQ which provides information
to a process about their own user queues on the queried
device.

The returned data is in the same format as that used to
create the queue in the first place.

The interface uses retries; the user first sends a request with
num_entries 0, then receives the right number of entries.
The same is done for the mqd sizes of each entry.

This operation holds both userq_mutex and the userq_xa xa_lock for
its entire duration (including for copy_to_user, copy_from_user,
and kvmalloc).

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 162 +++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h             |  39 ++++++
 2 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3fe10d6af757..3c930425c1bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -850,6 +850,8 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		    args->in.mqd_size)
 			return -EINVAL;
 		break;
+	case AMDGPU_USERQ_OP_LIST:
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -857,6 +859,159 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 	return 0;
 }
 
+static int
+amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct drm_amdgpu_userq_list_entry *entries;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id;
+	size_t mqd_size, entry_buffer_size;
+	uint32_t num_queues = 0;
+	int ret;
+	int i = 0;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	xa_lock(&uq_mgr->userq_xa);
+
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		num_queues += 1;
+	}
+
+	if (num_queues != args->list_in_out.num_entries) {
+		/**
+		 * If the num_entries is not the number of queues,
+		 * return the correct number. User should
+		 * try again with the right space allocated.
+		 */
+		args->list_in_out.num_entries = num_queues;
+		xa_unlock(&uq_mgr->userq_xa);
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return 0;
+	}
+	if (num_queues == 0) {
+		xa_unlock(&uq_mgr->userq_xa);
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return 0;
+	}
+
+	entries = kvmalloc_objs(typeof(*entries), num_queues, GFP_KERNEL);
+
+	if (!entries) {
+		xa_unlock(&uq_mgr->userq_xa);
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -ENOMEM;
+	}
+
+	ret = check_mul_overflow(num_queues, sizeof(*entries), &entry_buffer_size);
+
+	if (ret) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = copy_from_user(entries, u64_to_user_ptr(args->list_in_out.entries),
+			     entry_buffer_size);
+
+	if (ret) {
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		/**
+		 * Check mqd size. As with num_entries, return the right sizes
+		 * if they are not correct. These sizes also serve as
+		 * versioning for the mqd. Despite the names, these are the
+		 * mqd sizes for both gfx11 and gfx12.
+		 */
+		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_compute_gfx11);
+		}
+		else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_gfx11);
+		}
+		else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_sdma_gfx11);
+		}
+		else {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		if (mqd_size != entries[i].mqd_size) {
+			entries[i].mqd_size = mqd_size;
+			entries[i].ip_type = queue->queue_type;
+			i += 1;
+			continue;
+		}
+
+		entries[i].queue_id = queue_id;
+		entries[i].ip_type = queue->queue_type;
+		/* userq prop handling */
+		entries[i].queue_va = queue->userq_prop->hqd_base_gpu_addr;
+		entries[i].queue_size = queue->userq_prop->queue_size;
+		entries[i].rptr_va = queue->userq_prop->rptr_gpu_addr;
+		entries[i].wptr_va = queue->userq_prop->wptr_gpu_addr;
+		/* flag handling (AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK is the only flag in use) */
+		entries[i].flags = (queue->priority << AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT)
+			& AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK;
+		/* doorbell handling */
+		entries[i].doorbell_handle = queue->doorbell_handle;
+		/* This is the inverse of the calculation used in amdgpu_doorbell_index_on_bar
+		 * doorbell_index = db_bo_offset / sizeof(u32)
+		 *    + doorbell_offset * DIV_ROUND_UP(db_size, 4)
+		 * db_size is always sizeof(u64) = 8
+		 */
+		entries[i].doorbell_offset =
+			(queue->doorbell_index - amdgpu_bo_gpu_offset_no_check(queue->db_obj.obj) / 4) / 2;
+
+		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+			struct drm_amdgpu_userq_mqd_compute_gfx11 compute_mqd = {0};
+
+			compute_mqd.eop_va = queue->userq_prop->eop_gpu_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &compute_mqd,
+					   entries[i].mqd_size);
+		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+			struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 = {0};
+
+			mqd_gfx_v11.shadow_va = queue->userq_prop->shadow_addr;
+			mqd_gfx_v11.csa_va = queue->userq_prop->csa_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &mqd_gfx_v11,
+					   entries[i].mqd_size);
+		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+			struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11 = {0};
+
+			mqd_sdma_v11.csa_va = queue->userq_prop->csa_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &mqd_sdma_v11,
+					   entries[i].mqd_size);
+		}
+		if (ret) {
+			ret = -EFAULT;
+			goto exit;
+		}
+		i += 1;
+	}
+	ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
+			   num_queues * sizeof(*entries));
+	if (ret) {
+		ret = -EFAULT;
+		goto exit;
+	}
+exit:
+	xa_unlock(&uq_mgr->userq_xa);
+	mutex_unlock(&uq_mgr->userq_mutex);
+	kvfree(entries);
+	return ret;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -891,7 +1046,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
 
-	case AMDGPU_USERQ_OP_FREE: {
+	case AMDGPU_USERQ_OP_FREE:
 		xa_lock(&fpriv->userq_mgr.userq_xa);
 		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
 		xa_unlock(&fpriv->userq_mgr.userq_xa);
@@ -900,8 +1055,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_userq_put(queue);
 		break;
-	}
-
+	case AMDGPU_USERQ_OP_LIST:
+		r = amdgpu_userq_list(filp, args);
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b32c72a662b6..678f3d531df7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -332,6 +332,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_LIST	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -425,9 +426,47 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+struct drm_amdgpu_userq_list_entry {
+	/** Definitions same as drm_amdgpu_userq_in */
+	__u32	queue_id;
+	__u32   ip_type;
+	__u32   doorbell_handle;
+	__u32   doorbell_offset;
+	__u32   flags;
+	__u64   queue_va;
+	__u64   queue_size;
+	__u64   rptr_va;
+	__u64   wptr_va;
+	/** Userspace pointer to buffer holding mqd */
+	__u64	mqd_data;
+	/**
+	 *  In: Size of mqd_data user-allocated buffer.
+	 *  Out: If mqd_data was insufficiently large, the
+	 * size it needs to be.
+	 */
+	__u64	mqd_size;
+};
+
+struct drm_amdgpu_userq_list_in_out {
+	/**
+	 * For operation AMDGPU_USERQ_OP_LIST: User will provide a buffer, which the
+	 * driver will fill with information about all of that process's queues on this device.
+	 */
+	/** AMDGPU_USERQ_OP_LIST */
+	__u32	op;
+	/**
+	 * Size of entries buffer / Number of handles in process
+	 * (if larger than size of buffer, must retry)
+	 */
+	__u32   num_entries;
+	/* User pointer to array of drm_amdgpu_userq_list_entry */
+	__u64   entries;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_list_in_out list_in_out;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

