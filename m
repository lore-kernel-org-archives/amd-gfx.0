Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960F8CE7B0C
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 08:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0DC10E5EE;
	Thu, 28 Sep 2023 08:31:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7279E10E5EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 08:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4p7x04IwFbroViXcc2AilflkFAZkA8wAaV6DiV4SEvpGkbweU25N5uYbu+u3uh4sF7ovZj1NUroTDaqpIg63vFH6PY3tuECuvqL76v0mKrOuCx9qG2f6Q+2cxDipt96b0oZ9006q0WYS34igMQRvCtzfpE0+Jlo/EZCSb7hrXogLhM6UAEsNNTi9fSsw7ijBj4cvnuje8QYYtZZGkPMmvvHv2+8Z4BpoNksOhMPB0Zucv2/ByL85M8W+uOSWv895J7B6+fVfAwtyi5nFWuHg5bvN1qw4EYpzEYtzNBUHz3FdgYwA7bABC1Cruv8wADD2d7iMOYAOZWPFKXfi7f0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azVoi4XMRxUJkeTaGCgYBegiwPiDPbFcCNu4gJVwvAI=;
 b=KY7tGeIISfkAJEMubVmHLGc4OJSCaTF8nv6tM7sw1XetVm8T0iDY2B12UVw6y14LDdE4QjpL6++Vx8iFNqfbZla93fwHORcLvcGHWnhSv/GtwaSazD68DfopRc846VOT9TjVkjVNOEKXMGZL7+AGuSZysHxxvjLCF/2phVHf6SlIxiTm1UOE9lCzHfAMjq+plPyvISwACY/j/4JJZFk3/MzIJPNEcHyIH+A3msZ++Z//1MWtHg1Eu2yy41ByhOt29Zau//mMHxfFEJCb3i9fZOFBE1ufKaFe/tvXnJSuozHNn8uwXqLTuar9fGscdEqKgFWbKaSYpL1C4aXnkyGXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azVoi4XMRxUJkeTaGCgYBegiwPiDPbFcCNu4gJVwvAI=;
 b=zADnSM+d+a7kF+LJXnZY2LKS5L/jt2dCgrkJmrDDusYfK7svLkBzZV9dQKB6Ljx+/c4HzUU+ZuAWr54tM4ybzx6d6os1zQzL0ai5/OE2IqXgYTws2+MGOU1q/C1de/T8MEurhm2lxBeRAaoBEJGeUApdT+B0LqLhO4bbyhZRc9k=
Received: from CY8PR19CA0042.namprd19.prod.outlook.com (2603:10b6:930:6::7) by
 CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Thu, 28 Sep 2023 08:31:48 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::9) by CY8PR19CA0042.outlook.office365.com
 (2603:10b6:930:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 08:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 08:31:48 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 03:31:46 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add hub->ctx_distance in setup_vmid_config
Date: Thu, 28 Sep 2023 16:31:31 +0800
Message-ID: <20230928083131.2858658-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7067aaf1-4f16-4489-0e25-08dbbffd5b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQmugfHdgVVcFiSJxhooTLaVSUc9mg492LrxM+k2YxVKsuYixfaDC4TVe8wTibh0aJsuSCzSThy57x/MveLSKcTyZok3bFgmMALj5PwLp7Nt5OSJSIOctmNpIetEiku/bGQ2Wdh8bZgi6ZPz6fexHZZOaHRwWOxdT6md40O6gCvOY+j+NPgvgQtzUCGHdvKnBsMirRFlAz6Uizthex7nXvBp4DtXBs2JPCS6HBpWw4hnlRWFm30Ax0Q9clyWdcxHoL2u62yWR2hBV8Cbq16NSVXRL4UGsPAC2tO7OWftoiSt3+tmmtMtYwnQ5EPcAzihWbacfK0b/Pv6MXxIM1rcJSdULQlQ7fbbevWjACTwQCEsw6LBLhuGGUqy18OpPJlGuFplCiPO80GngdLWc0GooVU9htEZu8cTiweDtlf44Oa0oK48jSUTQ4t/lKudBWCgKWfVkZHOry6eXGl38R6nGljCTt3Xl0MrsyNe7D0qTRAxd6/+hVSra9a4cPtLrQ1zrj8LOySXlj07IGrLnBmYV1d0t8DTw1xh3GFp3SVQwWxS23Sw3RRPugjPT1FcYCjXhJgT+fBkw2QyjnXZsi5enqqXBGdTOghWhmM3brTKqwJAhAWdB7cpbl4FFJCCL00FGSMRYYI88U6sdDZyBzMM9JJSobmO8wHCLJahLWjrq118Qo7Tvg8Gzt/PNOnFNSsNniGDJ/6MUtZgBBHJKZImCDqi561cF+TuEgCnkNKWsacZp7v4/MqVQr0DMbi8TtIZDTd2LbPbpsYMpA7OyTXGgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(83380400001)(6666004)(478600001)(336012)(426003)(36860700001)(47076005)(16526019)(2616005)(40460700003)(26005)(356005)(70206006)(1076003)(40480700001)(7696005)(86362001)(81166007)(82740400003)(6916009)(316002)(41300700001)(8936002)(30864003)(54906003)(36756003)(5660300002)(4326008)(2906002)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:31:48.4778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7067aaf1-4f16-4489-0e25-08dbbffd5b81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add hub->ctx_distance when read CONTEXT1_CNTL, align w/
write back operation.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c     | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index bcb6ba03cead..f9949fedfbb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -297,7 +297,7 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index cdc290a474a9..53a2ba5fcf4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -260,7 +260,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		block_size -= 9;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index ff60670b8464..5f949caa68b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -329,7 +329,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
-			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
+			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 					    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 8521c45e8f38..793faf62cb07 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -287,7 +287,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index f829c441640a..cd0e8a321e46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -296,7 +296,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 89ff7910cb0f..abe30c8bd2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -294,7 +294,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index be1da5927910..b3ef6e71811f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -299,7 +299,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index fb91b31056ca..843219a91736 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -242,7 +242,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		block_size -= 9;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 9086f2fdfaf4..92432cd2c0c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -274,7 +274,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 		block_size -= 9;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 784c4e077470..2c0419faf8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -344,7 +344,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
-						  i);
+						  i * hub->ctx_distance);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 					    ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 37458f906980..02fd45261399 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -367,7 +367,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 4ddd9448e2bc..5eb8122e2746 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -285,7 +285,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 9627df8b194b..7d5242df58a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -323,7 +323,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 77bff803b452..134c4ec10887 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -310,7 +310,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index d1fc9dce7151..f0f182f033b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -315,7 +315,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index 3d80a184ce6b..76b12f015d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -303,7 +303,7 @@ static void mmhub_v3_3_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 5718e4d40e66..1b7da4aff2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -308,7 +308,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
-				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
+				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
-- 
2.37.3

