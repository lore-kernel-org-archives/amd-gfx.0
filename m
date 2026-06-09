Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDE5CD8CAD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 04:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA0610E07E;
	Tue,  9 Jun 2026 04:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lo3Dm/Nv";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BD510E07E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 04:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs+352UXsXv2APY+6AZH9V2/HMdc1tAdO3lAAOIEZLOxfBcXDVbVfyYxBxsYlcEzqKHuL45sTt8t8Fp+M0Dwhg91Ea/iruba0ghRBQ+XjUlptlJ18QTAF3garBuEBBkFhNl8LuMEsn05oE7R5CjlXea5wTpoqj3t6x8cRAcE3ZVnw7gTnA/Jf7zgCtXlne0r0hfZ9p91VEoFjRde9U0aTGsrjn+Pq49U6xi8v5EyPm4yHZTHResKEgoC8GUCVNqNSzWAx1wrSO/P0wtnlM7nkBJmRWmRp29nb/bAjV4plK3N/wFpuJqGlCGBas11uuS3im52xmfkuZbyUaf+epIaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sut6JYjebkaWqTgC+lRwmwLKcjn5BXBE53e+j/jKHrQ=;
 b=h7nrpvnR99zmgectud/IiO3ktbG4cmcG/JyuoiA/2d5bLe/CtbK/VnZFywdI7gQzvgfZiwMBQUP11BxEBCLrFIapCxBm6CJyHXRKW1KYkoNE+4QFkM5/oq0mjhLydJZLkzYpKfv+sAAQllOBl+gmddc23NErIf0r4xcg8D9k+GVt0/fI7iGQ5HlSZhHieq7/Zn2Op0+xsu3PIijLIVMmXfvy1bThxzqgYTKBFvkhub1nE6Ir8zKrxU7KiyEZI9N7Piav+uJvpQ4i1Ry8Kcm0ROWPskfiJWBQxMm8343U7ZbSf4FksUQS9oyINuRoGeSnpLzFieUnMhrNdXG2Q3ibrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sut6JYjebkaWqTgC+lRwmwLKcjn5BXBE53e+j/jKHrQ=;
 b=Lo3Dm/NvQiKeA7wzRrUAB2QSKe30LpxRTNRb8OH1SIhzFyANTWnSXVOMTCY/Qhl/qfOYsaXgVYPecKha6zkqC3mx2G9Jxq58m14KpFy4xkt1nDwEh0wJMf40Un8zVjDFWgF1RUIgRiMagl3IjOTm1usr9AH/7pN89AUcZiv+O2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 04:22:30 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 04:22:30 +0000
Message-ID: <08979342-8670-4d5d-a5f9-5c2621767f07@amd.com>
Date: Tue, 9 Jun 2026 09:52:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com,
 srinivasan.shanmugam@amd.com
References: <20260609033850.1672695-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260609033850.1672695-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5c0d27-c1d8-4a97-3123-08dec5deb898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: Q7fYFE6qRxo30Dz9HFrRJEImS2kvk7L+9blwcp5iRmHVFpdMPMjMFLQfZiGz8YbKg3RhouM+Xv2ogU/db3mv77feXxMzu0mbYfBjSeR+FaVQrWCj2P1saqLOjCYviqvZmYDybzq69yfO8ucEeONnSgqHu9sVR3Zmo/TpLNW3lBj1kyYKjCzy7HxaOZP7mwI90LUvn/6NDs4B2+iboVDO5x7K3xC7NEqeNmTOSXlKT5PzLKYxiSKZzK9sP9WRrqQnCDpUgntZbdL4qJfmFtDqhDF6S6z1M4Wone0lfJd9MQspw63Fl6AMFI4Bo9YidnxmZX1aH6iW00Mr2JaXU2ycTe2J4hlzyYb1JdTjCDfL+cEiFXqfG0XEZ79n+RW61VQvuizAT1anVsqWs+CL7fqgX1foC+4ApEtsim5EAFUqHSTBZuozMJZMIID4JDUOok5nZnVzieV7T4/wt7yDjZngB7ZaQoApGe0+wlDozAxudOKSUccf7W+WlXnCMLdYQBOd6bBFVVGShCBQfikv9UM9XB3BE7bBcPfJtbSGCJWuUhe5gww2slR/2Lz1JeAmkegNcUHkM7e0xI2EEnalYJtzG4hNqHEfQILM9lpOCG3X4k2/8nQuJBS7ZYEX+zUMmgnUzOl7DVdP4EIqrD1AEZfYjNjrTmdCnavY0y847EevBpQPlS6xE/n68jXox46kj5U0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVBRQlhaSXN5Q2NjTHpYM2daSXdvVE9SL1gwUFB6Z1NqUGJFODdLVGlybkIw?=
 =?utf-8?B?Q2Q5ZXJCdlZJY2N0a0poU3h3NkhhajlONWV0NktCQzM4dDhSWjRvbE1lK2sz?=
 =?utf-8?B?S2FKemJTOEMyc2x3cjVPaGw3c2ZXaWZvK1NkaTk2ZHJwQTE2MllDR2taUndr?=
 =?utf-8?B?bHpmeWo4UUl0dlJkWUJNVUg4eG11aU9ZZ2hwUitsNEo1dy9Pc09ZaVEyaWw3?=
 =?utf-8?B?RjhIY3BWcXROeGtHZHh0eUdZZTZXbmJISml3Njh1Tk9YUDV3QS9QUy9mblNa?=
 =?utf-8?B?OHJtZXYvRVp1cHhPanA1N2wwTE8wWndoQi9PVk1ML1JJN0t2SXVGM1VHOWVE?=
 =?utf-8?B?TXVjZWprSlN0ZmdBQlNSWUN0Sm9JNFBndTh1Q25aMlIvUXFkOExYV0ZUd0Rt?=
 =?utf-8?B?NDNySUdtb0c2eUVOWDdGVzJCSkdzb3JvVjlWdkIzQkVRSDdOTDIyenZ3a3hM?=
 =?utf-8?B?dmtDLzRIZmdyV2FEOUNxOFdqTGNmYTdBZGJnSVlwV3lsY1V6aVFUUHdhT1Zu?=
 =?utf-8?B?QmRGTExOZjYxSXQ1QnQ1bGZoRWlBTFVvK0NwR1NRVkZ4QTVUU0tNZ2xWa3VR?=
 =?utf-8?B?S2plRDcrYng5akw4aVkyaTJ2NG9vc0pTUytBdHlHOTlPTW1XdDJEZ212Q1pU?=
 =?utf-8?B?UVpUdDRiMW5iWjgzL1FkY1kxUnJjSmNRRzN0WkNQZk02aTFZZXpyNmMvYTdl?=
 =?utf-8?B?cGgxTVg5Qk0zUDBIUnpURndlbHk2cGVIeisxYjYvbDBoVlNXczdndk5MUWt2?=
 =?utf-8?B?aTRvaGNuZ2tpZzMwVkNlSk9LZUlRTlBBNzd5VkhMcDBvQmNxTmhlWkppZXF3?=
 =?utf-8?B?enZhM250dVFnUHNqSmpmNThjMnBzYy9Ja2dOL3BHbW1QeXUrUVIvY3R0SGtv?=
 =?utf-8?B?K3pmWjFzM01aeFNSUVNXRGxBalZ5b1ZRaDZmY1NtRm96QVpuRGVKL2tGVHdU?=
 =?utf-8?B?TXZFL1dldlJCL0x3SCs1ZWlVTXk2Tk1lNllKYmlEYXlSMlJRZUhHdVNKZldF?=
 =?utf-8?B?MEZ3cmM4d3M5OG15dGNUU1NYYkJ6RVVubXZMWTVBQ2tlaDdxUkQ4UHk4aFpR?=
 =?utf-8?B?YVFreW4yRnZsMjFoVzhTaE5lemhtMHAwdkoyMjJybnQ5bVd5bkQ3Z1VKYzlX?=
 =?utf-8?B?MDMrR2hQZy9IRlBoNHhxK1RZWlVvMGtQRGVrTmxIMDFyVFdBNTUwRnBYRGZM?=
 =?utf-8?B?a3RCd0tYaVhPekpYRVNhTnRBNW1uMncyN2xQb0drVlVXSkdyK0U2N29nWWRH?=
 =?utf-8?B?eUZpZEQ0cld0K1dGY3g2UElSVy9GUHhGREdMMHVVTlBZOHU3WmsvbWNzcTBR?=
 =?utf-8?B?MWhmbTlzckh1WTVYZzQxL3ljSjhSelNtbFQ4YzFUemM1QzNDQnIwM2h1bm8r?=
 =?utf-8?B?dWV0MzRFNzdqNzU5Q0hwL2FXTzdwTm1ZRTM0aC9mdXh1MjkyVk5TTkx0cWFQ?=
 =?utf-8?B?OEpVZHloZm10d1o1T1M0UEZPcERXbU1nbUFSRGV6cGFNeWNkbU1Vam9SMzhK?=
 =?utf-8?B?Mjl6QW1CSXF0aG5PS2NZSms4Mk83cUpzVXdIMXU2NkllVGhBUjVtaG9mazNi?=
 =?utf-8?B?SjZLeVNxZW52ZDdGRFRDV2Y4Z0ZFUnNHb0tvaTc1S2N4ODJjY0F3bWM2bkFD?=
 =?utf-8?B?Y2puTzQ1Rmc3VEdQQ2lyRDJ6dnlxVXd1V2ZjWGg5ZGJXVVRBMUZxN3h0alB0?=
 =?utf-8?B?VVFFd2NaRlZ0VFRwalJtSi9Jd2hQV2x2anoyNk03cXBtaGtPTmlWOWpGUXRK?=
 =?utf-8?B?K1VRNnN5OFB5VnFWaWpIcW94TjR0YUkxTFovbnFIbTV1bUdnSkQwTGF2cGJW?=
 =?utf-8?B?Z21HRkg1aW4ydDhxdVdtT3p5eHBaTXE0YXcrTEpja0VTdk9tbjNSRTlqeS9R?=
 =?utf-8?B?M3ZobzNKREdaUStKYXE0WGxzMWdzOHN2WHk4T2NqRVdNcHozaGpwMWc1TTZw?=
 =?utf-8?B?cUNuRkR5QlAvL0NneVFPVmx5M2trVU5QSUh0SndVY0dwdHBGQTc3R3pNYlZM?=
 =?utf-8?B?YWdDTHR0ODd6U0hRV1Y2RlhiY3JOcVJkWFdmalhNaTNQR0N2d3hUcFdOa0Ur?=
 =?utf-8?B?N3NveWZiQ0lKRkE3YUhZcElsMzhXb3BOVzh0dDNBbG51QnF0aEJYVmNwUm9B?=
 =?utf-8?B?dnE1QVFwSzN2VTQ4UmxnOHFrZHNmRnd2cWJsSWFjQ0owNFdZMGpKLzFWZHVZ?=
 =?utf-8?B?NWRxL2hlakNYT2o3Mk1ZRS9xWG1WTzhGRHZ1c2F3WHJpczZyQ0hOVjRuRjUz?=
 =?utf-8?B?NWQyYm9teWU2bnExZTlreURINkFBSmFoTzRIaVI0YjE2VU9qZnNHR2RYeHla?=
 =?utf-8?B?aGc3MUR6cS84c1VQSkZMbC9ZYlNCbWEwMDBoVDRBYUo2ZHpuNXQ5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5c0d27-c1d8-4a97-3123-08dec5deb898
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 04:22:30.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/saGsD4b4OtDaQnGJ6YLzyKblYvG7TPjqu5+Re2wmicXa9AgejtJGLBddYdN5Jv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
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



On 09-Jun-26 9:08 AM, Asad Kamal wrote:
> The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
> incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
> 0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
> kernel page fault.
> 
> The IB only needs to be a minimal NOP shell to schedule the job; the
> cleaner shader itself is emitted on the ring via emit_cleaner_shader().
> Fill 16 dwords to match the allocation.
> 
> v2: Use ib_size_variable (Lijo)
> 
> Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index ff5a55f5f3c9..bce1acf197a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1689,12 +1689,13 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   	struct drm_gpu_scheduler *sched = &ring->sched;
>   	struct drm_sched_entity entity;
> +	unsigned int ib_size_dw = 16;
>   	static atomic_t counter;
>   	struct dma_fence *f;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	void *owner;
> -	int i, r;
> +	int r;
>   
>   	/* Initialize the scheduler entity */
>   	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
> @@ -1712,7 +1713,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   	owner = (void *)(unsigned long)atomic_inc_return(&counter);
>   
>   	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> -				     64, 0, &job,
> +				     ib_size_dw * sizeof(uint32_t), 0, &job,
>   				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
>   	if (r)
>   		goto err;
> @@ -1722,9 +1723,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   	job->run_cleaner_shader = true;
>   
>   	ib = &job->ibs[0];
> -	for (i = 0; i <= ring->funcs->align_mask; ++i)
> -		ib->ptr[i] = ring->funcs->nop;
> -	ib->length_dw = ring->funcs->align_mask + 1;
> +	memset32(ib->ptr, ring->funcs->nop, ib_size_dw);
> +	ib->length_dw = ib_size_dw;
>   
>   	f = amdgpu_job_submit(job);
>   

