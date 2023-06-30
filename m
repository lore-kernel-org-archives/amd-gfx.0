Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D050CEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6207610E16E;
	Fri, 30 Jun 2023 15:21:19 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE0C210E49A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:21:16 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1b060bce5b0so1844172fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688138476; x=1690730476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wtDor58wYkeD7k1+TbbF0Fg/zO20U4/pAMVm2I7KJA=;
 b=Flmi7Tbgnqi/k/OIfescGSoyn0pGBEr6FhJlLwIZ5FEgsFapJKQEO1w+IdoQG6QWkZ
 Cyxn/SD3eq88F1vZn9AuajGKuNVX+miFtDjT9aOcFnvfdo02fm/Lt5Ts+eMM6fdDfnpO
 +omdCubRT9xkOKAH87HUqlKjAJ+q0iSwatg7DcDeKma4S1v4B6PSxmx1lmvTXM5qphML
 lM4HDCsi/H0DjlZu2TQPNRzSzcOKZUa+a6yovxxCbjYwrUPDVH4EDyZ8lEO0+TXNXTwC
 ELm2SZK29/Z9ZmiM+v1B9Mkep6ZBstlRjRSsx0+zJ/aYvFATz0bVmg5jExpVfnmuIhf+
 3cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688138476; x=1690730476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wtDor58wYkeD7k1+TbbF0Fg/zO20U4/pAMVm2I7KJA=;
 b=FwbPdksWD8xMbGXezjDkHXA8rf9/tGmUh6Br6Y9I4v51ZhBefjJmDqMAtweGxtx4Oj
 kWhWvCcFqKfCfv1A6ptCGDRESeR7m/a8rxO+e84AShq8KnJWYV6aKVLM1oFfalaYi49V
 qd7iuaI4tGHTXxZ+0r8CP8nBvT3zAGv4cbGwz9tc4CFmEH3daC/eR/hQXJeSsa/0idBr
 S0l3R9Qf/VqRyrLy2n6391EY74aM/Mja+Nwyolonq96zOBdja2rAxxkKOD8VKVtrAm9C
 a3j2alV+SmaHQJNB2/yV5P0WPVdJRJPciWHAG+Xk9ixg0BAY0qyYC3iTQvlmVSUFuytJ
 XJaQ==
X-Gm-Message-State: ABy/qLZ2gw0KdVe5BPGIWz7jP1vKPAX97CUPf5Cbjig+OFnaKFSjPFRu
 1Rh9f15ndD64PhIKQK5LkufDXanFnTw59cZtimk=
X-Google-Smtp-Source: APBJJlHHy6N5ZCDbtlPcYseza9bOuf9J2BAk/nI2GeLwNptHVcUmpkymeiUhPlzX+8x2XjVO9SiNtZh/nXZzbrnL0+0=
X-Received: by 2002:a05:6870:f988:b0:1a2:8e53:c418 with SMTP id
 hv8-20020a056870f98800b001a28e53c418mr2691979oab.57.1688138475715; Fri, 30
 Jun 2023 08:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230630112135.3347421-1-kevinyang.wang@amd.com>
In-Reply-To: <20230630112135.3347421-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jun 2023 11:21:04 -0400
Message-ID: <CADnq5_O5ZheqKR=n05yZO6BdQN0BQmEjhRYx7--=ORy2B_ueLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
To: Yang Wang <kevinyang.wang@amd.com>
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

On Fri, Jun 30, 2023 at 7:22=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> the dceflck sysnode is not aviable on GFX v9.4.3 chip.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 9ef88a0b1b57..5bf401533103 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2050,7 +2050,8 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
>         } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>                 if (gc_ver < IP_VERSION(9, 0, 0) ||
>                     gc_ver =3D=3D IP_VERSION(9, 4, 1) ||
> -                   gc_ver =3D=3D IP_VERSION(9, 4, 2))
> +                   gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
> +                   gc_ver =3D=3D IP_VERSION(9, 4, 3))
>                         *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>                 if (mp1_ver < IP_VERSION(10, 0, 0))
> --
> 2.34.1
>
