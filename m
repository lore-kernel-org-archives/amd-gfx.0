Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9B2C38142
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 18:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A70E10E376;
	Tue, 31 Jan 2023 18:13:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881C110E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 18:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4vTlvrbViZFqYEItpJSSAVoWUhUJe7ZrsYBCwD/Vw9urhf2vmILWHjC7Nux/77quFFUOpbC9OY3QG3QNrj3Q10RxV7trcq6VQ1qtGHB4HtkHf1WCLxjiS4dLB6tekuCGNLXM8ZcarT/+z4GU0LbdHCN0bmjBMeZABuvPesuWr1kQp0MWlpMEneZcH9schasjwO429yX0HH1aecOAKpJtXq2b2goMtTbNsI0PHLgXwJa0aK4yUbYX5JJrOohf1mAgKkjwQMjImF0kBoacWdE9O/Dprgfpn0zpk4vQQhxuSfbuHdW0DYimS2jhSI5K5TV5VqqyQE8qx2YaNiEG4hlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNRTaWvRcjPGvzCeKB/y8ubA7exF+Yr54bPmVlIaJ84=;
 b=bwf9ws7Nwt6a/mnsgSGxOEMlbq/ZxUmZw1TCn223ZHu4nUeRHBQTZtNfjL2NdEFaLUOAzewjC6+peUDKkIDxwb6ExVtfvCuHv8IWJkCCUJLTiQvmk3TRyrUXxXmhgZfhlsB/kDNLWs9fSJUzI9OSLI0OVSIhQvVQxDxUAbgJuwv+xsmjKUraotAnnJc8jLoJFTdnMw/K0apLwNdKmHojRKwxyC00j1bZy9bzPq2nUQ3GKa23bRDgqxpsOnJ3e8TWm/8GFR6TyCnGwephv1aUohgb6r2+tfSKGve2Aig/0GBHGp1+nEtustPrvFVyKfMt9b52Mj0HhJmYbObXlLTpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNRTaWvRcjPGvzCeKB/y8ubA7exF+Yr54bPmVlIaJ84=;
 b=NAYHSE5r3qM9zn/wxCQOoF2FyxTndtZY3HDnamjl4DCePGnuH/ku9URH9V8TGGrD715DqzYFum4ECx79+W4QEb3k77Jigkr24MFO5q4HZw7tzA3XzUS11B/ZLmFBhDh7ZT6FDJSn5lIdPNy4lw2rnEGua0pyFosMK4msUO31JtU=
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:13:51 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::b) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 18:13:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:13:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] Revert "Revert "drm/amdgpu/gmc11: enable AGP aperture""
Date: Tue, 31 Jan 2023 13:13:25 -0500
Message-ID: <20230131181326.3507396-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131181326.3507396-1-alexander.deucher@amd.com>
References: <20230131181326.3507396-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5066f553-82b4-46c1-bfbb-08db03b6e803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO/VOEon+NvIX3kgQ4gsYBTghM/2e1UUygHKjcPfoRqKpSyJVBd2Xuprd4GvecsqOgBi7vXyD45HmnbwjsToptm0ekEp7oZuCnlaGn26MAL9tMFxQyGAO7i+ygL+dqH8tBO8npq6dnyKLP/is3SoPAXeYvSXsvCe6UiLlMNWCcmMAcfk1mLFaR+GqBZzjeaiFN7igtlklVfXSLjlyZ1XNAoR6YFmfM8pK9RvDZihix2k8e/SmHwax8ggE6tGT9qYvEXQrZsVfoz2p40EB7HkxFo7C60oe2Z5TJ5xGpTamNgOQSV8GKMAy+SeoiIeR2n/QAzgYecG1ALNWD/RAF5wYgI2opuUciROutGWdXH6KD3+sqajczScPgjao9VCrsJEziA+j9GNh9O4g+U1UWI6DtsnYrTAxLA1IuItVhkafXcH9bAY8VBS6o/GZgQC5R2I/RWogZ0zZz/MCAaiB3cDzRdXsf6j67WEM4Vf3HqMZrrVyRmQsHr/KkVSeIYL5mgu+bw69kVjBROUBYK2bCtRe9O+fzoKtgk0Kw1wUsAmVnftLuswMiYt0z4kML9zNjT7/qT1GidWgYpudOnDwbSLV0hwoqw6TgF5MSxMjx4747W/P8eEqhSIi7TFbvuioWbE2KMe/V8xQ0scPaVjLj79EbOq7KuE0lp/04X8tx8ldw+2SvDu6v/XOxqamTwytYxFZ8+SCfq6cNPY97hULIR2YEhB1DaOQiICAO+Kt83v5xc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(6916009)(7696005)(16526019)(26005)(186003)(478600001)(2906002)(8676002)(1076003)(6666004)(8936002)(41300700001)(4326008)(70206006)(70586007)(82740400003)(54906003)(316002)(5660300002)(82310400005)(83380400001)(40480700001)(86362001)(81166007)(2616005)(356005)(426003)(336012)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:13:51.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5066f553-82b4-46c1-bfbb-08db03b6e803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 1a65327a84db5b9081a51ccb1c562083f59bfcec.

This should be resolved so we can re-enable this. Also,
the AGP apeture was bring programmed to 0 on MMHUB 3.0.1
since agp_start and end were not being set.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 6 +++---
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index fa42d1907dfa..7c069010ca9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -151,10 +151,11 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Disable AGP. */
+	/* Program the AGP BAR */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 5e0018fe7e7d..0a31a341aa43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -673,6 +673,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index ae9cd1a4cfee..923fc09bc8fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -177,10 +177,11 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * these regs, and they will be programed at host.
 	 * so skip programing these regs.
 	 */
-	/* Disable AGP. */
+	/* Program the AGP BAR */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 		     adev->gmc.vram_start >> 18);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index c30e40e52fb2..51580302ec42 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -162,10 +162,10 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Disable AGP. */
+	/* Program the AGP BAR */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/*
-- 
2.39.1

