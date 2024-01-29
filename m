Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CDC47DDF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810D8112E2C;
	Tue, 30 Jan 2024 08:42:46 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn2064.outbound.protection.outlook.com [40.92.98.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8301010F775
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 13:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrA/n5E9hBLUJOcGg7ZxzqiAIFwbvSBA7lrV0Tky73LSSzGNkoshz4VL9cOdgqbAPOwGBl4s9SjItedh3pIrbJIuyXDyTjS/9GtIa60fIzXF5yTDupo6ML4+sCuoj/A0zIfDc2O+pIlUZatvIybDU0uH3nXCl9z0T951UAH3ovtz5V1VSDrWN2EKpxlR1YqfpOU62I+YYVb+Hg/gTH0sstBTLi5Ck1xRKXxRzxu2Yj7KJdYVk9rJgYCgsEyTvAshNdxMFYyPGrUCyX+yAGBf62J5zJqWY7wnqLrZ55FnP/HSEc+AfNRntxpdVdVHljMLGPPKrPoHlsvFAeDt7Zrk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJpiQA2hyIItkRx/Sk1ooo9gkrewnnGjQxV+DaIk0gQ=;
 b=TfQHnbwOKpycu1kdmHU0CB/Y8zp7ZSRzqYacPuwn/QHw7LN156lIsDc8tP1ki8qxx+Z+JqQBggwI5Nnyl6dLkY6YPfNxLSUx5FDINr92yICMSY7lRbEKNzxuiUf3MQIHirWpIm3jydO9MC4MqcwOtAateSLLcZ972iA/KxqonooKKOaV5wRiuTk4uRBe9tX7eEQhrGsfcRlldQVtF5ArOVZCggMHnYlNzNdKnrL30cW0FZfSyETRGg45Rbj7sgDehYPGDwiBv1M3ZIinGj5VdpRexHBsavraK+F39DoVOrjl/lZXlGArB5I9NLr4juPqwpgq75u4NPKzjJWwxLmb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJpiQA2hyIItkRx/Sk1ooo9gkrewnnGjQxV+DaIk0gQ=;
 b=V6BKOMQMXweYjpH3vWlCnY5yUsGknsZwnPGFH7iPJqkMLvlBIT2fzPcRZxeWhgWg5ySxJmI6F6ejCj4WjzeisQncUw8ito5cFS2ZmLNUCF7hChF1KcNDd3I7JcVWtFCwFRpNdF8T2jZSmmS0zqjHAwMDKhOZKLFTHzmRFXUz+jciKWZLQ3j4OB/CU8jtlkx3YaX/zFWshO1vC3jci2n+eeiJ7C0xrozpv18RwFkfX1nqd/EH00ARaK1n9q6oJkUx5yzjXHiyX7+rIu2iMS0ukeuhk17/dMsAM/yR3pxDHjH/JA9DZs/ZeI3+fMifjx7OwtOJwlD3Zb2Kpb/uxJHi3w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3572.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 13:58:34 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6801:95d7:c963:398a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6801:95d7:c963:398a%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 13:58:33 +0000
Message-ID: <TY3P286MB2611C443C88FFC125AE79DA2987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Mon, 29 Jan 2024 21:58:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
From: Shengyu Qu <wiagn233@outlook.com>
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <5b23b3ef-2ccf-430e-bc0b-b4868358ad8f@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <5b23b3ef-2ccf-430e-bc0b-b4868358ad8f@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [1JLdrpr05SG3FO8xiiFqPFetEt2+yKYKZr4idxacbgNJ9DCNXVnbXg==]
X-ClientProxiedBy: TYWP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <4142075d-c73b-4c5c-8553-af68da261fd2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b12fcf9-1a6d-4e9a-1500-08dc20d26138
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tTDJkuhUcT9QDIgqO9ul9oAQxHJVQsxPTwayGZOSFBP+YSZjtetEza2uX97bbILSX0tM2aipVju54bRQRxPS2ut6hkX1ZHmSuKY3zW4asTRzTZ+uG2QthmfHBR4FIuj+yRvJN0y34zPonYQUtW2Jaej7GR8FWSORr3rZdU5nsA/GW7O4glhI/Pa09jt42SPgm/YfeCvImW1viiPn9Cpuhafs1p9gfiCdoGdQNjvndW45OXrb4aTltnOffW0GqUSrkMH2v854ZhQPtVAicbal+aEUzzxUMjAvaaf+S0LqEsfrtXk0WcgfK4zqBVeYsx24T2FMQuFQPFtFmvuomUekJs8G+cfBWesJ1FoDf9t026S9F1lrs0SkxXDZXJov+5fMypsvwnD1WgqTtq48SiNJyrm4kKbf4gk1/ESwKQb+OdCgG5cvXxOY+c3yBV71cUDyBVVX9ClSKrNSiKGZGo5xqxmu5g9vJLnjMAON1KDMuw6YtPBNpsDzd73m5b6SDT7LKn3xX9RD+l/+DyxLDnnk9Hf2454jasLh+0CkKpUUwJBGD40Yh23I8RVrZ1v+zbMjSXEHlrS9mPQEHiJUQWNRWRpmYG9Riq6N9TKJyDYwGU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1k4R092OTBGMmJ2ci8yV2kwUDR6bWJSbENFQjZPZm8rUzQ5TDdDOEN5aSt3?=
 =?utf-8?B?cmEwSmhSRThUMHN3Uk5GOXBiVU9nd1hiS0lmOHd6MVFBZzNMeklkcExDL2RQ?=
 =?utf-8?B?OExHNUwrNkEvRy9yVVlSaEJmckhhWkpPVkl5dk9uVEgvUllGMm9IN0xuUVZh?=
 =?utf-8?B?VjJOS1pRUWhqdHFXNWNNK2UxWnF3dFVROUJhbHRVcU1GVElZS0daNEEzdS8w?=
 =?utf-8?B?U3pOY3hzam8rdUtDWkdaUFFhZER2Z2MvTHRaVVFURWpyLzdCbmoxWG00MkY1?=
 =?utf-8?B?LzRkTHROd0h3RkgvU0RFdklYU3BEY2RyeXZLUmdQbUdWSGFHNkdFMlpyTEpI?=
 =?utf-8?B?Z2pFN1dudC83WUdWdnBUWWdGaUNxZTVCT3FNSEFDcklsVjA2dnMrdzJPeW5X?=
 =?utf-8?B?RXF2ZWhLUU8vWCtDSUx3UzlRS0I3QXJjaW1zbHJZVVhwanNGWlVsM2o3Tis1?=
 =?utf-8?B?SFFOYUI2SWJCY3J2MEhkdEFFeW1zRlVBdnEyZkJ4bGNxWE1VRXZLNmp4eDNW?=
 =?utf-8?B?ZVhrV2xDM0Z1STVKNkpRN3M0dWkrMEtBUlZuZ2pXK2E4dFU0bnVNRGc0THFG?=
 =?utf-8?B?alZ3ekxOSTNtR2pnTW5VdzNZSTNxdlJYUDlVUng3S0ptOWFTalNoZGVXWU0w?=
 =?utf-8?B?ZW9nc0xSbTRxNWNLREpsRzZlZUt4MzFLSXJFNFFSZTk2MERDYjlJTVJqZkFW?=
 =?utf-8?B?Tk9RbENRN2g0RHZGYUJaWDIveEVsTTVtRG83K2IzQ3UrMTMvcGFXdnIzcU5t?=
 =?utf-8?B?aHcxaE8weTRTdDV3VjhERVhVNG5NWCtFSWM3a05lWG42ZmNzZ3UweWVwV0t3?=
 =?utf-8?B?ZHFZQS9RUnZEME9ESHNZYlMwMHJyeUl0cmRGeG4zYkk4M3RsNURmdHVoczlm?=
 =?utf-8?B?cTNPSVh5Mk94aExCcXFmK3p5Wk1HRUxqSkVwK0tacmlyZHllL0pGSDZrenRH?=
 =?utf-8?B?TTNoWDFBZFdXRlhwbHFHeGdTZTd0TTNMazdISEdzSzhkM0RNSUJ6elNNTjI4?=
 =?utf-8?B?T09pbUdPWEdOR3QydXoyUy84U2d3L0F3Q2o3MllaekE5Z1NOSjlucnFFemVo?=
 =?utf-8?B?azZIamd6ckduM3N3NGtxeEREdmVOSzkvVTdCemYrbXhEVkVMYlFxNkMrKzBY?=
 =?utf-8?B?VTU4elpOTmpqYWVQQ2k4dU5aK2NnNVdmZzRLek1pSVY4OTQ3UjZTd2ZDZ2FR?=
 =?utf-8?B?c2VvZVd3Qks4S1hoSk15c1NpaHJDV1RUZ3JURHR4THMwSXFyV0lpY3VKRVFj?=
 =?utf-8?B?ek9CdjhPdFJDWlkzeVFNTGtHS05SY21qQU5ncy9HeWFxdmtTVWQ4RktjTXRW?=
 =?utf-8?B?bzArWmNsV3ZRcWhsQjZUWlBlcmE0aTZOVFF6Mno2S0RvaDBBY29OU0RVQnYw?=
 =?utf-8?B?WW1adnpna1p1OVU2Nm5wQVRyaXVtb2cycW1PUWQ5dUFxRmpqOVRDZS9vVGlS?=
 =?utf-8?B?Vyt6Mk9LUW5vRjZ6OTJQSC9TNVdqNS90SnBOUDQvTkxsMXdsZ2FnemFwTzFp?=
 =?utf-8?B?enhlcHBseTRTSUEyQkN0MEJDVktnSmxZQWVtT1N0YVlyM0ZsUExpK0ZHTjJI?=
 =?utf-8?B?b0VvN2grV2FHaUhGakd0Mzc5MzhnL2d3RllVeDZPbHphNkxVbXRWMjJJbk1o?=
 =?utf-8?B?K1JIUllWQ3RzWUlOYmRDZW1vK0R1N2lDaEt2Z0tHd2c4QjdWRXg0WE5wM05M?=
 =?utf-8?Q?B4v85JVTD2MddMpzdcQT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b12fcf9-1a6d-4e9a-1500-08dc20d26138
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:58:33.8665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3572
X-Mailman-Approved-At: Tue, 30 Jan 2024 08:42:45 +0000
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
Cc: Jay Cornwall <jay.cornwall@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Seems rocm-opengl interop hang problem still exists[1]. Btw have you

discovered into this problem?

Best regards,

Shengyu

[1] 
https://projects.blender.org/blender/blender/issues/100353#issuecomment-1111599

在 2024/1/27 03:15, Shengyu Qu 写道:
> Hello Felix,
>
> This patch seems working on my system, also it seems fixes the 
> ROCM/OpenGL
> interop problem.
>
> Is this intended to happen or not? Maybe we need more users to test it.
>
> Besides,
>
> Tested-by: Shengyu Qu <wiagn233@outlook.com>
>
> Best Regards,
>
> Shengyu
>
> 在 2024/1/26 06:27, Felix Kuehling 写道:
>> The TBA and TMA, along with an unused IB allocation, reside at low
>> addresses in the VM address space. A stray VM fault which hits these
>> pages must be serviced by making their page table entries invalid.
>> The scheduler depends upon these pages being resident and fails,
>> preventing a debugger from inspecting the failure state.
>>
>> By relocating these pages above 47 bits in the VM address space they
>> can only be reached when bits [63:48] are set to 1. This makes it much
>> less likely for a misbehaving program to generate accesses to them.
>> The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL
>> access with a small offset.
>>
>> v2:
>> - Move it to the reserved space to avoid concflicts with Mesa
>> - Add macros to make reserved space management easier
>>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 12 ++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 +++++++++++---------
>>   4 files changed, 30 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> index 823d31f4a2a3..53d0a458d78e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> @@ -28,9 +28,9 @@
>>     uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
>>   {
>> -    uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>> +    uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(
>> +        adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>   -    addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>>       addr = amdgpu_gmc_sign_extend(addr);
>>         return addr;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> index 3d0d56087d41..9e769ef50f2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> @@ -45,11 +45,8 @@
>>    */
>>   static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>>   {
>> -    u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>> -
>> -    addr -= AMDGPU_VA_RESERVED_TOP;
>> -
>> -    return addr;
>> +    return AMDGPU_VA_RESERVED_SEQ64_START(
>> +        adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 666698a57192..f23b6153d310 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -135,11 +135,19 @@ struct amdgpu_mem_stats;
>>   #define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < 
>> AMDGPU_MMHUB1_START)
>>   #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < 
>> AMDGPU_MAX_VMHUBS)
>>   -/* Reserve 2MB at top/bottom of address space for kernel use */
>> +/* Reserve space at top/bottom of address space for kernel use */
>>   #define AMDGPU_VA_RESERVED_CSA_SIZE        (2ULL << 20)
>> +#define AMDGPU_VA_RESERVED_CSA_START(top)    ((top) \
>> +                         - AMDGPU_VA_RESERVED_CSA_SIZE)
>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE        (2ULL << 20)
>> +#define AMDGPU_VA_RESERVED_SEQ64_START(top) 
>> (AMDGPU_VA_RESERVED_CSA_START(top) \
>> +                         - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << 12)
>> +#define AMDGPU_VA_RESERVED_TRAP_START(top) 
>> (AMDGPU_VA_RESERVED_SEQ64_START(top) \
>> +                         - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>   #define AMDGPU_VA_RESERVED_BOTTOM        (2ULL << 20)
>> -#define AMDGPU_VA_RESERVED_TOP (AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>> +#define AMDGPU_VA_RESERVED_TOP (AMDGPU_VA_RESERVED_TRAP_SIZE + \
>> +                         AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>                            AMDGPU_VA_RESERVED_CSA_SIZE)
>>     /* See vm_update_mode */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> index 6604a3f99c5e..f899cce25b2a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/mman.h>
>>   #include <linux/processor.h>
>> +#include "amdgpu_vm.h"
>>     /*
>>    * The primary memory I/O features being added for revisions of gfxip
>> @@ -326,10 +327,16 @@ static void kfd_init_apertures_vi(struct 
>> kfd_process_device *pdd, uint8_t id)
>>        * with small reserved space for kernel.
>>        * Set them to CANONICAL addresses.
>>        */
>> -    pdd->gpuvm_base = SVM_USER_BASE;
>> +    pdd->gpuvm_base = max(SVM_USER_BASE, AMDGPU_VA_RESERVED_BOTTOM);
>>       pdd->gpuvm_limit =
>>           pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>   +    /* dGPUs: the reserved space for kernel
>> +     * before SVM
>> +     */
>> +    pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>> +    pdd->qpd.ib_base = SVM_IB_BASE;
>> +
>>       pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>>       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>   }
>> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct 
>> kfd_process_device *pdd, uint8_t id)
>>       pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>       pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>   -        /* Raven needs SVM to support graphic handle, etc. Leave 
>> the small
>> -         * reserved space before SVM on Raven as well, even though 
>> we don't
>> -         * have to.
>> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so 
>> that they
>> -         * are used in Thunk to reserve SVM.
>> -         */
>> -        pdd->gpuvm_base = SVM_USER_BASE;
>> +    pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>>       pdd->gpuvm_limit =
>>           pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>         pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>>       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>> +
>> +    /*
>> +     * Place TBA/TMA on opposite side of VM hole to prevent
>> +     * stray faults from triggering SVM on these pages.
>> +     */
>> +    pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(
>> +        pdd->dev->adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>   }
>>     int kfd_init_apertures(struct kfd_process *process)
>> @@ -407,12 +415,6 @@ int kfd_init_apertures(struct kfd_process *process)
>>                       return -EINVAL;
>>                   }
>>               }
>> -
>> -                        /* dGPUs: the reserved space for kernel
>> -                         * before SVM
>> -                         */
>> -                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>> -                        pdd->qpd.ib_base = SVM_IB_BASE;
>>           }
>>             dev_dbg(kfd_device, "node id %u\n", id);
>
