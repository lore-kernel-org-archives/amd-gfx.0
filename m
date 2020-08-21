Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEF7C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501A32067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yo630e62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501A32067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C01F6EC23;
	Fri, 21 Aug 2020 22:58:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FE76EC23
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdOfhWimZKZ0MBD+lDz5ADeQVQBmKVPvpop+nlgnByu/6rpL5RufvN+wEZOhmAiDvehz9Np6ypWrX60KHhqPnIoS0gG7jUFWiodaDnTgmEOKFgTQhOpFL/qAaUpj5FaVRe9VuQ9W2/UByCc6evslT8Ma5fxLRSUn//81h+imJ3MZgVh1XKPIgRXxMQDetSg0fFLw1MlOmTnRU90WKRYSoIeTMfdP6dtvWSU7H9kObQ6RbSA+KI8F81MRTwrA+carfb7dT8GWOV68VYvW3tLxtwBIToJl2V5bUotb53nHAIC/yoG2L7+Ylnlzjqm5gsouJtXB5fRo62xtJG45bxgMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkfL7bXeb7CK+tWw5RTn9D+PLOLPbcLbMNCUX2RzkY=;
 b=Uwzp9BtAXDoSslNqgc46Mb1DamL3Jq8EqdrdAX5IaDE1Zrd9YHrGtm+/m24JFweCSx1N9z8u584kkfY0YBegm3H41tzGliypwoUvMUd1JiTwLDZWAkPZeo2h9Zl9hiz0dRACKDQ5/7rYYzaavqGr5xbYKSIwqdNIEXAmulkWiyrpjJ5km6Qi0Cy+XRk5OfVsDyEmuV80LWEAJNQPXfBfdhUJgFeccEVrTdvjXwmiGZng85lQNfb+Tl6KIYbQTNyFaafM821iHit2O1JtcvmxfH6yy+99DLIfGdfYsJcal68I84tlvOZk+xbVJPTPspYE/x6gAZmA4VIw3kuPQV/SAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkfL7bXeb7CK+tWw5RTn9D+PLOLPbcLbMNCUX2RzkY=;
 b=yo630e62LJkld6NXPOkVKkSHVoYpD0TbmixMEoQiVuB1GiQ7t8OJIcnUulCnmi4suncNkJMbt7+XncsZ1eMEajpL1wLHfvJCJxwyeKEBx23T6mrRjFnDuuQTHYqjEqL+22p3fhE8Wp5/f+6IakvqsASL1z5xgvAcZ4fwRURjTVE=
Received: from BN6PR13CA0069.namprd13.prod.outlook.com (2603:10b6:404:11::31)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:58:13 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::ca) by BN6PR13CA0069.outlook.office365.com
 (2603:10b6:404:11::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 21 Aug 2020 22:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:58:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:12 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:12 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:58:06 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amd/display: Send DISPLAY_OFF after power down on boot
Date: Fri, 21 Aug 2020 18:57:05 -0400
Message-ID: <20200821225709.136571-6-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb1e7b6-6d3f-4c03-46de-08d84625aeb2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4336:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4336D2F16C780C77E8FF7CC3E55B0@MN2PR12MB4336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueQqTyF2Ul+LlYKdOPsv7qNA1rOG9lrZSK/oHdrywStsYbJAvSMBhbrxCDhDDTed+PIHiSZYClpoe1pA6McXkIwFQYJkDoC8dlHSW7qEB2eC8BLKOEFGyBni6BuLr3x+g9LcSaMRypvW0NED3Mc44yWxxTbDtj/fxyDe1ZVJgZM1yJoB6NLlks7knFuap6/EzHojeskcxUP6kkaaYmsLhMeqvoVeOB4/K4/WR45NQuU+WOEdtRftc3AJSJj3rdgX08rxNWjrOKVkYsMPyDGqH7l/ELss5cuWZa/kSjzMQX7QO7RVzywPCYKQgq+GICOeohNWrTEXlFfYiNl/1uXNKWdhK/0k9a1Eqq8Wwjd3n3qn9yQheOptInazmwt3IKVW5xZRg+g1c9a16kH5ZVEbyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(82740400003)(8936002)(44832011)(86362001)(6916009)(54906003)(336012)(478600001)(8676002)(47076004)(83380400001)(36756003)(4326008)(5660300002)(81166007)(82310400002)(426003)(1076003)(186003)(356005)(2616005)(316002)(70586007)(2906002)(26005)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:58:13.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb1e7b6-6d3f-4c03-46de-08d84625aeb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
update_clocks might not be called on headless adapters. This means
DISPLAY_OFF may not be sent in headless cases.

[HOW]
If hardware is powered down on boot because it is headless (mode set
does not happen on that adapter) also send DISPLAY_OFF notification.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 10 ++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 53 +++++++++++--------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 +
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index c664404a75d4..543afa34d87a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -94,6 +94,15 @@ int rn_get_active_display_cnt_wa(
 	return display_count;
 }
 
+void rn_set_low_power_state(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
+	/* update power state */
+	clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
+}
+
 void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -516,6 +525,7 @@ static struct clk_mgr_funcs dcn21_funcs = {
 	.init_clocks = rn_init_clocks,
 	.enable_pme_wa = rn_enable_pme_wa,
 	.are_clock_states_equal = rn_are_clock_states_equal,
+	.set_low_power_state = rn_set_low_power_state,
 	.notify_wm_ranges = rn_notify_wm_ranges,
 	.notify_link_rate_change = rn_notify_link_rate_change,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 95e9d05f884b..8ca94f506195 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1450,33 +1450,42 @@ void dcn10_init_hw(struct dc *dc)
 void dcn10_power_down_on_boot(struct dc *dc)
 {
 	int i = 0;
+	struct dc_link *edp_link;
 
-	if (dc->config.power_down_display_on_boot) {
-		struct dc_link *edp_link = get_edp_link(dc);
-
-		if (edp_link &&
-				edp_link->link_enc->funcs->is_dig_enabled &&
-				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
-				dc->hwseq->funcs.edp_backlight_control &&
-				dc->hwss.power_down &&
-				dc->hwss.edp_power_control) {
-			dc->hwseq->funcs.edp_backlight_control(edp_link, false);
-			dc->hwss.power_down(dc);
-			dc->hwss.edp_power_control(edp_link, false);
-		} else {
-			for (i = 0; i < dc->link_count; i++) {
-				struct dc_link *link = dc->links[i];
-
-				if (link->link_enc->funcs->is_dig_enabled &&
-						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
-					break;
-				}
+	if (!dc->config.power_down_display_on_boot)
+		return;
+
+	edp_link = get_edp_link(dc);
+	if (edp_link &&
+			edp_link->link_enc->funcs->is_dig_enabled &&
+			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+			dc->hwseq->funcs.edp_backlight_control &&
+			dc->hwss.power_down &&
+			dc->hwss.edp_power_control) {
+		dc->hwseq->funcs.edp_backlight_control(edp_link, false);
+		dc->hwss.power_down(dc);
+		dc->hwss.edp_power_control(edp_link, false);
+	} else {
+		for (i = 0; i < dc->link_count; i++) {
+			struct dc_link *link = dc->links[i];
 
+			if (link->link_enc->funcs->is_dig_enabled &&
+					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
+					dc->hwss.power_down) {
+				dc->hwss.power_down(dc);
+				break;
 			}
+
 		}
 	}
+
+	/*
+	 * Call update_clocks with empty context
+	 * to send DISPLAY_OFF
+	 * Otherwise DISPLAY_OFF may not be asserted
+	 */
+	if (dc->clk_mgr->funcs->set_low_power_state)
+		dc->clk_mgr->funcs->set_low_power_state(dc->clk_mgr);
 }
 
 void dcn10_reset_hw_ctx_wrap(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 5994d2a33c40..947d6106f341 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -230,6 +230,8 @@ struct clk_mgr_funcs {
 
 	int (*get_dp_ref_clk_frequency)(struct clk_mgr *clk_mgr);
 
+	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
+
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
 	void (*enable_pme_wa) (struct clk_mgr *clk_mgr);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
