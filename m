Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E16C77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 14:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E726110E6DE;
	Fri, 12 May 2023 14:59:33 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E1F10E6DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 14:59:31 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-394440f483fso1500231b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683903569; x=1686495569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tvp9FHspBy+i1nmk2Aj6uxeUNLZbM4Ell1pEBnHvEEo=;
 b=hPeWtW/W3uXD5U9MLKRAWyVikmRjRnV5rgHzRlONd9PwIZSLWQL4jHQNwpHBbI10js
 Zdfkgexo3HF4lYkdUAg56hNtHF+dCJCQjn3uUCloo1jASOLCW7l4AK4fa/yACwd3UhsB
 TDDM+/g59gVIHAD1Rniux9gkJhPgRpXtYaYpRkkcWY8D+g4El4coaRU9+xtkHiB/D57o
 C9Ptq+nA1TbT2TsuoYLvz8rZts2limFlN+uVdhmzRQYbQnyUJaC0LyzsjXbhPOd1Ye62
 GzgjOt5xeYlhbQLLezlwSggyogm51E9tPKtLEhzv1I8hFPx0mBuTKMF3Cb1/D7Al+IjU
 cLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683903569; x=1686495569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tvp9FHspBy+i1nmk2Aj6uxeUNLZbM4Ell1pEBnHvEEo=;
 b=Icg/4p0sihbYLZlOsMufZ2PhhUvdTaesT630b904cC0vFuz6PrMZLqLPHsgPlfhguD
 vQM4rMOr+6JihAAt8jwVcYNY7bqFTjvKI0SbQNr9IipHUluU5QSWZOlwS3JmjexxYK38
 pAoPzJSDLqYyvMJOwHyyqf5azSemngXHozW1TvQ4I2S3DTDju0cT0At385z/BU4fFo/k
 kjczZf5+u2e0N9Zzr38mpmgrmpISR6XiSiHtcUErSnLHxOp4KuksBQGIa2jVNEzY+03K
 WUT9Hr9/jOla9R+0x1SnZEREkHudoRFUZ3jbw7M/prAEtfwZUVz/exaopUpavU0jcMJk
 8neg==
X-Gm-Message-State: AC+VfDzDaiqUobkcFAIaZJrVthl9gJJSod3mSF822oyXLGpvy3p0Zm7F
 npttJzXS0oLSCM6/QV5ZG9qCqlmAT3nj6fqQcb90o123
X-Google-Smtp-Source: ACHHUZ5mG3TABAAQa8Ih3M/aTW90YEMyGYEAL9xJiduZRcJg/p79Qw/1dVsSPZunI2PXT/P5NVM0WM0jyWaXgcSM8ws=
X-Received: by 2002:a05:6808:8c1:b0:394:2c0b:9d4b with SMTP id
 k1-20020a05680808c100b003942c0b9d4bmr4364257oij.16.1683903569590; Fri, 12 May
 2023 07:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230512074750.1890604-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230512074750.1890604-1-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 May 2023 10:59:18 -0400
Message-ID: <CADnq5_Ow_8rLEqjXhGLttXKKC_AeGanwjh1xsJm3C2hLPKtxRA@mail.gmail.com>
Subject: Re: [PATCH] amd/amdgpu: perform soft reset for sdma fed error
To: YiPeng Chai <YiPeng.Chai@amd.com>
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
Cc: Tao.Zhou1@amd.com, amd-gfx@lists.freedesktop.org, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 12, 2023 at 3:49=E2=80=AFAM YiPeng Chai <YiPeng.Chai@amd.com> w=
rote:
>
> When testing sdma ib ring fails to detect sdma
> hang for sdma fed error, force to perform soft
> reset.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 3d9a80511a45..1d463e1fd3ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -53,6 +53,12 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
>  #define SDMA0_HYP_DEC_REG_START 0x5880
>  #define SDMA0_HYP_DEC_REG_END 0x589a
>  #define SDMA1_HYP_DEC_REG_OFFSET 0x20
> +#define regRLC_RLCS_FED_STATUS_0                     0x4eff
> +#define regRLC_RLCS_FED_STATUS_0_BASE_IDX            1
> +#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR_MASK    0x00000040L
> +#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR_MASK    0x00000080L
> +#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR__SHIFT  0x6
> +#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR__SHIFT  0x7
>
>  static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev);
> @@ -760,6 +766,7 @@ static bool sdma_v6_0_check_soft_reset(void *handle)
>         struct amdgpu_ring *ring;
>         int i, r;
>         long tmo =3D msecs_to_jiffies(1000);
> +       uint32_t rlc_status0 =3D 0;
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 ring =3D &adev->sdma.instance[i].ring;
> @@ -768,6 +775,15 @@ static bool sdma_v6_0_check_soft_reset(void *handle)
>                         return true;
>         }
>
> +       /* Soft reset should be performed for sdma fed error to
> +        * recover sdma engine, so when testing sdma ib ring fails
> +        * to detect sdma hang, force to perform soft reset.
> +        */
> +       rlc_status0 =3D RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_0);
> +       if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0_FED_E=
RR) ||
> +           REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1_FED_E=
RR))
> +               return true;
> +
>         return false;
>  }
>
> --
> 2.34.1
>
