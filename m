Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56A4D39013
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3580610E683;
	Wed, 14 Jan 2026 20:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4hkQhIaH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79610E681
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reVI7//Z1/bkWjFMNoQWW06nBfdG79zA+l1r4Fv81brQQ9UzTnwbd5h5nrdYtuSo+wV2xa7ZWiQu1ogbNuxzefBDFlI49jqT/83MhZOJ0lwyuO2cLy/zCWcLyl3AhvLpufixiPJtE0XK//HnADdVAJ4nXiv+tFJuT4fWNx6Eyc/lCMMBbEA0GvNpN7KB9yYcJ9Km518pw09BG+zJQLjhf5dljg9+LXRkZcMdaO9KNIM9MgPA1I7Adu/yqGlIK1KnwzHXGGny5bFnmbi0ZneIWMPrnAM5B5AA7p+Hf6waMg5Fw8PRAw76OXFwRt2KEQOIkKbJGUrFG5Tmuq8gFKuwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiGl7XRVzJvqNyng9SUIkz58vBLhDFAYk9LicRrfJFk=;
 b=OQ4jsGv6Tu3oMPldrDrFtGEIuZoYbXfi5g4988NXmk8D1FlUxcp6LdY5Wo1Is2DskhJMDB+404tTTM5n0ygIaoYH/oqHrIBzmE+PcMDHzGy1b4aFed1WjRdXOSb1dwiFNcXlpaVxwjki9OTEepYEiFsnL/NrRYgs7sDT6ZEhxkBEEuWa1bb8bKLStWtdgeMZGrvzpWe7ugnoNDv48uw+s9y5xwdPzdF+b7QmlJ9Tn7pNG0np0Uz8d3igXujrZDonj7PmN6BFehloMmaIeIHPbTbreheFh77UaPW3s5Mzv0pxejzyZywTWNQZzNeWCV14wprXqkoXKbokFivAJfv4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiGl7XRVzJvqNyng9SUIkz58vBLhDFAYk9LicRrfJFk=;
 b=4hkQhIaHzFeDeh2Bn2yyKmNOasytp00TK1BvhT+Fj1/E82xkn1VoavIvYpFq3Vb2Ktf5hgmbQWTkjmwvkpHdFFtCP4uR1BkUMcTu0U0L1ju4kzivrVYHEZN0l74+ORvQ2KHreuA3P84uDwq4RufAyGhHDCIGEgz0IQna/QLJfqY=
Received: from SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::27)
 by BN7PPF49208036B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 20:24:09 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::fe) by SJ0P220CA0017.outlook.office365.com
 (2603:10b6:a03:41b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 20:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:03 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:03 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Matthew
 Stewart" <matthew.stewart2@amd.com>
Subject: [PATCH 04/14] drm/amd/display: Detect panel type from VSDB
Date: Wed, 14 Jan 2026 15:21:45 -0500
Message-ID: <20260114202421.3654137-5-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ffde54-b777-400f-5f10-08de53aadf57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FRyWb16kPckjNPfQBOBS2OzhaT5Z/gQBbTMBcRRdCRVo/6v9qpA0Zoe2+P1K?=
 =?us-ascii?Q?tdpLKOf2oiR8er/nLRSxOVW2lyiiK+JDZmj7gyoeG8Wz+ItMSDOHcFFAPHFK?=
 =?us-ascii?Q?TIMRKjK5uPofxQ6KLnr/H0WUGvVSPojpRdXh+IfVgiPRratEmQbOdIdQVTHJ?=
 =?us-ascii?Q?kVkZKGszkr2L/Oc4doybKxW/bz2z5jtIbyyN8Hkf4IBa+Wgcy8hTRzAW6ABw?=
 =?us-ascii?Q?2Qdi/aKf7Ulkl6ML0qWh2FvAOsUefrzdZ4MhIEuClbg4SUxuYOtgM3Vna+xM?=
 =?us-ascii?Q?HkU2OroNj+JCsPzu77yMyRzvLcYlgX9DeHe/DJfuAwGtLl6EZI20Fp18Cs+g?=
 =?us-ascii?Q?onxA0WanD0pPn7mfeQV3fAIMRsTn+54WZmp1qylDYmxVU8Vwnm2ka+yyRKyQ?=
 =?us-ascii?Q?8YnFDkG9k3LCIX4n+KFVpNkdqp5hIeiMk1SfKpzT8c2PGk1dI5Jg+x2qh0jZ?=
 =?us-ascii?Q?eyXKMa79KlKylIbmYgGZsGAlJzZZnQYUelSCq5h67sqgBWIsaOxH+7XrzFdy?=
 =?us-ascii?Q?OmNTNLyTpK1Yd3ECIOe5LDIoQJrfzfvvTWPLaAS5SA+6iPb0Uo1+6nYkdO8b?=
 =?us-ascii?Q?QtCzcUYrDgZBg37FcE6I0HDYAagmOtY/QWsIAvXA+oYa8cUV6OvMF7uO3P3A?=
 =?us-ascii?Q?c1CWNZFlRJRNOrrjELIs1ZoFgaYtjvj3HDtori0neib7wU+fym0b5WLmCAls?=
 =?us-ascii?Q?r4NRDCGKRERGdJ/JfUhzApf0f69Yf9FDsYgOTXUznv9iO5M9kkSPa0t7Z1Xt?=
 =?us-ascii?Q?yM7vRKe5hGbZYU+AR8zmA8bHWP8eWwHUIb+vkD/lYUXSM1FloX+UAvwwL4P9?=
 =?us-ascii?Q?NWK0GtPbBVS9t4JIRFo8FwBjZs2CbC4dXTROMlJ/zs7C0Oeq3sIEErzcpjWr?=
 =?us-ascii?Q?nO9I8Bnt6N8iyFP22lQSrqYIl44/J7/l8UM0u5af2lohueEFjgRzJUrHmdMx?=
 =?us-ascii?Q?0CrrRBl/6RGjb8mHWjptqkilfrQq71cZZZAYgH3cPzhs5L+900E/dmzf8qvS?=
 =?us-ascii?Q?ORshpOxP/QzarjmCAZj9Fh+MHe+kuGu422uZ3ryaDNULUJAwcJPJVQM3djWX?=
 =?us-ascii?Q?FDDUwfcyQ7PrqCW1YrRNHNletynOB3a1tpvp/gC91Lia/Hsz90XWt5bVlE5M?=
 =?us-ascii?Q?1FApkcAKzHPtb8uKctlEquFiaMfdgo2Q2Utid5LV8VndcgrrwZVqf+bq4Ze6?=
 =?us-ascii?Q?dyVMmDfpYHL13QuEHN3HPzJEDhmwM4rm3CdnQwcRPaj+i7058vMNCrNOG09v?=
 =?us-ascii?Q?v+g5+kNOyY/3ZwXqTdEWongL+MTACeUf4DuGpmdVQzT49KUiozwW2EmMV71R?=
 =?us-ascii?Q?e9iVur8bWMEWp768zvUxHSGcHN6gynsJXx9He/oAtPC1TjUt3kkCGrpVRFgL?=
 =?us-ascii?Q?kw1XbzulnZK4x7vTaWRQs3JX/bLMt272gJB93PS3uiz9aaFZQh2vVh/J7whF?=
 =?us-ascii?Q?24bjREPlmV1zP1e7QPu2BKrwBIIi81sb2adBHw3uA7vbXNxjyLTN/QffT8Lf?=
 =?us-ascii?Q?iYFfd9cfoTBSjQLrRX36t1rbceZpCe5NGCYK9epJeohBRvcEf2DU48lbGfPq?=
 =?us-ascii?Q?qXdpclqn/jYHt7mP8r65upD/Ke3yNuDSaykQuU3Z5kIv9AXAgV2PY4WpOCj9?=
 =?us-ascii?Q?WlvC8oEWjvQW+qwUm42pShMNaxvxsDmuCrt5+MT53UFh/7LnrO6wyfU+8haf?=
 =?us-ascii?Q?44RI/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:08.9010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffde54-b777-400f-5f10-08de53aadf57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[Why]
The AMD VSDB contains two bits that indicate the type of panel connected.
This can be useful for policy decisions based upon panel technology.

[How]
Read the bits for the panel type when parsing VSDB and store them in
the dc_link.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h               |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h         |  7 +++++++
 4 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fc5ceec5459f..b22925d1a59f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13110,9 +13110,24 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 
 		if (ieeeId == HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID &&
 				amd_vsdb->version == HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3) {
+			u8 panel_type;
 			vsdb_info->replay_mode = (amd_vsdb->feature_caps & AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE) ? true : false;
 			vsdb_info->amd_vsdb_version = HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3;
 			drm_dbg_kms(aconnector->base.dev, "Panel supports Replay Mode: %d\n", vsdb_info->replay_mode);
+			panel_type = (amd_vsdb->color_space_eotf_support & AMD_VDSB_VERSION_3_PANEL_TYPE_MASK) >> AMD_VDSB_VERSION_3_PANEL_TYPE_SHIFT;
+			switch (panel_type) {
+			case AMD_VSDB_PANEL_TYPE_OLED:
+				aconnector->dc_link->panel_type = PANEL_TYPE_OLED;
+				break;
+			case AMD_VSDB_PANEL_TYPE_MINILED:
+				aconnector->dc_link->panel_type = PANEL_TYPE_MINILED;
+				break;
+			default:
+				aconnector->dc_link->panel_type = PANEL_TYPE_NONE;
+				break;
+			}
+			drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n",
+				    aconnector->dc_link->panel_type);
 
 			return true;
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5775c722dd92..0855237ff048 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -55,8 +55,17 @@
 
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
 #define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
+#define AMD_VDSB_VERSION_3_PANEL_TYPE_MASK 0xC0
+#define AMD_VDSB_VERSION_3_PANEL_TYPE_SHIFT 6
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3 0x3
 
+enum amd_vsdb_panel_type {
+	AMD_VSDB_PANEL_TYPE_DEFAULT = 0,
+	AMD_VSDB_PANEL_TYPE_MINILED,
+	AMD_VSDB_PANEL_TYPE_OLED,
+	AMD_VSDB_PANEL_TYPE_RESERVED,
+};
+
 #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
 
 #define AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS 1500
@@ -89,6 +98,8 @@ struct amd_vsdb_block {
 	unsigned char ieee_id[3];
 	unsigned char version;
 	unsigned char feature_caps;
+	unsigned char reserved[3];
+	unsigned char color_space_eotf_support;
 };
 
 struct common_irq_params {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6daa35cd96a8..94f62cf2cd30 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1734,6 +1734,7 @@ struct dc_scratch_space {
 	bool link_powered_externally;	// Used to bypass hardware sequencing delays when panel is powered down forcibly
 
 	struct dc_panel_config panel_config;
+	enum dc_panel_type panel_type;
 	struct phy_state phy_state;
 	uint32_t phy_transition_bitmask;
 	// BW ALLOCATON USB4 ONLY
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index bb1387233bd8..0e953059ff6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -964,6 +964,13 @@ struct display_endpoint_id {
 	enum display_endpoint_type ep_type;
 };
 
+enum dc_panel_type {
+	PANEL_TYPE_NONE = 0, // UNKONWN, not determined yet
+	PANEL_TYPE_LCD = 1,
+	PANEL_TYPE_OLED = 2,
+	PANEL_TYPE_MINILED = 3,
+};
+
 enum backlight_control_type {
 	BACKLIGHT_CONTROL_PWM = 0,
 	BACKLIGHT_CONTROL_VESA_AUX = 1,
-- 
2.52.0

