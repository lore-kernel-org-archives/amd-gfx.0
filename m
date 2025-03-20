Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40EEC35FFF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D70910E670;
	Thu, 20 Mar 2025 16:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8DeBmVA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E85910E65C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1jo/L6EhRfE9JeBH7HAj3XhcV7Zp1rVXKuvp06d7gyNLHJAFWEQs79N9r2wFJSNxiQR4XISVqy6AJkrC8h/SsebkwOeLR135SzEW/GAkuFm0zKdC53DNENsl8jLaCG9sWdQq0WEHb7KLGUMo6n9bPoA28mAd1+dq8OfRucC1lEcSk+IYJ832LF4prd3hzZrRge4pK503wMgJH/o/vEnaEHDBHc97/b+P2M2V0U/xiW2v5S5XRER4jPYStrJ9pvs3MMEvxruFHJ1CYhBTxlMz1tHqqL3BR69nRzE+RFZwtMSkbrbwYQ/FjUyGrVe1Ctsf7dRQWGtwdm+Lw3izFogWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8i4E99hr9H7TkjulpZJHNBs9xxxROzgzaN9DlaF+qA=;
 b=eMb8rkuX6F8X0riH/V5kMsXK1tZwgCSyrBraEv8ZWZICVl3WyVEZkgmKWQBqvDBuHOAA1mycSjMEpwDqRjrPwyw/ezy3sUAIUACDE3X15BdrzVd29+0+7FPMXCC2eVX+eGZVwXdcFCksaunFQpUHlRyZyq8g3LeLKiRxZreNErGXAEa0Z+Sxv32P62Pb/MADt7HQpyuQR/jv3rH31KDCNOZPP7hHyt8MioLEjeF6laKX4GMAX/APrql79edJXJnp4s1Gjk51gBKOUAXHlohFpS+Lf9f+5LKK0by6VVSljcU8uXZ0oB3nrn5KpFEH7IhXl7qF4kWp8VtBnEt9hBFXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8i4E99hr9H7TkjulpZJHNBs9xxxROzgzaN9DlaF+qA=;
 b=X8DeBmVAr8MlvBqxhJP7rdpKxqlsY6P95J7aziMZII0rd1GD1dPKINeeSz9ryWXW83XvEit6sJ79cWDH3CvyScqPwx003bK1at6mj7nqNmKB4ekWKsjJCeHunTBxqFrJMS3vQzNsXXMplceFI+AI2FbiR7NyjmDovghtTW6In18=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 16:56:51 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::b2) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 16:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:56:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 11:56:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/gfx11: dump full CP packet header FIFOs
Date: Thu, 20 Mar 2025 12:56:33 -0400
Message-ID: <20250320165634.1245798-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320165634.1245798-1-alexander.deucher@amd.com>
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a7e496-6bdd-4d03-2494-08dd67d035ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ez3NgOlRvZbCIOI+UfCK6SGTAD7r3M1eeTHhm+FSRmQ5jZ2/vjiodeTYhO4?=
 =?us-ascii?Q?/pRplL6SaBB/o+QZ3stiiq/D1btsNT7Vi6fYqbqSLmEF0wg+/HpoDZJ8TuXn?=
 =?us-ascii?Q?827lNzVp7xxZEECBgGrTmTPil4ltDPWw3xU7XbItbs25b7dTqWNl38pKTCbh?=
 =?us-ascii?Q?NWokS8k7X1ydQUGpL0+mKTugQkYK3sWzGTQv+EQxPQPzT5hJJ55Ml2tw9xix?=
 =?us-ascii?Q?fVdBdUnX4OYcouaO2ih46mr9jjjTpKcCQGkSJAN06Wjv/whiKojKPehA3dJC?=
 =?us-ascii?Q?zqOHFrY5COR66bbSA92/HOqUx9ama6jrCCVH9MsbnYV/2U5LXFPukLynbD8u?=
 =?us-ascii?Q?Yweuu4FSescHO71q++8AH3Var3gJM99w0L6N0ouvWfP9Utrf90ampUR269ii?=
 =?us-ascii?Q?m3NH6jXB2R5txoxM6MQq2CvIrVatppaSymDYe0wFEKkdNFgyviTWquJzxM9w?=
 =?us-ascii?Q?HF4wG4t4R2MFj3mSJPo+4xwCcyq9TkrhiwjOZNw1StMJFCbA2TYYYqFl7Xkb?=
 =?us-ascii?Q?lxpjFre/PSzHx1bkbMp2TAilvs26tX/vfmoC1oJ+yaSKWz245WyWGMNFK4ov?=
 =?us-ascii?Q?SNx3KOudUE+vl4Zvmkcl3OHBgsES12kCjuTZZouuuO1vykP+6q2o+msOCVid?=
 =?us-ascii?Q?SyAgTr/iuPMYkFkR5JLxdPgWldTTv5F4dTq5Wxja3G3ynZxaLbm7Zpo2rFMt?=
 =?us-ascii?Q?WowHSaJ8ZiaYnAf58pXEUT1Ot5uEmTWhFzi9uNWolVApLsQmd8JhlyN3tRP0?=
 =?us-ascii?Q?AinuzADjcn4ozrYbDR0uxw1MVGxhTeI4y9aQ6PT53VIQuG9YWVQhhpvFz5op?=
 =?us-ascii?Q?ooAy3lZ4Dagzo2NsNlh1EPuq/Ppt34/OsSCV8L22AUjIkGjHO1zwtymwBQGA?=
 =?us-ascii?Q?cGcI98NvVQhANhWvhLN/ZdYasDli4s4a24ojQUwk+LSHOkz67psorzq8iFwK?=
 =?us-ascii?Q?WsubUVSJutaAvT0A0KU48QN0EM1jgprNA/m53K6Ve5aMnb+A3uCE7fOm0xmm?=
 =?us-ascii?Q?6tGXlaGypxDNbEfsQMJw3Dx1vPTrxByuszkZg63Omkh/IHU/PzkJV+4pxA63?=
 =?us-ascii?Q?AqWqYnXNZMlBdrdXs/ZLm1IvNbQxmgS0XxVdcur5aOciF3xhYEEX3DIqTVl2?=
 =?us-ascii?Q?p5GlO2RSF+s8meBc6txuB+oO3NnsP8sKMPbpM5qXskeIMaiAIAqG075DA0z4?=
 =?us-ascii?Q?YJ5nPFd1F0/F6DV/e26w/mHBQzNRRl2WwpDHZnJbZLXZQQ0+WP+UcOH283T7?=
 =?us-ascii?Q?HviU7c2mASxdVx7B4cJznUl/4Gzf2yta84sS38iVjRaaRIjYeshVYZ1iYB+Z?=
 =?us-ascii?Q?kNsmPtAfWyvwbFJnOY4mQO4dpkcTEJxTWMWbei6uLdw0QRO9p6o2nuJjg3tG?=
 =?us-ascii?Q?GroDim/mHYBfAXgJ9N/GVtrLUQjXhYEGYiL9ZbixNP7bvkrq7mVP0fKMIIuY?=
 =?us-ascii?Q?drIxBrAJcKO2SOW65kdja7xisvTUvHxlP/dbkEtGR/JY6NfrhX6rWA/Cv0qx?=
 =?us-ascii?Q?aAyU85jdgUtr0ZE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:56:51.2781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a7e496-6bdd-4d03-2494-08dd67d035ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

In dev core dump, dump the full header fifo for
each queue. Each FIFO has 8 entries.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 59 +++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 719c4aa90a0e0..182f0122998a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -179,9 +179,13 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
 	/* cp header registers */
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
 	/* SE status registers */
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
@@ -232,7 +236,16 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_11[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS)
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
 };
 
 static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_11[] = {
@@ -261,7 +274,24 @@ static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_11[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ)
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
 };
 
 static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
@@ -6738,9 +6768,14 @@ static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printe
 			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
 				drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
 				for (reg = 0; reg < reg_count; reg++) {
-					drm_printf(p, "%-50s \t 0x%08x\n",
-						   gc_cp_reg_list_11[reg].reg_name,
-						   adev->gfx.ip_dump_compute_queues[index + reg]);
+					if (i && gc_cp_reg_list_11[reg].reg_offset == regCP_MEC_ME1_HEADER_DUMP)
+						drm_printf(p, "%-50s \t 0x%08x\n",
+							   "regCP_MEC_ME2_HEADER_DUMP",
+							   adev->gfx.ip_dump_compute_queues[index + reg]);
+					else
+						drm_printf(p, "%-50s \t 0x%08x\n",
+							   gc_cp_reg_list_11[reg].reg_name,
+							   adev->gfx.ip_dump_compute_queues[index + reg]);
 				}
 				index += reg_count;
 			}
@@ -6800,9 +6835,13 @@ static void gfx_v11_ip_dump(struct amdgpu_ip_block *ip_block)
 				/* ME0 is for GFX so start from 1 for CP */
 				soc21_grbm_select(adev, adev->gfx.me.num_me + i, j, k, 0);
 				for (reg = 0; reg < reg_count; reg++) {
+					if (i && gc_cp_reg_list_11[reg].reg_offset == regCP_MEC_ME1_HEADER_DUMP)
 					adev->gfx.ip_dump_compute_queues[index + reg] =
-						RREG32(SOC15_REG_ENTRY_OFFSET(
-							gc_cp_reg_list_11[reg]));
+						RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_ME2_HEADER_DUMP));
+					else
+						adev->gfx.ip_dump_compute_queues[index + reg] =
+							RREG32(SOC15_REG_ENTRY_OFFSET(
+								       gc_cp_reg_list_11[reg]));
 				}
 				index += reg_count;
 			}
-- 
2.49.0

