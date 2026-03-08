Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2C4F5512F
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2026 06:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0146810E0B7;
	Sun,  8 Mar 2026 06:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QJLDOXJk";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2504C10E062
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2026 06:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgcUjbp7Bkt+Mo/rSlxfS5M5iGDABc6RiQr8jLv59P1Jq9+zEo2favt0giJH/FZdRrgw/UQhcMZ33k+Wn/bv6MOpCSg4JROuFci6lPy4G/FLmErRJebGDnYgoU7eTIHAMJ+gSlMls8D/TIcnhwsZQ2Or4dskBKS8dnFuic11JYFg1MCRaJdhoCrUg2GpXA5A2/NoqVoqooW84uPLsNJ9/LEnWa1eioSdOviiuD67KZLFiB52jdTNgndpj4KiCxEhAuMLLDJ+roHVUZdmKYv9EdcYIf3gnnTvSpR1Vblb5H28+zASARMo/b6Vck51/BG7BvRnWgmKDG240JC7yQSYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DorQ2skH7o2rzYg/cpqZB8PZp6sqOl7A5K+bQisojEA=;
 b=QMoAs4fN33wDtkblvz6PATFm6aLf4yK8O4lP2qdwtX65/7LX7DGwBMMxT6VEFEQsr6gqmZIYdrsb1tRpJEKGmat6GW2Dnqw4h8AbZX+dIiSb99XLS1lzDXFSPN5ZPTWI3n7QutjPcsMiIAOvIomWLdKSPpkDQPaR3v7nHvWGcUX/oyL/45gLDiHb0nCgV6h2abWI8XadHsIszUdo+Ps3CpvWn6/Zt4OeJobE/7sIeFnSZmNRb+taG5wr6Hhza+MFquDREBP24PQsdvrLa4HA151LXcvSGP9p0fOkEMh9kuHibbT0/VHNs9TVkT9duYSjDbeBTq5Dzu6I2VqQGrjMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DorQ2skH7o2rzYg/cpqZB8PZp6sqOl7A5K+bQisojEA=;
 b=QJLDOXJkPcBx5FlWYr4tNsw0o6hkvnuseT9dNVEWm9hAEq5Z3GroTaUUPt0TEW9K0iAaURaph5WZMN5EA4SRtaAIqZwrJyOUiaVREcOvQHKjAaw3UlvV+qBVDvxWah6K47Att7/tj5hMzadMYtlmUYxxcicHUBXIAwY7F51ruHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 06:11:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 06:11:13 +0000
Message-ID: <92d5f227-2e94-4b3f-a910-124131074ad8@amd.com>
Date: Sun, 8 Mar 2026 11:41:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd: Fix more cases of NULL pointer deref at fini
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260305220540.1354776-1-mario.limonciello@amd.com>
 <7305e3af-1960-4612-9dc5-fbf718b7fb7d@amd.com>
 <1decb90d-1b7a-450e-b846-d3dbabfd81f2@amd.com>
 <6ce53965-3e67-4164-979e-259e6b57a379@amd.com>
 <cf184113-6db5-455b-87a0-85af727ea377@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <cf184113-6db5-455b-87a0-85af727ea377@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::23) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cf26da-32ab-418e-3ef2-08de7cd9802e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: SQJRZxBXV5JqnAV98uVrMjHqL0z8jpoJ0fJGmN/lx/8bJVOwKZ8mNYeVucIitAxFqQo2UtNfkUWV3tVEHs+fpqZdTwTX6G0HFooJWmypIGzCf+BsFNfwJSdRM4UYhPT3yLR8KK/M4BPk6Rt0VzSM0oNWtS4ZHFQ5e2lPKcbGDhjzp8BWEUJuVVwAPXPRthKBKl5pPvW9edC/YG+jox3QyBT+xXAmAF1UGGB9tugZ6Y3wwSbXbAXO3OWRgOJda4OG5ucxw+iwAvRVk2NOufXPaiF77HpB2zOvvExFerPfm0rAmeKdugjoG238oVeIC6SkvgK8zLYnwPByX6W+/0jCbpYM9J+6lOXyObzd2GwHm5oMWWscN1nVzsSFaigQHwCGd84YStBT2uZpEAmAD6dKgwwgS/ak3IYVlC5U7sOFSxHibFWV2Q13lYlRLGNHkLZ7JoRz6TEZJXyw5mo9HVQ7GDl3RjxdYOy589IWT8yJASeswOs97AV9atKnRGbMewsmVorCiAmzc5Y5X70P++kl21+N5Ba9lvBN+sOwwUslIuNL/0nauVyA+iQ0V92UNMaBADNIn9fN309pmmEN6AEy2YO3eU7Hh5XedrJvog4ciA/fy60lW6YP+qOExio2my0DJUtmIzKTL2zWTtrzDZ4zXy4XItnPqdkKh7I8Mre7iDjHiMg8Vgv4ZM8ZA+u3TXSRdiGALlmN5MD2Xb7kR3/6UJg+7EjdnL42V0nKXjlj9os=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFZ6T2ZZU2NYZjlsRWpyakpXZ0g2M25mVjI1RExtNXh4S2VZaUM5RVhOSEdk?=
 =?utf-8?B?VXNkcFZCbkJZclJLWWF3N240WnVHQWZwbjlSQnpCMmxuYW94R2U4aVBxeTRL?=
 =?utf-8?B?Y1BWZW5BemNzQit5SGltblRyNDVBSkMzRGp5OW03d2JBOVFFbmpTMjVZZTJ1?=
 =?utf-8?B?bDc3MHh3amUxYzdXWHdma0t4SlhSSmtnNzE4ajdjLzE3R3JVS2JIVzBmZm1C?=
 =?utf-8?B?RjR0OGRiakVQeHdPTDhSZDhlSVNVNXJKMmNNa3lvL0RuYTZVZ1FzL3B5RDFR?=
 =?utf-8?B?aFdoUjdjaFhTcnNzdkI1RGRNaVF1cmtMaEcxVGhRSGkrMDR1WlBIUGxjNjhX?=
 =?utf-8?B?ZG4rQjdvY09KM1JJcytCb3BVQmFVQTF6aXlkazcwcGtrNU5NdDVsUmkzcExh?=
 =?utf-8?B?M0dsSGFwV29VdTA1aUUrTitnL1BUcC9Id1NoQU9vWHE5ZGQ1NE9Ca0x0N0c1?=
 =?utf-8?B?dzJXcUFQWVVoNzNGdHltbDkvWE5yREdOMTgyNVpvMGNjd0pBcVo5MC8xUzdn?=
 =?utf-8?B?ZVhhd29CRzhYYjYvY2Z0dVBFdTRlSnAvc0FGWHVkemZ3UXg4c05FRjhZbzR3?=
 =?utf-8?B?Vm83S1ViVFVUcGVjc09qZUh2RmdDRXVXUjVMVkgwMkdGeTl5ZnpkRzZ3NHpa?=
 =?utf-8?B?cGFOdmVDMm1jeklGN3RkbGlYdnliRittSFI3dTlkS2lnSS9QTG1udklsS2VF?=
 =?utf-8?B?elVSYnYwT0Q3QUNSbTk2NEMvZFhuNXRIUkczTzd5WU9NUUUxdTBrVmhCZWVT?=
 =?utf-8?B?dEI3YUlVd3htRkRIZTBSVlVXckxnQVJHMStsVklKRjdYVTRnbmJ3amc5MHp5?=
 =?utf-8?B?RldhdUU3Lzh2aFdBc0hhRDZtSTZxb0paWDZjU1hyM1diT0l1cmtRYmtpaVRE?=
 =?utf-8?B?U2c3MmNPU3BOazBkVnpvdWptNDMwbDRLR2JzR3dUQ092eVBCOUlIUWVFaTI2?=
 =?utf-8?B?UVc3N2JEOTdZRnRjeFhIbHpLalQ2SlhiRWVSTjN2VVp0OXZ0QnRVVStna0xN?=
 =?utf-8?B?V3ZrTGNkcG96RTZyWHVFZmdQa2x1SmpzWUJ0NmdMOGZieHVrLzVYcXcvK1pB?=
 =?utf-8?B?cnJ4K0t1dDBOWE9zR2duanJUeFRObHMxSHdVSU5OeGFHMFdLUWFZSkxjN2NR?=
 =?utf-8?B?WEtHeXVXcThoYmFmQzN6L3RQT3FLV0lsdnZnbmk4Q2U3dGxnUkRzb0YzMmhF?=
 =?utf-8?B?RVhMN2RYRTJHYXc2S3Y0SzlueGp6andCd3h4anRuSVo4UVc2ZVgvc0tHUms5?=
 =?utf-8?B?MmZsL3RoWjFPRUJFRzB5UThCaHRXb2lGb3pmRkpEbTRjMlp6aFRIbUJvMXFy?=
 =?utf-8?B?aXNFYW1ROWo4NUpiVGxCUUpFZEFmUVZUd0R6VEg3cExacWZPN1U0Tzl0cUR1?=
 =?utf-8?B?MHBEN3d6UzRJWFh5cWwxL1k2Y0FNNzZONUVxZHdpY2Z4RHB6QW1zajNpeXgz?=
 =?utf-8?B?dTlvQUlXMW41dFE3dklCRXpabUpFQ2ZuVGxuMFVlTzBMVHA1a3JIdlozZXpG?=
 =?utf-8?B?U0wyQlJBa2E0Um5Ob0VuRHZHR2gvZDBQaUk2c0VPeDl0T25pS1lQRTkxalB6?=
 =?utf-8?B?R095cldoTjNxYWk4cWRCcG45K0FRMldMUXM4eWFaNlhhUG5KZzd2NDRrWnNI?=
 =?utf-8?B?Yi9sSEtYZDVBd3Q5U09KbEYrblQ3WnVCMjJRejZZOFNHeHYzL0NsbTNWRDN3?=
 =?utf-8?B?SURUSW1pb1M4b1Z4UldGV1l5WHRqaS9DWFF5clVMTHlKSlNaTVZrZkpsNU9x?=
 =?utf-8?B?ZDNsaW9ZYUhTWStHYnlydzNISGdUNmxSSldVd3ZYZUtsMkFzdnpPdTlmak5k?=
 =?utf-8?B?MUtySGZHTTl1OFdhbjR4emlqMWxtQU1XUWVRTWJqZHZLRU5TRWcvalU4NS8v?=
 =?utf-8?B?V2hVSWVkcFpGL1ZhVXlaUU1aVnhkVGZ6c29iVG5UVW95NGd0NnQwaG1NdDFa?=
 =?utf-8?B?clhkOEEyb0ExRC80a0FGL1R4d0kxUWRNZ0JReXUxN3I4Z1NVMFpZNlFtQ1A2?=
 =?utf-8?B?WTNURFJDSzVURU1pVTNaN05nL1pzakx3cjRFTTMvU1RQWHkyczhCU2xXNlJJ?=
 =?utf-8?B?aHNtMGNOTWt4cVhQYjlBSmcrYjV3QkxudmExWnBOQXRnSkJmQ2dDZUJVWno3?=
 =?utf-8?B?bUdnbW43OC9PQ1gvd0RjQitkeFZlb1BGUGMydStrYktDaTN1YVoybzJnb0Nl?=
 =?utf-8?B?bC83R3ArRkdNYUVuUVlQWnlKL2hVd3FNbGo4YmhRYVFTTjBuYWt1ZnB6UjZY?=
 =?utf-8?B?amptVGVlY25LRUZGYWNtZmRZUmN0VHU1MmZOb01DZ1Rzd2Y3OXYvUmhPNXRm?=
 =?utf-8?Q?r7H9/M3ehJOAtLwyMv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cf26da-32ab-418e-3ef2-08de7cd9802e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:11:13.7253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6HKwr50J3aXCM6yqvxr7CIC1VjjkD7z/UUAeDoU9+Mryr/f1AgayM5uK4J8NwJl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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



On 08-Mar-26 1:48 AM, Mario Limonciello wrote:
> 
> 
> On 3/6/2026 12:41 AM, Lazar, Lijo wrote:
>>
>>
>> On 06-Mar-26 11:40 AM, Mario Limonciello wrote:
>>>
>>>
>>> On 3/5/2026 11:07 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 06-Mar-26 3:35 AM, Mario Limonciello wrote:
>>>>> I found more case that a NULL version causes problems.
>>>>> Add NULL checks as applicable.
>>>>>
>>>>> Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in 
>>>>> powergated state in some paths")
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>>>> gpu/ drm/amd/amdgpu/amdgpu_device.c
>>>>> index bc6f714e8763a..74cbe58484fe2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -3463,6 +3463,9 @@ static void amdgpu_ip_block_hw_fini(struct 
>>>>> amdgpu_ip_block *ip_block)
>>>>>       struct amdgpu_device *adev = ip_block->adev;
>>>>>       int r;
>>>>> +    if (!ip_block->version)
>>>>> +        return;
>>>>> +
>>>>
>>>> ip block versions are set during discovery phase itself. This is a 
>>>> very early init failure 
>>>
>>> Yes; this case is NPI system that not all blocks are in discovery 
>>> yet. System panics at bootup with NULL ptr deref in multiple places 
>>> instead of a clean recovery and keep fbdev.  This patch series sorts 
>>> it out.
>>>
>>
>> Blocks not in discovery shouldn't be added to ip list or should be 
>> added differently.
>>
>>>> and ideally the fix should be not to call any fini for such an early 
>>>> failure.
>>>
>>> As an alternative to this series?
>>>
>>
>> Yes, if it's a failure as early as in discovery stage, probably we 
>> should skip amdgpu_device_fini_hw altogether.
> 
> I experimented some more and feel that the solution I came up with is 
> correct. There are valid versions of everything at this time (the failed 
> IP block isn't there at that time).
> 

My understanding of the situation is this is any early exit since driver 
doesn't recognize one IP block and hence cannot assign corresponding 
version functions. Without discovery mechanism, the equivalent case is 
driver not detecting the device id. In both cases, there shouldn't be 
any need to run through sw/hw fini sequences of ip block.

> So how would you know to skip fini?  I guess check asic_funcs not to be 
> NULL?
> 

One way is to undo the effect of set_ip_block within discovery itself. 
For ex: if there is discovery error, call amdgpu_ip_block_clear() or 
similar and remove any added ip blocks. num_ip_blocks will then be 0 and 
in such cases don't run through any unwind sequence (that shouldn't 
really be needed then). That is the same case if driver is not able 
detect a valid discovery binary blob also.

Thanks,
Lijo

> But then it's the same as the second commit is doing already.
> 
>>
>> Thanks,
>> Lijo
>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>       if (!ip_block->version->funcs->hw_fini) {
>>>>>           dev_err(adev->dev, "hw_fini of IP block <%s> not defined\n",
>>>>>               ip_block->version->funcs->name);
>>>>> @@ -3496,6 +3499,8 @@ static void 
>>>>> amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
>>>>>       for (i = 0; i < adev->num_ip_blocks; i++) {
>>>>>           if (!adev->ip_blocks[i].status.hw)
>>>>>               continue;
>>>>> +        if (!adev->ip_blocks[i].version)
>>>>> +            continue;
>>>>>           if (adev->ip_blocks[i].version->type == 
>>>>> AMD_IP_BLOCK_TYPE_SMC) {
>>>>>               amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
>>>>>               break;
>>>>
>>>
>>
> 

