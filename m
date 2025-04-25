Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDDFC369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 16:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2260910E100;
	Fri, 25 Apr 2025 16:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PkK+YAN/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34DC10E100
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 16:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9b+B4Rdtnw5qEap64/JrdE0kqsb10vxyRufDvmozBR/OkKaf9fYhKSVbhjVl1qHSXGkMcm65AUxkoE5u74qBzVK3HcWg2S4TJmPl+/8oBmB6XwvpttFvuq/8c2K6lfvkuY4RKNO8mpJQKmC3EMBtvabOKOg19AuDXMSCtzYNex2cv7sUKO12psbRoNAQSVljKdcpUYspNY8rb+XWDFg1nSRRngnO42Q9Scx8sjkxD+ad5qb1zWdjZS9EvNSBWz+Oaij4pS2BkBuggVV5k+u3i1yO1NLGpIjKg2Zj+9p/pU9qGgLrAWWjkYbLeBu/l4KMvMpliB4rh7VD2yJM26a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwS1STRWDKsdMPVjdswN2pacG1LaOpvF5rwKL5k1EEc=;
 b=k2i7LQAIXszPUv0QDxaBZkyygNfgS2FvEgqGvLE08zRdG+2lNJE94IL4LeYtJHmdoHP+IMqulMXx4+tYxpjEsYpGAhQlBSBx1tWzi0v9hHe2Bq2iKyR4c3YN8DwUFP/kQS6pEqaJc8uuD4W8hn6MtoCVWriwuS7buQ338Vu3xrwaTWShJMLcHQsMl1OUskb+Vwvt/NxpWZxMAlG0AGIIOyJ+iQs2QEfPZWyHSD/3AmiLTIw3Eer/vt976QTY3/MGhMKkGfJk/M4/vTr3ub9vgRF5GQka97/SgJqTg0o9fcawBf0lSIgVB6odjQsqrzWuFZAl3NAcHfJrhtWUlycxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwS1STRWDKsdMPVjdswN2pacG1LaOpvF5rwKL5k1EEc=;
 b=PkK+YAN/oP6Onl9Mv0BmG+sXik8/pgHpMCZJSAb8uW9onii14Oi/a0klWmOMM2La7BsmKsj7BbRx88n3aN55VMJmR2GNm5SpzJWsRCOD5TfUXEqaUNnF40ddXD2vRPDZvtxY658wQctibpyb5rhgFVuunZpwnBwTncpa3TZe87w=
Received: from MN0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::6)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 16:41:55 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::73) by MN0P220CA0014.outlook.office365.com
 (2603:10b6:208:52e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 16:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 16:41:54 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 11:41:53 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1
Date: Fri, 25 Apr 2025 12:41:37 -0400
Message-ID: <20250425164137.1090949-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4e8f82-a38a-403b-b7ad-08dd84181620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jDrQjQ0ZHgTGKC5dwjXd3yG4Lvl18Kv7f3znlrS5ilrBypVHAKJvSf65HQNh?=
 =?us-ascii?Q?Nxp9/aAJ5Kc1hvNNzvAyloi44jkEhhZATcFNPIFJPPudLZ4nB+HeFl25wrE8?=
 =?us-ascii?Q?Nscv/poa/9aAgcAdxkD85wJMmocpdM8EulPv74+wyVrkyhVapjsLSvhoRiM/?=
 =?us-ascii?Q?UWAWqNCK1LpGdo3ZXPg1sp/SK0C9hBWKENR6oKe8QhJWcWwIocha33kvD15q?=
 =?us-ascii?Q?U17d58X+nxW1IRzBbC/ZY4MIMZ31ci4kB1A0IbVIsdR+ILhYS1Teg3vAxM+U?=
 =?us-ascii?Q?O8v35ScHV0+N8X0x9YhKyy88KfjM5onJGdiuuMFV9lkPYSuCYS1b4Npp2Cz3?=
 =?us-ascii?Q?ZTwa+ZoFUwwgXK4Nf4AGoH2Yhb77m6vNneNOy+haLiCTRHCWuAQ5kcFV5Eep?=
 =?us-ascii?Q?c12SdmcTyvQwguY+fOoxPkdh/rIDDdLFtKzMyXDROFihPbDgm3kwlBQ+/SPS?=
 =?us-ascii?Q?/JUeUf/22Q3TxZq6ThC6HyOIcHRViIsopjoHv7EoU1d+JZfD5RsJWxGPMnql?=
 =?us-ascii?Q?gfY7m7UBH0HIpMdGYkyGK5QyobgqMqlmO4YZHixk37E+AsXjjJ/PBTMvu1RS?=
 =?us-ascii?Q?kII3y0EUqmmUCQAXFE64LitopFDk9jrVr00r6NlAjYXvVkAjRYfiJRdZqxPr?=
 =?us-ascii?Q?b2DCKijtLrfDAPtD2SS7xGMiAmU+w6IHWn5Yd9NZmrQJP0FtMHTCwAIuGpXk?=
 =?us-ascii?Q?FtjssN5RpCIe0K0FEeiXn7bi79TVwuT6hz4oOpDMXTv/uBUrCRB7ExSjTnu/?=
 =?us-ascii?Q?MikITv57/QncF69xxwCluPfZ9AXZtc9c7nkOYEKFU2LVODWdbppNP1WYwy+x?=
 =?us-ascii?Q?+YN47y/kP4ufb8O/TWg9l5N20nSRAqbIkamj4ch9ObCLc/PhV+RWfv7eYIrZ?=
 =?us-ascii?Q?aS8BHMu3xhetpxhSu0pg+2uA5OuJIRrvqXWjWIbp6cgKN4L2P4DMhoftQJjI?=
 =?us-ascii?Q?9bHeqZEtGSt0yWUM5hDDgSahH6sunGwEKTQW2PuIx+gIo6/i7FPfijfA0kTq?=
 =?us-ascii?Q?wqQWqB/DxHyiB/TxxEWZRtF37IZgkNixR4ciS6XoiD+AOOy301rd8tDhCjnH?=
 =?us-ascii?Q?X/2ZS8uSPr3+E0MxvjWLj4H6+tCim68oy3lgFodfyH4sacgdOwcVON4PcQH1?=
 =?us-ascii?Q?fPnr9NnS2KlQxGFg/ZWlLr7anRUwUMNt0ipvM3vKXypqvLm4PLR8aLOC+Afc?=
 =?us-ascii?Q?Ulp91j0MIQC4y7GMeqo7YIUQfinBX7rrlzx7q29kyyRMSqVIEJRXZOg690Ci?=
 =?us-ascii?Q?W8V8QHQs1ZgEzLxZoCIrvVgUEKX6XvjzkFdVJ1GXENqam5yY/owMRA/7wS5j?=
 =?us-ascii?Q?hiQVu+V/KKXxiEoIjh1jw6EA4MQbwzaipv6vYeJDH+tgA5PWE6/qyJBFWo4j?=
 =?us-ascii?Q?ys6QztZLeLFMYk9bDNzG4hYHjpCv418lk2vKR/p14uQ8WL//kPiRkQ+p4PZH?=
 =?us-ascii?Q?QKp1QBM+EHZoq8Epp2/RjkXlx5yAduy1MS+pxzjYNaSHLuJnoWAB866FZN6z?=
 =?us-ascii?Q?Mnp+/WCL+661ICS7y9PKs4kHjjVD5juhn3Kz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:41:54.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4e8f82-a38a-403b-b7ad-08dd84181620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

For vcn5.0.1 only, enable DPG PAUSE to avoid DPG resets.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 4b2e6a033831..60ee6e02e6ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -502,6 +502,52 @@ static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 }
 
+/**
+ * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode
+ *
+ * @vinst: VCN instance
+ * @new_state: pause state
+ *
+ * Pause dpg mode for VCN block
+ */
+static int vcn_v5_0_1_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	uint32_t reg_data = 0;
+	int vcn_inst;
+
+	vcn_inst = GET_INST(VCN, vinst->inst);
+
+	/* pause/unpause if state is changed */
+	if (vinst->pause_state.fw_based != new_state->fw_based) {
+		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d %s\n",
+			vinst->pause_state.fw_based, new_state->fw_based,
+			new_state->fw_based ? "VCN_DPG_STATE__PAUSE" : "VCN_DPG_STATE__UNPAUSE");
+		reg_data = RREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			/* pause DPG */
+			reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+
+			/* wait for ACK */
+			SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+		} else {
+			/* unpause DPG, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+		}
+		vinst->pause_state.fw_based = new_state->fw_based;
+	}
+
+	return 0;
+}
+
+
 /**
  * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
  *
@@ -518,6 +564,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared =
 		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
 	int vcn_inst;
 	uint32_t tmp;
 
@@ -582,6 +629,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	if (indirect)
 		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
 
+	/* Pause dpg */
+	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
 	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
@@ -775,9 +825,13 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	int inst_idx = vinst->inst;
 	uint32_t tmp;
 	int vcn_inst;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 
 	vcn_inst = GET_INST(VCN, inst_idx);
 
+	/* Unpause dpg */
+	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-- 
2.49.0

