Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F824C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537A360527
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 537A360527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92966E992;
	Thu, 28 Oct 2021 15:19:40 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBAE6E992
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 15:19:39 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef59.dynamic.kabel-deutschland.de
 [95.90.239.89])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 60C4061E64846;
 Thu, 28 Oct 2021 17:19:37 +0200 (CEST)
Message-ID: <9a249627-87e1-ab04-ce9c-f2e130ca19eb@molgen.mpg.de>
Date: Thu, 28 Oct 2021 17:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] drm/amdgpu/gmc6: fix DMA mask from 44 to 40 bits
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, it+linux-iommu@molgen.mpg.de
References: <20211028142144.210568-1-alexander.deucher@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211028142144.210568-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Dear Alex,


On 28.10.21 16:21, Alex Deucher wrote:
> The DMA mask on SI parts is 40 bits not 44.  Copy
> paste typo.
> 
> Fixes: 244511f386ccb9 ("drm/amdgpu: simplify and cleanup setting the dma mask")

This was present in Linux 5.4-rc1. Can it also be the cause of some of 
the crashes with the AMD Ryzen systems like Bug 206487 - Random 
freezes/crashes with enabled C-State C6 - AMD Ryzen [1]? I know, there 
were also some things with Linux 4.19.57, but, if my memory serves 
correctly, they were much more often with Linux 5.4. Some crashes had 
MCE and other did not, some froze the system, some rebooted it.

> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
> Acked-by: Christian König <christian.koenig@amd.com>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 0e81e03e9b49..0fe714f54cca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -841,12 +841,12 @@ static int gmc_v6_0_sw_init(void *handle)
>   
>   	adev->gmc.mc_mask = 0xffffffffffULL;
>   
> -	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> +	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
>   		dev_warn(adev->dev, "No suitable DMA available.\n");
>   		return r;
>   	}
> -	adev->need_swiotlb = drm_need_swiotlb(44);
> +	adev->need_swiotlb = drm_need_swiotlb(40);
>   
>   	r = gmc_v6_0_init_microcode(adev);
>   	if (r) {
> 


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=206487
