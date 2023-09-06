Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F7DEB8FA5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 10:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4570E10E5EB;
	Wed,  6 Sep 2023 10:13:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0142F10E5EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXMpkb0ePQRyqDoOejlclXlAOKGBp7dlZcR95GUaog15zUn8gWR5FejMBZvwhnUO+aYdKgOcD5FBTeYS8HISmcVWGQxAjttCHnF0fK1f8iSf2RE8WN8Y81hMIoXWcedR5vLnPJAFNPEeJ8OtNTb0fnz214uYpuzG6JWIx72wWiWx0vbYcqY0V4MXPqGF4xBGnvoYoT7H4p5wY1SotMor7Moo3t8bouceKqxf4lB96ltj+EP8TIDDLCJ6QG7vRqC5BLZGZsqGVnVFFZ1uWOMUj9YV2jUPWKo177zlJG/Padid95duvFs+saLN7pEE+kda0dcZR2URtTAbbJELokH7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxn//8Rl9yVvKU944EsXQXYjZyWRCtzZPuDnADhD9u0=;
 b=Jr/s4nHHXMgPf9fVy0y+yC7COFOHGAXgmYSZZgOPQPi5QBwi04QhvV5643GT2Qi9IYWvuSNeaEU13BLxpoV/m2ZetnCQeFA8R43OPAf9KhrXPNWqQEQdQvMtBEJ/JNDjaQfk2Z0lyXpS/zcnXvi4A3fy1P6pmPbiiDB+LOaQzLitWkXAgWZi6+HFt4SQLsOXtMCDMsJ0JCYAQKRp9sGpx+eAOH0olMrHcrv280sf3fScUtSvVfX2E5TyC+oo+ouZfc6VqQl3UILTkSGfH2VGWEmP8RA4YIeaE3eh3oN/axoo2NyJ414bTYOVOSn37nHzpyGcmspqVnDXoU3OFXwhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxn//8Rl9yVvKU944EsXQXYjZyWRCtzZPuDnADhD9u0=;
 b=ZzjR/UkoZrp0dP5zyeLk6InQAOA613ta18s0hUBXQSJ7PwMng1GrvAC/EBplbmCUtujoYyEjui3bV+lcXk7AGDwzQxCNaLxHIZk8vwRXK7ctP835Y9m03YJJJFrkMDZ4hEiGBoQ7uBfGxn091PyLlzpN8ilNGbVTIkInHPflvW4=
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 10:13:12 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6f) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27 via Frontend
 Transport; Wed, 6 Sep 2023 10:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 10:13:12 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 05:13:05 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Correct se_num and reg_inst for gfx v9_4_3 ras
 counters
Date: Wed, 6 Sep 2023 18:12:04 +0800
Message-ID: <20230906101204.2177-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a02d3cb-da28-44f5-ae62-08dbaec1e0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lT9ot4mJr9MpZeSSHrasnFENPEZ4xt6j9vhmZMM0HNm2MArLC49riTQ7/I3H/csBLCkPVpviN4ohrhG6OaygC07v/m5Dw1W1D8JtQXrT3p9llmujsY/CuzgmdiBPE30mftlnOxog4kurhlJe7Uk9QpNLI0hXKj2td4wVWs1SEJXTI7HD9P1dyltQt5JmiMbfyik3ZvKgs5AKp7YMJb1mWNy7cCIRLa4U4oxSQWO6J0JJT+jW8x3iGPxXUUW8LVu8jHn7OiDZmrpxZv+dE7VamsOEh23dxUthTb1zSPItQJDr6E0tNRzsSE5bj+4IkzVHUO/C1G8Q4Xcfct8V+YIzvIBG0181SNLoVu/vgBI03PFBUc90DtRGS+bx392fNkkjlMxPRwhSfAHje5RePNBa7WB71Z3yPZ3mE4mDUI60RJP0LAq6nYPEtfu1j/zreF8F0IwPXHIXfxmTK22xAPfgPXOGpec73dhIOCVc0+jz6EEDBxJnFWADk3OVYWrD627d6CfZfGSiP+R2JglhEv2ItmKV7lU78N+7ZawNQczN0vN6zkG6eYj5h0ylQ9M1bH3BG4VwIp4Nl7kjWhuh9/gTrDW8eliEr4LGSlDMpPMRKFW3qzgJ6FAiTNu6fqlE0pzvl14p4ktAyQ3VI85jOoWYn1M8++qR4CXs4Mx2badmn1CGzLzTdymlbrwfTja/OahqxS4QPLwScTnrmEIe/b8kwpt0TQCn7HnW8/VpYd1Re4HuUUpEe9MlKf+qMuGJeOikPG2KMYTLz1ftjrOx9N0tJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(36860700001)(6636002)(316002)(81166007)(1076003)(82740400003)(2616005)(86362001)(110136005)(70586007)(70206006)(2906002)(41300700001)(8676002)(4326008)(8936002)(47076005)(5660300002)(426003)(336012)(40480700001)(478600001)(16526019)(356005)(26005)(7696005)(36756003)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 10:13:12.5999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a02d3cb-da28-44f5-ae62-08dbaec1e0da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx_v9_4_3_ue|ce_reg_list is an array per gfx core instance
correct the settings of se_num and reg_inst for some of
gfx ras counters so all the available register instances
can be polled for ras status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 40 ++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0a26a00074a6..a60d1a8405d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3653,19 +3653,19 @@ static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ce_reg_list[] = {
 	    AMDGPU_GFX_GC_CANE_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSPI_CE_ERR_STATUS_LO, regSPI_CE_ERR_STATUS_HI),
 	    1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SPI"},
-	    AMDGPU_GFX_SPI_MEM, 8},
+	    AMDGPU_GFX_SPI_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP0_CE_ERR_STATUS_LO, regSP0_CE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SP0"},
-	    AMDGPU_GFX_SP_MEM, 1},
+	    AMDGPU_GFX_SP_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP1_CE_ERR_STATUS_LO, regSP1_CE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SP1"},
-	    AMDGPU_GFX_SP_MEM, 1},
+	    AMDGPU_GFX_SP_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQ_CE_ERR_STATUS_LO, regSQ_CE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SQ"},
-	    AMDGPU_GFX_SQ_MEM, 8},
+	    AMDGPU_GFX_SQ_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQC_CE_EDC_LO, regSQC_CE_EDC_HI),
 	    5, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SQC"},
-	    AMDGPU_GFX_SQC_MEM, 8},
+	    AMDGPU_GFX_SQC_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCX_CE_ERR_STATUS_LO, regTCX_CE_ERR_STATUS_HI),
 	    2, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCX"},
 	    AMDGPU_GFX_TCX_MEM, 1},
@@ -3674,22 +3674,22 @@ static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ce_reg_list[] = {
 	    AMDGPU_GFX_TCC_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTA_CE_EDC_LO, regTA_CE_EDC_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TA"},
-	    AMDGPU_GFX_TA_MEM, 8},
+	    AMDGPU_GFX_TA_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCI_CE_EDC_LO_REG, regTCI_CE_EDC_HI_REG),
-	    31, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCI"},
+	    27, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCI"},
 	    AMDGPU_GFX_TCI_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCP_CE_EDC_LO_REG, regTCP_CE_EDC_HI_REG),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCP"},
-	    AMDGPU_GFX_TCP_MEM, 8},
+	    AMDGPU_GFX_TCP_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTD_CE_EDC_LO, regTD_CE_EDC_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TD"},
-	    AMDGPU_GFX_TD_MEM, 8},
+	    AMDGPU_GFX_TD_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regGCEA_CE_ERR_STATUS_LO, regGCEA_CE_ERR_STATUS_HI),
 	    16, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "GCEA"},
 	    AMDGPU_GFX_GCEA_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regLDS_CE_ERR_STATUS_LO, regLDS_CE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "LDS"},
-	    AMDGPU_GFX_LDS_MEM, 1},
+	    AMDGPU_GFX_LDS_MEM, 4},
 };
 
 static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ue_reg_list[] = {
@@ -3713,19 +3713,19 @@ static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ue_reg_list[] = {
 	    AMDGPU_GFX_GC_CANE_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSPI_UE_ERR_STATUS_LO, regSPI_UE_ERR_STATUS_HI),
 	    1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SPI"},
-	    AMDGPU_GFX_SPI_MEM, 8},
+	    AMDGPU_GFX_SPI_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP0_UE_ERR_STATUS_LO, regSP0_UE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SP0"},
-	    AMDGPU_GFX_SP_MEM, 1},
+	    AMDGPU_GFX_SP_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP1_UE_ERR_STATUS_LO, regSP1_UE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SP1"},
-	    AMDGPU_GFX_SP_MEM, 1},
+	    AMDGPU_GFX_SP_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQ_UE_ERR_STATUS_LO, regSQ_UE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SQ"},
-	    AMDGPU_GFX_SQ_MEM, 8},
+	    AMDGPU_GFX_SQ_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQC_UE_EDC_LO, regSQC_UE_EDC_HI),
 	    5, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SQC"},
-	    AMDGPU_GFX_SQC_MEM, 8},
+	    AMDGPU_GFX_SQC_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCX_UE_ERR_STATUS_LO, regTCX_UE_ERR_STATUS_HI),
 	    2, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCX"},
 	    AMDGPU_GFX_TCX_MEM, 1},
@@ -3734,16 +3734,16 @@ static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ue_reg_list[] = {
 	    AMDGPU_GFX_TCC_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTA_UE_EDC_LO, regTA_UE_EDC_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TA"},
-	    AMDGPU_GFX_TA_MEM, 8},
+	    AMDGPU_GFX_TA_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCI_UE_EDC_LO_REG, regTCI_UE_EDC_HI_REG),
-	    31, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCI"},
+	    27, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCI"},
 	    AMDGPU_GFX_TCI_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCP_UE_EDC_LO_REG, regTCP_UE_EDC_HI_REG),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCP"},
-	    AMDGPU_GFX_TCP_MEM, 8},
+	    AMDGPU_GFX_TCP_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTD_UE_EDC_LO, regTD_UE_EDC_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TD"},
-	    AMDGPU_GFX_TD_MEM, 8},
+	    AMDGPU_GFX_TD_MEM, 4},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCA_UE_ERR_STATUS_LO, regTCA_UE_ERR_STATUS_HI),
 	    2, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "TCA"},
 	    AMDGPU_GFX_TCA_MEM, 1},
@@ -3752,7 +3752,7 @@ static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ue_reg_list[] = {
 	    AMDGPU_GFX_GCEA_MEM, 1},
 	{{AMDGPU_RAS_REG_ENTRY(GC, 0, regLDS_UE_ERR_STATUS_LO, regLDS_UE_ERR_STATUS_HI),
 	    10, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "LDS"},
-	    AMDGPU_GFX_LDS_MEM, 1},
+	    AMDGPU_GFX_LDS_MEM, 4},
 };
 
 static const struct soc15_reg_entry gfx_v9_4_3_ea_err_status_regs = {
-- 
2.17.1

