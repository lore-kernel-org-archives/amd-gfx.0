Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350D7C7EE43
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 21:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37F310E0F3;
	Mon, 12 Jun 2023 21:48:03 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B9C510E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 21:48:02 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b280319df5so3172761a34.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686606481; x=1689198481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8Zu3tZEShB4hlKWa9Ekd7/vywIhjUVOt1jdis0PKqs=;
 b=Amy2PFjkjP96CZT3/iCzJ+fkPNZHK9YyWimAjqnTL8Dzp/ACI4ZRO1C0hKb8SRh658
 blzbR8ygT3CliuSxQw4kmqKeyRacZ5bJrQBFXYkF21tiF9OAp8YFW1Zq5COFWCK3dUHF
 yeSokIt165cds4GBaOzIujahzouyIBjfPZuxPnyn6mueoJj2JfaUu/wIaIJ/RIcOMnxc
 9dOAzbrVMR2GqIQqAJGiLZfdD+792BHQrl3y3tg7rC4v0Nn68Ts8qeFqNauOWh/4SI2m
 kPNOupcXITk2eHmeu3Ddmm28pkASNhcWKCAS55Lp4t2WdrJ8O5jhQx2B6xIkoFxYIPbM
 i/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686606481; x=1689198481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8Zu3tZEShB4hlKWa9Ekd7/vywIhjUVOt1jdis0PKqs=;
 b=RRcly63b3Z4wNJjTqIWWJhjhisaJI3Hpbv/fozCXjBdLRX4llv8So+wYWQV+ZKBCbG
 P2iqx4sO39d/LnYLfjIRsu9iN+n0DXhZ/f2bLuk4+vIhq9Zv1tunK8UDtTV9ER8164U+
 w4U78/YLjoylM8Jj+w1MpUZZgvHoPsvMCvc/hlxIhf0hEmK2/cud1x/5aPdGnz9j2cwU
 v7TBhqERyV/1DoUDUfagGtYOy1twKfp5zC+IR4Zd+ASbFix3eCpXjohBq2x7YdGjWWDe
 5PIbl7hPckBNAmGqepsZ0oRi3pksiyuLwXtFdnKXbw5+Rg/0oFSldl9VsR/TcZzMexiZ
 2WoQ==
X-Gm-Message-State: AC+VfDxAHHHKW1kf6ZZBoSdB0nacbTYAuKxPtEQNsTHb1haSqKbfpe/i
 VubtaQdo+N2mkm5t0cTe8LbIHwUnqc0hNhYIDpREYhfF
X-Google-Smtp-Source: ACHHUZ6SG9O5WhExb6YQASbsyvOUmxQv8TtM+OPqk6f3tqRfcT56Z/w5uksKHWKAfIL9KpPJAb0FuoS/7Wz/Nf5aIh0=
X-Received: by 2002:a05:6830:1210:b0:6b2:9005:1870 with SMTP id
 r16-20020a056830121000b006b290051870mr6505942otp.36.1686606480973; Mon, 12
 Jun 2023 14:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230607164604.961913-1-alexander.deucher@amd.com>
In-Reply-To: <20230607164604.961913-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Jun 2023 17:47:50 -0400
Message-ID: <CADnq5_Nwf_8iqMsFGO9x-PdUbBoUf1RqU4KzqrEKVPdwmkDW2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: fix DDR5 width reporting
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Wed, Jun 7, 2023 at 12:46=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> DDR5 channels are 32 bit rather than 64, report the width properly
> in the log.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2468
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index ef4b9a41f20a..6b3bdc27f778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -327,10 +327,14 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_dev=
ice *adev,
>                                         mem_channel_number =3D igp_info->=
v11.umachannelnumber;
>                                         if (!mem_channel_number)
>                                                 mem_channel_number =3D 1;
> -                                       /* channel width is 64 */
> -                                       if (vram_width)
> -                                               *vram_width =3D mem_chann=
el_number * 64;
>                                         mem_type =3D igp_info->v11.memory=
type;
> +                                       if ((mem_type =3D=3D Ddr5MemType)=
 ||
> +                                           (mem_type =3D=3D LpDdr5MemTyp=
e))
> +                                               mem_channel_width =3D 32;
> +                                       else
> +                                               mem_channel_width =3D 64;
> +                                       if (vram_width)
> +                                               *vram_width =3D mem_chann=
el_number * mem_channel_width;
>                                         if (vram_type)
>                                                 *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
>                                         break;
> @@ -345,10 +349,14 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_dev=
ice *adev,
>                                         mem_channel_number =3D igp_info->=
v21.umachannelnumber;
>                                         if (!mem_channel_number)
>                                                 mem_channel_number =3D 1;
> -                                       /* channel width is 64 */
> -                                       if (vram_width)
> -                                               *vram_width =3D mem_chann=
el_number * 64;
>                                         mem_type =3D igp_info->v21.memory=
type;
> +                                       if ((mem_type =3D=3D Ddr5MemType)=
 ||
> +                                           (mem_type =3D=3D LpDdr5MemTyp=
e))
> +                                               mem_channel_width =3D 32;
> +                                       else
> +                                               mem_channel_width =3D 64;
> +                                       if (vram_width)
> +                                               *vram_width =3D mem_chann=
el_number * mem_channel_width;
>                                         if (vram_type)
>                                                 *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
>                                         break;
> --
> 2.40.1
>
