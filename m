Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33ADC2BB55
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84F02076D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84F02076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A67F6E14F;
	Wed,  8 Apr 2020 15:46:51 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0227.hostedemail.com
 [216.40.44.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761916E148;
 Wed,  8 Apr 2020 15:37:22 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5739A18041E93;
 Wed,  8 Apr 2020 15:37:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bone48_22e7092f25135
X-Filterd-Recvd-Size: 2637
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf12.hostedemail.com (Postfix) with ESMTPA;
 Wed,  8 Apr 2020 15:37:19 +0000 (UTC)
Message-ID: <bfa1a07f6f2046d5edac80d282cc710328d84d72.camel@perches.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add prefix for pr_* prints
From: Joe Perches <joe@perches.com>
To: Aurabindo Pillai <mail@aurabindo.in>, alexander.deucher@amd.com, 
 christian.koenig@amd.com
Date: Wed, 08 Apr 2020 08:35:20 -0700
In-Reply-To: <20200408133735.7679-1-mail@aurabindo.in>
References: <20200408133735.7679-1-mail@aurabindo.in>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 08 Apr 2020 15:46:50 +0000
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
Cc: airlied@linux.ie, avid1.Zhou@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2020-04-08 at 09:37 -0400, Aurabindo Pillai wrote:
> amdgpu uses lots of pr_* calls for printing error messages.
> With this prefix, errors shall be more obvious to the end
> use regarding its origin, and may help debugging.
> 
> Prefix format:
> 
> [xxx.xxxxx] amdgpu: ...
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
[]
> @@ -28,6 +28,12 @@
>  #ifndef __AMDGPU_H__
>  #define __AMDGPU_H__
>  
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) "amdgpu: " fmt
> +
>  #include "amdgpu_ctx.h"
>  
>  #include <linux/atomic.h>

All the embedded uses of "amdgpu:" in logging
messages should also be deleted.

$ git grep -P '(?:dev_|pr_).*"amdgpu:' drivers/gpu/drm/amd/amdgpu/
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PT BOs\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PD\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:                       pr_err("amdgpu: failed to kmap PD, ret=%d\n", ret);
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched on\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched off\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:                        dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:          dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:          pr_warn("amdgpu: No suitable DMA available\n");
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:          pr_warn("amdgpu: No suitable DMA available\n");



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
