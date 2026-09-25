Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55886C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 10:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5D310E168;
	Fri, 25 Sep 2026 10:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4JjZnj5J";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A0210E168
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 10:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB8EiMckMl4Z17pu+jzbPj4j68Sn1aaBbeZA9pnpwuHMQHHLclpiin8ZtW57cEPIaNLbgQRQCR4X5fRUPupQIRfRflhHbroFKXIZsim6q3/mbcw5OrB1dPVnCXN36dVCsJoLWGVMmqBAQ1nqtmYA2LmtlJwoRztQDi/TogPdvpqKfAZvfJ2KXmo4hF0bxygLpXLxQ8x2IPnNW2jay8Hj7QLUh3c2NqBD/kqpiFvV1/wuiIylgtFneWXdnxdmUTEm9ghWJax8so6KXFsY0/KMIW2RrqZfB3ULn6H8NeRuRBn89jUMzVeWsrX7CHTTier/B4+jCfrT2wRC/Z/IXiVcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkaLMKVSSMJcgZWikDcGv+KRGGds9clHyBlxPn4eORQ=;
 b=ku/rlCc/DGxNtU0DQqW6hTn6Mpli/U0rZqDXnoj1zXBZAYshBwLCD5krteg2Q4g9I35zmKDaFoXLDoQnuR+w7pyQrKPKuUVsTUO7ZSZs7OoadNjoBVI54BOgUzeGc4ndkxz8uVSt39qhUk5O6EivFGttPD3LSWi16CQmD6V3NO5BkPl6PzHyqUwYx5ZhXMaSy33kZ/VK5m1PJEYhrPJDgLucaKC+GmSdbagj2nIxDSLjjMINGyukHZsvfVDPnjk3MjaFZa8TeKTEErrBkZWN5MyvG+OcpOkWGi7xY3lnIOqm1uuunEkab6KYjMdKWGr2Hv7F39isAj3sShpK6G4VBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkaLMKVSSMJcgZWikDcGv+KRGGds9clHyBlxPn4eORQ=;
 b=4JjZnj5JBblellz7ljSZMCNdaHdGQ5T1OchTMtdWaKnVyIpHf4q6JifrcCK+dcLWdCPQf60VyaEXEgPriNqYB6DM7aburAL92vc6BjPSWo6CKfXrlEnPAXWCZbWqZRRVVXx06MnwJjMGgYoPQGwiRx+m1abRRdkjDuTft/xMpLk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:50:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:50:04 +0000
Message-ID: <c63fa672-d127-44ab-97fa-bc3e5f725e87@amd.com>
Date: Fri, 25 Sep 2026 16:19:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
To: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, James.Zhu@amd.com, Bing.Ma@amd.com
References: <20260925093718.2737342-1-lijo.lazar@amd.com>
 <5fdab172-c7b8-472e-8c6c-c6d5fd7afc70@ursulin.net>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5fdab172-c7b8-472e-8c6c-c6d5fd7afc70@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0276.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c4548e-5b05-442a-a573-08df1af2c181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: M67g/g2Uy3mQbY5K4QHHGl881e7zYE4to7Fv9mMrIk5mm/ULcs/nHJ9gVDLva+DWUbaTV8t2+l1EW2nF4GJ5+KlRSwADxzQouWkLsKm2BGBr9PtlC/0n5JzkWAMFPF4uzE8I3138E7qdwGBI3cN6EW4R3agqyde7bMHC5N+ttwdcPx9XsAQlWQkcZh8zn39fq4RRd8djuqoqnZc2wPrJY9ztsAyn2KgnAXhnuGGhAQQnk41cPi79FKzBjfpKFCZVsr0hY41eoejoylaoEYB6zCnoCfB3tA4LpDYOTJPDBPKv9IG17Ln/e6kXUvrBYG3jXCcaz1qWiUVPBo4RaxE+Sf5rvulcBH362IqZHYKyJYzIQsPGaw8EfEv5H4yDZzN7tLCQETo3qIYlI6nHhTLqTfpEgw3XKoEkjTLTZg5fdSIOYzQeIInILRZ13FARaskBRrXgtAsSqmSI0pVkvxIatJ6EGuyD/hghnB7DMb0Sy/5Y/owzqB4sT59b5JjXBc487mCc6/togWdveU3oxGOfaAmneK7uqsJVQuJEnQ9eRl7BJ20e2Du2/7Q0tK4W5CVCRo/i0d9PRtdH+0H4AnBfuzcID9TUk6llElDbHSxZ1oTq1cv0CP8/x1I7qfdl3BLLRfd52NzRQ8Cn2qscIHSjZfkBK4u0D5SYyPvMZrtq/Sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3pESW14WUZ6My9FUGNTZVNmN29aN2E4K0UvYXNIb2tNTi9BWi9ENExvYjFl?=
 =?utf-8?B?M21ya2pJc3M3VjBxL3FUeHZiOVpMUVh4Rjc5c3hnRjdYL1QwZnhHS2s2cW9n?=
 =?utf-8?B?Y1Z6R01GbHNWUkpvSzBUZDd3VE5hQ29MTWxlbHhpRHJRL2NJT1E4aW5wMGFC?=
 =?utf-8?B?UG5BTDNJNEFqbjZncEEveElVdU5kY0VIeFQyRzZMNDVSdHFuWkhvVkE5cXZJ?=
 =?utf-8?B?RnVqY2FDVVNiend3SG41TzFxS3Z6ZmFTSjV3WkNGNzZ3Q0xNTVNJbXNOdGdU?=
 =?utf-8?B?MUNXMTc5M2JoNnVqNTlGdkIwNkpXZUpSTzY4THBic0RXaDV4RFVUTndZVFhH?=
 =?utf-8?B?SFlSM3FicVFlWnlCMUFPcGNtV3RsR0tpZnl2TVh4RHpiS01LUlpHWVhUVjUv?=
 =?utf-8?B?Ri9vdE91WmMvRjBERWFTYjZUYk1NYVNVbHYybzUzMDRETTJaU1JXcmxXSW9Y?=
 =?utf-8?B?RVI3U1NkSXhzTGxxbG80RWxtN09BYlZqazJXbDFVV1ZSUHhYaGdBMGdJeWda?=
 =?utf-8?B?d1JUKzVNUE5aN3pWRFMyaUliSWEzclVUakd5ZGYyRUkrWlVlU2taeWhzbEp5?=
 =?utf-8?B?a3RXaWxGMkh4eWQ0eWltVFVVbGd0SzZpNDZ0clJrTmNnNERWRUx2emNTbGRQ?=
 =?utf-8?B?OHEvdFJDSWliL3Q2NGg5azU0alJHTy9WYm1NZytLSXRhMUpKMTlNTmNxTjJD?=
 =?utf-8?B?eDhuZHY1bytlMFFldGhVeW5pK3VkUkk1MDZRYk9pRWNWQkNYak05SVF5OWxs?=
 =?utf-8?B?Z2FEWnhZL0E1VTZ2K2RzWEhuTFh6TWRRaFUvckFzSHk5bFFlcnczZkg3di9G?=
 =?utf-8?B?ZnRUZ3loa3RQVWI4Vjk0L05kbjNTWTl2b0hNWStDZTNvSTEwN00yQUN6SERF?=
 =?utf-8?B?NjVSRnJrVm5mTTg0VDBJRFJGbGFidVhrcjR4dE1kUE9kNW96SVQzcXk5QmRM?=
 =?utf-8?B?aFFrRlowWWRsWnJUN3I2b1NNVk9scGxwU20wTEtBejgwNUVXL1pGaFdTaHhC?=
 =?utf-8?B?OUg2am9sdDJObGpTSHNlTGJ6UXRzSlBmdU4xQkNWeWlaUTBIS2JZMksza1Jw?=
 =?utf-8?B?RXhKd1AyVU1wNk9hUEJlTkhIWEs1bUgwVEJicHJXaTNGRjlYVGRUSGFEeTFW?=
 =?utf-8?B?TThVNW9oSk41YVRCU1lLUUV2SlFIT0FZRk9wc2FRRTMxWTM0aDA5WEV5KzRl?=
 =?utf-8?B?RFJwak1ONEJZNVVFUlBXV3BjSnJZb2xvSmllZ2dYKzNoYkh1M1V1WU1GSnJr?=
 =?utf-8?B?ZWRjSUJWNVQxeUdYc0xHWHpjM0Q0RE0rbGsva01qa0tpdUxtVm1xMFlkck9Z?=
 =?utf-8?B?aUYwaVMzaFdyeVpETTJ3dDJYS1dWN3lqRmpyN2ZNNWNIUllIZGtwditOb3lZ?=
 =?utf-8?B?L1lZTjhNNGRybEQwWEtSOXB4TU1SWkdDSWFRcW5DdHJMdThZV2Z2eUwxdFc1?=
 =?utf-8?B?bTZlU1VoL1dXa0Z6dlJLYi9BU2pOdmMxeDYrVWJ5bFAycEhoMktPN1BZMjh5?=
 =?utf-8?B?dGJCU3VRaXB6d3pucWlVUUFCUk54QmQ4cWVpdE13dnNiN1ZpOUVIcGh6UGNC?=
 =?utf-8?B?YUxGeTlrSjZ4WnVSVzlidDU1NHhtN0ZzbEJ2SE9iTmtWcVpPZ1dnZm10d1FV?=
 =?utf-8?B?b3NuY3JDaVZsMTZuZlZkUE5mNjlkNnQ4YytvUThCdnNKNDdrTXlrVmdDTlpN?=
 =?utf-8?B?cVdLb28vdjlmc2o3Njd3d0YxUnZqNWp6U2pnSnpkV2dTaDlJZ09wRjcyMzAx?=
 =?utf-8?B?bjh5YmFpbFF2dmVkS1pZQWVMK1VvQUt2VkFidG84VlVaUFE1ZVJqRFBmRVZB?=
 =?utf-8?B?Q1g3R2xaTHZvK2J1Ymtnc1dIeFc2eVZ1NGxDczcwb0NyTVVMUStnNk5jK0Ry?=
 =?utf-8?B?RlQwcE0ybFFZYnVGb2FpNjN2SFRRV2dmVzdGYzN6aFUzdzZZOWNtNXhqb0Y3?=
 =?utf-8?B?TXRiVE96dnVDaWtxaW1vdkNjSFgzU0h5ajRwallTL1pFS1NkSjhrRUtWcmRP?=
 =?utf-8?B?TDZKdy9BaE9xdnVHaDJ3SUNUMGdwc29mN3FaOVhuV1RJZFl2bDdSbVRlQ2Y3?=
 =?utf-8?B?ajdUZHphZ0dLWmpaK0lENzllNFIyL2htak9jcUZGTndMMi93L0JVdmpITFZa?=
 =?utf-8?B?WWM4RzZhRUs5UzZRR25JNGY0VWFERVV5QXVBL1dUenRjazRqQk9YQ0szQlA5?=
 =?utf-8?B?MVlnbE9aRVAydERxTjEyNk5EYm9jcmgwNVpHVjlMamxxN0w1aVU3eGYxOHhG?=
 =?utf-8?B?RGdndG9LT1A2L01XcjZHWlhWdTMwejBKeExpY2Yxd3hCcVFXV3hrMVpaTFd6?=
 =?utf-8?B?a0dTVHlXdHcvWHBVdWVzSEphdFowZWdaa3FIZDJvQzFlUFpCelc2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c4548e-5b05-442a-a573-08df1af2c181
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:50:04.2626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5BuPKW5GlV55wihS1w01M9+qSqHN1aOrYJQJwUuqgVgXjTKanZfNIP6t9jW7yPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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



On 25-Sep-26 4:04 PM, Tvrtko Ursulin wrote:
> 
> On 25/09/2026 10:37, Lijo Lazar wrote:
>> RLC SPM is updated for GFX subsystem related performance counters. Only
>> jobs on rings that use GFX subsystem need to be updated. Some rings like
>> SDMA could be inside/outside of GFX subsytem based on SOC. Identify the
>> rings using GFXHUB assignment and use hub id assigned to find the right
>> GC rather than relying on xcc id. xcc id may not be necessarily assigned
>> properly for all rings.
> 
> I don't know the hardware well enough to review or be certain of what I 
> will ask, but if you remember the "kitten dies" meme it often comes to 
> my mind that "every time amdgpu repeatedly walks a list of everything to 
> find something at runtime a kitten dies". :)
> 
> On a serious note, question I have following the statement from the 
> commit message that xcc id is not always correct for all rings is, would 
> it be feasible to make it correct? At ring init time I mean. And so 
> avoid having to repeatedly look for it.
> 

Having to associate xcc_id with every ring (for ex: vcn/jpeg) is 
overloading it with too many things.

This is one of the changes in another set to remove xcc_id and keep a 
dedicated ip_inst. Then realized that a sdma job also could trigger a 
spm vmid update, then using ring->ip_inst doesn't work (even now, xcc id 
for sdma ring is not assigned properly).

That said, so far for gfxhub, xcc_id = ring->vmhub holds. The loop is 
only to appear it technically good. Also, max xcc = 8 (so far).

Thanks,
Lijo


> Regards,
> 
> Tvrtko
> 
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 31 +++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
>>   4 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu_ib.c
>> index 0f8b097001e3..6ea73ef6e672 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -212,7 +212,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, 
>> struct amdgpu_job *job,
>>           amdgpu_ring_emit_pipeline_sync(ring);
>>       if (emit_spm_needed)
>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, 
>> ring, job->vmid);
>> +        amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>>       if (emit_gds_needed)
>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_rlc.c
>> index 002fae3c380e..f791e1bcbf17 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>> @@ -27,6 +27,37 @@
>>   #include "amdgpu_gfx.h"
>>   #include "amdgpu_rlc.h"
>> +/**
>> + * amdgpu_gfx_rlc_update_spm - update RLC SPM VMID
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @ring: ring the VMID got assigned to
>> + * @vmid: VMID to program
>> + *
>> + * RLC SPM counters are used only for GFX and GFX Cache subsystem. 
>> Only jobs submitted to
>> + * rings in GFX subsystem need to update RLC SPM counters. Derive 
>> xcc_id from ring->vm_hub.
>> + */
>> +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
>> +                   struct amdgpu_ring *ring, unsigned int vmid)
>> +{
>> +    int xcc_id, num_xcc;
>> +
>> +    if (!adev->gfx.rlc.funcs->update_spm_vmid || !ring)
>> +        return;
>> +
>> +    if (!AMDGPU_IS_GFXHUB(ring->vm_hub))
>> +        return;
>> +
>> +    num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>> +    for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>> +        if (AMDGPU_GFXHUB(xcc_id) == ring->vm_hub) {
>> +            adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, ring,
>> +                                 vmid);
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>>   /**
>>    * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_rlc.h
>> index 959d60c90dcd..1410954da5a6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> @@ -370,6 +370,8 @@ struct amdgpu_rlc {
>>       struct amdgpu_rlcg_reg_access_ctrl 
>> reg_access_ctrl[AMDGPU_MAX_RLC_INSTANCES];
>>   };
>> +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
>> +                   struct amdgpu_ring *ring, unsigned int vmid);
>>   void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int 
>> xcc_id);
>>   void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int 
>> xcc_id);
>>   int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu_vm.c
>> index 29a66e39f3d6..dc8f85176b8b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -865,7 +865,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, 
>> struct amdgpu_job *job,
>>           amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>       if (spm_update_needed)
>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, 
>> ring, job->vmid);
>> +        amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>>       if (gds_switch_needed)
>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
> 

