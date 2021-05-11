Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF91C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D0961260
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D0961260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C366EA6A;
	Tue, 11 May 2021 15:44:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9DB6EA6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 15:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkXyxFCPgwEnUi12akCXTXct3LUHWYSzqMRpP4NF8RHzXZmoggBUFf30MP+3zCzyj/QLV5khTalxUjYp1KjRGEU9f+0MdxeA2KrjcnFVKsiYSJw0uZCzagkhDayjxfhep08SMktXGSmmsW11+5isgvC7Qo9n0zvGUiaTzTgTSNj7QGPbEVszQ1+dgccYZoPrQ0Gk8+elNVfB6+waTiqzAWguwkG7u3ItOqFutGKqAut0HKFwNpiUbZOa4gFqL+x6tDPhmPmocPl/pRmC1RaNhmi3hz4DfULaXlyi4jVuc1pD+/U03D3+vl8TcBTEZaBDClrRwkzQumtqOMYD7K7GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+10VGLmDMcUQWwiQL3mqY5x9OSUlx5XogZTAkJl6kI=;
 b=YjW0RTJqYz8RDH3zUYnKtplgDpAj2cvqRrpmvrk1ewVfj9jSqvrb0yQ2omi4hYk/yup1zP1pFbCPglodXMZju3C1y1PMEhjcRr10tgDGfbJWzifBufuWZkdCZFcO+QhMeRJoaTaByajmvi1JszApWsSqQ47cN8wnwicMQHJOrL036eP0LPsotVRx44nFnYwVSuz0ZbJNqP5Nx6A2yC4LKloY+yw+GTdNg0DzaiEPmwt1SgacfZVDVA/NGM9HLu3lZiRVy6/uPQYT8KQS0EQTrZ9GMwLIYDPAWWjf+yLEjBAOfnfBdzsI9fUU7kJRjR85gFoYfjgORtdse7J0Kvp58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+10VGLmDMcUQWwiQL3mqY5x9OSUlx5XogZTAkJl6kI=;
 b=4v6TkODTYdgoqZ1+CnV/cC5unSghldTdhZ+ddBMt1/BHLKJcQhgIb4nvokFujFpMn5drLN/zdESOuY8AEeEvT0dV3R1dTfXzMrh6PO5afMKv8k3GgzYsl3sSMGrxPcNIo3CfQ4PNiCRI6j3pPR/yTncKHE7HU8/CUwqycyehK1A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 15:44:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 15:44:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: add helper functions to get/set
 backlight (v2)
Date: Tue, 11 May 2021 11:44:10 -0400
Message-Id: <20210511154411.1281317-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL0PR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:207:3d::40) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL0PR02CA0063.namprd02.prod.outlook.com (2603:10b6:207:3d::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 15:44:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41228151-5b90-47dc-c467-08d91493a87e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44370A228FB27935514B98D2F7539@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wc0jAcen9KNoxnInFpJZDt59mSJaxKpAWELPneUyywIGKjmpTEn7Ue3B5LdgnrlVBc6m8sCC6YWAE4PSrnkuI1jfsHnDjYERQPaw2EknSPMWmiwcU7Hg03R5hnHeH9d0pThaYMA9AuCwpajXPTPkEqWoj5zxvn0TZx+nBYmCiiY/GVoGka7LTOLthZkYFJ+lPYwE7oSe6e9JQuGkwaIi7Y8FPIbbefzawNdihoOCFZpHehmszRtTZ6YqyLwUn4s8AoA0AQWE7i+A3/cgZnFYyuUJM5aUTjI9N5lXOFkNsDMEcu+Msn6WFwJPqhZT421j1WUKiGxOwxoaPsFqYPLGnA6fzfMZvzvCnFdDGTxfCetkGl/SpmGDVUNsV53x2fVqswN2nzzdLAkUtG1qZINgw2GzwTNXNpJxz72r313jSYaGZHB1xxh0HiqIKOZG2j47KgXv6oVCmHIa/tjCXvmLckISdLjgPW79HJx8wzA/zl9Uqp4FUN4hbfAbT4lnvinIjmMkqYWHeAal1uwn9zseoDWGrBIPiXmwfgcEFb0h6yyAE4XY+vODU9BQtdU2vXPApmV8RS4EOC7GtOSqAriCx3O4W047MXaSgbi8QHfgbdPuYUBVZWciB1DKP19F+/08KtrzZ9QUpAN/VUmWGvGrvji7c3SfFmSKQZqU1wgPKo/KlUUS1MepnOS8Yk3+yNS8MwB2rDJuoZmMl/3Mz8njWHevLvy7NAFIiyT9bMvoZUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(956004)(6512007)(52116002)(66556008)(6666004)(66946007)(26005)(498600001)(2616005)(6506007)(2906002)(6486002)(86362001)(8936002)(1076003)(66476007)(16526019)(36756003)(38100700002)(38350700002)(83380400001)(8676002)(6916009)(5660300002)(4326008)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g02eTSCv1P5T5tvXYnsYhJQkyNkaJ4PC4VKu5BJ4ngOrGEQ4oaPYfreXjeYB?=
 =?us-ascii?Q?f1XDXVmt7wvLz1bkISIdxJtf0gqUm/MfS1RDh6Y8BtudHdUWQCgWKuQXtTwI?=
 =?us-ascii?Q?Tx3zmiCpbgUitgpsA2N6Q+wPmypJyo/p2ulb4ENkxw+QpL93ppN1UGlUOWmX?=
 =?us-ascii?Q?EZArFBIDn0DdcxUfpmktCE2VDDSC8xrR06olasx5Sj4J8I3MtSdyebb2H559?=
 =?us-ascii?Q?eP0UvchmOIxGq2FE7DzGoxj5c+fI+oYHuSIAtS4jmbk3TjVowb2/XHT0kJ+g?=
 =?us-ascii?Q?gyola2nVYp0gHxLMmIdp/+C9ThkSEwEO+jTPxLNOmVaMsNx05GLwKRlEZz8z?=
 =?us-ascii?Q?ZaLPUxQNBZmSgZ9Lf/jyNF30JOBRB9BcNTMf+sRzugO+CmdJFPxsOeXci/71?=
 =?us-ascii?Q?c8j5B2+GPflpxQ5xFEYsf6hqCHkdrLUG/qaovRx8zUQizSu60d3eTqTwcnya?=
 =?us-ascii?Q?WJBza7ZzQ7aVSv2PYVJDOHqMHUW6DIoaAyvvE11AA/B1c8bj3Apm53iuWMaA?=
 =?us-ascii?Q?ZRLaGN2W+KCCwbrhYKF2uU1tU9nuVSVUro16w+3B4LqK4Qm8gkGhHcJbXe5h?=
 =?us-ascii?Q?98lLAjGTEgc5z3cU/bk/HCt4KB6pFl8KQg5+Nm+E5R4tGa4pmZ3HF/h/jbdo?=
 =?us-ascii?Q?DAE9cIchhhwEND+nOgdVgyY8tfNtPOy92VXURSGrEC3HoVoLpjh5u4fADcHa?=
 =?us-ascii?Q?rGtTjgQxoXehdaBESJ58Uc3gbJyx3dOHYkk9VTsEvwJhCA6iuWM0NUS9XLfC?=
 =?us-ascii?Q?9w7/4Xa0k02NumGRB4QvByYwsqhMkFS//tzIvKodvJF7ez/cNmirlv1v6FsV?=
 =?us-ascii?Q?O3MA7vtD/IH4+iVNpw9pXrfttglcTSRZ6yfxAxHag6hZ7ZxsvSCJH7hr9Zjv?=
 =?us-ascii?Q?eveVNhD1+RG8Eno255kQf+IacNvgP7umfODXoPYYSut9GOqlUI8wnH8wpu+9?=
 =?us-ascii?Q?GOh47neuHKGD0gtd9Myx80b0KA8MhUBRvYWT7po2MzrNvmcv+yTYC305xzkJ?=
 =?us-ascii?Q?5JpwPQNmDBe35XkRi9YBttaPGHRElRm+Q7RGCXmsD+GsVSbT0AqGD0jg0Mrm?=
 =?us-ascii?Q?0X4cXFy4JRINAqymwPtHmtbgEo25y6330zlDlOIvhlDqSNOHJesy/KC6y+7u?=
 =?us-ascii?Q?SeHUP0CRoe9Vem5MnQHPdzxDM5uWYpMvdn3VVhX53iy575IfLs0E0enB9cYN?=
 =?us-ascii?Q?lbcNssgcN9eXmD7t/UUV30pmy2+BSmRla5kuhg5hPn+piJHjC97keT2k/o/q?=
 =?us-ascii?Q?l5LdU1FczTwjiY3orOp1gGgKqsJ76KwRDilBN7MB0bJJbr/UjFY2cu9O4pmZ?=
 =?us-ascii?Q?ZbId5iWblllHNbcO88yihZ4+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41228151-5b90-47dc-c467-08d91493a87e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:44:27.1792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBJ/cAk3+p52VJP0hrpCAqNv4eH3D+pBAn81IdzPZ15LB7oCPTlz+/ugVVa3JOBZvT4kbUfAD6orGZrTeVHJJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

And cache the value.  These can be used by the backlight callbacks
and modesetting functions.

v2: rebase on latest backlight changes.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1337
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 ++++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 ++++
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5df187a6e25f..167c8759fbc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3467,26 +3467,28 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 				 max - min);
 }
 
-static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
+static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+					 u32 user_brightness)
 {
-	struct amdgpu_display_manager *dm = bl_get_data(bd);
 	struct amdgpu_dm_backlight_caps caps;
 	struct dc_link *link[AMDGPU_DM_MAX_NUM_EDP];
-	u32 brightness;
+	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
 	bool rc;
 	int i;
 
 	amdgpu_dm_update_backlight_caps(dm);
 	caps = dm->backlight_caps;
 
-	for (i = 0; i < dm->num_of_edps; i++)
+	for (i = 0; i < dm->num_of_edps; i++) {
+		dm->brightness[i] = user_brightness;
+		brightness[i] = convert_brightness_from_user(&caps, dm->brightness[i]);
 		link[i] = (struct dc_link *)dm->backlight_link[i];
+	}
 
-	brightness = convert_brightness_from_user(&caps, bd->props.brightness);
-	// Change brightness based on AUX property
+	/* Change brightness based on AUX property */
 	if (caps.aux_support) {
 		for (i = 0; i < dm->num_of_edps; i++) {
-			rc = dc_link_set_backlight_level_nits(link[i], true, brightness,
+			rc = dc_link_set_backlight_level_nits(link[i], true, brightness[i],
 				AUX_BL_DEFAULT_TRANSITION_TIME_MS);
 			if (!rc) {
 				DRM_ERROR("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
@@ -3495,7 +3497,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 		}
 	} else {
 		for (i = 0; i < dm->num_of_edps; i++) {
-			rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness, 0);
+			rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness[i], 0);
 			if (!rc) {
 				DRM_ERROR("DM: Failed to update backlight on eDP[%d]\n", i);
 				break;
@@ -3506,9 +3508,17 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	return rc ? 0 : 1;
 }
 
-static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
+static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
+
+	amdgpu_dm_backlight_set_level(dm, bd->props.brightness);
+
+	return 0;
+}
+
+static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)
+{
 	struct amdgpu_dm_backlight_caps caps;
 
 	amdgpu_dm_update_backlight_caps(dm);
@@ -3521,17 +3531,24 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 
 		rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
 		if (!rc)
-			return bd->props.brightness;
+			return dm->brightness[0];
 		return convert_brightness_to_user(&caps, avg);
 	} else {
 		int ret = dc_link_get_backlight_level(dm->backlight_link[0]);
 
 		if (ret == DC_ERROR_UNEXPECTED)
-			return bd->props.brightness;
+			return dm->brightness[0];
 		return convert_brightness_to_user(&caps, ret);
 	}
 }
 
+static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
+{
+	struct amdgpu_display_manager *dm = bl_get_data(bd);
+
+	return amdgpu_dm_backlight_get_level(dm);
+}
+
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
 	.get_brightness = amdgpu_dm_backlight_get_brightness,
@@ -3543,8 +3560,11 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
 {
 	char bl_name[16];
 	struct backlight_properties props = { 0 };
+	int i;
 
 	amdgpu_dm_update_backlight_caps(dm);
+	for (i = 0; i < dm->num_of_edps; i++)
+		dm->brightness[i] = AMDGPU_MAX_BL_LEVEL;
 
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.brightness = AMDGPU_MAX_BL_LEVEL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c6f79c7dfac4..721c8b49730c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -436,6 +436,13 @@ struct amdgpu_display_manager {
 	 */
 	struct list_head da_list;
 	struct completion dmub_aux_transfer_done;
+
+	/**
+	 * @brightness:
+	 *
+	 * cached backlight values.
+	 */
+	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
 };
 
 enum dsc_clock_force_state {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
