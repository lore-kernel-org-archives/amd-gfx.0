Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB125E69E95
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C02410E864;
	Mon,  2 Dec 2024 21:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuAUa7lc";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87ECF10E864
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:29:06 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2eea4a358a7so354925a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2024 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733174946; x=1733779746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9/Ak4h3y25UAuoo8e+AqKzDqU66Ir/1b5wVIj1BgVg=;
 b=SuAUa7lcl8kUSPA+E7YMusXRDaqY0HQOcORouTYCt0AL63AAQrhLH8U98nzyUJkbcO
 e6iKuby9h27/R++m0f6LkY2KYU8Joje/v0qqhLgDzkQyc9ZK4ppL2kba3ebKvzFrxU/E
 u8PDZUwVsztxhWdfnx0ARmUyEamCkSZ98k+DeP7UX7NPtReqexvPJTAjvOIQUd/GD9zn
 K18zssKXE8m3F8izXBR7uiybBkQ5w2VsVD+rUMJRYhKVCLaAhH0p3VmidKXguPPAbZVg
 QSaLKUJ3OQhYA5uMYpPXE9JrHyLsxa8w1hE7m/M++pA4A+XLxgRlytTxrqdaOeOR+185
 DoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733174946; x=1733779746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9/Ak4h3y25UAuoo8e+AqKzDqU66Ir/1b5wVIj1BgVg=;
 b=pAIcOWOvNvwIV0g1k0lGvwkbTLGXadMU3KJrMuuxLompAH+S7fn4cAx8x8IcMk/I46
 yEYv/SVu2OMcsTV917u7ya3cEWPbZ41o5T42W8DlRK1H7pFGgScOCGcfuacmkfp4DvfL
 vk4Ng6A+xlCuMckWeb/vr2V2rUohaJhtEsEeENLW2sPYYlgNGQhG04yeZMChatucNZok
 umBqLHdt8Wj7b2IUpPlcUkRnNCRBJrlCqD8s6OmAMcmQ9/3+ev1JAyn+X8Gd/JmcQFxe
 OOex30UO9ZFZmH4EUpy8iXizLxWTC0yS0HQhqt5RtPf0XMt6g9gWGjwpcyqyQ2SOpvl7
 SVPw==
X-Gm-Message-State: AOJu0YzXQfGOM6czT6HZodV/CP2BQGNC9qrB3ioxAUSFqcQa7tH6D+bM
 zD78z6FbFeJD2qfdUw/29D8K/hDynb4tVyAsEx1S5ytM9a2lFHcJl2Gslw1zrSjfjFEVE6DUG9f
 QSPodyZuz1dSHpQAiqvb0gN7mJYsa5w==
X-Gm-Gg: ASbGncu/kfm88FxJeNDgywS0pnO1itCF79I+uzOMKmem0WsrBA/JIen2QGgGrphQ+gG
 BrJUvZPa7290AY1/xTfgM7AG7KsBvgOk=
X-Google-Smtp-Source: AGHT+IGX0zhsu2N1jv/u64jcwXtbpjk6y61PdSJJ1S8ht4LhMHRfi2hnDhEEaVKUF1A+3F+qa/WlexYhcB6LvmTdOuA=
X-Received: by 2002:a05:6a20:6a04:b0:1cf:35db:2c3c with SMTP id
 adf61e73a8af0-1e1653a19a4mr74418637.3.1733174945928; Mon, 02 Dec 2024
 13:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20241127181224.2894983-1-David.YatSin@amd.com>
In-Reply-To: <20241127181224.2894983-1-David.YatSin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2024 16:28:54 -0500
Message-ID: <CADnq5_NnQJE5K=Mvf=HaS5ozNKMEbTRKUEu6TuFOdN_F350y_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: hard-code cacheline for gc943,gc944
To: David Yat Sin <David.YatSin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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

On Wed, Nov 27, 2024 at 1:22=E2=80=AFPM David Yat Sin <David.YatSin@amd.com=
> wrote:
>
> Cacheline size is not available in IP discovery for gc943,gc944.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index cd7b81b7b939..3a43c816f03d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1503,6 +1503,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_=
v2(struct kfd_dev *kdev,
>         if (adev->gfx.config.gc_tcp_size_per_cu) {
>                 pcache_info[i].cache_size =3D adev->gfx.config.gc_tcp_siz=
e_per_cu;
>                 pcache_info[i].cache_level =3D 1;
> +               /* Cacheline size not available in IP discovery for gc943=
,gc944 */
> +               pcache_info[i].cache_line_size =3D 128;
>                 pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                         CRAT_CACHE_FLAGS_DATA_CACHE |
>                                         CRAT_CACHE_FLAGS_SIMD_CACHE);
> @@ -1514,6 +1516,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_=
v2(struct kfd_dev *kdev,
>                 pcache_info[i].cache_size =3D
>                         adev->gfx.config.gc_l1_instruction_cache_size_per=
_sqc;
>                 pcache_info[i].cache_level =3D 1;
> +               pcache_info[i].cache_line_size =3D 64;
>                 pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                         CRAT_CACHE_FLAGS_INST_CACHE |
>                                         CRAT_CACHE_FLAGS_SIMD_CACHE);
> @@ -1524,6 +1527,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_=
v2(struct kfd_dev *kdev,
>         if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
>                 pcache_info[i].cache_size =3D adev->gfx.config.gc_l1_data=
_cache_size_per_sqc;
>                 pcache_info[i].cache_level =3D 1;
> +               pcache_info[i].cache_line_size =3D 64;
>                 pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                         CRAT_CACHE_FLAGS_DATA_CACHE |
>                                         CRAT_CACHE_FLAGS_SIMD_CACHE);
> @@ -1534,6 +1538,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_=
v2(struct kfd_dev *kdev,
>         if (adev->gfx.config.gc_tcc_size) {
>                 pcache_info[i].cache_size =3D adev->gfx.config.gc_tcc_siz=
e;
>                 pcache_info[i].cache_level =3D 2;
> +               pcache_info[i].cache_line_size =3D 128;
>                 pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                         CRAT_CACHE_FLAGS_DATA_CACHE |
>                                         CRAT_CACHE_FLAGS_SIMD_CACHE);
> @@ -1544,6 +1549,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_=
v2(struct kfd_dev *kdev,
>         if (adev->gmc.mall_size) {
>                 pcache_info[i].cache_size =3D adev->gmc.mall_size / 1024;
>                 pcache_info[i].cache_level =3D 3;
> +               pcache_info[i].cache_line_size =3D 64;
>                 pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
>                                         CRAT_CACHE_FLAGS_DATA_CACHE |
>                                         CRAT_CACHE_FLAGS_SIMD_CACHE);
> --
> 2.34.1
>
