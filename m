Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20265C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5D7613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5D7613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A51F6EE49;
	Fri,  7 May 2021 14:59:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7E76EE49
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0ESqYPxcYujTygwNy7amHYiGYdjustiHuWdLiPGu9uaXC3IkjrotsipzZ3sn0SYb1+A1tbD8AjPCBrL1QCE4QoZ0dOWiMtJsnQr7/WXdKdIZMau3QrGtRy0JgOx9EYFpBH6HqJRXzI3MMBkAcn+UaGp8xKfIGm5CNeurmYpI1Toyyo+CcIaLR6V6i7ceajYRqtoVKQ12arS0iuRkRqQHmFQ1WXXk84Sj1kQd24xYHwyG9lAzeqXMTa5xV3e6XNrm2cy5/iesZ0G9THrjRGk05/kNsvTtJrHGJrfP2/fPtXaQksu0io8ytl6Tts53thCzLwE7glKYwCEgyFlA1dL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiiZ3Y+ZFsB/oV22er7/ekpwlQo1bCHTQHziNUUYV80=;
 b=DpE62gUgBX+fjDk8hcFXhzeuLBwz+vDW+DSSUrX7/4GwYArJ8fVKmA7jpq5E3G/oTj+9cIxrD11jOFUmRBH1TqHiUoYmiT6yn3Nm/Usy5i37upzVJnu+UQXX/AYO8n3a3TXaoQPhdN17UX4unx2FMg9ayINFqQ71z2qOCivo1hVOvt7Qzma5CS59YXXN0KkHdClpwAOCIHzlLelQAj1GoNFVYDwd5Kk0lw0VPyddd7GmxCoPowUMNr/FNlKTIj5Xnd5inUP9JdrDuhIecbH4Hhp4g/10w5t84EVLhzG86cAL8RnM0ufQKPz86hVFvWxXuAoDoF4K3vPmvZuHNKpT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiiZ3Y+ZFsB/oV22er7/ekpwlQo1bCHTQHziNUUYV80=;
 b=cqInqhTa4NUGLgdYbuw+sKpgITEjM1JTKhoy4f4Jfkvq2yQjYcfpDHMmcrkPAjvIrlcDKy8rVTL71spKZrQFij9fgIBijiDwykGRGikql+Fm0RLxgvrDjD+E4uP+u/i6GhHObOQrzdT3ATsTg4JRmbaVh24h5xhfZKw0BpN08YU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:59:41 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:41 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/14] drm/amd/display: minor dp link training refactor
Date: Fri,  7 May 2021 22:58:15 +0800
Message-Id: <20210507145822.248029-8-stylon.wang@amd.com>
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
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45874800-e249-4210-915c-08d91168bdb1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17868249E76BFE62CE1C4800FF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSWd5aRBWGqNUyx4uwNtSEw3qvU809vvrFNiHWpiRWdkUXzmOIDrqi66nDYlL6jlby87oTlfHUESd5iOjdzu3YFZxqms+Y7KyeAU875J5nwkFA1V2qkUVnsu4Kvsc/Sgy0YzuvTvRhx61kgfX+xruCJyj/ZLE+Gu6rmMdFlK8SdHzb0QmR5XcJ0JZgxjJk03DXOfCW7HCOTxvhi0R6aKg09SOGLaHxHldELfZHAhUsXPgA1Q0/mj95wnOeAkr7oJJRRxrk3qknml9x7iNY8Jsw3Bw2lG+aCePSv2HWd/fz66tGRKn27HyUTD/jvJpR0+lr3SCV8DNhy9CPnj3egHIIDpCFY/2+q3b+R4TikRZoh/jfZ78ROITEq/2XPZ/jBjcMVppgMsn2I56vUziBemZD2EQYOYBpde2nH/lZ/zmpaNj8+FWznoHX6dvsWPodRW0OsQtyy46Y3M+lQ4fxE2Wv7fJoIPksdmy73ZReA4E0wrgZkhlRys7QHh4trSXDI2dWugqkfHFih53NRDOi6v2x9Z4WnCezm75HnpIA0c71wfrTFQjGWCB+IZaeNp8Do99xDh/6lOOdNMtqBT029Q1xfpnWpQC3Gt8CsbsfZ5B81sgk23zNv6bZkyeR7180N8N7ImFLiKzbXQAYmIvy4YgchfGVHWtC7xYpR4cWzwM8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(498600001)(16526019)(86362001)(956004)(38350700002)(38100700002)(4326008)(186003)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VLx9mVWcFUxA4ITnMAms3fat+XKbGlZeQmxkulEIyybY9gOQ8pGYJbQZtCAx?=
 =?us-ascii?Q?ANtwP//r9ri6AaaO6kb0y3qVuXdxcyarbT4bY4HeyraItUNbjptnpeDObSvE?=
 =?us-ascii?Q?C9bsQekGE8Jek3TlYCpPJc9cUqWnisHHR7mnDfvHbLLpE8wnm/9ol2LfpxKe?=
 =?us-ascii?Q?t0k2mtt6kQwdjS5o3MdtDmUm2530a/vLqDe0nddXkbSG+vhyA8K1AvjC1lPj?=
 =?us-ascii?Q?NiB72jkBf3f7DVVAQuZJEuQ7HtxpDlG0KWvXBzHyEF2Lt4RGh7s4AmKFPhQX?=
 =?us-ascii?Q?qI/ZYWpcZR6sS+fijb0QcKkXEucWUU38g6JR5SI2sCNGyVCyaB5bjPVefnNw?=
 =?us-ascii?Q?4cF06rY5mc2t4NeUAhkVSZBaeVj2xBxo1Z7PpP41f1F5k6a+BG16hMdEsjZk?=
 =?us-ascii?Q?uvbmixG7Bpfp4GMMIYcteFasRyntZR9cutlExIruf0N3jCRGaahuC3EvaNOB?=
 =?us-ascii?Q?/ZITYmMnciTOnuupoZMxLDoPQ/78L7UnJ+osqYiipGTbGfVyZHFYkID+Ail7?=
 =?us-ascii?Q?O7Ol/rRa88EfPcbftGVFO/CIIC1tsmppQEeM9jaRGZcW5/m1wdN8kqkOHqWm?=
 =?us-ascii?Q?TiFiPv7QnIVzHIN8PUobftIb1pNYJ+otbpH6NXcmfvVpw9jM6i6AHdKHrs4w?=
 =?us-ascii?Q?W2420mycxE415/25QI7ZYpKo3Ffe3or9FRQCH5lE6SuUmAAenYeHKXs90/Jy?=
 =?us-ascii?Q?KP9eItmQm35mTzFX3izDKWYaWi30hb9VvX/BWr3T25wDpFUZ4WZ8xjWUXnGx?=
 =?us-ascii?Q?2L7s1GManLTnsTuGtcYC11VaQJVB32netn2oBBExwroF9t5mny/4qa3J165q?=
 =?us-ascii?Q?PeTiot/Nb7NvTtSshnRDkTRKZKC2ResIVkMPVhQBhPv/QMT6yVQCuPKRpB+w?=
 =?us-ascii?Q?kqt6rIgML7ZiSbBur9tvf4xdX7bBOQjeCyudHVbLXPU9XQWJE/z/HiFnG5Au?=
 =?us-ascii?Q?Ct/bFVPo2LsxENJuPedYvYVQc0WSuumf2V7eRJJio9nH9f96o6JHd6xOhdTs?=
 =?us-ascii?Q?8IJS/Ui4kS1yQwWy68LQpSt2BdgUH1HvfWo7sm1NjKgJde+FgdDDSCmsU/9m?=
 =?us-ascii?Q?HmG6OD0BU+5m25ldw2kDyAV6cyLqOx1vK4sMy8gSPPnW8CstyNY5s6KYYaCh?=
 =?us-ascii?Q?vsRvJ59CkW1Cyx5ef879pUUKVKuZeaNp8Ya45n+qDQ4ykwJlUqxplx1EGCcp?=
 =?us-ascii?Q?dlIQ9Zu4iLiC70kj4B6g2nx4S/0nEJ8lufwpBym1md9o8ZEm9QIBPf5BaJfK?=
 =?us-ascii?Q?QkgbxZtcOSgTf2kLGD6DHiEtS97pH+rxcCSKZSeiXYTNO6/HsHeJLT3cgir9?=
 =?us-ascii?Q?rGtxUYy8tk/SyZDqzGwNAMyM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45874800-e249-4210-915c-08d91168bdb1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:40.9916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C00jolvVofQZDwdA4fRa+rmy52Z8ykqXbtVnechX+2m3bfejNl/qpD91wFkjeB0xKEiFt3JV4wivLZgzjDyiw==
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
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <George.Shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[how]
The change includes some dp link training refactors:
1. break down is_ch_eq_done to checking individual conditions in
its own function.
2. update dpcd_set_training_pattern to take in dc_dp_training_pattern
as input.
3. moving lttpr mode struct definition into link_service_types.h

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 124 ++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   6 -
 .../amd/display/include/link_service_types.h  |   6 +
 4 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index de75e8581078..27c5d49a7bc1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -108,10 +108,50 @@ static void wait_for_training_aux_rd_interval(
 		wait_in_micro_secs);
 }
 
+static enum dpcd_training_patterns
+	dc_dp_training_pattern_to_dpcd_training_pattern(
+	struct dc_link *link,
+	enum dc_dp_training_pattern pattern)
+{
+	enum dpcd_training_patterns dpcd_tr_pattern =
+	DPCD_TRAINING_PATTERN_VIDEOIDLE;
+
+	switch (pattern) {
+	case DP_TRAINING_PATTERN_SEQUENCE_1:
+		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_1;
+		break;
+	case DP_TRAINING_PATTERN_SEQUENCE_2:
+		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_2;
+		break;
+	case DP_TRAINING_PATTERN_SEQUENCE_3:
+		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_3;
+		break;
+	case DP_TRAINING_PATTERN_SEQUENCE_4:
+		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_4;
+		break;
+	case DP_TRAINING_PATTERN_VIDEOIDLE:
+		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_VIDEOIDLE;
+		break;
+	default:
+		ASSERT(0);
+		DC_LOG_HW_LINK_TRAINING("%s: Invalid HW Training pattern: %d\n",
+			__func__, pattern);
+		break;
+	}
+
+	return dpcd_tr_pattern;
+}
+
 static void dpcd_set_training_pattern(
 	struct dc_link *link,
-	union dpcd_training_pattern dpcd_pattern)
+	enum dc_dp_training_pattern training_pattern)
 {
+	union dpcd_training_pattern dpcd_pattern = { {0} };
+
+	dpcd_pattern.v1_4.TRAINING_PATTERN_SET =
+			dc_dp_training_pattern_to_dpcd_training_pattern(
+					link, training_pattern);
+
 	core_link_write_dpcd(
 		link,
 		DP_TRAINING_PATTERN_SET,
@@ -240,37 +280,6 @@ static void dpcd_set_link_settings(
 	}
 }
 
-static enum dpcd_training_patterns
-	dc_dp_training_pattern_to_dpcd_training_pattern(
-	struct dc_link *link,
-	enum dc_dp_training_pattern pattern)
-{
-	enum dpcd_training_patterns dpcd_tr_pattern =
-	DPCD_TRAINING_PATTERN_VIDEOIDLE;
-
-	switch (pattern) {
-	case DP_TRAINING_PATTERN_SEQUENCE_1:
-		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_1;
-		break;
-	case DP_TRAINING_PATTERN_SEQUENCE_2:
-		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_2;
-		break;
-	case DP_TRAINING_PATTERN_SEQUENCE_3:
-		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_3;
-		break;
-	case DP_TRAINING_PATTERN_SEQUENCE_4:
-		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_4;
-		break;
-	default:
-		ASSERT(0);
-		DC_LOG_HW_LINK_TRAINING("%s: Invalid HW Training pattern: %d\n",
-			__func__, pattern);
-		break;
-	}
-
-	return dpcd_tr_pattern;
-}
-
 static uint8_t dc_dp_initialize_scrambling_data_symbols(
 	struct dc_link *link,
 	enum dc_dp_training_pattern pattern)
@@ -433,20 +442,30 @@ static bool is_cr_done(enum dc_lane_count ln_count,
 }
 
 static bool is_ch_eq_done(enum dc_lane_count ln_count,
-	union lane_status *dpcd_lane_status,
-	union lane_align_status_updated *lane_status_updated)
+		union lane_status *dpcd_lane_status)
 {
+	bool done = true;
 	uint32_t lane;
-	if (!lane_status_updated->bits.INTERLANE_ALIGN_DONE)
-		return false;
-	else {
-		for (lane = 0; lane < (uint32_t)(ln_count); lane++) {
-			if (!dpcd_lane_status[lane].bits.SYMBOL_LOCKED_0 ||
-				!dpcd_lane_status[lane].bits.CHANNEL_EQ_DONE_0)
-				return false;
-		}
-	}
-	return true;
+	for (lane = 0; lane < (uint32_t)(ln_count); lane++)
+		if (!dpcd_lane_status[lane].bits.CHANNEL_EQ_DONE_0)
+			done = false;
+	return done;
+}
+
+static bool is_symbol_locked(enum dc_lane_count ln_count,
+		union lane_status *dpcd_lane_status)
+{
+	bool locked = true;
+	uint32_t lane;
+	for (lane = 0; lane < (uint32_t)(ln_count); lane++)
+		if (!dpcd_lane_status[lane].bits.SYMBOL_LOCKED_0)
+			locked = false;
+	return locked;
+}
+
+static inline bool is_interlane_aligned(union lane_align_status_updated align_status)
+{
+	return align_status.bits.INTERLANE_ALIGN_DONE == 1;
 }
 
 static void update_drive_settings(
@@ -848,10 +867,9 @@ static bool perform_post_lt_adj_req_sequence(
 			if (!is_cr_done(lane_count, dpcd_lane_status))
 				return false;
 
-			if (!is_ch_eq_done(
-				lane_count,
-				dpcd_lane_status,
-				&dpcd_lane_status_updated))
+			if (!is_ch_eq_done(lane_count, dpcd_lane_status) ||
+					!is_symbol_locked(lane_count, dpcd_lane_status) ||
+					!is_interlane_aligned(dpcd_lane_status_updated))
 				return false;
 
 			for (lane = 0; lane < (uint32_t)(lane_count); lane++) {
@@ -1005,9 +1023,9 @@ static enum link_training_result perform_channel_equalization_sequence(
 			return LINK_TRAINING_EQ_FAIL_CR;
 
 		/* 6. check CHEQ done*/
-		if (is_ch_eq_done(lane_count,
-			dpcd_lane_status,
-			&dpcd_lane_status_updated))
+		if (is_ch_eq_done(lane_count, dpcd_lane_status) &&
+				is_symbol_locked(lane_count, dpcd_lane_status) &&
+				is_interlane_aligned(dpcd_lane_status_updated))
 			return LINK_TRAINING_SUCCESS;
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
@@ -1569,7 +1587,6 @@ enum link_training_result dc_link_dp_perform_link_training(
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	struct link_training_settings lt_settings;
-	union dpcd_training_pattern dpcd_pattern = { { 0 } };
 
 	bool fec_enable;
 	uint8_t repeater_cnt;
@@ -1635,8 +1652,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 	}
 
 	/* 3. set training not in progress*/
-	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = DPCD_TRAINING_PATTERN_VIDEOIDLE;
-	dpcd_set_training_pattern(link, dpcd_pattern);
+	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern) {
 		status = perform_link_training_int(link,
 				&lt_settings,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index cc6fb838420e..fcfde2e04292 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -95,6 +95,7 @@ enum dc_dp_training_pattern {
 	DP_TRAINING_PATTERN_SEQUENCE_2,
 	DP_TRAINING_PATTERN_SEQUENCE_3,
 	DP_TRAINING_PATTERN_SEQUENCE_4,
+	DP_TRAINING_PATTERN_VIDEOIDLE,
 };
 
 struct dc_link_settings {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 5196df1ebad1..6398ab486506 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -36,12 +36,6 @@ enum dc_link_fec_state {
 	dc_link_fec_enabled
 };
 
-enum lttpr_mode {
-	LTTPR_MODE_NON_LTTPR,
-	LTTPR_MODE_TRANSPARENT,
-	LTTPR_MODE_NON_TRANSPARENT,
-};
-
 struct dc_link_status {
 	bool link_active;
 	struct dpcd_caps *dpcd_caps;
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 5a250f41004f..73ada16658aa 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -72,6 +72,12 @@ enum link_training_result {
 	LINK_TRAINING_ABORT,
 };
 
+enum lttpr_mode {
+	LTTPR_MODE_NON_LTTPR,
+	LTTPR_MODE_TRANSPARENT,
+	LTTPR_MODE_NON_TRANSPARENT,
+};
+
 struct link_training_settings {
 	struct dc_link_settings link_settings;
 	struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
