Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891ADCD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 20:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFDB10EE7F;
	Thu, 18 Jun 2026 20:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K97/bL2S";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1518110EE7F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 20:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfbjhO+Z18TEsYMrqK0PItDpq72PFeY1Uxnp4p+5fYaFOUVTllSr7H9RT8KjWE1L9DmyuKH0H5BrDs+g0OUuvPGv/gKP/NVD2PPo3QdNHc1McC5K18FhGiRqo8oIFvEAhXpskA7N1KXzsomp/KWtl6s0qElFFJu+wMTqxzOH5wzeK69coFi1NIL3e5pON0SVLPVeleayDMe5otrC46oSmT831mgcWiRzDsYrTVdn2kHAX7EL7XvA3hL24fS7ZROMwDy461CY2h5BIDviJ+XnpClDjdZj40Z4AWmBRYmTqe9hN4+sB3JKRg7GcnET19b3UowoqpgDWgePsusd7zPAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irMBQ5T2gRWbEOdtpBb+dFL6CyhyP+WE8r/KfFkTzjE=;
 b=OOGtk55E3yfpMuEdDY3+aK5ed6NHv75/yo9X6wYvB0Q0t0+XzvoPJROVW/EL65ikGVWPEW8s7tnP9XrxjhvA4cU3OZSpcyQP578OhSNObd1BFt7ei6P4wrQxlcTO1SG09OoFliKQ7LQqHD+wEr1uRTWazX2bXOGwmA0rDbgyr8vs5+eY23vAEGLfncu34LVgkTfIVZpZwX7bEJxKMxfneNGud+huepGxXV5pD3RxekH5lr9GC4lowLPL6IB/V7O4dVTih9BwKXvnu32KV2c1Oo6bO5hnIjRMJ8KU7o/fEn8QdR9PMvU9xMrQyisdfyRC3wygm/K4QQVbtI/tDBpDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irMBQ5T2gRWbEOdtpBb+dFL6CyhyP+WE8r/KfFkTzjE=;
 b=K97/bL2S17iiq7+C9S1rSkxgQIFabioHy1IQdVMkfOFeRCe9BUV5wsOxvjfdp84at2LC4QjETb8eOO7wqPdZDz1iobLOqXYbQFXBsD7YYhcqmu4Mg7/JF806Qny90B5rZKNW7qr5Nrjq4I8G1tpksTGrr3TH1BKGM/xaTJqOBC4=
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 20:46:01 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::67) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 20:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 20:45:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 15:45:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 15:45:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 15:45:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gx12.1: Add ip dump support
Date: Thu, 18 Jun 2026 16:45:49 -0400
Message-ID: <20260618204550.753250-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a56b7f-707a-4ba6-1a67-08decd7a9987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: GCBtDs/HOrbf9/4qfXbVZMKBroPXCzFREST2UTQbDeQxvH7L1wNZk0KWQFtZZw80ohO0j8A9ATjzEyZaLvpOhdWQI5n3IumPsUJalOmUUlFy16zOxRXQLANkO6J7YcU3Hnd1tBUKuANOm3GqMU2XJxjHrpy5Jdv7Ds/8PeASPNHTAHFrIn28XYqsDIW2thaGy0O9uXszoOAQID3RhcNH3H/TqMrVSicaYAcW0lugLMrYd03enHubxZeGj1UX11briASuG2dMaHEF6txBnzYu5A4phQchQcqeA9M5g93hVCr5RmfVZfT8uPURCGUOhKQBKn1u9rHfdsf6XfDq/qhHvKdI2h3naYojWjyrtafzI5eUTNYQ+kuuDDatVsBwYOeQN9V+mcQ6pFtlyT3pJCMU73pSf1apV5LLd3N3cIY9sQOTbXyzs4VaWX4Mj29T/U2YfK2B/zstGtHUjh0i/ScHxu0RRLtSmxBxlGI6kgInlsWW6FwCSDnes9j7fqSP06LdTVOGjWos3DSGnRqtP16S+ajSy9IzTs67AmnmhE/2Dfp9GE4O+OI+rpbVNZnErIN4/Kfd/NPAzMmQFMmcOQiGUbBI+aJZg9h1wlDQyP5qcD7tbLcaURFPti33L9eMwt5K1Kywyej9kTE7CHXC/8VucM7bjG5TbKqenJVjzdsdrt4IqyJRSy97b2HlvDefWAQanzljKGyOFmi1sA/FCvgEeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yUarTmQ4z1ejQoenfoTJF41GJ25aEPLhxXPle11DANsKG7VSaeTmOM5bsV+66aOFsCC+yrVYoNSrWmnkqghBPsUh7TVF1dWVTxCUiXnrnuOnEMis1tKCXjyEQGYUn5BL+6gbsRSgrJdo+5z3ALPZQlAhG3xGdfuEPL2HmbWWn3fTfhpPzVLF9ctx+PUfC5L4hom1g3oV4v7Kqkltnw7RTciC+zVnA5O03hz/GePa+E1gJNFO3iUhs007O6PDAWY5QTzsBFgOmcjZqVEHdicSs6IImNyn0Skp7Oi/IZgR0gbYbo/KJTBM+PytgJYZPvkSYiOZ+DJNm/S/PdEGzcXaRkZPES2oOVnySrkJqsxvIQ1Xj1BrkYuVBFryM/QmniUtIBzGXmuw9XNjkVc6CstSIcf/n5hgJ9UOElQLacKxmr6/ER0i3We4c2m06Dq9C0UH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 20:45:57.7543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a56b7f-707a-4ba6-1a67-08decd7a9987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 5bdf2512f1540..ec4346a6c2af2 100644
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
@@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
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
@@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	gfx_v12_1_alloc_ip_dump(adev);
+
 	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
@@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v12_1_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
 
+	kfree(adev->gfx.ip_dump_core);
+	kfree(adev->gfx.ip_dump_compute_queues);
+
 	return 0;
 }
 
@@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
 	.set_clockgating_state = gfx_v12_1_set_clockgating_state,
 	.set_powergating_state = gfx_v12_1_set_powergating_state,
 	.get_clockgating_state = gfx_v12_1_get_clockgating_state,
+	.dump_ip_state = gfx_v12_1_ip_dump,
+	.print_ip_state = gfx_v12_1_ip_print,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
-- 
2.54.0

