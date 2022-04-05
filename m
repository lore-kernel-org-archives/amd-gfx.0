Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Apr 2022 06:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250AD10ED21;
	Tue,  5 Apr 2022 06:45:22 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE35F10ED21
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Apr 2022 06:45:20 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8ff.dynamic.kabel-deutschland.de
 [95.90.232.255])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F45F61E64846;
 Tue,  5 Apr 2022 08:45:18 +0200 (CEST)
Message-ID: <7a0e9d4c-257f-287e-9caf-f4161887ba39@molgen.mpg.de>
Date: Tue, 5 Apr 2022 08:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Add missing NULL check in
 svm_range_map_to_gpu
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>
References: <20220404214255.11902-1-Philip.Yang@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220404214255.11902-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Philip,


Am 04.04.22 um 23:42 schrieb Philip Yang:
> bo_adev is NULL for system memory mapping to GPU.
> 
> Fixes: 05fe8eeca92 (drm/amdgpu: fix TLB flushing during eviction)

Sorry, where can I find that commit? I do not see it in drm-next from 
agd5f git archive git@gitlab.freedesktop.org:agd5f/linux.git.

     $ git log --oneline -1
     e45422695c19 (HEAD, agd5f/drm-next) drm/amdkfd: Create file 
descriptor after client is added to smi_clients list


Kind regards,

Paul


> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 907b02045824..d3fb2d0b5a25 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1281,7 +1281,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   					   last_start, prange->start + i,
>   					   pte_flags,
>   					   last_start - prange->start,
> -					   bo_adev->vm_manager.vram_base_offset,
> +					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>   					   NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
