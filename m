Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E34EC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BF110EBD2;
	Fri, 11 Apr 2025 14:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DyGyAAmk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CC610EBD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6tcOS1NIlmcaHb4bBywUmRwG+75oXBGUN7XfJVDaJm3sKyYDXacYOiRTRmNUJUskTnphwmNTC7d4/eQWbDjiLaQsBiRGUkWfIyRZ106cSbcfjNTkTaFCLTk+KR89Pzi1C/876r2CjOApUXd3sz2TrNL3Xv4LlEHrf4UM2ASf20PujRkWNF/h0enj9ipJUxcOorAC2dBjNgzEqUEC+oC39FgVORcgdu3CHdVnpIvHagoQSKr/ztyDfY7eG85LZyn0sDg7YIo/coI70NDs5d6JLVDkXq+wY+TdGNNcXtusRjwJStYyewN0bjPLUK9bOxOLwHypqrphyhSd+9TGmzI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChGMnx2koCH2Pt2xgOR5J1h5MmCDoGQUfjnQpjhnOX4=;
 b=dsCMYJg+OMO4xE8TvSGGqe+meODYrL9tAAbrYu+dA3PJi5wv7qVa9Y8ErWAL8kjYeYd9B+uSIqJk64ZDoMOw77/iOZnD9GFAwboLPGxS7El/s+if0oaqS8kfWCivfpIrsd+73qzSC+89lVtYPySKgvvn7hk/8+9I7x3rc3nk2BZkk333G4BZPy0NfZQ7TicIggoilFNhD/C70mX0LOu6ZGHY1c0ze+nzwSRbAv2np1/4LigiVzFudhbd5h5rrp3ik+shw0pYM3suNS3bbXroiJqVkMJhHK4CPQUymqldLajV1I8mVAYPM0Th0kZBqceAk/35dJBW7sK94P9cvK1KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChGMnx2koCH2Pt2xgOR5J1h5MmCDoGQUfjnQpjhnOX4=;
 b=DyGyAAmkVWPIp7hJCIU9xUr+YVahdq4IUI53+mFSGTuKAcUvL6IuRymJMzYCQbFXVUkcdFQPJaBx+Fkv+CnVAdKHBQLEUBagokB2L2hafkOVgxVPs4V1BdqeWDFtEHrcT+SiVAuq91p8T2FFmD0DxtZqkaCV9tpRdt6o9yvming=
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Fri, 11 Apr
 2025 14:12:41 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::fb) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 14:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/userq: rename suspend/resume callbacks
Date: Fri, 11 Apr 2025 10:12:20 -0400
Message-ID: <20250411141228.2722962-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 986d9fed-d607-430a-b601-08dd7902ebda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XAMAT9eG6CR9QaAcwYnch+MZEI6zqle0uHtfzzn+08nyn3Y88DxgNwdHtXWW?=
 =?us-ascii?Q?eWn2uRTmNTeTRkGNDoW2ymOboxaYQ9PtYEnp/mDTXYGy7ldPNgxbfZGAYGKR?=
 =?us-ascii?Q?zuBENVH5Xg2TxUj2ZgaWBguEONMkGBRQZOgMEkY8RT052KtSPGykyyYrW/37?=
 =?us-ascii?Q?cIKYhQKT2GnlXnL1qU/+Z3fdd/9cYZ6y/P7HfPIfcQ5eojEVZriL3HelB7KY?=
 =?us-ascii?Q?+h60uX5OHUZ6VY+ILbofc8egv/d/sYniDOto5Od/G09R53Gm6l/A3bCmCYdJ?=
 =?us-ascii?Q?Y0an4nY8f0JMNZXol022HDYhK5Z1DMjMkPiZnld7mbuwqEP0gLgImhxuSZ/q?=
 =?us-ascii?Q?Jxh6KiDM7vj8QfpTYGaXAyNTeBD2ghRF1pM+59NdZVhLVLXeCLMDQJ7y4Iro?=
 =?us-ascii?Q?Z2vcCQpOgYda1JhwJHUg5YJOvMUpCmbYCoAWJvgej6zTHP01SJCXGVXhQ90X?=
 =?us-ascii?Q?1ocwHbW74AOPDeDIY/QvTLZVCv6DEjDtHM4J2NV9WQJe5YWmvxt/hf4PwHJl?=
 =?us-ascii?Q?v1UDRzXXeA63yQ3IYzqngKSNmq9TxaPDjchR/1Jd1onX6PzC6V4NUBeaO0SL?=
 =?us-ascii?Q?TYv6S7PwFJWqO+x0XsMeiH8nceSnUlkKQGXJoFl0eLEhy0wmt4bY/6uyvY5t?=
 =?us-ascii?Q?A65bXWWZJZ1dHf9O8BU1N3tAOdxMVNLGy/SIrOmQu2n6oTRIPkpsG0SOb+SY?=
 =?us-ascii?Q?1CFEbNyCRyAYSEn/UmQjrYE1rPDBnJLi1p4CRODrnjPfLOKQs8pwVS/ix/7S?=
 =?us-ascii?Q?GgkCD1fRNXkotKs2K0HTMp4iTBr8dYE/67jAf76r0KNhVoM/TUnYbZ4Cb/Y5?=
 =?us-ascii?Q?SCy2TyyPQVcm13nknpGuJETK3pbyVjWOGpyucyzVZ45J6bjGfmEq/1az0nyk?=
 =?us-ascii?Q?5bZA31yVPbatIhx8C45/0ENTa3p1sYxlhp8QGrkncSgHzyT7OMU1EDnJfJhI?=
 =?us-ascii?Q?12j7vZVF25aEkyjf7odsr3EkWYUECt2qIsX+/0JmoRoB5ZEweGpmDu1wUpuV?=
 =?us-ascii?Q?HQ5Y8iVNxyjb8rpFUbN8wXUcH1xVVeQqkZosiUC2o5H0nvq9bb8TMQcICh2Z?=
 =?us-ascii?Q?c0tv5KEMs0Hd6IwIwXVkcI2IPZibBigD/D977lvU2vgP7/0ybMGeQj5x9rkY?=
 =?us-ascii?Q?3G2efhslQAfJL6zDqcytdmFUlzkjOQrHAHiS91OBhNy43S31/yWUn3uLGAGh?=
 =?us-ascii?Q?/3dfZaVAVOFeMyYcmv4eAWbAFTbge9CI70v5+Zdcz2Fi6l1TpK8tGhl1mjVZ?=
 =?us-ascii?Q?9l3nQ+d0Lw2hFm3ut9SqZ41VBaJH7FW6X+DJuFjoBX20agWMFstVfgH1t7up?=
 =?us-ascii?Q?XthOe9EUNVuDmKbaxiYr8XDNJtdGPOVQ6fxp6cLsLGspcs9BUwKl6jmuUNSj?=
 =?us-ascii?Q?4ZJbVk+7TQQiqOnktgFF6WxR58RyLw8/FxMxnd0DogObw/+7Xk93zSN63o+F?=
 =?us-ascii?Q?ESPF11qZPbwYWClJpAa6mFIt9HXCoiJ/wRqdiDLlXU2FcuoXKlHF5n7oDASV?=
 =?us-ascii?Q?TX+fwvQwiDMUoKKIlYQlx+VoI/HlIFHaIFF8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:40.9884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986d9fed-d607-430a-b601-08dd7902ebda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

