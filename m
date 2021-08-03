Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD78C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 21:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A118660F02
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 21:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A118660F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560F589F3B;
	Tue,  3 Aug 2021 21:07:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4335A89F3B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 21:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m06xgYZVxqD+zrWARqaHonunwXiaG2DQb6hVL1cZRbdOiCqMI3d2/VIfo43frcom+kHc57M7x2NRZ718QHqneE+wNtr6soaFEr/vSmC+sbBJp09P2ieMvZpFp41/h+66MjMARJxyP3A0te6UJwHyhoIk2Pf6Pe7aR3wgZA84BxxP0+BdE0jZTVfOHmahDQjcyzXv7rXSRYM1YFnfviobj1OvcLKVkWNjFkBu4S/wBuuiRn32WzjufW9LSV333zsrIETX3IF9SbvhrCNGtFTqf/hgAqVsCJeD7w3pDWlZxzIoF8bQ72fZPNx2p8oEqlB2G1O3WZlxkqzUNwds+nLvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19LcN7ZzqhEfxL9BHTe6YUl17KsbcAdvKHlGMVtdW84=;
 b=npRWiQyZsyTayTQFj8nQfVQZ8bQf5wRvRtdMPC+81cX9YzzXigPoZOXZ3AXVyDO/fNxBb/xRUs4tWzMql8BIcMFck3qNLzXxlCjnOWwR6yLcib2FSsainX73CNp8PT8wokqm35oBfc3eey4ikcYuN0zCtOPmMovhHgtp6MQkyvwQObGCyy6thqXYLtBMtzVXGW6DyulrW8e5khVNwtRqF/m96NUbfHZTmcG2CSRcRmAS0tBhiWAlXEL9bLwNIrxJBody8Bdr4LAMzLWsjWyD4wivVxSrCoSVDn4ZjQ6GPzNVzKvZXgsC5gjB9lWpPml5rSaw5quC0EWMbTsGBUAtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19LcN7ZzqhEfxL9BHTe6YUl17KsbcAdvKHlGMVtdW84=;
 b=hDwqVwRfKd3ikSTXEfuWJ8Bz2oh4B2At/hh4E8PjJ5/5jL3BLSmP0/bgyfXz5gkeuBL/CaZ+cEGdGTq4ESQUTl+ufBr8foOH2iTXhsYOplQlMFne2BpcA6JxhlK7NOq5MX0psulyubeV9GjWUzOyZwKTkKurmZ2csjJA8PML6gM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 21:07:00 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Tue, 3 Aug 2021
 21:07:00 +0000
Subject: Re: [PATCH] drm/amdkfd: AIP mGPUs best prefetch location for xnack on
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210802162806.12631-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7c36e2cc-a92d-7e40-d236-d6eb6921bb4b@amd.com>
Date: Tue, 3 Aug 2021 17:06:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802162806.12631-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::21) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Tue, 3 Aug 2021 21:07:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ec7111-f364-4495-462f-08d956c2a2e7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB516170C4E02FB8DC04D416B092F09@BN9PR12MB5161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxfLwQgfS+55xTuhgn8sHnS/hKzZKspEGvY/3XSqgpo7a5YkFnCE4W4m9habgTsiesEzXwzOF5N4VM78VXMNSaMzsYqR9DKURq40Iv1KEdi0gcWcecJ6s+i3KGl19bTV50u7NExlVfxcZLWI6yuWM+67Zva68beZJ+eSXSsxbPtX7TtR11vqVR63tYuRWAfyujNUEGYsLCTW/YV+L8ycjgJfA7I/SK5i4WKm2sLnAdZjKZ8G93BRpjjAWs9S+Yui7VhkPE19f5eJmrANBr2oRXvRJ99KN0aJH6yctSE7W/v9r6SmeRsk7VOg5j+9qGwHt1FYRO4jg8xc9nxbUT3lL6kwm4yQYb+QhLQ978A5qDPHux7jhZws/bANdybQZ6uLP7w3pS6t1fat1ShyTF8j+4e7OnDw2EamH6iJlGrcWB0D60kZmJ2InBw1q98E4xzZfDhbOAgWFEmoh975WQn1+T8cFCBmPq2HU9efsThtOFpLi5SMTxk0W21oZfPSOvyrY+WpYlcXS8HE9QzoY9QAwE3I3Sbn/WDZcvSDtMj/75g9sly/CLJB/22RR5XoDwz6amFqZaO+jOZ/yXAbzU4Rwf0CBK59fjstdJsrzl5cpNKxBnVzhHBHjZuFxoNWGv5D9QK2I6RaAgnPhysGcwnjPhivVzCIXf/m4dtCqW+/sCx45sQRs0miEg/piEY098iqX3Sr4hcjseBx9HNW2nNuIrbnTSaVCgQ2jw2E5DjiGdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(66946007)(44832011)(66476007)(66556008)(83380400001)(186003)(5660300002)(86362001)(2616005)(956004)(8676002)(6486002)(8936002)(31686004)(6636002)(478600001)(37006003)(36756003)(316002)(26005)(6862004)(16576012)(31696002)(38100700002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZyYWlWdnA2Y21vWVN1eVdreVpmcE5DdWtSS2M0cFNIQWU5cDFOd2tSYnlv?=
 =?utf-8?B?YzJ6UDdhcGFJSmg0cTdNd1BWVGhVZXNxY0dBejBlSHVBUjNpa3RUMzlBT2JB?=
 =?utf-8?B?ZE5laVZ2Y3pWd3MxTWZHdTFTUkFVd3RYV0s3Rm1uVjI0aWhjbnU4bHdlU3pC?=
 =?utf-8?B?OW9HMTV1cHRTOGE3a0tpUXNUZllXS05HSW42OFJBV0YrUnVHQ3gybkVKMDFo?=
 =?utf-8?B?UWZEWDNzWEh3VjF3WGxpVzdHTzZnb0ErS3lmT0VvbDJSckFMeGpjY0M2Nmky?=
 =?utf-8?B?U0l3em9aZkxPRzMzVERmRzd1SVpsZ0ZmWVR4OEhTTFhCZmtCbEdPUGl3cjFi?=
 =?utf-8?B?TmVnMnoybENzZnIrUTNiUWNmbUxDalNtaDFJOW9kWVFZNU1GOUo0QjZjZXVX?=
 =?utf-8?B?NmFOa3ZIalRFakNuMmdoanBOQ1loenRqTEtWWHV4MDNxa3BwTHVLblQ0Q0hm?=
 =?utf-8?B?UzdhY05NWVdNR20rMkxCMDRFMDBHNVVDTDJ5ZFIwRWFNbThXNVpaUUduYnZD?=
 =?utf-8?B?dUNqNWFERFhhdkg4NUVVbkI1VlhqeEJycEpKWXdjdHZSSUlUTkRLVzFGWVJn?=
 =?utf-8?B?WFNyRk1LMnUwdEJQSlpTS3pJakkvTUpxeWpJYUhaVVBYZ0hyN2p6TUdPQUVD?=
 =?utf-8?B?dkJDTnRFY3V3blRwOGRIQnc1TmdsQlp0Wm1Pc21nNHp6YjNibDcwanQzR3Rj?=
 =?utf-8?B?K1pPazBsUlEvWms3R2FPTS9IQ1hXUWNtcittbm5Md0k3MExvejh5dHFPOUo0?=
 =?utf-8?B?TUhDWXcrZlRZR0FhcGl0blYxQU5nYWJIS2lQZExIS2Q2QmV1Ry9tR3FvbU8y?=
 =?utf-8?B?QnZMOWdBcTloN1ZtRnRjRnE2bFNqY1dJeTF6SUpOd2JnRGV2QlM2aDZrUXlD?=
 =?utf-8?B?U21YK0dDSWRhRHRza2UyZHVWeFFhaDBOcytMK3BlRE1ldE8rUUdvT0lOTi9B?=
 =?utf-8?B?Y3dNdklaZFhCR3VIWXR2a0YvcDkwVXpTWmZhaHZhRVNLTnBSU2hyeVlBSGlD?=
 =?utf-8?B?aUk5NGc0WVFwU09LNFF2dDkwZDh0ckF6TlN5ellacy8vUk96ZEkxbGVXTmY5?=
 =?utf-8?B?ZldVYWFIUDdzOVBWKzQ4WVh4Rit1dnh3QUVScmxWc2FLS1d0Z1BqNDhwcUNF?=
 =?utf-8?B?UytjeWRMRVRWRVRsOXNXbTJyK0xOaGVWeTcvU0JMUnhrUXUydWc3YlIvZ0dj?=
 =?utf-8?B?aGRERXlISjhJOTFWNllEQTludFJtMU9LeFd0bHNHdkZ5bkI3ZFNCVFQyV2Vr?=
 =?utf-8?B?SkE0RjFDTktqZXRDaXh6NDl5WlRmZzJFT2lhNU9BK3lkUXhjdlp4VkxkR2RU?=
 =?utf-8?B?cS9QOEN5NWgzQWlYa1AveGNxYXVvYS9lWGZKLzVvZkhXM1R2alhOaG5peWxP?=
 =?utf-8?B?ZVdtQ2NHV1FodTBIRjNYbW00S0VTQ3FXa1NRcThSMERETENOdGYwRTVqQUxC?=
 =?utf-8?B?cUsrTHVGbjV6RUY5SnJoeCtVZGxBUXNqT0hYakRnajh2Ti9KTVJub3VjOC85?=
 =?utf-8?B?Y0JCOXgzUnVweUcyVnlLdmZUekloc1ZsNE5oZkl4QnNRWWZ6OHFBdHZSWjZw?=
 =?utf-8?B?ZFJjQzhIUTRRRC9FWFcwRkpQQk1tenh5V1V5YWJBZFU4c2oxK0VLUHBtMFk1?=
 =?utf-8?B?UHo4SWJmNGU5MzdvY2lickdFYjg5SVVLSlVuQkdHUFJDZCt0dGxVL1FremFB?=
 =?utf-8?B?ajc5akoyN09iQlVXd1VKUU1Zbk10V2xUZGRlRk1KU3FxS09IQjJRd3BMSW5t?=
 =?utf-8?Q?LqJEU/1XFJ03S1kE/Z7k4p/gfQHuPSN2lGz+zMV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ec7111-f364-4495-462f-08d956c2a2e7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 21:07:00.7610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiI8kBfdFyFU2dFDd9tux9IHUnTxqDoLmPl+sj/tVPXwAhtKS/FxKUJ4KpYYinr6gqOGxT6c7Aj/HJwGh1f8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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

Am 2021-08-02 um 12:28 p.m. schrieb Philip Yang:
> For xnack on, if range ACCESS or ACCESS_IN_PLACE (AIP) by single GPU, or
> range is ACCESS_IN_PLACE by mGPUs and all mGPUs connection on xgmi same
> hive, the best prefetch location is prefetch_loc GPU. Otherwise, the best
> prefetch location is always CPU because GPU can not map vram of other
> GPUs through small bar PCIe.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 44 +++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 69237d2ab2ad..6160c301f78b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2754,22 +2754,29 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>  	return 0;
>  }
>  
> -/* svm_range_best_prefetch_location - decide the best prefetch location
> +/**
> + * svm_range_best_prefetch_location - decide the best prefetch location
>   * @prange: svm range structure
>   *
>   * For xnack off:
> - * If range map to single GPU, the best acutal location is prefetch loc, which
> + * If range map to single GPU, the best prefetch location is prefetch_loc, which
>   * can be CPU or GPU.
>   *
> - * If range map to multiple GPUs, only if mGPU connection on xgmi same hive,
> - * the best actual location could be prefetch_loc GPU. If mGPU connection on
> - * PCIe, the best actual location is always CPU, because GPU cannot access vram
> - * of other GPUs, assuming PCIe small bar (large bar support is not upstream).
> + * If range is ACCESS or ACCESS_IN_PLACE by mGPUs, only if mGPU connection on
> + * xgmi same hive, the best prefetch location is prefetch_loc GPU. If mGPUs
> + * connection on PCIe, the best prefetch location is always CPU, because GPU
> + * cannot map vram of other GPUs, assuming PCIe small bar (large bar support is
> + * not upstream).
>   *
>   * For xnack on:
> - * The best actual location is prefetch location. If mGPU connection on xgmi
> - * same hive, range map to multiple GPUs. Otherwise, the range only map to
> - * actual location GPU. Other GPU access vm fault will trigger migration.
> + * If range map to single GPU or is not ACCESS_IN_PLACE by mGPUs, the best
> + * prefetch location is prefetch_loc, other GPU access vm fault will trigger
> + * migration.
> + *
> + * If range is ACCESS_IN_PLACE by mGPUs, only if mGPU connection on xgmi same
> + * hive, the best prefetch location is prefetch_loc GPU. If mGPUs connection on
> + * PCIe, the best prefetch location is always CPU, because GPU cannot map vram
> + * of other GPUs.
>   *
>   * Context: Process context
>   *
> @@ -2787,14 +2794,13 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>  	struct kfd_process *p;
>  	uint32_t gpuidx;
>  
> -	p = container_of(prange->svms, struct kfd_process, svms);
> -
> -	/* xnack on */
> -	if (p->xnack_enabled)
> +	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
>  		goto out;
>  
> -	/* xnack off */
> -	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
> +	p = container_of(prange->svms, struct kfd_process, svms);
> +
> +	if (p->xnack_enabled &&
> +	   bitmap_weight(prange->bitmap_aip, MAX_GPU_INSTANCE) <= 1)

I'm not sure why this condition is needed. I think there is an implicit
assumption that the prefetch_location is the one GPU that's set in the
bitmap_aip. But is that really a safe assumption? If you're prefetching
to a different GPU than the one that needs to access the memory
in-place, then the access is still going to trigger a page fault, so
it's not "in-place".

I think you can just drop this condition. It's a questionable short-cut
for something that's handled more correctly in the loop below.

Regards,
  Felix


>  		goto out;
>  
>  	bo_adev = svm_range_get_adev_by_id(prange, best_loc);
> @@ -2803,8 +2809,12 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>  		best_loc = 0;
>  		goto out;
>  	}
> -	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
> -		  MAX_GPU_INSTANCE);
> +
> +	if (p->xnack_enabled)
> +		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> +	else
> +		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
> +			  MAX_GPU_INSTANCE);
>  
>  	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>  		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
