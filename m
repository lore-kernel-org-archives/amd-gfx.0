Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C56CCD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 08:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0AB10ED90;
	Thu, 28 May 2026 08:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UqjVF6SW";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A017710ED90
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 08:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weymm5DCIuRaDNf/Q20/AfmjzEHgYp8DMip4O+luFvSjRV+Yftrj2gt8r8f+dDpWmBnLSuZp0c/GtZefg0YaJgNAZ+NDhNw3WNADCUqQywPlxr9HtV+SbxT/rsg7DOq7vzm5sTI40HHx1J2P0ofjiRkkdFNwC59yH3CFBeNL2+1SaA7khnVWsy92Oq4bpXJJtiuQDJpld3YvbMpY8AcVZkJlIR6tfEkprFSAHvH6OufAH9TD76Z2Jq0LTXlX8qQFt591Pl9tH/F2wmzbKvcch+u+24a8I4HcBsGkEGaNhsPVexj+wugVXBiQW8geZis1fDOeLIrnJQZ0NEepqAf8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtPn0wN/kB0uB6NoRDXhkFO4QRJxTFR3lem88p2pS50=;
 b=GbRtlhdKiZiwjMoVUibP0t/aipUDZOiG8S9hN02Z5mhzZMl1LK4ziAfK2C1DxXqfCnbyZJR6pSVg9gCSZIbkndxkeRrzAYIZdWAf3P9Bkcbr+4Ys2A7DCd84wNBT8OyNEyfUSpoLtUbVCCJQmHGaDPuq2F5EoplrQjwbPCd1heR246GhEf4a7ljE3vPCvcsQ0QAq9xBJYpR3l7MC2xxis58FHa2YBgm4lbPs7rXW0z4CW8uoFUCErdYKh7l3oFy6OrwIYAm4JsCGSPZP7LZ4ZgzP4zx++FEuUIC9mi0oDbmKauphzmgmf+KR3uQXMEws1O3i2sW9G5SUI9SlFGan0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtPn0wN/kB0uB6NoRDXhkFO4QRJxTFR3lem88p2pS50=;
 b=UqjVF6SWf2CBrAwiFEHzQujfXXsrlQjXbFl1dB4wP/Kg0kXtwygr2z4ELX640SRJ6n7cuGAOuhA4TieYNm8Bk5QkGpAyi6+yUVUVKddkfd/Sjd3/cZkUlfdQ1UE5zhKI1Nyc7wRlkCFD13njJU0T3h0IKeP3XREfhr9qmnSnSiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB999067.namprd12.prod.outlook.com (2603:10b6:408:32d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:06:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:06:28 +0000
Message-ID: <0b5ae36d-4045-4411-89bc-e779be98bce0@amd.com>
Date: Thu, 28 May 2026 10:06:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
To: "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>, "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>
References: <20260528062902.362031-1-honghuan@amd.com>
 <1e9480eb-24fa-4d97-9e4e-7120bf668f20@amd.com>
 <IA1PR12MB6435193DB8FBEFB4F4CEE093D9092@IA1PR12MB6435.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA1PR12MB6435193DB8FBEFB4F4CEE093D9092@IA1PR12MB6435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB999067:EE_
X-MS-Office365-Filtering-Correlation-Id: 935ac44b-67b1-4e00-bfdb-08debc900504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|6133799003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: V3E+Pucij2N60LdNz1FPe6DTZQnL88BXnWndXVJotdyIgJpuNvs8PxpqIokUfYUQqcnM10nj8yDWUF5A9d0DNhqmee0cojxOJt8Leiw+6MR5m06PPXKb3O43Gp48v9Ysyw9iYMic8yBBA8cT275EHBDanEXofNNTC3cGdVJ6GPvjkL5lSYXhIo11GdWGjer0UE+Eor33bjobgbzKac8eOvy75uGFWwsE/rJVlzSRdEs/xongWwSXqrwNw0eDx1+d8uti2XAY1s3ATT2eCNzaxxYGfcG3k0byETPiw9EmRfj+9iDiCR76HsESeMuEpzLDugeCzGWeK5Okf5A/45KgqjwSCTxVdEUctQ3c52WgtwTrl7h7itSJgsj6tZt9tNn/G2SBiuEXf80iYeg9xSarOlvSSA7xctlwphZY+lYbY5pnt0IYxhDfMtojjrlMG27TS9QCrX7VD9uwZsjsvYlNiDq9KYt8f8JrpQthGycqcp76IwnAv7M0VXUVxJmeDkfgH6konG+EdqCysVLZDbSKKeBYwhAdkiEj8tMOM2rXvouhw9KJnO8soxycMHNFgsJS47zJ91LNEEtjXgzNfWt09IPUuH5Mf/bYKB+aUNc5wYCh8uCATFGqL4tXuJwT2F56E8ZfejwS3m0Kj7uKbWmNhGH9UnRNKtv/r41BfpEv+uG3GozFGJF5tYGqjAhKv1oV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmRDODNuai9qbGViVGdtcUlqd2JIVW1Pb1Vtc21qMWxzZEF3S2w0bU9XaFVl?=
 =?utf-8?B?ZkFxSnltTTkvbG1DakZaVWVBMG5sSk53U0tvUUQyaXQ4OGVsRk1Fb1JBcU5Y?=
 =?utf-8?B?eUM4WWRtaGl2MVcxaWFnb0U4b2x2Q2d6aHlxSDV6U3hZN0p6Q3FUMTdIbmxy?=
 =?utf-8?B?OUNhRnIyZG16UVFuZnZ0akNlNExiR1RBY3NjWVFpWW1SWmFYYWlvSHBmWjhY?=
 =?utf-8?B?Z2Q0MCs0Rkt3OFBRNkQrMEthTzdHa016UEhBUW93bktwUHNScmV3MURLbzRN?=
 =?utf-8?B?QWtubkRnblZnTXFERlNOYnBzRVVDK2tlRS9YTXY0WVZSZy9JTFY0RVk3eERQ?=
 =?utf-8?B?Q2t4ZHZsNW9xYU85WlM3eFkwdUczQ08xeW1oSTRYYXdaWlBFUlo1aGZiMGE2?=
 =?utf-8?B?Y2owbnQzRWFkTXJ3WEMxdDAvRzBWaWtGcXlPMWRSbHZMUlZwUjAvNFZhOEVU?=
 =?utf-8?B?M1RTdm1yNExmL2RZK0ZKVnlZR2QyRnh6dWhvUnM4T3d6RTNHRkdmSWhlM01a?=
 =?utf-8?B?TnJIQngzbEIxRzMwMWZzKytvSVdJamV4SVdNZnplSmNrNHY3Y2ltdGxsajVY?=
 =?utf-8?B?dGJLSmsvdW9CZUk3L2dEakVwZ3NGNzFDWmZmckcvSCsvM05EQmljd2pwdCtJ?=
 =?utf-8?B?czg5Vk5kSDFobHBTbjdZcnd6ckYvWCtvS1JQM0hIT01QVkRZaU9mRnNOZHlI?=
 =?utf-8?B?aGEzMFpGYWNUbDdPczU2OEJlazlJaXBwVXlHTjMvMjl6ZjRTa3hwUEVlbDJK?=
 =?utf-8?B?UitPdHhIbzBnL3UwMGEySXhkNGlQK0IxMng4WWNoSHU2eVFzWThUUm5SVElz?=
 =?utf-8?B?czIwWHFKTlFyeXp3OWdKb0NVdC91VkYrRHJtVjI5a1g0RGxiTnFOem91Ykk1?=
 =?utf-8?B?b3p1ejArMEQveWJLcGZETWpnbC83a0dJSjJOZUhvSU8rSEFSekQzaDZhSTFs?=
 =?utf-8?B?UmRBK0c4UXh0ZzRiQlB5VForRlpjQU1IMktRZmwxZERBemRiVFQrQ3JlMzdp?=
 =?utf-8?B?NjA3UzF2UGljQUxqYW1zSFFaRFFzQjNlL0dIcW84d0pvNzhBRVVvTmQ5L0Y3?=
 =?utf-8?B?bU5NOGlDOExzWHZ6RmMvbHk2TmZvSHl5WmlBSlNjSlhadmJ5NVdGeUNMdWJT?=
 =?utf-8?B?MTV2NDFiNVM0ZTdDVnM3Nm1ReTZDdVgwNEVIYUVoOEQzZzlNUHRDN2IybXIz?=
 =?utf-8?B?QTZHdzJtV0JOYUFUVnhOWGtZWXNyMTBvaDBiWHArRjc2d3hHV3BUeGphSWVK?=
 =?utf-8?B?WnRsWk5ZejBhNnR1UkNUbFBrR0FSbzI5bkNYcFZ4c1ZrdWRGd1hsMXFUTFUz?=
 =?utf-8?B?U0JYRDY4a0V0M1BsVFl1YllTT1ZTdGR6MjF2SWNIUmp2eGR2eHA3N2pSTXB4?=
 =?utf-8?B?VnpIelorM3FXNUJOckovSXNyMVFWRy9LN3pkdk5UanRlMnU0U2JaRXM2dEpB?=
 =?utf-8?B?U2dxV2sxNXhFQ1dqdjAyVFFPdVpnd29NK2hseUlqRjVHT2xIYXhnN3V2Z0du?=
 =?utf-8?B?WmFMeXRBaEVUaC9NTlpEVGNLWXlNcnVtYWVyL0xXWHpScG1mSHRLMzRZWnpL?=
 =?utf-8?B?WEVNc2VrMFZXbUxKa0NLVC9tVU40OEptN3FqM3JpakxWRUZrTFlHT21qYjZw?=
 =?utf-8?B?TjhkVE1PK1lybGJQYlpWa1JYelErRjlTVDBJTEVubDRqa2NEbTVMWFFDRmY3?=
 =?utf-8?B?WDBCeUlzR2V1eDFpYkhwOUFWaGZFR2dnWFlSdVhWcWRRTTZPMnl0ZFVtUktP?=
 =?utf-8?B?b0ZaSUZka2hEdW5YVW81K2V2NGZUY2RJRzRPZFpZNm13N0ZCdzJicU5CUkc2?=
 =?utf-8?B?dGs3L1M0WWJYN2N3Ymx4Uk5Wdm9sVFBZZ0l1NjU3Z2JQNWEyL2l0cjNWVTV6?=
 =?utf-8?B?UmxvRnlYZjZpNzErSTUxVHFodEo1WVlhbDRaMzhiZkZIaUV3RjNJV1d2cGZM?=
 =?utf-8?B?MXBkUlRoT3lwVFFwd2NFcmJRdGxmblBWVTd0TkVaRFJXaDh3VUUxTEpiRGZE?=
 =?utf-8?B?NXd3OFRiWXR2QTBlWGZiTkVLWTVzQlAxRzdERjNHQ2dqU2piR3pFay9nY2Zz?=
 =?utf-8?B?TXd1TTAyQTBXeUUramk3c1JLZnNBVHJBaENrbmNMUFBwRWpUQUxzMVBNR3Iy?=
 =?utf-8?B?ckY1cU1jeWt6V09KZk9WTzl5cUR3cXVSS2dlWCs3U3M2UDBWeTJpWG9nWjBP?=
 =?utf-8?B?SUQxdHZlWGNiaVIwN2lONUw5VldoNEJoUmswL05xbE1JdmFUdkNyYmZYUUpH?=
 =?utf-8?B?NEFWenJPRm1qdHlRb3ZPbEVQMEFtVTd0b0h2bGtpYTcySllhWEM3NVFYY0di?=
 =?utf-8?Q?MSJjYJclRG1BdBK5WI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935ac44b-67b1-4e00-bfdb-08debc900504
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:06:28.1548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0w8qhXeeCvCpxt3yfxqLFymdbYXB6IrwwLTVmpw4dNyDpMXv2at0QLnYjI/VRf0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999067
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

On 5/28/26 09:22, Huang, Honglei1 wrote:
> AMD General
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, May 28, 2026 2:54 PM
> To: Huang, Honglei1 <Honglei1.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.Liu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
> 
> On 5/28/26 08:29, Honglei Huang wrote:
>> Align with drm_gpusvm_get_pages() (drm_gpusvm.c line 1416, 1440) which
>> refreshes notifier_seq via mmu_interval_read_begin() on each retry
>> iteration. Without this, a stale sequence number causes
>> hmm_range_fault() to perpetually return -EBUSY, leading to an infinite
>> retry loop at the caller level.
> 
> Absolutely clear NAK.
> 
> This is exactly the bug 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages") tries to fix.
> 
> The sequence *must* be grabbed before the loop because it protects all pages and not just the one from the current grabbed chunk.
> 
> What probably needs to happen is that we need to move the retry label or just completely stop retrying at all.
> 
> Got it.
> But in my local test, the test KFDMemoryTest.LargestSysBufferTest always fail.

I mean that's pretty much intentional. Testing is for falsification and not validation.

Either the use case is not valid in the first place or the test is not valid.

> It can pass before. This case needs RAM size big enough to reproduce,
> for some large RAM size CI platform, it can reproduce easily.
> Maybe someone can else can double check.
> 
> And I understand your concern about the seq scope.
> 
> Would it be acceptable to just remove the internal retry entirely and
> propagate -EBUSY to the caller?

Yeah I had a similar thought. I don't think the code should retry at all.

-EBUSY means userspace did something in parallel which resulting in the operation to not be able to complete.

So the only good reaction I can see is to abort and let user space or higher level retry.

Regards,
Christian.

> The caller already handles retry at a
> higher level. Something like:
> 
> hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
> r = hmm_range_fault(hmm_range);
> if (unlikely(r))
>     goto out_free_pfns;
> 
> This keeps your seq placement while eliminating the infinite loop on
> -EBUSY.
> 
> Regards,
> Christian.
> 
>>
>> Fixes: 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index 5d72878c8..ec0fe9044 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -192,7 +192,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>       end = start + npages * PAGE_SIZE;
>>       hmm_range->dev_private_owner = owner;
>>
>> -     hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>>       do {
>>               hmm_range->end = min(hmm_range->start + max_bytes, end);
>>
>> @@ -202,6 +201,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>               timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>>
>>  retry:
>> +             hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>>               r = hmm_range_fault(hmm_range);
>>               if (unlikely(r)) {
>>                       if (r == -EBUSY && !time_after(jiffies, timeout))
> 

