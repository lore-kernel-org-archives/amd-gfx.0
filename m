Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7165E9B36A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 11:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5615310E490;
	Mon,  2 Mar 2026 11:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UN/UaTx/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9D810E490
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 11:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLGfxlVRsdT33OWiYvdlMz3+7l+M99wpE4PDud7aB9eVarzJdinMOgOulisjh57aqTC/lHI1B8pQMdMFKilSMjWuLYnbJYJwNJOJnSvSdMti5nNsp1BGQg3FplEHRhl0n2X6cIUzG+o73jsw7q28BLl9ynqgp/EQNiDRgXqogwo5/Hix5lF+hKd+jyrQfDFiVfj8Iohcr4BNuwHoJ2oSeqCqz9m9DWxjeNwOKwjZE352VOZgi5Q7+hBBYEVmU2PMV/RzkkarHhEFuO/Ibd4S7bn8D24JGEqK09ETJNX/bVqlLrGigU+A/DegD2K0RkwfOL1KaDd8WC6KwG/piCvMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oslopPFvrom4/S0tze4qw93Vx3M+MqUoMhHNjInNl10=;
 b=FDND0sSWrbjbq2r9Upe9MKKZVbCwt+J2mz9d4RqKXK1Kzc1EVY1QUeD/UMLfHphTPLM+w2mPCPds9OTqCNJuGHZL64Qa94twpYNZsa2ZplSnTn6XUDR6MeF3xRCb7BJPkAWkWi/+6h1zOvj36N+w5EoHwp3km0TiTBnxQQwbOG8XGZ/+fQfkqiw8GchMrIpPnn8Sg5+BnHlYvmV+a7AHhjMD0K/SSLEcoQE0bPRI9t7T+XFWanWPD0dvJ1kwrzp45sjumTm3MxFs7oYeWPy9fMD8BbcLED5zmzuYyOqjmt52vdfrB6styTzlfdi7ZzrwD+aA9Y2V8EMHkefqFcAYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oslopPFvrom4/S0tze4qw93Vx3M+MqUoMhHNjInNl10=;
 b=UN/UaTx/US85IDzEs8vPxhUmtXK2siciDXFChBIPxUyOJTeOlPpF8b9jc8wMoEe5NCtSppim9NiRnRDGOo03Q1qBl+09x+rPju1ueilOMPdZ5nFrzclAvl76nLgb4ZOAVRfaNutcW3lkogn1Qhv3U+KCUFRYP+922uXoBWaYSq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 11:29:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 11:29:03 +0000
Message-ID: <d2c90a67-9bad-48d7-9a12-df6a4af849cd@amd.com>
Date: Mon, 2 Mar 2026 12:29:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Drop redundant syncobj handle limit checks in
 userq ioctls
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260301124950.1731192-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260301124950.1731192-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3348a15e-1bf5-44a3-b865-08de784ee82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: pA/Pk6cBsSk7A1MwEh4bpAdid4zjFhwvhopnbNqYZrt99GSQIaINIK8xqrdlx6KbNU8nWtK34sQS/soEZSo9cKsYweFdRBgzkzkltegNdSotQIix1ZZsObGURuvFmIa/zs0PafRwYfox5QyjWVrDldcHqLFHxgpNUPSOfoxzrkBUlZYwF8nf3//wh3xyJE+Pvz8h8voAK3GXuy7vxi/Mj/CYzJtz4tvb1teZehi1YpCf7FQBLW9uDxvCRh/2gEethgi7uVIAfwZaJGL+HZkCBWQoC3SfH30aorpM6NJF+yXdsBIYe70hxJ49QIelFrPnm+8fkgzo85jzUjcHdZ9+hMUxDOGASvy5rZp+v5QvV3yGRGI3YwXJfeUFMQ+zYqTvGwkb/UdJ9IWfRSLEvJxqlZ9JyFRT0bBGRYpaXHzc7KdUe2sQmzDGuXhvI3NoNTHzjW1EUGnOhSyrDlNe9Vf7pQfiGoLce88o62kQLf7uCp5sRSZTe56rL9Iq41heUfeAFlHQUWlyizHHhDKROhNlPpZbkzwnpKfCbFwv7gu/adf8UFSkzAU3EBC6M7v1GPwCLnN2O9USUKn37erhUxnKD8gAw5p/Mkp2pwpK/BuBMhfF/J4rjzqFSYkBz7/AJfZlRT+MlTMH2mNkHWqvk5fWE6qK40IHwlqDjzyz3zECk2GpZuG8/ozYO+nTETafjrwrLjU2BRM0ig6vIDaqA75NdkBDjRnY/SJPw53+YdOIsdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdUMmwxdEZhZjNINXFkcm1tOWpxdzhFSitpYUxzZU5TNWU0YUF1RjJqeWJ4?=
 =?utf-8?B?MHNQVm1lN014VXBpaThGRytOQkd3Y3Uzb051UUJwT2xGV1FwOHVETkF3MEZm?=
 =?utf-8?B?MHNVRWFadG0zNDhzVFlDU1Y3dlNEVDJVbWxmS25zQ3NTU0V6anRyRDkrdzJK?=
 =?utf-8?B?eHlLblp3M1FUUVk0Q292VDMrNG01SzEvcXd6K0JCaUJTc2dwa3dkRURFRGpi?=
 =?utf-8?B?RGJ2c2J6WlJYZTYvODFEcHFFR0hFRElKTkpnOEVjZFgzUlY3M0o0YnR0RWUy?=
 =?utf-8?B?NDN3RTA5WU1GaEhZSE5SZTJ1L1YwZzhmTGMyb2FHM2g5N2Q5OUNuZ0k1SnNJ?=
 =?utf-8?B?SG9hVTFMZnNmaSs2bER2S2dna1hSRjBzSXFkWGlSSERZWEtTelVndmY0UEZJ?=
 =?utf-8?B?MmJBNDNrUkhBdFVJbVl4N1JxR0hxTVVpTFBxR2FiMC92QTNzMFRnZkdnYU42?=
 =?utf-8?B?OGVidWRBeUpOTE5OMXI1TnZUNGtpOGxYUHJvM21YWXljNFppQlVITXI5ODNV?=
 =?utf-8?B?a2ZqUXovSEViSUxyUjRYSi8rc3owMnZ2SXVFZkc4KzVvZ2VCakdVSHFLOE9D?=
 =?utf-8?B?ak1uTnFBUWNkZzVzdUNrMGpMdWRpNHFMcEp4MDk1TFM5SnBNUzA2MXhMMEFw?=
 =?utf-8?B?ZXIzUGFFN3N3WExqOCtFWCt0bDYralQ2Z3pnNitvTlp5cG1Ha09FSFR0MEhz?=
 =?utf-8?B?MzM4d2JaYUtsZFdsR05HY1hhVnR5SG1uQURISHlSbFQ3YmVacUd6TDhkYldY?=
 =?utf-8?B?ek40MHZxWjlmNHV5dDhValJTVkZ0eGU0UVJvV1RFR3dSalhDeEttZzJsOEZn?=
 =?utf-8?B?WGpGdXFSS0VIazhwa3lrNTRSQzZFSlVZL1prSzFDemZ5Z2Eyb2JtcjhNaVNy?=
 =?utf-8?B?TEJjbWt4Z012b0ZPU3I4eFlKK0tLMXFaRnppdWpFM0prdDhObXJBT1Bqemt0?=
 =?utf-8?B?K0Fxa1BBQ3lCMTJlbko0Q3M0SGhNT3NYWGc2bEJ5aDZWZmtTTVZnanE0dHRP?=
 =?utf-8?B?ZjRNTldNc3FLckpYVlI1QUtuaDNPMWNrMkpTWW5EY054WkJIbUEzV0psWkNq?=
 =?utf-8?B?elNrWktzMUViTWdSVTZvZTlOUGhhWU45aWd1MndJVllBSk9VczExanRNaVJF?=
 =?utf-8?B?VlhCZGFwN0k4M1RENWFiRWc0YkV5M3VPemZHMkUveWs5d2ZuUExwVmgxMTN3?=
 =?utf-8?B?MVNvNlMzWG15R0diTEhMUTlDZnB1YkNvSllpNXFtL09ycXlIOGZITStmckRQ?=
 =?utf-8?B?dHJ6ZWhBRjBUTmNhckNLbTZlc0lHVzJ6ckIvN2FVTUxnMUpSQWRPV09KeGtS?=
 =?utf-8?B?cFRRbFByTHRDczE3OW85NWRKazhxSXdHZjhYR2FkRXpWVkp0WjNucGRRajQv?=
 =?utf-8?B?eHM1cFRldXVKKzVJYllFdllQZWtFUFJSY2N2RDRYamRnZEMwYVJXZUgvbUdn?=
 =?utf-8?B?aEpBdjRzQ1hmTnpYOU9yZUFPd3ZSSUI3OGs1ejZoSlpuQUdMZEJsWW5hcm4y?=
 =?utf-8?B?dE00NyswNXIwMVdYVEpXOWZzZlJqN0pzaW5sRzl0eE1RMExTVGc3aG1VdEpt?=
 =?utf-8?B?K3RmMS9pU25SdXp6d3RtcU5qK1hBYlVqQ0pPb1RaU2hWZFZhaTBoMVJnSUVF?=
 =?utf-8?B?dFZpTzQ5NnpuV0ZJZXduNDgzL1V0d25TbFdWUDRWYmNZV2RuTTlvWnIrQjJz?=
 =?utf-8?B?ZUJSQ1FPY09NVG90aHhWTTZrVklxbWx4cWJqRkNqWjBEYjY2N09iZGt4dzdF?=
 =?utf-8?B?T2ZMYXBseUlxRS9kMjd6V0M2dkxpWkw2ZzlSWWMyVnB0b2VxeTdsNVBtbkZX?=
 =?utf-8?B?a2ZiOVhwa2Z2TitpUDN2WUs1NFpDR0xmMTZiaTEwd3Q5bE91ZGwzZ015NWhT?=
 =?utf-8?B?UEpVSkJEVERjVHZaVXBhN292Ym5GM0IrUHRFQ2FqRUpyOXc4ZEdzeGU2M2Fz?=
 =?utf-8?B?Z2drNVJiZDZVZERvNmwwQk51Z3B5VkJnc25hUzNkVWNTQ0d1U0JRalpCQkJu?=
 =?utf-8?B?R0w4OEhpY0RsdEVEdzdIUjh1Y3BNOG55VHRGdW1vUTc5b1VIY2daSDlNWGhy?=
 =?utf-8?B?Tlhuay9WVjUwM0JnbmdFMU9NOTA5VTU5L21pWjJiNXh2bVU4ZXhSN1ZGN2R0?=
 =?utf-8?B?TURlclJZWVVBa2h0NTdGUFNPazB4VTBIdkYzT3l0b1lNNlVxUEkwbm16OXBH?=
 =?utf-8?B?YXY2V1pEZFA0Y2ZUWjNrcmt6SEs0cWNJM0JsQWRKN1VpWjlZN3J3NTQ1NXBF?=
 =?utf-8?B?aGd2ODhMWWl0T3VGdm5PVGNxL1FvNWpoYXJ0aEYvS2lzZ1JLU2l3MmdXOHgv?=
 =?utf-8?Q?OZt3SNa9NBpoxVdZ5+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3348a15e-1bf5-44a3-b865-08de784ee82a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:29:03.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFtD1RPhQ2VZzAsNcnxc2SUXWWQlGqHj9M0cVMwE/ILFOkrSZilhMzv+BS375v2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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

On 3/1/26 13:49, Srinivasan Shanmugam wrote:
> Clang warns that comparing a __u16 value against 65536 is always false.
> 
> num_syncobj_handles is defined as __u16 in both the userq signal and
> wait ioctl argument structs, so it can never exceed 65535. The checks
> against AMDGPU_USERQ_MAX_HANDLES are therefore redundant and trigger
> -Wtautological-constant-out-of-range-compare.
> 
> Fixes: Clang -Wtautological-constant-out-of-range-compare in userq
> signal/wait ioctls
> 
> Fixes: 2a235bc2e28e ("drm/amdgpu: add upper bound check on user inputs in signal ioctl")
> Fixes: 7d79dc596e6e ("drm/amdgpu: add upper bound check on user inputs in wait ioctl")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..f90321fde665 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -480,8 +480,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	if (!amdgpu_userq_enabled(dev))
>  		return -ENOTSUPP;
>  
> -	if (args->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
> -	    args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>  	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>  		return -EINVAL;
>  
> @@ -636,8 +635,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	if (!amdgpu_userq_enabled(dev))
>  		return -ENOTSUPP;
>  
> -	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
> -	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>  	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>  		return -EINVAL;
>  

