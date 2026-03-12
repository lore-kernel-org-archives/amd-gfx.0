Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD0C106ACD3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 17:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90FA10E17F;
	Thu, 12 Mar 2026 17:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L12aAuKl";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259ED10E17F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 17:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llvZonXC676nsNjXQDL5SJL6UkSy6wJOEjg5eE20hQXIJ5Pm9MmEZ+GVLcDf6eDNyyTpd9/oPrU7KiB1VCBLomFsBITunjZsuHbAKCNHQPpfj86b2U4WplTwN5uHT629rBqFrzxU3xEJXXzqEXihJs0IGbwIL3BZP98F+EqtV9IsMbb9ENW+J3ap03lWQ8EwnOag1OXeR0OZUTFXwJOkGl0yvriLYZLxE84oDPorjIVilPlvR3irDB1bdruc8kMvKppMC2bKkF5vvT2HPbh474HTtIhshUCMqpPc1ipBsvoWZ9W+PCSpGGuIUTIaxUVNvzmgN3qLluK4mo6EQxX0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D428A+EtPQQo9I+Iv8qg58IxOHA169FurUKCAljL/6M=;
 b=g+r1PHas4X613DEfBbO68DqucNfy6PEuTBoaU1fobyb9uX4OQwAG6VJpnInMy6RwKvqdpl2Q2HKXICAZU3wCXb5xTyYr/IcYH2CW9vzhAp8sdccAeijgE0tWeZG42AiWokqxrSRlpzf9bW0jrK76myrX4IzKpHMtgtr0w0MpbdTdnsaEM6qwPT8Q2hEUfp/Z1Zggw119kH1MOy/yNyIm6EwwpEsxRBU+QJJALZpBFB5iZbaZkT/9Wiq3/SMm5VIW4YPHu3jmvZshM+LZ1/XdHVJKGlhoDKczVUjs2cTP+S8RaqwqGMUoqOT9AT/wr89kCRFRNN8hVwdCXPuptUix/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D428A+EtPQQo9I+Iv8qg58IxOHA169FurUKCAljL/6M=;
 b=L12aAuKlV5aOJW5KhhiRcF0OkmGZQOPhr40iarSwNcUX03mE+tK7fncf1MHXrzh3SwkHTbvxE4qknLW2D7q3FxlxpDCvZAERJAvQTuNUXraD3W4bOSCGP/yfQkE+gDg16gRhYeqvX4MZTPLq4MqkIpjgUtteUua2OIeotB0a2ZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 17:21:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 17:21:55 +0000
Message-ID: <765c97fa-b910-45d1-862e-44fb69235c17@amd.com>
Date: Thu, 12 Mar 2026 18:21:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add explicit NULL check for bo in
 amdgpu_vm_bo_update()
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20260312141315.1851106-1-srinivasan.shanmugam@amd.com>
 <2bdb769a-7814-480c-932c-c0e44c58c2bd@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2bdb769a-7814-480c-932c-c0e44c58c2bd@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0575.namprd03.prod.outlook.com
 (2603:10b6:408:10d::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd26553-393e-422a-01c3-08de805bdbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: fhSAqYAd+Z1z8i9Y2tmUl6rhz8hlNDsHMN29nDlWpTfSp4oZdxFPnlDhpoPdZCJEIN7A9/5ihB7JM2g2v1Z5o36m04vFOEJUQOZcfxn+1JWxVvrZA2WRNAiWZ2upw2VKvfdk/ovhVN+lWNS+cS9TyaXzSpR40/SbBU/2UkEihf+iH2rbYUDCUenvItbCBnwtLUmiM34AceE716BNnykeoU6+pRp39xjIR3woH7yQUrRRek6kyC4hTBvmciedatXn1ooEKf4Z3SZYDHsPotubIWWtP1Qp8iSFRNnNk2nQ7P7cKhXvMgoX/cMcUxieKiAQXrY3fEokCN78goTTbucw1tlNjwbX898oaYSPmgsixT5i9t5xk8FwHA8V+vEOPjsNSJQBRZwkxMO4jpK8hkLR/ajA3so4QTkowKT66VjavDpu5Ehnmkx8ToUasIUg5tzDy1XP4FYE1YCky5WIX4Hfec2qofMkPgbyq5t66ydP3Otqw5HcU+ScFuZPYpq84aejpL/jAYhur106LHOa2TU5qidCVJO4vJhZ24BjrGf2VjMDFAXM22I3MBsV+i9urVEMoeSFlerJJrwBHyi4fpIYbIup/HyJDLnmnIjybb2udlK0Q9N98L1W3bQ0uAVZGo6sLFziV5yoCk3ZxjMfVUzQeKXIaMBlZYbJ2+j7oUtbTSKE4FDiiAQWXRnqcKOYHkaZw25nuyYGvnyioQrK6bFHpSRmcK+IjicPP+afTe9IRJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVZHSUdPSWRJZ0VYN29ZRVJmRWthbElMVFdVSlA4bDQrb3BRSEJDM1oya1dQ?=
 =?utf-8?B?OEVqQm5tak9pR2VZZTJUVTlWUFRzVzk5NFZzSlM0a3ErSTVRbENZcmZmNEFR?=
 =?utf-8?B?U0k1THg1eUpwYzNOc3lhT0RrVmV0QlV5NllzSjZMMithSUlEK2s4c3FmWGtl?=
 =?utf-8?B?S0ZjVzQ2WGs1cnJRNmRvSjFsQWdKbGNVNUNqcHBMKzNwQXFMSFExcEovTnAv?=
 =?utf-8?B?NWxrckljZ2pIeTVDdm1vcmR1aGprK3d0aGlWK2Z5NnlnNndYMDZXQ0lhSk9j?=
 =?utf-8?B?SGdjMkVaY0gwQk5FUlFIQkpNalRFSC9IYTFURktwTHYrSnZMNFFPOEFEOHhD?=
 =?utf-8?B?T0lUeDJWS0FlNjhlcFQ5R0Nadjk0UjgvVjhvV3JGcm9yY216bWZiUDNJRW84?=
 =?utf-8?B?OTVSVFNwVnFKVUxUL3p5Rm92UVg2WENnbEwxMnEyaW1adVRaV0xlNElKWkEy?=
 =?utf-8?B?d2VTMHZaTTRRZHhUeDE4UmErSnpUNXdNSXRRWHUzWkVVbXVQcUU4UUxlRE53?=
 =?utf-8?B?TDlGdXRuOVRya3NYRkpZZWQzS25Nbndzd1o0ZDloN2dLQWhQVnB0eXhrUHVv?=
 =?utf-8?B?VXI1Wk10QXQ0WE9YQlBaNlZWS1QwREplZ3BlSTllT1kyZjNlT0pLUlB1Zzha?=
 =?utf-8?B?M2gzYTllcWdEYmwwNHVteFhQdC8yRXhiWU9GOUtma2prVGNyUlMwaEZRZHlJ?=
 =?utf-8?B?MHEwS1l6K0JhQTBVN01WT1grN01nQmJDalZGRnR1WVBhM2lSVzY2WXRMMWNr?=
 =?utf-8?B?UTN0QXc1WFF3aUZhYy9KZW9YRXlZTkl1QkgrS0xnUzVLb2NtWlhCZE1ya1NV?=
 =?utf-8?B?VElWTGJnOXpOQkZGNy9uOFNHaTFDcVFsODI2MlhxTHAxa2lYTzFtZWZVelFu?=
 =?utf-8?B?TFJXUnZkN08xV2Y1Qm44RVZ3V1RNbjNiNVR5MW9zRzRnS2xrY3R0Rm9NaTNa?=
 =?utf-8?B?K3RqSlp4RlhkYy85UnduVDYzUFRWL2NtOVBsMDVBQVBvaG1idG9oQld0MTFD?=
 =?utf-8?B?aGFNeFk5blJyZ08zeXRFdGc4ZEZ1c3VtYk14NnhLV3FBSWxwUVNrWjMzZ1A3?=
 =?utf-8?B?Qm9STTV3K2NTaitDRGFONzQxS01YYkc2OVBzYk5WMld0alhoYzhIQkZhMUN0?=
 =?utf-8?B?THFNTmhENlBwTnBQUllWYmM1VjZFck1ZalRiaktIc2c5bi85ZG9oUWd1cVkz?=
 =?utf-8?B?UW9odjRMb2dxaUVvN0EvS2ZjclFoZ1p5SFhqZTNBZlJqRDloUEpFQ0I5b1Ny?=
 =?utf-8?B?M1RKem9ZNElkMTRGczlvcEdWTk55Z21WOGI0T212eVp2dnJ6MzlZWDU0YTkz?=
 =?utf-8?B?cmhFTU1ZbW81Z3lVZ1BGMTBtU1pxZEhlQjFyblZsRUF6NEk3VEUzS0ZobzQy?=
 =?utf-8?B?U1RwZldoV0hOR0VsSmFaVjhjNGx3QW1YSmNBYWYyY25FdU5LbERTdlJEbEEx?=
 =?utf-8?B?cjRtVG93ZmJDVVJxNGFwSlNVaTdKamZBMGhNeSthY0FaTHdWUlZtK2NyYnlF?=
 =?utf-8?B?RHJIRmJoU2EyQWZMSk56d1prd1RvbnQ0dHU2dTcxanFiZFNibG45cktwNkRZ?=
 =?utf-8?B?Z012dUxZcGhmQWw3OFpLRlNtRXR3RWxSNVlYelVNMGtUTXhjSGM4RlZtc2Fn?=
 =?utf-8?B?c2o5M096UjZFQ0lVMTFuMVNsVERtcmNPTlRUYUNFSEJFN3lad2R3TmowN3BY?=
 =?utf-8?B?V1RQSG1IanZ1MmRZNVB6RndMM0hmL083T01OT1JVT3h1VGhUWms3WmNkMXNZ?=
 =?utf-8?B?Wkg0dlNieVVyUkhIVnpvcnQ1bzd1SDA0QUtKNndCbkM2Z0NjT0ljbzhMUEVH?=
 =?utf-8?B?TUN6RlExSHJOeU5rS1NJMkt0VUlvWGxGQnpKb0U5cmNhZmxEM0FSWERER2VU?=
 =?utf-8?B?eUluNStzdFdONUtMQ2lORk9hb1VidmsyZ3pvczk0ZDhRM3YwMHVaU1FhNDJl?=
 =?utf-8?B?M1RaOGVDTTB0UnBpdGx5WUpKc0NTWmVram05dVlkVU92ckIwclZjUjFuRmZD?=
 =?utf-8?B?Sjdnc2puNFdDR1QrZmd2cUpvTGlMSUc0UjBIL01IWWx0eVdvT1ZTSng4azc1?=
 =?utf-8?B?OWl6V3BFcnJ6bHVxVW9pbVRzSFpCYXNBQkJrMlpsbTRJUmErSjltaml5cWla?=
 =?utf-8?B?eER1R29qbDVtMjJpL1ptK1UxTkpPWVJSeFpSRGJXdng5aUpyVVkvbFFGOXRN?=
 =?utf-8?B?QkkrTHRjTWxGQUdpUGRnL3BBZjk0VlpaOC8vQmdhR2FINFZ4b21QTU05UVMx?=
 =?utf-8?B?ejR0Y1c5Zkx3VTlUNmRUMTFaelBKc09kbDFpNll5ZzdJVVpHZ0ttVXNQQk5o?=
 =?utf-8?Q?+QjiNOoiw0ed7tOFD0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd26553-393e-422a-01c3-08de805bdbab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 17:21:55.1198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyeynb7ezRD9hsoEo4QSvhyjiUHu+WxByeB1CV4iB0cVh7bCj7nLyuv94VWgbQZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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

On 3/12/26 15:39, Tvrtko Ursulin wrote:
> 
> On 12/03/2026 14:13, Srinivasan Shanmugam wrote:
>> amdgpu_vm_bo_update() allows bo_va->base.bo to be NULL in some paths,
>> such as PRT-only updates.
>>
>> Although amdgpu_vm_is_bo_always_valid() already returns false for a NULL
>> BO, Smatch still warns that bo may be NULL before it is dereferenced
>> later in the block.
>>
>> Add an explicit `bo &&` check before calling
>> amdgpu_vm_is_bo_always_valid() to make the non-NULL condition clear and
>> fixes the below smatch error
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353 amdgpu_vm_bo_update() error: we previously assumed 'bo' could be null (see line 1292)
>>
>> Fixes: 26e20235ce00 ("drm/amdgpu: Add amdgpu_bo_is_vm_bo helper")
>> Cc: Dan Carpenter <dan.carpenter@linaro.org>
>> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b89013a6aa0b..0d26346178d4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1349,7 +1349,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>        * the evicted list so that it gets validated again on the
>>        * next command submission.
>>        */
>> -    if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
>> +    if (bo && amdgpu_vm_is_bo_always_valid(vm, bo)) {
> 
> That would be unfortunate:
> 
> bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo)
> {
>     return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
> }
> 
> Maybe Dan can make smatch smarter? :) Because I don't think papering randomly at a single call site is great. It is even in the same compilation unit. Hmm does the order matter to smatch? Should we maybe move amdgpu_vm_is_bo_always_valid() to be earlier in the file?

Yeah that patch doesn't make much sense.

We explicitly added the amdgpu_vm_is_bo_always_valid() function to avoid such NULL checks.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>           if (bo->tbo.resource &&
>>               !(bo->preferred_domains &
>>                 amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type)))
> 

