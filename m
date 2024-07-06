Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856C3C2BD09
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jul 2024 16:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4FB10E16C;
	Sat,  6 Jul 2024 16:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aCnYsYra";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC7010E031
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jul 2024 16:54:33 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2c961b5f215so1597868a91.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 06 Jul 2024 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720284873; x=1720889673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6JKp4wGLAdXhXxuz1tIdEkuCF6yf2YgaQ/zkOraCSs=;
 b=aCnYsYraB0G0YRfR6IupZ/GJzpSqXQxZ+qH/X5vlSz9x9CaceI6/FiW1x8iEeoSafD
 K4bsehpUd10uhBmiRBg6OReEoDBvmXxWWU8HMqDzlyTOXw3l2UA526fCz/qitiKFRMnD
 hlfntFtAq96A12pJ7PQTc9v7rlMnvlsEXAKGoXMmpKnVpocXHKWupMP52QExhGuRAa8C
 6zFBwkp9BzM3EQcm2AEJIloJXkb2ggCTuLv6QKR+qb2Q+sIaeEJPzgdAjR4Zsh9PDyOs
 +eivajvXAnJ75t2CbTV6Hei3BlW6TMTKqTIXrgwWmJhXsdz2l+3mRP1j3k9wYvLoWR1D
 qGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720284873; x=1720889673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6JKp4wGLAdXhXxuz1tIdEkuCF6yf2YgaQ/zkOraCSs=;
 b=Yl0t0yXGZpS01xFqtkePyWii5YYswlLRtINLkg/QuBIbXg2DJvaGJt1pdLzj7pNHv/
 Oftgwuq8+yfItDsdmki/TrjKaxnlQFGITqcvw2h8RhLUB61Cxaj6VBHzzZ5iA8rvJJ9Q
 RVxodWYMRrgmKPRh+jU5m9/9xdLw8tsXNY+4t4vDtC/XCnIY6357VGYKItcUAmY2J0d/
 UpF+dijAM2Ix0lz/uqDpZ1WeKk1EY+aACKbQXHMeFkQdADErXHRWh2fHPfWB/HPmR559
 mVevPeJ7tjwYz7PS0Ads2Tc6eV2gd7FVt76V9sd+a26Vni5AHcsFUZY+w9t1XBBhZxaj
 u8Zg==
X-Gm-Message-State: AOJu0YwpaUUtopiR+Fa8QqIWMMe/aeIXsVR1UtgrbP6jcpgBJ+i3bhrv
 nWC9o/vDzMLXKooxn03TF82CJseYi8pAzHBKxETyLj+eaI9ZpF4ynitp74/ENTwpPCEFNGBJ1fC
 X2XKv5FR2aAVh67k0I8UyDgIrOxU=
X-Google-Smtp-Source: AGHT+IE1k1mGmBZdycZv875ktl1ugdXspjgLanoQ5QtNpiCmTOsCx7AlnzbUqfyK89woyMdHN1tihNzZwjff/hXbDJg=
X-Received: by 2002:a17:90b:3ccd:b0:2c4:b8e1:89b0 with SMTP id
 98e67ed59e1d1-2c99c7f11c2mr4591868a91.30.1720284872525; Sat, 06 Jul 2024
 09:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240704145741.378053-1-kent.russell@amd.com>
In-Reply-To: <20240704145741.378053-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 6 Jul 2024 12:54:21 -0400
Message-ID: <CADnq5_OakwkjQv--9jwDsystOGpGwtQEXE3WaL8Xn85ugPW-Ow@mail.gmail.com>
Subject: Re: [PATCH] Documentation/amdgpu: Clarify MI200 and MI300 entries
To: Kent Russell <kent.russell@amd.com>
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

On Thu, Jul 4, 2024 at 11:15=E2=80=AFAM Kent Russell <kent.russell@amd.com>=
 wrote:
>
> Add "Series" to MI200 and MI300 to clarify that they represent the
> series of cards, and to more closely match the product information
> materials. This also matches other entries in this list
>
> Also correct a typo in the MI300 codename (Vangaram->Vanjaram)
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Document=
ation/gpu/amdgpu/dgpu-asic-info-table.csv
> index 3825f00ca9fe..d2f10ee69dfc 100644
> --- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> @@ -15,8 +15,8 @@ Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /=
WX200 Series, POLARIS12,
>  Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, =
VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
>  AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD=
 7.2.0, 4.2.0
>  MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
> -MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
> -MI300, AQUA_VANGARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
> +MI200 Series, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
> +MI300 Series, AQUA_VANJARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
>  AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.=
0, 10.1.10, VCN 2.0.0, 5.0.0
>  AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.=
0.0, 10.1.1, VCN 2.0.2, 5.0.2
>  AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3=
.0, VCN 3.0.0, 5.2.0
> --
> 2.34.1
>
