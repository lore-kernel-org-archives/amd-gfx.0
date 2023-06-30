Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BCFEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BE210E49B;
	Fri, 30 Jun 2023 15:26:27 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474B510E49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:26:25 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-39cc64e4a44so1208683b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688138784; x=1690730784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Tq9yb5ymAuGlgO5FmtVnIoFs2cu/LM9Vw/aDE+S5iE=;
 b=lwpAjON/VpjrA96XzTiJ6EmpIL4gxuCjTqIctKD1RIrJTUu8+7nHpmXzZPjGjCenfB
 RyPcwqCstXNTNzYXNivSV6Rfqpy7gaNoBOwISciCu/Sa8+DqVn8/FYQz21ArgrGO7C1W
 NIZg4tr6HD/DPk64g2qVlAjB23+JdxPv+Oap+qvPfsf8cid+h2hEofWP48OKkPCJ0OEZ
 Tg49u4m2F58zhFTzM5vxdgTLSO8XK5yR82J1YiQaS3DxqkBvUepCJ9PJtSWCXJ1w+O6z
 mdYXbravYObP9xJF1VIhl9wvIt1Ro1shSbL4kPzCLR/kVm+cuCsQDRDfJQdnp4BAaZmy
 qCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688138784; x=1690730784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Tq9yb5ymAuGlgO5FmtVnIoFs2cu/LM9Vw/aDE+S5iE=;
 b=bPe6WYNhbveamnyNWNcg4a1027IsBrS2fBbg6T6/OiTdcuxMGLVLhOH5rPriSAcfrD
 ooQHg9/Dx6m3hnDHf7rfPRmH0YDC9KnuiIJV5qP4x3JTllRUOnRnSvgJ5TXQtcFX8H/S
 rukOEayLjZ/YAsfZsqFJjX63G/nyq0cJXHRuRouqa7mtUfDijaXZT3fzOPCBoss6nlYs
 tWOdTL+XMGUPKsgcOEZd/F8NqKVEpQi8BMQTzdSxaOZdIes3veAwhY/hsxlk3x6plDZF
 jLicaJVbebAliKZBKTEHxrJcRg9Jl9/dS+Pc8cpu3Gotq0OWVTlhpBvIEEIcf0MW8pXA
 gPBA==
X-Gm-Message-State: AC+VfDx+yCjrXDtzkJrxpZyDpxdrG4acw3FAhmZJT/ihKRkOFfGpHvWW
 NEjpvdystgmdp0H0WiOqtzCEy7H802zfzvDpYaeAiZZi
X-Google-Smtp-Source: ACHHUZ7g0yBKK++MvVEbUV6sEfjaP5iG6EI8UiWlHq8vn5HTkC7r+3ALT8+Y36wZP4N1tqUp8jBrcEE1FyvGY7iXYdY=
X-Received: by 2002:a05:6808:651:b0:3a1:dc0d:f31f with SMTP id
 z17-20020a056808065100b003a1dc0df31fmr2609835oih.3.1688138784369; Fri, 30 Jun
 2023 08:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230630000408.686895-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20230630000408.686895-1-sreekant.somasekharan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jun 2023 11:26:13 -0400
Message-ID: <CADnq5_MAc2YFiahoYp85mHYVpL01m26hwAZNzTehu-2hgrBRhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add cu_occupancy sysfs file to GFX9.4.3
To: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
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

On Thu, Jun 29, 2023 at 8:05=E2=80=AFPM Sreekant Somasekharan
<sreekant.somasekharan@amd.com> wrote:
>
> Include kgd_gfx_v9_get_cu_occupancy call inside kfd2kgd_calls for
> GFX9.4.3 to expose cu_occupancy sysfs file.
>
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 5b4b7f8b92a5..0ac5377a2fe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -379,6 +379,7 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>                                 kgd_gfx_v9_get_atc_vmid_pasid_mapping_inf=
o,
>         .set_vm_context_page_table_base =3D
>                                 kgd_gfx_v9_set_vm_context_page_table_base=
,
> +       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>         .program_trap_handler_settings =3D
>                                 kgd_gfx_v9_program_trap_handler_settings
>  };
> --
> 2.25.1
>
