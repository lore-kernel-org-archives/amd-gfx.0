Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76036C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 05:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88C110E3B0;
	Fri, 23 Sep 2022 05:30:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA9510E3B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 05:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8paaiHVZ5mOM4X+VFYX7PhpgEuKA+lgobdESFwy1p4Aw7QaW7ArYukepWTD1Yz4JxOPaSwBy29vujWUu98hbKEIcv+JP7IfRM8gXdGBWFkP4IWiXl6EcUSnTT8/Man3oJ6hxx8SfOuCjyddvNX4X+qdOK3yS2swsmftVSZIbqLwsW3TnbeBRQSyjxXt2uBJRAOktI+9zjE0v/jwEYz8IBlD3jUkqf9IAaf6oCdq226bhWGF8I+FGA8F3zL3QlMA5RUxAXgr7zOGiTPTKgGJkklzRSjOkj5kzi+1Sdq9MQEPhOwKQq66/cyjGDCgr/qcHtgl5O/726neLizjjeBb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0N56h5r5ko6mREiYLtYJsVZS9SudICuMtz3+HSi4g8=;
 b=Ey0uVy75Z20J/ucu4kYYylZBtxdeOKYgESdkxlA9bLWBbYfrA7whXaLUjltj9tqDfxGVwV4QvwEPbZ6Tyf120D45pxFX1dGiVQiAiD3/S3XZKhJ77xi5UemmlYGdwxn3XxpOK+wVVWCziNLYQmI90irE6cfOT9TgK9gZTVfJMSbOREPE1zMf1UFjMWEoFR7qAWItO/SHG6+eY0iD/GRo98dbXUx6tlAxgJzyelhY0JWpkgERsJ0CopIq97TVbe7+Q4c9rePuVyc2GQjtEGwHOuOWEY9I703dipc78K4HAxD7AzrPMMtWFEgUjE7lDViEZYc6suMWJQXmzE4ujMLK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0N56h5r5ko6mREiYLtYJsVZS9SudICuMtz3+HSi4g8=;
 b=pLaYU4We7p1K/kmB8qMfe11qCscomuSRtHmzM+KkLKoFWw5H8JmMw48dQVWD5XM3WeHTaqdfW12CbXCg2lXmvvd2gn7JkVEboTQQQtT2XDnJvYD0yeQ1RfhsZNoYvle/ymB9EQdrGFajYNHAzVDVbyxq6SS5jFcjRDKAkhAYr+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 05:30:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 05:30:53 +0000
Message-ID: <8fd109a0-bf1d-befd-a9b5-c02c2104df25@amd.com>
Date: Fri, 23 Sep 2022 07:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Always align dumb buffer at PAGE_SIZE
Content-Language: en-US
To: lepton <ytht.net@gmail.com>
References: <20220922230452.3903316-1-ytht.net@gmail.com>
 <7526e4ba-1022-d921-9138-257c369cc172@amd.com>
 <CALqoU4y-3dWJ-gR8RxUFry9KpT+FMNDfb4WmvEoK5bc56ueUvw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CALqoU4y-3dWJ-gR8RxUFry9KpT+FMNDfb4WmvEoK5bc56ueUvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 376d6c78-16f0-4e06-29d1-08da9d24c864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYFs/3LwbBWPENC15v12Vha2Xt3xixPEjezWDtU+p3O3gRa8phXy/6lgnunIKLKMEdLRf77V819aVdW7J/RxEjBrSsKocklHvN++yup5NvbNIE/2xzqcxXf0+Ke3JgDgMIWmt3VLAQgFksD0uPnBHASUCQH6CMm+bSZuXyAd3cYfP5wS044ejYl+gQenavTLW/ZQpB+1zI2hGMkI6GMRUq2KztfB0a6fjB6sC9QV5G1zWdBFdT7MtG6Xej6VAPN2G2pCQHOC7G5BVUPzIHI6fqYE6N3FMN0Rvh+/1xVaoUJSdvjS75mMESXtnyy5UGnFRL5sLYK/B9bQcPnZHFltxDF4BcQv5ipFMjltNcyjRjPnUMvcit30y37ZMxWihp6rPZWwD/3SSEnzPBCKkLzvYKfH8wRXs/ZaK7l9JkCnTOHhhOtXy5HZDnU4m+1nQRt/vgDnqTo9XQKmM/JzEZI+wBuLeXVfjkqGJtmL+i/Yn+HLUuDxS8C5naznixmwg9gnaARjQbqE80a0Wrb2QfeSThNZZDUNKTXNJlnivdY23cawN04ovnn2DaCutTCbc3tIb8KMHVcTsJp6FTmGKBRF88F1p0E1Gq2AUsjRPXhd8e2VCDRz5cNW6ylz4dfz8RYLvJDOHwRsBD5uKCupJ11c0Pq9DnAz/TWMeCMI1YYGWbIJzoypSHFjW2WLKrXLXTq0rKa5GrwDiWRv9InAanVOFAb36MZozQYnZyeIwWEbjR6cSBE8tqWUNjgar9UI9aNs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(316002)(31686004)(45080400002)(31696002)(66556008)(4326008)(66946007)(6666004)(8676002)(66574015)(66476007)(83380400001)(478600001)(38100700002)(86362001)(36756003)(2906002)(966005)(6916009)(6506007)(41300700001)(6512007)(5660300002)(6486002)(186003)(2616005)(8936002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhNc0RQU093eTJiM2tlcDV3OUp3MGYzYW9BSlFXYUVWWTVVK0FLT21JVEVq?=
 =?utf-8?B?cW1xTDhVSElDdXhiQWNUNGxpdVMrUFVEbjBBWWJ2bXlQME5aMjRDRXJ2NFh0?=
 =?utf-8?B?c0RWZmRmMEUyY1ZLVUN1bHVEQWZwbmVnTkhlZlhMTHNFdkFtVW9PL1NGVzZj?=
 =?utf-8?B?MGFRZVQxWVpQN08vc0ljaEdFWVpVQlBscE1TTng3RXp6NmRHZmluMHNJOVJq?=
 =?utf-8?B?cUJodVE4WEd1V2hMWTlKeHZPbXlLeC9ZWDRGWWpyTnFRbXhhVXQ5cWhvcU9K?=
 =?utf-8?B?dnowZklKa2thMDU1UTVQTHY0YXFaSFZzRlFZQUtGMmlqMFY1WDR2TDVNWDcw?=
 =?utf-8?B?N25HTGp5UHlNV2FleE9oYU1kVDBlOTE2NG5vSFBDUGVSWklnQmVMaTI3Y3RX?=
 =?utf-8?B?Yy9ncnRqbFlUejh0cGRQUkQrVkpaUWhwTlk4WlQxMDYvMHY1SlNqYlEvTDlh?=
 =?utf-8?B?UGdGeE5NYjkzWFpJVnl3MDlSNi8weHM1ZngzUGFwN0xMSThuZWg3cU9zYysx?=
 =?utf-8?B?WXNYTWdYZnU1OTYrT0FKNVFxVGxidzI3U1MvMzZGbmh1NjZwbmJyQkdKOElK?=
 =?utf-8?B?UTRLYnBUSmJxdGd6Nk1KMXVmamdWYWRld0RkQmp5V05nR2g2VWYxaXA1b2p6?=
 =?utf-8?B?bjFuT3FlR0pWNURNMFBKK3dHYjd5bTdoSzFEUk5NYkJjSzFDeThIT1NDeHVX?=
 =?utf-8?B?bFVNMUhaaENMU25mbjBzREZJRzNkNkpKTkRrdjBUZ3RnYTEwNVB4THB5NmVK?=
 =?utf-8?B?NHJCdXlwUWNsN3o0eHdMS0RpM0RLMXNja1Njb1h4L3ZZK1hJeVRjZ3BDQ3RS?=
 =?utf-8?B?aktrbTNaNU1ReU5yemY1bkRaZC8zWW1ralFPUWUwQjVjcW5PVFhjL2NuQVUz?=
 =?utf-8?B?UG5kb0RiWm9PWUgrdVk2Nk14Wm9rQWlTT2Q3MlI5d0NWcUwvTk5tZFU2c3R3?=
 =?utf-8?B?SXJFSTVRd0toOFRZQ0ZJY0pJVlJicklrVWR6QWxWVFBkY3VQSktJQ2FieVVq?=
 =?utf-8?B?WDFUa0dSdGUxZ3NOUFZ0L2VYT2c4NUo1WlpWMUdBbXZtZ3U3Uk1wTlZIeDJV?=
 =?utf-8?B?NkJRSkhHRU04VXh6a3Q2ekV6NlhzYXZnQzl4UW4zbFNXWWNhcGZycS93Slg3?=
 =?utf-8?B?cENXNDNtNERwTFBIMGkyOE9nUEZmUFU3R2ZkMDZlRldVRjliazltL0VBTFI4?=
 =?utf-8?B?TXNxTkw1TWdBeFExSkZoQ2ZhVEFGMStGUlA4KzczcTE4WmxkSEIzOHJsdnhF?=
 =?utf-8?B?NnZKMXdZc3NnNjQ4dG9nSHcwNjRLYVJ3NHdzODdQV242Z3p1WXBVa3M0Vk1D?=
 =?utf-8?B?UE1uN05GMkdTcjhwd1dpTStFeWxDZE5uQTlTdExESG5HVTl5V0tOTHRwVDRx?=
 =?utf-8?B?SUNrU0FYY0JyeHpSSklMM2xwdUR4ZHIyZHpNSUJKN2h3SHpXY3VNM2hlWHFE?=
 =?utf-8?B?UXZTMW5Jam9tVFBKRFdVUm5nOEdZS3BkaUs2NmV2VVNPT3dsWlhRUXN1ZXZ5?=
 =?utf-8?B?bkpIcEZ3QXB4ZU5FVEJIemo2T05xeVRGcDJERWdOeWJMb0xEbkszQzdGcUl5?=
 =?utf-8?B?c1NmMTNKVWxBYlhUMXcySTJ4b0lBQUcyaHpQcS9nQTJQSzZNamJOVXRRT0VE?=
 =?utf-8?B?MWxvRVZaL2FkMnk4YmZrTlVmeDlEVC9GVWtxMTY5U25UbSsxSVNnUHFldFJE?=
 =?utf-8?B?N0RoVlkyUy9oVjRKNm5CSHJmeUtTRmVOam15eU1lemlITGRkMjBrS01WbmRU?=
 =?utf-8?B?Y0ZkM3JjalhKMTJkemowM3FMVHk3THVHRW1kZG95NzZFWXc1TUhnMWNSUC9C?=
 =?utf-8?B?djh2dkdER05QaHFMamNTSWtOR0VXQXlldk9kSktKZjRHWVhmd3hyVGk2Yit2?=
 =?utf-8?B?N0FJbzRwd01qL3NTNXc4a0dxeDJvY1FubW83am9sVkpiM0w3N1RDR2laMXdq?=
 =?utf-8?B?N1B6ejlIQmFFTkFkZ3RMSCtmdXRwTUlhb2lrNmRlbkJZakM1MllxRElneGo2?=
 =?utf-8?B?dUEyUkJpUGpXY0E4TGJaUzhVSWw3YVJtNUVRMUpwZUJPeGo2QTVyZVJaWVZH?=
 =?utf-8?B?cGF0ZC9JdWlJbXVSQzFnTGNpUkl2azlhcmtFSkEyU0p0UUpZQVNzbnBaeHdM?=
 =?utf-8?B?MGlYSmczQ1Q5OHBuVTdXd1J5UUo1MTFOeFdERHhBTHJhdTkrVDJNUVlmbjZJ?=
 =?utf-8?Q?g1zThqNnUo40ISyWtlnF9jIlVxxwlXwRbkwEpQUdqrry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376d6c78-16f0-4e06-29d1-08da9d24c864
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 05:30:53.5081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6zxaJaGC4h8mXcZOi44isZ08PPPhXPeIrwn82+VrIbB7smIm3t1Nfvwsi41vZ8J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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
Cc: marek.olsak@amd.com, amd-gfx@lists.freedesktop.org, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.09.22 um 07:28 schrieb lepton:
> On Thu, Sep 22, 2022 at 10:14 PM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 23.09.22 um 01:04 schrieb Lepton Wu:
>>> Since size has been aligned to PAGE_SIZE already, just align it
>>> to PAGE_SIZE so later the buffer can be used as a texture in mesa
>>> after https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcgit.freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%3Df7a4051b8&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C645f6878a7bd487588b708da9d246c4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637995077041120091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NMEAl8TByDLQFWW1d%2FaJfiGrXc4mpwL5dxNH0M0QH84%3D&amp;reserved=0
>>> Otherwise, si_texture_create_object will fail at line
>>> "buf->alignment < tex->surface.alignment"
>> I don't think that those Mesa checks are a good idea in the first place.
>>
>> The alignment value is often specified as zero when it doesn't matter
>> because the minimum alignment can never be less than the page size.
> Are you suggesting to change those mesa checks?

Yes, the minimum alignment of allocations is always 4096 because that's 
the page size of the GPU.

> While that can be
> done, I still think a kernel side "fix" is still
> useful since it doesn't hurt while can fix issues for some versions of mesa.

No, we have tons of places where we don't specify and alignment for 
buffers because it never mattered. I certainly don't want to fix all of 
those.

Regards,
Christian.

>> Christian.
>>
>>> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 8ef31d687ef3b..8dca0c920d3ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -928,7 +928,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>>>        args->size = ALIGN(args->size, PAGE_SIZE);
>>>        domain = amdgpu_bo_get_preferred_domain(adev,
>>>                                amdgpu_display_supported_domains(adev, flags));
>>> -     r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
>>> +     r = amdgpu_gem_object_create(adev, args->size, PAGE_SIZE, domain, flags,
>>>                                     ttm_bo_type_device, NULL, &gobj);
>>>        if (r)
>>>                return -ENOMEM;

