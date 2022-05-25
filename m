Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEFEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABD910E57E;
	Wed, 25 May 2022 16:20:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC62B10E57E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5hL868pPA4+37Fyd0XyotBOqqb7Lkcc/5O9a2nR72saLXyeBo/ZThJ9A/eyzT9Avu+smBM76fJQkBaGZPjD/2fdd0vPmilnUDTp4e7DB8IJCwz66L2Q9Dl1+TMDpBOARj/GkAWyJPkbJxhUKQQC6YNCJN9VOqGEN7OqIxwYSDLa7X07XfA+OFfpQYC+CQ8uXJWrUR824aNQfMcO/UbAgXTOZ957QxYDL3E5Ph3VdSoE6l/+X2RjGbR1HOkBgcRw6XCz7cH7Ep5ULtkETPj6MAclYeRIG69LxgOl1yBgbtqWcE1LYcNQlgRW36YBPgNiWsh/2da12RyO7loIeAuDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAHazlIV7xJ9/rP73B68c8KYaaRuWK86ytaxCLg2UEs=;
 b=kacOA+32/LV1s/jRsxcmNRUkHS+Q9cpWa3rn3T6KDbnE2x9HE+u96CE8BFfsB6OI4Eh+FjJPMVXKQGIdlEtsAULCMgzhVYeMQ+wTICHCff5W/+WoES3/+rJR1PhiXkvVZbT5IhSA2P2DrIVLn7q85KO34e/jmH0hDUMAwtH3a30XKM+qz52JGI6EZmhLkOVGJupYn31FtvR8zRXEGlvkR5y7EisOHRoy7myBNn/DG86+O+Hmprh+jtRqInlkQVoPvHWW7rYz2xHW7k62lcn1J3Q4xAnIUbi4MY9kghEBvPPI46vAeSQfNcsreFxvMvoK4NfMVEhiY3JsvhPssKRL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAHazlIV7xJ9/rP73B68c8KYaaRuWK86ytaxCLg2UEs=;
 b=GSL1scyJ1tI2Krczr4lRjJKTZ2HZfopOeJIiFZPZr1DrisG8tnNngtrNsv6Sz1m38S05hAGdEZFeK04QdeveOtFosTjxlmPDaa82iKUtPSNig20LSfsGsNhyAWpSYzEdq+nkzExqn/BJUwnt1JU+Teb4XV5idmQg7BcQvmD4O1s=
Received: from DM6PR04CA0030.namprd04.prod.outlook.com (2603:10b6:5:334::35)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Wed, 25 May
 2022 16:20:02 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ee) by DM6PR04CA0030.outlook.office365.com
 (2603:10b6:5:334::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 16:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/43] drm/amd: Add atomfirmware.h definitions needed for
 DCN32/321
Date: Wed, 25 May 2022 12:19:01 -0400
Message-ID: <20220525161941.2544055-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c20a8fd-53d3-4f4a-4574-08da3e6a6c27
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5611:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5611A19943A2438989E048BDF7D69@SJ0PR12MB5611.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMsPYfuHOv6WACdyQXZZBDaJv5WajFeHtGdTyEYZxQKVk83HjIrh78Lv61rceA6M0vZD2+F819c8XYnjMl3qzWPuA/mNCf2Je3dmjby1muFURvj44ptEpJ7hhS8w2C+J9VMXXZA8YIHcUSrU2u7K7QKc6mXm7G0/SDr8FVAsqQ9JOFGgySLoqMScidGS5RjDQilh/VRLbOkuzCUGR3xOWiZy5bH+xvHXC21/mnwMi22u09GblMwgtCQDqYIQan4gLriSkHo/F31uWbIlIplSrf/4V+GpQTsjJOzI1O4YgQITnfWg88eXPfTFjl8zQ6Kx6KqpV8UZpIeDnLz3BL6DJd44creCog9FS69H5tz7cYCcjt3K05yx1yE2A6RT25qh9sdpYWx9JIUsxu+WcPOuCmtu3J6Qei5DUBmQj77iGidUmMd0E5i5+rxQ7Pc2pZeSeSjjex7lDpvTDcRLZnNd2pXlu4JlIQuB2p9a3A8X25B/VzZ7YmV+VNmL553Q16J7ej7+XE9jPlBftQJGSqElvixTdCpQtPLTtCDwpfrrnMStt/OsdmdTnUhwWOmFMd8/R5JR7cG3kLpBLtzPBtNEmlJGOIItMHkBtz8A7tADWoplDdSKgQc1ZRJLfZZ3EgVCSm+osXxDo4u3UYK4b6Vl8BX2iZxkatGu1avPDBU/l8FFFLZ92hYJgFr2JbdCHjZE7995bYRNPXQtV7V629ViGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(54906003)(40460700003)(6916009)(47076005)(2616005)(508600001)(1076003)(83380400001)(82310400005)(5660300002)(26005)(426003)(70206006)(70586007)(316002)(36756003)(186003)(16526019)(86362001)(8676002)(4326008)(81166007)(2906002)(36860700001)(8936002)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:02.7221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c20a8fd-53d3-4f4a-4574-08da3e6a6c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Add new structures for DCN 3.2.x.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 209 ++++++++++++++++++---
 1 file changed, 187 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index ae8f6d299ed9..ff855cb21d3f 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -726,18 +726,20 @@ struct vram_usagebyfirmware_v2_1
   ***************************************************************************
 */
 
-enum atom_object_record_type_id 
-{
-  ATOM_I2C_RECORD_TYPE =1,
-  ATOM_HPD_INT_RECORD_TYPE =2,
-  ATOM_OBJECT_GPIO_CNTL_RECORD_TYPE =9,
-  ATOM_CONNECTOR_HPDPIN_LUT_RECORD_TYPE =16,
-  ATOM_CONNECTOR_AUXDDC_LUT_RECORD_TYPE =17,
-  ATOM_ENCODER_CAP_RECORD_TYPE=20,
-  ATOM_BRACKET_LAYOUT_RECORD_TYPE=21,
-  ATOM_CONNECTOR_FORCED_TMDS_CAP_RECORD_TYPE=22,
-  ATOM_DISP_CONNECTOR_CAPS_RECORD_TYPE=23,
-  ATOM_RECORD_END_TYPE  =0xFF,
+enum atom_object_record_type_id {
+	ATOM_I2C_RECORD_TYPE = 1,
+	ATOM_HPD_INT_RECORD_TYPE = 2,
+	ATOM_CONNECTOR_CAP_RECORD_TYPE = 3,
+	ATOM_CONNECTOR_SPEED_UPTO = 4,
+	ATOM_OBJECT_GPIO_CNTL_RECORD_TYPE = 9,
+	ATOM_CONNECTOR_HPDPIN_LUT_RECORD_TYPE = 16,
+	ATOM_CONNECTOR_AUXDDC_LUT_RECORD_TYPE = 17,
+	ATOM_ENCODER_CAP_RECORD_TYPE = 20,
+	ATOM_BRACKET_LAYOUT_RECORD_TYPE = 21,
+	ATOM_CONNECTOR_FORCED_TMDS_CAP_RECORD_TYPE = 22,
+	ATOM_DISP_CONNECTOR_CAPS_RECORD_TYPE = 23,
+	ATOM_BRACKET_LAYOUT_V2_RECORD_TYPE = 25,
+	ATOM_RECORD_END_TYPE = 0xFF,
 };
 
 struct atom_common_record_header
@@ -760,6 +762,19 @@ struct atom_hpd_int_record
   uint8_t  plugin_pin_state;
 };
 
+struct atom_connector_caps_record {
+	struct atom_common_record_header
+		record_header; //record_type = ATOM_CONN_CAP_RECORD_TYPE
+	uint16_t connector_caps; //01b if internal display is checked; 10b if internal BL is checked; 0 of Not
+};
+
+struct atom_connector_speed_record {
+	struct atom_common_record_header
+		record_header; //record_type = ATOM_CONN_SPEED_UPTO
+	uint32_t connector_max_speed; // connector Max speed attribute, it sets 8100 in Mhz when DP connector @8.1Ghz.
+	uint16_t reserved;
+};
+
 // Bit maps for ATOM_ENCODER_CAP_RECORD.usEncoderCap
 enum atom_encoder_caps_def
 {
@@ -885,6 +900,21 @@ struct  atom_bracket_layout_record
   uint8_t reserved;
   struct atom_connector_layout_info  conn_info[1];
 };
+struct atom_bracket_layout_record_v2 {
+	struct atom_common_record_header
+		record_header; //record_type =  ATOM_BRACKET_LAYOUT_RECORD_TYPE
+	uint8_t bracketlen; //Bracket Length in mm
+	uint8_t bracketwidth; //Bracket Width in mm
+	uint8_t conn_num; //Connector numbering
+	uint8_t mini_type; //Mini Type (0 = Normal; 1 = Mini)
+	uint8_t reserved1;
+	uint8_t reserved2;
+};
+
+enum atom_connector_layout_info_mini_type_def {
+	MINI_TYPE_NORMAL = 0,
+	MINI_TYPE_MINI = 1,
+};
 
 enum atom_display_device_tag_def{
   ATOM_DISPLAY_LCD1_SUPPORT            = 0x0002, //an embedded display is either an LVDS or eDP signal type of display
@@ -911,6 +941,19 @@ struct atom_display_object_path_v2
   uint8_t  reserved;
 };
 
+struct atom_display_object_path_v3 {
+	uint16_t display_objid; //Connector Object ID or Misc Object ID
+	uint16_t disp_recordoffset;
+	uint16_t encoderobjid; //first encoder closer to the connector, could be either an external or intenal encoder
+	uint16_t reserved1; //only on USBC case, otherwise always = 0
+	uint16_t reserved2; //reserved and always = 0
+	uint16_t reserved3; //reserved and always = 0
+	//a supported device vector, each display path starts with this.the paths are enumerated in the way of priority,
+	//a path appears first
+	uint16_t device_tag;
+	uint16_t reserved4; //reserved and always = 0
+};
+
 struct display_object_info_table_v1_4
 {
   struct    atom_common_table_header  table_header;
@@ -920,6 +963,15 @@ struct display_object_info_table_v1_4
   struct    atom_display_object_path_v2 display_path[8];   //the real number of this included in the structure is calculated by using the (whole structure size - the header size- number_of_path)/size of atom_display_object_path
 };
 
+struct display_object_info_table_v1_5 {
+	struct atom_common_table_header table_header;
+	uint16_t supporteddevices;
+	uint8_t number_of_path;
+	uint8_t reserved;
+	// the real number of this included in the structure is calculated by using the
+	// (whole structure size - the header size- number_of_path)/size of atom_display_object_path
+	struct atom_display_object_path_v3 display_path[8];
+};
 
 /* 
   ***************************************************************************
@@ -1080,17 +1132,73 @@ struct atom_dc_golden_table_v1
 	uint32_t reserved[23];
 };
 
-enum dce_info_caps_def
+enum dce_info_caps_def {
+	// only for VBIOS
+	DCE_INFO_CAPS_FORCE_DISPDEV_CONNECTED = 0x02,
+	// only for VBIOS
+	DCE_INFO_CAPS_DISABLE_DFP_DP_HBR2 = 0x04,
+	// only for VBIOS
+	DCE_INFO_CAPS_ENABLE_INTERLAC_TIMING = 0x08,
+	// only for VBIOS
+	DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE = 0x20,
+	DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE = 0x40,
+};
+
+struct atom_display_controller_info_v4_5
 {
-  // only for VBIOS
-  DCE_INFO_CAPS_FORCE_DISPDEV_CONNECTED  =0x02,      
-  // only for VBIOS
-  DCE_INFO_CAPS_DISABLE_DFP_DP_HBR2      =0x04,
-  // only for VBIOS
-  DCE_INFO_CAPS_ENABLE_INTERLAC_TIMING   =0x08,
-  // only for VBIOS
-  DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE	 =0x20,
-  DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE = 0x40,
+  struct  atom_common_table_header  table_header;
+  uint32_t display_caps;
+  uint32_t bootup_dispclk_10khz;
+  uint16_t dce_refclk_10khz;
+  uint16_t i2c_engine_refclk_10khz;
+  uint16_t dvi_ss_percentage;       // in unit of 0.001%
+  uint16_t dvi_ss_rate_10hz;
+  uint16_t hdmi_ss_percentage;      // in unit of 0.001%
+  uint16_t hdmi_ss_rate_10hz;
+  uint16_t dp_ss_percentage;        // in unit of 0.001%
+  uint16_t dp_ss_rate_10hz;
+  uint8_t  dvi_ss_mode;             // enum of atom_spread_spectrum_mode
+  uint8_t  hdmi_ss_mode;            // enum of atom_spread_spectrum_mode
+  uint8_t  dp_ss_mode;              // enum of atom_spread_spectrum_mode
+  uint8_t  ss_reserved;
+  // DFP hardcode mode number defined in StandardVESA_TimingTable when EDID is not available
+  uint8_t  dfp_hardcode_mode_num;
+  // DFP hardcode mode refreshrate defined in StandardVESA_TimingTable when EDID is not available
+  uint8_t  dfp_hardcode_refreshrate;
+  // VGA hardcode mode number defined in StandardVESA_TimingTable when EDID is not avablable
+  uint8_t  vga_hardcode_mode_num;
+  // VGA hardcode mode number defined in StandardVESA_TimingTable when EDID is not avablable
+  uint8_t  vga_hardcode_refreshrate;
+  uint16_t dpphy_refclk_10khz;
+  uint16_t hw_chip_id;
+  uint8_t  dcnip_min_ver;
+  uint8_t  dcnip_max_ver;
+  uint8_t  max_disp_pipe_num;
+  uint8_t  max_vbios_active_disp_pipe_num;
+  uint8_t  max_ppll_num;
+  uint8_t  max_disp_phy_num;
+  uint8_t  max_aux_pairs;
+  uint8_t  remotedisplayconfig;
+  uint32_t dispclk_pll_vco_freq;
+  uint32_t dp_ref_clk_freq;
+  // Worst case blackout duration for a memory clock frequency (p-state) change, units of 100s of ns (0.1 us)
+  uint32_t max_mclk_chg_lat;
+  // Worst case memory self refresh exit time, units of 100ns of ns (0.1us)
+  uint32_t max_sr_exit_lat;
+  // Worst case memory self refresh entry followed by immediate exit time, units of 100ns of ns (0.1us)
+  uint32_t max_sr_enter_exit_lat;
+  uint16_t dc_golden_table_offset;  // point of struct of atom_dc_golden_table_vxx
+  uint16_t dc_golden_table_ver;
+  uint32_t aux_dphy_rx_control0_val;
+  uint32_t aux_dphy_tx_control_val;
+  uint32_t aux_dphy_rx_control1_val;
+  uint32_t dc_gpio_aux_ctrl_0_val;
+  uint32_t dc_gpio_aux_ctrl_1_val;
+  uint32_t dc_gpio_aux_ctrl_2_val;
+  uint32_t dc_gpio_aux_ctrl_3_val;
+  uint32_t dc_gpio_aux_ctrl_4_val;
+  uint32_t dc_gpio_aux_ctrl_5_val;
+  uint32_t reserved[26];
 };
 
 /* 
@@ -1806,6 +1914,63 @@ struct atom_smu_info_v3_3 {
   uint32_t reserved;
 };
 
+struct atom_smu_info_v3_5
+{
+  struct   atom_common_table_header  table_header;
+  uint8_t  smuip_min_ver;
+  uint8_t  smuip_max_ver;
+  uint8_t  waflclk_ss_mode;
+  uint8_t  gpuclk_ss_mode;
+  uint16_t sclk_ss_percentage;
+  uint16_t sclk_ss_rate_10hz;
+  uint16_t gpuclk_ss_percentage;    // in unit of 0.001%
+  uint16_t gpuclk_ss_rate_10hz;
+  uint32_t core_refclk_10khz;
+  uint32_t syspll0_1_vco_freq_10khz;
+  uint32_t syspll0_2_vco_freq_10khz;
+  uint8_t  pcc_gpio_bit;            // GPIO bit shift in SMU_GPIOPAD_A configured for PCC, =0xff means invalid
+  uint8_t  pcc_gpio_polarity;       // GPIO polarity for CTF
+  uint16_t smugoldenoffset;
+  uint32_t syspll0_0_vco_freq_10khz;
+  uint32_t bootup_smnclk_10khz;
+  uint32_t bootup_socclk_10khz;
+  uint32_t bootup_mp0clk_10khz;
+  uint32_t bootup_mp1clk_10khz;
+  uint32_t bootup_lclk_10khz;
+  uint32_t bootup_dcefclk_10khz;
+  uint32_t ctf_threshold_override_value;
+  uint32_t syspll3_0_vco_freq_10khz;
+  uint32_t syspll3_1_vco_freq_10khz;
+  uint32_t bootup_fclk_10khz;
+  uint32_t bootup_waflclk_10khz;
+  uint32_t smu_info_caps;
+  uint16_t waflclk_ss_percentage;    // in unit of 0.001%
+  uint16_t smuinitoffset;
+  uint32_t bootup_dprefclk_10khz;
+  uint32_t bootup_usbclk_10khz;
+  uint32_t smb_slave_address;
+  uint32_t cg_fdo_ctrl0_val;
+  uint32_t cg_fdo_ctrl1_val;
+  uint32_t cg_fdo_ctrl2_val;
+  uint32_t gdfll_as_wait_ctrl_val;
+  uint32_t gdfll_as_step_ctrl_val;
+  uint32_t bootup_dtbclk_10khz;
+  uint32_t fclk_syspll_refclk_10khz;
+  uint32_t smusvi_svc0_val;
+  uint32_t smusvi_svc1_val;
+  uint32_t smusvi_svd0_val;
+  uint32_t smusvi_svd1_val;
+  uint32_t smusvi_svt0_val;
+  uint32_t smusvi_svt1_val;
+  uint32_t cg_tach_ctrl_val;
+  uint32_t cg_pump_ctrl1_val;
+  uint32_t cg_pump_tach_ctrl_val;
+  uint32_t thm_ctf_delay_val;
+  uint32_t thm_thermal_int_ctrl_val;
+  uint32_t thm_tmon_config_val;
+  uint32_t reserved[16];
+};
+
 struct atom_smu_info_v3_6
 {
 	struct   atom_common_table_header  table_header;
-- 
2.35.3

