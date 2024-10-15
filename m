Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52A0D1D893
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 18:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCEC10E5DC;
	Tue, 15 Oct 2024 18:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T6Sh8O18";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EA110E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 18:27:56 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2e2b720a0bbso1112676a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729016876; x=1729621676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uN8wEbmSkbOBOsNwizB2bAtsGEEjntCqUzqjpRBNzE=;
 b=T6Sh8O183YTZEOxhiSjTR9Rxj3M4I9uVBFBoMBnFxTT64xulCF1PRh19KHIK5X+Nxh
 xw3+XDmB5Jop+ihJn4AXHSTiwIAvVP6yXLmBFoC1ZDiKM5CLh5hQ6B7wkv+H58b5Y/W7
 VaWmkFRuVCxMHp/flGDIlJo/mDz7t+gG/8Kii3KltWKOHEafbB9yUPk2GUjQCxtXzNnZ
 eVXSgpuKPZt4gvQQ5ZKH5GnoFaJeVt68g/zq0YAoSROZhujkyJTRUjSsEIiUQixE8P1x
 9AAFA5XBk5M4VoqNoWJ+L5l9QpAV84jrWFrO3namdFjN9gW/DRPtlkaM4qsBnZYtmj47
 BcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729016876; x=1729621676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uN8wEbmSkbOBOsNwizB2bAtsGEEjntCqUzqjpRBNzE=;
 b=EzURx8YSZCT26/5AWX95RBWho+pAfUYUBTzcKO08462GvNqr3McJS2rhMKLHUAd54u
 4omI0yJOk9FdP/K6Nc4KN7HdPbZDJRo2Pcg+dR+nvRA5pq5Zks6Q3RZkGX7PFg++yPg5
 y2x40+5ngJNLEKrJqbkOoo6iR1No6UPvOr2YnCLRpTX060V/hOCSyomCUU9BUYlicZB1
 nBdO2NZ3AvVHJ9HQCxH90nLqXy9ZkqdE1hdk3uuGnNC1St91QhxmHVVbyXmU9+y3dEO6
 fIVFqg+4iR03gBsXCtQattJFoqgvR6KMYKuBHLKRDc7DK4lrqXER99MWZnxdw+AfiL9n
 7UiA==
X-Gm-Message-State: AOJu0Yz7324K9sTsvz/DOi0eccrzsod8XNGS9eltr7zRhAh49V6iWEf2
 lh774r+cs77pnEBjymm6fxZAgvHVO1uIS95Ffu5O6Tnoq2p1VxIEyAfEMcpy1/hu0xcKiRi7VQN
 D7sPY4CeTGiduMWOidCZDRyHromY9NQ==
X-Google-Smtp-Source: AGHT+IEKxQqwraBrJwhR1H6RzxR30xRy0Nef3tIfzhiZscjVwf7fai2bbSJ1MeewP5MJQi1w4NRYznehO1Hh5cS4aFc=
X-Received: by 2002:a17:90a:e2c3:b0:2e2:cd5e:b25 with SMTP id
 98e67ed59e1d1-2e2f0f08bfemr8059991a91.6.1729016875637; Tue, 15 Oct 2024
 11:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241015181335.2327-1-victorchengchi.lu@amd.com>
In-Reply-To: <20241015181335.2327-1-victorchengchi.lu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Oct 2024 14:27:44 -0400
Message-ID: <CADnq5_Nr6wswgfFGpiuPLJva-UpB1W6ue_tL0v+NfEeTaWmBUA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling
 interrupts for vega20_ih
To: Victor Lu <victorchengchi.lu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, danijel.slivka@amd.com, 
 christian.koenig@amd.com
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

On Tue, Oct 15, 2024 at 2:23=E2=80=AFPM Victor Lu <victorchengchi.lu@amd.co=
m> wrote:
>
> Port this change to vega20_ih.c:
> "89ae318001e5 drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts"

Might be helpful to quote the commit message here just so it's clear
why that change is needed.  With that, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index a42404a58015..a71552ffe0f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -114,6 +114,33 @@ static int vega20_ih_toggle_ring_interrupts(struct a=
mdgpu_device *adev,
>         tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0=
));
>         tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
>
> +       if (enable) {
> +               /* Unset the CLEAR_OVERFLOW bit to make sure the next ste=
p
> +                * is switching the bit from 0 to 1
> +                */
> +               tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 0);
> +               if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih=
(adev)) {
> +                       if (psp_reg_program(&adev->psp, ih_regs->psp_reg_=
id, tmp))
> +                               return -ETIMEDOUT;
> +               } else {
> +                       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +               }
> +
> +               /* Clear RB_OVERFLOW bit */
> +               tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 1);
> +               if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih=
(adev)) {
> +                       if (psp_reg_program(&adev->psp, ih_regs->psp_reg_=
id, tmp))
> +                               return -ETIMEDOUT;
> +               } else {
> +                       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +               }
> +
> +               /* Unset the CLEAR_OVERFLOW bit immediately so new overfl=
ows
> +                * can be detected.
> +                */
> +               tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 0);
> +       }
> +
>         /* enable_intr field is only valid in ring0 */
>         if (ih =3D=3D &adev->irq.ih)
>                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enab=
le ? 1 : 0));
> --
> 2.34.1
>
