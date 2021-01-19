Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B4DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 03:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2671222257
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 03:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2671222257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13D36E1A2;
	Tue, 19 Jan 2021 03:38:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1310E6E1A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 03:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfW1xYkwC29QXWlLXQkIFx5ShE99h2wAPUNXopNdPGx25g4zX0BnYHv62CgYi8S/OULS2UZQ8u5EQCuWlCx3e6op8TbJQafuJt97nL2suWah6GZj4IvfPVtHPB1/6VIXYl1xjOYrPSZkK/a3bi3XmgxfCSRJovaqSExsZXAOJvz+yYa/OVvaidQgY3CmgrxG2ZLWFWe+3vvu31BPVu6bUiaom2UhlY840AynDvx3WqEnL0H0Lkwy7jfQnwWk/HhWyG7NDqVHF++NQQLLd6uf87u483O2gY/f8Ez/F9RSZKqDBKHeFSp37c1mwTXjAJYmQkg+LPV+XehniDij/kASnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkUo6f+w5r6cAth5weEaAeCq/KsW8QvnowQjm+wxRv8=;
 b=joYdyi86UTKizG3D49CN8O23ZHrtqM4aoVC+25iIi8Yl/gOq56/vVUv25jOthIZHiq5BqE3cYUaM3sSbL+X66AFv7GHXkz+wJbiIzyru+Rx/rPFSco3KBgJ/FmHVDHPJjGs+77gwPVdzXmme3C9wZskF9cwpCc4O/5ddRPxl1G5VQuvEQjdckoTTu2QG68rqj28LTRMS5I2G2ftWntMNBwIwyYbQSfAqjEpRQYk/DdUQAkOyUOe+2ZIfHlnHl05duXgQlFsDARntBGTRN5nxexRy5SRYzXiGlm9FJ3WyD+WZ8LyxZmkBGmINKRwHK+13y6ywM3H5ammlq4EIkFXvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkUo6f+w5r6cAth5weEaAeCq/KsW8QvnowQjm+wxRv8=;
 b=rYe0C9JqNpnD8/TkR2DAa+QnT2Iry9l4EoDKLF4Hm9yQJZaJOzGD8Ozrppp9+T6s6HrJlC3UPRU2P7yxT3Pi+3u13A5SU5PxMWhnzeH0WYZqrYd6snYH+3X9N4QWHIyzt06yS2dSYeGIUzsynIa1UxCwNuL5kZHgBwQ892CLhrI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Tue, 19 Jan
 2021 03:38:25 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 03:38:24 +0000
Date: Tue, 19 Jan 2021 11:38:17 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GFXOFF MASK for Vangogh
Message-ID: <20210119033817.GB22628@hr-amd>
References: <20210118101751.18953-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210118101751.18953-1-Jinzhou.Su@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Tue, 19 Jan 2021 03:38:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be0c4776-0fec-4e5e-2ca6-08d8bc2bacff
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1440E79DF9EBBECD7C532649ECA30@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X++QWyS/l0bh6JGibbv/WQQyv7DvNO9ljHervMeKpvrBbM5SF4syZG3bpLHEApaY05t9E77J74XVFtYYup5kBmtk+otlTmNlJO5rwMR/Y/rBHXWDcDTn9ZD6W6Gicp8YFlNzHg7N7jQg5sNmvCjl2lYMcF/8mJOlnxi2sOtVO3QiIfGNF0vyre4sjMFkq6adAfQE//0HNvi4JfnR8uM8q9NnnCRAxECfkovUH+6rHCmUgOq94yyLtH6kBQ5I3jYXUBLuJkE62YDGm2Ctb4S9oImq5wU/DSKnWC63blu1MpdYhUy2uD7z8oenNouH4sa5vrzk88cLjolM/WxYA5K1E5vyEyvt3E4aVVyEaGzDBVt4G/eiKArf2ddYMOfcki07lTuYKCQbC+n4V7TTRMONfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(1076003)(26005)(316002)(478600001)(33656002)(55016002)(186003)(8676002)(6862004)(9686003)(2906002)(16526019)(86362001)(83380400001)(8936002)(6636002)(66476007)(6666004)(5660300002)(33716001)(4326008)(956004)(6496006)(66556008)(66946007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?apG/5y8PDN9wy5XbmJKC+nPK3OBHMN1Nw5XHkpqhW/YslwQ7xZq1/4zjpLum?=
 =?us-ascii?Q?EwBqAiOBZeC11FY2OFZhXsqpmn9W+VtDjqwf/VBr2tvxLQ2j+x76AAU/w7xF?=
 =?us-ascii?Q?WlJlivPA7WaLIV1bHqmkzG95a7vHCQJWMBIPFeW6k8wLv1USaYdS1AtfOmyO?=
 =?us-ascii?Q?9bP/gwi3N12223UGhc3hwBkJDZVILn9uJBt3TktUCeY3T+hWdo/b4ZtArhFZ?=
 =?us-ascii?Q?rBDDoLEFMKGrseho1ao57SFKNpwoiCr0FjFaSDA8ppN/hvs3CPYIjoyKh1Yz?=
 =?us-ascii?Q?4Ucr/Y+pTzglhsZv2hMdYFGqW17X6gyxjX09DHfzk8JEMp0UWdHOcHlUPEZ5?=
 =?us-ascii?Q?9PMVo+9yp2CjEe4jXGWFruKownuA00OPcTq5vy8IMaiW5goXGmIKPC9vMvaq?=
 =?us-ascii?Q?uEWMJ6dY0QLKpXMJtlVJY9DNArn6/oHZRkBGBH/nwokMgd1LftluIpw2N3Im?=
 =?us-ascii?Q?utUn6eIIcAQtFUz2LmeS3/qgZqUoFg+aLMy+JO3M0gd57LqVglc+IMjykHJd?=
 =?us-ascii?Q?y5Vc7mm4+2+eDnIlPjelXbmg3aOxNsMoYKVEBXVfExdtpsEYCocQiP1qt40t?=
 =?us-ascii?Q?P9PSU+b5n+WFNqvKV7WctULFV/Xc/kLiuedX64d7kewSE4IKKNJhMtCavX4p?=
 =?us-ascii?Q?VU6lYfPIrTSSK4Ufhan+8YW16nMPiyni5OQGwpQMyuPnXf3W6ATztqLJZ0JU?=
 =?us-ascii?Q?xfMlTa1E46vgE8w5RGwUPaP3ucFElyyUcyB6hvwc301xulczWJ5xPRM3+kZx?=
 =?us-ascii?Q?ESL9jta5Aqpxp15ZFCV7zzetF8EuBj4IETURPE107QSXZwO9JvmFAKIF4s8T?=
 =?us-ascii?Q?Hmsn+UjU2SL1s3VCzwLP2KojGFutsnhjQv6HNHfQAkZ6EfM7A/taSc0NyvUF?=
 =?us-ascii?Q?j483YJtTsjfqz5B4eFd2EmQ11yPOHdERh4MnoSfKiJZmXdRhKcTXQItyYiqE?=
 =?us-ascii?Q?g+zbpOVATgUYtYVxWZt1aeKnLDY165RWAfl6C64Tu+1A7Rt76BZ1zqL1xtJz?=
 =?us-ascii?Q?1cMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0c4776-0fec-4e5e-2ca6-08d8bc2bacff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 03:38:24.8123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGLLhAW+Icjg9QQ9T5neaK6ag3c6zD9vEbKhH3rzJzk6iuYLEc37Wf1nZThiFWkTTb0hucHb/B36EVTzcsQffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
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

On Mon, Jan 18, 2021 at 06:17:51PM +0800, Su, Jinzhou (Joe) wrote:
>  1. Remove PP_GFXOFF_MASK and then GFXOFF can be enabled
>     by user space.
>  2. GFXOFF is still disabled on Vangogh by default.
>  3. When GFXOFF feature on Vangogh landed, will enable
>     GFXOFF by default.
>  4. GFXOFF can be enabled by debugfs interface amdgpu_gfxoff.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 4d3b30a2dd45..92b1cbdebae9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3775,9 +3775,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
>  		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  		break;
> -	case CHIP_VANGOGH:
> -		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
