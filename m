Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA6DECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214B710E684;
	Mon,  9 Sep 2024 20:07:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HuOqxniG";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4142910E684
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL7BqMYcf5+/PzSPHr7mrWLuQBgyDHkfNhKLv380I3oL8H4k2X2qqIaeF704szNWs3eH07w6MWFFzsGo4mWnaDdV1BCF2bgiqndiYjMSDE6j9Psjh1nPfJZUHFH3zfhGFz8rmw0ISNhG63RytFUB06beJnfO1lh2Psr5HeRtSpOYY8BpZCYXh50L4Bcsxu5SMeKtDihNFT96RMkjGRgqCd/OdMB+Cz3d+Sd4Xv61Fc2qFe32ycwOe+Sl53J6tqIOAnAWnXxVkybt6vMuepAl4z9CziLIN8PRjbZW5N/Ju/fuH/t1VRNInxSnDio6th5JzN3V1HRC0uxRNu4UMhPaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cam2HQP/0r24LcP5l+Q0QkqYvf016v5TSCoeXUXg08Q=;
 b=n7oGd4Si0ItRWzBTvIQevuJji0WV0RopPxFagLQ4RlRmF1Y5PP0idi2KSAAISz9Ky/YinoA6cTih0huiHiG8eM7WJ8vsssALdzKRAyLZ0V1+fn9D2tE88jY8vXGuWvARqgxXyx7B6yUZEopO1jgi3XBBbjbdgZ+Z3vKpcCIC+0M3kORV1heglNhpm+b4XLX9lkQFzLgoicpa1npsYO9iIZDbYyJ3xSSBM6Zhxdr/NyBYccF09s6Su+Mu+bdKkUlTDmowne9SfDDrxY5DC6Ci89oEo5mXmTUslsNqxNcpeZ85l3ut1D7TlJPqV+QDSD876V5KvGzAiJQ4n7J4b5fGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cam2HQP/0r24LcP5l+Q0QkqYvf016v5TSCoeXUXg08Q=;
 b=HuOqxniGSS8jVYx5pnj7/r+SpFePq3SemQsmpTnClWbQKqAu9/R3KX4tMfUQCyU35AupmYfaF5vPIoJuPfMuOuYsB4siruvLPEkIGCLiH/5SHLfN45oh6vBQpQomkYiNlEGxDVj47Xdlv0aOFvvz+MCQ8la0fykO5zqH/6Z0PZw=
Received: from PH7P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::9)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 20:07:11 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::6c) by PH7P223CA0012.outlook.office365.com
 (2603:10b6:510:338::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:10 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:03 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v11 07/28] drm/amdgpu: map usermode queue into MES
Date: Mon, 9 Sep 2024 22:05:58 +0200
Message-ID: <20240909200614.481-8-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eca36fc-1b2d-446b-079b-08dcd10afd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ghZdPpYbKkC1zOBfpcN27gHS6axmE4dvWwPfnISrcw8/kQQd1nc2ckOuvO89?=
 =?us-ascii?Q?7x8++cA6Sx5HdgEBRgG06LT3q2h5ajZkd07vLdcTbE1hUiC8mW2vve7PCIA6?=
 =?us-ascii?Q?S/AtvLQKa1/9zxiWB6qrFcWR5mfqd+Gde0knPDODXZqW1VilhKoI9ZsVH7KN?=
 =?us-ascii?Q?riLYll1fslnzkjVzrs9lNaUWozE6xEi+03k3j9NjzJHTPgr/AMYcp9ztTxRb?=
 =?us-ascii?Q?MBy/H2TFiGkBJ2F3ouzm3YfkkB3O2F4MAGlllo7Loj3VgwWFJodi0kmz50A2?=
 =?us-ascii?Q?F3jXTWeSrLsVQN4n+HZfz4fbav51MZPMWAnNL/S1otMYek65jnJyuE56ADGO?=
 =?us-ascii?Q?O88wo2FVUS+N0DU3J0bzo2hY32g88gbQWtRmdMoM1CVIxSDXTNQIAYT5JF3q?=
 =?us-ascii?Q?t1e4fK7bdDAnbjq6p3C9kjAUenOCdeBVtXl3Pk/q79UNnJgeLYon/Eu5qckt?=
 =?us-ascii?Q?+V8FcSiNppdfT9w2keGEaF9P27iqTJ6toSM76LW26zCxvL137fOQDWZbdrPL?=
 =?us-ascii?Q?MxVxaQDeDDRoQLdiwevvO9fu8qEYQ2u0PT3NHkXHR+NS+RXX/n0FVmbsirVw?=
 =?us-ascii?Q?zyu3HhOYBOQJS94NXraofb9wLRu1lPjskepoAhyF2V1y39J4oN07BcWOZupC?=
 =?us-ascii?Q?wO5sMdDAb+IV2KcXmVGjcZUIQF3iacST5CkKFOALK1KSw/UAoFX6Z5vHfa7Q?=
 =?us-ascii?Q?zhVmMLWPUMor+TTQMNEvFcymPh3MNwy6IJWu8PgZ6ofCDxsZFEvtf47ENZUV?=
 =?us-ascii?Q?FYfJBk06+Q/jvTmL0MUq0NvYd9p+4hEuNglf1OKiF5EyZutbmgjLkR4KAhGQ?=
 =?us-ascii?Q?mm2bZK8QyCssDQnR08NN+x3+74/WrioQi24rpka27xmfk826N4d6vJQskQ+6?=
 =?us-ascii?Q?Q47FjsQ/TBLj2QwwYvUoxnw6Ocb4Sgphw7LBfnXJp902Sg6oHGs3GNh9GqNk?=
 =?us-ascii?Q?RC5qKGQCJhhTRMyn0PrUxslPdsps+H5vWHIftY0GXpnC3qV34G6ILBwopTVY?=
 =?us-ascii?Q?sOnREOeNRCG0MbLsXLzNhlBrYWuwE7/NJkt/+CHsWIMrCccDTHyOKbacY4h0?=
 =?us-ascii?Q?+PAKN2p8Jz7qoNNsbd7mANb5w9Ry5b4YKoK+3G+PdK7f5+le9Bbt7PUGNpT1?=
 =?us-ascii?Q?Jx6jCaZJrH1VGv6r/TjPnjn5k3I59zB9dtBYkJMlbiGexKYLru8TMVaR33fi?=
 =?us-ascii?Q?+qSf95vjqxKc14Nt0f2/G1unUyoSX/9FGqa4bWIlvbdk4BbuMvGKMQL+BJTY?=
 =?us-ascii?Q?AJgx3zv32BYNS3AXiK9DbSQZm0Cxdtl2rw02+5rZiKihv1S3BaeVqhCOrnGc?=
 =?us-ascii?Q?N/badaze+WWgHg+DJasjyoh16Ea45cRBFz1fsnnS7MXFka51o1ZkEVQBXPNM?=
 =?us-ascii?Q?HvdSkW0IWheuMhw2aVJ8EewVeMTXuNP6rUSdhVTP/C2rjH8HTsR4zrGOEj+d?=
 =?us-ascii?Q?PHDxmZgu8tZwgZs3JrOApNn7fc8lilYX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:10.9203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eca36fc-1b2d-446b-079b-08dcd10afd57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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

V3:  Integration with doorbell manager
V4:  Rebase
V5:  Use gfx_v11_0 for function names (Alex)
V6:  Removed queue->proc/gang/fw_ctx_address variables and doing the
     address calculations locally to keep the queue structure GEN
     independent (Alex)
V7:  Added R-B from Alex
V8:  Rebase
V9:  Rebase
V10: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 2486ea2d72fe..a1bc6f488928 100644
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
 					    struct drm_amdgpu_userq_in *mqd_user)
@@ -105,8 +168,18 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -120,6 +193,7 @@ static void
 mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
+	mes_v11_0_userq_unmap(uq_mgr, queue);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-- 
2.45.1

