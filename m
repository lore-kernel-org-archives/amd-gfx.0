Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD16C43460
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B566561400
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B566561400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D0D6EE41;
	Fri,  7 May 2021 14:59:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9233A6EE41
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJp6yulA1dNg12AnGdSmn6p7Su8gpXugkz0ACFefZv54c/S6BcQAwK6Bj9jC8JSsBPJsaze9NxZ9PNOlRytSjJwjhioRaUNtJSizq8tMx47xWhPj7dhoWLECEIAMvIkSoVTsmwVEL9jiJrk3EMpf7MhIzez1wVjvRrox0Lltjl2HMZ+HW78RjNh4yTRbxPJIOiX5nzUbK1Ouc+Z1BDNOLcEF1KVrIYTDvZDg709L+IR3TZwTbhd+Yel9HxOKLvbmnRFyXpEwCPh6RAIkoyGpfQq938fmkKr7dZHKDCnEKKNLlx8rxCJ8lf/3RHouClX7P8plT3iqCvSocqKjEKA0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMqfPI4T5DK3lMjVaXcpffGDhn0DLkwohJF0d2dkvs0=;
 b=SVBNCAWLH79LsBPubiLnOXwIFkNUN2TwotZpS2yYtMmASaZPGdd1U+qME8TFwWGo7bdNfbdEE/Qn3MluylS27+gFySrri9QOWK81lNO7YrgdofcNre5hvm69s3b+oJWdwWKDwGpWkwkjSxCwZYsJ++qVEUfvJcZ7gFrkrjoUfVM/G/l1gxnq/osgsuVZWRxk6mfwMnX29IT+xkh5JJYjlEGPs+36DRvkeDU69JJFVvYKAAp2pI8zzKFLcr0hd5Qx7EBSoJwTfnR9RTlv9p8t/v+CGFR02+dF5qmlrrk2qEDueaOiDOdvuCb/KznCDFDDLXDawE9ldQI2unsYe1Dadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMqfPI4T5DK3lMjVaXcpffGDhn0DLkwohJF0d2dkvs0=;
 b=gPM5yLQgh2AIhKoLEBEDkjXOCgTDa2EKaGWU8l9oRG2CgYalQVmnxGsxHdX4JgsQQ+1M9ig6MCQw1NdO1CIu5haNvR4conyck+iwWf4wYIWFIrrMwdCXkXr6fAJuNs/BFIboZL5guYfzBuokSTe36MVyc21GjtsXYoVVfWIOew4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:59:08 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:08 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/14] drm/amd/display: Update setting of DP training
 parameters.
Date: Fri,  7 May 2021 22:58:10 +0800
Message-Id: <20210507145822.248029-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ecbde1-d07d-4831-854d-08d91168aa45
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17865E2978F932E031FDD8F7FF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQl9HEr5POyKWPfLJcjMqU4o/0JrKOGC8ENzoZtmZErxdMmsa5WjutNVqdlfdwjx8YV/uiuBqQzBe1eBG/Apgma5eWKyzbX/qSRRV7MP+Nic6n3tuTzog6qMgzw9248fFjz4dlyLlaHseoOxNbBb3svSuIgVoGzbzIC1703b7l9woyXQFJ0RnhtolNmCApBKd/R4DSRtNXEtQrS5QyEFr9QMI0nuwCBX+dmT34zgZxDRnZ0PhYxugVHAnmY0JMUU73LGhjJDxJitj1LOihMnd7TCSRk9/6aobpnjrYSUFHrZOYelnDZ5AiaNH4MNd1shbVdYq3n+7ayLnby8eVjilRFtVz0xcXr2Qui6CNJrI/BWhIMhX4GE3ML6boHdxhc3T7SmOiGLLfXEUFg8qt6OkKutNr5ObIlXz9GFgy3E630S5CiBY06o7V2MWu3umvST1tkXXtjHaLUx46D4paL3Kn2rTlfaVCc8j7h0T33VdGZ3PvO3yhuAwuf3LhkD+D2W3fBoOUwB4az2u+ITKlCtYp8fwv8CZgWmpryl+CNSU/aewcYAY0sZreUwh1IHzcBLf5SpI/hHAzjupuxAl+N5zAcZ1Mi2c6/wsDRsHl/j3pWNY2CU7I5CUBM3lVguI4w1FM+MT5lAe74/nI2rMRCIr3RREJFtWdAv/3p7l6C+cN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(15650500001)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UpbrtoGZP18UDON53nr50tVIGRsIlZ9SSUBM8REayzoxXJEiod0lUUloXfVZ?=
 =?us-ascii?Q?VjPF0c2/ATCN2H8QC9Gj0xf+2OwbnBQPgKZ4DBX/cm5DLO5R92UhX0KdO7Zu?=
 =?us-ascii?Q?C+jCb1C3y3KyTmLpJbAvebhQLNFtoWBmK1qRtDOYlG7YWjLws7Nc2bv9b3AA?=
 =?us-ascii?Q?gY0W0vQ9MVYDkFt6a3OW7J9ObWLdMODOS0r/soEh//BpEEaQXgBfkQZdkyC9?=
 =?us-ascii?Q?itoxCY9dwN0L/KyCOHyukdqgGK15yR2bL5QzIuMs2Qpt50iLm0SucNleqniA?=
 =?us-ascii?Q?Lqwk63czr09ANSzNwN++D1Rtrtp2iMitjik438AiRrrj0aRmXSl/t2EfaZzp?=
 =?us-ascii?Q?vCPoyuLtDgCq1/zteAgUAfLZw/M+HmqMtOp6nSNNqJIY8NtHn81c6P1wBnka?=
 =?us-ascii?Q?dXt8kpIUNX8z8/po/mhLQ5Ex8S+tZvBX0KictH1I8pG9TsGGD4+LG3ZsMSm7?=
 =?us-ascii?Q?FV2exGwTDqqb14C/OtHDNsqO+bsBf7BT71UHxLjDQgOpsL39LG+EF+kbPBqC?=
 =?us-ascii?Q?UQsw1JmtiXv31nJfn/5zPDSHsqwzKoE4FjldhMrtw1psT2a0wiIQumwWi/pC?=
 =?us-ascii?Q?RJJQnMZj3peUoY1Hg3Qo9nMdyidtomzn6/f0y0IYviCD34TVDDSczw6XADv3?=
 =?us-ascii?Q?nfTFos3Z+gLpu69CwL1yZbTjGoHnRuct5AWfzBwkH/i04Y+BqfeiIn33GUNU?=
 =?us-ascii?Q?Ei5OAjarZsOmfqB2aSwnPXJvafs/UojLilXGJgSXcu+vLJCt6oPcmy5bb/eX?=
 =?us-ascii?Q?BylD3A4AVoJSB9wn1bCBl6gFn3fEuqCNAvw0T+6ey/QMIiAet5cpTAGgK3SJ?=
 =?us-ascii?Q?ISXDRSg2eMjfrH+7emwKU1GSvHpZPUXjLNVfi8/McMFgWdY+KXEqUu/OIlVw?=
 =?us-ascii?Q?yDEoZ9UYRViR6UwTgAFo/FcrIvxjIVWFmy2p+/r88Pw8wyfWc6a5dSwwRhhk?=
 =?us-ascii?Q?y2hpAmi4Qr7X3x7qhA03xs/1TPMF/qRcHnWpjzJe9aimd8WeDNLdomUPNXqH?=
 =?us-ascii?Q?P63dDsKDchxPD7JWMGuzMUEMF6RmWk1C4DTWDkleSfFZL53wePmOmTtbpn/L?=
 =?us-ascii?Q?BY3M5i5SAUFhPX8Ef4KkYVvuOKHqOPkpbNHiFuspOqTGJg3823g5qRl20ult?=
 =?us-ascii?Q?h3Vq6ryONlbe9rsXpUF5Do4hJQ6roSDu+JXjKSELOnRIXzsYL0BG/IA+IHeL?=
 =?us-ascii?Q?bM2A4dbxlWnaXWZxHLarWzjwdMWjmxAEWHIjOiCkzfuLc/+zvY6OA1tDsIKe?=
 =?us-ascii?Q?cstGbxM5eNmCrx12mYci3dWVLzsEJHl7vJFE5dPilx7YyEHCMMzGwmFPddVC?=
 =?us-ascii?Q?HO0HdYevq7DryWDi4gAH/tQ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ecbde1-d07d-4831-854d-08d91168aa45
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:08.2098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdyDcPmGHCKEVIE7QVUY8/Kyae1X9ORtKYPASDdtCfky3Y7vqWhr0sv1wBvXYnWbIVpDu6RjbGngqMzetIus0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Some links are dynamically assigned link encoders on stream enablement.

[How]
Update DisplayPort training parameter determination stage that assumes
link encoder statically assigned to link.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 +++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  4 ++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 18 ++++++++++++++-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 22 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  7 +++++-
 5 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a2e7747ee387..d040d235c2db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -48,6 +48,7 @@
 #include "dce/dmub_psr.h"
 #include "dmub/dmub_srv.h"
 #include "inc/hw/panel_cntl.h"
+#include "inc/link_enc_cfg.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -3737,8 +3738,22 @@ void dc_link_overwrite_extended_receiver_cap(
 
 bool dc_link_is_fec_supported(const struct dc_link *link)
 {
+	struct link_encoder *link_enc = NULL;
+
+	/* Links supporting dynamically assigned link encoder will be assigned next
+	 * available encoder if one not already assigned.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign) {
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		if (link_enc == NULL)
+			link_enc = link_enc_cfg_get_next_avail_link_enc(link->dc, link->dc->current_state);
+	} else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
+
 	return (dc_is_dp_signal(link->connector_signal) &&
-			link->link_enc->features.fec_supported &&
+			link_enc->features.fec_supported &&
 			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
 			!IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 3bdd54e6248a..ba6b56f20269 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -685,6 +685,10 @@ bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
 	bool result = false;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 
+	/* Do not try to access nonexistent DDC pin. */
+	if (ddc->link->ep_type != DISPLAY_ENDPOINT_PHY)
+		return true;
+
 	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
 		ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
 		result = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a22484e90e75..8565281e6179 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -14,6 +14,7 @@
 #include "dpcd_defs.h"
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "inc/link_enc_cfg.h"
 
 /*Travis*/
 static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
@@ -132,10 +133,22 @@ static enum dc_dp_training_pattern decide_cr_training_pattern(
 static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
 		const struct dc_link_settings *link_settings)
 {
+	struct link_encoder *link_enc;
 	enum dc_dp_training_pattern highest_tp = DP_TRAINING_PATTERN_SEQUENCE_2;
-	struct encoder_feature_support *features = &link->link_enc->features;
+	struct encoder_feature_support *features;
 	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
 
+	/* Access link encoder capability based on whether it is statically
+	 * or dynamically assigned to a link.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign)
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+	else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
+	features = &link_enc->features;
+
 	if (features->flags.bits.IS_TPS3_CAPABLE)
 		highest_tp = DP_TRAINING_PATTERN_SEQUENCE_3;
 
@@ -1366,6 +1379,7 @@ static void configure_lttpr_mode_non_transparent(struct dc_link *link)
 		}
 
 		repeater_cnt = convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
 		for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
 			aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
 						((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
@@ -3603,7 +3617,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 				lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 		is_lttpr_present = (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
+				link->dpcd_caps.lttpr_caps.phy_repeater_cnt < 0xff &&
 				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
 				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 1361b87d86d7..1a89d565c92e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -112,8 +112,8 @@ static void update_link_enc_assignment(
 
 /* Return first available DIG link encoder. */
 static enum engine_id find_first_avail_link_enc(
-		struct dc_context *ctx,
-		struct dc_state *state)
+		const struct dc_context *ctx,
+		const struct dc_state *state)
 {
 	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
 	int i;
@@ -270,7 +270,7 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 
 struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 		struct dc_state *state,
-		struct dc_link *link)
+		const struct dc_link *link)
 {
 	struct link_encoder *link_enc = NULL;
 	struct display_endpoint_id ep_id;
@@ -296,8 +296,20 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 
 	if (stream_idx != -1)
 		link_enc = state->streams[stream_idx]->link_enc;
-	else
-		dm_output_to_console("%s: No link encoder used by link(%d).\n", __func__, link->link_index);
+
+	return link_enc;
+}
+
+struct link_encoder *link_enc_cfg_get_next_avail_link_enc(
+	const struct dc *dc,
+	const struct dc_state *state)
+{
+	struct link_encoder *link_enc = NULL;
+	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
+
+	eng_id = find_first_avail_link_enc(dc->ctx, state);
+	if (eng_id != ENGINE_ID_UNKNOWN)
+		link_enc = dc->res_pool->link_encoders[eng_id - ENGINE_ID_DIGA];
 
 	return link_enc;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index 7d36e55f3097..883dd8733ea4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -81,6 +81,11 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 /* Return DIG link encoder used by link. NULL if unused. */
 struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 		struct dc_state *state,
-		struct dc_link *link);
+		const struct dc_link *link);
+
+/* Return next available DIG link encoder. NULL if none available. */
+struct link_encoder *link_enc_cfg_get_next_avail_link_enc(
+	const struct dc *dc,
+	const struct dc_state *state);
 
 #endif /* DC_INC_LINK_ENC_CFG_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
