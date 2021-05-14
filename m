Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08361C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD74D61184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD74D61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D786E215;
	Fri, 14 May 2021 04:51:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3866E215
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMmbzY+rCYgyHrEt4OlTCzXluwSWWOY6PWrelPv4GywrrydxKUtNvGpyx0z7dbkZJho4J2cxtaJ/PnIwmWE5HR99ljO4ezuh/lZwNH4EFN0glVJx2tw1lgs9BlloolBVSB0JPc9W8skmyVf02ox6CSC4L2sy5mkUSxVQRs0Xj+j+7Qy2GlIZYePINDTRR0uff5g3eWiNC0uBFgeitmJQPXftz9akj+0EBbXpb8n+vfeUJwn218GCmIB2mn854a5ztN53Nu6tSYqWoIVdZvfMw4LAJDt+mzleVXyYzko2+Wbox/d/1V0pFjQ7finhFy0OQmqiXO/48QDfHVQKoDmwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1JcPTpFYWjwSkRvvl1iKWzCDvrTpN+5OF8nbU7Oxh0=;
 b=RcI++PFtgSnR49QyNwby/pwAfZDsV830YaEYr6UdFrnJpH99A4YmbNQqZ1oHM5PygQejbLaVeCWlzmeRkeX6t3i6jx3usNJzPWaym9+HIQAKw7pQDwKIHHLi+h7eUqjebNwS8BptojwWwDq07IxN2+EUHR7bIo0CspUqAVJbb4VtfyoQhBZxAV7s3zs9pVNB7qZ8BKTPQc8E/XtA1AKkfXDE9ao+0LZ+GSrd/QU1X70y+zrDhFiaaAMurx+IfYCLMFK7x+O18vPpxrW179tX+jOC2ilF2eONPY1s3Z1LfqR3pgxGUJS7OV21C0WF+yJ4sRmy/eg+e7/rVgu3Kk2W5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1JcPTpFYWjwSkRvvl1iKWzCDvrTpN+5OF8nbU7Oxh0=;
 b=wJ4+SKP131pzkZT+sF0wVmUyiLMoWaI2YKC95bbfNA6kUb1EcJK6FgDxEPa631h6A6fO/sx6rVX1Z2vc3OQZjISG/FyE+5xyxehYNyGsM4aU9Eurx5vm+y1LggYDLu8qEGfGE5KeVkxdrkjJkEtBB4oYP2zUijwPmCW6tUO/vXk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:03 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:03 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/20] drm/amd/display: decide link training settings based on
 channel coding
Date: Fri, 14 May 2021 12:49:53 +0800
Message-Id: <20210514045003.3069681-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41b2340d-32fa-433f-3a5f-08d91693e03d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129399B7669E86AE9B408E3FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBAH47qd1YEkbRwpEUfkMMedf6vpVGMgKnkD+I7cVDR8r4Nlw2OV7UzkeQ5i6Ix1FhJBtGq/hvWAqzCLDxaHIStO91nkShMhQjskupdsMGGU72fXMmLee5N4uM1WTeelTB8r2e6cq2itVs6oyZ791qEdarPeHmS0ZSIz7TFiSPXf+o4TtS7szCxAzZcmRZWqRHEruEHOd8MSLz+g9DS2hUzRyw46jCsTUVKrrsHTuKcoCc6ueT0Suw5Exskov7QW/LJ2F94D0HdTZbaWz4zIZpuisvBC0crln1yGXMZWIdyqrsER06EpXwUUHQQZyO2pl+3z+M8J9nVT7He9AehCDOTtG9Am5MSpTbNMCT59BSdp4BjWqCd8Hug4I7BcjiTgzQhvFzaue70TmzIsJeH24I5RERjsN7onGibYp7iRhgkcM7an8OMDHCNBreMRNqL0FTuUePhwjMZ72BnxTHYfC5rnRzLYXET6s9lKYjO4hbRflat//lRhkM1h4HCAPHCE161+EnNEZWVNuQ1eujSeB1+YfYC+bAO1HZN7duJiuoM9rIbfQ1SAPn1DdP59GTn9H1ivS2Sm1mkF4cQwYptQbdpuvM5iG5tSw/Q+JAVOhEahMiV7HGBmB0ezmS9Tb6VKZcsmsWL1UTrhR9S/zrSuakp5vhE0XWQ9vm7Gml2cdcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(498600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KS7+rVMeGeL4E1pesv5kr/IvH7W9ypZpWIGSy1ZrIMAH6gZY3m6aSMnUOXgI?=
 =?us-ascii?Q?0CqZpv4coNYYWWVPbdNRMASdJ9dxl+Cyf6LsGrkZffsKpBEbHu9n0LrVnPsc?=
 =?us-ascii?Q?e2LH2FzvQzxOBkN/78Meq5jV9gQbos0Xw9xnOL13ebb/2Tx9KVqjm5lBgLF9?=
 =?us-ascii?Q?bRXIWrK+Vo0j6DWfFGTmjDeqyqF5IFHUEfH6eRZQMMjLHDVQOoB7nBtzP6lP?=
 =?us-ascii?Q?RsV9IX55uGTumPClSsvx+74a6PAY/STT88cIGzM8SYwAXUI5zBdd8O7iTTfq?=
 =?us-ascii?Q?ykCNkkAtRKrZWsEE1Hr3LXLuniz+LrT7NEv4L2d/P1Ai3ocX62bnnarDuSD5?=
 =?us-ascii?Q?2RR+EZsy8adNW6CKZ/1nr+bWj4qJjYJ1qNlgmJ8DX0pwrw6aAK56T8Ge1RwF?=
 =?us-ascii?Q?0+hl/EAMgHGWhy3dvWmmd0/sYzXRNzE2GI7HqI+D/h8osw30JXpL7uxVpqIa?=
 =?us-ascii?Q?DnzMFRtrNKKigwhe6ZOUE9YRE/g03Q1Yi+k/gcs7L89AIpXQODYNnsRi2Y/t?=
 =?us-ascii?Q?/8BKJfXdcJmeXP9mZ4MoGi9/nMno6CjeHw3LRxtkaPVGBpdLNxXxonSMohT8?=
 =?us-ascii?Q?0F+8AmcgMXu3JgYYssxssKhhabi+Ui2qYDQu4lHrg6PZ1eti0fXvfpDt5rkg?=
 =?us-ascii?Q?Yq3gGdYVBSrewv9aFu4AXjZHXFU9DyW/doI8NPY4sreRgL6LTuqKxq/FpBR4?=
 =?us-ascii?Q?ODNIoztGn4gpQdmuNgEuGjt2nlVBM1Czw0bPfa2ra12Jl11pQfbp1PfUdVny?=
 =?us-ascii?Q?ABNcKn6hKiPadPQYqC/xWnYsWQeeEB1PyVavpa2GTvWD3pW63+eLQTdaz2Pu?=
 =?us-ascii?Q?oqm1AxJB2w9O3/Yxf7DKHhWX0JZul5K7PQc0PFrytTD3CjQTY/pNEF5ROvrs?=
 =?us-ascii?Q?XnupGI4Sau7fpLVdI9MegO7P2iNf9fzKTR+PzQ10pvKVwi/j+CiTv9YV07M3?=
 =?us-ascii?Q?wHADtz1Jtyj4aRV9GLChmkVR2BhJKxX5vW3GLGzCnQPkLXWQIr32QP+CgiMg?=
 =?us-ascii?Q?CMFOsNiNqX4JHSRdfkZ9jqbX8k90qjq/aVgbcLse7dAgeg1WSz3qaGApBLX+?=
 =?us-ascii?Q?vKkeaCT9pTc7anTBUP2tzOAGfF6ln6a3Y1VejUC/kIcjZvuM6ZyfriwgCtJb?=
 =?us-ascii?Q?8L9Mz0/A3MVpWeJSfo+z8DGRWTT8lJ5EgKWdUHkMS4NTlrEGbtfT2CRYsxUJ?=
 =?us-ascii?Q?SH8xK0jiSf3z85YDjVI5sGF+L02qSYhh8TYtcM6VdUx1/kJsp6Yh78EPoiMz?=
 =?us-ascii?Q?3ZHGwJNHyudfNTkFcfx81UH3uy0HqYjfCV12FAjTlNKHJfs8GGrRR0qJOuaG?=
 =?us-ascii?Q?KW4NCQ06WRVrVTj3otz11sfbTFwOdlLLeeJg7OVyCtPgbg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b2340d-32fa-433f-3a5f-08d91693e03d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:02.9477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqDGjj9oN618+2m49V33Xh4p3VMcZHRFfmRN2UThADlO8RHt55nqBsYiY1J58Da6jcpQX2Y7sh5hR2uX3AvOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Rename initialize_training_settings to decide_training_settings.
Call get link encoding format and decide training settings
based on current channel coding.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 396ac89a3c0e..c295e48c697b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1231,7 +1231,7 @@ enum link_training_result dp_check_link_loss_status(
 	return status;
 }
 
-static void initialize_training_settings(
+static inline void decide_8b_10b_training_settings(
 	 struct dc_link *link,
 	const struct dc_link_settings *link_setting,
 	const struct dc_link_training_overrides *overrides,
@@ -1327,6 +1327,17 @@ static void initialize_training_settings(
 		lt_settings->enhanced_framing = 1;
 }
 
+static void decide_training_settings(
+		struct dc_link *link,
+		const struct dc_link_settings *link_settings,
+		const struct dc_link_training_overrides *overrides,
+		struct link_training_settings *lt_settings)
+{
+	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING)
+		decide_8b_10b_training_settings(link, link_settings, overrides, lt_settings);
+}
+
+
 uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
 {
 	switch (lttpr_repeater_count) {
@@ -1542,7 +1553,7 @@ bool dc_link_dp_perform_link_training_skip_aux(
 {
 	struct link_training_settings lt_settings;
 
-	initialize_training_settings(
+	decide_training_settings(
 			link,
 			link_setting,
 			&link->preferred_training_settings,
@@ -1592,7 +1603,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 	uint8_t repeater_cnt;
 	uint8_t repeater_id;
 
-	initialize_training_settings(
+	decide_training_settings(
 			link,
 			link_setting,
 			&link->preferred_training_settings,
@@ -1877,7 +1888,7 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 	enum clock_source_id dp_cs_id = CLOCK_SOURCE_ID_EXTERNAL;
 	bool fec_enable = false;
 
-	initialize_training_settings(
+	decide_training_settings(
 		link,
 		link_settings,
 		lt_overrides,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
