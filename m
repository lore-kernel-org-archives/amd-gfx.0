Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9A3CA5FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23C610F440;
	Wed, 30 Sep 2026 13:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="21C6QPYH";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C9210F435
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftN+sqQAuL6wm3v4nz9bjuwEcbh3hh+9E0VfCmtng5JyEsaMup2hRBdmztDl49SRrXnJprE6oPfrR6oXAW8HUW2mQ+682K3glLbTBxYM6qI/8+hy/Eai2AVmzqTJjGAouJI2FvX9K8opLSn9lDo75UhL8etBmw0a4QCWXc1PTRI0SASI82z2ggFJZ298fCIVeR3dSYyI+//OLzFSFjRFifPWZRZhZXeuxmLtsmtaaIGJ0wiCAaLohfsqWSpjmU72mD+BJ0RYRGTpPSInNbxCKkn5eQ9y31AOBXKNsiviskEu1Ml41RW8Jy97D9WHrO23VZC3F0dY2QbhWDA7xo9XbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp7fCqfGBOpZBqB+59zB47lvbM6ufUdLoaZAXVVRpJQ=;
 b=ZEMt3Zn91PhyrSUn/hgg2f6DjsH9SNL3nlKcDqLUCUYkgMUYZMCV8IhcWizMoOygYNDjG5EYqi5WIEXuAWor1YN+PVk50ZiYcEqQG31wpc9HWHbQ8WtVeeEsDICbWW5KwP5YHCHNe5PCrywSgeezRbyVxRJIkCZQnkgR7Sm74v9qmZRj04RXAdabVVv+iXqt/+lXA2s6k7bXf4iap9JsCEhlSVzW2tnvWODdDJ55YZDB9i3ci2/r0ijiAWy0bMYjc4+tLexVy/0RDMsxeMQnMif3Mbrwo5JmmjXVc/V9HB8K5zW3vHa4E8pzBdDTOucSpAIOxCglnyHs40vPYmnfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp7fCqfGBOpZBqB+59zB47lvbM6ufUdLoaZAXVVRpJQ=;
 b=21C6QPYHtQKCtynys2s6+/WSJKmvvyHZ2yB9yl5fmsDzm0rK3eYSVUFnN3HdyEw7/hCRrbpd38lXjCfOr8O4Xzeoxk1W7nG7W6XJeRnb0C1xBuLL6lwb2zFkIHHZP1YXrfq0/TmPwEkcgy+31WdbKf+DfACbAL5NBJHxXxmWJF0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Wed, 30 Sep 2026 13:51:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 13:51:23 +0000
Message-ID: <78c99777-2a12-49c2-9061-7ce8228a8d33@amd.com>
Date: Wed, 30 Sep 2026 15:51:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub
 to vm_manager
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930134658.3982457-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930134658.3982457-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0414.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: ed18c3a2-e500-4c87-18f5-08df1ef9e9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZHShwVXDHgR3bPhudBFIyIZiySu8h91Ktgo6J6Q5iurYvRKaYl2OzoHo8IUc0AWzQkbPu6/re0kwYzrN9DCHc38jc3ynPmuXuV+3lH73dUrKV1KZfZ4Kwl9U0gYyddKuqTFd4Kg3GbSpWxfeB+3n4HSnCUK2TMlo1XEx+f9F1c91WXfPJvBw4HuRrSBtHy+ClBd4WLjbRSAz6NT5BT9AcnLgAOiw83Yb9Uk8IdmErZGaM1p25oqGaIf9EybJ8+FNcNlQay48ivdS5nNBuerVvzqi3Lzg0ZTpqgRTeabR1jmdhODkJ8kD78eT29tK1vaZpQUflFSRwrfc6flyu10mNJnv4UFjBvN0Tjf01EUrtaiM+GCtdTj2RoQRPC1ynpHwSzHeL8H1lL30dbwwlR9fiDNHsWLJZZ3Dmlv6iEsNlIDMhsS/KUnsyIt2uQq95mPVr9T+SvbyD+D1F93pq3moh6pxuRdcO5FfTJucJYLLdG3E4V4cXz7xUVx7TfTtUBMMR5xolD1k6+eI5t4sh1CfDqWTTKwBwYxzlEKYsTW/+ZmLS1gS6l9rd6dtrSpckgebwgKB4Ob8Sdv8fhS09VRWM0RH442lwWB6jaXyIi7TMTlF34FqB8Ap5ByqIloqEYgmQUDNXC1W9iYxMf8hPmbkOx6JGr6nY2RcEb2NI9iSdEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHFsa1Zlem0ycG1rL3hvcVpNUmNuSWpneTh1YVUvWktvb21jbklKcXBRa3h2?=
 =?utf-8?B?MzNUTzhuNCtpS0tDQzRIT3ZLb0YySXhBa3MwMm9LeTZ3WWtuRlhqcXNhdmNO?=
 =?utf-8?B?MDM2VlhvRWJMeURpNFNiWFpWUCswcVhITVNmcmNsenlrVkFPWVA0MWErNG5u?=
 =?utf-8?B?aEd6aVdoMTM1ZXFOYnV3UDBVM1dtdDVRUlB6T2JkUi9WVXQzZlZZLyttQnox?=
 =?utf-8?B?c2JEOWo2bE4yQU9uc0xCbTIrb3ZmWW1rVTl5Q3RhcWRmQWE0WFFROFliUnRv?=
 =?utf-8?B?NXJ4eXF2Y1JOcW91Z0E4UTA5cnJ4bjhIK0RmU2Rjd1VUOThrNjBLL25VcmRx?=
 =?utf-8?B?VHkrQ3cxaU5TMi9jM1FvVGtSSDlHRCtIWjBsU0VDUXE1K2xnaUswRHV0ZXdB?=
 =?utf-8?B?QmFxNU9vcytubzBXR3NteU1PZ3ZmVm9uUUswRlVQUERqczlCYTgrV1RkMWVo?=
 =?utf-8?B?czRoSEU4SXgxOGtJWUhDWmdiRlFOSkkyWXJteTV2Y2ZxOTNNVkxwYlF0cHVo?=
 =?utf-8?B?aUx0Mjl2TTR1NWN6dmd2Sjk4WjBVNlZuMERDVmtoR1J4L2k0OFIzQys5cjFL?=
 =?utf-8?B?RXd2M25nT3JWU0FmRFFBS2RWalhjWnVyNTlXK2lFWmVMVEcvU2JTMElmd21Q?=
 =?utf-8?B?R2hJWEwvd0VtSG9oVVdsOEkySTlmTDBGemJZa3FmZVZaajlla1QwWm5mK2kx?=
 =?utf-8?B?OXVDTWtZNXZjQk5rM0thYks2MmhJVE5CVzRLZ2w0d1pSVG9xYU9iWjN2cldm?=
 =?utf-8?B?MUd2aE83WW9sdXV5d0pLd0ZsMUI2ZDVTM2ZWdjd3SUgrUW00b1FMRndtdm8x?=
 =?utf-8?B?SUFFWVlNcU9pdWxMYU1YQXZGbTJZb3EwNy9HL25sY0NxTHRZVVovSFZLOFhN?=
 =?utf-8?B?TGorYkluQi93SDh2a3lpUHEvQStsSWRYTnJjVG9PbVNmbjRqUnNpUEZiU2E0?=
 =?utf-8?B?SGlZQ2VyQWowWHJnL0F3RFBBSE8rRFFWN0p3WWN3RkJIZTF1TDJMMUhIVS8w?=
 =?utf-8?B?dU1ONC9pVkJibjdTZTcvSVFZTHdNWU9KaFBBaFJuVjh3T0t3WG44STZ5MUFH?=
 =?utf-8?B?UG9VTnpzSFZwT0dUYk9IQm9KN1lONGMxU2FnM1dtTzlUVytBU21pdGNpbW01?=
 =?utf-8?B?bmNFNk9RQWRXZW9iWjB5U2NVYlZtTGRodHRaTmNVdlFlR3owaWpuZGZqSmU3?=
 =?utf-8?B?VXJqOWpGVTg1aEdkR3dIeXNKa3VZS094d1ZrYjZvZ3hraEYySU4ydExNY0RG?=
 =?utf-8?B?T2g1Q2RWbXJPeCs2UElxdEFqZGpRYkdUQUFOU09wQldPSnU5c0dhQUtScGtx?=
 =?utf-8?B?UzQzVHErcnhuZTBOcDJsL0tmcGtnMXdqNzdmckI3UXc5MTltRklWZXFmRFly?=
 =?utf-8?B?ZEt5R2RUdGMyV0xqSFE4RzlVVFk0Ty9kbWNBQnFhbW5paXRwdncrUUlZMm0r?=
 =?utf-8?B?b0dWQ05YYzB2aTVmd3d4RTF3SEVDTlNobHpiaDc2SkFUeWlrUURoUm1CcmxW?=
 =?utf-8?B?WlBEMnRFaENZZ1RLR2dJR2o4S1JCZFIzN0d1UTRSbFNEN1VHb2t5Z2lRTDF5?=
 =?utf-8?B?YzZVdHJveHVFL0E3R3dOREZhVVpvNmswY0pDcTZZODQ4ek91S1d2dzROOU1n?=
 =?utf-8?B?a0JoUHRuVzdDeXVGNHU2WG5BNUpCcGlVdkREV3JIdE4xbHVQSHlwemo5c3Fa?=
 =?utf-8?B?ZmRHZWxpUVllaHk0ZFl6NzcrNmc5U2pyTU1vdXUyK2RiWlVsWHkxdGNvVytU?=
 =?utf-8?B?aXE4TTZFS2loeEltMmNZcG5yMzRiakFKQi9HcGlxTXZJZ0J3VVdjREo0U3lL?=
 =?utf-8?B?Vmt4V05qUWhSRE5FbTFLT1kyZ2FjbFZGZXIyZkpsSndHTVB5aGs3eXhCdit3?=
 =?utf-8?B?cTArbUJIYUl0d1JyVlZTNERjVi9WZVZFb3FadmRzT2NRTm4rQTZXZXpRc28w?=
 =?utf-8?B?TnJicFRtdk8xWnMveStPTUFYNGVreWlFSVVVRlI5QlZ3czVoOFFIclJQRGxl?=
 =?utf-8?B?K0N5Z0kybnZ2OVNSMzFvS0tpTnloeVFyZFJXNnBDTWYrZ09tZmU4bTE5Y3JG?=
 =?utf-8?B?UElnaVY0OGpmaUNBb2FnR3ljN2VUOGJZQ2VrWlc0eTNZY05JZm0relh4Um9C?=
 =?utf-8?B?dHYwNkdiUG5mR2FKZU9SclFHcHgrcTEvT0NwbFpqMjVCVXc0WjZaUVFlSWha?=
 =?utf-8?B?eEQ5NWpMRlpvNEdscytuK2FvYk00bkE4NXlCQUp0N3k5WE56aDZoUDZmME9s?=
 =?utf-8?B?OTc1ZVc1UFJlbzFURTBJaksycVdvdWpsRVZBcGxvYzVEMGJjb3o0eHJFaVdZ?=
 =?utf-8?Q?no0OSpDibVkTAeWc6E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed18c3a2-e500-4c87-18f5-08df1ef9e9e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:51:23.0922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXAlOKEquhhT0HQftj+/vd+EZN3JCvgUGQTel/U4PpZUvGd127EBXu7n+/HCqTtp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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

On 9/30/26 15:46, Sunil Khatri wrote:
> vmid_mask_gfxhub/vmid_mask_mmhub makes more sense logically in
> vm_manager than the mes ip struct.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  |  4 ++--
>  6 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 5285c1d1fd4cb..d1e956cf8e5b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -137,8 +137,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	total_vmid_mask = (u32)((1UL << 16) - 1);
>  	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>  
> -	adev->mes.vmid_mask_mmhub = 0xFF00;
> -	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
> +	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +	adev->vm_manager.vmid_uq_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;

Reviewed-by: Christian König <christiam.koenig@amd.com> for the whole series.

It would be good to move the total_vmid_mask and reserved_vm_mask computation into a function in amdgpu_ids.c as follow up.

If I'm not completely mistaken the KFD should have identical code as well which can then be merged with that one here.

Regards,
Christian.

>  
>  	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>  	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
> @@ -183,9 +183,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	}
>  
>  	dev_info(adev->dev,
> -			 "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
> -			 adev->mes.vmid_mask_mmhub,
> -			 adev->mes.vmid_mask_gfxhub);
> +			 "MES: vmid_uq_mask_mmhub 0x%08x, vmid_uq_mask_gfxhub 0x%08x\n",
> +			 adev->vm_manager.vmid_uq_mask_mmhub,
> +			 adev->vm_manager.vmid_uq_mask_gfxhub);
>  
>  	dev_info(adev->dev,
>  			 "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 594fb817e0a38..2b13a5b375393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -122,8 +122,6 @@ struct amdgpu_mes {
>  	void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
>  	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_INST_PIPES];
>  
> -	uint32_t                        vmid_mask_gfxhub;
> -	uint32_t                        vmid_mask_mmhub;
>  	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>  	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>  	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 98cdd7e3475fb..ba711cb8defe1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -413,6 +413,10 @@ struct amdgpu_vm_manager {
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info	fault_info;
>  	unsigned int				npa_vmid;
> +
> +	/* VMID masks for GFXHUB and MMHUB */
> +	uint32_t				vmid_uq_mask_gfxhub;
> +	uint32_t				vmid_uq_mask_mmhub;
>  };
>  
>  struct amdgpu_bo_va_mapping;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index d1cd665ab301c..78c517f6c2d27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1080,8 +1080,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>  	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>  
> -	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
> -	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
> +	mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_uq_mask_mmhub;
> +	mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_uq_mask_gfxhub;
>  	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>  	mes_set_hw_res_pkt.paging_vmid = 0;
>  	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index c0719d8fa63e9..b6356095b079f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1042,8 +1042,8 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>  
>  	if (pipe == AMDGPU_MES_SCHED_PIPE) {
> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_uq_mask_mmhub;
> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_uq_mask_gfxhub;
>  		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>  		mes_set_hw_res_pkt.paging_vmid = 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 20159fb9d6ea3..ef81c5a23b9da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -685,8 +685,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>  
>  	if (pipe == AMDGPU_MES_SCHED_PIPE) {
> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_uq_mask_mmhub;
> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_uq_mask_gfxhub;
>  		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>  		mes_set_hw_res_pkt.paging_vmid = 0;
>  

