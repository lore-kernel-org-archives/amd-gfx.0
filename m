Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9D7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F8E10E32F;
	Mon, 24 Jan 2022 17:00:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E1210E333
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw+PKibc9duq5UW05Go+U7Aq/QabWx+MZvQC5Zh6RC71X62TFhEd1e34NxTx6RCkFxqKVJ49uOJOAMH3qVGig1FF4/bvP/fEvV5J2zsD3Ge21yLCFWf5mFw2dC6etJCzg78TbD1nJkuU/cvHapWbWJApPPAKUT6sZX0UefhoZDGbIkNpRYqPHcE29gKfJ2Bzzjhf5XRenBEhQbUcTz8MfY6taa0mOynYDOM0wK3YmhkW5A92ZIcCh6R6l5i5no58ok5E+n67s0wPr3pP+E/hM0bZ7V6sbhmbVh+NqljLMUP9wuMMMNI+yb4uSBuKM0O1AjKXhACe/iiGTnsNc+Y0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtvmQcGX/A8QDR1atcwgNWK2Oyo4D4X4XRgcko+RZu8=;
 b=oS0k1ZkkciXDzBudeNp2kB+v9ARYaf1omnwQ0LD+ziLExwWyX593k35HpZap5FlKJpttx+6JPFpcbdGzKEMhJnUi3D/L4EdyEhqDAIJZmjS+KoMrYYhupwRL6EcIqSIChiubIC+l5hti/F2LGqKgrf+bLunB8XoR0BglyJhxBSJ1wWRxM9yhx62zel8Fakm0oAF3kmLB4MDqUmOmY1+L50Au5gv2ujqIx4uoo7t8v8emcqwv5FqBzgbqL6lY1aRo0HAdQMXoKiU4d2+Rk8TErMEiqRDdRB0x1nFoXGYcqfdtvyKZMG+BSDy3/i6TJHq92CMA6DPD17KIztM0AAcAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtvmQcGX/A8QDR1atcwgNWK2Oyo4D4X4XRgcko+RZu8=;
 b=5EwVsnG1P5F6d2sxNqNn2ntgaWE4zuKYZjgC/Yl3M0vp+JnWvNsA+TQJ5PoC75Amrqm6vCeMq2EitBZQRF62jCdAqY6ruv0dVnxNiQLh4Al+7BxEJcVoAvwuZfKcPRXT0iTlo9hjFCX9e8xJ8AQWBQGv7ctwUkwzJSKx/amfaZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 17:00:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:00:17 +0000
Message-ID: <f2211cf8-f159-9668-7e3f-7587063ca075@amd.com>
Date: Mon, 24 Jan 2022 18:00:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] drm/amdgpu: add reset register trace dump function
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
 <fa8d13a4-ccbe-6e8c-5c97-9c4d7f1134f6@amd.com>
 <26aeafd9-307e-f8de-501d-5efabd67a450@amd.com>
 <c47c2450-7008-4419-795d-f9e6be64061a@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <c47c2450-7008-4419-795d-f9e6be64061a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eee5e99-b03f-438f-5fab-08d9df5aff28
X-MS-TrafficTypeDiagnostic: DM6PR12MB3355:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3355B08010DEF33578EAC64DF25E9@DM6PR12MB3355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmkK8Woennm4Vt9I7zuf/RWy8TWwuzkYEUE46a8khwe/z88rMKUWJWS2lufOWFQhoNuU/vCb1s7CvIrhgY/MqKu2nGknRQoSlJdErPU7TnIkOuMAKOp2KkX3S1fdIucH4GvwZU1C8MIWigmg3OEWgNfdvSGkyhXAFnoT7UBAKAmMIayLALiGHAUC+WbQ23NRZHjObtteV5x7Advq2PW7RbrAj2RyLQtbDpDm+BqegImdgdV//iUItWI4xXNAaVYtrfrsadrdLr/vOi0U1xRhXaV0JNXLNn6IlHnIBwhnT1p3WB0a6NmLqHysXs9uEr4XCwNb5YlsRQakF2cNkM2LCtcrAgwuWLrQ0LnplENsXV68xK7rtF0Fk5kBDDoJmmRzScMcixvfX0hZwyAfUJEu2OBcYAoRvWKga4bhJBuhgS6jGuUyd8ecMkTj0g9SERmVtq6O+P4LNrrgxLS68dtnq3T/fqJWXK78UMuX3l0/Qj+z3LVT9ko2M2+BmPj3zPJCwRw8sAOzw310ad8S6xDt706XCk+B4HncaaGzWJAxNoKsO6ZtvvhMZH2EzHnRU4nQchdCSO661901yxhZ/U1rERDqjK4DRIaxcOOxMcFEWyEnjXSb7Zdy3AgUBbM6w6c9mZ2Qgs6bTXlHx26g67PHeUSeDBkoYh77HhmhxaPeW9cYhBJb81/zcFeUg0Z5uuN5PznVbz6PC0+s+UINF0unL3bSpcoq25tYAGy4qA6LFtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(83380400001)(5660300002)(31686004)(53546011)(66574015)(86362001)(38100700002)(110136005)(4326008)(186003)(26005)(66946007)(54906003)(36756003)(8936002)(8676002)(2616005)(316002)(6486002)(6512007)(6666004)(2906002)(6506007)(508600001)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlPcG9sZkRZa2V0VEV2RGhLdGlVa1Z0S1ZtOUNPNzM5Mlhwaktaa3o1cklq?=
 =?utf-8?B?UkxKWnFjbkY5RVBDTlhxeHV1UUx3Ukh6S0s5TVVsaW9qb2xEazgvbEQwVi96?=
 =?utf-8?B?c0NDWVlOVkNZcWtuRUNyb2p4by9tSFhJUFVwUm9paDlaM3NlWE5RRVowYVBI?=
 =?utf-8?B?M3NwZHFxdWxnbkdXeWZOSDMzampuWHp4R2RxdEF5bEZ0UzJCdXI3UXhlSUFw?=
 =?utf-8?B?cWtaOFhHU25BZURHamZhNlZCMXd1aWE3WnFCNG5ZOGlQV2VWeGovQUJSeVVJ?=
 =?utf-8?B?azM2aFV1SVg5Q3lHTXNVaFZyNUxueGpjbTdUbis5Z3J4NkRtRGxoK3lOaW9l?=
 =?utf-8?B?UzYva2NQeW96QjJ2aG5vZEFzSmU1SjNOdjdNRCtjWXdQL1owZ1pnNTNwbmc4?=
 =?utf-8?B?OHNyRWdmVVRha3p6SDF0RzVxVTIxQmNIanAwWnVKQURNR1BBbXNhY0NSZENZ?=
 =?utf-8?B?Y2ZIc1B1LzdQTHo4S3dmeXVPWTRVOGVoNEtKdUxPU0lPTStUWCtkZk9jOGdp?=
 =?utf-8?B?MjZjc2YvUFg3aG4xU1pwaWZCd3pXZDN0TkRacVhKWHhKVUw3bzBQRzNoanVT?=
 =?utf-8?B?c3E2Z0QwRjFnNWp3djFNS1dRV2hiWlkzUjUzeXh1QThCR2lMTWFmSElMZHZJ?=
 =?utf-8?B?cHhEZjEzRW53SzVzZ1MwOTh2VVNkamhNK3F6WXdjd3cxZEdRUEg4R09NVDJC?=
 =?utf-8?B?ZkNXQXZvZXFRM1FwaGlFUzVoUmpqTjI5ZlBuOVhqdVB2TjNXOEkvOEZPWHNy?=
 =?utf-8?B?cEpuRFNUMnN3QnV6SEwraWorTmEvUTRuK1NCMmFqM1dXTTMvWFQ1QXJtMzVr?=
 =?utf-8?B?K3NCcWx5emVodmNlYkdCSnYyZ2tSUjg0dmROaXdhRG0yV3ZPdFlkQm5ERkwv?=
 =?utf-8?B?T2VoRnJGTUNhQTRQYzY0RmdleXNuWmJzbFBPQytxZnVRTVFXWm55QjdSbytw?=
 =?utf-8?B?aDlnaUZac3YzTEFtNEV3UUJBb1hJV0pNajJvVVFMTElaWEtWblNHMHVRdkxT?=
 =?utf-8?B?T0tzZDRMM0l1RHpBcXB5R2JWVDRRUzZDYVFGZHVnTnMwTm9zUW94N0lkVUxH?=
 =?utf-8?B?Mm9vekRLd0Y1Q1lxMEQ4YjVsNWlIeWZhOVBZUytKMWxmTXAxTVRORTUxOFJZ?=
 =?utf-8?B?dkF6eGl3Tmc5REFQTEx3UDRLZk1PaGtZTC8xTFg0cGhMTU8wdUlaMS9Td3JO?=
 =?utf-8?B?TDFqcnc5dk8rN09Qd1ZNRjIxZ2hqbVA3VWtVQVhpSkxCZHFHZUhta0VXaHRF?=
 =?utf-8?B?RDFhTjhTcktFdmVNYnRRelgyT3RjTC9GU1N3M1RSUTNhQThkeGdHWE1pbXhR?=
 =?utf-8?B?ZUtFeWc0NHRmTFNWNFF1MTArWkE3bXFKUzRZZDZhR0tNcTdTSEtudmhtdStR?=
 =?utf-8?B?ZmVsbUxuaXQrZno1SldjUnVRTEpLcXZUOXNvVTFPVjNuTkNEUFdtcE9HSVl0?=
 =?utf-8?B?SVNmV2pkRFBrM09YcVVKT3gzc1ZhWnkwUjgxaUFnck5TMnlTVys5ejNZN0dV?=
 =?utf-8?B?a3pSTnVPNjZ0Q2xZWjJMbm0rZEZXOWFiQlNQY0p1dk5RUWZHb1B2WFBRejcx?=
 =?utf-8?B?bnoySW9LQ05IOUJ1LzlSYVpsTFZveS9BTURhRDhlQml4amNaSW41NDlrdHRa?=
 =?utf-8?B?OFRvMG1FUm1aSjIxallpMTNkMXdXai9ObEREKy80d0pZUFlEZXlkc05NZy8r?=
 =?utf-8?B?WTh5eXdReHBRM2l3UEVDcmtkWk1xTUNhN0VIYnpGWWRWTXQvbmNiN24zNHRT?=
 =?utf-8?B?Vk1EdFZqWDR1MWo4Z0lTNFQrcEQrcEFuU0RMWkpwdlZuZ09mYy9SY2U1MjdF?=
 =?utf-8?B?WGFvTE55SlJpNEF2MnZrd1lqTjVEcXAzamUwcE9hRWo1U2tDVUNSdnpNNmVU?=
 =?utf-8?B?N0tEand5cHlma1dyNGRPNjVVV3h3TzNLQmVob0J0TkdpUUp4eDZYK1h4Q1cy?=
 =?utf-8?B?VHVROFUxOGxsbk1OOE9ETHJvT3A0NG5CU3k1MHdzcVlJTUNDbUMwSG8xQ0JK?=
 =?utf-8?B?R1BLYklVTFFtRWFOdEdTWG95VFlVNU90Zm9Hb0s2NmNYd3o1NTlSQUtSNFhG?=
 =?utf-8?B?bEVWUVN2Q002NUVjS2tLOFl6eEFybnhmSm5GaGVXbDJ4UE1UemlwNHZFWTdS?=
 =?utf-8?B?Y3JkMjRzaXNOUUs0ZzJiNTVnMTR2M0UvYVp1ZzhnY3hsNVVsNnQyTmlCNW1q?=
 =?utf-8?Q?zXbhu40FW4/eCV79laGjYJY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eee5e99-b03f-438f-5fab-08d9df5aff28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:00:17.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2VQPOTXiRxl7EyDQ+Gn7dqZYHI+j/rLk04FFM5xxzUt5yJN8PmB08lGLfZA6ZLEQ3RSkKJag+55jMS5zINuvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3355
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 5:48 PM, Christian König wrote:
> Am 24.01.22 um 17:45 schrieb Sharma, Shashank:
>> Hello Christian,
>> Thank for your comments, please fine mine inline:
>>
>> On 1/24/2022 8:15 AM, Christian König wrote:
>>> Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
>>>> From 1c5c552eeddaffd9fb3e7d45ece1b2b28fccc575 Mon Sep 17 00:00:00 2001
>>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> Date: Fri, 21 Jan 2022 14:19:10 +0530
>>>> Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump 
>>>> function for
>>>>  gfx_v10_0
>>>>
>>>> Implementation of register trace dump function on the AMD GPU resets
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 ++++++++++++++++++++++-
>>>>  drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
>>>>  3 files changed, 60 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> index d855cb53c7e0..c97b53b54333 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> @@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>                __entry->seqno)
>>>>  );
>>>>
>>>> +TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
>>>> +        TP_PROTO(char *reg_dumps),
>>>> +        TP_ARGS(reg_dumps),
>>>> +        TP_STRUCT__entry(__string(dumps, reg_dumps)),
>>>> +        TP_fast_assign(__assign_str(dumps, reg_dumps);),
>>>> +        TP_printk("amdgpu register dump {%s}", __get_str(dumps))
>>>> +);
>>>> +
>>>>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>  #endif
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> index 16dbe593cba2..05974ed5416d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> @@ -46,7 +46,7 @@
>>>>  #include "v10_structs.h"
>>>>  #include "gfx_v10_0.h"
>>>>  #include "nbio_v2_3.h"
>>>> -
>>>> +#include "amdgpu_trace.h"
>>>>  /*
>>>>   * Navi10 has two graphic rings to share each graphic pipe.
>>>>   * 1. Primary ring
>>>> @@ -188,6 +188,12 @@
>>>>  #define RLCG_ERROR_REPORT_ENABLED(adev) \
>>>>      (amdgpu_sriov_reg_indirect_mmhub(adev) || 
>>>> amdgpu_sriov_reg_indirect_gc(adev))
>>>>
>>>> +#define N_REGS (17)
>>>> +#define DUMP_REG(addr) do {                    \
>>>> +        (dump)[i][0] = (addr);                \
>>>> +        (dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);    \
>>>> +    } while (0)
>>>
>>> Those macros need an AMDGPU_ prefix and maybe some better names.
>>
>> Agree, @Amar pls check this out.
>>>
>>>  From the design POV I'm really wondering if it wouldn't be better if 
>>> userspace defines the registers we want to dump in case of a crash.
>>>
>>
>> I am not so sure about it. This means we have to communicate with the 
>> userspace and get the list of registers it wishes to see, do I smell a 
>> new IOCTL or DRM property ? I also feel that we have better filtering 
>> tools for a trace event in userspace than in kernel.
>>
>> What do you think ?
> 
> Just a writeable debugfs file should probably do it. We have a list of 
> known registers filled in during boot (just reg offsets) and userspace 
> can read/write the file to update it.
> 

Ok, so in this case, what would be our state machine ?
1. gpu_reset happened
2. uevent_sent from work queue
3. userspace goes and writes into debugfs files
4. kernel collects the desired register values

5 (a). kernel send the trace_event with desired values
6 (a). kernel sends another uevent to indicate trace_event

Or

5 (a+b). kernel loads the reg values via debugfs itself.

In both of these case, wouldn't it be too late to collect register 
values by the time userspace list arrives at kernel ?

Or do you have a better state machine in mind ?

- Shashank

> Christian.
> 
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>> +
>>>>  MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
>>>>  MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
>>>>  MODULE_FIRMWARE("amdgpu/navi10_me.bin");
>>>> @@ -7488,7 +7494,6 @@ static int gfx_v10_0_hw_init(void *handle)
>>>>  {
>>>>      int r;
>>>>      struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>      if (!amdgpu_emu_mode)
>>>>          gfx_v10_0_init_golden_registers(adev);
>>>>
>>>> @@ -7602,6 +7607,49 @@ static int gfx_v10_0_hw_fini(void *handle)
>>>>      return 0;
>>>>  }
>>>>
>>>> +static int gfx_v10_0_reset_reg_dumps(void *handle)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +    uint32_t i = 0;
>>>> +    uint32_t (*dump)[2], n_regs = 0;
>>>> +    char *reg_dumps;
>>>> +
>>>> +    dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
>>>> +    reg_dumps = kmalloc(1024, GFP_KERNEL);
>>>> +
>>>> +    if (dump == NULL || reg_dumps == NULL)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    DUMP_REG(mmGRBM_STATUS2);
>>>> +    DUMP_REG(mmGRBM_STATUS_SE0);
>>>> +    DUMP_REG(mmGRBM_STATUS_SE1);
>>>> +    DUMP_REG(mmGRBM_STATUS_SE2);
>>>> +    DUMP_REG(mmGRBM_STATUS_SE3);
>>>> +    DUMP_REG(mmSDMA0_STATUS_REG);
>>>> +    DUMP_REG(mmSDMA1_STATUS_REG);
>>>> +    DUMP_REG(mmCP_STAT);
>>>> +    DUMP_REG(mmCP_STALLED_STAT1);
>>>> +    DUMP_REG(mmCP_STALLED_STAT1);
>>>> +    DUMP_REG(mmCP_STALLED_STAT3);
>>>> +    DUMP_REG(mmCP_CPC_STATUS);
>>>> +    DUMP_REG(mmCP_CPC_BUSY_STAT);
>>>> +    DUMP_REG(mmCP_CPC_STALLED_STAT1);
>>>> +    DUMP_REG(mmCP_CPF_STATUS);
>>>> +    DUMP_REG(mmCP_CPF_BUSY_STAT);
>>>> +    DUMP_REG(mmCP_CPF_STALLED_STAT1);
>>>> +
>>>> +    n_regs = i;
>>>> +
>>>> +    for (i = 0; i < n_regs; i++)
>>>> +        sprintf(reg_dumps + strlen(reg_dumps), "%08x: %08x, ", 
>>>> dump[i][0], dump[i][1]);
>>>> +
>>>> +    trace_gfx_v10_0_reset_reg_dumps(reg_dumps);
>>>> +    kfree(dump);
>>>> +    kfree(reg_dumps);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>  static int gfx_v10_0_suspend(void *handle)
>>>>  {
>>>>      return gfx_v10_0_hw_fini(handle);
>>>> @@ -9367,6 +9415,7 @@ static const struct amd_ip_funcs 
>>>> gfx_v10_0_ip_funcs = {
>>>>      .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>>>      .set_powergating_state = gfx_v10_0_set_powergating_state,
>>>>      .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>>>> +    .reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
>>>>  };
>>>>
>>>>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
>>>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>>> index 257f280d3d53..76d3a55278df 100644
>>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>>> @@ -296,6 +296,7 @@ struct amd_ip_funcs {
>>>>                       enum amd_powergating_state state);
>>>>      void (*get_clockgating_state)(void *handle, u32 *flags);
>>>>      int (*enable_umd_pstate)(void *handle, enum 
>>>> amd_dpm_forced_level *level);
>>>> +    int (*reset_reg_dumps)(void *handle);
>>>>  };
>>>>
>>>>
>>>
> 
