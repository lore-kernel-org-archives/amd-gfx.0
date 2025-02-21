Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82048C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23CB010E03C;
	Fri, 21 Feb 2025 16:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mOqT4E3E";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDED10E03C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:47:29 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2211ea911b5so6364665ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740156449; x=1740761249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skyRYW7hXDui2Iqp7qAWOJUNpeJKwXOV48TOjRdDGS8=;
 b=mOqT4E3EPm5nV2lR0m3OfX6XGbAg76LOVCMckDzaA2QMaLp6z5Sc63WhdVEySXlcXH
 /Rt9YsdlUGUoemefy9VbjivylScD2uyWJBak/Bj+Vsxw8vzunC8D2sTbLrX56SIiBrh1
 c5XwVlNbGn9VR84J5kn7BUUvTVk5Rtqh7K0EJxLLTdhrMadfqZet08Fpmv9Z5i8nIJyr
 S9CIdxsc9RzkQ8nnIoVyy6y06nK2hHz9ofxYIV32Mh+Gy3WKAv/clQx69A0riI1bMItc
 STqLMmCqA4cSJY7rXKo5QLN96JhCDFWpRNNjhomQFp9DhaleuKa9Ttsf2hSr1gHhUkpc
 p7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740156449; x=1740761249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skyRYW7hXDui2Iqp7qAWOJUNpeJKwXOV48TOjRdDGS8=;
 b=cv3aNEXrj1wVslUzZT1ds/ff32kmKaptqKUd6rz0KGrm79TkGnW0H+pvaRSdiVE96o
 Z2IJU2omGix+shvZUyScPfmdz1V9aGA2D8R/m3Dfjsaje6GQLp7ympqQ87y8bRqEbZ0Q
 b9B3ouDiSeuCUWdewQai0VTl9TqozEdKHgnZ2HmVaO2ToBbFFj50rbRZK9OZszLwMJdK
 BGhi/2uQ/ix9pJ5pKmi/wSsDnT28X3miwyaZgAHLyIGxh1Pfzj8VYTzLez61P2Uzdc5o
 M3QdazeMq0ugb53HYG9TYOMG4dH0CzQ7M6S92TVEXmGS8FBQxLhE0lvDBMk+FXoxokLX
 fTuw==
X-Gm-Message-State: AOJu0Yx9JrndRJ6EKtoCrqgUD9jVLe9T9WcgSrEmtsQrBn7saYQetjuL
 JECxSoEtsiPUHPEa9l9bHUbPjcWROrAjbwnLFYACFnavIqJpBg6hV5InCLY6jETclY2zyz3h86+
 jO6xIPZcJmP+Yv8Jywvu91bJ2/2s=
X-Gm-Gg: ASbGncuw+OGgT8REROPOLxme2HAAJZyn0V4RVVFo5BExOZQDSfqJm5SwAoR6YIPWdiJ
 sC46k+iIMyBbXo4lvfWp7rvdbh30VyE8sV/XGyr69m8Rg+Wjvjl8IRvQwYEad33bsrCB+qNaSEB
 w9kuizXCM=
X-Google-Smtp-Source: AGHT+IGWF7C/27/iLqtkY7wn3eCbL8NRIS9yTznQREnwyZ/L0lUkzyRnq/NgwjbTlWLg7L2Y3q6UcewToeKCpvNDFAM=
X-Received: by 2002:a17:902:ccd0:b0:221:7b4a:4749 with SMTP id
 d9443c01a7336-2219fffec59mr23953085ad.12.1740156449372; Fri, 21 Feb 2025
 08:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
In-Reply-To: <20250221130030.3703750-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 11:47:17 -0500
X-Gm-Features: AWEUYZlqWDyJY-9j5tkxHL2MNBgvhunqvbzH3WosKR8AeJyvgv6DA9L9lqQ1k60
Message-ID: <CADnq5_NBNSxfxqfzrv95uGiZ4S0KCo1Vf2wJxBoOy67cGGsRLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe
 reset
To: Prike Liang <Prike.Liang@amd.com>
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

On Fri, Feb 21, 2025 at 8:38=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Implement the kernel graphics queue pipe reset,and the driver
> will fallback to pipe reset when the queue reset fails. However,
> the ME FW hasn't fully supported pipe reset yet so disable the
> KGQ pipe reset temporarily.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 71 ++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.h
> index 4eedd92f000b..06fe21e15ed6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -25,6 +25,8 @@
>
>  #include "amdgpu_socbb.h"
>
> +#define RS64_FW_UC_START_ADDR_LO 0x3000

Will this potentially change in future firmware versions or is it
fixed?  If it will change, then let's just read it back from registers
and store it in adev->gfx.rs64_fw_use_start_addr_lo or something so
that it will be correct if the user has a mix of GPUs in the system.
Other than those comments, the series looks good to me.

Alex

> +
>  struct common_firmware_header {
>         uint32_t size_bytes; /* size of the entire header+image(s) in byt=
es */
>         uint32_t header_size_bytes; /* size of just the header in bytes *=
/
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 2c7f0bb242ff..7e53c0b63f88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6653,6 +6653,68 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
> +{
> +       /* Disable the pipe reset until the CPFW fully support it.*/
> +       dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.=
\n");

I think we can drop this warning.  It will just confuse users.  Maybe
make it debug if you want to keep it.

> +       return false;
> +}
> +
> +
> +static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +       int r;
> +
> +       if (!gfx_v11_pipe_reset_support(adev))
> +               return -EOPNOTSUPP;
> +
> +       gfx_v11_0_set_safe_mode(adev, 0);
> +       mutex_lock(&adev->srbm_mutex);
> +       soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +
> +       switch (ring->pipe) {
> +       case 0:
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE0_RESET, 1);
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          ME_PIPE0_RESET, 1);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE0_RESET, 0);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          ME_PIPE0_RESET, 0);
> +               break;
> +       case 1:
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE1_RESET, 1);
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          ME_PIPE1_RESET, 1);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE1_RESET, 0);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          ME_PIPE1_RESET, 0);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
> +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
> +
> +       r =3D (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)=
) << 2) - RS64_FW_UC_START_ADDR_LO;
> +       soc21_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       gfx_v11_0_unset_safe_mode(adev, 0);
> +
> +       dev_info(adev->dev,"The ring %s pipe reset to the ME firmware sta=
rt PC: %s\n", ring->name,
> +                       r =3D=3D 0 ? "successfuly" : "failed");
> +       /* FIXME: Sometimes driver can't cache the ME firmware start PC c=
orrectly, so the pipe reset status
> +        * relies on the later gfx ring test result.
> +        */
> +       return 0;
> +}
> +
>  static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vm=
id)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -6662,8 +6724,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>                 return -EINVAL;
>
>         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false=
);
> -       if (r)
> -               return r;
> +       if (r) {
> +
> +               dev_warn(adev->dev,"reset via MES failed and try pipe res=
et %d\n", r);
> +               r =3D gfx_v11_reset_gfx_pipe(ring);
> +               if (r)
> +                       return r;
> +       }
>
>         r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
>         if (unlikely(r !=3D 0)) {
> --
> 2.34.1
>
