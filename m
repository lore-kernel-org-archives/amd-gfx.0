Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D25CA9EC5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 15:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F1310F1DC;
	Mon, 12 Oct 2026 15:11:15 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5998110F1CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 15:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+HacjkK8JNJo2PG0hSlFjjhteob975wBFmbIUWKhR2FLL/DqNQwH4DUoLvmN+S+fKoniDtbHR25GTqqn3J0TPnZWNN7f3368Gb+/6pDSgnCphSeOJu0AbgHkxEvhTZ7h7UHtgXm/s77kdH2lhCyxpisjr/Vh/6psAJrP3Xmnmg1zXe0yiKnr7zzuoruBn2O/cKJtFCulKVdNHy26BtYw3R06wlgdFvr5tgf/4zUxL2lEI9e2X3gvLFfv4ZRU5OMgfFyPixfMolWwlpy0i3eIUGNCa5EsSmWdxWIUxVlmGFM6RetotqGN49jC0+Ga+734LpOGv/qr6p74z/zUFpHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPXIcV3yd9i+1WRyAmAacEMaxakD2A2+5BOlec3SwiQ=;
 b=ZgBn5rzKX4OGMv3/1KkcdfQ2ABc3fvdpGml5UOZLT18Q9eppDgVn9eD3wJA8WJALg1RkPG96lMp0IQLJqXlcSy7oTgq9dOL6ktiZO3MzrExQ/7PqXWK0CZewinS8PRUif1hFOXryx4z2Nl5uGriGSb4ibhlcaTBzlSC+Om1c0vGQrw664BA0WCl1b4Na7lzIBqLrEqKIscFDV4GMBZvrguCYTf9/AaQDLxOuayto61YEn2iZPPdOOTQXiCPeXFn2THanKRX7qsKRSC1M/mbZrw06uGsm2QdiAQsPW7Z6qrowZcuMQLcFy9BjXNkUMVW4Jk8vsAluTA5V3FZiR8HG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPXIcV3yd9i+1WRyAmAacEMaxakD2A2+5BOlec3SwiQ=;
 b=zv1Lc3ztf8tI7YvXR3iDtZdpY6Y0xwtPO9QxssGZQ5/yA2CFoKqhoODE/ImUxeuakOcHwKym0SjlrYIxZOZwZRGA0kr1S9yJKm0DoL9QrTJZtr1AJX8bb+BS0U3KV92J0xfUwJbFVWxFfg7Fm9NVFcfcaw5AEuLMcXK0u4hW4rg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 12 Oct
 2026 15:10:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 15:10:59 +0000
Message-ID: <81a7fa79-8cc1-4c38-9f3b-f01e93083784@amd.com>
Date: Mon, 12 Oct 2026 17:10:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-8-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008070542.1111149-8-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 632602da-a434-42ec-3a65-08df28730596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261009223027099003|18002099003|22082099003|4143699003|260925021311599003|56012099006|10067099003|260925021911599003|260925022911599003|11063799006;
X-Microsoft-Antispam-Message-Info: SkHmXE6K5X2G810kfE0QFwlZGZVM12HSqchIGj/KNbr8cKPJUbH2pV9dO3+ywUpX49M26+aXHhfSjd/KLDgehP451/L5eNpgizrTRrk/oI7r45YtN3LLNwhYCRJsffLDYctDqctorabepe+vEWdCcL7PfbIfYbbhc18pI0OFeOqbTE/EaW0z6xhHgPKqRU0XFypN6w5i4wvYEw+4q4XbUG7U1hHxlfDd8rBoAw50O/fgOyC3DejZLwVs0EE78TC/d0S4O+OY9MqeTbjfvzUlyRPpgL1DPwEkgMaiQmoWCBfUWySxKapOFxV/mpMTvb95MO/gVVZLwVICh4F5vcf/yaz+Ta4j9KExN1kfdMR715FDzFT9nnDW4ybuVMk5dlhTOQFmkQbf9ydTqGYu6a7Wb9YEezsgfCt2klXNWHVcrSmQXw1EzeJveFYK/bdo91m1mJ5abi5YCdl+bj0KVa4DlcX5PLRxtXZtUntCXX44QW4xNI/Pgf/TsNwT+zykgSRje/k6D923eEJ/Ne0qXCZ+rOx2AhXlhk/cAmZPCpbrSP3pquxS09JcfqfweKQ/mAtEYcCJnYQFN6AbumGmUt2YIzCZnTbnJUDr71atVHS1VIHe56GBrBPeA815eQ8I1oA7k0zvz6FO5DIEylkXeo+lTGInTJdV822rHjDCzw/+mHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261009223027099003)(18002099003)(22082099003)(4143699003)(260925021311599003)(56012099006)(10067099003)(260925021911599003)(260925022911599003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlpCVGJmTjJlZmF3aXhwMXV4UXRQNlpXQXRReG1PM1RTTG9LZk9CK3pTTVNx?=
 =?utf-8?B?bmJNOWNZNC9Pdis5dlVaeUVIVHhJQW5HUzczREw0amt3WWdRMHFJRWFZR3lr?=
 =?utf-8?B?L1F6dmM5M2hZZHVSRm1ZQ3Z2YVdqcW1ZODltN3JwVnR1cTFBdGJlNVFWckha?=
 =?utf-8?B?M29jZWhBcnd3aEtSalc2cE5BTWsxK1Q5eW8zU3VTbTJKMlV6YkhYZzNNRGFz?=
 =?utf-8?B?dUEvUCtEbWd6UC9nRE1hNUVlS1pFWVJYUWE1VitjeWhRMlVVWms2N0dzRUdU?=
 =?utf-8?B?dnBvVHVLbDBRWjd4UFMzWml5RDJ0dE8xSjdpMzNwM2VNTWhGZlhSaitscVhC?=
 =?utf-8?B?Ty9kWWlCR1dMVkNFbU1WT1h4TkhMOVhHcW4vOVdkQ1hJTGJvc2gxRzdkbVJ3?=
 =?utf-8?B?bUZQQ2dUTndCeUVvc0E5ZnJrL1hoVGw0c3IrTGV4SUVLbkVtdkRIWU0yQXVG?=
 =?utf-8?B?aXg2OEJST20rVXBnNTBLRVVEM3V3elJDN0hBaHNVLzhMcnBJNU03a3JXRjh6?=
 =?utf-8?B?eEc2dUxmODB4M1RDbVh3aEhmM3hOMldxYmx6bVNMMFMvMnFNc1hvRFhWYmJj?=
 =?utf-8?B?S251UXpNM2MvaWtWQWYvRm50UDV3SkdqUElxSWJyamFIUXcrazhSZUd0REF3?=
 =?utf-8?B?RkN0MElla3poU1M0UDEvZ0JIWHU1VE5wcWZzNlVpSXhaSmViaEhNZjUwYk5I?=
 =?utf-8?B?NllPNjZrbStndzRvcFBmVTdnakM0WWVWSmhSZll3Qk1ONzlLL2h2ZFhaMTd1?=
 =?utf-8?B?N1pLMWxwTGVObTVXcFdwM3B6TlQ4Ui9rZFBMQ0x4ck9kVk1DS1l6ZzhtYUU3?=
 =?utf-8?B?MFhBMWF5YnUvUDhEUXEycGxqYkcvdGJKUkcxRUFEakQyeHUrOVQwUkt0LzBK?=
 =?utf-8?B?YTBLYVUwS2MzQWpvRG1ZcjExcnRZK2Z0aU1aVFIwM0RERzZBNE0ySlV3OUhS?=
 =?utf-8?B?bVJRVkxvKzkxY1lxT1ZXQnpoMzNpaDltSEVHRHdEVTJPb21CRC84aXJwMlBN?=
 =?utf-8?B?NkJDTFE2VkxlVU5VdVlwTkxGVVZRVFNHVHprMWZtTFlvTkl0RTN5YUx2T1Vy?=
 =?utf-8?B?THREWjJqRC9sSGdYY0xOWDVLSXlicDJxOG1SVWcxdWl1ZVh0cjBPRmpyL3oy?=
 =?utf-8?B?M1V1YktPMklZcVJrdWZUZkM1K0RBNGN0d05oWlo1N3JJM1dYc2FVdFlpV2VU?=
 =?utf-8?B?VDIvQk1XL1p0YnFueGFiLzdUcHd3K2lWRUFUd3dWaXd4cVZiLzdOeTRRcG5T?=
 =?utf-8?B?b1kraHFHVDUzbEdGY1dhbHRrWTA5Q1ZjYUphOGpOZytGOGErdEcxL0lUZ0Jy?=
 =?utf-8?B?VUh1c08xWFZKODFVUU4ybWg5VUhnZ0lpQmNQNm1lckpReEM3NjlSc1hLNE1Y?=
 =?utf-8?B?UUxPNFJjM2VqbjRNdStwS1VXUkNvYmpiUzRDL3Z5N3g3Y0RubHhiVWxDSkNL?=
 =?utf-8?B?RnArVUFSQWZOd0hWN3U2WEtqKzZNaVhVMWpJcmFRRmJxUEZGLzdQMG1WQnF0?=
 =?utf-8?B?ZDhvQnpPVGIyc2RpcEVKWnRGZ1c5M0VnaVJsNkRGK2RsMGNUSnoyQzZkenIr?=
 =?utf-8?B?TERwZzQ1OEs3bDBERFRIY3pCSzZSZjFyVkhGcGRMOS9CcGtRSEYrdkM4MURW?=
 =?utf-8?B?aWNsb3VJZDgxY2dqa1lIckNkM0RlOUFNZnptanpWd3I0UUFsbHlUVE9iWHdk?=
 =?utf-8?B?emlKNHJBOWFqM1NEVDQ4dmxZSlNNNmZ0bW1IY3JzMkwvSjVzdDE1SndhenFV?=
 =?utf-8?B?aElnMzQxTjRRQ1VqVStVSkI5ajRObmlpOEpRWTh1VndYS2dUQzBOeXFMUEVV?=
 =?utf-8?B?M2htMHEzUmYvV2ExNjhYUEpVRGt1VjQ0VmR1aExVOUdnZkcwM3hsWi9GZWFJ?=
 =?utf-8?B?Ymc4ZlErb0w4SCtxYTYyUDdJNHBlWXE3SWtOcGxFNUk1Z1FLc2JkRWhQaWVS?=
 =?utf-8?B?clZhWWJiZ3BuZ0UyYy91MFozc3gyMUt1Q3RSdCs1YTNlOXhOODhhMVpZZk1q?=
 =?utf-8?B?aWhpRnE3RHluWENId2pidVdVeUdONGVLSVRCM2ZQTXRrbmFLamp4WXBOd1lo?=
 =?utf-8?B?eDF0bW0rcUh6Slpna043bTVHdE9UQ2M5a1BGY0R5ZzlpaFRjQ0xwWHZsTnoy?=
 =?utf-8?B?SGh0cWdjMzkwY0l4WWR4bDhXakVvMmVKcHI3Z0ZtZFZZY1Q5dlpEZ2lzblVi?=
 =?utf-8?B?ZTIwUnNnMC9GTld5UUV2UkxRL0dDeTRoSWZSZlkwRU1SSTVFWmd3blBTejJ6?=
 =?utf-8?B?U25tYlIzR0VaZUJxalNobVc0Q1lvQ2t2YzhiTFpEZk5PZ3o5dnF0RlZyZ2p6?=
 =?utf-8?Q?s0Uy4HmnNodaypQ7j2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632602da-a434-42ec-3a65-08df28730596
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:10:59.2051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4yU1iBSG3I0u+d4F6AbCr9D1cB/+rl2TIst/KUwTP+fuLie/0+CGD/TDho8gt6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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



On 10/8/26 09:05, Srinivasan Shanmugam wrote:
> Add SET_L2_TRAP and CLEAR_L2_TRAP operations to the VM ioctl.
> 
> The second-level trap handler is set per GPUVM. All shader waves using
> the same GPUVM use the same second-level trap handler, regardless of the
> queue type.
> 
> SET_L2_TRAP sets the userspace TBA and TMA addresses for the GPUVM. The
> kernel checks that both address ranges are mapped in the GPUVM before
> using them.
> 
> CLEAR_L2_TRAP clears the second-level TBA and TMA addresses from the
> first-level trap descriptor.
> 
> Userspace must keep the TBA and TMA mappings valid after SET_L2_TRAP.
> The mappings can be removed after CLEAR_L2_TRAP completes successfully.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 29 ++++++++++++
>  include/uapi/drm/amdgpu_drm.h          | 64 ++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index de4071db94f5..d82834004bba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3008,6 +3008,35 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	case AMDGPU_VM_OP_UNRESERVE_VMID:
>  		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>  		break;
> +	case AMDGPU_VM_OP_SET_L2_TRAP:
> +		if (args->in.l2trap._pad || args->in.l2trap._pad2)
> +			return -EINVAL;
> +
> +		/*
> +		 * Install or replace the per-VM second-level trap handler.
> +		 * Applies to all shader waves using this GPUVM regardless of
> +		 * queue type.
> +		 */
> +		if (!vm->trap_obj)
> +			return -EOPNOTSUPP;
> +
> +		return amdgpu_trap_vm_set_l2_trap(adev, vm,
> +						  vm->trap_obj,
> +						  args->in.l2trap.tba_va,
> +						  args->in.l2trap.tba_sz,
> +						  args->in.l2trap.tma_va,
> +						  args->in.l2trap.tma_sz);
> +	case AMDGPU_VM_OP_CLEAR_L2_TRAP:
> +		if (memchr_inv(&args->in.l2trap, 0,
> +			       sizeof(args->in.l2trap)))
> +			return -EINVAL;
> +
> +		/* Disable the per-VM second-level trap handler. */
> +		if (!vm->trap_obj)
> +			return -EOPNOTSUPP;
> +
> +		return amdgpu_trap_vm_clear_l2_trap(adev, vm,
> +						    vm->trap_obj);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9317018330ec..6c86d5731ca5 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -614,10 +614,74 @@ struct drm_amdgpu_userq_wait {
>  #define AMDGPU_VM_OP_RESERVE_VMID	1
>  #define AMDGPU_VM_OP_UNRESERVE_VMID	2
>  
> +/**
> + * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
> + * handler for this GPUVM.
> + *
> + * The second-level trap handler is a per-GPUVM setting. All shader waves
> + * using this GPUVM use the same handler regardless of queue type.
> + *
> + * TBA is the GPU virtual address of the second-level trap handler code.
> + * TMA is the GPU virtual address of the second-level trap handler scratch
> + * memory. Each range must be non-empty and contained within a single mapping
> + * in this GPUVM.
> + *
> + * This operation may block until outstanding GPUVM work completes.
> + *
> + * Userspace must keep the TBA and TMA mappings valid while the second-level
> + * trap handler is installed.
> + *
> + * Returns:
> + *  0             on success;
> + *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
> + *  -EINVAL       if TBA/TMA is invalid or not mapped in this GPUVM;
> + *  negative errno if waiting for GPUVM work or reserving the GPUVM fails.
> + */
> +#define AMDGPU_VM_OP_SET_L2_TRAP	3
> +
> +/**
> + * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
> + *
> + * This operation may block until outstanding GPUVM work completes.
> + *
> + * The l2trap input members must be zero for this operation.
> + *
> + * After this operation succeeds, userspace may remove the second-level
> + * TBA and TMA mappings.
> + *
> + * Returns:
> + *  0             on success;
> + *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
> + *  -EINVAL       if the GPUVM trap state is invalid;
> + *  negative errno if waiting for GPUVM work or reserving the GPUVM fails.
> + */
> +#define AMDGPU_VM_OP_CLEAR_L2_TRAP	4
> +
>  struct drm_amdgpu_vm_in {
>  	/** AMDGPU_VM_OP_* */
>  	__u32	op;
>  	__u32	flags;
> +	union {
> +		struct {
> +			/** GPU VA of second-level trap handler code buffer */
> +			__u64 tba_va;
> +			/** TBA buffer size in bytes */
> +			__u32 tba_sz;
> +			/** Explicit padding; tma_va starts at offset 24 */
> +			__u32 _pad;
> +			/** GPU VA of second-level trap handler scratch buffer */
> +			__u64 tma_va;
> +			/** TMA buffer size in bytes */
> +			__u32 tma_sz;
> +			/** Padding to fix total union size at 32 bytes */
> +			__u32 _pad2;
> +		} l2trap;
> +		/**
> +		 * Reserved; keeps the union at a fixed 32-byte size for
> +		 * future operations.
> +		 */
> +		__u64 reserved[4];
> +	};
>  };
>  
>  struct drm_amdgpu_vm_out {

