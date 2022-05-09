Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B188C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 19:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14BC10F84E;
	Mon,  9 May 2022 19:07:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D75FD10F84E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 19:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxUEchM8fwz1zGfK1wn6J36zLFM0PXB27NFdHBK+I0wNLk7RxbpXhobaPhNi7nLtN18VmQS7bxngUNEkDfmn7fXXht4ErqTICub7kKZwRgX1DzAjLkZM0IUejjF2C3GbHfW2RnJytpUB0bf6IT/qZPYCCS9OXixhuHtayrhRE4oTxPi757CrR04mx/SY4TgZBJEve3Z4fyUPbsUm42OPWcATfP8sSuZhuo+sZ5nBMmEVIiymvIm/V++NFpTBr6b6b0FgJ6tUTB/OQcRjKCK9X4hpcLaAZD4dEkKKe2xwJvaib6Ufxne88DhUZ2HMsEOT5M4qTzjjquxfGV7AgZPs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQp/fowwgStBHw0QpfhwIOt0w04DQCk0UPTn1Us223s=;
 b=dX2BkDQ16SBYNTbg5vSwArUAFyLpqD6fO8u2aAytPFeysAiBbdmCUM2jZSGWKkbJpIRn3lqDjCOibXfuLndHZEVwHHfRq/u/7AHJECfZq9v2p7Y20aeEJu6c6ELX0BW98lrhpHa017GjgTCa2srAL5KGlQVfhugqo4M7gcgCQPjtOejFKYtyY2c84xv6nY3xOG1GTDzgrL3lRC4m5kYisraOBoQ1qZ7T9xXwwYuCCLH8Dw4u/9BBxunXxK7pWgWqsoUgDQtM4TRjXl7sps3NNhrC14KX2bGofhL5nT5Fi8JWVKiNj7oFF55QYGysdtKzntRH6hkz7SSqMGYEOaQYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQp/fowwgStBHw0QpfhwIOt0w04DQCk0UPTn1Us223s=;
 b=MljlHY1DVEgle/q7xeoq2vWUZElC0MFjHPZaDbbOjeYwckI8ghlLXvXzY8yCXTW5zdCe+sa0ubwUCNBl7+YH9loLtfUSb25oRFeq/uisaODJTFLz3e1ZvbQrVqRsRH0n4zY5vMyZX8/rbFE6gO/aGBS5oBkgN4jspkrX7VWwW+Q=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 19:07:11 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::63) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 19:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 19:07:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 14:07:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx11: fix mes mqd settings and map_queue packet
Date: Mon, 9 May 2022 15:06:57 -0400
Message-ID: <20220509190657.478625-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46627e03-98b7-41a9-f96e-08da31ef1ed2
X-MS-TrafficTypeDiagnostic: DS0PR12MB6391:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB63914DA0DC4BE38144710589F7C69@DS0PR12MB6391.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2s/7IObl27D/l59u3pv0Xr+giz2QFrFVQFHZ3qX3bMtVATSH5lSD1VCEQSePYQyD9ExcMosE479GBQ9sOxIW0avHU8PYcT+xiLERNOXM0jKRvTDtWFK+E7DT4wK5i9NH3r3O1tUQfB+q5/8KUMeQNqmrNpiFEULqFckhSXBqraGT0vbrwtgwskOrj63Y2oRjm4zQX36oRcXfjF1Hd8TfqFHsUI3GgJ6M6tzedqsMS6VzDFabwItUaywwA9x9Yh3jkp2/1jUfXmYvwxsOLQ+tpoREn+PUC5S2GMCNaa8sZq3KDPGqFkzcIfwqkq5ntruYiBKkaL3Xej2Hqxw6DOovGQ2Ba/RKMwlqvwUV9dMc0XfSlldVvMDXrnXd+6NL+i6W9J64xnpQD0Dzl9GvopCtbjuvKqWCgM65Qc5Lbi96j8bkLTHuBO6/+aDRQ+kiKYzwVFUbaX5uY0JLkSEz8y7K1MvWYcbJKvcVKCcDzgR5KwxCm4KmTwEhApg1NgKCHS4o1wawMq3VVfP+TrPDg6+OVHyrRmpgjani6bA8tS3pf+DW8o4oq6J9o2jNlVFKNMVGigUf625Syrncbp7/DqwRQnj0k4n2JxfvDP4Kzc57lyCkWyPxOR/1C9W6Th9BYPckScUliw9ETp2yqwz2skoW4CF3EQxoMWkDmqJ3X/CJINW0qyWop72G3pNl0aT+DT94/+P3dIIXgRLTCdJzI4vE+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(186003)(82310400005)(16526019)(83380400001)(81166007)(26005)(8676002)(70206006)(70586007)(86362001)(356005)(47076005)(426003)(40460700003)(336012)(2906002)(6916009)(54906003)(5660300002)(2616005)(36756003)(508600001)(7696005)(316002)(1076003)(6666004)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 19:07:10.8559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46627e03-98b7-41a9-f96e-08da31ef1ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

a. use correct mes mqd settings
b. fix me field in map_queue packet

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7614f38ff381..8a1bec70c719 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -145,16 +145,19 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 {
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	uint64_t wptr_addr = ring->wptr_gpu_addr;
-	uint32_t eng_sel = 0;
+	uint32_t me = 0, eng_sel = 0;
 
 	switch (ring->funcs->type) {
 	case AMDGPU_RING_TYPE_COMPUTE:
+		me = 1;
 		eng_sel = 0;
 		break;
 	case AMDGPU_RING_TYPE_GFX:
+		me = 0;
 		eng_sel = 4;
 		break;
 	case AMDGPU_RING_TYPE_MES:
+		me = 2;
 		eng_sel = 5;
 		break;
 	default:
@@ -168,7 +171,7 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
 			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
 			  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
-			  PACKET3_MAP_QUEUES_ME((ring->me == 1 ? 0 : 1)) |
+			  PACKET3_MAP_QUEUES_ME((me)) |
 			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
 			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
 			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5d4d54cabf70..fcf51947bb18 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -29,7 +29,7 @@
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 #include "gc/gc_11_0_0_default.h"
-#include "v10_structs.h"
+#include "v11_structs.h"
 #include "mes_v11_api_def.h"
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
@@ -637,7 +637,7 @@ static int mes_v11_0_allocate_eop_buf(struct amdgpu_device *adev,
 
 static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 {
-	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
 
@@ -724,22 +724,22 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_vmid = 0;
 	/* activate the queue */
 	mqd->cp_hqd_active = 1;
-	mqd->cp_hqd_persistent_state = regCP_HQD_PERSISTENT_STATE_DEFAULT;
+
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE,
+			    PRELOAD_SIZE, 0x55);
+	mqd->cp_hqd_persistent_state = tmp;
+
 	mqd->cp_hqd_ib_control = regCP_HQD_IB_CONTROL_DEFAULT;
 	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
 	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
 
-	tmp = regCP_HQD_GFX_CONTROL_DEFAULT;
-	tmp = REG_SET_FIELD(tmp, CP_HQD_GFX_CONTROL, DB_UPDATED_MSG_EN, 1);
-	/* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
-	mqd->cp_hqd_suspend_cntl_stack_offset = tmp;
-
 	return 0;
 }
 
 static void mes_v11_0_queue_init_register(struct amdgpu_ring *ring)
 {
-	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t data = 0;
 
@@ -910,7 +910,7 @@ static int mes_v11_0_kiq_ring_init(struct amdgpu_device *adev)
 static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 				 enum admgpu_mes_pipe pipe)
 {
-	int r, mqd_size = sizeof(struct v10_compute_mqd);
+	int r, mqd_size = sizeof(struct v11_compute_mqd);
 	struct amdgpu_ring *ring;
 
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
-- 
2.35.1

