Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F4CC35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFFD10E568;
	Wed, 19 Mar 2025 17:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uRDITXNS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3BA310E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPP2gfz3ZCulyTjUqFYQdDv5Vb8r1vbCRTJEz2RjolcbAN715giBBtFtOnGge4DDGwW5aZE6+t+JXn+Y8WB49zLirVVzDyLWHiruOUhkl1zpAm4UGVHZ/AW8+qOycuHRqjczfam0f7aLE7FlqgFUwp2yghdPGfzTC7J9ttBG7zMFpAOJ4EprCPbPWR6dC9OdtuHHmpmILbbN0vANOIr3ThihYty5s9ASu9G5qkNV6Xbq79cTg7Nkb3J43zONfW355swOqYywaAcEZxF/1e7WNMY7RZ0F7vzVPTdj4Ohh5z7+0nCgqwyQfJnXBEb6lwBB+LGGL43+HsVPIBzx23DUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ad/St3pocsVO+ucSpjVLbmJTRm31fGdUDRkgUwSBnY=;
 b=gHIcaPD2mCI2zwYfrR9bpj891AOSmCuPO/JPCdupCiZ9KUcQCDdvdlI3ANFtipGzviHB1y7aie8eVmkuerbxifAx1mC56RU5kdCQsjXXBRRcogdIC8UoDWsxcf27dGFA1FwNBISoUdvziK58yiB3PNk1+5FHuM1mjT2KzFaFJk/N98N8yRQK5Icck2+J5DepGpdPbyoDddwSc6a49tmFlv/OT7tHM3U0a+ahYE+t7kIeObWhchJrFSjxIZC/R1xWojpiwou0slopzo9ktW3WsvbH5rwkxJxPB93mpKPg7AliqUpNnUvV8aHvVc9gcvweTpiUZWKTQfyZlzoi/ezPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ad/St3pocsVO+ucSpjVLbmJTRm31fGdUDRkgUwSBnY=;
 b=uRDITXNSkRbBs31VFhuVD2rdCP0r5BJ3kQ7EzP59j3BDMN/JhB0q20592zOwwd1fHEOMDTNLxOJNeAEo6vMhft4dMT0xwzcL1IV7upD3rW9ILmkMQpDEwMdImGRz8683mqYLG6dP/YRgvQgSyYOnSSWBJ13WOrTZFn5UyrST4LE=
Received: from BY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:a03:1a0::14)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:29 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::df) by BY5PR16CA0001.outlook.office365.com
 (2603:10b6:a03:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 17:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 17:57:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:27 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Josip Pavic
 <josip.pavic@amd.com>
Subject: [PATCH 12/16] drm/amd/display: Create a temporary scratch dc_link
Date: Wed, 19 Mar 2025 13:55:17 -0400
Message-ID: <20250319175718.2578234-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4614756b-190f-4bdc-8960-08dd670f83bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GFHQz0+1d5gD8hkWEATQkh5loU1iMiSuSmEdaj0LveF0ds1YmKFb464QMA8T?=
 =?us-ascii?Q?7ZhnqSUCVQhqtOX6F5Y3oBODBCluYPlnblwak/uDohcQAT5PJFrbXuQhXZiz?=
 =?us-ascii?Q?+OWG66Tg8gz+Ez5d4gxpuGMceephi6mZ0AZTHISuX6aDOq8GdaBrFuaNvp7w?=
 =?us-ascii?Q?w5PMcSDO9huXqwUb/BKnaM7GuC/OeIfjg6MBSZYNzFYuswpLUhFAm85EPdSW?=
 =?us-ascii?Q?n0lbbscbAj3lBIO3YM0h2IQGVcOrmDGuofI4DgMWE1vCyYRazmCA/gi+Exr4?=
 =?us-ascii?Q?tYMxfqxWGGCFEdKeG3PP31/7483GSJ8I4wI5L1Mn63BHFYn2fj+iSEqtwzdv?=
 =?us-ascii?Q?1/EgvDD1xmDHve7dnv+qbLqOzEPBGfysGbEflw9i6HSWoRCdDLVsUBvMXrEZ?=
 =?us-ascii?Q?JUb+o+/h9jxG4nFe3t+1Vvnnlje8WIz5wAH+KWSj6UcIH0JElPqFnsFq4VIh?=
 =?us-ascii?Q?ecwzWXXxD2Z5VP/WDXgQmIWqBp7voGlm/B6c6TUJ1EaPQUApBjZainn9IMvP?=
 =?us-ascii?Q?kn4AEupiOqnYuw4xKY+okt4GiZL9e0G7oe/VVXMJvDyOLRZBubFZmMVL+hb8?=
 =?us-ascii?Q?UJ52xppUmCj/CXDa9QiW46ZeH24moXbgTmVnn7E9yWz3905pty3ODYyRIm/k?=
 =?us-ascii?Q?J0xRDgoZ1/7SLLcfBXf7f3DqLiRoPcBXg7NtxSAziiLtNUE3LypDkyfRbNZq?=
 =?us-ascii?Q?YrIxU/Yx6JbuegBHgBD3hA+ZPl/bPAyJz0N2pW2B/Gyk40cQrUxbvm+nZ3D4?=
 =?us-ascii?Q?DtWvrbjb5BX1q56tuj8cY3U16bH+5Ma6kx59DJ7IEXcdN4FJACqtyhzW9Kmy?=
 =?us-ascii?Q?mM1zSby7xU4eIFZzLPXwX+QsKjxZIqD1iuqmtCBO0s4HXNgFfgMPT+Y93ens?=
 =?us-ascii?Q?1dJm3lxxHvTON8HlcOO8JoxjZ7HEDtPYB9ZkEzHxbn3+USXNkwxzOdZu1j+9?=
 =?us-ascii?Q?ctdB0uhOrG1VeMYJjHj+3hzKVVNf5RjoF/Go3n71VD0fvmZU9ZerxpNt3fgW?=
 =?us-ascii?Q?+XRXKyUnbU5MOspyVIa39NZ6mgxCO2U3LjEd8+OvgeIgKn4AzH/kvt9UYl5j?=
 =?us-ascii?Q?GuC3IPrbfjOsu7EbUInslsXqe0G9o6JL3TWzDUZph2YVXwEL/F8SXfg03OXe?=
 =?us-ascii?Q?QH22wiFhp3eiciKjZno5RJClvIkyGwtg2PExxck9PqA9Z2m3Aw+69m+3PUHq?=
 =?us-ascii?Q?8APlu+G5ztdJS8esgrpY8KrOZe+cmVTars5YkWz/zRr5Tei4Dzg/EWAcTCob?=
 =?us-ascii?Q?oFgyZJMHSoYj/wA0UH6OS8N200vP+2xP2MTApb57SGTpKPK5kKwUANGaBPSw?=
 =?us-ascii?Q?rxr3OF27/g7PF0rnF3USVaWNJ6Z7r7EXD5cZAdYjv60OZegA2UsXuhob5R0g?=
 =?us-ascii?Q?sRJ2TVGRDZbeoIU5fK/y9EV6pvLgDkAbm2aVCtsfVO/AVLrvkPtolHbQUPK1?=
 =?us-ascii?Q?aGjkAs8b708680gRTAxEB3StQmjmScB9i18aaMj3pJlvrD2+kLVACz+9ukjI?=
 =?us-ascii?Q?8cNQ07MeDqnAHRI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:28.7413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4614756b-190f-4bdc-8960-08dd670f83bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
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

From: Aric Cyr <Aric.Cyr@amd.com>

Create a temporary scratch dc_link for programming purposes
and fix a copy of pipe_ctx on the stack to a pointer reference.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           | 329 +++++++++---------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 .../link/protocols/link_edp_panel_control.c   |   8 +-
 3 files changed, 170 insertions(+), 169 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index be2518e07c14..13f3a8370592 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1419,6 +1419,170 @@ struct dc_scratch_space {
 	struct dc_stream_state stream_state;
 };
 
+/*
+ * A link contains one or more sinks and their connected status.
+ * The currently active signal type (HDMI, DP-SST, DP-MST) is also reported.
+ */
+ struct dc_link {
+	struct dc_sink *remote_sinks[MAX_SINKS_PER_LINK];
+	unsigned int sink_count;
+	struct dc_sink *local_sink;
+	unsigned int link_index;
+	enum dc_connection_type type;
+	enum signal_type connector_signal;
+	enum dc_irq_source irq_source_hpd;
+	enum dc_irq_source irq_source_hpd_rx;/* aka DP Short Pulse  */
+
+	bool is_hpd_filter_disabled;
+	bool dp_ss_off;
+
+	/**
+	 * @link_state_valid:
+	 *
+	 * If there is no link and local sink, this variable should be set to
+	 * false. Otherwise, it should be set to true; usually, the function
+	 * core_link_enable_stream sets this field to true.
+	 */
+	bool link_state_valid;
+	bool aux_access_disabled;
+	bool sync_lt_in_progress;
+	bool skip_stream_reenable;
+	bool is_internal_display;
+	/** @todo Rename. Flag an endpoint as having a programmable mapping to a DIG encoder. */
+	bool is_dig_mapping_flexible;
+	bool hpd_status; /* HPD status of link without physical HPD pin. */
+	bool is_hpd_pending; /* Indicates a new received hpd */
+
+	/* USB4 DPIA links skip verifying link cap, instead performing the fallback method
+	 * for every link training. This is incompatible with DP LL compliance automation,
+	 * which expects the same link settings to be used every retry on a link loss.
+	 * This flag is used to skip the fallback when link loss occurs during automation.
+	 */
+	bool skip_fallback_on_link_loss;
+
+	bool edp_sink_present;
+
+	struct dp_trace dp_trace;
+
+	/* caps is the same as reported_link_cap. link_traing use
+	 * reported_link_cap. Will clean up.  TODO
+	 */
+	struct dc_link_settings reported_link_cap;
+	struct dc_link_settings verified_link_cap;
+	struct dc_link_settings cur_link_settings;
+	struct dc_lane_settings cur_lane_setting[LANE_COUNT_DP_MAX];
+	struct dc_link_settings preferred_link_setting;
+	/* preferred_training_settings are override values that
+	 * come from DM. DM is responsible for the memory
+	 * management of the override pointers.
+	 */
+	struct dc_link_training_overrides preferred_training_settings;
+	struct dp_audio_test_data audio_test_data;
+
+	uint8_t ddc_hw_inst;
+
+	uint8_t hpd_src;
+
+	uint8_t link_enc_hw_inst;
+	/* DIG link encoder ID. Used as index in link encoder resource pool.
+	 * For links with fixed mapping to DIG, this is not changed after dc_link
+	 * object creation.
+	 */
+	enum engine_id eng_id;
+	enum engine_id dpia_preferred_eng_id;
+
+	bool test_pattern_enabled;
+	/* Pending/Current test pattern are only used to perform and track
+	 * FIXED_VS retimer test pattern/lane adjustment override state.
+	 * Pending allows link HWSS to differentiate PHY vs non-PHY pattern,
+	 * to perform specific lane adjust overrides before setting certain
+	 * PHY test patterns. In cases when lane adjust and set test pattern
+	 * calls are not performed atomically (i.e. performing link training),
+	 * pending_test_pattern will be invalid or contain a non-PHY test pattern
+	 * and current_test_pattern will contain required context for any future
+	 * set pattern/set lane adjust to transition between override state(s).
+	 * */
+	enum dp_test_pattern current_test_pattern;
+	enum dp_test_pattern pending_test_pattern;
+
+	union compliance_test_state compliance_test_state;
+
+	void *priv;
+
+	struct ddc_service *ddc;
+
+	enum dp_panel_mode panel_mode;
+	bool aux_mode;
+
+	/* Private to DC core */
+
+	const struct dc *dc;
+
+	struct dc_context *ctx;
+
+	struct panel_cntl *panel_cntl;
+	struct link_encoder *link_enc;
+	struct graphics_object_id link_id;
+	/* Endpoint type distinguishes display endpoints which do not have entries
+	 * in the BIOS connector table from those that do. Helps when tracking link
+	 * encoder to display endpoint assignments.
+	 */
+	enum display_endpoint_type ep_type;
+	union ddi_channel_mapping ddi_channel_mapping;
+	struct connector_device_tag_info device_tag;
+	struct dpcd_caps dpcd_caps;
+	uint32_t dongle_max_pix_clk;
+	unsigned short chip_caps;
+	unsigned int dpcd_sink_count;
+	struct hdcp_caps hdcp_caps;
+	enum edp_revision edp_revision;
+	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
+
+	struct psr_settings psr_settings;
+	struct replay_settings replay_settings;
+
+	/* Drive settings read from integrated info table */
+	struct dc_lane_settings bios_forced_drive_settings;
+
+	/* Vendor specific LTTPR workaround variables */
+	uint8_t vendor_specific_lttpr_link_rate_wa;
+	bool apply_vendor_specific_lttpr_link_rate_wa;
+
+	/* MST record stream using this link */
+	struct link_flags {
+		bool dp_keep_receiver_powered;
+		bool dp_skip_DID2;
+		bool dp_skip_reset_segment;
+		bool dp_skip_fs_144hz;
+		bool dp_mot_reset_segment;
+		/* Some USB4 docks do not handle turning off MST DSC once it has been enabled. */
+		bool dpia_mst_dsc_always_on;
+		/* Forced DPIA into TBT3 compatibility mode. */
+		bool dpia_forced_tbt3_mode;
+		bool dongle_mode_timing_override;
+		bool blank_stream_on_ocs_change;
+		bool read_dpcd204h_on_irq_hpd;
+		bool force_dp_ffe_preset;
+	} wa_flags;
+	union dc_dp_ffe_preset forced_dp_ffe_preset;
+	struct link_mst_stream_allocation_table mst_stream_alloc_table;
+
+	struct dc_link_status link_status;
+	struct dprx_states dprx_states;
+
+	struct gpio *hpd_gpio;
+	enum dc_link_fec_state fec_state;
+	bool link_powered_externally;	// Used to bypass hardware sequencing delays when panel is powered down forcibly
+
+	struct dc_panel_config panel_config;
+	struct phy_state phy_state;
+	uint32_t phy_transition_bitmask;
+	// BW ALLOCATON USB4 ONLY
+	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
+	bool skip_implict_edp_power_control;
+	enum backlight_control_type backlight_control_type;
+};
+
 struct dc {
 	struct dc_debug_options debug;
 	struct dc_versions versions;
@@ -1486,6 +1650,7 @@ struct dc {
 		struct dc_scratch_space current_state;
 		struct dc_scratch_space new_state;
 		struct dc_stream_state temp_stream; // Used so we don't need to allocate stream on the stack
+		struct dc_link temp_link;
 		bool pipes_to_unlock_first[MAX_PIPES]; /* Any of the pipes indicated here should be unlocked first */
 	} scratch;
 
@@ -1652,170 +1817,6 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 		const enum dc_link_encoding_format link_encoding);
 
 /* Link Interfaces */
-/*
- * A link contains one or more sinks and their connected status.
- * The currently active signal type (HDMI, DP-SST, DP-MST) is also reported.
- */
-struct dc_link {
-	struct dc_sink *remote_sinks[MAX_SINKS_PER_LINK];
-	unsigned int sink_count;
-	struct dc_sink *local_sink;
-	unsigned int link_index;
-	enum dc_connection_type type;
-	enum signal_type connector_signal;
-	enum dc_irq_source irq_source_hpd;
-	enum dc_irq_source irq_source_hpd_rx;/* aka DP Short Pulse  */
-
-	bool is_hpd_filter_disabled;
-	bool dp_ss_off;
-
-	/**
-	 * @link_state_valid:
-	 *
-	 * If there is no link and local sink, this variable should be set to
-	 * false. Otherwise, it should be set to true; usually, the function
-	 * core_link_enable_stream sets this field to true.
-	 */
-	bool link_state_valid;
-	bool aux_access_disabled;
-	bool sync_lt_in_progress;
-	bool skip_stream_reenable;
-	bool is_internal_display;
-	/** @todo Rename. Flag an endpoint as having a programmable mapping to a DIG encoder. */
-	bool is_dig_mapping_flexible;
-	bool hpd_status; /* HPD status of link without physical HPD pin. */
-	bool is_hpd_pending; /* Indicates a new received hpd */
-
-	/* USB4 DPIA links skip verifying link cap, instead performing the fallback method
-	 * for every link training. This is incompatible with DP LL compliance automation,
-	 * which expects the same link settings to be used every retry on a link loss.
-	 * This flag is used to skip the fallback when link loss occurs during automation.
-	 */
-	bool skip_fallback_on_link_loss;
-
-	bool edp_sink_present;
-
-	struct dp_trace dp_trace;
-
-	/* caps is the same as reported_link_cap. link_traing use
-	 * reported_link_cap. Will clean up.  TODO
-	 */
-	struct dc_link_settings reported_link_cap;
-	struct dc_link_settings verified_link_cap;
-	struct dc_link_settings cur_link_settings;
-	struct dc_lane_settings cur_lane_setting[LANE_COUNT_DP_MAX];
-	struct dc_link_settings preferred_link_setting;
-	/* preferred_training_settings are override values that
-	 * come from DM. DM is responsible for the memory
-	 * management of the override pointers.
-	 */
-	struct dc_link_training_overrides preferred_training_settings;
-	struct dp_audio_test_data audio_test_data;
-
-	uint8_t ddc_hw_inst;
-
-	uint8_t hpd_src;
-
-	uint8_t link_enc_hw_inst;
-	/* DIG link encoder ID. Used as index in link encoder resource pool.
-	 * For links with fixed mapping to DIG, this is not changed after dc_link
-	 * object creation.
-	 */
-	enum engine_id eng_id;
-	enum engine_id dpia_preferred_eng_id;
-
-	bool test_pattern_enabled;
-	/* Pending/Current test pattern are only used to perform and track
-	 * FIXED_VS retimer test pattern/lane adjustment override state.
-	 * Pending allows link HWSS to differentiate PHY vs non-PHY pattern,
-	 * to perform specific lane adjust overrides before setting certain
-	 * PHY test patterns. In cases when lane adjust and set test pattern
-	 * calls are not performed atomically (i.e. performing link training),
-	 * pending_test_pattern will be invalid or contain a non-PHY test pattern
-	 * and current_test_pattern will contain required context for any future
-	 * set pattern/set lane adjust to transition between override state(s).
-	 * */
-	enum dp_test_pattern current_test_pattern;
-	enum dp_test_pattern pending_test_pattern;
-
-	union compliance_test_state compliance_test_state;
-
-	void *priv;
-
-	struct ddc_service *ddc;
-
-	enum dp_panel_mode panel_mode;
-	bool aux_mode;
-
-	/* Private to DC core */
-
-	const struct dc *dc;
-
-	struct dc_context *ctx;
-
-	struct panel_cntl *panel_cntl;
-	struct link_encoder *link_enc;
-	struct graphics_object_id link_id;
-	/* Endpoint type distinguishes display endpoints which do not have entries
-	 * in the BIOS connector table from those that do. Helps when tracking link
-	 * encoder to display endpoint assignments.
-	 */
-	enum display_endpoint_type ep_type;
-	union ddi_channel_mapping ddi_channel_mapping;
-	struct connector_device_tag_info device_tag;
-	struct dpcd_caps dpcd_caps;
-	uint32_t dongle_max_pix_clk;
-	unsigned short chip_caps;
-	unsigned int dpcd_sink_count;
-	struct hdcp_caps hdcp_caps;
-	enum edp_revision edp_revision;
-	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
-
-	struct psr_settings psr_settings;
-	struct replay_settings replay_settings;
-
-	/* Drive settings read from integrated info table */
-	struct dc_lane_settings bios_forced_drive_settings;
-
-	/* Vendor specific LTTPR workaround variables */
-	uint8_t vendor_specific_lttpr_link_rate_wa;
-	bool apply_vendor_specific_lttpr_link_rate_wa;
-
-	/* MST record stream using this link */
-	struct link_flags {
-		bool dp_keep_receiver_powered;
-		bool dp_skip_DID2;
-		bool dp_skip_reset_segment;
-		bool dp_skip_fs_144hz;
-		bool dp_mot_reset_segment;
-		/* Some USB4 docks do not handle turning off MST DSC once it has been enabled. */
-		bool dpia_mst_dsc_always_on;
-		/* Forced DPIA into TBT3 compatibility mode. */
-		bool dpia_forced_tbt3_mode;
-		bool dongle_mode_timing_override;
-		bool blank_stream_on_ocs_change;
-		bool read_dpcd204h_on_irq_hpd;
-		bool force_dp_ffe_preset;
-	} wa_flags;
-	union dc_dp_ffe_preset forced_dp_ffe_preset;
-	struct link_mst_stream_allocation_table mst_stream_alloc_table;
-
-	struct dc_link_status link_status;
-	struct dprx_states dprx_states;
-
-	struct gpio *hpd_gpio;
-	enum dc_link_fec_state fec_state;
-	bool link_powered_externally;	// Used to bypass hardware sequencing delays when panel is powered down forcibly
-
-	struct dc_panel_config panel_config;
-	struct phy_state phy_state;
-	uint32_t phy_transition_bitmask;
-	// BW ALLOCATON USB4 ONLY
-	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
-	bool skip_implict_edp_power_control;
-	enum backlight_control_type backlight_control_type;
-};
-
 /* Return an enumerated dc_link.
  * dc_link order is constant and determined at
  * boot time.  They cannot be created or destroyed.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index d0021f25f3d8..c1c8742d4a58 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -507,7 +507,7 @@ struct resource_context {
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
 	bool is_mpc_3dlut_acquired[MAX_PIPES];
-	/* solely used for build scalar data in dml2 */
+	/* used to build scalar data in dml2 and for edp backlight programming */
 	struct pipe_ctx temp_pipe;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 1e4adbc764ea..669ac1bc662c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -524,7 +524,7 @@ bool edp_set_backlight_level(const struct dc_link *link,
 	struct dc  *dc = link->ctx->dc;
 	uint32_t backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
 	uint32_t frame_ramp = backlight_level_params->frame_ramp;
-	DC_LOGGER_INIT(link->ctx->logger);
+
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
 
@@ -1130,11 +1130,11 @@ static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 	struct abm *abm = NULL;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		struct pipe_ctx pipe_ctx = dc->current_state->res_ctx.pipe_ctx[i];
-		struct dc_stream_state *stream = pipe_ctx.stream;
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct dc_stream_state *stream = pipe_ctx->stream;
 
 		if (stream && stream->link == link) {
-			abm = pipe_ctx.stream_res.abm;
+			abm = pipe_ctx->stream_res.abm;
 			break;
 		}
 	}
-- 
2.49.0

