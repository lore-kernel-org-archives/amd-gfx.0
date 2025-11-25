Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A02D0E6F9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19D710E0B1;
	Tue, 25 Nov 2025 15:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1EDgApkd";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BD210E0B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOpZbvcOd4AOUskcBiuP2u1V6HyLEUg1OF9PP/Yho6QJFhRJhQen7rhwXFGGNriNRPb5wGu3hriqEZNoazTrcXintgkvLKBjDuoaidJ2fPzAdxNNAKVju89dY278NlWhA53IvYEUJX9AE8dzYkBJjVgBl+ODxF/lW+5Xv3z+DyaUMKt8yLdV6NngjplVBAyBDqCc4yXOG6x2FUi1SYCCWMN6ybdMhX5vyInxjScnDGKPZ+zdVyBrZlZC8vY41rZ1LkV9sgb3BYIvmmC0uU/uIsruN8pMecwYjCZwKCSgzjff8Gb6vk09rxZrKk2XfL11G8FzMsmhrffdTfIkp+fGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvZLKBPOKgRb2ufEfNzSuuzp2pnCoHivkKLE6Nlh6g0=;
 b=UqPSoF/ok85uw+aRnMu54YwXScipDDXrxJveLP5hcDzBzg/sRjEHwl/XO4IDl+vBY6ZH1lmEngfnXD0BKiZHaVaMfYauxGQxOerLemUtBAbGpQuKrtV4to3scHkME3ZH820YfDo1mpCz4ifA4G3T+PEPetBSrQy4jEN4TTE0a3Tr8DEaNZ0ntIvPU26kruk3Pi10ZUptbASvaeiAyELxGAkgEPF6YSs75V4AJYS4vte02YOK3OYroPy4Vlc4X9iOhAOsuSGanDmWo01joygk3ZP/5mw+AIGteV0bfCjPtPBo1ZzagrMmv+QKbnvjiqWO4S9ptc1DEhxb0bwwjJ5y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvZLKBPOKgRb2ufEfNzSuuzp2pnCoHivkKLE6Nlh6g0=;
 b=1EDgApkda3gzXw/p4iyRZh4LedvxuO2xcFun/rG7tYnlg5XrIdEOvQ381QihwxQa+OMNau9bXWaZGZVZwjF4czj3M1lxYLCLuWVtYNY2BmeC+A7zJuh4Nvz5amdkXb44UQzu2jFyiNBzPn5tZtyG6kfaGuCMFdU3zA5wUa5KcR0=
Received: from BN1PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:e1::22)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 25 Nov
 2025 15:09:45 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::1c) by BN1PR12CA0017.outlook.office365.com
 (2603:10b6:408:e1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 15:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:09:44 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:09:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes12_1: add cooperative dispatch support
Date: Tue, 25 Nov 2025 10:09:30 -0500
Message-ID: <20251125150931.2046618-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 0260371c-843b-49ad-3bd1-08de2c34aac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?16Q6441VPVStbmxbeBK1225Zy7ZHzJgdqmmfFZ4wZ29MCxbGQH8ONx/7ZdDd?=
 =?us-ascii?Q?lYRe3LsL8XmhYCzvcnyvKHqhQvoEUJ1jH7zlPMlE5KOg5X3j6+UFKkVKmyUa?=
 =?us-ascii?Q?olaJg1qiBMtxIEd7/TJFFE9L+ZK8848W4/5XKFcSOeTV0BK9WR3IshQyd10Z?=
 =?us-ascii?Q?CDy5cenBuKptdz2hKcYvKL/586laY604xcQTLv+P/pCAeDQ9EheOHOjl29zF?=
 =?us-ascii?Q?uHV07twhPQm9QsXhHqKUDEjaEBmuGuedmudA9vNMAGgCLbjQ4hYlnZHMIkpu?=
 =?us-ascii?Q?oMS3px6P+BcFXSul/Zst/fz44Z7XiBLqXqTcZjLiEXKynZJlqhrIWE0X3yDK?=
 =?us-ascii?Q?Vm065llyPx6q7uLBlEiu1KUbkdq0CSd37P4TUp6FdgrE82U7mdBsB4OWZHyo?=
 =?us-ascii?Q?9KdWuA/CALrN6td2lR9PTZ1xAzoFHzIsFwnpyhzxs5uyZvWww5vYGS1dOBZu?=
 =?us-ascii?Q?5kitTtdfs7YzF1xybJSxPijzY/ez7XhJGpZHjpYM/vQUyk+em9UWl0IXiE9u?=
 =?us-ascii?Q?jVuYsUjS2jwR2aarQLsVbPYjYC9X4BiV+51xxMg4j4Jpq7X3HT0pi5h2keEj?=
 =?us-ascii?Q?/Ty9X5fIraoOeXroJg+PA2NpFl072cTnRkoPzqidF8DmxRlN07ofsRkmGlyA?=
 =?us-ascii?Q?zwRS0xga/k3Yjqcwl6mzHpwW6k4HkhprbwhTVFAWEcwWEIDOVroyeblKf3SG?=
 =?us-ascii?Q?TNT2Wadp1PYlywF9mNtp7fpRLWLlvup0wP5A2csZJzosFAlfGuS7+U1AbTXV?=
 =?us-ascii?Q?95ni82qbxC4GsZX/r+dkdn3FA7Vqp8AycxhVw7/ue/BxpejeXHJjX2POLxFr?=
 =?us-ascii?Q?0W3r1nWhRaZJe/aLu38dmDppf5LMdRGU39t7z29Qn/479A7n9B4wblosupEi?=
 =?us-ascii?Q?cnvNaZH4ERv8GQmG0ULanGR61Urme5W59Y1sffZaK/iiDiIpbyldLgUXp+Jp?=
 =?us-ascii?Q?WKIrKNnMPMota+EmBSo/+Azwp/Y5TZdShWqTNSh6Y5+wKpl68v72q5IrqYh8?=
 =?us-ascii?Q?B1jnbUISN2J20GGiemik4XqsNqSHmYML/ILHE/f/LQSBm6wQvPJSuYpr5K1b?=
 =?us-ascii?Q?OVXlTKE/Ei39TZNsogrgtdlTnPKplDhxLj4ImP5Zr2fe0n8xJFBBKyY3vWgn?=
 =?us-ascii?Q?q4Qd8YXAipANmRMUQszvX/rHzrCMkLGMUdREXV2LwsgpiyR94AxpcwObz4RF?=
 =?us-ascii?Q?dRf/9uQlsipGIV6KkouTy5trKW/hVopaJU9cw2XfIfwh192pbjbw5zhEZt1C?=
 =?us-ascii?Q?jmbuXtPWyn9u07Wz0Q8dRlLJ3gM+oSdlbkXGDfxIIjYv3sRCZq9ogUmQ+rGJ?=
 =?us-ascii?Q?mCcokqwi4uS1JnQGvADz0GktNyVDLCU9tcmu0YsBd/abzzbQvh1npzqUPHRD?=
 =?us-ascii?Q?gHNq9qw9Xxmf2HHyiPI0Gk8zWIErLnt8y0ylzXLs8LRYb3qSzv7reEfIeJ1Q?=
 =?us-ascii?Q?lXzyf46sGPMvzrLtuilAlOffx+wc35Lk47b+YHX0Pcyz+00tUTE0M6cWLBQa?=
 =?us-ascii?Q?vWOqLdoNxFklUu1o1WZofcKhW7/VYJqEoPzXZ8rMVTkwaRzCKOY/CvrYDbus?=
 =?us-ascii?Q?LxbAVpyzOoX9Uu8QYxA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:09:44.7601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0260371c-843b-49ad-3bd1-08de2c34aac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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

From: Jack Xiao <Jack.Xiao@amd.com>

Add initial cooperative dispatch MES support.
a. set shared cmd buffer for the group of cooperative dispatch mes.
b. automatically dispatch add_hw_queue/remove_hw_queue to master mes.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 +++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 66 +++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 941d6f805b028..d503127e45d5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -165,6 +165,12 @@ struct amdgpu_mes {
 	struct amdgpu_bo		*hung_queue_db_array_gpu_obj[AMDGPU_MAX_MES_PIPES];
 	uint64_t			hung_queue_db_array_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	void				*hung_queue_db_array_cpu_addr[AMDGPU_MAX_MES_PIPES];
+
+	/* cooperative dispatch */
+	bool                enable_coop_mode;
+	int                 master_xcc_ids[AMDGPU_MAX_MES_INST_PIPES];
+	struct amdgpu_bo    *shared_cmd_buf_obj[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
 };
 
 struct amdgpu_mes_gang {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 1ec3f876f7c53..b12a1256989b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -289,6 +289,11 @@ static int mes_v12_1_add_hw_queue(struct amdgpu_mes *mes,
 	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	uint32_t vm_cntx_cntl = hub->vm_cntx_cntl;
+	int xcc_id = input->xcc_id;
+	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
+
+	if (mes->enable_coop_mode)
+		xcc_id = mes->master_xcc_ids[inst];
 
 	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
 
@@ -334,7 +339,7 @@ static int mes_v12_1_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.gds_size = input->queue_size;
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
-			input->xcc_id, AMDGPU_MES_SCHED_PIPE,
+			xcc_id, AMDGPU_MES_SCHED_PIPE,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
@@ -343,6 +348,11 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
 				     struct mes_remove_queue_input *input)
 {
 	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
+	int xcc_id = input->xcc_id;
+	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
+
+	if (mes->enable_coop_mode)
+		xcc_id = mes->master_xcc_ids[inst];
 
 	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
 
@@ -354,7 +364,7 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
-			input->xcc_id, AMDGPU_MES_SCHED_PIPE,
+			xcc_id, AMDGPU_MES_SCHED_PIPE,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
@@ -601,6 +611,7 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 					  int pipe, int xcc_id)
 {
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
+	int master_xcc_id, inst = MES_PIPE_INST(xcc_id, pipe);
 
 	memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt));
 
@@ -609,6 +620,13 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 100;
 
+	if (mes->enable_coop_mode && pipe == AMDGPU_MES_SCHED_PIPE) {
+		master_xcc_id = mes->master_xcc_ids[inst];
+		mes_set_hw_res_1_pkt.mes_coop_mode = 1;
+		mes_set_hw_res_1_pkt.coop_sch_shared_mc_addr =
+			mes->shared_cmd_buf_gpu_addr[master_xcc_id];
+	}
+
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
 			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
@@ -665,7 +683,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 		mes->query_status_fence_gpu_addr[pipe];
 
 	for (i = 0; i < 5; i++) {
-		mes_set_hw_res_pkt.gc_base[i] = adev->reg_offset[GC_HWIP][0][i];
+		mes_set_hw_res_pkt.gc_base[i] =
+			adev->reg_offset[GC_HWIP][GET_INST(GC, xcc_id)][i];
 		mes_set_hw_res_pkt.mmhub_base[i] =
 				adev->reg_offset[MMHUB_HWIP][0][i];
 		mes_set_hw_res_pkt.osssys_base[i] =
@@ -1082,6 +1101,29 @@ static int mes_v12_1_allocate_eop_buf(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int mes_v12_1_allocate_shared_cmd_buf(struct amdgpu_device *adev,
+					     enum amdgpu_mes_pipe pipe,
+					     int xcc_id)
+{
+	int r, inst = MES_PIPE_INST(xcc_id, pipe);
+
+	if (pipe == AMDGPU_MES_KIQ_PIPE)
+		return 0;
+
+	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM,
+				    &adev->mes.shared_cmd_buf_obj[inst],
+				    &adev->mes.shared_cmd_buf_gpu_addr[inst],
+				    NULL);
+	if (r) {
+		dev_err(adev->dev,
+			"(%d) failed to create shared cmd buf bo\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
 static int mes_v12_1_mqd_init(struct amdgpu_ring *ring)
 {
 	struct v12_1_mes_mqd *mqd = ring->mqd_ptr;
@@ -1441,6 +1483,9 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r, xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
+	if (adev->enable_uni_mes && num_xcc > 1)
+		adev->mes.enable_coop_mode = true;
+
 	adev->mes.funcs = &mes_v12_1_funcs;
 	adev->mes.kiq_hw_init = &mes_v12_1_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
@@ -1470,6 +1515,13 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 				r = mes_v12_1_ring_init(adev, xcc_id, pipe);
 			if (r)
 				return r;
+
+			if (adev->mes.enable_coop_mode) {
+				r = mes_v12_1_allocate_shared_cmd_buf(adev,
+							      pipe, xcc_id);
+				if (r)
+					return r;
+			}
 		}
 	}
 
@@ -1484,6 +1536,10 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES * num_xcc; pipe++) {
 		inst = MES_PIPE_INST(xcc_id, pipe);
 
+		amdgpu_bo_free_kernel(&adev->mes.shared_cmd_buf_obj[inst],
+				      &adev->mes.shared_cmd_buf_gpu_addr[inst],
+				      NULL);
+
 		kfree(adev->mes.mqd_backup[inst]);
 
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[inst],
@@ -1733,6 +1789,10 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	int r, xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		/* for SPX mode, all master xcc ids are set to 0 */
+		if (adev->mes.enable_coop_mode)
+			adev->mes.master_xcc_ids[xcc_id] = 0;
+
 		r = mes_v12_1_xcc_hw_init(ip_block, xcc_id);
 		if (r)
 			return r;
-- 
2.51.1

