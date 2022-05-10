Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA74C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B6710E271;
	Tue, 10 May 2022 15:40:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEFA10E271
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A99vHXf3yt00HDtBTWb3Ymq4MllV8pvJxSkH+0O1NYIJCt9AC6hqLsEPbdo58RAOww9BqIoNJCcCOvH9OIRIBf7IC4NIMpDrixq0FuiOCd6E5mCz5ZxbxOK6pSctovnVO4uHcsaJmTJ5GfPnORLf97W1Qk5gtQfKeqVjkDPzbE6eKaK/I6Q0I8Vu+yd+kwKXbR/TFaOIhIYjiTBBZMoV73a7v4Zd8/fmAxbXxEQbA1MydIeUM57GVvuJypVWa3o+ru73P4zkiDXTzhBS+CP/Z6tYlEpelFhIsgdWvEdilur79XO2NlFhHP5kFmdDJGWTYq485xjSuZ6MLrufFCbL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOTjs3BEZLvD9+JwOhyYiMvPCRB9Y+XiplkovpqRiNY=;
 b=TCewEXMXhNrIvHIoAg2OjV1qv/eaODHgQKoPOSVde7bF5801J88Zx/lOeTiNXjwPFPu3UpKOPBRFL4ylPpDYKA+BRrsvwtPkcRGFfPoUSVlGgoeKP+U1KrnYK7qwuMjL/oEXWJ639s7izR/8YtlwIqJ1dPxPUFduaNtezu0Eowfp/0XDP/aXpt7bBElP55eW3ZrdMy7zBQtMnWTS1KNdbzXSa7tep7jHKCn1pJGcv9T0MD2JMSN0zPgiYyKufGMaln2whtVXKat529Ihql9AoopdgHG32lfP8ieUOBtCKVvJIL32vk1UG4rxuMI4ous3+MvdXXGifxbVJN8mJKQ3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOTjs3BEZLvD9+JwOhyYiMvPCRB9Y+XiplkovpqRiNY=;
 b=JYHBjIYUuZVLYj1pOjqzuI5RjsmdoVA5YU265j4l/C9lEdRcNEVQqPU2xEf+WKrw6azmX+aRDYPfNQNG6n9K70jPE+UZFWtuvLaXNwmWLxzAsLD7s7QV667b7iET4wu/g0/uGHWsRu5ZZskpe3bDJx564GyTuftDLuxkV6kM4bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 15:40:41 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:40:41 +0000
Message-ID: <3b06ca9c-d5f0-e0d9-e4d3-2b17791fdb19@amd.com>
Date: Tue, 10 May 2022 21:10:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix start calculation in
 amdgpu_vram_mgr_new
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220510113649.879821-1-christian.koenig@amd.com>
 <90f223dd-d6bc-3f98-a620-e61df3af6f5b@amd.com>
 <91bb776c-9898-51c5-dfdf-d514ac7a9305@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <91bb776c-9898-51c5-dfdf-d514ac7a9305@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::13) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bc57952-b76e-4c2a-4b4b-08da329b7067
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4672BEC29FE68A4C468DDA24E4C99@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BqLEoTfS3ma2NyNb15I7GBL2U6sxcIKAWvrPfUAbAgWYvLfasfAeb1dDLgqF9JC7yIz96FHUAUgemzPaWofYJZp6ABzsE79TRgO68ZCw6liuFBIsbjEeUak6L65Ja0LNH8qprE2AgmWpcK+atfmdDgU/W29fyGr4IlJtcdMOVtBRK2ov93lADEOpVR/hjfyHItcWxjaTWl6uIy5Aaolzjg+mUaqSp1MjhONbEHEEAfmFNHXzJ12Y6iBrSz0SIgV9bOdUCr7JtW3xNINeq9wWFY/ge1lNDysN6y2xg3HYB/yJWgWZm22Bq0CxJrDg3VFoL/8BHN3iHyeGGx9/RvwtL4GD+ON30ixjyhw7hnxA1kWEHEyjCTtyQ6jZEw4ab/CYB+RNYUd5LSKKO+up63XpVG69zcyjp7U1gD98B+mkBYiekhJvhusvSY1w7JX1E6M38N7rRABvPP4FR4DF3Tg0vMQxbh1k9x5KbXeremW+N4sP7eeLCDgWALMJWts++Y4q0Ff6JiG7Dw8G6K0jQgyBPSrP+FFTtobeRud0OGamjGsAHr+FuUXF/Fj0Na6k4AXCEXMciN87rUpvZRJsA9MXoimy7gAW+bNxM9naxme167r+x1LOCxFknnn5767sH9c3fMlNAx9+LL0zpsg3sG/wy+NoQXAtc76f/1EsoUY3GVMjXAPAzETi+ag3bQXMGIVS8ZQ/MOVe+B1OkwWeq/1X5JguaeQEnkn4J3/NX9UZWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(6506007)(110136005)(508600001)(6486002)(2616005)(83380400001)(5660300002)(31686004)(6512007)(316002)(53546011)(8936002)(66946007)(38100700002)(6666004)(8676002)(66476007)(186003)(66556008)(26005)(31696002)(66574015)(2906002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RMeTNlSXFwanR1OVRIQnV5N1ozcGdRQzU3TGYyTnk1cTlwRWwwQ1Fmbk5w?=
 =?utf-8?B?Vy8xK3orOWhRU1l0MVNJM1ZPVXpoS2VPL2lsK2tDemp6M3ZTSVhpY3lrc0NF?=
 =?utf-8?B?Y2pURHN5NjNMS1NubnF2Slk0Z2tWR1dDUFFpc1dxcnNySzZwaDBodnJHejVR?=
 =?utf-8?B?VmEzeWRqZnBRYjZyZmFvVnZLVGRKSS9Oa1VXM2MzUWVzSzhLaDZUU2QrSlpC?=
 =?utf-8?B?dThTUThva2hPMUtDODNRTUJhQkJxTWZ3S1drVm1abVBjelUxN2ZyYWkyMzNz?=
 =?utf-8?B?RWhkRW9maDRCYlZjZXhQeDJEeTRJSEpSR1VydmhtZGFBQWJzSUtHQUxkMnk5?=
 =?utf-8?B?MVh6NWZrdFcwSDY2NEsrTjRLQXRYZ0tTZ05CbHd1bHJHSVFpOHdlN1UwVnFH?=
 =?utf-8?B?MWIwRHdYZFJEa2NvSXNZVUkvZVJBeFZpejltVFpJeWEybFAvbU5sdDl4Nkh5?=
 =?utf-8?B?bnB6NkQrMC9aWkxSZUwva2RyZkZLd0kvOVM5ZzU2bFVqQjN5Vm9LckNwajVs?=
 =?utf-8?B?d0luRDFPZk9PSjRNZS92YjQxVDhLQndiaDJLZDB0dENXZUdiaHlrRkp2ZDlC?=
 =?utf-8?B?VVVGYmtndHpHZnpacGh3WVIxeENZNlU0V3l6dEVJR2N1SmZaTzdTb0FoTHpU?=
 =?utf-8?B?TjJsZjhaZWRVZ2o2TWk1cUhwb2MyQkp3TUgvcjVDckZReDJ5dUFnamdQbjA0?=
 =?utf-8?B?WXdOZWIxbXpGbXcySng4VEl5SE56L05vL0VLblNyb3RBajVUVU1NNXZDK1l5?=
 =?utf-8?B?VFlsUFVKZHNXWUZYQ0dRVUl1cEhJWjdzV1Y5WjI0aEtlQjVYQVdIK2hlVVBI?=
 =?utf-8?B?U25JYXh1Y0E4NjdIckJ4dWJPL3FYOUZjT0QzcVFHK0pxOVZhTUc5SVdYTENZ?=
 =?utf-8?B?aG1FZGF5T1lPaTBRNHc4MnBKSzNSY01tS0ZnSmxrKytWZGhJYXRUK3RicFZ3?=
 =?utf-8?B?RU1lU3hEMUtBd1ptVFEzNnR0NGpEc2YzTmhxSXROa1pybGRUNWJjUlBIVUMy?=
 =?utf-8?B?ODY3d1ZzcEhoTmM3cGE5d0ZNVGVEMWM5MkRMRnhtOGZyUnFWWGhralNaSU1m?=
 =?utf-8?B?WGhaVlUvMmVBcktYejIwUThOZ1FuMnZqK29TZXlTQ1lQaUdmZUM0aGxHVXJ3?=
 =?utf-8?B?Q01DWGJtbGg1Q3dwQ01YcG83SXcxd0lITkJYT3hHeUI3ZmtSTFhML3dJKzZt?=
 =?utf-8?B?SGdjb0xrZ1Q0TmxIanQ3T2pESVkzVCtCb1phOEVqQ3RWanh5SmRxWG5adC9q?=
 =?utf-8?B?cTRZdUUvWk8xRTFpcEhWM3RqeHdUOUdicExualJIVDY0TG5WNkY5NWo4L2JB?=
 =?utf-8?B?Q1pmdHc0NGUwNmpmbGdTZGNZaHArT0huVkVFbG5EK1dtZU1FY3c5QmNOb1Bv?=
 =?utf-8?B?VkVjdlFrTlRmNXhZVjkwTzJpamVxRklFeXpuZHRQYXFZTjRNbWlRemlOcnky?=
 =?utf-8?B?MzNnN1RBaEZaaERqU1NLOStLSElYVTlidFk4bVNNM3lnVlRySTBrYjBsNXVk?=
 =?utf-8?B?dU4vT2pIZndUaHo2ekV4dTZWNXl0SjM0clhqTjNNb2pJMlFaUDlRM3FoTUQw?=
 =?utf-8?B?Z3dvRU05ZkhDVFlPYjJoaUVSMXM5My9lOHlSSHA4ZWpGZi9yMTJPVFR4cThy?=
 =?utf-8?B?dFZsWEg2aE8wUzJCOEtQeG1JRGhBS2d2QmNLREFjc2ZKb0QwNXo2a2R2RFB0?=
 =?utf-8?B?bUlxbjBOWlRZemJqR0xrc20zRDlMQ2crNTFaTHAza0tEOWUveENFYVZ5cHp1?=
 =?utf-8?B?UHhqTHlRdThZK25HTTV5SVFuMWJrM1VJZlc0VE95MVRldmFaaG9pV1RLS3Ru?=
 =?utf-8?B?Zkt2ajdLTWJ3S0RmL05WUUg2TlNETFlXZlY2Q1BjTkRad0Nrak5KZ2dXK0JD?=
 =?utf-8?B?dW5WVXdUUDJNRi9lbkZFWUIwT0RWenYyLzF4VkQ5ZldheXcrcm9CN2daY3JG?=
 =?utf-8?B?K3N4UE44a0VYYWxQcHpvV0dQMG5YVjdkb0tMU0Vnb0RvcEREZ3E0R1l5VlFY?=
 =?utf-8?B?OE9uQ2dsM0p0WFdrenp3d2YvVUx2aDRKYTlqbHUvREN2OVFwY3h3S0dwMGUx?=
 =?utf-8?B?NjIyTnJPcFQ1NE83clVza3NKRklBQWJNaTE4Vk94NS9Ea0YveTM5Kzl3YTZq?=
 =?utf-8?B?SXpVMnZ3QVIvTlVrTzk0V0lUR0Z3VXkwSHlUVTlxSG9RQjN5ZXNQc0Vqd29W?=
 =?utf-8?B?eG5zTUpXVTVBVlJVaGtXQll0WFZ6dm4waW9LNkluYUdkalZ3eXl1RjRaYWhZ?=
 =?utf-8?B?M0FneDdqSExCTTkvaW43YzdUTTlxOVpKWUFaSlA5VnlyTGNpTmROMWQ3cWxW?=
 =?utf-8?B?U2EySGV3bk5USXZlYTQ0TU1ZYkhWUFp5S2FqQjZZV0tLNjhmMndzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc57952-b76e-4c2a-4b4b-08da329b7067
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:40:41.6608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQa0B9hJxSDnkKuIu0AmDSaBdyGZHQfhPb7X1ig24HUNMElCW4wjwgU9qod78adhD3xMbVcZCDQjjCtVorL/hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
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



On 5/10/2022 8:56 PM, Christian König wrote:
> Am 10.05.22 um 17:20 schrieb Arunpravin Paneer Selvam:
>> Hi Christian,
>>
>> On 5/10/2022 5:06 PM, Christian König wrote:
>>> We still need to calculate a virtual start address for the resource to
>>> aid checking of it is visible or not.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 
>>> +++++++++++++-------
>>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 49e4092f447f..51d9d3a4456c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>               list_splice_tail(trim_list, &vres->blocks);
>>>       }
>>>   -    list_for_each_entry(block, &vres->blocks, link)
>>> -        vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>>> +    vres->base.start = 0;
>>> +    list_for_each_entry(block, &vres->blocks, link) {
>>> +        unsigned long start;
>>>   -    block = amdgpu_vram_mgr_first_block(&vres->blocks);
>>> -    if (!block) {
>>> -        r = -EINVAL;
>>> -        goto error_fini;
>>> -    }
>>> +        start = amdgpu_vram_mgr_block_start(block) +
>>> +            amdgpu_vram_mgr_block_size(block);
>>> +        start >>= PAGE_SHIFT;
>>>   -    vres->base.start = amdgpu_vram_mgr_block_start(block) >> 
>>> PAGE_SHIFT;
>>> +        if (start > vres->base.num_pages)
>>> +            start -= vres->base.num_pages;
>> I think this works for continuous blocks of addresses, but for a non 
>> continuous blocks allocated at different
>> locations and linked together using list, this might fetch an invalid 
>> address. I will check this patch on my
>> setup and inform you.
>
> It indeed does fetch an invalid address and that is perfectly expected 
> behavior.
>
> See the resource->start value for non-contiguous allocations is just 
> the maximum allocated address.
>
> This makes it possible to easily check if a buffer is inside the CPU 
> accessible VRAM window or not.
>
> As I said we should probably get rid of that, but for now it's necessary.

ah. good point.
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Regards,
> Christian.
>
>>
>> Regards,
>> Arun
>>> +        else
>>> +            start = 0;
>>> +        vres->base.start = max(vres->base.start, start);
>>> +
>>> +        vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>>> +    }
>>>         if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>>>           vres->base.placement |= TTM_PL_FLAG_CONTIGUOUS;
>>
>

