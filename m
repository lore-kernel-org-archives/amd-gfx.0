Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2CCC61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4297310E763;
	Mon, 31 Aug 2026 18:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMoTv37B";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D62E10E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWt8dQOyTJrSVsWCgbHac6CXMz+EsL4RaVn681yDN5YOr2N5kMK/L5l/uOtpim1uNXQ3HmWBRukBkXoq6mSP5jxShKI7+X7rkfBpS/lKJD25HP4tBMHBFcgYUDPokiuq5e+4ERjPQvdVCey6C5+E+aks4HhTIeMQqdm2etbRtcDjTL7uRjU08QXVz0iokxmrE5evE0fP9vdwyjkCY3Pgv8HCF+DRPL/vg6O2B1uyae0dOVVS36RWcy8G6EV3aG9Zj7avkt4+Sl6Z+v0yiv1iJ5W6RtNsq9FtQJe+u1/KOh/p3c1MxK76TPfCxvxXzueBPRcnVz8MPZPdE0YIaK6Ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z0/UUGxTtFRXbjXQJEiZ30hBemJhwnjr3p9zBL2W/g=;
 b=fbahUUwVwu/mqlTR3OYXCphYFUVpJJgr+7M0kNEv0S8Fkj7UFhz05KbzRQZaIv/qIcFc2wdVIFvlqeFmzZXljxL8yIlL5zo9XjnY/bwUaxxwZsJXbI15UrnXW+1SDCSe8oTZT6FnSqfEQlAbO4Y7y3ezZVNPfIStvt3ozR+tBB0YS/8nFxAXSyMRje1jJKY5E43fBnqjOlE3Ong3VqZEZVJyrFUTEvOFV+7w1O1D6DoAzeEZe+tHDN4DbwuR7a5CrVh4XPtzGxgGGdCYcW+9QRaZU2SIDMCfF1uERHiqeapcBfkb0b08NdcQKaeZKPMVnWkfS6tP+YV13XSOloGpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z0/UUGxTtFRXbjXQJEiZ30hBemJhwnjr3p9zBL2W/g=;
 b=tMoTv37BgZ50LAXubhXFkc+FzyXwuHf4TIZGvYq8g+KinLaMQdHhITJSiG55UOb4GqjVWJnUg6pvTrq2M1wPy6ORSLnVzs8GEV5rOMbgukFcJ1b/1+ecjF48dS/zt0wc9BUjU06q8+/TAo3oc0D1wj1RXSbXu/PmmFOynCZv71o=
Received: from PH1PEPF0001330F.namprd07.prod.outlook.com (2603:10b6:518:1::a)
 by IA0PPF002462CFE.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:16 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2a01:111:f403:c801::2) by PH1PEPF0001330F.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/95] drm/amdgpu: Add psp ualink command interfaces
Date: Mon, 31 Aug 2026 14:26:20 -0400
Message-ID: <20260831182754.1089811-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c68f664-74f0-4246-ff83-08df078d9eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: biuMxRbD5svXcF0/y6ggjX7pNm5V0nDzcFdVmwaCAUprYecaY9amOipbhGDlcp2Y8j9ti0LfB9O1eFW0oYNEHr/6DFdox5YJZTwql9meSotjRUQQ3JcVoO9ZT32VEy1MBHB88rTjlgwfr6Uoq8GK21vvWx+ggsBM2Fix2teLS1LBfMl/pao30HhhA6TdVU60mjmwq768HQ/nYaxeNfHl1g1qijPXI5wRa1V/PmFKmxYiMWPkb86D4dFHWxCdco9EXj7AuLjAJp0JOAJikh8fnCNakV7GHf5MqiH0s20+m9s4doOfDcvwv0+iCxXyOJkwCqRGpfjnR/8utaOBY4suDpZlIvvb8kUkHjkmq6HmC5/8HwmXNenS9CMZ5rNFTsAnzgP/yZE+Vq5uvtgGNDNM8F5ftsp7x9nUBWFMWFK+yr4TFSqfdOgoaw/IYM7QZjLjZ/t6B+pbpqVApRkXaC/ZV+qBgNR7zYU0o2XApCYkFdSW4B/C9AqyqxH0HFD0Kb52G4xFP0W8Glg4w1KVYGEOjCySnMZTwWi1tpGs+KrMEhCyFaMzgvyolj4Y+LcPhv8PSm/BGkksM1+O+m/bo9BhRxZYzuju+uDFEFTfEaMyc7P6WM1xArWiaE+U2dl/wKWQOl8QtB0pClA48me3z8EuFUYDfZLm2iPI/8zHrHFqxmP2Ehst6Xx4CvAnAeS1ltfWbMfF0cCT+C5mmje6GNvsXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fz2GDgxgUYakIFDdbScN3Cg0lE+KkZgdxd5IEysP2YVqeEnkA35ALgEHzH+2Ed6/Xfmi6VylvDmRKg1qH2U5cOdIqPpiMd9eeptmB0QlVPiJ8oHwZx+V+DViMEQ/Gx0z9lMdptF/6daApwhGECJ91vhnvKnYm5yfKNB0LvF65afqP5Gg8RwlzKVZ72GmGXFvUWI+6TzJUDkCLjALjuNpchpz5W+FMQVUFFLeksU/pOV8HVxqc1l7tezsWvptGHH5hzbaJEwMxkwELoMeUYmO191qsE9eBGIJjAl679ICKkQdUUuQmbgMfKK65367BKOWLzHGq/b1goUr52xp7+9r/RoTDPVmwhs1EVaxk1K0Qij5bFy5a5o0k9CaoJeWr4Sfzp13DDFjw+lZ2nlWoRM6LgGwuShPXtXo+FRf/9jJq4Mf93uEdyalAcTCTeQvCF32
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:14.5164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c68f664-74f0-4246-ff83-08df078d9eca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add asp ualink command/response structures

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 126 ++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index ad618b78685f6..6bcc04109d4cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -53,6 +53,13 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
 };
 
+typedef enum
+{
+    GFX_CTRL_ADDR_TYPE_AUTO_DETECT = 0,
+    GFX_CTRL_ADDR_TYPE_SYS_PHY_ADDR,
+    GFX_CTRL_ADDR_TYPE_GPU_PHY_ADDR,
+    GFX_CTRL_ADDR_TYPE_GPU_VIRT_ADDR
+}  GFX_CTRL_ADDR_TYPE;
 
 /*-----------------------------------------------------------------------------
     NOTE:   All physical addresses used in this interface are actually
@@ -110,6 +117,13 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_PERF_HW            = 0x0000004C,   /* performance monitor */
     GFX_CMD_ID_FB_FW_RESERV_ADDR  = 0x00000050,  /* Query FW reservation addr */
     GFX_CMD_ID_FB_FW_RESERV_EXT_ADDR = 0x00000051,  /* Query FW reservation extended addr */
+    GFX_CMD_ID_UAL_GET_INTERFACE_VER = 0x00000053,  /* Get UAL interface version */
+    GFX_CMD_ID_UAL_GET_CONFIG        = 0x00000054,  /* Get UAL full config */
+    GFX_CMD_ID_UAL_SET_PPOD_CONFIG   = 0x00000055,  /* Set UAL config */
+    GFX_CMD_ID_UAL_SET_VPOD_CONFIG   = 0x00000056,  /* Set UAL vPod config */
+    GFX_CMD_ID_UAL_SET_STATION_CONFIG= 0x00000057,  /* Set UAL Station config */
+    GFX_CMD_ID_UAL_SET_NPA_CONFIG    = 0x00000059,  /* Set UAL NPA config and VMID */
+    GFX_CMD_ID_UAL_SEND_COMPLETION   = 0x0000005A,  /* Ack from driver after UAL config completion */
     GFX_CMD_ID_SET_MMHUB_ECO_SEC_LEVEL = 0x0000005D,  /* Set MMHUB ECO sec lvls on VCN block */
 };
 
@@ -382,6 +396,100 @@ struct psp_gfx_cmd_req_perf_hw {
 	uint32_t pref_format2;
 };
 
+#define PSP_GFX_MAX_LOCAL_GPUS_UAL_V1   16       /* max gpu per local node */
+#define PSP_GFX_UAL_MAX_STATIONS_V1     64       /* max UALink stations */
+#define PSP_GFX_UAL_MAX_ACC_BIT_MASK    32       /* max accelerator bit mask 32*32 */
+
+enum psp_gfx_ual_npa_address_mode
+{
+    PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_ALIASING = 0,
+    PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_IDENTIFICATION = 1,
+    PSP_GFX_UAL_NPA_ADDRESS_MODE_MAX
+};
+
+enum psp_gfx_ual_ports_per_station
+{
+    PSP_GFX_UAL_PPS_1 = 1,    // 1x 800Gbps
+    PSP_GFX_UAL_PPS_2 = 2,    // 2x 400Gbps
+    PSP_GFX_UAL_PPS_4 = 4     // 4x 200Gbps
+};
+
+enum psp_gfx_ual_link_type
+{
+    PSP_GFX_UALOE = 0,
+    PSP_GFX_UALLINK = 1,
+    PSP_GFX_UALMAX
+};
+
+struct psp_gfx_cmd_set_ppod_config_ual_v1
+{
+    uint32_t accelerator_id;     // Accelerator ID
+    uint8_t  ppod_id[16];        // Physical Pod ID
+    uint32_t ppod_size;          // number of gpu in physical pod
+    uint32_t bandwidth;          // Bandwidth
+    uint32_t latency;            // Latency
+    uint32_t local_accelerators[PSP_GFX_MAX_LOCAL_GPUS_UAL_V1]; // local accelerator list, sorted in socket-id order
+};
+
+struct psp_gfx_cmd_set_vpod_config_ual_v1
+{
+    uint32_t vpod_id;                       // vPod ID
+    uint32_t vpod_size;                     // number of gpu in virtual pod
+    uint32_t vpod_active_accelerators[PSP_GFX_UAL_MAX_ACC_BIT_MASK];  // accelerator ID list in each vPOD
+    enum psp_gfx_ual_npa_address_mode addr_mode; // NPA Addressing Mode
+};
+
+struct psp_gfx_cmd_station_config_ual_v1
+{
+    /* Number of valid stations in this configuration
+     * Only lane_en_bitmap[0..n_stations-1] will be processed.
+     */
+    uint8_t num_stations;
+    /* Station configuration flags
+     *
+     * Bit [3:0]: PortPerStation (PPS) - 1, 2, or 4
+     * Bit [7:4]: Reserved
+     */
+    uint8_t station_flag;
+    uint8_t reserved[2]; /* Future use / alignment padding */
+    /* Bitmap of enabled lanes for each station
+     * in logical station order.
+     */
+    uint8_t lane_en_bitmap[PSP_GFX_UAL_MAX_STATIONS_V1];
+};
+
+struct psp_gfx_cmd_get_config_ual_v1
+{
+    uint32_t ual_cfg_addr_hi;               // UAL Config Buffer Address Hi
+    uint32_t ual_cfg_addr_lo;               // UAL Config Buffer Address Lo
+    uint32_t ual_cfg_size;                  // UAL Config Buffer Size
+    GFX_CTRL_ADDR_TYPE addr_type;    // Buffer Address Type
+};
+
+struct psp_gfx_get_config_ual_v1 {
+    enum psp_gfx_ual_link_type link_type;
+    uint32_t accelerator_id;
+    uint8_t ppod_id[16];
+    uint32_t ppod_size;
+    uint32_t bandwidth;
+    uint32_t latency;
+    uint32_t vpod_id;
+    uint32_t vpod_size;
+    uint32_t vpod_active_accelerators[PSP_GFX_UAL_MAX_ACC_BIT_MASK];
+    enum psp_gfx_ual_npa_address_mode addr_mode;
+};
+
+struct psp_gfx_cmd_send_completion_ual_v1
+{
+    uint32_t cmd_id;
+    uint32_t status;
+};
+
+struct psp_gfx_cmd_set_npa_config_ual_v1 {
+    uint32_t vmid;
+    uint32_t enable_npa_translation;
+};
+
 /* All GFX ring buffer commands. */
 union psp_gfx_commands
 {
@@ -399,6 +507,12 @@ union psp_gfx_commands
     struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
     struct psp_gfx_cmd_fb_memory_part cmd_memory_part;
     struct psp_gfx_cmd_req_perf_hw     cmd_req_perf_hw;
+    struct psp_gfx_cmd_get_config_ual_v1    cmd_get_config_ual;
+    struct psp_gfx_cmd_set_ppod_config_ual_v1 cmd_set_ppod_config_ual;
+    struct psp_gfx_cmd_set_vpod_config_ual_v1 cmd_set_vpod_config_ual;
+    struct psp_gfx_cmd_station_config_ual_v1  cmd_set_station_config_ual;
+    struct psp_gfx_cmd_send_completion_ual_v1 cmd_send_completion_ual;
+    struct psp_gfx_cmd_set_npa_config_ual_v1  cmd_set_npa_config_ual;
 };
 
 struct psp_gfx_uresp_reserved
@@ -432,6 +546,16 @@ struct psp_gfx_uresp_perf_hw {
 	uint32_t pref_format2;
 };
 
+struct psp_gfx_uresp_get_intf_ver_ual
+{
+    uint32_t intf_ver; /* [31:16] major version, [15:0] minor version */
+};
+
+struct psp_gfx_uresp_get_config_ual_v1
+{
+    uint32_t resp_size;
+};
+
 /* Union of command-specific responses for GPCOM ring. */
 union psp_gfx_uresp {
 	struct psp_gfx_uresp_reserved		reserved;
@@ -439,6 +563,8 @@ union psp_gfx_uresp {
 	struct psp_gfx_uresp_fwar_db_info	fwar_db_info;
 	struct psp_gfx_uresp_fw_reserve_info	fw_reserve_info;
 	struct psp_gfx_uresp_perf_hw		perf_hw_info;
+	struct psp_gfx_uresp_get_config_ual_v1  get_config_ual;
+	struct psp_gfx_uresp_get_intf_ver_ual   get_intf_ver_ual;
 };
 
 /* Structure of GFX Response buffer.
-- 
2.55.0

