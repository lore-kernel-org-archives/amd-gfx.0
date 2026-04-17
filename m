Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6483CF8DFF9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 18:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12C610E2C8;
	Fri, 17 Apr 2026 18:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9/yjtDp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B7210E2C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 18:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3ULfw8kxbVZCCrCEL5ObptKnON+bT0puzPnL8EEPD2pow/eFOHwStJyaP6a1paJgYyXTfRpaYHnBVNUtN9UhGLQKWGbY+CwGVfQcUraOXI0Ck03E27PLqzikGiAibC+9fqpWnIpIXBwlI+LgW/L9jr0GfvYd4sT7C6ubZv9wdTyNCdQXknSivYpNlLN1ZcosBrzcHQg3rY7tPhUJepsNGdx9ebPrscodKWUNm5DvhYNE/400wLCz14+4K45W+rQZdQRQjqeKzgYMRZqXDegeSIORG571W4Nb3p2ozpIbImVaOCAQOQWMcmh0qMoC4XD9sICSb0zSFFUZWtX68Wq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehoSVjcNiziLCJ6Iv2ZqXtLr2gJAljKK8EuZe4BORVA=;
 b=WmQFxJiSBHw9k/ZglIqUYLyfhKrgoaQ8/0ATqXd920LPVR/+C/jWzIQ3yxx0tCbNjxiprGiezkAM+2iXHiph4r89gahWjj9qdE4FUY9KSC8by70m6x+qrYY6pHczL6WFN7uuP2lz2BcO2VvKoxrzib7FK5KPbYrXDkZWsPWHCl1T4ui7XUIGRgDJ4kbNaO4a8juubSfdPWw736jFdyG6DvpllYaBWiOv1oiH7NvirjojmBuDedJClrC0NA5x/R61mxQgkPzm60TGbSCnXLHupn3DVdcSEZCD/u5HSXh/rnTibSgIGdVefaZog/0D/uMX7m9z6fPdGRjZgqIutbR9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehoSVjcNiziLCJ6Iv2ZqXtLr2gJAljKK8EuZe4BORVA=;
 b=X9/yjtDpU2ag8DCZK+Ud+CEQSd6hHo7oHtbjuw4OX7TmmgcjRgA2BGGTpMhJLBFETsp1Gce5iDk+a45l1zm/w7yX+dkzUpoHeda+V8Pso+bW3y3OpMhrFtxE91/KlV1v+6keoR4ucxQKuWiSBzSH5n14xkp3WI2irgTLWHPJ+18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA5PPF80B25317E.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 18:40:46 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 18:40:45 +0000
Content-Type: multipart/alternative;
 boundary="------------jtSFDgYwVtwGXQM5hBrxjZof"
Message-ID: <b4d323f3-6ed7-40a5-beff-e3f0b6db8ba5@amd.com>
Date: Fri, 17 Apr 2026 14:40:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move VM PTE MTYPE override to per-PTE
 granularity
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260417135025.3434482-1-Philip.Yang@amd.com>
 <b48fb991-9d12-4299-83e4-936a60267bd7@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <b48fb991-9d12-4299-83e4-936a60267bd7@amd.com>
X-ClientProxiedBy: YT4PR01CA0376.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA5PPF80B25317E:EE_
X-MS-Office365-Filtering-Correlation-Id: 720f9266-54a0-49c9-6de4-08de9cb0d618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: Z6JdGY+Lj/+XBVStvA9HJrXvQBfXbdzcHiXvcns9qrOy36xEMf+htrN+TIUTMf7tcWmCgRGX6+99abteohtSQNxa0PeJ84+Ow4AkC646voN+NOXof3DraMotaf7Jv8eVX3fJp7D9vA8YNOEUGug7IK4KtNWaRr/AnBSoPHdrDJojxE/cJNyXnB5z24mbbAB0moWowu5ZsQMaBPXkA56PnlHb6cFF00qq0TMhfDw3yfs4ayEkMHfUXWTUDpp/yQMGyhha9utUxUSctDYW4wVFqmG2knrBB81ozp4iG6RW8FI2x9Pm5IqUkihZewI3KmUUNOtEBegPJ01cFlWASBXN2Mo13nvzLVgy7rQGYdJdYI3BRE8VkQ2s98+G+7eXMQmDo+2UqeODObvt9S9lUd4LDMLBlF2AB0o7hIMjp+Fk4JttJfl8P11QxsnRUhJObjgGaaBFD++qLYJHEGjctYBReFkkMIV0zl8++rhkTTSfL+VA8svy23WzyQr5+lt14FpdEuFuGIPoAuproVXI9WOA96WI5REZiSRAB5JUANVVG0zP3qZmdqZc72X+zoFSWGDfZE9b/SUqzBm4wgIFaJftC/jKw/QpO++r/5u/L5U70KrgYEvxn0/9ZsAnJys/GfAPK6I079bPTQSaMSLgZB2o/RP1uTupNJ4tRjn1oKLuLknlP2r4S9J+Fss1Vm+bWlO+IS9ATtLInNBcVoweKAV8XEglEumiom7UdIG5+tw8eM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRBcTR1WTZHeklONkNoRGFyQXFBbG9HRXVMbk1uRFdMalJ1WHdXSDdDbzRj?=
 =?utf-8?B?bXlEOVMzbG0vQkR1a3Nwd0txMUJHUk5MOVhRaFFEL0x2ekZyVEZJTC9YUC8z?=
 =?utf-8?B?djYwSXpPbWgvbDA4OUJZWTdmb2xLZzJMQndIVm5YT3RiZWtreEVCYXMzS1hN?=
 =?utf-8?B?Yno0NlZOVytEU0xyM0ZndVczTmxVdm9BK2lkWU41bVVzaW83aDBFa0FzU2FS?=
 =?utf-8?B?cmJ5cGxsT0N3cWx4ZTFoMUxWSzNKSFVIMnFGU0RHL1RkelllZkxkY3NYUW1a?=
 =?utf-8?B?azV6L2RvZlhraHZISnZsbFZlM09NbjVyRFkyYTZPRkpNdFlJMTI1VllZNnY2?=
 =?utf-8?B?RTVNVWducitkc0hUdEJMeFJKRitQL3p0L3hNN2F4aWhUTjVsUzFmMExIb2Rk?=
 =?utf-8?B?S1paZFVBOCtxMGU0bmRXTGZTRGM0amlvejNEQkxhell6NGhrOFRITWNWNWNI?=
 =?utf-8?B?cHNlRFdod1NrMFVRNExhYUtnRzMxR3JSUExPdCs2L2xyN0F1Ym82M2pqSHVN?=
 =?utf-8?B?RDBjL0dpSSsvSm41UWhua2hMRUZuNHhJSnNEbFptRC9WbkZjd0JhbFV4WXph?=
 =?utf-8?B?Vk4rL3RVNDIrYkxXbEROS3graXczK3R0emRJNjIrZWF3L0dJMTNEelpGa0dT?=
 =?utf-8?B?eUZzRWJDVjFscmNZMWloMjkyZ0x6UC8wMkpaRTgzdmhmUk9OMUZWMnJoTkRW?=
 =?utf-8?B?ZnoyVFRyZ2oxcWlJbjB4QXRZZFdTanNFeThPOWpqNFJFYjVyZjY3T1FsZlN1?=
 =?utf-8?B?cmhDRkI3Nm5vZkZOcWpaV3dhTUdON21pZjdtMi8rTnhwbnA2ams5bExaYURI?=
 =?utf-8?B?NzFMdVVaYUVzTzZ0eDAxclVwVDZ5YklwbGp2ZUFYeHBIdUhLYkk1QmhQVFhz?=
 =?utf-8?B?ZTFPb0N4RU5yejVXTm9uMEx5ZDBWdlp1bUpEbGU5WFFjcmFzVDFWOUN6UHB5?=
 =?utf-8?B?RjNmV3NVNXNnU1hoVXJJTWE2UkthVHFsU2J1Q1BFUkFrOWZOcmJxZHovMW9C?=
 =?utf-8?B?d2VKMkNkMEt5c1B6NGVBNWU4c1QzbXBhaEtnRnhuK2JXMGFwVUVhRzllazJh?=
 =?utf-8?B?NWIrOG4xeERiN0duVVlkUW5jc1B1Rld3TTNoeWZraFVVdjg0dkkyRmtvNlVU?=
 =?utf-8?B?ckJTREtPbUdGUVZpWVFXeTdLcy9tN3I1a05mck11VFVzaGZoNkx1S3RYNVNW?=
 =?utf-8?B?cC9MWG9vd3UzVjdMRjY2N21kcS9wL2RGTVJrU1RhamhDR09LNU5EYVBqZ3J6?=
 =?utf-8?B?RlRmVFRIRGxTdmhoRjFibVBNcWNCNFhVTWJNQnNSblViYXh1alpUQ0M0R254?=
 =?utf-8?B?dlZVMEdwQVNmdUpNUVNvaXdjZ21PdEZBVXd1ZkVPQUxSSmFTankwYVZyVWdm?=
 =?utf-8?B?OGNsQ05mZjcwdHFuVmYvUmlQc3hMQTMyS0dSQTZzenpzdFVEWHJGLzk5MEVl?=
 =?utf-8?B?bmFseDJxdStEbEdWbnI3ck5pTk1iVThRWEhwSmhweEZxY3FkaC9mbXFiMnpu?=
 =?utf-8?B?NlVJMkxtUGg3T01nV3NrQWFQZU9UNXB4WWZQZUdGd2FEaFRyb2VBY0JheTFO?=
 =?utf-8?B?SHlhb3dNcmxrVE40ZjliL2R4MEJqNHFhc0cwajlUR0dhcDltUmpwWGNCenRH?=
 =?utf-8?B?R3VaYVhoUkEva3JNYUdJekNzd3FhNnRzTUFUV28wand1UjIxMkJqMis0ZEV5?=
 =?utf-8?B?YWZzZ1MvN29mSGkzUHFYR3V5WXQvOSsyYXFqd3B4TU9xL1JDVml6TWlZcW1j?=
 =?utf-8?B?NnFTQ1BqbkQwTnlrM1BkTnRiNkZjRVlKTVc3NDRuVXp4M0JkSXk0Nk83bkNm?=
 =?utf-8?B?YTNSSWx2Q0xTeFBJUFV1Z3RvS1V5TVQxRkY4cG4xRjg5ZHpWci9vU3Q3RDhV?=
 =?utf-8?B?bVQrbktXbXdWYzJRb2FhRWNjRHZHdVp2SXJoQWZqL2k1UGV3aXZ2SUtMa1k0?=
 =?utf-8?B?UGNJejlNYlJZNUVydUJkQU9rcjE0M2ppdkJ3cklVYnl1a0ZKcWsyc0hrajZm?=
 =?utf-8?B?cHNoS2FHUk56RnFxTHc4bUtrOHorcGVpTnFaQnNHUFA3TkFvQUJmTnJhTTJ4?=
 =?utf-8?B?VUIrTWRGTVdQVnVWRG5mVGVPWDRPTnExWlBUc0UxMnZkbDJBSHI5NWxlWUY0?=
 =?utf-8?B?TjVqbGRQZEk5K1F1ZCthMXpJTHk5WlJ2N3p6cnlSVTJ5NUFUdzliVDNmWmVE?=
 =?utf-8?B?NjRxOG1FdUNQc2xNMjNJeGV0S2RYRTJFYUJiZWNmVW55ekI1bm5ITTErZ29R?=
 =?utf-8?B?c1FRUjcxWFZkc2RMd2o1N3ZhODVKYVFMWmpIRXZsK1U4QWZxMVVPaUJqdi9t?=
 =?utf-8?Q?+ZNZgFTB98N4tDaVoj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720f9266-54a0-49c9-6de4-08de9cb0d618
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 18:40:45.7272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7ssbIX0/2pxfXvL2WPC+m2zrhnynFHZUNUi8vvBEqfdWz1QNYzChCIRwagMTsHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF80B25317E
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

--------------jtSFDgYwVtwGXQM5hBrxjZof
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-17 10:04, Christian König wrote:
> On 4/17/26 15:50, Philip Yang wrote:
>> Refactor the NUMA-aware MTYPE override for VM page table entries:
>>
>> - Move the override_vm_pte_flags call from the centralized
>>    amdgpu_vm_pte_update_flags() into the individual CPU and SDMA update
>>    backends, enabling per-PTE MTYPE override including for scattered
>>    pages (pages_addr path).
>>
>> - Move APU, IP version, and direct-mapped eligibility checks from
>>    runtime (gmc_v9_0_override_vm_pte_flags) to init time
>>    (gmc_v9_0_set_gmc_funcs), selecting between gmc_funcs structs with
>>    and without the override function pointer to avoid repeated runtime
>>    checks on every PTE update.
>>
>> - Guard allow_override on whether gmc_funcs->override_vm_pte_flags is
>>    actually implemented.
>>
>> - Move amdgpu_device_check_iommu_direct_map() earlier in device init
>>    so ram_is_direct_mapped is available when gmc_funcs are selected
>>    during IP early init.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 50 ++++++++++++---------
>>   7 files changed, 55 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bc7e96b58d3f..b139475f65cb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3860,6 +3860,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	 * completed before the need for a different level is detected.
>>   	 */
>>   	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
>> +
>> +	amdgpu_device_check_iommu_direct_map(adev);
>> +
>>   	/* early init functions */
>>   	r = amdgpu_device_ip_early_init(adev);
>>   	if (r)
>> @@ -4117,8 +4120,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	if (px)
>>   		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
>>   
>> -	amdgpu_device_check_iommu_direct_map(adev);
>> -
> That should probably be a separate patch.
ok
>
>>   	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
>>   	r = register_pm_notifier(&adev->pm_nb);
>>   	if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 63156289ae7f..853204b5bd73 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1163,7 +1163,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	params.pages_addr = pages_addr;
>>   	params.unlocked = unlocked;
>>   	params.needs_flush = flush_tlb;
>> -	params.allow_override = allow_override;
>> +	params.allow_override = allow_override && adev->gmc.gmc_funcs->override_vm_pte_flags;
> Prerequisite check first please!
adev->gmc.gmc_funcs->override_vm_pte_flags is not NULL only if all 
prerequisites are true.
>
> And we should probably rename params.allow_override as well. Maybe something like override_pte_flags similar to the name of the callback?
will rename to params->override_pte_flags, don't change allow_override 
parameter of function amdgpu_vm_update_range
>
>>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>>   
>>   	amdgpu_vm_eviction_lock(vm);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index f33ea7f8509b..326522917131 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -296,8 +296,8 @@ struct amdgpu_vm_update_params {
>>   	bool needs_flush;
>>   
>>   	/**
>> -	 * @allow_override: true for memory that is not uncached: allows MTYPE
>> -	 * to be overridden for NUMA local memory.
>> +	 * @allow_override: true for memory that is not uncached and gmc override function is
>> +	 * implemented to allow MTYPE to be overridden for NUMA local memory.
>>   	 */
>>   	bool allow_override;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> index f078db3fef79..fa5d4ac2ef39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> @@ -88,12 +88,21 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>>   
>>   	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
>>   
>> +	if (!p->pages_addr && p->allow_override)
>> +		amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
>> +
>>   	for (i = 0; i < count; i++) {
>> +		u64 oflags = flags;
>> +
>>   		value = p->pages_addr ?
>>   			amdgpu_vm_map_gart(p->pages_addr, addr) :
>>   			addr;
>> +
>> +		if (p->pages_addr && p->allow_override)
>> +			amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, value, &oflags);
>> +
>>   		amdgpu_gmc_set_pte_pde(p->adev, (void *)(uintptr_t)pe,
>> -				       i, value, flags);
>> +				       i, value, oflags);
>>   		addr += incr;
>>   	}
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 31a437ce9570..883cc275f354 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -707,15 +707,6 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>>   	if (level == AMDGPU_VM_PTB)
>>   		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>>   
>> -	/* APUs mapping system memory may need different MTYPEs on different
>> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>> -	 * to be on the same NUMA node.
>> -	 */
>> -	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>> -	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
>> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
>> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>> -
>>   	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>>   					 flags);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> index 36805dcfa159..37f0c0027075 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> @@ -257,6 +257,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>>   		}
>>   
>>   		if (!p->pages_addr) {
>> +			if (p->allow_override)
>> +				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
>> +
>>   			/* set page commands needed */
>>   			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
>>   						incr, flags);
>> @@ -275,8 +278,14 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>>   		p->num_dw_left -= nptes * 2;
>>   		pte = (uint64_t *)&(p->job->ibs->ptr[p->num_dw_left]);
>>   		for (i = 0; i < nptes; ++i, addr += incr) {
>> +			u64 oflags = flags;
>> +
>>   			pte[i] = amdgpu_vm_map_gart(p->pages_addr, addr);
>> -			pte[i] |= flags;
>> +
>> +			if (p->allow_override)
>> +				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, pte[i], &oflags);
>> +
>> +			pte[i] |= oflags;
>>   		}
>>   
>>   		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index e7b78027002b..479611e269b8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1204,21 +1204,6 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>>   {
>>   	int local_node, nid;
>>   
>> -	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
>> -	 * memory can use more efficient MTYPEs.
>> -	 */
>> -	if (!(adev->flags & AMD_IS_APU) ||
>> -	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3))
>> -		return;
>> -
>> -	/* Only direct-mapped memory allows us to determine the NUMA node from
>> -	 * the DMA address.
>> -	 */
>> -	if (!adev->ram_is_direct_mapped) {
>> -		dev_dbg_ratelimited(adev->dev, "RAM is not direct mapped\n");
>> -		return;
>> -	}
>> -
>>   	/* MTYPE_NC is the same default and can be overridden.
>>   	 * MTYPE_UC will be present if the memory is extended-coherent
>>   	 * and can also be overridden.
>> @@ -1231,11 +1216,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>>   		return;
>>   	}
>>   
>> -	/* FIXME: Only supported on native mode for now. For carve-out, the
>> -	 * NUMA affinity of the GPU/VM needs to come from the PCI info because
>> -	 * memory partitions are not associated with different NUMA nodes.
>> -	 */
>> -	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
>> +	if (vm->mem_id >= 0) {
>>   		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
>>   	} else {
>>   		dev_dbg_ratelimited(adev->dev, "Only native mode APU is supported.\n");
>> @@ -1328,6 +1309,19 @@ static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
>>   }
>>   
>>   static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>> +	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
>> +	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
>> +	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
>> +	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
>> +	.get_vm_pde = gmc_v9_0_get_vm_pde,
>> +	.get_vm_pte = gmc_v9_0_get_vm_pte,
>> +	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
>> +	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
>> +	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
>> +	.need_reset_on_init = &gmc_v9_0_need_reset_on_init,
>> +};
>> +
>> +static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_override_funcs = {
>>   	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
>>   	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
>>   	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
>> @@ -1343,7 +1337,21 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>>   
>>   static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
>>   {
>> -	adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;
>> +	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes, local system
>> +	 * memory can use more efficient MTYPEs.
>> +	 *
>> +	 * APUs mapping system memory may need different MTYPEs on different
>> +	 * NUMA nodes.
>> +	 *
>> +	 * Only direct-mapped memory allows us to determine the NUMA node from
>> +	 * the DMA address.
>> +	 */
>> +	if ((adev->gmc.is_app_apu && num_possible_nodes() > 1) &&
>> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>> +	    adev->ram_is_direct_mapped)
>> +		adev->gmc.gmc_funcs = &gmc_v9_0_gmc_override_funcs;
>> +	else
>> +		adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;
> I think a flag in adev->gmc would probably do as well, no need to duplicate the call table.
will remove the duplicated const call table, add flag 
adev->gmc.override_pte instead.

Regards,
Philip
>
> Regards,
> Christian.
>
>>   }
>>   
>>   static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)

--------------jtSFDgYwVtwGXQM5hBrxjZof
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-17 10:04, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b48fb991-9d12-4299-83e4-936a60267bd7@amd.com">
      <pre wrap="" class="moz-quote-pre">On 4/17/26 15:50, Philip Yang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Refactor the NUMA-aware MTYPE override for VM page table entries:

- Move the override_vm_pte_flags call from the centralized
  amdgpu_vm_pte_update_flags() into the individual CPU and SDMA update
  backends, enabling per-PTE MTYPE override including for scattered
  pages (pages_addr path).

- Move APU, IP version, and direct-mapped eligibility checks from
  runtime (gmc_v9_0_override_vm_pte_flags) to init time
  (gmc_v9_0_set_gmc_funcs), selecting between gmc_funcs structs with
  and without the override function pointer to avoid repeated runtime
  checks on every PTE update.

- Guard allow_override on whether gmc_funcs-&gt;override_vm_pte_flags is
  actually implemented.

- Move amdgpu_device_check_iommu_direct_map() earlier in device init
  so ram_is_direct_mapped is available when gmc_funcs are selected
  during IP early init.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 50 ++++++++++++---------
 7 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bc7e96b58d3f..b139475f65cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3860,6 +3860,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * completed before the need for a different level is detected.
 	 */
 	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+	amdgpu_device_check_iommu_direct_map(adev);
+
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
@@ -4117,8 +4120,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev-&gt;dev, &amp;adev-&gt;vga_pm_domain);
 
-	amdgpu_device_check_iommu_direct_map(adev);
-
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That should probably be a separate patch.</pre>
    </blockquote>
    ok
    <blockquote type="cite" cite="mid:b48fb991-9d12-4299-83e4-936a60267bd7@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	adev-&gt;pm_nb.notifier_call = amdgpu_device_pm_notifier;
 	r = register_pm_notifier(&amp;adev-&gt;pm_nb);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..853204b5bd73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1163,7 +1163,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
-	params.allow_override = allow_override;
+	params.allow_override = allow_override &amp;&amp; adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Prerequisite check first please!</pre>
    </blockquote>
    <span style="white-space: pre-wrap">adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags is not NULL only if all prerequisites are true.</span>
    <blockquote type="cite" cite="mid:b48fb991-9d12-4299-83e4-936a60267bd7@amd.com">
      <pre wrap="" class="moz-quote-pre">

And we should probably rename params.allow_override as well. Maybe something like override_pte_flags similar to the name of the callback?</pre>
    </blockquote>
    will rename to params-&gt;override_pte_flags, don't change
    allow_override parameter of function&nbsp;<span style="white-space: pre-wrap">amdgpu_vm_update_range</span>
    <blockquote type="cite" cite="mid:b48fb991-9d12-4299-83e4-936a60267bd7@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	INIT_LIST_HEAD(&amp;params.tlb_flush_waitlist);
 
 	amdgpu_vm_eviction_lock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f33ea7f8509b..326522917131 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -296,8 +296,8 @@ struct amdgpu_vm_update_params {
 	bool needs_flush;
 
 	/**
-	 * @allow_override: true for memory that is not uncached: allows MTYPE
-	 * to be overridden for NUMA local memory.
+	 * @allow_override: true for memory that is not uncached and gmc override function is
+	 * implemented to allow MTYPE to be overridden for NUMA local memory.
 	 */
 	bool allow_override;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index f078db3fef79..fa5d4ac2ef39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -88,12 +88,21 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 
 	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p-&gt;immediate);
 
+	if (!p-&gt;pages_addr &amp;&amp; p-&gt;allow_override)
+		amdgpu_gmc_override_vm_pte_flags(p-&gt;adev, p-&gt;vm, addr, &amp;flags);
+
 	for (i = 0; i &lt; count; i++) {
+		u64 oflags = flags;
+
 		value = p-&gt;pages_addr ?
 			amdgpu_vm_map_gart(p-&gt;pages_addr, addr) :
 			addr;
+
+		if (p-&gt;pages_addr &amp;&amp; p-&gt;allow_override)
+			amdgpu_gmc_override_vm_pte_flags(p-&gt;adev, p-&gt;vm, value, &amp;oflags);
+
 		amdgpu_gmc_set_pte_pde(p-&gt;adev, (void *)(uintptr_t)pe,
-				       i, value, flags);
+				       i, value, oflags);
 		addr += incr;
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..883cc275f354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -707,15 +707,6 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 	if (level == AMDGPU_VM_PTB)
 		amdgpu_vm_pte_update_noretry_flags(adev, &amp;flags);
 
-	/* APUs mapping system memory may need different MTYPEs on different
-	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
-	 * to be on the same NUMA node.
-	 */
-	if ((flags &amp; AMDGPU_PTE_SYSTEM) &amp;&amp; (adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;
-	    adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
-	    num_possible_nodes() &gt; 1 &amp;&amp; !params-&gt;pages_addr &amp;&amp; params-&gt;allow_override)
-		amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
-
 	params-&gt;vm-&gt;update_funcs-&gt;update(params, pt, pe, addr, count, incr,
 					 flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 36805dcfa159..37f0c0027075 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -257,6 +257,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		}
 
 		if (!p-&gt;pages_addr) {
+			if (p-&gt;allow_override)
+				amdgpu_gmc_override_vm_pte_flags(p-&gt;adev, p-&gt;vm, addr, &amp;flags);
+
 			/* set page commands needed */
 			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
 						incr, flags);
@@ -275,8 +278,14 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		p-&gt;num_dw_left -= nptes * 2;
 		pte = (uint64_t *)&amp;(p-&gt;job-&gt;ibs-&gt;ptr[p-&gt;num_dw_left]);
 		for (i = 0; i &lt; nptes; ++i, addr += incr) {
+			u64 oflags = flags;
+
 			pte[i] = amdgpu_vm_map_gart(p-&gt;pages_addr, addr);
-			pte[i] |= flags;
+
+			if (p-&gt;allow_override)
+				amdgpu_gmc_override_vm_pte_flags(p-&gt;adev, p-&gt;vm, pte[i], &amp;oflags);
+
+			pte[i] |= oflags;
 		}
 
 		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e7b78027002b..479611e269b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1204,21 +1204,6 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 {
 	int local_node, nid;
 
-	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
-	 * memory can use more efficient MTYPEs.
-	 */
-	if (!(adev-&gt;flags &amp; AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3))
-		return;
-
-	/* Only direct-mapped memory allows us to determine the NUMA node from
-	 * the DMA address.
-	 */
-	if (!adev-&gt;ram_is_direct_mapped) {
-		dev_dbg_ratelimited(adev-&gt;dev, &quot;RAM is not direct mapped\n&quot;);
-		return;
-	}
-
 	/* MTYPE_NC is the same default and can be overridden.
 	 * MTYPE_UC will be present if the memory is extended-coherent
 	 * and can also be overridden.
@@ -1231,11 +1216,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* FIXME: Only supported on native mode for now. For carve-out, the
-	 * NUMA affinity of the GPU/VM needs to come from the PCI info because
-	 * memory partitions are not associated with different NUMA nodes.
-	 */
-	if (adev-&gt;gmc.is_app_apu &amp;&amp; vm-&gt;mem_id &gt;= 0) {
+	if (vm-&gt;mem_id &gt;= 0) {
 		local_node = adev-&gt;gmc.mem_partitions[vm-&gt;mem_id].numa.node;
 	} else {
 		dev_dbg_ratelimited(adev-&gt;dev, &quot;Only native mode APU is supported.\n&quot;);
@@ -1328,6 +1309,19 @@ static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
+	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
+	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
+	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
+	.get_vm_pde = gmc_v9_0_get_vm_pde,
+	.get_vm_pte = gmc_v9_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
+	.query_mem_partition_mode = &amp;amdgpu_gmc_query_memory_partition,
+	.request_mem_partition_mode = &amp;amdgpu_gmc_request_memory_partition,
+	.need_reset_on_init = &amp;gmc_v9_0_need_reset_on_init,
+};
+
+static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_override_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
@@ -1343,7 +1337,21 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
 {
-	adev-&gt;gmc.gmc_funcs = &amp;gmc_v9_0_gmc_funcs;
+	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes, local system
+	 * memory can use more efficient MTYPEs.
+	 *
+	 * APUs mapping system memory may need different MTYPEs on different
+	 * NUMA nodes.
+	 *
+	 * Only direct-mapped memory allows us to determine the NUMA node from
+	 * the DMA address.
+	 */
+	if ((adev-&gt;gmc.is_app_apu &amp;&amp; num_possible_nodes() &gt; 1) &amp;&amp;
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &amp;&amp;
+	    adev-&gt;ram_is_direct_mapped)
+		adev-&gt;gmc.gmc_funcs = &amp;gmc_v9_0_gmc_override_funcs;
+	else
+		adev-&gt;gmc.gmc_funcs = &amp;gmc_v9_0_gmc_funcs;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think a flag in adev-&gt;gmc would probably do as well, no need to duplicate the call table.</pre>
    </blockquote>
    will remove the duplicated const call table, add flag
    adev-&gt;gmc.override_pte instead.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:b48fb991-9d12-4299-83e4-936a60267bd7@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> }
 
 static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------jtSFDgYwVtwGXQM5hBrxjZof--
