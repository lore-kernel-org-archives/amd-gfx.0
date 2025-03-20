Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0FCC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE6B810E65C;
	Thu, 20 Mar 2025 16:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LTfKQKgo";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37BE310E3AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkyKbuF5VPcF1xGsi3kR83V4SSYMBkn4hF3SqiDmCL1J3ptWHg3MffH5jHUPwyz/gQ3XcVEl/3tP9nn+lchDMuG8bwNP3WqhiSAj+7chIK122MlsKwJCvcgKxwIO86g6rHYnzK8VSCQNSrpJuuZ7nGokIdhP/h0bWpRsgan0JAnG5p18uOvec0S9dlEDqHKsWSDXWob5qBnj16lP1M1T9xUXwbvOcDCH1qu7fWQrO0H5iyEAZi50UYUyQK4B+IGEHGpQvYoSApVA/cfbJHLi0BhgO16y0sHlZyvT/mK3PrMI1Fcj+ZPvrdG8fTJZO+q0MUgfsUm0g013bFuBMr+VrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMlbMMPdV8ROm5WLrWa5gDmKTy92r5ucUYJCNCvYv5w=;
 b=FDfE6s3QR5JYyQs7qerTy/ZsFUujM2SY9juf5p95MK6OoAtda2Gt3QpzzP8t0jNWn25Te9epgQd/zSi+1g7aE07H0zJnRq7NX83I9v0lN8lmuXWccZho4JqlUWTjXSYSbsotWnnL9ka7V8Papw5IBCznN9FVmjHhMicDYnqBOluOrubpS1QPVKN9UUUhqTdlGgoijVyIAwvLcYLM5ek6pJLZxsBwdVpo995Po8KGHqF94kR6UmgeYxezgc+urUbPzp8Fex15NderuRmkBjk/dqceW01YW4CKK1np9l+Ip8x4ioXqZf309pSD8iLFeF2ou2VDCIPEVgEpJ+VJ3X5m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMlbMMPdV8ROm5WLrWa5gDmKTy92r5ucUYJCNCvYv5w=;
 b=LTfKQKgoG3TO1RBDSN1Lbs+36GCidV8BX1KrjzomJlYvj0OjH/1lB20xfSjEwrtb8tanKN4a/ovXeSUnYfyyfHH+/wpYz8yOgbaon1cI4yIJILO6k3iep28RfrRLzJ6QGft26KhE9jlnX30SkBO/6BM8qa/gL7D6UobXIjE/KQU=
Received: from MN2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:208:23c::31)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:56:51 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::d7) by MN2PR18CA0026.outlook.office365.com
 (2603:10b6:208:23c::31) with Microsoft SMTP Server (version=TLS1_3,
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
 2025 11:56:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/gfx12: dump full CP packet header FIFOs
Date: Thu, 20 Mar 2025 12:56:34 -0400
Message-ID: <20250320165634.1245798-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc756d9-0845-4188-4894-08dd67d03644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9eB+SG9NJIvavlgSECkRA+9ymVYX5jFA/1acbreLSAIsv1Za6NM7D8RNhX3p?=
 =?us-ascii?Q?Nf1blXK7CEG7bXb4Z9JC1l6GQEVz00qbfe7KFWo/O/gOmns4yfvVLctNho7R?=
 =?us-ascii?Q?RJbfIVXrnixqgP8V+vGALE7MsZ7Dt206bGRNuleqwEIH5FEug7e5kjt9VxNC?=
 =?us-ascii?Q?ct4hsSo17eyMK8zQMePZD6xHkRC8GbgPO6rVn0aBaFW5yZGmMIA9fwfMwuYO?=
 =?us-ascii?Q?T487RSxurCZs+zSaUbwJ/HWwDW9VJd/3nX4pPRc4EXcSUW3PUMhKt3al5vg8?=
 =?us-ascii?Q?Jn+FkSlK2Y1x5JIZs01YxKERbbzLyj3fuiuya32oShdDtXZ7okh9neEBgUER?=
 =?us-ascii?Q?Ubz6ok9MwT/CnPoSDb8GViJppS8Rzv5FfuUxJuX0rF8AoKt0TyW+qCxiTRm2?=
 =?us-ascii?Q?5pvmHFOU4/zLtHjOhOb94c2ANJcCM1v4b7kUSQzvMYvqtYVXAiAayUSBLrLo?=
 =?us-ascii?Q?wSJftTV8Cz4MhMiEjPLTSgckJvcIi4mRhnKP5F+iPCz3v3bQ8axNy2zHkFv6?=
 =?us-ascii?Q?VhNQ/8GdvaGL6Mzhw8rb27S35LbTiWcc0F/Qt2SeOzp4RWJMaumSZEjTywYQ?=
 =?us-ascii?Q?rxvSzabeBOqYt3XG9nLuPfE1M1VNOkE4i/rQr+P5lpXc+hfewAZCyaQHh030?=
 =?us-ascii?Q?d89x+vn4SaQY4XUteGWhv9BQYTot85ej/L60JnScFo8udDxBYY2G7yndp7lQ?=
 =?us-ascii?Q?hJ36qXwDJAPtXA5/trIV4EV3VJw6gDH8FIAe2FGEy9czuFJUaZ6igNejuT3Z?=
 =?us-ascii?Q?DvdqNo40BdQbF1XB5jh9SliOp3U8AZ8z1HLqwfuVhRPU2z5aZJbtC/BIVGmO?=
 =?us-ascii?Q?q4nqjGQn0zYrT9zkjGkJaraoJDxfPjJ5jMZZaHs/J+50FoDukf0nJSZbjpum?=
 =?us-ascii?Q?BAudeLdNyKiLWHs+/zUUps/F4heSdx6Bo3SSgd54Bt+7/9WC2QeDmDGmvaAQ?=
 =?us-ascii?Q?tqllKzKfUBZ9gkGMK0EHEY0JTlYtYNIuQMRtNAm21v+kNbHeSPV0S/Ex6nYy?=
 =?us-ascii?Q?zKWM5/pCBf7Cwv19hqlUKfEzf/F2UdhWFeqzFKP356TNmsNmoVT3HLv6CqBs?=
 =?us-ascii?Q?AJZwIBB+qAWbJNmcCgk/JiRF/t0yZxbt9UMPhaeB6TXjUJq8yQyGUww6val4?=
 =?us-ascii?Q?eZiSkbxImpQ7SjQHXx1d/a3SEfmB69ofWgzID7jhHkoTWdiZ7cGaaMGc7sUQ?=
 =?us-ascii?Q?w6SGy1m3jKQZ5mveRtXH5U3Ton87da/D9rxTLYcaidOrfIEb5az7DX835DLQ?=
 =?us-ascii?Q?9+z62Nd7RK1U/NheSzh826tYj0WeVeU9CehKVs/dkRS8G75vYRg5ps37qfq7?=
 =?us-ascii?Q?FxVvAilJfsEJO0/p+mjbt2E0J3bDscnHx0ciozSEenWTHrDqBvzDN53FW51L?=
 =?us-ascii?Q?5McSNPhVS5BVXDM+Rlr04fOlrBDS884qVScn1HTy41fer0N6+FyuJ9Sol8ys?=
 =?us-ascii?Q?Va9MeooWP4gecke/z+QyysUQ7HDwyI4T6LrWgO3ERWE6JHtedWki0yn7TVLz?=
 =?us-ascii?Q?cpzOnRFahvDa2ls=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:56:51.7312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc756d9-0845-4188-4894-08dd67d03644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 634dd0abc0e80..ae41c91c9f6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -135,11 +135,14 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_12_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
-
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
@@ -188,7 +191,16 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS)
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
 };
 
 static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_12[] = {
@@ -217,7 +229,24 @@ static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_12[] = {
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
 
 static const struct soc15_reg_golden golden_settings_gc_12_0_rev0[] = {
-- 
2.49.0

