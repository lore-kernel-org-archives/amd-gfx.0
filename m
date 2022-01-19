Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5845FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 15:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC32010E341;
	Wed, 19 Jan 2022 15:00:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A931F10E40B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 15:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA77OZ1SJbRVILtEV7i8liZRc+FtcL9pMc0IRssAZHYbOIbUIzHJoBBF2nwl/nORinjoxjACotaHd0HzFt1R4mPcuHSGA0PNQ9QWZgDw3jdmn/HoJRn3Rdx2FSDyu+SB/qXB/vBapc9kWZJis18C+ErWJ457Pgys6kHvsIAp2lC4rMegEz+FqYDU8wrwkBarGWr3HUm98bnhZ49QM7QHaBk2TZ6omSpioxfDl7dSqCsUNaFgMmtt45FKiicmPnWe7d0V+DxzQaB8kJxzJ6jsm+ZqwotRqsPhyg8M/Cu1k1fuNGRwo8BDlLLAgBii9I0Zj7i7hU/EEbNzFMsN+RC5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hucY2g7jR4ag7Ut5+Vq3yoGA7gJ2nTnoZ80PKhT5nA8=;
 b=ftkAejpbQVV3BOGFqyRTWJ9xLZiDEW/oHHrs7E9YDOIusQgFmdZr9fOW2t+Cx8uQSobgQy+qnZUeIywCUGWeXLgL9LLYRXwqaiY2iravDQKdgC4jal0oNpe1XA9AJO+Pyt9+dEX7yCfwy8n/nOg9kfeG/sk6/LP6afIZ4JlIIZifDX4NN/WdFGU9bQqXpl2ISv1afKcYX3Mu2iCB6c0vrrXXXeq/C+EVPA0W0cDWZZRyKRYf/wPp9WVY24RVSlauIER5KDS68kFnZ7wZucifxolcCVarJw755amHirCDbBPzSJu2mAEsclvZ8ou5rpLOEefikIFUd3S39rZ7HbZoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hucY2g7jR4ag7Ut5+Vq3yoGA7gJ2nTnoZ80PKhT5nA8=;
 b=y7fE/CW+W4mJiEnAa/zJXT/M/ZmVsDkLGpSPdo13qSbc1WH2VL9KAJZyDzeJQTsYe+3o91nXO6rwHBtnY/nigZ4leOqAP+sxFGrXTP700p7upvqvb0iIZq6mDqSMewwsYLM/Y9Y2YG27KteTrpUcO7+U6vF50W9l6wOz9oS6mJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 15:00:48 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424%3]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 15:00:48 +0000
Message-ID: <d5cd89ef-e303-7557-964e-afc251372ac7@amd.com>
Date: Wed, 19 Jan 2022 10:00:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Content-Language: en-US
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220118224513.26563-1-jinhuieric.huang@amd.com>
 <b4572e2d-7898-9740-c1f6-15c22aca12bd@amd.com>
 <DM5PR12MB1308928E28F9CAAB947F9E3585599@DM5PR12MB1308.namprd12.prod.outlook.com>
 <40522d1a-d759-c6c2-96e2-59923573d0ca@amd.com>
 <CY4PR12MB130369EB0000727C6269A84F85599@CY4PR12MB1303.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CY4PR12MB130369EB0000727C6269A84F85599@CY4PR12MB1303.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0019.namprd05.prod.outlook.com (2603:10b6:610::32)
 To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 959b0d2e-594c-4954-733e-08d9db5c79da
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2550:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25502739566270CB0A1C938682599@CY4PR1201MB2550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaVMicrfiZ8LLEe00VEXc2q0GS7l3SJIYxQjhhCDUa0mVa1xIpEyrwCziZp1ht+95Wpcraz98b17dGsE9fro0kcCXpVMo6A7FOZggyCcHpBFTcxnJFnTqBj/2I1n24t3Y9lWVIVFU70dhC5yJEIIReQ9EAkgUGGsom/eHZMseMzie9vO+gdrcz9dtVLUU8VFKymzrsqvd2Y8AVytEzsiR+up5nq57MuYoKXRtOUS0D9otUmWWVuDszQIeoWEaYq7CjNYFpbgILozha7al80PKbi4JV9G5dkFlviRWL6WyMSP1AnWmRtiActBf8HUwq3r2Gt9OoOLAU2/ntZEjJ3oa6J0AaKB7oz5q+HzsMOO0xiDG7YkMVt5fx1ezpO6+USY6pEgPkXFUd3h0tQFhjCfFNsnMNfOHxbWkq19Dp4mELLg8onfLj9gVyZ1AaFgZtir0dTE0jYPG7UQ10aAXgL9AVafaDnp5wNyi8sRwMZ06SROPDrcz24r3AjlLPKdAhbyOlfwE8gc46THe1oX3BY0ptd3lLH7KMY+x1ZbGy0vlSNYkpsRdlLA8I0lOxdcsnO83N+BWFNdpNAyBv7kjiu5Trhtvf2OfPHD61j+zhiKwZUxvBgCeaNEEvzgjO9h+Jdjr5R268gY8HNdcEXmXdvf3gQ5667lXEnenjx6iGMiQ32T67YsySURu1xZVgH724BXr95vbV9yN8O3oFvfcj3ONfh4r8nwLZd+Sztf76gF8/y4SlsrQh+hYU4PloUCFTZ131uQ1mz+iuutKKrNit7UKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(2906002)(186003)(6512007)(66946007)(6486002)(40140700001)(6666004)(53546011)(2616005)(36756003)(38100700002)(83380400001)(8676002)(66476007)(66556008)(31696002)(110136005)(86362001)(316002)(508600001)(31686004)(6506007)(5660300002)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZ5YWV4S1pSWlM3VFlwNE1scTJjVWN0aVZkUkt4VEZkSzEzbHhldGI0VFFE?=
 =?utf-8?B?dVZIaDMyNzVkUWdkeTNISHpiWVJUUWhnUmxEOHhnMkg1YXFxTUhzay81Ym5k?=
 =?utf-8?B?bWlrQkZaNy9jU0RwVXppWDByVm5JUG9IanlQQ2VocVIzV2NWVGh3M3YwaUZW?=
 =?utf-8?B?MGYyRjZUSmJnM3BtdmxHNnorZ05STWJNdXJVeGJmbUhhSFdRejVOQnljMjdZ?=
 =?utf-8?B?ZnB1M1RXV1VUUkMyTnJUNDMyUEs0VWM5Zk81YllickFkdERoU0Y1MnBIWS8r?=
 =?utf-8?B?NnhDU3l3T0RhaENGcEIzNjVoRml4c2JvdFllQTR6eWlhNitaUFkrWFJmWVNk?=
 =?utf-8?B?bzV1VjdtbCtPN3VZZEpvZ2ZyRkE5T3dqdmVXUVBVdldXSkY0cTQ2UXgyNHhl?=
 =?utf-8?B?c0czckErbTVkMGhxYkJlTDVvOTJlYUVjRUc2Znk3dG9QMWpSVTEyNnIxcXh3?=
 =?utf-8?B?bk9yU2N6a3BNd213cFgvTHRSaU9jd0dZV2gyYjV6WVU2RWREMzJhQkhrVElB?=
 =?utf-8?B?clRwNzVKMk9vZFpvYXpIemV0cWlEVHhSSG13a0lmWXpaUWdXRW1MWGFIYk9n?=
 =?utf-8?B?YTY1Rk44NUNZU0tPQ2VMdVIzUUU4UU5LUzl6LzMxWjBkdGJjOVZuZ1RSemJZ?=
 =?utf-8?B?WWRZZzc4clRqQUNvbGNmZ0JoK3RXelpOdThicVFuK2JDWldnZjFOT080aUF3?=
 =?utf-8?B?YWVBRGdIVG1XL0hUWmlPN1NuQlM3TnZJRkxUbXg5Rm95eXlTT2lpSmhuWXdo?=
 =?utf-8?B?QnoyRnNZZVJpbXZhM3REVUZZeEZpbUtLck15RWJ1TDFXaVBtY09kRmVwQlkz?=
 =?utf-8?B?VjY3bnJ6UzlTS3c0bnM1TFNSelJ0T1NXUTUyTmp3eHpxL2dvREg1anl3VVN2?=
 =?utf-8?B?LzNHSzNuWHNMZTZ5a2hjN0g2akNBNSs4bjhMejJUdnZFSVNRQVFYY3ZBaUxt?=
 =?utf-8?B?Q0U0VXJhNVZyYTJNRGhPVjZmaVd6WnFjZzViSGs0V2FuSjF3QW15cm13dTlj?=
 =?utf-8?B?Z2xJQno5WXArWDREcnZVRWYzNVZ6YTJURENzeVozRmxZTjBiSmtVN1N2YURK?=
 =?utf-8?B?L0V6TmVJWnlmblUrbGVCU2hNMGtla2tpOS9LdG1hMmtmMlNXTFN0V1hZUFlU?=
 =?utf-8?B?ZXN6NmJoVUVrMU5kL013S3VsVzZiT1diRkVKclhLeXUrbzIyZ1dmVC9xZ0tD?=
 =?utf-8?B?em9semFOWjRnei9Bc2k2VS9qdmR2M2x0NUdMMk1iOFhqYTBLNHFUa3NiZmF2?=
 =?utf-8?B?RGprNm4wZE9JczkwRGRWZUpBYW0xU0ZvbkYveW9ZRldiTURBN1dTRVFscy9M?=
 =?utf-8?B?V2tsWFhDZnFTalVwQXFkVjhRdFhwZXQ4U3liNnZSVENuQlp4UnF3bkpXeXc1?=
 =?utf-8?B?SitmT3lId0NGY0xPWkFUbURWdXpxSnZrYXcwRG1OVmFrdE5ERjFKNkhJZjlW?=
 =?utf-8?B?VFdlb1dEdWlpTHk2dHpZZmZ0YWZLcU5hSzFvTHVuYzVmbHBDV2xUWEFjaEVU?=
 =?utf-8?B?MVAxUzRHc1JsTzhGanMyVFc5TW5QSUoybEtxY2RJMkp1MllUMldRWXYvb2dl?=
 =?utf-8?B?eUFPT1plaWc3YlZ5M0hZNkRPb0daR2l2a0J6RlZkbm1qZFFjMTRpZGlaT0Vw?=
 =?utf-8?B?a01DQ3gzL0w1UnlsS3hvcFM0Mko4M21MQ2pVdFRpcy9jKzlleTFzTHlTdUNJ?=
 =?utf-8?B?a3JYb2pqVzVlMjhUWDNscm9XTlhyRjYxakY5SFZJVVVEU2ptSnJiSmNmN1NS?=
 =?utf-8?B?VlhTTVFocnQ2TmtrVXRhWlpJTTRVTitXRisrY1VJakFvc21mSWlDbXdVZVZ6?=
 =?utf-8?B?cUl3bTZZQ3J4cmVlNHRaNHE1NmtWaGh5cUtqN1FnaWhnSStBTDJxRWFsSzNZ?=
 =?utf-8?B?ZWp1TFVoL2MxN1lYUWVNVFFQSm1tcnZVY1lCakR2ak9CN2tzWFJvSkdvTjhp?=
 =?utf-8?B?TG9UWFlWODJzbHlLSlNpZy9WOW45cExOdXhZY1RCT1JSVUhBZndQdjJGWStX?=
 =?utf-8?B?K3BFNk5qM0lrVkprbmFNYTlEMzl5cFhqalc1NTZ6OFZ0OFJsWVJJRHVaYlRW?=
 =?utf-8?B?c2ZuN2s0bWZnNXpvK0JGR0R6M281NUJxL0ZPUUg5bThsZW0wbXFhSzR3djBW?=
 =?utf-8?B?UWsrSDNBZDV3UzBQN0VIWVZ1YnBwTkdrcHcwazJZTi9GbU1ROW1pUk5nWXpD?=
 =?utf-8?B?dlNYOHplQ0I4S0JKb0xqNnE3ZUIvOU5nRVRiZDR5RW9reWtjay9FODgzWVpB?=
 =?utf-8?Q?M/sOpLFogm+xNB1sPQ3ZeQsi30xVo4kcb4Dp2YS5xc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959b0d2e-594c-4954-733e-08d9db5c79da
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 15:00:48.0281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYW0Xiu0Mo59Q2ZE9Qqot4uTZHLCMxO/Q4BOSqB/JviD/tYrIYH7/ZBS6Mg/+ABWJ61m4lQ64Qtz5eCtq/R3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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



On 2022-01-19 09:50, Russell, Kent wrote:
> [AMD Official Use Only]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Tuesday, January 18, 2022 7:16 PM
>> To: Russell, Kent <Kent.Russell@amd.com>; Huang, JinHuiEric
>> <JinHuiEric.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
>>
>> Am 2022-01-18 um 7:08 p.m. schrieb Russell, Kent:
>>> One question inline
>>>
>>>
>>> *KENT RUSSELL***
>>>
>>> Sr. Software Engineer | Linux Compute Kernel
>>>
>>> 1 Commerce Valley Drive East
>>>
>>> Markham, ON L3T 7X6
>>>
>>> *O*+(1) 289-695-2122**| Ext 72122
>>>
>>>
>>> ------------------------------------------------------------------------
>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
>>> Felix Kuehling <felix.kuehling@amd.com>
>>> *Sent:* Tuesday, January 18, 2022 6:36 PM
>>> *To:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>;
>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *Subject:* Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on
>>> Arcturus
>>>
>>> Am 2022-01-18 um 5:45 p.m. schrieb Eric Huang:
>>>> SDMA FW fixes the hang issue for adding heavy-weight TLB
>>>> flush on Arcturus, so we can enable it.
>>>>
>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 ------
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 10 ++++++++--
>>>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index a64cbbd943ba..acb4fd973e60 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -1892,12 +1892,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>>>                                 true);
>>>>         ret = unreserve_bo_and_vms(&ctx, false, false);
>>>>
>>>> -     /* Only apply no TLB flush on Aldebaran to
>>>> -      * workaround regressions on other Asics.
>>>> -      */
>>>> -     if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
>>>> -             *table_freed = true;
>>>> -
>>>>         goto out;
>>>>
>>>>   out_unreserve:
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> index b570c0454ce9..485d4c52c7de 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> @@ -1596,6 +1596,12 @@ static int
>>> kfd_ioctl_free_memory_of_gpu(struct file *filep,
>>>>         return ret;
>>>>   }
>>>>
>>>> +static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
>>>> +     return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)
>>> Do we need to add a check for sdma ver >=8 here?
>> What's the significance of version 8 for Aldebaran? This code was
>> working on Aldebaran without a version check before. Did we ever
>> publicly release an SDMA firmware older than version 8 that for Aldebaran?
> We released v5 for Aldebaran SDMA in ROCm 4.5 . If I remember the ticket correctly, the same fix for Arcturus was required for Aldebaran and was part of SDMA v8. But Eric is obviously watching the ticket more closely than I, so I'll defer to him there.
Yes. Aldebaran has the same bug as Arcturus in SDMA, but the bug doesn't 
cause GPU hang on Aldebaran. As Felix said heavy-weight TLB flush have 
been working on Aldebaran since it was enabled, so we don't need to 
check the version for it.

Regards,
Eric
>
>   Kent
>
>> Regards,
>>    Felix
>>
>>
>>> ||
>>>> +            (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
>>>> +             dev->adev->sdma.instance[0].fw_version >= 18);
>>>> +}
>>>> +
>>>>   static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>>>>                                         struct kfd_process *p, void
>>> *data)
>>>>   {
>>>> @@ -1692,7 +1698,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct
>>> file *filep,
>>>>         }
>>>>
>>>>         /* Flush TLBs after waiting for the page table updates to
>>> complete */
>>>> -     if (table_freed) {
>>>> +     if (table_freed || !kfd_flush_tlb_after_unmap(dev)) {
>>>>                 for (i = 0; i < args->n_devices; i++) {
>>>>                         peer = kfd_device_by_id(devices_arr[i]);
>>>>                         if (WARN_ON_ONCE(!peer))
>>>> @@ -1806,7 +1812,7 @@ static int
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>>         }
>>>>         mutex_unlock(&p->mutex);
>>>>
>>>> -     if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
>>>> +     if (kfd_flush_tlb_after_unmap(dev)) {
>>>>                 err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>>>>                                 (struct kgd_mem *) mem, true);
>>>>                 if (err) {

