Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3EAC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC21210E5DF;
	Mon, 13 Jul 2026 13:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3oe0ncl";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8BC10E5C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:54:29 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc8311c6ddso4622195ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783950869; cv=none;
 d=google.com; s=arc-20260327;
 b=Oj9LpXM0SXnao3RHdHDIMPMfz67wagouHF6GA4N1HH6MOzfYUYyWRAw1ZS/Gqnx6tq
 SPIdZ77asBiZ2Y0Izpn686TMUkU6EZw5qyzHa865SFnfJKRcoqLus4mqLTx/+bPBLArs
 ejNQDz7SMs33KO2k6qEGjz+MyemOXgLLlkzb18lZRWNqGkrnGa9DO7zGk1/Y9r/jY3jX
 JFpVjDXRrwlWMFqA+twVZhOMEZsDxb9FlbOHv1R9aYIy6uQhkDYcaNkoAeVVvWx0T75g
 KYRFYgeJuYEYA+9HQK5n/22FhZ7i664dhcLSRs0TauOt3Dl4NVQnSBk8P8Qh+PcDK5sV
 SqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gTxMdBszUAN+CtUZRmncM5EBsuLTWgleqZVt4ypRQ8U=;
 fh=8SL3Z5C4JnYjk5tdkqQXBXGUL223bQRSd2V73HPrRNw=;
 b=kUM3J0yyk7YYnrkCRyxfQCDJsyf8BHzdgMBsxKGfAg0IfUxMZgYN5Lc7O3K5JeXCLn
 6U4jmzPd+8ljzq3TPql9RIGf/LNJsOgkWrR8nH9FkJ8C1Itmkmk9L4iTf4vPm1VarJpJ
 /K128h4D6qwALEwkOSURiSse9RkiFKdlF2/gKiMFDAI+5YruMTBoRStLBgh58rSLYaNs
 snhO4iI7lCKsf8+pSIdeZxs215EpR7/gulXR60kEwCpzW98hu4x8nKyQdbtmnsYwh73Q
 kTOPlbxyWYhR9o0j8uXtNHLXCOInNepKmFgKIGXORS80d6KSwH7NkeI3U8UeKNKhs4GO
 K0YA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783950869; x=1784555669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gTxMdBszUAN+CtUZRmncM5EBsuLTWgleqZVt4ypRQ8U=;
 b=N3oe0nclgbYMq4s9aoE34N8UYhIQTnoBKm9zntiAT9Ng1WGamlwzck0qV/fPcOJEJy
 TG1iXWanpocpD3za260ObDDwqCHPCqSD4wUKayShm4/XisyGPVEPTkLjTpvhMrC5Wav5
 EP0MFNpDk3Ld/htBbVjODyVE1aMAOZSMHl5Idq6sIP8GGJkyPlFU/ADEldeH1FTMaPWU
 RTLWd3/SZ6jGM/XJe9cZrQq/Id4VAufnR2O0trqmXri5stAfeFNIq3usfL8ncgpbTKGd
 gVnk/ae0zbn6T5H4RJEQJgqjYjPOzG8jYw8LnDftys0AVO9qe9pO32xkFAL679n+R2No
 ywiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783950869; x=1784555669;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gTxMdBszUAN+CtUZRmncM5EBsuLTWgleqZVt4ypRQ8U=;
 b=eCj5qsitUjbpjdPUK7Sz37YOdJqDE7WfHy1zEg6esPcmWZR3Q2t9BWjy/PQZU5vLgw
 nxn5y3UF/8WHxf5UaDdRGjXZGEwGKDr7WkqkEgZOd9ENy7FaOZ2TLCjZiQktFMzC6HxI
 QhWu34NY3k/JHqbnHoZ9cgP9wF0MjCHAXQNO9ak8HioxxKdVKbQHR0iP+u8RcjqxMsDd
 AVNrTYa2kAnvVUOqVem4BOiuB/bTKExY/5nnOz79vTbcxTrF/sWVoYHKQ7XBd0s+tck+
 XprRVSS1+P0RuZ9mzRQbma7PyoikoE/whP+rsGxnfju+pYRsAALOaz/G2jyBphr4EkHM
 6aBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrX+37EbnNIB3r3dWjnrCpejKpBO615eNnMrvkIdFrz4l3SUoMgTXD8amKYUCXZmX0KzxV+DEk9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqV8Eg8JBF9VoFKX4zJOVaMVpMe+is+jN3Q6fNaDtAKzdwu2RM
 CW40l5U1nPGKweJahSTe+Y81HF0Wb7tK5TJXMry5VJaooHWgZpMpET3cCBTN4e6dmwD/jFJTKQt
 UTOki/QU9wuNyronc5Y4Pg9GhaiysaZ8=
X-Gm-Gg: AfdE7cnZejNCMNqu3sHEClW1B6NNegPzDSeGl/TwVbw1W2KOS64WFZBbFipUUW2cWyA
 4tCiVhiaKuLv/EiiXFc3Ju5UWLI+J0uzssviGL/LPjIyQyktmycbz2qG22PME9J92Q3WspnhXmJ
 A6ZnnG9mq++FJxsWC49hltWNGtUzWBg3DprvRF2ZqAVp3y0dFGRcI0Ov4zcE9qvPdXUtEhEJqTz
 lTQCH2vTPQiVIArrP7LCeM4+xRyjRnzdE19odhj1CLrA6HK5l1TFVgHG65ZiP8NTxc9tRM1QCnD
 A45SDOA8A0NJvm2VIHyUFjTyasdpcrVf1CQtJQ+lRF1YEzar7mfUfTjE3ok=
X-Received: by 2002:a17:902:ef06:b0:2c9:cf5d:d9b2 with SMTP id
 d9443c01a7336-2ce9ef1bd20mr72219375ad.4.1783950869063; Mon, 13 Jul 2026
 06:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E261113F418E454CE1ECFA60DB8BD5F38305@qq.com>
In-Reply-To: <tencent_E261113F418E454CE1ECFA60DB8BD5F38305@qq.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 09:54:17 -0400
X-Gm-Features: AVVi8CdBFq_xjfX1uVVBgmkUN8MDyASCbf51C-iU_16T9M0lslkVVOewKB7iMuY
Message-ID: <CADnq5_OhrWiPq=q1M1_zsu062CWcu6feDD-hv-=Pq2G+TT8kyw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix __udivdi3 link error
To: 2681643870@qq.com
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, oushixiong@kylinos.cn, 
 yanglinlin <yanglinlin@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
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

Applied.  Thanks!

On Mon, Jul 13, 2026 at 3:30=E2=80=AFAM <2681643870@qq.com> wrote:
>
> From: yanglinlin <yanglinlin@kylinos.cn>
>
> When compiling the AMDGPU display driver for 32-bit architectures,
> the linker reports undefined reference to `__udivdi3` in functions
> get_dp_dto_frequency_100hz() and dcn401_get_dp_dto_frequency_100hz().
>
> This is because the code uses 64-bit division (/) on 32-bit systems,
> which GCC cannot handle directly and instead tries to call the missing
> __udivdi3 helper function.
>
> Replace the raw division with div_u64(), the kernel's standard 64-bit
> division helper, to avoid the link error.
>
> Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
>
> ---
> v1 -> v2:
>   Adjust overflow=E2=80=91check condition: change INT_MAX to UINT_MAX and=
 add 100ULL suffix,
>   also reorganize calculation order to avoid potential integer overflow
>
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 7c293917e6fd..ecb8493ec523 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1229,9 +1229,9 @@ static bool get_dp_dto_frequency_100hz(
>                          */
>                         modulo_hz =3D REG_READ(MODULO[inst]);
>                         if (modulo_hz) {
> -                               temp =3D div_u64((uint64_t)clock_hz * dp_=
dto_ref_khz * 10, modulo_hz);
> -                               ASSERT(temp / 100 <=3D 0xFFFFFFFFUL);
> -                               *pixel_clk_100hz =3D (unsigned int)(temp =
/ 100);
> +                               temp =3D clock_hz * dp_dto_ref_khz * 10;
> +                               ASSERT(temp <=3D UINT_MAX * modulo_hz * 1=
00ULL);
> +                               *pixel_clk_100hz =3D div_u64(temp, modulo=
_hz * 100);
>                         } else
>                                 *pixel_clk_100hz =3D 0;
>                 } else {
> @@ -1285,13 +1285,12 @@ static bool dcn401_get_dp_dto_frequency_100hz(con=
st struct clock_source *clock_s
>                  *     - target pix_clk_hz =3D (DPDTO INTEGER * DPDTO MOD=
ULO + DPDTO PHASE)
>                  */
>                 temp =3D (unsigned long long)dp_dto_integer * modulo_hz +=
 phase_hz;
> -
> -               if (temp / 100 > 0xFFFFFFFFUL) {
> +               if (temp > (UINT_MAX * 100ULL)) {
>                         /* pixel rate 100hz should never be this high, if=
 it is, throw an assert and return 0  */
>                         BREAK_TO_DEBUGGER();
>                         *pixel_clk_100hz =3D 0;
>                 } else {
> -                       *pixel_clk_100hz =3D (unsigned int)(temp / 100);
> +                       *pixel_clk_100hz =3D div_u64(temp, 100);
>                 }
>
>                 return true;
> --
> 2.25.1
>
