Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EF1C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 15:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC7F10E2D3;
	Mon,  5 Jun 2023 15:17:05 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF54010E2D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 15:17:03 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5559cd68b67so3373061eaf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jun 2023 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685978223; x=1688570223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWjS5fqrXtL4Y6bwiH3YFaO0BMHdo/EW8P/F3fBFrYI=;
 b=WBrHO6LIVecgtSSQWjJMQQHR7llUQJ4Xrf8cBePEW8S8qoWi/Zf6gwVz+r7vC8gzhU
 IVn+WhpL6g+EotmxXIzj5cv3Yr7NIN6GMzB45nvWMhTO/lAMk4MGvXH6WxoiLX2fLShJ
 q7vSyH+7kJLBSkfSEc4Ven1aUXg6FL0S+p2HAbiuaYNGgvZDpjQ56KpCgoJPdZObDJpt
 tBg96dOay7QF0QYI/IU+lRMxt0Lp1m6WxCqgV9uWXbuh3b2oaQFDHU/MhjRLFwzcCMAW
 Fm9GXlLrASv7XJdVBQboCuBX9IJrZAEr9q8/6B3iKKeJ27VLZt1huzzG4FltograbEA7
 SC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685978223; x=1688570223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWjS5fqrXtL4Y6bwiH3YFaO0BMHdo/EW8P/F3fBFrYI=;
 b=e7n3ylrwFLh56dzJOIcnnI1+TOmEZyi3f9m8UKbHvNCNoX7SkxCkrzeEJ1EEAmLYmQ
 3xqpr5X3LPQ/jwRm8wlOyJaa6BRhEZotSiSf/rr0sxtDnFAW+trUhhNII8hx+B0LqT93
 o6XHc02gB941R5Hkl5kLGVebIZgO/FZy1kKHlJp630OHtE33XHjh2eVNdTmlIbQOd3wi
 MHJXZcjna7uueE+sd25t93FISU6FFOneNc+nYtet3yd0qyxapjElrc388LGXwR4840/j
 cY1mG+EM1UgmaLcuofhvc0YWpv2cFoKoHZ4p5tGi1xtvosAdg++4jl/V+VKpqli1qbwn
 94kA==
X-Gm-Message-State: AC+VfDyly7CxjkLX7TsZJ5tXazCuoL4GuLoQ0WpGJExPFZM4Ml2aJxz5
 TzjuNGvAEKZIUsxoqzeOI9tdgp9Y8gimlhJloBLZKjeOPXU=
X-Google-Smtp-Source: ACHHUZ72Iw4ujJaOIdOKKWnXU3V0ExvVPhvLiJPsbF6jQZ2EJYIP4xRZrwVrMbYPgDBVDFQqjOgHjyuNaMjM4kuAbOM=
X-Received: by 2002:a4a:de57:0:b0:555:5348:f2b with SMTP id
 z23-20020a4ade57000000b0055553480f2bmr194944oot.0.1685978222836; Mon, 05 Jun
 2023 08:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230605091122.3363-1-christian.koenig@amd.com>
 <20230605091122.3363-2-christian.koenig@amd.com>
In-Reply-To: <20230605091122.3363-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Jun 2023 11:16:51 -0400
Message-ID: <CADnq5_PgNeHKD=-6i_fd5c3s-6M0nqHX0QWm=EVOH3usYCuJnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: make sure that BOs have a backing store
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
Cc: mikhail.v.gavrilov@gmail.com, Guchun.Chen@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 5, 2023 at 5:11=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It's perfectly possible that the BO is about to be destroyed and doesn't
> have a backing store associated with it.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 2bd1a54ee866..249385985a4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1268,8 +1268,12 @@ void amdgpu_bo_move_notify(struct ttm_buffer_objec=
t *bo,
>  void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>                           struct amdgpu_mem_stats *stats)
>  {
> -       unsigned int domain;
>         uint64_t size =3D amdgpu_bo_size(bo);
> +       unsigned int domain;
> +
> +       /* Abort if the BO doesn't currently have a backing store */
> +       if (!bo->tbo.resource)
> +               return;
>
>         domain =3D amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>         switch (domain) {
> --
> 2.34.1
>
