Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA062C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 13:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA8310E9A5;
	Thu,  5 May 2022 13:15:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FBE10E9A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 13:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2GnqMYa9Biz2MQdRw7P3hCSmt+ZueXIEZ/DpHJ590spw8NldUU79fIVww3czBzhugW5bhqJVFcFTyeskd1tsfyu5eKkbkNOznQACgvsSJ8VCxpDuCL4/7osV9HjIcq8MicFm+tobLMaK+SJEQiKm1c2tiFi1052redULeFHSFCIf2QZeyOgYKOOdqBfaezwvdMI4bJRdXppakuCtPD8Z3D4bWwe6aX2rhcK2CZAsvE7EriGMwuqD191sctWhHNJlxxRAVLoFj+dgebaMGoMFWmDjYEW706wk6TqIO7US6Ka1lN4THEJSJCmv7NUrIH/CcF834N+qq1CdfGBnFZRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCJUVi25rrlJjEDuOYNjB3onyLmpLQvtwDG7sAkc63g=;
 b=MCJl2QHcwWI4Maneg9javi/gEiQgnFgDJpQrSxkNt9PfvZM3lZLTNQ9RyRXQAxUnlPjzllu41OeQcq3TbkGgX+jV4A7wwUfrIqSc7gX5lFKL24+1fwcV2VtjDB4O38c1OdY3h328B8rKty9R98k1aqpN5TklGCbevekGVnXwwNmhR1726W2e/q4aoEFQ08yzFxI+s5vulOD85LoT3n3hqYU0Bxj6x4i53cumf5pvKHuyhu4TbZw8q6bHYLUG288NEkUVtmCsPmK04zzn4nRjYQmgC4AjNU8PmNell3lN2GP7YTFcSwQ0RoEUtQKQB/zF3xploXAIx2aQ33jQNTo30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCJUVi25rrlJjEDuOYNjB3onyLmpLQvtwDG7sAkc63g=;
 b=GrYBZxnQTnamM1ZvIU+Ti4NDtbznB2q1r83e4tDm9+YlMSnR+AoM/CzNx+2wZvZboY7ll+vfRj5Y1TX1/PTBzNz3duVpYmws4PKFQ4DTDuEh/9EgfHl9bpzpyQtl+cxPXRarsurzSXpjPsMBjBF2uRE5Xh7xz5Hr0D4P3z4zA1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 13:15:54 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5206.026; Thu, 5 May 2022
 13:15:53 +0000
Message-ID: <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
Date: Thu, 5 May 2022 09:15:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe3c7ee-df9c-4b8b-37b3-08da2e99621a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1815:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1815E1824B9611597B485C61EAC29@CY4PR12MB1815.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgqfKiqlObf6B4vfCVe8VkxRcW2UU6JGBZYODw3lt9Ts3KSadFBT+n5nPWd6zOXxa+YLfhhxEpNpqKXsVA3wAbPJ7Prd10PGlIDuEnOQFskMnoYfACf9whWmqTQblIDqX3DS9PRErWhERpJZhmlMi2Vybp7L3ndMHSasu6Q6fVcQJMJIPC9gjbQWcEKwOnm+cz5k44ZG0odORgz40hYIL5SzD63SB57E69TAmHvkwVJJ3OiGA/coVeKK3YeSK7xOkG6etv3tRYmA0Pi/yErBxJEWjQTxJ8J20hf5J49aiRNO9Z2dN0NAEayNTKXKHVBHBsyZxPpJkL+dKbF4Fuua1lBs+bblsTM2GCbAX2CAZ8sS/q8bt9wBjvcwSd/iMb26Sl2yY+6fhFdci3eu18VJg6C6bb+BxC1YCElbR98H4NiGsmacW79+nEBogp2w7ZQ+VaLb7I0bOJLLSuka8zRM3sALxABLaaAC89+c+rGJ2rqB4xhqoeQxmUsyizCm07zgnxS2S0i34qrZ5n10y8EuPvGR5w5snNOSkq/H8dtbvOcjvMPtFtA2ywi71y4iS4g1TFxDkIsu5U7FLPcrqbxk9Guptb5kByFEk0d8o9JlxttsZq9LPqKQDilJSDosctG+bPY36JswAmS1q1cj79liNZyNjtUZ/xi6SV4pDLs3g09OQFNw/2rrjj6by5yfnywervXQsiljPfQkiQ+EmiW/aKT8ygcQbAcQIWttsZ/xv6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6512007)(186003)(6506007)(53546011)(66574015)(86362001)(38100700002)(31696002)(8936002)(6486002)(83380400001)(44832011)(30864003)(5660300002)(508600001)(316002)(66476007)(66556008)(2906002)(8676002)(4326008)(66946007)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9OTzJsUEp0b0YvK2JMZ041YzhJYnRYd3JzQlpaS0E2blVLTTdPNGV5ZTBl?=
 =?utf-8?B?Zk1zOTV6MElEdGhkZTZ5b3JyK20vanlwSW1LNitnT29RcVAvdDVUQkZJdGhZ?=
 =?utf-8?B?TTJLaDRTbnkyUDBHdlFVdDJVenZsY3IzeDh3dWFTUXppUkJoWXlhNVJ4NDJM?=
 =?utf-8?B?MjhJV05CRlBOajBBVzFROG8rajIwd0pjZGFsOGlvQVRDV2Jod3JNWCtHSEZB?=
 =?utf-8?B?K1ByZi9BZ2prcGJVTkVQSVlXU2JUdyt4bkZCMkdjTEJZbG1QM3Fpd3hpZ2cx?=
 =?utf-8?B?Rm95bVcwTWZqYlJmejR5ZnAveWY3amFyakVTWi9DZXRBZC9LNUd2QTNsSVps?=
 =?utf-8?B?UnpPRXEvYjgvQ1FwU0E1b0FxSEpLdjNHWXFLNHprMDFYWkc2Tm5UVEtwZ0E0?=
 =?utf-8?B?aGQ0ZUI4REYrSUp6aER0bFV1QmRHc3l6WlFZbzNyeXNnZjZuQnlCZlJkckl1?=
 =?utf-8?B?WEVnK20yTCtNbEJQK0JqWXJjaTh2WVlrcVhaUy9odmhVWEJLcjN3U0xaSVpS?=
 =?utf-8?B?NFJETUtYRDFUODIxTXV4NmVwbE5sa3R3Ny81M0QybHp4YmM0VUNFK292aFRu?=
 =?utf-8?B?YUM4OWI4Z1FkSDh5bWNwbEhuSDV2QnRoVnRmMEZWZjBIRzgxWXFvcmtZZDRx?=
 =?utf-8?B?WVl2QjdxcDF1TlhNa00wdEcxTXNvTkNNSlJHTkNkN0VrbzVDUDhKYkVpUjM0?=
 =?utf-8?B?RkRRcDJWaEt0WjNtRkl1SFJUbXZ1MDg5NWliN0dPUjVMajlSdGhJMUtmelQw?=
 =?utf-8?B?QWhDMVM3SDVQQUVPOXFrYm9KTmNZZWJHd3NoS0RZSzZFUWRwVzNLcFR1YXlr?=
 =?utf-8?B?UjZibHYyL29sOXhWVTF0bnB0cklpR1JNNFZtMWV6RkxQZkJmZ1BSK2thK0NQ?=
 =?utf-8?B?UjhaVTZibllRbm4wOWpDeCtxZG1ieHczZkc3RW5lY25JOElyQ21WY28vbEMw?=
 =?utf-8?B?WW1rVFNRM1hoRGpOYzNDQ1RlRUZKQjdybTZsTFA0MVEvTFJNQ3plMVBMMWkz?=
 =?utf-8?B?WjFDQW05RnJvYy8rV1NBQ2dRZC9CK2M2UjNVVmg4bFFuRU1pOEhPanJ0Sitm?=
 =?utf-8?B?Vk1BTG1QRWZMT01NL1NHdEsyK25lY1lDdktvV1RnYllPcXFhT29XaU5YYmV3?=
 =?utf-8?B?OGZKOWVTbHdKODVXVDFtSDArSTNGb2E5RFBBY3pBeXhsYjAxZmhDVHhSRDdU?=
 =?utf-8?B?WkZTV211TzVYbjQ5TVVRNVJmc3lUTnR4eStaRllTNDN1aUV6R2pwalB3Mmxq?=
 =?utf-8?B?UkxXQXhZZUNDQmdVMFpMY1Bvc2VEblN6aEVJSVUyakRsaEZGaDV4cTN1N1NL?=
 =?utf-8?B?OENoYUtVS21RQ0g0VjlqeTM0cHBvVy80a0NYZkFJbUJCLzlHZTFjNXpPa3gy?=
 =?utf-8?B?WXdJZDVZYUY0eUJWVnowdzR4RnJINkl4ZW9wRlpJeGpnSFo2cTFDTU40cUt5?=
 =?utf-8?B?WHFrTXlCaXN0blRHRHk3NFhwTTZ2SVBqKy83Z3lpdU5keWFpZ0hQdmFwVytz?=
 =?utf-8?B?ZUlLTjIxZzNmdldoLzFKa2djTlZpdVJXbG91ZjVKakJ3ZHYvME1WMTdQS0lo?=
 =?utf-8?B?QVMra1FNd3lLUlptMkZqN0QvSm5VemdjTTV1amsrRXB6MjlIQ1J0NzhRUUh2?=
 =?utf-8?B?bVNHN3VrUXh1ZVRVb0tUbVhCa1krdFordjRUa1R6NERvMVk3a3NUa1pCWUtD?=
 =?utf-8?B?dEtGMnd6cTJBNlo1RE9XQ1l1a3lWd1ZoZENBdFdTalQrUkFTMEU5UzkzZjhx?=
 =?utf-8?B?LzhsM0R1WGFUYkJPUzNNVWxIaHBrRm5HcmR2WStqL0xRYXpVZGZhQjhKc0I5?=
 =?utf-8?B?T0ZSY3NEWHNVZUlmTW05M3hDVWhoR1pEZnlDT3JuMlRZUWY3Unp1Y2FkdUIr?=
 =?utf-8?B?VmErVHVVOUM1Ulpjb0lYYm5PemNTcS9CZ1RWNUppWGNDWmRQcTgwYUIzTFQx?=
 =?utf-8?B?blB1ZDIvQTFqL25NNVR3emQ4a1hQdUVrWmcyYXg2VDhRQWtST09qS3hUYXNl?=
 =?utf-8?B?U1JVeDZrcUEzdmZUZEhNNm9RUkdBVDFSN3J2USs0TmRwbFZBNHlSQjIrR0hl?=
 =?utf-8?B?WGZQckJUTE11SzBVK3ZKV1pFK1ZjTzNKTlE3di9PTlV2Qi9NTnpLZmpWcS9i?=
 =?utf-8?B?UDM4aVlaVGxQU0lRdFRCUDkzei8yM2Y5Q3FGZVVsQzNFQno4amE1clBWTjMv?=
 =?utf-8?B?WjRmc3FkT2VnRnNlRVNxN2FDay9vM01SYzhiQ0ZrRDBFd2NQTFdyRVppN2dV?=
 =?utf-8?B?THdoUkcxOU5aMER2d1NLazl4cWJhcVBDRnMzY2YzSWNJY1c1aXd3bHJsdjVJ?=
 =?utf-8?B?SUtNYy9vSCtTMGd3eUNrZUphcWtrUHF4YTM4anZxT2lnZCtvZVRScXoxSURs?=
 =?utf-8?Q?tUOY3ck15eXxABpFwGVTkWO6yuvoNCgX8VtgZjwUEEVXf?=
X-MS-Exchange-AntiSpam-MessageData-1: ggy6w4VRLKTYIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe3c7ee-df9c-4b8b-37b3-08da2e99621a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 13:15:53.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdFCzC6EHiC5MvC2NBa6m2k1RkUSbvthgbNfyawkIkzM6MPJre62IGsd1YoWSCmcMAocFuvDDqvY7d+4fhefMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-05-05 06:09, Christian König wrote:

> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>> Problem:
>> During hive reset caused by command timing out on a ring
>> extra resets are generated by triggered by KFD which is
>> unable to accesses registers on the resetting ASIC.
>>
>> Fix: Rework GPU reset to use a list of pending reset jobs
>> such that the first reset jobs that actaully resets the entire
>> reset domain will cancel all those pending redundant resets.
>>
>> This is in line with what we already do for redundant TDRs
>> in scheduler code.
>
> Mhm, why exactly do you need the extra linked list then?
>
> Let's talk about that on our call today.


Going to miss it as you know, and also this is the place to discuss 
technical questions anyway so -
It's needed because those other resets are not time out handlers that 
are governed by the scheduler
but rather external resets that are triggered by such clients as KFD, 
RAS and sysfs. Scheduler has no
knowledge of them (and should not have) but they are serialized into 
same wq as the TO handlers
from the scheduler. It just happens that TO triggered reset causes in 
turn another reset (from KFD in
this case) and we want to prevent this second reset from taking place 
just as we want to avoid multiple
TO resets to take place in scheduler code.

Andrey


>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 +++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 4264abc5604d..99efd8317547 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -109,6 +109,7 @@
>>   #include "amdgpu_fdinfo.h"
>>   #include "amdgpu_mca.h"
>>   #include "amdgpu_ras.h"
>> +#include "amdgpu_reset.h"
>>     #define MAX_GPU_INSTANCE        16
>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>       bool grbm_indexed;
>>   };
>>   -enum amd_reset_method {
>> -    AMD_RESET_METHOD_NONE = -1,
>> -    AMD_RESET_METHOD_LEGACY = 0,
>> -    AMD_RESET_METHOD_MODE0,
>> -    AMD_RESET_METHOD_MODE1,
>> -    AMD_RESET_METHOD_MODE2,
>> -    AMD_RESET_METHOD_BACO,
>> -    AMD_RESET_METHOD_PCI,
>> -};
>> -
>>   struct amdgpu_video_codec_info {
>>       u32 codec_type;
>>       u32 max_width;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e582f1044c0f..7fa82269c30f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct 
>> amdgpu_device *adev,
>>       }
>>         tmp_vram_lost_counter = 
>> atomic_read(&((adev)->vram_lost_counter));
>> +
>> +    /* Drop all pending resets since we will reset now anyway */
>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>> amdgpu_device,
>> +                        reset_list);
>> +    amdgpu_reset_pending_list(tmp_adev->reset_domain);
>> +
>>       /* Actual ASIC resets if needed.*/
>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>       if (amdgpu_sriov_vf(adev)) {
>> @@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct 
>> amdgpu_device *adev,
>>   }
>>     struct amdgpu_recover_work_struct {
>> -    struct work_struct base;
>> +    struct amdgpu_reset_work_struct base;
>>       struct amdgpu_device *adev;
>>       struct amdgpu_job *job;
>>       int ret;
>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>> work_struct *work)
>>   {
>> -    struct amdgpu_recover_work_struct *recover_work = 
>> container_of(work, struct amdgpu_recover_work_struct, base);
>> +    struct amdgpu_recover_work_struct *recover_work = 
>> container_of(work, struct amdgpu_recover_work_struct, base.base.work);
>>         recover_work->ret = 
>> amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>>   }
>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>   {
>>       struct amdgpu_recover_work_struct work = {.adev = adev, .job = 
>> job};
>>   -    INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
>> +    INIT_DELAYED_WORK(&work.base.base, 
>> amdgpu_device_queue_gpu_recover_work);
>> +    INIT_LIST_HEAD(&work.base.node);
>>         if (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>> &work.base))
>>           return -EAGAIN;
>>   -    flush_work(&work.base);
>> +    flush_delayed_work(&work.base.base);
>> +
>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, &work.base);
>>         return work.ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index c80af0889773..ffddd419c351 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>       init_rwsem(&reset_domain->sem);
>>   +    INIT_LIST_HEAD(&reset_domain->pending_works);
>> +    mutex_init(&reset_domain->reset_lock);
>> +
>>       return reset_domain;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> index 1949dbe28a86..863ec5720fc1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> @@ -24,7 +24,18 @@
>>   #ifndef __AMDGPU_RESET_H__
>>   #define __AMDGPU_RESET_H__
>>   -#include "amdgpu.h"
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/mutex.h>
>> +#include <linux/list.h>
>> +#include <linux/kref.h>
>> +#include <linux/rwsem.h>
>> +#include <linux/workqueue.h>
>> +
>> +struct amdgpu_device;
>> +struct amdgpu_job;
>> +struct amdgpu_hive_info;
>> +
>>     enum AMDGPU_RESET_FLAGS {
>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>       AMDGPU_SKIP_HW_RESET = 1,
>>   };
>>   +
>> +enum amd_reset_method {
>> +    AMD_RESET_METHOD_NONE = -1,
>> +    AMD_RESET_METHOD_LEGACY = 0,
>> +    AMD_RESET_METHOD_MODE0,
>> +    AMD_RESET_METHOD_MODE1,
>> +    AMD_RESET_METHOD_MODE2,
>> +    AMD_RESET_METHOD_BACO,
>> +    AMD_RESET_METHOD_PCI,
>> +};
>> +
>>   struct amdgpu_reset_context {
>>       enum amd_reset_method method;
>>       struct amdgpu_device *reset_req_dev;
>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>       unsigned long flags;
>>   };
>>   +struct amdgpu_reset_control;
>> +
>>   struct amdgpu_reset_handler {
>>       enum amd_reset_method reset_method;
>>       struct list_head handler_list;
>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>       XGMI_HIVE
>>   };
>>   +
>> +struct amdgpu_reset_work_struct {
>> +    struct delayed_work base;
>> +    struct list_head node;
>> +};
>> +
>>   struct amdgpu_reset_domain {
>>       struct kref refcount;
>>       struct workqueue_struct *wq;
>>       enum amdgpu_reset_domain_type type;
>>       struct rw_semaphore sem;
>>       atomic_t in_gpu_reset;
>> +
>> +    struct list_head pending_works;
>> +    struct mutex reset_lock;
>>   };
>>     @@ -113,9 +146,43 @@ static inline void 
>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>   }
>>     static inline bool amdgpu_reset_domain_schedule(struct 
>> amdgpu_reset_domain *domain,
>> -                        struct work_struct *work)
>> +                        struct amdgpu_reset_work_struct *work)
>>   {
>> -    return queue_work(domain->wq, work);
>> +    mutex_lock(&domain->reset_lock);
>> +
>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>> +        mutex_unlock(&domain->reset_lock);
>> +        return false;
>> +    }
>> +
>> +    list_add_tail(&work->node, &domain->pending_works);
>> +    mutex_unlock(&domain->reset_lock);
>> +
>> +    return true;
>> +}
>> +
>> +static inline void amdgpu_reset_domain_del_pendning_work(struct 
>> amdgpu_reset_domain *domain,
>> +                  struct amdgpu_reset_work_struct *work)
>> +{
>> +    mutex_lock(&domain->reset_lock);
>> +    list_del_init(&work->node);
>> +    mutex_unlock(&domain->reset_lock);
>> +}
>> +
>> +static inline void amdgpu_reset_pending_list(struct 
>> amdgpu_reset_domain *domain)
>> +{
>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>> +
>> +    mutex_lock(&domain->reset_lock);
>> +    list_for_each_entry_safe(entry, tmp, &domain->pending_works, 
>> node) {
>> +
>> +        list_del_init(&entry->node);
>> +
>> +        /* Stop any other related pending resets */
>> +        cancel_delayed_work(&entry->base);
>> +    }
>> +
>> +    mutex_unlock(&domain->reset_lock);
>>   }
>>     void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain 
>> *reset_domain);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> index 239f232f9c02..574e870d3064 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> @@ -25,6 +25,7 @@
>>   #define AMDGPU_VIRT_H
>>     #include "amdgv_sriovmsg.h"
>> +#include "amdgpu_reset.h"
>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is 
>> sr-iov ready */
>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
>> enabled on this GPU */
>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>       uint32_t            reg_val_offs;
>>       struct amdgpu_irq_src        ack_irq;
>>       struct amdgpu_irq_src        rcv_irq;
>> -    struct work_struct        flr_work;
>> +    struct amdgpu_reset_work_struct flr_work;
>>       struct amdgpu_mm_table        mm_table;
>>       const struct amdgpu_virt_ops    *ops;
>>       struct amdgpu_vf_error_buffer    vf_errors;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> index b81acf59870c..f3d1c2be9292 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> @@ -251,7 +251,7 @@ static int xgpu_ai_set_mailbox_ack_irq(struct 
>> amdgpu_device *adev,
>>     static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>>   {
>> -    struct amdgpu_virt *virt = container_of(work, struct 
>> amdgpu_virt, flr_work);
>> +    struct amdgpu_virt *virt = container_of(work, struct 
>> amdgpu_virt, flr_work.base.work);
>>       struct amdgpu_device *adev = container_of(virt, struct 
>> amdgpu_device, virt);
>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>> amdgpu_device *adev)
>>           return r;
>>       }
>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>> xgpu_ai_mailbox_flr_work);
>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>         return 0;
>>   }
>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct amdgpu_device 
>> *adev)
>>   {
>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>> +
>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>> &adev->virt.flr_work);
>>   }
>>     static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>> index 22c10b97ea81..927b3d5bb1d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>> @@ -275,7 +275,7 @@ static int xgpu_nv_set_mailbox_ack_irq(struct 
>> amdgpu_device *adev,
>>     static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>>   {
>> -    struct amdgpu_virt *virt = container_of(work, struct 
>> amdgpu_virt, flr_work);
>> +    struct amdgpu_virt *virt = container_of(work, struct 
>> amdgpu_virt, flr_work.base.work);
>>       struct amdgpu_device *adev = container_of(virt, struct 
>> amdgpu_device, virt);
>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>> amdgpu_device *adev)
>>           return r;
>>       }
>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>> xgpu_nv_mailbox_flr_work);
>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>         return 0;
>>   }
>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device 
>> *adev)
>>   {
>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>> +
>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>> &adev->virt.flr_work);
>>   }
>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>> index 7b63d30b9b79..1d4ef5c70730 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>> @@ -512,7 +512,7 @@ static int xgpu_vi_set_mailbox_ack_irq(struct 
>> amdgpu_device *adev,
>>     static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>>   {
>> -    struct amdgpu_virt *virt = container_of(work, struct 
>> amdgpu_virt, flr_work);
>> +    struct amdgpu_virt *virt = container_of(work, struct 
>> amdgpu_virt, flr_work.base.work);
>>       struct amdgpu_device *adev = container_of(virt, struct 
>> amdgpu_device, virt);
>>         /* wait until RCV_MSG become 3 */
>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct amdgpu_device 
>> *adev)
>>           return r;
>>       }
>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>> xgpu_vi_mailbox_flr_work);
>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>         return 0;
>>   }
>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct amdgpu_device 
>> *adev)
>>   {
>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>> +
>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>> &adev->virt.flr_work);
>>   }
>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>
