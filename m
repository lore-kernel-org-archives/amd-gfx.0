Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127C606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQM1W9gf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0E710E131;
	Wed,  4 Nov 2026 14:30:59 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F185F10E131
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 14:30:53 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-7cbbde7dbceso18512137.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 06:30:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793802653; cv=none;
 d=google.com; s=arc-20260327;
 b=TWo9MpZFKqYvoDi9YuTS3bVfqqINL5ET5Jd6xuksqQ4Y8VlWQeje5C+XdHV2hcmSqR
 R4XmjK1yDPUkNZlpIxZscBQWnjQ/aOrjpQSii9iaENZppS6MkEztM+4avlkKILfp/Jsh
 fE1FMBvahcDwi4swdaxuRD5RUbj4NEIzh6Gban32ym0qDxRIZ0jb6lr+Ye2zCKHWqf0i
 P+pVbL9/4yvh6cjM6bSiroVqp1S+IPI9y6lsENusdRhOlo2MpU2dyQIQQJjMvRssTK4J
 GO4v+RyT0IOccpdOe8KOPAi5a9HkFwHBmMffWWsXL1MXjIsRZ5cg0xEu4EHL5cJ/p+c4
 ffrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SiwzsgsFqYp5fdv33nLKshPx8wMfX1sKTYMLElHYMY0=;
 fh=kiYYdWRZpUkLIrTJJfk1hYO1XY0BzQh96R41+D3J4I0=;
 b=Bs3UQIR5DJpglN5XZFsYWvrqHqJ+/xwZb74LgCRD3URyFZDchiSBe80h098soZ4T9A
 h0uDkQ3U6CaCPruYi2npfYLx4v9bXuBplvdM0pGFd1DWwpXJfOYPkNicHtusWWRYB0A6
 IVPCnS4SR0BNhxi6Pexmc4HmshtC6haKsRgBYfS0XYsgzgbIKGlKObLgWXS6afl+3OuD
 eSpZklIdAoIFJvUqctnrSeM8Hkcfeh5plkiLcuZh59daO5NWZAlt/eviDsnbMwbkFu9w
 AOBofdOicvj+yhQvD2C+gxQaDVG/hJhUcbaw340MH43Atx9PhQDdB5A6BqRmWF9EEAJ3
 nZVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793802653; x=1794407453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SiwzsgsFqYp5fdv33nLKshPx8wMfX1sKTYMLElHYMY0=;
 b=XQM1W9gfHMephxZsssTgGsyzsfxbbht3+a4F9gT9t65LqhNuf4rWVW/54TOh90JEuV
 hxAfwHRkjz7bIcfYuJa81tanM0tHL6ct4g1yxrIv96wOaxJP1vwOHbgTTDYpgM+dUvWy
 HIRjsTdvzuRY91ENn3Ih383EML6/YGzvbxPlYghTgNJt2eHvK+Sx6W+q9oaIQdGuYFy3
 Dsc1EsGYv71PNJEhwf2Jb+TKf7YPQhGz4QnhZNOXB+k+0qhabbprX2H4+epu+BXFMLIW
 fjN7vtvM5dUntgWx972z66CypkbGnG+004mzfnixOzRwi4Ia8K13cnRT9rc8GFc7lf19
 Ps7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802653; x=1794407453;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SiwzsgsFqYp5fdv33nLKshPx8wMfX1sKTYMLElHYMY0=;
 b=pBeL2Vs2rfJ+gemC/i0YONE+2BW1UAahLblQb0CnSXfwH+3N/wVJCXw+b7GagLInkQ
 IdBZP4ohQOlRQ3QCoT5BlRvsYXG69+//IHwJcccSpuY8Gjx5+x1MApZoeVLYKtTP1cfO
 aLRDCu+z0RnVOh5Ugmv6c7VJ5TXRgJzpeEAWYR0nyiNOzVaZsQaaaT3QJWOmlPSosknm
 aCmxHtSF5uUhbwF+6+pyBM8b2OCBR9UZ/0gTvYF4kv90dq/qhhwI2uJGpNGjJLHYlet7
 an9f8k082igmXxo/A8aypc+UE1RSDtnqpgnPzi7nWDopm3ZUXtF0WoXeg/5ungJWfNUT
 8gdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4qQzN0TXmka747f/s4EHzIwSKml7nEbbWcLGrydgRjZWHT+W6eR+97nST/PzE+XPjfoprwvmD@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8m0c9jWpRZ5OgUaHNOqnYl/ABQxZf417qpPatZyczhKfIp0s7N
 6gGBKrzf7QbySJn8BWULDX9mgdmCiBGqqVaancxYIA6O6yXEixa2St0+QsapH58rdgY5ZuBP65p
 G/SPmVdpoxk8XG7dzZ1+y8CmAUYgMJ+M=
X-Gm-Gg: AYBFou3Z7bLEeaaG2nsNINDmSPlejJ1N9VVgCbpmfkwgZC0UU7HEPE7QnDDF3W2l9Qc
 ZvfrZvk77UYkUeB663jnf17m/UMCTFXiJsYASAaP7Q0g8Y6YxhQ7Yvly1DdrwpNolK0BBaxe/m/
 KX5IvH/Zm8Y50IMk/a9UTKdCmCcigNTviXcPsS3ZIV55pqlk6W4RFKFpzaxyU2G4cqvIi8x65Ef
 qIRQfC685YcEsO3t1Lz+pLV6wGBW/x4wo0Qqps3zloliz2SfCJMf6HGOpJFiNlOWBqg0LTNMmvr
 /nKMw8juaIaiUmmPN94Ihog86hL2gWQj9qBz2dBh2JIDA8pMoVatP83HfBg6SHxboGci94iEVyP
 pWALJaTCCTqXgwX2OoqJLG7R/JzxSvT9vT7RTXcGuTJypPOQl8XyNxDl/OhpTo4cCGTqop5IX/Q
 /biOw8dwTvAeYXK5G8XAy4iVdYz90icQ65utFOMTCUjn71
X-Received: by 2002:a05:6102:14c5:b0:7cc:80ba:94ed with SMTP id
 ada2fe7eead31-7d072b6c90fmr6802775137.2.1793802652626; Wed, 04 Nov 2026
 06:30:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103000130.282357-1-an9949an@gmail.com>
 <MW4PR12MB6803349916CEC87B4278FE798E692@MW4PR12MB6803.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB6803349916CEC87B4278FE798E692@MW4PR12MB6803.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Nov 2026 09:30:40 -0500
X-Gm-Features: AclHuK8DSPPZWlRU397eNtiUNvVTi6MPDtv9LB-JU9WYupiCyLsO5FW_FOvnLj8
Message-ID: <CADnq5_P1x=6gCGra2dj6z3OypKBz_DArU+CNKc372=cFh4Sprg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: Andrei Krautsou <an9949an@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

Applied.  Thanks!

On Tue, Nov 3, 2026 at 6:25=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com>=
 wrote:
>
> AMD General
>
> Thanks for the fix.
> I just remember that there was an issue on MGCG so it was not enabled at =
the beginning, but I forgot the details, apology.
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>
> -----Original Message-----
> From: Andrei Krautsou <an9949an@gmail.com>
> Sent: Tuesday, November 3, 2026 8:02 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Andrei Kraut=
sou <an9949an@gmail.com>
> Subject: [PATCH] drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2
>
> [You don't often get email from an9949an@gmail.com. Learn why this is imp=
ortant at https://aka.ms/LearnAboutSenderIdentification ]
>
> GC 11.0.2 (Navi33) never got the GFX MGCG, FGCG and PERF_CLK clock gating=
 flags. GC 11.0.0, 11.0.1 and 11.0.4 have all three, GC 11.0.3 has MGCG. Th=
e gfx_v11_0 code behind these flags is shared by all GC 11 parts. Enable th=
em for GC 11.0.2, same as for GC 11.0.0.
>
> Without the flags the driver does not clear the override bits in RLC_CGTT=
_MGCG_OVERRIDE (0x000605e7 under load), so this gating stays off. On RX 760=
0S the GFX clock is limited by the GFX TDC limit
> (68 A), in Linux and in Windows. With the gating off each MHz costs more =
GFX current, so PMFW stops at a lower clock than in Windows.
>
> vkpeak fp32-scalar for 300 s, median after the first 60 s, GFX current is=
 about 68 A (TDC limit) in all cases:
>
>                           gfxclk    VDDGFX   GFLOPS
>   current flags           2030 MHz  800 mV    8915
>   + MGCG                  2261 MHz  873 mV    9921
>   + MGCG, FGCG, PERF_CLK  2314 MHz  894 mV   10104
>   Windows 11, AMD driver            910 mV   10157-10186
>
> GFLOPS per MHz is the same, only the current per clock goes down.
> Windows shows other clock sensors, so there I compare GFLOPS only.
> With all three flags vkpeak is within 1% of Windows. MGCG gives most of t=
he gain, FGCG and PERF_CLK add about 2% more.
>
> Tested on one laptop, ASUS TUF A16 FA617NS (RX 7600S, PMFW 82.97.0), Fedo=
ra kernel 7.2.11, Mesa 26.2.5, with the same flags set by a local debug pat=
ch. One 300 s vkpeak run for each setting and some gaming, no amdgpu errors=
 in dmesg. Suspend/resume and long runs are not tested yet.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6082
> Signed-off-by: Andrei Krautsou <an9949an@gmail.com>
> ---
> I have only this one Navi33 laptop. I could not find why these flags were=
 left off for GC 11.0.2. If there is a hardware reason (errata), please tel=
l me. If only FGCG or PERF_CLK is the problem, MGCG alone still gives most =
of the gain (+11% GFLOPS), and I can send a v2 with MGCG only.
>
> Logs, register values and the Windows numbers are in the issue linked abo=
ve.
>
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index 599d47e..635f026 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -599,7 +599,10 @@ static int soc21_common_early_init(struct amdgpu_ip_=
block *ip_block)
>                 adev->cg_flags =3D
>                         AMD_CG_SUPPORT_GFX_CGCG |
>                         AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_MGCG |
>                         AMD_CG_SUPPORT_REPEATER_FGCG |
> +                       AMD_CG_SUPPORT_GFX_FGCG |
> +                       AMD_CG_SUPPORT_GFX_PERF_CLK |
>                         AMD_CG_SUPPORT_VCN_MGCG |
>                         AMD_CG_SUPPORT_JPEG_MGCG |
>                         AMD_CG_SUPPORT_ATHUB_MGCG |
>
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> --
> 2.56.0
>
