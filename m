Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66850C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 21:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6AA10E0D6;
	Mon,  1 Jul 2024 21:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbyRcLdF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D8D10E0D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 21:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq4yJKlzlfmo+ItCbpGVQ8djqLu6OIft+FbNtYeXKb+zCnu/GTSvoJqD/Q83oFCQex/MYHjL7PgOt3uwylmjytNXjClC6uffE9pvx5ieFOTKsXz8dbCdEUHa40APi1rZwmQvwAvTdyfZLq7oLbUjSPrfpmUJHKw2/ML96vzoJsJN4y6gJHQIpQK7kJ8VzzTm4CxV45cQcAtWFRTJ2x4JMBkqEFIsb39VNDhOpcWQT7ytCynORb/ZbZsJ1/AhhxAnVdK4JY4N2gyOW0Ep/Qde2tBS8FJ8iAIDql/DrbD6SDG6cPP0TR4msVDlQ/yYY6XwL75X2cAa4XJSzifIT97LsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3wKAsbjRmK2KzJ84ECarNOV1h3zWsMrJkI0+kk265g=;
 b=Doxj4KSWS0lWr/XLHCXWfQ580hIC3Kjbyl4Bnhn0hvuMq4/L2BdBt0dPYMkj5EnPIdN311VgIj5AfE6mNN78LAwaVstcD0EDxZM24j1cB7o+pfg0/wo5EY2M6cjvaa9Nc304wSKVTENnjOMV4J/dQ7sFyUdiUX6QH8LYZOjivWJGCUU0ttODAzVsJZ3x2rplUWgbkOG95Or4HqRMFOdmZTAqYhewUZsty+FQnapMrw8AMSZfPXDgVwD4Pfsr0lDQ9f/oFtEcRBdhUy098KaaASvHIfO/s1JbbLut8WcYCNnFCkC7fI+onxtNFK1bpjvSbo9azzl/wNmdQJI0QTcS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3wKAsbjRmK2KzJ84ECarNOV1h3zWsMrJkI0+kk265g=;
 b=PbyRcLdF8+/Eohk7D9GtE0CqwxtGALuG7QipipC4XbdHOXansZ4OdCNnfcBBwN+MURzkCVRxXF1AhvyHZsBM3w+UI408AYAhIsgjQ4a1DdjdvoPeG2OH/UqTl03dTyPR7/uFSOBbq8EXLvk8qMR0rR8NwJ1+etJO0D6rskKrEWg=
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Mon, 1 Jul 2024 21:41:50 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::89) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 21:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 21:41:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 16:41:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12: properly handle error ints on all pipes
Date: Mon, 1 Jul 2024 17:41:36 -0400
Message-ID: <20240701214136.15012-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7313ff2c-dd12-433b-024b-08dc9a169dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ri2V1hgMlxFQiyOuXWdxbK+XFME02XN8ZZylfE76VNWQLjpTHah0ev0XfP8o?=
 =?us-ascii?Q?wfF1CbNsqnwMu7kWvSsohsLVC+s8m2EnIdVu2+eaVgZgExNBIKn2X3yBJf3c?=
 =?us-ascii?Q?QH0Bz7Z3Q61I4WDTOE3sDKmAsjDs5x0tMsB/JfZJIh/EBeB5GPr1/rGuLuY/?=
 =?us-ascii?Q?XFHk3AxPe3YMKhGj43fOl5QblsvIZR7ryxSbSxzifynYx3TytxdeWME47j1P?=
 =?us-ascii?Q?EbkWD04iFiLDL4Ud2uRKkZXe+COy95zz8C1XltWQ0CxMBh+mY2CcjAmv5ZX5?=
 =?us-ascii?Q?1b2cWys+KNwRvd+KpUrY7w0KdxSnnSSTAnKzTXyPoLMqvwaf2ySXY9WD8Ur7?=
 =?us-ascii?Q?C2Lf5g37k7mesS7kBbMBPDeXAnwsV66DMq4j9Jg92mfIZQhVyhKmGHs43F3R?=
 =?us-ascii?Q?oXXfs/BYUzk5863+RcEh25ihmiHZddlNmfjsTOSM69PKBp1KsECvglyuY+kl?=
 =?us-ascii?Q?u7ElwTIjKy9G0zg6K6lBNqjU8nLdl8AQbhZ9n56+Y6iagxW1+vkfCpR8LGQJ?=
 =?us-ascii?Q?ZmLl6Qbsl2i1NqrHyO8wfUYEzi/Xf/RrsnMB0VH0ojRAf0BKk/90ubsbI3uV?=
 =?us-ascii?Q?rdArw07NnrC09uaxcVZUPe4oDeGDdnTHjQvL1e9DEeaUrTuA0eWfydToY7rN?=
 =?us-ascii?Q?E0q+wTyfTD3D4IV81C49xWOq/+o8kp99vlaUod3UFbe7fNLuq/tY24cN0Wcd?=
 =?us-ascii?Q?LuZpUzhxl0f0yopYKwPRd8/kuorZUIZlFJ6HczxEH4mNGVGdQrh+mtsDTBd/?=
 =?us-ascii?Q?4c/3YxS07rJyzv/1qluuoArhJtO+RfPiZ8OWpJeNso6zYUXWtYQdnhuTLdaH?=
 =?us-ascii?Q?pTjIvXcISwaYG4lTC7hIY9vMC/PubqVDfIeR7cR6pnIOVw9xAHmYzGHjv30Z?=
 =?us-ascii?Q?c7D+Wn6R/DUBkdNcC1Pl+Gc+otpaURbnvX1QDCMOWZ/7K/x++G9BKhu1hXGz?=
 =?us-ascii?Q?4VLUqo9cg0JYb/+0uhIVwIR3gJ63kvB2mzvA4yyeBBJmbgdtMRS5viF0x6OO?=
 =?us-ascii?Q?df7yktHl/wfFRo+6Hf+KliMYDqXJtJwHndJs+WgO2jrR5RDmi8FAgQI8r+Lk?=
 =?us-ascii?Q?bHSVAlNk7KCDR5yHRzyjXwYcXGi53n+SOYIuCL/Y2FfhPmk0pljQlTs518/Z?=
 =?us-ascii?Q?42dmcJHR7u1A38X6kIKaETdYYYYdanNzAclyzezZ9+IJHOHUNGZnTRHVJnq/?=
 =?us-ascii?Q?hqudiKBed0HZ9/lq9j4h1VBD3hXP+oZLnQ1FO9AnRYzUuyMOjouhFdr/MXUn?=
 =?us-ascii?Q?M3jE8+tPsFpzyqv+l5znn9ml9YhgbcKm8xFJ8/J88GNOflGJbz4O9KQFRSYG?=
 =?us-ascii?Q?qzZdSRlPV/Xc7Xu/golyVps0D3j6gnub/5YSPQJ221mozsf4lrNAI6UbJZwg?=
 =?us-ascii?Q?GkRcqOirmhRKfR7lMVDZsTssYIMrUN6oZBHuCJq51y1ms2WYUFQwcAis13RG?=
 =?us-ascii?Q?tdqCUK9G2YduEJxiIJlcdcI5ukhvlZak?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:41:50.5737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7313ff2c-dd12-433b-024b-08dc9a169dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

Need to handle the interrupt enables for all pipes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 130 ++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index af98fd0f32a7..4e761d166ef5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1496,26 +1496,68 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	gfx_v12_0_init_compute_vmid(adev);
 }
 
+static u32 gfx_v12_0_get_cpg_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	if (me != 0)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING0);
+	default:
+		return 0;
+	}
+}
+
+static u32 gfx_v12_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE1_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static void gfx_v12_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
-						bool enable)
+					       bool enable)
 {
-	u32 tmp;
+	u32 tmp, cp_int_cntl_reg;
+	int i, j;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0);
-
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
-			    enable ? 1 : 0);
-
-	WREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0, tmp);
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (i = 0; i < adev->gfx.me.num_pipe_per_me; i++) {
+			cp_int_cntl_reg = gfx_v12_0_get_cpg_int_cntl(adev, i, j);
+
+			if (cp_int_cntl_reg) {
+				tmp = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
+						    enable ? 1 : 0);
+				WREG32_SOC15_IP(GC, cp_int_cntl_reg, tmp);
+			}
+		}
+	}
 }
 
 static int gfx_v12_0_init_csb(struct amdgpu_device *adev)
@@ -4584,15 +4626,42 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 
 static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
-					      unsigned type,
+					      unsigned int type,
 					      enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0,
-				      PRIV_REG_INT_ENABLE,
-				      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (i = 0; i < adev->gfx.me.num_pipe_per_me; i++) {
+				cp_int_cntl_reg = gfx_v12_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v12_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
@@ -4603,15 +4672,28 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 
 static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       struct amdgpu_irq_src *source,
-					       unsigned type,
+					       unsigned int type,
 					       enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0,
-			       PRIV_INSTR_INT_ENABLE,
-			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (i = 0; i < adev->gfx.me.num_pipe_per_me; i++) {
+				cp_int_cntl_reg = gfx_v12_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_INSTR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
@@ -4635,8 +4717,8 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 	case 0:
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
-			/* we only enabled 1 gfx queue per pipe for now */
-			if (ring->me == me_id && ring->pipe == pipe_id)
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id)
 				drm_sched_fault(&ring->sched);
 		}
 		break;
-- 
2.45.2

