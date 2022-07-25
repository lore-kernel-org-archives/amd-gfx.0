Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03130C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 18:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA9DC14BB;
	Mon, 25 Jul 2022 18:04:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF819C14BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 18:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZaT9bNqD59qGgW8JXf34XNHfOjOOE3gj1w0xb0aH93jfUFFm8FYwlJ7G0ayhdEvCv6AK2nlLnYuorQLzoWMk5W/2/lCJlqTOtsOkbuN5Vo76TA/3upmtFkKbxkH9R9cwSeta8er04bZfzD7m4w+06bwa/TF61Vhs8eDngQzwDaLRUtv765vzSEzn1/zPm4uyzYTC9Cgr2TqRMIgU8zL6OLTiylTpZhs7BrY5S0XBctY8XYlxp5ftrRr0v9OqtNfnUgGrKCZAQ+JPZGPa++j/rVueCU4NCzXmtDsHvY1N2WsllbtazWxWYN5W5M2PFjER4Y9C3lCpO5A9H21FDDNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K8HGWkLI7YvfhMm+BcwKmYgqr/9Mii3KhGQ/87Sp0g=;
 b=JcJnW+d//00RdF2e7k3GT2jiQkzIIOZTcqi6WxBkzkP6sR0YwD7/nSdBChFIulNX7gtPmS8B5dRAxvf4vYWTcd3jPQ8lxxWBcBJkm7HV+OmByXjYlfVsUo7TJp7g45ikaqe7RWFO0HqkBotxvMHag33FoyQ2efMOfAqURhq50EBz3Z9CxwUsgsiWVV8gtUpM9z1eEDphMD4X7C/6E66anfymmnkAQKbIMA9zqB/D58F+1PXIxMCjOTGzXLJ6jpHpAU/or9HnVSEyg3LZ94obDm4Wei6aHGYPvN/38IFYgZK7l+mSZwA3rsuxrR+icsjQCCo1jpVsnEJDXM1mYy5N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K8HGWkLI7YvfhMm+BcwKmYgqr/9Mii3KhGQ/87Sp0g=;
 b=P2VGY8yn4z4GPrnPANfXAKjCm4MR/vVUYMMOC6oesSKA3xrwzMS6cFOmXmTHkhOGTYCXvCNY4KwGlIu2OVq6yMCNlx62fKLhXN6kii+EjIW5uXiNnysYVg/A/EDh6W3Z9+/PT1ZRQMrK03dm+0FQlL25fMjRYJtuTJi9LpLi2ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.21; Mon, 25 Jul 2022 18:04:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 18:04:18 +0000
Message-ID: <662c46c3-1713-5f63-1bd4-1e86eb1d213e@amd.com>
Date: Mon, 25 Jul 2022 14:04:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Split giant svm range
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725171943.9155-1-Philip.Yang@amd.com>
 <20220725171943.9155-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725171943.9155-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c5a3df-c3d4-4464-4c0f-08da6e68179c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1643:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANbW/GiSznoEaLtaIpqJWQqafzC3DwwWqUG+zWy6U6h9CAQX28pmkrHGdc7aJMILohRIVx8f05ZGy4yi2VuzrX8t5GSLvkdil/G8xZd91yk4oX2jkwRaDHjOa+DK1i9jgqXwtmFehvJ9H9/DST2JPINzBCJMFkstC5JosVJXH2QvN9EJRg/yn+O6C8RORuMpiiBGkx/fFgH3JCL2R31WbhGvTx1086r/aRCKpqLlaHepFabjwKdH1uGB7vxNRTfqTadSXmFAC7D0c3KhVDUAEJ6/mo9YjU6/2KrRzRwSSdcHey4Pvfa755+v1u2Nzz8eemSZODVTxhHTAnNXle3DqSWG/gL8V6EY46cdc1Xp2NiYg3UrbQUu3RgG4aX5vzL/B6WRNRqCOCUc/0H61EmV+rkWR1iHt3xKTTKgCL5m+HnOQHCSG2XRB0XLQrpAa2GcFscbEeGCtkGZICSwLH+2S7BYD1wxGsEiSsO5tJ3euxzs2Yb0e/Zb+3PUJFr9h83RfNhCNhva+JAamdthE32UnPv+r83zpyoUtIiIp53nqNkgSzMv2sJBok5AGHHJn6sVm0+bAM9h1d2Y6oR1gR80DDbLIgsyD2hK/kM3L/gUKGICXWOQqnKk3iz30ORZEYFeX/sKDEUNKRSEvb1ouf8DQJqhdl8qRMrh4KQh+CgN9ojhYRmEdGDo+eBfFMn8eiz1Co2IDrsXQslIzWGxC/HoJavEZwZtEtPFOu7V+nVx3kb7u6Ible9WLhJlqs3raU+1mRI4Wl56CEGnml0+6qNeuDh/CAt779P9rL4tIWKrX3GROsLGmIFtL4tmO7rPUCQmYtjtkSvksFgs70i/jBUXZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(8936002)(6486002)(478600001)(86362001)(31696002)(6506007)(2616005)(6666004)(44832011)(5660300002)(38100700002)(26005)(6512007)(41300700001)(36756003)(31686004)(83380400001)(316002)(8676002)(2906002)(66556008)(66946007)(66476007)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTYyTzB3TWVIQ1R5Q2VQaUgyaFp1M0VFRHFXcXE3eXY3V0QwaThZY1lGRDFq?=
 =?utf-8?B?L1BWOTdLdkdLTmlnRDZUMlJxYjFOUVhwekRlcEJObTdVUXVOS0N6RStrQ2lH?=
 =?utf-8?B?WTNiUGRESmFvWXBaNWhCd0EzcHV2UmEwMTRKekdNc2JiUlhpVVRnci9MMDVR?=
 =?utf-8?B?QXVmVDhSVXhWeHpVT2hDdDNIT0tmSFNZZW9YbDAvaHBKbUFjQStVOFgwOHEv?=
 =?utf-8?B?aU55TWhyVU5sOGVEbStid3JOL1dLMWduSnNic0Rnc3JUL1d2WndseW1UQnhW?=
 =?utf-8?B?dGVFWGxGZWJMbzRXdmg1WnZLS2ZuR3VUeG9xSzVwQUluQXRrcVYrOG5sM2px?=
 =?utf-8?B?MkxGRlZneFhIdzVCL1hjZlAySGxLNlhFYWVtSkVtSkFPSEUrcWtjQm1mVzY1?=
 =?utf-8?B?QkZDY0dIRmkxK25CcUoxaW8wSjIvQlJJazJtcE8rOFV3NFUxcEFzMUdSeUdR?=
 =?utf-8?B?TW5IdzQrSWd1aTBwd1lMSWIyaFI5bUlRVStFUDRXdkx3R0RsdURtSlQ5WndQ?=
 =?utf-8?B?dnBPQnppQ0ZiaVNrS1FlVWZXZWM1QmJsdDk0ajFSMlRURDAvLzlxOHJaemh5?=
 =?utf-8?B?QVlpNmUwN0E2Q3pBdmJiLzRQZ1hyOU1ocXBoUVZUY2tGMVZuL1hYbXBieWdh?=
 =?utf-8?B?UXp0N1diMElJWnYybjZVUGJMakVhT0ZZRDRZYmZVUnFDckhaMmQzODl1Q3ho?=
 =?utf-8?B?VGJrOFRNSm5TZFRFWjEwNnJLZW10TWxyR2psUjdHNkFUV1JyR1A1ZzV3blNI?=
 =?utf-8?B?L0N6NnZiTW5zdjIzOXMxazd0L2UycnBOTnZ4UTB5OUpUdTlnOURLRUpBU1Mr?=
 =?utf-8?B?azlFdkE0cE81bUtYS1l3LzZLd1gxbTdmTElJQm5mbHRuZWkyc3RDNGVXRE92?=
 =?utf-8?B?OHFxU3hWRzFkSFRrMkRHN0tHY3RPZktuZU0xVXpINllxWG9uRzlkZHNFUXo4?=
 =?utf-8?B?UW5Sc0c2elNpaHMvSTJPUHd6NGVlcGJkalN3eFRmN01BeE9jSnZXNzZuSHBY?=
 =?utf-8?B?WlBPM3JvK1I2YlhpdGMzekpVK1pST2RYMEtaYWRMS0t2cU16YmJZaFNsdnl0?=
 =?utf-8?B?TU11SnU3ajdueGxrOFQwQmYyaU1mbzNvaFZkKzd3UGZsaGoybDBSRWhTc2FH?=
 =?utf-8?B?M3lzOXJsYlRuMC9NaGJKSkI0Ym1LNURxeVZwSnRITEEvYUIzaWl5aVhVRmJ1?=
 =?utf-8?B?cm1MRFRSd2dJQXBoTlZWOEVHZHV0Y2dzUUVwWTJrSmUzR1ozQURYTlpmRFZy?=
 =?utf-8?B?RThsYkZUakR6MTBMWVJTUmYyVHVkNE1CV0pEcEZZUXh4NHF2ZWExNUNjOG51?=
 =?utf-8?B?RmEreDBmUUt1T2p5RmFVd0ZQelQ0M1E1WUhiS1U2SUo2ODdaUVo4Y2w1YStt?=
 =?utf-8?B?MmRBTU93ODJqeEJwcVlFZGEvY2ExRlBpeVZyTUZRUCtBY1pCUS8yd25xcTFH?=
 =?utf-8?B?ZWpnWHNtekdoeEt6bWI1K0JPRGgvcHFRWFJaa1F3R2x1SkEweHZCdmRKc2hv?=
 =?utf-8?B?OHYraVYyU3diSyt4T2paMHJvRkV2NCtrZzVYNzZhSUVRZGMzSGdvTUJQSVZK?=
 =?utf-8?B?ZXhKaFdLbUY3Ulp3WEg1dk1zSEptYUpJL2RaaGltcHhPcFJiZVUvNm9pRUZi?=
 =?utf-8?B?Z3kxYTJpZ1FXSEVzSlo3VnZmRDllZHhrZElKYTV1U1hWOXNtVGJield4S2Qr?=
 =?utf-8?B?cWp3SXFaY053UGRQRGZwRE1ISzZINDlmZnVNMUJGeFFMVWtsdmw4N0xCUEtH?=
 =?utf-8?B?STNKTk04VnJpcWJHSmdwZzFKTTRvSGNaUkJlT0NDMGVJQm82SS9LRU9XTGo3?=
 =?utf-8?B?ekVVVktTc1R0YjRqVk9hWDFoTjlsbEQ0N2ZNVEN3dU1XUFBXRzB3MWdiZUNK?=
 =?utf-8?B?WHZKUlladlVta0s4b0hXd2Y4a2Z3WXBKOXhJdU40VHo0bzdrU2pNa1huc0F0?=
 =?utf-8?B?RUdqSUdFT2FuclZNQzZ2MjU5Z2toNjNhNitNU3RHRTR1Qi9xZ0RZVWNVeWgx?=
 =?utf-8?B?b2ZVV2N4Z0ttYkx2bHZDZ0Q4eHpUZ3piQXo1OFRrVFNLWDYyMTY5b2lNMUF1?=
 =?utf-8?B?a2FQYjVQSVBnV0doN0RNQWpVdms3ODlBWDh4cmxBOWExcXZHMnVpSThQbS9x?=
 =?utf-8?Q?55mmGDzPIUW85+Kt6HbKKC4bU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c5a3df-c3d4-4464-4c0f-08da6e68179c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 18:04:17.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+RqmBOBg2cyJP14Keu7nHDzIy0Ag/Q0dmu5mOjwWoRKVSJCvF+2S//Bfreq2Bwu/odsCRhub6fUAw9FsCEGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1643
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

Am 2022-07-25 um 13:19 schrieb Philip Yang:
> Giant svm range split to smaller ranges, align the range start address
> to max svm range pages to improve MMU TLB usage.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 49 +++++++++++++++++++---------
>   1 file changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 098060147de6..6529a40fb508 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1889,6 +1889,31 @@ void svm_range_set_max_pages(struct amdgpu_device *adev)
>   	WRITE_ONCE(max_svm_range_pages, max_pages);
>   }
>   
> +static int
> +svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
> +		    uint64_t max_pages, struct list_head *insert_list,
> +		    struct list_head *update_list)
> +{
> +	struct svm_range *prange;
> +	uint64_t l;
> +
> +	pr_debug("max_svm_range_pages 0x%llx adding [0x%llx 0x%llx]\n",
> +		 max_pages, start, last);
> +
> +	while (last >= start) {
> +		l = min(last, ALIGN_DOWN(start + max_pages, max_pages) - 1);
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
> @@ -1991,14 +2016,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   		/* insert a new node if needed */
>   		if (node->start > start) {
> -			prange = svm_range_new(svms, start, node->start - 1);
> -			if (!prange) {
> -				r = -ENOMEM;
> +			r = svm_range_split_new(svms, start, node->start - 1,
> +						READ_ONCE(max_svm_range_pages),
> +						insert_list, update_list);
> +			if (r)
>   				goto out;
> -			}
> -
> -			list_add(&prange->list, insert_list);
> -			list_add(&prange->update_list, update_list);
>   		}
>   
>   		node = next;
> @@ -2006,15 +2028,10 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
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
> +		r = svm_range_split_new(svms, start, last,
> +					READ_ONCE(max_svm_range_pages),
> +					insert_list, update_list);
>   
>   out:
>   	if (r)
