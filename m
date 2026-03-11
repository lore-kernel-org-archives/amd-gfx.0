Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFC51125847
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 15:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD8810E066;
	Wed, 11 Mar 2026 15:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4e1hOBzF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D9E10E066
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 15:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOJ73Q959lCTiEnSPGQKzVBGAduFiuc5Wj9jnJCDY8BwCQoSqdOlOHOZuTr6GbnsJ6SvxZITCorRDuXXsVXub/jG3NfGLEM3Zs+dobU8cwjq09oUjkRa1FfZNodX3lD7SRx3L6AiXYjnWQ1auUwxgSdrFzt8T63XcwfxYo7Ern2lozHp2Bb5jOlqCee0vHcD0cnaYmekU/9Arv/oxC9tx7cqVzRWmtlQAuF/MC1o3Jl2x9jOfcEB6ikJstHQwJVCboomFA5q6IzrYBhaV+QTYoMYylhtPekY4yX4Veb1tP4ujEjUjvavXhRrEd8tGMcVobhdwfT6g0mw1U5C6j1XnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/tb+eEhdsFkbLwj1ltXU2IulZXFDpT8BKGmSkUB2Qg=;
 b=c/lx24SiaDzdv07Uvh6+0bxzrAXTWbQdq3zXWa8fhNsb4+wB601qheNNu+rM5/dePcOD1UBeidl5SgT4MBhl941fs3ZUKWOUMVWCbrHVYgGshXw7uW9zvIw1uNa31apIDH3LrPrpQo6R8GyJVWMohnMmv6H0Z9fqtHm4w39CIct0be/sAw/IVrVsWrBYWXhZjWOQfGQJMOp20RpeSEMt18iyfEEKx2ZAzDKkpkb9KRllCkgpRqoeiHhpXk7IzSn2jobH9KQI1l1AFSvl5IyiHvPvaj+e53sviQAOfvfbZA2LgNAJUgkGMdQkNhFnD8H7BboSzdxhshUoMj4pxNTbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/tb+eEhdsFkbLwj1ltXU2IulZXFDpT8BKGmSkUB2Qg=;
 b=4e1hOBzFiLMuidg1W5gNTqEYMiDu39NEIMcomvwc8H8RRKSzt+l3B2/x422iB4MJ4ZaqeVlxzHyxBjeZJxg54rY8HlK1ghfOSIJsUQi0UMPLCCdG0wlIUSif5VNAIijqmX3Ge6GBkARy5Fpn8ek6PA4Opaplt4Ekd7gAQPDU6Is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 15:29:31 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 15:29:31 +0000
Message-ID: <46fa7959-ff84-4ea8-a17b-3825876b64eb@amd.com>
Date: Wed, 11 Mar 2026 11:29:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, mlimonci@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
 <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
 <0fb83ff2-33ef-443d-a4a1-1608d52d34cc@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <0fb83ff2-33ef-443d-a4a1-1608d52d34cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: e52d3962-2022-489c-5320-08de7f82fd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: taxxUDXsgJ9zX6WiZ12Cfxf8KB+BR+67y2eTc9Y6mF8wgYHIrdj64dWgM7pOE6Y3O9DJkoa9VroLOvL9SvXRB8pq20tX4A/Pm7PYq9ZV7t5zeBUbUoAmwu+NIK0OAbr/u1QXRia4wjrLiwAKrF/izV4JyHbDvgvuf3G5YJjbSK6htfG1Gm2SRDOShT7Xn0G0NqyUbD0AGdO/mL53NVYG9EpLJjGe8hswM+pW4jc/U6z/RjhxUyQVWjLCtLGUW6iFAKKY7UKvXiQ2rWwE8RZdfKiaAp+YwhMdQYUxe8NiqEPHhBrY2pUXzxzqZ57mGQ5VdMD3Pwjo0Z1xpvJP/xCRFDOxULrDXD8UbT/RWrIswoqnPAXsh7AYbfEmyw46G66sRu5hhKD9uB+JlIMEbJrx+/2/r/Ntza+1OC9qU8U4+BxQYUyrzqD5m6tBrEWC6N1AIeRrCUC8Leh4kEGc06tRz/clMjsvf3uma9k7HRANPqTNTT80SEtS2C3OblAx020kU6F4B9nt43w2i05RhMy93lUXoEwfsrWPDgY+EURiYuQaF1iikeSVcIwCGQOS9Fcunikkr+g+rdkTap/b2Q+WHkx6Z9mGuHvCEoU6TeOieNd3riFER/eNtXyYyprS8jlP009d0gYfxWy+T0duRdo8wNtHclW4M2jGVN2nXqELn1kI6ws3cpMyDEmuQvE9ANn1euJj4MV4PT3akQh6vF1fTDteZp9XAKzBkEZNxsrI8QTwNPQF8LCc2daz1w4L/4a3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVHWFZ3WU1KRjRybVlzREkzQ1ZmWTlIcUg0T0kzRE5uZksyZzI3SlF6OE9z?=
 =?utf-8?B?V0UxNjBKb3gwcW1CMXF4ZHFibSs1TWQrRXlHV3VvSTMzQ2tvai9aQUtnRFV0?=
 =?utf-8?B?V0cwNXhINVJlemRzOUJBMjR4WWIwNml1ZEhRN1cxSlZlVFlOYm5YUnZSMTZZ?=
 =?utf-8?B?ZG5ZTHZWelA3Mk5iQytXbjI3aVpGaDFydzFXSUQxdXN0QjRvZnJSMnBTaVRj?=
 =?utf-8?B?bEU3aGFrMTVJVUJFRWQySVpnLzdkcGNWNDVFNFhDMko1b29KTGJrZVhLU1RK?=
 =?utf-8?B?bVlOeG9qa0p3ZklqUXpaRUhNSUhnd2xtRUJxTUhBNFlpdGMyUUZ2ZmtJanI5?=
 =?utf-8?B?V00xY0pNcjR5ZTYrOUlPMVFxdlpibnpna0xadXI5UDNtTTh4K1JmT0NybTlo?=
 =?utf-8?B?dkRyaHUrTXkzb2U1Mm9iNEpzekZzT245NEpyKzRBVkxROUsrSzNMN0dPNFlh?=
 =?utf-8?B?b243UHZRU0pKUzFXcG80NW9VeFdsNVB3NHhPSVRSYTNtbXc5UHJISWUxYURw?=
 =?utf-8?B?d1NXUWNpNjJMVThCT1UrZkhqWS9OTU9OLzlqMURJS0JnTWcyNHphWHZlODFn?=
 =?utf-8?B?ZGZ1TG9EV2c5NTdZUkV0UVlUZEE1M3RBK2hzSWJsRktab3BpS0FxVUc3SnAx?=
 =?utf-8?B?MTBrLzBWclpFWlA4bUdiZjNJTWFqNHVrcmtHWndIcHJDMTkzS2ZhK3NNNEhx?=
 =?utf-8?B?bXUzbGRyUThpQ1NNSDVIWjd5UzRJTkMzYmxyK05wS2R4clRVK0t3WUNoU2tG?=
 =?utf-8?B?RHJPOER2a0F5MUFJanlwd3c4akF4eUFuSzFjZnR1MW1KcWtwNkhvYWZ6eXJS?=
 =?utf-8?B?TmRQYk40ZmI3dmk1SXhPTXNBalNicmc4YnI1eHFsSlZ4TXUyVjg2RnpzcHJh?=
 =?utf-8?B?L2Q1T0NSWlFaVmlhU0laYWlBckxKeVFPdDNXQlFocFJJa0xMbG1nQmg3eS9u?=
 =?utf-8?B?NDdweS9icERuS1JmaFNoOWxURHByMjdwMjBGRzdMZ3FiU1BVVlAvbmVHWjhH?=
 =?utf-8?B?bDR5VUhUcUhrY3FGVTdFQ3R0b2FzT3g0Z05SZXVEOEhTWjdOenZIT2xNT3hF?=
 =?utf-8?B?WjArb0phbENYc1hXRnorQTZEOFR0a0Z2cG90elV4dFIvRmV4TjQvYjQ0dkVw?=
 =?utf-8?B?aUdPVDI5T2hYNXBnZUIrMEVpOGttampjT0FjdTc4TGE3OTE3M0tPYTE3TnpR?=
 =?utf-8?B?eXNXTlFXa3hNQnZhWmpvNk1IZlN3cng3QVQwRmxLZlZ5L1BUQ2hPSmZZSnJh?=
 =?utf-8?B?V0pvNjVYVUZ3MGdHaTlrTXowNzVYdVBIQ2t4SW00T29EV2t6OUxJUm90Wngz?=
 =?utf-8?B?TmI4MDlNZTRna2tJSkdXSDRJNVZYUDlIQnRXMENFMjVITmd3MEF4ejBJcWI2?=
 =?utf-8?B?bnY3NGVSM3hIMXRSWDNlMG1ZTFI2cmxZM1VIa2haWjBFMURzT2tzVEp3Mi84?=
 =?utf-8?B?TDR1dmlrMWM3RTUvOWxWVmZiL0FYTTFtTmtPMHluYmVBZnZoYlhlRXB5ekZG?=
 =?utf-8?B?TzN0RmxITzJ1WVpVTFNnVWlJR0srZUo5YVh2VlhWVUxPUFZCcjJxUzRZaXJ1?=
 =?utf-8?B?cFMxZXR4OU8rc3NmSzZaUllSYlEvcjBVaHNlSk1TUEF5RExNUW1zRGtycFJT?=
 =?utf-8?B?NEEvL0hUT1Z5YlYwcDFaZkpzNWxKL2dMd2hZUnFPVG9JV1BXa0pRQ09WdEtE?=
 =?utf-8?B?VUx1Ym5yaGl1QlUxbjBmQUtWRlE3UTJvVEtJMzA0NE81TGhJYzNUdUladEw1?=
 =?utf-8?B?VjBRbXZlbkJESzdqbUFpS2NSd3NUVFdSM1ZobDgwOXhhUXpvSUNUWmxkVHJv?=
 =?utf-8?B?TU9JN3hyMytFWE1JeHdRZWxDTFlXMHNzemx6MTRqOGFRaUM5REY0NUpaK0hH?=
 =?utf-8?B?NTdKNWV5OWZhMVVZZFowelhES0VZd2hvOU5QTXg4M2xUV0ZFQ1ppWElEVVRR?=
 =?utf-8?B?dkJRc1pCcFl0alJZcHBpaEZJRkxkQmVCajRjVi9hVWxlbUV6SENaU1UycStB?=
 =?utf-8?B?cXUvQWE0UWtsYXB4ajkrMEM2U3JCNjFpd09jRGlPY21rbkFZTG56NE5GUEVP?=
 =?utf-8?B?QnVOcDhRWmluZGtWYXZzNGJKUnpHM1A0cThmLzhlbkhKQkFhTFVETXppeXFk?=
 =?utf-8?B?RVFnL2lpWVdmUDJKbFp2WFpJOFRGZU9ZWFZXQlBTdmptc25nbWpKZGV0WXp2?=
 =?utf-8?B?Sm1QMXJwZUw4R3ZibkVnSkhOSnVIZzV1T2tYVmliRkdsektqVE0yTm45bDhs?=
 =?utf-8?B?YkkrbzFlSDVIVENGRTNraWhwbG5QQXo3SmtCTUhkcEI3OGZKWG9VUE9OUkdq?=
 =?utf-8?B?ODJDcGxFazFjMVRhZlBKZ2ZyME80dDZzRGUzMFpPNWd2QytFdHFvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52d3962-2022-489c-5320-08de7f82fd47
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:29:30.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9xuWygMko6rq4RK/fsq+6Ny1TwMsvLq81UQ1fhYutJ0k8pW6zWYVvBfWy5XGej1M6nIZk3XaIYkwDbMLWR9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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



On 3/11/2026 1:26 AM, Mario Limonciello wrote:
> 
> 
> On 3/10/2026 5:52 PM, Nirujogi, Pratap wrote:
>>
>>
>> On 3/9/2026 5:58 PM, Mario Limonciello wrote:
>>>
>>>
>>> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>>>> Add NULL pointer checks for dev->type before accessing
>>>> dev->type->name in ISP genpd add/remove functions to
>>>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
>>>> ISP driver dependencies are loaded in correct order.
>>>>
>>>> The regression was introduced in kernel v7.0 where MFD ISP
>>>> device enumeration doesn't complete by the time it is added
>>>> to gendp. The timing of ISP device enumeration has changed
>>>> because of the changes in registering the device sources in
>>>> the device hierarchy.
>>>
>>> It's a little bit pedantic; but I /think/ there are two different 
>>> problems here with two different root causes that both happened in 
>>> 7.0-rc.
>>>
>>> As a consequence I think you should have this split out as two 
>>> separate patches in a series linked to a Fixes tag with the reason 
>>> for each of them.
>>>
>> Hi Mario,
>>
>> Few things to clarify before I split into 2 patches and submit v2.
>>
>> - Yes, you are correct, the changes in this patch are not directly 
>> related to the Fixes tag 02c057ddefef mentioned. But since it has the 
>> dependency on the below patch for automatic modprobe of isp to work, I 
>> have used the same tag to cover the dependency. My apologies if this 
>> approach is incorrect and misleading.
>>
>> https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/
>>
>> - NULL dereferencing issue with dev->type observed on v7.0 is specific 
>> to this commit 057edc58aa5926d63840c7f30afe0953d3994fa3. As the wakeup 
>> sources are registered using physical device instead of ACPI device, 
>> wakeup source device (wakeup14) is added as the first child of AMDGPU 
>> device; and since its dev->type is not initialized properly it has 
>> resulted in segfault.
> 
> Sure this makes sense and is a no brainer to get in.  I would just send
> this one right now and we can keep noodling on MODULE_SOFTDEP (more
> comments below).
> 
thanks, I’ll go ahead and send this one out now and will submit the 
MODULE_SOFTDEP change separately after the root cause is identified ( 
more details below ).

>>
>> In 6.19-rc4 or earlier versions, this issue was not observed as the 
>> wakeup source device was never part of AMDGPU children list.
>>
>> For the changes in isp_v4_1_1.c, I will use Fixes tag 057edc58aa59 in v2.
>>
>> - MODULE_SOFTDEP change in amdgpu_drv.c is needed for automatic 
>> modprobe of isp (and other amdgpu mfd child devices) to work in v7.0. 
>> But couldn't identify the specific commit in v7.0 that is causing the 
>> issue. I can confirm it is not because of commit 057edc58aa59 as the 
>> automatic modprobe doesn't work even on reverting this commit. Can I 
>> submit this as the fix needed for isp probe to work in v7.0 without 
>> the fixes tag?
>>
> 
> MODULE_SOFTDEP is generally for ordering, but I don't think you have an
> issue with those modules loading before amdgpu do you?  I'm not really
> following why the modaliases stopped working and I'm a bit worried that
> it's papering over a more nuanced issue still.
> 
yes, this explicit load‑order dependency was not required earlier. I 
agree that the regression point is not clearly identified. I will 
identify the bisected commit and submit the patch later.

> To identify the root cause, it might be helpful to do a bisect, although
> it's a bit complicated.
> 1) At any point that has that platform driver conversion you need to
> either revert or add the change to auxillary
> 2) At any point that has 057edc58aa5926d63840c7f30afe0953d3994fa3 you
> need to apply the NULL pointer derf fix
> 3) At any point that has the changes in linux-media for API adjustments
> in 7.0 you'll need to pick what version of ISP series to apply.
> 
I tried #1, #2 and few other combinations, but none of them helped. I 
will investigate further to identify the commit causing the issue.
> 
>> Thanks,
>> Pratap
>>
>>>>
>>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform 
>>>> one")
>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_drv.c
>>>> index 95d26f086d545..920595f0d22ca 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>>>   MODULE_LICENSE("GPL and additional rights");
>>>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp 
>>>> pinctrl- amdisp");
>>>> \ No newline at end of file
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/isp_v4_1_1.c
>>>> index b3590b33cab9e..485ecdec96184 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device 
>>>> *dev, void *data)
>>>>       if (!pdev)
>>>>           return -EINVAL;
>>>> -    if (!dev->type->name) {
>>>> +    if (!dev->type || !dev->type->name) {
>>>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>>>           goto exit;
>>>>       }
>>>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device 
>>>> *dev, void *data)
>>>>       if (!pdev)
>>>>           return -EINVAL;
>>>> -    if (!dev->type->name) {
>>>> +    if (!dev->type || !dev->type->name) {
>>>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>>>           goto exit;
>>>>       }
>>>
>>>
>>
> 

