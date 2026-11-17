Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DEC606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxRoAxRC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42B710E629;
	Tue, 17 Nov 2026 15:20:17 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AA610E07B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:20:11 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-567ff5b9488so429528b6e.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:20:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928810; cv=none;
 d=google.com; s=arc-20260327;
 b=GfZpVvGSLxfoVB6xvJ1qd11a/tLCXXyU5DajOlIqxLnEZqalSwmO9mb/0ndxFLvUCj
 b1bqgNdofuouy7nZodqx4YeSjsLqPGohfQOSLs3dEQJrFcgY/V/3ybUi2xD89+CmFdgL
 YYZMvGO2ZadOh8zn10znI8qs0Id+ifqkUsJGFmfSEjjovRHrC75wichVwcNePYdogoZe
 5i1PIu0M8Kl7pDqqRR9vttAKUrZFpwgI4pp5WeuXCBF+uQpEORU5gj2urFk69eOFYaIT
 UBGxtU6FhY8/IrzghhwLy98mYpngb7EtHejxJ1KDyfEw1vBZWWRBUZuSOQ4KmbJ8jbKG
 iAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NfavTn69hpcvIJk0EgoXJoyHQ13urM0ePPguggroc+g=;
 fh=ZxvrC6rNjWHvCh5o5yNM8zSSCYAFdK0GMEIYqGOthl0=;
 b=Lrxyq24OacD2l86NjJEAtuQ1ljs4Haesc5mYpDJBHR0lZKp4xuqHmUiDlpokAn/+np
 yPu3i99rQFPUuBeYP9yDoGVICKfW58jn9A3me9hClAjbdsWpr/Ae6RELROSH1eliisuz
 TttUuFtNlqLXTNWCp2PCuZyGTNe9UDEFtoSzBiEZGw4txhZw+2K4jjG1QTGfKLL5H9NI
 E6RhRWReUY2vET0/gIdW7TtIBU3gR6kv2Kus5qPQHsUEsKY+Do0PiwDxryWcekmWAPtk
 sAkJMosDUi842RdmsJHUDK++5tVzFvDTXfaS8ZuLyUj/a9px5M2KF2Nf2qOBg3Fdn8wW
 uacg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928810; x=1795533610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NfavTn69hpcvIJk0EgoXJoyHQ13urM0ePPguggroc+g=;
 b=bxRoAxRC3Ctt8kPiZ+mFO010es1Mse9DSBXa9pauFWkDRxdMHCaLYu+BjFHJ0jEe1G
 Q3ny0wPJZhdr49ctNqmTFyDt63S6ikOufReHizsPTFPjNvMnsjb0uFumk+zL5tQ7xkOr
 jtHzHlPRP7ccf7ikJZKGuUl0f0rROQa6tZLIyCdfs3BUQZQWVMmP5aYaK/CfNzxBnBo8
 W9YwdEoCvaFoHFoDK0mIhULmRZ2CV5LFhdW61tM3yIuEMCjTUpH9lE/yCGO4l3cUU6nu
 li4pPgn1dkjyuTnNCgrR06DrCRCVeB93Vmc9XtgkiVSTqEz7UZK23tGlSjh4ibnfog2K
 40rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928810; x=1795533610;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NfavTn69hpcvIJk0EgoXJoyHQ13urM0ePPguggroc+g=;
 b=f4Q//0TbFrbzprMxkSO6mXvxK765HoFaL4Bip7Po54T3XvP62TQr3er10ueYSdgS5K
 dQqKQThEZwmo2VZKOhpQnjvdHdHUmrTabWt4TEtOCeXBMVYw9cczpTlJxIDCkoOmD+l1
 8ixwhQT0JiQCscQEDwAYUcp1ZFDQ7aQ3r9DfZxbh+qYLm8GQ6cHiTLNukDp7/5Mllc+H
 RGND90k62eQKkioUnaybVgJoSoHnWl/y8MSPEnCQMKb4uQaiLRzSfMSFbJ2hqALtpb6f
 Ri3e3EzFN9sGcBbSCk3XOOJWFp5XQX76fPxMMdcFJTSYDoFC7T0Y4Pq4rS/AFl065unU
 eBoA==
X-Gm-Message-State: APuU4Z8SaRgFxav0ga28eTslPFEDX2cypLkj4Uh0LOLTmtEM+ac+RkO+
 wIrYd9kfBexFXwv5eYCOZJjW3ejIuvqfQgv4EtOVkMn4Isc6ClVFPNOOhEPPKEyNHMEMhHhhD1Y
 ccaJKytaF+/DLepBFLEnBZLQz9GWD8N6w/w==
X-Gm-Gg: AYBFou0VvI2lFf69splVhFSfHrmzPiFKMW+TRcWAQ9G7RvdgLuUXVbks1CTPQur+PS2
 96nP95NWZbozXGHa7c2V7RecuSKqMCtM0vCb6fo6bdKCAClmM0g4Uczsom+9idVE1ngZJIIx49l
 l5TEpcIpA9ie7Ve27DZzLhHUWwl1wGi7CcxHAtb9HBfuKqLqP2N31JDWdNc8HaL80KSvwFAYVDf
 adO8DmMIJXFmTRJRmQtMZQGgpH73BwuVvCqMEIWlm+gfKhFd777Bo/Nm0Fh2+GtP6PCUSnFXair
 lfqjxXG6AYUqfie60MfZca1PAYIkpljBeFoXQ3fFW+l7hl6XluKFjGTCf1IjdcZ+bP1fm+mW+Xw
 kgCWaQQvNGo9AfOnFQ+2AvJz3OsoLoIU6A7g3G7GvQuFCfPAs6Vw/KwnRVqh7EsNvumwIRsRV/f
 Nj93yLQgGZZmJ5wxg3uf9yvnN0yzQDUKlgd9z8B1M2+u/MQ6dDE+75vBavFmUK2hg+WFJUt1MJs
 Spj1M+G
X-Received: by 2002:a05:6808:1821:b0:573:2541:180b with SMTP id
 5614622812f47-57325512719mr10995431b6e.1.1794928810320; Tue, 17 Nov 2026
 07:20:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105000613.3850438-1-alexander.deucher@amd.com>
In-Reply-To: <20261105000613.3850438-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:19:58 -0500
X-Gm-Features: AclHuK90h3bL-ik1nsw9qyp1f4l20Om1pLTENnSjhdyM7y3K1U0KCx9VjLgeBJU
Message-ID: <CADnq5_Nefu3UuUUc8T0esOeYPpdtG5zVfyrfXNK_DEMozHbbvg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add helper function to get hdp base addr
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, frank.min@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 7:06=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Frank Min <Frank.Min@amd.com>
>
> Add helper function to get hdp base addr.
>
> v2: drop debug message
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c   | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hdp.h
> index d9f488fa76b94..efd6414bbe12e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> @@ -35,6 +35,7 @@ struct amdgpu_hdp_funcs {
>         void (*update_clock_gating)(struct amdgpu_device *adev, bool enab=
le);
>         void (*get_clock_gating_state)(struct amdgpu_device *adev, u64 *f=
lags);
>         void (*init_registers)(struct amdgpu_device *adev);
> +       u64 (*get_hdp_base)(struct amdgpu_device *adev);
>  };
>
>  struct amdgpu_hdp {
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v8_0.c
> index 63afdb5de3d4f..36e2bfbe91395 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
> @@ -125,8 +125,21 @@ static void hdp_v8_0_get_clockgating_state(struct am=
dgpu_device *adev,
>                 *flags |=3D AMD_CG_SUPPORT_HDP_SD;
>  }
>
> +static u64 hdp_v8_0_get_hdp_base(struct amdgpu_device *adev)
> +{
> +       u32 hdp_base_hi, hdp_base_lo;
> +       u64 hdp_base;
> +
> +       hdp_base_hi =3D RREG32_SOC15(HDP, 0, regHDP_NONSURFACE_BASE_HI);
> +       hdp_base_lo =3D RREG32_SOC15(HDP, 0, regHDP_NONSURFACE_BASE);
> +       hdp_base =3D ((u64)hdp_base_hi << 40) | ((u64)hdp_base_lo << 8);
> +
> +       return hdp_base;
> +}
> +
>  const struct amdgpu_hdp_funcs hdp_v8_0_funcs =3D {
>         .flush_hdp =3D amdgpu_hdp_generic_flush,
>         .update_clock_gating =3D hdp_v8_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v8_0_get_clockgating_state,
> +       .get_hdp_base =3D hdp_v8_0_get_hdp_base,
>  };
> --
> 2.56.0
>
