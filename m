Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA37FD5F98
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED6F10E58B;
	Wed,  8 Apr 2026 08:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hS0xiSEl";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6759710E58B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq80I+rgnH9fy2sXC+i4onz9kffk53ZKHCiftKw+h4qnVg+U6M8UCNwKMC/YF3v7mpEa/F50Y5JIJ78S5zve6YtZX5JrENMYDK+NZuCt3CZTre0kcCAtXPyjKnARRDFWaD7EMRooV9jRbYRP77u+y/+5SKrD8mz5uHvkmOZMH3rBy1N4711b5vm7RR1KZyx+/XaaKZmVsDjZsBGufG7ET4BVeDMSfvcX0IUKjH/nGmk7eq+7SRPE+c59DDQOFworonyUdua2KvDw7N9hC1sgDFLs3X2kYITFdr3InmH50TSd84rIXvUbwn1kTLnl099V4SBWRV8tHP9t83jUYMxF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P8u7b0FQuAHzkkHQapUMVVjmYy4+z7cxm8ZX6D7If8=;
 b=bO4hlLovZqmpWBIedH53FnF73Wrwz42nnJ407FNjDW7osv/Zq42zrrfs01gXvDmxEMajCapzR7PRGUJ0UGMn5vOZpXQaXs/kCUHDpleCZ74jDsjlq414BB2UjJM62cqCQcA/Zi53XVyTKs2+mx2j3ca0m00iMqZwkHxR4HyeExmAv7WTig8vzE8kNUfmuMLd6USEtMCL2UlzRS8tjP/ubE5eAiuOz3qdTPoZqjp+NTMDXMAb1cqaxLfCB+r+N5h8l2pbXBNvN9RiI/4IHExYrrXRd5W2K61p8K+20yKAeMyxbW06//LCqihNMN6HNwgpcgTiH93tkSKqFHyDUCl+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P8u7b0FQuAHzkkHQapUMVVjmYy4+z7cxm8ZX6D7If8=;
 b=hS0xiSElF8VSFCqa40Nvuljh6JMOgFHOO/3HkHuv3fW87QGCjsx7f8XHHP5RUfR/6FhswcHhCvxdH2lvO6OZpqsRZUomc/zDPncmyC5dMP50jPE1INE5bNiyLJCVLZlNRYhbTr6IWF9wdTxnnM60wjP5KtB6+G5wgOMRe1Lqk+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 08:38:38 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 08:38:38 +0000
Message-ID: <bb83b5b7-66cc-40b0-bcb7-81793df95068@amd.com>
Date: Wed, 8 Apr 2026 14:08:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] drm/amdgpu/userq: unblock signal ioctl from userq_mutex
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408083009.3328380-1-sunil.khatri@amd.com>
 <003d5670-0e77-4f09-8784-45511dfbd5a3@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <003d5670-0e77-4f09-8784-45511dfbd5a3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 224ec0a9-490d-405b-f517-08de954a3aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: GPab3XFRFc/48+g0s4XBVxruQ0PkRJHT+keGyNLp5gtTQczHnQyQ7qDGH0ETcmE6mAo0qKKJJaYR0RhKGbNU/jcQKeT2sdzk99o3OB5eJb0A+M4QCOAtgJsDk3GErImeI5GoNOofOLOWZ5i5FFfYjS/0tjLJrE9V4zKLsBa7/LgNIwHcDjqv8qy//FZ8BcOTYCPCEgbHU0X6QHDEaqQOl8e5kNX0C6L6XFqPuadyUMLIpYWxeMUGV/P6pwzueqlGlahjKHm4XlY3mbP+6IPLvSDUP5CfNtX6EmGvd8ISjnJRG+dvW/XiZpC4PDb2lkoQ1VyR2BmTUnd39+TX4qqBC5VVNsrlM9xH1DntHWgcNT2OwO0hWBqh0Qsf48U6a6/kZePKBY/ZQiUwzn73DT0dyUxpQrn5bEmCxYE/ZbTLOpjMrBb1uJ9g19tA7VOQOmly1bf5+gwy+hJWWrUacxvkfRUAu8ECtSRWAeu7g82zd57JCNt5Q8ish3OzpcfoDmDWcTI7UXzIoyd9b0e3JLWLOldz+6H/OaMhV+2+qLF3+RiDnGPte8O9jtamk40k7ytHiLknFjDPXV/DnTRDgcv8eJYLzMSa2MKOqRlgi1ktLCdy1uWxZyDBB2J/LjcMM/w8xcMcxK8Ye5oYmoR1OylZoZ++vwQ8GDjG7YXHDZ01ZRRYMiPi0VFbrzckEs4Q1ghSw6tQ+u23lB2r082mzl79c9FDLUSGxfv9kxnziLb80Rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0Q3TFMzeTQ2WUFPckpvQXhsQnFoNDFidFZWTktwbXB4cXR4WXc5Q3FIOTJB?=
 =?utf-8?B?azlKZVZ0OEtJSlp1OG5nbVg0TkNoQmsrSGRSTUs1MlVXUmpGdTZ6bitpa2J6?=
 =?utf-8?B?dkJtekNEWE5NRmN0cm1aU0VIdXgwVStzT281Y2QvajJjd3BtQm1FY0RiNWNy?=
 =?utf-8?B?OGtid1BqR1hROU1iUlFKVVREcWIyRmhKLzlkMzBVc3NralliOU5rT3A3QTcw?=
 =?utf-8?B?Q0hFNy9KeERaaUhiazJ4TTNMSWpINkJuTGdyN0ppamJSckFEMlgyK0V3d3ZE?=
 =?utf-8?B?WUVEMmUvSEw4TjJxL3hidGRKUVZkUjlUZXZkOFpXVUVMZzJXbGdSbk9zYjJY?=
 =?utf-8?B?aEtEeExMRWR6VzRpL3QzaGdFSVRBZGdzYnByVTZhL29MdkV6T3BteENNTXNN?=
 =?utf-8?B?blRHa2JZM2JUYy9jOVRPaTBTc0dlODBlUkZNT1JyZkhuL202dStuQ1RUNXhq?=
 =?utf-8?B?akxOemx6TnFiQWFSazRDNXlCOE9BSnJGVk1yK3Y4NzF6Ui9LMjVCb2p2aDVl?=
 =?utf-8?B?eW00ckVSWlNqcDJFZXRPQzhwT1B6Z1NlV2RPYVh1Sk04MWZ1eXRVMVJOblpn?=
 =?utf-8?B?SWh0RGRNY2hqVk1odnJVOEdKQ2VQRzJNZzV0M2VZZ3QzcHUzbWdmeU1ISHd3?=
 =?utf-8?B?NE53WWFoeWdDUURDY1dtdWJOTUxrdTRaQkZaQmxWcEpBSVVIREsyTlZvSnlu?=
 =?utf-8?B?djUyV0VXSlZGZ002bjJWNEdNNFg5QmZXR0dWdVdCRmIwVnFUS01oT1JsK25K?=
 =?utf-8?B?U05raUNPYVZXZ0lCTS9UanB5Njd2ZGFRTlVBL0JDTjlFWlRtaGw2djgraURy?=
 =?utf-8?B?ZXRmR2JuTlRWWmkyNUpUdGJmemlpUGFHVkhvNjZTaHA4K1N1UkZIMk1vTHE4?=
 =?utf-8?B?ZGJuclBiMS9jcU9wUEZpK2FRNEdUY3lJcEw1bHVUcUFOT3EwcDhVUHh6T1JY?=
 =?utf-8?B?dkxQN1lhbHkzN0ZNRmlTVk5sd1VQRHdsd1BDU2g3eG1HbVh6NGI4M3pvNnk4?=
 =?utf-8?B?dEV5c0gxN09ReHR6UWpKZEhuMlFJUzlPNEJyVVh2YUsyOHJnaEdrWjlVVTVl?=
 =?utf-8?B?YitPb3lHOElBWnZYaWVaek45K3JrN2pYR05YT1BTaWt0cExYYlN3YWp5UEs2?=
 =?utf-8?B?aDdFZHVrSlZWMU4vOWVFTS9kQWhHTHU1WmdCSnlsNEZjbUtyZWVya05vV1l3?=
 =?utf-8?B?RU1wTzk5cHg4eEEzejJWRUNWazZKUGVIV3JDSTNFemcrMTlVSWwrTElqc1NX?=
 =?utf-8?B?NGJRS2hXWE1oZkFkMUdQN3ZUZWVWL0xjRG00ZFVmdVRUdW15V2xDZkFrRFls?=
 =?utf-8?B?WG45eWVvelhLQUZsY0NFRXpRMFQwbFhtbldsUmkxNWlZNVE4SEtxTFY1alRW?=
 =?utf-8?B?czVpM1hjenVrQ2Y2YzE2c1BYcjY4ckRwWndaZFJvb2paYVhPZkNQdDBWdHpa?=
 =?utf-8?B?YTN1cjdQR05YdWVLYkhPb2h2YzMwMnQxeHZ3a0JBcElxdmplVDNjeDFiRDY4?=
 =?utf-8?B?ZVAzNHBOY3RVcmFqemNIdm9uQTdaR1g3ZC9xZnI3bENtR1VkNHB6QmszcCtk?=
 =?utf-8?B?UmhvY3o0NkJvMEkvVG5SSDZhOGRSUGg5NTdPczR0TmIxS1hTWlRySXJGU0hT?=
 =?utf-8?B?YzhMTDlGOFMwSERrUkppSkR1MHlPd3ZFU1h6anBZNEVmVEg1eEUzTnlrcEVB?=
 =?utf-8?B?ZUFHMmV1cURXRWE0OHRmdG85YnhEbXRCMGF0a0M5aEo2K2Erb0xobTZyeFRr?=
 =?utf-8?B?eWlaa0NNZUg5eG1wTzFmcVg2Y0tidUlCYkltcktia2pPZGpuOHpGZUVDUVNo?=
 =?utf-8?B?cFhnOXErSHd1dXBObUZGSkh0S2JETURvdGNCbER1dXZCSDl1NU9BY3RsUHlI?=
 =?utf-8?B?dFhpYTQrOFI2V2c4bUdJTjhCTU1xcmhYVHFlUVdQMElGcjl3V0xpVkZ0alIv?=
 =?utf-8?B?Ui9LQS9ZMW9JZEpnRFV2ZG5LaVRrVmVaR3RScndHMk5ZbWNyM3ZLWGoyQWQx?=
 =?utf-8?B?TDgvRTNlVExPNTlBQmlNNjIwRFcrc2ZkTjZRdkxwODZkeXJXSW9sSjNIYkdG?=
 =?utf-8?B?aW4yTUhLOWpPSHhqYmlFY1hTcDFJTTlkTlM3L1NVUnJYMG1hVmN5SzkreS91?=
 =?utf-8?B?SDVuMDlNbVZjeWxuVVBiTHl0YVJxc3RVaHNKaGMzMldYTVp6Ukdjc1RROHJH?=
 =?utf-8?B?djUveVpQZ0trOTJRdGRGcDRzZEJtTTJ3bGlWVHVaTWpHSWlGN2RBaWFxYUUy?=
 =?utf-8?B?dEk3TVlCR2RleFdJSStPTjkveTFDa1ZteVQxUE9DL2FiUmdjWVVEMlJDSWcw?=
 =?utf-8?B?cjUxQ2RGelpOWENkMXQyYWdiZVBnSzhMSlQydnBONEc3Y0tQK2hjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ec0a9-490d-405b-f517-08de954a3aca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:38:38.3044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vipjMVwkOIxNx/SnGMqxBUrQ1kevC1GyFDTRXdkyF+3RCcTcFrJDrPoUM8ocJ7Vzdhvmfvid8zMmmTcBdTsng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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


On 08-04-2026 02:02 pm, Christian König wrote:
> On 4/8/26 10:30, Sunil Khatri wrote:
>> Signal ioctl does not depend on eviction fence and neither it
>> needs to hold userq_mutex as we just wait for userq fences
>> to be signalled before we go to suspend state in hardware
>> and we prempt and unmap the queues.
>>
>> This unblocks other thread which hold userq_mutex to go on
>> without breaking the code.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 38 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 18 ---------
>>   2 files changed, 38 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index 5ae477c49a53..53f0bf6b3ca0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -54,6 +54,41 @@ static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
>>   	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
>>   };
>>   
>> +static void
>> +amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +	struct amdgpu_usermode_queue *queue;
>> +	unsigned long queue_id = 0;
>> +	struct dma_fence *f;
>> +
>> +	for (;;) {
>> +		xa_lock(&uq_mgr->userq_xa);
>> +		queue = xa_find(&uq_mgr->userq_xa, &queue_id, ULONG_MAX,
>> +				XA_PRESENT);
>> +		if (!queue) {
>> +			xa_unlock(&uq_mgr->userq_xa);
>> +			break;
>> +		}
>> +
>> +		kref_get(&queue->refcount);
>> +		xa_unlock(&uq_mgr->userq_xa);
>> +
>> +		mutex_lock(&uq_mgr->userq_mutex);
>> +		f = dma_fence_get(queue->last_fence);
>> +		mutex_unlock(&uq_mgr->userq_mutex);
>> +		if (!f) {
>> +			amdgpu_userq_put(queue);
>> +			queue_id++;
>> +			continue;
>> +		}
>> +
>> +		dma_fence_wait(f, false);
> That doesn't looks correct to me. We need to hold the userq_mutex while waiting for this fence to make sure that userspace doesn't installs a new one.
>
> I've already pointed that out on teams.
Ok in that case dma_fence_wait will remain with userq_mutex. Got it.

Thanks
Sunil Khatri
>
> Regards,
> Christian.
>
>> +		dma_fence_put(f);
>> +		amdgpu_userq_put(queue);
>> +		queue_id++;
>> +	}
>> +}
>> +
>>   static void
>>   amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>   {
>> @@ -66,6 +101,9 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>   	struct dma_fence *ev_fence;
>>   	bool cookie;
>>   
>> +	/* Wait for any pending userqueue fence work to finish */
>> +	amdgpu_userq_wait_for_signal(uq_mgr);
>> +
>>   	mutex_lock(&uq_mgr->userq_mutex);
>>   
>>   	/*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index c4e92113b557..1e8c08b63f65 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1269,27 +1269,9 @@ void amdgpu_userq_reset_work(struct work_struct *work)
>>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>>   }
>>   
>> -static void
>> -amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>> -{
>> -	struct amdgpu_usermode_queue *queue;
>> -	unsigned long queue_id;
>> -
>> -	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> -		struct dma_fence *f = queue->last_fence;
>> -
>> -		if (!f)
>> -			continue;
>> -
>> -		dma_fence_wait(f, false);
>> -	}
>> -}
>> -
>>   void
>>   amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>>   {
>> -	/* Wait for any pending userqueue fence work to finish */
>> -	amdgpu_userq_wait_for_signal(uq_mgr);
>>   	amdgpu_userq_evict_all(uq_mgr);
>>   }
>>   
