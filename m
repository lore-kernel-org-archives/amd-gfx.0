Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3847DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 18:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FF710E1F6;
	Fri, 18 Nov 2022 18:53:25 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAEC10E1F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 18:53:23 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id n186so6301359oih.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zyEgt3CIDXW+lBGH59lwEF2egtQVj7pnsYx4GuyQlNU=;
 b=eaNlOgNEY0f+vuhv0VEgCIN9f9GRgGQ7rHL4ahnWVvRgJRurMCf01xyXbw5fZbRdze
 cAb1irOXrkGKGR0xA0wEW+e8cLysFGyLD5y73npFLxi/OdI5NSnSrKrfxezpELo09AWW
 MZJUr7O4IL3R865NSDcFT+jqg2tBn82IKlM4OpJ5027NZOGs74vox/AbCNMoMrrhQ7Tg
 GOlq2l7f7fY0Eck/C2BXYI746gAYOn5t15lUBjCC8k34uZr77pemI9iMo+T9R9M68S4j
 g0im6yctK7ZSQgIHzzMBQqO/xLGHOhcI9CFmicpJiaYy8YPLXfH/UIzWjUfv62lW/qZ5
 8AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyEgt3CIDXW+lBGH59lwEF2egtQVj7pnsYx4GuyQlNU=;
 b=TmLyu+TGmjYVeDR9oxTktsy/2WyeU9j6KEz9OwkIl/1UIfak5CGHwMqnAj3Z5wRkip
 ChQskiyW9RJWdjAM1EKq5M6PeV5fTDJu2F+cMuS4QoKA8VxQvPREc+uvQumcXgFkfrAW
 LtFS4J/kc5TfoIIOEO6VUKvm/j5YY9ABY5f0dOsSo6mjXbg8XgQJmWwgFzRnz1okUYY4
 TCr7Oe/CShyP0f3tA5xECCpgLKXvOD+2EEQTvEuRt1M0g30/rS8j1572OgEhFbGYP/+f
 x3uQhqDwna7dDXQ6rrs756MCL/Saaa6NbXQhtLKTYmorJz2KdiyzUqC/WnJFKBt7I0mg
 HvCw==
X-Gm-Message-State: ANoB5pm7Z22CMlVruk3RcP2JjIWrOoSjn0RPUooCXAY/Riz4pdiP3PXV
 h59W5M3Z3NbYljXm9eToMPy90cx0AS422gS2MBk=
X-Google-Smtp-Source: AA0mqf5PMY7oTNrGSQSkmBI2t0qoGMGqjbBeIAgH4bt6HTSlleA3Yhxuv5EKTLGt5B9iIMwPB3ogjHWJuOhrng9qOiQ=
X-Received: by 2002:a05:6808:9b8:b0:34f:97ea:14d with SMTP id
 e24-20020a05680809b800b0034f97ea014dmr4259263oig.96.1668797602452; Fri, 18
 Nov 2022 10:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20221116160111.3226-1-christian.koenig@amd.com>
 <20221116160111.3226-3-christian.koenig@amd.com>
In-Reply-To: <20221116160111.3226-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Nov 2022 13:53:11 -0500
Message-ID: <CADnq5_Op0Jo24ddTSXaMoHCfec4qzDEuvTFfkyX4RVoYZ-Ux5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: WARN when freeing kernel memory during
 suspend
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 16, 2022 at 11:01 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> When buffers are freed during suspend there is no guarantee that
> they can be re-allocated during resume.
>
> The PSP subsystem seems to be quite buggy regarding this, so add
> a WARN_ON() to point out those bugs.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexdeucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index d0d53e83a318..063bf6f69918 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -428,6 +428,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64=
 *gpu_addr,
>         if (*bo =3D=3D NULL)
>                 return;
>
> +       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
> +
>         if (likely(amdgpu_bo_reserve(*bo, true) =3D=3D 0)) {
>                 if (cpu_addr)
>                         amdgpu_bo_kunmap(*bo);
> --
> 2.34.1
>
