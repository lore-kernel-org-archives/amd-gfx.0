Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA3C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 15:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046D589361;
	Mon, 11 Dec 2023 15:56:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5479A89361
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 15:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQAK4rf4UJaVI9iG+YRl4aV0E5zMzoRmMtBKE0MwU+v3LqsZ98k1LtssQ2WByRkTCIAnGe7nfgkeBbS7NwnrJL1Fioj40w2hjQEh1A8bRv3Hu63BJH1uhEDvZUBfqx1+/q+If6SlqGeKPletUc60dgq2FxoIOQCweaRNnC+COI3HC72P0lPXzOV03y8BheEQlSkvdxekn3WMiG3lXpDIFDPJeiFP8GBjIz84fsUCXv7d6OjAWmvd6g3X23yVcDyyemIDyEUMmNqiUXN71cjS8bsHIrwsGKls87MJ6rZO/O9dg5BRKGMDoJjXVHl2THhdq5Sz51sYLOENKzWZ/1NMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIP32FsoUlNfU7r1p4Ae9+el3jyPDuRskyqdbsixoC4=;
 b=HfMHn6uBh8KpADTYxVeSGdgqyay01X8MuuesMlF2Eq8sV5QF3TYrUOQ7LW4RHUbbGaNf1ZrkGEd5KR/GKHaer2SbfSaZvP6M5/5EP8fqLEXqI0CXUsfNC09m0JJY42ccbY8oU/OfZhuM3azW8NKD5kRpk59oXL4YjKR7EkN2Rh9nq3O34foQyPtRs/o9olAfVMFrltBMnWihFI07z9Dzqun/F0QFgPUJCf5hrlPekynR0SHXnmk4EapN9JczgFzFzzTbhz0kf13RNUSEXTPivCeIsmpnotkbYch8HgRzrvQZIeoEp7+WdxBksd8L6UzALUsbLslUFnw0mkVFJAeeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIP32FsoUlNfU7r1p4Ae9+el3jyPDuRskyqdbsixoC4=;
 b=ci6KjmE9Nu5a1OzSUNwDcxiEy2BuEDh+QleuGK8zC1KhPQDB6X8SSioHj3wbzaBYoyY8sjAADi8g4F0yAMVa9IUyPJsQLK6DZCO/2XutUN/iRS8Y4cIktVbtZSsz/EyOGE3bZ0BmI1kZQGgrOl8e9rjCoRX1BqkCmYpnaR7qEVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 15:56:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 15:56:15 +0000
Message-ID: <7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com>
Date: Mon, 11 Dec 2023 10:56:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix sparse __rcu annotation warnings
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20231205222026.2108094-1-Felix.Kuehling@amd.com>
 <e879ea47-4281-4830-a4db-5a144999198a@amd.com>
 <a6411c81-d0ea-4002-bfc6-a725a83eb9bf@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <a6411c81-d0ea-4002-bfc6-a725a83eb9bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f4b2f0-0d65-418c-640e-08dbfa61b497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaetQ1GDZeZ3tS1R2MrSd4uXfxBUrVNVcXPn2o1Ij2h5E4tHFTogvvyvXNGZrOE7ZU4v+1AsTlleGBSUJWxK+jbK4nKhyzD6pgx9PnnrmE9GWW8ODVqzXYXroScCnhXbDzpIo2uT3BeL+CJG37v9rplG0daIoxV5hQ0iVwhJPGV8gNuEatGnSWK97dtlqay8zoMlo0jSDD/+QT2bieDiG9duSiG45g+OE7+lqW0g4NI7M6k42tqH8AL0lhbeFeofajUezp4fkX24HPNQ2EOoEffKmwsLAVyw6sXmjkitYDsFr40iNdL3ygWCGoy/2vIvbTPTIfoaBD3riknqUyR4nqCpwVE8K4I3HIejEs8mc0xLWY/yY8eSZQbb/64MQSPi4pK43LhrODlaUyLR4B74NZghYX01FABzLCv0BivXFOpfcy5+G4ygXh9duK7jCiZkRZl0pN6GZnHRQ8aR8EgsrMVBUoK7lWjM0iypWwaUP95CLCgFhkYODv2SxtNm+tyMth0fvRFrQdXO5I0mSy43krZ0TFUfUMZH8/ECYDuwNVyi/hd1a8/kZNC60KJUEiuKNh0xEQC26xyCronretMjLS4cOZoxTqqcVbf3J/hXOt59ZVX37tTzsAb2RUNr+7yF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(66574015)(26005)(83380400001)(2616005)(86362001)(36756003)(31696002)(38100700002)(44832011)(5660300002)(316002)(8676002)(8936002)(4326008)(6636002)(2906002)(6512007)(6506007)(36916002)(53546011)(66476007)(66556008)(66946007)(110136005)(966005)(478600001)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFVkanRPcE9IVyttNUo5WTdNdS83MFgwOTRzaW1Icm9sV2lEdlZXc1NkN2U0?=
 =?utf-8?B?M2VsQ2s5bmVDNkpKSmllejFVTEQ3NmltaVNpUkZVdHJPRExPZ2RPL0xKQkIx?=
 =?utf-8?B?b2krRmFJa21hR2hNRENwUEdVUlZuK2Y1aGswVUJiTGx4RHBrQmpSdjViYWQx?=
 =?utf-8?B?MGk0L3BoQXlsVHh5NVRKa3kvSlVyNHBaVlp6OVU3N2Njb1d3QUJDOWFEZXd1?=
 =?utf-8?B?bno3TjJnV1pnMzVNZ1FxUE0xaVUxUGsvOUJsTEpkZGNiL2tOSVJhU2VWWlFW?=
 =?utf-8?B?Y3Avb1FESVZYMlJueFlvWm5oTlFHQ2NBdHZjR3Q4M1J4OTUyMjFFdEszWTcz?=
 =?utf-8?B?bzRYMm9qU0c1c0E0RkN3Y0VtWkl5dUxMdURDMHQ3Mis5cHJHdTBGRG10TEg5?=
 =?utf-8?B?UjZEUVZlbzN6L292bXM5Mnh0NlYzakNub21ncDlVd0M5VmgyS1BqSWxTY09V?=
 =?utf-8?B?b3l6Y1loOHdkUWhsNDFRbnVGSms4K1NUQXlSNndxbFRRYlBLc05KaDlZL3VW?=
 =?utf-8?B?OExMazNWNWhQZlJSNyt1VEN1cGVmbitrUFVtZ05SalNiNS8wd0pBSEdQVjEw?=
 =?utf-8?B?UWw1S0xvajJPdC9xYWQ2UFMxc05zeEhPa3RWNm5qRk90NWsyMkxIb3FLRmtq?=
 =?utf-8?B?ZFVsc1VnZkxObXJpK2lPV2VUMjlKVFRYamsrQnQ0N21iVmE1MXdYb0FqczlU?=
 =?utf-8?B?WFovVFMyRW53amdNZVZWRy8zOVFzNU1vNEFiQVpsbGovRmRGbkM4Q2g1djRl?=
 =?utf-8?B?NVJZbHNtM2dPTDdnaksvOHE4ZHNMOW1WbUJkb0cyNklqVWZRQlhBaXFiUmxV?=
 =?utf-8?B?RUJ6ZjVUNGN5VnQ1ei9XY1Ztc0tVWjdQSmZneHFzVzAzTTJ3U2NocXlycUND?=
 =?utf-8?B?MU9CTzNZMFBSaEk0UnQ3RUFrd0RvV1crc1lDQmJ2R2krcnF4WmZSZjVSdDNI?=
 =?utf-8?B?R0FreGFNTGt2c0d2KzVJV1JxUElhR3I1dFhPSzhxVnA3OXlzalpkc1dQZ0FQ?=
 =?utf-8?B?UW5XcHo3YitDcGZoRVFhL05jMElHV04ray9iSEM5M3kySUhZK21RWVZaTXdY?=
 =?utf-8?B?aUNXQzY1ekQyaldteEMxZ3UyeFl3TTd2OEJkcHZvTnhRdzFDWE1LMUN5Sml3?=
 =?utf-8?B?ZjJPYzJUUnJTM2ZpNTdpVkFpUHJIWHlOWFdCRllFYXdYckVzdVFiUldaVzU4?=
 =?utf-8?B?Qm9qNXowZ1VzL1ZSZmtHQWU2RCt4dEh5RWE2L2gyWEpFNVgzR3pZb3pVd2Ny?=
 =?utf-8?B?UXFvMnBSQWVDVU9qYXJ2eTZwUWtCaFhBVHFDWnAzUytYSEFJd1FvanJSaDdH?=
 =?utf-8?B?Tm5LRFlXOGE0M2FSYkxwMFoxb0JJc2lqUEVjemhaVFZKNnpaYlhoSHI5R3Fn?=
 =?utf-8?B?WU1kQUMzUEh0dHRIbGphNGZlZGhqQUkyYkN3ekhLaXBtWFR1dERJR3hkVjBB?=
 =?utf-8?B?bXJaTkF1MEY0YUlJYnBaVU9OSWw5QWRlVWYzcXFHbXR2TWlhQTNMUDZDME1t?=
 =?utf-8?B?dEdhaWhoeTVzU3dkSFZIQ05sZytGbVpMT0srb0wzSmJ6WnpuUHNmOEJiVzNp?=
 =?utf-8?B?YUF3ZTlJbXl5WnZFS1RxYS84RGtOeGx6MXV1SDZQKzNiWUVQZE9jdkF0UFZZ?=
 =?utf-8?B?RHNRYVJVM1B0T1RBbmNXeGo2MC85QXEraVBRTkxpSFo2WkN5YjFBWXd2QjlU?=
 =?utf-8?B?UTFYRFZOZ0xaVHpySis0TjRkRy8xYnZPVzlUalN6Q2ZlOEVhRkp1ZGFiWlVX?=
 =?utf-8?B?WlY4NkhhOU81Rm13L1pGU1Z3Y1Bvb1JsWUpjNWVJSkdwSFRiOFpUdmhrVGRH?=
 =?utf-8?B?TmZpMFBNcEl6dTY1Tm1VclppUDVvcnFHSlVmSnBVRG5UM25HaVpTaWtYVStj?=
 =?utf-8?B?ZXFQZUtqTCtwUURMdWFoRDlXd01sbXBYVVE0WjlaYVBXVHJUVGlYMjZ1engw?=
 =?utf-8?B?K00rcGVaVjBEOWV3YU50MndETnNFRUJsV1VFQWNGNlkvT3ZyVzZnNnh1RlBT?=
 =?utf-8?B?MWVyWkVsZVlycUtVWGxkY0Y0aFB6RlNIc1RKVnpsVUFQV0ZHN3h6Yzl4ZDJV?=
 =?utf-8?B?M0E0c0VLT1cxQ0NyWGJ5dDYrM0lLYzBGY3E1clNqKzhDSEN1U0xVdUloRVdr?=
 =?utf-8?Q?GVT8whb0VvW+A3QD9FjGPD3Tl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f4b2f0-0d65-418c-640e-08dbfa61b497
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 15:56:15.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI9x/k3twn/9guEtbt8AWwgF9vkec1/hzuVrlghqwZybwTgyEMAIOZvbTtyZLC65S2vC4WG7dIEYmF/UwvJNbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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
Cc: linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-08 05:11, Christian König wrote:
> Am 07.12.23 um 20:14 schrieb Felix Kuehling:
>>
>> On 2023-12-05 17:20, Felix Kuehling wrote:
>>> Properly mark kfd_process->ef as __rcu and consistently access it with
>>> rcu_dereference_protected.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: 
>>> https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>> ping.
>>
>> Christian, would you review this patch, please?
>
> Looks a bit suspicious, especially the rcu_dereference_protected() use.
>
> What is the static checker complaining about in the first place?
From 
https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/:

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: sparse: incompatible types in comparison expression (different address spaces):  >> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
struct dma_fence [noderef] __rcu * >> 
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
struct dma_fence * ... >> 
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
sparse: incompatible types in comparison expression (different address 
spaces): >> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: 
sparse: struct dma_fence [noderef] __rcu * >> 
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: struct 
dma_fence * >> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: 
sparse: sparse: incompatible types in comparison expression (different 
address spaces): >> 
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: struct 
dma_fence [noderef] __rcu * >> 
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: struct 
dma_fence *

As far as I can tell, the reason is, that I'm using 
dma_fence_get_rcu_safe and rcu_replace_pointer to get and update 
kfd_process->ef, without annotating the fence pointers with __rcu. This 
patch fixes that by marking kfd_process->ef as an __rcu pointer. The 
only place that was dereferencing it directly was 
kfd_process_wq_release, where I added rcu_dereference_protected. The 
condition I'm using here is, that the process ref count is 0 at that 
point, which means nobody else is referencing the process or this fence 
pointer at the time.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Thanks,
>>   Felix
>>
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 6 ++++--
>>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index f2e920734c98..20cb266dcedd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -314,7 +314,7 @@ void 
>>> amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>>>   int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, 
>>> struct amdgpu_bo *bo);
>>>     int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>> -                        struct dma_fence **ef);
>>> +                        struct dma_fence __rcu **ef);
>>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>>>                             struct kfd_vm_fault_info *info);
>>>   int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device 
>>> *adev, int fd,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 7d91f99acb59..8ba6f6c8363d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2806,7 +2806,7 @@ static void 
>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>>       put_task_struct(usertask);
>>>   }
>>>   -static void replace_eviction_fence(struct dma_fence **ef,
>>> +static void replace_eviction_fence(struct dma_fence __rcu **ef,
>>>                      struct dma_fence *new_ef)
>>>   {
>>>       struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
>>> @@ -2841,7 +2841,7 @@ static void replace_eviction_fence(struct 
>>> dma_fence **ef,
>>>    * 7.  Add fence to all PD and PT BOs.
>>>    * 8.  Unreserve all BOs
>>>    */
>>> -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>>> dma_fence **ef)
>>> +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>>> dma_fence __rcu **ef)
>>>   {
>>>       struct amdkfd_process_info *process_info = info;
>>>       struct amdgpu_vm *peer_vm;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 45366b4ca976..5a24097a9f28 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -917,7 +917,7 @@ struct kfd_process {
>>>        * fence will be triggered during eviction and new one will be 
>>> created
>>>        * during restore
>>>        */
>>> -    struct dma_fence *ef;
>>> +    struct dma_fence __rcu *ef;
>>>         /* Work items for evicting and restoring BOs */
>>>       struct delayed_work eviction_work;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 71df51fcc1b0..14b11d61f8dd 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1110,6 +1110,8 @@ static void kfd_process_wq_release(struct 
>>> work_struct *work)
>>>   {
>>>       struct kfd_process *p = container_of(work, struct kfd_process,
>>>                            release_work);
>>> +    struct dma_fence *ef = rcu_dereference_protected(p->ef,
>>> +        kref_read(&p->ref) == 0);
>>>         kfd_process_dequeue_from_all_devices(p);
>>>       pqm_uninit(&p->pqm);
>>> @@ -1118,7 +1120,7 @@ static void kfd_process_wq_release(struct 
>>> work_struct *work)
>>>        * destroyed. This allows any BOs to be freed without
>>>        * triggering pointless evictions or waiting for fences.
>>>        */
>>> -    dma_fence_signal(p->ef);
>>> +    dma_fence_signal(ef);
>>>         kfd_process_remove_sysfs(p);
>>>   @@ -1127,7 +1129,7 @@ static void kfd_process_wq_release(struct 
>>> work_struct *work)
>>>       svm_range_list_fini(p);
>>>         kfd_process_destroy_pdds(p);
>>> -    dma_fence_put(p->ef);
>>> +    dma_fence_put(ef);
>>>         kfd_event_free_process(p);
>
