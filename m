Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F64C0015E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B378910E45A;
	Thu,  6 Jul 2023 12:36:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE44810E48E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hESZqcSYYt/LP9BtmceVYWmJsQrClz5Oa9fIUZ9actbAZP7zto4b/PitmfGqJR0miQ9gJojGZEzo905shLGn38InXG/dn14yigJmTxrHzXrgpAoHXoomtHbMk/ZLGUmiGUk81T0SZ2gedMcuVuFAte3Z7JOY9yT6NOsQrxMyyQG5fDDTMMfAqR7TGu4f+hMODFGfyQnKq6MOX9otmC2AWczIBOKG2mZGjpFx8AYm11OavocV3v2R68aAiLtvHyw5LPxMVDbDtKSJTYoUx675aBV0Es4LcgKdRLHW9mIE2i1i6Xqa/Ut4dP2TlI4btnPdWt7Y6E3HEM50yQZbNM+3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6faR/D6J8re5fkZDAc4VHCyW6HVNGFTd2z4/qwHuc4=;
 b=VCxPfr5fpi4GoyLQ+yTBZZq/VlxWwSaf2kJOSm7sl3bY6lb4ov0e3P1IGlBqz/iCKvcmGbcSrWuwoXU+EoCB8POcNF1db9ArWcdDkeMlQPfFw9xtg3Mz3vbR/w7WBhAQu89/YZclbF5ZRDHg0Fxukk2uqKgX1Xg89uonk/N4TLz8pJoXMH7P2wRp6bX3Seh8vNNiJvlGp6aY7RWKs8wc5IMuBllfWVDi0BqDsQ8EuByvzJ94ZOj7hVj4ozW+tHw6ZRxkK/ADTAEzyW8nKKW4n4NOMh33pPFbL3L5ohSCjuy1+SU7C55CGvyD1WhwhI3cDxuzO1WwqFhpbSHT10reBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6faR/D6J8re5fkZDAc4VHCyW6HVNGFTd2z4/qwHuc4=;
 b=foe2XaY4WX4ToYKqiBumdMXfj73iO7gJ89YmKAmg3NNyEntzwoKOn7+AnbRHu2GDuNu52/EJAmfSvIWgjYlnrJF9WkxBDhc5h5x+mumdfRVkDUlZhhkg84clE9HOUc1FS1cvzzdMPYYDnC8yo93EsRmt17o5p/s1Qum9TSRQKvA=
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:36:37 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::9d) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:36 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:34 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 06/10] drm/amdgpu: map usermode queue into MES
Date: Thu, 6 Jul 2023 14:35:58 +0200
Message-ID: <20230706123602.2331-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f395d0-ffab-4dac-9150-08db7e1da356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwvZe9bFLfBz2RXj3gFZ6xllY0t6upadXKCwGM72iw9waF5twtLDBdrT1cIo0OUkBjrmDYutcuFUTL2bV+JWnsN4dbDnaGKijXH2to+oI6u9dpM1OqsuPRVK1pw0DKiRvUqwfobso6pzzcJ4g0HiTaYp0lLf8dL8QYb6wk0AwqSmvI0jFfR04liknJDR5K/KRCCoL2WsEC3irueXS/ga4Tj+UG+khjlJnXursTiUPhkKC+rnA3qetUxXu0AFufrtpTi7zvCLHIn3xrP5Ly/yJCo1HrDtc3U+hL8pZevJHO9sG9CluereqhsviGGXb2nhgG07ZnXbKMed+LBebCn/fWwhLVjQz1wRrHX80SuOE9cUuZhBthkP8aHnBnRkORO1pYA5g2NctuiqmtBGXzSS4j92GdkMducyZUDcxCKgVXVVFhrISIyJC9M5FwFrYUutC5ivPAw3TLSDxyJT1nTIa79oBmGWZcVyPaTavkDXF+inrV1wOAijhF8DJwY0DIGFYgpN/j7JqAwNeTHr4f4PzWG/3zvErsi4CPc3otVdpdw7nnGKMjd09gHKumkif4om2qU4J9xqwC4JPFcEeUEwS0yeYgjBS4AL3Y1G+bYf1wYoMUN0P/upsnYBI93GG4l+IazQC1rVfSoSKSVWBPdFnwq7RNwyC/DsjnD23LIU8YrbDxCY7kH63XuDtNnYflW0AkV02mnC0THW3swEEGmCcduiafBLgQ7/OOg5qvAWevFGCEnBUkJB7lpZgpKm1q7ekk14Yyd6+UcJqMlkYIpvAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(54906003)(2616005)(36860700001)(426003)(40480700001)(86362001)(40460700003)(36756003)(83380400001)(356005)(2906002)(82310400005)(47076005)(16526019)(186003)(1076003)(26005)(336012)(44832011)(316002)(81166007)(5660300002)(41300700001)(70586007)(70206006)(4326008)(6916009)(8936002)(82740400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:36.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f395d0-ffab-4dac-9150-08db7e1da356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7d3b19e08bbb..b4a0f26a0e8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6491,6 +6491,65 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
+				  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_remove_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
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
@@ -6601,8 +6660,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -6613,6 +6682,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
 {
 	struct amdgpu_userq_obj *mqd = &queue->mqd;
 
+	gfx_v11_0_userq_unmap(uq_mgr, queue);
 	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
 	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
 }
-- 
2.40.1

