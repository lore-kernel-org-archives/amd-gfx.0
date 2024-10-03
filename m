Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9A8CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E4110E995;
	Thu,  3 Oct 2024 23:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiDu7Im1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5897510E995
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvTTWL1Ql3mYLhhnXMC1Kyyaa4vtIWL7QLbx5LE0MZdI5zo+Dq+4eCGMJ6TtIZ1EYtGzeJpaFm5xUpo7MiiYMYfECdp3BbCzsUwqIGjLlmJQBUrq5pr/pFM530s772IiayPO1Ao5OuA4qCkNOvXsO2hoNG8wepHdHheuKRnc3BwtbIksatNnhfPJ4IHnOpgA7kidiBKqqXIxjnp401h9avtrO8V5b47DFShsglxcKhG57MJNK2l/03pvaCCHiBaqFxw3gTBTA5a85LwWExu8ahgX6ZQwfFtXjwm+2Lid1LymSxLwwOVGvobyVk67hiEAPd9n/GreV5RofoM9bMZM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJUpKipL2wfw3p55PzTgL+Z0ZesRBK/u/mRjYdQrj2Y=;
 b=E6BRsDxd0D3c+dp25l4PH2OrBXPFIJ7QFuhvrcDlBFrh2UUp46ue78U6LSHnTfYvkChyWSmUP4Rf9DiThlLL8lmFjhoTsEgFcr0Ce0+wOMGbUXD8tN3G14y23g7W7Qm2YHlwEpxpp3IGR52PqdPNgRkdkhbsj8G06Mi20eykUs5Qc6f5s4Rn4SQ3lu1mVjlHlv/J/8Tme4ciSU+xhoms2RWiwhqJwy+BZ4QzjMkvrT6nlNVoOdDplobDnUGVJO6SqK0PIJ/g5QKzq+OqFezb2DTZOexp0/AxjxAmvWIBrNBgpoMWZpHINTY0NgNHHu68arjlAiq9eUMdbuWC/nqh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJUpKipL2wfw3p55PzTgL+Z0ZesRBK/u/mRjYdQrj2Y=;
 b=GiDu7Im1G56AJ6s0aRpRZHo+VhH4c2g4kM0L7+MNmiahzkjUeFC3FT21oMO7tyPLmYmSVg0BGhm/lM3cjt3zszjr2v1+gtyNhsMX5yvz/3XLwOC8Ike82VDt26MomaFZLCOSf7Zj+ZYwGBmymdBY+Z/ztLmxF5/1pLB26ftWptc=
Received: from DS7PR03CA0272.namprd03.prod.outlook.com (2603:10b6:5:3ad::7) by
 PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:35:46 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::66) by DS7PR03CA0272.outlook.office365.com
 (2603:10b6:5:3ad::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:45 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:43 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fudongwang <Fudong.Wang@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 05/26] drm/amd/display: force TBT4 dock dsc on
Date: Thu, 3 Oct 2024 17:33:23 -0600
Message-ID: <20241003233509.210919-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea334e7-6424-4ab6-c199-08dce4041aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9o6HgidD7+MnJa/JZSIF7qwDKahFHRPxAM8Rd1/E4vYhGP//ZBh3XEHrQoH3?=
 =?us-ascii?Q?h1Ya3IZn49kcIke9vN40GZesO8awpLc1hXWDKQrlx5HB/8cw1ves30FTDUI9?=
 =?us-ascii?Q?q+zkYxqaYk8K42s0jgppX7Ev8iI0Xc+8dkvNPHo7/BKFa88LYZjgZGTB4VpU?=
 =?us-ascii?Q?f6V+6zdGedBajHiqHjDEoIqHMzLI9Qw8LGKjxOGywFGfb/+dIIKdPj70jB0M?=
 =?us-ascii?Q?HGKe00uOsXm3jPT8Qum5KWabk0UagX+fPEUe8o4bnAanAO9mS50bYY55mdez?=
 =?us-ascii?Q?qUwm1njFAZUHigAajQISFKLleDM5JZd1BlJozd0GjS57/vdZ1n3NM/0U1fke?=
 =?us-ascii?Q?W6EiZknkvcYG0BOjE/a3X9zFnB4h7PNXwhOF5BbAVlTTpQdDtqbuzDIZtPdw?=
 =?us-ascii?Q?dR0C0Mbo0rffyefgSRGTZxjWkzwzyeycYgP0m/baDCDhgz8RS7B9SLylHYic?=
 =?us-ascii?Q?RE647/2OgYbHkDusPkM3yNX1hMGhx2vsfU4KuZBHFs2QujmcNTp1LuFdz7wQ?=
 =?us-ascii?Q?s5spg4cwdocUvPme9S0oq+QW2hmfmZV5QuYcP2Pk8PmG46wquWLrDTyUlB/F?=
 =?us-ascii?Q?E41XY3fWBEOAlQQP2szrgmmZ0u5oi9vm0YCa4Zwa7QXVFmKUwngFo+11IQxq?=
 =?us-ascii?Q?0BYsew9qOhisxXu+ZhWvF1qdTPsIaJcmXu8ntM06E0ln2ednUhhwzleosmik?=
 =?us-ascii?Q?p46o/Iw661N33G3JWgifSvqDwVgeTBGmwcz2ZBhApJySuLMkwFiFdnF+rApB?=
 =?us-ascii?Q?uJC7WUShr2bBrK/3ZjqNTC33QJCEtn1u+K6lJkEPDueCsI96Rg9KTu8LHodA?=
 =?us-ascii?Q?2mw9wx+CrLTPhptNv0f8o1LafmWK1F7IF153yyN2tYlWXFAQUoofc3po4M5G?=
 =?us-ascii?Q?BZbS8fFo+yU6mWbNYGfUUrA5f6YqU75qogftqihCq1yjZQCLLBGjd3v4B66R?=
 =?us-ascii?Q?dft+54anUwfFZs6DR7cN7rxFB8Rm+Wt10FrLiw35z9j4l0E5I0jICW2GWW2b?=
 =?us-ascii?Q?trlBCCkUJ67lJJpLcqe1CI7tLT2kxpKWBQATHsLV/pkleq/HhLQk8Hp/6awx?=
 =?us-ascii?Q?tr+SThr4SmqWBLLMhcomNYmfGy/5K5wJl7ib/uk3WH0/WO78qDRI/2722H61?=
 =?us-ascii?Q?ZzZwIIkI2Joui2BZ2Ombzy/XBy1fRo0ghIB0wrNCrtdH9yId5R81sLUbLhlM?=
 =?us-ascii?Q?em61zzozavYwdhORoJnaG+Av2IlaP0jFBEaXNSDwTVOs00BywwGng0+M5aLV?=
 =?us-ascii?Q?J49bzqrU0Vr1MzoP4CqDpfN2catJU+p3k487g/I89SlJNAOMAM3i7oEz2V3l?=
 =?us-ascii?Q?8g8H7ktAGGXFMonJgQxVUdJzxzx34xoSY2jfgX++gl9dC4BH+4TeJyGRiZKj?=
 =?us-ascii?Q?UC4bbtmFsuPvMW7v/TOOTyTgIFU9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:45.8546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea334e7-6424-4ab6-c199-08dce4041aca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

From: Fudongwang <Fudong.Wang@amd.com>

[why]
TBT4 dock have bandwidth limitation, need dsc always on to support all
modes.

[how]
force dsc always on when detect TBT4 dock.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Fudongwang <Fudong.Wang@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h         |  4 ++++
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 12 ++++++++++++
 .../display/dc/link/protocols/link_dp_capability.c   |  7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 41bd95e9177a..50fa8547d718 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1166,6 +1166,7 @@ struct dpcd_caps {
 	int8_t branch_dev_name[6];
 	int8_t branch_hw_revision;
 	int8_t branch_fw_revision[2];
+	int8_t branch_vendor_specific_data[4];
 
 	bool allow_invalid_MSA_timing_param;
 	bool panel_mode_edp;
@@ -1358,6 +1359,9 @@ struct dp_trace {
 #ifndef DP_TUNNELING_IRQ
 #define DP_TUNNELING_IRQ				(1 << 5)
 #endif
+#ifndef DP_BRANCH_VENDOR_SPECIFIC_START
+#define DP_BRANCH_VENDOR_SPECIFIC_START     0x50C
+#endif
 /** USB4 DPCD BW Allocation Registers Chapter 10.7 **/
 #ifndef DP_TUNNELING_CAPABILITIES
 #define DP_TUNNELING_CAPABILITIES			0xE000D /* 1.4a */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index d21ee9d12d26..e026c728042a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -48,6 +48,9 @@
 #include "dm_helpers.h"
 #include "clk_mgr.h"
 
+ // Offset DPCD 050Eh == 0x5A
+#define MST_HUB_ID_0x5A  0x5A
+
 #define DC_LOGGER \
 	link->ctx->logger
 #define DC_LOGGER_INIT(logger)
@@ -692,6 +695,15 @@ static void apply_dpia_mst_dsc_always_on_wa(struct dc_link *link)
 			link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
 			!link->dc->debug.dpia_debug.bits.disable_mst_dsc_work_around)
 		link->wa_flags.dpia_mst_dsc_always_on = true;
+
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+		link->type == dc_connection_mst_branch &&
+		link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
+		link->dpcd_caps.branch_vendor_specific_data[2] == MST_HUB_ID_0x5A &&
+		link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
+		!link->dc->debug.dpia_debug.bits.disable_mst_dsc_work_around) {
+			link->wa_flags.dpia_mst_dsc_always_on = true;
+	}
 }
 
 static void revert_dpia_mst_dsc_always_on_wa(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index fe4aa2c158ea..286841456157 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1207,6 +1207,13 @@ static void get_active_converter_info(
 			dp_hw_fw_revision.ieee_fw_rev,
 			sizeof(dp_hw_fw_revision.ieee_fw_rev));
 	}
+
+	core_link_read_dpcd(
+		link,
+		DP_BRANCH_VENDOR_SPECIFIC_START,
+		(uint8_t *)link->dpcd_caps.branch_vendor_specific_data,
+		sizeof(link->dpcd_caps.branch_vendor_specific_data));
+
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_14 &&
 			link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
 		union dp_dfp_cap_ext dfp_cap_ext;
-- 
2.45.2

