Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E84CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DAB61165
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6DAB61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435446F5AC;
	Tue,  5 Oct 2021 07:58:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670ED6F53A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4S7jyfudCpW93pvKyFcS7ivJ+6XlKl/djs3i1I7Ig+XryzO6vGIy84beFTCCfqwUybUXs8Vxqitq/JvfI3AplHddqhfLcRID+p5ZCuVzj+7FW12CvHVU/ziYvYgRODEOc98HO3l9bS0RaIy8tGT6K5ehOlYRvPnorA270Dmxp1GvhvIa5m0BAWA0iMtg+kFvHSPM/9L3JUXmCovxRxZctxBXx046ZMedUt2cFzMj7tcubZbn4mSVI9WziG1jUKsR1camg5xa3tx2Lv+PovQjuNQOJ4kZEztoeZoVnFcH1tUHI2ZGdLDCzJjY1kwThGBcIvbTYzPnZ3HNwqhe8d5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOyEsCmnZNEcOaxp3Ck1BIKlxUleOAVIsDgVuYxslj8=;
 b=OAQL5EJUIxeTcGPknMfm72dAnYbVGbFeC2kw99Laiyn3kox6vPOXfbMT/YMgU43fC6RR03PkEs7YQ1Y1oaY7Guz840/uLCwhK3ynPV4MGRDIf5pESb13WPuQHi/dARiqE/FipQdqMEZFZs7059zLyDPMSh2+pr4nxemJ9YWBrJkqQXoG6Ejf6Yleyl6T5g6dX8O1+PTr+SxMPheJpsHcw6oXlrir9w0CisaG+6o6CA1fgSUGKe2Q+PeKMHy6ruxoGcUbHrGN+rdTpRBbwj4TskAkxw6XrllBBqZQ6fjdtnjA3xoWtbgLqu/zGo1aV5g0OMv6TU2nsY42kImWSMviuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOyEsCmnZNEcOaxp3Ck1BIKlxUleOAVIsDgVuYxslj8=;
 b=h0CIIscTUrcJdePzdPw3T9pUJZXgwS3b0GfBjNKUGAZfTeVyv1oJ5p7AlgfIsUDExTI7kEp0k+zLEktunOMCN/CYpaxm1nkdnDnuDjNNFXVTK3sYRebSwHRsI3nGrvY3oHdDJgkr9EVCa/Lt78zgfCFzYQ27jfCGIhl9DbyNlYQ=
Received: from BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::24)
 by DM6PR12MB4809.namprd12.prod.outlook.com (2603:10b6:5:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 07:57:58 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::fd) by BN9P220CA0019.outlook.office365.com
 (2603:10b6:408:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 07:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:57:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:57:56 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:57:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 12/23] drm/amd/display: Implement DPIA equalisation phase
Date: Tue, 5 Oct 2021 15:51:54 +0800
Message-ID: <20211005075205.3467938-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb03510-12b8-4ce9-c9e1-08d987d5d81a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4809:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4809BE658D764C312F80B845FCAF9@DM6PR12MB4809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkoNlP/hFcor0/f3W/470DNXySpJOfBdqpJNI+dmR5q/oAFsc9neyQ/VXFZmb/6emBd75b6I7QvVUBaEyOHDxEOI354Vh1ozsniiU/0pBC/fhyWCxYCSw77n7pgwj1FMLj0FYt6iWE0gFpcxAnKqXsNkQ7zrou7tvFYm0SHle63/XQcVKC/Dfbu3Fo6CG6MOMbDTEJ64dEKfhTAnJxL3+ocP3hzx6G3wdrkAGRKb4vdmQOiqfYCCFkTrE+Mkun/KsxqSafO6JDCXbna1imzD9rNZlEsWCKY2Fnkx4CH49V5XMau0+Yyjqs/1rhqXeGYOKe2jB5WAFcnvMJpUdhDnrRPay211DkbvJnZ5RAihCCGEEATRQrOqaZQMFpm/gCV+mOs+OhuThrD+cn6oPdqT8azMkyggYOLDXRLObmqOoD/rYTmDi65LDG2FM7vmCsXOml0NcguVhAd2wP8tKrPEZGRPXyirvuE2+Vw8NOzcrupSjBFQTTOabefZZukXY6FrOsoZxFz+cjNITRVYd3kQvBn2ppffxZ5hGDxljQjwqwSsQRd/F38+DAIfOnmQp/A9DGDVJab2fgY9K+sKRL957z7uqKjLxTxyGSyRG34CSlKSaXRpg8H18SPj7VoM4Yxfggbg07vHSS8PUfTLhXYJMJ3JjqJqXqwg8WLJdGBR5pZ6EPy6r4uUAQXJjnbCaZf4vYOnEQQqB2AaQJ2tA7ekK+EMQ6dGdDXVVel4h0i1ZU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(508600001)(316002)(6666004)(70206006)(7696005)(36860700001)(186003)(8676002)(54906003)(356005)(83380400001)(26005)(81166007)(70586007)(47076005)(36756003)(5660300002)(2616005)(1076003)(86362001)(2906002)(6916009)(426003)(336012)(8936002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:57:57.2524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb03510-12b8-4ce9-c9e1-08d987d5d81a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4809
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Equalisation is the mandatory second phase of DisplayPort link training
over a USB4 DP tunnel.

[How]
Implement equalisation phase for DP tunneled over USB4 in DPIA
training module.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 247 +++++++++++++++++-
 1 file changed, 244 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 9608fd345936..fa7539916c77 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -473,17 +473,258 @@ static enum link_training_result dpia_training_cr_phase(struct dc_link *link,
 	return result;
 }
 
+/* Return status read interval during equalization phase. */
+static uint32_t dpia_get_eq_aux_rd_interval(const struct dc_link *link,
+		const struct link_training_settings *lt_settings,
+		uint32_t hop)
+{
+	uint32_t wait_time_microsec;
+
+	if (hop == DPRX)
+		wait_time_microsec = lt_settings->eq_pattern_time;
+	else
+		wait_time_microsec =
+				dp_translate_training_aux_read_interval(
+					link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
+
+	return wait_time_microsec;
+}
+
+/* Execute equalization phase of link training for specified hop in display
+ * path in non-transparent mode:
+ * - driver issues both DPCD and SET_CONFIG transactions.
+ * - TPSx is transmitted for any hops downstream of DPOA.
+ * - Drive (VS/PE) only transmitted for the hop immediately downstream of DPOA.
+ * - EQ for the first hop (DPTX-to-DPIA) is assumed to be successful.
+ * - DPRX EQ only reported successful when both DPRX and DPIA requirements
+ * (clk sync packets sent) fulfilled.
+ *
+ * @param link DPIA link being trained.
+ * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
+ * @param hop Hop in display path. DPRX = 0.
+ */
+static enum link_training_result dpia_training_eq_non_transparent(struct dc_link *link,
+		struct link_training_settings *lt_settings,
+		uint32_t hop)
+{
+	enum link_training_result result = LINK_TRAINING_EQ_FAIL_EQ;
+	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
+	uint32_t retries_eq = 0;
+	enum dc_status status;
+	enum dc_dp_training_pattern tr_pattern;
+	uint32_t wait_time_microsec;
+	struct link_training_settings req_settings;
+	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
+	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	uint8_t set_cfg_data;
+	enum dpia_set_config_ts ts;
+
+	/* Training pattern is TPS4 for repeater;
+	 * TPS2/3/4 for DPRX depending on what it supports.
+	 */
+	if (hop == DPRX)
+		tr_pattern = lt_settings->pattern_for_eq;
+	else
+		tr_pattern = DP_TRAINING_PATTERN_SEQUENCE_4;
+
+	repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+	for (retries_eq = 0; retries_eq < LINK_TRAINING_MAX_RETRY_COUNT; retries_eq++) {
+		/* DPTX-to-DPIA equalization always successful. */
+		if (hop == repeater_cnt) {
+			result = LINK_TRAINING_SUCCESS;
+			break;
+		}
+
+		/* Instruct DPOA to transmit TPSn then update DPCD. */
+		if (retries_eq == 0) {
+			ts = convert_trng_ptn_to_trng_stg(tr_pattern);
+			status = core_link_send_set_config(link,
+					DPIA_SET_CFG_SET_TRAINING,
+					ts);
+			if (status != DC_OK) {
+				result = LINK_TRAINING_ABORT;
+				break;
+			}
+			status = dpcd_set_lt_pattern(link, tr_pattern, hop);
+			if (status != DC_OK) {
+				result = LINK_TRAINING_ABORT;
+				break;
+			}
+		}
+
+		/* Update DPOA drive settings then DPCD. DPOA only adjusts
+		 * drive settings for hop immediately downstream.
+		 */
+		if (hop == repeater_cnt - 1) {
+			set_cfg_data = dpia_build_set_config_data(DPIA_SET_CFG_SET_VSPE,
+								  link,
+								  lt_settings);
+			status = core_link_send_set_config(link,
+							   DPIA_SET_CFG_SET_VSPE,
+							   set_cfg_data);
+			if (status != DC_OK) {
+				result = LINK_TRAINING_ABORT;
+				break;
+			}
+		}
+		status = dpcd_set_lane_settings(link, lt_settings, hop);
+		if (status != DC_OK) {
+			result = LINK_TRAINING_ABORT;
+			break;
+		}
+
+		/* Extend wait time on second equalisation attempt on final hop to
+		 * ensure clock sync packets have been sent.
+		 */
+		if (hop == DPRX && retries_eq == 1)
+			wait_time_microsec = max(wait_time_microsec, (uint32_t)DPIA_CLK_SYNC_DELAY);
+		else
+			wait_time_microsec = dpia_get_eq_aux_rd_interval(link, lt_settings, hop);
+
+		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
+
+		/* Read status and adjustment requests from DPCD. */
+		status = dp_get_lane_status_and_drive_settings(link,
+				lt_settings,
+				dpcd_lane_status,
+				&dpcd_lane_status_updated,
+				&req_settings,
+				hop);
+		if (status != DC_OK) {
+			result = LINK_TRAINING_ABORT;
+			break;
+		}
+
+		/* CR can still fail during EQ phase. Fail training if CR fails. */
+		if (!dp_is_cr_done(lane_count, dpcd_lane_status)) {
+			result = LINK_TRAINING_EQ_FAIL_CR;
+			break;
+		}
+
+		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
+		    dp_is_symbol_locked(link->cur_link_settings.lane_count, dpcd_lane_status) &&
+		    dp_is_interlane_aligned(dpcd_lane_status_updated)) {
+			result =  LINK_TRAINING_SUCCESS;
+			break;
+		}
+
+		/* Update VS/PE. */
+		dp_update_drive_settings(lt_settings, req_settings);
+	}
+
+	/* Abort link training if equalization failed due to HPD unplug. */
+	if (!link->hpd_status)
+		result = LINK_TRAINING_ABORT;
+
+	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) equalization\n - hop(%d)\n - result(%d)\n - retries(%d)\n",
+				__func__,
+				link->link_id.enum_id - ENUM_ID_1,
+				hop,
+				result,
+				retries_eq);
+
+	return result;
+}
+
+/* Execute equalization phase of link training for specified hop in display
+ * path in transparent LTTPR mode:
+ * - driver only issues DPCD transactions leaves USB4 tunneling (SET_CONFIG) messages to DPIA.
+ * - driver writes TPSx to DPCD to notify DPIA that is in equalization phase.
+ * - equalization (EQ) for link is handled by DPOA, which reports result to DPIA on completion.
+ * - DPIA communicates result to driver by updating EQ status when driver reads DPCD.
+ *
+ * @param link DPIA link being trained.
+ * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
+ * @param hop Hop in display path. DPRX = 0.
+ */
+static enum link_training_result dpia_training_eq_transparent(struct dc_link *link,
+		struct link_training_settings *lt_settings)
+{
+	enum link_training_result result = LINK_TRAINING_EQ_FAIL_EQ;
+	uint32_t retries_eq = 0;
+	enum dc_status status;
+	enum dc_dp_training_pattern tr_pattern = lt_settings->pattern_for_eq;
+	uint32_t wait_time_microsec;
+	struct link_training_settings req_settings;
+	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
+	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+
+	wait_time_microsec = dpia_get_eq_aux_rd_interval(link, lt_settings, DPRX);
+
+	for (retries_eq = 0; retries_eq < LINK_TRAINING_MAX_RETRY_COUNT; retries_eq++) {
+		if (retries_eq == 0) {
+			status = dpcd_set_lt_pattern(link, tr_pattern, DPRX);
+			if (status != DC_OK) {
+				result = LINK_TRAINING_ABORT;
+				break;
+			}
+		}
+
+		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
+
+		/* Read status and adjustment requests from DPCD. */
+		status = dp_get_lane_status_and_drive_settings(link,
+				lt_settings,
+				dpcd_lane_status,
+				&dpcd_lane_status_updated,
+				&req_settings,
+				DPRX);
+		if (status != DC_OK) {
+			result = LINK_TRAINING_ABORT;
+			break;
+		}
+
+		/* CR can still fail during EQ phase. Fail training if CR fails. */
+		if (!dp_is_cr_done(lane_count, dpcd_lane_status)) {
+			result = LINK_TRAINING_EQ_FAIL_CR;
+			break;
+		}
+
+		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
+		    dp_is_symbol_locked(link->cur_link_settings.lane_count, dpcd_lane_status) &&
+		    dp_is_interlane_aligned(dpcd_lane_status_updated)) {
+			result =  LINK_TRAINING_SUCCESS;
+			break;
+		}
+
+		/* Update VS/PE. */
+		dp_update_drive_settings(lt_settings, req_settings);
+	}
+
+	/* Abort link training if equalization failed due to HPD unplug. */
+	if (!link->hpd_status)
+		result = LINK_TRAINING_ABORT;
+
+	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) equalization\n - hop(%d)\n - result(%d)\n - retries(%d)\n",
+				__func__,
+				link->link_id.enum_id - ENUM_ID_1,
+				DPRX,
+				result,
+				retries_eq);
+
+	return result;
+}
+
 /* Execute equalization phase of link training for specified hop in display
  * path.
+ *
+ * @param link DPIA link being trained.
+ * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
+ * @param hop Hop in display path. DPRX = 0.
  */
 static enum link_training_result dpia_training_eq_phase(struct dc_link *link,
 		struct link_training_settings *lt_settings,
 		uint32_t hop)
 {
-	enum link_training_result result;
+	enum link_training_result result = LINK_TRAINING_EQ_FAIL_EQ;
 
-	/** @todo Fail until implemented. */
-	result = LINK_TRAINING_ABORT;
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+		result = dpia_training_eq_non_transparent(link, lt_settings, hop);
+	else
+		result = dpia_training_eq_transparent(link, lt_settings);
 
 	return result;
 }
-- 
2.25.1

