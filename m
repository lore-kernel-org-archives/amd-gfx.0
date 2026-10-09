Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91681CA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 07:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E531610FECE;
	Fri,  9 Oct 2026 07:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZ0k3wdN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADC510FECE
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 07:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbTHihmBImSwUF4QYL9nu02g4E0xK/RdgC2DjYTe18qVwcNN71xzQPrU/Q2r4eHCoaOU5VlY0/rR/5tfMGwlB8Vo6bPe/nUDwDyBzu9BrrctStWrlYYHq6JOyAwySElBKtl63O6whWTvb0NV2lZofe4bp6GPXwqSbcXVfC3eOF/M8O69L8xhNks3LyY+gZHYoW8SWbce40uPEPYqEuv2DCuEpW4b3PLwtRa3zoSm2+d/kMrHU5RMl0wom4d+6aYOBRKTvKbt/+iV0Jkih4whzVSZs10wAS9zUHSXzPmFPkLnuTHt6tT9kG62lcPGHA+mbVWVS49z/5nMNusNu5iFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tABKd2Lvp/UGCjY1DdNdGcsc/lUt/w3zdeVTRzjaCIk=;
 b=T0/A7GuxokH6RzZ7bABevjEHyFA0JdzMCMmoJgYoDMlqTD92QP//zDahoJ/fGEZo8Tv/HRt1vkQmqt5tCe3PEI018RTaP4TgEDPxcSs2FlTDZOr18qCPSUYg8AHIJfMAa3/iaUpLUTaFa74Np1ur0kl4tzKh6ohrAscRB6bvwIBI617bqFt2QO5RZG82iGkXiay5NRKKu4c9UixYhciazrbuBtq+BJ9+BVdFrlr1qqp9d6/Whd3/COuUaQUIjR7TPWN0GQQlKjcBqWQgdzlWUlUVtgehHpMVjP4qfP0jDEpYVNN2z/54cftLy7koH3+zCz/0WEB1KJEq6AmeOpzZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tABKd2Lvp/UGCjY1DdNdGcsc/lUt/w3zdeVTRzjaCIk=;
 b=QZ0k3wdN0iVN2faJJlY6p7rK75p+m+W45n2A002R+uVzTlAEiWsNeZhk30ksyASHN1FByXMXffhUu9MfCoA+dqzYmYTiXL/BKr20PpZPbLbC0kmKq/Jq3BvqQGJ8r1+ccxa+jys7dK5d7YSXJr+kOoqVtSEV3Fr0hDMT4EFAZYc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 07:07:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 07:07:34 +0000
Message-ID: <01f9a0f8-63c3-4e84-a17e-51ea8f9b6104@amd.com>
Date: Fri, 9 Oct 2026 09:07:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: place GFX12 compute queue MQDs in CPU-visible
 VRAM
To: Geramy Loveless <gloveless@jqluv.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <01534506-891e-4d0d-8d0c-fb5e82264c03@jqluv.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <01534506-891e-4d0d-8d0c-fb5e82264c03@jqluv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ea30d5-4612-40c8-a159-08df25d3fdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V/v83ReSMmHs0b5OY/sa3E6riMArVHy+2npyhHFfFJZJFglMh+TBmlq6rrTQYqWYX8UCUKOVlcGVjA35NvKzzVdaDeRqiWBwjQwgweIIyQcoWe3p8P3GwwoijPPdVglKmvk2SYATS9RhplDd14L5sBRFhZe7N/MxBsU8gwOp2ecoHsCd/1BEkoY+rHDgy2CJ0TPy/+6CafswnRexLh12ugMQKTJ3Oxh5xUC8ON/pXEOvTVpiqv5xI3Rv4phvHxCcvYwhlOsk65yG5x66SMGjIuxyNgL3XMpB8JwEpqC8mZN9t07jM0h5ktAuWzHuGfD4nKzqHhlcD0fWk+Gzbw8BvGP6LW8ZF6q64iVbXNYGLUstJmVHAAPvMF8X17HilSpXEmwjB3Wb2WCov4UXCUlwBaHA+Xku2bSH+yPNQokx4lU6tAA3J5YF0jabnIk7TflAFnYTu6S+29XRVGsVi5ny3CNp55nXzef7iwUw72r/srXJYFkADW9/v5R9NtdU4SIBNgRz2v0O2d9LFmq/qxvOe5sKDxatkkGT6dW53y6FFIyXlHrnkVpYoRq9c/P+J16uxz6vZKVhP0mXQvF/+Q4NJAU4lauGgfRJCEglglRapJml/RFRbRnxC60jnx7Ooc64HivImnWUKjq9IX8hbnJgPhEYAdFEQZVMdohgZuvRHDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVIK1RMb1E3OEE5Vm03WU01SEU3SFliMTRLMUNScGNwYktwaHpLMXpOVWdI?=
 =?utf-8?B?YWVyQVo5QTBsem5NTkJGZFN4STd1RXlzMWxoYklBdW1wOTNmbU1lamFIWnds?=
 =?utf-8?B?dmV1N1dYeHEwZUpMOFV2anpZRTV6YmNvc2JMb1cvbHpWai8zZEdaQy9WZVZq?=
 =?utf-8?B?YjBsZFY0OUdsZkhxNklpQWF3dTRqdVZkTkk3MjkydTlLc2l4TlAwQXcwL1R5?=
 =?utf-8?B?OVF4dHpKWlhaZnNuNWFtMXkyaGdOU3pWdTliNXVFeElqTWpuOVJ1OEVxSHo4?=
 =?utf-8?B?RE5HVWtVQURSekowQ2ZJZUtqM2sxZC9rYlcyRkk3eUI1aStTQk5pQkErbFZi?=
 =?utf-8?B?UFhqNnBLaUc0cFVIc01NQkh2MU9aOFM5S0paS0c2YVBDWU9leXJ1VWUwV2d4?=
 =?utf-8?B?SUxwZGpyWFRZVW5JbmdZTXlpVW0vWk1ZSGVLaHozbTlnYmMrcXc5Q1lxbUxE?=
 =?utf-8?B?WFRwQ3VyanpnZTRpVStHb1VKZzNRVFdRdnByUUZQTmxOdUsxdUlkQ3d5ZWZw?=
 =?utf-8?B?d29KdVNaWjI4R2JEZzg5N25VVlhhbHpYNGswVDFuWGdOcEFyRHJMQnZKZ0p2?=
 =?utf-8?B?NVNNK0gwcWVPSFo5bXFoRlR0MSs3cnkyT0taUHR1ZFhUcHdSYjlFcE9yR2d6?=
 =?utf-8?B?QUVrWkpMVGJ4bGJ1TGpVNit6emJrdlFkdEhXSHJqNFBsWkdURmhRMDNOMDdM?=
 =?utf-8?B?RDE4NHN2a3pHL3EyNHhJYmExNzM4UGxvZjNZVXdhNHhPaTdGMlRyTWNMMjNx?=
 =?utf-8?B?M2k5aityYks3NWUzRTE0WG1EN0orWElsQVRNNHE2aDl5Y2xuNWJpY2ptby9q?=
 =?utf-8?B?ZlM5Y1BKR3l6M3Z6ejdVbEZDNnZDaTJPU0NETzRuYVlRZ2FPaGxnQmRTZzhN?=
 =?utf-8?B?V3RYV1NhdHdPaVNMYUN3aVVLZCsxaVRQbmZYb1BNUG1DeUFtM0V1UC80OXBU?=
 =?utf-8?B?KzI1eVFreklib3ZIYTQwMmliTCs3NzJRdkZEOTBYZ2Y5dFpwaGFhK3VNV3NS?=
 =?utf-8?B?WWdkWFBWcFlmeHlzY0YzQmIveDF1ZU1VZjM5T2w2RkZXZ1lEcXh2MHZsb1A4?=
 =?utf-8?B?K2xHWUhNK3FOc1lJdFlRUVRnTWpna3JiT2VRNnFqcVhrRXhOQ2xuK0Y2OFZm?=
 =?utf-8?B?WFlHV0RZU0kwb1gxZ1lVT1RZMFo5OXlHYmlDemtxbzZJNkh1OHhrSzlqays0?=
 =?utf-8?B?bjNJTmdOcXhhbk03YVNYT1NqR1RqSU1GblI1bHlRMWJwb1ArU1dMQWxlL2pN?=
 =?utf-8?B?WG5weVhFd1FLQXpKSEFXREJMWEJ2WEdHQlkwMU9hRzBFcEJvVUNJWUtPL2Ju?=
 =?utf-8?B?Y3JZaXVHbVJzTjc5Mk4vdHI3R0NHbCtXVEhEdGpQNC8rVFRRMzVzTE4zb2ZR?=
 =?utf-8?B?aGI5citXSVQ3MUV4MU1BMFBtVHhJcWtNTnBrREcyRVNtNFI5NVpEN1RWVTQy?=
 =?utf-8?B?dkE3TXdMY0tIOVJ5bFZBbnVRaGRVblMwZWxTaHdNUnBvRUREWm5RdUxCaVBX?=
 =?utf-8?B?dHNtUlQ5Y1VheW02RXFMNkpiS29CT0o1TTdnSzRrZ1ZtWGhJWDBSV0VXUzlq?=
 =?utf-8?B?NlByMHhwNURpWUZBNWRsUDd1Q2daVi9zZ3pmczJ0YllpZ1kweDNmWko0bzZK?=
 =?utf-8?B?SGV0c2hReUFSU1FpNkVxeXRWZENJdk1mYnVkZnRJdlpoWDNMOTdDdUg3YlNU?=
 =?utf-8?B?NmljRDRDWUhVUlV2ZUJ3dW8xbGkrREQ5QlVjYkI5K0dtMjFLM01ETkJPcTZw?=
 =?utf-8?B?SjlPWi9XRCtMQ2s2ZG0vQitsSE9aVXF5YVBhVVY4NHVxR1RVMFg4dXRaRHNY?=
 =?utf-8?B?cHB1NFRrQkJTTXduSjY4M3dlR2IySzUvQk5TcUJaZG1sSWpRQUJpRjhNWitQ?=
 =?utf-8?B?TzY0cWk4NHA2TXRtN1krdmpMMDJwT29Ec3RYM1BBbFk5RUFHcURTT0pIQWNr?=
 =?utf-8?B?dW5tVmhWTzdvcDFUSVZPbmIra2k0NlRhV093WGtMUzlGRFRKcXBvUlVTRTYx?=
 =?utf-8?B?YUJRbmE2RzlxM21iL2RxYXQ5eWFaSHo0OUV1WEtwYWw3aTJSU2x3a0NxdElR?=
 =?utf-8?B?QVVtUkJCMWFpNEFWQjhxbGsvRlpzN2VPbmFXMk1IR1B1aDlXUWdZSlp5dHJW?=
 =?utf-8?B?WnZ4dDdEb0o4N2NINVpHMUorTFVIYUJJZGptTWtjZHJlRUFXMmQxeFhYSXAv?=
 =?utf-8?B?U1RGRXdsbXBLMmx4aE0wQi9EekJkbHBZVkwxSE45WFlGc05ibkhsTnN4TDhH?=
 =?utf-8?B?RnJiTUcxZkxRRkJFQjVpeEFvRXRML2RNWllBbDNUdVRaWHFpbk1TQ1dnOXRI?=
 =?utf-8?Q?+FcfKkquK4uwEvqkeb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ea30d5-4612-40c8-a159-08df25d3fdef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 07:07:34.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdAO1/BLedK5EUoQhTGV5vIiem8JyIwfyN9lXn93M20xHmkV5zTj/k742htWnUTx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
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

On 10/9/26 00:11, Geramy Loveless wrote:
> KFD sub-allocates the MQD of every GFX12 user compute queue from its
> GTT pool, so the MQD is in system memory. The CP accesses the MQD while
> it runs the queue. A dispatch that exactly fills a shader engine is
> retired through a path that accesses the MQD, so with the MQD in system
> memory that dispatch pays the PCIe/host-link latency.
> 
> Measured with an empty kernel, median of 200 dispatches, on a Radeon AI
> PRO R9700 (gfx1201), for a dispatch of 253-256 workgroups x 256
> threads:
> 
>   - stock Linux (MQD in GTT): 26 us, against 7.9 us for 252
>     workgroups.
>   - Thunderbolt-attached R9700 to MacOS running mac_linuxgpu running the same amdgpu code under a
>     different host OS: 51 us with the MQD in system memory, 17 us with
>     the MQD in VRAM.
> 
> On dGPUs, allocate GFX12 compute queue MQDs with
> amdgpu_bo_create_kernel() in VRAM. That sets CPU_ACCESS_REQUIRED, so
> the BO is placed in the CPU-visible part of VRAM, which is needed
> because the CPU writes the MQD. Flush HDP after CPU writes to the MQD:
> at the end of update_mqd() (init_mqd() ends with it), in restore_mqd(),
> and in a new update_mqd_gpu_addr().
> 
> Add GC 12.0.0 and 12.0.1 to mqd_on_vram() so the existing S4 handling
> (unpin at suspend, repin on resume) covers these MQDs, and implement
> update_mqd_gpu_addr() for v12 so the MQD base address is fixed up after
> a repin.
> 
> This follows existing practice: KFD already places compute queue MQDs
> in VRAM on GFX 9.4.2, 9.4.3, 9.4.4 and 9.5.0 (mqd_on_vram()), and
> amdgpu places its kernel compute queue MQDs in VRAM on GFX10+
> (amdgpu_gfx_mqd_sw_init()).
> 
> Only GFX12 (GC 12.0.x) is affected. SDMA, HIQ and DIQ MQDs are
> unchanged, as are APUs that prefer GTT.
> 
> Testing: compile-tested on amd-staging-drm-next. The patched kernel has
> not been measured on Linux yet; the VRAM number above is from the other
> host OS.
> 
> for macos r9700 support reference where i prove the gains:
> https://github.com/lemonade-sdk/mac_linuxgpu

Absolutely clear NAK!

You are missing tons and I mean litterally hundreds of technical pre-requisites of doing this.

Keep in mind that VRAM is not coherent, you need HDP flushes and iosys_map() handling for all memory accesses to the MQD for that to work correctly.

We have some internal patches to do this, but IIRC they are still not full stable.

Regards,
Christian.

> 
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 54 ++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 9b7859a77..e6b45950e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -326,6 +326,8 @@ bool mqd_on_vram(struct amdgpu_device *adev)
>  	case IP_VERSION(9, 4, 3):
>  	case IP_VERSION(9, 4, 4):
>  	case IP_VERSION(9, 5, 0):
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
>  		return true;
>  	default:
>  		return false;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 6ea09b031..d3a8c2aed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -92,6 +92,37 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
>  	return mqd_mem_obj;
>  }
>  
> +/*
> + * The CP accesses the MQD while the queue is running, so keep compute queue
> + * MQDs in VRAM. The CPU writes the MQD, so it must be CPU visible.
> + */
> +static struct kfd_mem_obj *allocate_cp_mqd(struct mqd_manager *mm,
> +					   struct queue_properties *q)
> +{
> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
> +	struct amdgpu_device *adev = mm->dev->adev;
> +	struct kfd_mem_obj *mqd_mem_obj;
> +	struct amdgpu_bo *bo = NULL;
> +
> +	if (!mqd_on_vram(adev))
> +		return allocate_mqd(mm, q);
> +
> +	mqd_mem_obj = kzalloc_obj(*mqd_mem_obj);
> +	if (!mqd_mem_obj)
> +		return NULL;
> +
> +	if (amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM, &bo,
> +				    &mqd_mem_obj->gpu_addr,
> +				    (void **)&mqd_mem_obj->cpu_ptr)) {
> +		kfree(mqd_mem_obj);
> +		return NULL;
> +	}
> +	mqd_mem_obj->mem = bo;
> +
> +	return mqd_mem_obj;
> +}
> +
>  static void init_mqd(struct mqd_manager *mm, void **mqd,
>  			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>  			struct queue_properties *q)
> @@ -242,6 +273,23 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>  	set_priority(m, q);
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
> +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
> +				struct kfd_mem_obj *mqd_mem_obj,
> +				struct queue_properties *qp)
> +{
> +	struct v12_compute_mqd *m = get_mqd(mqd);
> +	u64 addr = mqd_mem_obj->gpu_addr;
> +
> +	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
> +	m->cp_mqd_base_addr_hi = upper_32_bits(addr);
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>  }
>  
>  static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
> @@ -409,6 +457,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
>  		*gart_addr = addr;
>  
>  	qp->is_active = 0;
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>  }
>  
>  static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
> @@ -454,7 +505,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
>  	switch (type) {
>  	case KFD_MQD_TYPE_CP:
>  		pr_debug("%s@%i\n", __func__, __LINE__);
> -		mqd->allocate_mqd = allocate_mqd;
> +		mqd->allocate_mqd = allocate_cp_mqd;
>  		mqd->init_mqd = init_mqd;
>  		mqd->free_mqd = kfd_free_mqd_cp;
>  		mqd->load_mqd = load_mqd;
> @@ -465,6 +516,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
>  		mqd->get_wave_state = get_wave_state;
>  		mqd->mqd_stride = kfd_mqd_stride;
>  		mqd->restore_mqd = restore_mqd;
> +		mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
>  #if defined(CONFIG_DEBUG_FS)
>  		mqd->debugfs_show_mqd = debugfs_show_mqd;
>  #endif

