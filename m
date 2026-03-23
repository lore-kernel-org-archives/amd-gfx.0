Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F5CF4613D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 15:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D521A10E2EB;
	Mon, 23 Mar 2026 15:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rrKOPFeG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A70810E4A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 15:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYdiFkfTVzCkNWsHerbsoDfs52mFg87apj12HxZcrT0hTdSC0HbM54s1q6dZSJW7yCzBnX2Hc4aO8FopqnEyaU7JPYShbe0DiJJzROGzOnGzf0N1620NzUGtpdDY3Wa+ci15vdS6aP4fG5q0XLGRuGSeZY7rLzc18nPWwNlJj38/ABsMbFt03OHsOO886cFn6g5GR8akBsQYhV4YBF/igKxCktujc9hcBORaZNn19xDXmkhQtZE/3jQkxwsJLV0kSfZ7ziWiCS9fRWkOpV40MGc9Zf9Lwhbqpv9G2B9u5SrPa2QGxrI12t3v8I/fsj/8PZOyS6S/VNHKH88iQBj/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGzg4McXs58VmDflfLugDd16hYz5aqjEFq/+7oYwoO8=;
 b=L4idqr6zjX9AxKiigEwOEavqE3mXtUncPgl52rFDrwd7iVX4xJdhqh6l2xPE3CtILTyGYHdO2VSo8wE07nGVoU8zPaKVWkUoc/S6uxuAb82SuzYtAjaov02tZf8aLVyP5nubfRJhI1EkFkM8FdmhXhVT/w/bLlak2mw4QaiAw4BrgZDTpt6OtT5ezwstua4FbJMY2kUz+KwP5gm6jEiuk+W7nVo4udTnhLeS/HbcWw10RkW5oXWi4u5q7SBgQVO2+xuNIVlsI7AlriXt6hRWreALn63wppbXDtMbRR1rOSMHHm30Vp/W+HTIY9/HYo+3kNLYsEt3MHcLYboVHx3EyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGzg4McXs58VmDflfLugDd16hYz5aqjEFq/+7oYwoO8=;
 b=rrKOPFeG722cFBIW8ntfLUn2r3xosGiSkRvbfDHQ35Yd9K2KGex7JqBIwFpy1tyhUPpkI8U3+A6tsEwQpt/9+tiNVaNHrqH5W+vzL5Mrj6onzURZEBAUxPN9Ao64PKR+vhpUl7twD+6iR+Gw9lqoP/WakjoL/APLhMQHvmXbHTw=
Received: from SN7PR04CA0194.namprd04.prod.outlook.com (2603:10b6:806:126::19)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 15:41:20 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::66) by SN7PR04CA0194.outlook.office365.com
 (2603:10b6:806:126::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 15:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 15:41:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 10:41:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 10:39:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 10:39:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/display: add a no_hpd link_encoder_funcs variant
Date: Mon, 23 Mar 2026 11:39:23 -0400
Message-ID: <20260323153923.1055788-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323153923.1055788-1-alexander.deucher@amd.com>
References: <20260323153923.1055788-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: f3987cf1-b40f-41c0-f70c-08de88f2a10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DTL5XncOziz08XMyldA7OG6xfr+Ap33VWlVskbB6pWxecqqVcHvikKno1LQZs7Uu4Dz646pAInzCoQZLySLpWxRZ4Wmqwjfzdn5mvuVW0ittDwo8x/nHZkkg7YwFzkHo11ja/fCThvsMg1wgy+Z/Ca+dU3voA0X9xmQyKX1QStQHiRRVD9NiurOm42WxbesuxJwp0d3T6ijO6RY5mASo7kwhvDgXugurPpg3PFNSeJetBOK4DENI2maBnPrgVUsUPCP8WdOoF9z8SZq2zR5w78b4649woXbHfXmvjwLzwyAV7sQ6nenZDzEBs0nUx1eWBJYWl6twjO83sexw7GPhfugr9l07XWYDP97yqnrQMwb9IDNeu4jp+TB/rItpVgI7qtlIT90G5VNiwT2fTqNERID2HD9zuVSiaBk1K169rQQFTntdAQTALLalGEX2QNDzS/sjg1dRwytQKhm5kUQ6U7QnIe/qL7QefcdxuT/Khpkm5UrdTrAWlEJi5uTC6iE5Dr+L2rd5vVwkObrfc6rfV/jOetMLxnFcX+wdGJ88iNvkxz89+1WVzWy77KOZvZq+/i2sNMJ1etxVMpSrD74Pczp5Uv3ZsmDArSEx2PiH2tAsucl4TDUoFkJKTfUG5gQwwoW2z8f/uUHAGZHUbYQKRQSOHuxt0iGcVZW3Jj+pZKwKanQnGx6RGyy5osssxwGPRSIUS1a155hFSstJMepTXhJC3FvTxT2yCxvyDtfFq2sWuybd347FHmeAbTENLbenqujAKOnQ/948iWOf/PAVfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ubQFh0z1dmv5GSvggVeinsy9t4CPSroY77W4Pgpxx8Q7ZCFgXIm9nhrtvuvWBMIa8ri5TLta5PAR1heIWPKtGqskbANwE6412A7/XpluaHWpt0b9eXxU0GB7bPd5JQ6Uk/BtxHayVp4iPQapuA0hcgbEqdX/MIBoWDP9d/U5VJVtXPDCkTxiNbDeIO9D3PtIz3Ad9ef9+23/BiZ6540sDn8fa9LeVSL/kl8TZu7Rwn4/4wOpzDdLdvlf1TAKWPXC4McBZ4wBjqqaecHIXtbY5XZ1NYfkwr+ANiVAuvq3qszANUggsHRdNjKHzvJPvwpY7AKpMW129GZYemRZhNMxk9mcML91M9FShTyCuErM1L+8ZEqFM3Kwo4dfIeKPjnn2CEddnCIAdorRByq7E9obIPzm/xEihtI4jZdDiGRxFUqTEysGkP6iP8To7R6gHfn+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:41:19.7847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3987cf1-b40f-41c0-f70c-08de88f2a10a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
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

For link encoders without HPD (analog or LVDS), add a
link_encoder_funcs structure with no hpd enable callbacks.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 64 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 2ba3d3a3aac58..a368802ba51db 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -122,6 +122,33 @@ static const struct link_encoder_funcs dce110_lnk_enc_funcs = {
 	.program_hpd_filter = dce110_program_hpd_filter,
 };
 
+static const struct link_encoder_funcs dce110_lnk_enc_funcs_no_hpd = {
+	.validate_output_with_stream =
+		dce110_link_encoder_validate_output_with_stream,
+	.hw_init = dce110_link_encoder_hw_init,
+	.setup = dce110_link_encoder_setup,
+	.enable_tmds_output = dce110_link_encoder_enable_tmds_output,
+	.enable_dp_output = dce110_link_encoder_enable_dp_output,
+	.enable_dp_mst_output = dce110_link_encoder_enable_dp_mst_output,
+	.enable_lvds_output = dce110_link_encoder_enable_lvds_output,
+	.enable_analog_output = dce110_link_encoder_enable_analog_output,
+	.disable_output = dce110_link_encoder_disable_output,
+	.dp_set_lane_settings = dce110_link_encoder_dp_set_lane_settings,
+	.dp_set_phy_pattern = dce110_link_encoder_dp_set_phy_pattern,
+	.update_mst_stream_allocation_table =
+		dce110_link_encoder_update_mst_stream_allocation_table,
+	.psr_program_dp_dphy_fast_training =
+			dce110_psr_program_dp_dphy_fast_training,
+	.psr_program_secondary_packet = dce110_psr_program_secondary_packet,
+	.connect_dig_be_to_fe = dce110_link_encoder_connect_dig_be_to_fe,
+	.is_dig_enabled = dce110_is_dig_enabled,
+	.destroy = dce110_link_encoder_destroy,
+	.get_max_link_cap = dce110_link_encoder_get_max_link_cap,
+	.get_dig_frontend = dce110_get_dig_frontend,
+	.get_hpd_state = dce110_get_hpd_state,
+	.program_hpd_filter = dce110_program_hpd_filter,
+};
+
 static enum bp_result link_transmitter_control(
 	struct dce110_link_encoder *enc110,
 	struct bp_transmitter_control *cntl)
@@ -865,7 +892,10 @@ void dce110_link_encoder_construct(
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 
-	enc110->base.funcs = &dce110_lnk_enc_funcs;
+	if (hpd_regs)
+		enc110->base.funcs = &dce110_lnk_enc_funcs;
+	else
+		enc110->base.funcs = &dce110_lnk_enc_funcs_no_hpd;
 	enc110->base.ctx = init_data->ctx;
 	enc110->base.id = init_data->encoder;
 	enc110->base.analog_id = init_data->analog_encoder;
@@ -1855,6 +1885,33 @@ static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
 	.program_hpd_filter = dce110_program_hpd_filter,
 };
 
+static const struct link_encoder_funcs dce60_lnk_enc_funcs_no_hpd = {
+	.validate_output_with_stream =
+		dce110_link_encoder_validate_output_with_stream,
+	.hw_init = dce110_link_encoder_hw_init,
+	.setup = dce110_link_encoder_setup,
+	.enable_tmds_output = dce110_link_encoder_enable_tmds_output,
+	.enable_dp_output = dce60_link_encoder_enable_dp_output,
+	.enable_dp_mst_output = dce60_link_encoder_enable_dp_mst_output,
+	.enable_lvds_output = dce110_link_encoder_enable_lvds_output,
+	.enable_analog_output = dce110_link_encoder_enable_analog_output,
+	.disable_output = dce110_link_encoder_disable_output,
+	.dp_set_lane_settings = dce110_link_encoder_dp_set_lane_settings,
+	.dp_set_phy_pattern = dce60_link_encoder_dp_set_phy_pattern,
+	.update_mst_stream_allocation_table =
+		dce110_link_encoder_update_mst_stream_allocation_table,
+	.psr_program_dp_dphy_fast_training =
+			dce110_psr_program_dp_dphy_fast_training,
+	.psr_program_secondary_packet = dce110_psr_program_secondary_packet,
+	.connect_dig_be_to_fe = dce110_link_encoder_connect_dig_be_to_fe,
+	.is_dig_enabled = dce110_is_dig_enabled,
+	.destroy = dce110_link_encoder_destroy,
+	.get_max_link_cap = dce110_link_encoder_get_max_link_cap,
+	.get_dig_frontend = dce110_get_dig_frontend,
+	.get_hpd_state = dce110_get_hpd_state,
+	.program_hpd_filter = dce110_program_hpd_filter,
+};
+
 void dce60_link_encoder_construct(
 	struct dce110_link_encoder *enc110,
 	const struct encoder_init_data *init_data,
@@ -1867,7 +1924,10 @@ void dce60_link_encoder_construct(
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 
-	enc110->base.funcs = &dce60_lnk_enc_funcs;
+	if (hpd_regs)
+		enc110->base.funcs = &dce60_lnk_enc_funcs;
+	else
+		enc110->base.funcs = &dce60_lnk_enc_funcs_no_hpd;
 	enc110->base.ctx = init_data->ctx;
 	enc110->base.id = init_data->encoder;
 	enc110->base.analog_id = init_data->analog_encoder;
-- 
2.53.0

