Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30FAC54E49
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 14:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B2810F055;
	Fri,  1 Mar 2024 14:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FutBjo1h";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341B410F055
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 14:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0uGGasH+/WovocBEYaMhVXFpWLDm3wc1f4uUfuOUCyqNbV7NZewJ6G4tsR0OId2LDfBJp/JqMUyQ4uU4sMyq1r/KY9Lyz9Ca5ACHe3O1S1q6Mfy2S2Y5S8SI/tcGGMcxJvVT0e0AxcZUFjyBUoizNo5ORmNxtoO2ztppZfiA+v3+jXLW58qfdV+uGEGhDt/AQNTeC8ds3AmzfERO0+ja30PNOskoogIWmLfs1XFT02r8ObYtqha2uOglHb/t7w8ECSF5ilAEKse7tVR9CSR9MB89EtpLNv/AOYQsdZ7rIDQGk27GL8R8YhoYjCdIwQ0uBtjvkKRu7+vxh2s48XRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XMmRNu5Mq1TRlUvQMvyKmZ4K97tYm/Fk+XRYc4X/9U=;
 b=XWF/w/wbXV3IsHdcih7bmuP1J7Ee9hIVDEPKYNEegV8rEfnJd4T5OpRD/RTMPn1zUrKjKIl4l33ui5cAxa+NTxzGGe4s0D1ct9weqqkJJecI185b7eyJpTPWSSyplEX6uGBvMwOw5FRr4liKM5pB/0O0Bei4NyiL/XD5vsyv4kXQtsuFRBgpksPD6nHYtHQknBt9NGvfeUvLzWtKxB9wBsO2acGc44HEBxPerbLiAAtrNZIIElfrOBo299SQX1cOet5NXVdTwoCNkYlJnPUiMLRA8r175Vwj/tklw4dLHl0fkmE5qEu47G7oruvGutjVc9rkc2HOno6Qb4VxDw8gUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XMmRNu5Mq1TRlUvQMvyKmZ4K97tYm/Fk+XRYc4X/9U=;
 b=FutBjo1h6/WwpIobmmWMBLuLvpArcbCDtYfama35uPCZ85HaqeRY4Z3gTmcqXfiJIISA3jsDHQr0shRGZqTdvXMy0RQ+ELNoYZMoDEDd553uvJgEocKk93Yijc3gzNBQxg7hgThaIbrac51uDqENAjx5bCHVE8bK2CXKGn8jNc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 14:40:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 14:40:29 +0000
Message-ID: <a4b45e89-de6c-4ec0-b0d7-a7c255092560@amd.com>
Date: Fri, 1 Mar 2024 20:10:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix potential Spectre vulnerability in
 amdgpu_gfx_parse_disable_cu()
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Nicolai_H=C3=A4hnle?=
 <nicolai.haehnle@amd.com>
References: <20240301124551.4038626-1-srinivasan.shanmugam@amd.com>
 <cde9a11d-85d3-4b27-9237-452a6e2fd24b@amd.com>
 <602e8183-9be3-49d8-bd84-01093243885f@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <602e8183-9be3-49d8-bd84-01093243885f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ba26b6-0e9d-46b1-27bc-08dc39fd8a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZR9MPsUh7epd75xgjBQJgrAxL6If1vR3rS6FmQAxq47zefh+kvj1TlSqIKvmseTCkh6KZU9E3t4kRZsxnrwaSgWFDMpAy+p63yVTgps3rTUM14tIH8YwI8M7qH7XxbOOZQ3QjP3KLs62kbXG5xPIyaj7QdJs5vMZ0tU98G9cWGmgWI8oo5tcEUsqIOzQuCw6pwI7kcZS4AeDfo0rDmF4CXjfP5WDG0OG+2B3a5s7aS5Y+KMSQPu3iJJbMswB22//yln3dWl+ZkcK1NOOL49c+HvQZXAycc1DGa8GkK2p2XRtlMQYgQyryoRBbCVc77BN9R3jbPEU/E+I1M5bRlnq+g0t6MI5X0dbSU7tE+Hgdnx3sQOj9L/yE2w5uKWTiwukkoMn0PImOE70JtJhlm2KLrsMESTthd0oa9HtRPeY7v8pbxvP3FOkjFHp+InMxsmY60ak5qu4mAl4u27Xu53zXl/q/Rvn1kR7v/GdC0KQ99vMIotVRv4mA58vmRkLy4fiSje4FAY5X8xzSJeBwLIAyhAgUTRWgBsfd6VhyYEoA4w9hynQwEGlph4OH8Q1+rbrQKAQNHSEMWaOW4s0A4YJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9uVHdvSHhFT05oVktHNzRsZDdNWXFuMXFPYnR0VmlNNmN2UmVITUhlUk5x?=
 =?utf-8?B?MUU4OTVOeTlOQU5ON2gvSm84YXZoNTdoYm4rV3hzamFVWURYMjhmSEgwK1RG?=
 =?utf-8?B?UnJLWlp5b0g4M2ZzcGxiTmU3ckhpUUczOU9kSlBrMFlaY1h4azNBd3hWWU9E?=
 =?utf-8?B?a2IyLzZ1WTZXdmdQVHhiVU52UTdWcUR3YlNLTGpDRS9oV2JuZVFybXJ5Z3Vw?=
 =?utf-8?B?T3hQZDBScndiTng5QWR2Z1F6ekVDOWdjWXI5REo5VkNocGZqV1ZvckJ6aWF4?=
 =?utf-8?B?Z1pGYWRIeWg4TWNMcCsvZytFTWhsQjNuU0xaRzlIYmVQMFJNYVZ0cDd4Y3NE?=
 =?utf-8?B?WnJ2SkMzUlpuSndEdXR0WXBEQUpIS2Vjb0N5RjBjSHJaK0Uwd1ZmdXQrME1t?=
 =?utf-8?B?U3JKWHJqNE82QW1yb0JDQUVqZ1JqUmVPNjdWRHlLdlRIcXhSTFpDL1g0Lzkz?=
 =?utf-8?B?R2s1eHpzZkkrbnZYbmlmdDNqWTE5ZnJ4QzNoNFYrL2dBeWcwY3ljd0pWUjh4?=
 =?utf-8?B?c3cxSktTNWNyMDhaWmJtL21IVWZicjdBVm0rSitHMUI5N2ExQlFuRW15Vnlo?=
 =?utf-8?B?RkpXMzFjeUxXUWVUL0s3V2ZsRzdtSHRMeE0zMEdvNVR4aG5tOHI3S3RkaHRY?=
 =?utf-8?B?SFF4L3FxRGpKSXFpMXRXWSt6YjViUVRVUWM0L0F5UVhEait5YnQvUng2QjM5?=
 =?utf-8?B?VTY0Z3NRRllGMHc0Y1k5UEdWMWpsMGV6Y2pOZlorU3h6MENMdHlucUdVdHlu?=
 =?utf-8?B?UU9BVS9sQ2Q2VGIxTFI3OVloNUNQNFd0V1BNeTh3NDVyZmdlMUMrVXFtNzkz?=
 =?utf-8?B?RDUwOFpTcjExS0E1eHJpTmNMbTY1VHQ3UmJQZEw5TjIzRkZaY2NQMm5HVHNT?=
 =?utf-8?B?bU93MitGK1lBV3RKc0dVSlVOQS9Qa3pvaDdFUTJsQjhzbjdqU1NjVWNDTjRT?=
 =?utf-8?B?MGgrN1lCTndlVlhyQWVRNnE5ci8vVHZuNUFud2dLM2ZqUW13ekhaVDVpUGY0?=
 =?utf-8?B?NWpBWWQ3Y3FlWE9nN3NrUjBReTZQUE0wT1c2d0Y5WDlIb00vRlBncXNWMG42?=
 =?utf-8?B?dUkrdklsMGEveC93aHZlZ3FmNEZ2SWJZZGRpZzhPZTdiM2lHWEJudGFvQ0x0?=
 =?utf-8?B?SnU4b3IvWEZuVmk5TzFhc3lsaW9KTkdoWDAwQjFLdlBTaGxJTllmZFkvTWRq?=
 =?utf-8?B?Vmh2d1cvMWJUNjhDV1Z5L0Q0V3RWK1hsSXVuZnNsZC94dlNGTjZxNmZiaEl4?=
 =?utf-8?B?NjRoQUhEM210MVNQd3BlamIwaE51VjczbHZnTzBNSDZQUGVjUmFxbEo5T0Np?=
 =?utf-8?B?TjRCTmVVcWdFNEJ4dDZVdW1tTEpTYkxMdmRlQWZ2RENXUlZhbExCR21aVEZk?=
 =?utf-8?B?M3pGTHlZeGRqUDRkYjE3ZXZ2Q3FkT0d5ZjlaaFE3aTBrU3RTME5Tb2dZWEp5?=
 =?utf-8?B?ZS9pQXBVOWNFWXZVSUpxcGxsc2NPcVp4N21BWWJudVFwb2w1MUFzM3RBVGNR?=
 =?utf-8?B?VVVqaVhtd3RBVEtFNjdnTjVwY20wVFA2RFk5c291TkdwYUxGWnJXVytPczZ3?=
 =?utf-8?B?NUMrWHVpQ3A1cGNJbGFNVVFRdy9yQzBXRnVNZ3V1ZDhQWkNWUFRNNlBKVkk0?=
 =?utf-8?B?SE1DL2gvNzAxZ01iK3FYYXg4WVFYanVHQWFrK1Z2U0hhUnR3Y2piYUVRNjJn?=
 =?utf-8?B?S3FFTUh2MzJmeWFQZHo4SnJzaTNNT2l3VzRhbjdjejFnY2ZqQllwYXVEa1lh?=
 =?utf-8?B?OGpBRy9kclUyVlZXWnpuRnpsUlFQcmt2YitrOGhMc0Vub2N1OE5xUnpmQlpX?=
 =?utf-8?B?VnJwbFB4REdHR3k1a2c4eGN2bkhsYmVDNkQzb2QxUnFKczVBN3hrSHgvaU8z?=
 =?utf-8?B?Nk1Ja3NIV3VTTVRQR1lVMFk2bDdvN0wxOTR3MGo2bkVLbUU1c3ppYUNBTnQ3?=
 =?utf-8?B?ZG41NWNKUzZQMW9lQ0ZrWmRnUXRzVnBBc0VmS0w0NFpocWFZbUlKQzhyeDdv?=
 =?utf-8?B?N1Jha01veW5sRk1NVkhvK1l0ZTBjTzhMYXZWb0Nmdm5xL3d0d3h1UGdTOWEx?=
 =?utf-8?B?U0xsMGxldTZpZlR0dWs4em0wc1VFNkEzb2NBa0J6c0xUNDVOd3NCV0w5SnIy?=
 =?utf-8?Q?TALadXI7kEoT+r4vMQsgSybU6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ba26b6-0e9d-46b1-27bc-08dc39fd8a17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:40:29.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfdDPLQun8yWWhygjMuzW7kAC0MdvbZK8y9vJYsc6U1GGjE59DI3PVDZ3o798kam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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



On 3/1/2024 7:52 PM, Christian König wrote:
> Am 01.03.24 um 15:01 schrieb Lazar, Lijo:
>> On 3/1/2024 6:15 PM, Srinivasan Shanmugam wrote:
>>> The 'mask' array could be used in a way that would make the code
>>> vulnerable to a Spectre attack. The issue is likely related to the fact
>>> that the 'mask' array is being indexed using values that are derived
>>> from user input (the 'se' and 'sh' variables), which could potentially
>>> be manipulated by an attacker.
>>>
>>> The array_index_nospec() function is typically used in these situations
>>> where an array index is derived from user input or other untrusted data.
>>> By sanitizing the index, it helps to ensure that even if an attacker can
>>> influence the index, they cannot use this to read sensitive data from
>>> other parts of the array or memory.
>>>
>>> The array indices are now sanitized using the array_index_nospec()
>>> function, which ensures that the index cannot be greater than the size
>>> of the array, helping to mitigate Spectre attacks.
>>>
>>> The array_index_nospec() function, takes two parameters: the array index
>>> and the maximum size of the array. It ensures that the array index is
>>> within the bounds of the array, i.e., it is less than the maximum size
>>> of the array.
>>>
>>> If the array index is within bounds, the function returns the index. If
>>> the index is out of bounds, the function returns a safe index (usually
>>> 0) instead. This prevents out-of-bounds reads that could potentially be
>>> exploited in a speculative execution attack.
>>>
>>> Reported by smatch:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:136
>>> amdgpu_gfx_parse_disable_cu() warn: potential spectre issue 'mask' [w]
>>>
>>> Fixes: 6f8941a23088 ("drm/amdgpu: add disable_cu parameter")
>>> Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 4835d6d899e7..2ef31dbdbc3d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -24,6 +24,7 @@
>>>    */
>>>     #include <linux/firmware.h>
>>> +#include <linux/nospec.h>
>>>   #include "amdgpu.h"
>>>   #include "amdgpu_gfx.h"
>>>   #include "amdgpu_rlc.h"
>>> @@ -132,8 +133,9 @@ void amdgpu_gfx_parse_disable_cu(unsigned int
>>> *mask, unsigned int max_se, unsign
>>>           }
>>>             if (se < max_se && sh < max_sh && cu < 16) {
>> This check is already there which is equivalent to a case like -
>>
>> int arr[A][B], then check if (i < A && j < B) before accessing arr[i][j].
>>
>> I think smatch is missing this.
> 
> The problem with spectre is that those checks can run speculative and
> you can still get parts of the data by looking at cache behavior and
> timings after it returned from kernel space with an error message.
> 
> That's why you need the explicit call to array_index_nospec() to avoid
> security holes from that.
> 

Thanks, found the doc -
https://www.kernel.org/doc/Documentation/speculation.txt

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>> +            unsigned int index = array_index_nospec(se * max_sh +
>>> sh, max_se * max_sh);
>>>               DRM_INFO("amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
>>> -            mask[se * max_sh + sh] |= 1u << cu;
>>> +            mask[index] |= 1u << cu;
>>>           } else {
>>>               DRM_ERROR("amdgpu: disable_cu %u.%u.%u is out of range\n",
>>>                     se, sh, cu);
> 
