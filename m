Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934A8106B50C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 12:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C4510E7E2;
	Wed, 25 Mar 2026 12:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P3VHZDXE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923BB10E7E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 12:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP3slK2RGoTGNbUKmqybHiMqQbL+CMi/2vLq9o4aKXgsiNCYqj4OjBf9KjV5Vb7WlnLR90MwqLxELLQJ/MbubFUy6Cn9BJ47c456qoWIbyv4MWl+VIdjFxTlC7NyL+5FWtVgNrcdqfim9YGInx6muOmDCO493TCOpHuD5klImKiLwEoHHcO68QW6JHIO5SUxZZDXabrHv+MbCpTjgv3YOQ30l7Fb/2C5U9UIlLzY6hO0wn8orS5Hn+qpjw1qWnPSCUceso46lcwDMwj4rofSVNBSTPI8MpwIMNKjRYU3V4rvs0BAjqavcSDSxYbLp/Pd+B2AL+96FoS+Le9ndXovQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBjawLA9F5579xsrlBk5ZN75GdDjIYwtgKDxKOLMqzY=;
 b=E3YLB/4hUsPSMeXDdOIduPGM/JxS4zqs2MEDExpb730IvzMUJc19ijC2oY3JIXsrG6aN6PVMqRZHl0Q8gH9Ac8hMJAde/Llr3cJYw8Kp25wxHnPXTMnx++MEeF+kv9rb69cHGGvjwYoy9i2j4XLkgZAoGkEnfLgmcqTKOM2bPafKZ22hGi2hzXgAWoTXQhs65/uXKOCiYnJiVkNZTCIo0i0IVqDN5VSe9MU9EsbcNThCbk0/ocmsN+jR7eKAL4oiv4nEaN/EzhFLMSlp+wO5aPo/zmNXHPgKthFv/4dK1/D6bvtO2lwAtWENqg1FtCL/dI7HS7E/kZaWl631s37QWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBjawLA9F5579xsrlBk5ZN75GdDjIYwtgKDxKOLMqzY=;
 b=P3VHZDXE99BtrS9kSy9QD3BVTQDGlXMlyVc6IBKzpYDVFK++j4WODwQ6zFwzFAUwlc8JF4LOkOvq1iRCoYfj2yt0s3OoucZnY/aEy8N+K3MTLMS80ZHM1c+iuWANDeFRhoI6RKQo1zj9AY9ecJD68mW5woTOOtmpLU/8o1jP5jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 12:09:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 12:09:31 +0000
Message-ID: <f434a376-dec8-4ec5-8c5e-85cc9e7e5a7f@amd.com>
Date: Wed, 25 Mar 2026 13:09:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix PRT VA handling and guard BO access in VA
 update path
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260325115826.2100519-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260325115826.2100519-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 930be8d6-b554-4bf7-c6df-08de8a675f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: oHj8TrTWfW3S2D9Ad7YletvJwJdA1Lv5avNvGkoxuoXOTdGJCKamSo+udoN3h0wP53yfzYn4JqVMEX9uhXQtrzC1W4B5WTCJ8VHkB0eQ7IBbeFER0VUrbV1HcTtYifCtYvmYY2De1b5HF0GbTRsWRrTtir3pyELelRxDcHkwnZ92tFsLNIusRZOCtEn5YQ9C/auFXOKqT+m5a36CxRVjW5jcooHpMS2c1d2oB+gjyzByfIM3JhgYISGEQZZot25LNPCkXqERSURyP3+bVv68isWwbpjIiZZSaYVeX/uZIKSvAtX83E7TuUmn6GiTmKH2L1A2foCAtcXMehosKbQIKc6G3m/huDGErGyZ3a4vBLxglkgym/Fp0exJ637fq7JefLvtAf8tTnwglQyVIXV3eGwMYGk9YJnnNMIg65LW4Vvz5bFYqIh5TZB/YoqAzGRMzkPCh6jfeicFN6uuvcC6O3q1QeNt6vExz5+ndX2Mw0MMUC7uhnHPhzCjew5RHonW2wUQxqdqsEZZzIzj5H2ChwKJ9qqnx23v3UfuuCZ+mjeiWq7tXv5/tuFYcQiBYt0ZM/D1LDxD+XmZ6d43fW3Hd4ayDOHpv36q8xXgkjNCS8dafTzNJRrfzysxP74VsToz/8Zi6Yl1OVWJl6ko8QXttnEE+YyElLBnUkd9whjN4p8ZCc54qFPxx4c4sYNOAa/oo9bcnB4e6iveAuW/n2yzucJfkKVZiKzVKRjSd7m+3oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEN5eWYvUGluNWhmcWRhNVdRV1hTUjEyZHBlQ2xzK25KYjdNU002Ulpram8x?=
 =?utf-8?B?SGlLeWJiUnduOGFWV295Nnh1SXNQUUlERE1DSEs5N3dmclpDRmk2WDBnRUVp?=
 =?utf-8?B?dlJZalUwbzUwWXY1MmVZYkFyc2F4MXpTai94N1NWRFArSU1wMTZrR0JrTzgr?=
 =?utf-8?B?Y3IrdW1tWE9udDlZRXRjbVVObTFtSTNOZjV1aUVyL1ExN0Y1UGhBa3RZcTQ3?=
 =?utf-8?B?QXZsdnMyZm1SL2Rua1EwN3ZXQUZjUExQUXlFSjhHak5aNzNpZ2tsYzkwYzJl?=
 =?utf-8?B?THh3eGhaZFlGTmJKdklmR1hzVmpRRUtSakIwOHZUK3FvQlFIMWwxMm8xWE0z?=
 =?utf-8?B?dWVSd1NPTUFtMjRCQTR4SCtubkhtQUNzd1VSaGdzUTdnWDIvS280NUJNVVdw?=
 =?utf-8?B?OVkzSGdRRTNlV0p6eE1Wb2JsYVh0aE5DY2wvemc2SWpybXUxU0hQbEN0OE5z?=
 =?utf-8?B?MlJWSVp5bFAyOEFycTNYdmR1akJKZzNINWhyWloyeGJadDkwZUk2aWJFczlU?=
 =?utf-8?B?WS9reXQ5ZXB0RHd2ek91MmpzdkhiSitkUzMzVlVXcTZON3hlckxNZ3RFWG85?=
 =?utf-8?B?V0pPalNXRFhrYXYvaGMxUUF6RnJ3em4wY1dyclhzYUV1bzFCTHljRDkya3Y5?=
 =?utf-8?B?bWFrYTlIVWxmMVJVVlMxRk9ySnVZNHdWUFA0S1puengyaUlTVlpqWEx3cllK?=
 =?utf-8?B?SWNlclRaVStCckU0ZGRrZnpOd0lPM0JrcGRmOFV3eUNISXZPWm1HZUtwVlY1?=
 =?utf-8?B?ajMwT01qMEcvR0Y2K0xZeTd3YkxrQXByKzBaVWtEODBkaUZ5d0tkUUtWQStZ?=
 =?utf-8?B?K016bldKUnlyUEYveUZnNk4xcnlmMnQwTEJWNU81a1AxUUZqL0Z1eUg0NHdq?=
 =?utf-8?B?TzBldWNGQlgyZ0ZKc0w2aXp3QjAwNnFTQlUxTDVwZUhnOWE0S3B2b2VkczlO?=
 =?utf-8?B?UWw2UmdGb2M2T051djZRbU53ZVp5UVJxWm9rOFF6ay9TTUpHVTRJZ1RMV3Za?=
 =?utf-8?B?M2d2OE84R3l5K0RveFdnQStySEdRZVQvbTlOYUxnTmZOYVNDWnJmNTVUcUVj?=
 =?utf-8?B?ZTh3TS9UVFZFZkIxb2lxT2lMbW5IODFVQXlJRGRqUGJjbHVKNkZLR1Nwc2tP?=
 =?utf-8?B?d1AwRHVQUEd6OTIrSjFDUC9FRWN5SXNmc2VzRHo5RGpVWmprWldxMTY2cTFB?=
 =?utf-8?B?bG1GUjl1RUgyeGZsSktDTVcrMmg4SGJFU3VDbWE2L3BkeEMzL1VFTWI4Vksx?=
 =?utf-8?B?bUpHLzJwQlI3eFI4Zlp2ZmVBZTdMY1BKbm1ZU0ZGdy85b2s5Unpab1lKQlVR?=
 =?utf-8?B?TmtHNGZzTFZIbGNVbjJTbmgxTG9sSzdZTzJPSFpiSkMyVmtJMU1pTnNuTmtl?=
 =?utf-8?B?dnBvZVFib0tLcGJuSGJhN3ZOeUtHemk3c2Z0ckQ1NEg4NHAzSk9iTzFGVks2?=
 =?utf-8?B?Yk4xQ2w5NmJ0WitUalRkcmdZWWFHbnNHZnBLNlI2Rjdyb3pzQ1BudDdONFlX?=
 =?utf-8?B?NGxRUTJxaXhYbkt1MlNzWGxoWWFabjdqcGFnOUUybVdvWEVrVWJYTmZaNlly?=
 =?utf-8?B?RzhMUVlKc2xVck8rSjBmZ3RLVnlSZzNHeXdBcEkvMFcrdGFzWVJ5cllBdUt0?=
 =?utf-8?B?WnpWb0pWSlo0ckh2bWRrK1JLQ1ZwNHc1ekFCeUhPNnQvWmRSK3pCZnc2UjFN?=
 =?utf-8?B?ZTNpWEpCQmhIc09xYW83M3hNUTRSOEpSdlZuMy90TXNUbnlGTUxoUXRkZk9W?=
 =?utf-8?B?czI4V2U2bytFRWNXbEozeHAxTDdOUDQwOFp5VTB5SlFWWGI4NXRkMG9nejdQ?=
 =?utf-8?B?aHR1aVp3YThBcUt1aUZhQnlQOWFOaG9nMXNXZERVdEZseDUyeE03U05HdVJ3?=
 =?utf-8?B?NENKdjNRUk5vMGZQbllveTRzOEdndXZUeWY4Q2tTMUNkQWRtdlYxY2p0WkFI?=
 =?utf-8?B?NWFIZHJHdXd0SEdKT1F2eWlyQ0NsblNyRERHVzBibEFvc0I4V0xUbHQxK1FJ?=
 =?utf-8?B?VTgxdk51ekJYYks2dnIrbWZHRlNzSWJzZU04cDU1SVFTMkdsL09JN1FaMHVJ?=
 =?utf-8?B?alRuczNFMGF2RjZnWXRGMEJxajkwRXF4cVQ1czYrbEpUQmxxYXllZjREZUtZ?=
 =?utf-8?B?MVk4SWNGUkN0bEUrTU5oU29wVWs3aWFZMmNuNjJQeWYzS1JYTGZ2MSthTXdS?=
 =?utf-8?B?VDRHVVBDVnhvd2R5b1J2dFArbGpGZjVSd0VqNnh5VTJ5K09LaFVKTnIrZm8x?=
 =?utf-8?B?T1ZqeFg1eU82VWhkQkNjVUg1ckJGc3BibHV5dEpONlhobCtPNXNITkwyaVhh?=
 =?utf-8?Q?yK1AdUsyjBYYeI8XZK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930be8d6-b554-4bf7-c6df-08de8a675f1a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:09:31.7644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2U3yh9vpNbqeTVN/V+IURetGJyT2TJiWHtgEdxr9UOILmvQRtBRE20gy/oLleUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
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

On 3/25/26 12:58, Srinivasan Shanmugam wrote:
> PRT (Page Request Table) mappings are not backed by a real buffer.  In

PRT (Partial Resident Texture).

> this case, bo_va is valid, but bo_va->bo is NULL, meaning the mapping
> exists but does not point to any real buffer object.
> 
> amdgpu_gem_va_ioctl() currently mixes CLEAR and PRT handling, which can
> result in incorrect bo_va selection. CLEAR should use bo_va = NULL,
> while PRT should use the special fpriv->prt_va mapping.
> 
> Fix this by clearly selecting bo_va:
> - use fpriv->prt_va for PRT
> - use NULL only for CLEAR
> - use amdgpu_vm_bo_find() for normal BO mappings
> 
> Also, amdgpu_gem_va_update_vm() accesses bo_va->base.bo without checking
> if it is NULL. This is not valid for PRT mappings.
> 
> This keeps CLEAR, PRT, and normal cases separate and avoids invalid
> memory access.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b0ba2bdaf43a..289d6b58b579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -772,8 +772,10 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> +	/* Only do BO-specific handling if this VA is backed by a real BO */
>  	if ((operation == AMDGPU_VA_OP_MAP ||
>  	     operation == AMDGPU_VA_OP_REPLACE) &&
> +	    bo_va->base.bo &&

That is not correct. This branch here should also be taken for PRT mappings.

>  	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
>  
>  		/*
> @@ -909,15 +911,23 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			goto error;
>  	}
>  
> -	/* Resolve the BO-VA mapping for this VM/BO combination. */
> -	if (abo) {
> +	/* Resolve the BO-VA mapping for this VM/BO combination.
> +	 *
> +	 * Depending on the case decide bo_va:
> +	 * - PRT: use special per-file prt_va (bo_va valid, but bo_va->bo == NULL)
> +	 * - CLEAR: no BO involved → bo_va = NULL
> +	 * - Normal BO path: lookup mapping from VM
> +	 */
> +	if (args->flags & AMDGPU_VM_PAGE_PRT) {
> +		bo_va = fpriv->prt_va;
> +	} else if (args->operation == AMDGPU_VA_OP_CLEAR) {
> +		bo_va = NULL;
> +	} else if (abo) {
>  		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
>  		if (!bo_va) {
>  			r = -ENOENT;
>  			goto error;
>  		}
> -	} else if (args->operation != AMDGPU_VA_OP_CLEAR) {
> -		bo_va = fpriv->prt_va;

That code already looks correct to me. I don't think we need to change anything here.

Where is your crash actually coming from?

Regards,
Christian.

>  	} else {
>  		bo_va = NULL;
>  	}

