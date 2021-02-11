Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1581C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 11:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3EF64DF0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 11:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3EF64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC186EE08;
	Thu, 11 Feb 2021 11:59:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3593A6EE07
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 11:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8dJrT/EqPt+bK05eHCFxCSJ1BYUqb2Ct6l8QUrELCT2I4lJVtIaDOYCIQgjQGbKNpf3noG0RXTgS3fAaSzikzX6iA1REPn/YvT/wyy6d0rxO3aokSDOT8Vw4sNNKXVn37QP7BjAMcnllN0pRRV3Q5wQ0B8V4iDWgTrYfzFeRuAE+fDFYIcWsEHB/sh976jhxTJDLGHcrTZ9SyA2wmoeoSLJB1fSLXDLwSImVjxalcIAjQwn96xymYk673byIF0he4m5px0V74KbWkrj0cOq2Kffmcb6h7tFV9NYRlmtM+d/xxstqsHqvt1sxfX5b9OWW24WCIcLw5cxNpZb+v/FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRidvRJ1TrRg+OXLxZ8M57GRlEiTwNpgEYDYPeXP6Y=;
 b=GzTsi7pHqY9Ff0rEKXd/gV/oxQknbENKgIYY84XzqL1B2Zs+aogLZ6zSXV3PiwEmIzXMtZdN9uREmGsXykUOHZ2aZcOxBV40H/Vx5KbIQOVf4i49c/TNj7hK8ompaib21PfgJnzzUm8KFqCBYUkSn9kl2CtBKoc6Y8OmctABRg61hmy9UZbI9N+zDGk8bN/fCqYeJnm+5eiEl7xreJzzgf8FkqamQzVo+8w3sj9ID0UffxDw1JwPyBvFyEFCKWZl7ts+kG/i+OqHZ5t/YT16J18tVn3ZUzKuf10zaQSZq+Yf5H/ny9Dkt4qh+6xStuufHxe9ifdiOO6kwAv7OlY0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRidvRJ1TrRg+OXLxZ8M57GRlEiTwNpgEYDYPeXP6Y=;
 b=U9IDX2otkQUd0nbyZBLxNXJCu3qWZvcch8o5YP0tzHe0PyFUsuw5ZLe8VDntMH7jgrCSAKQX84viYGwAmgfjpvRRd9MsPACdAXexcNINZBmlTxiyxEsXl6ERWepvYqXsSogVFxuuvQOmWZbEiA28QR0K4DCual/+Mv0US0NHMT8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 11:59:48 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 11:59:47 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/2] drm/radeon: cleanup debugfs
Date: Thu, 11 Feb 2021 12:59:32 +0100
Message-Id: <20210211115932.9287-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211115932.9287-1-nirmoy.das@amd.com>
References: <20210211115932.9287-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.97.172]
X-ClientProxiedBy: AM9P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::31) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.97.172) by
 AM9P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 11:59:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 221a039a-d469-4484-38f3-08d8ce848781
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB245645A6B2A04C347D8159068B8C9@DM5PR12MB2456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQvctYGW7hZUYX+I73/y6R2DDmA9sZIYzrFjUYmqXw53UUso6k7AXahDjnGYF6B3TA0ejmeJc93qOyl47kjOq9MHcTS8fJvPHWtMfxKYRLxXH0SYMFpWZl4tnifqt95P4kZ/0xpP/FD6tj/tBFe3V7bAATsH1zGD2C+lpBY/F+aupOMFXqSnGql9Ws9qaqvVbzy3JztXx/DMgc8KJ1ypqwhn50u8OLYvDX1qExSXED0g0J/lb+rV3PpZ0A4c3/9DWWcYkbla3tJ/ISC6HWjmzbz9iD70L9dpju+khQn9vKmsNYRaA0mCUEnwAq5lGazKU5nPVhLrsQ1eCEIkdZXJwF3QJuKekqU4ZNt63PQoE62WSie2/+PFferXcyPMsRLlhfxNBVlt2OexcMpM0pY9PSEHu1EQZ0wVLnH3/3Xr/zzZsHcLuECvf8oOAco0CJ9uCGk08bS5NR7SvGHAk4zjNw/5huCw2g0BGF2iRjAXw8BvJmpi7frR/0b6ePd+pmH28SX8b/+ZTR2awX2wHdM9Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(16526019)(36756003)(186003)(316002)(66946007)(1076003)(6506007)(6636002)(6666004)(6486002)(26005)(52116002)(8676002)(66556008)(6512007)(44832011)(86362001)(2616005)(66476007)(37006003)(34206002)(2906002)(8936002)(956004)(478600001)(83380400001)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zFbuU8NjvJKTquf0y3dFfF4sH3HaNfdCOKJ+m2YHCv3FxqiDozoXMfk3Jk/Y?=
 =?us-ascii?Q?BzB6BiEqBnEdy3ga48YYL3YBrLVOmy5paKDo/DR/y48RCru3K0bNviQm2wqR?=
 =?us-ascii?Q?TSjatyvV/xPl0d5ueGTV7wTF9I5sGo1rAjZrodq1bsNCE0P/1Yu1M0iMnAw7?=
 =?us-ascii?Q?gA4GeUFjqq1p//6bPZYShjggOp/23ddUJKfqqoZDASOz/H7n2N7CZjylkxYk?=
 =?us-ascii?Q?p2WQcWB2pkifoA/4iEdScTQ2gjzTuW273nheFdQprzFAanU0ViEvS505dc0q?=
 =?us-ascii?Q?p/AgqGW95eC35/wK73DnKWWrUnuAbNkjdIVphuf6/UCg/cwYP1xlOp0kUHPc?=
 =?us-ascii?Q?kzUMulwjxnYEcoYw4qGUpGYeialNNJ6HOe9tSBqw70Z9ourB3jeeEEhxbfPg?=
 =?us-ascii?Q?+6MsffmGiftoDa7G8lHPsBGgAY27DSjFEx0VPL93lO1DwUJYVDK1or5n2tEn?=
 =?us-ascii?Q?RgG6j5oXEh2YdHPjFRBtibbzi6RG+T2kAhX394mSgNlKXNLQA35d689BxTbD?=
 =?us-ascii?Q?F1fbuNSUgO/FMniGNSG5IbkhblUP4cBNxMLX5cVEzwXmCo0Rgb3qveZOmbKc?=
 =?us-ascii?Q?qJytTkl1Bqp0MK5/+uGX+VuFM50GGu4JG9a1sALtNJhYgGfKp7rGtEBLG60J?=
 =?us-ascii?Q?A+HEA5/vFEO2VsoR880RlCrf/rX4dljCX8YKHJIpMOPPqZkArOg+7Wi4B1wy?=
 =?us-ascii?Q?LdJOlBQu3+b7c0gAQ2oF8m7o/8twGKwwjmYHEd/Mob5mHOvmfnauTYSCyaKs?=
 =?us-ascii?Q?Sv6R53RYi/pQnQdwI4d9GpPfWulf0T8bmIUztsyRAYtuHVJjG1Y75pyICZP6?=
 =?us-ascii?Q?FU/CZCrOEeSghKKmOoov4kqXO+n4EAUxdV3Lzek+nBUWyIukNmGMtgyNgcb2?=
 =?us-ascii?Q?oDyWdEF2V1EBhF1WJCwawfNIAt+RSC5kr6+FsBo766elcHiDPgfo0JDlZroV?=
 =?us-ascii?Q?xRb4iFNKhfTonSTUvRJVKtmzO6zDQkNjUsm86LtYx/SQgcESauTEKaaPwYxK?=
 =?us-ascii?Q?CQEw1o/SeXri22cplQSvarJF6YpvNgq8PohIeLbcnepHy0aUnv6LnmMMmx7N?=
 =?us-ascii?Q?IToC6LiAnvf4xrt+Op39aUOvOM+1pnq4l4SXKLS6Lh8FvKENer2U3RLPczBB?=
 =?us-ascii?Q?c5Myk5sYh6v4apPUeZ3HPAva3MYqygyC7J7xr0anocLtVXU5wVjDLC32E8TH?=
 =?us-ascii?Q?g2juLfCso6Y3tiwU4Fpd1YkUydGL+6NPa7U1pamZXd6LH3N9qBFQYUdK5PZB?=
 =?us-ascii?Q?T8BIyZxffv2IRZaSajJHVi6Dyzz9v9uah6WrjGNB3eaGE1TPKSiRrIaP5q9p?=
 =?us-ascii?Q?uCVJUHFpZflm/rYSiwQ+6BYq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221a039a-d469-4484-38f3-08d8ce848781
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 11:59:47.8742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kMowlEBRMCd2qVeCnXVEio9/1m7TWuSs5GmSMclA2ziYditXtgKVcxSTK82YoZnv0Z7nN8+NEMj5tsaRKNm0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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
