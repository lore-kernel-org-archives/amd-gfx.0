Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D647AC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74257112BE9;
	Mon, 22 Apr 2024 15:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2kvmz1EL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70329112BE8
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0a6FRtwNKj9KMHEurdFrCP0FnG0qZG0waNYMvnJdT4LzEJR4itCJZZ+Mvb43BaemfEahL8GsguYSwABwJEn5KQEcsm6/pMah6YV5AQqfCpYhzQDYUt1dyT7zzj4QJPwSS8Ux2iMcxe5eFKJMHE8nFJkamKWmnbumF72avZFIBgoR2ul7BG0MPuTDC5EYbZNhBvnijBygN1IUrZN+g+UgNm8AtGlSrgjBKlBCCpq9b4WNhGfpx4EAjykR8rfxWQCym1hJMBVQvR0AbKqbi5HtJXwgm1fxDzJlZIWc47qOEg8o7umnnT3aH/7C7g7auzRcm/KW+i9kKvYveMjiV1Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWawQwfTpPSy6l+m5RW2qaHyGSZruxY9dHJPKcvIIIk=;
 b=I8/pvdZW9mehMbPQN8Oc3nruTcac8lgHiOdiTLrh84VwX5+MQ4s5fCJhNI+Ztb93OL3bbohxfhrG4uhuNrdoHU1jmNTdeSwrij79eQyneNVPt487bnZOyFOP9XckdpF8QNpZpYYuUY6zRMoYSH5cfiTCoWlSVKUe3FN1KpzwA2mBWTIxO/DbLOKks+HbGQtqW2WzuM962kPeLtN+aMGJbtd/S60gdqQy6RT5OnmkyTr04NGs+YgP2HY0RyIlRKSiuXT0hCb1FawKM0hZ7CxyIeoz/S+P1dwNDkHSOXZzDwEFMswDUZrXcx+D0oo09+UNrepNglHNwND705EPI0cU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWawQwfTpPSy6l+m5RW2qaHyGSZruxY9dHJPKcvIIIk=;
 b=2kvmz1ELn2JveLOuflBK1nGazkzYDuA8RbdbOlSqekhX4AUKixx35eBistu44osB117hmVji7xQHjyMYJe5aYz0j5CJkeerGmzPkz70TkqX1YVaW9x1nuHzwkEbWDtiKcBGZlGEW00/GDHGDz3WZEt7H7nvX1n07/Qff/2c3g/M=
Received: from PR0P264CA0234.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::30)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 22 Apr
 2024 15:28:50 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10a6:100:1e:cafe::29) by PR0P264CA0234.outlook.office365.com
 (2603:10a6:100:1e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:46 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:40 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 04/37] drm/amd/display: Add some missing HDMI registers for
 DCN3x
Date: Mon, 22 Apr 2024 11:27:13 -0400
Message-ID: <20240422152817.2765349-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc65395-fb91-4377-b76a-08dc62e0e7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SPdVrkzZCAM5Zdg+viM/pikXKuoclj0XuMo89N0HDmIA5+y+wCKQQyvbRn0X?=
 =?us-ascii?Q?VWsyzeQNGpRO1WqgbNzb1VJoUAjiKJjLUlmeLaJOuQoiH4lhLbI4/9p/Y3T4?=
 =?us-ascii?Q?4mrRItnQTRacEGxP5yFgzFNrGYijx8btV3xnp5ddRFqqT+B9gAOFIBwVNT8C?=
 =?us-ascii?Q?W0Z4Njs2ccT/oMafNJBeXNzkHgR9gYUruFZb1tjB0TPQq8BLR2h/XIv1doJx?=
 =?us-ascii?Q?pFZ1y+BPcLya1mLdJ+iz7sCTs+z6oxd/CASzsw2xuqpvsFKGBRHgO0g//4fv?=
 =?us-ascii?Q?2ZMJ0faBRwTiqyUooMZyq3lV0P++EgrZd2iPopfZrzVQZH+eIHbiPqOxVVD2?=
 =?us-ascii?Q?7GIJwlYrwZl2T6BO9fLsmcxw62gkhlqMPI/ODL6ZIBB7xVoPgrCg0FbMCmlS?=
 =?us-ascii?Q?SClRvT3l5WnosapxEF5QQ8EXs729y/HwjEz14qiHs+58ySuiLwD2oQTFJFGo?=
 =?us-ascii?Q?d9vUeQZHdZOyzx4k1Jub0OrsouobW+LMFEuWixyjjhtQ7/2s9OnEbPhas4+1?=
 =?us-ascii?Q?TbsBxA4yUefwWWkgNoQGbXjA7HnnHEX0BhqigraKOkjkSBLZ+zfc14ho2V2K?=
 =?us-ascii?Q?h4/dWycFzDQ8gANfzc7QgjkVi0Gi/lE8kyfIaQw1rWPkrescki6rCzgIpz2T?=
 =?us-ascii?Q?7FAGhmphhUfjBTi0EeAuo8ACSZRF17MMBZAV1MZAlDM6b1DRoB+qbANaQc0l?=
 =?us-ascii?Q?X8nv/1xaKRl0fke02fjBly2yhf5jo595r6onANqI7Xu0+nFzqt3nMMAifFSn?=
 =?us-ascii?Q?Jb7CxkaRHihrJH/HlRbuIZ7nbADBj+rgC02jSA+YokK9gIujXJ64U6Q2Ebnv?=
 =?us-ascii?Q?yIof6fZXdwPizA0yTEr3+5j7vTAJMB75N2S6Bt1eLL9u9SHQxFXB0ButHyu9?=
 =?us-ascii?Q?gMaRhji01nwRUZjqT5ql2JLE/HzT3ItHtGzfPe2+o7up6x17RdevC0yZTAAx?=
 =?us-ascii?Q?MS3azGC52O7TgeLgptTjwOyeZPHInVClpEJ/i3OSUgdFiwi1O5BSH54gGphR?=
 =?us-ascii?Q?mkMevlGB/IadbnYdFuT3sZyRoeyX76ndOLWpRnzhklk/h3BxWbZ4Q+aaNqhI?=
 =?us-ascii?Q?IEYfy9pQhyjqNiHzYtn3SxkqcK44Dhe3LLNXRcUkdaoBaozUwqXj/VZ0QxxZ?=
 =?us-ascii?Q?vzQ6h3rdwgIl0h28RE63KI3lS6Z/Qwz2l3ov05713EGyzLTTntfmAxrpMhjq?=
 =?us-ascii?Q?VFJm1JPYq4n4GkjRYSWljSupB04TeBemVX+Ko8vXtJ/2fteEPs88jLjH+70T?=
 =?us-ascii?Q?CpnIeBWn0QfCMI4iHw81n2XmU0e0Bb8b2axtcpvS0YnSlhXTQjvRwxe7Tiov?=
 =?us-ascii?Q?jPzDRj20VnV+4vGZu5kahf7U3qkYkfO3CpBBIldDvbsLwhHydiUrdhW4HU+d?=
 =?us-ascii?Q?zffsJGjJ8FDThp18C8RgkK5+ehIv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:47.9611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc65395-fb91-4377-b76a-08dc62e0e7c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit add some missing HDMI control registers to DCN3x.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h      |  3 +++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h      |  6 ++++++
 .../drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h    |  4 ++++
 .../drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h   |  5 +++++
 .../drm/amd/include/asic_reg/dcn/dcn_3_1_5_offset.h    |  4 ++++
 .../drm/amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h   | 10 ++++++++++
 6 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
index 08a57ea4591c..3f1da7f3a91c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
@@ -31,6 +31,7 @@
 
 #define DCCG_REG_LIST_DCN30() \
 	DCCG_REG_LIST_DCN2(),\
+	DCCG_SRII(CLOCK_CNTL, HDMICHARCLK, 0),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 4),\
@@ -41,6 +42,8 @@
 
 #define DCCG_MASK_SH_LIST_DCN3(mask_sh) \
 	DCCG_MASK_SH_LIST_DCN2(mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_EN, mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_SRC_SEL, mask_sh),\
 	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
 	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
 	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index e3caaacf7493..e3be0bab4007 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -34,12 +34,14 @@
 	DCCG_SRII(DTO_PARAM, DPPCLK, 1),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 2),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 3),\
+	DCCG_SRII(CLOCK_CNTL, HDMICHARCLK, 0),\
 	SR(PHYASYMCLK_CLOCK_CNTL),\
 	SR(PHYBSYMCLK_CLOCK_CNTL),\
 	SR(PHYCSYMCLK_CLOCK_CNTL),\
 	SR(PHYDSYMCLK_CLOCK_CNTL),\
 	SR(PHYESYMCLK_CLOCK_CNTL),\
 	SR(DPSTREAMCLK_CNTL),\
+	SR(HDMISTREAMCLK_CNTL),\
 	SR(SYMCLK32_SE_CNTL),\
 	SR(SYMCLK32_LE_CNTL),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
@@ -78,6 +80,8 @@
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 3, mask_sh),\
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_EN, mask_sh),\
+	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_SRC_SEL, mask_sh),\
 	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
 	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
 	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
@@ -92,6 +96,8 @@
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK_PIPE1_EN, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK_PIPE2_EN, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK_PIPE3_EN, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_SRC_SEL, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_DTO_FORCE_DIS, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_SRC_SEL, mask_sh),\
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
index e2d1da50f29d..f32649047374 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
@@ -311,6 +311,10 @@
 #define mmPHYESYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
 #define mmPHYFSYMCLK_CLOCK_CNTL                                                                        0x0057
 #define mmPHYFSYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
+#define regHDMICHARCLK0_CLOCK_CNTL                                                                      0x004a
+#define regHDMICHARCLK0_CLOCK_CNTL_BASE_IDX                                                             2
+#define mmHDMICHARCLK0_CLOCK_CNTL                                                                      0x004a
+#define mmHDMICHARCLK0_CLOCK_CNTL_BASE_IDX                                                             2
 
 
 // addressBlock: dce_dc_dccg_dccg_dfs_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
index 112bbac13e14..4005c73c2c9f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
@@ -1189,6 +1189,11 @@
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL__SHIFT                                                0x4
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_EN_MASK                                                       0x00000001L
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL_MASK                                                  0x00000010L
+//HDMICHARCLK0_CLOCK_CNTL
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN__SHIFT                                                       0x0
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL__SHIFT                                                  0x4
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN_MASK                                                         0x00000001L
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL_MASK                                                    0x00000070L
 
 
 // addressBlock: dce_dc_dccg_dccg_dfs_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_offset.h
index 50c34d88c17c..16a69d17bb1e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_offset.h
@@ -213,6 +213,8 @@
 #define regDTBCLK_DTO2_MODULO_BASE_IDX                                                                  2
 #define regDTBCLK_DTO3_MODULO                                                                           0x0022
 #define regDTBCLK_DTO3_MODULO_BASE_IDX                                                                  2
+#define regHDMICHARCLK0_CLOCK_CNTL                                                                      0x004a
+#define regHDMICHARCLK0_CLOCK_CNTL_BASE_IDX                                                             2
 #define regPHYASYMCLK_CLOCK_CNTL                                                                        0x0052
 #define regPHYASYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
 #define regPHYBSYMCLK_CLOCK_CNTL                                                                        0x0053
@@ -233,6 +235,8 @@
 #define regDCCG_AUDIO_DTBCLK_DTO_MODULO_BASE_IDX                                                        2
 #define regDTBCLK_DTO_DBUF_EN                                                                           0x0063
 #define regDTBCLK_DTO_DBUF_EN_BASE_IDX                                                                  2
+#define regHDMISTREAMCLK_CNTL                                                                           0x0059
+#define regHDMISTREAMCLK_CNTL_BASE_IDX                                                                  2
 
 
 // addressBlock: dce_dc_dccg_dccg_dcperfmon0_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h
index 295e0dac9ffa..6473362e39a8 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h
@@ -886,6 +886,11 @@
 //DTBCLK_DTO3_MODULO
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO__SHIFT                                                         0x0
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO_MASK                                                           0xFFFFFFFFL
+//HDMICHARCLK0_CLOCK_CNTL
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN__SHIFT                                                       0x0
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL__SHIFT                                                  0x4
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN_MASK                                                         0x00000001L
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL_MASK                                                    0x00000070L
 //PHYASYMCLK_CLOCK_CNTL
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_EN__SHIFT                                                     0x0
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_SRC_SEL__SHIFT                                                0x4
@@ -911,6 +916,11 @@
 #define PHYESYMCLK_CLOCK_CNTL__PHYESYMCLK_FORCE_SRC_SEL__SHIFT                                                0x4
 #define PHYESYMCLK_CLOCK_CNTL__PHYESYMCLK_FORCE_EN_MASK                                                       0x00000001L
 #define PHYESYMCLK_CLOCK_CNTL__PHYESYMCLK_FORCE_SRC_SEL_MASK                                                  0x00000030L
+//HDMISTREAMCLK_CNTL
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL__SHIFT                                                     0x0
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS__SHIFT                                               0x10
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL_MASK                                                       0x00000003L
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS_MASK                                                 0x00010000L
 //DCCG_GATE_DISABLE_CNTL3
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK0_GATE_DISABLE__SHIFT                                           0x0
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK1_GATE_DISABLE__SHIFT                                           0x1
-- 
2.44.0

