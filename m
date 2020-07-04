Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48AC433DF
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58002075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iUfzqZj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58002075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1F76EBE7;
	Sat,  4 Jul 2020 01:15:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060A76E3D6
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbAZNwC0ySYZPODBrZCOr4HE+ucRddMI0Remu79UiarwTE4yxWgoT8OdYefUPt4r8XougsI4C5s/T7Gdlogv8/goH+gQV6jTOZ/DDRTcwiUtUZap8vzTf9SzjQ4ujn6PKUDrCVid1MrJSQdK+c0UTqEDNRIh6GxAIlHEzLdfgihv7j8Ut1hrXbUmX55R1xbnLUjj3u5BxuzXmOVabe8TwTm1FOBvXfEQ/MbVJgHmWEyUSvTpt2BIRMDqqo1D5oIX0ajfFQogGppVNpfJq418E9LlQh7H3G4fnVMDbfTa4wy9mJ31ahkIwECfPn7s7BO6NLKLlq6eQ4Uib4SHP8Fl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZHYp5hNAdB7NbfH9JICTAlkp2ZgNMEmWqnNrDOO+zs=;
 b=ZcBs+OZ3DmqybP6azyDRgTXMR5iKS5iybjBk4gonK6AluJZmPvXJHEcL1nBC2TLCaKePhAcZ6C51veHtOyDqPXSbFBCbIMWusbs0iSgnwk3bJ8+c/TUE3PDEthMWhsNrjBbwkQuDuXKkobWyKWBcoIGlSuKE7FKwd0gkPyfJ7uoivene4tQOCNCvLRpQek9wjbhTamcuJOpwtG6CmjWfcDwQ3QwLRy+C9NFb/gBO3TX8gHWYqXCgCCed0oZ2AWKRLW/eeLTKpbmGrmtc3LOGQHxP86de45ZoqsFeMq25m79rrr3HwM0L2ppl+19uOEjCXzojSkyjoSE23snSmYH+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZHYp5hNAdB7NbfH9JICTAlkp2ZgNMEmWqnNrDOO+zs=;
 b=iUfzqZj3Pbgn3rJbrJq+TpbNRSarcJ/yZc/Gwq4GUZf+C8QMtyTvuGS5i/0bms9VIB2TMSBJMrtXUd1UHdeJh1jV9F6O28tL1BhYQKepnlgjf90FUJNFdpcRhjcDKzY/kXAsf0J6WboKNFAT7X1Kas/tJY6pGtjyB9Bds1TiGPM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:28 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:28 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amd/display: Request PHYCLK adjustment on PHY
 enable/disable
Date: Fri,  3 Jul 2020 21:14:56 -0400
Message-Id: <20200704011457.2368241-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be648831-7f3e-4996-c91f-08d81fb7bce4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37684B213E7D0DBE9D50F5C0986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0paOQd7gOsGfPspwWPdsViRYIwkWJuKTq0N40rCWX+YGJbVFj5Mu/Ea28ujhXBD/4lWQJnpI9xHe2sGRpyxKYD0B0ynx2S5Z5+vpsAePGklokeBbyvEf0EgGu39etCTTUG3skWIzf1DifpvCwzrueoMMUlc+CGXpgZ0l8zX+3fFnqyN6LPPQOC6TAEODFPkf3lUVOYK0n9ZhXa0nXM2OX2+VpiIIYT8bg/kjPtMTtdx2uE2oAixPuY5uayRCVzAtpP0XQVLYlgxAn3yCAjIv3h9X3tUW9Tzai1W0lpNPThejL3F8oJYHKE6LGUB+pfLcuKnQ+E39KpLRumLSnrisvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(30864003)(2906002)(1076003)(36756003)(4326008)(54906003)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zBrtJJL24XbvU0Sn1XLdtN9nZ6MK9oZtJkXRPihtcf9p34hLMH4pY77iuBVhZ2lIYqtmvYTv3I4boVXZdSnAtEqDCDOICR4L8rLzScr89ky6KBsicqdAzoFnA2jE6bNvZzcYUJD78KHxP85YwRTizjAsmNyH5K2Bx/433wngPhrPbb+nKQC/cj/aR9VOrClv9BuQGp8f9YglQBTR87FbADaj30VNJTUFV7jGhZXIncdIbjmIBKHtjllGKAcFGanlqaPmrVzjpe+BBeSd7ZtdZRz5ehFxEji893fhWuu80q4vBdMCVS5yfzDfHxoMA2g5QoICEmTRw8TOsplzEFqRkfGzjxUhOgtj9A6/5BTEAdX4lKIWagmUtUFdH+OYN4x2uUMmm7ewJ95mmQ0yMW1OW3XrFNqM+/9PpHlDJjhJ4iGYAF8JXsPP9BPup7Du4UJfj8t3N4J+GyaItOrAsLlGXSfW9Snc4cr0ERDMeEOiaZosaY/qcn2qWLKRctSQmJzE7vfTxXvEJuLauTx/5M9WWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be648831-7f3e-4996-c91f-08d81fb7bce4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:28.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiU4o0rZ5UdoQ1R5T5f1mAL0z0ExCxU1rPAl/Yr8QCH0xH0Aeswg2ycknVL8BgdfNTFm6dTSo0WbKNkxUNzYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, eryk.brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 aurabindo.pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Currently we don't explicitly send a request for a minimum PHYCLK, and
we hope that the dependencies other clocks have will raise PHYCLK when
needed.

[How]
- new clk_mgr function to keep track of PHYCLK requirements
- request maximum requirement across all links
- remove PHYCLK from clock state comparator, as it doesn't come from DML

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 35 ++++++++++++++-----
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 27 ++++++++++----
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 32 ++++++++++++-----
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 11 ++++--
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  3 ++
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 ++
 6 files changed, 85 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index c63ec960e116..f2114bc910bf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -184,13 +184,6 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 			pp_smu->set_display_count(&pp_smu->pp_smu, display_count);
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz)) {
-		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
-		if (pp_smu && pp_smu->set_voltage_by_freq)
-			pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_PHYCLK, clk_mgr_base->clks.phyclk_khz / 1000);
-	}
-
-
 	if (dc->debug.force_min_dcfclk_mhz > 0)
 		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
 				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
@@ -417,8 +410,6 @@ static bool dcn2_are_clock_states_equal(struct dc_clocks *a,
 		return false;
 	else if (a->dcfclk_deep_sleep_khz != b->dcfclk_deep_sleep_khz)
 		return false;
-	else if (a->phyclk_khz != b->phyclk_khz)
-		return false;
 	else if (a->dramclk_khz != b->dramclk_khz)
 		return false;
 	else if (a->p_state_change_support != b->p_state_change_support)
@@ -427,6 +418,31 @@ static bool dcn2_are_clock_states_equal(struct dc_clocks *a,
 	return true;
 }
 
+/* Notify clk_mgr of a change in link rate, update phyclk frequency if necessary */
+static void dcn2_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc_link *link)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	unsigned int i, max_phyclk_req = 0;
+	struct pp_smu_funcs_nv *pp_smu = NULL;
+
+	if (!clk_mgr->pp_smu || !clk_mgr->pp_smu->nv_funcs.set_voltage_by_freq)
+		return;
+
+	pp_smu = &clk_mgr->pp_smu->nv_funcs;
+
+	clk_mgr->cur_phyclk_req_table[link->link_index] = link->cur_link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
+
+	for (i = 0; i < MAX_PIPES * 2; i++) {
+		if (clk_mgr->cur_phyclk_req_table[i] > max_phyclk_req)
+			max_phyclk_req = clk_mgr->cur_phyclk_req_table[i];
+	}
+
+	if (max_phyclk_req != clk_mgr_base->clks.phyclk_khz) {
+		clk_mgr_base->clks.phyclk_khz = max_phyclk_req;
+		pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_PHYCLK, clk_mgr_base->clks.phyclk_khz / 1000);
+	}
+}
+
 static struct clk_mgr_funcs dcn2_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.update_clocks = dcn2_update_clocks,
@@ -434,6 +450,7 @@ static struct clk_mgr_funcs dcn2_funcs = {
 	.enable_pme_wa = dcn2_enable_pme_wa,
 	.get_clock = dcn2_get_clock,
 	.are_clock_states_equal = dcn2_are_clock_states_equal,
+	.notify_link_rate_change = dcn2_notify_link_rate_change,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 39788a7bd003..9b4807f52381 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -136,11 +136,6 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz)) {
-		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
-		rn_vbios_smu_set_phyclk(clk_mgr, clk_mgr_base->clks.phyclk_khz);
-	}
-
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
 		rn_vbios_smu_set_hard_min_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_khz);
@@ -496,13 +491,33 @@ static bool rn_are_clock_states_equal(struct dc_clocks *a,
 }
 
 
+/* Notify clk_mgr of a change in link rate, update phyclk frequency if necessary */
+static void rn_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc_link *link)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	unsigned int i, max_phyclk_req = 0;
+
+	clk_mgr->cur_phyclk_req_table[link->link_index] = link->cur_link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
+
+	for (i = 0; i < MAX_PIPES * 2; i++) {
+		if (clk_mgr->cur_phyclk_req_table[i] > max_phyclk_req)
+			max_phyclk_req = clk_mgr->cur_phyclk_req_table[i];
+	}
+
+	if (max_phyclk_req != clk_mgr_base->clks.phyclk_khz) {
+		clk_mgr_base->clks.phyclk_khz = max_phyclk_req;
+		rn_vbios_smu_set_phyclk(clk_mgr, clk_mgr_base->clks.phyclk_khz);
+	}
+}
+
 static struct clk_mgr_funcs dcn21_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.update_clocks = rn_update_clocks,
 	.init_clocks = rn_init_clocks,
 	.enable_pme_wa = rn_enable_pme_wa,
 	.are_clock_states_equal = rn_are_clock_states_equal,
-	.notify_wm_ranges = rn_notify_wm_ranges
+	.notify_wm_ranges = rn_notify_wm_ranges,
+	.notify_link_rate_change = rn_notify_link_rate_change,
 };
 
 static struct clk_bw_params rn_bw_params = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 872ee08b315f..d94fdc52be37 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -260,11 +260,6 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (enter_display_off == safe_to_lower)
 		dcn30_smu_set_num_of_displays(clk_mgr, display_count);
 
-	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz)) {
-		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PHYCLK, clk_mgr_base->clks.phyclk_khz / 1000);
-	}
-
 	if (dc->debug.force_min_dcfclk_mhz > 0)
 		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
 				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
@@ -431,8 +426,6 @@ static bool dcn3_are_clock_states_equal(struct dc_clocks *a,
 		return false;
 	else if (a->dcfclk_deep_sleep_khz != b->dcfclk_deep_sleep_khz)
 		return false;
-	else if (a->phyclk_khz != b->phyclk_khz)
-		return false;
 	else if (a->dramclk_khz != b->dramclk_khz)
 		return false;
 	else if (a->p_state_change_support != b->p_state_change_support)
@@ -451,6 +444,28 @@ static void dcn3_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	dcn30_smu_set_pme_workaround(clk_mgr);
 }
 
+/* Notify clk_mgr of a change in link rate, update phyclk frequency if necessary */
+static void dcn30_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc_link *link)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	unsigned int i, max_phyclk_req = clk_mgr_base->bw_params->clk_table.entries[0].phyclk_mhz * 1000;
+
+	if (!clk_mgr->smu_present)
+		return;
+
+	clk_mgr->cur_phyclk_req_table[link->link_index] = link->cur_link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
+
+	for (i = 0; i < MAX_PIPES * 2; i++) {
+		if (clk_mgr->cur_phyclk_req_table[i] > max_phyclk_req)
+			max_phyclk_req = clk_mgr->cur_phyclk_req_table[i];
+	}
+
+	if (max_phyclk_req != clk_mgr_base->clks.phyclk_khz) {
+		clk_mgr_base->clks.phyclk_khz = max_phyclk_req;
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PHYCLK, clk_mgr_base->clks.phyclk_khz / 1000);
+	}
+}
+
 static struct clk_mgr_funcs dcn3_funcs = {
 		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 		.update_clocks = dcn3_update_clocks,
@@ -460,7 +475,8 @@ static struct clk_mgr_funcs dcn3_funcs = {
 		.set_hard_max_memclk = dcn3_set_hard_max_memclk,
 		.get_memclk_states_from_smu = dcn3_get_memclk_states_from_smu,
 		.are_clock_states_equal = dcn3_are_clock_states_equal,
-		.enable_pme_wa = dcn3_enable_pme_wa
+		.enable_pme_wa = dcn3_enable_pme_wa,
+		.notify_link_rate_change = dcn30_notify_link_rate_change,
 };
 
 static void dcn3_init_clocks_fpga(struct clk_mgr *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index d0a23b72e604..dd88eb348dfa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -14,6 +14,7 @@
 #include "dpcd_defs.h"
 #include "dsc.h"
 #include "resource.h"
+#include "clk_mgr.h"
 
 static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
 {
@@ -123,6 +124,11 @@ void dp_enable_link_phy(
 		}
 	}
 
+	link->cur_link_settings = *link_settings;
+
+	if (dc->clk_mgr->funcs->notify_link_rate_change)
+		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+
 	if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
@@ -141,8 +147,6 @@ void dp_enable_link_phy(
 	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 
-	link->cur_link_settings = *link_settings;
-
 	dp_receiver_power_ctrl(link, true);
 }
 
@@ -234,6 +238,9 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 	/* Clear current link setting.*/
 	memset(&link->cur_link_settings, 0,
 			sizeof(link->cur_link_settings));
+
+	if (dc->clk_mgr->funcs->notify_link_rate_change)
+		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
 }
 
 void dp_disable_link_phy_mst(struct dc_link *link, enum signal_type signal)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 505357597603..5994d2a33c40 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -241,6 +241,9 @@ struct clk_mgr_funcs {
 	bool (*are_clock_states_equal) (struct dc_clocks *a,
 			struct dc_clocks *b);
 	void (*notify_wm_ranges)(struct clk_mgr *clk_mgr);
+
+	/* Notify clk_mgr of a change in link rate, update phyclk frequency if necessary */
+	void (*notify_link_rate_change)(struct clk_mgr *clk_mgr, struct dc_link *link);
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
 	/*
 	 * Send message to PMFW to set hard min memclk frequency
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 82212ae2755a..b3b8b46d293e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -270,6 +270,8 @@ struct clk_mgr_internal {
 
 	enum dm_pp_clocks_state max_clks_state;
 	enum dm_pp_clocks_state cur_min_clks_state;
+
+	unsigned int cur_phyclk_req_table[MAX_PIPES * 2];
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
 
 	bool smu_present;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
