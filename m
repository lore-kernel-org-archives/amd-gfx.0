Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D4C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 05:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF852053B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 05:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbDeDyqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF852053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9746E39C;
	Wed,  1 Jul 2020 05:33:50 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE646E39C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 05:33:50 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 22so21031602wmg.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 22:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xGeW9f3Xy+cXNdZdvpjlI7C+XxnILDkPMw2+du1Viio=;
 b=TbDeDyqSXXen0MOW/8BHTvVnAMoc4Sj9aqvmoPZG4QpYQn4DT/vLf0xVDF76Hv0Cn6
 Y0gS9Id8VdvifNQo7EoG3QstJauUKfM5W7SOdHgaYchHGEJtHbBrTk/Ss/ClFxTI6dYJ
 ixEzT5r6EXpW/zt/DJG/62agWloaHGtnIRCylg4QQygZEra+Mdk3iWfu86y6bdH5Pgd8
 /mpAuxr5aXsYYC797jfMTQs6ZUPuMYZsWvImmTAOG6qHVgCIM7BOFUggQJGFNPvaeW7v
 J8siPh9vOoxyEOZdVV73Jm6iujDor5j6JmFyz378OTbyHmyMHJ5yAweMt4OPWPW/4IpR
 BQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xGeW9f3Xy+cXNdZdvpjlI7C+XxnILDkPMw2+du1Viio=;
 b=IEJr/sghXOZ+GVJPcJN4RBRzdGm6sD9Q9TN9WSxkZGVtyKpMdO1o1hz7D5d5DCRPNv
 PJa4dPbiaTLIAUuwyrUdBEGanUmjZT3JpmR+f7EETVCe3yEysSU0fKO4FZ/rmntCxNBR
 iydBbi6xmokjSsxYUwW98/Ktftzks0wvu8r2vArPavYDBRQvSCZk+N23JdNpWHAYB1Z8
 OOYvOIm/mjlocPchuwJ1ax3IJjxLa5J0dxm6x2aUH0HQYW6YLDQCn9kfM2gwQTIiosnA
 lojdlPU+R90b+elrXrM54mGu+yLdApglBJk0xDLXiZrjJ12BvAD8Avygl1veVajGEwJi
 NqIw==
X-Gm-Message-State: AOAM533fpEOQeIwALWlxrNljHGrb3+WAWfSzT7nqWEDzK0c+TqnsRe66
 iUe/npbXbxO2Cc9pEKnpOIRbEb3su5SzeZlhEFz5cw==
X-Google-Smtp-Source: ABdhPJyq0YftvN5rKjnyboWzTjRE72DXm+sUAYvGlBLjIWMcr0KpdnC8BTWfmi4FWOZPXT2oKWly5b+YwT1ZpPUKO9o=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr25290549wmy.79.1593581628570; 
 Tue, 30 Jun 2020 22:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200626140423.1425349-1-alexander.deucher@amd.com>
In-Reply-To: <20200626140423.1425349-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jul 2020 01:33:37 -0400
Message-ID: <CADnq5_MzKqWxOdzGSVUWU3cJaXwXNNB3T0igMP8dyRpLMGpgEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: return an error for hw access in INFO ioctl
 when in reset
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping?

On Fri, Jun 26, 2020 at 10:04 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> When the GPU is in reset, accessing the hw is unreliable and could
> interfere with the reset.  Return an error in those cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 341d072edd95..fd51d6554ee2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -684,6 +684,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
>                 if (info->read_mmr_reg.count > 128)
>                         return -EINVAL;
>
> +               if (adev->in_gpu_reset)
> +                       return -EPERM;
> +
>                 regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
>                 if (!regs)
>                         return -ENOMEM;
> @@ -854,6 +857,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
>                 if (!adev->pm.dpm_enabled)
>                         return -ENOENT;
>
> +               if (adev->in_gpu_reset)
> +                       return -EPERM;
> +
>                 switch (info->sensor_info.type) {
>                 case AMDGPU_INFO_SENSOR_GFX_SCLK:
>                         /* get sclk in Mhz */
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
