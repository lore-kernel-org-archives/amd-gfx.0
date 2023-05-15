Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E0BC7EE2C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 21:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5759F10E296;
	Mon, 15 May 2023 21:39:22 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2163710E296
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 21:39:20 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-55239f43426so2049226eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684186759; x=1686778759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dI/NZTv30xWYvuAe/G62vAm/Uhf84bN1JRbCpqmykhw=;
 b=aCAM3tB0p+rpgaC1LJpwAtz26NLIFkE6N1X5hyYfElkjbxJonYS2kjPnrZIXPejbSl
 /FjOWlX7la8GewrcJhukM7JM+w12Ce+kSHyD2w9GcTt82KtUu5BAE0P10o+LvDv3e3i2
 1Ro+99DR1BvSp6WdobD9xPE/BXy9f363lvofPJuxHY6XrBX8pOtvWXLJdLw7ekGvVmFO
 XpgzYN1aX68KYls2EdVL6clccGBVnKaFRI/oc/Blpj6uvC+rVcgwtq4STaCSAn3ijOAx
 z9ulEnerx3xsTaGstr7fIb6NWjRy/H1N/WWB0WhJpqFbzN+4a+0bsj9qh2Pr3iMvAKto
 EUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684186759; x=1686778759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dI/NZTv30xWYvuAe/G62vAm/Uhf84bN1JRbCpqmykhw=;
 b=G0bTuadDOh8K+W+hPRN4kCMxJD8w0YhodRoY9e8o4CNryWmCa+0z+w72A/8yFKAokQ
 LPLycpIzpsWiP+0+/8Vi92ZIiFX6HoYGzd48kJPojbFcYEHX7Mx9JrRZehYkUzO9BgTt
 wWQ9RaNTl7dmpwxkH8JZtzqWEmQ4hxHLS+mfF8+Ix7M+3kZsPD79XxVDYbSbtilpjyLk
 yzpQp4e/Go07u+ovTtcibQdn0Rqi6mJ53ZrH97Ad3g42NGFWFd6N07BvHEJlIkrlcUdp
 cdme4H1y1xfvy3QiKHukm0V1LDmUMArqrv6uMcVIcEndArIqLbu1CdMYX+kVlYNvJ5QX
 SK2A==
X-Gm-Message-State: AC+VfDwAU0e0HSGSXZMiknf+gn0dWBrQ1B/R5IeTLB4zv2jQ0Waf85/g
 2IPYwCvk3MATy42a75B6zBT83IZHwyRc18kOKkw=
X-Google-Smtp-Source: ACHHUZ7wT7W3woP+7sDXgPe5KxBPXrzVXNIY3ZyO5TYxU4tpVjQFVTWkoOVabmjPEdhFzaGoqQTXeiNDvfDVvzzGcYU=
X-Received: by 2002:a05:6808:b14:b0:394:3771:2781 with SMTP id
 s20-20020a0568080b1400b0039437712781mr8707147oij.51.1684186759012; Mon, 15
 May 2023 14:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230513125100.1287549-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20230513125100.1287549-1-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 May 2023 17:39:08 -0400
Message-ID: <CADnq5_Mc3eLNE1y2uDdugbTf5s+UQy8gEVawiGicu9XTvR_Eew@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Validate VM ioctl flags.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sat, May 13, 2023 at 8:54=E2=80=AFAM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> None have been defined yet, so reject anybody setting any. Mesa sets
> it to 0 anyway.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 158176b2f47e..62922a795312 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2442,6 +2442,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>         struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>         int r;
>
> +       /* No valid flags defined yet */
> +       if (args->in.flags)
> +               return -EINVAL;
> +
>         switch (args->in.op) {
>         case AMDGPU_VM_OP_RESERVE_VMID:
>                 /* We only have requirement to reserve vmid from gfxhub *=
/
> --
> 2.40.1
>
