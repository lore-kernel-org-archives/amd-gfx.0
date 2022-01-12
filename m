Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C2DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 18:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DC110EA28;
	Wed, 12 Jan 2022 18:52:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD6F10EA28
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 18:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEQ1mOk9AF+PXfelsjaxGr6Lfv3NxWyjsAVw82XshCjHSixQKs2D9cVat/XtqCDHQ5E4vy1o/aasZnIHce5UTFgQXatpbwg9Viw+JgAq7x1DUn8+zXbT5zBVtJWUmpI1mLeiXPpi8panvgwW2ofIh83hW7bdtMwhaFZDf/5OGek/S0zzJz/t06KvJweAtPRDDpx+n52O78w5/ydARHcJeHj7xzGuu5RO3/2KVvDrcWvFNgSP5wg4Kf5e3rAk0P8aCb8yWycu7nqkxDN6PDa4Vb5nd6jmA9Cg8Fjj33seC1xaE5Ev78CWEpaJvPEY8kB7P9A2GNzKAfJGbnoAPasWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzovPmc4sVrnTvaLp1F/avzsHLmMuAuyKMSUa1bNi7s=;
 b=Juv9GUerBwnHrr7Hn7mDHHr9EkmsdG8Zdn/ant+yZXJDO1QcXiSbKnK9kOUQgW07Re3BMbiaLz1epBa8oFjJkfRaI96BjcCTH8hAld5Xy2bx3IrTdKJY23CnpF6YsPy64z98BI4GgPH+J6zmS2Ej/kMCxOxotRQOnZ3S603FYrhjAzTzkFZV1ZecN2RzVnMP7V4A+kyx8L6FxZkI4cNwdIPrhFtPy0IYd6Ox28e/Mq9p9QYt5qL9i2G0tpzhC567LVvKoXfVZBhiNV4uLbfdhzsY+96Cnu+Ml+fB6/BU04pyE+RIj/5DarodrOhkcmUkZrv1bYXqH9Gsim/JNgUZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzovPmc4sVrnTvaLp1F/avzsHLmMuAuyKMSUa1bNi7s=;
 b=LbS6Qc5VFZ1//VmvvQCOXGcjhwCuVhq0g/nfD69KjgkgTMw7bcHRWOytbjbJIEX1feO2lWu2zDuXx650dVczBkLgyUh30ROOWtQA/q2Ln/B7yFr7kC26vl7UXa1NNyuBsLbwI4PLYGGnNW/r4xWUmtNpJlXR3pxkDwmQtTiNo9w=
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by CY4PR1201MB0213.namprd12.prod.outlook.com (2603:10b6:910:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 18:52:30 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::6f) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 18:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 18:52:28 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 12:52:27 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: cleanup ttm debug sdma vram access function
Date: Wed, 12 Jan 2022 13:52:18 -0500
Message-ID: <20220112185218.2648420-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0cdfe5-ef4d-48d5-1c56-08d9d5fcae8f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0213:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02135261A6CA4EE1C80AE9B185529@CY4PR1201MB0213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpcpNxoiBSLkP2UT2/pG8+8AlCwk89l/Ts0hh/br5neSDESr6pIrpqxx6UfVOzkd+ieWkL6nkUBn/iw0KZoQZ4jhNYhxzFtadZWMNrRloJrfrUraFyeDJRAc01Zk8k0cGlw7Z/EMHu+VWy2FhQtWh881DxoXSbOz20fhLOxetPrNVXd1yyoyx1/eLqWxUekJt1SqrhKKN+gKYR02tfdUz/u3/mkALgz6NWapdNiYyAG73QTIpsuI6Ku3buL8HkYqQECNKz9j66KPyruwzgk5QLXQRRIR1eVkYYoAEnbSx8WdTDCareJCogolRz6rI7R7X6rxufnKPTjyqrCsdPBwxIH9bLBLm123V9Aw+4nJkerssewr3V56Ffzp/zjRjL0AWRC2aIGCIQS8fVj9wECbsCv70DeHBA3xjsTleSPXkhrLphm3Kn0hzBIONndF/IPMvarZePIpWSP86TVlrIHZBnJoQFPhUK9SUqsr0IXlZg/c+d5iELvsaYgCzOGrQsBVvYg41/HX6aORJni9k44IXi4Wf0g/E9uQbhSHZPYr2P1gh0Nc043R0ehk5ztyKoOes3xmEm9ixF1c48mci/r3uBxcUiUXEql6tcp/SHNiXbZm7I5d5WoF9eN24DBO8WOPFHDNzdfRvuAdt4xo+h07Z5TTIdK5oelT0fE8no7GcUDcQaHOmNg8BZQdv8DQPtrR2GJymuNA+1bLVtq3qIswikK9PsdikUs1fzHucvnyXuSy/W6EAAWOVly0ISdt8ZCs7+gTwi0uRp4kH0ZkXR6vBGN+sKid+xdLLOGRZbQZFKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(2906002)(83380400001)(81166007)(1076003)(70206006)(26005)(70586007)(426003)(8936002)(6916009)(6666004)(4326008)(44832011)(40460700001)(336012)(54906003)(2616005)(47076005)(36860700001)(186003)(356005)(7696005)(82310400004)(36756003)(86362001)(316002)(508600001)(5660300002)(8676002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 18:52:28.6256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0cdfe5-ef4d-48d5-1c56-08d9d5fcae8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0213
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some suggested cleanups to declutter ttm when doing debug VRAM access over
SDMA.

v2: rename post_mortem_allowed func to has_timeouts_enable.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a675dde81ce0..747d310aa72f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1448,6 +1448,15 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 			       enum amd_powergating_state state);
 
+static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
+{
+	return amdgpu_gpu_recovery != 0 &&
+		adev->gfx_timeout != MAX_SCHEDULE_TIMEOUT &&
+		adev->compute_timeout != MAX_SCHEDULE_TIMEOUT &&
+		adev->sdma_timeout != MAX_SCHEDULE_TIMEOUT &&
+		adev->video_timeout != MAX_SCHEDULE_TIMEOUT;
+}
+
 #include "amdgpu_object.h"
 
 static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 33781509838c..b489cd8abe31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1460,10 +1460,11 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (r)
 		goto out;
 
-	src_addr = write ? amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) :
-			amdgpu_bo_gpu_offset(abo);
-	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
-			amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
+	src_addr = amdgpu_bo_gpu_offset(abo);
+	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
+	if (write)
+		swap(src_addr, dst_addr);
+
 	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr, PAGE_SIZE, false);
 
 	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
@@ -1486,15 +1487,6 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	return r;
 }
 
-static inline bool amdgpu_ttm_allow_post_mortem_debug(struct amdgpu_device *adev)
-{
-	return amdgpu_gpu_recovery == 0 ||
-		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
-}
-
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1519,7 +1511,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	if (bo->resource->mem_type != TTM_PL_VRAM)
 		return -EIO;
 
-	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
+	if (amdgpu_device_has_timeouts_enabled(adev) &&
 			!amdgpu_ttm_access_memory_sdma(bo, offset, buf, len, write))
 		return len;
 
@@ -1909,8 +1901,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
-	if (adev->mman.sdma_access_ptr)
-		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	DRM_INFO("amdgpu: ttm finalized\n");
 }
-- 
2.25.1

