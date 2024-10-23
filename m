Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA2D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA26810E718;
	Wed, 23 Oct 2024 04:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUlvpM83";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F54410E718
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0nMvMfOkjqMCbgv1HVN0IXsQpLfoKlMfcWVlBMfN8o/SLZjUNMU5Me7SXee6L1MW3+6M9aqo8SrP9JW8eleziAqCipKNUoElRz3m8vs8yujZMoyIEDBIWxxWr2dH8PLf3TVJvOn0fiqtg09AOjrvg9wxk/1dV2528t0kVR02CICe5yz2Rrwicz1XZqD7sQVijjX14E2ayK2akcN3uaMeHNYvQCoZkgAWFXjml6ba/BRpoe3H+UP67f1VEvNMb2E7abdN5ucY/qZeIt89UuXo2GYTm9IcKCxQOmp3eFKhWjd7QRrcAt7xC61W1yWxYEjyE4p3KdZb0b8BW+OSdIIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X24ulGii9d/oxFlZqwnDXMD3jWqjWssEciKMKZQK0yo=;
 b=pUxMqoQ17+TDrIgFkgFNC22d1CimiR4MK2QnDQU2XTebmlx/yZnYhnF8Y3VQ5MpG4EcFN+d3unvRRBQxORXJr2Ph2dO1/y98TN9i+NeHLPUmhiE5kl9iR1L+9kvY86ZGljW0IAJiUH+F0qbjwJp43sHrw264JtdDvf2Z0RPpCP7etzffLfsYIMtBntS5KkSDWySyqd7al/c1ecjs1M6e7N1zsdFMIoxIxfN7+x6K+eMN6xO681O++Bk07gmp4pVQMTMizR7lrcn6RThTjt/vXjPgrittO556R8QrUuNkhG0hKC8NIiVx/Q3TeiLZe70bhGnRHvnffXmlQDCYG5HKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X24ulGii9d/oxFlZqwnDXMD3jWqjWssEciKMKZQK0yo=;
 b=DUlvpM83t9nfaFGkXQLZLnEaRYjTVfUJptN/Nd1l13shj4wDeYrk9LhqtqjDpNhoL5OBbY9/oe10HMuO7CorwLjMDbW+hJ672dNHUXyH1lOvKpzzwo523GMPvKLWPNR/rsEQv/7uw3dIpsMb6WzwMi5fMbEaS8nVFvB5wcOY57I=
Received: from CY5PR19CA0100.namprd19.prod.outlook.com (2603:10b6:930:83::12)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 04:54:00 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::33) by CY5PR19CA0100.outlook.office365.com
 (2603:10b6:930:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:53:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:53:58 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:53:55 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/16] drm/amd/display: Add P-State Stall Timeout Recovery
 Support for dcn401
Date: Wed, 23 Oct 2024 12:53:23 +0800
Message-ID: <20241023045336.1557443-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c7b9ba-f4fa-4e68-3f40-08dcf31eb593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cCoEHbnXqtqO3Q4SwRLeQGUy/GM1IXHYzojR1Poioh43IpZId751F3MUx9ss?=
 =?us-ascii?Q?usrmvCDTCEDID009rmbqomcc7AF6hklAxFM6LVTZd/aOM3iENAx9WDuiyB3r?=
 =?us-ascii?Q?S//B/4h4RFBnmoZI9pAgSqRtyfcsEk23y2ku0xOvHdR74AmdAaXkj7xr56OI?=
 =?us-ascii?Q?3zOWAq3lVJHbCpJOZdTIlYtbfFtKcxmy25nabzGNwmL2gQcg1M5KW6Ytj2c5?=
 =?us-ascii?Q?0BCvDibPgIpCTLKN3r3IcQ0lVH5FXKUe8ooMuIUE8w+ndmB3S24nL/qcuVDF?=
 =?us-ascii?Q?DbbQJdwcf9tO3p5YGwB1WsRVV+n/prVgF0BYITEUX4JuNwXfbOm2sW9CJDkb?=
 =?us-ascii?Q?seJm218alWflysu47I/jggmnW5/0MNXcVyaa1/V/JPm2uTt5CbRrSLBJrrBN?=
 =?us-ascii?Q?PIhryX1lpJUBmIMfidHLIWa9f4i3EuLiavbonQBQiY2S+X3gJ51sB8ep0zZr?=
 =?us-ascii?Q?QXUGoRxN9K0tnRQLfJ3Al1wAFu1kn+o4FDPf8bbcXXTQ6GYSj9IZQH9JkJ0o?=
 =?us-ascii?Q?gaAuMw9KCf2F6ewRlchtACKTfqbaBWGixlt/77I6bgp5DCHlfTvB6mhCfwJK?=
 =?us-ascii?Q?SSKNzjbEEhveispquXt+CkyYROyQVuziF6INaYUudQIV0KWmGEkKfePXO3Ip?=
 =?us-ascii?Q?1UCg90c3iXGTvy6S6nHbbij4hHiU9Jdi9Q8YRTxFH98PkwKKF278uGBQ/Pzc?=
 =?us-ascii?Q?b+BciBdsjari+m8ic3igqIDQTUlMNq33hzLm1j+4/D0Lv97Y5FIF41d+RtDg?=
 =?us-ascii?Q?8sA8LUpyjwub9o1lekYKGQJNoMkTG8FXaKSZSbH+TDya/IUDnimX9Z0bn3Y3?=
 =?us-ascii?Q?WU84WGy05Tn9q7i0diYvE0877RY60FInc993PxkDpkdA6Bw/a3sngZ2xJmf5?=
 =?us-ascii?Q?62+s9a3HRUOPh5I8jzZnyr61lzBkQ5BFVK1wTbW3N3Qck9R3b8cqgLg0U0Ko?=
 =?us-ascii?Q?VTF0Go4PZ5D5ym3laCjN7WjjHvlAJjQpnWF8HiVZOTU5YE4yDrJeBBW4pOFD?=
 =?us-ascii?Q?b35jnFFNtb8SjAZwTbcncBNC1jWo01tKKbjpp/nwnexHYezUKF7WmAingbye?=
 =?us-ascii?Q?vpntgcwe6ylYePCwjfzET21HcRBD2Hf03M1siiQFOy85QJCXcPVhpcY1Uoxb?=
 =?us-ascii?Q?f+yt7oM+6lhWkr9MsinSfYxlYsuxnMQz/LdzfvsgMaIs1E6uU5siDrdsvTAV?=
 =?us-ascii?Q?ptXdDY3tEAh1wTaE50r9rTQebbKg3hYKF8sOJZbA+fDyoTUuBqP1g0SFvZmZ?=
 =?us-ascii?Q?wwOPDK4KWAls9p0OI/hQOUSuXDTgz+mnd8zT7Koqaf8Nck+l9ya+JLN/r87z?=
 =?us-ascii?Q?92Rlp2j3bOEvxdIG1IGLt2l9smDk984z4XW7NPw42lG5uDl0HOWETvj9ucpk?=
 =?us-ascii?Q?qeBpZzFeGxT7f6FpGcIFUH11AfAW64TTnrseXK6sUQh0f3BtIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:53:59.8943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c7b9ba-f4fa-4e68-3f40-08dcf31eb593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Adds support for P-State stall timeout detection in DCHUBBUB.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/dml2/dml21/inc/dml_top_dchub_registers.h      |  1 +
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  |  3 +++
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h   |  9 ++++++++-
 .../drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c | 12 ++++++++++++
 .../drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h |  8 ++++++--
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    |  5 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h     |  1 +
 .../amd/display/dc/resource/dcn401/dcn401_resource.h |  4 +++-
 8 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
index 83fc15bf13cf..25b607e7b726 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
@@ -88,6 +88,7 @@ struct dml2_display_arb_regs {
 	uint32_t sdpif_request_rate_limit;
 	uint32_t allow_sdpif_rate_limit_when_cstate_req;
 	uint32_t dcfclk_deep_sleep_hysteresis;
+	uint32_t pstate_stall_threshold;
 };
 
 struct dml2_cursor_dlg_regs{
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 3ea54fd52e46..92e43a1e4dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12236,6 +12236,8 @@ static void rq_dlg_get_dlg_reg(
 
 static void rq_dlg_get_arb_params(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_display_arb_regs *arb_param)
 {
+	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
+
 	arb_param->max_req_outstanding = mode_lib->soc.max_outstanding_reqs;
 	arb_param->min_req_outstanding = mode_lib->soc.max_outstanding_reqs; // turn off the sat level feature if this set to max
 	arb_param->sdpif_request_rate_limit = (3 * mode_lib->ip.words_per_channel * mode_lib->soc.clk_table.dram_config.channel_count) / 4;
@@ -12247,6 +12249,7 @@ static void rq_dlg_get_arb_params(const struct dml2_display_cfg *display_cfg, co
 	arb_param->compbuf_size = mode_lib->mp.CompressedBufferSizeInkByte / mode_lib->ip.compressed_buffer_segment_size_in_kbytes;
 	arb_param->allow_sdpif_rate_limit_when_cstate_req = dml_get_hw_debug5(mode_lib);
 	arb_param->dcfclk_deep_sleep_hysteresis = dml_get_dcfclk_deep_sleep_hysteresis(mode_lib);
+	arb_param->pstate_stall_threshold = (unsigned int)(mode_lib->ip_caps.fams2.max_allow_delay_us * refclk_freq_in_mhz);
 
 #ifdef __DML_VBA_DEBUG__
 	dml2_printf("DML::%s: max_req_outstanding = %d\n", __func__, arb_param->max_req_outstanding);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index a1e2cde9c4cc..4bd1dda07719 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -198,6 +198,8 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_ARB_REFCYC_PER_META_TRIP_B;
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_MALL_A;
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_MALL_B;
+	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL1;
+	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL2;
 };
 
 #define HUBBUB_REG_FIELD_LIST_DCN32(type) \
@@ -313,7 +315,12 @@ struct dcn_hubbub_registers {
 		type DCN_VM_ERROR_VMID;\
 		type DCN_VM_ERROR_TABLE_LEVEL;\
 		type DCN_VM_ERROR_PIPE;\
-		type DCN_VM_ERROR_INTERRUPT_STATUS
+		type DCN_VM_ERROR_INTERRUPT_STATUS;\
+		type DCHUBBUB_TIMEOUT_ERROR_STATUS;\
+		type DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD;\
+		type DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD;\
+		type DCHUBBUB_TIMEOUT_DETECTION_EN;\
+		type DCHUBBUB_TIMEOUT_TIMER_RESET
 
 #define HUBBUB_STUTTER_REG_FIELD_LIST(type) \
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 37d26fa0b6fb..5d658e9bef64 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1192,6 +1192,17 @@ static void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
 	}
 }
 
+static void dcn401_program_timeout_thresholds(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	/* request backpressure and outstanding return threshold (unused)*/
+	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
+
+	/* P-State stall threshold */
+	REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, arb_regs->pstate_stall_threshold);
+}
+
 static const struct hubbub_funcs hubbub4_01_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
@@ -1215,6 +1226,7 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.program_det_segments = dcn401_program_det_segments,
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
 	.wait_for_det_update = dcn401_wait_for_det_update,
+	.program_timeout_thresholds = dcn401_program_timeout_thresholds,
 };
 
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
index f35f19ba3e18..5f1960722ebd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
@@ -123,8 +123,12 @@
 	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DCFCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_SDPIF_CFG0, SDPIF_PORT_CONTROL, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_SDPIF_CFG1, SDPIF_MAX_NUM_OUTSTANDING, mask_sh),\
-	HUBBUB_SF(DCHUBBUB_MEM_PWR_MODE_CTRL, DET_MEM_PWR_LS_MODE, mask_sh)
-
+	HUBBUB_SF(DCHUBBUB_MEM_PWR_MODE_CTRL, DET_MEM_PWR_LS_MODE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_ERROR_STATUS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_DETECTION_EN, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_TIMER_RESET, mask_sh)
 
 bool hubbub401_program_urgent_watermarks(
 		struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 3c70f40bf047..e8cc1bfa73f3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1554,6 +1554,11 @@ void dcn401_optimize_bandwidth(
 						pipe_ctx->dlg_regs.min_dst_y_next_start);
 		}
 	}
+
+	/* update timeout thresholds */
+	if (hubbub->funcs->program_timeout_thresholds) {
+		hubbub->funcs->program_timeout_thresholds(hubbub, &context->bw_ctx.bw.dcn.arb_regs);
+	}
 }
 
 void dcn401_fams2_global_control_lock(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 67c32401893e..6c1d41c0f099 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -228,6 +228,7 @@ struct hubbub_funcs {
 	void (*program_det_segments)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg);
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
+	void (*program_timeout_thresholds)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs);
 };
 
 struct hubbub {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index bdafa7496cea..7c8d61db153d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -610,7 +610,9 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SR(DCHUBBUB_CLOCK_CNTL),                                                 \
 	SR(DCHUBBUB_SDPIF_CFG0),                                                 \
 	SR(DCHUBBUB_SDPIF_CFG1),                                                 \
-	SR(DCHUBBUB_MEM_PWR_MODE_CTRL)
+	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),                                          \
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),                                    \
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2)
 
 /* DCCG */
 
-- 
2.34.1

