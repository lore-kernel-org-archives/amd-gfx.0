Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBDC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C3F61391
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6C3F61391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C40E6EA06;
	Mon,  4 Oct 2021 14:44:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6746EA06
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK3ZjXjzoWZHfoMBTRjlYYvryMFEMPXhcv9etXroQPlaKASGzO93xb16MLBmnd9zozWy2brzEt2cGCNIEKGIPGwqFNX5NyCu17w1/dl9jusWqqHQZ3FzaSsrgIBYmqX3Gy5jdbvDt/MZ5eEIA7mnqG3DJIrtwK2DgRc/uU5Hltlr8QiFY4Uwba8imll2Mca3yXHCe0K5EG7CFvRYxc/Ord8QOUjjPC9P8rS4TaiY50FQtxfEoLBU1uAuKtKuAN5Evk6mM4uIw0TWAOGICIvG2o6O15ZJXunHEP/CT7xf0Uji/GsUodHwVCnLs1BxwORwcRqxd3HypEurk2qdlgG+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOyEsCmnZNEcOaxp3Ck1BIKlxUleOAVIsDgVuYxslj8=;
 b=LqJZg4SI5x5F2g8RSg80AGQhQQfXiWYXJyKQ0rihDcC9BkgLhwnEkO5rDhHUinzeRKKcAlUCYA1dHxt8orFl62Og1uUzhR1S2tsb4XCS+aGUci+2mn/W2i0jp676GZcReIm3WEfMgYkW42yZLiEwPaOUWOTSNroexxm6EQqabpke8heozxzMcMjeL4a+2eigwTA2h3kO/NIV+ph4hlRo4QL7f0lHYq7uhgiexlZI7E85jGuYKMxUHwVzDfk0EVmavd6hUYn9Uhqw1afZQRjaiImBfxPJEz+FFmZ8qgvo3lzDNALqo1d2t9ginFPE/fqmq+t55w1E+h3sdA+ZJhln/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOyEsCmnZNEcOaxp3Ck1BIKlxUleOAVIsDgVuYxslj8=;
 b=PebSrPGKUb7J4pkrL2KM9EL6Ah7cowX3dIL/vO0xC0JE8/Ae8vo/mGvxFP35vAARAxJWYe3tnFzpSVgQ++GOcy/vpz7awbgw/o6ZcY80+EHRhhzHkFsKHDLxDLaAHmq9K7v/bH61qWCTDndGaLByMPvgPg/B0/dJZE1pkvVxGYo=
Received: from MWHPR20CA0007.namprd20.prod.outlook.com (2603:10b6:300:13d::17)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 14:43:57 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::d9) by MWHPR20CA0007.outlook.office365.com
 (2603:10b6:300:13d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Mon, 4 Oct 2021 14:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:43:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:43:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:43:55 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:43:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 12/23] drm/amd/display: Implement DPIA equalisation phase
Date: Mon, 4 Oct 2021 22:40:39 +0800
Message-ID: <20211004144050.3425351-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2abf421-9e9f-4769-7c45-08d987456521
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2638A912A358365101C5FA6FFCAE9@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gs+H3EEAzwVGBnJoQBDvVXeqnGKD6XJ2RyuHHSyAdh1Ea+tS01Osrtugm5fmz6N57zOcLR1TAePpesm12LxGVIMtfEjZiKBVEc2m8q0VrrP4T4F8bl2vqmSlQ1mEcv0Pj9ViQmbhz5qTURimo2lcQBrRPJm7JyTEvIXDBEyf5wGz2Ch9y9djML0spNi4pw114Kisy96cfuk1xqHsPmia2QjrkBXsAhKE67k0uHdQlMteJKxSz/N5KmAvVWqNdYy8qRA8La95HYWeUGq4+tT13ulKwLUMNCgLiW8uWQqglPW8Rx9aQXD9a/pQU3VlyqyR7UDqQWihxMGnYQEyZm1GrazVBiW6f17Zt+izWQQWW0lZuZDVCd+R2gCBoHWJXoN53RVYI5U09Zs44Y8yqN7lqV/EmX2EUWs3UKLdkFpLQ6FUnE9pgi5WfA65ZkfPdPDJb6TUNh3CJnj9aCgi0H+elmYa5P7BJQQs0xUDzEYsFhQx9YGirC5oeZl0VZBCSIePd31Bx7izOHN9A/wniB00GGnCsPR0KWk9Nfk3SbRQDrxPByTs5m4d46UDxWHzpmpcYMtVv/DFNPFuSqSjqZ5VstXfI1sQlSeXmJDE9qAm7THdW/B1tK7qXA7vO7j6zQB6brSuhZaByWHb1fCmNyiThNz71fFyFwCEhBN3jHOG6vKsh4KhnqszlebWKszN82UxZGo3kSH6MukC23KHij9ZL7mBkt22r88SHKHgvZRP6N8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(70206006)(36756003)(508600001)(83380400001)(186003)(6916009)(26005)(8936002)(2906002)(70586007)(1076003)(8676002)(7696005)(86362001)(36860700001)(316002)(82310400003)(4326008)(54906003)(81166007)(336012)(356005)(6666004)(426003)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:43:56.7383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2abf421-9e9f-4769-7c45-08d987456521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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

