Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892D9C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA1B613D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA1B613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD0B6E133;
	Wed, 21 Apr 2021 07:27:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5420B6E133
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 07:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drEvDR71iGdQlKOpciIQcvcjXHaTZu7YKq3TjrGO/U+oxZAeUjwaSDH0ptB5MvtDQ2ha6+ZNJ5ws11ZN9pDm04zO8YRsZy2Hkubv0HNw5KytvhU8qBZ4ZeHDkHOxEfcNxuxSi9Y4DWo+vvPLmRfWfmbZF0McXZrD6HB8A1oHzZYqXmgt5rNg6isThmIP6TujvvLsXhttgcDAfFgPFl/KwxmihCL86WS4X9lDQsRfSndGys95NOFE5To9GnQlAjJJNa8r2G0vChU8UNi4sdzfIyfRbpFsEoox7XGnkPd7iuLgsixhS7B6Q6qHAjdnoPTIcChD31TgYCRCkNxkqRepPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj0iEVtr7QHWx3SGvRl6pvp3topctPzQa0bQTiwFsOs=;
 b=EWY0r+o3LHU6YqccrFmDQel4/G7KdPStrI3w7VTxq+eiw15FTpysjQCnOMT8xiBxsKeFbaAclL47UmhTdi5VLLqQHOWZshSCxrQ2AtbGZgXaSuE/FFMMixDi9nTUb8UH7RlIeGkRw5gLpBIZtEoXgr9GFgRZC7hHY5PPZ2wwbEug0X1d5SHZNtqnEBnVqWRajH5/XBZRbq1Bb+fH8FcQHoGrGIpVIk4zkforOvRbeEdiGD57ZfD9JzUPbV6aPHY2Cww0M4AYY/zDR//mupaFcUrNogPCve+zviYP3/8ntNGFVTNmAnFHyukI4SGPbWW5ZbYNrr6TerpUrFkroLZAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj0iEVtr7QHWx3SGvRl6pvp3topctPzQa0bQTiwFsOs=;
 b=EUFLiZ/6aURYyNCsSLXyRYgEPaQHjvvLgP8dwruXaidDC1djAOT9aByK84ZqgQ/kakO291OTY9fo5m9DVzcyqc9CZMshiA+kiazdJo3cZOU0wIAVFWNS0tweM7St9B9R+cK/YI0o1dxdCCKwshCEyXaEqRwxxfxuPXCn47W5onQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0237.namprd12.prod.outlook.com (2603:10b6:301:56::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 07:27:48 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4065.020; Wed, 21 Apr 2021
 07:27:48 +0000
Date: Wed, 21 Apr 2021 15:27:59 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh
Message-ID: <20210421072759.GC404763@hr-amd>
References: <20210421071250.795910-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210421071250.795910-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR06CA0017.apcprd06.prod.outlook.com (2603:1096:202:2e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 07:27:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b68688-c361-4afd-c1c2-08d90496f688
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02378CEE5B4D39C0854108A6EC479@MWHPR1201MB0237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qg0YtV++k1aKrlkaGAxWjSLt+Nv+Wx7AXkBtqyyt7YfouopLR+ALiIyBCnAZs09jIB0FosD+oeFMpSoNCtPp38BZhPilaHooTAxnVejF74Po9AxbzihsBYKvesIxUDzjz2eVvbOdrqOJB0+UCVXxyIx+ihlQbU9HRmOcMjhrdTWnshGKL+G9wdtvym6xA0soQ3bh0lU3HN80+XANXPkY9w6lH073KXsWrzNwCCVWgcIAs9z/qyB5qED7bwWGmOhSuZjkvpptKAtJomnaaryOfDVNZNhuc9eqydX6HAUtSXfJsdTFFXWIM25kSwJZdVNLzJXQHqMI6ZFzdYx3d/SNwdnLKaQMATol5yUPnFOYcCSYTnQJfUZ+PsLgpldQWgXiGUa7KSHK+pAcaIFK7HfpV70r4wJspwmSX32TDORsYtKAw1sP/mpRTi53PXz14yu9u1hNjQONT7i5X3EX7Fc6JYbK/5hdk9A6wlQboBtN865aPwF4CtnuQfUGa+dn1P0KtBnR3RgVCQli36BPOAKe9NhbhTsFZF1xE39W6Ltf4x1sHbU6h6te+UH0YnbwbblIkjBS9CNsuVQATJXqn+HtSRow3B5CiTc4smbnw8U4Uyoc3NMQBxfp0x4dEj3KwR73FgS8M9Yn6ALe0ywJE0TT4bLUhwWliSdFLjQPN0e5ZMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(66556008)(66946007)(38350700002)(38100700002)(33656002)(956004)(6862004)(8676002)(186003)(5660300002)(83380400001)(52116002)(6496006)(1076003)(2906002)(26005)(6666004)(66476007)(4326008)(8936002)(6636002)(33716001)(316002)(478600001)(86362001)(55016002)(9686003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/juW87hXBHpJC0ifxfnJD0ndsI9XQC3cux+MYJktFfF+xbMsTv3niCT0Wp5g?=
 =?us-ascii?Q?YiwH5FRYJW1WrUawGalEHcRf0CfUtuZfszz3gCuoo48gZjVzXDzM3oj3oSZh?=
 =?us-ascii?Q?9XsxKiyp5ApyKFnmuSGLWIjNBxeDkwX1ipGSXP7q/X6NYhXHjnAdzYkWIqnn?=
 =?us-ascii?Q?IvQZqcQUIevbqbFTO/RFihitHkzwZTr0A+EFDL0E6awyy1jw9S/Udr9Rtz4m?=
 =?us-ascii?Q?94m19qvWpPtbWoY/WUq68PsMTrufN/IuWIjbgyRCrNCbPQ0i0juYb/18W9lT?=
 =?us-ascii?Q?5dlrnFZjY/mlo+1RghWptUj53iOXQ76Pc76gg9ucX6HQPXeC82lO2tlzWk63?=
 =?us-ascii?Q?ULja1Fl/N8lq6Meh1bjZgzmPYtOnnh7HN60nDKB7zmMsEx4KRs23PPO+Or4+?=
 =?us-ascii?Q?hrk3Y5O7y+1Rg4vp7uImrgInCl5F8rwTAmFea2WwUbY7T31M9n7orPEtBi6K?=
 =?us-ascii?Q?Cz1to22UdkUnT0WdlPQjR4dzpZkYKkMDy+UhWogZdmnGH1+BBWMCdy1GYySj?=
 =?us-ascii?Q?9kaytPgdP5pO0ikEKH1b4618+baXXt+988vGfZMp2FSbAXD/z0xY5z+XosVj?=
 =?us-ascii?Q?4gUYfdqAikupLsxots7N6dPOhALvv2N6oQexbMljcyMYZwA8OxGXyAc+sppn?=
 =?us-ascii?Q?k7CGOm7aSgdEZgs221Pz+6sbjAEjEZlXHAZWaGBF25rCydWPzVgUaf2CjbPn?=
 =?us-ascii?Q?N37tlgb1j2TXqW4EYSKe2Nq/C8hzMzBgs/uu2vGMu2i48BtnguYw5dY6Cb9S?=
 =?us-ascii?Q?GGnMMyhvLpy3QeiPI5llOV1cA88nmkqIA23XsC3LokdWmWKPuAi2H3M9ktUw?=
 =?us-ascii?Q?EwWGbjzTjsZXTOQTRkjs+64Z7eereAwFz0WQoPaGaF5rL+xRrtVmKV2/hRhs?=
 =?us-ascii?Q?TYKpjAZSx1yx8mhoXEtL1/vrGkNA/EbP9ggh7/JyajUIVis0cTfN8h38ful7?=
 =?us-ascii?Q?JTxbaw3pAcFZRI42epRTueIB7oNhzNrDVrtElst65QhtSh67Capmw8pxJYNr?=
 =?us-ascii?Q?ZG1L50ouaTM83xY+NTDRBOkOydLG1TT9byP7qfyq7cstKzY6vujyQ2FS5vzq?=
 =?us-ascii?Q?YtwG8zYw5zNx2nc1xWC3fIZBEcX3aXLM3TJzYnqLqj8u9NeMmqWPI/B9SWhY?=
 =?us-ascii?Q?lVqOMFCoLtyup1WEvn0bGlg6Ft95bqRx2SuJaumZ9NnKKdIGDlOf8gqrHW+k?=
 =?us-ascii?Q?IAQRXf+yDgM2cK7Zn1kzV7aPsI2dzOnlqL8lJ6Pu2vaLpSEKFSt7MxcTkJmO?=
 =?us-ascii?Q?EbRvLaKNRRcswF9/bNEINAs+xHb7t1HsRcvENZuRTa7JckdSpFZbSnNzqJSx?=
 =?us-ascii?Q?juEMwiodY14zaN6f+XgKKjZc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b68688-c361-4afd-c1c2-08d90496f688
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:27:47.9548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsk8GXrRpPBpb/As/YTswZu3XSwjBIwGS6T9Mkn7DzWXfTsCwu7uLv9zBG9JDZkvute/45ipR1x0W5zHx2a0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 21, 2021 at 03:12:50PM +0800, Su, Jinzhou (Joe) wrote:
> Add flags AMD_CG_SUPPORT_SDMA_MGCG for Vangogh.
> Start to open sdma mgcg from firmware version 70.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index d54af7f8801b..0142f6760ad2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1118,6 +1118,7 @@ static int nv_common_early_init(void *handle)
>  			AMD_CG_SUPPORT_MC_LS |
>  			AMD_CG_SUPPORT_GFX_FGCG |
>  			AMD_CG_SUPPORT_VCN_MGCG |
> +			AMD_CG_SUPPORT_SDMA_MGCG |
>  			AMD_CG_SUPPORT_JPEG_MGCG;
>  		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
>  			AMD_PG_SUPPORT_VCN |
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index b1ad9e52b234..4ba7fce4c0b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1556,6 +1556,10 @@ static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *ade
>  	int i;
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> +
> +		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
> +			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
> +
>  		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
>  			/* Enable sdma clock gating */
>  			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CLK_CTRL));
> -- 
> 2.27.0
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
