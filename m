Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372FBCC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE1810F52D;
	Tue, 13 Oct 2026 07:37:30 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C55E10F53E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjEAMiY83nnL73oPURVN7XoR9ewDUU//iV+hk2t8CAG2bHWZvhdjluroAm832OVLVUrr0OpxzhJ1T6ni3sFH7Q1Atc7AbUx+iyiWypfak7ES4LLNFhMb6vef6XF3V/JUG1PwNlyrOPFuR80hzJABfdF0+XFSsZj1dG5hVWB3FlqjeWiHUJHwRZWB/qaIMIB5dWNorkgmpL3xsXHeGcHhrcjPshTIOAmuymx+BWQ+rcMEOZvdJ5gju4dB4H0DQ7db899LXxXkPiRI25/j/AincsR8oKt2tvl7kUHuAv6gAgSa412lTPDWA26ABxarIQDh3RL1I+5sETz+XqsbZRPl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWRD1vX3z1tprvYt6wU/4Ee6p6+i1/3r0NVJPqcw3tI=;
 b=JkEsGUdJIe18WubRXW/dDAbVSThJM/7ncVc0++QEe2cHas6q5v47iEIsRAVaZHae+iDMmtgkZuSaBIjHcZU2dnFTymPQGS8yRtr7M2wusxzZ24MMjW19xG10eBDCneKDvOM87INW7DWQLTFjiCmBcg1mRdNzhf5K6+fk/IEZoJhhpniBexau1bXNkqeJSruwC7ZgYHdif7JA+0ylcGxO8eTvXMPOpzP0TovZoEAgvJ0a1iIDYWGbTYpmhKl+oTkinWIRaztoq0KGgPA0h2dDKL4+s7CK1p6p1yp71+dKqRcuM9UJ8agWMnO5yO62i+qsBMDkZSUfSSMDhDzHvZzxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWRD1vX3z1tprvYt6wU/4Ee6p6+i1/3r0NVJPqcw3tI=;
 b=H8t6E07XFYRIbEoalH7Ny6lZMzfl6Lh2ziiCaom/djE/vlXH/8EKjg2jqeTVySwlLKNk9AXzGZYB6DvW1hs0Ggg6A2DvBaWZvEtyE6yJzH0Px2lmwBJZqsLSVGyTns3ChhUTInQjibg7FeQKQ3tL8MzRYi74Acm1iCgDOVYziwQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:37:20 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:37:20 +0000
Message-ID: <b1234815-c324-4025-91e4-a138c15ba25d@amd.com>
Date: Tue, 13 Oct 2026 13:07:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] drm/amdgpu: remove the now-redundant runtime SPM
 VMID update
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
 <20261012092429.3937825-11-sunil.khatri@amd.com>
 <5bb454e9-65ae-4c7b-89ec-468d0b202538@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <5bb454e9-65ae-4c7b-89ec-468d0b202538@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c58fcb4-14d1-47fb-250d-08df28fcd08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|4143699003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: tKdZ6w86R5fSxug+VA1iqDuR1QuDO6DHx7kN43V4WvsU/b3guFNe73mR6g8o4UkiYNWmIEoKKM+fLkn/MG4B911x7FU/NeaA25Otb59l+5H6Ph15c/sFVOdAHnK8zxZ/x4IqWLCtChZu446Xue30PFRY0xHncpiMylE85WOPNUD3X5TkEuxmMAf6R7o9J0TwguiojqxN0F8bzhJZ3oPHAWcBUEw/0KVKcfOti1XmrRZi2mz/GUpHik6psg8QlkIdKq29E4I1QCXV0i76KsUogzOhq5TRqbBHj/uNk4Pr/LWfbyZCDXOJZfwphUnC+ntBockBtsLfQTvxlcP6ks7C+yvUhtZcZC1mfzdcmFmz8HDFR9onbTwSWgJbBWMXSTOvvD21Oiw8AwQNPLWwCnx+AAUVXXLykgl2G+uH2ZAOLhUJLha6VjMzuajZXV8fX3CS/n8lH3eVZp02IYJQJjkrxR1SnLs/fvEH+lmZzHCiEknR1MQXN9CL0uukflKFjZjItKNHeuX+Jp45ozbFx7VHMquWoLBwAInQxD/JrfRmP/yABuZxIHaevFK1qRphEJ12rS5Reicy25XbR8cwtqvp9mehlZtqZBraERIwnCe0RZgX5ZpE/JTdJlez+yntfZ38dKA0RURINRsChnfUUsR1EGGU22PlPBTMMbvjMgppkgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpFaEp6UUVVMHdtUko4NTh4QjM5M25DZEFtVEtxODNVMmc0ZkFxS2pnYWhr?=
 =?utf-8?B?NkEzb3d0dUdXUk04NW9MRWJqUWltaVlQS3BYdnhFNFB6Y05MNmIxMFVUSnBs?=
 =?utf-8?B?ZGdpSVRlQVVJNVU2RzRBbU9tV1FJY2lUUHBLSzBhUCtXV0szUG52Vmw5dFMw?=
 =?utf-8?B?NC9EZzhZdHdzelArOFJhcnFldmVlZFo1RFBlSXB2eTNBYjAzdXUxMmMzeTVC?=
 =?utf-8?B?UnQ3WHNiT3VjUDh6U0lzNHBzT1o3WU5IMHp6VlZEciszTi8rcWZ5UWNlSEZQ?=
 =?utf-8?B?ak9JTFFZZkJJUTE3QndzVkx3Z0VpRHJxaFJKaEdEYXM5YmtIbDdZb1oyZFhR?=
 =?utf-8?B?NFRxV2EwcGVvcWZOVCtMci9BVHJlOWRhWmlqZm1MZjlRbnBwcGYwdVdPMzhV?=
 =?utf-8?B?VjhtVWs3K2pmNnFGRjl0OXpKT1MzdkRvejBEcnRYbHR2alEybUhDUjgvTjRh?=
 =?utf-8?B?RnJybSt6bXpSK0tuc1RyNTVZSG0rWkVJSlY3a0FWK0FuK1ZvZy8yaGZkZytO?=
 =?utf-8?B?Z2V4R0cyMUs3YkVSOEhlcHNzVSs3bUtKWGxpTHNFMkc1U2k1S2tUU3Z2QVJ5?=
 =?utf-8?B?ZVd1bGk5SExmYTMydnR2THhwZGk3RVBIT29PRi9UczhpYlJGVmx5VkNpYzRO?=
 =?utf-8?B?QzJZZW1OMnVQNTRPVytWNit3ektwUlNKcnZkNkFoRG83UVJRZFE2cHJ4cysz?=
 =?utf-8?B?bzh2TDgva2t5dlRVT2FoSTV1OEpFL0dydENMSzJ2dW9LTlZYRkxBNk5jZGtt?=
 =?utf-8?B?VXhEYzBmSnRadVFqUmFpVjZGTzh6cEVrN3FTcy9kNU0zTlZhQTF2bFJlUTNx?=
 =?utf-8?B?bnhtZG1FdUNtMjRQRXhtMlhFSWhKaUt4V0IxaktaYkZCbVRCVFBLSXgwY2ty?=
 =?utf-8?B?c0QvL1h0M1NiYVNtbHVBUHJqS256R2NGZHhNdmcxbDlqMlZ5N0YxZDNJMCs1?=
 =?utf-8?B?NDNJUm1uMWtTOGJlVEw3RjJkakJGTnhGSjVMbTF4bjR1TDhmRG1lVlNDVzNJ?=
 =?utf-8?B?V3A4eDAvWGV6NDZydFVUUWFUdzBJVkhYbjk0NTFwWFI4c2oxa1AvV3pxWHA1?=
 =?utf-8?B?RzUwMHVEVlJlWDdaV0NFVkNzeHZ6dlNVVGw5aWYzallDSzlYWlRzWUNKN2N3?=
 =?utf-8?B?d0hjMDRSeUNheG5ScmJ6WTlUNXdBM2FnTEZXUzhIVXVnNElmdmcvSDY0anFk?=
 =?utf-8?B?OHlJMHRIQU1HakRVYVFOdVZldm1sSUh6MjFTTklndDlZNVgrU1ZnWmFFY3Za?=
 =?utf-8?B?MXFlUXRVeVRaTVErZWc0Z3MwV3hpaEhvbVNEU1hvN25kQkcxaFk3bW8rdkFM?=
 =?utf-8?B?cW9YNHcyb2VENHhBSm40Z1FqOWxnK21pNGQwZk9YWHMyaVBkL04xVmxBb2xF?=
 =?utf-8?B?YUVuYlJLRFE2a08xK3VNYXZUMjFXeldOcVJiaFI0RlltRXE4dnFqd01IMmxs?=
 =?utf-8?B?WERuN2l0c2hTZ3ZoRmdXQldobVhOVUdNVEVPamdVQVkyTmFYcC9DaXVwNWRy?=
 =?utf-8?B?L2Q1VHFKVFI0b0htQ1c2aHhsSitmSW5wVjRrZXNMaGQreEtlL3dvODMyazJk?=
 =?utf-8?B?ZUN2aHQrYjRBUjdVcUdLaGMwOXd3SHgyUHF1SkFpaGhZVjFRbXRaL2VsYWRu?=
 =?utf-8?B?RkN3N1dES3hFejJaUytTVVhOOXpYUGV2aGxiQU40bFFNNGJ3RkxsSFRnTkFm?=
 =?utf-8?B?QUdaVTFkMDA4K3M5L25QV2FpRGk4NW9xUm9meGtTMFZPSWQ5bTJTMUwyL0tQ?=
 =?utf-8?B?eC9WTTlGKzZraFNPT1h0czE3ZnV5Vkh1THYxVHV4b1g5UGl1ZHBXMW8wdWFm?=
 =?utf-8?B?Q2xWa0pzeXNZenFhRWF0cThoZXpuOWM1U0xrZjRHK0M5RWU0ZUVRam5xVVY3?=
 =?utf-8?B?RUJNcWxQQ2xyT0hEQkJJSnE0L3h4MzNEMWxYNVRPODBSWmZMNFBqbDN1YWk5?=
 =?utf-8?B?TUxiajd2blhPSTl3Q1F6d1BmNmJmQWVzQXo0NUhEVHMyeENYSEJPRmRsNTlW?=
 =?utf-8?B?TkxIZWZxVFYwbWk0dW1MWmd4WDRrS3FOYzJxenpGUWZLaXR0Ky9xSEVORDdm?=
 =?utf-8?B?MTJCbmJoazFBdEVWTXovZ05rbEUxQzI1MEExeHFIOTZSdW5QSFp5aUFZSEVR?=
 =?utf-8?B?N2hvaXQyeE9nYW5Fa1A4R3pQc3VIMW5ZTkR0ZzRLeWszaE9VeG1nVEZ5T3Fr?=
 =?utf-8?B?TXVoM2xWcVNzT1VuSmZXUUhoMzRpV3R2UFJWNzA3NnorUUx1RFBrcmNSU3cv?=
 =?utf-8?B?SkVxMVRlZU95WVR0cWRPVU0zYnhodm16b3VOaGlIQnc5YTRsVldFT3VsY1ZT?=
 =?utf-8?B?QTZ0ODNNcUNGRFR3TTNiN084Z254NkczVjJ0OXpWTHJkSExYb2Y0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c58fcb4-14d1-47fb-250d-08df28fcd08e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:37:20.7494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWtNyqGIYEGSZ1oTMb/QYPy0I4MdKWh5WKxxm5KmiOM+ipeX5gqQXjdgVvi2517mIEHnl3sCpt5qiwyign6wCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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


On 13-10-2026 01:01 pm, Christian König wrote:
> On 10/12/26 11:24, Sunil Khatri wrote:
>> The SPM reserved VMID is fixed now, so retargeting RLC_SPM_VMID to
>> job->vmid on every submission is dead code. Remove
>> job->spm_update_needed and the update_spm_vmid() calls in
>> amdgpu_vm_flush() and amdgpu_ib_schedule().
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> We should also have another patch which removes the ring parameter from adev->gfx.rlc.funcs->update_spm_vmid().
Sure... There is another patch that i kept for the end and will send in 
the updated v3. This is to set the pagetable for vmid15.

>
> What's left is comming up with an SPM test case and eventually getting it to work with user queues (shouldn't be to hard).

sure, here i might need some more input since i am really clear about 
the exact usecase or how to validate it..

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  7 +------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 15 +--------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +--
>>   5 files changed, 3 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 0f8b097001e3c..f98a7c6797b3c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -126,7 +126,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   	struct amdgpu_fence *af;
>>   	struct amdgpu_fence *vm_af;
>>   	bool need_ctx_switch;
>> -	bool emit_spm_needed = false;
>>   	bool emit_gds_needed = false;
>>   	uint64_t fence_ctx;
>>   	uint32_t status = 0, alloc_size;
>> @@ -195,8 +194,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   
>>   	/* VM sequence */
>>   	vm_af->ib_wptr = ring->wptr;
>> -	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
>> -			&emit_gds_needed);
>> +	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_gds_needed);
>>   	vm_af->ib_dw_size =
>>   		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
>>   
>> @@ -211,9 +209,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   	if (need_pipe_sync)
>>   		amdgpu_ring_emit_pipeline_sync(ring);
>>   
>> -	if (emit_spm_needed)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>> -
>>   	if (emit_gds_needed)
>>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>   					    job->gds_size, job->gws_base,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 3617de2368d5a..85ffa2d28c3fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -372,7 +372,6 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>>   		return r;
>>   
>>   	job->vm_needs_flush = needs_flush;
>> -	job->spm_update_needed = true;
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index ae569b4497f6a..f6577f82e6b93 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -75,7 +75,6 @@ struct amdgpu_job {
>>   	uint32_t                preemption_status;
>>   	bool                    vm_needs_flush;
>>   	bool			gds_switch_needed;
>> -	bool			spm_update_needed;
>>   	uint64_t		vm_pd_addr;
>>   	unsigned		vmid;
>>   	unsigned		pasid;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 7d3659ef11e53..de992405ed718 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -766,14 +766,12 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>    * @ring: ring to use for flush
>>    * @job:  related job
>>    * @need_pipe_sync: is pipe sync needed
>> - * @emit_spm_needed: does the caller need to emit spm
>>    * @emit_gds_needed: does the caller need to emit gds
>>    *
>>    * Emit a VM flush when it is necessary.
>>    */
>>   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>> -		     bool *need_pipe_sync, bool *emit_spm_needed,
>> -		     bool *emit_gds_needed)
>> +		     bool *need_pipe_sync, bool *emit_gds_needed)
>>   {
>>   	struct amdgpu_device *adev = ring->adev;
>>   	struct amdgpu_isolation *isolation =
>> @@ -782,8 +780,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   	unsigned vmhub = ring->vm_hub;
>>   	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>> -	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
>> -		job->spm_update_needed;
>>   	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>   		job->gds_switch_needed;
>>   	bool vm_flush_needed = job->vm_needs_flush;
>> @@ -797,7 +793,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   		gds_switch_needed = true;
>>   		vm_flush_needed = true;
>>   		pasid_mapping_needed = true;
>> -		spm_update_needed = true;
>>   	}
>>   
>>   	mutex_lock(&id_mgr->lock);
>> @@ -807,7 +802,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   	mutex_unlock(&id_mgr->lock);
>>   
>>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>> -	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>> @@ -821,10 +815,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   	emit_fence = vm_flush_needed || pasid_mapping_needed ||
>>   		cleaner_shader_needed;
>>   
>> -	*emit_spm_needed = spm_update_needed;
>> -	if (spm_update_needed && emit_fence)
>> -		*emit_spm_needed = false;
>> -
>>   	*emit_gds_needed = gds_switch_needed;
>>   	if (gds_switch_needed && emit_fence)
>>   		*emit_gds_needed = false;
>> @@ -864,9 +854,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>   	if (pasid_mapping_needed)
>>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>   
>> -	if (spm_update_needed)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>> -
>>   	if (gds_switch_needed)
>>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>   						    job->gds_size, job->gws_base,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index ddcdc7256ef07..b8aa45db1d844 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -448,8 +448,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>>   		       void *param);
>>   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>> -		     bool *need_pipe_sync, bool *emit_spm_needed,
>> -		     bool *emit_gds_needed);
>> +		     bool *need_pipe_sync, bool *emit_gds_needed);
>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>   			  struct amdgpu_vm *vm, bool immediate);
>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
