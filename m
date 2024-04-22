Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F332C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D8011218A;
	Mon, 22 Apr 2024 15:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nLwRGnJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A5011218A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfLKOaOP2QbDN20EEmatsn2hYmRmNxG7iWgyISwEi/9OhlSGxGMMSKZsGmG0wCiI21/++gfMplwcJjuOvtpOT1fhYvqD4kG1v3uKoMgjaKzbq9kTwj8zDpRSgKk0VtymGLCfimqgGKgJtQjQBB2MGp8jdCnaxL4WkdDEh63uhwPIyGsmtwlYchdA8WlsUd0l+vqUNma9pc3zSz6qLxetoOdmBYrv0bIZ3L+8n6eOm/MHUzvE3K+WEjNZauy08viE4Bvn20I70THb/VVcQoEayhjht1YdXottSsUxcvbR5AM879bnvKaUkPYFLeR1uDjW2ET3/IYv/2RBBTNXOvFjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq49H3aQfW0jekzfO/tXa1PmXPP783qzkCgyPCbk240=;
 b=PFRM/iAvHkvfp8ToWa1YlzVRy/+GWOG6L5Luww3SwJaSQeZ5O2kuhAT1f9iVHcqxZ/03AzO1FJvQwcOHN9uHa2sBTuzOc1rrp4cVh90zCeN798Ts1U4LxxTP6ny11Zq4MWwetBivPm76fKdDgsXQh6546dTWbXmOxIju76F9j5vGB1SbulFaHWbHbuWM93xjoiyNkO28AnKZv6QHXLFg+PbirWDkttcerWbXMAaSoHh63Ww8hFROsMdL2C239Lsp+6VYyRodKJldWXPdPFdLjJqigdx+K5aqY43/bJqhfq21ro/2oZGsAHclHin4tdeST31XIEshUNVRnx3jd5w8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq49H3aQfW0jekzfO/tXa1PmXPP783qzkCgyPCbk240=;
 b=2nLwRGnJi3k7rf5XIjBA+POvzqDKKLTu7rFD9AcEDghsSXSREXp62LTuqof2n+FAT1u7YCWiMqynlOW77JtIijIHmbf2U1uvWNfcm0qCaG62Q+KiYKNnsdRXyIGf3s3LC119xi2emCgxcmOoeSqH+SIcYRcd9oi2aYrRmi5EYYs=
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:28:32 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::2b) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:28:29 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 01/37] drm/amd/display: Add missing debug registers for
 DCN2/3/3.1
Date: Mon, 22 Apr 2024 11:27:10 -0400
Message-ID: <20240422152817.2765349-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a628e4-5d20-41f2-3bf5-08dc62e0dda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XiFyidJSxzNZAmk5jqGj/OS06MQHhL45vrni8R8jmoPdH7LM+FkF686RECTp?=
 =?us-ascii?Q?cCA306hQ/xyiouACEZGLSJhUg79MCM/kutI48EJgM9xnN8t956nPcisetGWn?=
 =?us-ascii?Q?z5IbNoV49QWKBpJBKymoYzydMDWDjOcgsm8OZQk/KN5QeWHKz0cUypIKP/WD?=
 =?us-ascii?Q?dz5SxFpEdbp55u16Iut4PeD4Kv7m1FitcaokeVrVcQlwilztOMpKoRY4hUC4?=
 =?us-ascii?Q?ip4nEaY+0TEDUupOcN0HJUlxyAv5o6THZLu99XkEMZDjKPksfW+GCaVGTHVd?=
 =?us-ascii?Q?yEmrw78uGxW+QRHMHESUo8lOmy7WhVsqCLNn2A7ij20G3gwIa9iGsqEIXacg?=
 =?us-ascii?Q?rwjvU7AgzyyHtjbOHYlRcjguCkbRr0ftv4KTQT/UCEmKYaGVKJh5Fs03dnqL?=
 =?us-ascii?Q?wJQUbf8XUUMLr3Kt/vNxBnSJRfMNuDZTVTLOQV58eRYDGxl6o784fuq7nxAV?=
 =?us-ascii?Q?GOd9r7cj+9rAD1jIC5PdGX8US8Z+uBRP++y8ClV1SxbFTBZEuQT4WUdcnc9M?=
 =?us-ascii?Q?BEolUk/BTCskl2utsOdTZyT+FuYKIZvBPn9Kya/JBrspndtaqgKF8Je0LA3f?=
 =?us-ascii?Q?q+EQD/Z7YyQ5P8BKYFw61fIe17BAKUI0nQG7nbtjI+zXTwP1fVsc7Bit6+Lm?=
 =?us-ascii?Q?3oCp0kxVnmrfIg6lNwxQdscicpF3MC+Yv8X3TYg1PIHjmFw/siXIsDrLI0Aa?=
 =?us-ascii?Q?jIznGcxZppAqEDalUV1rPwugDQBIRUvpd16+23g0s9QmbZ4qPtQyyb3gMCp8?=
 =?us-ascii?Q?hrAoZwi44tJZNDstKFXRJ+PLnU6malOKvpMyEvgVJRuyG/QNWYvm38/qPQfE?=
 =?us-ascii?Q?OBud2MHelJYI9P0nDJq/JqjXvOGaZWLWOKgBdyDiJonurAUI2odQLl++OeHv?=
 =?us-ascii?Q?GLItP6pHGJmRGpv/SaHkYnTuFfbZ2iyJXT88t6yUTvou0S90mKvwFY1/71fR?=
 =?us-ascii?Q?Eybe/+YH3TGi4iUJs+o+V78Ygj92MHg+yEnbVTmVVHWm7BPyBHtPRv3fSdb2?=
 =?us-ascii?Q?tL83ggmxp/tmreKb+dC7TH90xZEiI8555TYGCO8sZbC2kF4+aqdAQzZ8nygs?=
 =?us-ascii?Q?U6Q8s4y8Y6QYDDKDFiSh7qyRJ1vPZDXYhxSmsTnakHkcyy9BPDXl5EplC3Tz?=
 =?us-ascii?Q?jlo9hQvUV7P+ZstnzAifBjFDQwRxwlzKWttqBqAlm/J7hZbj9KYKHyzP0BTw?=
 =?us-ascii?Q?OWsyAkhFifcMqp0p7L8fSrnyMtF8KInar4w6RQTk5F8QX8CCyUoRasYpTPeJ?=
 =?us-ascii?Q?AhEz8AXXyH4AFrYlgntJffCGwKnXmh0s88P485BcEPEJ26kWtfBvJpfuoB3M?=
 =?us-ascii?Q?Dsu0Dk/1VLkZzyFo5LRo3nRSA/lf9YFBhKAWmYqGzTUPbEcr7JbYZdWI0Bek?=
 =?us-ascii?Q?hxDsa7zmP6f8/6ktB8CX5EsPX186?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:30.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a628e4-5d20-41f2-3bf5-08dc62e0dda5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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

This commit add some missing debug registers for DPCS and RDPC debug.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |  5 +++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |  2 ++
 .../include/asic_reg/dpcs/dpcs_3_0_0_offset.h | 24 +++++++++++++++++++
 .../asic_reg/dpcs/dpcs_3_0_0_sh_mask.h        |  4 +++-
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index b2b266953d18..c34e04cac9a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -147,7 +147,8 @@
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_SWAP, mask_sh),\
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_ORDER_INVERT, mask_sh),\
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_EN, mask_sh),\
-	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_RD_START_DELAY, mask_sh)
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_RD_START_DELAY, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_DEBUG_CONFIG, DPCS_DBG_CBUS_DIS, mask_sh)
 
 #define DPCS_DCN2_MASK_SH_LIST(mask_sh)\
 	DPCS_MASK_SH_LIST(mask_sh),\
@@ -231,6 +232,8 @@
 	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
 	SRI(DPCSTX_TX_CLOCK_CNTL, DPCSTX, id), \
 	SRI(DPCSTX_TX_CNTL, DPCSTX, id), \
+	SRI(DPCSTX_DEBUG_CONFIG, DPCSTX, id), \
+	SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
 	SR(RDPCSTX0_RDPCSTX_SCRATCH)
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
index b5dfd404676a..ee78ba80797c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
@@ -89,6 +89,7 @@
 	SRI(RDPCSTX_PHY_FUSE1, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_FUSE2, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
+	SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
 	SR(RDPCSTX0_RDPCSTX_SCRATCH), \
 	SRI(RDPCSTX_PHY_RX_LD_VAL, RDPCSTX, id),\
 	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
@@ -222,6 +223,7 @@
 	SRI(RDPCSTX_PHY_FUSE1, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_FUSE2, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
+	SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
 	SR(RDPCSTX0_RDPCSTX_SCRATCH), \
 	SRI(RDPCSTX_PHY_RX_LD_VAL, RDPCSTX, id),\
 	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
index 0bb47e06eee8..081e726afbf0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
@@ -24,6 +24,8 @@
 #define mmDPCSTX0_DPCSTX_PLL_UPDATE_ADDR_BASE_IDX                                                      2
 #define mmDPCSTX0_DPCSTX_PLL_UPDATE_DATA                                                               0x292d
 #define mmDPCSTX0_DPCSTX_PLL_UPDATE_DATA_BASE_IDX                                                      2
+#define mmDPCSTX0_DPCSTX_DEBUG_CONFIG                                                                  0x292e
+#define mmDPCSTX0_DPCSTX_DEBUG_CONFIG_BASE_IDX                                                         2
 
 
 // addressBlock: dpcssys_dpcs0_rdpcstx0_dispdec
@@ -50,6 +52,8 @@
 #define mmRDPCSTX0_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define mmRDPCSTX0_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x293c
 #define mmRDPCSTX0_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define mmRDPCSTX0_RDPCSTX_DEBUG_CONFIG                                                                0x293d
+#define mmRDPCSTX0_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define mmRDPCSTX0_RDPCSTX_PHY_CNTL0                                                                   0x2940
 #define mmRDPCSTX0_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define mmRDPCSTX0_RDPCSTX_PHY_CNTL1                                                                   0x2941
@@ -120,6 +124,8 @@
 #define mmDPCSTX1_DPCSTX_PLL_UPDATE_ADDR_BASE_IDX                                                      2
 #define mmDPCSTX1_DPCSTX_PLL_UPDATE_DATA                                                               0x2a05
 #define mmDPCSTX1_DPCSTX_PLL_UPDATE_DATA_BASE_IDX                                                      2
+#define mmDPCSTX1_DPCSTX_DEBUG_CONFIG                                                                  0x2a06
+#define mmDPCSTX1_DPCSTX_DEBUG_CONFIG_BASE_IDX                                                         2
 
 
 // addressBlock: dpcssys_dpcs0_rdpcstx1_dispdec
@@ -146,6 +152,8 @@
 #define mmRDPCSTX1_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define mmRDPCSTX1_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2a14
 #define mmRDPCSTX1_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define mmRDPCSTX1_RDPCSTX_DEBUG_CONFIG                                                                0x2a15
+#define mmRDPCSTX1_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define mmRDPCSTX1_RDPCSTX_PHY_CNTL0                                                                   0x2a18
 #define mmRDPCSTX1_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define mmRDPCSTX1_RDPCSTX_PHY_CNTL1                                                                   0x2a19
@@ -216,6 +224,8 @@
 #define mmDPCSTX2_DPCSTX_PLL_UPDATE_ADDR_BASE_IDX                                                      2
 #define mmDPCSTX2_DPCSTX_PLL_UPDATE_DATA                                                               0x2add
 #define mmDPCSTX2_DPCSTX_PLL_UPDATE_DATA_BASE_IDX                                                      2
+#define mmDPCSTX2_DPCSTX_DEBUG_CONFIG                                                                  0x2ade
+#define mmDPCSTX2_DPCSTX_DEBUG_CONFIG_BASE_IDX                                                         2
 
 
 // addressBlock: dpcssys_dpcs0_rdpcstx2_dispdec
@@ -242,6 +252,8 @@
 #define mmRDPCSTX2_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define mmRDPCSTX2_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2aec
 #define mmRDPCSTX2_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define mmRDPCSTX2_RDPCSTX_DEBUG_CONFIG                                                                0x2aed
+#define mmRDPCSTX2_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define mmRDPCSTX2_RDPCSTX_PHY_CNTL0                                                                   0x2af0
 #define mmRDPCSTX2_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define mmRDPCSTX2_RDPCSTX_PHY_CNTL1                                                                   0x2af1
@@ -312,6 +324,8 @@
 #define mmDPCSTX3_DPCSTX_PLL_UPDATE_ADDR_BASE_IDX                                                      2
 #define mmDPCSTX3_DPCSTX_PLL_UPDATE_DATA                                                               0x2bb5
 #define mmDPCSTX3_DPCSTX_PLL_UPDATE_DATA_BASE_IDX                                                      2
+#define mmDPCSTX3_DPCSTX_DEBUG_CONFIG                                                                  0x2bb6
+#define mmDPCSTX3_DPCSTX_DEBUG_CONFIG_BASE_IDX                                                         2
 
 
 // addressBlock: dpcssys_dpcs0_rdpcstx3_dispdec
@@ -338,6 +352,8 @@
 #define mmRDPCSTX3_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define mmRDPCSTX3_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2bc4
 #define mmRDPCSTX3_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define mmRDPCSTX3_RDPCSTX_DEBUG_CONFIG                                                                0x2bc5
+#define mmRDPCSTX3_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define mmRDPCSTX3_RDPCSTX_PHY_CNTL0                                                                   0x2bc8
 #define mmRDPCSTX3_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define mmRDPCSTX3_RDPCSTX_PHY_CNTL1                                                                   0x2bc9
@@ -408,6 +424,8 @@
 #define mmDPCSTX4_DPCSTX_PLL_UPDATE_ADDR_BASE_IDX                                                      2
 #define mmDPCSTX4_DPCSTX_PLL_UPDATE_DATA                                                               0x2c8d
 #define mmDPCSTX4_DPCSTX_PLL_UPDATE_DATA_BASE_IDX                                                      2
+#define mmDPCSTX4_DPCSTX_DEBUG_CONFIG                                                                  0x2c8e
+#define mmDPCSTX4_DPCSTX_DEBUG_CONFIG_BASE_IDX                                                         2
 
 
 // addressBlock: dpcssys_dpcs0_rdpcstx4_dispdec
@@ -434,6 +452,8 @@
 #define mmRDPCSTX4_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define mmRDPCSTX4_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2c9c
 #define mmRDPCSTX4_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define mmRDPCSTX4_RDPCSTX_DEBUG_CONFIG                                                                0x2c9d
+#define mmRDPCSTX4_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define mmRDPCSTX4_RDPCSTX_PHY_CNTL0                                                                   0x2ca0
 #define mmRDPCSTX4_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define mmRDPCSTX4_RDPCSTX_PHY_CNTL1                                                                   0x2ca1
@@ -504,6 +524,8 @@
 #define mmDPCSTX5_DPCSTX_PLL_UPDATE_ADDR_BASE_IDX                                                      2
 #define mmDPCSTX5_DPCSTX_PLL_UPDATE_DATA                                                               0x2d65
 #define mmDPCSTX5_DPCSTX_PLL_UPDATE_DATA_BASE_IDX                                                      2
+#define mmDPCSTX5_DPCSTX_DEBUG_CONFIG                                                                  0x2d66
+#define mmDPCSTX5_DPCSTX_DEBUG_CONFIG_BASE_IDX                                                         2
 
 
 // addressBlock: dpcssys_dpcs0_rdpcstx5_dispdec
@@ -530,6 +552,8 @@
 #define mmRDPCSTX5_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define mmRDPCSTX5_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2d74
 #define mmRDPCSTX5_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define mmRDPCSTX5_RDPCSTX_DEBUG_CONFIG                                                                0x2d75
+#define mmRDPCSTX5_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define mmRDPCSTX5_RDPCSTX_PHY_CNTL0                                                                   0x2d78
 #define mmRDPCSTX5_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define mmRDPCSTX5_RDPCSTX_PHY_CNTL1                                                                   0x2d79
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
index 23fa1121a967..1f846fa6c1a2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
@@ -70,7 +70,9 @@
 //DPCSTX0_DPCSTX_PLL_UPDATE_DATA
 #define DPCSTX0_DPCSTX_PLL_UPDATE_DATA__DPCS_PLL_UPDATE_DATA__SHIFT                                           0x0
 #define DPCSTX0_DPCSTX_PLL_UPDATE_DATA__DPCS_PLL_UPDATE_DATA_MASK                                             0xFFFFFFFFL
-
+//DPCSTX0_DPCSTX_DEBUG_CONFIG
+#define DPCSTX0_DPCSTX_DEBUG_CONFIG__DPCS_DBG_CBUS_DIS__SHIFT                                                 0xe
+#define DPCSTX0_DPCSTX_DEBUG_CONFIG__DPCS_DBG_CBUS_DIS_MASK                                                   0x00004000L
 
 // addressBlock: dpcssys_dpcs0_rdpcstx0_dispdec
 //RDPCSTX0_RDPCSTX_CNTL
-- 
2.44.0

