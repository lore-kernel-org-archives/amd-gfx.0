Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B11C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C0210E2C8;
	Wed,  3 Jan 2024 14:19:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D08C10E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU90V6nZneQb49ARS6DcPwYIrjbVXTbN8oNs/krKOmKWMoDoDMkM1/2MokUJCj35wPk7x4+voLi5EV+3GEazBgLPgRKWS33+l85awIKz/Oc3Rmn8LEm5jk44uJTTvSqCE8Vg6+Q4lawQ3blCSYbrXpPcxAu5Vp/1wQtBKEV//OPyy7Zp6GdiiRlYRT6uU3qQVzdmrqLLz8tqmFCpHaez0NuXAxzNeEhFjEGuZQMiLMT0OSQQufR3a3vgZKbKozK+7ZYCE6oLQz3UbYW55UyOy9ItCX5Nt6aJ8BHeSEqCJ3jNR8JRvhjib22h/oYmKLF3aLizqxqi/FIQPFUWAB4OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPk0QZp846FMbFRvutGdAAotCIbgUyKGCaVz0KM6VFE=;
 b=GrEwDNrQ+sRKNVyFNK2MYeLG8l7qiIQVxqdqa5XPrwC3u5Kr/mv4MWlR2Be1tmgNOcZ6h8ksZfK390BLuHmM8sweBptMhAyHghR/z2i1zEJGrJbQ6RPn2qIZ8aU3i9/RL0gOQnmDgfIKn4FS+sIKBj+4P7L8AdFA7rZ3WCPDecbqk84oFr26aO+nhsHntA33Ic0kg+NCwL3tXJqkY0Zca0ggIjdnFvfKzmExfIf1pZq/g1+UAF1OizT58cYFlS0ni9F060i7V6Zk9yzEhiVmO5wKr9FJLyBzavSp+r7RK/It1I5LI0IHs5ctVL7bhhmQfcsran4InGo7Utx2sACuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPk0QZp846FMbFRvutGdAAotCIbgUyKGCaVz0KM6VFE=;
 b=U2xVjVLzFzHnbIk0f8prheMXgnpNI/oWX6bjqfgUJROAqth7KlVz8njuUxpp876Nje5Y9d4LZ+C3LelAvIuIEbEXI4FCBAdvB0M6x2UpED3XoKNRbtGxbbT3X7o6Njd14JtponIrmKmpSbG7QAGalEoyqGUtJqbnKMnQwQ27W94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Wed, 3 Jan
 2024 14:19:47 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 14:19:47 +0000
Message-ID: <75975bd6-3885-4bdd-a584-671561df7f6d@amd.com>
Date: Wed, 3 Jan 2024 19:49:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Prefer kernel data types u8, u16, u32, u64
 in amdkfd/kfd_priv.h
Content-Language: en-GB
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231229110325.81696-1-srinivasan.shanmugam@amd.com>
 <247331b3-1216-4853-8c48-2a1c32b57e52@amd.com>
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <247331b3-1216-4853-8c48-2a1c32b57e52@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::34) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|BL1PR12MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 800fdc0f-3a98-4f02-eff1-08dc0c670a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vi8xqmCuOmkf3hAqlSOnSxbM2RdB+Qv0q+ZJvfEzFBEo5HJMC8AzsQh0BXUyMUAq7reUBje3/0fZUkgNYnwm4RF/ofkqwJ1s6qi4/Dbv4A13oo2OgeDgSVjEMT9IceQQ0MXeaUpCWnQcNnxiTuHEAwrtRi2bxqmiHegWDyxwrNzMcsMrFa/MraXbxpqzDRo3LOOExOIJZMI0EMis4QEqiCf2lgDOLyymfW89xS7XfrAouYzs71dVXgNeNBdve38YUeToleH1/XINyMl56+usE1fb6cu3JjaS/gCo+dpvX+UyQaB7eXCt/vMSirQlywqc3nrnKtF0e9jABgPw8Zj6vmKFRBEZuGwt/ULPmuAoul5WFojo34BFLaKU4bW+wFAC+7YAXYP73jVxaPsvWIEgQ9rzCcoGNHMuw4CeIVMrChR2brZWaAWgELBEvGkoOlPAsg5y8bUeHWBDSYd8KcaFVHFX0RGizMUYUX62odI7rnZCzja5gLLQNJMO9MtGUFjPB61sQcifWddvLtmpvgcqEuEpXRXfTFeekSCG6POMW+kWGFp94B0BQLVpGUI7zOTwkWcyzuetAukPEJs4VPCRmowoCV0ViCWwNRr7X9tcIEHSYQ7bwKK9uITiziC72/kkQQupePBLfQTIOtGgK/ZBgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(30864003)(4001150100001)(2906002)(4326008)(8676002)(8936002)(316002)(66574015)(6636002)(110136005)(66556008)(66946007)(66476007)(31686004)(2616005)(6512007)(26005)(83380400001)(41300700001)(38100700002)(36756003)(86362001)(31696002)(6506007)(6666004)(478600001)(6486002)(966005)(53546011)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhwRWM4NGREcURqRjlDZm1ITlNnb2psZ2FuWmI4aGdzdWZEeHgxTzU4SjFS?=
 =?utf-8?B?TjBlaGQ1U1ZVM2FXQjBCeFkrSWlPMGUrWEdRQWpiQThDZkRWanMrd05BT25F?=
 =?utf-8?B?a0g2QXJneERRejVkK1ZZK05ScWh1djIwRytpdjJNQ3NmV3cwaE5MTEFBQlVV?=
 =?utf-8?B?SEVZWGVBZnZUbnVZWW53MlhZZVYwdUNIbGQ4QXJXbndFVXlDeSs2QkpXVFU0?=
 =?utf-8?B?Qjh5ekN5VWg1KzcvLzRWdmovN0tPQzNtbEI0WE9ycFo0enpMTjVjNnRBUEZD?=
 =?utf-8?B?a0JIRGRpbDU5bVV0YXZPQmROZHdxS0QyTy94bW1EUmRWL1lSSmNVeTRvQmF3?=
 =?utf-8?B?ZGZYamErODR3QzI5WU9TbHl0QS94U0hZLzJTeVBHTVlFV1diWEpUUURyVnBh?=
 =?utf-8?B?T1ZpYTVaZkVYc0c3YTkvZUVyV25qS015UVpsZmtXT3NydnUrVXU1cFI0dWJn?=
 =?utf-8?B?ZlBKeHoyQytobUs2MkxMZ01ndjJSczdHTmpKKzBaWFpOWUw5aEpKN3VWaHl3?=
 =?utf-8?B?a0thaG9CR0lKTzVZdVBqZC9nNlN5aXdhdm9VZENrdUYwcmxPQWtyMWFESW85?=
 =?utf-8?B?cTIxSVg4UHE4RHVGMEJGOGJMdDdrcWNqV0dBL3I5aU9pUWVGRllhZDlNRHZx?=
 =?utf-8?B?UEgwR2JIbGZxRXB2Mnk2YTBteEh0M2JMV0lPWkptS1hFRFUxc0JhTGpxQWxZ?=
 =?utf-8?B?NW5VZzBXWUo5NFFqR2c4dnV1eVBTRzlBTWhCdFhGQkNNUDJqek1sM2c0QzFh?=
 =?utf-8?B?YzJHQjQ4S3RWYUs1d3VEdzVZcWxQM2RVTWN1WEU1RndSRjdOKzh1bEVQYUFF?=
 =?utf-8?B?RVZDa0s5WE9CK2RoblNqZ09leHVza0xYU0UvVDBmK0YzdWRtZjZabDNHampo?=
 =?utf-8?B?SGRWdFVsVkdBa0txVXZ4dlg2VUFBaDRuT202a3RTVHdYa2VCRWNpdUIvcysv?=
 =?utf-8?B?dkhSTWJzOTdXVTVDQnJ5VXVnQzkwa3pYdHJkM3JscHZuL1laQms5TWwwdkpD?=
 =?utf-8?B?bElaOFBkN0dFVGNVUHZNbUJEdTBJcEF0SlExY0RySzY2WmxmRUFOSEtEYTJK?=
 =?utf-8?B?Q3VIOGVEWVgzZ09pMWpPRzJ5ZEFVbHZ4S2dwQlhOOENTRXZTdDg0NlgzRm9r?=
 =?utf-8?B?Z1k4bWZxVGlkZWo4MEc2UjMyZ2w5MmtvMWFSb2xtYkVibUxDSk9mOCtrQWgw?=
 =?utf-8?B?bmNRRzIyQUx2UEZsZ004UlN5NzZQTzlFc3M3NGR4aTJiMDZjSVFMbVhsbXpn?=
 =?utf-8?B?a0hybXBKOTQ3d0krZjA5eHgxSktZWXhWZTFtUEFDbURXcXJ0OEJUU3kzeFoz?=
 =?utf-8?B?SXl4RVZranB0N3hHZnFrWmE3SGVIdWEvTHdCWWtSTnd0SDZ0cUl6c3pRQWtx?=
 =?utf-8?B?aytDeXMxaWFYaFlQS2pTUkk2SlNTMHdTL3R3V2hTOW1nUHd1dk43eWJaMys0?=
 =?utf-8?B?Y2NTdndLUnlXa1NpQ3BiWS9QcDZwZVlLVXk5RS9wbXZJWlE5SFkxM21VRHZS?=
 =?utf-8?B?Y0tXblpVaWdSTnE1VE5ldy9xVGpRVXVGRUhSUDl2MTA2TUNtRHN6aUYySXVy?=
 =?utf-8?B?ZUhxejRpcmFOcEN1dzBqamFmTU1UbDhqd1dFNW0yNnBNdzVJRDNKVk5CeWhp?=
 =?utf-8?B?YzV1ZjZKNy9ac2t2MnloK3JuTUx1K3pyb1lLMk1xbkhNUm1iVWZIRyt3YUVG?=
 =?utf-8?B?T1JZL21BbXRqY3d6SjZBbldxdG0vSkMwWkxDZEdvUEJOYjN0VU8wOUoybFc1?=
 =?utf-8?B?em5TNGhDZkhZOS9uYnBlbVloNnZyTVE0M3RnNWpkVVRXY21Fc2VFWDVHWC83?=
 =?utf-8?B?TFlZWmtURFpVaUFCU1lTUkRuWkFRUUR4c3NpQnMwOEJTckFlenlzZmlIZGJZ?=
 =?utf-8?B?YUJxWmY4YXZyaE5IcjRRa3VjUzB2MmtTdGdXZkRweUtMbFdwMEs5aW95a0tt?=
 =?utf-8?B?bWVOdk1FSVN1cmxmL1hLWG1TTUZsNjE0Ynh3RmdDdUV5ZW9yVm5HUGxoSlBZ?=
 =?utf-8?B?NE40ZTdaWXV1b1RaU3dyZ3N2cHltV2RHaUQ1TTZneTB6SzhnMUFYR0VmUWNj?=
 =?utf-8?B?VzZ1U21tV01aaVR3R0huOTFWWXV0TFN3aHVVeVM3L3QrcTFETWw5bGkveFFC?=
 =?utf-8?Q?i5jrgoZwtvsXIuvAWMXkNBjcJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800fdc0f-3a98-4f02-eff1-08dc0c670a47
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:19:47.7951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib64jPwYO5dGfAKpIV9N+bQEMe3crLz2NeE7oeK8CSwiNKRntcKKHALcHmOmdpZdAIBmI2ihKj7TIf/cIt42zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/2/2024 9:57 PM, Felix Kuehling wrote:
>
> On 2023-12-29 06:03, Srinivasan Shanmugam wrote:
>> Fix the following checks reported by checkpatch:
>>
>> CHECK: Prefer kernel type 'u8' over 'uint8_t'
>> CHECK: Prefer kernel type 'u16' over 'uint16_t'
>> CHECK: Prefer kernel type 'u64' over 'uint64_t'
>> CHECK: Prefer kernel type 'u32' over 'uint32_t'
>
> This is a lot of churn. Why do this now, and why specifically for KFD. 
> I see a lot of uint..._t in amdgpu as well. The kernel header files 
> define both data types. Why is one preferred over the other? If there 
> is agreement that u8/16/32/64 is preferred, should this change be 
> applied to amdgpu as well?

Hi Felix, Good Morning!

Thanks for your feedbacks!

1. This is was done mainly to eliminate the reports from 
'scripts/checkpatch.pl --strict', when "uint32_t" was asked to retain 
for consistency for the one of the comment below in the other patch - 
'[PATCH] drm/amdkfd: Fix type of 'dbg_flags' in 'struct kfd_process'

 >
 >       /* Tracks debug per-vmid request for debug flags */
 > -    bool dbg_flags;
 > +    u32 dbg_flags;

For consistency with the rest of this header file, I'd prefer we use
uint32_t here. Other than that, the patch is

2. Why is one preferred over the other?

Based on kernel's "Documentation/process/coding-style.rst"

5) Typedefs
-----------

     u8/u16/u32 are perfectly fine typedefs, although they fit into
     category (d) better than here.

     .. note::

       Again - there needs to be a **reason** for this. If something is
       ``unsigned long``, then there's no reason to do

        typedef unsigned long myflags_t;

     but if there is a clear reason for why it under certain circumstances
     might be an ``unsigned int`` and under other configurations might be
     ``unsigned long``, then by all means go ahead and use a typedef.

...

(d) New types which are identical to standard C99 types, in certain
     exceptional circumstances.

     Although it would only take a short amount of time for the eyes and
     brain to become accustomed to the standard types like ``uint32_t``,
     some people object to their use anyway.

     Therefore, the Linux-specific ``u8/u16/u32/u64`` types and their
     signed equivalents which are identical to standard types are
     permitted -- although they are not mandatory in new code of your
     own.

     When editing existing code which already uses one or the other set
     of types, you should conform to the existing choices in that code.

based on author of that document would prefer
uint8_t but will accept u8. It also seems like if code is consistent
about using a given type (as this code is) that it shouldn't be
changed.

But some other discussions in linux kernel open source
https://patchwork.kernel.org/project/linux-input/patch/20131231193442.GA25208@core.coreip.homeip.net/#:~:text=When%20editing%20existing%20code%20which%20already%20uses,to%20the%20existing%20choices%20in%20that%20code.

It's mentioned in this link:

I prefer uXX in kernel because it matches __uXX that we publish in UAPI.
Also here is Linus's response form the discussion that introduced that
particular wording in CodingStyle [1]:

"The problem with uint32_t is that it's ugly, it used to be unportable,
and you can't use it in header files _anyway_.

In other words, there's no _point_ to the "standard type".

I really object to this whole thing. The fact is, "u8" and friends _are_
the standard types as far as the kernel is concerned.  Claiming that
they aren't is just silly.

It's the "uint32_t" kind of thing that isn't standard within the kernel.
You can't use that thing in public header files anyway due to name
scoping rules, so they have basically no redeeming features."

>
> I also see a bunch of unrelated indentation changes in this patch.

This indentations fixes, also were to eliminate the reports from 
'scripts/checkpatch.pl --strict', on amdkfd/kfd_priv.h

I am happy & open to accept your suggestions though!

Thank you!

Regards,

Srini

>
> Regards,
>   Felix
>
>
>>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>> v3:
>>    - updated u32, u16, u64 for missed variables in v2
>>
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 448 +++++++++++++-------------
>>   1 file changed, 226 insertions(+), 222 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 45366b4ca976..c161b5220fd7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -74,7 +74,7 @@
>>   #define KFD_MMAP_GPU_ID_SHIFT 46
>>   #define KFD_MMAP_GPU_ID_MASK (((1ULL << KFD_GPU_ID_HASH_WIDTH) - 1) \
>>                   << KFD_MMAP_GPU_ID_SHIFT)
>> -#define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) << 
>> KFD_MMAP_GPU_ID_SHIFT)\
>> +#define KFD_MMAP_GPU_ID(gpu_id) ((((u64)gpu_id) << 
>> KFD_MMAP_GPU_ID_SHIFT)\
>>                   & KFD_MMAP_GPU_ID_MASK)
>>   #define KFD_MMAP_GET_GPU_ID(offset)    ((offset & 
>> KFD_MMAP_GPU_ID_MASK) \
>>                   >> KFD_MMAP_GPU_ID_SHIFT)
>> @@ -91,7 +91,7 @@
>>     /* Macro for allocating structures */
>>   #define kfd_alloc_struct(ptr_to_struct)    \
>> -    ((typeof(ptr_to_struct)) kzalloc(sizeof(*ptr_to_struct), 
>> GFP_KERNEL))
>> +    ((typeof(ptr_to_struct))kzalloc(sizeof(*ptr_to_struct), 
>> GFP_KERNEL))
>>     #define KFD_MAX_NUM_OF_PROCESSES 512
>>   #define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
>> @@ -145,13 +145,13 @@ enum kfd_ioctl_flags {
>>        */
>>       KFD_IOC_FLAG_CHECKPOINT_RESTORE = BIT(0),
>>   };
>> +
>>   /*
>>    * Kernel module parameter to specify maximum number of supported 
>> queues per
>>    * device
>>    */
>>   extern int max_num_of_queues_per_device;
>>   -
>>   /* Kernel module parameter to specify the scheduling policy */
>>   extern int sched_policy;
>>   @@ -212,24 +212,24 @@ struct kfd_node;
>>     struct kfd_event_interrupt_class {
>>       bool (*interrupt_isr)(struct kfd_node *dev,
>> -            const uint32_t *ih_ring_entry, uint32_t *patched_ihre,
>> +                  const u32 *ih_ring_entry, u32 *patched_ihre,
>>               bool *patched_flag);
>>       void (*interrupt_wq)(struct kfd_node *dev,
>> -            const uint32_t *ih_ring_entry);
>> +                 const u32 *ih_ring_entry);
>>   };
>>     struct kfd_device_info {
>> -    uint32_t gfx_target_version;
>> +    u32 gfx_target_version;
>>       const struct kfd_event_interrupt_class *event_interrupt_class;
>>       unsigned int max_pasid_bits;
>>       unsigned int max_no_of_hqd;
>>       unsigned int doorbell_size;
>>       size_t ih_ring_entry_size;
>> -    uint8_t num_of_watch_points;
>> -    uint16_t mqd_size_aligned;
>> +    u8 num_of_watch_points;
>> +    u16 mqd_size_aligned;
>>       bool supports_cwsr;
>>       bool needs_pci_atomics;
>> -    uint32_t no_atomic_fw_version;
>> +    u32 no_atomic_fw_version;
>>       unsigned int num_sdma_queues_per_engine;
>>       unsigned int num_reserved_sdma_queues_per_engine;
>>       DECLARE_BITMAP(reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
>> @@ -239,17 +239,17 @@ unsigned int kfd_get_num_sdma_engines(struct 
>> kfd_node *kdev);
>>   unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_node *kdev);
>>     struct kfd_mem_obj {
>> -    uint32_t range_start;
>> -    uint32_t range_end;
>> -    uint64_t gpu_addr;
>> -    uint32_t *cpu_ptr;
>> +    u32 range_start;
>> +    u32 range_end;
>> +    u64 gpu_addr;
>> +    u32 *cpu_ptr;
>>       void *gtt_mem;
>>   };
>>     struct kfd_vmid_info {
>> -    uint32_t first_vmid_kfd;
>> -    uint32_t last_vmid_kfd;
>> -    uint32_t vmid_num_kfd;
>> +    u32 first_vmid_kfd;
>> +    u32 last_vmid_kfd;
>> +    u32 vmid_num_kfd;
>>   };
>>     #define MAX_KFD_NODES    8
>> @@ -267,7 +267,7 @@ struct kfd_node {
>>                             */
>>       struct kfd_vmid_info vm_info;
>>       unsigned int id;                /* topology stub index */
>> -    uint32_t xcc_mask; /* Instance mask of XCCs present */
>> +    u32 xcc_mask; /* Instance mask of XCCs present */
>>       struct amdgpu_xcp *xcp;
>>         /* Interrupts */
>> @@ -281,7 +281,7 @@ struct kfd_node {
>>        * from the HW ring into a SW ring.
>>        */
>>       bool interrupts_active;
>> -    uint32_t interrupt_bitmap; /* Only used for GFX 9.4.3 */
>> +    u32 interrupt_bitmap; /* Only used for GFX 9.4.3 */
>>         /* QCM Device instance */
>>       struct device_queue_manager *dqm;
>> @@ -293,7 +293,7 @@ struct kfd_node {
>>       /* Clients watching SMI events */
>>       struct list_head smi_clients;
>>       spinlock_t smi_lock;
>> -    uint32_t reset_seq_num;
>> +    u32 reset_seq_num;
>>         /* SRAM ECC flag */
>>       atomic_t sram_ecc_flag;
>> @@ -326,7 +326,7 @@ struct kfd_dev {
>>       struct mutex doorbell_mutex;
>>         void *gtt_mem;
>> -    uint64_t gtt_start_gpu_addr;
>> +    u64 gtt_start_gpu_addr;
>>       void *gtt_start_cpu_ptr;
>>       void *gtt_sa_bitmap;
>>       struct mutex gtt_sa_lock;
>> @@ -336,9 +336,9 @@ struct kfd_dev {
>>       bool init_complete;
>>         /* Firmware versions */
>> -    uint16_t mec_fw_version;
>> -    uint16_t mec2_fw_version;
>> -    uint16_t sdma_fw_version;
>> +    u16 mec_fw_version;
>> +    u16 mec2_fw_version;
>> +    u16 sdma_fw_version;
>>         /* CWSR */
>>       bool cwsr_enabled;
>> @@ -346,7 +346,7 @@ struct kfd_dev {
>>       unsigned int cwsr_isa_size;
>>         /* xGMI */
>> -    uint64_t hive_id;
>> +    u64 hive_id;
>>         bool pci_atomic_requested;
>>   @@ -362,7 +362,7 @@ struct kfd_dev {
>>       unsigned int num_nodes;
>>         /* Track per device allocated watch points */
>> -    uint32_t alloc_watch_ids;
>> +    u32 alloc_watch_ids;
>>       spinlock_t watch_points_lock;
>>         /* Kernel doorbells for KFD device */
>> @@ -489,38 +489,38 @@ struct queue_properties {
>>       enum kfd_queue_type type;
>>       enum kfd_queue_format format;
>>       unsigned int queue_id;
>> -    uint64_t queue_address;
>> -    uint64_t  queue_size;
>> -    uint32_t priority;
>> -    uint32_t queue_percent;
>> -    uint32_t *read_ptr;
>> -    uint32_t *write_ptr;
>> +    u64 queue_address;
>> +    u64  queue_size;
>> +    u32 priority;
>> +    u32 queue_percent;
>> +    u32 *read_ptr;
>> +    u32 *write_ptr;
>>       void __iomem *doorbell_ptr;
>> -    uint32_t doorbell_off;
>> +    u32 doorbell_off;
>>       bool is_interop;
>>       bool is_evicted;
>>       bool is_suspended;
>>       bool is_being_destroyed;
>>       bool is_active;
>>       bool is_gws;
>> -    uint32_t pm4_target_xcc;
>> +    u32 pm4_target_xcc;
>>       bool is_dbg_wa;
>>       bool is_user_cu_masked;
>>       /* Not relevant for user mode queues in cp scheduling */
>>       unsigned int vmid;
>>       /* Relevant only for sdma queues*/
>> -    uint32_t sdma_engine_id;
>> -    uint32_t sdma_queue_id;
>> -    uint32_t sdma_vm_addr;
>> +    u32 sdma_engine_id;
>> +    u32 sdma_queue_id;
>> +    u32 sdma_vm_addr;
>>       /* Relevant only for VI */
>> -    uint64_t eop_ring_buffer_address;
>> -    uint32_t eop_ring_buffer_size;
>> -    uint64_t ctx_save_restore_area_address;
>> -    uint32_t ctx_save_restore_area_size;
>> -    uint32_t ctl_stack_size;
>> -    uint64_t tba_addr;
>> -    uint64_t tma_addr;
>> -    uint64_t exception_status;
>> +    u64 eop_ring_buffer_address;
>> +    u32 eop_ring_buffer_size;
>> +    u64 ctx_save_restore_area_address;
>> +    u32 ctx_save_restore_area_size;
>> +    u32 ctl_stack_size;
>> +    u64 tba_addr;
>> +    u64 tma_addr;
>> +    u64 exception_status;
>>   };
>>     #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&    \
>> @@ -537,8 +537,8 @@ enum mqd_update_flag {
>>   struct mqd_update_info {
>>       union {
>>           struct {
>> -            uint32_t count; /* Must be a multiple of 32 */
>> -            uint32_t *ptr;
>> +            u32 count; /* Must be a multiple of 32 */
>> +            u32 *ptr;
>>           } cu_mask;
>>       };
>>       enum mqd_update_flag update_flag;
>> @@ -581,12 +581,12 @@ struct queue {
>>       struct list_head list;
>>       void *mqd;
>>       struct kfd_mem_obj *mqd_mem_obj;
>> -    uint64_t gart_mqd_addr;
>> +    u64 gart_mqd_addr;
>>       struct queue_properties properties;
>>   -    uint32_t mec;
>> -    uint32_t pipe;
>> -    uint32_t queue;
>> +    u32 mec;
>> +    u32 pipe;
>> +    u32 queue;
>>         unsigned int sdma_id;
>>       unsigned int doorbell_id;
>> @@ -599,7 +599,7 @@ struct queue {
>>       struct kobject kobj;
>>         void *gang_ctx_bo;
>> -    uint64_t gang_ctx_gpu_addr;
>> +    u64 gang_ctx_gpu_addr;
>>       void *gang_ctx_cpu_ptr;
>>         struct amdgpu_bo *wptr_bo;
>> @@ -622,11 +622,11 @@ enum KFD_PIPE_PRIORITY {
>>   struct scheduling_resources {
>>       unsigned int vmid_mask;
>>       enum kfd_queue_type type;
>> -    uint64_t queue_mask;
>> -    uint64_t gws_mask;
>> -    uint32_t oac_mask;
>> -    uint32_t gds_heap_base;
>> -    uint32_t gds_heap_size;
>> +    u64 queue_mask;
>> +    u64 gws_mask;
>> +    u32 oac_mask;
>> +    u32 gds_heap_base;
>> +    u32 gds_heap_size;
>>   };
>>     struct process_queue_manager {
>> @@ -663,28 +663,28 @@ struct qcm_process_device {
>>       bool mapped_gws_queue;
>>         /* All the memory management data should be here too */
>> -    uint64_t gds_context_area;
>> +    u64 gds_context_area;
>>       /* Contains page table flags such as AMDGPU_PTE_VALID since 
>> gfx9 */
>> -    uint64_t page_table_base;
>> -    uint32_t sh_mem_config;
>> -    uint32_t sh_mem_bases;
>> -    uint32_t sh_mem_ape1_base;
>> -    uint32_t sh_mem_ape1_limit;
>> -    uint32_t gds_size;
>> -    uint32_t num_gws;
>> -    uint32_t num_oac;
>> -    uint32_t sh_hidden_private_base;
>> +    u64 page_table_base;
>> +    u32 sh_mem_config;
>> +    u32 sh_mem_bases;
>> +    u32 sh_mem_ape1_base;
>> +    u32 sh_mem_ape1_limit;
>> +    u32 gds_size;
>> +    u32 num_gws;
>> +    u32 num_oac;
>> +    u32 sh_hidden_private_base;
>>         /* CWSR memory */
>>       struct kgd_mem *cwsr_mem;
>>       void *cwsr_kaddr;
>> -    uint64_t cwsr_base;
>> -    uint64_t tba_addr;
>> -    uint64_t tma_addr;
>> +    u64 cwsr_base;
>> +    u64 tba_addr;
>> +    u64 tma_addr;
>>         /* IB memory */
>>       struct kgd_mem *ib_mem;
>> -    uint64_t ib_base;
>> +    u64 ib_base;
>>       void *ib_kaddr;
>>         /* doorbells for kfd process */
>> @@ -707,7 +707,7 @@ struct qcm_process_device {
>>    * idr_handle in the least significant 4 bytes
>>    */
>>   #define MAKE_HANDLE(gpu_id, idr_handle) \
>> -    (((uint64_t)(gpu_id) << 32) + idr_handle)
>> +    (((u64)(gpu_id) << 32) + idr_handle)
>>   #define GET_GPU_ID(handle) (handle >> 32)
>>   #define GET_IDR_HANDLE(handle) (handle & 0xFFFFFFFF)
>>   @@ -738,12 +738,12 @@ struct kfd_process_device {
>>       struct qcm_process_device qpd;
>>         /*Apertures*/
>> -    uint64_t lds_base;
>> -    uint64_t lds_limit;
>> -    uint64_t gpuvm_base;
>> -    uint64_t gpuvm_limit;
>> -    uint64_t scratch_base;
>> -    uint64_t scratch_limit;
>> +    u64 lds_base;
>> +    u64 lds_limit;
>> +    u64 gpuvm_base;
>> +    u64 gpuvm_limit;
>> +    u64 scratch_base;
>> +    u64 scratch_limit;
>>         /* VM context for GPUVM allocations */
>>       struct file *drm_file;
>> @@ -764,17 +764,17 @@ struct kfd_process_device {
>>       enum kfd_pdd_bound bound;
>>         /* VRAM usage */
>> -    uint64_t vram_usage;
>> +    u64 vram_usage;
>>       struct attribute attr_vram;
>>       char vram_filename[MAX_SYSFS_FILENAME_LEN];
>>         /* SDMA activity tracking */
>> -    uint64_t sdma_past_activity_counter;
>> +    u64 sdma_past_activity_counter;
>>       struct attribute attr_sdma;
>>       char sdma_filename[MAX_SYSFS_FILENAME_LEN];
>>         /* Eviction activity tracking */
>> -    uint64_t last_evict_timestamp;
>> +    u64 last_evict_timestamp;
>>       atomic64_t evict_duration_counter;
>>       struct attribute attr_evict;
>>   @@ -810,30 +810,30 @@ struct kfd_process_device {
>>       struct attribute attr_faults;
>>       struct attribute attr_page_in;
>>       struct attribute attr_page_out;
>> -    uint64_t faults;
>> -    uint64_t page_in;
>> -    uint64_t page_out;
>> +    u64 faults;
>> +    u64 page_in;
>> +    u64 page_out;
>>         /* Exception code status*/
>> -    uint64_t exception_status;
>> +    u64 exception_status;
>>       void *vm_fault_exc_data;
>>       size_t vm_fault_exc_data_size;
>>         /* Tracks debug per-vmid request settings */
>> -    uint32_t spi_dbg_override;
>> -    uint32_t spi_dbg_launch_mode;
>> -    uint32_t watch_points[4];
>> -    uint32_t alloc_watch_ids;
>> +    u32 spi_dbg_override;
>> +    u32 spi_dbg_launch_mode;
>> +    u32 watch_points[4];
>> +    u32 alloc_watch_ids;
>>         /*
>>        * If this process has been checkpointed before, then the user
>>        * application will use the original gpu_id on the
>>        * checkpointed node to refer to this device.
>>        */
>> -    uint32_t user_gpu_id;
>> +    u32 user_gpu_id;
>>         void *proc_ctx_bo;
>> -    uint64_t proc_ctx_gpu_addr;
>> +    u64 proc_ctx_gpu_addr;
>>       void *proc_ctx_cpu_ptr;
>>   };
>>   @@ -893,7 +893,7 @@ struct kfd_process {
>>        * one for each device the process is using.
>>        */
>>       struct kfd_process_device *pdds[MAX_GPU_INSTANCE];
>> -    uint32_t n_pdds;
>> +    u32 n_pdds;
>>         struct process_queue_manager pqm;
>>   @@ -954,8 +954,8 @@ struct kfd_process {
>>       bool has_cwsr;
>>         /* Exception code enable mask and status */
>> -    uint64_t exception_enable_mask;
>> -    uint64_t exception_status;
>> +    u64 exception_enable_mask;
>> +    u64 exception_status;
>>         /* Used to drain stale interrupts */
>>       wait_queue_head_t wait_irq_drain;
>> @@ -1005,6 +1005,7 @@ struct amdkfd_ioctl_desc {
>>       unsigned int cmd_drv;
>>       const char *name;
>>   };
>> +
>>   bool kfd_dev_is_large_bar(struct kfd_node *dev);
>>     int kfd_process_create_wq(void);
>> @@ -1015,37 +1016,38 @@ struct kfd_process *kfd_get_process(const 
>> struct task_struct *task);
>>   struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
>>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct 
>> *mm);
>>   -int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t 
>> gpu_id);
>> +int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, u32 gpu_id);
>>   int kfd_process_gpuid_from_node(struct kfd_process *p, struct 
>> kfd_node *node,
>> -                uint32_t *gpuid, uint32_t *gpuidx);
>> +                u32 *gpuid, u32 *gpuidx);
>>   static inline int kfd_process_gpuid_from_gpuidx(struct kfd_process *p,
>> -                uint32_t gpuidx, uint32_t *gpuid) {
>> +                        u32 gpuidx, u32 *gpuid) {
>>       return gpuidx < p->n_pdds ? p->pdds[gpuidx]->dev->id : -EINVAL;
>>   }
>> +
>>   static inline struct kfd_process_device 
>> *kfd_process_device_from_gpuidx(
>> -                struct kfd_process *p, uint32_t gpuidx) {
>> +                struct kfd_process *p, u32 gpuidx) {
>>       return gpuidx < p->n_pdds ? p->pdds[gpuidx] : NULL;
>>   }
>>     void kfd_unref_process(struct kfd_process *p);
>> -int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>> +int kfd_process_evict_queues(struct kfd_process *p, u32 trigger);
>>   int kfd_process_restore_queues(struct kfd_process *p);
>>   void kfd_suspend_all_processes(void);
>>   int kfd_resume_all_processes(void);
>>     struct kfd_process_device *kfd_process_device_data_by_id(struct 
>> kfd_process *process,
>> -                             uint32_t gpu_id);
>> +                             u32 gpu_id);
>>   -int kfd_process_get_user_gpu_id(struct kfd_process *p, uint32_t 
>> actual_gpu_id);
>> +int kfd_process_get_user_gpu_id(struct kfd_process *p, u32 
>> actual_gpu_id);
>>     int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>>                      struct file *drm_file);
>>   struct kfd_process_device *kfd_bind_process_to_device(struct 
>> kfd_node *dev,
>> -                        struct kfd_process *p);
>> +                              struct kfd_process *p);
>>   struct kfd_process_device *kfd_get_process_device_data(struct 
>> kfd_node *dev,
>> -                            struct kfd_process *p);
>> +                               struct kfd_process *p);
>>   struct kfd_process_device *kfd_create_process_device_data(struct 
>> kfd_node *dev,
>> -                            struct kfd_process *p);
>> +                              struct kfd_process *p);
>>     bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
>>   @@ -1054,11 +1056,11 @@ int kfd_reserved_mem_mmap(struct kfd_node 
>> *dev, struct kfd_process *process,
>>     /* KFD process API for creating and translating handles */
>>   int kfd_process_device_create_obj_handle(struct kfd_process_device 
>> *pdd,
>> -                    void *mem);
>> +                     void *mem);
>>   void *kfd_process_device_translate_handle(struct kfd_process_device 
>> *p,
>> -                    int handle);
>> +                      int handle);
>>   void kfd_process_device_remove_obj_handle(struct kfd_process_device 
>> *pdd,
>> -                    int handle);
>> +                      int handle);
>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>     /* PASIDs */
>> @@ -1076,13 +1078,13 @@ void kfd_doorbell_fini(struct kfd_dev *kfd);
>>   int kfd_doorbell_mmap(struct kfd_node *dev, struct kfd_process 
>> *process,
>>                 struct vm_area_struct *vma);
>>   void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>> -                    unsigned int *doorbell_off);
>> +                      unsigned int *doorbell_off);
>>   void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem 
>> *db_addr);
>>   u32 read_kernel_doorbell(u32 __iomem *db);
>>   void write_kernel_doorbell(void __iomem *db, u32 value);
>>   void write_kernel_doorbell64(void __iomem *db, u64 value);
>>   unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
>> -                    struct kfd_process_device *pdd,
>> +                           struct kfd_process_device *pdd,
>>                       unsigned int doorbell_id);
>>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
>>   int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
>> @@ -1110,22 +1112,23 @@ void kfd_topology_shutdown(void);
>>   int kfd_topology_add_device(struct kfd_node *gpu);
>>   int kfd_topology_remove_device(struct kfd_node *gpu);
>>   struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
>> -                        uint32_t proximity_domain);
>> +                        u32 proximity_domain);
>>   struct kfd_topology_device 
>> *kfd_topology_device_by_proximity_domain_no_lock(
>> -                        uint32_t proximity_domain);
>> -struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
>> -struct kfd_node *kfd_device_by_id(uint32_t gpu_id);
>> +                        u32 proximity_domain);
>> +struct kfd_topology_device *kfd_topology_device_by_id(u32 gpu_id);
>> +struct kfd_node *kfd_device_by_id(u32 gpu_id);
>>   struct kfd_node *kfd_device_by_pci_dev(const struct pci_dev *pdev);
>> -static inline bool kfd_irq_is_from_node(struct kfd_node *node, 
>> uint32_t node_id,
>> -                    uint32_t vmid)
>> +static inline bool kfd_irq_is_from_node(struct kfd_node *node, u32 
>> node_id,
>> +                    u32 vmid)
>>   {
>>       return (node->interrupt_bitmap & (1 << node_id)) != 0 &&
>>              (node->compute_vmid_bitmap & (1 << vmid)) != 0;
>>   }
>> +
>>   static inline struct kfd_node *kfd_node_by_irq_ids(struct 
>> amdgpu_device *adev,
>> -                    uint32_t node_id, uint32_t vmid) {
>> +                           u32 node_id, u32 vmid) {
>>       struct kfd_dev *dev = adev->kfd.dev;
>> -    uint32_t i;
>> +    u32 i;
>>         if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3))
>>           return dev->nodes[0];
>> @@ -1136,7 +1139,8 @@ static inline struct kfd_node 
>> *kfd_node_by_irq_ids(struct amdgpu_device *adev,
>>         return NULL;
>>   }
>> -int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
>> +
>> +int kfd_topology_enum_kfd_devices(u8 idx, struct kfd_node **kdev);
>>   int kfd_numa_node_to_apic_id(int numa_node_id);
>>     /* Interrupts */
>> @@ -1149,8 +1153,8 @@ int kfd_interrupt_init(struct kfd_node *dev);
>>   void kfd_interrupt_exit(struct kfd_node *dev);
>>   bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void 
>> *ih_ring_entry);
>>   bool interrupt_is_wanted(struct kfd_node *dev,
>> -                const uint32_t *ih_ring_entry,
>> -                uint32_t *patched_ihre, bool *flag);
>> +             const u32 *ih_ring_entry,
>> +                u32 *patched_ihre, bool *flag);
>>   int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
>>   void kfd_process_close_interrupt_drain(unsigned int pasid);
>>   @@ -1158,8 +1162,8 @@ void 
>> kfd_process_close_interrupt_drain(unsigned int pasid);
>>   int kfd_init_apertures(struct kfd_process *process);
>>     void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>> -                  uint64_t tba_addr,
>> -                  uint64_t tma_addr);
>> +                  u64 tba_addr,
>> +                  u64 tma_addr);
>>   void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>>                        bool enabled);
>>   @@ -1181,19 +1185,19 @@ int kfd_process_init_cwsr_apu(struct 
>> kfd_process *process, struct file *filep);
>>   #define KFD_CRIU_PRIV_VERSION 1
>>     struct kfd_criu_process_priv_data {
>> -    uint32_t version;
>> -    uint32_t xnack_mode;
>> +    u32 version;
>> +    u32 xnack_mode;
>>   };
>>     struct kfd_criu_device_priv_data {
>>       /* For future use */
>> -    uint64_t reserved;
>> +    u64 reserved;
>>   };
>>     struct kfd_criu_bo_priv_data {
>> -    uint64_t user_addr;
>> -    uint32_t idr_handle;
>> -    uint32_t mapped_gpuids[MAX_GPU_INSTANCE];
>> +    u64 user_addr;
>> +    u32 idr_handle;
>> +    u32 mapped_gpuids[MAX_GPU_INSTANCE];
>>   };
>>     /*
>> @@ -1207,44 +1211,44 @@ enum kfd_criu_object_type {
>>   };
>>     struct kfd_criu_svm_range_priv_data {
>> -    uint32_t object_type;
>> -    uint64_t start_addr;
>> -    uint64_t size;
>> +    u32 object_type;
>> +    u64 start_addr;
>> +    u64 size;
>>       /* Variable length array of attributes */
>>       struct kfd_ioctl_svm_attribute attrs[];
>>   };
>>     struct kfd_criu_queue_priv_data {
>> -    uint32_t object_type;
>> -    uint64_t q_address;
>> -    uint64_t q_size;
>> -    uint64_t read_ptr_addr;
>> -    uint64_t write_ptr_addr;
>> -    uint64_t doorbell_off;
>> -    uint64_t eop_ring_buffer_address;
>> -    uint64_t ctx_save_restore_area_address;
>> -    uint32_t gpu_id;
>> -    uint32_t type;
>> -    uint32_t format;
>> -    uint32_t q_id;
>> -    uint32_t priority;
>> -    uint32_t q_percent;
>> -    uint32_t doorbell_id;
>> -    uint32_t gws;
>> -    uint32_t sdma_id;
>> -    uint32_t eop_ring_buffer_size;
>> -    uint32_t ctx_save_restore_area_size;
>> -    uint32_t ctl_stack_size;
>> -    uint32_t mqd_size;
>> +    u32 object_type;
>> +    u64 q_address;
>> +    u64 q_size;
>> +    u64 read_ptr_addr;
>> +    u64 write_ptr_addr;
>> +    u64 doorbell_off;
>> +    u64 eop_ring_buffer_address;
>> +    u64 ctx_save_restore_area_address;
>> +    u32 gpu_id;
>> +    u32 type;
>> +    u32 format;
>> +    u32 q_id;
>> +    u32 priority;
>> +    u32 q_percent;
>> +    u32 doorbell_id;
>> +    u32 gws;
>> +    u32 sdma_id;
>> +    u32 eop_ring_buffer_size;
>> +    u32 ctx_save_restore_area_size;
>> +    u32 ctl_stack_size;
>> +    u32 mqd_size;
>>   };
>>     struct kfd_criu_event_priv_data {
>> -    uint32_t object_type;
>> -    uint64_t user_handle;
>> -    uint32_t event_id;
>> -    uint32_t auto_reset;
>> -    uint32_t type;
>> -    uint32_t signaled;
>> +    u32 object_type;
>> +    u64 user_handle;
>> +    u32 event_id;
>> +    u32 auto_reset;
>> +    u32 type;
>> +    u32 signaled;
>>         union {
>>           struct kfd_hsa_memory_exception_data memory_exception_data;
>> @@ -1253,27 +1257,27 @@ struct kfd_criu_event_priv_data {
>>   };
>>     int kfd_process_get_queue_info(struct kfd_process *p,
>> -                   uint32_t *num_queues,
>> -                   uint64_t *priv_data_sizes);
>> +                   u32 *num_queues,
>> +                   u64 *priv_data_sizes);
>>     int kfd_criu_checkpoint_queues(struct kfd_process *p,
>> -             uint8_t __user *user_priv_data,
>> -             uint64_t *priv_data_offset);
>> +                   u8 __user *user_priv_data,
>> +             u64 *priv_data_offset);
>>     int kfd_criu_restore_queue(struct kfd_process *p,
>> -               uint8_t __user *user_priv_data,
>> -               uint64_t *priv_data_offset,
>> -               uint64_t max_priv_data_size);
>> +               u8 __user *user_priv_data,
>> +               u64 *priv_data_offset,
>> +               u64 max_priv_data_size);
>>     int kfd_criu_checkpoint_events(struct kfd_process *p,
>> -             uint8_t __user *user_priv_data,
>> -             uint64_t *priv_data_offset);
>> +                   u8 __user *user_priv_data,
>> +             u64 *priv_data_offset);
>>     int kfd_criu_restore_event(struct file *devkfd,
>>                  struct kfd_process *p,
>> -               uint8_t __user *user_priv_data,
>> -               uint64_t *priv_data_offset,
>> -               uint64_t max_priv_data_size);
>> +               u8 __user *user_priv_data,
>> +               u64 *priv_data_offset,
>> +               u64 max_priv_data_size);
>>   /* CRIU - End */
>>     /* Queue Context Management */
>> @@ -1283,19 +1287,19 @@ void print_queue_properties(struct 
>> queue_properties *q);
>>   void print_queue(struct queue *q);
>>     struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>> -        struct kfd_node *dev);
>> +                     struct kfd_node *dev);
>>   struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
>> -        struct kfd_node *dev);
>> +                    struct kfd_node *dev);
>>   struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>> -        struct kfd_node *dev);
>> +                    struct kfd_node *dev);
>>   struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
>> -        struct kfd_node *dev);
>> +                     struct kfd_node *dev);
>>   struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
>> -        struct kfd_node *dev);
>> +                     struct kfd_node *dev);
>>   struct device_queue_manager *device_queue_manager_init(struct 
>> kfd_node *dev);
>>   void device_queue_manager_uninit(struct device_queue_manager *dqm);
>>   struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>> -                    enum kfd_queue_type type);
>> +                       enum kfd_queue_type type);
>>   void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
>>   int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
>>   @@ -1311,7 +1315,7 @@ void 
>> kfd_process_dequeue_from_all_devices(struct kfd_process *p);
>>   int pqm_init(struct process_queue_manager *pqm, struct kfd_process 
>> *p);
>>   void pqm_uninit(struct process_queue_manager *pqm);
>>   int pqm_create_queue(struct process_queue_manager *pqm,
>> -                struct kfd_node *dev,
>> +             struct kfd_node *dev,
>>                   struct file *f,
>>                   struct queue_properties *properties,
>>                   unsigned int *qid,
>> @@ -1319,31 +1323,31 @@ int pqm_create_queue(struct 
>> process_queue_manager *pqm,
>>                   const struct kfd_criu_queue_priv_data *q_data,
>>                   const void *restore_mqd,
>>                   const void *restore_ctl_stack,
>> -                uint32_t *p_doorbell_offset_in_process);
>> +                u32 *p_doorbell_offset_in_process);
>>   int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned 
>> int qid);
>>   int pqm_update_queue_properties(struct process_queue_manager *pqm, 
>> unsigned int qid,
>> -            struct queue_properties *p);
>> +                struct queue_properties *p);
>>   int pqm_update_mqd(struct process_queue_manager *pqm, unsigned int 
>> qid,
>> -            struct mqd_update_info *minfo);
>> +           struct mqd_update_info *minfo);
>>   int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>> -            void *gws);
>> +        void *gws);
>>   struct kernel_queue *pqm_get_kernel_queue(struct 
>> process_queue_manager *pqm,
>> -                        unsigned int qid);
>> +                      unsigned int qid);
>>   struct queue *pqm_get_user_queue(struct process_queue_manager *pqm,
>> -                        unsigned int qid);
>> +                 unsigned int qid);
>>   int pqm_get_wave_state(struct process_queue_manager *pqm,
>>                  unsigned int qid,
>>                  void __user *ctl_stack,
>>                  u32 *ctl_stack_used_size,
>>                  u32 *save_area_used_size);
>>   int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
>> -               uint64_t exception_clear_mask,
>> +               u64 exception_clear_mask,
>>                  void __user *buf,
>>                  int *num_qss_entries,
>> -               uint32_t *entry_size);
>> +               u32 *entry_size);
>>     int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
>> -                  uint64_t fence_value,
>> +                  u64 fence_value,
>>                     unsigned int timeout_ms);
>>     int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
>> @@ -1369,22 +1373,22 @@ struct packet_manager {
>>     struct packet_manager_funcs {
>>       /* Support ASIC-specific packet formats for PM4 packets */
>> -    int (*map_process)(struct packet_manager *pm, uint32_t *buffer,
>> -            struct qcm_process_device *qpd);
>> -    int (*runlist)(struct packet_manager *pm, uint32_t *buffer,
>> -            uint64_t ib, size_t ib_size_in_dwords, bool chain);
>> -    int (*set_resources)(struct packet_manager *pm, uint32_t *buffer,
>> -            struct scheduling_resources *res);
>> -    int (*map_queues)(struct packet_manager *pm, uint32_t *buffer,
>> -            struct queue *q, bool is_static);
>> -    int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
>> -            enum kfd_unmap_queues_filter mode,
>> -            uint32_t filter_param, bool reset);
>> -    int (*set_grace_period)(struct packet_manager *pm, uint32_t 
>> *buffer,
>> -            uint32_t grace_period);
>> -    int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>> -            uint64_t fence_address,    uint64_t fence_value);
>> -    int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
>> +    int (*map_process)(struct packet_manager *pm, u32 *buffer,
>> +               struct qcm_process_device *qpd);
>> +    int (*runlist)(struct packet_manager *pm, u32 *buffer,
>> +               u64 ib, size_t ib_size_in_dwords, bool chain);
>> +    int (*set_resources)(struct packet_manager *pm, u32 *buffer,
>> +                 struct scheduling_resources *res);
>> +    int (*map_queues)(struct packet_manager *pm, u32 *buffer,
>> +              struct queue *q, bool is_static);
>> +    int (*unmap_queues)(struct packet_manager *pm, u32 *buffer,
>> +                enum kfd_unmap_queues_filter mode,
>> +            u32 filter_param, bool reset);
>> +    int (*set_grace_period)(struct packet_manager *pm, u32 *buffer,
>> +                u32 grace_period);
>> +    int (*query_status)(struct packet_manager *pm, u32 *buffer,
>> +                u64 fence_address,    u64 fence_value);
>> +    int (*release_mem)(u64 gpu_addr, u32 *buffer);
>>         /* Packet sizes */
>>       int map_process_size;
>> @@ -1404,23 +1408,23 @@ extern const struct packet_manager_funcs 
>> kfd_aldebaran_pm_funcs;
>>   int pm_init(struct packet_manager *pm, struct device_queue_manager 
>> *dqm);
>>   void pm_uninit(struct packet_manager *pm, bool hanging);
>>   int pm_send_set_resources(struct packet_manager *pm,
>> -                struct scheduling_resources *res);
>> +              struct scheduling_resources *res);
>>   int pm_send_runlist(struct packet_manager *pm, struct list_head 
>> *dqm_queues);
>> -int pm_send_query_status(struct packet_manager *pm, uint64_t 
>> fence_address,
>> -                uint64_t fence_value);
>> +int pm_send_query_status(struct packet_manager *pm, u64 fence_address,
>> +             u64 fence_value);
>>     int pm_send_unmap_queue(struct packet_manager *pm,
>>               enum kfd_unmap_queues_filter mode,
>> -            uint32_t filter_param, bool reset);
>> +            u32 filter_param, bool reset);
>>     void pm_release_ib(struct packet_manager *pm);
>>   -int pm_update_grace_period(struct packet_manager *pm, uint32_t 
>> grace_period);
>> +int pm_update_grace_period(struct packet_manager *pm, u32 
>> grace_period);
>>     /* Following PM funcs can be shared among VI and AI */
>>   unsigned int pm_build_pm4_header(unsigned int opcode, size_t 
>> packet_size);
>>   -uint64_t kfd_get_number_elems(struct kfd_dev *kfd);
>> +u64 kfd_get_number_elems(struct kfd_dev *kfd);
>>     /* Events */
>>   extern const struct kfd_event_interrupt_class 
>> event_interrupt_class_cik;
>> @@ -1435,26 +1439,26 @@ int kfd_event_init_process(struct kfd_process 
>> *p);
>>   void kfd_event_free_process(struct kfd_process *p);
>>   int kfd_event_mmap(struct kfd_process *process, struct 
>> vm_area_struct *vma);
>>   int kfd_wait_on_events(struct kfd_process *p,
>> -               uint32_t num_events, void __user *data,
>> -               bool all, uint32_t *user_timeout_ms,
>> -               uint32_t *wait_result);
>> -void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>> -                uint32_t valid_id_bits);
>> +               u32 num_events, void __user *data,
>> +               bool all, u32 *user_timeout_ms,
>> +               u32 *wait_result);
>> +void kfd_signal_event_interrupt(u32 pasid, u32 partial_id,
>> +                u32 valid_id_bits);
>>   void kfd_signal_hw_exception_event(u32 pasid);
>> -int kfd_set_event(struct kfd_process *p, uint32_t event_id);
>> -int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
>> -int kfd_kmap_event_page(struct kfd_process *p, uint64_t 
>> event_page_offset);
>> +int kfd_set_event(struct kfd_process *p, u32 event_id);
>> +int kfd_reset_event(struct kfd_process *p, u32 event_id);
>> +int kfd_kmap_event_page(struct kfd_process *p, u64 event_page_offset);
>>     int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>> -             uint32_t event_type, bool auto_reset, uint32_t node_id,
>> -             uint32_t *event_id, uint32_t *event_trigger_data,
>> -             uint64_t *event_page_offset, uint32_t *event_slot_index);
>> +             u32 event_type, bool auto_reset, u32 node_id,
>> +             u32 *event_id, u32 *event_trigger_data,
>> +             u64 *event_page_offset, u32 *event_slot_index);
>>     int kfd_get_num_events(struct kfd_process *p);
>> -int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>> +int kfd_event_destroy(struct kfd_process *p, u32 event_id);
>>     void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
>> -                struct kfd_vm_fault_info *info,
>> +                   struct kfd_vm_fault_info *info,
>>                   struct kfd_hsa_memory_exception_data *data);
>>     void kfd_signal_reset_event(struct kfd_node *dev);
>> @@ -1478,8 +1482,8 @@ static inline bool 
>> kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>   }
>>     int kfd_send_exception_to_runtime(struct kfd_process *p,
>> -                unsigned int queue_id,
>> -                uint64_t error_reason);
>> +                  unsigned int queue_id,
>> +                u64 error_reason);
>>   bool kfd_is_locked(void);
>>     /* Compute profile */
