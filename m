Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484DDCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 20:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE0E10E53B;
	Thu, 19 Oct 2023 20:59:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6579210E53B
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 20:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk66mKOlBDSVLsYuseWbU12KAT4zazlMXjPwvKFOdZ9Cx+i7m6ovbjdthXgbxmgftZcljdx7PwPIot06vF+PtN7050fruxLjLfSuBZGxkIKvc8QWTsX44Gl5nyrQk5+vZHmcsvyTvDzlZCG8o4mDGOJsse570CP3VCC9iLVXaVHdPabDLoZI1jdAx9F4NFFSHyVdFUgDl6bDHu+7x5jqCT5zHyb5HljgJi7YGF0R1X/ekP96ofc1CqFfDxOIrpX9PX+2Cg9vPKy94psxqyqBijGJwrB8VGOmzdpsxSxVV3chILFoPQtp+hmUqjhlON2ym/gDAou6umM3oHySgcjrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eAn5cb0OGTGJYBhuW5wiNDFihw6xen5PeR2QWMuUc0=;
 b=HUzV2+5q6QDBIbnYw+L3A+01EPAlBsIp/INyS5Zk5x/4kiJBjKcStk19RQUyR0ikM9o5YqgOsF89cKOd/0yf+6oITTn7TfKvjdl5DmB6QLahG/+RjyQt+J5zgYAFw+UFM0e8CLsegQIYMyidm3LuvAwW61iqo8Oc16EGI81Saz42WKWRLTPlDl9/TiNpEtOaIvo/0LOxLOloQdexmYCDxeC4mEG72nlzGn5Fmvd8ywRA9ouoTvd+N/3Yv5UiBIQk/M14fQlhmfrH/+OuN+EtC12nMQx2HP/+v27Xqhv83Ta7sW65E/2vZiw10TOkF9U6fk7MIs72ES5+nhgGaQIPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eAn5cb0OGTGJYBhuW5wiNDFihw6xen5PeR2QWMuUc0=;
 b=CwqjGl4zsPQgD/0zR/Zj//iIslLAxNc/yd5HR6/kxzR8/cOwsDC7X9sM3U6K1G935laJQnHwPSf/dCE8/SUih1xLTvjq+R8B46gEUvT4qhTGEKGFTBZ4ubQoc94Re5xamZtb8CdhAmAiHhkJYs3KnbbavWqyjl8pZ6JZo/SY+3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 20:59:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 20:59:39 +0000
Message-ID: <0309c686-c9f9-46e9-b723-1b848869448f@amd.com>
Date: Thu, 19 Oct 2023 16:59:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remap unaligned svm ranges that have split
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231018222607.9872-1-alex.sierra@amd.com>
 <0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com>
 <d988944f-a515-c0a1-a823-2d7b3e9c37cc@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <d988944f-a515-c0a1-a823-2d7b3e9c37cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0197.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5c6b84-657f-4e9f-b5b3-08dbd0e64ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXAP2ku59sh1ph2QSg9a0sIeoNwTgy/DNxlFaAW28wbZFyyOjC827bElWyypC44hdSvmAMc027P/VdoOxxC4pBfcuTCy4T9X+G+a3+QHOL3FuGrrFLE32fq9f/CF9CqL+mND4Q055/tj/rjTp+VhKnW+tvxE7y/X1aKEy8NyE/MHw/6BacEsuhU8G8nUq7eRdxd6kZW58gGdJMqqRL0Jp4iasJi0Ov6ieyq3Iog30+FmtVTAm8xysNL+YH4xooeRsI81ecO31ZY00hT3K/ND7QTjRfRWygrCI/LHoIMDN4pE7/cYm8V16FP6xRDu1JBqDBBmD8gS+hiLsHapGic6DAN964JdPxBeOzxxLXPjaZ1hvOfg28LB8Djwqw0XchlqWUGvrsViKSumztGwFgzA9TQkvtGSaXl9IKYwAfsYRYLwrs92G7W8TyeLozVwnZ4PrgR63aRSCt2wm2jMWKKr6WPuP9KKjo+gQFKlIvYK9Vxu5OFcgApe4N8/4ObTCY4DPSXM177c4sxpEL/DRYx3ZjTkfFLNVumR8wel3ID3tgLl7G0QZ3xRyWqJabRDNbBehgBHuCmtt6WmC0FIUKbxWBTsZCoVaICOYCoIGJJ2cGMnDtEkM9pMhD679+8M784zPDcaAoyKn02PNJIYUGEhdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6486002)(2616005)(478600001)(66556008)(66476007)(38100700002)(66946007)(53546011)(36916002)(26005)(31686004)(110136005)(6506007)(6512007)(316002)(83380400001)(5660300002)(31696002)(4326008)(8676002)(44832011)(2906002)(4001150100001)(86362001)(8936002)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdneCtkNEJod0Q4NjNCc1VPNDdjVFlsdHVjZUhMM3loL1Z2NHFWUmVvVGp5?=
 =?utf-8?B?YVhoOE1DQlhCV2xSUkRvWEQ3NGNiV01KR2h6UHpNWGoyNGlFTlJ0SFNyMmdw?=
 =?utf-8?B?UXVRdDIxbWxMMWw4UlBnY2hKcFBBMmJ0TWVGWGswdStiRW9xQ05DUkN0MzBi?=
 =?utf-8?B?Q3l6aXV4RTN6akhHQmk1cVhYa1NyTGVUWWg2Ti9hL3hmajl5MnhYUmt5VWtS?=
 =?utf-8?B?Y0JRL0t5WVNGM2lxMkNHYzNYZFRWaUtyWjdMRTRDUDVBOWVReEd3TmkvcDBN?=
 =?utf-8?B?L0p3ZWlaRGRWZnNGNjVwU2x6MFFtRDhiUDU3QXF1WUV5ZWNwbDd2bEtGU3JX?=
 =?utf-8?B?QisvMlcxYU5nVTZ3bGFGK1RVaE5WdElqSmpFNFpiU3Y0YVpwREh4QTFQSnVR?=
 =?utf-8?B?WVBENm54akZWd00wZ1IxM09HTXNqUmFOdVd0eVNNcUhzd1JiRjlpMzBweU5u?=
 =?utf-8?B?NWZjVTZ5clJJWm9hcFRMaHhobldMUG5yY1hTQjAzbnhzeUo2eXhTckF0OTlm?=
 =?utf-8?B?Um1WUzJlaWRMZEx4REhVZW83YzVKUEdoOUk3aWN1VmZkV1hKTlNvYUcvSVFp?=
 =?utf-8?B?YmJKLzZPZ2RYSFV6bkhUZW9ma1o3ZFBsczdOTWFaMXpPbm1pQzBIREVOUzla?=
 =?utf-8?B?amgybWpNQkVRQXZKT0lxQ2pYZDRKV0R6emFzalcwNVl4Zmt4VkNNN2hJU1Rn?=
 =?utf-8?B?a2dJOVFjbTFvV0Q4WlR1ay83VzIwZFdqNnpLWkxib1UremNEaU1wSS93TXg4?=
 =?utf-8?B?bnBTWkIzYUtwMWg3TWpOV3BMWGNPbG93NVVrOW5vVitrWmhWNmREZjRYWXRV?=
 =?utf-8?B?cGQzaXF4eFE0dGJxUmlCVnd6QVlVWnJnRlpRZHBkYnVvY3kxTnMzeHhPdTJW?=
 =?utf-8?B?bFhLZG9nNHl4L1dYZXBPOE5EM05mOU13QkdHTUtvMHVNT0pUUnBiM1lpMXYz?=
 =?utf-8?B?UXJ2Q1ZJMmwyT1lVNXlUWEQ5VEt3cTFKTTh2NUpWd3JiSk90cjFSdU1ubzRC?=
 =?utf-8?B?dnRxNVM1Z3RNUkVEcW9iTkdCMWxXWEFsM2tCUmNrZ2NOVEhNVlVtTWZuclRF?=
 =?utf-8?B?VEYrWXIzTzBqM2RWbjZHanlBZnFmOXhvSGREQ0NNSEtsNXdYMVFaWlQwMU1I?=
 =?utf-8?B?Q1J2Z09LYzczY05jS0szeEhFeXRMNnVXVkxydFhPb1Y4aDZVQ3l1YXVlNHNm?=
 =?utf-8?B?SHhxOTZWb0hDelRvSm1sczVncFpsU2F2a1U1WUQ3TDNNU2ZKbVkwMmtyTEkw?=
 =?utf-8?B?YWV0cmJMK015MWlRMjcyMHU0bUsvNE02YzAzZ0t5aWZtWHVId2sxalFmL0pI?=
 =?utf-8?B?NTZESVRqaC9sVmJjSExCOUU4VHJxUlFCVENRd0UvZDlDQ200UkJUeTJtR045?=
 =?utf-8?B?dWxQUUxBT3hUT1ErNkpSakw4eUViYnRZR1V5RE5aTll3a3dxNVZtTlZQVVVx?=
 =?utf-8?B?TlJWTUVQMXE3KzR2WkNXZGhWQTAwOG10Y2lvMkZyUDlpMjcwTUVGR2M5cjlE?=
 =?utf-8?B?UnVhVklCWXE3Nkh1d0pUNURXZ2ZHcXJpK214aGh1ZGRTNkpGdlBqT01hOEtw?=
 =?utf-8?B?VkFjZ3hzY2YvWnlERE1xS1p0elJVQWMrZlhNVGN6Y0hRTlk4UXl2YVFGV1dM?=
 =?utf-8?B?QXBkQXl1VVRhaUR3WGNxaU9XTmlhOC9uR1hVNTVQR2xVbmh0MzN5YXE4NFdD?=
 =?utf-8?B?OXE5QTluaUY1enFqY0ZzdHAwVXJ1SVRPbmx3SGdua1d3TVdkYVp5UENIVytE?=
 =?utf-8?B?ak1vMkYvdC82STJyT2pYdnRuVzl3emg2VFlnOGdJNHBERnNLYzhiMTZNREFB?=
 =?utf-8?B?dDZmYWc2MmVyZlNkSnVNMk90REd2cGVDSUJ0SjBPRlV5cjRDN3ZlOFl5a0o3?=
 =?utf-8?B?ZWVhVWRRd3UvOEJUZVpTTVJsdmhrVXNGT3ZyQXRiMGk4KzJ2UkFOZVlVZXZR?=
 =?utf-8?B?ZFlvK0V1S0NIMC82VXBUczIxTkxqNTR4cGxKYWU4U09iY0JaMjY5amZQa25k?=
 =?utf-8?B?QTl2VmpjZzlsUkxlTlU5Umc1TGlQQzNZZnMwaXBIbzhtTGJtd1ZtWnc3dU8w?=
 =?utf-8?B?WGJ5VFJ6YUcrWk9iWGpQbjUyTkV3ZVIzNGRFY1lmT0ZlY1V4SU1HemVmMlM0?=
 =?utf-8?Q?6BQxq9gNR+bJoUtyuMrT03MCV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5c6b84-657f-4e9f-b5b3-08dbd0e64ee5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:59:38.9411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO4mqGPSxOAzCCX14gO7ec1ZbUYlhc4FqZbhmi0rNgLF52eHfDaGbuI+FM+6FOoF4SpTk0v+5Abw9L3k17TwoA==
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


On 2023-10-19 16:53, Philip Yang wrote:
>
>
> On 2023-10-19 16:05, Felix Kuehling wrote:
>>
>> On 2023-10-18 18:26, Alex Sierra wrote:
>>> Split SVM ranges that have been mapped into 2MB page table entries,
>>> require to be remap in case the split has happened in a non-aligned
>>> VA.
>>> [WHY]:
>>> This condition causes the 2MB page table entries be split into 4KB
>>> PTEs.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 45 
>>> +++++++++++++++++++++-------
>>>   1 file changed, 34 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 7b81233bc9ae..1dd9a1cf2358 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1104,26 +1104,34 @@ svm_range_split(struct svm_range *prange, 
>>> uint64_t start, uint64_t last,
>>>   }
>>>     static int
>>> -svm_range_split_tail(struct svm_range *prange,
>>> -             uint64_t new_last, struct list_head *insert_list)
>>> +svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>>> +             struct list_head *insert_list, struct list_head 
>>> *remap_list)
>>>   {
>>>       struct svm_range *tail;
>>>       int r = svm_range_split(prange, prange->start, new_last, &tail);
>>>   -    if (!r)
>>> +    if (!r) {
>>>           list_add(&tail->list, insert_list);
>>> +        if (!IS_ALIGNED(tail->last + 1 - tail->start,
>>> +                1UL << tail->granularity))
>>
>> I'm not sure about this condition. I thought this condition should be 
>> about the point where the range is split, not the size of it. So my 
>> understanding is that this should be
>>
>>         if (!IS_ALIGNED(new_last+1, 1UL << prange->granularity))
>
> I think prange->granularity is not always 9, 512 pages, we should 
> check the original prange size is larger than 512.
>
>           if (!IS_ALIGNED(new_last + 1, 512) && tail->last - 
> prange->start >= 512)
>
That's if you only want to protect against splitting of 2MB pages. If 
you also want to protect against splitting of fragments (together with 
your WIP patch series for the mapping bitmap), then we should use 
granularity.

Regards,
   Felix


>>
>>
>>> + list_add(&tail->update_list, remap_list);
>>> +    }
>>>       return r;
>>>   }
>>>     static int
>>> -svm_range_split_head(struct svm_range *prange,
>>> -             uint64_t new_start, struct list_head *insert_list)
>>> +svm_range_split_head(struct svm_range *prange, uint64_t new_start,
>>> +             struct list_head *insert_list, struct list_head 
>>> *remap_list)
>>>   {
>>>       struct svm_range *head;
>>>       int r = svm_range_split(prange, new_start, prange->last, &head);
>>>   -    if (!r)
>>> +    if (!r) {
>>>           list_add(&head->list, insert_list);
>>> +        if (!IS_ALIGNED(head->last + 1 - head->start,
>>> +                1UL << head->granularity))
>>
>> Similar as above.
>>
>>         if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
>
>           if (!IS_ALIGNED(new_start, 512) && prange->last - 
> head->start >= 512)
>
>>
>> Regards,
>>   Felix
>>
>>
>>> + list_add(&head->update_list, remap_list);
>>> +    }
>>>       return r;
>>>   }
>>>   @@ -2113,7 +2121,7 @@ static int
>>>   svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>             uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>>>             struct list_head *update_list, struct list_head 
>>> *insert_list,
>>> -          struct list_head *remove_list)
>>> +          struct list_head *remove_list, struct list_head *remap_list)
>>>   {
>>>       unsigned long last = start + size - 1UL;
>>>       struct svm_range_list *svms = &p->svms;
>>> @@ -2129,6 +2137,7 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>> start, uint64_t size,
>>>       INIT_LIST_HEAD(insert_list);
>>>       INIT_LIST_HEAD(remove_list);
>>>       INIT_LIST_HEAD(&new_list);
>>> +    INIT_LIST_HEAD(remap_list);
>>>         node = interval_tree_iter_first(&svms->objects, start, last);
>>>       while (node) {
>>> @@ -2153,6 +2162,7 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>> start, uint64_t size,
>>>               struct svm_range *old = prange;
>>>                 prange = svm_range_clone(old);
>>> +
>
> unnecessary change.
>
> Regards,
>
> Philip
>
>>>               if (!prange) {
>>>                   r = -ENOMEM;
>>>                   goto out;
>>> @@ -2161,18 +2171,17 @@ svm_range_add(struct kfd_process *p, 
>>> uint64_t start, uint64_t size,
>>>               list_add(&old->update_list, remove_list);
>>>               list_add(&prange->list, insert_list);
>>>               list_add(&prange->update_list, update_list);
>>> -
>>>               if (node->start < start) {
>>>                   pr_debug("change old range start\n");
>>>                   r = svm_range_split_head(prange, start,
>>> -                             insert_list);
>>> +                             insert_list, remap_list);
>>>                   if (r)
>>>                       goto out;
>>>               }
>>>               if (node->last > last) {
>>>                   pr_debug("change old range last\n");
>>>                   r = svm_range_split_tail(prange, last,
>>> -                             insert_list);
>>> +                             insert_list, remap_list);
>>>                   if (r)
>>>                       goto out;
>>>               }
>>> @@ -3565,6 +3574,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>       struct list_head update_list;
>>>       struct list_head insert_list;
>>>       struct list_head remove_list;
>>> +    struct list_head remap_list;
>>>       struct svm_range_list *svms;
>>>       struct svm_range *prange;
>>>       struct svm_range *next;
>>> @@ -3596,7 +3606,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>         /* Add new range and split existing ranges as needed */
>>>       r = svm_range_add(p, start, size, nattr, attrs, &update_list,
>>> -              &insert_list, &remove_list);
>>> +              &insert_list, &remove_list, &remap_list);
>>>       if (r) {
>>>           mutex_unlock(&svms->lock);
>>>           mmap_write_unlock(mm);
>>> @@ -3661,6 +3671,19 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>               ret = r;
>>>       }
>>>   +    list_for_each_entry(prange, &remap_list, update_list) {
>>> +        pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
>>> +             prange, prange->start, prange->last);
>>> +        mutex_lock(&prange->migrate_mutex);
>>> +        r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>>> +                           true, true, prange->mapped_to_gpu);
>>> +        if (r)
>>> +            pr_debug("failed %d on remap svm range\n", r);
>>> +        mutex_unlock(&prange->migrate_mutex);
>>> +        if (r)
>>> +            ret = r;
>>> +    }
>>> +
>>>       dynamic_svm_range_dump(svms);
>>>         mutex_unlock(&svms->lock);
