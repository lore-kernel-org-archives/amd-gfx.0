Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370F9C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 12:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E1564E79
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 12:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E1564E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA926E11F;
	Thu, 11 Feb 2021 12:02:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A1D6E11F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 12:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI4sGlsvEivsGmW4im3Yz8cAR3w3T/haW2aokmQs0WwrQTrJ9IC3FqeQffwZNuZpLnUJsVSRaEJDaVXcwZ50PKTKIKD8zxRruFOdWaqR1AUBRnqF/22FjN4HhbmUapmRZ4lCzJcVqJLbP7bb6pQIQxwAAlC+TYWLEVevcH+rxvVvy81y17e1TfvjL8GxVSDI5H4wjglV7e/CxAKezdhKHJJ23mdwX/gAc0SJYi++DrurReq9GksNPuIZZkivIq7CGv8ZWNfj1Q4in/QJN2KUpE/N71BzL1UFzGodZHM6K2pvmuaF7511gaDw+aP3bNyFEqShhL3m/qZUZhWPJsnEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRidvRJ1TrRg+OXLxZ8M57GRlEiTwNpgEYDYPeXP6Y=;
 b=WoIzdleuxz5jGXlYatKcW2CJ7pXLvdtH8ykMRjtos5w2c2WeAVfBO6yzDHvvSwzzp+529YMpUQV/HX7VotbZYHt7oRg5e0sIMTm00JTYi+QcXwQf+RudS8CmP76jzbDWkxrNZLcpCGHKlPIFXVKOjJZavftm4csxKVkhg9rnwDiYwuCky7sC4xkDrZolNBdTtZmPYEQO/sFqmiNADN4+XeO/IvntrBA2THrKVJDtLYNo22aMCO0dX8nrn7UGhd/w8vmjf7y9LnnINdwNARTL16eVDcvGge0ObLJzDAD4jJ6LbG1UVQ6WVf18KC67dWoNp9nE9YehiPbT9I6q5sr2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRidvRJ1TrRg+OXLxZ8M57GRlEiTwNpgEYDYPeXP6Y=;
 b=eK/fLOf2RnKdKJvQSrKJzWAZOexVtfDlaVcgW9orYWu/EmgZPwfs3he8vU6Vy/NgeSqv+fGllCElCqr/o/veDbGpW4XuOsU+bwxC6+iEKOxpJRp3JSBFwwFWLL4HAAIK3a3qxTyM1lCVNiAys93e9ho3+WHN4ChC+HT92045uyU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3354.namprd12.prod.outlook.com (2603:10b6:5:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Thu, 11 Feb
 2021 12:02:04 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 12:02:04 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/2] drm/radeon: cleanup debugfs
Date: Thu, 11 Feb 2021 13:01:51 +0100
Message-Id: <20210211120151.10428-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211115932.9287-1-nirmoy.das@amd.com>
References: <20210211115932.9287-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.97.172]
X-ClientProxiedBy: AM0PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::22) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.97.172) by
 AM0PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:208:ac::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.12 via Frontend Transport; Thu, 11 Feb 2021 12:02:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df4eef15-bd10-427d-bb31-08d8ce84d894
X-MS-TrafficTypeDiagnostic: DM6PR12MB3354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33542363F4C5EEBC035EA7A68B8C9@DM6PR12MB3354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYE4xNioS0LJQFDDy70r7hy5a2587ffYi9mpETvjVQ6EjjsthVSEbMA16bWGeGz3njYkQvh75Q2ggei5RxulUroSeNorPCseOHdpqGZ9gy9hztMmIyp47ASyhpqyvgktlXUo8Q6Q0/Ya/lBuUPD5EQ2rP4W4rTT1pa9Md4R4e0K4cTpB5P+xnf/adUl3JyBF8r/Wv99eVgaH7yrQDsyup9Wn8/Bws+hwjZwnW8caav2yrE98qAvjVTwSCL+mEl8sFQTc4e2NR13Q6o2VHj/jG1x70b6/iYDvi6uh0f+fXryP6v/iYHIzlraGcL9OVIpLQTXA30CcQd87O2sQyQV3do0Lh6blRHQ18BbeM5j0VXQzTppMMIdmPTmWSirTzhxZUj88HvIIJoZlOetpy8gd9hP1ytyT2o1V6KrouzS0w+sdD0gH+s8x9Qfs3+Xy3KKfGx0mFOraFVxpI+1nwDXWtg00rEOTGB6WiuWpgCuzoPo0m/lMJ1V+XwDSeWjvFamENhQZVbZlFgpO1x+Ky26hRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(26005)(66476007)(316002)(83380400001)(6486002)(36756003)(6636002)(4326008)(5660300002)(478600001)(16526019)(66556008)(37006003)(186003)(6506007)(956004)(1076003)(8936002)(44832011)(52116002)(6512007)(6666004)(8676002)(86362001)(34206002)(2906002)(66946007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cs+CNS1bWw6Sy/hqPNgwvT1gbZewbypMxiDeg16J/sVg6vEjx8TymzDEPJAm?=
 =?us-ascii?Q?hvT6G2qo38c9Y2mwNMDnPAIk8zwNo8mtFaZRFmBqs2bfx1TI9mg/zHiHRRdh?=
 =?us-ascii?Q?DdD/HyXPZgCMVm0rZJ+kLxfdY4/QmaEy7lRJ07tSDiwJgbdrOoqW85vQuqEW?=
 =?us-ascii?Q?mSsdUBVNQYNqmOOEGI5LWezgNG/T3Tyxk8ghy/N9zDEErdl5q+vXVZ6p7dAh?=
 =?us-ascii?Q?RstEPyqzqGRZdy+EKqSVv0MTHHA4pnWTA0yNox7Pwqdgfx9w7TGuUB2P54xi?=
 =?us-ascii?Q?L3ZRO8IFTkE/nt8LYecHw0UgH28eLIS7VjklYrnF0HQiy/lRcMNPiKng0low?=
 =?us-ascii?Q?9ADxmZa/U1eLRgCwL6EcV1mhNUhjvpIv8iCKhI2r5PfB9XvWfVkBgXFs2Dll?=
 =?us-ascii?Q?jscJH/vkoydHuPTTrjR+lAwbk5eTPt2tkrYNJZJDaUM4Z/g0A6DVOonjbvUL?=
 =?us-ascii?Q?SElVaV8t0bjOtLpfeJ3FsT1qk7yI3FLmi3xc/pRbkQlcfjflVq3whqCDRHsU?=
 =?us-ascii?Q?5rqGvRlnJP9x5eQr4QLQo1/yMbppZIGkOTu63pG5nHbWE0w+SgoU65yPMt/U?=
 =?us-ascii?Q?a/C0wdxLebTUTUdB9mkAZN9DZ9TEWifpppI0t8/TLcoSRHInIGjOqCYO1aia?=
 =?us-ascii?Q?BpktflLCChyy6HI9mO9i2ELb5kYIyXiKoKmTU0q87Q2ItYrVIYNPfwuqjX0R?=
 =?us-ascii?Q?2QXKd3Rl7ibvPrHdBkhh0NvzU51zo8wW6EU99wIUZ3lTMs/fHvGvklQUFn1D?=
 =?us-ascii?Q?SAR8EoViFjFdbTpz9y1AH8LvsRPj3sBqtqXEImH7NbMT+IkRtK48IoY9zZo0?=
 =?us-ascii?Q?saUp9ZC685fDt5u/EBBtkjcuZd4byYCLk7X3Igk9TRuJXDlNrLXUlbhAQSxh?=
 =?us-ascii?Q?h0M3uv3ttMxyXoiexxnhxQS4UgKV9yFg0BfEQ+qNqGhYsOLUeDrBFrMFrQDg?=
 =?us-ascii?Q?b2BbuOZs9lfyEUj76IOi4kSjg6gYWyxED/FCJUIQsnRQfOg49cog5U9H8dBC?=
 =?us-ascii?Q?ieHZuLe/HHqIgg1cULndwwcsHFzJSp7cYhjBmchAaqd56J2XG1X0HfBQdulu?=
 =?us-ascii?Q?M6OlIOi/llE9VjX4sIgdxtjbq+1jBrV9FXjWHN1MryK6KnXcYZu50vRfq8/F?=
 =?us-ascii?Q?NqTMPrxsLDAO598ezGzezIPRbrNQQuDGswkToTuK+96xrAia3aqCWOxaxs6t?=
 =?us-ascii?Q?m3W+MjR7ULrm3F46iN8lARv/R46N3toZ5UeyvKDTGYkH1KYgem6j+xAIyHx+?=
 =?us-ascii?Q?Dgts9g5+wlRECOWaLb/sL4sdcJk52bc6sr075d59RF73ON7MbBV/DJwQXRdg?=
 =?us-ascii?Q?i8BSiYtHp/5+KIAOlwYWL/E8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4eef15-bd10-427d-bb31-08d8ce84d894
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 12:02:04.0004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKYJPYZXNLynt91M/DK6/LmuF0ni3qUxsxuymqK6fyLtRskCnU7KWzEfY1a+dt9D8M+y+wlO73PH776H5Khybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3354
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

Remove unnecessary debugfs dentries and also radeon_ttm_debugfs_fini()
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
