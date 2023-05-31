Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E209FC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BD910E4EB;
	Wed, 31 May 2023 14:40:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA36310E0A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfeXQDn/OzcY8K6pGTVy3HMRkXLtEpjYqi1R1midKoXJKCVHbZ3RSFrxpV391f2k3eqiucN6vm4jQhvWYuqbBlXp9A1SSGHC4Q2QRIm+VwUiY0khjzYE2STRM1UHbGxOEqhTklNhkyiqxO6QheYqMUC/KJapa8OT/KltZ7eYEdaJhebzcQQXAASdZpPw84mbqGmQmQ8pdrDQAQCxgtcy4gMzaUq9oCsDcEP1fSoj+RK3EoqbNeIiLr7yXVEXAEoGPDj5uCNGWBpovco7OY8IZ9IGjJqYZWoWviABRkCho6n1NTVxSy3I0E051eLm6ZgpAmQjrNg3UDulksx8L/ZJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzFqt+NQqX2D+E1GtWK2aF8jOjIIZ9mt5jI4z1H4uHE=;
 b=fdseJegOLOVuG55uk854QGV3ccFcN24wndtS2CGHKqt4px75k5cqZ9dgGDIrCN1+F9T3uf5HOuso87yG7zvbHleJ/+pmaEjysOBTm9N/bXox4sQ3ZVy0k6va6tSEjx/KK+Fk3ApPb0k75sBX+py4mt1MThjZQ6pyUdhXl+CiqYGVkz4/TuTkpIohIG897x/0ziJvV7PK+Ga/7XZk5lr05UmXo6SLfitAYN2CWGbPrjFD0+ceRQ0DX2swoebHsgrwibR+YzFAHdSUYKn+R/3L38lvohHijB3jcnPOT9kgEzgZyaqBa0LKHJj0WwzhWaJU1wRkR5xskis2A3RANcXV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzFqt+NQqX2D+E1GtWK2aF8jOjIIZ9mt5jI4z1H4uHE=;
 b=paflXy1oYI86iZuQ9pMulbHOb1mF5KTwJhfuDrFPBm4+eWlMSs2fZPS23C6bLCud97LioKD34GUcuvd58qRi/YP5xclSg3oQy0ua5lf+8h7oPic1M1/x3Wi0Z483RWsoWrgrQgT2iBZ4E0B29xW9V1g+4PHIiABSPXVVQHM1kLI=
Received: from BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 14:40:04 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39a:cafe::2a) by BY3PR03CA0012.outlook.office365.com
 (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Wed, 31 May 2023 14:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 14:40:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 09:40:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: Enable VM_CONTEXT1_CNTL after page table
 addr is set."
Date: Wed, 31 May 2023 10:39:06 -0400
Message-ID: <20230531143906.3472425-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e57656-a971-44f6-5c76-08db61e4ebb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmbbG+Zo3bNGE24eGZZEmz3G+EHHm7u5xr5OoDRVVIm1pS6COyZIg4xU60Wwl3GNVCRtVtvWYNL1JVaLv8lhx5x7R2gncwl6uccaSDmJwEvoCUx1ZdWaHQTAFHLe4hrbgZANpqpmTiWgUQKaDQWjrlx0M4SQ799eH6AICbq8wio0YrKmmFpt0QCLIB9OvPa70zcyGDxVi0Csgi6T68pFcz5zOPOV/JdZdrXVqHxue4wqUlCkRAQn2R7H+tBXzxW+mB1XoY3n0Dzeri/zsLDCFGlcF35ubzgys2ZcMeqNzPfSJa+fy51IS+WDVMSFDFE7EMBk5xM8kSQwggTyraGOgdY5RUXEzMBTq1Yed6kj2bCtZjjuXrwy4YiTET+IdOY+cI+ZskRSW3rKqTFqEGbFgMsRGPIPKZSqQNIXNBcXqbC0GvYPLkpeoAKYPl0PoBqNzkxC/ZO0ybWmYRXC8CQY0Gv9EyCe4LxsuM4E3AfoPxn1anTpYankxl6xOeCjbPoFWXIJ3xnZpULvrl0XQ7o5iTDsqfMZonnCTnxZXN3oiZAF8VHGPhhH6AvlRomRv/YoanAZK2AGergbrSWKSINQATs5RvrU8vYe4GmcF39q4WRtIiPOvbB7usawhWE06TdkOTGMvEFQo/Uc27njHcctZ5OptHgW2PEs2bZr9yIfCbAnKiPV2arO1U71YV8/K78eo+Os4Xnm2GkXS97VAHFZYXuzs4Em5/IkSrmGoKqlvTOxROxO9wxjYE3Zp94txAUdgr9uK2SfoO7tuKWuRWZj3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(70586007)(6916009)(70206006)(54906003)(4326008)(316002)(478600001)(36756003)(86362001)(36860700001)(47076005)(186003)(426003)(26005)(1076003)(16526019)(83380400001)(336012)(8936002)(8676002)(30864003)(2906002)(82310400005)(40480700001)(7696005)(5660300002)(41300700001)(82740400003)(356005)(81166007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:40:03.5576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e57656-a971-44f6-5c76-08db61e4ebb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
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
 Zibin Liu <ghostfly23333@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f57a74f5b42d1627bd5366f88952d42819e91146.

After talking this over with Christian, the original programming
sequence was correct.  The enable bit needs to be set before
programming the rest of the context.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Zibin Liu <ghostfly23333@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 5 +----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 5 +----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c   | 5 +----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   | 5 +----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 5 +----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    | 6 +-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c    | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  | 5 +----
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 7 +------
 15 files changed, 15 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 52a1e79ee4d8..d94cc1ec7242 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -261,7 +261,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -302,9 +302,6 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 108674f6eef0..4dabf910334b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -330,7 +330,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
-			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 					    num_level);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -377,9 +377,6 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 					    i * hub->ctx_addr_distance,
 					    upper_32_bits(adev->vm_manager.max_pfn - 1));
-			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
-					    i * hub->ctx_distance, tmp);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 502cb6e1fe84..f173a61c6c15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -288,7 +288,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -324,9 +324,6 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index c5dbd5af23f0..d8fc3e8088cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -297,7 +297,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -333,9 +333,6 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index d7f86a6834a1..c53147f9c9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -296,7 +296,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -332,9 +332,6 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 3371597a7280..ae777487d72e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -301,7 +301,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -337,9 +337,6 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 22070a379140..fb91b31056ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -243,7 +243,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -280,9 +280,6 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index f746981a7d4e..9086f2fdfaf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -275,7 +275,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -314,9 +314,6 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 618019caca8e..5e8b493f8699 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -346,7 +346,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
 						  i);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-					    ENABLE_CONTEXT, 0);
+					    ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 					    PAGE_TABLE_DEPTH, num_level);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -388,10 +388,6 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 				regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				i * hub->ctx_addr_distance,
 				upper_32_bits(adev->vm_manager.max_pfn - 1));
-			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-					    ENABLE_CONTEXT, 1);
-			WREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
-					    i * hub->ctx_distance, tmp);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index d4b9796389cf..8f76c6ecf50a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -368,7 +368,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -405,9 +405,6 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index d9d5e698060e..8bd0fc8d9d25 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -286,7 +286,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -323,9 +323,6 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index a18b61a39866..441379e91cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -325,7 +325,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -362,9 +362,6 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 92e86bc64bcb..12c7f4b46ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -312,7 +312,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -349,9 +349,6 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 0f01ead6d105..5dadc85abf7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -317,7 +317,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -354,9 +354,6 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 18391a0fdf0c..e790f890aec6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -310,7 +310,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
 				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
-				    ENABLE_CONTEXT, 0);
+				    ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    PAGE_TABLE_DEPTH,
 				    num_level);
@@ -357,11 +357,6 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
 				i * hub->ctx_addr_distance,
 				upper_32_bits(adev->vm_manager.max_pfn - 1));
-		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
-				    ENABLE_CONTEXT, 1);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
-				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
-				    i * hub->ctx_distance, tmp);
 	}
 }
 
-- 
2.40.1

