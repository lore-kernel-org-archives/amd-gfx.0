Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3761C5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 14:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DA210F00B;
	Fri,  1 Mar 2024 14:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aGukIYkw";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2AC10F00B
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 14:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPA+pMyAaYdSgE+ohtpo1o5FY5JCOoRqnQqW7I7gToon1u+CKf3Q3E64BqCC2k0vfkxOvFjyNI7Rim478B7C3A7l7zoGDAIvwwFKoF8i1a+640aDj98C4Y523hg/7FIfypm3NR5fhSQp8PQskKkPQlwQ38AcYcUrhwTTmLBtR++mlIfiz1q/uHa+2Ri6HHOQ3VrIoqK6ptb8kNW3edEB76Lt9dt56MyvTqaQXHtS3RPMqdUCvsf924DxJzoPIO/XNmqIFPB8LZ3hG3GuZh83nTAcpdpz6jB1yLyRBiqAdshuCpLT6gT55v5uopFlGwKJFreWEwt0XNzlgAVAfnvCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+n2SCg/M52RvNrVq/XziDmy/ybw59YsgMx+TwCO6SY=;
 b=c1TX6T8dUJ9i1KZDxsn5qV2ngK4bhXs4nxmJvaO3fn4xyijqyrod3epgounHS9dDLwifCw3Fdwip+ZCYYSH8d0cX091kD3yS3aU9sud0Jj2zgH5aHwOzoZK505EpK+EuCQWJC6a1BekTgeOMYDUSI7wx5X3pcvwrVlGXt0v9UfiDV1pXfMxY0P5FT8zL28RlP5kQOa65n6sXCkn75pIrqDnnYc8wvz344aVJGiGa8dPALYWgf2G+Po33b0qFMPDTclA1+Ywx6QC2HvtsJwCeSErsMLIj0RkzpeluhhdbAAjpWH7O7oL+QU07IVRmPiaWRY8IX0d+XZ9DaHWNY0Ec9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+n2SCg/M52RvNrVq/XziDmy/ybw59YsgMx+TwCO6SY=;
 b=aGukIYkwCC0AaWMHiNPybqOqir23juR2aoCXStJZ2hPhMNT8QJDC7FQJbU90EY/+eiNV1SYG/jo8Qlv1S8V5v72R1U8KP1RQXgJ6Ln4WM1/adluqHwyv5VqCk6DVBTEuaM4BdwHtqIHiHutdX6opQoi/QqgeQTcr30O92EgyRIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Fri, 1 Mar
 2024 14:22:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 14:22:50 +0000
Message-ID: <602e8183-9be3-49d8-bd84-01093243885f@amd.com>
Date: Fri, 1 Mar 2024 15:22:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix potential Spectre vulnerability in
 amdgpu_gfx_parse_disable_cu()
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Nicolai_H=C3=A4hnle?=
 <nicolai.haehnle@amd.com>
References: <20240301124551.4038626-1-srinivasan.shanmugam@amd.com>
 <cde9a11d-85d3-4b27-9237-452a6e2fd24b@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cde9a11d-85d3-4b27-9237-452a6e2fd24b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 139f9e3c-a6bb-44be-a04b-08dc39fb136e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G32bj4d0POrfyqpZ/nw0iOMGTQvzWwhwVUubwuRvOcqBr4r4g2lXWPGl4PZ3/RkDI2HrGhJmItUg8n/cCdvjPEqjfSaAR3qNtN9300F4ImTBMnBA3Vrh/3Vb7CqyKTuMSSWKZDcp8MwE4NTLUBr4giKF6PPYoVzskGAxdpHe33h9fgwDieoTM4C7PZkvqH8pCwdRrzpjMGoAQ6i4xykdWMuzUZeC0u1kGQzL1VRbU7w/uS2lMZ/QtC6hTC244+c98qoH0l+RrMMF105AhzoFV1ln9nqUl6cAI05+968keknGE4mD7bYaQE3S/3AygoRfwwUEdkXnvWfWD7GyuVKC9xn32EmQid10EC6ISCyUS4qVBTV/eP7C3TiD7ur4VS4n1PAqKMnFzWRBPpDom8ewPr28R+pM2zvjsjR3/QwtMcuYMDNP3e/6RttYx2DRguDCjxHPxV41F9VjBCW+tYxvb7aqHi3t12EXlaPOwIrm8P8jSvw8QMoK9iu7f3EefBx2f4u1BSbDZf8qt+EK9gMv4aFXXMzq8MkrBaowue0jK4yOCA0fcLVHq736XW1zmrU9aJPPNkGi3xSUXf7dLlgFbLk3oyEdEHRPfJKW+6oNPaZycBhVI86les5gvdTsGLzldlYy97IXVqBt58bAVIuoEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFFSOWpJbXBka1ZwU2NPOGFZSEdtRTVjeHdJOU9rY1pWam5BUXN0YlNoSXRJ?=
 =?utf-8?B?L1FndTIwMEQzR0p0U2FhRjFMS0RZcWFud1BjWDdqOXRxYy9mdmoyaTFZMDdJ?=
 =?utf-8?B?SkQzRjZPb0pOSDBtUFlkclFxQ0ZsT2pZejY0VVpGYjU0cms0RDhGT0dRRTJY?=
 =?utf-8?B?ZDJQdHhvMERoeUdGUUNhTHpnUm9vMzcvc0dwdWlRWlE2andQckZQYlNublZR?=
 =?utf-8?B?WFlyK3dScS9Na3lrTlhLVndvTlJzNk9rdUpkYUE4QnBQSXgxUDNsT1BMVjRE?=
 =?utf-8?B?Y294U1RBLzdVdmZoendzV2N0UWI5TlAyL0lrUk4rR053T0tVb0VheTQwdHVS?=
 =?utf-8?B?QmNhQXdhK0NMb1ZhQUFoTnhyZ0gwYkJod2hSeldoTWNRdmY2cEs4SFVtNzVo?=
 =?utf-8?B?c1NURW8vREE1UU1IU0Nqd0hnYmZrU0grdzU2N3lzTkFreUJDUnMraWF6TWdW?=
 =?utf-8?B?VXZPOVpoMnRGTStSb240VWxXbnNOZDlhZHhobm9TKy94dll0QXIrUHozc0R5?=
 =?utf-8?B?emZ2TklJQStEcUFoYmR4d1l0U3AxNHFja2g2RjdieFVqZkVaVFVTMis0SWkx?=
 =?utf-8?B?MjRiMjRHNmY3dlFjbFZ1MWlVWGZGZHNJTlhkTjNpOGVtUkxZWExTTnBkK0lr?=
 =?utf-8?B?MzRPZGtsd0QyaUo3bTRscTY5YlU1bndaakpaUnhQdC81aStqOGlyNys0cmx4?=
 =?utf-8?B?cWlEaTdwMmM5VzBUNjBpSThwS3hCbFlWRmFzbExQTFVVdmg2STA1ZnJhUnlH?=
 =?utf-8?B?WjdSeE1ZbDBvN0lqeXJ2Y2Z0bFY2dUVMR2pNRzh2cllvY0kvbmxsSEE4ay9z?=
 =?utf-8?B?bjI2elllMUsyeFNBYkRPV2IvK1JEVnlkZzZHSG1FVitwZmxHeHpuTHpWU09k?=
 =?utf-8?B?N05PTXp6YmRYOU5RVWZDV0dKMndEVHRWZldPaVh3SU5KVWlJd3JRZ2twWW0y?=
 =?utf-8?B?WFlqYTRSb2JXZ2N2NlJydVIzYkxiTmc1bjM2dzVkK0pXV2pIQTc2NnJ4Sk51?=
 =?utf-8?B?OE5ZdHRJOFhyMEZac3JJZldqT0dzanNYNUFocUlXQndmTStDemNjNmh4ZHVG?=
 =?utf-8?B?Vm5pNmNZck5TVC8vTGp2bUJheVRMdHA3OUh6eEVKSVE2WHRNZ3duWlhpUjZH?=
 =?utf-8?B?enZJY2tuWEhHQVdJeFpRYmkyYkp5bVVaUFFEeDR2dWxPbVJtWlA4WmFMNlVK?=
 =?utf-8?B?TU5ZdThWUDVQVHp2MWdSVXN0Z25EQ0Z4ck56USt2Z0JEZEVvem9BQXBYUFM3?=
 =?utf-8?B?R1pNeDlyaWpvZVdjaTZUNisraVhlcnBxYWJydkR6TjlCSEhIZHY4Qi9oYlVs?=
 =?utf-8?B?NUFuNUU1YTk0Y2FnbGI5UytsQTF2bFVTNnpHT2hCMlBjOENHSHowTTF0SlBR?=
 =?utf-8?B?Qm9IWG43T3liWUJQMUZPa0tHRFhsN1V6L0Nhd0dKUG1CdHp1UkpFTzJHRzFS?=
 =?utf-8?B?UjRnTkoyaUdYRmpjSFlLbnUzWEJxcmVjYUxaZW9DSk1XVnZ3Zm9VRFdmZ0xV?=
 =?utf-8?B?eXhrNHZ1alFyZTNUMmYrejFxNzVtT2t0ZjBVOTJCajRJT2NGQjdLZ2lHZGVP?=
 =?utf-8?B?dkJOYy8veUtiVVNOb2NVekliRnhydUxrVW5rZkEvZVZRWElOd1h1MEg5UmdZ?=
 =?utf-8?B?bUFsbXVtdUM4UlNGYWEreXpFN21KRS9kdzZQZGRNSlZXU2pFZWlHUjh6bHlN?=
 =?utf-8?B?RU1DQWk4aUxCeVRPK0JCaEs3bENDb2VSWVpBQW92b2dtYlNwS1BpN3FrcUhM?=
 =?utf-8?B?V3ZiQVI1Vk5XTHd3Z2tSMlk3NldhejdzZVE3RFJlN2hXTG9PR0M1QnNHek1v?=
 =?utf-8?B?b3V6eld0QW9zUTdUVUgraTJqTjNNMzNYMXJkVlBnOGd5TmRWVmpmQ1NUaEJr?=
 =?utf-8?B?SkNMWEdwTnl2YXU0RkI0by92dHNxUGhQaWZWanJOMk05T2QvZHBRTEhaMkVM?=
 =?utf-8?B?ekN6WXBKTVRGWEdaNFRYaEw2OFVYWDA4Sy9PRzZsY0lHb0xma3B4ZFpUdnZS?=
 =?utf-8?B?YlRnTExDendzcWVNNFU0MG1iNFZhRU9Sc0JDajZoN1JPdi9Tazl3UmUvT3lV?=
 =?utf-8?B?ZUZFZUtuV2lhRXF6UzQ5K3pjQi9ndDFPWGcvM3NFQTVKbnQ5NktUbGhqOXA2?=
 =?utf-8?Q?JjV7jBGd0g056+RqI8pAJQjrY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139f9e3c-a6bb-44be-a04b-08dc39fb136e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:22:50.7848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbTVJ7cVYc8zSeaaFJU/guQIYc4o3HzxFaukYkk8ERMZdLrl3Mqq4EA/KD1ohoF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
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

Am 01.03.24 um 15:01 schrieb Lazar, Lijo:
> On 3/1/2024 6:15 PM, Srinivasan Shanmugam wrote:
>> The 'mask' array could be used in a way that would make the code
>> vulnerable to a Spectre attack. The issue is likely related to the fact
>> that the 'mask' array is being indexed using values that are derived
>> from user input (the 'se' and 'sh' variables), which could potentially
>> be manipulated by an attacker.
>>
>> The array_index_nospec() function is typically used in these situations
>> where an array index is derived from user input or other untrusted data.
>> By sanitizing the index, it helps to ensure that even if an attacker can
>> influence the index, they cannot use this to read sensitive data from
>> other parts of the array or memory.
>>
>> The array indices are now sanitized using the array_index_nospec()
>> function, which ensures that the index cannot be greater than the size
>> of the array, helping to mitigate Spectre attacks.
>>
>> The array_index_nospec() function, takes two parameters: the array index
>> and the maximum size of the array. It ensures that the array index is
>> within the bounds of the array, i.e., it is less than the maximum size
>> of the array.
>>
>> If the array index is within bounds, the function returns the index. If
>> the index is out of bounds, the function returns a safe index (usually
>> 0) instead. This prevents out-of-bounds reads that could potentially be
>> exploited in a speculative execution attack.
>>
>> Reported by smatch:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:136 amdgpu_gfx_parse_disable_cu() warn: potential spectre issue 'mask' [w]
>>
>> Fixes: 6f8941a23088 ("drm/amdgpu: add disable_cu parameter")
>> Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 4835d6d899e7..2ef31dbdbc3d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -24,6 +24,7 @@
>>    */
>>   
>>   #include <linux/firmware.h>
>> +#include <linux/nospec.h>
>>   #include "amdgpu.h"
>>   #include "amdgpu_gfx.h"
>>   #include "amdgpu_rlc.h"
>> @@ -132,8 +133,9 @@ void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsign
>>   		}
>>   
>>   		if (se < max_se && sh < max_sh && cu < 16) {
> This check is already there which is equivalent to a case like -
>
> int arr[A][B], then check if (i < A && j < B) before accessing arr[i][j].
>
> I think smatch is missing this.

The problem with spectre is that those checks can run speculative and 
you can still get parts of the data by looking at cache behavior and 
timings after it returned from kernel space with an error message.

That's why you need the explicit call to array_index_nospec() to avoid 
security holes from that.

Regards,
Christian.

>
> Thanks,
> Lijo
>> +			unsigned int index = array_index_nospec(se * max_sh + sh, max_se * max_sh);
>>   			DRM_INFO("amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
>> -			mask[se * max_sh + sh] |= 1u << cu;
>> +			mask[index] |= 1u << cu;
>>   		} else {
>>   			DRM_ERROR("amdgpu: disable_cu %u.%u.%u is out of range\n",
>>   				  se, sh, cu);

