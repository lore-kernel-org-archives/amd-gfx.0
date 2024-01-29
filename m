Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708EBC47DB3
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 17:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1960110F6E7;
	Mon, 29 Jan 2024 17:47:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3455510F6E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 17:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6TOSimwzCDBXHF+mMQSMbnnThZBTxTsmDeq5j9RGlgUyREJiQH9nooa68poPk10nDabAdyN9/mvpSmiMQBRNm9AnPGqbvr+9Bwd2vnimBr2Ya7RYUygz25Bls8buKa+85yoXUbdHwk72yIuXFedkv90Tg5leiut7xbYrt/E97i6+4HBhoiXC7/aKsT9W0UJ02+f81L+wWKOZdeR4anYIAeyf+DAmFvsmk0B8zu1E99pX3Eb0aHM1yRzuwZghxRQLB8PzLt/gOS8tlmYxGQXIb7vJ3LL5Mgd+w0xDT4G3GAhP5mKvPnZOEK733koxHWdenB0iq1lYQoJfC8/lci3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/Mv248iMI60BeOO60L/b+Ers6wH88Lc2ikujTGryw8=;
 b=SjaGSARL8AXyf0u5pNt6teY+tVZngSZuoMDjUUOxo12osZ7VH+LB4jVGfX6gOyb9XW26UqdGYKcngJHmRhcsQR5em0qfrFkHiFReNjfpCxo2KKS4iChFpD103g1FnMvozS53PFBNsC1P20o31t14DhoOBnAQIDm/bq93o8P8nbp/YKM2hTvBE0SKm+XJkmVedxdTOlgRvcWTeC/ZqN1LZqkQ9ddChgrClK245s9Wfq4jh+yOVbEfdKGrVnGe/tr+NGolWQfiXupWInWTplXzaWOOVwAjMO5jn+NaM8diBqa4cUn0oRwK3TKei51rvt7NwCIr1EK2YGlbPR3VfOR6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Mv248iMI60BeOO60L/b+Ers6wH88Lc2ikujTGryw8=;
 b=BodyrCucRJzn6MBhpHmfH8Q0OWITViZ2VblaIlsLPgM4FjIcVx5JuW1hstR5S0lbe1hfkyRuD2rC0ip3r+cIh1G8SXgIXZzdY+ONwv5aOPWv+OJfJgmfNQl/sxpiXOnZ5E/5BD/J2+78UjmOTX2OHu/SzvyCrxe5swHXDRS2nCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:47:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:47:36 +0000
Message-ID: <d180e65f-7b3e-4413-baad-e40c3bb63fce@amd.com>
Date: Mon, 29 Jan 2024 12:47:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
Content-Language: en-US
To: Shengyu Qu <wiagn233@outlook.com>, amd-gfx@lists.freedesktop.org
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <5b23b3ef-2ccf-430e-bc0b-b4868358ad8f@outlook.com>
 <TY3P286MB2611C443C88FFC125AE79DA2987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <8b8d9a37-111e-4c92-886d-f29da2abb527@amd.com>
 <TY3P286MB2611E17DA5FCC50F6FEC83BB987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <TY3P286MB2611E17DA5FCC50F6FEC83BB987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: b79b33a3-9b2b-44f7-62eb-08dc20f26143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ep++sre4p3CttJBa2gJzA9i1cGW3nruJQwkr3pQKjVzZ8+3zi5+egBm2r+1O0xeKVlqPFIGHRtIlTgu4HNCeirrrSxrVbmJ8dQUnMmhTbIo67YtWBlRXRlht09CMIhIDISf4s8ec87uH0vzvvDX1+FE4OJYHcAH4nP7kA8bQCurh/cWhDrQbhW4cBkQYWox2n0SZzZ6GAVmt8gCWyaZx7SstDijL9wE5n4PKgOgUC9tpf9v7T8agF517brrdMhRfBBUkr21UzTk2PwC6NDxrfZ8jJmrm0zrYMZX0nV2L5rx/HtJ9uQNt3a3HUlSplbNMvZXyCVoLwShzYrmSPdZmh4oYgjr2Es8sicHIPRZqvImK65eWcXXlH3rDeIryl1hhu/31wxejdxl7QPIuQk9Jf+gbGf7kskHogHjzejw95G1Qwc3njFoVfMfldFC/b3t9njodpobnu0V+OjOyoBcLiDuDHdryzRtOSH5UaWY2ZHfTyWbgGGTvYPtDekrhQhBSveDNpmidTAz+NtgS3j2t8ca5CNalSHvk7YfpiRY8Vi9EKFUqHGYBaaQKJyT0jO0q5qVlcCXLWf0cyQ5/Ydzh27W6rtIblvdbUgCd01CCOfgO9ZFcuNoetlsc9jGmZ4oOZCc+b4Be/cixk/68BRHu9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(8936002)(4326008)(38100700002)(66476007)(66556008)(54906003)(66946007)(316002)(86362001)(31696002)(36756003)(41300700001)(2906002)(45080400002)(44832011)(5660300002)(6486002)(966005)(83380400001)(31686004)(6512007)(6506007)(53546011)(26005)(478600001)(36916002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUx1Z2JYYUR1aUUvUUpKam0wUGpUSkJEem16ZGZHRU96ejllRHFLSDJvOENH?=
 =?utf-8?B?RTlvS1pLaWNaRFg4WUgzQlIxMEJXQUVpWGxYdkxyeUpPZmh3Mmc2L0pYUzM3?=
 =?utf-8?B?eUo3dW90VWJieWx4YVZRbWtpUW83TkpvK2ZmbW1EcVptbDZyNWhTanZXNHVP?=
 =?utf-8?B?VXJzNFQ1cGNWc1pKM211eVh4SURBK3lqM0hrY0o4NXo5NUxvLzFzSUQwaVBS?=
 =?utf-8?B?K0ExRzE4aEJYV3Nac1BXLzlTMVpwSGt3ME54YlZwQ2x6Y1NpaVJUMWEyYlJR?=
 =?utf-8?B?V2pzVEdpaERDWUJja2VvQmpJVkFHdHNLYVVXQWs1SFJxYmF0VW5QSHRvWDND?=
 =?utf-8?B?aXovVnNlbXZ1NXM2eEJyVll0RGEzTWUyc0p2QmpLa3VDTExpYjdFcUlqTFBJ?=
 =?utf-8?B?ZXBBZFFNL3hlMmE5K3FFU3g2amRBMHlOQUJTY2xuTFptMlpzZnhJRkdLVGRs?=
 =?utf-8?B?K29GOUxtOWFXdStuaGJEWHlhNmdLTGdJb1dPUVJnb0NFMWY1VXF0QllwRFVU?=
 =?utf-8?B?WXZhZ2NmVUxtOS9jcGwyNlhtdjZYVERLaTZhM2cweTR6YUxLaktSVGx1a0pF?=
 =?utf-8?B?Q09BVXFGelFqMWx5MitUaXVUbndkNzdBUlUvdXlWUHNuQmpvanFrRG5wNzJC?=
 =?utf-8?B?ZHNSOCtjUjN5ME1tNUFRanpIckliVUNEeUkwdGRRWVpESkNNdnVmQ0N3cGVH?=
 =?utf-8?B?WURmTnN3UWlYcHNIZmVZSTFIdjJjZVVlS1hVTzRtSTZMNzR5VzVST3ZaZTll?=
 =?utf-8?B?Zkp0Wmw0RGlVMEMyTnZ6NTFMTGM0N1RzWm8xTDF0ZUxiSTdSREs0dDRlb1Vw?=
 =?utf-8?B?VnJReG10cDRCeHlYSjRVbjVhR0N6TGM5VlFwOWdmNlBxNC8xZnZ1VmsrNlEr?=
 =?utf-8?B?U0toQlp5MHNDNnlOR2FLbEVtZ3hmZ29UY1AybFYrTEhsQnRkV0RUamFaWTRM?=
 =?utf-8?B?dWxYQTQ1NGZpTGZjUWQxTERtWmhwRWZMY1c4NFFVaS82VU91UHJvRy9UN09E?=
 =?utf-8?B?aERFMEZrYzRvcEhMQVpCSG01QWZHMmtRK2lDV3I2RWUyZ3dCc1BRQmN2YXlj?=
 =?utf-8?B?MmxGcisrQXMxWmsrYzhzUjFFa0Zyekx3Tk9QMWxRRld4bWdlblNPdGxmSDRi?=
 =?utf-8?B?eFkybkVDVWZTUGJETHlYdlVsRmIwTnBabXFoWjdveU5pcW1uNHh6Y3BhRTZW?=
 =?utf-8?B?SVM0UzlzQnAyQmxJQ2tad1hRY1h1Mk13cDFGVHdjRjdCdXQ3Y3ZmcEVRbkxC?=
 =?utf-8?B?czVPYnRjUEdrTmpjWkpyYkF2V1J1MlJVUXlzRmFKQzB5aTE3c2JneFVjSHBR?=
 =?utf-8?B?RUk4bDR5TC9WRlAwNmZvRzR4UmkvbVNlSzF2RnJWNEZOYWw4Z2xiWngxb0VC?=
 =?utf-8?B?dnd4bHVTSHRTVUJndll6T2lzUzBPWWJ2QjA4R0lPY2ZsM1hjYzlDQ004ZmxG?=
 =?utf-8?B?NG9kOWhYaGo0c3BiVWI2cU44eDk0cSt0NWsrbUx5L1NKeVBYMVhIbWhjelk2?=
 =?utf-8?B?SlVCb2JHRnUydVQwaEtWdUJXQnR3TSs4L0N5RlZwK05wc3lnN1dhSWxoRnhJ?=
 =?utf-8?B?N1prZDN1WDlXeC9PZDhWTHdtdjlkRjh1QW1kVFgyYWF2MWhFUDFrMmlvSWl3?=
 =?utf-8?B?RGhONmlXdnMvckgvVW9tUHFHUUlvOHJnZ1pNV1pjZWZockZuakdGSnJPZllN?=
 =?utf-8?B?ZEsvT05nMldtUUYwSyt1cmxIbkxNKzhwN05LOEl0UFRkZllWTzNQNnVMQTZR?=
 =?utf-8?B?dC9Scm1uRDNybWN3UXFFcTBjY2xzTkppU0ZUdG9xa1JkRGdmSWx6MGNoY2tT?=
 =?utf-8?B?SnYraG5tQ1g5cU1WRFppNmF1V0JXY1FSWU5rMFh3dTBkRWsvOUJWSFdtaXhV?=
 =?utf-8?B?MDNCUlhCYnNMTSttWlZ3bXoxNWRSeXEyTDdTbnFxZjVzWFVwazdYcHd0NS9J?=
 =?utf-8?B?eGF0bkh1ZVN1cmZoSnlOSHd0OUZMVHdxVWhSRlRYcktmU25pS3htakswM0Nl?=
 =?utf-8?B?THp0UDROaU9oN0VBSDdGVWxLQ2VCeGsyZ3kwdFRNT0ozUHFMdWR1cXlCaDdY?=
 =?utf-8?B?N2VaalBxOVFZZStjYy9iWGlYZzJ2LzZVRGgyd0lnbTlIRW1GY0tCUFYvZnhq?=
 =?utf-8?Q?Qe4mq/Kb4ViLVWJXiIqbSkvEV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79b33a3-9b2b-44f7-62eb-08dc20f26143
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:47:36.6991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8ttkJuaCYugBlJpQ+O5+PHv/Qo7bhNlE1EGw1hN53/zpy7gnfpg5r3/iOXoLInic2/iUhYWSkHBArm1A5c6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
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

On 2024-01-29 10:24, Shengyu Qu wrote:
> Hello Felix,
> I think you are right. This problem has existed for years(just look at 
> the
> issue creation time in my link), and is thought caused by OpenGL-ROCM
> interop(that's why I think this patch might help). It is very easy to
> trigger this problem in blender(method is also mentioned in the link).

This doesn't help you, but it's unlikely that this has been the same 
issue for two years for everybody who chimed into this bug report. 
Different kernel versions, GPUs, user mode ROCm and Mesa versions etc.

Case in point, it's possible that you're seeing an issue specific to 
RDNA3, which hasn't even been around for that long.


> Do
> you have any idea about this?

Not without seeing a lot more diagnostic information. A full backtrace 
from your kernel log would be a good start.

Regards,
   Felix


> Best regards,
> Shengyu
> 在 2024/1/29 22:51, Felix Kuehling 写道:
>> On 2024-01-29 8:58, Shengyu Qu wrote:
>>> Hi,
>>> Seems rocm-opengl interop hang problem still exists[1]. Btw have you
>>> discovered into this problem?
>>> Best regards,
>>> Shengyu
>>> [1] 
>>> https://projects.blender.org/blender/blender/issues/100353#issuecomment-1111599
>>
>> Maybe you're having a different problem. Do you see this issue also 
>> without any version of the "Relocate TBA/TMA ..." patch?
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> 在 2024/1/27 03:15, Shengyu Qu 写道:
>>>> Hello Felix,
>>>> This patch seems working on my system, also it seems fixes the 
>>>> ROCM/OpenGL
>>>> interop problem.
>>>> Is this intended to happen or not? Maybe we need more users to test 
>>>> it.
>>>> Besides,
>>>> Tested-by: Shengyu Qu <wiagn233@outlook.com>
>>>> Best Regards,
>>>> Shengyu
>>>>
>>>> 在 2024/1/26 06:27, Felix Kuehling 写道:
>>>>> The TBA and TMA, along with an unused IB allocation, reside at low
>>>>> addresses in the VM address space. A stray VM fault which hits these
>>>>> pages must be serviced by making their page table entries invalid.
>>>>> The scheduler depends upon these pages being resident and fails,
>>>>> preventing a debugger from inspecting the failure state.
>>>>>
>>>>> By relocating these pages above 47 bits in the VM address space they
>>>>> can only be reached when bits [63:48] are set to 1. This makes it 
>>>>> much
>>>>> less likely for a misbehaving program to generate accesses to them.
>>>>> The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL
>>>>> access with a small offset.
>>>>>
>>>>> v2:
>>>>> - Move it to the reserved space to avoid concflicts with Mesa
>>>>> - Add macros to make reserved space management easier
>>>>>
>>>>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>>>>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 12 ++++++--
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 
>>>>> +++++++++++---------
>>>>>   4 files changed, 30 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>>>> index 823d31f4a2a3..53d0a458d78e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>>>> @@ -28,9 +28,9 @@
>>>>>     uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
>>>>>   {
>>>>> -    uint64_t addr = adev->vm_manager.max_pfn << 
>>>>> AMDGPU_GPU_PAGE_SHIFT;
>>>>> +    uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(
>>>>> +        adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>>>>   -    addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>>>>>       addr = amdgpu_gmc_sign_extend(addr);
>>>>>         return addr;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>> index 3d0d56087d41..9e769ef50f2e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>> @@ -45,11 +45,8 @@
>>>>>    */
>>>>>   static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device 
>>>>> *adev)
>>>>>   {
>>>>> -    u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>>>>> -
>>>>> -    addr -= AMDGPU_VA_RESERVED_TOP;
>>>>> -
>>>>> -    return addr;
>>>>> +    return AMDGPU_VA_RESERVED_SEQ64_START(
>>>>> +        adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>>>>   }
>>>>>     /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 666698a57192..f23b6153d310 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -135,11 +135,19 @@ struct amdgpu_mem_stats;
>>>>>   #define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < 
>>>>> AMDGPU_MMHUB1_START)
>>>>>   #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < 
>>>>> AMDGPU_MAX_VMHUBS)
>>>>>   -/* Reserve 2MB at top/bottom of address space for kernel use */
>>>>> +/* Reserve space at top/bottom of address space for kernel use */
>>>>>   #define AMDGPU_VA_RESERVED_CSA_SIZE        (2ULL << 20)
>>>>> +#define AMDGPU_VA_RESERVED_CSA_START(top)    ((top) \
>>>>> +                         - AMDGPU_VA_RESERVED_CSA_SIZE)
>>>>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE        (2ULL << 20)
>>>>> +#define AMDGPU_VA_RESERVED_SEQ64_START(top) 
>>>>> (AMDGPU_VA_RESERVED_CSA_START(top) \
>>>>> +                         - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << 12)
>>>>> +#define AMDGPU_VA_RESERVED_TRAP_START(top) 
>>>>> (AMDGPU_VA_RESERVED_SEQ64_START(top) \
>>>>> +                         - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>>>   #define AMDGPU_VA_RESERVED_BOTTOM        (2ULL << 20)
>>>>> -#define AMDGPU_VA_RESERVED_TOP (AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>>>> +#define AMDGPU_VA_RESERVED_TOP (AMDGPU_VA_RESERVED_TRAP_SIZE + \
>>>>> +                         AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>>>>                            AMDGPU_VA_RESERVED_CSA_SIZE)
>>>>>     /* See vm_update_mode */
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>> index 6604a3f99c5e..f899cce25b2a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>> @@ -36,6 +36,7 @@
>>>>>   #include <linux/mm.h>
>>>>>   #include <linux/mman.h>
>>>>>   #include <linux/processor.h>
>>>>> +#include "amdgpu_vm.h"
>>>>>     /*
>>>>>    * The primary memory I/O features being added for revisions of 
>>>>> gfxip
>>>>> @@ -326,10 +327,16 @@ static void kfd_init_apertures_vi(struct 
>>>>> kfd_process_device *pdd, uint8_t id)
>>>>>        * with small reserved space for kernel.
>>>>>        * Set them to CANONICAL addresses.
>>>>>        */
>>>>> -    pdd->gpuvm_base = SVM_USER_BASE;
>>>>> +    pdd->gpuvm_base = max(SVM_USER_BASE, AMDGPU_VA_RESERVED_BOTTOM);
>>>>>       pdd->gpuvm_limit =
>>>>> pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>>>   +    /* dGPUs: the reserved space for kernel
>>>>> +     * before SVM
>>>>> +     */
>>>>> +    pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>>>> +    pdd->qpd.ib_base = SVM_IB_BASE;
>>>>> +
>>>>>       pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>>>>>       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>>>>   }
>>>>> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct 
>>>>> kfd_process_device *pdd, uint8_t id)
>>>>>       pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>>>>       pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>>>>   -        /* Raven needs SVM to support graphic handle, etc. 
>>>>> Leave the small
>>>>> -         * reserved space before SVM on Raven as well, even 
>>>>> though we don't
>>>>> -         * have to.
>>>>> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses 
>>>>> so that they
>>>>> -         * are used in Thunk to reserve SVM.
>>>>> -         */
>>>>> -        pdd->gpuvm_base = SVM_USER_BASE;
>>>>> +    pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>>>>>       pdd->gpuvm_limit =
>>>>> pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>>>         pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>>>>>       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>>>> +
>>>>> +    /*
>>>>> +     * Place TBA/TMA on opposite side of VM hole to prevent
>>>>> +     * stray faults from triggering SVM on these pages.
>>>>> +     */
>>>>> +    pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(
>>>>> +        pdd->dev->adev->vm_manager.max_pfn << 
>>>>> AMDGPU_GPU_PAGE_SHIFT);
>>>>>   }
>>>>>     int kfd_init_apertures(struct kfd_process *process)
>>>>> @@ -407,12 +415,6 @@ int kfd_init_apertures(struct kfd_process 
>>>>> *process)
>>>>>                       return -EINVAL;
>>>>>                   }
>>>>>               }
>>>>> -
>>>>> -                        /* dGPUs: the reserved space for kernel
>>>>> -                         * before SVM
>>>>> -                         */
>>>>> -                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>>>> -                        pdd->qpd.ib_base = SVM_IB_BASE;
>>>>>           }
>>>>>             dev_dbg(kfd_device, "node id %u\n", id);
>>>>
