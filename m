Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD2BC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 07:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911A0112AC8;
	Tue, 16 Apr 2024 07:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvwN4lza";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CD6112ACC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 07:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHKgkdgUy2lVaxQEumpUn0fR4RLbb6/OyVTyTvU+DS8bD5kzzDIbKVn7LMZLiM+gBTlyeCLDupG9xUsn/08C8knOfPUw+m7T2BfzhYD4R3YL3m6ipIffX2Hx/H76LWDP1KMbjM5cu3m+GNp15M6sytZl7yTJ6MGBcu4uvy28uhi1uUl3nxzCpy4EKfqbuVJWFNxkR54T99LSi0Uw1ggA+wXRdIl45nPQZWEV7rCyd4DYyN2GqTofmHExC8Zanl7BDIYWQtGq4oYfP2bypS/XW5iJw58alfmvfdQpmfcKOIXSHQj8KOxorph9CldXl0OLIhTVGyLjwHi1jwUrYq3WZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xULEHkSMvPmPySxzMnglIDvB7BkukY885RDsRvRB+po=;
 b=ln6kfhsWIWlJqIzlWZUtujF9pxnddQtTATU/u0nxn61EjA9yJD+Zw5zfiOmUFPpBKvS9jp4uWdFQQkqHjC6V4RleaxwMpZVBl6qyqJWEj4hBePAa41Y8DftcdSy6XsXS1njQ2qG6US8Ee96PkqSav2WX59WGaYg3Q3UOd67FxezSyh6TYK3kjxLjJLD8SYXvAt5KPGerV6bWXWqck1lfMORCj1oQNYmEV0AT/LS7TaVw4ilu6z0Hui4HlS8LNTSI2Pidco4uSXtFIjxKeggQrUIo0E/YPKW4egGCJUJxFRslBt+wkSl897vM4mCbRcdjjOVOwmTjk0y1tSAVsmd1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xULEHkSMvPmPySxzMnglIDvB7BkukY885RDsRvRB+po=;
 b=vvwN4lzagAk4XcIOM9mOUeoEXRhcBk3Pkbn7U3bWWtLLkkim3g8VK91e25qBPEt1LVEkt7BcSHjoMNNP7Zddr31d0Y9DA1M7KpVeUyr8ATwoIIr7N+mN0X895H4HECiWzZC8p2qVTHpEUJrVVZ6turYiiQqlhpfyFD6quMv+FFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 07:56:26 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 07:56:26 +0000
Message-ID: <bc804d82-7bc5-4d0f-95b6-226bba55ed79@amd.com>
Date: Tue, 16 Apr 2024 13:26:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
 <01b794f2-1f9f-e8ac-1c0f-1acd199e09ea@amd.com>
 <4e0dd9e0-1b07-47df-804a-a869d08ca171@amd.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <4e0dd9e0-1b07-47df-804a-a869d08ca171@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffd5886-4fc0-40c6-77c9-08dc5deab788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u30wy6Sgce62J5m1JwFBq2k3M2yfsCO/NdmrsPGTcQKLInelGiiG32FOVhx/FilKwhA4CTh4qUekbgtFP+vHoawpN8aobHcBPalo3iSO5lMI/wS7Eop8xeiNSMAbwN1hkg4zdGQRjqQYrimLQWahlJBEatxV9WFtCu5hC7sjIAKen0E8xi4G8oKl8sGlVQlOeWnznyzziNOZcm0QfyyYS4Cj5oPy+hiaapSQIjv/BA/ly0FXIBjFjhYR9gqjwm6PRLhPsxe8bzjMISSAWNNHZ90otCnJPiHcnuEF1x5uPWXufhT93/IFwaEv61aTLx1mZWl9ixIhn/NZT3sJgY+TyalSh0pudvC0NBbi1hZpIsUJmqWnCqykHgoXyFe3NmR86hqk3lOlzR3MK+FLjmufs8d/fbRWjwUxj+2l7EledQjiYw1iGFlx3PJeQrR4IBviLecu3fpfr+f6muKNaRfxMm+OjGyOmVVLGs8yxVmzLSXKuVfjAdNtRvAq3i3dufHqtFQmkkkoHlEcGT8BjsmCqkBWeG+Z1oOuS2VGecZB9BbJ4ufpVeq3DhnkKLW9RCejMzUZ/LiibtWgZwym/3U4af+ZbLC+1nBoSw5l2I2G0OOZrqZNG44bMlyD6SIzpseB+83yER0oE6xbpDgiD4ceei+olmya942e4WZm44DqT9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlQaXM3VTlXRzhmWTZuS1gwT1B2ZnVsMVdRZ3poUzc4VVVhYkR3YVZXTU1L?=
 =?utf-8?B?ZDVvTmxvZTltek9hcm5tbFdrUVNWMXlYV0pyQXFGc3kxZXZyajZNOHh4OWVP?=
 =?utf-8?B?anEvSmduc2hyY0d1YzMxTVA5dnd5R1VMN0J1U1Y2SFkxSzcvbXBFMVVvMDNp?=
 =?utf-8?B?ejYrYlZMWXBLRDNFYU1tazJkYmlQb3lubE1RT1U3bFdmOU1Fbm1TT2dqSWNB?=
 =?utf-8?B?TkpzWWxFSnNqTzVSUFpTWFBpRVh0STY4OXc2dEhmaU5qSWR3aHJKN2hmR2J4?=
 =?utf-8?B?Z2hrUzY1aE5lQ3FyOStsV2hsUEVyRklmYU52enNXYTJRbDJpbEpqMDlhUENY?=
 =?utf-8?B?eUk3elJrSGw5d2JJUW5IVGVKWHduYWFaOSs5Qjdta05wNGZnNlhKQ1NFMzFG?=
 =?utf-8?B?NUptTnc3RGhTRXFsWTdTVG45djYxdnoyOCtwL3RDL2s4cStsQisyNk1uMkYy?=
 =?utf-8?B?NGRYNUExZEpwUkNMTWVqdlJKZlliMVU2dCtHMkpRTkgzNzd1bnpkbTYzdnhX?=
 =?utf-8?B?VEtTM3dmeExDNlhSaHlsVlYwTmdGdTZFeE8zQzM3MytRSWwzajFhdmFSZlVM?=
 =?utf-8?B?SEZhRlI3bmxPVEtNMmdSNTRTeCttWlBoZktTMmR6aDh1MFZnOUE4c2lDdXZK?=
 =?utf-8?B?Si9yNEg1Nmo5WHY5WGk4OXRwaXBoQWVJaTlIQnZTSG9rblA3NUVJbGZRa1JZ?=
 =?utf-8?B?dXFHa0dRaFdxL3RkL1lTOW1RSWJqRlNBQXJnSWJwTzkvYkQzWGRyV3NpU2pJ?=
 =?utf-8?B?empmblFCYmlZQVAzYzkzVmhJMi9uODhRditJK2QwMTFCZkhYeXdWakQzblNZ?=
 =?utf-8?B?cE9xZE85bjdVTysvRC8yaXpqVCtTMkRuckRSekJyemprQmxtMXpVRHI0WWZk?=
 =?utf-8?B?ck1UeDRzb3RnalUxcHhJUXNDcGhJUjE2eUNYbXJuWi9OMmZncy9FQ3NLQ1NI?=
 =?utf-8?B?UGVDM3RFMEgweXJEY0lPWEpOeG5EOWsyTmF0QUFCa3NtMXZvT1E5UmF6amJp?=
 =?utf-8?B?b1k1bTNGOW5jZkYyZ2VBY1krKy8xRjRBbjRrUndWQkxiZ1JkeEJXN2F2SmFo?=
 =?utf-8?B?a1lUbktFTnp1aDd1cWcwb3lwUTFpd0x3QXBnVDBORUUxdXJDcUJSVDZ6cWZE?=
 =?utf-8?B?SzBoU05vNXQzWXd2RVluRGVGT2lrK2NXcmZSRzVaOUN6ZGhzWEUyaW9EMnFp?=
 =?utf-8?B?Z3JSSEFjbUlpTGNDSS9kYUJRSjZWMk8rNmhLVDNhTDIxcVFIM1IxY29vNU5k?=
 =?utf-8?B?Q3U4b0ZNUkQxWm5lcTJpSkpPOVFhM0dzTGVTbWlnUGdNTytvQzN1ZDJsY2dh?=
 =?utf-8?B?aUhyeFZqNVQyWE16YVlOQ3VjQlRWRUhRZ2JEMzRMcThnM21Zdk5ieFlKRXdG?=
 =?utf-8?B?U05iUGpFc0k4bUx4bE9hN1hod3BsTDhna3k2emp5c25UdWNDTGJzcHpWUktR?=
 =?utf-8?B?U3owRjM1WlV0QVJIRVBKa0tHd3MwZ0Z1OGx1ZlYvRVM3RStCUGVtbHVocmVD?=
 =?utf-8?B?YU1Pd0ExUENlWjFHKzl4NGl3eDlCbmpReTF1cEpMYjBiZUQzSUhJWXBCVVlm?=
 =?utf-8?B?Y0V1K0c3L1BreW5sYmpHcGFnVkk3Zk9sT1JQRml6VXBmZFoxWTJDdUpLS3gz?=
 =?utf-8?B?ZnVoa3J0a1N4RmlKbXoxVDM2VU12U2ZSTHlpd0l3ZVFNdHZ5TTBxZFl6TmxB?=
 =?utf-8?B?ZWN5SEpoeDlIRFh1cjZnOXBRQ3grWVk3VU5BMVo5MVpHMXZSYmgvei9yNWpH?=
 =?utf-8?B?NVg3dXNFOHZBaks3RFJDWjcvRTZCS3BKNk5rS1FHWllVOVR2TzN1YUkvWWU5?=
 =?utf-8?B?Z0tPb1RkNXBZNEdjdzFFQWN2UGRydlR5VU9LWmdZcTg3TFFqU3RzQmpQL3d3?=
 =?utf-8?B?NUNCOGMrUnhxd2Zidy9JVzZxaTk3d3N5Tll6RkkxNHZUdm5IcnRmTDZqQXY3?=
 =?utf-8?B?UngrQ3Z1TGpDbUpGaUYrQXlxTUlPWUJKanhDYXFvelB6OGVsSWFBUlE3cVpG?=
 =?utf-8?B?T2I3aHliV1g2ZE1ZT3dUOFhyOUNhTE0yN3JDelh2em95YnFLTFB0WjZLWDZD?=
 =?utf-8?B?cjF6NlVMYkpzaTFUaWJQUUtFNlB4azJCNEgxMG5FaWpQS2FFTEF6WEhqemsv?=
 =?utf-8?Q?as1mGn+rJZgObAPtbY3B3Js8R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffd5886-4fc0-40c6-77c9-08dc5deab788
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:56:26.5816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFd9YLHt2B4InDcGagXbGwpNvHq/RUEWZq9QOIwW3RH+ckLZMtA3HHL1/iT6GjxjwwJZGRY2TyZM/Lh5YrhV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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

On 4/16/2024 1:16 PM, Christian König wrote:
> Am 16.04.24 um 00:02 schrieb Philip Yang:
>> On 2024-04-14 10:57, Arunpravin Paneer Selvam wrote:
>>> Now we have two flags for contiguous VRAM buffer allocation.
>>> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
>>> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
>>> buffer's placement function.
>>>
>>> This patch will change the default behaviour of the two flags.
>> This change will simplify the KFD best effort contiguous VRAM 
>> allocation, because KFD doesn't need set new GEM_ flag.
>>> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
>>> - This means contiguous is not mandatory.
>>
>> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS used in couple of places. For page 
>> table BO, it is fine as BO size is page size 4K. For 64KB reserved 
>> BOs and F/W size related BOs, do all allocation happen at driver 
>> initialization before the VRAM is fragmented?
>>
>
> Oh, that's a really good point, we need to keep the behavior as is for 
> kernel allocations. Arun can you take care of that?
Sure, I will take care kernel allocations.
Thanks,
Arun.
>
> Thanks,
> Christian.
>
>>> - we will try to allocate the contiguous buffer. Say if the
>>>    allocation fails, we fallback to allocate the individual pages.
>>>
>>> When we setTTM_PL_FLAG_CONTIGUOUS
>>> - This means contiguous allocation is mandatory.
>>> - we are setting this in amdgpu_bo_pin_restricted() before bo 
>>> validation
>>>    and check this flag in the vram manager file.
>>> - if this is set, we should allocate the buffer pages contiguously.
>>>    the allocation fails, we return -ENOSPC.
>>>
>>> Signed-off-by: Arunpravin Paneer 
>>> Selvam<Arunpravin.PaneerSelvam@amd.com>
>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 14 +++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 
>>> +++++++++++++++-----
>>>   2 files changed, 49 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 8bc79924d171..41926d631563 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -153,8 +153,6 @@ void amdgpu_bo_placement_from_domain(struct 
>>> amdgpu_bo *abo, u32 domain)
>>>           else
>>>               places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>>   -        if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>> -            places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>           c++;
>>>       }
>>>   @@ -899,6 +897,8 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>>> *bo, u32 domain,
>>>   {
>>>       struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>       struct ttm_operation_ctx ctx = { false, false };
>>> +    struct ttm_place *places = bo->placements;
>>> +    u32 c = 0;
>>>       int r, i;
>>>         if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>>> @@ -921,16 +921,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>>> *bo, u32 domain,
>>>         if (bo->tbo.pin_count) {
>>>           uint32_t mem_type = bo->tbo.resource->mem_type;
>>> -        uint32_t mem_flags = bo->tbo.resource->placement;
>>>             if (!(domain & amdgpu_mem_type_to_domain(mem_type)))
>>>               return -EINVAL;
>>>   -        if ((mem_type == TTM_PL_VRAM) &&
>>> -            (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) &&
>>> -            !(mem_flags & TTM_PL_FLAG_CONTIGUOUS))
>>> -            return -EINVAL;
>>> -
>> This looks like a bug before, but with this patch, the check makes 
>> sense and is needed.
>>>           ttm_bo_pin(&bo->tbo);
>>>             if (max_offset != 0) {
>>> @@ -968,6 +962,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>>> *bo, u32 domain,
>>>               bo->placements[i].lpfn = lpfn;
>>>       }
>>>   +    if (domain & AMDGPU_GEM_DOMAIN_VRAM &&
>>> +        !WARN_ON(places[c].mem_type != TTM_PL_VRAM))
>>> +        places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>> +
>>
>> If BO pinned is not allocated with AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS, 
>> should pin and return scattered pages because the RDMA support 
>> scattered dmabuf. Christian also pointed this out.
>>
>> If (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>>
>>     bo->placements[i].mem_type == TTM_PL_VRAM)
>>         o->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>       r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>       if (unlikely(r)) {
>>>           dev_err(adev->dev, "%p pin failed\n", bo);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 8db880244324..ddbf302878f6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -88,6 +88,30 @@ static inline u64 
>>> amdgpu_vram_mgr_blocks_size(struct list_head *head)
>>>       return size;
>>>   }
>>>   +static inline unsigned long
>>> +amdgpu_vram_find_pages_per_block(struct ttm_buffer_object *tbo,
>>> +                 const struct ttm_place *place,
>>> +                 unsigned long bo_flags)
>>> +{
>>> +    unsigned long pages_per_block;
>>> +
>>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
>>> +        place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>>> +        pages_per_block = ~0ul;
>>> +    } else {
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +        pages_per_block = HPAGE_PMD_NR;
>>> +#else
>>> +        /* default to 2MB */
>>> +        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>>> +#endif
>>> +        pages_per_block = max_t(uint32_t, pages_per_block,
>>> +                    tbo->page_alignment);
>>> +    }
>>> +
>>> +    return pages_per_block;
>>> +}
>>> +
>>>   /**
>>>    * DOC: mem_info_vram_total
>>>    *
>>> @@ -451,8 +475,10 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>       struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>>>       struct amdgpu_device *adev = to_amdgpu_device(mgr);
>>>       u64 vis_usage = 0, max_bytes, min_block_size;
>>> +    struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>>       struct amdgpu_vram_mgr_resource *vres;
>>>       u64 size, remaining_size, lpfn, fpfn;
>>> +    unsigned long bo_flags = bo->flags;
>>>       struct drm_buddy *mm = &mgr->mm;
>>>       struct drm_buddy_block *block;
>>>       unsigned long pages_per_block;
>>> @@ -468,18 +494,8 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>       if (tbo->type != ttm_bo_type_kernel)
>>>           max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>>> -        pages_per_block = ~0ul;
>>> -    } else {
>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> -        pages_per_block = HPAGE_PMD_NR;
>>> -#else
>>> -        /* default to 2MB */
>>> -        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>>> -#endif
>>> -        pages_per_block = max_t(uint32_t, pages_per_block,
>>> -                    tbo->page_alignment);
>>> -    }
>>> +    pages_per_block =
>>> +        amdgpu_vram_find_pages_per_block(tbo, place, bo_flags);
>>>         vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>>>       if (!vres)
>>> @@ -498,7 +514,8 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>       if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>>           vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
>>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
>>> +        place->flags & TTM_PL_FLAG_CONTIGUOUS)
>>>           vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>>         if (fpfn || lpfn != mgr->mm.size)
>>> @@ -529,8 +546,20 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>                          min_block_size,
>>>                          &vres->blocks,
>>>                          vres->flags);
>>> -        if (unlikely(r))
>>> +        if (unlikely(r)) {
>>
>> If pin BO failed to allocate contiguous VRAM, this should return 
>> failure to application, as RDMA cannot work with scattered VRAM pages.
>>
>> Regards,
>>
>> Philip
>>
>>> +            if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>>> +                /* Fallback to non contiguous allocation */
>>> +                vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>> +                bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>> +
>>> +                pages_per_block =
>>> +                    amdgpu_vram_find_pages_per_block(tbo,
>>> +                                     place,
>>> +                                     bo_flags);
>>> +                continue;
>>> +            }
>>>               goto error_free_blocks;
>>> +        }
>>>             if (size > remaining_size)
>>>               remaining_size = 0;
>

