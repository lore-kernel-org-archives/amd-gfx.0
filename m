Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A6BC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DC110E913;
	Thu, 15 May 2025 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GjYBWL58";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C8C10E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra3E6rxKEOmdqJg7VjcBZmjfkLA+Thm9tkT8meOCIHgucMbAUFaEv/pPzz3weDhjnfiBKQOv+R+i3WDVssJkWZ3NeGTcvZTWCQw3CsH0g4jXWTCymP6ePs5YE6plIMKfijaVXCvAOJJdJViY8YgV5VTEyXtBuJ7moRFA9mX3tcvV017gc66SyZ1w8gtw4niC1s8E8Akn4Imr5pyRBulGepcNUpTI5gD2qdK/7HGcY7sT7APr3jkAPtUBxcOqbRWrRvUk+3KzZh8j0LSUVGKwoMkf0Vjg6YOIj3G04RNT3iu+tht9ziLdTOw+dadwwKys2mFm1yyCfaUmkSOceXQxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWMnF+qNAbCi8S4t3bVloaIWit5JEKRmwppWN5uiaPw=;
 b=daf5rQkcSydIyfe4yR/AXoEWvI8OXw3tS8PaHJe57ciQuI5Gms33BTEfhIYb33RPd+HSxMkJfwovaziGStptmNaYrQfcuSuy8xigkOYJTvwYeUHU+sLsjkLYVe+h9z3x6R5YH3NLt5DyTHUp9uYSsDWKW6ocU+kiS/jVAazASlNlzwJV6X3/FxT1eh8+Pyx0gUlyo1OQPlyPGM8BKTXP1PbPRIrwsDj6KfyR8tPtbJchdsyP81fdDDvS5sM2LmESCKQlkwmU6tpJMjq3MrEQK2drELLdDKSGi0MCtG4KzXAVY8YyNgp40thELV9dv636ZGb3ZEKwBvsssXD30au9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWMnF+qNAbCi8S4t3bVloaIWit5JEKRmwppWN5uiaPw=;
 b=GjYBWL58kLUJ96Bx9NYrkgWuCrOUIqST5eSpeKGmvUCCrn3i780B1SHnBFnCeWZsYciq2GeIuyj5pXiUf4r9rPpxWi7FMxKwi0NHcWcRIa8Fjb3P66GKJm+Rjpouz7YdcT4sWiLD0fu+AV+WGqE/qDsH50SOnABxfxYkTt6Bk4s=
Received: from MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 16:41:19 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::ef) by MN2PR07CA0001.outlook.office365.com
 (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Thu,
 15 May 2025 16:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:19 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:18 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 5/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:40:58 -0400
Message-ID: <20250515164102.808954-5-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2284dcd0-ab54-4631-a444-08dd93cf519b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZhWCR2dFgQ59l03Ldyuzm5E3tRFpNXKg0EsDMO7NJuc5ZVmPCkzZwyxOq6G0?=
 =?us-ascii?Q?Y6QtAftKBM+S4YC0wSpNPJayerFpwi6w9IA3wMjvPizhPnlgGpIcmoi95btJ?=
 =?us-ascii?Q?5sfTS752xLAlAkmC8Eqa7yjuMgqEsx0ObdVI2F4291rY9iAHuflsncSBQQi8?=
 =?us-ascii?Q?5Dqif0MjI5oTTrWfrRG11FubUok+y+RhEckAvNJJqlJWYx3aIWFfXhRl1Vlh?=
 =?us-ascii?Q?bLVWHaEGgazL3LNdVp+QHETvdgoDj1M7QqpxYUzXHW+e3+Uu+CuVDQmy308x?=
 =?us-ascii?Q?dpA6EOCDiX8FDK1hDOyPU0mI4Z1yxi4YN/HpoMFD9Wjbob63pnx+9ahV5HQL?=
 =?us-ascii?Q?rPElqgO6EVklAnaKKLCYLwW4Je3iXRk2RIt1HJOI4esld74p3Ez+5/4TfALH?=
 =?us-ascii?Q?h8DF24tO81UvdH84AseJqfRhWCipzQAGXFDIkxyFMMOZknLSlm63Tln4d1Fp?=
 =?us-ascii?Q?RqQBbHChlVN/ya3D/7EYAGrBmkQ8dZOEjMhvKv108vf1p+5WO+kN5+08DUaE?=
 =?us-ascii?Q?lm0927kJ/8oF2qBOmw9pqZYrp9hAyuLSAzEMNvfP3nq0/qtX8ItpHn3N9V5V?=
 =?us-ascii?Q?1hLae+ez6OAI3UQn0KADYWK+W4+vG3oqoBbEKrdDbkZQAzrV4ehbZ5NFyLvZ?=
 =?us-ascii?Q?c7voqoOXIMs5OPXaSfypAsftoIjvN9iHqdA+EBZjr9JTvjpAyIkzjV129JXM?=
 =?us-ascii?Q?8bMk4gq5Ed6JN2EVdkjfIThqiEKz8dE3StCvD5cI9dZCmOJrsMfpyAsqLjL2?=
 =?us-ascii?Q?IvOhZFGSl5b9NElb+l1TMtdrbSjbHOm+bm474iH4qEm+80QsCGauEjro5/g4?=
 =?us-ascii?Q?5zt8TOLeX+AxKdJjR+jXRj5seALT0pmKVRTHxUkVf/3CfqwJjzigt9N2UgVz?=
 =?us-ascii?Q?vouJS8p14y3ooBXPdY8wBVQDXLvikQ8YTT6MCeCMNRhrHx8sat6bap37JjFv?=
 =?us-ascii?Q?qUqahHxf4eGTf/d4xeV7jo4Z2OSOUSj4ZBZS4dlvWgt6REKfKqyhg8cWq+gi?=
 =?us-ascii?Q?+9oAecLOU3/3D+vDxVonEm8EQ457jWjnDSwNMyfMEn8NaJ9RmVGhhhGrx2iD?=
 =?us-ascii?Q?0EQgdZWx74sGUzLIYZh/GbYHIma+nbmfgDtOW7HnuMlSvZlzXxG94fyAwmzZ?=
 =?us-ascii?Q?V75T58jGWwDpyUmU6dlZLdUzKZ0QpppHNU9CIdg6R0G4lIRdRo+TFJmdhuV9?=
 =?us-ascii?Q?uPg6i1Q+zTSCNSTk4GY8YSa817wa5kL74Y9HsXAosBPWaY2vMFf3W+KXI828?=
 =?us-ascii?Q?YiwSkEQqpaDrCsweH2P0CGyNlzynpqfZwyE69q10FXLY/X+CnI0akbRdJB9d?=
 =?us-ascii?Q?Y/MpmQy7siwdk9VqFVNAGNn1l8QFCso2NOWJP+4IduscsU817FVhq3aV9onh?=
 =?us-ascii?Q?NXjxBDaZ4x5Cg8rhmpfEoEQSBmxipGBkMbLoOs0B9ixtcg2M5rHxAugVryac?=
 =?us-ascii?Q?6mDCgk6SC72YXm3FG/1seg4VUv0F02/aZ13Og9oPOyQBtVW9HE2eQaFf8Tal?=
 =?us-ascii?Q?w5+LSKodIIzX62up93zbSn7wmq/ZkoNQ9VFK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:19.2699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2284dcd0-ab54-4631-a444-08dd93cf519b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
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

The addition of register read-back in VCN v4.0.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8fff470bce87..5acdf8fd5a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,11 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
+
 	return 0;
 }
 
@@ -1303,6 +1308,11 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
+
 	return 0;
 }
 
@@ -1583,6 +1593,11 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
 }
 
 /**
@@ -1666,6 +1681,11 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v4_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.49.0

