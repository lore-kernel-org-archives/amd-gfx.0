Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AAAC38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 14:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E30F10EB32;
	Thu,  8 Sep 2022 14:34:28 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D456F10EB32
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 14:34:25 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 a1-20020a4ab101000000b0044acf001f83so2976394ooo.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Sep 2022 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=3za8w/Kh9FMUewNDWqQO2iVNWIziP8AFXCV79g21n2k=;
 b=IIb/cVLbFQlELFTH20BMIvoiwYWlOZ4OqyP8xldmRWDBhWa7ChA9+ZyzkZOY1MYUot
 XRpHsRlancygT5mwUh1WmanHAaKXLDmWESzRp6ihaWDh/R8BPpPwTN/gZ/cX5GziE3lv
 Icydgb5m/5qZKIzXSV/JYRWA+R7c9ruNWMrpbXjt3t7BiA5QkSJ80aCQ+V9hta6yW+HC
 LpEGlquh6QvbuEQDltT+DQ3aLii11C4XAabHe4FNMfydsrADSXF+hV7zfzD2vngBca52
 2IhIG+C9Rr3Wfc7T41f+pQg7B9S6G3QX0+e0ew2vOAAgvmW4rLrhsc+kWLx3LeOl31wF
 ORkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=3za8w/Kh9FMUewNDWqQO2iVNWIziP8AFXCV79g21n2k=;
 b=U4eB0K1RRzt3Ns8W8ruUI1OiTjMxC/2l8p32p33eHiM24ISXC9rk/n55mmQHTZSWjb
 mQ3QeC+Nrbki3m/GVoxxrg1ksBKdbTeIhf8SUmxbUu7DG6X6BhuteYv1WRQ/B2qYffqI
 11djeiJ/SZMm5kIjIIVHX52jUZOwBDWz0Y5xRp6fxxIMpUweXofcfzenqEMTn/BMLxFr
 wNpnQ0X8xDRLxUjQ842pgNoId0gOlG6Zu8g/O+/AV5YFhUEd3kGbuwa6BKneXzDehTNg
 IVOIoI1je5o+4W64hSXc470Jglqb/myjbG1BE+Ifi8g7OVeuon7/fAARfVYloBDjzWTp
 3s5A==
X-Gm-Message-State: ACgBeo3IF5ffklWLcD4SpaK+8LfLzlLRtgzEDxrdrHsC6+oUvnuiGuFe
 NIvbcwwVi2OLHS28omwd7KcdGRbQK0DRvZqyt4I=
X-Google-Smtp-Source: AA6agR6T2OmHtDYStKlvsAzaM/zHTyRfK/wGkTru5nKbaoGuR6/OTanKQPhYH6qjz2uKLZ8fA3ChG2gs9UJ+A+pApw4=
X-Received: by 2002:a4a:4197:0:b0:467:cd87:bcb3 with SMTP id
 x145-20020a4a4197000000b00467cd87bcb3mr3150365ooa.97.1662647665155; Thu, 08
 Sep 2022 07:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220719183436.1705006-1-alexander.deucher@amd.com>
In-Reply-To: <20220719183436.1705006-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Sep 2022 10:34:13 -0400
Message-ID: <CADnq5_OeOuQ262pk_8naNnKpm-8M_1dBPUm31XjLSk0j-gGSMw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Tue, Jul 19, 2022 at 2:35 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> amdgpu_device_asic_has_dc_support() just checks the asic itself.
> amdgpu_device_has_dc_support() is a runtime check which not
> only checks the asic, but also other things in the driver
> like whether virtual display is enabled.  We want the latter
> here.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index c20922a5af9f..b0fa5d065d50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -514,7 +514,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>          */
>         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>             amdgpu_bo_support_uswc(bo_flags) &&
> -           amdgpu_device_asic_has_dc_support(adev->asic_type) &&
> +           amdgpu_device_has_dc_support(adev) &&
>             adev->mode_info.gpu_vm_support)
>                 domain |= AMDGPU_GEM_DOMAIN_GTT;
>  #endif
> --
> 2.35.3
>
