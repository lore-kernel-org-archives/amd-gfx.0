Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EDECD98F0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 11:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C158110EFAB;
	Wed, 17 Jun 2026 11:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5azetz5B";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C377210EFAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 11:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj0EvmQscJix7WJWuvGKcN08Ifojis1tRqwA8tvDa1U1ZHXcJD/g9kRoED9hXhfr7MqFWcr4fXrp6fwpA8XVTJx7dAPG/tBUy2YGrUeHDa7h28KX6iJuB+2ra1dJUkfAAZl/VBh43ymy4OnKx8MeGqrENbdEHdDaxp23KIT/xawfhYcVaJRrXOIvs0hh4exC6sQLl/w17OwsTbn/rYyhfNsUspz2uCKLY5nJA6nG+D274DV2OZZa1HJzf9qKertbkC0VvWUIobCnSkE/NBCrt9gSehQPMBMkrIUVQY0W7dOl75aNgV9kaxOjKrf9frZstIlSqZXzVPPhD3DZ0MqwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=QAhpoUtQl5jUq1isEy0KxqJU4rcJBi/rFonEYMA8sB3XChKOSmVkMSHIOHNZP7WEaWXfK6hS20UzFc4gUsamUDMM2tlS4W4cAl82zvAJf+wl0NDDtDIZSjciusXrs7iFxgAj8XFdRYab0V/pWViBIX+AamdBMQBENQnSPIvl8+vcNlOWRQtleKiSA9qriKs05bTDq+ZuqWjnW983oInkEgNLSB6aVcxbnzyIY19f/qKsTXxlqBgRaAGMWsI1bjdX1XEB/OXSEcbUme1/NwYAc9LUH72ljXgwDTw/viUT2z3uYGpUUSnF7q1KwgdpnKm+OhVhyLtUEfzZGsRz+ZUvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=5azetz5BpgK2XxBNI9rNSNMUN6aHnH4V/ZrSVEXytdSoL13F6MOGz2LopXjtvaharQkzbf1AaDWOr1GSK97I7Skz9w3A8S034RmbkhLuWQ4hc0m3poVDm6DkLMWzscbEYltFN9OX2fJh7iiUwg5KwY3862XvdDPgRJyXmZW9e40=
Received: from MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24)
 by CH8PR12MB9839.namprd12.prod.outlook.com (2603:10b6:610:274::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:25:15 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a9) by MN2PR15CA0055.outlook.office365.com
 (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 11:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:25:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:25:14 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 06:25:11 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 3/4] drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in
 DPM frequency queries
Date: Wed, 17 Jun 2026 16:55:11 +0530
Message-ID: <20260617112511.14181-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH8PR12MB9839:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a008ec5-145d-4f41-4497-08decc631a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: CCRBovrbNauLOK2akxLInJFtaz6LB0xG9uAMgrMGLChLINqJN3AdLHwBdNDbt/8oqqjRD56YMPWLexCe9/rRkp55NZ3raO3802wdzGXJ4ozQnv+b8uKTNjU2mMKoC/Ap2ZHbqF/3Oo8vNCS75kUQomdTNMx6selJIugDqx7LACudKhbYU5SfFQWdkCND46pb16L7fUm+aZJfNuLVteRAdw/eDqQb0Mb8FxrSX0APIURmkmn6J+a9gkL4CrLo7/S06k+svNptyUgjD+HvMyofG2B+RmgKaXlMZUinRlzz5cjnjRdhk+HDe6o+GqKW0wOVcZpQrUAiUNr32LQ4UvOq8UrMPyme3A5XKEW5JUrHgCPwRGaaOr/EF8KxLnL/rDR7950gDg44CX8O431m2mEJPGArMlB8k2V9v1kRvzMa8+hzS6Rqn2P3AoUtavUh+OTpMh5Ls0968LPW5ZRNaHn7HS36NyN6dURayDwmeWk9UY0mAbgdo5hFCfkgfc0UQa6fT6Yazg9Z5uWKD3RV959S+cfvnODs9rh2mBHzcPJL/xbdgqi6AHeAT92X0aiN2WsoHR/3LyPSgb3drHXfAa9Q8SAMFytUdhsQusXJBNYw47eONl8f0zMm5kr0VsJvDIbkYYXElCIahGhclw2jRKFlEyF7OAKYB+6CrYulQYFFiOt9g6VFq3ua12hfbliwJaeNZhyaIc6R8viLNgrccYhCt4yFEMZUrKA7QgVoIQHD3XQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n3B1JSniwxj26ISYTXOOzwodCwiWqeG4BvUnTfTSO1V4SzXpKFHHJdPC8jcvmwGtFky5khxIUCBun9+ViVTMZhf4gZxFfO0hAxwMPZ2R60FNJx7yHURfeSL3Cv+TJzuvHx0m0Ms6zj+hQCbe2nbnd3GW47zEt+5eGLRQHU2ffg+lK4CguUzt6LI3gXLPamtBRrW0II8KSBCANzDQ1DgN69r9Bnd1f5j1/mDfhZAoCZGPjBaI43LHTbHCY3x2quiOapo14nA6DH7PRkQt+ryHSN48NhaAdeXXIQK4PUZqEIx/9MYlUOHBi+qra/IMXBF3sYviR5KG0cquQ0Tws2XXJM2QAhjFbfcGPkq7qMUo6j1GxDupv6aYwWiXKDPSPo5AUd6JnTht01J44Fevp96hu8Ze7OunrNQGP6HT7Q+9duj02K3L4XO/jfvqeiqGUPSP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:25:14.6364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a008ec5-145d-4f41-4497-08decc631a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9839
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add SMU_DCEFCLK case to smu_v14_0_1_get_dpm_freq_by_index and
smu_v14_0_0_get_dpm_freq_by_index using DcfClocks[] with
NumDcfClkLevelsEnabled bounds check. Add matching case in both
get_dpm_level_count functions.

Add SMU_DCEFCLK case in emit_clk_levels to list DCEF DPM levels.
No * marker is emitted since SmuMetrics_t has no DcfclkFrequency
field (same firmware limitation as Phoenix).

Without this, pp_dpm_dcefclk reports N/A on Strix Halo.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index b206a4d0376b..f273b95928c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -735,6 +735,11 @@ static int smu_v14_0_1_get_dpm_freq_by_index(struct smu_context *smu,
 			return -EINVAL;
 		*freq = clk_table->FclkClocks_Freq[dpm_level];
 		break;
+	case SMU_DCEFCLK:
+		if (dpm_level >= clk_table->NumDcfClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DcfClocks[dpm_level];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -779,6 +784,11 @@ static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
 			return -EINVAL;
 		*freq = clk_table->FclkClocks_Freq[dpm_level];
 		break;
+	case SMU_DCEFCLK:
+		if (dpm_level >= clk_table->NumDcfClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DcfClocks[dpm_level];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1142,6 +1152,9 @@ static int smu_v14_0_1_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1171,6 +1184,9 @@ static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1237,6 +1253,18 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 					      cur_value == value ? "*" : "");
 		}
 		break;
+	case SMU_DCEFCLK:
+		ret = smu_v14_0_common_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < count; i++) {
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			if (ret)
+				return ret;
+			size += sysfs_emit_at(buf, size, "%d: %uMhz\n", i, value);
+		}
+		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
 		ret = smu_v14_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
-- 
2.43.0

