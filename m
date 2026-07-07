Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66677C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F216710EEBE;
	Tue,  7 Jul 2026 18:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RuT40uXF";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C3C10EEB3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHZb6fTVgyOu0m6xAS7fCX9DaNFongEtuJgjJuYlK47DTKwa1CTBTbm31gOfdQyegELuDDCchY3tSlPLoIOMWZLO9KEazPmKA6FNDZzLK1PXiLLzQJDx60TBfyYz7YrTZW6Xl4nMgQFNdoKB8DXFL0JcW3he4KfGy8JM9eJEzGo8iZ5xJm+8tE4JJRxz/qi40YpUByDgdXnmK5GNEg9XA1/NLM+sxQdlAL7eYHFmzkbqZRel9plQIQDScfw9sVl0RuTKIFF+ehWBsIvL/4xTSX5blSschNyLfif83T64fu1Xe+Tb6sJ4umtVSu3iF7Wl6tO4PMu2HR+j9dxT/UAn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACqn/70prU69Rv9mRK7DRQDz6Ji1PrZCEL5rnKqKntk=;
 b=gx2WIJUi2Mv0/wAUaEmJaAowC7pdD7+moNa6xpPHkG3Emz5khPgxWTgUdGt81+bRN7F7d97b33srjiSwXdGoVLlefFavs92CtqjTOktcskM4AIrH11ZGLtc1OEe9ycVGHT2s0zc0L13StPQmwfMjtb/UM/o1QQwklnzbSXJbGhlijXX25IToSCH/J8sVgX+O4j16/nc8nLipeDkTAY40vXjDPBCRweo1VTkJ8B9X8pgUfz0gLEp96s/ji4vuvaqsrIvEhgAjwe3zNVg6knInfUtLKBWTRqjTwjLqX2RlVXUj/Qh5yrxGlqFMyMtj2wbaRr2UcAHZFL/fDgK4R8ByzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACqn/70prU69Rv9mRK7DRQDz6Ji1PrZCEL5rnKqKntk=;
 b=RuT40uXFrxyl7yx5KBIpLawrtf22G6gufaMvsCoofMpmKOFna/M/BwBSaDA7ixYToSRm7kqSAu0Wpro0OlR/nSwgsG8PVBlcyP2MrPbop982QKKqZRA+F4qj93mVgjAGj2ZnnZLO+qHHpgWsyCsww7lsLhY21kaCUmwf+0JrGK4=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 18:00:34 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::39) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 18:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 18:00:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 13:00:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 13:00:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/gx12.1: Add ip dump support
Date: Tue, 7 Jul 2026 14:00:21 -0400
Message-ID: <20260707180021.2642432-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707180021.2642432-1-alexander.deucher@amd.com>
References: <20260707180021.2642432-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb80555-6357-4570-781f-08dedc51a466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Aq7MJmhFjZ8K3RQIoF3LNXANLaGevTaGviFuhM9uv4onAbAnXIy/djQEAgRlIcZB7/FcCsTLK0xEHddKDeXd4HJeymOI1CFXwuCZU9qvjgHQsmJHAn0WxUdIZm/3O/xDBqp0QciU9adc0Lu/h1shsabTywD3TssLASPL1jBeOnPx1l/+bgezOalJJv4RaKfu9gcFR8kKgBGMjg0L9UcAwYSIzkBB/U5Zpt2bXSEB+oLKtBebhN4LINkHR4ShvKEJl8tnCdk6gkVXApVsGv+PJkHNMxT1rAha+SEXz9sMqj6oa9woZBG1U3Gf3gtLfATNbbncwGUGaYjWNWJL1uRpSdOuRALMNYbFYVDT8ZdqYkXyz679fGYiafVcEJlR+3YjQ/anPRUJKlF7LVtPplLGyUhOKPhksdgdIMvGCd4ypiWoSvdiKU8skD2KpVEgoBObF/wxmBFb8rZPaEyqkKCtqbnnYZoItKSimCnK6u6rnTxkVGb+yJJEjy9A2q/DVtuqUaF2E6S1VFipLus9wEBRgHGbYh90YXFX9JNLjz3TCXP9WpQ9QiEgVJdM/pWygMF/yavDI9FV+zXs8+lQbiNXN2QN7GrmwAhcKKMZJd8bnw4jf/e0Zw7ZiHEZxkuxaySr8C6mgZqD01Rl4mUNqMl7zQFQnTbMP5hU9Zdp7LagJTaVDozDSjqQgnu9WwTYT1ItjvFRZj/xI1kUcWIIXhb1sQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3fPMHPEjq32KEi9wVp34rdBTnlvg3EYJdxXR89mFDl5eXmEUuV6oBwDswVwRLciIU7VZ7PXvWUFs4ghdMqPUu8N28gm+jq4SzW56ZAocgNXddt20ETbaz7/gRElt89Pb8d2z87M8Ili3SVGesLvj2PJQzAtaP2TvvSTJuU4KGtNL4OQOP6f1Ujc3F+30jUfQr7xKR4SsE8S/sL9uTwarQX/j4nLlkqeoKq2IYmoJTRRbZ1eH4+5tmaPUE/3umTdHRDOel1j4Z6a1QVmI3OE3ZktyIXteVxYebMwVePI8T7UlxSVWmazm6XhiBi2kgMIIi+uwtsjLwYzXiAhQ/QrtkQEOgcseWYK+6nm+eekcIbZpKxetnVOeAPtIHbFeFf/J8/NDpbYiELdDTPEA6sLwEza7F6NpDOvobMB3Hm9kfAxaqI9eUHvFIKpDIKKr6gOT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:00:34.1001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb80555-6357-4570-781f-08dedc51a466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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

Add support for dumping IP register state.

v2: fixes suggested by Mukul

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 277 +++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 408fd23c6bd43..1d09f1771dde3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
+
+static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
+	SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	/* SE status registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
+};
+
+static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] = {
+	/* compute registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+};
+
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -1148,6 +1269,155 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
+{
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+	uint32_t *ptr, inst, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		adev->gfx.ip_dump_core = NULL;
+	} else {
+		adev->gfx.ip_dump_core = ptr;
+	}
+
+	/* Allocate memory for compute queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
+		adev->gfx.mec.num_queue_per_pipe;
+
+	ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
+		adev->gfx.ip_dump_compute_queues = NULL;
+	} else {
+		adev->gfx.ip_dump_compute_queues = ptr;
+	}
+}
+
+static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
+			       struct drm_printer *p)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	uint32_t i, j, k;
+	uint32_t xcc_id, xcc_offset, inst_offset;
+	uint32_t num_xcc, reg, num_inst;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	drm_printf(p, "Number of Instances:%d\n", num_xcc);
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count;
+		drm_printf(p, "\nInstance id:%d\n", xcc_id);
+		for (i = 0; i < reg_count; i++)
+			drm_printf(p, "%-50s \t 0x%08x\n",
+				   gc_reg_list_12_1[i].reg_name,
+				   adev->gfx.ip_dump_core[xcc_offset + i]);
+	}
+
+	/* print compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_compute_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+	drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n",
+		   num_xcc,
+		   adev->gfx.mec.num_mec,
+		   adev->gfx.mec.num_pipe_per_mec,
+		   adev->gfx.mec.num_queue_per_pipe);
+
+	num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
+		adev->gfx.mec.num_queue_per_pipe;
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count * num_inst;
+		inst_offset = 0;
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+					drm_printf(p,
+						   "\nxcc:%d mec:%d, pipe:%d, queue:%d\n",
+						    xcc_id, i, j, k);
+					for (reg = 0; reg < reg_count; reg++) {
+						drm_printf(p,
+							   "%-50s \t 0x%08x\n",
+							   gc_cp_reg_list_12_1[reg].reg_name,
+							   adev->gfx.ip_dump_compute_queues
+							   [xcc_offset + inst_offset +
+							    reg]);
+					}
+					inst_offset += reg_count;
+				}
+			}
+		}
+	}
+}
+
+static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	uint32_t i, j, k;
+	uint32_t num_xcc, reg, num_inst;
+	uint32_t xcc_id, xcc_offset, inst_offset;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count;
+		for (i = 0; i < reg_count; i++)
+			adev->gfx.ip_dump_core[xcc_offset + i] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
+								   GET_INST(GC, xcc_id)));
+	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* dump compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_compute_queues)
+		return;
+
+	num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
+		adev->gfx.mec.num_queue_per_pipe;
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count * num_inst;
+		inst_offset = 0;
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+					/* ME0 is for GFX so start from 1 for CP */
+					soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
+							     GET_INST(GC, xcc_id));
+
+					for (reg = 0; reg < reg_count; reg++) {
+						adev->gfx.ip_dump_compute_queues
+							[xcc_offset +
+							 inst_offset + reg] =
+							RREG32(SOC15_REG_ENTRY_OFFSET_INST(
+								       gc_cp_reg_list_12_1[reg],
+								       GET_INST(GC, xcc_id)));
+					}
+					inst_offset += reg_count;
+				}
+			}
+		}
+	}
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	uint16_t major_ver, minor_ver;
@@ -1286,6 +1556,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	gfx_v12_1_alloc_ip_dump(adev);
+
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
 	return 0;
@@ -1325,6 +1597,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v12_1_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
 
+	kfree(adev->gfx.ip_dump_core);
+	kfree(adev->gfx.ip_dump_compute_queues);
+
 	return 0;
 }
 
@@ -3914,6 +4189,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
 	.set_clockgating_state = gfx_v12_1_set_clockgating_state,
 	.set_powergating_state = gfx_v12_1_set_powergating_state,
 	.get_clockgating_state = gfx_v12_1_get_clockgating_state,
+	.dump_ip_state = gfx_v12_1_ip_dump,
+	.print_ip_state = gfx_v12_1_ip_print,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
-- 
2.55.0

