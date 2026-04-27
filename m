Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63589FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3B710E637;
	Mon, 27 Apr 2026 08:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CL4zVAS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233D010E637
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6n2oJXNp1vQDQW6Oh2i+mi/zdUxjcZEOBokdRyJKuKe/hceDHX14ZR2dwd2heRflts9QHXNNW2h41XysuMwXbL38RwNxM2ONxpuf0OexCDQ5HBcU4bZKFj6j/PrAedIJd9R3CyyaOcKW0jSTufRmtnav8R6ZDafcpKadxjPLOMg43exKy5/3AutlIKwk5/p9VBl3iK/1bvQ+xFAqzcpGUo5TgihqWMbE6BPRw3tTBsrT5/vpFPfVx74+/r8DeTNaNgup55oJrACDaMgpdHUlmajxJk83dhHrTIM4QvFO/sLdOi1My6+bcchDMaHxYfnwIn6iHotfxTGSVshQoUUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjoN/Oo4lAug7u2WVT/ymQyqcmMh6wHOjoV8GILYlqg=;
 b=yCPyEhoPuBoTK15ixiopEa79iWTI7ZjC6905Xl/7Dm8o9nJeyLyKa7nq7i7b8sbCL7ijvABTkdhDvejwQLn7/u2qgl6XRkB4Kd39+9anTfhWGuTUbREsb4brcZTSuItS+WAy3ZIRpJQWLx3EVSwWoKgLz+fpYGDA6/o+XU3kIt2CD2bFjBqW8NLBS+ENNVZr3GP1dfOD3YcK0DFx8FSMOjFXpAeDjGGyVExKFOQA+LgIekWq99irD2ht9HOO2o/ZFf8VFkCM4CwOi8qMIyO3EWqXZAcr8iBzBgQo4hB5IxVg9DjHEoYp+51OBqk3RV7JFfG4Nqm2skFBHANRlwkF9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjoN/Oo4lAug7u2WVT/ymQyqcmMh6wHOjoV8GILYlqg=;
 b=2CL4zVASDkQjhDJ8EDMliHEuls/p4nD/Vm6+8wX58KyOTD1ynA7uU7A8wX8RxpzYoevNZVzVyczQnhSGmMA1MDmkvuCiDIuLWjMXQeHwPpPBn5wtw+wvzXu4Hob6kC6jtB7azGNOpvfo0sc0qXv4y8vrmTGQcjA9x3UEeXoaZYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 08:42:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 08:42:27 +0000
Message-ID: <934574bf-cb2f-4bfe-a864-7b6d3f294d24@amd.com>
Date: Mon, 27 Apr 2026 10:42:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] drm/amdgpu/sdma: add SDMA usermode-queue
 doorbell pool infra
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a3d096-cd0b-459d-e60b-08dea438e909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: yZ1Utc7ltswRVu7Ai+ydYLhF2TzcsCRA+aJaL5vqV5RZd7A3LX9Zm3F97sbs+k4Hnsq2eU7073zFcuE3+rFc+Qd5tuY/aVjmc41nFRFWq77PyJ85YQnl3DqU1mOgdu07z8fuuXi9MaiBZmrGnfbX9reQ1PbsnIU9I7WRzf99qri8I6tHtcxLzjTHBI96EjJ890zGl/NSRs2j4w+rJDuK4qZ1DH3HPW9NUpv90TicwvVValHDhaEEozer0y3kb403NPIAhOgXbfiKp1fPzLMfkX0gFMYhAgHrE5tIyySPmMRb40FpTND4DQqn6SKSJrqZgluh8n2s/l9mOr7aYQBwqXt2Pid5NooI5+edaG6na4Ct0DR/JfKSMMGtaEbdUdIDIknFqbSASzRYgQlk0u8eZouIs6LqC9Ua/zKA17P0JbxR6D7RSu8Q7EYFjEsQ2tcoVFjn2HIu+YckF7dW84diOMGkLP6nDduo5mjbuI/7hTBbHIdc3ABaSj0RT5jfgxVCu/X7J924anRHUBS6d36kQbyD41ja/E1eiC29hvj0XlUBPDulmE5BqvvOaCjxs+cW3kNEHYh/sJCYKiTSRRA3xirmHEyDYvefJNbLHdAGWVbCAY7E7njQsi7/GDRhYXaBs1o1ZoTFel/uyhfoA0ZaFlMl/MDBIBu7z+UVdcEtEa74BPlmuQwBfWNfF951Eh5/ejXh+ePS0ISadLxhV39foI3Vt48ROjxxv4WA8UkN9ug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1h3T1VJdHBmMXl2c1lrY3h3TjZ5ajArYmwyenRYOUt3MjNYS05jL1dsZG1T?=
 =?utf-8?B?SStSSy9CY3FoTEJsc3FMa0lYU0QrU0hiRm9xdzd2THRqQi9Kby80Nkl3eTJl?=
 =?utf-8?B?OUZYcVNWMU1CMWwwVG1kS2dJazdTek96dFRlOThIendUNTFyUDZlSEFUYXkv?=
 =?utf-8?B?VlVDN0ZOMWNJdTJIdUV1K00zZjA0bVp1d0RMVEU3UnZkWEF2L1hUT25aOStQ?=
 =?utf-8?B?NE9GZFB2dzZ4L1psNXFGc1NUVysrako5OFhWc2xQMkdUNldrWlIwME55Sm5m?=
 =?utf-8?B?cVRmcTBGbXJLaEpVN3Y3RE1JY04yVXc3YWQ2S0FOREVzNnRUNlFGTE9NZkNC?=
 =?utf-8?B?YWRrY1RGaEVxWUthTUFJY1RBUnVaczI0Kzc1RkJhWlBsL2JiRElXSTl6NXdR?=
 =?utf-8?B?MjNuWTN5WGgzZTJjR3lFOEZIcldwSTBPdTdEMWpRUkdZQk4wSFZuZlNWaW1T?=
 =?utf-8?B?c1VoYzc5cEpJeGZMTXBOL2lLZHNBeFFEYzRadnBNMW1ONjhPL1MwdlFmSjVI?=
 =?utf-8?B?YzVhelNBV3ZhSkYvVVFNWWRIdHlQZ2FhWlNuTWl3L0dNb2tNN1hlaFZRSzM1?=
 =?utf-8?B?QklSVzFsS2dzS21hSG1zaStBdDdoaENlNmpVMVV5eHVZbytUMDFyZWVsdThT?=
 =?utf-8?B?STY4MzMxOFZ6QVZJMVFOL3dwRjRqSklLK1NDRk1VL3h4QUpwQVhPdDNUR0l5?=
 =?utf-8?B?cGxlb2wvMmlMM0FKakhmS3p3MWNMTWViTTRoVFJkYmpETUJLTTh2b0JING9y?=
 =?utf-8?B?Y3hKQkxvZUVBNGcwamtjd29WK0JHbDBpT0hBMWZQeUc1WTFwRVpRS1RXTWlu?=
 =?utf-8?B?SlFPUG5LallEVTkrRm5wY1RwUkxCekxRbVdUaVhqVlZNVkVRSUE5UlhraDg3?=
 =?utf-8?B?RnZJRlpKZkREV3BpKzVEOTEyYUxuRDRyTTJ2SFI2TGNkOFdMOEJLQ3lXZVN2?=
 =?utf-8?B?YW9id1FUWFVvY1FJM3lsS2tSc3o1WU5yN0F6WGtmNmFqZGI2SVFEd3B1d0tz?=
 =?utf-8?B?SjF6c2pGS0FmNCtaa003TWRsZWcyQm5WcGl0Q0oyWlREMmJKS0xBb3Z4UnRF?=
 =?utf-8?B?SkI1azBEb2FDY1BFVFpZaWVBbXRYVzk1SmZkM0d4ZjNsOW1XdU1pSjJDdlBC?=
 =?utf-8?B?dzZoRUUwenlKV2o4Mm5pODBaTVgrTGhEQW9iRUhzby9mcS9FZSt5SFE2NUZq?=
 =?utf-8?B?ckt4WlZjcnZQLzR4cHZCby95YTM2QVhhQzJGNDIyN0h1NmFLRjZNOCszaGdu?=
 =?utf-8?B?MWF4aW9ydFdWNGJybG4ydis0MkYzYmZFcGEvZ3pHTmg1bkJSYVBnZWh1OXl5?=
 =?utf-8?B?ZllCMmJqUUZURG5zbDZiTSt3UWxxVlVabEk0WjJiL29CT0ZCZkwzcTB2aFFW?=
 =?utf-8?B?NVN4bmhXZ2U3ajRxeGt2NkNvWkd3bWpsVXJOejlXS0Z0RmUwMGM3RkExN2tS?=
 =?utf-8?B?Z0wxUWgra1p2Q2g2a1B3dTZSUkRVUGcwUGdmU1g4V25ocTJDV2Rqc2FrY3N0?=
 =?utf-8?B?dUVGMGpibktmOW93ZlNnbFg1RHJ1NUY4R0FINlhxUWZjY0RXcjF4eU9qdjA4?=
 =?utf-8?B?aXNuMWNJcDZoSExtTG1ET0RkaDVNMDh3QU5jT1FWYm84cGJnUlZObU0vM3NO?=
 =?utf-8?B?OWlzWWMvOVd4M09JbXlaTlhGaUt3N0ZUSHgwWGtnMS9HeTNXditHLy9QUkdV?=
 =?utf-8?B?alJHNEZucVdldDR4bE1rTWJYUVNXSFpyQnlOM2xmZjVBVVdzREVrVnhpck9C?=
 =?utf-8?B?aDQ0eHNjcTF5RmQyWVk4L1RaZHI4T3NtSUsxcVdOek55RmNqOEZjdW5qN2FJ?=
 =?utf-8?B?Ymp5TzFFNnJFUXpmU1Z0TmE2di9tWVRHTzFpdVhMQmtJdE0zMUMzYmxKSDd0?=
 =?utf-8?B?aC9NYUZwemhhVEd1NFJWT29sSE1EM1c3bGVmR2o0bzdVOEZGdWV3R2Z4RXZ5?=
 =?utf-8?B?NnlVbEYrL1ZGWmpRUnNETFNzT3hqMFRnUWJDSjlYSk0xdTFtL0ZiMzZlTzZK?=
 =?utf-8?B?YVhGQmNuT0tyZ25RMmVlR3RSM0YzOGJscHJLaUdvc08yOWtubmxLb1p6OFcw?=
 =?utf-8?B?ZW5ZNVlOOXlxY0FHSS9HQkdWYmpPSWMyL1ppb0IzdzlQRHlwa1djVnRyK2xL?=
 =?utf-8?B?NHdIdXFjcGpLLytzamFBOE9QRW40dW1SbEFVeU9oMDFuMFNUS2RYYm9sUDZJ?=
 =?utf-8?B?aWgydWlHM1ZsY1VZSERWNkk0U3pVNGh1V2QyaXFqeTdDUXlkbEgvWUhDOCtl?=
 =?utf-8?B?amwyaUQwSDc1OTh2RGZUYnZJR01PMFJoUEx5MzlpcmF0cldQajdBSWdCY1Qv?=
 =?utf-8?Q?mBi3dV819firSHQEw5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a3d096-cd0b-459d-e60b-08dea438e909
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:42:27.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFUu3ZnSU4TIwuyDA9QTtMmASLeNse2urJp6dvwUlAxIGOB4lj0rpcsyfEn2wxWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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

On 4/27/26 10:34, Jesse Zhang wrote:
> Add a per-device qword-slot pool covering the firmware-managed NBIO
> SDMA decode window (BAR dwords [sdma_engine[0],
> sdma_engine[0] + sdma_doorbell_range * num_instances)) — the only
> range whose writes are routed to the SDMA back-end.  Kernel SDMA ring
> slots are pre-masked at init.
> 
> The window is exposed to userspace as a custom drm_gem_object: no TTM
> backing, custom .mmap callback that does io_remap_pfn_range from the
> SDMA decode window's BAR address.  Per-fpriv GEM handles for that BO
> can be minted on demand via amdgpu_sdma_userq_doorbell_create_handle()
> so userspace mmap()s through the standard drm_gem_mmap path — no
> file_operations override and no fixed mmap pgoff sentinel.

I can't see how that would even remotely work. We basically would need to distinct on every GEM handle lockup what type of BO we have.

So absolutely clear NAK to that approach.

Regards,
Christian.

> 
> Slots are allocated/freed via amdgpu_sdma_userq_doorbell_alloc/free.
> The init/fini and the AMDGPU_INFO_USERQ_DOORBELL ioctl that uses
> create_handle land in subsequent patches.
> 
> Suggested-by:Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 164 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  55 ++++++++
>  2 files changed, 219 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 321310ba2c08..1c61761c0046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -22,6 +22,8 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_file.h>
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> @@ -200,6 +202,168 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>  	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
>  }
>  
> +static int amdgpu_sdma_userq_db_obj_mmap(struct drm_gem_object *obj,
> +					 struct vm_area_struct *vma)
> +{
> +	struct amdgpu_sdma_userq_db_obj *db = to_amdgpu_sdma_userq_db(obj);
> +
> +	if (vma->vm_end - vma->vm_start > round_up(db->size, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
> +		     VM_DONTDUMP | VM_PFNMAP);
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return io_remap_pfn_range(vma, vma->vm_start,
> +				  db->phys_base >> PAGE_SHIFT,
> +				  vma->vm_end - vma->vm_start,
> +				  vma->vm_page_prot);
> +}
> +
> +static void amdgpu_sdma_userq_db_obj_free(struct drm_gem_object *obj)
> +{
> +	struct amdgpu_sdma_userq_db_obj *db = to_amdgpu_sdma_userq_db(obj);
> +
> +	drm_gem_object_release(obj);
> +	kfree(db);
> +}
> +
> +static const struct drm_gem_object_funcs amdgpu_sdma_userq_db_obj_funcs = {
> +	.free = amdgpu_sdma_userq_db_obj_free,
> +	.mmap = amdgpu_sdma_userq_db_obj_mmap,
> +};
> +
> +int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_sdma_userq_db_obj *db;
> +	u32 base_dw, size_dw, nslots, ring_dw;
> +	int i, r;
> +
> +	if (!adev->userq_funcs[AMDGPU_HW_IP_DMA])
> +		return 0;
> +
> +	base_dw = adev->doorbell_index.sdma_engine[0] << 1;
> +	size_dw = adev->doorbell_index.sdma_doorbell_range *
> +		  adev->sdma.num_instances;
> +	nslots  = size_dw / 2;	/* qword slots */
> +	if (!nslots)
> +		return 0;
> +
> +	db = kzalloc(sizeof(*db), GFP_KERNEL);
> +	if (!db)
> +		return -ENOMEM;
> +
> +	db->phys_base = adev->doorbell.base +
> +			(resource_size_t)base_dw * sizeof(u32);
> +	db->size      = size_dw * sizeof(u32);
> +	db->base.funcs = &amdgpu_sdma_userq_db_obj_funcs;
> +
> +	drm_gem_private_object_init(adev_to_drm(adev), &db->base,
> +				    round_up(db->size, PAGE_SIZE));
> +	r = drm_gem_create_mmap_offset(&db->base);
> +	if (r) {
> +		drm_gem_object_put(&db->base);
> +		return r;
> +	}
> +
> +	mutex_init(&adev->sdma.userq_db_mutex);
> +	adev->sdma.userq_db_bitmap = bitmap_zalloc(nslots, GFP_KERNEL);
> +	if (!adev->sdma.userq_db_bitmap) {
> +		drm_gem_object_put(&db->base);
> +		return -ENOMEM;
> +	}
> +
> +	adev->sdma.userq_db_obj    = db;
> +	adev->sdma.userq_db_nslots = nslots;
> +
> +	/*
> +	 * Mask out the qword slots used by the kernel SDMA rings
> +	 * (sdma_engine[i] << 1 in absolute BAR dwords ⇒ qword slot
> +	 * (sdma_engine[i] - sdma_engine[0]) within this window).
> +	 */
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		ring_dw = adev->doorbell_index.sdma_engine[i] << 1;
> +		if (ring_dw >= base_dw && ring_dw < base_dw + size_dw)
> +			set_bit((ring_dw - base_dw) / 2,
> +				adev->sdma.userq_db_bitmap);
> +	}
> +
> +	dev_info(adev->dev,
> +		 "SDMA UMQ doorbell pool: %u qword slots in BAR dword [%u, %u)\n",
> +		 nslots, base_dw, base_dw + size_dw);
> +	return 0;
> +}
> +
> +void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev)
> +{
> +	if (!adev->sdma.userq_db_obj)
> +		return;
> +	bitmap_free(adev->sdma.userq_db_bitmap);
> +	adev->sdma.userq_db_bitmap = NULL;
> +	adev->sdma.userq_db_nslots = 0;
> +	drm_gem_object_put(&adev->sdma.userq_db_obj->base);
> +	adev->sdma.userq_db_obj = NULL;
> +}
> +
> +/*
> + * Allocate one qword doorbell slot.  On success, *out_slot receives the
> + * slot id (also the qword index inside the userspace mmap of the window
> + * BO) which the caller passes back to free.
> + */
> +int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot)
> +{
> +	u32 slot;
> +
> +	if (!adev->sdma.userq_db_obj || !adev->sdma.userq_db_nslots)
> +		return -ENODEV;
> +
> +	mutex_lock(&adev->sdma.userq_db_mutex);
> +	slot = find_first_zero_bit(adev->sdma.userq_db_bitmap,
> +				   adev->sdma.userq_db_nslots);
> +	if (slot >= adev->sdma.userq_db_nslots) {
> +		mutex_unlock(&adev->sdma.userq_db_mutex);
> +		return -ENOSPC;
> +	}
> +	set_bit(slot, adev->sdma.userq_db_bitmap);
> +	mutex_unlock(&adev->sdma.userq_db_mutex);
> +
> +	*out_slot = slot;
> +	return 0;
> +}
> +
> +void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slot)
> +{
> +	if (!adev->sdma.userq_db_obj)
> +		return;
> +	if (slot >= adev->sdma.userq_db_nslots)
> +		return;
> +	mutex_lock(&adev->sdma.userq_db_mutex);
> +	clear_bit(slot, adev->sdma.userq_db_bitmap);
> +	mutex_unlock(&adev->sdma.userq_db_mutex);
> +}
> +
> +/*
> + * Mint a per-fpriv GEM handle for the per-device SDMA UMQ doorbell BO.
> + * Userspace then uses standard GEM_MMAP / mmap() on /dev/dri/cardN to
> + * obtain a CPU pointer to the routable doorbell window.
> + */
> +int amdgpu_sdma_userq_doorbell_create_handle(struct amdgpu_device *adev,
> +					     struct drm_file *filp,
> +					     u32 *handle, u32 *size_bytes)
> +{
> +	int r;
> +
> +	if (!adev->sdma.userq_db_obj)
> +		return -ENODEV;
> +
> +	r = drm_gem_handle_create(filp, &adev->sdma.userq_db_obj->base, handle);
> +	if (r)
> +		return r;
> +
> +	*size_bytes = adev->sdma.userq_db_obj->size;
> +	return 0;
> +}
> +
>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>  			       u32 instance, bool duplicate)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 2bf365609775..93a7eb9746d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -146,6 +146,20 @@ struct amdgpu_sdma {
>  	bool			disable_uq;
>  	void (*get_csa_info)(struct amdgpu_device *adev,
>  			     struct amdgpu_sdma_csa_info *csa_info);
> +
> +	/*
> +	 * SDMA usermode-queue doorbell pool.  The window covers
> +	 * BAR dwords [sdma_engine[0], sdma_engine[0] +
> +	 * sdma_doorbell_range * num_instances) — the only range that NBIO
> +	 * routes to the SDMA back-end.  Each bit in the bitmap represents
> +	 * one qword slot; kernel SDMA ring slots are pre-masked at init.
> +	 * The window is exposed to userspace as a custom drm_gem_object
> +	 * (userq_db_obj) that is mmap'd via standard GEM_MMAP.
> +	 */
> +	struct amdgpu_sdma_userq_db_obj *userq_db_obj;
> +	struct mutex		userq_db_mutex;
> +	unsigned long		*userq_db_bitmap;
> +	u32			userq_db_nslots;	/* qword slots */
>  };
>  
>  /*
> @@ -185,6 +199,38 @@ struct amdgpu_buffer_funcs {
>  				 uint32_t byte_count);
>  };
>  
> +/*
> + * SDMA usermode-queue doorbell pool.
> + *
> + * The pool re-uses qword doorbell slots inside the firmware-managed NBIO
> + * SDMA decode window (BAR dwords [sdma_engine[0],
> + * sdma_engine[0] + sdma_doorbell_range * num_instances)) — that range is
> + * the only one whose writes are routed to the SDMA back-end.  The kernel
> + * SDMA ring slots are pre-marked so they keep working alongside any
> + * number of SDMA UMQs.
> + *
> + * The window is exposed to userspace via a per-device drm_gem_object that
> + * userspace mmap()s through the standard GEM_MMAP path; per-fpriv handles
> + * are minted on demand by the AMDGPU_INFO_SDMA_USERQ_DOORBELL ioctl.  No
> + * file_operations override and no fixed mmap pgoff sentinel.
> + *
> + * FIXME: KFD's SDMA queue doorbells (kgd_*_hqd_sdma_get_doorbell on chips
> + * with a non-stub implementation, e.g. gfx9.4.3) are computed
> + * from the same adev->doorbell_index.sdma_engine[] array and would
> + * overlap with this pool.  On gfx12 the kgd hook stubs to 0, so there is
> + * no immediate conflict.  A shared per-adev allocator that both
> + * KFD and amdgpu UMQ call into is the longer-term fix.
> + */
> +
> +struct amdgpu_sdma_userq_db_obj {
> +	struct drm_gem_object	base;
> +	resource_size_t		phys_base;	/* BAR phys addr of window start */
> +	u32			size;		/* window size in bytes */
> +};
> +
> +#define to_amdgpu_sdma_userq_db(_obj) \
> +	container_of(_obj, struct amdgpu_sdma_userq_db_obj, base)
> +
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>  			     bool caller_handles_kernel_queues);
>  
> @@ -205,6 +251,15 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
>  				      struct amdgpu_iv_entry *entry);
>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>  			       bool duplicate);
> +struct drm_file;
> +struct amdgpu_sdma_userq_db_obj;
> +int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev);
> +void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev);
> +int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot);
> +void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slot);
> +int amdgpu_sdma_userq_doorbell_create_handle(struct amdgpu_device *adev,
> +					     struct drm_file *filp,
> +					     u32 *handle, u32 *size_bytes);
>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>          bool duplicate);
>  int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);

