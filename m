Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0E0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 14:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57CDBDEE2;
	Mon, 25 Jul 2022 14:55:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AFCBBDEE2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 14:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbBZCFW1xl4s5NPzyPW0uKS/a+s2/yki9+slgYy2tq7NMD0nqo81pOTyM3xlXBuWAdry2q+qOfdvOQr3W2Og1xbGnWrhsCuc8Ag7oJgFR+wxeHlvvoFb0KbxwnY6ulQ5cEruIriD5f82EFn2c2TWRUKmwTUy2ZAj2YHk5JhEA+nFZocxqReNbRBjDGlee9EP92XyClGIz8JSEGz4/KxStpO7xm2pmYUj42fh1m6EM8n60BatvMVEzpUhYx2FyoxIG2GSvGZqiLaAvFmbgcInPXx+jh2lhjJN2NSuY8VLkXQOnwhyLvwbB58oxvzuFz2Karu7X0MEt0n4vNQU2wXObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7Nc5K/DJFuHpW5TSkcwGb3BaT7iKzLXKerG7ozA/j0=;
 b=CuOZYZX5WDsA819cocjt7U77xtKzfy5NkZTsXgk/17z8U11Fzp3zUj5GsVGdjJjmb4dlykmCI/FxYoLZYXdOtq6Y+pKeT6s8XL+RUWi4bsZQCFGGFa23uBs944obRbXYG9o0y0Q8Mf2PbkrRIYHyC17fl3PqW0D9bZTx8iA9GK5Ka1TPn+vL1OPX8O1KMQlJhXJtFEXURc97UKqaIsTjdz25R7pdocfOg1P2sFkpqYIMQwqKi4WQGa3nbLwKCP+oawUdIeMPgbN0hEMB96ple7bwB5MQpdif6dkyARCX8SSFFO0t6nO5zUAlZcyqtffHPGra6Xb6UntqKNHIPCSpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7Nc5K/DJFuHpW5TSkcwGb3BaT7iKzLXKerG7ozA/j0=;
 b=xc1O6qnk6scYcdFjJa0C6l2C1wHp1R8JGe3EgUKusR6C3PGDBU2pnWpjMVYTmAKyvh1lvE8BuvvfGXQEYJBahwB6migOSmzEEbVQif6fMxXNhBkZ6jWhCVx2OFQT3MSLFks1fCZwCJMadnuW6lxiUoFO6WkaatEEKIPLCz+wG4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 14:55:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:55:26 +0000
Message-ID: <2dfe868f-a2a7-e0f1-bd62-573079de5891@amd.com>
Date: Mon, 25 Jul 2022 10:55:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: Split giant svm range
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725122317.24606-1-Philip.Yang@amd.com>
 <20220725122317.24606-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725122317.24606-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e82c394-082d-4c13-2e30-08da6e4db55e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jw4kBVbdHlZyuBj+3NpbDBKCqHb2kO2NWFKD0gFVkRDdcFCV/CqT4/auJGQ+0QjAzJDhufjUFD7dJURzU4c+HpmHa2wSKL4yyJHMA2G/05/A+2JTXw777Mc10ZpQiiqu9foBfyE1oy/z/KoJrRU3SMwfcNbxkrqQXyxNG3WHGGFAXjh9Pnd9395c+dWi/5Ugby/Eg6pde+CfwYiaZQE3NagRNm58xmZV1euwZbz272W09ZNsRKe01RfaGj8ITnVgWaqhuBaW6TkHdA4jdz6LKzq1zTbelVsPwzxvg88fX68Ke8cd+OT3DCBTJbplTteVg3bhkeBYAFgWZsZ++p5Jpgy6waHjOnz0PdXCNv3O7HAvuKaVbyV9bLNQ5aM0mg0uyx1hlivIjhn3VGuIjpNCUteRUBc48gySs/R88Y8QvC56TAOWZOamRaz1Re+xoFcsV+PsiNhOTI3k+sbkCBJ++MacRUb7+WyrPxmB5gPkZXFftndtn1UEhZSqWZAR+JUURVnY/lOb+y3rQzhjLBThQqZwcUjx0O41EMfnY+eC+sEdcX8qLBeqevhLPFZOSbIi0RcyE0rq+p8tSy6eNVGIJ6A3Vu7wREs/Ff2JlCiiSxgKEN38G+X0tmm8zNVwmBmcOghOR+WkIYiWc1vEwQ/yyox8YHm9HoN/5yH97DlVcScmr1Trr4EP5Azi+c1rbfDI6dI42x4gyafjC5Oo1NCPPJoCy5FmBZ8/L3LcSLXammDlMA4ioLmybIXzwulo7mjFH0OUfRKnbxlYkUxizoPjEUpmmFLJ6Fkyq6YSgWmGM3bOipytimZCirTuaC5ycUvK3f6ygtjtlPN9cAbUtO2eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(8936002)(44832011)(66946007)(31696002)(66556008)(66476007)(8676002)(5660300002)(86362001)(36756003)(6666004)(6506007)(38100700002)(31686004)(6486002)(26005)(2616005)(478600001)(316002)(2906002)(41300700001)(6512007)(83380400001)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJzRHRxOURpS2ZFZk5CVm1RMEV4RzRSU0p4ckp6UmQ4RGM2MHdDbDBlNGkv?=
 =?utf-8?B?ZFlKRERWM2ErWjNKTWNHRU1VdkRKcVg2aDFtWW5pRmZkaWR5Vnp4RFZYVzlh?=
 =?utf-8?B?alN1bUhMdVdJU2NZQXRNRTVJR1IyS3lUVE9IQW4zYU9CWFJ5MGFYOC9jbmY2?=
 =?utf-8?B?VmZXdWFGR091eCtyZXVrSFNiK1gzbGlhS2tnR3BGKzF0YnRHNklsNDZXcGlu?=
 =?utf-8?B?MlBJanJydlhxVkNPNHg1cVFUa1ozT2RmbDJvWkRBQW5ycnZac29UWmxyYmgy?=
 =?utf-8?B?SEdLV2NFam1ZMjBCeXNDeFI0Z0lRR2VJS3lHaW1yTTJaMUQzZEN0ZGZxR2tn?=
 =?utf-8?B?bjhvajN3bHZWUTJqOVhhdkI2TEVzS1kzYXdudkxneVMrcXJKMXVNMWV6ampN?=
 =?utf-8?B?amZLVTNEbVBseFZlUWZzc3k5Q0RrdUdSYmJ5L0xlQXcxYmROOWFBWXRsQzMv?=
 =?utf-8?B?cVhtaXYvMXVBN3U1QXlhQmVKQTJnRTY2QUdHZVpPOGp4N2lrZE9HUWtwRkNu?=
 =?utf-8?B?NHluamVtWGsyaThsZWhSR1d0b0dvRkI3SlhZY1lHQmZ2UHFKekNRL3JVK3hS?=
 =?utf-8?B?L2hJMEhXbWxlZTdhOFZwMXk5U0QrbzJTd3NpajQyVlZLTWdkbVpPL1BjRmFk?=
 =?utf-8?B?N0syUDY3bG1lQTlma1N3c1RQVEttc3Fya3pZNzNKOUV2Mmk3OW1mVlRmTGJB?=
 =?utf-8?B?bm1MQ0I0UDBwOFArWlIvZXRrcTJFaWYwUTlFLyt5aVd4QVdtc2hBZnhOa2xQ?=
 =?utf-8?B?T1Z2cVhYRTRGL1dqNXUrVFF2dndaVFhRVUZoYWdheXdRTnNQOTlNdW5ibzR6?=
 =?utf-8?B?dDd1VTI3bVh6M2VBRnp0K0hMM3p0eThTK2tJaC9jaTllc2VuTjNOckd0L0xS?=
 =?utf-8?B?SHFpenprSEhYN2ZQUEh2WDQxWEQzLzFuN29SRVhxZy9nYVZCaEtPNThsWUx3?=
 =?utf-8?B?aUZ2SnY1ZjB4ZTk3NnZ2a3h1ZDlnUWx5elF5SStxUUo5WXdiSVNUeHlyVFpC?=
 =?utf-8?B?UXhNbnQ0UkpMc0ZDcU1XRkwvek9LektkczlHVjJ4MHdqc3dsOWJXS3NOa2hz?=
 =?utf-8?B?WjU2aVlYRWdUbjhYeUVsdVd4MVozQ3prblRTSTZlM2lXWnJLMEw2ZTcrbWRp?=
 =?utf-8?B?Vi93bzErVm5QYjlZMTg0R3pwVEdRL2I3VGhIY2dOekRMakJod2VXaDVLRy9L?=
 =?utf-8?B?TU1CcE1WR2RVSEY3RXNOV3IxR2RLTVc1VlEyUU9pZnd4V3FPTGRkVXZjRFFY?=
 =?utf-8?B?SU95UjNZa0ZBclI2ZnVyMG5WUXUxTjNGb0lqci9sMXFKelpaTEhzaXQ0N2RC?=
 =?utf-8?B?YlRWVUJYUzhIa2VHUFVOdzAwQUg5d1dVVkZvKy9jOHhGR3FUT245SVBPNWZU?=
 =?utf-8?B?VU40b3AvVjcwOUdWYzFpWFh4K0F4K2xvVURXaldUQ2U2emMzd2hPVWNRYTlk?=
 =?utf-8?B?SjQ1ck5xYyt1ZkhuNldVQThWNDA0T2srZE56VzMxUVJyV3llZzd0VGRVUVdB?=
 =?utf-8?B?aURnS2h1VnkxeTZZQk4wRFhhSURvdHJJTm1ob0c5cU9udnVsOENkZ28vazl4?=
 =?utf-8?B?Unlzb1ViUUtaY1puanhoejRaTW5MaWZGYU5xbFA4a3NmdHZ2SnBqZmZ2aUtY?=
 =?utf-8?B?YVRlU2Q1bjByUE9kZnB2RitpeFFNN1UzYVRTc003ZkkwNUVsYjBlejlrOGox?=
 =?utf-8?B?cjhEMEdkeXE2MUM0V2ZEWm5FR3BGdVNLZkppdktObWpkeW9Xd0hneXdjTndV?=
 =?utf-8?B?dVRTa3UraFRNRFI0ZjZ2dk5Pd3F1N2E4NVRQYjNHTGhneVM3MnBlWUtGRHgz?=
 =?utf-8?B?aldaeU93Nk5TYkNLMWRFMGxpc2M4VSthdDgveEpkbUlkZnpGL0YybTc1VUtR?=
 =?utf-8?B?UjZqdjVuVWFCNDMreVhONFFabGgyWk1ScTdaa2tLUFExWmZ2QUttaW81dFZz?=
 =?utf-8?B?NG5nelZ1NEgwQTRIN2djbXBGUk9tWGFIdUxISk4zaHRnL3V1c2JOVCtmRDd0?=
 =?utf-8?B?cGtQeHlFakxhMzY5YitJY2JBY1kzVmZmMm4xdlpBRGlYUFFVNkcrVWdRNzVH?=
 =?utf-8?B?aThDVjZIb3JkVS90NTBhY0VZSHhYam9ueENCcWxhM3ZMWG1ZdHNDaHJlazh2?=
 =?utf-8?Q?NAWtx41+P8biKd6doOJOYHFLe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e82c394-082d-4c13-2e30-08da6e4db55e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:55:26.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6IqgV4h7TCuYuTL2fJE9Nts48NNTKPJxYFDAh2EAs5QWZuXS6iLjYghO7xFTVxDyUSXTSTxbjFtvnhmeFn8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
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

Am 2022-07-25 um 08:23 schrieb Philip Yang:
> Giant svm range split to smaller ranges, align the range start address
> to max svm range pages to improve MMU TLB usage.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 52 +++++++++++++++++++---------
>   1 file changed, 36 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cf9565ddddf8..044bb99f88ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1885,6 +1885,37 @@ __init void svm_range_set_max_pages(struct amdgpu_device *adev)
>   	max_svm_range_pages = ALIGN(max_svm_range_pages, 1ULL << 9);
>   }
>   
> +static int
> +__svm_range_add(struct svm_range_list *svms, uint64_t start, uint64_t last,
> +	       struct list_head *insert_list, struct list_head *update_list)

It would be nice to find a better name for this. Maybe 
svm_range_split_new. Maybe make the max size a parameter of the function 
for better clarity.


> +{
> +	struct svm_range *prange;
> +	uint64_t l;
> +
> +	pr_debug("max_svm_range_pages 0x%llx adding [0x%llx 0x%llx]\n",
> +		 max_svm_range_pages, start, last);
> +
> +	while (last >= start) {
> +		if (last - start + 1 > max_svm_range_pages) {

Use a single READ_ONCE in this function to read max_svm_range_pages into 
a local variable. This should avoid race conditions with GPU hotplug. If 
you make the max size a parameter of this function, that also works if 
the caller uses READ_ONCE.


> +			if (start % max_svm_range_pages)
> +				l = ALIGN(start, max_svm_range_pages) - 1;
> +			else
> +				l = start + max_svm_range_pages - 1;
> +		} else {
> +			l = last;

I think this whole if block could be written as

     l = min(last, ALIGN_DOWN(start + max_svm_range_pages, 
max_svm_range_pages) - 1);

Regards,
   Felix


> +		}
> +
> +		prange = svm_range_new(svms, start, l);
> +		if (!prange)
> +			return -ENOMEM;
> +		list_add(&prange->list, insert_list);
> +		list_add(&prange->update_list, update_list);
> +
> +		start = l + 1;
> +	}
> +	return 0;
> +}
> +
>   /**
>    * svm_range_add - add svm range and handle overlap
>    * @p: the range add to this process svms
> @@ -1987,14 +2018,10 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   		/* insert a new node if needed */
>   		if (node->start > start) {
> -			prange = svm_range_new(svms, start, node->start - 1);
> -			if (!prange) {
> -				r = -ENOMEM;
> +			r = __svm_range_add(svms, start, node->start - 1,
> +					    insert_list, update_list);
> +			if (r)
>   				goto out;
> -			}
> -
> -			list_add(&prange->list, insert_list);
> -			list_add(&prange->update_list, update_list);
>   		}
>   
>   		node = next;
> @@ -2002,15 +2029,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	}
>   
>   	/* add a final range at the end if needed */
> -	if (start <= last) {
> -		prange = svm_range_new(svms, start, last);
> -		if (!prange) {
> -			r = -ENOMEM;
> -			goto out;
> -		}
> -		list_add(&prange->list, insert_list);
> -		list_add(&prange->update_list, update_list);
> -	}
> +	if (start <= last)
> +		r = __svm_range_add(svms, start, last, insert_list, update_list);
>   
>   out:
>   	if (r)
