Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1DAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F96E64ED5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F96E64ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267B26E44D;
	Fri, 26 Feb 2021 22:37:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE106E44C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbiU9wu5TsBe9aL8k24FTv/GoG9wAe7cmnBMqzrkgtBXcO6B+f5UoO3im8I1zMGyhBYiarZJFnzpe4lqhhtmay/nvwt4qWE4DVuCa8YLYWGa3AdK+G4aBv6Wdi7Ov/pHUR5ENFt3XHWLFYr/6jOcMBiNfkcnd1E1iMFMzqFoxY0FtoqwWlp3jmFjbPvFLfMLsu6G//u7KICV8d/Od996wSvI+zyspoJnbq5KRfpysa5B6MN4djQGIocY0QMa7h6aGrcJBC7yASVCIrfypzlC0p95kr4EvlHhMA3NQG59tSb4quvtwK//7hmG++NKDwOv72+2qeQLVzT3HTy2eZFGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gU++EPiHzjF1fCVnMfHr72SOSKKt1KgzYEpRhxZ3Ow=;
 b=gNLrxsymDUVgKOGwP23J42klRTu5vmVnZrtC34prOqOy61iqSlpApnn6hAvQRMwgswgSlFNj8ZOh30ETAiCMxHa1q8ZYhetu1ktX5NJqWyLcOiSkjrXbqrSCoeibjcmVlSCRiQuQRo1XIM8RpaLo6v9LBKLLYv8QGLCAKlsCSmWSn6SKt7t2sIxHCEgFH6misuiGxamR3kOaB0Lw3dnuAEF9ManTDG8/u2xKbE5tJ7H/vI2aw+6uhpG51GKhoOcekYqkYVe9hqFdAR3X1G8DVmJAh7q+5VIxMtcbZ7X3FEAyOn9BJpoLev9KftMn+BLV1EKYfJZFlMyhziaqhHT0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gU++EPiHzjF1fCVnMfHr72SOSKKt1KgzYEpRhxZ3Ow=;
 b=f80gFnNwcHoS1Yz2fR5SdFa5Qc9bpUgR6oDUnk9Vm0njRlNp7Onh5ki+Q2PxL844NIDMX+csxNoHrWp/AgRX0UzSFPj9v8OGJRNJ0XR9J39NtsdeirrXRQQ+N5CVT05lXZlIliYeM2vsEkFMbFJkEmJ6vtb5ISTnFhcU0uiY3k4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:46 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:45 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] drm/amd/display: Refactored DC interfaces to support
 multiple eDP
Date: Fri, 26 Feb 2021 17:36:58 -0500
Message-Id: <20210226223704.400472-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1352bbb8-7882-4f13-61d2-08d8daa72318
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883A119781BE14E94A33A5D989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUiGmFetXRONb+gJJ2NoPZEIrrD6HxYbQVNEvhZtJExRNa8300vbrHBdTIED69aopo9GrGkauSPuKGR+ep0lIHxE/bq6ON12y5G9L4hq5hl4J+D6+H0P/UmjlHf+RnPzZ+rFySKM1hDk0OVEiYNQJMzf0TMLZnZjr6aa6Mgwdx51e4+JL/ulniE6QuOC4mWFOrwrkO1i2hnw2LVipRqC3I3MWx1GdpCFYEst6IYLnkqWB9X5xmXuQObf8pswbrYdiGZaQDld4qS9p41Rg5ZBdsUrYmBrqr7m7B3MjkKTfk70eCbegKGrjwjMu+s8YWhJxTDNVJp04FbeQFyDbpxfLcfhqNpvKlOYvMfyz66caFLgemJhdDoS77xNgwr7gWnRyW4qZV67m1VC+71crMZ64Bb6D+dn+7u2YdkXjgHwB4yoSEaa4VmyebeRBCRC0XqwoNr1M9NDcd1CKP1pACUReS4Vq2E6sjxCbBvcm0ZI+TiOGg3POsMAem+mPucLxne2WyPGiZoqzWrQ+VdcRsUHbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(30864003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QOYJjp6REcfJ2+VeFMmmPj8NCFQxQUEL1p4CBkIZvjsAbBvnr/9l/f3QCcz0?=
 =?us-ascii?Q?tAgwgCGt73O+g1SyQ9hLjTRyHuQAxA8NbBs40jOKRazA0G55ykeLbYtN3cDv?=
 =?us-ascii?Q?ajdzUq4Alkp8aaWSpXTa8iXhOfUEhJvZGmWXxztjQ2gN5q2u+P0n98VG/xAG?=
 =?us-ascii?Q?o25lpuJyI0WDr+T+9jmS9lpdOdNncMFf174bNwbzps3bQmrtlNMdW90oBreX?=
 =?us-ascii?Q?Ylo8dEMy9VZF0oYGMxEzCtqpwyWkFRUTHGXN8VGD6eUiSGp4lc6TeTlOSjGQ?=
 =?us-ascii?Q?QwoCi1x7cjNNSNXw5kP4+WRk65CLL3SPJNoBBFUza1M1/YWj9gzlWwNYp7d8?=
 =?us-ascii?Q?NsguQYttb2mM6NDunlYqsrIrZH14CAWsRQo5IAeo7A9LXy60s9JJLqjCA31O?=
 =?us-ascii?Q?oifRzsYF4DTPVzkDkFSSLKahN1vcJxg0KcdLPqP7XNNndx1qi/9rGy4SNM2G?=
 =?us-ascii?Q?r4MAKsQz2ORcZwrcb3dDhoV/cxSQi1jIL6QoNyO5G/YXQnaxI4/EpD83jydv?=
 =?us-ascii?Q?w4LMUPHC46qmD3xSsjRtVRVO+phUi/oTAyJENAwcFwHRSMmvRzYlTCEJqSj2?=
 =?us-ascii?Q?09isUdel0d3mc+CjutdUgPURGfzQWdRAFmwiW689R3WgHEBvEvKwEwxRl/5S?=
 =?us-ascii?Q?GRPL2j3U8V6RIau0YFmSFFPdsWkwLE1VPBTgSaYsDFq47xRILXsdqod28GuT?=
 =?us-ascii?Q?YX5RIt0oqTphyJ9w1GlZ6/cHX9kt72BlViHYfjpmBaUWT1+6Z0O6melORYEb?=
 =?us-ascii?Q?ilI8qcNe1h28PTsLLL1rz4/X6nQggcv5t48dSCDLDnDGxE9Ixrx6XNC2CNiM?=
 =?us-ascii?Q?Yh9yZbxHzpqkBV/Ak+q8OGi3aCcqGH6tKWAR3MfYXqlWNd1xhHBwoZOFeO//?=
 =?us-ascii?Q?hS6hJPhZ9EqsH/Qu5OcsC+JthS5nKQAR+xhmZDtkEBAHwFW+lB5pQtJAXigQ?=
 =?us-ascii?Q?FJ2iq4ElzTAkAJLHX9jd+vdRMbOYuNSNDUP0EDwh4ap9qd1Fbf3lLfq9rB+s?=
 =?us-ascii?Q?Ggj7u4sJUDO0jLc93RLeTbL9V9KSrbksgeZnBQCe485LbStHTRepPW6DznfT?=
 =?us-ascii?Q?nmcdQVieomso88tYRltjVIx0+oi7I4SWwzcRLGIe79GZo1hZdWxEpiWcoEQL?=
 =?us-ascii?Q?OrSWT4MhCpoHS5awQlOXZ6zfFh2EQFiL9HgxUp5EAskbcSnMVoxhUUkjnfY3?=
 =?us-ascii?Q?wZMeXrdnHdcy+a1B308w6dkQai4ogH85tSYPRXVQOQmytHRCufVflnucjl2c?=
 =?us-ascii?Q?+1y1wZPOofwbbgwcEHWUfFKatlcC/Uki9cwXKWxybrs9UYIzqEqSnIBWCW4z?=
 =?us-ascii?Q?LUCPu44wrlapEbRxS3dvPA5SiMxoRxKZEbhXp0v0hQwgtupFQRllPTtRks+X?=
 =?us-ascii?Q?fvZyPIiLWx3sXv+//O/5rxsNHuGA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1352bbb8-7882-4f13-61d2-08d8daa72318
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:45.8298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WETzfBNFfExoPOAybf3UkZ+Y9/SMWS1G4Tnb1WhI8xgxYOOUvyfpDVid4rdhmTHz1X19etY0v6FgfvmsxvaVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Some existing DC interfaces are optimized to return a single eDP
link/stream. Refactored those DC interfaces to support multiple eDP.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 17 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 18 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 15 ++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 72 ++++++++++++-------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 29 +++++---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 31 ++++----
 8 files changed, 119 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 995ffbbf64e7..f7c728d4f50a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -87,12 +87,16 @@ int clk_mgr_helper_get_active_plane_cnt(
 
 void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 {
-	struct dc_link *edp_link = get_edp_link(dc);
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	struct dc_link *edp_link = NULL;
+	int edp_num;
 
+	get_edp_links(dc, edp_links, &edp_num);
 	if (dc->hwss.exit_optimized_pwr_state)
 		dc->hwss.exit_optimized_pwr_state(dc, dc->current_state);
 
-	if (edp_link) {
+	if (edp_num) {
+		edp_link = edp_links[0];
 		clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
 		dc_link_set_psr_allow_active(edp_link, false, false, false);
 	}
@@ -101,11 +105,16 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 
 void clk_mgr_optimize_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 {
-	struct dc_link *edp_link = get_edp_link(dc);
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	struct dc_link *edp_link = NULL;
+	int edp_num;
 
-	if (edp_link)
+	get_edp_links(dc, edp_links, &edp_num);
+	if (edp_num) {
+		edp_link = edp_links[0];
 		dc_link_set_psr_allow_active(edp_link,
 				clk_mgr->psr_allow_active_cache, false, false);
+	}
 
 	if (dc->hwss.optimize_pwr_state)
 		dc->hwss.optimize_pwr_state(dc, dc->current_state);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1cdef90c03aa..87b8315cfbb8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1012,22 +1012,26 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 
 static void detect_edp_presence(struct dc *dc)
 {
-	struct dc_link *edp_link = get_edp_link(dc);
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	struct dc_link *edp_link = NULL;
+	int i;
+	int edp_num;
 	bool edp_sink_present = true;
 
-	if (!edp_link)
+	get_edp_links(dc, edp_links, &edp_num);
+	if (!edp_num)
 		return;
 
 	if (dc->config.edp_not_connected) {
 			edp_sink_present = false;
 	} else {
 		enum dc_connection_type type;
-		dc_link_detect_sink(edp_link, &type);
-		if (type == dc_connection_none)
-			edp_sink_present = false;
+		for (i = 0; i < edp_num; i++) {
+			edp_link = edp_links[i];
+			dc_link_detect_sink(edp_link, &type);
+			edp_link->edp_sink_present = (type != dc_connection_none);
+		}
 	}
-
-	edp_link->edp_sink_present = edp_sink_present;
 }
 
 void dc_hardware_init(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 49e055a8309c..4ada3fe36b2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -52,6 +52,7 @@ struct aux_payload;
 #define MAX_STREAMS 6
 #define MAX_SINKS_PER_LINK 4
 #define MIN_VIEWPORT_SIZE 12
+#define MAX_NUM_EDP 2
 
 /*******************************************************************************
  * Display Core Interfaces
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index df6ab333336c..c50ef5a909a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -187,16 +187,21 @@ static inline struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_
 	return dc->links[link_index];
 }
 
-static inline struct dc_link *get_edp_link(const struct dc *dc)
+static inline void get_edp_links(const struct dc *dc,
+		struct dc_link **edp_links,
+		int *edp_num)
 {
 	int i;
 
-	// report any eDP links, even unconnected DDI's
+	*edp_num = 0;
 	for (i = 0; i < dc->link_count; i++) {
-		if (dc->links[i]->connector_signal == SIGNAL_TYPE_EDP)
-			return dc->links[i];
+		// report any eDP links, even unconnected DDI's
+		if (dc->links[i]->connector_signal == SIGNAL_TYPE_EDP) {
+			edp_links[*edp_num] = dc->links[i];
+			if (++(*edp_num) == MAX_NUM_EDP)
+				return;
+		}
 	}
-	return NULL;
 }
 
 /* Set backlight level of an embedded panel (eDP, LVDS).
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index c13f9674048e..62c019fd326e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -216,6 +216,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		    res_ctx->pipe_ctx[i].stream->link == link &&
 		    res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
 			pipe_ctx = &res_ctx->pipe_ctx[i];
+			//TODO: refactor for multi edp support
 			break;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index caee1c9f54bd..ddabc205bcfc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1629,34 +1629,39 @@ static void disable_vga_and_power_gate_all_controllers(
 }
 
 
-static struct dc_stream_state *get_edp_stream(struct dc_state *context)
+static void get_edp_streams(struct dc_state *context,
+		struct dc_stream_state **edp_streams,
+		int *edp_stream_num)
 {
 	int i;
 
+	*edp_stream_num = 0;
 	for (i = 0; i < context->stream_count; i++) {
-		if (context->streams[i]->signal == SIGNAL_TYPE_EDP)
-			return context->streams[i];
+		if (context->streams[i]->signal == SIGNAL_TYPE_EDP) {
+			edp_streams[*edp_stream_num] = context->streams[i];
+			if (++(*edp_stream_num) == MAX_NUM_EDP)
+				return;
+		}
 	}
-	return NULL;
 }
 
-static struct dc_link *get_edp_link_with_sink(
+static void get_edp_links_with_sink(
 		struct dc *dc,
-		struct dc_state *context)
+		struct dc_link **edp_links_with_sink,
+		int *edp_with_sink_num)
 {
 	int i;
-	struct dc_link *link = NULL;
 
 	/* check if there is an eDP panel not in use */
+	*edp_with_sink_num = 0;
 	for (i = 0; i < dc->link_count; i++) {
 		if (dc->links[i]->local_sink &&
 			dc->links[i]->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-			link = dc->links[i];
-			break;
+			edp_links_with_sink[*edp_with_sink_num] = dc->links[i];
+			if (++(*edp_with_sink_num) == MAX_NUM_EDP)
+				return;
 		}
 	}
-
-	return link;
 }
 
 /*
@@ -1668,36 +1673,48 @@ static struct dc_link *get_edp_link_with_sink(
  */
 void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 {
-	int i;
-	struct dc_link *edp_link_with_sink = get_edp_link_with_sink(dc, context);
-	struct dc_link *edp_link = get_edp_link(dc);
+	struct dc_link *edp_links_with_sink[MAX_NUM_EDP];
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
+	struct dc_link *edp_link_with_sink = NULL;
+	struct dc_link *edp_link = NULL;
 	struct dc_stream_state *edp_stream = NULL;
+	struct dce_hwseq *hws = dc->hwseq;
+	int edp_with_sink_num;
+	int edp_num;
+	int edp_stream_num;
+	int i;
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
-	struct dce_hwseq *hws = dc->hwseq;
+
+	get_edp_links_with_sink(dc, edp_links_with_sink, &edp_with_sink_num);
+	get_edp_links(dc, edp_links, &edp_num);
 
 	if (hws->funcs.init_pipes)
 		hws->funcs.init_pipes(dc, context);
 
-	edp_stream = get_edp_stream(context);
+	get_edp_streams(context, edp_streams, &edp_stream_num);
 
 	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_link && dc->ctx->dce_version != DCE_VERSION_8_0 &&
+	if (edp_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
 		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
 		    dc->ctx->dce_version != DCE_VERSION_8_3) {
-
-		// enable fastboot if backend is enabled on eDP
-		if (edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc)) {
-			/* Set optimization flag on eDP stream*/
-			if (edp_stream && edp_link->link_status.link_active) {
-				edp_stream->apply_edp_fast_boot_optimization = true;
-				can_apply_edp_fast_boot = true;
+		for (i = 0; i < edp_num; i++) {
+			edp_link = edp_links[i];
+			// enable fastboot if backend is enabled on eDP
+			if (edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc)) {
+				/* Set optimization flag on eDP stream*/
+				if (edp_stream_num && edp_link->link_status.link_active) {
+					edp_stream = edp_streams[0];
+					edp_stream->apply_edp_fast_boot_optimization = true;
+					can_apply_edp_fast_boot = true;
+					break;
+				}
 			}
 		}
-
 		// We are trying to enable eDP, don't power down VDD
-		if (edp_stream)
+		if (edp_stream_num)
 			keep_edp_vdd_on = true;
 	}
 
@@ -1712,6 +1729,9 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	/* eDP should not have stream in resume from S4 and so even with VBios post
 	 * it should get turned off
 	 */
+	if (edp_with_sink_num)
+		edp_link_with_sink = edp_links_with_sink[0];
+
 	if (!can_apply_edp_fast_boot && !can_apply_seamless_boot) {
 		if (edp_link_with_sink && !keep_edp_vdd_on) {
 			/*turn off backlight before DP_blank and encoder powered down*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 74c2edae08f2..bdf40ef01607 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1462,19 +1462,26 @@ void dcn10_init_hw(struct dc *dc)
  */
 void dcn10_power_down_on_boot(struct dc *dc)
 {
-	int i = 0;
+	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link;
+	int edp_num;
+	int i = 0;
 
-	edp_link = get_edp_link(dc);
-	if (edp_link &&
-			edp_link->link_enc->funcs->is_dig_enabled &&
-			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
-			dc->hwseq->funcs.edp_backlight_control &&
-			dc->hwss.power_down &&
-			dc->hwss.edp_power_control) {
-		dc->hwseq->funcs.edp_backlight_control(edp_link, false);
-		dc->hwss.power_down(dc);
-		dc->hwss.edp_power_control(edp_link, false);
+	get_edp_links(dc, edp_links, &edp_num);
+
+	if (edp_num) {
+		for (i = 0; i < edp_num; i++) {
+			edp_link = edp_links[i];
+			if (edp_link->link_enc->funcs->is_dig_enabled &&
+					edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+					dc->hwseq->funcs.edp_backlight_control &&
+					dc->hwss.power_down &&
+					dc->hwss.edp_power_control) {
+				dc->hwseq->funcs.edp_backlight_control(edp_link, false);
+				dc->hwss.power_down(dc);
+				dc->hwss.edp_power_control(edp_link, false);
+			}
+		}
 	} else {
 		for (i = 0; i < dc->link_count; i++) {
 			struct dc_link *link = dc->links[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 04de9d9b8e28..c626334e9346 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -421,11 +421,12 @@ void dcn30_program_all_writeback_pipes_in_tree(
 
 void dcn30_init_hw(struct dc *dc)
 {
-	int i, j;
 	struct abm **abms = dc->res_pool->multiple_abms;
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
+	int i, j;
+	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
@@ -574,17 +575,23 @@ void dcn30_init_hw(struct dc *dc)
 	 * if DIG is turned on and seamless boot not enabled
 	 */
 	if (dc->config.power_down_display_on_boot) {
-		struct dc_link *edp_link = get_edp_link(dc);
-
-		if (edp_link &&
-				edp_link->link_enc->funcs->is_dig_enabled &&
-				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
-				dc->hwss.edp_backlight_control &&
-				dc->hwss.power_down &&
-				dc->hwss.edp_power_control) {
-			dc->hwss.edp_backlight_control(edp_link, false);
-			dc->hwss.power_down(dc);
-			dc->hwss.edp_power_control(edp_link, false);
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		struct dc_link *edp_link;
+
+		get_edp_links(dc, edp_links, &edp_num);
+		if (edp_num) {
+			for (i = 0; i < edp_num; i++) {
+				edp_link = edp_links[i];
+				if (edp_link->link_enc->funcs->is_dig_enabled &&
+						edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+						dc->hwss.edp_backlight_control &&
+						dc->hwss.power_down &&
+						dc->hwss.edp_power_control) {
+					dc->hwss.edp_backlight_control(edp_link, false);
+					dc->hwss.power_down(dc);
+					dc->hwss.edp_power_control(edp_link, false);
+				}
+			}
 		} else {
 			for (i = 0; i < dc->link_count; i++) {
 				struct dc_link *link = dc->links[i];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
