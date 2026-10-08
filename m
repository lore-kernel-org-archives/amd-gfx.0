Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9990FCA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 15:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C1210E0E9;
	Thu,  8 Oct 2026 15:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYOCvI15";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A5510FA99
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 15:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+1rs8gQMz6sSmxP/MbwFQxJPUyJ6VjnHrsiI+pFD+mUN1l7XRUUzDMXpP4ADcN8v411daDm3jRsrAXCt1uKT+y4Bp/s9UTxO1F88AmiO3Z7OGO0TSIH0OrTJZXEVGlrqIcUR3RSD5dMVasTVqKTUyzAAsMWhLxxhrYcaLyMvevDeY3v3f9kJAitj3/dqFT4dhfjGmT/+pn2h6J4K439sYT+8XJfQOzLrtAXFa73EcXovynlNhpCaAHMdemorgh/QCmnZ0sAR1VPUZ/Ij5euGBEUZHX83JeNl0/t9gt4UgeXkZqNbMC+qbXTfJVWxXa0rR7EXko+T6ejj4a4FXtInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgUqaJbft6Yyf13P9DosDSdv/r86b4ElvvSKUJzEbBM=;
 b=xcmpPCWukdZTjd+O3kpX3GYDckyl2a3nFioq/ktuhtVq4uYWpYG0I0G6kKS3mIWb6cWhcCnFIQmtovStQ2Wl7MaRPfx05Q7Gcde48wzhpXddy+FF6zcKCLFnrCvObCJ5N6y154Gx40pTsi7UbfCJ1RsppNhrC+3e7oubq981L50XvbgGLU1DryDuYLsUq8mKicyITiKtephXQvLDvoULQYUhEa6KtJnlu2vrvJREknt8vjPeyk6+lBL1oIbs/idgTmIe9/AaAJ7UVrkRzWwBvFMBqG+lVLfFLrY931lVyB9xMFcmtbMDF0jpDpRPGWaX52lmov/PH1tpOF0AUSxafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgUqaJbft6Yyf13P9DosDSdv/r86b4ElvvSKUJzEbBM=;
 b=gYOCvI150Am/P0aiyGO/biQ3ieoiYaWgYd1jPRsepuOXm6MjmIRXe6RiNJHzMCLN/k3Z7mONfk6YB7ORNWxni74dXQmj/DIjaiirUbofaJqHylyjedFOUgNcHjJf110egeSuhQvCwpJYPM8qdEBN4ZgaofXkbY8jrq0K2g2qox4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM6PR12MB4234.namprd12.prod.outlook.com
 (2603:10b6:5:213::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 15:58:24 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 15:58:24 +0000
Message-ID: <3d43d8fb-0cd6-49d3-a64e-dbbc160a7c62@amd.com>
Date: Thu, 8 Oct 2026 11:58:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: preempt KFD queues before taking the reset
 domain lock
From: "Kuehling, Felix" <felix.kuehling@amd.com>
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: kent.russell@amd.com, Harish.Kasiviswanathan@amd.com
References: <20261008140045.1283288-1-William.Palacek@amd.com>
 <87e18cc7-2382-4440-96bc-605dc0828ab6@amd.com>
Content-Language: en-US
In-Reply-To: <87e18cc7-2382-4440-96bc-605dc0828ab6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::6) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d9d0a7-0fd6-4f9c-0a1e-08df2554fbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: lN8JH5TpPwAYdh/JH3CYKkYE95X3mIRU/zSKPzXyP0IoJ5xDQI4KtruNEo/rvbYXvljd7WwfAKcyeqVwahCUCvFmU1ozhAMZESuQ3iOzh4k6ibBxK4SULiLCrVAPX/ZD8zWpkbI70pkUjTraw36KOX5uZ3QGRnkVnny603Hb7CDMn3Yg1GFV1fjUbmyzN/tGmufvJwCKH88nPogxYY0E+2jfnf+Hb+RMejhoZrbA0dLm73VFjsmTkryrH6GIUOoqlv26UUhANChNjeij8tbg3N7CI1X47iKeO87lLh2Hvdap+eU9uoA38uqB3s0TwevNfrja+QVX63LRjbRKgbuQT9SAE0Bb8OYbgPxoAQq1/2poGvVGwG5dwyQd/dzLRdpfPcUuR0S8x8MRSYNAGOl/7PmtrFvBhKcLhCLQ/GFhiZSTB0Ew0gyOcyiMtV+OEqMs2gVM+UG8VQ51h9PULqDOnZxLoB4cloT5r2LVW7tVsyrXvgepyTeLjZonc0qnWiiL0OW3GPBcbZmVs3IuMnsFZNCRHh2ia4aqrXcm0IZWnChzeBK42tyl2WiXSLBHGA2T5QdfZa1fyUDv4y6kzCdi39SckoX5Yx6t8be4OEljQ4m/b4ymlscMTNkjcdvbU814l/yD8e5v1/7ER5yoZQhbLbG3gHTu9nMSX8MWg6wUvj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkR0MmVUOEE5SmhNdXB0RGhqcDg3UmpKMVlOSXZNckdvV2xxZjFxTWQvditj?=
 =?utf-8?B?Nk5CQlFyb015a0J6bUJyU2xoci8yckk3VVozZW5BU0o2QlRUdCtid2hSZ0NC?=
 =?utf-8?B?L3F4YTlrV0hHWDg1V0xka05GUVBLRnI2UzdIVlBWVUQzMXFzTEEwMmVtVi9B?=
 =?utf-8?B?R1o2UHdsMEUxeTVXOGdQbURNdkk2L0FCWkE3TkwzZDVnbkY0QVdKWXdHdTlz?=
 =?utf-8?B?emw0cHF0VGRtYUtTSlRocFVkRTdiRGVrdjdwcFUycGgvaEZGckV0dnNhekJi?=
 =?utf-8?B?QjdCZVNSUE9naWlMR1hFTzJOMGtJNEVCbUgxZVBvUE90VEE3VUlLS0xuV1RR?=
 =?utf-8?B?K053Qk05YlplVjFPSDhkTFhXbmRENVRHLzRUSkN3amYzemxrY3JSWDlOcTl3?=
 =?utf-8?B?VFBrSzR1Ni9YVkdqMmwrM3A0cGRQYUVoT000NlhmbXFYbXBINFNJb2NRV2pX?=
 =?utf-8?B?TlhmWnprQVdLTkxjc1pQS09WdnROSEZIQitSTDdMcTdSRmtsemxhNnpSTnRB?=
 =?utf-8?B?aVhqWXhpS20yVkoyeXVpcGpScHpRZFViZnZXNHRqVWxEaTB0ZGlqNEVxd3lG?=
 =?utf-8?B?NkROVm1rdHlFUzc5UVRJLzVWNUh4RFJOMTdsWnlqV3NjTmdSY3pJaXU4RTVt?=
 =?utf-8?B?TUJ5bDdUMVRIM0Jnc3padVY2RVdkMWdaRFRYenNDVitBSTVCVDQ3M2VjOFl1?=
 =?utf-8?B?UUxJaFlNNC9DMW1na0lkUWRjeW1tR2hlMmVVRG0yVWcvUUQ3NGVSdzQ2UnB3?=
 =?utf-8?B?aTU5eDBiWWlmQmxuZ2FTOFNmVm1FS1JYL0ZERUg0eG9Sb2ozRnVKT0kvc1NB?=
 =?utf-8?B?UHpKaWRMTEt1L2ZaNlZFcTZKZGV2cEh2K2E0d2tqMWxBQm8zdUErbGRLNS9P?=
 =?utf-8?B?RTJSR0UzNnJ4SWtZYSt2Tk9XdTJiR1oyZWpSSjVZTVByT1lXM09XK2g2M3RY?=
 =?utf-8?B?dW5MSDc1aGVFa1pnRkhVMXBXMHR0UnZzaUpGcENjYmxQSUk3aEdaMzM2SEh1?=
 =?utf-8?B?cXpxa3QwaGVjVWZGaUsxS3pDWmU0SHNoc3FEcXRxMURjZjcvVkg1ZWVMcVZG?=
 =?utf-8?B?K3EyOUQrNGtQU0NuanpHY1Iwd1BtTUJ0d0ZJYjhSVlJROUQ1QnVuM2YyN2FU?=
 =?utf-8?B?c3JDWCtUdnpXZ0dkN25Zc01TSUp6QjRxaTA1Rm9LdXUxcEFTUkdNRVd6MlhW?=
 =?utf-8?B?YllLeVZIcGg4YWpYclh0cU9LS0pyUEl6YXNjU2NjV05HK1MrOUJGdmkzdHh4?=
 =?utf-8?B?UnBTdjJqNVVMczloenJXSlc5NmhhVEtPZEZOaFo0ZXlzR016YWM0RnRENmty?=
 =?utf-8?B?MW5sY1hCVGUvaXZWS29JRU5DNFVTTUV6bEdXaGcyTHdGdldNQkdJVTRCR00w?=
 =?utf-8?B?ZjBpeFNXUXFUeU5RTmMxZlFiNnlVN1ZydzBKNFd2b2FuVHlnM28ycU9icXpi?=
 =?utf-8?B?SURjK2hxUWhiZjBaajlRQU9ZMjZrTXd5cklLbG5FT05XZ2JOM1JzTFBrMnRa?=
 =?utf-8?B?UE5JbzN4R3I1b3J3QjFybVh5TUtlejdqR2oyQ3RNMFZNTmpmNlNWcDFyMzFR?=
 =?utf-8?B?MGRVREM0eXlTTTdVaERTc3JzYUFsZENaekUrdnpBT0lHcGJRK25OTmYyRVRO?=
 =?utf-8?B?Vi8rZU5xU3R4Vll2SzFFV29lYnVjQzZVV05md2JWYTYyYkMwdmxia3hUU3Vu?=
 =?utf-8?B?SmxhQ1hxOWROQWl3bzViUlIxSnlKUEpNTTVYdFdQTi9wYUUyRGttWGxKTE4y?=
 =?utf-8?B?ZzlzN1YvdEErSThHWXVVSEowOFlOZzZ6VkozWldNV1hGL0J2MG1Qb055amZM?=
 =?utf-8?B?ejhRWGpRV0E5bDhscFAyRDREV0pLUXdRTm1xVmJvZWN2TzhnWHNmMzJrTWQx?=
 =?utf-8?B?R1Z5aVpkY01XOVFaSWdJTmpiZUdibmdSVnVHRDRmUnVtUHg3ajhFUGQyRGVp?=
 =?utf-8?B?SC9mK1JhSTgxZHNYc1pLWUNIUXBtem9CaE93dmZLK0VmVE40c1R6cCt5TVpZ?=
 =?utf-8?B?d1BkNXFOdGlraWlZc3BJdmJwaUZLdWxoK1hVTGdQM2lmZlp5ZVIvRGFGaWF2?=
 =?utf-8?B?R0kzWTFzaXJKdkdISHRZL1JTWDJHUEQrMGV5S1JGT3h0aXlLeWNsWEoyRzRn?=
 =?utf-8?B?czlWVHBIZ2gwWXFpbk0wMGg2VXZOS0F3V3h4cW9mazhqK2xDeTBxK25OY1J1?=
 =?utf-8?B?MFo4aHVLUkVycjV3d3hGZWdPNXZLaXMzQ25xbGNCRDJ0a2VwSHdNT0t1UTlP?=
 =?utf-8?B?QVV6WE1jdDFJbStBaHlxRStmTzJocXEySTBHeTNIWk5pcWFtcGpFN3phR0RH?=
 =?utf-8?B?VDVadlY0bmNlaHh3M0xNd1RHaGlNK2xKWEdIV2R5bmFoODdpOHFmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d9d0a7-0fd6-4f9c-0a1e-08df2554fbe3
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:58:24.4734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX5fkpuB3Hn0omMBEYU2JVSTxbz/mTM/B3y/FyCvnv3p6gh685ss487fI0o7/o0w0CdyGDSmyj4vcY8NsaiVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

[+Christian for comments on reset architecture]

On 2026-10-08 11:46, Kuehling, Felix wrote:
>
> On 2026-10-08 10:00, William Palacek wrote:
>> A GPU reset issued while processes are using the device can Oops the
>> host in munmap() (free_swap_cache) after SDMA write faults from a user
>> queue whose process has already exited.
>>
>> amdgpu_device_gpu_recover() takes reset_domain->sem for write before
>> amdgpu_amdkfd_pre_reset(), so the down_read_trylock() in
>> unmap_queues_cpsch() and execute_queues_cpsch() fails with -EIO and no
>> unmap is sent. stop_cpsch() still clears sched_running, so user queues
>> keep running while their memory is freed.
>
> There is a general assumption that the GPU is stuck when we're in a 
> GPU reset. It seems in your scenario, the GPU is not entirely stuck. 
> So you can still get interrupts from the GPU. At the same time, you 
> can't rely on MES or HWS to unmap queues when the GPU is in a 
> half-broken state. So while your patch may help in this special case, 
> there could be other cases where you can't reliably stop the GPU from 
> sending spurious interrupts while a reset is in progress.
>
> Maybe we need something in the interrupt handler to ignore interrupts 
> while a GPU reset is in progress.

It's also possible that there are still interrupts pending in the IH 
ring when a reset starts that won't get processed until later. Do we 
drain or discard pending IRQs before starting a reset?

Regards,
    Felix


>
>
>>
>> Call amdgpu_amdkfd_pre_reset() before the lock, for gpu_recover and PCI
>> error handling. Skip the dequeue when the HWS is hung or the PCI link is
>> down, so recovery does not wait out the preemption timeout.
>>
>> Signed-off-by: William Palacek <William.Palacek@amd.com>
>> ---
>>
>> Notes:
>>      v2:
>>      - Drop the SRC_USER gate and the helper; run for every reset source
>>      - Cover amdgpu_pci_error_detected() as well as gpu_recover()
>>      - Skip the dequeue when the HWS is hung or the PCI link is down
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 16 ++++++++++++++--
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 14 ++++++++++++++
>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e0014611f039..8ae6228dbf31 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5479,6 +5479,16 @@ static void 
>> amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>>       }
>>   }
>>   +/* Dequeueing needs reset_domain->sem for read, so run before it 
>> is write-locked */
>> +static void amdgpu_device_kfd_pre_reset(struct amdgpu_reset_context 
>> *reset_context,
>> +                    struct list_head *device_list)
>
> Instead of adding a new function with a confusingly similar name, 
> should we change the signature of amdgpu_amdkfd_pre_reset to accept a 
> device-list instead?
>
>
>> +{
>> +    struct amdgpu_device *tmp_adev;
>> +
>> +    list_for_each_entry(tmp_adev, device_list, reset_list)
>> +        amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>> +}
>> +
>>   static void amdgpu_device_recovery_get_reset_lock(struct 
>> amdgpu_device *adev,
>>                             struct list_head *device_list)
>>   {
>> @@ -5534,8 +5544,6 @@ static void 
>> amdgpu_device_halt_activities(struct amdgpu_device *adev,
>> cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>>   -        amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>> -
>>           /*
>>            * Mark these ASICs to be reset as untracked first
>>            * And add them back after reset completed
>> @@ -5784,6 +5792,9 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>       /* Cannot be called after locking reset domain */
>>       amdgpu_ras_pre_reset(adev, &device_list);
>>   +    /* Cannot be called after locking reset domain either */
>> +    amdgpu_device_kfd_pre_reset(reset_context, &device_list);
>> +
>>       /* We need to lock reset domain only once both for XGMI and 
>> single device */
>>       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>   @@ -6232,6 +6243,7 @@ pci_ers_result_t 
>> amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>           INIT_LIST_HEAD(&device_list);
>>             amdgpu_device_recovery_prepare(adev, &device_list, hive);
>> +        amdgpu_device_kfd_pre_reset(&reset_context, &device_list);
>>           amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>           amdgpu_device_halt_activities(adev, NULL, &reset_context, 
>> &device_list,
>>                             hive, false);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 5e57576fba21..988fce11a4fb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -81,6 +81,16 @@ static void set_queue_as_reset(struct 
>> device_queue_manager *dqm, struct queue *q
>>                      struct qcm_process_device *qpd, bool verbose);
>>   static int reset_queues_mes(struct device_queue_manager *dqm, 
>> struct queue *q);
>>   +/*
>> + * A dead HWS or an offline PCI link cannot service a dequeue 
>> request. Skip it
>> + * rather than wait out queue_preemption_timeout_ms per node.
>> + */
>> +static inline bool kfd_dqm_can_reach_hw(struct device_queue_manager 
>> *dqm)
>> +{
>> +    return !dqm->is_hws_hang &&
>> +           dqm->dev->adev->pci_channel_state == pci_channel_io_normal;
>
> Is pci_channel_state always valid? I notice that pci_channel_io_normal 
> is 1. pci_channel_state is only set in amdgpu_pci_error_detected. If 
> that never gets called, pci_channel_state is probably 0-initialized 
> and this condition will never be true.
>
> I'm a bit cautious about spreading different versions of "is the GPU 
> usable" throughout the code. There are lots of things you could look 
> at. I've seen different conditions related to GPU hot-unplug in 
> another patch I'm reviewing. These kinds of conditions should be 
> managed carefully, otherwise we end up with subtly different or broken 
> conditions all over the place and it will be a mess to fix later. Or 
> the the code becomes unmaintainable if the conditions need to change, 
> because now you have to change it in 15 different places.
>
>
>> +}
>> +
>>   static inline
>>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type 
>> type)
>>   {
>> @@ -314,6 +324,8 @@ static int 
>> remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>>         if (!dqm->sched_running || dqm->sched_halt)
>>           return 0;
>> +    if (!kfd_dqm_can_reach_hw(dqm))
>> +        return 0;
>
> Why does this return 0 and not -EIO? Isn't this logically the same as 
> the next condition? We don't talk to MES because the GPU is hanging 
> and a reset in progress.
>
>
>>       if (!down_read_trylock(&adev->reset_domain->sem))
>>           return -EIO;
>>   @@ -2832,6 +2844,8 @@ static int unmap_queues_cpsch(struct 
>> device_queue_manager *dqm,
>>         if (!dqm->sched_running)
>>           return 0;
>> +    if (!kfd_dqm_can_reach_hw(dqm))
>> +        return 0;
>
> Same question as above.
>
> Regards,
>   Felix
>
>
>>       if (!dqm->active_runlist)
>>           return 0;
>>       if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
