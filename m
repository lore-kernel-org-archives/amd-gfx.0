Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D013AC369B4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA12910EC62;
	Fri, 11 Apr 2025 18:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GpKhIwVb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B70510EC5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quCLiNHLvbsm/N4QqC1s2r8MdEwuboJ3b8rzwLEmyLadDbIbHoT39CSLM37tKinCeto9JVzJQZ6RuaxGi3mSS0YK+vZr/N3eFVSptJCqyzFlQqeSjeTWmi3s0VGv8INCPhAjGg2NYB17tkgc4ve1VEzmYM9yZKgTK+rKbHS6FJ8JDr7iyXo6Hsqucn7ERPE3tq/XM8afvFekvnB6jDTEZ8lMC0pQwxQa6t4SY4UqTS4v7TOkZULUDu2yJpmLUzqe5z/zIRUd4bU5T9WfJcElQhShb54J9GTWaDUYO9LgGXh5ijqN1lXHZUW92rkV/fg1bGAvpF5jSMcL/lxL4tEbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChGMnx2koCH2Pt2xgOR5J1h5MmCDoGQUfjnQpjhnOX4=;
 b=ZZ/QcflBLmi8d81Hh6eg470qE6B5rcs9TVVLY2PmkQkwMsCQEvqB5GzFNtn9SeNwML97Zgxyba7MwfeT63KCjD8Kp7FVYPONi6aReByvOqhOQl9YTUGR2bFD9uB7fmDjxB5IM7w6UwqSA8wGrFZ35V38Kf+2f3gagw4Dg8cE4MzbfgJllj7antgfRk1pYr+b7ZCErQPurQamoy7GW940zN1V2OZLN94wE8vUEQiNXBp+Yn8plqs9MRN9wdrQBiseUW3dpztocyWDvPuucQ7FndytgyCvoa69f70BbGYEYCtkta68Nybzv/Vu05EOY/isEyWAXmRZzcKD4MubQWpwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChGMnx2koCH2Pt2xgOR5J1h5MmCDoGQUfjnQpjhnOX4=;
 b=GpKhIwVbeFKNLiO5Vm5IBW0OwkIJuhv1RAsS4bcooW2DiTjF9w97qRWbdfdSa6iUKijrbHyHqj3AI9tyada9qm4nNpUI2BZi5vbiFWam38ZpAI5kIMI7Fiw4978cfWnCdLRiirYVe/DQZrANhL7+uhViZgyNRhJTD2NxJT94R/0=
Received: from BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 18:48:38 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::a7) by BL1PR13CA0288.outlook.office365.com
 (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 18:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 01/10] drm/amdgpu/userq: rename suspend/resume callbacks
Date: Fri, 11 Apr 2025 14:48:16 -0400
Message-ID: <20250411184825.2890189-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b1b227-4db1-448c-20b8-08dd7929789f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1dn+MauypIatBZkvIsKLrZUI2baOEWHtZ4hN/HbxKkMrwKhp5Yrwy03QDrr/?=
 =?us-ascii?Q?TOmHzxBCeZ2cR6OzSThfqGX+ICVqf6YDGdGIyRUlB8JVvAdUFowKCPHA71cO?=
 =?us-ascii?Q?skgLGwG7yrnZOqfAAcJ9+4W8fEBC9+bdeOgq5wFyet3Aivi5C0YNp9sn00yc?=
 =?us-ascii?Q?4r7h3Mvp1uh2fCC5VbCNLf1ZlBKER0HqRC90H1ri4Ux1fsc6oUi6DXNwpMs/?=
 =?us-ascii?Q?zK8oO5j1nBNZa1QyVrismD3nr7xRrlqpnTnrds5sRlPzvYiqghmRfQXCHvTg?=
 =?us-ascii?Q?W1wfQhOtdY0pEPOoOg63vZMxCM5Zr3Iyx+nTzGmXcMTQ20o24gcUFTyV4gVd?=
 =?us-ascii?Q?mBDun+K7VBghR/S6YOAsEM5ItVFvDWfr/pGHwFOjd7dH2QN65iWwc4LK09Fu?=
 =?us-ascii?Q?QbBPyStVF6Mk8RSo+chwByqwkpI61c9MbKEF1qqdGs/1D4D5wAVn5/YLLEOO?=
 =?us-ascii?Q?he0tHnxyF/iFo5ceShbwS2aCbg7NGH5Y3699bZ30tZuNbBJDsTBU1clMIhXx?=
 =?us-ascii?Q?5vJVponc9d1F241NaLrHGZxcwNs5Ec/whOmyYMEtdghAjJ9quc+4zX7/+BC2?=
 =?us-ascii?Q?DNYTGtKH79kSCPiH9XYjZJeCxcHZsE/WlLSTXVBvf/AJdOJ5qLeP2KNn9h0n?=
 =?us-ascii?Q?JwWxML9Z1QnF0dw1pOf3A+QQUZ9XnIziOV++pwxvtLFIJwMiH1fESMnP6s9y?=
 =?us-ascii?Q?hNWFQVWBLJ6X8OlpxVNrotdBNEwLq/LI+6rQtwv3XX5McROFgFvhXswBbsSA?=
 =?us-ascii?Q?CQfeVuj5fUgnTvnTB9IsQhS7lmhLmhRDOV8HzRiGodcrawQL1K//DtYOc4ZX?=
 =?us-ascii?Q?FT4U3JBBuGhbNBgosmMPkUJFKJD8Y+W5ePgoabfXVjOjVdoFyg4zpmayjrUR?=
 =?us-ascii?Q?7Wx4EzabM0s3Ig0RMeEsMBiJhIdRJlsidRbllCFKBJ/wLg2m5blMMUyDGrY4?=
 =?us-ascii?Q?gzMx+X8uiQ9xn5/3nDTTodXQXjOAi0NgK0H5vSamM2lYbqdcU4ti0SBHad6e?=
 =?us-ascii?Q?b6/v3u3qJMj88OuRAM81HUPRzXg1v6xi913pWKjoVRweFTP097aiNyfg6nzK?=
 =?us-ascii?Q?P/I+KBIVhcI11HqbopEc1xG2aVwe5jZZ336Vj2p3z7pt/8jECR5UkOWRm8Uh?=
 =?us-ascii?Q?Q+PGgtdm2oaT2avpXKl6g4Pu/ybyboYKpDj5KCP8jDQBwBxk9PPfeChGTMdb?=
 =?us-ascii?Q?11QVcONxP9H3knuWTC3p4OSDKz+dCkX7BLkjMPYxOyGcomgNntenDgAuczao?=
 =?us-ascii?Q?f3o2AvhcAvQ1VUavS8vOa+OT/jDGENf6EwwNBFK2xy+qLi6dnIS8KYJZ+88L?=
 =?us-ascii?Q?uuFLu+yqlON14HOanMlkAF/LDie6bfLHwvxzfMLIh5UXnUrcVWt1L7oNah3j?=
 =?us-ascii?Q?Eg0tA973QwM748gbKaGxLlP4OpSF2JhI779/k9O5PzO+FqI1fg+aYWbsRkW7?=
 =?us-ascii?Q?XLEhDKIk63/pfnBjZefiBgipFsWhTBkeYkEi2vx4w4SISHa5q7Zip2/hwFJb?=
 =?us-ascii?Q?KQ3StwGxBgtxmKrYhIuzV+9FzFF46bj2VzAQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:38.0355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b1b227-4db1-448c-20b8-08dd7929789f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

Rename to map and umap to better align with what is happening
at the firmware level and remove the extra level of indirection
in the MES userq code.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 10 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  8 ++--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 46 ++++++-------------
 3 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ecd49cf15b2a9..2be1e54b78997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -432,11 +432,11 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		userq_funcs = adev->userq_funcs[queue->queue_type];
-		ret = userq_funcs->resume(uq_mgr, queue);
+		ret = userq_funcs->map(uq_mgr, queue);
 	}
 
 	if (ret)
-		DRM_ERROR("Failed to resume all the queue\n");
+		DRM_ERROR("Failed to map all the queues\n");
 	return ret;
 }
 
@@ -587,14 +587,14 @@ amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0;
 
-	/* Try to suspend all the queues in this process ctx */
+	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		userq_funcs = adev->userq_funcs[queue->queue_type];
-		ret += userq_funcs->suspend(uq_mgr, queue);
+		ret += userq_funcs->unmap(uq_mgr, queue);
 	}
 
 	if (ret)
-		DRM_ERROR("Couldn't suspend all the queues\n");
+		DRM_ERROR("Couldn't unmap all the queues\n");
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index ec1a4ca6f6321..a0cf6978f2ba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -64,10 +64,10 @@ struct amdgpu_userq_funcs {
 			  struct amdgpu_usermode_queue *queue);
 	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *uq);
-	int (*suspend)(struct amdgpu_userq_mgr *uq_mgr,
-		       struct amdgpu_usermode_queue *queue);
-	int (*resume)(struct amdgpu_userq_mgr *uq_mgr,
-		      struct amdgpu_usermode_queue *queue);
+	int (*unmap)(struct amdgpu_userq_mgr *uq_mgr,
+		     struct amdgpu_usermode_queue *queue);
+	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7ae4759b5b569..fe6fc3e0a3204 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -98,14 +98,17 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
-			 struct amdgpu_usermode_queue *queue,
-			 struct amdgpu_mqd_prop *userq_props)
+			 struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
 	struct mes_add_queue_input queue_input;
 	int r;
 
+	if (queue->queue_active)
+		return 0;
+
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 
 	queue_input.process_va_start = 0;
@@ -143,14 +146,17 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
-			    struct amdgpu_usermode_queue *queue)
+static int mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
+			   struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_remove_queue_input queue_input;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	int r;
 
+	if (!queue->queue_active)
+		return 0;
+
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
 	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
@@ -161,6 +167,7 @@ static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
 	if (r)
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 	queue->queue_active = false;
+	return r;
 }
 
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
@@ -314,7 +321,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	/* Map userqueue into FW using MES */
-	r = mes_userq_map(uq_mgr, queue, userq_props);
+	r = mes_userq_map(uq_mgr, queue);
 	if (r) {
 		DRM_ERROR("Failed to init MQD\n");
 		goto free_ctx;
@@ -354,34 +361,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }
 
-static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
-				   struct amdgpu_usermode_queue *queue)
-{
-	if (queue->queue_active)
-		mes_userq_unmap(uq_mgr, queue);
-
-	return 0;
-}
-
-static int mes_userq_resume(struct amdgpu_userq_mgr *uq_mgr,
-				  struct amdgpu_usermode_queue *queue)
-{
-	int ret;
-
-	if (queue->queue_active)
-		return 0;
-
-	ret = mes_userq_map(uq_mgr, queue, queue->userq_prop);
-	if (ret) {
-		DRM_ERROR("Failed to resume queue\n");
-		return ret;
-	}
-	return 0;
-}
-
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
-	.suspend = mes_userq_suspend,
-	.resume = mes_userq_resume,
+	.unmap = mes_userq_unmap,
+	.map = mes_userq_map,
 };
-- 
2.49.0

