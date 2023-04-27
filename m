Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43809C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F2B10EA96;
	Thu, 27 Apr 2023 06:28:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF0D10EAA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpZrXVe2rMOy0/PIOxcVAGJty6192LWwjsmjMvKUO/SkRWYW0slzbIUtrV+zVY9aEZKn24k5bEcTRtY+lkBokggAa1m9lpGbL7CVH3xI6WE/zEjuxCYtVGggRavx8RmfDzjBw0dAyjQu9p4FRlss8EgUxIYySWLxcJmC33R45jJHWc5Oo8z0mK2ciJQHmU3CCg3YRaba79+52wjwhpoH3QgPQJn72IwQ9xv0DiwLrELzMetFSgeGYKMOaCRX42lkJRYufIOeVP/G6keUtl5c39BFyWphJmUDKIdQbbcS5BWEBSHRHeZFIZ7JOgf2mY/DV3++8FKvwTKBGNupue5QjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCnBmXRuEBlB4PH3Lxs/Mdjkto4LA1HR7XCTJvB/9Yc=;
 b=QSm/jHveejPgJVKPzcwSr6LAdXjtOu+Id+f/qHswAFfH9Jg3E00a/REAGT5XduSaCiCknhYc3L9aRUcmKo/yiov76zAXVkwkbmW8iqzlOIYeP6gDSU0WueYveI8XppDYgSQp0eE13z/tsMRU50lT3vsDBMvxomoQzwVxI36MN6kgm6de9ECO67L6B8EIiLOV4SKL3vQJcaZJhsyeNAbAP62R35sMFCwF9nVZ/XfWNYnqWxcWEFSbK6qrmlaX8wplX95Kh98iqV2s03Zfnb7vHCCHaB/7qG+DnYAvTV67hCzEFNm8TW/4pritju95rcHeMzcqd2S7P4g8rvTWFu5BKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCnBmXRuEBlB4PH3Lxs/Mdjkto4LA1HR7XCTJvB/9Yc=;
 b=DSttxBwkZsYlZ/jjgbFm3+rHBIb5jIAWQDDXU1xoAveUSVqajPZeJTYQhgrSMbU16WSf/uZLJmqpADJK4iTNShurpfjsGZNACLhNFc3uB4i4lr24ZgEG4frxswIQ4mZfBW1fuDgTaNPnwb005L8wLoQc9p4aLxC83xaLiJ4i2M0=
Received: from BN9PR03CA0880.namprd03.prod.outlook.com (2603:10b6:408:13c::15)
 by SJ0PR12MB5421.namprd12.prod.outlook.com (2603:10b6:a03:3bb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 06:27:56 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::1c) by BN9PR03CA0880.outlook.office365.com
 (2603:10b6:408:13c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:55 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:52 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] amdgpu/pm: Optimize emit_clock_levels for aldebaran -
 part 3
Date: Thu, 27 Apr 2023 02:27:18 -0400
Message-ID: <20230427062718.1172269-9-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427062718.1172269-1-darren.powell@amd.com>
References: <20230427062718.1172269-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|SJ0PR12MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8ac55b-6ed3-4e2d-2fee-08db46e88996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUgTfeL0isfrbic0zeRENOuDF6YpYNKd6x51WDojDRNbpkNhkGVIZ4784Z7RBPeHIvr5AGo2epSyi/uv3ZcweuZnjjxrhhFyEYKOXiwgbEeFjPlPHdECHUAWn9Y4Rb4Yi3V1MxxpLGt2Pw+70uDEh7WQQ8TOU5iHob+3jHruAmZSQCas375DWtZYBbH/AkpjAAknGlUiCXSFBZt7Cd+JXGxIp7TLUx/rQrxWvkH7oWWxaJ4kvdmGK8kQ0AJPZQFfkR0vwdXav3jPTQ9m1IkqZoZLWtugWEhzBgGSbEjIyLQCmVRugdQBN5DmmG4pnfQZvuicS14SzIurfUL5fJE3FgW+AEIN68AoYE+ju3uBLhDJ4bLVzK96p3mKk69k9I33agv0wPfH/ULkh6wrVGmSbhZQ2SOFFNmnCCkChlFHiXL+HGF32WzQxGYHvZVoHUVPNytwgCU0+5p3ImS0FG7gIDX+MgQqY7MolaNggHrZrp/8hPJ303l10fov3Z17j4kLfOasStAkFCnxzWAXbigEldqYPs/PNgp/m8ad75PaoUtDgVkqWh8nLgx9LM2dNt3NkIbcx3oOlSo6gV4wLY4nPkrfPSci/6hsl9AMrOgD6HKnMhLaDBe48hZV89NXa4FnkY+FVwY72G5cnq/TjGVn5cLHiKpmXrPg/TY74zN7/HCAWGyHz06W2oHAWLn5lW94E7Ht9pqns1pDOyyNTlKw5tHg3Y5iNSPMCQGWezkjY3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(316002)(4326008)(40460700003)(6916009)(70586007)(70206006)(54906003)(7696005)(82310400005)(6666004)(86362001)(36756003)(40480700001)(478600001)(186003)(16526019)(26005)(1076003)(41300700001)(81166007)(2616005)(356005)(36860700001)(2906002)(47076005)(5660300002)(426003)(44832011)(336012)(8936002)(8676002)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:55.7266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8ac55b-6ed3-4e2d-2fee-08db46e88996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5421
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
Cc: lijo.lazar@amd.com, ray.huang@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, lang.yu@amd.com,
 david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

   split switch statement into two and consolidate the common
   code for printing most of the types of clock speeds

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 82 ++++++-------------
 1 file changed, 27 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index b315353adfdf..9d37800bfae9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -788,17 +788,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 			freq_values[2] = max_clk;
 			freq_values[1] = cur_value;
 		}
-
-		for (i = 0; i < display_levels; i++) {
-			clock_mhz = freq_values[i];
-			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (display_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-				clock_mhz,
-				(freq_match) ? "*" : "");
-		}
-
 		break;
 
 	case SMU_OD_MCLK:
@@ -813,16 +802,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clock_mhz,
-					(freq_match) ? "*" : "");
-		}
 		break;
 
 	case SMU_SOCCLK:
@@ -834,16 +813,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clock_mhz,
-					(freq_match) ? "*" : "");
-		}
 		break;
 
 	case SMU_FCLK:
@@ -855,16 +824,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clock_mhz,
-					(freq_match) ? "*" : "");
-		}
 		break;
 
 	case SMU_VCLK:
@@ -876,16 +835,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clock_mhz,
-					(freq_match) ? "*" : "");
-		}
 		break;
 
 	case SMU_DCLK:
@@ -897,21 +846,44 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
+	switch (type) {
+	case SMU_OD_SCLK:
+	case SMU_SCLK:
+		for (i = 0; i < display_levels; i++) {
+			clock_mhz = freq_values[i];
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (display_levels == 1);
+
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
+				clock_mhz,
+				(freq_match) ? "*" : "");
+		}
+		break;
+
+	case SMU_OD_MCLK:
+	case SMU_MCLK:
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
 			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clock_mhz,
-					(freq_match) ? "*" : "");
+				i, clock_mhz,
+				(freq_match) ? "*" : "");
 		}
 		break;
-
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	return 0;
-- 
2.34.1

