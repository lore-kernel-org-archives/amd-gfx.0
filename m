Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D0EC54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 15:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E961B10EC02;
	Thu, 22 Sep 2022 15:20:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F085510EC02
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 15:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8TbMTLmybL+IOiUqTfl+zv/yl7NY2W56nKwypIfpOMw45OH64BPwtaOZTgQnbraoLeRb6MsubvAT6OD8R8y/W2U8xi0DzWeypf3VCw5IbefShXf+eQbs/VF9RJODfwoZbtXceg6QaEUcAw4GaayhKEvam2inqTi8HkEfLXEOmPclIyLFmvO0ifkOGYOhTW74748txLtHeeJW09CLmfv4dEWN/+NzYwftqPWnnGEvY7/dX5gg1PEuaNY7+OyAW/eUyhIoZw3Ltv7INwUhHw4YUaI7zJrwKvaZrNKEsgKWnMd7Ur41pH3sPUzrILRTb4Ofs+0htAJA66PAAUnl1X64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNrYRkXKomaGZOe90Rz9F1AvpLEca/ss/mYfOZ8jwHs=;
 b=mLgdaT2QaOZbnKgHinT6n90iT2rRZNmfEuMG2RVpAsRwYZ4VJ4Tk2bAqrmk2Pi+qZxPtdK0mG/59kAsSKxMDh+daLSE/47bjTBnfWm9v0Iihzo0D71n6F+hU1mUYz+faIF7JSDtiQK5KGwX4oRYCUvgknWXrtfFqIgoqbIdm/YW2DXad7fTKM3bHN+zafeAQ5/ZNc8h1xiNlm53cuF5HroaKelaWSVNc0+9sfhOQFevCV54rVgGQrLWenBP5gPo7mcmi62ME7Cs4z5Vd7w4J5xDJeG/nqQ/cT/RnN8y+LnAoogDEnQaQGQ3aRxFRNL+nVtyxwGTxPiPLUoAObmxN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNrYRkXKomaGZOe90Rz9F1AvpLEca/ss/mYfOZ8jwHs=;
 b=yB7fC5IOzI5f1iAWyYlcsUqRqW35qrVkIpOEzF2R1Z/dIWED9n/tQO51jZbN0YPcTM/4zByFZwYcB0wkXQXlkLKAL8sA0iJyvYY95r/ylPgHyHRTCCIJQf1Nr2LqN/mU8t6sSeKxHiWUL6gOdWIoje4JsGnA4yiejrj8g9r82qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 15:20:28 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6cf:60a9:3ed3:7be3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6cf:60a9:3ed3:7be3%9]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 15:20:28 +0000
Message-ID: <290b67eb-d1f2-82ff-04c3-673b045e9f66@amd.com>
Date: Thu, 22 Sep 2022 20:50:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM BO swap issue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220922131859.131544-1-Arunpravin.PaneerSelvam@amd.com>
 <CADnq5_PoB=3XO7wjcqcmewOnNajuhnWpVisSh1TR6eAQD+Z-5A@mail.gmail.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CADnq5_PoB=3XO7wjcqcmewOnNajuhnWpVisSh1TR6eAQD+Z-5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: d842bf44-862b-42e3-8d0e-08da9cadfafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc3Z+rVu41+EaInaIeWDullctQuMdKfuEPtmeqwivVgHVe+09Xn9Y7W7UCZQZY37qdoKk0sAhEHaVFpiKZJjY/v5Rw4E0of1t5ji6ihnjSCtUaB9CZoE4rePuK6jqPrSktV7RGANmXqEPVTUXCQ3E9lVem4CAvjkhjR6GRDhOqcEbsKNyyl/Zi8CkosPbBS6b/pKRzJJ4QrnTW+Yux8JYuexdj935Sv6S6qQ0bA1cn6inM/kooQV/FbM9YOVLInrSmPjyjmlco2z0W9i/hrziJgyAsevqe78Mq7lFxg7ToGdftScDK6K9vL+5IdytgogggHm8uW3r8tuKl4jYUqsdqWlPRtDjj+uhGEFy3OeFpgyRREirCI3MrLyfUGbxysbNk+oaeFhuDmAXQceBYD3HKL1QuExNcDWKJbWnn8CpUBTwXEr6kYD2oSkHsOuFR5a/bY3LmIRvQix2UZ4JGZVUWegXoF35tNbgK0wH3dm5ix+MHPHtVUCX8bdN3mHFULRBYBfmQ0IPXlz/qgNQpGMHL+dHhDfXkOxBHyJjz0IhHuiukMlsqpBi7fFZJ4FAKr6pcMMkjTto+Ew3QLnQJJk2lSmy+9wNcWRkb1iaK5FIVuPslVvq2P5Htv2xj+Z7g0ArQAA2gko8WVE8M3sJ2i7M0IhJ0csX2SSxmKqp4pLW0OF1oWQCO+jUDIlXIAtskXBIAhRBMIYKQUDQt8JsNv05n6XBXFwwT+VOFWtkcJxO7kBsJ1lj+CR1AJj1jrXV8gV4SoHLKn78Smt2IVBJI/5mMwHu+KKXvE488thM7yWkec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(31696002)(86362001)(6916009)(316002)(36756003)(2616005)(186003)(83380400001)(6486002)(478600001)(6506007)(53546011)(26005)(6512007)(6666004)(38100700002)(4326008)(5660300002)(8676002)(41300700001)(31686004)(2906002)(8936002)(66476007)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9kdHc2TWM2MGxCekVTY0taWitpVDM1b1NGOVpxMTl4RDZBV1ppbDRFU3Vs?=
 =?utf-8?B?RGMyS0I1NDNTY0RaRGhQQzJoZ0xoYzFncUpSUkVmVU5MNGZXcjFKQ2pMcWVV?=
 =?utf-8?B?ZWhuWXF6ZlR2b2xLd09yQ083cVZVdGZTRStwb1piU0JyWjVVbk42d1hXVVZC?=
 =?utf-8?B?dUdvUWFNMDRwd0xEbm01cFdDTXIwQ2V0RzNiVFlXNGI2RHBNNWd6ZDZMWTRY?=
 =?utf-8?B?d24rcXdxVHdSOGFtVDlwM29OL1AyOFd6azljY09IbitzaHdGQjNHZjhLaUky?=
 =?utf-8?B?aGRtU1VuZjgycXk5eXgvNDNBc0RNQ3A4WVl4NVVkNVE4OGlPTm91UmpuNENZ?=
 =?utf-8?B?dWI2ZHNMbFovbW4vNHFNYWNxVXpzR21UR1ZBVnZIRWUxZkxlcG41eURScnlE?=
 =?utf-8?B?aHdkVzZ6T2svMmp5eXUzZ3owYU9rM2w5Q1hFRE1SQVk0WDhBUmdMcUFxNXlo?=
 =?utf-8?B?Y3h3KzNETDlyN2pVeCtYSFRwMXg3U3NZSk93U2FMRGR6MEhWNERvRGNjeWs2?=
 =?utf-8?B?dTc2SEIzN0pHTlBWajZWSTJrZC9XUEZybDdPL2hrMGpiVWQ4U0dxV05MWUI0?=
 =?utf-8?B?UVd0WHlYc3VTckdyNFhhcjRrdGc5QWZTajZUWnE2OHd4ZWMrV2FXU2FYVUc0?=
 =?utf-8?B?UDkwSkptazNDS3FNb1ppaWhJVlJpNGptdHp3disyUURPOTQwbDh3NGhJRkha?=
 =?utf-8?B?aklXN1M0SHpuN29IbnVCNFNnbGJjcW1UTUJxNXlWTWN5NnpwMWZaUVVZWXpX?=
 =?utf-8?B?b3lUU0xlVDg2Q1dHcnNvOEpiVWJWNjZGN3NsdzFJZEt0Z3FjdDlXNEd4K1VY?=
 =?utf-8?B?T0s1SC9YM3ZCZHdFS1BiVW04amEyeXJXMSsrbUNxb1J2MUdrVUJYdGlIelg2?=
 =?utf-8?B?aFMzNHdtMThhOHUzeU43ZVNDaDVlRlRKLy9iVWlUNVVqVUQzSmUrcElPRDcw?=
 =?utf-8?B?b0cybnNhb3M2YUt6ZGxOZ1ZMdUJiaDZZRGZjZ2JtRGJTZTZCNFFJcW5CYkkv?=
 =?utf-8?B?bitHeTFFZ3VUQ1RTSzR1SGJ0S1cvZ3dSTWlGY1JNdnpJOTVFMVdjZ1Z3em4w?=
 =?utf-8?B?eDV5UlJ4aHpxSk9rYVdiS3BBa0V0OW9yK0hiNUx6YWkrM2g5ckhJcWxOeTk5?=
 =?utf-8?B?VER1MkhtVE4wL0k0U0hpeWdTcGx1eWd3UlU1am4xV1kxZG9aQ3hHKyszeUJC?=
 =?utf-8?B?K0VOTDB0VEZWakZkczlubTJ0cUlUQXQzbS9MLzRWWlNmMm11bTNwZDkvMkNS?=
 =?utf-8?B?Z09SZm9hRkhhbHNhN1RjVU16aW8yOHE4NUd6TUc1bmRlSUFSTTRlRHduMldS?=
 =?utf-8?B?K1ljR3h0bVoweXNFN1cxQlJIREFRZExkbDR5Wk5ZT1RTWUxkWExWd3JRb1pZ?=
 =?utf-8?B?a2FwWEsyT084NTBRNlpDTktOWm5jbVRtV3dTQWJ1blNZSVU1UVR4WjVNQTM2?=
 =?utf-8?B?SEFvMnZYVVRSa29VNjFEQ296aXlyQWd0WEYwMzNuTXBYbWFSSi84MXhnL2VW?=
 =?utf-8?B?cllGeDVKLzFIdmQrMStqamZIeDczQVBKdlZ6T2VjalVZMWIybGZuVXlqV280?=
 =?utf-8?B?SlJOOWZEekcrZXExK0hGVHBiT05yYnR5QzRZT1pQMnlFWHVUc3hvTmNyV3Bh?=
 =?utf-8?B?cXVqUlJVQmFzZzhXMVBLd2l5anJyWGFkYjRVQlUxVEc2aEpvWHRvdnhpY1Ez?=
 =?utf-8?B?d0NlVlZzRDkxUDJTdWhwNFVVeGxqdStwK2VSUmc1UUZIV0NSaFJubTFzK2s4?=
 =?utf-8?B?WXV1RWM0RjF0WmJSTHF4bjJ6Y0czd3hNdkxHTjNSZ2t2RkM4S3ZObW9RTllS?=
 =?utf-8?B?b1pCb1RvZFBTZFU0c3lpOEpkUVNQalVwRUtrR0Z0Wm4yZERFbktPZzNSZWRS?=
 =?utf-8?B?ekZHM1hBZElhbGpLd1gyMklBcnV3M3AvS1dPaWZpS01TaUxNZUdyZ3lQeU9T?=
 =?utf-8?B?Vk1JcnVwV3NjaFdWZmMxczQ4WlhkMXFJV2FtTHk3dFVXUlBzYWYzMWhRV1g4?=
 =?utf-8?B?Uk1SRzdKQUxkS0NRMVdrYk9uajMwZW1ZbytlbFU5Vmw2aTBOb2dZSUdlbWk3?=
 =?utf-8?B?Rm5iMWFjam9OMm8ya3l3anNLekp2VWlpT2c4UVFsY1RJWlhFQnQ3eG5yUHMy?=
 =?utf-8?Q?51U+GLvvnfx5p+3Yl8SyffRMm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d842bf44-862b-42e3-8d0e-08da9cadfafa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:20:28.4892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIcadqeI9FT6yZnOu89zvmLvm8sdrFqknzX1NLNCtFFhFjVCxpdsiJC0CaLZzF8/yhNXHTNqeI7BLSZ9S+fpRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/22/2022 7:04 PM, Alex Deucher wrote:
> On Thu, Sep 22, 2022 at 9:19 AM Arunpravin Paneer Selvam
> <Arunpravin.PaneerSelvam@amd.com> wrote:
>> DRM buddy manager allocates the contiguous memory requests in
>> a single block or multiple blocks. So for the ttm move operation
>> (incase of low vram memory) we should consider all the blocks to
>> compute the total memory size which compared with the struct
>> ttm_resource num_pages in order to verify that the blocks are
>> contiguous for the eviction process.
>>
>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Please add a Fixes line and any relevant bug report links.
Hi Alex,
There is no bug created for this issue, I will add Fixes line.

Thanks,
Arun
>
> Alex
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index b1c455329023..b1223c8e30c9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -426,6 +426,7 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>>   {
>>          uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>>          struct amdgpu_res_cursor cursor;
>> +       u64 start, size, total_size = 0;
>>
>>          if (mem->mem_type == TTM_PL_SYSTEM ||
>>              mem->mem_type == TTM_PL_TT)
>> @@ -435,8 +436,23 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>>
>>          amdgpu_res_first(mem, 0, mem_size, &cursor);
>>
>> -       /* ttm_resource_ioremap only supports contiguous memory */
>> -       if (cursor.size != mem_size)
>> +       do {
>> +               start = cursor.start;
>> +               size = cursor.size;
>> +
>> +               total_size += size;
>> +
>> +               amdgpu_res_next(&cursor, cursor.size);
>> +
>> +               if (!cursor.remaining)
>> +                       break;
>> +
>> +               /* ttm_resource_ioremap only supports contiguous memory */
>> +               if (start + size != cursor.start)
>> +                       return false;
>> +       } while (1);
>> +
>> +       if (total_size != mem_size)
>>                  return false;
>>
>>          return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
>> --
>> 2.25.1
>>

