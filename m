Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473DAC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBD810EEA2;
	Thu, 30 Mar 2023 14:53:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A55B10EEA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqyU1Bg1Gp66F/79K/BpVSgo3x+F6Kcc7jQVPoUJif50sSqnMSUXv3CbtcjTa7G0ro7yptwEQLOpbaxueFi8MvlECCkf1Er/4p2ry+Nq3KCaCh+pnmNY/SKU8zCwCVOiRk7ELmE2j5wYKid9thaKnnj16+vX9h1ACXNeRzr0IW0jRYgUzG3HQOG0lt/+/Rl9TMVlVYHli3au5CN/ZRSNbHve2hVdlciiM/aR/UzK6m+jmimtWTNUXQWZQ+n0bv9fMjnaATkJzsLL9QxvzUGjjpB+u96jK3+IfTLpuqNI3lQ+NAjdojSpLN9P6KBZM57UvJ22VVkj1qkLA9SIbtuSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvdByeFAS3zXwX9h0sQDF/sT16ZCJMH5fTNLJ4L3NAY=;
 b=WhnPTRn9dJurzJEJgbnqpc3xqUl1oTzm4RVRW6umK0J/wZhChSO9MTttcZ1C/sa573k0QKiYIG+k0AvOr2v7zlzrAz6MXYJQHtykSKVq0s/u5u+rxKwWKP0XMsnK+Bf4GzedBgobgNO7A2l5tnA/34CyhN/zNrVQB06PuK7t8NThLplup0EiWRIkZhzVw0qzWPHFXdbYAuq9YSyrcaK+N0YauV8sNcj6bQzdodafOAYUEZT62Wno7n6zwTMxijP7c69TnQuKh4Da0PTmpfpJe6K3ZcklA0WJtxLVX/hUosfg6Hy9UlJu2Z9KzWP0xuKAZHu3R3PxOiPYC9Ukbw0qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvdByeFAS3zXwX9h0sQDF/sT16ZCJMH5fTNLJ4L3NAY=;
 b=qypxaV0DxEtYdCe7WoEFnCGQ+j7BRY5FIPs5npMPXE2SRNVQl6NCONVbYrsiO3WeLc54S9Th/pMSVDOsu/yw4ZOVpp2t9dNhGN0DtxSNCOH8uQsHVHQfKx4QJZAAMtHHzv0Om5eT7/iFKwSXYuLOnESAEK50Xs34RbtlHk9hTD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 14:53:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:53:18 +0000
Message-ID: <90d3512f-8e6b-45ce-0dd5-89b944855034@amd.com>
Date: Thu, 30 Mar 2023 16:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
 <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
 <CADnq5_OZkNwPhwAmvmzVN+w6B4oBmMWdBGsuTBJP0y9ct9eUMA@mail.gmail.com>
 <1b468b00-6435-425c-ae0a-5ed4c1727d96@amd.com>
 <adab1273-a3a1-5618-fd00-9e1d846f032f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <adab1273-a3a1-5618-fd00-9e1d846f032f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b561c0e-7904-4158-246f-08db312e7f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PKac60n3OL5imMNnZXyk1ujtSkK9RI+wcN1G+GHe+r0X9XG2SA9FFWY/DoW8Snktw80nFOloCuGfUdh3XSx/1QDBFIBnn7OjPrQKU9LNvwHuhMcw1sF9zyI/TWF6uhhdyg/iI1eazhDQJgtfCAPNVZ11PZ2iq523FHVVnNG2PvsjaqBEVo7KlW1RYZyEB2ryTjPkUq29Lgyg++Np2LcZa0xuByy55MU2OFEur13slpaIqurDyPCHkZnLQDpHv2kMDBKli72gNDeWjDuHsj7H61nvEMsrNgdvAXivU4ssoBMyvBG7Flr6pdXZn86WhS2ANk6KXGQRGhwLV8N0ywNAhHwFdS+PgIkjKO7MoCGwXvXHN8sRmYDSW5iQHfPV3XiNrcNdhc8yeuQr5AsqtJIoDL7nm+DQLyWTrW5Ztc4n/wCEUoy29dS9F3M4xx29BSjravcrRvtt3FtFWOfQqzpIY+eWNYNJBA8f/uI1vql9AFo1FQPEY+JRQp/jNugQ5aYEhmsdVlj/Ne9JmgfTEUNAaVjNDhVU6lRJlQdkPDuGnfn+Ww+CQsynfgc0Up53yTRTXbjAksbh3TWBviAvfH12l9qDpZJAEZJoXYO0zBb0vm3Da9kr7rsFxh9U3JPnuLvebizkFNyy8GIwCKls5YdVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(31696002)(66574015)(6486002)(186003)(6666004)(36756003)(6506007)(53546011)(86362001)(6512007)(4326008)(54906003)(2906002)(8676002)(8936002)(316002)(66476007)(41300700001)(83380400001)(66946007)(66556008)(38100700002)(5660300002)(110136005)(31686004)(478600001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjN0aTJQcEtZVzArTmExMzVUZlc0QnBjSXBYRlpFQVBHdjJzdE83U2ZvTXh1?=
 =?utf-8?B?TTdyb0NjaTZkQ3hBSnRmUmJyYmhlUGllcEhkc1VjUFdQNWlNeDcyVzVodlBQ?=
 =?utf-8?B?QVBhanFnMmtkSUsvby93SktzM2sxeEZwTkxKY25ONlFiTDYzdThGb1hFak9Z?=
 =?utf-8?B?V01aZGtpQldnK2VRdUFRS0NnTlVPZVRVdi9aWWJyY2ZnTkhTTW9sQ1NnRUlZ?=
 =?utf-8?B?eUpRSFhLa3AzOVFoZGE1WEhybVN5REpXVHRyYjNQOU40cW1lY2NORmpMQUY5?=
 =?utf-8?B?NTg2dlZZOXdONkhrTTQvMS9va1ZNcHZKVVRic3Q2SExHK3YxNWp6TFVtWGxK?=
 =?utf-8?B?WTA4MlhMN2k2Rmp6R29NTEtkdGFYZFE3SkIyeGRiN3lOUGRxaUhjY3FHSWti?=
 =?utf-8?B?b3c1MS82dHlEQ0RVM0F3RmhCd1ZmZFhmZkxiZnpGYnE0MzROeEhrTC9xNWhO?=
 =?utf-8?B?Tzc3SVo1QTBUYTJPdDhGeWVCVm41cDhjOUZqcVVyUHRUTjZiY1dQbTdqZjBi?=
 =?utf-8?B?cHpOZ25iM0tSUzB3NnZ1eGRYYUE0MmNzRHpCVzZSOUlxbXI0NFRJS0E3L2x2?=
 =?utf-8?B?bHpDSkVXMlFCRnUrWUJBVUR5TjdQWXFwVW9WZTU3N2I1NW1ZM2llWE9wRTRH?=
 =?utf-8?B?ZVJHbU1WcjY1WWhwMUhFeXVhd1IzcXRNd0V0RzduREg3TUtvOUxlUWxwdFJz?=
 =?utf-8?B?d3ZPcWJjRGsyeWpka25vT0tHUWFNRlZjMk93YmpLU2ZxaFZpSUxEb09jQjBo?=
 =?utf-8?B?MHgrd3dncE9PaTU0OWtzakY1R3JDSkNDbFhhWjRieFpSdFNHRVNxQmw3V29x?=
 =?utf-8?B?akt1U3V6MXFQYUo5dHFwL3phb1hQdkJkVUorSDQ0Yk82dWVOd3NpeDJEM1Nv?=
 =?utf-8?B?NjN2dkpJL2c0SzFybFJvNDhjdlNFS0ZFUlo4bXM2emdpaEcwczlTam8yZDFD?=
 =?utf-8?B?a1BUMDhwY1ZOb3VaOXJZTGtsZWIxVzNzbDRjSkx3YVRabXpvTmVOZUloTkg5?=
 =?utf-8?B?NHNjS2VPRWEzRmx0OHE5WkRuYjhKRWZ2cWZobEJmV01samFhaGFqRVVMRkhI?=
 =?utf-8?B?Y3dYK3M5bS9QaW54MXhvTjZtbTRLK3pDWlNJK2ZwQlhXWnhZV0MwdW9ISGsw?=
 =?utf-8?B?NTBncWtpYVgvU2Nla2xKQTJ4Y1NnYzYxTktQQVJ1U2ZxMU5RcXRyRGQ5UVcv?=
 =?utf-8?B?cjhFRUtBNVBTa0dseHZqVmdNUHM1TlNDMitzTGliNGc1ZVlHb1FsRmU1bUR1?=
 =?utf-8?B?TmI4T3VCWW5tQUhaOHBPNG5DOUdZb1FmcC9UV1h3VWErZE9zVTNtRWEvam5u?=
 =?utf-8?B?aWVSckpJSEhCN2xpQVBKdThPVHoyd2gzdDJ4enZiV1BPajFQMjBMV0gzOVZS?=
 =?utf-8?B?SGI4RFFZUktvTkhaQUVnWmk2VHJ0TEY4dHBZbkpmZFFsOXJMeUt4YzJnZzZC?=
 =?utf-8?B?dW5SYkRoTmx0Q1RQbml0RFM4Uk9FeFR1WTE5UzZCQlZ1S2xUSmJpVFp3SjFX?=
 =?utf-8?B?NGhhbzFXWm0wQnVFZEFEUjlLMXJlVW4zeDM2NkpyazVZK3NCcmNjb1ZqdVVG?=
 =?utf-8?B?MkdNSU5YVWtSeWhCWlE3ZkdJTXR2Ym1KK0hKVGt5SjZteXgrVE42K0tBVi85?=
 =?utf-8?B?M21kQ2JMZ2w0U0JIdktadWtyOVVTM2xvU2d4cmVuUU0vSFhMVzI4T3NFU0xF?=
 =?utf-8?B?QnlWNFFGN0FLSlRrN0lKNzlRb0JvRi9nSVJGV1JJZHFSaS9JWUJ0Um9JSTh3?=
 =?utf-8?B?L1JteVpxaStueDdEZE1HWk8zN2lMa0E0dk96ZlVwNFR1SytOenZHWVlUeHdy?=
 =?utf-8?B?ejFhYjFaVXNGSFZqSWNMOWRKU3hQcnlpTi8yNjZDQW1kV2IvbjF5TFNSczlM?=
 =?utf-8?B?VnlKQjdTZDd5bmVJZ3NaM0w5dnhRV2xLcXVmaDUycjJKb0dpYzhZYTEyZWcw?=
 =?utf-8?B?UnpQWWQrUEQ1QWF2TEdvUzFNdDkxNksrWUJFdEpoT2tRaHJkK0JjSjBZOW5V?=
 =?utf-8?B?M3ZveGhQV0RzQlBncURvNVI4eUsyR2daem9scWRKUkZ5YXF6R2pRbW1qWCtx?=
 =?utf-8?B?R21hZmpraHhtY2NCcnR6aXJ4YU04SXZvZU5oYmwya0NrckZ5WHozek5oU3pZ?=
 =?utf-8?B?c2MwZzlKWHVRQzRYaXFhSTNFT1lhRExwKzFRQlFlV1lTSTU0SUxJajhsbkpP?=
 =?utf-8?Q?HeKB9EBX9xpqBrv/6NhKZxc+SunP9OemAaID1rhJVUgE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b561c0e-7904-4158-246f-08db312e7f76
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:53:18.1211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/TNKBgp9TLYFspApNcMk/yA9aE3UbmSvhXj7tRk3Po13376Rk4iZ8ZR1S0WcqUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
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

Am 30.03.23 um 16:48 schrieb Shashank Sharma:
>
> On 30/03/2023 16:42, Christian König wrote:
>> Am 30.03.23 um 16:39 schrieb Alex Deucher:
>>> On Thu, Mar 30, 2023 at 7:49 AM Shashank Sharma 
>>> <shashank.sharma@amd.com> wrote:
>>>>
>>>> On 30/03/2023 13:30, Christian König wrote:
>>>>>
>>>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>
>>>>>> This patch:
>>>>>> - creates a doorbell page for graphics driver usages.
>>>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>>>     kernel-doorbell-bo's cpu address.
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 
>>>>>> +++++++++++++++----
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>>>    3 files changed, 57 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> index 6581b78fe438..10a9bb10e974 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>>>        /* doorbell mmio */
>>>>>>        resource_size_t        base;
>>>>>>        resource_size_t        size;
>>>>>> -    u32 __iomem        *ptr;
>>>>>> +    u32    __iomem        *ptr;
>>>>> This one can probably go away if we use the pointer from
>>>>> amdgpu_bo_create_kernel().
>>>> We started like that, but later realized that the cpu_addr from
>>>> create_kernel() will just limit us
>>>>
>>>> to that object only, whereas we are keeping this ptr to ioremap the
>>>> whole doorbell space in one shot.
>>> Why do we need that?  For the kernel driver, we'd only need to mmap
>>> the page used for kernel doorbells.  Then each user app would mmap its
>>> doorbell page.
>>
>> Yes, that is exactly my concern as well.
>>
>> The kernel needs a fixed number of doorbells allocated for its 
>> internal use. Everything else should probably use the normal BO API.
>>
>> For KFD we can use the BO API internal in the kernel, but that is 
>> certainly completely different to the kernel allocations.
>>
> There are 3 different kernel doorbell clients here:
>
> - graphics driver
>
> - mes (for aggregated doorbells and kernel ring test)
>
> - kfd (for kernel ring test and KIQ)
>
>
> The fix num_doorbells are just for kernel graphics driver, but We are 
> allocating doorbell pages for each of those, and they all need to be 
> mapped.

Yeah and exactly that doesn't sound like a good idea to me. In general 
we should only distinct between static and dynamic allocations and *not* 
different use cases of those.

What do you mean exactly with graphics driver and aggregated doorbells?

For the MES in kernel test we should probably just allocate a single 
doorbell page and use it statically like userspace would do. E.g. with 
fixed indexes etc...

Regards,
Christian.

>
> Please see patch 12-16 for these details.
>
> - Shashank
>
>> Christian.
>>
>>>
>>> Alex
>>>
>>>> - Shashank
>>>>
>>>>>>          /* Number of doorbells reserved for amdgpu kernel driver */
>>>>>>        u32 num_kernel_doorbells;
>>>>>> +
>>>>>> +    /* For kernel doorbell pages */
>>>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>>>    };
>>>>>>      /* Reserved doorbells for amdgpu (including multimedia).
>>>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct
>>>>>> amdgpu_device *adev,
>>>>>>    int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>>                    struct amdgpu_doorbell_obj *db_obj);
>>>>>>    +/**
>>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>>>> doorbells
>>>>>> for graphics
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * Creates doorbells for graphics driver
>>>>>> + *
>>>>>> + * returns 0 on success, error otherwise.
>>>>>> + */
>>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
>>>>>> *adev);
>>>>>> +
>>>>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, 
>>>>>> (index), (v))
>>>>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct
>>>>>> amdgpu_device *adev,
>>>>>>        return 0;
>>>>>>    }
>>>>>>    +/**
>>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>>>> doorbells
>>>>>> for graphics
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * Creates doorbells for graphics driver
>>>>>> + *
>>>>>> + * returns 0 on success, error otherwise.
>>>>>> + */
>>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>>>> *adev)
>>>>>> +{
>>>>>> +    int r;
>>>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells =
>>>>>> &adev->doorbell.kernel_doorbells;
>>>>>> +
>>>>>> +    kernel_doorbells->doorbell_bitmap =
>>>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>>>> +                              GFP_KERNEL);
>>>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>>>> +        return -ENOMEM;
>>>>>> +    }
>>>>>> +
>>>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells *
>>>>>> sizeof(u32);
>>>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>>>> +    if (r) {
>>>>>> + bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, 
>>>>>> err=%d\n", r);
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>    /*
>>>>>>     * GPU doorbell aperture helpers function.
>>>>>>     */
>>>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct
>>>>>> amdgpu_device *adev)
>>>>>>            adev->doorbell.base = 0;
>>>>>>            adev->doorbell.size = 0;
>>>>>>            adev->doorbell.num_kernel_doorbells = 0;
>>>>>> -        adev->doorbell.ptr = NULL;
>>>>>>            return 0;
>>>>>>        }
>>>>>>    @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct
>>>>>> amdgpu_device *adev)
>>>>>>        if (adev->asic_type >= CHIP_VEGA10)
>>>>>>            adev->doorbell.num_kernel_doorbells += 0x400;
>>>>>>    -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>>> - adev->doorbell.num_kernel_doorbells *
>>>>>> -                     sizeof(u32));
>>>>>> -    if (adev->doorbell.ptr == NULL)
>>>>>> -        return -ENOMEM;
>>>>>> -
>>>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>>> adev->doorbell.size);
>>>>>>        return 0;
>>>>>>    }
>>>>>>    @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct
>>>>>> amdgpu_device *adev)
>>>>>>     */
>>>>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>>>    {
>>>>>> -    iounmap(adev->doorbell.ptr);
>>>>>> -    adev->doorbell.ptr = NULL;
>>>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>>>> +    amdgpu_doorbell_free_page(adev, 
>>>>>> &adev->doorbell.kernel_doorbells);
>>>>>>    }
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index 203d77a20507..75c6852845c4 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device 
>>>>>> *adev)
>>>>>>            return r;
>>>>>>        }
>>>>>>    +    /* Create a boorbell page for kernel usages */
>>>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>>        /* Initialize preemptible memory pool */
>>>>>>        r = amdgpu_preempt_mgr_init(adev);
>>>>>>        if (r) {
>>

