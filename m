Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C52C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 12:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA3410FB5F;
	Thu, 13 Jan 2022 12:18:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A61310FB5F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 12:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9g/myEz6ANibHSCiRpjpWVxwjffriawkva6Vce/WfCTyMhaKiZxuYsy9d8kqZGAjRB7bnaZqW/ilgyACtyP8emzrt75HFgtwozFbBmamilnA6/tH5wZqSk2rNpVT9LJnLxp+4vcEmY/V18s1OkcMRMR5WGNETxSJPfzxG7DZi1sNp5vfA2X5lfAMhIUnr+BNVXJklhSzTP1hRQprW1VytpLdFrDKImcFXEc4HaHTf8HV+F9FQMq1SJfUQfCVvz7KnT+t3otBmTO4In9tFZIOvI8iuVfBrQU5B0nKdX8MGmKSD+ICQChkWoxESS8PBElHkRs5OmeXBLhl8aAMhc6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqatTIXqzxqY8vZLDGlWlDKLCT6yJr1GCoXlDvL67oE=;
 b=kMp3JLJHZt0081HDsfT8oDwefgXa14ZrEUfuDQWDIQYrcojoEn1Q/Am0Z5vt4hTh8beE0S0VZTeWJroBiSAbJGp97j3RMTU3x1DNE0DEvHb38yI4OOOEcgV8F0C+yEwTjJy0OFssCxGkba60zpvLThrP/RMfYO85M0z2q6XxZmtq3taMcabgW99lUtSlE98zkp9wiQmYgM1/PWoQuPkepUUiyqAkGkO6qy5xLMPUBOBRHijhwwnH01iDMO0BDmk2uPS4gq/IoEc0FB0JFXZ34pnwdHcAqgNJFaVUXV0U+/CaWHGfPnCkpBtTrningoGv/efG94+MEYZwkmfnKlvicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqatTIXqzxqY8vZLDGlWlDKLCT6yJr1GCoXlDvL67oE=;
 b=Lmw06cgWpiFMyPPDj7/QeKsjBOCxdMW4OaJ5bQOFFeUznyYoZjIerxGqUOyq2pYReP5U6CakLU0lmWBtzIDf/Rs8efSKPoMOaucTrpgPzPyF7MSlUNMi367wQ+6sxRHM8cgFyICsThp0nzoYsofZ+ZU8HKINWkAaN8Zmpl3+ZVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 12:18:39 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 12:18:39 +0000
Message-ID: <f63350f1-7c2e-bcf1-811c-deac75e22db6@amd.com>
Date: Thu, 13 Jan 2022 13:18:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/1] drm/amdgpu: move bo_va ref counting to internal funcs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220113120635.7475-1-nirmoy.das@amd.com>
 <2d7964c4-9d90-25df-4234-6fbe0d66c174@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <2d7964c4-9d90-25df-4234-6fbe0d66c174@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::30) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a4d661e-fbb4-4783-cdfe-08d9d68ed498
X-MS-TrafficTypeDiagnostic: BY5PR12MB3873:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38736467BA89242C16E0A3A08B539@BY5PR12MB3873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4u9FCDMkvu6W/nD3+sylKV/Irh0y3t+5f/HZ8AJMIAIc91GXk9xyf/ZGbjjVVVK/69zXY3FdZQxgNT1ul0naNOW3+6VHWCO4wP8wNJd5Tp97yiYtC/ZWQ8tDvGK5CqeIyEcDQEcS3Nkr2e0P4VRZmIWfZkonYv0iZoSyX+fwNd9LLF+vK2fnz+bShWH3EEzTahwFqSXUd4GiY563pMc93Qszfls5B6nRxzUpozLwIir/f87kPckXzE+3Ghl8DktRVFH+jzXCmtOkTEqJz7uwdBidB35uF59iUZDgDLTHFDI8H0E6xhwRUZrG8jlEDudrz+vXeCrnSM1LYZydOjE/GtXOwNU+llxOphvXmNT/KIyUftDiz5mvGYZhTg27aNwJjeCbQAmUcrE/lFV9xSw6g5zodQld193qwO44k8nk+MAnmudCmIHK0rB+8Z9yQgmC5blrFVPcSykL8nkSUfykuaJfsDP+AteoOtAIsvd94CKEQ8YyTO5T/mqanHieKHX1jwbhXVoEyXqGG+uvmZPjNK+wkCytv6kMSXj7AIB5sUMcfa5D9DxgsobS5Nr0zYIDiR8mSN9hh+M4VNBto68Vty3UR2UCUmEFFp48WsZ2BTmrHe5s+VaGz9QQJpNKmzJ3v/ASGetAxOXgJXAUVaKX7aTeebOBC7UzJ82LlEZpLUr9fzbkCL2oZvpRLtLJFvm3dBfwjkPXJ2l3wK8KZpkhYoqDknR6j4XmLQt48YsBC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(5660300002)(31696002)(508600001)(53546011)(6506007)(8936002)(38100700002)(8676002)(83380400001)(6512007)(316002)(4326008)(66574015)(31686004)(6666004)(66946007)(86362001)(2616005)(26005)(6486002)(66556008)(66476007)(36756003)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTg2Y0hkQmlvR3k1Vm55WUd6UmFSZVZISVpleHd3akx4SHpXMVdCVndvTWdC?=
 =?utf-8?B?SDVBYitWYWVJakRublp6WDdjeWJwWXA2Tk9selYwUks5NTJUbGpBdHNaQlg4?=
 =?utf-8?B?OEF6R1RHL3puQnVoQlp2SVZTTm4yZGMxQXJwZWtaR2hlYzRZRzhCVmsxVlFo?=
 =?utf-8?B?Zy9KeXRHRzdKQXc0Y0Jpb2tjL1hzQU4wRkVTRzlITEV4N3J4aFNuRmNoYlht?=
 =?utf-8?B?emR2THVVZmFKWEdWVjUrWUg2dU9lTEJMTmJtODVMaEI3R2xzVU1tYVFKYS9V?=
 =?utf-8?B?b2RsQ3Q5M1pTcXJTaVNqOFY5VnExcTJScWpNVEJLOTFlNDAyb1VUSVhiRXVE?=
 =?utf-8?B?UFJXK2hWc1pmRWpiM01KT1crMGhyL1VNUlFqMFdqOGdadzNtYlQxQmlEVjB4?=
 =?utf-8?B?ZVlzQk01Q2VqY1J2elVFMVN2V3NoTUQrMEE4NzJSc1hxOHJHbjNQcFQraUQy?=
 =?utf-8?B?QUdDb0ZBcDdiS3UwZkQ1YWZLRlpPVC9FbEM3MWdqR3hMZERWaFpyVGRNYk10?=
 =?utf-8?B?OFlZbVdaRncvOFdXbXVPd25rRDdYaXgyL0hTU0hnb0JGVWNES0FCOTVPZ2ZX?=
 =?utf-8?B?TEt4aTl5V295Q3hQcUNLUGZRY3dHQWFNaGtMSjhqUmFuMklGb3NXajNOanF0?=
 =?utf-8?B?N3hTVGNNUktpQ3AveXBYYjhoSStyQSsyVWRpWG1hQVRmb1RoSDhDT1g3N3Iy?=
 =?utf-8?B?Uk45clpDZHFvdlVNcVRsNEthbnY2THlWRGxLTjZkOVc5TVRDRkRsZkplazlG?=
 =?utf-8?B?UkhoWXFMbEFEdDYrN0RKNnl1SUgxTFZNTGhUM3ArMjhla0JhL3gyQ01YWm5E?=
 =?utf-8?B?cGtxenQ2SmlRU2tBdmhRWXI2cDhNUUlCNWhWMEpRRnR1MytBN1BodGZpd1ZE?=
 =?utf-8?B?dk5haUlCRlptYWNFQytQMWU2TFZ4bkNBdnVDMCt2RDA1RnZhdzk0N3hRR05v?=
 =?utf-8?B?dmY3cFRNZUYxWnpuSFVjSlM1SEpyc3RkV293dTZ4L001bXdISWplR0U4alpz?=
 =?utf-8?B?TUZhd05ONlQ2Q05wRXBwSkFqNWpRVnltSG80NVl6QW1WMFBaSWJ6Q2Y0ZzhQ?=
 =?utf-8?B?RmRUWWpwSTRKWkl3eEtpdHVYZ0dJVzBDSjNGbkNNVnpPVFlpUWh0MXZLSEFH?=
 =?utf-8?B?SVBwQ2RrSEFjUVd1aFNjaTgwRnN2RXhETmhxaEFFb0NtcDJRTzA0WllOWjZL?=
 =?utf-8?B?VnVqcW9mSmhmaFBzQmZ3WVV5TXQ1V1pmaDJ5K3h6dkt3ZlQwZzlsMlFaZ3VX?=
 =?utf-8?B?K2syeXUrQ1RrS2szNWtWY01jd09EWHNHdG1kcmtSeUJLMXRnNG5DYzc4aDR2?=
 =?utf-8?B?QkFhZmZSalo4SUx2T0tzN2Vpclp3NytBWnVocHZWSHgxSUp4U2lQQTBva1lL?=
 =?utf-8?B?NEprKzdFcGFEZVkwRHJRWGtEZGl5ckJrb3Zja2QraHhHQlNBRW10U0gxKzRF?=
 =?utf-8?B?VnZUNHNiTmU5ZUVrYXF2aFg4TjhBSm9BTHR6N05mODVjeTRhUTF3ZC91YzNj?=
 =?utf-8?B?R3FIdkdvK3MxN1BaSExYVHBKMEY3bk9GZ2poL1ZuWTBFOGRNMStPSGkwQjJu?=
 =?utf-8?B?MFBuNXAyVFU5RDUxSFhnSUswWmNDU0ZoVHVxQk1mZVlOMG1Ha2NQZjVtTnFh?=
 =?utf-8?B?UGI1Q1pqODRhdDlwU0ZhSkFWMmtxZWNuOWpGT1d5WnM0YUg1TWZMTElTSkFv?=
 =?utf-8?B?em1JNVExVE85ZUd4WGUyK3dIeDY4dTJRZ3BDeG1sRFVUcENnemNGdElDeUR3?=
 =?utf-8?B?UjNUZTlZeDdUNkR0WFRxNGM4QkNjMHIxdXRGWlQ1MC9LQVhYbkw3alNVV3l4?=
 =?utf-8?B?R1U0R1pCK3B0UnZDZzBvcnJray9wdmlEWmRjdzhZbnFQd29xamZGbFJjS0dR?=
 =?utf-8?B?eURyRGxQcDZzcVVaTDY5ZWdQb0RzWVJtUUM3a1J2eEQvOVhDMGZ4MjFBd0dB?=
 =?utf-8?B?d2pjaWJqWDBZZDY3SlJSNGM0eFo1V3BJZXcraXF3SUNXSE12a2Z2bGVsUDY0?=
 =?utf-8?B?TXBLTXZVWllDdlg0Z281K0kxaE9DOHNNZEkrVTJxOVBZQzhiWWVlRmhKMHl3?=
 =?utf-8?B?STkyVkpYMHBxQnRPU09XMUMvczByZVlWSFpyWWx2ZkdwR1BKTENNdGQvZ0xU?=
 =?utf-8?B?a2U3RzBvOVIrR0ovejhVTGFOVGxrRTF6a01YdTFTU0hpeUhjTUFuaVd2c1pN?=
 =?utf-8?Q?NRpmC6X8Z0i/m5mCupNRSgE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4d661e-fbb4-4783-cdfe-08d9d68ed498
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 12:18:39.7308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyyvlE6tIW/w3Isl23c+86uxAYV6LPeUg6d+pxbLQHLiI3Zzp1PSflVIQ73ZojtZlLoZ5KVyj+NuQV3aLaJHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3873
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/13/2022 1:12 PM, Christian König wrote:
>
>
> Am 13.01.22 um 13:06 schrieb Nirmoy Das:
>> GEM code should not deal with struct amdgpu_bo_va's ref_count.
>> Move ref counting to amdgpu_vm.c.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 38 +++++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
>>   3 files changed, 42 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 4a11a2f4fa73..691f0a879c90 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -176,12 +176,9 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>       if (r)
>>           return r;
>>   -    bo_va = amdgpu_vm_bo_find(vm, abo);
>> -    if (!bo_va) {
>> -        bo_va = amdgpu_vm_bo_add(adev, vm, abo);
>> -    } else {
>> -        ++bo_va->ref_count;
>> -    }
>> +    if (!amdgpu_vm_bo_get(vm, abo))
>> +        amdgpu_vm_bo_add(adev, vm, abo);
>> +
>>       amdgpu_bo_unreserve(abo);
>>       return 0;
>>   }
>> @@ -218,7 +215,7 @@ static void amdgpu_gem_object_close(struct 
>> drm_gem_object *obj,
>>           return;
>>       }
>>       bo_va = amdgpu_vm_bo_find(vm, bo);
>> -    if (!bo_va || --bo_va->ref_count)
>> +    if (!bo_va)
>>           goto out_unlock;
>>         amdgpu_vm_bo_rmv(adev, bo_va);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b23cb463b106..9d60de6a6697 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1290,16 +1290,49 @@ struct amdgpu_bo_va *amdgpu_vm_bo_find(struct 
>> amdgpu_vm *vm,
>>                          struct amdgpu_bo *bo)
>>   {
>>       struct amdgpu_vm_bo_base *base;
>> +    struct amdgpu_bo_va *bo_va = NULL;
>>         for (base = bo->vm_bo; base; base = base->next) {
>>           if (base->vm != vm)
>>               continue;
>>   -        return container_of(base, struct amdgpu_bo_va, base);
>> +        bo_va = container_of(base, struct amdgpu_bo_va, base);
>>       }
>> -    return NULL;
>> +
>> +    if (bo_va && bo_va->ref_count <= 0)
>> +        return NULL;
>> +
>> +    return bo_va;
>>   }
>>   +/**
>> + * amdgpu_vm_bo_get - find the bo_va for a specific vm & bo and 
>> increase
>> + * the ref_count
>> + *
>> + * @vm: requested vm
>> + * @bo: requested buffer object
>> + *
>> + * Find @bo inside the requested vm.
>> + * Search inside the @bos vm list for the requested vm
>> + * Returns the found bo_va with +1 ref_count or NULL if none is found
>> + *
>> + * Object has to be reserved!
>> + *
>> + * Returns:
>> + * Found bo_va or NULL.
>> + */
>> +struct amdgpu_bo_va *amdgpu_vm_bo_get(struct amdgpu_vm *vm,
>> +                      struct amdgpu_bo *bo)
>> +{
>> +    struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(vm, bo);
>> +
>> +    if (bo_va)
>> +        ++bo_va->ref_count;
>> +
>> +    return bo_va;
>> +}
>> +
>> +
>>   /**
>>    * amdgpu_vm_map_gart - Resolve gart mapping of addr
>>    *
>> @@ -2704,6 +2737,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
>>       if (bo && bo_va->is_xgmi)
>>           amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MIN);
>>   +    --bo_va->ref_count;
>>       kfree(bo_va);
>
> That here won't work, you are removing and freeing the bo_va even if 
> the refcount is not zero yet.
>
> I suggest to have a matching amdgpu_vm_bo_put() function instead.


Right, let me resend v2.


Thanks,

Nirmoy

>
> Regards,
> Christian.
>
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 85fcfb8c5efd..6d936fb1b934 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -415,6 +415,8 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device 
>> *adev,
>>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t 
>> addr);
>>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>                          struct amdgpu_bo *bo);
>> +struct amdgpu_bo_va *amdgpu_vm_bo_get(struct amdgpu_vm *vm,
>> +                       struct amdgpu_bo *bo);
>>   struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>>                         struct amdgpu_vm *vm,
>>                         struct amdgpu_bo *bo);
>
