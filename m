Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9B0E81A3C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C17B10E08D;
	Mon, 16 Feb 2026 15:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nGfvKh91";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F20E10E081
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:39:31 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2b866f98574so238344eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 07:39:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771256371; cv=none;
 d=google.com; s=arc-20240605;
 b=eMvfpYnApkxXP7NFO/AMvkdTOgtWcBlScqaM1Kbksc69t5wM4ZAX/dKe2eazWrgGpC
 c+Cd2dnVph1YTU8pA5oRILq7uHDlY2u4ngJFXpac/6Zbak0rijlPEhMaLMdejXHNSn7g
 OSnFTV4KjCun885KzxwcbiED/lcb4o+pvf7fzB+ncEkaZAzk17hqA4KUwEvMp4dOR4QC
 4YjGfTJ1ZaxslCP/WqqluMDL8tqn3tlo+S1ugBSV/JVbkUnI01FHoMvealFyq8/n/Ea0
 CuASpzg7aZy/nXRF8RO3pyp60GYKfeNYQPbuzYd1G4zO5DM+HpsmuyXP1mAqknGQD5bj
 aXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ob2CEqEmP3Zi8vE7TSabzak1pONCQRxWk1dG5MIku6s=;
 fh=DABbUURGM9TMLtwBuDRETB23as3ygsuRRCdK0T2f/rw=;
 b=NIzd/9SkMJW4khQWUEy+9YmVqHzIdQjYHTMtv40dQKQtWhNd7NO/Lz5Obxt0axr3Z6
 8E/k2cPnKGMMVV4VZFjpagnfQe0rhW1ia4TA2DO+71jU3QZWMcHiW9tT5+ILd+4leGP7
 nZyf5NwULXKgpH9ByomXE5bVJFfNmHmCLtipcGemqMDl4wJu+2buH9Byc9UhQ7ljgdVc
 64DWeSwvY1DK0BcJXtkxrr4UsiXZqVHX1b4vY8HazUtBfVj/CPes0lq+pIGVrzdbZHye
 r6DjtoytEao6yKLEJ7my030yqWjih8qzJGsqwMtANu+LVsgIwEwRBSovG7z2hhlRfiba
 8Y7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771256371; x=1771861171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ob2CEqEmP3Zi8vE7TSabzak1pONCQRxWk1dG5MIku6s=;
 b=nGfvKh91gQfq/IWoQ1Prrg95JK2gQY0fh50p7nQoQJ3zib8zhjDjniQevucGj90KFz
 VtKyQrlf+eAowa2YkU1OpUQyHG55kkjjMehdLQnPKevKuqMY0/Jd0G4uqiVVJEXpK2cy
 uFVxKK4/7JAqMBAWzsnrMJNDgnIQdRprTYzUsztNXC+z4K2jtShFfajWwynX9Iz3jizd
 jz0L20OsddF1z5e6IuYnQZCpIhU5T56by1w5qSu6xAXWfD2oEUbeDHa1zeR5YDijAjou
 xG0gSHcPp2WkmTiZoYA5sYU79E5UOD2M8Gc0dhAGGFLiXPJhRXeyzjU6rE9zEGblgn+9
 bnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771256371; x=1771861171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ob2CEqEmP3Zi8vE7TSabzak1pONCQRxWk1dG5MIku6s=;
 b=djRqsu/a/C033PI1Kep2XRAa8QcPLVoO79HGrln+bqr8E1pY/ifSlE3r0odrtxZqPB
 rWYIF0xozOc368skhfIT6kfi9665RWSBVK00/pr+CRF87/+GcJW2N43x7zOBaRtYaFPl
 Y+Ichs19NpK2uWjv2ejhN9aZOLE6CZbP961xHHeTadspiZyN52o6I3sQ8/nuuvsODCzP
 yej16Yl7Mp2abyCApSDiSrpHIbYRNEEUZUXHoEEc5YJHrTCQvE2RUZCG64qyqKP4Ct0Z
 ScIKe5bdXHFaBGTHo0CkzKxPg5OfAwhQLmy36BEt0E3RpN62TVDHh1Kc2CEDu/CatSbz
 SPlg==
X-Gm-Message-State: AOJu0Ywbtzq+bnPAb4kWqvLaTfuGamNZi9FBuF/BrBbg5a1fSK9JLtzu
 eXBEwUalEDuSoIsNWr482YHMkzs30P618Qi7RNOKqVod/oGlYI1EZK/mRlr5DI+xGeEt8w3RCgS
 iukbDgltQ0gryH8lK563PwYAru18gDEo=
X-Gm-Gg: AZuq6aK7gCCvnYCe6HRQ/dlbC85GlUdBdbLX6bcBWknrdRG3rwasApOOkhTu3v1qtRF
 RdoJEo513Bo8ucA4QH42N9sZ09a5/JV42yYBWuHMisZmJSB1o+uBUdffZ4ksHXudPTQ3VvIoVpu
 v2bARKc2a7qC+Zj4VRyrehSyt7+Ki6VouIebdwtH1ah9NvNN6u5HHFBrWdQh0BAnKNgMi6b0lNY
 5N/Jb7dw58scq6sucnEJnZR6S+q4ytgPYNmwTEyAol9DhBgx273hy4aZvxFFldt+4UPYwbt23ks
 PNEOMm3RQu8cE+pNATaaIy9kw//Y6UCCKmrt1jk9gj4rlHl2ycXbEQlFehCsefYyKgxpfQ==
X-Received: by 2002:a05:7022:b93:b0:127:2d87:f0fa with SMTP id
 a92af1059eb24-127398117bemr2871932c88.4.1771256370330; Mon, 16 Feb 2026
 07:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20260206223828.33061-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20260206223828.33061-1-mario.kleiner.de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Feb 2026 10:39:18 -0500
X-Gm-Features: AaiRm52EOYj-okIlSlxWKrJwP9FVULI7wkjN1UPMFdj7PbYikOnQP0p8sKBPk_M
Message-ID: <CADnq5_Nbm7i+b2ykCrYBXJLha3ow74PWVQ_8hVmB=Btim2Jdew@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use same max plane scaling limits for
 all 64 bpp formats
To: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

Alex

On Fri, Feb 6, 2026 at 5:39=E2=80=AFPM Mario Kleiner <mario.kleiner.de@gmai=
l.com> wrote:
>
> The plane scaling hw seems to have the same min/max plane scaling limits
> for all 16 bpc / 64 bpp interleaved pixel color formats.
>
> Therefore add cases to amdgpu_dm_plane_get_min_max_dc_plane_scaling() for
> all the 16 bpc fixed-point / unorm formats to use the same .fp16
> up/downscaling factor limits as used by the fp16 floating point formats.
>
> So far, 16 bpc unorm formats were not handled, and the default: path
> returned max/min factors for 32 bpp argb8888 formats, which were wrong
> and bigger than what many DCE / DCN hw generations could handle.
>
> The result sometimes was misscaling of framebuffers with
> DRM_FORMAT_XRGB16161616, DRM_FORMAT_ARGB16161616, DRM_FORMAT_XBGR16161616=
,
> DRM_FORMAT_ABGR16161616, leading to very wrong looking display, as tested
> on Polaris11 / DCE-11.2.
>
> So far this went unnoticed, because only few userspace clients used such
> 16 bpc unorm framebuffers, and those didn't use hw plane scaling, so they
> did not experience this issue.
>
> With upcoming Mesa 26 exposing 16 bpc unorm formats under both OpenGL
> and Vulkan under Wayland, and the upcoming GNOME 50 Mutter Wayland
> compositor allowing for direct scanout of these formats, the scaling
> hw will be used on these formats if possible for HiDPI display scaling,
> so it is important to use the correct hw scaling limits to avoid wrong
> display.
>
> Tested on AMD Polaris 11 / DCE 11.2 with upcoming Mesa 26 and GNOME 50
> on HiDPI displays with scaling enabled. The mutter Wayland compositor now
> correctly falls back to scaling via desktop compositing instead of direct
> scanout, thereby avoiding wrong image display. For unscaled mode, it
> correctly uses direct scanout.
>
> Fixes: 580204038f5b ("drm/amd/display: Enable support for 16 bpc fixed-po=
int framebuffers.")
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index d3e62f511c8f..394880ec1078 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1060,10 +1060,15 @@ static void amdgpu_dm_plane_get_min_max_dc_plane_=
scaling(struct drm_device *dev,
>                 *min_downscale =3D plane_cap->max_downscale_factor.nv12;
>                 break;
>
> +       /* All 64 bpp formats have the same fp16 scaling limits */
>         case DRM_FORMAT_XRGB16161616F:
>         case DRM_FORMAT_ARGB16161616F:
>         case DRM_FORMAT_XBGR16161616F:
>         case DRM_FORMAT_ABGR16161616F:
> +       case DRM_FORMAT_XRGB16161616:
> +       case DRM_FORMAT_ARGB16161616:
> +       case DRM_FORMAT_XBGR16161616:
> +       case DRM_FORMAT_ABGR16161616:
>                 *max_upscale =3D plane_cap->max_upscale_factor.fp16;
>                 *min_downscale =3D plane_cap->max_downscale_factor.fp16;
>                 break;
> --
> 2.43.0
>
