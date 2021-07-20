Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C9C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B2E601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B2E601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A776E446;
	Tue, 20 Jul 2021 15:44:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C056C6E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr3x5SZgdm6nQkTVdO7pMlJMr5Ac8DHmn6T91H26bzKqc2ZFuDE06TtFplLpycxVnvU9/v7sckPpheCTbpa9wVn3DOo2xB2Yw2x5Vs5O4m5Zr4fTSz0siKZSiEZ2Xyefhv/WP0Opl+km/kYwFiNb0skxOIeGoXPqysei2uSmqEFDm39FQt2Czmrc8K72cXa1h+hZhFVO+F6AsBv5+1x6UkfefrsE5n1dMHaKE43X+zRHXq2D5qAPVOxfBD210JCV1CsXOgbPwxBRyAZKOHHXPC5N/OtxqNw1yI+1Ura87srZps8gt5i6/hLCSBycfglWUrwp9TekD2v1lYVA76W6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jund4FEo+Q/BmT5LdvXWbsAeLC7tylj5/tPtvze0x58=;
 b=Fj0nQXvG2osCaFMFSL86a3KJOOZi4idQQ2UzjJtwIIjvbykHtPxdndmb6Z1Yvr+wxl+lm3UvCXwd7S2UwonkIp+sNDxNJYOwP8G7DSnHijLBZIMraiqQOUdu6U9PWPChuS/SthSeoDhfu4aFCZD8Kqp7IduaYqlxVrs1UWMYREijzLj+hBdKPRsqqKATV5aSufBwilgP3G7lZbwkZVzKpGOtT6Hd8V+BgyJFHpzETj7SYhKMr4qTUHQAMtVgmVc4Q7LbzV94r99Hw9QaujH+gXSuNNNUcjffT8oUlWv/L88CXforkvpmsb5C2azm4shcFRo9yqa/QbO5QIzidOCsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jund4FEo+Q/BmT5LdvXWbsAeLC7tylj5/tPtvze0x58=;
 b=GYabn3D/8J31HL0My9bSVV0LVQ/UToz0liuu4ZTfxCWPyTcixJQXCXVaZzC/pAqaCD5niLxJR8n1fan/0NEBzJ5pc9VmOeU14mLQbU3il79PUVpSFuqn8C0HxCmTkGlkg9DnxatGt2cDpCC9xl5g+wjAU5kKYFsVxoniEMAOjV0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:30 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/29] drm/amdgpu: add autoload_supported check for RLC
 autoload
Date: Tue, 20 Jul 2021 11:43:48 -0400
Message-Id: <20210720154349.1599827-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615919c9-a74e-4925-66be-08d94b954338
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB553859382647DB8ADA74F8E6F7E29@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMfKnDLdNSwjbQrxXfnACWNQaMKFx8Q//WqAniEmBhnGt0qHY6dtrbkrycoS9W1BNxNk/jTiHseuXz1Idd2bYUVKgVGeOIEqwiq2hfHdPPFB84ewe+A+JkBUmrnQpx7MikCZdRCSTUnWY0OvuwS3ORagITZu30ypr0+af2bPbDku2/RBHVa7cUTnvkwC8VhKflfssDeMOLUe3EuQk8G+ztJdF/fKeZG33sNTgnOAyR8Jh7jDyRfp5uIzmuwiHTX7IxIABJRq6cckF1fRn/PcPsgmV/vsCk3V0npai2aukJIuaUUAok8AMGYe2RhtJlVHBzBLmErAHzr4Yuf80LExpRJ0FijMFtDFKFeTgK3PJK5/MFMyEEgr/WSj+XnLM8xlAOhBKUa7/YAZKKgk2XtWF4kj4c/0Xo+HYklWhde83NuuaQRVwGMd3AG/82+Garp7yyRn5Y9URjRmSqD2+ajwk1rNuPy7B1UZXRITBjNZwSLw7grq7CphYZ5oKj3nuLBu7vm/zytdHaxkfLe9MQ0vCCp+V/zv2Hn7v7csDt9eUFUx2S6/eva9d0F460g8In6t/SsBUsqRKSQA/i2eU9l++XhcyZ2dXni0qrpUS9EMXBqHpxu0tWIerBfz/2q2tYHzszRzj/HjUMj5T26M+SdYDX9D3u23UZ8OszKKosmsx31NgXo9e39sw3Rlx+aRswofs+BFd3059MFEy3+jaOMdOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuTUDCG/JXm9Tnt+gZf2nHA1LZYJgDMUl5Q4YCzGjADtIU3GUkxa0zDcwRU1?=
 =?us-ascii?Q?2QCTEsnOFrvNyA3xykOlKOb8gerxEkarJb8r4PC29XBEd0amkN37PgK12hzl?=
 =?us-ascii?Q?fAFM+AMWx3FyX5jf4c1sL7Aie4TijubfDcH5lfy31Ovs2cweuEqep4pDhM8y?=
 =?us-ascii?Q?yP8G03pGBQQKm0htn24539XF/xvo5AqeFiB/xeRuU9MSFvHYLUOMtVivQdQz?=
 =?us-ascii?Q?MOyMQz4vtShlgbVg6YSF12930owbpGAwoc49Gjy/PySrlT6HnxNhqzHzibkK?=
 =?us-ascii?Q?tuvuS09DLn8FG/1Q5RiPEPqpZeUivTMWLMiZ0qC56TEuYLVumdAHZwyIm1DC?=
 =?us-ascii?Q?xz4qOOmpwCN2sBl3rf8mw7K0uBIQrMJBEwBLlYVGstAQqtBwVicN1uZ9iaFH?=
 =?us-ascii?Q?ryNcq+LYxTB7WyOrt2EqxQ2JTmN/1ELpzgZgM/YEKzrIJ6AvoKFxkOjcJZ2b?=
 =?us-ascii?Q?uj2ToESQZt861jT90sXa5KtTGnZoBqh5eDNO6rzzMlFJ8c7C4L3jhabI7IXg?=
 =?us-ascii?Q?+0nFbwnQzO9Wf2EADvE3/yZODQiGLFbq82EFjnM6BjMwChm0HEptE+JlQ3kA?=
 =?us-ascii?Q?aa9m+d+f6scNlFtW0+dX2WDbJvPXf2n8lpk5Fl1myRdcvvJmWhEcYb4XpGA5?=
 =?us-ascii?Q?MLGTZnZ0z/pwTBo4123Iq58lXrP7IURNLo7qyub/bR2/68awUVLLvwZJZxFE?=
 =?us-ascii?Q?Plh8ALxeGqGjcoCaw5t8Ac+auSOVyJDgildir6HxtG3GBbax6lfxTG/FCUW7?=
 =?us-ascii?Q?MMZ9IZ/WZYqCBuoamrlKKU875XIVYEv7tOoq3EuUZjbpbQKkByYlTvxXD/AF?=
 =?us-ascii?Q?mG1yA6ryTGK0hNnwzl08TmrkroMM2l/ke4AIgwfcgi5FNoYrzN1Ekjzh+rip?=
 =?us-ascii?Q?qU1SfzNmFpnnE11cNabxmsk0jaQZ6ueA3wfQgddI7glzpSMiFfpD5fhbir+E?=
 =?us-ascii?Q?8B6RQYXIfi2ZtrTT3EJZ1FzNdZ6IwOxsNxbBkttu3//81xwd/ZjSRs259no0?=
 =?us-ascii?Q?7J8i/NYBWskWx2XJeGLhUMhBHD1kDM2Byxy/LTXiva3MVbNOa2zloFkgc2Zt?=
 =?us-ascii?Q?pgQgvSW9Xr9yyalM/m8PHjr75L/jkUP2zH0POf2YMzhHoQX5X7XNvefy91f3?=
 =?us-ascii?Q?WC6NZLV0n4ZhDolGaKNSDKEaX6cGLxHZ7DTfFMraCkb8AbW33+dy4RC/1TsR?=
 =?us-ascii?Q?cVS5GNHAYTpbs2O7cGrCSf6Qt03c6MFIgPRRhSXoTkQIApY0UULZ7XS5KxOn?=
 =?us-ascii?Q?bn6K3+UmWwJdO56vINxSxz/Z34+PwDcTUPHyReAoDcMSu7IjugBQue4wortZ?=
 =?us-ascii?Q?D9y1weqhPlZycdfW3SWDHlbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615919c9-a74e-4925-66be-08d94b954338
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:30.2652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/EdhnhgvprqL4JXs4N781lG2+CyFhBy7lNcJ08SjgC9BYDcdZCbt2yXna5dwy1IFffj9nRMaiJfhv/VyDzYRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Asic cyan_skilfish2 won't support RLC autoload when using
front door loading. We just use PSP to load firmware like
gfx9 here.

So add autoload_supported flag check instead of just
checking firmware load type for RLC autoload.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b91f9ad911ce..4e64b92c5e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5418,7 +5418,8 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
+		adev->psp.autoload_supported) {
 
 		r = gfx_v10_0_wait_for_rlc_autoload_complete(adev);
 		if (r)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
