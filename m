Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DDBC7EE32
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9661F10E52D;
	Tue, 24 Jun 2025 08:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3iOUGlJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB8D10E52D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbSan3xZDrN9QCNT3CV4N4oC7fACHC7nsl4vkVJuVvT5/2Gl4TUw080k08hUTBSP8MWqkWju34esgb43Tlb0I9M+zXsawHu0BqtiHlkNF98bztNOWtRGfE7R2safNpBg1OVqW3SrF2blb/qbUKKegqnTKisP1VaDO65X8gJoGqeMoVYmtSZknd4r7n3bYK1kX5vlgODlX69ha+1jvuqVbye60ZPoy4UA5CGKkkwNyaKoFdvXWgX4Nv26s3EFPidf96s85vbNIqOW8lPRPDQvVlLs8Kuuo9JpXrfCbrpLGQdDZWPVMneVrOQc5emypAQWBtAJ+u7VIozGdTPEpof7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok6Q2GrJGZq7kUo/ogvwtfGYH4GZfm+0hO66bkEARAs=;
 b=x5NEvwQ+mSk34tjbi2lsS5euvdQMxozqFuesuokfz+eC1+JO1sgt6Z5noxvv9M8YHMQAhlpZqX44g5P2Uu2Ka9m7yuma81O45qQ17XcKGfQqo5VHKJMnh+HO4ch+W/5WEsXL1xnQ/OxeGu0lFUCZSgjYje7fIVOxO8/axTsHJ8eIkqfgpVxEgGoAkVX03gVx2y9ln0aBKm7jWtPHIOW8LX5/NYJqGNT2uVpioSRVqTD+xLiZBy94E0jFqb6wkCL/ZosdwbsByIjYsK8jVLSsvyB2k1yyE4fVAk26r8W3NHv9CX2wFkb0DAGGjYXD39vH/TKCOQ7S7Y9m1ELGVVXdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok6Q2GrJGZq7kUo/ogvwtfGYH4GZfm+0hO66bkEARAs=;
 b=v3iOUGlJF/id6azXeg7sQ0+RPGPvKjHsRizPyFz4gCEKw9+QlrdZscbDeUDILRd+PMzuEaiCuUQNGIzahM+bz/bAN+Y1TrC+Eu8vo7Rk2aZcGvuBNMR4uzFOhxoBcZf+3nauCNyOQYRon3+ltink93ixLHS5N9G6YtrrwYmUexw=
Received: from PH8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:2cd::25)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 08:45:53 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::a7) by PH8PR07CA0014.outlook.office365.com
 (2603:10b6:510:2cd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.31 via Frontend Transport; Tue,
 24 Jun 2025 08:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:50 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 04/11] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Tue, 24 Jun 2025 16:45:28 +0800
Message-ID: <20250624084535.1178476-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 408e04ef-5be3-4f77-3218-08ddb2fb86b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJnMNlLRS4k5xuheZ4QrC4/PPpcLjtGwoewVi84gHLLk1Bv36hhdp/vjNu4a?=
 =?us-ascii?Q?+WjSQyDLMyIKHvohfWxUxGxYwigoXIsmkLeLNOhnd+cCrdJNq4ShplFWTIso?=
 =?us-ascii?Q?IgW5w5SS6ylK6+SVRAnFbeYmvcEJqGlhii0tIw/Hv1mDcES+W9/Dqq3MUrW7?=
 =?us-ascii?Q?Noxu/zTCUh/AOhMh2LdYVXddFBSH2U5nkEP6Sim03MSACMIOkbAxyNoysGit?=
 =?us-ascii?Q?hbdT8p/3XPxGeaxKeWdmKx/OMorvhMnhRVXZMWA5JdiAnGkorX0mFRepDRol?=
 =?us-ascii?Q?rOFTFVHP3itKyAXm2D4iGUge9RQaYyzmnkReT4p3epK9wzXWHohCkBJB9AXQ?=
 =?us-ascii?Q?uRTbd0QA5BwjcfF/8NTlk9RAzjUVGFC2suWVmaTCMe8yoZyVaZlzvh+gc/M+?=
 =?us-ascii?Q?tWYhzxKXKbsnELqShvo8s1QOAZAbZ/Mbcd9zoBpiBuKAZIjD8HVokIvuA1UU?=
 =?us-ascii?Q?jKaQ7yIPfZowswaKtVezYD6Lo4xZqRlc7FoRVM3xa3KIYGqZd0CYfI2mMC2S?=
 =?us-ascii?Q?VBsDmZab0ZF7eTMx/hO2Ooyo0lQgLlRR2qnsqEI1ARgrA/knXG2COxqdFDpb?=
 =?us-ascii?Q?3IpenfKoCW36YOj2pZL6SxEa11h2TgCI279G2KXmV5eq0OZcMIYwXPGAI/+W?=
 =?us-ascii?Q?RijF+/O3F3iG2AsJ8bqBs+5vEtCjzyN2BH5sjWRzZNDxFcIx1wtE5lqbW7Gj?=
 =?us-ascii?Q?KDRaGpGedY3kvD/bfKGG+CRrdj5XG3nUVR8lNzL5vyyJbrYuE0ZJlcY4f88I?=
 =?us-ascii?Q?a44BC92rU180vxXS0I4OQhet5JLBQa2CKZLh946fRtlMwclVWH3Q6ShO2nNI?=
 =?us-ascii?Q?BR12RPLVrNTcdRKpFC3d9ssCUUG8hBYqYhCmrQY8HKLnkNSl4LfrxlE0DbyT?=
 =?us-ascii?Q?kSQie1eFgZXJ9yT72SqWNJl7r7AWtQyXd++/GDnSefR54GQ2LRavq1NL1c/g?=
 =?us-ascii?Q?iPaQUQDHDpwYmNwAKgd9HXpsg287lA7M3SVIMM3uqeHfMAImaFfofSU7xxyy?=
 =?us-ascii?Q?H7XbBO9zp8sQgOoKfVCb+jlDFeV5/cA0l4NUjdj60MVL5LF8WpNFGq92ZrEe?=
 =?us-ascii?Q?wQp0VHwTEOydU76tLkEc1tp3vr2I/vXHVug1qJYsLYogsB1Bpi8MvxWAeWgp?=
 =?us-ascii?Q?w2HhTNMPkGeOympGNA7Zm970bmZ5ottkzYR2jLn0mBD0pzZ0DOpPclWROpij?=
 =?us-ascii?Q?XoBGWtL6bFgr/aBGYE8+lsRfi8QQYaCbnW45FLz+ApwOs89VMDAcIqEDMENg?=
 =?us-ascii?Q?VnHu9uVSTd0RAyVsjdPS+NfexvOi4BW0it30qBaNAunTo+bXI3ABH2FH0Pg2?=
 =?us-ascii?Q?irJrjq/OKbWbf8NAfCMjpKDs1EEI+wPLcbnv0XnXRC2tQUX8Y/42R3ZxONjD?=
 =?us-ascii?Q?4hMA0erYPiaP/pQZALwtUiLvD4XmBouSavsvNTl1CICdCVX5rcYFiXsyEyOr?=
 =?us-ascii?Q?GOgBLxi7HmjOa0EktNhLNKhwfJIRG/b6bhm5BcEKx9ntK5hiYSyUKIk2pFbc?=
 =?us-ascii?Q?ZWXzDRY6nZvoi2CNcPtHEzLa5D4tnUBvr2io?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:52.2105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408e04ef-5be3-4f77-3218-08ddb2fb86b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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

It needs to validate the userq object virtual address whether
it is validated in vm mapping.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 44 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 ++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index acaea4416ed2..a20f7ccbe98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -31,6 +31,8 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
 
+#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+				u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 user_addr;
+	u64 size;
+	int r;
+
+	user_addr = amdgpu_userq_va_align(addr);
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!va_map)
+		goto out_err;
+	/* Only validate the userq whether resident in the VM mapping range */
+	if (user_addr >= va_map->start &&
+	    (size != 0 && user_addr + size - 1 <= va_map->last)) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -391,6 +423,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -EINVAL;
 		goto unlock;
 	}
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
+		drm_file_err(uq_mgr->file, "Usermode queue input virt address is invalid\n");
+		r = -EINVAL;
+		goto unlock;
+	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
@@ -500,6 +540,10 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 			return -EINVAL;
 		}
 
+		/* As the queue_va and wptr_va etc are the useq cpu access address and they
+		 * are also come from the user space IOCTL request, so they may need a access_ok()
+		 * check before trying accessing them.
+		 */
 		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
 		    args->in.queue_va == 0 ||
 		    args->in.queue_size == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..704935ca0c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+			u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index dbacdfcb6f7b..4615d3fba530 100644
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
 
@@ -247,6 +250,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE))) {
+			drm_file_err(uq_mgr->file, "EOP VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
@@ -274,6 +284,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info.shadow_size)) {
+			drm_file_err(uq_mgr->file, "shadow VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -291,6 +309,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size)) {
+			drm_file_err(uq_mgr->file, "CSA VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
-- 
2.34.1

