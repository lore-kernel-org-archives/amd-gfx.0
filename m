Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A52A606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OEy6GG0O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1860D10E291;
	Tue, 20 Oct 2026 19:48:41 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9662310E291
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 19:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz+rd1LvhCPp+FO5olgojE3iWq6GsDd+SDGqWM0A5OUWekBrAPDsGC96bSDG0+X5eW6xugETc4Jl+0+3LyJUeKj/PeF4a5O6E0b1jRW1Uxt6231MiJ2/cpKewSQQGRhc4RRoXEIKzQepBg243/jIp2MZyCqmoGAWSNv4JiLitr6dT5aTC5yv47+JvemB7ZDbtbs60SDBy1GvI/4e+6viY23KPjy407eNmHQ4SvVhtMS5FLLnjuncvh+hClwMwkF0/MtdixiB9xU1YBztvcpxWeqgMAeh8G92lE3RYP1C2eJxMQdj5opboRLp3w9RqRqY4MaMJcSYNTDNl0Ofihyizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGhwynS8yrXYqMnyJgFuJ/Ta2bD5+Ov5p8Dg0PajFUg=;
 b=miQg7gIkYE0ogiPbjDCVZnBlgsctZr12wDhQf/euuZm8fYiVlZbburbroU+RZB5HVgM6yJc1LrE+betYxPrpv8vR0Q0MwOwrmiLqhS1GeEDsQfCxiDA6cfwlFiSETO4sTO2hhaMza0TGd7FjJtDBXFSL9zclNvzxMBNEBETolXjmf7jULB9vEMADxN2CVk7s+wsrC74A/bGxQz1DeJ+E/IWc6GhtiOkL0BJaMQf4GpMLS3C8b+qI0kFGTtTlrngyOmNY0j8Dy77zSWQvErUKZyZOnx/JQaoOtHo/qk+nhSp//Qedi1bjtxKd6xutKQPiunX7/nGsoZLdBdXmTS8yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGhwynS8yrXYqMnyJgFuJ/Ta2bD5+Ov5p8Dg0PajFUg=;
 b=OEy6GG0OuEdbNih1esJzyTLxl+vayEeL1PEQdeuZq+moa12T0Dn7yHLVKhYvrmWuWsRznb6PdpWeVLTdtN0oNejaQHQzumuqwi0bOtITxlekTjUlMYt9JKGhnCjJ7juneJ7+6td751kt5tAHxiLBFyeEDrRvyltNBd+pBITcY/c=
Received: from DS1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::19) by
 CH3PR12MB873938.namprd12.prod.outlook.com (2603:10b6:610:366::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 19:48:17 +0000
Received: from CH01EPF000BE94A.namprd02.prod.outlook.com
 (2603:10b6:8:44b:cafe::d) by DS1P222CA0026.outlook.office365.com
 (2603:10b6:8:44b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 19:48:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94A.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 19:48:17 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 14:48:16 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v5 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
Date: Tue, 20 Oct 2026 15:48:00 -0400
Message-ID: <20261020194801.506382-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020194801.506382-1-David.Francis@amd.com>
References: <20261020194801.506382-1-David.Francis@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94A:EE_|CH3PR12MB873938:EE_
X-MS-Office365-Filtering-Correlation-Id: a5802211-09ed-47a5-7fcb-08df2ee31605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1nf1xpLfnigVLt1+s521v49uOMtfh6cKHGgFF+BvRXiTIiEtU9otfgX7QmNeZdFU3IZdkhGxZlxGk3WAPYVgBf0FdJWxyPizUT92Hl0pusc9JAckCssK0ue1SJHlPUh8kmEIwn8L7Mz56I5YgNfcDJm//yr1rQBtWwyzoZ5BObvawokYgdiFpU3Vm0c20b36jFVni4IRXsPMwuXEM4n1RwmLEgFgo0ZNQEflXuIZKwLE5JoTCseOSLUTrxGAxslmiHkh3C0oBJB6Hpis7H6aEzqHIIQlHjfx5jz4cCCSboyCNeg5ucDkgtepX9GJRm9xbgW+gxkkMfw7lesr4XfdI1hpyqJOV9WX8s+Jg/GXFkeOgzLZHw6Ls0CSjNFBxeCgALuopltIC4Jp7ndEkp4VTuQWFCanqchzOxOUrz0a7mhzXfZC6KwSag29ragXh9NBwP931jK4OCIL/We5qPUTZ6X3ASldVfLkgbTn6aqLGmINnpd+dUlXwBx8J2npfwu4YNKV93EsL2ehWd6+J1+surCb6MBZPlve/vCKJ1RoepkjzjH1RGyzw42TB73YdE3xLvNOvX4/RG7+uYrV6OCAHYNwUZUeumMDt8txp/alQ5yihUPAXz5Ifs/vbZgdSXy5W0+LvAQ47mnU1zjlTBBdwFW8Mgs4B1VIa+mJOHUDfmIPtz0gqGf2TtOzGqH/U9QiV0Fzx1+EWepeEbceXrbGcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HtSWPViixFro0ZRmgWWapX7KJTRB/t51EGc56cnYkC+k6CwkqM0ZQs+lGLH4/+Adbg1T6BTpxfpcfpMu07kKYgBx10QgEPIqYHALdHp/gE3Y+b4S73oJZT+CBM61OH+D6bAH3RmWZrgLlz0Bvnh7QyRS5sFqTLd8pPCUeOGCABPKJEs3gpsG3xKFYFUBvMYqUN2WRfmu1TM5kwIm/zij1DI6KGM4SSlgBlIIwFddUXUwirCpGR8oCUhXMQpmlrEwTsXB1+jVXCwSC0uM9KrNlW8mVTetXzgLFfFqwIqmfBvPwgJsX29OfiTD8/eEhcd/cHkQa4OAEf6mSN5R301CTGyssUBpoocuBEsGTKzszWzI4gpBKoyz4EeKy7TPFFeUFJHw1tUUf/fs7etF2d+x21KFG/4tVgHgv5lyIc9sV+DVJaUQJ6wlK08dLyhSlOjx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:48:17.1260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5802211-09ed-47a5-7fcb-08df2ee31605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB873938
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new option to ioctl USERQ which provides information
to a process about their own user queues.

The returned data is in the same format as that used to
create the queue in the first place.

The interface uses retries; the user can guess at the number
of queues required; if insufficiently large, the correct
value will be returned.
The same is done for the mqd sizes of each entry.

v3: Don't acquire xa_lock and other misc fixes
v4: Don't acquire mutex either and other misc fixes
v5: Small fixes; now with accompanying igt and criu changes

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 145 +++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h             |  40 ++++++
 2 files changed, 182 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3fe10d6af757..5aa53b2f4355 100644
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
@@ -857,6 +859,142 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 	return 0;
 }
 
+static int
+amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct drm_amdgpu_userq_list_entry *entries;
+	struct amdgpu_usermode_queue *queue;
+	size_t mqd_size, entry_buffer_size;
+	uint32_t num_queues = 0;
+	unsigned long queue_id;
+	int i = 0;
+	int ret;
+
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue)
+		num_queues += 1;
+
+	/**
+	 * If the num_entries buffer is too small, return the correct size.
+	 * User should try again with the right space allocated.
+	 */
+	if (num_queues > args->list_in_out.num_entries) {
+		args->list_in_out.num_entries = num_queues;
+		return 0;
+	}
+	args->list_in_out.num_entries = num_queues;
+
+	if (num_queues == 0)
+		return 0;
+
+	ret = check_mul_overflow(num_queues, sizeof(*entries), &entry_buffer_size);
+	if (ret)
+		return -E2BIG;
+
+	entries = kvmalloc_objs(typeof(*entries), num_queues, GFP_KERNEL);
+	if (!entries)
+		return -ENOMEM;
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
+			drm_err_once(adev_to_drm(uq_mgr->adev), "Unrecognized queue type in USERQ_OP_LIST");
+			ret = -EINVAL;
+			goto exit;
+		}
+
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
+					   &compute_mqd, mqd_size);
+		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+			struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 = {0};
+
+			mqd_gfx_v11.shadow_va = queue->userq_prop->shadow_addr;
+			mqd_gfx_v11.csa_va = queue->userq_prop->csa_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &mqd_gfx_v11, mqd_size);
+		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+			struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11 = {0};
+
+			mqd_sdma_v11.csa_va = queue->userq_prop->csa_addr;
+
+			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
+					   &mqd_sdma_v11, mqd_size);
+		}
+		if (ret) {
+			ret = -EFAULT;
+			goto exit;
+		}
+		i += 1;
+	}
+	ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
+			   entry_buffer_size);
+	if (ret)
+		ret = -EFAULT;
+exit:
+	kvfree(entries);
+	return ret;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -891,7 +1029,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
 
-	case AMDGPU_USERQ_OP_FREE: {
+	case AMDGPU_USERQ_OP_FREE:
 		xa_lock(&fpriv->userq_mgr.userq_xa);
 		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
 		xa_unlock(&fpriv->userq_mgr.userq_xa);
@@ -900,8 +1038,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
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

