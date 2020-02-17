Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDECCC34021
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F9E20718
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMz3a39n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F9E20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 493616E967;
	Mon, 17 Feb 2020 14:44:39 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9D46E968
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 14:44:37 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a6so18764830wme.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BlCz0pxtbpswmPT4z1roh2o5wpVhy8aDm9TpZVmFN7Y=;
 b=oMz3a39nie6zhqjMgoSTqr7PpEgv8yrVqQmERbHrhWJ/pH7VMoTiLoivevnv1W4yIG
 aTyiZKUDMP+/aEjhUVKIahiWGDGmKk+Bn77XQXYbTmhRB4+PTfDT5g6tb/ryirNu8Qhd
 7jnl36lMHCR1Y1HaKo0tcojzUbB7Iwk6EsQrhS/hLpkacgZaIIlsAVUpZ/YAqciw2Sqa
 0wjkFccxRu8wqzWLomg77EKhgv65ETANk5iPZ5JAircwVlFoJYiRB/1Rm/bZg9huxNYK
 jkoDwagfUV6fyPHkOHqFVdrLpIVkMFzzFKWHy10ER5tMX2ipAamf73JINJl0ajhW5zOV
 iy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BlCz0pxtbpswmPT4z1roh2o5wpVhy8aDm9TpZVmFN7Y=;
 b=IB5KpzgPZz6rLejEkThqMpIp91VSHTZoJTjEEV/SWj7vjSy2MOILGscrXThoOPW7XO
 uiB+xVxBoRflpxP2oXvHWDxO26IwXmaPwRjGvWJFjXzrKJB3+f8qi7O+GGkWJAVKIFDc
 qkLIv8w3QGa5VgUXbmC4jb0zhsFr3P/6AzJPEjnIRTV8Q3jbEAT/my57ji65C8NF7FLF
 sUD0Q3lmjbX014GbTY2xsPrY1PqnbLgz7QcrVRry6C3QXHpHJ0BaakukOhUN9tXj+uFk
 M3Gm88UAP9P06TketNT2RIdngupQMG+pdSWmb8Uu9DHt9+ymRTIFjfjTNZcaTBp1dz3Z
 fBng==
X-Gm-Message-State: APjAAAWm4BOXlCN9QEYOBMlNkgprnWLLPa50iT1vHMWyNhZCk5pdx8dN
 /xJtNTQM7r8Ji692xDjz9Xx0nHWPdGjHkE8gOjU=
X-Google-Smtp-Source: APXvYqyZOsPkUqdcLktxwsk/m2julFzvLE+/kShqr/iEZ+41zjqDLhqo/DOPNEVt9sTLOBB6LfAG9XMO6dzcnxL3SBs=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr22906794wme.56.1581950676212; 
 Mon, 17 Feb 2020 06:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20200215001714.605727-1-luben.tuikov@amd.com>
In-Reply-To: <20200215001714.605727-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Feb 2020 09:44:24 -0500
Message-ID: <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
To: Luben Tuikov <luben.tuikov@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 14, 2020 at 7:17 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Add a AMDGPU_GEM_CREATE_MASK and use it to check
> for valid/invalid GEM create flags coming in from
> userspace.
>
> Fix a bug in checking whether TMZ is supported at
> GEM create time.
>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 ++---------
>  include/uapi/drm/amdgpu_drm.h           |  2 ++
>  2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b51a060c637d..74bb79e64fa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -221,21 +221,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>         int r;
>
>         /* reject invalid gem flags */
> -       if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -                     AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> -                     AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> -                     AMDGPU_GEM_CREATE_VRAM_CLEARED |
> -                     AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
> -                     AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -                     AMDGPU_GEM_CREATE_ENCRYPTED))
> -

I'd rather keep the list explicit so no one ends up forgetting to
update the mask the next time new flags are added.

Alex

> +       if (flags & ~AMDGPU_GEM_CREATE_MASK)
>                 return -EINVAL;
>
>         /* reject invalid gem domains */
>         if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>                 return -EINVAL;
>
> -       if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> +       if (!amdgpu_is_tmz(adev) && flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
>                 DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
>                 return -EINVAL;
>         }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index eaf94a421901..c8463cdf4448 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -141,6 +141,8 @@ extern "C" {
>   */
>  #define AMDGPU_GEM_CREATE_ENCRYPTED            (1 << 10)
>
> +#define AMDGPU_GEM_CREATE_MASK                  ((1 << 11)-1)
> +
>  struct drm_amdgpu_gem_create_in  {
>         /** the requested memory size */
>         __u64 bo_size;
> --
> 2.25.0.232.gd8437c57fa
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
