Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F5CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 20:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F9210E536;
	Thu, 19 Oct 2023 20:05:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B90810E536
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 20:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud/sZf0/6QjY1IdSMNhqV2+Pt61g8v4zWMGKkwSb6TSxXZE4n8bW8e4DDF2YtM5SJYHuKB/zHvT/Kr5WKfPhbr++LCreUTQCs0Z6qBv4U2X+tr+eFVFqmyGbZtkrE8nnpnvfMlLhQ98fqETCVzc9oS+Ox4nS+pr2Q7uXo784avNal3y6EcTvCJ/wpLRjzRbxbgRDd9GX2LVZ7Yos2R2fh54x8fH32CR/eSf8g9KkjDjZk8xU6sUfMTy9kcPCoNEhgOe3tI+Rxu2WFHOqMUAU4qp62BlVYFk2wjEBYVZKIcLW9DNybylQWgTZCEn0+CClh7f2pFUP/USE4QEOe1tTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc1XX/quiv780w03xMYDICa9M7JlydhuoT3WF/ui3jg=;
 b=C0v8OWD9CoDfQSF2dpUhZYn79M0xcvqYvCxI3wrwf9cqx0jPMYvGz+TDuIHTqeUfGbaBuRnkmCxrRu4hKzYtO7VgudR2VPj/N0o3lW2AVM/TdImp5ne1c/jucI1b5ey3ooIfE6tnAg7tuOMN2gTK3zgiqBt//T7ln6s9P9V9x6oHO0t4D2PqG81IJTGQrYyJaUp9vWSnaAbLbMFoQxHwFJC7x7EQVjTU0kvhKEfSAFPV7MZAaN8jXY7inehbMIRtTjTGTKAmDtWuZokvz9/q0np9FhqHgQWnouq+TtBnOewBf/KkYpzDcIEN1K1q3g5/F8xruOsxhFDza7mwSI39pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc1XX/quiv780w03xMYDICa9M7JlydhuoT3WF/ui3jg=;
 b=fdd4nA2wmzehKN+AylcBWTfAKHhpxi9lIjSi3pUqubilMUF78SA7gedHKfAF4I5Ym7vc/9ntxNhXLErGj4EwS8me2oGVd4YqmNzTXjg0I1Hj+dyRb1Ofua1MjArrng7cvic6eVOzHIMWCkJWG8xexlRW1sXirSMZ4ikBkkx7/ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 20:05:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 20:05:52 +0000
Message-ID: <0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com>
Date: Thu, 19 Oct 2023 16:05:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remap unaligned svm ranges that have split
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231018222607.9872-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231018222607.9872-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0222.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fbd5d0-8c73-4c66-b96e-08dbd0decbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsotDoGN/7aAphznLwpEwUsU5ymOHY/gunRf7x4p308qD+AcZeCdtyTQXxQxCqXFo0vxaeAIthsBVopnaSzNfIYQ6RfyNaLe4jjqgclKkItA0xjfcs5a8DTN5hNbh1na7t2dqc+Jsxlb7dR/s8Tn5ekGfPyMI2zogdjPlDpnKeTfOyJEnmEnwwIzaBRCps5/rLOuQZhVxOEk4uM2Hct0IS7yGFzmu7cg7wIbzJH4HHb1Spci/gHnMwzPpjuJ2Ph+6ca9g1+p05ZF8KDNSbr/rk14ZuBAfruPiuNTMsjtBuewygvJpSp/o4pMwhzh5ngRIxE+n1aQX5zbJKJXaaIx6YA/0LREokJvPVYLZfERXgXdECZKn3JbL1pZWst9bx83a9nlZ03e5GRZHu48XhIuwRvUjBufMa13bSL/F33ijDtZG79fgGynRZV+WvpJDeno8C6RFQOaVPDM0J54mn9LvslZSkme9vN84rJnN3jsxiofcb7ryb9aGwPGtRQwvz/pssMjfwt9UtGWypcL3XbyWBSA9HIr2SdEbbVtqqVyZQvjQIWz7jBqvMcZ81tpYum4TpFQGkkZue9QD3qZ5ym74DiCTIoSG08cQfdKs5QnCCN3N37WU3J9HS7Q3RX5eUaCII3JcytbmT/gQXOTM7g3sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(4001150100001)(2906002)(38100700002)(5660300002)(44832011)(8676002)(4326008)(8936002)(36756003)(36916002)(41300700001)(66476007)(66556008)(316002)(86362001)(478600001)(66946007)(6486002)(31696002)(53546011)(6512007)(6506007)(2616005)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVEYndhOTgxMW56ZEVBRmxGSXQ2M295QXNCQVJPS283c0I0Z3gyZTNmRm5E?=
 =?utf-8?B?eTVlaHJaazlXOTdEaVF2TmxmSXpPaUV6USthRGtTZkhuL0dXOSs0UEZRYjVo?=
 =?utf-8?B?ME5ZMkZVdzE3Y2RoK0IzTmN0Qk9YUjhzckVOMzA3UFlWaGgrclNJUGwzZEor?=
 =?utf-8?B?TjRlcDZGNWY4T3ZWbVhFdXdLeVAzV3VVZXorb1Viem1XV3hXc2FHVzVkWnZn?=
 =?utf-8?B?WUJVUDducUZkaENYNTBuVmk2dEVuNS9NUjBvQ0xiV2xGelArbzQxZlpvbDJm?=
 =?utf-8?B?ZWtaZGJwQlFCdDJEaXlRZjJNa1BOYjBrSEZkVjF1L0ExUVlHKzliUm9wK2ZS?=
 =?utf-8?B?cDB4ZlUzZGhTbUJqL2ZwcWJEQ1JvTXA2bVRIbkxjSkNyRHc5NkpkM1JJVU9I?=
 =?utf-8?B?YmNxQnBuRDhGZC9KTTZvYmNPTThVNDVNMUFNcHhrUWRrS21YME8ySzZ1WDVl?=
 =?utf-8?B?bmxlMUZETDRNZWVzV3hNY3ZqOEt2WU9TMUYvNGg5OFdNTE5odWhndUprUG1B?=
 =?utf-8?B?ZUwxblJYVFRoNzJ3dW04ZVFjZ1N2TVdlWmdtQWFKYUt0MnlxeFYrditsZXIw?=
 =?utf-8?B?eHpZbmFZS2dwcVZMc2J5b21mcGM3bVlkSml6U3lzZ3h3QXMyOElyMlUzd2Nn?=
 =?utf-8?B?b2FoR2EyU1pMMFBhczFUVjkrNjA0NXVzMlZtR1VaenZvZE1TU2hrS3lkWjIy?=
 =?utf-8?B?YVdQL2ZhbWtNcmg1SEpUcUpOcUk2NjArUGIxWm43OGFOU0xNelVHc3dQcTJ1?=
 =?utf-8?B?RGRrSmtjQzIrWklXY1ZTTGtPdnVrMi9FdUZNOVZjU1ptUk9PenRraGN5c2pJ?=
 =?utf-8?B?MTAxQ1R5WEtuSnBGSTl5TnFZc3Q4bGcyMXkwYWFrV0VGV2Z5dWxpS28yNkp2?=
 =?utf-8?B?bkVCVE5qTHdQTmtGNEtGWU9QakRETmt6UzNSb2drK09IbEw4aW1BR2FGTTlo?=
 =?utf-8?B?dmVTbTd3NnVuMURac0sxVXpWSkw2VGtqVjBGano2c0NtaUVFT1J6UlZnNzY0?=
 =?utf-8?B?NkxEaWN0VWQ4SUt5M0x3dnhvblB5Vk9xRUl1cTBWZnZGd043bmJ2OXBvTHdQ?=
 =?utf-8?B?NmVkMitWQmFGK1BTMWJqWlh5d1F0azRxNFNlR0dhMTZFWk15VFhZOGlFQkJv?=
 =?utf-8?B?TW50WTNQU1RLWHl5YVVwcURkUndaeU5STUw3MnV6ZXFrcjRYU0xCMlRxajI5?=
 =?utf-8?B?dWExdTA4OUpZWmQ3a2dScU1XcUxQa1Z4S1JXWmxZSXJUcldGallTa0ZKOWRa?=
 =?utf-8?B?TU13SjRtNGMxMXFMbGw3ZTgzWGswcHViUkZreFhEZzY5Tm1DQmhLUmVieE5H?=
 =?utf-8?B?M2VZRERwV3lHZkVUYXdzcWVBcGtFQ0tYSGFKS0U2U0tVRldZN3FxSEJWVjlQ?=
 =?utf-8?B?ZVVibTV1RndZNFdjQjEwYTAyeUFDbk5aRmt0emhsYlVnaERjMXBqblBNNm53?=
 =?utf-8?B?Q05RM01VNFNGVWJkcUp2NUczS3gzeG5SYklOdDdEMXRoSzdhK2lkNEJZcERk?=
 =?utf-8?B?OEFzVmpURTlVd1IzTjFnZmR1S2hycno1RnVqdjJDWDlSaE0yZ3VHWUJaUGV5?=
 =?utf-8?B?bjRRL0FiRDRnWXVJRVJMakNGcU0zN0FmM0NvZVZGR24vQ3E1cTBzWDIxdklB?=
 =?utf-8?B?OW1EN0xWaUNRRVk3VlhYU0RQYkluYzVxclBNVDQySUhkdlJGaUQ3dTVuaDJ3?=
 =?utf-8?B?eGJmN1pXaHhMQTQ2TENTeDlVR2Iybll3YVdVbjliRGxuR21kV2pGQzhtQUZu?=
 =?utf-8?B?Yk92WTZWdVBVVzA0eE9DYkRUSC9CMHpBc1ZyR2lmNFl5NjErSWVwQmg2UmUv?=
 =?utf-8?B?Z2xTNk5CVTJMdUR1VUQ2aGxsRFIyRzF5OEM4anVkN05jYXFwSlRERGRDMThD?=
 =?utf-8?B?cThLbnpsMzhLeDFhN3ovTkN1YlNDbjRGelBHKzZhNWN4d3h3STAxK1c5cjFz?=
 =?utf-8?B?KzJrSUFkM1V4a2J2OG5halJxeWhBcjQrNmhZc1VZWmMzMURpUDQ3VVZONjha?=
 =?utf-8?B?NVJ3SFQ0S01KaVdPU2hJRzNjNWh0YUEvcGFQMzJXaXlXMmphaGhidlZLUG00?=
 =?utf-8?B?Q296bWVmd3ZzYzQrYnhkektUUjJxSEd2Mk90ZmV0RXhlaWs1eWJsa29ROUtN?=
 =?utf-8?Q?JIhZ9lsFVy7TKi3hpbk3+OPYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fbd5d0-8c73-4c66-b96e-08dbd0decbb0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:05:52.3069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUhW8H7mXxguW52ucgI0OeL/Szc/ZfHeYsUMIct37rzq9YyKgemAoXES+rL+1mZGKAERLr1JO1iJoBgWDSJpeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
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


On 2023-10-18 18:26, Alex Sierra wrote:
> Split SVM ranges that have been mapped into 2MB page table entries,
> require to be remap in case the split has happened in a non-aligned
> VA.
> [WHY]:
> This condition causes the 2MB page table entries be split into 4KB
> PTEs.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 45 +++++++++++++++++++++-------
>   1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7b81233bc9ae..1dd9a1cf2358 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1104,26 +1104,34 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
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
> +		if (!IS_ALIGNED(tail->last + 1 - tail->start,
> +				1UL << tail->granularity))

I'm not sure about this condition. I thought this condition should be 
about the point where the range is split, not the size of it. So my 
understanding is that this should be

		if (!IS_ALIGNED(new_last+1, 1UL << prange->granularity))


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
> +		if (!IS_ALIGNED(head->last + 1 - head->start,
> +				1UL << head->granularity))

Similar as above.

		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))

Regards,
   Felix


> +			list_add(&head->update_list, remap_list);
> +	}
>   	return r;
>   }
>   
> @@ -2113,7 +2121,7 @@ static int
>   svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>   	      struct list_head *update_list, struct list_head *insert_list,
> -	      struct list_head *remove_list)
> +	      struct list_head *remove_list, struct list_head *remap_list)
>   {
>   	unsigned long last = start + size - 1UL;
>   	struct svm_range_list *svms = &p->svms;
> @@ -2129,6 +2137,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	INIT_LIST_HEAD(insert_list);
>   	INIT_LIST_HEAD(remove_list);
>   	INIT_LIST_HEAD(&new_list);
> +	INIT_LIST_HEAD(remap_list);
>   
>   	node = interval_tree_iter_first(&svms->objects, start, last);
>   	while (node) {
> @@ -2153,6 +2162,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   			struct svm_range *old = prange;
>   
>   			prange = svm_range_clone(old);
> +
>   			if (!prange) {
>   				r = -ENOMEM;
>   				goto out;
> @@ -2161,18 +2171,17 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
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
> @@ -3565,6 +3574,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	struct list_head update_list;
>   	struct list_head insert_list;
>   	struct list_head remove_list;
> +	struct list_head remap_list;
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct svm_range *next;
> @@ -3596,7 +3606,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   	/* Add new range and split existing ranges as needed */
>   	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
> -			  &insert_list, &remove_list);
> +			  &insert_list, &remove_list, &remap_list);
>   	if (r) {
>   		mutex_unlock(&svms->lock);
>   		mmap_write_unlock(mm);
> @@ -3661,6 +3671,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
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
