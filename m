Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24879C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7462910E34C;
	Mon, 24 Jul 2023 19:51:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8776210E037
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThZVA2IzMlKXIeNymz87rXDKpQPWYB5ysgdVA1cuEp6HDClZXOVseazLHIEMJcGXDb2gDyFFBf7T7zUFzeUDUwwEtWc0PyZ/YebrNfMVeJRpEu1s6CVInHA7MB4jEScDJqY9gF+yUpwoMInqejJBWkb7/NABTDtDDJbUjn/aY2tIpxZz43Vk5/4yxPcQ+9/3MC0aQgY6N7s+RF2w54cIEg1ykwANXYiFgAEP6/WMLbDa11n9xqohMkyzeoTAn5byaM+K/7v1bAnRdGFL/JtXqskFG+hvVXa4tAF01+rUL9005RMH/wujRnnZfh9+f5sJpF/24Y8G1j29/Lz8srdB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IktGk1GWNL18Y8P+c3KzQdD8EvH3YZvxnaaSZLzJYcg=;
 b=IoKYzBOGqbCd05HSPjvhhC0sE4Zh9CFXKg5nkfACbmRXwLtO3WwjnuScKqMEsKpsDJd7di6Fj1l+dTr9SGZ3+tz3VN+KMIEHL/mWY9t2K/ZoVB4R8VSuyUZHgC3usDbzq7Jke1P5dFQUM0gl/r9//hfTASSHOqRTgSmy+xrIccAH5HyJeKi8s4sgwhVr6m6lOyP3/IiAXmYgjMl0l04kjsxiKP5MPusXTzRZcYBLifp0L1Pt00tgUe0GnR021B77DxMBQSliR1mFgeg0lnGr8Xt5abFRV7JlgCu9/p1V6ZXtCHlDKcc2AssZ5cI9w3KMd8ge1w2xVy8ZkcF0oY5Hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IktGk1GWNL18Y8P+c3KzQdD8EvH3YZvxnaaSZLzJYcg=;
 b=IaFDFbgJRI6v1aZkSBiGlFahQY6HxMNtyW/Sv1aVn49beHNemqtj53uglw0/LDwbBxva5jwKtQzpN6F6qGswk1lRJf9wc8+bivOkoKR1IMTrpgun6eFiFE/O4+JEAiyOQ2tEFozO3i0Pi4ckksoAivvOmn9EZMQ4UkEuG/fR/Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 19:51:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 19:51:07 +0000
Message-ID: <7d3bdae7-817b-79e0-a404-096ab089400e@amd.com>
Date: Mon, 24 Jul 2023 15:51:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Checkpoint and Restore VRAM BOs without VA
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20230724155721.1974726-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230724155721.1974726-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0067.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: efd3d609-fb5b-4439-1f41-08db8c7f528e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/eRSUUlCIrQJCW+4kPz1t5FoAy0NcHapxyfGkHTseMCSuF8xIfD+TmukLXJU6QVthdMeWeMcRuuvzXWwg0Z4aYEKgg2r0J8o2WvZdKijgVGHf7OJbTpi8/LSIOPacf6ZXkQOmIohbjw7KaIjglcgn77Q5vqcfBuirmJpsHN08t721NUBuXzez5dmvLQFMM7Pgi8n/61vXZi1ZCIfSYlsLVCRx3lwoFNDjb1TXVLE3kSikmlEykWaKUFvulB+CS2WNP6wrNyH6fmfjQGS+vJlqOLQt+t/bGBCfuhk58rHSJKX4CI+HsZbCVAhB9dlLcMV8i/cY2Kr4FCLO4p0ZY84cTFPyvWgy3YjQUkcygNiR8o8z0MIgnBiMUq0dSuXZCnY8gm0jA2CKEFS0eDqz371fLl5B8ggVekKBLicidQEZhLXxbpZ08QtNhvfGN/VnufSJ2KJFbo25HAHB/MvXkf8rkUSgn9XixnHtTiBJNPz0YKE6Yz6HRXMQ41fyYqjN2gUSDV6Nc5MVYQdGfX/PlHpWQBg4ufvTjtnDf+MJSCM20oMIs0WPaPE1jKz/vAvU5uVDN1I5GBXJ3FBSjPBjS/p40YScLVN991N5mHYL6Nxb8D8wqxbBTsGNp+S8GVbt5B1UiWpXv7ab4Pm3Ahd0QfIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(31686004)(86362001)(31696002)(38100700002)(66476007)(6636002)(66946007)(66556008)(6862004)(37006003)(316002)(478600001)(41300700001)(8936002)(5660300002)(44832011)(8676002)(6486002)(6512007)(36916002)(2906002)(186003)(6506007)(26005)(83380400001)(36756003)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtRUzBZYUFuZzlGRjhTTmhla3NucStGMzJ3VU0yVDhGNTNtV0FZSlIvOGtI?=
 =?utf-8?B?OGFmYmxaRGVNMDdxTEh1V2JpSUlsTk1jNUd4UEZRT242emFoWWJib0pXOWtM?=
 =?utf-8?B?Q1JzbGZRTHJ4QU1GSHZ4UURSMVFoVFNNMUNLZThVS3ZCNXZoV25seHo0SDZZ?=
 =?utf-8?B?NnNsQm1Rb2JzdFhlRHJXYXl4RHRvN3k1enBCN3ZGS1IwUVRKUVdqWlpiVVdl?=
 =?utf-8?B?aDBGbzdGUFBCQWpXTnp4MlVJRUtpYm9MWXpEdkI5R2dCWklGdTE3WEFaUndE?=
 =?utf-8?B?N0JyYkpFZnc0RlIyenFoTk1YZDh5VU5NQTlhRlpVRFhabUpRQ1drUkdVYWg0?=
 =?utf-8?B?ei9PcURZVExSbTE2OWJlS3cwY1FidFAxUE1ZUTlpVlhIUTAzb2NwZHhKakNs?=
 =?utf-8?B?dWlxSktuY0dibkh3MmtFaU9CZWRURCtXTVYzSVhHQWdlNlFOR2MydXh5WFdw?=
 =?utf-8?B?aWE5VzFZMXRRTnlpNXVaSzQ0V0FnZlZtOFh1STRmVzZUbnVGenppaUhRUmpx?=
 =?utf-8?B?RFYrTStuSjZjdExWYmNLMGJHbjBQdDRhMUFIQ3pFTkRGUFhsb3ZDNzc4K1c0?=
 =?utf-8?B?aDdIcTUrejdndU1TYi93MlB3dVVLaXdyT3p0U0IyY0lySERZQnZhSWlGR2Zj?=
 =?utf-8?B?Y3AxN0JMUFdWUzl1VHlMQ2xmVUZmOFlwUy9oMmk4UTdJV1dDSFV5NXUvMWRm?=
 =?utf-8?B?bUZJbjlPQ3hYQ3FiamNMRHBFWWY1VFZxV2NzL2JwOUpEZjhFL1BPMXQwelVO?=
 =?utf-8?B?WDdXSDZUaU9QMzNuaTRyQ0JsSGYvYitFa0MvL3U4eUVIczVUMmpBK2RTaytS?=
 =?utf-8?B?a0xrRHgzU2htV2k5anR0eVQ3NC9ydFlEczVmNG1aZ2N5N01nV2wrMkVUQXZt?=
 =?utf-8?B?bGVOcG84bDVpRFdJTk1GUFdnbzBvdkw3b1VqVmI3Vnc2VHlRS0RtTE4xQ3dZ?=
 =?utf-8?B?d0xpeWxBNU5md3RnYnlXT1JWZjZMc3RwK0VJNW9jUmdwUG5VQTRtNjVhcWhY?=
 =?utf-8?B?OWgwbldIL3lPd0RUelNMZDNCaWpJMC8vMnVFbGt2VUhoc3l5TjcwaUw0d0ps?=
 =?utf-8?B?R2w1Ny9MUXhPVGxWbG9JL1ZVK2lCUnVNRnJYUnhuK0xvZi9EbjJ5NmpidUVU?=
 =?utf-8?B?NmxyaFB6YWNJYjdNRHhNNldQZ2xvQ0MyNWNqUUhtK0dHcERsWmVTSmNnK0pk?=
 =?utf-8?B?bmtBWXNnTVMwNmhuMnFyVDNLTy9GZ3pBeDNleXlaQWY3TEVORXJsQWJnZXBN?=
 =?utf-8?B?RVowMW5kZmhKaFE3SjBHaC9mL2lMcXYzRFhuc3lKZmtGdkN6eUhvMnpTdUVt?=
 =?utf-8?B?MXRST2N4djF6U1NIV1hRNkRuK25lQVlJTll4U3FMYTZaM3JZekZ6dGFwWE84?=
 =?utf-8?B?ZnhOQ3FheVc3YjZtSndTMHhnZzJ1bkpEK3p5dFFrVXFmZEJJNzJSZmhhTUkz?=
 =?utf-8?B?SVRwd1B4RFg4STBDT1hjQ3BKbWkwdnZGUkRvYVV4SXQzVktHRTZKNlM0eWY3?=
 =?utf-8?B?dy9UT3NxcDlreHM1a3Y1SGFYQ3grRjQyV1lXR3BDY00xV2psWUlBN2xoOElL?=
 =?utf-8?B?bGNTTkdzYmpzUTNyci9hSDBjWitydWc0TStLTXpMclEyR2hCME5VZGJPNlBt?=
 =?utf-8?B?SzBNc00yMlJnQjRWN1UrWDFrK1o4TnNQRW16K3ZRSk5rdnNYZ3UyMmRtWjNS?=
 =?utf-8?B?VGtiamhqWXZtdjVDM2lsN2lFeHhjVTZoenAraEZveHZ2LzJNbTd4Vm1BQ1pU?=
 =?utf-8?B?QTNYWjFrenJsdlMwTzlQQ01KU1pCT3VkTHBaWHpkRWJvQ0pib3dhc09jbEFY?=
 =?utf-8?B?TFRpQnROQVB3VU9Qb1dXeVJYaWlDeWNpK0F3ZHNERzlSdlZsTEs0Mm5qZXF3?=
 =?utf-8?B?VXk1bmhUb1l1cXp6eXhZTkQ3VlRPS0RGYWN1c0F3Q1dGTEo0ZlVmZlRrR2Uy?=
 =?utf-8?B?SHNrcjBUREV2bHV3ajhpaTl1SHEvQnA1b2NhQTdEWjVNd0w0MGRSd0Y1V2ov?=
 =?utf-8?B?amJmZ0RUVzBCU0c2ZTZYbHZIVUZZY1RpNml5cy92c2dxZVNoemZBeUtBNVNU?=
 =?utf-8?B?MlpZRUtkaTZIbXcwWU9keTJtMWp5b1ZLbXJkQ29DZjJzVjg3SG51ZHM4N1N1?=
 =?utf-8?Q?/t3xwHFiFIWuyRL1nDzJK0VEm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd3d609-fb5b-4439-1f41-08db8c7f528e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:51:07.8334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21DclKn4LeQ38THFvVyz/YZU6HCK8ysSzJ0AGaHprAzllSeInVl5gI/V7WUQ7eMld6XOesBQJ3LysAqvXLyYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
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


On 2023-07-24 11:57, Ramesh Errabolu wrote:
> Extend checkpoint logic to allow inclusion of VRAM BOs that
> do not have a VA attached
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 40ac093b5035..5cc00ff4b635 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1845,7 +1845,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>   		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
>   			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>   
> -			if ((uint64_t)kgd_mem->va > pdd->gpuvm_base)
> +			if (((uint64_t)kgd_mem->va > pdd->gpuvm_base) ||
> +			    (kgd_mem->va == 0))

I'm trying to remember what this condition is there to protect against, 
because it almost looks like we could drop the entire condition. I think 
it's there to avoid checkpointing the TMA/TBA BOs allocated by KFD itself.

That said, you have some unnecessary parentheses in this expression. And 
just using !x to check for 0 is usually preferred in the kernel. This 
should work and is more readable IMO:

+			if ((uint64_t)kgd_mem->va > pdd->gpuvm_base || !kgd_mem->va)


>   				num_of_bos++;
>   		}
>   	}
> @@ -1917,7 +1918,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   			kgd_mem = (struct kgd_mem *)mem;
>   			dumper_bo = kgd_mem->bo;
>   
> -			if ((uint64_t)kgd_mem->va <= pdd->gpuvm_base)
> +			if (((uint64_t)kgd_mem->va <= pdd->gpuvm_base) &&
> +				!(kgd_mem->va == 0))

Similar to above:

+			if (kgd_mem->va && (uint64_t)kgd_mem->va <= pdd->gpuvm_base)

Regards,
   Felix


>   				continue;
>   
>   			bo_bucket = &bo_buckets[bo_index];
