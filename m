Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63841C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121332242C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M5tAuCsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121332242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A320B6EA06;
	Mon, 26 Oct 2020 13:51:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52F26EA06
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 13:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YijQr+6B1a5Cm3JXGhCT32QHT9sIyXSKiRAayyaLRbfMXZgysclbtoU/omEohlEcDX7HkTwrMuwrIjpCdAUYVFP5JQ6Z6J+6MEeJX1U7x2fEFFA0q984FZoVuPGth1Kk6WExkOIUeNgXO+HNOOwCVpjAzzr/xX1kCgc9jHGXiV8aGAIgR9a0rR3QzZiFWDrQMED/H2SJKYHQ6gqvMFm4xXXRK5YUanh+eW2da3nii2+/Lk+L1oN3fm5E8hylrsO8O8mrk+OjnERxaGGsKEUa+vUYO/sG3WwcV78Llx9sxvmRkcCUuSYRfIXHq/11Emr+4DeTnGkmqSjhUZ1XZhS+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5ukV1FXXh9WEi739Bw+axDiFZmB+e18Vpfkew9Rt+8=;
 b=R0d5kQoKr8R/d5R7Rfdmr2xqD+ZnCnDMYk4IW+k9YQx2JEFvO9qDFXLrlbANtysmQZdtq9iLWf/eMNmNKID8hhCBwin1hG1g7RzrjwnFRl8iVzEzNImsZShkrvQAPSGgzHXv2b9fLLbVWSAJAYIaeyoi9yoC+TVZ2Yzh2TRAikZI7VHrJDe9VG7GRU7dWUptcakzV55jIwXNspazvfXefUK0rynnN2095P8ocNFBlKBU7ZbCzAwe4klIoU7iuFOPCTuzbBy2uPtV/J7eoE2iKlvSbUj6qNgjGgTv52cjNxxQGJDu27Id2V7RDksfXB9+SrTiLi3dS+QvLKRE+9inHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5ukV1FXXh9WEi739Bw+axDiFZmB+e18Vpfkew9Rt+8=;
 b=M5tAuCszJ0l9u+gOdJys7zYYEeUXlsZ/n1LfLSocl/yZDz1XPo592mhetGwV9g5USzi20XT+Gp1cF0ef/2rZGDKjdAcTXeXQA97MxsvaaMdJ5FMDW0ye1NyPjbbF7bg7M2vkAWSKL5dr0EC/uqq04gV1R8N8DX95ekWqb4oC9rM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3239.namprd12.prod.outlook.com (2603:10b6:a03:137::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 26 Oct
 2020 13:51:03 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 13:51:03 +0000
Subject: Re: [PATCH v3 02/11] drm/amd: Init modifier field of helper fb.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
 <20201021233130.874615-3-bas@basnieuwenhuizen.nl>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <247850f2-2dbd-ad7b-ce84-be057b77d616@amd.com>
Date: Mon, 26 Oct 2020 09:50:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201021233130.874615-3-bas@basnieuwenhuizen.nl>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 13:51:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60cd477b-b83a-48fa-d3d2-08d879b62d81
X-MS-TrafficTypeDiagnostic: BYAPR12MB3239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB323963D5EA3C6175C8B2410CEC190@BYAPR12MB3239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCwGyXRZzvsnte4e/+Nq2NxIkOt5Jrmo6pl+M2yDQQHUZC5VcC0xGY8L4FFnJlBMj3A7uFqdXhPDY2o1WhYTCZRLxq1v1yU4chAhUYuZ2Msj033MkDbSUJmSKNV8M0upa33EttdZHXA64RCu4PES0GetsdMSCJq6H6xH9BIJyOLVy9cJgUp/9y6PlidSFKtXJ2SQUJ4UDihK+7A9TMw+EO0bVGCG6yg2L1sJeNmUD7sDHuJllPIzHIK+C12SRXvpfGVGb8R+3X3k4KxLR1ImXFZbBmn9Pkyh4iUFxr8QS/SmaZH6CdXJfDR0L2ddbJStJ8xI+y2UneVF9DNKu6WLX7rybX1y8qtqT+G2QCcZok3nkai6NZ0tDEAMGeNnkotz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(53546011)(26005)(2616005)(478600001)(16576012)(956004)(86362001)(36756003)(83380400001)(4001150100001)(4326008)(66476007)(8676002)(186003)(31696002)(316002)(2906002)(5660300002)(16526019)(52116002)(66946007)(66556008)(8936002)(31686004)(6486002)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JB0mHgafMCcF4cUpQYF0E9E0YA4oYlwTSaee1kX2AVbL653EgtzoZVvKxbpmJfGM1gqdRGJTpWxkoBzjWvi3QB6K4YFFPOdcS89ccoxmJQa5XAIbfaA34l4RaKtiViQK8SJ0vDdw6hRkiLvFHDgMglDjOkWlPdWEjrcQf4dVUDNsyvlC07K0AN1H3Y+Pnb2JmfjQSzWEvrNYkQW8S3oPttc4ehU8tARs9p8Lh92PVMQ9wPpV11gvGzwTHb/+kEDJvkO3T1HA8TBZZmyj+IyULcdn1LEghQN+nnPe4Lrr8xi2zjRzSgpEB3j5K3pDehQNGOauafupv6kmpSNdqD74E6AyFi2CXziD+OVVCHGzkxGkgb73HzW9uxUvCa2nOfxLYHLt4oTAypEsUlE9Hxq9gL0PC9qraEAsrKIUH3JA8vCV4xLIZPQadC+9BV+7PSifBGCzTfHl8MXA/cZ1mSVLspL/kkL4tbS0zx3Y0G8T8MeBQ41/XV6oMe+xKIiwjkx8/VCaEf1kTOt1d62V99fTNavwLjkLCcdYNR2AIl/3AD7/SLDD8B6w3rmZyrNp1OzsiRk1KwbXhUvemsYn43YRgEDX8O64/UL5lu0ZiV3uBKMz8MM4wJbye/UgD6skoI/wbBMFxkh0P9DbSAK3DhBy5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cd477b-b83a-48fa-d3d2-08d879b62d81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 13:51:03.0205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exiPMfAGJmsxm9D+ieo3rKmwgF+9jj8g3HVLgBAKk9zHokfaIFJkNiVeTGYjn9BRNJf5TYDJCHKO4X53SBOsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
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
Cc: alexdeucher@gmail.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 maraeo@gmail.com, daniel@ffwll.ch
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-21 7:31 p.m., Bas Nieuwenhuizen wrote:
> Otherwise the field ends up being used uninitialized when
> enabling modifiers, failing validation with high likelyhood.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> index e2c2eb45a793..77dd2a189746 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -201,7 +201,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
>   	struct amdgpu_device *adev = rfbdev->adev;
>   	struct fb_info *info;
>   	struct drm_framebuffer *fb = NULL;
> -	struct drm_mode_fb_cmd2 mode_cmd;
> +	struct drm_mode_fb_cmd2 mode_cmd = {0};

I think we should prefer a memset in this case. I always forget which 
compilers complain about this syntax but I know we've had to swap out a 
bunch of zero initializers to satisfy them.

Regards,
Nicholas Kazlauskas

>   	struct drm_gem_object *gobj = NULL;
>   	struct amdgpu_bo *abo = NULL;
>   	int ret;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
