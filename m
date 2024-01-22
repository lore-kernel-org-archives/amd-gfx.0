Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65FDC47DD9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 15:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD0310F411;
	Mon, 22 Jan 2024 15:29:20 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2115510F411
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 15:29:13 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-2144ce7ff41so461692fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 07:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705937290; x=1706542090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7P44KWjvJ0ZIPFLsvWhWpxySxhD0P5QRmYy377O6go=;
 b=EAMdrmdrKsJ4v0m7GC2fgXqlr/xR64JOpfugzCqcxUCe2ucMVqVque5MuSik6nwQFg
 UCYQynpaixUloopmtEiWmcvyolpPzbLyBoZxCq+TK3ozZ1bfbpHiFqutj3wnEPAF1Hp5
 nZnsos8P9Vd7k655NCQZIywK9+6rtzXUpxEymGdWE66fybHlLlNFc4i3Ppl5gDvJ19Lx
 9mvpZh4t4pc7JHqaFBz8V0seZ7QEF2I7AL0m319qEQvlwI1n4m3R7UhmiWPRGYxfZ9Oi
 7EN6nEr2A1XtWQbh9DVg9ROKf/XwNhnbymwnjS3l44d0TpMC9CpIoE6Bs5/TNkpK4jXv
 QANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705937290; x=1706542090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7P44KWjvJ0ZIPFLsvWhWpxySxhD0P5QRmYy377O6go=;
 b=sIPTqcUymPsuD09um3FTut4pP7Qeuhflw2oP6MC0fEhezZysxyjF1kOhcVa05r0slw
 glpW8KA17SFk0M0v3nIKTFrghk6VII1PcF+m1MNSKMp2K9pIw2slbHFmY7chLVGwYjxk
 C05yNIDH7OHmyIHtNy7cvsfoN2uZkRGa6MnTCa75S8QfA2GHkULOCKPbjJAVeiFpemJN
 f0ex3tqOAPq1VbxIO8lnt8d1n9WkAw+dcYH1jBSbiSqYiZnt6FBz429ggxQIqtQrLOUj
 xTMxh1bJZwGZDXKUynxTIRsNBu7k1P8uXjBPnp2C6DK/zbN7eKp1ZM99ENJeopEeoz5y
 W48g==
X-Gm-Message-State: AOJu0Yy2PNJqx/1V7oYmTF40335dagmgAtn+2RgkfQpBjVWW/UM+5OfC
 M9fUUzqOvZoXDVxNYlq2lKTGxm6gMgzC0+HxwQdJulyYGL5QYHmHgELSDbf+UfJu8nwgjkVKEUQ
 d+3gJrnhh2RLbYSzCFmMjdEY9+SSC+B/a
X-Google-Smtp-Source: AGHT+IErX5qtNpwf9XLe2qx6+X2n41VY/NhUfIew8Dap2NdfKDO5AJhM3VcLPLXyyJcG2Yy9sJLBOqjAlP7U08E+NnQ=
X-Received: by 2002:a05:6871:28a:b0:210:d1b9:dda3 with SMTP id
 i10-20020a056871028a00b00210d1b9dda3mr77357oae.52.1705937289988; Mon, 22 Jan
 2024 07:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20240120022118.2648843-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20240120022118.2648843-1-Joseph.Greathouse@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jan 2024 10:27:58 -0500
Message-ID: <CADnq5_MECChFNo2+NvJps4QPgOE+78fUidfm3bRJCv+KMEKjoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add cache line sizes to KFD topology
To: Joseph Greathouse <Joseph.Greathouse@amd.com>
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

On Fri, Jan 19, 2024 at 9:46=E2=80=AFPM Joseph Greathouse
<Joseph.Greathouse@amd.com> wrote:
>
> The KFD topology includes cache line size, but we have not been
> filling that information out unless we are parsing a CRAT table.
> Fill in this information for the devices where we have cache
> information structs, and pipe this information to the topology
> sysfs files.
>
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 93 ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
>  3 files changed, 94 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index cd8e459201f1..002b08fa632f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -55,6 +55,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -64,6 +65,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache (in SQC module) per bank *=
/
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -73,6 +75,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache (in SQC module) per bank */
>                 .cache_size =3D 8,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -88,6 +91,7 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -95,8 +99,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] =
=3D {
>         },
>         {
>                 /* Scalar L1 Instruction Cache (in SQC module) per bank *=
/
> -               .cache_size =3D 8,
> +               .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -104,8 +109,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[]=
 =3D {
>         },
>         {
>                 /* Scalar L1 Data Cache (in SQC module) per bank. */
> -               .cache_size =3D 4,
> +               .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -135,6 +141,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -144,6 +151,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -153,6 +161,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -162,6 +171,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 4096,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -174,6 +184,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -183,6 +194,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -192,6 +204,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -201,6 +214,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 1024,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -213,6 +227,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -222,6 +237,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -231,6 +247,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -240,6 +257,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 1024,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -252,6 +270,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -261,6 +280,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -270,6 +290,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -279,6 +300,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 2048,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -291,6 +313,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -300,6 +323,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -309,6 +333,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -318,6 +343,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 8192,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -330,6 +356,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info=
[] =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -339,6 +366,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info=
[] =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -348,6 +376,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info=
[] =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -357,6 +386,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info=
[] =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 8192,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -369,6 +399,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -378,6 +409,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -387,6 +419,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -396,6 +429,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] =
=3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -405,6 +439,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 4096,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -417,6 +452,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[]=
 =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -426,6 +462,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[]=
 =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -435,6 +472,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[]=
 =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -444,6 +482,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[]=
 =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -453,6 +492,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[]=
 =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 1024,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -465,6 +505,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -474,6 +515,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -483,6 +525,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -492,6 +535,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] =
=3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -501,6 +545,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 2048,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -513,6 +558,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache=
_info[] =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -522,6 +568,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache=
_info[] =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -531,6 +578,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache=
_info[] =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -540,6 +588,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache=
_info[] =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -549,6 +598,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache=
_info[] =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 4096,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -558,6 +608,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache=
_info[] =3D {
>                 /* L3 Data Cache per GPU */
>                 .cache_size =3D 128*1024,
>                 .cache_level =3D 3,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -570,6 +621,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_=
info[] =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -579,6 +631,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_=
info[] =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -588,6 +641,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_=
info[] =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -597,6 +651,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_=
info[] =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -606,6 +661,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_=
info[] =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 3072,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -615,6 +671,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_=
info[] =3D {
>                 /* L3 Data Cache per GPU */
>                 .cache_size =3D 96*1024,
>                 .cache_level =3D 3,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -627,6 +684,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cac=
he_info[] =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -636,6 +694,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cac=
he_info[] =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -645,6 +704,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cac=
he_info[] =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -654,6 +714,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cac=
he_info[] =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -663,6 +724,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cac=
he_info[] =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 2048,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -672,6 +734,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cac=
he_info[] =3D {
>                 /* L3 Data Cache per GPU */
>                 .cache_size =3D 32*1024,
>                 .cache_level =3D 3,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -684,6 +747,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_inf=
o[] =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -693,6 +757,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_inf=
o[] =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -702,6 +767,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_inf=
o[] =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -711,6 +777,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_inf=
o[] =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -720,6 +787,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_inf=
o[] =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 1024,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -729,6 +797,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_inf=
o[] =3D {
>                 /* L3 Data Cache per GPU */
>                 .cache_size =3D 16*1024,
>                 .cache_level =3D 3,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -741,6 +810,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_in=
fo[] =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -750,6 +820,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_in=
fo[] =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -759,6 +830,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_in=
fo[] =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -768,6 +840,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_in=
fo[] =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -777,6 +850,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_in=
fo[] =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 2048,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -789,6 +863,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[]=
 =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -798,6 +873,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[]=
 =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -807,6 +883,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[]=
 =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -816,6 +893,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[]=
 =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -825,6 +903,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[]=
 =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 256,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -837,6 +916,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info=
[] =3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                           CRAT_CACHE_FLAGS_DATA_CACHE |
>                           CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -846,6 +926,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info=
[] =3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                           CRAT_CACHE_FLAGS_INST_CACHE |
>                           CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -855,6 +936,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info=
[] =3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                           CRAT_CACHE_FLAGS_DATA_CACHE |
>                           CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -864,6 +946,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info=
[] =3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                           CRAT_CACHE_FLAGS_DATA_CACHE |
>                           CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -873,6 +956,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info=
[] =3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 256,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 128,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                           CRAT_CACHE_FLAGS_DATA_CACHE |
>                           CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -885,6 +969,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] =
=3D {
>                 /* TCP L1 Cache per CU */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -894,6 +979,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] =
=3D {
>                 /* Scalar L1 Instruction Cache per SQC */
>                 .cache_size =3D 32,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_INST_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -903,6 +989,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] =
=3D {
>                 /* Scalar L1 Data Cache per SQC */
>                 .cache_size =3D 16,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -912,6 +999,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] =
=3D {
>                 /* GL1 Data Cache per SA */
>                 .cache_size =3D 128,
>                 .cache_level =3D 1,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> @@ -921,6 +1009,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] =
=3D {
>                 /* L2 Data Cache per GPU (Total Tex Cache) */
>                 .cache_size =3D 2048,
>                 .cache_level =3D 2,
> +               .cache_line_size =3D 64,
>                 .flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                 CRAT_CACHE_FLAGS_DATA_CACHE |
>                                 CRAT_CACHE_FLAGS_SIMD_CACHE),
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.h
> index 74c2d7a0d628..300634b9f668 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> @@ -303,6 +303,7 @@ struct kfd_node;
>  struct kfd_gpu_cache_info {
>         uint32_t        cache_size;
>         uint32_t        cache_level;
> +       uint32_t        cache_line_size;
>         uint32_t        flags;
>         /* Indicates how many Compute Units share this cache
>          * within a SA. Value =3D 1 indicates the cache is not shared
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 83024c6bdd50..3df2a8ad86fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1564,6 +1564,7 @@ static int fill_in_l1_pcache(struct kfd_cache_prope=
rties **props_ext,
>                 pcache->processor_id_low =3D cu_processor_id + (first_act=
ive_cu - 1);
>                 pcache->cache_level =3D pcache_info[cache_type].cache_lev=
el;
>                 pcache->cache_size =3D pcache_info[cache_type].cache_size=
;
> +               pcache->cacheline_size =3D pcache_info[cache_type].cache_=
line_size;
>
>                 if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA=
_CACHE)
>                         pcache->cache_type |=3D HSA_CACHE_TYPE_DATA;
> @@ -1632,6 +1633,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_pr=
operties **props_ext,
>                 pcache->processor_id_low =3D cu_processor_id
>                                         + (first_active_cu - 1);
>                 pcache->cache_level =3D pcache_info[cache_type].cache_lev=
el;
> +               pcache->cacheline_size =3D pcache_info[cache_type].cache_=
line_size;
>
>                 if (KFD_GC_VERSION(knode) =3D=3D IP_VERSION(9, 4, 3))
>                         mode =3D adev->gmc.gmc_funcs->query_mem_partition=
_mode(adev);
> --
> 2.20.1
>
