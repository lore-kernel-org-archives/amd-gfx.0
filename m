Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A48EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 03:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7107610E3A9;
	Wed, 21 Jun 2023 03:56:47 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489A910E3A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 03:56:45 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b58e439794so1706494a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 20:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687319803; x=1689911803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9EdQBKx4EeHGzpIYhuR5FkGWFM6fxplogp/PGWLVAc=;
 b=Iluzj6uxsyZxh1NOwjNg7YzhC8x3cWygExb36akI0uK1bLmvHkPLJIklWFmi3oUXmA
 3VqWq0UVj/MFR9Dl39JvffL0BqnoEXVnBVlgnkMB4CuFdDnk4N2779+3N/tNsehoDeyq
 9MeiVPzhQQu+nkyjCfya/VBRHkBMOC6RPqHdFqMWzb9GBxd0pqqDH2bU4F9qT/+E7HCC
 dd5m0wkze56nFB2BPHbzIGeRBUk32if5qcJyBJGQUFQSqbAFNrwwksLCvZH4c+wiFP92
 TONozkSs605JOOEP0SFwO/pRMX/6ojbpJvfZOw+KWZSAnARiQkEmfp2w8yV99Acjm49R
 Sb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687319803; x=1689911803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9EdQBKx4EeHGzpIYhuR5FkGWFM6fxplogp/PGWLVAc=;
 b=Al9701kMHvF2QciUDs9FFj4UH8WDHouU/ZMbcg+7c6gsdvP21AhIilx70LeGUhiAQY
 2BpQAnbfz7NGSbAA2vT38Js9T8S4PI2mQpJLTDTgzlBZTUzgQEfRt8rG5GeLX0iecUL9
 E3Z30Kva2hG96W/n0aOeql+i21bE2Eb8195ZU7bvWSqcIUpaVXIg5w/SZTvQjtu0FUC7
 IMfbhGdntyUzHj4EzBO5/X5kM4/qWbYW1EsME82qOmwqHV/n2cJIlMIJmRvoLcaTN+pg
 x6n5VbE7Rk6glNtov+TMfE5ViSj48H7T6bmpEk9Q1VAZK6kGZMR7ixCwKCsA0Dj58Iko
 bwLg==
X-Gm-Message-State: AC+VfDzjCUCUqiy0e6PMUZUn+NibhqjjarB6n/9kiz8j1jnHw3WPDtKz
 ZCcEKtfG3CTv0jCP3p2x940/F+gE+JstCkVCPMo=
X-Google-Smtp-Source: ACHHUZ5hxG8ciN6+/WEPiZaD+89Y5cVb9EYZERKXv+ZtJaYvxXVOgfdmYqyi6VmKomve8AgHTKDh7eKO3DxdYWWx3aY=
X-Received: by 2002:a05:6870:35c5:b0:1ad:b6b:a6bd with SMTP id
 c5-20020a05687035c500b001ad0b6ba6bdmr1053593oak.39.1687319802835; Tue, 20 Jun
 2023 20:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230620111813.2523-1-christian.koenig@amd.com>
In-Reply-To: <20230620111813.2523-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Jun 2023 23:56:31 -0400
Message-ID: <CADnq5_O5wPwmJX7f=XiPuigeX1b8J2bpS66dK58g-b1GDe=+bg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix number of fence calculations
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
Cc: felix.kuehling@amd.com, Yunxiang.Li@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 20, 2023 at 7:18=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Since adding gang submit we need to take the gang size into account
> while reserving fences.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index d9503882ea97..b34f9f8d33d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -136,9 +136,6 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_p=
arser *p,
>         bo =3D amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>         p->uf_entry.priority =3D 0;
>         p->uf_entry.tv.bo =3D &bo->tbo;
> -       /* One for TTM and two for the CS job */
> -       p->uf_entry.tv.num_shared =3D 3;
> -
>         drm_gem_object_put(gobj);
>
>         size =3D amdgpu_bo_size(bo);
> @@ -912,15 +909,19 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pa=
rser *p,
>
>         mutex_lock(&p->bo_list->bo_list_mutex);
>
> -       /* One for TTM and one for the CS job */
> +       /* One for TTM and one for each CS job */
>         amdgpu_bo_list_for_each_entry(e, p->bo_list)
> -               e->tv.num_shared =3D 2;
> +               e->tv.num_shared =3D 1 + p->gang_size;
> +       p->uf_entry.tv.num_shared =3D 1 + p->gang_size;
>
>         amdgpu_bo_list_get_list(p->bo_list, &p->validated);
>
>         INIT_LIST_HEAD(&duplicates);
>         amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
>
> +       /* Two for VM updates, one for TTM and one for each CS job */
> +       p->vm_pd.tv.num_shared =3D 3 + p->gang_size;
> +
>         if (p->uf_entry.tv.bo && !ttm_to_amdgpu_bo(p->uf_entry.tv.bo)->pa=
rent)
>                 list_add(&p->uf_entry.tv.head, &p->validated);
>
> --
> 2.34.1
>
