Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4054CCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 21:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACA410E53E;
	Thu, 19 Oct 2023 21:01:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A69010E53E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 21:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIeCRnXRoFIJCFeaNoT28/EGUzyu4Z8W81zUaouRbpMeVyPq4Z375+ZmbLETtlL805qeah/j+7513GoR0AZ3a/+YMduTs9eHNmHsAtsuw9v5V1o/E2kC+AH5ur1obCg8LJkZ9mFwCzXOr1hFcbe09r70wisjohYqfb8bEpKQE5kk+bAwqsRUi/sAp+yypBojP5qU+yZK0RRcjTgMgxvqB7z8SKjQVWtNMXk2jy4CYK5yThc7Sftq7cI2WIu2sGSdY+iIp3GMpxxbJM4CB7AMGsaxMRec56/Tt01phIMO20a/InD3my5KYI+TOUrN4tiuwdjOH7amQYVZ0gtrWcDrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2QEfiY5TxHsipRbdwq8psfIPFVL6XuzjQ9e6we9FlY=;
 b=XpcKNKqk8COxKYfudifT2lhNn0L4+GZha749vliZRBGD1l6GV8f0PTptpd6x/9JSK7BQbX3+vaQ7/uB6F1xBckgV3TWE6fYWByiS/qzT9XyYPIGg2+vPQ/IUg5CRc5bPrkSaDYfio9IqhAV4FtxCTVJKen7k1rcg4A8FvsnttZv+wdL3IAl7Iy3oM/RonEjJTz3lC5AQ2B9RWnBMhJrvpQOIGRAcTocAfdlFFYNnWX8YEUm3VVdk2dtE53xt8v9IPNVnwSm/t/UmQ0EVf47hBxXjvMYlgME0MJWgX3lxE5vARQE2xrCA3o4q8M4MrZNxlypTF8Bu+11b4V8UBhBKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2QEfiY5TxHsipRbdwq8psfIPFVL6XuzjQ9e6we9FlY=;
 b=va6XqphLgcIR9Yghr6OARb3ZbQGwKnWxSEn71LOpiTDFslC71pPmtm2Yu8ptRQhuG48tIysvV3jsj66E/T1mWGbIjyDMeg2DagKFDgSdCrthmRwdm96p6y/FKfTycwmkmFPpW/uVsTCFauG3WyH4PjZ2Kzg38Ie/cIiI/kQSK9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 21:01:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 21:01:26 +0000
Message-ID: <d6cbd8cb-0d25-4ff3-8499-016f9c848887@amd.com>
Date: Thu, 19 Oct 2023 17:01:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remap unaligned svm ranges that have split
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231018222607.9872-1-alex.sierra@amd.com>
 <20231019205105.22624-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231019205105.22624-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0210.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f49548-b68b-48e1-eaf9-08dbd0e68ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdcgZDVjknJO78kDZywxg8Oo/p6IQhmq062YRyPHNtP3F+A/3bRaECeNRWy8vy6qv8PCT2wyTtUmLROQ2XEYLWnVm3xVQGbTlU+V6NIbM39d/J322oYwV9zwP+5salrw2+yccj0imfJseVL4vgHUfn2M3XO3JBwIB02Lv1NQgMFuysOci7UHXqHfDaKO6gend9AFbrDjVxflIYrHTe/lKbNJZIYAHos1yI5opo1HcFXp+VmyOX6uZ9Drob1u/VS2AKD6jU6HFr8lwqIGX9xJ1p/Lb1On2hJFFCGnS5KpUrVi4d3n5MxQUY/1n5v/0RuSrkX+BqT6iKnMVC8W6RRvJSRcEUPiyEfvv6qiWlpzAdTTHwmzrVHiyUZKga5JTW7i38YzKw4a3TneuO9w6dkHNqqbRwlCSqpDVEFw4IjNNOox0AF/5fQqIAbd0Zxh9eJl0Sq272oORBPEbFBvZ+3/MnRAcBpQq10hAWa+PDOef2OBef3pqOIvCp7BquHMUUGnTSmjC4Qtlya6h8ay33JHJkCjRRfKg9TIeS+wqO47i6/nqvCvGsyTeYhe1+8Zne/XVkbFZJgJGSBZddU0NpfwqJvEUbZhxQ9FKiYEUmo/ufCA/L7lC7R56auuvigYgKryVfUcgV1j6OO8GneLreW1aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6486002)(2616005)(478600001)(66556008)(66476007)(38100700002)(66946007)(53546011)(36916002)(26005)(31686004)(6506007)(6512007)(316002)(83380400001)(5660300002)(31696002)(4326008)(8676002)(44832011)(2906002)(4001150100001)(86362001)(8936002)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnEyZHFNQUZPMlFYM0RjM1FFa2VpSlYxcy9YZjBkTVdBdVA3QkE3UHlaZFhU?=
 =?utf-8?B?QmR1bm9xT2tLVkRGTHVyN0FteGw3K0wwUFBjWGg0TUpTckdWNHRDWGlIMnIz?=
 =?utf-8?B?L1p2NUVxWnBnekZ5Z1BURDd2MWhqQjV6YXpnYXM5dGZjQjRZNy9TL3hIendC?=
 =?utf-8?B?Mm1SZTdvWDFjNFJ6SHNDU3RsZEltOW1VaDZGZGsyWHBERUVaYzNMNmo5Zmo2?=
 =?utf-8?B?cndrRkgvbXE5S0lDTyt1dXBnVFRsWEN4RXJtZ052TnBVVy8vcE9sWWdxR2NR?=
 =?utf-8?B?NEkvUmxVaElvUHZyODEvM205ZHdnV1h4L3RhSzJKUnZBZTNIaGR5VVhoTldO?=
 =?utf-8?B?YXFiaWV2RHBLNm92ZHJpbjVMQ2s4ZzB5bUlZODY1VnNjdGcwR0lCM1Urb2FB?=
 =?utf-8?B?eHR3NjV3OWZKVDh2VUlJektVWCtQcjlvYUxrZ0o0ZzNXd1Z3V0hYRDNmakFO?=
 =?utf-8?B?RS9CUGk4THExUEtIZTBuZG1kQXA4dlN5UE15UnVhdUZnd04rcUN3ZWFjTnZr?=
 =?utf-8?B?QUh0amlOQ01zQXBCM1p3aVBDWE0wVFpTOG5kNEhxNTlIMGZwbUNhN2t1TzNO?=
 =?utf-8?B?Vy85ckJNSHl3R2JMNUkvZWR2ZE5YTThJWVl6ZnYvVTZIejZUMlZiWjBlYVQx?=
 =?utf-8?B?WVJwR0N0eFVhd1hwcVFVZk0waXc4SGZaQVZGZ0FDVzIweDRSSk5vTjRzUm5z?=
 =?utf-8?B?V0MvNGJpSDQwWEJwUUJvNW5tbDl2Z2ErMi83eWpyZWtLblY3b1JsVStFQ2Rv?=
 =?utf-8?B?a1NkdHJBdmg3aXVsTG9lMFc5Rjc2NlEwQzU2VWwwU1FLRml0Mkk5QkJrOWpI?=
 =?utf-8?B?N1M2azBzVXNqcW5vaVpJcGpMdFlpSmY1djdCVnpPd3B3VklzeDRxbG16QTR2?=
 =?utf-8?B?eHhnL2xBL2ppNVZQVDlDc0N2aGhqV2lNbm9DQldDTlRKdFo5MzgrRjhUZWhR?=
 =?utf-8?B?V1ZKUXUwdUF6TU5DMjRCbUJCMXFIQkw1YVF1cGQ2aUExRkxTdGlQZEVDUTd6?=
 =?utf-8?B?UVFCVWc5S1ZOYVJVT1lxSlk0bk82WFYzVytnM3dxcFpLNnExWU55WEkrSlRt?=
 =?utf-8?B?WUU3WUxkSURJSFo5ZWhvM0NKOHpaMlducGtLczBTcjhkODVVMTl0TzBwbklv?=
 =?utf-8?B?a3dpd1hNNU5CcHRKcUFmSmlQTzJLVkNKUmdaRG4rNGJiWjkyUUNtaXBDWDl2?=
 =?utf-8?B?Qi9hTlkzQWVwSlNaK21OdVpjL2ZTTlVPR3Z1aEFObXNqeFdSODVaR3pQZEdE?=
 =?utf-8?B?K2xob1NqZzJ5Z1dOZU8za0h3OVBKZlhCOHFFTlU3dDloQlZZLzdNWmJPbWl2?=
 =?utf-8?B?UW1ZVDJ3ZGJXWDBLUWF3NGhOWEpCRTNxNXFPblZWclUxU3FMVjBXdkRqQ3VM?=
 =?utf-8?B?d2xTRnpLZGpTQlFkTzdHY1RFWWJmMmtJTFBidm9zV09jMzEwa2ZtSXlxZkRU?=
 =?utf-8?B?MnZDS093TlA1ZGRhcE16MDRYcDZyRk9pYWNmZlRrOUNRWlNJUFplUnVKOXVD?=
 =?utf-8?B?LzdFdXZ3eTFDb2E2UjRqMFBNTGVEVncyUHZmK1c5Nnliclk2WjBqWDNNRHhW?=
 =?utf-8?B?MVRVQXlsajJUNUVmZzI1NTl3dXZMWFJ4Yy9PQTFVN0J2SUdoMEtKdzdwdERi?=
 =?utf-8?B?RStUMjBXYTlxb2ZXOWtTREdPQUd4OVh2S0JSNlNQKzJUSlFSQmZxaEVkd2Nj?=
 =?utf-8?B?Qko4ejNOeStLMjU5UldrYUJUWlFZbVgrY0JWSWJIa3lURWhEY3hzT0F3azZL?=
 =?utf-8?B?T1lmdHNFZTYxUWpsODc5QzZhODZFYkJOYnlBeFFsWVhSbjdHMTBtQ3MrUW9N?=
 =?utf-8?B?ZExybzVxd1VJaW9oSEI5dEJqelE4ckwwd2lpV01LOGVJM3ZscFVYNFFaR01q?=
 =?utf-8?B?MkhMSm1jRllTUWRVNSsvR0YxeHk2cmZCR2I3OXExV2lieVNiK3pkRG1TV3dW?=
 =?utf-8?B?a0JTZWFUTEtkMTlWOFNDNjliUzMvaUVQalBUcU1MaXRoQjg1b3dBeG13aytl?=
 =?utf-8?B?Q2kyM0VrZU9jU1Yydlh3dVpaVlBRK0Y1WUp5Ykt4czJGK2dYcEg3OEJoTHQr?=
 =?utf-8?B?UDRwNHAxZnNnWTBXSlNYdENBMWJBbGxRUzF3S0creFh5cGZINnlPYjBmTExr?=
 =?utf-8?Q?nA3m1D8Gd51URozjJWb5ke1Uo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f49548-b68b-48e1-eaf9-08dbd0e68ec7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:01:26.0917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eULt82mtn7C6Zqk2BqmgCssXoPfTHqAic6O15hAC5iwmWLhRq+5WH5uwbDa0F6dvOJFv8LJr3G1bRW+ySS06dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
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
Cc: xiaogang.chen@amd.com, philip.yang@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-19 16:51, Alex Sierra wrote:
> Split SVM ranges that have been mapped into 2MB page table entries,
> require to be remap in case the split has happened in a non-aligned
> VA.
> [WHY]:
> This condition causes the 2MB page table entries be split into 4KB
> PTEs.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 43 +++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7b81233bc9ae..aa2996d6f818 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1104,26 +1104,32 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>   }
>   
>   static int
> -svm_range_split_tail(struct svm_range *prange,
> -		     uint64_t new_last, struct list_head *insert_list)
> +svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
> +		     struct list_head *insert_list, struct list_head *remap_list)
>   {
>   	struct svm_range *tail;
>   	int r = svm_range_split(prange, prange->start, new_last, &tail);
>   
> -	if (!r)
> +	if (!r) {
>   		list_add(&tail->list, insert_list);
> +		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
> +			list_add(&tail->update_list, remap_list);
> +	}
>   	return r;
>   }
>   
>   static int
> -svm_range_split_head(struct svm_range *prange,
> -		     uint64_t new_start, struct list_head *insert_list)
> +svm_range_split_head(struct svm_range *prange, uint64_t new_start,
> +		     struct list_head *insert_list, struct list_head *remap_list)
>   {
>   	struct svm_range *head;
>   	int r = svm_range_split(prange, new_start, prange->last, &head);
>   
> -	if (!r)
> +	if (!r) {
>   		list_add(&head->list, insert_list);
> +		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
> +			list_add(&head->update_list, remap_list);
> +	}
>   	return r;
>   }
>   
> @@ -2113,7 +2119,7 @@ static int
>   svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>   	      struct list_head *update_list, struct list_head *insert_list,
> -	      struct list_head *remove_list)
> +	      struct list_head *remove_list, struct list_head *remap_list)
>   {
>   	unsigned long last = start + size - 1UL;
>   	struct svm_range_list *svms = &p->svms;
> @@ -2129,6 +2135,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	INIT_LIST_HEAD(insert_list);
>   	INIT_LIST_HEAD(remove_list);
>   	INIT_LIST_HEAD(&new_list);
> +	INIT_LIST_HEAD(remap_list);
>   
>   	node = interval_tree_iter_first(&svms->objects, start, last);
>   	while (node) {
> @@ -2153,6 +2160,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   			struct svm_range *old = prange;
>   
>   			prange = svm_range_clone(old);
> +
>   			if (!prange) {
>   				r = -ENOMEM;
>   				goto out;
> @@ -2161,18 +2169,17 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   			list_add(&old->update_list, remove_list);
>   			list_add(&prange->list, insert_list);
>   			list_add(&prange->update_list, update_list);
> -
>   			if (node->start < start) {
>   				pr_debug("change old range start\n");
>   				r = svm_range_split_head(prange, start,
> -							 insert_list);
> +							 insert_list, remap_list);
>   				if (r)
>   					goto out;
>   			}
>   			if (node->last > last) {
>   				pr_debug("change old range last\n");
>   				r = svm_range_split_tail(prange, last,
> -							 insert_list);
> +							 insert_list, remap_list);
>   				if (r)
>   					goto out;
>   			}
> @@ -3565,6 +3572,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	struct list_head update_list;
>   	struct list_head insert_list;
>   	struct list_head remove_list;
> +	struct list_head remap_list;
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct svm_range *next;
> @@ -3596,7 +3604,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   	/* Add new range and split existing ranges as needed */
>   	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
> -			  &insert_list, &remove_list);
> +			  &insert_list, &remove_list, &remap_list);
>   	if (r) {
>   		mutex_unlock(&svms->lock);
>   		mmap_write_unlock(mm);
> @@ -3661,6 +3669,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			ret = r;
>   	}
>   
> +	list_for_each_entry(prange, &remap_list, update_list) {
> +		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
> +			 prange, prange->start, prange->last);
> +		mutex_lock(&prange->migrate_mutex);
> +		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> +					       true, true, prange->mapped_to_gpu);
> +		if (r)
> +			pr_debug("failed %d on remap svm range\n", r);
> +		mutex_unlock(&prange->migrate_mutex);
> +		if (r)
> +			ret = r;
> +	}
> +
>   	dynamic_svm_range_dump(svms);
>   
>   	mutex_unlock(&svms->lock);
