Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7379DC88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50B910ED09;
	Wed, 16 Sep 2026 17:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZjiawt7";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB1D10ED10
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:57:11 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396673bd283so210190a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 10:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789581431; cv=none;
 d=google.com; s=arc-20260327;
 b=G2wBXsX/1ICmzRooS18+qQk6BMbLhgSM92oyiXsPgRgUKJMuZYxysEPsqBrnpGnoSd
 SbndKwSncEn8EsXDfFJ4AIzkyx8kjldAqSxDwA/Z7Zs3kqP9AhTZX58grTpBoSFOCwRX
 /VqcTYdl0JGA/Dc2SAcfmf/rlPJwE3cNXnLDSlA7Drd7bSITUq6Lm9NI6Wz4/BQTGPJH
 m71N/DpHnoXjYYL8xpX4K5u4d2u36686bDdxBcQGrMNRXn7nCz2dIstC8nRMnaEUzPMS
 L5R5K1iwxka09M1MgxgBiJ2D2TVtldcMTvDJBOlFH30y7WJot98zFCC+s9WW7O3vwySk
 7fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bRhmmCrAtVPev1jQLA09AINV4vc5qQ/mpuw1U6wCpOQ=;
 fh=hc/BLZFObJVhLCUqC1oiwO84FSWzCpju30n1XM0jJdQ=;
 b=syIEx1yLBv9WEc+C5yUzKPuaWs+lvN0CJrfLqbrezmSQkj623/qw8zrzF65Niwtc10
 eFEacFU4wiOTtflnTdmtWKw76f6UkJMG3n7nP58HiUE0qRgDNMZbsfbA8X2kV2B2xPZP
 rD2Ypui4eXBeqXnmuAjRMQ49/cGwScak8cs+3PQsWyHGYR2t636vKpJcAsk35A0ziMTq
 1ZI6zVa0i/u41j5XbNpivvBiXZ+DTfjxRVInA2qZ77nDDXFC98KfFSFGU63BnuQKdMEJ
 UO57ocBN7sKt+GcQLwfYihlt6C2GoYjiAhuQwV3BPJsmry8b8r8YaHTORtOmlXD2ZsJ6
 0LtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789581431; x=1790186231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bRhmmCrAtVPev1jQLA09AINV4vc5qQ/mpuw1U6wCpOQ=;
 b=JZjiawt7DOi9MRWB6haEQtK8c+kiIH9iitR+NkeF2asLJbfeO9Ea69be1CI5ROcZ23
 M0Zu9DpAaNaBPSeQuTTuEhxXCX49Yaz/yk67Ix/qzOXTABIKcVUpdWSEVcslEjUyOkU0
 jTYew+AIMjmhikDo64qawIjvjtkguVcLrARD/lUKDvc46YzZoSh/PTNqUCYbGBsxfyui
 b6XZkmCZY+/6gg32DMj12VVaMjuaDgSzMbeN5elNyYV9zQbK4gnSkKHQGowtoQzucnil
 qjcmvewpUTbqf2LIvp9TthSbnWOx29R5JFa/XEGE4q9YaD2DQFC1fwQx1YA2/FHT3DAB
 pciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789581431; x=1790186231;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bRhmmCrAtVPev1jQLA09AINV4vc5qQ/mpuw1U6wCpOQ=;
 b=gcqa4z5nb+M3wKp4chA/+cV5CSWF6SqB0lh4ax4dq5DZfj5Hqja/eISmn6owlDCQ9X
 R0FTb41SinWnVpObOP2cLTqzF/pr2keZAo9Rs7jekYKr2StjkM47ka10W7dJPIwAhoXG
 j3YxKfx6J1mTtWdXbG9IvzJnsXc2DDG44tk6sEd8v7+FaLCfIrM8xJ5kSq/TqAMdNY4a
 DN8s0qyXJBv7naf3xjQDzoSD08LBVOJGogJ3rSMpZHmf0vFk4l9urK90VDtKiC9QdQ4+
 /SGX8A+iv+seu6v1Kvj2Hk6nnzBEuDbS9IpIWbVDrgmAG4rDjt6KGusXEHktoG8yTrRw
 AJ1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvK21D7xRPi5RQtQvAjSg/mkUWwsxYzbOXzCDfEQ9Vvuf/tMY1GwTyYXCeDK6MIuCWFYI9eBow@lists.freedesktop.org
X-Gm-Message-State: AFuF++njM7S2MubhjJ1hardWbHcLyxoI7F2slsbVzHUGMXwwQIyWzFp7
 rV5xdqKhr4/0URtauEio+zhy92y6X/J+4AzQi1YnKZxBAbtcufuS10SL3PZCQJXsTUWQNgF85K9
 dfXvo0f/Dmw4A2L71gw0TQYLB339m+Lw=
X-Gm-Gg: AYBFou0fc7shjC8nZbOY9TrtbIgzwQrcBc5kI46zfiaycNlMy3UsztREnhR6F73PXwh
 DVY6Pjyldxr0qVJvYFblmUI1uIVV+h+1FolDsq31D/1WXZ7ZHv8Q+tl5c/UoKKMusBVozoud/HU
 j+PQFPL5EbkyZ3KFGHGJSS87kFpa9M4EtKVo2JNz8fIIanN1SVw1zmItEqEMWzM/+itXUbFCBl+
 Y+A57E4rTiM2lt0pHdY9KcGToKNmEpjjINMmwzRBwer2X0zn4JnDV0vb5GSCiecB7yv7Y4KJCeM
 XtRuctZWNIBwKmeKLM6o6HsbPgSxJ23XWGeUC2jwLu5N3oD4F2jcg7L8CMJGMfGdXURCb+bL4pu
 fR8Yp+UHW3n5LFHjJoAZ9qrRXArspsnEOOmAxyjG8ceor3Y8grm9f
X-Received: by 2002:a17:90b:4c49:b0:39d:fcbe:fdd7 with SMTP id
 98e67ed59e1d1-39e1e23cff7mr5673235a91.1.1789581431294; Wed, 16 Sep 2026
 10:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260915201525.3530491-1-arnd@kernel.org>
In-Reply-To: <20260915201525.3530491-1-arnd@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2026 13:56:58 -0400
X-Gm-Features: AcwNN1WqFxHVyo89bZ3kWQkp1b6VgBRYVdOql17xbIgcYVCDABYsam0h7bBy_4M
Message-ID: <CADnq5_MG+Yrws17OPHCCtc2Sw2yVBZUf-6ym8QCxnOW+SFKFfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix unused function warnings
To: Arnd Bergmann <arnd@kernel.org>, "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, 
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, 
 Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <siqueira@igalia.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 15, 2026 at 4:21=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_DRM_AMD_DC_DCE is disabled, most functions insde dce110_hwseq=
.c
> are no longer referenced, causing a lot of warnings such as
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:3510:=
13: error: 'dce110_enable_analog_link_output' defined but not used [-Werror=
=3Dunused-function]
>  3510 | static void dce110_enable_analog_link_output(
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:3391:=
13: error: 'dce110_set_cursor_attribute' defined but not used [-Werror=3Dun=
used-function]
>  3391 | static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx=
)
>
> Replace the #ifdef with an IS_ENABLED() check that leads to an empty func=
tion
> in this configuration, so the compiler can eliminate the unused functions
> and not complain about it.
>
> Fixes: cd2cfe4d1504 ("drm/amd/display: gate DCE ASIC code behind CONFIG_D=
RM_AMD_DC_DCE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This still leaves an unused empty function, not sure how much harder
> we should try. Maybe the file should just be built conditionally?

I think so?  @Wentland, Harry What do you think?

Alex

> ---
>  .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 817f2bf736f4..a334e10eb1cd 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -3618,7 +3618,6 @@ void dce110_disable_link_output(struct dc_link *lin=
k,
>         dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTE=
R_DISABLE_LINK_PHY);
>  }
>
> -#if defined(CONFIG_DRM_AMD_DC_DCE)
>  static const struct hw_sequencer_funcs dce110_funcs =3D {
>         .program_gamut_remap =3D program_gamut_remap,
>         .program_output_csc =3D program_output_csc,
> @@ -3685,9 +3684,8 @@ static const struct hwseq_private_funcs dce110_priv=
ate_funcs =3D {
>
>  void dce110_hw_sequencer_construct(struct dc *dc)
>  {
> -       dc->hwss =3D dce110_funcs;
> -       dc->hwseq->funcs =3D dce110_private_funcs;
> +       if (IS_ENABLED(CONFIG_DRM_AMD_DC_DCE)) {
> +               dc->hwss =3D dce110_funcs;
> +               dc->hwseq->funcs =3D dce110_private_funcs;
> +       }
>  }
> -
> -#endif /* CONFIG_DRM_AMD_DC_DCE */
> -
> --
> 2.53.0
>
