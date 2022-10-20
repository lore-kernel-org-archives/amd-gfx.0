Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B5AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D7B10E48F;
	Thu, 20 Oct 2022 15:48:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733DB10E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+JTe8ySJtMnKm1jgdBw+gsK5tGqujzP7xipGBQY7qAeJ463FDE/dCKslqyNTFyh4s5JzqXIJjX1FSTJ2jpoPjTtCccZJS4YRjSKJqPNZPkpJ96PZHob+pDcTX/K8og8S4CfoucRWgsKGC45GiI1E9stdn0om4IZo6noPEeg1R+1Yc3f1g3etNTSQIozrDNFlVHnznetK3QJx9QNCxrOizLd4exC2lry63LBSyU9ojU+MjZvcWqk35+/cfsz5hND8ClC0r6m3BP5sb13VXzegd4hcCo0J+xBPjlaua0bndhXVY0pVw7Dj5MKiQlrIMauHS1l9bOQhyM/BHbQp8ftYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpisBk7mmd7VSFSYIMKDsKb+UblxxibZeucq0HcqOr0=;
 b=TVeWEZ4Tx7g6sjxZSBpvYmyuqasY3+2oayxuhr0G/BHpTCRiTFZPZPkCzCphpnSG5coLNbKKPRJOHxH2srUaLLuVQFvKoVIt3mQF9IVyWh4gaB5cgQlDIml3w1QPpBuIHXMNny3KBfrjgS5uKjMw7WgtpJs1AC31D+FQ1GYKsuA+H2n3nhHxdGzhNA52tRql7Wn6YltYaB5hTriSIN5uzfIMvZt3UT/SNQWEhguBSD2PKYeYPslZibMuR3zCBzfQ/DEC5W/9g/fcds5B/csug6DQN0FICW+D3HAk4WCH/jNJFlDH6uOiSzgWuNedYGWusbXNzhOtUcBgil7iXMsuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpisBk7mmd7VSFSYIMKDsKb+UblxxibZeucq0HcqOr0=;
 b=pCr4ib1Ct4NMsYPzsHtr18hflpBy/J1hye+HwSkcy1RaFiLdjLu0LTiEnj4ch24phpxBZxeJt+AxWRjjTYMdqpFls0u9pymTlFiQ09j5YSeogwnzBftxoWuxw/UDaGUHvWRMOVyXHtgp6Mhtq2A1MNvfM16Vzc1wvNDkr2dE62U=
Received: from DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 15:47:47 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::52) by DM6PR02CA0114.outlook.office365.com
 (2603:10b6:5:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:47 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/33] drm/amd/display: refine wake up aux in retrieve link
 caps
Date: Thu, 20 Oct 2022 11:46:39 -0400
Message-ID: <20221020154702.503934-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 048a8c8b-a059-4ec4-071b-08dab2b26fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSuKtugpJXuxNX5m/B4Jz4cFHtmvGHKwKumrlQgPrUGVJzdpginQC7xupFD3ruGkJ9PswQSuQq/XMyM0NPRHKc8hmfwzZWEh58P8Gr8hkSKV9iylzZ+ZD4IRic/HZqCLmGZFurLQ8ya9ytCYbVB/6pa3geuBUTb+FMLGrmSIbDLY02l3+/6onTHJdqo552UCOR2mweHdDP1fmgAwLImNzXxI/Mowsmxye6o8COXJdQX4GAYv7C+DE3nDiMEIRA9KaKaxHR59HwBe7ghoodbd5O8tzJ180HM2G6X4bwbv7uP3k3Iq+5HqT7XESbcbbJD/Wi0bOc181WhrGpWNLH80KC6adc6GpCLNqZzWeSiqrqJA5aD04ageOZ2mRQdyzmmQimbHOZi9gjsKCaIVl2cDYQSprANm+c61Jq6xThSC1DqrCrB6uDqBcbudXXL6gvzcI4qrfkwnjEyiX42TfZrjjeiRve4mQ7BrpakP0nKcgA8Y7nmziObiDg7eWd9Y4p5Rysk+o8fgOg9KlaYlLtpB6SNj7dPVZUdMCBWUOEkySZQ+EDEGP/vGB5eLGU19FHT5uWwJH1KzNaW4pIoQfUMScId3Le26EQVYuuoel88FqgEElQ3GU8qK5sqO+c2kDIi4RpttdUQp04xT6F1uZz/+RLvKZ1svAIGS7TCP7NzY1scskHIEoze39Q4OMOdxxYKGTuaRzZZSKf717OxYZdtAYYmqjZyYF1zAtSpunmrNj0FS31tVAV1qsBXcN5lPu07Hbnvu5pp0/MHcd0LeYTO40t8PAeylXwSxLHhViTaIUiM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(41300700001)(5660300002)(8936002)(36860700001)(81166007)(36756003)(4326008)(54906003)(478600001)(7696005)(70586007)(16526019)(8676002)(6916009)(40480700001)(40460700003)(1076003)(82740400003)(186003)(336012)(86362001)(82310400005)(426003)(83380400001)(26005)(2616005)(47076005)(356005)(316002)(2906002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:47.6022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048a8c8b-a059-4ec4-071b-08dab2b26fdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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
Cc: stylon.wang@amd.com, Lewis Huang <Lewis.Huang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
Read set_power_state dpcd after HPD cause USB4 CTS 4.2.1.1

[How]
Read LTTPR caps first. If aux channel not ready, wake up aux channel.
If wake up aux channel return pass, retrieve lttpr caps again. If wake
up aux channel return false, register a detection retry timer.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 148 +++++-------------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 2 files changed, 41 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 697c4925e1e9..dd2e90ec60df 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5031,7 +5031,7 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 	return true;
 }
 
-bool dp_retrieve_lttpr_cap(struct dc_link *link)
+enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 {
 	uint8_t lttpr_dpcd_data[8];
 	enum dc_status status = DC_ERROR_UNEXPECTED;
@@ -5099,7 +5099,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 
 	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
-	return is_lttpr_present;
+	return status;
 }
 
 bool dp_is_lttpr_present(struct dc_link *link)
@@ -5227,76 +5227,45 @@ static void retrieve_cable_id(struct dc_link *link)
 				&link->dpcd_caps.cable_id, &usbc_cable_id);
 }
 
-/* DPRX may take some time to respond to AUX messages after HPD asserted.
- * If AUX read unsuccessful, try to wake unresponsive DPRX by toggling DPCD SET_POWER (0x600).
- */
-static enum dc_status wa_try_to_wake_dprx(struct dc_link *link, uint64_t timeout_ms)
+enum dc_status wake_up_aux_channel(struct dc_link *link)
 {
 	enum dc_status status = DC_ERROR_UNEXPECTED;
-	uint8_t dpcd_data = 0;
-	uint64_t start_ts = 0;
-	uint64_t current_ts = 0;
-	uint64_t time_taken_ms = 0;
-	enum dc_connection_type type = dc_connection_none;
-	bool lttpr_present;
-	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
+	uint32_t aux_channel_retry_cnt = 0;
+	uint8_t dpcd_power_state = '\0';
 
-	lttpr_present = dp_is_lttpr_present(link) ||
-			(!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support);
-	DC_LOG_DC("lttpr_present = %d.\n", lttpr_present ? 1 : 0);
+	while (status != DC_OK && aux_channel_retry_cnt < 10) {
+		status = core_link_read_dpcd(link, DP_SET_POWER,
+				&dpcd_power_state, sizeof(dpcd_power_state));
 
-	/* Issue an AUX read to test DPRX responsiveness. If LTTPR is supported the first read is expected to
-	 * be to determine LTTPR capabilities. Otherwise trying to read power state should be an innocuous AUX read.
-	 */
-	if (lttpr_present)
-		status = core_link_read_dpcd(
-				link,
-				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
-				&dpcd_data,
-				sizeof(dpcd_data));
-	else
-		status = core_link_read_dpcd(
-				link,
-				DP_SET_POWER,
-				&dpcd_data,
-				sizeof(dpcd_data));
+		/* Delay 1 ms if AUX CH is in power down state. Based on spec
+		 * section 2.3.1.2, if AUX CH may be powered down due to
+		 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
+		 * signal and may need up to 1 ms before being able to reply.
+		 */
+		if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3) {
+			udelay(1000);
+			aux_channel_retry_cnt++;
+		}
+	}
 
 	if (status != DC_OK) {
-		DC_LOG_WARNING("%s: Read DPCD LTTPR_CAP failed - try to toggle DPCD SET_POWER for %lld ms.",
-				__func__,
-				timeout_ms);
-		start_ts = dm_get_timestamp(link->ctx);
-
-		do {
-			if (!dc_link_detect_sink(link, &type) || type == dc_connection_none)
-				break;
-
-			dpcd_data = DP_SET_POWER_D3;
-			status = core_link_write_dpcd(
-					link,
-					DP_SET_POWER,
-					&dpcd_data,
-					sizeof(dpcd_data));
-
-			dpcd_data = DP_SET_POWER_D0;
-			status = core_link_write_dpcd(
-					link,
-					DP_SET_POWER,
-					&dpcd_data,
-					sizeof(dpcd_data));
-
-			current_ts = dm_get_timestamp(link->ctx);
-			time_taken_ms = div_u64(dm_get_elapse_time_in_ns(link->ctx, current_ts, start_ts), 1000000);
-		} while (status != DC_OK && time_taken_ms < timeout_ms);
+		dpcd_power_state = DP_SET_POWER_D0;
+		status = core_link_write_dpcd(
+				link,
+				DP_SET_POWER,
+				&dpcd_power_state,
+				sizeof(dpcd_power_state));
 
-		DC_LOG_WARNING("%s: DPCD SET_POWER %s after %lld ms%s",
-				__func__,
-				(status == DC_OK) ? "succeeded" : "failed",
-				time_taken_ms,
-				(type == dc_connection_none) ? ". Unplugged." : ".");
+		dpcd_power_state = DP_SET_POWER_D3;
+		status = core_link_write_dpcd(
+				link,
+				DP_SET_POWER,
+				&dpcd_power_state,
+				sizeof(dpcd_power_state));
+		return DC_ERROR_UNEXPECTED;
 	}
 
-	return status;
+	return DC_OK;
 }
 
 static bool retrieve_link_cap(struct dc_link *link)
@@ -5308,7 +5277,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 	/*Only need to read 1 byte starting from DP_DPRX_FEATURE_ENUMERATION_LIST.
 	 */
 	uint8_t dpcd_dprx_data = '\0';
-	uint8_t dpcd_power_state = '\0';
 
 	struct dp_device_vendor_id sink_id;
 	union down_stream_port_count down_strm_port_count;
@@ -5316,11 +5284,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 	union dp_downstream_port_present ds_port = { 0 };
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	uint32_t read_dpcd_retry_cnt = 3;
-	uint32_t aux_channel_retry_cnt = 0;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
-	bool is_lttpr_present = false;
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(&down_strm_port_count,
@@ -5335,51 +5301,17 @@ static bool retrieve_link_cap(struct dc_link *link)
 	dc_link_aux_try_to_configure_timeout(link->ddc,
 			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
 
-	/* Try to ensure AUX channel active before proceeding. */
-	if (link->dc->debug.aux_wake_wa.bits.enable_wa) {
-		uint64_t timeout_ms = link->dc->debug.aux_wake_wa.bits.timeout_ms;
-
-		if (link->dc->debug.aux_wake_wa.bits.use_default_timeout)
-			timeout_ms = LINK_AUX_WAKE_TIMEOUT_MS;
-		status = wa_try_to_wake_dprx(link, timeout_ms);
-	}
-
-	while (status != DC_OK && aux_channel_retry_cnt < 10) {
-		status = core_link_read_dpcd(link, DP_SET_POWER,
-				&dpcd_power_state, sizeof(dpcd_power_state));
-
-		/* Delay 1 ms if AUX CH is in power down state. Based on spec
-		 * section 2.3.1.2, if AUX CH may be powered down due to
-		 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
-		 * signal and may need up to 1 ms before being able to reply.
-		 */
-		if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3) {
-			udelay(1000);
-			aux_channel_retry_cnt++;
-		}
-	}
+	status = dp_retrieve_lttpr_cap(link);
 
-	/* If aux channel is not active, return false and trigger another detect*/
 	if (status != DC_OK) {
-		dpcd_power_state = DP_SET_POWER_D0;
-		status = core_link_write_dpcd(
-				link,
-				DP_SET_POWER,
-				&dpcd_power_state,
-				sizeof(dpcd_power_state));
-
-		dpcd_power_state = DP_SET_POWER_D3;
-		status = core_link_write_dpcd(
-				link,
-				DP_SET_POWER,
-				&dpcd_power_state,
-				sizeof(dpcd_power_state));
-		return false;
+		status = wake_up_aux_channel(link);
+		if (status == DC_OK)
+			dp_retrieve_lttpr_cap(link);
+		else
+			return false;
 	}
 
-	is_lttpr_present = dp_retrieve_lttpr_cap(link);
-
-	if (is_lttpr_present)
+	if (dp_is_lttpr_present(link))
 		configure_lttpr_mode_transparent(link);
 
 	/* Read DP tunneling information. */
@@ -5406,7 +5338,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
-	if (!is_lttpr_present)
+	if (!dp_is_lttpr_present(link))
 		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 99c2ce2e7b9e..0286ada0424c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -193,7 +193,7 @@ enum dc_status dpcd_configure_lttpr_mode(
 		struct link_training_settings *lt_settings);
 
 enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings);
-bool dp_retrieve_lttpr_cap(struct dc_link *link);
+enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link);
 bool dp_is_lttpr_present(struct dc_link *link);
 enum lttpr_mode dp_decide_lttpr_mode(struct dc_link *link, struct dc_link_settings *link_setting);
 void dp_get_lttpr_mode_override(struct dc_link *link, enum lttpr_mode *override);
-- 
2.35.1

