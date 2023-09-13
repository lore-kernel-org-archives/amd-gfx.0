Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7BDEDEC53
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 13:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690B910E4BF;
	Wed, 13 Sep 2023 13:46:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED6210E4BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 13:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPe/EKiYABr2RA1i+bL8Wh4taE660w2mJX/urES42b4sUdtdCTlZbqO2npFMD/Fdr/IJd5L/GXOGVaxsnGuQWZaXzDiXOq4Csia2TYzgOB5QKQ/drwpahcSamvOj1fbeBlUcE94mT9RiK2MvA0ZBxnSrjkn689v530LzYXEZVJgzBxWQCPxrwcynb+bKRnvQGwV44dsUsdAzq4lJuUPD9YL1ecf52U/ApVvZFyZqFuczx0N8NdDRHxcqV6pH1u3qc5CxjIOms16AMiamaJSlhwcatZ1V6FTOXN9ieCtYjuaz+ao5UzKJQ58L2O4gFnEi4gjaSfMMb8dgfusX8OH+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR3VdnIvvcrVCyeLgLf/fzh/g7iUfyskFZCcQNg/hlg=;
 b=KG2Z6rhpV7ERQwtsSkKTnqsONYyFO1e1CRsR0X+gx9gx7ujXBsCdLgWE6RsRnYrlugO/sSBgL97wdPBWKWeQbZfUBLGz0oBnVqLFwTMrxX0+GHN31/sQC0+hOrDi6Q7+PoYgs444+R5GK9KUG7lKOJh11qc5922jm6pm23L+U9vm/5m/tOc1KFbCDr7Aag8qo6afbI8WBo2ZM8rMqwpZy9bNcRanoZMuMVjM7TZGG9JP3NRjD7OY8MGTVO1onOvNXo+wUcnGRFehz3sgadWnKJiqGJ9q7HH1GstIbtJTTAAkAje3ZsA+NND24ZMFsVNCqkyf6X837KriD3j5jv/CXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR3VdnIvvcrVCyeLgLf/fzh/g7iUfyskFZCcQNg/hlg=;
 b=Ts1N4cmZjmAWqRTeAUoAdMjVVQ4fC9QG1NbjwICYYY7VbwzWc3nt/Ofyps1M6hSSdY/c2QaPyxd0mUOFg90/RXjZaA4s4AVeY1YP4pFqYJFo1I1OxypECunzMsOJBF/mjR5B+U/uvVWxVbATdNr/352PzAUjD4CDEkKSw8p4+6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:46:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:46:07 +0000
Message-ID: <5300374c-3f89-b80a-622c-afca07eb0e16@amd.com>
Date: Wed, 13 Sep 2023 09:46:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
 <ZP/SdUd9am/f2WJw@lang-desktop>
 <c04dd9a3-ab81-5d5d-fafa-93877073017e@amd.com>
 <ZQGNtOJsi4K914Oc@lang-desktop>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <ZQGNtOJsi4K914Oc@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 581432b3-c27d-4558-2763-08dbb45fc7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/DFPEwOvP4cseIcdE2IbvcMIeNd9R8XBvPkOBv+hF1+1dSuxQomM4Y0tx2p14LrDEzYdnbs+15BRmSxwXCaav4oO9D2PNffE/+QNi9MA39J0QGKZrPsUvOW6S2kbDN0zWTFZ4UIQmr350XAxFUOuuvhojTJN8w7KuL2OJ/CzB7iS+fWIz7h73a5DCwgpvtidQEVjc6K9t3pXg9AQRFO4RB0LBPYeLA/tJWFytp9WtrUbN01QeGj8bgJIy2xYi1uaqEU4QpIW+0XPDRfU6i5GJiLvLzj/nB1Lii3QN8hbPAzg7y+D3pCE+1bAd2RFYHV0kWGrZF+NCekh0ZZCdyeKtIWaHcYpLA27aNaD0Tboond35/DLumc+8I2qpWWmhVm09OdMsnqN5yPG+xDjXyTgvPTrzgHacZM1jxbM8YQ6DcaEwK5QuJ8WXq3ZFdqNlfhjjpdURbxJOkn2COcSbKcXBCYUbC7Q8KAJR8Vb9RiKs8aqo2VgzFOQtEsMYvlFg0WxT4ktrvMO2EEZlf4JEHq8Eg4uBB3+XBDYZPLdN9Lywku0FpaRApDmMwrvjAptMqZ6RkU2drct5MTBoFQImoNvwqJZtn7i/z9cQYvAZNr06SNTBZSi37NSiUnsuFQ1ZZno4SzXwr6AFjChJEiVHefAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(1800799009)(451199024)(186009)(8936002)(44832011)(4326008)(6862004)(8676002)(6666004)(6486002)(6506007)(41300700001)(5660300002)(6636002)(37006003)(66476007)(66556008)(66946007)(316002)(478600001)(53546011)(6512007)(2906002)(26005)(2616005)(31686004)(83380400001)(36756003)(38100700002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vlo2SDc5NTFPQzRkZzduZFlBd2JLVW10NGRWeGt4Q3RqOWtEQkZWTkpUM3Zi?=
 =?utf-8?B?YjB6TldLWkFWR3RzQXI5aTFZeDRjUXRMRTJBQmpxd0lTaEhPbnRPZmR0ZzZi?=
 =?utf-8?B?V1Y1MGs0VHhZYXRhYWdXSVJQVnVuMXRxUUovVUh5M2R5UEtKamlYcXljblQ0?=
 =?utf-8?B?eHkyek5mYnB6NHR3ZlpKS3FDVmRjRGhNK2VtajFxa3VNSXNpelVuZVhHNHVm?=
 =?utf-8?B?eDR4WXNmT3hzK2d1czNFd0ZrT1dKWXdmeE5CZFk3NHlsYUx2YUk5ZHFtZEw3?=
 =?utf-8?B?U1g4cXR4U2ZnNVpySzJKRldhYUszQk9ucXRCeldmaEU3Q29SNm1OU2tSU1Rh?=
 =?utf-8?B?ODZoT1RScUp3aUxJb2lQODNmVnlXVXI0T21CbW4ralI2QUt3UkJEZW5oNlMy?=
 =?utf-8?B?OWtYK1JvZFNnUFFYRkFscmRHbW5GbU5RQW85ZnNFUm1vUnJPaHlZZks0MVll?=
 =?utf-8?B?SXl3Wk9VWFd5NWpHU1p6SmJuU1hyMWJaS3NQTzNoQlM0dmJ5OVdNZUdXYk1F?=
 =?utf-8?B?REVJeGMwMmJIaGV2enFhaGcvUmdzTnhmTEMyb3gyNWJJdmhHMmFJaExaandH?=
 =?utf-8?B?aVUwMHVvYXJZMllmR3JSUmxnM0lSYWpTNG1YOThFUGthSWtJc3BDMVBoQ3Br?=
 =?utf-8?B?T0xmcFpRQWJRZ3laemlWVnFmb2dDYkRqRG96V3VzVkVvSFAxNDh1V0ZCOHRn?=
 =?utf-8?B?MUJyb0FQQTZ6TVQ4Z3EwUlRzWXN6bjlZN2p4OENTS1BQSXlFeVVGTEdaRlJm?=
 =?utf-8?B?YVJpQk8xVkVFM2lQS0RKZHpseS83amNpYWUyWktPaEFVcmRLdHlCMVNGSmp0?=
 =?utf-8?B?SzREMmEvY2h4QW5rR2pKYTRJZ2U1VnFONEtFV0ptY3FmTGRGcWdnRGZBR2c2?=
 =?utf-8?B?R2dBa1ZlbC91bDBIUjUrL2pvU1hYUUdDb3JGbFY3VE9sT1d5dkIyYzljYnNv?=
 =?utf-8?B?Uk51RWZ2QkV2VU1zMTRYcGdaWHptYUorK2JtdjBVUFU2L0QwSFZjeFNwWkpZ?=
 =?utf-8?B?RHJXUkFNVEJWRW9FS0tWTEFRV283MTlTRStnb013TWhvZGJpQWRLbU5oenVE?=
 =?utf-8?B?V244eGVVeE1TSVdOaG1WVmtyL09SamtBQWVQcDFWbW92UTg3N2VQd3hPUmlR?=
 =?utf-8?B?cUFzbFg3K0d2djFHdW5ZNWNwSnRsVVhNdWlacEgzODU4OWdMTzVDNDdjMmtL?=
 =?utf-8?B?MS8rNEYzL2xSdzd2NU55L0h2NngxaHc1RkRKUEdYKzl2akFIS1RYYjZObE9h?=
 =?utf-8?B?WUxKTVo3VUpVekZFSHdJN3RpQWtBMVg5QTRqNGJTeFhhRGpwZXZ0UjM1Rk1B?=
 =?utf-8?B?NEZyVGxPaVdQc1BEM09KWnI1amh3TEVUNitmZm0ycW5aQktocXVxL1Fvd1Jo?=
 =?utf-8?B?ejRPcndoTGVmT2d1T1NXTTdPVjZBZDRXWTZvQXVKWXUxUmpVR1BIUGx4TmE5?=
 =?utf-8?B?VHl2eGRsampubU5UVmZhcEtkbytpYm41dStmeU9HbVdMU2JXcndIQmdFSUJC?=
 =?utf-8?B?MWtKY3BmcFlRZ0FvMHRvUFFhM044OHUyZGxHWk9SdDZVR0U5YjF3ZzU5cWhR?=
 =?utf-8?B?bHJrRDNGQi80V0ZrWlpRd0w3TEpOWlNCSndrZ2U5U2dmK004ajdKTXVpcElR?=
 =?utf-8?B?Y0FxdjZMQTkySExoVWY5aXY0NzdFZkI5YldkdmIzWW9DRitLZ0pEMWNXK1Jy?=
 =?utf-8?B?VmlrVmZwNG5sOXZCQ3FoODZVdnVvbEJLY3NaaDU2cTQrQmNyN0k0amdKVHFy?=
 =?utf-8?B?WUZjZGFuTFd4SG1hNkJjVDdwSnJZVTVnVlI4eUZEbCswaGZ3MTJHeDl6THA0?=
 =?utf-8?B?OWNJejVPVks5Qm1CV0krQ1M1VXFJeU8yNnB5dUNJK3QrM3BKRjVGckc4U0ZO?=
 =?utf-8?B?UVRqL2VBNG53cG1QRS9XVlhqemt6SzY0UGcrQWxtUTcrWklick9QS1NpSUxR?=
 =?utf-8?B?dllVWGt5Y3V4ekRxcGxybjk5WGdWdmVsVm1OVEdna1B5OHVQYmE0QWZQRW0z?=
 =?utf-8?B?Z0N6K2thclVyWXVMQWc0cVJ2UjEyQ21IS0tpamYyd3VIL2tyVERidXNZMXRi?=
 =?utf-8?B?cW10K2h4aTNjWWVhL2wyUW4vQzBlOHo4SHd5Z2VZYVdMTXBBK0FIK2d5YVVr?=
 =?utf-8?Q?NJ26XQurCEGI6KVuTBW1mSLea?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581432b3-c27d-4558-2763-08dbb45fc7ba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:46:07.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1aJFNjheWe+uCr1q0KcrtvaDdjz3e0gC1PlrN6zQ/6GkZT2CLvwKgdCZkQUQ82FN1W9Q9+1cl2TFhBNUc571A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-13 6:23, Lang Yu wrote:
> On 09/12/ , Felix Kuehling wrote:
>> On 2023-09-11 22:52, Lang Yu wrote:
>>> On 09/11/ , Harish Kasiviswanathan wrote:
>>>> Heavy-weight TLB flush is required after unmap on all GPUs for
>>>> correctness and security.
>>>>
>>>> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index b315311dfe2a..b9950074aee0 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>>>>    static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>>>    {
>>>> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
>>>> -	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>>>> +	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
>>>>    	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
>>>>    	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>>>>    }
>>> 1, If TLB_FLUSH_HEAVYWEIGHT is required after unmap on all GPUs
>>> as described in commmit message, why we have this whitelist
>>> instead of a blacklist?
>> That was a bug that this patch is fixing. There were specific GPUs and
>> firmware versions where the TLB flush after unmap was causing intermittent
>> problems in specific tests. This should have always been a blacklist.
>>
>>
>>> 2, kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is also called
>>> in svm_range_unmap_from_gpus(). Why not add this whitelist there?
>> There was a patch that used kfd_flush_tlb_after_unmap in the SVM code. But
>> you reverted that patch, probably because it caused more problems than it
>> solved. SVM really must flush TLBs the way it does because it is so tightly
>> integrated with Linux's virtual memory management and because with XNACK,
>> memory can be unmapped while GPU work is in progress without preemting
>> queues (implicitly flushing TLBs and caches):
>>
>> commit 515d7cebc2e2d2b4f0a276d26f3b790a83cdfe06
>> Author: Lang Yu<Lang.Yu@amd.com>
>> Date:   Wed Apr 20 10:24:31 2022 +0800
>>
>>      Revert "drm/amdkfd: only allow heavy-weight TLB flush on some ASICs for SVM too"
>>      This reverts commit 36bf93216ecbe399c40c5e0486f0f0e3a4afa69e.
>>      It causes SVM regressions on Vega10 with XNACK-ON. Just revert it
>>      at the moment.
>>      ./kfdtest --gtest_filter=KFDSVMRangeTest.MigratePolicyTest
>>      Signed-off-by: Lang Yu<Lang.Yu@amd.com>
>>      Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>>      Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>>
>> Regards,
>>    Felix
> Yes, that's because kfd_flush_tlb_after_unmap() return false for Vega10(gfx901).
> kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is called unconditionally in SVM
> for ASICs > IP_VERSION(9, 0, 0) and works well.
>
> So why not relax the condition to KFD_GC_VERSION(dev) > IP_VERSION(9, 0, 0) ?

That would reintroduce the same problem that this workaround was meant 
to fix. I don't remember all the details of this, as it was years ago. I 
believe it was an intermittent hang or VM fault that was somewhat 
difficult to reproduce and investigate. Maybe Eric remembers the details 
as he was working on this bug back then. However, it was a real issue, 
and we got an SDMA firmware fix for it on GFX IP 9.4.1 as you can see 
from the FW version check in kfd_flush_tlb_after_unmap.

I would not recommend reverting this workaround at the risk of 
reintroducing a known intermittent bug that affects stability.

Regards,
   Felix



>
> Regards,
> Lang
>
>>> Regards,
>>> Lang
>>>
>>>> -- 
>>>> 2.34.1
>>>>
