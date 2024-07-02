Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D37C3065C
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2111210E293;
	Tue,  2 Jul 2024 14:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZxQ0LFD7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681DC10E285
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 14:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBayWrPQRVTShH7pECLqIidn/e1kgG6ahMLIq3HNu0z4CL9/IumXzZ77k1l5odSiz1txadIguKmAUuPyZsLQhx+XDYxlGnJf4bwx3OgKmDiRsnTc0j0TsG0DaVCICwbnTxGV3Kyu2LR2ZOrULb1+4+S4V8OG2YfkPDp8nez6o+EtO625YYcBv8wFULn5sZQ9KSLFmpjfdcUnTnkOSY5hihv7TWYY94iPgL+BSpb3N5u6T7QcVEYtk34S36FqNuxscYWoSTxb38JBeYHh2QDjfJ3UmhZdPtUCX+hzpEWmAiHKmlbGuR88TC+K84eTZVYk6Xn6FlzFa/uAru6yqc7Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aRYI90Cnz3kj8sIQVCWzPd07pLFnspmx00bU1h5aOg=;
 b=XlbNPxIL36S6Kt3Ntb057dhsChOCAY5onzdAB/vVA0163Y0ee3G41XSITw2DpWoU4VoSfKPmCsRWyHGhCVKZLD3dXDDhzxhk02fKVSiXLj2VrMNd6k85xDDzy2dufaimMB1wnRhuTqlmajxQ5ZsZOwh4Z8ZG4TDm6/bnIcbmm9siuVJpMZBg0nRKQwWXQEe0CHhEXsQoxyuYlQj9yA5JQD6sFsaJIkEp1AV8wGD5Uev3TUOtmDjPfkaw7S6JrjU5SLzMfeqEYEmU7HBL2pl+7cJIvMSHv3VcmTtTMlQnaSGr5nN/y9RJVArPP6kT29UIEfF1mh/ki7auNp2ulTWuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aRYI90Cnz3kj8sIQVCWzPd07pLFnspmx00bU1h5aOg=;
 b=ZxQ0LFD78P1fstJLvbHO8z/wxC340fm3c/71/5ZVGcZT+Y3d05SUd3MKt/YC14O7nOYspFtzpBSA6DRRd3DPKsCEkNdtQnyxi3QkiuM+G9AG7qPEEc0h5GrhCJtm+sXJvG/oluKjawA4iPJxIhS4fQFTnrlv/39Al+5BPzGVxWQ=
Received: from SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 14:28:46 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::b8) by SA9PR10CA0003.outlook.office365.com
 (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 14:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 14:28:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 09:28:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/gfx11: properly handle error ints on all pipes
Date: Tue, 2 Jul 2024 10:28:26 -0400
Message-ID: <20240702142829.705019-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702142829.705019-1-alexander.deucher@amd.com>
References: <20240702142829.705019-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 640109d3-8c05-4d13-71f3-08dc9aa34892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c6M2PDCcAsNtEgFZzZxP4nwzEwWW/cFdmBviPj2edEXRUpWM/hwmTYEBCUBS?=
 =?us-ascii?Q?X41YHeRJ8yL9gM2kOXdywBL+e45LrYwU1vw+fFKnnVC6MflJLA2SsaqAiadl?=
 =?us-ascii?Q?40N/WirudC2GekYowRgMeVGxOzwQB+yUjiaGpqb71R190vqhAWpfWjlp8h0S?=
 =?us-ascii?Q?zEDiYeyXBT9AtfrThyee2j6qlcochDAwvOAdNYTK0oYwTa9C/qRl92R7ZLnM?=
 =?us-ascii?Q?LEm4a6BQmaQ87Vd6Llv+ozx//wNUWO62xH95x/YPZi7qFyM2PFN8+gsVpKki?=
 =?us-ascii?Q?Uz2lbklCBt9UClaakUmTcp8+YxcrIk+ZwoXXP8VsK/LRRnmVPVBCW9NwFJqw?=
 =?us-ascii?Q?wG9WkNw+kCTgy27p3IPDmTcZINPDXkoqDS7HIz07TjkAPjOXjvK3IoYqrX0n?=
 =?us-ascii?Q?NvG4oxENXEexv4UsgIdciotUD5vwYBPTHk9WkUlQtvbKx3mScH26eqCy0sOu?=
 =?us-ascii?Q?W06Ih3ZCALJBenBMS7B3qH8ommJEb/cAReqiv9dzkRBEheIgzhrWy352jv0r?=
 =?us-ascii?Q?75lq1KLes6Jqs72iQtH3YcrO560n8XWB9ZnFjT3ntOsK05eXH3/n89sjm3EB?=
 =?us-ascii?Q?76AQjEqB4KfFjWnQQhA7QmAZpOBxqdFBNygAssSmIq84/HwE7UVbWBNw9ePW?=
 =?us-ascii?Q?pbb0tPHaNGLVRsVMG5RDAHfPZgoVROnbI16HUlC3wAaQVl/+36gMDEJvGRSD?=
 =?us-ascii?Q?ahoA0QFD30dqbKziHQ6CMxcRgkEsgmWFaeA854gYT47hf7RRlsbVmp0H2eyZ?=
 =?us-ascii?Q?ufPSS5JjAdylidfu3y0zoT0tFeMm1bXXTiKlBEOCuVDCvLRu/EqYfcF7TV1F?=
 =?us-ascii?Q?bRjB7qh3yfRKkhHcLr4CPAJkDFSihT5hf0Wftka70gQof4EJ0MZ/gEWvbU9e?=
 =?us-ascii?Q?Z/ny5pq7GixD3ViPkBucDBQfC+oye8HV6P+H1M5NnYIarnMmDpk84M3oOpPW?=
 =?us-ascii?Q?zGbTuGEm+updMBEc6Xs983dJXqjuRYbvOHpHv5QHiFCQ08K6HIyr2gGTmnKm?=
 =?us-ascii?Q?1vq4NaMb3ALy19+tY+RpGOQXelIBJIAh4uZHmhkXJCSLWB5aDMprRrtiiEGv?=
 =?us-ascii?Q?RvdYdvcjr7sQ84m9wNrRu6N/72UEqNuHQW9m5KHf6cBXM10hfC1NOiS0vpeB?=
 =?us-ascii?Q?TlMM1SZIVwZGgJyljL2Zqg3qW3nJUcCs3gZJLqOAAwH10ZyJ1s7nKZHftAdv?=
 =?us-ascii?Q?5rb8foUjIFqbQGdOKp8ChwtWY1hJVygTwM4NQFT7hdPMN0oFMP/0TVciuOXv?=
 =?us-ascii?Q?Z2kMTXrDcs2UPHHzhkxgsTwwJrr2J5v5k4VRGUtvaJTTxJbEsK3UkpoDiSAF?=
 =?us-ascii?Q?CihEU4U27Ef5u0mkeL7nodWqxVULUtqZI3INEPz5Qild9nHqZvpg5qPcLDYy?=
 =?us-ascii?Q?z1e4kMPDA0QUtUQDZt5Oxc6ElKIGR7xFhuf+qbcUhRcD2yw+TDkYFeRGt9/A?=
 =?us-ascii?Q?mYFAYbd3G4rjqqDuWMESCxsH9+9Lsbd6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 14:28:46.6265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640109d3-8c05-4d13-71f3-08dc9aa34892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 134 ++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6d285556892b..b686a37a9fee 100644
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
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
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
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
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
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
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
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
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

