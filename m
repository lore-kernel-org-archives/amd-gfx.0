Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25969C77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C198110E304;
	Wed,  3 May 2023 15:35:51 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036B910E304
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:35:49 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39212bf4ff0so2677761b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683128147; x=1685720147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N66tuvo9MUa9M/fdhmVpGOul3K8h34H937ChdJxtfW0=;
 b=TwuyjpC6rnxJTcq6JSniaOx4qDAh92sBct2qkr/CjJfCZ75MjUg0vtJFs7JilNQ1e/
 5AKtQmqa/usyzDMxO2ZC+JOSFB/7vDNijOmZAj/Ufn+s4P/NsrN9NJNCocb6g7WKsx9D
 666ECo+fyvgRajpJXyxNIwT0MuIBGmrXCSTj/olDQSqIdW5A9Q0N2vyEET1KOyCyiMfQ
 /AFvBbwJbWNC4E8/5R5vbm0GJlFnODtaxSJGp5OdLlN/mW1cc3gZ221EHsHwmsDHsnhe
 LI+c5AArQLf5l515P4taTTznWHDpd9PKvk0gMY5ySny4aU3kY1MozvIkd558RAbcKlZV
 NFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683128147; x=1685720147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N66tuvo9MUa9M/fdhmVpGOul3K8h34H937ChdJxtfW0=;
 b=SsCvPj6oCqUAxt/6Raaw824TSwzgMveyo9RXI7USAF53kKxvnBUAaBZ0/DWUfYl9Oy
 UIwCtqqu1eHKZIaXN5mncpgEdaCH7S5YSuj6NWK50hMeqQ4GMDeGeUnjpxfKSPvvHZpL
 hdnx0qYiPmo9YFYuqwfbzwrjL2bfwX6LbxjUoATtXq+mTRcRDLEfrqDtV6kM+iPrKn6Q
 OjC9eZr690OLVU+vZJ2e8uBLE0p8yKrsA2c8rSZxlAY+6aC+V4ZtAEbhqr92A6Fw0Wjb
 7KjN6jKbhSzr14ZA0qrmBzyvhRMx0SeImvVe2g5oZcdZYoWcseuywoQdq5PYhmXkZE3k
 4DHQ==
X-Gm-Message-State: AC+VfDxTUJaIXzNy5VB6sOa5MuS9tFeov7nCEZPYmKUs3QXbQ+HZdHcM
 x44+viT60cSyP6O6twW5wcdxkMNMz0IKd7Q7ty0=
X-Google-Smtp-Source: ACHHUZ6eePrhA/wDgseDCOtU13YUT9fnksyCK+IuKRLgtkaw5ORBNcGN3YKyfZD27AHqBcM8v+Knj+duEYpLvP/rb+E=
X-Received: by 2002:a05:6808:278e:b0:392:6077:e36e with SMTP id
 es14-20020a056808278e00b003926077e36emr119275oib.44.1683128147636; Wed, 03
 May 2023 08:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <cb48ef1c-5f1a-449f-a9f6-909042661ce6@kili.mountain>
In-Reply-To: <cb48ef1c-5f1a-449f-a9f6-909042661ce6@kili.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 May 2023 11:35:36 -0400
Message-ID: <CADnq5_Np18c8T=jy6OEcKU3GejoWFn8V-crf+70Sz7rq05b7_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: unlock on error in gfx_v9_4_3_kiq_resume()
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Le Ma <le.ma@amd.com>,
 Morris Zhang <Shiwu.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, May 3, 2023 at 11:29=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Smatch complains that we need to drop this lock before returning.
>
>     drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1838 gfx_v9_4_3_kiq_resume()
>     warn: inconsistent returns 'ring->mqd_obj->tbo.base.resv'.
>
> Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v=
9_0")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The Fixes tag is weird, but I think it's correct?
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 56a415e151d4..552729a514d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1827,8 +1827,10 @@ static int gfx_v9_4_3_kiq_resume(struct amdgpu_dev=
ice *adev, int xcc_id)
>                 return r;
>
>         r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r !=3D 0))
> +       if (unlikely(r !=3D 0)) {
> +               amdgpu_bo_unreserve(ring->mqd_obj);
>                 return r;
> +       }
>
>         gfx_v9_4_3_kiq_init_queue(ring, xcc_id);
>         amdgpu_bo_kunmap(ring->mqd_obj);
> --
> 2.39.2
>
