Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E146CD3E78F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810F210E6E1;
	Thu, 11 Dec 2025 05:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCmQFOmV";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7FCD10E6E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqJlvyZkas8auikZX8iUMh60tXq6MnEo5zdm2IjIcw08QVbW3a8I7mYSTe15lo5yQzuiVi9i9bpY2JDx9Rvvgj01AtndKj77jS7CCV1Obl9Ox45qX0q7ZlyNa+VXQJP+O2P4yAWCQeyERjgmDdKXD/OkyH+f7Ds8HCqQW5i9l+QUegAjf2aMVPHPyPaonofVnPT+nUKsDfanENyPhonthjNdrKeVWlBPODFK+H2dXQKELaURoiuAh4ZoloYIxV9T0/H+19vJ75tWANp9v0IB6Xz4umftAsjPFbhBp5QSyQTroC9MXKjURMu5D5DM89hkeCvA54NO+qLgDnALUfNMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/lKuZDaq32lAq4BUOTKHHOmYpgy8DVHFkQQT6wv+yA=;
 b=tYpoMm+yXL00GpR1LD47UAcUYTcGnW3Hv2x2BNhJ2RkUWq/vH/rEy+tTy6xmZzzRTAZL6jDYaHxG7OLWhLcmJpI0MtQT2NGUn8Qaq/zedoknzHlk2P9Z52ZytHYyIhRpkV9vMui0w7LFFahxyu3PhcFnY4bmfgeXpA7kjOW4wX0BbtbhE8jiLS1S/ZLl6ijsFlGf52b9NoZuwujATtKrxLCTxsF9gIX4ogZCXPvFnl1jZTmPb0BnxoPTjDVNJ8c0LaQ23ssqfF/mLzf2D7tmlGs8sYcP6Rh11X6Z83EDzOEoBuwEYKjBRzVkusb3+95uT5PmvtnzrRDhJ8lAKNHWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/lKuZDaq32lAq4BUOTKHHOmYpgy8DVHFkQQT6wv+yA=;
 b=wCmQFOmVoZQPy0+uPzIyjBDiNxdL8jm9lQwTi+b+gp1U8YYQk2PxHPF+xWr9NMjeexByiYflJ6A7ea6AIghD9pk+w2k1zdAAnTrOR/c5BzdnWQuVt7ljitKO66enrpeqoJVnOTX/e8l0pFLRRfnB810uDzvwTE60DvHkrwniBeA=
Received: from BN9PR03CA0620.namprd03.prod.outlook.com (2603:10b6:408:106::25)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 05:17:08 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::77) by BN9PR03CA0620.outlook.office365.com
 (2603:10b6:408:106::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Thu,
 11 Dec 2025 05:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 05:17:08 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 23:17:06 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: add PP_PCIE_DPM_MASK support for navi10
Date: Thu, 11 Dec 2025 13:16:57 +0800
Message-ID: <20251211051657.652580-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ed8047-269e-4a03-3268-08de38748805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qWQyZykvX50XkcYV+C2WWplQmTQHUjgOsLh9WsIXDNRrgmcVhx6rfCxPkzFQ?=
 =?us-ascii?Q?xDT5RPqtupyb8pwkA4yiQlDmbhjzeugZyuOo1dACJ05SaITcuLElWn8HPlrB?=
 =?us-ascii?Q?oP2r//DDdUn+7t0gTuD48pMS6ZSnwtr9y5abA2uYd5HAVoXZWkQSyTMh3Fgy?=
 =?us-ascii?Q?tXGVpL0Cn77hF7WejFm6VPLhApU5yh+KFa2QTtlT+uaHiTtKONKUFVVOqs6a?=
 =?us-ascii?Q?3AqFKyJ2My8zcTFvCZs9x1c1lJn0iTDfI+uI5yNyLjKW9wM6xxN/kw8MJVdR?=
 =?us-ascii?Q?P1Gt6wCapnznZk6hdzTP4AveW6SaIEhaVwNA7ifxc0lnsCteBmRUp15MtFca?=
 =?us-ascii?Q?k0PvQZ3s6R5I51xfo/C3gabZR8w/8cwRlGwqoLHKMAfOfV0BCFNdGRpoxTKz?=
 =?us-ascii?Q?i4xAsxxNDuyBvgdvAPTzf1tCvin0xmfZvO1xEaeAEPP3/dtNWTwe8jIhN0be?=
 =?us-ascii?Q?t7uWcHYqVfz5koyElwsssRBKJaiakhamoJjo33U4lFjgMKJCy8t4OUmLCeDa?=
 =?us-ascii?Q?Ttamg/ktc9zvEoOOyeLmA6Nhp+HIDH7MTjozlYOVvcEsTgEEkllxOmClppou?=
 =?us-ascii?Q?gXu0fk/bozsS8EIadFSurifxblzzkVv8DOy4PvxgsRqc4WbSL48uByFT23Pn?=
 =?us-ascii?Q?cvyPqSnqCfTra+KTi8sV06ItDB8HwwfFOp3M7i5aQYJkpCBRV35lk8sdtVYQ?=
 =?us-ascii?Q?r4HbMwtvgAXgA3h7WWprnuXrxVQscPAdkUWshT0pAF0dxty1OrCCkoBAEU60?=
 =?us-ascii?Q?VMwxWXR+hPhVyOA4fACUp/an3QdrQ8ilZvliq4DHInC9/8DluT8h7qSQxJ64?=
 =?us-ascii?Q?EEgNhD8zjaaIzVHdPRo9ojNEvLcLJvVoyW0vS2D+bnfIkb/n1g5osA74Cfq+?=
 =?us-ascii?Q?ak4XBJjvIXX2zhw9JaNjIw1L7nfQ3lHYe1LtJMVymefctxOtj+iE9ZTE9jCe?=
 =?us-ascii?Q?0M9t13MA50TkxpfxkJqAExURC1hnlL3v/nQ2QB0G3hXT6EtqEaTOz0PSmoLL?=
 =?us-ascii?Q?bJ9NFRz4SrvoUD92UeeXY3hJsfoTRtn6YpTD/k6YnVCAYU8zAuW4ClpXeArI?=
 =?us-ascii?Q?/WwfP9xs3kZvJma3GvpEZhYrFZwN9xa5yb4XqJqP4zUvXDZ6dltllZo76R4T?=
 =?us-ascii?Q?yacPzyLLFzhsKNiCsWbny/D2SfahqhfVYSLVkFLp2OMSdsH+gjPWHbyEOT4W?=
 =?us-ascii?Q?5JeDXODC/cx6wEEhjrJY4lS4xxwB+glvppEkJsHGGRJOqN1B010mCwBRlT5o?=
 =?us-ascii?Q?Q+Y+3bDOm8OBeRBEkmBvHYq3+rA6fMqxwMC0P2TLUrUz/+/iWCnK3IkpTtqx?=
 =?us-ascii?Q?dyCIja9SwcCpA1fU0JqaTfVOAQJw8fxxjR29WEcWs/ql7gHrE/uCRT0EDY+Y?=
 =?us-ascii?Q?xTeMSztC5frLz4G1x4ZDj6xaMOGbFNMV6MYZAkVHQqx6pN3pNO63wgDS+cT1?=
 =?us-ascii?Q?JB1807pXkC/f1VyyHld/x5a2Uq0WDhXNRkNrhG/j+mrNMiImeneI5NB+Wqkt?=
 =?us-ascii?Q?nDXW7xB2h/PjGQF9w9RrlhIewk/haVErVsPBg3Uv3vJzL6kPA36r3wHTMCca?=
 =?us-ascii?Q?+TuDmC8MGntXIvjRzBM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:17:08.2177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ed8047-269e-4a03-3268-08de38748805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
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

add PP_PCIE_DPM_MASK support for navi10.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 66 +++++++++++++------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0c26fe6fb949..fab19174343f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2192,39 +2192,63 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 					 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_pcie_table *pcie_table =
+				&dpm_context->dpm_tables.pcie_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t smu_pcie_arg;
-	int ret = 0;
-	int i;
+	int i, lclk_levels = NUM_LINK_LEVELS, ret = 0;
 
 	/* lclk dpm table setup */
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
-		dpm_context->dpm_tables.pcie_table.lclk_freq[i] =
-			pptable->LclkFreq[i];
+	       pcie_table->pcie_gen[i] = pptable->PcieGenSpeed[i];
+	       pcie_table->pcie_lane[i] = pptable->PcieLaneCount[i];
+	       pcie_table->lclk_freq[i] = pptable->LclkFreq[i];
 	}
-	dpm_context->dpm_tables.pcie_table.lclk_levels = NUM_LINK_LEVELS;
+	pcie_table->lclk_levels = NUM_LINK_LEVELS;
 
-	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
-			pptable->PcieLaneCount[i] > pcie_width_cap) {
-			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
-									pptable->PcieGenSpeed[i] > pcie_gen_cap ?
-									pcie_gen_cap : pptable->PcieGenSpeed[i];
-			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
-									pptable->PcieLaneCount[i] > pcie_width_cap ?
-									pcie_width_cap : pptable->PcieLaneCount[i];
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK))  {
+		if (pcie_table->pcie_gen[lclk_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[lclk_levels - 1];
+
+		if (pcie_table->pcie_lane[lclk_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[lclk_levels - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < lclk_levels; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
 			smu_pcie_arg = i << 16;
-			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
-			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
+			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+			smu_pcie_arg |= pcie_table->pcie_lane[i];
+
 			ret = smu_cmn_send_smc_msg_with_param(smu,
-							SMU_MSG_OverridePcieParameters,
-							smu_pcie_arg,
-							NULL);
+						      SMU_MSG_OverridePcieParameters,
+						      smu_pcie_arg,
+						      NULL);
 			if (ret)
 				break;
 		}
+	} else {
+		for (i = 0; i < lclk_levels; i++) {
+			if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
+			    pptable->PcieLaneCount[i] > pcie_width_cap) {
+				pcie_table->pcie_gen[i] =
+					pptable->PcieGenSpeed[i] > pcie_gen_cap ?
+					pcie_gen_cap : pptable->PcieGenSpeed[i];
+				pcie_table->pcie_lane[i] =
+					pptable->PcieLaneCount[i] > pcie_width_cap ?
+					pcie_width_cap : pptable->PcieLaneCount[i];
+				smu_pcie_arg = i << 16;
+				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+				smu_pcie_arg |= pcie_table->pcie_lane[i];
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_OverridePcieParameters,
+								      smu_pcie_arg,
+								      NULL);
+				if (ret)
+					break;
+			}
+		}
 	}
 
 	return ret;
-- 
2.34.1

