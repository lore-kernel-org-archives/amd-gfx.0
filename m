Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C96CCE9D42
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 14:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C8610E10E;
	Tue,  6 Jan 2026 14:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mRO6RtTv";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFBE10E50D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 14:52:56 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-121a15dacd1so25351c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 06:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767711175; x=1768315975; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nU2jY68+v3uM5onmzMUso4lL4Grtw+z6Y73ewZcXAjY=;
 b=mRO6RtTvkANXHuG2TJe9N7sktvgZtbweXGNRK04B8CaJTbr1PIWP0TPfAZYFN5GnWD
 q8fMFwym/MZY86GvZmc/T/xnpsEsgbnPOk0r/K/6BKpI60z/dopviK7+t6R3hi+8GqLy
 0AooRf9RLuPWejTEomFcTfvFxmxHlqHbsyPaxab+zBmqrce2MnmOQS5mi3ydAYx0s4HN
 VfC3ALlcj6SbgzdREesbOsm68wSzjz0SwpRQ+bY2VH1tS+1YqY6vL0Hgju/1bm+HhXic
 62RK7QFp0HskDISToQ574H1WaRg36X64teF91zKqvZEUD/aRUKT7kLiC+PrNuSJm3x2M
 4epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767711176; x=1768315976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nU2jY68+v3uM5onmzMUso4lL4Grtw+z6Y73ewZcXAjY=;
 b=TRwBHJu5O9UfCM8n7CD6fYc1p8FX4cszp/SGegTpYhlETxzvxyBik7nUFCCTtWoOdx
 pRPfKTOwTilw7sPLhrfRAg+Y4ORwuU7ShqK3YNgPSkTStsZdHWEyXdqCnYp4dEizBeVQ
 8oFivXzxFPyskPma140foMxbkneeH1jocVKO9Wx1N5aWM5VsJxFc8RsesKc1gJgdhKhd
 FRhUa/Ytc+5q+38qGEi+4UDhpVEnbyeyXjijyHK0jytNqtyZU2lt5i8Fu4HZqxxP1gvv
 /ERAf8kHto5rm3vBIE+vqPHDZ+2FqOeeXRa433O51jKXjEz0FkGSUX3QWyDyCE05aVqQ
 diKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWohHAxh1yQ/Ce6VDpuix0XOJmrnRRFK4w8/d0WvgRtIwmOuoM49eAZMsZLKrTFBlIW7oNBF/qn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeAU9o/iekDfTXjxK1YcigByUpopDBFmdZc/Vgdop20pyxtaY7
 r7bJwtGWOaeFgIn4XiZWQH3W99+3bNn+NLgEuMGCZG6venbghg5w0UQeW6Iuc3ZxGQ3mYKcI3bk
 /DbmaZqY8KHnG4jK7qlFZQZVn6jrph84=
X-Gm-Gg: AY/fxX4yIZZFbDPkEnUbvRfFwLdjY6yfsVn3XOFEjKtNTnQubYJHusqs+XInTPcvgF+
 wx9LummQapGd/FS7bRpSANmDUglivBft88YMuH8EteE2GuHgiB+RThoNZR7YBKOD0ubjdMJVFx6
 bLpB3o39pFsNWH5kLxDcIWmNpjc0oY572o5ULw/CrvlQ4oE22AQ/0zJwr34LhaRruPmQOMw21Mo
 ITTlJI1OKJnnWttEFJb2ioHoaCh+lzY27JmEVZjrHexcM52gQHgahlfjB84s1g4LysGtdqsbZg+
 b2b9Ht8=
X-Google-Smtp-Source: AGHT+IGbexNqbpHfKfJA6IJneXNFlcW/Iwy+nKKHp8Rqze9NIPnkdBJAsrBQL5TxQQJea9Ml7i5WE1j+Ybe2rAEiIj0=
X-Received: by 2002:a05:7022:4a4:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-121f18e5ad8mr1533764c88.4.1767711175450; Tue, 06 Jan 2026
 06:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20260102141629.617921-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260102141629.617921-1-ben.dooks@codethink.co.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Jan 2026 09:52:43 -0500
X-Gm-Features: AQt7F2oNtp0sRjFqbYLl8nt4XXpZ18Y12YF3gVJn4WQ0RJxeCTvYgZDAcNZYqXg
Message-ID: <CADnq5_PZxhjk8xsqzoF_nmrOyYgUjLVNMUDRUEODym7sQ7MEuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix signed v unsigned print formats
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, simona@ffwll.ch, airlied@gmail.com, 
 christian.koenig@amd.com, alexander.deucher@amd.com
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

Applied.  thanks!

Alex

On Fri, Jan 2, 2026 at 7:36=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.uk=
> wrote:
>
> Fix several places where %ld or %d has been used in place of
> %lu or %u.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index f86773f3db20..891ef929cfa8 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -110,7 +110,7 @@ int radeon_gem_object_create(struct radeon_device *rd=
ev, unsigned long size,
>          */
>         max_size =3D rdev->mc.gtt_size - rdev->gart_pin_size;
>         if (size > max_size) {
> -               DRM_DEBUG("Allocation size %ldMb bigger than %ldMb limit\=
n",
> +               DRM_DEBUG("Allocation size %luMb bigger than %luMb limit\=
n",
>                           size >> 20, max_size >> 20);
>                 return -ENOMEM;
>         }
> @@ -560,7 +560,7 @@ int radeon_gem_set_tiling_ioctl(struct drm_device *de=
v, void *data,
>         struct radeon_bo *robj;
>         int r =3D 0;
>
> -       DRM_DEBUG("%d \n", args->handle);
> +       DRM_DEBUG("%u \n", args->handle);
>         gobj =3D drm_gem_object_lookup(filp, args->handle);
>         if (gobj =3D=3D NULL)
>                 return -ENOENT;
> @@ -886,7 +886,7 @@ static int radeon_debugfs_gem_info_show(struct seq_fi=
le *m, void *unused)
>                         placement =3D " CPU";
>                         break;
>                 }
> -               seq_printf(m, "bo[0x%08x] %8ldkB %8ldMB %s pid %8ld\n",
> +               seq_printf(m, "bo[0x%08x] %8lukB %8luMB %s pid %8lu\n",
>                            i, radeon_bo_size(rbo) >> 10, radeon_bo_size(r=
bo) >> 20,
>                            placement, (unsigned long)rbo->pid);
>                 i++;
> --
> 2.37.2.352.g3c44437643
>
