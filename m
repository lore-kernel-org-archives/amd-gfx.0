Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A1C4332B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A12164F4C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A12164F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3AC6EA57;
	Thu,  4 Mar 2021 17:41:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA73C6EA53
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 17:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO7mLr6oE6D4ZfbJVSLNASqASS4xrDw3qQH0QhTzacmciFvpopWCmG3PrQmcTZzr4eyCqY9l1HrrR/8MCQuzgox7mzdkpDXUSqVnsoIY/t6z3p6dSqNiqO35fW8IpvkaS4cy7ELZAI/s2V0+0vln7L93On9Jd3D8yaPcA6IVyRTqEf85Psbn4jyErBZeec+epTdFXgfYvbG9pNLoKscphYf70VS9j4xtlA6n/f853xy7H4NbFixAuzq7QgD7szGdB63dxQRx8wgT5iuqEHSLcOHlNI8MgeZVIIB5p99ClxjGN+yBzy5NbRGmkf5zDRhrbdqtohlc3VzSjD0/wmTItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqcV5S6yaIaeIFKXSocPlTcyO1U9GGsP+glsCqp4s2g=;
 b=aoCyt5OOUiVIHBpXsMeTqUFlPG2AOWAQVhJGaFmqrmWGhZZy7eYo3lrqwYdBkXqGkgpTYtuu3yACscc8jukyt6gniQO1aVgX3VsXqmHtdSEsZ5jz70UgzLPa1WS09mVvVjhX7kkgniBQCO9SBHwX/x9drm9A1wTgiRgjSQ2KnCIX/PVHwOyPSD/4aiYMwJU5/TxPQ2Ls12Gxq4jn91mFHWspkpXgKzYWu7l8FZ3Oj1/IiTu/YB+GljtnsE2re6i+rd08PpsltbB/vmwOY5f/ikz7MtubP3md+PLNDXxWlXDiE74ropPgI5TpLe3la3m6gWdKmTI5n1LLrquy6+4/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqcV5S6yaIaeIFKXSocPlTcyO1U9GGsP+glsCqp4s2g=;
 b=glzTFg8qWDly96Y7RT6WjLoMJ9zw9dwB/1YXnJQrbTRN20CbSJi7WXf/CXDs/9jBshcKtIgzPhYFRvHWBg/K/ERXtj/xe//6E31CGcdsRSVJ/STNd8zbGaJGSJv7b6VsYDVnVhaewhfPg2G1/liKPToohYQJbtMrumhYwD5jMUY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MWHPR12MB1341.namprd12.prod.outlook.com (2603:10b6:300:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 17:41:25 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b%3]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 17:41:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, tiwai@suse.de, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, nicholas.kazlauskas@amd.com
Subject: [PATCH 3/4] drm/amdgpu/display: handle aux backlight in
 backlight_get_brightness
Date: Thu,  4 Mar 2021 12:41:02 -0500
Message-Id: <20210304174103.202272-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174103.202272-1-alexander.deucher@amd.com>
References: <20210304174103.202272-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To MW3PR12MB4491.namprd12.prod.outlook.com
 (2603:10b6:303:5c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Thu, 4 Mar 2021 17:41:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a12d0d35-d072-430a-ddd0-08d8df34bbac
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1341FA71CB35C555A3DEB29FF7979@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrEs6I5pRvnuOAU83beo241ooLZh8Q7XTUZhd2Bs+a2/6bqOFk8n6uIRkvvdEIrqUaGeUYoEwfYr2F4MPf/XiBMydZ2r6ZZLP79Bfm+fq2OegT+9jCzqdGdSyheP70fo2XP/HBcSvPWlTMm+iXuQuWpxFQrAxyTNph+bp21rSkP+yBxEVpzaz++KbbzYKRpWMZoFy6p4fBXlfs4xOswSw4yW8rI5c06ExJ0ShyNbZvytEiv4cc77Nr+/dhnPGjtcj5f+7Xwl3YHpnGHmk4H6CrSrZgl6YNG7dAA0fs502MIZ2/3Obq+QVidODNPtfkQXf5XLtaz7TuPf+3wJT5ExFsy5Ov4HZL9ipaXZSJQIoTD4OKc4LNslvYj5CIWw6i/yJ0Ub8UUQWbo1hUbTn0idbehWxbORgqSaabtuOZbWiH7ePrPTKdcORcNtVrmLuCQl6A0fuhYy0BiexlXbj6IrnmWmnsYz2G3GgbCK+/F7q5NSbwWOsEqptTnM/vn39jZTb2cChs5C90oRF6CWcII7ziq2YqUkDWXAwgcY+QV1rEVdvEtZBxSmvUP9MI8chOeU74tBTKPZ9817/bzWHIwo3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(66556008)(66946007)(52116002)(478600001)(6506007)(66476007)(316002)(1076003)(2906002)(956004)(2616005)(6486002)(8936002)(6666004)(8676002)(4326008)(26005)(6512007)(16526019)(186003)(83380400001)(6636002)(69590400012)(5660300002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iDSfk1fhI7DCGPmRiq7br6jMmP4U6Whf99MWcKbSGKEW0nm9fg0E/a5UkiJ9?=
 =?us-ascii?Q?MFET0nKRBwnIxxuB73XoPyII7GE0iX5+HR94lJqP8Hp5vP21ppdgF/CwMFzo?=
 =?us-ascii?Q?zEYN7xzZ3OJnM1Z2insXuV83TooBdEWE3o3GfpFzN0U+Hht7vgmXXeWP9yMj?=
 =?us-ascii?Q?KX7ZMPnbljj5dl8d0u4qKUK4GzeG1/3q3Sv3J6olxUL/q6E/264w8l7Qn1xJ?=
 =?us-ascii?Q?A06zNDFeqSdzljdn7CRolHBPW73t7FbzREB90rlX4JcrQvowUb6gQ9PMgXI8?=
 =?us-ascii?Q?3y+mtapOOJBwUEN6ko5M/biMy5F1TFTWszWB4I0ZWOjoyngvTUKB3SEzVuEG?=
 =?us-ascii?Q?RrAyLzvl5PZlj8lrVeYIWUuPniCi3iI5FzszoMJ3/dbXg/vvfGaIj6tLdwaS?=
 =?us-ascii?Q?4WjbGBDLZvQNKu1NV5+9d3pVbGeS3LLovxAxtbBu2WxLvT1nPvq41ZRH9JM4?=
 =?us-ascii?Q?3xEURgSRscQTKmQEDWNetwmgdbklHjDhisZfG3S72/TZz29Il7uhqC0cST5W?=
 =?us-ascii?Q?gyuoCCaKqXTDNBlmQxqC5vL1t92rnRNCtdBOYDpJh3i6kLHgxxPbekXzdLz2?=
 =?us-ascii?Q?fuGe1vfGlVqOGVYiKmUzD5S6tCOSV/Df/r614on+geHriUlLcFJ+rEWcCl9s?=
 =?us-ascii?Q?f69vjz4kK00MlNPMubbyTmFw1cackhEq8Gb10GZGVpqP7ayXUvRAU+opgGBk?=
 =?us-ascii?Q?K+8yT0wZ054CNTtJhDLaUDjaWaj3HCEwPkBjRjaDUOsXllQaMtOHta4CYCNp?=
 =?us-ascii?Q?isYpiDgDin5y7lYU3pclGqJOm9sA7wdi3ripTS2muTAsj3o2PBTXcGvAGQ5/?=
 =?us-ascii?Q?apsb3HXJrRFa2lUaMwmLXAhbYEUq29AKQFIrfeSVi1caGFpGgBNboDtkrMML?=
 =?us-ascii?Q?snNaG0A4DdkEOfCHGTJhuOBnCTgkeHlbX+pAkl3oiwfs+j4FSCcjZ79LRgtF?=
 =?us-ascii?Q?7wb7GY6E6WhXxUm02RGF8dZxEUwqdu4vHl7GcZjSf8WqM1IYBwJrg1X5730z?=
 =?us-ascii?Q?4fadG5ytSv2/X33AftYo27qTrDuzwv4N8FD97xs7BLdX+0GAOFDVoxd2J1I5?=
 =?us-ascii?Q?tjKfeN/WYch3a7DS3N/CThNY6fT1PhTyFWHP136LuTZs+hdq88dBGThhn2qf?=
 =?us-ascii?Q?LhiJQy9zkj/xd48T0EwprxSanW2m8S/8aHO6u4XQOild+1tIVadIHj/GLj7c?=
 =?us-ascii?Q?xvAm4/GqtWlBCQ9o73XnGxa7cri4TsUGrnI+Ngj3F+tZ/2XjyGXprMSdOGuj?=
 =?us-ascii?Q?84FngtuVFrnnualIchKoiVoThzcznB24vh64D+QTHZHCqnlHBzvlR0GdBy2S?=
 =?us-ascii?Q?eFhJKcAVZ38RfIfu3DhQe0aa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12d0d35-d072-430a-ddd0-08d8df34bbac
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:41:25.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9Bkjdy2z0DkgUt1bPiO2RAOV9nrzwuvHo/ax5kv+QumTXfrwRt+te+qZNR2zlZY6ZcrcGgnPsosH+Bqz07osw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to fetch it via aux.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 175a4cd8b982..fb1ad1426cd1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3273,11 +3273,27 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int ret = dc_link_get_backlight_level(dm->backlight_link);
+	struct amdgpu_dm_backlight_caps caps;
+
+	amdgpu_dm_update_backlight_caps(dm);
+	caps = dm->backlight_caps;
 
-	if (ret == DC_ERROR_UNEXPECTED)
-		return bd->props.brightness;
-	return convert_brightness_to_user(&dm->backlight_caps, ret);
+	if (caps.aux_support) {
+		struct dc_link *link = (struct dc_link *)dm->backlight_link;
+		u32 avg, peak;
+		bool rc;
+
+		rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
+		if (!rc)
+			return bd->props.brightness;
+		return convert_brightness_to_user(&caps, avg);
+	} else {
+		int ret = dc_link_get_backlight_level(dm->backlight_link);
+
+		if (ret == DC_ERROR_UNEXPECTED)
+			return bd->props.brightness;
+		return convert_brightness_to_user(&caps, ret);
+	}
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
