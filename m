Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECE4C00A8F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 23:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF9710E2BA;
	Mon, 23 Oct 2023 23:39:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0B810E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 23:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V31kIOwY1ooCICSoqR1PwTEwc0voyVjZE4uY4i2fxklHkGj9aOS0FTT3L2GC6mXRObmOAK1yTvMdOsi2fnECRMlyM3r2rSt74KjVg6kB2oPlEKvBebUMQwZrzZ0Pl29KRkGAX2sZzWTqdsoFOocB/lw+ZsPhoXZtciV/2pQenVhGh2ATIuQA1rkJErKcrHWPNxtYmcyE8Cya1vgS7IBWVd/yPKvqIkjY9kojlXcLqE5T3OeR5RDPh82cQvliA4ReUXwqTDm3bm3Q7z/iF6QN+ovGVx8hRl2F4ZF1w4K8rWmXSfkHWVncLygnPSdFBBW413gxiYYUb6K5mvREcQWbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJNcjrbdkKJHOFly+jky11GC7udBARMo1JK5Xsqg5/g=;
 b=coPeLMEDQkpjJFagPRDI6k5cvZICI62MPidJJIZAoTlEgX5lfWfxZvceJ/nz0RJ6px0vTWF823MS+XZQJyWcxua83AgKI1WM8aIoUxwNtJ9WzjYMsTHzuDjyTyLruz6AvWbPGX8Xf3GXC8W/41RDkUYE6lnAFEDrjPhVNKjD4JwANyetwzQRwbgnPCxulRqMSMu79Hy8YQFRG5HT73QYK/ep1h1LXu80VrFgbvbE9MSoyP9xfMv505KWQD7bAELq5RZbwpGz9fCr7O9CheiYBGMfaFl6Y1cKFdrm2tBFJLMppb76hSsqUSAZHCv2X/LpBw9620eISAJQugRsLiTBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJNcjrbdkKJHOFly+jky11GC7udBARMo1JK5Xsqg5/g=;
 b=vGMUO3DZwlZ1TxCi/sGi/Hnm5nllMxXh5NrqNw1/ps3WQhvRxR6JtBRyH+kGBS9YhRJ80jTiDYR1DiqNG5WkkqwvQ1uYvQPpuChwTSvc+qnkj1BjwgVAVPXBVUPLTnaD2fjiAuTZGxyYg2MIEkf37ka587Xmgm2vQPdabPQNDaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 23:39:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 23:39:27 +0000
Message-ID: <651b8d49-9fb1-461a-b9ed-5ad4d0b0ecf1@amd.com>
Date: Mon, 23 Oct 2023 19:39:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute"
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Daniel Tang <danielzgtg.opensource@gmail.com>, amd-gfx@lists.freedesktop.org
References: <5984374.lOV4Wx5bFT@daniel-desktop2>
 <38742906-869c-4bc6-9cce-ea3ea98873d4@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <38742906-869c-4bc6-9cce-ea3ea98873d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: c2277fdf-ac1d-4317-ea61-08dbd4214bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6X/l2sUWkPCdIKOJ4TkPpAvjCWwP95qx+LvJG5o81VbB4ytT4rrle1zktUOjCIhQEDODKmcNp0+db1DalQ6ftBKh04PM3Ze8HXzaA5RzrH6saGAzMWHmlt2F0jCIdWrJGgOupDjQTnOt8d1auwdEkVnNFTrxpDxkY0ius4F8ZshZHH9xRsvoOsC/FSnkg5vGgTFVeCRDBfe6iTDcgLWHKxMjSHL44AY4qNWCFZyABV3G+Rzm0Tdvqg2HN4qFekA19/RLJ8f50MIOq0gMTFw8w8bq8RY9Wyqn2kHxgvDKzWeH+qAGzes9DsZQsr4PTJBisfiq7TPUxNWWeuiEAwXHxM05XxEtSTYaXh16YHkqeGxhB+rvkORyS1V3D8GSSkGJw2sMO3vkuD/d2bSCXcDGgqOXlaz2sGTzHFjjrJo6ESQXiB2ip+SVCk2F9LxEP5Lt6x3QYlrp/XaNYEscUfdY2pD4d5zJuo/opgpivdERjgtSMynKsUzS53vsFt7xw2hbx5XN5H05pzLmlAv2A+7Npbo2Iv0nTyeq9QWh+Vh/rnm36gi1cTs4drsJ1zOe1feINf0GWGR6m3RnRmMrBxaWOdgm67+6MKTTau/fiJLWT3bG+fcvbSOEaJrPVNI+mH4jaUsyrDcCp2wqqBfTlw82Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(31686004)(4001150100001)(38100700002)(2906002)(41300700001)(44832011)(86362001)(5660300002)(36756003)(31696002)(4326008)(8936002)(8676002)(2616005)(66946007)(6506007)(54906003)(478600001)(110136005)(316002)(66556008)(66476007)(6486002)(83380400001)(6512007)(66574015)(966005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRxcTI2QWoxTEh6NzhITXMvV0dnem1UNGNhcU90YjBnTmEya3dqZ2l2Yzl4?=
 =?utf-8?B?aE9TRlJEQUw1WmFXVHlJV3V2S2k5WVVjOG5DQlY0TEhSOTlxcjREVGZ3a2Qx?=
 =?utf-8?B?YnJjaDdmUEdFOW1uUGJNWTBaWnJFU0lxOSs5MmZzWWpYbVhQeURUNkpUakFQ?=
 =?utf-8?B?T2tXVVZOeGlWWUdnWFgwU1J5dWNBL2FYY0FJZ0R2MHFld3o1ZEdZV25yZmVG?=
 =?utf-8?B?K09tRHRVekhNTjd5UjNZSVZLdWt3MjU2ZjRWbmJjODBHUjNQcWFkN29MWEY5?=
 =?utf-8?B?K0NsVys2eUpwREFIcVFqTExvYUlhc01xemd2Y1VGMjNIQngrWnkxSjZEMWRV?=
 =?utf-8?B?b1Qxc2R3bG5yUHZaNXdyKzJLNlA5ZFNrcFRWOGtCWitOQVgwWkpmM1Vvam5p?=
 =?utf-8?B?L0orYkQxWlRDWnFzc2JHeDliNkI4enVnMzAvem42YnZJdktKNG5DRllrTlI2?=
 =?utf-8?B?Tmx0UzBPc2dsSUo1cXFuekxYNk1UREFoQzV6SGQ5VjMzQlllYkY3aHh0cWlS?=
 =?utf-8?B?ZHU5YlhQZGl5R2pIbVRWR2VScXZCL0phaDY3ODRwNFYrVFhPY1U3ekpQeEw4?=
 =?utf-8?B?TVg1ZXpybGZUbitneWZsT09jRkx3R1BrVmZuTmdZRzIva1EvUmxsNjNpcE9T?=
 =?utf-8?B?YVRCenBsbXA5MlN5aE43cjExeWtsWHlmYTR3Ny8zNlV3UmVjYlMrK09rM1pH?=
 =?utf-8?B?UXo0VlEzRm9KRG40YmpWMGJlQjh0SVpOSS94M1pTUEMvWUNaOFdiV1J6STlH?=
 =?utf-8?B?SFVHcUIxSk9tRHlxdUE1MzRhaVdpY252Y3dLeWpiZG1mTFh6K3RNbVVURmVM?=
 =?utf-8?B?V2ZQcDJsZmtBNW8vRkNIYlNFZ2ZFNkk2amZOcVZrL0VkTS9IbDN3SE5SWFMx?=
 =?utf-8?B?eHZXK0JWc1NmTndzSWtQWFpoejd6eVgvaUtrU0taTTBFZUNGMFIwZ1VVMzFT?=
 =?utf-8?B?T2lNakhkVnVuY203ajc1OW9Tc1R0UEdkZTJMRytlU1VrMzRPZm1CVXB4Z2cr?=
 =?utf-8?B?Z3J6SzFyT3RiUWNXUUYyWGVETkE5eWJLY0FNNk9oY0UrS1JMT2tvaVUwVUZv?=
 =?utf-8?B?S2w1SnI4alNzQ2VYalRlbldsdnYrcnlhY1J2eS91WmhGNGNVN1JucHNjcE9a?=
 =?utf-8?B?dEdybjhwZkZJeHZraXRPRHNHKytpQ0NyaHV1UnFTMXFsVWpDVnQrSEt5YkdE?=
 =?utf-8?B?WkExTnY0WWh0R3FxdnhabTZWSXArYk1WT3ZHdTFTMXNkRXJ1Tzl5cUpmK0Jp?=
 =?utf-8?B?RWpNWVQrVGJZMHUvQlNZdVAzeG11NGZJVWwvQnV1TGhGc0JGbzBqSlRNOW4z?=
 =?utf-8?B?WmMrS2VPVllLMXhwVHVlS1FvRkI3ck5NL2E5Uk5TR3A0NG5lTnp6RUc2eXFT?=
 =?utf-8?B?UVUyZVVPSTlCK1ZqNXBKTVJsOXQ4RUpoUVowajJ2ZktzL3M4cCsxdjQyWWtz?=
 =?utf-8?B?cmhHbW1CRmpsWE1sSk1VR2JxNG1xaVNpNlNTVG9SSjA3UEwzdFdQdEFwWi9V?=
 =?utf-8?B?eFZaajZoZjkxQmJpNFphZGJub1JocWNFSjN4Z2NxTng2N0dGVC8zODcwNXN6?=
 =?utf-8?B?azFXU2piNmdVUzAzemxMQ3RGRDVtM0hxR0JkQkN2aFRYTjdDa2lobjMxUUNa?=
 =?utf-8?B?c0ZHSmVFWEwrUUQvcVBBV3doUURMZDAxdCtzSEUvTHl0TkV6WWk2bXhycGFl?=
 =?utf-8?B?N3BuZGJiNHYrZWxNVHU1byt6bGszdVdyNDQvYUVGbndwTjd6L2lKa2dPQ2hl?=
 =?utf-8?B?TGIxMk5yOXhiajJvSVJCVnU3MmFzVER2MVhiTWlhd0pTRDFDYmdCY2N0R2Mz?=
 =?utf-8?B?NHp4SW9XYWZucHdNeHJaMHFmUytNbUJPcmI5UnBjZU0xNnRtc0dEYjhzMjVq?=
 =?utf-8?B?ZnBsbXFtQ0VCektpTW0xWFZjTVl1ZGRSbFJzSXl5U3FrR3lZc3RjRHJSbFln?=
 =?utf-8?B?bHNDSEsxVUJ0TWwrcjVnYm5JOUJ3WlhNTHViS1pUK0Q4ZlljVk9MeFkrOFBK?=
 =?utf-8?B?bUxCVzM3bUI4TEsxZG5HajhVckpQT292UHNNMldoTEdBVitjWjZLK3JVV2V4?=
 =?utf-8?B?ZHdGT2pLMlJueUYxMUx6ZzV1T09LMzZHYXlBZTF0VFZvdmFhUWh4TERrbVpa?=
 =?utf-8?Q?m19ATv44pfOPbj0nl7rmqQwhc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2277fdf-ac1d-4317-ea61-08dbd4214bd5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 23:39:27.5406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFiMBWeEWP+IfuxgD3C8oAK7Xv4ZfVJ9QIIYZEs5xvsKZDFqkevy6Rk4xi4+x5pNuJCTNZQwkLg8q5LVW1l1ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-10-23 11:15, Christian König wrote:
> Am 23.10.23 um 15:06 schrieb Daniel Tang:
>> That commit causes the screen to freeze a few moments after running
>> clinfo on v6.6-rc7 and ROCm 5.6. Sometimes the rest of the computer
>> including ssh also freezes. On v6.5-rc1, it only results in a NULL 
>> pointer
>> deference message in dmesg and the process to become a zombie whose
>> unkillableness prevents shutdown without REISUB. Although llama.cpp and
>> hashcat were working in v6.2 and ROCm 5.6, broke, and are not fixed by
>> this revert, pytorch-rocm is now working with stability and without
>> whole-computer freezes caused by any accidental running of clinfo.
>>
>> This reverts commit 1d7776cc148b9f2f3ebaf1181662ba695a29f639.
>
> That result doesn't make much sense. Felix please correct me, but 
> AFAIK the ATS stuff was completely removed by now.
>
> Are you sure that this is pure v6.6-rc7 and not some other patches 
> applied? If yes than we must have missed something.

This revert doesn't really affect systems with ATS. It moves the sanity 
check back out of the ATS-specific code.

The Null pointer dereference in the bug report comes from the CPU page 
table update code:


This revert is just a roundabout way of disabling CPU page table updates 
for compute VMs. But I don't think it really addresses the root cause.



>
> Regards,
> Christian.
>
>>
>> Closes: https://github.com/RadeonOpenCompute/ROCm/issues/2596
>> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 82f25996ff5e..602f311ab766 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2243,16 +2243,16 @@ int amdgpu_vm_make_compute(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>       if (r)
>>           return r;
>>   +    /* Sanity checks */
>> +    if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
>> +        r = -EINVAL;
>> +        goto unreserve_bo;
>> +    }
>> +
>>       /* Check if PD needs to be reinitialized and do it before
>>        * changing any other state, in case it fails.
>>        */
>>       if (pte_support_ats != vm->pte_support_ats) {
>> -        /* Sanity checks */
>> -        if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
>> -            r = -EINVAL;
>> -            goto unreserve_bo;
>> -        }
>> -
>>           vm->pte_support_ats = pte_support_ats;
>>           r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
>>                          false);
>> -- 
>> 2.40.1
>>
>>
>>
>
