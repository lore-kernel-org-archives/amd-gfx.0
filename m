Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828C7EDEC02
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 03:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1532D10E939;
	Wed,  4 Mar 2026 03:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hq21JW5w";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A11F10E939
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 03:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYe/ODTHH8RsKJ1kydZtsPDkKmm2WfKcpuELDhTXuQ1YOHnNglOOkj+nHLADjEqsWLvxdiw/HfeuDEozbolNjzN9N1rCOYX2iw8tFuCRYBEipAt27SuBGwTXAhcpLaAT6VkBXPjOP8zAm2l4DGdi7ZzvEWdXX0rlTD81rP/UQeYSs8U6Mn7vPdijaJk4Nk1QzsA6xToSAerbUQ6lkNATjb8cDbEpku3ykbKEDr1WBAUAU0PjoZ3O+vc9GzfReJB7TYC/LL48ufkYf3RCSCiIWJxfmjU1xvn4YereELX1pJflsEdXqlCVH2QZtmZLvnN23mo8jFg7HJHfm8wjtXKLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcOhEuFbBeY2+E7kSdyeeb1t0IgZ6GLOigqjuKdDuOk=;
 b=ODbZKPDbVc0YWA8JPKYPVfao8nHdF18HmXRqMvZQqGybkJN2gehcqJzM7ptf2hFLUdX6IUbNf3tRgzKL4xmCXKgDbFBqgf/0Nfcor6tIqjRbNcDcU/TdxqVYRTKPTZM5YzpMh+Dv7/TNJRrHngixr5AC4hidZwZoeTWAREkUu9vOFlyncaM5qWArMDv23c4fDmnV3qQnm6XUUsURVffSCi8sqH57BdR2A6/P1hn3Th4NG5gAFIR1SBfmIphyBg4PW4ps187tSeX5yP41fI5C7DYZscwqyv9R97kWAcHfgQR10pxceZFEYrLq2Iit71RdYRPC6hYCUIrThLp0BS8qpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcOhEuFbBeY2+E7kSdyeeb1t0IgZ6GLOigqjuKdDuOk=;
 b=Hq21JW5wr7dL+FDVdynWLwAbPyF++WhnO8OilBBwxqJ9fL6BUnmP6MIf3TSWZfbPmru1sag1KrcRWsbNcnw8lxOsXhTYbutswHoqUTQtlt+5MM87cUHxdrWXbYHc0l4IU90qrC8Z7Q7dTNAsNO8L1/x82G/JRmxDr5Devt39cl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 03:07:15 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:07:15 +0000
Message-ID: <e1289ed4-1ba6-4ee2-9858-68ab42abcd79@amd.com>
Date: Wed, 4 Mar 2026 08:37:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260128195327.2158888-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260128195327.2158888-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0144.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 9867d9d5-59d4-4444-5b72-08de799b2336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: Pz/YS89wNIO2h2y6ZWJRXfSms3QGrGCLBztSPmb5iizlr3Qs4TDTj7ziSjHDrUfYof+2J8APB9iN9URU3uTstRrfP0tu59Lipc6jjbNLljKboY4dZg0C+fw/3DPcNiptSpvE39ZmJdbOOPtWQEebSx+dJDAkP4hUy0ZUfBsTkVOoHX/NUMul5S6mDJE1PVGS0yg9raBazIXIzPY/qV12F+OzLd2dtrFmi3C+6rOveHJUJDGdhxLXMrzNIierg94DI8Xi/pChWTH3O8YQPLLnTz3WcN5i423xICUoXWv2eKQ7lKNMap1OQtsha6/oqJtMnJ819D2e68+9bOzNMtONy3f/r7zCZ1iSOrmZ6MeghrrAc8P1NAhv7kBjm+16Bdo2Vn2l4wuENDQVHQJpmLljmxZILBUURwFs/PLuEtDknTT4UKzgjuwsZqhCsKpUcBPTIqV+friszC8otNwDgLIbibjgk/uJQQ7WjznzacstZIPryMirr/IUy0a3O20Ia50UeIPTqudnCHusPuJyMfPowGEaD6Ig5ddI52VzgTDhH+i4IsCjz4ks1FxJPwVBO05afXRM2k8e0gC8IobH4NB5LTe2j1XflpbbuLI5j5kdkERjyedBTY/7prPfc8P5ju8wIvfbYxsAJdGrrhnAA7TjuE0+c3fImL3nkIPwHmcpzilaHOVBqsNakh3ILcv3o1OVZ7HKAIzN+s955QAoi5zFYZTkRQCj5YhQQ4w/62a+Cow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG0zZDdrdmxTdFROWlVTK1VPVTZOa1dsTW9oMUxRTDd3MUc1SVlqbDRYdDk1?=
 =?utf-8?B?b1hTL2V4cVJqM3hXb3Z2VGZEek9Icy9relJZODgydjRwVWgzMyt0NVZpNWl5?=
 =?utf-8?B?b2w3aWlqeTZYbE95aGhsMW12SGR0VmJHdWNxTktyclU4N3RySlkxL01lTmN6?=
 =?utf-8?B?WFUybGVlRW1WT2ZCemNaT2tSSC9nSnVoalBVUXUrdXpDMWdCRHFqUDQwVUdq?=
 =?utf-8?B?ak9BZ1BSSEx4M01hc3FoUmtKSjh5MG0va2l1RUI0SHRmUEFzdDV0S3Rmc2Q4?=
 =?utf-8?B?b09yUmZBRnIzc3JWT1ZQWUwyUzdWUG91Zm14djBXOTgyVnVqTzVpaHZMTVZn?=
 =?utf-8?B?YWcxaE1kZGVjNzJXZFhvYkxXdWhaQkxyY2xMWlNuU3FqNVl0UDRCR3E4REZ0?=
 =?utf-8?B?UTRTRjN3bCtxVFc3YUs0ZGRKQlVPTXVITm0zeW8waGEvdmVjbGtwdjJyTUxF?=
 =?utf-8?B?NFhtcGR4MTZBVU1PL09rU0svV3grbWVTeGdPeDIzSFBCR1d5akNwaUJBdUll?=
 =?utf-8?B?bzYwaGNTUURGaU5heUcwa2o2NXNkM0hvSFFzUjJGOE10SFhTdUJYZ3FsZFkv?=
 =?utf-8?B?aVZJemxJUkhjd0s2cU1ZR1JHOGVkeE1CRkR6VDlnb1BJZENESkpFbFRCREFC?=
 =?utf-8?B?M1l0M2h3T2NSTjlDdlU2Ung2NWFwdmhhUTk0YkRmK056S2hsNkZOc0daWTVP?=
 =?utf-8?B?TmVuNi9pUVFrMHFwVzlYY3o0Qm1vL243V2VoYllOSVdFemtzZmJxNDJsbVNW?=
 =?utf-8?B?T3l5ZWF5bFUzSlRGcmFvZXBpdG4wR3J1WFMwZFdBQVBYenRKK1l2SDRBdDJR?=
 =?utf-8?B?VzBpTXlNVG54aUdCSlF6bGJZZ1ZsSjZ6Tk9GQjdYMXpONnJpVDd1cytyMnhq?=
 =?utf-8?B?RmROWlhibytRdXVZSllEb292cnE2VHNrNDRTNDBoRXNnNmpLTHM4RnI5em90?=
 =?utf-8?B?TUlyY09PR3RLK2pvY1Jhajdtb2ZRR2grVjhxR1huNWNMbWdZc1d0a1AySElJ?=
 =?utf-8?B?OEhDOThicmhad3RTaGVvS3IvWklPMUZwQU00UXI0aG54SmwyUkRWdU1oM0tE?=
 =?utf-8?B?eldKcnNwTXB1Y1FsYjN1T2ZqbVk3ZGVabnpFNnRSRElHbkJtd1pEZFJHWG0z?=
 =?utf-8?B?NzRuR1hSZWpMeHdMdFhBajkvZ0cvcE5CWkkyNUVsdmszYUg1Qk9SajJjazhQ?=
 =?utf-8?B?eklpSkx6VGsyUzNhMEZjMzdqd2g5T0xIemJuNnpkRDV6MHFkVzMzcEpqRnM0?=
 =?utf-8?B?NDJIQkJYaXBhck9pczlWZkFmK2h3SDlNd2xXT0JidlY0Tk9uS3RlM3pVQzk3?=
 =?utf-8?B?RitpRnlSMStyVldHNUtGa21RRzRFd2xSL2tjc3M5SGR6RlRJWFhWdnhKUG9n?=
 =?utf-8?B?Q3VPQ1ZsVkZZWTU2L09TRmY2NG5VczdqRHdScENNdE5tL0VlUk96dTUyYXpk?=
 =?utf-8?B?ZWdnVXhnWWkrZDdBcncybGJacTdRUmZIcG1HdEZ4UjcwOFVBRE4rRU9JRGZq?=
 =?utf-8?B?cnpwYndCWVVWcjM1Mk1DMG0vZ0VlUXlVa3o4V2tOQW9ZNEZXanN1akhMNk91?=
 =?utf-8?B?OUhvRTlNUkFzY2ZIc1pkcWJQTHdHbVhhSGsyMHJhamg4d1UyOXRMZUxqN2hv?=
 =?utf-8?B?amh2Rm8vdm9sMyszeUZKelNKemJOZnJUS09IdnZQNUh0ZngranQ1cG4wMko0?=
 =?utf-8?B?dFRXNnN1Q2VtNkFyUTE1YXE2QmFUK1M4S0owOExMaFpTamovYWI4MGFXbzZm?=
 =?utf-8?B?YnFpOHVxY3dQeDFnZU8rbWdhU0NucGI1S1hrcjI5WFBjR0RMclN1dDRQaTRD?=
 =?utf-8?B?Z2IrK0F4a2VCakd1QTMwUElEQXQ3Yk5pNzRYRWpwMVdUT2hUdnhsZy9LMWhN?=
 =?utf-8?B?Uk9oSzQ0VVRJS0s1dFVpTU5aNUhQU2lNK1pWSVZTSG9FZm9SclBuRkc0Wkps?=
 =?utf-8?B?dy95NUZXU3NBdllKR3EwdkdYUHdUa3g3N0YxZlE0aWFZd1dhSytKdW1ySDVa?=
 =?utf-8?B?cUhrODVybTV5Q3pEYUlSaU53RlVNMkI5QWdxOEdEdHFBSmxuZDI1UjFHbVla?=
 =?utf-8?B?cGZXRFNIUVdZcG0wWmdFcndwNlpYcThyR2NrVldGZFFkUFpPUzBrblZ3Mlo5?=
 =?utf-8?B?YXo5dFJid2tHVzR2OFJIRkR0cGZvL3Q2NXNRZEhiWHE1SmNOSlVWOU1penpu?=
 =?utf-8?B?ZEw0bWh6Q1hhenoxL3pHamJnVCtwRUM0czl0ZXM3UlRMYUEyajFxcTkzS2gr?=
 =?utf-8?B?UW1vZzRwMnJwMS9UdkgxeHdnTXBDbE5sWFk4TEU0WDRqdStrbld1MFNveWNu?=
 =?utf-8?Q?UQxG0wdEA52GTIncqT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9867d9d5-59d4-4444-5b72-08de799b2336
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:07:15.4162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZNHnG1Qxmo7ZaXi+bDOGCkEx2mi4TRizA+wVubf1/gjkeD7Fmv6cH5cc72Bu4BM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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



On 29-Jan-26 1:23 AM, Alex Deucher wrote:
> Plumb in support for disabling kernel queues and make it
> the default.  For testing, kernel queues can be re-enabled
> by setting amdgpu.user_queue=0
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 109 +++++++++++++++++++------
>   1 file changed, 82 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 08ae50a6313f3..f93ee275ce398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>   		break;
>   	}
>   
> -	/* recalculate compute rings to use based on hardware configuration */
> -	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
> -			     adev->gfx.mec.num_queue_per_pipe) / 2;
> -	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
> -					  num_compute_rings);
> +	if (adev->gfx.num_compute_rings) {
> +		/* recalculate compute rings to use based on hardware configuration */
> +		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
> +				     adev->gfx.mec.num_queue_per_pipe) / 2;
> +		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
> +						  num_compute_rings);
> +	}
>   
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>   
> @@ -2794,6 +2796,36 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_device *adev,
>   	gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
>   }
>   
> +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev,
> +					      bool enable)
> +{
> +	unsigned int irq_type;
> +	int m, p, r, x, num_xcc;
> +
> +	if (adev->gfx.disable_kq) {
> +		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +		for (x = 0; x < num_xcc; x++) {
> +			for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
> +				for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
> +					irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +						+ (m * adev->gfx.mec.num_pipe_per_mec)
> +						+ p;

if x is not involved in type calculation, I guess iteration over x is 
not required. Only the handler for the interrupt type needs to be 
enabled once.

> +					if (enable)
> +						r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +								   irq_type);
> +					else
> +						r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +								   irq_type);
> +					if (r)
> +						return r;
> +				}
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -2801,6 +2833,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +	gfx_v12_1_set_userq_eop_interrupts(adev, false);
>   
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>   	for (i = 0; i < num_xcc; i++) {
> @@ -2868,10 +2901,26 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +
> +	switch (amdgpu_user_queue) {
> +	case -1:
> +	default:
> +		adev->gfx.disable_kq = true;
> +		adev->gfx.disable_uq = true;
> +		break;
> +	case 0:
> +		adev->gfx.disable_kq = false;
> +		adev->gfx.disable_uq = true;
> +		break;
> +	}
> +
>   	adev->gfx.funcs = &gfx_v12_1_gfx_funcs;
>   
> -	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> -					  AMDGPU_MAX_COMPUTE_RINGS);
> +	if (adev->gfx.disable_kq)
> +		adev->gfx.num_compute_rings = 0;
> +	else
> +		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +						  AMDGPU_MAX_COMPUTE_RINGS);
>   
>   	gfx_v12_1_set_kiq_pm4_funcs(adev);
>   	gfx_v12_1_set_ring_funcs(adev);
> @@ -2898,6 +2947,10 @@ static int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = gfx_v12_1_set_userq_eop_interrupts(adev, true);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -3719,29 +3772,31 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
>   	if (xcc_id == -EINVAL)
>   		return;
>   
> -	switch (me_id) {
> -	case 0:
> -		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -			ring = &adev->gfx.gfx_ring[i];
> -			/* we only enabled 1 gfx queue per pipe for now */
> -			if (ring->me == me_id && ring->pipe == pipe_id)
> -				drm_sched_fault(&ring->sched);
> -		}
> -		break;
> -	case 1:
> -	case 2:
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -			ring = &adev->gfx.compute_ring
> +	if (!adev->gfx.disable_kq) {

If no handled here, is this unexpected or handled somewhere else?

> +		switch (me_id) {
> +		case 0:
> +			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +				ring = &adev->gfx.gfx_ring[i];
> +				/* we only enabled 1 gfx queue per pipe for now */
> +				if (ring->me == me_id && ring->pipe == pipe_id)
> +					drm_sched_fault(&ring->sched);
> +			}

Not related to this patch, but this code looks redundant.

Thanks,
Lijo

> +			break;
> +		case 1:
> +		case 2:
> +			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +				ring = &adev->gfx.compute_ring
>   					[i +
>   					 xcc_id * adev->gfx.num_compute_rings];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		default:
> +			BUG();
> +			break;
>   		}
> -		break;
> -	default:
> -		BUG();
> -		break;
>   	}
>   }
>   

