Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B86E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCFE10EB81;
	Tue,  3 Dec 2024 21:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3UZGZaM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFE610EB80
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC3SsR6b0agLlq5N0aa2Ar+/4cFTqHL0RQjK67WbasbT2yZ2vg80sHqFE5Wf4KDIJTXPGDG2kC9owdNXggxD/1AfjTMMHZ+k8lXI+nt719fNTbh7e+d0Ue2R6iIfZqq/jHl02qTGAFAw9LZ5rSweNGAQB2AenWVBgAk9J7YzZk5r9iP95Pw7uyokZyUnx5wvXr1Sj1GkbqqTKAv6VXjFumKNBA/hTw1CfeSklW0m6CPyPzxz0/rj5JLnbysKgAeOYJGIbWEXgTrnN0fGUlmIPm2bKyfckI0Rxc2SC5fj97Nc3rUbhjUmZ5dCbYRgU2uuBhZQyE4R+PPjsr5C7cc1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX4m9xXhy45iPjNSC6mq+ZImmfd9s1A/G3SQRlBoeBk=;
 b=xr9zIZ22Nmp8lExoRiHoGAx/y7fFOWVI4EUt4mmaYPrjhH/bArQQA3htEfPaEYPr7nkgASmHSmGOIRJ9dWpgfD4pY75KN4FQN3LdH7iV05uM0cVhuuDvI7GmmE2ssHZCMYCzZ13BqY8Uw+XCT+joV6pbWWqh8KU58IfG4n7tcbY/zk5N/dtoPwFFkULoaFQC5lGdk9DwdKZJCdmKvIK7ceRV0/9j1GoSE2W4f18KTtYUMJ1aSRxtIs6MiWFdLlwt7GiRdiK35UtUAcSeLBRBOJ8k7I6Y2m6cbDGjJRkmZevGQTSBaIrEWSSCC3+KNDsyri5c3okqZ5gM0h+sMCXeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX4m9xXhy45iPjNSC6mq+ZImmfd9s1A/G3SQRlBoeBk=;
 b=O3UZGZaMkes8mNYYq+v7XDv04PL8Zo0vfO9CJ35WrEUct2Jxir9q6fGRDTxd3acfY7oYQCGTJKlRVcOw+sw5NA8UNf7Ojp38BUWqa04hqA2Vc4/GHcLww+FIIhZcRNbAFTRvMTur/Hy95NruhQRBskBi6kolBHEOutXYXeisqCw=
Received: from BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::24)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:50 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::96) by BN9P220CA0019.outlook.office365.com
 (2603:10b6:408:13e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 21:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:49 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:48 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>
Subject: [PATCH 18/19] drm/amd/display: [FW Promotion] Release 0.0.246.0
Date: Tue, 3 Dec 2024 16:39:56 -0500
Message-ID: <20241203214120.1161810-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4c023c-11b9-45b2-5ea6-08dd13e34b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0GaRke4ISTM+jnJYW6Lf1TeCXbdr3es0uFg9z0+nKUFqaVJiestJoeTqvyc9?=
 =?us-ascii?Q?IlJS0KLPyc0uxx9k1WqMAvytGGKS8kU+90c9ydti79kxYjSaDq6Gc0Fje9s/?=
 =?us-ascii?Q?gzzCpwGCXt11LmvvKDQn8P8w8DieJGvQqV1hvntMn/0ZptduvKxF33DmqNod?=
 =?us-ascii?Q?iCzQnSwk+F4MUp96ll0wu9sgE0UyXkERcoVw998Zq7DV0QxrP/sUm3wkdwNp?=
 =?us-ascii?Q?mQh5FQgJYWtjWh5lpXStUdHxoit4TC9WbZvaZp31+WrOMGgi60Y5n4EM4+tO?=
 =?us-ascii?Q?oJkkCZMg5cqoxB8+woralnNyGcDOaskp7goD9Lv+n2YQ0g30FXHYa3JtBdV0?=
 =?us-ascii?Q?b6CpMWC2YjVGjASO9/nncusKZKyn3f+YglwJri7Jrm48Dd8fjMIM8VaSwu+a?=
 =?us-ascii?Q?5GMqPCVAiklWzvo1L4z1Vlm/HuEWNRMoDr/6CFqzkP74av3lnlpXP7Rc8Bhn?=
 =?us-ascii?Q?cOhebmmBlAeHMn+r2u8UxtV20j5lSXH35ovRGMP+EB2Ea9bhFT3uPLtF/uem?=
 =?us-ascii?Q?SqTWIPYDleh253wMeGxrpsqapgZZP8lyw5yAxl2I/XPu0BXNQSHtpjPFOSqG?=
 =?us-ascii?Q?6HnHogJNsqTwNF6FAgWfrtBEu4uwyoDHYXS2KcpFUBFjrYTSk/+EmwhDUg+5?=
 =?us-ascii?Q?kzaTTb2UjVptfNTgAPbICTpRtBaxasqWWXs5eX6WsZfhJH9fMgvjg+PlN/OR?=
 =?us-ascii?Q?Cdwfv7AsQFwt6J03NPL2Bvl3pt/Tnzvi9mpcWX4bFfcfZ2zZ78aob9o3JRTc?=
 =?us-ascii?Q?n2zvJeMcYxuj9kM9SMQ+3jGDtqibkWVMuGZEirpJWUObZpS2q9x3ua1tO0yU?=
 =?us-ascii?Q?pFT5G/N3DDHyL7RJy4thDLH6xu/8KBB8bVkf/XN+lY6+20D538XduJ1CtxrQ?=
 =?us-ascii?Q?0B4LjoNmV1dBHgxQauwL5aHysXD+C2f5eKMLZQOiYxQ71naH7qrrDiTk6lhS?=
 =?us-ascii?Q?yDxJuZow0Zb2w7/qEm54eSCtc1w0BiRJ+Ab8liXs2nbaD7K0bybVOr16kzoQ?=
 =?us-ascii?Q?g60QI3MRf0/26TOz7vR/yzFAHGoiPGz+IExDAaJAuohNg7U+XCgGDAwEb8Yj?=
 =?us-ascii?Q?i91zTYRpnOvv78oMIs0554X0UVyhn6cpg758lAy5zwXxqoJ3JJUyEWxjnjps?=
 =?us-ascii?Q?hcKg2wLCX2iF5sjIO3flPs9+dwrmbfYICDSwO0uU9wIeEweI9+5+XX6ETTMP?=
 =?us-ascii?Q?EGMuLlYYnmZOSKybLb0O2j/9/Pc1zPWMwhun8VS2z7sCx8WJ+b+f6sB1MXI3?=
 =?us-ascii?Q?Tdbc0P/SG69lsna20njbZoaczu1FXTx30ImvqFVvo8C9QmWXHJp5P5PXMtUs?=
 =?us-ascii?Q?5b7najizyIYTWInZ5EhXpHyBQgr7/PahYcnV5uVsP9aSppnGLL2BkMnZN4eU?=
 =?us-ascii?Q?I8BEinFyMGoYQkyNZaM4F75l98i+vvFosmtxHI31O4rLoG67BbPxx0DGVGR0?=
 =?us-ascii?Q?c9ndqDe9ddNmPw9eNLI1043r9lQF1q0Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:50.2044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4c023c-11b9-45b2-5ea6-08dd13e34b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 154 ++++++++++++------
 1 file changed, 103 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b800a507d1e0..59990929e44e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -475,11 +475,23 @@ union replay_hw_flags {
 		 * Use TPS3 signal when restore main link.
 		 */
 		uint32_t force_wakeup_by_tps3 : 1;
+		/**
+		 * @is_alpm_initialized: Indicates whether ALPM is initialized
+		 */
+		uint32_t is_alpm_initialized : 1;
 	} bitfields;
 
 	uint32_t u32All;
 };
 
+union fw_assisted_mclk_switch_version {
+	struct {
+		uint8_t minor : 5;
+		uint8_t major : 3;
+	};
+	uint8_t ver;
+};
+
 /**
  * DMUB feature capabilities.
  * After DMUB init, driver will query FW capabilities prior to enabling certain features.
@@ -1823,52 +1835,11 @@ enum fams2_stream_type {
 	FAMS2_STREAM_TYPE_SUBVP = 4,
 };
 
-/* dynamic stream state */
-struct dmub_fams2_legacy_stream_dynamic_state {
-	uint8_t force_allow_at_vblank;
-	uint8_t pad[3];
-};
-
-struct dmub_fams2_subvp_stream_dynamic_state {
-	uint16_t viewport_start_hubp_vline;
-	uint16_t viewport_height_hubp_vlines;
-	uint16_t viewport_start_c_hubp_vline;
-	uint16_t viewport_height_c_hubp_vlines;
-	uint16_t phantom_viewport_height_hubp_vlines;
-	uint16_t phantom_viewport_height_c_hubp_vlines;
-	uint16_t microschedule_start_otg_vline;
-	uint16_t mall_start_otg_vline;
-	uint16_t mall_start_hubp_vline;
-	uint16_t mall_start_c_hubp_vline;
-	uint8_t force_allow_at_vblank_only;
-	uint8_t pad[3];
-};
-
-struct dmub_fams2_drr_stream_dynamic_state {
-	uint16_t stretched_vtotal;
-	uint8_t use_cur_vtotal;
-	uint8_t pad;
-};
-
-struct dmub_fams2_stream_dynamic_state {
-	uint64_t ref_tick;
-	uint32_t cur_vtotal;
-	uint16_t adjusted_allow_end_otg_vline;
-	uint8_t pad[2];
-	struct dmub_optc_position ref_otg_pos;
-	struct dmub_optc_position target_otg_pos;
-	union {
-		struct dmub_fams2_legacy_stream_dynamic_state legacy;
-		struct dmub_fams2_subvp_stream_dynamic_state subvp;
-		struct dmub_fams2_drr_stream_dynamic_state drr;
-	} sub_state;
-};
-
 /* static stream state */
 struct dmub_fams2_legacy_stream_static_state {
 	uint8_t vactive_det_fill_delay_otg_vlines;
 	uint8_t programming_delay_otg_vlines;
-};
+}; //v0
 
 struct dmub_fams2_subvp_stream_static_state {
 	uint16_t vratio_numerator;
@@ -1887,14 +1858,59 @@ struct dmub_fams2_subvp_stream_static_state {
 	uint8_t phantom_otg_inst;
 	uint8_t phantom_pipe_mask;
 	uint8_t phantom_plane_pipe_masks[DMUB_MAX_PHANTOM_PLANES]; // phantom pipe mask per plane (for flip passthrough)
-};
+}; //v0
 
 struct dmub_fams2_drr_stream_static_state {
 	uint16_t nom_stretched_vtotal;
 	uint8_t programming_delay_otg_vlines;
 	uint8_t only_stretch_if_required;
 	uint8_t pad[2];
-};
+}; //v0
+
+struct dmub_fams2_cmd_legacy_stream_static_state {
+	uint16_t vactive_det_fill_delay_otg_vlines;
+	uint16_t programming_delay_otg_vlines;
+}; //v1
+
+struct dmub_fams2_cmd_subvp_stream_static_state {
+	uint16_t vratio_numerator;
+	uint16_t vratio_denominator;
+	uint16_t phantom_vtotal;
+	uint16_t phantom_vactive;
+	uint16_t programming_delay_otg_vlines;
+	uint16_t prefetch_to_mall_otg_vlines;
+	union {
+		struct {
+			uint8_t is_multi_planar : 1;
+			uint8_t is_yuv420 : 1;
+		} bits;
+		uint8_t all;
+	} config;
+	uint8_t phantom_otg_inst;
+	uint8_t phantom_pipe_mask;
+	uint8_t pad0;
+	uint8_t phantom_plane_pipe_masks[DMUB_MAX_PHANTOM_PLANES]; // phantom pipe mask per plane (for flip passthrough)
+	uint8_t pad1[4 - (DMUB_MAX_PHANTOM_PLANES % 4)];
+}; //v1
+
+struct dmub_fams2_cmd_drr_stream_static_state {
+	uint16_t nom_stretched_vtotal;
+	uint16_t programming_delay_otg_vlines;
+	uint8_t only_stretch_if_required;
+	uint8_t pad[3];
+}; //v1
+
+union dmub_fams2_stream_static_sub_state {
+	struct dmub_fams2_legacy_stream_static_state legacy;
+	struct dmub_fams2_subvp_stream_static_state subvp;
+	struct dmub_fams2_drr_stream_static_state drr;
+}; //v0
+
+union dmub_fams2_cmd_stream_static_sub_state {
+	struct dmub_fams2_cmd_legacy_stream_static_state legacy;
+	struct dmub_fams2_cmd_subvp_stream_static_state subvp;
+	struct dmub_fams2_cmd_drr_stream_static_state drr;
+}; //v1
 
 struct dmub_fams2_stream_static_state {
 	enum fams2_stream_type type;
@@ -1924,13 +1940,45 @@ struct dmub_fams2_stream_static_state {
 	uint8_t pipe_mask; // pipe mask for the whole config
 	uint8_t num_planes;
 	uint8_t plane_pipe_masks[DMUB_MAX_PLANES]; // pipe mask per plane (for flip passthrough)
-	uint8_t pad[DMUB_MAX_PLANES % 4];
+	uint8_t pad[4 - (DMUB_MAX_PLANES % 4)];
+	union dmub_fams2_stream_static_sub_state sub_state;
+}; //v0
+
+struct dmub_fams2_cmd_stream_static_base_state {
+	enum fams2_stream_type type;
+	uint32_t otg_vline_time_ns;
+	uint32_t otg_vline_time_ticks;
+	uint16_t htotal;
+	uint16_t vtotal; // nominal vtotal
+	uint16_t vblank_start;
+	uint16_t vblank_end;
+	uint16_t max_vtotal;
+	uint16_t allow_start_otg_vline;
+	uint16_t allow_end_otg_vline;
+	uint16_t drr_keepout_otg_vline; // after this vline, vtotal cannot be changed
+	uint16_t scheduling_delay_otg_vlines; // min time to budget for ready to microschedule start
+	uint16_t contention_delay_otg_vlines; // time to budget for contention on execution
+	uint16_t vline_int_ack_delay_otg_vlines; // min time to budget for vertical interrupt firing
+	uint16_t allow_to_target_delay_otg_vlines; // time from allow vline to target vline
 	union {
-		struct dmub_fams2_legacy_stream_static_state legacy;
-		struct dmub_fams2_subvp_stream_static_state subvp;
-		struct dmub_fams2_drr_stream_static_state drr;
-	} sub_state;
-};
+		struct {
+			uint8_t is_drr : 1; // stream is DRR enabled
+			uint8_t clamp_vtotal_min : 1; // clamp vtotal to min instead of nominal
+			uint8_t min_ttu_vblank_usable : 1; // if min ttu vblank is above wm, no force pstate is needed in blank
+		} bits;
+		uint8_t all;
+	} config;
+	uint8_t otg_inst;
+	uint8_t pipe_mask; // pipe mask for the whole config
+	uint8_t num_planes;
+	uint8_t plane_pipe_masks[DMUB_MAX_PLANES]; // pipe mask per plane (for flip passthrough)
+	uint8_t pad[4 - (DMUB_MAX_PLANES % 4)];
+}; //v1
+
+struct dmub_fams2_stream_static_state_v1 {
+	struct dmub_fams2_cmd_stream_static_base_state base;
+	union dmub_fams2_cmd_stream_static_sub_state sub_state;
+}; //v1
 
 /**
  * enum dmub_fams2_allow_delay_check_mode - macroscheduler mode for breaking on excessive
@@ -1970,7 +2018,11 @@ struct dmub_cmd_fams2_global_config {
 
 union dmub_cmd_fams2_config {
 	struct dmub_cmd_fams2_global_config global;
-	struct dmub_fams2_stream_static_state stream;
+	struct dmub_fams2_stream_static_state stream; //v0
+	union {
+		struct dmub_fams2_cmd_stream_static_base_state base;
+		union dmub_fams2_cmd_stream_static_sub_state sub_state;
+	} stream_v1; //v1
 };
 
 /**
-- 
2.47.1

