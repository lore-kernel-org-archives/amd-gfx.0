Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA74C04FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 20:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85D2112E28;
	Tue, 16 Apr 2024 20:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eGGpao+c";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEFC112E24
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 20:06:30 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so3649698a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713297990; x=1713902790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5E3O3iZSspG1/ffgiDU08cEJhtgFR4KFhA3qvq8gas=;
 b=eGGpao+cuiPlRpzyX5VN+XxH5nkXI2/HAf3Od+b16+RoXNPXzDLuM9AknV2Iic2B3k
 eQlUCIvHmbzm74yw3QKIrIPYtbz6HxFblTbwTpNB6JEOk34dSrV2YUq0NCfZGPpzpX1o
 Q0D4XcotwkELLpH8TYW2M4bqaalWmvuc+j9l7pJ/+cuJtiof594GwdPO+wTbeDR4+gPC
 Q7QCxvzczlAGgY0e+3uDmSFxWbi6arQK9RSlCmjywJGgY3YwNnkHjOHY0R9AzwXsS9vx
 KRKMKakG24DTOBF1Qsqw8XlTkuy1kXjmNHbRG9GWoCQZo1mTAybvXjF+DuWMn9+t7bo7
 ufbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713297990; x=1713902790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5E3O3iZSspG1/ffgiDU08cEJhtgFR4KFhA3qvq8gas=;
 b=n2P2bK3zVYuYrIcpQdzwWC/1940xFJAAXYUotGkljDa7jMueCoT36sbAfWdBvXf7z6
 9LPFH4MVbKZBLPX3UwPQ+vtUEp6V1Mz2Ir11d/I5o9/xIa4SXKW/jlRWuDD0N24hovXr
 vmp6+xxZBRN3vw/TPezC+UpkfKfYQJTV+QU+W9XryMAG7Qw7GwqHHm/vRQe97++4z4VO
 NnE1dCsyfvn7o2gzf+13pWSDeXMXwW17Ia0HM1upYQoqKCMRAwMsc3+SkkUH/kT6O3Az
 1LjmbJQmNCOpmC2ts6YICQQyn6g5t5bT5qWfP6vMwgHlLLU81S2PNDwtHupo5Nywk7HQ
 qGuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzsXD+KwZTdQOGFO+1wUWrEKPJXxNalkMboFkfXRkwd+eVmsasSwlwZnuBljzYmIlwiO2+m6+3Rm4CpUkKgvYxcy7d6nQx5eXkt68G+g==
X-Gm-Message-State: AOJu0YzQTSFHOFAx7PmvLoZa4xuupwLG3XZMhH0QWnuQSPDcEu33gnDY
 s2+Zp8mA/LzXm2hMCYdE0cG8kvV0OlNbHHf3g53xGA4aN1hg+2LNWwdgvE2kKgUVsAkeZRI3VJK
 fKytpJq63UFRglN5GVbZtaxszZUk=
X-Google-Smtp-Source: AGHT+IENs1wQT5hCEeqK7Pr/XSH1/FqYY1ovIoc7neQudSpxc4OhUoS5eyNT24PtNmT3iclBbgj9AdFSLw+gWwOHIMs=
X-Received: by 2002:a17:90a:5d83:b0:2a2:7a00:f101 with SMTP id
 t3-20020a17090a5d8300b002a27a00f101mr11183477pji.47.1713297989557; Tue, 16
 Apr 2024 13:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-5-sunil.khatri@amd.com>
 <CADnq5_ODDOi4vOXyH7m1J3DJ54+PG__K0vzm8fQ=TT0vPTQX4w@mail.gmail.com>
 <21419f15-8be2-45a2-817b-5b3b80e93136@amd.com>
In-Reply-To: <21419f15-8be2-45a2-817b-5b3b80e93136@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Apr 2024 16:06:17 -0400
Message-ID: <CADnq5_NcambE6i8zcCGta0xiau_46SBMn0Eti0gPHA9L_8PqNA@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: add support for gfx v10 print
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
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

On Tue, Apr 16, 2024 at 1:36=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 4/16/2024 7:27 PM, Alex Deucher wrote:
>
> On Tue, Apr 16, 2024 at 8:08=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.co=
m> wrote:
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
>
> Print the name of the register rather than the offset here to make it
> output easier to read.  See my comments from patch 2.
>
> Just register name and value is fine or we need the offset too.
>
> Also i am assuming stringify the macro is good enough ?
> eg:
>
> #define mmGRBM_STATUS                                                    =
                              0x0da4
> so printing register name exactly like mmGRBM_STATUS is acceptable ? we d=
ont need to remove mm as it makes it complicated.
>

yeah, that's fine.

Alex

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
