Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485F3C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 22:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C1C10F717;
	Thu,  9 May 2024 22:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RiQU21mz";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ECF10F717
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 22:07:55 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-61aef9901deso1082018a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715292475; x=1715897275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WUCADoGVzlNBM3uEPL/3jdp1SRUMbvwvrgL46r0TBI=;
 b=RiQU21mzsdSk9zHHa7jQoL8ZnZsdqWesDtnC0TVwPEKVxT45+vqscogBVsWdNl70Oy
 9yv7Vu6yDStQv92Xi7D9dFAnDSm4WY075ec5KqQrc7ly8//BNRsTOloDx/0uIoGsa0BF
 A9eYqOA+xIvpw1dJbwDINjuKtRwTVjVGVbnDBOElhyFRAYUXOFNWmvQFM1k2rtIiQZmR
 MWeIgVcIHSH6COuU4pgJKysTY4TOC4OcFRaFhOUHgaGcjHntvjLJcfxHV+/fqybrU5Dc
 Om46lLhhata23/TcoKYGjLAEyh4AUjCttwnJRXs0TcAZYY+0CIvjVFrjdoNyU8Iqobk3
 P+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715292475; x=1715897275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WUCADoGVzlNBM3uEPL/3jdp1SRUMbvwvrgL46r0TBI=;
 b=YTNA1C8Hj/dkr6I2SSTEceyZgIhrQt3hcgcEsyPR6LB2hjsILgy78cCxH8p5dVVRSy
 eaJN/SHvcH0deKT8zSQnTa4GvO07OVYpkrH1FeQ5Dx5qthKA232tuSJzhNTWhuL4owmJ
 ESuVmY3Owg8332+BWX9gNpFVs7RK1FN31IHU9ufy9cXzSbtYeZgk2Bx1jRiE/woDMdkc
 51vj53xyW0nFTZ13UDE0Ltq1Twa3wcsm1qGydZCWEWe/l3roMrqr1iMJQGskhIIbsUCH
 gHbM1VHkuRbUqwIpMBxLii75yKeXm7qaEu2jjtLCmyOpJzWDT9zGvRgnLE95mcllyH5G
 hBvw==
X-Gm-Message-State: AOJu0Yysoyg6P5hogY31Dp+1kqL00hxANkp4z9w/oAfsiPNtw9F2hSWC
 uXfaRgoLvT8FHoXgYrM3HNDtMuK7NLc9j21N15WxYMbg/JILcZhKcqynbVt+X8xuwUNyh3/QEkW
 gmwhCLucHdhdDaXu3jyhXsFqQrzJ0SA==
X-Google-Smtp-Source: AGHT+IFwJmg3fRlaFFMs4QDm73x29GvPdZrNIU/u84rC/9DiGQO/GC53ZY90gAekOL5KVhk5pTQYY8X2VpeSwLJxU4I=
X-Received: by 2002:a17:90a:6f85:b0:2aa:b57c:b178 with SMTP id
 98e67ed59e1d1-2b6ccedd2f8mr889707a91.34.1715292475276; Thu, 09 May 2024
 15:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240509213709.1495007-1-David.Wu3@amd.com>
In-Reply-To: <20240509213709.1495007-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 18:07:43 -0400
Message-ID: <CADnq5_OjSnyhyHyO5Ou+OX+gOESRe=wwCdwvJF72JPLdMumomA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: update jpeg 5 capability
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Christian.Koenig@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
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

On Thu, May 9, 2024 at 6:02=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@amd=
.com> wrote:
>
> Based on the documentation the maximum resolustion should
> be 16384x16384.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index 12900488dd61..285d6af10f62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -61,7 +61,7 @@ static const struct amdgpu_video_codecs vcn_5_0_0_video=
_codecs_encode_vcn0 =3D {
>  static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_decod=
e_array_vcn0[] =3D {
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 2160, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
20, 183)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
>  };
> --
> 2.34.1
>
