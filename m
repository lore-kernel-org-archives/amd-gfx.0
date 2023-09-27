Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3849AE80AB2
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 14:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9B410E53A;
	Wed, 27 Sep 2023 14:19:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0228E10E53A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 14:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQB7AwMyKOjr28bDpHCG6LpzoauVAvKrPqwsyAOUgcg7QDP6FpmSqSkXOP/f8yHOWErxLEYXkpzKwv9uYWawUoFij1fE37uzl9FH2wp5o/12dqOx1W58jJo5Q5SwKJHi8Ae8wXstiVjIj0fKSsDrmC4NSdAlWl1o9AdE8go72TFC2Ma9IcO4NLDSxflNChvuNVyiT4x8QkS+kPzieiY/cKx2XN4sFFgH+Kf1qUBWA9KrgmXu/fmRs87S4i3spv3lqfJb1gpIfuiFftDmh9Stou7pdsl0zyzRN2rhmVZZh8f4QLMDxptS7xyIXmqd5d+CBZSHgqb5iV/5p0LvoNOlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqZX8yrS/LzfqLIewOTmS1ut/Y6dxd5U7qfSjaPVLfk=;
 b=F6hlxxcXJY8ZOpm72iCGaMsounGdOIF0PAnwYmjKerW4McF6SCo3SdqhxhJufrCW5YfwONI5cETQnmxe5LAG6/+thMDCdeTPV2OpX32eL74WE7/cV5BVVxMLhsyIu61jRa6bT6ILdXZjG7OZbZNHzAyXG9TksdDj/WO77C/GtMirwh7e5xjhd3gMb+7ju2VNP/TP9vM3I+u7W2ndwrWTjOSJ2s1tYhp5CZGye/yAMoGi9zCmGOD2OSVZn1kQr/0s6uBRai2qTTUbOTLSN+SGcGr9np4VSEYl1rpAlcyr6bCc2XgvH3XN24gtQunb0jzZ8WJDp4vRVRfkpcrXC7XUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqZX8yrS/LzfqLIewOTmS1ut/Y6dxd5U7qfSjaPVLfk=;
 b=csvqvOM6jva3RaEtPO1FWwri4RNMUZypQYO8yvEiRP6Ws2E3oqLcycQFEuHaXqZJWcPHq26KdbPnVKPPvt+37hffKbANratJx0pWj7bZqKYZWKSD/Y17u9BExbkN82Kq2T45VOiUnsHjOfAPxsFmCpUw0lJlD062YLArPZbwN7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.25; Wed, 27 Sep
 2023 14:19:27 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::bfe0:4c86:ce07:4f59]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::bfe0:4c86:ce07:4f59%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 14:19:27 +0000
Message-ID: <101279ab-0c40-e169-e1b8-3a171d20bbb7@amd.com>
Date: Wed, 27 Sep 2023 10:19:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Fix a race condition of vram buffer unref in
 svm code
To: amd-gfx@lists.freedesktop.org
References: <20230927030008.278066-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20230927030008.278066-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::18) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 799706ad-a9b1-48e0-9a5c-08dbbf64c1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEImhae4Wi31cI8HBikRmGNOt0U69cr3uAywdRF8g2qUZtovTroMohkV1gpL6XTRIy56Cz4UIcb2WUg1Nr+LJsbnmimb1qS0yIahrQ/cybiGsmhUIkUxQSbM+mzAnwpC5Z+G1aJJeKNghh1L5EVK6NzGd3MhPtV+qHbk1yI7mfXG046wjgury+jc+ZH9Jc0EPfjqTz2/E7j6lYtEikBg6CvbJy+w43nzBozao+qpdYOKheUsH9XT5xqC7BS1wAboy38UAuIFMQUphPvWL6vV2WYHhsvI2vlx5HWv8ua/lydy9KPRrc32hlpjJrdNh4XfM5BAZYfQQxiUcXgUESdV+PpKuiatPnJssKQtmPQs9UMyQStgUomTH0608e87VSZO2RkbFVOlTV0ELGLO36qt2r1UHigJ7gdPA4khylS4qMZHCkCxam0pDNfMYyKYh1JqgjvMrbXGRN6lS3+XffF4KrUmHn3bDSsnIu0Dl+4ZE7SBspwVZVbgb75szViGT6/Ao2UkypTnWUQ7RExYzCqi5MWK/aahMiPzGHPAiH5fnOgUnNxglMSsnwADGhiJLqApgru68a3o09PJeikd0CHdvBnSZA7YWoNropvDKCWFi/ilrpcdH1y35jrB4nPRuWJP02ObujoVmiPX7B+l61Xyrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(478600001)(26005)(2616005)(53546011)(8676002)(6512007)(6666004)(5660300002)(83380400001)(6486002)(2906002)(6506007)(8936002)(66946007)(6916009)(66556008)(41300700001)(316002)(66476007)(38100700002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21FOG8zQ2J2bDNtRWNPRWxCbzlPZUtha2tDZlR3TEt4V2liQ2xrMUlpMUI1?=
 =?utf-8?B?SVFqeUhBS1ZWWUYwTDZiZ0l5L3lvaW1HN0lGS2tBTjFaYUNpYlhmR2c1SUls?=
 =?utf-8?B?YVc3blRveFhCTExrVTUrYy9nak1kV3ozbHl1YWdvc0ZYODlhc2lnVWdHQVdq?=
 =?utf-8?B?Q2ltY0RnUnFIVEFTS3M2VUpEZUc1eThJWGFhVmVXYk9PN0w5OEptWjd0aWJ6?=
 =?utf-8?B?UXBLaWRGNnl5MWc4c1phbjBSL29Kc2VLTFQxcXA3R2ZsdXByM3lFUFlTWWtv?=
 =?utf-8?B?Tk14elF0QUt2d2dwMmI1MmRLV2lQM0ZSa21XQWdmaFdSRStBVFVCbithNWU5?=
 =?utf-8?B?TVIyRWRNVFNudVdFa0xwWStCMUo2QzJXL2lqRU94WjdXVkczd2Fhcmo4bmRh?=
 =?utf-8?B?elFKTlFsdk0zSEY3L0JuR2k4OVI0bUdFdDhIa3VyWmJBeXE5WnErWXdBZ0R2?=
 =?utf-8?B?RTJ0VnJlc1YvUEZNRDByMmYvU242TTNwY21MdmE0Vmh0NG9MRHQwMzlBTXV2?=
 =?utf-8?B?RXo0Mm5KZ2l2Qjhya3JxVGhJbG84am9YVmxLejNTU1k2azI5VklPbWg5ZE5t?=
 =?utf-8?B?NU9wd2lpTENWZHVvLy9BRW1NSVBTU09aYkNwRXRRTm1HWUR0eDFQRTlrZitu?=
 =?utf-8?B?dmFxNE5ZUzNSek5tOE43ekN2UGFCV01IMGlJcGlpeWl3UUlpdCs3THdpdm8v?=
 =?utf-8?B?OTY0dFpxVlkzMXJBV0YrbTdLWFR5Sk4yQzhQOWhmK1p1SG9CcGRtRTRpbmlj?=
 =?utf-8?B?bzBzU1gydkxsaEdoMVN0SGo2ODVja1hncjQ4VmltcHI5SHU3a1RkSkV5eFg5?=
 =?utf-8?B?Vkc5SUs1cHZUZ1ZrRFBjTHNjMmZzOEdMYm5WY0JhTWxHRFFKbG4weGF2VXIx?=
 =?utf-8?B?OE1LbktBTEdOL0J0dmtoeExZM0d0OFd5Q1JQM0owcmU3L0JZQjBHTGdvd0t1?=
 =?utf-8?B?dzVMNk8vcDN1K1dOU2dmTHV2MDFGSzU5Z1d1Q25lZFBuUWxhYmN4UW01YWV2?=
 =?utf-8?B?WWd5NHBLU2syM0JRck54MzhXeExGS3EvblpOdUdONDlNL0IxK3pJTDVqdCtC?=
 =?utf-8?B?S04yQkN4WTdVdjNoSlhKZlN4Z3dOb3V0UldVaUk4L2NoazNMcGRGN1M4NkRy?=
 =?utf-8?B?K0JPeWRBZjNvNGhiV3pVRlpZSjRPanJ3ZlQzZjlZSkYwKzJqaWZEbjhSLzhm?=
 =?utf-8?B?bjl4bnhIdlhoTVdlY2I0OWtoTWVMaEdOeVNSS2lCY2hnazBHbEJ3bjgzN2pR?=
 =?utf-8?B?T3JiMlJWZUc2SzdlVUdFSW55aEw4WDNhSFBvbU5VNnM0dCtiNXgvcGpOL0pC?=
 =?utf-8?B?U09VcTQ4WlJBZEovVWxOeDFCc3BoVlJoZlpIY0UxUHVWMU04VmdBeENkUnNM?=
 =?utf-8?B?S1pTRHlyR3FPamJlL3JGSkpYTi9nMGUwWkluS1NUNWpvbFlIZ2lENGVOc0J1?=
 =?utf-8?B?bWUxMEJJbWtUcWM0SjEwQVlkSDQvUVQ0cmtwbXRwU0ovNUYzSHExNjRwMXJU?=
 =?utf-8?B?b0dNbHdmVEZIb1U3b25jVEEvcUYzYVljRHRyL244anZwNmJhRVVYZWgrbGRX?=
 =?utf-8?B?SEN3c3UwK0JWb25xL1BBRTBEdWx2MjdkQzVyQi94TEM4Um04RUd6U29MK3lQ?=
 =?utf-8?B?ZlRNMDhaazF1MHg5VTlpN0lLZkFvcU5sUlMxYzlHZFVvc3hONm9ZMjQvdmQ0?=
 =?utf-8?B?VUF4UjloVE95RW56TzArNFZyMEtaVmdudkNJODFiaFQwVmN1ekQ3RmovVjJn?=
 =?utf-8?B?RXVpOUtJT1RlWWxBdk1UeGRSajE2dnQzSGNVMElud25KUnlOb3pwUnowRldS?=
 =?utf-8?B?ZzNackhJR0dLTXB6enNSRlN6S05Ucy9JUFlYSUF4U0gxZS9NMEJJS3NSUGJo?=
 =?utf-8?B?SGZkYk0yU2dhblM1dFB5b0EzSExpMFFrVUxMNm9GS3hQTHhwUC9vMWlHS0dh?=
 =?utf-8?B?cGREd1QvcHFNVWhrUU8zaVhJSUc5aGJmV2krMGM2ZFBSZWVwTm41TXJLci9s?=
 =?utf-8?B?SnJrT2lraHJoN3BnTWpmM0ZMQVRBZ1VPYVdvL09FZ2VDZGhnNUVQbk5HNXJt?=
 =?utf-8?B?bm4xVmFqZGg4VWFXMmdwejV5ek1FN3Bra2xGT2tSaTVlQmlyVTdyc3pnRmIz?=
 =?utf-8?Q?X+5My+fjVPHAQaUQ3jQ7Xz5Z+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799706ad-a9b1-48e0-9a5c-08dbbf64c1d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:19:27.4530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N1k4Kw7v8I3UI6fPj6HWsW88PAaTys6/wgRcIzs8hbyD+v8WukG1eWXpV51hePIwthCF5caWC3Msyltc4v7NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
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


On 2023-09-26 23:00, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> prange->svm_bo unref can happen in both mmu callback and a callback after
> migrate to system ram. Both are async call in different tasks. Sync svm_bo
> unref operation to avoid random "use-after-free".
>
> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 70aa882636ab..8e246e848018 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -637,6 +637,15 @@ void svm_range_vram_node_free(struct svm_range *prange)
>   {
>   	svm_range_bo_unref(prange->svm_bo);
>   	prange->ttm_res = NULL;
Are above two lines not removed?

Regards,
Eric
> +	/* serialize prange->svm_bo unref */
> +	mutex_lock(&prange->lock);
> +	/* prange->svm_bo has not been unref */
> +	if (prange->ttm_res) {
> +		prange->ttm_res = NULL;
> +		mutex_unlock(&prange->lock);
> +		svm_range_bo_unref(prange->svm_bo);
> +	} else
> +		mutex_unlock(&prange->lock);
>   }
>   
>   struct kfd_node *

