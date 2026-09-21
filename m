Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62538C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 16:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E908F10E166;
	Mon, 21 Sep 2026 16:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g6YIK7Md";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2F010E166
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 16:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+yKOugEh7bWEd2fjuSwed/evNTBc6nIKe+Kjvj3+DDqH7GtIk5seY63BUpE24L600ON5h5hBoPmQyqdRdZn4tMG7ogho0N8prKti47l0gmR9QyGZ8qXTOSJl/388HzVs3kzTvRR4s4J00N+BXc9N292xUe1MOkjF864V5UtoxNU0pZvu4ljCsQeUBdyFBOVjAkfmQ8QJnfECPU9wWwQR/KakDxpv2DCbAnbDNXP/Yo4AJg6it2BtKPFJNRi75QvrnOhg7PFDrTdJBi/rjJSwXEY8+krKJO6ubRODEZLD15tYlvg4UMUbyKFgkGGgwbe3VLCOQyw42UxZmpDRU8Jtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVfOSUxruToNdYfkqbOEoJpjBBMJ30wC+N88P6rjgf0=;
 b=fV3oVu4orBAWKJ1hN+0Yle2rZulxJ9laQWWfMLTbeqCEZAxBrz2UhwBenRXRA9GnDoeY4XtRFtf33Gc9PeX0q+A6NGw7Ppe/B4nQ4lMk2TtdSwLkpCUqIrCA1/tNaeeVLclyEx+J36D4c1MUI3PzbbFiarWHzwo9gANsaEYvjVWooXg4gfT8hCZ/xzWY46CpGJqV4AwoberZmvP6NWuMuy7ek3rMbnw/znftXjfbZA91MBykujT99+TWJUBNdf07OjeoBC+PgOjoFAkpcHf/SxrLvdfMsj77S14s9OIt66rGSXOJm7oblPQtBDLVHrKfEODzBNiRcQNN6VSPFqvxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVfOSUxruToNdYfkqbOEoJpjBBMJ30wC+N88P6rjgf0=;
 b=g6YIK7MdugCiQW/F2bhN4JWTU1m0vr7JZ5z0bvz6BpX9x5WkZsvv4bEslqIDPBQ+s/8o10ZprlxR2pxNSTrpxQ8EIv7FbR8pDijvaAo5tqfJNa5pdjZDDtb00X2F9s3D7f3ONUfZrm7sTWrf0EbOe7/ikdadTw8iHKlsa7qfoJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 by PH6PR12MB944609.namprd12.prod.outlook.com (2603:10b6:510:3de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:35:39 +0000
Received: from MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2]) by MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:35:39 +0000
Message-ID: <d7088dbf-99c6-42ae-b115-ee8931ec1edb@amd.com>
Date: Mon, 21 Sep 2026 12:35:37 -0400
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
 <e77dc3d3-eec6-4b54-8bd3-d2b51591bca4@amd.com>
 <b4c6676f-9333-4bb0-9861-3ecc3c72f350@amd.com>
 <0cefdcf8-8afc-466e-8f5c-18d681be47a7@amd.com>
Content-Language: en-US
From: Shahyan Soltani <shahyan.soltani@amd.com>
In-Reply-To: <0cefdcf8-8afc-466e-8f5c-18d681be47a7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::29) To MN2PR12MB2863.namprd12.prod.outlook.com
 (2603:10b6:208:103::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:EE_|PH6PR12MB944609:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1af1c1-bf74-465a-af1e-08df17fe5eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jgLAQ63qG8w4a/MfzgyM4Ez7Jocf2kKiW4TkQKKzyTn6DMGDH3RBHn/DsFByYxx/T9uv7oaoe572kVOK0vvZiwbjhuIQ1UT05SjQKKtR0zcQrPIJEYpzNjPX5eV8mRt6mWz2mMOguUhntBAOeruHs1lLBbj9BNzWnCb/zibzNwWbyMPFnAqDDLdY0MP4CcdhpDnXoeKOk4CSOf0sdPeMqgkyIxLW5LQUYaCFxkL2Np3T7lxjKPtrskrxL0LBHu32Fd0kkAMai8TFBPNMDAUx/8XKYaGqPt+w4wIT6TE3itQteBsRP8n7XKHgoXj9vIXvI00pVsvoHiG9rxYJf8PNolkFEZ3VIes+5EKWe7dKGzcBhcc/RZkUc4WBW4U19UseV36sQZJn34qFvfczpHWZX5piDo8zJhCkVHgctuZn3IRGWb5g85RsAyLmrvVCC8aNHsUyhfSDpuvcqKHSx+4i9OX7W1AC2sGqji3KVIOXTfhVZlG9Q0X5u6hijbr5AO+ko4hjqMWOrgQG8F4fgn7qHahC0ysxpRGqEpcBXOnFDPYyKJfa5Zp85BlovC+uyJXun9GYAgUJxloKnMbI03UC5gauQrKA3sA3ZX9oGoQW3VTq4APVX+W56lJZsprsI0Lk2G73fk9y/CUKXKnp18WacUCRnlTwZliVRTNXm0t+zdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2863.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThNRGxLOENzOG5pWmZpSEpKZDl3VCtHMzFjZ3p4UWxwYzdDWURuUDBHODB0?=
 =?utf-8?B?cVQ2NGk2VXFGRXZtUU1pZ29SUXZPZzVWQ0dHUGZINmw0YXBIa2Z1S3JPdEhn?=
 =?utf-8?B?QXhUY1NUMXp2ZTJ4L3c2VC84Tjd5anNMZFJWeHR1anpLVXJobWNiYmRHbFJN?=
 =?utf-8?B?WEJjdE9tcE1PQ3YrUEZQUEpyZnVpQU9QWExHNDBBWUtXeWxtY1NjVVhGZXRZ?=
 =?utf-8?B?d3JNVDdvUkhnOCtqMTZ2YTlVYk9rT2ZMbnF3M1FNVHpobU13dExSOHVZU2l3?=
 =?utf-8?B?QlpXdFpVMElUTVJxZFZPdGZWaTYzcnlMOGxITGNoYnFMZFpRQTkzY0ZLVmdw?=
 =?utf-8?B?TTk5MHM3ZFlGSjBwWlVra05oRFJSNk1ORDR2OU9jSlIzUE04aC92MC9WbTdu?=
 =?utf-8?B?SklFdGpidFM5QkhsVnZGc0JBc0ttdnMxS1FxZjdod0FMRHZQbnphK2crWDl5?=
 =?utf-8?B?SEZRcmx4V2tVT1dWNjFjN2orZUN5Wk82ZlhESFdEVS91ai9nVWhIMjB5Vk9F?=
 =?utf-8?B?NDA1cVB6NFFBNy8rTDRYZXZZM2ZZSkdPaXFxT0ZUS2VXVzJwUWpWZ2V0RTRW?=
 =?utf-8?B?T1BNK29tM294d3V2NWdQdW5TaWFYNUZEV3VmdTk4TTFLNnp3UWllZTNNMlhX?=
 =?utf-8?B?MFliNS9EWmdqcUJraUg4K0xLc0pjRk1QRFk5UFpIRWJ0QXhDT1hGY3I4NXhP?=
 =?utf-8?B?N1dCUWpiMENzMGFDcmJlN2tiU0tycDU3STVhdHdnKy8yQlpMdExOZGlMNW9L?=
 =?utf-8?B?VFJyeHBxOGZHUG1SYmc3TkxWQnIwM2MzVGg4RzBvOTlLVW9qc1V3ODluWFBE?=
 =?utf-8?B?aHZCKy9jajYvd1UwTDlFZ25QOThJSGVqeDFNTE8zcTNaaTAvbUVHTldOWWRo?=
 =?utf-8?B?b1k1blgyUnAwRDg1bFJxeTlvSGtxakdSc2xZZkEwRGgrTS9SNmRTQVJQOFYr?=
 =?utf-8?B?RStFUitOTTQxQnFNUDJETFFBQ2hFTU9XaC9vd2xsRkl3VDlJMk9PV1JpaUo0?=
 =?utf-8?B?UFl0R2RzMGlGN1AzN3hwUGsxWDZrYlptQzFlRHpIei9DWnpjckNBa2laK3hM?=
 =?utf-8?B?Z2ljSE1UZlFkUnpKK2xpemVIT083RWR3L2REZTZmcHJOZmZQRFNVM0FNK25C?=
 =?utf-8?B?V21OcDFySmlQall4aVVqL2R1T3dSdHZ1S0xUUGZjS2FkQUowTTdYcWVDQldM?=
 =?utf-8?B?aVFtR0VqYUdWQVJMTGxxUWNJZURXWmhkRGF6R0RPNGlnVkNmaTU3cVUxTjBF?=
 =?utf-8?B?dDlIZ2J2bFB1ZHNxcVM1elpuZHI4bnM0YStOL3RRR2NRVFhFb3hDQ2RzYys0?=
 =?utf-8?B?TXhHSTEya1hLQzdTcGVuTHptZGx4Qkl1Y2p5SDNXYWZDcjlKRGVQMG00cEl1?=
 =?utf-8?B?RzNENGtkQUxnZlNQa1VZcE43eC9zdkNtOFhSRGNmVyt0bCtmcGxDb3R3NjB6?=
 =?utf-8?B?WjQzUzdKN1cra1lFSndCcDUxYXRDRCtUU2ZxSWcxMnR3ekVZQklZbVpXNVFs?=
 =?utf-8?B?M3JuK1drOG9pRGVrSFdmajhwZDZiZUxsdUlrVmdOdUVXcmtEYnd1cXp4cXVN?=
 =?utf-8?B?SWxwVDBvYUJDVTYyRG82b1Q1V0t5ZU5BOGM1RVlDT2pVOHp3amtSd1l3NTE0?=
 =?utf-8?B?TFFTbWZIZDBBNWVRQzBoUW1rcGRoWjBQYWJxRTVrWUdsOXJScXFwOEg5TVNU?=
 =?utf-8?B?OHJwSi9TdWE2cHFnUDNzakpOdUMrQkd1YU51MDRqd1hrdkpvN3pUR0FCN1My?=
 =?utf-8?B?UkJMU2lSZkMvYmh2UGllckxOOVJFYmVlbHp1Y01aN0dCRHlhZ1BXWWg3V2xY?=
 =?utf-8?B?REt4bjVOUjBtaUxrWHZhYXVPWDFSNjVHRFY0WFhGczNuUVB1cEVpYU5lKzcx?=
 =?utf-8?B?dDQ2a3RyMXQwWWVrWmRNdFN6TDVvbkZBZ3RrdlRyR1NJSGdtdzhxQzlYbkxv?=
 =?utf-8?B?dlZTWStPK2hmVVZTU3F6VHV2a3E5L3NDUlUyMFB4Y0oxWG9vbktJNUFvWXc0?=
 =?utf-8?B?SXkyby94Y3FiYnh3a09naGp6VjFBTzR2TFdDV3YwMFFPdGJWWmZRZm0xVGE5?=
 =?utf-8?B?Y0wrSUFSRmlTTnhxSG8xQWs0NWhkbFF4aWcvcHJZaXY0TDFLTU5MbW9Cd3ht?=
 =?utf-8?B?R0svNHh6NGxhMzY3WUdtVzUzenYvdnNBWkJlU2UwbXNKUlVDZVY1cnlMNk40?=
 =?utf-8?B?YmRRWkw0Z3d3aCttUzZpUlhjN1U2SE9FQWhGa2NjcENpVXFwdWF1ZUJqN09v?=
 =?utf-8?B?ZTlRTmNZQm5pa1gxS3QweXFodFo1QlBnMSsrMkVBOExwcDVNRE1xMHNZNmh0?=
 =?utf-8?B?MG1QTjFPRDMvc0RCWkh2QVlPcDlUWFZnNGV4T3pSbGIzcTY2T3Q1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1af1c1-bf74-465a-af1e-08df17fe5eaf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2863.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:35:39.3742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dalGIkuhtx2V3M9iWM642C3Mbm125gkv95w/0sXoHAbtaLM3gyj+zLJkuwZxpBgbIg7zpWR6m61deqyH3Sj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB944609
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

On 9/21/26 11:06 AM, Christian König wrote:
> On 9/21/26 16:50, Shahyan Soltani wrote:
>> On 9/21/26 10:40 AM, Shahyan Soltani wrote:
>>> On 9/18/26 3:57 AM, Christian König wrote:
>>>
>>>> On 9/17/26 21:58, Shahyan Soltani wrote:
>>>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>>>
>>>>> For now use the same logic as the existing one, but it's not 100%
>>>>> correct since:
>>>>> 1) most operations don't need the GPUs
>>>>> 2) some operations that need it are actually deferred
>>>>>
>>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> index 4e4814caf61a..6edd03647c2d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> @@ -978,6 +978,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>>>        if (r)
>>>>>            goto error;
>>>>>    +    /* FIXME: only PRT operations use the GPU to update mapping, but
>>>>> +     * some operations are deferred to fences callbacks so it's not
>>>>> +     * trivial to fix.
>>>>> +     */
>>>> That comment is not correct, just drop it.
>>>>
>>>>> +    r = pm_runtime_resume_and_get(adev->dev);
>>>>> +    if (r < 0)
>>>>> +        return r;
>>>>> +
>>>>>        switch (args->operation) {
>>>>>        case AMDGPU_VA_OP_MAP:
>>>>>            r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
>>>>> @@ -1031,6 +1039,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>>>          }
>>>>>    +    pm_runtime_put_autosuspend(adev->dev);
>>>> That error handling is not correct, after the switch there are a bunch of returns and gotos for cleanup.
>>>>
>>>> I strongly suggest to use the guard approach here as well.
>>>>
>>>> Regards,
>>>> Christian.
>>> Thanks for the feedback, you caught something I completely missed. However I have a few concerns
>>> on what approaches I could take.
>>>
>>> Attempting to use a guard in this situation would require the guard to be moved to the top of the function,
>>> resuming the system much early in the stack.
>>>
>>> As far as I understand this is due to the guard not being able to succeed any gotos as the "lock" variable
>>> in the guard must be initialized before any subsequent goto.
>>>
>>> For example:
>>>
>>> goto error;
>>> PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
> Oh, that is a very good point.
>
>>> Is invalid as "lock" is initialized after the goto.
>>> Trying to initialize lock beforehand doesn't work as it would count as a redefinition of lock instead.
>>>
>>> Would that still be preferred over creating a new label and trying something like this instead?
> Yes, as far as I can see the PM reference just needs to be moved before the first goto, right?
>
> When I now check the code, the first goto in function amdgpu_gem_va_ioctl() is that here:
>
>          /* Add input syncobj fences (if any) for synchronization. */
>          r = amdgpu_gem_add_input_fence(filp,
>                                         args->input_fence_syncobj_handles,
>                                         args->num_syncobj_handles);
>          if (r)
>                  goto error_put_gobj;
>
>          drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
>                        DRM_EXEC_IGNORE_DUPLICATES, 0);
>
>
> We can't grab the PM reference after drm_exec_init() anyway because that could deadlock.
>
> So that should still work as far as I can see, or do I miss anything?
>
> Regards,
> Christian.
Nope, you got everything. Just making sure if this approach was the one 
that should be pursued.

I didn't notice the drm_exec in this case either.

Thanks for the help,
Shahyan
>>> replace
>>>
>>> +    r = pm_runtime_resume_and_get(adev->dev);
>>> +    if (r < 0)
>>> +        return r;
>>>
>>> with
>>>
>>> +    r = pm_runtime_resume_and_get(adev->dev);
>>> +    if (r < 0)
>>> +        goto newlabel;
>>>
>>>      }
>>>
>>> ...
>>>
>>> + newlabel:
>>> +    pm_runtime_put_autosuspend(adev->dev);
>>> error:
>>>      dma_fence_chain_free(timeline_chain);
>>>      if (timeline_syncobj)
>>>          drm_syncobj_put(timeline_syncobj);
>>>      drm_exec_fini(&exec);
>>> error_put_gobj:
>>>      drm_gem_object_put(gobj);
>>>      return r;
>>> }
>>>
>>> Another approach I could try is wrap the entirePM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); and the subsequent switch cases before the error handling into its own scope with {} However, I feel this method is a lot more hacky then necessary. int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data, struct drm_file *filp) { ... + { + PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock); + + r = PM_RUNTIME_ACQUIRE_ERR(&lock); + if (r) + goto error; switch (args->operation) { case AMDGPU_VA_OP_MAP: ... case AMDGPU_VA_OP_UNMAP: .. case AMDGPU_VA_OP_CLEAR: ... case AMDGPU_VA_OP_REPLACE: ... default: ... } if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && (!adev->debug_vm || timeline_syncobj)) { ... } + } error: ... error_put_gobj: ... } If you have any ideas on what approach I should/could take it would be very much appreciated. Thanks, Shahyan
>>>
>> I'm not entirely sure what happened here...
>>
>> But I meant to say wrapping the guard and the subsequent case handling into its own scope.
>>
>> For example:
>>
>> int amdgpu_gem_va_ioctl() {
>> ...
>>      goto error;
>>
>> +    {
>> +        PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>> +        r = PM_RUNTIME_ACQUIRE_ERR(&lock);
>> +        if (r)
>> +            goto error;
>>
>> ...
>> +    }
>> error:
>> ...
>> error_put_gobj:
>> ...
>> }
>>
>> Thanks,
>> Shahyan
>>
>>>>> +
>>>>>    error:
>>>>>        dma_fence_chain_free(timeline_chain);
>>>>>        if (timeline_syncobj)
