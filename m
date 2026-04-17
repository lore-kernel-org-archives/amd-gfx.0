Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174DDF436A3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 13:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8B110EA0F;
	Fri, 17 Apr 2026 13:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuUQ3+Ep";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B54E10EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 13:34:55 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12736a0147cso32255c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 06:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776432894; cv=none;
 d=google.com; s=arc-20240605;
 b=RDpfSI7VSz3bkZpOimBH9SUHH0xnqnhK2LIzjRm3n+J5kHR8A4ro6jd+9fziDNi32N
 CU8hM6Qgzd/J7YqJJhi2zsv1dY2Zv/yln+Uoju8roPD2gC3eRDmuVPYtjlJ0hJwgZM7F
 +hv6T8fFWWfUIztKdKuorrdXQRBls9/NcjbrhdcIC2fAtrE6guKik5injtM1BFKv4Ia/
 TUBfpgVmxGFkwakah0485sHj8AIcmzPbkMjtNmjg25zzoqYNBW0YlzZKqZ0jqeyFIUPl
 TQFt/bc4iFbcA9J2eNdsbxKBhMjsqxBK+zAiUBwc/1nhDb2jV2jDAKNuxfalPNjcWgU8
 DJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
 fh=4fNTSjg/+R4vZcx9hZJ1xQeqtFUWN7i1SEPIwezdLHw=;
 b=BJ/q6u05SlZgUd7hTiFVEP0MvYHXlZiUbB7vuMBXsVt5AFEMkbX7AqFf2HzmSbtZTk
 D9e8/lVoYe1xbpeglUh25xdPbMwltB4zT4LLE9p1YzJwxIzpTTtldYSoitdwZ2BP3s2t
 QEYveVcAgaIwqh/RdY+II3xuqxYCu14PC00QWSaeWAK9I6HtWHfOyyv5ovzj9Ut8q90F
 I9hrKrSBI73nvtefD1B1bQbXAGnV+0hUy6Ws1VZzdELK+uOnTazv1bOJ1fm/hUM9kJ2V
 hyApsp+IC/kVxDzej2d5htLyeaoeI1NQmZAPzCEj3b/efA0EKL1CgO9o9R4daExyI7WZ
 l/4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776432894; x=1777037694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
 b=SuUQ3+Epprzx87ktui4oWAwGtBml/z7LXmDoLB2Crhz5DnYFDnMMsdTpLO5hBxdT5i
 z4l4SpfTzgfG/DQh0bDnHSvuMNQKUBmtkq0lZXCUoMXaSkrBvxBvdaaAqqM/DqZGWnUT
 GUWdVGrF74goxAAc59PJbf2PtDq/HjVYsP1rXbqUFyxT32at0c9I0T2z7cC38HwDObNl
 BvlviT5rc4CICSvTvSBZsbhl+OdCUKbPCJua7yTwSp9GywHNU5sePbKqC5dNXv/hczqN
 oimpXm3/Tw4xIvjBUoEZEL1UVDMpWxGUtCWNZAmzj0rSPQGkoIy5K9/qCQWVUtbcFp1S
 7TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432894; x=1777037694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
 b=cBDmelItrMe5a1KdCl+yJHVyBRzdIHMsvSe0aGdqcKBNyMciCOaCT8ygDUkg89nX0O
 kDOwIDBvb3zfL/WzSjRJgH9DbpcpzoycLJTYe1JzP3jdC+IUxblY3OmbfKnHuoQMzLco
 mANhqOXMuYdChzi8bDUOJd7hY5QU71wRzRgppvFXpZxC5CYeQcbGFC+G67wIkYSka9ox
 vYdjJnrLMWBBxc+5oTKJfhGRyXOhfsv1QUciepQV/XKzGxeO5Xx17aWlGIeUOuRCXZ7v
 JTZO1LK0VvR7lL45jlqKUGE9ly7r1JLu1o1Dl6d1tgkJ21rBk42UNbpy+m1C3NZj8VFs
 ZSvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jcVCc6Eo6/L5+muBLZSLQXk3DCTK0Ukf5FlbAGTvMCHL4KL57LE0jNjQNqiFg+SurHWypwjDY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOoG7oX1sQx9o0CZlxUhdcp4uqjaUXbXNTRPhD+ZBLcT6U+Pku
 6yRS4sOkYQ+GD6MpJgiqIIFqYBSQnaGhrAoY3hmTn0YykJNqpmwW/QqiASXksWc0DhNnbTSk2r+
 V6+d9vIxc2o/9w8kJQ8O5tDQOrQB0toU=
X-Gm-Gg: AeBDiesjztmoo9Ke2i/BD9fFJk+C+ymk8V2zgPU6SFoXAVNGwPpo1E3+em1LItrXpmO
 naq3VRzzft6A9oATpvG5B+2bBAyzpTyEoJxvnLstiSVp3JarCOaFsA9ssmVU2YHyuvyL48wlaCj
 hfNrORC9CtsjXG21i0xStoE7z3AR/FFuoLDg7E7JiiBQYXDIWVNHtsvKNfud24CXyxsNXkpfyY6
 hdvqTLEOIPJWWj5d06y2b+RlTAXqBbAhoJ7969+3eMfSpUUWyF5losyIMfZvx5esveZLKGc7uzI
 ajUE6fCdjLVSM+nSwgS8p/cABwyn3d/TGZUFgz5/gvYM9wZXQ3F/z6hwO3ANsMBWhS1jzXexfJW
 +dAnJ
X-Received: by 2002:a05:7022:928:b0:12c:33dd:fa0b with SMTP id
 a92af1059eb24-12c73f69c12mr560921c88.2.1776432894188; Fri, 17 Apr 2026
 06:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
 <20260415221350.1178094-1-werner@verivus.com>
In-Reply-To: <20260415221350.1178094-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 09:34:41 -0400
X-Gm-Features: AQROBzBNKLgUz5j7LnoNFi5Ad4rOoyX0l8ZAuNVWt5YQYXWOh6GE9S_RYf361NE
Message-ID: <CADnq5_M4Rr2ifOoCrvLqiqj9H6tRgKOY3Tn6NqyUB3YziicqZw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/radeon: fix integer overflow in
 radeon_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

On Wed, Apr 15, 2026 at 6:14=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> radeon_align_pitch() has the same kind of overflow issue as the old
> amdgpu helper: both the alignment round-up add and the final
> 'aligned * cpp' calculation can overflow signed int.
>
> If that wraps, radeon_mode_dumb_create() can end up returning an
> invalid pitch or creating a zero-sized dumb buffer.
>
> Fix this by using check_add_overflow() for the alignment round-up and
> check_mul_overflow() for the final pitch calculation, returning 0 on
> overflow. Also reject zero pitch and size in
> radeon_mode_dumb_create().
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
> v3:
> - Squash this fix with the earlier zero pitch/size validation change.
> - Use overflow helpers for both the alignment round-up and final
>   pitch calculation.
>
>  drivers/gpu/drm/radeon/radeon_gem.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 20fc87409f2e..8ce180e22d1d 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -28,6 +28,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/iosys-map.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>
>  #include <drm/drm_device.h>
> @@ -812,6 +813,7 @@ int radeon_align_pitch(struct radeon_device *rdev, in=
t width, int cpp, bool tile
>         int aligned =3D width;
>         int align_large =3D (ASIC_IS_AVIVO(rdev)) || tiled;
>         int pitch_mask =3D 0;
> +       int pitch;
>
>         switch (cpp) {
>         case 1:
> @@ -826,9 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, i=
nt width, int cpp, bool tile
>                 break;
>         }
>
> -       aligned +=3D pitch_mask;
> +       if (check_add_overflow(aligned, pitch_mask, &aligned))
> +               return 0;
>         aligned &=3D ~pitch_mask;
> -       return aligned * cpp;
> +       if (check_mul_overflow(aligned, cpp, &pitch))
> +               return 0;
> +       return pitch;
>  }
>
>  int radeon_mode_dumb_create(struct drm_file *file_priv,
> @@ -842,8 +847,12 @@ int radeon_mode_dumb_create(struct drm_file *file_pr=
iv,
>
>         args->pitch =3D radeon_align_pitch(rdev, args->width,
>                                          DIV_ROUND_UP(args->bpp, 8), 0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>
>         r =3D radeon_gem_object_create(rdev, args->size, 0,
>                                      RADEON_GEM_DOMAIN_VRAM, 0,
> --
> 2.43.0
