Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006E4C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 20:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7995810E666;
	Tue, 10 Jan 2023 20:44:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B9210E665
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 20:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQeO7jGwsj2bxI5ctQK/3uqWK6N1GxI25j9yh34DkqOlAzW1MXcyk3f0DfJy/1wps2J3WZIgcOOFJsz7dHFlKkzc6M0rEqYbi56mLyipIVNBv1IcLSppS6G5X/8A5mJcG1StfWfyXw473vgNE4q79REoHweA+SiTpr0oNAIazFPr2lLs9iPT+Ao2he3Ug5zO/HEXofADK2O/9fPg2C2Cy7syR0332S7gA+XrDHN8YinA/weC+izrifdwZde0cuVy+V5IzSMsOIlac2iiC+SoKSjFgD8b/a5zOhDU/gFvGYzZQmpIs83Pw91hhCUjJbBsUbCCP3hlsY7t7bt7YmnJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNYc6I6IJdzFb2TinK7HDZ+uxlNcIcdsUR0+02oTl2w=;
 b=R+UEJ2EVjkmW5CB/rxJ9iVLbpAYUVAD+5DvQ0IerpBoIFHpd1Hh0sOb9OiVKJJRDblO+B/ucZBdExc3RN5qo/xIetIMt1kntzNQ+kmW16NqS/P8lTxevfal9SB5JJAAqv5NkB3BCIiG9MckVTZSEPMwU03qcpQcfrUBspDr0EOzwBPART81KQ1g2ituVPkVhziNYSm4oQjT7+wsWeYob/IWV/5TT5DIb7/YYvLEU7HxFbvwhis5/3QUYtOCP+vRGzbXvW+TEe1lVVxs7MVYemtDPfe5p3ybNMpQ+1kjMPE7eAIreLKHgZ2Sen8+U2PBfJQEfov3x5db16UuQAU6z5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNYc6I6IJdzFb2TinK7HDZ+uxlNcIcdsUR0+02oTl2w=;
 b=VvBW9WkSx7AVYhjwb6kGYI0+ux3/5OaOVJrcWOGWZYIMNVDDentiO7UiEVJbgBFd3O52+HauEpadf+mGxU3lf3YLdR5AqgVOOBvzwsaAKKC8B3BlYZ/phA2zxqjCyYn7QrYGJLUfQgYmbmIe+1BNHVlRxbrZwCqbenqgaU0Mx4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 20:44:28 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1%9]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 20:44:27 +0000
Message-ID: <a554f4d2-3d0b-3c5d-c010-047f5048753c@amd.com>
Date: Tue, 10 Jan 2023 15:44:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Page aligned memory reserve size
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230110000112.29730-1-Philip.Yang@amd.com>
 <20230110171122.10380-1-Philip.Yang@amd.com>
 <d5d4c442-e7d2-5319-56b5-6d41edb9f375@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <d5d4c442-e7d2-5319-56b5-6d41edb9f375@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cb50bd-df96-4687-c373-08daf34b776a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gDOOPCjGSEV7ek6Fhcm38rkC+Yp7RX6bUNWVE+RR3K2pEJxhJsOKuG8z+/K0gSCAfDCGai2S0Tkfzc3i0AmKLURK6HXYsN4ESjzTdw+GCSp3VrJG8vBXibctFAIEbmR63rGl364JgaP/Xzu2uk4lfUbUO0/MwL0uBVUNTDZK0wjHs/iwlsDUuOlZPfKueERdn3rlXp4TpqzzHJbBdf6rw/7hOT++xrP3PIJ+vgO20mCFzBLIMyDQUGF6poUZXaAw773XGqLo1g9TlBX44YA3wonTOxpQMde+N0t6Lj9N1hKSF/x7GcvZxq5h5L2YqmZOIjulu3/uw3NHZJp+0r48qum0x8jEVDrmTzBaO5Qj3FW9sXqHenZ0CW2TwuRGhc0VI+v6O207RZayFBzkMps3Srusm4s19A4QTlJCiWfYaoVb5dDGand7730c9aQ4pGe+EYfXfm14eCGJRo0kun1wV65yeVPeTbArdhNocv1ppvw8LKZfxjTCKMO1wbKrZsq098JZQ5Z1LnY4O8m0m72IJ4c96nreuaqhAJSZhJ/jaG7dJrgvEY6wLMTfmLQCZiOIMV8bPn9HFkJTUARfS6Ps8RaJKNKCfUIfzseQI3L54q3NTwRiRPXJEA93NM9Y5w3BGxt4fyr2SqPvZ9TYQexAoCaL4K6h+Ut3093tZjKgnc5DLYvYsMDAEj3lBwIdBhvhmN+bOSaUz3nEmTTiwKwYHF5vTuVJNFtOTdYGI/AZY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(2906002)(83380400001)(2616005)(66556008)(66476007)(5660300002)(66946007)(53546011)(8936002)(26005)(36756003)(186003)(6506007)(6512007)(31686004)(478600001)(38100700002)(6486002)(8676002)(110136005)(41300700001)(316002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZaRWE2dVRNTG9OMCtwMDdSRHBZSGFFK1QyczBMZEFEVm5DYmpvTnNZcXdM?=
 =?utf-8?B?cllsMDhkdWdacVFtNlNNVTR4aVRQa0lkS2EwU1NQRzZ4RVE0Mm80U2hHaUM1?=
 =?utf-8?B?QXY4ay9mU1ludnFtYTUydmZMT0NPbVZxNUV5MnR5VXYvVTV4ZUNTWjZON1Vt?=
 =?utf-8?B?VU9kK29ZVUh3OENvMGxFcCt6ZkRUSVRCYXpUMzRyZFAxbWdKT1NHMXRiL0lE?=
 =?utf-8?B?ZytRV3U0NDExZStyQjNSdUFFWmYvTVFKbTEvL1d5Z1JWRVJRbTQ5RGcwYys3?=
 =?utf-8?B?c0NkMGt2Q3c1L0ZEckhqQWxVVTc0S1doS0dKQlRIdnRCanJqRE80VllCVCs3?=
 =?utf-8?B?MjJuNFZkVkhYOFAyQTY3aHJMSkdNcVN0S0toUldrVWN1dGVEai9PSXZ1TUdi?=
 =?utf-8?B?dGFhWUtvaVNYSThKNUtVM2RPMkdFbnprdkVja1FnVnQzKzc1VGtXWTV5a0hF?=
 =?utf-8?B?QzNPdFAxYVdDUHdCRnpqWnBJTFVNRzNiT0ZibmVReXlFOHZCeXl6Y1lsUmpZ?=
 =?utf-8?B?UXlZSDVNc0dmYVpzOGIzbGh3VzNmdS9JSzRJN3VCWXF2OXp4VURSdWxIMHFU?=
 =?utf-8?B?ZHR1T0Y5VUQyVE85dW5yOEwzRjQyd2E4dlZwTzloeFhkMlZwcXd0VHYzeUZV?=
 =?utf-8?B?WWkycGlYVTV0c0xVTVk2NDdoQkxMWHhJSG00aENmeDZ2N1B1Tldqcm0rVU1y?=
 =?utf-8?B?OUNWeDV6L24zUDJEeGR3N0o0eE5sMXhsREhIQTJrRit4dExtZTF6UCtSWEJE?=
 =?utf-8?B?di94dS9vTGZtbTUrY2RHZGtXejBETEs2bkozSDdZeHVraFEyY3NuM3RSM0dK?=
 =?utf-8?B?Q2xkRzljbS9SaHhWdndjU2h4OTlGUUFjRkpCenEwM3VOaGNDWUFuQTk1eVBB?=
 =?utf-8?B?UWNrWFhseFArYkowekZ1NzBibFNNRGFFRXkrRmNReGxRTDFqRkVNNkRGUC81?=
 =?utf-8?B?Q0lROFhLWUlQaDBUQ0JoRzBuejd5SUtaSjd4R2ZqZmUxS2NoSXYxOWVYbGNz?=
 =?utf-8?B?SHV1VjBDYTdGamtBTEI5TlloYkg4RGZ2Sm9oMS9zVFVmUUNCK0dHYlZmSE4x?=
 =?utf-8?B?MVYzcU10NGRsZmxhc0Z2cm5UTEpuK0ZTVitPaUNMU0t6a29vdkFoZXUwaGNL?=
 =?utf-8?B?NUIyT0VLOXpvam9HVVFaVkVBUnZnd1daQnVqSmUzTTJRNENCcDFLUWxReEJz?=
 =?utf-8?B?ZWFKWGhGK1J0M1BpVndIWlA0NDJVWktFM0JlK0VEWW5FM0R0eWE5NmFTcDdt?=
 =?utf-8?B?M0I4Z3FDWWttcjRWWmpyYzNuY1phaDRRVFdPdnN3dnRRa2VYOEl3RFp6dHFD?=
 =?utf-8?B?eTFHQmJkcE8zMERXU1BUZVBSNGZCd214MDlaNlY3ZnpITUVsVEtzTHV1TnRy?=
 =?utf-8?B?SitGTEsxL2NUNjhQVFlCdGVGZmFFVS9UM3pBMllUNmdDMVFyKzB4V3BuVFUr?=
 =?utf-8?B?QzdkTlNVMnlROWRTY3ZEcSsyd1gwRk5BVjlaSTF3ZE5RUWJ3N3NxQy9qc3p1?=
 =?utf-8?B?dDJvTk4vN1lhaUN1a1BtSEx3NS9lZDJjbG1xN0hSUWpXRno0NWJGSVdKR1Vi?=
 =?utf-8?B?NDVDT3VTT0ltc3JRTEdwNUJ1K1R0WHZUQ0E1dzJEY3BSRldqOWN0YTdob0Ju?=
 =?utf-8?B?cVB4bGV3VlNieFBEWkkzenQ1WTZHNDA5UVhHTFg5cjFIQmJ2L2dNNFVDM083?=
 =?utf-8?B?cmF1MVF4RmkxS2ExWDNpZndwVE02Z1QweVpyNzhZSTFHdkhmeU95NEZjVGRo?=
 =?utf-8?B?TWcwM3Njck9YbGc3ZWU1QVFEaG1jODBCcm42M0ZTZnVCa09jYnhrVVhjaStN?=
 =?utf-8?B?T2VBaEdCV0tYd2JPaW5SMkNXWmhNSGFrYnRDTFl5eDNaNzNtd2l4aHZXcDFN?=
 =?utf-8?B?OXRVcERENy9RVWUzTG9yY05Pd0p6NlFwQ0xEeE05QTBiaHJRbHpwMlYvRU1K?=
 =?utf-8?B?M3NXa1A3ZmJKVDNrR0h6MlNsNjE2SVhHbC9uWW5GMkJESVhOS2k0a2J3dnli?=
 =?utf-8?B?QnhGbnprQ3I0amNpUnJOMjdDTExCa1lUYzVxcWxHejdxbk9Ick1WblFLeUdB?=
 =?utf-8?B?TjdONTBkWW5BV2w1UlVraWNzQjVURDlNN1hYSkhOb3lSMFFwQXBzTTlVbThC?=
 =?utf-8?Q?Yotg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cb50bd-df96-4687-c373-08daf34b776a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 20:44:27.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1egFtTMdu0iMIdb6sgj43COCE0BgS2wXThwF+TX30gcAFAJPg8oLgNXas7dZzFPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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


On 2023-01-10 13:33, Felix Kuehling wrote:
> Am 2023-01-10 um 12:11 schrieb Philip Yang:
>> Use page aligned size to reserve memory usage because page aligned TTM
>> BO size is used to unreserve memory usage, otherwise no page aligned
>> size causes memory usage accounting unbalanced.
>>
>> Change vram_used definition type to int64_t to be able to trigger
>> WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
>> accouting issue with warning and backtrace.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 7 +++++--
>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index fb41869e357a..333780491867 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
>>     struct amdgpu_kfd_dev {
>>       struct kfd_dev *dev;
>> -    uint64_t vram_used;
>> +    int64_t vram_used;
>>       uint64_t vram_used_aligned;
>>       bool init_complete;
>>       struct work_struct reset_work;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 2a118669d0e3..7efee672bc41 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1598,6 +1598,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>       struct amdgpu_bo *bo;
>>       struct drm_gem_object *gobj = NULL;
>>       u32 domain, alloc_domain;
>> +    uint64_t aligned_size;
>>       u64 alloc_flags;
>>       int ret;
>>   @@ -1653,13 +1654,15 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>        * the memory.
>>        */
>>       if ((*mem)->aql_queue)
>> -        size = size >> 1;
>> +        size >>= 1;
>> +
>> +    aligned_size = PAGE_ALIGN(size);
>
> Why do you need a new variable for this? Can't you just update size to 
> be page-aligned here? Is the unaligned size still needed anywhere?
amdgpu_gem_object_create ->...-> amdgpu_bo_create needs the original 
size for domain GWS etc, as the size is used as number of pages, not bytes.
>
>
>>         (*mem)->alloc_flags = flags;
>>         amdgpu_sync_create(&(*mem)->sync);
>>   -    ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
>> +    ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags);
>>       if (ret) {
>>           pr_debug("Insufficient memory\n");
>>           goto err_reserve_limit;
>> @@ -1725,7 +1728,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>       /* Don't unreserve system mem limit twice */
>>       goto err_reserve_limit;
>>   err_bo_create:
>> -    amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
>>   err_reserve_limit:
>>       mutex_destroy(&(*mem)->lock);
>>       if (gobj)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 6d291aa6386b..e11451100a20 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1127,8 +1127,11 @@ static int 
>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>       }
>>         /* Update the VRAM usage count */
>> -    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>> -        WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
>> +    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> +        if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>> +            args->size >>= 1;
>
> This will return the updated size to user mode. That's probably not 
> what you want. It may be harmless, but technically it breaks the ABI. 
> It would be better to use a local variable for the updated size.

Submit v3 patch to fix this.

Thanks,

Philip

>
> Regards,
>   Felix
>
>
>> +        WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + 
>> PAGE_ALIGN(args->size));
>> +    }
>>         mutex_unlock(&p->mutex);
