Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A61C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 15:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D1610F30B;
	Fri, 21 Aug 2026 15:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDXuf9VY";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A4110F30B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 15:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQAUYk2dZUHAjyGlm44BKdqDKc9MK0R66SUIoDUnfNY48Ei69hMXL1PZjx/oXXUSDtmRptcVQ00V+0Rs8M5EqEQg8XqRbC/xKlzTdO57ryUJJPfzDEni0NK4atgqoQ2LlE6bpA2vPerO4DnKmKtQXEwqWPP/4njaFBhRAJtttYwC44C+GeVBCTFjps7bthxc6NuJ24bsXgl/MM4VbnWwe/G+E3hIP4A5BqBIJ0reYx1iGUn8lirIliu3DnIkFVpoEkjg7PQ3kgGJJSGl5t2jpsW9vwImoURuz2VvVTvh9OfQAquvinVKchjXAfDkwO5jsh4bKFpxdk4cjXGwK8hdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8UWk+o6ZLBdzCEXiWHkwBC3IXNRsQMgdP17DQ/H1wo=;
 b=YEe7eXhJ+RiSN+V/9us17a6pscJ5z6KNzM/a+QclX9QUs19TZCc7poP2fD7SdyYnJptUjVzwiO072V9k7ayB/VVScbiaSIkC3j570h/QAiOSsxApjul/RyXpxd0R1nMV8lc3ancilNPXV1LgHK4ZQeyXDaGJxyCCyxur0u6unhLqGOiO+/5yZOIJFeHFbxlbGZSRo3arAHJyqrtb6HqSdbUuWKFgX2+QIil1VBjC278jnJME5y/TbTaNUOG8u/K0rGK489ktOOhsYOSWUH+w+QHjpW1/c65KXvdjBqP893lDAPWxFF6PIiloKs0l5ZAZtfFsuLlzMxHoLb/fMdRv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8UWk+o6ZLBdzCEXiWHkwBC3IXNRsQMgdP17DQ/H1wo=;
 b=lDXuf9VYdg26myNaeKChucTufGfrjCRm0bswTVcBArRPrFgiE5gnEFSTBU1LDZkB1mgZNfxTvSIduNCftZ4KH2we+4e9/GTI0C5S1z225QGGCH6XmpM6PIMaaUswtSDdt62Sl5Ig4cv5VHhzPQtLGKQ33H9EuvBzuEdJSybHH10=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:29:47 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::8a) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:29:44 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 10:29:44 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, <Christian.Koenig@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
Date: Fri, 21 Aug 2026 11:29:30 -0400
Message-ID: <20260821152931.3493933-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebca9de-51cb-496f-d044-08deff990745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: G9C5qPlhOkeKYhN95FUyRFVbMKwvFRL/2Hb8BWKCJh17JV/a6buaa+NYmSchnMCX4BH4vh4mn8yZ2fMLe9kBRWnDEMcEhBFH9pvHHp7t4pNdKT4aryrYxz9d6VagmbbTl7l5CoVvu+53k5gngxj4YwYtriArlaCH+DbRJ6ctnz2WXNPdFXQJPWM08loxY7tI3R+OQxm90waaqOzbYS/NUGF986z2vPziOw56dG9qi/Hd4+rvhHpHCrs88VcnvMBPcApEktLnMtNy6DV0pcKQJ3y5A+io/NsTiCB4mro/HYsXIV/1HjR/EvkTuhb6Tkj3sdMmYxvnm/EoN137PgSnTTwt8LChqLO/gOMhYxlOoMWwoQret9M15zIlxlI8I+o0lO+KVc1QGEYWr3tVpi51ahbhIqMKr8amY6M+3Dm+IMLG6hGNXD8zgR8p5ngkqdhKygSfCBm2ITJ4JJZQo9ki3utU7QSIx1P3JkxIl50rWD9pbRWPQBvLCxpbQUTPvpJvMbO7PvqLa4lc0sCP7Ptf7O0WPDzVtlXy8OEeCzjeBmMqxAY3KzWTUSTCvmR1Kx87CwwUVogcH4HDcE6OnO8ErQtXsb76OsV1JyL+L0BGm+WUsw+mf/+XLvh25L/p+SPp0MkQZqsrztToCjEFWIZHF/xFCcMyi+tOARxDBtwFKeI21CBaRqsgrHGTOWywspl8dZlacemQy1pZ0YMCKnCG1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RJjBLoMqzWhAeiEIB2gPKMtUKeuUXn55+FMvFDkNRkJ5EPdSTP4wV9rby+rOY05HqNwc4lJKdbYEAa31waBkuiqk27CYvueRBCxLyhzFTQy8IUT1LtMMGIMhCn+Ofsgrg+dKPGrjwKtKNulLJ7gWXuPY7mZQgbuq3nAa41Ihn/xtt7/5Y3dShYMAAfu+qdWP8sGDfONsU/8eH78+KeEnK9GyPs44e0vfSVGU/2JOArBQgGVqXBB42os90XNJqEF78VoG+aQZBGVtkrM/rY47uvjpF7c4qpyzg0pmOavC5eQvNYSPzigmpQn/r3NhTjUbcjDQQlBbD2K4BrDiYeM21dj0T61m5wj+rwFvkWUsMRHD4hzXALsLWmDeeLBuRLtvvidKje/M68x4CIuQfq9yl28ZpN2G7OxPLzuiVp2OnVYh9wI7+bSZKM8zTxF2I0S/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:29:44.9416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebca9de-51cb-496f-d044-08deff990745
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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

