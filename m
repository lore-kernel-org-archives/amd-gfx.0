Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD90FC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936D210E8CE;
	Wed, 10 Jul 2024 19:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NLWEuJCb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125D010E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmC1JxoCuAao2O06MWbiLlPk3uxOnV60H1Wf2eiFgZOV07C2PVOOGaZgtLIGdFy6RfHN7T366gIqRyYAA5ZLtazAA5odAYuvQ72PaZi9VNQnqxVL/oDzB8J678TVvhCWPu9yFFbUzJCnpi1WHoAjngJjjBx5UalGht2fVP0PuoywhGOiuAftj8rgR7PMhWJxU8RDfIVAEa6PA0DHggYFTsyaK31ZbzPg/uIOsNkmDdDmWR1eBiIwXT+68XBfLv+8abK5Zz1vrxRd9S0uFbhnOIf/3NaMzC6vFnYYtVIQr3kArdz60YuyYIPc95hhammPh1os+/+rZI82qffm+JzIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8b4rWZUwLF8KW+OFRW6Gtnx323gx/ZF/TJ5B17Suuo=;
 b=oKj1CyS81fw4DoPMZwWJpAg6koy1PwOTH0q/2LOqXcUSu+HFnZegA+NuEtMbtqSTRNPvKPkrTENIRN4ZvhYIjYdo1T0b6rdPFN/tenvFJp2XuwWmPESX3dnoSlRW929xokQiN+pY1S4VM3UcWEpGaPwmM/6J4aNQZDaDYKCEnvojxBGEm2KAffdsFIgl4Gv+ABptrDlBC+lvrkf1ioChLLQ3xPemiI0dMrGTCuZwV9oaNB+to/D/5S20LCSGkqY6PsmHdZc52ObQ65jE1oDAsLbfeflw7/8nmPVRqIhT04mYfYwAZhT7UTW15JRxxsf0D65dHPP1n4ttN2H4L/ByOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8b4rWZUwLF8KW+OFRW6Gtnx323gx/ZF/TJ5B17Suuo=;
 b=NLWEuJCbQsNWXBB74TWwCqmcAUSajEAIM19wrpEiriEQ4EPYlKRny2rKfZfvdSL34eoXrV/BhjYluaRhHXjhvvoNp+ipB1SrvDupt048Gt0Qrv1CjPq8gUojvzDKdeFuNpehAsgMUF6iqr8s9ed2iaRLuVvW3xK4VMGRVzMzf04=
Received: from DM6PR07CA0059.namprd07.prod.outlook.com (2603:10b6:5:74::36) by
 CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.39; Wed, 10 Jul
 2024 19:40:56 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::81) by DM6PR07CA0059.outlook.office365.com
 (2603:10b6:5:74::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:55 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:54 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>
Subject: [PATCH 49/50] drm/amd/display: Remove unused dml2_core_ip_params
 struct
Date: Wed, 10 Jul 2024 15:37:06 -0400
Message-ID: <20240710193707.43754-50-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3242b412-04c2-447f-bed2-08dca11837ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b2tPe9U9+U/BgFkX2n3FMY3MPdl32IQINvH9ljC5oZKPi4oDOk+o9kA67cwz?=
 =?us-ascii?Q?TMkw2gkqn5J8MFTWsrUmlpuCYJPnh81jUdVxrAOaiSfo8xjpectjaB5LuG8+?=
 =?us-ascii?Q?cMRLYmyfN+ZE3TVEfedah5dpK4rxEb+tBbFnBALrNEJ3gUzjBA8HWUnueQZw?=
 =?us-ascii?Q?jriev9Vk9Ch4USh2xGFhi2cNo58wXzxUA4rNwqRZ1LeASznekgxQGjhOARPJ?=
 =?us-ascii?Q?bc+t84Yb/1dKV9Bmkai7HIibNbZ2rMZ1Yhvid1qb+RAo8/NVVNTngtEJzh9v?=
 =?us-ascii?Q?Bl9fuoc9Py+iNANT9+EqgjO5tb8vgaZtfJfWaNSSb5Zzmx6ubeea1953Zubu?=
 =?us-ascii?Q?JJeDhrJsXsWz/boEJDMXn2FciBpZffVWb8X8QUBVfMrScTal/ZYAkpCjQI7a?=
 =?us-ascii?Q?kPAjBKHB9LgwYC1nPUVlqrN4OF2aupyXQ/3beReL0v/1FIA+yQiPL2pGHzK4?=
 =?us-ascii?Q?Q+YUkExRLaNZR+43c+ro551y+PA5aXbScOTaxevGa0FihwgzLMnrye0/M2lT?=
 =?us-ascii?Q?O68JnHBS7kKrZKAQMQwgfqahI9KkBwe3ttTKoBZlHFuWsHADzlNoEJliNnHe?=
 =?us-ascii?Q?tL/XimtM7TxTct+2wsd+DqJLW4xUD78kanMuAvNHPkc+xDpnfrUK9RFEJuWI?=
 =?us-ascii?Q?nJ8e8JSEoxVO+/xDAkj8izFed2mM+aG1o+I0FrTW+fCfcCOeN13TsmVCd90L?=
 =?us-ascii?Q?210CvEHYQDT82H9Y8Y8NaxP8VJl0HHuOO9n+smwJvaOAGHh04ztemE17mDPY?=
 =?us-ascii?Q?qgDswgk+YVC7ildx9oojHm2pnv78jKjDet2Uj8GqUvNtekrv4PNJOj4WopCT?=
 =?us-ascii?Q?IQf/5L8VuaORkCH+4VoTzGfa+06S1bJZFn18Iw7PCbqQ0KPqVH8C4fQ35M6d?=
 =?us-ascii?Q?H+m1MxLjzUpcWtoVqQ68DyUapAAtTJyJeFoiBHfMCjoFuHbO/4kudijKgAC0?=
 =?us-ascii?Q?X0ic0PbYdayQQWjAKhtqee0Nlw5EsAPNzjClssuZ3ZlIoAohIZUvulbTyWNV?=
 =?us-ascii?Q?ni1vD4FO4hYWPD3k/sILxqX5qH/yGsPEKGg+TCqmXCwg9two4/oqOoByYZ68?=
 =?us-ascii?Q?SD/+SnHzg5sjukKOsTIXRvWniH/ap9SPVGzeyQUATbjUCKkL2DhmxrQS/lwe?=
 =?us-ascii?Q?XNCBBi7pZYwA7Db9kgneKxh35LpWX+blYA6r3yxa3w9DAjJkr367LVe2FZjh?=
 =?us-ascii?Q?daJgPAXrT6Ra1rOM25Ug5m/hdKirjNXhBGuqK5L2F9buAehME1kbcbroC/dI?=
 =?us-ascii?Q?OV2dwVxvQCQlN0GXec1zSrtWUiVlYI4/jpZ1+IW9mws7jXq/FFLZKH96hmJ4?=
 =?us-ascii?Q?uzs076p5enZBA5VqjVpMgLR4OGrUWleDjIHLCDed9Hl2/t0D4Z6HVKqY0+Zr?=
 =?us-ascii?Q?DP1nNn6pKkA3KHIX0BiPL3FShYrgcfJaJbcJkUmg4tMbaSnaapEgQtMkIp8s?=
 =?us-ascii?Q?xV8f1SAo5EfX4/gzmCoOeGiTeXmLOdDD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:56.3852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3242b412-04c2-447f-bed2-08dca11837ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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

Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c | 78 -------------------
 1 file changed, 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 8c803b12404b..f5c6cd5cf5e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -77,84 +77,6 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	.subvp_swath_height_margin_lines = 16,
 };
 
-struct dml2_core_ip_params core_dcn4sw_ip_caps_base = {
-	.vblank_nom_default_us = 668,
-	.remote_iommu_outstanding_translations = 256,
-	.rob_buffer_size_kbytes = 192,
-	.config_return_buffer_size_in_kbytes = 1280,
-	.config_return_buffer_segment_size_in_kbytes = 64,
-	.compressed_buffer_segment_size_in_kbytes = 64,
-	.dpte_buffer_size_in_pte_reqs_luma = 68,
-	.dpte_buffer_size_in_pte_reqs_chroma = 36,
-	.pixel_chunk_size_kbytes = 8,
-	.alpha_pixel_chunk_size_kbytes = 4,
-	.min_pixel_chunk_size_bytes = 1024,
-	.writeback_chunk_size_kbytes = 8,
-	.line_buffer_size_bits = 1171920,
-	.max_line_buffer_lines = 32,
-	.writeback_interface_buffer_size_kbytes = 90,
-
-	//Number of pipes after DCN Pipe harvesting
-	.max_num_dpp = 4,
-	.max_num_otg = 4,
-	.max_num_wb = 1,
-	.max_dchub_pscl_bw_pix_per_clk = 4,
-	.max_pscl_lb_bw_pix_per_clk = 2,
-	.max_lb_vscl_bw_pix_per_clk = 4,
-	.max_vscl_hscl_bw_pix_per_clk = 4,
-	.max_hscl_ratio = 6,
-	.max_vscl_ratio = 6,
-	.max_hscl_taps = 8,
-	.max_vscl_taps = 8,
-	.dispclk_ramp_margin_percent = 1,
-	.dppclk_delay_subtotal = 47,
-	.dppclk_delay_scl = 50,
-	.dppclk_delay_scl_lb_only = 16,
-	.dppclk_delay_cnvc_formatter = 28,
-	.dppclk_delay_cnvc_cursor = 6,
-	.cursor_buffer_size = 24,
-	.cursor_chunk_size = 2,
-	.dispclk_delay_subtotal = 125,
-	.max_inter_dcn_tile_repeaters = 8,
-	.writeback_max_hscl_ratio = 1,
-	.writeback_max_vscl_ratio = 1,
-	.writeback_min_hscl_ratio = 1,
-	.writeback_min_vscl_ratio = 1,
-	.writeback_max_hscl_taps = 1,
-	.writeback_max_vscl_taps = 1,
-	.writeback_line_buffer_buffer_size = 0,
-	.num_dsc = 4,
-	.maximum_dsc_bits_per_component = 12,
-	.maximum_pixels_per_line_per_dsc_unit = 5760,
-	.dsc422_native_support = true,
-	.dcc_supported = true,
-	.ptoi_supported = false,
-
-	.cursor_64bpp_support = true,
-	.dynamic_metadata_vm_enabled = false,
-
-	.max_num_hdmi_frl_outputs = 1,
-	.max_num_dp2p0_outputs = 4,
-	.max_num_dp2p0_streams = 4,
-	.imall_supported = 1,
-	.max_flip_time_us = 80,
-	.words_per_channel = 16,
-
-	.subvp_fw_processing_delay_us = 15,
-	.subvp_pstate_allow_width_us = 20,
-	.subvp_swath_height_margin_lines = 16,
-
-	.dcn_mrq_present = 1,
-	.zero_size_buffer_entries = 512,
-	.compbuf_reserved_space_zs = 64,
-	.dcc_meta_buffer_size_bytes = 6272,
-	.meta_chunk_size_kbytes = 2,
-	.min_meta_chunk_size_bytes = 256,
-
-	.dchub_arb_to_ret_delay = 102,
-	.hostvm_mode = 1,
-};
-
 static void patch_ip_caps_with_explicit_ip_params(struct dml2_ip_capabilities *ip_caps, const struct dml2_core_ip_params *ip_params)
 {
 	ip_caps->pipe_count = ip_params->max_num_dpp;
-- 
2.34.1

