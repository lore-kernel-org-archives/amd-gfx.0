Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304DAC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD68B112C2E;
	Tue, 16 Apr 2024 12:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vRZH9akg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1BD112C2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 12:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1OPPUqtNSyupa+DK66RhycGOIs36FklyJBKgSIODn8VTeSE7uPXYX+aSh7mnr9Hnf1Ov3+7SVz3ccYuBwv88dlS0jDzW6dptvAoTdFkccWlGaBCSIUYlnllwg5FOPsOCkmC6Qf2aEvs3KUFmkmydoauUNYH9vj6y99BpYrrdzCaLzYLW8+eBoVr0bZ9z/3tvKX1v5Q2CEBD4o1c71no/Wbp1gG9a6HUyHdDLZVMc3FWOIfcJXWsB7bx/Bk3CM+BKp7+zz+heh9s1NfrJWYxuSw7OXCTS9bAbpVB3SFBI3LvMgRZ7aFFKpLRSw9xwgut9lKQ4MFroi3apbKhw9nAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19LJ5WxQsSg8KqI/cnU5rfgVy0S6mYuPyZpUzt8vz5k=;
 b=UksU5PBsAL4r+7Rl52A9spsSbn3vV4lHnlI4HkIhKnZENjP3nX6aeOwncRbfYOgbGIA3xC/CQm1D9v3QzqYRN1mXRnss4fqTKxkeZTVk/B8JWllR/Z3wQgc7Ht9/jFmXnMDeNXz4OC7Jr7jhTt8FGf+y/RXvAk6eUBQkqniH1U3VEp6tJVguESKqV1gWHwD6RjqMoIj2l6HqwOagPevAqDVftFAG2Q9z2eeglCpfLP+Nc1Et+SeI9e/j8BLMBLpfmE378Dr6eddwiEyh7FqVdsQnGjvoMjISkNxYBIxw0UKN5qNcqM8By1EL8VjsIHajzW6+vTcAS2jIQGJwFB/m3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19LJ5WxQsSg8KqI/cnU5rfgVy0S6mYuPyZpUzt8vz5k=;
 b=vRZH9akgoiTkYDINNxEh0ho64QOMBGgbjl2y54YjEh12TZCkbk6c29dRFeVM1nz0fg+1woUb/FUhbzYxeUfUvLCpSaysKwFsxwdd9TwLCZQwBHU+kNUn4nEhiqSbqQGSVyA2z+o+z52e3uv248fHB1HRY4azzqLj6DeCygpGQPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 16 Apr 2024 12:34:34 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:34:34 +0000
Message-ID: <616481ae-9a79-4800-ab98-d45c7fbc3731@amd.com>
Date: Tue, 16 Apr 2024 18:04:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear seq64 memory on free
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
 <662576a5-4597-4a3e-bead-4b80852eb19c@gmail.com>
 <5383bac8-c097-4975-8022-181d1d2f0877@amd.com>
 <7e532341-cf37-42c9-97e3-41d10e7871e5@amd.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <7e532341-cf37-42c9-97e3-41d10e7871e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 09736236-df62-4f40-913d-08dc5e119288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kttf3dKQMW/h2PddPKt+anqg2Uq+yT5M1hTWAFfiuRc7b87vL8ZV5U3bjDF++BlkcdhAkl5pTa3ZktHCYZVhbsbFh9fCVO1u63L7S2ikVxzwDXOkEhK+l0LvrcMrDjHn8O4gbbpwscVxt7fBqf3wp+1tv0eIrOZNPRw9YrPNhLtEXmOd5aBsvCj492cwQGr+JnxbOjO4OTQwLhEaMjuPA0gUUW+83hwYMUOEYfzlqZaDaS+Em40i76cNSeOIOhZQRpBttSvrvq+5RRMCRPpyevCEX3ltWKx5WPe/pSSxLD8NLLcfxjptP2YiWGRTR54bju+RyGU+6t5OybgiSpUcJT9JDjfwdXvX/b7Vx2ht9EeISj7z8JaPWkT2ewChcQwBKu2+yFHAAQN9kcGz2U3rtH4cDdVxtLTHlnX+Kk9K6J1mp1TZ8cbffk5y0B9BVlzkoH0WLNH59/kJ1LZjoUjwzTS0m3gob1LVk/efYp3eQy13R9T4STAni/56Z/Zlu1QDeA/6MMfksR29PSQHH4x/jiA1XdSDHddycrVuFoeRZKKVdNmhWtJkygYmlXdnwDi5ReZuCX8TnzxTWg2yurU1C+QlL8R5QJ/gVpF16l1Er9qAx47yt6VvZliT38DuzATr0RFWFx1phIH/fq1koiiW9u1Lb5zFQ1dR7pY8G3lxfe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFGOVpBWUxXUXNRa1ZVYmtENHRmSWdkQmsxSGRUNnJUNkFBSkZGajVndlBz?=
 =?utf-8?B?NVc1K2tTK0RubE5VR0gzTS9Xb2NtY3VtREJHWFNEK3hkelRjL1JFQjRZYXVY?=
 =?utf-8?B?RllJLzhjTjlTNlZ5RmIreG1wNjVDaWhiSFViQ0FWdXpqaC9TMGx3MGQrdkdU?=
 =?utf-8?B?R080a2xaOGU1d04xWk5tU2xmVENRQmc2ZlVzcmhxNHdYSldkZUxkcEd6VkxV?=
 =?utf-8?B?STlraThMOGNFK3RSV1N6Z0kwWjlVbENSUTZVWTl2MW9ReHlFUmFQUWtlOFRu?=
 =?utf-8?B?MmNkS2pzQ2J1VU9CNHhOU2g4NWRhSW1wMjFocnJpeGNScUJ3bzJ6SWR1b2tK?=
 =?utf-8?B?b1ZMNS9GUFIwRzJteXJPb1YxZnZxMjFqeXNEMG1kT2l3VW5vNXQxblhxSXgy?=
 =?utf-8?B?UzhsdjUyakRkZmc3ZkRzSXNPb24vQlVrZUxWdnM2VThUYWx1b3dVMVRwZ2xI?=
 =?utf-8?B?ZERVZ1ZOMkoyZ0lCdG1kT3BjTlNPNHVTWnp0TFpGcGVZSXdpclVpWmUvRXVH?=
 =?utf-8?B?Q3orOXNFK3R1V25Bc21Ec1dwSkVMampVQkxtZ1BnTHAvZXpJUG5nRTlEVDdQ?=
 =?utf-8?B?ckJkUlhMWUIxM21EOHpQSVFHTk5jbWVkZWQ0blppdVBYSW9TdWFPS0pjSDUr?=
 =?utf-8?B?bHVEakpHcjNjVUVYT0E5QmRwQ3RrTmd6RFZld083UVBVNnQ5ZGhSUlY5alZR?=
 =?utf-8?B?aHA0aUM0eHg4VGQvN3k1VVdxYWRBRE9iLzlVZVBtVXZMSU1TL0VPejNrcGxS?=
 =?utf-8?B?blpXSXdvREJuMmpBSXUyYjhid2w4SHA4NzZ3S2kzOHR4SU1LSGFhT2hEeFJB?=
 =?utf-8?B?V2lkYjlOVGVJNWFlK3pjcGIvQm5FOTBpZi9RMXh4UFlSZ1ZtZXhVdUtrSG5s?=
 =?utf-8?B?ejhIQ1VtME5BdHZqTjhSOXl0YStmMFJ2ZE9sV3JTS0VhdG9CcDBQTGNiKy9E?=
 =?utf-8?B?UDRFUkVpalVLMFZYa29oRzlzMDdEWTF4STFKeXVQMm9UR2lrdGl3V2Z6MlVN?=
 =?utf-8?B?US84WDc2Z1JQWTF0SzUvWWp1SWpPNGp5SDlaTm4wQW4vamZkVTlLb0ZtZThx?=
 =?utf-8?B?TEl4Vm5FL2V6N2Jvb2duaW5XRVpwOUlGZ1FCeDNJMGFyTWl0Qk0wZ1NxMllO?=
 =?utf-8?B?V0hjVnE3Mi9qUzQyWFJyYm9tL3JRZkE4MDQvUFFYc0ptMDlkZit3dXg2V2tY?=
 =?utf-8?B?MFJzeUVlaTlRRFRUWWNXd2lyK1g4ejd4TEdlcDNtQTN6M2ppbDNLelpjUldV?=
 =?utf-8?B?dk84dlc0bHVpcllqQmxZMFAzeENDYWVYVkZxbXVPTVp2cjJBbm9sbC9kbm9t?=
 =?utf-8?B?a1I1b2IvVGdLbXp5STR5M25CMmxzcHFIUmZqcHR3OEM5VG9hWHVTTnhicHk5?=
 =?utf-8?B?N3lZd0NSYkRycWI1cVFZc0xpVDV0WXZyS1plWEtTdjJ4bklDOHlteEVDUWVL?=
 =?utf-8?B?bk91ZjRYQjcvRlhaTE5YTktCSkpVS3NlcDZCMC9xK0VWWERkLzI4bnk1eWwz?=
 =?utf-8?B?TlZGVmlpdEJwbGJEWHFNaGZyVnZ6c1FDdzJTSEJFeWhEWEQwZThMYi9La3U3?=
 =?utf-8?B?Sms2MXpYdWN6V2ZPb204Wnh0cm01K1NOVlhnUGEvNWdJTEprS1hxcyt0WXNs?=
 =?utf-8?B?MXVDdGViYXJZVk1QWFlENkZ1K3MzU1NMN2hTS3pEYkVpbFl5VVZkckdheThR?=
 =?utf-8?B?dktLNGdLbVpLYzEybUlIbDd0bGIwc1BXUGpURlVodldNVGJLMkJLWUZRdGVy?=
 =?utf-8?B?SEFEWVBxVVJEUjYzdFVBRHZyNnAyOGZDV2xSTG8xUHk1eE1OSlRNcURRejNp?=
 =?utf-8?B?VFh3MEVXTDZWSThJY1BzQTVsbzNqTmpGTWdWNHNPWWpBTHJVZTM5bVlkU0Js?=
 =?utf-8?B?VDlmd2s0K1ZtZnNMVmVkdDhRaUtsOC9ucERaQW1HVFRiNkhjcVNPZlRicWQx?=
 =?utf-8?B?M3FFTS9aaFdya2Y5cFE5MDVrZG1pdEY4dlRmb1RHR2JwZGh5MG9CcytxYnFJ?=
 =?utf-8?B?Y0RTV096MTZsR0hHbi9jWGtQQWlneWQ5NG9vSzdFZTdUaWlpZFZkZTFwMVdL?=
 =?utf-8?B?VVdIQ1oyb0I0bGVxajRRamlRVFVUczZTc2ptNUR4L1hIQjlFd1Vyc2xJc29J?=
 =?utf-8?Q?zFGo/4SqhqSTZPOEVUAmBXuIe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09736236-df62-4f40-913d-08dc5e119288
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:34:34.6848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcZraquAIMG9CibmfEYkTyktl1LpdUv/0mVqaL+L7mdn0gUOx2NF7Rt2EB/5zCPp7z3GddLLBQK7FSOs7riudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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

Hi Christian,

On 4/16/2024 5:47 PM, Christian König wrote:
> Am 16.04.24 um 14:16 schrieb Paneer Selvam, Arunpravin:
>> Hi Christian,
>>
>> On 4/16/2024 2:35 PM, Christian König wrote:
>>> Am 15.04.24 um 20:48 schrieb Arunpravin Paneer Selvam:
>>>> We should clear the memory on free. Otherwise,
>>>> there is a chance that we will access the previous
>>>> application data and this would leads to an abnormal
>>>> behaviour in the current application.
>>>
>>> Mhm, I would strongly expect that we initialize the seq number after 
>>> allocation.
>>>
>>> It could be that we also have situations were the correct start 
>>> value is 0xffffffff or something like that instead.
>>>
>>> Why does this matter?
>> when the user queue A's u64 address (fence address) is allocated to 
>> the newly created user queue B, we see a problem.
>> User queue B calls the signal IOCTL which creates a new fence having 
>> the wptr as the seq number, in
>> amdgpu_userq_fence_create function we have a check where we are 
>> comparing the rptr and wptr value (rptr >= wptr).
>> since the rptr value is read from the u64 address which has the user 
>> queue A's wptr data, this rptr >= wptr condition
>> gets satisfied and we are dropping the reference before the actual 
>> command gets processed in the hardware.
>> If we clear this u64 value on free, we dont see this problem.
>
> Yeah, but that doesn't belongs into the seq64 handling.
>
> Instead the code which allocates the seq64 during userqueue created 
> needs to clear it to 0.
sure, got it.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>
>> Thanks,
>> Arun.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>> index 4b9afc4df031..9613992c9804 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>> @@ -189,10 +189,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device 
>>>> *adev, u64 *va, u64 **cpu_addr)
>>>>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>>>>   {
>>>>       unsigned long bit_pos;
>>>> +    u64 *cpu_addr;
>>>>         bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
>>>> -    if (bit_pos < adev->seq64.num_sem)
>>>> +    if (bit_pos < adev->seq64.num_sem) {
>>>> +        cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>>>> +        memset(cpu_addr, 0, sizeof(u64));
>>>>           __clear_bit(bit_pos, adev->seq64.used);
>>>> +    }
>>>>   }
>>>>     /**
>>>
>>
>

