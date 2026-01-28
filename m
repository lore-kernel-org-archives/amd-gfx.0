Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AEFD35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D12310E5F0;
	Wed, 28 Jan 2026 01:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kQuZGiP+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2016110E5E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPxmJduQiI/wGaAQgPM8MCKf9/MLdw1wSrI/lp7W4PBOSriPLtZfL8W9r6LWsLl/Ak/9NNFxhrnXX0RNRdc4bwZO7eO5LGOMoqSdquS6SKjXPFG5ahBSSVtywldo2vAbMMMlA4y6BGZp0R1oKfFewektduRxxjoWeAlm1/lJI9ll4dvN8Tqn5Ws0BFGinqZ28dwWyreFwX3dqdgTZnpWMVeZ1bZLrvEir3Kd6WJcuhM9KYnRgpODUJ3Omc0Sm24HJUhxyGF2S+AwWxlq7IHDj0x7R9M5Vrh02OY1LzhMs3sJxmBiAJ8cDU9suVXU9YFqIXL1hC8uSVsPgNM4UANjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD2M9XiChl8V0mJ6U5gGy5cuZIkqfX0qmPTTHAkKtFQ=;
 b=RiqBpNc59jeqhUFhFecqQo8fMMGUtCUMI1/EBQIfFFCx9CCBrvoGMoCAViG7OF3a7yASqN5DE+Bw9c5irqf6nZE6cGdvdB4m7V5PUGhQTYO/fd/VmznGbxRTShfntDFmtHaWR2B4/6VVe0Z7DGhhj319ULzTJCUgO4kiFzOg0W7c9aHTVS/ix1PpEONzFv5rBias6dv9n1mPPt7JQmEhZ7WhGRIHD0vzK3aabC588COu0APLl/I/UEmCxK+idipTQtLy7ec9gU4vBPF65owf3nIJTBcWWyuyEIMy12dPX5Y4GpKs/DUVTalU2jNfHbDnL4oV5XowSOtkpR/P5aCrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD2M9XiChl8V0mJ6U5gGy5cuZIkqfX0qmPTTHAkKtFQ=;
 b=kQuZGiP+I/0wfUgcTIc10JpHC3P82OSZiAelY7jTppXZ+gqkgkdrsLbu8RboCCGq9nvte86izAlfB5/pxi3r8MEnsx3Mhya6J6RFAJonSgXdX/zbPpMMoR8zB5qxOaFllGfu5T4Ljo141V3A/+gbGSAfpEj8pDF6QI9nbb5wTf4=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 01:59:33 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::97) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 19:59:31 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:28 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 06/21] drm/amd/display: Make some DCN35 DCCG symbols non-static
Date: Wed, 28 Jan 2026 09:51:31 +0800
Message-ID: <20260128015538.568712-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: d098473a-ef22-4bc6-3838-08de5e10e18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2hSqlX/8f1F1Gg2DfM+QjaOUSesHPV8/Ylm09fbxM963z5t02GrSqcbZHhZN?=
 =?us-ascii?Q?S+qlfRd5/BTmBzSVpxB/ZyePqem+PgBbELHrSYww/JECq/U7/bALWc2XUaHf?=
 =?us-ascii?Q?HzVmHNH5f4trrRf2TAqMROP8wLiOFl71+zf8WB4bHaOpaRpRNFkF9Up8xZJ5?=
 =?us-ascii?Q?YeGUg28lH4zaU/uDuttOj+Vm6MX7j5jrmWVn0uOnGvrMW+k3TkjNIu+sSKGr?=
 =?us-ascii?Q?nAVWEuuIUxyNOMmFXCNmfEtHBBidjYMAA/QRuqeG+vMheSdUlnzLrDeLFDuo?=
 =?us-ascii?Q?878G5E3/l3+G+s3IAgaTld83HPp6XG02D9xB4Q92sGZZkuUm9H/R+7D9sm9d?=
 =?us-ascii?Q?DxFeDBId8RLOsCF1AQa0gel4pv/hjScimDrbNHcWa1BawXYSHQnVtk7vA5xw?=
 =?us-ascii?Q?OWcoL8Jx/SzoJ2Y3itvsG/GVWYvc598jOWTHaNIPklAcyCmqht6ONwiZGAq+?=
 =?us-ascii?Q?O9CV0zK7zQewOdJOcWpxYEBbT02z5OIIeH1dYsG7PUwWXbVd0L6XgC51yUuR?=
 =?us-ascii?Q?EnvF85Erxq7bW1ICZ3w6Euz/xK9jjOTEtWQn2mija1bbktcPKK7N766jgT3J?=
 =?us-ascii?Q?7UM7cjPap/kgv1ecqVPLaTtwS/W9zqyWWCpwFD7C/GPOX0zZjTNNBiFqJWFX?=
 =?us-ascii?Q?2BCsfn+Vc2FTK+t8dMlnZmL/TqxTiaf8ldp/46AS2Bpig9sDS3HbEhJW+Bw8?=
 =?us-ascii?Q?lvWYlBAhTONUAcicnGUwSj7GAZoSHKwhb5+Q45WW0U9NwrkZP2UiLEa7T6JB?=
 =?us-ascii?Q?i7q+Np+kQdUC5QPEH4vinK87uvW4XZs7UFLnckEwO53wBfHYq3/iUQ0g1HMR?=
 =?us-ascii?Q?IknEN2H/Wrp65j0o9g3wwFEHJ7TrobpEACnIA3PKfAdZqNYF4mJ4N73xLhln?=
 =?us-ascii?Q?taIjECySjXIruAdMUM+KXOnIPUsnpnqcsCUqCBzMA8Z7CULXWfEPMV3gnfzM?=
 =?us-ascii?Q?iBkDWFEOm1oqQij0s1SJetu+BeAxK77ADp8TaXACgVfAxsq56OciLCX8KAcg?=
 =?us-ascii?Q?HLf2E0L6ulzFXF8/hM7MzpzVH8gyc044DvW+AwVBuWqyzTUZNOyZMuhRUoEC?=
 =?us-ascii?Q?n6Wi10lU7fiXmV5+xmQ5NVRT5Pt0mzIkOJGMwWutxicEOo+NY+usn6JE6ccx?=
 =?us-ascii?Q?bbueSorwEWSZQKPk6ffsEnmM6hPfwasCKtlvl1vN9JtPRy7zlAERniRQeWj4?=
 =?us-ascii?Q?NBvnIi6CBt/6GupuZsjUlrbg1Pgcpx/WSQl2pvJA6awcTXSq1yBWuyzpEkmf?=
 =?us-ascii?Q?B/RVNEM34hkD2tDCkEFlRi0xZuBhuj3rjRdX0HV5QShIEEbeUJMOzHHpJfyH?=
 =?us-ascii?Q?3Pq/mT8xnbW0+SQ/a2rlRRthKFlFs852YtR8F5Lv8DovlC0CuJiLOXy02RAM?=
 =?us-ascii?Q?dZf7r/PYnRDFj86VJhh9rRMaHlwH6kH5Nj5+thPSTXS+KunalcFwNSUcY7QI?=
 =?us-ascii?Q?firLo9Mj/7FkOlDp9Ld+THrcK26mFLAtbI40ggV3MZ0XZkvIV81Q7jwMOcoS?=
 =?us-ascii?Q?n7F1bNCHZjeKm67IhYWfw3YYQDTCnFWNxR0+KYzYuyZ9HzR5Qbixe0EqhlYz?=
 =?us-ascii?Q?Ywd9gpMsiQGWVOGFcty68GjBW8pYP3T8gZJTcXCXjtVPKI03VK7BZzxpL01M?=
 =?us-ascii?Q?UDZWdp7vJx0+vLlYTB9J27Ivx88gUnUhFzfHO2Tm4c9JuMOFmMNEowflaYgx?=
 =?us-ascii?Q?oBRSLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:32.8268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d098473a-ef22-4bc6-3838-08de5e10e18a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

In order to have few DCN35 functions be leveraged for future ASIC
implementations. Expose them to the dcn35_dccg.h header.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 30 +++++++------------
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    | 17 +++++++++++
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index bd2f528137b2..838c6617c029 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1105,7 +1105,7 @@ static void dccg35_enable_dpstreamclk_new(struct dccg *dccg,
 	dccg35_set_dpstreamclk_src_new(dccg, src, inst);
 }
 
-static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
+void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t dispclk_rdivider_value = 0;
@@ -1114,6 +1114,7 @@ static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 	if (dispclk_rdivider_value != 0)
 		REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
 }
+
 static void dccg35_wait_for_dentist_change_done(
 	struct dccg *dccg)
 {
@@ -1151,8 +1152,7 @@ static void dcn35_set_dppclk_enable(struct dccg *dccg,
 
 }
 
-static void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst,
-				  int req_dppclk)
+void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -1498,11 +1498,7 @@ static void dccg35_set_dpstreamclk(
 			__func__, dp_hpo_inst, (src == REFCLK) ? 0 : 1, otg_inst);
 }
 
-
-static void dccg35_set_dpstreamclk_root_clock_gating(
-		struct dccg *dccg,
-		int dp_hpo_inst,
-		bool enable)
+void dccg35_set_dpstreamclk_root_clock_gating(struct dccg *dccg, int dp_hpo_inst, bool enable)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -1669,10 +1665,7 @@ static void dccg35_set_valid_pixel_rate(
 	dccg35_set_dtbclk_dto(dccg, &dto_params);
 }
 
-static void dccg35_dpp_root_clock_control(
-		struct dccg *dccg,
-		unsigned int dpp_inst,
-		bool clock_on)
+void dccg35_dpp_root_clock_control(struct dccg *dccg, unsigned int dpp_inst, bool clock_on)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -1704,9 +1697,7 @@ static void dccg35_dpp_root_clock_control(
 	DC_LOG_DEBUG("%s: dpp_inst(%d) clock_on = %d\n", __func__, dpp_inst, clock_on);
 }
 
-static void dccg35_disable_symclk32_se(
-		struct dccg *dccg,
-		int hpo_se_inst)
+void dccg35_disable_symclk32_se(struct dccg *dccg, int hpo_se_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -1813,7 +1804,7 @@ void dccg35_enable_global_fgcg_rep(struct dccg *dccg, bool value)
 	REG_UPDATE(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, !value);
 }
 
-static void dccg35_enable_dscclk(struct dccg *dccg, int inst)
+void dccg35_enable_dscclk(struct dccg *dccg, int inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -1860,8 +1851,7 @@ static void dccg35_enable_dscclk(struct dccg *dccg, int inst)
 	udelay(10);
 }
 
-static void dccg35_disable_dscclk(struct dccg *dccg,
-				int inst)
+void dccg35_disable_dscclk(struct dccg *dccg, int inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -1906,7 +1896,7 @@ static void dccg35_disable_dscclk(struct dccg *dccg,
 	udelay(10);
 }
 
-static void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -2013,7 +2003,7 @@ static uint8_t dccg35_get_number_enabled_symclk_fe_connected_to_be(struct dccg *
 	return num_enabled_symclk_fe;
 }
 
-static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
 {
 	uint8_t num_enabled_symclk_fe = 0;
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
index 7b9c36456cd9..554700287c1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
@@ -249,8 +249,25 @@ struct dccg *dccg35_create(
 
 void dccg35_init(struct dccg *dccg);
 
+void dccg35_trigger_dio_fifo_resync(struct dccg *dccg);
+
+void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk);
+
 void dccg35_enable_global_fgcg_rep(struct dccg *dccg, bool value);
 void dccg35_root_gate_disable_control(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 
+void dccg35_set_dpstreamclk_root_clock_gating(struct dccg *dccg, int dp_hpo_inst, bool enable);
+
+void dccg35_set_hdmistreamclk_root_clock_gating(struct dccg *dccg, bool enable);
+
+void dccg35_dpp_root_clock_control(struct dccg *dccg, unsigned int dpp_inst, bool clock_on);
+
+void dccg35_disable_symclk32_se(struct dccg *dccg, int hpo_se_inst);
+
+void dccg35_enable_dscclk(struct dccg *dccg, int inst);
+void dccg35_disable_dscclk(struct dccg *dccg, int inst);
+
+void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
+void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
 
 #endif //__DCN35_DCCG_H__
-- 
2.43.0

