Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E891DC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B1610E731;
	Wed, 21 Aug 2024 22:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ESFMmuvm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899E710E710
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+U8/4K+kTtmft/EDlhXeLm1imroCkSAzgGRumVQ6ICXigCe6Koj4isSzJ/s7LXe2jSUBSa4rEFc195feMU+jumA6O4sODKrm//1z8FepSCt5Cu+bsTfFRpaa7iGP1Z3g3xqhgvs8BXbjnvI+rSXIqxbjUsqi+6jEZSlTWqG7PkYvC8FwLatT72UaVBRH9OjSKjiRL3pq/0WgFsgb20EBfd+dwX/kHIf+ZQKt6tulyFZ+CxghXAm1dFgMdVfflBKX/RHRRk0JS2JWuGNM7u5ZawxQTK+ZUmutaQXxcCf1YJsXjTVu2hPVQlTBBxNxG7yQAY6e5wUfBdxtY5o6aKkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYHKy79LLqqpLJ8h4VCi7Tq/00Ox495yp6ICySC27Pg=;
 b=XA1m5FELkt4d0qICltmSM0o9BYf60YxQWnriOz/Q4kvs6Y+981iwt1lkkqfnJjgTorzar3ykN1xhdiKeJphT/RON3NwmdYkfEG6mJU1lZKwOLdqZ23YlP8cCa5ESWUlkaibXGxrOgAfIW36hz0vusu5k2JQzLh+UfylEgxHOe6iNOhg/CtYpW5GGJZr7hTezCR1H0As+n1fqyv4qXA8ynew/UPYEDOw/CaIsSNvSGAcE2XQxc5UCFGQcbINQOEyX7ul0/Do3B7yavZBHLwtERcy5Q1zIZ0saXBLMCE5Y2QOUJhXvRGTAgSgVub+sSfFhy1QvhY4M0NDM7tfnpgH/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYHKy79LLqqpLJ8h4VCi7Tq/00Ox495yp6ICySC27Pg=;
 b=ESFMmuvmGXZunnnvF9yt6Q9wzUgLHXRPHzph4VXHw1at53aIMipoDdNfsbyp82VOkISyH6ABmpi4Iv80I8TDCOdrMsiFYSjXThOBtDgo1F8wh6+W3wBTd6Oh3RuFn67R2WYODeqaTAMtUL398ILlWKt/ioulu7AWTqVLitchtJk=
Received: from BN9PR03CA0445.namprd03.prod.outlook.com (2603:10b6:408:113::30)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:04:58 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::2c) by BN9PR03CA0445.outlook.office365.com
 (2603:10b6:408:113::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:57 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:55 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 16/16] drm/amd/display: Add DSC Debug Log
Date: Wed, 21 Aug 2024 18:01:58 -0400
Message-ID: <20240821220156.1498549-17-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c37c8c-c68c-44ec-8cce-08dcc22d4bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CsJTHOpgn5eVQZqZlG60q+bkpwoxmlBX1lnISOHjoUllY54PIcF1ob6II4rp?=
 =?us-ascii?Q?g+HbT22QG7jGNylomYgjHi1c/hKRxVup3pEfmRz76DqeoXHkbpmdT9fNOIwy?=
 =?us-ascii?Q?ADE+t5402oY+FyeMnO9C7XPNps/fbhhaccq7dHKFVfFpXik4E2HkVf65PFGi?=
 =?us-ascii?Q?syd4tblc9wbaD2OTu0wqHbIEs/LViAXdO2c4nSuD1l9Vp6TJzOLIi4VxKd1t?=
 =?us-ascii?Q?lAvvBuBSIPbV5dr02g7rSYjKLkSFRJrgZvW716T6clrTm9Uf2tETM0+UgKz1?=
 =?us-ascii?Q?vGxLN2zIL8eQYpXV3LvtTkivsJ/pxbSUsm/jNb0F38u9PTXX7kBtaTNJZwrz?=
 =?us-ascii?Q?dz3pbj8TVmms3vcbHl5G3r+f+gJYX31DXYU3nPPI9xbGbJUw6hMXkJMEC+Q7?=
 =?us-ascii?Q?VXhbC4D3nCBT2pdSNvUd9Q4WB6eFddGf1Uf2VLV0ciHyIX6GQG8+F7Hb9O44?=
 =?us-ascii?Q?P/fl/TebIcxpdvVkrOUr3aT4K6oMaxIIsZj0tnhtVesCbrB2BJYT6GgOnW14?=
 =?us-ascii?Q?xMwSF4jgMHWCNRKKmemSaxNBfHZB/b9hg60RQ2YRONYj88rc8C3g6fxmdhKk?=
 =?us-ascii?Q?vLT7iV67NW5/SVv+EIt7g+sJV7r/tlilQTxPnax2NgIlaBYpbpd/auQmCSfK?=
 =?us-ascii?Q?mDEI4iaJ+cOAVQ7NZOkz+HHZKw3z7vn7EQEdMS83xeZYQqU+q5qJbEJnHe2g?=
 =?us-ascii?Q?f5IQH0jMKH3+BplPc+TKrDkmYR+wR/r1LNotY821QvzyX2N3Fcb/0wanhlbY?=
 =?us-ascii?Q?TB+UnS3SDGzGcjwBpvVilaomEdjR0TvMMT/+Mz6Gnesn+9qwLLbQyWWvZh12?=
 =?us-ascii?Q?IVD2op3hgSzhJQHI/nCvv5DH53KjGytxH9eaYJokn+RkAbab/ptw0t119MqO?=
 =?us-ascii?Q?kG/CzJ0GL4+P3tLDZAgUgFK98sn24vI+D1e1jaDENfUGB5Z8fA57YS3Ibt8Y?=
 =?us-ascii?Q?L1RUwoxW//qlOY6GNNYhIBBTREH2Xfm53Mvq+LYLfbWFWym8DP2NfcxjYKoH?=
 =?us-ascii?Q?q2R9DpA9L8b1ZXafFBJqRqq/GytT4NOxr/ItHzwIRdFHOXGfOAJftqRANh2X?=
 =?us-ascii?Q?Yzy+5mhPBNyTCKAgGKmxW9gawtRtq90NeNzNgu3P/FasRCkcDj633V0qw6Lf?=
 =?us-ascii?Q?XCaQgE29/S+PtrDMj1ZILT+qKnG94QO5ZxE9AbGGB+vCQotkLB4da07nwc0C?=
 =?us-ascii?Q?dVy3RFsULruiyiMd9fJCl1ccv06kGLO20fWLBYbNZW3zVXwuVJ0Wcy53gSnN?=
 =?us-ascii?Q?z3IhCl6VHOXu4rflIeCzA3E0kFRC2ymCaO+cLrp6W165MF3XUcOUZQPXYKen?=
 =?us-ascii?Q?sQHq2aRRQsM+kB+6gRNSNyacaMuXkS79CWE5xmt0KVudx87z288v1HP8BD9+?=
 =?us-ascii?Q?f2Om5g4n2BA1xVvQqpbPLnxQmjzqzfyfUpDyKtkskZVRVqkeBHp2o6UkkHa1?=
 =?us-ascii?Q?b+CM3m8KAZ/uvG0pNwHoj1mf+KXONiqf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:57.9435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c37c8c-c68c-44ec-8cce-08dcc22d4bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Add DSC log in each critical routines to facilitate debugging.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  18 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 131 ++++++++++++++----
 3 files changed, 119 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dd8353283bda..541578c39aa9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6446,7 +6446,8 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 				stream->timing.flags.DSC = 1;
-				DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n", __func__, drm_connector->name);
+				DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from SST RX\n",
+							__func__, drm_connector->name);
 			}
 		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
 			timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing,
@@ -6465,7 +6466,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 					stream->timing.flags.DSC = 1;
-					DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from DP-HDMI PCON\n",
+					DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
 									 __func__, drm_connector->name);
 				}
 		}
@@ -11588,7 +11589,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (dc_resource_is_dsc_encoding_supported(dc)) {
 			ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
 			if (ret) {
-				drm_dbg_atomic(dev, "compute_mst_dsc_configs_for_state() failed\n");
+				drm_dbg_atomic(dev, "MST_DSC compute_mst_dsc_configs_for_state() failed\n");
 				ret = -EINVAL;
 				goto fail;
 			}
@@ -11609,7 +11610,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		 */
 		ret = drm_dp_mst_atomic_check(state);
 		if (ret) {
-			drm_dbg_atomic(dev, "drm_dp_mst_atomic_check() failed\n");
+			drm_dbg_atomic(dev, "MST drm_dp_mst_atomic_check() failed\n");
 			goto fail;
 		}
 		status = dc_validate_global_state(dc, dm_state->context, true);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cea3a16943c9..39b82c73a0dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -759,7 +759,7 @@ static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 	uint8_t ret = 0;
 
 	drm_dbg_dp(aux->drm_dev,
-		   "Configure DSC to non-virtual dpcd synaptics\n");
+		   "MST_DSC Configure DSC to non-virtual dpcd synaptics\n");
 
 	if (enable) {
 		/* When DSC is enabled on previous boot and reboot with the hub,
@@ -772,7 +772,7 @@ static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 			apply_synaptics_fifo_reset_wa(aux);
 
 		ret = drm_dp_dpcd_write(aux, DP_DSC_ENABLE, &enable, 1);
-		DRM_INFO("Send DSC enable to synaptics\n");
+		DRM_INFO("MST_DSC Send DSC enable to synaptics\n");
 
 	} else {
 		/* Synaptics hub not support virtual dpcd,
@@ -781,7 +781,7 @@ static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 		 */
 		if (!stream->link->link_status.link_active) {
 			ret = drm_dp_dpcd_write(aux, DP_DSC_ENABLE, &enable, 1);
-			DRM_INFO("Send DSC disable to synaptics\n");
+			DRM_INFO("MST_DSC Send DSC disable to synaptics\n");
 		}
 	}
 
@@ -823,14 +823,14 @@ bool dm_helpers_dp_write_dsc_enable(
 							DP_DSC_ENABLE,
 							&enable_passthrough, 1);
 				drm_dbg_dp(dev,
-					   "Sent DSC pass-through enable to virtual dpcd port, ret = %u\n",
+					   "MST_DSC Sent DSC pass-through enable to virtual dpcd port, ret = %u\n",
 					   ret);
 			}
 
 			ret = drm_dp_dpcd_write(aconnector->dsc_aux,
 						DP_DSC_ENABLE, &enable_dsc, 1);
 			drm_dbg_dp(dev,
-				   "Sent DSC decoding enable to %s port, ret = %u\n",
+				   "MST_DSC Sent DSC decoding enable to %s port, ret = %u\n",
 				   (port->passthrough_aux) ? "remote RX" :
 				   "virtual dpcd",
 				   ret);
@@ -838,7 +838,7 @@ bool dm_helpers_dp_write_dsc_enable(
 			ret = drm_dp_dpcd_write(aconnector->dsc_aux,
 						DP_DSC_ENABLE, &enable_dsc, 1);
 			drm_dbg_dp(dev,
-				   "Sent DSC decoding disable to %s port, ret = %u\n",
+				   "MST_DSC Sent DSC decoding disable to %s port, ret = %u\n",
 				   (port->passthrough_aux) ? "remote RX" :
 				   "virtual dpcd",
 				   ret);
@@ -848,7 +848,7 @@ bool dm_helpers_dp_write_dsc_enable(
 							DP_DSC_ENABLE,
 							&enable_passthrough, 1);
 				drm_dbg_dp(dev,
-					   "Sent DSC pass-through disable to virtual dpcd port, ret = %u\n",
+					   "MST_DSC Sent DSC pass-through disable to virtual dpcd port, ret = %u\n",
 					   ret);
 			}
 		}
@@ -858,12 +858,12 @@ bool dm_helpers_dp_write_dsc_enable(
 		if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
 			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 			drm_dbg_dp(dev,
-				   "Send DSC %s to SST RX\n",
+				   "SST_DSC Send DSC %s to SST RX\n",
 				   enable_dsc ? "enable" : "disable");
 		} else if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
 			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 			drm_dbg_dp(dev,
-				   "Send DSC %s to DP-HDMI PCON\n",
+				   "SST_DSC Send DSC %s to DP-HDMI PCON\n",
 				   enable_dsc ? "enable" : "disable");
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index c309af2f6f24..08586f9e07c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -577,6 +577,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (!aconnector)
 		return NULL;
 
+	DRM_DEBUG_DRIVER("%s: Create aconnector 0x%p for port 0x%p\n", __func__, aconnector, port);
+
 	connector = &aconnector->base;
 	aconnector->mst_output_port = port;
 	aconnector->mst_root = master;
@@ -871,11 +873,11 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 		if (params[i].sink) {
 			if (params[i].sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 				params[i].sink->sink_signal != SIGNAL_TYPE_NONE)
-				DRM_DEBUG_DRIVER("%s i=%d dispname=%s\n", __func__, i,
+				DRM_DEBUG_DRIVER("MST_DSC %s i=%d dispname=%s\n", __func__, i,
 					params[i].sink->edid_caps.display_name);
 		}
 
-		DRM_DEBUG_DRIVER("dsc=%d bits_per_pixel=%d pbn=%d\n",
+		DRM_DEBUG_DRIVER("MST_DSC dsc=%d bits_per_pixel=%d pbn=%d\n",
 			params[i].timing->flags.DSC,
 			params[i].timing->dsc_cfg.bits_per_pixel,
 			vars[i + k].pbn);
@@ -1053,6 +1055,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 		if (next_index == -1)
 			break;
 
+		DRM_DEBUG_DRIVER("MST_DSC index #%d, try no compression\n", next_index);
 		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 		ret = drm_dp_atomic_find_time_slots(state,
 						    params[next_index].port->mgr,
@@ -1063,9 +1066,11 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 
 		ret = drm_dp_mst_atomic_check(state);
 		if (ret == 0) {
+			DRM_DEBUG_DRIVER("MST_DSC index #%d, greedily disable dsc\n", next_index);
 			vars[next_index].dsc_enabled = false;
 			vars[next_index].bpp_x16 = 0;
 		} else {
+			DRM_DEBUG_DRIVER("MST_DSC index #%d, restore minimum compression\n", next_index);
 			vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 			ret = drm_dp_atomic_find_time_slots(state,
 							    params[next_index].port->mgr,
@@ -1081,6 +1086,15 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 	return 0;
 }
 
+static void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		DRM_DEBUG_DRIVER("MST_DSC DSC params: stream #%d --- dsc_enabled = %d, bpp_x16 = %d, pbn = %d\n",
+				 i, vars[i + k].dsc_enabled, vars[i + k].bpp_x16, vars[i + k].pbn);
+}
+
 static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 					    struct dc_state *dc_state,
 					    struct dc_link *dc_link,
@@ -1103,6 +1117,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		return PTR_ERR(mst_state);
 
 	/* Set up params */
+	DRM_DEBUG_DRIVER("%s: MST_DSC Set up params for %d streams\n", __func__, dc_state->stream_count);
 	for (i = 0; i < dc_state->stream_count; i++) {
 		struct dc_dsc_policy dsc_policy = {0};
 
@@ -1144,6 +1159,9 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 			params[count].bw_range.stream_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing,
 					dc_link_get_highest_encoding_format(dc_link));
 
+		DRM_DEBUG_DRIVER("MST_DSC #%d stream 0x%p - max_kbps = %u, min_kbps = %u, uncompressed_kbps = %u\n",
+			count, stream, params[count].bw_range.max_kbps, params[count].bw_range.min_kbps,
+			params[count].bw_range.stream_kbps);
 		count++;
 	}
 
@@ -1158,6 +1176,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	*link_vars_start_index += count;
 
 	/* Try no compression */
+	DRM_DEBUG_DRIVER("MST_DSC Try no compression\n");
 	for (i = 0; i < count; i++) {
 		vars[i + k].aconnector = params[i].aconnector;
 		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
@@ -1176,7 +1195,10 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		return ret;
 	}
 
+	log_dsc_params(count, vars, k);
+
 	/* Try max compression */
+	DRM_DEBUG_DRIVER("MST_DSC Try max compression\n");
 	for (i = 0; i < count; i++) {
 		if (params[i].compression_possible && params[i].clock_force_enable != DSC_CLK_FORCE_DISABLE) {
 			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps, fec_overhead_multiplier_x1000);
@@ -1200,14 +1222,26 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	if (ret != 0)
 		return ret;
 
+	log_dsc_params(count, vars, k);
+
 	/* Optimize degree of compression */
+	DRM_DEBUG_DRIVER("MST_DSC Try optimize compression\n");
 	ret = increase_dsc_bpp(state, mst_state, dc_link, params, vars, count, k);
-	if (ret < 0)
+	if (ret < 0) {
+		DRM_DEBUG_DRIVER("MST_DSC Failed to optimize compression\n");
 		return ret;
+	}
 
+	log_dsc_params(count, vars, k);
+
+	DRM_DEBUG_DRIVER("MST_DSC Try disable compression\n");
 	ret = try_disable_dsc(state, dc_link, params, vars, count, k);
-	if (ret < 0)
+	if (ret < 0) {
+		DRM_DEBUG_DRIVER("MST_DSC Failed to disable compression\n");
 		return ret;
+	}
+
+	log_dsc_params(count, vars, k);
 
 	set_dsc_configs_from_fairness_vars(params, vars, count, k);
 
@@ -1229,17 +1263,19 @@ static bool is_dsc_need_re_compute(
 
 	/* only check phy used by dsc mst branch */
 	if (dc_link->type != dc_connection_mst_branch)
-		return false;
+		goto out;
 
 	/* add a check for older MST DSC with no virtual DPCDs */
 	if (needs_dsc_aux_workaround(dc_link)  &&
 		(!(dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
 		dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT)))
-		return false;
+		goto out;
 
 	for (i = 0; i < MAX_PIPES; i++)
 		stream_on_link[i] = NULL;
 
+	DRM_DEBUG_DRIVER("%s: MST_DSC check on %d streams in new dc_state\n", __func__, dc_state->stream_count);
+
 	/* check if there is mode change in new request */
 	for (i = 0; i < dc_state->stream_count; i++) {
 		struct drm_crtc_state *new_crtc_state;
@@ -1249,6 +1285,8 @@ static bool is_dsc_need_re_compute(
 		if (!stream)
 			continue;
 
+		DRM_DEBUG_DRIVER("%s:%d MST_DSC checking #%d stream 0x%p\n", __func__, __LINE__, i, stream);
+
 		/* check if stream using the same link for mst */
 		if (stream->link != dc_link)
 			continue;
@@ -1261,8 +1299,11 @@ static bool is_dsc_need_re_compute(
 		new_stream_on_link_num++;
 
 		new_conn_state = drm_atomic_get_new_connector_state(state, &aconnector->base);
-		if (!new_conn_state)
+		if (!new_conn_state) {
+			DRM_DEBUG_DRIVER("%s:%d MST_DSC no new_conn_state for stream 0x%p, aconnector 0x%p\n",
+					 __func__, __LINE__, stream, aconnector);
 			continue;
+		}
 
 		if (IS_ERR(new_conn_state))
 			continue;
@@ -1271,21 +1312,36 @@ static bool is_dsc_need_re_compute(
 			continue;
 
 		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
-		if (!new_crtc_state)
+		if (!new_crtc_state) {
+			DRM_DEBUG_DRIVER("%s:%d MST_DSC no new_crtc_state for crtc of stream 0x%p, aconnector 0x%p\n",
+						__func__, __LINE__, stream, aconnector);
 			continue;
+		}
 
 		if (IS_ERR(new_crtc_state))
 			continue;
 
 		if (new_crtc_state->enable && new_crtc_state->active) {
 			if (new_crtc_state->mode_changed || new_crtc_state->active_changed ||
-				new_crtc_state->connectors_changed)
-				return true;
+					new_crtc_state->connectors_changed) {
+				DRM_DEBUG_DRIVER("%s:%d MST_DSC dsc recompte required."
+						 "stream 0x%p in new dc_state\n",
+						 __func__, __LINE__, stream);
+				is_dsc_need_re_compute = true;
+				goto out;
+			}
 		}
 	}
 
-	if (new_stream_on_link_num == 0)
-		return false;
+	if (new_stream_on_link_num == 0) {
+		DRM_DEBUG_DRIVER("%s:%d MST_DSC no mode change request for streams in new dc_state\n",
+				 __func__, __LINE__);
+		is_dsc_need_re_compute = false;
+		goto out;
+	}
+
+	DRM_DEBUG_DRIVER("%s: MST_DSC check on %d streams in current dc_state\n",
+			 __func__, dc->current_state->stream_count);
 
 	/* check current_state if there stream on link but it is not in
 	 * new request state
@@ -1309,11 +1365,18 @@ static bool is_dsc_need_re_compute(
 
 		if (j == new_stream_on_link_num) {
 			/* not in new state */
+			DRM_DEBUG_DRIVER("%s:%d MST_DSC dsc recompute required."
+					 "stream 0x%p in current dc_state but not in new dc_state\n",
+						__func__, __LINE__, stream);
 			is_dsc_need_re_compute = true;
 			break;
 		}
 	}
 
+out:
+	DRM_DEBUG_DRIVER("%s: MST_DSC dsc recompute %s\n",
+			 __func__, is_dsc_need_re_compute ? "required" : "not required");
+
 	return is_dsc_need_re_compute;
 }
 
@@ -1342,6 +1405,9 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 
+		DRM_DEBUG_DRIVER("%s: MST_DSC compute mst dsc configs for stream 0x%p, aconnector 0x%p\n",
+				__func__, stream, aconnector);
+
 		if (!aconnector || !aconnector->dc_sink || !aconnector->mst_output_port)
 			continue;
 
@@ -1374,8 +1440,11 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		stream = dc_state->streams[i];
 
 		if (stream->timing.flags.DSC == 1)
-			if (dc_stream_add_dsc_to_resource(stream->ctx->dc, dc_state, stream) != DC_OK)
+			if (dc_stream_add_dsc_to_resource(stream->ctx->dc, dc_state, stream) != DC_OK) {
+				DRM_DEBUG_DRIVER("%s:%d MST_DSC Failed to request dsc hw resource for stream 0x%p\n",
+							__func__, __LINE__, stream);
 				return -EINVAL;
+			}
 	}
 
 	return ret;
@@ -1404,6 +1473,9 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 
+		DRM_DEBUG_DRIVER("MST_DSC pre compute mst dsc configs for #%d stream 0x%p, aconnector 0x%p\n",
+					i, stream, aconnector);
+
 		if (!aconnector || !aconnector->dc_sink || !aconnector->mst_output_port)
 			continue;
 
@@ -1493,12 +1565,12 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	int ret = 0;
 
 	if (!is_dsc_precompute_needed(state)) {
-		DRM_INFO_ONCE("DSC precompute is not needed.\n");
+		DRM_INFO_ONCE("%s:%d MST_DSC dsc precompute is not needed\n", __func__, __LINE__);
 		return 0;
 	}
 	ret = dm_atomic_get_state(state, dm_state_ptr);
 	if (ret != 0) {
-		DRM_INFO_ONCE("dm_atomic_get_state() failed\n");
+		DRM_INFO_ONCE("%s:%d MST_DSC dm_atomic_get_state() failed\n", __func__, __LINE__);
 		return ret;
 	}
 	dm_state = *dm_state_ptr;
@@ -1552,7 +1624,8 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 
 	ret = pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars);
 	if (ret != 0) {
-		DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
+		DRM_INFO_ONCE("%s:%d MST_DSC dsc pre_compute_mst_dsc_configs_for_state() failed\n",
+				__func__, __LINE__);
 		ret = -EINVAL;
 		goto clean_exit;
 	}
@@ -1566,12 +1639,15 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 
 		if (local_dc_state->streams[i] &&
 		    dc_is_timing_changed(stream, local_dc_state->streams[i])) {
-			DRM_INFO_ONCE("crtc[%d] needs mode_changed\n", i);
+			DRM_INFO_ONCE("%s:%d MST_DSC crtc[%d] needs mode_change\n", __func__, __LINE__, i);
 		} else {
 			int ind = find_crtc_index_in_state_by_stream(state, stream);
 
-			if (ind >= 0)
+			if (ind >= 0) {
+				DRM_INFO_ONCE("%s:%d MST_DSC no mode changed for stream 0x%p\n",
+						__func__, __LINE__, stream);
 				state->crtcs[ind].new_state->mode_changed = 0;
+			}
 		}
 	}
 clean_exit:
@@ -1696,7 +1772,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	end_to_end_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
 
 	if (stream_kbps <= end_to_end_bw_in_kbps) {
-		DRM_DEBUG_DRIVER("No DSC needed. End-to-end bw sufficient.");
+		DRM_DEBUG_DRIVER("MST_DSC no dsc required. End-to-end bw sufficient\n");
 		return DC_OK;
 	}
 
@@ -1709,7 +1785,8 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 		/*capable of dsc passthough. dsc bitstream along the entire path*/
 		if (aconnector->mst_output_port->passthrough_aux) {
 			if (bw_range.min_kbps > end_to_end_bw_in_kbps) {
-				DRM_DEBUG_DRIVER("DSC passthrough. Max dsc compression can't fit into end-to-end bw\n");
+				DRM_DEBUG_DRIVER("MST_DSC dsc passthrough and decode at endpoint"
+						 "Max dsc compression bw can't fit into end-to-end bw\n");
 				return DC_FAIL_BANDWIDTH_VALIDATE;
 			}
 		} else {
@@ -1720,7 +1797,8 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			/*Get last DP link BW capability*/
 			if (dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw)) {
 				if (stream_kbps > end_link_bw) {
-					DRM_DEBUG_DRIVER("DSC decode at last link. Mode required bw can't fit into available bw\n");
+					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
+							 "Mode required bw can't fit into last link\n");
 					return DC_FAIL_BANDWIDTH_VALIDATE;
 				}
 			}
@@ -1733,7 +1811,8 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 				virtual_channel_bw_in_kbps = kbps_from_pbn(immediate_upstream_port->full_pbn);
 				virtual_channel_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
 				if (bw_range.min_kbps > virtual_channel_bw_in_kbps) {
-					DRM_DEBUG_DRIVER("DSC decode at last link. Max dsc compression can't fit into MST available bw\n");
+					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
+							 "Max dsc compression can't fit into MST available bw\n");
 					return DC_FAIL_BANDWIDTH_VALIDATE;
 				}
 			}
@@ -1750,9 +1829,9 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 				dc_link_get_highest_encoding_format(stream->link),
 				&stream->timing.dsc_cfg)) {
 			stream->timing.flags.DSC = 1;
-			DRM_DEBUG_DRIVER("Require dsc and dsc config found\n");
+			DRM_DEBUG_DRIVER("MST_DSC require dsc and dsc config found\n");
 		} else {
-			DRM_DEBUG_DRIVER("Require dsc but can't find appropriate dsc config\n");
+			DRM_DEBUG_DRIVER("MST_DSC require dsc but can't find appropriate dsc config\n");
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
 
@@ -1774,11 +1853,11 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 
 		if (branch_max_throughput_mps != 0 &&
 			((stream->timing.pix_clk_100hz / 10) >  branch_max_throughput_mps * 1000)) {
-			DRM_DEBUG_DRIVER("DSC is required but max throughput mps fails");
+			DRM_DEBUG_DRIVER("MST_DSC require dsc but max throughput mps fails\n");
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
 	} else {
-		DRM_DEBUG_DRIVER("DSC is required but can't find common dsc config.");
+		DRM_DEBUG_DRIVER("MST_DSC require dsc but can't find common dsc config\n");
 		return DC_FAIL_BANDWIDTH_VALIDATE;
 	}
 #endif
-- 
2.34.1

