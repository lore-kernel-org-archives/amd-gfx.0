Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802366087A20
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4Rcgq1Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2170D10E68F;
	Mon,  2 Nov 2026 16:26:27 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC0010E68F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:26:21 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1397a4855beso168891c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 08:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636781; cv=none;
 d=google.com; s=arc-20260327;
 b=N2mzie3etmcvF/K3gEsNn2t/PdXrL2PQQS4wsp7L4Yl3/7bzyhYGegwI5fD38NXcyj
 Ph+e0zoQA5H+IfhibAKbs+SJnrLIgGKpWZKWjq7FJkV9mE9/HciwQSREukc8ThwJ4AaS
 rGu/qKZA4gkFkyPWyJocW7M4K2kr3g0CPIxwDGy9zrn/45CQwqZvXvqjS32iJVR+43bd
 F1ATanxn/bkA+i5um4ev0LxbT8S/l5hwk/zrY43aWChshoml2C3HXW1wn0TMumrDhBsb
 ZIiuYoZJNezIqG6ByA9rmbSh7zf0yTQJlvAw9MVI5NSOireigTJ7atsFBHwjvK0U+NcE
 uQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qucegT0GPEVFirSiuMs+ziNH5YCrypPe21lyqCO0TWs=;
 fh=jdVbxspfGO7HeF3K423pceLWWnifVLAHoouXpEYuSqE=;
 b=oPmLPlxxjc60c2work3aOtMdwzXofjipGVA6SIjAFwwM6Q+s+trrJ6Mk9+6JDGxzJv
 vGKcMXTbFFLIUwpSxIZXn39kPXDsZspQ7qqnF0D6lG3kNQUFfLl9zjBM08ZxnNiLHnlz
 Pg24OuL43Cl3pgmu7ViHNslMNwwWvmfxpV4gdrvV/ZOCAZQSE22t+lebvseohRB7JHpn
 EaoGdaDaONDGz8+wER4HPmqv/u77AE1UjM5krcISgJmcCKS8baM5J8l50Y+3ksDtmnGK
 fwa02C6mcRZSEarm5XJOCXOmZ1iKpPvRY/QsNB2ZPTFxFf1yqSqOhiixyDMt2i7lh9Om
 nLTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793636781; x=1794241581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qucegT0GPEVFirSiuMs+ziNH5YCrypPe21lyqCO0TWs=;
 b=W4Rcgq1YnhL0tZw9YTqeE2LqTHnIZc9czMuaYrD2KV9JcyFjUgdvtly53F9uOljJPH
 Tjgx+hLyqjzZOkCV+WV2iofoyuC8FjDJBJksAxN/r6xTcbFHPRkOx/vcpdOl09W6ldON
 LR5v2LpqadDOlxcp2H9noGVEo9NhlJzld+uvjsMmIeQ0nV/E32tuR8AF1RKDBDg2VaC/
 s8q2WKHA5PJiNLUf3qRfPq7pIXGiSjt8F4cCEvEMagtQ7dQp6XtnGECzEIZSI0S0Pjrl
 XGD04WT6xKf+rCx111RoJ1EmiPwrPNKMFGpL2nBzmShGN0C79m1C2MbIym7dhT7BiAK6
 JYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636781; x=1794241581;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qucegT0GPEVFirSiuMs+ziNH5YCrypPe21lyqCO0TWs=;
 b=hLqPk7NJjhsDy64Sjf0M7f6qXqj6HENgji0Hzd1oXrmf0QkYyZTf7+kNT+R3zq61rw
 pdxjGv5CGA2GZQlsVmuA2feHSk4H1m0nnztjYOaKyi2J1j59FVfulq2hCye4MW4eDm/F
 BuToMJ8EkTZVuu/gTnAZAW0jm4ke2svRbwjMZXZzmt2RL+2bTyKrpg+0JAm2/OYDBgYg
 /ASpHRD84xwT3lp5hjvHgPJp7lYBKSprmNCTqX1NB81QtQZyAI7RtNbDkcE9N1R/wznz
 RqlN3/bfqyANn+bqWSTJFjsa3NnYd2KALO5AJmydjJ6M5X2jEG8vDQN5ZonfiOzsmrpN
 gYLA==
X-Gm-Message-State: AFq9FYJbml0F9fN+1flm4dZwu1j8nQJgf5aZvC5M2zO5LfTaf5Istqbe
 43UZpDqxFdk+yvtqXGfHd3Xu22WTzhZpvJID3r4kvCtS39++0PD9sdfkv/SVN4FxY5o52wA/Tqr
 SD+t4jHNpGBFIpm1EWzzM5Qhn+kq3Pq8=
X-Gm-Gg: AYBFou3QHlrU3RUuRtzIoVZSCTccCbV/hLjYGuEVeAD9B04oCcJgJqof3pVlalrd5sj
 4MXnWgiY2stmqVrht8AEZuATNkHOpPxgicriq1Vxyb6rkZ1NLVKrdXUsalXEZkhmYTzcbRC/stY
 M3cr1EGy8lcIipvXv9mTzmfwdqrKZsWqFeImOWo50CsATOJ7zGp70qUOG/GtQFKKGA7ekEnQhOW
 bE0b51vEcSqy5Uhr3Y7s55hqWVmvTAxWPUVEk7FMeTqM6Cuj7j0cDrSwEcbHIsLCwCxKFjFqW0s
 RohLmyYab1iZ85lYRnDvoiQVpO7xY+DojpQgWMoBOVGn9ply80Kkgd061HJhL+yArXmwZm4FyPL
 AXQIOidW9FCD/4OHtEP6Sz2y4x/sH3RDnxkdF2bAterQaJPGyPNhobLtC62gY8kxsee66g47g0h
 VbwqQciyVR03tkiAPdJyTrv8kOO1JsWuPqpKF5xWSS8syO
X-Received: by 2002:a05:7022:c90:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1ac5914348dmr21533874c88.2.1793636780378; Mon, 02 Nov 2026
 08:26:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMwFX_CpeF-K1-9R38Fscu7EghETOOV5FmJvd=8No7YhapvL1w@mail.gmail.com>
In-Reply-To: <CAMwFX_CpeF-K1-9R38Fscu7EghETOOV5FmJvd=8No7YhapvL1w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:26:08 -0500
X-Gm-Features: AclHuK9xq0E4ivi-W8VggfJkbcZCnlA03ilqfpjC2gopSzo50cdjzh-WV6hPi_g
Message-ID: <CADnq5_P-oF5U1sYWiDKGNRZOCEc5p-oOFA9zJpH69Cb2dUSEdQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/radeon: UVD GTT corruption and RV6xx coverage
To: Ted Bullock <tbullock@comlore.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org, airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

On Thu, Oct 29, 2026 at 4:05=E2=80=AFAM Ted Bullock <tbullock@comlore.com> =
wrote:
>
> I investigated video corruption on my older iMac7,1 (RV610/M74,
> device ID 1002:94c8).
>
> When the decoder was reading compressed video from system memory while
> the GPU was drawing, it would corrupt video frames. Moving the input
> to VRAM allowed frames to decode correctly. Disabling graphics draws
> also stopped the corruption.
>
> Here is a proposal to keep UVD buffers in VRAM for this family of
> devices, as the driver already does for some other chips. The patch
> covers RV610, RV620, RV630, RV635 and RV670. These chips share the
> RV6xx decoder path and legacy R600 firmware, so I think they are
> likely to have the same hardware requirements. Someone with the
> other hardware would need to verify that.
>
> I tested this on Debian.
>
> I used Codex to help with the investigation, testing and patch.
>
> Signed-off-by: Ted Bullock <tbullock@comlore.com>
> ---
>  drivers/gpu/drm/radeon/radeon_cs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_cs.c
> b/drivers/gpu/drm/radeon/radeon_cs.c
> index 2db819a..9bfd3ea 100644
> --- a/drivers/gpu/drm/radeon/radeon_cs.c
> +++ b/drivers/gpu/drm/radeon/radeon_cs.c
> @@ -125,11 +125,16 @@ static int radeon_cs_parser_relocs(struct
> radeon_cs_parser *p)
>
>                 /* The first reloc of an UVD job is the msg and that must=
 be in
>                  * VRAM, the second reloc is the DPB and for WMV that mus=
t be in
> -                * VRAM as well. Also put everything into VRAM on AGP car=
ds and older
> -                * IGP chips to avoid image corruptions
> +                * VRAM as well. Also put everything into VRAM on RV6xx, =
AGP cards
> +                * and older IGP chips to avoid image corruptions
>                  */
>                 if (p->ring =3D=3D R600_RING_TYPE_UVD_INDEX &&
>                     (i <=3D 0 || pci_find_capability(p->rdev->pdev, PCI_C=
AP_ID_AGP) ||
> +                    p->rdev->family =3D=3D CHIP_RV610 ||
> +                    p->rdev->family =3D=3D CHIP_RV620 ||
> +                    p->rdev->family =3D=3D CHIP_RV630 ||
> +                    p->rdev->family =3D=3D CHIP_RV635 ||
> +                    p->rdev->family =3D=3D CHIP_RV670 ||
>                      p->rdev->family =3D=3D CHIP_RS780 ||
>                      p->rdev->family =3D=3D CHIP_RS880)) {
