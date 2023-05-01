Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF0DC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 22:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0982210E125;
	Mon,  1 May 2023 22:09:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A326410E125
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 22:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L34IMD1Szp+fZMGtBgr6gL67ZK9i4DL798jBejucm8picQFbhlY9BEBo0i6puQgoa28pC01sAzmItnUFy9LzrWJwrR7mvJup30hMX4BmXcgQZ+FI1qaKszldaV7LBDniUUP5PPqstiLOu4+gYKh6J//qpLsC81RDt65OgU0kUeaJQ+4TbM2H0rcNMeHDeqeIcbIs9ZhvJGo452Gy1EvQOFmAqdTH9ndncoIDNg11UztdHlz2rKy4ygB3EvmFlm62jcntIRS6ZgueF3lnQWYGo+3RvZjjaTjR8p+lzowd2leHE0RnE0hSN+tOzgDbV7Og3aRIp828L+Svc8cQ/Nioow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlsHb+Tpcn87Di00Qljjmwjfhc+6U4Rhwt4E4iz1rl8=;
 b=kC7u+v0NK7ONvojVvetmIrE2njKcDhet+BqZzD2jjgKQRld22bR2JGhEtTzCEVG00H2kyoaCjnl/E9jONvtBNxSARKJl03O7fUaT7hvgJYphEhLWRZlK3XdMXKRhWA9vkmpxft1O4Fn5F5hAw8k7kEsNkBHPiKL4lpeBUhJKC2KRnpTPZFUmm2xQ5DlMXnRpkB+AHWyRCaSKLbt9AxzBhCe67ilKFSETDSi5tgpRmC2VK+fZjLt4AGv2ms2llj2Rix8x/EU6/xBDvBsfrTQfYz5/CWdRp4EbI/YZ4EcLaB9R/JI8gaDNRwy1eyTor81/58o0V+zaSTe2woTIKnbH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlsHb+Tpcn87Di00Qljjmwjfhc+6U4Rhwt4E4iz1rl8=;
 b=jICElq0wQroKM7ZtcvXpXMmFUxi7CbDBvSIynn4lpinJWEZzPFz8okmNOUk601uTuCc1VyPbgqq4cevu8RCZ6yJ6GOe6hHNOwS/i9ExkK5ylx5zBfQmJg5h4EZbSh1S/9LIgAT5OFQLSZw8/UJVolxdIEm1KQC9G7y5C1SeoJ6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.29; Mon, 1 May
 2023 22:09:18 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9%4]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 22:09:18 +0000
Message-ID: <62c73d43-f77e-b06b-b403-949881281931@amd.com>
Date: Mon, 1 May 2023 18:09:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdkfd: Don't trigger evictions unmapping dmabuf
 attachments
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230501205227.2402326-1-Felix.Kuehling@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20230501205227.2402326-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::19) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 5beae153-5b1f-4eb6-5902-08db4a90b555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXzUL4ce3rxQYvZCilwJ0CiOoKXSykMgHm1aaofhu9WlEpsWFAQ5hQs4Hx0hUArvmFqDq/4HoO4TyGoSxo4PyHc3XOk/iQcxgIZVogeMJcXJdZsiVVTs8VG6rZQKt9MKkNyIuIy+AvVddN9DHJAyAtIubkcgS6pcqQjVoPvOSNVEnoTXCo3hyB691MotpS5Q9P05CxN7lMLZ3zM8z3mFqFKeIWmX8qIl89QAyoWDvzZKEc+dnEE5QAu0j8G5WYKMG2s4ibRiRortYHXs3cR3RpG7JGAi3L44fUA8d3BccKNy8cD8vw9nVDEzVAq/xs1efBrueKUQo8H6HJNSP6GlP9ItHD4GxK7iSppQxm1t7gXrweM5IEHRsXrh65biiCSLyyt3o2ua9X2kbmhtMserhijFFUkyCxhXt6Jt6uC1UuImMr87KOgYXU81dP/OsrOnMVbOxUgYXMQIqCjnlOeby6DGSz9V8+NgjzmwluQ7HMhArUtAtL3gp7ZVrTvfpSB9VUCltcDH84bi9PKiFlKwJC9DDcfn4ckKHSaQE2pa9fyLbXGX3nDkz2cMIbuwfPJcq4ro1ATNrBXLlVeU2ByYC4awguNFm15abtpn4uAKoDfPHz++zmPcyf/U36Cy8JSl/pLSIBEs3A1TmqnLE2xMUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(53546011)(316002)(6512007)(6506007)(26005)(2616005)(41300700001)(83380400001)(186003)(478600001)(66476007)(66946007)(66556008)(6486002)(38100700002)(6666004)(2906002)(36756003)(31696002)(86362001)(5660300002)(8936002)(8676002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVjMUIweWRpTG9SOGthandWVzdTdlJBaWpaWjdTNldFTS9xSjJWNFRNOVRz?=
 =?utf-8?B?R0JoUEJuUktNbzExMEY4QXkwcUFRYjZWUFhXbUNpVGFQbUQ5VzNrc2FNYjJD?=
 =?utf-8?B?dFdXdWdFYlVsOXFXUWF4OURlZ0xwVjdGejYvb1FWMWxGVG1rWmFLZG9ObEdM?=
 =?utf-8?B?YWE0dS9ib1l3dmYwd0NRZUZHUVFJeUJ6MkdsSjFrM2JsaU83dmJOcHJoN0t4?=
 =?utf-8?B?RS9yRllZcjlvMlphTmczRjI3T0xaQ2lYTHBIeTFNRkh4VjhDdml0UUNBN3dY?=
 =?utf-8?B?cWdjRDFkMGRyUVh3bGdrTWd2VDBqalBIV280Yko2TGpJUlNleHljd3NpWTZB?=
 =?utf-8?B?eCtvMmc4Rmx6UEVIaHFQTjVxenpVRDB0SUt4S1czVFhiZ29kQXlKMjFOaFFO?=
 =?utf-8?B?ZUJHei9XYnk1c0NTZlhydFJYZjZ4WmdCL1Jja25ob1JrdXQ5cnFSWSt6bkNS?=
 =?utf-8?B?TmIwZHlicDhHZFU3WG5ZZ1ZOSnlBU1RCejNsZXYwc1ZGeHN2VmQzeDkvcDk5?=
 =?utf-8?B?Sy9aN1VBd0tjRDhUYzlWSktOazVkZTg4TGVlOTFXRmx0UFZxOWVaNWFsdCtV?=
 =?utf-8?B?M0NEQWZ2TzVoeUYzS29oU2RKYUl2bGdTb200MXg4aFZ0cVhPeGRQcEhTVytD?=
 =?utf-8?B?U0JUT2lIMVlzRklFWjRyRkJxZDNydGJrZE5oQm1wVFZkT1o4RjBCdkNJeElG?=
 =?utf-8?B?QkJSdmdOcUZ1bHVoNUNPcXAzSFBzV3JlV3ZVN3dwQnJjY2MzNDVCRWlBMzlw?=
 =?utf-8?B?MTRnN2pyN0RpaElEdGpxNVV1aUo4ZmRKSDlHK2ljOElONXRFV2NWeDlTM0sr?=
 =?utf-8?B?TGQzMVRaNFVLMHQzWGs0NlZiajEyejhlZTFhQjZuTzBuOGdPVU9wN0pHSDJC?=
 =?utf-8?B?cG1KaXMvYnRITVFuVTJHa0lZL1BEeGFyVFU5Uk5kdklVL3hRam5PbkdPYzlK?=
 =?utf-8?B?VnhVZ3RNVGVueEZsRk14bzhyZ2JON2ErN3FaTEViQU5IckVjZXg0R2hId21O?=
 =?utf-8?B?cVJzOU16b29LeTdIQXVWNXJvenpZbXhHL1MrL0dBYXFrdE1XQ2JMam1Nb1M5?=
 =?utf-8?B?ekNmUmVuVk42M1Q1eW9ybE5NUjFJdDJRZlRGUzNSbGdidURuK1poTzFrMWNi?=
 =?utf-8?B?dXdRUHdRMnRQc0w5a2hsZWRnVGdNUjUvWU45K0JQTVNkUm9kcFJIYkNkTEVX?=
 =?utf-8?B?QzdLK3hVTlFOcTY0T0hsRnZMN21oWUUyOGgvSUZKalE2UzdsQlhFR0gwZU4v?=
 =?utf-8?B?ZXo3NWZYTS9PTTdseHpOQW5ONHoyTUQrRWh4cWg4ZitmZXlxdllzbmQ3YVFJ?=
 =?utf-8?B?NnRpQkhSWlgvUTNPQXhjMUJEd1IwQndONEptNW9CdHdKUlRkNW5sRmhidnhl?=
 =?utf-8?B?WWZFOEtpQTA3dHFtRlZqaXZnTTZadjVJMjhsNUhNUmk2MGxiaWc5YUZyZjJx?=
 =?utf-8?B?SmRJazRvZ1VNR1dZRm9QTm5nUGtiekIvWERpNk5VaU1yUUlEdGtJRzVFR29R?=
 =?utf-8?B?YmxlOUV0eWhNcitic2VTUm9TUE5MRGl4SHVKUnZNMngyZVM0VU9QcVp4MmZL?=
 =?utf-8?B?Sy9QYnZzTXVHUW0zd1lZNXRiS2FGRWI5RUFpU1NqY2Z5OW5JUEl6eWpvdzVa?=
 =?utf-8?B?a3hPb2hWYWtnbkZtTzJMS1pyUU5IMkhtL1NMSjY5RUZxWGg3OWJBc1liQTJS?=
 =?utf-8?B?Zm5xMUdyVHRxcUoxRm82OEdReFk0SXBaV3Fza2htOG5FWTZ3VG9iR0k2Sjlm?=
 =?utf-8?B?OExWWVUzdG1vckhXa1Z6TU1ReHc5SEhBSDZacW9jMllITklLZGpYVzBxTUNr?=
 =?utf-8?B?UmZIamJJQWNPMW1BdGhLUk9PcGVMOHFLK1g0QUlqbHF6Vlc1Rk1QelVwTFdu?=
 =?utf-8?B?dmFIQTFBUmE0eWdBL2MrVzR0eWFIanVpRTIwR2podlkyQ3B2WDhZRXlqbGhM?=
 =?utf-8?B?bHdUekoreURidHFZTld4ZjFlcDFvcFRzS0IyWU1kenAvYk1uRWJnTTQ2K3BI?=
 =?utf-8?B?UDZGeVZ3cWFUcHJYa0N3SDk1ZDBRLzViSjU5UFN4RG91dkF4WlBZeXF4YUNp?=
 =?utf-8?B?MFFJbVZuVXZPcW5KMFErM1daZmZNVEpWTXZPQThrOE5vUGFXVDhBb1Uxenc4?=
 =?utf-8?Q?bIloNWrEEb6UfNJkoc+QRDRZZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beae153-5b1f-4eb6-5902-08db4a90b555
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 22:09:18.2951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djosi6bfeJRqqV4cu16TadlyYlPjf0Ni2sKx7kKHNLo4n9Kuf4IXY6wRdQquABPtIvFn40dmCTYDAtsj1N7pyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273
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

Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>

Regards,
Eric

On 2023-05-01 16:52, Felix Kuehling wrote:
> Don't move DMABuf attachments for PCIe P2P mappings to the SYSTEM domain
> when unmapping. This avoids triggering eviction fences unnecessarily.
> Instead do the move to SYSTEM and back to GTT when mapping these
> attachments to ensure the SG table gets updated after evictions.
>
> This may still trigger unnecessary evictions if user mode unmaps and
> remaps the same BO. However, this is unlikely in real applications.
>
> Cc: Eric Huang <jinhuieric.huang@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1002c7834386..bb8e6f6793c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -530,6 +530,12 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
>   {
>   	struct ttm_operation_ctx ctx = {.interruptible = true};
>   	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
> +	int ret;
> +
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (ret)
> +		return ret;
>   
>   	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>   	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> @@ -662,11 +668,10 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
>   static void
>   kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment *attachment)
>   {
> -	struct ttm_operation_ctx ctx = {.interruptible = true};
> -	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
> -
> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> -	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	/* This is a no-op. We don't want to trigger eviction fences when
> +	 * unmapping DMABufs. Therefore the invalidation (moving to system
> +	 * domain) is done in kfd_mem_dmamap_dmabuf.
> +	 */
>   }
>   
>   /**

