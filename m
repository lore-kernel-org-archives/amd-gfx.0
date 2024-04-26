Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF975C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED3C112411;
	Fri, 26 Apr 2024 13:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z0QJlAow";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC90E11240F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO4Sg04CDxau0skcrYE4YzakE4MalVqgLZhsdj3P5lZ9AFEmnwL4JxqaoOQ/ahjUpG++Qu38Y5sYd6jX7OhOVPh0f0OKDbhaRkoqNktuABce4siy/pXcBX9Yll0MMN5fFghUTpkOxvRyNWU5o4MmtEIoFo8Oh92DGkmdaayPEyvRjXuDLjs3LuIGZRB/iykWWv2UfaUq/RO3DnPr5ymqevaASQDzm0EbgKwPHyWF1aZju56nbdnNJqHMKXdQu2qMiOmOv/gnVpdRoR+NviD55sU3YeO7M0UeHZw6l9AdLUXNJj0mEIcY0c3YQnW5lYZp05UQk9ZWGKlGxFV1jzHyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLh3525G3AyyDQiAbOQoS/KDssQ0k3OZalFCQzxDZac=;
 b=RB06SeVQvO2+OhZidIT471lFdtFm0B4CxBxhFsOv5Le+0TVN9q8mVUi7w0JrWVmnJ7RuBgGtaZh14/4K8y4wtDZk9tBEtsntdTXYFXQnqRe0dX6qHubYlpU5d7BRmnOm9BnnevIa5hLsgWQVK2bUsa+rho3DCKx/hdz+idfxDZq8AqqOrw8ftdSp2q2jlXU/6TKegkEroBBJ0cQkXYY1PeUMfnFwhQnQAIx8b9sAMpZDCldIBqL+3M3wKsW2dLiR7B0AyeyiQadf+KdoBIvBzE5GUl3unDqr9pJUhazHnvyyIL5l1HKYMetUgHeeguo+e/juk/bS1D8G2USrhXlVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLh3525G3AyyDQiAbOQoS/KDssQ0k3OZalFCQzxDZac=;
 b=z0QJlAow7htMSGBH6fXRi9GgBdxZlhdytK6BCrVgaSfAN+08Axz0ptCN0UURgVL9AgUmoafvSpGmeREqXQv53NfS8I9vIKlBNWBj9o97ARWJuIBuWJBR6Ibxp7YOW7cCxUAu20oY9+Z9qS3hOK3IijCQdI3UCLUa2OaiDtuLl2E=
Received: from CH0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:32::11)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 13:48:48 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::29) by CH0PR07CA0006.outlook.office365.com
 (2603:10b6:610:32::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:47 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:46 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 07/14] drm/amdgpu: map usermode queue into MES
Date: Fri, 26 Apr 2024 15:48:03 +0200
Message-ID: <20240426134810.1250-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ab0660-6d67-4867-cfdb-08dc65f7990c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V5slvQGpgLzU5MGXzPVBrG6BIbYhHBmjpqv6+kQt7kxPA2/T9RzuQTRwyzSv?=
 =?us-ascii?Q?SXYDzZ8miNOaUEGXX1v8HmAu0mfuU8L692ZBW0gRXy+RpKUO4J4vPPwNIViY?=
 =?us-ascii?Q?SJJv7ZgFbUxLd4sH1QWRGO94Jmq7nvAOYTyPIrmsE7ZIH9mWdM6tUeXvGGCd?=
 =?us-ascii?Q?2wVWP4Cw8ndN+ssugHZSqOFJslgvwQkT1mzemIEtUb1FKt05MqRZFSSY0pv7?=
 =?us-ascii?Q?FjP0Y6xU3C+0ycRZlKXG6tuYTVrUE9bHcTeW+fyILbcC4CEAv37D5ahZXC3o?=
 =?us-ascii?Q?VFHGuztbkTNxm4pDv/KvPiwmmZ+djXP4ww3iHg959HFYrO+V2kk0XfhjIXLE?=
 =?us-ascii?Q?+0tNa1sRu8W0vfpHmFZJoyku40KRWaQreTUgIRPWE6SS1EXzD0Uq8FlGrd7V?=
 =?us-ascii?Q?KLaqjRuTKQ2z6dQO+mUjid+XtslrSc6JGc/QCeUrnNEQKaXlQWJMVwRCkg89?=
 =?us-ascii?Q?6y+DX5QUNw5DL1OYc85heoXfBwOLm37DRA0wKvNI544qMoe33+sinEwmJ9Uz?=
 =?us-ascii?Q?F/Nr2mJV7JV1wAiCFsBNIyVCUr8in5Na69BDsGPS/uzz5vvxBLWn3k5l3j8d?=
 =?us-ascii?Q?66r76DD/sAy25ebsjPi95vtTJn+FEw+3o3F1ISvttQGDA+z6+qRlXNBMybyZ?=
 =?us-ascii?Q?/R+YRJlJLXi55/sw5CJ7d4dvY6iKLT/wA1O9NVm/P0aM2XhAEiQWMwNOVF8g?=
 =?us-ascii?Q?eiIr2XX0qkqKIIaxcH3YnfxtX02gqSGcdC3TevNsoZ/F+MeVLxnjEpXMKcI1?=
 =?us-ascii?Q?WkkQ2oPYHsozaKu3HH8519uSomt15c5jPQtX+fp+NbrO2ewmG7YbUFahxEEB?=
 =?us-ascii?Q?7z5AdIAV5OzdtcHRYbWE4wk9ocE+ivFD7OhdvRaGCzl7zMh1SpCFnFdaDWd5?=
 =?us-ascii?Q?ASgXn/HYGtcpSCPgfVHQJfaEXXBDlzbix9vA3NC0nZc/Z+MU2z46fmDCX22z?=
 =?us-ascii?Q?ZT1PUFLctU4joJnn6DQuYdVBXxfIpzRjex7H7lgyVXlfsLz0doqS6SjI5te6?=
 =?us-ascii?Q?/39T/RFJtl4SfpeO+H+W8dc7WOZJCQnkoEv3QHAqskSLlcZLkYXHx56F+eHv?=
 =?us-ascii?Q?RauSSpKnsY6QRuS4ghC4pwcYYsE6b30V+gSrK6Vn4sWinq78jljYOTsz7GdT?=
 =?us-ascii?Q?kTgfTg1cioXdf4379cj+5XcDcd+Adg8FQxIGvB3qcjUYiufDCYQxtUbe8DL7?=
 =?us-ascii?Q?8NHbx5TRyK1hnbD538L2mKiFsYLimSCvPKsXMkmAR42eCyYF0rv/xkmWX/Ak?=
 =?us-ascii?Q?rAohfAUCHNINI1IGbShwQgVfbS2rW/0orw7DjaqCEu3Uz9HOslCJfHyvmuM3?=
 =?us-ascii?Q?+2M+V9t1vQA7yvAqRLsRM5krAKmxLJFF92jm5MHzmxz6Vhk2umwReZ9h/Fa1?=
 =?us-ascii?Q?DSxsy4oumOipdIchNqQPVjVPmaiC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:47.7755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ab0660-6d67-4867-cfdb-08dc65f7990c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

This patch adds new functions to map/unmap a usermode queue into
the FW, using the MES ring. As soon as this mapping is done, the
queue would  be considered ready to accept the workload.

V1: Addressed review comments from Alex on the RFC patch series
    - Map/Unmap should be IP specific.
V2:
    Addressed review comments from Christian:
    - Fix the wptr_mc_addr calculation (moved into another patch)
    Addressed review comments from Alex:
    - Do not add fptrs for map/unmap

V3: Integration with doorbell manager
V4: Rebase
V5: Use gfx_v11_0 for function names (Alex)
V6: Removed queue->proc/gang/fw_ctx_address variables and doing the
    address calculations locally to keep the queue structure GEN
    independent (Alex)
V7: Added R-B from Alex
V8: Rebase
V9: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 9f9fdcb9c294..8d2cd61af26b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -30,6 +30,69 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
+static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_mqd_prop *userq_props)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct mes_add_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
+
+	queue_input.process_va_start = 0;
+	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+
+	/* set process quantum to 10 ms and gang quantum to 1 ms as default */
+	queue_input.process_quantum = 100000;
+	queue_input.gang_quantum = 10000;
+	queue_input.paging = false;
+
+	queue_input.process_context_addr = ctx->gpu_addr;
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+	queue_input.process_id = queue->vm->pasid;
+	queue_input.queue_type = queue->queue_type;
+	queue_input.mqd_addr = queue->mqd.gpu_addr;
+	queue_input.wptr_addr = userq_props->wptr_gpu_addr;
+	queue_input.queue_size = userq_props->queue_size >> 2;
+	queue_input.doorbell_offset = userq_props->doorbell_index;
+	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
+		return r;
+	}
+
+	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
+	return 0;
+}
+
+static void mes_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
+				  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_remove_queue_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
+}
+
 static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 					    struct amdgpu_usermode_queue *queue,
 					    struct drm_amdgpu_userq_mqd *mqd_user)
@@ -124,8 +187,18 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Map userqueue into FW using MES */
+	r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
+	if (r) {
+		DRM_ERROR("Failed to init MQD\n");
+		goto free_ctx;
+	}
+
 	return 0;
 
+free_ctx:
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
+
 free_mqd:
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 
@@ -142,6 +215,7 @@ static void
 mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
+	mes_v11_0_userq_unmap(uq_mgr, queue);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-- 
2.43.2

