Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BA606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1zah7g6Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D0610F8DA;
	Wed, 11 Nov 2026 01:43:22 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E079910F8E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCXAs7cCxBQuENOwfRASx7r8fy+ZpdHUY1YKDHwBR0celQIZaHD/I+efeLf0/Gwz8WJEN1Oat3x+lNYcYG7flAL3C10/7Cq7EfIFqeWV3NNm38SjRjhvPON4Ua0pOVK0DISzCjcn6otS+m6hK7xpdqFbQkwZZNnUtVSBfOWFVKGt+OnVo+zjJKp0FpgshrgSLh86snK3YNiNBKE7rpV/vmvODonomct1WxrSIdntXN6Xl5UFOIsCy1twHz9EUZBYiI5u8vaVhdzTE/d4dPGrwJEAwCbFXB7yP1+FHWwHONiIF0xmNMNSLllIzZVtN4Nv71sX8M86/2ev0LTx/3wLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoIRrd6xIzYspiLBDo8//5n4EawMWN9Y6XdaZGSxIQI=;
 b=k37lW9g764nFmmCrLTlwuZZR1Caxg4W4QwILXvogEeozQAk6IugdmnI4x+J1bvkTV5KNBJLeDHSlzGTVMubC5/xPH2wLfmTAoLbBGE/8Zdjr1YTtqYEKm1FffQkBKmoBHZEioR95fvqDLRCAqwv0KYKw/dP85p0maWgNKRVuzYkxSPbaDZimOS2m6W58xNSR/OVoTvRS8Qvvp4/TY0SnjNw5njdfZt8Rkn4CPhwjnr42JzGSHZ9t5yO/vS6841dbnMJJ3MHc8JtUAZxfAA3l5C0st0alMkyoullWrMFXeRDcLDRyqdqPGYv68xplEnnH/unTj729h/l2d4zUTUIzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoIRrd6xIzYspiLBDo8//5n4EawMWN9Y6XdaZGSxIQI=;
 b=1zah7g6Zw5POATtMylpW/a3aviegIsfD3nZEr88TE/wrsaEQweMT0gYP0ngZAcOSZB4Azq96VWvzfyJaH5wKol7hvFbfb24foOfGKJ6U8R2OPYgIrHlHbdj0XC8G357OrCiRfz9TnnyiuRnHhtlfA1ndOYDbCbb18cxMlCDH2Ms=
Received: from MW4PR03CA0182.namprd03.prod.outlook.com (2603:10b6:303:b8::7)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:43:10 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::a5) by MW4PR03CA0182.outlook.office365.com
 (2603:10b6:303:b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:07 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:04 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 42/74] drm/amd/display: [FW Promotion] Release 0.1.83.0
Date: Wed, 11 Nov 2026 09:28:48 +0800
Message-ID: <20261111014100.3596072-43-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4896e9c5-c75d-4877-fed6-08df3f9523f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|30052699003|23010399003|376014|1800799024|82310400026|5023799004|11063799006|261009223027099003|56012099006|261026121527099003|261022075727099003|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021123027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: If70HrozRirRpwK2ZskDKW4Flin0bHIDI33ELuBZZCUrEpyjtvc2lEaFYfByvcIVQB8Y7VB4ly5Rpm9cISWVTI6xI2Uu1wkU8RZomAi1+rfZt8yS54Rxzk8KcWTCBlc5o/x+fkmYXa3OQogJZEuK5wO3xqNmIIOxSJq+hX+5XrEUvAR+4fjtMoQ2OvGek8qOBfUXomSuZ9YcqisBRwmR2IxWnjaF2Yfk1K3WtEkTAgDr6Q2LJImPaLBJKNb2SaHQT4O7drTertJlM1qMu8IWlL2O2eCtg7UoGAn+IINwFk9/UECM4Pa6s6wAjjMFQ4TPBzhCGwm+GvMCGT++RJky6NrtrQmWddoewNBtZ0N3tkvFVigVKpntjw6xOBnchNQq4LtojjgMpsAQCxGaqhi9iesB0OsQhdy2wYriyAooTZKmYZ4Ad75mTfwX/yRsblccaqkhyPQrC5jHCO7pL/Ambu+F7n+jFT3Pcj2wzp+hAqB7KNljZpXJettCH/+zR9J5NJN/1/yhW5XGx89gHwyyXB43CKXwLxnzwRCR2nceoL5lr/YtVdkNRP+i7uL5ZW3D4tYIO2JibfzGURij808iKwLA4Duo6I/y2/haMk1I05aXadjPuXFAp2bFgtkrrKY05gT+cSSTyQr6Pz8rZR7OkbU0qfv3z9q5+5fYRLtn/dBNKkNmNuNM3det4+ippcbXbShLmE8aoPghrNvNU3fq6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(30052699003)(23010399003)(376014)(1800799024)(82310400026)(5023799004)(11063799006)(261009223027099003)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gE7QtXVIMfr1GB1g1rLf+0Nwg0ZaPgG9gbYwf1kBOLXSF7au3mBfUK0prDxaWXK3hj/AEhMf1Am8CrcAkBBi5PVVoVOEm0/1Av5tfH6h47q89/YDHL3064WOsXGjzz71XwK/Bws66nSadH/9rQJyrNT8subA/shWfkch0w5M+nzjeTDZnxoLNqGIksE5P8x8PeXmUPJznpd1a67eedAsxQ4Nmbob6MrJJmEILRyaZRuAPCE6+Bvd6rNkdW6teKhJvJFWcNEwBaYKrmve0FQbaaRVny+kuSr8Hv/yIGhG0YbRs9aQFPlc1WYSMPFSv5n//C3PMR9uc0jKGaaAdme+7t+2fkLl/cmhlls93OCCgXq8lc4+brA+Boer+4eRYDUh8lw+ulWLwPacZct2rJpBEKF8Tx1cYnrDrth+xlrrSAh4JHmR9IUi+EIgaiOYa3/0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:09.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4896e9c5-c75d-4877-fed6-08df3f9523f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

Updated DMUB interface
- Extend the SoC bounding box with urgent bandwidth targets, pipe and
  output counts, return-buffer sizes, and FAMS2 delay and timeout values
- Add RAMLESS_LOBF commands to copy static settings and to enable,
  disable, or wake the feature
- Carry a seamless-boot eDP request in the DCN init command

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 203 +++++++++++++++++-
 1 file changed, 197 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8684b1398d4e..c3aa0d0a74be 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -408,6 +408,42 @@ struct dmub_soc_bb_params {
 	uint32_t vmin_limit_dispclk_khz;
 	uint32_t vmin_limit_dcfclk_khz;
 	uint32_t g7_temperature_read_blackout_ns;
+	uint32_t fraction_of_urgent_bandwidth_nominal_target;
+	uint32_t fraction_of_urgent_bandwidth_flip_target;
+	uint32_t max_outstanding_reqs;
+	uint32_t return_bus_width_bytes;
+	uint32_t alternate_dram_carveout_size_mb;
+	uint32_t pipe_count;
+	uint32_t otg_count;
+	uint32_t num_dsc;
+	uint32_t TDLUT_33cube_count;
+	uint32_t max_num_dp2p0_streams;
+	uint32_t max_num_hdmi_frl_outputs;
+	uint32_t max_num_dp2p0_outputs;
+	uint32_t rob_buffer_size_kbytes;
+	uint32_t config_return_buffer_size_in_kbytes;
+	uint32_t config_return_buffer_segment_size_in_kbytes;
+	uint32_t meta_fifo_size_in_kentries;
+	uint32_t compressed_buffer_segment_size_in_kbytes;
+	uint32_t cursor_buffer_size;
+	uint32_t max_flip_time_us;
+	uint32_t max_flip_time_lines;
+	uint32_t hostvm_mode;
+	uint32_t max_vactive_det_fill_delay_us;
+	uint32_t ppt_max_allow_delay_us;
+	uint32_t temp_read_max_allow_delay_us;
+	uint32_t vblank_nom_default_us;
+	uint32_t fams2_max_allow_delay_us;
+	uint32_t fams2_scheduling_delay_us;
+	uint32_t fams2_vertical_interrupt_ack_delay_us;
+	uint32_t fams2_allow_programming_delay_us;
+	uint32_t fams2_min_allow_width_us;
+	uint32_t fams2_subvp_df_throttle_delay_us;
+	uint32_t fams2_subvp_programming_delay_us;
+	uint32_t fams2_drr_programming_delay_us;
+	uint32_t fams2_lock_timeout_us;
+	uint32_t fams2_recovery_timeout_us;
+	uint32_t fams2_flip_programming_delay_us;
 };
 #pragma pack(pop)
 
@@ -1193,7 +1229,7 @@ enum dmub_dc_bls_command_type {
 	 */
 	DMUB_CMD__DC_BLS_DCHVM_INIT = 0,
 	/**
-	 * Runs the fixed DCN hardware init sequence.
+	 * Initializes the DCN hardware.
 	 */
 	DMUB_CMD__DC_BLS_DCN_INIT = 1,
 };
@@ -2071,6 +2107,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__NBIF_AZ_PME_RESTORE = 99,
 
+	/**
+	 * Command type use for all RAMLESS_LOBF commands.
+	 */
+	DMUB_CMD__RAMLESS_LOBF = 100,
+
 	/**
 	 * Command type use for VBIOS shared commands.
 	 */
@@ -7732,15 +7773,157 @@ struct dmub_rb_cmd_boot_time_crc_init {
 	struct dmub_cmd_boot_time_crc_init_data data;
 };
 
+enum ramless_lobf_enable_cmd {
+	LOBF_DISABLE            = 0, /**< Disable Ramless LOBF */
+	LOBF_ENABLE             = 1, /**< Enable Ramless LOBF */
+	LOBF_IMMEDIATE_WAKE     = 2, /**< Immediate wake (program_manual_trigger) */
+	LOBF_ENTER_IDLE_SCREEN  = 3, /**< Enter idle screen */
+	LOBF_EXIT_IDLE_SCREEN   = 4, /**< Exit idle screen */
+};
+
+/**
+ * enum ramless_lobf_phy_mode - PHY power-state mode for Ramless LOBF.
+ */
+enum ramless_lobf_phy_mode {
+	LOBF_PHY_MODE_P0_ON     = 0, /**< PHY P0: lanes and PLL fully powered (normal operation) */
+	LOBF_PHY_MODE_P2_PLL_ON = 1, /**< PHY P2: lanes off, PLL still running (shallow sleep) */
+	LOBF_PHY_MODE_P3_PG     = 2, /**< PHY P3: lanes and PLL power-gated (deep sleep) */
+};
+
+/**
+ * enum dmub_cmd_ramless_lobf_type - Sub-command types for DMUB_CMD__RAMLESS_LOBF.
+ */
+enum dmub_cmd_ramless_lobf_type {
+	DMUB_CMD__RAMLESS_LOBF_COPY_SETTINGS = 0, /**< Copy static settings from driver to FW */
+	DMUB_CMD__RAMLESS_LOBF_ENABLE        = 1, /**< Enable or disable Ramless LOBF */
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__RAMLESS_LOBF_ENABLE command.
+ */
+struct dmub_cmd_ramless_lobf_enable_data {
+	/**
+	 * @enable: 1 to enable LOBF, 0 to disable, 2 to force immediate wake (program_manual_trigger).
+	 */
+	uint8_t enable_command;
+	/**
+	 * @panel_inst: Panel instance index.
+	 */
+	uint8_t panel_inst;
+	/**
+	 * @pad: Align structure to 4-byte boundary.
+	 */
+	uint8_t pad[2];
+
+	uint32_t wake_source;
+};
+
+/**
+ * Definition of a DMUB_CMD__RAMLESS_LOBF_ENABLE command.
+ */
+struct dmub_rb_cmd_ramless_lobf_enable {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data for enable/disable.
+	 */
+	struct dmub_cmd_ramless_lobf_enable_data data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__RAMLESS_LOBF_COPY_SETTINGS command.
+ */
+struct dmub_cmd_ramless_lobf_copy_settings_data {
+	/**
+	 * @panel_inst: Panel instance index.
+	 */
+	uint8_t panel_inst;
+	/**
+	 * @otg_inst: OTG hardware instance.
+	 */
+	uint8_t otg_inst;
+	/**
+	 * @digfe_inst: DIG front-end hardware instance.
+	 */
+	uint8_t digfe_inst;
+	/**
+	 * @digbe_inst: DIG back-end hardware instance.
+	 */
+	uint8_t digbe_inst;
+	/**
+	 * @dpphy_inst: DP PHY hardware instance.
+	 */
+	uint8_t dpphy_inst;
+	/**
+	 * @aux_inst: AUX hardware instance.
+	 */
+	uint8_t aux_inst;
+	/**
+	 * @phy_mode: PHY power-state mode. Use values from enum ramless_lobf_phy_mode.
+	 */
+	uint8_t phy_mode;
+	/**
+	 * @enable_scenarios: Bitmask of enabled scenarios for Ramless LOBF.
+	 */
+	uint8_t enable_scenarios;
+	/**
+	 * @line_time_in_ns: Total length of one horizontal line (active + blanking) in
+	 * nanoseconds.  Used to calculate wake up timer IRQ.
+	 */
+	uint32_t line_time_in_ns;
+	/**
+	 * @vactive: Number of active video lines in the display mode.
+	 */
+	uint32_t vactive;
+
+	uint16_t reserved_0;
+	uint16_t lobf_min_sleep_time_us; /* if < min, then we don't want LOBF to sleep */
+	uint8_t debug_options;
+	uint8_t vmin_force_default_frames;
+	uint8_t visual_confirm;
+	uint8_t reserved[1];
+	/**
+	 * Use for AUX-less ALPM LFPS wake operation
+	 */
+	struct dmub_alpm_auxless_data auxless_alpm_data;
+};
+
+/**
+ * Definition of a DMUB_CMD__RAMLESS_LOBF_COPY_SETTINGS command.
+ */
+struct dmub_rb_cmd_ramless_lobf_copy_settings {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW.
+	 */
+	struct dmub_cmd_ramless_lobf_copy_settings_data data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__DC_BLS_DCN_INIT command.
+ */
+struct dmub_cmd_dc_bls_dcn_init_data {
+	/** 1 to keep the boot eDP stream for seamless boot. */
+	uint8_t seamless_boot_edp_requested : 1;
+	/** Reserved. Must be zero. */
+	uint8_t reserved_bits : 7;
+	/** Reserved. Must be zero. */
+	uint8_t reserved[3];
+};
+
 /**
  * Definition of a DMUB_CMD__DC_BLS_DCN_INIT command.
- *
- * Runs a fixed DCN hardware init sequence after the pre-OS to post-OS
- * transition. Carries no payload; anything driver-configurable is
- * programmed by the driver after this command completes.
  */
 struct dmub_rb_cmd_dc_bls_dcn_init {
-	struct dmub_cmd_header header; /**< Command header */
+	/** Command header. */
+	struct dmub_cmd_header header;
+	/** Data passed from driver to FW in a DMUB_CMD__DC_BLS_DCN_INIT command. */
+	struct dmub_cmd_dc_bls_dcn_init_data data;
 };
 
 /**
@@ -8164,6 +8347,14 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_panel_polarity_reset panel_polarity_reset;
 
 	struct dmub_rb_cmd_dc_bls_dchvm_init dc_bls_dchvm_init;
+	/**
+	 * Definition of a DMUB_CMD__RAMLESS_LOBF_COPY_SETTINGS command.
+	 */
+	struct dmub_rb_cmd_ramless_lobf_copy_settings ramless_lobf_copy_settings;
+	/**
+	 * Definition of a DMUB_CMD__RAMLESS_LOBF_ENABLE command.
+	 */
+	struct dmub_rb_cmd_ramless_lobf_enable ramless_lobf_enable;
 };
 
 /**
-- 
2.43.0

