Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA4C47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 16:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38D910E031;
	Mon, 29 Jan 2024 16:31:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D95A10E031
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 16:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYsx9ZFXQg/zQY/xBd9CpLYpdYCIF0sAfv6SkPjqAn/BlEA3hyMBVS3h0agv9xFgw4BI6Dz1a3C4H4GneavqWHC//AMZz5SKjfvcUcteHXobV+PDmsxoCr5YjibdyJ1G0K8MKJikWx2VnLrbV3DCYb73w3Mt9WhQmNwKC83BRlN0WiCa3g2fV7s7bRYJcItgz88DSIho7rNqMugBujQCUxbQoaYlkKm7QYD+nMfKfQFkjG6HbgbHprBXomQ74ZE3auDs1i367fO3mMHmFSMsyDNk2wmS5d29Y0i0npddeVJjw/LijIOVXcVXZ2Bizd6Qj4q9HCreSp7E/RmZWcfYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Sc/joHo2xeE5Fd0rcJE2EE+Sszou3Emvm5RnSIuT7o=;
 b=Wkq4AyydQC0p8cCWKUGKU52jMBItL22R3hiNpvofJoEr+Efi3ggV847A8Yc7+UTNsf/Hka3oa+jpBPce+T2QkWMVyTrP0xp1aYC45kQD1nHOWqSuh/J7vWoXofja1t5D6lQ8OwmBBtus3wCm9dTKCIxnSbk1OlR4rhcxaNu3ndgrjsmOEsUtszn/kWmrN7KQDZbg04VvjAycjj3toFQrXoVBR10ogDoPNVMRT/9QMUm9tEmbJ5lbg0ti3ccRLhMIXG0BdnCt0p2knYua/HL5coL7rYEvQGEUShauyEILwgjPOLXHk2oxz9stSFIL0UpJQwXN6ksMi9BMdON9Pc07Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Sc/joHo2xeE5Fd0rcJE2EE+Sszou3Emvm5RnSIuT7o=;
 b=SQNOoKQh9ycWsiYg0Y4nUJuFqmmx1w6U2lQ4lsQjpu6WRcRrYS65zN1HFnzCo2m5sAXCFUwKOfefUdK3aRaDmK+s60p+3UKCbT+WolpNXs4iSaCOcsFxbZidpuzq6koDZ7SWE2yUP+ujSTErjIUsEukgts+QsKobr7wlqfwlkpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:30:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:30:57 +0000
Message-ID: <adb1a9d0-11ff-44c7-9d5d-c20d1bb7f01b@amd.com>
Date: Mon, 29 Jan 2024 17:30:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Support >=4GB GTT memory mapping
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240126194721.18853-1-Philip.Yang@amd.com>
 <e128767a-9980-4892-a8bc-9acc206dd84e@amd.com>
 <43f6a455-4256-bfbb-f4ca-84e46440e5eb@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <43f6a455-4256-bfbb-f4ca-84e46440e5eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: bd13d32b-a673-46e8-2840-08dc20e7abc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPmlwkFLe16hkO3Qq3Iy8zfTUeCfiChM7wB3WAzF6NBeXzImMRHVI0tRe6JEz3wbCDH9LGrU4yTJXW8EX4XEbINl+GJnnAcYdy/D+gwAZ8RNi8CHNDG3mDtIpP/CgstwIdygqPD0+MmkEu9wp0CLToRlkBM//bHfM9+QH1cCGNHv1A3tWqdw2qHmVHJQ5RkAZROL44SqWaa//EZOBrb7UbGwR8NNJbVn2TpqByHpWRuNNC1BkrGx9E2HohqqdnBDebwkRvpCDgmdqB/T0G9I2Q4AoXiuMVlgg1GcapyFA+GkTkEowehzPbEnaNfyCZip+ILOGr5+mo2El07Sgd9ZZl1TGGA8h1hnghM3D7aWWlxc5k9x4FIQQv7/Q/IvBEh/h2v9+zGfoF6DbVq6Fla45NguW9//mpUdW0jrGNJHIq5vewia1aq7lumevxTBWT9jQVVmcZHntGjQl0UHEuXGWxad825FVYzj3bYLl3ltf3AgQRqnPUz0I3BGgh93EinVd9uDjk1pMVPwO7F/Ixp3mBepG+K52xMKnuM4QKqKO3v9/pbBirShGeSX+ij+FBoIyreAmvAvN1XQB1AjTkJXl6UFPd/2uiqtTKU05gFhYM8XDFwJzG14DfJ0EX17GGSYHLCOT5IcXSi61mDsK8oLog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(38100700002)(2906002)(36756003)(41300700001)(83380400001)(66574015)(2616005)(6666004)(26005)(6512007)(53546011)(6506007)(478600001)(316002)(110136005)(6486002)(66556008)(66476007)(66946007)(8936002)(8676002)(4326008)(31696002)(86362001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tBa2l1NG8vbVhBc3JyOTNMWkdpV2JheUJLN3pEZFl1T0FhTHdmM28ycFZo?=
 =?utf-8?B?QTVNc05ZK1hwVEsveno4TjhsWEtPUnZFTlNtZ3dRaXp5SGtxRmhFU1hpNjI0?=
 =?utf-8?B?YVdoUloyNXdsTERMSnBqMndYS24zb3U1QkJmcERJY0ZrekFBckhTS3hoQnVV?=
 =?utf-8?B?MmhUVGhYVzZFcHQzTlBVYnE2ZnpqRGtBSS9SZlVLTkk3cExJdkEzSmJqa1RS?=
 =?utf-8?B?ZW9UL1Rnbk50MkZPTkdQZjMrVXRYZE9KTlVqNWJGWW0vaUFiRStjM2UzcklB?=
 =?utf-8?B?bWNJOEpYVDk5VGpHZ1ZwUnJBSW9jWXFoeXVSeVpvRFJjY1krSmxmNkNaRFBn?=
 =?utf-8?B?TmZudkV6TklsU3J1MG5MZE5ad1N4OTJGM24xR3ZKdHltY21qSTJvRXRlbThL?=
 =?utf-8?B?UUo3SUJZVmptbVRrTEMxR3FzbzhEK1FzN2g1TitBL0FTTnpaQUZ1L3JjdGts?=
 =?utf-8?B?UkZ6V1o1bTUxOUdRU0NlSzRzcmt1NDQrYTRiRjVvV1R4ZVFYNFk4YWREL0Vs?=
 =?utf-8?B?NEp2RStySE8vN0tWaWUwbkVCbmVqb01oTU9DUytoVS9ZYXRNNGg3QmpJUDJu?=
 =?utf-8?B?RVVsTVJOaFJJV2N0UW5PSlVpR3dzK094M3dRTmZ6OXFMRmlzbDRvNkJjcytQ?=
 =?utf-8?B?aFB0UVh0MThWSnJhRlVnQ1grTW04elBJRVdWUWxreXA5UFFYeWNIVFJUVGZH?=
 =?utf-8?B?dVFEZ2libjZVOXJwT242N2s0TllwcHlEUVZDZ2FzaEEyV1hXRDA4Qm9mOXdu?=
 =?utf-8?B?MnNDUUdpc1ovbWMyTEsrZTZUZWpXVm9iWDZrUTR3SWpaNm9jTlhYWEY3a29I?=
 =?utf-8?B?UjE0VTY2eE1YY0lxRUR2VHQvc0QvZEYvTnJRcmgrbXQ5eHQ4NGFxc3lWWFVp?=
 =?utf-8?B?bnlSQlU3ZCtFWVR5a3NoaGxHTVl0YVRxZzdrcU5raFVKaXJhTGhXZjRoRmZm?=
 =?utf-8?B?WW5EaGNYdC9uNm5qaWFybklBZDZRNVcyUXdyTTBiWFNnWHhCSFdHODFKV1Bq?=
 =?utf-8?B?aDhxbUFHMGRwYStwbUtqYlI0TXE1U3c1aGhRZmRwTEdzZTVFSis1ZFFhVXp4?=
 =?utf-8?B?ZHkrSzNsYTVNQlJYQVRrc2Zid2ZOSjBXci9yZWVRT0dodmFOaGRzOTBZd0V4?=
 =?utf-8?B?cTJ1ZWg3cWlzM00ycXVRYVpXd1JHN2ZwcStEc1lNM0RiWmFFLzFYTy9tTk9D?=
 =?utf-8?B?YWpIUFVDU3dsYUcwVkpUM3VHT2x0OVpKeUM1VnIwNUs4VGpxa0taN3NoR0xW?=
 =?utf-8?B?SWhxTXpBVTRwT2FIL0UxRnpuajduSWhjdFF2bk5YaU9YazdXTzlrc3JhbEtW?=
 =?utf-8?B?SkRlMnZDZjdDNitFTUNDcWEya0tjYmZ6ZTAzSWV0c3NiK2c4OGN4Wk5yT0g1?=
 =?utf-8?B?dlNFcmdmaWlkYlZ3OGJyYTdqUUhSemNyY25TUldDdXNudVR4VnNES25zMWIw?=
 =?utf-8?B?d0dFa3Zvck9CUEZmVHEyekxyRzRTRGtGdi93SElyemVtRXFKdHdpR1Y1YVZt?=
 =?utf-8?B?TkM1eC9EV1c0SDlSeU9RRVZrWVoremRyVHNuejVDR0ZRb1hzbUVZcGdZYkNB?=
 =?utf-8?B?SGprbW5jSmVoWk5sYlFrNDQxRGtJUmwvNHYzVDRrSVdKcEd4Z0dnaFpnWnJk?=
 =?utf-8?B?aDNhTGo5Rys2emxNRWo5blFrWjVMRk1SN0k5ZDFSdWthYVg0cWFncGNLQmg3?=
 =?utf-8?B?TlpqcjNob3ZJbWtnMEN5a05jMjloWUI3UGpqdWZmWER2bThFVHVXc0JJcjdN?=
 =?utf-8?B?bS9aUEljN2pPa2tCRVR0OThYZlhyb3pxb1RrSjdZL3owRjBqaW5RZlhHZEpw?=
 =?utf-8?B?N1N6NUdKaTVWSDdNeGUzRC92TW5BZThmZEhyLzQ5anNiYmc4Y25mcVYzQytN?=
 =?utf-8?B?U0tUTmNDejh2bWMzSFEyRU9PM2k3UlRSSzUzRGVjZ2U1eXlXbDN4aTQ4QVMw?=
 =?utf-8?B?dGIwVmNNRTZrbU83dmNIQVAyUHNhRmZXZ0EyMnVnWVYzdis3ZUJxVUovY3Bz?=
 =?utf-8?B?SzJpUmR1cEF4Mlc0dEIyTXRoMnlVaW9xQU1lek82N1JjWXkwZlZGWk5XcHV3?=
 =?utf-8?B?cyt5SnRkMW51Mm12UTdaUU9ZLy9pRXg1UHhJQnhIOC92Y1BlNmgwZGVhWnFO?=
 =?utf-8?Q?oAnL5/8lxaEpkKLjpGanU2koR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd13d32b-a673-46e8-2840-08dc20e7abc7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 16:30:57.2823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vic7PDTQPrEhw26slDUIXxt60pQ7sSOAfiXwaCWzc43jO2t9GfkTMUwFyDv+R7tY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.01.24 um 17:25 schrieb Philip Yang:
> On 2024-01-29 05:06, Christian König wrote:
>> Am 26.01.24 um 20:47 schrieb Philip Yang:
>>> This is to work around a bug in function drm_prime_pages_to_sg if 
>>> length
>>> of nr_pages >= 4GB, by doing the same check for max_segment and then
>>> calling sg_alloc_table_from_pages_segment directly instead.
>>>
>>> This issue shows up on APU because VRAM is allocated as GTT memory. It
>>> also fixes >=4GB GTT memory mapping for mGPUs with IOMMU isolation 
>>> mode.
>>
>> Well that was talked about before and rejected. If we really want 
>> more than 4GiB in DMA-bufs we need to fix drm_prime_pages_to_sg() 
>> instead.
>
> I sent a patch to fix drm_prime_pages_to_sg but the patch was rejected.
>

Why was that rejected? If this isn't something we want for DRM we 
probably don't want it for AMDGPU either.

> This issue happens on APU, as VRAM is allocated as GTT memory, get to 
> this patch only if IOMMU is isolation mode, with IOMMU off or pt mode, 
> multiple GPUs share the same dma mapping.
>
> Even with the fix patch accepted by drm, we still need this patch to 
> workaround the issue on old kernel version.
>

Yeah, but that's then just a functions fixup for our backporting team 
and shouldn't be worked around like this.

Regards,
Christian.

> Regards,
>
> Philip
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 50 
>>> ++++++++++++++-------
>>>   1 file changed, 34 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index 055ba2ea4c12..a203633fd629 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -171,18 +171,41 @@ static struct sg_table 
>>> *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>>>       }
>>>         switch (bo->tbo.resource->mem_type) {
>>> -    case TTM_PL_TT:
>>> -        sgt = drm_prime_pages_to_sg(obj->dev,
>>> -                        bo->tbo.ttm->pages,
>>> -                        bo->tbo.ttm->num_pages);
>>> -        if (IS_ERR(sgt))
>>> -            return sgt;
>>> -
>>> -        if (dma_map_sgtable(attach->dev, sgt, dir,
>>> -                    DMA_ATTR_SKIP_CPU_SYNC))
>>> -            goto error_free;
>>> -        break;
>>> +    case TTM_PL_TT: {
>>> +        size_t max_segment = 0;
>>> +        u64 num_pages;
>>> +        int err;
>>> +
>>> +        sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
>>> +        if (!sgt)
>>> +            return ERR_PTR(-ENOMEM);
>>> +
>>> +        if (obj->dev)
>>> +            max_segment = dma_max_mapping_size(obj->dev->dev);
>>> +        if (max_segment == 0)
>>> +            max_segment = UINT_MAX;
>>> +
>>> +        /*
>>> +         * Use u64, otherwise if length of num_pages >= 4GB then size
>>> +         * (num_pages << PAGE_SHIFT) becomes 0
>>> +         */
>>> +        num_pages = bo->tbo.ttm->num_pages;
>>> +        err = sg_alloc_table_from_pages_segment(sgt, 
>>> bo->tbo.ttm->pages,
>>> +                            num_pages, 0,
>>> +                            num_pages << PAGE_SHIFT,
>>> +                            max_segment, GFP_KERNEL);
>>> +        if (err) {
>>> +            kfree(sgt);
>>> +            return ERR_PTR(err);
>>> +        }
>>>   +        if (dma_map_sgtable(attach->dev, sgt, dir, 
>>> DMA_ATTR_SKIP_CPU_SYNC)) {
>>> +            sg_free_table(sgt);
>>> +            kfree(sgt);
>>> +            return ERR_PTR(-EBUSY);
>>> +        }
>>> +        break;
>>> +    }
>>>       case TTM_PL_VRAM:
>>>           r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
>>>                             bo->tbo.base.size, attach->dev,
>>> @@ -195,11 +218,6 @@ static struct sg_table 
>>> *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>>>       }
>>>         return sgt;
>>> -
>>> -error_free:
>>> -    sg_free_table(sgt);
>>> -    kfree(sgt);
>>> -    return ERR_PTR(-EBUSY);
>>>   }
>>>     /**
>>

