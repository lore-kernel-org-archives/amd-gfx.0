Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FA8C3601E
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 13:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15B910E012;
	Sun, 13 Apr 2025 13:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FGTgklLW";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0551410E012
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 13:54:58 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so555706a91.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744552497; x=1745157297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwEdHL4af0Jon0tRwd6wwyiEBUfdW466Agxs8/vt3mY=;
 b=FGTgklLWn5unqlhr+X0eJrxbVcgT7zjme7mwxMJQ/vnq0Z1dQVLBMY+Pr1nTxqvale
 00OTjfv8SUDqSu3oZXnUXprYEL6fvcJEX17nyK+Lvri1pt2eXblUEuNNAf7B6rMnFzoO
 lJASbmpovEJLnD0eVr+mM0fdkrGy+tMIVQ4Wd1vZzm2OF2kMDxqKoIlon2thSkV9uY5T
 +Sc+Nl01vkf5rlzXJ0553wQgTW+cvFe15MsLJYA4ugEDtq5SwjQvyeG2kIPjjmC6afqk
 9wcjBXLIe2gk/wiaeGpxHZH4+Hn5F9NslOzA2KG229XeKXbYyycNaRt54+YXP13XjYTV
 ga2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744552497; x=1745157297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwEdHL4af0Jon0tRwd6wwyiEBUfdW466Agxs8/vt3mY=;
 b=LzxAKyDRwBcXZwCSaBJDlvEBDWXon/QsQSu45wG+1pJ4sl17a9tZD34S25ELIoNf7L
 HlDAqh2w7hf0kFHMZ267EA2au5cPW30Fy1RjlOxpoT8Gz9Zy8u0bzHkXKGl5jiyQ/K0F
 PQOmbcWK3ksuL8RcpzqcPQvSOeFzfp8D8M6EWq/ngZzqWNyFXDcHUcLFJhipv/rZTpLc
 yJjJB2Ov3tfwgZ0/AZ5w4h01ZTjewpSckQPF+WPsqE/A3EzZDkTSHpwt5VVC2Z3UFObF
 4tDMY6U/KdOLuOII3fCfCom34TLMbtEqjwhl19jJm74+1wSpwbGLBAO24lLkJGOF/TYe
 c4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9s19kUhsXFU1SmmbSnxd0uFd9Txy1h7BV6Vzd/3vWGw1OY4EVCpckP1wtq1E+pLnRmj3+/iep@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpEhXWdwdQTgG6tocHjOazotKAqWmW3Vf8rKneYR1rp7BMZMSe
 1eKs0LypQPurQaSC67q+oIHs/lEMGhufyX+wik97/lsnE4pJRrgzTgJP1bgGu/4Jp0xb5tQvgU7
 KvGJVSdObA/JXpjwOaIu5oXWxdPUpElHk
X-Gm-Gg: ASbGncvlVI1eebrsmXF5xv7gINk+O/6VfokwmSMYjjob4iSq3Ncg6nRylxhCwN7mFTD
 fYi7sHABMsQZl6ef6AkxxUz8027JQfHpyhf3Dai3DVlvWaJdnolbiGO7k73nSR6qnE2oN9Reir0
 DjRLVUiKtGgeeqsVDCw0O8tQ==
X-Google-Smtp-Source: AGHT+IHKNigekW5u4hnvGWuF/OLQEb7BaDJB0oxQexs7JmEtppAXPpokDDFddoCO/UO1LZB1y76+CYsLbCfoNZBCmJo=
X-Received: by 2002:a17:90b:4d04:b0:305:5f20:b28c with SMTP id
 98e67ed59e1d1-308237c95b7mr5020210a91.5.1744552497307; Sun, 13 Apr 2025
 06:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250412202134.3025051-1-siqueira@igalia.com>
 <20250412202134.3025051-8-siqueira@igalia.com>
In-Reply-To: <20250412202134.3025051-8-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 13 Apr 2025 09:54:45 -0400
X-Gm-Features: ATxdqUF1WmjmV7TBUnw_Efo1e0sbePRBKAtoxr5CmbST4PXXrXGq0EWXHPKdnqE
Message-ID: <CADnq5_NCyuZdO4gHzpjfV_ASZ+ExkWAb41jeE+N+DBqfQuUaZA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] drm/amdgpu/gfx: Clean up gfx_v7_0_get_csb_buffer
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Sat, Apr 12, 2025 at 4:22=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> CHIP_KAVERI, CHIP_KABINI, and CHIP_MULLINS have the same buffer
> manipulation as the default option in the switch case. Remove those
> specific manipulations and rely on the default behavior for them.
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 16b94ff5a959..4d8d68b737d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3902,15 +3902,6 @@ static void gfx_v7_0_get_csb_buffer(struct amdgpu_=
device *adev,
>                 buffer[count++] =3D cpu_to_le32(0x16000012);
>                 buffer[count++] =3D cpu_to_le32(0x00000000);
>                 break;
> -       case CHIP_KAVERI:
> -               buffer[count++] =3D cpu_to_le32(0x00000000); /* XXX */
> -               buffer[count++] =3D cpu_to_le32(0x00000000);
> -               break;
> -       case CHIP_KABINI:
> -       case CHIP_MULLINS:
> -               buffer[count++] =3D cpu_to_le32(0x00000000); /* XXX */
> -               buffer[count++] =3D cpu_to_le32(0x00000000);
> -               break;

These should be fixed rather than removed.  Actually, all of these
should be fixed up for all chips.  We should use the values calculated
by the driver similar to what we do in gfx_v8.  E.g.,
        buffer[count++] =3D
cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
        buffer[count++] =3D
cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);

Alex

>         case CHIP_HAWAII:
>                 buffer[count++] =3D cpu_to_le32(0x3a00161a);
>                 buffer[count++] =3D cpu_to_le32(0x0000002e);
> --
> 2.49.0
>
