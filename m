Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005B5C3DA4B
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 13:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C0910ED17;
	Fri, 12 Jul 2024 13:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D/qGOJwT";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1429C10ED17
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 13:49:54 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2c98a97d1ccso2287767a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720792193; x=1721396993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PhoaUhlD1E8RjZKWCggxTyBUT7WjQYRrZwEsMAHNAQ=;
 b=D/qGOJwTDiunwwAkK0SppbhRfc3Kmu8YMyNf5xY97cJlCt7GD5vE+jDaIuowMFG1uJ
 6Qb7biUZiOqQzLSHt6rhLRpn7ZovAEDvzwjwnXieApv4WgC6LYvawta2a/4atDoAJOE9
 0ZuuNBuWQ32Xr9mlCD4rGMUNTAPfGXWIYcQ0f7qmGzvcV8QVEXU8KO5etUlepdHI+rg+
 j/kztP8zCAUuirP4+rQ/9atr04+fCKsnXhgkOodWPkidAMIGDbpfaMqa0Z2yERCbrIaM
 Q6uJzapXa+FT7n+kQh+Rf+q9u0EJ7M9jnYwxZdwcXqxFPShYmLLkUpzZQai1FGeXxAER
 dQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720792193; x=1721396993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PhoaUhlD1E8RjZKWCggxTyBUT7WjQYRrZwEsMAHNAQ=;
 b=MhHjLZjAYgrsFC3XLg8ojn61AgQ1aDN03qGr6hlZ4Hsg0ogsP5i9FBWYdactkGOyTW
 Iy1z0uwqT7zO77bLIj++JAuMn+1c3xkRDQQbGwYSkzvts1dlp6CB+H7SVuRxbwGhsOVo
 8uFB+ANfDzCKvb6rQsjq9gPkMJ0gGzJHwBoiRP0os+skuL11EZV2+EHBQSCD5Cvz5W0N
 ryGJN9lgzBp6lgiucMWc1SEDEFJWAF73/TSPJuvl0rx4EcMQTppHG+WHhk2SgqcqvUlw
 vftldjs96Jto/OcaAboQZbKQMmyiXuPOJI/7aSy2fRI+MjbPgcOfA+juakA0JPYqfuU6
 Ho9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLOjlvFjMyqQ2Tlon2pLshPrslXvWeoYZcnqBRo2klFeX7hualesX/7NOomcUF9X3aSjiYBwWzPWPL3nTJ81DjMRbiN4f1eJFJgiKdzA==
X-Gm-Message-State: AOJu0YyPLhPiXj8DlBkoVg8VSyhVdoDI/ji9TuxF8KWQqPenjkRhkVZ8
 E86AxXsLyv0hHiKx0FXvyozqHfkXiqiafy8i6Vu19oO6Bkf7xhc1Ql46LQ63xWpXM0HiK5Uem18
 DGXHaICE5Op/21Yllx3Oe6eUQctMU0A==
X-Google-Smtp-Source: AGHT+IG8Mw69I3Oa1JsCsa+a80k9qNv02QljSZefUXMC//8IRQ98T6dtV14IUnwNg9QMtR1e1wWtVRot2/I/4I5W/2k=
X-Received: by 2002:a17:90a:b786:b0:2c2:d590:808e with SMTP id
 98e67ed59e1d1-2cac6e1c82dmr4189255a91.13.1720792193493; Fri, 12 Jul 2024
 06:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240712122317.223571-1-sunil.khatri@amd.com>
 <20240712122317.223571-3-sunil.khatri@amd.com>
In-Reply-To: <20240712122317.223571-3-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Jul 2024 09:49:41 -0400
Message-ID: <CADnq5_Nb+yWngKmXCe4burLHaPS_3qHaahCRxkRkD3_DxVuwFw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/amdgpu: add print support for sdma_v_5_2
 ip_dump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jul 12, 2024 at 8:23=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add support for ip dump for sdma_v_5_2 in devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 05a13086405b..dc1ca2205807 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1722,6 +1722,29 @@ static void sdma_v5_2_ring_end_use(struct amdgpu_r=
ing *ring)
>         amdgpu_gfx_off_ctrl(adev, true);
>  }
>
> +static void sdma_v5_2_print_ip_state(void *handle, struct drm_printer *p=
)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int i, j;
> +       uint32_t reg_count =3D ARRAY_SIZE(sdma_reg_list_5_2);
> +       uint32_t instance_offset;
> +
> +       if (adev->sdma.ip_dump =3D=3D NULL)
> +               return;
> +
> +       drm_printf(p, "num_instances:%d\n", adev->sdma.num_instances);
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               instance_offset =3D i * reg_count;
> +               drm_printf(p, "\nInstance:%d\n", i);
> +
> +               for (j =3D 0; j < reg_count; j++)
> +                       drm_printf(p, "%-50s \t 0x%08x\n", sdma_reg_list_=
5_2[j].reg_name,
> +                                  adev->sdma.ip_dump[instance_offset + j=
]);
> +       }
> +
> +
> +
> +}
>  static void sdma_v5_2_dump_ip_state(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -1760,6 +1783,7 @@ const struct amd_ip_funcs sdma_v5_2_ip_funcs =3D {
>         .set_powergating_state =3D sdma_v5_2_set_powergating_state,
>         .get_clockgating_state =3D sdma_v5_2_get_clockgating_state,
>         .dump_ip_state =3D sdma_v5_2_dump_ip_state,
> +       .print_ip_state =3D sdma_v5_2_print_ip_state,
>  };
>
>  static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs =3D {
> --
> 2.34.1
>
