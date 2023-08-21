Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD4EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 06:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBF510E1DF;
	Mon, 21 Aug 2023 06:33:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C83110E1E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 06:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqZGjD1FObXFjx2RbEpcjVGaCSmAKA4RvNw2Fje2YImZhsuH8IfwGe9epb8AoneMMSiry5krt/7dXIfvGENp1Fu24m31V7SSMRnCKEiVTWVPcoYYevVVJG8b95MVI9G3mGoQpN3NYl7z02wIqicX/js6ziTGh9a8NLt8eFIOd0ajZy4TMoPvvG0nzdM5/Q5IbsFkySqG9cXwwp5wnFW3ecDpL9QNlYw9TDgwZfb9JPwHK5qylEW8RDlKer1ezaGe7/ucWpepzQQX9UNNHTdawLpzcH2n0sP9gfGEyOx+xlwfEjtKuly6mn/1+G7qMEqSfYy6pLDUn4/yUPBWoW/Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCVimQn38u2cCI0XfJau5+THGB8bDbwDiHvJtkajREo=;
 b=HsmwNOsjbkgIvtWO6EXHrtqLH1a02HINyRQm5J0inGH2SNroQErJ8ZlGAfAtnm0/A5jbS1ElismBjpbPViQvZHI3QiFbox5CLjpAJRptRZ9uOxBHGk90PXAC6NzCW5cIweh85Fvcj7ifCmsr8IZl/1yGPvEqgTfyNZf/uMFT4SRHa2r0UOUkSgie6MeQBymm48QZzx35Y31NfKx2489RRo9sI54q57CrkkjDUBoLjdpy7WmRv1ojVDUgBHsCp2zHkUMu7xEn4TWcsc+sQW7wZH6po0Tgd6NaXNFL/vhADWDvcWX04zmDsWTWiJGdvcR2ngW2C4KADOWFWATVbtZxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCVimQn38u2cCI0XfJau5+THGB8bDbwDiHvJtkajREo=;
 b=zkiBfQ96sEyNv8YmA9IGwQleJ0xnLH4e+jR+5fWXxQ4PCVg+KPALcEeKRq06uoBNMRl9e5gxLtB9rkYdrQHnPeS7g4C6rSSTITbAnAVTtOhiXVRtdwgXUmY7bxsHVcXIXnlgFAFZyn2dI60a5S3eIIXQv19GYhSuzj/1zkRpFnY=
Received: from CYZPR05CA0002.namprd05.prod.outlook.com (2603:10b6:930:89::20)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 06:33:12 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::d8) by CYZPR05CA0002.outlook.office365.com
 (2603:10b6:930:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Mon, 21 Aug 2023 06:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 06:33:12 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 01:33:10 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fulfill the support for SMU13 `pp_dpm_dcefclk`
 interface
Date: Mon, 21 Aug 2023 14:32:55 +0800
Message-ID: <20230821063255.628681-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|BL1PR12MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 42256742-bed3-484d-4442-08dba2107e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpMZTWhUbSqtiiOOKHCSyw/chh8BuV2a2aSgTsR/QHm47kCEmgADQE9K8HIGLZu4/d4aUx/qV+fswVH2Bv4SBVdtqTs/ZF2L3hOFyeultW8gK/mJGQZAHrHgqCLSrD66A75Z6HOsZ0gWPH3hygveGYZypRIZ4+rVqMTvsJYCkpyWvUuAicHCAiOhmvrtTLlc2rQZINmJAo5irwYkD/VGvGqWfyl3o9RjDoptMBlerU0x3PcH0kq+hJkZtOYpTbAyhXgzZv8LXEcG6v2YR0TpKzxAhIGWZl/U5IrZgD3nMWB8Om9Hf1VdUM0H4jmlxNFHsmWSc5WhOAiUv9tEaTWpQQUgxnTDMfQNnI/aIcaUV0GAoS+IfYjG1k9fqvuRnaYHXWPBLUkrrdLStP5JYfKrX3C9nv6KyTU9A7m5wewsTiv+dP3LVrYQjBsDbXTvdNtCOVIljj8wFvP3f59rimpcffDyAt6Iu9ylP7ggN9WhIq6Yk2hdWoYMXsVGXAWgSMcRbxJM/ixEE3nr/psDo8E3qdstZCjLJCGTrZMKLY7L2vMcNjQ5Sl43D5UM6PJZeow7pyHcRFafrvXFaCx+b6thqegI9Nf0rn24WhHsPQ0SJQ0DI/AUuc0a37+CY4S3kIxRmr8MS0DCAnStRY1WaOppDTtDNb2aRt2CDgL+T5bHOyXDKb2NLBoObjUpeOAhLwaVzGC97XKdon3m/ssTRlNk1v+bAPJV6a74wkjEkcnYB/2EahhipbtfWrPDLT2meny6o1+b+oxiXOoheY40XwXFfsAdmCif/wIJyOC5fgC0FIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(47076005)(2906002)(83380400001)(82740400003)(356005)(81166007)(36756003)(86362001)(40480700001)(2616005)(44832011)(1076003)(5660300002)(316002)(6916009)(70206006)(70586007)(54906003)(41300700001)(7696005)(8936002)(8676002)(4326008)(6666004)(478600001)(336012)(426003)(26005)(16526019)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 06:33:12.0135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42256742-bed3-484d-4442-08dba2107e10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Guan Yu <guan.yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the incomplete SMU13 `pp_dpm_dcefclk` implementation.

Reported-by: Guan Yu <guan.yu@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 27 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 27 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index bd0d5f027cac..5fdb2b3c042a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -176,6 +176,7 @@ static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(VCLK1,		PPCLK_VCLK_1),
 	CLK_MAP(DCLK,		PPCLK_DCLK_0),
 	CLK_MAP(DCLK1,		PPCLK_DCLK_1),
+	CLK_MAP(DCEFCLK,	PPCLK_DCFCLK),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -707,6 +708,22 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		pcie_table->num_of_link_levels++;
 	}
 
+	/* dcefclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
+		ret = smu_v13_0_set_single_dpm_table(smu,
+						     SMU_DCEFCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
+
 	return 0;
 }
 
@@ -794,6 +811,9 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_FCLK:
 		*value = metrics->CurrClock[PPCLK_FCLK];
 		break;
+	case METRICS_CURR_DCEFCLK:
+		*value = metrics->CurrClock[PPCLK_DCFCLK];
+		break;
 	case METRICS_AVERAGE_GFXCLK:
 		if (metrics->AverageGfxActivity <= SMU_13_0_0_BUSY_THRESHOLD)
 			*value = metrics->AverageGfxclkFrequencyPostDs;
@@ -1047,6 +1067,9 @@ static int smu_v13_0_0_get_current_clk_freq_by_table(struct smu_context *smu,
 	case PPCLK_DCLK_1:
 		member_type = METRICS_AVERAGE_DCLK1;
 		break;
+	case PPCLK_DCFCLK:
+		member_type = METRICS_CURR_DCEFCLK;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1196,6 +1219,9 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 	case SMU_DCLK1:
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 		break;
+	case SMU_DCEFCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.dcef_table);
+		break;
 	default:
 		break;
 	}
@@ -1209,6 +1235,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK1:
 	case SMU_DCLK:
 	case SMU_DCLK1:
+	case SMU_DCEFCLK:
 		ret = smu_v13_0_0_get_current_clk_freq_by_table(smu, clk_type, &curr_freq);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to get current clock freq!");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index e54a6efc4fb5..d289662f4223 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -147,6 +147,7 @@ static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(VCLK1,		PPCLK_VCLK_1),
 	CLK_MAP(DCLK,		PPCLK_DCLK_0),
 	CLK_MAP(DCLK1,		PPCLK_DCLK_1),
+	CLK_MAP(DCEFCLK,	PPCLK_DCFCLK),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -696,6 +697,22 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		pcie_table->num_of_link_levels++;
 	}
 
+	/* dcefclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
+		ret = smu_v13_0_set_single_dpm_table(smu,
+						     SMU_DCEFCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
+
 	return 0;
 }
 
@@ -777,6 +794,9 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_FCLK:
 		*value = metrics->CurrClock[PPCLK_FCLK];
 		break;
+	case METRICS_CURR_DCEFCLK:
+		*value = metrics->CurrClock[PPCLK_DCFCLK];
+		break;
 	case METRICS_AVERAGE_GFXCLK:
 		*value = metrics->AverageGfxclkFrequencyPreDs;
 		break;
@@ -1027,6 +1047,9 @@ static int smu_v13_0_7_get_current_clk_freq_by_table(struct smu_context *smu,
 	case PPCLK_DCLK_1:
 		member_type = METRICS_CURR_DCLK1;
 		break;
+	case PPCLK_DCFCLK:
+		member_type = METRICS_CURR_DCEFCLK;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1176,6 +1199,9 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 	case SMU_DCLK1:
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 		break;
+	case SMU_DCEFCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.dcef_table);
+		break;
 	default:
 		break;
 	}
@@ -1189,6 +1215,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK1:
 	case SMU_DCLK:
 	case SMU_DCLK1:
+	case SMU_DCEFCLK:
 		ret = smu_v13_0_7_get_current_clk_freq_by_table(smu, clk_type, &curr_freq);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to get current clock freq!");
-- 
2.34.1

