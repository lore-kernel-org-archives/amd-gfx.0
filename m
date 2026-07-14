Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3527C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A8110E05F;
	Tue, 14 Jul 2026 09:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GN1fgBZX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB5E10E05F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MirG62eN2lBSV0QEm+xwS2JdeB08NF6f+rhsKlKi6BRaIgS1wWLCwunVfOyMuNA7FkFVbd04HfDCyhwL5N464GRGq/p5VSibK0aKL45/0c1MLRTR0Rz38+8v3ik8CLnR/KpAcycVT1/mUZFMx/hKgeB/JTRwlKQ88uZ97jcO0PYZpKzylcNUXmgEEdVNjhBaZw1uqEcq+2rb8DDCi34Tb2NgBjz6jRxBp+blJBm9IFaea17ylp78WE+dCItZh91UkvVYMZRn7UmS+Ee8kuohUq72IFJkihnBX5cw7M1CU5zDPYuwuWTZrA8XmJNztcZtR19sCiOn8NhBuDPMXMWjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rwv+l4tNbtqm3lFMUAaXUfUCDNfDoIW2krfAWVAUoTk=;
 b=ebJwnuTckRt6vo1g1bIQS6+h3af5/QtvmHvA8KT8CNzJ7YKUvCMZ4Z31V27qC5NYzLSUNHfJ79OoZyvyKKMNeU85BusF+RibDCgcKSsawHQO+LeuujqwKDtRIaGJ+oWShUWYgJ3Frl0WxIto1WnLO7c9zFxZBtCmkacfEEG249HTM82DQ4mRZMyqbWdxVG7LE9LIntX3CeyNO4eO8+d5oPHPEs+wKg+bAZTuqUASu9NOQw4F99IF4Ocq+ma0agnklRzraU6LVeCZ7QDz8O2wlTFp2Dlxc3UKigjyYJciu8ZBJkqAFZ+wypDD0hDrnqx6qQzw7llFg3EafPIivBKrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwv+l4tNbtqm3lFMUAaXUfUCDNfDoIW2krfAWVAUoTk=;
 b=GN1fgBZX3oaA6WQQtCoMpWt7Z1Nnbty71p/umQrLr/VyCzH7e8jEzBiqOMhKMis8ENnDQH/dVLFCQbQJEkulKx4genP7lAuJFmgO2KuWOmOeExNzbee3JWDCqPAkIvCs275OOrhc5y4LZyUQK8RMJedJ6wj2cZFEPihCI3c9ipI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAVPR12MB999120.namprd12.prod.outlook.com (2603:10b6:806:4e7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 09:41:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:41:33 +0000
Message-ID: <6ebc660e-f3a6-470e-b8ec-3aa64b08f597@amd.com>
Date: Tue, 14 Jul 2026 11:41:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amdgpu: add core helper to do TLB invalidation
 via SDMA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-10-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260713182732.630947-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAVPR12MB999120:EE_
X-MS-Office365-Filtering-Correlation-Id: a8286ce4-2425-4469-07b9-08dee18c16e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WXLWBfnK+TzlnU1LgGiT1c4oaIlLlGWxHk1s14VGMSvzw4Jqjq43V/1RGpoN1T1XYNt+TfHXp6GALoKDA7WoAmmXyRSv0uHHBL0jfD6DabRV2g6Tm7emzgScdLQsuBnxQe6Osvd+QuadMMwHZtYCHB7CoQ49EnV/4YvxKvStBTkH1eVbl35UBHHOt0nGuiau7+pqu6j97+UEbiD4SqDOzMyP3s71zpGVg0qsBXID5gDBPuI9Fv14oEr/Iku+q3sh5BxP+MelN8FH0+GSxvw0TKgqIYOcZ1exZSYxuc1OacrVtoK8G918rhVRoCUt8+7NANFYrLGiELGZ5w4I4MtJyGgJGPPGk7mEWZ+P6Wkc4j9BioOYbsk/jaaQNidehteNHwkPUAbVF+ayyDtKUpzZIm3QR+bz5S5U/5A1jJWJTw+uHa6GVCMRQ6/I/zizpQO/er78OJemnCbaLhA/0nVei1vHiJbJJeoclKzN/K/bFlKnaJ0UxHAS2RqGk8BJetv5wGSWif9PqPjcxAv2Ik93Yn9TGPvD/qUVIg7efVOl9T3ZQhHMIhPcr6kEpa8rnvnMZbqDolT+D45BrgxJDqy/yrvQXN8V/oQy9/GQtOXwf59XvInNsOPQA0ofmZfBlEK+yu08z9zm3pGJB7V7boucu5dsrdjZjo/qUg677RjMeuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWFiV081L1luMUFaNER0bzA4WDA3MmowdjExR3lyL2JYNFBsZGM4Y2hjQU5M?=
 =?utf-8?B?a2RLZ2NwbmM4VDlwZ1hweE1XZTdNSUlBOE0vZGcwanl0d1I5WUdOMjFGcHhW?=
 =?utf-8?B?UEFWajYvc00vV0NTbks5d0RBdjdWaTNjT0REWTd0am8vbGtKRHdDakxNTElF?=
 =?utf-8?B?cVdjMVRXcEQzOE01d05tU3NseFVGTk4wb0FzUlRhZitWTzJrS2c3ZWNkOXBm?=
 =?utf-8?B?c3A4ZXlxTW00TktuZkVDUU90eGxGakthcTlDYXkyRnhnWm9yK0w4MnFOSUtP?=
 =?utf-8?B?dkFxMXJxR0phUmF0d0ZZdFh4cWtxYVRMYndSZlFSWFhSMG5UOUdSMGtlbm5T?=
 =?utf-8?B?UWZpZXN3dzYwVzdkSlQwRGFJZGlrWWtveklHUHA1RkZXNitBWExySHp0Qk5H?=
 =?utf-8?B?emwxVEh5R1VCa0VhNEFROGRlRUt3cTh6Y1FvZTBsajJSZUZNbnZMeUNPRW1h?=
 =?utf-8?B?MjY5dGZLRFRRSFlOSEdFNjlqRFNPNFhnMW9obXNxVVcvbzIzUml1TU82SGNt?=
 =?utf-8?B?MWp1TnlTUG5Fdkpub2RZQXE0R3pjVnlHbEhrOXdNaDBSeVRFUjd4czI2M1F0?=
 =?utf-8?B?NTZrRy9HNE5wZG5Xei9LN1lsN2VzL1RmV3JOS1RlcXNUOVc1ZkxpdUdxaVk2?=
 =?utf-8?B?aFhzaGR6REhJYTRnVFgxcG5KOXFnS2VNcGhsMlZUNjczelkxMk96d3V4RVhw?=
 =?utf-8?B?RnRFYVBjQVBuQzFZaWFPcStnOGxDZnNscjZLTGhnR0JRZzJrRG8ydFQvUWJJ?=
 =?utf-8?B?S0hRaWdoa2pGQkJRNXZMZVRjVEtSWU9TbzNkRm5FV2wyclJsaUlpRnlRQnZ5?=
 =?utf-8?B?K29sRHByZy9mTTI1cG5Ta1hTSGM4ZC9hNHVEdDgzT2ZnejF6YTVMQ3p3bTVK?=
 =?utf-8?B?ZDVDU2hKTGI1VmJycjJzNHg1ZUdHVCt1KzN2NVRYRkNPUEdjVm9WSTZ2MVo4?=
 =?utf-8?B?MFhxbnJySllPcVBYYW5aenY0QU5mT2xjenlTazl0NnQwUnJHRDlIbmVPV0li?=
 =?utf-8?B?QkhUSzk2UTJFWGNSMHM2N1pBeGdLZUFQSzJSdXhabXEvRVVkR0t6SnJPQmZy?=
 =?utf-8?B?emlXSkpFMWwvWnNZTWtsKzc2cEQzV2x1OUEzcFBqZXR2d1ZiYW4xRTZVQ2Y4?=
 =?utf-8?B?VXkxdW11bGQ4M1N1bUk4WEVGemFHK3FTR1o1ZFR3cTVPazB3aDRrSWltN2tZ?=
 =?utf-8?B?WWVyaFZUZVc2bVl4dUI3TE1PTWJkVGY2VEVxaitoc1kxMlNsYjlNcXV6ZFpk?=
 =?utf-8?B?ZWh4TmlIOFkzN1hPL0xCRnFZSmhjT0NZZWhka1dlWGwyOXE2eVAwSUdKSDFu?=
 =?utf-8?B?QlllbHZmamZLREY0YWdDbWliTUIyQWJad3I3V2svQ1lCRG5aOGFWUTFIREFZ?=
 =?utf-8?B?Mjc0dFhJa0QwQVJneExCRVBXZS8zbm1qcUtXenRkL1RidU9MQVQvKzlQeVRW?=
 =?utf-8?B?TURSd0RPVVRzZ3dmamh6OUpsSWlGVVdZd292V3d6ZE1VdFpLQldpN1dHV2ta?=
 =?utf-8?B?ZmVMWWQxY3dNbXhtcFlyTXRRbjFmNkNEWDc5c3R4Zy9oUmp6MWNzcHRmMXBv?=
 =?utf-8?B?YWtpK04vZjlpT3N5a2JHRUEyMTNxaUZUalJIOURDOXlxcDl1bEFhNVZ4enVk?=
 =?utf-8?B?ajYvSFlGbWlBaExtVGMrTUo0N3RaTExpS0hXNHhRRmhkNlk5aWsvZnZsRGJz?=
 =?utf-8?B?VU1kMlZiaEdDSTQyd3RYOU5zWkdpQ21TMVV1cXFMY2JBYTkvMThNL1paRFU3?=
 =?utf-8?B?RVlpRllxYUxSbE5aVElnVmQ0ckZRZnE4cWhvMklRQXV1OUEzeVNKaWpRVzNp?=
 =?utf-8?B?QmZSRkNsaUY5Q2lNK1VERUpWd2t3OXJjQ0NHdjJ3S1poRUtpbTFKSklqRE4r?=
 =?utf-8?B?aU5QeTZJOFdwdW1PeCtzZC9Xbjd5ditTVktoUzgzWlpLWU1YU3A2cVRydy96?=
 =?utf-8?B?V3dPWHN2U3RkY2wzYnhsNVdqVnI1STJBNWtSR2ZHbGE3ZWwxY0hqdm83TUZY?=
 =?utf-8?B?QVhEeGRuQUcwdGNzVmNEWHhVYmFNaDEzTDI4WG00aUsxUzNkWG1KOXBNWkZt?=
 =?utf-8?B?bU5NaE91TTAvb0JJWjlsLytOd3BibWZBY1RVc0xqck02U2czY095eHZrSzZK?=
 =?utf-8?B?YWdBS01WM1pwcElQK01ONit4L1JyRlVlWjJSWFQyY29xUUt4KythOTdqdFBE?=
 =?utf-8?B?SC81MlV1b3Ztc0dvTnhCUEZjUW5lSytOazZUWkcwWEdGVTFoZThDYXczVjFw?=
 =?utf-8?B?eWxWR1FLOUpaV25md0ZqaStqcmF5NkxXTmIrSXVPZFZHNnlyWkVJQkZZVFVE?=
 =?utf-8?Q?bSC5Q/z6afLqZrvfvw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8286ce4-2425-4469-07b9-08dee18c16e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:41:33.2022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+l+ooobIpO7vcl0fAcgIuanKbuMPgZ75aRh7yxBVCwsSSm/FlS7MvK57ZqtQGnR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999120
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

On 7/13/26 20:27, Alex Deucher wrote:
> Adds a new helper to do TLB invalidation using SDMA.

We already have that. See function amdgpu_gmc_flush_gpu_tlb().

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 36 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 42 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  6 ++++
>  4 files changed, 86 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3f0b1b7a557b9..5c1237a30b865 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -928,6 +928,42 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>  	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
>  }
>  
> +int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
> +				    uint32_t vmhub, uint32_t flush_type)
> +{
> +	struct dma_fence *fence;
> +	/* Use register 17 for GART */
> +	u32 inst, eng = 17;
> +	int r;
> +
> +	if (AMDGPU_IS_GFXHUB(vmhub) && !adev->gfx.is_poweron)
> +		return 0;
> +
> +	if (vmhub >= AMDGPU_MMHUB0(0))
> +		inst = 0;
> +	else
> +		inst = vmhub;
> +
> +	/* flush hdp cache */
> +	amdgpu_device_flush_hdp(adev, NULL);
> +
> +	mutex_lock(&adev->mman.default_entity.lock);
> +	r = amdgpu_ttm_tlb_inv(adev, vmid, vmhub, eng, flush_type, inst,
> +			       &adev->mman.default_entity,
> +			       NULL, &fence);
> +	if (r)
> +		goto exit;
> +	r = dma_fence_wait(fence, false);
> +	dma_fence_put(fence);
> +	if (r)
> +		goto exit;
> +
> +exit:
> +	mutex_unlock(&adev->mman.default_entity.lock);
> +
> +	return r;
> +}
> +
>  /**
>   * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>   * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 3ca187f5ade85..0135be1418a91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -450,6 +450,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>  				      uint32_t reg0, uint32_t reg1,
>  				      uint32_t ref, uint32_t mask,
>  				      uint32_t xcc_inst);
> +int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
> +				    uint32_t vmhub, uint32_t flush_type);
>  
>  extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
>  extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 74ada995bd8e5..03e74b7ca0003 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2513,6 +2513,48 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> +int amdgpu_ttm_tlb_inv(struct amdgpu_device *adev,
> +		       unsigned int vmid, u32 vmhub, u32 eng,
> +		       u32 flush_type, u32 xcc_inst,
> +		       struct amdgpu_ttm_buffer_entity *entity,
> +		       struct dma_resv *resv,
> +		       struct dma_fence **fence)
> +{
> +	struct amdgpu_ring *ring;
> +	struct amdgpu_job *job;
> +	int r, num_dw;
> +
> +	if (!adev->mman.buffer_funcs_enabled)
> +		return -EINVAL;
> +
> +	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
> +
> +	if (!ring->sched.ready) {
> +		dev_err(adev->dev,
> +			"Trying to inv tlbs with ring turned off.\n");
> +		return -EINVAL;
> +	}
> +
> +	num_dw = ALIGN(adev->mman.buffer_funcs->tlb_inv_num_dw, 8);
> +	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
> +				   resv, false, &job,
> +				   AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_emit_tlb_inv(adev, &job->ibs[0], vmid, vmhub, eng,
> +			    flush_type, xcc_inst);
> +
> +	*fence = amdgpu_ttm_job_submit(adev, entity, job, num_dw);
> +
> +	return 0;
> +
> +error_free:
> +	amdgpu_job_free(job);
> +	dev_err(adev->dev, "Error scheduling IBs (%d)\n", r);
> +	return r;
> +}
> +
>  static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>  			       struct amdgpu_ttm_buffer_entity *entity,
>  			       uint32_t src_data,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index ff9e2e3466099..f6a69c5a5ee86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -195,6 +195,12 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>  		       struct dma_resv *resv,
>  		       struct dma_fence **fence,
>  		       bool vm_needs_flush, uint32_t copy_flags);
> +int amdgpu_ttm_tlb_inv(struct amdgpu_device *adev,
> +		       unsigned int vmid, u32 vmhub, u32 eng,
> +		       u32 flush_type, u32 xcc_inst,
> +		       struct amdgpu_ttm_buffer_entity *entity,
> +		       struct dma_resv *resv,
> +		       struct dma_fence **fence);
>  int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  			    struct amdgpu_bo *bo,
>  			    struct dma_resv *resv,

