Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EF2C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 13:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C12112CC5;
	Tue, 16 Apr 2024 13:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GrCd8mQV";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D085112CD9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 13:57:12 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so3348174a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713275831; x=1713880631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KogCcpB78UgXHyZztSJL4gs53uMIV3snrRM6ik2dLrE=;
 b=GrCd8mQVNNv1uozHcA0msF3CV45OthSeZbxFz9njFbWe3ZZHZDS5nBzFGYQPlQFs22
 BYEJgngWaRCsHM/6mAUUW2fw9SU4yPh84U+tEzQd/m8n/9BGcl5KZmwDEVRaFBExLMnX
 LgzkOwqq/1S62G8C/GbAVSfZVsCLdEdD1+hNDuooaPbrxlTSj6RTcg6HvfJlrm7yH/ST
 eeNl742PhSeBNDGJRloLRFDhtZ3IMw2y7dxjT7JRriPo7pepE2GbjckkEhxuoMwUusAf
 wevkZEZueEnH+gImCk78dImbn+fXeybTFgf4LUT2mjc33cLrODG9X/OqAYFNVnSqi9HT
 o9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275831; x=1713880631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KogCcpB78UgXHyZztSJL4gs53uMIV3snrRM6ik2dLrE=;
 b=cGsw9fGPFtbJRpARHgs+Y+H8RWEjEtN7QtmnuzhpOsOClkIVbNJC6Jh/Jgc5WqXFem
 uyVkeQiJ0Xjlj5+KFYu3w6JMju3bOijcVoTq1bqD7+N0gouscBHUX1lGQ3xflUy2g4ts
 Q0Sm9AtImeyYKOkee89xSiHaP1xTLNp397rX0I5AYPMVfVQHPFoV1NVOHkGI16XL9ia9
 Z4lBbicDmtt5FQYuCFwK9eYHYZT8LQrQDLOWqEShHKhzYZkfgEBQnXsme3W2kGkIkgvl
 HzMAhVnu0l/uWF51Vaz7CeavM5m7ofIL4tta1vj/m91DmWYO3GO2aNOcIUVuk+BtqPPd
 Tl7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3iCrCdNj+aDga/Gyp0QBldQJ7GNNBjgBQnBN9HCRyYV+ISUYPUQXr70Bq2lmPxzLxGugfQWCNh1tLMgpZa8aacXTMhHmi8J9dc8svhQ==
X-Gm-Message-State: AOJu0YyPJiE68mdGmK9EdAT6lTkIN+d6ecJ6anoRVyR3PfJ03WhPLrTe
 ja4E54fZJX5XH6ZU1c84JC8DlAe0xDyNIol1PNSQDCtqCATfed1q4025AZGvRLur2xTS1XcrSs9
 4rIRXu67Le7gZNykBcBv9VU9MVQmp7Q==
X-Google-Smtp-Source: AGHT+IF9BZ7LILV3UVdMM8McJOHQkI2HoVy4c6tax2AiS+JMbZfubSJnmUiTKxYh0uUDcoET1Ul8qUqPDL0Aox2l78k=
X-Received: by 2002:a17:90a:de92:b0:2a5:52c3:4ca9 with SMTP id
 n18-20020a17090ade9200b002a552c34ca9mr12491167pjv.29.1713275831445; Tue, 16
 Apr 2024 06:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-5-sunil.khatri@amd.com>
In-Reply-To: <20240416120804.607272-5-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Apr 2024 09:57:00 -0400
Message-ID: <CADnq5_ODDOi4vOXyH7m1J3DJ54+PG__K0vzm8fQ=TT0vPTQX4w@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: add support for gfx v10 print
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Apr 16, 2024 at 8:08=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add support to print ip information to be
> used to print registers in devcoredump
> buffer.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 822bee932041..a7c2a3ddd613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9268,6 +9268,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       uint32_t i;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
> +
> +       if (!adev->gfx.ip_dump)
> +               return;
> +
> +       for (i =3D 0; i < reg_count; i++)
> +               drm_printf(p, "0x%04x \t 0x%08x\n",
> +                          adev->gfx.ip_dump[i].offset,

Print the name of the register rather than the offset here to make it
output easier to read.  See my comments from patch 2.

> +                          adev->gfx.ip_dump[i].value);
> +}
> +
>  static void gfx_v10_ip_dump(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -9300,7 +9315,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs=
 =3D {
>         .set_powergating_state =3D gfx_v10_0_set_powergating_state,
>         .get_clockgating_state =3D gfx_v10_0_get_clockgating_state,
>         .dump_ip_state =3D gfx_v10_ip_dump,
> -       .print_ip_state =3D NULL,
> +       .print_ip_state =3D gfx_v10_ip_print,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx =3D {
> --
> 2.34.1
>
