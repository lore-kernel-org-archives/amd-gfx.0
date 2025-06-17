Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E5AC71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 19:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D81D10E0FF;
	Tue, 17 Jun 2025 19:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c3EXRDw7";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0627E10E0FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 19:54:38 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-312a806f002so998869a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750190077; x=1750794877; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCmkpyYyEpdgSWyKPbZqnqqdHmRP9IMDwy/cykTeZYw=;
 b=c3EXRDw7p/l4IPQs+y0OlDraA8uuYe+t13FgOMajzFEbPc5RacLxkgcpwFmv2lfQvw
 COnL8j0GBPex8xgcZ3eempsUDcnjZz4BBY4kEvH/Q8JdKxcVt0NT6wIBWBIi2JK6LodV
 UZ3V3Ey/0Xo6vopI1rgCyd78NZgOliG0+onDjpeBPLmvau+XOFkMHyYxDEDtZ8EXMEaB
 Y0iXLa/Jt+lWGs35zTo00fCsiFx/PhjlWYJ8m/pd/rP8XPKqV1d7OLwXLpHAtwIXpIM8
 HJdEt2qbEwS9IfWrWpPVKoI/1qr/qXPmneAxj5N89vUQbXTBtrIl10gswM5EZ/O6jXMm
 PCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750190077; x=1750794877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCmkpyYyEpdgSWyKPbZqnqqdHmRP9IMDwy/cykTeZYw=;
 b=KU3hypj3qw8MIkMHnxOsUmU4CyVR1psgAYSTVAjCjVffd0DyIA1hHQAjv/B0YMv9J4
 HjkuJ2mgVN6/A81pn6r4a5ts9Y+UqjDL1f/E3199+pBNMIqqHyPwAtjQvgzs5KfTXJSA
 iTbi4sWuwUMDlEvIWiBjiIyfOzK5ZI9lm61ouOlYkXNxYdlHHFnmhru/kpQ98pqbv03O
 08rxP80h43NTvpon811hTO4MJ7a/KzHF/wnHEn3iueUlqHIaTA19Q0DRvJT+K9+/LgWD
 rTraMXkrVnj7oB/ZWGIL0GXzc7btPMfbY0wARME9fRiWteSySwN8vf3m/sck4u05D9HC
 J62g==
X-Gm-Message-State: AOJu0YxkV4QmpFLmJLroZ3/WPtS92jorPKSWR1GGHw83caDKB3GBS2nG
 e7ITPRYtWq6D2g2wWwpMSP2Y0feg2m81VAzzKG/WjxzS3hMg4WS6QrnWJ7Z6mLQv/dR36u5pLzg
 m+n5Bdx4I8t6imXeDclpuR3rHhp8BghU=
X-Gm-Gg: ASbGncsuCsnnoRWOxNaIi/9dsmhT/zhx9pdsv/C49YP7CHaJXYa+zWUlVTGytQHDSAL
 SOnXSKFjkqH4TyssdQcxeoLDV3eHddrnEVOiOoBQrZyVWD4XRGMskYxweJUciTwB7J8i0B7nviO
 Nfnx7N2qIJ8I/mV+5hBYbBoRBgygxyg8IeqbW6K2XdXaCh
X-Google-Smtp-Source: AGHT+IG+ooesAIZOfMgo3RciObm8f9vA7X7PyW5ZMLF1pdvwgKJa77sP1f47fnS0z0kFjIcVn+NRA2ntApYJYukJ5Ag=
X-Received: by 2002:a17:90a:ec84:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-313f1b312d5mr8058979a91.0.1750190077366; Tue, 17 Jun 2025
 12:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250617183052.1692059-1-superm1@kernel.org>
In-Reply-To: <20250617183052.1692059-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 15:54:26 -0400
X-Gm-Features: AX0GCFue8U3esnfn-Cat_zGZtVU5sAHnAjRebH6a4if8-npmzKqlwupATnOpMHI
Message-ID: <CADnq5_M8cMJqAap9OCdJcZOqgTqqcQgE+V1UA2Fo6wkbym=9kQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Adjust output for discovery error handling
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Marcus Seyfarth <m.seyfarth@gmail.com>
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

On Tue, Jun 17, 2025 at 2:31=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
> available") added support for reading an amdgpu IP discovery bin file
> for some specific products. If it's not found then it will fallback to
> hardcoded values. However if it's not found there is also a lot of noise
> about missing files and errors.
>
> Adjust the error handling to decrease most messages to DEBUG and to show
> users less about missing files.
>
> Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
> Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file a=
vailable")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  * Add tag
>  * Push error message into default flow only
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 25 ++++++++-----------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index a0e9bf9b27108..a29bd807e59f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -321,10 +321,9 @@ static int amdgpu_discovery_read_binary_from_file(st=
ruct amdgpu_device *adev,
>         const struct firmware *fw;
>         int r;
>
> -       r =3D request_firmware(&fw, fw_name, adev->dev);
> +       r =3D firmware_request_nowarn(&fw, fw_name, adev->dev);
>         if (r) {
> -               dev_err(adev->dev, "can't load firmware \"%s\"\n",
> -                       fw_name);
> +               drm_info(&adev->ddev, "Optional firmware \"%s\" was not f=
ound\n", fw_name);
>                 return r;
>         }
>
> @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct amdgpu_devi=
ce *adev)
>         /* Read from file if it is the preferred option */
>         fw_name =3D amdgpu_discovery_get_fw_name(adev);
>         if (fw_name !=3D NULL) {
> -               dev_info(adev->dev, "use ip discovery information from fi=
le");
> +               drm_dbg(&adev->ddev, "use ip discovery information from f=
ile");
>                 r =3D amdgpu_discovery_read_binary_from_file(adev, adev->=
mman.discovery_bin, fw_name);
> -
> -               if (r) {
> -                       dev_err(adev->dev, "failed to read ip discovery b=
inary from file\n");
> -                       r =3D -EINVAL;
> +               if (r)
>                         goto out;
> -               }
> -
>         } else {
> +               drm_dbg(&adev->ddev, "use ip discovery information from m=
emory");
>                 r =3D amdgpu_discovery_read_binary_from_mem(
>                         adev, adev->mman.discovery_bin);
>                 if (r)
> @@ -1338,10 +1333,8 @@ static int amdgpu_discovery_reg_base_init(struct a=
mdgpu_device *adev)
>         int r;
>
>         r =3D amdgpu_discovery_init(adev);
> -       if (r) {
> -               DRM_ERROR("amdgpu_discovery_init failed\n");
> +       if (r)
>                 return r;
> -       }
>
>         wafl_ver =3D 0;
>         adev->gfx.xcc_mask =3D 0;
> @@ -2579,8 +2572,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 break;
>         default:
>                 r =3D amdgpu_discovery_reg_base_init(adev);
> -               if (r)
> -                       return -EINVAL;
> +               if (r) {
> +                       drm_err(&adev->ddev, "discovery failed: %d\n", r)=
;
> +                       return r;
> +               }
>
>                 amdgpu_discovery_harvest_ip(adev);
>                 amdgpu_discovery_get_gfx_info(adev);
> --
> 2.43.0
>
