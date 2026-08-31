Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC1CC61DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9884110E5E0;
	Mon, 31 Aug 2026 05:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9EKyt9g";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E62B10E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5XX3oM8xcpt7lrLoxTR36XWKn7GLWH93t3xMQyUThPeejm0nuVqJsj8QBWno0PttgneFxvsnhxgDRJtlcarZSzlztR9e+XtwLLcTzX/x/9B6L9d1VYe/6TJLSM9RDUtjqLlEcWaCq0bfb7iyVsWRDumPrfTobSTgv39pZ491SvlPW78/DEbwB/r58y3oFbDPNdMy5Hi3/0Bx3avocw2yNQ0BQtfYHzotNkMBeAGQPGUTxCkMelQkOI3sb0q9FJG5/R45A7lDAO3SOkvQSn+EJRUBb3fXeurNqyw32ud7I13dbJ9FSpc7xfRpxhs1hw50SSP5QEQEyvRb0kio4QHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT1S+pBoUzcRyRwtSGbYtN2mFz0kGvGv+BMbaA5vCFE=;
 b=lVsRBFRYcQlHTmNNblZsDx8akqJTnbQhy538+kcilAHNDmMIAE+V/rcGmuvi4+xkT5nRysurDkrFrHbTKtAkQf7E/93ghW7+agd9M8pHXN0rBbqEoX1tDDrs+lZ2bkT6DvJwoSvYM0FggUtBl5oRvLT/zUHd8rnWt9uBx/U8+vnDQIaBl35jITbRFvH2ZIzPwTXu6KhZwY4o9NpakNOMGTdiNrQmcGBsbvAZo3AEKIol2hK5pck8GDodWxtAsQyi/pnjYG2IFKg7mgPry05Sq9lNf1NsKIgPxE5mh5ZrU/I90xoGXZbJ0CJCuBqlwiZpkvCMB7lIJ5/oPECI7uQ8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT1S+pBoUzcRyRwtSGbYtN2mFz0kGvGv+BMbaA5vCFE=;
 b=y9EKyt9gB6wGYEmcrjA3YUq/2CCIBF+O5lys5VZ7iUACTupa6YSyQANOkXUu8VRPIbgghjCPfuBs2CXfpSSi5D3WCUlScdCF3LsBUoC2ghorIO9b/F/XWX4Eyyu9a7xZeBONali2Qyou6NXPzWJ+EiiTOVZ1xk93ZtSBkUH+Lis=
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:28 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::42) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:26 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:25 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 08/10] drm/amdgpu/mes_userqueue: route compute MODIFY
 through init_mqd
Date: Mon, 31 Aug 2026 13:24:20 +0800
Message-ID: <20260831052513.1518180-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 566ebbe6-3aba-47ca-de2c-08df07204481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: DKNUM+0GrioJ82zt6JrpgHriSiuhOIWkBpp8MosBVTpzDCgj0UI4LFckStOM05w9M3K60kkoja6qQofn+h4ek3cBBD0pSKaThiJD9BG8GbSR8+qqf3keaQghO9FyPUXhC2BWkt3kupvH8ZLxsmvUEJmrJN6Qh3Nlty8IQjZxFxUfmSfR1GPB9jG5vYs8ynNmzWO5j+P6JtdpFK0USFXblTF0g0sRVkJSNvoAyocWB/dpf1IDAFGeA9kA75q+LPQ1/OxIv++9iyJxqZDSryp8o/JS0h4U8diTk72uFG5pyRfqhOZjVuLy6VY5+7VLifJAxLZIAFPGt2wRFaxHCkXtI4DCjzBGitiwE8b8xrjgrBMfgV1sRS+fy/QjBBWlO42EL/8rP5rAVyWN8oui5379i2O4FyzZEVr0GexQilRu9JqOvatIcK4auLiTUdV1RP/lKyTuIVqoB8A+vP83EkeCBCpHtRkXrxIgQHZ6YcBuGBsCtosVFzyUDvu+miRdsmqZYPwT1dYZYg1jolajKLkbvAnh+kLpeuO5r2nDuuyKIuyT9fAOmOLIetO1IUjC9M0TzwEYI8qjy0kAna4In/VC/vBVD2b7DH9GgXX0qt20Zitq+u8HnMqaV3qttMfDgAC0PJRpUVcKo5DlH80pvn7U86jL1Io0Vul7AuLVlCS8PHUK0OZ2eQ/+8z9WbQPIoxwkRMbVOWNsCb2P3z9NpL4I5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q/bDQKC9bmAshQjuq68WdpFcKZ/KhTl1rAfHPxLdLAIv2lyW9X9nWLTqj08vlWMsQCPPvzVrIGJy58U6s5AVufySqg3bOgGfANeJ7k2B1acGCSHXoWkeAVChG8H6XTMplDIWDH+LHtgQBBAXoNwty46c5ZaqjOv3Dult5geF69vgISWz6iHK3Z/4zBMrfN3AlO52QB2ozakol1EhOcFCr6VFH3J9zX7v22skT29B7Cwf86nMK0VbWutFnILQijBuTJPhgwlvac17FtJuHHMt9mhug0W6w1VLJpCL8G60+LzmvPkxckhIH8S4DJCAZ4DVY6KQH2/6g0TSHOWRbhyOWN+6yUyDdjp3I5emwHzBGKXTLg8w3oXWbskPW6cytmksqSqtguy71vyxsihvj0E7UVmRmHxjQwXUyyZIFmlA7ocDRtvaJrbVw0ITKzZ+aQsu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:27.8336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566ebbe6-3aba-47ca-de2c-08df07204481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

Set prop->modify and prop->user_wptr (read from the wptr poll BO) and
call init_mqd, so a re-enabled compute queue keeps its context-saved
rptr and resumes at the first un-consumed packet.

Also set modify=false on the create and kernel-ring
(amdgpu_ring_to_mqd_prop) paths, so every init_mqd caller states its own
value rather than relying on the zeroed prop.

v3: set the mqd_prop modify flag and call init_mqd instead of a separate
    update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 686c92e96025..9fd0ab0be40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -840,6 +840,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
 	prop->use_doorbell = ring->use_doorbell;
 	prop->doorbell_index = ring->doorbell_index;
 	prop->kernel_queue = true;
+	/* kernel rings always build the MQD from scratch, never a MODIFY */
+	prop->modify = false;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 82bb4369451e..c6ac3194e4da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -479,6 +479,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
+	userq_props->modify = false;
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
@@ -681,6 +682,20 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+/* Read the queue's live user wptr from its poll BO; 0 if not mapped. */
+static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
+{
+	u64 user_wptr = 0;
+	void *wc = NULL;
+
+	if (queue->wptr_obj.obj &&
+	    !amdgpu_bo_kmap(queue->wptr_obj.obj, &wc) && wc) {
+		user_wptr = *(volatile u64 *)wc;
+		amdgpu_bo_kunmap(queue->wptr_obj.obj);
+	}
+	return user_wptr;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -707,8 +722,11 @@ static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 
 	userq_props->queue_size = args_in->queue_size;
 	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->modify = true;
+	userq_props->user_wptr = mes_userq_read_user_wptr(queue);
 
-	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					 userq_props);
 
 free:
 	kfree(compute_mqd_v11);
-- 
2.49.0

