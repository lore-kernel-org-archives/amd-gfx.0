Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD3F506D0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D8410E1D5;
	Mon, 16 Mar 2026 13:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dcC/YHU+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B9B10E1D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 13:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxEALsMoQMMs2W2nRsKLRAb6qIjk/8KxqQwjwJ8bks6+nc24XKFpZ6riirDSd7IeoQ+p/zetAwY/r8DYR+kV6vcgeTKAlj8i+Oz/vm8CN46+4oHZar81ELV/dpwra0UmUUUXIFiik/XjiQUQWP8Dx51c654hALbCpkgytC4Ow3zaXUPNFx1mgUrds5QVcwRh0+zTNM4IFBTlgpnfYzz3hgTMNifcXw33LYR3iRL9mbZxxT+eWIXBeEm5g3cbveAihqI//QPypYQ5w/o5/nO2WcqsZVijk2Yumjp0E8U/mgnPH0Eh3RAkfYYpEYq6f2zjUhRWeIxOTrHJC1jmecnqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHrwQT7lry3PselGmPxBNTG2+KsfXzEMTzH8Mv6tw1Q=;
 b=PqYFSMsoi66Ph9StAR9VSAup9lAQ3+kaFXEOYNKVIKkK1ioV5vC4caSRfzUaw7gaTEFifUVl5wdRzoAJe3o2+/qYhNQKjd9OD72EdC5UMjsHwX0MntKbMwQd2tKyXZZlYXUICpaSXzdRrbipxeZyg/FDny7FbHyj9sERglS7f6y2gvNpKzBxjLMNmucpDMIIxOeO9LDuSL7PtrR5DK7kEbInv2vFM10JyNcwWl57qzIrZXa/ESlcUkgWmFJFq13/88A3/aXLqTHR+zKIULeij6fOmxlwIfeh+jMrETxVPrOifKojC28WSVC/2QhlB22+drmiYQyWosLcSpznfdhzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHrwQT7lry3PselGmPxBNTG2+KsfXzEMTzH8Mv6tw1Q=;
 b=dcC/YHU+A6w3eNS06aY4URMSNvc6HfoSxnpe7ADjUnjir0bo9NC68/zdFeub9gptSAM+t2g19XkXuE21nxE4OfTkk3aWU2W6oi85RbJ2Zs/ecZOSk7SgNau4fnDJuVIUnPjbW6tWdq8qH4GwQyWUopxGYQ8ooYJ/6lbC8GV27WQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 13:45:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 13:45:00 +0000
Message-ID: <cd5f4df5-e532-4512-861b-5bf361b25f0e@amd.com>
Date: Mon, 16 Mar 2026 14:44:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: restructure VM state machine
To: Tvrtko Ursulin <tursulin@ursulin.net>, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, Yogesh.Mohanmarimuthu@amd.com,
 SRINIVASAN.SHANMUGAM@amd.com, Sunil.Khatri@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-2-christian.koenig@amd.com>
 <b0a6f3b1-c11e-4b5d-ba12-a4e7564518a4@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b0a6f3b1-c11e-4b5d-ba12-a4e7564518a4@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0455.namprd03.prod.outlook.com
 (2603:10b6:408:139::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dfe170-f32d-479a-8850-08de83623774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: QqWqqKfR6mp3bvgZNwYUGF9Eg0+eDNvQGG/n/hzksgdvIZJrk+OgUN26Yrm3qS3mMMh8UZYqs04amgAos0T8YB+qf+Ncd1glE02HY/vIEh8azSnCs094/v6ts4hc5hAagHSSb+XzoM7i58ExlZhfFhOdYT9W235DiVVifhpeZH7cllhsTSAMYkHjwUpDssEZt1v2yCk7gPek+hccy0jwxRlOaa6BgzhUchWZ0KGVidHDNdkFmh+UKPumv24dsw2L8d+MOTYxH1K6F1Kbq/QMO9J0M9u7h2qCGhV/FXW8Eo6UqGRZ4POLWNo4nAY9Q95bBz8FnTyBm1BjniceBtlSMteZhmRTYFZDOY91+cObczP/cophcsBMbog3soEhVpu7Vbjmf7Xkpk8ETs7W8jtNgDULKkjOh941I3epO55ooud57mnga6wJtJOJcl0CF5VoLhH303cLBThW/15mZP/s+/OSag0yfy6K4nd1fAejy07AFeYasC8zPHX0YMPUDCrPjLDbipP4T289B/ptwx6KkafpQmYl8tYxyL9WoaObQH4ozh0XoT8UJL82nay4RlDSIi3MiWmECtudwogecHiBJYK47Uofn+mgn2SpVJX+PzgKV5a8ywBGzft0O/TTFL+TRXltfHzD1TvPcjmk9dMtiYJa8FQCYSCZ/hCKLMwTsIjWbBcWef8RNKY9unwas/csaQc8xjo0KXV2ZJOQUpAVkl/ZznpG48Kge6H780rpu7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3I4LzlOeUxTeU5jQmpqUjIyc2d2eStQa0tRdTFNY1ErU3QybnNBbW5ZekJI?=
 =?utf-8?B?YVQxa0s1RzBndkx6eGlrSU5BSlZNSEN1clluS3pOVkIrb1B1ZWpMVGpjMXJU?=
 =?utf-8?B?WHdxZHI4OW1JQU9sSnN6QysyUTI4aVQ3eTRobXlZS3Y4a1dpalhab2ZKeHM2?=
 =?utf-8?B?L3YrdVpJWmhXR1Nnc21KTlYwa2hBM3dvUkxZcVd2OWFuc0ZYQXdUT1k4WkEv?=
 =?utf-8?B?QnNJWGVOK2NDakNvWFZXVGxKYUo5T2h3NGNXeU9kSUJzdGhKVGUwUXV3c3Yr?=
 =?utf-8?B?T3Vja3FsMTFxMUhBa2Myb0cwZndHOUtOVGdPc09JYU9sQm9qb24vTzdyYjlh?=
 =?utf-8?B?MU9hMS9XOTYybk5nY1hmUzR3U2ZVK3ZDRHdZelFwZ24rV2tHMGV3Y3VaNm9H?=
 =?utf-8?B?aWVqUy83V0hwUlNxTnNUYzdSdXc3MEY3cll3UGRHQWtaM013K01uMzlBQS9L?=
 =?utf-8?B?cWdVZEpsY0hCdC90cXJTK0I5U0VLR0VyUDhTZ2RyeWkrTm9oTFZwQndkTmhv?=
 =?utf-8?B?N1FZeFpDS2xteTNOZTBNNlpCUitvczZoT3VtRmZZbGw4VVJ2S0VtSUcrTXRN?=
 =?utf-8?B?d3RubEQwQitWd3BoUTBhVk83d1JETUJYSTRHTGF1NXlpK3BXWVhXWkc3ODU0?=
 =?utf-8?B?Y2xsM0FSN1B0TXFtY0tnU1JYeGYwMjhGUnp4K1FVNWtyTWdDUURoYVYyZkdT?=
 =?utf-8?B?UHB5cHVJbFcyTjJLdmE1SUlPdVJBRFJ0L05vLzBYNmZ1YUtRcmZqZkozTU0y?=
 =?utf-8?B?UDRiTE1yUjEzRXNkdjUxQ1FLNC9kWkJHaThMbzVJUXJEK0t6TEtyS1ZZQVRX?=
 =?utf-8?B?R3MxWDNOU2RLYXY0ZHNnK2xiLzFBUTliSExTWnNmcW1McndWWm43cnNYYmZs?=
 =?utf-8?B?TWFtdkQ0YkFLREpSUWk0MUZRdS8yckhTU2w4WmxUaXlvTUQ0ZlNWTnM5VWg5?=
 =?utf-8?B?YmpkTlVIcEdQd1BnUFhvcEcwYmVSSnFXakt2d0xiYnQ3bnpENW1HMkNuQWhS?=
 =?utf-8?B?VTMvYlNwdkJpbUsvWXpsWG0weitEeG16bzBjdnZsRGZrdUpQN3I2REhkMlIr?=
 =?utf-8?B?cGwwVkhJZUFaRFlwS1Eya3dOSkNtRHRlQzVnMVh4S01SMGpocW0zSmZ0TVBh?=
 =?utf-8?B?MVlmam5iYlZzc2N6cTVZS0hlTStETEFVcjR1Qi9lSjVDSmdua2lwcUZOTFA3?=
 =?utf-8?B?VGQ5MW1HK0QxMjVyK2lub2VldEpXTWppUjc3OVZyRHNWM0R2QVFjK1A2Z2Rz?=
 =?utf-8?B?WHhmY2R6dnRxS1pYbzZyT3JLMFNPcWtYb0dqM21uSlZoQ1UvQW9zMWtXNFpY?=
 =?utf-8?B?TDNTbytPQ3Zac1l5NnFHLzlTOEZLMVNZcXlYQjlBbWh1VUYwdHBuQkJSeE1M?=
 =?utf-8?B?bHRJRjRlOU9ta3N6ZTJrTm1qNFhMcDFoNWFPZ1k2OUc4RktVRUM4SmZNV1l5?=
 =?utf-8?B?UDMydHMxakt3Rm1sUURsWWdGUURoSUxac1hva3dRNnFNaFMxQitoV3EvcVVa?=
 =?utf-8?B?Z0dxTXMxRFNQZjdqbWpUL1ltUDhuUTdSR1FjWlV6RkVQTDhtWlVIdnFMS2Nx?=
 =?utf-8?B?eitROG53UkdsMmJSeVoxbWJFWktCdDJDOFJXNjhrUk5LNEpDNEhQMEFvQlZZ?=
 =?utf-8?B?ejhLY1NMV1h3czRoOW0raG0zWk1IeEc1TmZSL3RjNTB3WkltbUtjbzkvVTVZ?=
 =?utf-8?B?cWhjUFY5dnFKNGxYcVhnMW5hZXVjMVZHbElMc2tsYlBjQWppYTNLV2Nta1Z2?=
 =?utf-8?B?dUhoTHMyVUZWV3ZPRU1OekJaS2ViOW1MaGJRQ2xWTTV5dU9jMjc3RUwxK2ZB?=
 =?utf-8?B?Ti81THNYVXpUUitWc0wzbC9Ud3NNbEc3d2V5Rm9oRGNEYUdtRFdyY2oyQklI?=
 =?utf-8?B?Z1RXZGRlZmx6OHZKdnYwc0lRdEM4MEY1ajhkdXBJZVZ0YVhienRUeDFJUnhX?=
 =?utf-8?B?a2pNSzNpS3lCaFBVSmVGNmhYQndneU9CcGRxUTVVb3ZUUjFjUjNVRmpnQUM4?=
 =?utf-8?B?QnRKTkR0L0d6cTBSR2ZNZmwxUlN0NThwLzZ5cDh5ZElaUTdwcTJ1K3haNzFV?=
 =?utf-8?B?eUlNQlpVdWFURjZDUmUzRHhTWlBqTGtHOXVocnVwTTlnZWMrTWJSOVhJaGhh?=
 =?utf-8?B?Y1FDMjJkNWxhd1hVeS9RbDNadG05dUZOaHJucGJCYkNWbERMQmRPczNKOU9i?=
 =?utf-8?B?Wjc2RnV2aDNuaFhKcEh2cE1xSkZ6NDJBNXRMZ1RoSU82SmkvcEZ4cWQyMXVq?=
 =?utf-8?B?T2orR0tIRzV3OUJpdHNRYXhMRjYwWVdDcTVOSE5NdEoyeWJOaENWYk1KdExT?=
 =?utf-8?Q?z3QPZTiSNEDfD93BxZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dfe170-f32d-479a-8850-08de83623774
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:44:59.8710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAnpbnNdmHaa1SlA26Uvrc1Uah3CU1ZiXm2REHq8yXyHzWEYp29iWLR/18HkUSTU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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

Hi,

On 3/12/26 15:32, Tvrtko Ursulin wrote:
> 
> On 10/03/2026 19:13, Christian König wrote:
>> Instead of comming up with more sophisticated names for states a VM BO
> 
> s/comming/coming/, and maybe a comma after "in" in the row below.
> 
>> can be in group them by the type of BO first and then by the state.
>>
>> So we end with BO type kernel, shared_resv and individual_resv and then
>> states evicted, moved and idle.
>>
>> Not much functional change, except that evicted_user is moved back
>> together with the other BOs again which makes the handling in
>> amdgpu_vm_validate() a bit more complex. Also fixes a problem with user
>> queues and amdgpu_vm_ready().
> 
> It would be good to describe the problem at least a little bit, especially if it was a significant reason for the patch.

Thanks for the comments, fixed in the next version.

>> -static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>> +/* Eventually unlock the status list lock again */
>> +static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -    spin_lock(&vm_bo->vm->invalidated_lock);
>> -    list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
>> -    spin_unlock(&vm_bo->vm->invalidated_lock);
>> +    if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
>> +        spin_unlock(&vm_bo->vm->invalidated_lock);
> 
> Worth putting an assert vm is locked on the else path? Could be given the new API (amdgpu_vm_bo_lock_lists) is a bit odd in that for always valid it expects vm already locked and for other takes a different lock.

Good point, fixed as well.

>> @@ -412,14 +384,16 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>       amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>>       spin_unlock(&vm->stats_lock);
>>   -    if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>> +    if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
>> +        amdgpu_vm_bo_idle(base);
> 
> Hm on what list is it today?

None, the status member was just initialized with INIT_LIST_HEAD().

Since it doesn't has any mappings yet putting it on the idle list sounds perfectly valid to me.

>>   int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>>                    unsigned int num_fences)
>>   {
>> -    struct list_head *prev = &vm->done;
>> +    struct list_head *prev = &vm->individual_resv.idle;
> 
> Should this access be under the lock?

No, prev is the pointer which is always valid. In this case here pointing to the list head.

Only prev->next can only be trusted while holding the spinlock. That is also documented by the comment below.

>>       struct amdgpu_bo_va *bo_va;
>>       struct amdgpu_bo *bo;
>>       int ret;
>>         /* We can only trust prev->next while holding the lock */
>>       spin_lock(&vm->invalidated_lock);
>> -    while (!list_is_head(prev->next, &vm->done)) {
>> +    while (!list_is_head(prev->next, &vm->individual_resv.idle)) {
>>           bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>>             bo = bo_va->base.bo;
>> @@ -584,7 +558,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   {
>>       uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>>       struct amdgpu_vm_bo_base *bo_base, *tmp;
>> -    struct amdgpu_bo *bo;
>>       int r;
>>         if (vm->generation != new_vm_generation) {
>> @@ -596,38 +569,52 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>               return r;
>>       }
>>   -    list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>> -        bo = bo_base->bo;
>> -
>> -        r = validate(param, bo);
>> +    list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
>> +        r = validate(param, bo_base->bo);
>>           if (r)
>>               return r;
>>   -        if (bo->tbo.type != ttm_bo_type_kernel) {
>> -            amdgpu_vm_bo_moved(bo_base);
>> -        } else {
>> -            vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>> -            amdgpu_vm_bo_relocated(bo_base);
>> -        }
>> +        vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
>> +        amdgpu_vm_bo_moved(bo_base);
>>       }
>>   -    if (ticket) {
>> -        list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
>> -                     vm_status) {
>> -            bo = bo_base->bo;
>> -            dma_resv_assert_held(bo->tbo.base.resv);
>> +    amdgpu_vm_eviction_lock(vm);
>> +    vm->evicting = false;
>> +    amdgpu_vm_eviction_unlock(vm);
> 
> Is there a specific reason this block is right here and not at the end as today?

The evicting status reflects if the page tables are at the location where they should be for an updated (VRAM/GTT, accessible by the GPU).

The status of the always_valid/per VM BOs doesn't matter for that.

This has caused a few problems for userqueues and is the issue I described in the commit message.

> 
>>   -            r = validate(param, bo);
>> -            if (r)
>> -                return r;
>> +    list_for_each_entry_safe(bo_base, tmp, &vm->shared_resv.evicted,
>> +                 vm_status) {
>> +        r = validate(param, bo_base->bo);
>> +        if (r)
>> +            return r;
>>   -            amdgpu_vm_bo_invalidated(bo_base);
>> -        }
>> +        amdgpu_vm_bo_moved(bo_base);
>>       }
>>   -    amdgpu_vm_eviction_lock(vm);
>> -    vm->evicting = false;
>> -    amdgpu_vm_eviction_unlock(vm);
>> +    if (!ticket)
>> +        return 0;
>> +
>> +    spin_lock(&vm->invalidated_lock);
>> +    list_for_each_entry(bo_base, &vm->individual_resv.evicted, vm_status) {
>> +        struct amdgpu_bo *bo = bo_base->bo;
>> +
>> +        if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket)
>> +            continue;
> 
> What is this for?

Only certain elements on the list are locked, we skip the ones which aren't.

> 
>> +
>> +        spin_unlock(&vm->invalidated_lock);
>> +
>> +        r = validate(param, bo);
>> +        if (r)
>> +            return r;
>> +
>> +        /* need to grab the invalidated lock to trust prev here */
>> +        spin_lock(&vm->invalidated_lock);
>> +        tmp = list_entry(bo_base->vm_status.prev, typeof(*tmp),
>> +                 vm_status);
> 
> Why is this safe? Lock was dropped while the current element was left in the list so anything could have happened. Even if current element was unlinked before dropping the lock, I don't see how it is safe to assume the previous element is still valid. Does it rely on dma-resve being held over the whole function? The current method of restarting from the head is certainly easier to understand.

The whole list is protected by the spinlock, but individual elements can only move while holding their resv lock.

Now what we do is to walk the list until we find one where the resv lock is locked individually, so that we know that it is save to drop the spinlock.

We then validate the entry we found and try restart from the entry before the one we found.

Going over the list again until we can't find any more is probably easier to understand but also less effective.

>>   -    seq_puts(m, "\tRelocated BOs:\n");
>> -    list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
>> -        if (!bo_va->base.bo)
>> -            continue;
>> -        total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>> +        amdgpu_bo_print_info(id++, base->bo, m);
> 
> Probably just thinking out loud - given the format of the debugfs file is changing anyway, and that this id is both unstable cat-to-cat and also has no relation to the user handle which is output by the only other caller so could be confusing/misleading, I wonder if it is even worth bothering with it. For example you could pass zero and even modify (or not, optional) amdgpu_bo_print_info to skip it if handle is zero.

Yeah I was thinking the same thing. The id is really completely pointless.

But I think that is for a different patch.

>>        *
>>        * Lists are protected by the invalidated_lock.
>>        */
>>       spinlock_t        invalidated_lock;
>>   -    /* BOs for user mode queues that need a validation */
>> -    struct list_head    evicted_user;
>> -
>> -    /* regular invalidated BOs, but not yet updated in the PT */
>> -    struct list_head    invalidated;
>> -
>> -    /* BOs which are invalidated, has been updated in the PTs */
>> -    struct list_head        done;
>> +    /* Userspace BOs with individual resv object */
>> +    struct amdgpu_vm_bo_status    individual_resv;
> 
> Are all state transitions valid for all lists? If not it would be good to put that info in the respective comments.

Yes they are.

Thanks for the review,
Christian.

> 
>>         /*
>>        * This list contains amdgpu_bo_va_mapping objects which have been freed
> 
> Regards,
> 
> Tvrtko

