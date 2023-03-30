Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3ABC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F15710EEA0;
	Thu, 30 Mar 2023 14:48:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C7810EEA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c86FZz4PB8EzD4DnaJ0vtAboDUDSwbDo7xdxV5ZZfmOBSMDLGkymAsb4mP5ZGDvPiwNvf7T6o7NOvnUotD6pJ6xrVoi9tKLvmcMQiUGceMt9u7lfyysR8q2OK2t4TniBAacSTdSf5Dq9qJuEiJWmE7QJTZeaGJumISIrRbUte3fOU0/rmOB4bmccOc0H62xAMRMwoE35kfzJiCw8L+TCkKAhZGKBSu5ggj3FJVmk+RinscCM8PPkhUYEUvyJ+bZVZ+5TLmEFtmFUcCBOPIhHesYqSEvSEkd6VOte8QPGImKN7spGD/3t31Gh0nYTjZaGt5xdoo8XE3maEqPRMRCN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X9FUQ1cqzb2cAVHLHvYqL1YeA5/B+cIhaeOLA8DoJQ=;
 b=arPVH7SRcVKJtb3doO+uRuZcHG5JbhETlKNP9BjXbjy1nz4bxbU5FHmqaiMnmYTGUM+SgJnc3zV8KMHJoo5WFI2zQ063ZOHzSB62upHZRkkyHEOfcFpz9SZe4zs3l2zPtpTEPkUNl7OmRjLDzmUnJfolC2CPN9N4slU9NH3uvhg1rqgac5WRcoDQxWkXg9ReR0wJ6Kmb2p3kpZw+7Si4ck1qHAuuLdUiG6lWSFXQ1DQt+zwjnWnetXpNx8gCnnpkxTM3xj/kWng3+pSwIIH45Hyae09N2OpQUXuq+3LFuU+lehZEnLmWwviG0NRBaJOEdm5KYmtzQeQUFVVpDrmGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X9FUQ1cqzb2cAVHLHvYqL1YeA5/B+cIhaeOLA8DoJQ=;
 b=qa1sesWC4Mmw6ItOqjPRUImxQx/ty2/mgpdDImdN+XylMaPGwXw1NAAQPig3EgtyPD8QwIVDT1zgEj7vv6l0BPn+B6Eg0QXztJWH/2q0kLfF42bDcNvNESxEKmW0+1Ewwsun/kHiAR0tM8BmMqypRlJJ3A58nqnbGlhDgfVgRlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 14:48:49 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:48:49 +0000
Message-ID: <adab1273-a3a1-5618-fd00-9e1d846f032f@amd.com>
Date: Thu, 30 Mar 2023 16:48:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
 <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
 <CADnq5_OZkNwPhwAmvmzVN+w6B4oBmMWdBGsuTBJP0y9ct9eUMA@mail.gmail.com>
 <1b468b00-6435-425c-ae0a-5ed4c1727d96@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <1b468b00-6435-425c-ae0a-5ed4c1727d96@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: e10980f8-ab23-47c6-af5f-08db312ddf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6qc1jbvLucIxP5hjF/IureUImufxl7YSLoyr7VuSqmhQR1O1wJhpyKs1RLPZoZ3xutbIiL9ipnQmxOUq3Y8NwsROATrcw41nAhmrjwrIFsK8N/FGYswvlm3CR6XutxW7x5w8HD5LgPDx+G3EewRf3Xhpc0Y5qN41Z0FDLDVX4eFDzqmNBdHP1/e7IaHT4Eww0wFs9TI+8bpKGb4RrxoQNLfVVdPHtQ5q61UiikeYK935C3b1XVZrGNL1Aab5mCh1tBoEEfDQp1GTjkysUv1FxogpdM8aN3DnTWVEFDPEJzjN8gV19svp9Tnj4hg0O5FOSjwR5BlvoMs9963SSOY5ts9nWxis8cAZKUiQceh+qOUp3BOTcIm50BfsY1Zs7ke8imbFSsV7xVOU/n16pLebGWz2sXgKJWQLhAwBIZFSrkPC/rlEf4SW5Zltm+jFPgrGf/HXeK7A9kBH9CsbdSeoESyZ90Ezdz740nCclXfIasfp0UG2msb87gXVItJOGZ860k6+89YtkBJmnAwnytFfAryy0DCVIPJdBY0QF3VdLvyYd0vFa4mnmNJ5t6Szc8bVZsFlxrk0hb/MRLnJoE0ym280UjNHpkgoASHrblFHTK9dW4o9/NMiOPG/PTchWD9h0V0RLhsPDznclbPn0bV7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(6512007)(316002)(6666004)(86362001)(54906003)(31696002)(5660300002)(8936002)(110136005)(41300700001)(66476007)(4326008)(36756003)(66556008)(8676002)(66946007)(66574015)(186003)(53546011)(26005)(38100700002)(478600001)(44832011)(2616005)(2906002)(83380400001)(31686004)(6506007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitLUExWcW9FOHUwOUQ0UEk0RlVDeTRLSlJHUzVpRG1wbFdKMTF5dzVZZ0I2?=
 =?utf-8?B?bFZmQ3E2d25HK3VFMzREVFB2UFcxVU9RN3FmMHl1dTJZWlhDZWlZOHZkSU1L?=
 =?utf-8?B?NWoyZ0lra2tEamp4VFF0b2k0V3padmF4bG1lQkZJWjJvdHk5ZHJDejMxalFk?=
 =?utf-8?B?Q3FkOWZRMGdqWE4yeDdGaFA5M29Wd0NPT3BYQnFqaU9GSkNFRUdPS0Q1RFZJ?=
 =?utf-8?B?Z3VCWS9odXNWUnhXaFdIUW9DRUNrQWdlRVRKWk53TXNqOVFWTis5TnRrbVdv?=
 =?utf-8?B?OGwvQjV6MXhCaG1jS2VvdkpIZWhQSjVoa3NRZjJFUmx1cXp1a2JPK0JJQTdT?=
 =?utf-8?B?Ynh2VTVFUjgvY2d3N1ErMHYrVWYzeDZSenlpeDlnb1kvN1V2OXkxWUU4MlY0?=
 =?utf-8?B?dDJDZXYxODRQcDVveVlSOTVBUDdPOFh3RmlYL3NuZ002Y1dEa1dzUzlzOGpF?=
 =?utf-8?B?SkpTUGxRak9WYndGaGNHcFJFbEgvQ1p6VGJrZWF4MTVyVzZMZTZ1enR3ZDg3?=
 =?utf-8?B?WjBTMVBLU3FOMVlaakhBdXZ6MCtYclA2a21RV2dXMzZBcndRNzRyR2FrNG0w?=
 =?utf-8?B?bHMzc2Y2UnBoZXdtdWM5dVpyUnlXVndyYWJkQ2Q4d1RrZk9hL1l0dzBLREtz?=
 =?utf-8?B?V0pTOHNEUTR1M0FLKy9FdzBVcnpUN3VhcHA5MWVXdnRMNGZmS0U2K2JEMGpv?=
 =?utf-8?B?V1k1bHppeDcxQ3ZqUEo1djRLaTRCTFZqRXNBVnhjSUdGTm1sYjE4NkpIaHhK?=
 =?utf-8?B?OC9PZDRDQ0w5V1g3ZUNLRHVsT2wxV1lCaGJrTTV3MjUvMXVmc3BkdTRPMk4v?=
 =?utf-8?B?T0dBdUl4L3lmeXZDM3dzSW1jVzA3RjRuQS85ekFlOEltNXZYVXk4SmxnbzRw?=
 =?utf-8?B?Y3ZZZ3dQSXRaTjR1R1VxWEpzVHdSdXRPR00wVDRBMkh6ek8zSWJjQjJqWXBy?=
 =?utf-8?B?Njl4VGRiUzVLTnlWTDd3TkhRSEVFSUVQQ20xaFpDcHhHSVluTldxNTM3WXpG?=
 =?utf-8?B?MW5SZkRuNUVwOGQzcjZxKzBCVVFUUHN5VDY0VVFHUVpaUUk3SGFtMEhvTUVy?=
 =?utf-8?B?QlA4MmZia1V0MDg5THB0MEc1Vk4za3cvcnZ2TjFTUy9VTk05cmVPZ1RxblZH?=
 =?utf-8?B?ajMxVTAxMS80cWZRTlI1VlVsS3BJYjl1bE1wNjhkdldjQjEwUHoyRVNBcy9x?=
 =?utf-8?B?ZDFQdmtFeDlyeHNwK3JETi8vYkhqUHlUR3hTRmtOUzdrZ3ZaWHlEcnlhUHps?=
 =?utf-8?B?dDhsME5TbWRha2NOOEJGYWJqUC9rMlgramNPSkJ1cHRPL0ZrVlR1K1ZrNGt5?=
 =?utf-8?B?K1k1bjh6dUFSREUrV2YxbTlDemprcjcxZEhQTWlRKy8rd2J1TUphUFJmTGUv?=
 =?utf-8?B?SDNSZWJXVHJpbnVaWmRnbTMvd0JXMkFlTTB2VGFkalh5NWFZTktWVzQyNFpj?=
 =?utf-8?B?bmp4ZktGdVROZjIxbExyU1prL0I5TEhHajdlWkVzOVE2UUNiQmNtamVjRGdr?=
 =?utf-8?B?dU5LYkJUWjFPb01QeVhJeVFaUXE5bHR5anFrVVpmWFBDYVdnd3d3UzFJRjlj?=
 =?utf-8?B?R2xGS3VTSW1UaTBzNUYwZVFyV3VBU214NmRvakd4ZlJERU55dllnZlpCSlJV?=
 =?utf-8?B?QjQ5Vk9SYzBDOHJUOG0yOWp2TmloaUJEOUxVTi9nMUZEQVVVNDk1eFR3eWtE?=
 =?utf-8?B?V2RiM003Uk9kQ2VmU1RNZFh4bVVZNHNXaHpJU2tneThPZHdwSUFNdVNuaGp3?=
 =?utf-8?B?dG5oWGxQNTN2bWNxQlFJd1BXaGViL05HQndSTXY5akJ2ZzVyb01tWmdlR2hw?=
 =?utf-8?B?c2JKYTFOSHNONzliWks5WkE1dmdCMTZrYmpDV3NPMUQrTTNpQUZPdy9qYU1s?=
 =?utf-8?B?NjAvMkRjd0c3bWMweHpMcDFkSmRxRzJCYmFHOTBwdWVTWUpXWklJcUNyNk9S?=
 =?utf-8?B?d3BmQmt6WmlCeGZqai9JYWlXZHRybWxJSlVBWEhFWnR3emMzUGVNVXdRSmx1?=
 =?utf-8?B?Q01aYmJuMThvd1d6bFBtcGd6eUNKNTIxZ0VsZ2ppaDhlajdGSXdpRy9Tb2Za?=
 =?utf-8?B?NmxVdHE4ZEVpdGJrWFhMWVhiOGNYZ3MwK09LSm5VSjBWRENiQ0pnMkFmUkkr?=
 =?utf-8?Q?YFE/3bhvCjy/b4HOdonYdegpy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10980f8-ab23-47c6-af5f-08db312ddf06
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:48:49.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2L+iwnlCYflwTkXaqmux4s2cDF4K/XDQGD/T0YjPNpP02nt+bu5fzN6s3udP6hoZphsupaGGxjhVge4aGWpng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:42, Christian König wrote:
> Am 30.03.23 um 16:39 schrieb Alex Deucher:
>> On Thu, Mar 30, 2023 at 7:49 AM Shashank Sharma 
>> <shashank.sharma@amd.com> wrote:
>>>
>>> On 30/03/2023 13:30, Christian König wrote:
>>>>
>>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>
>>>>> This patch:
>>>>> - creates a doorbell page for graphics driver usages.
>>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>>     kernel-doorbell-bo's cpu address.
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 
>>>>> +++++++++++++++----
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>>    3 files changed, 57 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> index 6581b78fe438..10a9bb10e974 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>>        /* doorbell mmio */
>>>>>        resource_size_t        base;
>>>>>        resource_size_t        size;
>>>>> -    u32 __iomem        *ptr;
>>>>> +    u32    __iomem        *ptr;
>>>> This one can probably go away if we use the pointer from
>>>> amdgpu_bo_create_kernel().
>>> We started like that, but later realized that the cpu_addr from
>>> create_kernel() will just limit us
>>>
>>> to that object only, whereas we are keeping this ptr to ioremap the
>>> whole doorbell space in one shot.
>> Why do we need that?  For the kernel driver, we'd only need to mmap
>> the page used for kernel doorbells.  Then each user app would mmap its
>> doorbell page.
>
> Yes, that is exactly my concern as well.
>
> The kernel needs a fixed number of doorbells allocated for its 
> internal use. Everything else should probably use the normal BO API.
>
> For KFD we can use the BO API internal in the kernel, but that is 
> certainly completely different to the kernel allocations.
>
There are 3 different kernel doorbell clients here:

- graphics driver

- mes (for aggregated doorbells and kernel ring test)

- kfd (for kernel ring test and KIQ)


The fix num_doorbells are just for kernel graphics driver, but We are 
allocating doorbell pages for each of those, and they all need to be 
mapped.

Please see patch 12-16 for these details.

- Shashank

> Christian.
>
>>
>> Alex
>>
>>> - Shashank
>>>
>>>>>          /* Number of doorbells reserved for amdgpu kernel driver */
>>>>>        u32 num_kernel_doorbells;
>>>>> +
>>>>> +    /* For kernel doorbell pages */
>>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>>    };
>>>>>      /* Reserved doorbells for amdgpu (including multimedia).
>>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct
>>>>> amdgpu_device *adev,
>>>>>    int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>                    struct amdgpu_doorbell_obj *db_obj);
>>>>>    +/**
>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
>>>>> for graphics
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * Creates doorbells for graphics driver
>>>>> + *
>>>>> + * returns 0 on success, error otherwise.
>>>>> + */
>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
>>>>> *adev);
>>>>> +
>>>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, 
>>>>> (index), (v))
>>>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct
>>>>> amdgpu_device *adev,
>>>>>        return 0;
>>>>>    }
>>>>>    +/**
>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
>>>>> for graphics
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * Creates doorbells for graphics driver
>>>>> + *
>>>>> + * returns 0 on success, error otherwise.
>>>>> + */
>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>>> *adev)
>>>>> +{
>>>>> +    int r;
>>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells =
>>>>> &adev->doorbell.kernel_doorbells;
>>>>> +
>>>>> +    kernel_doorbells->doorbell_bitmap =
>>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>>> +                              GFP_KERNEL);
>>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +
>>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells *
>>>>> sizeof(u32);
>>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>>> +    if (r) {
>>>>> + bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, 
>>>>> err=%d\n", r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    /*
>>>>>     * GPU doorbell aperture helpers function.
>>>>>     */
>>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct
>>>>> amdgpu_device *adev)
>>>>>            adev->doorbell.base = 0;
>>>>>            adev->doorbell.size = 0;
>>>>>            adev->doorbell.num_kernel_doorbells = 0;
>>>>> -        adev->doorbell.ptr = NULL;
>>>>>            return 0;
>>>>>        }
>>>>>    @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct
>>>>> amdgpu_device *adev)
>>>>>        if (adev->asic_type >= CHIP_VEGA10)
>>>>>            adev->doorbell.num_kernel_doorbells += 0x400;
>>>>>    -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>> - adev->doorbell.num_kernel_doorbells *
>>>>> -                     sizeof(u32));
>>>>> -    if (adev->doorbell.ptr == NULL)
>>>>> -        return -ENOMEM;
>>>>> -
>>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>> adev->doorbell.size);
>>>>>        return 0;
>>>>>    }
>>>>>    @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct
>>>>> amdgpu_device *adev)
>>>>>     */
>>>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>>    {
>>>>> -    iounmap(adev->doorbell.ptr);
>>>>> -    adev->doorbell.ptr = NULL;
>>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>>> +    amdgpu_doorbell_free_page(adev, 
>>>>> &adev->doorbell.kernel_doorbells);
>>>>>    }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 203d77a20507..75c6852845c4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device 
>>>>> *adev)
>>>>>            return r;
>>>>>        }
>>>>>    +    /* Create a boorbell page for kernel usages */
>>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>>        /* Initialize preemptible memory pool */
>>>>>        r = amdgpu_preempt_mgr_init(adev);
>>>>>        if (r) {
>
