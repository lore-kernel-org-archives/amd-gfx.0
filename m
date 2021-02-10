Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C223AC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 16:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8579A64DAE
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 16:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8579A64DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C866ECA0;
	Wed, 10 Feb 2021 16:06:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3476EC9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 16:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo7gG4TiPtORqDkvNJpnLXrwUgI5uOhhKIPpPutK2iJFaKBTBRf2/mIIrAHK2X0oRI3CwdGh55FGRMARMZbvkJl+YiG7QrsS1YhklTYJUgXbTKavoXxfGz7t1g2+MizoYPaulu2ZRY+m98JgZFJpcchBzuW/044yxvEDcIKa8VtPPJJYVPqyXKpriNqQ271ME+VkTzRRksPv6qrsGL91yvbSByFpKuOad+XxyWKfJzFYJhcOCqDK2PofRnESF2HviVB0rKNDtJyrCMw+kX6HsjDtWLWnaDqQdsq9Sw00dZ2TPd56EOIfxsjFDPxDjqw+m1HJR7nWfeTmY0j6a4CjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXTfH0jva9CKoOK/lgLR9xQ98ouVB8M1IL1y/XnL5Iw=;
 b=XTCPud2/trqqe63spKkFBm74fTzj/VpyqHoqbjJjShoqOoq+X14VXN1fqApcCG5Gnta55ImbTilC3bM7HRecdowa0Aq/VHXqTJMuyE26dfpgdO/vKn1vC95xWsGOfxpeLt32zdg/pa7avoMb8p1zlJ6RmmWds6aCxISxCS5lnXJ7FsGfglEE4ixz8rr5JQ98oIGcCnc+KGGx25/2lodFwIMcajrex5UN+BZLXuw6X6cxIQuzp1UpknNX+nyyjMRwh7EzRDLnPAu5M/qpVbDnPG1y6tMu2Qba8zYZHflwPePg8f1ebPwuj1u59Itl6UpboJbxnI36O0wm3tzTMf2i5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXTfH0jva9CKoOK/lgLR9xQ98ouVB8M1IL1y/XnL5Iw=;
 b=uoFtZduAujW7q4ImLtjDF6Jq2ucsUPogsa6wpevC6LDi2viSGXSRVXmYl5iqiz9e4TJe7B3mWkpInOPqQH9c8BEkLtaoffDm9O/Do2SUR34I/JxzeolhMOJ0tW76WIg0jAgYdjkDxrGlJWmW/H5WWPfk+BbZ3+m2TFcEbLsxyqQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 16:06:17 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 16:06:17 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/2] drm/radeon: cleanup debugfs
Date: Wed, 10 Feb 2021 17:06:02 +0100
Message-Id: <20210210160602.15903-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210160602.15903-1-nirmoy.das@amd.com>
References: <20210210160602.15903-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.120.56]
X-ClientProxiedBy: AM0PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:208:1::37) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.120.56) by
 AM0PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:208:1::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 16:06:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efc71a55-a8e7-45b4-7579-08d8cdddcc0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4138C88DC6B4D166FE4210228B8D9@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pf2V3xI1vbaBQ1QpR9UVw1InqBPLjjaTg7yvWxtaYfOdcoAwX/JaWA9oa2YhEbcKoAWiUITiYrC3xM4f/iBQ7Xabhe11+dZRu8/FOQihlrYuA6p+t4aX8Bf1ZBQzqXnD4jlwH0klTeptmuDo+vqJIYN5jQMsoYrPWXUZY25WRzjkTCobwoHe+CafQhFDNPuYMdFojA2/kQPnOM2E+sxcDyc5qhg3ED+1QeMQMYgS0LtJnY+fo8TidIJcP8TzNZtySTDABhF8yZrJnKx6Li85ijdmk33Dm7E9JEg6FjwrJR44bk59OndWwvukSsbMx7gx1/X0Ng37ZRSAAxMVOP4zENv3z4a+JsNukMCStdcph+37M+hEX6/yVo6bpkdN5PgXxz4SQW5xogEaNVS6PjUFipc2x9vRMTcG5GYGa0oAed4/8ozpe5/DvaY1rrV3xK1T/SCo5oAvSC2X8H9+Sz1ii4397EA4WzhW/O5UTgWDjRjfy8uAWhH4I23UJqTMnhrslIbp25rZ2Ikt0RN+vaFXwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(26005)(83380400001)(6506007)(34206002)(16526019)(186003)(316002)(4326008)(5660300002)(6486002)(36756003)(478600001)(6636002)(66556008)(66476007)(66946007)(6666004)(8936002)(52116002)(6512007)(2906002)(86362001)(44832011)(8676002)(37006003)(1076003)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bsbqsY6+b+N5wql4gXQhammowk0FybnoAc9XvyGqQHECO8bJEwRxZhghuYSl?=
 =?us-ascii?Q?G5Xne37AqevTQ32MCQ7NGD6DiBeAOeqULq1upX5tovej4rkOoFvBkxlTQZ7T?=
 =?us-ascii?Q?rb/yXAKgtOTjRZAFD+WBOXdOuRiorrmzNTGi7PfHVrXL/Z/RPuwLC8dnd05s?=
 =?us-ascii?Q?DrhbIUaa3Ss6DOLZhDc1SJWYiLgX8bf/Xy93mU/of4mCEOUxFOSd3qr5ZdS0?=
 =?us-ascii?Q?GaWFV0emLDSxVSdvu8e0VDyQrs5Xd1Js3g7072Lr1DEHfwbJ7TwhlXRoOohl?=
 =?us-ascii?Q?xUEraAsWGvTG/4jwvA+pI22Qg+Loy+ysiMee5sUs4NHuxRO1wALr2Q1ID9Hz?=
 =?us-ascii?Q?gQNRbx45Ru+M43CsClYOsyWCvc4WlnuLykO8ABwCyyF0s+9pYSvQ/5o4bQtW?=
 =?us-ascii?Q?6Q2ZQWVGO2UYaS/0pUGtuok5tgUvAfznLfGSNZDNvN1nKvM/l3tVwy2/HEpW?=
 =?us-ascii?Q?Qjn0ix3neQA52MD/loNlEClxlKrBx6t7btNzHcIHmM8dDvt8Krltrnjarz6s?=
 =?us-ascii?Q?olOPsUZ3uz0IUFhgsKSDTXgp3WjAvq2rq1ymdhM2HLxzY4IrP0RkNitf+unX?=
 =?us-ascii?Q?aux/Zx8up1cYq1CVlkNaLqpSw75N343Ibo/Gftxi1AhytWJQOopySrUOeiMj?=
 =?us-ascii?Q?ofxmQlqDIcKEnx+7OPPIjdhqb56Y67o0o8xxZ5JElhpDhL4j4UbUTtuc+g9X?=
 =?us-ascii?Q?V3SH1H9MrOnMaq+vsMID2juXgbrv6LFF+nw4ma/uRR5loyIEE3canSIED4Wt?=
 =?us-ascii?Q?DIrKrhU7M6lESpZyuiejk3fyozOyZWPY2wF2mbytUhIw1fRdkqVs8J83W+xE?=
 =?us-ascii?Q?OKCrIJWPVeS3qDneLiMY9lu+7WaEn9oChPlT2CO2Us5Q40vXR8OV7KmKdEBw?=
 =?us-ascii?Q?edBWyODNto0O+wNhzBLrn7Ppyw658iy08PrQsrSK/x5nMDRkrc80qDFwhgod?=
 =?us-ascii?Q?u9EnqWxGnn2/u3EwqNsCRPLaSfEo1YokTQJg3WtNfOT5shKWIdllGXstqUqA?=
 =?us-ascii?Q?1rEakXyzj073PGUYlaIAzM1iiKORysAH4sTCc4mSPjOxGlKzKFucl3jA7vrG?=
 =?us-ascii?Q?J55wz+7Wmf5FfzndihJbzWniBmOzc3o6uSdqMsrY4knodlHXM7XG5HeG1gHf?=
 =?us-ascii?Q?mAMbiR3YQwKJdXHWDjFx4sbnY+LWUNae8+Kyf5a6/r9vJht46sDAFcwc0DF1?=
 =?us-ascii?Q?1E3lFb4+8fN8IQcvjKhbJmk0jZvqJdu0EZMsF2GQlZm7ZThaSFNwMi+7tJod?=
 =?us-ascii?Q?60BZXnsrJDLzWmEtL9HfjxDEVc6I1uknQWaBWo1lwWDziUkwDY3yyxbgV8ne?=
 =?us-ascii?Q?qLqDoySvE8RxkzLpCiZz4pcd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc71a55-a8e7-45b4-7579-08d8cdddcc0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 16:06:16.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gsrm9WTjvzlrQ+oj3Pq7QkgXcGVJwmCN6WP2Uh5ZOp9ZsKwiy+wzD0SoOA5x6MXB/fe66rVby0+yC08AwOzMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unwanted debugfs dentries and also radeon_ttm_debugfs_fini()
as drm_debugfs_cleanup() will recursively remove debugfs files.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/radeon/radeon.h     |  5 -----
 drivers/gpu/drm/radeon/radeon_ttm.c | 24 +++++-------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index f9f550784590..2c0e3e7c294d 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -454,11 +454,6 @@ struct radeon_surface_reg {
 struct radeon_mman {
 	struct ttm_bo_device		bdev;
 	bool				initialized;
-
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry			*vram;
-	struct dentry			*gtt;
-#endif
 };
 
 struct radeon_bo_list {
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 46bf835284f4..9d156b12d24c 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -55,7 +55,6 @@
 #include "radeon_ttm.h"
 
 static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
-static void radeon_ttm_debugfs_fini(struct radeon_device *rdev);
 
 struct radeon_device *radeon_get_rdev(struct ttm_bo_device *bdev)
 {
@@ -793,7 +792,7 @@ void radeon_ttm_fini(struct radeon_device *rdev)
 
 	if (!rdev->mman.initialized)
 		return;
-	radeon_ttm_debugfs_fini(rdev);
+
 	if (rdev->stolen_vga_memory) {
 		r = radeon_bo_reserve(rdev->stolen_vga_memory, false);
 		if (r == 0) {
@@ -1009,12 +1008,11 @@ static int radeon_ttm_debugfs_init(struct radeon_device *rdev)
 	struct drm_minor *minor = rdev->ddev->primary;
 	struct dentry *root = minor->debugfs_root;
 
-	rdev->mman.vram = debugfs_create_file("radeon_vram", S_IFREG | S_IRUGO,
-					      root, rdev,
-					      &radeon_ttm_vram_fops);
+	debugfs_create_file("radeon_vram", S_IFREG | S_IRUGO, root, rdev,
+			    &radeon_ttm_vram_fops);
 
-	rdev->mman.gtt = debugfs_create_file("radeon_gtt", S_IFREG | S_IRUGO,
-					     root, rdev, &radeon_ttm_gtt_fops);
+	debugfs_create_file("radeon_gtt", S_IFREG | S_IRUGO, root, rdev,
+			    &radeon_ttm_gtt_fops);
 
 	count = ARRAY_SIZE(radeon_ttm_debugfs_list);
 
@@ -1029,15 +1027,3 @@ static int radeon_ttm_debugfs_init(struct radeon_device *rdev)
 	return 0;
 #endif
 }
-
-static void radeon_ttm_debugfs_fini(struct radeon_device *rdev)
-{
-#if defined(CONFIG_DEBUG_FS)
-
-	debugfs_remove(rdev->mman.vram);
-	rdev->mman.vram = NULL;
-
-	debugfs_remove(rdev->mman.gtt);
-	rdev->mman.gtt = NULL;
-#endif
-}
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
