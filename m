Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36167C61D97
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 16:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9440E10E189;
	Thu, 23 Nov 2023 16:25:24 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502E410E189
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 16:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do7rYDZvF7WTkWMuK3kZBYzaJ074uf2+BuuHivwwmvO0l+eMmQkYNZpK+oCDkOA5t3hwOtKZx6Qs+VIOr6WXtwAnPv1HD0Lgdp6VUGa393G7+AakSr7peN2hXBReYv6W9vO2jxRy5T3h0H+sXf4o5e+uc/Bp1UjxBXUg6aac/nhMEgiEh/cGHRHtjIVbnylnRu7hsfxLebGlMfdNXnt1oDHbJ9R1QbXCgm8/M8LKga5deTNwLUWAxyxxWjmfrmetPrDiQ4eR3Olfi8PoSxvJkkjx6vjGPvfjiTIBxkofQhUqxhArVKMvEZRE4hFs18yw0Y8j1Uwr4LQy5gprEP74sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yjY+37fnlWPq9f0LqM1h/MWC8AFBuqUmWfqeki0LVM=;
 b=lFvwiq5V+xyY6HiWBeIhPv8Bj01e3utDGLqWM5qgUZ+2zO+8Q6f7vWUL6c5FatvIB8+ylAbw3f9z5l4E2tK4PuSq6+vTBbjDuTuxH9DipOuQAbI3xf6BbUPFIaK+/XmyhCozQ1qQO3u6WRaj580RCx7sdVV2185Xj21UnJpUh5LY9/QbTAGbxNyuokN6fEBdineuOSqFqRDeIeWEt5u0dh4CELS+Oj6hXhgG5YD09aeQb0IAAKfFUs1Cr18+ERLDH81KMzj8ffCUbE/CLfcOjs6Z/RKHfc4t0l8QSEbYl+hZq3xr5rYPGkLJ6kY0PxC0i8RQH8gPwMMGWiEWhFa6pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yjY+37fnlWPq9f0LqM1h/MWC8AFBuqUmWfqeki0LVM=;
 b=pcmXyiWbxBh4aLPjONCQ9Aeze47Ub57+fdO4qxUSk5oa0c4F4hiU1mqvLhp66CfmJU+Q/14j8U96lIgcLd1EtMySnNrSOsqH6xMDTEOALidts0GbvO9aUT5KlMtVkXw9OYPS4GevYjngunZKaRUv0hdLW56T8h2UrUAU39ZJMns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 16:25:17 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 16:25:17 +0000
Message-ID: <f24bb157-8c36-44a8-9ffb-128c21377500@amd.com>
Date: Thu, 23 Nov 2023 11:25:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] drm/amdkfd: add queue remapping
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-22-James.Zhu@amd.com>
 <dc13740d-666d-4296-8f77-062c6f32374a@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <dc13740d-666d-4296-8f77-062c6f32374a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0261.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::28) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 81562157-fa28-423b-5175-08dbec40c786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XD+RjKGPpwkjSScn6D48QkeNEE2FDy2VOAOaaVZA2AZpp7MtBJvn+MhaQP7turxQMDK1IIApq2Kq5+S8NSJbPPh+8j16q71h7yr5sbuON1QfycjYBZ/NnRglQ7B7buhxotLY2TjEkbpZAFSaW8JT1jyoLvjDrePdHj3AiJvGL04MlFqxrPbR4vS06Jiyyi4hWa0SUt9OzdyC1zcMWsBsaDjyd7X9luiE/wKlvcU+h0bhv9XgoIU/uBsVVdyqfDA5tL2IGUfmSvPxhCVXqK3qqtn9F//w2JMPuOib+LFoT3/zNpbpX7dRxWIAETare0Gm5Tz9r0SQxKrcig+gHuzTQwGyevlAyyNgZIBU3dkngO2iyumdr3nrlG1C/C3MdUECZgatW2Vt1CnnmPUrUVhHQMBNaRyUm3tdO0gD48wkivOb/L3s02vyEFczLLOaINvJlc+bK9J7ytPoHoWTMgFNEkFqKUxcPVZQ+d2ce81uK8R5mlw77gZjE/oo/DtuKaC/AN0hh1YDPsV4dxRz8V3jF9MEf5EfD4uMb69AjS5HhemYvNu/m3Gyvs/MsKWoA1BX4GvYoauCEScG9uUL8f2zYfWPHJg4rIa5mEeOeiAnrea6h5l/Q0DCHA2y9XfERsvdgnRiuQYDgZnKOm2EantWtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(26005)(6512007)(2616005)(36756003)(31696002)(83380400001)(38100700002)(4001150100001)(5660300002)(2906002)(6506007)(478600001)(36916002)(8676002)(4326008)(316002)(53546011)(66556008)(41300700001)(6486002)(8936002)(66476007)(66946007)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGNBRWVOcng4YVJxcUlwQ25yWHU3eHNITURDS1ZVWkQ0cWtSUytuQ1dRN0Fk?=
 =?utf-8?B?ajR3aUpvRk1SaDJpV3ZHRWZBOFJZR0FreVFJS3p1amV2bmsxUWdwclgzZkNy?=
 =?utf-8?B?NkJaanJLdjBpS0R4U2JvRjQ3bmtCUllSZEx1aVBFcUVQb0o0UVJRUHE5OTAw?=
 =?utf-8?B?L01zMjZwbnRMcEVYd3hOcE1vRmtRNFpaaE1SNVo3aXYwZ1Zzb0pxZHBpY05s?=
 =?utf-8?B?WUxack5QS2o1TWJHcW9odkZPa2tsWW4xMGtSQ3JBZjhGYU02bkhyYjd0dzA0?=
 =?utf-8?B?NEdBb0U4aGxFNFVxUm5SNURjMUFjdm15Y2ZZOEdETlFycXdRc25tNmVTWnNz?=
 =?utf-8?B?djJ6ZENRdjZEaGpnL3VJdWQwekhFV252Tlh5YkhmOURLeWIzQm5ycVljQTB2?=
 =?utf-8?B?V00ydGQ3WWlFU3lkNjNPT01acklzSE9VZDhyQnd5bUJSNGI4RWFjUlZrb3k2?=
 =?utf-8?B?dHVSRzFWbTFJZFZCemJ1ZXk5YnQvaE9qc0hHQTA1UDJoQmRJRWJ2NDJPcVUz?=
 =?utf-8?B?U2w4bnVyUjk5U3pyQlFYbXNCUDkzZW9adk5aTFhaM09Uc2ZsWFhIVGljNEpE?=
 =?utf-8?B?MTFEd0pyQ3ovbVpKelV2TFE2OWRabVlyQ1RTMWVWbE9rQm5LKytnaTBNOWhj?=
 =?utf-8?B?V0NxREEzV2VOTzcyTDQrTE1OMHRIWEwzVDVUNjhyamxnZHk5K0Y4OTFZVTk0?=
 =?utf-8?B?RTN5WG0rRUQzdXB2OGlZT2pBTzgrOFNQWU5aMmJvSzVPQXRxTzFmQmdMdEpQ?=
 =?utf-8?B?ZUowa1Zzd0svdHNMWWE4azJOQnh2dUZsVXJVUEhmenJGWlUzWUx3VTZCRVMr?=
 =?utf-8?B?K3Vjem9PS1VUK3JmOVo2UFJUSzdMbFBXS2I1R3pOYUplRDFlS1U0UHNxVkl4?=
 =?utf-8?B?OWVrZDhZcjdrKzQ1NEFic2s0bGcyR3JnbGZhUGxLNEZzMnZOTlVqUmtZdVZt?=
 =?utf-8?B?c0RyNC81ZFJORU9NdGdXUVZUd3Q5TC9jY3BpMS8rSnBDT2VjZFpZVk9zYXFS?=
 =?utf-8?B?ck1Zc0NkVWRPbkxtRjhDUDUvMWN6eWRicDhnQ2tobUNjK1JVNHNYaG1LRCtR?=
 =?utf-8?B?MFZoT1JjMC90eG9oOXJ2ZHFFZFZQeVNEbjNkejhNb3JVQUhLY2M2NjY2N2Qw?=
 =?utf-8?B?SmF1SEVjUWczRFhVckpOWDRtcTdiY2Z3OHk1THlPTmNtZWM0b0lxa05xVUQx?=
 =?utf-8?B?T05OWWliUXhNelk1TERRQ3B2UTI0cEQwR3NkODRHcyt5blZYYXlLc0ZUOVQx?=
 =?utf-8?B?c0YrbjVPRDFLWHV2Q2wvS291UnM0d0UyU2gzQVVjWUJGTlpxaTBsb0dIUE5G?=
 =?utf-8?B?dHIvREo3a0N2aVJEZzRDRVA5b1JUZjA0dWtHRTF6LzkvS0lZcSswQkRQeStQ?=
 =?utf-8?B?blRXT2ZuNnZIdmthQTRtNGJYbXROV2Q4Nm5aTmlqME1Ma3Y1NTVTYkUzMExp?=
 =?utf-8?B?MzVTV3NkZ1FXalYzb1dHc2dZb1B2K0FxQy9iRnZKYVFPeWZzQVRpMlpEZDJj?=
 =?utf-8?B?QVhsWCtYOGNOdlpNZ0lFaVNmL0g2THdsRUVOU3JrZG5FYStHRHdQNkZvTEll?=
 =?utf-8?B?S3o4T1d4N1p5b1FnUkVuTXRuVjdVYUxzeW1YVnBQUGtPOGNSWkFBQWJFbm1y?=
 =?utf-8?B?VTJ4cEM5VGhYL0NPRGtjY3dZeTFySm92cVhWb2tob1VWMWg2MjRQanJtVEwz?=
 =?utf-8?B?VU9NM0ZvOVJMMlZabXc2QTk5S0poQXRIRlpaT3dSM2tlWjhZTHBpRVExUVdk?=
 =?utf-8?B?bTc1eWcyZURFajBwRVpjOHEwTndwN0NvQmhpT2tjeEYzcEhNNVIwQ0RySGVt?=
 =?utf-8?B?T0pMcmpLa2ZFR2xjYWxyNEZpRCtVUnZHaU5MQTB0cVdiRDZSZWNvUm50SmNp?=
 =?utf-8?B?Q09vdEdRT25EZnBOTi9UWlpYSElLd0VGSDBJZUMvRW1nQUEwczdJck5IRmg2?=
 =?utf-8?B?U0RkMFhRUXozbzV1RDNIVFBPS3J3U0Mxb016Nk81M283SVVpelc1dkY0VWl4?=
 =?utf-8?B?MzdhYXc5Y3I5NkY5Q3JIUU5zWjVmd05LbEI5TDJaNkxqNHJGWjBCQ2hrOEdW?=
 =?utf-8?B?aUtrVlZ1QTJOUDByS1hXdTVsU0o1VzNjcWFLMEdhQVZnQVZrM2tjaldRWVYw?=
 =?utf-8?Q?/UyUvcQrIZQrLkHaOxhjsnPtC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81562157-fa28-423b-5175-08dbec40c786
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:25:17.4561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93WmiX88EEuO+UW8IbMCXilPoYKlsY7/mo0XQWpPgZGaSly8aLOpMLXiBOuRD78+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-22 17:35, Felix Kuehling wrote:
>
> On 2023-11-03 09:11, James Zhu wrote:
>> Add queue remapping to force the waves in any running
>> processes to complete a CWSR trap.
>
> Please add an explanation why this is needed.

[JZ] Even though the profiling-enabled bits is turned off, the CWSR trap 
handlers for some kernels with this process may still in running stage, 
this will

force the waves in any running processes to complete a CWSR trap, and 
make sure pc sampling is completely stopped with this process.   I will 
add it later.

>
>
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  3 +++
>>   3 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index c0e71543389a..a3f57be63f4f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct 
>> device_queue_manager *dqm)
>>       return debug_map_and_unlock(dqm);
>>   }
>>   +void remap_queue(struct device_queue_manager *dqm,
>> +                enum kfd_unmap_queues_filter filter,
>> +                uint32_t filter_param,
>> +                uint32_t grace_period)
>
> Not sure if you need the filter and grace period parameters in this 
> function. What's the point of exposing that to callers who just want 
> to trigger a CWSR? You could also change the function name to reflect 
> the purpose of the function, rather than the implementation.
[JZ] Just want to create a general function in case that used by others. 
I am fine to remove passing filter_param/grace_period
>
> Regards,
>   Felix
>
>
>> +{
>> +    dqm_lock(dqm);
>> +    if (!dqm->dev->kfd->shared_resources.enable_mes)
>> +        execute_queues_cpsch(dqm, filter, filter_param, grace_period);
>> +    dqm_unlock(dqm);
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>     static void seq_reg_dump(struct seq_file *m,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> index cf7e182588f8..f8aae3747a36 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> @@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct 
>> device_queue_manager *dqm);
>>   int debug_map_and_unlock(struct device_queue_manager *dqm);
>>   int debug_refresh_runlist(struct device_queue_manager *dqm);
>>   +void remap_queue(struct device_queue_manager *dqm,
>> +                enum kfd_unmap_queues_filter filter,
>> +                uint32_t filter_param,
>> +                uint32_t grace_period);
>> +
>>   static inline unsigned int get_sh_mem_bases_32(struct 
>> kfd_process_device *pdd)
>>   {
>>       return (pdd->lds_base >> 16) & 0xFF;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index e8f0559b618e..66670cdb813a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -24,6 +24,7 @@
>>   #include "kfd_priv.h"
>>   #include "amdgpu_amdkfd.h"
>>   #include "kfd_pc_sampling.h"
>> +#include "kfd_device_queue_manager.h"
>>     struct supported_pc_sample_info {
>>       uint32_t ip_version;
>> @@ -164,6 +165,8 @@ static int kfd_pc_sample_stop(struct 
>> kfd_process_device *pdd,
>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>> +        remap_queue(pdd->dev->dqm,
>> +            KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, 
>> USE_DEFAULT_GRACE_PERIOD);
>>             mutex_lock(&pdd->dev->pcs_data.mutex);
>> pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
