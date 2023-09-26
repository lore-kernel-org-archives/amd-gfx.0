Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6F6E7D27B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 11:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44C110E39D;
	Tue, 26 Sep 2023 11:03:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8632510E39D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 11:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc8o7geEsUb2YdO3d0AF1f0g4K7zPNAfAYWcTiClqfy5ib9E2O0ZHeQ0T6woGLvzkjCdWTLJJrRRQtPb4lm481Nu4U+GS3nYTU/Nsauz3kxNvgqpKew8G8BeB61CqddO/giIGedU3R/yU8FC6AYXGeSOyZ/ViXtyB4rD9VAZmg3DJsdLI1xHm8teURKsNlyOHYXnPoMUc+gM3Ygc8Hbb5BX6BZANnVnIQkYqtJl7iwdhS9M0tm4fQPU/sOxNPSUmLZ1ouIPywuofQgpql4Cwlh/LO8z058ywGWUhLZzkCvzAlbvQssNFMpwJU8JxK84px7UK3waG1pQxT8Of2RYFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkWAt1G4ihZhHvO6eUtByoqYMjHsJ8C+dgqkX9xgujI=;
 b=PeXfJ23W1LppKy0AogH+Y9BP0Qhe7MLKEikPOzins/ceZEEHMBbzKsCUJSNYQ7DFOPc0uHqL5ZB6t5jrTuA5A4IY+1ECpH8Vq4+x8envc3Huz5C7Jd9MFOeSV1Z9so6nXpxOEAlvDJPFf5wfikCExfKyTl5LVF9NH2pyUJbSrm7BGVd/fbjc93x6C549LKDHuxstFuzSlEh+RRmsLEBiOz9/Z4GjctbAvcsrtLTD0wfX2Gn4+yD5YNVBcDrv6C0TUMPn+V+5GbFLBPZF5wHK7MN7aE+RJtTW20CXRYserEY14kC5NC5u0qD0i9/CWDsX44nLzLyB/4qBEcf9njCw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkWAt1G4ihZhHvO6eUtByoqYMjHsJ8C+dgqkX9xgujI=;
 b=OFZQWoVl0n4Lfca1PlQS1v+jT8lFN6Yo9lArC42nKpzTQ4zj42KNnBAVqIoooIdO400D6Lqh7F3DmPe2lB3fEvWj8wd/CcGc0CiB96ixy15uo1F1umVWulD+TbA4Q7V4FSnLfH8W8o1fxFBMZ8IwGh78NlocIn2XfASGazsrjNY=
Received: from DS7PR03CA0331.namprd03.prod.outlook.com (2603:10b6:8:55::26) by
 CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.24; Tue, 26 Sep
 2023 11:03:05 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::d1) by DS7PR03CA0331.outlook.office365.com
 (2603:10b6:8:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 11:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 11:03:04 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 06:03:02 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amd/pm: fix the print_clk_levels issue for SMU v13.0.6
Date: Tue, 26 Sep 2023 19:02:49 +0800
Message-ID: <20230926110249.5071-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: fca44a5c-5ad7-4b63-62ee-08dbbe802881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QMRoLCPTXDc/jBlHaiSjr6ksjpHnWW3QC5XGbEe5hua/h/hvpky9dqB8bX13+Sy+GjxN+wQONMBXqrHe8gto/8x6UYRjp3QHUtA2Wa0FxSBH5tQSkIyAru+W2XU6GqP0F6iMJxiw4HUqSHJtmBGA5IhJ+R/LULSELrBoHREVy4V3cboPoag5G1VzUUxhO0wX45J2OEdHDVb3/kHgdlRjo+I9+kqMZUe7eU6Dr5CJ77f/pxhentpNjO67IulkR6zcSqPsEUoRHJljZxihz9cDKsCQI9Gc1pilgTEDTaMqPoh71m2qoRodzoVBXgZkyVcO1qzlRreh1624E8oP/7LkKLJUI3dDtsDRVbDUKae4EPV6IrCJx10LnFicr/0VbgdhbIL4Q8BRFEhCjxe6OB11Sq9ElFVJvfdWf+b807FTLzmwJNU/S157gjd0ku5wJtwDMHkKI/KVUTYVDV8RDXCxTBqBlBXgOisLYAtUSe6GYObwh7+yyT4fJqhfCW1q1tiMJcxOG9xyVgSjrFOAQQ3lt+FVGucyVaqlbPmZg07P3z5HLa1XnSk6nGiVkVO1itSgvGggGya/5x3Wmm9LnUXl4LRkh2EXNFz/HKCLQZ93h/s/8I2D+JkNik0rS3J6gKbzopdigQGWxgq4t5+DjQ2RJhS7xu13QYtitJPFM+jNaMN6zfc+Z2DleRjXkDVmx/OXBzs1d+94R72gYAOECbETFPiFD8ehDKBSMs2RqHvFDZjgDeYvEuVzoeWLKIbhiKKPg7b1gzS7qTYYV4T8irBuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(316002)(2616005)(336012)(16526019)(1076003)(7696005)(86362001)(40480700001)(26005)(41300700001)(47076005)(36860700001)(356005)(83380400001)(36756003)(40460700003)(426003)(82740400003)(81166007)(54906003)(6916009)(8936002)(44832011)(4326008)(70586007)(5660300002)(70206006)(2906002)(8676002)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:03:04.6935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca44a5c-5ad7-4b63-62ee-08dbbe802881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pass the correct size to smu_v13_0_6_print_clks, otherwise
the same place in buf will be re-written.

Change-Id: Ia0e12430d01146a11490204c1bab4b4f06cd17ea
Signed-off-by: Le Ma <le.ma@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11a6cd96c601..19c117eb5ebe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -821,12 +821,12 @@ static int smu_v13_0_6_get_current_clk_freq_by_table(struct smu_context *smu,
 	return smu_v13_0_6_get_smu_metrics_data(smu, member_type, value);
 }
 
-static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf,
+static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
 				  struct smu_13_0_dpm_table *single_dpm_table,
 				  uint32_t curr_clk, const char *clk_name)
 {
 	struct pp_clock_levels_with_latency clocks;
-	int i, ret, size = 0, level = -1;
+	int i, ret, level = -1;
 	uint32_t clk1, clk2;
 
 	ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
@@ -947,8 +947,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
-					      "mclk");
+		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					      now, "mclk");
 
 	case SMU_SOCCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
@@ -961,8 +961,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
-					      "socclk");
+		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					      now, "socclk");
 
 	case SMU_FCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
@@ -975,8 +975,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
-					      "fclk");
+		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					      now, "fclk");
 
 	case SMU_VCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
@@ -989,8 +989,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
-					      "vclk");
+		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					      now, "vclk");
 
 	case SMU_DCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
@@ -1003,8 +1003,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
-					      "dclk");
+		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					      now, "dclk");
 
 	default:
 		break;
-- 
2.38.1

