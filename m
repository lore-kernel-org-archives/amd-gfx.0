Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7DDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jun 2022 11:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE6610EFF6;
	Fri, 24 Jun 2022 11:57:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E550610EFF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jun 2022 11:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNkqw2PLj9AKBUPjZrvVSowyKbMdzU8ElUJpNhd7cT4P4rZ7JWE4U1mrRZ0aKDuXaI7VwXRdw/xOHUIyZkn3Sqgj02fIPqbtEQpREnYTVaP6IPAOpMGsiXZewBWlIqSHmrIxiKWzEDdGgOhYTKyXgTSGCUIl8Dr7QpoGYYAmJsSI+zWzZHgknie0bY18l+9ZKF66L/PC2i8B2UHAjJ6yvBHvaMji3hWf33AoTPnEFr9cYVYsxYbWogkMVwObjvDbchzqrlOMhD/auh85yGrjwkE3q5anvNXX4rXvEjZErhhHMS4WWBNGaDKiGJ0+8LgdflAUeOgRiYYbG0cVDqYsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg/okHZ50KMDH7frrWmgNUsUgqKXC4+D6dyxTuFOUVk=;
 b=TzUvItZMLqP/SgDcYKCWlDONOkm9aKFKGiDSY2q64bsOcAI5+tqIFnSzyz53nK9TdIqztnKEM/i02euH3fpfOyQyvvtpCPjh2mgcPEjp51uZbD/ItdY4LIIN+1K4KgyK7kw88MQFuMXwCVur9eZVs9KqD7DJHjk7uRc7MC8+miLOZWeW7aaWgB1KwWRBenidhiHPdzxuObxWMQ7Vddl9rf3reaQL58VRDJFHS/hm9UJOMKxlf8US91UA1l+IhEXbRU7+kpm45dAaXEXdeTZM86pxwgS5D8VYwjLLsZ+AxLG5aAHzSwFkOnAJhpfLfHxB5e5BsprLjlxCAyhmik0kKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg/okHZ50KMDH7frrWmgNUsUgqKXC4+D6dyxTuFOUVk=;
 b=t+EDDq+BJAzyUgo7eh8HdBD/IjkhXbg4wZBInqvhwztX0i/HcxrQqKnxHpIHHeeHkb6BR1XxPRNN1IYgwO8PTTtN7eobEDB/14MB95vlYfzTpiMEsimQwL2aVDcp31RjeWW/6M4b/REpu+yTsYCwsg8Wy6PoritRGfW4r/IflDs=
Received: from DM6PR02CA0166.namprd02.prod.outlook.com (2603:10b6:5:332::33)
 by MW2PR12MB4683.namprd12.prod.outlook.com (2603:10b6:302:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Fri, 24 Jun
 2022 11:57:31 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::8b) by DM6PR02CA0166.outlook.office365.com
 (2603:10b6:5:332::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Fri, 24 Jun 2022 11:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 11:57:30 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 24 Jun
 2022 06:57:28 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Graham.Sider@amd.com>
Subject: [PATCH] drm/amdgpu: add mc wptr addr support for mes
Date: Fri, 24 Jun 2022 19:57:12 +0800
Message-ID: <20220624115712.2757646-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efc972e9-60f2-4dac-cf1b-08da55d8b794
X-MS-TrafficTypeDiagnostic: MW2PR12MB4683:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Fb8RxbSjxcUKMsPYauHJvUNyK2z1q2Ec0RfXqNOtJ00XxDLw89vudXi0OvEbO5Uv1xMA3tlVTidpKVf4qL6yJNjjUxGrGpYrUEXbcHf8BvNdey9hsuEfNJgsffNge6zvpLfWu7OqMyKH/+nhTlVkmgifp2XMsonfnXhdiqx60r2fu8MwTyBw/Jd6PuNa3Bodujc4HfNM8Zqc/c7tUgkkzfMNhxGyDxu8Gyt6QhDb60oxm/EIZi8ayASs3Im8jcqbq9chVvMGr/eOjF2AvVm0hBgJ7CicZuFxouN6nJX/Xf+lp48KF+ZXmaTEsWvvHK36DLn8TezbjnFqaYobwRODpw1g5I+fYA/OcO8M/IySbRRx7eEIHs1Fnpyc5hIvXIY+UCe+qAx28oSKcLuoVQ7Bjjh6sYyeV41GNZ5cF8nIkkD0SFODRI0RKibXEZ90GTSPkX5BC5COI3ceEdymfqP/ikOwu7F5UatObQhG6kmMia4LIMsCf4DrziJT3LHmqtaY6z//IjATerIvuIhZycLVes9M2BFYfXeF4eCaL0z2cmv53jkPhJ6UYo9DZxl7sCPOakfMOpX86OnnA4gtlcbi27ysav5QCBzAxJVfNpDPqTwW91c5kS2iDQzKRXjBuX0RNDsnIM7Z0z1MVnaVXt99PLQUVWttmUcILKfTvwl5k7OxycDMCNZpHUnE904yq1mPL9AeXmftumDCl2fmarBVOyVRBEsI3jqWi9z6VXZBRqaBImkNvdSsCpdYO7TQ9maqD9hMbCqGlPgsMYm/rm47X8kEVKqhNNGa6gShZ39VBkQ4O+BGlHt+0YOAhTA8Xh2IbN4ezWYnsJGoYhIcg/mI9OLw/q6qKQLgGokEmnbmBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(40470700004)(70206006)(356005)(478600001)(8936002)(86362001)(5660300002)(36860700001)(110136005)(83380400001)(40460700003)(8676002)(82740400003)(40480700001)(81166007)(426003)(70586007)(4326008)(6636002)(6666004)(1076003)(316002)(2906002)(41300700001)(82310400005)(186003)(47076005)(16526019)(7696005)(2616005)(26005)(36756003)(336012)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 11:57:30.6532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc972e9-60f2-4dac-cf1b-08da55d8b794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4683
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES requires mc wptr address for usermode queues.
Export bo gart address for mc wptr address.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                |  8 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +++---
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 521e35d93d67..0c9cb493a85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -675,6 +675,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	queue_input.doorbell_offset = qprops->doorbell_off;
 	queue_input.mqd_addr = queue->mqd_gpu_addr;
 	queue_input.wptr_addr = qprops->wptr_gpu_addr;
+	queue_input.wptr_mc_addr = qprops->wptr_mc_addr;
 	queue_input.queue_type = qprops->queue_type;
 	queue_input.paging = qprops->paging;
 	queue_input.is_kfd_process = 0;
@@ -802,6 +803,8 @@ amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
 	props->hqd_base_gpu_addr = ring->gpu_addr;
 	props->rptr_gpu_addr = ring->rptr_gpu_addr;
 	props->wptr_gpu_addr = ring->wptr_gpu_addr;
+	props->wptr_mc_addr =
+		ring->mes_ctx->meta_data_mc_addr + ring->wptr_offs;
 	props->queue_size = ring->ring_size;
 	props->eop_gpu_addr = ring->eop_gpu_addr;
 	props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
@@ -962,7 +965,8 @@ int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 	r = amdgpu_bo_create_kernel(adev,
 			    sizeof(struct amdgpu_mes_ctx_meta_data),
 			    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-			    &ctx_data->meta_data_obj, NULL,
+			    &ctx_data->meta_data_obj,
+			    &ctx_data->meta_data_mc_addr,
 			    &ctx_data->meta_data_ptr);
 	if (!ctx_data->meta_data_obj)
 		return -ENOMEM;
@@ -976,7 +980,9 @@ int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data)
 {
 	if (ctx_data->meta_data_obj)
-		amdgpu_bo_free_kernel(&ctx_data->meta_data_obj, NULL, NULL);
+		amdgpu_bo_free_kernel(&ctx_data->meta_data_obj,
+				      &ctx_data->meta_data_mc_addr,
+				      &ctx_data->meta_data_ptr);
 }
 
 int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5fdc4fbde3bc..3334316c2995 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -175,6 +175,7 @@ struct amdgpu_mes_queue_properties {
 	uint64_t                hqd_base_gpu_addr;
 	uint64_t                rptr_gpu_addr;
 	uint64_t                wptr_gpu_addr;
+	uint64_t                wptr_mc_addr;
 	uint32_t                queue_size;
 	uint64_t                eop_gpu_addr;
 	uint32_t                hqd_pipe_priority;
@@ -207,6 +208,7 @@ struct mes_add_queue_input {
 	uint32_t	doorbell_offset;
 	uint64_t	mqd_addr;
 	uint64_t	wptr_addr;
+	uint64_t	wptr_mc_addr;
 	uint32_t	queue_type;
 	uint32_t	paging;
 	uint32_t        gws_base;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
index c000f656aae5..912a5be2ece6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
@@ -107,6 +107,7 @@ struct amdgpu_mes_ctx_meta_data {
 struct amdgpu_mes_ctx_data {
 	struct amdgpu_bo	*meta_data_obj;
 	uint64_t                meta_data_gpu_addr;
+	uint64_t                meta_data_mc_addr;
 	struct amdgpu_bo_va	*meta_data_va;
 	void                    *meta_data_ptr;
 	uint32_t                gang_ids[AMDGPU_HW_IP_DMA+1];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 7dfc6ea21397..89b99dc827a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -156,7 +156,13 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 		input->gang_global_priority_level;
 	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
-	mes_add_queue_pkt.wptr_addr = input->wptr_addr;
+
+	if (((adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK) >>
+			AMDGPU_MES_API_VERSION_SHIFT) >= 2)
+		mes_add_queue_pkt.wptr_addr = input->wptr_mc_addr;
+	else
+		mes_add_queue_pkt.wptr_addr = input->wptr_addr;
+
 	mes_add_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.paging = input->paging;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 74a1f8a6f53f..21e451acfa59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -197,12 +197,12 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.mqd_addr = q->gart_mqd_addr;
+	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
 
 	if (q->wptr_bo) {
 		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
-		queue_input.wptr_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
-	} else
-		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
+		queue_input.wptr_mc_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
+	}
 
 	queue_input.is_kfd_process = 1;
 
-- 
2.35.1

