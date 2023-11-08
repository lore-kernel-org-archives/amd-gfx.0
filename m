Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8698AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 23:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AEF10E88C;
	Wed,  8 Nov 2023 23:21:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB71A10E88F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 23:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf1Tccw8WoncnAhRSHXe77s8BafYXcZ+ar9vnb2lL073ZZJyLqFXDJSp1JZj7F9CMmv27xMWlO6SCTS0U2pQnPynuebbb9HCa8Ys5kSAieJQ3C0I2eMMYVOBie4n3EO6HDwsA5sYVR/eoTkZAZFvVzL3E7NDk7mFYQvj+Iv+vwJl2dV6Syee/CZzB9jS9SMYZchB4QhWNBAtsMkLwX6mtJ3h+1tj3Ns3XEbjwZxQp+1K5yIW5PV/pQuz77cNojGR47LVtNsAjf5KLmMtV0tJWuCcmP0oEKlHO43NDSlzCXdbQxObksLqK5sxnje7XTRrEUE0ToXRHdDJC30xsaIRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQUUiC00eoBD1IJUOiWGjMtEaQPBNTmGCyQ9ngwpmoQ=;
 b=STMiEskmIMdA9Loz0AkZFmPRaW3PFVSh2AVQRFgXfX9ZymeBDNXw13fB39c5WlItI1i1wS63be4a3CF7EKSv19UXxWr7b3Fxi8JYnwmlPWMeAXXJ7zXCaMIRj2iCyCSr/rKFMYwd+RLWhagVRg+1oHoAvgglc7foqZM0VQ6raPVdT0rwdj8LfL96VBF/edtdedpTKTt5VBgb+L9fJMgMzrUjAUZ03U5YESKijJ14aWSlJ4guyKBVWw7Bl8o1lZjwqvrxAMB9yQV5h6FviB+ecw2Z//gCO9m7uiIJyIjq6IcG8X2napM1ukppsTvgPJgisutloetNNMyd47kIVGiMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQUUiC00eoBD1IJUOiWGjMtEaQPBNTmGCyQ9ngwpmoQ=;
 b=1mt99wcFXoNFeZZ8J9gV44WAkQ0OiatCJesEh+3YOmtV6p/fsnVF94E0D+nDyOhw7zGfddP9STil/oAwywtUtXty6/gl/EY8U+1Cng8+hXFXLfKdo+oUH4mjVn/6l2M2AvsCx/kSZb3l0FoBNBAFTjDZvct+oX7ELySQ09vxyww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Wed, 8 Nov 2023 23:20:32 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9578:681f:c050:51b9]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9578:681f:c050:51b9%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 23:20:31 +0000
Message-ID: <feedeec2-e6ca-f1c1-77db-db0cd6305428@amd.com>
Date: Wed, 8 Nov 2023 17:20:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-5-Felix.Kuehling@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20231107165814.3628510-5-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:806:d3::31) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DM4PR12MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: e63bd260-5866-4c28-bf02-08dbe0b14d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36cnhSpw1BCrFucUnW6MCOFnXSIpXZi4Y9wFS1ZTvOSItImS0GCJuFcV+cUh3Lt/y/bUKnYceZ1ogC82MYv/S4kpnW5y5vzdPLyUrPa1Xc9vCIBzz+zpk8QWSAlAsRoS1iU+spz1DnO+dhu3Q7cobhAtb4xQb83IrDnh/uJKBUiuxi73+ReiFBRmS6Vtc68CwfrVIDGnfBc1tP+g8Acu7Mtcbn8YpP1n6xpdO/iEJ0AyX89Hwvbrcg1GwGFboZ+bMXONA+Ee4YogLu7kmVXMJPfYekkILLXjJpa5Bi6/YqLM7G7vXoCMRi4xJlBUsGQ1iJIvZnxFCvu24OjBaSUoOJdQJSIj3i0DWcT+JICoi+dt9ompCHZ/pZ7Y/PFWUmgpFKbjQPZbgFv5gKiC7XHDu9SnAEPbrR71bkh/BQ2giPkaGff4P6scZwBcNiKXv9MxjIZuXE8cFUb3aAEajyVsUx5TP3zDv08fJLKtH/Vga6zp9mLL72ORTKee0ZwfH0eJ5psKVwBQuZMLNWJz30Wv3WPKaqulFEp47iKCxy/wATwbT5P5S9t+2yTsHEzJ9FJn3CubXxwDkZsHhk0UeBSz/3TvXHpyOCY3JlePHePrJPk89LluxOmhvwyKs23w1Uu9DzD1Y6VqM6f5lJET1UfqMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6666004)(6506007)(53546011)(83380400001)(38100700002)(31686004)(2616005)(6512007)(66946007)(86362001)(41300700001)(2906002)(36756003)(66556008)(4326008)(8936002)(8676002)(5660300002)(31696002)(66476007)(316002)(26005)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ZBQnh0TzlXS1dWVDQza0tYbUVqMmV2OEdrcmU5ZDM1UVE1QVZ0SnZscjg3?=
 =?utf-8?B?ODVqemx0V09TMkZyejBZSDRxSDN6cVpCalFDdFFjQVpaUHhRS2NMSW50eGtm?=
 =?utf-8?B?V0Z0bkhva3JvN0RWOWc2cCtIWFZGck9VOU1ueE8zcGt4VXBCcE4rVUhGMmpG?=
 =?utf-8?B?bWFxaEtCS1E1b3FCbWpIbWh6NDl1Y0ZyRFBmQmtSQ2x2OGVVaW9Td3VYK1Q3?=
 =?utf-8?B?VU5CZmtuc2xPbFZ6WjBqQUFuM1NHS01neUZ0S3N2YmdueDJTdmpkcW9GbmJT?=
 =?utf-8?B?VFY1ZTR1bHpUNU1RMjVLWVpCZTF3SU9HWTlVWDhsVDJTMTRENHA3TXIvTDBB?=
 =?utf-8?B?UkJ3QUhtaWZ3R3RZaHk0TmpjSWlaNjJvRG1nYTZRUVBHdjZWZTY0TFhVNXBB?=
 =?utf-8?B?ZVpQZmdteHFUSFpTdUxaNkRqUElwZTVNOFVIN3ArL2dNUnhhNlR2ZzgzS1Vz?=
 =?utf-8?B?eDh4VlJSelBseWVUZVQ1bm1VL1FXWWlaVWFFSzBGYi8zNlp0ZG5kRnRzWFNE?=
 =?utf-8?B?d3AxazJJSERQam5FOHBLTG8yMDBrOU16Z3hNRkRrdUFlZHh1cmpoWUpLTVJi?=
 =?utf-8?B?M0ZQd2ZVVkNTOHEwNUp0TmtrVDNrelEwby80SzJXSGJPaXF3aTMyWE1MVUth?=
 =?utf-8?B?TTcwdTFoc3VlZkZ5T09lalUrS2paRnJqbXAvei9xYVJJY1JGOFM5cUwxTExy?=
 =?utf-8?B?UTVpSDVGYk5zRjNBeHJENlZVeXB1VVQyYS9qUlM3SnpXNXpFa2dPWXExOTNZ?=
 =?utf-8?B?ZzhaUUdwNUtqbm1tTG5GdlQ4VUpycDh4UlZhZTVYeEJzWnY1OHZTSjJSRmNp?=
 =?utf-8?B?akRYMS9uLy9lazFQQXdTRmJxNElqSWRxNHpZUW0yZDJnNVZCWDZlSnQ1MjNz?=
 =?utf-8?B?bTY2OHdHdWRUZWxLSmFNZ2NQS3NFTjZDOURURlc1M0tPSHA1N2taOWF5TzY5?=
 =?utf-8?B?ZHJzNmFBRmsraHBJOUV4cHFLZjB3T2ZsMnQvS3hGdzFDeWZsOUdza0FkK09K?=
 =?utf-8?B?VXk3OEowS1FqL1QzQVlzZTl5enREdmdSVkN0MjF5REtuWk5lWUxYbWxaK3RH?=
 =?utf-8?B?czNVNk9STWFCcnE2NC9sc3FNNC82NjI5L0hqN0pwdTI4S2lhdUdEd0NTa0hD?=
 =?utf-8?B?ODJaaDV6Zlo0NHp0WnllcldZSzZ6K1VkcERBOVc4MlF5UGZaT2pveEFROHQy?=
 =?utf-8?B?WE1rR2FTZ2ZHRm9PekFrM081ZHF2QlpPdk5TZk5BdHJTWE9qTWNWR2lCNWZJ?=
 =?utf-8?B?SXl5K0IwQzl5U2xNMzBTY2xWcXBSMlhmdDNhaUJla1RZcEFST0lpMVRnbEF5?=
 =?utf-8?B?ZHU3UzNRbkxhck52WEw3NC9NYVByOU9KZDF2S2FHWUh0NHVtTEVpVjM3TUxN?=
 =?utf-8?B?YXl6YmlnY3pVaXFRSHlTUHJoR082SjVlS3RwZG9Ic3NEZExqSk1mMGdXVUVm?=
 =?utf-8?B?VUU3L0MvcDdZMFNGSFhqaE5uRVZtNFIwUnNLNm5aY1pSWHpzcUVpcVByOTB4?=
 =?utf-8?B?c09RL29aVmdDc0RxL01jZnRKYUxHWjZnYU03MnloTUxhUjFwTjNEVXQvUnU5?=
 =?utf-8?B?MUY2K1IzbUpwUHNVZm9pemJkRkZPMERVZnljVFo1K0M3UEpPS1J4RHRyR0sy?=
 =?utf-8?B?R1FPTE1CNDBscC9YUEdBNEVqQUV6YzU2b0xkZmRXWk1JRTNXYVExU013VVFT?=
 =?utf-8?B?YVIwb1NsNUljbWRWK3QzOEExU2k3OHpCWmJscGdsc2VYVzZGUUpwQjJVOGhB?=
 =?utf-8?B?dFdFT0wvYTZxZ3U5NnNoQUpRcDgxOEE4REQ5QTliSSs3cXpIMm9CRlovb21H?=
 =?utf-8?B?Nnh0aHBkV2szVy94ajN4WHJXVnVpbExRTGZGb3Y0T28xS0lTSXliWUtnblFP?=
 =?utf-8?B?QWUyYWxlMkZIWEMvZUhvcUlMRlNqSEo5aVJPTXhxS082WUhLZGZNTE1ocnJn?=
 =?utf-8?B?MnVCNGZiNXc3UVN2OURXZVlTTEd5SzYxdWE2cjV1Nm9LK0tUSlhueEhqMXJP?=
 =?utf-8?B?dEpWa0NibzdQOHIyZU8wS2dhdFpwcmk5bzJNRlJNOHRFaUxCQ0NQSEp3aC8z?=
 =?utf-8?B?Z3NPKzY3cDA1TG5GRnJ3aUp3MjFuM2QrVTg5RDJ4emQ2SmQ5dTRtdWhPZXgy?=
 =?utf-8?Q?xAvA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63bd260-5866-4c28-bf02-08dbe0b14d36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 23:20:31.3940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3b/rcLJy9pM7DXXdLwJ4leheDl1R7Cdz5Twhm+bL6yCNvx8JeVHj+3TDHhuoM1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
Cc: ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/7/2023 10:58 AM, Felix Kuehling wrote:
> Use drm_gem_prime_fd_to_handle to import DMABufs for interop. This
> ensures that a GEM handle is created on import and that obj->dma_buf
> will be set and remain set as long as the object is imported into KFD.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  9 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 64 +++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 15 ++---
>   3 files changed, 52 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4caf8cece028..88a0e0734270 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -318,11 +318,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence **ef);
>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>   					      struct kfd_vm_fault_info *info);
> -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> -				      struct dma_buf *dmabuf,
> -				      uint64_t va, void *drm_priv,
> -				      struct kgd_mem **mem, uint64_t *size,
> -				      uint64_t *mmap_offset);
> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
> +					 uint64_t va, void *drm_priv,
> +					 struct kgd_mem **mem, uint64_t *size,
> +					 uint64_t *mmap_offset);
>   int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
>   				      struct dma_buf **dmabuf);
>   void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4bb8b5fd7598..1077de8bced2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2006,8 +2006,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   	/* Free the BO*/
>   	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> -	if (!mem->is_imported)
> -		drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
> +	drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);

A minor thing for this patch: I think this is a correction for last 
patch " Export DMABufs from KFD using GEM handles". mem->gem_handle is 
created unconditionally at amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu.  
drm_gem_handle_delete should be put at the lat patch.

Regards

Xiaogang

>   	if (mem->dmabuf) {
>   		dma_buf_put(mem->dmabuf);
>   		mem->dmabuf = NULL;
> @@ -2363,34 +2362,26 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> -				      struct dma_buf *dma_buf,
> -				      uint64_t va, void *drm_priv,
> -				      struct kgd_mem **mem, uint64_t *size,
> -				      uint64_t *mmap_offset)
> +static int import_obj_create(struct amdgpu_device *adev,
> +			     struct dma_buf *dma_buf,
> +			     struct drm_gem_object *obj,
> +			     uint64_t va, void *drm_priv,
> +			     struct kgd_mem **mem, uint64_t *size,
> +			     uint64_t *mmap_offset)
>   {
>   	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> -	struct drm_gem_object *obj;
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	obj = amdgpu_gem_prime_import(adev_to_drm(adev), dma_buf);
> -	if (IS_ERR(obj))
> -		return PTR_ERR(obj);
> -
>   	bo = gem_to_amdgpu_bo(obj);
>   	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
> -				    AMDGPU_GEM_DOMAIN_GTT))) {
> +				    AMDGPU_GEM_DOMAIN_GTT)))
>   		/* Only VRAM and GTT BOs are supported */
> -		ret = -EINVAL;
> -		goto err_put_obj;
> -	}
> +		return -EINVAL;
>   
>   	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> -	if (!*mem) {
> -		ret = -ENOMEM;
> -		goto err_put_obj;
> -	}
> +	if (!*mem)
> +		return -ENOMEM;
>   
>   	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
>   	if (ret)
> @@ -2440,8 +2431,41 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>   	drm_vma_node_revoke(&obj->vma_node, drm_priv);
>   err_free_mem:
>   	kfree(*mem);
> +	return ret;
> +}
> +
> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
> +					 uint64_t va, void *drm_priv,
> +					 struct kgd_mem **mem, uint64_t *size,
> +					 uint64_t *mmap_offset)
> +{
> +	struct drm_gem_object *obj;
> +	uint32_t handle;
> +	int ret;
> +
> +	ret = drm_gem_prime_fd_to_handle(&adev->ddev, adev->kfd.client.file, fd,
> +					 &handle);
> +	if (ret)
> +		return ret;
> +	obj = drm_gem_object_lookup(adev->kfd.client.file, handle);
> +	if (!obj) {
> +		ret = -EINVAL;
> +		goto err_release_handle;
> +	}
> +
> +	ret = import_obj_create(adev, obj->dma_buf, obj, va, drm_priv, mem, size,
> +				mmap_offset);
> +	if (ret)
> +		goto err_put_obj;
> +
> +	(*mem)->gem_handle = handle;
> +
> +	return 0;
> +
>   err_put_obj:
>   	drm_gem_object_put(obj);
> +err_release_handle:
> +	drm_gem_handle_delete(adev->kfd.client.file, handle);
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 4417a9863cd0..1a2e9f564b7f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1564,16 +1564,11 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   {
>   	struct kfd_ioctl_import_dmabuf_args *args = data;
>   	struct kfd_process_device *pdd;
> -	struct dma_buf *dmabuf;
>   	int idr_handle;
>   	uint64_t size;
>   	void *mem;
>   	int r;
>   
> -	dmabuf = dma_buf_get(args->dmabuf_fd);
> -	if (IS_ERR(dmabuf))
> -		return PTR_ERR(dmabuf);
> -
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
>   	if (!pdd) {
> @@ -1587,10 +1582,10 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> -	r = amdgpu_amdkfd_gpuvm_import_dmabuf(pdd->dev->adev, dmabuf,
> -					      args->va_addr, pdd->drm_priv,
> -					      (struct kgd_mem **)&mem, &size,
> -					      NULL);
> +	r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, args->dmabuf_fd,
> +						 args->va_addr, pdd->drm_priv,
> +						 (struct kgd_mem **)&mem, &size,
> +						 NULL);
>   	if (r)
>   		goto err_unlock;
>   
> @@ -1601,7 +1596,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   	}
>   
>   	mutex_unlock(&p->mutex);
> -	dma_buf_put(dmabuf);
>   
>   	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
>   
> @@ -1612,7 +1606,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   					       pdd->drm_priv, NULL);
>   err_unlock:
>   	mutex_unlock(&p->mutex);
> -	dma_buf_put(dmabuf);
>   	return r;
>   }
>   
