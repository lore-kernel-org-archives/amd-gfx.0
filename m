Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF73C77B61
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785F710EB85;
	Wed, 29 Mar 2023 16:05:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B3D10EB9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdKFG2iKHEmJRyGrZ8rx9zteq8CPnCrbTr/9KntV0u7RftIq6wCiA0G4bZhLAum3FX3QXaesPvCi1NsNKE1nQgR7nZiQy58dpYao/f4BhHrWtdJwCRjTOZFuvfhDBBrSzZCl1OBB9H1kJADM6QzRFMK6IVvfdO4tvFxyvaUrpBT431aLMHjSm37/UNDnXcrr5ggG0uNESkDLnuB2TLCw9qXUS5jeckHbLBt5ieJvWmQwbdyNjHpenqZicg9+ApHxmbXLi0p/GNFqe9lFv1e2UXgYuy8C3Kvztc38DqFokKOFCaWdNZK5jjegDFE9fDEm7Ke09QyPu9tFAMbSS63FTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFOoqXwXXG38moY0t6XJ8tN/VgEkp3m6MxNKyRYuO8E=;
 b=YinD/chyGrrJGK3NZ4aTTrQuhSXvvGjyHNYJTiLII8zqjUIPMo3Okqd9ryKSmtklyU1E0kVULFgpYaS05C7i1CyrEONi4hJxI2ho2iaJq4KRgt/ePbg/a1MBASVGlTNCCltMKwLXDdN8ZovQb+I4WxSwxNVCLZ4oc5HnhCog8ugHpZ0r7WwNkaFOnD8LGSuSFaMUFgUMv0FvMoAcqGrOxyRub9GFXqsh/XTJ9jrLi1lfAzrVFBLVVeoXR6HhbLGsRAIpl41Nq7Dw1WHo+O1Kha/ZQlrEsmxwuagC+z2EGM0v2d8yYdU6XHODR7yD7rXFyVPHiyzEsvJOqBlT4Pog2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFOoqXwXXG38moY0t6XJ8tN/VgEkp3m6MxNKyRYuO8E=;
 b=xAIZOz5r7Zwgc9jdSUxOs7RJ4HjBXiHaJtZ0VTjgA5kc268sZSbNnH4W0faRcZUMIEpvuUtpw3SN/IIbwb/KWNRNfORSu5ovPNstAoM+tNBBB09eG1UMSQc2ry+bttpHAcQG/0o3HY7hVcQsbNDffWoEz25ed6Lxi9XHcY7tLDo=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 16:05:17 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::e8) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 16:05:17 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:14 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/9] drm/amdgpu: add new parameters in v11_struct
Date: Wed, 29 Mar 2023 18:04:42 +0200
Message-ID: <20230329160445.1300-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|DM4PR12MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e93145f-dca0-4edc-18bd-08db306f638e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAhueg8mzkmxga7bXyRlGD/M0tOlehFYJ7QbsSgv0RLfHseokS65UOJcBYEY4vFDJmMsdEnIHcO3R5idcu/Sezz87zkTyU78UXk712O/0IwCBPGZk4ABm/5k2YcrDuNc7Eo9g6vRIEeJMI0tEJI3ipLiG8Uzyj/u7PFx0/oEaRj8lmek2rw4ViCanu0k7bG4zdGlztoiEQ0JrjKbTQGKLrfYbarXtDQWu7PRfvft57MwiS2Z3QnZGZcde0s9Dp0bb+8Is8zlGVPki/c3aGk5j1JqCBX6F2SGS4k25paXFrqH2w2haTb0tV9PLPoVWkvu65VZ9wMWo0aP9AFsyVke0v+nHfPgENB1ifVbBlSedKpJfcypC4c7xJ0MIAKA1T4dsdEUuDg9Dt4digiJ8URL8jG6uAFXzB7L5HMUafuEAWEdnPDIUBJxRPIiODjqOguxsh+Px4WvQrUIOjEWDYw4NmLgJjwq3Mkl93LT/jTCCoa3J5H38uWCjagof3qEG8+xwegfMxXHIY5oBR4TPjtceluB4ZaFtPGbha6LbiGi/FeC2c2OVbUCnep7a5raaACOpUyCgqLCDtoTKY42zgIzlVsI2nTE1Usa8KBa3/IZqjQ73LZbwO6wcG2R0wHTzYnc0oLIYBp07HxlSjLtGXK9Kc60xc/665VstMAOlVwYpstE/jNby7sB1XK/OIu6FlgAq5FN9OaNdr+ByON60CqLdI92y6wNcr7qy1Uq9AfQi68=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(70586007)(8676002)(70206006)(41300700001)(6916009)(40460700003)(40480700001)(4326008)(2906002)(5660300002)(81166007)(8936002)(44832011)(1076003)(82310400005)(6666004)(2616005)(36756003)(47076005)(426003)(336012)(83380400001)(186003)(16526019)(316002)(54906003)(26005)(36860700001)(7696005)(86362001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:17.1254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e93145f-dca0-4edc-18bd-08db306f638e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind
 Yadav <arvind.yadav@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
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
2.40.0

