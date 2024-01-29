Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63BBC47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 14:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400FF10E4A3;
	Mon, 29 Jan 2024 14:52:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D522C10E4A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba/XLD08H1FI3WpwOPC7enoThmjQdwpdSUBx2/3f9OTL8RER+KHemKOC1cgENi/BrqVY49m93KSRSdbWTN/HLYkgzLsIDW297MJdQTCVn1GRlaigzhF0kgxM/Sxvi/5EF5AlixM9ITpL0oW20IgfcCvLT/ERHpMtq/B16vn5t1LPP0mnQORtUS8UwkuVXXsGJ+wc7TvYCFgmoOfR1XSCsvAO58oM4rQQYy6EvOyhMknoOlfF/2v/3NdyR0eyZ9sS9cr9lIC4GXqqIRMwaRkYu1oEsozWbdKm2KpKiSVpDpZT52YvgUShIlSTSr73VaS7n3NF/6J+YnjWqCQ5mNuOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwwJGhKgYlhyRolDHuZVpETvlC89tTSB9Jju3MdxQjA=;
 b=Ky1MRyrEfKpH70UjYux1Al0KO0j9offoKB5ONVnwsXSnRnO+yuBhVmVQ5hCv+n2mm/oewEZuDk2s1BZTD9etPGS3jOGmjYQqoIhAZhnAz1owKQ8iw+oTx6O2GKqewY9O9oUmFFj3NB24Q0xH06sh+ljNa4n3F5jeT2Ut7+40lFKma11Pj+0AOHE5K70Q8x4CioAM+CpDyQRPDcD/zOfXOxWWWeHXamQ1pohoIPryskTgEvBH3gV0zrjSAxJB7cd2XwdgXGfZ2jxnzoHbl1U2QSe8nTYRzm+8KFe2n/L5w6Qe4OVVytaYxDbEJuR8aZtwcs08OjBvEgoT/mKGgZzzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwwJGhKgYlhyRolDHuZVpETvlC89tTSB9Jju3MdxQjA=;
 b=INBY0mX9aPf+LUfWVDHBIQXew6GstiTtCyPBQfvtypPVs7JJwH+v7hK3h7AFFRvdtDtvaYbmMsNYq4ONKjHdd03R0xmbPPA2FIN+F68wxqiK2mL79llJlHyfGiZ5sT+q3AUMeV3FlY5t2W8iw2uMLzs+Y1/MwcLNg8WwUB4hvEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:51:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:51:58 +0000
Message-ID: <8b8d9a37-111e-4c92-886d-f29da2abb527@amd.com>
Date: Mon, 29 Jan 2024 09:51:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
To: Shengyu Qu <wiagn233@outlook.com>, amd-gfx@lists.freedesktop.org
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <5b23b3ef-2ccf-430e-bc0b-b4868358ad8f@outlook.com>
 <TY3P286MB2611C443C88FFC125AE79DA2987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <TY3P286MB2611C443C88FFC125AE79DA2987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::31)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcaa1aa-f1de-4090-eb3c-08dc20d9d7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgGeBQhNslmVzqxCSzyRDmVlgZZ3ODIh1uaeV24vMQ3KoL63XLJbTvM58OY2OuVFmzdet9CEq9f3uOGRZK6sO095tgRLgPp/826+2iIymseuKAj3CvFmGf5IeNDtxxzHPc0vkxUHitP7DTPcSIymq2wrrnNSVmCuHpH3Zo6BzQGZ3ggsTgDZ17evuTUW2TrVlZp/RpzMxS7mQVHt0y5g/tHr4yaTUzUvPQpH21QLKcz+vptbUbZiZF+KKwWsM+UxiDZXov6fg60/HixyDXX+qHLDDFOnxoGjcqDdLOnz5bo5t71FhJ1EGjVvYZH2snQR2+tY9Twsh/an7Fd6BbRWeRsNQ1R19Kv2ICHQref7DF4NkkXZI+Lc0jFSQTgrNQ1z3XE3kjTPEtRNJeZAcvMdK3jboJ9LX8fmhFxhX9OrVuZMg+LdWeM1iHw9YxqOyydq7pdwqSAcG28xZ7DRaV+F8F4TazyPrR7p7zp5ZbHFScRXqD1MHE3opIQDOFHN+r4rZUapxeRgrskCkrGs+TTq0e0XLwlkTbZ72TjKxF34YrxLCpjQExeTsUuQWJQkoFlSP3ImYtlXGeSquSW8Aim3EAFTJREpXAmIay3YU84AW5zY6tctOvrpWhNRhXBHZPOFOSevfEuuu9JNb8CE1+gd6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(53546011)(6512007)(6506007)(38100700002)(5660300002)(66946007)(4326008)(8936002)(44832011)(8676002)(41300700001)(316002)(478600001)(966005)(6486002)(2616005)(2906002)(45080400002)(66476007)(54906003)(66556008)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Y0aSttOTU1Q1BRTjB5R3JJNkEzc2xDWm5kMk0zOTdZb09WVXpiWXVnQyt0?=
 =?utf-8?B?blV5NXFXYWVDNmVIVm1uTm9jNGIvemEwWjBjWWhxbGIvODhMNGNJSy9NcXUr?=
 =?utf-8?B?WGlQOVphQ1RGU0ZGNnczcVRUUkU2bVhMMFdKdEliREtwQUl5eUEwYWVHTmpD?=
 =?utf-8?B?dERScmZsakd4R2UrL2Ztc3NKOThvbUYzUjBHSmo4a1dBYW9lMTJpQXUvdk5L?=
 =?utf-8?B?cVl1NDlWTUVveFZZU3dsT21lOUlyVXRyeVFlZHdCMld1RmoxZElycDlRNnJw?=
 =?utf-8?B?SklMdFJ1aXkxZk5UWmJJVTJtV1ZPNDlpdXZXanZMVGRlVFhEUDZEVDd4cVZN?=
 =?utf-8?B?dm9CMnFYaXZSbkJmWWtlZTFia0JzaFUyU21JN1pMY3FCdWFMNTNlbzd6bEJF?=
 =?utf-8?B?U0gwTkIyN3NvSGVFMldMRlZTdWJaWjR5blJtOW51UnI4RVdNelVCMy90dG1Q?=
 =?utf-8?B?Q0daTWlrWTRrajFlZWpxWlJLci9HUXRsbmVXVjRyYUdzY0Vpa01NM3FTWGRr?=
 =?utf-8?B?V3EvK2F0a3g2andXaWtaakxmZGxpcXNoSVJ6VXRjdXFUSlM0bE1UVGFhd05C?=
 =?utf-8?B?S1FhRnd1cGNhaVVVeC9La1VoQXFHaS9oS0dsMTdtYURXajVkRGlWeHRRUkxM?=
 =?utf-8?B?dHV5QWdEcW8rVHVJSElXWEpZOEw5bW1kbGlTSEtZc21XbmQzamZyZmNQWkt1?=
 =?utf-8?B?ZUs0TjVYQUQwc1l6bzVtYW1DV2JkeXU3MU9nSmhzYzRPdys1RnhXamF6TDI4?=
 =?utf-8?B?UWRQTXY4S3RjYUcwQWVhdUp1TDNUV3V0c0pnMVBlLzBkSktydlduZW1kUlRV?=
 =?utf-8?B?S3RQVnFtbUhlMlFyUnEzYmhRbGszOUNjTGVQVGxxNnJpYXhGY21RTUpnWjh0?=
 =?utf-8?B?N0lyd2k4N2xqK0J6NUZwbndhT2p6Y3VneHpTTVJ3Rlp1U3AybFJ4VDJJNFc0?=
 =?utf-8?B?c1lOQllWM2VTNUVOMUVuV2hFTHBVWXprc3NWWGNKdTkrc05NV0VXYmNJNFdH?=
 =?utf-8?B?MVhRM0I1REVCb2ZCcHh6OWc3MnJxOGZ4LzhVb0hyOENNeENwZW1GSm5ZSnFK?=
 =?utf-8?B?NGMrbnFvUit5d0NwNDVjNG5DTmhaUXJ2RFluUHgvNTFycTU3TGxwQlF2bHpT?=
 =?utf-8?B?N1lGSjNLSFpwVHRlUk5Naml5dnBwdlZVNDdndEd1ZEo0Y1htMG1DeHJ1cEx4?=
 =?utf-8?B?bnkzdGhXalBhczhGVE83QlZBM2ZoMjBGbXJySVg2ZWFLcHBnMWR1T1ArUFZ5?=
 =?utf-8?B?QkNvYzlKOW8wQzZhZC95Wm9YMDFHbHcwMlo3amFjM0EveTVRc29DSHlUQ3I4?=
 =?utf-8?B?NVBzQjFVZldSc1c1TG1HcU96OFM4dmxRVUcrR0htbXhYaCtMdjMxaXJSOUhq?=
 =?utf-8?B?K3Q2aU43VCs2MmRFdHdSUjFwaCtXeWh0alJ0Q0JZamRQbkQvcVNqYitKVU41?=
 =?utf-8?B?MDhPbFU4UDVGb0REY09wYTBzcW01Z3poKzZUVTVPV0FHb21tNkFjaXhPMFdl?=
 =?utf-8?B?TFQ1cnU4U2pRQ0lyaW1ZQmZ6OW5yLzRFUG9CUCt0S2NhY2pPU2djdTVIMWts?=
 =?utf-8?B?Z3ZKSWc0QjRkVWxydFUyNllaN3B5dHFPdzEyaE83ZGV2TFpkaFN3cExCVmRC?=
 =?utf-8?B?QW82dkJTRnJrOUxYN2lSN1FrT2hsY29kTWREUFIwVGVxNjExbVhqZVVvWTdn?=
 =?utf-8?B?eDhwTDJNbXQvRjJsV2NJYnRLMDdlZ1p6bTVvU0dTazAxaDdUN3lUcWFzZWkz?=
 =?utf-8?B?NWhScFRETlkwM1hLeWNWYUVnU2FldldwVVdERG1Gb0tLQ1Fibkt2MFdtZ2tn?=
 =?utf-8?B?U0tvb0R2VThMRXlndjBmYUYzTWhYbXpPaEhuc2x5dWtIQXlxMnVQd1BvTGdF?=
 =?utf-8?B?UmQ4NldZODhjRnBtTytNanhBRVB3M1E4NHJYZ1gvakRUam1Gd0tZZ0dzMjBL?=
 =?utf-8?B?OXdTOHFtQlJDUlRYdE9WNEdZQXJUeWJuYTJ3SkE4YnpiVXlqWitPdU1LaHgr?=
 =?utf-8?B?cExvcjZJTTZSc2lURXVpK1Y5K0JvY0NNRTBBU1ZWWlQ2TGN6cWVmcTlrK0hr?=
 =?utf-8?B?OW93M3dXRUoyYkN0Tzh4TEFzQkUvWXdWditIc0M5NzlrdE45WVFLL2lYNFZQ?=
 =?utf-8?Q?LBhtAX4ZMl3TajYSJ8nf3EkTv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcaa1aa-f1de-4090-eb3c-08dc20d9d7c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:51:58.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5g6s2D2fY8TXhLRbPMEO3nCOpRs34LDIeoru7gMGaVcxT4Wawg6MI2/WxBIsGuUpR2abSVWhqG3XrfrZPZn0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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

On 2024-01-29 8:58, Shengyu Qu wrote:
> Hi,
>
> Seems rocm-opengl interop hang problem still exists[1]. Btw have you
>
> discovered into this problem?
>
> Best regards,
>
> Shengyu
>
> [1] 
> https://projects.blender.org/blender/blender/issues/100353#issuecomment-1111599

Maybe you're having a different problem. Do you see this issue also 
without any version of the "Relocate TBA/TMA ..." patch?

Regards,
   Felix


>
> 在 2024/1/27 03:15, Shengyu Qu 写道:
>> Hello Felix,
>>
>> This patch seems working on my system, also it seems fixes the 
>> ROCM/OpenGL
>> interop problem.
>>
>> Is this intended to happen or not? Maybe we need more users to test it.
>>
>> Besides,
>>
>> Tested-by: Shengyu Qu <wiagn233@outlook.com>
>>
>> Best Regards,
>>
>> Shengyu
>>
>> 在 2024/1/26 06:27, Felix Kuehling 写道:
>>> The TBA and TMA, along with an unused IB allocation, reside at low
>>> addresses in the VM address space. A stray VM fault which hits these
>>> pages must be serviced by making their page table entries invalid.
>>> The scheduler depends upon these pages being resident and fails,
>>> preventing a debugger from inspecting the failure state.
>>>
>>> By relocating these pages above 47 bits in the VM address space they
>>> can only be reached when bits [63:48] are set to 1. This makes it much
>>> less likely for a misbehaving program to generate accesses to them.
>>> The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL
>>> access with a small offset.
>>>
>>> v2:
>>> - Move it to the reserved space to avoid concflicts with Mesa
>>> - Add macros to make reserved space management easier
>>>
>>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 12 ++++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 
>>> +++++++++++---------
>>>   4 files changed, 30 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>> index 823d31f4a2a3..53d0a458d78e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>> @@ -28,9 +28,9 @@
>>>     uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
>>>   {
>>> -    uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>>> +    uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(
>>> +        adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>>   -    addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>>>       addr = amdgpu_gmc_sign_extend(addr);
>>>         return addr;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> index 3d0d56087d41..9e769ef50f2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> @@ -45,11 +45,8 @@
>>>    */
>>>   static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device 
>>> *adev)
>>>   {
>>> -    u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>>> -
>>> -    addr -= AMDGPU_VA_RESERVED_TOP;
>>> -
>>> -    return addr;
>>> +    return AMDGPU_VA_RESERVED_SEQ64_START(
>>> +        adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>>   }
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 666698a57192..f23b6153d310 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -135,11 +135,19 @@ struct amdgpu_mem_stats;
>>>   #define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < 
>>> AMDGPU_MMHUB1_START)
>>>   #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < 
>>> AMDGPU_MAX_VMHUBS)
>>>   -/* Reserve 2MB at top/bottom of address space for kernel use */
>>> +/* Reserve space at top/bottom of address space for kernel use */
>>>   #define AMDGPU_VA_RESERVED_CSA_SIZE        (2ULL << 20)
>>> +#define AMDGPU_VA_RESERVED_CSA_START(top)    ((top) \
>>> +                         - AMDGPU_VA_RESERVED_CSA_SIZE)
>>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE        (2ULL << 20)
>>> +#define AMDGPU_VA_RESERVED_SEQ64_START(top) 
>>> (AMDGPU_VA_RESERVED_CSA_START(top) \
>>> +                         - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << 12)
>>> +#define AMDGPU_VA_RESERVED_TRAP_START(top) 
>>> (AMDGPU_VA_RESERVED_SEQ64_START(top) \
>>> +                         - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>   #define AMDGPU_VA_RESERVED_BOTTOM        (2ULL << 20)
>>> -#define AMDGPU_VA_RESERVED_TOP (AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>> +#define AMDGPU_VA_RESERVED_TOP (AMDGPU_VA_RESERVED_TRAP_SIZE + \
>>> +                         AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>>                            AMDGPU_VA_RESERVED_CSA_SIZE)
>>>     /* See vm_update_mode */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> index 6604a3f99c5e..f899cce25b2a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/mm.h>
>>>   #include <linux/mman.h>
>>>   #include <linux/processor.h>
>>> +#include "amdgpu_vm.h"
>>>     /*
>>>    * The primary memory I/O features being added for revisions of gfxip
>>> @@ -326,10 +327,16 @@ static void kfd_init_apertures_vi(struct 
>>> kfd_process_device *pdd, uint8_t id)
>>>        * with small reserved space for kernel.
>>>        * Set them to CANONICAL addresses.
>>>        */
>>> -    pdd->gpuvm_base = SVM_USER_BASE;
>>> +    pdd->gpuvm_base = max(SVM_USER_BASE, AMDGPU_VA_RESERVED_BOTTOM);
>>>       pdd->gpuvm_limit =
>>>           pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>   +    /* dGPUs: the reserved space for kernel
>>> +     * before SVM
>>> +     */
>>> +    pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>> +    pdd->qpd.ib_base = SVM_IB_BASE;
>>> +
>>>       pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>>>       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>>   }
>>> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct 
>>> kfd_process_device *pdd, uint8_t id)
>>>       pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>>       pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>>   -        /* Raven needs SVM to support graphic handle, etc. Leave 
>>> the small
>>> -         * reserved space before SVM on Raven as well, even though 
>>> we don't
>>> -         * have to.
>>> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so 
>>> that they
>>> -         * are used in Thunk to reserve SVM.
>>> -         */
>>> -        pdd->gpuvm_base = SVM_USER_BASE;
>>> +    pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>>>       pdd->gpuvm_limit =
>>>           pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>         pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>>>       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>> +
>>> +    /*
>>> +     * Place TBA/TMA on opposite side of VM hole to prevent
>>> +     * stray faults from triggering SVM on these pages.
>>> +     */
>>> +    pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(
>>> +        pdd->dev->adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>>   }
>>>     int kfd_init_apertures(struct kfd_process *process)
>>> @@ -407,12 +415,6 @@ int kfd_init_apertures(struct kfd_process 
>>> *process)
>>>                       return -EINVAL;
>>>                   }
>>>               }
>>> -
>>> -                        /* dGPUs: the reserved space for kernel
>>> -                         * before SVM
>>> -                         */
>>> -                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>> -                        pdd->qpd.ib_base = SVM_IB_BASE;
>>>           }
>>>             dev_dbg(kfd_device, "node id %u\n", id);
>>
