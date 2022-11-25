Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0B3C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 21:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0AE10E7A5;
	Fri, 25 Nov 2022 21:03:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC6210E7A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 21:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffAGG/ROMIoY5UAbCQuiW0uQ5cXyM6S8yWNoNtm9v63myAC0sa71QOcTZu97AyDv4tVG+MudWHTDGMDMqT2E+xKFlJwnOVeI36Sh7y8F8Jg2trCZFk3pzHVOxOMn2iB+vfNu0G5cVqAeGHmXm7LwJr8VWmkwlQkjcAmijQ/DqhgkGWV0baWeirya4A3z03ZPBilLPJT1ZQltC6ur341KuylTXu17khTo7zeIuF/o0nMtrKZ6TVJtT+mu5O/zQBRREME2SKduBdsJTuAgrJ20qfV+3qSDl8Acp4XQES0ME3GpQx452e+Wd8xZlZZZZM1U0bt1IqxxjcDqFiH4p7sfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovhKPWWMsNd83r8oF1qiu4byQ5x2Q2ztJCs2NCYXYAs=;
 b=Qmoiwf1oyGrbJM2Sr6PF9BDvUhiJgdJbJZpKrQzMuIlWK3hTbbDVeUyLJoEVmvMLLzbx0pvCcc333jI2g/bNBTED+2uab1bYjlmFvvJSD0p8tTXvn3H39c0DHZZzyXZTbknk7Bca27pMkNkxVrmjerEhS/b70ctdiJ1rzbpIWCOIOjUzCsERkDe1oMQ5f61nz0FFbNgu9O2e0JXB7xFC828yqT9ogzUQ5ittwTZn6w6UeS+m+J7phkzUmUivaHJ2rCmqypm2THzltExCH00odyr+1BuYJdNIo4KBQ4hjvM5e7IcO+Ym2ZwHavGH8YrK/hjb0J9vPa9N+0PoQQ6WLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovhKPWWMsNd83r8oF1qiu4byQ5x2Q2ztJCs2NCYXYAs=;
 b=1ujQhwOdjSfFJ9TLZOtV3anlkTKPHxpdmHBBnpU/Nc5IzvrMbmtsnymDe3gTLJloZCDwmvqMTGOHViqO+tkh0fYB53e3auBlVWnaMuzq489AzLoZsdynUePBV7cHxCldXKJ6KFtCc20Cysyv2aRM5I52JOAoQtfsT2SlfbfjSwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Fri, 25 Nov
 2022 21:03:07 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::5eeb:3e6f:7509:b20b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::5eeb:3e6f:7509:b20b%12]) with mapi id 15.20.5857.019; Fri, 25 Nov
 2022 21:03:06 +0000
Message-ID: <575b89e1-7960-170f-4a50-89f030f19c52@amd.com>
Date: Fri, 25 Nov 2022 16:03:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
 <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
 <5319277f-5841-4051-2684-93b3a985197a@amd.com>
 <fc5238a2-b30d-579e-ec7d-3686238f8b12@amd.com>
 <52eed51e-e234-aa36-3d74-3a4f39bb1dad@amd.com>
 <22425c61-9a95-a650-d113-396aa35e52cc@gmail.com>
 <856f03cb-a226-1525-bccb-79bab4c6f6df@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <856f03cb-a226-1525-bccb-79bab4c6f6df@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:610:e5::22) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be39958-23d3-4250-cdbc-08dacf28734f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/cX8uxM/YePLVry/X26xS24AE/9jtNYBYmgzw94R10fB2Y3VSQ/mNUQFZoAXfxm/dgvEHheNkMTchDUQ45P/vN0ZsMdNDpL1+KF4zBzXnWBeCI9wQpLSiDlXeHDMwoN7wvO9GEvmNFbaFEY+Bef/EXEwF3RmYcf7T5XYE+uval0M0sUZwVFmSUeHKat8N9B7XMl254tp8chqYv69ONnFa0KSWwiQhNaGRpjUTelyNqR++yHY6+omYMGGEIC8V3GM73GUyVXlREVI8/+pfVeQQ4bzSlGPm2NzSbMTaf9Q7awsOHCSMFDeNHBLpfLLbxHT+XJgxZ3aZzcRaOn+loeVKEnK7I1E1nGdvK20eNYs76xOZmlcLbsDzbj0trr99LnW6+qaPf0RPgS/7RFBrEbzjNKxgWspZQnxAkizXUeFOKu+hZ/oO9WwO6ECicMqP1iXywK0HFK0qljqnRYFTZXrO9NYgYN4NvfN4xcZVa0/xYhbg+6dCAbcMN0773p9mRur7FkJcvRVdXYIU8I0fkNYNuPlBBC2pxP6wd1YFkRX8tXkejrs8Uf2XKqZzDHSShrElcbOOUAhbfD0TT9Bew1raSHhohPlb+wcRjyFcHS3wQGE0lY+tYaKvnwcTHxFwClnj1H4+hXcsgKm/2TsNSaX8zWFbxAxgQMW3dnA1NW6cZW322orfAQksmJHD4GRj8gAmtTxABjlJFTkaGfYe2NKq+yaHd+qWrVvmQ1z4sfc4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(4326008)(38100700002)(66476007)(83380400001)(36756003)(66556008)(5660300002)(66946007)(4001150100001)(31696002)(41300700001)(2906002)(36916002)(8936002)(6486002)(478600001)(31686004)(8676002)(54906003)(110136005)(186003)(2616005)(53546011)(316002)(66574015)(26005)(6506007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVhma0R2eGV0WFV4dnRITzNCdDZFSHJqY2pnM3h0bnlGZFNmV2tVMSt4RW8z?=
 =?utf-8?B?VWQ4UDRXdDhCUHlBTFFxcDFoRlQrRThEQlp6V25PcjB2SGZrQnpyRGFXaFEr?=
 =?utf-8?B?RFA3YnBmbWJmSm45ejRNcGlwQThzRTdXU2NnMGEvRnJtNTM1ZnJUK0l6aTBP?=
 =?utf-8?B?bTNwZWkwb3lRd1RhT29mK0UyR3haa2V4SVBOTzcyU09wcEoySUUwQ0JSSlR0?=
 =?utf-8?B?OEtxeWdEdGVMUWRHZHF1aVZxQ0p3YmovbHY1c0lQbDNsUm9PMEE2MHlaWHVT?=
 =?utf-8?B?SVpRZlVUOUhIc0o5VithMXI2aHBwWitIM1dwcGJIZVpSKzZhQkdxeW5nTlc4?=
 =?utf-8?B?T01MSTkxUE9lODhlMmwzWFduSVZaNzFnaE1mZW1OQ0NKWDVScUcyZVEzQlRX?=
 =?utf-8?B?Q0lrYlJzc0RsT2c2WHRIMTF5NThvL2F5cHBBUlJMQm00UVd4blA2dW9kQjla?=
 =?utf-8?B?VWorMGIrenVJVGpwemlIbjdGM2xJRTdRTzFJK3VlNHBlaSswSitBUHVlM0hC?=
 =?utf-8?B?S3ptNEs1Q3FtVitLUFdUR3kzWFhaYlNOWU9PeGNlcGxsSyt5aHRHWEhXNVdp?=
 =?utf-8?B?eUxDKzhJMEhxS0lvb2p4R2pxQUdzMFhVa1RBVmlKWnZxK2kvSUFXT1RUVUhn?=
 =?utf-8?B?cmhJUnhsdXQ5NmdBVVU2VGNrclB6eGpEdU5OUXNXbnlRZTBQek1yOW02SEtp?=
 =?utf-8?B?cDRHMmNjeDhtbHNrTGZJYUxUZEc3aWlqdktaa1JjaWd5ZnNpcDkya1JtdkFQ?=
 =?utf-8?B?VzJvZWl6RW5OaHFzZUtINVYzYUVDLzlka0swaHg2alpyYW1LdTF0WUNXemU2?=
 =?utf-8?B?c3p6V0hGNW1oVmcvajdxMm9CT01iVHNrQVk0YjdtZUFxLzVtbEhaajI2cmRa?=
 =?utf-8?B?dWJIM1hsZjgzM2J1dm1pdUs0ZzlLZXZBTDdLSllKc2RyV1NnRDVaWVJjM0dk?=
 =?utf-8?B?ZjUxQmxEdDg2Sjd5NXlCcHBIc3JablcwYXJCV21oei9PWGpiMjVYUUNDbHhS?=
 =?utf-8?B?OUZBN0pwa3lOd2luVklZdFR4dkJrcjVabUdOaWd4akdzNGpTZVUwQ3VJVW5D?=
 =?utf-8?B?WkJHWDBoRUZwOUhmbmJINnlqUHJHYjc1N3M5Rm5obmdWUW1qcFBTcDY0SXNY?=
 =?utf-8?B?WUoyUFdlS0wvUHVKWG5RVDdYdVJ3cnRrOWlZV0tsbjdPcXVMNkJOVU1Nd042?=
 =?utf-8?B?Wnd0alVYMHNiVDIydEJoYjdKZWRWOXVFbFd6SFkzUlkxbU1lcGxuMTZXUDli?=
 =?utf-8?B?cTNoN0ltK3ZrQmE0aHdtaFg4UDUyOXhOV1BlYzFlNDByN1BNOTFWT0k5VGts?=
 =?utf-8?B?MmVhaXJ4SklTamVWQXVSQWJJTUIxVUZNTjdpekc0dEt3OWNJbkMxN2d5em1C?=
 =?utf-8?B?STArLzFYYU9hWmpSRDRuN1EzNGwrN1gxVkVXQ2kwMzdaS0ZBM1FrRWlRZk11?=
 =?utf-8?B?bXlSeUtZN3FRWm0vQU1QcEhwK3dmV0pDMktSME9TM0lTR0pxeTFPc0YraVds?=
 =?utf-8?B?RHRjOHZIK0R6dWU0WlZkeGU5R0ZJVjVORFAyUlJWTGs5N2d0WWFKeGZjeVpj?=
 =?utf-8?B?WC9IMFBsdVZEUzJsMTVGU0N1WnBzQW05eU55UUxKckhLU0lRMmU0Q2dMYXRZ?=
 =?utf-8?B?ZFdFczJ4MUtuUFQvbXpsMmFBTmhjU0xUdHpSNHlGSStEZDhiYm83bFM2QVQr?=
 =?utf-8?B?Z0FOUEs5bXJ5ejVrK2djeXN3WldkUWxYVGF2RzNqaXZnRFNFQXNUb1Zyc3A5?=
 =?utf-8?B?U055a1VJb25ibTVXcXRBVDQ0ZWhBbkY0UWl2b3lBd1E5OHI5SnlNelNmTGlE?=
 =?utf-8?B?TmxRd2d1SFh3VTF0c05zeHdKOFYxSmxTTEUxbG1ybWJIQkt2c0pGNHhheUtE?=
 =?utf-8?B?aUV3aEdsNTF0R0hERnZKaWcxZG13R211ZlR4RkMreFc4WU5MNTAvOWRHRFQy?=
 =?utf-8?B?bDF2VGNVSU9SVnBCdTlEKzlCMHlpdTkvTWIyT01la0RiR09JVU9DcXBQMWo3?=
 =?utf-8?B?aWp3NjEwMlprNnhLeGRJM25LRGtsbTAwanlxQmJoTW54M09KTkIrcWZ0TUoy?=
 =?utf-8?B?bGlLSHpJTFdRUnljM2VrYk1vRE1oaXcxcnpkWUo2NW42SzhnM1Z4RlpDQkZG?=
 =?utf-8?Q?X42VNXsstX5/+Aj25i4hD+WY+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be39958-23d3-4250-cdbc-08dacf28734f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 21:03:06.8785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tK1dCKNhQcxcj59FdnWlIKpk5wpDzHtgsZdsJwEOw1NX/aKqQU+JvEzQIvxqcLkP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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


On 2022-11-25 14:42, Luben Tuikov wrote:
> On 2022-11-25 04:57, Christian König wrote:
>>
>> Am 25.11.22 um 09:33 schrieb Luben Tuikov:
>>> On 2022-11-25 02:59, Christian König wrote:
>>>> Am 25.11.22 um 08:56 schrieb Luben Tuikov:
>>>>> On 2022-11-25 02:45, Christian König wrote:
>>>>>> Am 24.11.22 um 22:19 schrieb Luben Tuikov:
>>>>>>> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>>>>>>>
>>>>>>> Cc: James Zhu <James.Zhu@amd.com>
>>>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
>>>>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>>>>>>>      1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>>> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>>> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>>>>      	hmm_range->dev_private_owner = owner;
>>>>>>>      
>>>>>>>      	do {
>>>>>>> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>>>>>> +		hmm_range->end = min_t(typeof(hmm_range->end),
>>>>>>> +				       hmm_range->start + MAX_WALK_BYTE,
>>>>>>> +				       end);
>>>>>> Since end is a local variable I would strongly prefer to just have it
>>>>>> use the correct type for it.
>>>>>>
>>>>>> Otherwise we might end up using something which doesn't work on all
>>>>>> architectures.
>>>>> They all appear to be "unsigned long". I thought, since we assign to
>>>>> hmm_range->end, we use that type.
>>>> Mhm, then why does the compiler complain here?
>>> Right... so MAX_WALK_BYTE is 2^36 ULL (diabolically defined as 64ULL<<30 :-) ),
>>> and this is why the minmax check complains.
>>>
>>> So, since the left-hand expression is unsigned long,
>>> i.e.,
>>> 	hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>> is,
>>> 	unsigned long = min(unsigned long long, unsigned long);
>>> The compiler complains.
>>>
>>> I'd really prefer MAX_WALK_BYTE be less than or equal to ULONG_MAX,
>> That's not only a preference, but a must have. Otherwise the code maybe
>> won't work as expected on 32bit architectures.
> Well, I don't know what to change MAX_WALK_BYTE to, and given the suggestion
> below to change to min_t(u64, ...), I wonder if messing with MAX_WALK_BYTE
> even matters--it wouldn't matter so long as the type in min_t() is u64.
> It's a macro at the moment.
>
> However, the LHS--struct hmm_range's members are all
> unsigned long and then we're essentially doing (unsigned long) = (u64),
> which on 32-bit is (u32) = (u64).
[JZ]MAX_WALK_BYTE can be reduce to #define MAX_WALK_BYTE (2UL<<30)
>
> Regards,
> Luben
>
>>> and be defined as <literal>UL. I mean, why is everything in struct hmm_range
>>> "unsigned long", but we set a high limit of 10_0000_0000h for an end, and
>>> compare it to "end" to find the smaller? If our "end" could potentially
>>> be 10_0000_0000h then shouldn't the members in struct hmm_range be
>>> unsigned long long as well?
>> No, that the hmm range depends on the address space bits of the CPU is
>> perfectly correct. Essentially this is just an userspace address range.
>>
>> Our problem here is that this code needs to work on both 32bit and 64bit
>> systems. And on a 32bit system limiting the types wouldn't work
>> correctly as far as I can see.
>>
>> So the compiler is complaining for rather good reasons and by using
>> "min_t(UL" we just hide that instead of fixing the problem.
>>
>> I suggest to use "min_t(u64" instead. An intelligent compiler should
>> even be capable of optimizing this away by looking at the input types on
>> 32bit archs.
>>
>>> And for the timeout, we have the (now) obvious,
>>>
>>> 	timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL);
>>>
>>> and I don't know why we necessarily need a "1ULL", when 1UL would do just fine,
>>> and then compilation passes for that statement. I can set this to 1UL, instead
>>> of using max_t().
>> I think just changing this to 1UL should be sufficient.
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Luben
>>>
>>>
>>>> As far as I can see "unsigned long" is correct here, but if we somehow
>>>> have a typecast then something is not working as expected.
>>>>
>>>> Is MAX_WALK_BYTE maybe of signed type?
>>>>
>>>>> Would you prefer at the top of the function to define "timeout" and "end" as,
>>>>> 	typeof(hmm_range->end) end, timeout;
>>>> Well for end that might make sense, but timeout is independent of the
>>>> hmm range.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Luben
>>>>>
