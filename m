Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413C1C636D7
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460EA10EB80;
	Wed, 15 Feb 2023 18:44:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F412B10EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Tm2h7CzuKHE2412iSQARo8DVRcttp5x9j22kTUey4/BW0p2Cy1BYyITN8+OAUt2G25mOImgoNsQLm09Xh/sCebp2eSxgrFbjUcAXZb1v+4Eey5oc9VZVzB/GntVJa1+gkMxjEpeAVNvRYgyph6vzcCcmVq1LmmpCoSKOIDnD7qylLFDL6gmisDvYhDMuJrOuhByXc4If93WAy85LQp0DqWDrwYIwTXtQ1t0TdvZ8nZ53ke4dWybBW0bc4qt7mX9MLkcjfV14qn7rPZ9l8CcmGarxce6RuAB18EJu/XeqxvSJWmZtuhN3BjM27tPywGGPw1j7GLiW0OZMjheL8efQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzwEeGGKyRIQuI+2l4S4oTEmyXX3nx6yVnxv1F00w5Y=;
 b=DOlpy+ed33bdiCDex2jhlhmSMrOWoI8Y5VObq2NE7UzlgFPIn0Q33sxmgM1Csn8WRX9JgAw/7N5f0DxGWZp+Q027oF7NGGUwPTMyeOZxfrT7M3WoRljE927dJm83IwFysQioFRPeBzKIyqZYjRhR2WZciGivPvUNaL6k7MIV/WTYYGDtYDPRuJ/dq4rrqOeuYFR8a4vpDOsOvV3biqFuFkRkqUDwhmU2SRfzXYFijzcpQEb5T+tKh/7EV/GVq9V1FHbryexWf/+nRKduykNBacVSvhGZBSc6Mb6eZs8ym8OZWR7NO27sFLt7klUrsoLmavRQOpYmBAuEdNNFJ+4Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzwEeGGKyRIQuI+2l4S4oTEmyXX3nx6yVnxv1F00w5Y=;
 b=2/U8Q5BB9m+z7ARjnxSZgJrj4b/ihLOsqMU9z4kVwALlHz6gR1u65wtt6jQY2Fewt1lU8ub3Vf7PlbluPm3TNI37mxjx14hVdmxObdaDxfcxDPjJO4P2eKJ6fqErrvkGXdNw1v1PvZO9JsfSXZY1gTubCBCTq8vq1Q4T2NBF8ps=
Received: from DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25) by
 BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 18:44:38 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::e9) by DS7P222CA0022.outlook.office365.com
 (2603:10b6:8:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.27 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:36 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/9] drm/amdgpu: add new parameters in v11_struct
Date: Wed, 15 Feb 2023 19:43:54 +0100
Message-ID: <20230215184356.2205-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|BL1PR12MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b777806-0b8c-41e5-5ed5-08db0f84b13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSlB4NPT4EMFlJrPDavVrLJyonjQCfBe/ZmB+QLjySugNIkEG1OA3ET2UAoE0YvSafuxwpeN8w4kPyhFbAqnFAI/da1zcFv1qQ6Eun20xEf2oOkYReeltZwS2z/ozaqixl2ZLP0J7wfdU5REX2Dot2Nu7VvLKqGiYNtpm07ZSZxqu4AT2AcJySMd5lgVJsJYNFF3KuQS7nH8Yatc3/EQ7KbAeViULcK53QlW6hAqk/ToWoNGjuGV1UvBYRTXyi3PJJVPH/KN0STi5xY3S1ytbsMkf4ren0WyiZGCUqCJvZEKYH0etPUhBGCwRk/y8uvoahDZjjz99oVQmOCz4rrjU8yLTVz//FsAPpw0MVuLfZ08XpEL9l0LpoDEptOomKEUnPRiVqP84GCnmcD6RUpZZeHIw5HM490fTHFaJQhBlnOQgfgOl3iuuVeh9MllKxerfLqmdISq/R/H1N6h1IJpRsh6DiHHHOI1qCUy2OcISKhm9CItcC3BlEv5WE0I9qu0xrwn/wd8/hlnAee6gSSQjyIXzHrOvUnOUE42MAUYHqL8+eyWN6ftjlyQA2AQbuhbRN30GHGaBOL+aZWIvT5WSVVINP5eL+qDtfxrLBX3sYGI38+p5DSqRCt4U1TEHPSQlX61ojqAa3s75+Kqp3yYWJMU92cWkaa9cV3jlBunEJVkBafeocQb4tbtFh1nZ6lpZ0kSqwt36jeFb/t8hBnr8fd3NpTlmRMvzLsmh+bxQHY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(40480700001)(83380400001)(36860700001)(47076005)(426003)(86362001)(356005)(82740400003)(82310400005)(81166007)(7696005)(478600001)(6666004)(16526019)(26005)(336012)(2616005)(36756003)(1076003)(186003)(40460700003)(41300700001)(6916009)(8676002)(70586007)(2906002)(70206006)(4326008)(5660300002)(8936002)(44832011)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:38.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b777806-0b8c-41e5-5ed5-08db0f84b13c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian
 Koenig <christian.koenig@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arvind Yadav <arvind.yadav@amd.com>

This patch:
- adds some new parameters defined for the gfx usermode queues
  use cases in the v11_mqd_struct.
- sets those parametes with the respective allocated gpu context
  space addresses.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 21 ++++++++++++++++++-
 drivers/gpu/drm/amd/include/v11_structs.h     | 16 +++++++-------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
index 52de96727f98..39e90ea32fcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_userqueue.h"
+#include "v11_structs.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -68,6 +69,22 @@ static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_mgr *uq_m
                           &ctx->cpu_ptr);
 }
 
+static void
+amdgpu_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+                           struct amdgpu_usermode_queue *queue)
+{
+    struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+
+    mqd->shadow_base_lo = queue->shadow_ctx_gpu_addr & 0xfffffffc;
+    mqd->shadow_base_hi = upper_32_bits(queue->shadow_ctx_gpu_addr);
+
+    mqd->gds_bkup_base_lo = queue->gds_ctx_gpu_addr & 0xfffffffc;
+    mqd->gds_bkup_base_hi = upper_32_bits(queue->gds_ctx_gpu_addr);
+
+    mqd->fw_work_area_base_lo = queue->fw_ctx_gpu_addr & 0xfffffffc;
+    mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
+}
+
 static int
 amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -104,12 +121,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
     queue->userq_prop.use_doorbell = true;
     queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
     r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
-    amdgpu_bo_unreserve(mqd->obj);
     if (r) {
+        amdgpu_bo_unreserve(mqd->obj);
         DRM_ERROR("Failed to init MQD for queue\n");
         goto free_ctx;
     }
 
+    amdgpu_userq_set_ctx_space(uq_mgr, queue);
+    amdgpu_bo_unreserve(mqd->obj);
     DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
     return 0;
 
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index b8ff7456ae0b..f8008270f813 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -25,14 +25,14 @@
 #define V11_STRUCTS_H_
 
 struct v11_gfx_mqd {
-	uint32_t reserved_0; // offset: 0  (0x0)
-	uint32_t reserved_1; // offset: 1  (0x1)
-	uint32_t reserved_2; // offset: 2  (0x2)
-	uint32_t reserved_3; // offset: 3  (0x3)
-	uint32_t reserved_4; // offset: 4  (0x4)
-	uint32_t reserved_5; // offset: 5  (0x5)
-	uint32_t reserved_6; // offset: 6  (0x6)
-	uint32_t reserved_7; // offset: 7  (0x7)
+	uint32_t shadow_base_lo; // offset: 0  (0x0)
+	uint32_t shadow_base_hi; // offset: 1  (0x1)
+	uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
+	uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
+	uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
+	uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
+	uint32_t shadow_initialized; // offset: 6  (0x6)
+	uint32_t ib_vmid; // offset: 7  (0x7)
 	uint32_t reserved_8; // offset: 8  (0x8)
 	uint32_t reserved_9; // offset: 9  (0x9)
 	uint32_t reserved_10; // offset: 10  (0xA)
-- 
2.34.1

