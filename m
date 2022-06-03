Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A2DC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2318B1123DE;
	Fri,  3 Jun 2022 20:12:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CC51123DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEv5XDZJMOUQF6m/QGhUI4qLfk9m3PUTbQa+1cOflbdk+h04t6TMXRtu86NFIRYdcXt5f6t5Ru43f7Iy8D/qX3pANQdeOqEMygQkZPwX5Yv66Yx8zYhdX8ls4Hd3DZ/JJxErIdsvKztAJHrr3j7LHtS6m4PEhma2ItFA+mNO78Unt+FK0T7LZaPRmj2W2uSomOn16BHmjZ/87Kf3vU4ulSotaatbIeqjropFyeS+miEyJ6tGG6KoagCSR8NHCY01OivLNRMchcQfTap9Dfz/1SaKpDUW5BmFs58dxEt7A3Y9glgeEHtwvqqH6ZVLEKO6EBP7+/1gAikbqQtywa3kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NfUqZ31RQZK0+xJ3gWCvFrJY+Z3k9KA8hx3HvwE/Xo=;
 b=Ie8CHsHPDZd+PlXYvMB18ZLOPIZK7gBztl35nzfeJLmhVnbSUUJTbOHr2Wlw/C+RV42doVl8TkuK9L5/zRp9NuyAFt64RKffhJzv75aOHqapSE3t0yy5SDIU/TbyTEynlnjV1u49WuxghKI+AWdDN3cIda6rHgy0kdfzaZMxPHS+yoL6nlYHAA40J266+Rg4ndKAWGEEbVsRdlcPIRjYYARyH6lHGda4cDGf3pR72Ck3SZDxmAfUMd+O0khCZzEm4YYjElnBVNEJqYEdIWZYlBcq+rXhN8Ko2sLhEKBbrWaX1T0XW9o7UhLJtzZH7a+j7pMztPbhWxhZegwwYpak6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NfUqZ31RQZK0+xJ3gWCvFrJY+Z3k9KA8hx3HvwE/Xo=;
 b=uemyAEIXxaBAgTUbZBsSbPJFROE49a5Cade51oFUnByVLAK+muktab7k60uBtJSE3gDfSie6k4KHNkeX2qXuWP+gM3RbsGMN+wHFPBKB6HbaHUnG8pANhbjE5m2lp32zyOI+mLzKXf3mOYx0MHkfvMS9WUeclGpXu2MzQbMigAg=
Received: from DM5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:3:c0::34) by
 DM5PR12MB1305.namprd12.prod.outlook.com (2603:10b6:3:75::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 20:12:33 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::7e) by DM5PR16CA0024.outlook.office365.com
 (2603:10b6:3:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:31 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Blank eDP on enable drv if odm enabled
Date: Fri, 3 Jun 2022 16:11:35 -0400
Message-ID: <20220603201147.121817-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd31c09a-d2ef-48de-94b9-08da459d6508
X-MS-TrafficTypeDiagnostic: DM5PR12MB1305:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1305FBAF95EA15CA35005636F4A19@DM5PR12MB1305.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcBcOf1Rvdhi4M7ZTwh3fxbpeE6cRYD+9RsidvlsB93wb3MIACUJdZq2PBbSVcT3Lk3+bCdyVdSwYuCvsaY7t8gTXFdaD3ia5lbuuDLwxVbJbILYi5DGdSUVEDWwTTwHgC9HVYAG8ObvH3YETGCGm1UmYK/LZSrkurNn5rZRfNPLcv7QBAIPKAP6YrpTUDA2N0GuR9F3kEhjJFxEXJDyH3xZjblIIM/3C3CNHzDYw+BgrNlLaEBvX+BU/Qh43Pb62Uh6CjciLA5nPXBx8pyGbzWGqKhPkpqP8dotvhIsa9JH5khyD/2hdz2hKCtt8hlOhSO20W67NyqoFE7OGFNr/IDJlxxaiTSO+U5YZN3zAT8V+/qHqFkHT6J2L7XL8Q1SMVQVcqtnLZb3jjK4MI1U3R1q6daMWWaGaJEqCqUZToyweW5fX3FoqGODuIhAxw1IhF9B/uNjlYYQ4nCC5U3iKDUEHSmAiQt3JXMxNmdtUEj5nkRSj6sPK4tJo1g/a+qn6+ZJ5bdvGat+lGmS0PYZJNTqnxyZo4HRliBqxc+wC3667OVsdv9gkFbRSwW0/S3GyClhWRhVQST0dGlaMkiBA+gm+K68s5GL0rHLV2WP+gujRONU3X4cUu7XrmkicPCK2XSMMpGgr9fflJoHizHG3yJDu3vYHgIEMVUgD5KnSTgPAbJvmCVqEhGPCDqtKfpizceh6fsdxScUKw9M2ErDTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(47076005)(16526019)(336012)(186003)(426003)(44832011)(36756003)(508600001)(5660300002)(82310400005)(2906002)(8936002)(83380400001)(2616005)(26005)(356005)(40460700003)(316002)(1076003)(86362001)(54906003)(6916009)(81166007)(36860700001)(4326008)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:33.2496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd31c09a-d2ef-48de-94b9-08da459d6508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1305
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
For panels with pixel clock > 1200MHz that require ODM
in pre-OS, when driver is disabled in OS, odm is enabled.
Upon driver enablement, corruption is seen if
odm was originally enabled. DP_PIXEL_COMBINE and
pixelclk must be programmed prior to programming the
optc-odm registers. However, eDP displays aren't blanked
prior to initializing odm in this case.

[How]
Upon driver enablement, check whether odm is enabled,
if so, blank eDP prior to programming optc-odm
registers.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 20 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 22 +++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 55a8f58ee239..818a605dcab1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2126,6 +2126,26 @@ void dc_link_blank_all_dp_displays(struct dc *dc)
 
 }
 
+void dc_link_blank_all_edp_displays(struct dc *dc)
+{
+	unsigned int i;
+	uint8_t dpcd_power_state = '\0';
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+
+	for (i = 0; i < dc->link_count; i++) {
+		if ((dc->links[i]->connector_signal != SIGNAL_TYPE_EDP) ||
+			(!dc->links[i]->edp_sink_present))
+			continue;
+
+		/* if any of the displays are lit up turn them off */
+		status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+							&dpcd_power_state, sizeof(dpcd_power_state));
+
+		if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0)
+			dc_link_blank_dp_stream(dc->links[i], true);
+	}
+}
+
 void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init)
 {
 	unsigned int j;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 11b02a98cf0f..d08550337a09 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -202,6 +202,7 @@ struct dc_caps {
 	bool vbios_lttpr_aware;
 	bool vbios_lttpr_enable;
 	uint32_t max_otg_num;
+	bool seamless_odm;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a3c37ee3f849..592b1d473cb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -321,6 +321,7 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
 
 void dc_link_blank_all_dp_displays(struct dc *dc);
+void dc_link_blank_all_edp_displays(struct dc *dc);
 
 void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 531dd2c65007..55f2e30b8e5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -213,6 +213,28 @@ void dcn31_init_hw(struct dc *dc)
 	 * everything down.
 	 */
 	if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
+
+		// we want to turn off edp displays if odm is enabled and no seamless boot
+		if (!dc->caps.seamless_odm) {
+			for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+				struct timing_generator *tg = dc->res_pool->timing_generators[i];
+				uint32_t num_opps, opp_id_src0, opp_id_src1;
+
+				num_opps = 1;
+				if (tg) {
+					if (tg->funcs->is_tg_enabled(tg) && tg->funcs->get_optc_source) {
+						tg->funcs->get_optc_source(tg, &num_opps,
+								&opp_id_src0, &opp_id_src1);
+					}
+				}
+
+				if (num_opps > 1) {
+					dc_link_blank_all_edp_displays(dc);
+					break;
+				}
+			}
+		}
+
 		hws->funcs.init_pipes(dc, dc->current_state);
 		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
-- 
2.36.1

