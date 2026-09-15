Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F8CC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A17910F404;
	Tue, 15 Sep 2026 10:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z6JZL+WA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA4510F404
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlhWCAiLpUd/uv+619vaZkT8YbXflVuumr1Ktaoj+5kjJ2aAjSTJi1mG/NirznV8vk+/USIzUeCUoWtsyrRfvrk7dOu3G3ZfA3c9LYswRtnuglNOdLbjgobfOvQNL3LDv1ctauSkofa+tPkNaf+Ea+Xwx3GHKYNscfzGXhWJqv0iC+nhLH0HxgjNG9Wwjc0AvYMNPnTYEXvmqtJFtYT7SJbyXHV6D5a2NYzGQCNHkkKjNqg9YlP6Cfye1qySLd1c9Z3vIuoS6qp3qwywWJjldjHLy7eTDUa2SjrTavNnWpz5nQTDWlNFgr2K/6MIa45KOHhyE/ikqxFhQOOt9d5MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6pRCPfjI10mdjUlTh/5/xRVzwEvsLfkx2N0VZvGCMg=;
 b=TSueACr8XXBBX76gfJZPYYWq+p4wOyYBGgu9phtw48jZSN++cnsGTsCk2iqrtUQb3v8NkHUHdDgKNHoBkaK/M7rghv4P6NnEIIfmd26A6R1rlBapetBLA1QqVVgWEkmq7Sm79XwNOhK//AUQMJxGGzf2xDUx6PahNXx68+sGPYf6jceWQkgaYGxG/PFxHp+gZd+zF+PlFVcRJXOeA2LcIcoxpz7E3DdlkpiVU9BWsJ0xJNjsmzFh07F94dlky6tP+gXL0whiYtAHNH7l++QGD2n82AgUitw5zqA9qIoZ+mdvWV9yfcnEuX95htmVnx5t2EHO3/v4dRXa7vISHVJQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6pRCPfjI10mdjUlTh/5/xRVzwEvsLfkx2N0VZvGCMg=;
 b=Z6JZL+WAIQJI7Fk9FYgP+FeyoXUPzevOcLvgukYL+npQbZAnxs5fk33zmKruE4aew0AelrHwoVXDBApeJIVDJvZce7hwD+/voN7ECaYtPae9hfWGj/VT0cJYAn7Z6dsiJurR7hZgBHiY2xJOW8pUwHhe6iDKAUEnxm9C9GBkbVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 10:58:44 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 10:58:43 +0000
Message-ID: <380737a7-3321-446c-8676-08dd526bd704@amd.com>
Date: Tue, 15 Sep 2026 18:58:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock
 uses
From: "Huang, Honglei" <honghuan@amd.com>
To: christian.koenig@amd.com
Cc: Huang Rui <Ray.Huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yu.Huang@amd.com, Honglei1.Huang@amd.com, timur.kristof@gmail.com,
 natalie.vock@gmx.de, amd-gfx@lists.freedesktop.org
References: <20260911164801.50175-1-christian.koenig@amd.com>
 <3d040b4b-a9f7-4819-91e8-5caa204f57f0@amd.com>
Content-Language: en-US
In-Reply-To: <3d040b4b-a9f7-4819-91e8-5caa204f57f0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: b8260378-86bb-4267-3418-08df13184eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: IbqB227ta+WA2UKXxlTC26/sX6Ijlko/mifLtV7VrI3Adw27JpsOLX3f5GIHReVe7+L0znw4wzFlT/F+Xb4IToHUOgMC9+tN+b3vCgWZN/gR6KJgFJ37Rttsvqrfef4Jd8TPq5Pi77S2akB8rOB2RT0c0Xr7OHtZXt3CT/OytXG/TaSmXhDyXVHWY4HCfGGAErRAd05NmDbxFpynJjw4iBQ1R3rc7aCJTcscMA8e7bsLOhp5Nxprp0nHBPJssSFSiUaBYswHbgt47lzhwBGt/Mzc1ZLFZFZ34/TMyvrrwlqZuspT+sYMrOugni/YbnadjfWoontzHl5f62Y6mRa11BKWumZ+lxQXc2KnymMZ7yCyqAKyThpl+uwIJLqHH7hILsBNHwnqMaBp44y4dmM437zcxIIAt1c2X3iw5YfHs/2krizsh2xFr7ZHyjoru66+1C+ICOg4yA6PM2HKNkScpjxM8W5AAl4YFi2qEnlzP0Gy+HRRsVcrOFb671HlzGP4pCieMsCO40WBZAG9wDFzGoWFv8q07J09ik8I/yXs+gIXjx9IZ2h4CPHiR890K6bqODkT3bb8JNpo22ckdY9lVFdc0oERrDi5w1tUHkj+5IJS8j/qK67SNWGp1c70sXpDi4FWdJwB/S2o1xumhbmQ1I+gGsQnMeVk/wVJyVKYGB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhKTzJrNHY4YlhqZlp3V3dNMFc1ektCSkgxMjhQQS83RCtWSmhxR3BBaWZO?=
 =?utf-8?B?ajVvTjdYMDRFYXRVYlhzTEVTY2hadXhsOXJFc2pEMjFSQ1pNS1RnU3hvTFIz?=
 =?utf-8?B?L3VTNVg5NDRXLzhJRGh0VnBrUnE0YmtoOUs2Tkk4MlRnUXovTUpEQ2hlbDh2?=
 =?utf-8?B?a0FBMkg3UHVzS3dVb0tkZDJOdlhseHlNK0lJVlhMZndiNlgzY0ZtOWlBMGVX?=
 =?utf-8?B?OHBlRVA1dVNaeDgwZnByMElIb21WZDU4UTlTWFJrWTFVRHpSdGVmaTlYR2lV?=
 =?utf-8?B?RDkwMGFTYzBrbTQrK3ZOaXFFMXFjZkJoRVpLUDUxaFNNbmVUS1RXTEUzWWF2?=
 =?utf-8?B?NXkzRmo2Y3RWSzdldUV5MU5SdzB0TUlqM3NPWXB2QllQSXkxY0NKaCsxcXVE?=
 =?utf-8?B?RnBvM0hYWlJXT1cvU3lXOEg0SEtpVWtZN213L2FwaDVpbTU3OHdvMVVLTmNW?=
 =?utf-8?B?VTZhTHpKTnNBb3ErNHRUWlZPUW1FTW1Helk2bGZhT3pIZ21aLzlhRnlTMUVp?=
 =?utf-8?B?TU1jcS9KQVVKS2trc0NKWDkwem1ZTHJUdTB5bGVpVTQ0ditDNUpyREswUTcy?=
 =?utf-8?B?bVprN0R1WHVDUGd6MXVyOVNWU0Jpclg5QXBadWEvakh3d2dNT3g1aXd1dWJv?=
 =?utf-8?B?MCtxMUYvWGFPSEZzTmVmNDlUVGIyN1VwOWhHeE1yYVJ6TXlhaHJxYVVQaGRM?=
 =?utf-8?B?N1BIM1JRUVZKZFVyaHEyc1JuSFRGQnhXSEZpdTdBZVFPcUlGNEtBQnFWWUdJ?=
 =?utf-8?B?ajcyUSs4SkV6UjBWVW9KMHZuZmo4Zk1zTEE0d1V3ZlJoTjBtOXk3M1N6Mmtn?=
 =?utf-8?B?K1BWODlEd1h2c3ZCRTkzK09lYTkvdU1aUFVtQUNGSjZ1YlIrS0lqekpOMlU0?=
 =?utf-8?B?aFJUT2c4N1VXWmgyQTRqektDajQ2M0V0SG5nYjN1QTRaTzE4ZnRCSjRiajBW?=
 =?utf-8?B?b3owTW5YN01CeFdzSU9ab210N1lxT3BPN2pWeEl3VWF4R2tvRDdBUWQ0dGtQ?=
 =?utf-8?B?c1lWV016WHUwSzFBUFRsRU50SGwxUGhZajZ2SVMwamNXcnJXZDNoNndiK3NN?=
 =?utf-8?B?Sng2eUdBUmx1U3VoMjdVeEV6bmFSbTdhOUpoZ1hPUDFOd2hmd0xQZE1tSzBZ?=
 =?utf-8?B?blhUQjNFK011dzJaZ0FtWFp0NUZGSVNxNHRIcE5qS1o0OEtVcXdla0t0UEp4?=
 =?utf-8?B?YUdPSEg0U0grT21iTDNEN2pmT0lzODBXenVtL0drRVpBV2pSOFVMOUV6UGVr?=
 =?utf-8?B?eUhMSmhjaFJHWGF5RFEwcGNvcmNHVTZVMmJjSGF0YWJqOUNjVm5HS1lkeDJY?=
 =?utf-8?B?czNuaGhKbTl0QVpNcEhrV0RkOFdtdXdrK2VoalRMaGp4THN2WnM3d0U0V3ZE?=
 =?utf-8?B?M2lJWTRrUkVOWjdzWWRFektHZVhlb0MxaHc5VDYydGN6RXFLdDBTS0dTSkEw?=
 =?utf-8?B?eG0xbjBxK0dXbWc1SWpZZUg5OG9IRW16c1B2ZDdaMG94d2tPQ0g3U0lTbjFp?=
 =?utf-8?B?MVpkMjhhWHZGUmViL2FxZXE1MnRSV0VxZjljWW5xdTMzNzZLczliU1ZTZitY?=
 =?utf-8?B?enJ5eGdsWE1KdCtNRjcvOXJ6dDRydjdNWDQ1NUtiS3NLS0F0ZUwrdTJ1a2h0?=
 =?utf-8?B?R2hMR0g4dmNSbi9LREhUMGdLbGdqdkdvNzVMOGg0VFNXTmc0enNQdFl6bEV1?=
 =?utf-8?B?cTRhTlJ3SWQ1MHBzeWNraTcxZkViSUIwWHVyTElFOU4wdk1ST0pkaSszV3VJ?=
 =?utf-8?B?NmVDaWg4Z3FLQzRpQ1B3cTVzSlNTSmhNMHNrY21EZHpBcTExTi81cWJZNFlW?=
 =?utf-8?B?ck5wclJEalJKcTJSQ2FzNEhscjlhYVk5ZCtITzc3ZUJINVcrelBCSzNZVHNR?=
 =?utf-8?B?WWRWd0dxSjg5MExTVGE2TEY2SHJUa05TRHpubUd3b3U4TGowTi9lcnNIODBI?=
 =?utf-8?B?RW9EUDN5c2JnaTMzMHd2czRmeXRyaEJxVWgwaExqc3k1Q1RFWmZlSkhxM3Nt?=
 =?utf-8?B?Ym9kdnFDZHcxQm9Fak5VbURWRHZBVEk2WmdCcEd5UlZIeHR6cjBqMWk2Z0pW?=
 =?utf-8?B?YW9sVld4U29QS0wwcWN1V2ZlZzlYejhGUUZ2eGZMdVdIWTNqNFVtRFhLVDhy?=
 =?utf-8?B?dTZuR2pZSnp3d0ZGZDl4YnNKN0p3cXJjZVJkakxINmUweHQ4QTlPTS96Ylpk?=
 =?utf-8?B?SVlENkFZZXdCUCtHQlpJWUFTZ1lsbDgzSEI1ZkxyOEVnc2NyclV0ZWFrOExk?=
 =?utf-8?B?MXIyd0hYUldEb2M4ZkVwZ3c3ZHBqc3Bpa3d1d0l5VGFFRFg2bUlLdlViR3hP?=
 =?utf-8?Q?mD2otc/kUCgPldy4wK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8260378-86bb-4267-3418-08df13184eff
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 10:58:43.8406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QAHlACGuiLmVPzK5EJsEisYwoNBbb6VUnQOvMNSTLnLxXlICSd96Yt1lFclT1dWU4yhUnIHhGPMANlug79/dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

We are preparing the amdgpu drmsvm V10 series, have some questions:

1. The patches organization will be:

	drmsvm notifier and eviction lock unify patches
	amdgpu drmsvm patches
	your amdgpu vm fixes

And during the test process, we found some places need to modify, we 
will fold these changes into your amdgpu VM fixes,
  do you need to review them before we do so?

2.  In previous meetings, we cancelled the attributes remove under unmap 
mmu notifier event,
Then we found some issue in kfd and HIP test, do we need the flag: 
AMDGPU_SVM_ATTR_AUTO_RESET like the auto reset flag
In XE driver for backward compatibility?

3. The KFD doesn't support the multi-CPU prefetch/migration (numa 
support), this is a major missing feature in KFD.
And there is an information form ROCR/HIP, UMD have the multi CPU 
prefetch/migration APIs and requirements , and they want to kernel
to support it natively,  the current KFD can not support it, so they 
have to make some workaround for this feature.

So, for support the numa feature, we may need change the AMDGPU UAPI let 
UMD pass the target CPU preferred/prefetch location. Here is the draft 
design for UAPI:

enum amdgpu_ioctl_svm_attr_type {
	AMDGPU_SVM_ATTR_PREFERRED_LOC		= 0,
	AMDGPU_SVM_ATTR_PREFETCH_LOC		= 1,
	AMDGPU_SVM_ATTR_ACCESS				= 2,
	AMDGPU_SVM_ATTR_GRANULARITY			= 3,
	AMDGPU_SVM_ATTR_HOST_ACCESS			= 4,
	AMDGPU_SVM_ATTR_COHERENT			= 5,
	AMDGPU_SVM_ATTR_EXT_COHERENT		= 6,
	AMDGPU_SVM_ATTR_HIVE_LOCAL			= 7,
	AMDGPU_SVM_ATTR_GPU_RO				= 8,
	AMDGPU_SVM_ATTR_GPU_EXEC			= 9,
	AMDGPU_SVM_ATTR_GPU_READ_MOSTLY		= 10,
	AMDGPU_SVM_ATTR_AUTO_RESET		= 11,
	/* new attr for multi cpu/numa  */
     	AMDGPU_SVM_ATTR_PREFERRED_NUMA_NODE = 12,
     	AMDGPU_SVM_ATTR_PREFETCH_NUMA_NODE  = 13,
};

And the value can reuse the raw Linux nid.

Is that ok for you?

Regards,
Honglei



On 9/14/2026 4:04 PM, Huang, Honglei wrote:
> 
> 
> Will rebase on this series, and forword Junhua and Yu, casue the rebae, 
> fix and testing are a relatively big work, requires multiple people to 
> cowork.
> 
> Regrds,
> Honglei
> 
> On 9/12/2026 12:48 AM, Christian König wrote:
>> Use scoped_guard/scoped_cond_guard instead.
>>
>> Saving and restoring the GFP flags is not necessary in those use case.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 27 +++++++++----------
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  9 -------
>>   2 files changed, 12 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu_vm.c
>> index 47cde54594693..7ced26c9c651b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -616,9 +616,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm,
>>        * As soon as all page tables are in place we can start updating 
>> them
>>        * again.
>>        */
>> -    amdgpu_vm_eviction_lock(vm);
>> -    vm->evicting = false;
>> -    amdgpu_vm_eviction_unlock(vm);
>> +    scoped_guard(mutex, &vm->eviction_lock)
>> +        vm->evicting = false;
>>       list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
>>                    vm_status) {
>> @@ -678,9 +677,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>>       amdgpu_vm_assert_locked(vm);
>> -    amdgpu_vm_eviction_lock(vm);
>> -    ret = !vm->evicting;
>> -    amdgpu_vm_eviction_unlock(vm);
>> +    scoped_guard(mutex, &vm->eviction_lock)
>> +        ret = !vm->evicting;
>>       ret &= list_empty(&vm->kernel.evicted);
>> @@ -2274,6 +2272,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>>   {
>>       struct amdgpu_vm_bo_base *bo_base = bo->vm_bo;
>> +    struct amdgpu_vm *vm;
>>       /* Page tables of a destroyed VM can go away immediately */
>>       if (!bo_base || !bo_base->vm)
>> @@ -2284,17 +2283,15 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>>           return false;
>>       /* Try to block ongoing updates */
>> -    if (!amdgpu_vm_eviction_trylock(bo_base->vm))
>> -        return false;
>> +    vm = bo_base->vm;
>> +    scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
>> -    /* Don't evict VM page tables while they are updated */
>> -    if (!dma_fence_is_signaled(bo_base->vm->last_unlocked)) {
>> -        amdgpu_vm_eviction_unlock(bo_base->vm);
>> -        return false;
>> -    }
>> +        /* Don't evict VM page tables while they are updated */
>> +        if (!dma_fence_is_signaled(vm->last_unlocked))
>> +            return false;
>> -    bo_base->vm->evicting = true;
>> -    amdgpu_vm_eviction_unlock(bo_base->vm);
>> +        vm->evicting = true;
>> +    }
>>       return true;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/ 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
>> index 447195cc45932..ca86eaac75235 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
>> @@ -137,15 +137,6 @@ static inline void amdgpu_vm_eviction_lock(struct 
>> amdgpu_vm *vm)
>>       vm->saved_flags = memalloc_noreclaim_save();
>>   }
>> -static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
>> -{
>> -    if (mutex_trylock(&vm->eviction_lock)) {
>> -        vm->saved_flags = memalloc_noreclaim_save();
>> -        return true;
>> -    }
>> -    return false;
>> -}
>> -
>>   static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
>>   {
>>       memalloc_noreclaim_restore(vm->saved_flags);
> 

