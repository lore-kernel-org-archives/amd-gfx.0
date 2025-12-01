Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A3D111A8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7069110E37A;
	Mon,  1 Dec 2025 10:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/5gctk3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9581610E36F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etA2/xTktE2kQgMCj1Nw9TgTfANMRf6g+VHh08IllxAiDNiAOCmYkhF8UtwLgsFJ3y2BivsXhwyVjgzk9f641mX5lUKgCcDgRlPxCH13McaPTVD0wpJoTp1oLOvS3oIDV1xeqACykbPL3U5PGZsU6O2Tiq6lGdvr8K7KhGeZOpehYqEUbE2Fo3AIo6OG8Uq8Ygp8WZEUSm6Wjl83MFkeUWfNvfWVDDvV/UsGq8cPW9Cyi0NQItea0i3almsDWeiw/214cytAuWyz0QgdaOOldLpTeUjMGgVGcRNZu13QdDaeu21NlTwAwjJghtNUtV8+lSw10N94M8Hh7FRrq2aaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBvmJAyViy+Rvgzp+Ug36W5w1w6VSRV+yDdj4CdpqCQ=;
 b=SGov3mWD27YPAVJx/ROCRjxe7fM1glDUuYHUahc4MZuc4TCla5Xwt5DYF3xhEMCaFR0AzQAzfDtKzZTwzbcnxJFb6Jd/yGM/umuYzrmTGjJst8seF/Nz8rYoxX/9oKjMcGW6jqZMQXg/P8gQJeKGCXCsHIen8JII8G1Pau9c3znjurdbhJqZpc8/konI9DGRSGFZh7fiSwbmqMMcHenWscp8+J+mOClsg6COcE4mlrKgFwQJq+R3CIIyVk/lIrXtUUfgsATTPLw1wvsgKNfQXLFDT6lYT5rwTrO7GFnDQ/A0WK21Hf+T8og0xgSD4nuecSs2UW7BPHSXp2TRlSwpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBvmJAyViy+Rvgzp+Ug36W5w1w6VSRV+yDdj4CdpqCQ=;
 b=v/5gctk3jg4eljcP2vrJY8CQFIFEH71R7yw4KAyQGF8qBh+mAcYcOBynUxwHShP+ZUeRByfgt3EWM5Y3rf1jk/fmpBiXXM90DWoU0JhQtB5BhKajajpugNsT1pQFazhkSD7xWgtbgtlLxPokDVTo4QKYal73dalvDRE8TWLS4dU=
Received: from CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::26)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:43 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::f) by CH0P220CA0019.outlook.office365.com
 (2603:10b6:610:ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:41 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 17/17] drm/amd/pm: Use common helper for smuv14.0.2 dpm
Date: Mon, 1 Dec 2025 15:33:30 +0530
Message-ID: <20251201101331.101584-18-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b852c1a-8cd3-4e40-87e1-08de30c27228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KjMKfp7hHjQVPJvPckbeE/sdF+gbWBXLxm/lxqbnFA65xWTPdDiVWVYQCvTq?=
 =?us-ascii?Q?D47XVKeIEeFz6zVj86ZOI3lC0SI7+Jp6KUuOl3w+mOl+AEiJcmO5G/fPVejf?=
 =?us-ascii?Q?uV2YfvIcAavLzE6P2/+jPdD4htV4alE67DnnBeQ8AN/ErSynO8+1E+Q7Pp8a?=
 =?us-ascii?Q?o7rkSCKcU+/Fvv+FjEywxVgJrbxSR5hGCF6YWSMor+v/7v4AHO/XyqkmM3er?=
 =?us-ascii?Q?QjJshtKghhLeIPDezvq6w3e1oWv7JcRbNUeMMqFW2zKqF+VLBpG9hdCcIwpF?=
 =?us-ascii?Q?aoXTySGhBoybx0+7eVlGJpUkn608f1RGvKS3nvCb3TyQMQhWXeLtcXFIflxH?=
 =?us-ascii?Q?e3Mz7mqsmlvyJOAe2WXt9sEOXzLiFd7wzTt9SlkLAKIF0cuRDP+CIhbogggr?=
 =?us-ascii?Q?lGR8T4qwc0tdDNnWKyb3EDoKRKJhm6Fku0sin4+wkTi+IBOCYRQ56BjV9TkL?=
 =?us-ascii?Q?bsO80DDpbV6A66TjwuPGBAu8qv88DF2PEqyK8L7xkF99GX0c6HzdcF7JTYk5?=
 =?us-ascii?Q?WOKQidYIt9uL7OBRc0eDr0ZwLqmtF9eQBxKLhCFVSTl05fp9tMXkDYT+fSNf?=
 =?us-ascii?Q?q8MJ0g9HBexijmKzY8YoAwUNiFmu1oUUID+QOf5+MDAsVe9ximiCu9d3wRKg?=
 =?us-ascii?Q?aqzlYAjvwahcHi/glMN3HZVQch5br7cZy2N/nzLMAok/Ao/96ajy+ZswGnyB?=
 =?us-ascii?Q?o/c/6STSIQp4tutW2KmxK8b3Cd29fQs3yW/5JkgOLaAiWNJMc/VEaCxSNquQ?=
 =?us-ascii?Q?u0LszvUoS94kwm4xuZ+mGJZJCGB036FlaAeNTGbAkvPY1Ox5pnkw3n1326pY?=
 =?us-ascii?Q?+FMgA8SAgbfmQmjZkpwfgHTCrtvngVa2EXXEM8i30MdFjC58OvO0H4lHGmEx?=
 =?us-ascii?Q?quyrlp8V6E6ixDQMyuaF43pBcyV/wQeDkt/W6brXUdajCcYatyXp3hLmZ0if?=
 =?us-ascii?Q?9cNHILchwTPZD9YGgSMZILgOngulqIz0Jsgur7f4D23ZxhYmJOyw9xWH3wfW?=
 =?us-ascii?Q?lan6dofF0El5A8/Mv53qGePQnO5ejB7OzP46Z9KplFqY639sBvLgzfQKdtud?=
 =?us-ascii?Q?hP0v6s+EX+XTPiO+M5/cNfmgnrQUdnVZmpVS53geKI/y785Ye1/H5BuqvGtJ?=
 =?us-ascii?Q?GSzK+pKIMDmaVj98OA4sHvLmvMpfJ5TaPYZ/EgmzHVHf2/N/VavE0hPPuI9H?=
 =?us-ascii?Q?njBUY1dvZKET//Cgm89foDcZNmLc+7VEJX7XBNZvRP5s1Y3a7aKMDhRqikoB?=
 =?us-ascii?Q?FfjXmfAq3zM+ClYhZ++OVtpspR4bMI/qtvcg6SQhyzCaXmxiz1hTbxdainCG?=
 =?us-ascii?Q?214sVUvlP2eSJCaou5iKigPryrAVKQcLvRjaXwRIXKP2GEnDMi+QWs8j46tm?=
 =?us-ascii?Q?4bhq3TdZaSRq5aRYQCEeFx8oakAr94BqpcSKdWMOwMMxNnf6TeoYQF/rDlMu?=
 =?us-ascii?Q?qFRUqTMCV3aT5Ebzij91rvWwxc87KmTQKS6ARvOVjUjp4hjDacMYJ5gAb+Nn?=
 =?us-ascii?Q?zvWLZweaAioLDJqxSw8agKMixhBD2pj8P4vcmAOlT6A0cB3SIxK9ebS/hqQ7?=
 =?us-ascii?Q?IoIBqYsKBpH4upkzSPg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:42.9701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b852c1a-8cd3-4e40-87e1-08de30c27228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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

Use helper function to print smuv14.0.2 dpm tables to sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 90 ++++---------------
 1 file changed, 15 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 596cdba0a8b4..af1bc7b4350b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1045,7 +1045,7 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 	struct smu_14_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
-	struct smu_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = *offset, start_offset = *offset;
@@ -1081,61 +1081,6 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 	case SMU_DCEFCLK:
 		single_dpm_table = &(dpm_context->dpm_tables.dcef_table);
 		break;
-	default:
-		break;
-	}
-
-	switch (clk_type) {
-	case SMU_SCLK:
-	case SMU_MCLK:
-	case SMU_SOCCLK:
-	case SMU_FCLK:
-	case SMU_VCLK:
-	case SMU_VCLK1:
-	case SMU_DCLK:
-	case SMU_DCLK1:
-	case SMU_DCEFCLK:
-		ret = smu_v14_0_2_get_current_clk_freq_by_table(smu, clk_type, &curr_freq);
-		if (ret) {
-			dev_err(smu->adev->dev, "Failed to get current clock freq!");
-			return ret;
-		}
-
-		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
-			/*
-			 * For fine grained dpms, there are only two dpm levels:
-			 *   - level 0 -> min clock freq
-			 *   - level 1 -> max clock freq
-			 * And the current clock frequency can be any value between them.
-			 * So, if the current clock frequency is not at level 0 or level 1,
-			 * we will fake it as three dpm levels:
-			 *   - level 0 -> min clock freq
-			 *   - level 1 -> current actual clock freq
-			 *   - level 2 -> max clock freq
-			 */
-			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
-			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
-				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
-						single_dpm_table->dpm_levels[0].value);
-				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-						curr_freq);
-				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
-						single_dpm_table->dpm_levels[1].value);
-			} else {
-				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
-						single_dpm_table->dpm_levels[0].value,
-						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
-				size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-						single_dpm_table->dpm_levels[1].value,
-						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
-			}
-		} else {
-			for (i = 0; i < single_dpm_table->count; i++)
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
-						i, single_dpm_table->dpm_levels[i].value,
-						single_dpm_table->dpm_levels[i].value == curr_freq ? "*" : "");
-		}
-		break;
 	case SMU_PCIE:
 		ret = smu_v14_0_2_get_smu_metrics_data(smu,
 						       METRICS_PCIE_RATE,
@@ -1150,25 +1095,8 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		for (i = 0; i < pcie_table->lclk_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
-					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
-					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
-					(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
-					(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
-					(pcie_table->pcie_gen[i] == 4) ? "32.0GT/s," : "",
-					(pcie_table->pcie_lane[i] == 1) ? "x1" :
-					(pcie_table->pcie_lane[i] == 2) ? "x2" :
-					(pcie_table->pcie_lane[i] == 3) ? "x4" :
-					(pcie_table->pcie_lane[i] == 4) ? "x8" :
-					(pcie_table->pcie_lane[i] == 5) ? "x12" :
-					(pcie_table->pcie_lane[i] == 6) ? "x16" :
-					(pcie_table->pcie_lane[i] == 7) ? "x32" : "",
-					pcie_table->lclk_freq[i],
-					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
-					(lane_width == DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
-					"*" : "");
-		break;
+		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
+						 lane_width, buf, offset);
 
 	case SMU_OD_SCLK:
 		if (!smu_v14_0_2_is_od_feature_supported(smu,
@@ -1364,6 +1292,18 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 		break;
 	}
 
+	if (single_dpm_table) {
+		ret = smu_v14_0_2_get_current_clk_freq_by_table(smu, clk_type,
+								&curr_freq);
+		if (ret) {
+			dev_err(smu->adev->dev,
+				"Failed to get current clock freq!");
+			return ret;
+		}
+		return smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						    curr_freq, buf, offset);
+	}
+
 	*offset += size - start_offset;
 
 	return 0;
-- 
2.49.0

