Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7737C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 13:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4292710E7D6;
	Tue, 26 Mar 2024 13:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmWacQIF";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7705310E7D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 13:17:41 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-29e0229d6b5so4206591a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711459061; x=1712063861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPWIjnkAZgYNRjidlLd8FzMHO2l20Uui1pZIRlb2lCA=;
 b=YmWacQIFE2O3YSMMXA7TKishO2GgJZby71Y6PNN1ryU+yH5N9OqhD72QQRHC/Yu15V
 OR60HGqsBYczlngaJxSMps/Xn7EvN9NnKRAyIdiQ4EN/DFJwNi7PHI1j9bYHkjGGcbnm
 D9bebq6IvgZWh3JMy89Bl1q2xWerWSC+7Sdzig9zlWa8Q0Bnqc8mQVp5x6UgPdTeZ5T/
 Q6YAZGJ7gd1KIXdEupkGf8eQ7HrP8Q2uX2J7YU7I27z8M5T0hiYKmR55an4AIeSHQ94u
 PfiWduQ7T5I2SSpofWvq6ApzEGrmuT4Q6kwgkD2VNDu865P0WGof3++iNNK02tjK/bek
 a6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711459061; x=1712063861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPWIjnkAZgYNRjidlLd8FzMHO2l20Uui1pZIRlb2lCA=;
 b=OPrz36I4CmUwaROjQQxqZadHvZmzvlsFSNv4JCzJI2jtt3WzczzdpKk42AVJvJt0SS
 c9UybKtAwYg3AM8on2Ix90un19RLRVRPfnS3WKUlHhbTjo9C7LkhzzLbVbcoCbm8T+7L
 ZuJwFDPURJxW4TiH38zDn1Il63skEijML21vTya42ZLLbkJnhOYbxcvckZTIGhqI6Z0R
 AyPdpvYrcVX+RJM1xgyrYwbBlA30hqi+TKMO7baponxBYHz2XdKNsSsM9kW6q9y3/Vgk
 zNQUhh8AobWldAcmKmEnYSRbvFiCYe7VeTg41JvxP4YbhuONq/foDP4/GNAZnXYS9Bur
 glNA==
X-Gm-Message-State: AOJu0Yyjb2fU9yBSen5wcaRN1e6JPo4AOPayiFk1q6fY/HL/82wJZufO
 jxlT1nWOgNUhB6zurTAnYM/tBG0EFs1KEvKNhWH8dTJnfTYu0Sdn2o1Pg28Yx2EAXM6qVrKvxdi
 GGNCUPkUXgzJ8RUFhyBbtDBx2SJ3FBGFpl5U=
X-Google-Smtp-Source: AGHT+IHlgxidZWUp27IxpKob/wonhaPnCrQf/nq17Uh89pjZMdwo3X5Jw8fvR+w47IQtlIeToXA7GAv18yHaj+8Gj5E=
X-Received: by 2002:a17:90a:eb0c:b0:2a0:5295:3f92 with SMTP id
 j12-20020a17090aeb0c00b002a052953f92mr994655pjz.3.1711459060638; Tue, 26 Mar
 2024 06:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240315061226.1691633-1-zhenguo.yin@amd.com>
 <SA1PR12MB6680EAC544D653060504DE83E9352@SA1PR12MB6680.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB6680EAC544D653060504DE83E9352@SA1PR12MB6680.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Mar 2024 09:17:28 -0400
Message-ID: <CADnq5_PMseagsa03NBGHZ1q3qSfNn339UXnWTZ=L3p+acf1OmA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add pipe1 hardware support
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "mdaenzer@redhat.com" <mdaenzer@redhat.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
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

On Tue, Mar 26, 2024 at 8:28=E2=80=AFAM Yin, ZhenGuo (Chris)
<ZhenGuo.Yin@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi, Alex
>
> Could you please help to review this patch?
> This should fix the bug: https://gitlab.freedesktop.org/drm/amd/-/issues/=
2117.

Please split this into two patches. The HDP fix is a standalone bug
fix.  Please also add:
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2117
With those changes, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thx.
>
> Best,
> Zhenguo
> Cloud-GPU Core team, SRDC
>
> -----Original Message-----
> From: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
> Sent: Friday, March 15, 2024 2:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: mdaenzer@redhat.com; Deucher, Alexander <Alexander.Deucher@amd.com>; =
Koenig, Christian <Christian.Koenig@amd.com>; Paneer Selvam, Arunpravin <Ar=
unpravin.PaneerSelvam@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk=
 <Monk.Liu@amd.com>; Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: add pipe1 hardware support
>
> Enable pipe1 support starting from SIENNA CICHLID asic.
> Need to use correct ref/mask for pipe1 hdp flush.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2117
> Fixes: 085292c3d780 ("Revert "drm/amd/amdgpu: add pipe1 hardware support"=
")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index f90905ef32c7..5eb6f189920b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4518,7 +4518,7 @@ static int gfx_v10_0_sw_init(void *handle)
>         case IP_VERSION(10, 3, 3):
>         case IP_VERSION(10, 3, 7):
>                 adev->gfx.me.num_me =3D 1;
> -               adev->gfx.me.num_pipe_per_me =3D 1;
> +               adev->gfx.me.num_pipe_per_me =3D 2;
>                 adev->gfx.me.num_queue_per_pipe =3D 1;
>                 adev->gfx.mec.num_mec =3D 2;
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
> @@ -8317,7 +8317,7 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct am=
dgpu_ring *ring)
>                 }
>                 reg_mem_engine =3D 0;
>         } else {
> -               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> +               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->p=
ipe;
>                 reg_mem_engine =3D 1; /* pfp */
>         }
>
> --
> 2.35.1
>
