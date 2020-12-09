Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E22C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 02:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F99238E5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 02:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F99238E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B716E0E5;
	Wed,  9 Dec 2020 02:07:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6C06E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 02:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvN/AeNqsDBIcM/9BQyu3+k1NhNkBT0xeF7TrA/K87eKhw4rS+R7rgFpTY6aIJPcRzVJ2wojAsD2w8UgXHt4K8f2h82azZo1L3jzRtGFFdL/+ZuWt3kJ/p0c6UCb3q5dP0oHROBByDv7pU8xbLHsKWo91+7pZMAsfV9FE5uEV9kxHvb1I4o1t6GieDfxs0xRq/Xgm6rY8tE5Z0YTW1WlpvQuBKgvjMR5zTqpZr5cH4WM7n9QW9bY5440NK6zbRLBpPH/YFRSED+GQPhe7bDz2ny4Gu9mcMhnlznjNyBuvm+2HezJVeTcZ6WxworMGRpM59WcjMFA4vj3yUigQKCTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alPs9sIt9QUT6XPZbJ9PJ8q/CpSb0C2BfmpsNxUahIY=;
 b=gC4bkV2M2KUUgETYVzydscxH7tQjXF4UeVUOWfdVpixVHQ+hjYqdYqGvDFhMuejUXPoFvT+F6T8EA4XVIBbzxNhPCkNT4OXd/+Xmjs5UFwDW1qglFamVlVTN/No9TS2Y9A6tyVsBscLfmJO7iDMDU9S+GeSW5jUYowB7KOhqPSjga4loYyZ+sYevYVbyfQHMjJeK7igEXYkl1l2P1l7ZKebSAAqEyaZNLJ82sTYWNmn6gvCr025Ry8o2GlVnVT/QIIosIkalSvB9tbb72m3tEkKGP4jvVS/Y7UtQ3ThDw6yucCWwxKSitcoP/7+Z5AG5VooTh4x6wDYAtF4MdBOUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alPs9sIt9QUT6XPZbJ9PJ8q/CpSb0C2BfmpsNxUahIY=;
 b=B/RTpW0HPwytTCZLF0IJKz8PRdimnzsNgl5Yw6Qj5tevf12O2W5jL8RCY8Ty9DR11AN9UlW3H9rblwZcXafCfQTFmdGaKAUUPBM301PIbKBk0jGEUT2tq2//mp0/E05qjeQFep83EqYyFO/wh+OFy5TytN5InfDPV2lXHC35eOc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 02:07:16 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::6897:cec8:2ff9:c003]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::6897:cec8:2ff9:c003%3]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 02:07:16 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com
Subject: [PATCH] drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for raven
Date: Wed,  9 Dec 2020 10:06:56 +0800
Message-Id: <20201209020656.7285-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR03CA0098.apcprd03.prod.outlook.com (2603:1096:203:b0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 02:07:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37f0916a-d520-482c-033a-08d89be7269e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514B1E7DA6EF71FFD679F50FDCC0@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJBRTsx2PBrKufMJQHrNEv/IIcExlDkHtefHKrWe6/0hK+XOg5Sxp037xirlojtA8ys0Jr5Brnxy3ntXYUXvqUMeKx0NYTrOoocSsGWtkHVNXml+sHvKlxNS6N1+KuOwKKLMEW9YgGWO1f1FUme8yXVCvt6sKjeGeR3U+EiMtofUlBzd/SjtsJZj4vXPTA2wm3EzZgEQoNMZFF/KDsIzzdEVmG1JOw2gz+E1kPEc7M/x0PEok+LSbcCju+R3TEmqJbTmUULUCtyA7LNkcyAbCP9sPoeN7WvQ3ve1HuTo+Yai+geZ1ARkBDuuA5Y27VuXzuwLxl6bcMwxc1PxxBqlr1k5IQ/UMHjukn2tGkKjrPPEjZ4/iH8PXbrkCg835qbH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(86362001)(34490700003)(4326008)(8676002)(36756003)(15650500001)(83380400001)(66476007)(66946007)(5660300002)(8936002)(6486002)(16526019)(1076003)(186003)(26005)(6636002)(2616005)(6666004)(508600001)(2906002)(7696005)(52116002)(956004)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NoIzeH1jChbGFe4IE19dURzR6sstVTmIHBDp+WtuQNvWmPMja/l0hPv9LIzf?=
 =?us-ascii?Q?0EP+CZW7sgE/4NjE7oYZYncMX0N3rRAb1yjxHS0fEvasmitrPJY0qhPtGRVQ?=
 =?us-ascii?Q?sD2iV+iaBlEHV8c5dwNlit1Af62/HZVPwoVaEFQ2Roth9BD6R5TLJs/KFdbO?=
 =?us-ascii?Q?3FDHw5gw/en4kfVcSqxaA1YUROLHysbLX7591G8WA3aBMJGEKhvXGJqVIIz6?=
 =?us-ascii?Q?TqE+bM90bgKHDFpJCcLxW+vHgoBKxjFwjP1DjyDsZyTItYoHqqTGILDWWgVg?=
 =?us-ascii?Q?d6jyW52wSF0TR8ilEkM8BkL2qNfA1zwjT5b1N5365RfIDZwt13pejQ3LUxP8?=
 =?us-ascii?Q?rDyO+yVV5qvDgOWWyz1igmzALeGTunURHgldYlVt19Kzi2lyO/xNQUSD/G6C?=
 =?us-ascii?Q?hvX80LhkGm3I4re1WggmpPO4pfUfRqwM8uMqAe8lz9iF0rYTqmx2MSjxrd+X?=
 =?us-ascii?Q?dINqAULJ5z/ESBDJjvjfBtZFJc2FVFIe2l+a3b9e+/GxzRBezRaQx2qHN+X4?=
 =?us-ascii?Q?Z7aTdgO18he/u5yU8qYEIs0nNCwmFK3ohQ44wh5aPIPoYc955lmLFQ6ydiuy?=
 =?us-ascii?Q?Z/IqjrAc1Bn8ZRPDFN6Kq/ZLwQJOGY42XpiAJXJOiZq1klPhPBYeH5iWbDHY?=
 =?us-ascii?Q?KR6Mw6UMcqHvfhRrO6F72JZYfcXTMqIdOHHidgYG2jV0Uq5SmE0yTUs7dnB2?=
 =?us-ascii?Q?ITtKztkfkB1t01h9AIB/K40KqC6+UL53wFKDXf6h3Giep+u2xRC+hASIrIs9?=
 =?us-ascii?Q?vNXJ9NBL54f9uBgS9J1AY71/0nQZEW3ggJ2g5Fy5rrhUMJeOpfmQ5McHQh+z?=
 =?us-ascii?Q?osLmNxadPP5jjPr1H09AFH4zfepqeYjaazCTkQ0WJhyzR2RaBrLclOL/niyG?=
 =?us-ascii?Q?BwS3Lhi7gz2L7qRVZb+pr220sfDyvDF8BM6iez/IPJAQna5J1DPkgZiKk43f?=
 =?us-ascii?Q?9hfsayjQI7zO0/pI27cJMTHq6M0Gs9y74nh+RQWGokOiW2QGThN77WknVfG2?=
 =?us-ascii?Q?eeNU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 02:07:15.9786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f0916a-d520-482c-033a-08d89be7269e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwKMmNt0PFrYrhfdRnThGhMm0ef3nm+y2B5QB6laZpcbXBZn1u7clHKwf8Ld1f/MoC145sxg7A80xS9GJo2RfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

When using old WORKLOAD_PPLIB setting in smu10.h, there is problem that
it can't be able to switch to mak gpu clk during compute workload.
It needs to update WORKLOAD_PPLIB setting to fix this issue.

Change-Id: Id2160a7b4a6cb8808d100de25e999714a7ccaebd
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu10.h                 | 14 ++++++--------
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  9 +++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/inc/smu10.h
index b96520528240..9e837a5014c5 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu10.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu10.h
@@ -136,14 +136,12 @@
 #define FEATURE_CORE_CSTATES_MASK     (1 << FEATURE_CORE_CSTATES_BIT)
 
 /* Workload bits */
-#define WORKLOAD_DEFAULT_BIT              0
-#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
-#define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
-#define WORKLOAD_PPLIB_VIDEO_BIT          3
-#define WORKLOAD_PPLIB_VR_BIT             4
-#define WORKLOAD_PPLIB_COMPUTE_BIT        5
-#define WORKLOAD_PPLIB_CUSTOM_BIT         6
-#define WORKLOAD_PPLIB_COUNT              7
+#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
+#define WORKLOAD_PPLIB_VIDEO_BIT          2
+#define WORKLOAD_PPLIB_VR_BIT             3
+#define WORKLOAD_PPLIB_COMPUTE_BIT        4
+#define WORKLOAD_PPLIB_CUSTOM_BIT         5
+#define WORKLOAD_PPLIB_COUNT              6
 
 typedef struct {
 	/* MP1_EXT_SCRATCH0 */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 04226b1544e4..e57e64bbacdc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1298,15 +1298,9 @@ static int conv_power_profile_to_pplib_workload(int power_profile)
 	int pplib_workload = 0;
 
 	switch (power_profile) {
-	case PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT:
-		pplib_workload = WORKLOAD_DEFAULT_BIT;
-		break;
 	case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
 		pplib_workload = WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;
 		break;
-	case PP_SMC_POWER_PROFILE_POWERSAVING:
-		pplib_workload = WORKLOAD_PPLIB_POWER_SAVING_BIT;
-		break;
 	case PP_SMC_POWER_PROFILE_VIDEO:
 		pplib_workload = WORKLOAD_PPLIB_VIDEO_BIT;
 		break;
@@ -1316,6 +1310,9 @@ static int conv_power_profile_to_pplib_workload(int power_profile)
 	case PP_SMC_POWER_PROFILE_COMPUTE:
 		pplib_workload = WORKLOAD_PPLIB_COMPUTE_BIT;
 		break;
+	case PP_SMC_POWER_PROFILE_CUSTOM:
+		pplib_workload = WORKLOAD_PPLIB_CUSTOM_BIT;
+		break;
 	}
 
 	return pplib_workload;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
