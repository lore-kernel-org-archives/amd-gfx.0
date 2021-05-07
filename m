Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7187BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0511761451
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0511761451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983036E578;
	Fri,  7 May 2021 20:37:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB2D6E578
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 20:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czZXWDP9KHpFzqAMKbjOZOPJvH9kTqnm53fVIMHLQKWI5H+JShlPBT6KoKdNFoWBALJzsmXuzFfhUUY1bChhqXXoFCt4p0EXIb2MWwG1kvGluQ9jacn0dTd0UGh/R1HGp32UcSvjfsU00YVm+MqX+GM151j3ZKJYIT2HhBXkKRMRWdfu2G8wH651qU8Wphfq2KQJ5k606aXvKsWE/hXh52Ge+X3gamASLyj8zISSFOHgnsdGuSFlZSrKz0p5baUeW4exLAIOdVJt0XUhXKegFVyCFD5wPFZ9yw44hzHJYZBIhoRRowyKFeZVZeIrsncsZt8XKyk597FgfYHL9JM9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Ftyu8IafbUbd1wDd42GKpEeahnKDWSbu7WNWwNDcU=;
 b=LTCwgSVgOPEH0bCLgi3vg7l39CenvrAXIVSwrX8Fp9OhdTtCdg/A7CyJLm/ts2Mg/Rq9TZ6omWvItgcT4pa9rj91GVxHuPlbHC/o0A3QsdpakltZt86Yk/8v4bc4byF3m2beuXnZWvLyBIdBpKs+agspchs3tionyEqDWekv4QmP3LlrrQgdCLh7rwsTZ8WGVEv198JA8OTryLXpMVJxN3FMQ3CImFkMaRrEMT8Ii8EqrOnXCjRfitO9riHGtvTJcR71RwwMRShfcZyIq/rqOdGTFp7+8vn0CAehSqyB8KhkIdmOgzV/WLN9lN+aSPzePOqgB/AHu5ed1gaObbew7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Ftyu8IafbUbd1wDd42GKpEeahnKDWSbu7WNWwNDcU=;
 b=d9gZAorS94R5H631fuFbF33x5XcybbFHzcXC+dt2LvBeoGWS39dbQc/hhLR8/hs49+NxPzXNB1U7jyGxdy6V+oz+X3QFC3UtNOZrHtRQyYYf/hSovNkPSKWkB216EIRh3+VhywWx5UrtRiSoBTcDsOGE2iZuEP9Gt2JIdSuWcYA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 20:36:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 20:36:58 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/display: remove an old DCN3 guard
Date: Fri,  7 May 2021 16:36:40 -0400
Message-Id: <20210507203642.552770-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:208:234::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 20:36:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17300786-bf38-4a84-776d-08d91197dc0e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3869B5EBA2490198B70F7724F7579@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUxLqW2Ea1Ecxn69lA8bRceiTQJEy7fIEJWJ0YNDPLMELIc6xPoRGDvq3vlVoikGfvFDEP7H4SeV4gACaEQW7n+V0pGshSeQUxWYcNn76Guli54PQ1SSHNm+z0rL+mLlwNOQmwYoZwHteIHHX6djCJhkjrbBSZHsaEz/2cNWgDetBhNsZoRBzB1G0judfMrUYT0gHHHygheF+9PTgCieDxZ2d1sdXafkj0UrLuy9+a2BSOVvLkI7JT+XnwhCJwiDH/MSYB6AZc69n04lW3IRor/66/inQQUDf2/e5ImHWjTA/WqvcClVFqlTwQHaDjn1MEq/BUYcsMZTkGqfG7xIvk7eN/PPJaf4NJBgS4Ycd1TysPhQyukj9Vpi/oYUPNjgEm8imVpcctVXJjAJn7g19rqctQ2EgPO73wIPdruiELi9nNZ0M8Qvqjnr9YH325K1csRsYEJsbGd4qLYrvUGrz5CyNerZFA950NDMs2m888RVHBTUmN8sixsjI01n/4ZqHnyTmPPitFaH0PkGAIhsVYb6267KDvEzeNRpHW2YLI7AZBVbRjA/ly0jqgzuJ4RCwXRiA31BHTaqY3/N/QkJgeZHSeeNpcyBOxk6NzJNeJyiwCKJO3U4Slo66Xg9ZbKAgWL7iPpS+yH9BZL4cGxmY6iBqEROsxKSSyRT9KtVRFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(83380400001)(5660300002)(186003)(4744005)(8676002)(16526019)(26005)(36756003)(66946007)(38350700002)(2616005)(8936002)(52116002)(6916009)(86362001)(2906002)(4326008)(478600001)(1076003)(66556008)(66476007)(7696005)(6486002)(38100700002)(316002)(956004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BDzr1MJ518zouO5eWmyZNMGVoAfSinAftnFRlz9F3IA2RkMzSSpzaO6nVdhY?=
 =?us-ascii?Q?VLnShBg//S29xnf2Hj6csA3+NvTYrcKT1KDxgTnEhU4z9q2FaHVg0VG8ZRK8?=
 =?us-ascii?Q?nKLiz4MLwEC6GfcSYJlXvpmEr1Oo6PZrGbYwsC4v+RNFXaYlkKtKKQKrlqF1?=
 =?us-ascii?Q?B/fqRM/a9yQ2dZMDlUEJixS1mxLNKPHVFHGNGmI6A3TNkUB2o+2E2AIqFZ/a?=
 =?us-ascii?Q?4OVsTRLLWu+YlhgplioqhPNOZvG70fo6QSWdva7g5+eq4vefZdlu1CIBGXfp?=
 =?us-ascii?Q?nNHYnQJzcCSVEUsg1PU6WhcZD2fu/2cfluCWGbFuI0FtZulURE+pUs3NcUIP?=
 =?us-ascii?Q?MZsdsKfRVaokkRR9eS1kUBg7c0CIYMIK+5pMjXqqkd5SBNHfa6mC4nZewIQX?=
 =?us-ascii?Q?5DLsILZAEwB8bK6nSNschJMthAChGqKklXsliA8s9U1LEqxyxChmsMWX8MaC?=
 =?us-ascii?Q?yp1ccgmNo0KbelqdxrN1eyIVwzWytD+PNSivSshCoN5Cjez5IMXXhCrES6+g?=
 =?us-ascii?Q?Ko7i6yC1IY/drct8A42LtSh0MZg1mNh+Uw82D6LKk7sP6QtGND3UhQxnHDeK?=
 =?us-ascii?Q?xbyWrkcXYCCMDC3Wd+GuAUmXog2OWetGS4BVkSc6vyoTx+MbuZvTfBETHZZw?=
 =?us-ascii?Q?wiBBOVqA4DS9Fe6syit5XG2720AjbF/jvJhVlJHe7uQwhiubkInbkxD//fji?=
 =?us-ascii?Q?c3+DT2R1HeuSaiPnXfHKVHo1orqIgVZcVoZEyehPKbk4vjj1eUVgiLC9DUZB?=
 =?us-ascii?Q?46hvO2Siwl15v6JkF2zkAxy56w8ARke9cSw7nqazR+2t0ZzqS9Ilu0hzqWzv?=
 =?us-ascii?Q?Jjx0/FDf/tMeHi2RKonurLEGMNfWxjX5vptRw5UIybe4kneOZ8Hhu0/atAQy?=
 =?us-ascii?Q?nWTSUiOEhIJ3P9BQGVrpvljasL/VfmpM/9VNtJdaFlWVN1yPYv9pg+AzwktP?=
 =?us-ascii?Q?Z3axwPycQ8qBvvk1YNW28Xs+ShAR1I0WFHKaEl+7L/aYYT8GCGNMtgZST2zH?=
 =?us-ascii?Q?xgxROJ70mSRgPAb3ZlALgT76710FcRIN7nSvXQAk/WhLKe8tx6hYVRCAe5me?=
 =?us-ascii?Q?hXDxroT2SFDmhqXyiNdzQmjZAxadIsB51NCmt2uCf1dxrS6Ae5wf6APRsH9w?=
 =?us-ascii?Q?M3Y0p5BIvV/vuy11X2fvtpyBhRbZbAxawGPBJub0ONfplVuHsj1t99mvSE19?=
 =?us-ascii?Q?DQ5ddLigV51H/UwJVkKbEExY25roa1dNkuBx5GlOgVyRO4zdYn7/kBMhU67q?=
 =?us-ascii?Q?6EOBfRdCFQCCzjxw70NnGL9gvt0vDitK9VDT0pcMjC4AO7mAHKJcLwF5Muj5?=
 =?us-ascii?Q?ZpNAloVOZhkK5Q+YQNvbTMHR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17300786-bf38-4a84-776d-08d91197dc0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 20:36:58.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofU47ObwRQedTgd2b86kPUGVsoyct3btNquo7W4Q0D9kp1ApwLiPwAhtrHyqHO7KVy7HoZRVkgbw/qgw/QBH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
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

The DCN3 guards were dropped a while ago, this one must have
snuck in in a merge or something.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdbc577be65c..73d41cdd98ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3720,10 +3720,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* Use Outbox interrupt */
 	switch (adev->asic_type) {
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
-#endif
 	case CHIP_RENOIR:
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
