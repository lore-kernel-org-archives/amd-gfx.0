Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B336CC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C9420657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fSIcRfRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C9420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3958E6ED14;
	Fri, 15 May 2020 18:13:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE4F6ED19
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtFHwJ1d7kgVniuAOK6OqBzcphg+j8zQ9EjSmT2cw1zVfkXnyYybuU991E8hwYRvLnzXfgovhy2ITifbPqO6RE+7Kfad42yX7pMrZ/0qR3MdKPUwxznXv8Arz7HrvZC0tR0eNmS4ETfX+VBt9vutLsWNs3R13yi+HLyy+WMQqs1yIH0CC5c8gFSTtB5qOQLnqSzDa7qdVa9YWCkqUVbMo74yVE1IIXT4OM2djTpXAZxqVZPRUXD6Vmamd/+x3MVxd2id1UcuH7jseZCVjQczHs7tgNVTKvAMGL/obcwkN/pBKkv+4E2bHVfvna0d87SFSvl3yCMCEzGuwRlbpwAoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfvPYAfxDncgXH7z/xkXTd7RZJTvt9Oj0HjCSbydKb4=;
 b=nL6Plyn0iKpkgYIOfkZ/c+Ib3NmSd3Ucvt4bybIZz6ZiMtPRRbcYQXLXS9IHT+zf66aEZjIyWR7gf6PL9pMU1gW6whgR3JDhNFCZWgIQBVsQjTfsovJU1+YVMZtbvEn512Q9EW1OMer0MWsZ+capdPk6jGr7sBO7z/FQmt9Z1gjzcN/OZHsRF4IIXxHAs9MyjQqoJLKM7ywwEt0dFWiR3dcmu/L9mrsY7dqhoXc7px3Tm/xJ7zdemI9Eu23nV3hWipEicEWZ6pvbRL1fLqgJB4/fs0DIPJdW5Oy8764NHUsCJa0Yjfcz3vgT7Lvt3trfvYnR1NWkj75NGmF9ituAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfvPYAfxDncgXH7z/xkXTd7RZJTvt9Oj0HjCSbydKb4=;
 b=fSIcRfRe8882CX60yUBrqyNm3ESgMM8DZnCd1UnnRdMAAQwQfURh3RCCm76ONZL/Wwp87cvRt8o5K/52xWzzV40PrKly0/0JdRbbc6jugg5digRFhJSOaXc6jvlP996clzMdf8MvxuCF+xASJIZYs08LoyiHv57hX0cAO0ctll0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:45 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:45 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/27] drm/amd/display: Add bit swap helper based on endianness
Date: Fri, 15 May 2020 14:12:55 -0400
Message-Id: <20200515181315.1237251-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:44 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f1fd3f8-eaf7-42ca-b390-08d7f8fbb4e2
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974B7E4C17F2A9216CCD7F598BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDuZh2AA99r1PbyuyBhqASTGUfH2YQQMj7bMsZcc0fZJ8JiWefsJ2aztgnX1kXup07t+lezt8leskQDHLBFTBHYLqeyZOVq7UqmSW26jnzZxZaaegbyzrfvkeWQFRE742TtiKaWdnNjA+ZgJj+MQoTW5wANbltC/Zb87DYOYbv1H16OAvGKCLJOPK+6InSoIrT5BoWDjxSilT36wTlHt39BnyCKJZHqaQL/pkf8fToNDBOj3qmK82j8ccx04DZCWS3V+N+mu5GBSFjja5pCG917VUxp6UAhhiGON9rkKSG+WcS31Skeg7qlXhANM/3pXDLevA8Ni5TQHH2ubOxM+k/ZU6zieFq9hhaEZz5MqnMsA/+HiwtGHyFbbXf3D4Rf2GVo6ZI5M8O55ELK0/aBfHK7NI8UzPI3hNNWJQUDHRljWRgnlTVZuv8aHPSwhEax+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2gddtRLJdUNTW9oINFmQlo3HHDy3nuv0xofqekvblnXoLP0OUldj1ygBcvzyO9C3qX4lyXnmF+XuYEkwsWsKenpzVY83dsS6hUXrXRZqyi1jB8kOCju90yuUl14viPb984lEFMt5Qll2GaVV4dcvqvsSMbqxjexwoxR/Gq0VgPjwb8YOfeF8xc/ouT6Ac7TvfbU5vaj0p/9yNk1pvUvl7gbqWcXoM32CZLrelA5jr+qUR41eVWsx60Fpy15o9+mC1BRRVyXxF7gj6ZITY/e6FCcWhlPcjCrrx/lXT/WXccrQXYDn57Zqf/v73+c/TWO+ctrbPu12Sz/0XYjoGoPKbd1ZGumnWPFNbQnjvjHgYxW/uRPg5jzUmBuMEt85Zxm/7dQbpUALJrNXVkkxlVPPGktau0xDQBEbbmZqK/xcnHkmlLxKr37twkra2AoKeU4WdTWvbP4PfKJ1KS0upP7Hq4i1kscYwha4JOM+c5Cww1EZc8o1v4NtmVryUbbkYATub/7jh8zRMZxwYklqJEF+kA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1fd3f8-eaf7-42ca-b390-08d7f8fbb4e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:45.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnOIJPbNFXYauLsrd5EGKFS07T1mnwr4I6nSE7LJ8Y5/L+hahha8fJTyGdzwd6viM72E8ZB3N/X0q2oE9MijWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Wyatt Wood <Wyatt.Wood@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Christian Koenig pointed out a code duplication related to bit swap in
case of big-endian manipulation. This commit adds a helper for handling
this verification and reduces the requirement of replicate some part of
the code.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 8c37bcc27132..60b92f099af5 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -29,6 +29,8 @@
 #include "core_types.h"
 
 #define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
+#define bswap16_based_on_endian(big_endian, value) \
+	(big_endian) ? cpu_to_be16(value) : cpu_to_le16(value)
 
 /* Possible Min Reduction config from least aggressive to most aggressive
  *  0    1     2     3     4     5     6     7     8     9     10    11   12
@@ -624,30 +626,30 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
 	ram_table->iir_curve[4] = 0x65;
 
 	//Gamma 2.2
-	ram_table->crgb_thresh[0] = (big_endian) ? cpu_to_be16(0x127c) : cpu_to_le16(0x127c);
-	ram_table->crgb_thresh[1] = (big_endian) ? cpu_to_be16(0x151b) : cpu_to_le16(0x151b);
-	ram_table->crgb_thresh[2] = (big_endian) ? cpu_to_be16(0x17d5) : cpu_to_le16(0x17d5);
-	ram_table->crgb_thresh[3] = (big_endian) ? cpu_to_be16(0x1a56) : cpu_to_le16(0x1a56);
-	ram_table->crgb_thresh[4] = (big_endian) ? cpu_to_be16(0x1c83) : cpu_to_le16(0x1c83);
-	ram_table->crgb_thresh[5] = (big_endian) ? cpu_to_be16(0x1e72) : cpu_to_le16(0x1e72);
-	ram_table->crgb_thresh[6] = (big_endian) ? cpu_to_be16(0x20f0) : cpu_to_le16(0x20f0);
-	ram_table->crgb_thresh[7] = (big_endian) ? cpu_to_be16(0x232b) : cpu_to_le16(0x232b);
-	ram_table->crgb_offset[0] = (big_endian) ? cpu_to_be16(0x2999) : cpu_to_le16(0x2999);
-	ram_table->crgb_offset[1] = (big_endian) ? cpu_to_be16(0x3999) : cpu_to_le16(0x3999);
-	ram_table->crgb_offset[2] = (big_endian) ? cpu_to_be16(0x4666) : cpu_to_le16(0x4666);
-	ram_table->crgb_offset[3] = (big_endian) ? cpu_to_be16(0x5999) : cpu_to_le16(0x5999);
-	ram_table->crgb_offset[4] = (big_endian) ? cpu_to_be16(0x6333) : cpu_to_le16(0x6333);
-	ram_table->crgb_offset[5] = (big_endian) ? cpu_to_be16(0x7800) : cpu_to_le16(0x7800);
-	ram_table->crgb_offset[6] = (big_endian) ? cpu_to_be16(0x8c00) : cpu_to_le16(0x8c00);
-	ram_table->crgb_offset[7] = (big_endian) ? cpu_to_be16(0xa000) : cpu_to_le16(0xa000);
-	ram_table->crgb_slope[0]  = (big_endian) ? cpu_to_be16(0x3609) : cpu_to_le16(0x3609);
-	ram_table->crgb_slope[1]  = (big_endian) ? cpu_to_be16(0x2dfa) : cpu_to_le16(0x2dfa);
-	ram_table->crgb_slope[2]  = (big_endian) ? cpu_to_be16(0x27ea) : cpu_to_le16(0x27ea);
-	ram_table->crgb_slope[3]  = (big_endian) ? cpu_to_be16(0x235d) : cpu_to_le16(0x235d);
-	ram_table->crgb_slope[4]  = (big_endian) ? cpu_to_be16(0x2042) : cpu_to_le16(0x2042);
-	ram_table->crgb_slope[5]  = (big_endian) ? cpu_to_be16(0x1dc3) : cpu_to_le16(0x1dc3);
-	ram_table->crgb_slope[6]  = (big_endian) ? cpu_to_be16(0x1b1a) : cpu_to_le16(0x1b1a);
-	ram_table->crgb_slope[7]  = (big_endian) ? cpu_to_be16(0x1910) : cpu_to_le16(0x1910);
+	ram_table->crgb_thresh[0] = bswap16_based_on_endian(big_endian, 0x127c);
+	ram_table->crgb_thresh[1] = bswap16_based_on_endian(big_endian, 0x151b);
+	ram_table->crgb_thresh[2] = bswap16_based_on_endian(big_endian, 0x17d5);
+	ram_table->crgb_thresh[3] = bswap16_based_on_endian(big_endian, 0x1a56);
+	ram_table->crgb_thresh[4] = bswap16_based_on_endian(big_endian, 0x1c83);
+	ram_table->crgb_thresh[5] = bswap16_based_on_endian(big_endian, 0x1e72);
+	ram_table->crgb_thresh[6] = bswap16_based_on_endian(big_endian, 0x20f0);
+	ram_table->crgb_thresh[7] = bswap16_based_on_endian(big_endian, 0x232b);
+	ram_table->crgb_offset[0] = bswap16_based_on_endian(big_endian, 0x2999);
+	ram_table->crgb_offset[1] = bswap16_based_on_endian(big_endian, 0x3999);
+	ram_table->crgb_offset[2] = bswap16_based_on_endian(big_endian, 0x4666);
+	ram_table->crgb_offset[3] = bswap16_based_on_endian(big_endian, 0x5999);
+	ram_table->crgb_offset[4] = bswap16_based_on_endian(big_endian, 0x6333);
+	ram_table->crgb_offset[5] = bswap16_based_on_endian(big_endian, 0x7800);
+	ram_table->crgb_offset[6] = bswap16_based_on_endian(big_endian, 0x8c00);
+	ram_table->crgb_offset[7] = bswap16_based_on_endian(big_endian, 0xa000);
+	ram_table->crgb_slope[0]  = bswap16_based_on_endian(big_endian, 0x3609);
+	ram_table->crgb_slope[1]  = bswap16_based_on_endian(big_endian, 0x2dfa);
+	ram_table->crgb_slope[2]  = bswap16_based_on_endian(big_endian, 0x27ea);
+	ram_table->crgb_slope[3]  = bswap16_based_on_endian(big_endian, 0x235d);
+	ram_table->crgb_slope[4]  = bswap16_based_on_endian(big_endian, 0x2042);
+	ram_table->crgb_slope[5]  = bswap16_based_on_endian(big_endian, 0x1dc3);
+	ram_table->crgb_slope[6]  = bswap16_based_on_endian(big_endian, 0x1b1a);
+	ram_table->crgb_slope[7]  = bswap16_based_on_endian(big_endian, 0x1910);
 
 	fill_backlight_transform_table_v_2_2(
 			params, ram_table, big_endian);
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
