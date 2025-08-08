Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AACAC87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 12:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E30510E021;
	Fri,  8 Aug 2025 12:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ohXw/EaQ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F110C10E021
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 12:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfqtGXdLDM/OXkgQCepZ0AIFef05rQtKlrwZxJAva5SO/fyIDzzNPKK7fi7ItGMuAyl4CjPprPOjf8HxstlDKCqSCs1xzTVYChlWIfTbSCkPvwLJRAhLRsKJ8UBY0xAhmoJfsmSE2P/OTeGcQMVj4fHCl54BJsyVx/cw1ZA3fWumLTFdkmrp+3THh4kg75IECf8/NroTA+2IqS54mfOw3D+reQX5GcPYr6nfwEpnplOzEa0C+b23sXbZbShTHW9UB55v2xY5wPPH31DAxboLeHnerBYwptQNTv2qnoP/KPD3xyf3NnD4HVTMLExwv5CUSEJEHZrI6UCzn1w+DiMvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ82YVgdzBs48lN1X1uOuGpw08uL/TPcBsQ7BnvVh1U=;
 b=go4KXcz5E0izZzSuCYqQ3JkK5BWf5j56ZG9MKAVNYfeoO3Q+TE/okqOKATklPzQJqOmdeJdx+rmgmiV24gxPs4pJHDny6OqW8NP2HQoAponn555N1xqXW7JskTRT7n+VTWkX60gL+NKP62u3CGuMMVJSxRNaZ8KorIorIqu3aiOWktJInNqexic6YTU514TBFltMDEOZnL4k6nrqXh7yxwc0sOgoiuXS10D4sYn8p/v6T2jwXK00ryQ85UiupJ4EFGnHMKtG9Z9MozNQsdhzC82t3OkATFfRaECxHSsi2NHsx1x8nYYvEC3F3oHA+PCNwMXDWnahP86DIsF0xTYfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ82YVgdzBs48lN1X1uOuGpw08uL/TPcBsQ7BnvVh1U=;
 b=ohXw/EaQN11ZDGnEJD0hvONPkJD3J0aEgjFpp40cQ1xBaDhggMvzuIzzdoHQuEaWu7Ox8csvcOxLgRuOsphh+oK1JtWOZNnWQ/YWpZXvDRjRhre3YxX2UscFB+Tmtiw1X6n7ke7w/OSgyvyLFLViiMHwuDfOevEE5AJDKUC7l9g=
Received: from CH2PR07CA0042.namprd07.prod.outlook.com (2603:10b6:610:5b::16)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 12:49:14 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::da) by CH2PR07CA0042.outlook.office365.com
 (2603:10b6:610:5b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 12:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 12:49:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 07:49:13 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 8 Aug 2025 07:49:12 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Leo.Liu@amd.com>, Ruili Ji <ruiliji2@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
Date: Fri, 8 Aug 2025 20:48:36 +0800
Message-ID: <20250808124909.1813022-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808124909.1813022-1-Jesse.Zhang@amd.com>
References: <20250808124909.1813022-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 60758be4-ba42-4da7-92e3-08ddd679faa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/1hvWrHLcd9idVAji573cBYolnWhxl+L+Ammb5jSNJVjc6bPX46ltu8rtbcF?=
 =?us-ascii?Q?AjYQnh5ZBh3ox+Uk7WmMtY2utkIvzLBF0bKFZANZlaih0KIdZHiaK1pUGiJ2?=
 =?us-ascii?Q?KTacmHgTJgCP67Cs2zLt5JoR3OYY2jCQfGwanutpe5W7WPHdBLAl7/nplDI+?=
 =?us-ascii?Q?+XQw4P6bG7oGIFsP3cIzAJkVxfQDPiJydlpVG5PciCdztX986CfW38jPX/cw?=
 =?us-ascii?Q?DwkZ4zgloRauFHWaL7knYtx/CTZlo1ONzhCtgW6CzoSM14XfnIi28SSaXhNQ?=
 =?us-ascii?Q?z6tuiG+AKcdPMssVdqKJ26FC+hgrdIEoNZ+/7zU6ci6U4BKw3kt1iKUu6wBg?=
 =?us-ascii?Q?I+AXqWtkQeinwTBbIr2xRpdPRbN7dBtsPlK8pL4JgmjmW7iu15gI7ToYJWBp?=
 =?us-ascii?Q?kOAeyGbNaVNMfcEfMcQTA7KHpARiLshZO26ZdgiIWSV01iWwpYxe6TuMjw7N?=
 =?us-ascii?Q?8qbI23qsa3Yjcr4xz0cV765lev41/5/3ffz0INoxBSEMTVzKGOx3wigQwYr0?=
 =?us-ascii?Q?qaGsi4TC5IxIDsJA2uVsl5YHiNtTbQZgH8YgTpzCidR/YKGGy7rsrOcwSbA3?=
 =?us-ascii?Q?Ia56npne+aROvPwaVia21LkSk52UIqbEpDN5SeXf5yDhbRXbE7GoPPD9p7uD?=
 =?us-ascii?Q?zHa41fwUrNk7VUOxM2bY39Ji6VIVahhV6h/9Qf2pUgUB2Xi9UTGDhd/VVB4T?=
 =?us-ascii?Q?ZboMnJUm9gl64WI9zG0scsul3wKxy+LSn3jxDX4dQG3NGZrwkXRnNBN+0k0V?=
 =?us-ascii?Q?4XJ2bxVyXbBdXm3o0WpDBSP0TZwbMF3F7jBdApuAyo+ZuY1/i+ijpjL5NfyZ?=
 =?us-ascii?Q?51SyRwhySPmxd0TCsEc6JOVd4ypIXmcJODHXhNzbU+EgCDbUptwSBtulFZnG?=
 =?us-ascii?Q?NbOtgFTfvXfrkEIXfjNrlVlvkl17WhiB53DKPrLIMNyeJAEhgHO97Njk2i2V?=
 =?us-ascii?Q?xxaB4X8K1ksGcjQvdQBLUcpnWvwq2vhU6ybRZZT0/cVdZ4n7+REMfrE+rchv?=
 =?us-ascii?Q?07zdxsQPeuNypYfR3136WvUKYBpnqLVuqSYIwkKsF5jWruCUsw3Oj7V6agiS?=
 =?us-ascii?Q?jdgBYlN/Y0rECKa2qPRk4GBL3DxKeqYzIaF0bPaFTtt7500DNP4F7th32rGh?=
 =?us-ascii?Q?V1qC6mWPkbFP5kBvJ3o5++j2YDgUnAdM+iE1dgTUexKWi6ghsugkLrXp0Zfs?=
 =?us-ascii?Q?5ZYVX9bf0Pcwd746FxQBLw264FErWOVPUUMkiAFCtGPofBgdAPZDQ+PNMrsO?=
 =?us-ascii?Q?6qXLd13shK7RYVVNYb5PnJB4pnoTfRks0mwxrd4c4hzyzm7iKUY/uoCh4r4C?=
 =?us-ascii?Q?bOUkH/VYQgiKxTyYPCwpZyJxhVd0V9oovbJoj2tauExdhcJcjAtroskOY7kV?=
 =?us-ascii?Q?DqDnA43ee5owTJWecbVp7A0YUJQ+jGBRdwfb/wvT5HcdBOtLGNo9/0s9Plpe?=
 =?us-ascii?Q?KiwFcK0p7o2D/ZbpI6xT5SPHuBuFXA71LyxGRmpttQKr0rpx9FR3BSm/XluZ?=
 =?us-ascii?Q?rJrAbeeiILj/fwNQDfecahkt4v1He5jMc75a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:49:14.0481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60758be4-ba42-4da7-92e3-08ddd679faa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
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

From: Ruili Ji <ruiliji2@amd.com>

This change reorganizes VCN reset capability detection by:

1. Moving reset mask configuration from sw_init to new late_init phase
2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset support
3. Only setting soft full reset mask as fallback when per-queue reset isn't supported
4. Removing TODO comment now that queue reset support is implemented

The late initialization allows proper evaluation of SMU capabilities after
full system initialization, while maintaining the previous behavior when
per-queue reset isn't available.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 019bd362edb2..55dd86061115 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -134,6 +134,18 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	else
+		adev->vcn.supported_reset =
+			amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	return 0;
+}
+
 static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn4_fw_shared *fw_shared;
@@ -211,10 +223,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->vcn.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1871,6 +1879,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.name = "vcn_v4_0_3",
 	.early_init = vcn_v4_0_3_early_init,
+	.late_init = vcn_v4_0_3_late_init,
 	.sw_init = vcn_v4_0_3_sw_init,
 	.sw_fini = vcn_v4_0_3_sw_fini,
 	.hw_init = vcn_v4_0_3_hw_init,
@@ -2073,6 +2082,7 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 
 	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
 				&vcn_v4_0_3_aca_info, NULL);
+
 	if (r)
 		goto late_fini;
 
-- 
2.49.0

