Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0CACA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA2710FF98;
	Fri,  9 Oct 2026 08:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XQOyh85X";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0739710FF98
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 08:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOYI3FcKuyuloaTd4ykM9HaiL0U2l2DOexoGbltnI10SAspvQV7ITODByQgSqvoaqaehHpDZ66K1GjOdSI8gko4Ho8nYWWpbSEZx3iMaT8gotkpBjLl0VQNaujO6N2R4P4MZ7P5I902GE1RVyVbOVxZh6O9EOJrldr8HH41BV6O0DCFwbJuEkLjKjds9ZsiYyVD4xU9JiHfOaZu66Hdc5GKVQm9kRGePcgVF3T0eL9Ke/wNPB16Su3or0R9tPBH/CUdrrdCvYLlYG43l1r9RoNCkFGnld7O7JGbkUVOmNGJUGCTCEwiVzPit8Tp7A5xXNEL83dTVyQ8GQKmPL0fl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IJPFbE8nCXohnqHn/bWv9200W1DrgUQ7N4rT0R9IT0=;
 b=TGlFwybWGXQPryF3oj/zIKyUXwMpMqsqHDpx4D1sqbL4xnB7JcXCJJEv/lEDDmf6IFz872nF+TuUmtM5nnHcRFbSZtegme+y7ppFfB0KAZweLV/CQNaunYRYFjWY8VYtx7ujSYo0ap/5/2h5rGHNgq8WEZAgjHInfKCowwceyePX17CXo7mZEoEEldDnnkpa2G1R5EBYViPxviiRVR2CT6bDL55wVuxn1XUSs+y7ZHEIKatUztV75QTggzUE8zz1KK2fXVyoO3L8Zo/bteL265Iy+v5Qrzq/4NxyoJ/CoYvoIwfXnRfiZmFpH/Sb4eRrneukWE4yEzeyXxCUgRl2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IJPFbE8nCXohnqHn/bWv9200W1DrgUQ7N4rT0R9IT0=;
 b=XQOyh85X4yx5f0Sz0gOf1+JKku4AHziD1Ug9eubnRagRHZ9i6g27gWifQm2QMMkRueG5WGFKDxyjugs8EuTOgKgm8XLYsms/g1ToyVvuPC8cAS4jiPVfWynOGPeHLdZZ3vuhDMZeux1xOZ+IEy39xeDI7zC/NpsORGFvShuMSy4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999284.namprd12.prod.outlook.com (2603:10b6:8:41d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 08:44:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 08:44:50 +0000
Message-ID: <dfc79fa7-a3bc-43a2-b060-e06410491768@amd.com>
Date: Fri, 9 Oct 2026 10:44:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: store the user-queue VMID mask instead
 of first_kfd_vmid
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261009081732.3505820-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009081732.3505820-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999284:EE_
X-MS-Office365-Filtering-Correlation-Id: 328e2f5f-0489-4d4c-2519-08df25e194b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZdKNjInyVYxxxzVTqo1LesRnMA9XsEe24ujt6ps8SgZ+S9g6PtY3W36dF+AtDq15BhvpD9ZgPsICOAoWOrp/25vSbcO5vzqEpb0TSR44hgUJmLrLYEutge9Lp8W9X8ZQKgnLnFne+zIkAzGCKlE5urZ9K7GpjDgSGHiXaHDA8FWK+ve4rhAaYGfbL3q2wEeEOnE2LDq2tvtTv3GAjbdPGmnVVJ7+X76eA0mTnaYNBhnIC3nhjkYqWM912a8VBO6FfWB8dACYmtSny2FKnKJCUPqBfLGn6m6mDBWx9UIPIJxytsLw+a4gAXX/ICXr/5P/BdwFgJH+8u4ifvzjW2FMeXF1EIzGSW3r/gHlRJzupB0ucKOy5Dls5Ze7kgqV35tO6NWOx6TOvqg9hanmEfOMEUvC/e3dRoTdcZTWaMcfiMjo+BrOlU6KXFQuHpVRPRTPMpAzzx/eMVDOlRt9d6efdoBDLINqe9De1RHCe4DLVsiETj5JhcprX1WDAXT4pGCHRUm0LDK7slCgKyqBDYfhxnt3+coj+C0e0hLBPqwdzJicVid/AETQ7a/fnzf7Pin6SvAEdXUE/POu0SJAcQ5jMnkalQsiKrrvb3jofxBW5/ack0Ylyt/01M+kPivwSu3nIheCy53BLwaPw00zjBP0ISkcXb81hcyXAvdO6zaA3uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXQ5YUZBbWR0N3NBVkJEelBpczlsRXZFdC9yclM3MjlsNjBiU3BkblhLcEJ2?=
 =?utf-8?B?Slo3dXBSUk9XMnExK01IVUJSd3hsRDlFZTZQV1N6SXpJMzAyQkNacDN6SVVY?=
 =?utf-8?B?ejluNWh0QkpUbzBmNjR0MVNrSjlpOFNyZHdsYStMVHlhNFlENXVPTW5tNWEx?=
 =?utf-8?B?ZnNBMVFlTk5IYlJzaUZLcjFjb1JqcjJNb2FJUDhEVW9oR1Fua3dyYUtsVHlJ?=
 =?utf-8?B?N29IZE1CSFRBYXN4WTI1Q3VMRHdoZ2ZGbFRCbHhaN3VDNVBGOXBpckR6V0hz?=
 =?utf-8?B?RWhTMkljRURVT3lQSzdacjBTL2NQVmh3dDg4R2dFNHFxbUYzYzB4YWZVMGY1?=
 =?utf-8?B?Ulh4S1lVV3BhL3drTjlwOXNyWTZKeW1CMHdIdmUwV1pmT0VDZE1McncxQURu?=
 =?utf-8?B?UVBJMDBoMTdFQVpNRlZyRTZKUGtuY1BYTFZYaGJKWXRJNFBobDRJSGxFa25E?=
 =?utf-8?B?cmN0Tmo0REdVYVo5SW9wNEdPUkdRMXc2eEs0YmZIR2t5WGo4dUlBK2FWbU41?=
 =?utf-8?B?T2dUTkdhM0xNZFI3bU0wOWVMaHNRWFlzSDE2ekNkR2l3N1hyOFBmMnRhdjRO?=
 =?utf-8?B?eHc5aVkvSEpuR2hHYkJOTkhKNVIzcG5keStCL0xsTEFaOTlqUGdYNWNhQXBE?=
 =?utf-8?B?NGNjNE9KRTJPUk4zd1hJanUxaUo0TXh2YkY5Um1ZWSs3WklOa1BZUnhtd2dW?=
 =?utf-8?B?Q0RudDZ2ZTE0ekRMNGNWcDJCQ1JwbGpLMlRObjBPa1RzNnlyU2VxU1JTbnNK?=
 =?utf-8?B?V0owSk5KWDljWE1FSU5kRWVGZlRnNm4xQmtVUkVaOG9sUEZwdTdSYktzS0lS?=
 =?utf-8?B?MStlYkt5RWhHVlk1QVFVU0tYaDZqZ1IxVFFyRFZYeHdUaE00d0JIMGhsa0tj?=
 =?utf-8?B?WWtaQUJJa09yQzdGL3NvSklzSUtwa3A2S2xweGRuV0FGM3RSZFdTaDdyK1J0?=
 =?utf-8?B?dDB5MFFaeW40TkNCTW9VTTZSdno2a3ovWUs4dFp3bzVSK0tQNUh6Z3BZUVVa?=
 =?utf-8?B?T1F2U0Eza1FpYjJtSDQzWTJaUUltbnRXU1ZreWVlTi9DdTJSQWVWdEFGR3cz?=
 =?utf-8?B?NWVkUTh2eHpDTWd4NHJNbGd2SHhWdU9aSm1SUklKbHNZUWczRENVVzRob1Bl?=
 =?utf-8?B?TVpydkwyS3NETXdUejZGT0lac0ZXMWdFMUk5Q2tQcWlyZEt1QXhRclpSclF4?=
 =?utf-8?B?VWVRcmZwZWtQTmxyOXMvalRZWWlwemdjWHBWT0RlK0ZuMDB0L241MmVGRjBW?=
 =?utf-8?B?SFVJY0VaWWp5aDZZRG1PNUZHR0lqbThueW95M01OVkQ3dXoyMlJiaDMwYzY2?=
 =?utf-8?B?L2ZtOXpjUGhmUnNCdUozV0xoYmVHMjNXUnVXQTJKaHhnQytNWFlIK2t2Z0pl?=
 =?utf-8?B?Umk0ekdqQTl5cGg5RzVobUVnYm1CNGZEbFlzZkV6cW5CSGhDQWhaM1R6TzRS?=
 =?utf-8?B?WEtFdklySkh4RFN3Ri9SRTFEM2J2Z2M5ajQ1SGNCVS9jTWhtdG9tVG1IK1Nk?=
 =?utf-8?B?ZnZ3TEExdHVhRVhNVmlsV2hSRTFwNUE3N1NzVFBTUEF2Zm9ueHoreXJKLy9a?=
 =?utf-8?B?dnJKU054N0RMNE9pcFVpOW5wd25kMTJicnFnSWZkYmt4V0s1T3lrUG1VMVZm?=
 =?utf-8?B?ZFMvK0hRMjFnREQrbTVmZ2JmVnRVVFl0MEluNHRRdHRBSzVIb2JINEo4Z1d1?=
 =?utf-8?B?R3JMN3k1Nml4bHZKMC82K1R0M0lIL240MlN0NW5UaTNiZ2ltbnR4bXBBYVNn?=
 =?utf-8?B?M0s5Q2pJVU5XQzV4Z0J2MGZoakRDa1pCSUJkYUwyOVJuV1prcFJ3OGRQQnRp?=
 =?utf-8?B?Q3lhcFEwTGkrazJYNkJZd1lwSGRsWlNHdndWMDJkM0pZRk9SZitGYW1MYzhp?=
 =?utf-8?B?TU1HdkZleGFHT0N1TTFPV24wUEtCVEFTYVN0OGJVMkJUZ1hnZlFPZU1WLzJ1?=
 =?utf-8?B?ZUJ5N3J6blhzL3JTRzh6NkZ5c0N5aVpBWS9Cd0dCOUNKVzhDVVhpVlh1Z1Nk?=
 =?utf-8?B?UlZXVU9Zd2xCMStRWnQycGFYYlRqV09qQnpWN0tTenRnck9YdDRuV2hqMW0x?=
 =?utf-8?B?TEk4T2hMdThQWlFVWVlGeGtXV0hHK0pKSzlOY0tGSjMwczcxalRXK1FmS1pG?=
 =?utf-8?B?VFBiQUlWTTVDV0pwd1RCM0x3YXNDTXZTZHhZR0t0YW0rTDlldGdzV1VGZnUw?=
 =?utf-8?B?Nmk0aGZZZGIrR05OV2F0dG5mZGNwdzBDejY1UkJacnNqQ1FsTzEyOWpRU2lY?=
 =?utf-8?B?c21rUjROOVI2c2hWTy90RzRJYnNOTkdRdmNvMHlaVHNFd2NTR1MweWhlOGlz?=
 =?utf-8?Q?kd/GuRIBRuPinHNg15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328e2f5f-0489-4d4c-2519-08df25e194b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 08:44:50.6642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTNKx0f0UZL5c2tcCdKZN2xY9WUYo3R7NX+abiy1C5qKxCNYlod4G3AGnF6jMl4m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999284
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

On 10/9/26 10:17, Sunil Khatri wrote:
> first_kfd_vmid only ever existed to be turned back into a mask
> (directly, or via range loops over VMIDs). Drop it and have each
> generation set vmid_uq_mask_gfxhub directly instead, add
> for_each_uq_vmid() to replace the range loops, and mask-test it in
> amdgpu_amdkfd_is_kfd_vmid().
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 41 +++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    | 16 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 20 ++++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h    |  3 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 10 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 11 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 20 +++++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 14 ++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 14 ++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 14 ++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++-----
>  21 files changed, 119 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3391e8c77f13b..e023cc734ebc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>  {
>  	if (adev->kfd.dev)
> -		return vmid >= adev->vm_manager.first_kfd_vmid;
> +		return !!(adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid));
>  
>  	return false;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9cdd8870960a6..55d6b2107d8f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -630,6 +630,21 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>  	}
>  }
>  
> +/**
> + * amdgpu_vmid_mgr_set_vmid_mask - set the kernel-queue VMID pool for a
> + * hub, and the matching user-queue mask on MMHUB
> + *
> + * @adev: amdgpu device structure
> + * @vmid_mask: kernel-queue round-robin VMID mask for this hub
> + * @for_mmhub: true to target MMHUB instances, false for GFXHUB
> + *
> + * On MMHUB, also sets vmid_uq_mask_mmhub to the fixed pool of VMIDs
> + * MES/KFD use there, excluding npa_vmid (a VMID dedicated to a single
> + * fixed purpose) from both the kernel- and user-queue masks; the
> + * caller must already have set npa_vmid. vmid_uq_mask_gfxhub is set
> + * directly by each generation's sw_init(), since unlike MMHUB's it
> + * varies per generation.
> + */
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  				   unsigned long vmid_mask, bool for_mmhub)
>  {
> @@ -637,6 +652,9 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  
>  	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
>  
> +	if (for_mmhub && adev->vm_manager.npa_vmid)
> +		vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
> +
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>  		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
>  
> @@ -644,22 +662,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
>  				    &vmid_mask, AMDGPU_NUM_VMID);
>  	}
> -}
>  
> -/**
> - * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
> - * first_kfd_vmid, shared by KFD and MES user queues.
> - */
> -static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
> -{
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		((1U << AMDGPU_NUM_VMID) - 1) &
> -		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
> -	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +	if (for_mmhub) {
> +		adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +		if (adev->vm_manager.npa_vmid)
> +			adev->vm_manager.vmid_uq_mask_mmhub &=
> +				~BIT(adev->vm_manager.npa_vmid);
> +	}
>  }
>  
>  /**
> @@ -673,8 +682,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>  {
>  	unsigned i, j;
>  
> -	amdgpu_vmid_uq_mask_init(adev);
> -
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
>  		struct amdgpu_kq_vmid_mgr *id_mgr =
>  			&adev->vm_manager.id_mgr[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 21d6a41d1738a..9bfc7a950ca31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -56,6 +56,22 @@
>  	     __vmid_mask; __vmid_mask = 0)				\
>  		for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
>  
> +/**
> + * for_each_uq_vmid - iterate over every VMID set in vmid_uq_mask_gfxhub
> + * @vmid:	loop cursor (int / unsigned int)
> + * @adev:	struct amdgpu_device *
> + *
> + * Equivalent to walking adev->vm_manager.vmid_uq_mask_gfxhub with
> + * for_each_set_bit().
> + *
> + * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long.
> + */
> +#define for_each_uq_vmid(vmid, adev)					\

Maybe name that for_each_uq_gfx_vmid().

> +	for (unsigned long __uq_vmid_mask =				\
> +		(adev)->vm_manager.vmid_uq_mask_gfxhub;		\
> +	     __uq_vmid_mask; __uq_vmid_mask = 0)			\
> +		for_each_set_bit((vmid), &__uq_vmid_mask, AMDGPU_NUM_VMID)
> +
>  struct amdgpu_device;
>  struct amdgpu_fpriv;
>  struct amdgpu_vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8e478d3bda1ac..d99e42ca308ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -383,7 +383,6 @@ struct amdgpu_vm {
>  struct amdgpu_vm_manager {
>  	/* Handling of VMIDs */
>  	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
> -	unsigned int				first_kfd_vmid;
>  	bool					concurrent_flush;
>  
>  	uint64_t				max_pfn;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 33403e16df5ca..cf7d0dd3c12d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5178,19 +5178,12 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
>  #define DEFAULT_SH_MEM_BASES	(0x6000)
>  
>  static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
> -				uint32_t first_vmid,
> -				uint32_t last_vmid)
> +				uint32_t vmid_mask)
>  {
>  	uint32_t data;
> -	uint32_t trap_config_vmid_mask = 0;
> -	int i;
> -
> -	/* Calculate trap config vmid mask */
> -	for (i = first_vmid; i < last_vmid; i++)
> -		trap_config_vmid_mask |= (1 << i);
>  
>  	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> -			VMID_SEL, trap_config_vmid_mask);
> +			VMID_SEL, vmid_mask);
>  	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
>  			TRAP_EN, 1);
>  	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
> @@ -5214,7 +5207,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>  	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		nv_grbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
> @@ -5227,15 +5220,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>  	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	 * access. These should be enabled by FW for target VMIDs.
>  	 */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>  	}
>  
> -	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
> -					AMDGPU_NUM_VMID);
> +	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.vmid_uq_mask_gfxhub);
>  }
>  
>  static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index d5f428ac19bf3..42bc2ab1b9032 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SCRATCH_APP_BASE;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		soc21_grbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
> @@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>  	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	 * access. These should be enabled by FW for target VMIDs.
>  	 */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 420ce997bebc7..435bceba7a834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SCRATCH_APP_BASE;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		soc24_grbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 4498e253846f1..d4fa4c7c16acf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 549d1239e326b..61983c7141e11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		cik_srbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
> @@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>  
>  	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	   access. These should be enabled by FW for target VMIDs. */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index ab4123ddbb942..16e634e0d2c1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		vi_srbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
> @@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>  
>  	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	   access. These should be enabled by FW for target VMIDs. */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1678015ce5a97..6c44bfc93d1a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2568,19 +2568,12 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
> -				uint32_t first_vmid,
> -				uint32_t last_vmid)
> +				uint32_t vmid_mask)
>  {
>  	uint32_t data;
> -	uint32_t trap_config_vmid_mask = 0;
> -	int i;
> -
> -	/* Calculate trap config vmid mask */
> -	for (i = first_vmid; i < last_vmid; i++)
> -		trap_config_vmid_mask |= (1 << i);
>  
>  	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> -			VMID_SEL, trap_config_vmid_mask);
> +			VMID_SEL, vmid_mask);
>  	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
>  			TRAP_EN, 1);
>  	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
> @@ -2610,7 +2603,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>  		/* CP and shaders */
>  		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
> @@ -2621,7 +2614,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>  
>  	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	   access. These should be enabled by FW for target VMIDs. */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
> @@ -4932,11 +4925,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
> -		gfx_v9_4_2_debug_trap_config_init(adev,
> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
> +		gfx_v9_4_2_debug_trap_config_init(adev);
>  	else
>  		gfx_v9_0_debug_trap_config_init(adev,
> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
> +			adev->vm_manager.vmid_uq_mask_gfxhub);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 54bcb5fdca242..e84426b6a1a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -836,16 +836,14 @@ void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
>  	}
>  }
>  
> -void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
> -				uint32_t first_vmid,
> -				uint32_t last_vmid)
> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev)
>  {
>  	uint32_t data;
>  	int i;
>  
>  	mutex_lock(&adev->srbm_mutex);
>  
> -	for (i = first_vmid; i < last_vmid; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		data = 0;
>  		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>  		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> index c8757de669eaa..ca240f4298da6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -24,8 +24,7 @@
>  #ifndef __GFX_V9_4_2_H__
>  #define __GFX_V9_4_2_H__
>  
> -void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
> -				uint32_t first_vmid, uint32_t last_vmid);
> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev);
>  void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>  				      uint32_t die_id);
>  void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 01ed1701c781a..8555e64977348 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>  		/* CP and shaders */
>  		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
> @@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	 * access. These should be enabled by FW for target VMIDs.
>  	 */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for_each_uq_vmid(i, adev) {
>  		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 490b4c4eb662a..a95bfe22c640e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -746,6 +746,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
> +	unsigned long gfx_vmid_mask;
>  
>  	adev->gfxhub.funcs->init(adev);
>  
> @@ -869,10 +870,11 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      false);
> +	gfx_vmid_mask = GENMASK(7, 1);
> +
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>  
>  	amdgpu_vm_manager_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 3cdc7893587a1..7b19c59a2f743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -745,6 +745,8 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
> +	unsigned int first_userq_vmid;
> +	unsigned long gfx_vmid_mask;
>  
>  	adev->mmhub.funcs->init(adev);
>  
> @@ -854,11 +856,12 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
> +	first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
> +	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
>  
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      false);
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>  
>  	amdgpu_vm_manager_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index fcc1d580fa946..9194130c25f29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -849,6 +849,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	uint64_t pte_addr_mask = 0;
>  	u32 mmhub_vmid_mask;
> +	unsigned int first_userq_vmid;
> +	unsigned long gfx_vmid_mask;
>  	int i;
>  
>  	adev->mmhub.funcs->init(adev);
> @@ -997,26 +999,24 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 */
>  	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
> -		adev->vm_manager.first_kfd_vmid = 3;
> +		first_userq_vmid = 3;
>  		adev->vm_manager.npa_vmid = 15;
> -		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>  	} else {
> -		adev->vm_manager.first_kfd_vmid = 8;
> +		first_userq_vmid = 8;
>  	}
>  
>  	if (adev->gfx.disable_kq)
> -		adev->vm_manager.first_kfd_vmid = 1;
> +		first_userq_vmid = 1;
>  
> +	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> +
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      false);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>  
>  	amdgpu_vm_manager_init(adev);
>  
> -	if (adev->vm_manager.npa_vmid)
> -		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
> -
>  	r = amdgpu_gmc_ras_sw_init(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 71409eb718d39..4e593e67221ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -768,6 +768,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> +	unsigned long gfx_vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -824,13 +825,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      true);
> +	gfx_vmid_mask = GENMASK(7, 1);

BTW I don't think we have KFD support for GFX/GMC v6-v8 any more. Not for this patch but we can probably drop that at some point.

Apart from the nit pick above patch looks good to me.

Regards,
Christian.

> +
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index c95e097241bf8..bbb5c42b9d4ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -941,6 +941,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> +	unsigned long gfx_vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -1006,13 +1007,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      true);
> +	gfx_vmid_mask = GENMASK(7, 1);
> +
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 8d8a0775878ff..25d47d2c288dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1051,6 +1051,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> +	unsigned long gfx_vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -1121,13 +1122,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      true);
> +	gfx_vmid_mask = GENMASK(7, 1);
> +
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 85ba228f002d0..7ebf7b1299ff6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1849,6 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
>  	struct amdgpu_device *adev = ip_block->adev;
>  	unsigned long inst_mask = adev->aid_mask;
> +	unsigned int first_userq_vmid;
> +	unsigned long gfx_vmid_mask;
>  
>  	adev->gfxhub.funcs->init(adev);
>  
> @@ -2030,21 +2032,21 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	    adev->jpeg.disable_kq &&
>  	    adev->vcn.disable_kq &&
>  	    adev->sdma.no_user_submission)
> -		adev->vm_manager.first_kfd_vmid = 1;
> +		first_userq_vmid = 1;
>  	else
> -		adev->vm_manager.first_kfd_vmid =
> +		first_userq_vmid =
>  			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
>  			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
>  			 amdgpu_is_multi_aid(adev)) ?
>  			3 :
>  			8;
>  
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> -				      true);
> +	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> +
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>  	amdgpu_vm_manager_init(adev);
>  
>  	gmc_v9_0_save_registers(adev);

