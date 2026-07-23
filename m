Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39031C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 18:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D0210E476;
	Thu, 23 Jul 2026 18:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EyFYNYR+";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407ED10E5C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 18:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJd7fVyLxfWGMu+NF+1HKca86eWpSRiCRoEZ9ed8YJo2XOj4bt37Sz3qV3OWvzTo0o/wR1mMeM9UfFOv18ub/onkxKJ7qrIFSBie9CoOkgfezrwdJYkTej5E9EiqbPKYWVzVf2zHnw/7EHJqOD8FKDqt0+g0WykVDq9x0XmE7zKZ7UquZ2Olpevssx18d91zjL41PBJ1+ibvDzOF+8f4wsXIAwMw1mEOMQ4kQ3Xfgt4+5FggFTmTHpyCJLcM3YRYCTI9BlroGoDvenmN+wrlgqoKedRqXEqdvpb5d89gR8i0//wYJ0CUBrQIBQhYLXumIQ8nrKPlNw9j5CC3lcFAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK5EHkaK+iW0RVpaJmLyvEsLPV2qDZ6NTfu+lsMM3ko=;
 b=HXMxEbNw5Nspb8P7NunYILdK0IUgOlufPLSzmgWA9EzbNRLSmz2f5q2c7A4+EzDt/OkKxBZcMeLVWQVr0IsJXjm2iOxmMVco4qLWPBoBOc0Ix7xoSNFVOFn1BSb+TKpTdiSCdZD5CqkaerCgzbJ5C7REyUQDafe45qgPMhaQnyXMsd2sddABC2AMmf6Ph0XlQ+DEAknfbkcRWpmMGpDC8JseSMJ+xBbpa9r2bBeXnt8FBluZXNzNNP49I94bijJOkggGOsWWQlalqCO78+O5ht0FY9DYBq3QUyR3ollX8HP2A0SCaxE63jvXTj3CgvSTIarhaVTnydIkWJUaTR4CLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK5EHkaK+iW0RVpaJmLyvEsLPV2qDZ6NTfu+lsMM3ko=;
 b=EyFYNYR+61eCn3Gv3s1fxcG1k0uUTtUyxyg9n6yz/eY9ftbCFZJcuD9ScecSAoJkzl03aSV7685x78Ro8s3rVFZHsgBm074dVa+zCsTGhWd8LPrMExdXTPl8jbuupV8LhEWl9vC8Be5qm+JxD3tB1E0ZyKDj21759chD7uf3gKk=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 18:51:05 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::59) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.6 via Frontend Transport; Thu, 23
 Jul 2026 18:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 18:51:05 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 13:51:03 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add LIST option to USERQ ioctl
Date: Thu, 23 Jul 2026 14:50:45 -0400
Message-ID: <20260723185046.1239011-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723185046.1239011-1-David.Francis@amd.com>
References: <20260723185046.1239011-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a90c83f-a600-47d1-e6f1-08dee8eb59e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|3023799007|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 06fobDQJJ7J+XaEBIAbXkX5xtlalLiXUbWD1iEaAEhwmtx4JymhN2VbIqhznDZDkpbTtItJRzvZ8kKbQ9VKHUTJ5946cwxEwwmM4rQq2J8CAZ6EOThR5ZyEMgavHWA2H+n81LavmMWQNDOoQXLh6XWkT+sp9s6jwIqOBe3Enuv6mhRrLBmyUE1NwMuG5fbWOx3bK1yYwfU6Y4ArQpBSkzoLvccsWxZ7AfJRenwAuDCmU/ovqOgRTsIKCMaP47ugJH/AelT84liX6a3HmfFyNhTHoVEG1BSGzU6P/ltyRrzEvflB5GZ9A2Mfv0h9rsn9UOd3aCRDElbKakJ1nRuuYdI2UGCLcGw98u+b/OmD/4gE73Z16ekc5/xJOTZZl12TO94spENVVhT2Jj1v0lgb6PBtKBZjgTjIvnHffQ3WM5kdv6HgWkYc+0X8NEhmUrKJxRRCPp3s9EMcV0oEXjaqJTQTwFQfPdlLzRugKH2C+KAz6BXKiCtRU1fjJ8pDiBzU2COfeN85hbJ+BEYnrLkcLKB3G0r6aw9xHs/xARCb2hQ3YpayhYZlWR2lRqwypKrfWtoiC2nQ6vW+H1UXUjQcfGQpacAjPCdV9AcoSz84lyBvpCq0bVjyhptxYC8D2xSwlXo9qSeVf4Utg3snr9Lg/COOU6ObyQEadwynBkPAr927LovfYgdpviVocsqoyjz3sEEo09o/4imhAiMfdkLnQ5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(3023799007)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S7RFnPaJc9dMTVGBqVHZ/HBjp0ZWBOP4fSp9yldOzujNAeQlgDbq8GeMoFAqZ4oEl5GgtSSYUOFPcSQSjWerlWdG3qY+/uoQrxVuLD/3y8R/X8It7u/xsuOdL+nczFs67l/a5bmUpbbvIzr2SzES10v0KCs2Xcyo1kMlHWj44/LcGMt+dbMKnzYcaFEi8j23gbwru8BlTsFiFKykkqHJCG1LN1t/35zMjiDh0xuqz5QLvTbt97MWm+TgaT0rpD7fnHlI23B/HbrjHua5TseW/5wu+CyuERaf/NdphrKEC5XxMN8EGQpWvIj75BHwYfssK6PbwDSlLJ994Dk2rOhfx8z8jVq3X7n60qVGuOShl7wO4TjVFlMn3egDnzTCx7PoNSW9bpbiG+n7HJjMmJGZlE1LhH91SXL6gbRrXRgth3KMVaCWtxQUVKS5K3Yh4u4T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:51:05.5422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a90c83f-a600-47d1-e6f1-08dee8eb59e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 159 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h             |  39 ++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cfee7466ef44..b13ed7f8be7f 100644
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
@@ -857,6 +859,158 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 	return 0;
 }
 
+static int
+amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct drm_amdgpu_userq_list_entry *entries;
+	struct amdgpu_usermode_queue *queue;
+	bool mqd_sizes_correct = true;
+	unsigned long queue_id;
+	size_t mqd_size;
+	uint32_t num_queues = 0;
+	int ret = 0;
+	int i = 0;
+
+	mutex_lock(&uq_mgr->userq_mutex);
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
+		mutex_unlock(&uq_mgr->userq_mutex);
+		if (args->list_in_out.num_entries == 0)
+			return 0;
+		return -EINVAL;
+	}
+	if (num_queues == 0) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return 0;
+	}
+
+	entries = kvmalloc_array(num_queues, sizeof(*entries), GFP_KERNEL);
+
+	if (!entries) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -ENOMEM;
+	}
+
+	ret = copy_from_user(entries, u64_to_user_ptr(args->list_in_out.entries),
+			     num_queues * sizeof(*entries));
+
+	if (ret) {
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		mqd_size = 0;
+		/**
+		 * Check mqd size. As with num_entries, return the right sizes
+		 * if they are not correct. These sizes also serve as
+		 * versioning for the mqd.
+		 */
+		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_compute_gfx11);
+		else if (queue->queue_type == AMDGPU_HW_IP_GFX)
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_gfx11);
+		else if (queue->queue_type == AMDGPU_HW_IP_DMA)
+			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_sdma_gfx11);
+
+		if (mqd_size != entries[i].mqd_size) {
+			mqd_sizes_correct = false;
+			entries[i].mqd_size = mqd_size;
+			entries[i].ip_type = queue->queue_type;
+		}
+		i += 1;
+	}
+	if (!mqd_sizes_correct) {
+		ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
+				   num_queues * sizeof(*entries));
+		if (ret)
+			ret = -EFAULT;
+		goto exit;
+	}
+	i = 0;
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
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
+		/* This is the inverse of the calculation used in amdgpu_userq_get_doorbell_index */
+		entries[i].doorbell_offset =
+			(queue->doorbell_index - amdgpu_bo_gpu_offset_no_check(queue->db_obj.obj) / sizeof(u32))
+			 / DIV_ROUND_UP(sizeof(u64), 4);
+
+		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+			struct drm_amdgpu_userq_mqd_compute_gfx11 compute_mqd = {0};
+
+			compute_mqd.eop_va = queue->userq_prop->eop_gpu_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &compute_mqd,
+					   entries[i].mqd_size);
+
+			if (ret) {
+				ret = -EFAULT;
+				goto exit;
+			}
+		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+			struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 = {0};
+
+			mqd_gfx_v11.shadow_va = queue->userq_prop->shadow_addr;
+			mqd_gfx_v11.csa_va = queue->userq_prop->csa_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &mqd_gfx_v11,
+					   entries[i].mqd_size);
+			if (ret) {
+				ret = -EFAULT;
+				goto exit;
+			}
+		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+			struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11 = {0};
+
+			mqd_sdma_v11.csa_va = queue->userq_prop->csa_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &mqd_sdma_v11,
+					   entries[i].mqd_size);
+			if (ret) {
+				ret = -EFAULT;
+				goto exit;
+			}
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
+	mutex_unlock(&uq_mgr->userq_mutex);
+	kvfree(entries);
+	return ret;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -901,6 +1055,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_userq_put(queue);
 		break;
+	case AMDGPU_USERQ_OP_LIST:
+		r = amdgpu_userq_list(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to get list of usermode queues\n");
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

