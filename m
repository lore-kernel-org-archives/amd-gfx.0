Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D8C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 21:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29AD10F14C;
	Wed, 15 Jul 2026 21:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="adzIAopX";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B078E10F14C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 21:11:28 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-37f9e2642deso554697a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784149888; cv=none;
 d=google.com; s=arc-20260327;
 b=GBrhwYLOrKuZcjl6cfVyUjpyxp5ay9liELXuY4F3VXCwsrTLG+fFQLaTB00ZB4qB1m
 +1AhhpNWtK/pGcT3HCkNwiN42K6Fa4985a/jKTFnuTt2JaeABFUfkK4lyN9Q9yI12x7A
 Fxr1FoqZYWkV98mIpcBj1EtDOIbqBIaFeCiBR+K9bbdJ9SYya8t5MmK/hEzDA1fjRuvO
 Dhgg552OddlqFtBOcCjo5Y3XDgM7glWw6RyzAiOU5V1qXUzqM9SoDcbLaCHqk5bYPW0h
 y8W4nExkzUaoqmUCZjmDSpXpgZJeQN3iN55UldJ6sL43Ao3WyuBLzvuL6mYDc3G00l7l
 aDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TN6fxli9LQ3MUlsLr1uknWC9L3pHije6Ktw5JC5sQvc=;
 fh=yPMe0XF0Fbektkgt50AKypVRbc4Q9ZGT7aF48vx1Pd0=;
 b=qZcE6+7h7MrxzWzSBTgSdApR3PqvXUzyaBfasBK6mpf43PKUQlIGBdus9f1XV9N22s
 q2BwHad0DTVp6Q75ALbRjlMAN8OMji+d+D2OtJW1aBZkaCMImW/0Bjj/ZzYKsCEoLUZb
 dc4qjpwCAjVmRzjr9sjjexpLrOHe6NRGMvsFAaqxMFIuGKylifjVDPFaTHwY/61QYOLT
 fauyrpEitFqJxf/UO1rrxNuzRwnDegYdO4DIrzqZ2MlOeZzX7t7uuBilIYuJ+gZiIKqX
 Qs7PwRie4RueZG+5B1rVJQo7ni+Yr3FV3lZ+lersXR4WMGZMl5zJlucgmlEtWD95Sfia
 LqEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784149888; x=1784754688; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TN6fxli9LQ3MUlsLr1uknWC9L3pHije6Ktw5JC5sQvc=;
 b=adzIAopXo/PGkpEtoBYwL755S5aeD5V2SNQNhfVyJSOxtqXqhl9P4dugSsnFS1IvUo
 Gznuc5kXzGMs261qthpiGq057gbcOTTMlYGoloWYA9dRLB6Fb2crSiEushGsQQUlLW3R
 wEA7buDSnjWGu1o7Rbxsqkjfjz17R7Xu9rCpvcDoWIZiGcmu6U+K1jq4wXBVixKxiI7/
 LcP+5Q6Pph70OG0PYMRZdgr4U+quCgs7s9fGjOdbhT8xpyX3bRByAIDV+mx+vfTtr4X9
 deP8JbQcrFjOe6M6CZmLHwxTvQw9QKdxUa4/URkWmWJxf0YGb5jyTtN8mQaeqV5Rq8aH
 BD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784149888; x=1784754688;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TN6fxli9LQ3MUlsLr1uknWC9L3pHije6Ktw5JC5sQvc=;
 b=Uw3wuvuVFS91MwMQymZvH9kM/ra2muvbhyJchknbNbKEuMC8eTEGzB9hypczsMyslw
 aD6WeAnXHJQGCIRX7cB1fKo8udtfsrfFxn7MIWinzsA/M7KGy7LB55/ViRa/4YakklE3
 ui0Mqb+mv0/faCS1SGoxpy8msGf55Ba7LpbYw9CzKdc1Us7ByEOMEfpboFfgN52K5HKM
 pXjsTya5qcPNyUOX5V4U4CwumPXWbpwSt28WYqcbIRH/cSxXQg7SlN7tw4ycQw4HqcUO
 TLtIyd61XqL8DvZ8JpLWeHVZuEP/clkTGzP3M1YY4bhxLzGd6vRrOxoHZnYI28rkBBsD
 AyEg==
X-Gm-Message-State: AOJu0Yw9GLLxpRt1/FnfPV+B3IT+HK1YXIpARuG5RPJT6js9LSI2U6zV
 pqtMBLBrhBVmqkahS5TGpHOaTllDEODgRTMq1IIma7D/bgNBiFgi+3vJ2HJt6AxBN0SOELXLHGP
 gdfMROx33WMrYww10pyH2pPiMWb8F6AA=
X-Gm-Gg: AfdE7cmKabYDuu+Q8d45fk2W/CJXnF4+ZBccoHVjxSePg5nk3FqC6lYGhRe0ZEh+8iY
 UHvdC18EAhMqhwlVWB5GL4PLS9zLlgCJ4R9e4Neoj2mLYmFvbNe2o5fIRim7lsnRM4hy0J2NRiN
 L80DPaFKkvnifKSr4cHW0NQe/NyfOZUX2VDXr/HRvKxadajA249s5ly1K+Dzg6l6QvnmVaccmgJ
 zyawF0S7wujdF/BKqfHiUVRn6RAx4LZoLHDzw/dbUgmMP3CCWI2Fwd0F3g7/cB2/UeS4vuroKsA
 NlaV1oHEOYHcTsusP39Qyo4VEpmmlHQLfgEkccqm650rrJDH7VLsyMoXKLs=
X-Received: by 2002:a17:90b:3b8d:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38dc7b2d49emr14818459a91.3.1784149888113; Wed, 15 Jul 2026
 14:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260715200201.2458988-1-jerry.zuo@amd.com>
In-Reply-To: <20260715200201.2458988-1-jerry.zuo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2026 17:11:16 -0400
X-Gm-Features: AUfX_my5ehEuE1g2EXr9yK5krncXVcLaRO_DnIGT2np_svuq-UnN7vqBVZHa7rE
Message-ID: <CADnq5_PSoY_9gAjwvZ=r40CaDTvDth9Z52M9Bz2i7AZ2wNUQ1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: dispatch compressed FRL cap check inside
 dml1_frl_cap_chk_inter
To: Fangzhi <jerry.zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com
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

On Wed, Jul 15, 2026 at 4:02=E2=80=AFPM Fangzhi <jerry.zuo@amd.com> wrote:
>
> [why]
> DSC over HDMI FRL (e.g. 4k144) was pruned by DML mode support
> because the compressed FRL cap check was never reached.
>
> dml32_TruncToValidBPP() validates the FRL output by calling
> dml1_frl_cap_chk_inter() directly. The compressed-vs-uncompressed
> dispatch (if params->compressed -> dml1_frl_cap_chk_compressed()) had
> been moved up into the top-level dml1_frl_cap_chk() wrapper, leaving
> dml1_frl_cap_chk_inter() as uncompressed-only. As a result a DSC stream
> routed through TruncToValidBPP was validated against the full
> uncompressed bandwidth, failed the cap check, and the mode was pruned
> (vlevel =3D=3D num_states).
>
> [how]
> Move the compressed dispatch back into dml1_frl_cap_chk_inter() so every
> caller of _inter() (including TruncToValidBPP) honours params->compressed=
.
> This matches the internal DAL tree.

MIssing your s-o-b.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/driv=
ers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> index 260f58a97fc7..da2c92e5c02f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> @@ -630,17 +630,17 @@ enum frl_cap_chk_result dml1_frl_cap_chk(struct frl=
_cap_chk_params *params)
>  {
>         struct frl_cap_chk_intermediates inter;
>
> -#if defined (CONFIG_DRM_AMD_DC_FP)
> -       if (params->compressed)
> -               return dml1_frl_cap_chk_compressed(params, &inter);
> -#endif
> -
>         return dml1_frl_cap_chk_inter(params, &inter);
>  }
>
>  enum frl_cap_chk_result dml1_frl_cap_chk_inter(struct frl_cap_chk_params=
 *params,
>                                                struct frl_cap_chk_interme=
diates *inter)
>  {
> +#if defined (CONFIG_DRM_AMD_DC_FP)
> +       if (params->compressed)
> +               return dml1_frl_cap_chk_compressed(params, inter);
> +#endif
> +
>         return dml1_frl_cap_chk_uncompressed(params, inter);
>  }
>
> --
> 2.53.0
>
