Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40F0D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 14:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A68C10E030;
	Mon,  1 Dec 2025 14:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzMt6DKm";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E0E89D7C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 14:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exD1+Q8QE2Fbte27DqmRrjv4Qpp9rl/0t5CwBAtWSehnphN6PYf9XduUk5AAPglB5xdxCIhhsTxiH/2Ow1hWdX8zzt2FVpdzkTbdD60JkjemrTe5Xjl+XxpV8XDdgt1r/liz2YITCGVLEOkbPt4YD2JaUcx6MypNLtcSwckZ8U4X7urS0ARR7aXMJiW4VW5m3uJOH6eEZOmqnNcERYRydrLXuZvNS5jOCHEAQzTLmP4Du+ghiIh/xSXP2YKEAAq5Su6T5qVU2tpOYTcSOfIp9O49WWp1gO732BjyUEfoF4jZO5CQkujwjeXkg5TyXKpm0jdcxGsvmIucnOHKkppOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0gEZl+d9GF/zAQ2Fgeq2QylxQXLv0y+qjgJf3ovzDs=;
 b=U0Hb6HABkwvRWlQMiQ35rnQ3/jfWFN9gC+gtKdP3+xVZ1GwBvT7eyTBd2/ulpawNURM9JjbBFXepPxDV4dPvI1Rkd10tcoAKDbJjL8kl9f2FrxtUtq8i9R6D+rCczn6awqEawYTCJDDTD3W7oq4bYufY+Q5+Lg0K/Wln1qOpzltD45WNUeLrGPNd1n5nq+vGpqauGZ6C7TUGygkP8TpzFq6/5m94YVt+6uqmQwPhdyduwGPJu2qPPjGScYtA36SePwCs/jut13qPIgrQ8qegJDglYptPiBa/Ve4DM5hZB/e/GXviWnIyV1WR38A7zZlRY0cMd2dp9qO5iSY4wIq8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0gEZl+d9GF/zAQ2Fgeq2QylxQXLv0y+qjgJf3ovzDs=;
 b=lzMt6DKm4yILu0+IWpvELPFwT28UCF33g2QyQb6QiOpWjxkYWXyCpkOrz1mFQRxg0AA2S6LUdkqA1TBwkLQ1GgX2Rm2OOxFuGlfo9z9R/EBNMqt4RfU2jVw9QZKuOqO+HUSRzXvYEGUZyZEwMNTyHrG+u3CBTzgXFVK0ij1yTmg=
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 14:28:57 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::29) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 14:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 14:28:57 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 08:28:54 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc kernel BO
Date: Mon, 1 Dec 2025 09:28:36 -0500
Message-ID: <20251201142838.1516452-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201142838.1516452-1-Philip.Yang@amd.com>
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: f2999a5e-24e8-47ec-9d37-08de30e5f649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ry5dcuIzPJ67WO6WbChxAVpqiuuzQBdOoJM0QZQK8BMyHsPksIlpz9zEdYxc?=
 =?us-ascii?Q?ksvr1KeIlCcH6nRdMrTDfgIGVfuw758IXgbBuN58BtZlodNJR3sX4gM9lWnC?=
 =?us-ascii?Q?74Zu+ppbNwl36ds0hNIpnFehA+5CZwYQcP7ASgJWxhZP+HOL0cP72NXjz4si?=
 =?us-ascii?Q?6UK50GxxT0KgwsKE9UEy2N6WxAxW9/KQ4d+BBIXh51UCCxtRiJ3ieluIZ41U?=
 =?us-ascii?Q?bZBjveeKF0K6/G7fxbLFYVL3oKuRSydqoquSJ1zAU2UbmxmsFJ7rO1mavh07?=
 =?us-ascii?Q?KMrKNsXaIskCDWpnVZgscsMhU66XkHrv+vvwod42IiweP/zMJBWT5RqSJUvL?=
 =?us-ascii?Q?YoFnlkGw9BJ8DNS6h92vDdxtW5/P4LpmLL//wfS+ySQ0s6Ss/WLuExszTVYr?=
 =?us-ascii?Q?EYPfiq6LN9Eeg9D8uYMzlTLuVTGQrOFzAq4l4dC2EvtALYgqurOc1Oj7hpZk?=
 =?us-ascii?Q?RyUbinTHlS+/hU08FgRNW7lW268eLK/p3/xbBug9TymnYLRRBWX/xWxIXyPh?=
 =?us-ascii?Q?25C/oFqQQNttju8pwLofqa8iOSMBMYn7y81htkxF+uFbLA7cOTCKZ9gXtOBF?=
 =?us-ascii?Q?v10d7wEYN7llVuIUQVa6ZBKgJzDLlVnVJb+1qI78xEn4UoBjSu22pumFX0UL?=
 =?us-ascii?Q?12jjNGx6yeHoTy7K1JwodKzE6w7LL77thFzrT9L6l2luv+0vRFs8eekjK3QL?=
 =?us-ascii?Q?5GyuStXpsSEIVcR0sCs+2Apn6TXVcMrIyaRI1zsEOiyqxS9bJLvtIUdmoaG5?=
 =?us-ascii?Q?HGToNViF2DVGhdFb3M6OfLLVQhmcOpMBckzHoK/EuwvfPwhxvUHWjeWG4iff?=
 =?us-ascii?Q?RkXdhUZQwCIoOnjvKjPsUh5LEQwUdmUIDskSFWUgpimXMnuL/njZhDnZbkHc?=
 =?us-ascii?Q?6eFO0Dtvljptig9CTLzjqsAVKWIYzEtKCoDRwc47hJTva8foVU5AbgWH+51e?=
 =?us-ascii?Q?pbRGUt6+OR1xan5uO9T08+01SL3oStSsDg+JZooO7MfFC4KCJn+yF2Llg3pm?=
 =?us-ascii?Q?LYNr4f/9l2573MxhPmtkJ5he0nw2Dkq//3DTiAcnimDKna0BvQ2cTJyfRoEt?=
 =?us-ascii?Q?ljP1jq91Xxr6K3MDrRJI4l7vX//j+wXRs5G/8p0J4NT/VvG9bLAobKbs+jPW?=
 =?us-ascii?Q?7SFUs3BXBu/qZmDVIIOABdMkHwTj0NNA813huYpRgJUbLV8FoD1ueo0D/dTt?=
 =?us-ascii?Q?NqQz7DRXNFEzATGv8z2ubeFe82biUqcUWxQ3Oqe2yaOkaf8ZMR2mwpjyzuJg?=
 =?us-ascii?Q?HqmvcuWO0JvHz0ladJyaYESgXJO1gSNvJglM74gjwL+1gZfALtrGtNQNGp8f?=
 =?us-ascii?Q?1tYMNWOTGakSpxRUENq5p4T9kHELSzOntkLPAMgRlv/JZ5SZ8+Y7TPhkHq1k?=
 =?us-ascii?Q?r/huQW/JF+A8nkldr7kacw0nOePN3sCg+8h0F1h+K2DOTg+vPWTFK3V6CQ+R?=
 =?us-ascii?Q?MH7ViOC+6HUEHRPNkXNPSkWxqep9a9pKiTUai17VrlyP/ggEY+ItrYWJO+Cb?=
 =?us-ascii?Q?CDCK4epwatP+M4h+opsMir5nmgYYKybCIJB23YqFlt9azklCUbn2QuOTgSrq?=
 =?us-ascii?Q?8ZQoAchsUXhnsmmrWH0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:28:57.0313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2999a5e-24e8-47ec-9d37-08de30e5f649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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

To allocate kernel BO from VRAM domain for MQD in the following patch.
No functional change because kernel BO allocate are all from GTT domain so far.

amdgpu_amdkfd_alloc_gtt_mem has many duplicate code as
function amdgpu_bo_create_kernel, with one extra flag MQD_GFX9
to bind MQD and control stack in GART with different mtype,
the duplicate code could be removed in future.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 ++
 7 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8e..9cd1660b8f60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -317,7 +317,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool cp_mqd_gfx9)
 {
 	struct amdgpu_bo *bo = NULL;
@@ -328,7 +328,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.domain = domain;
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
@@ -351,7 +351,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 		goto allocate_mem_reserve_bo_failed;
 	}
 
-	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	r = amdgpu_bo_pin(bo, domain);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to pin bo for amdkfd\n", r);
 		goto allocate_mem_pin_bo_failed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 335d733751cb..14b5ab6fa051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -237,7 +237,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 #endif
 /* Shared API */
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
 void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba9a09b6589a..494a563e072e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -359,6 +359,7 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 	if (!pdd->proc_ctx_cpu_ptr) {
 		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
 			AMDGPU_MES_PROC_CTX_SIZE,
+			AMDGPU_GEM_DOMAIN_GTT,
 			&pdd->proc_ctx_bo,
 			&pdd->proc_ctx_gpu_addr,
 			&pdd->proc_ctx_cpu_ptr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9f183d27a0ef..b0cfad750919 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -787,7 +787,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	size += 512 * 1024;
 
 	if (amdgpu_amdkfd_alloc_gtt_mem(
-			kfd->adev, size, &kfd->gtt_mem,
+			kfd->adev, size, AMDGPU_GEM_DOMAIN_GTT,
+			&kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
 			false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 36ac35d64126..028fca1d2755 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2906,6 +2906,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 		NUM_XCC(dqm->dev->xcc_mask));
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
+		AMDGPU_GEM_DOMAIN_GTT,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
 		(void *)&(mem_obj->cpu_ptr), false);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 2e9b6bcf2704..a489d43d5f64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -139,6 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
+			AMDGPU_GEM_DOMAIN_GTT,
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5f8cda4733f9..e0c5ec7e2fe9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -266,6 +266,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	if (dev->kfd->shared_resources.enable_mes) {
 		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
 						AMDGPU_MES_GANG_CTX_SIZE,
+						AMDGPU_GEM_DOMAIN_GTT,
 						&(*q)->gang_ctx_bo,
 						&(*q)->gang_ctx_gpu_addr,
 						&(*q)->gang_ctx_cpu_ptr,
@@ -369,6 +370,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
 		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
 						     AMDGPU_MES_PROC_CTX_SIZE,
+						     AMDGPU_GEM_DOMAIN_GTT,
 						     &pdd->proc_ctx_bo,
 						     &pdd->proc_ctx_gpu_addr,
 						     &pdd->proc_ctx_cpu_ptr,
-- 
2.50.1

