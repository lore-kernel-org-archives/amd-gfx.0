Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FE6EFCBC4
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 06:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81EE910E0B1;
	Mon, 16 Mar 2026 06:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKQ/yveY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFA710E0B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 06:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2fTnfwqXamM/diOod+kYBS5/K6wz5ckIMlMze2NMhrtWApL4L3jpi8e8QkefmhOWMjASiiQRTDB17BXvtfycsyIvViwoI7kyMHUMUEvWKYalNEmdw42KPBiEdPbCUQeQRvucqd10QtMhhLN9i2toAiyTxbNADY6RZgCwxV9N6zAWlbSQSkide3qXh4U030dudFE914EUEvIY1fl4Ra3QHX8LIr9YEArkwoCcDa6Ez2Vb32B0daI+SS71Nn/KEPpKxFcMzb0B86wtZwOJRBXe4Fvq2zwmUyxP6enx7E3V91PrkBMpNmZ/K7oINdcRoFOd+Y5NZFnw5ojl0ZZri94zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvzufBlxfeC8sNuEJzREkJwuvlSqE4XFacB9TGLxDLA=;
 b=AXIE/KD4RItPEsJs4iVSwTk/ZnISuJ65D9WHl6WHgymFuCDlooIvuuWSKIgWsuxFx6N9FX5iio8YhxJVGPW1zJf2l3MAKv3MD11U+py/nc+JexuXV0qEugVhxdzJfGaOfdGTK0s8nYMPo+xRb/4hkCSw/0bkIuCxawnoFhsc9Rehn3ADMkzJaTmk9cZ/CsBMXyjAL4yLxF49E1DjpW1e3/mn2Pr/BECDg7FkBIohXLNMkdoKvsNh75CPhiazRLMvp6zB5F5x5dOH4aAJcxABm9cJKKQWiE1SIvbuDACMsbM5hISCH5UGid5jS891enTi/E6Vea9zDxO3qZBqJDjt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvzufBlxfeC8sNuEJzREkJwuvlSqE4XFacB9TGLxDLA=;
 b=oKQ/yveYtYokljNOu/PEE7eUNFNSFGBJOa1TdurGIzJl3/sSzAHNaj8d/FIZsf9HdhOv84uD9ma3EPV/zdAroMbUFp/0PsvRdfvryg5LIuAaHkYxbjMEIrdYYkGKtsNFZiPnCcMYetLoohYmTh5+zJPuy7dJTY+5t99B4hCAoyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by LV9PR12MB9782.namprd12.prod.outlook.com (2603:10b6:408:2f2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 06:48:58 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 06:48:58 +0000
Message-ID: <bb50bb58-4101-4908-aec4-be7003321f79@amd.com>
Date: Mon, 16 Mar 2026 12:18:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
 amdgpu_vm_flush()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0202.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|LV9PR12MB9782:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5650fa-2ceb-4460-a5e9-08de832818c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6ArvA4ngV/qV0c6ufDGGbD/MqrUcH7OSHZPX07Sl+h/BNYlOV6aFgyRH/XLy7lIVOiaTsGMH9lrQeEa2OzUR0Sy0A2qmG+nv28r/bDrTqt6/C/qMemjF1/x5COiB0TbFET7u9ZM0aSfDyuoNgrwpoagqH0DvBRJGGz/mjJqgKt43suqLjcv7z6NbMK7AWX6hBiuhnnhHcUfAF4v+EbbzIVIWWRQONLj8mM3AIjBp+3NRpzks07QELfSd54cxZGWm3NwfHzOI4dwAi2SStqF/kbncSuEb6vkaBNwUw8Xwj2EEmK/WLGhiWPehjHzWZ8eO90SE2zz98vTsnvYrheBSdQQIkiE5Rb2mg8BNpeoQTAPvlzDD9oM9MJYDwmcMgmdS36yIxISOePFYqCVtVe+YzUvIWU17t0gUSJ9Sc7UYOF7mtuGTzhgpE2FhR+9rJxfiILqz+76p8biciwGJO6VSX3ZPLSvxi1GVB5thWoeYr1MD2ZKYstsXgQyAjfMUuuNYeaFSk0+99Ttq23muyYoLzYXcBiXelVpnqSGfFK3uSZOTXraIJGMkFMeLzNHeP38XixCKKEYFG5fRidixj+HM1EDNLt8jt6geH14Z3H4uNcNBdftE4b0mNroVgI1nBfdabjxsXb8x5fHY/2S6iBpyIxd+rR6lR73Ktaiichw+SM/boYYPDEFfazI58p81u67mRNz9xqPwCBb1878SGwpbIS00A5asr83IVRx29Vo7hZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndtZy9IeVg3Qm1MckwvcE9JTDBtbjZFbTV1aThQaFZMcVVoRkFYMGUvMTJx?=
 =?utf-8?B?akpNL1pubzM5aXgrRWFiV21rajh1VGJ2UjltN3c5Sjl6dmwycnRvWUZMMVh4?=
 =?utf-8?B?Nmxyc2NJYnQxbTRtYXZtRHhxek5jdVMvWEJHSHR3UURhMHgwM3ArV0JoNnNl?=
 =?utf-8?B?VzUwWGgxTTZsOXF0WlJZUUM2cmtJVTBWYjlFWkgyL0doL25ROTRiWlV4WHRU?=
 =?utf-8?B?WXYxSDBtL2RhN01LYlpwdklVRXNtR3NFUnNoaEJlT09RVzlpZjZka2JPZzJK?=
 =?utf-8?B?dG5Yb25oKytlWkZsZjU2SVNkRFdsNUdRWTBJK3RSWWlOYWhVZURSM1VPODlU?=
 =?utf-8?B?SkJHR0dQaFNseXE0QUhsKzhmbFhqREY2Z2NMZjZSWHJLRjlzMnBaUXk3OHEy?=
 =?utf-8?B?NTFZTEQ4ejdvWGVoNFhVdENlQ3FWQjEvaW16L1U3djJhWjhOdmdiQVNnMGhQ?=
 =?utf-8?B?ZmJRbm1kYXkzSXNpU2hsaXI2RXNaYkxRWjBJVXZlMVNwU1o0aFhsNTEzbEFN?=
 =?utf-8?B?bUd5cW5DWmtJeS9mZkRnbEpoejkzZmxCT0dncUkzYUVCanhRWU1tZWtacTk0?=
 =?utf-8?B?WmZhM1FpYXFyWVU3Y0lLcGhoN0psYUkyZTc2Q2JXTjFnTi9JVTRYQUNnOGdC?=
 =?utf-8?B?blVTV0QzaHRlNVk5c3dES0VLNFI5R2FLbDJSRUFrK2tyT0I1amtrYjFhUWdK?=
 =?utf-8?B?RWpvRTZXN25KaFRUV2todmViUktqdGNzTHVZck1HbFhxN0ZtMHNYUkwwc0ty?=
 =?utf-8?B?N2ZKeUFFUzFXR1M0N3BWaC9hR3dNSHVkSFRYUmYrdFlQaEhTM1libXlkbnNW?=
 =?utf-8?B?Mjl1ZHZzZzhvaEtMMmNNZFN2N0JUSnZxdjkxaGFIR0gxeXpSaEdmTk9pbHNR?=
 =?utf-8?B?L1grS1l1aTZDOTdaRFhuaXNEK0l3SWR6WUtrNTJDTUFjejBKSUtZUENKM3ZO?=
 =?utf-8?B?OW9hL04vcXdvZXBnZUY2dmRTYW5OWTgzY3B6bDZDcE9UcEhLcjBOTWY2QlhM?=
 =?utf-8?B?RVlnOTg1b2JkakExK1N6WG5uMFhSL1EzK3lOMjV4L2oxZGlmNjJJUkk2clFk?=
 =?utf-8?B?UWNLYitGWm5PUWhVYTFwR1pCeDRsWVlLaHBYNDhqeGx6MG5Qc0xjVHhXanVY?=
 =?utf-8?B?TWx5Z0s0bGwybFVpTzdiRzRIVFNCcUUxUi9HNVd2ejNxeEQ4QkcwdkxvcEdJ?=
 =?utf-8?B?VHlVdExoWlM2TUhDekJMcDByS1Eweml6YlRkUGtJN3FXbTZqYmZqYU9BWktv?=
 =?utf-8?B?WEhyY3g4ZzlVMEdiOEZpTkpYTXFqMGpBQWJNNHhxbTFnOUhIaE9ycXhhSXpm?=
 =?utf-8?B?WXdyU0REc0ZFcDFINCtxUFdSeVN0OFIvQ0EwL1diUTE5TnE3b29mNjhSTXFp?=
 =?utf-8?B?QVhvWVhEZFR6TVhURDRsUEw3SHUxK2VtN1hDZ2oyejBtYVdHeEFSNUx5ZmlH?=
 =?utf-8?B?MFJJQWRJRytKaGROaUZaNmhqUVg4alZYM0JDWHdQb05DTjFUU3h3VHZIWGM0?=
 =?utf-8?B?RExjK2t2cjRQa1kxSkxIRytydy9Eb09YbXhFUTBLOXlaQllpWm1uNUZOY0Fx?=
 =?utf-8?B?dXFoVUNCV0xxYzI0czhraVlTa1ZGaVBUc1VTV0hQbUlaZFJySEFleDNPRTk4?=
 =?utf-8?B?a0g5UlZONUtzTzVRQ1RpcjcxejVPT2JNKzFaS0IyTmxGZkdSR0tCbnpMczRq?=
 =?utf-8?B?MXo5UE85akVUY1pUK3FLSURZeHFuTXk1eU03K3BqcFRxY3RCdE1OWVdxOTN2?=
 =?utf-8?B?R3dZaWdLVEhMVHFVY21VTDkzbXRCWktiVk52UFZIdm5STEVKK1RZcmk0WmFW?=
 =?utf-8?B?djUxK3Y5eVAwVlkxVllBdmN4YjhISGwxaVhmSmFIMzUwSjlPSkF6WnBCVEw2?=
 =?utf-8?B?cmE0L1NVb1dPcWJWaitEMDdGeHBnMFRRZk95dzZFSlNmSFNpV01jd0tGM2Vq?=
 =?utf-8?B?Ujd2QUV0RVNqdE05c29qSzc5aTdmMUF3UHBZL3pVT0dPNzloTnZUZG8zc094?=
 =?utf-8?B?UEJaNFc1RFVDSWlpOTBBMC9JM0RMSHJtOGQ4em5OSzJjRDJGWitpSFJQRDE4?=
 =?utf-8?B?OHZXaUdpcCtScTFNQ0dWOSsrMzBBU2dIV1F1eERlV01SNTlCcmR4ckFYQmJD?=
 =?utf-8?B?MzRhd3hrcDNoRHgxQitIbHJuOFpldlVVZ1p0YU85K280YXR2WC9EeksrajBX?=
 =?utf-8?B?ZkNOcmlDa3hMSjhWMWcxRVgzZDFoK3ZsQWZBTnZSclYzbjdxZ0luaktaOEkz?=
 =?utf-8?B?MDlHWUN0dWQzSXd3dWozeXdRWjZmdnBVeUhqM2h4dXBDd2JiWmpEYUxCSXpj?=
 =?utf-8?B?d1U3ajFwSHo5aUtxMHdtNlJ2WTZLUWl4ZHJXenQzaENabk1xVWI5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5650fa-2ceb-4460-a5e9-08de832818c6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 06:48:58.3644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajWoQ/DNZJ2fJp3MawgVqpE1uEh+oZtUvdnPyAArTHFBbZhZ4PRVCqAEGD/OWa81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9782
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



On 15-Mar-26 12:25 PM, Srinivasan Shanmugam wrote:
> amdgpu_vm_flush() sends commands to the GPU to update the VM page tables
> for a job.
> 
> When a job uses a GPU virtual address space, the GPU needs to refresh
> its address translations after the driver updates the page tables.
> A VM flush tells the GPU to forget old address translations and use the
> updated page table mappings.
> 
> This flush command is not supported on all rings. Only rings that
> implement the emit_vm_flush() callback know how to emit the correct
> hardware command for this operation.
> 
> The function already gates vm_flush_needed on the presence of
> ring->funcs->emit_vm_flush earlier in the logic. However, static
> analysis tools such as Smatch may not track this relationship through
> the vm_flush_needed boolean and warn that emit_vm_flush() could be NULL
> when the VM flush command is emitted later.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:826 amdgpu_vm_flush() error: we previously assumed 'ring->funcs->emit_vm_flush' could be null (see line 788)
> 

I think the code logic is correct and the check is implicit in 
vm_flush_needed. We don't need to write code to eliminate 'false 
warnings'. Moreover, it is inappropriate to use a Fixes tag for this.

Thanks,
Lijo

> Fixes: b3cd285fa68d ("drm/amdgpu: update the PASID mapping only on demand")
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..cc79cb7dd4e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -807,7 +807,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (cleaner_shader_needed)
>   		ring->funcs->emit_cleaner_shader(ring);
>   
> -	if (vm_flush_needed) {
> +	if (vm_flush_needed && ring->funcs->emit_vm_flush) {
>   		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
>   		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
>   	}

