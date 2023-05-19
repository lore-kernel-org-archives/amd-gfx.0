Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6EEC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 13:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC59810E217;
	Fri, 19 May 2023 13:44:37 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB6510E217
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 13:44:36 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-390723f815fso1219347b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684503875; x=1687095875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8vIQLzbUG92/Z8jQsRyZEbLxB+l3drJUS07i1usQ4A=;
 b=MEMYSj+Pu9jAtd8sdQhiLXwYkFktMuB/4ZqS+gaqQ6pOldi/zXRZEjzzxlhzaRCFeb
 rBJMpNCiU9tORc3PREqwupfeM57nOzMjp1tMtV1ZIW/tAy6fM4ZZIuokqN23c1g9kWDG
 z4YieiqlQJAaD4NyKdQ7E0t+io0mmmPg7VEb9SV+9yLpIjBcgGA5LTFO4i1u3YtNOKpZ
 f8BzuuOcCjNSwjz+MMPMVXFd2IOpkMruCebRewrUy8IkT2STxSYAZS/62tCWCy8x9oKL
 ycYoxZiOnpq7yC2yhExuQmKbBbK3wgvVA+ehzT9PboiJj1zLvTWsmP7JE64CePZSezjC
 eJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684503875; x=1687095875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8vIQLzbUG92/Z8jQsRyZEbLxB+l3drJUS07i1usQ4A=;
 b=ZAiEvV/OAIKL8cyK/v3qM60lb1zSRMGKXRFZn13pSggsJEvfXrwvUnCLRI5LTPTy4O
 tN13Ua2DZki+kmqslSfM54DsgneoNa+pqrEB+fUuMPCHHl49UgGK7ofUJVfql3XswHzH
 bpFNGBQdpsPa492dIMSuckd3siRpnzQqmoEJL1qRfSz0RxMUVX7KMv4bPC45VzSN0wd4
 GvQajLS/fpA5k54RwQZ+g8wob2LNwOq8NiFeJrQ6bHw0JfVRyx0/nYcntUaqsqq+uiOb
 a9h8LdGlmNo//P+knA4ERCOfMTB6IB/a3EmrKRo97tnxm1QI4r+n+Lv9C6esEnAj+XOD
 jNSw==
X-Gm-Message-State: AC+VfDxgrKkQ7IlCo8NZMB5bDILIS/T3OKsMi1WdpXXDugzAHaNyLf/r
 NI5PiGG8KOcPt2eQKLhDdvn5ovvkULXKQWfAUNHQTbh3
X-Google-Smtp-Source: ACHHUZ5vqv11f7Q3lTW3d9SgFMo1dd8r+q2Ku6Dnj8DKF7/hFn43b3SbGocn/3gLbeAAmxKlrRbCQpJkakyx6mwI74E=
X-Received: by 2002:a05:6808:b38:b0:394:4efb:faa1 with SMTP id
 t24-20020a0568080b3800b003944efbfaa1mr1108898oij.17.1684503875283; Fri, 19
 May 2023 06:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230519044153.16726-1-shiwu.zhang@amd.com>
 <20230519044153.16726-2-shiwu.zhang@amd.com>
In-Reply-To: <20230519044153.16726-2-shiwu.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 09:44:24 -0400
Message-ID: <CADnq5_N4ULGKXSO9nHNPePiZLZ=ZEtiiF93WciiTiszKnSj61g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Disable interrupt tracker on NBIOv7.9
To: Shiwu Zhang <shiwu.zhang@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, May 19, 2023 at 12:42=E2=80=AFAM Shiwu Zhang <shiwu.zhang@amd.com> =
wrote:
>
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> Enabling nBIF interrupt history tracker prevents LCLK deep sleep,
> hence disable it
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                        | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd=
/amdgpu/nbio_v7_9.c
> index ad70086de9b5..e082f6343d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> @@ -432,6 +432,8 @@ static void nbio_v7_9_init_registers(struct amdgpu_de=
vice *adev)
>         WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
>                 0xff & ~(adev->gfx.xcc_mask));
>
> +       WREG32_SOC15(NBIO, 0, regBIFC_GFX_INT_MONITOR_MASK, 0x7ff);
> +
>         inst_mask =3D adev->aid_mask & ~1U;
>         for_each_inst(i, inst_mask) {
>                 WREG32_SOC15_EXT(NBIO, i, regXCC_DOORBELL_FENCE, i,
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.=
h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h
> index 033f2796c1e3..c8a15c8f4822 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h
> @@ -6201,6 +6201,8 @@
>  #define regNBIF_SHUB_TODET_SYNCFLOOD_CTRL2_BASE_IDX 8
>  #define regBIFC_BME_ERR_LOG_HB                                          =
                                0xe8ab
>  #define regBIFC_BME_ERR_LOG_HB_BASE_IDX 8
> +#define regBIFC_GFX_INT_MONITOR_MASK                                    =
                                0xe8ad
> +#define regBIFC_GFX_INT_MONITOR_MASK_BASE_IDX 8
>  #define regBIFC_HRP_SDP_WRRSP_POOLCRED_ALLOC                            =
                                0xe8c0
>  #define regBIFC_HRP_SDP_WRRSP_POOLCRED_ALLOC_BASE_IDX 8
>  #define regBIFC_HRP_SDP_RDRSP_POOLCRED_ALLOC                            =
                                0xe8c1
> --
> 2.17.1
>
