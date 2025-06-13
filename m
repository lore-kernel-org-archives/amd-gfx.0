Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD3AC71148
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 16:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2B110E299;
	Fri, 13 Jun 2025 16:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fpb9EmJ9";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8475010E299
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 16:01:29 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-313862d48e7so404337a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749830489; x=1750435289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTz2ZADwxHZ4UsiWGig2gHTbpRT0iKrilsMoZYSynUI=;
 b=Fpb9EmJ9UlxxjELswe9bpMbrAQIM/cYjq/4oLDQKwluoQACWPFiMGm4W+pRQ39hQ1p
 d6WEuE++iOFj0cIepOoR+UbeYK2pvTJrVY0uyp38hvPM4NcTMyPJYrJ2KDyqLENTSKme
 GxXBfql6WY4vOBpbxJuzXVnQ9TC0G9koAfUkjo8bcD9y3u++M3POGLUYTeUOTgFMnE2w
 WlnW9tGF4KboCILChv8NVjQ5uVHC4lOmb61cRIfYsChobsrF2zaAcf1rKSb32VMRu3Jo
 eNdoIGFzlWd34eMRlcb8hJLhWm7w71XPwEJ1478gW8VbW78/wrJM6Ds/ZyBQehKIVk54
 Temw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749830489; x=1750435289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTz2ZADwxHZ4UsiWGig2gHTbpRT0iKrilsMoZYSynUI=;
 b=R/zPKiHj3yoC1z8wtYsTHo9ol1Xq2ShjCC9qAnpGLzEfHr3Ljh5TgBbLfCRgi/rBEH
 sidBaLlY8/SeeNZYwHoxVeQuAtnbocLJZbSmA/nwaAT2e708T7wlJt26BpI/inuWktGW
 hg6Z+vFKdHsCRM1WgKoqdHmvsg/TAlewIHZ4829gs7zZ1S5gff2VtewNv25MmgI7S36h
 wCR+u/Idfp0KzDN9ZHfs1A1fAHCOIaEWj2l3FFb9Do7CJEINo/tIpqtAqpPY/3YKe89X
 kgWQrAkyC2axzwVWmMYacfHcL2rB0+iIGQLQQmKDqcprx2Nyx+uN3Lp2m8nh7dWQKbUd
 6Y1g==
X-Gm-Message-State: AOJu0Yz8eHBbk5VP1FDhKsQL5yhkrkmbhyqSBJZa9ZmAahmxBLChWjh2
 ZUs8LCdMAIXI16Ui26tNLK9/lFGlP90E4RRnrUQeWL1+K4r8wQNd6k3n6PJwmswRzHkAaUvHvyo
 Z+nJoCmHl4CeJtPUXYTOPC8/waBzra2uZ2w==
X-Gm-Gg: ASbGncvBdEcIQjUpXft3xfJLdgxx9BVExcwW23u6kNAOdagDZL5HEfnKYf/9eUdiDHf
 n43hXuWU2yc6EM4vzwBKK57wGRoDOeRW11qwICGXab5Qn0sj68/KUSJ5ev24JzOrfI2Nt8jGXi1
 pVg8GaaC6hCIIMvaTy4Ee2Xv0Ph3p5e71FjRjBQ2cwgZhj
X-Google-Smtp-Source: AGHT+IFRf+jrhTILUl0QWTQhaRFceFaY23CVlzQXCzI/JnUrslAkruEthXkMfrtgfL6rlrVDh1MvORogQVil5dA5btM=
X-Received: by 2002:a17:90b:4c45:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-313f1e70849mr96911a91.8.1749830488339; Fri, 13 Jun 2025
 09:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250613144203.441129-1-kenneth.feng@amd.com>
In-Reply-To: <20250613144203.441129-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jun 2025 12:01:16 -0400
X-Gm-Features: AX0GCFtfi2Jlm1zGRa2JzUWUkRI9S8zWg9HGiX-HvnliboAGfkgycoKmd49SpDI
Message-ID: <CADnq5_PNf903HaK9eieL3w_tWXOfHzY7sQgivfskyvRwh8L4gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: move the dpm table setting back after
 featureenablement
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo.Lazar@amd.com
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

On Fri, Jun 13, 2025 at 10:42=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com=
> wrote:
>
> move the dpm table setting back after featureenablemend due to dependancy=
.

What is the dependency?  Can you provide more details?

Alex

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 824fcc6dd32a..cf4ac3914b68 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1687,17 +1687,6 @@ static int smu_smc_hw_setup(struct smu_context *sm=
u)
>                 }
>         }
>
> -       /*
> -        * Set initialized values (get from vbios) to dpm tables context =
such as
> -        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature f=
or each
> -        * type of clks.
> -        */
> -       ret =3D smu_set_default_dpm_table(smu);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to setup default dpm clock tab=
les!\n");
> -               return ret;
> -       }
> -
>         if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5)
>                 pcie_gen =3D 4;
>         else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GE=
N4)
> @@ -1739,6 +1728,17 @@ static int smu_smc_hw_setup(struct smu_context *sm=
u)
>                 return ret;
>         }
>
> +       /*
> +        * Set initialized values (get from vbios) to dpm tables context =
such as
> +        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature f=
or each
> +        * type of clks.
> +        */
> +       ret =3D smu_set_default_dpm_table(smu);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to setup default dpm clock tab=
les!\n");
> +               return ret;
> +       }
> +
>         smu_init_xgmi_plpd_mode(smu);
>
>         ret =3D smu_feature_get_enabled_mask(smu, &features_supported);
> --
> 2.34.1
>
