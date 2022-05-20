Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8F1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 13:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9FA10F07D;
	Fri, 20 May 2022 13:29:44 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1093010F07D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 13:29:44 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id s188so6153162oie.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/n2APKkZ7fk2+5lAvGjOLrDcPmluLEo0uY38RVTB878=;
 b=hswlc4VWdByjiYmySw3Ty/ypKDigLCS3I/NF6gcWJxCw+HNzcki0LPhqS0+F2Oeq9e
 QLsQ/z+hGm0GXua+SwjMGNhYn0u6APfCjeDZvWXk9n1SlZqoGBg9M5GdQ0J/w9jMYhNB
 JKaMxHv7gH6zhd5DYabs5DFEKygqKojJ8BHzYNRSb7sTrAyJEcH359HljcmKI2wKuUql
 K+xAk4clstjJkVnN/yYkuZBO2lubq+u1UdmTsWz8m809Ci/afA5u7sXh2n/Ne50rohXj
 rePi82eEWhzGBhxEoxTXg2GZ9hA0wtGoEx7bwblZMV4bHNIp1YLoQNg/5HIHKdDK3Jee
 jkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/n2APKkZ7fk2+5lAvGjOLrDcPmluLEo0uY38RVTB878=;
 b=F69SNO+J0ar00WCZkgdIQhZZqnhnUEvstxcaWA+JBhjzu92G5jNlLytl4x6w8I6+To
 bP28tMH0OcK1y0c1JvJGc9bfvb1GAVfFWJ3ohISbr1F1uQvJWrX6iL0+T8ILKvUu6Qpw
 cvTCJlRqEqMa8OPm0qVBN/gGLVIWlI8CAzkVQYDAneijZQ+egEHmKkMX609UG2NNOVCO
 m40tGX8plMapm+UFOqLy+GpbJrHGACh4p9WZ0dD36rmIwkSq+w/DaN8nEPNqDRVSWppG
 SJlocqq6TpRw6LxJhLBWvUneU95Cl1c5zRDQ5mF9Id/PRs2PVi1A2OHt3d2CaIVGJeot
 xpNQ==
X-Gm-Message-State: AOAM533DlvdlirmMYYzUhTu7BDe4c2Bq4EDrpU+ubGJL84wWejJQv34q
 eNqTImn/6AGdbY6mHnz0lKf8Ix0+VHbFDTjCRAM=
X-Google-Smtp-Source: ABdhPJx3h20FnidwOJEwgdJpceGhJ9Wt3Sqg9LSimstQ/S95Fwelwnkk0u+PQxkwzyIDgc6ZsI2famj7NrgN4AxMKe0=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr5414471oib.200.1653053382327; Fri, 20
 May 2022 06:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220520075932.186691-1-danijel.slivka@amd.com>
In-Reply-To: <20220520075932.186691-1-danijel.slivka@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 May 2022 09:29:31 -0400
Message-ID: <CADnq5_P8p5zKiW20xek0M0DVs+YRDX6qcy+b01NWXP_NUs9O5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is enabled
To: Danijel Slivka <danijel.slivka@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 20, 2022 at 3:59 AM Danijel Slivka <danijel.slivka@amd.com> wrote:
>
> In case virtaul_display is enabled there is no hw DCE so
> need to skip setting up fbdev.

Wouldn't you theoretically still want fbdev even if it is virtual?

Alex

>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3b9dc1803be9..8d03eec49eef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2095,6 +2095,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>          * 2. don't init fbdev if there are no connectors
>          */
>         if (adev->mode_info.mode_config_initialized &&
> +           !adev->enable_virtual_display &&
>             !list_empty(&adev_to_drm(adev)->mode_config.connector_list)) {
>                 /* select 8 bpp console on low vram cards */
>                 if (adev->gmc.real_vram_size <= (32*1024*1024))
> --
> 2.25.1
>
