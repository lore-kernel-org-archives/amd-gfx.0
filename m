Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C61D72369
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2AB10EA94;
	Fri, 23 Jan 2026 10:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W7GSO8jL";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0069110EA94
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyc+JlUYQhaUWJ8uf4c7DdEc3YBa7wDZF/Yqfom+zvWSbGTuO436uVmK4WlciUISal6wxqrxM1rFTG43tmbFHe9LaogXCNE9bjNSF3gifOEYgljir92gdPjkcI0Q8/ZHMddotA0BFEPfTvWRKa+3S3ADLjy11hmewuh5j7CvWV8Fos65yx5EALcATszX4Y+qPdFP2IfX87bKbMEJF+7J+Qe2FAdN8VCS8lRnJt7VCGZu8qUNfzhcKhud8R1vKbl0WbM02zJgr2XxLnRnbtTWh5YJ34PMcmD/Zk9Te4s7QA8ufOnYK4kA8Ddmsq9klIeJCKcFJbr0+8rXqEZ7WGBdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsyjqZjilWMe4ABE2SFEwdp3lCz4ZyBDF/r+YExjj3Q=;
 b=pmj5cVCVviKGKgHtAs9DDyrUsWxugpZDIAc2mPJH7RrBFip4dcbx569TONCjsQQbS64L9uyOKE73MNpv8OSXS2sEcrrI9HLQw+6tfS/5Tyd10GOQzYEBRxR4/cJvMvqAO6lpq6vzE2OlaFJFjEhwXM5/kiIzQVzXDcYP42ExUnyugvnkbb6yIXzNx3gCg6eEcSOAocg2an1mZy4oKpaXOSbamRf95IkWfq2/io7oIMheTeSyoniowQL2JefI+lOM85SVvHDMN5c00dQXL3jYd/Ug4OnbOALXN6GVxRvcVjiNcBBF/O2JssGxpdGBX872738iQUNTkshKPZtoB99y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsyjqZjilWMe4ABE2SFEwdp3lCz4ZyBDF/r+YExjj3Q=;
 b=W7GSO8jLfYty9EA3nAJzCBnpP7NRBVZYNSbmZn92WWnTl/hAMKykkjIQ+VOK9s8fOANkZmLwqDI0uMQ/T2ntq2cjyFyAWKb/LXvhpIHwXl4kK1tExc8wv95nSag9Nr/DEBJ5VMrRpG3cTyB5E+istr8zMZRemSLxseeybS/zUbM=
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:11:07 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::2b) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 10:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:11:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:10:59 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 02:03:16 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:03:05 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: implement CU mask modification support for
 AMDGPU user queues
Date: Fri, 23 Jan 2026 18:01:24 +0800
Message-ID: <20260123100219.1693990-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa8bdb1-e756-4d31-4994-08de5a67b980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cgBfnzHdM4AL9F3wmRikkTJO9v3X2RI9vvwNzhEIKC1V4GzZZWZpuI/0T0V3?=
 =?us-ascii?Q?p/PyBVkTo/oLlsdM7vQCEiOMkt7T0AAJtF/8fVmJGV5EuXVtFF9ohC3gMuEJ?=
 =?us-ascii?Q?nn7XYr9uc44iu/2i3coC7cWAHBZuVPyx23PMuE3jFw87gW50c8ah2cJwD3oL?=
 =?us-ascii?Q?jDtF02oPwGAhRxRw3OIbVX1wxt7GPSYmfCk6fiB5EaDCsbEoMv/ybV2VMesD?=
 =?us-ascii?Q?DA1ysq0xgbav2pQPfJ2TqGD3/v9eR15z1FJpB1HLxGnr8g87clhqfejnyCkQ?=
 =?us-ascii?Q?Er8Z3CQvxMSF1fUZuB/sECYDHKyWftSnLC7zKc9RsJDyfRrWiPYpmcHhjgmb?=
 =?us-ascii?Q?Z/ZNsJP47Fbwu3YbL++3TKJlzl4k4dQJK7CxmoD7Gv2Aq6Njv3rUt3FOMZ2P?=
 =?us-ascii?Q?5TxyiXoc12+OW28k4vXSz1TbuCjwQbhHCp6zk+zXFvR/iir9XUIeRBP/4TX6?=
 =?us-ascii?Q?LGCebxA+7iWUuh5wkz3y5BER9pH2nOk9v2gcc5w+Lor36Mpl95yMlKn95V+n?=
 =?us-ascii?Q?ieEmUq6HDidaneSxGOTmcEDcOQrWkBRHSnMicTk6W2GNHxbhNatU6qUha4s/?=
 =?us-ascii?Q?kj85SFUB8haj1/b5NHkGfBHD5fF6jCGxHbwzBTlRc4Sxs55iEWKXLm8sGBau?=
 =?us-ascii?Q?cOZcHiaZFLFzjSzGq32BZxzYPDmsJVQJz4gwD1qdV8w84VnnotIOdX8haTRC?=
 =?us-ascii?Q?UBtWTJELP9TO0IdbC7BQT1aV6NA0PEI6i9Z88ivA9DDQSykElZMcWZnNV6pE?=
 =?us-ascii?Q?gY5fXOkqosf66MZ/PQEz0XTZVfKzfo51M0ccMxqkuuyBomNhzvOIsJHUxXhO?=
 =?us-ascii?Q?+zIAZfyQkCdTmKCK1yfYYmnCxZg9pr0A+iBAwwniTtwDS8iusiPXMiI1UcJ/?=
 =?us-ascii?Q?bXyVIWMHpTtPMzz+M5Rje6KgaGvNKxoOhvfSh6YI3J2NjUDMduIZjB7n77Ij?=
 =?us-ascii?Q?H6aEBqmaRA102liNY6/a5HxA62k7+oal+7xIFL+By/Qu9UcWMqYaTGAhq82O?=
 =?us-ascii?Q?EcXWt+/w5d6tWlau8sfmNFkrbVgT1qlA4x1HegvNygbwvZBl0l+IS9ppP+1W?=
 =?us-ascii?Q?Rb7EXL5pDvI8RFiyt3UQhoMi0X8B8e0IKsEVNQVMtYfWxlpVqFffvTVPzmwU?=
 =?us-ascii?Q?+683Emu5qKrT+nd9t8BjVqMWaHJkg2IFTplxNTuC6ZGIMMp8JgACRbNVtI21?=
 =?us-ascii?Q?ZqNJgNAHyqP1va7iUDPixazf/WEuYLFCXcD7P2RPmGtssUw4g3FdrR5uXVIL?=
 =?us-ascii?Q?xcxTA+S13UNwqBVa/FpLAeEDdtSug4XA031XZn9x7XN5Gl/AWvf2ClN/8rin?=
 =?us-ascii?Q?MRjFwtgwNH7ET0hnHk3XZEsyOjflp8DydEsax9EvPM8PwYjy10JxWJ1BBV+q?=
 =?us-ascii?Q?yb5kUFQEFDWVk9LprT0472z7b1m2IjaIsS4ZxuFL30mzMBefDL0IZXSNyOOv?=
 =?us-ascii?Q?6cImFRntA9dmofklu974LWO2SePwtvD7rPkDzoIsOqz6+kjMYK///qxo/7Wm?=
 =?us-ascii?Q?qGhkxjozg/QqKMVoT+H5WXiHsQ1KkT12XkO7W2Rbzv6Ms9AAu+bVbstDK5ak?=
 =?us-ascii?Q?2O4ETSQF56RrH/8LtODTunuuHe8pwWzV2TBny8r+B+4lpkGLCJGQGPLudycf?=
 =?us-ascii?Q?h6AWApill0vnMGFq8WYsl0LqfrhjPxRBOteMn7bI9mhIwiQM1KiuUmx4vFBx?=
 =?us-ascii?Q?OPgO4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:11:07.3115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa8bdb1-e756-4d31-4994-08de5a67b980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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

Add support for dynamic Compute Unit (CU) mask modification to
AMDGPU user queues via a new MODIFY_CU_MASK operation. This enables
userspace to update CU allocation for existing queues at runtime.

v2: add a new op for AMDGPU_USERQ. E.g., AMDGPU_USERQ_OP_CU_MASK

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 111 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h             |  13 +++
 2 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 256ceca6d429..4d7841f47dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -901,6 +901,113 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
 	return false;
 }
 
+static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs;
+	bool unmap_queue = false;
+	int r;
+
+	uq_funcs = adev->userq_funcs[queue->queue_type];
+	if (!uq_funcs || (queue->queue_type != AMDGPU_HW_IP_COMPUTE))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Unmap the queue if it's mapped or preempted to ensure a clean update.
+	 * If the queue is already unmapped or hung, we skip this step.
+	 */
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+	    queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = amdgpu_userq_unmap_helper(queue);
+		if (r)
+			return r;
+		unmap_queue = true;
+	}
+
+	r = uq_funcs->mqd_update(queue);
+
+	if (unmap_queue) {
+		r = amdgpu_userq_map_helper(queue);
+		if (r)
+			drm_file_err(uq_mgr->file, "Failed to remap queue %llu after update\n",
+				queue->doorbell_index);
+	}
+
+	return r;
+}
+
+static int amdgpu_userq_set_cu_mask(struct drm_file *filp,  union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_mqd_prop *props;
+	const int max_num_cus = 1024;
+	size_t cu_mask_size;
+	uint32_t count;
+	uint32_t *ptr;
+	int r;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue = amdgpu_userq_find(uq_mgr, args->in.queue_id);
+	if (!queue) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	props = queue->userq_prop;
+
+	if (args->in.cu_mask_count == 0 || args->in.cu_mask_count % 32) {
+		r = -EINVAL;
+		goto unlock;
+	}
+
+	count = args->in.cu_mask_count;
+	/* To prevent an unreasonably large CU mask size, set an arbitrary
+	* limit of max_num_cus bits.  We can then just drop any CU mask bits
+	* past max_num_cus bits and just use the first max_num_cus bits.
+	*/
+	if (count > max_num_cus) {
+		drm_file_err(uq_mgr->file, "CU mask cannot be greater than 1024 bits");
+		count = max_num_cus;
+		cu_mask_size = sizeof(uint32_t) * (max_num_cus / 32);
+	} else {
+		cu_mask_size = sizeof(uint32_t) * (args->in.cu_mask_count / 32);
+	}
+
+	ptr = memdup_user(u64_to_user_ptr(args->in.cu_mask_ptr),
+				    cu_mask_size);
+	if (IS_ERR(ptr)) {
+		r = PTR_ERR(ptr);
+		goto unlock;
+	}
+
+	/* ASICs that have WGPs must enforce pairwise enabled mask checks. */
+	if (ptr && adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0)) {
+		for (int i = 0; i < count; i +=2) {
+			uint32_t cu_pair = (ptr[i / 32] >> (i % 32)) & 0x3;
+
+			if (cu_pair && cu_pair != 0x3) {
+				drm_file_err(uq_mgr->file, "CUs must be adjacent pairwise enabled.\n");
+				kfree(ptr);
+				r = -EINVAL;
+				goto unlock;
+			}
+		}
+	}
+
+	props->cu_mask = ptr;
+	props->cu_mask_count = count;
+	r = amdgpu_userq_update_queue(queue);
+
+	kfree(ptr);
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -920,6 +1027,10 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
 
+	case AMDGPU_USERQ_OP_MODIFY_CU_MASK:
+		amdgpu_userq_set_cu_mask(filp, args);
+		break;
+
 	case AMDGPU_USERQ_OP_FREE:
 		r = amdgpu_userq_destroy(filp, args->in.queue_id);
 		if (r)
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ab2bf47553e1..cfc3a9313229 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_MODIFY_CU_MASK	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -410,6 +411,18 @@ struct drm_amdgpu_userq_in {
 	 * gfx11 workloads, size = sizeof(drm_amdgpu_userq_mqd_gfx11).
 	 */
 	__u64 mqd_size;
+	/**
+	 * @cu_mask_ptr: User-space pointer to CU (Compute Unit) mask array
+	 * Points to an array of __u32 values that define which CUs are enabled
+	 * for this queue (0 = disabled, 1 = enabled per bit)
+	 */
+	__u64 cu_mask_ptr;
+	/**
+	 * @cu_mask_count: Number of entries in the CU mask array
+	 * Total count of __u32 elements in the cu_mask_ptr array (each element
+	 * represents 32 CUs/WGPs)
+	 */
+	__u32 cu_mask_count;
 };
 
 /* The structure to carry output of userqueue ops */
-- 
2.49.0

