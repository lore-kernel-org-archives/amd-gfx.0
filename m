Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A62C636D7
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4A710EB88;
	Wed, 15 Feb 2023 18:44:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4529710EB83
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvHnhlob+L0OijJxJQ7+dJ5epZINR+R7FAnXfXJL0C4I1+Widy3mdqAvcY0sXt32+AXsJ3GkCTwi7w//ry349g5sfa2l9+J1p/eqiMYeULnSTpZfapfRQlYjhpTvgPD8LABm9fhhcy5rMShD8oAKSMpQNoOS9s3cJ70QxutqUkxDJoZNFemYHQH0XWpvZ2oqBPlPJ4dhWyVDy0jAeeS+lHzvMcezzit1+EygLh4e2kidToT9ueUW/LdMP4EwQSzaHT3mXBhhUq14KwoQhvLgAhnhl7JW5VDAyQ3Jd9we5S9cX4jD72ArJyOtzFvItBGGUTmsHULkn4pZ0bJpsCz7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmbPSI7eNIr2QNvSMZGj8scbJjwGD/febW02bmLEujA=;
 b=UuD6XXBZ4d9kSbKy2au74XuUixZVamvP87b6jKbj9tTja7POQx7bxEwjWUjrbuuxG3C6qRPVnGhKtCu7TSeSFfV1nnpi+QYnnXCIaV6gM2PJhos1rS7gEIZYm+klu6M6P2TA04dJ65MWww/L2h0ZGlKjkFHuJiZLEx/y+mN4K+h5yi2bONnvUNmJ2IC89qNDubrelBvmmXe3nx8HZcb/wubBh0yqFbQszdASwqnbxZqEu/PiHNZHIOYuG6Jz+/TzUPDpRAOwYqcD1tomsDyJ4mufNA7aS7Cu14fL7VT3LA/bBQ0RXCKvXvIMpOtIhBsfK1Haf12Hff515BUg/2dScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmbPSI7eNIr2QNvSMZGj8scbJjwGD/febW02bmLEujA=;
 b=xaD0rKHg5sXuMNzYWRyGFUFMO1nc5MTYh02PoqoSTHj0Bs78bOTCfBwd7pJiLcoAZsFAYtw/IrimpXlFygJ43UYwcB5IwvFNrsh0YTraEP9oQKNuQcnbWlpxN5OyKBeQ1FOAqjgKSaKue/68d2UXIAkO/M5gZDLWZHgzM0fPREg=
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Wed, 15 Feb 2023 18:44:37 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::40) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:36 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:35 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/9] drm/amdgpu: create context space for usermode queue
Date: Wed, 15 Feb 2023 19:43:53 +0100
Message-ID: <20230215184356.2205-6-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 94553c10-6f52-4d9c-2d43-08db0f84b036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RpW6gnM5W8ZlHyyho9EUR4VpBFg2IHy8ts5bxycOzTwN/9JBaDvcc/VoAZ+T/3W43zj0H69QP6T2wmsxYEPB3JPvn5CNAnSQGpK4qRjc9ssIJ95HQ2d8ZDyGogbqivvHquh0yVZAqvxlz6u+Njz9e0soq+QL1BfiGfnQzBv66tR1y0AbD37BmXmpC2Wwm1Tq8hBtWZl9Ns3vPGbdJ4R21vgIjkLrEOzSK5dGJQFKVx9uOWUgVz1qB4C2Q1WfO5jxH2FkLUbsO0kA+iI2Ie9yyqWIDdaFtAQiFPvYawooSUyZW/FMz3NfuEEOLoEj+nAc+MqxTDUH4ARNHQX1ls8zRbFb1K22vdUU7Z00TgTh3Vok02lNzRrR7QnVJUbwD8sQexZmSmUv9K9VNQAczhoZnRVUudfXBnnqXvoT+2iNQ3xZ8BXE85C6g86x1ojqbTHXzOhig9GNp7b4gcyV9uyMp2McmZBDYr2wWqI5qmw5k0E/JvNTinuBGRKVadbFar6ftAmN9kMnbXkas9GQYYWiuLUlkaOtV/6O5WEb3poe6w8qfG+qrUq5iabARqAKmuOkT4ff32j7TPE03DOzewBfAR0rxyfBd5hs6/W5EB1MHeczNmsTYsbHZAHwPZLr03V5Z18JsEs7Wla9wuzATS+rWgnb2mmj805UnnDeNUiVhKzrVm2nEK4DE4yYP/1gEjsUaG9IpWA1RazxT8u2akh0KP4SAGby1c8FCJn19EyHJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(41300700001)(54906003)(316002)(6916009)(8676002)(4326008)(70586007)(70206006)(356005)(36860700001)(86362001)(81166007)(82310400005)(40480700001)(82740400003)(1076003)(7696005)(6666004)(26005)(186003)(16526019)(2906002)(5660300002)(8936002)(336012)(44832011)(426003)(47076005)(478600001)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:36.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94553c10-6f52-4d9c-2d43-08db0f84b036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
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
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

The FW expects us to allocate atleast one page as context space to
process gang, process, shadow, GDS and FW  related work. This patch
creates a joint object for the same, and calculates GPU space offsets
for each of these spaces.

V1: Addressed review comments on RFC patch:
    Alex: Make this function IP specific

V2: Addressed review comments from Christian
    - Allocate only one object for total FW space, and calculate
      offsets for each of these objects.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 60 ++++++++++++++++++-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
index 12e1a785b65a..52de96727f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -23,6 +23,51 @@
 #include "amdgpu.h"
 #include "amdgpu_userqueue.h"
 
+#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
+
+static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+                                                 struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
+    int r, size;
+
+    /*
+     * The FW expects atleast one page space allocated for
+     * process ctx, gang ctx, gds ctx, fw ctx and shadow ctx each.
+     */
+    size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ +
+           AMDGPU_USERQ_FW_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
+    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_GTT,
+                                &ctx->obj,
+                                &ctx->gpu_addr,
+                                &ctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
+        return r;
+    }
+
+    queue->proc_ctx_gpu_addr = ctx->gpu_addr;
+    queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+    queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
+    queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW_CTX_SZ;
+    return 0;
+}
+
+static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+                                                   struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
+
+    amdgpu_bo_free_kernel(&ctx->obj,
+                          &ctx->gpu_addr,
+                          &ctx->cpu_ptr);
+}
+
 static int
 amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -43,10 +88,17 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
     }
 
     memset(mqd->cpu_ptr, 0, size);
+
+    r = amdgpu_userq_gfx_v11_create_ctx_space(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
+        goto free_mqd;
+    }
+
     r = amdgpu_bo_reserve(mqd->obj, false);
     if (unlikely(r != 0)) {
         DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
-        goto free_mqd;
+        goto free_ctx;
     }
 
     queue->userq_prop.use_doorbell = true;
@@ -55,12 +107,15 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
     amdgpu_bo_unreserve(mqd->obj);
     if (r) {
         DRM_ERROR("Failed to init MQD for queue\n");
-        goto free_mqd;
+        goto free_ctx;
     }
 
     DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
     return 0;
 
+free_ctx:
+    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
+
 free_mqd:
     amdgpu_bo_free_kernel(&mqd->obj,
 			   &mqd->gpu_addr,
@@ -73,6 +128,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
 {
     struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
 
+    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
     amdgpu_bo_free_kernel(&mqd->obj,
 			   &mqd->gpu_addr,
 			   &mqd->cpu_ptr);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 2911c88d0fed..8b62ef77cd26 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -38,10 +38,17 @@ struct amdgpu_usermode_queue {
 	int queue_type;
 	uint64_t flags;
 	uint64_t doorbell_handle;
+	uint64_t proc_ctx_gpu_addr;
+	uint64_t gang_ctx_gpu_addr;
+	uint64_t gds_ctx_gpu_addr;
+	uint64_t fw_ctx_gpu_addr;
+	uint64_t shadow_ctx_gpu_addr;
+
 	struct amdgpu_vm *vm;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_mqd_prop userq_prop;
 	struct amdgpu_userq_ctx_space mqd;
+	struct amdgpu_userq_ctx_space fw_space;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

