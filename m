Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D58C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 22:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467F810EB18;
	Wed, 19 Apr 2023 22:11:44 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E53E10EB18
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 22:11:41 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-545d82e1a1bso74193eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681942300; x=1684534300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa3PtC8tpurPkv0BGUo0QfkmVrvHlLoI/fycx6+dgc4=;
 b=Ggonuq5zUz+iCy0DfzROJ+8qNc2k6pxu52oKnp54/5se/4+HVOyEytb/YTqN1AQX75
 J8lHUvVm2O6DwcNz24XIVnMqW9ku6tfCtkJoSEuzWl2V5iXpyzR9q+q2oCAvYg/REvqX
 +9QS7AIjuT+ENtOb4y0SmvK9CMklWS+vVnrwDidbatZMpCrIbFj2iu/xs3XjldM0oLbn
 cLQk2dVS3V49NuXZFbVUfa77LOp1PC34emlMqradEPzL++U96JOS+F+l6sGH5m72tT6Q
 OhsbiPilhXMmhzgvGA1BcR/AlLuzgz/YCUiHQPATEU2QeyHXgl1g3K5Qhal5Kd57+ULx
 mFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681942300; x=1684534300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xa3PtC8tpurPkv0BGUo0QfkmVrvHlLoI/fycx6+dgc4=;
 b=j2B8ySnRd5ITRZO4XMTvc+nIyoFRuk4Bp8ZCZTMfHX//HIIaisgo4IPsErQpl4N1d3
 RgA0lTEETsanWRUxHgcdkr3FW+p1pdXkftCiBssgpX0ekbKVl1vP1BR2D+/sx7X3iC1I
 ZcXW2BIEliljlkZEzGevBq3i6zf9S8V89Tt6WafPu/7hDWRVphLikzuA7tcyFXN5Y2VW
 FCfQm/lzM5F3JZs1hIWzImsb3xnvMgq+TnHSeS0YzyMq0mJx1H2GY4KZVKWumEPH81Jv
 68i0mb6xxr90+FBhAOEnQsZg/suJLosS4aaQC3b7MFWYLxU7SgiKTYboEadw3Pe0soTu
 KKCw==
X-Gm-Message-State: AAQBX9cK6Jfyz1FH/JRKx9zuwQQQ/5kHdyac1P5cTZTkiJZLNtya5HcC
 OrI+wf7yc7iVw7aUMQWtfq/H/qu33WqsOUNYuszUBdZ3
X-Google-Smtp-Source: AKy350ZlboijJF0qayioa7YgCbD0+ckiZ34nQXJIfEs0Kq1+Xouz16n/7XeMFgtLmS7aZajHEwg7BWbmoUEgGMMnxqA=
X-Received: by 2002:a05:6870:b607:b0:17a:a59a:e931 with SMTP id
 cm7-20020a056870b60700b0017aa59ae931mr789107oab.11.1681942300241; Wed, 19 Apr
 2023 15:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-10-alexander.deucher@amd.com>
In-Reply-To: <20230330191750.1134210-10-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Apr 2023 18:11:29 -0400
Message-ID: <CADnq5_NWpuXWh3DhYdSkHMLOaTo7xgaKk51bCt+HCmgNkDVPDg@mail.gmail.com>
Subject: Re: [PATCH 09/13] drm/amdgpu: add get_gfx_shadow_info callback for
 gfx11
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

On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Used to get the size and alignment requirements for
> the gfx shadow buffer for preemption.
>
> v2: use FW version check to determine whether to
>     return a valid size here
>     return an error if not supported (Alex)
> v3: drop GDS (Alex)
> v4: make amdgpu_gfx_shadow_info mandatory (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 1fc1e941f7df..7a5da13cffa0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -822,6 +822,27 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu=
_device *adev,
>         soc21_grbm_select(adev, me, pipe, q, vm);
>  }
>
> +/* all sizes are in bytes */
> +#define MQD_SHADOW_BASE_SIZE      73728
> +#define MQD_SHADOW_BASE_ALIGNMENT 256
> +#define MQD_FWWORKAREA_SIZE       484
> +#define MQD_FWWORKAREA_ALIGNMENT  256
> +
> +static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> +                                        struct amdgpu_gfx_shadow_info *s=
hadow_info)
> +{
> +       if (adev->gfx.cp_gfx_shadow) {
> +               shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> +               shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNME=
NT;
> +               shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> +               shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +               return 0;
> +       } else {
> +               memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_in=
fo));
> +               return -ENOTSUPP;
> +       }
> +}
> +
>  static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs =3D {
>         .get_gpu_clock_counter =3D &gfx_v11_0_get_gpu_clock_counter,
>         .select_se_sh =3D &gfx_v11_0_select_se_sh,
> @@ -830,6 +851,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_fu=
ncs =3D {
>         .read_wave_vgprs =3D &gfx_v11_0_read_wave_vgprs,
>         .select_me_pipe_q =3D &gfx_v11_0_select_me_pipe_q,
>         .update_perfmon_mgcg =3D &gfx_v11_0_update_perf_clk,
> +       .get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
>  };
>
>  static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
> --
> 2.39.2
>
