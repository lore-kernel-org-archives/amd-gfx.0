Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730DC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556F721D42
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CjB7Lewd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556F721D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106D36EA06;
	Mon, 26 Oct 2020 13:50:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6846EA06
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 13:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkCG+eL1SABzRhneny6yBfAIMHS3Ol2tYsBb3FlFtY74FzMEUc5lEZVXAzuf1huXLmQjk0CQ96TwXkeIWyQXWheC7dX3NsHDZzhd6ubLi5W51kujEfk+2GJF5wmvwKdQOMzQrHnsds6F6Yfz2lx0xrAZW+H/3OT9OPEt/ISvFKwVGlma5WsLJR+lXvyNeL6f4cx3aruveSWHqn0I0ckYxyxdki3pqYLLTpuGZ/LM6ubUOvNaii6KVHjc0uP/kItrU+whaJvIP5ekK583e1VkViuQNiASY2GBBsTY72kKLlTtNrXlCh/eUcokVgXq5F0GbzEOTJGiHjSaXZtPnALLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51whaiDT7zx7ph8UGmqY4KvW2/34Znfs8Eip5WP7HkE=;
 b=ePrNvluj6awsAixR8t1Mcm3FLdPIjyB4XS7XFgsJRa3tWCOuB1QydyiSwczijmeD5y+/xMCpPJKhtrXaibhozOJAAiNaTCiguF0DWmeYSYQNDxmNSMm0EaRWhFRebMk4CEPK9nqs7DkvOMxAh6wU3dZzbC7Q8uALJLGo4cZxUS/4ZzEnvrlXZR9tQNh1P3WVb2+Iy98h+g/MYwnBAWZvKtQPDGXi1LhjtJW8GZm2QQvpYH/c+c9iUXdGPxJhjHPfPZ+SVJZSwuPSH4lX06jTPg9LtRV1ACPV44WdWiCUG4kv1NyDSVmLYJ7EaF8+6BV82gVdm3p6oxDwBjG7DP4p8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51whaiDT7zx7ph8UGmqY4KvW2/34Znfs8Eip5WP7HkE=;
 b=CjB7LewdP2OZm2rTnylJSZ47iglhvjFtM8nCOuyJYwAlnZ/jH255kkgZ888NTQbjubo6U27B0xfTBHIKUuyR5DhQ7CzmryxvyP6SkBfrWz23JUH9k8Biu8USH4ZYT7a/WozTVmHsM0Wrub/NDGuOsMWa2Js6LJw0yjkuDZKXj8w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 26 Oct
 2020 13:50:06 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 13:50:06 +0000
Subject: Re: [PATCH v3 01/11] drm/amd/display: Do not silently accept DCC for
 multiplane formats.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
 <20201021233130.874615-2-bas@basnieuwenhuizen.nl>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <a501ff9d-139c-b9c9-f2da-9d377ea67436@amd.com>
Date: Mon, 26 Oct 2020 09:50:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201021233130.874615-2-bas@basnieuwenhuizen.nl>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 13:50:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e88ae28-c484-4c50-9179-08d879b60bad
X-MS-TrafficTypeDiagnostic: BYAPR12MB2919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29194B12364D41389C32773AEC190@BYAPR12MB2919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n44+TQkQMYBKbihVmxeV2jh7G3m017Y+qgWxnvIxmCt4Ag3hnnbxAReBMtotL2D7qlais6CjZkHFyvH0SZFEt6KPOGg3uTL8yiRbvM6brXj/TBGpWgjN/NU64xRGe//AZWT7bH7CHsJWOfL8DaIGqWxbybHFjn/fEJwW4Uy8kc7wHL4QhJma55gYMr5BESgDIUhr3KtslxgLPqkzGJTLTaJiGlAkUMma6t8UJZjQDcu19ZR1i2Bvu8X5lzLqR9860mAtbvFNcQnQ/CfUmqvs0ONeIMlJTdCY4clJiDIcDs+/RBZlTpykRIuNS8B+t5bU5af7x+TfgYLzcUY0t6tYh7FAz1Y0uB2nDrFuJxi1hU+huCpzNHLNVDNVR2OEEXAt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(86362001)(5660300002)(66556008)(52116002)(66476007)(6486002)(16526019)(186003)(956004)(2906002)(66946007)(31696002)(316002)(6666004)(83380400001)(8676002)(2616005)(4326008)(31686004)(8936002)(478600001)(26005)(4744005)(16576012)(36756003)(4001150100001)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0HEhwDMI8eIu3JWonrEK52JGd1JxC+nAcD1FJbG2ZYyyRPXoiTHGm3vXijsvkwOK4IwErBd3INPa/hIlzRiphR7sbvI19KCHFxhMs5kbK2fbK0psGPhKfrAOxIddR6zUm/P2KqLHxfCIt/ZsMbQmhznpEb62AqLAY03vgCtiSC91AipnfIrlyNyLxytWfERgoT78t/2mKv/oq+EWEfgs8wnTTsfoPWumfTho7cItVZHqvgZBs2GBofKcComxYaOK14nT0BPTLM86Hu7RGkh9uZyds8eFmECHUH8w4AKrr8AHEjOz+1s+WnAXqzKwnwTPK9TKwLTxioENvPjPYGJa6y3NC6/UHBaeO40U87ybPJW7C68LgDByZscPb1U94/ZezK4Kc1N+Bh9lESW8okDzRGq21A9QZ5ZquIemvmahBzg9Gx6nKC+qh+VoiJQVi6iYZ42aIebaG7nqNvixLRqyhqkzzZFauZuwuOsHJyfkEal2ne+CX1ha00jRJJ+iCBlVwITyLitUYCeJT81KMoPSmc2Q5OReX53uIMa4ykk510J+eb2719yaAiLTL4bTn6WkZlmIlU/vweiyz/5pou5iaP5J8rAoKzJyyWle/P7VTFNMop4Eai4FzNjQhkQJBZ0pLuCURep6vYYVmG/rC/Bxxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e88ae28-c484-4c50-9179-08d879b60bad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 13:50:06.4015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04khwKqJ4ZM7efXc2QowD2zGklyKkjMZbcrK/HQU98JAsAh4yxctTWOIZEQZqFWAFSPYSPz9bwkvoFCIgwO5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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
> Silently accepting it could result in corruption.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2713caac4f2a..73987fdb6a09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3908,7 +3908,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
>   		return 0;
>   
>   	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
> -		return 0;
> +		return -EINVAL;
>   
>   	if (!dc->cap_funcs.get_dcc_compression_cap)
>   		return -EINVAL;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
