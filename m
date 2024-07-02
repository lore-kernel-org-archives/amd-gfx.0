Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F6EC3065C
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA4910E611;
	Tue,  2 Jul 2024 14:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RhYuhuAo";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE7910E29E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 14:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnyONvCTWHhUeP2zxsGEnfKzU5ZL40lmh3uFr1/t1BUDOTQByOZu2Pb79JoJ1G3y9Yko2GwsA1SWmUMcfe4HecC285fAXmSgJAxrOLzczfZNNc2diQu4rSr/ovW4HhBJRRe/RYnBGyKSrWc7DjCRRXCnx9GTnrtVGSKHzyHPFbJtGOxwjm/OUqRcVR70vl0SkV84Xgwm+MqgTjMlVkAdRJ2qqx8zT67X6OaC/+InTYs/SjE7P0Pg8Mo3nljxOE17u8bxYaeJXXNsVjpFwTF8O5lnLE7Da4PG+MN+pEVUuhTOi/eK+8BJz7oTekZrREq9x0TBedEG4JAk8lsI17dzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xjtBxQZ7C8AURFRb+ItdwU+75VCWASeGt496q22CLA=;
 b=RiGinmK3xrCH4LkrJgzwQ3PNDQGU0Rbz3ErDGF2XkwWu3yexlyMgq3jtEzfYcPSP+1OEcXEEsnM3wul/6y/vGvffCQzpzx+xL/LGXc/y6yv75e7mPnekLSGMGep2NrJRRCYV4zniP3QMjZC5+alkw6hdtfwXIb6Zw3s+X9I2AZTH9+5+lh4JE/mIvbh0r6+3x8hZt8tV4HgSSAwSXWCaF71qpkrUhrLScPe07Gugf8dXvAj+lBJhVUsI4hkSeD98sH5oYd1HS5D2rgQJc6p6YtpyTR3O7v3TDLQAuy8YWikFy58Bjg/qI5DmUw80Pny4LsCSzoQwvPNKDq+Xzz53AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xjtBxQZ7C8AURFRb+ItdwU+75VCWASeGt496q22CLA=;
 b=RhYuhuAos9zetM6W4NLJZOpqLOdEFcrfMr2CieY0do6+eTv1NMSMGPb4w0aKKTIsb/Pi8xNGYlBiqayehSvuACT3vXYDMAB/LiQqkm5QYSBvSDCvjnf4cs3fU8LOgiVzramPNcrrZCbaV1WBbH7zzKDBnAVrSphyyJgzcYVZkB4=
Received: from SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 2 Jul
 2024 14:28:47 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::1e) by SA9PR10CA0030.outlook.office365.com
 (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 14:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 14:28:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 09:28:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/gfx12: properly handle error ints on all pipes
Date: Tue, 2 Jul 2024 10:28:27 -0400
Message-ID: <20240702142829.705019-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a81b17e-076c-4cb7-1f39-08dc9aa348e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T2qosctrLRwJLcBR6mSRI+iZAGMk9HE7wWvCzYJs1oEaY+ztl6LxVWfVcDKp?=
 =?us-ascii?Q?QhQHzRYheIi4dihl7Ni9fopXAKs6Mm9PBTydRMaeKd/A11UJBjt1iCytMz2A?=
 =?us-ascii?Q?hwA0b6tZUpT1jqgPG4mN+8IjHv10vVBm4UGfZJHSHrBllvTil3pchMZGuVDt?=
 =?us-ascii?Q?ftb4CifdYyBmWfiVajts15YI6a45gfDdiHwZ36SPprGEtwUvu8yQtKV7mlhy?=
 =?us-ascii?Q?jbK7hy2HFe8EirFK8SIJqDMVKvyP2A8HXIQBV5GSGytokDoF6KG6zCGIqXJO?=
 =?us-ascii?Q?LkWobHpwvt1wRGpvQ0jrlzKZIjUj0p3s3X1sA8NPXEuEKqXUnzneM5ZlMtic?=
 =?us-ascii?Q?wv37zzwBCmi4FJPZ6PT+XyBiVx6kB3vFf5wkJbJKmjIig7oUpSfiRThVO3et?=
 =?us-ascii?Q?ajBuUiVN1m9vQHrdP/poIOXtj1bKciRD7AuaD1mThxvIDlgSRhKQcqjAs/4V?=
 =?us-ascii?Q?FDwLVZQCz+Xva7h3wmmiXl2chOEeAoEyVM5RGH/kvbE/PzEfMuicalbQcAZo?=
 =?us-ascii?Q?t1mUfkw7Sdf+DWnW6cDRKQ2I20BY9RCxAfTWJOAulgt7OcTpZZ+vCQbGo6zF?=
 =?us-ascii?Q?1kJzpSS/mfmNFwesA+ewcZ5QwK45kfq5EdeB2AxIW29Iz4SLadVcVs8f05kw?=
 =?us-ascii?Q?oqh1f4qaumLXybAQkikt80nwFOd5M6IoG0YxgyPIowyN98EY0/T6RbDDxihs?=
 =?us-ascii?Q?kobxWOq0Mm98hEXmD3+EGSKAkDm2+yaApLrq0lVst8h+4xAR3bismWwc/zzO?=
 =?us-ascii?Q?hDDh5f90Gj5mMjVcN9dB6wBa9PEfMh+gXIH1poc9Gky3VVOpY5CObwZoOb9g?=
 =?us-ascii?Q?GuNYuZg33k+LgsNpsMVEF5opzlMe5SLOicXEX1Y66NLHtJUQBD4ZkavRRUmT?=
 =?us-ascii?Q?BNGyQ0G8zZdsT+i1g6SvOki1VC2Qu4BOWSw8MvNvZ7QUiwgt651yPP1/vqrb?=
 =?us-ascii?Q?W/WKH/ShgH+FWpQkKPm2surs+3Y8314ENBsllh6UTxPqP3bu47uxfjWY5Ymf?=
 =?us-ascii?Q?OgOz3P8jrwj8pGaE1Q2Vk6gJmpByX+gXQZOJZz8W3QhUDy7B86iwzKViFMcT?=
 =?us-ascii?Q?nCVe8m6jOXJ4o93Qa4lkWbYCI204qWy0NEXMn0R3ow7/3KpwZQ/0jYUSyo4J?=
 =?us-ascii?Q?4qhZ8qFMXTT24rd1ErkhxTKcsetMxnk3nTsaM8knspSHEV4wu6dkOetRfYvD?=
 =?us-ascii?Q?sEJ7DD+Wdzf80dujJSp4fxBwLULDQxItBpcHKNyRGsN2Xy8TxM9+BwGV4I4m?=
 =?us-ascii?Q?KCeGDArbgi3sPJYn5U/nKpB00iJRoEN5PN2BLfScFHweMUpC7GLtRkKrtKUu?=
 =?us-ascii?Q?zF7soKDDC01bZozrYMYtuuhVQ+lgYqchCARiN99CQmz+XFVyDHv7weU7sM2d?=
 =?us-ascii?Q?l/8Pl0tbHHFxtQYzJyNzl/gmbfo9JssuktKyBbe/Mj+3wsXQMV7lC0j99N4m?=
 =?us-ascii?Q?h4VhMaL5725hd9KjDOHMdUJvZtNTaRyd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 14:28:47.1108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a81b17e-076c-4cb7-1f39-08dc9aa348e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
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
index af98fd0f32a7..d91a40f8545b 100644
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

