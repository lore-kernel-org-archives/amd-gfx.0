Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEE0C04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E825112586;
	Thu,  2 May 2024 16:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UkXPsV6V";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D298B112585
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQYHwpVrjS2k0koWGGI9xeJt13vpqygIclg6R2JeWgFQ+XSvz+PSKrOmLQObbn/Dj8Alhvz3v3i6x3ygT3L9UA+6MbUSRGPzKYor4njcFuErRw0z7+d9A14wABC5bWFA0BK2lt8/e6n/r1xds/FvQdHslUzV/6nD+59YaT307ArJhB48DP9UG0930Tf2vvslSMRlOWVRZT3kbHazCt4Odcda3NtoHat1hxumC/i9UfqDHIUzQXngumAu87RMYYkgZFeqlOik1Lye1WadjpZtEGwCQ2MexQbIAB3PY8Bqe/UBHmwvlqYpjpiHF0Wu/+i12vZvJNNBornS/PZvYXfK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USRUi48f9kN16gw+L3nV1wuIA3hM01KMo5jaBx9LDO0=;
 b=F42Ipwvn+j+b2DFIKV8dOdxamginTeEhWyBb6XgQq7HFoyuisQY7LXHWVuBavx5lILNZU+iULEI/etSow0O8ewCA44CoqNqx6jVXQcJtY/guEodr1ZmPACLuTnwxFi1FhKGK/4iQ3hrHi40PLtpH4zdYHltquFfd3MCjnY60jvbD+0jUWfT75PPonNH7qgCMtTL/WH1SSKqGSQftih6w6HUJY0SaVbhQVLPbknfbEKVPhJZtnwgBAOYM2G54mG6XFOgyaQAIFm4Mhl0Z6KgBhBDMZe5OqcoFjwORobTELF/JRqFr9LleYgCW98VCQqfkTVcVy4OrslwdOaO54+3VHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USRUi48f9kN16gw+L3nV1wuIA3hM01KMo5jaBx9LDO0=;
 b=UkXPsV6VMDN1e2BvEkG+iQEn0ala/aklTtxIALeQYNneBoFvDvX9gCRCcVj3A8gmrfKxdYeNNuJ7rmQbWc+JDDGrtpCeGuT6DVkg/aedugJYRLLAR2XBx0RlakvgeX2D2tJthHz4UDk4pJwxS3rxGwymsLH7jlG55SF7Ewi+e68=
Received: from CH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:32::29)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.40; Thu, 2 May
 2024 16:32:38 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::37) by CH0PR07CA0024.outlook.office365.com
 (2603:10b6:610:32::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:32 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 08/14] drm/amdgpu: map wptr BO into GART
Date: Thu, 2 May 2024 18:31:45 +0200
Message-ID: <20240502163152.1382-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c46740e-f01b-44ad-65a8-08dc6ac57af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nRRQPtKGfhILLFyaNNxZgmudO3O1hG202FfJMecONUd20TsujmYhbQ4UiLHL?=
 =?us-ascii?Q?Xwm8n6EUXiepTejVrGpZmbKAiYe4Cwwd8G9L9+Lg8na0P/Vl3r7R8jDG4+w+?=
 =?us-ascii?Q?kmU14pYPmR59L1Cjhr5goFQZciXo/nDuxRagJYtUX32QOPEDoND9xev7WpEj?=
 =?us-ascii?Q?R0L7cr1XzFdAqWJnFKaSFTOxoUdfDs9rokkAMGmCziUiJWS9IDucmV4s25FK?=
 =?us-ascii?Q?O4pSwfq4sLcCuP5xNamLYDbAy2gJvt8oewI/uQfT9zMcZtl5QSaotI5GDhPA?=
 =?us-ascii?Q?K8OpzvMEumFT6wkRYtj3iI5KSeEl0YzG0dG1B5nirJyz7+h6bzow+S9UV/MB?=
 =?us-ascii?Q?j4fXB8iG8p6ZwTXaiuGdGscPAmm+XNNnR7HRadW5o84pL0ySdsAfMjPwScvy?=
 =?us-ascii?Q?iiqZNMLhTKIWTMZMaCDDovfpQa9NIxvPZtkHiX8lHolN4AbcABaSC4c5RFDl?=
 =?us-ascii?Q?lqZ48zE6S8UtgMWAKpQlRm9LHK1YJIsE9b9XAm53mf6h2hGdtNImUZ1SqLhR?=
 =?us-ascii?Q?1mnb5potNN2+TO5XEWXkQFavYhhXHQh2+wemMab0teNR80hp/mPDKQjs+AfN?=
 =?us-ascii?Q?icA0f6lkRROrNA7whZnCT6FabIuQFkA37zDMBJ4ApMVcnzodR39BTlngWe+m?=
 =?us-ascii?Q?GMxFSjCYX5Y4QhZNtfcnZqgNuzWpII+Gvnc3SKyP3sxm/zSfT9NA78A5GHkp?=
 =?us-ascii?Q?btZUe+jO/IePh/U7Y10y4CcHJ1ntWs8NBEMXizbACWVyIWXYET2R7VRSKPZ7?=
 =?us-ascii?Q?hzJzI7PnNtYS/RHSA8T1ZC+epRIakq+d9+sJ1drlbYsUl53ENG9sg3nme3xD?=
 =?us-ascii?Q?/5BLTv2CupS5d3Ud7ReINDzfVNe3BWLox7aL+s9TZmtFS4NfWxYgZllqwYq1?=
 =?us-ascii?Q?LjGNPJ2wzpp3d4I546ykvm3Hv3Hnp7SUTOiIYsDv1/nO3Emkr8tPHNE9ODOR?=
 =?us-ascii?Q?KyHf0pOrVe99NS3A8RDX3yLkBbQF8ptWGNYE/TwEIF8grIgAJZNbtoDp0404?=
 =?us-ascii?Q?8Ltiy8yCKLqqkZaG0GSSPnUdZzvHWYlfo6JeWfAKqg0svifrSWIId0n0kc83?=
 =?us-ascii?Q?KFTYUk3ROmVcBlC53+7aAVA0U6d/qa1zMJ62nQVNKNnhOM2Wb8J20qc02T9u?=
 =?us-ascii?Q?z6hcE+rwIPYSDSS8vP8+xmvOwStozEJLJvi9y1wHSTgnbnP+toa9qmuWTKJ6?=
 =?us-ascii?Q?pFYXr8ynq6xR6Au9+0mcCwpdo/yInsyAJirC4iUVCjDNjFXK92HLAFE+GQmC?=
 =?us-ascii?Q?3iSTeSUXdvhBhe2tKeOWc2aiFGQlBBO4OquTHPrN6awgv45x7Gk5lJ0jDzjQ?=
 =?us-ascii?Q?u94hOcl4aIBa/IoOzli5D++YftNBHGumTnDrlxEI8f4wR7zesBO9Ogyu/nLn?=
 =?us-ascii?Q?HdABZZE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:38.2249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c46740e-f01b-44ad-65a8-08dc6ac57af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
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
index 874ea3901319..6ff04647b62e 100644
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
@@ -184,6 +252,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -213,6 +288,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
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
2.43.2

