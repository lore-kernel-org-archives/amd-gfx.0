Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB61CC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EC610F5F0;
	Tue, 13 Oct 2026 08:21:50 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F9110E75F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rscw5EWJHHmQdXCtEWjdU21VxykFUSqapgtnuOHRq/6tXtJeslGl7jo2tAwNpFEJydDmRSkoEVA3KJ2Qw5PRyQDb2I3WCWxwXWAXnjLgZnGpyysl2zzQkyNI6+aoRJASAny3ov79tk0uHZdD2UIBEarj7aEeAo2inyu9yQd5VyO8bK3RJ9leVGQbX4d4UTE1Nqvml7MUi6jQLpBwfcAv+8cw5oN+6BbPxUkl6p05rSsnn/bfnnEXKpZW5cefxajdcYMFiB3ubUoxsYAqGsxUxKL4qgGqMRsvOUTtYybCoDMUfgPilHvmHghL+AzFJEMwtcZeihEm0twMwN++HKmDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdYP2Rc5AmiUiSs8s5eapvxrX8vlPSEOvR3kr387zOI=;
 b=nOknoqjcch1wxZZhR569Fc7H/bq4oJRtuSt64yBg4HM0DHEX636ouUAqgfXxStWxDVj+EkbBmLI9c4kdpb+5FEwYHk9Rpg3b41N6hLYSlnK/67C70+mCD3GjWKeQ+jf10LJiOx1IF84nHRtwidqrhnWCYnfSxa8vcBVLonxDRqZHot8isSR4FBkGQIknWhtH6DiLKkW0kFFFpqnMq2MEF7OwkwVIjxPNmEumvfRxgaXYTMENx65MdLsEZftm3uLhRWJ9YV5XGGYF1f/XF4FNoBDyB5CjwN6e28twhY9JpaQPSSjGHvqSwJLYCyx9NHUpuUfMIhsKLLgRbKPvY6+/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdYP2Rc5AmiUiSs8s5eapvxrX8vlPSEOvR3kr387zOI=;
 b=KiMiwBaRJkaEHsmSI1sXUaK4v350U6n58GDm8ifSu3Naa/VbRzmhoZD7KdLB3jjmGqfH+9TBkzUFMQ6bTRBJgA8lY02h5akzwAR63XNlBS52pYh+XrMqn0hJ1kqb+KQBYOFQTfLHZDpKCFc1gjORdvDUVzL3vgHe6SKJk6r/80I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 13 Oct
 2026 08:21:39 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:21:39 +0000
Content-Type: multipart/alternative;
 boundary="------------QC8alH7cHXUrtLOzAmiDtZWC"
Message-ID: <55ab744e-b178-4689-b0ca-30fdc400d082@amd.com>
Date: Tue, 13 Oct 2026 13:51:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] drm/amdgpu: bind the SPM VMID's page table to
 the reserving VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013075644.775162-1-sunil.khatri@amd.com>
 <20261013075644.775162-13-sunil.khatri@amd.com>
 <3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com>
X-ClientProxiedBy: MA5P287CA0197.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: a35f2a82-9365-4086-256c-08df290300dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|11063799006|10067099003|5023799004|56012099006|4143699003|261009223027099003|8096899003;
X-Microsoft-Antispam-Message-Info: 98u1HBwtmCHTiB0CmRwAyHXIAOs7GURIsObQ45YdtYaOqJ6v+M9VMB5tnxRIudVUXljPapNO2QrAkABxDxxEPcj/NxlVvKaoDWT8d+58kGEiyLvHt5kNnwEYlBA9a572T0vd9lQ0/gIG8H4TDejjXbNZEbpAMfduAyLsZpoDDMmezzY9QTJH8ExhwoLXcqDtCF0vscW1XtmpYPYmJzPO48Zo8DauPwLjP43Wb6y/vDx0CwC4gjVHK171zY2r0OpICy0uZMkgLzsZP6sRaE97P1h57QQsaM06XJUbAZFwNfVWhM3zrpJkmiF1BHreju8ks0AQB71l3yuxySvlXQZWcCtZbCJsEZiLIiaJ7YDdtW0FAxSB5GdsqcatDkQlaKZ0YE+qPc6B5NJoTAvhzd9LW6mRMYs/cg+JzAPFY3LN3IiQ1v2bsWL0iXfNU5zp/m+M5JUUyKXpx3B3PzI00yrdQRPoMAvOrv02VEpdP6kU367CEkQSYWu2zh4A4ckoqbHv33VRZPx1+nPPa9XMN3tP+qa30N6GtEdKHPV69AA5/f/+IybGNrzTgaeY4y2ntiHcM9tfOPz0dE1YjNjJH2BWjqaNo+dh219pR8vn1KsVZjygllO3TJt4ByJFlAdSMaanf2IQtrzRqmKGSQtawyR6wt4hcfsJHmK0/y/rwy7V1jY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(10067099003)(5023799004)(56012099006)(4143699003)(261009223027099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVN4elZraW92NFRhUldTRnJMa0FDcUN1SEh1Q25WMWY0d1RFdiswZi9xVWtU?=
 =?utf-8?B?bFBIMGlPaHRnU0ZkYkNZRElDMTVaVkhoNndKd2FhOW5TRjZMWXB4SHJ2dUN5?=
 =?utf-8?B?aEhzWnNTN3RtTUZMQUZ6T3NSYVE0cmd2OU1UODFrMkhDcFhpeGhKaG0vdXY5?=
 =?utf-8?B?eGxxYzNwTTl5WnYvRHNieUQ2ZU11Nk90ODJKck9hRVNPS3ErQUZ5azJIZ3pI?=
 =?utf-8?B?VjYvbGYxZ2xOaU5FaGdnSEsyakMzYVZvUVViL1JqY1hkM1V3Tk5qRk5nSDN3?=
 =?utf-8?B?RzRlWXNaWmN4NSs1dnd1WHdnL3B4Vy9yNW5VOXVHYkY3dXJpcHRyUG9GTFBR?=
 =?utf-8?B?U3k0dnFIUUcvb0ZOWXJoTytzKzRabjB1UXhrcTNCM01LYTJlcUZRbHJLNE1L?=
 =?utf-8?B?eFJBMHJWdk13cTJ1c0Zza3pvalE4K2xsTGkzalVOVDFtYVhEVHNlV1grYW9I?=
 =?utf-8?B?MS9tNnJKUVd6a1RFM2tiMnNnOE4vbjlnVzZ1NC9QdEhwc1NHSHdBNHpUUWRM?=
 =?utf-8?B?dVJ6SXhCMkM3cGgwVWROTnEwMXNFLzBlekNweFJIc2JoVWE1RGx5ZUpJRFpH?=
 =?utf-8?B?NnFlcE8zVXBrcll0M2pXWmFlRE1TQko0WG9Rb3NSRkUrOGF4dlJpcjFaTStO?=
 =?utf-8?B?VFlMZXFMYmsyR3ZnOXN0ME42OWpFbkt4NktHMFhaSHVNb0c4bmxZb2dqVGtr?=
 =?utf-8?B?VWdKdWw1SndZSko3TVBhT0xBOHpuNWJLb2lqYzI0RU05T0xvYk4zK3BKQlhl?=
 =?utf-8?B?cnlpYXhHUURDWjBoc1RRUGQ2ei9MY1BIeFNQV0JYUGExQm9EOXhXSHYrbjBy?=
 =?utf-8?B?MnpvMmJGNFp0aXJnVEVSTmprSnZwTHF0SjhrUENiL01BSktrbExoaU1VeFY3?=
 =?utf-8?B?Q3JHdVhmeklwMGlXZ1lYemdlQlArdWNsSmtFZXN3Zkk0MkRPYlRYN2lLdkhl?=
 =?utf-8?B?THpUcVcvM3NyOGNvNldRNzJZY3l5ODFtbTZCZksyUVJFRUhxcnRzdXpzbnZv?=
 =?utf-8?B?RVdFVzQxdVJMMkRYc0drS2ZhZ21sQUFHQWV1Z2IyRjJqN3Q1bTBBWndMVHNE?=
 =?utf-8?B?dHlGdVVobVFXRDZ3U29BbmJDR1ROS0hmYnZzWWwzQ2ZUOGZ5L01yd3pSWUpM?=
 =?utf-8?B?QUlPeW9oWVZOa3pGYXZ6R2N5QzJXR1k3eTg0RWhTUDRQVm5LZEdvWU1tQlM0?=
 =?utf-8?B?VHllS3ppWEdCUWQ5a0hubXhudkFUVFpFUTlrSGJwcUlJWnFaQkNaekE2Zk1p?=
 =?utf-8?B?SktacmZYeUNFc1U1NW1OZ0hnUnRSOVRIaGpURjlJVU1vblB5czV3dGp6ZjNh?=
 =?utf-8?B?Z1ZlSXNHQmFudnV3WlNQZ09jTGpGVVJHbENLNklMUXZjTGMwUkdQVXlnTDRz?=
 =?utf-8?B?RHJDN25ob0E5WXcrVXNTeE16bVg0QUhSMWdibUpXMWhhQXl3V1RRK0Q5eUVG?=
 =?utf-8?B?WUdrS3NOTVJMMzY5WnJuS2xFVHN5WUlqdlNpT2t0MnFjZWdnM2ZpLys0QkR0?=
 =?utf-8?B?YUpUU01MZVM3bE8yS1E5UjVGeTB2Y25HYndpTEFPQ2ZYZTdKelVvdy9tWldO?=
 =?utf-8?B?NlRsdk5BWSsyczNZVUg4TmRxSE1jTVZMVkZFdVhVWVVRR1FaN2crazYvSWZl?=
 =?utf-8?B?bDVuYlRCVHp2bWFCV0czMWpKd1loakNoSHhKR1lkaCtvQXMzbzZOdTdzSlI2?=
 =?utf-8?B?TGwyMkJyUlZ4UzlORk9hcGpUaFpBNyt0UzdsK01TTTU1NUxzQUkvZEpRMVB0?=
 =?utf-8?B?dTJRVERya0Nlendpb0MwNUJLRWJFRHVmemtONW03QzRxVkNVaUZNVStGb2Nr?=
 =?utf-8?B?K2RkZzYwclNDWFI4eUFHbGMxUHJ3amFYVG9nZFpEaEltaE12ck1sckl6SHFy?=
 =?utf-8?B?ayt6L1V6MitEMDZzMGxuc3VIVmllUjlzVTlsWnh3Vk9WOEh2Nk43TzVjQU1X?=
 =?utf-8?B?dSt6cXF1a1RZMXVFZWZTdzJsVVZOd2NyRkFGd0g2QUt3TnpKdjQ3c0g4NG9o?=
 =?utf-8?B?VDRWRHkwVVB2STg4cWE0YTYvcFkyR0tWcHRGR2pBaU1GUlhDUjF4Szh1SkVY?=
 =?utf-8?B?UGpienJHRHNlTmVrRlJRSkxBNnZ0MFNSNGVldkZRUkF6OFQ3OVlHQkdGUGpq?=
 =?utf-8?B?cThkSmVHYkl1QUxRcWxaUjRXVzl2VWRjeTJTZ0dOVmlOUUFrZURsaUhtR0lw?=
 =?utf-8?B?MUxkcVJiMG91Ujl1VmhLbGVIU0xlbzRMOUI0aXN5V015cVZNN1NBUHZEUUVm?=
 =?utf-8?B?NThoZDlESUtrUmJzdGJpeFhZeGVURGlWTXN2R2V1SXdkUVBqUmwrNWdYSytZ?=
 =?utf-8?Q?R4iUSY1SvBwYMvzwmB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35f2a82-9365-4086-256c-08df290300dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:21:38.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB7TRjfu6iCCUyBD1kxCIukYMl+2gcuZ7/BrlpOjfLclSyiviwh5xO3z2ra39MKzzYDM3S+qnzXlEs75N0PQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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

--------------QC8alH7cHXUrtLOzAmiDtZWC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13-10-2026 01:42 pm, Christian König wrote:
>
> On 10/13/26 09:56, Sunil Khatri wrote:
>> MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
>> userqueue never got its VMID's page table programmed. Add
>> amdgpu_vm_spm_update(), called from amdgpu_vm_validate(), to bind the
>> fixed SPM VMID's page-table-base to the reserving VM's root PD when
>> that VM holds the reservation; it is a no-op for every other VM.
>> amdgpu_vmid_free_reserved() unbinds it directly to a dummy address
>> under the same lock that clears the reservation, so stray SPM accesses
>> fault instead of racing a new reservation's binding.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  6 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 37 +++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  1 +
>>   3 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 992f7cb3a3102..0ad94b09c6b46 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -581,6 +581,12 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	if (vm->reserved_vmid[vmhub]) {
>>   		vm->reserved_vmid[vmhub] = NULL;
>>   		id_mgr->reserved_vmid = false;
>> +
>> +		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs) {
>> +			adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, 0);
>> +			amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid,
>> +						 AMDGPU_GFXHUB(0), TLB_FLUSH_LEGACY);
>> +		}
>>   	}
>>   	mutex_unlock(&id_mgr->lock);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index de992405ed718..3967dadb8d425 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -568,6 +568,41 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>   	return result;
>>   }
>>   
>> +/**
>> + * amdgpu_vm_spm_update - bind the SPM VMID's page table base to @vm
>> + *
>> + * @adev: amdgpu device pointer
>> + * @vm: vm to check against the SPM reservation
>> + *
>> + * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
>> + * register must track whichever VM currently holds the reservation instead
>> + * of being set per-job like a normal VMID. Bind it to @vm's real root PD
>> + * address if @vm holds the reservation; otherwise do nothing, since @vm is
>> + * not the one that could legitimately change the current binding.
>> + */
>> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>> +{
>> +	struct amdgpu_kq_vmid_mgr *id_mgr =
>> +		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
>> +	uint64_t pd_addr;
>> +
>> +	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
>> +		return;
>> +
>> +	mutex_lock(&id_mgr->lock);
>> +	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
>> +	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !vm->root.bo) {
>> +		mutex_unlock(&id_mgr->lock);
>> +		return;
>> +	}
>> +
>> +	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>> +	adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, pd_addr);
> That function seriously needs a wrapper in amdgpu_gmc.c.
You mean to move this function totally in the amdgpu_gmc.c or let this 
be here and create a wrapper in gmc layet calling this function?
>
>> +	amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid, AMDGPU_GFXHUB(0),
>> +				 TLB_FLUSH_LEGACY);
>> +	mutex_unlock(&id_mgr->lock);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>>    *
>> @@ -630,6 +665,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   		amdgpu_vm_bo_needs_update(bo_base);
>>   	}
>>   
>> +	amdgpu_vm_spm_update(adev, vm);
>> +
> Wrong place for that, this needs to be in the caller of amdgpu_vmid_alloc_reserved() and in amdgpu_userq_vm_validate_and_restore_queue().
If i understood it correctly, amdgpu_vm_ioctl -> 
amdgpu_vmid_alloc_reserved after this call returns when we should call 
amdgpu_vm_spm_update?
For the userqueues,

amdgpu_userq_vm_validate_and_restore_queue{ ...     ret = amdgpu_vm_update_pdes(adev, vm, false);     if (ret)     
     goto unlock_all; is it safe to add after this point ? amdgpu_vm_spm_update(adev, vm);
}

>
> And while at it please rename amdgpu_vmid_alloc_reserved() and amdgpu_vmid_free_reserved() into amdgpu_vmid_alloc_spm() and amdgpu_vmid_free_spm().

Noted

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>>   	if (!ticket)
>>   		return 0;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index b8aa45db1d844..2a2a2ccbaa2cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -443,6 +443,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
>>   			      unsigned int num_fences);
>>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>   int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   		       struct ww_acquire_ctx *ticket,
>>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
--------------QC8alH7cHXUrtLOzAmiDtZWC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 13-10-2026 01:42 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 10/13/26 09:56, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
userqueue never got its VMID's page table programmed. Add
amdgpu_vm_spm_update(), called from amdgpu_vm_validate(), to bind the
fixed SPM VMID's page-table-base to the reserving VM's root PD when
that VM holds the reservation; it is a no-op for every other VM.
amdgpu_vmid_free_reserved() unbinds it directly to a dummy address
under the same lock that clears the reservation, so stray SPM accesses
fault instead of racing a new reservation's binding.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 37 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  1 +
 3 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 992f7cb3a3102..0ad94b09c6b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -581,6 +581,12 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (vm-&gt;reserved_vmid[vmhub]) {
 		vm-&gt;reserved_vmid[vmhub] = NULL;
 		id_mgr-&gt;reserved_vmid = false;
+
+		if (adev-&gt;vm_manager.spm_vmid &amp;&amp; adev-&gt;gfxhub.funcs) {
+			adev-&gt;gfxhub.funcs-&gt;setup_vm_pt_regs(adev, adev-&gt;vm_manager.spm_vmid, 0);
+			amdgpu_gmc_flush_gpu_tlb(adev, adev-&gt;vm_manager.spm_vmid,
+						 AMDGPU_GFXHUB(0), TLB_FLUSH_LEGACY);
+		}
 	}
 	mutex_unlock(&amp;id_mgr-&gt;lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index de992405ed718..3967dadb8d425 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -568,6 +568,41 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	return result;
 }
 
+/**
+ * amdgpu_vm_spm_update - bind the SPM VMID's page table base to @vm
+ *
+ * @adev: amdgpu device pointer
+ * @vm: vm to check against the SPM reservation
+ *
+ * The SPM VMID is fixed (adev-&gt;vm_manager.spm_vmid), so its page-table-base
+ * register must track whichever VM currently holds the reservation instead
+ * of being set per-job like a normal VMID. Bind it to @vm's real root PD
+ * address if @vm holds the reservation; otherwise do nothing, since @vm is
+ * not the one that could legitimately change the current binding.
+ */
+void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	struct amdgpu_kq_vmid_mgr *id_mgr =
+		&amp;adev-&gt;vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
+	uint64_t pd_addr;
+
+	if (!adev-&gt;vm_manager.spm_vmid || !adev-&gt;gfxhub.funcs)
+		return;
+
+	mutex_lock(&amp;id_mgr-&gt;lock);
+	if (vm-&gt;reserved_vmid[AMDGPU_GFXHUB(0)] !=
+	    &amp;id_mgr-&gt;ids[adev-&gt;vm_manager.spm_vmid] || !vm-&gt;root.bo) {
+		mutex_unlock(&amp;id_mgr-&gt;lock);
+		return;
+	}
+
+	pd_addr = amdgpu_gmc_pd_addr(vm-&gt;root.bo);
+	adev-&gt;gfxhub.funcs-&gt;setup_vm_pt_regs(adev, adev-&gt;vm_manager.spm_vmid, pd_addr);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That function seriously needs a wrapper in amdgpu_gmc.c.</pre>
    </blockquote>
    You mean to move this function totally in the amdgpu_gmc.c or let
    this be here and create a wrapper in gmc layet calling this
    function?
    <blockquote type="cite" cite="mid:3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	amdgpu_gmc_flush_gpu_tlb(adev, adev-&gt;vm_manager.spm_vmid, AMDGPU_GFXHUB(0),
+				 TLB_FLUSH_LEGACY);
+	mutex_unlock(&amp;id_mgr-&gt;lock);
+}
+
 /**
  * amdgpu_vm_validate - validate evicted BOs tracked in the VM
  *
@@ -630,6 +665,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		amdgpu_vm_bo_needs_update(bo_base);
 	}
 
+	amdgpu_vm_spm_update(adev, vm);
+
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Wrong place for that, this needs to be in the caller of amdgpu_vmid_alloc_reserved() and in amdgpu_userq_vm_validate_and_restore_queue().</pre>
    </blockquote>
    If i understood it correctly, amdgpu_vm_ioctl -&gt;
    amdgpu_vmid_alloc_reserved after this call returns when we should
    call amdgpu_vm_spm_update?&nbsp;<br>
    For the userqueues,&nbsp;<br>
    <pre wrap="" class="moz-quote-pre">amdgpu_userq_vm_validate_and_restore_queue <span style="white-space: normal">{
...
&nbsp; &nbsp; ret = amdgpu_vm_update_pdes(adev, vm, false);
&nbsp; &nbsp; if (ret)
&nbsp; &nbsp; &nbsp; &nbsp; goto unlock_all;

is it safe to add after this point ?&nbsp;
</span>amdgpu_vm_spm_update(adev, vm);
<span style="white-space: normal">
}</span></pre>
    <blockquote type="cite" cite="mid:3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com">
      <pre wrap="" class="moz-quote-pre">

And while at it please rename amdgpu_vmid_alloc_reserved() and amdgpu_vmid_free_reserved() into amdgpu_vmid_alloc_spm() and amdgpu_vmid_free_spm().</pre>
    </blockquote>
    <p>Noted</p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	if (!ticket)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b8aa45db1d844..2a2a2ccbaa2cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -443,6 +443,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
 			      unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------QC8alH7cHXUrtLOzAmiDtZWC--
