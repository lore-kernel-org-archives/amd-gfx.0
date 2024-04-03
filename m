Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285F7C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 07:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987661125DF;
	Wed,  3 Apr 2024 07:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IiUp/iLH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2102.outbound.protection.outlook.com [40.107.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A881125DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 07:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dshp5mS7+40jNjvtKzhpRxDZ5R409x6ikEkpn672IADhgTLb16CTZmDBmCFjEOwpNd9Sp0FPU3SNltAtxcPm/XI4GQ2AKyUvngT6SjxlqCNXKY+FNX0S9a3RCp85QjXTUYLF4rWJ4FiaDS/bf9dci00cFQnnXGKC8qpOOxbXoEEPQafWn1v5hrMhCfSlaqrrkAVfLa1Ndf97iUzhsaC6ENR2E/PDDZS6hLHariAQe3lcvCvnEaGLNxLI5AQoTk2aSGl4BEZmCB/PSle/JBKCIutPs6Pib45wACCc7D7pIPownUdPiS2LJy0U/nnA6+t6RAxlEuUn0j05OMpOUaN6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTmJyaWScYdrFf4w5qF37/z7tlVmXVVjyg6e1fVzgUQ=;
 b=TL1RCzB9hf1uONJiZPmmtbvni2zYdCYNFubjFC5j596O5C4/lUgzCW7DKeGQGlCXpWq3O/kwU85QmHB0W5mBkwTNpZq/4HXLpoRixarQ5AdRJtbwMj0te/ER9Vv8ptgzb9m7IRxa4+CgzGD0yM3ZGJw3V4vgOc5OBbxH68ekv97Rf+BLEAHhR7miUiFHp/kcQwitvyFoKjD9lVPfV7t7lW7NoNijg0No31O6ANwsO25wF9wetyEm/ozp5pbaVEf1R7PTMktddQgcGvjMl2ciKBjuuuES8J5s0XCP6MVuTqWiGd2Kibj1w0z49LQDQAYi365CZ3onm6PKgCzpff08Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTmJyaWScYdrFf4w5qF37/z7tlVmXVVjyg6e1fVzgUQ=;
 b=IiUp/iLH7+8l8CijmcM0wVmvQIM4qrHKIYAPorbC9rhSDZqW7usHyFtMwizZXM1SldsunIRb9fzp0E0clw3t4/XN6DBIPFXJFsdYUKAc3x+J3gW607BdGP1vHOSsX9QeN+1n2p4YqNOukGUM7mbDSdBKmsiZlPbjJFejVfQJtFI=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 07:18:50 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:18:50 +0000
Message-ID: <c037df2f-bca9-ffb6-a569-603f4d8edb29@amd.com>
Date: Wed, 3 Apr 2024 09:18:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
To: "Yu, Lang" <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20240328044014.3278891-1-Lang.Yu@amd.com>
 <d3581afc-4bc4-4e42-a4f5-5b4be5f10ed3@gmail.com>
 <MW6PR12MB88988E7D5DB5D5E9C4ED1A45FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <MW6PR12MB88988E7D5DB5D5E9C4ED1A45FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::24) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB6184:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/wqGL9vpLmR0Q2poUXbylxJU0pmX34CzNFxjWJRKmsycE2ZDcIPTpR4VM0PRLMsoFOOLh0W+qcklCgV+w4HCfT/cjh+em+MMoyPRmx83UYJVGx87uvryCUa8ltf3X7WmqVqExYQy1acJQmif5m8DtpoGvJJJCNbAGSvUcs4c5bqNPvM74dqnmNvJ/QXQk6Sg5EDkY1y2A/DxCfD2aHFak0WflWp4dqB4qugrlEOMnZCmDh8RQvLPH9/GaMPPQYH+sExKU5I3qSYP8f+hzy+g0hrq5o2R3QM/toEZU0X0UWYMEXpriD6ByBi/vBU7yD4nnShsWGngeF1hSkr6DjMAmi/zRhAcRMnn6yCrWdga7tpo9KdQjI98wU1RPKU6nBiUWDba/caUIAyEH3P34sCZ43JCEfnGwSR1Kn8b1A0UG1vYymqGyCEhT+q6nZs/346BwSuWNyUCnc8Jk9TGU2+k5L5PypT/PiFvTi6mVSsTK3rdR1M0LSvJ23f6KLfPkFHinjDIpaZrpFA5aFnyUP5xwGfxVGikVuZ0we+XQIpvg8dhgU4E0YLWRzxYSEc0bqELv2r6uN3B1qstMpuYQM8XDITITUav7+wqXCQ5T5ZrNjM0uMd5EdF6XVu6lHrskq66PJJmQ7iiL00tLsoKvAKr7emgDHTZbkPLweYhE6I/cQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZzTzZkQ1kyNk9ORWdMNG5LcmhMSXpyQ0V3K2lUaHd3dXdLVlVNdUxNMys2?=
 =?utf-8?B?ZVFZYmhiQTUxUS9NMDhEeU90QnRxdmFoMDV3RUt2NEFDWTZkRTBhWDZCU1JW?=
 =?utf-8?B?NWw2MlhiUVdxaXN4RmlmOEZrb3A0SEoyU0lHaTZGdFNMZTIrOVE5YU9wZXRu?=
 =?utf-8?B?SGdldWNJOWxXZXV5WGFXMkhjS2lOdzRLTlZKcXphTHJ6NFNTKzRGU09NdTJS?=
 =?utf-8?B?dVdta1QvM2ZQbVhCaE94b05uZXFPV1FmSmlTZy8zY1BRbkpsYXpJWVhWcUJu?=
 =?utf-8?B?dlhRai9pUE1VTjlyL2FRNDdNM24zQ1pnSG1KQVdzMy8vTkl0Q2NqUzRwQndQ?=
 =?utf-8?B?bnhZaS8xV1VXMU1wRm5WcFFKQXpId1h2c242TUVoWGxySFJnbHQ4THYyN3kx?=
 =?utf-8?B?dGtzTmFyUFdiYjVZeTBrZy8yZUZZOWNWRDduTFVzZ2JGTlhKMEt6MVBCZWY1?=
 =?utf-8?B?elU2eW1hbmx0YmJDYStVVzFvdkh6eHVydStXUUFodk5maVBnejZFeUxaOGZn?=
 =?utf-8?B?TGRrcENPMTkraVMvRFBLWS96NDdMUDRBTmRMVHoyOGJGRjloSzBodlVjZVFD?=
 =?utf-8?B?ZDZwZXJQL1NDL0RBY3dJRmM0UVNBM090Sk93Ri9QTm83bkZMcmIyVWZlOGI4?=
 =?utf-8?B?WUI5R1BEc1VXaFc4b0JWbUhnOEYvWHd0WWg0TU9zVFJySlluKzZFNFpVcStI?=
 =?utf-8?B?RGJDUGE5WFE4OFl2VExrKzRWelRQTGt3OVZEMi9XalhyT0dxeDFlWGVTM0Ux?=
 =?utf-8?B?cEl5TDJUcmZId3pQNjNySlBOUlRqcWlubCtObkNSY21xZWl3WENNUWcwVEN5?=
 =?utf-8?B?R05ZSjdKZnhUZ3llcUYxUEh2ZG5ndlNJMlRMTmx3OWJyb29OMXBhR0xQWVhN?=
 =?utf-8?B?Vjk3dmQ0d3JTRG5sQ0xnUUNiMy9BM1ZjYnVVcS9GUzBZZHRMV1VuWjN5eWJa?=
 =?utf-8?B?anRLSWxNZFBxcWtQc0xXRm91VFU3R04vdUpHblVJZWhyVDZvMmk5bTFBWmZm?=
 =?utf-8?B?S1FWU3lFVjJwUXZOTTZSZllQRkx3ckFhQS93Mlo5SitUNzBJczVxb2hFaWZq?=
 =?utf-8?B?YnpuaXRKNy9HM21MZWwyR2RweEI4M3NBUDM0R25FdXloZEtpejJTeEFsVmI2?=
 =?utf-8?B?cnBjakdLK2tMUWlaTnJYTWVTY0dOSlppU0l2VkpnY1ljamlGUWpNbGxMZTgv?=
 =?utf-8?B?bG1yZUhOLzNvaDZsOTZ4VnowV2hkbEFuUkliVitpRFEwVGprU2srWG5zUDFv?=
 =?utf-8?B?U205MStIVS9FZW9Kc3hML3h5STJGWkJWNHN0ckxiWWhqTWl4c1RZSDN2c2t3?=
 =?utf-8?B?SGo3d1NjT2lBVWNVd05FTmNDLzJjVFdqZGhkZlBsSDlmcEswSXJuMnNnZTVa?=
 =?utf-8?B?V096ZWVXWlI2QVZIZzFFUFM0NlIrTGxSYUhCNEpES1RGY2FvRG9hOFFLNTZj?=
 =?utf-8?B?RW5RN0ZsN0YvRklLVk10SkN6RmZGd3B0OU82TDBPdkpsNnBlQ1doVHl4b1ho?=
 =?utf-8?B?aTlINUh1cWxwakNFKzkwSHlnOWIrSzd6K1AzVXFxeWwrZ0w1TGpkdHV4emZ0?=
 =?utf-8?B?RnRXWWlHL3ZnOTlzTlc0MjM2aVRRVlZjNzVZS1hESU91Zkcvb05EQjhPSFJt?=
 =?utf-8?B?UEhzeHByTUhzRE5tMlRwM1llMDNsWUlQSE5xcStNa05tVXVhM05Wa01yaHV2?=
 =?utf-8?B?UWJjblNoNHIxMTIxQ0NGcjgrbk9Sdk9mTjNaYTE5c1Y3KzBTSk9HbTNUL2VG?=
 =?utf-8?B?OTI4U0RBQlpvNE5RV0ZOcDRUb2IxSlkwNmJuQnlpbE1nMGgrQ291cEZYZ0x4?=
 =?utf-8?B?amxVblpLR1BJQnRsREw3V3pVNUlZUjdrckxnSEVQK2ZMdTJBcjkvcUF6ZS84?=
 =?utf-8?B?OEpsN0FRV3hGQkdnanNRSldhYndnbVU1NjJYcFdrZ0lsYW1pS01qVS9NOS9U?=
 =?utf-8?B?eGNPT2M3enJqeGhOTXdJcXhUNjdBZ1hleUJqcGd6Wis3bjhZR1FZTU9PUHVw?=
 =?utf-8?B?OERyQTJQWWdhR0o0VHFPVklmYlh1SkVtVnMwZ1E5QlNVNjZpMnRvdHVYZXY3?=
 =?utf-8?B?QkswQkRyTDQ0Uy9HUkNleUVrVnpLNjNlUmp3eWN6VU53d1RGM3c2TDBJTW45?=
 =?utf-8?Q?w3V8ct425jjSd+FCBfzQpHY0S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1accc7c-6682-4790-4520-08dc53ae4f70
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:18:50.3022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5X4M95+MAgeCWq7utx3EFtumrjcJGWV4ak6o5VSL9mJ3BN04O6ZTEahjyE1ZZfVvns2TY3hTLuhyFe+BTCOXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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

Hey Lang,

On 03/04/2024 08:51, Yu, Lang wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, April 2, 2024 9:38 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Sharma, Shashank
>> <Shashank.Sharma@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
>>
>> Am 28.03.24 um 05:40 schrieb Lang Yu:
>>> There are use cases which need full GPU functionality (e.g., VM
>>> update, TLB inavildate) when doing a GPU reset.
>>>
>>> Especially, the mes/umsch self tests which help validate the hw state
>>> after hw init like ring/ib tests.
>> I noted that before but just to repeat it once more: We can't do any MES or
>> UMSCH validation while doing a GPU reset!
> Yes, we can just easily disable it if it doesn't work well.
> But it doesn't take too much effort to make it work.
> It can expose issues as soon as possible and is useful for debugging purpose.
IMO, its not that useful for debugging as well. In case of a problem, It 
will just timeout waiting for MES packet write and we will still have to 
find out the actual problem which caused MES to go into bad state in the 
last GPU reset.
>
>> The ring and IB tests use some pre-allocated memory we put aside for the
>> task during driver load and so can execute during GPU reset as well.
> If user space can create a VM and allocate memory during GPU reset,
> it makes no sense to prevent kernel space from doing that.

I think the objection here is mostly about why to do it at all, when it 
is not helpful. It would be just a maintenance overhead.

- Shashank

>> But for the MES/UMSCH we need a full blown environment with VM and
>> submission infrastructure and setting that up isn't possible here.
> At least for UMSCH test, it only uses VM mapping functionality
> (if we can create a VM with cpu update mode, that's enough),
> it doesn't use other submission functionality.
> It is actually a compute context.
>
>
> Regards,
> Lang
>
>> Adding Shashank as well, but I think we should probably just completely
>> remove those from the kernel.
>>
>> Regards,
>> Christian.
>>
>>> Add a post reset IP callback to handle such use cases which will be
>>> executed after GPU reset succeeds.
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24
>> ++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/include/amd_shared.h   |  3 +++
>>>    2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 12dc71a6b5db..feeab9397aab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5556,6 +5556,27 @@ static int amdgpu_device_health_check(struct
>> list_head *device_list_handle)
>>>       return ret;
>>>    }
>>>
>>> +static int amdgpu_device_ip_post_reset(struct amdgpu_device *adev) {
>>> +    uint32_t i;
>>> +    int r;
>>> +
>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +            if (!adev->ip_blocks[i].status.valid ||
>>> +                !adev->ip_blocks[i].version->funcs->post_reset)
>>> +                    continue;
>>> +
>>> +            r = adev->ip_blocks[i].version->funcs->post_reset(adev);
>>> +            if (r) {
>>> +                    DRM_ERROR("post reset of IP block <%s>
>> failed %d\n",
>>> +                              adev->ip_blocks[i].version->funcs->name, r);
>>> +                    return r;
>>> +            }
>>> +    }
>>> +
>>> +    return r;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>>>     *
>>> @@ -5805,6 +5826,9 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>>               amdgpu_put_xgmi_hive(hive);
>>>       }
>>>
>>> +    if (!r && !job_signaled)
>>> +            r = amdgpu_device_ip_post_reset(adev);
>>> +
>>>       if (r)
>>>               dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>> index b0a6256e89f4..33ce30a8e3ab 100644
>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>> @@ -287,6 +287,7 @@ enum amd_dpm_forced_level;
>>>     * @pre_soft_reset: pre soft reset the IP block
>>>     * @soft_reset: soft reset the IP block
>>>     * @post_soft_reset: post soft reset the IP block
>>> + * @post_reset: handles IP specific post reset stuff(e.g., self test)
>>>     * @set_clockgating_state: enable/disable cg for the IP block
>>>     * @set_powergating_state: enable/disable pg for the IP block
>>>     * @get_clockgating_state: get current clockgating status @@ -316,11
>>> +317,13 @@ struct amd_ip_funcs {
>>>       int (*pre_soft_reset)(void *handle);
>>>       int (*soft_reset)(void *handle);
>>>       int (*post_soft_reset)(void *handle);
>>> +    int (*post_reset)(void *handle);
>>>       int (*set_clockgating_state)(void *handle,
>>>                                    enum amd_clockgating_state state);
>>>       int (*set_powergating_state)(void *handle,
>>>                                    enum amd_powergating_state state);
>>>       void (*get_clockgating_state)(void *handle, u64 *flags);
>>> +
>>>    };
>>>
>>>
