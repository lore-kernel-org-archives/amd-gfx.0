Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BA6D35693
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475E310E653;
	Wed, 28 Jan 2026 10:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AqNC9qMM";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07B310E653
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 10:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CURFMFYPxKx7Tk28N+nEV0qVvmQfiRWe/9O6Jjk7JX+RogGw+LC2Y19B8LWbyD1WGJ+lZCJMDuTjLD/uoH+rnEd1McyY+uJ087w7QPbDsxayCWim815LWNOhEvdQSncvelBgABDi3+gMcbDD1PoVI9kjLOyepQJxbysvFa/nwptv6FdRxjkcNaUY8fr4u/ZxO4eP1KYJ3cYSbu5JS2KVkvWULDoQUu9e/ts2CgvXg4oOB1+RksGDh9lDNiwdMnpgcSdXQvIS8AZN7Bic8V/UdfKkQlbbJ8zc5y2XrogakcQtD2MgWvEM1aMPfBabpbdYkyMix9FYaXnP8RYg/axm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjvfU+EegiooSSxqBLvsxIu1EhTynZQp6iV9h8uyxdI=;
 b=w0pMmZ2dOC1NwoWPdrQhAaH6ZQrJmAQMWGjoevXvtYMj5uqtYfhSNnaZhL0Bdu8rIC0cuzbFmIhq0gSJztJYx5Lvc4yP2o9Sk1iUAqmutu5BwJGrA5rHys6GW3i6emHZptJu5hChch6Zf07+cvXP86qF9xEZ6CeZ/rN8z7YwDGezzS9CWHSM/9PwWFVq8LoBWxt7Ue2NQ9GgxrQ6pbHZ7LNKNFXoW+ETZpx8C29AosPa5jEc4ABXPfpAdkSD0acnhmoQg9igngH/mv7PYfcSikvk/tu/54h39k5zunqEU87LaJrFqk/SwMSbtCaS9a+qas6noN2QGKK7K3lNacSeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjvfU+EegiooSSxqBLvsxIu1EhTynZQp6iV9h8uyxdI=;
 b=AqNC9qMM1PE/wAig58ms1JIfF4RVFg2rXKT2HCKO9rgYi3h/FP3EAlDZpBapKKHWHv9Lu4d9fF+YjRhT5CxOU4uDsEEtezgCNYMgvf0g1M5X2eqFNuQmWH95JRjXUuiE0Ky7z8//nKe4oAu0sf33nPmzf2R7IPotN416wAjJ+5U=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 10:59:48 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::d7) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 10:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 10:59:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 04:59:48 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 02:59:47 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 28 Jan 2026 02:59:36 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4 5/6] drm/amdgpu: add MQD update support for user mode
 compute queues
Date: Wed, 28 Jan 2026 18:58:28 +0800
Message-ID: <20260128105847.2898288-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f06bcd2-1ce4-44ed-0a9f-08de5e5c5ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bj1ZShrrLK0xu6vJV4UeepFxQ1/J+l3inxWZDZGOXyqm3/WtnnYc+nVHTQzz?=
 =?us-ascii?Q?F9JeM/uCIVT1nyje7l5GTiMuZCNK74KzPB4fprRLWDTh9GAzSKqX2TF3/apw?=
 =?us-ascii?Q?0NB0uTqaAz3lhDM5QmDLK4Zq9eG8RrHE0oDXC4wnfH0Od9/G8iO/YkySLV0t?=
 =?us-ascii?Q?Hc2LT9EJ3w1lcCxLsgH1ZHEykmP1m9mFruZPhLVTUq/LamZRCBe+G86qX/bX?=
 =?us-ascii?Q?clJ0Tpo/GRn+o6PIPg32kU2yOHw10OnrXDzKqz55ir8rZZweo4XkRFPjx630?=
 =?us-ascii?Q?VKTDQUUFznYGPN0KznmPZtoj5JadgmOdNTINE6ZpnrTNn9S+q3TMc53CnXK0?=
 =?us-ascii?Q?7jW8fGjjMQAdgi2UdZgx+UKtwfpl+s9oh+zsn3wSezR8/ywr/IiweNUM9TNN?=
 =?us-ascii?Q?Wf7sTtaUlgPQVLg+VMzqjlAjzLgSBQSfDhj2W+oC5THRC3sWHDM3QJpjtMfO?=
 =?us-ascii?Q?Sts2aCgWAtRTIOSge+HC0NgqyLQviUCfE5Oe0PRv2RBCPLl3R8lMv1jFaUQ6?=
 =?us-ascii?Q?PT/LL6MiimKbfcdpYIoIP/ppycMyLwW6biWWKo+HeWZuQARE3c2lbn5bJdci?=
 =?us-ascii?Q?szVlBwSOKwWt/Mfa6aHrfNPxXMfmJMnez3bufcOITHWU0KxYjZJpjX7tsPIw?=
 =?us-ascii?Q?py62B4HIEiH5BsqW3/FS2NhjddgVzDhQ9iaJxD4k9ywfMe4oXwvw7he+3g2O?=
 =?us-ascii?Q?Z5HNkBFbMuikA/JJgQj4H86unmyfuRmI0ZzYAcf12MGRks5W3wEr3XHOTl5R?=
 =?us-ascii?Q?XiPZoR6tH2aya/sG4BWZZ35TlJpomAJBhj4cbEb6wRNJk4tW5+kkSitomu5b?=
 =?us-ascii?Q?+3/9kAUPsDo60LlOZ6V0SZehucaNorMivI7i4GkAU+w3VawvILRv+TxjAKKm?=
 =?us-ascii?Q?OgNc44kiOOMAgc7Gq6vWo9NRQlUbuSU/u/CxxsL3ZE6urZJedpk8/uycVGQs?=
 =?us-ascii?Q?UCK29ZSNKcuhUuYozyZcd8/lK/mf0L//3Jzf/jSaCvORbcVb+dHMBwnhzbyZ?=
 =?us-ascii?Q?wz4sl52alZLBqA3ElB8+TErbdF5F7wKpQac8zp29SIkoABsdH0+64jWlmBiX?=
 =?us-ascii?Q?iARkYhOmZAoEquM2ovFcoozcI3gzLMOPSIsp5CdqAJOpI5NCmkV2Xs1mS8vW?=
 =?us-ascii?Q?ra/wdMLKWht0kTH10TTrVbdFnjVy5AD6LwrQpCMmyKwLJQbR1/p8GXQbcBih?=
 =?us-ascii?Q?tJPySx4otMpfjq4hdloBSuVXsE7Oej7dLG0t/nvLS2wUz49zDlDAm8mtPEsT?=
 =?us-ascii?Q?Kr4DHEKTAfr5+ly/5mCOI3IZ2iK8SzXb/CRDacnrXZwu/U/IdxwuVEtXjy8v?=
 =?us-ascii?Q?5lv7XWbMis1/z+wxO3kelVxMknIlV7N7JNFKasUowiUQPEzDeyMZB/ofcGXy?=
 =?us-ascii?Q?JqsaGy3kx11sCWvfVaDrhPsNi+6RMN+JcHZ0Sd1I1X+vBzDcCv3whE/un9s9?=
 =?us-ascii?Q?tNc3b7y6PxyktG4YHLBZoM8vto0ptLKLredGPijUts99VGGWB1rxOiMg2SXG?=
 =?us-ascii?Q?ODnA8pgUz9BwNKTJBQiasJO8UhhXidaHyp0Nv2GCDgOOjcCSxkxAt++ZRyE8?=
 =?us-ascii?Q?ta3N+tSmCe6I53MTxBbeH1pf1KsY3RR/8CA1e4JvT4v9+uKkw2gCIsmiVPOL?=
 =?us-ascii?Q?8EeVl6hNxoiyeC4KaVOu1OhnMXgFx+Fsgop+rE5kFGT6Xhu+v52SAPNbWzjf?=
 =?us-ascii?Q?cFK47g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:59:48.5570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f06bcd2-1ce4-44ed-0a9f-08de5e5c5ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

The update functionality allows dynamic adjustment of queue properties at runtime,
enabling better resource management and performance tuning for compute workloads.

v2: Return an error for non-compute queues. (Alex)
    remove the parameter minfo

V3: put the new paramters in drm_amdgpu_userq_mqd_compute_gfx11. (Alex)
v4: move the define AMDGPU_USERQ_OP_MODIFY to patch 6/6 (Alex)
    add the props input paramter to amdgpu_userq_set_compute_mqd

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 166 ++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h              |  28 ++++
 3 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a8f4f73fa0ce..ad136145316b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -819,6 +819,9 @@ struct amdgpu_mqd_prop {
 	uint32_t cu_mask_count;
 	uint32_t cu_flags;
 	bool is_user_cu_masked;
+	uint32_t queue_percentage;
+	/* used in gfx9 and gfx12.1 */
+	uint32_t pm4_target_xcc;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2309d72bbe6..d5251f2d7613 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -30,6 +30,26 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
+/* Mapping queue priority to pipe priority, indexed by queue priority */
+int amdgpu_userq_pipe_priority_map[] = {
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2
+};
+
 static int
 mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
 {
@@ -272,6 +292,105 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_userq_set_compute_mqd - Parse compute MQD and update queue props
+ * @queue: Target user mode queue
+ * @props: Queue property structure to be updated
+ * @args: User queue input arguments
+ * @uq_mgr: User queue manager (for logging)
+ *
+ * This function only parses and validates user input, updating queue props
+ * (no hardware MQD configuration - that's handled in MES layer)
+ * Returns: 0 on success, negative error code on failure
+ */
+static int amdgpu_userq_set_compute_mqd(struct amdgpu_usermode_queue *queue,
+					struct amdgpu_mqd_prop *props,
+					struct drm_amdgpu_userq_mqd_compute_gfx11 * compute_mqd)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const int max_num_cus = 1024;
+	size_t cu_mask_size;
+	uint32_t count;
+	uint32_t *cu_mask = NULL;
+	int ret = 0;
+
+	if (!queue || !props || !compute_mqd)
+		return -EINVAL;
+
+	if (compute_mqd->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+		return -EINVAL;
+	}
+
+	/* Validate priority */
+	if (compute_mqd->hqd_queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM) {
+		DRM_ERROR("Queue priority must be between 0 to AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM.\n");
+		return -EINVAL;
+	}
+
+
+	/* validate and set CU mask property */
+	if (compute_mqd->cu_mask_count) {
+		if (compute_mqd->cu_mask_count % 32 != 0) {
+			DRM_ERROR("CU mask count must be a multiple of 32.\n");
+			return -EINVAL;
+		}
+		count = compute_mqd->cu_mask_count;
+
+		/* Limit CU mask size to prevent excessive memory allocation */
+		if (count > max_num_cus) {
+			DRM_ERROR("CU mask cannot be greater than 1024 bits.\n");
+			count = max_num_cus;
+			cu_mask_size = sizeof(uint32_t) * (max_num_cus / 32);
+		} else {
+			cu_mask_size = sizeof(uint32_t) * (compute_mqd->cu_mask_count / 32);
+		}
+
+		/* Copy CU mask from user space */
+		cu_mask = memdup_user(u64_to_user_ptr(compute_mqd->cu_mask_ptr), cu_mask_size);
+		if (IS_ERR(cu_mask)) {
+			ret = PTR_ERR(cu_mask);
+			cu_mask = NULL;
+			goto cleanup;
+		}
+
+		/* Validate pairwise CU mask for WGP-based ASICs */
+		if (cu_mask && adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0)) {
+			for (int i = 0; i < count; i += 2) {
+			       uint32_t cu_pair = (cu_mask[i / 32] >> (i % 32)) & 0x3;
+			       if (cu_pair && cu_pair != 0x3) {
+				       DRM_ERROR("CUs must be adjacent pairwise enabled.\n");
+				       kfree(cu_mask);
+				       cu_mask = NULL;
+				       ret = -EINVAL;
+				       goto cleanup;
+			       }
+			}
+		}
+
+		/* Free old CU mask */
+		if (props->cu_mask) {
+			kfree(props->cu_mask);
+			props->cu_mask = NULL;
+		}
+
+		props->cu_mask = cu_mask;
+		props->cu_mask_count = count;
+		props->is_user_cu_masked = (cu_mask != NULL);
+	}
+
+	/* Parse HQD priority and other compute properties */
+	props->queue_percentage = compute_mqd->queue_percentage;
+	props->pm4_target_xcc = compute_mqd->pm4_target_xcc;
+	props->hqd_queue_priority = compute_mqd->hqd_queue_priority;
+	props->hqd_pipe_priority = amdgpu_userq_pipe_priority_map[compute_mqd->hqd_queue_priority];
+	props->eop_gpu_addr = compute_mqd->eop_va;
+
+cleanup:
+	return ret;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				struct drm_amdgpu_userq_in *args_in)
 {
@@ -325,10 +444,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 						   2048);
 		if (r)
 			goto free_mqd;
+		r = amdgpu_userq_set_compute_mqd(queue, userq_props, compute_mqd);
+		if (r)
+			goto free_mqd;
 
-		userq_props->eop_gpu_addr = compute_mqd->eop_va;
-		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
@@ -432,11 +551,51 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
+
+	if (!queue || !userq_props)
+		return -EINVAL;
+
+	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
+		return -EINVAL;
+
+	if (args_in->mqd_size != sizeof(*compute_mqd_v11)) {
+		DRM_ERROR("Invalid compute IP MQD size\n");
+		return -EINVAL;
+	}
+
+	compute_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(compute_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	retval = amdgpu_userq_set_compute_mqd(queue, userq_props, compute_mqd_v11);
+	if (retval)
+		goto free;
+
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+
+free:
+	kfree(compute_mqd_v11);
+	return retval;
+}
+
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	kfree(queue->userq_prop->cu_mask);
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
@@ -513,6 +672,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
+	.mqd_update = mes_userq_mqd_update,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ab2bf47553e1..c52949ea8c1e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -341,6 +341,7 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
+#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE	100
 
 /*
  * This structure is a container to pass input configuration
@@ -460,6 +461,33 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
 	 * to get the size.
 	 */
 	__u64   eop_va;
+       /**
+        * @cu_mask_ptr: User-space pointer to CU (Compute Unit) mask array
+        * Points to an array of __u32 values that define which CUs are enabled
+        * for this queue (0 = disabled, 1 = enabled per bit)
+        */
+       __u64 cu_mask_ptr;
+       /**
+        * @cu_mask_count: Number of entries in the CU mask array
+        * Total count of __u32 elements in the cu_mask_ptr array (each element
+        * represents 32 CUs/WGPs)
+        */
+       __u32 cu_mask_count;
+       /**
+        * @queue_percentage: Queue resource allocation percentage (0-100)
+        * Defines the percentage of GPU resources allocated to this queue
+        */
+       __u32 queue_percentage;
+       /**
+        * @hqd_queue_priority: Hqd Queue priority (0-15)
+        * Higher values indicate higher scheduling priority for the queue
+        */
+       __u32 hqd_queue_priority;
+       /**
+        * @pm4_target_xcc: PM4 target XCC identifier (for gfx9/gfx12.1)
+        * Specifies the target XCC (Cross Compute Complex) for PM4 commands
+        */
+       __u32 pm4_target_xcc;
 };
 
 /* userq signal/wait ioctl */
-- 
2.49.0

