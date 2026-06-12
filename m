Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BD3CD98D9
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 10:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90A810F42C;
	Fri, 12 Jun 2026 10:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rNrAVhoZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3A810F429
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 10:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ory7RVjaVHX1y7CbSL09vUxHmSbdiqd6w4k1RFt3l6xGv6jaOkxOwJia6sDQyrrdhJaTiUusRo7JvudLoU6/v5RAf4ZCoJF78Mku4FWe5ygc0ZBnm+ZOvzgwS6Spr6toFPg0KLOTN34iX0JR366CLKPOB2EbPZErEDqhrl7dx/TKMhBfZecidQJahLS3B4vq1qASS4IL37mOEmcQ5aMq0Xew+HnylsJ73+cXPRr/Op9CkFAlmTO89A6EqOOfiqJa+kkdRyTM/k9f/Sg0XSHFScOOlJSkd0+Wm3gr9ETHDJmvdjGySHAnywtTMVtpaep7gWo0/oUhsf0IiAvhATeUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gbsaaEI759mU3Gdo5ZEhJxe5beQ1ZNqB4tnRqG9AoM=;
 b=L+GC2MakAztVtHUy3YInsjmMZEVHveQqZ1/8OPZObh2msQ7uG0J32ZkJKkRZOmOHAxf82DYB6FSp/1ukfOZTilqDoAyrw1EhccXDlJJQfMibLgtvF+XSCWDmqytY4TmvqYMJtQLJ2OQbzjyPTRjpl0A6xLw3rHPM0l1nGqhAtyU6Te0yFg32dzTCtxE8uV4jjrCIxeNH0rcFbwSrxoKUyjaaZ22nRlNAJx3OmcKnzF7+hue3y+kbbYv855zo+7UiyfWxwjJ1nK3xaQtNhgOS64A1Jq/UlQarJh341fy/NO68akRrtxbBY/E15/XrP912Jx2i61aZ+8/ox7Sklvprfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gbsaaEI759mU3Gdo5ZEhJxe5beQ1ZNqB4tnRqG9AoM=;
 b=rNrAVhoZ+kMNsTBs3GF9bR2JkwEHWlaxgd92Wlg4bCA3A85D8DvDWhxTqeODIa8/rKYM78v92ztmcE1IrajCFvb4/EujcwOp3Thft3e0Q2EmMCFEAS90xznuRNFq48OQv2T+KcrvA3XSEbeEvphLzRAkYZzACUr5sauT939n5cg=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 10:44:20 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::a2) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 10:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 10:44:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:44:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:44:19 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 05:44:16 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v4 1/4] drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting via
 VCLK level index
Date: Fri, 12 Jun 2026 16:14:05 +0530
Message-ID: <20260612104408.9596-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612104408.9596-1-Priya.Hosur@amd.com>
References: <20260612104408.9596-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: de4b2d46-4b7e-42bb-61ec-08dec86f8efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: qWneXwBjtGd5TYpaohfvXY39g0YT4m6PGA9Pc37G0b1+BRx6T+TACgMmyJBNPeZyRA0qXhsJLeBkRxk0oNxDYAA26iA5qDBZZOd+UtsIQ8zjBj7quX7agoamKq5GkY4/SIvRS1gbCihE7FW4k4glHjPr9S/n+4Ml4shLO7iQzyfFL17H/aefMJzMwBGKDK9gUBdyJHU8/9Jo1eODhd/haflF5K05iwSIvCEM8r9L5h+7xUdu/dmcT8I1t6rKINP761lGAfHpGpc6bFtfEsbQVNa/9ai8DkiAxliS6C3s/ZFC9kWJXQrn2utspLZri8N2HyC247Zq1uRKJCwhXocQ1Dfi2RqDsXUWvO+ZYEsU3lZCsqYNmiVCq4i2UskKIqCHpS6WzVRNW4rvgff9ikJfp3bqavyiQ4lsT7mL7sYAabI2X/EqGVvjItl85lyvmLVA1TKln7btJBmEjlisTspYJ3nZZxBwAl9noiicDWCM+ZDqFP70VoRIJc3sWBQpIfVyukVZFA/SWmNSTH0I+T2tYIJZKc1hxzZlFvc6aCMzRDsXhyXEfZfDp339iQ8IdobpRHmfvCx8brnMZbNyFXtolViLow1m5sFMt29sY6ECMNzZuw/rDQQYwvFMqhirAMYkzADzaQ59FLIFKktJgp5vmM9tL6unrYUmpJSCmhrtg0LWt5ZIi54SXOzNXfl63QgeEHKtBh+/q0iZwSB7z9Up0x5+NITqaC5kef91W+9bc3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YnCtCAZ1HjABxjzXcrk2VMZFmzwQdQeOOevRHyoykcjtmZ784sGyuziDwzUMTNkoLfF4dme+XGTNQ2X+9xOXzbwdZll4Tx/6ynLxcryOxD3DW+/qok60k+ImtXfPz1hltQe656kI8GIyuN5hQaHlabrAxeusgNrAQaIE223wYvFovAA8dxzu1eiBi+0vI34jlqyQZ2bqbstHfNlY+jwKnmck5f11TxJSm0W+ePwMWpIHKX2UJLzc3NwIG6mFbwyxdAIMbGo3BiMNBPWe3ZkCx/wYfsmBJhY7stR9x5bfgK7c0jH9BBe4isSWz4KqdtSvNmpD9HWmSjUgN2zxNTOaz8lTJtzKTtEQZRmKuy2GxXcxSxY4eNB///STngKiMGj/PDt6sGtu1UiBVwAGwZ1VWJPb9UiWWCsedMeRZe1ykGs+LSJlmZaKrM0wIerkmCXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:44:19.8752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4b2d46-4b7e-42bb-61ec-08dec86f8efe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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

SmuMetrics_t has no DclkFrequency field but DCLK and VCLK have
separate DPM clock tables with different frequencies at each level.

For METRICS_AVERAGE_DCLK, find the DPM level whose VCLK frequency
matches the reported VclkFrequency and return the DCLK frequency at
that same level index, since both clocks share the same level count
(VcnClkLevelsEnabled / Vcn0ClkLevelsEnabled).

The original code returned 0 for METRICS_AVERAGE_DCLK, which broke
the active-level marker in pp_dpm_dclk entirely.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 2fe006de927a..c4c45c8dff69 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -284,7 +284,34 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->VclkFrequency;
 		break;
 	case METRICS_AVERAGE_DCLK:
+		/*
+		 * SmuMetrics_t has no DclkFrequency field.  DCLK and VCLK
+		 * share the same DPM level count, so find the DPM level
+		 * whose VCLK matches the reported VclkFrequency and return
+		 * the DCLK frequency at that level.
+		 */
 		*value = 0;
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+			DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
+			uint8_t i, levels = clk_table->Vcn0ClkLevelsEnabled;
+
+			for (i = 0; i < levels; i++) {
+				if (clk_table->VClocks0[i] == metrics->VclkFrequency) {
+					*value = clk_table->DClocks0[i];
+					break;
+				}
+			}
+		} else {
+			DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+			uint8_t i, levels = clk_table->VcnClkLevelsEnabled;
+
+			for (i = 0; i < levels; i++) {
+				if (clk_table->VClocks[i] == metrics->VclkFrequency) {
+					*value = clk_table->DClocks[i];
+					break;
+				}
+			}
+		}
 		break;
 	case METRICS_AVERAGE_UCLK:
 		*value = metrics->MemclkFrequency;
-- 
2.43.0

