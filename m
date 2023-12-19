Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5869C41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 08:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D40010E3FE;
	Tue, 19 Dec 2023 08:10:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C48E10E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 08:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRR2gtUvzl1rjvmViOgrWog6fXW9onCVhIy2BqU4sKqIMd1Qm5R3C1zj/dFPcMcOVuK7SxkOoWBKzA+d1xAaF+eKJAQ3JZ9F1hn0tsQCBxKwG6m7JHWw3IRaLqYdOQj8ixLXxruAe9HR+QkaJBAAFXzVhvLA+3QFinUfDx4l4KEIiU16PPlNpCV3jS88Syf+mcLbtrqYxcRs+nG/LnwUkIJRnAye+YTnfl0ZQSRyMOqQbE4gXxHgAbEBudTFLW9Q6fACcvMLKHGcjhrq1A8Tf1N0IVfoTRb9HU+/ND8fy/p0PYt8jcxcHCdvox5G3X3h6u7jHnkHK7GIvJpiHF8hHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbzLdVfzY8+F6REiXTiy3d561OoNUf70tANY11b3PI8=;
 b=O7JosXZgKFK89wby491dJnB05Oj5I8Q7J4XO/48mrpqyfDexQ6etFhKge3NBSuSalSRTTo4GjLf8MtINo5Jo6877obRk1220VZbDxC9hm8p7vidGzf9tmySLjaT1nQAXOV28j8LhuInzSv5lLByMHzCeC5pLKINKIYnIZY0TgWhaF43JzUaMneLhJj+R3Y8JuHw7fnj0imo7w0lsdCwKmA0LaAhyr3fp1GD+ogs/wCBjdGXF/Ra/ZjSkpKYAn7WLg2f01CBKjvNu9jqDMkJSzMT9ZFZ1RdmDxyNO/P6kMhxUVoG6oG261HRAjPdGEFYJ3z66g/hqYEy0+hVsi/9Gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbzLdVfzY8+F6REiXTiy3d561OoNUf70tANY11b3PI8=;
 b=jZ4xENLtLxR+DdABr59ui1mF0+AAReokbJKIZ/u6NgKo+Y3poaGrVQi7NgUv5f+St5Ix1z9fYL7egpuGlQhvDYTHToRqRQp1HDdjHDICbhfuVzm9pOXrn55P0ts0HNFDcY4WlGR2TOma0hMN8gypFcfEeafCyYoNZp/tlD4LAZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Tue, 19 Dec
 2023 08:10:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 08:10:29 +0000
Message-ID: <346c1009-2930-4424-9cd4-589e5872877e@amd.com>
Date: Tue, 19 Dec 2023 09:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231214223001.218746-1-Felix.Kuehling@amd.com>
 <fe14d738-ab23-460f-ac44-2090ef9ab4c5@gmail.com>
 <3bce0db8-9da0-4f6e-a941-e5531518c908@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3bce0db8-9da0-4f6e-a941-e5531518c908@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e872f3-15f0-43b5-0104-08dc0069f6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuDMK8+OfQFoPDhTMKAwO3UUfYu6/CJT5Tzjlm5/FXJsHAyEa/F8IBAFqx2UAu9FqJxXI7eZhwGu7VZNlLBTL/Ml10MxCPWnkW+u9RqY0TU6XJE+/xgfhfcV1GHOXwCI2s2sn7pl7LY8+mXEFcj1ZkeKh2d3NtKQB9L0bwNrnhGB590cvCOJqMy1dEsoixiemQlggeTvlQ3G6UEAgURctf7EjKV7iyD0rytcyNL+Ag2r8rIhEjqGH2Hfc6La5ae9RncWUs+pjLjGnG4cu49GIQTe3wYsZtLTCtMbcxJZlglXuve1hxejkHQUHGcKPG3V3dIwrQae+MjVF2eCj5zh5wEPyH+LlAZzH3NKYN3Sl0HyEy89reRhcDxCqt3mqrsbbErga4kj/G5s/RD/j/UBcuvT5ExHsr8okWy0fx6/yM/A7i0nFs18fqTfXVF3uUxKr2qDVB6WGdr47ZHXYlTO8R5aAIHXLPxgImyVFaZoUsZK8vJd6HVPH4NC2zusbyRNJT4V2IG2V8YvT4Au8qTd/wT5ONog8PLOfnn72sIpLCrzq1CQ0q9z5CLzFMs6iAOITBVCdmLYrb+l9HeVZ1kn58dueE8dIupaAmO77p81IBttSCg3LFCv137xjdBvUhxvCw6MLg/TS3deP4fUvVusFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(2616005)(26005)(66574015)(86362001)(6506007)(36756003)(31696002)(38100700002)(15650500001)(5660300002)(6666004)(6512007)(2906002)(53546011)(6486002)(83380400001)(110136005)(41300700001)(66476007)(66556008)(66946007)(316002)(4326008)(4001150100001)(8676002)(478600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0Y5QzEyLytwUk5WR0hJczd6UU1FN2RsVUxaaU5NUUdwdjVPNjEza0I1UUJM?=
 =?utf-8?B?VVA3bVZ4SEFKbVNPZEZOQTc3RkJKblRpclFWREwyMEwyaFFZVk82ZTBuSWVB?=
 =?utf-8?B?YVpDL3REcG9pVCtIOE1mejBrT1ZvUmZwV2xZQ2RkcnhadjBVT1J3Mk42Rmxv?=
 =?utf-8?B?MjUrcC9lQlJ5MDhpZEpSVzM5dzBYT01SWkZsc3cwYzI3SStuQWh4eEFLcTlw?=
 =?utf-8?B?NVRVM01sSnZ0cUZrWlBkUTZvWERWUnpQZnUwcmx0VU1mTUZNN1BZWWFxMitV?=
 =?utf-8?B?c0wxdjlwNkdrNkx6ZkJFV1NsSzZLY1hhKzJDWWxueG1nSjcvMlQ5NHRxL1BE?=
 =?utf-8?B?YzhLVmZmZk1Bb2lVbkpYc2FmQVNvcVNMRTdTUEhkUGlTMG5nTEEvQUdtSHBJ?=
 =?utf-8?B?OVl4TnNreXdHeUwwZGJLM0FWK3dOSlZzWGRTV2c1RWJnR0hTVXFIalNUdzdl?=
 =?utf-8?B?d0xrVWZBVFA3b3IzY0NVQU8yM1NEVUUweDZZTlZncFpTUW5XUjVLZTJzd1Np?=
 =?utf-8?B?MUQ1cE1mWWErS0VDdU5kKzlWU0g5M3VhNFk5SmhFZEtpMHhyejVnSW1McEZL?=
 =?utf-8?B?cUoxTFkzMU1vYmEzeEhHN2NKdDJyd2ZZMHhickpWNU1ocTRISk1PU0M5QnEr?=
 =?utf-8?B?bXRXUjZxc2NYQUlXSWphNWpzVmk2Rkg3b0IzSjRjM1JrMGNzSndxckhKZ3pk?=
 =?utf-8?B?NVBNK1hLVXdCeDFKU2VNSmpBSmlHQ3pnK3ZjRTVUU1NmbGJEOTdTaG9yWkNv?=
 =?utf-8?B?Vk1pRHZIZTVWN3Fqa1VRMWJFMlk4N01FTTBDeUVxbWo1ckJhWGtJSnp6V0Fy?=
 =?utf-8?B?MHBzeVBRcUVpWEVMbDNKWkEyWTZNMGZ6emlwam9pK3YwRTA1RW1nY29xclA4?=
 =?utf-8?B?c2Z6dlR4VFJvSGpRc0EvYVQ1cUh4SlBGTGVuanlPaW9EMXF5bTBmcm90MmJN?=
 =?utf-8?B?Tm5kT3ZMRElMSkZxazBlOWlNd1JWclBQREplcnlyRWl2anpNcURuSDdlbDBI?=
 =?utf-8?B?MGtjUkllaE1kUUlRVFZmaFVWeTQ5NnlGeEN5b3BrUURlTnYwVFh2WUFyU2Ru?=
 =?utf-8?B?UEV0U1ZmUWFwOXE1NmR2MU9SSUdUWnN1M0E5U0hpMHhlNTFiVnlQdEkxbDJn?=
 =?utf-8?B?QkV6L0lGOUkrY3ZEVGQ2b3Y1L090cXc2Ly9hdG93c1VFbHNFSGp1bUx2UWNF?=
 =?utf-8?B?TnFGNUhQbU4zTkpYRmwwdUg4bXdZSERuayt6cG92Q0s4NnFvaFdHZmt0ZWpP?=
 =?utf-8?B?QnNNWnpYYkovRzZGVzhvSWl3UmdiUHZiRS9WUW9sVTRGUnhwZ0dCV3hyYTQ5?=
 =?utf-8?B?MWZ0NE5kd3RaTWhnWDFvWWJOSXFmdG9DemJEZzZuaUpTMGoxRk0xYVUreDg2?=
 =?utf-8?B?bDd1c1M2bUp6dlMvMi9EaUp5a1VxVDFXaTI1bW14dmFMbVcxWHR5bDBjZHNW?=
 =?utf-8?B?d2RnTnZTZXVuMnNDaXp3Mi9YUmFOSlMrK0pQL1Rxa2dCTkdWb0JyQVhESUEw?=
 =?utf-8?B?M1FoWmtLSHJuUGYzWlRLMXJaR3ZZVzdXU0xGWTJ5OXk5VXR1enIxcDU5Z3By?=
 =?utf-8?B?Z2w5bnYrRWtZaUhVN2ViTlQyRU9VdWJlWE9zUU01c25HTE9mV0lwc2R5MzRU?=
 =?utf-8?B?NXNTajhkRGRHVmxNakVnS09YTmlCU0JiWThiUGc2aDFLc3RSeXg5Nm4za2Mv?=
 =?utf-8?B?a0xyWllsanVYM25UMC9WOHRuODh5MzB5VGlRMTFaRDdmTVZpL3d3Ky9vclRT?=
 =?utf-8?B?YTFiTGNNSzEyL1NSakkzS01tS0pvblg0M1RTeWtWTVU4b3Q3QlpUU3hZUEUr?=
 =?utf-8?B?RnJQWTZkU3NtNWRFVmMwOGhGU0Q5eDVGUUYyaVVpZkRkUHErUHI2bVNobHI0?=
 =?utf-8?B?cmNrblVRam50d1phajNyU1piMktYNzR2OEZJL3Z4TmhKUnQ2d254cld0TEVY?=
 =?utf-8?B?SGZoT3E1S3c0Q2JuZ0picTFLNHJWWnBOUHJVQStINzFET0psZnBFbjFuRWtL?=
 =?utf-8?B?SDZ0eThFaUR4NjQxWDNUamUwTzROd3FuVmpKYWxuSlB6dElVME5vVWptS05P?=
 =?utf-8?B?U1N6ZThkVWsyQXI1WTk2U1oyOWE0TVlUaE9KbTlYYzQxMmIzS2NRSk04Skpv?=
 =?utf-8?Q?nPGrERTeZSqVwRfCJLxcudxmR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e872f3-15f0-43b5-0104-08dc0069f6dd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 08:10:29.5291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkTOYg6DWqLwI1oNuq18XHWIdM4p+xQ1e9VXRhSx2f0C8OTBSMLnphj/3O87xs8u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.12.23 um 16:19 schrieb Felix Kuehling:
>
> On 2023-12-15 07:30, Christian König wrote:
>>> @@ -1425,11 +1451,21 @@ int amdgpu_vm_handle_moved(struct 
>>> amdgpu_device *adev,
>>>           }
>>>             r = amdgpu_vm_bo_update(adev, bo_va, clear);
>>> -        if (r)
>>> -            return r;
>>>             if (unlock)
>>>               dma_resv_unlock(resv);
>>> +        if (r)
>>> +            return r;
>>> +
>>> +        /* Remember evicted DMABuf imports in compute VMs for later
>>> +         * validation
>>> +         */
>>> +        if (vm->is_compute_context && bo_va->base.bo &&
>>> +            bo_va->base.bo->tbo.base.import_attach &&
>>> +            (!bo_va->base.bo->tbo.resource ||
>>> +             bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>>> +            amdgpu_vm_bo_evicted(&bo_va->base);
>>> +
>>
>> The change looks mostly good now. Just one thing which worries me is 
>> that when GFX and compute is mixed in the same VM this here might 
>> cause problems when we run into an error during command submission.
>>
>> E.g. GFX validates the VM BOs, but then the IOCTL fails before 
>> calling amdgpu_vm_handle_moved().
>>
>> In this case the DMA-buf wouldn't be validated any more.
>
> This code path shouldn't be relevant for command submission, but for 
> the amdgpu_vm_handle_moved call in amdgpu_dma_buf_move_notify. That's 
> where the BO is first found to be evicted and its PTEs invalidated. 
> That's where we need to remember it so it can be validated in the next 
> call to amdgpu_vm_validate.
>
> Currently the amdgpu_cs code path calls amdgpu_vm_validate with 
> ticket=NULL, so it won't validate these imports. The only place that 
> auto-validates evicted imports is amdgpu_amdkfd_restore_process_bos. 
> So none of this should affect amdgpu_cs command submission.

Yeah, but ticket=NULL will result in removing those imports from the 
validation list. This could potentially result in not validating them 
should we ever mix GFX and Compute submissions in the same VM.

For now that works, but we need to clean that up more thoughtfully I think.

Christian.

>
>
> The flow for amdgpu_amdkfd_restore_process_bos is:
>
>  * amdgpu_vm_validate validates the evicted dmabuf imports (moves the
>    bo_vas from "evicted" to "invalidated")
>  * amdgpu_vm_handle_moved iterates over invalidated bo_vas and updates
>    the PTEs with valid entries (moves the bo_vas to "done")
>
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian. 

