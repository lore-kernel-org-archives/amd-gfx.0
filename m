Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFA9C4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 16:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C563710EE9B;
	Fri,  2 Feb 2024 16:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ODm0x4Ch";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9425110EE9B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 16:51:26 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-6dc8b280155so1389865a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Feb 2024 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706892684; x=1707497484; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnY9o3B3SSTNVn9Y1Lp1mMMGnN4XmIIKfbkbQCcDIyY=;
 b=ODm0x4ChZYsy86453LYD6XXLJEkPnrOJPvGIhdP0SbPESagzBsynNKfGpCeyoU+jAf
 8ZeCF6PAfm6GITHTk9itUjXIZWbFviWfcd3Jvv1uqY5OSD1FxxksoxO/3QLCL3Q0NBB9
 zg25KSqCCI16YH/px+LcCVqJqbI48VfRA46iBsIs7+neT7yR2l3+mWnPKzAyY26hWSOv
 xIHAmrNWO6PhDBon7kq/w7UwE7p+gKD3/cgAnIwEpvihv3+jTpCw8OnX+bKuMeJDiHkH
 Vjjz1/xg3gUzQiovMjqLm135OjExHXElUe9eho7W5BE9PWwTGfVhOLpYIxjaHIdz1LEp
 dFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706892684; x=1707497484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mnY9o3B3SSTNVn9Y1Lp1mMMGnN4XmIIKfbkbQCcDIyY=;
 b=BmYkTyZd2h/GUbm6MoSCvP9/naau8LVMd4eF8TyCaxjIZ2WUCByuTZwAS9gvXhPgES
 4g9/npzq0iqIDn7nn5fns34/q7Y1PbBYDv65fUk/eg9b4f9VMAJXnH54i8fCSJHuQ11r
 ddVoZHW/u+g0KkeZhJxZsBJvyyhan4WHqCF+dezMYS1DHGylms7olDQfugX/PdDyyAgm
 7V+ScOILJRCdZYzPyX3GfrX5j/a1SfA8f3bqLopiPd/+cp8KHnK9E+DmGCOmV1jDoSUO
 z+SAIbUv+M4k+XkYUCAXy3qV79auK7C7e5OlBM9qq+uuLMFL01ca4YM0dVORRruGNtlz
 398A==
X-Gm-Message-State: AOJu0YwnOQkv0ieetJOhZgc9Uv4G3v0ZnDhtzTkUqiz+vnBKa99PaGNq
 N85drP8IEBwPhKCa8P3TLOExKTkJIECjhefeReYo1P9cHdDCLGizhmVcqP9L8ATyQh7YfoHLWcu
 1TBPOya/O+1tXbabYYvN5I+/tcdtZlwGN
X-Google-Smtp-Source: AGHT+IGhmuISjF4sAaiOW8QJbtuwsbGZBQ+AEdejOjY3pVmY9w2TaxsB+RcWd1sUKz1EMwBA8+1/69s8R+PE4ZzCuiA=
X-Received: by 2002:a05:6871:70a:b0:218:72c5:acff with SMTP id
 f10-20020a056871070a00b0021872c5acffmr244229oap.50.1706892684069; Fri, 02 Feb
 2024 08:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20240202153547.274367-1-lijo.lazar@amd.com>
In-Reply-To: <20240202153547.274367-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Feb 2024 11:51:10 -0500
Message-ID: <CADnq5_PHS_trHQtiRfAYfnrSGKZTRP0MO7_DhKPVs4557VTPYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Avoid fetching VRAM vendor info
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Le.Ma@amd.com
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

On Fri, Feb 2, 2024 at 10:53=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> The present way to fetch VRAM vendor information turns out to be not
> reliable on GFX 9.4.3 dGPUs as well. Avoid using the data.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index a3a11538207b..c1161f465b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1949,14 +1949,6 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_=
device *adev)
>
>  static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
>  {
> -       static const u32 regBIF_BIOS_SCRATCH_4 =3D 0x50;
> -       u32 vram_info;
> -
> -       /* Only for dGPU, vendor informaton is reliable */
> -       if (!amdgpu_sriov_vf(adev) && !(adev->flags & AMD_IS_APU)) {
> -               vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);
> -               adev->gmc.vram_vendor =3D vram_info & 0xF;
> -       }
>         adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
>         adev->gmc.vram_width =3D 128 * 64;
>  }
> --
> 2.25.1
>
