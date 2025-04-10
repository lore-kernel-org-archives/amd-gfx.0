Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A299C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8450E10E379;
	Thu, 10 Apr 2025 18:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qqQ/2ry5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3EE10E14D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBlwbkIsX9qHXD7mZud619XVkmQM1Hs3GeA4O6klbAuXZgqdU9nRgRdjQiDYp/BZ+JuXfGUfvAqWpOhxbkFwYK6a+zUp1RigFY+MX7f1OBV3N7JE4HPnDcfyH8icogwpb6Cr6weJSfeLSHZmshCY5QvzCGyvz9L9c3ePzb8OLqPqQKIDVoHtDqVk6Vg0npJuqj3LEynZtDvHle382e3iAa3YhmelCXEcW2jH1B9W69zt5rmNqfLKawx6fVaWBtG3Gp/wa2GuQgN2OfZAkqBkdh+ijfWJk+mxhPf93wYPlhZNOXsT90mmd+WiZZdTypxGDEn94IniEbf/OYWetIPmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6BousFz+Z6UaLReDKdAKrxvuNipcgysi3gJtW3IFwM=;
 b=enHMs2cJ+ts479fQaKUG44tnXeCg3qm2jn5Ox4EVzg47wWpe+apu8Vu37JS7tjAs/wUEqLneCgFM4o8IIekM5LDerXKurT1Qz6Pm0uDWscn7xGs03OQemzxvmZNc+sszW/v5hGn61oHWMBuNeAaRKAVnCKdtu59qJ7qn601/33veIHRB7YzGSRjon2H+nrRq6U5Ox6eeTL0a2odrIbsTtV03dGGQudhCd15P/rxmtnCsMhkLBqUMLEIZXr0DxKL4XcrKiQ/hbaf3XZhQadk522Fd4nIP1xJsoVcw0R+6QByXqdsMirKlYL7HVnJGZc7xujsUWz4pLIoMSfz6ppalYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6BousFz+Z6UaLReDKdAKrxvuNipcgysi3gJtW3IFwM=;
 b=qqQ/2ry5AbQv+ewajSjPqHTQUwPBknfGk9XwAMmEGxB5VtZDfInhPSxTWRAwmXJpRDmiH1Z6qKtPjM2OBLp9D3f2Ol7IPfURh2SqxKvUZ41kjfaWcbnO42OUW6jOk6ZG/atHYxPFyiYSfALWzAfiuPFCGNqfS6ZbeShh7RrgtaY=
Received: from BN9PR03CA0333.namprd03.prod.outlook.com (2603:10b6:408:f6::8)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 18:11:53 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::db) by BN9PR03CA0333.outlook.office365.com
 (2603:10b6:408:f6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 18:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/userq: rename suspend/resume callbacks
Date: Thu, 10 Apr 2025 14:11:30 -0400
Message-ID: <20250410181138.2287932-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7636c2-64a7-4cbe-10a5-08dd785b2b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fdPySvUzOHCvcO5iYextqhYRwmdDlxAZEkyKTwxLYsVo2vJ85u2+r7u5ql3G?=
 =?us-ascii?Q?o7GyaXpdmTHmJtEBrniATXExeTnisnbDmDpb09da8VJI7ZeyJuCxup/2taGz?=
 =?us-ascii?Q?PL1iMASWLIbwLkVNHWFnUzgNBrBkzKLEnm0Aj9SRVg0KaGH/aN0/HEd+3bRx?=
 =?us-ascii?Q?uXloBBV03cqHgnDL2fcqlpFhHluOKPqRagUSl71q4f3uN/T6YDsxVe6fzSLH?=
 =?us-ascii?Q?u/ahE41fmP3Onv5joXpzD3QrJ1+rIL25r0CahsZ5so3Lh3mg20TuDkdXfaYO?=
 =?us-ascii?Q?ua0awdnbdRgMYqCEsokiRBKLaJ2nOpgupuy9EcK+SXyv54ugfSGl1RGTJBvK?=
 =?us-ascii?Q?gj2yt5KE/1prAW091FqGwaK5Z18gcQxSG6uhyToMfxXZX66ki2SBlpS6uwmq?=
 =?us-ascii?Q?Xl3xe9yt3JruAUsSyN5DjnR6jwjBhOdJHK6VqCxWJl1sBDPC1JJLrdAOz5pW?=
 =?us-ascii?Q?uuEBZIVSKFWs7ECyuyHMe14DX+oGtTHoYvlqemy5dYT7eZU+zoXeLH565hQJ?=
 =?us-ascii?Q?OHSQNG4r5qUF3dYfqV5eqFMaLyZ/QtPnawQgQmS38da1S31f1d/8gEpHbcsE?=
 =?us-ascii?Q?4sohEgYxfMsnyC/4qtTELOz5fQXI5LpzCZ7tYb5Oxtj8n5bd7sAA3syt4dAV?=
 =?us-ascii?Q?3pOrRdwgoamc3pL8I4AMTDyZH9DMHPWYOAigv/UuTOCP6pc69u9UGQc1smFy?=
 =?us-ascii?Q?2J5NE8hcNEN7dwUKoIVWoVZR0VY1EY7JshmqzzK8kBBJ6YMok07Ug36A7jlj?=
 =?us-ascii?Q?2IObwzm4exA3RBcE5POfSMCFf1aOjJxZRHIBzPPqaQ0LbLGpTgerRl9YoyVz?=
 =?us-ascii?Q?txwV1Pr5o0KiPJrz/sIenCUsLEZzScZVqXbVoQPvRX/3hKKdMSj/bCZYoeg8?=
 =?us-ascii?Q?xNnPdxyZaQtUtKMYtov1EKoo5T3OQB9m6BwifTR/Nfa412YF2gRkxEr1/2UO?=
 =?us-ascii?Q?XcnZp18p5aAA0XnLIr5inh34ikwCgdSf5MdNib2GsoMRTaW/s0Lc2vLYhY3n?=
 =?us-ascii?Q?M75kR/TaGQzfObjfw+MyMgUpPfzy/HkgjuVeYEZ2WjxHkYG4flk5k7/sxqi3?=
 =?us-ascii?Q?eCKXOeAgHI423fiu6ED5EiEnO+zDQ5uwMZAPAnXXUKKRb+n0qTQiiVlHg+Q3?=
 =?us-ascii?Q?NxGl4FN0Ivz1Ts/JAduu0AREQk6DFeSeNCVR7RcMiprz92hT77aivx7lwIO4?=
 =?us-ascii?Q?RXqVxeIHQL29N2vRMJDGDg8piaCvicPV/alZbbIgohBJcweKXS1xto2OiVc5?=
 =?us-ascii?Q?/sScJn3QSLoBO+z3offOUb3uI/JiVYTy/PifY679gCrhakOAB1gGVDYqZMBr?=
 =?us-ascii?Q?k3uIehqfpfBS2RfSbzUfauE+oHh8UvJpLsitYlMGUc9Y4wEvwAEiIiDuvbkx?=
 =?us-ascii?Q?X1m0zW+8doxF7gAdHqHqzXuJlJuMresQJAqjfhu9h/WD/Vss99AfZBniCuUa?=
 =?us-ascii?Q?jP2DF1nFy5Jo5Ub4BA81/DHb5Yqa55ZBm/Z9y/0z8mwVrSQ0+qWMic/szCG3?=
 =?us-ascii?Q?7zcDs5TRNdThbjT14bjbeIc6TJUYuWLqsmBM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:52.0034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7636c2-64a7-4cbe-10a5-08dd785b2b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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
index b9705cbec74d2..94fee99bd2a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -99,14 +99,17 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -144,14 +147,17 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -162,6 +168,7 @@ static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
 	if (r)
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 	queue->queue_active = false;
+	return r;
 }
 
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
@@ -315,7 +322,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	/* Map userqueue into FW using MES */
-	r = mes_userq_map(uq_mgr, queue, userq_props);
+	r = mes_userq_map(uq_mgr, queue);
 	if (r) {
 		DRM_ERROR("Failed to init MQD\n");
 		goto free_ctx;
@@ -355,34 +362,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
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

