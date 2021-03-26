Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A54EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525D161A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525D161A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D833D6F4BA;
	Fri, 26 Mar 2021 22:06:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF7B6F4BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCLla+6eiZYoUkWE1BEywg0u1XgYrTma6nOK+3tOyK26lJZg6GQEm2YRs+YOd0uKgYleVsPgW9SfU5So+jeobxQq4tmoANdUJ0X6/b9bj+u3NfrdTC+/4zwY2pfszRG7r1SdZFjfbzGXoSiT12UWyrEMiHc5FphwdQOiO9evCQBGhAZNpaD5RjeZulan61Q6mLvvxtf4inYr3jFDtjdSkIPkJDiwKYNiVcaIyA0vWwKpbKuGRlxcsh1NXmGX405EqKK2fGCubuEkjkj3qsc8kacesWJz/1Obx3UlbBYw4fpGhglA+votK1Lrz1eqgmnCV0IaVDUdMu/cX98QWQB+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7DBe+GFuZ7+3a+pKWC6tVjVrZ571yFK9Qg8xIE98Pg=;
 b=CFJYmGmKPhp/6eaL8QqLJp2VAs74nMGfGmFUvNeC+SHQ5L/gd4/X0/MtfZZLmqIiueXf4KkXUZsavAaznrdYb8KRbX3JdG3+bFWc0tGiAlvR0x53VN6uRoqy2pjv45Y6ZTwNfX8xDQEdKCnN9kYGy6xFN2k3VvRvdXu/ZKaE9g+JQUCfO0Ev0n6vyXXogAnhoaPIJ/T/GG0SxtMsiuzGVbUA4LyZck4trKMY5/JTf7Ig2uP7tplYZcpnYKGi8zVoBmu0i3HnD2VFbEUCTx8+pdJc/MtTS+b0jb2ckSn8YOaRr0EwxEIeS0Ne7HixwlG3glK+f6bvBAM/uSf9A+Mf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7DBe+GFuZ7+3a+pKWC6tVjVrZ571yFK9Qg8xIE98Pg=;
 b=xfy31OkkCZWZf8r4UQA41JC5B1IPvjY7TGivID7ucq2lbTxGpsnWKcaA4N8vZVoj7ifPoZL0ufjhwwkfUY2qynR1grPjsje+rucamXefjJusOnK6h+Nlx/g5Lvto8QCNZQgWXont9zbRCAVUgau1bMYRCbRb99VAW5c8NZXXvvY=
Received: from DM5PR16CA0043.namprd16.prod.outlook.com (2603:10b6:4:15::29) by
 BN8PR12MB3554.namprd12.prod.outlook.com (2603:10b6:408:65::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Fri, 26 Mar 2021 22:06:05 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::5e) by DM5PR16CA0043.outlook.office365.com
 (2603:10b6:4:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:04 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:03 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/21] drm/amd/display: Enumerate LTTPR modes
Date: Fri, 26 Mar 2021 18:05:24 -0400
Message-ID: <20210326220534.918023-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48586be9-aa93-4f43-5e5a-08d8f0a35a09
X-MS-TrafficTypeDiagnostic: BN8PR12MB3554:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35549DE245C6D4605A3FB38AEB619@BN8PR12MB3554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GjPNyzlv8F2sRBDPIJny7yXO4cY7h7hqxEnVEP+GvlypjjJIr03sdO5MyQ9OKgUX1KCPcLYyuZouea2Dwb0ZQo2NL6hUYYpIpdQXEZqWj+MGc9okqKxKWQwHfC08SMiuLFo+MLX7L7kWy3bOyzeH7AE8nbmd8oS2oCUkvZ0pvECTRBuCYrnH84p63td0RGMpv2LTiOw+b91yovjdcfRdDJFMUEWuYpeHXbJorl2tXG4vM+o0h/0VhM48pTh691tISlDH0lwsb+sZX0EKUzVHlDmgYo6eS4DPIEX62q96JRudnkJnPDec6gbRCkFISsaSIN+6t/NfjgKTBV7j3M+nA/2VNq/EYCEgNm340xzt58nhSAtUNalYiuC/ErQnZqJmou3QJjO/9WjUBaqxoWG26lSzDAWBIYvSu+4tc+1KbbekXt2QXSO0TZNpcB31/B8tk3TDjvZIQGo8xwgcWJVlP+pFDMN3UsvJyAVlXqPCvpY7ml9EHO3UA8+gbjtN2gUzOGL2ksSSp9TPl3KGYBK9oYfBKz+xaYEVaavQOyy/mKXBfJ/brbrO3Vy+UOt3MtEWrHMo2xkdpWMkGsYMKMOmCrOZCQAFb+pWLWMIWCvJWlsLi8j8D2f0t04NQ7gk1dHTjpLeXT3mMsL3iIbZTjzfb7GSx4dKdfCnyUtx/2Sx6RBoVu3pFUGfWlv0cvv9F+/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(70586007)(426003)(86362001)(83380400001)(4326008)(336012)(2616005)(356005)(6666004)(316002)(70206006)(2906002)(478600001)(82740400003)(8676002)(36756003)(54906003)(82310400003)(6916009)(7696005)(186003)(36860700001)(26005)(5660300002)(8936002)(1076003)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:05.2884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48586be9-aa93-4f43-5e5a-08d8f0a35a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3554
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
There are three possible modes for LTTPR:
- Non-LTTPR mode, where AUX timeout is 400 us and no per-hop link
training is done
- LTTPR Transparent mode, where AUX timeout is 3200 us and no per-hop
link training is done
- LTTPR Non-Transparent mode, where AUX timeout is 3200 us and per-hop
link training is done

[HOW]
Use an enum instead of a bool to track LTTPR state; modify comparisons
accordingly.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 33 +++++++++++++------
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  9 ++++-
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 962e88dd8dda..209286357867 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -284,7 +284,7 @@ static uint8_t dc_dp_initialize_scrambling_data_symbols(
 
 static inline bool is_repeater(struct dc_link *link, uint32_t offset)
 {
-	return (link->lttpr_non_transparent_mode && offset != 0);
+	return (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (offset != 0);
 }
 
 static void dpcd_set_lt_pattern_and_lane_settings(
@@ -1072,7 +1072,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* 3. wait receiver to lock-on*/
 		wait_time_microsec = lt_settings->cr_pattern_time;
 
-		if (link->lttpr_non_transparent_mode)
+		if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
 			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 
 		wait_for_training_aux_rd_interval(
@@ -1326,7 +1326,17 @@ static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
 	return 0; // invalid value
 }
 
-static void configure_lttpr_mode(struct dc_link *link)
+static void configure_lttpr_mode_transparent(struct dc_link *link)
+{
+	uint8_t repeater_mode = DP_PHY_REPEATER_MODE_TRANSPARENT;
+
+	core_link_write_dpcd(link,
+			DP_PHY_REPEATER_MODE,
+			(uint8_t *)&repeater_mode,
+			sizeof(repeater_mode));
+}
+
+static void configure_lttpr_mode_non_transparent(struct dc_link *link)
 {
 	/* aux timeout is already set to extended */
 	/* RESET/SET lttpr mode to enable non transparent mode */
@@ -1346,7 +1356,7 @@ static void configure_lttpr_mode(struct dc_link *link)
 		link->dpcd_caps.lttpr_caps.mode = repeater_mode;
 	}
 
-	if (link->lttpr_non_transparent_mode) {
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Non Transparent Mode\n", __func__);
 
@@ -1562,8 +1572,10 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&lt_settings);
 
 	/* Configure lttpr mode */
-	if (link->lttpr_non_transparent_mode)
-		configure_lttpr_mode(link);
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+		configure_lttpr_mode_non_transparent(link);
+	else if (link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+		configure_lttpr_mode_transparent(link);
 
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
@@ -1578,7 +1590,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 
 	dp_set_fec_ready(link, fec_enable);
 
-	if (link->lttpr_non_transparent_mode) {
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
@@ -1899,7 +1911,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	 * account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
-	if (link->lttpr_non_transparent_mode) {
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 
@@ -2057,7 +2069,7 @@ bool dp_verify_link_cap(
 	max_link_cap = get_max_link_cap(link);
 
 	/* Grant extended timeout request */
-	if (link->lttpr_non_transparent_mode && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
+	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (link->dpcd_caps.lttpr_caps.max_ext_timeout > 0)) {
 		uint8_t grant = link->dpcd_caps.lttpr_caps.max_ext_timeout & 0x80;
 
 		core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
@@ -3529,7 +3541,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 	}
 
 	/* decide lttpr non transparent mode */
-	link->lttpr_non_transparent_mode = is_lttpr_present;
+	/*This is a temporary placeholder for LTTPR logic. More comprehensive logic will be added in a future change*/
+	link->lttpr_mode = is_lttpr_present ? LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_NON_LTTPR;
 
 	if (!is_lttpr_present)
 		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 124ce215fca5..22fe19ee842d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -302,7 +302,7 @@ void dp_set_hw_lane_settings(
 {
 	struct link_encoder *encoder = link->link_enc;
 
-	if (link->lttpr_non_transparent_mode && !is_immediate_downstream(link, offset))
+	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && !is_immediate_downstream(link, offset))
 		return;
 
 	/* call Encoder to set lane settings */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index c50ef5a909a6..7b927e634279 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -35,6 +35,13 @@ enum dc_link_fec_state {
 	dc_link_fec_ready,
 	dc_link_fec_enabled
 };
+
+enum lttpr_mode {
+	LTTPR_MODE_NON_LTTPR,
+	LTTPR_MODE_TRANSPARENT,
+	LTTPR_MODE_NON_TRANSPARENT,
+};
+
 struct dc_link_status {
 	bool link_active;
 	struct dpcd_caps *dpcd_caps;
@@ -100,7 +107,7 @@ struct dc_link {
 	bool link_state_valid;
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
-	bool lttpr_non_transparent_mode;
+	enum lttpr_mode lttpr_mode;
 	bool is_internal_display;
 
 	/* TODO: Rename. Flag an endpoint as having a programmable mapping to a
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
