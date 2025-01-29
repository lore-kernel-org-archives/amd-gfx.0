Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB0EC0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 03:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE1D10E731;
	Wed, 29 Jan 2025 03:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YMSppg1y";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E910310E730
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 03:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlVtUVeyShWlHjQJ4jbas51cd6M1x4J179jwGkfm43kY4qFW0ivjL9b1IY6yijvWjZIueb9i9Bm6VlVDQOPPbEvyO5CG4rw7mzDifghAgHlTMw7blI1/ZfrYs0gDeAVf8ybbWQvSXrklZ2AZtz5F2lPtWL10mD3x+gn+P80W7Dz/Xb/J8SKj4XMg8KgK7g41bdyR4ZzOL97Q3ubzV4gd4R1irf2gXRgEyqGe7gSpXdfb1QSCS4NYTDvaZscOG/Y3+9VS+ODE734YukmyHiU74NZBwYgNv44XGx277Mrz1OEGVPvWKkd5qHyaMO0A74hTSSqQ30XRZ2B7mCBliaiYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkutRP6pSmteGhdQKR1fVHicE+0baMFewSa/NwbR/sc=;
 b=L2+1t0TFGtU0WkommZC35tnd1aqKlOxhsngXcsiiwg1V8wvzOHc7cDwid+1oGIbXqyBbFdn0DARp8aTFkRPs5SbvyaFmZpf8FLk8eldREJT6gWsYahEq45haUQfR2N4K2B0vCjVqlACowDgOpRNTz5Q8HnaW553FWtGZ0RRD0W2cE8CloOJgjvifTT/zifMyXu1eKx0Yt9J/OgujlBxLU3kPykKkZc6iIMuT6gpS2hqKgrpKGRD5SYJpnrc+3UV87AkD2z1ELV+7+2iq/O5aa4MVpemvJE3eGPIcCLMoLrc2PMIz6d8HcKN3MgtrADearohjexPhBOB5x+jEQhS5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkutRP6pSmteGhdQKR1fVHicE+0baMFewSa/NwbR/sc=;
 b=YMSppg1yonOuMHeRLpzUCCBerqr2/fNscBtVO7JfmvU19xAYBfDZiUh7RiTaP62HtcI00sD9aanBiTipYuryIVWkZIjI0+GpxHwT39NEp4PHbhxypP/gi1pwxLQoH/lzrEiN6BJl+gNTAQeXRuWKA72QZjjvQH5BHbPMtAIzaC0=
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 03:06:13 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::f0) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 03:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 03:06:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 21:06:09 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Dmytro
 <dmytro.laktyushkin@amd.com>, Charlene Liu <charlene.liu@amd.com>, "Charlene
 Liu" <Charlene.Liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/10] drm/amd/display: Allow reuse of of DCN4x code
Date: Tue, 28 Jan 2025 20:04:46 -0700
Message-ID: <20250129030453.2129085-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129030453.2129085-1-alex.hung@amd.com>
References: <20250129030453.2129085-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0cda01-983f-4fe8-5b4f-08dd4011e36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nMozPADel/YhxeMzfSJ7IcTyJ1KsL2v0i8FKWfx9O6y9D4yvUHghIj3RSJbY?=
 =?us-ascii?Q?DW3uNrTfZByV6pbwzkKzoQ8iiDbrD+us7aFSNBLfh8w/jIpwdmdG2j2+vQHh?=
 =?us-ascii?Q?GOcFqjXliujPnC86fjTEiEixbMbJs4n/FvC+YLG4ziKcOyga0OEiFl8FYd9e?=
 =?us-ascii?Q?nWxaQ8J//IHpVM+hWPvjuu7p4Rqp8cURLO8VZAUMR72ogN+iguBUEhAvDtBl?=
 =?us-ascii?Q?elajzmFVC7njghq3TnaajaL6VoamLdjsLYWPFm+re8wrSsn1IVGImWjwJ2T7?=
 =?us-ascii?Q?LIZgQMbfBc4k29OiNas2elpQhyqNOpzdm1fvEkW+fifs9zsuHfxsR8056gE/?=
 =?us-ascii?Q?oqM64YmVWJse4QCJoDtybjglieX6MATGrG/DeZdJX5TVW3YT9Fds8NNinv4j?=
 =?us-ascii?Q?HGplWcMwW1FtPJjOsigDCaZJE5fzm60qIqf//iawz1+ygogYsXu0j2ClcCo4?=
 =?us-ascii?Q?NxTE8gTAUSGe0xwDok8v/CkgHA5XXjUDZAhmYBwDesH49kCCS5mOq090pisN?=
 =?us-ascii?Q?J89wN41m157r7ff/bF/zS19r8CywgQrHue/kjaJ+64BjTZG1ANknB/9BvTPt?=
 =?us-ascii?Q?EVaI7VSNTLZKZ9eQJPC6Z1tBqwxB+I+4rLDCXAfSVhnO6phPCACjbmE8xJKR?=
 =?us-ascii?Q?jpU2Ey4IDQYE42sQy+MC4ng14FMVDFUXX4NlDPU++rE2srzqpLJ/+pyKpykD?=
 =?us-ascii?Q?gKa1CL4YxDrK/EeeYSzRBFDyiQyv40kdb6w95EVa4xC7ZOSA2LxmXbSYwRLL?=
 =?us-ascii?Q?Jije9AvxHBW/hC/yDTdBE2xoKUJKZ+6QldjvhNIXmFil080vfW36TUcLpF/o?=
 =?us-ascii?Q?4WMa0H/Yk+nvvYaHz73XmjAlW1fOb9P13SREmQxRRsChld6zAwtFAkKg8IZI?=
 =?us-ascii?Q?K8rd9pxrwgLHdkSe+ZhXFAf4Qkzx/czL/keS7njwEpgGTbnnk8VBAs1SmhLP?=
 =?us-ascii?Q?XOVnOxiLl6Abb2H781V4qFN4VQUjfYdXiA3WVMJnVftvAjPa+2XWvzi1BDSX?=
 =?us-ascii?Q?SNLBabZYxc2abOZZ4c4VUTZxO8VmjdA6vV+oYQTeNZLI7NU4iv9NOd1zN3ql?=
 =?us-ascii?Q?ovRbEe6oeyx73gw38vukpTr2v/gu+ZrBr2ZrmaSzKMqjyqS0BniuQJHRxNs8?=
 =?us-ascii?Q?PaYz70as4sqbyTPivp7FFpsFvZQgmjW8WfvvTfWh3MSgoGOXmngOBVIv53OK?=
 =?us-ascii?Q?BjQjIOM3zKLB4x6kLFDNSEI4KsUn8q/BEDlIVgwXaoTqrOM0CYYI9ldzE2Uc?=
 =?us-ascii?Q?U+W/U7rRNzSxz99uCgoygRKSPd46w+4jwJ1NszdzvWzyQWmZEM4FFmt2Gd6R?=
 =?us-ascii?Q?XUOVXlqyqW9NnhcpWwVSAXQtq4KHPNKYgzmWP+8PC2J/oeF4oMk4sfy7Az3J?=
 =?us-ascii?Q?3SpQaS86am/gG9nZr6QpB7RUQwIsL2mxl42NjsL43KSVwYAbwrzJdrJgTaX3?=
 =?us-ascii?Q?k2CFHY5bMfFRmwiiL0PplRXBpWxMzkxkQhR62tXuM1s3fkHZZmXSI9jA8gff?=
 =?us-ascii?Q?j5to0JebeN0fNPg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 03:06:12.9066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0cda01-983f-4fe8-5b4f-08dd4011e36c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
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

From: Dmytro <dmytro.laktyushkin@amd.com>

Remove the static qualifier to make it available for code sharing
with other components.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro <dmytro.laktyushkin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 24 +++++------
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  | 40 ++++++++++++++++++-
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c   |  2 +-
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.h   |  6 ++-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c | 12 +++---
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h | 18 +++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  5 ++-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    | 19 +++------
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |  7 ++++
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c  |  2 +-
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h  |  1 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    | 14 +++----
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    | 16 ++++++++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  5 +--
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  2 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.h    |  1 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  8 ++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  3 +-
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |  2 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |  2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  4 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  5 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 14 +++++--
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 22 +++++-----
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  | 19 +++++++++
 26 files changed, 188 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index d3e46c3cfa57..332094ad2b05 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -116,7 +116,7 @@ static void dccg401_wait_for_dentist_change_done(
 	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
 }
 
-static void dccg401_get_pixel_rate_div(
+void dccg401_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
 		uint32_t *tmds_div,
@@ -154,7 +154,7 @@ static void dccg401_get_pixel_rate_div(
 	*tmds_div = val_tmds_div == 0 ? PIXEL_RATE_DIV_BY_2 : PIXEL_RATE_DIV_BY_4;
 }
 
-static void dccg401_set_pixel_rate_div(
+void dccg401_set_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
 		enum pixel_rate_div tmds_div,
@@ -209,7 +209,7 @@ static void dccg401_set_pixel_rate_div(
 }
 
 
-static void dccg401_set_dtbclk_p_src(
+void dccg401_set_dtbclk_p_src(
 		struct dccg *dccg,
 		enum streamclk_source src,
 		uint32_t otg_inst)
@@ -348,7 +348,7 @@ void dccg401_set_physymclk(
 	}
 }
 
-static void dccg401_get_dccg_ref_freq(struct dccg *dccg,
+void dccg401_get_dccg_ref_freq(struct dccg *dccg,
 		unsigned int xtalin_freq_inKhz,
 		unsigned int *dccg_ref_freq_inKhz)
 {
@@ -378,7 +378,7 @@ static void dccg401_otg_drop_pixel(struct dccg *dccg,
 			OTG_DROP_PIXEL[otg_inst], 1);
 }
 
-static void dccg401_enable_symclk32_le(
+void dccg401_enable_symclk32_le(
 		struct dccg *dccg,
 		int hpo_le_inst,
 		enum phyd32clk_clock_source phyd32clk)
@@ -429,7 +429,7 @@ static void dccg401_enable_symclk32_le(
 	}
 }
 
-static void dccg401_disable_symclk32_le(
+void dccg401_disable_symclk32_le(
 		struct dccg *dccg,
 		int hpo_le_inst)
 {
@@ -574,7 +574,7 @@ static void dccg401_disable_dpstreamclk(struct dccg *dccg, int dp_hpo_inst)
 	}
 }
 
-static void dccg401_set_dpstreamclk(
+void dccg401_set_dpstreamclk(
 		struct dccg *dccg,
 		enum streamclk_source src,
 		int otg_inst,
@@ -587,7 +587,7 @@ static void dccg401_set_dpstreamclk(
 		dccg401_enable_dpstreamclk(dccg, otg_inst, dp_hpo_inst);
 }
 
-static void dccg401_set_dp_dto(
+void dccg401_set_dp_dto(
 		struct dccg *dccg,
 		const struct dp_dto_params *params)
 {
@@ -727,7 +727,7 @@ void dccg401_init(struct dccg *dccg)
 	}
 }
 
-static void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst)
+void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -763,7 +763,7 @@ static void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst)
 	}
 }
 
-static void dccg401_set_ref_dscclk(struct dccg *dccg,
+void dccg401_set_ref_dscclk(struct dccg *dccg,
 				uint32_t dsc_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -798,7 +798,7 @@ static void dccg401_set_ref_dscclk(struct dccg *dccg,
 	}
 }
 
-static void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -834,7 +834,7 @@ static void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 	}
 }
 
-static void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
index a196ce9e8127..b9905c73e754 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
@@ -193,10 +193,48 @@
 void dccg401_init(struct dccg *dccg);
 
 void dccg401_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk);
-
+void dccg401_get_dccg_ref_freq(struct dccg *dccg,
+		unsigned int xtalin_freq_inKhz,
+		unsigned int *dccg_ref_freq_inKhz);
+void dccg401_set_dpstreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		int otg_inst,
+		int dp_hpo_inst);
+void dccg401_enable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst,
+		enum phyd32clk_clock_source phyd32clk);
+void dccg401_disable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst);
+void dccg401_set_ref_dscclk(struct dccg *dccg,
+				uint32_t dsc_inst);
 void dccg401_set_src_sel(
 	struct dccg *dccg,
 	const struct dtbclk_dto_params *params);
+void dccg401_set_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div tmds_div,
+		enum pixel_rate_div unused);
+void dccg401_get_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		uint32_t *tmds_div,
+		uint32_t *dp_dto_int);
+void dccg401_set_dp_dto(
+		struct dccg *dccg,
+		const struct dp_dto_params *params);
+void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
+void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
+
+void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst);
+void dccg401_set_dtbclk_p_src(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst);
+
 
 struct dccg *dccg401_create(
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
index 425b830b88d2..e93be7b6d9b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
@@ -47,7 +47,7 @@
 	enc1->base.ctx
 
 
-static void enc3_update_hdmi_info_packet(
+void enc3_update_hdmi_info_packet(
 	struct dcn10_stream_encoder *enc1,
 	uint32_t packet_index,
 	const struct dc_info_packet *info_packet)
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.h
index 06310973ded2..830ce7e47035 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.h
@@ -322,6 +322,10 @@ void enc3_dp_set_dsc_pps_info_packet(
 	struct stream_encoder *enc,
 	bool enable,
 	uint8_t *dsc_packed_pps,
-    bool immediate_update);
+	bool immediate_update);
+void enc3_update_hdmi_info_packet(
+	struct dcn10_stream_encoder *enc1,
+	uint32_t packet_index,
+	const struct dc_info_packet *info_packet);
 
 #endif /* __DC_DIO_STREAM_ENCODER_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 098c2a01a850..334fb5e2c003 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -60,7 +60,7 @@ static void enc401_dp_set_odm_combine(
 }
 
 /* setup stream encoder in dvi mode */
-static void enc401_stream_encoder_dvi_set_stream_attribute(
+void enc401_stream_encoder_dvi_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link)
@@ -229,7 +229,7 @@ static void enc401_stream_encoder_hdmi_set_stream_attribute(
 	REG_UPDATE(HDMI_GC, HDMI_GC_AVMUTE, 0);
 }
 
-static void enc401_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
+void enc401_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
@@ -260,7 +260,7 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-static void enc401_stream_encoder_dp_unblank(
+void enc401_stream_encoder_dp_unblank(
 		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param)
@@ -376,7 +376,7 @@ static void enc401_stream_encoder_dp_unblank(
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
  * into a dcn_dsc_state struct.
  */
-static void enc401_read_state(struct stream_encoder *enc, struct enc_state *s)
+void enc401_read_state(struct stream_encoder *enc, struct enc_state *s)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
@@ -394,7 +394,7 @@ static void enc401_read_state(struct stream_encoder *enc, struct enc_state *s)
 	}
 }
 
-static void enc401_stream_encoder_enable(
+void enc401_stream_encoder_enable(
 	struct stream_encoder *enc,
 	enum signal_type signal,
 	bool enable)
@@ -704,7 +704,7 @@ void enc401_stream_encoder_dp_set_stream_attribute(
 		DP_SST_SDP_SPLITTING, enable_sdp_splitting);
 }
 
-static void enc401_stream_encoder_map_to_link(
+void enc401_stream_encoder_map_to_link(
 		struct stream_encoder *enc,
 		uint32_t stream_enc_inst,
 		uint32_t link_enc_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
index d751839598f8..25cc8f72d8d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
@@ -214,4 +214,22 @@ void enc401_stream_encoder_dp_set_stream_attribute(
 	enum dc_color_space output_color_space,
 	bool use_vsc_sdp_for_colorimetry,
 	uint32_t enable_sdp_splitting);
+void enc401_stream_encoder_dvi_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	bool is_dual_link);
+void enc401_stream_encoder_dp_unblank(
+		struct dc_link *link,
+		struct stream_encoder *enc,
+		const struct encoder_unblank_param *param);
+void enc401_stream_encoder_enable(
+	struct stream_encoder *enc,
+	enum signal_type signal,
+	bool enable);
+void enc401_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container);
+void enc401_stream_encoder_map_to_link(
+		struct stream_encoder *enc,
+		uint32_t stream_enc_inst,
+		uint32_t link_enc_inst);
+void enc401_read_state(struct stream_encoder *enc, struct enc_state *s);
 #endif /* __DC_DIO_STREAM_ENCODER_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 68b882d28195..556a780466ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -785,7 +785,10 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
-	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version == DCN_VERSION_4_01))
+	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
+	if ((in_dc->debug.using_dml21)
+			&& (in_dc->ctx->dce_version == DCN_VERSION_4_01
+				))
 		return dml21_create(in_dc, dml2, config);
 
 	// Allocate Mode Lib Ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 61678b0a5a1e..4893b793fec0 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -16,14 +16,7 @@ static void dsc_write_to_registers(struct display_stream_compressor *dsc, const
 
 /* Object I/F functions */
 //static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
-static void dsc401_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
-static bool dsc401_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
-static void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
-		struct dsc_optc_config *dsc_optc_cfg);
 //static bool dsc401_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps);
-static void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe);
-static void dsc401_disable(struct display_stream_compressor *dsc);
-static void dsc401_disconnect(struct display_stream_compressor *dsc);
 static void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
 static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 
@@ -117,7 +110,7 @@ static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clo
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
  * into a dcn_dsc_state struct.
  */
-static void dsc401_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s)
+void dsc401_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
 
@@ -134,7 +127,7 @@ static void dsc401_read_state(struct display_stream_compressor *dsc, struct dcn_
 }
 
 
-static bool dsc401_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg)
+bool dsc401_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg)
 {
 	struct dsc_optc_config dsc_optc_cfg;
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
@@ -145,7 +138,7 @@ static bool dsc401_validate_stream(struct display_stream_compressor *dsc, const
 	return dsc_prepare_config(dsc_cfg, &dsc401->reg_vals, &dsc_optc_cfg);
 }
 
-static void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg)
 {
 	bool is_config_ok;
@@ -160,7 +153,7 @@ static void dsc401_set_config(struct display_stream_compressor *dsc, const struc
 	dsc_write_to_registers(dsc, &dsc401->reg_vals);
 }
 
-static void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe)
+void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
 	int dsc_clock_en;
@@ -185,7 +178,7 @@ static void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe)
 }
 
 
-static void dsc401_disable(struct display_stream_compressor *dsc)
+void dsc401_disable(struct display_stream_compressor *dsc)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
 	int dsc_clock_en;
@@ -211,7 +204,7 @@ static void dsc401_wait_disconnect_pending_clear(struct display_stream_compresso
 	REG_WAIT(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN_STATUS, 0, 2, 50000);
 }
 
-static void dsc401_disconnect(struct display_stream_compressor *dsc)
+void dsc401_disconnect(struct display_stream_compressor *dsc)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
index 3c9fa8988974..e3ca70058e64 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
@@ -334,5 +334,12 @@ void dsc401_construct(struct dcn401_dsc *dsc,
 
 void dsc401_set_fgcg(struct dcn401_dsc *dsc401, bool enable);
 
+void dsc401_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
+bool dsc401_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
+void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+		struct dsc_optc_config *dsc_optc_cfg);
+void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe);
+void dsc401_disable(struct display_stream_compressor *dsc);
+void dsc401_disconnect(struct display_stream_compressor *dsc);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c
index 8af01f579690..de3ec4fcade2 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c
@@ -41,7 +41,7 @@
 #define CTX \
 	enc3->base.ctx
 
-static bool dcn32_hpo_dp_link_enc_is_in_alt_mode(
+bool dcn32_hpo_dp_link_enc_is_in_alt_mode(
 		struct hpo_dp_link_encoder *enc)
 {
 	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
index 176b1537d2a1..48ef3d29b370 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
@@ -54,6 +54,7 @@
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_VC_RATE_CNTL0, STREAM_VC_RATE_Y, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_UPDATE, SAT_UPDATE, mask_sh)
 
+bool dcn32_hpo_dp_link_enc_is_in_alt_mode(struct hpo_dp_link_encoder *enc);
 void hpo_dp_link_encoder32_construct(struct dcn31_hpo_dp_link_encoder *enc31,
 	struct dc_context *ctx,
 	uint32_t inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index dce7269959ce..6d41953011f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -46,7 +46,7 @@
 
 #define DCN35_CRB_SEGMENT_SIZE_KB 64
 
-static void dcn35_init_crb(struct hubbub *hubbub)
+void dcn35_init_crb(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -71,7 +71,7 @@ static void dcn35_init_crb(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x5FF);
 }
 
-static void dcn35_program_compbuf_size(struct hubbub *hubbub, unsigned int compbuf_size_kb, bool safe_to_increase)
+void dcn35_program_compbuf_size(struct hubbub *hubbub, unsigned int compbuf_size_kb, bool safe_to_increase)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	unsigned int compbuf_size_segments = (compbuf_size_kb + DCN35_CRB_SEGMENT_SIZE_KB - 1) / DCN35_CRB_SEGMENT_SIZE_KB;
@@ -255,7 +255,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 	return wm_pending;
 }
 
-static void hubbub35_get_dchub_ref_freq(struct hubbub *hubbub,
+void hubbub35_get_dchub_ref_freq(struct hubbub *hubbub,
 		unsigned int dccg_ref_freq_inKhz,
 		unsigned int *dchub_ref_freq_inKhz)
 {
@@ -295,7 +295,7 @@ static void hubbub35_get_dchub_ref_freq(struct hubbub *hubbub,
 }
 
 
-static bool hubbub35_program_watermarks(
+bool hubbub35_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -335,7 +335,7 @@ static bool hubbub35_program_watermarks(
 }
 
 /* Copy values from WM set A to all other sets */
-static void hubbub35_init_watermarks(struct hubbub *hubbub)
+void hubbub35_init_watermarks(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t reg;
@@ -397,7 +397,7 @@ static void hubbub35_init_watermarks(struct hubbub *hubbub)
 
 }
 
-static void hubbub35_wm_read_state(struct hubbub *hubbub,
+void hubbub35_wm_read_state(struct hubbub *hubbub,
 		struct dcn_hubbub_wm *wm)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -514,7 +514,7 @@ static void hubbub35_set_fgcg(struct dcn20_hubbub *hubbub2, bool enable)
 	REG_UPDATE(DCHUBBUB_CLOCK_CNTL, DCHUBBUB_FGCG_REP_DIS, !enable);
 }
 
-static void hubbub35_init(struct hubbub *hubbub)
+void hubbub35_init(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	/*Enable clock gaters*/
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
index 54cf00ffceb8..23fecf88556c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
@@ -152,4 +152,20 @@ void hubbub35_construct(struct dcn20_hubbub *hubbub2,
 	int det_size_kb,
 	int pixel_chunk_size_kb,
 	int config_return_buffer_size_kb);
+
+void hubbub35_wm_read_state(struct hubbub *hubbub,
+	struct dcn_hubbub_wm *wm);
+void hubbub35_get_dchub_ref_freq(struct hubbub *hubbub,
+	unsigned int dccg_ref_freq_inKhz,
+	unsigned int *dchub_ref_freq_inKhz);
+bool hubbub35_program_watermarks(
+	struct hubbub *hubbub,
+	union dcn_watermark_set *watermarks,
+	unsigned int refclk_mhz,
+	bool safe_to_lower);
+void hubbub35_init_watermarks(struct hubbub *hubbub);
+void dcn35_program_compbuf_size(struct hubbub *hubbub,
+	unsigned int compbuf_size_kb, bool safe_to_increase);
+void dcn35_init_crb(struct hubbub *hubbub);
+void hubbub35_init(struct hubbub *hubbub);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 6968087a3605..62369be070ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -280,9 +280,8 @@
 	type MCACHEID_MALL_PREF_1H_P0;\
 	type MCACHEID_MALL_PREF_2H_P0;\
 	type MCACHEID_MALL_PREF_1H_P1;\
-	type MCACHEID_MALL_PREF_2H_P1
-
-
+	type MCACHEID_MALL_PREF_2H_P1;\
+	type HUBP_FGCG_REP_DIS
 
 struct dcn_hubp2_registers {
 	DCN401_HUBP_REG_COMMON_VARIABLE_LIST;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index 5661d7a80d54..6d060ba12da8 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -45,7 +45,7 @@ void hubp35_set_fgcg(struct hubp *hubp, bool enable)
 	REG_UPDATE(HUBP_CLK_CNTL, HUBP_FGCG_REP_DIS, !enable);
 }
 
-static void hubp35_init(struct hubp *hubp)
+void hubp35_init(struct hubp *hubp)
 {
 	hubp3_init(hubp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
index d913f80b3130..934836717f32 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
@@ -72,4 +72,5 @@ void hubp35_program_surface_config(
 	bool horizontal_mirror,
 	unsigned int compat_level);
 
+void hubp35_init(struct hubp *hubp);
 #endif /* __DC_HUBP_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
index 84c8f8707c5d..09049aa3c4f3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
@@ -644,10 +644,18 @@ struct dce_hwseq_registers {
 	uint32_t DPP_TOP0_DPP_CRC_CTRL;
 	uint32_t DPP_TOP0_DPP_CRC_VAL_R_G;
 	uint32_t DPP_TOP0_DPP_CRC_VAL_B_A;
+	uint32_t DPP_TOP0_DPP_CRC_VAL_R;
+	uint32_t DPP_TOP0_DPP_CRC_VAL_G;
+	uint32_t DPP_TOP0_DPP_CRC_VAL_B;
+	uint32_t DPP_TOP0_DPP_CRC_VAL_A;
 	uint32_t MPC_CRC_CTRL;
 	uint32_t MPC_CRC_RESULT_GB;
 	uint32_t MPC_CRC_RESULT_C;
 	uint32_t MPC_CRC_RESULT_AR;
+	uint32_t MPC_CRC_RESULT_R;
+	uint32_t MPC_CRC_RESULT_G;
+	uint32_t MPC_CRC_RESULT_B;
+	uint32_t MPC_CRC_RESULT_A;
 	uint32_t D1VGA_CONTROL;
 	uint32_t D2VGA_CONTROL;
 	uint32_t D3VGA_CONTROL;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index dec732c0c59c..b158eb1045a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2778,7 +2778,8 @@ void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		if (is_two_pixels_per_container || params.opp_cnt > 1)
 			params.timing.pix_clk_100hz /= 2;
-		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
+		if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine)
+			pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
 				pipe_ctx->stream_res.stream_enc, params.opp_cnt > 1);
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index ee4de9ddfef4..dd46db67d033 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1322,7 +1322,8 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 			params.timing.pix_clk_100hz /= 2;
 			params.pix_per_cycle = 2;
 		}
-		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
+		if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine)
+			pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
 				pipe_ctx->stream_res.stream_enc, params.pix_per_cycle > 1);
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
index eab196c57c6c..2d4b7a85847d 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
@@ -50,5 +50,5 @@ MMHUBBUB_DCN35 = dcn35_mmhubbub.o
 AMD_DAL_MMHUBBUB_DCN35 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn35/,$(MMHUBBUB_DCN35))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN35)
-
 endif
+
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/Makefile b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
index 5402c3529f5e..1e2e66508192 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
@@ -68,5 +68,5 @@ MPC_DCN401 = dcn401_mpc.o
 AMD_DAL_MPC_DCN401 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn401/,$(MPC_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN401)
-
 endif
+
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index 37ab5a4eefc7..ad67197557ca 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -40,14 +40,14 @@
 #define FN(reg_name, field_name) \
 	mpc401->mpc_shift->field_name, mpc401->mpc_mask->field_name
 
-static void mpc401_update_3dlut_fast_load_select(struct mpc *mpc, int mpcc_id, int hubp_idx)
+void mpc401_update_3dlut_fast_load_select(struct mpc *mpc, int mpcc_id, int hubp_idx)
 {
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
 
 	REG_SET(MPCC_MCM_3DLUT_FAST_LOAD_SELECT[mpcc_id], 0, MPCC_MCM_3DLUT_FL_SEL, hubp_idx);
 }
 
-static void mpc401_get_3dlut_fast_load_status(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow)
+void mpc401_get_3dlut_fast_load_status(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow)
 {
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index af44054c2477..9267cdf88e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -63,7 +63,8 @@
 	uint32_t MPC_MCM_SECOND_GAMUT_REMAP_C31_C32_B[MAX_MPCC]; \
 	uint32_t MPC_MCM_SECOND_GAMUT_REMAP_C33_C34_B[MAX_MPCC]; \
 	uint32_t MPCC_MCM_3DLUT_FAST_LOAD_SELECT[MAX_MPCC]; \
-	uint32_t MPCC_MCM_3DLUT_FAST_LOAD_STATUS[MAX_MPCC]
+	uint32_t MPCC_MCM_3DLUT_FAST_LOAD_STATUS[MAX_MPCC]; \
+	uint32_t MPCC_CONTROL2[MAX_MPCC]
 
 #define MPC_COMMON_MASK_SH_LIST_DCN4_01(mask_sh) \
 	MPC_COMMON_MASK_SH_LIST_DCN32(mask_sh), \
@@ -235,5 +236,7 @@ void mpc401_get_gamut_remap(
 	struct mpc *mpc,
 	int mpcc_id,
 	struct mpc_grph_gamut_adjustment *adjust);
+void mpc401_update_3dlut_fast_load_select(struct mpc *mpc, int mpcc_id, int hubp_idx);
+void mpc401_get_3dlut_fast_load_status(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 82b91b9bc9c2..a6d4dbe82c13 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -168,13 +168,21 @@ struct dcn_optc_registers {
 	uint32_t OTG_CRC_CNTL;
 	uint32_t OTG_CRC_CNTL2;
 	uint32_t OTG_CRC0_DATA_RG;
+	uint32_t OTG_CRC1_DATA_RG;
+	uint32_t OTG_CRC2_DATA_RG;
+	uint32_t OTG_CRC3_DATA_RG;
 	uint32_t OTG_CRC0_DATA_B;
 	uint32_t OTG_CRC1_DATA_B;
 	uint32_t OTG_CRC2_DATA_B;
 	uint32_t OTG_CRC3_DATA_B;
-	uint32_t OTG_CRC1_DATA_RG;
-	uint32_t OTG_CRC2_DATA_RG;
-	uint32_t OTG_CRC3_DATA_RG;
+	uint32_t OTG_CRC0_DATA_R;
+	uint32_t OTG_CRC1_DATA_R;
+	uint32_t OTG_CRC2_DATA_R;
+	uint32_t OTG_CRC3_DATA_R;
+	uint32_t OTG_CRC0_DATA_G;
+	uint32_t OTG_CRC1_DATA_G;
+	uint32_t OTG_CRC2_DATA_G;
+	uint32_t OTG_CRC3_DATA_G;
 	uint32_t OTG_CRC0_WINDOWA_X_CONTROL;
 	uint32_t OTG_CRC0_WINDOWA_Y_CONTROL;
 	uint32_t OTG_CRC0_WINDOWB_X_CONTROL;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index bf921d1f500b..382ac18e7854 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -101,7 +101,7 @@ static uint32_t decide_odm_mem_bit_map(int *opp_id, int opp_cnt, int h_active)
 	return memory_bit_map;
 }
 
-static void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
+void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
 		int opp_cnt, int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -162,7 +162,7 @@ static void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
 	optc1->opp_count = opp_cnt;
 }
 
-static void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
+void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -177,7 +177,7 @@ static void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc,
  *
  * Return: Always returns true
  */
-static bool optc401_enable_crtc(struct timing_generator *optc)
+bool optc401_enable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -203,7 +203,7 @@ static bool optc401_enable_crtc(struct timing_generator *optc)
 }
 
 /* disable_crtc */
-static bool optc401_disable_crtc(struct timing_generator *optc)
+bool optc401_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -234,7 +234,7 @@ static bool optc401_disable_crtc(struct timing_generator *optc)
 	return true;
 }
 
-static void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
+void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -245,7 +245,7 @@ static void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
 	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);
 }
 
-static void optc401_disable_phantom_otg(struct timing_generator *optc)
+void optc401_disable_phantom_otg(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -259,7 +259,7 @@ static void optc401_disable_phantom_otg(struct timing_generator *optc)
 	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
 }
 
-static void optc401_set_odm_bypass(struct timing_generator *optc,
+void optc401_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -365,7 +365,7 @@ void optc401_set_drr(
 	}
 }
 
-static void optc401_set_out_mux(struct timing_generator *optc, enum otg_out_mux_dest dest)
+void optc401_set_out_mux(struct timing_generator *optc, enum otg_out_mux_dest dest)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -396,7 +396,7 @@ void optc401_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, i
 	}
 }
 
-static void optc401_program_global_sync(
+void optc401_program_global_sync(
 		struct timing_generator *optc,
 		int vready_offset,
 		int vstartup_start,
@@ -430,7 +430,7 @@ static void optc401_program_global_sync(
 	REG_UPDATE(OTG_PSTATE_REGISTER, OTG_PSTATE_KEEPOUT_START, pstate_keepout);
 }
 
-static void optc401_set_vupdate_keepout(struct timing_generator *tg, bool enable)
+void optc401_set_vupdate_keepout(struct timing_generator *tg, bool enable)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(tg);
 
@@ -442,7 +442,7 @@ static void optc401_set_vupdate_keepout(struct timing_generator *tg, bool enable
 	return;
 }
 
-static bool optc401_wait_update_lock_status(struct timing_generator *tg, bool locked)
+bool optc401_wait_update_lock_status(struct timing_generator *tg, bool locked)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(tg);
 	uint32_t lock_status = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 69ad21084fbb..fa62737b5b1b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -173,5 +173,24 @@ void optc401_set_drr(
 	const struct drr_params *params);
 void optc401_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
 void optc401_setup_manual_trigger(struct timing_generator *optc);
+void optc401_program_global_sync(
+		struct timing_generator *optc,
+		int vready_offset,
+		int vstartup_start,
+		int vupdate_offset,
+		int vupdate_width,
+		int pstate_keepout);
+bool optc401_enable_crtc(struct timing_generator *optc);
+bool optc401_disable_crtc(struct timing_generator *optc);
+void optc401_phantom_crtc_post_enable(struct timing_generator *optc);
+void optc401_disable_phantom_otg(struct timing_generator *optc);
+void optc401_set_odm_bypass(struct timing_generator *optc,
+		const struct dc_crtc_timing *dc_crtc_timing);
+void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
+		int opp_cnt, int segment_width, int last_segment_width);
+void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
+void optc401_set_out_mux(struct timing_generator *optc, enum otg_out_mux_dest dest);
+bool optc401_wait_update_lock_status(struct timing_generator *tg, bool locked);
+void optc401_set_vupdate_keepout(struct timing_generator *tg, bool enable);
 
 #endif /* __DC_OPTC_DCN401_H__ */
-- 
2.43.0

