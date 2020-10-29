Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6DBC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 23:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA05A20739
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 23:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F8Jk2qKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA05A20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A34088EF3;
	Thu, 29 Oct 2020 23:39:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898E488EF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 23:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtwgHp6gRl6j8DxX/7UcVO5LRs9/M7dew1Ovc5mq7/HOUwJIszP2dkCHN3ZGdXAI/beYqCzxiyfbUEDQroaX4/qxxcM1PlFoW2WD/Vp0LhKL8bI4MP2vMJpQYi9hsC80sCv+JGBCpK0d/Wv3Plks1zKgQvTOMFM85XmO/7Jg8OKbB7QKeyzT9yoBRTF+RlMNe78agGLdQ9kNCXyqwFxIOHb7KZE7q2tN2jBx+9/a3BtFNR77kJtmav/mxhZroQrN230y/pRGoPiH/i51wcRIxPSdWaF25j3MxR2cmTh0LDuahCQ5nTt9sFwGSasZA4SoAQfqGx7o+26sAK9JLOaU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dte5t370gnEl01WKwhthP8e6ZHryGErcg+mPzMqlbUw=;
 b=SeIJJFDWW+YaJgc20DLNjcM8+yAJDt7r+TN/31V1RsnKmZ+9maDG74gZknuZlhoFGfp9EAOUEdMegsr3oftr3MKWLxIRcf6pVoEujRAOKCodYxbTudxOnE6aPMTVD1NyoWF5RrCe6LfRCNaS2VyMBLkvcI+Xd8fR+oGi/zKgCQnOrfFetMaFaDZjEFNpqCHhEamPi+kh0fXTfB8VLkMXMIsrD/Fth1+qZm2NdQOSvhaGdwwZIvDAf2lw3LiHV8rG3bELs5rVgUGMnQCPxpfcDmq2Hq43+reNjPy0/E6wnFCocwu7QqMDK11+ebGaC5UfpRlb0eczIMCwV/Trbvqo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dte5t370gnEl01WKwhthP8e6ZHryGErcg+mPzMqlbUw=;
 b=F8Jk2qKkYlYlzPs4xLZJJsvj+O5TZCPPH9ptj7g6ve1wEXFDqkfWTqY7zjbwDw/ngfAPJsDhQXlbpVj7ptHXenuYJxrNe2FctMDDE62AnfA2g6cqP6afhc0e27qw11gnWOONEWUcuVZnb1RYRyz2lgzHpTP4OV3ghY3MY/uEMKo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 29 Oct
 2020 23:39:18 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3499.028; Thu, 29 Oct 2020
 23:39:17 +0000
Subject: Re: [PATCH] drm/amdgpu: allow TMZ on vangogh
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201029203133.215585-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <3670e339-fe71-7473-a44a-69325bb8fd50@amd.com>
Date: Thu, 29 Oct 2020 19:39:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201029203133.215585-1-alexander.deucher@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::47) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 29 Oct 2020 23:39:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48a1f688-19c2-48c9-a483-08d87c63d9c4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36894E31679A8B326005211699140@DM6PR12MB3689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIOTRfNkhz3jru5ZZp9yd931kPtwJNWXh4ylIAIcepBKb8XQBYb7YSQSL/wY5wDEMMkouw2JRlMCcWJLTwbaihuPRlE0R9d78Qx7/Z9xLFt3IzVnsyaC/8wZmfr2VBVJ4Hw2k5QVAvBPsOz+u/ZGvN58YG5u7RnxyW5TCN2L395ZyhFYPxjJ/5nnQLo65x8C6DNKiUKm9v7fMHcZqYToZFnxqqbVD3wyUrD5iflbSUyHwOyyDASGAYjUCwFs8Im7zInKye4lcn4trnzSmlzfKQi56gUR7b14wivB0HKG9HQ3ZzAHwH2WP6HAwkw7Zw2i2yd9yIwOz6/0bpxuV2/abyFYhe7eunmicTEQ2eOd+Alr10l1dKbxz/of6HwHY1lF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(8676002)(4001150100001)(8936002)(2616005)(956004)(478600001)(26005)(53546011)(52116002)(4744005)(44832011)(66556008)(66476007)(66946007)(36756003)(16576012)(5660300002)(86362001)(316002)(4326008)(6486002)(2906002)(186003)(31696002)(31686004)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Rcev7X9C8YZSrJjiwJ2+nSKzUXyxrGLT5Bu3L9yRjdZU/SpnvV8cg2VRhs5nJVguf79cdSDDSqiz2ouM5XjujpjYs14RvrpBxfnIMnBWPt2hOMWeXivpgPkDww9CBK8das/I3Lev7eoGYpSv7x0TPy6B+5ZbhlOzJ/B4739fCbmoxxQW9zd5cOnmwBDqipYLeYcza/nG2/HY3MEFPFClvYCfuN5qgrdrRC/cZ0Np68uHXFtwehU/DqfKN8rOoJjCVz2a2hFkuFpAyKkpzBtURaxOyz/YlefGuK+kZfmppR3RRIfmxFqvathaKHBJyKm/5hFD11/jGpy2Gv7MHXrI9lWyMTKI46e8lfnh7q+MvZh3/sKUBkHPei9gvbJEPn31U5O0ITP7lxWhEABLcG0kCN3UbPr8MDOcFCUj3ZgMMgO15dYxClwi8UIZlz7J7OMYms643UmFcv1OLbEya4hp0SkKE+l34g9UevLAYahq4G7We6HgXtCmrpLP4hx4Dtcuinrth8XC4mDPzBGsWu+Lk7aT9MOmMashHvvXo+bueSc/ermOSNRFEedqXCHUFguMGkX0XYln7NHwCRg7/uh3vNZ5amlI9kFxYq1P6hrTTa3xxWzEmO7gIdezue+uTotfBUmnuWWhA4Ogv6XmxvQRhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a1f688-19c2-48c9-a483-08d87c63d9c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 23:39:17.7240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y18vF5+GNeHGX3eayunwqKxPM+0AQ9wHJRDgepobA9oniMuXsouICuesSzkxacqP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
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

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2020-10-29 16:31, Alex Deucher wrote:
> Uses the same pathes as navi.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index fa799600a58f..1449489cbe78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -393,6 +393,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>  	case CHIP_NAVI10:
>  	case CHIP_NAVI14:
>  	case CHIP_NAVI12:
> +	case CHIP_VANGOGH:
>  		/* Don't enable it by default yet.
>  		 */
>  		if (amdgpu_tmz < 1) {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
