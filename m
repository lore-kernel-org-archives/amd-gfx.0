Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49174C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 16:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD0B10F3B9;
	Thu, 13 Aug 2026 16:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mi17nIiO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5123D10F3B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 16:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epud5kujTx2a8EMMjXw3a4MTfexvKyHcnLuLdLj9w4MLJrdy32IZkgzp1M7PoN46jzaOnDjoYmAsQUzYPTD7PjS5sUvFXsROnw0PFeg/kRzO24geWTXpzH9L2ZF+tHfnjpLrUzb5ECmZA4UYUQF6a5PaHxhMQZei+/tH2sawD8wkjEPVgIavKdA9Z70PsZKLBisC5aTdxkXKMg8auzx3MAsBx4xrFoAeotku3ElPe52L526OMSxPl4Rd/ENfZjOxUm4TYFMmo3aTBKQkFaIJ4Nid18CdOaAdEZFo8xw7B9EAGd2krb8cvi8ymIEhABKza4TJgeCkkIpNnZ/gsisf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUoVoLK+Y55GwQuyC3gT15pZQ1D1CGdLzh84VuX2Pts=;
 b=hk7c7rgQucJPrrX2shqi1aastdE/cCQOdeIxiiH3jSLPza9Jj00cUYWA4f8eki48hnZ/KzXH9mKUm0NMOoR0mIokoOUjQ1IRMrd92xhPByD35JqL2BzYkatjQkN6HmMkIoKo/cF3ScqbDboJPps/q9u/i8FHLdkEiNEsx+1bH8mDa1U8w72oTgDI7w6m/wf6KqAXZe6Ap17oXgBFKrYhsCoBZEQZ/kTXi+RMl2OzYoTPTPy/Y/ZkljpBQIAgouH5tgufl7WeMuogJiSQ03NpvVEpYnh9t1itop7EtdU2G8/DXvjOoSfT/XszM00YeCBxZA6EPpLxO8Qbc/FQNUwaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUoVoLK+Y55GwQuyC3gT15pZQ1D1CGdLzh84VuX2Pts=;
 b=Mi17nIiO0Ri+rYRqBzPS+/VdtgjJB6deCgTfbLTM9POBmGA11vrqswUM95mEm84SVgYgfBLTRrTcteFhkIFZzxGsN17e9+Lk/WwuUtcSQah+ul/eqwR13Y0qS0nkyae9PF/rPnEs8M92q6XuBibXYhXUVNi5p1lCH/v/7kiAyxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by SA1PR12MB7128.namprd12.prod.outlook.com
 (2603:10b6:806:29c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:05:03 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 16:05:03 +0000
Content-Type: multipart/alternative;
 boundary="------------eK0Dow7EwDGbc6qSurJrujru"
Message-ID: <02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com>
Date: Thu, 13 Aug 2026 12:05:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: allow profiler process reenter
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260806084312.79422-1-lingshan.zhu@amd.com>
 <CH2PR12MB94573C6D5DD3480E33E6463F8CDC2@CH2PR12MB9457.namprd12.prod.outlook.com>
 <3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com>
 <be92ca16-443a-478d-96dc-c83318df3670@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <be92ca16-443a-478d-96dc-c83318df3670@amd.com>
X-ClientProxiedBy: YT4PR01CA0443.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::15) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: a021b1ce-12d7-447b-07da-08def954a285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: GPk4hjYPTBdLJ4oVQs5HuW2PV+N9byjnlRslV4Yw1SU7CoeRQjChDIk+NcfbKHsBPRRMLrs1lFfsdtvSOhLUZdlXqR8x1rhnA7WJcXplN43zJ6K+fMcwDc6wAHPBWg3dqLJz06tLbxbensUHEGGVP/9hGPUCoLqXN/bY8aOVeONDs3XvZmNjy5uQNoN7U3X5x05rm9h9ajpdGsI4AWKsX5/qC7OcHSUK+7705j53N+WKjRh/gE8C0lm/LbG+hoiRAmCAr2CG9+MBbLUJ9HNzVeCI5V1kxJZBoZCaTqC2c6le21I/3NUQ6AtQTNDadzK3vlSlpoBKXQ/PqYzlWIFz+Q7zoNSA0K4j0bLujI7moTvk27/3LIP+itRHvPSAq1iZ9Ny9U+nO16qdNsPQauEeNxuBMlRSdlDmvqD5FCVuzh1ybRtgKdJHzfCbqM+elACe2KQ3k7cebIORu7YgkvK65xwvojDONQiDgBKpl2bOfn4O15jLGG3jjV464TbxfNjPu3HcJM2G6KdXMzt7sUwYP6iFNm4nY+xgwXgw0zCFJbrNFloa8YDSiRPuPfCgWiHjPPutDC3B3znB1ADynXh/FdanpU/4q8BFQxDxqwbheeLcPgganVue0fR9c4m4yCnmCxRS3bE+RQzIBaiR9Caoth1W4GDjmSkEeSiL1A6eYj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2duUWhBWjRmaC9nR2pBVHB6L1gvekpVRmE3a3ZJUE84QmtIRjJyTVZ0TFYz?=
 =?utf-8?B?aTZXWHVJYit6bXdsaTAxbGZMdXIrM1phTjRkaENxeFVXbkxtczIxNzZxeXZy?=
 =?utf-8?B?NFd1NUQrQjRHUWVCSzdYUEs3RGl6d3RoaGwvdWt4Qm1hM0pWOHllOWZvY25u?=
 =?utf-8?B?bUdvWk5RcE52TUtJZC9keFZMYTRjL0RLcVB4bERhVjJjTmdmV1k4NzBBMlBt?=
 =?utf-8?B?eFBFS3ZSS2pmME9pN3ZTVUh5dzdKcllzT2FwZS81dUgzV1ZuNEhRSWY4MWtG?=
 =?utf-8?B?OGVmYXRaSWxxelJ1RGxOZHlCRmtkcVJ6YUN4MEd5cm9GOVdsV2kxUTNCbXlC?=
 =?utf-8?B?NCtSNFJUS1VLd0V2SWFYOFRTVG9Fcy81Z0haekVkWGxuUFpkYkNJeGU2em5q?=
 =?utf-8?B?NHVNVG5wNU95aXhadTZnR0NDMWx1MUJuWFQvUFovYTY5YVpnTnFyR2FWUkhi?=
 =?utf-8?B?L2ZQZTkzakZXMk1ETDNyNENpS2NySnR3LzlMUzd6d0VFMnI4WWRhamhsaTZ4?=
 =?utf-8?B?Y1hMYjErRnFGMDkzcXJkUHFLRmh3Q0ZjM3VBdThQQXppd0F2Y1huWWV4YnZP?=
 =?utf-8?B?QlJDRzF5Ym1VdGpqczk3cWJUZ0ZieG1tNWZLa2VRQ05Uc0QvTWtKeUpOSEx4?=
 =?utf-8?B?STRSNkRFRE5WaVZ1dkxZV2NiN1hXN2hQUTBITXo3SFBacXI5WTNMU0lMbFk0?=
 =?utf-8?B?eVBpbi9EMThWalZVVE81bjNlQXFndUdwLzBaOEJ5RjAydXUvb1lJcnplMGk2?=
 =?utf-8?B?dnJHb2xtQjNObTIvZWpLb1NBUnp6Skd5VTdySGJkNlpVTXVzZTlHQ0tOU1Ax?=
 =?utf-8?B?NWc5ZGR5OTFUQWFMMFVuUFU5R0RzWlBqVlpFcXF2Z0VjamFQOHBSODdPbUJW?=
 =?utf-8?B?dlVJaWVQaUM4YUF2QkJESDZlaGYybjUyVktIT2tFWFQ3RnFZTkJONjhVdVlI?=
 =?utf-8?B?NmVNSnIrVHdOdlN3UjN2Tkh1cDdMQ1dkMTh5SVlSMWUxRkxGVjJYdXJ4T2Ri?=
 =?utf-8?B?cTFTVzJEeHZBYkczTWhDcWJ0b2V5ZDBoazlDRG1oaTFEdnJYWWljb3RvT0RY?=
 =?utf-8?B?NmFaeVBNUjY0eStGekIrNzRZRWdCN2V0Y2dnZnBjc0k4akt2M3FNaEoybENS?=
 =?utf-8?B?Tkg2MDNmbWMxOXF5RVVSUVo2dW83cXBXeHNnanNycHRJSTFyQVBlUkk3RFcv?=
 =?utf-8?B?N2FLQmM1citPdWdJcFFlc0xsR01QK3dLN0sxUVB0c3hsYVpucUVpRVEyQzNh?=
 =?utf-8?B?WVNOTDk2UE5heXlZa0hsbk9lb2NOSHAyVy9jTERXRjVEUFZJWFBxdkxQalJQ?=
 =?utf-8?B?RURwL3orNmtCdEV3SFlvdlByb2YrNElCdnlvVElxUjFQZWh2TDdGYkpyaTlv?=
 =?utf-8?B?ZVVPZTdrL1dlaUpsYnd3SEk0R05td2gyWGtzbmlvaVNSNGxEUEtnLzhFK2RR?=
 =?utf-8?B?QkRHOEFQcWNmTlM2OEw1UlVvaHBNM3o2dEE1elUvNlZINWVFYmtDcWdQV3kx?=
 =?utf-8?B?ckU3RzZyUlZNN1EveDBYS2h6dC9iL0wzbitUR290VXNqbVA2MWoxV2hWRzBC?=
 =?utf-8?B?ejZabjEvNUZrTHZ3Z1ROK3ErSGxNTlZxZnFJaU1hblVDWTdJam9LQlR6OSt6?=
 =?utf-8?B?NW5LbThHOW5tSFZLVC9LN2ZONk9oUnhSaGF6Rk1mRW5QcDc1R2hBNmVnSU5y?=
 =?utf-8?B?VDVGdFByWFpwajdsTEdaZEdtWURFL1l5cDh2a2JQSXdMN0o4dWVFdHlPWXRt?=
 =?utf-8?B?OVBmMXdjNlQvb2hsVHhrb0lSNWlzS3plZWJkeUljU2FlOTJzL0tSeEFCV1JB?=
 =?utf-8?B?RENZRUdveFY1aForSlRqRDNYQXpGQ3V1U0VDczVTTGRYTi9GY0RlYVo3RDBI?=
 =?utf-8?B?c1dFb2M1SjMxc3hPY3NnS3Z2NVFqRFRXNXU4dEFraEprL1ZKNlFtTXlzTjhE?=
 =?utf-8?B?RkxNRWRUQ3ZMcmJEdFhGalFkZlRGdHZGZ3NZN2I4SVlRY0ZEdGUzMndCNVZs?=
 =?utf-8?B?OXNQaWpRYmE3WXNOblhqR2xBVkJ6cTNzUFBwUTJFVE1OeElnTlREdVdMY2pw?=
 =?utf-8?B?N3BGZXFaZFpQRFBSb3dnbEZxU2htRDN6V1dzN1poYysvcEltSVZIZ0lvb0tR?=
 =?utf-8?B?aWFQemxMa2hqYy8xb0FFYTFoS2ovdTA3RTRBM3BDRWllSUpDclVKWERKRHFS?=
 =?utf-8?B?M21keTVUSkp3SlQ3dWJKWUtSYlR1TlFZaDRraHpVeFVtempJRTNjTk90Ry9J?=
 =?utf-8?B?Nm9wTFZLbkpFRmJuQk1KVC9uUTIwR2dWbFhQYlQ5RlA3N3RWa0RwYnkyL3Rj?=
 =?utf-8?B?cmpMK1l2dThmaGN0QmErRUY1bW9iSm1EeTN1MWJLSzE4WndGVE80UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a021b1ce-12d7-447b-07da-08def954a285
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 16:05:03.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pKMBmxcUos+qV9hcLYUJOGVZNhy3yVah5isjFGEyg+uOjL3Lm1yTrMBGUDY/f/5sfbJ4hO5M1KeK9Z77KqlJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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

--------------eK0Dow7EwDGbc6qSurJrujru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-13 02:21, Zhu, Lingshan wrote:
> Hello Felix,
>
> Yes I agree the user space may be buggy, and the kernel should be robust.
>
> Even though it is named locking, it is actually a reservation, not recursive locking.
> The kfd_process that successfully invokes the ioctl reserves the device as a profiler.
> So when a user space locks the device multiple times, it does not increase any reference counters, and doesn't need to unlock multiple times.
>
> Multiple times lockings from the same kfd_process just keeps the reservation, it still reserves the device successfully,
> so IMHO kfd should return 0 other than -EALREADY, which is a negative error code.

That's exactly the problem. The API is apparently designed for user mode 
to "reserve" profiler access once, presumably to get exclusive access to 
some profiler resources. If user space reserves multiple times, you 
probably have multiple uncoordinated users of the profiler features in 
the same process. If they are not aware of each other, they will run 
into problems because they're expecting exclusive access to resources 
that are actually shared with someone else.

For example they will both independently call "unreserve" as well. When 
the first one calls "unreserve", the other one breaks. This may happen 
intermittently, depending on the order of operations. Or it may be 
noticed as a regression after seemingly harmless changes that affect the 
order of operations. This is much harder to debug than a clear error 
code returned when a double reservation first happens.

By returning 0 here, you paper over the user mode bug. But chances are, 
you're going to run into other bugs later that have the same cause and 
are much more difficult to debug. Unless someone explains to me that I'm 
misunderstanding the intent of the reservation API, I will not approve 
this change.


>
> By the way, the function is declared to return uint32_t, which is definitely wrong, because the function may return errors, for example -EBUSY.

I agree with this part.

Regards,
   Felix


>
> Thanks
> Lingshan
> On 8/13/2026 12:27 AM, Kuehling, Felix wrote:
>> I suspect this won't work correctly. If the profiler locks the device 
>> multiple times, it probably also unlocks it multiple times. But I see 
>> no reference counting being done, so this may result in a situation 
>> where user mode locks twice, and unlocks once. Now it's lost the lock 
>> but it was still expecting to have it from the first lock operation.
>>
>> I suspect that this is a user mode bug, and KFD is working as expected.
>>
>> Regards,
>>   Felix
>>
>> On 2026-08-12 03:14, Zhu, Lingshan wrote:
>>> AMD General
>>>
>>> Gentle Ping.
>>>
>>> Thanks
>>> Lingshan
>>>
>>> -----Original Message-----
>>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>> Sent: Thursday, August 6, 2026 4:43 PM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
>>> Christian <Christian.Koenig@amd.com>; Kuehling, Felix 
>>> <Felix.Kuehling@amd.com>
>>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; 
>>> Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>> Subject: [PATCH] amdkfd: allow profiler process reenter
>>>
>>> profile_lock_device() currently returns -EALREADY when the current 
>>> profiler process requests to lock the device again. However any 
>>> negtive values here are treated as failure, so this causes rejecting 
>>> a profiler operation even though the caller still owns the device 
>>> locking.
>>>
>>> This commit fixes this problem by returning 0 when the current 
>>> profiler process locking the device again.
>>>
>>> This commit also changes profile_lock_device() to return an int 
>>> value other than uint32_t, because it returns negative number when 
>>> fail.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 309510e23315..9acd5c91e51c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct 
>>> file *filep, struct kfd_process *p, v
>>>          return 0;
>>>   }
>>>
>>> -static inline uint32_t profile_lock_device(struct kfd_process *p,
>>> -                                          uint32_t gpu_id, uint32_t 
>>> op)
>>> +static inline int profile_lock_device(struct kfd_process *p,
>>> +                                     uint32_t gpu_id, uint32_t op)
>>>   {
>>>          struct kfd_process_device *pdd;
>>>          struct kfd_dev *kfd;
>>> @@ -3365,7 +3365,7 @@ static inline uint32_t 
>>> profile_lock_device(struct kfd_process *p,
>>>                          }
>>>                          return status;
>>>                  } else if (kfd->profiler_process == p) {
>>> -                       status = -EALREADY;
>>> +                       status = 0;
>>>                  } else {
>>>                          status = -EBUSY;
>>>                  }
>>> -- 
>>> 2.53.0
>>>
--------------eK0Dow7EwDGbc6qSurJrujru
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-08-13 02:21, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:be92ca16-443a-478d-96dc-c83318df3670@amd.com">
      
      <pre>Hello Felix,

Yes I agree the user space may be buggy, and the kernel should be robust.

Even though it is named locking, it is actually a reservation, not recursive locking.
The kfd_process that successfully invokes the ioctl reserves the device as a profiler. 
So when a user space locks the device multiple times, it does not increase any reference counters, and doesn't need to unlock multiple times.

Multiple times lockings from the same kfd_process just keeps the reservation, it still reserves the device successfully,
so IMHO kfd should return 0 other than -EALREADY, which is a negative error code.</pre>
    </blockquote>
    <p>That's exactly the problem. The API is apparently designed for
      user mode to &quot;reserve&quot; profiler access once, presumably to get
      exclusive access to some profiler resources. If user space
      reserves multiple times, you probably have multiple uncoordinated
      users of the profiler features in the same process. If they are
      not aware of each other, they will run into problems because
      they're expecting exclusive access to resources that are actually
      shared with someone else.</p>
    <p>For example they will both independently call &quot;unreserve&quot; as
      well. When the first one calls &quot;unreserve&quot;, the other one breaks.
      This may happen intermittently, depending on the order of
      operations. Or it may be noticed as a regression after seemingly
      harmless changes that affect the order of operations. This is much
      harder to debug than a clear error code returned when a double
      reservation first happens.</p>
    <p>By returning 0 here, you paper over the user mode bug. But
      chances are, you're going to run into other bugs later that have
      the same cause and are much more difficult to debug. Unless
      someone explains to me that I'm misunderstanding the intent of the
      reservation API, I will not approve this change.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:be92ca16-443a-478d-96dc-c83318df3670@amd.com">
      <pre>

By the way, the function is declared to return uint32_t, which is definitely wrong, because the function may return errors, for example -EBUSY.</pre>
    </blockquote>
    <p>I agree with this part.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:be92ca16-443a-478d-96dc-c83318df3670@amd.com">
      <pre>

Thanks
Lingshan</pre>
      <pre class="moz-cite-prefix">On 8/13/2026 12:27 AM, Kuehling, Felix wrote:
</pre>
      <blockquote type="cite" cite="mid:3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com">I
        suspect this won't work correctly. If the profiler locks the
        device multiple times, it probably also unlocks it multiple
        times. But I see no reference counting being done, so this may
        result in a situation where user mode locks twice, and unlocks
        once. Now it's lost the lock but it was still expecting to have
        it from the first lock operation. <br>
        <br>
        I suspect that this is a user mode bug, and KFD is working as
        expected. <br>
        <br>
        Regards, <br>
        &nbsp; Felix <br>
        <br>
        On 2026-08-12 03:14, Zhu, Lingshan wrote: <br>
        <blockquote type="cite">AMD General <br>
          <br>
          Gentle Ping. <br>
          <br>
          Thanks <br>
          Lingshan <br>
          <br>
          -----Original Message----- <br>
          From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com" moz-do-not-send="true">&lt;Lingshan.Zhu@amd.com&gt;</a>
          <br>
          Sent: Thursday, August 6, 2026 4:43 PM <br>
          To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
          Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
          Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
          <br>
          Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">&lt;Ray.Huang@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
          Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com" moz-do-not-send="true">&lt;Lingshan.Zhu@amd.com&gt;</a>
          <br>
          Subject: [PATCH] amdkfd: allow profiler process reenter <br>
          <br>
          profile_lock_device() currently returns -EALREADY when the
          current profiler process requests to lock the device again.
          However any negtive values here are treated as failure, so
          this causes rejecting a profiler operation even though the
          caller still owns the device locking. <br>
          <br>
          This commit fixes this problem by returning 0 when the current
          profiler process locking the device again. <br>
          <br>
          This commit also changes profile_lock_device() to return an
          int value other than uint32_t, because it returns negative
          number when fail. <br>
          <br>
          Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
          <br>
          --- <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++--- <br>
          &nbsp; 1 file changed, 3 insertions(+), 3 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          index 309510e23315..9acd5c91e51c 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          @@ -3329,8 +3329,8 @@ static int
          kfd_ioctl_create_process(struct file *filep, struct
          kfd_process *p, v <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
          &nbsp; } <br>
          <br>
          -static inline uint32_t profile_lock_device(struct kfd_process
          *p, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_id,
          uint32_t op) <br>
          +static inline int profile_lock_device(struct kfd_process *p,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_id,
          uint32_t op) <br>
          &nbsp; { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd; <br>
          @@ -3365,7 +3365,7 @@ static inline uint32_t
          profile_lock_device(struct kfd_process *p, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (kfd-&gt;profiler_process == p) { <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EALREADY; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = 0; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EBUSY; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          -- <br>
          2.53.0 <br>
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------eK0Dow7EwDGbc6qSurJrujru--
