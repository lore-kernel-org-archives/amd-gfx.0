Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E755C35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FD42082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3viDdzKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FD42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D866FC4E;
	Fri, 31 Jan 2020 22:17:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DE76FC48
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLz46iurgvGN/pbkYeNPyVPYdC1oGM3DgvPw1u7tREDTXABCkipC5VY3FDO42yX1R4ZHx08kk8aat0nWnjBgR9QFnSucoQJzDVp3+DXkwLXOEjdvRDFpOuO3q4Beu4uaDVvzg+KlP0JFm2wBh6B3cQ6RzLoYxrZIDwN50I28G/b4NTQAujkcbEqurV8AfDG+IwLJ7tPYgmkLrXKgllWyWlDFwWZ3rf10XhBXqn3W8N+Lcs88lFf1/8KTxYh7HZR/c/RcXFjad4SOHN8Ysv3FUz0r6OyTou2x3wGvhuaLvglBFkRIu9a8u1fdb5Rgcm9ObSw2IKQK8gOahbn1syQ0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UdjtKvFHgdJmrTPFiDHEmRJim4eZWqdEEhx88gKpF4=;
 b=kI9oExts2O5+2h3Ot88dBt/r4IU+02v1PPlg5O9oVQFEylbNyaUprzyt6Kclagg8ZT7s8GbYjOpvED3SaN7WUAqkc6PMcWkXeRctLebotGGfZCU8HVrhfRGe0MJx/gi+j4EdOShR6N0xhz2QmAvpr1DiOsglx9I9ENFIJLMVgfhBaBn1lfed0ZmDH6Gy++4W2R8XA5h/pWoAB2/r6MunvAjDEx2XuJlr/poc60FD4SSCO9aLCOxKuyX/hWaysj9hcXsQYiiJE70FMOVkFNf6858XAYMZiczHtomb82i8oOmNFVZiw+XgPXOZFca+SzJwwiI/IxK5xDWoClJchSY2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UdjtKvFHgdJmrTPFiDHEmRJim4eZWqdEEhx88gKpF4=;
 b=3viDdzKntxs2xpqbStNgm4IttmtY40avImes/HWbiTTHUanA0/DyIB3tiw1/7kpmZQ5bc2W+zVBflimQNPlHUOCdfRFAd6AqUitNCnCGID+hs1j28ijIP/+6jqN91MjJhQ+GmAneXPc9h4MuBXqz42bwhjpoEbgx7+vaZeNNsls=
Received: from SN1PR12CA0083.namprd12.prod.outlook.com (2603:10b6:802:21::18)
 by BN8PR12MB3538.namprd12.prod.outlook.com (2603:10b6:408:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Fri, 31 Jan
 2020 22:17:23 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by SN1PR12CA0083.outlook.office365.com
 (2603:10b6:802:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:22 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:14 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:14 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/33] drm/amd/display: linux enable oled panel support dc part
Date: Fri, 31 Jan 2020 17:16:40 -0500
Message-ID: <20200131221643.10035-31-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(428003)(199004)(189003)(81166006)(8936002)(81156014)(30864003)(36756003)(54906003)(5660300002)(356004)(6666004)(8676002)(478600001)(4326008)(70206006)(70586007)(316002)(336012)(186003)(26005)(426003)(19627235002)(7696005)(2616005)(6916009)(86362001)(2906002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3538; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6e636c-64f6-4696-e6c2-08d7a69b587a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3538:
X-Microsoft-Antispam-PRVS: <BN8PR12MB353874735CC30C6B48A2EC1AF9070@BN8PR12MB3538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UL2v94YYf5DwE+hA+as/VtmH48YGeS7d+JsU+i0sdqKsUQ6/mah6FuoI4tHuCEnQqjXPfM8E2i9QiE8qWEFlbFtU5Bz1/AiIO0zdczXEAFtYP3NQS/Nic6kFc/gehZZ6KLsi7AgtuN+EK6A3yv18t9xlozTyOC16DmtASqFkLthmcnq/xY87DJqyVYMoCpNECFA7FwFCVzzLOmykqdCf4kuL8YyKoywCuJ9EeuoEb/Iy4XMkLHjPIuA+WNtnaKwOX3fHIJrd1QhfFPekf1nRi1G/M4LQP+5IhfX5TDiFS5yscKb6u7HtvGtQjoGygEpD1/ioRBXaHhD/i8YvF2MMl74R8Ii+ICx0U1dFfNHbQvRlt+m88he5Y/McAFljNkADqR04Yxf8RE24ep9NjoBI7T+SPICROFnMbFi0nA47ZAacQMQiy+DIklpgVIzuTC5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:22.9174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6e636c-64f6-4696-e6c2-08d7a69b587a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3538
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] old panel has been enabled for window driver but not linux.

[How] enable oled panel support for linux. this patch is dc part.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  32 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 168 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  14 ++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  34 ++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  16 ++
 .../display/dc/dce110/dce110_hw_sequencer.c   |  14 ++
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +
 7 files changed, 279 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fe50747692ec..bed57051f04d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -599,6 +599,9 @@ static bool detect_dp(
 
 	if (sink_caps->transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 		sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+		dpcd_set_source_specific_data(link);
+
 		if (!detect_dp_sink_caps(link))
 			return false;
 
@@ -769,8 +772,16 @@ static bool dc_link_detect_helper(struct dc_link *link,
 
 	if ((link->connector_signal == SIGNAL_TYPE_LVDS ||
 			link->connector_signal == SIGNAL_TYPE_EDP) &&
-			link->local_sink)
+			link->local_sink) {
+
+		// need to re-write OUI and brightness in resume case
+		if (link->connector_signal == SIGNAL_TYPE_EDP) {
+			dpcd_set_source_specific_data(link);
+			dc_link_set_default_brightness_aux(link); //TODO: use cached
+		}
+
 		return true;
+	}
 
 	if (false == dc_link_detect_sink(link, &new_connection_type)) {
 		BREAK_TO_DEBUGGER();
@@ -818,6 +829,10 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		}
 
 		case SIGNAL_TYPE_EDP: {
+			read_current_link_settings_on_detect(link);
+
+			dpcd_set_source_specific_data(link);
+
 			detect_edp_sink_caps(link);
 			read_current_link_settings_on_detect(link);
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
@@ -1492,6 +1507,7 @@ static enum dc_status enable_link_dp(
 	bool fec_enable;
 	int i;
 	bool apply_seamless_boot_optimization = false;
+	uint32_t bl_oled_enable_delay = 50; // in ms
 
 	// check for seamless boot
 	for (i = 0; i < state->stream_count; i++) {
@@ -1515,6 +1531,9 @@ static enum dc_status enable_link_dp(
 	if (state->clk_mgr && !apply_seamless_boot_optimization)
 		state->clk_mgr->funcs->update_clocks(state->clk_mgr, state, false);
 
+	// during mode switch we do DP_SET_POWER off then on, and OUI is lost
+	dpcd_set_source_specific_data(link);
+
 	skip_video_pattern = true;
 
 	if (link_settings.link_rate == LINK_RATE_LOW)
@@ -1538,6 +1557,17 @@ static enum dc_status enable_link_dp(
 		fec_enable = true;
 
 	dp_set_fec_enable(link, fec_enable);
+
+	// during mode set we do DP_SET_POWER off then on, aux writes are lost
+	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
+		dc_link_set_default_brightness_aux(link); // TODO: use cached if known
+		if (link->dpcd_sink_ext_caps.bits.oled == 1)
+			msleep(bl_oled_enable_delay);
+		dc_link_backlight_enable_aux(link, true);
+	}
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 07b9aa1d01af..c5b45d17e8cd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -20,6 +20,14 @@
 
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE   0x50
 
+#define DP_SOURCE_TABLE_REVISION	    0x310
+#define DP_SOURCE_PAYLOAD_SIZE		    0x311
+#define DP_SOURCE_SINK_CAP		    0x317
+#define DP_SOURCE_BACKLIGHT_LEVEL	    0x320
+#define DP_SOURCE_BACKLIGHT_CURRENT_PEAK    0x326
+#define DP_SOURCE_BACKLIGHT_CONTROL	    0x32E
+#define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
+
 /* maximum pre emphasis level allowed for each voltage swing level*/
 static const enum dc_pre_emphasis voltage_swing_to_pre_emphasis[] = {
 		PRE_EMPHASIS_LEVEL3,
@@ -3166,6 +3174,23 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
 		link->wa_flags.dp_keep_receiver_powered = false;
 }
 
+/* Read additional sink caps defined in source specific DPCD area
+ * This function currently only reads from SinkCapability address (DP_SOURCE_SINK_CAP)
+ */
+static bool dpcd_read_sink_ext_caps(struct dc_link *link)
+{
+	uint8_t dpcd_data;
+
+	if (!link)
+		return false;
+
+	if (core_link_read_dpcd(link, DP_SOURCE_SINK_CAP, &dpcd_data, 1) != DC_OK)
+		return false;
+
+	link->dpcd_sink_ext_caps.raw = dpcd_data;
+	return true;
+}
+
 static bool retrieve_link_cap(struct dc_link *link)
 {
 	/* DP_ADAPTER_CAP - DP_DPCD_REV + 1 == 16 and also DP_DSC_BITS_PER_PIXEL_INC - DP_DSC_SUPPORT + 1 == 16,
@@ -3438,6 +3463,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 				sizeof(link->dpcd_caps.dsc_caps.dsc_ext_caps.raw));
 	}
 
+	if (!dpcd_read_sink_ext_caps(link))
+		link->dpcd_sink_ext_caps.raw = 0;
+
 	/* Connectivity log: detection */
 	CONN_DATA_DETECT(link, dpcd_data, sizeof(dpcd_data), "Rx Caps: ");
 
@@ -3590,6 +3618,8 @@ void detect_edp_sink_caps(struct dc_link *link)
 		}
 	}
 	link->verified_link_cap = link->reported_link_cap;
+
+	dc_link_set_default_brightness_aux(link);
 }
 
 void dc_link_dp_enable_hpd(const struct dc_link *link)
@@ -4147,3 +4177,141 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 	}
 }
 
+void dpcd_set_source_specific_data(struct dc_link *link)
+{
+	struct dpcd_amd_signature amd_signature;
+	const uint32_t post_oui_delay = 30; // 30ms
+
+	amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
+	amd_signature.AMD_IEEE_TxSignature_byte2 = 0x0;
+	amd_signature.AMD_IEEE_TxSignature_byte3 = 0x1A;
+	amd_signature.device_id_byte1 =
+			(uint8_t)(link->ctx->asic_id.chip_id);
+	amd_signature.device_id_byte2 =
+			(uint8_t)(link->ctx->asic_id.chip_id >> 8);
+	memset(&amd_signature.zero, 0, 4);
+	amd_signature.dce_version =
+			(uint8_t)(link->ctx->dce_version);
+	amd_signature.dal_version_byte1 = 0x0; // needed? where to get?
+	amd_signature.dal_version_byte2 = 0x0; // needed? where to get?
+
+	core_link_write_dpcd(link, DP_SOURCE_OUI,
+			(uint8_t *)(&amd_signature),
+			sizeof(amd_signature));
+
+	// Sink may need to configure internals based on vendor, so allow some
+	// time before proceeding with possibly vendor specific transactions
+	msleep(post_oui_delay);
+}
+
+bool dc_link_set_backlight_level_nits(struct dc_link *link,
+		bool isHDR,
+		uint32_t backlight_millinits,
+		uint32_t transition_time_in_ms)
+{
+	struct dpcd_source_backlight_set dpcd_backlight_set;
+	uint8_t backlight_control = isHDR ? 1 : 0;
+
+	if (!link || (link->connector_signal != SIGNAL_TYPE_EDP &&
+			link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
+		return false;
+
+	// OLEDs have no PWM, they can only use AUX
+	if (link->dpcd_sink_ext_caps.bits.oled == 1)
+		backlight_control = 1;
+
+	*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
+	*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
+
+
+	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
+			(uint8_t *)(&dpcd_backlight_set),
+			sizeof(dpcd_backlight_set)) != DC_OK)
+		return false;
+
+	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_CONTROL,
+			&backlight_control, 1) != DC_OK)
+		return false;
+
+	return true;
+}
+
+bool dc_link_get_backlight_level_nits(struct dc_link *link,
+		uint32_t *backlight_millinits_avg,
+		uint32_t *backlight_millinits_peak)
+{
+	union dpcd_source_backlight_get dpcd_backlight_get;
+
+	memset(&dpcd_backlight_get, 0, sizeof(union dpcd_source_backlight_get));
+
+	if (!link || (link->connector_signal != SIGNAL_TYPE_EDP &&
+			link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
+		return false;
+
+	if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
+			dpcd_backlight_get.raw,
+			sizeof(union dpcd_source_backlight_get)))
+		return false;
+
+	*backlight_millinits_avg =
+		dpcd_backlight_get.bytes.backlight_millinits_avg;
+	*backlight_millinits_peak =
+		dpcd_backlight_get.bytes.backlight_millinits_peak;
+
+	/* On non-supported panels dpcd_read usually succeeds with 0 returned */
+	if (*backlight_millinits_avg == 0 ||
+			*backlight_millinits_avg > *backlight_millinits_peak)
+		return false;
+
+	return true;
+}
+
+bool dc_link_backlight_enable_aux(struct dc_link *link, bool enable)
+{
+	uint8_t backlight_enable = enable ? 1 : 0;
+
+	if (!link || (link->connector_signal != SIGNAL_TYPE_EDP &&
+		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
+		return false;
+
+	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_ENABLE,
+		&backlight_enable, 1) != DC_OK)
+		return false;
+
+	return true;
+}
+
+// we read default from 0x320 because we expect BIOS wrote it there
+// regular get_backlight_nit reads from panel set at 0x326
+bool dc_link_read_default_bl_aux(struct dc_link *link, uint32_t *backlight_millinits)
+{
+	if (!link || (link->connector_signal != SIGNAL_TYPE_EDP &&
+		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
+		return false;
+
+	if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
+		(uint8_t *) backlight_millinits,
+		sizeof(uint32_t)))
+		return false;
+
+	return true;
+}
+
+bool dc_link_set_default_brightness_aux(struct dc_link *link)
+{
+	uint32_t default_backlight;
+
+	if (link &&
+		(link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)) {
+		if (!dc_link_read_default_bl_aux(link, &default_backlight))
+			default_backlight = 150000;
+		// if < 5 nits or > 5000, it might be wrong readback
+		if (default_backlight < 5000 || default_backlight > 5000000)
+			default_backlight = 150000; //
+
+		return dc_link_set_backlight_level_nits(link, true,
+				default_backlight, 0);
+	}
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e52a469b4672..6e2e5e24daaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -980,6 +980,20 @@ struct dpcd_caps {
 
 };
 
+union dpcd_sink_ext_caps {
+	struct {
+		/* 0 - Sink supports backlight adjust via PWM during SDR/HDR mode
+		 * 1 - Sink supports backlight adjust via AUX during SDR/HDR mode.
+		 */
+		uint8_t sdr_aux_backlight_control : 1;
+		uint8_t hdr_aux_backlight_control : 1;
+		uint8_t reserved_1 : 2;
+		uint8_t oled : 1;
+		uint8_t reserved : 3;
+	} bits;
+	uint8_t raw;
+};
+
 #include "dc_link.h"
 
 /*******************************************************************************
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index dfe4472c9e40..f762f35f529d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -432,6 +432,40 @@ struct dp_sink_hw_fw_revision {
 	uint8_t ieee_fw_rev[2];
 };
 
+struct dpcd_amd_signature {
+	uint8_t AMD_IEEE_TxSignature_byte1;
+	uint8_t AMD_IEEE_TxSignature_byte2;
+	uint8_t AMD_IEEE_TxSignature_byte3;
+	uint8_t device_id_byte1;
+	uint8_t device_id_byte2;
+	uint8_t zero[4];
+	uint8_t dce_version;
+	uint8_t dal_version_byte1;
+	uint8_t dal_version_byte2;
+};
+
+struct dpcd_source_backlight_set {
+	struct  {
+		uint8_t byte0;
+		uint8_t byte1;
+		uint8_t byte2;
+		uint8_t byte3;
+	} backlight_level_millinits;
+
+	struct  {
+		uint8_t byte0;
+		uint8_t byte1;
+	} backlight_transition_time_ms;
+};
+
+union dpcd_source_backlight_get {
+	struct {
+		uint32_t backlight_millinits_peak; /* 326h */
+		uint32_t backlight_millinits_avg; /* 32Ah */
+	} bytes;
+	uint8_t raw[8];
+};
+
 /*DPCD register of DP receiver capability field bits-*/
 union edp_configuration_cap {
 	struct {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index d25603128394..5f341e960506 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -128,6 +128,7 @@ struct dc_link {
 	enum edp_revision edp_revision;
 	bool psr_feature_enabled;
 	bool psr_allow_active;
+	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
 	/* MST record stream using this link */
 	struct link_flags {
@@ -178,6 +179,21 @@ bool dc_link_set_backlight_level(const struct dc_link *dc_link,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp);
 
+/* Set/get nits-based backlight level of an embedded panel (eDP, LVDS). */
+bool dc_link_set_backlight_level_nits(struct dc_link *link,
+		bool isHDR,
+		uint32_t backlight_millinits,
+		uint32_t transition_time_in_ms);
+
+bool dc_link_get_backlight_level_nits(struct dc_link *link,
+		uint32_t *backlight_millinits,
+		uint32_t *backlight_millinits_peak);
+
+bool dc_link_backlight_enable_aux(struct dc_link *link, bool enable);
+
+bool dc_link_read_default_bl_aux(struct dc_link *link, uint32_t *backlight_millinits);
+bool dc_link_set_default_brightness_aux(struct dc_link *link);
+
 int dc_link_get_backlight_level(const struct dc_link *dc_link);
 
 bool dc_link_set_abm_disable(const struct dc_link *dc_link);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 56d4ec7bdad7..28b681b33f7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -71,6 +71,8 @@
 #define PANEL_POWER_UP_TIMEOUT 300
 #define PANEL_POWER_DOWN_TIMEOUT 500
 #define HPD_CHECK_INTERVAL 10
+#define OLED_POST_T7_DELAY 100
+#define OLED_PRE_T11_DELAY 150
 
 #define CTX \
 	hws->ctx
@@ -936,9 +938,21 @@ void dce110_edp_backlight_control(
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 		edp_receiver_ready_T7(link);
 	link_transmitter_control(ctx->dc_bios, &cntl);
+
+	if (enable && link->dpcd_sink_ext_caps.bits.oled)
+		msleep(OLED_POST_T7_DELAY);
+
+	if (link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)
+		dc_link_backlight_enable_aux(link, enable);
+
 	/*edp 1.2*/
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_OFF)
 		edp_receiver_ready_T9(link);
+
+	if (!enable && link->dpcd_sink_ext_caps.bits.oled)
+		msleep(OLED_PRE_T11_DELAY);
 }
 
 void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 8b1f0ce6c2a7..e94e5fbf2aa2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -78,6 +78,8 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 
 bool dp_overwrite_extended_receiver_cap(struct dc_link *link);
 
+void dpcd_set_source_specific_data(struct dc_link *link);
+
 void dp_set_fec_ready(struct dc_link *link, bool ready);
 void dp_set_fec_enable(struct dc_link *link, bool enable);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
