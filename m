Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A412C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 14:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A271A10E44A;
	Mon, 21 Sep 2026 14:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qTprmSpc";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440F010E5B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crfGBnr/3Caz2NgvgtB7TyE+G3wxwTRKuktHjPn47j5fRB918zE9tnM0WP66p1PA5ybC17QrD/T+azIU8lqppLS7bFLidxM3nIWGonO1MeQUitQ/0zT8U8+vbk2y/Tr9+K2qUhdiLkYusPN1jGEnvbrdnXZIhbKEE/QsOKYTRE8FpqpVL1XdMV7aHmE5FcB7LlwtPFOv8+bqcJay3fkgydNUjYKK83Nz2EbDPKWOaEL18zOSoU9UAfMp3DLwg2H40foGs7Dx0q+M5QmNTO71aBt8KpGZKlDbisQfvXeXLoqkKH51V+rm3NL3lITmaHjEjMdjkAhJ7JvIOK1FOT5G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPed/oOtBMWJK3O74hgf2h/k1rjbx40rRVxI9WrhGaA=;
 b=JXJ8ijMiBJaa95K6c6CY9XN5565eLbZWmh/wiCWeKmS7AB7ShZAOF2Qr52VS5HmOiPCDRVqkt4KFD7hRqRO0rhnl16hPAJf7C0uNPKREdctfyocgk9ZP4T1UdF4TgVMP1CshyyrwlKl7Botmjj6tr64VQ5T1J9DYNraRSJsUKmyXjunK3tJTsQFdyVJeh0q/Sd1E72U76tYJ2AMnVQ9MYPy1owO5nVEdQUk9pgRwddxlxRGBXeresnED/Y1tKmrOoADRS5t/82Y0zyg51b0o+XRxw5GT3vJV4ij/2fn9Tp2MebjJyc2GxRN12n8Tlx0151YnwOeEzkPn+bROi3FT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPed/oOtBMWJK3O74hgf2h/k1rjbx40rRVxI9WrhGaA=;
 b=qTprmSpc9h5Q2VqGGKBxMTt7ZPnTyljY6t3yIY0lkgDXMglD4sidmcTKx/w0Jj8P8ieetjMqd+j/CojtphgyH88G8Wbs9h/mx+8jzItTbWt8OkuYgLh91ydqKV3XtOm6HDLTlSNXs+AHwrULTyVEkW0d66YIFQbZOWYsFEcB3ZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:51:00 +0000
Received: from MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2]) by MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:50:58 +0000
Message-ID: <b4c6676f-9333-4bb0-9861-3ecc3c72f350@amd.com>
Date: Mon, 21 Sep 2026 10:50:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-5-shahyan.soltani@amd.com>
 <2d2520d8-6477-44d0-a298-37bd078da24a@amd.com>
 <e77dc3d3-eec6-4b54-8bd3-d2b51591bca4@amd.com>
Content-Language: en-US
In-Reply-To: <e77dc3d3-eec6-4b54-8bd3-d2b51591bca4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0301.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::10) To MN2PR12MB2863.namprd12.prod.outlook.com
 (2603:10b6:208:103::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb11b4a-ca2f-4a57-8eeb-08df17efbf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: agMGFOUL2K9Q3fjwGhZtyietb4J4zWjcWHUBgGupiBn6Lt/rHKK4g/Y5j/n5DlKtMDYFFuZrzSUBOqbz4kh0JiZGRuT/3yWA/3qp/Fw415WpLRQhtBEH5+nXkqHTnTqmEbqVdyrV/CF4s+A+UvjQJD1W0OOfqorlfGw91rcUAAEOfkhShhMT+P8CLenuC0sZf/OT90zNSRWOGVtYdeoAEnitmPMF2uLulFebYAqc7G8TgaLF+Mczl6irJxyDXGyAwwkxJwumwPWKYAQR5MJAG0PpvHnH3SpP36woq1UZZD8kMclROAAfbb0FmaBFWNiU6nHOSf6Mg/kyY3JDUsNiX8ZyejAaWzmGL2+2BAiwJC7PhNgm7dY1k/0dMuZH6sxjtgTZzPe3A+JPvniYE5IpUO0q2rAnPfo+np3mhe3EIe3DHkza7GWx9yEmUHHcH+fkfDnxAfkbL+lg15qAfiIJlu5MykuiWvKNVg0fbiw804eJDNFnPs0ovLdp/MqkfaHtmMaoP9sof1mMezIsVbrlEKuYEMsdGYsVTiXOKDnrECoFqZsJfdRmrF1NnK+MEAgTngGSNsNyXz+nzRpnKWR4PcpTeeHe+g7qzMrK/OTMAsb/p42c0/y10agxjeJuCme/ov0DGxwW7Wby5I5U+0leK4EsTFUhQtfyX1azvCFfUXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2863.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXJGbXBsK3ZyUDhjcER4ZDVDTkN4czJaaXR6NitMSHp3cFFMcHE4S3dqL0lS?=
 =?utf-8?B?TTlXeU4vWm5rYjY4VTVKZnIzMjg4QXJUcUdCelBzYVFtNXkya2hPbjNvKytq?=
 =?utf-8?B?clgwdTRkd1RHWmZCNEhyQnNnWVFmSk5hVk1lRG1mVmpLdDErakhaWEd6YmdM?=
 =?utf-8?B?VEJYTnA3bnBsNXRvUlZBVGN6VWtGb25jME9DcDMyTk05V3kyWFA4cm00d0lR?=
 =?utf-8?B?NVRsRWJlZzFKZlYvL1Nzc3hQVmc4WEVZeDFyUzlqNWM4bE1ldm5PdXNtRkZ1?=
 =?utf-8?B?Qm1tK0xEWUUvNjRPS1M5V3o3a1dtd2RqK241dklZN1RjQ3I1R25lZFIwVFBX?=
 =?utf-8?B?WDZMWHExZWJBTkk5S3FDUVdQZVNYWWcySlZwMU1wV29CUE5USlpPbGZrdk8y?=
 =?utf-8?B?UHlacXlTQ05GVUhpOEQrN00rdEdhMGo4MzBUaWFyN1VVRnhZTUZIVEVNcjJY?=
 =?utf-8?B?bnp0MXNWY05XaU9ydXg2UnI0bmpDRU9QWUc5eWRhTHNZRjZMd2Z4ZnIyN2FS?=
 =?utf-8?B?bnRyRG1UaXd0b3RrMFZNVDRpbHB6dWxMaUpsaXZvT0gyZlpoMklFK2ZsV1ll?=
 =?utf-8?B?S3o2VGkyb2RTWWRjQ0RpSUtncEJ6Um1yQjVaK3NJSzk1dnpQVmVsQlppRWlF?=
 =?utf-8?B?WGRoN0w5dkJteU9QWHpZdlZnalRVV0NWM1g1cWkyL2xIbGFoOW9lU1VRRmRS?=
 =?utf-8?B?elowRmQ2SnY4TWNPekVtRTYrV3lSN0Q5SnQrK3VNdzJydTF0R00ydUpKSUZl?=
 =?utf-8?B?ek9ZdWIxNkJKOEtkNDY3SEVxOENsUWVaaGY0Zk9yK0NwazFqcVFaN1g1UGNO?=
 =?utf-8?B?Y1BPZnFyZnpkV0VydlIyMkxkWmRzVHZ4NFMzRVJVSFVVcGVPZ1Y5RlZSWHMv?=
 =?utf-8?B?NFd1QllQV0xVd1cyU3ZoZmxXR0tRSXlMaW1Kc3pCNzZiV1QzMmcwSFB2OFlD?=
 =?utf-8?B?YlVWaU1abUUxSGNyM2VmQkxmYUdiakYrQmVnTGdUN0x1eCtwN1JIcUZ4VmxU?=
 =?utf-8?B?L0RhM3FkaUtsdTNnVy9WNzNUTDFJYlR1bFNQNVFLeWsyMHVBd1dVQXZoRHR4?=
 =?utf-8?B?WnFJOEhwcnFkOWdDWGxwY3J6dGdYaHlxN2pYckZhMFk5OGxhWi8zaFhoTW04?=
 =?utf-8?B?Rm9oa1BuaDdsYWRQZ2hZUllNbE1hRmlqYWtWM3d2WkNHNU9kUW1kRlJUVEkz?=
 =?utf-8?B?cFd1elZIK2tzQlFPMHgxcFlGeGx1aGhmL244cmxxSFgxYkluZlBiMkU1VmMv?=
 =?utf-8?B?ZlVwOFJMRkFpY2FTRG44TmErM3BVSzRZNUVqUFZUYVlUSFl3ZTBvdEtHd2F5?=
 =?utf-8?B?cVV3K1pObFR6UWNDOGtWbDE0UnhHZWVsVWlYVk5BczJEUWlEM2pSZmk2SFQv?=
 =?utf-8?B?WWdoaVJteWJDdDNCS2Rob0ppMjJUdlpLaVoxc2IxSzhyRHNTcGg3Vjg5SEpz?=
 =?utf-8?B?VVlXMS93OEJNN3hmMTN6ZHFNcXd6ZmI1MlVHNi93UGJhbkovNFVRdXdhV1Iz?=
 =?utf-8?B?OEJQVjNOczR5ZjUyT1VuVmVXeDA3L0xYMGNzajI5MXhZNEdlUXk2WHZ5ZlIy?=
 =?utf-8?B?dC9LNEI1Zk0yTHFSREc2Z2k2Q1c0NFR0MEFhVkkycjFtdFVvUTRJN2RIR3hk?=
 =?utf-8?B?Z0wwL2ZvcFdid1N2THlweng3Ynk0cnhHeTRXQ0dlaFFoeVliZXNQUDRmaFdV?=
 =?utf-8?B?SXFydTJ1ZlJUSFp1UjBNbkFWdklMckdwWjZ5RUppRnVjRHpTZzU0NzRoKzlT?=
 =?utf-8?B?UlFMK01hWkVNSWJJdUttdWEwVzcxcWVmS0Z5Y0x5S1Zwa3JaYWVXeXNCdjJN?=
 =?utf-8?B?ZlZBTjJPQ0lpTG9Rc0dmbW04UnlkdUY1MVJLUzJpSHdYc1JjZmM0QS8xWWxr?=
 =?utf-8?B?VkRPSkIrRnFpOUxodjlJUlJKV0lNYXNiRXh6RXBBUlF5eXFXNDVzOHhkdG41?=
 =?utf-8?B?NVJaOW93YmVvTDBnQXhQQTl6dFZxbEQ5b2JVVHBULytTVlBFTHROVUp2Uzl6?=
 =?utf-8?B?UW9KdFBuakhMeFBCd3NNRytPc1lVTWR5NE40UmdDajBmM1BUSXFLNU1rY3ZK?=
 =?utf-8?B?Sm4vd3ZuTzdxUmxlOWZVb3NWSExPUTZHOG55ajJTeFBWcFRoS2JyZ0liVEJt?=
 =?utf-8?B?aW0wbmEwcWdwdkV2UXlGUEVYL3RPckpLMEtFVlcyUlE5SU1rTkRVelhOaTZw?=
 =?utf-8?B?cURjbHdoUTZYWWtyTkdIcFpYcFBkdEtlbXdmV0MwdTlVTEhOcjhSdUsxMXBm?=
 =?utf-8?B?c1RuNUhtTnplbXBEQ2gxZG5vSzNnUk1HMm1IaTNEdmRTNnV5akZmNGQxdXp2?=
 =?utf-8?B?VXpwWUZwUFppaktuMjJPdStrNGpwaVV3eTlYcGMzUEdtV3JnSDBUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb11b4a-ca2f-4a57-8eeb-08df17efbf45
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2863.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:50:58.5002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4nSaDnaOSKJceZsFxOzCFSkDMyDbHSLDWzKt0slQpBEUxEMI58d26sNs/EkhT4XuuFxHG64tIiAGdRGIA0mxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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


On 9/21/26 10:40 AM, Shahyan Soltani wrote:
> On 9/18/26 3:57 AM, Christian König wrote:
>
>>
>> On 9/17/26 21:58, Shahyan Soltani wrote:
>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>
>>> For now use the same logic as the existing one, but it's not 100%
>>> correct since:
>>> 1) most operations don't need the GPUs
>>> 2) some operations that need it are actually deferred
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 4e4814caf61a..6edd03647c2d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -978,6 +978,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, 
>>> void *data,
>>>       if (r)
>>>           goto error;
>>>   +    /* FIXME: only PRT operations use the GPU to update mapping, but
>>> +     * some operations are deferred to fences callbacks so it's not
>>> +     * trivial to fix.
>>> +     */
>> That comment is not correct, just drop it.
>>
>>> +    r = pm_runtime_resume_and_get(adev->dev);
>>> +    if (r < 0)
>>> +        return r;
>>> +
>>>       switch (args->operation) {
>>>       case AMDGPU_VA_OP_MAP:
>>>           r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
>>> @@ -1031,6 +1039,8 @@ int amdgpu_gem_va_ioctl(struct drm_device 
>>> *dev, void *data,
>>>         }
>>>   +    pm_runtime_put_autosuspend(adev->dev);
>> That error handling is not correct, after the switch there are a 
>> bunch of returns and gotos for cleanup.
>>
>> I strongly suggest to use the guard approach here as well.
>>
>> Regards,
>> Christian.
>
> Thanks for the feedback, you caught something I completely missed. 
> However I have a few concerns
> on what approaches I could take.
>
> Attempting to use a guard in this situation would require the guard to 
> be moved to the top of the function,
> resuming the system much early in the stack.
>
> As far as I understand this is due to the guard not being able to 
> succeed any gotos as the "lock" variable
> in the guard must be initialized before any subsequent goto.
>
> For example:
>
> goto error;
> PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>
> Is invalid as "lock" is initialized after the goto.
> Trying to initialize lock beforehand doesn't work as it would count as 
> a redefinition of lock instead.
>
> Would that still be preferred over creating a new label and trying 
> something like this instead?
>
> replace
>
> +    r = pm_runtime_resume_and_get(adev->dev);
> +    if (r < 0)
> +        return r;
>
> with
>
> +    r = pm_runtime_resume_and_get(adev->dev);
> +    if (r < 0)
> +        goto newlabel;
>
>     }
>
> ...
>
> + newlabel:
> +    pm_runtime_put_autosuspend(adev->dev);
> error:
>     dma_fence_chain_free(timeline_chain);
>     if (timeline_syncobj)
>         drm_syncobj_put(timeline_syncobj);
>     drm_exec_fini(&exec);
> error_put_gobj:
>     drm_gem_object_put(gobj);
>     return r;
> }
>
> Another approach I could try is wrap the 
> entirePM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); and 
> the subsequent switch cases before the error handling into its own 
> scope with {} However, I feel this method is a lot more hacky then 
> necessary. int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data, 
> struct drm_file *filp) { ... + { + 
> PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); + + r = 
> PM_RUNTIME_ACQUIRE_ERR(&lock); + if (r) + goto error; switch 
> (args->operation) { case AMDGPU_VA_OP_MAP: ... case 
> AMDGPU_VA_OP_UNMAP: .. case AMDGPU_VA_OP_CLEAR: ... case 
> AMDGPU_VA_OP_REPLACE: ... default: ... } if (!r && !(args->flags & 
> AMDGPU_VM_DELAY_UPDATE) && (!adev->debug_vm || timeline_syncobj)) { 
> ... } + } error: ... error_put_gobj: ... } If you have any ideas on 
> what approach I should/could take it would be very much appreciated. 
> Thanks, Shahyan
>
I'm not entirely sure what happened here...

But I meant to say wrapping the guard and the subsequent case handling 
into its own scope.

For example:

int amdgpu_gem_va_ioctl() {
...
     goto error;

+    {
+        PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
+        r = PM_RUNTIME_ACQUIRE_ERR(&lock);
+        if (r)
+            goto error;

...
+    }
error:
...
error_put_gobj:
...
}

Thanks,
Shahyan

>>> +
>>>   error:
>>>       dma_fence_chain_free(timeline_chain);
>>>       if (timeline_syncobj)
