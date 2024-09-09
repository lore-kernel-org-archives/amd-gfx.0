Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9554BECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EFF10E687;
	Mon,  9 Sep 2024 20:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FiXJin5U";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF57C10E685
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPVkfyXvktCOzI1pFuFLxPyWZU/98wgHpLPPuIkOCrV5EVktb4t7tpb/KBa+tf2Tgsp2EwvLJuH2hh1UxqWZPqXXDw5JG+4TGUYmn1Fa9QzBxInLupsPpVfDiobmu1oIfqPJDq2l9kWgRZ0Kkuba0qMThi31j83vA7a7HkwBXD+UThGLGn6aRbKHkvL0USD83euWgL0vjab/6K6cLpuvBX3YTAS2cXdKkkhL4fx7/B+8VFDLfCOc5QxRTB19NN2AV+rUX+ZNKfcz3j9Sw44fH8WvghKqnpWq3bbru4KGXHpftfnO+p5PlInSjyX6k49ts5lyPikubHa2Omwud7Gr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ayq6rDAb6Gie/5Kv4eRSk/U+SO8Z02yC+JEPD9AckNM=;
 b=KaWDoRXLGveBWQDIuLoz82M8H2lDC0PbTDOC18GLI+PfVQtV6KkqlPGaACzwkvsbiX2jgZeXa0z/naSbKrbMgKsnU2SuiFyvYlLySGxbMcccS1SQ8Q/oYZT/Zw1TUiendi7V23h7/HwLQxUMc0fqdwbmOhYszeA6OgD9XnrdS/u+2Gy9it0LYL3f7s0tmO1ZKA5Ui4iaeuMbsJQ+puqtuaQu9sO3KWNFDs2oEPdkFdURxzmDZ7MPSLe0XJ2oZLEAW8cC5a3my15YMLi4GVXnjvNyboARdY+cvP/HkWktQyH97KpNabgQ9ehxxavJi+QCs+JXj/16dUr6oPahLwH99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ayq6rDAb6Gie/5Kv4eRSk/U+SO8Z02yC+JEPD9AckNM=;
 b=FiXJin5UE6w02Sndl1lxcIPwU/BisXYhkQGwvA4tbHqrDDIq65qDqjTbg9At4vAWodCpt7Gc7utPs+9txtdGqVWQj7pjSCSuUyy9hDs/xUp/oxs58BPK8CLKTgj8awIeCc0a27SJ9UF0JlQTe0DSsKNx4tk6GxIR4ujeVNsol/I=
Received: from PH7P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::12)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 9 Sep
 2024 20:07:12 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::78) by PH7P223CA0004.outlook.office365.com
 (2603:10b6:510:338::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:11 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:04 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 08/28] drm/amdgpu: map wptr BO into GART
Date: Mon, 9 Sep 2024 22:05:59 +0200
Message-ID: <20240909200614.481-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: d174303d-8f3c-41b2-00ee-08dcd10afdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OLuR6/r+c4tGKldQAnv4Z0RbjFCJsKgfzSNdIfdH20WwNQbdjpdJTkF6ypnk?=
 =?us-ascii?Q?iZOeLUshq7X0e9KIpR45rN1McbxX1wkGEuLo/fZJdIITj4zanaFOBZ7c/6vB?=
 =?us-ascii?Q?buPn2skxJM4cIoOPnB5itcwctIohWZ60NuMjY4+H9+1nmQs4skiJOpf/ss3w?=
 =?us-ascii?Q?0yRUXitwD+YzgWP5eEMhsoUxh0/e4gZ/Xi06JQmTAOe9wbhSjcVF46g99fd9?=
 =?us-ascii?Q?d5O3U9uEY/ZjJIJaImFfJcIPmBP6C/3FdS9byCcDD9xilJjWP6EmWuS09s0Y?=
 =?us-ascii?Q?eWCeWh83LQC7ze2VTglI3oY+vc/5IrVWn8x3NNQKyjQ+6DftCpwTqPcf3fMk?=
 =?us-ascii?Q?QAATEm/wFfdM/KdFLxJ9Q10r7PbztCLCBXi7R+Qtu/V93GvBvtoO5MZyqktl?=
 =?us-ascii?Q?GSgsmJrDCLvBv7Gk3OaYCJri69JO4ios+i2wi0YXkDMwEAvtIR057BKMN8JJ?=
 =?us-ascii?Q?NZW/Dtwx+HMgqF26ihEzGbizrwwck0pW8PTNWESgCD7S8E5yFllEHytDvtRh?=
 =?us-ascii?Q?jVtqLQgUoaCOwfV9viNeU2Bd8Dj87uQUXQ71qiPkDMaRpXhuzkIz1PAOQfTh?=
 =?us-ascii?Q?sfS1gJmBNj0wQz7mtFWQnNYlTQ2RnPRR73ezU3RoEBC0LQyUXOHsBUG7sMOS?=
 =?us-ascii?Q?krzDhOFjuDfZb8dKSKHsqmed3o7dX0jhH9iCw5eqtUj9pMxW4uSXcceoyHGx?=
 =?us-ascii?Q?wEtVTEJHZpg62WM5D1wOaPYoDZBLbZjfyjVt/rYJag1fJmgz6EvYr1IK6UvQ?=
 =?us-ascii?Q?CyQWd80mCSYvkG+D/8Xaef9GjbyfSzfohngPh6i6pOJ9d6y/BA0lFNtodkSo?=
 =?us-ascii?Q?o9XOnN7M2nYHVkrBLo3daI5JOVqzjg3oPUaVBWOEzp4BzbFOmg7cEPjopUlf?=
 =?us-ascii?Q?Xo6QSYk0zeO2QVb8jRZ3UWr1imiYpvbCLn0h/B3z5PhHawUIhe6H3hnVgfS0?=
 =?us-ascii?Q?IjbsQ0xf2kOaKPX0EbeNH0U7NoS7Um+7Xchk3KYmCVhbx7wePXFeD8BwzfHd?=
 =?us-ascii?Q?fWvz5S+JP/Rf1aNCCP+hZQulJh7JH5SpKolA5Q9Svg9k1VTchdKwLcKRbf6K?=
 =?us-ascii?Q?q1tkyeq4qCgvuWRKtENO2I0FeZeRki0UDjGUcDAngVcygO91eSEtWQc6w7fg?=
 =?us-ascii?Q?jIN2P5HJ0wEJkPwxhPn9/eBhmJS5G1RbNDDtJOZBUsA4JkFs4PV1nSpBpel7?=
 =?us-ascii?Q?Mp3YaV+jufPoMI6xFHjUaRkPr8O/TeWd+vO6wbkA6EIPXz4pTT3h4NpLaoe5?=
 =?us-ascii?Q?xb6Qop+WtgfKNrNRO5M3uJMFgIhIjtqp4Oz7D39bX/vFh8fCTQltweJGYaoU?=
 =?us-ascii?Q?Y2q6kaFLuxG+FGFEd+krylAO7GyDageoOtWlnvO/cij0uB/55SfsV2GZJnv0?=
 =?us-ascii?Q?eMvQiO4sJPEU66S4zP0RjF6qzSthpfFMJoaVqcQcohGGJtsG1GTR6jdZwhwW?=
 =?us-ascii?Q?f8PsvfAdBGsI4wO4Aco658nfG1O2DkmB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:11.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d174303d-8f3c-41b2-00ee-08dcd10afdf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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

To support oversubscription, MES FW expects WPTR BOs to
be mapped into GART, before they are submitted to usermode
queues. This patch adds a function for the same.

V4: fix the wptr value before mapping lookup (Bas, Christian).

V5: Addressed review comments from Christian:
    - Either pin object or allocate from GART, but not both.
    - All the handling must be done with the VM locks held.

V7: Addressed review comments from Christian:
    - Do not take vm->eviction_lock
    - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset

V8:  Rebase
V9:  Changed the function names from gfx_v11* to mes_v11*
V10: Remove unused adev (Harish)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 76 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index a1bc6f488928..90511abaef05 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -30,6 +30,73 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
+static int
+mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (ret) {
+		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+		goto err_map_bo_gart_failed;
+	}
+
+	amdgpu_bo_unreserve(bo);
+	bo = amdgpu_bo_ref(bo);
+
+	return 0;
+
+err_map_bo_gart_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+	return ret;
+}
+
+static int
+mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
+			      struct amdgpu_usermode_queue *queue,
+			      uint64_t wptr)
+{
+	struct amdgpu_bo_va_mapping *wptr_mapping;
+	struct amdgpu_vm *wptr_vm;
+	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
+	int ret;
+
+	wptr_vm = queue->vm;
+	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+	if (ret)
+		return ret;
+
+	wptr &= AMDGPU_GMC_HOLE_MASK;
+	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
+	amdgpu_bo_unreserve(wptr_vm->root.bo);
+	if (!wptr_mapping) {
+		DRM_ERROR("Failed to lookup wptr bo\n");
+		return -EINVAL;
+	}
+
+	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
+	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
+		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
+		return -EINVAL;
+	}
+
+	ret = mes_v11_0_map_gtt_bo_to_gart(wptr_obj->obj);
+	if (ret) {
+		DRM_ERROR("Failed to map wptr bo to GART\n");
+		return ret;
+	}
+
+	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
+	return 0;
+}
+
 static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 			       struct amdgpu_usermode_queue *queue,
 			       struct amdgpu_mqd_prop *userq_props)
@@ -61,6 +128,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.queue_size = userq_props->queue_size >> 2;
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -168,6 +236,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* FW expects WPTR BOs to be mapped into GART */
+	r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
+	if (r) {
+		DRM_ERROR("Failed to create WPTR mapping\n");
+		goto free_ctx;
+	}
+
 	/* Map userqueue into FW using MES */
 	r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
 	if (r) {
@@ -194,6 +269,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
 	mes_v11_0_userq_unmap(uq_mgr, queue);
+	amdgpu_bo_unref(&queue->wptr_obj.obj);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 643f31474bd8..ffe8a3d73756 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
 	struct amdgpu_userq_obj fw_obj;
+	struct amdgpu_userq_obj wptr_obj;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.45.1

