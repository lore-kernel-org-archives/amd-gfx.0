Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C822CC61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 12:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152D410EB0A;
	Wed, 15 Mar 2023 12:55:50 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338ED10EB0A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 12:55:48 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-17671fb717cso20887060fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678884947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDRdRGJp7k5ZfgoB3Lm0Mu8XPM+IZAnbQYD5RuYZmMA=;
 b=hWgwaDaRUWMSn5QZvEc6aCgufOZNvXSyJHA3w6c6JXX2jJvYT0+pxKstnRuZOh0t91
 AxV8qsMFmqDObTK6xTd4jMRCIE91APXv1i2sGRGwu++ptkHe/bZ43T/HwCOBlk32z4cM
 s5AXUHEBz2CfBc/yJLHYWqshe21mFycLAdx2Rt2SKGNUbU6FIw23Yr3M4KgzdfQvCyw6
 zZj0ElFSEVp6LsWxq6Eb0EnSjsXLN34sxA4PzybFw27+KSlpECaTJlD8MQbsfB7+xKru
 MqbEGXxXbvlzpJFPWcW8p7FBq4Gb5EaM5Rv6clzJLwZf0TS/dDm3teaiFVQerzPtjmut
 ts8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678884947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDRdRGJp7k5ZfgoB3Lm0Mu8XPM+IZAnbQYD5RuYZmMA=;
 b=x/g17X4QvZkPd4TBkbpnGq5h1wxWIZvAYAYF8Wq0zXXtD96XisfBKFdmou4XLNAQ7/
 DyZNBFzaYAIZWcKczndvT+umVd8BQpKMYErCSHdmUi4jAhyLKjqQXIvAB+RueXI8Y8/V
 VVVPy1Jhgya6xIeuk8c+j+mdgD7mkTJhtQRxQbT0Mgk/JtBAo08nth6LfDMX5JxWBfiB
 H7p2lOGCuVD99vEzgv5TPd7GcJL3jb2YDXmbBiPt2yFOyVB4OlYheMXhJdC8pt7aX/oB
 CDGFT6hmHnkIobb/ZU8htTzlkDwaxyooRBEWnRStHiYvJKkJCNfim3TROw/wAjF1REuR
 Qdbw==
X-Gm-Message-State: AO0yUKW1OdkIIT7duqZfPHCmItS1j4I16bJ6cQd+ET6LT1tzIWxkgRao
 J5tNzmvyNmDBCkX2480OcCBk8DBrAIYNF9F1NzM=
X-Google-Smtp-Source: AK7set/W8HujF10cJ7sJg7Mgl7uvmoJzKsw8uyHDh6129lrXSssTVkPxM7XnbVqDsiYdrT1HXmAsmZK7Z7XXLo8YvM4=
X-Received: by 2002:a05:6870:3290:b0:177:9150:e7ba with SMTP id
 q16-20020a056870329000b001779150e7bamr5497915oac.3.1678884947294; Wed, 15 Mar
 2023 05:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230315081327.207785-1-Tong.Liu01@amd.com>
In-Reply-To: <20230315081327.207785-1-Tong.Liu01@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Mar 2023 08:55:34 -0400
Message-ID: <CADnq5_OFhZYLsSpYB2r3_sM3wdM37NHs4p3Tng9a+kSkuqaS+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add mes resume when do gfx post soft reset
To: Tong Liu01 <Tong.Liu01@amd.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, horace.chen@amd.com,
 amd-gfx@lists.freedesktop.org, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 15, 2023 at 4:13=E2=80=AFAM Tong Liu01 <Tong.Liu01@amd.com> wro=
te:
>
> [why]
> when gfx do soft reset, mes will also do reset, if mes is not
> resumed when do recover from soft reset, mes is unable to respond
> in later sequence
>
> [how]
> resume mes when do gfx post soft reset
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 3bf697a80cf2..08650f93f210 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4655,6 +4655,14 @@ static bool gfx_v11_0_check_soft_reset(void *handl=
e)
>         return false;
>  }
>
> +static int gfx_v11_0_post_soft_reset(void *handle)
> +{
> +       /**
> +        * GFX soft reset will impact MES, need resume MES when do GFX so=
ft reset
> +        */
> +       return amdgpu_mes_resume((struct amdgpu_device *)handle);
> +}
> +
>  static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *ad=
ev)
>  {
>         uint64_t clock;
> @@ -6166,6 +6174,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs=
 =3D {
>         .wait_for_idle =3D gfx_v11_0_wait_for_idle,
>         .soft_reset =3D gfx_v11_0_soft_reset,
>         .check_soft_reset =3D gfx_v11_0_check_soft_reset,
> +       .post_soft_reset =3D gfx_v11_0_post_soft_reset,
>         .set_clockgating_state =3D gfx_v11_0_set_clockgating_state,
>         .set_powergating_state =3D gfx_v11_0_set_powergating_state,
>         .get_clockgating_state =3D gfx_v11_0_get_clockgating_state,
> --
> 2.34.1
>
