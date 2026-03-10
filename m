Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C02FCC9D6
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 08:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338BE10E68E;
	Tue, 10 Mar 2026 08:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ql68oGOK";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D34A10E68E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 08:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETkGXCj8LTbnxSx1M7+9zlfzwrcWGU19xP2Rtc8ZbCqchXqv79UwuSt/+OrMfVvpdOnqB5UgLqwI88lhlYD1S/CUVkIhcl11ksRqc5U5rQaOay0GDTD5dNHQdoJXlv7kyf8h3PSuom49GjA1Yt+45+0NUS/teFCkc1HKuRYwTumKtryqhnssWc8pd8caGz1OAXScyChRBEbDJtt+vPToNQlhqy5wmQQDwt1DYLSms5EELCcEPREhYj5MIqN7XWajiJKftc+vqls4uJ+zt37roNCFQcMmq9hB0J5165BWsDkQ/vqVVrj0SX/t/cnT+FqKBU3ri5sKdqxE2SjCDfvrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3pxZCAJcxcaGnyi24ZYFTHLlpJbeUPogO/dnxsCcDU=;
 b=fBhMgvi/FG8+ccOnyNTYjadnfnPWfLAjfqxB9yzmA98jh4L/qxLg1PIOmF1x2oLKJRN7rxrhfrPnoCQtYlU0Z1r6LbXne6JHkC2c3gNWE5X9IL7rc6GA2wnZpjkNuIIpP6CYxORSrcv7jxCzvMIWhBuaSmeOUcY1T318+H8B4bf28ovjm1MiL2EdnthCQF7BhDPhlailCb89ip1H7maV6+TUrtFS+JpvrckE7Y5CqCiyM0jNWq15RNhHnGsNLwDYBwMrNN9rKkh/u9inVAwthY/TgNs1TQCTxwRlKDoBgNsGyJdMhppvfDfRANyYo5M7x22DnpAocrY6XPrvQ+OqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3pxZCAJcxcaGnyi24ZYFTHLlpJbeUPogO/dnxsCcDU=;
 b=ql68oGOKae39XOGIIwyl3oB58O3GeyFkrknCG46QJstPEt/ZrXInRfif8fmiGbiqjlbFnRhqSyHf2cQUDDQAqDu65FoLyIR7Sxu/ANnmKnBKiGqC32b38HZIqkhQJZ976+IXDmq16VRHuUfDC01iXgdxwgX9C3Le/CLRpLTpShY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Tue, 10 Mar
 2026 08:50:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 08:50:27 +0000
Message-ID: <168eb007-f149-4727-b78d-8ef961348a86@amd.com>
Date: Tue, 10 Mar 2026 09:50:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove the WAIT_FOR_SUBMIT flag under lock
 context
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260310070252.3217741-1-Prike.Liang@amd.com>
 <92a288f6-26c9-4b74-ba11-3b4d6a94ca4c@amd.com>
 <DS7SPRMB00183B0CE49B4CB23A7B0F82FB46A@DS7SPRMB0018.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7SPRMB00183B0CE49B4CB23A7B0F82FB46A@DS7SPRMB0018.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0383.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: e75567b9-6755-47e6-d664-08de7e821359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: aUnEZ3rGNiJiVyjLrWkeeb3Pje2Tt6R0EjAVJ82p30vwGoLr64yPr+6r3HF7xVuQ8Uh01iL60MSHmE289tLLEFyJhotXWO8ycfPEQj08o5tJVJk2j+m/1uGHSVIwgGj5W0YkRqck5Rh2zWSC1U6u8a6nPgEpzS+RXW9+gVqtjA/4yV4g0ayNMRgS631ipsuSOp1moiI8zmSacr17dh4ELbnVnvCMY9P9hQbdyZODdcjcN0qB863BIFlQQvp5D48CbM6WW9HsN0oCYVPi16wT60x0NmDx5QKtcbqtWFKPID+ZipedcffnjRTI16Ieqy79ufJb0S91x7mysBO6jA75C5VJm7QMkZrGKHwFLXXjQnPQcx756UJEkd3zIZfMxCa6nYsQSozmvT/kFhRMliEK9byEDeusn9OvI1kiarGCJR/MbakUe8M5Mjb+Cj/lccjl1jZmxHUD3aC23yu45xlQ/YCqaufzB70DCCnC6Z32sVp/OShaeWo88dx8pyQjWIpXmX0uq4MjnOLZfcChLJdXIVefHQtCpsjdk3vLb953VCkzgGbrCbbpTm8wxPlfeix/FCyC9p4PiBiO0+aXwww+z52cv5w+L/QugSPDFKOYcETWZqU/mtDqR0hj49+z2sUnBiwNIyCMQ0qo4lp74g0hZJicdWHK/TSrzToYXhQnNZKBVQtY0HRIXxMAeoXUBLye84Y7cNNsNFyt8TPTZGPEwZPIxmDskZ5DaObhIR3YNIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldxdlc3SzQwVGt6UlFBRE1NazFjRkxWWktnYmo0WkZrMTJGcU5Rci9kUFMy?=
 =?utf-8?B?SUNINjJCVGZRa0FpNzR1bjB4azFBZWxzSEkzMVI3K2NVa09qT29hMllRY1No?=
 =?utf-8?B?MVIrNDhEYjNSUXRFb1prN2FpTm45UlEzQWk3UGd2b0tScEVXYWpDOWRVZVZR?=
 =?utf-8?B?SDlrODBuUEF5RG9sczVVemU3aFNGWkVvdDdhSjUzQjhWVWliaDlYMllBTkMy?=
 =?utf-8?B?STZMRUJjbWFYOEFDTnNPNEJrZGlBTmd1NHRsQW0zRlZORWFPdkgxWTlOQ09u?=
 =?utf-8?B?V1IreXFNaEtuQjhOejVzb0NUMGFGNURxUlgxMnYzWDZ0VllTcDhQRXdhSXZZ?=
 =?utf-8?B?dkhwVVVaSitTQVFkd3JwSnFjdUdNWE9YOVVKNTdrby84Qit3c0dyUTBhaFBl?=
 =?utf-8?B?VFpwUU1lRm5SdGRaeHpCeEZuSVEvOTRSK21vTmNwTENrdFZ0cGc3NHp6YVgw?=
 =?utf-8?B?VS9aZDFZTVRFZFFxQ09Rc3pMdmVKMFIzeUZlM2ZkZWxMQzdnam10QzRzUVBw?=
 =?utf-8?B?YXltc0FvdkFqOWRLSEhHRnh4bzhDNFRFWXY3d0lQQTFZdHZ6UC80MCsyZE1B?=
 =?utf-8?B?N1VOSHZIb1VObGpWTUtXa1ZpT1FWUDNOais5TWZVaUV0NUN2UzdvV1AwWGVS?=
 =?utf-8?B?eGdxMXFaSWpQWFV5R0h3VUc3Y2VTMXhTNTJjeG1MQysrV1ZmQ2lIU0VrMXBv?=
 =?utf-8?B?NEhHZHFjMjJXcVYzNFFnR3NWVUk2d1NJSVM1bzlTTnB5dFJJQUJDQk96cG52?=
 =?utf-8?B?NitOandZS1lBZEVmRVNncVIxemk4MzNRait1dFAxK1ZQRDBqbTBZMEd2dTFh?=
 =?utf-8?B?M1d1QlJsMTNjd0xtNGtLdDdhN1hrSmZ1UGFCSFJSekFOK2VFWDdlR2dISTlG?=
 =?utf-8?B?dHJvZkVhcTA3ZFZWeXJEVnZoeHBKSm9PQ0gyWlAyV0VhZFRpaDJ3aEVCMGo5?=
 =?utf-8?B?WmlnellqSlEyeWZ1VDhLTTdGd2VDVWh1MWF0S3JpSWsvNnhJVVJ6MzBvU0pF?=
 =?utf-8?B?UlJoV2d1MThrVHYydVZFWnlxMUEwZ2ZsaFhpSUNJaURWM0JVRHhIcnFRd3h3?=
 =?utf-8?B?ZmNOVVRDTE5Oa2RIQy9wSEdVUGtNNGlJZWZ4L09HV3hRRmdJQ2RtUGRkVzRj?=
 =?utf-8?B?UUdKbFBsMStQaFM2dXkzOS9mdU5mL3dtMmxIN1VOS0VpSzdwb2hxMlBLQS9k?=
 =?utf-8?B?YW9uUUdMcU5rVzZFV1p4eGNUdWU2OElRVGJzSERsMTNPc1lURUNITTlHWVZL?=
 =?utf-8?B?MU9vaTNublJjSWJjM2VKOW9SQkZqU2RXU3NiTTZLK0l1UTh4YTZQNFErZnlQ?=
 =?utf-8?B?eUFCS25WZ2JnZGtmVEtTV0hLS1ROSW1tZDY5Z1FTc3ppMlMzbnRVRWdtNStX?=
 =?utf-8?B?M2NlamRZRHF0Z1g0ak9HWitxd1dpQWQyK21HUHQvWlQ1b0hWelpCWlJOeFlI?=
 =?utf-8?B?YXl1cVJubGJKclJYS1d0a2huU0JEZjJMSVRpL3Zzbzkzcm5QUzBFWndWanZX?=
 =?utf-8?B?S3lqWjZ4bVpXUzBvdkhNd2t5WlYvUUlocCticHFTOXZ6N3BvM2x6NlBXQU1k?=
 =?utf-8?B?QUV2RCs1SGd1SXEzMmtPUXBiVjFYR2dUUkt0MTJ4OWUvVll3ZWxMcFpuZHgv?=
 =?utf-8?B?bllXSzBlaTduMzMwTFJodFhhNFQ0ODR5d2ZjSklUQ0Q5WXFEM2JENk9weXJn?=
 =?utf-8?B?U240Q1Q5TGdiV2JEcEI5emxHK1Rtb2p2UmgrZ0tneEp6c1U1dnFsc1VDN1Bq?=
 =?utf-8?B?L0pseElIdHdYM3ZHbkdWc2JIdnVOR1pSWXEyTzJZdno0cjN2c1NMY3lmdCtS?=
 =?utf-8?B?R2oxcTFjaWtreE44ektzOHptTy93MkQyYzZoSFU1djgya1dmdUpXRU4vSE5p?=
 =?utf-8?B?ZStuMlZoMnI5UUl1c0xQKzk3U0dwUlVzazJrWktTNkg2Ykt2cXFRbTA1cWxl?=
 =?utf-8?B?STB3eEJYVlh6czJlL2ljVk5FQ1kxTmVES21kWXRDcUpwd0p4WDRqWjBzc1c0?=
 =?utf-8?B?eVVZK0dvQTRzS0RUZXNQcktUYWM0MmI4cWR0dmpZemE1ZWdvZGRwYkcwb3Vx?=
 =?utf-8?B?TTV1VGdPZHVXdGJDdHlsay9yajdocldlaWMwcEhMT2trUVRURXIySGhHQWF2?=
 =?utf-8?B?b3Z3L1AwWmVjWTdDVUhtckVZWU5KNklNdXpSVDMxMUQySWJoZDlycTVneC81?=
 =?utf-8?B?aUYvVGozQ2s4MkFHQ0diNUV2cHg1UFl2L0x0b1hvM3hwdnNFRWo5RksySEM3?=
 =?utf-8?B?SUVNS3ExVUdyTGFaK0h6eTNkNXBEL1hTUFZEc0FoT0toYlFCQy9Ca1VYZUNo?=
 =?utf-8?Q?stn11bFM2JW3/D1p59?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75567b9-6755-47e6-d664-08de7e821359
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:50:27.1184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8OGrU9olbkdzhouPymT8ZaoEsXOwAZtS0PJJyWCYEf5RbqwAbLVnLmyx0XWNPVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
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

On 3/10/26 09:47, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, March 10, 2026 4:22 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: remove the WAIT_FOR_SUBMIT flag under
>> lock context
>>
>> On 3/10/26 08:02, Prike Liang wrote:
>>> In the userq fence gather and emit IOCTL path we acquire BO locks (via
>>> drm_exec/dma_resv_lock)before calling drm_syncobj_find_fence().
>>> This causes drm_syncobj_find_fence() to complain because it is entered
>>> with locks held while the WAIT_FOR_SUBMIT flag is set in the calling context.
>>>
>>> However, the userq userspace path does not rely on
>>> DRM_IOCTL_SYNCOBJ_WAIT to wait on fences that are dependencies of userq
>> submissions.
>>
>> That's not correct.
>>> All waiting is
>>> handled separately, so the WAIT_FOR_SUBMIT flag is effectively unused
>>> for this IOCTL.
>>>
>>> Therefore, we simply clear the WAIT_FOR_SUBMIT flag for this path.
>>> This avoids the lockdep / drm_syncobj_find_fence() warning about being
>>> called under a locked context, and has no functional impact on userq
>>> behavior since DRM_IOCTL_SYNCOBJ_WAIT is not part of the userq
>> synchronization model.
>>
>> That doesn't event remotely work.
>>
>> See the patches I've send out a month ago or so for the correct fix.
> 
> OK, after checking the Mesa code, DRM_IOCTL_SYNCOBJ_WAIT is still invoked before creating the userq.
> I had already considered resolving the syncobj-dependent fences before taking the context lock; now given that
> this flag is still used for syncobj wait fences, I’ll go with that approach instead and drop this patch.

We actually just need to take the locks in the correct order, it's a bit code re-structuring but not much of an issue.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 76f32fd768fb..7a309b0130d8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -708,7 +708,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void
>> *data,
>>>                     for (i = 0; i < num_points; i++) {
>>>                             r = drm_syncobj_find_fence(filp, timeline_handles[i],
>>>                                                        timeline_points[i],
>>> -
>> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>>> +                                                      0,
>>>                                                        &fence);
>>>                             if (r)
>>>                                     goto exec_fini;
>>> @@ -726,7 +726,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device
>>> *dev, void *data,
>>>
>>>                     r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>>>                                                0,
>>> -
>> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>>> +                                              0,
>>>                                                &fence);
>>>                     if (r)
>>>                             goto exec_fini;
>>> @@ -818,7 +818,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void
>> *data,
>>>                     for (i = 0; i < num_points; i++) {
>>>                             r = drm_syncobj_find_fence(filp, timeline_handles[i],
>>>                                                        timeline_points[i],
>>> -
>> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>>> +                                                      0,
>>>                                                        &fence);
>>>                             if (r)
>>>                                     goto free_fences;
>>> @@ -844,7 +844,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device
>>> *dev, void *data,
>>>
>>>                     r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>>>                                                0,
>>> -
>> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>>> +                                              0,
>>>                                                &fence);
>>>                     if (r)
>>>                             goto free_fences;
> 

