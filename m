Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5C5D3B7F8
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F2410E43C;
	Mon,  8 Dec 2025 17:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYBUv2J5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD9810E405
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKQe5p6eHRdBX3Mi7/apk7LCxWoU9GJ+XZ3AISyfFYGtUO6MNhsuIYZWAQiU/28Ez7komxUHfIGvL0nkF+N7VCzsdRRJR1oJ+7QvN5RYblqtKIL0ApfkUVPvusuT+QHFTleAhY29i9vx82maJBGp8Kh+fPVsF5uThjBP6wNefE+kH5lOvE5Teak2L41lYgVL8mVBd+tkydW6Rmcw6DXmefRTktrRzSfpXk7yi8Wes/rUp5Rx5+tRplNIQmoPwFZ9ijE8+T3b/VBeyTB7XAzM8D1kLS3ulBtenjYral1j7GTNij6pcTLUr+Uv6M2jc8dBbTWZdI35MUIWvH4MWyzeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzB4Wz+7mVXDA/jATrhHXNclm0nByg2SoRRzBEQOMAw=;
 b=XDo6B8DmWW2rykWTmpMON99/BO1jnV0+thQVe6fRVhEnfEb6vaMBuWrZ25eWugTfSpxE8PJGJ//1kA446HPyiNP4iTT07wQdrFJTRws4R6aEurkgjaAiczYoM257e/DP+5PsULGv55ylvpIUKnuP6pPo0P0RHg35N58RVQ9rK4iIR6kizn2U+yt7zh+e3ISETc1Ivgryauy4kqp9o01mnZShHgQ3qng7Ne4P2XOrg90baSsyJE8HFIkSQtf3anCrOTJ2ncX8+Jw0M5E85Al7FjpK5RvES4P07yKm0I56i9R5ID300ooNwYPEA31d3y7RXsBbP8sWCIX5Nkgd9yZKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzB4Wz+7mVXDA/jATrhHXNclm0nByg2SoRRzBEQOMAw=;
 b=EYBUv2J5MTdFHst99AmfbYhv166+4ItW9HsrtnXQJaLw3GKSOHMn72+7XZhj1AMw7ZtkqYazCDCQA+MvsL0aoaSmA1n4IefybspkelfB3sLjL1iZEcDUywv+L7w5Nz17lDvviGDpoL1yEcZ4d4y0lnqF1jnxKSx0xUFTJQeOQ8Q=
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:46 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::54) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Mon, 8
 Dec 2025 17:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:45 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Jay Cornwall <jay.cornwall@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update MES VM_CNTX_CNTL for XNACK off for GFX 12.1
Date: Mon, 8 Dec 2025 12:17:06 -0500
Message-ID: <20251208171720.153355-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: d13bc48d-bb28-46e0-5a85-08de367db481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5j3dobm+721D2C/sQvnTxyExIK7O4I3/oGBebv9VCrO8j/2H2Ej0fTUefTTa?=
 =?us-ascii?Q?PuVqdW3Lr1IR2giab0UgwCXRGze4vCMUQ5OEsm1Qn60HZB0I4qOWKLFJyTEw?=
 =?us-ascii?Q?3IXJEPpD5Oq52lMcI8szbhh28s0e5oeHG3pvRUZRK4dd0TD3+YvnXgv1v1aC?=
 =?us-ascii?Q?mlq2aS6wmTyGe6rLs1yF7olG1BHctbi3rcgU/RxJ7M9XxEOYQFIHF5pntdwd?=
 =?us-ascii?Q?fjeRflJZcxD2DcbvNfDe7hTXNAyFdWhSHgsN2QlqyV54JNfOwa0KBxAeBqrX?=
 =?us-ascii?Q?1PFMpXjIqeT/NCpkhaqCUZpxu3Z37BAke3Z+sx2ZbC+e9Yj9UD5A/ajBg7W0?=
 =?us-ascii?Q?Gnr4jVi1SuiP32GowaZe1Q47Gwz9Kkp6YL6lpzfS1vVGb0wLl5RlXaXea6Y/?=
 =?us-ascii?Q?w2NsMNmgj+7tyZqU56Mu4UNn9hVLhX/qJyM3qn7jRVfQMKTUdN0RglX0VZ/2?=
 =?us-ascii?Q?Z6iSt37Wb2BpAvcbGONJX6rjO0/+jzYX4XY6xCBlV1ikuQdvHMDAV0Ow+gv3?=
 =?us-ascii?Q?DWT1z2jnoIrmHyObMwjFqgWZNwHxNir8FExl5inifeq5c3cZQORlPP2wsSgo?=
 =?us-ascii?Q?SM1rARnhn/nLr5tN5Qaqa5ZjCA8K96BK7iUbYLRLvyhuZBtl1sTmU0EM6Unu?=
 =?us-ascii?Q?DPEx8Nt5kNLOwLyppkcv+LXX/yB47gtzJKAqDvv1aCehiPODo2k+2hmMuE9L?=
 =?us-ascii?Q?zqC61JPaOPnX33GRdxFpYdTvKaLJ68i7KKEsMWDP6VxEzMKlTDijXviaZHsd?=
 =?us-ascii?Q?480lZRM/mSgAXY7oHkyA7bhv/07kpoH917paJsWTKLjjFLCymwO6Spco18Hl?=
 =?us-ascii?Q?UyOtkV3+p242u3zE9NMlg7/FsvgOGtcaO31kxqLEfkq3qbdCEJvfkTy9l8jt?=
 =?us-ascii?Q?HoYSYDrQx+tMAlZgZZcccba8EBdSqj6XfVHbyxJLrVmMJC+0FtgA8q042t7g?=
 =?us-ascii?Q?Pa6YXwb24wrl4rePoqFvcE+tsxHPY8x+VK7XqChS3YAtMEoYkuMmtIbQ4XYL?=
 =?us-ascii?Q?67P7yfidXbJ4t1stMba3ho5K/kuDe2EsVHXDitErJSZlnLFLPmIja9tlE+aV?=
 =?us-ascii?Q?MwESMPmCKJzs46+cEUoLzBXK+4lYRtyj2JCnCZENMgeVOgJQ/eSLDuLZYGhr?=
 =?us-ascii?Q?r7GvWROv9Xa9tFWwaHBA9R7jE6ETvvhf7idVq4orNsupUJBjPiEsx5KJifZO?=
 =?us-ascii?Q?ha6MuU5f/k+JIN9mStLvToS5pOxQU0qQkcBfgNEEud33Qz4ONA4mTkt6KIUf?=
 =?us-ascii?Q?mxDT/VB2CIFO8ntQg9Wy3qx8VkHL4u31mSsCztOcd+bnWN/6wWkKS+o1hDle?=
 =?us-ascii?Q?IFoER83HBjBjBOuCuj1MSZ5OgO2q/7icSZi74OU93wP7V7X6S20pYXOxAIlF?=
 =?us-ascii?Q?aE69M1GSJeVB3lXDHz3GdUuSDBQhlo5Pm5RiYAU98HFNnKCT//82a903PcXH?=
 =?us-ascii?Q?z6PK83Tp+1FR+w5BzcCsGrmYvzbSEhukoyChn+d07UfNQw27oTb86ek2baJF?=
 =?us-ascii?Q?irBEi2nn7+tllG0J7+9inE8QoC92AeQ1zd+gqpW+t6Z9kZb0dZYkSNlpLR8O?=
 =?us-ascii?Q?Y3tAvq35qJ5i4r01R6A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:45.9046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13bc48d-bb28-46e0-5a85-08de367db481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159
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

From: Mukul Joshi <mukul.joshi@amd.com>

Currently, we do not turn off retry faults in VM_CONTEXT_CNTL value
when passing it to MES if XNACK is off. This creates a situation where
XNACK is disabled in SQ but enabled in UTCL2, which is not recommended.
As a result, turn off/on retry faults in both SQ and UTCL2 when passing
vm_context_cntl value to MES if XNACK is disabled/enabled.

Suggested-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h              |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c               |  5 +----
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    |  1 +
 .../drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  1 +
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index f99de1592921c..88685c58798e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -254,6 +254,7 @@ struct mes_add_queue_input {
 	uint32_t	queue_size;
 	uint32_t	exclusively_scheduled;
 	uint32_t	sh_mem_config_data;
+	uint32_t	vm_cntx_cntl;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 15b467b4aae40..913ce414ca9bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -286,10 +286,7 @@ static int convert_to_mes_queue_type(int queue_type)
 static int mes_v12_1_add_hw_queue(struct amdgpu_mes *mes,
 				  struct mes_add_queue_input *input)
 {
-	struct amdgpu_device *adev = mes->adev;
 	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	uint32_t vm_cntx_cntl = hub->vm_cntx_cntl;
 	int xcc_id = input->xcc_id;
 	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
 
@@ -322,7 +319,7 @@ static int mes_v12_1_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.paging = input->paging;
-	mes_add_queue_pkt.vm_context_cntl = vm_cntx_cntl;
+	mes_add_queue_pkt.vm_context_cntl = input->vm_cntx_cntl;
 	mes_add_queue_pkt.gws_base = input->gws_base;
 	mes_add_queue_pkt.gws_size = input->gws_size;
 	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 824d73ab5b283..1dbdf9465e590 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -256,6 +256,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	queue_input.exclusively_scheduled = q->properties.is_gws;
 	queue_input.sh_mem_config_data = qpd->sh_mem_config;
+	queue_input.vm_cntx_cntl = qpd->vm_cntx_cntl;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index e4ec7190fea14..9e70a5f8a50b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -52,8 +52,11 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd)
 {
 	struct kfd_process_device *pdd;
+	struct amdgpu_device *adev = dqm->dev->adev;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	pdd = qpd_to_pdd(qpd);
+	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
 
 	/* check if sh_mem_config register already configured */
 	if (qpd->sh_mem_config == 0) {
@@ -69,10 +72,15 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 	}
 
 	if (KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev)) {
-		if (!pdd->process->xnack_enabled)
+		if (!pdd->process->xnack_enabled) {
 			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-		else
+			qpd->vm_cntx_cntl &=
+			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
+		} else {
 			qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
+			qpd->vm_cntx_cntl |=
+			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
+		}
 	}
 
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7b70f794f3d0c..ebc637c38c04a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -697,6 +697,7 @@ struct qcm_process_device {
 	uint32_t num_gws;
 	uint32_t num_oac;
 	uint32_t sh_hidden_private_base;
+	uint32_t vm_cntx_cntl;
 
 	/* CWSR memory */
 	struct kgd_mem *cwsr_mem;
-- 
2.51.1

