Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF0BC982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 15:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D57E10E8A4;
	Mon, 21 Sep 2026 15:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ur5ZU8aK";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D8E10E436
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 15:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDvPsh9BzKLva3x7Enfy8RMHk3NdjiEqSKqUP4tFw2xlnyG4N30xl789vgONYDZequFcDkuX1hpTQLF/eXJYhR6KlUBnr0KHuVewzMp9Bdr2j/9s9YoR0Gk/8Jo0iIMqAUonR0l84KsoZi6WC3eRPoxJbFtX14nl/R7ElfozuT1Lr4rfh7kxIPXB3et6sUxmpOZWbXlKfK5ScAR11H6gCwlzSNx6z/3Dvik+g9R0uIJnLwmpRElbvEdkAE+ncqbQjrmOTNlqFVT/aZVUGE+cz4jh/jn4IAkVCV2zOdBlM42bY+khrwmr1YTFGTe1ssgCGRHDK24otZeyCCTyeVPOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKmURSMj8Ck3JnULi285wtQFuRlLj76LXQQLBgW0FQg=;
 b=JDxPr3PuULWrPpKcTk3wA3hhtXve4RY05ek8Dz7Bq2QdSyPGYbj7ToAZqwJmApX8pSKJczjUBi3CVmV66DuYhqLad35p/sE8K9Phe++B8Zc2UAMuwgdbF2IIXTHdiYh8A1PwSLYdsREWnIdxzqb8MsOYzq3Ch0MGxeOr0rsuLBeC5YOfYm+RS6YPWuoiow9a9mGegNFPsXVaS1zrqA6swYZmeerLj65SoETZZK58X8EE3BjP7nshpVgppedNxlibmIbi/LAaejNm1LkGJvEW6GGglWt/rgzlXYlSBzPW+iCs7tQAAqf8seZSJmXEwgxeF/hC8oVQCmlJimUu2pCqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKmURSMj8Ck3JnULi285wtQFuRlLj76LXQQLBgW0FQg=;
 b=ur5ZU8aKpp/u8rvZxRd1ad1nLLGtmi5/s9DfG/b2U0hh1xzwSi3P8kZsh2og5n3NSycPyDxNLbe76QqD0evBVJ9pNlZ21L369EopTvnNVaRinVvQ/pLYbCGyzFXA55nNa3I1S/vHZ/dcmoZlkZfrM+JmbgSVbyauSVtsjjv7dCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:07:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:06:59 +0000
Message-ID: <0cefdcf8-8afc-466e-8f5c-18d681be47a7@amd.com>
Date: Mon, 21 Sep 2026 17:06:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-5-shahyan.soltani@amd.com>
 <2d2520d8-6477-44d0-a298-37bd078da24a@amd.com>
 <e77dc3d3-eec6-4b54-8bd3-d2b51591bca4@amd.com>
 <b4c6676f-9333-4bb0-9861-3ecc3c72f350@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b4c6676f-9333-4bb0-9861-3ecc3c72f350@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ba0476-c96a-41b1-e2f2-08df17f1fc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: SVaTHQTtQX2CI+wb7+W2BFFenLlG/2RqQPY12amc9LU49kOn794jVBaoZMsbfmQPzyPFhfdSmmEZdt3TDiMG8UNv6oVp70tpo21Xa0kkyehQzj3k8xXXsHXITiea/070DqjYw5fRxzXaFO8jUhNdbzVom/j9RiLuBn54vjAGCu7V5OF2DF4S7LAcRdG4XtO/Cb669pt2aYoAg+bh1DQtOsT+LrErcOWuNx8/VbvhvB6neKubnlshYexq34m5XUFkzx+Uo8eezUSnVoOXzRIhEVm+//FdusXCOkddu3RI0oBIz6SS3tOnPFf+4TcFpJUsSgQflP01hME3wGjAa7YdRSTp7bjIBsZMHZ8Dyy6RkNT/LlHWlYzaOI6BiRT1RXSSJFOgt9OGzR0EAhph/QrEO2fNEOOlFV8lmiFdwGPDXwSoKZLBy12BYPW+J1HTG8Fyt1HmEc1t+Sp8181jYOjnzwfqox+Fbs3n8iQ2R0sXwYNktLBR/AJHJtTmAwMhiH8uLGo3uLENSy/TNYP1NfRED6V9JsBNi+4ZLw3AQgzjDstT2erMx76RhuGkgBDgisegTCyA+mBSbZbQYGKxmn6f/YRRSJhNM9hQmJyYhU01RCxqBPIxYb5/XaUKdLdpPYQC1PaQa3swyOCJcLIuaKgl4p52iOwliUBqgMYBnm5vjH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NObExsZGgzSm8rRjhoTDdLb0RJeHp6L0UxRGpjbGlYQThvYk1ONEtGRlFi?=
 =?utf-8?B?MU5IeWkvZnJqdHFudXd0dkxRd0NCY2VqSm1aMHBDQU5tMnh6N3lSaUFaUEho?=
 =?utf-8?B?dnovRnVRdFJnY01mdmdBSjU2WFB5dUZlRXNXTVk1dVJ4UkhNcUZLeDdHZGFX?=
 =?utf-8?B?VzRqbWNVSFhnZW1VVFJUemxKWko1THMxMFNXNmZIZmRDYWJ1YUhPZ0tZS1Fk?=
 =?utf-8?B?bVo0L0pLTDF5Qlh2VEdYVm5wMmFZanV2WEViellpMWUrcmx0eGJRcGZLbndD?=
 =?utf-8?B?bnF0QXRPV3VlUnEzWnh0VFF0a1hSY3dFUkhEWitUNFppUDl0aUwveVp2alNs?=
 =?utf-8?B?cGkrd1hWdm51c1ZMc1FQd0xiNk11UmJxM2gyWXNQZGNPTnd0c2VEamdYTVh3?=
 =?utf-8?B?TjA4eS9ZRGkyWWhKVUtvTENMdFFLdEJJb2wvNEp6Ti9sMGpaeVBuZjJNY1RE?=
 =?utf-8?B?UWNwOW5pcW9LaW9Ebjd3U0xGUjF2Z2lVa21Pc3dzNjA5RTF1a0R5ODlMR1k1?=
 =?utf-8?B?MkQ4U1cyeUhSUnRmSmN0V3h6NjRnZGdEaUV0KzMxOEtCOENqMlB3VTFpVDVu?=
 =?utf-8?B?S21LSWFLbHF2enVHbUlEcklhazhFM0lhRi9HOWtiZ1kyM3BRek9DRmNrczhK?=
 =?utf-8?B?OXlISFNNdXQxZDhSQWlZZjJvSGswbUdjSUtrUWdudm1NRTVPUjF3SUhZNnp3?=
 =?utf-8?B?MldRVFFnZUFkc0x0Zi9NMFB6bzdHOVNDdFp3QTE3NHp2TVNtMGhLeGJ2bkkw?=
 =?utf-8?B?dHdGUE8rSTBXM1p3aXk4U05UZUJ1a2cycWg3SGV0RC9ta0VHUXZ6cWFZTEhN?=
 =?utf-8?B?bHEzOEdiWUVrRGVLYk9iYVVZY1c3U3BTb2M5YWM4elBUM2djbWF2NHNTUWJS?=
 =?utf-8?B?SXl6WEhDNXZyaEFyaVJaQTAyMWk2NVQ4SHZNblB0U0dmV0YyYXJBb3pDdllt?=
 =?utf-8?B?Y1BBbEdqczNCY1VtMXA2K1did29VODNaMUdUOThDUUcyZ0krdnNGZkFxRTdW?=
 =?utf-8?B?QUw1VU9tUktzd1ZwQ0xtamhHWVRJMUtxRkZhbE8yeVJXQXEwRUcyemVEcVNt?=
 =?utf-8?B?bFJWMHZoOXI1ZEhFeCtjSTBuMGpWK2wyL1VVM0ptRXFQZ1VaOFFkNDBpd1dS?=
 =?utf-8?B?cCtaRCtBbDU5UkEveldUM1lRcW4xY3A2VmYyUitHUmpEMUdRaVBZRXA4Q0VT?=
 =?utf-8?B?WWQyb3kyblExNzM4YVAxbnZLTHl6b05HblA3NTZncklwSnZBa0tIRXVGQTh1?=
 =?utf-8?B?TjhWcit3UVM4L0oxcHZncnVnWkFjVlNYd3gvNlVqQW4rWURNZ2ZkcGwzRldU?=
 =?utf-8?B?NjJNbFRhOXBWeTNnM2FLUlhHKzNjdXR4M2RQd2srS2U0cVhGZzU1YnRGRjNP?=
 =?utf-8?B?OGxtMW0rVlhabUJFd2NHVzNad2JtZ0ZRdEpPTkcvMCsvWmx2b29qV3ZmWjdi?=
 =?utf-8?B?bFZraFNJck1KVHVKRWJoZDAraGtUcUNGeDIyQUU2ei9BeUYrNzlSbWlTN2pX?=
 =?utf-8?B?d0xwOGZVaGtYVGF6b2liVEVxblVienA3VWMwVSt3S0xFTWIrY2lCdW1LKzR4?=
 =?utf-8?B?bkxHV2Z2NkJaSzQ4NlNQb0hVRWxlcjVZNkt5aXJBTURwVmFKSVdCcitGV3dC?=
 =?utf-8?B?WUFWTzNHbkhSSGRrQ1Ewc1p6OTdmZmVlazhDYlpNQmtXaThwWGtUSVVtSk0w?=
 =?utf-8?B?QnZlTmRaei83SUhPeTM4VTRZR2VtbERGNTlJRHE3a0xpQkNpOCtybFhabnNv?=
 =?utf-8?B?N1Y2V0Uycjg0cTRkUFM1aS8zNVlpOW5vam1tWUwwYVZNWVRUZjhMdVdoVFEy?=
 =?utf-8?B?UHpILzdBazB5a2NqbGlKeXNORzlNWFJWK3lZTGM1Yk5nSkcwY0hnSWpTby9C?=
 =?utf-8?B?eFFvaEpEbklYV081c0diZmExWWlsYStRSTNrMGNwSGxGdjRMa1FaRk9TbUJE?=
 =?utf-8?B?ZkJ2cnlKYTlwWld3Yk41SzlMRXlnLzZyc1FoK0xLaEswSXpOdnJkbFFPVkZl?=
 =?utf-8?B?eTYwNWFVeWZTZysrSFVRT1QvVHFReHZZOVYrT0hmcjgvQkdYWHRBdUc1TStY?=
 =?utf-8?B?UC9GaHpvRHdxd0wxL1BCVnVPWW1jNlhXUUswOW5UbnlHbkNBQjRTckZYSllT?=
 =?utf-8?B?STZISkpMeDVLOENFeEUzOWhYWVpEMmhuU3BrclpnZUpFbEp6UXZIdXBRTllw?=
 =?utf-8?B?K2cxaFUwOThTNWNjaDVxQVlXcm5XK2hwT1N2bTZpMUlkU01lU3piMVJVOUJM?=
 =?utf-8?B?aHAySUJsWE1QQ2hzQ2U5TmVPY0drU1d5YWZPcXlTNTJFVi9xUDFjeXl6eWNt?=
 =?utf-8?Q?o2uupexRXRTJdM9bUU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ba0476-c96a-41b1-e2f2-08df17f1fc46
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:06:59.8384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa6cucgQJ9Lgna6Li6U77mmnTvyPP9kW7PD00I3wWxRhWS/iotkIkU4zIzKeuWhI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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

On 9/21/26 16:50, Shahyan Soltani wrote:
> 
> On 9/21/26 10:40 AM, Shahyan Soltani wrote:
>> On 9/18/26 3:57 AM, Christian König wrote:
>>
>>>
>>> On 9/17/26 21:58, Shahyan Soltani wrote:
>>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>>
>>>> For now use the same logic as the existing one, but it's not 100%
>>>> correct since:
>>>> 1) most operations don't need the GPUs
>>>> 2) some operations that need it are actually deferred
>>>>
>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> index 4e4814caf61a..6edd03647c2d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> @@ -978,6 +978,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>>       if (r)
>>>>           goto error;
>>>>   +    /* FIXME: only PRT operations use the GPU to update mapping, but
>>>> +     * some operations are deferred to fences callbacks so it's not
>>>> +     * trivial to fix.
>>>> +     */
>>> That comment is not correct, just drop it.
>>>
>>>> +    r = pm_runtime_resume_and_get(adev->dev);
>>>> +    if (r < 0)
>>>> +        return r;
>>>> +
>>>>       switch (args->operation) {
>>>>       case AMDGPU_VA_OP_MAP:
>>>>           r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
>>>> @@ -1031,6 +1039,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>>         }
>>>>   +    pm_runtime_put_autosuspend(adev->dev);
>>> That error handling is not correct, after the switch there are a bunch of returns and gotos for cleanup.
>>>
>>> I strongly suggest to use the guard approach here as well.
>>>
>>> Regards,
>>> Christian.
>>
>> Thanks for the feedback, you caught something I completely missed. However I have a few concerns
>> on what approaches I could take.
>>
>> Attempting to use a guard in this situation would require the guard to be moved to the top of the function,
>> resuming the system much early in the stack.
>>
>> As far as I understand this is due to the guard not being able to succeed any gotos as the "lock" variable
>> in the guard must be initialized before any subsequent goto.
>>
>> For example:
>>
>> goto error;
>> PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);

Oh, that is a very good point.

>>
>> Is invalid as "lock" is initialized after the goto.
>> Trying to initialize lock beforehand doesn't work as it would count as a redefinition of lock instead.
>>
>> Would that still be preferred over creating a new label and trying something like this instead?

Yes, as far as I can see the PM reference just needs to be moved before the first goto, right?

When I now check the code, the first goto in function amdgpu_gem_va_ioctl() is that here:

        /* Add input syncobj fences (if any) for synchronization. */
        r = amdgpu_gem_add_input_fence(filp,
                                       args->input_fence_syncobj_handles,
                                       args->num_syncobj_handles);
        if (r)
                goto error_put_gobj;

        drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
                      DRM_EXEC_IGNORE_DUPLICATES, 0);


We can't grab the PM reference after drm_exec_init() anyway because that could deadlock.

So that should still work as far as I can see, or do I miss anything?

Regards,
Christian.


>>
>> replace
>>
>> +    r = pm_runtime_resume_and_get(adev->dev);
>> +    if (r < 0)
>> +        return r;
>>
>> with
>>
>> +    r = pm_runtime_resume_and_get(adev->dev);
>> +    if (r < 0)
>> +        goto newlabel;
>>
>>     }
>>
>> ...
>>
>> + newlabel:
>> +    pm_runtime_put_autosuspend(adev->dev);
>> error:
>>     dma_fence_chain_free(timeline_chain);
>>     if (timeline_syncobj)
>>         drm_syncobj_put(timeline_syncobj);
>>     drm_exec_fini(&exec);
>> error_put_gobj:
>>     drm_gem_object_put(gobj);
>>     return r;
>> }
>>
>> Another approach I could try is wrap the entirePM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); and the subsequent switch cases before the error handling into its own scope with {} However, I feel this method is a lot more hacky then necessary. int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data, struct drm_file *filp) { ... + { + PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); + + r = PM_RUNTIME_ACQUIRE_ERR(&lock); + if (r) + goto error; switch (args->operation) { case AMDGPU_VA_OP_MAP: ... case AMDGPU_VA_OP_UNMAP: .. case AMDGPU_VA_OP_CLEAR: ... case AMDGPU_VA_OP_REPLACE: ... default: ... } if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && (!adev->debug_vm || timeline_syncobj)) { ... } + } error: ... error_put_gobj: ... } If you have any ideas on what approach I should/could take it would be very much appreciated. Thanks, Shahyan
>>
> I'm not entirely sure what happened here...
> 
> But I meant to say wrapping the guard and the subsequent case handling into its own scope.
> 
> For example:
> 
> int amdgpu_gem_va_ioctl() {
> ...
>     goto error;
> 
> +    {
> +        PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
> +        r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> +        if (r)
> +            goto error;
> 
> ...
> +    }
> error:
> ...
> error_put_gobj:
> ...
> }
> 
> Thanks,
> Shahyan
> 
>>>> +
>>>>   error:
>>>>       dma_fence_chain_free(timeline_chain);
>>>>       if (timeline_syncobj)

