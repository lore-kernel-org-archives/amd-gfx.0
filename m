Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6555CA600A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 09:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AC410E04A;
	Thu,  8 Oct 2026 09:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5G+bRAUu";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F3610E04A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 09:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBz0vwTx/G+70quDyYMehp9LptwiQyZ/dQb4UZmFiLbrva6GeNB/N4naC623l9qc+wllsj1aDbZdvyHdwLyq1MkCyQYCX+/DEg1MZbrLgHy6rFAJgXJ4puQ8o/yNgLMNRHeUqR6d6Nuy8NqXaNNVQiVqEEIsup4Wlfi20RCSSiFABShPO/tRaa2sBpq4jUxmDNRxADg9/dWmn1BpcEQbPiXfFEj6feJWw8GfgFPeYorG2IdYF5Yax4oeiBvwn+4Yf7UTanR9r81z0DzGdmIeiCZPEXfKedUTNeAmaGvx9bRkHZGpExFnYrT1k5ENdqYEUtPMjOv0pP1usp3+h3rbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxkzP/hS36JrZsyt47Jvm0zXPkuF98vjwWgDbiNOTcc=;
 b=isig2NI5nbJy7PWcvCHsr72/tnQO9cvXz2GDV46D2hgzGcAd7W4i7Z7I5HqonlBWGOCCmwRS7WVC6Vc0vdfHBlj0P4GmwH7FpQIkRk7njnOx6ePiVaLjd6gz/5awgaO1SO5rhZJ+R2Zk9C2SWkJvlCZ7HQbi0Y3TqjyF9rot8/1JNssLNr5jnz7bbbU7J1knY0dvNrtKJjlZeTcHv+1n3R7wZhLZJGAyGGsM8Ytm+Yx3ciTBEVGRwnSmxqABGbzDy6Bgq5tOv/stGbXgMGJTu6kWLxzSQoj3WOJhCTYvoy7jv1KZryyORixs908X1AOFYD1AmzQPX61qbBN4+VyDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxkzP/hS36JrZsyt47Jvm0zXPkuF98vjwWgDbiNOTcc=;
 b=5G+bRAUuThyRcXotsKOMef4iqKAZCmVB5IkH7soz7r6bBOVvQGOblPm3sMPO6QxIyS6m7qsrcDb8b7zB5WPFK/NjbtmU++C6r+JdrZzgn1pKnJ8Vmkm9AV/9ifN01Nzm8uUEUfDQIqCEuAhV9mUMG/SpDO9kzDHS+DetpstNpjQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 09:18:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:18:22 +0000
Message-ID: <e8edd489-abe4-4023-a64b-1065066c1b00@amd.com>
Date: Thu, 8 Oct 2026 11:18:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: reject imported dma-bufs as WPTR BO
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261008065400.3608540-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008065400.3608540-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: fd33061c-60b6-498a-f401-08df251d193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fty6MhpHNLwRhfoRzH0lD1nD+WKocfBn6NjEdh2uralcPH44XeFbVdSoYs8ZZCf7wXYmVsDpHuFxhT5jfosQiY3f7Y2M38GFjzEjbLPi+o6oGLCJsM83asc5IdrBuqyCG42dWZmSxn2YchzsjCMvYCqK5mIMero1t4D6R6Q0uK949HTpvi81jU/KWNCICo/C6H7N8hhVA88YQ+eshtcfW35aoskpGDXux4LqpDDkbyw9bf6PLLTaLXAHRed4roy3ikCDEJadqEioafLBTJqqTDyDX4l8tLafTSra+MP6q8VfDRmqG/hDeaNMZKCrHFg4/8cTxVUznbwtmukI7RQyskjCbdo7utephGrPi6EY7FfJcRF1WlRN1OfPGWbmXgXkuFEVkeqMpcVWvAei49yzsqHZWHFalSpUBfgwvI9yFSYw1ZZCozLhBrKBfW+6jstnwrKbruyREGKt5935wFR20+LC1bmHoMvGHrhrCGzpd2EkwjGL6VW2rJ+/4wt/KCZbrH5Pw87E9XvYjkPqymQ3MdF0ohhVjAn2crPW0wJVnvzs33p8WlER7RGsttMxi5BUA+5kHpUdAMXLd0cZJdlbj7L9XjDSRlMmr5WE2hfP6r/SJgL/DakfAIxtGmMoWWQK05XzuJeb54JFEPHVsQWpEu8nqNIPOYIdpYTnjxDTCkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJ6dGdMVnZiTS9jZVU2RFJyWkhFNDN6aSswSTBPUlcyMHhyYnczY0F4MlhP?=
 =?utf-8?B?L2dmOElOb1ZjNEZ1Zi9XS0dheXQxcE9TVDdwR0NXTGdaTkFubzdsWERmYjJp?=
 =?utf-8?B?UlJIenlkbGpRaFdxL3lQOXc3QzIyU0ZhR1BPTFRPQ1VSR3hnSFNkT0luaXBP?=
 =?utf-8?B?amhNYUJtTVBwSEpqZktlUnBnWkU0UWpiVzlObE12R2Q2b0pqYWNYa0R2d1kx?=
 =?utf-8?B?UGw0dUc2Rm0vdzAwMTBVUi9zeVNxS3lTeXYyd2NoK2JHUEpjYXVKT1hNb2xX?=
 =?utf-8?B?NHdIbk1peHYxZWFXN0lpM1hVOGFXN0trWnN6Q092MTd5UGU0QzdxS1ZXVnlJ?=
 =?utf-8?B?TStWZzYxUGs1MFZ4czl2cVBpbS9YQzkvQzR4aEJWSWxMUGlNaU5RSThPQ0tI?=
 =?utf-8?B?RnJSOWJEMVBYeUs0WTh6RUxnNHNHbERvV3M1NnZXU0dRMDlXN2tObHlnLzI2?=
 =?utf-8?B?SGE1UEtWWEgzTWEzUUFSeTc2ZzhIcW9ST3gvMnBZOE91eUcvc1ByZWRSbERE?=
 =?utf-8?B?Wk0vMVV1ckZzMTc1QzlSejREU0M5bXA5YnFka28wUXBKdTF2T0ZRbDFyKzRR?=
 =?utf-8?B?WTRlZWZPejhwRnZXcHZNM0FmNENSV1Y1QytUUGVqNHNoQXpSQjhITVlRYVlG?=
 =?utf-8?B?OUUyVHU3QVUwQUxjOFZQTlcrNlB5YjVwZHBycHlmVkdhUk5SRDBpMjFRMGVO?=
 =?utf-8?B?U0Rza3VRODlTbXVzQ3ppQ0RHVXJGRDN6VXljK0NDMUdEQktQbmRNTXJsUUZo?=
 =?utf-8?B?MVFLWWRRZWNlSjlKOUpraFpWQmlVSWVHL0NHbXRZR2xuUFpCem5MVStSdk9R?=
 =?utf-8?B?VHAyYlJEcnRwWGFnZ2JnaGcyR05yZGl2WDVSaFpSVHlYZEhrclBudEMwdHJN?=
 =?utf-8?B?dVdpbVhjY1RkVEtFTERMY1pONHZVSWprQitxWGtNSnlVRU1NaUR1OFFMRG1r?=
 =?utf-8?B?RExVS3pZVW1OLzhJeTBtUGNqMnlYSkZ4NFVua0x6RE1ESUE1emVsbGM4Smpj?=
 =?utf-8?B?L05jNW1OTnlJRFRXRGM2WTd4cmdQelIrVzIrcyt6b2tHUWVUZWZlclhuK3RF?=
 =?utf-8?B?cmk4M3VzUy9tcmRzTVJYRm9KWXF4ODBmaVJrcENka3pmcjNDaGlnRWUzUnZj?=
 =?utf-8?B?RkxKVU1IYXR4SStVWkpMbzRVbDBjQk0xaE5vYk9JNmYrcXQ5clNwOE1JTG02?=
 =?utf-8?B?TUNEaGhGTVQzcUd0M1JwYmh2QUR4WFJaTnJmYk5pQ0cwRk5xN0tXam1ZeFkx?=
 =?utf-8?B?TGMvaENIcUhwVFFncnc4VnA0eEtGVGgwcitad3dxcnFKdUJOSm53MVdDZFRv?=
 =?utf-8?B?cEd1K2o0K3VjMXBJejZNSkdmV0FNQXdCSE00RHFrVGZZcWFBS291dGdqcE95?=
 =?utf-8?B?RGU5R0Y3Z1ppand6cWFucm1KbTBYdHNqYTc1dUg4V1RVNGFUVHhuc3RHdk4y?=
 =?utf-8?B?RlFIWTFSdExNWms0ZGJaYUdrcmY2MGJpWExCU3JJbFZsRHR5UWFnRGtGdllj?=
 =?utf-8?B?b1BiZ0hwdk1KME9TVjNZQkd0YitEZ21sRnZ2MWhJQS9IMXMvaHNQYU5ReUhK?=
 =?utf-8?B?YmxQRCtobjVJS3lkRUhQSk5TcncrcHNhVGU0dndkWFpXS3NsVForT0VnOXhF?=
 =?utf-8?B?VXNGbWpvb0gxaXpmSVhxdE1oTVp2RjBGK3UvZFBYb0ZyZ3VKUHQ2aXYzb0ZP?=
 =?utf-8?B?RXRoYm9idXJza1Z3alRJRzczT2hDS1oxR1pjaGpsa2JHWEZsVitscEhSSndo?=
 =?utf-8?B?M1YyUDRZU21EWnkvam5vVkF1MGFmRWpCOTNIbDlxWE9hVDBkeW1wc2tEaGU5?=
 =?utf-8?B?VmE0TTJCZXl0dFU2d0xDS3BNV0UzaXhzZkRMSnBwdm9yT3JYM3hFME10cFRN?=
 =?utf-8?B?NGJFZjhIZlFHNmpFd3ZZdjJkMzI5OTZNY0FzT1BmNW5ubkNPNzU0N1NVU3BY?=
 =?utf-8?B?eDgwd05wL2t0cjNMVzJCbTh1a2RsQkhmTmJXYVlrT1UwVzFCRlpXK3RJd0x5?=
 =?utf-8?B?eG9CdWRYSGxncEliTmNaeXczakRNNU9FUjRsQTVuRnZMZlBzSEljNHA4Y0Ns?=
 =?utf-8?B?WDVXQ1NnN25BeTl4YlNnYUo1bDJGZ0Y2MVV3Q0VSVFdHZU02eUxmMzJMVjFj?=
 =?utf-8?B?QVJ5V3R0WmpxYlVKTFk1bFlHdmdwV2lvU015eDZ5amcyc3JUY3RxTmNEaDhS?=
 =?utf-8?B?ZmtlWkd0Z2JVSG1wdDNCck1KVVY1ZUhlNnJqc2RsNzFuY1BFQWpQNkdlOGlx?=
 =?utf-8?B?YUw4cnQ1Z1ZrRzI3SEMvcWRqcDlSNXRCeUpoVXZnZTRaYThHalB3LzRRWEZ1?=
 =?utf-8?Q?ihTljCxnsGoFM3NqFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd33061c-60b6-498a-f401-08df251d193c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:18:21.9882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGXmwrlZVfEAtuYpFsfO6+rBuF3OcppZWNB7rpKCrq7RM3veSpxGf3V/wqwdSgQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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

On 10/8/26 08:53, Jesse Zhang wrote:
> USERQ_SIGNAL reads the WPTR through amdgpu_bo_kmap(). A dma-buf from
> another exporter (e.g. udmabuf) is imported as an sg BO without a page
> array, so ttm_bo_kmap() dereferences a NULL ttm->pages:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
>   Call Trace:
>    amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
>    amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
>    amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]
> 
> Queue creation accepts such a BO too, and warns in amdgpu_bo_gpu_offset()
> because the BO is still in the system domain when its GART address is
> taken.
> 
> Reject imported BOs when the WPTR mapping is set up at creation time and
> when the WPTR is read in USERQ_SIGNAL, since userspace can replace the
> mapping under the WPTR VA after the queue was created.
> 
> Fixes: 5fb2f7fc21a3 ("drm/amdgpu: map wptr BO into GART")
> Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

We should probably fix ttm_bo_kmap() to return an error code as well.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      | 7 ++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 118db0306559..a2fa59a9609e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -386,7 +386,9 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>  			goto lock_error;
>  
>  		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr);
> -		if (!mapping || !mapping->bo_va->base.bo) {
> +		/* Imported dma-bufs can't be CPU mapped with amdgpu_bo_kmap(). */
> +		if (!mapping || !mapping->bo_va->base.bo ||
> +		    drm_gem_is_imported(&mapping->bo_va->base.bo->tbo.base)) {
>  			ret = -EINVAL;
>  			goto lock_error;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1b76c10d1ac2..7abb9d95ef59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -54,7 +54,12 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  			goto fail_lock;
>  
>  		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr);
> -		if (!wptr_mapping || !wptr_mapping->bo_va->base.bo) {
> +		/*
> +		 * The WPTR is read through a kernel CPU mapping, which imported
> +		 * dma-bufs don't support.
> +		 */
> +		if (!wptr_mapping || !wptr_mapping->bo_va->base.bo ||
> +		    drm_gem_is_imported(&wptr_mapping->bo_va->base.bo->tbo.base)) {
>  			ret = -EINVAL;
>  			goto fail_lock;
>  		}

