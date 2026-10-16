Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD65CCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 12:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3639110E246;
	Fri, 16 Oct 2026 12:43:54 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6E510E246
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 12:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsvY5oHmPCwuVnF1Bty6S9ANV5xSXGlDmIf0mjansXJWspvavImFrdsE8lUd1C0/uhz4e/mzwEZ/xYElrMWVktfiyvaND1XnANelirjmIZEFP9hZas0tz7Uy98pcV7ZcUITZCUKGu/w1+E9dVmUTATsrb8wqgxMbw4g615NXm1JHKZTI6JMJDy4x03I4rUlH0I9Q+nfEISEkivFIRuP/5mP5iCjJfJOdQ1biMDgZLNii39Mm0lJvsweD9z7FlKIpGu9sdg0wQca4yqA0kmR5F+qJFprhazk6mlQ6wDLfgRA3xyq124DG1v62vr5AfULmIjjRxaoX1kgpl1Dpr8dYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qw4em5IhTrWa9U92ph7XOEvA3c0ru7TCVEXZcj1eYo=;
 b=OjemoS1o3YVc2P6QEyxQdtAPgApwHeUBmkbTlh2liz2H3PBjMm4qedsVDzZd4UyGtRditWHr9zBqjqV4tLzqkyBol/h/S+jy7Rkwh1Ok3wzqxQyWZrwrUdQf415uJTjmSdITLNE2Aut0Lxc3Q+znp5x7MPbdDBUv66GJuL9UFzb6YD9YUmJi9HcWxR0n2iL2c3p+cXS4pSG5QkAEhcrBHSnhHHwZjfuVcGbcSEr9Np5YF3wSWZm9gK8YtJqmmeGIpp3yFpZDGZIupbDTaTzXIn3REt7ZQHJIlPHprgTxSoRRyo+sm8xs66agKXUCQDTzA6jhGiepRn1dVwvQOPkkuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qw4em5IhTrWa9U92ph7XOEvA3c0ru7TCVEXZcj1eYo=;
 b=LJPOMZPF2CVpuFuCldx9KsKJzjY1Njm9SZLY5MGiESlT0TLsGy4xqjPgPIgiwn5mNC6ohBURGgr0g95qlvmtpvBX6JWEzckKZQMrRguxBP0TOhQRG9WybdMapj8EghnbGrtMXuuZb2bWb7oH9U2LqwHQZkKukIKNzhdrNJ1n7fc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB106381.namprd12.prod.outlook.com (2603:10b6:8:4f2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 12:43:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 12:43:44 +0000
Message-ID: <d58714a1-7189-43a4-83e0-140c32b4feb8@amd.com>
Date: Fri, 16 Oct 2026 14:43:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: rename amdgpu_vmid_alloc/free_reserved
 to _spm
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013112112.1449531-1-sunil.khatri@amd.com>
 <20261013112112.1449531-2-sunil.khatri@amd.com>
 <a1676db3-7de7-4a49-a41a-433133fc4913@amd.com>
 <7bdf01f2-a727-4fd7-8815-96c6d537b827@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7bdf01f2-a727-4fd7-8815-96c6d537b827@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:52c::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB106381:EE_
X-MS-Office365-Filtering-Correlation-Id: de55aac4-4ed6-4add-8494-08df2b831cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: wfKYZXzhnYi105ryYH6gKMFBXP+UrXBc1RWncPYXYEVREZnrgnGDGRka0CDSxFPTtRTbANqG8yisK6dx2cNV6oOlQ/MVdDCT6PZmnt6Va5a/AwBOH3/0rw8YzheSBy+RxieFdO7dl5c8pC7eYs+GF9adJwS5aW09d5IW/0CbINgpSIJtQBTTLhLPv4+8Gv8SdRu851wl+PnOcwwh5joaHFXhk8qRZ+WpWF7SGrTemydrnG4Yrl4dHVQotWNvA3oad8RYy/NPyzjKWjjKg2MUKZVhILaeZb4cNyIGQm2Eo9M2R1kleR90MhDUwrjCaQ+gZhMPhITkDlmI1y7nwSsbangwY0etlG7x8L7WydxSAYmd0eYSNP1/wx2BhpSGQo4KNXmp49+KK0keNUJwmcx1C6EuzJQWaSCZnGhQGMdavyR5w7hpv8E3ZkGX6oOJQRUpEJfLMKEyEGHe++77C6GCj4fhacfywhmgfQb2uX8RNXse0qv9YjOn0SmxW+6nxmOCpKTRa7BbE6d2BAbsmF5bQARnLxg8eOrLCm7NKyB4M7EoRILxl1PD/bbg8rLnYB4kK5vxsHk7mrs66e+URQYPpMfz6QmAe5knBOKxOduCL785xN0NXz4jLPFJko5bboAR6ZimLu6081jhsqRTUrrjNd3OALz+ohetpZq/DHl7E9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25FMmRRNGREakFPa2orMGFXNUJyVDdEaUJwMnN4TmhObFU2aDd0YWNZeHRx?=
 =?utf-8?B?Mk9zM2kxTWNZZjJEcS9mdHpYa0hKbjFyUTlCUi90aXM3UmJGQkxWR2ZWYmxK?=
 =?utf-8?B?OEN6b2YyZGpqRjBIdGVYMUxtY1poTElYbHNZQTVjWUpwQ1JPSFN0eUNVZG1x?=
 =?utf-8?B?ZUl3cXVIUTliUVFEWDI1dEZ5VFVnUGR6WGl0MVdmTlA3NkovWHVhZ1lnWlcz?=
 =?utf-8?B?Y21oMnBGZFZpdy9DSHRTUm1UL1o3R1lQQTNsTTBQTE84REdMU1JobjFGek1s?=
 =?utf-8?B?U3JZVEo0QmY5SGJsSUJ3NjY1Nk9aY0x0L0pZWktvdnFpS3pyemp4UUtsTzFz?=
 =?utf-8?B?ajk0bVJhNGMxN0NFVVpOM2F3WTNSYXNXTU5vN29NVFJJcjdHTHNIZGpFR0Rx?=
 =?utf-8?B?NFVtckxKNUlXVjJtaFYzK2FGR2JJN3ZtK2NtanIwc0dvL2lvMUlrT3J3aTZz?=
 =?utf-8?B?OG1WemFQOGhvR1M3OUt2bExBRE9XVlpTMkRZbmp6OFdXSlVNV3U4d2trZ09Z?=
 =?utf-8?B?cGtDQUtyamkybGJRSnBjU2FvRGZkdFNma2FhU04vOVRneUhNWVlOLzFwNVR5?=
 =?utf-8?B?QnZBakNxaFFQL2QrTFRSUWZTb2k5cDE3TS9Oc0pFK0hmMitwMlBsUFBNditO?=
 =?utf-8?B?TE1QNy83MnFOdjZ2bnBXNFZYc1BNMS9sdmpnTkV4R1NaQVd1Q2U5R2dkYUIz?=
 =?utf-8?B?cTgycVRJTG1BZzczRURZYzZGSG10cjh4MWprTDRyVzZrTW9HWnNtY2RuZWl3?=
 =?utf-8?B?NGpVN29QTGNGc1dEektwZHYwZHltVVNsa0RWbk1IbHo5TUY0cWZUYTNadi9X?=
 =?utf-8?B?WC9lTWlJTFhPYjlGS01YaVQrd2dzU0tON0pKZStvekMzemhReVJzc0U0bGZI?=
 =?utf-8?B?UVRWci9UMHRVODhKMmovY3JuaTk4cW5FWjZSV3JZaUtDYUxHR3pucldxMnNv?=
 =?utf-8?B?Q1hSbGM4TFRCUkN3MFErNTlzaW9uRzlUYmtxV3QzN0FUMmdEbUtqMmkrUXlH?=
 =?utf-8?B?WUhvMzRTYnVLTDBUeERxTFYrREtmK3RSZG5RMkoyQ1hpaVRicCtrUEU0b3pB?=
 =?utf-8?B?emZseHRpOWNhRHExRWE2VEh1dWdpd0xaR2ZCRHBxLzh5aTEwZERDTG1nNEUr?=
 =?utf-8?B?bytndzV2cHFqQ0RmZEhEWkhSRmpObEdKaGhZczhKdUxEcGpnZHlWRVJOZXdS?=
 =?utf-8?B?RmdCUHEwSTJscE1SbjFQWGtaWmEvaCswUUJWR2RjUHduKy9jdVA3OFRBVkFa?=
 =?utf-8?B?aUVVREs3OHRoNktqYlEzamJueFN0RVNsZHFDMU15bC8wSUF1L0MzZ1JEOW9D?=
 =?utf-8?B?REVsYmhoalg0Q2liMHBjNWJKUWl5UWx0UWFjM0E5Y3NGam5mNVJYaDloZmNB?=
 =?utf-8?B?ZHdTaG1pSXg1SUs1dkZEbmVNVzZvVy9mSGJFOHE2Y2IyRDM3cXAxUnR4b296?=
 =?utf-8?B?bDdHQmg0c25MSkUydU9KZ1dkZ1k3elg4WTh1ZFEzSVg3dzBBOEcwOUcwQW5l?=
 =?utf-8?B?eFRBTHhwYlR2SkR1bUdQeG1makUvN1pZNEhFNmpBa1Y4UGY2RnhIdUlybkRY?=
 =?utf-8?B?cWRUSlhNd25RQXZ6L2tLUzRuZXFiY01WNGpUUTlFdGcweGdkbU9pL1BYdFVu?=
 =?utf-8?B?cm9mUEVZRkloVlp2eVpNZjFOS1Bxd3hFVGt3OTJJbHRpWk9hRzNHdXFPRE9C?=
 =?utf-8?B?N2ZXeDhyV1N5alhZY0kyZU4wc3EwZ2V3cjNGbHVJc21aWXFFQ0lraTJrR0pX?=
 =?utf-8?B?ZUlCU3MybGFQNXFXcnFjZlNxUjNGK0Voek9UTkZvKzV2YzU0eTFrdUg4K1Vp?=
 =?utf-8?B?SGN4NmNYMmpxNW55WlBOSHcvNHhjV0ZpZUFjcGM2TVdkVU1CdkUzOEFHYlRH?=
 =?utf-8?B?VnA1cm9PZnhMTUg5WDZwdWdNRXhsSTl4NU1EbkVaSHJxTm93c3ZPb1VqYTNM?=
 =?utf-8?B?em42cHhrYXJkSzAxNjRIcHdOZGd2WFlmOGo0RlMvdnhIVnppVHVSazZxVjF6?=
 =?utf-8?B?ZjJtV3IrZVYyQXk4d2VlSTBpUGg4UFM0akhwdDMzbVJYbmY0aTdDVCtuWkpl?=
 =?utf-8?B?a0hEaC8yNlgzTy9NTSswNlc0akNaUHNBc3l0YTNMZ3NMV2F1SkdOSFl6YnBv?=
 =?utf-8?B?amFneEgxMFprdTh2VUVoaGMwSHhyZlZkRHJ0Ykl1UVJzYXg2NGMxb1hCZ25X?=
 =?utf-8?B?UGxLcElEQlZOSVJtZjdsalFZNXdxRWcwNUt2TDlhZVNMemgzZXdMa0ExZmdU?=
 =?utf-8?B?RWlUdkxGc0pWYWNoK1pqdjk3aWJucDFMRTVYaDBhT1RENnoxSW9ZOVJwRFdh?=
 =?utf-8?Q?bcH/CKesN0RHCOza14?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de55aac4-4ed6-4add-8494-08df2b831cfc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 12:43:43.9945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reJh4GMMwZfLts/Y/+SCmAprluj7Rvy0m/FDzYvJ2BfAvnnbNbCnECBYQ7zemP+K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB106381
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

On 10/16/26 13:41, Khatri, Sunil wrote: 
> On 16-10-2026 05:04 pm, Christian König wrote:
>>
>> On 10/13/26 13:21, Sunil Khatri wrote:
>>> These functions only ever hand out the dedicated SPM VMID now, not a
>>> generic reserved VMID. Rename them to amdgpu_vmid_alloc_spm() and
>>> amdgpu_vmid_free_spm() to say so. Pure rename, no functional change.
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 8 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 +++---
>>>   3 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index e5d84a786c4f2..f15702993eeab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -589,7 +589,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>>>   }
>>>     /*
>>> - * amdgpu_vmid_alloc_reserved - reserve a specific VMID for this vm
>>> + * amdgpu_vmid_alloc_spm - reserve a specific VMID for this vm
>>>    * @adev: amdgpu device structure
>>>    * @vm: the VM to reserve an ID for
>>>    * @vmhub: the VMHUB which should be used
>>> @@ -598,7 +598,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>>>    *
>>>    * Returns: 0 for success, -ENOENT if an ID is already reserved.
>>>    */
>>> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> +int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                      unsigned vmhub)
>> I think we also need to make sure that the hub is a graphics VMHUB.
> 
> amdgpu_vmid_free_spm/alloc passed explicitly AMDGPU_GFXHUB(0) only... i left the function deliberately to be generic but caller is within the kernel and we hold control to call with GFXHUB only4

Yeah passing AMDGPU_GFXHUB(*0*) is not 100% correct because we need the vmhub depending on the partition the VM uses.

But I think SPM is not really used on that HW or otherwise somebody would have complained already.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
>>
>> There is really no use case for an MMHUB here.
>>
>> Apart from that looks good to me,
>> Christian.
>>
>>>   {
>>>       struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>> @@ -629,7 +629,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>   }
>>>     /*
>>> - * amdgpu_vmid_free_reserved - free up a reserved VMID again
>>> + * amdgpu_vmid_free_spm - free up a reserved VMID again
>>>    * @adev: amdgpu device structure
>>>    * @vm: the VM with the reserved ID
>>>    * @vmhub: the VMHUB which should be used
>>> @@ -637,7 +637,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>    * Waits for all work that used the reserved VMID to finish before unbinding
>>>    * its page table, so submissions still in flight don't suddenly fault.
>>>    */
>>> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> +void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                      unsigned vmhub)
>>>   {
>>>       struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>>> index b85aa2ee19b19..c134000eecfdc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>>> @@ -125,9 +125,9 @@ void amdgpu_pasid_mgr_cleanup(void);
>>>   bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>>>                      struct amdgpu_vmid *id);
>>>   bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
>>> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> +int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                      unsigned vmhub);
>>> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> +void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                      unsigned vmhub);
>>>   int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>>>                struct amdgpu_job *job, struct dma_fence **fence);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 7fd6215510a94..8d4c13f2ef7fb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2894,7 +2894,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>       dma_fence_put(vm->last_update);
>>>         for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>>> -        amdgpu_vmid_free_reserved(adev, vm, i);
>>> +        amdgpu_vmid_free_spm(adev, vm, i);
>>>       }
>>>         ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>>> @@ -2997,7 +2997,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>           int r;
>>>             /* We only have requirement to reserve vmid from gfxhub */
>>> -        r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
>>> +        r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
>>>           if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
>>>               amdgpu_vm_spm_update(adev, vm);
>>>               amdgpu_bo_unreserve(vm->root.bo);
>>> @@ -3005,7 +3005,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>           return r;
>>>       }
>>>       case AMDGPU_VM_OP_UNRESERVE_VMID:
>>> -        amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>>> +        amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
>>>           break;
>>>       default:
>>>           return -EINVAL;

