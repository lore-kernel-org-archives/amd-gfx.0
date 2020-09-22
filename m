Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14DC2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3CC2220D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9x082tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3CC2220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21A76E84B;
	Tue, 22 Sep 2020 15:39:34 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7646E84B;
 Tue, 22 Sep 2020 15:39:32 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q9so3817699wmj.2;
 Tue, 22 Sep 2020 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+DDHh48hUhaZM9vXx+KNvw8NfXShcDtMcHxV9xxIOts=;
 b=V9x082tFsavECxmKgNMIK9Wq1WWUsqy/d69/S+J2gvE5b2H723klZEisQ60MVgW4Qi
 bmL/zxtUvGA5YhoErIhGZC0zyH+q1iIRBZvrSQVEqTKoSlUCP+ieT1SE9WdiLyhVGS13
 0QA8x2nJI3hruNv6pQJdKAXnvaiuR3mRCzBDzmqvw+dkx20/dKtlGPK3H+Za8w73s2kB
 etExTz7+7nw6Wbded+nlyg71BToKGzsNJnpIR5ZfMs2rmaDT0xbiU76fSZaectXwozLP
 nHWQrmK5u6NW5GxfchIv72aQpMXlb10nUI3pF5QdPv/BaaUzFVz9cuxiCIINQehNw9T9
 OKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+DDHh48hUhaZM9vXx+KNvw8NfXShcDtMcHxV9xxIOts=;
 b=HD29Chyo62vj3XxwhHF4n8OVRKYZuKc+ZrHCOw/NhIMX44y95oL1Xz6W/h04FKViVy
 MIb7fiK6fNMsqrVpSpvVuAy6FzaDNmTgVG+zceAwHfm0NN7QE083jDDkf2umfXbssW+3
 +fq2PENQk7Z9KftF7tCH9aw+eLmxfzv8oBSUGKawDXFHlixNSDMf3mvy+r6UTxSNw0CW
 61JlVkAFhYZO83mJTPn3bVWVCVu7BeTUStxW46yeOCKrEitFhP4mAI+CW9/veHayDjBv
 TLxIzg9bFC5HjmriOzwZpsW6UfH8RE97hyKZgB8xU/aRF3SYqzTZv7r5qzCBrGv5/nt8
 I4uQ==
X-Gm-Message-State: AOAM533QdizyUQC5XFiEYfy0Ims7Pjy84O525CK6edyBUcffiFXo0+nH
 3nzbjsVkxE1ltADwHZRh+IPZSy/RaLwJ0SBEl84=
X-Google-Smtp-Source: ABdhPJxOUJWknVLKUhCLW7xnXjLZyic+3stY5q2umXf20WkebOVMhD3AnwCsYAxz/rRo/Ey7dj3LYpsMveqbF3JMdX4=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr1633913wme.39.1600789171418; 
 Tue, 22 Sep 2020 08:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200922124029.27500-1-bernard@vivo.com>
In-Reply-To: <20200922124029.27500-1-bernard@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2020 11:39:20 -0400
Message-ID: <CADnq5_ODhc7PuiT6OY5hh1bLdR74iVYRnR1fWR2jZHtobdLr2g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon:fix typoes in comments
To: Bernard Zhao <bernard@vivo.com>
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
Cc: opensource.kernel@vivo.com, David Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Sep 22, 2020 at 9:11 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Change the comment typo: "programm" -> "program".
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/radeon/uvd_v1_0.c | 4 ++--
>  drivers/gpu/drm/radeon/uvd_v2_2.c | 2 +-
>  drivers/gpu/drm/radeon/uvd_v4_2.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c b/drivers/gpu/drm/radeon/uvd_v1_0.c
> index 800721153d51..58557c2263a7 100644
> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> @@ -117,7 +117,7 @@ int uvd_v1_0_resume(struct radeon_device *rdev)
>         if (r)
>                 return r;
>
> -       /* programm the VCPU memory controller bits 0-27 */
> +       /* program the VCPU memory controller bits 0-27 */
>         addr = (rdev->uvd.gpu_addr >> 3) + 16;
>         size = RADEON_GPU_PAGE_ALIGN(rdev->uvd_fw->size) >> 3;
>         WREG32(UVD_VCPU_CACHE_OFFSET0, addr);
> @@ -360,7 +360,7 @@ int uvd_v1_0_start(struct radeon_device *rdev)
>         /* Set the write pointer delay */
>         WREG32(UVD_RBC_RB_WPTR_CNTL, 0);
>
> -       /* programm the 4GB memory segment for rptr and ring buffer */
> +       /* program the 4GB memory segment for rptr and ring buffer */
>         WREG32(UVD_LMI_EXT40_ADDR, upper_32_bits(ring->gpu_addr) |
>                                    (0x7 << 16) | (0x1 << 31));
>
> diff --git a/drivers/gpu/drm/radeon/uvd_v2_2.c b/drivers/gpu/drm/radeon/uvd_v2_2.c
> index 23b18edda20e..6266167886d9 100644
> --- a/drivers/gpu/drm/radeon/uvd_v2_2.c
> +++ b/drivers/gpu/drm/radeon/uvd_v2_2.c
> @@ -109,7 +109,7 @@ int uvd_v2_2_resume(struct radeon_device *rdev)
>         if (r)
>                 return r;
>
> -       /* programm the VCPU memory controller bits 0-27 */
> +       /* program the VCPU memory controller bits 0-27 */
>         addr = rdev->uvd.gpu_addr >> 3;
>         size = RADEON_GPU_PAGE_ALIGN(rdev->uvd_fw->size + 4) >> 3;
>         WREG32(UVD_VCPU_CACHE_OFFSET0, addr);
> diff --git a/drivers/gpu/drm/radeon/uvd_v4_2.c b/drivers/gpu/drm/radeon/uvd_v4_2.c
> index dc54fa4aaea8..f9e97fa63674 100644
> --- a/drivers/gpu/drm/radeon/uvd_v4_2.c
> +++ b/drivers/gpu/drm/radeon/uvd_v4_2.c
> @@ -40,7 +40,7 @@ int uvd_v4_2_resume(struct radeon_device *rdev)
>         uint64_t addr;
>         uint32_t size;
>
> -       /* programm the VCPU memory controller bits 0-27 */
> +       /* program the VCPU memory controller bits 0-27 */
>
>         /* skip over the header of the new firmware format */
>         if (rdev->uvd.fw_header_present)
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
