Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D9BC54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 14:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685A610E750;
	Fri,  8 Mar 2024 14:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GWeW44GN";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D9410E750
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 14:33:42 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1dc1ff58fe4so15677775ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Mar 2024 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709908422; x=1710513222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgqYtQvsG879MbgbpoxyFpjlrtEkL0cC8NVQecN52wc=;
 b=GWeW44GNwlCvphC4vUpISxjVijqIUIPi8tJF4QVWqo7CJqcgzg17d6u4Q+3bKgjNt0
 GjUDbCvtj7yDqYGlva3oT3+qqeGk5E1Du+jhbeEKXaZh4s0LqTSYhkGdpe7kqHSVyGAU
 nPemRjGKzjGY12glxlAf0VeG7l/q18vd/MC+jEu6kfzSWO89Ho7IZZWLB1rRzZZXlYN8
 zhbihprIeV7dImdm4z2B5+tAuqavGa5/TmoXprHzXl+Xx2xx2ydFk2ZkBgxFz4Bq6Ape
 t5nF7+TbggBtSUXfUADX7EO11aChjACanmj/Xaiv0sBes7IUv7tjHnRgSPDSWfoyNTbw
 6g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709908422; x=1710513222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgqYtQvsG879MbgbpoxyFpjlrtEkL0cC8NVQecN52wc=;
 b=lanIjsq0bkXyOc8tAmdDyNjlph8jRkk8y0XzV5jjDdkImYbkRWPRrgzH8p2Nz2SNeh
 IHMlziqapniBIpGTfVwzWqJjfzKvhwI5rgBOn8ZByX6AEqsdDBvCap2sPg+k2XO+G5SK
 1zKfdRNVyqSblGEaVH5g5F/nz9UFclb5/4rUqUrcPQVMfoJCi7y5yGMP08x3MWRU7NuY
 7CjT39gaMAd1qLh4bqnMl02Fems/YOUo9O4KYMjrLNyo/7l/yoipDI18aI9pT8tLbB4l
 YM3BVlsQfB54hexfq5EP90ZC62LmxjwumNRSSolZ2YjVItPDVFDDO97Vd101WhqgzK3K
 cRBA==
X-Gm-Message-State: AOJu0YyPYBHX8Yi6L+V0R+QstCbfJoU7DIyvNtdwjY9HeSUHtG71k0YZ
 s6SXK7CIVRjhW6gQQ6Pv/vQ2xD1Fwm2D2BDslj0poB/x1dzbew/fmS3rYIIAyjx2pQenKNBrXyZ
 zrKHCgT7J8Ex0jF56piXvgWYUIcbOUKXW
X-Google-Smtp-Source: AGHT+IFhS+GDGS8MFnsTDR+gNvRC5F1qCPfNGw8TzgeSXo+a7vXoLXDpG+sdEBbHIHc0r5k1L8blSWMW7wN19j7Veo8=
X-Received: by 2002:a17:902:654a:b0:1da:1daa:e2bd with SMTP id
 d10-20020a170902654a00b001da1daae2bdmr10831203pln.19.1709908421650; Fri, 08
 Mar 2024 06:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20240308085400.385793-1-Xiaojian.Du@amd.com>
 <20240308085400.385793-7-Xiaojian.Du@amd.com>
In-Reply-To: <20240308085400.385793-7-Xiaojian.Du@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Mar 2024 09:33:29 -0500
Message-ID: <CADnq5_PCJX70A3=_RjAGhR++J45hgXebnhuHOhs-DbNXGKATCA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] drm/amdgpu: add VCN sensor value for SMU 14.0.0
To: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Fri, Mar 8, 2024 at 4:13=E2=80=AFAM Xiaojian Du <Xiaojian.Du@amd.com> wr=
ote:
>
> This will add VCN sensor value for SMU 14.0.0.
>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 47fdbae4adfc..1d6630d20402 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -352,6 +352,12 @@ static int smu_v14_0_0_read_sensor(struct smu_contex=
t *smu,
>                                                        (uint32_t *)data);
>                 *size =3D 4;
>                 break;
> +       case AMDGPU_PP_SENSOR_VCN_LOAD:
> +               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
> +                                                       METRICS_AVERAGE_V=
CNACTIVITY,
> +                                                       (uint32_t *)data)=
;
> +               *size =3D 4;
> +               break;
>         case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
>                 ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
>                                                        METRICS_AVERAGE_SO=
CKETPOWER,
> --
> 2.34.1
>
