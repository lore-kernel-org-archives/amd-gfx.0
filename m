Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8DAEEAA41
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 13:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A488210E281;
	Thu, 14 Sep 2023 13:35:19 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667DA10E281
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 13:35:17 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1d1b55882a4so450222fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694698516; x=1695303316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzY2M/f5qabl6f+6JdcKWJpi07kAlGzr1dxCD44iEiY=;
 b=g6VA/8thRPyct3q3l5dHUvbiHqXAJPGoiVN/BRRvVvcg7eOyGCRfxonPx8ABh6fN53
 C38BCqXnQ5d9+rILKCc+GgGbwlUHfSgzMgH/OE6qaIczOE5GAKGz1uIjn0NluPn0lmLM
 ZPgXfNYeJCUwO8KNOXR8AVsjdFqZ18UPahBQjiXkEDB8jTBmAShNtXOUIgPImXoFRmvc
 YDcJXqZawNDMfxySrUC7ZDSAzFgspXbvzeOZmDvTogf1ztwETlaDP6lmfxdch5xMMiG8
 inEeXnIFJIS1/IsMGNDU0npdM0pCXWbGo/T4xZDyeOYyiBftrovgJTizKo8WDzp+rV1Z
 /RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694698516; x=1695303316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzY2M/f5qabl6f+6JdcKWJpi07kAlGzr1dxCD44iEiY=;
 b=xCL5zQMo3pmqKuQ6cEunSvRHPmNc5TmsNhu+t2/OC9J6kel/nXlvjh7qC9FQfKqR+Q
 c3olFgGClk93Nd+8H9LBJuIFgxswB6QHdJzYXwIk5f7MGkcB+CBTZFT54dNX5/4FgO5F
 RLHdOQsJkL5tU1KNZoFVcILSaziL/u2eyC3GIeGAXtqlXfNQRKDlf+QP660mtZa4jX6+
 OOycWjVBToNma+P7TICF/2MYIhHwxeQA2I92IHXRf2VRHWXg85NUJvXeCxeoNIKbC9Za
 xhNiuDcjE9V/MuJA5UySxmuqtWTQSvBxTwKCQQi8hcsuwdHxPMOCADj8xh1XSbEOY/hM
 K4FQ==
X-Gm-Message-State: AOJu0Yysy4YxowjoHpQBNoql/aBmrmh7iZ0yMPVLWH4S11wcT8ZNLESh
 HT422NzJixmn31WG7miHCPWKU9MAfZjnCOmfHNlp9ef9
X-Google-Smtp-Source: AGHT+IEbUqoa1m53mt3GACjWBrYQiLFfbUWxIYZe2BjA17hX5aqCjrLn3GbztqwOVtW3bCFwUVRCddVyV4T77nJUQ9g=
X-Received: by 2002:a05:6870:6694:b0:1d6:4641:8fe8 with SMTP id
 ge20-20020a056870669400b001d646418fe8mr881776oab.47.1694698516552; Thu, 14
 Sep 2023 06:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230914130541.1235831-1-lijo.lazar@amd.com>
In-Reply-To: <20230914130541.1235831-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Sep 2023 09:35:05 -0400
Message-ID: <CADnq5_PFihWAEHtwJPUy_z2BdioyrwAD1XWrGm8tJz5yW28WHg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Remove SMUv13.0.6 unsupported feature
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, kevinyang.wang@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 14, 2023 at 9:31=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Selectively updating feature mask is not supported in SMU v13.0.6.
> Remove the callback corresponding to that.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 94b0a7226ba4..4ba6790cac5a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2222,7 +2222,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_f=
uncs =3D {
>         .allow_xgmi_power_down =3D smu_v13_0_6_allow_xgmi_power_down,
>         .log_thermal_throttling_event =3D smu_v13_0_6_log_thermal_throttl=
ing_event,
>         .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> -       .set_pp_feature_mask =3D smu_cmn_set_pp_feature_mask,
>         .get_gpu_metrics =3D smu_v13_0_6_get_gpu_metrics,
>         .get_thermal_temperature_range =3D smu_v13_0_6_get_thermal_temper=
ature_range,
>         .mode1_reset_is_support =3D smu_v13_0_6_is_mode1_reset_supported,
> --
> 2.25.1
>
