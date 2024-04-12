Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCE1C04FF8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 04:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7AE10E7D9;
	Fri, 12 Apr 2024 04:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R01BKlaA";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1C110E7D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 04:15:56 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-6ecf406551aso434230b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712895356; x=1713500156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hl968ineGCx0VDpZ/zmxWDVkY31xgjA9jzYG7umw3dg=;
 b=R01BKlaAi3JCDgi6v9rZSfr8VwoUbkJrlvBWUoYFyqyXXrBX5/9LoQHJUBF737VY20
 eoY3f4qK4gl+wALXAH9ztnoEadDAeh86QKViU/ljXvd43blWCmNWwdb74WUWiIYqJzAq
 DFp7dPWbMjgE8pmOQ1qTObdzgat7JzrseR79iUioi0R8M/up7uodqg69OJEb6e5uNAZ9
 8TIa8vEl3VFr5EJiZyLhI06O6KM/g27w6GJElgKHkTQ3vSrEPZyQ/8Mgc3NipOiNbbwd
 wQfkxrbE+HZf5htnn0sVGMDlhi3eXtfcyD3gSFeP0J1zF5zt9wAg3wiusX34zvyBeauv
 TzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712895356; x=1713500156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hl968ineGCx0VDpZ/zmxWDVkY31xgjA9jzYG7umw3dg=;
 b=bBL29cv1P/CWeuhS6TQo6KZG+ki/TkbvcZX3CBaimXOAuciGqac7jScgou8KTgZNUW
 VupxyU0g/qjvKGH0sLyp+kstJA0xgO5Zpm5HKIlstl2NDH06qn3nja1644xbHAjGtwag
 jYGT+sYLPFapoXdtKt63iPKXILxl2yXj7GVy17/GrxtZsI/eFzHzhNWzKzFxNlYZz5Sw
 yTBVOFHbiU0s26oDGdYuN/UKZIx74qG0rGXB/dI3aacGIT4c59UO0rchyg25yGJnrwUA
 u8oIkenUR8lAwchFxTDEADBIWm+AhEFLXRObdCmJYI7NhdFK5DyXe9KCQAYth9w0dbFo
 blBg==
X-Gm-Message-State: AOJu0YzPAdbiGfLfZolBMYGmEt8A4JZNeXNtyPMGLixaQV7abTSD8HEQ
 md3R2tzlqpw+2/Cghy4j5n+ScnQ95wBpNLA3aIATr0leJvsqe7w59Fs49wqO/Xf2TrRWW5wWovp
 QrVVDgVacqqfE2d61z7eMJiEusLu4xA==
X-Google-Smtp-Source: AGHT+IF6aSeJVlJLqx0E3jaiPSPswDnMWstbwl4RvYA8ScXTn1REIAbsdT61ZPVIqC+bOekH8BkYWnFQY4jpFkIU98w=
X-Received: by 2002:a05:6a20:ba9d:b0:1a7:1c26:f9ac with SMTP id
 fb29-20020a056a20ba9d00b001a71c26f9acmr1540591pzb.62.1712895355626; Thu, 11
 Apr 2024 21:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240408172025.5848-1-alexander.deucher@amd.com>
In-Reply-To: <20240408172025.5848-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Apr 2024 00:15:43 -0400
Message-ID: <CADnq5_PnyCnu6Q+wH240pyp72bHpfFQx4QErS4QGd2ncBj6=JA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx11: properly handle regGRBM_GFX_CNTL in
 soft reset
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

ping?

On Mon, Apr 8, 2024 at 1:57=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Need to take the srbm_mutex and while we are here, use the
> helper function soc21_grbm_select();
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 7a906318e4519..dc9c0f67607b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4506,14 +4506,11 @@ static int gfx_v11_0_soft_reset(void *handle)
>
>         gfx_v11_0_set_safe_mode(adev, 0);
>
> +       mutex_lock(&adev->srbm_mutex);
>         for (i =3D 0; i < adev->gfx.mec.num_mec; ++i) {
>                 for (j =3D 0; j < adev->gfx.mec.num_queue_per_pipe; j++) =
{
>                         for (k =3D 0; k < adev->gfx.mec.num_pipe_per_mec;=
 k++) {
> -                               tmp =3D RREG32_SOC15(GC, 0, regGRBM_GFX_C=
NTL);
> -                               tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL,=
 MEID, i);
> -                               tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL,=
 QUEUEID, j);
> -                               tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL,=
 PIPEID, k);
> -                               WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp=
);
> +                               soc21_grbm_select(adev, i, k, j, 0);
>
>                                 WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQ=
UEST, 0x2);
>                                 WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_=
RESET, 0x1);
> @@ -4523,16 +4520,14 @@ static int gfx_v11_0_soft_reset(void *handle)
>         for (i =3D 0; i < adev->gfx.me.num_me; ++i) {
>                 for (j =3D 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
>                         for (k =3D 0; k < adev->gfx.me.num_pipe_per_me; k=
++) {
> -                               tmp =3D RREG32_SOC15(GC, 0, regGRBM_GFX_C=
NTL);
> -                               tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL,=
 MEID, i);
> -                               tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL,=
 QUEUEID, j);
> -                               tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL,=
 PIPEID, k);
> -                               WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp=
);
> +                               soc21_grbm_select(adev, i, k, j, 0);
>
>                                 WREG32_SOC15(GC, 0, regCP_GFX_HQD_DEQUEUE=
_REQUEST, 0x1);
>                         }
>                 }
>         }
> +       soc21_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
>
>         /* Try to acquire the gfx mutex before access to CP_VMID_RESET */
>         r =3D gfx_v11_0_request_gfx_index_mutex(adev, 1);
> --
> 2.44.0
>
