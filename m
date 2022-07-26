Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3A6C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 01:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4908411B498;
	Tue, 26 Jul 2022 01:48:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19E211B487
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 01:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKqhU96ZzX24Vtq87xFKLQbfN/bGePn6jO8++mJMyXTHMYDCDcybNOq8+b9IYxTzgIClBxK1OB44/kWEgV+5ECg6gyAIpcUhjjhOJ8Y5zQazcVTu13+63LAEFqTLg+lq8MOI69SN8De53aSaqC5prHrmJVgFEhb8jO0FFRUjltZyQeS4PLerV2vC/2EGOjLsLE7epfjL+V/7VH1SrFKvSxxROZlbqbdoCbEe5xunlQETttcg0X0oDKC6uxhkLz9NWfJIEXEqIxpjRn3qhvKKGUeJCiAwKciF6SgnWtA7eaPS9fOgTbquqa4HeyTPRwLmsVDWjscprpwwQESfTNea0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vQ3ozX3FZtdv9gcxUkq5WHSIX5My2ms+N1Hx3whSBo=;
 b=hl21DZfra0RyMxh6BRliFHBwRDTnUKE8Orh/R3lBlXjYl/qvR7jD4kXQS6O89OuTr+ym872/L6dmG07PFZn3r+eq5RGdraEaNpHUdtUyxtAXBG7SBD6DeZ9nPZpkOyR7ZjYAJMEYCOFrLp/mHoFa+NmyYE+Mts51BM3cIpjqAK4C3BiwhDdejT4UeJzLNYCxM04bYl9CVch3nOCud87Xtbs7tv1PWx9KGv4LGR3ieS+Zg4c3f231uhxUdwKph0KOdHrJxI+3AMIiXJcgulWUN8Zy9DTLAKpWgyRoXkFrTtYk0MFBTKoybUIJkFGCkA7a5nw+tmPOJmCKIzelsNc/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vQ3ozX3FZtdv9gcxUkq5WHSIX5My2ms+N1Hx3whSBo=;
 b=OUCnp5ytwwhUvr0C+weJFzdb37/DGN0zdFWG4MYj+7dcohk0q7XEtQlriHdaw3jfUEf9p5xPvPbmuPBAx6ALE4PlrpWxyydOVIYJ4oGl62ghc7nJ8ZUuZA0N1cnIlH7MrM6tXoz7Nm8gPLxVBMrXbSS8CNEGIT4fhP9/tL6/96g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 01:48:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 01:48:54 +0000
Message-ID: <fc9bff98-1d79-b769-6999-f792c045193c@amd.com>
Date: Mon, 25 Jul 2022 21:48:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
 <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
 <Yt8yHSREAp6sRK+K@lang-desktop>
 <9548e049-8567-7479-7939-4cd12e856153@amd.com>
 <Yt84EdsZe/2QCneC@lang-desktop>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <Yt84EdsZe/2QCneC@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14a666f9-123a-45f8-8406-08da6ea8ff20
X-MS-TrafficTypeDiagnostic: CH0PR12MB5091:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ec3KBfQJbMH0Ci5onPFRDaeVasxx3QVcaFheX7l2Oi1Pccvjb9b4ni6HJUwNV1VC+lGq+AWc9EBJxzd/N8aDDT1cAlC8ExI/OvJNTpnDDRARv6MA+LB1ZYJKlX7+CWCbnfPDFfAWr7xZQjXjwuoGLT3ZjPuYdqH30YD0VtEhfQIkMPFF1KnChfivGnUzYQS8b7pVgZFGZCaaCz4BsxbKqO9JDjihlaMSmdBOZ0TWMd8y8nW9aEsmTssXTL0oeLwsn5lHKakG6p5sYw15QgdvMB6IQuI1f/hkLuikcfuazPzXiMShV3KMhk5b10wDoVOcfk7b3pfJbgxVS3gc3Pcv2sMymsRiOI1bs48PVKNcmK+hjfcAIKQ1uqyhiZPJK/4xRS5VozrZ+undVm3exqUd6SyalnZRTN365Upi/r24M+YElOZQ7I7fteQFPPISHOvC44Oux2CyaMIeRM7ggl3qdo22BOxKvFFKMXPRkMKiDszp3VBQZxkMFuIIx07PXTOZht3EgtmT/f0r8Yt+YqOkGP+C7VkwgAmA7wQlZuBD0XRu7wHPmhgfZDM9WyD4FZH+KSGbT2p/4ktW6KIUZ9cm8uKYLmemLjQumTgTVG9lFIdqxwfUch8AnJPH7dQP2LIg5f8xoJClEnq7zkP8CumjPcCW8tr0LlyfkQtyG+7rU0sUZeSf0DVinFs9j8H7S2b050dqWHl9P/wzqXLevsKt+On6DvBg+wqlsdAfSw8vksnFC1QdniBlQw+uUZMpLmHtCnUqAtBmKdUpj8tt1yPCd+q12Kek2nezSStgEPCEUuD3x4ASFsZRjXW5aEZdLbgafeuBnmRcfbrUp7XHSz+yiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(83380400001)(8936002)(6862004)(6486002)(478600001)(2616005)(31696002)(38100700002)(6506007)(26005)(6512007)(86362001)(44832011)(5660300002)(186003)(41300700001)(2906002)(6666004)(6636002)(37006003)(54906003)(31686004)(36756003)(316002)(66556008)(66946007)(66476007)(8676002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTY4VmZQaXdmamJHTno4SjhMb2pic2M3YUpudS90bjBpL2h5Qm9UbGhRY2RN?=
 =?utf-8?B?WGdDK25PbG9QY0d4am5Qd1hwVmZkNER6NExBWWRBV3FaREozenNwekhidzJI?=
 =?utf-8?B?SkxHdGFrK0d5SmZCNXVXdHFKOWMweFhFcFcrYU9QK0Z2YXQ5S1RnRjMyRmZa?=
 =?utf-8?B?Nml0OExzb2Y2VGEyN0ZkZDlMN0lFVDU0SGJ1K1phUmdyL0kzcEFVTWNlY0pl?=
 =?utf-8?B?K2tYaDBxZHgxcW10cHBpRlhudkt3emlrcWVDeHJZTk4rRENpMy9Eb3h0VHFP?=
 =?utf-8?B?cUJDZTcyRndVNWNSdmpqOVY5d090aFRjVGRNZ20wb1c2NUJUQjczUnlaYm1n?=
 =?utf-8?B?UVY2Q1dZQWJJak1OV1BYbEt0ejBGZ2JhZFhtdWVzSm9FLzA2YlZmWEo5U0pn?=
 =?utf-8?B?aDU2L1lyODA1bkdVT0xDK09UZkZqbTU4bE5lRlpsNHlKYzk2UVN1Qlh5dEtp?=
 =?utf-8?B?MklYRDZhaFJ6WWdpVjB5YXpjMmRXTDRQdU5YU3JwVG82MkowSnZKMEhoZ2d0?=
 =?utf-8?B?UDFrZzhtaTVKS1pvMmZFcktydXdQbndyWlFUcXFWTU1hemNzWDFUa21JcjBy?=
 =?utf-8?B?UWhodSttclZ4RS9OelFyY2pLM285dDFRT3huN2lyRllpb3Fkc25YSUZkZXZp?=
 =?utf-8?B?ay9QVXZKZlA4dC81QVg1Y3hqdTlmcFdpeUJWWmN3SW5GWGh4b1J2dFNiTTFJ?=
 =?utf-8?B?UW82Y1E4bkdrMlA5YVdYVUJDMkQvay9rOXg4UXNWTmpJQ0lxZ2Frdk1WNXZ1?=
 =?utf-8?B?T05VbzdLOHRodFE2d1U5bGJ1cVdrM2JlUG5yc3BDczI4MHhrdEhGRzdHT0ds?=
 =?utf-8?B?d21LbS96azJRdkwvdVFUR2p1aGJ3VmhucFBqNXIvNnJ4ejR0OFBqaXJIM3Jj?=
 =?utf-8?B?R0NYY0szd051N1U2aFVEOUx5Ylc5SGhHN1BNTnRyZmROeW96TXNldWFiejAr?=
 =?utf-8?B?ZzhmK0dkcmRWVUVBakNnK2l4M2k5Y0NHbm12dHBMYUJpb0lEaHJKUGM5SWE3?=
 =?utf-8?B?OFl5ZjFpdkNINEZyMmJlclZSNjV5TDRtTG9ZWUV0TGd5ajI1eGFmclBHM1pR?=
 =?utf-8?B?M3k1cEl6Ti9PVTRWWDhRMms5b3M4WVRlcXNKRldrdnM4WWVzRGpFNlBKMEJ5?=
 =?utf-8?B?OU10cUl4N3ZKc29HVkdFbFAxMVVzN2RkMUV2R01qVUxVMUZ5WkZ5dGdxQkt6?=
 =?utf-8?B?UFU3TlJuTnMwTENMVlJiOVljd3FLM2ZlejJNM1hxcVdtREhMOEx1cCtMUHFi?=
 =?utf-8?B?VVVveFFENTBLVWd5V2xvVjNGL25NeDhEU2pyOHlLMU9pako2YjdjU0x6emt1?=
 =?utf-8?B?c25IbzQ0ZmJNTTdCQ1hSTGRCSFd4YVdpVFBXVUdWQlJweFR3VStabFB0QXJR?=
 =?utf-8?B?SlBRM3FVd3V5eHBPRGIyOVhXVE5uS3FURzByNmp5TnBMNjNYanlrR24wclVP?=
 =?utf-8?B?L1VXR0JNSk1DZENjMFBzdEJpMmY1OTZxRENmbzNFNnowV3pnT3RMbjJDN0dT?=
 =?utf-8?B?UFpNakNvdkZtRlpEVWYvdHVGTWdOL0p5N0RnMk5ib3Y0K2JkaUc4U0had3lJ?=
 =?utf-8?B?a1NIaktJaUtlWEJpN3BJSDEyYWpWSU5KYnhORVBWMmpqUmRwTGRKSDh4dE9U?=
 =?utf-8?B?ZTQ3ckFTdExXWmhiQTEzQUtZekVBdFRCWkh0OW90UWRoR0FycEkvblUwSnFF?=
 =?utf-8?B?cmhxa05GSmdFNmNiK1JPa0x6MEZucE8vZzJMMEhTRFMrNmRXWXI2eU5Xamt3?=
 =?utf-8?B?M0JtVFpQSHY1cTI3ZHNyZFZEc25MM2hNWHE4K29adldFa0k3L0xlTVhzR1hW?=
 =?utf-8?B?WlFxOEQvSmdIbzBWdkFRZDhwWUhjSjVJU3lJVk1nU2NSUk1Wd0tvVFl5KytX?=
 =?utf-8?B?TXMyQXpSeUREc2U4L2x1Z1N3aSs2UldCUUZ1T0Y5VkV2WTBXN2c4TVl5TW5n?=
 =?utf-8?B?NkFnMTMxY1JjdFdaajVUalh0OXYyTmo2SVlFRW5jT1A4dlRBZ24zcHlkd1pl?=
 =?utf-8?B?czJJYU5wbUpXcXRIWVJKcVBzUjZUb3JPaUJvZVE2YVNtQVlSMVg3U1F5dUll?=
 =?utf-8?B?QXNSNFJBYmw0VnIxQytReGs5UFJRVE85ZnpxZTQwRjdxdFlXV3Q0NW5aa3Yr?=
 =?utf-8?Q?tE8gSV4jkH3Ke4nL4AT1N7jP8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a666f9-123a-45f8-8406-08da6ea8ff20
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 01:48:54.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJa9CQ6fWnQWjCxefMdNkhM+bZIVV3fwmRmk7edxquy3yQq5Av28pc65+sy8fco9zTnGNOKszbVLX32SjjXb9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-07-25 um 20:40 schrieb Lang Yu:
> On 07/25/ , Felix Kuehling wrote:
>> Am 2022-07-25 um 20:15 schrieb Lang Yu:
>>> On 07/25/ , Felix Kuehling wrote:
>>>> Am 2022-07-25 um 06:32 schrieb Lang Yu:
>>>>> We have memory leak issue in current implenmention, i.e.,
>>>>> the allocated struct kgd_mem memory is not handled properly.
>>>>>
>>>>> The idea is always creating a buffer object when importing
>>>>> a gfx BO based dmabuf.
>>>>>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
>>>>>     1 file changed, 70 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index b3806ebe5ef7..c1855b72a3f0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>>>>>     	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>>>>     	u64 size = amdgpu_bo_size(bo);
>>>>> -	unreserve_mem_limit(adev, size, alloc_flags);
>>>>> +	if (!bo->kfd_bo->is_imported)
>>>>> +		unreserve_mem_limit(adev, size, alloc_flags);
>>>>>     	kfree(bo->kfd_bo);
>>>>>     }
>>>>> @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>>>>>     	}
>>>>>     }
>>>>> +static struct drm_gem_object*
>>>>> +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
>>>>> +{
>>>>> +	struct drm_gem_object *gobj;
>>>>> +	struct amdgpu_bo *abo;
>>>>> +
>>>>> +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
>>>> I'd rather remove this limitation. We should be able to use any DMABuf with
>>>> KFD. This check was added when we basically sidestepped all the dmabuf
>>>> attachment code and just extracted the amdgpu_bo ourselves. I don't think we
>>>> want to keep doing that.
>>> This limitation here is to just reference the gobj if it is an amdgpu bo
>>> and from same device instead of creating a gobj when importing a dmabuf.
>>>
>>>> Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf
>>>> import" sent to amd-gfx on March 16. I'm about to send an updated version of
>>>> this as part of upstream RDMA support soon.
>>> The "drm/amdgpu: Generalize KFD dmabuf import" doesn't handle the struct kgd_mem
>>> memory leak issue. Looking forward to the updated version. Thanks!
>> Maybe we're trying to fix different problems. Can you give a more detailed
>> explanation of the memory leak you're seeing? It's not obvious to me.
> The struct kgd_mem is allocted by "*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);",
> but it is not assigned to bo->kfd_bo like this "bo->kfd_bo = *mem;". Then *mem will
> never be freed.

True. With the current upstream driver there is no way this can happen, 
because we don't have an API for KFD to export a dmabuf in a way that 
could later be imported. But with the RDMA and IPC features we're 
working on, this becomes a real possibility.

Your solution is to ensure that the dmabuf import always creates a new 
amdgpu_bo. But that can add a lot of overhead. How about this idea: In 
amdgpu_amdkfd_gpuvm_free_memory_of_gpu we could add this after 
drm_gem_object_put:

	if (mem->bo->kfd_bo != mem)
		kfree(mem);

That way amdgpu_amdkfd_release_notify would only be responsible for 
freeing the original kgd_mem. Any imports will be freed explicitly.

Regards,
   Felix


>
> Regards,
> Lang
>
>> The problem I'm trying to solve is, to ensure that each exported BO only has
>> a single dmabuf because we run into problems with GEM if we have multiple
>> dmabufs pointing to the same GEM object. That also enables re-exporting
>> dmabufs of imported BOs. At the same time I'm removing any limitations of
>> the types of BOs we can import, and trying to eliminate any custom dmabuf
>> handling in KFD.
>>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Lang
>>>
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>>> +		gobj = dma_buf->priv;
>>>>> +		abo = gem_to_amdgpu_bo(gobj);
>>>>> +		if (gobj->dev == dev && abo->kfd_bo) {
>>>>> +			drm_gem_object_get(gobj);
>>>>> +			return gobj;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
>>>>> +}
>>>>> +
>>>>>     static int
>>>>>     kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>>>>     		      struct amdgpu_bo **bo)
>>>>> @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>>>>     		}
>>>>>     	}
>>>>> -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
>>>>> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
>>>>>     	if (IS_ERR(gobj))
>>>>>     		return PTR_ERR(gobj);
>>>>> @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>     {
>>>>>     	struct amdkfd_process_info *process_info = mem->process_info;
>>>>>     	unsigned long bo_size = mem->bo->tbo.base.size;
>>>>> +	bool is_imported = false;
>>>>> +	struct drm_gem_object *imported_gobj;
>>>>>     	struct kfd_mem_attachment *entry, *tmp;
>>>>>     	struct bo_vm_reservation_context ctx;
>>>>>     	struct ttm_validate_buffer *bo_list_entry;
>>>>>     	unsigned int mapped_to_gpu_memory;
>>>>>     	int ret;
>>>>> -	bool is_imported = false;
>>>>>     	mutex_lock(&mem->lock);
>>>>> @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>     	}
>>>>>     	/* Free the BO*/
>>>>> -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>>>>> +	if (!is_imported) {
>>>>> +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>>>>> +	} else {
>>>>> +		imported_gobj = mem->dmabuf->priv;
>>>>> +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
>>>>> +	}
>>>>> +
>>>>>     	if (mem->dmabuf)
>>>>>     		dma_buf_put(mem->dmabuf);
>>>>>     	mutex_destroy(&mem->lock);
>>>>> @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>>>>>     				      uint64_t *mmap_offset)
>>>>>     {
>>>>>     	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>>>>> -	struct drm_gem_object *obj;
>>>>> -	struct amdgpu_bo *bo;
>>>>> +	struct drm_gem_object *imported_gobj, *gobj;
>>>>> +	struct amdgpu_bo *imported_bo, *bo;
>>>>>     	int ret;
>>>>> -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
>>>>> -		/* Can't handle non-graphics buffers */
>>>>> +	/*
>>>>> +	 * Can't handle non-graphics buffers and
>>>>> +	 * buffers from other devices
>>>>> +	 */
>>>>> +	imported_gobj = dma_buf->priv;
>>>>> +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
>>>>> +	    drm_to_adev(imported_gobj->dev) != adev)
>>>>>     		return -EINVAL;
>>>>> -	obj = dma_buf->priv;
>>>>> -	if (drm_to_adev(obj->dev) != adev)
>>>>> -		/* Can't handle buffers from other devices */
>>>>> +	/* Only VRAM and GTT BOs are supported */
>>>>> +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
>>>>> +	if (!(imported_bo->preferred_domains &
>>>>> +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
>>>>>     		return -EINVAL;
>>>>> -	bo = gem_to_amdgpu_bo(obj);
>>>>> -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
>>>>> -				    AMDGPU_GEM_DOMAIN_GTT)))
>>>>> -		/* Only VRAM and GTT BOs are supported */
>>>>> -		return -EINVAL;
>>>>> +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>>>> -	if (!*mem)
>>>>> -		return -ENOMEM;
>>>>> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
>>>>> +	if (IS_ERR(gobj)) {
>>>>> +		ret = PTR_ERR(gobj);
>>>>> +		goto err_import;
>>>>> +	}
>>>>> -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
>>>>> -	if (ret) {
>>>>> -		kfree(mem);
>>>>> -		return ret;
>>>>> +	bo = gem_to_amdgpu_bo(gobj);
>>>>> +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>>>>> +
>>>>> +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>>>> +	if (!*mem) {
>>>>> +		ret = -ENOMEM;
>>>>> +		goto err_alloc_mem;
>>>>>     	}
>>>>>     	if (size)
>>>>> -		*size = amdgpu_bo_size(bo);
>>>>> +		*size = amdgpu_bo_size(imported_bo);
>>>>>     	if (mmap_offset)
>>>>> -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
>>>>> +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
>>>>>     	INIT_LIST_HEAD(&(*mem)->attachments);
>>>>>     	mutex_init(&(*mem)->lock);
>>>>>     	(*mem)->alloc_flags =
>>>>> -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>>>> +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>>>>     		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
>>>>>     		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
>>>>>     		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>>>>> -	drm_gem_object_get(&bo->tbo.base);
>>>>> +	get_dma_buf(dma_buf);
>>>>> +	(*mem)->dmabuf = dma_buf;
>>>>>     	(*mem)->bo = bo;
>>>>>     	(*mem)->va = va;
>>>>> -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>>>> -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
>>>>> +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
>>>>>     	(*mem)->mapped_to_gpu_memory = 0;
>>>>>     	(*mem)->process_info = avm->process_info;
>>>>>     	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
>>>>>     	amdgpu_sync_create(&(*mem)->sync);
>>>>>     	(*mem)->is_imported = true;
>>>>> +	bo->kfd_bo = *mem;
>>>>>     	return 0;
>>>>> +err_import:
>>>>> +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
>>>>> +err_alloc_mem:
>>>>> +	drm_gem_object_put(gobj);
>>>>> +	return ret;
>>>>>     }
>>>>>     /* Evict a userptr BO by stopping the queues if necessary
