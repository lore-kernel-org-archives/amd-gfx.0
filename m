Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3528C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283C210F35C;
	Fri, 21 Aug 2026 16:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2sz3bY+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB0410F35C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf0BukvaNRgp3FAghKBrNmLNZrwb+WdnJ2wubvQvktjJ6g3Av6eFJnGnX8QF1t3lsQYbNWJzDETvWm+GJ34KpxUwo4z8rNqc//9XavQfhCRExx4yx2s60WIXzA7wpgfRyjzjDz7KLnqQPK9ZgUwdk6pen3AYsVmY6x4bDtgp1dXeeyYm+zIeANJ/ZbmHvGgYv6WNnM6qFVoQs/Xh/uYJmQ/V7drQ+a2nshszQ2bYZhyXiUdeecSiCy5BFLe5S65RicA4I0Fpb7pa6I8s4G4ibYP1YP6nE+Ctpc1IWK9rfKqva8paqHOXxvQnDgfoxrdgT/WhDtB2IqGbChbvTSJhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b72SpWo40rsT+tq/eJ5crud7EVYxKgx/nKtrl5WyhGs=;
 b=gvrKGFIBJKsucMqAPyx+jNz586b4GepG46maC2/cMU+JrP8E3xH8zgQzMwxEBeQneQFNILuLAfJ9uNKA7/6Ph1UQ9V4FRpqPAlSQMhiGUZN12vUR8slLqNgqpejHB7RPKzUV+dt+NAu7cp0KIwP602ooWVSh25N9swatr5tiad1I/335Zo4yYuJsqkm1HKNLVesArov/2ovIvrcaZaYaW2seeqAuW5SmjFrqXvoBy9WYM4mI6wX5k+lUcH1myJT61Sa6hrCN0jZ/UFLvryhEPfnZQm68LDJgOcL9lm5NG+E1dQQFZ07fOpJYaaNpRovqb613hYAzJjHZAfz1kdDC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b72SpWo40rsT+tq/eJ5crud7EVYxKgx/nKtrl5WyhGs=;
 b=N2sz3bY+KB+xzggtf+zZ6iRbokoRCQRMAk8wG2BvC7ew/sq2EoF3b+suuLVwy/p2biB/2lHdq38SabwtXE8uYH6044dfu2t+rVgNgYdxYLQU6j+IL3fc7Xy9ZKouFp3wh47Pbes3m2eDGYulf1M91BpZCRiJ3xdd67eaKM4psTk=
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by DSWPR12MB999152.namprd12.prod.outlook.com (2603:10b6:8:36e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:35 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::18) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/15] drm/amdgpu: Add workaround to enable GCv12.1 MGCG
Date: Fri, 21 Aug 2026 12:07:06 -0400
Message-ID: <20260821160710.752459-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DSWPR12MB999152:EE_
X-MS-Office365-Filtering-Correlation-Id: aa95ab97-9194-4b36-35d5-08deff9e5034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1LpsLhDq2JqE4fhXryNH7KO6jhM1pNBmgX2Knph+i9SALKH4j2dSu1MmDUfo0VJszcDAC24MO35Cf6NE7BeI3Cc2+67RvdNjf19DyR4XvAuL8WTqh6Xe3L411t+uMPYiLk7tNCqpGRrHzQttPfPXu2p+O2t4veOKwdbzQlPeTG42pJ6Idzuk7/2cStMrS4J58amGnfWQjUDl9w+ysQ0Iuv75HoeEWd/V0EVVb3sT11VEIh6CN3aPyreMvjus51pFcjCNKEgpqS7MijDtsuvkeOiYdeGQTfIoPKcKkR+Qn4vuwIflIX0R8ByzLCMCnzw+gPW6zhNtwoIaDMOwRAbVkgZ4RqWyy0sC743GWvmdtuytE+ADxxOOwmZWn6xuDKMBxqcfMn1GRvuWc4GeYfQNU9BORN1FgxawA8V7Ul2SRjRQZaqYYi6oIYLcKjM1P4EMA1+zIUGQ1NVGdYkV2ziDzy3sTYA6JsvbGnKSeCvtszCceFn45ySqslsEVHcplTF50e9Ip2fDOE7zEA4czlJ6d+Kr8z/PQceCv1w9wCiLV7vr00t3+mN/+ryM7k9IUcQ1VEGY+SgNSHZEVDL4563oLouLIM3YbpZS+z5FSSF2UktZc+dNhWBG43aB/AvaTI5s1V9wHMpKB/gK6DcDAFoi1mMNTP/Ilw1tWaxnAYpPPGzlDrtFRDVHkM/AjfoC3JrwPWb1LBRG5AeKJv4k/M+w8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 22g0i9tqVIbGsmLHUJ2Xig5YLxQoYtEK4DxMU2xoPaDh1AIt6m+BQTyYgP8iPLMmUk5+gfcK4Zo061fRQhshtnVewLjdIG2sYDYSW21RV36ceE6YvNLUhbi9oPUtwURbzBvysYu394B9MemM3dHfcnIBk6BdHX+PNeMkfu22tf43QQCyGY3ttj3ceANKfhSImR0QJ/nHcFrrIBAo9A85RYyF1eZsbKOi3uq1SPOn6w40rNSHN1tlr3WrAkZ3XdWO+bVcSJMOLGYNK0pY1FLkNFXORVgqKiaqOSkyyxEgp1eV9kBJY2jQ09ain+PeOdR1iuMvOM67mvuYNYUgz+HaZmXzlWhDdmkAGsnuTg6T+7fuiqP1qbkUpSzqfct+jKJ3x0OWD1GR51qrWayrAQc6+nd0ws0sio03NNhBtTvo79Nm+q3xDC1HlM3jR8APmwTh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:34.7611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa95ab97-9194-4b36-35d5-08deff9e5034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999152
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

From: Lijo Lazar <lijo.lazar@amd.com>

A workaround sequence which toggles MGCG override is required to enable
hardware MGCG. As this is not the final solution, don't change the CGCG
flags.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 53 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 123fb904f4bf7..beb7d55e14771 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -214,6 +214,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
 					 bool enable, int xcc_id);
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
+static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
+	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
 
 static void gfx_v12_1_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 					uint64_t queue_mask)
@@ -2754,6 +2756,8 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 				return r;
 		}
 
+		gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, false,
+							       xcc_id, true);
 		/* GFX CGCG and LS is disabled by rlc fw */
 		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 
@@ -2787,6 +2791,8 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 			if (r)
 				return r;
 		}
+		gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, true,
+							       xcc_id, true);
 	}
 
 	return 0;
@@ -3381,37 +3387,41 @@ static void gfx_v12_1_xcc_update_coarse_grain_clock_gating(struct amdgpu_device
 	}
 }
 
-static void gfx_v12_1_xcc_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-							   bool enable, int xcc_id)
+static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
+	struct amdgpu_device *adev, bool enable, int xcc_id, bool force)
 {
 	uint32_t data, def;
-	if (!(adev->cg_flags & (AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_MGLS)))
+	bool support_mgcg;
+
+	support_mgcg = force || (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG);
+
+	if (!support_mgcg)
 		return;
 
 	/* It is disabled by HW by default */
 	if (enable) {
-		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
-			/* 1 - RLC_CGTT_MGCG_OVERRIDE */
-			def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
+		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
+		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+					  regRLC_CGTT_MGCG_OVERRIDE);
 
-			data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
-				  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
-				  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
 
-			if (def != data)
-				WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
-		}
+		if (def != data)
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+				     regRLC_CGTT_MGCG_OVERRIDE, data);
 	} else {
-		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
-			def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
+		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+					  regRLC_CGTT_MGCG_OVERRIDE);
 
-			data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
-				 RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
-				 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+		data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+			 RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+			 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
 
-			if (def != data)
-				WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
-		}
+		if (def != data)
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+				     regRLC_CGTT_MGCG_OVERRIDE, data);
 	}
 }
 
@@ -3481,7 +3491,8 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
 
 	gfx_v12_1_xcc_update_coarse_grain_clock_gating(adev, enable, xcc_id);
 
-	gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, enable, xcc_id);
+	gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, enable, xcc_id,
+						       false);
 
 	gfx_v12_1_xcc_update_repeater_fgcg(adev, enable, xcc_id);
 
-- 
2.55.0

