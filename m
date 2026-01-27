Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D1AD25955
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 07:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474F710E4C2;
	Tue, 27 Jan 2026 07:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Axcoz9Cu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C1710E4C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 07:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or3TwJJvSmMCV5v2iE9cm/Nzb7PCCsJW/ZuMzCwNjFEmJ/FPhVD3g90kiAaRLDX23UoPzcYNpPkN6/7fL9uHaC2qCExiiJJ8YFrfBR+aNaf0lY+KUyhVHtXg4VLOc4+q3lk17UKR+Q9Xt75AvNM/m0wdZ37y/X3AwXdkQPJ1Sqb7oiZxnI5jLeP+eMx91TEJ8d59RNoGDKKSpeU2f2HvudbAp9XkbvSNg1ZlN8M4agGAXhd84ymmh5NqcSDLnpfNA/vEPB+w8GbAPm9NwS5Mwpp+R2HTO9rFJDsqrV6PA0lyVvhLacqCghdGZRqQSPyG/+2DMOv0tBiiogk00+AOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r2Evf37C+X1IRXBWnYubb+QosgF54EkE1ZZLLXoNmI=;
 b=Rtu3H4mNAQEat5jbm/c+o3Mugqlt99KXruEsZucRcpiuXBakosuW6pLDbOFnTWnBbOBUyaVAOJ7UZ5AMIX87Rr2jsxZbk8plr/Kcl3KgixkNkVgwevhrgz2W0qUeAzJk2hACW35ab2Lhb/CpXOAys9oseJZmVuZ0R4j6yhlzpF60g+e87ABvoWzaGVB/u/qEokZiD+0ZvHgcp3+J07ispaqlgNZqhv0yFm9ahgakrWNKUW37Bw7UkdmsY0A6IEOTbZ51XKnvAvdsx3pK6Rs1CHsLIpxU5sLooKs7c+94JCo9nax9tXXUbJdQhFyt0JborpLfWvWz8orWCdOdoX0alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r2Evf37C+X1IRXBWnYubb+QosgF54EkE1ZZLLXoNmI=;
 b=Axcoz9Cup6DhuJXLLACzyPtOzH5MDIIdlweAKElbMS/n4BDZSD4BbjTF3OrxNBr4Fy7SIjFQ2RcoMo59NTBxCWrH18EgyyqiAvuWP8uACeNb/Ti6FbZ3XK2BwZCQ26xJvSgtj8tFP3MbfY+AdRO3tK+f/VN2kjAScpVgozqW3FQ=
Received: from LV3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::18)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 07:19:02 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:234:cafe::b2) by LV3P220CA0009.outlook.office365.com
 (2603:10b6:408:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 07:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 07:19:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 01:19:01 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 23:19:00 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 26 Jan 2026 23:18:49 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 5/6] drm/amdgpu: add MQD update support for user mode
 compute queues
Date: Tue, 27 Jan 2026 15:17:27 +0800
Message-ID: <20260127071800.2395621-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
References: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a8edc0-5db0-4cfc-7323-08de5d745870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yrs6YVC+wHBew/g11HPoVkB/tBQkfOpabHF4+6dVMMiAS61t+xkUsQ4GlwFO?=
 =?us-ascii?Q?7+OqCIqJz/f24UsIvZzWDj9gyejCOB4N2EtGv3Z9ncl/PJ2+/2jHjavkzaNv?=
 =?us-ascii?Q?xCUXzYgwrq2SpuF3pQOxzuHyJ9CNahK1pk3LWFo3mRHGKcpNbX3R+VRvefP6?=
 =?us-ascii?Q?7OBFTRDbr8IpE1PgwSWF8B1ZG+XprFinak5yZNUy+NCBpTkB1NHz2o4meKMi?=
 =?us-ascii?Q?cdKyYprOBcePcOa22uRI4C7O9xeflkabiK+6Lwiiu19twK/5lSKhKeb+0bRO?=
 =?us-ascii?Q?tlI24YrNiR4XL6KzHMgJCi+7PcXb3ydUHaIBF8YFT2jslkyl8Yn3cOZJU7c/?=
 =?us-ascii?Q?ywoSIT9eAhEOY5mHoAGywt4+Ps2UhgtAqgvKrmQ5/5RZ6uaQlPbXrLzicGCh?=
 =?us-ascii?Q?7+NpFV564oZXenxvz0gxSiMFRS4FkwsG47hPF40PFTR+0eywaY3xUAVk/v8I?=
 =?us-ascii?Q?RtkK4sAUEFm0oJUORUke8iwyc869j1V50gWdBUdeOWWvNu+XSWB3rSPXYyQu?=
 =?us-ascii?Q?ZhvMr9yhf2JKIs/poxMPf0BE5Wsf531wBhons/mbHHaBIPa623TWKwnYtaXc?=
 =?us-ascii?Q?NQYqWVIKevsjDsQROZIgJAvv5yMiAN6CZ1vBkHQ0qg92O+HWnm8UAa8U7++X?=
 =?us-ascii?Q?eoDcvKNuVeHnHR47r3/IyX9qDMiLa6zSVBav/Hi3RPUnvZ6OpaawvnoPY1B/?=
 =?us-ascii?Q?uF4Apf8pdZTEQsb/gHu8jnBFmmN6Qsii3qmYkijath0KhC8tvs0B3hlr9wP3?=
 =?us-ascii?Q?1HYFFsDIyta2zphEHPxoNz8vEPPubr13NFg2rnDgncXA46OYxAHWu0xBFf09?=
 =?us-ascii?Q?fDk7jZa+q3Y90GA+zDodxaKefXiugp8yypV3byHATVCn4MjNvHekNQvBTGDU?=
 =?us-ascii?Q?YhUqVsY9SBcHUI7t/8TIy8ZZhocc08N9hCoE6I2Vj2195JY7HTl1y2RDV4l1?=
 =?us-ascii?Q?8Ihnlfob6sA6w/Wa4h0G30FImjL5brEpBaoepXZVD9hqqUgTC7x5UfJ35PVY?=
 =?us-ascii?Q?YqerIj6jKWvN56TF1W18V9Z1kaoUx04aF3KwY9LTBk8iX95i0gHo3f9ZJ4ha?=
 =?us-ascii?Q?aPghGs+vu8e8sLrbSMG4bONpxUWdope6yHiBUPMC2AnqPQL+s/iTzSQw8RJ/?=
 =?us-ascii?Q?WJcxy0CBuo7kymq96qITYAdCyJNuEeSzVk9hP6a6Ev9ZT6Wh4PGe0uBkfvYT?=
 =?us-ascii?Q?NzxO1TkQzzva3aC4IJYpU/H7iRuf/crhpbdpZjTOCJn+6NZwH5+fAkhZWjKT?=
 =?us-ascii?Q?y+OBKbF33Z5XzQsL35RynGhhDSB+IIQ+o1txtcgYFNVTyKv6IteLgp9D1L6q?=
 =?us-ascii?Q?IZe4F/96FjXEuPB7rqsi4CJ6RcdnZ5JayS7yprv/ShNI6N73eWCKhqZR8tMl?=
 =?us-ascii?Q?IEXopIFbMfTtpGAgSHuGq4nFBqpuRDyNGIklLBquIQLb/W8fPfYCVhodkctn?=
 =?us-ascii?Q?sLDYXxPsVsF2rgqXRhpqg7rHcWnZUfEFQF51uDcphogwJGdo6/bKVlHiSzZp?=
 =?us-ascii?Q?6NgYssgpK18CMXLgfADIGLJVqhcBgnI1vm5ScUF5w5ciDr3I7TB871+LoDpD?=
 =?us-ascii?Q?z2wPFmfiaN/3IAeiyZX8V/6Y3UID7OxKXoa2ZI/HxB0wqYRo6tcJKKraCXs1?=
 =?us-ascii?Q?m0LX5ZQHzrhm7ZJKXNyzVdcuaLlhhs9GaKTvE+ILyZc4R4oh9OKcMzT4ek+E?=
 =?us-ascii?Q?3DBSmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:19:01.4118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8edc0-5db0-4cfc-7323-08de5d745870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 167 ++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h              |  29 ++++
 3 files changed, 196 insertions(+), 3 deletions(-)

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
index f2309d72bbe6..ee91721f322b 100644
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
@@ -272,6 +292,104 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_userq_set_compute_mqd - Parse compute MQD and update queue props
+ * @queue: Target user mode queue
+ * @args: User queue input arguments
+ * @uq_mgr: User queue manager (for logging)
+ *
+ * This function only parses and validates user input, updating queue props
+ * (no hardware MQD configuration - that's handled in MES layer)
+ * Returns: 0 on success, negative error code on failure
+ */
+static int amdgpu_userq_set_compute_mqd(struct amdgpu_usermode_queue *queue,
+                                          struct drm_amdgpu_userq_mqd_compute_gfx11 * compute_mqd)
+{
+	struct amdgpu_mqd_prop *props = queue->userq_prop;
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const int max_num_cus = 1024;
+	size_t cu_mask_size;
+	uint32_t count;
+	uint32_t *cu_mask = NULL;
+	int ret = 0;
+
+	if (!queue || !compute_mqd)
+		return -EINVAL;
+
+	if (compute_mqd->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE\n");
+		return -EINVAL;
+	}
+
+	/* Validate priority */
+	if (compute_mqd->hqd_queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM) {
+		DRM_ERROR("Queue priority must be between 0 to KFD_MAX_QUEUE_PRIORITY\n");
+		return -EINVAL;
+	}
+
+
+	/* validate and set CU mask property */
+	if (compute_mqd->cu_mask_count) {
+		if (compute_mqd->cu_mask_count % 32 != 0) {
+			DRM_ERROR("CU mask count must be a multiple of 32\n");
+			return -EINVAL;
+		}
+		count = compute_mqd->cu_mask_count;
+
+		/* Limit CU mask size to prevent excessive memory allocation */
+		if (count > max_num_cus) {
+			DRM_ERROR("CU mask cannot be greater than 1024 bits");
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
@@ -326,9 +444,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		if (r)
 			goto free_mqd;
 
-		userq_props->eop_gpu_addr = compute_mqd->eop_va;
-		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		r = amdgpu_userq_set_compute_mqd(queue, compute_mqd);
+		if (r)
+			goto free_mqd;
+
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
@@ -432,11 +551,52 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
+	struct drm_amdgpu_userq_in *mqd_user = args_in;
+
+	if (!queue || !userq_props)
+		return -EINVAL;
+
+	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
+		return -EINVAL;
+
+	if (arg_in->mqd_size != sizeof(*compute_mqd_v11)) {
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
+	retval = amdgpu_userq_set_compute_mqd(queue, compute_mqd_v11);
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
@@ -513,6 +673,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
+	.mqd_update = mes_userq_mqd_update,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ab2bf47553e1..aa9b31578c6b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_MODIFY 3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -341,6 +342,7 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
+#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE	100
 
 /*
  * This structure is a container to pass input configuration
@@ -460,6 +462,33 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
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

