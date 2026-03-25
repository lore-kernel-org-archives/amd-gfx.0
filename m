Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33DC106B535
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 13:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDD110E223;
	Wed, 25 Mar 2026 13:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gk+y7c44";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878DD10E223
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 13:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWEh2hZ/dOHNbE4Wfd6vSRXYGcm1R2Snel1OSQCPldFFys7xgkWNCedGcaQL98pxvaSF0GXPwBB2htUDoWCWwhF8CnBOmERreS03Lxm/52g6xCMVGVG8G44cbTyvEwAQ0mffoEYUGHyeCHoxZ7BXWmlS+CVUC0/hXHu/3+4nUTqOSwh3R83+hNimfd5o113aqH868xo8lkX04q7aJzgTsCXOh30PJNKaSXIrYUS/4SSLwpF/0zJ2JFckNu/4+EqwKZTOssQ7UNRTvjKEsXn8FYiX+UXTBjU+8fdMiQ2E4GTrGT/eh6rcHW8VJWNT1YkV6FZHLDV4MF4vVRUEkoMAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x60Tcx2eTMSUnM4s+wTM773NHpkPJo+deacMfKjHj4=;
 b=E4tQ3hQZrCnJwjoiJWPl0Fv1mIsFrSPw4862C90bw2T2YN9Qv2v0/dXTXJfV+F2yAdEtZdXjLMtWtT9b9nDoYaGjNvfbBSpZNCnrr2qT9dyDIliY1AoGfwpkvO69EvOm9Pc1z1ROiTGLbAvVPJtHRtdBjhrFct1AprgXeMkxAOH28sQjHOv1GMUNZcTJi4zSIf8WaEKhKAwS5zxbQnkr6dFe95Jrxi019uEfuYU+vHZbpPBufYhb4zuO+QmIv1A1Irq3vcavrxVTPrHRjj0qaF+unCrd6r3GoiG56QC+wQfh0jUWZppboDSTQYfvMQCAfWgFC9qw7FUUX+neTFUGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x60Tcx2eTMSUnM4s+wTM773NHpkPJo+deacMfKjHj4=;
 b=Gk+y7c442VmWidWViNG+hJzDDdv5kWCygqZKKClW01aYxrPKy1ZwsVmZ17mWZJgLDh7HkHW7PnJ5NBw3ArtgBsY/DgjtZHukevnXHpLfDhwREVB9FvZHXFLFKw+dePqu6EjOioA68lD3IJ3Xp71Y1lx62Ddj9HKE7zb1Htxc50w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 13:28:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 13:28:10 +0000
Message-ID: <a554a809-d8ae-473a-a068-a240f66c5ea9@amd.com>
Date: Wed, 25 Mar 2026 14:28:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix PRT VA handling and guard BO access in VA
 update path
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260325115826.2100519-1-srinivasan.shanmugam@amd.com>
 <f434a376-dec8-4ec5-8c5e-85cc9e7e5a7f@amd.com>
 <IA0PR12MB820867AB3A8984B75C9B460F9049A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB820867AB3A8984B75C9B460F9049A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cf32fa-3f48-4dc7-91dd-08de8a725bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ExWNjLZjDmknR3aTgnpvfEqJBtjL+cIgjkyDjrUdrFbPgq68mQbwNp3ChFsZ9DvWoGnewk0S3RfDA8tceaVzaiVk4xV7SMD4jRmCBfAjr3WvF6pdE/NAZ76MpoZ/DruBW6H85RTSPX6ElV7dGFAJRuyAzEYLgis17AwCOZtdeNGMFWfenMsCoSX6GuN3VSdDg5v0W4tG9PjdFo7Ib3Yo8aqfv7AtV928/vIP0s5R3JPHcQsxt1o2aMBTuUBoK4gBxleupVs5Hdn9is11HotDwZdyfANMBPKMiwxIErOER2jHVwkklmqW/mmgUIQO+CcEdbXwvq049+JxGY6YOScpsCvwC90KkobKGtYDu0qTbZ9OKT9PwFLlkkU9tUOeZvwt+E5E262cFzkra/gFK496q9THqHhRa4uJw5TCw/SIKSS5OOOjmo0tQuUKKTdrjtt3m7IOlkRogBciX7w96eiam56gGGDdGnIxxIEr0nBhHkfqYnhLcceuApvRte4IWNiBHWuejArdXN1eysTChFzjNZM1X+WtdWCGn8nre+U6FlUBT8SrnkLKw6tx3qJrY1jliREBJa3SP6x4P4u0K79VT6pjP8yCuEQbmTxOlxWuPe5swKrqCaKTRuadZluT7CF8pT0ootr/vFkoPQfuIGL68f2teWl9kdlTWHw5cBzuSwsDG+H/7lfagBmlR8Da/eeLKs2QyYjvCmdoAabBJCokiXkt8e31Afl+VD1zb6Bdrz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzJyT2J2VGZubVhYY0NFTXRYMGlJMTJJelN3T1o0UGhhejFLTWlETVJrM05B?=
 =?utf-8?B?Z0Fxd1lxWVlnVTkzckpCN05ka2pGT0pvdW5tTTN5c0YzRUdrNysyK0dYMk9C?=
 =?utf-8?B?UzNGeS92SUx3ZS9LWURvK0JZQW9OdmRKMnE0OXE0aE1SU3pBSHJ3U1ptUk0w?=
 =?utf-8?B?aVV4Wmp3WUJNVXUrN1d5cmlnck9Gdm5rc0VsK2g4enJFZ01nTU02QzFvWGgw?=
 =?utf-8?B?WGoxYTUwMURncmlSVXhiZjZHclNtSW5yckRnejBIQjZrMnFMLzQ0MGlGMlht?=
 =?utf-8?B?RzJVYWRRWWRsdTA2ZEtWR3Z5amcrMkV3SkxtM2JnTHEzbWZ5UVlYM0tjTU1z?=
 =?utf-8?B?aGlqbUE1QWtScDBsenpaemxVNFVCUy84MEs1cmtycGxkNkFZQ3hWUkhkWU5I?=
 =?utf-8?B?K1JhOHJpK1ErOUhKb293K2tuVVd0T3JDclA1QXorcGxXNEttZkFuSG5pT2lQ?=
 =?utf-8?B?c0o5T3BFYkNXV0laajk2c2FBcnlka3dwa21sYXUwZWhVOGF0eDBoTnV1VFl0?=
 =?utf-8?B?TVJXQWw1WTg2NFQvRVRaSDhkUE5EK1lsM0FycVo1STdxQlVzeXp1QmtQUTJ0?=
 =?utf-8?B?NzNueUMra05SK2RzMDA5T2RyeGZqUy81NlRTK2RBNEZ5aEJWem50TFFFOGRI?=
 =?utf-8?B?SnNNQkRkSWU4aGdQQkZ4VWt5VVNUOHVlNVZCR0NOenBUQ2ViWmRTemVyYUZN?=
 =?utf-8?B?Y3EyMkJ2UnVieXAzQ3d5RnVTT1hsVjJ4RzBDVzFFUXo1TUtxZ08yRUxnM3oz?=
 =?utf-8?B?dVJCL0dhczRkYUdrSUhtYldtRnBUeHhXR01LNm1ncTdhaFJpOUx0R1I1MXk0?=
 =?utf-8?B?bUxydUVQaGRwM2RmRDkvU2ZLMnFXNzJaQk5Td0cwbEYybVhLWmduNC9laE41?=
 =?utf-8?B?MUZTVzZCWTV1RHh2OE5nMW43NE5FUU1SWUJlNTRvNzkrWFlOZW5vWUpKRFFE?=
 =?utf-8?B?WlEzRURWQys3MVVjd0Q3T29oOUg3RG8xNXYzTWVLTkwyclhHWThTcVNBeE0w?=
 =?utf-8?B?Q1ljeFhESmFYUXFha242VU1uTUhjZWdETCtoMy9lVGhIZkthbmZyOGJvbk4w?=
 =?utf-8?B?RUlUK3VmRW1sMWp2T0lEUkpLZDZlYUQ0SnlOWnhiOEtXUE55MkZiUjdpMDZT?=
 =?utf-8?B?TWFrZVN6YnFVaGRuSTY2c0p6UUVLN0E1SDQrTGFvMzgvOEllaDd0aElzV3lT?=
 =?utf-8?B?a0wxbjFLMGpLQkhDS0VQRitGS1JhRUdrUHloR1lXWmR1T0NsMVdQdGNVVFpx?=
 =?utf-8?B?RXlJWjg3R1QxaElwUmhHY2VlNlVkSFBhblJ2Z3JvckdhTllXdlM1QndnOENl?=
 =?utf-8?B?VHBpbVRwREN6R015RzBwZjVNZ1dja21ldGplbWNjbHJwQ2xYN0FvN1FLL3RX?=
 =?utf-8?B?cDhzazJncHpuK0sxRDlMOVd3Uk93bDJyekM2M3Q4ZHpuL1dzZ0lKc3VwYndu?=
 =?utf-8?B?MzZITDc3SDAvUEp6NkNtV2Q3VnljenJQa0UySVgxYU1VMjlXbWZZNUNYbUxn?=
 =?utf-8?B?RThxVHFnS2t0OEZKZ1d5N2xVdGRPek1vaGwzK1FYL1hqbTJMNkNjSHhvYXpX?=
 =?utf-8?B?Q3dJZW9QNndJMzJTVkgrM1c1WWgrUTFycDRENEFmcGJ1QjA1WURYR0s0Z2U4?=
 =?utf-8?B?TmFTRGVzK0twbXYvWGtqeHl2THZCZmppUVJqZTI1VXN4d2t6WTE3QklNZ05I?=
 =?utf-8?B?a1RBUzBNVHpqRWJuMjByMHR3SXJNVkhOZ042eG9nWU5VSDF0RU9neCtkOExt?=
 =?utf-8?B?TFlxdEtIeDU1VmlMT2Jvb1ZNQ3hoT1lNTTY1VW5SRnhodWlDTXkvdUh6ZlhZ?=
 =?utf-8?B?MklkWktpcnZFSlh2NDBRUE5vZjZWbk5QRkFOTUxJajNVSWIyU1FWYmptODJH?=
 =?utf-8?B?TmRpUDV3SGpMUCtHUHFKWXYrVkN0WFZ0ZjZyb0lnK2ViWEY5K2cxcU1HYytK?=
 =?utf-8?B?OHcrRi9PT09VOW9aQXViZFhEUWo5MjczMEJGQ0VJZU0zVHlhZ1JRQjdCdE5r?=
 =?utf-8?B?dmdNazczaTVROWNPOFdHTnF0b3Z3WC9JVy9NY2JVME1PVGExeldMcE9YaXZG?=
 =?utf-8?B?MkY3VDRUTVE5NXExMjB4T2JFTVhSMkx1aEtqUW9MVVkwQTB3RXYrSDJQaDh0?=
 =?utf-8?B?bGNyYVlOMjE1aFlvMGJBRmc3eGJ3TnU2ay9KMUpOd0dSWlAwRThldDNGWG4x?=
 =?utf-8?B?d0dtVnQzTzBueWpuK0xVRmlhei9iYjE0YVluYWxyTkd0K2tGeE9KYTBzT1hw?=
 =?utf-8?B?ZWtQZ1l5QlFSZ1ltYWFZTloxYnYxSERoQmVkQ2ViNHFxMDErQjllbHc5aGNy?=
 =?utf-8?Q?uEehk4PEwJ2nZ1XikS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cf32fa-3f48-4dc7-91dd-08de8a725bb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:28:10.6126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xI5xX29KWYNTATNk+RldSOrLctkYfw8SEpEjlE/KL2snF46gADOo9AwyYBoT7na
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
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

On 3/25/26 14:18, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, March 25, 2026 5:39 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Fix PRT VA handling and guard BO access in
>> VA update path
>>
>> On 3/25/26 12:58, Srinivasan Shanmugam wrote:
>>> PRT (Page Request Table) mappings are not backed by a real buffer.  In
>>
>> PRT (Partial Resident Texture).
>>
>>> this case, bo_va is valid, but bo_va->bo is NULL, meaning the mapping
>>> exists but does not point to any real buffer object.
>>>
>>> amdgpu_gem_va_ioctl() currently mixes CLEAR and PRT handling, which
>>> can result in incorrect bo_va selection. CLEAR should use bo_va =
>>> NULL, while PRT should use the special fpriv->prt_va mapping.
>>>
>>> Fix this by clearly selecting bo_va:
>>> - use fpriv->prt_va for PRT
>>> - use NULL only for CLEAR
>>> - use amdgpu_vm_bo_find() for normal BO mappings
>>>
>>> Also, amdgpu_gem_va_update_vm() accesses bo_va->base.bo without
>>> checking if it is NULL. This is not valid for PRT mappings.
>>>
>>> This keeps CLEAR, PRT, and normal cases separate and avoids invalid
>>> memory access.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 18 ++++++++++++++----
>>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index b0ba2bdaf43a..289d6b58b579 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -772,8 +772,10 @@ amdgpu_gem_va_update_vm(struct amdgpu_device
>> *adev,
>>>     if (r)
>>>             goto error;
>>>
>>> +   /* Only do BO-specific handling if this VA is backed by a real BO */
>>>     if ((operation == AMDGPU_VA_OP_MAP ||
>>>          operation == AMDGPU_VA_OP_REPLACE) &&
>>> +       bo_va->base.bo &&
>>
>> That is not correct. This branch here should also be taken for PRT mappings.
>>
>>>         !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
>>>
>>>             /*
>>> @@ -909,15 +911,23 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev,
>> void *data,
>>>                     goto error;
>>>     }
>>>
>>> -   /* Resolve the BO-VA mapping for this VM/BO combination. */
>>> -   if (abo) {
>>> +   /* Resolve the BO-VA mapping for this VM/BO combination.
>>> +    *
>>> +    * Depending on the case decide bo_va:
>>> +    * - PRT: use special per-file prt_va (bo_va valid, but bo_va->bo == NULL)
>>> +    * - CLEAR: no BO involved → bo_va = NULL
>>> +    * - Normal BO path: lookup mapping from VM
>>> +    */
>>> +   if (args->flags & AMDGPU_VM_PAGE_PRT) {
>>> +           bo_va = fpriv->prt_va;
>>> +   } else if (args->operation == AMDGPU_VA_OP_CLEAR) {
>>> +           bo_va = NULL;
>>> +   } else if (abo) {
>>>             bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
>>>             if (!bo_va) {
>>>                     r = -ENOENT;
>>>                     goto error;
>>>             }
>>> -   } else if (args->operation != AMDGPU_VA_OP_CLEAR) {
>>> -           bo_va = fpriv->prt_va;
>>
>> That code already looks correct to me. I don't think we need to change anything
>> here.
>>
>> Where is your crash actually coming from?
> 
> Hi Christian,
> 
> The issue was observed in CI during IGT (amd_bo) runs, but I have not
> yet been able to reproduce it locally. Will continue investigating to
> identify the exact failing path.

That is most likely something completely different. As far as I can see the bo_va handling is correct.

> 
> Below is the crash signature for reference:
> 
> BUG: KASAN: null-ptr-deref in amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> Write of size 4 at addr 0000000000000000 by task amd_bo

That sounds a bit like the fallout from Pikes patch:

    drm/amdgpu: fix syncobj leak for amdgpu_gem_va_ioctl()
    
    It requires freeing the syncobj and chain
    alloction resource.

Not sure what exactly goes wrong here.

Regards,
Christian.

> 
> RIP: amdgpu_gem_va_ioctl+0x385/0x1130 [amdgpu]
> CR2: 0000000000000000
> 
> I also tried to map the crash offset using gdb/objdump, but the results
> were not conclusive. The reported amdgpu_gem_va_ioctl+0x380 offset did
> not map cleanly to a single obvious source line
> 
> So at this point I can localize the crash to amdgpu_gem_va_ioctl(), but
> still need to identify the exact failing pointer/path.
> 
> 
> [  325.779102] ==================================================================
> [  325.786483] BUG: KASAN: null-ptr-deref in amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.795105] Write of size 4 at addr 0000000000000000 by task amd_bo/7893
> [  325.801997]
> [  325.803595] CPU: 12 UID: 0 PID: 7893 Comm: amd_bo Not tainted 6.19.0-1314135.2.zuul.928a0cbbebc74c4f8d5a99a4d0a7ca55 #1 PREEMPT(voluntary)
> [  325.803602] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
> [  325.803606] Call Trace:
> [  325.803609]  <TASK>
> [  325.803612]  dump_stack_lvl+0x64/0x80
> [  325.803623]  kasan_report+0xb8/0xf0
> [  325.803631]  ? amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.804427]  kasan_check_range+0x105/0x1b0
> [  325.804432]  amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.805229]  ? __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu]
> [  325.806022]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.806815]  ? __pfx___drm_dev_dbg+0x10/0x10 [drm]
> [  325.806894]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.807686]  drm_ioctl_kernel+0x13d/0x2b0 [drm]
> [  325.807767]  ? __pfx_file_has_perm+0x10/0x10
> [  325.807777]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  325.807857]  drm_ioctl+0x4be/0xae0 [drm]
> [  325.807936]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.808728]  ? __pfx_sock_write_iter+0x10/0x10
> [  325.808737]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  325.808816]  ? ioctl_has_perm.constprop.0.isra.0+0x2ad/0x490
> [  325.808823]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
> [  325.808827]  ? _raw_spin_lock_irqsave+0x86/0xd0
> [  325.808835]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  325.808841]  amdgpu_drm_ioctl+0xce/0x180 [amdgpu]
> [  325.809622]  __x64_sys_ioctl+0x139/0x1c0
> [  325.809630]  do_syscall_64+0x64/0x880
> [  325.809638]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  325.809645] RIP: 0033:0x7f205fd12e1d
> [  325.809650] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [  325.809654] RSP: 002b:00007ffe9032b510 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  325.809660] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f205fd12e1d
> [  325.809663] RDX: 00007ffe9032b5b0 RSI: 00000000c0406448 RDI: 0000000000000006
> [  325.809665] RBP: 00007ffe9032b560 R08: 0000000100000000 R09: 000000000000000e
> [  325.809668] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c0406448
> [  325.809670] R13: 0000000000000006 R14: 0000000000001000 R15: 0000000000000001
> [  325.809675]  </TASK>
> [  325.809678] ==================================================================
> [  326.029964] Disabling lock debugging due to kernel taint
> [  326.035486] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  326.042557] #PF: supervisor write access in kernel mode
> [  326.047887] #PF: error_code(0x0002) - not-present page
> [  326.053132] PGD 0 P4D 0
> [  326.055766] Oops: Oops: 0002 [#1] SMP KASAN NOPTI
> [  326.060577] CPU: 12 UID: 0 PID: 7893 Comm: amd_bo Tainted: G    B               6.19.0-1314135.2.zuul.928a0cbbebc74c4f8d5a99a4d0a7ca55 #1 PREEMPT(voluntary)
> [  326.074815] Tainted: [B]=BAD_PAGE
> [  326.078233] Hardware name: TYAN B�8021G88V2HR-2T/7] RIP: 0010:amdgpu_gem_va_ioctl+0x385/0x1130 [amdgpu]
> [  326.093279] Code: 00 00 75 aa 85 c0 74 a6 41 89 c7 31 ed 45 31 f6 48 89 ef e8 dd bf 09 ce be 04 00 00 00 4c 89 f7 e8 90 0e 13 ce b8 ff ff ff ff <f0> 41 0f c1 06 83 f8 01 0f 84 3c 05 00 00 85 c0 0f 8e 75 05 00 00
> [  326.112237] RSP: 0018:ffff88a0d02d7b60 EFLAGS: 00010246
> [  326.117568] RAX: 00000000ffffffff RBX: ffff88907f0c2848 RCX: ffffffff8f43434a
> [  326.124813] RDX: fffffbfff2a16c0d RSI: 0000000000000008 RDI: ffffffff950b6060
> [  326.132056] RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff2a16c0c
> [  326.139303] R10: ffffffff950b6067 R11: 0000000000000001 R12: ffff88b1349d7778
> [  326.146548] R13: ffff88a0d02d7c00 R14: 0000000000000000 R15: 0000000000000000
> [  326.153794] FS:  00007f205dbad940(0000) GS:ffff88c00aa09000(0000) knlGS:0000000000000000
> [  326.162023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  326.167872] CR2: 0000000000000000 CR3: 000000207940e000 CR4: 00000000003506f0
> [  326.175113] Call Trace:
> [  326.177661]  <TASK>
> [  326.179861]  ? __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu]
> [  326.186637]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  326.193168]  ? __pfx___drm_dev_dbg+0x10/0x10 [drm]
> [  326.198141]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  326.204608]  drm_ioctl_kernel+0x13d/0x2b0 [drm]
> [  326.209319]  ? __pfx_file_has_perm+0x10/0x10
> [  326.213696]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  326.218934]  drm_ioctl+0x4be/0xae0 [drm]
> [  326.223109]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  326.229576]  ? __pfx_sock_write_iter+0x10/0x10
> [  326.234130]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  326.238752]  ? ioctl_has_perm.constprop.0.isra.0+0x2ad/0x490
> [  326.244518]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
> [  326.250630]  ? _raw_spin_lock_irqsave+0x86/0xd0
> [  326.255268]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  326.260429]  amdgpu_drm_ioctl+0xce/0x180 [amdgpu]
> [  326.266018]  __x64_sys_ioctl+0x139/0x1c0
> [  326.270056]  do_syscall_64+0x64/0x880
> [  326.273827]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  326.278983] RIP: 0033:0x7f205fd12e1d
> [  326.282660] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [  326.301609] RSP: 002b:00007ffe9032b510 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  326.309316] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f205fd12e1d
> [  326.316560] RDX: 00007ffe9032b5b0 RSI: 00000000c0406448 RDI: 0000000000000006
> [  326.323855] RBP: 00007ffe9032b560 R08: 0000000100000000 R09: 000000000000000e
> [  326.331103] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c0406448
> [  326.338347] R13: 0000000000000006 R14: 0000000000001000 R15: 0000000000000001
> [  326.345595]  </TASK>
> 
> Thanks!
> Srini
> 
>>
>> Regards,
>> Christian.
>>
>>>     } else {
>>>             bo_va = NULL;
>>>     }
> 

