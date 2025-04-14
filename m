Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54278C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 15:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53BB10E612;
	Mon, 14 Apr 2025 15:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMK+dScu";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909E010E612
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 15:08:37 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-af51b57ea41so422770a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744643317; x=1745248117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRIZTk7MyAlpDvcRPhS0x8rTpR86+o5tI6wPqbnAJB4=;
 b=AMK+dScuP0XthaPtf+Sb6BD6JoalsWO4zntLHqJqDYmNdX82Lh8zsknKjeNY5SbHvX
 oNIeuZodH4c8dsl45bKjyd6yALPgHepCy04pmAISnC2iihtyyyxlTM+9YT5NGRnh0nE2
 EoIYnC9Cd4aEdW3nLRgjNWrfz3H3n/Gp8iKBOoDYx7dtq9nfZm0BYje6olwq03A5cuIK
 p0/h9XBmgbgPdu/xWCBJkuQBb2PA4X97SGOtBpNqSngF04K/hYkqSQc0IIpKRdULhA6o
 1omH462gzHkZtBJYEKLVVStq1BuZweRcav3d/AmEt94saHedgB4DpV1oAn/vsG3eaTdM
 FjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744643317; x=1745248117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRIZTk7MyAlpDvcRPhS0x8rTpR86+o5tI6wPqbnAJB4=;
 b=xSITxInPg2nwCIKJX+PF4EFDRu5r/SNTk1KJIrXThiTm8penWLyU1i8DO2KT99hBec
 U1d3DuDydZKf5uALG8L0cqGEwbCMmUfE4BJCGqltmDV/LppqgOyfYGsbHoaQCOY0gwps
 nk2GwgKktryAN3t7laE/LNYCdmAHVl1Tk6n/F7A/6z0b0qsMaU4LwmTYQu95n+2czFxt
 sQiM+38/3/gTIVpM/aGrL7+kepddtmUFYr9gqLSMyrtb7Ec4CXzc698aaUgpASEe1RGE
 Ef0Fce9JoewmobTfscrlWtSc6ckcwGuiPF1cs3i1eyE0pcysFnBk9GWUrhdNjjjyIHl2
 nucg==
X-Gm-Message-State: AOJu0Yyc9eitxXg/gmRLXAt2amXXJf61lFHAFeIPqooEmjGiFFbiv+6n
 gxOs+AwbgTY/yaZXUTChaqtUCF4qTdqcQJ6KBSlzxUONfkVbqmFP8r4PdHXrmf7F1PmDtnhDqCP
 C9kF5o5lKs8IsbkqqHPcR2rwMW9320g==
X-Gm-Gg: ASbGncsOEzWLcNjEa2Fi9y1qi+4Tn5+aQsE/eEoPVQ01UaLBdTtP7/TiX9rYXtfw5OM
 CmJhegnuIyEjx0vgz5Pm2789Hzq+s2w9C8jlPyTtrHLd40Hke86qLZJszssjSS5KPc2CJgEDIv7
 t+bb6zgal701QZN8i/ijkcWg==
X-Google-Smtp-Source: AGHT+IFV3lWkiC5hCFC5SRf1ryPPc0eM4vhezZWmGCbx1mw2GecCgAN33IKtBwfzvw6LUsbIf/pvlN4u/HiLUVwSD8g=
X-Received: by 2002:a17:90b:4b12:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-308237b1aa9mr7870188a91.4.1744643316875; Mon, 14 Apr 2025
 08:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250413205121.5702-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250413205121.5702-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Apr 2025 11:08:24 -0400
X-Gm-Features: ATxdqUHHpSMHqA5DH9P4c7NBdbhRXr2jFr5c36t9x6nrMj2Ub6rpdoNUhlZk5Xc
Message-ID: <CADnq5_PGnG3=khQiBVBk-dQ+wr+Z1Qe_z4xbSWGiTuDWSKemtw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing DCE6 to dce_version_to_string()
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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

Applied.  Thanks!

On Sun, Apr 13, 2025 at 4:51=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Missing DCE 6.0 6.1 and 6.4 are identified as UNKNOWN. Fix this.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm=
/amd/display/dc/dc_helper.c
> index b402be59b2c8..3d483b5193e1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
> @@ -689,6 +689,12 @@ void reg_sequence_wait_done(const struct dc_context =
*ctx)
>  char *dce_version_to_string(const int version)
>  {
>         switch (version) {
> +       case DCE_VERSION_6_0:
> +               return "DCE 6.0";
> +       case DCE_VERSION_6_1:
> +               return "DCE 6.1";
> +       case DCE_VERSION_6_4:
> +               return "DCE 6.4";
>         case DCE_VERSION_8_0:
>                 return "DCE 8.0";
>         case DCE_VERSION_8_1:
> --
> 2.49.0
>
