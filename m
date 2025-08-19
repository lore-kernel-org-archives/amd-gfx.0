Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786FECA0EED
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 13:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C44310E5F8;
	Tue, 19 Aug 2025 13:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="huQ1ffpd";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5103410E5F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:17:55 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-32326e20aeeso890595a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755609475; x=1756214275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yb2wWIRgGei7Vitk1cJphekZbG+iPDN5vxrYBvlgFzE=;
 b=huQ1ffpd1IpTWPwvp6eH2mQbGtWYova+LQe5UjUv4doHniWnS2Uvl7cxVvjH///xQV
 eAVfS21tF5xHvY/eu34Mj3afHUJNGfLUaDkd4eoS/B7cQ2nHBRcDsbY/TUsmDaWCgS7U
 WmAv2f76S822LD9/3Oq2MrXkNqvS3QdZecjORiZ+hgd1e9vN4XQ4YD8H25+25Z2so/px
 PJtdikFZXxg9ZkfM/53pJQoOItIHo8xJ02f++I07sisOiigeVJZzLv4shf3ddG6VY42l
 8NCn1TYRRiNuth8VxMTpRJkydJMKEqTjSN6SUp5xL+NJalxhWxamOQkz0LBfKoBYqMUZ
 XAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755609475; x=1756214275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yb2wWIRgGei7Vitk1cJphekZbG+iPDN5vxrYBvlgFzE=;
 b=Q7HZaILoE4/eV2D6Os2Zpa1ANVO91PJ/Ppu3Wyzons3ez/omPxUgqbhIJS9xPTDUUj
 UepuIDUeb4+lZRAFcCn5QzzOglYUs7q28+5iCnDy6aD21Zdh+2ExTMlZqwzoM8cKH+Oz
 7OhD5fOMXMkHNN60KKhynelbeYlZr7kiv4pZNMzFdl3+vpjZJ8Dqax5usa3PlDg1tDdW
 NEhwhoiRaevlS0YJXqW5RrXla5HqNXpt6W+pm2oN3qq6nQMf5RKPeWSlWMmxST79Ol02
 XNP+HybQwNvxoOa//fB9kJeVFs5cxcJYY1GtQ5byPwzT+cGSnOR8ObTp3yaH0ePVNPTg
 5Bdw==
X-Gm-Message-State: AOJu0YwW1fxQCZWuC3jTqI+c1pFBoGa9BTenTDcO2ZJABRnb/rfaXaM8
 8I+qF01AJNjUG8TX/l+QmPGRMxfSLejOfCN3t7ODbbc3DY4JZbykSuUytaZqt0siKeFJhq/w6IF
 01qi4P4m+SrzjOSDE8M/cHmTCdII+qJjrUw==
X-Gm-Gg: ASbGnctz82BCxlgbaorlmwBgmwgiDfnlQgXOWHrulgkmHbeUkExVbhutEcwo3PiGiRA
 j2hVm6ZgHBKPcB/TC5pLef4Mtv7x5YxVOPa8N0hmM0iMhE3c5LkfW5o39WllgHHZJxLCK3oNTHs
 reAXHm9jrvs6hoKWLh6XYOtQB9+V+82C1zaEALOyZc2+d1GAuELzXD+gNdiufu1TAgNwKpZNRgl
 7q0MiU=
X-Google-Smtp-Source: AGHT+IFeVQf4DpJ6HK8rF9mdjcWuedKhLH27AvPX8FWDTAyAagbmiHUVk6BitGT/UzNOj1bsS6gswS5Tp6LA9ROEe/U=
X-Received: by 2002:a17:902:d484:b0:231:c9bb:6105 with SMTP id
 d9443c01a7336-245e0197d7dmr17447725ad.0.1755609474694; Tue, 19 Aug 2025
 06:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250819020813.3998652-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250819020813.3998652-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Aug 2025 09:17:42 -0400
X-Gm-Features: Ac12FXzinEtAgFsDXLWM7p1MU6yup_rr-fqiI6GbaL0QjAUoWMFEmP3T3bNUDl8
Message-ID: <CADnq5_OrK2oWhW1HbUj=UeV9+=mX=rHw8fo9uJ7kn4G-Mm283w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Update SMU v13.0.6 caps initialization
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, lijo.lazar@amd.com,
 leo.liu@amd.com, sonny.jiang@amd.com
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

On Tue, Aug 19, 2025 at 2:23=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Update the conditions for setting the SMU vcn reset caps in the SMU v13.0=
.6 initialization function. Specifically:
>
> - Add support for VCN reset capability for firmware versions 0x00558200 a=
nd
>   above when the program version is 0.
> - Add support for VCN reset capability for firmware versions 0x05551800 a=
nd
>   above when the program version is 5.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 3484fce0d41a..c502e19bcc97 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -440,7 +440,9 @@ static void smu_v13_0_6_init_caps(struct smu_context =
*smu)
>             ((pgm =3D=3D 4) && (fw_ver >=3D 0x4557000)))
>                 smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>
> -       if ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100))
> +       if (((pgm =3D=3D 0) && (fw_ver >=3D 0x00558200)) ||
> +           ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100)) ||
> +           ((pgm =3D=3D 5) && (fw_ver >=3D 0x05551800)))
>                 smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>  }
>
> --
> 2.49.0
>
