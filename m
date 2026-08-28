Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8414FC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 14:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181A110F3DC;
	Fri, 28 Aug 2026 14:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gvaieVhB";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E285110F3E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwM3rpo4yJxHsSxBJMU2KoH/xqgtrUlDe7MNXldb22IXwJgPq2Ww8kLFc3XhEUvu/v4eYToSLcOLdKBWlX52+SJ6M+33DwADhqoooafRR/cguPwPrevV7zJJA7x77uG9UYNK4TaMlfD6t67WlFtwcbeX3y9QVQyyXt3EFDQEE9efXRkuxUfmonvcKbOpms8MdsGG1wXKAFy30Eu4Q6/+nGK/fYVVhSShuCAarJs/2JSC8hyUdanMHGnfHOomUQ4X9iN6PciwCKUFPYjTrYg3CKYUwo2wTrCRz/P0AfTh+vhehdRVAgzzHPDu7XiTYB8ZG3PZs7pVxhbVEXSiqmvU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ1wpVKuy9lraLM4sdwcT54/V2EE0NReB7cs3EJhRXc=;
 b=CkzR1LXg7qOJkbi4pU4Lfk4GrbEsh/J6HOtzLknCAFOKzwRshMHHEBnvkTxM6qybZw+6nsR9RiHc23d+n27C2u4Kuf2/0XsSZK1aHiyHTqhEOVyxNgewkoXVE51Ky+OuAAPQvmMqF7NiNEiRnVnk4xL359u8INdpuLJVKs2UCyCqK+AiyAXRnnjZGnih5RfvpKMoaiViR20cInwSZGJ+FXoLZ6BRAJeeds/Yg5TRJT2Kh+tmSdf+v5846Zx1d+VqOKIKD5J60lmWSig///HkS+Q0Qva5lPF2t9sCAV03uwuZPct5ol6Ks3pyiE+Df3dBAdM9ZLmszp/p5uaJd9snmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ1wpVKuy9lraLM4sdwcT54/V2EE0NReB7cs3EJhRXc=;
 b=gvaieVhBXmKGurLMF9Z5hLUCHT37WlBfwfXzrYS57rYEfHq5+qx+0fdrdr9VOVIPYfDy18pd4uc8Mlv0rhiM5EGiM5pP0R2ap4VfffPqDTWmghcv0qow65uYIl2mzVw0MBuuyaU5Yy64vL+I2HAi9ppOCZvbOAUM8nHfu3feK3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CHBPR12MB790180.namprd12.prod.outlook.com (2603:10b6:610:33d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 14:16:20 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:16:20 +0000
Message-ID: <5158d162-f60c-4ef2-b2a2-cc544e1915f5@amd.com>
Date: Fri, 28 Aug 2026 19:46:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu/sdma: Use common SDMA legacy queue reset
 on SDMA v4.4.2
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-5-timur.kristof@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260828120729.25908-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CHBPR12MB790180:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a20d23-787c-4aa8-e655-08df050eeeaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qhNAHEt/L3OQsFjYBiJkwfPhtiv6dnWNsR8Mb/pM1BSm1JTy+tekPqspJvr7ifpi12Q8a7HlH79a7bGvYqlXNzCwmMRniev0wD77ufCkL2XIG2vDwNMRaPq78Os7udAbT3Ms8Gmn/WkIWdcb4E7VYJEZkQaNy8ppzLPg4NkMvumjjZv6WtvSBZsom42gVSxMebBe3fiA2e0yZcmZVrgA2/93YUzNrTuvn0lRVXkkyX42TKkGMe10AR5Dak61aFLEUUi6XWlj1zNknvCddnKY4AYDCOP2p3bstb1JekxIHF8jYdJFPjks6pLYLPbdyve71uZR435Eb4IHNX1for+R63YEixsh92zTanh8BqFVwpjF/eidsPAJYVds1xNbIWJ2FVEbNjE0dHuS773PwLZgq+MzOrvb90iNmGd4ULcrZyvH/yKyghIZhdhxxc++C2HkKmmk5Yq2KxmVMdZu/ZiySctTRoRW6W49tYSc2+GEvK51v8J89ddlsTvMsEJzYQgmGf9Ubi1Un/1v1CeinKjgHdxjaw503bCwXijNsGp8XQ3Axtd1Uy2yzW1t9BiEvfOstyl/OSQhCiHKyB+bi3HNjPFPkAqITCOvCARV0dBFqDEwe/cAl2LluRhYmEab53FsemkPHwnqI48gVlDmo9qiBvsiRnSLXm/Qa/C0Jd3HSp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lsOTMzVHpJbVR6ZU1tdXkrRnd5c2ZHalZGMUtXclZXMmx0MlZ4YzZocm96?=
 =?utf-8?B?VFcxdC9Ka2xYNHovTytIVHd3cjY2N3dIR2FJWW1vd1libjZLWk4xY0VwK01B?=
 =?utf-8?B?UDZsdUFaWEk2MDEwY0VUbmIyZmZKQjhKTWhMR3pLcGtUZGl0YWgxQ09LODRZ?=
 =?utf-8?B?RG9oMVZGK2xRYmxPMC84cDdnbUxnZU93YjUvUHNjTUM1VXkxditvV0hiVjBn?=
 =?utf-8?B?aVpRQndFVE9jWHJUTEc5dTh6R04xNnFRcm43Z3Zzcmc0S29Xb2hCSzlUUWxI?=
 =?utf-8?B?K3dVd0NNcGF1cGpicjd4cjlkTzgvTmNxSnF5R1FIZzdxK2FjbmpwZG1MdlNS?=
 =?utf-8?B?cElBd1ZnQmJlOTVXeGVUVnZ0VHU5L2Q4K1JkeTJqWFBTMkQ3ajNXditBZTQy?=
 =?utf-8?B?NVJzdUdteFhSWTMrV0N0UlJUcG5McWIzMGxuWXI0SHVXN0xSTlZIQzFWOWEr?=
 =?utf-8?B?OXRkV2FqcWRTcllrYVBmdE9adVR6NEZOWEVoZVNaZTh5ZzB6S01oay9SNUpJ?=
 =?utf-8?B?NDVWUnpuMm1mUkpLdWtiM3lyYjIxSkNzTmhFYjZnRTd2eUt4cWU4QWVCNjcz?=
 =?utf-8?B?bDNLNDAydzZBby9DUFVtbkNsZWJ4eUNDTXVOb2x1ZFhVK3dGL0NTTjd1d2k0?=
 =?utf-8?B?MldkMWpMQlNIV2NwN2k0TWNJckFySTBFTHB6ZU1uQzFXeGdkUEo3SUp5elQx?=
 =?utf-8?B?d3JZMUo2V0VJbXRZZFVPd3ZoVGFFQnd2SGc1Rzk3SjJGZjUxUTRrWjNha2VY?=
 =?utf-8?B?bWxEYXlpVmtkQjJaN1R5cXhXN05zc0Jpb2NFdGs0ZEEwRldFemJXcGtUeGQ3?=
 =?utf-8?B?VHFFUzRvcS9pOHhzWFpDeXRqWTUrdnRmQ3IzQVdKL2FFQ0J0dWdIa2p1ZmJ3?=
 =?utf-8?B?QkgzeW5sMXlHcTZ1V0ZYbWZKdGpoSlBObWhFakJMSlhrRUVmamxFSmNzZ2xS?=
 =?utf-8?B?ODV6UHFqdjVKaFBCcTdnTjVVejlzTWJMTzVBcXVIWFdncWtxV2ROOEdBZVEv?=
 =?utf-8?B?N3hiYlA0dXQzRUxPTUZYcWdGMXJOYXJJdVVCREZpVzBOc0V3MDhNVGM4WnMx?=
 =?utf-8?B?dUlEZVFheGxUOElRbDJxY1cwS2FYUi93eEVMclg0VUEzelZ2dXpRRXB2b1hN?=
 =?utf-8?B?VThoQ2NkR0trZVpYSWJ0d1VuT2RIelNtVEUrNWl6SHBIeWxzV1AzVldMakc2?=
 =?utf-8?B?M0s3RktqMzdCTFk0TUh3MFhQSHBrWlgyTmdXdjVOaFNXZ08zMENjZXpLcTRY?=
 =?utf-8?B?SzdaZDc3WHVrdjlhN3MrYzY4UUR3OGdFZDQyTlNyNCs2YmVQY1diM0UxNWxK?=
 =?utf-8?B?WFJEak9obHhtRlZIM2R6QmtMOTVTY1g4b1F6OHlQTSs1RmFWNDQvN2NGdnBP?=
 =?utf-8?B?b09uSzJmVzQxNlpsaHFRZXRza2RHa0hEN2FOZ0c4Z055RXRWVGVNTFhzSk5H?=
 =?utf-8?B?M21FakpCUjBqTTJFQUdvb0pTUTFXbm56cFJqajlCT0hUZ00vYkU4STdSR3Nh?=
 =?utf-8?B?bllBZmFQOW9ISUpsWk11OXZublVzZG51OSs1cjd6ZkJNM0ZmRUNNUGdCYlA1?=
 =?utf-8?B?QTRNaUt4MVRUOEU5dy9VYTdCR3pMakVleVpuTTgrYk5tK0FJTjlpQzFBWkVC?=
 =?utf-8?B?OUhxS29aMmdyd0tkdUtDUnRKRGRLV1dVa1hRdnZ6SlNqd3ZYb0RJQ25tNUxn?=
 =?utf-8?B?RnFzdkFIVmI2dm55bUF1cEkvU0g2SkF6cTB5MWYyOFhucURna0x5NnlEQXV5?=
 =?utf-8?B?MFBlL0hWTjkrZFVMNlF3eU56SlJHa3FNdlMxeHJJZ0dBVDdaQmNOVHhjSUhB?=
 =?utf-8?B?S3hjbWRVajNMYm1YZG9KWEtYcjdFY21RWU9BRVBsaVBZTldWeHVZYmpISGVk?=
 =?utf-8?B?UEJZQjVRcndFS0FLc0huYy9kZUowMkdTRU1ORFpzUGltcmI4NmlabWcxNlI0?=
 =?utf-8?B?WXE5YUJMd1FNd1I4ZlpwT001SE95NG9MYWkxa3hXSG9hZG1mL0J2M011a1Yx?=
 =?utf-8?B?QmVBbGFISkpuUDkwYWxnYlBlOS9qdzVvRTdDMWlySVpST3czYXN5MTF0blhY?=
 =?utf-8?B?QklrQWI2dU9kU3QrdlNNYkF4NllZM1FmbEJuSzlQRmQwL3FCSU1ocERNRWdE?=
 =?utf-8?B?WGVRR2RIdWUyUmMxUlFNdFd4dGhvQ0RyeC9mMWw2QXJUOXVpWEg4QVROM3po?=
 =?utf-8?B?cCthRkNWUUtiVnV6cjUvKzNaVWs3QVFpcTdGcFVrT0I3dFZ1VWQ4VDBTOXVT?=
 =?utf-8?B?aGdlRG1LV0lnc1RJbEhjWTlvTXZwK3hXbG4xYnVaSUQwZ1lXdVF2NXFNWU1C?=
 =?utf-8?Q?e04jr+i6DZGObOzxVE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a20d23-787c-4aa8-e655-08df050eeeaa
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:16:20.5418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUrs4ZyhLrwOiI4dZcHd368IoRTSlBY2oHPZak3qCfrE8wYuruEQOqfiqH7LdKcS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB790180
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



On 28-Aug-26 5:37 PM, Timur Kristóf wrote:
> Besides sharing code, this additionally adds support for
> restoring queue contents after the reset.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 72ea9db939b4..023821848531 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1655,20 +1655,6 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
>   	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
>   }
>   
> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
> -				   unsigned int vmid,
> -				   struct amdgpu_fence *timedout_fence)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	u32 id = ring->me;
> -	int r;
> -
> -	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, id, false);

The common one passes true, so this doesn't look right.
  	amdgpu_sdma_reset_engine(adev, ring->me, true);


Thanks,
Lijo

> -	amdgpu_amdkfd_resume(adev, true);
> -	return r;
> -}
> -
>   static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> @@ -2133,7 +2119,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>   	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> -	.reset = sdma_v4_4_2_reset_queue,
> +	.reset = amdgpu_sdma_reset_queue_legacy,
>   };
>   
>   static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
> @@ -2165,7 +2151,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>   	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> -	.reset = sdma_v4_4_2_reset_queue,
> +	.reset = amdgpu_sdma_reset_queue_legacy,
>   };
>   
>   static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)

