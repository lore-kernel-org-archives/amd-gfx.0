Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158C4C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7464011222D;
	Fri,  3 Jun 2022 18:51:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924FE11222D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8Q2UrHileRFUv5OYfzwx/Bf/OM+lS5AVzIFQTBxv6A4oB/dyE0JcQ4PFv5d0BCeYHM/HpxvBUdnvxnsl6J57qHDChCzcOuJz+/CueK2cz0cu4045oS/mTB81KVCXDNPS79cCCERsCvY/bLxdZeg3SlBmRBjO9GqTC3VLX2GTkhf5z8J3oxg1RqNle3CdCLcPipIC+4YW8qBHVvJ8XK57R+u/fkn4MtFylcyyRIZ/6FtV8vnmnGH53ThOTK18VAc34W1zlmPvnYvSXAQ+OWkLUaM8N35CpAfTVUgdYZRjnhfMyOrWoV+Rlqm6Qn5n9YO/MHH7Gp+8Nro93jdN7T87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLtuieiwusuBKXlbny+L4HFR99xH7DAm0UFufJVFRNs=;
 b=hfKS/xLevhmVmtWBid5CSArMTDmViFIRW2F3LCHs+wZp9kGhd1qqmd5ahJlByke6N5LjEQYEiBfiqO7inqHU1tjriULdJMiteQ2/TvNS5nmeHjT+LYIelx/UVZfjHBLQ16vCuRrnPARagrqhYSfS51Mi/g5Qp+Rds7GJUCX1Su+FIpvsHFdg/SnTTL2RCsXPMoucWdhdkrxvYY+a/U3LDnVDqI8xg58MunkFeNxb3NPVAl03jOmoSK3LXNs+iXj5j6QVK0Wvcn6ckSphukhnxPYPhWAnyi8geTbfRJsCH/bH7z17RNPlYQR4aNVHn0S1yqIeet5bK9eWjW5JfY/j/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLtuieiwusuBKXlbny+L4HFR99xH7DAm0UFufJVFRNs=;
 b=rMnoWRoathY5I/Y06hsLJbShLq4r6ChUXqnjS+OCnchV7Lq0fqzv4mV+QWe7G4X70Wlniy1o5IcoyidRQV+8FkAwShz0s3DK5j+I8Hc8uXiz4DMVv09AzXDNDhv/MI4RQgGOdru5J0uAI0oLFVdtNmEFZT9mplbxcxF5/6vhaR8=
Received: from BN0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:141::19)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 18:51:02 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::db) by BN0PR07CA0013.outlook.office365.com
 (2603:10b6:408:141::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 18:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:51:02 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:51:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amd/display: Reduce frame size in the bouding box for
 DCN20
Date: Fri, 3 Jun 2022 14:50:38 -0400
Message-ID: <20220603185042.3408844-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24a2b03e-25e5-4b23-763c-08da459201ad
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6266:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB62661B853F4AC641D455BFAC98A19@SJ1PR12MB6266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdsVuvMe81SfEy/qh523QfMtIjfzoU+MJyvWTWovX2oEgkWe6U1Sg7QREJGWG3qkSLpW3eTiLK7mZuJdp6QrNlbQnLSSemftIF66hL/UKroIZLyyczK2d8MxgGuPTUTYAlGMxkBvRDfWUwhNUNM4obIlWcSRWVo6MGeM2SwOxKamA+dpAN77glHyCFJpMA4tWCRM0oG06vdQCdfDlF7wMZpGqwkyd9AGvUjA15WspLTuYkIsQCNFXvkRTEqzPJ1iskKisUr23DB4h15eP/cQX+CWcZ3Ed+oB3C5wsHJuMEyLaN7CyvAW2MQUSI0BJHEN8WFwWrj1ZBfMB5YqhZTTIKvWuFYsfU+3GhpPEMQOxUqpSe5xh+10pdP0XlqSgT+9kEpJOQLKWSK/kY3DyaxJGMVdGI9+5ovbfvC1q6lf268B0XGwlzOL+FcIJWEJIymHTthu/PO9lJcP1+IrL9pblm/dh25ehybOCH073EGveAyVDATE0BKrlH+bbquWqeQ5Z2mmdjO2UG9lREOd94goP5xWymdjmmhWRS6COEPZjqaSna5oSTWaDFjYFWHXG+hixoHzNBii4iV9lBtD4BxgM6HNYLBcCDwrmAkwGLPAGtYsV3Ny+goMcoZo06yHcXjFVGQ1X6PqzpRhbSq2rLjLgktVded8d0WXMjQYFc7g24K645dEvRTAPLCFQh0oBj5HGT02h2sg0P5qa3/1r89apQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(16526019)(2616005)(8676002)(36860700001)(7696005)(6666004)(26005)(47076005)(40460700003)(8936002)(36756003)(70586007)(4326008)(86362001)(82310400005)(1076003)(5660300002)(2906002)(508600001)(83380400001)(426003)(81166007)(54906003)(6916009)(70206006)(336012)(186003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:51:02.1408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a2b03e-25e5-4b23-763c-08da459201ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
 Stephen Rothwell <sfr@canb.auug.org.au>, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GCC throw warnings for the function dcn20_update_bounding_box due to its
frame size that looks like this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

This commit fixes this issue by eliminating an intermediary variable
that creates a large array.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 38 +++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index eeec40f6fd0a..d9cc178f6980 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1456,21 +1456,20 @@ void dcn20_calculate_wm(
 void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
 {
-	struct _vcs_dpi_voltage_scaling_st calculated_states[DC__VOLTAGE_STATES];
-	int i;
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
+	int i;
 
 	dc_assert_fp_enabled();
 
 	if (num_states == 0)
 		return;
 
-	memset(calculated_states, 0, sizeof(calculated_states));
+	memset(bb->clock_limits, 0, sizeof(bb->clock_limits));
 
-	if (dc->bb_overrides.min_dcfclk_mhz > 0)
+	if (dc->bb_overrides.min_dcfclk_mhz > 0) {
 		min_dcfclk = dc->bb_overrides.min_dcfclk_mhz;
-	else {
+	} else {
 		if (ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev))
 			min_dcfclk = 310;
 		else
@@ -1481,36 +1480,35 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
 
 	for (i = 0; i < num_states; i++) {
 		int min_fclk_required_by_uclk;
-		calculated_states[i].state = i;
-		calculated_states[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
+		bb->clock_limits[i].state = i;
+		bb->clock_limits[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
 
 		// FCLK:UCLK ratio is 1.08
 		min_fclk_required_by_uclk = div_u64(((unsigned long long)uclk_states[i]) * 1080,
 			1000000);
 
-		calculated_states[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
+		bb->clock_limits[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
 				min_dcfclk : min_fclk_required_by_uclk;
 
-		calculated_states[i].socclk_mhz = (calculated_states[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000) ?
-				max_clocks->socClockInKhz / 1000 : calculated_states[i].fabricclk_mhz;
+		bb->clock_limits[i].socclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000) ?
+				max_clocks->socClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
 
-		calculated_states[i].dcfclk_mhz = (calculated_states[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000) ?
-				max_clocks->dcfClockInKhz / 1000 : calculated_states[i].fabricclk_mhz;
+		bb->clock_limits[i].dcfclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000) ?
+				max_clocks->dcfClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
 
-		calculated_states[i].dispclk_mhz = max_clocks->displayClockInKhz / 1000;
-		calculated_states[i].dppclk_mhz = max_clocks->displayClockInKhz / 1000;
-		calculated_states[i].dscclk_mhz = max_clocks->displayClockInKhz / (1000 * 3);
+		bb->clock_limits[i].dispclk_mhz = max_clocks->displayClockInKhz / 1000;
+		bb->clock_limits[i].dppclk_mhz = max_clocks->displayClockInKhz / 1000;
+		bb->clock_limits[i].dscclk_mhz = max_clocks->displayClockInKhz / (1000 * 3);
 
-		calculated_states[i].phyclk_mhz = max_clocks->phyClockInKhz / 1000;
+		bb->clock_limits[i].phyclk_mhz = max_clocks->phyClockInKhz / 1000;
 
 		num_calculated_states++;
 	}
 
-	calculated_states[num_calculated_states - 1].socclk_mhz = max_clocks->socClockInKhz / 1000;
-	calculated_states[num_calculated_states - 1].fabricclk_mhz = max_clocks->socClockInKhz / 1000;
-	calculated_states[num_calculated_states - 1].dcfclk_mhz = max_clocks->dcfClockInKhz / 1000;
+	bb->clock_limits[num_calculated_states - 1].socclk_mhz = max_clocks->socClockInKhz / 1000;
+	bb->clock_limits[num_calculated_states - 1].fabricclk_mhz = max_clocks->socClockInKhz / 1000;
+	bb->clock_limits[num_calculated_states - 1].dcfclk_mhz = max_clocks->dcfClockInKhz / 1000;
 
-	memcpy(bb->clock_limits, calculated_states, sizeof(bb->clock_limits));
 	bb->num_states = num_calculated_states;
 
 	// Duplicate the last state, DML always an extra state identical to max state to work
-- 
2.25.1

