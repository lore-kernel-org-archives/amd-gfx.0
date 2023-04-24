Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F88C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9221610E59D;
	Mon, 24 Apr 2023 17:39:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC97610E57D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3/WkJ119Qg7GQrBHkwg0W1FJHhIp49F2imLj8bPZ6uKJBF6Qir998Aj6eqAac8RS/OaN/5Ca8892qOwBTs2ya3xG8kyFA5P792pmwG/B/CIVcHntwNgEuxHve/7GEoPyX5kj4nvxOuIwtmzdUZ8p52urdnGjxxL5kFWU/XemrsmPnRa+edbAibHU5PM8NiUsmEnNUn6zzXkCkUozU9TY+dL9WMrW37YS4YITfZjJuTKLEVGk6F6E+yidvgQz6AW217SgQrxzFocVQVgN1fivkE9VtrTQ4t8YAVhZD/dz7sIpd1XdrygXzvaSBwwTzOOGb10s8URz3ZyONc5Z5tuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIscbtV3Whfe3Pz+bgc0Mcg0Zn9UL76CUtc4Z3ap7M4=;
 b=NKmY+X2oyw+0+61jcXzmFHG7ZrIM/o8LmLqq8iSDqXVp8Kc01O+2eGz8mr54sMe5XPwbON64QY4Pc0SuZzRpU2uHGXXW/Vi38Vi1jmXtskD1DZ0HnTL7fx7wxjPCdO5J/uxQs7BBXe+LXoJIq4cjDCh0K1rKujADRFL+7ruXs7Rj5s7Rg0IhvZ6bee48gjKCxijqE9LahIhEujE60xW7JSBkMAbQnUOnAcaZZY5gRQPBewP9c8RVgVhqBFdzXbeYJ6STOrxE5vObEksqMYBcGo0b41L+Wu+16pR4FCiCE8qTlbkVpbwhxjeELQCk2ya3aIb7QL5e/jnUzw3ElPlZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIscbtV3Whfe3Pz+bgc0Mcg0Zn9UL76CUtc4Z3ap7M4=;
 b=fmmDmLV6FiEEQ31jlOoScXw2dJ5ERuBOIz2SKM78NnOS7QxSzWObDfjrezG23ssvmCGiKgrdHdFdRR++QRqXbgkR5n87po1GgKzW3I45OsCgYKU6EWr5EmLYA1GXAIjiC5kJtespmvsPrDRansEADjMow/ZQnxj9Pp6a7sv3JV8=
Received: from MW4PR02CA0028.namprd02.prod.outlook.com (2603:10b6:303:16d::7)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:17 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::c1) by MW4PR02CA0028.outlook.office365.com
 (2603:10b6:303:16d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:16 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:14 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 07/10] drm/amdgpu: map usermode queue into MES
Date: Mon, 24 Apr 2023 19:38:32 +0200
Message-ID: <20230424173836.1441-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e491afd-f2e5-4eda-eb64-08db44ead3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlcJgzpKwU875T3FW/CMXw+OYGTmkqle0tAJEE4jniBjTRE2Vvd1uXFWMWoV7jdNc0G8pWxEVnvQnZWwGIWmBaNoIzlc75571NX1+qsZ/Cu2uu7Oo+VBM21cNTK3hVDAcJD5Vy/KKMECYenSSWrwP80wrcIhuX3Z7ulCesVmc4WVCiWXk9MzZ899McQJZQX/qVuZeknh6HMzwpK0OHggOb+CN4ytogHtas1rRh6Q9EYD8y1ACCINDEj9haDBTccw7UJ0rrL3xYIXFzSjjaiZ3bJqjjrvAje4lHVN30oLs2sNRjjeBawHt7oMGzaBmBwQkMFXkct1nkDzg8b6stJe3tPtRmxFekJ60ZMVcVLqHqhcCGwB/q4/BGT4UOWS40J0/MzI7QVkPyGx+s+NP6sFOPPdWZzSJ1NP0VW3AuuySJQpMrHpNhaFQamyc7Lrud1bjfCWfAdqQXJhxk20uDnXxyJuLCuPxrlWBAAM05CUlqDej6AwikY7WDcbOsCV2YlcGRe7x+oAc9LtYd9H377l5BXsF51vEFqKzITopIOyqnnVAF4Q4f6m1gYJOd/YuEd/5q6LR4eKZ7++Jrik8tOGWFshtgxu7/mXBbFrEHDGlgsYDsioJdi6hAt4anr/PLreI/AeQms2Q0fkwtHhs43YguW4dfZsvHeqWB5mifj0LSaTRyTiS7a079MvJNI00EPMSKJUvMvwl2V6zK3zIDyY61uGR0pkFfLU8jDMS6bmAYw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(54906003)(40460700003)(478600001)(82740400003)(316002)(4326008)(6916009)(40480700001)(70206006)(70586007)(356005)(41300700001)(44832011)(81166007)(2906002)(8936002)(8676002)(5660300002)(2616005)(426003)(336012)(1076003)(26005)(86362001)(186003)(16526019)(6666004)(83380400001)(47076005)(7696005)(82310400005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:16.8109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e491afd-f2e5-4eda-eb64-08db44ead3cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 86de35292f69..7a45d68091ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -31,6 +31,7 @@
 #include "amdgpu_smu.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_mes.h"
 #include "imu_v11_0.h"
 #include "soc21.h"
 #include "nvd.h"
@@ -6411,6 +6412,64 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
+			     struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
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
+	queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
+	queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
+	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+	queue_input.process_id = queue->vm->pasid;
+	queue_input.queue_type = queue->queue_type;
+	queue_input.mqd_addr = queue->mqd.gpu_addr;
+	queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
+	queue_input.queue_size = queue->userq_prop.queue_size >> 2;
+	queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
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
+	DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
+	return 0;
+}
+
+static void gfx_v11_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
+				struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_remove_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+	queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
+	queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
+}
+
 static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 					struct amdgpu_usermode_queue *queue)
 {
@@ -6507,6 +6566,13 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
 
 	gfx_v11_userq_set_ctx_space(uq_mgr, queue);
 	amdgpu_bo_unreserve(mqd->obj);
+
+	/* Map the queue in HW using MES ring */
+	r = gfx_v11_userq_map(uq_mgr, queue);
+	if (r) {
+		DRM_ERROR("Failed to map userqueue (%d)\n", r);
+		goto free_ctx;
+	}
 	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
 	return 0;
 
@@ -6523,6 +6589,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
 {
 	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
 
+	gfx_v11_userq_unmap(uq_mgr, queue);
 	gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
 	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
 }
-- 
2.40.0

