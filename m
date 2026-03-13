Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E382B105F79C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 12:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8239D10EBC3;
	Fri, 13 Mar 2026 12:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T7MPsBgl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D79310EBC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 12:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvB4YhJHMdHcs/xW9Mys/VZWedQt+b12my6t+gLP1d4jZECnDc1RVZEBoAjqNdhTerpcFCwghcDGxN24WiuPV+9jviqgzKV45vtJ3Ul0jVBMAaTnDWrsjwfeaPyqjWhn5JsGVVzFNBRYjAaDouV8LBnVPqEtdRz2bOrpTQBrjA/mj3OPgjf6NJcGK/xgeObIFtIo9JQ0PCTpOMcH9Nb9g2rNTq0uYvFWO8oveDUKbBd/yYx2bXPrkz7gvV6h9egpWCgwkTQ+zIRlVv1GPonDCubebKe9zj8Ncs+K910P2v1UIYGMcoGvXVagwL0vkZSjAy1aLUs8GqQAk5lV2Hy0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP6x8hcAn9aYMb7puNeQVV9tF5tA7uQe3yZblKm/GQQ=;
 b=qHt7X/F3yyIhyRP7Re019bmXZ459gQtI2gVjBaBS1ylNknLhOfcjc3R39UXRXBx/T65HLVCXTxUl8bN4Kh7u/Qfw8zkfZL1yVaVmzaaOb2iKX5yxnUR0nNZbIeWsCK2ZDShHK5meN5DodAvAROblrq8qE8OSsEC1s++mvuyC5Gpp39vITw52pYIiDqI1YJ4AstfSvd2fvBl/5Lgu7JYWZusKDFW5ZCKN7RujLdKN3pN/PadK2NzAm9bB4D5CAHbhvb/M5FY+Jep5Za94mKDPRuixyjAVL8FR3WqKk2mlsBW+Hcnw+XtSWjXi68Q2yDbMFmpOyxEvASwwbJ5F8DIVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP6x8hcAn9aYMb7puNeQVV9tF5tA7uQe3yZblKm/GQQ=;
 b=T7MPsBglwyFonnpnUh7z3GN7BRkCFx4J8EALWVsVQas9SJRONO5SLgmw4ESXfzvmqrCNid5wuGB6b+0bOcp+CsmYpV01QeFwq+MC4MPZ0I7MX+lrDrQ5yeo/21JeKAUIhJiNImaM1dcsYUWpnvm7GLExU52SA4FI7QvfnKgyR1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 12:05:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 12:05:44 +0000
Message-ID: <f5053ac5-868b-4b3c-82e1-62db57b0c588@amd.com>
Date: Fri, 13 Mar 2026 13:05:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: Only look up for gem objects
 when count is non zero
To: Tvrtko Ursulin <tursulin@ursulin.net>, "Khatri, Sunil"
 <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260310135531.3954691-1-sunil.khatri@amd.com>
 <3d80b2b5-4d1d-4435-8418-f59e2b905ed7@ursulin.net>
 <563d4978-6e84-4059-80bf-5b5d6d5699e5@amd.com>
 <3e393a12-be1f-4fa9-9024-35661cabb29a@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3e393a12-be1f-4fa9-9024-35661cabb29a@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6acdb0-7178-45ba-fc5d-08de80f8dad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: slScnDgzqJSxHhl4UGqkFInIVd06LkEf8nqXqtp9XHJw0v969+ElxAsQ7srdWijWt6Yfhcl3PY7pmtmICMcqb/VdyYaoFDiJyW2QGEL8pM8zJaPPVcjtrA4sXVSJd2ALki/mSmIdMmqKBYXE/YfCQIVFXeI6zfw6hT1xaaZpUH9EmlgUQNyZZmlgolBkuVvN2gML81nvKLdIdvQAlAdnEVazbMfhk24XTyjdTAmCHO1Pdd+laWvjAAonJKeGkHhXNW8sDSrpu+Ibixnoq5x2Lg96YE/Q+7QvpzjAUUZBjuLxuMIeuoYkYFq+eNSKJ9QJQdrF0znF2vJX6MaSF+JbR+CZK6erH76ZakhiX5nc/TCU/MYu+gnMpCh1XYB3F9Kvt/c6zshytQZJ/0ho0J1C0uXFupmstxyjVzMBOF5ikAloHs86SS96pBxx5mCVssUltJ6rxV0l2dZXEjwC0RAXuGpTX6p/r7ftxHFXXvOiT+4W0uvsNMRHV6X+Y9QP4YBv85XyC9DoAE54pMvD+/bi22wjiFyct58IiWNC+QHE9WqQJcvt2495QDArxHs6bvkoaFPW1pxDX/D4rvzgqwTNklsJLxMzvwSZ0juchRIPAlF/zfuQb0bvRRE5qjgq8FrBZceLmO3tygtzI4qETP2IXcueS2Ck6ZQsTB2j4ulef3h9ug9uCoywiTUaXOS2yzOhmatvd/YgFBBMOdqAUEjFLzyFYRjwg84lSpgiG0b4RNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzAxUHF5aGhJaFEvTGNtWS80YXlza2NhZEJWRUxkNjR0MVdXejlCekpIVVNl?=
 =?utf-8?B?bmhKUzhZSmliTzRTaDBWdFJkVzZIcTgveDBCSVBLdDRuaFlhOGs5SmVLbG5p?=
 =?utf-8?B?ZWQ1Q05SN0JycE4ycVVpOHBJOWZvY0N4M0ZtQmxFanRhU01DTWxHUmVSeGNN?=
 =?utf-8?B?MmY1MzFFTmM3L21Rek14MXhJVWhyU1hYZ2tOa0pQMVRMaFVrcmF1c2NUU0Ez?=
 =?utf-8?B?U0d3MjVsNmFZQnkva0V6NlpSelVoUXZESG9ES093QkVCdi9pSjZoZlFNcm4z?=
 =?utf-8?B?UEdTS0h0ZStORjVLcGtNTG0wMTBlcGRZeWFWN1pYR2tsVE0rekt2dUtPNXFt?=
 =?utf-8?B?MFVuMWlPYTN1b3JKZWhaTWpmaDRuUmpOYlYrVGZTTEViMXBXQm5xSXZRUlRy?=
 =?utf-8?B?YXgrSlBicXNyeFh2aU15UStpR0NmbXhnOWpnWWFPdmpDcW5GZEZicmoyeVZw?=
 =?utf-8?B?dHJuMmw3TlVPQ2ExOXBKc3ZFNVpYWVBJcFRLY0w0OXBEWXI0dUpNY2pKbHNS?=
 =?utf-8?B?Q0dtK2xNMjFjMmxzV3k2UkEydXVmQ0htblVOdkovbXhNVkhBQTB1MDlqZEtn?=
 =?utf-8?B?UFRCbG82N0JVVGhRay9NVEJ6ZGk3MURSVjQxcDNvblJnNk1Xcmk1VUxIc05W?=
 =?utf-8?B?WGc3Ny8zaFdrZTVwY3J5OU5sOExVbkZiSXFhcHYwRk0ycGJaWkZma3RQQUR3?=
 =?utf-8?B?Q1RzZk1pSHFJaHlkVXZOQ2xXN1g1dytFdU9oZW94RDBhVFcwWENUaWFrdWpB?=
 =?utf-8?B?T05ZNkJWU2ZOTFBuVmdqeXE3eDFXb1FZaXlYN1c3eVkwUHUyLzVESWgrbDUv?=
 =?utf-8?B?alZYbStHLzZQT0EzcDVXYk9WdGxmQmQ0aHd4V1NCRjJZaElJWnNYVUQ4NkJ0?=
 =?utf-8?B?b0VRMmNkYUFTVXljS2xlOTZvSndkOU90WjhFT0RXZzloWGwvQTZkTGVHTHlD?=
 =?utf-8?B?OHFaaWhyWXVObUJqT2huQ09ZdW1qOC9JU3NXQXF2T3hOY3pzVU13ajVqalhk?=
 =?utf-8?B?NTdadXNtRkxkVEw5cVZjYy9GSGJydUdWNCtVbzNValB6VEVFcnpTOEJhbU56?=
 =?utf-8?B?UHdIMmVuYVJiRUphaitSVnJPOTR4OTNHVG84aTgraG9OejByL04vdXFyWC8z?=
 =?utf-8?B?WEMzZzJUOGVYa0Vray9OQTNwTTZGKzFuSDAxb2xwYUk4eWR1WWZBNVVwNVBu?=
 =?utf-8?B?bHZtUFE4SkdTcndCTVB0ZHdoNWlUdDVIZ2M0RlcrTXQ1UXhnZmpUdk9oYS9F?=
 =?utf-8?B?Wk9LYVVybHkxQ05mMVZvYWNXdEZnaUFCOHI1MDJURTJKaTlBOERTdk0yL2Zp?=
 =?utf-8?B?b2FiOGtOc1ZUWTJZTEV2Rk91WVFNK1hQV0lOSjZQR3k5eTVTUFVxajFib0g5?=
 =?utf-8?B?TFhoekJ1eDA4WVllYk9kbUNWaG9KZEtoN213Z3FlRFVYR2swS3JZMkMrdDdQ?=
 =?utf-8?B?b0NkQzRZbk9FVy9lRENjZFdyMTgzZXloTE5PREZqTVpIQXBIbnpMT04veTJN?=
 =?utf-8?B?Yk1KVFJDNjArQ1oyQzNVejFhQ2l5NWRVa284b2FqQTZGeGxXaVN5Vkx0Y0VQ?=
 =?utf-8?B?OFNqa3YzbDhCc2NZZm9LMGgrbjF3bloyYVl6dGxucDB2RmZ6SDhhUUlaSUZS?=
 =?utf-8?B?U2Vhdk83STEwS2x1YTkrV1ZDVnpHNU1LeG4vU2dPSVZYWkMvSmRVV0pESWh0?=
 =?utf-8?B?REhqem0yOW1uMW9mZTl6NWVEejB5dlNqejVmNFNQblBvdThTT0Y5WVVISHdx?=
 =?utf-8?B?Vnh1bmFsbHMrTEtoOU9LOU5CQVJ5WTZrdjdCUkNXZ0RSbEFqLzZVdk9nVTV4?=
 =?utf-8?B?UllBU1ZYRyt4VHc3R2h6amNJcTh4VGR4WjhNYzcxcXU1OGNKTGcvWllrMUtC?=
 =?utf-8?B?SUxMWkZaR1htNDNqUEhwVElVR0xUQ3hvdUJMb3BxVTd1UFRuZTduWFpudUo0?=
 =?utf-8?B?NlR0OVpIbk5ZdzBWVEFtbEhRWXNoM0VHS3VnN0ZrOWl0RkhEb3M4V0NwaFJn?=
 =?utf-8?B?UDJOZjZxc253K0RxSkpYcjZ1U2xyT09abm9kT1JLSW9WekxkaXJwSlk0cTMz?=
 =?utf-8?B?OVdldjhrT3hYamxISlBHbll4RmNpV3ptUWdFQzhqT3BjN084ZG1wYU05L1dl?=
 =?utf-8?B?TzdQOHNLK0dZZ0JHZ0dyUTRFdFJzNVBhYytrOEFUK2htalJFWlN3bmN5T1l3?=
 =?utf-8?B?aC9qK0xXQkdsZmgrbUNMZ2JCV1BHN1AzWS9aVkZiTjBQTEFMWnh1UTkrMTc1?=
 =?utf-8?B?cmE3WXBvWlhsSk9RNkxQVHc0RHpWak1YOE5GU28xQnVxamd3bFdFbmljazFs?=
 =?utf-8?Q?s7TQFPvdfF0ALkyPQu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6acdb0-7178-45ba-fc5d-08de80f8dad2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:05:44.6024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koxTMlQ7jggJAzsNbMLb7N3EMIrS/EHncln2YKjUAy8yhBZ/iuinivCt7mOmyiZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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



On 3/13/26 09:53, Tvrtko Ursulin wrote:
> 
> On 13/03/2026 08:45, Khatri, Sunil wrote:
>>
>> On 13-03-2026 02:09 pm, Tvrtko Ursulin wrote:
>>>
>>> On 10/03/2026 13:55, Sunil Khatri wrote:
>>>> In function amdgpu_userq_wait_ioctl, call function drm_gem_objects_lookup
>>>> only if the count is valid i.e non zero.
>>>>
>>>> In case of object count is 0 set the pointer to NULL for proper clean
>>>> up.
>>>
>>> Hasn't this been discussed already with the conclusion that nothing is broken? Or I am missing something?
>>> Regards,
>>>
>>> Tvrtko
>> Issue was seen again since Alex pulled 6.19 fixes from DRM and the drm_gem_objects_lookup again got reverted to old and we started to see the issue. With that in mind Alex too suggested that nothing wrong if we explicitly check in driver too. Also i thought its only when handles are Zero case when the problem is actually seen and why not that have a check targeting that and not to invoke the function drm_gem_objects_lookup itself for that specific case.
> 
> Yes nothing wrong with checking, thanks for clarifying. I was just worried I again missed something in the code.

I'm clearly against adding those checks. It adds additional complexity because of an issue somewhere else.

So we should probably just cherry pick the correct fix over into amd-staging-drm-next instead.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++++++-------
>>>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 76f32fd768fb..a4fff90b190a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -665,19 +665,27 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>>           goto free_timeline_handles;
>>>>       }
>>>>   -    r = drm_gem_objects_lookup(filp,
>>>> - u64_to_user_ptr(wait_info->bo_read_handles),
>>>> -                   num_read_bo_handles,
>>>> -                   &gobj_read);
>>>> -    if (r)
>>>> -        goto free_timeline_points;
>>>> +    if (num_read_bo_handles) {
>>>> +        r = drm_gem_objects_lookup(filp,
>>>> + u64_to_user_ptr(wait_info->bo_read_handles),
>>>> +                       num_read_bo_handles,
>>>> +                       &gobj_read);
>>>> +        if (r)
>>>> +            goto free_timeline_points;
>>>> +    } else {
>>>> +        gobj_read = NULL;
>>>> +    }
>>>>   -    r = drm_gem_objects_lookup(filp,
>>>> - u64_to_user_ptr(wait_info->bo_write_handles),
>>>> -                   num_write_bo_handles,
>>>> -                   &gobj_write);
>>>> -    if (r)
>>>> -        goto put_gobj_read;
>>>> +    if (num_write_bo_handles) {
>>>> +        r = drm_gem_objects_lookup(filp,
>>>> + u64_to_user_ptr(wait_info->bo_write_handles),
>>>> +                       num_write_bo_handles,
>>>> +                       &gobj_write);
>>>> +        if (r)
>>>> +            goto put_gobj_read;
>>>> +    } else {
>>>> +        gobj_write = NULL;
>>>> +    }
>>>>         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>>>                 (num_read_bo_handles + num_write_bo_handles));
>>>
> 

