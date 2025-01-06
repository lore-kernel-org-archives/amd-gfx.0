Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A45E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 15:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710C410E6BE;
	Mon,  6 Jan 2025 15:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fA0sVghj";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D79D10E6BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 15:48:43 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ee9b1a2116so2982074a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2025 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736178463; x=1736783263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl5CIxhtMMRJKWq+2wH6XZB9/wsnOBB/zos3o0d+jnk=;
 b=fA0sVghjUr0Kipe26yeiIfxN8wI1Sng38ntOoDSVrxtPp7TDuZhsYAOjumnPNhFIXr
 xG7gVsvjVYWnHc74xA1goxKmqR0I6xaaAw9iM+Z6rv+mVqsLXkFzIdEV4cUpMkxT+Vyp
 KTxVVOwSeLCFnZoI9smnCa0hKzyYbtwSjqnvwnWzk8d8IAgU6x/B/2Gh5jNwemm7V/Hx
 QP8zSYAGt6iss7VM2ktYixkwHKVmtLNFFodm23zrzsAhhz0z4lWG6PANMyBBOV9xaJGX
 1cJ4DEiE3smMW9hzUno+KAdqeSDFru0oHNuNdSbKhahpFJbgVBCnnc6ARnOr29dTZC9d
 QzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736178463; x=1736783263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pl5CIxhtMMRJKWq+2wH6XZB9/wsnOBB/zos3o0d+jnk=;
 b=Rw2rwZ7DpTd7HlbCPgk5C3vHweRBpAcr833Vzw4giO1EtzLgGNrs0jfmZEqTPDvaCw
 piDuhP2oCCCHVNcqSnUk7/IgIU6yBujQOxBWW8wPb57EwE1ro0JdRamAxkTQlASe79ka
 UgRQkDjCP2pcDlFGNj4HZltYdgUfG7JIUsclqt8fvyrqv6XL+qECNvZz1hl3m6vdY2qw
 dkGlj0dJns7vPKaOngrbOcu21RSFB2kbWq5HqdZ7TBVdVGCgeMRjy7/1aDjI49g1BsW0
 NElW8QDn2OOjRNDRPnOnYAPoIYI/l8pMKvRoRntyJKCK43xfo1ikQeMeX5v+soW94qp8
 8UAg==
X-Gm-Message-State: AOJu0YyI/8gQxdDST0wSud4hbNZaFZf6V/w5CY+lkZw5ic3TIpWW/K0o
 oiR3BZqSg5jpgZLYebCEu7RaQHDgzXnPLe6NwqgJ1WnOPABa85XPw0QkL2bghpzz3PFwKxdRTgR
 Wlt29xmhV3ajPkF6m/s8VcrlbRmPxDw==
X-Gm-Gg: ASbGncse9xZAG7A5lUcWytKHSf9YV5UYNI39Qm5xheocWRcUyRf7nLPbzrwN3w/Sp1z
 yPItbRyUJ9V/gJywHo8kxVnO2j2PoPF2bmgTVYA==
X-Google-Smtp-Source: AGHT+IHcJOawXFrtf62nBDEby4U03kjMSq0ltWl8IoYpdM/2yQX0+PuziY7PIqskyPlCFO935CUS/GIBZZgTYx9bRQk=
X-Received: by 2002:a17:90b:3bcb:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2f452de8c1bmr34007329a91.1.1736178463028; Mon, 06 Jan 2025
 07:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20250106055810.3785461-1-tim.huang@amd.com>
 <20250106055810.3785461-2-tim.huang@amd.com>
In-Reply-To: <20250106055810.3785461-2-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jan 2025 10:47:31 -0500
Message-ID: <CADnq5_NPcagW5fhYuL3AeYOGAxnUV+svFx9=+s9b1Aj4N=BCag@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix incorrect number of active RBs for
 gfx12
To: Tim Huang <tim.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Yifan1.zhang@amd.com, Xiaojian.Du@amd.com
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

On Mon, Jan 6, 2025 at 1:32=E2=80=AFAM Tim Huang <tim.huang@amd.com> wrote:
>
> The RB bitmap should be global active RB bitmap &
> active RB bitmap based on active SA.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 3aa34c55554d..f8d46651dbf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1650,6 +1650,7 @@ static u32 gfx_v12_0_get_rb_active_bitmap(struct am=
dgpu_device *adev)
>
>  static void gfx_v12_0_setup_rb(struct amdgpu_device *adev)
>  {
> +       u32 rb_bitmap_per_sa;
>         u32 rb_bitmap_width_per_sa;
>         u32 max_sa;
>         u32 active_sa_bitmap;
> @@ -1667,12 +1668,14 @@ static void gfx_v12_0_setup_rb(struct amdgpu_devi=
ce *adev)
>                  adev->gfx.config.max_sh_per_se;
>         rb_bitmap_width_per_sa =3D adev->gfx.config.max_backends_per_se /
>                                  adev->gfx.config.max_sh_per_se;
> +       rb_bitmap_per_sa =3D amdgpu_gfx_create_bitmask(rb_bitmap_width_pe=
r_sa);
> +
>         for (i =3D 0; i < max_sa; i++) {
>                 if (active_sa_bitmap & (1 << i))
> -                       active_rb_bitmap |=3D (0x3 << (i * rb_bitmap_widt=
h_per_sa));
> +                       active_rb_bitmap |=3D (rb_bitmap_per_sa << (i * r=
b_bitmap_width_per_sa));
>         }
>
> -       active_rb_bitmap |=3D global_active_rb_bitmap;
> +       active_rb_bitmap &=3D global_active_rb_bitmap;
>         adev->gfx.config.backend_enable_mask =3D active_rb_bitmap;
>         adev->gfx.config.num_rbs =3D hweight32(active_rb_bitmap);
>  }
> --
> 2.43.0
>
