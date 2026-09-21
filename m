Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD30C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 14:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F2010E32D;
	Mon, 21 Sep 2026 14:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TLVxxHaQ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2A810E32D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDIew8xtCCxONUUkw3LTgfdWjltdtffzeEbae0WEMvqY4HfUR2TxvqkdFqsgEhpGBUtRwEgeGvedfaqBT720Gs3PcXcICwISwOrLlx876tU/5jNMcLet4Wbbsd/w3G5LB/0PdKrYLFXfLNBNyhY25qm61ZOE8IFuO5IX9ehWRD8S62c/zB+vsnwf7Di7058PoASyvCORWvJBFYPKNT7hrA2+PFEME7robP8D3fJCg2k/y7LAMzFRKZn1a3TGDknCPbQDxiahK8tVASrdbRUI6EulB2l2XGL0hB/kHy8Di271SD9j36aSLmxwLr5xgRO+xmz3KsmS2gfSmrOluByQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGdDnm5myNnsSDuxLp43jnwRe5ganUTs0GHsXXx1ZDs=;
 b=mu01JbU21CnX5cMRNeGGm4pLzJXldJNRzPPar1o4CkuJn7ESB9w1avB1oFuECdZhkJqqwVd6uhHOMns0C8UVCsR3Lbnm/xurZbRiUpBzNQUTbrm3pVrWP+a1+iyfNLhaKv5gwXS4KYbtXjD8t6XwYAl10O+MUjqMYZjS/WQoy8hI8vEIMKuC3hoY+bJ8n91t1G2mHx3pOm5WVtlRK/tPeVPWcdZsoPiNSDup5JYgjivRUsgXQp0illC4bqVHngZi4S2JdbNazig8VpbGIuzC8qLzg5ABgTQhH4XV2m3olqYhNrm5wnPrn53MV4Y0Xp5UoyDdlHzsWXPomPFEdn3HaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGdDnm5myNnsSDuxLp43jnwRe5ganUTs0GHsXXx1ZDs=;
 b=TLVxxHaQ0cM908Waq8Y494WTKdXNJcwAPvd0a0U4frJvACd/TxlVqenwvo4K1+147Vw/UuwV9PtfDJt7YrLkDuRK7vCBXAMjRS1S9CrEh86Fh/1vHfFBrUIDhBpLNI6caKy+9p255nkHOM7u5afx4VhwvRevF8T40hPHQciyNqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:40:52 +0000
Received: from MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2]) by MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:40:52 +0000
Message-ID: <e77dc3d3-eec6-4b54-8bd3-d2b51591bca4@amd.com>
Date: Mon, 21 Sep 2026 10:40:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-5-shahyan.soltani@amd.com>
 <2d2520d8-6477-44d0-a298-37bd078da24a@amd.com>
Content-Language: en-US
From: Shahyan Soltani <shahyan.soltani@amd.com>
In-Reply-To: <2d2520d8-6477-44d0-a298-37bd078da24a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To MN2PR12MB2863.namprd12.prod.outlook.com
 (2603:10b6:208:103::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: ba22256e-f466-4266-5fb9-08df17ee55f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: onfL4Kj2TcSHqOcrD3eb9s72OzeW8xyZyZAioZSUyDRMueL3e7HHNlzd4NnESxYvHm+GwPkMgAClH0d/iKJ/fO6uEZ2J0OFbyOPmjONzK1hwQdmwo43Z+qbYOmuUWaxwGiE6cSQidstrTMElEs9qxBDFBLJcNGuC8RFYKg0U64hqz5aTq5q9sn1FduvJcMZ3j7cBtYVON+fGBFXNBWWSr3mjnQjCq+tMVz+4pXkiwqJZt56peXmhm1Hpb0PlLz6HdVTe3e9rBzBHfta3v2W7oEjgwk+eZLnj4oqBpUM0dfkMrYtrOzPhunVbNWEBYuU6Q2mwDB4e36i0ymE8NL535X7JAW0ES/rKCR/j8KqW0Qjij2AgM3YAPDk7wSFpo5J941TLw7w1ffw8ykC+da0JhOoYWyADtNoZ4ryzVyKNRrwKJ8lTxcwTZvD0862r1VY2hER2t1Xk6rM/qYYW6KQ6bgDwnFJxo7/Nxw8IK7zLQbzKdsbEMSkvHQ9a6nFKDHeHH+TU8jxTkNEnkzphnbUaXPIXVKaOzcNCXgOPThhyCVNB0mqh9v/JFPKH45A7hcQJ1ePvnFpvPDS1tLcFqUDQHF1ZA4NLmdmfBMpcFzsvIJvUbUnoqu0N5+pjTIhBoX6r+ukYM7+qp6lgZMLqy2yROB3Mt7EyVm9t/PurLozEu6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2863.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS91RnJxaDh3TGdsMDhYQ0tnSHNaODgydkk1R1IwamViYWhzRVdweWY3b2dx?=
 =?utf-8?B?QTI0eUg2MDIwQnptSGVEanNueVdOcjFLWU1vZEwvcVpzNmd4UVV3YXVHdnJH?=
 =?utf-8?B?cm95WUlCTWF6SldlN2pwQm1VM05JVzh5L205dXpDZGNJZFNWNFZwbzVUaDkw?=
 =?utf-8?B?eXB1OU8vaktsVWozSEZ4MzNRK21TMEl5NjM4dlJqeFdUamlaelJNNE9sdHpK?=
 =?utf-8?B?cHYrVVN3U1J4TGhIZllhdVRsTU1KSnR0eWxLOGtJUlgxOEp6a3RrSWlYZkFQ?=
 =?utf-8?B?eWNtMm1yRThLaUxSUlZxaE44Ykp6RUhJU3AxNFVmM1NPV0RjQ3UzZC9tTlZU?=
 =?utf-8?B?WXh4aTgxck5vVkhOeVhobzdBbkNQSzEzY0NtZWdzL2RXNkU5UmR0WXR6Nkh6?=
 =?utf-8?B?Nyt6RForZ1lnWjdPcFJjcEJsaEh3TEp2eFQzeUhPSmp2SHdRK0xFQURXNXdx?=
 =?utf-8?B?REJaMEtaK2kydTNKakdQVmhOSjRoN2tWbjVhbStsYkl1T2kxUVkvNDFLMCt5?=
 =?utf-8?B?QTVNaTkxYUNlUTJHc084dHR4Z1NGR0taL1VXUTlRVllEdjVtT2UyUldDbnpJ?=
 =?utf-8?B?Qk1KZk1KTE5pa2dya2g4WHhITktabTNvOHNlQ05HWkthSEJYS2VBeE9oaDVp?=
 =?utf-8?B?VmtaOTFFa2E0K3pLK01ZaUc2R0d0WTZlNHBNdHNjSjBMd0k0Y0Ivc3c1RG44?=
 =?utf-8?B?RlFvdHZ1eXZZMUMrNHlBV3c0OHpmaU9oRTVIMVliMk1hQVZSMjZFNitXRzJi?=
 =?utf-8?B?QzlaUDc4alRQb0lXcHpZaTdNRndyU2kyRmh2KzRmUTBjWmg0c2FaQ3Q4V2Zq?=
 =?utf-8?B?aTdvT1lteDZLNWlUcStIMVYxY01pVHJhY2tmMzlYS0hPcjdyV1QvWHFETHFl?=
 =?utf-8?B?aUsxN1dmQ2JVWUhZYTA5Q0VtaWZTT3llNmtUTTN2dnF6QlhEZmZYY2ovWlhl?=
 =?utf-8?B?V1VZZVRzZUdHZzMxT3M3UE1HR3plMUgwWFFQNGUxbWtQbndZeG1ITW5rL0h3?=
 =?utf-8?B?cXA4cHdUMTZsdWhWaUl1ZnNxeUp0aFM5bCtjRmcvblNnek1EQmxSQWs5Nnpi?=
 =?utf-8?B?ZEpSdkF2Ym52MFY0eGErbWg0b2Z3Y3lMODVmN0NUbHdrSFBhaGFGZGpWRSsz?=
 =?utf-8?B?Z1NzUkJjbm0vdlAvSms2MHhMZGJ4THZJQ3RyMEZhbGlYVnBrVzBiSkoyV2NW?=
 =?utf-8?B?WTBXcXdVVWdwY3BWT2JPcHk4cVNTM21OQW9WWG9sbWRlYnRxOGEyQ3FHc0FN?=
 =?utf-8?B?dXNScXYyaFVVa2lSZ1laSnpnZW93U0t4OWtoUnVDL0JnRnRIcUdyK3NlbFVE?=
 =?utf-8?B?RCtESlJha2ZOTml0V1BZeXFPUkY3T1Y0WkdRaDQ4eEozUjZFeFAzdHRvdVFz?=
 =?utf-8?B?VWdzMTF6RXZlUFJ6NlJuUDljMXJLdTRYQ0VpaFgwQ1BuK3FsazJFZjljWDBD?=
 =?utf-8?B?VXAxcjdlYjRNMTI5NmZTdHRpaTA4bEt2T0hWKzgzK3FCQWVMeVpPa1NiU1Vl?=
 =?utf-8?B?aXhiT3dHTStXbXBSYUc3Wiszd205Vm55dEV6di96MXJ5d1pDdXErTUJ3Q1dx?=
 =?utf-8?B?cFZXUjlmM1dhQTVMUnBHbWRWM0wxUU5sNHVYK2w0akdDdWhMOU1JenZYR3FZ?=
 =?utf-8?B?c3dwM01GZnpzSVBLUU95enhRN2FtaElPYjB4MTk0SVlNYkJiSmFtMlJKN1JX?=
 =?utf-8?B?TjA2b1lHYW5MSzZlVnl2WFF4a2xRWS9kRkg3MVV3cjdzWGZ1cjNZeFc1YWdn?=
 =?utf-8?B?WUhBbGpCaFllcCsxNDdyNmlWQm80YkFEd2g5T3owazhUTjJuWWNLNkNyQ0pw?=
 =?utf-8?B?N3ZiTGE0aWpiMUlkbmpsTGtqWGgvRyttcDZST3FTb29Va0hnMHkwZFI2czZq?=
 =?utf-8?B?c01BVjNCSFlaR3lqVEYydDIrU1Y3bUU3bExpcTFPNGlSa29EdkZBQ2puNml4?=
 =?utf-8?B?cFNDQUpqS3J0MS9xR2xzYkN3U3VST2FVMFhBSUY1bEhIZ2xIK1JMY1pPZmJr?=
 =?utf-8?B?czRvYUNkQW1jc0w0dFAyREJ2OWtrU09ydmV2bUJzZUE5UTR2T3Z5UzdJVlNT?=
 =?utf-8?B?dE1JYkNlNXJONlYydk93K2lSamNwOEFrU2Z4QTluUE1IQWQxNWZhekNZTGp5?=
 =?utf-8?B?U201N3dHQ0ZXWE4reEZMU3BENWVDam9uY25pdkVQUVlveEIvNS91M0dvaTJq?=
 =?utf-8?B?Wk12MUxRWEkyWmZSZkFSRlpTSUQxZ09PZVJMZnJkRmVRMFpROEtFaExONTZj?=
 =?utf-8?B?b25pUnU3WXlNK21rLzRJV1FaY3JIMForR2lPRXJOaWtuenVqQW40QUpYS2ln?=
 =?utf-8?B?TXovQzQrRFJOL2xNT3hSQjM2ZFNJMWRRNUlCNU1mbTg3UURTRDRGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba22256e-f466-4266-5fb9-08df17ee55f3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2863.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:40:52.3270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxXFHmr9ZuTzWU3W9d1UfrQVcwwnrK1+fa2cAiee9/EXhsa7Xx7UnxL4CEzLKhi7qGivG2RCNq9YPHpONSJUEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

On 9/18/26 3:57 AM, Christian König wrote:

>
> On 9/17/26 21:58, Shahyan Soltani wrote:
>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>
>> For now use the same logic as the existing one, but it's not 100%
>> correct since:
>> 1) most operations don't need the GPUs
>> 2) some operations that need it are actually deferred
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 4e4814caf61a..6edd03647c2d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -978,6 +978,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>   	if (r)
>>   		goto error;
>>   
>> +	/* FIXME: only PRT operations use the GPU to update mapping, but
>> +	 * some operations are deferred to fences callbacks so it's not
>> +	 * trivial to fix.
>> +	 */
> That comment is not correct, just drop it.
>
>> +	r = pm_runtime_resume_and_get(adev->dev);
>> +	if (r < 0)
>> +		return r;
>> +
>>   	switch (args->operation) {
>>   	case AMDGPU_VA_OP_MAP:
>>   		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
>> @@ -1031,6 +1039,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>   
>>   	}
>>   
>> +	pm_runtime_put_autosuspend(adev->dev);
> That error handling is not correct, after the switch there are a bunch of returns and gotos for cleanup.
>
> I strongly suggest to use the guard approach here as well.
>
> Regards,
> Christian.

Thanks for the feedback, you caught something I completely missed. 
However I have a few concerns
on what approaches I could take.

Attempting to use a guard in this situation would require the guard to 
be moved to the top of the function,
resuming the system much early in the stack.

As far as I understand this is due to the guard not being able to 
succeed any gotos as the "lock" variable
in the guard must be initialized before any subsequent goto.

For example:

goto error;
PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);

Is invalid as "lock" is initialized after the goto.
Trying to initialize lock beforehand doesn't work as it would count as a 
redefinition of lock instead.

Would that still be preferred over creating a new label and trying 
something like this instead?

replace

+	r = pm_runtime_resume_and_get(adev->dev);
+	if (r < 0)
+		return r;

with

+	r = pm_runtime_resume_and_get(adev->dev);
+	if (r < 0)
+		goto newlabel;

	}

...

+ newlabel:
+	pm_runtime_put_autosuspend(adev->dev);
error:
	dma_fence_chain_free(timeline_chain);
	if (timeline_syncobj)
		drm_syncobj_put(timeline_syncobj);
	drm_exec_fini(&exec);
error_put_gobj:
	drm_gem_object_put(gobj);
	return r;
}

Another approach I could try is wrap the entirePM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); and the 
subsequent switch cases before the error handling into its own scope 
with {} However, I feel this method is a lot more hacky then necessary. 
int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data, struct 
drm_file *filp) { ... + { + 
PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); + + r = 
PM_RUNTIME_ACQUIRE_ERR(&lock); + if (r) + goto error; switch 
(args->operation) { case AMDGPU_VA_OP_MAP: ... case AMDGPU_VA_OP_UNMAP: 
.. case AMDGPU_VA_OP_CLEAR: ... case AMDGPU_VA_OP_REPLACE: ... default: 
... } if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && 
(!adev->debug_vm || timeline_syncobj)) { ... } + } error: ... 
error_put_gobj: ... } If you have any ideas on what approach I 
should/could take it would be very much appreciated. Thanks, Shahyan

>> +
>>   error:
>>   	dma_fence_chain_free(timeline_chain);
>>   	if (timeline_syncobj)
