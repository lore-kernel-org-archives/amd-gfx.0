Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4E5CA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 14:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0DE10F429;
	Wed, 30 Sep 2026 14:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHnVJ8W4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2F710F429
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 14:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBe5XL/EiGCxo+/ubGznnkSk8yXr1DsKSLmR1TcTv/SmXm/3MI80mBdsmLZrc79YvFYg9CpMpJLhcyeJfSz7fVuvLJXg3YpDWNX2k0hxH7HTIw9we0wOpVP7S960+Vph8DSj4yF9ArTMQyDyLq5kwRGFgPaxR8M1cUN+oeJzIeF1+Lwj3qGBRj4vGNwoF1ZjarNk4XAjxbYgzzu/G1Hx0VFAW3tDC+bWfXLY/F0Zp/UiqC+x3T5/jAmE6YYgXpbaD3IbLFCIO6YrRk1NRxT86qtoa1j2XkXBoqOzQKUJfY6SySoBpx8j8w5r5j8+jAD/WivHOdkgw3Wk8AzbNGZv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaXI5QlcVtqUfQ3cw5defECoTMs0JLLE7MRdafTRKbg=;
 b=cVuc+KoCrWHh6HBZwmyFkRqIC7drGoUvaiZliiu/DTR0CuOn8MdktbOKoqQO9FOIIKqMm062uskCpvzAlX/4b9N6E9KR+A8MzTtRIhS2qd0CWJx57ynhS4wJxKQlWbkRvqYQ+Lxn4tTcAOoQHas1LDQoyrah4xRFI8ic7pTxSKQxi9UB1GpJox8THxvtfZkT/Z4XDUpPTGzb4V0XoD8TMy9cd4cPiNaEMfSawRxFS1nX8m6EmC0gkAKsEGIOkgJB3zYM0x7XhcwvpYB+0oHr22eJoW4ASQjbbwqPWI37bdNJWX9Bljx4Re9cSl9CS8OPDT1Jnfk1xcWuLx/SSsgBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaXI5QlcVtqUfQ3cw5defECoTMs0JLLE7MRdafTRKbg=;
 b=vHnVJ8W4BWSwWkr50K5TUeVgvnwC3oZqQBwaAdLi2iJ6TA2C6I25GP1e45yyaWUNP/4W5i8t45YNkOliYrpVj/NV1BJ6xX9RKnYxhU2G0DaNJNTr5rOUvWUIdRCkjgjsP2PwAMIhqAgaB3JB1Tvw3bg7t0CSgd9pHCBLx1zCV1Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SA1PR12MB7150.namprd12.prod.outlook.com
 (2603:10b6:806:2b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:44:44 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:44:44 +0000
Message-ID: <7b1ec2f8-0619-4132-ac35-bc2722755b97@amd.com>
Date: Wed, 30 Sep 2026 10:44:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Philip.Yang@amd.com, cascardo@igalia.com, tvrtko.ursulin@igalia.com,
 "Joshi, Mukul" <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
 <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
 <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::13) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe1dd7a-63aa-439d-cb92-08df1f015e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|18002099003|56012099006|11063799006|22082099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info: LKqcX97hYlCvGWeLdO3NP4Fwjy+0SsFnHtzaD1ngSP39hig73cDxaRbpK+kNeoMxIrygu2AHYGbOiSZj+MO6vzcC8Fy4plg8UstxBgogoXQrnpcK92C8jJnaNnraCPZ/Jvkjo/p0ky6fw9MiSIB+d/7PnvssVR12nXLQdPbNk0gVcVVcmGyBOAz7V3HGdvny/BAiIeEzDE8vHyEK5dXD7BPqaR8GGpklx85P/ycUNDq3akgmxk2pVxTKDzTnhrYjU6R33KXgelTygDeF0nb57KcpQo0vBUV/nMfKknStfJJDpQJQ5tPSqwXTmsPeklqFI3d9gqVpNyQ25YON8j68jv7AVWVikKCvdH9ELiK9cqU067WehV+2bD0qzjCr1t0fezPryacWfaca3JiODhc8/dwkLa0KOFxg94Gph19b6Gpwn17AliYRzL84dZfm7NnGewL1Xpy8ViksCBXCZtZqZhjbZXTUM1XK/yaUWflDkbXzXWhb5QwO7+hE6V821qRCqXj6kLdxEMqVB/gtyNMCknNuIlsE9c+mU3GiaM/KW90F1yuoT+LjhywxblKKNlFT/8EP+c/5BatMUaBncy8TXV5soFoYYU1xz6TWHK4vU98aAsSI/UJ8v4gQ3vuJc+RqjVwx2MP5y6nJJiUtYwrRH/FyDpMaZap/fT3L2yE2rIvOBWc+MZM+O4OVDn+rFgtOImOLCxlhlDNi/jKfix7bvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003)(4143699003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJPNlJGS3IzdzNUb2xuaVpoTzQyalE2M1d5RzRUYVJzbFVwOXoxQXhWdUl0?=
 =?utf-8?B?dlNOdGdHeTVVUk1JeUlTMUxnU0ZXTzNwaUNwZnFLWHd1Rkg0MjJNZDlBdG9Q?=
 =?utf-8?B?QStkZm1iNVRJVE9raTRmQ3RwTU5PWGpiZG1TUFFvVHpTaklLV2YxR3lHS2Rm?=
 =?utf-8?B?TjhRZHZGSHhIbTZKa3Jac05IRDI2VU9DSUR0eGpPRDl2L3Z6QytoK3lBR0Uw?=
 =?utf-8?B?bkhCWDFMVXZYRDVyeXprNjVsTlZsMmJMN2hjc1ZLb1BqRDB5WkZGTkpkbFhx?=
 =?utf-8?B?WjVSSTltdTdTbi81VDFEa05IUGZ6WHZoYXE5WHE2U0g0cVA3RDcwNWFlUFhn?=
 =?utf-8?B?d1FXQUp1TGcvbzJBNzRJZzgrYU03c1NTd3RZMmFUb25QRElKdlVibHJhYVl4?=
 =?utf-8?B?Qk51aXpOUjdKanNCSXlLSy9oTEhDYW5LQ0tWdUV2ZkFhSisydC8vNzB4ZG5B?=
 =?utf-8?B?dVZRVzRuWEVHTmE1aENVUnlTUk5Rd0JwNUpmaHZmVlpLYnA0OEp2Y0FJcUc0?=
 =?utf-8?B?NkRlSUJ3WkNpU2tQRTJKWUpqaFlaZGR5Z0xhNDVNUSt6WTZHTnZnNUdiTS9w?=
 =?utf-8?B?SHJTK3ZKQllNb1cxSFE4OVRVU0s3cjNyL2l6T2k0S09rNmR4REtQWnVtWmhU?=
 =?utf-8?B?OFJxOUZKNzdqS0ZJNmlHcEtJbUdVYUs1cC9SdmpsQVUwakQ1M0cvYThjUG5E?=
 =?utf-8?B?Qkp5dU1na0RER01OdHFzL0NodElPdyswYU1EYjRZUlZDbGVDa0JseEZyYjlh?=
 =?utf-8?B?QjFWTko3b3I5UlpFKzl1VEJyN3hISlNGUTYzcm9VREpFQVNBZVV0YmNvRTF6?=
 =?utf-8?B?eGllWTFoblBLbjFyN0pKZ3NmN0ZKYWY5aUFkVTd5dFZVNkNJS01YT1kwQkRl?=
 =?utf-8?B?ZWlSYTRWbm10Rkk3cnE5THVVTmNGZG96N3JUb2NEZkJQRVBEeG5wVlRONmNV?=
 =?utf-8?B?dWlEai9kQ1UzOFVqREt3a3pyU2Rob2c4M0t2M215R0tQTlFQbHNzVzRKazkx?=
 =?utf-8?B?MmRPOFVsblE4RWlBT0VobHQvYnB0TWxycVA5WFRDbCtwK3lrY3dBc280ekZU?=
 =?utf-8?B?WGdtY2hUbUk2V3lwUzlBRUhSRjFYMitKVVhaWWJ6WlBuL09GL2Z0d291ODNT?=
 =?utf-8?B?STRWRkpQMXBWeU9YRE00aExMUkw4QXFpSlg5d3Jwalh6VlUrdUVnY1hZOEwz?=
 =?utf-8?B?cENuOGZiV2NMOHRyNXpTdzhYZmYxbXh5a3JIdWZYUld2OUUzVjM2ancvbmNS?=
 =?utf-8?B?ek4wb0VjWmNtLzNtcUdpT2NxcWV6ZkJnZHJtdTI0cFdLNHB4MWExZzFXRmpm?=
 =?utf-8?B?Ym5BS1hDYVN0UFJaVks2R0cvUjAweXhvYVZ3VGxjSmszMFZMT2FSWHV3enp2?=
 =?utf-8?B?ZUxKWllQTTF2STdLeXF5bGRNcHN3ZUJLYlJpNHJQVWx3ZjhSTUFJQ0E2TTE1?=
 =?utf-8?B?ZEhsMVd1ZXc1NmdCVVpGNHJOcktFRWltYTBUdXZTVVg5Q0R3Y3BHVFZPK3M4?=
 =?utf-8?B?OXphUlZXcTJuT0lvZHlra09Hd2lDOTdqTzRGcnNkQUp0aStJOWNyMitKcTJx?=
 =?utf-8?B?Nk12a0lPcm8va0RzZnNRanlvVVhqdTd3OFFZcU55U1YzNnYvRVY5Q3V1Q1U3?=
 =?utf-8?B?UUdmZklORnhyOG9vYlJDMU9LeEVFczBDNWkwU2dSVU8xa0dOMy95UmVrRnBF?=
 =?utf-8?B?MklpLzEvWGpONmk0b0JFdEZLS3pFS2tYbkRFZXNnQnRoRStiSUI4QmJydERk?=
 =?utf-8?B?NzRMZ2VHR2krbnFlZy85bU5TM2x5RVFDblRzODlBdGhiQXNMUzdZNFdMT3kw?=
 =?utf-8?B?VzRNaVM2V2ZES2QzR2tPcmllakZXWEVBTjlFYnFaN3d3WGI3U01EWjk5Z0dU?=
 =?utf-8?B?WlFjTkpha0pwNjRrRFR6NGZRVmxwYWgraVdtSURwdFJ6akxJSmx5amxGWml1?=
 =?utf-8?B?MDFob0x3Ty92VFRaeVpOZngyTGZxbWg5blJOUFNwd2pvNlVyYTZGNmRISlJN?=
 =?utf-8?B?UGFVUWpBZXkzVDhJSDU4U0FzQkw4TzhESGcxRnR6NWdoY3cxWG0yazZ1czZH?=
 =?utf-8?B?RGt4K0ZNTFVFdHdtSFZzUGVXUWtFeDVIZ3l3S2VWZWNWRCtJMmRVMVJmOHlB?=
 =?utf-8?B?UmdFWDdGc2tYSTNUaHlYZHNPWFhwb0R2OEV2bThNamd3dG5seEFZSDlCNFNQ?=
 =?utf-8?B?UEExUi9wM2pGeG1EWjZQMER1UW4zb0FxekdScHE4YUtLR1JVcXB4NFUwMnpo?=
 =?utf-8?B?dVZiSVgxa253SHdqekxiNG4yWGI1MGM4eU82ZzI4dG8rRkdxZ1ZkUlc0UzZa?=
 =?utf-8?Q?R1Gq2qs6lQ/LNdLi9f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe1dd7a-63aa-439d-cb92-08df1f015e12
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:44:44.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bh4ZKdc2XddMOHzvcbLkHYwxM/xk9Mr1xuMiCUSTSlb2YeSDGBDbbwphOdzcfcHia27x26PdplYW5cyQGXFBrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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

[+Mukul]

On 2026-09-30 05:02, Christian König wrote:
> @Felix and @Philip any objections to this patch?
>
> It is actually a bug fix for the NPA support.

As I understand it, this fixes the flags used when unmapping memory from 
the NPA VM. We passed adev->gmc.noretry_flags from 
amdgpu_ualink_unmap_npa_addr to amdgpu_vm_update_range explicitly in the 
flags parameter. I guess that's no longer needed with your fix. But I 
think the end result would be the same, right?

Regards,
   Felix


>
> Regards,
> Christian.
>
> On 9/28/26 21:08, Timur Kristóf wrote:
>> On 2026. szeptember 28., hétfő 11:10:34 keleti államokbeli nyári idő Christian
>> König wrote:
>>> That was broken since adding the NPA support.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64 ++++++++++++-----------
>>>   1 file changed, 33 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
>>> c03327f1242d3..e8f441e018839 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
>>> *adev, amdgpu_vm_pt_continue_dfs((start), (entry));			
>> \
>>>   	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev),
>> &(cursor)))
>>> +/* Return the flags used for cleared PDEs/PTES */
>>> +static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
>>> +					struct amdgpu_vm *vm,
>>> +					unsigned int level)
>>> +{
>>> +	uint64_t flags;
>>> +
>>> +	if (adev->asic_type < CHIP_VEGA10)
>>> +		return 0;
>>> +
>>> +	if (level != AMDGPU_VM_PTB) {
>>> +		uint64_t value = 0;
>>> +
>>> +		flags = AMDGPU_PDE_PTE_FLAG(adev);
>>> +		if (vm->is_npa)
>>> +			flags |= adev->gmc.noretry_flags;
>>> +		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
>>> +	} else if (vm->is_npa) {
>>> +		flags = adev->gmc.noretry_flags;
>>> +	} else {
>>> +		/* Workaround for fault priority problem on GMC9 */
>>> +		flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
>>> +	}
>>> +
>>> +	return flags;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_pt_clear - initially clear the PDs/PTs
>>>    *
>>> @@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>> struct amdgpu_vm *vm, struct ttm_operation_ctx ctx = { true, false };
>>>   	struct amdgpu_vm_update_params params;
>>>   	struct amdgpu_bo *ancestor = &vmbo->bo;
>>> -	unsigned int entries;
>>>   	struct amdgpu_bo *bo = &vmbo->bo;
>>> -	uint64_t value = 0, flags = 0;
>>> -	uint64_t addr;
>>> +	unsigned int entries;
>>> +	uint64_t flags;
>>>   	int r, idx;
>>>
>>>   	/* Figure out our place in the hierarchy */
>>> @@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>> struct amdgpu_vm *vm, if (r)
>>>   		goto exit;
>>>
>>> -	addr = 0;
>>> -
>>> -	if (adev->asic_type >= CHIP_VEGA10) {
>>> -		if (level != AMDGPU_VM_PTB) {
>>> -			if (vm->is_npa)
>>> -				flags = adev->gmc.noretry_flags;
>>> -			/* Handle leaf PDEs as PTEs */
>>> -			flags |= AMDGPU_PDE_PTE_FLAG(adev);
>>> -			amdgpu_gmc_get_vm_pde(adev, level,
>>> -					      &value, &flags);
>>> -		} else if (vm->is_npa) {
>>> -			flags = adev->gmc.noretry_flags;
>>> -		} else {
>>> -			/* Workaround for fault priority problem on
>> GMC9 */
>>> -			flags = AMDGPU_PTE_EXECUTABLE | adev-
>>> gmc.init_pte_flags;
>>> -		}
>>> -	}
>>> -
>>> -	r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>>> -				     value, flags);
>>> +	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
>>> +	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0,
>> flags);
>>>   	if (r)
>>>   		goto exit;
>>>
>>> @@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct
>>> amdgpu_vm_update_params *params, flags |=
>>> AMDGPU_PDE_PTE_FLAG(params->adev);
>>>   		amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
>>>
>>> -	} else if (adev->asic_type >= CHIP_VEGA10 &&
>>> -		   !(flags & AMDGPU_PTE_VALID) &&
>>> +	} else if (!(flags & AMDGPU_PTE_VALID) &&
>>>   		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
>>> -
>>> -		/* Workaround for fault priority problem on GMC9 and
>> GFX12,
>>> -		 * EXECUTABLE for GMC9 fault priority and init_pte_flags
>>> -		 * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
>>> -		 */
>>> -		flags |= AMDGPU_PTE_EXECUTABLE | adev-
>>> gmc.init_pte_flags;
>>> +		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm,
>> level);
>>>   	}
>>>
>>>   	/*
>>
>>
>>
