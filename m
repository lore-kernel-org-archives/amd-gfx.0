Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D7C83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D6A10E6C7;
	Wed, 30 Jul 2025 19:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VC6xZlxY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C85010E6C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x30543OzfGC0w1jOeWfd15cPAxX2IJHSK1EDkHNddyjZJ2TLib6D1S2bsifc7D53+LPjmIRFadydbp+ZKmGdg91Av+F0IUqK1udydjCrHfjXeHM9U/oH4z1gcggHBZTeJ88vfp+uXjJExNDKKA8++u1s0qKrTQROeNTqnT9jjlUIVPL2cTK4iMGzs5zBf/F42uTThn6ciEr6x+Wtp0mnZoVU+0jUEqJKIGHBW0Cvp1dMjYU+2tgI4r+ia5eH9cEz2KiErS3AEwox6iZdGjWtSKmIEXc6vwB10+QeGlDN/pSMI8qK0KFZDRdW1/Xs9R45Kx0fwGxn066V3E5+VefEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAt1WTBUW+qUcYPlhBwAV/3fvV0aW6q4oqLE7WqBczQ=;
 b=EcmY/Hv5ewsgJAl2QVw7icZcjqhgR/mQBq3bSrbE4guo/9ILm30rVCSXji4OLjpYKST3J+9E8y6f+NaJHqS3IfUUu8KwanDn/A1tZ5yQarazR0Ef/FUK3SFhRXXrt/FQi8EIFZv/Y81AxSMjVvfO+iyxxLHgzg0ZJBMnzkzFSZvQyuPlJzY2cUbC/2tjF2QWQigFUiGMbIAhlDLpiBJK/QSgpy2XHyUoyLD4H78FcXCRaLUTK+//1zFp1OItbCM+mTMD8GDICYRx9xXFBpb8Xtv38Hs580LsMTxJOMid2Rr85zPvI5aT3EqZHcf14l13sRsv8Jx//hS3USCia8KbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAt1WTBUW+qUcYPlhBwAV/3fvV0aW6q4oqLE7WqBczQ=;
 b=VC6xZlxY5kVBwFPHpDIuXsAMJrQc+3f9AeSHsyC/HgwNzPu2VhnF9N93pvjryFNXaPTrZ9T7efCxSsSw37MtfaO5/b2uNxUfpqXK9DjzrLxcXLrDI4kVnjDXk9hV/O5y8u7QZvSomsfcHh6ve1hHulAUJNYIkyzlkTeM/Dcqumo=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 30 Jul
 2025 19:02:04 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::15) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:02:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:01:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jingwen Zhu <Jingwen.Zhu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 08/12] drm/amd/display: limited pll vco w/a v2
Date: Wed, 30 Jul 2025 14:58:59 -0400
Message-ID: <20250730185903.1023256-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: d012bb1e-963b-4e33-4643-08ddcf9b92b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MzyIWTRwkgmwiuOwUjaVPz9OROHgFdpzRbUUIyBKBAvm4ooTzPxrvi9CS1+k?=
 =?us-ascii?Q?gINz17trVnszW7povRCCOadb/iTAbH1oOWRM/DgGlVrgbRBVcwQpQlMcGjy8?=
 =?us-ascii?Q?lbx0KuX0gA3WKuXvET0r0U6SsDgvTca+75/VnWhlKQd4ZiQzTB1w4Dpt1Kzg?=
 =?us-ascii?Q?umpCeZHgNViJcEglOGQzqrhAUvjam2j62c2L0CtAVpvxfXId1ZL5lgW6caU8?=
 =?us-ascii?Q?aXq/dWT15e1El71PtpcEBGN9oyY+ihwna1GNhdDxSvEpuVwTuV0HGp77WUlV?=
 =?us-ascii?Q?pwsIq4qFmZBQdhIyhrWe9I6ttnbqIh2p+rK0WH7OpBpeDkNJV0ylXnkaVuto?=
 =?us-ascii?Q?xfLIcDih3GfwSxSqxdHEZFekL20aO2VpiXCDtotJaaCssVe20wlZZxa2te42?=
 =?us-ascii?Q?Nf2gowDySFNJDhkTdlg5DB+3Gfq6iHVp7J/grZYvhtLyyBCnCRAA+3fWv+VB?=
 =?us-ascii?Q?pHcHcGND9arZw9p1fhUwpGAJFUBzGmyR8yhQu7rbSMFMTDk2N7Q19YIUAdpg?=
 =?us-ascii?Q?zeyUSsf8upyyxmOxL9rprdxwHZvrL5VB1yvgT7ee6qtfa/xdI4FhHJVKuXMO?=
 =?us-ascii?Q?E1t9UIUMM5vZbiP9kA8itDW+2dHG7uXCa11Bx5tr12atwSFqQS0PPlnzsRb0?=
 =?us-ascii?Q?UP0hwK/84/0y6sn5nSGY+TWlLUzDW3xXHDEZWi3cvqT21NGdYtwlp7XGGo2V?=
 =?us-ascii?Q?yaArzFPYaFkIs+QR4C+aaFN4gLTcq9V3gRDcdAhz1Mrf3PzciTL/P26mJ/zx?=
 =?us-ascii?Q?3Sbw6sC1/sDMaMpOlTONpyz+gyL1U5HfOiI5N7P51GDFN3nB9j2vyGAIGt22?=
 =?us-ascii?Q?c9gfcojVUkWLlDTVrZGl8uyyZCAjWZk9gYY8G75e4ZduUF4JfqSIVaOJn653?=
 =?us-ascii?Q?xcfRBHPsuZdSjilE7fm17bmWsgWyqV/fTZsL29STGShttmDjNoQcfScZD3Z6?=
 =?us-ascii?Q?4OrkX7RpRobsA2XcGrBCc9Azgji6l9Nf6UWMcyO9iC9gay5bQ58E2vUSGRsS?=
 =?us-ascii?Q?TEzk1E7IPtkBnSz1Cgm3W9JAfgAprYLPJ0bWL5CA1VWr00/QI8I6H/46Xp3h?=
 =?us-ascii?Q?hv8dOgVff6G6jwNpjwQdUzMTQu82SrVAbd6Kcarn/YBci8gYFvcKU7+8eMjB?=
 =?us-ascii?Q?WOiF1jN5iu21aROrwD28dtbytdQVTL97LtHE9G21nww5a6XRAd6QfwhqRvMn?=
 =?us-ascii?Q?99iun8HpxOU2Rn2pBas/IcssyQlSXSldwkUZdaphsAlIWbnoHQy381Q7NlU9?=
 =?us-ascii?Q?eUrpXeqOB1Gf4np48TNfbaqoTwMC9XyP6yZQyaLA2bKzUBJ+t22LC5uw9FCQ?=
 =?us-ascii?Q?BvpSyLz954LpLo4S7oNqnGBFIZPcMQjCR2lUv0k3BUHNx9r6opC2aeF1dY9n?=
 =?us-ascii?Q?jEN142MsjNfMV9IT2H3jHOqA/USKXn1MGaPCr15QtFR6CvPtpH/pRXiWBa//?=
 =?us-ascii?Q?7+7aheehsCwezaq0GYG1mrsGoMhtYGacXG+z3yewdP5uvTmq06hAwy/YFdMI?=
 =?us-ascii?Q?NpnHJfEEnwidSnd+gL1R2BYzgVYWBj3DABzG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:02:04.4482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d012bb1e-963b-4e33-4643-08ddcf9b92b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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

From: Jingwen Zhu <Jingwen.Zhu@amd.com>

[Why/How]
The w/a will cause reboot black screen issue.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jingwen Zhu <Jingwen.Zhu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 0bafb6710761..87b761ac3135 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -316,6 +316,7 @@ struct dmub_srv_hw_params {
 	bool disable_sldo_opt;
 	bool enable_non_transparent_setconfig;
 	bool lower_hbr3_phy_ssc;
+	bool override_hbr3_pll_vco;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index dcae768c2cf4..79b5b1bb9b93 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -843,7 +843,8 @@ union dmub_fw_boot_options {
 		uint32_t ips_sequential_ono: 1; /**< 1 to enable sequential ONO IPS sequence */
 		uint32_t disable_sldo_opt: 1; /**< 1 to disable SLDO optimizations */
 		uint32_t lower_hbr3_phy_ssc: 1; /**< 1 to lower hbr3 phy ssc to 0.125 percent */
-		uint32_t reserved : 6; /**< reserved */
+		uint32_t override_hbr3_pll_vco: 1; /**< 1 to override the hbr3 pll vco to 0 */
+		uint32_t reserved : 5; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 3f38db752b84..4777c7203b2c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -377,6 +377,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
 	boot_options.bits.power_optimization = params->power_optimization;
 	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
+	boot_options.bits.override_hbr3_pll_vco = params->override_hbr3_pll_vco;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
 
-- 
2.34.1

