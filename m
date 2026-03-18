Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D97BFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2366A10E652;
	Wed, 18 Mar 2026 01:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qUIE3zOc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADFC10E652
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnUGbm0R111D8KaDvAEsDi9DWVdp2W5d/ec8mEG5kBWn+zpM2urs8/eJBTwqZcJSJ/6E9YgX56FXowkdgcFUXEVm+L+MtK3mCEeTD0tcfjtllsNhlOAWCAHfFXXx39DQgf/KIRKNacYIbhxeIlKXT3lZkmbjkPvgIB+jq+9NdFA6rgfP4Rf8dJDgUav1p2n6x24B33OU8MD6lYt5zV/7W5lYdd/OCEzDC44/10cKus4KCOvUZxhR2b3fTW5HwR+jVA2yoYAnWmQJBg6E15bO2mhA8Zzy31eTz2C+ZViaQ+zaZQYn03E4udoeRKXotrCBZoUZILqJDpVb48kVqUtYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnaPnemd6AWbhRW2/GLiGNk/KC2vQA7obPw4mdHe77I=;
 b=weyQoh09dwjkR5zt4BEJ8rbXTw6Az11ioaMk7v45KxUUcDlabtEaUiQVU7VBLF/+wU7t04jSAJHNVkw5AekQ01zKqT4vi6xiXaEwS2FOG5CUbKgvPpylftQ7zUhBLRqrbtxgECQ9CsbhjkowOyC53KuKuiGzFKuVg6roI3pRr7bAuChjQgWH0d19nXBTtCES124CbNXYNn0qSjGruLBf99LdIRPEZLWFPPcK9PBflYJKh2ClfTzUIbT7gy34ZRI+tAzemCTxMnOGKCvvv8WYoJDiLSyi4ckvBnMLExdIk0zKxD0/8Wn9a2+DFNs+7ljVkbK8e60lJtWFaNMvvs+QoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnaPnemd6AWbhRW2/GLiGNk/KC2vQA7obPw4mdHe77I=;
 b=qUIE3zOcx5Lrg2ZWFk1a4fyu56Imj/2wxexdkXoKpeeMKgfKimMVHWNpKA3ovMIuX88s6wIG0yGBPKa8rYn2Bt5GRNf/pMQ3grbUe5LPqr6Ni+Cm35eg/hxn+ceyiRvJdcCFogALphEPMQcwt+ggv4ezwBL/fT5B6Z0jeqISb1c=
Received: from SA0PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:d3::18)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 01:02:12 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::56) by SA0PR11CA0013.outlook.office365.com
 (2603:10b6:806:d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:11 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:08 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Aric
 Cyr" <aric.cyr@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 19/31] drm/amd/display: Fix Silence warnings
Date: Wed, 18 Mar 2026 08:59:28 +0800
Message-ID: <20260318010224.513094-20-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ae0ca8-ee6a-4cdc-e06e-08de8489fcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: szJm5WsIrim2/qtxN3eV1CSY3IJNorKuGTZKP906AWN8mJizgJ4E2rzdoekXyb5zDBay/HnxUYTJTWoEWOwZ4eNQ6/9/zLwyPKabNmpJgFdsLdWnUJvjFMJgQCJ6p3raXRodrf1zrycwKmD7FOthSmk/RPMUYXgsVjV3locCmkEb6zVoMu1vADllZwlHz0e72jmXDm5zkABfw0qVZ5z6F6WLdD2PpwQc8zIt5g8BQpZi1mlhljXRfiJa+s08fL9uHuVBCjibqbFw8ia4YnP81qqBXigOaWElm8DN9ht3H7wA0PtH3QjkVYBjDio0veWuMQHc9HDDrSyJPtaYZGfc4CtPdJ+I9EVN58+zjkQfwQH+KW6M69mhDR5LS+9Jndfw2TA+VEp+DI9db+a6frT1d+G+wj1bFOFdIiYLoi3CapEOopIWzRrQQTbjCAWhSAY3lS1Gej8eORxp3oH+ACmyddfpzP6U+wDCgnLcKUzuPUkRKdB4DMhg1BLbR/WhkXPeDaldzKB2H06zf5Hbya7VYSdpr+1Z55iPEXrtkJ/OADhp03lh0nPrmXmZc2LgJNzff2OGBaf1KkWCT4fQN2WXUBuau7MptyD4xnvPvCaRYvpRNXyEoGRsv7GIinJF9eGwK7kGa8Ox3N+0TBDjHUzDWT5+aUVAXwYjGLDLwdY+YKEPsbsOnBgTigGIXp8GlXVA49W3uXGapEpxq+8VLn7DOWBVyPx38dGHbPdXYctnfZIMLpWfBRBOhurP+wUM33rFNUqlmnJ0UYAgFrNGgGmxFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vMoNuQot2S6ZBM+uMx2ynU7GXofdC+4SGDcGJeKlEoLZpDKbjHUUPPaUXx/iQXJ5ANumWc4xJVqbPw/XWdwUEGcEdhlGegotLugHachnofsMhlA1gEsHT0vHBsUbNccxXvssZxmQp4iI5TKCa+ElDzJ3qP+5gMOw9QsLyxCQy6GUPXEA3agxP8Sdls2K+HuDqVTbZXUChldnlOeGUUJ5G+Qnuwn9Qop9w7s9XcAkdp/9D8usQIirE+jiz2+0ncq9fhdHXUhLHdWojXKYJnpJ+4urf92M+PrMpgjgNyXAF0C/+a/UE4Pv9Hh/cDFj90efzRlBDMJ9XwnUhF6kYOGCY+c5mdqVH5E8Nql22ohQcmXTDSEsPqIavVAAMreptGtkHyLI9HqnO4fHNR2J5DfUgVGv95ncKhkDKBr7h03eZi5HEDzl615B4BIlGnG1jVZW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:11.8872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ae0ca8-ee6a-4cdc-e06e-08de8489fcc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Also affects: freesync, hdcp, info_packet, power

[Why] Resolve compiler warnings by marking unused parameters explicitly.

[How] In .c/.h keep parameter names in signatures and add a line with
      `(void)param;`  inside the function body

Preserved function signatures and avoids breaking code paths that
may reference the parameter under conditional compilation.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 ++
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 6 ++++++
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h         | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index a71df052cf25..0f9e8a11df0d 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -896,6 +896,7 @@ static void build_de_pq(struct pwl_float_data_ex *de_pq,
 		uint32_t hw_points_num,
 		const struct hw_x_point *coordinate_x)
 {
+	(void)coordinate_x;
 	uint32_t i;
 	struct fixed31_32 output;
 	struct fixed31_32 *de_pq_table = mod_color_get_table(type_de_pq_table);
@@ -1339,6 +1340,7 @@ static void scale_gamma_dx(struct pwl_float_data *pwl_rgb,
 		const struct dc_gamma *ramp,
 		struct dividers dividers)
 {
+	(void)dividers;
 	uint32_t i;
 	struct fixed31_32 min = dc_fixpt_zero;
 	struct fixed31_32 max = dc_fixpt_one;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 1aae46d703ba..b7e03dda700c 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -114,6 +114,7 @@ static unsigned int calc_duration_in_us_from_v_total(
 		const struct mod_vrr_params *in_vrr,
 		unsigned int v_total)
 {
+	(void)in_vrr;
 	unsigned int duration_in_us =
 			(unsigned int)(div64_u64(((unsigned long long)(v_total)
 				* 10000) * stream->timing.h_total,
@@ -218,6 +219,7 @@ static void update_v_total_for_static_ramp(
 		const struct dc_stream_state *stream,
 		struct mod_vrr_params *in_out_vrr)
 {
+	(void)core_freesync;
 	unsigned int v_total = 0;
 	unsigned int current_duration_in_us =
 			calc_duration_in_us_from_v_total(
@@ -292,6 +294,7 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		unsigned int last_render_time_in_us,
 		struct mod_vrr_params *in_out_vrr)
 {
+	(void)core_freesync;
 	unsigned int inserted_frame_duration_in_us = 0;
 	unsigned int mid_point_frames_ceil = 0;
 	unsigned int mid_point_frames_floor = 0;
@@ -447,6 +450,7 @@ static void apply_fixed_refresh(struct core_freesync *core_freesync,
 		unsigned int last_render_time_in_us,
 		struct mod_vrr_params *in_out_vrr)
 {
+	(void)core_freesync;
 	bool update = false;
 	unsigned int max_render_time_in_us = in_out_vrr->max_duration_in_us;
 
@@ -545,6 +549,7 @@ static bool vrr_settings_require_update(struct core_freesync *core_freesync,
 		unsigned int max_refresh_in_uhz,
 		struct mod_vrr_params *in_vrr)
 {
+	(void)core_freesync;
 	if (in_vrr->state != in_config->state) {
 		return true;
 	} else if (in_vrr->state == VRR_STATE_ACTIVE_FIXED &&
@@ -946,6 +951,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		struct dc_info_packet *infopacket,
 		bool pack_sdp_v1_3)
 {
+	(void)mod_freesync;
 	/* SPD info packet for FreeSync
 	 * VTEM info packet for HdmiVRR
 	 * Check if Freesync is supported. Return if false. If true,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 26a351a184f3..d07387a961dd 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -501,6 +501,7 @@ static inline void callback_in_ms(uint16_t time, struct mod_hdcp_output *output)
 static inline void set_watchdog_in_ms(struct mod_hdcp *hdcp, uint16_t time,
 		struct mod_hdcp_output *output)
 {
+	(void)hdcp;
 	output->watchdog_timer_needed = 1;
 	output->watchdog_timer_delay = time;
 }
-- 
2.43.0

