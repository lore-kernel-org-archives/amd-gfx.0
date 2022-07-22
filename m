Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3176C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 13:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376F193CA2;
	Fri, 22 Jul 2022 13:15:16 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D21193BC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 13:15:14 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id m8so5800138edd.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4+ddiPTel2vFa1kYX8gfVcB4xgjKvz4TiOUm2fZjs1U=;
 b=Ux75VCLqYHZoxBrro68VM9NtcpOqu8BgPz8puYrbyQOg6cHBQWKRSwts+kpyzfuKwW
 gTxX1GbnvOfZZu2i5mC12ojW0R17b6mx8/CKxBz7QrdvGVOA1SXiax5o6MXbMsPZTF+l
 ujQx6GHcDnUBFTSt0ahYYy4XFTmOSRebeEwe/FbfhOtD6+fNTivu19X/r83q35C5t+IH
 Nox+/Q5oMTSxUSm1ELEHHWt/FNHtDhIewG6Zm3E93up94m052edESi5BArUpUm9k8JX/
 zeh6jIDW/DOEWaBZNeXzborgQMXPS6QbTGr/4+fvKqPJofaxz/9ElrMrM6b0AGvDWpTQ
 chmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4+ddiPTel2vFa1kYX8gfVcB4xgjKvz4TiOUm2fZjs1U=;
 b=C17CiWMk08366oEVSt9g+hWlL5uLI/2mRzTQ1WAJX0k+6K7wsrK197427ZPusCqnkg
 epmGZ6tMnhTjUUEysFBGPrpbbN09R29+JYKEi/H6n1DF9Pm/ZoeNMqbK7D6u0x5KZWxN
 uRYtkUOs4piFlVxplEqDETEs0cyoKoIKlmMa4uekTgqmzAYOCeIQ2e07T5AwBl0b9Y/j
 Vb9kn0vd0HnZtay1ee6qKrP8jZ5g2uBedQn8TjKAQx+s7IRtr62M5kp6T/PLDVLjw8TI
 dkKrISNBfeTKClf7+aaImmRAFYbr0DA2zNVCkSBl+Mluqo0LduAsV+qajjD9Watvo3ys
 p7Qg==
X-Gm-Message-State: AJIora9p33LxXBiTkvuraan2UQlOR99XHEoMB2o17+K2A9g4pt+Vz/09
 jyWFjeKfA7+eM/eY6SD/L3uJtC5eysYLfB1Iw0DVpRd/
X-Google-Smtp-Source: AGRyM1vGFewvCOi/UD0VuVrFVyU+ROekpHNu+0pQu9GVTTNyHS2itl69QUkyhtvkhkpujBeGIPEulftks0fctj9A/30=
X-Received: by 2002:a05:6402:500e:b0:43b:6f0:756b with SMTP id
 p14-20020a056402500e00b0043b06f0756bmr631081eda.221.1658495712752; Fri, 22
 Jul 2022 06:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220721095210.37519-1-horace.chen@amd.com>
 <20220721095210.37519-3-horace.chen@amd.com>
In-Reply-To: <20220721095210.37519-3-horace.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jul 2022 09:15:00 -0400
Message-ID: <CADnq5_N0jc==nPZexbAQbtpgaminNKmxuWoZX-D+mM1iygKWgg@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu: add a compute pipe reset for SR-IOV
To: Horace Chen <horace.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 21, 2022 at 5:52 AM Horace Chen <horace.chen@amd.com> wrote:
>
> [Why]
> Under SR-IOV, we are not sure whether pipe status is
> good or not when doing initialization. The compute engine
> maybe fail to bringup if pipe status is bad.

Seems like this should be safe for bare metal too.  Can we just do
this for both to simplify the code?

Alex

>
> [How]
> For SR-IOV, disable the compute engine to do a pipe reset
> before we do initialization.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 0d8193b30fc5..b8f197a5ee84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4586,8 +4586,12 @@ static int gfx_v11_0_hw_init(void *handle)
>                 DRM_WARN("Invalid gb_addr_config !\n");
>
>         if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
> -           adev->gfx.rs64_enable)
> +           adev->gfx.rs64_enable) {
> +               if (amdgpu_sriov_vf(adev))
> +                       gfx_v11_0_cp_compute_enable(adev, false);
> +
>                 gfx_v11_0_config_gfx_rs64(adev);
> +       }
>
>         r = gfx_v11_0_gfxhub_enable(adev);
>         if (r)
> --
> 2.25.1
>
