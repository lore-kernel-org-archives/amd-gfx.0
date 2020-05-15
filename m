Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C17C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD893206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lokp5CjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD893206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F366ED21;
	Fri, 15 May 2020 18:13:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7396ED1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6ZUM4DFLWMRPZGcuO+zOWLwJqbGQGNBeRZfQi0DMLrFf69p/bWF9c0cfMKFr8xzAMYejoxlsmraEOqPZB4GzcBLnuWog0HF7QX15SFIf/PMW8jyT6dZm+Pci0WxfqmTzcwGieo/qlNQJ0Lm5nZKR8Wiy8MXHfUOhk25kITZY/BK0qVDy8c6Znmk6yPuyM8aO5Nkt5B4yW/Xqa6YaXPXIRBjxJUWTE26QMpDjCEUCFeR9awVfMfI96FhSuLvSFeHFoV+pttl7ZjZTHbrTN62flmyX8eeNKpesvym3GxXlyEMbfbFD5/uWuwrOjdWVkysGKeUJbvxhfM/NF4VZn6LPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY6coKBSjiEu/L4fGQ8odg7J1+u4OgiIdNnezi4r5Rs=;
 b=cLb4CXD475D8bJl2O3Fmtemg+Wkx+fbWFSfrClxotSP6h9VA7rpOVMxIc/94GyegOROuG3Erxd9O8JG7I6vo/UGBrMTrINSwF29/aM2ZymY49wfLyfkYY1TwHMkaizux7IclkJqiywj1nNSHHPPO1W11wVxRIY0ymAyAT0bRmAtF5u+sNpXNmApBOTFD/HUf4BlPHNBUdbWJFwDDTdz6SXmisuRcfYwDNBKJjkBVc/MkhKkYYWwB1ZvxK8x0FqXQWSDREaTo1bIEvFlxRqntZmfEtooWjvSntuK0rEXAldWOjitxrjUGxDElqCiqdbwV8GxbuvrF+8TQi97c81uNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY6coKBSjiEu/L4fGQ8odg7J1+u4OgiIdNnezi4r5Rs=;
 b=Lokp5CjS0d0LrJcYOE2KXgWp8auMNKcURydQIBlsTeafSDaKfsnspa5cHi6FzVQVpAfXgYDu0hlN8KN5ygC3DdTVfYWyu7ak5SRzKu0XFirzmPbB43nyZQ6pxOiBJc2n0yStxHPhW4Fos/CS3ZZSlBuHBfPTnLrslCxnRjo4S+4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:53 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/27] drm/amd/display: DP link layer test 4.2.1.1 fix due to
 specs update
Date: Fri, 15 May 2020 14:13:02 -0400
Message-Id: <20200515181315.1237251-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:51 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bd0fe08-3722-4b5a-19e7-08d7f8fbb951
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB384890616D54D723A1DFC8C598BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXMXgYCnShmRhj8WJcZrBQ1CPFH2u0D6yBdGI67fFaE++J7cLlG+9Q9XrMyEczWmIgHRDL/s7YBuKIHj4NTaesNerzJveFkWy9D6TyyI4AgAGtiN+NrG2bJZuCgC/F0eVjEE9edMsDOSuuOOVQgPWHyru7FBXRE8cpWg78ls9Lt81rfRzG3cwEDUuzV2qr3x72RpfZNFucog9mjpuIqAG/HuvSPZKa5tIy4XjMUjOgfu3fz/d83T05GA5i9XUXbaLSo0g6Sonws+sBypQjN1arulbmWcBnjZBlR19Wq61XZXQVa1fks4OEki23AkkHBZe+4XEm1TawSC89WrHg4wtCxaKYsg/D7nLCpD/pc5+PV9gZOO0zS8pioB3WSRLJMYAwptHxt2lym3hbYzxipZPmNPqd5oF/JQowp++jurZg0X/PGQprFu+MpJHeOiF7RE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(15650500001)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(30864003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pceKfv07VwLPLe5RjGiMjwPrsh21FloQ6ZCma8fNweCeYeCCsWGpgYQo0Ona7crNzRBbpBXQrKcFhEwQ5j1UXLyscoEkkT4Jk7tLL8FYnqpUZnwyiB8cAlY6OWG9uXhr4zX0UjWyDojNKPQUhU71XsA8fEhZgXXAO0r8JDDCB/Ni9ilSh4c6N/gTRA85zKjsiOiRVEaggjsIJnXCtg94R0d3cz5iaW2Ecq0Hyh+pnn/nPqmLloKUKwFVN41dEYvFL506XHg0EATUoSF6M4UyeLzsU2mEK7xTXlcmrkfZ1swJXDRL7uqCrAZgZJX3YBvCBBJcXGjl96jQYKzacRUq87mqgWA3ID/bENgUqM3W4ZwM/xvegAKWsGWQS1KYCfT/EOMraxXMwsSok9eRip88+9xg252ep8/Jklkp5WKlRQvA5uwThmGIMnwazPV5zieYt2NtIfLMgWtIgo0E485a2lvTM9a/Kvd10QmYGIcDdRROuCmbrbI5GI0DiG3ivi0U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd0fe08-3722-4b5a-19e7-08d7f8fbb951
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:52.8054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RAsLDSEtsIq2kIRaHa7DQssrP+uI15dL+YvKSnHnumOURtSnqNldQ5acesRG61ZuTqIT+aqyWWNDprqGk5zzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DP link layer CTS specs updated to change the test parameters in test
4.2.1.1.
Before it requires source to delay 400us on aux no reply.
With the specs updates Errata5, it requires source to delay 3.2ms
(based on LTTPR aux timeout)
This causes our test to fail after updating with the latest test
equipment firmware.

[how]
the change is to allow LTTPR 3.2ms aux timeout delay by default.
And only set to 400us if LTTPR is not present.
Before this piece of logic is interwined with LTTPR support.
Now we will default to 3.2ms aux timeout even if LTTPR support is not
enabled by driver.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c | 13 ++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 59 +++++++++----------
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |  2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  2 +-
 8 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c08de6823db4..e920d046f026 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -691,10 +691,9 @@ static bool detect_dp(struct dc_link *link,
 	if (sink_caps->transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 		sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
 
-		dpcd_set_source_specific_data(link);
-
 		if (!detect_dp_sink_caps(link))
 			return false;
+		dpcd_set_source_specific_data(link);
 
 		if (is_mst_supported(link)) {
 			sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index aefd29a440b5..242ed5976cdb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -648,16 +648,17 @@ bool dc_link_aux_transfer_with_retries(struct ddc_service *ddc,
 }
 
 
-uint32_t dc_link_aux_configure_timeout(struct ddc_service *ddc,
+bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
 		uint32_t timeout)
 {
-	uint32_t prev_timeout = 0;
+	bool result = false;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 
-	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout)
-		prev_timeout =
-				ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
-	return prev_timeout;
+	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
+		ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
+		result = true;
+	}
+	return result;
 }
 
 /*test only function*/
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6db1f16957ac..b578687f2b38 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -245,7 +245,7 @@ static uint8_t dc_dp_initialize_scrambling_data_symbols(
 
 static inline bool is_repeater(struct dc_link *link, uint32_t offset)
 {
-	return (!link->is_lttpr_mode_transparent && offset != 0);
+	return (link->lttpr_non_transparent_mode && offset != 0);
 }
 
 static void dpcd_set_lt_pattern_and_lane_settings(
@@ -1038,7 +1038,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* 3. wait receiver to lock-on*/
 		wait_time_microsec = lt_settings->cr_pattern_time;
 
-		if (!link->is_lttpr_mode_transparent)
+		if (link->lttpr_non_transparent_mode)
 			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 
 		wait_for_training_aux_rd_interval(
@@ -1268,7 +1268,7 @@ static void configure_lttpr_mode(struct dc_link *link)
 		link->dpcd_caps.lttpr_caps.mode = repeater_mode;
 	}
 
-	if (!link->is_lttpr_mode_transparent) {
+	if (link->lttpr_non_transparent_mode) {
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Non Transparent Mode\n", __func__);
 
@@ -1473,7 +1473,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&lt_settings);
 
 	/* Configure lttpr mode */
-	if (!link->is_lttpr_mode_transparent)
+	if (link->lttpr_non_transparent_mode)
 		configure_lttpr_mode(link);
 
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
@@ -1489,7 +1489,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 
 	dp_set_fec_ready(link, fec_enable);
 
-	if (!link->is_lttpr_mode_transparent) {
+	if (link->lttpr_non_transparent_mode) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
@@ -1756,7 +1756,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	 * account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
-	if (!link->is_lttpr_mode_transparent) {
+	if (link->lttpr_non_transparent_mode) {
 		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 
@@ -1914,7 +1914,7 @@ bool dp_verify_link_cap(
 	max_link_cap = get_max_link_cap(link);
 
 	/* Grant extended timeout request */
-	if (!link->is_lttpr_mode_transparent && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
+	if (link->lttpr_non_transparent_mode && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
 		uint8_t grant = link->dpcd_caps.lttpr_caps.max_ext_timeout & 0x80;
 
 		core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
@@ -3255,17 +3255,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	uint32_t read_dpcd_retry_cnt = 3;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
-
-	/* Set default timeout to 3.2ms and read LTTPR capabilities */
-	bool ext_timeout_support = link->dc->caps.extended_aux_timeout_support &&
-			!link->dc->config.disable_extended_timeout_support;
-
-	link->is_lttpr_mode_transparent = true;
-
-	if (ext_timeout_support) {
-		dc_link_aux_configure_timeout(link->ddc,
-					LINK_AUX_DEFAULT_EXTENDED_TIMEOUT_PERIOD);
-	}
+	bool is_lttpr_present = false;
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
@@ -3274,6 +3264,13 @@ static bool retrieve_link_cap(struct dc_link *link)
 	memset(&edp_config_cap, '\0',
 		sizeof(union edp_configuration_cap));
 
+	/* if extended timeout is supported in hardware,
+	 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+	 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+	 */
+	dc_link_aux_try_to_configure_timeout(link->ddc,
+			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
+
 	status = core_link_read_dpcd(link, DP_SET_POWER,
 				&dpcd_power_state, sizeof(dpcd_power_state));
 
@@ -3300,8 +3297,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
-	if (ext_timeout_support) {
-
+	if (link->dc->caps.extended_aux_timeout_support) {
+		/* By reading LTTPR capability, RX assumes that we will enable LTTPR extended aux timeout if LTTPR is present.
+		 * Therefore, only query LTTPR capability when LTTPR extended aux timeout is supported by hardware */
 		status = core_link_read_dpcd(
 				link,
 				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
@@ -3332,20 +3330,21 @@ static bool retrieve_link_cap(struct dc_link *link)
 				lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
-		if (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
+		is_lttpr_present = (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14) {
-			link->is_lttpr_mode_transparent = false;
-		} else {
-			/*No lttpr reset timeout to its default value*/
-			link->is_lttpr_mode_transparent = true;
-			dc_link_aux_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
-		}
-
-		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
+				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
+		if (is_lttpr_present)
+			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 	}
 
+	/* decide lttpr non transparent mode */
+	link->lttpr_non_transparent_mode = is_lttpr_present && link->dc->config.allow_lttpr_non_transparent_mode;
+
+	if (!is_lttpr_present)
+		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
+
 	{
 		union training_aux_rd_interval aux_rd_interval;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 6590f51caefa..6bbe4e775832 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -281,7 +281,7 @@ void dp_set_hw_lane_settings(
 {
 	struct link_encoder *encoder = link->link_enc;
 
-	if (!link->is_lttpr_mode_transparent && !is_immediate_downstream(link, offset))
+	if (link->lttpr_non_transparent_mode && !is_immediate_downstream(link, offset))
 		return;
 
 	/* call Encoder to set lane settings */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a4b30233aee3..391691c70805 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -274,7 +274,7 @@ struct dc_config {
 	bool edp_not_connected;
 	bool force_enum_edp;
 	bool forced_clocks;
-	bool disable_extended_timeout_support; // Used to disable extended timeout and lttpr feature as well
+	bool allow_lttpr_non_transparent_mode;
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
 	bool enable_4to1MPC;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index f63fc25aa6c5..5c60c2f9779a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -101,6 +101,7 @@ struct dc_link {
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
 	bool is_lttpr_mode_transparent;
+	bool lttpr_non_transparent_mode;
 
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
index de2d160114db..b324e13f3f78 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
@@ -105,7 +105,7 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 bool dc_link_aux_transfer_with_retries(struct ddc_service *ddc,
 		struct aux_payload *payload);
 
-uint32_t dc_link_aux_configure_timeout(struct ddc_service *ddc,
+bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
 		uint32_t timeout);
 
 void dal_ddc_service_write_scdc_data(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index e94e5fbf2aa2..b970a32177af 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -28,7 +28,7 @@
 
 #define LINK_TRAINING_ATTEMPTS 4
 #define LINK_TRAINING_RETRY_DELAY 50 /* ms */
-#define LINK_AUX_DEFAULT_EXTENDED_TIMEOUT_PERIOD 3200 /*us*/
+#define LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD 3200 /*us*/
 #define LINK_AUX_DEFAULT_TIMEOUT_PERIOD 552 /*us*/
 
 struct dc_link;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
