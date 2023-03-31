Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80444C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0B8310F340;
	Fri, 31 Mar 2023 22:39:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11D910F334
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzRNLO24g3JQezF7ovG/c0UFjsdeKFSLrG3P/lvOWJxJObVvnu3Hsvw054jGzuKw/SUz8ilPXbk/MBSS+C3SJWGu13f7WlQX97MrVUPAwJg48aQhQsBK2D99PJoeX6Kjdo2ZyxvK7JbLijeFLIPMJ9oJNXjrMQaiDm2MAjFa6v1I3qOK9OCkEXwpvUsupSxi1uchGuRrEFDhFDmfIM21rdWfqbBHf+M/Im74n/6poRppNtCiEZwMr8pfDsejsc7TBq6rrD4H2ojwqoz8UbIB24c6JAC+q82j1IHjRXXdA8P/OsVqoHUK7l/LHYW/JTaFD+rG7UVHO/ziKqiueFC6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l28kbjaW5SmjDZfQ3PCaOas2fK895+/yZR6jil8Rvlw=;
 b=I88Ve7ri10aEQddvwps8h2d6bxAGjrICEU9cE3mtwcx0jwF9C9P69+8od96pDidauZ1JETV56eIYaJR9hJ+phgITDSxzCnF81JDEB6bIjcDcC7C+TMQi49qrwtEIumMBv8dwX4tHZVcLV8nqxJAdQv/W7z3FA+AVgl3HglpKmvKbsbR6HPSqoC9ByWtMQ8Hw4Wh0ZePUqCNcUNAAc3PgypcFpSy55yVZkGcasqZ8d7hrb179jE9ZEA0T8NiYoI2VXHLHhsE5vt+I4PLdMyr4PB0RG0TBTLT71ad7y4CUKXdlWiF1ckaPpwucy/YgDpV6sqqatnr4P/PciV7gXfHQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l28kbjaW5SmjDZfQ3PCaOas2fK895+/yZR6jil8Rvlw=;
 b=t9NRiljQnBOlf9SkXj9MU7uTpDf8DnYWyD85PChu9ClUqYSkEsRp+UI8Dm/ij8UDXOSJ2bw50e4toeRBQ50o9IkdAHOFo7q3C1sCmswlwSNFEGNBoBWYjciui/T/H8sHJn6o/ohm3aDr+ehxVNgIXHpoPbods7fXw+Qyo5VIWwI=
Received: from CY8PR22CA0009.namprd22.prod.outlook.com (2603:10b6:930:45::16)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 22:39:44 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:45:cafe::c6) by CY8PR22CA0009.outlook.office365.com
 (2603:10b6:930:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 22:39:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:39:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable MGCG on SDMAv4.4.2
Date: Fri, 31 Mar 2023 18:39:27 -0400
Message-ID: <20230331223927.8388-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331223927.8388-1-alexander.deucher@amd.com>
References: <20230331223927.8388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|BL1PR12MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5d467d-248e-4b97-b20c-08db3238d324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfDioASeVeKkVQa0KS4W9Skc4u9C1m4KUV7Mf91+C5tkum7XQ+0hvtrxlkj8LJSjfj9HRdYhSU6fc9+YWp09370WQxiRARpjRFaTgTW8lk1jUOO6ZhEZlbmT4kg53z0MSaVSnplHOQlCPA+cX+Eundv6RmeNYu4Y1oKV1jtZR+N2QMlmREC3UwTlb+jQ9C+7p79k0ycbexcXkljTOWCDNzK7Zj71QjHtndZsyBx2Q6M1PagJQ7jIyCFOik3YVHTceAzNOwBzfQVMlbSBgtvtvU66Y0RXs7atwlwLuGnSUw8MSLmzA8A09b3FYX5dXZZ2YD00vVafPmSQD4CEw/9tH2o1TUrUw9JdAeWCrtlgFX785b05s7uw/XcJKpMKWloTfhottx0yHLxf9I6UcfS+zywnZjlO2bdE48/jKPP/eYK/e8JZqBhpxV1OmHImYOmMpRweDoTT8YAs0GfX9JX79u9xW64jn15m8bd5qDWnQD31xMncLWU6/ZH0YUYNIctmWgURhegN0xdZMrYzioagK+IgndTLzNwCtx4xzmseaYNoRwvCWCQAEbeAygWRBtlYVfDawUiE0UkBPfN4xWiqcdvfXEkqwOEUUeLOUtg0ZiAl3biW7+5eus0eR0qe26FREo6YjftqQaet8d1Yfzor97eEUrQ4hzRUYTV6+Piaej+q57GeaByvkbrRlXZGqomAL76uHDw9xWdizm9GswiujhrgEu/d/tyGmDsOijKW+cU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(81166007)(6916009)(4326008)(316002)(54906003)(70586007)(8676002)(40460700003)(70206006)(478600001)(356005)(36860700001)(5660300002)(82310400005)(41300700001)(7696005)(8936002)(2906002)(82740400003)(40480700001)(86362001)(336012)(186003)(16526019)(2616005)(426003)(26005)(6666004)(1076003)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:39:44.4074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5d467d-248e-4b97-b20c-08db3238d324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Enable clock gating on SDMAv4.4.2 versions. Leave memory light sleep to
default.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  4 ++--
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 7aa26e716a2d..dca0beec0252 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1683,7 +1683,11 @@ static void sdma_v4_4_2_inst_update_medium_grain_light_sleep(
 	uint32_t data, def;
 	int i;
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
+	/* leave as default if it is not driver controlled */
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS))
+		return;
+
+	if (enable) {
 		for_each_inst(i, inst_mask) {
 			/* 1-not override: enable sdma mem light sleep */
 			def = data = RREG32_SDMA(i, regSDMA_POWER_CNTL);
@@ -1708,12 +1712,14 @@ static void sdma_v4_4_2_inst_update_medium_grain_clock_gating(
 	uint32_t data, def;
 	int i;
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
+	/* leave as default if it is not driver controlled */
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG))
+		return;
+
+	if (enable) {
 		for_each_inst(i, inst_mask) {
 			def = data = RREG32_SDMA(i, regSDMA_CLK_CTRL);
-			data &= ~(SDMA_CLK_CTRL__SOFT_OVERRIDE7_MASK |
-				  SDMA_CLK_CTRL__SOFT_OVERRIDE6_MASK |
-				  SDMA_CLK_CTRL__SOFT_OVERRIDE5_MASK |
+			data &= ~(SDMA_CLK_CTRL__SOFT_OVERRIDE5_MASK |
 				  SDMA_CLK_CTRL__SOFT_OVERRIDE4_MASK |
 				  SDMA_CLK_CTRL__SOFT_OVERRIDE3_MASK |
 				  SDMA_CLK_CTRL__SOFT_OVERRIDE2_MASK |
@@ -1725,9 +1731,7 @@ static void sdma_v4_4_2_inst_update_medium_grain_clock_gating(
 	} else {
 		for_each_inst(i, inst_mask) {
 			def = data = RREG32_SDMA(i, regSDMA_CLK_CTRL);
-			data |= (SDMA_CLK_CTRL__SOFT_OVERRIDE7_MASK |
-				 SDMA_CLK_CTRL__SOFT_OVERRIDE6_MASK |
-				 SDMA_CLK_CTRL__SOFT_OVERRIDE5_MASK |
+			data |= (SDMA_CLK_CTRL__SOFT_OVERRIDE5_MASK |
 				 SDMA_CLK_CTRL__SOFT_OVERRIDE4_MASK |
 				 SDMA_CLK_CTRL__SOFT_OVERRIDE3_MASK |
 				 SDMA_CLK_CTRL__SOFT_OVERRIDE2_MASK |
@@ -1773,7 +1777,7 @@ static void sdma_v4_4_2_get_clockgating_state(void *handle, u64 *flags)
 
 	/* AMD_CG_SUPPORT_SDMA_MGCG */
 	data = RREG32(SOC15_REG_OFFSET(SDMA0, GET_INST(SDMA0, 0), regSDMA_CLK_CTRL));
-	if (!(data & SDMA_CLK_CTRL__SOFT_OVERRIDE7_MASK))
+	if (!(data & SDMA_CLK_CTRL__SOFT_OVERRIDE5_MASK))
 		*flags |= AMD_CG_SUPPORT_SDMA_MGCG;
 
 	/* AMD_CG_SUPPORT_SDMA_LS */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4626cae7eb18..8550a6b0b890 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1154,8 +1154,8 @@ static int soc15_common_early_init(void *handle)
 		adev->asic_funcs = &aqua_vanjaram_asic_funcs;
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS | AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_GFX_CGLS | AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_VCN_MGCG | AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-- 
2.39.2

