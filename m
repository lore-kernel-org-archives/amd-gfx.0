Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD99AC5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF7010F349;
	Fri, 21 Aug 2026 16:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZuVyuTg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE0010F342
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMm5On53RKU8R//BweMm1vCMuD0zOlErbbUq2JobFF91+YHpV+nE53eKbCzyp38WHAtjYZY9GL0/l8Et4qR/Zk1kCu+fTZfvx7oNB6cgme+kxiYx+pfANrKUXthSimPuhCwUUcHcHAoltHNADAUClKEBKqYM5ZKkSPb5LEyePljOnQHGMxkdk6wVlt6UM4ggxqsbvXBi/kw7dZOCT9/ClckF4LTn3Vvf2vLF6liZnYTfLhlKujSZr9iljleUX/TpASwIyr550SuhYgLEPAdHrLy7LLv9HZth4emxhztIieMCa2GCnYe9QIDpwLj6CTuG7H/XMzsQkQPgipFy9Sg6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w1MaCcVE2TFa5ECKqYhxTv9XIYs98hWECc+d2LW4tE=;
 b=MOkJ3nmK3Rq1yhTRLiFUjpxWVUdlG31aAKGchfW2Z51osFV+8CxM3spvp9GbQL54IB5SY8GtTvg59b/ZqpmH+0gt0TBqNzgqkXLftsceMcN12F7AtXynUw1f+0s2KhtLVTjUxauz/jXKv0ca1XfOTa2eQR3ooLEZ5hq5eyYPQf1jV7egRd+DZ7PdOdSV8O8UwQh3wMj1AWeI72yLsT6U1UESqx/5NVQJlKy65OQbQpw5Trp3eLxUfmv2CAMIjRYS5MOxqbO/yfQ4lzzPQVQj8RgDBISHv0RdvF2i5t13H9L2Z2ta3rrUrFsaShpVNgkODwpf7na5/Q0jNg50WLzw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w1MaCcVE2TFa5ECKqYhxTv9XIYs98hWECc+d2LW4tE=;
 b=hZuVyuTgz+Nj9VP2Z5T0PRf/++spSbtUuak6Wbo+vI+8hxnoiNlQrZTrETe3IshVTAI/jRijum5slC8w6qnVWx2Qzh7uAuTe+BemU9lMIwqkfUP+tlkGNAv10DDBzyP82FEfJRO9/SqJGU8d/QzXPjqzZC2I/gOcUhxJBFUOfKM=
Received: from SJ0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:33b::24)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:05:52 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::6e) by SJ0PR05CA0019.outlook.office365.com
 (2603:10b6:a03:33b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:05:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:05:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: fix master_xcc_ids[] indexing for non-zero
 xcc_id
Date: Fri, 21 Aug 2026 12:05:41 -0400
Message-ID: <20260821160541.752029-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160541.752029-1-alexander.deucher@amd.com>
References: <20260821160541.752029-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: acafc8f6-e4eb-4275-15e4-08deff9e12f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 5PHbAcNsUGxXBFr2KKQziH8zOp7/I2TpvxTb7mzmW+BNAvo3NU3FpmsAk+7nZVHMqpC2l8o7elFMZYAAw0X/SMI6sCa6FkmRjdlv+rIwP5Qnx8Hbrs3g31P2bZ6ZZa+VodXdmBo3gJgN49LiSe3/RRuMVzkRp0DAXOWlWXdwajyr489/zA3lTKHXrEfJCN7eHhiMSR9tBPRGPJAYXqr8iLTbHkbwheTOPws5jrVudu+iZ5iFg3arVH48K/8uVAHueC4BauFilzVgnAE9Y1X9zEz+4V7vfGbfg2kz06SqEYWlAjPzbRYCU2qdGIebPzXolfuk8bgC6TGHTe/B1Y+0JT9ePI4htQ5ZgHS7OYGOu2EqGDqDYodlliPj72JXtzMxKrCk/uckbAJ+JNWcWpd6GhF6QsRwQ/UkrTiTR/9IqFneVX4LI2wALOy2K6iOSCM1JV0NOLePKx0gQQDL7d053MTtFOqXJs7QQzECnh7D9yKrLyOefsL7iDUocv2lQfW0I57Wp2PcYlmtZ722znKRGQUy5z51plOHTx/euk8jQXZnq5LaGihDKw3dM4/v0+o8ExmawcoCGGKAguvWN7t0JfnLfofA88ufub6Yr9FMOOPMjU1TXpSkK0DU55bISbgBdniYPKDyNRTmbgJRIWKAorBKOwvRCo8NpnG7rBOaHX6WBfan0D/5CNRBO8TbewHqnkYD/SEP4qWWG3l5gy+SFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qeFP4gS4OuSYqD/qwAyBdJ8oEPnnrF7usbeMHbS9fENZ+WWdYJFuelqIrGLgbL8Zv3/sb1TXz/RRNL+gEcwq0U6PUfWp9U282po8Xr0jzq/XRf7oNb5o5L7PkP1l6SsuVibKhxF+zjK7S/8Mcoz/ULSUHLRFhDAQH+S6PtdJW44e2nzeJcv3ffFuvsVnbYNSNAq/ptEtm99e2YFiLSgU5te6zBlycy7J1bVq5RtQetXUduI1thhwFIuWunvP60PQ+i+gU3vnkpeK/fWNgc789Y5vKwy7Z48FoA4KT+aIvliZCK1iP5EBrrihrj/BzHEzp2Ce0pext3102gBwciwkPBcfh16Mqc9OMrVp66I7mdJR7mr48tdik8N3rQ2kgW3ZR+PxPCSoqgTS2qDTNuv1aZ4Ufm1gKcyTOME7eWBTmr1zQbI4BeB0it5nQ/qqRhjg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:05:51.9995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acafc8f6-e4eb-4275-15e4-08deff9e12f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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

From: Alex Sierra <alex.sierra@amd.com>

add_hw_queue, remove_hw_queue, set_hw_resources_1 and inv_tlbs_pasid
read master_xcc_ids[MES_PIPE_INST(xcc_id, SCHED)]. That only worked
for xcc_id == 0; with a non-zero target (e.g. partition-1 master in
DPX) it read an uninitialised slot. Index by xcc_id consistently, and
fix the related shared_cmd_buf_gpu_addr[] index in
set_hw_resources_1() to use MES_PIPE_INST(master_xcc_id, pipe).
All indexing stays in logical XCC space, so this remains correct with
harvested XCCs; the existing ip_map / GET_INST() translation handles
the logical-to-physical conversion at the HW register boundary.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index f1098118d5c05..4df3f0204dbbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -291,10 +291,9 @@ static int mes_v12_1_add_hw_queue(struct amdgpu_mes *mes,
 {
 	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
 	int xcc_id = input->xcc_id;
-	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
 
 	if (mes->enable_coop_mode)
-		xcc_id = mes->master_xcc_ids[inst];
+		xcc_id = mes->master_xcc_ids[xcc_id];
 
 	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
 
@@ -352,10 +351,9 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
 {
 	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
 	int xcc_id = input->xcc_id;
-	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
 
 	if (mes->enable_coop_mode)
-		xcc_id = mes->master_xcc_ids[inst];
+		xcc_id = mes->master_xcc_ids[xcc_id];
 
 	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
 
@@ -663,7 +661,7 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 					  int pipe, int xcc_id)
 {
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
-	int master_xcc_id, inst = MES_PIPE_INST(xcc_id, pipe);
+	int master_xcc_id;
 
 	memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt));
 
@@ -673,14 +671,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 100;
 
 	/* From version 0x74 above, pipe1 support use shared command buffer
-	   to distribute some tasks on individual XCCs*/
+ 	   to distribute some tasks on individual XCCs*/
 	if (mes->enable_coop_mode &&
 	    ((pipe == AMDGPU_MES_SCHED_PIPE) ||
 	    ((mes->kiq_version & AMDGPU_MES_VERSION_MASK) >= 0x74))) {
-		master_xcc_id = mes->master_xcc_ids[inst];
+		master_xcc_id = mes->master_xcc_ids[xcc_id];
 		mes_set_hw_res_1_pkt.mes_coop_mode = 1;
 		mes_set_hw_res_1_pkt.coop_sch_shared_mc_addr =
-			mes->shared_cmd_buf_gpu_addr[master_xcc_id + pipe];
+			mes->shared_cmd_buf_gpu_addr[MES_PIPE_INST(master_xcc_id, pipe)];
 	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
@@ -945,11 +943,11 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
 {
 	union MESAPI__INV_TLBS mes_inv_tlbs;
 	int xcc_id = input->xcc_id;
-	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
 	int ret;
 
+	/* See mes_v12_1_add_hw_queue() for the indexing rationale. */
 	if (mes->enable_coop_mode)
-		xcc_id = mes->master_xcc_ids[inst];
+		xcc_id = mes->master_xcc_ids[xcc_id];
 
 	memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
 
-- 
2.55.0

