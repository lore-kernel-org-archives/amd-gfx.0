Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25A3C5DF85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 13:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF85910E1E4;
	Thu, 20 Aug 2026 13:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C7pF+TkL";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E4710E1E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 13:53:17 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-97c55f283ebso39931241.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 06:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787233996; cv=none;
 d=google.com; s=arc-20260327;
 b=VXiTq0+atWJCmT7w/GbQQ4Xuq+lAcy0Ln3Hx/Tr2ux2hZvu7/b22MFJM+F2YRtnUzW
 7irgLH8WWnxtTEnQSBC0gdDwdl/+bEVGUeE6sjpX/CD9oBGrxHlsMs772gWKPQ77g8B7
 PVPWI7nqEIXlyLr5sBhlu1qZdXgxdWY9otYGYOz2ms2hn0v6fNxdwMr8o9QrVzDCglIn
 ot0uZkDUULb3Kv7ITgfbCX6CtHUMex5NgzDLm10t0UNcEO/fWxR7umbAazpsRUWysAVh
 We3pLoJukgjZwkUas/YmbLQOMyr4jTWJcdpBXZn0QV8txKb0AaLoFWvk1toEos1pT4tF
 5mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w/wARQLv1ksffomZ68IDhBiZqaBGnGg/wMcmICd9uIk=;
 fh=3iBQxkh3a6cIqM16ErsTI7QgnF0+Vku35l22ls49KfM=;
 b=Z4n/T0u/wIcO6TcxYuJKk3atcnnUcw4IwQVzCKen5rhQzn51DdEUYPwE5UIuqR1H/u
 0ZDZXXcfjimRslNPVgYDW0l7z0/2e4mBS2H2cOXBHF0IfIIgVJYrUkuHo+Dr2IZL8jEg
 T5Jj/hPLcsmZL5/2B+GCSISZ4yrpoI0EfGr93DQi0UlTdDFoi96Tndwv4EX2oDgLKfYd
 O50Wl3+qmsbDtBETa1ThnR/bQb755Dn7a6SbgUAnX/z3aK7dtIwlvZW+a9r7CSTy/AX5
 BNaFKWfbM2zr6wGouAe9i0jGL1aeygkit9SyI+VJUwSVqMh6RIzWe0QxbXi1coj+wH6f
 WYqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787233996; x=1787838796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w/wARQLv1ksffomZ68IDhBiZqaBGnGg/wMcmICd9uIk=;
 b=C7pF+TkLmilt8nCxi+Se+iC44Lqa4ixQEinTCHAnDMDMkZ9YAmq0rtMNVUlp+l6Nvq
 JYoXxBvEXc+8zyP54ckJYujSKYds+avPYU9dollViWNbE8fpIO8vn81dJwitVFs/gXU3
 Jh8eoipGUWUeyS/Xg52uWiX4NR7vGsnmeskE7CFklFzyzmrSyRRsql3FEfmf+OmOiSAf
 dm1lbleYrh64Iwd/bwe/jDPcv92CuePB2FxAKTabKTudCZ4pHWntQPjBoLaKHiq8tKv8
 fjvj5qoGpo2WuUwAA7dgq4wkyB/IUl309CXvKTN42LdwiTof3/Kg+Qcinl57V45RH6gs
 TtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787233996; x=1787838796;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w/wARQLv1ksffomZ68IDhBiZqaBGnGg/wMcmICd9uIk=;
 b=FU9mrsMvFJWoBOnFKcjDaIpvgJhX3m0mUaKP5uyQy5nqbi4r+oA+L0TCMbUdXJqv51
 2eAatsI4xvw4/i9fHsLEVQnOcE6SCJMGCHkKp9Yw/jIdZujTntBrd1DuqkcDIYvzaROv
 e42fLxDIOcD4aL83aP0ixs2kHCjTTjXOJUS0WP+i6bsDOW+TCIXaNuw6gT3TykSZd08V
 aQCSCJ76xfGbicLlWYFKGHg1pYyZCKGYhBf3sbJw8rFRfZo9ohDPzRwN5LwW/uML9lrZ
 t8KoYQm1FJIS/vs9DuonY7JRCLnEcqASR6iaDWhPb5pbgDg4PruZ7Tn4nVw/yduBF0ws
 WbFw==
X-Gm-Message-State: AOJu0Yz0+1u8BjE2ZcJw78BH8n+70RmPFchpD+wQeNGhSoHMIFEAvi+l
 MPFuxjEvBXJEi4LE+d/44Cat+elP/Klk4Us9jJGrCqOgRiBa627tcIJeZR3P8Qzoopi+VoZ4Vtu
 lQbkKSrdjEdjmZOadPe+ZlWEDLDbrNio=
X-Gm-Gg: AR+sD11YZjD2oDu0vb65WJfl5YDLxY6uxklmvHnoUBBRvlqW+mlaLZ7ZnTO3ZaXIr3e
 1UKLGk5JFq4nPGKDXk4C6OS/njmgCi3wyffuyQwOyHlnvJRwNUmeDtLgCZcWOZ5AjwGpGxQIUEM
 XMefElLlDZAPPYs9yUlKL1L6Uq/sQAjIi0E+VCaTJ0HK6ZgUO/Sd/jWgoeMyTGaLqrxXNiBo2dz
 rru6cCFBOQLyvY5sJ/Ggm7LPh76Qs9vxG0W/i/Sk+xGRlIC6jj1srIlACqnKGjXH+yPBuGE9FQ5
 WCp3QnVP3qxq7qJMXgk0cKKL0fyaDcmLuy8GjqvepPSSYIg57dvp7y+WfotmdzhocNZNH4+HG1G
 hDkDhNa5GRfr1i7UN3PtJZahvpOMUJUE=
X-Received: by 2002:ac5:cd85:0:b0:5c5:b075:40a with SMTP id
 71dfb90a1353d-5c5e3d82e96mr1610347e0c.2.1787233995770; Thu, 20 Aug 2026
 06:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com>
In-Reply-To: <20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 09:53:01 -0400
X-Gm-Features: AcwNN1WsqJ3hCNNk6J5SSbpBmQkwMQqHzWTnbqQW9wXiEiex83KAj_oGWS9dVyY
Message-ID: <CADnq5_MNFZfbvkgQ6JYjBZOb5+E+kezXDphFHshaaw7h7yVk0w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device
 padding for 32bit compile
To: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, sukhatri@amd.com
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

On Thu, Aug 20, 2026 at 12:55=E2=80=AFAM Yogesh Mohan Marimuthu
<yogesh.mohanmarimuthu@amd.com> wrote:
>
> need to pad before __u64 tcc_disabled_mask variable.
>
> Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>

This will break UAPI.

Alex

> ---
>  include/uapi/drm/amdgpu_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 0a113529b..5beef3eaa 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
>         __u64 high_va_max;
>         /* gfx10 pa_sc_tile_steering_override */
>         __u32 pa_sc_tile_steering_override;
> +       __u32 pad;
>         /* disabled TCCs */
>         __u64 tcc_disabled_mask;
>         __u64 min_engine_clock;
> @@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
>         __u32 csa_alignment;
>         /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
>         __u32 userq_ip_mask;
> -       __u32 pad;
>  };
>
>  struct drm_amdgpu_info_hw_ip {
> --
> 2.43.0
>
