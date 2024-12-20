Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D693EE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889F710F065;
	Fri, 20 Dec 2024 21:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5i9ugR2R";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB32610F06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPvTnprMIApO6AS/TpDr9+SF9wW1JhswjIM4NAAuYwg1bZWF3MPl76OTmHFbICZehdHzFy7W2Iva375MS9q81bBI8pgPaOjCGLzCMszdxxgyqB2KwuShGHsLan0N+KDxJEPkJJhphqZEBhcEhGy3MI817Ds8WSbNbAgUzROy/rxy5Pxfd18eDat7ts1LYFlFtsDXr89wzfu+0KeB6mFJBCMUZBakmTY4Q2iojwlWl3BAyIx/EDuaBO5uSou3++9MilP98ms7RU7viLt2obfYy4H71V9gUU7wgQ+mFJIrIcuyhruvHw0jPspi2soLLDRihWv+dn3zcXunZQkJ8cXg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evd35BgPlFGDeWe+tcmEhGuHwXt6O0PluizwTayvXVs=;
 b=oVI+Hpa2R2yhnDkPenLosXgte+m+uaWWmxY0t8zXjs8jcXVOqE9VucFvio6rdj8bR9o4h9m5pEaqIZfbKjsEwa/Sc/7sBuUNSTDFqYWioXcX2ZGPXTdp7cVXzyNt+LsztyEEHLXtvSghI6V90PUJUUQjwA0xRJS0WqGDHdOzVPaGsXs12bkZvKK0/2Q5RgSdHKy0C3cR8WYTqn2SJQ/3LTwGhTdzZ8V2kHDUTa5gxr6GOiNvT3sf+eojtO4WyRhBuqUDL9IBmecqj1x+us3cVpyQe4BtYp/9X1fSZmZTItam8SaxhGXcwHbp2wQlif8fKCNYjA38zYpBc2sbdeWoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evd35BgPlFGDeWe+tcmEhGuHwXt6O0PluizwTayvXVs=;
 b=5i9ugR2RqQATa89CxNMyDH5RImHYtJOj+TYtgLCWOMxk/3jNLOXy8MMLXmKyHJN35XaQBW6ac2fKx3TsxYlW6AVruXPVrVFIqT/N69Qc+xMYHRwjB/gHc7DnXJTQpm/xQ/TWo4kM1z3z57waskQLHkjlaoz5V1elsJIQybybvmY=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:50:51 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::2f) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 21:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:49 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:49 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 05/28] drm/amd/display: Add DP required HBlank size calc to
 link interface
Date: Fri, 20 Dec 2024 16:48:32 -0500
Message-ID: <20241220214855.2608618-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 274a0040-c2a4-46a8-6b96-08dd21405f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ePdHp8IFttv0VsMrIq3z+z/U3J/tw9W/UvYjVte/9V6HnbG1F7yUZ9sj2RZ?=
 =?us-ascii?Q?Yt8sGGjndXH03qk4WY2IEyDCgAcVs1UiLOEfOJhAz52esBcuoq8FQ6Ibc41P?=
 =?us-ascii?Q?PV5EH7PNmqIQQvNIh8efz3GSlMb8hB9xJW0uIGm5UKc9rCGpZQz9JRONSgWL?=
 =?us-ascii?Q?0N+QVsmcJVPwDJQcnPE5Zl5ZODoOLTpvV+jlZ3yBQHzi4o55qyIo8+DBoDrd?=
 =?us-ascii?Q?v+5Qr3BHRYuJgDCeyc1L1Y4hjds+fbGhBwpWfOtlzrQDkMeXst0My2BieS8D?=
 =?us-ascii?Q?pwFs4YHfOEQ5XBekf1TLhNhIZI6nU2HuNt+hZaLbgP4zsKkTolrGUc7n9Cdq?=
 =?us-ascii?Q?WG9dq9Wd+cxR/rWAVQe6ZoK9H84jRXrZoW4YOTdY17U/LlSxdTvaTqGsi9wp?=
 =?us-ascii?Q?jx/5T6Z1VNKx/bcxXlKYZJHWYTh7KKiEMznXBR7HM7Asvhu3XF0E7u1qZHKb?=
 =?us-ascii?Q?qGitmKiIWqs/+klvakc1NltAUzjv0Z12wZShUYCDqIloFn/SZ/jFoSxc4+i9?=
 =?us-ascii?Q?TF4kkpgtMtHdkPl84J6HvBLTLpAxJ1MXyuG2wQGWFV/Veu5cIC1KB54a9JwM?=
 =?us-ascii?Q?rg/nAbr4GrWaqDMoA3TAqHrQS6FWxtM+t+Q0kZJEW8QyzuElvYz+kXo6R3a/?=
 =?us-ascii?Q?6FX2duEbmcotZ0JHUIZyU5oDmHPAPE0hu8WIHSwwzneQAn9BOlnkrBxmCpda?=
 =?us-ascii?Q?A52I9nv2HRMeoLHVsuuTuNLZAdznmu7o8nYK64N+4in6Nwba2ZDgZK+nAGEt?=
 =?us-ascii?Q?ac+Ckh9FXEbN/Q77hmOqtdiF8Na0K/bk+Ug3bdHEzs6uT3L++RtgLX/UAdQS?=
 =?us-ascii?Q?UD1ezYAHs0VRIRNvI5vO72bIxDgh7qhyXejs2wFRG4canPua7oPx85HSCByn?=
 =?us-ascii?Q?ZgPnwni2oX4kwKIrMaqYxtqIPKB5ujAShGuhsXIQtHIl3OAUUomAMhx9pjAE?=
 =?us-ascii?Q?2hw+3Ggaho44h0DsWf9s+/eDo3VadyqLtqUClcemVGtaT+9OEdvyYzXzirLY?=
 =?us-ascii?Q?1bbQjiT/l97BEVNuHE5JZQe5j1w377rDj0j8NPYDi2R+yheIygBeSMI/QAQm?=
 =?us-ascii?Q?tTfvJyo79LyFkOgpgW9f5y0eCdPziTy3D8VTnr0ULurzqXLNJIMn2gG11lRG?=
 =?us-ascii?Q?RHA+6xv31f2/zUtk9qhIpKfgFJN+cu0W9I2GPtSviktkfSg2d7CdqDQNnfWX?=
 =?us-ascii?Q?ySp1JAM8bGXkFvjksb5rd3Feht2nIJ4/1VgK5k2U0TJzYJo7s6i1VLnxSEOs?=
 =?us-ascii?Q?pnrjdc+yYN8DAlWf3wGqK7VOvTCGOjXIXQ1zvo4QK2JMbp7GiD7Z0gDuGVsV?=
 =?us-ascii?Q?3Cpc3ts8hy1ezQ2NTc2w1XIun6FhwhIAXzuVkwKvKEIy0amUMz+p3sciRYyn?=
 =?us-ascii?Q?shkH0y0FJyQbmkqsQQ+2DNj0Pen7XJ46c6cxqLdR7+eFpqjBowAO759UKFNn?=
 =?us-ascii?Q?FTGhNl4fjIZCXofPrV6HIunzAN6x4RKcrNxW0Wxe6Eh13n9wpPSCC4hKtLb6?=
 =?us-ascii?Q?LyjJp5551usFo0A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:51.1083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274a0040-c2a4-46a8-6b96-08dd21405f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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

From: George Shen <george.shen@amd.com>

[Why]
Some features, such as HBlank expansion/reduction, needs to know how
much HBlank is required to support basic audio.

[How]
Add interface to link to calculate required HBlank size for a given
link + timing combination to support basic audio (i.e. 2-channel 48KHz).

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c |   8 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  18 ++
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.c | 179 ++++++++++++++++++
 .../drm/amd/display/dc/link/link_validation.h |   5 +
 6 files changed, 215 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 457d60eeb486..c1b79b379447 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -125,6 +125,14 @@ uint32_t dc_link_bandwidth_kbps(
 	return link->dc->link_srv->dp_link_bandwidth_kbps(link, link_settings);
 }
 
+uint32_t dc_link_required_hblank_size_bytes(
+	const struct dc_link *link,
+	struct dp_audio_bandwidth_params *audio_params)
+{
+	return link->dc->link_srv->dp_required_hblank_size_bytes(link,
+			audio_params);
+}
+
 void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map)
 {
 	dc->link_srv->get_cur_res_map(dc, map);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 01f22706d27c..96594ec6a1d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2024,6 +2024,24 @@ uint32_t dc_link_bandwidth_kbps(
 	const struct dc_link *link,
 	const struct dc_link_settings *link_setting);
 
+struct dp_audio_bandwidth_params {
+	const struct dc_crtc_timing *crtc_timing;
+	enum dp_link_encoding link_encoding;
+	uint32_t channel_count;
+	uint32_t sample_rate_hz;
+};
+
+/* The function calculates the minimum size of hblank (in bytes) needed to
+ * support the specified channel count and sample rate combination, given the
+ * link encoding and timing to be used. This calculation is not supported
+ * for 8b/10b SST.
+ *
+ * return - min hblank size in bytes, 0 if 8b/10b SST.
+ */
+uint32_t dc_link_required_hblank_size_bytes(
+	const struct dc_link *link,
+	struct dp_audio_bandwidth_params *audio_params);
+
 /* The function takes a snapshot of current link resource allocation state
  * @dc: pointer to dc of the dm calling this
  * @map: a dc link resource snapshot defined internally to dc.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index f04292086c08..fd1f9d3db039 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -148,6 +148,10 @@ struct link_service {
 			const struct dc_stream_state *stream,
 			const unsigned int num_streams);
 
+	uint32_t (*dp_required_hblank_size_bytes)(
+		const struct dc_link *link,
+		struct dp_audio_bandwidth_params *audio_params);
+
 
 	/*************************** DPMS *************************************/
 	void (*set_dpms_on)(struct dc_state *state, struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 5e1b5ab9fbc6..334f985186d2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -101,6 +101,7 @@ static void construct_link_service_validation(struct link_service *link_srv)
 	link_srv->validate_mode_timing = link_validate_mode_timing;
 	link_srv->dp_link_bandwidth_kbps = dp_link_bandwidth_kbps;
 	link_srv->validate_dpia_bandwidth = link_validate_dpia_bandwidth;
+	link_srv->dp_required_hblank_size_bytes = dp_required_hblank_size_bytes;
 }
 
 /* link dpms owns the programming sequence of stream's dpms state associated
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 60f15a9ba7a5..29606fda029d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -409,3 +409,182 @@ bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const un
 
 	return dpia_validate_usb4_bw(dpia_link, bw_needed, num_dpias);
 }
+
+struct dp_audio_layout_config {
+	uint8_t layouts_per_sample_denom;
+	uint8_t symbols_per_layout;
+	uint8_t max_layouts_per_audio_sdp;
+};
+
+static void get_audio_layout_config(
+	uint32_t channel_count,
+	enum dp_link_encoding encoding,
+	struct dp_audio_layout_config *output)
+{
+	memset(output, 0, sizeof(struct dp_audio_layout_config));
+
+	/* Assuming L-PCM audio. Current implementation uses max 1 layout per SDP,
+	 * with each layout being the same size (8ch layout).
+	 */
+	if (encoding == DP_8b_10b_ENCODING) {
+		if (channel_count == 2) {
+			output->layouts_per_sample_denom = 4;
+			output->symbols_per_layout = 40;
+			output->max_layouts_per_audio_sdp = 1;
+		} else if (channel_count == 8 || channel_count == 6) {
+			output->layouts_per_sample_denom = 1;
+			output->symbols_per_layout = 40;
+			output->max_layouts_per_audio_sdp = 1;
+		}
+	} else if (encoding == DP_128b_132b_ENCODING) {
+		if (channel_count == 2) {
+			output->layouts_per_sample_denom = 4;
+			output->symbols_per_layout = 10;
+			output->max_layouts_per_audio_sdp = 1;
+		} else if (channel_count == 8 || channel_count == 6) {
+			output->layouts_per_sample_denom = 1;
+			output->symbols_per_layout = 10;
+			output->max_layouts_per_audio_sdp = 1;
+		}
+	}
+}
+
+static uint32_t get_av_stream_map_lane_count(
+	enum dp_link_encoding encoding,
+	enum dc_lane_count lane_count,
+	bool is_mst)
+{
+	uint32_t av_stream_map_lane_count = 0;
+
+	if (encoding == DP_8b_10b_ENCODING) {
+		if (!is_mst)
+			av_stream_map_lane_count = lane_count;
+		else
+			av_stream_map_lane_count = 4;
+	} else if (encoding == DP_128b_132b_ENCODING) {
+		av_stream_map_lane_count = 4;
+	}
+
+	ASSERT(av_stream_map_lane_count != 0);
+
+	return av_stream_map_lane_count;
+}
+
+static uint32_t get_audio_sdp_overhead(
+	enum dp_link_encoding encoding,
+	enum dc_lane_count lane_count,
+	bool is_mst)
+{
+	uint32_t audio_sdp_overhead = 0;
+
+	if (encoding == DP_8b_10b_ENCODING) {
+		if (is_mst)
+			audio_sdp_overhead = 16; /* 4 * 2 + 8 */
+		else
+			audio_sdp_overhead = lane_count * 2 + 8;
+	} else if (encoding == DP_128b_132b_ENCODING) {
+		audio_sdp_overhead = 10; /* 4 x 2.5 */
+	}
+
+	ASSERT(audio_sdp_overhead != 0);
+
+	return audio_sdp_overhead;
+}
+
+/* Current calculation only applicable for 8b/10b MST and 128b/132b SST/MST.
+ */
+static uint32_t calculate_overhead_hblank_bw_in_symbols(
+	uint32_t max_slice_h)
+{
+	uint32_t overhead_hblank_bw = 0; /* in stream symbols */
+
+	overhead_hblank_bw += max_slice_h * 4; /* EOC overhead */
+	overhead_hblank_bw += 12; /* Main link overhead (VBID, BS/BE) */
+
+	return overhead_hblank_bw;
+}
+
+uint32_t dp_required_hblank_size_bytes(
+	const struct dc_link *link,
+	struct dp_audio_bandwidth_params *audio_params)
+{
+	/* Main logic from dce_audio is duplicated here, with the main
+	 * difference being:
+	 * - Pre-determined lane count of 4
+	 * - Assumed 16 dsc slices for worst case
+	 * - Assumed SDP split disabled for worst case
+	 * TODO: Unify logic from dce_audio to prevent duplicated logic.
+	 */
+
+	const struct dc_crtc_timing *timing = audio_params->crtc_timing;
+	const uint32_t channel_count = audio_params->channel_count;
+	const uint32_t sample_rate_hz = audio_params->sample_rate_hz;
+	const enum dp_link_encoding link_encoding = audio_params->link_encoding;
+
+	// 8b/10b MST and 128b/132b are always 4 logical lanes.
+	const uint32_t lane_count = 4;
+	const bool is_mst = (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT);
+	// Maximum slice count is with ODM 4:1, 4 slices per DSC
+	const uint32_t max_slices_h = 16;
+
+	const uint32_t av_stream_map_lane_count = get_av_stream_map_lane_count(
+			link_encoding, lane_count, is_mst);
+	const uint32_t audio_sdp_overhead = get_audio_sdp_overhead(
+			link_encoding, lane_count, is_mst);
+	struct dp_audio_layout_config layout_config;
+
+	if (link_encoding == DP_8b_10b_ENCODING && link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT)
+		return 0;
+
+	get_audio_layout_config(
+			channel_count, link_encoding, &layout_config);
+
+	/* DP spec recommends between 1.05 to 1.1 safety margin to prevent sample under-run */
+	struct fixed31_32 audio_sdp_margin = dc_fixpt_from_fraction(110, 100);
+	struct fixed31_32 horizontal_line_freq_khz = dc_fixpt_from_fraction(
+			timing->pix_clk_100hz, (long long)timing->h_total * 10);
+	struct fixed31_32 samples_per_line;
+	struct fixed31_32 layouts_per_line;
+	struct fixed31_32 symbols_per_sdp_max_layout;
+	struct fixed31_32 remainder;
+	uint32_t num_sdp_with_max_layouts;
+	uint32_t required_symbols_per_hblank;
+	uint32_t required_bytes_per_hblank = 0;
+
+	samples_per_line = dc_fixpt_from_fraction(sample_rate_hz, 1000);
+	samples_per_line = dc_fixpt_div(samples_per_line, horizontal_line_freq_khz);
+	layouts_per_line = dc_fixpt_div_int(samples_per_line, layout_config.layouts_per_sample_denom);
+	// HBlank expansion usage assumes SDP split disabled to allow for worst case.
+	layouts_per_line = dc_fixpt_from_int(dc_fixpt_ceil(layouts_per_line));
+
+	num_sdp_with_max_layouts = dc_fixpt_floor(
+			dc_fixpt_div_int(layouts_per_line, layout_config.max_layouts_per_audio_sdp));
+	symbols_per_sdp_max_layout = dc_fixpt_from_int(
+			layout_config.max_layouts_per_audio_sdp * layout_config.symbols_per_layout);
+	symbols_per_sdp_max_layout = dc_fixpt_add_int(symbols_per_sdp_max_layout, audio_sdp_overhead);
+	symbols_per_sdp_max_layout = dc_fixpt_mul(symbols_per_sdp_max_layout, audio_sdp_margin);
+	required_symbols_per_hblank = num_sdp_with_max_layouts;
+	required_symbols_per_hblank *= ((dc_fixpt_ceil(symbols_per_sdp_max_layout) + av_stream_map_lane_count) /
+			av_stream_map_lane_count) *	av_stream_map_lane_count;
+
+	if (num_sdp_with_max_layouts !=	dc_fixpt_ceil(
+			dc_fixpt_div_int(layouts_per_line, layout_config.max_layouts_per_audio_sdp))) {
+		remainder = dc_fixpt_sub_int(layouts_per_line,
+				num_sdp_with_max_layouts * layout_config.max_layouts_per_audio_sdp);
+		remainder = dc_fixpt_mul_int(remainder, layout_config.symbols_per_layout);
+		remainder = dc_fixpt_add_int(remainder, audio_sdp_overhead);
+		remainder = dc_fixpt_mul(remainder, audio_sdp_margin);
+		required_symbols_per_hblank += ((dc_fixpt_ceil(remainder) + av_stream_map_lane_count) /
+				av_stream_map_lane_count) * av_stream_map_lane_count;
+	}
+
+	required_symbols_per_hblank += calculate_overhead_hblank_bw_in_symbols(max_slices_h);
+
+	if (link_encoding == DP_8b_10b_ENCODING)
+		required_bytes_per_hblank = required_symbols_per_hblank; // 8 bits per 8b/10b symbol
+	else if (link_encoding == DP_128b_132b_ENCODING)
+		required_bytes_per_hblank = required_symbols_per_hblank * 4; // 32 bits per 128b/132b symbol
+
+	return required_bytes_per_hblank;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.h b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
index 595fb05946e9..bf398c49c3e8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
@@ -37,4 +37,9 @@ uint32_t dp_link_bandwidth_kbps(
 	const struct dc_link *link,
 	const struct dc_link_settings *link_settings);
 
+
+uint32_t dp_required_hblank_size_bytes(
+	const struct dc_link *link,
+	struct dp_audio_bandwidth_params *audio_params);
+
 #endif /* __LINK_VALIDATION_H__ */
-- 
2.34.1

