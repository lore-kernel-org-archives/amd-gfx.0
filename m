Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4173C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373D16E7E5;
	Thu, 25 Nov 2021 10:58:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D2E6E5A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNYXzGaum7zVYSptAdWb7qxrhV8lBc5dZ/Eg6CYmL5d8omqqrEVJpiLkykTID0y9wTSYpGuNU+RPTBkC+AShHFktBnI+olnZxQGxlHdhtqboNWCnbO657eZQteFfU5U/dD2mK/WMJiFiIr4RYkna01WMxZB8vQvCn9qAkokMszBy2St4xqeKKN50SVXLv3VFDL6s6UEPS+W9oOrRJbmuQULGqXUQLCKtdRb42cjUuAG+DgXQGv+hmVO4e8myDgExccGEyZ6Le3ViEI4k3sdI2Slqpk2p7rJOzAp4wc9U1kuDpSSs1me1Qo+HnRbinHVH0apOel7tDBJtK2dYKZ50tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llNjs8GldxKFCtnojAGf6pCIOAqK2WLz4eBcBgf4iHM=;
 b=LISGRyzmu3V4lRU4VAYZivvHOPsZVN2NSNR+/tKRbQ9jowtI488cT8beZWEKopKqN2L5Gqp2dXNfPjsJlg49RoZ+FSo3Orngx7nPiR0lvxRLk1QGiR8dnnTlJoe5u/DScT6HR/toQMvUfu/cP9/FVwAwPILLk+R93MR55cyL3vEQ+ZOjB2jQJUBmKyK50Wz4/GpKMEblKc46xSnEwGk4wyGFqNKHMHq+OrkjW2wt0HnrJVfn1IVAzTHQEKu5kTnCcZygpJy0ghlmMC5ykipGumjoj0aDErF2JTR0gg7Q6ACHOv8xQv9mkmPtTeVMKsZeXFUaOhU26sk+WijGLuE8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llNjs8GldxKFCtnojAGf6pCIOAqK2WLz4eBcBgf4iHM=;
 b=mCcUXcU3QxZI3jPsoh/YAWyvPCw16ZPU9Gm+0zdsyVIKy7/xC0pUcazx031noX2JUYtsRU0HqsPyJdiTqNKG3jr8f6j+xZo2JzlsYh4Yd9YZuUcqe0TiYZT2aH7MVH7rNDJkNEL2vlVWLlE5FTn19Yp0/DciFhoMUMdsgEzWCsE=
Received: from DM3PR12CA0052.namprd12.prod.outlook.com (2603:10b6:0:56::20) by
 BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Thu, 25 Nov
 2021 10:58:35 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::54) by DM3PR12CA0052.outlook.office365.com
 (2603:10b6:0:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:35 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:32 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amdgpu: Modify gfx block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:56:54 +0800
Message-ID: <20211125105701.15860-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125105701.15860-1-YiPeng.Chai@amd.com>
References: <20211125105701.15860-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7562ad4-403e-4f32-3516-08d9b0028728
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4915D79774214E4A6E647143FC629@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BIdoIWKFVdqV1pYaEIV77q9LeRCOmnL5ZL9VS4lljuN4wMgrz1dsMNsGODqap2whm9vjM+QCw6544rPTNGmL7OKotXRi5tSqh3O/uXO1RrLEm+LuJ28nM9Glr8YZYGIJXXUUqdaH44pHlxrf7jz5LQz7nisMpxBEvSueG+C5yVM6wmq1kuWb6SVU7NURHfZFByJVCzOQT2esbV2trgJhEu97cmoH+EKAcFVEjoNEzBH13WNNeP9mbJ+JoZpHg8+HarGdtCO+44pvcnecbC6e0gUMcvQpZ+HSvFExgKepQGk8CGkueUyPsfyHzVVmQV7qpiy0tMma4T8e6kefC06ka50/D+EXWj6AkfD3kf09Xm6OtbGh/8HnpCCbKpzFRnd21FPXRDaSNu3naG8wcq+Ym4NhFLF4S1yeGr0l7nkYkOPS/fwHdZD4NTL8XIGOM3GTu049AO8HDRhGQcfk40i0oR/dBRQjOPKgqXxI4h1rHo8dSZ/gvHfiJ1n652u5VoiRuQaUk6BPuKL/tnDL4QNrIjVwaNK2uPCW6bgLC8G14Mc8UAxLNcXzpQj8aLrgSWdCiR+N0nKVG4OxiqJfKFrX/3+tEYveMWYowKLT1mJitFHxqG55B+y+G0Tiavreqd0kBbSiJvLqSimTNTGhKrxZW6hN/e/YhwBbEJOqLLbkUw6FjKqvBSq6sZF7J0RPPT35NhSvz4dMNXfFLScD60cK8dwo8k9wDIQubnyz4RWQT5BmLfibVVV4bKiAB4/Z/xk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(70586007)(8936002)(2906002)(7696005)(70206006)(6666004)(316002)(336012)(86362001)(5660300002)(6916009)(508600001)(47076005)(83380400001)(36860700001)(8676002)(426003)(4326008)(30864003)(2616005)(36756003)(186003)(1076003)(16526019)(26005)(81166007)(356005)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:35.2049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7562ad4-403e-4f32-3516-08d9b0028728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify gfx block ras functions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 28 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 19 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 21 ++++++++++---------
 6 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1795d448c700..90ac0e9a32cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -697,8 +697,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
 		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_count)
-			adev->gfx.ras_funcs->query_ras_error_count(adev, err_data);
+		    adev->gfx.ras_funcs->ops.query_ras_error_count)
+			adev->gfx.ras_funcs->ops.query_ras_error_count(adev, err_data);
 		amdgpu_ras_reset_gpu(adev);
 	}
 	return AMDGPU_RAS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b78b4a0e182..2a7f78f17c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -31,6 +31,7 @@
 #include "amdgpu_ring.h"
 #include "amdgpu_rlc.h"
 #include "soc15.h"
+#include "amdgpu_ras.h"
 
 /* GFX current status */
 #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
@@ -214,15 +215,7 @@ struct amdgpu_cu_info {
 };
 
 struct amdgpu_gfx_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*ras_error_inject)(struct amdgpu_device *adev,
-				void *inject_if);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-				     void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
-	void (*query_ras_error_status)(struct amdgpu_device *adev);
-	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+	struct amdgpu_ras_block_ops ops;
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dc6c8130e2d7..790aaba065ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -920,12 +920,12 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_count)
-			adev->gfx.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->gfx.ras_funcs->ops.query_ras_error_count)
+			adev->gfx.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 
 		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_status)
-			adev->gfx.ras_funcs->query_ras_error_status(adev);
+		    adev->gfx.ras_funcs->ops.query_ras_error_status)
+			adev->gfx.ras_funcs->ops.query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -1018,12 +1018,12 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 	switch (block) {
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->reset_ras_error_count)
-			adev->gfx.ras_funcs->reset_ras_error_count(adev);
+		    adev->gfx.ras_funcs->ops.reset_ras_error_count)
+			adev->gfx.ras_funcs->ops.reset_ras_error_count(adev);
 
 		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->reset_ras_error_status)
-			adev->gfx.ras_funcs->reset_ras_error_status(adev);
+		    adev->gfx.ras_funcs->ops.reset_ras_error_status)
+			adev->gfx.ras_funcs->ops.reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -1103,8 +1103,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->ras_error_inject)
-			ret = adev->gfx.ras_funcs->ras_error_inject(adev, info);
+		    adev->gfx.ras_funcs->ops.ras_error_inject)
+			ret = adev->gfx.ras_funcs->ops.ras_error_inject(adev, info);
 		else
 			ret = -EINVAL;
 		break;
@@ -1734,8 +1734,8 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_status)
-			adev->gfx.ras_funcs->query_ras_error_status(adev);
+		    adev->gfx.ras_funcs->ops.query_ras_error_status)
+			adev->gfx.ras_funcs->ops.query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 08e91e7245df..ba00dbbb5e4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -817,7 +817,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
-static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
@@ -2128,11 +2128,13 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
 };
 
 static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs = {
-	.ras_late_init = amdgpu_gfx_ras_late_init,
-	.ras_fini = amdgpu_gfx_ras_fini,
-	.ras_error_inject = &gfx_v9_0_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
+	.ops = {
+		.ras_late_init = amdgpu_gfx_ras_late_init,
+		.ras_fini = amdgpu_gfx_ras_fini,
+		.ras_error_inject = &gfx_v9_0_ras_error_inject,
+		.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
+		.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
+	}
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
@@ -2449,8 +2451,8 @@ static int gfx_v9_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->ras_fini)
-		adev->gfx.ras_funcs->ras_fini(adev);
+	    adev->gfx.ras_funcs->ops.ras_fini)
+		adev->gfx.ras_funcs->ops.ras_fini(adev);
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
@@ -4889,8 +4891,8 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 		return r;
 
 	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->ras_late_init) {
-		r = adev->gfx.ras_funcs->ras_late_init(adev);
+	    adev->gfx.ras_funcs->ops.ras_late_init) {
+		r = adev->gfx.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -6841,7 +6843,7 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);
 }
 
-static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -6850,7 +6852,7 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t reg_value;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -6879,8 +6881,6 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	gfx_v9_0_query_utc_edc_status(adev, err_data);
-
-	return 0;
 }
 
 static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index b4789dfc2bb9..758c51a076f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -863,7 +863,7 @@ static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -872,7 +872,7 @@ static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t reg_value;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -903,7 +903,6 @@ static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 
 	gfx_v9_4_query_utc_edc_status(adev, err_data);
 
-	return 0;
 }
 
 static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
@@ -1030,10 +1029,12 @@ static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs = {
-        .ras_late_init = amdgpu_gfx_ras_late_init,
-        .ras_fini = amdgpu_gfx_ras_fini,
-        .ras_error_inject = &gfx_v9_4_ras_error_inject,
-        .query_ras_error_count = &gfx_v9_4_query_ras_error_count,
-        .reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
-        .query_ras_error_status = &gfx_v9_4_query_ras_error_status,
+	.ops = {
+		.ras_late_init = amdgpu_gfx_ras_late_init,
+		.ras_fini = amdgpu_gfx_ras_fini,
+		.ras_error_inject = &gfx_v9_4_ras_error_inject,
+		.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
+		.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
+		.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
+	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 54306fd45ff1..00f9bfa68af7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1644,14 +1644,14 @@ static int gfx_v9_4_2_query_utc_edc_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 					    void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint32_t sec_count = 0, ded_count = 0;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -1664,7 +1664,6 @@ static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += sec_count;
 	err_data->ue_count += ded_count;
 
-	return 0;
 }
 
 static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device *adev)
@@ -1935,12 +1934,14 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs = {
-	.ras_late_init = amdgpu_gfx_ras_late_init,
-	.ras_fini = amdgpu_gfx_ras_fini,
-	.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
-	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+	.ops = {
+		.ras_late_init = amdgpu_gfx_ras_late_init,
+		.ras_fini = amdgpu_gfx_ras_fini,
+		.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
+		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
+		.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
+		.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
+		.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+	},
 	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
 };
-- 
2.25.1

