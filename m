Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2ECC47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C2361C21
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C2361C21
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3BF6ED22;
	Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FC86ED15
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwU44tm6BQ6kDp52SciV4NoKB5n8KPcxYjjnCvWOm5bG/BNz+8l5oeDPy16+fA+G/rUjzu2cVyVBm5+HTiX2aoLQVcFstICMIcV3FTN2R6dTUVlCaGb0wX4XfBKXHO097BIWlFx8d6+br5egThYR0fsxyH03fYCj1uPvldcz0wrWTXQVg3EnI9Eu1DiuBDrsfErqBvF/KQ+k/UiiZdsEw57qHOAePSS3dn8lSGgQcJS26QUTZyeze4J6xHlEHKZjzo0+i72mu9ZrweNyFxdZYWHF4bX7QecCn7/fUovhLUnTALiYwja5uCVcFVLj2eyoyzBx0X9hKKEXBvvY/A8wBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfmPv30ZgrHVd97tFTUPDVe6vJ9tVHYuAU8HNK1JYCg=;
 b=QOpDsMqS9E+jXJd7Z5eyD4+fdvCGCjsEBtrdp4ddkcOzlNNX5dmJ+WBkrma+/s0s5m+FvQnlMJg+DeHo0F1cVbD3tqklS/zsTfwU8CukhM9hxNUDXPR3Ay/yZ1mFt+bGEjfPjRQFrKnUrjRxXHMOIfa39xQZi7wYW9rxO4WCb01Qfnvay+bR8aEAM1d9HYGpE0jDEDN1Shuzz0rBn74t7IR4H91CC28mOgSOcZzu3KZfSJqt+5PqovSGxxQ6fmzCsv+4WRstd3uArOSY9SQ8iA8Fx3q8XmVi6feQ8pMBg/xC2CQ1TPKEKwlBkQDRMTrrn9eC/z2HaRGVstKWtmf6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfmPv30ZgrHVd97tFTUPDVe6vJ9tVHYuAU8HNK1JYCg=;
 b=jVSjKG2YEyLIj0ZGEDcHUMBak9Vp0hOPJIVkole/4UjV8bRu5x+niAhncrxP5BZB7GVpFknK+rTNJCKF83eOhupfctq9bO6Rnou2myEhGMdKZ5MM60kQ5jdh5cm7QD4xpcb+yuxi1DtCCMPOu3OSrellkyBxqcbDn0mWsshnb6E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/89] drm/amdgpu: add yellow carp asic_type enum
Date: Wed,  2 Jun 2021 12:47:41 -0400
Message-Id: <20210602164908.2848791-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 286c71b2-a878-41cb-4817-08d925e663b3
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675E2941D9B8A6B2EADAD77F73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d19K2PaPEorKP2p0iwVR3IAI8gSZoDR8or0Wn5J5rH466X97FulNvfh9/LKfKTV7G+uVaShZkmN/eBbmOGwZ48Ce/00r+9asufXgZHqnjLUuBwvjKWTwPbT/oAPoRFxa/3IdhdXprkN0UaegWDQHKAeB1hbCwZj5wdTDQnqfW8P+FX/7jw6b2IABohIj138tg9mqZqCOdKYvuIHDldspsUGcaCUBYP6lAayHysKzAIFnuCbNU44Xs3xu7zZtaO5UqrwW8j76T2hNMuYLPBNjzviBoy059Orii57otQdxDm8IUDaRJhT9VdvFux3zNjwBwfF6ybdL5gVXJA5cD/TTlBpAJtaUjCWz439MZ9My45/FIVmaqU5j24gZWa9ukszDg7bcThX8lF1EZ3sHDcDTy47aDLgTnJF6qGfIZr2PPR/pNkd5ekBk32SyO3gMhHn+8kBNu40x03y59LPswZMU9fCh5ZGril8/r2Tw13mfDUFiPI1FZwh92CqDF2ozuuw8DBxz2SF8xLF2UhDWcgG7OArpk1Vu+7iGbAJFZ0LQsFsmlQG1B+P+PXXcfgI/k4JYlVNL44Cs48JONiHQ58MmeLoYoH3vwN2rwX9CNM2q8F3GiwZhhpumbyEC/KIbbWrMo9BkzERMvhlk4cBgXpZ8Js451Ys92OiOzz7BPMlK93WAxfJ+niiY7Onbr8e1lpLs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(66556008)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tQDCJqPdneSW+VD2IR8ULNKj250UuzXZWt7cPKayL/Qe4+S/j0Ts2Cef5CMK?=
 =?us-ascii?Q?wINhXeA5oNhtroPCfyO6AmhOzlvLeCXFkkj+N/FX5sL4rUhULeS4vbbPrUmK?=
 =?us-ascii?Q?S8xYMI83sZO829+BEGQH0OeOAvadnJs4Y/6G6/EacyeTsmjSDHiO0aOmG/Bw?=
 =?us-ascii?Q?Iqj9oZlFwsxk+nmUAV8zbnFI/j+a9oCMRq0y0eW1E1Dx5m1Ksfo/jAWdJ2k0?=
 =?us-ascii?Q?pGLmjIe76Q7R3PPw0rVetG2Q7bcCLQzTwgARuSOkMEWcMPI542sBtEdDc5hD?=
 =?us-ascii?Q?BaunsDr+K6jGFIozAhJ6nkFrwafGULIopJntHcUi8KexSUMgWFjz/QW2NnEJ?=
 =?us-ascii?Q?t+I6a+kAKMHXoI35lkwRzQHQ5BKC49G4tUvciJxaHavo0DTv/d4eALVVZFVE?=
 =?us-ascii?Q?afpEwq5Ke5XOGp94BFVym6i4tEVjqFfRJpxJXkFbC6m79ZBDGUVArE0sbd92?=
 =?us-ascii?Q?Ry3hg2bdQ4dpDRx6UwyGdaA47aqlxnbRoMLWO57LEWrzTzt1LFsNT5Qtgvfe?=
 =?us-ascii?Q?HVPOz+HV8abAms1nh8CdDy4R3e8GOhbbUn0qmRr8evC41P9LizxgnYgCRm44?=
 =?us-ascii?Q?n0e6+7JFABDlu8JYqOhNiZC8J42dLr2GT2dJRLinGUHOtpWtoNkkueYCLSgR?=
 =?us-ascii?Q?3iWW30yqwTAZIqMvDGH6ua0KXr/RCZgOfnrua9yvMf2Zd8X0HkPjH0UoLMZp?=
 =?us-ascii?Q?fUYj3zXeoKdDyZqlDDJmfFMT2NrjHIfQOETLXTLZczuPJp5YPt/iqTNt4GUk?=
 =?us-ascii?Q?WK60TzBZUkzK0dsMWJF2Ue8qx36Cr3mr4DJCQvi0X8V6ZSkY32AsYt0xcI3j?=
 =?us-ascii?Q?T2NJtAlLHGuifFavY92YmLTd+va89Fh0pESdRT0vVlVlwL9IZ/deCUCA9En1?=
 =?us-ascii?Q?ExpsdnVkJzmhMcGHOhupCsNIXThmU99jGnL5YBZHVqb7WEhuFnzS3+lzzFhg?=
 =?us-ascii?Q?0IBp+tNX+waqIVBv9LyC4TpcYUBG/K45Dzm/LGhYckxL9pwlPbj0oXhJ9XVv?=
 =?us-ascii?Q?TvfUqxhPs3KcLAq778yCA9fPPxdA8Z1nSdTvhdihQ7lNUroBYMfjjOIiMQi1?=
 =?us-ascii?Q?A3/0OJ9v+PCaiWutiErF7BhHLdari5aOVIrKne1sUOTgPd5Jd8thT+38fNt+?=
 =?us-ascii?Q?1N39XxzlCF6rjxZLtWiFh+Zrda2KezcqkAcQ8NUKpgUcp83aygGQeH468hMA?=
 =?us-ascii?Q?kL4bv2D2NWa+NR/NYwgn4uEAADquzfi9xOu3ejodMkpJDXgN5y2lwj2qFVJG?=
 =?us-ascii?Q?IsmX0ayD8AS+qhrUqyIX/fPo8Z1G7x2l6Z9XAbJbqa2DICFtc8IX1qz8B8BU?=
 =?us-ascii?Q?u1cpePZ87Hkm7LIF85k6nS1p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286c71b2-a878-41cb-4817-08d925e663b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:29.6827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZBJVmYnT1+Lc15YVRJFVJXoTHS+YQ8jmPi2PHykZaaHD1t6olHdXM45t0hovcfUyCCsVMj029rQ0ei2wtOTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds yellow carp to amd_asic_type enum and amdgpu_asic_name[].

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 include/drm/amd_asic_type.h                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c465db47aff..5db997a09bbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -120,6 +120,7 @@ const char *amdgpu_asic_name[] = {
 	"VANGOGH",
 	"DIMGREY_CAVEFISH",
 	"BEIGE_GOBY",
+	"YELLOW_CARP",
 	"LAST",
 };
 
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 02f703ec4230..0bf0ad869eb9 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -60,6 +60,7 @@ enum amd_asic_type {
 	CHIP_VANGOGH,	/* 31 */
 	CHIP_DIMGREY_CAVEFISH,	/* 32 */
 	CHIP_BEIGE_GOBY,	/* 33 */
+	CHIP_YELLOW_CARP,	/* 34 */
 	CHIP_LAST,
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
