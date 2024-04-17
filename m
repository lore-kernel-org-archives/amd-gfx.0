Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D15C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 15:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6063113658;
	Wed, 17 Apr 2024 15:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAUqTfbd";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C8D113657
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 15:52:14 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so733690b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713369133; x=1713973933; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2vvVq02G4JQZ851FxDk2b5/VLpPOU5qnqD3CA8C4HI=;
 b=CAUqTfbdiaLhnwglEIx010239yY4GG1AtJG+s6Q+jty8HkRCwaC7S6VH6yEmnUGCl4
 Ztnp322tq8DAUtXhDEpy3pakL2ozQFOrN38ew4tm0d1m106f6FoKP6hYr1QtyQVL2GPS
 hjunLfi2S5B8TUSUqJawNMzGQ+OS5dRTqBtI9Ml8jkRS1bkR/dgswv55Impv7DuKM8Wg
 wwzLtdr7y9anwAkJvZG31W8M3gRYEg+XR+vpAOx+wL1Q75dfd8omADtsUjpI9rSt2tp+
 dBpBDMwNPrlugTX4axY84yqXyndQZlE4hBupVkj+3aio4s5kdazAf/WQG5gb1c4CYBT/
 vHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713369133; x=1713973933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2vvVq02G4JQZ851FxDk2b5/VLpPOU5qnqD3CA8C4HI=;
 b=G1y0ZeRNyRoCuUGFVklQV8VWRo+g/xlU1i2t/Bn9zufO/PCbRYQiFzuyu7bcSe9gl/
 eFR9vah+eQOMs3GCV1s1k0OPrhfSj5rqGcx7xERFdXpnGGNqbFpgyYmykw4MEZmx9lnR
 Nv8Y6JFmYXDyYppkMImg+Wrwl6pMo8v9JxPIeswPLi+fZLKTbtsEB+0z750tE1z1JB2g
 PkSXzY++/gudfDNcu7sxRtfn+t50yb90t4twVWzf1kIwg2YyOgtL1V8W2kPnHMShLoE+
 114zuVEVDvpLX0dYRXN5i4b/RkS12o2KNVjbwS8zozFtYOkYINkNCHCOOH7SCXQkhIcJ
 X4AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+HfdUIkgR73W0YjV/0AVmoIJS9Plcg8G3Gkliw0u2qA3+ivPzADzIuhYQe5bY5Gww3HWLDpRHDDLBpt6ZOXkhKERNBM+ejM49VOYvDA==
X-Gm-Message-State: AOJu0YzqG1Wj8T5nEgxPHeznCTO2xJ4daYm+aQc3QD+4Zb2TT/qCJp4b
 qmkLLZOLxmp/R9sN1fAI/rd8FH2qz/87V3x7gfWagLiuRpjH9cDaHmrkm36hhx/Y3ps7Z9o9qFT
 DlCUHb0TlQaRhC9AcIInuzHNhI7c=
X-Google-Smtp-Source: AGHT+IFHmwVXaOa6aGDoLUCT9tL2Im1H4EOSvGfaYGj4mToVVM7iSDoMFJkoGHXX5Tq1C/Wtwm0JKBH24nXS94N/BxM=
X-Received: by 2002:a05:6a00:4f92:b0:6ed:416d:e9e with SMTP id
 ld18-20020a056a004f9200b006ed416d0e9emr8139112pfb.16.1713369133397; Wed, 17
 Apr 2024 08:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240417093809.168002-1-sunil.khatri@amd.com>
 <20240417093809.168002-4-sunil.khatri@amd.com>
In-Reply-To: <20240417093809.168002-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 11:52:02 -0400
Message-ID: <CADnq5_OW42zWYiPHE=yhYKXJcX6VL7crW3nW8h8vCs3OixWwGg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] drm/amdgpu: add support for gfx v10 print
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

On Wed, Apr 17, 2024 at 5:38=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add support to print ip information to be
> used to print registers in devcoredump
> buffer.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index ceeeafef668c..9b0b8ce5f5e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9267,6 +9267,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_=
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
> +               drm_printf(p, "%-50s \t 0x%08x\n",
> +                          gc_reg_list_10_1[i].reg_name,
> +                          adev->gfx.ip_dump[i]);
> +}
> +
>  static void gfx_v10_ip_dump(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -9299,7 +9314,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs=
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
