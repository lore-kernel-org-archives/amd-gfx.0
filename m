Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732C1C61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 11:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AECB10E278;
	Wed, 26 Aug 2026 11:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wePFeGf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE19110E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 11:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7xHD+2D5R7mlr9fEDBGz5M36Ij1IX3oXG7l2zcMcPkIATQxGQrCM13SXQ7UduXJK4pEz+wDjmBR6e9X3xi8O9wA04LXc5xxtCCprK8zREnSKPslmZ7E4wTzk26V45oiAg3ZFhGut5S6uxqbA7jxSACuCR4Yd+rO5zfjUwqOvDzkEK7IFI5UknTb6eOd2QbF5+aSq6+NU4oYN/og1B9Jn9fWMnhP+hXbYfbpklua4PzkicWSpRYxAsZHucbzDH/ay7jnCKh6XtIpBSJtoB5bPKnG3A/YfqmIG/DuGbTLSXZhLR+OcqK8p835vMIf+pP7sp/iLcfXzuznbwaLjlbpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd5fZJgoF3fWum54tCeoPPwU6OkiPJGM5NXRdMMyYq8=;
 b=T3PdOraaXbkL1A6MF5innH0dmWWNnc9rlhXwTZKLKh2whXLM7f99B2xSlBe0XzTA2pdd6OCz+Tl66opFTL4N8uNNijsQOYHtEJq7QrR3cnFWOXR4DD15e2gT7e9yb63NVvbn4NAcpkyIEa1rGnzv7oXnfJn9YoFkH44RF5I03NsZpGdvJeHbWSXmir7sqg3Y+xEMcAd1TaS8gogIeGIUAFhzS1TUjSDa3daNEWlDrdzbf+HV82FTlzGKior50dWcBxSFamqH6t5IYtOi6alI/zaOwwew2qK4q0xs0NkhOiQ+Y+9qq0UyFpu6Kb9g+hP8vTWHACLePmRaK74qc9/CCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd5fZJgoF3fWum54tCeoPPwU6OkiPJGM5NXRdMMyYq8=;
 b=0wePFeGfBrr43RSbOi3NwRA6ctGAHpCco2kHoZDLKT07WFPgr0PecqJ0Uahm0t83BHP90mW6JPMkf8f89XEkoNzltcvUZ3ncFK7aa3AKaldOaNMvKUpK+7fH8nb/BD1BCnbShSGMA9LXjcBcksc/9+uB+Elz87Lp8pkRS+b02/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 11:57:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 11:57:02 +0000
Message-ID: <71b1fc3f-3e52-45fa-a69c-7b49a912b842@amd.com>
Date: Wed, 26 Aug 2026 13:56:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is
 attached
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "Ghosh, Prerona" <Prerona.Ghosh@amd.com>
References: <20260825075346.536983-1-yifan1.zhang@amd.com>
 <7fdf5073-24be-4460-8018-eb2090584b15@amd.com>
 <CY5PR12MB6369330C3CCC4735451CEAEFC1AE2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB6369330C3CCC4735451CEAEFC1AE2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd5519f-e1c7-4044-18e7-08df03692418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|5023799004|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +cwl20ubOrcD0xGMys9QrTVoGfR++tCz3d7L629+cZPPENqhUMueoIZTguMG0wK6IIKpBptth9bkY9vPZSLd879edTTXk26m9EiMdHObAw+eS4x5EyeREKh8C2BfZyRkiHuwlMF9LnG0GqB5uTxhhiFPOw0sOIlzZWur630Kq58gcYS3V6vo+BtcNX90xQOnNK+X7LhdYDylJ+crmLTEsTdTG+/pco+iBf+JxbUt88zT7XrLIMV7QZYTThuuX7RcJ9E2/wbDyVNDTyRSs9xerEldiMM1SN5RFBjGFTfKETCos9zVeykK+Yjb0u5bvOCLbvWzB7yHPOpywKwD3+1KljZSyLeXKgVtRjXN6fHzcZwM9SGuH2PIqQcCtepxBowAg0IAqaNPeisYCeAUoax3KYTdfFdNFT9erUTNBRi+nJdteMsyMv2cZNZaJ+sXRsyUVO1vrq5IKkkd6YrMJ/r7kwcj15gwLzO/9paZEZFbWLEfgDnFogAOXwhWtHWXEuLsKsQbmFxbUIPjSWtT9CX5KhDxqkkx2cB5BMd3aPwlpTvl8HP/bQKLS4tKbRlysB+iVmVbtNw0Yna8PgVNHubvnJrMbqg4EIaJN3s7mhGwyf/SmmpFoODFOEc/17n0gHq/4Pqvi/idvDpIYwzLnG60aUkXKcVz/Q1fQEysRaBRbYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzQ0b1huMjVabHpNby9MNWJFSVVrVW45SXVTaEdRMGlDRktUd3dyaFBhdUta?=
 =?utf-8?B?L21hQlBDL3E5MTFnTlE3UDdVc3ViTGJmS29QRlJPMVFzclFyYlFQdWU0Y3Yy?=
 =?utf-8?B?SkZOWVpKT2tsZW1QMytMSGlhTStuMll2T3pEcEt1aUxpUDdETEJ2Snp6aVAw?=
 =?utf-8?B?NzRXQmJkSFNJbjB4NDVwS003TXhZWWRCU2hMM1BZdEpxUnZnMlRBVVdOQVli?=
 =?utf-8?B?d0srRzA1SXFjTWt0dXlZSXcyOXBxVGh1aVdyaWlXaWpYd0tLdmpXVEpBVlJI?=
 =?utf-8?B?NXhBSGhuTkhId3ltTWZCYjl3UXJBakRHa1oyMmFyZFVrVEJyRDZqdmtYQkRp?=
 =?utf-8?B?Y08vT0ZwQjY5SVJnY29zUUhKSmV4d1E2MGRFd05wSUtiUmhFRmNZR1MydGha?=
 =?utf-8?B?RW5HbGlxcnFVRXFxUExqSEJDN3lmVC9Rcjh6azRsUlhvZUJRUG9abEs4Q2Fp?=
 =?utf-8?B?MVI5OWVWbHJ2L1dTTVdwZVZWN0pGNU5Cd3hFS1QxYWp2SnR5ZnQ0bzNJUzc2?=
 =?utf-8?B?Q28rdHc0NzVQN3hCV0NnUTZ2SDJtTE5KUHlpQjBoRk9IZWhzcStYaTZGbm1n?=
 =?utf-8?B?dXFNZEJVeU5RaXV0K1pSTHlhMHZ1RXVLa2c2alB3MFFDMk52cjMreTIvbUFw?=
 =?utf-8?B?bFZqQ0dsVUNjMDZKcm5UZER0USs3LzE0QXU1TGJJQWV4eFc4M2hZenE5dXNZ?=
 =?utf-8?B?eHlpeXBIV0xHSVpVOUU2eXRYVWxTc3NTSjcvR3VKWFBLaDVRQ3U1Y2hRSnU2?=
 =?utf-8?B?OWZnOEpCVXJUcUpLMHJrOHNpMzY1NFRTQ3dFZEVaYmNFVGQrbnE3dWlFampL?=
 =?utf-8?B?bVJuU1JSenJ0U09zb2hwbUNxSUdTK29ZeU5lV2dKR3BHdXZDTTRqMVZxa0Va?=
 =?utf-8?B?Rmh2MHdMcGN2WDRjWWdlMmdEbWUyaWJjZk9Pb1g2UHVJZG9tdXQrRnZvclAx?=
 =?utf-8?B?anJkblI4eHkwczlLTURBdHVWVmZsTWFnSkw2aWI5cnp2TnAyeENFaFR4S0w0?=
 =?utf-8?B?Y0ROejIrRmpKQy9URmVRVmdEZkthcHc0Z3FOWHlselIwZjBrRyt4cnp4ZHhG?=
 =?utf-8?B?d0RwOG1razVacFpDQlMxSm1qZHA0MmVnYTZnSmRKK3lzN2dTTmk0WUFMMDU3?=
 =?utf-8?B?eDRuc01nckVTbjZ2SmxrY2Jmc1RTRDh4dm5nRGdQWk9BOHlCQmNPWENOdFNP?=
 =?utf-8?B?VjNGa1hoRW5kUUFEa0dtRytVblQwUDVnMlRVdXlmMFlrMFdoOGxDZTVxbnN0?=
 =?utf-8?B?VlNtbFpqbkZyQjA3VHhQYmk1aE9hQXNlUEorY1FqdDVic2ZXa1BGczU1eE9Q?=
 =?utf-8?B?TStIdlNPU2E4QWFSVUo1cTNLTkFURVVwZjhlR0gzcHdldTl6N1p0bVJ5Tkxx?=
 =?utf-8?B?Y2pWMGdHUDlyWnV3cGlRVURrSFc2SVlITVJpMWVFWm5VSlVrYjlFOUxEQ0Er?=
 =?utf-8?B?UjVUcG80c3Jidmk1UzZKaVp0aTV2OUJGTzBkY1ViR1F5WFp0NHNEQk9jWHBr?=
 =?utf-8?B?QjZPUTJqTEo2VCtuTHFLSnJnbkxvTmFMa1RjcDYrWVErd21iOHhCVit4MStT?=
 =?utf-8?B?YlpsSUNubk04WXJDc0hua1Rkc21NVWtqTklOQlIzRzJRM1FoRGh3UDhtODBS?=
 =?utf-8?B?SFFEck1SZW02dVFvbDVOM2liSEk2ZGx3ekdnaFdhMkVUVUJkeHdlSkpUaGgz?=
 =?utf-8?B?Y3hCUk4rb01CRkUxVGJEOTI2aHdaWmUrYkRKa2ZrRDJ6eDlBY3loRkFjOFRk?=
 =?utf-8?B?UVVETFB0WldFYmM1QjgrelVCbEkyQVpZZWFSZE9HU09TMGFpbG1vbE5STTlE?=
 =?utf-8?B?aE9XNkdOYkFxSnZXaXVIU0ZmU0hzeENCMnd4a2FtMTBVTFI4Q3E5YkRMNlh5?=
 =?utf-8?B?RllNUWk2ZXNiWjBaN3dYaVIyNmZMRTRtZm9YTTZJczJ0OXQzcE0wMlVwemQw?=
 =?utf-8?B?aEROOVljdmdBKzJiOUtjRW0raVBKdUh4dVhUd0VJQlVTQXFFMW05SlVEV0dH?=
 =?utf-8?B?V1JqUFAveFBaOGswMFZlK2R1R0Rnd3NzcFNuNFV1YXB1bkpIejdDNHlIdGZp?=
 =?utf-8?B?cHYrQ3AvcHlNcWJWZXZlcUhocXNXWkkrLzZ2UWxaK2VUWUwvMXRkQ2d0V3dD?=
 =?utf-8?B?Y2VCUlRpMWdnVzFxSEdaUkN4M0RWTllZazR3ZjhkallCNzZweUtiMjdrSks2?=
 =?utf-8?B?NUFZRS8xb1V5MDhVVFhTcjg4L2s2eGxUdG8zODdWTEtXSkl0VjdwRHN5MStD?=
 =?utf-8?B?ZDZpWlNrSHZna0UrQzdPdjdmK1RGSjcvOTFNM3lJSWM5U3ZLa2REdjRZbHlY?=
 =?utf-8?Q?kt1fIssUXoCuZoq9/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd5519f-e1c7-4044-18e7-08df03692418
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:57:02.4913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avkfHQ62lBBq07odlU4zP/dzFjIo3jh6OozBfuXetKeLLawBZhSTGK9/rFJQF/Ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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

Hi Yifan,

On 8/26/26 11:40, Zhang, Yifan wrote:
> Public
> 
> Hi Christian,
> 
> That’s because ev_fence is initialized to a permanently signaled stub fence in amdgpu_evf_mgr_init():
> evf_mgr->ev_fence = dma_fence_get_stub();
> As a result, dma_fence_is_signaled(ev_fence) returns true in amdgpu_evf_mgr_attach_fence() if no user-queue setup or resume path calls amdgpu_evf_mgr_rearm(), allowing it to bypass the validation.

Yeah but that is totally intentional. The validation should be bypassed as long as the stub fence is installed.

When the first real eviction fence is created it should validate the DMA-buf imports and make sure that page tables etc are correctly setup, but that doesn't seem to happen for some reason.

Please investigate further.

Regards,
Christian.

> 
> Best regards,
> Yifan
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, August 26, 2026 4:58 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Ghosh, Prerona <Prerona.Ghosh@amd.com>
> Subject: Re: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is attached
> 
> On 8/25/26 09:53, Yifan Zhang wrote:
>> From: Prerona Ghosh <Prerona.Ghosh@amd.com>
>>
>> DMA-buf imports are created in TTM_PL_SYSTEM and land on the VM idle
>> list, so nothing binds them for a VM using user queues:
>> amdgpu_vm_validate() and amdgpu_userq_bo_validate() skip idle BOs, and amdgpu_cs never runs.
>> AMDGPU_GEM_VA then programs PTEs without AMDGPU_PTE_VALID and the
>> first GPU access faults.
>>
>> amdgpu_evf_mgr_attach_fence() is the right place to fix this, but it
>> only validated while the eviction fence was unsignaled. At
>> amdgpu_gem_object_open() time the fence is still the permanently
>> signaled stub installed by amdgpu_evf_mgr_init(); a real fence only appears after amdgpu_evf_mgr_rearm().
>> Natively created BOs hide the bug because amdgpu_bo_create() already
>> validated them.
>>
>> Validate imported BOs even when the fence is signaled, and unwind the
>> bo_va if that fails.
>>
>> v3: validate inside amdgpu_gem_object_open (Christian)
>> v4: fix amdgpu_evf_mgr_attach_fence itself instead (Christian)
>> v5: restrict the extra validation to imports so that resident and pinned
>>     BOs are not migrated or failed on every GEM open
>>
>> Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> Assisted-by: Claude:claude-opus-5.0
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 ++++++++---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  9 ++++++++-
>>  2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index 4c5e38dea4c2..c2f9380511a3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -101,11 +101,16 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>>       struct dma_resv *resv = bo->tbo.base.resv;
>>       int ret;
>>
>> -     if (!dma_fence_is_signaled(ev_fence)) {
>> -
>> +     /*
>> +      * Imports are created in TTM_PL_SYSTEM and this is the only place a VM
>> +      * using user queues binds them, so validate those even when the fence
>> +      * is already signaled.
>> +      */
>> +     if (!dma_fence_is_signaled(ev_fence) ||
>> +         drm_gem_is_imported(&bo->tbo.base)) {
> 
> That still doesn't make much sense. When the fence is signaled there is no reason whatsoever to validate imported BOs.
> 
> We are still missing something here which explains why that doesn't work as expected.
> 
>>               amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>>               ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> -             if (!ret)
>> +             if (!ret && !dma_fence_is_signaled(ev_fence))
> 
> That check is superfluous.
> 
>>                       dma_resv_add_fence(resv, ev_fence,
>>                                          DMA_RESV_USAGE_BOOKKEEP);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index f754a4a3a1c2..3118b3036564 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -264,9 +264,16 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>>       bo_va = amdgpu_vm_bo_find(vm, abo);
>>       if (!bo_va) {
>>               bo_va = amdgpu_vm_bo_add(adev, vm, abo);
>> +             if (!bo_va) {
>> +                     r = -ENOMEM;
>> +                     goto out_unlock;
>> +             }
>> +
> 
> That should probably be a separate patch.
> 
> Regards,
> Christian.
> 
>>               r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>> -             if (r)
>> +             if (r) {
>> +                     amdgpu_vm_bo_del(adev, bo_va);
>>                       goto out_unlock;
>> +             }
>>       } else {
>>               ++bo_va->ref_count;
>>       }
> 

