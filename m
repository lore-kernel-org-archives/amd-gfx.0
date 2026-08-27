Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02210C61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 19:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4835D10E1F5;
	Thu, 27 Aug 2026 19:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NBEH3tB4";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8FF10E1F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 19:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2l8xwPhf54JdjvCczYuzbxjVTJ+KW1S0NYIMjqaJg/feHYAgqgNovw+mBDSCJqFcNUYPBv7TAT7Ku0FJ/Lww33aQWMkYArzoRMl1vx2LMA4VpNQ99qH/VrqT9Hsi0vLPZd8rCMYJIjEyYDQxNVwzLdGoq57EuqjGbWjJu3u7EpMUgTZTTVPc1+LgBmgYiNVWiPXN3P/mWRb8OPhr7QgsLBz0m8OSCLRJ+c4OIxdC/DXUJQ9ZkxenRusT8u/AwKLw5i0BE6T0/1BA7mlN3SSeEdI3KuU5YWVr4ufPxdFncVi/0kzt+RxLlig4AffjPyaeQSoCmlJVBSLCv1Y6z+q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8UWk+o6ZLBdzCEXiWHkwBC3IXNRsQMgdP17DQ/H1wo=;
 b=UH3BnH97agC58TlBiIQA5ovTuSOPA634D4qT2VHaZ9Yx0cTeSqvlh6KiCC1G1yUjOC2jIdausMrA6E/KuFogAvmM1owfXQPdMfGw0LjjZQVRDx2dGHMbtmxvjv1NInPeDC/Yz0RtZcMcTemXB89jKJmOSuHYcloPyyBWUGkGYGfqtnN1u/LM26tyQV0Ln2syh6yl8WWjGpf0u7zuAgpovYONTeiRYoZrygx8S8rt4ovgvSujxtjD0DZTlUHtwMajc5UAxdM0TbNz66ZJdbCctDUeFbpF1ng6uyjesnqJwgBlnb/7pUiXkjgTf0QLRW7RnDM23ZKNC7iVeReiPThZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8UWk+o6ZLBdzCEXiWHkwBC3IXNRsQMgdP17DQ/H1wo=;
 b=NBEH3tB4Tke7LWDbIN21MPTDRZnlEEjzkaXxdTyhzziN9GM1S4dYYXAUPnNji3zw5SzXB3Q1aF06NmTqDxEqrOnbzjNya4i99ODx/KgeBpuXVRptdZ3imuy7YOL/OKp23SXIvzyz8ROmtzhztUNbUc4E0wm9OyykmKNbWYFKE6k=
Received: from MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:59:53 +0000
Received: from BN6PEPF00000076.namprd03.prod.outlook.com
 (2603:10b6:208:235:cafe::af) by MN2PR20CA0054.outlook.office365.com
 (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 18:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000076.mail.protection.outlook.com (10.167.248.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 18:59:50 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 13:59:50 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
Date: Thu, 27 Aug 2026 14:59:34 -0400
Message-ID: <20260827185935.89623-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000076:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 82414f7a-27ab-4d60-ccac-08df046d5f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: fxTV4gaH6oH+deUdJGA6H96hCjXNEfHSZhyC9ocn2uD423we3ZCSRMEywki7D6bzjOdDO7vhWpwxuo/co7qrMjzisyPkq4WTCR7WRfINRuIxpf/cZYAhbTgu1azD5RSZbc9JoyWAJ+u+o4U948fjJPZWF/EU8OZDXsVAMaWS1drhehHtpbh5NGN4oQTQ3H/GHZeb1gp66ujRxYLopkcY8DEX8ddF6wCeYj26kO2D9sW7i1rf7k8d5WU5Tv4Ck4v2TeNDr7q/NM2qN1xSZoHIoIHXzQg1fb4x1Cfu09suTT41oXN+4VZhgKriD1FbWMMatUSTnJYX5XgWIL6HXuD3ueProSDc7qnICRR09M91CgqDwHZVpb+8LaXclflQdueeveXCQGjxTG3ZDYSnLxllTDC0Y/RtVhGqRr82tUtiUzd7fiHSLCc2qdLsWOabdPr0ImVVzFE/nzhcGK4dKyHZnNe+M7BKjsIqPve/RvNLWZ0HNzxdV45jt8lXixU3pd2B1G6yBS8SjyWFIXDC4ZL8QpAn1nvnqq0dXWTU3fjk1qRDVSkqdkIjXdw9qCM9I2skwvbghUo7jvhiGMbGyau7X3usY6PJSNl+Qbe6x/trMlZMlmokO6Xd2GVke8asGkZb2kumX7bKwTOM416qB4BfyCw7ZbpdA0wx+C91/aE33z29VQHo11c8WwjYbkv7dBju1QI5ZneU+QLuAfyp2dNMgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JJOPG+i3PhdWl3IywWTZy6pPrO4HZQyM6choDe2iYbuCCDNfNtvZvxRKokkPR9CPtq/C+Jf1hl/8j1KVUghW5YfWJIchB/mitLcgXw6EFwiiJmjWOpgNxMM8FaatonRxE+yNh2FP3gHGASZTtgDwLGzmECDm+NyMzgit88l+HcriixvtnVWSdKQPsIFqe8tgkbOl1uc9KRNON2fVQ66A+U9oOAjtsRTDcHNYS7H6a/UMichfVywnU/YS6UmkGuw8obze+KpZtfEGauhR47hdGvp31Iw+1WQV862dUe9iYRrJelbcRWtTWBlr4dh2Ki6icDOtg46feS8G0CayeFNlAlsvsOG8S1fb9QPB4LUIbrk84CvZGVG2ZeZH5L+M2oEcKOiaw8js+uWcI6VkryTiHuQ37XrVJKZU17YW91r7X+fg97EIHDL4VfeGJBTScOi7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:59:50.9079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82414f7a-27ab-4d60-ccac-08df046d5f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000076.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
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

The interface uses retries; the user can guess at the number
of queues required; if insufficiently large, the correct
value will be returned.
The same is done for the mqd sizes of each entry.

This operation holds userq_mutex for its entire duration
to prevent the queues from being freed or modified under it.

v3: Don't acquire xa_lock and other misc fixes

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 160 +++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h             |  40 ++++++
 2 files changed, 197 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3fe10d6af757..32d1787aa7e2 100644
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
@@ -857,6 +859,157 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
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
+
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		num_queues += 1;
+	}
+
+	if (num_queues > args->list_in_out.num_entries) {
+		/**
+		 * If the num_entries buffer is too small,
+		 * return the correct size. User should
+		 * try again with the right space allocated.
+		 */
+		args->list_in_out.num_entries = num_queues;
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return 0;
+	}
+	args->list_in_out.num_entries = num_queues;
+
+	if (num_queues == 0) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return 0;
+	}
+
+	entries = kvmalloc_objs(typeof(*entries), num_queues, GFP_KERNEL);
+
+	if (!entries) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -ENOMEM;
+	}
+
+	ret = check_mul_overflow(num_queues, sizeof(*entries), &entry_buffer_size);
+	if (ret) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = copy_from_user(entries, u64_to_user_ptr(args->list_in_out.entries),
+			     entry_buffer_size);
+	if (ret) {
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		/**
+		 * The xa may have added or removed queues since we counted
+		 * them, so break if there are now more queues than entries.
+		 */
+		if (i >= num_queues)
+			break;
+		/**
+		 * Check mqd size. As with num_entries, return the right sizes
+		 * if they are too small. These sizes also serve as
+		 * versioning for the mqd. Despite the names, these are the
+		 * mqd sizes for both gfx11 and gfx12.
+		 */
+		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_compute_gfx11);
+		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_gfx11);
+		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_sdma_gfx11);
+		} else {
+			drm_err_once(adev_to_drm(uq_mgr->adev), "Unrecognized mqd size in USERQ_OP_LIST");
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		if (mqd_size > entries[i].mqd_size) {
+			entries[i].mqd_size = mqd_size;
+			entries[i].ip_type = queue->queue_type;
+			i += 1;
+			continue;
+		}
+		entries[i].mqd_size = mqd_size;
+		entries[i].ip_type = queue->queue_type;
+
+		entries[i].queue_id = queue_id;
+		/* userq prop handling */
+		entries[i].queue_va = queue->userq_prop->hqd_base_gpu_addr;
+		entries[i].queue_size = queue->userq_prop->queue_size;
+		entries[i].rptr_va = queue->userq_prop->rptr_gpu_addr;
+		entries[i].wptr_va = queue->userq_prop->wptr_gpu_addr;
+		/* flag handling (AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK are the only flags in use) */
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
+	if (ret)
+		ret = -EFAULT;
+exit:
+	mutex_unlock(&uq_mgr->userq_mutex);
+	kvfree(entries);
+	return ret;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -891,7 +1044,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
 
-	case AMDGPU_USERQ_OP_FREE: {
+	case AMDGPU_USERQ_OP_FREE:
 		xa_lock(&fpriv->userq_mgr.userq_xa);
 		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
 		xa_unlock(&fpriv->userq_mgr.userq_xa);
@@ -900,8 +1053,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
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
index b32c72a662b6..92738d630eea 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -332,6 +332,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_LIST	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -425,9 +426,48 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+struct drm_amdgpu_userq_list_entry {
+	/** Userspace pointer to buffer holding mqd */
+	__u64	mqd_data;
+	/**
+	 *  In: Size of mqd_data user-allocated buffer.
+	 *  Out: If mqd_data was insufficiently large, the
+	 * size it needs to be.
+	 */
+	__u32	mqd_size;
+
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

