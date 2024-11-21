Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24211D6ED28
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C505D10E93A;
	Thu, 21 Nov 2024 13:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EQ+rOPdY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C1810E93A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4FtOD6UimABnSLAaZxv1vo59R52/236AKTJJTfI+JQATfGA3gvXRPwVruOKAjw+VEUsqwM6pStlDlx48X4UgQNdctLXJ9qukANUaIjX3DwIYvMHt+8sYpJue/W9gkhm66vh4Np5tjG/6ZkAkq75P7ag0w7PawRoMumXfM9zaeKc1pwzYajkyp0XulsaosMoREpV03ZrccEXssHFobe19XoWXA5QqtL40oxhlUh8gRTDC87t4nQr/Ni6NCgJ0EVsnX3p5GsmTmKtbc7Rn++SpectGXECmnf2iorO1igz4i+/7K5rEZ6bXpuisqpu3fh6+O1K2YJ2rMee+MYYjIPqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuXxP/LtxtcwvvT6Wu+Nh8sS7RMvBoN1GcVj79sJWTM=;
 b=DuRdFOqwzBNe123F3aycGgWg0J+xBCraCJTaF+bAOg8t/XXYVjNdrDFSwFZn2EV6FVRZghcWK8e5EPThwvHUCL/dn4tlKjwkpS64edqTSWvsKP2Dk9VWjneqqjG7aWBzI7cEbwhQY/JQ5b1d2xzy5VFCVqsmoLBA+5WKKgI6eCirqB6eeHZ0D+KVBGVULj63IVARlvx1WptJQAxTgJYtUW1GBzKyWKh6+b71Ge6tTjpKBWUDWL5tviT1F/X/hxxymA7ykUoeggOQWEMSZ0mM84ImyEdRCQf1LiFV72fwilF7TZ14HAjKkrUEvIG5/BUZv+AA5qHs0/Q112O8aFHQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuXxP/LtxtcwvvT6Wu+Nh8sS7RMvBoN1GcVj79sJWTM=;
 b=EQ+rOPdYrue949zjD68ur7r8zzfsQkYcxdXyXDnpgzc1gdAswjx+knqEorMFppd0iA7jOt+NJJRV73xV9nyd4Zmv8DVuQPV12UxbDDInBtbdeE21BdwNb2Py4nEl2pKDwHs+s0nF/3IBPG+hOxTXgeZdqZY9dRUqTzVZksacA28=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Thu, 21 Nov
 2024 13:11:37 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6a) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:36 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:31 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>, Somalapuram Amaranath
 <Amaranath.Somalapuram@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: enable userqueue secure semaphore for GFX 12
Date: Thu, 21 Nov 2024 14:10:55 +0100
Message-ID: <20241121131055.535-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e7bf77-006b-471e-d528-08dd0a2e077e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ElEA9qkZrgJ/bNVYgpvRTysAiPlv6ynylaQo9FGy9/PWlmX+woosQkQd20Ee?=
 =?us-ascii?Q?AL6CrMaLsMGNRwsgIPNCjPndxXtx+RbT8vgd7mRc7scPrxNcj6AgXVhctYhx?=
 =?us-ascii?Q?XdXmN+D75fr8q43T9udVJXmJ75XylnSKnDCzb7lpbYWlYw3ZHbYzcOkiaHrv?=
 =?us-ascii?Q?6sVkpMqP/Wser8D4NNRBT3BveUngGmRMmnxxAbxgt1ReC6vTwem3FvnoP7Ek?=
 =?us-ascii?Q?whwv3yNKET7KJazk0qMfdRI5cwu7bRwd9NO/fd6Ipc5QGuwoSbLihl5vcw7l?=
 =?us-ascii?Q?Ez+7cdwORjBFYUvFhazfdDP400ku+gxRSwunsIjvjZFgMk+ubYXbIxbJuaW6?=
 =?us-ascii?Q?65qFFMhvJMBYS/+DTKzLCpta7LGuvooN8UYzyDHuXkTsX/sBafyrCXZRI3SE?=
 =?us-ascii?Q?DSnsbo7Li7hfT949hQad+GnYrFZiJZnqp5c4okN1fcW/GKYBn8FKm+WVb6yQ?=
 =?us-ascii?Q?eGHrzTx226p+kg1G5mMuMfpASNhy7SJBxqG17dvAcop9fOjlvUsw3tG6Hq/Y?=
 =?us-ascii?Q?odAMx0i7qUbJ2b4l++NtMzA5DY3NCM2bcnFq1tjVTxK6Bq8yHdUhSceOpypQ?=
 =?us-ascii?Q?CMduxGSirEs02EXpMvShx/GEtsBy7JmmrLuaeZIOOHyonUz3iakf5Kl0DcnO?=
 =?us-ascii?Q?CfkhbBPrDit1WXirS4hdOuy9Rk3J6TOGnfXE4dFKqZ4iCZ6D3p9s0ELIqc7/?=
 =?us-ascii?Q?MurS19FVU/7Syd95reDVLxx/SVqfdVk2VU9HzyKwHUZX5gmmsAz4JBfT3az5?=
 =?us-ascii?Q?BAnIWtwBoiTczlUOTZx2IlDoL1Irw5aFfCtdj7g9kfjuIJIT622CoseepiOt?=
 =?us-ascii?Q?/ek+M3lg9qrwT/YcWwQM9xstOXeOhyTIoeFk58Wt1zITQVsR6MAKWjyQ1q8j?=
 =?us-ascii?Q?Z09DuV8YwDk4nLrmrFwb0qchG5lBbQ9V0cmfisTkCAU841DmoPUzpzqphjPl?=
 =?us-ascii?Q?Z15AQ8luSRbIisG1DbNH0A67ea2Vjw2IXzNkcshx3nkdvmYBZv1Cng6Ndas9?=
 =?us-ascii?Q?9ro9s6J22/5tL1Mdnc2jiaIrBqADVTrkwc4GANQJaTZVgS1K8KgxjUvPzOOI?=
 =?us-ascii?Q?5I8rsBAE4MDLOkXF28DNqqVSi+MsxmPwfBpawTlxuU8hQGwnhkWawflxHrYN?=
 =?us-ascii?Q?2NOgikxv/u3ffLa3kxONthmIVKQEUp5bChml3zlYH31bemVESEykLHNqAMIb?=
 =?us-ascii?Q?Jpf27AVpSaoIintl4d6o/ChGL7szSeiY6dyf0pIA6qy+v/3m9j/Gdsu1unab?=
 =?us-ascii?Q?bJnKg0cZmKBynCYTJSQX1p7q778Bq3VwJcLvxGjC01jQ4mleuv0xmsrMSWZZ?=
 =?us-ascii?Q?Zdbs7IgfHw834yIPQvHVSd+BKXiZH8Dd6fhRqIVx7/oSeqhokL/rG9He/kfk?=
 =?us-ascii?Q?OHIZ8wveSq3Yyk1VlkDkdRWzKc3KTmcEbIudaeawdHgtPF7RNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:36.5129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e7bf77-006b-471e-d528-08dd0a2e077e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

- Add a field in struct amdgpu_mqd_prop for userqueue
  secure sem fence address since now we have a generic
  file for mes_userqueue.c
- Add secure sem fence address mqd support to gfx12 into
  their corresponding init functions.
- Enable secure semaphore IRQ handling

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 27 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 11 +--------
 drivers/gpu/drm/amd/include/v12_structs.h  |  4 ++--
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2c889cc2a59e..9c4df966fa8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -829,6 +829,7 @@ struct amdgpu_mqd_prop {
 	uint64_t shadow_addr;
 	uint64_t gds_bkup_addr;
 	uint64_t csa_addr;
+	uint64_t fenceaddress;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0e5732795891..fc2e82eb0d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4058,6 +4058,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->gds_bkup_base_hi = upper_32_bits(prop->gds_bkup_addr);
 	mqd->fw_work_area_base_lo = prop->csa_addr & 0xFFFFFFFC;
 	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+	mqd->fenceaddress_lo = lower_32_bits(prop->fenceaddress);
+	mqd->fenceaddress_hi = upper_32_bits(prop->fenceaddress);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b151a75cf88c..ff74f7d389e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -47,6 +47,7 @@
 #include "nbif_v6_3_1.h"
 #include "mes_v12_0.h"
 #include "mes_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 #define GFX12_NUM_GFX_RINGS	1
 #define GFX12_MEC_HPD_SIZE	2048
@@ -2972,6 +2973,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
 	mqd->fw_work_area_base_lo = prop->csa_addr & 0xFFFFFFFC;
 	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+	mqd->fenceaddress_lo = lower_32_bits(prop->fenceaddress);
+	mqd->fenceaddress_hi = upper_32_bits(prop->fenceaddress);
 
 	return 0;
 }
@@ -4817,25 +4820,23 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_irq_src *source,
 			     struct amdgpu_iv_entry *entry)
 {
-	int i;
+	u32 doorbell_offset = entry->src_data[0];
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
-	uint32_t mes_queue_id = entry->src_data[0];
+	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
-		struct amdgpu_mes_queue *queue;
+	if (adev->enable_mes && doorbell_offset) {
+		struct amdgpu_userq_fence_driver *fence_drv = NULL;
+		struct xarray *xa = &adev->userq_xa;
+		unsigned long flags;
 
-		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+		xa_lock_irqsave(xa, flags);
+		fence_drv = xa_load(xa, doorbell_offset);
+		if (fence_drv)
+			amdgpu_userq_fence_driver_process(fence_drv);
+		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fe50c85fb2ff..93eb26f072df 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -183,14 +183,6 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static void mes_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
-{
-	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
-
-	mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
-	mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
-}
-
 static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				struct drm_amdgpu_userq_in *args_in,
 				struct amdgpu_usermode_queue *queue)
@@ -229,6 +221,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->mqd_gpu_addr = queue->mqd.gpu_addr;
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
+	userq_props->fenceaddress = queue->fence_drv->gpu_addr;
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
@@ -305,8 +298,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
-	mes_userq_set_fence_space(queue);
-
 	/* FW expects WPTR BOs to be mapped into GART */
 	r = mes_userq_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/v12_structs.h b/drivers/gpu/drm/amd/include/v12_structs.h
index 5eabab611b02..bbb6ebdc6238 100644
--- a/drivers/gpu/drm/amd/include/v12_structs.h
+++ b/drivers/gpu/drm/amd/include/v12_structs.h
@@ -535,8 +535,8 @@ struct v12_gfx_mqd {
     uint32_t reserved_507; // offset: 507  (0x1FB)
     uint32_t reserved_508; // offset: 508  (0x1FC)
     uint32_t reserved_509; // offset: 509  (0x1FD)
-    uint32_t reserved_510; // offset: 510  (0x1FE)
-    uint32_t reserved_511; // offset: 511  (0x1FF)
+    uint32_t fenceaddress_lo; // offset: 510  (0x1FE)
+    uint32_t fenceaddress_hi; // offset: 511  (0x1FF)
 };
 
 struct v12_sdma_mqd {
-- 
2.46.2

