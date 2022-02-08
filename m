Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7409C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF6210E227;
	Tue,  8 Feb 2022 03:20:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776FD10E227
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 03:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ5vgw8BgfjPpsNVC8b1VVjhoYVaMlDd5kUxoFkCaT4B5/AF1OSCVHaChOZwdAZ9BUhGx57QiEcjhQPq7vZKOR5WDh2vQcweXSWIA85dEc9EVYtyWAR1psqxRZCeA79gKLcceA92yzp5/dTT4vLbk0OKDbTMLV7aCyka/AbPyJi8yh3NZIWC4DUL9wcaVpZqRMbqr0PZmySW1jDawbzQxH0TcinF903vHX+6HdF8kOuSXw0lfLjlg09bp2/tm4e/mjMyXf8rGBVPPLAfBIDsxJd00dxGckm6nXoMZP9mA1nH51PXQyRzTlbQA3TRqk1fCMOOTz5XpAFFUn7CGzlQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilU8ZA8ntN103V8YfiFbGCYm5yJVpUJTMuis9703waY=;
 b=hRiRF47fz0gPl/XttkOBXDz5hOTTgm2+O+z9sprOVoBsewKA5TftUG9nzD6GbtckCJu7qPxg9+EoB+tQYLxJGlvuWGv2LrnbBIbXdjnCBCjkM8gC40l2DLgRTl6EHltSHjqAbfzEkh5MV1vzjZKoH6XnasIrlqAvqGnMaoSP/qgGE5irV3qOcLEYHn6dGkLupEXX3zlspvbJeVy1KxKknllk/BhbsiBljXO4RUwVliIDNc28mGEplH6Cy43I8lRBRTH8jlkjI5xWT7KcoAMDK0sPzkjWFQnVVMeMTZ/BuyZhC7bggLLoipu4ENpeOnJ5pgJKjFtY3ZhFIXMR+Xrzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilU8ZA8ntN103V8YfiFbGCYm5yJVpUJTMuis9703waY=;
 b=p4SKCsGH946bGXio1Vt1fQcGpERlTaqKi1J6k3xTl0rNtQPH6iGcx11dooTfgPn5t+0cKKY/ORvMDtYJn4vqmJ9aku30IX257PJnrsK3kR6DPPtFPjkj4YpQg/KPvAel046qdm0MDJ8zh+ug6XcZAUmJ+oUTLMydec+amMAPopA=
Received: from DM3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:0:50::33) by
 DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Tue, 8 Feb 2022 03:20:28 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::e6) by DM3PR03CA0023.outlook.office365.com
 (2603:10b6:0:50::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Tue, 8 Feb 2022 03:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 03:20:28 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 21:20:26 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/pm: correct UMD pstate clocks for Dimgrey
 Cavefish and Beige Goby
Date: Tue, 8 Feb 2022 11:20:03 +0800
Message-ID: <20220208032009.763982-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec0f697f-8da1-4787-6429-08d9eab1f4c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4911:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49117BB5FBADB944B905C58EE42D9@DM6PR12MB4911.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4VnyhNDhlCT8EAEM06nPHaENPP7dTWV05tghxgj9MeAH5mypVzGwF6P+0Jh5qygQHzp3j8F+LmRxZ/CkUmz3GH1QmQJYcpR4DfrEC3VXsmSkc1W86RzyljydGVz4AcEXvhvKh/N06DA72/mrH/jXMj8Xc6iKG9yXDtpYE5vmh3z4c4MyeajDHDrH6zwbvp/c3RU/Hx0xh4Of8IBywbUN9xUtKH58TUkRz50XuxT5aQn0YVlYODp71OI2KYtnO6BbOK1P9WF8pEAHRYQMKwkWbQ+r9V4Z2iuO1BEbLjF815lr3wJoxkimRLo8n9QuSvhYaiOYhZAbDHn/CfKM/9omAlfjr7vm/DcpeZ+HE7lzhvIrZXOf6NYQiok+UYchW4wD1+B5b51ddu6puSpxDJCfGGDDgHgnQi2tu0YcPM7ZnbiozvAaNRCfK+MMwcR4b0tA2JARaDsfzdgALQ72swgs/93OkHAkKj4nIWRMGKpnm7czSOQp7xEVO8re11bZsWdd/F63uonoe+1UYtW+f+DeQC276AJ9JQPizWuKHTsnrPl0PxrGZsqciwo1NWNJMOiqWa/cVA7YcuAoYusDpKQmFfQvKQVYPe0Qt1yyxvuo5Ked65tQi7VB8FfgJuEXRbH2N+XKTbbI+5xTS1DoNRCzoGMLOujcRopI0iT7qf0ydwxR0Wk634l9Cypt2IAtbajEDlvNQMVQFhq+8/aZOFfhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(8936002)(82310400004)(54906003)(6916009)(70206006)(36860700001)(40460700003)(2616005)(508600001)(316002)(4326008)(86362001)(2906002)(8676002)(1076003)(7696005)(336012)(6666004)(356005)(81166007)(16526019)(186003)(44832011)(36756003)(426003)(26005)(83380400001)(5660300002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:20:28.5048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0f697f-8da1-4787-6429-08d9eab1f4c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the UMD pstate profiling clocks for Dimgrey Cavefish and Beige
Goby.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I74fdbcf2cfa11f97ae16e4921449ab7cdb7e43c9
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 26 +++++++++++++++----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.h   |  8 ++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 5bd48c922385..c335f398ba4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1231,21 +1231,37 @@ static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
 				&dpm_context->dpm_tables.soc_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
+	struct amdgpu_device *adev = smu->adev;
 
 	pstate_table->gfxclk_pstate.min = gfx_table->min;
 	pstate_table->gfxclk_pstate.peak = gfx_table->max;
-	if (gfx_table->max >= SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK)
-		pstate_table->gfxclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK;
 
 	pstate_table->uclk_pstate.min = mem_table->min;
 	pstate_table->uclk_pstate.peak = mem_table->max;
-	if (mem_table->max >= SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK)
-		pstate_table->uclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK;
 
 	pstate_table->socclk_pstate.min = soc_table->min;
 	pstate_table->socclk_pstate.peak = soc_table->max;
-	if (soc_table->max >= SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK)
+
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
+		pstate_table->gfxclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK;
+		pstate_table->uclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK;
 		pstate_table->socclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK;
+		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		pstate_table->gfxclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_GFXCLK;
+		pstate_table->uclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_MEMCLK;
+		pstate_table->socclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_SOCCLK;
+		break;
+	case CHIP_BEIGE_GOBY:
+		pstate_table->gfxclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_GFXCLK;
+		pstate_table->uclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_MEMCLK;
+		pstate_table->socclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_SOCCLK;
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
index 38cd0ece24f6..42f705c7a36f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
@@ -33,6 +33,14 @@ typedef enum {
 #define SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK    960
 #define SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK    1000
 
+#define DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_GFXCLK 1950
+#define DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_SOCCLK 960
+#define DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_MEMCLK 676
+
+#define BEIGE_GOBY_UMD_PSTATE_PROFILING_GFXCLK 2200
+#define BEIGE_GOBY_UMD_PSTATE_PROFILING_SOCCLK 960
+#define BEIGE_GOBY_UMD_PSTATE_PROFILING_MEMCLK 1000
+
 extern void sienna_cichlid_set_ppt_funcs(struct smu_context *smu);
 
 #endif
-- 
2.29.0

