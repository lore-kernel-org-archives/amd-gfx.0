Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FFC64E7B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4ED520725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pNmaruDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4ED520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3C589A4E;
	Mon, 30 Nov 2020 22:54:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487E489A4E
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 22:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG8i5y0z3OfY32q1PsV9GXpt4CBqW3Ruyd63ULzoLCs87kbPRhDClj31GzyUQCj6yOGZfpIPCcelSunF3xP3tQYLs3HJhNjlFzkPTh6ksfzmQbVsCkEORQIHAh0BRrHcV6du4lfsAPmJXRmF5lA3onm4SH76CqA9i6grQSXD9TPAmXm7ZX+61+dFFZ92vFh8vnC8zphXbVmIcr45iBa4CTUPiWIA7W4O3PKqINRtPXkNRJjiIw3l1fTddIgYx3fZLobNtcV7B3kUY60bAZ6FhOpMfggZeIiLeUe8iM8v8CP5kZW3CFPJiubRSAdQQkKgyCNIOBpBc8RGwkStfHCr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shtNgrD0OW9kwHuakpFvDkF0EeUwVvAixCsDf5AvDNk=;
 b=RznbXgQyECW8+3FWQvSNhhSpQEqgCI+i7cWtlEMPJAB9fz4QKYndZW8MdHtsIWP0Cy7I8MOEh8/V+VavUQexdnhQf43wxuhnLl7p3EPU7+v2AFUM0g0U+Sgud53wKvsWiI+w+O+kGfAPDMT5IXTfEl+lH4GnBH+wwO0/loqSItaibpdZuUkgFR72Pb/sMkrvTC/KCZY0gNPphTjnWQAawuF0itLlnfeT/IckS3DAqfIl0I0fNH7g8J5GWH5ayD3w/Xl4E/2Fb5oRSFRi4pYztHCPq4ne6K2tfENk7rSqA/cLWb8LB3a45L1BTsYRoV7MFn3i7xrWTcZlFbOTQ7+aHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shtNgrD0OW9kwHuakpFvDkF0EeUwVvAixCsDf5AvDNk=;
 b=pNmaruDdhd8wNlmelK6slXOzX43zMflGaXzNWDETznGskb/o/FKePy/rqXdi6UIe5gpjk9CZl+NpRPbnTC5jwpww7rD96lPlR9UsUVd2+j7Li/blQ5tWQsiI9DWXSM/L636OitcJLWJt4FJJOirLGqDPL6Tjzs72OxLPN7uD7Ks=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2387.namprd12.prod.outlook.com (2603:10b6:207:44::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 22:54:47 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%8]) with mapi id 15.20.3611.024; Mon, 30 Nov 2020
 22:54:47 +0000
Subject: Re: [PATCH] drm/amdkfd: keep BOs in system memory if restore failed
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201130224832.2498-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1915dad2-db17-cb77-8a07-f3f5d14351a8@amd.com>
Date: Mon, 30 Nov 2020 17:54:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201130224832.2498-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 22:54:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86359445-dd20-4b22-8cd4-08d89582ef96
X-MS-TrafficTypeDiagnostic: BL0PR12MB2387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2387AE1E9AD160BBB3707C0692F50@BL0PR12MB2387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/ZOtWuctpJMXYocqUMHVXQjtGELz9ly5b2wDxx49ZMUsJCHPWM2KBeBBd/m8on6FC9m+MIbcYfyPyU7ZjYiSq35xdH1c3R4MqUcdeD+Zd7XNc++qZg8KdFxNJYrh0nhzUTWupQP7Jzzt8OYWyhYALkZd1qKKFJfdxjk1rv1c38WNX613segwk9gaAGqM2DY8RDWMmRKdAM+nGesYLLlJguBJ2jIp0VW2tKHs2aNFw8ZNJUcSiKeb+1crRKTIzPthQFkqsrHnM76KRJyRkPzGnAdBubm8YGgvPlGQ52n/JP24w3HumAnYgZgHfv+nszqYHtG6P6ntlC3rZTiSmvesOdEyxQgept7libpR2QSoWqeNJ3ATAvI0E7JHiNiSllw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(2616005)(956004)(86362001)(52116002)(8936002)(4001150100001)(44832011)(16576012)(31686004)(31696002)(36756003)(66556008)(66476007)(6486002)(66946007)(5660300002)(316002)(8676002)(478600001)(186003)(16526019)(83380400001)(26005)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnY0amZVYlQ3bzJUSGFlUXdOQ2hxbjY3K2VzVThLdUNvMEh3L0gvNmJ2VzBy?=
 =?utf-8?B?ZmpTdU1vNmZ0NkN6UElVdUNlTkd5Y0NIb0t1UzVsZUFDaVZLeUIxT2VLNWN4?=
 =?utf-8?B?SVVweHNYeXh6UTBIU1UwNUF4K1VWTHFZeEVUL0h5WVZBa0YwSThTc1ZaZVg0?=
 =?utf-8?B?NTJoNlJkSVVTSGZ0ZVQreUZTMmgzSkJCZ3ZjVTBwWkVFck9nWEJMUzhGcTBh?=
 =?utf-8?B?amRNWkZIaCtFOG03VG1JQnE3LzFQU0w5Y3VGMjA2UG9lYlVJVG9ab29nQVpm?=
 =?utf-8?B?aEVuSkdUbkk2T011V0EvRkRGMVpCTThqOEhMU1pUQ1g5MWI0Z2dscDZ6ZDhW?=
 =?utf-8?B?VGdCSXVtZFRoNFRQSGQzZFRuQUlpOWpKTHp1Z1lPcHM4ZFVNUlM2enVTSUsy?=
 =?utf-8?B?TzdWZVBvUU44ZWRLZVFiZEZSL3hCTnBpSExxM2RLNEx5TjFWZHdnUS81elNP?=
 =?utf-8?B?d3ZUYldSWVpWZ2llY2I2Q0ZsVDlwTThycXFJK2FFMmdnckNTbUd3ZHNBYlRL?=
 =?utf-8?B?WTcybmtzcXZCaXRjT3ZaVWgzL2dyZkxUTG1sMWlvVy91Q09HQnNZSUtBVVE4?=
 =?utf-8?B?NW5sUllmd2ozUkpTNVVVQk9CZVJEdStlajA4ZGF1Qk5GTTRsODV2WElUWGcy?=
 =?utf-8?B?ZGRkd2xjZmhrVnhZUUhFdVFibUlrUGZta1dIcFNWNC9OZGpzUTJNSXZxcGxH?=
 =?utf-8?B?MllMMTI2eTZPWUNldFFBL2daNVViaDhESEgvUlIrc04xNFYvYmg0SFZCN0F6?=
 =?utf-8?B?L0V4RTF5UnVCNyszNnZYM081M3RldHZydkZxQnArVGs1UGtNaTRBSFcxNDM4?=
 =?utf-8?B?TThGckRwdFRzM2QzWGQxOThVV3R3K2p0QytwVElSc3hKZnVzQkp0OWFJTFhI?=
 =?utf-8?B?by9UUVlwMm9QSWFUNVlSSm15NjVGcDhPeVQ3NU1oKy92M3BxZ3VuOVU1enM2?=
 =?utf-8?B?WEFwNHVnL2owajFLSEwyZTBMYzR6dFd3Vmxab0JEcUl4SEhJRVRIYmNQVmJ1?=
 =?utf-8?B?UmVQY1RXdHlmbFN3VmwyejhIRkFvcVhRZWpHSFlpL1JCMm5VRWd6WU5FU1FT?=
 =?utf-8?B?UU5DbC9lRlVvMnVnalVwMUFTVHhhZTN2SG55bVlEYVd2dHgyZFVqQ2drbkdB?=
 =?utf-8?B?VXN6RVJjaUJnZ3EvN2RkcWE1UGs2VzRzaXlsbzZnR2pKMUx2UXRseVZUTnpm?=
 =?utf-8?B?Z3l2Yi96ZkcvYXBqUUJTcU5ZanRaOUxTRS9hS2RDR1l3ckprQkRKeFdCajlE?=
 =?utf-8?B?MExpbytVTitzUjloQWRidmViMWI1MGQ2SVN2NTlSTmxxSlRRSEQ4c3RCaldK?=
 =?utf-8?Q?PupJ4twBNdwg98gwRniKsQjapnFPqVWxmh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86359445-dd20-4b22-8cd4-08d89582ef96
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 22:54:47.3481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxp5G8BRZDvvNbQm9l9Xa0GO08orIlK7Lnmmuue9Wt543Z9GfIXoRpvYBWsOOXtSJgcfWZWhju+H6ChnexZRAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2387
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-11-30 um 5:48 p.m. schrieb Philip Yang:
> If vram is used up, display allocate vram evict the KFD BOs to system
> memory. KFD schedule restore work to restore BOs back to vram. If
> display BOs are pinned in vram, KFD restore work will keep retry, and
> may never success.
>
> If restore BO back to vram failed, keep the BO in system memory to
> prevent endless retry restore, and GPU mapping will update to system
> memory.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 703cd5a7b8f7..e54883ff74d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2042,6 +2042,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>  	int ret = 0, i;
>  	struct list_head duplicate_save;
>  	struct amdgpu_sync sync_obj;
> +	unsigned long failed_size = 0;
> +	unsigned long total_size = 0;
>  
>  	INIT_LIST_HEAD(&duplicate_save);
>  	INIT_LIST_HEAD(&ctx.list);
> @@ -2098,10 +2100,18 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>  		uint32_t domain = mem->domain;
>  		struct kfd_bo_va_list *bo_va_entry;
>  
> +		total_size += amdgpu_bo_size(bo);
> +
>  		ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
>  		if (ret) {
> -			pr_debug("Memory eviction: Validate BOs failed. Try again\n");
> -			goto validate_map_fail;
> +			pr_debug("Memory eviction: Validate BOs failed\n");
> +			failed_size += amdgpu_bo_size(bo);
> +			ret = amdgpu_amdkfd_bo_validate(bo,
> +						AMDGPU_GEM_DOMAIN_GTT, false);
> +			if (ret) {
> +				pr_debug("Memory eviction: Try again\n");
> +				goto validate_map_fail;
> +			}
>  		}
>  		ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
>  		if (ret) {
> @@ -2121,6 +2131,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>  		}
>  	}
>  
> +	if (failed_size)
> +		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
> +
>  	/* Update page directories */
>  	ret = process_update_pds(process_info, &sync_obj);
>  	if (ret) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
