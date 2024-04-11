Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7445ACD1292
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 07:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7123F10F208;
	Thu, 11 Apr 2024 07:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5rK2RAO";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34FD210EC4F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 01:46:56 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-617cd7bd929so68327597b3.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 18:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712800015; x=1713404815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFi8Oz0YV2woPJ+NOuQqliHLzn8T7fbeMzO2MlMmb4k=;
 b=D5rK2RAO0gBCGgI87MSLwOPalSPBQ0Rzn2UyMlB5UIv7e9Ghm763V1dqQBxuK36u4d
 qWz1l6d5vc0Jz6G16pFoJ0NNSDqZEOfv3KE8kw3enVQFnXVxxmXWyR6RxlFVw+eNcr9c
 Nm+7x6qbt8vSbXtiwGHPGd1K4EkcwzDa7lRmYJAVPTfA0mFORBODBHoYfRWABwc9gHQ0
 RkrFIv7zQ+nubWBlm+EoCdvcFiVkNsJj3FHQ8ZkYNnB1EUE6/eGbRZgHbKEMTAT6XDQp
 pYqVol9RreGv4Snh4+SWPX1k2bOx/P8xXAWtylRCp5n9idEmoCPFvQnLaR5/BoqmNtzf
 FwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712800015; x=1713404815;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFi8Oz0YV2woPJ+NOuQqliHLzn8T7fbeMzO2MlMmb4k=;
 b=PSsXVkTa0bpiwL3cUu+w2PHCKYNfdkOp2NH5ePGj/J8UY/4Cg80mS50bUxCeM+UX4R
 c4Z1UQTzAmEXPeCyheS0qyXqlMrZdY6kx3ZKiBhSk0FCM0fpbD0LNg6bGPE/bisPAim/
 3Ia0vamAXVO0xC/KbkBsWQk5tbT1NVoREXhtAE6OZDlk4W/yAmChyJ/g0gwesd3ydPgq
 MUa9HE1ayhHSkor46rQSH4Ug2h5MccvL4PXFFei0fpgNc5Q2wZmKJJ/LIWQz7donIQVJ
 1wjMXVbSy5Q7xWtAP9pbcKsJHz0kng6bVX07kJruWvQHzGRkbj6dhvyy/Nrdx/gOCluJ
 yYSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrD3jAXNOG6zpAufgY43Fb3zB8NzvMHz6FlD6yEz+uez/Yjrw1HThp9f2QCqIBTkkb5EODxFct4gGGkhaHpsQCvEYLZACzy00I1hHadg==
X-Gm-Message-State: AOJu0Yw/BpWrDwmfqzF0F8rtyJz5iDzCCO/zIUVp1x+X7Pb1NeUrGiP0
 +kd7hhFC6OXsdR/ajOhChNhlICo96BDVWczFdHmT3PTF4fyaXbdJqxilEY1GwMMvuPxxeV0E6rm
 p4XB+yK83lHCr6+PKK6I+Z7+I/X8LEQ==
X-Google-Smtp-Source: AGHT+IFKvk63eyCkqrSk3c+YyxDoW1TJqHPcSFxuEq8130cnSxRADMGuY7h7sKUBR39b3X8Gpu2A7b+EZDh1tmUKvaI=
X-Received: by 2002:a25:848d:0:b0:dca:a3e8:a25a with SMTP id
 v13-20020a25848d000000b00dcaa3e8a25amr4428485ybk.62.1712800015000; Wed, 10
 Apr 2024 18:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240410221336.34627-1-joshua@froggi.es>
In-Reply-To: <20240410221336.34627-1-joshua@froggi.es>
From: Ethan Lee <flibitijibibo@gmail.com>
Date: Wed, 10 Apr 2024 21:46:43 -0400
Message-ID: <CAGLTkm7vvmnAs3xs7KASPBcCYtPw2EaSyR27S-NBQzmgP7+czw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 11 Apr 2024 07:41:32 +0000
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

On Wed, Apr 10, 2024 at 6:13=E2=80=AFPM Joshua Ashton <joshua@froggi.es> wr=
ote:
>
> The comment here states "no OGAM in DPP since DCN1", yet that is not
> true.
>
> Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
> works fine.
> My best guess is the comment is confused with OGAM ROM for DPP, rather
> than OGAM RAM.
>
> I did not test dcn35/351 as I do not have that hardware, but I assume
> the same follows there given the seemingly erroneous comment.
> Someone at AMD should check that before merging this commit.
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Ethan Lee <flibitijibibo@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 9aa39bd25be9..94f5d2b5aadf 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
>         dc->caps.color.dpp.dgam_rom_for_yuv =3D 0;
>
>         dc->caps.color.dpp.hw_3d_lut =3D 1;
> -       dc->caps.color.dpp.ogam_ram =3D 0;  // no OGAM in DPP since DCN1
> +       dc->caps.color.dpp.ogam_ram =3D 1;
>         // no OGAM ROM on DCN2 and later ASICs
>         dc->caps.color.dpp.ogam_rom_caps.srgb =3D 0;
>         dc->caps.color.dpp.ogam_rom_caps.bt2020 =3D 0;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 25ac450944e7..708d63cc3f7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
>         dc->caps.color.dpp.dgam_rom_for_yuv =3D 0;
>
>         dc->caps.color.dpp.hw_3d_lut =3D 1;
> -       dc->caps.color.dpp.ogam_ram =3D 0;  // no OGAM in DPP since DCN1
> +       dc->caps.color.dpp.ogam_ram =3D 1;
>         // no OGAM ROM on DCN301
>         dc->caps.color.dpp.ogam_rom_caps.srgb =3D 0;
>         dc->caps.color.dpp.ogam_rom_caps.bt2020 =3D 0;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 8a57adb27264..053e8ec6d1ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
>         dc->caps.color.dpp.dgam_rom_for_yuv =3D 0;
>
>         dc->caps.color.dpp.hw_3d_lut =3D 1;
> -       dc->caps.color.dpp.ogam_ram =3D 0;  // no OGAM in DPP since DCN1
> +       dc->caps.color.dpp.ogam_ram =3D 1;
>         // no OGAM ROM on DCN301
>         dc->caps.color.dpp.ogam_rom_caps.srgb =3D 0;
>         dc->caps.color.dpp.ogam_rom_caps.bt2020 =3D 0;
> --
> 2.44.0
>

Tested dcn32 on a 7900XTX, applied against kernel 6.8.5, confirmed
working with gamescope compositor.

Tested-by: Ethan Lee <flibitijibibo@gmail.com>

-Ethan
