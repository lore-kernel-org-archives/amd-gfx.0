Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A7CC48291
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 16:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E4410E510;
	Fri,  2 Feb 2024 16:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o776A3qd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9C110E510
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 16:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3z8lR/UjUy5XY0E66ZEYVqJCGRbm4KLONdo/8NjINXIoh/Xi+tQob4OVBG+yFlXnU2vyBnvjLRfLLYFEqr6pUc8SKg8GeaWOA1bbXMdCXDt59DQehRtAqhjdxuUEhs/afkYZ+Ax1p1vvIJl39Ce3pOoxg+dKFYGQuROc1S3gcCtreG+BHPydTpnhktgkz4GLNZaMSeWelGjWoS2TzldnP5j1NXL6TT6njyiIbDuFltDDapUKrk0DGnYxOe/dOkbz8Zesgz7N5WOcizgpPWaFf9RTTWIsCZtQuSPhQfuGWcA+1xGyZCXLB6u0gc08slNxZ24CAyQxLTaUQSzFRnyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcS3k1bRmB572jEu0YKYILmhsidFfGJ5MbYEX2mQe+0=;
 b=MyJxEtrPECWcchN7Uw+KUTOFV6K0Jhbd7/uc4GLuKo3k4OYO6UTYtV3bMPF2DGcr1A0NjgMPJmZYx8KC9WYFArv5FbRQ6+afMBOwowWM5vNV/Qe8uQ0yRZsFGgCOR+fGUWZpuPu41Tkp23TIJx3zhvGrMgpmtqzLar4yQjPHkT6YoXrn0tIkdjfn4/QJLS9IZ0kyc+zOrsqg7LotDaaV2Y9QnfO3dF/aGx23QtpOa6tg/jeAovKSRImbwQRF0PkVRolQ6WUUBn7P0HMI6h6bxjn9fV9OiJ05a3gXOPmqdQmsHSTQTlLp5t9nvWCiiybXbLH0UoBOURlGS47AZuftFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcS3k1bRmB572jEu0YKYILmhsidFfGJ5MbYEX2mQe+0=;
 b=o776A3qdjO49NYM7PJfezZ+5UT8yPHYUTf5ilo4L9TlqmDsX7Od5vlNlV53Ho7gRfSxCx8T5tBncpCdEdvUP5WxVB6+HT4AW1hCcRunyWvb2hxvOba2xCAv0PatJarJE8yvSEDF8LKLnn1O3sOop4OKQi7XV7DVgxGMT47EQ3L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 16:20:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.036; Fri, 2 Feb 2024
 16:20:51 +0000
Message-ID: <89049091-fcc2-4d9f-929c-108af7941f49@amd.com>
Date: Fri, 2 Feb 2024 11:20:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2
 onwards
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240201185445.1461461-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240201185445.1461461-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0276.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 55587f4c-6350-44f0-d37f-08dc240aec2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szsEiBHHgESJbI81/pm1nEYoPiFmGzTy2BJJEbsvDFQEBvFXbsEHMfaZxJ6MnyNYxsOmyk+pCM6owo0sUFgnjJh00M/Yxalz1x/ufAQoCbbxM9sbUAcjDke19PFbOiNwViW7lCYpAhMi5YuK11VM8aXTyuC/seXgeu58fPkzOj3xt9wfXV0go/VpBNKkh94YhozQM25+IgM8hUMjP9P11TOguwAyJBQtKL5V4iu/JJRH7NxY4X5KvTPBkduaF2A5p4q89LDCDLpwQ5TutodCK9ZxzWCMjEk2AvCA+wlm06NDNWhf/Drn9LKtvGMriCBRp++xmD6A5We8aGxsd+cBIwriaOQmPxAAe/iE2JksGw5kYC/2H+95IDCBwLNx8/ZS8nNpzB01hMJPE0sqipLRJOHczHT16+dg5SV0Hn/0M0q2WwMppQxpzdayBsGTj2EXyhOjQ2KFq47lnTKsP5Pno1cHXmEl7cP5ukOVzgUPFu/VZdgfaN+SWThQHRq+5FEOf6wRcObafbJ48bkuSP2UyvTHT9tKiUXkzJQuOLRq9ewjnIkBTYxoigQVo6Lu0uPf76B/9kV708bxEDvMrXhK9R0mX2J/HDcA05T44x/ZD9TTxjJLooGBgzJRxtTEYaEW1e7l0jCgoeS0V6ypyz+kZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(66476007)(66556008)(8936002)(2906002)(44832011)(15650500001)(5660300002)(316002)(8676002)(66946007)(4326008)(31696002)(6506007)(478600001)(6486002)(36756003)(86362001)(38100700002)(26005)(53546011)(6512007)(36916002)(41300700001)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJscGowaU5lbVcyM1o0Uzl5UEhoMmZmc3BFWG56L25MQ2l3NGhraXdIeFhv?=
 =?utf-8?B?NU9qU09obDJCbTZaRnpvNmlQQ2NUdU1iUlc2OEU2VXVBclArbWl0b3V5dUtS?=
 =?utf-8?B?YTc4a2JaNUZRYzAveE1pdjlIaEc3K3QvYzlmaiszbzVhMHRWM3l2cWRRVjJH?=
 =?utf-8?B?VVc0ekJoNDBsdGdzM1RXU0p1Vm42cU5PcnFzWEJ5RXQzMElrMGFvQXB5akxw?=
 =?utf-8?B?RERRQVhXeUcwcHo3dzRaOTZyYm5tTjhUd2o2VmU0Q0hHNkpQSGJUTlErZXF3?=
 =?utf-8?B?RU1TbW1xK0hLZlluOXdUWXlCWXV3cTdLYXFzRDkrcHU3cGN2RzRYMGhMNGll?=
 =?utf-8?B?aEVjaStuYWt0SzJnRCswUVljYlJXL0lqZ1NGYjdWSm1iaEJOb0RJRXhzSTdR?=
 =?utf-8?B?TWdlR2l6dTJpS1YyYzN1TGRyb2VPMW5NNDh3OEo3L24wUlhGZnZHZm5uVjNm?=
 =?utf-8?B?Q1QrV2doK1RHY0o5VS9VbGJab291eFBkeEtpd1B3Tzd3VWE2TkJFd0pzb0tQ?=
 =?utf-8?B?ZS9NaFVVVUVlMTd0eU01NDJxamVYdXFBQ0ZkMWQ0VkFUc3VISTM2Wkx6dVRT?=
 =?utf-8?B?RU84a2JzRW1uY0F5d1dNUklydXFidXpXQVJBUEtVSEloWCtxMVNZN2lBNGI4?=
 =?utf-8?B?NDRDTHRnMGYrcHBKbXN3TUJGRXBQN2ZEbkIxTG9qOGszbzhvTDJOU3c4amZD?=
 =?utf-8?B?ZXpObHBrOTJJNzFqQS8xNWtuRGMxdS9oZXpkMURXM05INWhOeE1FWFkzMVQr?=
 =?utf-8?B?V25PbWtjTVYzbmthK1dEV2MvcTdoK09abnJhVGducS8vbFNkSGJaTDhvS0NT?=
 =?utf-8?B?UWtGVzAyak5FQnY5NmhkK1dLbytkNCtEMnY3d1l2R2d5akNQc0lpRHZnbVRS?=
 =?utf-8?B?Q2xvaFhnZ3lNTmRrSUlPZlZnUjZjS1NyK25BaktnNmdpemJqTDhWSE1hOWIv?=
 =?utf-8?B?aGpvQkJnT25vcDB2STVna3lOVExNL21wR0hudm1MRGZGTTVoUDNCTVA0ZDUx?=
 =?utf-8?B?b0MzTWhHNStEakNqUmZiOTROTFNqaVBCZWhsQnJzSW84dnVVOUxpUEJSYTM3?=
 =?utf-8?B?WS9sdlZkTTh0eXlsWm0rL2FEM0NwTHRoTVZWWlA2YnJHcU5HNWhNcmEwSk4v?=
 =?utf-8?B?Q05iaDRlK1kvZFFKS0IweWNhdE50NVFYdWtJUUxpdjJ6WXNyQXM4NVNiblZF?=
 =?utf-8?B?WDFxOFp2OExES2I5VnRYdTVjbFlCZTZTcmVnWmhTcmJNYWJKSlhMd2hNby91?=
 =?utf-8?B?VWRyMmhFandDRlFQWkhteEl3aTFiNmxxbEllY3lUOHhrVUswTGtBVXdxcGR0?=
 =?utf-8?B?encwc2NhMEpUYVhySGRSZ0Z1YXFEZkowejhuTzNiTFpCMFFXSTdUTVI0cnk4?=
 =?utf-8?B?RmtleTJkQXJJTGkvWGJ0aU44bjhqZCtmaS9kYWxxOTJiWlFOZlFaT25EK2F6?=
 =?utf-8?B?NlVIelMwaHFYdzBWT01Sem1ZSUYxRlNLVGJuaWc3dExJa1NoT1ppbGNDY0Rt?=
 =?utf-8?B?dnZ4ZjBCOE93OUt1dUhkaGhMTGIrOVIyWTdiS1pSbXdsOTVlck90MEJSLzhi?=
 =?utf-8?B?UTBMekJPZW4vZ3JEMjJPZjAwQm1OaXo0MllpdVhjRHFmWk1RelhBQ1MyMnpZ?=
 =?utf-8?B?N2l0aldWVzQ1bHQxdU9HcnZpcldrZFhPY3hiY1VXRHc5Y2d6SDY4RVphYmlX?=
 =?utf-8?B?ck1Ick1vNWZQRmJCdjlraDM2OEM3bnB2d1RGdkRpUFZLZmdjQVJlSjJNYlR5?=
 =?utf-8?B?WGd6cU5ZbXFCR2J1azgzVUVONW5yNG5pbDJXRGwyL2tDZzBqOGxXODlkak43?=
 =?utf-8?B?TUxOYWR2Z2Npc0tnQ25NYnVSRzJiYUlKRWIxbzdVVFQ1cWJCUTNETHVMVlJo?=
 =?utf-8?B?NHp4aXQwbHArWFlTcGJtQ0VmZkpTSVg3TzZrZVBNOTZvUFdoVVpjUmVIQkJt?=
 =?utf-8?B?ZkM4anI1ZVk2bXFxWGV5NFpydkFhR0tiNmJ5ZGxKV0FYckhvc1BneE9TNjNv?=
 =?utf-8?B?Z2ZjdU5vWU9tTDNwdlJVclh5QWVjOEhzWlhUc1JwZkp4eTVZeWFPVGNWMElm?=
 =?utf-8?B?RTNwN21tRUtwaGxZOENQQlF1Y0JQRW1SSnY1ZnM2Skk1SlRyQ1cwU2F4SVdR?=
 =?utf-8?Q?v8bZtMujTM6JSqwDHiamCoFT8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55587f4c-6350-44f0-d37f-08dc240aec2b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:20:51.2277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IpmlodiP11qDHtYkB1APH703n14uoKKMnAd/dFXnBoGPEQz2a8n+J3KtRvVqcl7aUYjCSM7PHgltuLw+niVXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-02-01 13:54, Rajneesh Bhardwaj wrote:
> In certain cooperative group dispatch scenarios the default SPI resource
> allocation may cause reduced per-CU workgroup occupancy. Set
> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
> scenarions.
>
> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 42d881809dc7..4b28e7dcb62f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -303,6 +303,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   		update_cu_mask(mm, mqd, minfo, 0);
>   	set_priority(m, q);
>   
> +	if (KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2))

Are we sure this is only needed on GFX 9.4.2 and later GPUs? Does it 
affect older GFX 9.x GPUs as well? What about GFX 10 and 11? It seems 
the register bit exists for all those GPUs?

Regards,
   Felix


> +		m->compute_resource_limits = q->is_gws ?
> +			COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;
> +
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
