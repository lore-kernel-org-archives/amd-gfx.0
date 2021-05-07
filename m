Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0D5C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A2C613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A2C613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F006EE43;
	Fri,  7 May 2021 14:59:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E434B6EE43
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgzaA3h/OgTzefcFhwIiu6wNlu8JOPWPn9FyVHYyeQffCSViM4kTXpHhWterpn5pgYV1Pqb46ufcx36hwjQWFSXUxZSi18sHOtQXhQegQ6vKBVoN/j32G9QbkPPHHqInLArqVNFmizpH75GXO8qRD++mNORe9B6EgJq1FsUE2+Cw30WTyeFVJaa4rNudbf3cAwDv9j6AnK5cUPbqQDF1WzlYXwQMLXfT44C7N3TEK1rVc4z1vz+VYM58cpRz7aaKDQMa1K2ulsCSbPi6qg+KSwiQB6HvzDny657SZ8ijMHqsB9Yo4GgnjzrUYP01pX3vzBQu2OsqfEBEq0gx1V3HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3szPL9dDuzNGTdaE24HxyweHh41TQ34FkrE5dkuxYmk=;
 b=JWmDhTsdtN/0Bj6hqvLUJoaEDigQSu3k/34k5uGzozzPvUAcd+dbE2geGOGRDaSs5AiXsaf0WAHUOjezoxcDRcZwQDJcENddMEMe8GiRR4/m6BCFUBZeMCZS8uG6uwru9/tKjMIDXnayAJex2UG7aQGD2fVpg4i/vN2OCkwRwz8mTh2JjOHCgBX7Wa62YMIei29wjjxQPlaWHa7GUdTvmUy9+Scs5BFFdGTtvaMbLVQT+rAHfINqoZUTZf8WlCaE0hjhjQhIkUd40KotWpPyDPkuzNsuCpiL2QLVTTPXhdQZ5I0wItGgaTn9y5yCIZ7NYSLQ0ipA6QKQQ/erxJVVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3szPL9dDuzNGTdaE24HxyweHh41TQ34FkrE5dkuxYmk=;
 b=GsWQfIMLXVsy/HD9TjPy8zOEpGL7IQeiy59RBF7esPTpc3WInXISavX90REqSsVMCrA+NddSEdDezX2tJ4Qxg/d84kr74TVN+dN2nQQJMYWrLL6tggF4kgyw9dVyRgCNzV2hcyJgxrxAQ8rKc5eLO0JsxvXhQXvpI6aR/5OjAlY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Fri, 7 May 2021 14:59:21 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:21 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/14] drm/amd/display: Expand DP module training API.
Date: Fri,  7 May 2021 22:58:12 +0800
Message-Id: <20210507145822.248029-5-stylon.wang@amd.com>
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
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c01784b-2fe8-401f-351f-08d91168b1bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3852D3559EEFC377ADB2E545FF579@DM6PR12MB3852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWlK9a3H1ynJLwXpvwcdxdnIfuy5N5rN/hdyabipXMeZ7Dq/WVym+dpUR/FUQfnSwVZu2LtvHVZfJFknot5eAPGolNNGY3XSVvmqmr76eYiPWTApVCrvpaja/UxlUvNSZlQnWJMtbPjpZm3rI3b6vfxusnQdrfIhMPIxrw5DBut0YYx32JakvbzOk4/TyG+IGx9boQH5n8IMQ1aHLjvs70y4Lwk8Qx12ye8uUG7TccfuRfIsHXjXhd19qEVP7UHPQAyMFQdccpolzsRBnWuJHM+einx5kolgj+PdM25NjWUW10aHXpnAFaIEpLPdzHMp046WdploLuDzT7Z3Q65jKZnejf3F614eOjQSbzr7UvHQLdmSuX1UFHy0Fun8TSNJkO1ov081Ape+pYrIK+ihyeE6+yd39A+tya+kSZ1D3gi+L0S7NvVWv2TGPhv71y5WDA2KbTeomWXzFtEJkUACXCgLZuFxLfbSfxXeTw946D2TgpSxvLzSLNPWoE8iTxbQGQeaJ6+kL9sgHy4NK3W9G+K8A/GTeR6x/YjAvJyniE0JtF25fwPO/9TCpumYk3A0UCmIxZARox5v7oVpfu/NBJFgOpUfaimpGVsWDMxNMrRx6cr3fR12kNs0bRvKees0KJ9HzMqZlOoJKLf8AcNSiDh8VWTi2HNjujyUFEMSwuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(316002)(86362001)(38350700002)(38100700002)(4326008)(8676002)(478600001)(44832011)(66946007)(66476007)(2906002)(26005)(52116002)(54906003)(7696005)(36756003)(8936002)(66556008)(83380400001)(6486002)(2616005)(956004)(1076003)(5660300002)(6666004)(6916009)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mE2BSKbaYFDHI68Tq73ctBBZ+09eND3E0YLIhtKIQVVyhudmYrRVZEgSM9tK?=
 =?us-ascii?Q?ahK4rFeuq9RR0766D3CTy9/lEwY9+Nb7t8TNx3ZbhikNus4hp96tarlae7WV?=
 =?us-ascii?Q?hK832QA44AGz6PEWIJxGK4KrIRnZEJoHHbVvgd/3FspSbOp15b6Qo1KUDXI5?=
 =?us-ascii?Q?pv5sOYanfd3PlEGVcXDymf6f+AbcEmOg/Q3vcx26PN6Jr1Uwc/gUVreqviYH?=
 =?us-ascii?Q?Whjjgn/L9SYHZ26iHQVxP5lKnQDvkbbP6/1bKIQ0a3EJTShcUPc8FqM/+oa8?=
 =?us-ascii?Q?qsuNyXb/NYwAoIRuuHsjgiqXLp0MKc856UK4+SXlFdAsPbJ7BBndODjIZw09?=
 =?us-ascii?Q?S4UObo4MWdnh5hrBdjv408KQ22dsC8QJHRkZkTe8uashWcH7JbNODrgz3UBD?=
 =?us-ascii?Q?8vQbuBGc6Ze3OJuaDJ6bG3ES8JChAw9YGHCBNinAI12pGQqaehKvF3IZUdXR?=
 =?us-ascii?Q?grPk9N+TzoWZSwqzGL/+8fg9zhpHXEnf30HfbtdXkwXn6SyRkznVRE/pBDWm?=
 =?us-ascii?Q?DaJwbx3/eLA39hAPO21+vSfWeYZhkYitcqkzY2VSgHwU8n08fIdW+U0kBIUm?=
 =?us-ascii?Q?Gc0OZ6NJNIQIXcqAHPQGcslfQ4ZROPjdm/yTpx3wESX6lW3rof6ygg8QGBvi?=
 =?us-ascii?Q?wRfeNDyqspju0XUiuFbTj6qCWxswnv+ak2dkMVlGaJ5/OwF/Yfofp69MXjTJ?=
 =?us-ascii?Q?zgT8Ze0+NH++wcxBrYrPlD8dl1+ZpaK5BUODpi13I5itVdH7XynuhVV1BbIK?=
 =?us-ascii?Q?Udm8pAE2BSaaxvXj+r7UibjLo7G93qEtTJAuquQNwXWVCGw1CPksK6PAkre9?=
 =?us-ascii?Q?f4zuLfedIAp1rDXHbNe/bJOP6IpoKk48isI9zb4uc+/3xMcy45+5gpRZoRa7?=
 =?us-ascii?Q?a6fjk4iMHz0fGu7IhQAGKzSsqvywDpgnvJRYZqEawn5+hNypbBUbNKSpf3bS?=
 =?us-ascii?Q?V6Tr1Zcp3sdte5/V4LNQVMlJA0V8LMNKNniulrLBzZxj7S+Z2IrdnhcakB/k?=
 =?us-ascii?Q?SvgefzoOItv6KBfNCYXlai2VkFwuc0X+69GozX17anqqIXzcjJt3afSpgHhN?=
 =?us-ascii?Q?u0sA+F0MGqOC8bWMTKEtjhH1kP5CAGGOipOIG3+CUn3ZPMBQJp+WWRGjapVG?=
 =?us-ascii?Q?WbTb6en4buewtaS05DhnnYkaoLMZ95wJtJA7vCqZuKEvUjpvCqyxfYwu5TIX?=
 =?us-ascii?Q?Kvq2E3G0oy0H4IRePmOESWAOCbMIqoMqJB0KACgAlyF0pWRNBcwQkwP0MUsz?=
 =?us-ascii?Q?IFfTQ97xhfmhvx+NuroCXkHmpOBusd7FHoMWNOXLFehALN2574+1jyuSDeia?=
 =?us-ascii?Q?EKgmCCKLBT3LHrVn6hoKX3Sh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c01784b-2fe8-401f-351f-08d91168b1bf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:20.9263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRabiNHqwx+HKw1/TsZGlC9ql/dO1cq23SffQiX2as+G1YAhuV1osss+FJ8dhJJaQuIXLvSMTNPtg+AWvTLYYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
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

[Why & How]
Add functionality useful for DP link training to public interface.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h  |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b6ed57ba7a48..de75e8581078 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1175,7 +1175,7 @@ static inline enum link_training_result perform_link_training_int(
 	return status;
 }
 
-static enum link_training_result check_link_loss_status(
+enum link_training_result dp_check_link_loss_status(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting)
 {
@@ -1309,7 +1309,7 @@ static void initialize_training_settings(
 		lt_settings->enhanced_framing = 1;
 }
 
-static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
+uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
 {
 	switch (lttpr_repeater_count) {
 	case 0x80: // 1 lttpr repeater
@@ -1378,7 +1378,7 @@ static void configure_lttpr_mode_non_transparent(struct dc_link *link)
 			link->dpcd_caps.lttpr_caps.mode = repeater_mode;
 		}
 
-		repeater_cnt = convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 
 		for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
 			aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
@@ -1605,7 +1605,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
 		 */
-		repeater_cnt = convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 
 		for (repeater_id = repeater_cnt; (repeater_id > 0 && status == LINK_TRAINING_SUCCESS);
 				repeater_id--) {
@@ -1648,7 +1648,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 	 */
 	if (link->connector_signal != SIGNAL_TYPE_EDP && status == LINK_TRAINING_SUCCESS) {
 		msleep(5);
-		status = check_link_loss_status(link, &lt_settings);
+		status = dp_check_link_loss_status(link, &lt_settings);
 	}
 
 	/* 6. print status message*/
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 38e6fbf1e26d..428842511c03 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -97,5 +97,12 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx);
 bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable);
 
+/* Convert PHY repeater count read from DPCD uint8_t. */
+uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count);
+
+/* Check DPCD training status registers to detect link loss. */
+enum link_training_result dp_check_link_loss_status(
+		struct dc_link *link,
+		const struct link_training_settings *link_training_setting);
 
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
