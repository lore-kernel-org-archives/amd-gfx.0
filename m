Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA68C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B4664E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B4664E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FCC89DDF;
	Mon, 15 Mar 2021 11:23:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39CB89DDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2UGzPZzRBJo/HagH04nyq8R5VeQaF0LDURE4Y6q70yhSOsLTNqW8gzQvA/CD500tk7gKhuG6pre1MHhr4ntqnxno0i55UhzpGQCuRMMEW7rCJjrXAuAPbzsgOJhF7ZA4CwBWRpBA1jFKVsiSws5d89U6mbAgBzAW6YGmSP+N/2WfPWfVYcfX/e/ZmbED69MtpVxZEVUuB2r4tkZ0pENjlo8kfTsAIuJV+isycrxlsZTP8fxZ5aVbWX7gpbGxFol1m5O+C2NwudxX4oxvYvL04J9h9GpOefkFpFxwyQOZHlvL9x+foTG2ruijj4bxwyHdBmmzXclwPqdq3yQvAG3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5JoAq+gvsa4EOw2mhRWMxFr38sxCUy3n+hX2dFdVJc=;
 b=gcquillKM+pPLRfewDtTgrnSrcW17RwXSkHCNuzkZNfXabiwk+R0UaZ0IxAp7ygL2M0darNQ47mwipQFbLxrFA5R7jpyi9byi/+ekBPUXJybDtuIRaKDD66ipJsWomBy3bHcxPBEgcir0PT6W9vi8FWf3NW4d9/p9tEN4OiQodHA4sfiJHdjPZMR7Ox/gMNVugwZ42xmM6QJxTCKdzF1EMcZLW9dyDViE3aaGjWnitq617nuamatSw5Ic7IVmDEJ6L5kIwWxfdoZU7tA8Q/n/IFSj1R/0WE61zOc7J1KvLhlSOKq/t+kFPls9qUrpuCb0O33FYFMQL0ILHlqFGLhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5JoAq+gvsa4EOw2mhRWMxFr38sxCUy3n+hX2dFdVJc=;
 b=zrRMRewY9Z0Ze6xNzwOHgz2ZdPI8+6qXHjN5G/GvmcS3+PNRE44vaFtfTclVf/UGgHmX8Jf4n6O5+KH2Pbrf/2KySGPS2qgQhv8ZnqKDb1f7f9h+5c0hbyuS97Jdzl+l/AMOtpKlrm1/QY9ugpS2vdSFP1B+HpnGZmK/LukTTVg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:00 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:59 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/23] drm/amd/display: Correct algorithm for reversed gamma
Date: Mon, 15 Mar 2021 09:39:57 +0800
Message-Id: <20210315014010.16238-11-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 724efe2f-aeb5-4f5b-3a65-08d8e7a4b05b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617096D73D511FF02222694976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaazqWbWAJx6tC3R6ndliZrnJAat6UuzPSLtczD8+H8HW3KhlxVqHswZY2JfZMMlK9eurziQqPr+GWOYXMdrTQgG39Fe7702c/Q7nfJt8f6HE0GCZhCwpHpag/FpbfC+VSTWtB6lqlep8Hq8iuEHRkTMhqWAkyQa+LILpM4Ae7qAeiRf3bARSQU12PeZg0DyskKIsqQHh6CDuGtDT1HvJJZ1e4iYT4VL5gyXhlg20kzZVTQs2cYKpqSjBAbhD9hb9lztS2Jv+9XAe7LntyM9S8IkHsJXmrV3Qvfna6cMqANJ5DGRC8jT8AbFJxfhB60ZxGc+56SBqHK3VWJ7hpGHrYa+kMYI2Yd7q5YR//7REyhWyVtiE0G97zyNC+DYbLhBJ7mQAt9OgY0bu5th/tqs60Cj1HjZADlKT8pZxQ+RfRm/tw/Gid443FD5CAklrkHwFVZ5n627vqseJeORQ2p4X/UyaBZATG3wSjv5TyQ28u3UWhyuuxzSsDlU4ZYF4dXSDbZQlt798WkyMfVnme0SAzJJVio9m5t4mogkZyOWo77FAA4qb94Yda8TBWlzR7Vr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?749iJdsLLB/Lh+s/X34K5+7/allREAtG5erwRkPysK1VIW77JBqGGk6+N6C/?=
 =?us-ascii?Q?TNy8gh5YQxl3T91tW9SfuZi4RQLcjSnHbXqFD3zDBDvpsmHwX8vrJlCpudNf?=
 =?us-ascii?Q?tqIO9uaJskHVUq0HxPI46ygZQKWvLqX9k6+vIezqCHmIbeIXEK7AgesoHfdI?=
 =?us-ascii?Q?oXVW+9fgkB+h0pGq5xlgZ27PsljnO1drYoSz9NYnnfgdeT6qpkdbNz7sPuFP?=
 =?us-ascii?Q?D7e8OVZq4PbUnvEgyHLHYDcRdYSUqozp10ovg21InbfA11MY0xuUO3/C1SDy?=
 =?us-ascii?Q?FLjQ0IJf7qT/tMN0lWecno1N0qj8KFL28igAKn9Z90JTkY0bTp6BLtrdt1vg?=
 =?us-ascii?Q?o1cdCWCB0UK0RnqN9WFEMr4Zzd+HADK6Br7ZlmIHcDV5rqk9YyCm9FnziFBg?=
 =?us-ascii?Q?6qpQVZDdHcNTbbCo6wlmCPauHW5pFCqdUmnn7bDgz3X/uCudQPLzBo4/QKMk?=
 =?us-ascii?Q?WMbxV0j7DZP1havAlnuX5q9vES9DOLOEfmOUJ1iQ5biaG0FysHZkpdcU+Tt/?=
 =?us-ascii?Q?pwx1M59XGIiZt/P2Bk2Aoykg0DaQyy0p4M/hbJdRMa1LxNVPTwPdgF3Obis9?=
 =?us-ascii?Q?Ip1bhLKpPxaTOHJXksEw7tjdMm4JB54xEOiIFhOsA4r8OJmtRW9y8WrIQrhA?=
 =?us-ascii?Q?KFfrspyAxz/QHH+i+OuQrUeYfkoWM8e1G1hhOd7RIc0uu8g1i7Aya3hA5mmN?=
 =?us-ascii?Q?kGA7LNKHJL45Y+MRdA467fBd+PLq4+OPuA4cZeXP1wXTEiGpe0/TiwHWCBSo?=
 =?us-ascii?Q?UOJgwQUHw8Iv+btmfcVuFImdart3nVfBKNmNnVqaVPcltKBcSfkaz8P1AIlu?=
 =?us-ascii?Q?nKKuBtiOmERpFYD5mm0Oi0U/z3baK9YO3hD1WUx5avrE7RZFma0otG20BnFx?=
 =?us-ascii?Q?9uWxoXbQ63R8e+zhWgXjV7/6wHsFi/Euwi3SCVzygQq1gN7YuE0T9+kFQMxH?=
 =?us-ascii?Q?UIj6XkR725UGXPDRGtnh2LoRegEc13E9pnTkCfPVgSHwCVTZfoOqDVGL83HP?=
 =?us-ascii?Q?SvvJRJeiEgZwNw9UOADrVYg7Ifc0nF7xkw1jshp4enjSpwZUWXwj1PA3zgyL?=
 =?us-ascii?Q?FRSQsmSBzB54wg3W660XfKJvrLzqDOMc4Jkhk5gb0Q7nLPJ93pq3BVXOFHse?=
 =?us-ascii?Q?le32KQhsFVipuiDVc8hGW4U5G/Ls3Ojjv/WMxEkGAYWqyDBErPuleXsJxBOA?=
 =?us-ascii?Q?WI2/HAxeMGswEAGUTzB7Cx6+Y8PFx6YA9o0hOoWgHTdhCkA2UstcTGQ5mWvr?=
 =?us-ascii?Q?JMV5wHq6Snoqn5VJy1ILu7Z1YmGYGozFLmMgrwdWboWNaIIsSGGhjhNa+ylA?=
 =?us-ascii?Q?vUHFUo0SixdGAehN8+ZBrLC8ydKhdlt686hNKesWHtwGog=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724efe2f-aeb5-4f5b-3a65-08d8e7a4b05b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:59.5075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMAq1YQThXIig/WX44lq8b0YJF/Kpq8vkUvmW7hT6kzKzZLin2APjNmx/kK77C6D1XSY/YATqWzjGEuPVwhwNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Vladimir Stempen <Vladimir.Stempen@amd.com>,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Calvin Hou <Calvin.Hou@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Calvin Hou <Calvin.Hou@amd.com>

[Why]
DCN30 needs to correctly program reversed gamma curve, which DCN20
already has.
Also needs to fix a bug that 252-255 values are clipped.

[How]
Apply two fixes into DCN30.

Signed-off-by: Calvin Hou <Calvin.Hou@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Acked-by: Vladimir Stempen <Vladimir.Stempen@amd.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 41a1d0e9b7e2..e0df9b0065f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -113,6 +113,7 @@ bool cm3_helper_translate_curve_to_hw_format(
 	struct pwl_result_data *rgb_resulted;
 	struct pwl_result_data *rgb;
 	struct pwl_result_data *rgb_plus_1;
+	struct pwl_result_data *rgb_minus_1;
 	struct fixed31_32 end_value;
 
 	int32_t region_start, region_end;
@@ -140,7 +141,7 @@ bool cm3_helper_translate_curve_to_hw_format(
 		region_start = -MAX_LOW_POINT;
 		region_end   = NUMBER_REGIONS - MAX_LOW_POINT;
 	} else {
-		/* 10 segments
+		/* 11 segments
 		 * segment is from 2^-10 to 2^0
 		 * There are less than 256 points, for optimization
 		 */
@@ -154,9 +155,10 @@ bool cm3_helper_translate_curve_to_hw_format(
 		seg_distr[7] = 4;
 		seg_distr[8] = 4;
 		seg_distr[9] = 4;
+		seg_distr[10] = 1;
 
 		region_start = -10;
-		region_end = 0;
+		region_end = 1;
 	}
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
@@ -189,6 +191,10 @@ bool cm3_helper_translate_curve_to_hw_format(
 	rgb_resulted[hw_points - 1].green = output_tf->tf_pts.green[start_index];
 	rgb_resulted[hw_points - 1].blue = output_tf->tf_pts.blue[start_index];
 
+	rgb_resulted[hw_points].red = rgb_resulted[hw_points - 1].red;
+	rgb_resulted[hw_points].green = rgb_resulted[hw_points - 1].green;
+	rgb_resulted[hw_points].blue = rgb_resulted[hw_points - 1].blue;
+
 	// All 3 color channels have same x
 	corner_points[0].red.x = dc_fixpt_pow(dc_fixpt_from_int(2),
 					     dc_fixpt_from_int(region_start));
@@ -259,15 +265,18 @@ bool cm3_helper_translate_curve_to_hw_format(
 
 	rgb = rgb_resulted;
 	rgb_plus_1 = rgb_resulted + 1;
+	rgb_minus_1 = rgb;
 
 	i = 1;
 	while (i != hw_points + 1) {
-		if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
-			rgb_plus_1->red = rgb->red;
-		if (dc_fixpt_lt(rgb_plus_1->green, rgb->green))
-			rgb_plus_1->green = rgb->green;
-		if (dc_fixpt_lt(rgb_plus_1->blue, rgb->blue))
-			rgb_plus_1->blue = rgb->blue;
+		if (i >= hw_points - 1) {
+			if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
+				rgb_plus_1->red = dc_fixpt_add(rgb->red, rgb_minus_1->delta_red);
+			if (dc_fixpt_lt(rgb_plus_1->green, rgb->green))
+				rgb_plus_1->green = dc_fixpt_add(rgb->green, rgb_minus_1->delta_green);
+			if (dc_fixpt_lt(rgb_plus_1->blue, rgb->blue))
+				rgb_plus_1->blue = dc_fixpt_add(rgb->blue, rgb_minus_1->delta_blue);
+		}
 
 		rgb->delta_red   = dc_fixpt_sub(rgb_plus_1->red,   rgb->red);
 		rgb->delta_green = dc_fixpt_sub(rgb_plus_1->green, rgb->green);
@@ -283,6 +292,7 @@ bool cm3_helper_translate_curve_to_hw_format(
 		}
 
 		++rgb_plus_1;
+		rgb_minus_1 = rgb;
 		++rgb;
 		++i;
 	}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
