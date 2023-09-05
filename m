Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E40CA1006
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 19:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A6810E4EC;
	Tue,  5 Sep 2023 19:54:07 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2270B10E4EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 19:54:06 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1c4c6717e61so2457455fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693943645; x=1694548445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=himoypY7mdHKaClJbOjUWIjrudKu/HoFop64s4HnL84=;
 b=PcQy6fr5+AEWX73wGt96rzBhAtXmyDWAtA3lRgcec4j1yJ9xTVEcPnG4ZmcM5P35ch
 Rrqfpol1M9pGg9JwRuucEX95NJoB1am6Lqif7H7xnUnduOYbC2pwiPCrrrU00izY7pI2
 H9Bc6f1S9xA6SzW/dKM4wPYVGiFr5JmjE1uuDx0z00yRAjtSoknzTMCczVHT9EAgtv9R
 fLJ7GeEjfjILYg8GEqKaZcOkKvJZe84ocgls4p+/4IBXgAw+Bi2Yojdttg8tBUxOnjm+
 oyj3+JiIFRyFj+icfPHbYVYQCsYX5/xxqDJdo37gUKp2F3pzfC5QoC7AXagj6K7o/VTO
 3i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693943645; x=1694548445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=himoypY7mdHKaClJbOjUWIjrudKu/HoFop64s4HnL84=;
 b=BXH4g9OlF78RpP0eE0U7zlDJyseQDY3UEm70lNTjkyDDqsLWZk/7KowVFJIDQWGtze
 IiG84S3okBPeT8qtRz6obeOJ/k5XAmjk+VROmyM7/KAsuS9R7X3Fg6J4H5AwmqEIEKdv
 aql+V1ff0HkV286JvPxj4jK3X+YfHN1IJeTwlbzbzHsKhMBDoy1qiXs9V/hacsYjOMH8
 wZWyeNy0b69/nuZTpo5N87/bT4f5CXw3r8T6PesOpAJlSSsP1o36VxoQophIJ3RMDC7g
 MBdSonuw3NrZHHRoEp/yzjPurdLO5nwO3+tRs0T3Zst0ikXbUpPZDPO0iK0ghNnLba6j
 DCkw==
X-Gm-Message-State: AOJu0YzDcrMHI90x2dGtSNHPbRXnhszBhp6BBNNrn/XGFwokhvjXSkUa
 rfp1A3x/nM3tiRqrdmTFP9hC1+NF7mnfNsLPlfT1KIqQ
X-Google-Smtp-Source: AGHT+IFBzLP8Y4XoX1g13oUAsvuzXJCpK2Mya43fQvwYw448cBpkSGkaSYpPE4XwD2kDQrXHmSU6d5eyTGawJQaa1kk=
X-Received: by 2002:a05:6870:a70d:b0:1d0:c224:77eb with SMTP id
 g13-20020a056870a70d00b001d0c22477ebmr16981236oam.39.1693943645358; Tue, 05
 Sep 2023 12:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230905192600.32449-1-mario.limonciello@amd.com>
 <20230905192600.32449-2-mario.limonciello@amd.com>
In-Reply-To: <20230905192600.32449-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 15:53:54 -0400
Message-ID: <CADnq5_O=9jNjVT6KwSzOVqjOw65zb2sD4jstdXpF71PDny8QrA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amd: Drop special case for yellow carp without
 discovery
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Sep 5, 2023 at 3:45=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> `amdgpu_gmc_get_vbios_allocations` has a special case for how to
> bring up yellow carp when amdgpu discovery is turned off. As this ASIC
> ships with discovery turned on, it's generally dead code and worse it
> causes `adev->mman.keep_stolen_vga_memory` to not be initialized for
> yellow carp.
>
> Remove it.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 5f7641d9f346..27e534b0b8e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -725,12 +725,6 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_=
device *adev)
>         case CHIP_RENOIR:
>                 adev->mman.keep_stolen_vga_memory =3D true;
>                 break;
> -       case CHIP_YELLOW_CARP:
> -               if (amdgpu_discovery =3D=3D 0) {
> -                       adev->mman.stolen_reserved_offset =3D 0x1ffb0000;
> -                       adev->mman.stolen_reserved_size =3D 64 * PAGE_SIZ=
E;
> -               }
> -               break;
>         default:
>                 adev->mman.keep_stolen_vga_memory =3D false;
>                 break;
> --
> 2.34.1
>
