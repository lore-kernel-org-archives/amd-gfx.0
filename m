Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88144C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF31F10E4C7;
	Wed,  7 Jun 2023 12:07:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2859210E4C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbdQ8QvUfu4ebaLWJS9iDlbhrNW9orLC/fYUvjIkjj+8WMXSkTQvP7kuMNZlEFX7RcAQTAnlU2IgH8duFcazUZLtMlF+SBtMoR3BVlltuhp6wlpDeb4C8Q4XsT79X52ihLnNGxgqX45rWVxHsIevdo0tUcBSVThWx9sTztRwkzzrX0jJt91SyaghdFOMvyjy3mwnTs9jJhqblaAFJwWJhdxiyNLRpw40TR+UHhA1W0JRQh77f0QRkG7pQi9dXbgsLjVkU2WX4KwlYxNKnBVTMxlmrQhZuFK8y/ChMWOEb0DWvnUtN+6zKY6OSBwgFbLPdQ4RZIGzyfDDc0zslXfF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8dW856n5ZwYmh4mImnLqGVJEWpav5AoKkTHCnot00g=;
 b=DeC+3KzNYPUNQAvRmzqEg/zcq0DN4nUCb7x7nlbjxpRFXrmIox53UFOGQEZsvhSylc4I+0t+oxSfSHX+Uv8ByFarvw68QOnKH8xYEAV50JgQvg4F9xo+WyT5xzyaCc4AXbrrCTS9+zdyOzWeV4yDcrpkUhG90zSk2dfnUv4Z9Ys06KS0Me9h586g9NeOfKPgd2Z0OK0tqMNVU5UTPuVUk5Iv29kkEPPWtW2AOdHHW/EWdvG6LwlCuyYbHAnGlaYjTXNUIyzDjtMkj3tprJbDv3NpXOzLqshe955LmOnlpwOe0mz320WLbYwO9DWJKchsjhXbNKdDRM9ncfRtnus4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8dW856n5ZwYmh4mImnLqGVJEWpav5AoKkTHCnot00g=;
 b=ewlirERIkBAGFotUklpCuSGBiRHw7JUyLKQk4aivaX+grb+jXFVThDxfHobhAcK4CLYdWUVDSdqp7cvaO/odtju97rWUmf12Lw61PeO0zjI1q8bC/gYxQ0XqQ5hAyvhZkNaeO5dSr984ZZnKW/5bjwgNblyYVFuFUHlBpYuKDnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:07:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::61c8:1d79:40e9:17d8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::61c8:1d79:40e9:17d8%6]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 12:07:45 +0000
Message-ID: <90324aae-a514-d251-55a9-d6a256c57cdf@amd.com>
Date: Wed, 7 Jun 2023 14:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/07] drm/amdgpu: add option params to enforce process
 isolation between graphics and compute
Content-Language: en-US
To: Chong Li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230607105752.3905380-1-chongli2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230607105752.3905380-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 37aa8361-fbc8-4db2-a06e-08db674fcdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaagXM0u+CvpMFUOt0sroh5M7dG70+5mqsbYKyP6yms2Gk4D01CEyuAL8yqi0Z2tKbAtj0Kw8P/6Sh0wyW7hIECGPrlekTa3B6ZSa73L+t17mxlvqpFJ91Q7BSj+vw+thCwJifWK2ZQmvhE8QaebJ1/6uEK7atvdQArsYi2/QvX5V4qAsmtEjy067OemnDzsAySqOoXpFhN53DsSLNdBEsRAFIxxuJrCiODJEBR2LOEhfqhL9cq/2VKqd2/F9pMP7oXl+h/92gEAdjMfTA7ebPxaL1fWgKVW8bt8LPNIgM/ALkWzfc+ixvdp4xtAT0f4VLS+FoVJ9AmS4UMxW55DVBgeT7BkZb+0bl7wcrc3c7vJIB0VLd6SMemdoslaDhh2DLGQHOMiCQ6QWp0+BEzoJsa8D2sJBTPKnv5DPRXpfw1NUjg5EmynGhRAR5hwcTw9eNzUfIx3aR1/jerUGjhUaECpGiOfg6DIusTXdgPw7n2lr7+hlZmcAvDqsOkQT2IS7/jOJfXU98b8RRa+830rDsuaqhoG9BOXOZzojlYBuYLCLKIUPSJIwiJNnB4SKCkSp/2TPFkmvqOFCrbhXEHMUM5J411m4Lmp7ydzgak3wFclqROZN0P/oNm6M7ZYF49y+nUtrjTnU72aolQ5sORvaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(6486002)(6666004)(2906002)(66946007)(66556008)(66476007)(36756003)(38100700002)(5660300002)(8936002)(86362001)(8676002)(31696002)(41300700001)(4326008)(316002)(478600001)(2616005)(6512007)(6506007)(31686004)(186003)(83380400001)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJIRHRYZUhNM3dFRG96N2d1NEFjSUVmaDV4UGcycGpTS1phS0xLckNZSHBW?=
 =?utf-8?B?ODNySlJMa1VKYkhMSDRaT0l0NkZXQkNjOHR5VTFGLzRwSWVGV1E0cUlzbnF5?=
 =?utf-8?B?bGVTV2IwcVQra0dVcHQ5SFhEOU1ObHpVVGxPZkRxZW44ZS9FRGN5ZXJCS1RY?=
 =?utf-8?B?SUpRR0Rpa0ZsdTJrNEVKWUxUQ1RqMGRZa3VjZUNLTUZPcFJJV09KTzBUZU85?=
 =?utf-8?B?S3JuT0RGS3lzUlZmSjdVOFlFVng4Y090aEx3VTJWTk9SQk9QVzZSUXFUUmRa?=
 =?utf-8?B?M1VYZTE5QmtKc1lXVXIzTSt2aGwxQ2pVNTNpVGtFblA3OHV3eEdydFp6bFhl?=
 =?utf-8?B?TlBVOVFOcnl1OHdYMllhVFBEdko4UFVkZ2x0Zjl6WU9qSUQ1bUZmVHNoZkdL?=
 =?utf-8?B?bEdzNVh2SVhVUTl4bng1WUhsZ3M0enNYSEd0ZWZEK284T3ZtWURNSVh4UlBp?=
 =?utf-8?B?Mjh0NUszcTFaeGdGbGtXNkJUS3NQR2toVVV0ZGpndk9hOFV1S28vZWRCUXNP?=
 =?utf-8?B?V2dXeUh1R0ZHU1F4M0U3U25NVUZUeE9MaCtITjRzNUVJdklGMTNjVWo2dGZr?=
 =?utf-8?B?TEJORmlpZW95dHk5TkFyUFBWanNyQUR4dE1rd2IwaW1mbFIyc0k0bzlYZkxL?=
 =?utf-8?B?K0M3Y2J2M2RMM3plTjREZTJMUm1uUE5pL1llZHFNa2Jwb0xhN3pFQ2xENjds?=
 =?utf-8?B?YXVldFgyT2tYMWl3TG85aGhhUkM4cExZWXA2ZWJZaFE0aFFMM1NKaTFYY0JY?=
 =?utf-8?B?V1Z4YzRwQ2NpOUx2aTRuNDBnRml5S3lReC9ieThQS1dtL29FNW44WnEySE5I?=
 =?utf-8?B?Sm5LeWVWZ0tPdW10QWJvOEljWEFzaDNOTmk0b2JQOFpSMDdDTTd5M1IzTmJ3?=
 =?utf-8?B?clJjYnd2YlZNdmZWc0hSZUpzWVdXVlB5bDBMNVJ5WlVDRkJRSnkvSGlJbXlx?=
 =?utf-8?B?NjZBMGFETU5FTlVmclFkY0NwOC9RWTNQSlJPa3ZTVHpZUkZ3eFlwUzNEaWEx?=
 =?utf-8?B?bGhrYnlIc2xyMjJTZ0g3dWpLUWZaL01SZTVQeVZocDk3S0VuVUxTbHRjSWFa?=
 =?utf-8?B?ak1GLzFHcFQxTjAzdHgzakZDdzFaZTA3WlYwWWJRSHRUZlJXNjl4RDN3anpQ?=
 =?utf-8?B?L3R2ZXFPRlFnZ3BEZ0t3N0gwck5ZbWZZYXV2eGgzWS9JdWdOcXZrRkc4Z1VF?=
 =?utf-8?B?ZGpkTnRSYVYzclY3aGFUTjlLU3o0QjV6Y2RjcWZjQVUvcTJjWitZaHZBSXV1?=
 =?utf-8?B?VElSSlNTZUF1K2k1d3pMU3BUODY0MHpvR2FkYnpUWitueFUvZ2VCd240TG92?=
 =?utf-8?B?WkJKbTdMSWxjRmRXcDlvd2dMak96b1IvMFluUzErN0dPd0VUZGJ2VWpWODlG?=
 =?utf-8?B?WE1wTGpYcFZ1dFJoeXlvRm5SSkVFcGhGK00vRnhqUjRrYUlrZVhORmI2TW1k?=
 =?utf-8?B?ZDRlRllHTmJSOEV3SjQzZTNrdWV4SStyVlZPcVhqWVJwSStaRzZMeExka3dj?=
 =?utf-8?B?ZXhianNJY1dETVFvYWt1NzB1WDhDaWUxb0NwKzZYVDgzVlIvTjk4d2tuZWZz?=
 =?utf-8?B?bG1jZG82QkYyOFh1RVltMFlXdEp0ejROL0lHV3p5NVVtTlU4emI4L0c1L0sw?=
 =?utf-8?B?WDF0Wmwxa05TVFNQL1ZXaE5wbXdNbE91TGxjSlNiZHF0a3BlaEdZMlJtNlUw?=
 =?utf-8?B?UzlMaC9zK3VxdERpRzVXbW12U0dZRkJ3MSttd2hKN1pZb2Z5Vm9oc1hWb2pR?=
 =?utf-8?B?Z3BNY0s2cXhESGxyWkpScnYvdUZOaE9aZDI5MDU5N1lQNm1NMEZGYzMvQko3?=
 =?utf-8?B?TWQwL1RhYkFhWThPMGwwVHhHM0F1c3lrcWs2cWEwUk9Ud3h2N2dpczhyWnVj?=
 =?utf-8?B?YVJvNmlsUG1mdkFFQ0lmQlZtUU8xaHVwSDlnYVFOcmYveUtucGhlMkFseGxm?=
 =?utf-8?B?cWhpckVKenl3QTNJZEloM1FsMG81TkRJK05DWFJjZGk2bEVPK0o0cDV5Nndt?=
 =?utf-8?B?R3RDQVFlVmk3NklxdjVWOUc3dCtISTJ5WU0wTm41SHhBdnNCKzQ2cjNBbGsw?=
 =?utf-8?B?c2RVVUFQVWNueFlLTWtvK2wyUFVRaTNwelNQZzNTcXp5a01GaDJxNC80OXpR?=
 =?utf-8?B?WmlDOGpIRGpVV3JBdHZtS0pObGgyaERCbkxxQ3orOXBOMTFQMGZVOWlvblVS?=
 =?utf-8?Q?xtWf3aRoezhjMOENPxcrE8gVUf/sBHSF5yriN61/SfqV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa8361-fbc8-4db2-a06e-08db674fcdc8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:07:45.8267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gDQCVh3VC5eDg6jEylOgN3s2o0hlsJ6srCt0eWLQvhZaJu6rdtwKL/7mL8pOjFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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
Cc: zhengyin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.06.23 um 12:57 schrieb Chong Li:
> enforce process isolation between graphics and compute via using the same reserved vmid.
>
> v2: remove params "struct amdgpu_vm *vm" from
>      amdgpu_vmid_alloc_reserved and amdgpu_vmid_free_reserved.
>
> Signed-off-by: Chong Li <chongli2@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 17 +++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 22 +++++++++++++++++-----
>   5 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ce196badf42d..ef098a7287d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -215,6 +215,7 @@ extern int amdgpu_force_asic_type;
>   extern int amdgpu_smartshift_bias;
>   extern int amdgpu_use_xgmi_p2p;
>   extern int amdgpu_mtype_local;
> +extern bool enforce_isolation;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3d91e123f9bd..fdb6fb8229ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -153,7 +153,7 @@ uint amdgpu_pg_mask = 0xffffffff;
>   uint amdgpu_sdma_phase_quantum = 32;
>   char *amdgpu_disable_cu;
>   char *amdgpu_virtual_display;
> -
> +bool enforce_isolation;
>   /*
>    * OverDrive(bit 14) disabled by default
>    * GFX DCS(bit 19) disabled by default
> @@ -973,6 +973,14 @@ MODULE_PARM_DESC(
>   						4 = AMDGPU_CPX_PARTITION_MODE)");
>   module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
>   
> +
> +/**
> + * DOC: enforce_isolation (bool)
> + * enforce process isolation between graphics and compute via using the same reserved vmid.
> + */
> +module_param(enforce_isolation, bool, 0444);
> +MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index c991ca0b7a1c..ff1ea99292fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -409,7 +409,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   	if (r || !idle)
>   		goto error;
>   
> -	if (vm->reserved_vmid[vmhub]) {
> +	if (vm->reserved_vmid[vmhub] || (enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)))) {
>   		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
>   		if (r || !id)
>   			goto error;
> @@ -460,14 +460,11 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   }
>   
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
>   			       unsigned vmhub)
>   {
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   
>   	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[vmhub])
> -		goto unlock;
>   
>   	++id_mgr->reserved_use_count;
>   	if (!id_mgr->reserved) {
> @@ -479,27 +476,23 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
>   		list_del_init(&id->list);
>   		id_mgr->reserved = id;
>   	}
> -	vm->reserved_vmid[vmhub] = true;
>   
> -unlock:
>   	mutex_unlock(&id_mgr->lock);
>   	return 0;
>   }
>   
>   void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
>   			       unsigned vmhub)
>   {
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   
>   	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[vmhub] &&
> -	    !--id_mgr->reserved_use_count) {
> +	if (!--id_mgr->reserved_use_count) {
>   		/* give the reserved ID back to normal round robin */
>   		list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
>   		id_mgr->reserved = NULL;
>   	}
> -	vm->reserved_vmid[vmhub] = false;
> +
>   	mutex_unlock(&id_mgr->lock);
>   }
>   
> @@ -578,6 +571,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>   		}
>   	}
> +	/* alloc a default reserved vmid to enforce isolation */
> +	if (enforce_isolation)
> +		amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
> +
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index d1cc09b45da4..68add23dc87c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -79,11 +79,9 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>   bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>   			       struct amdgpu_vmid *id);
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
> -			       unsigned vmhub);
> +					unsigned vmhub);
>   void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
> -			       unsigned vmhub);
> +					unsigned vmhub);
>   int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   		     struct amdgpu_job *job, struct dma_fence **fence);
>   void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea3d0be152fc..73900ab545c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2358,8 +2358,14 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	dma_fence_put(vm->last_update);
> -	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
> -		amdgpu_vmid_free_reserved(adev, vm, i);
> +
> +	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +		if (vm->reserved_vmid[i]) {
> +			amdgpu_vmid_free_reserved(adev, i);
> +			vm->reserved_vmid[i] = false;
> +		}
> +	}
> +
>   }
>   
>   /**
> @@ -2447,13 +2453,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	switch (args->in.op) {
>   	case AMDGPU_VM_OP_RESERVE_VMID:
>   		/* We only have requirement to reserve vmid from gfxhub */
> -		r = amdgpu_vmid_alloc_reserved(adev, &fpriv->vm,
> -					       AMDGPU_GFXHUB(0));
> +		if (!fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
> +			r = amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
> +			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = true;
> +		}
> +
>   		if (r)
>   			return r;
>   		break;
>   	case AMDGPU_VM_OP_UNRESERVE_VMID:
> -		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB(0));
> +		if (fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
> +			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(0));
> +			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = false;
> +		}
>   		break;
>   	default:
>   		return -EINVAL;

