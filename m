Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA6C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2D410E430;
	Wed, 17 Jul 2024 20:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3GqeW6a";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B351B10E446
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTZ3B7L1IXg6UWXg2she0NIXK+ZIuNwOVjsfsazTvwHQkFQhreK5hL20O5R1BkWReFkqbrE3ROaX6G17WwWBAgEtB69o9Eu+wOeGyrtBUWqigpaZ0kvjdiVjyv0Kbi5a+U30NiEpJur60Q9TDDwGBIO8O0/MXCZKueCqnuL+NTVMqR+ZDeJpk2b1ovdG+T+7kNbjvs8+jsW+nRzBFQMnReJrU25RfJmc0tQ8HsBNdrdoNPzhYLX0czdOsp4wTGb+LPpdgmGYj8bpSIhfZ+qsq6c2+q6SN6jY2dn9AEXoP11xsf1rs7uw40xRsyP+SydlB5yc8YXa7W0OdC5Aawp14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH+qrOjgUQRmonIrDBBaDSjFarU5m6pJmEw0s8O+4Uw=;
 b=prefvK+UM/rnIvyP4YYT1URXUGpoCJ41YWf7CDwja2c/n/vlEX8aZKWMetFNte+0VZdgbwyktAQm7kGdTpNud0Jqy39roBuHY5TWYBW9bCRHsmqduk5ZihXzqhxpYdZEfpYxTRB3S68i3uhTTm6u9E2M4T/RqW8njb9594wFukvzSvzQN/yugcfsshoUD2B8vhtpMnrxdROQwE6PEg45IJ9MFx013NO7hwlRygxffrajpN0tYDJY5U/qnmVRtVGZm4qlb4zr7naGOrSgoOdQ+JgPTq7QnszET5w5cG2Xk9CSWCfKlWV+vAY/IZ8vI+3v9AWyV8zOx3nZvzD/ZE26/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH+qrOjgUQRmonIrDBBaDSjFarU5m6pJmEw0s8O+4Uw=;
 b=u3GqeW6ad/Eh6EB6FINhEyjzb5cAKGIsDBtx3xNmam1v2aOsK5XC4UoiQagx42Xqh5L8gDDDPTO3DJVx5CV8iL5OOm28NSqhYJDWOeAaXFSRZF5qvOLHKXYQ4PbdJTfwvh6gT35qpaIw52jxEHQM0ZZLxWGh16NmOs97gMaWECQ=
Received: from BN0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:408:e5::31)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:39:10 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::45) by BN0PR02CA0056.outlook.office365.com
 (2603:10b6:408:e5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 20:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:39:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:39:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/gfx12: properly handle error ints on all pipes
Date: Wed, 17 Jul 2024 16:38:46 -0400
Message-ID: <20240717203847.14600-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203847.14600-1-alexander.deucher@amd.com>
References: <20240717203847.14600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 505844c2-104e-4a9a-aef1-08dca6a08318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?isBLrUCUM9LDvUA6iaz/A9Xtk56J2lw7F93HPlgCaPP4Ev9ddXQXqUpNzgpY?=
 =?us-ascii?Q?5P/0E8wTzzNETYKyO2Kn1wtB8k22CNVko9bnXiUf+ndVx4Tkd24kjwnJr82T?=
 =?us-ascii?Q?0zdM7+2FbABDNLJSwjvM0kmJpG7f6iqKoVOdLBJkR/9NuT9eO4bTSTOATD//?=
 =?us-ascii?Q?cExrsIN8lhuQkJLMQMaeqGJ1up6dm+ZKt6Afm9VMkb8sqjh+ShNsEeIUpSRf?=
 =?us-ascii?Q?piyOWP7GBsqTu/GKcq+qFITO8vBUfs7mcqu7Ej/nyGS5/347dhv0v56SrEax?=
 =?us-ascii?Q?r4ayfM/1KZrmmggb7B2d6dsgrqsYZyvSapWcJhEHCH+a94u1ZnPMQD2FLF8v?=
 =?us-ascii?Q?6QTOfc6eLY9l+IEZCeA25Uk9Rkh3C9+nUeEXIHoVMASotpqB+/j0SvtGwa1r?=
 =?us-ascii?Q?ms4cF1UDwvNy7HkqI4A6qgo5xbV8qDuhfo4M8afLzvcSHnT3eUr++RPT3Jrm?=
 =?us-ascii?Q?ATfPYNM+WlnYHw+aMhuA7veKArkrq+f7Tk+HZPuiCRTFe5NwweAaIeuy0zO8?=
 =?us-ascii?Q?cFOM+Z9+R0WWJ8VUh1cmlIHuciC4nE3AxkSzgMKru+S40YNjqOE5n/h+oen2?=
 =?us-ascii?Q?u7PY0RaA6M58OYPuAfWSLVqS9WxWyggwSqJhgx5kTrcPJTi4fnjkoNH+c9Vq?=
 =?us-ascii?Q?+Irsh7jNh0+kzjcZR94LaiuW9H4/8d0wzGyfGmqxRHkqXPSNn/6fNVIr23QG?=
 =?us-ascii?Q?GvKv/UcASCf7ixWpZzPB3aIPGaxzumSiGOsfpyVgt374Jn4gD7XozNb+DT+b?=
 =?us-ascii?Q?WzZiYuHbBlV+bnGPYZEesL2MXH7I3FM+JU9i7czok6PWiZk5RzZdxo8V27YM?=
 =?us-ascii?Q?JumIWI8Vbs2qsi7MDh8tzsfOaqoypUaHnI6w2etuu0T73NXL/oe+bqdRjdz/?=
 =?us-ascii?Q?q+wVqBMkD+kFomDxlbB9U0sLCE44X5C9cCKLDObwGYmfwRZpWTAGmk1KMBBF?=
 =?us-ascii?Q?p+VPJYORocveiqZS9cTgdSz1DSoGO4wJ16s+R7kfC0jGvQw67R41a96SqJDV?=
 =?us-ascii?Q?2np99nDRK/Em8sgSPYRY89M7xzViuR528HjdG3ksRaOY3Kb0RztW5hqudqYr?=
 =?us-ascii?Q?WfXWX2vFXwsJT1u2fEONxzYvoYcPfbYWIS5MwqfxytxwfMbckYOkh6gT37bH?=
 =?us-ascii?Q?nNTWoyroUqdcDNFsuvGSCeeM8GWh+km2VTWD4sPLEMylxmdPuWZ+yKMp+JPF?=
 =?us-ascii?Q?G6bpaKyFssOEfkYp+3Aspjb2npDRiUcchyzBqISQmrHnkNwBjsWAzLSAy6nr?=
 =?us-ascii?Q?I0fJfZftj2HlH+8ZeE+T2UYNQ4sFitLDukibBqYjAB6WjTOdmH4XOtNSiHNu?=
 =?us-ascii?Q?6S38RllXBGM2oYtd3bNMCorvc7BZBfoB7n2FAY/sP2a5jX0LYebTUGmXo3RE?=
 =?us-ascii?Q?5l4LbR3V4KPFX7q2FXDfoHq9HbqKFXyTE6SbseRJwaBxXv5ftx8p+fw0ZDIR?=
 =?us-ascii?Q?Ri/t13fRh7cUwkbpNspniAvfaaZBVljI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:39:10.3553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505844c2-104e-4a9a-aef1-08dca6a08318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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

v2: fix indexing (Jessie)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 130 ++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 567f9196d6a0..c74c8a60a23a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1680,26 +1680,68 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
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
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
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
@@ -4745,15 +4787,42 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 
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
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
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
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
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
@@ -4764,15 +4833,28 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 
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
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
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
@@ -4796,8 +4878,8 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
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

