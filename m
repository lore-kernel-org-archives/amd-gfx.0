Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66AEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 19:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D281310E795;
	Fri, 25 Nov 2022 19:42:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8304A10E795
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 19:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJRMgyJnnOIh69gxBzXSiVGtWjn8v8YMtZHoUVCWtt6zxjS+tsGCq6cWLrveK6EhoWEa0N/J1Oon8camHrqDKmA+Dio2Mg8NYjlJVQwCNQRyfvbQaw5TnpwIZn1TVp5O+zOtL31PV94Z/sQaZ1sTx9OmdmWYP0IHgAJn2bp4YHoCPaSWjZq9NF4jHeEHxOFVdH+f/piiwWpZiIlsDlarSCWmGwe6Nk2umZJBZMqq8flpqma6tmcWmPzo5/7TpulaqzahAFNdEfrreo1EiDi39NYNKUXt9aSn9S1Qyb5EPBqpo5tJC53bPKiM3Ulr9XsHmYzhQHQop6CCCPgQ91xUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfZY8QKzh1iNyozkaDdUSh6JPd+KmetOsMXGJHSzTsI=;
 b=f5sDeADjgI4sDEq3d2otH3TmzLxAUkdMbPIY/5sIyhQl/7YDuJwrkKovdBhaJN8hRzhk2rRM1PiiblAUzN5DVDZWVrHuDlfu3NkUB89DAUCAgOuiTc1UzyjNfRtuKfPjWXWQx0l86WHd/7V8kn+yI2nGfmrih8GAUZ6zpZu0uZCBuMSKDlmjdoa7588ua15hCT/OlFy/S77WXCrq6Q62eyt8RXfLXG6EY7NFipOzhA2JEhxHxbobEQe0wGml89c6pTNJHyq5PuXtFNDOij/1Ql7z695zYT+P4ov9E7LxxvU2zf7SoCyQHw2pkBZbjRRIXgtYI3HUgME3EnGKwEKrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZY8QKzh1iNyozkaDdUSh6JPd+KmetOsMXGJHSzTsI=;
 b=jTLlVtfiY1SWyNoh69X7bizs9fXJvM2fxJx48fbcriJZpXnigf0uPBJ/0r4UbOrY2FFXQ80hHPYYcd9mkynPhWhs24ffmwdv+1YhYUTvpAuqbJZCaKnZI2cE/N8drMwnXCF39Wa4f80t7KN1wDGfZL9oWikDWBcnfG6gRRjtSgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.20; Fri, 25 Nov 2022 19:42:36 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.018; Fri, 25 Nov 2022
 19:42:36 +0000
Message-ID: <856f03cb-a226-1525-bccb-79bab4c6f6df@amd.com>
Date: Fri, 25 Nov 2022 14:42:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
 <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
 <5319277f-5841-4051-2684-93b3a985197a@amd.com>
 <fc5238a2-b30d-579e-ec7d-3686238f8b12@amd.com>
 <52eed51e-e234-aa36-3d74-3a4f39bb1dad@amd.com>
 <22425c61-9a95-a650-d113-396aa35e52cc@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <22425c61-9a95-a650-d113-396aa35e52cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8275bd-3381-44b2-8533-08dacf1d346a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrtylW4sJetIchju7BVVmdkqCpk+f4M3X+17utR49uhlYHqaJPjMur3HppkdREUDup0CI7TmKxO5AohF/rpdER3ttPRNkJfKLreNNbM0kxJ3tLxG3oKIGfamfCyYCC3sRnPj82nSbrxyoTpdkvKysPgBcWqMUWiqvpx1MjgWwh5d90qYSGB+w0uwFLL3tcFkrt0Cul6J/Nffdk5J7CYnhS9tiDrj01Hw7aoraWVPHGh+3aax5GtNRQ4i/BFkOYzpJpegMulkXarOEZ6Fxs14gc0f/feVh6b/zKOjETyZ3iN7VyT+4w5P8BZvhDrLEbjWC79qeJg5hOyQXdb08ZsEJnvinUwTFiYzxxwLYvP8osmOqqPuJqXKt7S6ZDE6+lemUU58o4Ho/ynP7ienL8TmYf5Phm7mqQRz8bEAJwZC9ZlviPgvsiTsUhDWuDtiy3d4xp/WmURmMH5Kfe6TvHIR1Wptz05h14lzUg/ZIPxZvb0dx3OAP+9w/1LHsUwak4Mvu9+88vdXkeBCGS3hxDqRHmXvZa7tEfQhE5txFY1ZYn1ftbJt2bM7MM0lWMxbWvjLiGFwm2mQRf1yhxwUjptPzluOmN+Y9hC100Zz15GA5JDePU+AoUAQBwf3JFQ3J36Ttq9Xy32H+adNmWjBvgt10J3qkhbWxYCQHKlUB4e0ltuTWoIoiPr17N/jNQUdaPBsCb0rZ2Qi3C5QBhfodCfjDV5IwNO7ThLOxz6WCiuTk44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(186003)(66574015)(6512007)(53546011)(26005)(6506007)(36756003)(6486002)(4326008)(110136005)(66946007)(66556008)(66476007)(8676002)(5660300002)(41300700001)(54906003)(2906002)(4001150100001)(478600001)(38100700002)(44832011)(31686004)(83380400001)(2616005)(31696002)(86362001)(8936002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjN0U04vQkhNQytBY2dPV2ozUzRFWWxjRUp2ZW9MaXU0ZE1pOVljdm4yUU1U?=
 =?utf-8?B?elZIWkJyTHhlaFM2YzVITTJBaHdTZ0Zoa2dXdGNsRHQrV1RPSUU2NmJkVno3?=
 =?utf-8?B?Rkp2KytPWU41ZkhBdGM5R2FVMGpmVng5ZlJEY1g1Z0cxc2xaYk12VzJVNDJD?=
 =?utf-8?B?NDNqdWM2VEdyVSs3OU1sZVpIYk01N0Q5TkthNlkxVnJ1WXZMUmJXeURPRllM?=
 =?utf-8?B?a3ZCT1VEU0VnTWVoL3RnYUJoekZIc0lTSzJtUng3dTI0UHIzbUU4T095MDFH?=
 =?utf-8?B?SkpNWDdlbjNxVVg0dU9FODB5UDEwaFRrSGZNdnNOeFdtZHR3RmdQZU9KbmZO?=
 =?utf-8?B?VWU5ZXNVQUJ6SlFHY0Jrd3BnSGxvaEhKZ2RtMGs3bEdxSXVzSEVKS0RPcFF0?=
 =?utf-8?B?a0lCaFFyZFp3ZUNwd3VKNXA3SThPL284ekJqK2N4S254N0R0VmZ6TCtiUmt0?=
 =?utf-8?B?SWUrUnY3V0hyd1R5RWZtZEpyNisreCt2K1orR2N5UkpBWjR1YkQzc3JUd3Q3?=
 =?utf-8?B?cmNpV1JyVzJsY0VaN3hmZmV0cVYzL2RVcVY1ekdMT2Rkb0czWGtQL0dOcHcz?=
 =?utf-8?B?am9QMFBwbU9hUi9kUEZVbmlhODBDYjhUMVZDUGFrNHh4WFhCOEFHTThkMkJ5?=
 =?utf-8?B?K0RIL2lyZDdMTUhLOHRsNGVFcUZPWlVwNEtjZlFwN0lmN2RabVhtUllpRDlv?=
 =?utf-8?B?amhlTG8zRnkyTURNMDdmVlFHcGZzTkFFbTgwQmV6SUdSUmRINktPNlp1cTlH?=
 =?utf-8?B?cFM1LzBGbkgrZGo4aVhpcld2bjFmRnMwTzJCOWxucE9tU3RTTDVIZ2pFN09E?=
 =?utf-8?B?RkRnY2lvSzZSVGttbVdZUG15aHhTeC9RbG5WUlN5ODNma2xBU205bW5EOGFG?=
 =?utf-8?B?SWY4bkJxbHNLRnhvNXFoVGtsWFZyYXZBRnhyR1I5akJ6N05nelA1TlRmMVNa?=
 =?utf-8?B?eUdqZTk5MFYzZnBDSGJybE1CUmZrZUtoOHYxUmtrcEt1bDBLajRFcGJxbnFP?=
 =?utf-8?B?QTBFQ1ZuZmI3blBFK3JEOGV4b0lZYUY0K1RYK0UyNGV0MmN0eDJhNDl5Z0xk?=
 =?utf-8?B?S09xc1NYUmRhaFcxRllYMjZJdDcvd1EwcmJuYkdHNE1aMGdBZVNXcC8wc3Zl?=
 =?utf-8?B?dzVya05JYytjcUZQTFkrZlBldnhvTDAvTFpBRGxuUENud25wSzJoUHRueTlS?=
 =?utf-8?B?K3QzWmM4cTcvcitXL0RNT0cyUHZSNG9hS2g4L05lQ0VucjJ0MnlORzBIb3VP?=
 =?utf-8?B?WEVLRXZCTXMxem96UlFTd2t5NE41OU03RlZ6QXlJZFBSNDZxcXdJNWtrVjZB?=
 =?utf-8?B?RzBSRXJvQzc5ZTJjeGtWUzZTeWtmK3daWklxVGNNTjJ2QitzMlhtYUN1NUxU?=
 =?utf-8?B?SDRwWndhU1pFNUlSTG1qK3FkWTNlVHIyZXJxZkREMnFLaVlqNTVnRnJyc1A4?=
 =?utf-8?B?QXRCOTZ4YjIrTVlPOCszZ3c5Z0c3ZTZLVk5ObjVSeUlMaU5ONE81SEtXcmt5?=
 =?utf-8?B?UHBtcHFrTFNER3VlTDlReUdkazJwVmhzWGhvL2hvY29QUmE3eGxYUnhMbXYw?=
 =?utf-8?B?RlhtSlU3eDMwU1c1VklUbzl1c2FrL2kwSVV3YkErY2FOWXBDWkxiQlVTUmdp?=
 =?utf-8?B?b2JOZytkUmdnbm1RNFNkNE05SXZCT0l4SGVTYkhVRklJSFJRK3ZhQlY3ZDRH?=
 =?utf-8?B?aDNHK1NxZGZ1LzlDT3p4ZkhaWGNpQlcydmFibnVBOEJ2NzIwazVhdWcxWUxH?=
 =?utf-8?B?dHVpdWRxS2ZJQ2NvV005aU1QRXJRSEtlUzdoVmE1Z0tzMFYzVG1EZDNoQk1z?=
 =?utf-8?B?SGZpVXBOOGFrMHlaSmZmRjZBNG9xNit1YkxvWjBpZ3VXZ2dQWnZ5RCtlZ1hr?=
 =?utf-8?B?TkxKamN0TmdiMjE0UGZrc2tGbjBUaHNlT3dIVTZnYnN5cUpkb0dLQ2o1Qzgv?=
 =?utf-8?B?SVU3eGZQNW1xZ1JYekpSenRkQ1NUR2FKQXI3QkhxTkI0MXlDZi9zQnFETDZO?=
 =?utf-8?B?SjJFdlFTWlNmNGROUmcvQTN5Kzl2aGpxMHBIMWtKYjI5NE5UNnJvQis4NVJz?=
 =?utf-8?B?MlNUUWJ0a05pWGpWQlBiZThqK3pGd0dDdmY3NlAwNnErVDFjcmpQdWQ3QjVk?=
 =?utf-8?Q?mmGLXSe6gBKkAezi47eUqawII?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8275bd-3381-44b2-8533-08dacf1d346a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 19:42:36.7993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTasgk7yscPdH2WGv75Ehp/3ACix5o5UCN6ADpPqsO++dtaAiDYf3+YBoS1JztwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-25 04:57, Christian König wrote:
> 
> 
> Am 25.11.22 um 09:33 schrieb Luben Tuikov:
>> On 2022-11-25 02:59, Christian König wrote:
>>> Am 25.11.22 um 08:56 schrieb Luben Tuikov:
>>>> On 2022-11-25 02:45, Christian König wrote:
>>>>> Am 24.11.22 um 22:19 schrieb Luben Tuikov:
>>>>>> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>>>>>>
>>>>>> Cc: James Zhu <James.Zhu@amd.com>
>>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
>>>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>>>>>>     1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>>>     	hmm_range->dev_private_owner = owner;
>>>>>>     
>>>>>>     	do {
>>>>>> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>>>>> +		hmm_range->end = min_t(typeof(hmm_range->end),
>>>>>> +				       hmm_range->start + MAX_WALK_BYTE,
>>>>>> +				       end);
>>>>> Since end is a local variable I would strongly prefer to just have it
>>>>> use the correct type for it.
>>>>>
>>>>> Otherwise we might end up using something which doesn't work on all
>>>>> architectures.
>>>> They all appear to be "unsigned long". I thought, since we assign to
>>>> hmm_range->end, we use that type.
>>> Mhm, then why does the compiler complain here?
>> Right... so MAX_WALK_BYTE is 2^36 ULL (diabolically defined as 64ULL<<30 :-) ),
>> and this is why the minmax check complains.
>>
>> So, since the left-hand expression is unsigned long,
>> i.e.,
>> 	hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>> is,
>> 	unsigned long = min(unsigned long long, unsigned long);
>> The compiler complains.
>>
>> I'd really prefer MAX_WALK_BYTE be less than or equal to ULONG_MAX,
> 
> That's not only a preference, but a must have. Otherwise the code maybe 
> won't work as expected on 32bit architectures.

Well, I don't know what to change MAX_WALK_BYTE to, and given the suggestion
below to change to min_t(u64, ...), I wonder if messing with MAX_WALK_BYTE
even matters--it wouldn't matter so long as the type in min_t() is u64.
It's a macro at the moment.

However, the LHS--struct hmm_range's members are all
unsigned long and then we're essentially doing (unsigned long) = (u64),
which on 32-bit is (u32) = (u64).

Regards,
Luben

> 
>> and be defined as <literal>UL. I mean, why is everything in struct hmm_range
>> "unsigned long", but we set a high limit of 10_0000_0000h for an end, and
>> compare it to "end" to find the smaller? If our "end" could potentially
>> be 10_0000_0000h then shouldn't the members in struct hmm_range be
>> unsigned long long as well?
> 
> No, that the hmm range depends on the address space bits of the CPU is 
> perfectly correct. Essentially this is just an userspace address range.
> 
> Our problem here is that this code needs to work on both 32bit and 64bit 
> systems. And on a 32bit system limiting the types wouldn't work 
> correctly as far as I can see.
> 
> So the compiler is complaining for rather good reasons and by using 
> "min_t(UL" we just hide that instead of fixing the problem.
> 
> I suggest to use "min_t(u64" instead. An intelligent compiler should 
> even be capable of optimizing this away by looking at the input types on 
> 32bit archs.
> 
>>
>> And for the timeout, we have the (now) obvious,
>>
>> 	timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL);
>>
>> and I don't know why we necessarily need a "1ULL", when 1UL would do just fine,
>> and then compilation passes for that statement. I can set this to 1UL, instead
>> of using max_t().
> 
> I think just changing this to 1UL should be sufficient.
> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Luben
>>
>>
>>> As far as I can see "unsigned long" is correct here, but if we somehow
>>> have a typecast then something is not working as expected.
>>>
>>> Is MAX_WALK_BYTE maybe of signed type?
>>>
>>>> Would you prefer at the top of the function to define "timeout" and "end" as,
>>>> 	typeof(hmm_range->end) end, timeout;
>>> Well for end that might make sense, but timeout is independent of the
>>> hmm range.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>> Luben
>>>>
> 

