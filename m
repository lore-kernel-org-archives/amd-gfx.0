Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8BDC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AA410E350;
	Fri, 21 Aug 2026 19:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gsLvr8hn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838DA10F3D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lom40iQNFnpRlDyGqkPnW5Nk4YpCGh9D5+RC/Ui4WaapQY3BYiOXM0ckotI4svgPFMQBOseBDSVlgKqdVNzMnPbfpVRg5nPov/UEHcFmUcR8nfJJtNe7Zoib1dCU4TiRTnwn9KTHBoPkJfn8c0nNmPbBTxYKfDpIdODfv7mBjqMWP4KGUQZJ1YMP4xdAgTkiCr0LWmr8N9tciFSonz/VBTtvg2/qHqV6oDUBdgt+jG+e/K2Hc1JU1xpYalIabdiMol4ybd5cduzoM+3+Ulnz7Akd6dhtd9JYRdeK0IkapGvNTyx5rVggI/e/UpdQOCFp6QrjMGNVCs7kcPKpnphOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z0/UUGxTtFRXbjXQJEiZ30hBemJhwnjr3p9zBL2W/g=;
 b=DByqLyrjGq7xroT6qar3nxSvfxMBS9QxxKOiKPMRKYpcYu4Jpi9KBhoE7fqhyV4XZHg2soOnlgU6rLjpoAC/hKrey3YyctqJeShGJ+NAH6gBsEdfMFGKsS2cGStHn8yrGpK9An3OP/+eSSPcIRJPE835phXCCbCA3I/OrSbufh/ZX8QzWidYYtXWq18TNz1VF5+yiU+UNf+c42nwNL5rq5F3PAHp3KiQn+ZQL9zq5JozXMG0tgomp0emWDw/qztv2lDjskqcmCrJE91XJ132ElpdCLyOnVJ01GO07ANccJmrH837S0CkFYWDUIqopF+3BCQrhfR+HlbVAEdTjkF1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z0/UUGxTtFRXbjXQJEiZ30hBemJhwnjr3p9zBL2W/g=;
 b=gsLvr8hnkHbAx1qqoETPMF767z7/d5y1cA0FNRmX/qhxB2m1OBl1F72I8IK05Jp2aLiz5Mqq5Lu5POpzL1fYEIFj96qq6vbHA6rpSWnV6wNfRAav2MERs4ip8MXjOPwFlUC3HbV0+/6985KN0ipbeOQiv/KQocDL4R6j62r92J4=
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:15 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::3e) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/95] drm/amdgpu: Add psp ualink command interfaces
Date: Fri, 21 Aug 2026 15:33:24 -0400
Message-ID: <20260821193458.808626-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6bedcc-2fbb-4f29-8910-08deffbb527c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1pYGB3EF0Q3VBrgXErsAgqiqjKvrRWJfbgJ1BSl5DjC85hpK8NKpEIAlXtvgmsDBjxHBHYYZNLgDiicH4P8yyjGCM7xqCK6UqYDJXy4DqLscgM9GKjZz3mikHlDXgMsdJ3Wq/VmQgOsS2p0KPObQlH3sfuH4A+8+rtrjVb0W5pJM9sLdoB/r+Pc4ZhPyKCf5jV0Htmf3dGO5eXeo/1vTx/vSXmAlRfhGTa/HR0Dzmm9RjgGjPdJwUVZzBw+SvlasVwbhQqZvHK9ZqNL2lE9X+6Tc2GEu8HJ+RaSzVhGrXx7kYgBSNRtNw3xt2JF7kb0o/qxy1yBiLC1TbVijIJBBkKz8szBEkE0a4YasVbBBiyQGWM79shoBY+fFLuuDnUDoGOZAQa1otEfaEiaTFtT6tN+IhE0aofZLKE2GDir0/sjZmriaaX2qumrc4+nY8eFicBzCbaudUHIiYEojoh+DvuD/EaXKt/L/PdAR0InkO+GrpefjmgEMJMgGUA3wc91wq0hTEVTd8DIs+pmsOqH8/LZxZljMuKJV9FcMjkhxHUbC5NlFUUXFnyYECYaPG0+zLN8wl3uDZTj4WIW9rzft/ydfYJnBvIVBCEZzqB56IintTeQJiRTDk5hGOkK2nWdooPoAw5M4TPMSHzfrrQMeU3usr9siNvIxrUWAnebkOBvKIFziPDUoloHfzYansRzplOVH8+FKOkBl/6Jdsd7Qvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: flEi0KLhh3y+reoOIQ5Du/tgfMbpHuP7idx/8GA51AjaVl0oF9fp5FbatYTSyBaxdA8gt/Um5OEittoTn1REolrEbsusKdquqEU0PgJ6XcH39/2y0kfwebvuZ5go1ybMCvcDtwoJaafIf/QeU+xZB6kCZKQwXfmT++lm+SsL3ieBZmdEwGXJ2KOORPn4f3TQDkvV8PNveCnrER7/ORDhxT3enl6tFQ2ntkjoe80rfXH5tNyEZknHPQXd7KZkN9Tfk/zLNRjns0HgacRbEFIP/fFovG4G+Cx2N1VVm0Q+tqPspQ+z5rUKFvtW8DNd7ol3td9ZK9TUrf/JsWp29wHiBgSs1vjBUSOiXlbhRq/GvMGE6rDe+75ez+KY5CtynRup+8WURMbTQejDjDEvlSbFQ8WRiJNvJTt988rJEnhR0UjpKeaAe42fkhXCMDGxw7Y9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:14.0495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6bedcc-2fbb-4f29-8910-08deffbb527c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
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

