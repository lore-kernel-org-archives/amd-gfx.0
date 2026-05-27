Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E86ECD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 10:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEE610E774;
	Wed, 27 May 2026 10:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4waZ8kNl";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A939C10E1F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 10:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnHVFWWm8k71Yr8Ania8f0c9dYXIjk35Dngj0OWCJAFe2oHinfqYY4ulbZSaGOWMHqCgJ8MvVtjEUxe3np6ouAWo/0o1wwwjFrvjNi38xkVb2Oq49xPeTKKM8qSqzYftDsElEvGTaAfBWL2F4K2oOWVuhUef5A6wJIpZVgrUgkeBz4v8oxiWIT5G62bdIKBI6v98knF38/i20F9O8+mPFI2yQ6QSxLxDRGZNKyKe9abCMtyeE0uH2GmI0bMVUjkTyhMXQBgQPkmqVcdH2CjhH2JxX2F6rI6ZLtSGPyntmtkZ1o4dGuQueJMSuLHxHrX4ZhoSRtq8MOCF7ImZCqAAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQOjczM1PHLdY6P8QaWsFWM8ZNhphk21xmJFOR9SHYY=;
 b=clCUTSYEC532AdwNwmNXQ8ZQm7bt/qyKmY1qDEpXd96MF1dUtu/6cecWuo9ujzENgWMTcZvIZrr5ud0oQBP8NQr81CuPvaWtAhH1DNKtpchzhUkcklt3VRDyR1G0WG+Z/LzHZSOoFKq8jUYftQ47ob65Ai44ozyI+F5LxZSgw1V7ZHjfaj3GVoYT2wGdObXQEaQ+QS2fiWs9e7YRIaPu4xRjmfgBXmWtfbdnC9M4Fwz3DOC9Du0tav0FaRV1duettB6t9v4TvKXWgAr2K1e2LgTg9o1KDFB6mDXjd0YZ0V2lWZ514a7/WtE0xPgQqpdMDNsMXC7dNkUW+uSkD2VIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQOjczM1PHLdY6P8QaWsFWM8ZNhphk21xmJFOR9SHYY=;
 b=4waZ8kNl1/YOuuVKidXC3L+3bHO0ckJUrhhTEbIMPOyrY0uOKd9GfNukzSxdqXJ6U94M5mMwY1i6Me91LuP6LrvUdXdkQhuvyZCy87GByskVhn+fMnnFN9euC3ncnVLlJnp8kSIXWjeUPXVh3oKIHBz2OpXI3l5q+btRKssfBBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 10:35:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:35:48 +0000
Message-ID: <a7dad5d3-57ed-4b71-8503-f56f315dcd0d@amd.com>
Date: Wed, 27 May 2026 12:35:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] drm/amdgpu: Add a reserved VM ID query
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
 <20260526160630.35562-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526160630.35562-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: bae533e8-5028-47b2-685d-08debbdbb77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|10063799003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Z1vb5NqcZYSRWKKlLW8KR22pNa0hXYlJoTeF9BHfRPgmQumg1chrAd5Ux8o8V2XrsCANJWPwasyOQnM4Ie8HDnCn6pjfuB0GaK7eUzr57JupD57UfMrMMtM4e8b7P1avRcIRWEsboFOdfRZ6zzwGNHCkDDOlHT1jR0HEFri7GTYTBahcuyZpQclu6dIEsmfqOQCqqq39X990Ppo2XUH8lQz35hECaEfm5V0E01CrFrknhRWZqo7Y2fEHBpIVbtCnOkgaOciJ1JIBEvykdM3y0ngLm/vGmCM1Zn7oA1tKw8XeT75Vezs/ApPebnJ3TaMpiTSnKuh9JKmbctVvfXfGD5tsWZPTZ18be8mpcdG/9zO/mAyTIvpoxpUcTU0wk+ESnnUB3O/Eh5KDsmIFWdGvqTBfFKk6ez5aung9TisdtAJNIFRCqUq/NZ2NAiVTUPqls+HpWlsUwVFr7165Oa36PEizzs94TIzgeYUffpMkxtCfwSTodng9+9/jwAxUsYS3Jr+1RMwSKaWgSCa7YEFtoZ4tUSN5hYjnxSFm63hzZ63YaZsSqpscjPQ9uS8vZmylJYWYE9x2/di/thHgZFAaOTlEAvfYQuHhYTv00710cgf2ycVETRNqgRLyCcMs/aT62HjylBKWsm5LRpkxL3MDYYM12oJN8foqvyoq1NGhG/MTrYvdvVPzXGMiAOyv6zlU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(10063799003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VJRVNTYmQyeHUrS014M1J3Y2FJTGJVdHRaS29aQkZjb1BsOU5NLzYrUmZp?=
 =?utf-8?B?SzYvOVdWb0dMdVEva09scy85QUZYSENUMlBDKzMyNUE5L0wvTTRqZk1MdFVW?=
 =?utf-8?B?WTFLZ0p4K3FIdnJjWUt4bHRTaGY5RlBXWitHVk04Nkpkd1ZKT2ZNOUx4RURE?=
 =?utf-8?B?bEhTdUFVZmRmZ29aclN6YlprSzN0ZHk4V1dUNzlTZncyaGRGWkNIOHR1NzJW?=
 =?utf-8?B?SHBuUG9aN1hSSTF2TnJwTGUxbXA1TStPaXpjOUo3ZjFJWDFVRFhmUytTeEQ4?=
 =?utf-8?B?T2g5VkpjUFM1VTlPbGdKb1hBT2Q4aW55SndSYUwzMjlONDQrNVVhY29yRW1E?=
 =?utf-8?B?QStEZjJldklkVWVvQ2FxcWEwdUYxNWJuRVd2aUVLM0JhalBySEdJMTFsUVFh?=
 =?utf-8?B?eHE4blpQa2U3YkluS3JGRUtRSzZ5WldRL0ZmSWVBSFVkNWt4eldkTE5HQmxo?=
 =?utf-8?B?dEJJTktKbmZFcVNPTi90STJFYmU3VFhXNXUyeVdaaGR1clVPdHlwb25JUnUw?=
 =?utf-8?B?TTRNWUNlRHU4U0RsekFZNEhvUXJ4b1ZNYTRWM3ZOeWE1Q2xncUlvRGh0Y2VE?=
 =?utf-8?B?RDlxUlM3WlI5alIvQ3E5cHZPV1c5eHpqeTJhcVNDbUpSdm9yekRSR0FPZ0pt?=
 =?utf-8?B?ZTBxNWZmQVVBaUgrN0RVOGhEa1VCQ1R1RjVqc0RtcnZKS0Vtd05MNEZJUzBj?=
 =?utf-8?B?NGh6UFh5c0RRUmFuNkdlWlc1TzI3NVRxMXN6QWdIaUVBZE5wU2h6Y254cUlO?=
 =?utf-8?B?ajQyRHZvMHdqRGRhVGMxMU05S0NPb1RlWS8xUVhHYnRMM2JWSmdrL1dQVDVS?=
 =?utf-8?B?NWJGNEh0YVIvaDY1eGZOSnBlVFVhNlhybHZhQXo2Yy9OMW83VDBuVHM3U2xw?=
 =?utf-8?B?cGtyNXZUbHdPOGxQbmRPNHdmSFBaOWptUWpDelBSWS9mNEVvWndJczJlRmpO?=
 =?utf-8?B?QVhZUWtLdStYVncwaUtFbEJyaXFpSXVOZk9xdmVBRFZRL0NJL0NjaUJTendS?=
 =?utf-8?B?Tm1yZUZ0RVBMM1dSMlZCaW9PMkFBWXBUTFQ3aURaYWNDQ2RxRFFCM2p6MGla?=
 =?utf-8?B?UTB1Ym9ma3FoMkE0bVQ0UEZGOElEMWlBNlJ6cHRkbDMzUGVqa0RTMDZjQUJn?=
 =?utf-8?B?b0NLL1psczJud0F3OVlWN3ZZR2JWRmRBb1pOM2crVVFsRTdoRFhtbWVxZzBw?=
 =?utf-8?B?aDlwclNjN0xoNW82T0szRUlTOVpNeVc3RHE2QVRjZXNYQ1B6Z1pLblM3djJs?=
 =?utf-8?B?Y3o0YUhlUlZBR1Q2L0FFd3luKzNqcnVyaDVFN1pGdzdaMWxkQkpienRkeXFu?=
 =?utf-8?B?NVVxeXlCUU9EZUdTWkk0eVBid0gvRzhzemRIZnpWc2hlNlAvWHVnUzZJTHdx?=
 =?utf-8?B?Z0M4bTUzVFFVcCtvdnRLL041R3IxY1R6Q3JzamkySDhER0s0YS9nY1Jab0Fz?=
 =?utf-8?B?V2xXeHk5SWllbWo5aTZ3aXY1VnVyVGJUbWtMODFteExxeGxrUjlheUcweVow?=
 =?utf-8?B?M0drS05hcm9ibWhNVFhMaHY1RHFPUDlxakxrU0FQRE1qUE52ZmNVNEZBamtx?=
 =?utf-8?B?d1g0QjViRkxkUHBVcXArN3FYNytvODgvVVVBNkVKOUk0TDR5VUVmRWp6bkFh?=
 =?utf-8?B?dnBIWUMzUVl3NVllNk5wNTQ5ZWtSM2tsZjF1WGRoY1luanRZaW5sZmlacHdv?=
 =?utf-8?B?VEFHNm5qaTFDT3MrQ3B4ZXRJWk9maldzbE5xOFVua01MMUJQNk1vVXZYWEor?=
 =?utf-8?B?S2NTT3l2Y1JZTmRMUjIwTlRXWnJWOThiazVxRElaT1RlRnlQN1FzZTg1SDVT?=
 =?utf-8?B?Q2lhVkZ4RjBWS2loaHlrdk02akZwU3BSRzE1dkQwRUlNZXpXeWY4NkVBUG8x?=
 =?utf-8?B?dHhlVkRHM3NnSkZIVFpFTzhVQXpiZnFWYTFFWmVsTXJXd0RqMU9GaGIxS0Vk?=
 =?utf-8?B?NXo4Wk9JVnZjM1FzdmtIR1VqeitEa1hRanVybitqWVVjYUFtL3djWUdGS3pE?=
 =?utf-8?B?Y1FHSkhvR1AzQ2J5bjl6SGtia3dKMWs2VWN1YlNUcXBPMnBHc2IranRJZytG?=
 =?utf-8?B?NmQxVy9SLzBMVnN0U2YzYUVWVGxZVG9zVnpIK1haTFVtcmNzVkx1amFoTTlU?=
 =?utf-8?B?ZzNQZERnMlRvSm5haDFnN2tVejg5Q1pYN0NYWks1YXFyRXVtZG1TaURWeUlL?=
 =?utf-8?B?YTRxdDdoRDJVNmNObDZHR0dNQUFsM05QSCtUVnhNZ3NJMnpqNTZwRVRvVUFz?=
 =?utf-8?B?UnZRckNqaEdLdWd1YVI3TTVFME1qU0ZFdFhnTVJZNHhRYUhoaTdINzJRYWJD?=
 =?utf-8?Q?mD3D2eJQDaMxncuNus?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae533e8-5028-47b2-685d-08debbdbb77d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:35:48.5344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yh1nDyd+aqd7ZhgHH5N7GihTJ2/RHM5ca2SwJ6nQFYmajsknA5QvIYQf9LQujsZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
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

On 5/26/26 18:06, Tvrtko Ursulin wrote:
> Add a new query (AMDGPU_VM_OP_QUERY_RESERVED_VMID) to the
> DRM_IOCTL_AMDGPU_VM ioctl.
> 
> This is required for the checkpoint and restore to be able to correctly
> restore the client VM.

Well that's a complete corner cases for SPM. Why have you implemented that?

On the other hand the patch looks good, so we can probably keep it like it is.

Regards,
Christian.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>  include/uapi/drm/amdgpu_drm.h          | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9ba9de16a27a..ce068e2d32d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2942,6 +2942,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	case AMDGPU_VM_OP_UNRESERVE_VMID:
>  		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>  		break;
> +	case AMDGPU_VM_OP_QUERY_RESERVED_VMID:
> +		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
> +			args->out.flags = AMDGPU_VM_OUT_FLAG_VMID_RESERVED;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 3069560ac26e..8a6f4c558102 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -587,6 +587,7 @@ struct drm_amdgpu_userq_wait {
>  /* vm ioctl */
>  #define AMDGPU_VM_OP_RESERVE_VMID	1
>  #define AMDGPU_VM_OP_UNRESERVE_VMID	2
> +#define AMDGPU_VM_OP_QUERY_RESERVED_VMID	3
>  
>  struct drm_amdgpu_vm_in {
>  	/** AMDGPU_VM_OP_* */
> @@ -594,8 +595,10 @@ struct drm_amdgpu_vm_in {
>  	__u32	flags;
>  };
>  
> +/* drm_amdgpu_vm_out flags */
> +#define AMDGPU_VM_OUT_FLAG_VMID_RESERVED	(1ul << 63)
> +
>  struct drm_amdgpu_vm_out {
> -	/** For future use, no flags defined so far */
>  	__u64	flags;
>  };
>  

