Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DA5C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C40112309;
	Mon,  6 May 2024 18:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WV5T759x";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FDB11230E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/yeWWpYncaMzh3WV5SbRnJSifM16edCQKnRwIyf+98gI+la66XqMbugUS7Bt9pdaqKijqauVNQClJ+tlOGHsz3925BROVi7k7pm0rfJCYCm8vx7hJHBLBc2yzGKIZMxaYngJy1mpQAH4LE9FDaGlVW2kIpuCMohpZo7UhD1DHzMoRh9gnHnQulflPPqPhCxjROdjc6ynG0yBHeapU7cFAc2pKz1jBcQ8y5kMPPsKN9SRw2/1W8B/0SoAxwFLHndWztcr1F7tCQhjsfB6n4gh6b9h0wNbdhSGIJ74jq6m8jg4MRnU9Qy3XjjQOTa9DTLTyUIxuQZxxx2rsAcgFMn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2e8Ft0CV5eLWlN6GosxQ8zXckp1eL06m/osfEruUCE=;
 b=XzMhEXMIzQSqnS7G5gPyCAVXjCbiSr4cyVMiQxjVrjoIS3+f32TVdtqK/MEugWdDkn5e5Fb+PvCq3kQ1SIDDO0uJ68w4Ynqx9defXxUFzQMPatnhc8IVqTZJNY26a+rsG+aaG7uWXPGAIHlJkue+TV8HHaMnf9qZo2X/v4rfr8aMCNOEOB1Dz5nf+Z8b+QSAj+dQwEE7GUfpDEF6X+H3jVeKfXZC2nHI5yKjfgE9i30metiSLovTPCmUtJAOILvPbsM9rE+hqvXbE83UNNrlg2rww/BX0qHu6zz+Roz3Nlf8BAdr6Fo28uSu0BzPFXlzjGqcaXyipdWurDczjVgX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2e8Ft0CV5eLWlN6GosxQ8zXckp1eL06m/osfEruUCE=;
 b=WV5T759xEqM4BSBeNFZPCGrIlaPapO7O835QniTQ+a4qnJGyQcL9+4DZ53KJbQRG8zMUanUEYrnbutcwID8uALfszPzX8+kkHl6emWCFbGW1CgEQfqRlMPL9Mdf7l7ey5i5MiIi1n6ovaDleIsPZuICehLDSPtq+WRgJiKSYX6M=
Received: from PH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::22)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:46:07 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::4c) by PH0P220CA0004.outlook.office365.com
 (2603:10b6:510:d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:46:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 13/14] drm/amdgpu/nv: use common nbio callback to set remap
 offset
Date: Mon, 6 May 2024 14:45:38 -0400
Message-ID: <20240506184539.1669157-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 616f6018-a1bc-4bc3-b985-08dc6dfcca50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kGGAd8zm1cPeqhBkeGXhlO5aTIWa06meKcLa7dCOS19RpDvK4hEF8y1Q0tZ6?=
 =?us-ascii?Q?VrXdJCikzNWbhmQNJ/VRFUoVXQ75uLSZlnYfimSTynasaXB2mg/8bMisRSoZ?=
 =?us-ascii?Q?i4Z20aq+2k6dIF2eBZd1Yz6DNR3PVQKsiXSIqqw4VWjKGLulv2jkkI9q09Km?=
 =?us-ascii?Q?lTuacoaJshkxunyDHGINoXl7f71ezZexi4HXeAN+SGOz7/tTCrbxQPMIxPcj?=
 =?us-ascii?Q?WAbHnS4+e4lMAPDd6sNdkbL8TB+4EVZJpyvQpleY8GRG0l0RCwwwfr4fKI16?=
 =?us-ascii?Q?NGnGcQlDoVFbWJQi4Zan4nbyrdoyUarq2j/1g0Kjxiqivrt2b8IL2fNO1vF4?=
 =?us-ascii?Q?3y+gaY0h0iO7YHuU13Jxs2Vjx770tEjOdcAxWwiuFbnBq0j5+pDUs1FIUpBP?=
 =?us-ascii?Q?fw7S6zFoeKSBuu8hXVO3nUo//sBjqV4Fd1+eLTZWcZpb58OnluAfADylZjm7?=
 =?us-ascii?Q?kvjVdbQIa29KW/QO2+gKtyXoCexEX431nvTKUeQVdJEMM0XAzKVt66yuogVW?=
 =?us-ascii?Q?c8KDsXeGRUBQ3FUJvZQKQCmLFvc3wYf+y+7plkho8OxdCEFfE/Utn1e9JWRR?=
 =?us-ascii?Q?JU8evmOQDCpHVSaqiExtrveUXRNsn6CYpe/Nf2OsnBoUFriENrjBXEyzfBcR?=
 =?us-ascii?Q?yKkR3oP/LjbyeHsoCq9r0Ygu09x5y+HwRp0HvszBRNg+RGe/jl6x8e/VsC/v?=
 =?us-ascii?Q?tTTWEOkrKXpp7KqklZ1M5kSNh+FgYsuS5hIsdkqn42MaAVb89dEyIywfBkM5?=
 =?us-ascii?Q?4kmVZwAB89uiC9iCXz8LW+4RWATCr9FH+9+M7MnlxydXjsMT1v3ERs+Gem4S?=
 =?us-ascii?Q?UbaIN+Fih0/DmgP5bkJMo93+mBgNAyrUvFisi7Gg7tpOi9FjwKIj2LgLk7Vo?=
 =?us-ascii?Q?1RnkxPqkKaq5pKUZ1HtZegW5SJ/1QLha6Qth3d2GH7KG/MMTht4u7aQIkfYU?=
 =?us-ascii?Q?dJqkvJUU10vPyocmKqOKo2HqHbX83zI5R7EdWdRbQIep54ll24W0In2CBFoN?=
 =?us-ascii?Q?sUlEfNXAztjXa35BImx8h+RC2qlS27Sfmy6as72qXuYVn3AlpOte3051LK56?=
 =?us-ascii?Q?NjLWvUSd0rGpEuokEFVEtP+DvVBUuWyNr7Fm8NdUHYrDSP3oWMfyt1VSebBz?=
 =?us-ascii?Q?LMQx3tLZT+bKjTv/Kz+/bfrLxjY8xvIbtS8HC6+aj1ArFLaihxPGFoEimNuh?=
 =?us-ascii?Q?LKeb3qRLPuRFI+/5AbV38AOo3RGs9iInCROQA70b4oOLDd/scusTq2pIdYef?=
 =?us-ascii?Q?/EPkIdG0dMjoogoExgUoi9s8zMa1tRfmHUSr1Z8CuzBvVv9P3Podna0NaK5b?=
 =?us-ascii?Q?MUUKcGTGEgp+oXOB3vq5WVZ7XxFQ9fqqO6L3Q+k1qSbksOV+/J5eXx1VtCrp?=
 =?us-ascii?Q?7Jhwh1QPZi18+IL64u41+U990Ym4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:07.2304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 616f6018-a1bc-4bc3-b985-08dc6dfcca50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

This fixes HDP flushes on systems with non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/nv.c        | 6 +-----
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 41ae0a6f9db86..fa479dfa1ec15 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -339,10 +339,6 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 
 	if (def != data)
 		WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
-
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 52774a096350e..a766e2d90cd00 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -402,10 +402,6 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
 		break;
 	}
-
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 12e54047bf795..7e30a89fe03ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -637,13 +637,9 @@ static const struct amdgpu_asic_funcs nv_asic_funcs = {
 
 static int nv_common_early_init(void *handle)
 {
-#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
-		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
-	}
+	adev->nbio.funcs->set_reg_remap(adev);
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-- 
2.44.0

