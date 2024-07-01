Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C3FC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 21:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6CC10E4EE;
	Mon,  1 Jul 2024 21:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rxS/qRJ5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA9410E4EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 21:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hex8wTFMKHCvhJkEDUMMRFnBcUzSNjJyjSfSoPaVvx++SR+LEmzBiUY05mQlmRqXkTK9SOBmR3EzslgpVfmTSAjpZR4jS/aHRrFhGW04eqjL3hkXuatZvglEke34Z/ARNPFcEVbLtbXR1UiO6n/dW7Y9PqHJ7uq9e/+H5nke4dsWatYhwmUI1AoWxWD3uPPT3KA0WQFqXty2TQ3vyiKD27GLanJ7OuuMaHhG1gRrSvZzsYk/14NYNDD5hsK8Dea+zmTzoA5oIBzymQZ21W9zGye803E+cPfuE3qdNNlLyBE/G0BB8T9zZgOLnqzG69j0xvfEN6t6MXOb+KZVBCQ74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DosiRqi5PWIoCVmVjLxyFM/pbxhXZX9xR5tGxo26NCc=;
 b=KiEkJ9bl2/647ua/1AYz0jMXND45692SySn8NgqxHppO2thsmJ7FSE89LQUVChf1DUuTenRCRjPXRykkXQ7exMgKxiu/yU/XZs9ImECTts1sxWw9YgetCKXfNbio9/rhxUN7J3N7wPWg9OQxWvGfeuV36rKQRXY21NHvsbUuvM4piQeDAW3DHqsp0T133heWeTtNnvNHK7abikyFyCW/0MxLhS7ixpo6EcHmwGRBNuKxKwhvKo1TjrzXeCM0cNo7KNHh/04lZRNFGfAgnR2oC0/QJxXQO8R2a6+s0zcrC6BrJLtAT10y0hWIu6Djn47zyxBlHeN6L9T7PagQNq5erA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DosiRqi5PWIoCVmVjLxyFM/pbxhXZX9xR5tGxo26NCc=;
 b=rxS/qRJ5LA2W/9MNH1SUK9oKDRk6U2O7LNB9MHOYWpmsf6ursNQ77KmaPwsH02hx+ga4MvpxikcY7jpq9/d1TcvPm2l17edYgfpi6rEN8VGb/LgQxi6WNsfjep6PoDouxE3lnaUQwGuClHPC6MAUOSKIUhrmnsI0PAb/Al+EIzM=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 21:31:45 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::6) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 21:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 21:31:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 16:31:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: properly handle error ints on all pipes
Date: Mon, 1 Jul 2024 17:31:27 -0400
Message-ID: <20240701213128.7596-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701213128.7596-1-alexander.deucher@amd.com>
References: <20240701213128.7596-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e14ccde-45e8-400b-6128-08dc9a1534b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yN4vc+6EOldsnVTIev/BBwxM8jwutFSp4r1zFsSCUiDH/QQ/AvGDc6/BA7G/?=
 =?us-ascii?Q?PHgpYH0//KmyZBXyDBbwW4NUH+GEIAYR/V0VPcTJrUOVJMD/lvupimC6m9Ac?=
 =?us-ascii?Q?JbkHFtAuMsWoinB5nseWkeKwQ6VqYnFYIx5v1OBZ6tJ/tuwtwIwFAwtp8++S?=
 =?us-ascii?Q?LAzRhJts07SclReAA8KWLbJhPKA35Pl8Tlyx0T9Lge6uibbqP/goJwQCeSsN?=
 =?us-ascii?Q?qulmH+mINDwShMyMJiCDG7d/1LGla0t0928CRH5//z+HHrtZzA4mq5M4Hps6?=
 =?us-ascii?Q?DppAEGt62rYSGjYS1hftBSUEF/v/5rGb7f/Qw1ukWAnl4ejm+ZT15qBVacM/?=
 =?us-ascii?Q?qlBp+ILPbmxmTNEzbeEC5YwklPPrxeTD0BP8DOkwfaORX/6lGU27p0GOK4Ml?=
 =?us-ascii?Q?mxWQSQlSr5Eg8BzXbUBbOhGuzvEedsAlVmFdjktY+ATUNuWErpyFLu8xH4Ns?=
 =?us-ascii?Q?ANHHGlJxa7JpphbY/0VJt3naqTN+BwAdEgcn8evyZgtR1+aLQGabturDuGPH?=
 =?us-ascii?Q?dkNT1JfvzeUqJVTVEF0s1ee3CJMbNmSeCBrDrSIqQyOsF1rpY836Xe9dFF+m?=
 =?us-ascii?Q?p7MHA+G2clbdP313dF6iZkZPDY9xSFgNZuThQGfIaUIbjEfwsWVlppu6XVcL?=
 =?us-ascii?Q?OGOTv//UTws2+xZPGprE6ISgBeORjXeYZ75Ja2/TwUqeYvjZXhOryZ0RqnIt?=
 =?us-ascii?Q?0JgW20nD0Z1fz5MYHR6eSw0NgJQLJ5eWAtntkRNhwMDjumcLODF4SIGUppcF?=
 =?us-ascii?Q?98D4er4LgvvpGz2rjPOdeO1OLEd6A4NaZDJ/8rxTyGQTNj/cLuzWNVz2mjMO?=
 =?us-ascii?Q?WKsEf5hhHjHAWOgQ+lkjOrpN6w6RhrUEjWPyWMt+79e5UgGmk05SK1F62cTh?=
 =?us-ascii?Q?K+1swuHH0wIUCKM2wwHKdMuvOwBcFDgjFRiFHDx/LfeAXRUDDaR9WGOQe+Jb?=
 =?us-ascii?Q?kDgyu2RL8jA/D5R1idIQV1W/SqLVdDwvl8Sn5dQVGgSSwcDG6KJbRYncXwOO?=
 =?us-ascii?Q?9hZVHMJOX3fuLmpNHEyMvxhhEJWa8LqCB8E13XYcL7uUpIlMqsbYpTLn94PQ?=
 =?us-ascii?Q?3k0feIgkTdBIqFoErYFJJrvkF0QEp9PELA9I0z+JlcjqIEH/NGlw+Fs3R46e?=
 =?us-ascii?Q?tpZKqy6Zd5zUmVZ7x2LtoGTXTKm01X6WjzQEgsRI/z+Z7E+kNKTnxMyQKHGu?=
 =?us-ascii?Q?BY61TOkTRAfpcmOE+uk4Oalaa279I9kZJc0a64nhvK93nnh1AIqXECUcgYf1?=
 =?us-ascii?Q?bbR4lH1raJXarYgnuLT0uN+MEq9eXZzqUP7otjBWv8MEjxRxhvzf55dLoVLF?=
 =?us-ascii?Q?xJ2VoVGl3g2gq8iXHW+tckL4euupVGn3Pt0g3ZctFPZHw3DSzpnyROVzfZV7?=
 =?us-ascii?Q?sQ6jYqxU44j4scRFIVqWmHCPKIn0bFn8QHDZ0ciChaWD/FAlbAyuSnWeSOnv?=
 =?us-ascii?Q?oUrtT3ZiDHTTBQcKME5li07YsR/FH62k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:31:44.7326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e14ccde-45e8-400b-6128-08dc9a1534b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 134 ++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6d285556892b..fcf31483ed25 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1947,26 +1947,74 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	gfx_v11_0_init_gds_vmid(adev);
 }
 
+static u32 gfx_v11_0_get_cpg_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	if (me != 0)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING0);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING1);
+	default:
+		return 0;
+	}
+}
+
+static u32 gfx_v11_0_get_cpc_int_cntl(struct amdgpu_device *adev,
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
+	case 2:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static void gfx_v11_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
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
+			cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
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
 
 static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
@@ -6199,15 +6247,42 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
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
-			       PRIV_REG_INT_ENABLE,
-			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (i = 0; i < adev->gfx.me.num_pipe_per_me; i++) {
+				cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
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
+				cp_int_cntl_reg = gfx_v11_0_get_cpc_int_cntl(adev, i + 1, j);
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
@@ -6218,15 +6293,28 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 
 static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
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
+				cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
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
@@ -6250,8 +6338,8 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
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

