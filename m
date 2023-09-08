Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781A8EE801A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FAC10E910;
	Fri,  8 Sep 2023 16:06:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F0010E90F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZrQdT0sXC13siLmo40bHGGmiyBEugGTmPxtYh8bpO7f3IPkRFmcvuJdrBUzH52oeDDNgfenvRP++tPIubReUNIaW4XfzgJ695mLo5mq1QvTkI5wCAEKZ4Gd0OhJzQqsW88xdYJY4ut+cQv4viTshFUXg2P9o5P5fMa4Uebmr0eeN19NtZW2+JQwM1oAfmSABY/EhCXVtrJb7E7QKCCPaJ0o8rr+3EqrLh9oAtzg0dTYR7+85nq3n5f+BgePBOr5k9Ik+nHLthDyDNCLaceBe0D7cO/JP7wTPnoWCpugpPrsTLqPY1mfRsu1kg8KwRx6BqJVzJ+z6h3zXvdF01516A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPRE0rNA3QYBg8Dj+QbM20OxAlyRq5/WqHwrvI6d8vA=;
 b=XAu3dolZQ6uPJJFpLcoA2/dzYL8L06IoXwpNjJcSZQIBkGG7vlNQu3hD4MkWDfUCKpHxHFSpo9E4soIDWJHMCCVYSLi6SKyEmjCT70XGAMGo0N7KMgHD+QF5kM+rR8NMwQMXilK5GbQ+5i5WWXhrx3S2nAMkdLydw6mcAsj4UcTqFx+E2+/ooxggFvVD73W5c0GcbY4ogF2jCO7iEnOoUkxZ1pWFxqDcs16Fc3nL/vkoQDxRAOy42bc74qAkKQm6n/lhVZLyJQVCAB6yqIOhy5OJtSMKwNkxg5z0kQha8Yp5eg53vGMv5j3LEIvHqbIIeZnuO7OuSqd1UeNutcLBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPRE0rNA3QYBg8Dj+QbM20OxAlyRq5/WqHwrvI6d8vA=;
 b=r9oSDR+yVIiRAMT3tK5ytETNY+9s3vngUNJwUv8kREwl7bYR1mM0IOtsLgE5vvh06AbRk4abSDgFA58zrKe3utlXWKY+fzWjeVgu0aX8wZNtawbwlT9mpf9i3dYfj404B4I9gOGdDM4Dvo1GKmTX1KJ2Qvn54wN19RxvZGxggyA=
Received: from CH0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:610:e7::18)
 by BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 8 Sep
 2023 16:06:16 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::1d) by CH0PR03CA0223.outlook.office365.com
 (2603:10b6:610:e7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 16:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:06:15 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:06:13 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 6/9] drm/amdgpu: map usermode queue into MES
Date: Fri, 8 Sep 2023 18:04:43 +0200
Message-ID: <20230908160446.2188-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230908160446.2188-1-shashank.sharma@amd.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BL0PR12MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: 845dcbaa-6c54-41fe-8e96-08dbb08587ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGFmcKopOHOANJOqbyVkyo4QslArgaFcBMHpu2D9Kb9n/DbeaARg2lrbwx8svrAMzPFqaFu7D5DGXUHnSUu+5K7Jhj7toGmSR9jTRFHF1rcvVAY3f0iFhrS0ZjsOy0V7FAAzvvtF6keoYWmu+X5Z1RVhk/yOO71jPf8L6S7+taLx89/Rgz6aJ2NfEWmTohcWD/uKBFHWJsdhEZ69FCLYuXKDlwRh2tnq+Ks6tt/t1FanveOSptjp3/BqbT0o2y0TK/LWHt8yd5W3NBXbYnN56dXLpzM9na8T1zcNpNdg/DME3nfzXOq2pfYQzP4UzKF8mziZ4GRFat+/y3txj9y/HC8f3p5NL+vIZBlR3CkG8avMhrIawtVlnGj+yhdXLpjmQ/S8xtEY8k3lPXNix6Nhs0baJ9UW5n6X/o9EELbmDYW59jCL4QU+Pl3dGa0pUfCzIpP5x+d/kiG/qv2anEcMVdUSVhECYjgIqpPVsBpWY+ZY8GyHcI2sJZum35fY/8nhZpTzIEhiFJOdky5k65j5XFyhkUv4VmUh27tjTBgNuZ4JJUbhW//MU1Ay2PzBcBIOqRtBv7EiLr88ylVx/BLbD/+3Y51VPT91L1GwIse9YG+Z3NQ8X0/6Y1o2qRizpsBTJpLUYKQbCj3p+SO4QEiqoBU3D0UzDi8K6uQ9cwfU5HU78Et4ISz4G3PtcB8b9gR49XnPvy8YoLwuKcfEfeppsfR2aZ2jGPTWLIJKpTc+2uud6COjfgW9ldzu1H/ZFkb6te5q+QCtjmC1mFsQ52jf8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(47076005)(5660300002)(44832011)(478600001)(36860700001)(8936002)(8676002)(4326008)(356005)(54906003)(41300700001)(70206006)(70586007)(82740400003)(81166007)(6916009)(316002)(6666004)(7696005)(2906002)(426003)(336012)(40460700003)(2616005)(86362001)(36756003)(40480700001)(83380400001)(1076003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:06:15.5647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845dcbaa-6c54-41fe-8e96-08dbb08587ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
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

V3: Integration with doorbell manager
V4: Rebase
V5: Use gfx_v11_0 for function names (Alex)
V6: Removed queue->proc/gang/fw_ctx_address variables and doing the
    address calculations locally to keep the queue structure GEN
    independent (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8ffb5dee72a9..e266674e0d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6427,6 +6427,67 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
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
+static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
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
+	queue_input.process_quantum = 100000; /* 10ms */
+	queue_input.gang_quantum = 10000; /* 1ms */
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
 static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 					      struct amdgpu_usermode_queue *queue)
 {
@@ -6540,8 +6601,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Map userqueue into FW using MES */
+	r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
+	if (r) {
+		DRM_ERROR("Failed to init MQD\n");
+		goto free_ctx;
+	}
+
 	return 0;
 
+free_ctx:
+	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
+
 free_mqd:
 	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
 	return r;
@@ -6552,6 +6623,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
 {
 	struct amdgpu_userq_obj *mqd = &queue->mqd;
 
+	gfx_v11_0_userq_unmap(uq_mgr, queue);
 	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
 	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
 }
-- 
2.42.0

