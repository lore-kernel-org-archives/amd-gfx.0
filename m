Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19FFC19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 16:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6652010EB3A;
	Thu, 27 Feb 2025 16:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+1SMbdM";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BF710EB3A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 16:53:39 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fd02536660so297628a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 08:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740675219; x=1741280019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFk4m4XbUFicTNejx4arcHYFJNOrZgxFFb6fqtWyk+A=;
 b=P+1SMbdMo2iBUpkze06IWT8SmXKz1HwX/tU+pfC0jIWOeGtUoKWj2qVkL6Nvm/MlLY
 EVCaEyKXSVioIfHOaGU+VCwfo7qaIN2hALTjEyF5OOletUgxVvfZB8fz1C6x2PVsmp+p
 8l8IhMWWsoIyUO5BfE0CdN/lavpNaX/2KhJWUH9WVwR4msEO+xrxcBv7mUr3j/dKKr55
 dp13/+yW1nhVNKX1ZqY6G3xPvh3XKv/++XoJSM20tJnlg2q8v6nsi9UOhaAAyEqri/x2
 GmoSGqC3GKZflPHBJxKPFtOgKhJByptFbB4iPEBErpqwax0vpm8zLTw/AQhRoaGWbNwu
 RZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675219; x=1741280019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFk4m4XbUFicTNejx4arcHYFJNOrZgxFFb6fqtWyk+A=;
 b=Yr7F2bNkv7HE2rkFVQz01khvV66p80YEUPcIyuWYxJ92UKpQ+js0SlEieNdjCSma9e
 NWe5SeEqN+IQwM06uYDHm4U+1KAk9mmVxzyxteNCOpwhboyMQYlqWRh0Or0IivF8xISR
 fbc5Ny5VwWvBSe21TEloKLnSFMNYrdfrRHLQVk8hn+Gz7Geutvxr+cpGRFNrcY+Jocce
 lO/OQCQn0ft3sff3QwwquYOqi37drL2ccFqCoHO9BcavngiZbvwJqoyTq3eBN4gmD3Xh
 uG4Ekh78+w1MnQ0iomC6KsXITVGJSuGfccTT5s/7ArmyWPn3E0thmxAanfUVn47AMIzv
 IgYQ==
X-Gm-Message-State: AOJu0YyCoyxk5a13S5RfZGw8G/QTuG5dh0QfajMAtMl13O1VtFQxsJkM
 C2mWPH8YDNQsd2SfDBQ/s2mHTC5qjjrl193GxvoKEeASYbqjBGg0ty5yV2z5WZdBZvKjfFI62kU
 Pz+W7SIpZErNZQXKqTP7C1s2BOHWhpg==
X-Gm-Gg: ASbGncs9KAxkd36vbeaSnd6/TrSNpUXVwC5bNEY5qmzipl/Do37IlJXZKHbVd83LlMS
 L+TShUwu9BHg9+xZCZTyoF3pp8Z01QfRbCEBnkRMnuWMlnUAfNdK35wAxiyRyG4ffzcgWkdxfVP
 F4ESCoObM=
X-Google-Smtp-Source: AGHT+IF/TC0NvrBLIGmmnoMxqMhYBXXJwbz/qYDX+UXghWj+jSlagUwQj9XCAd4QqRER+jYQL5MN77wQF7VJry8Z5j4=
X-Received: by 2002:a17:90b:3891:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2febab19eebmr20984a91.1.1740675218510; Thu, 27 Feb 2025
 08:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20250207233837.2738432-1-jay.cornwall@amd.com>
In-Reply-To: <20250207233837.2738432-1-jay.cornwall@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 11:53:25 -0500
X-Gm-Features: AQ5f1Jq66WlfjANZGm_njWlzuAaBFXwYxjXMdtXvFv3gGvrQlWcgcjcYRiMMMkg
Message-ID: <CADnq5_NWRZxRVsr9W_gfvEVgEAs5mNJq2OgR8u2x-hdyGbRCmg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: Fix instruction hazard in gfx12 trap
 handler
To: Jay Cornwall <jay.cornwall@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lancelot Six <lancelot.six@amd.com>
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

On Fri, Feb 7, 2025 at 6:57=E2=80=AFPM Jay Cornwall <jay.cornwall@amd.com> =
wrote:
>
> VALU instructions with SGPR source need wait states to avoid hazard
> with SALU using different SGPR.
>
> v2: Eliminate some hazards to reduce code explosion
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 677 ++++++++++--------
>  .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  82 ++-
>  2 files changed, 404 insertions(+), 355 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu=
/drm/amd/amdkfd/cwsr_trap_handler.h
> index 651660958e5b..0320163b6e74 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -3644,7 +3644,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] =3D =
{
>  };
>
>  static const uint32_t cwsr_trap_gfx12_hex[] =3D {
> -       0xbfa00001, 0xbfa0024b,
> +       0xbfa00001, 0xbfa002a2,
>         0xb0804009, 0xb8f8f804,
>         0x9178ff78, 0x00008c00,
>         0xb8fbf811, 0x8b6eff78,
> @@ -3718,7 +3718,15 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>         0x00011677, 0xd7610000,
>         0x00011a79, 0xd7610000,
>         0x00011c7e, 0xd7610000,
> -       0x00011e7f, 0xbefe00ff,
> +       0x00011e7f, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xbefe00ff,
>         0x00003fff, 0xbeff0080,
>         0xee0a407a, 0x000c0000,
>         0x00004000, 0xd760007a,
> @@ -3755,38 +3763,46 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D {
>         0x00000200, 0xbef600ff,
>         0x01000000, 0x7e000280,
>         0x7e020280, 0x7e040280,
> -       0xbefd0080, 0xbe804ec2,
> -       0xbf94fffe, 0xb8faf804,
> -       0x8b7a847a, 0x91788478,
> -       0x8c787a78, 0xd7610002,
> -       0x0000fa71, 0x807d817d,
> -       0xd7610002, 0x0000fa6c,
> -       0x807d817d, 0x917aff6d,
> -       0x80000000, 0xd7610002,
> -       0x0000fa7a, 0x807d817d,
> -       0xd7610002, 0x0000fa6e,
> -       0x807d817d, 0xd7610002,
> -       0x0000fa6f, 0x807d817d,
> -       0xd7610002, 0x0000fa78,
> -       0x807d817d, 0xb8faf811,
> -       0xd7610002, 0x0000fa7a,
> -       0x807d817d, 0xd7610002,
> -       0x0000fa7b, 0x807d817d,
> -       0xb8f1f801, 0xd7610002,
> -       0x0000fa71, 0x807d817d,
> -       0xb8f1f814, 0xd7610002,
> -       0x0000fa71, 0x807d817d,
> -       0xb8f1f815, 0xd7610002,
> -       0x0000fa71, 0x807d817d,
> -       0xb8f1f812, 0xd7610002,
> -       0x0000fa71, 0x807d817d,
> -       0xb8f1f813, 0xd7610002,
> -       0x0000fa71, 0x807d817d,
> +       0xbe804ec2, 0xbf94fffe,
> +       0xb8faf804, 0x8b7a847a,
> +       0x91788478, 0x8c787a78,
> +       0x917aff6d, 0x80000000,
> +       0xd7610002, 0x00010071,
> +       0xd7610002, 0x0001026c,
> +       0xd7610002, 0x0001047a,
> +       0xd7610002, 0x0001066e,
> +       0xd7610002, 0x0001086f,
> +       0xd7610002, 0x00010a78,
> +       0xd7610002, 0x00010e7b,
> +       0xd8500000, 0x00000000,
> +       0xd8500000, 0x00000000,
> +       0xd8500000, 0x00000000,
> +       0xd8500000, 0x00000000,
> +       0xd8500000, 0x00000000,
> +       0xd8500000, 0x00000000,
> +       0xd8500000, 0x00000000,
> +       0xd8500000, 0x00000000,
> +       0xb8faf811, 0xd7610002,
> +       0x00010c7a, 0xb8faf801,
> +       0xd7610002, 0x0001107a,
> +       0xb8faf814, 0xd7610002,
> +       0x0001127a, 0xb8faf815,
> +       0xd7610002, 0x0001147a,
> +       0xb8faf812, 0xd7610002,
> +       0x0001167a, 0xb8faf813,
> +       0xd7610002, 0x0001187a,
>         0xb8faf802, 0xd7610002,
> -       0x0000fa7a, 0x807d817d,
> -       0xbefa50c1, 0xbfc70000,
> -       0xd7610002, 0x0000fa7a,
> -       0x807d817d, 0xbefe00ff,
> +       0x00011a7a, 0xbefa50c1,
> +       0xbfc70000, 0xd7610002,
> +       0x00011c7a, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xbefe00ff,
>         0x0000ffff, 0xbeff0080,
>         0xc4068070, 0x008ce802,
>         0x00000000, 0xbefe00c1,
> @@ -3801,331 +3817,358 @@ static const uint32_t cwsr_trap_gfx12_hex[] =3D=
 {
>         0xbe824102, 0xbe844104,
>         0xbe864106, 0xbe884108,
>         0xbe8a410a, 0xbe8c410c,
> -       0xbe8e410e, 0xd7610002,
> -       0x0000f200, 0x80798179,
> -       0xd7610002, 0x0000f201,
> -       0x80798179, 0xd7610002,
> -       0x0000f202, 0x80798179,
> -       0xd7610002, 0x0000f203,
> -       0x80798179, 0xd7610002,
> -       0x0000f204, 0x80798179,
> -       0xd7610002, 0x0000f205,
> -       0x80798179, 0xd7610002,
> -       0x0000f206, 0x80798179,
> -       0xd7610002, 0x0000f207,
> -       0x80798179, 0xd7610002,
> -       0x0000f208, 0x80798179,
> -       0xd7610002, 0x0000f209,
> -       0x80798179, 0xd7610002,
> -       0x0000f20a, 0x80798179,
> -       0xd7610002, 0x0000f20b,
> -       0x80798179, 0xd7610002,
> -       0x0000f20c, 0x80798179,
> -       0xd7610002, 0x0000f20d,
> -       0x80798179, 0xd7610002,
> -       0x0000f20e, 0x80798179,
> -       0xd7610002, 0x0000f20f,
> -       0x80798179, 0xbf06a079,
> -       0xbfa10007, 0xc4068070,
> +       0xbe8e410e, 0xbf068079,
> +       0xbfa10032, 0xd7610002,
> +       0x00010000, 0xd7610002,
> +       0x00010201, 0xd7610002,
> +       0x00010402, 0xd7610002,
> +       0x00010603, 0xd7610002,
> +       0x00010804, 0xd7610002,
> +       0x00010a05, 0xd7610002,
> +       0x00010c06, 0xd7610002,
> +       0x00010e07, 0xd7610002,
> +       0x00011008, 0xd7610002,
> +       0x00011209, 0xd7610002,
> +       0x0001140a, 0xd7610002,
> +       0x0001160b, 0xd7610002,
> +       0x0001180c, 0xd7610002,
> +       0x00011a0d, 0xd7610002,
> +       0x00011c0e, 0xd7610002,
> +       0x00011e0f, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0x80799079,
> +       0xbfa00038, 0xd7610002,
> +       0x00012000, 0xd7610002,
> +       0x00012201, 0xd7610002,
> +       0x00012402, 0xd7610002,
> +       0x00012603, 0xd7610002,
> +       0x00012804, 0xd7610002,
> +       0x00012a05, 0xd7610002,
> +       0x00012c06, 0xd7610002,
> +       0x00012e07, 0xd7610002,
> +       0x00013008, 0xd7610002,
> +       0x00013209, 0xd7610002,
> +       0x0001340a, 0xd7610002,
> +       0x0001360b, 0xd7610002,
> +       0x0001380c, 0xd7610002,
> +       0x00013a0d, 0xd7610002,
> +       0x00013c0e, 0xd7610002,
> +       0x00013e0f, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0x80799079,
> +       0xc4068070, 0x008ce802,
> +       0x00000000, 0x8070ff70,
> +       0x00000080, 0xbef90080,
> +       0x7e040280, 0x807d907d,
> +       0xbf0aff7d, 0x00000060,
> +       0xbfa2ff88, 0xbe804100,
> +       0xbe824102, 0xbe844104,
> +       0xbe864106, 0xbe884108,
> +       0xbe8a410a, 0xd7610002,
> +       0x00010000, 0xd7610002,
> +       0x00010201, 0xd7610002,
> +       0x00010402, 0xd7610002,
> +       0x00010603, 0xd7610002,
> +       0x00010804, 0xd7610002,
> +       0x00010a05, 0xd7610002,
> +       0x00010c06, 0xd7610002,
> +       0x00010e07, 0xd7610002,
> +       0x00011008, 0xd7610002,
> +       0x00011209, 0xd7610002,
> +       0x0001140a, 0xd7610002,
> +       0x0001160b, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xd8500000,
> +       0x00000000, 0xc4068070,
>         0x008ce802, 0x00000000,
> +       0xbefe00c1, 0x857d9973,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbfa20002, 0xbeff0080,
> +       0xbfa00001, 0xbeff00c1,
> +       0xb8fb4306, 0x8b7bc17b,
> +       0xbfa10044, 0x8b7aff6d,
> +       0x80000000, 0xbfa10041,
> +       0x847b897b, 0xbef6007b,
> +       0xb8f03b05, 0x80708170,
> +       0xbf0d9973, 0xbfa20002,
> +       0x84708970, 0xbfa00001,
> +       0x84708a70, 0xb8fa1e06,
> +       0x847a8a7a, 0x80707a70,
> +       0x8070ff70, 0x00000200,
>         0x8070ff70, 0x00000080,
> -       0xbef90080, 0x7e040280,
> -       0x807d907d, 0xbf0aff7d,
> -       0x00000060, 0xbfa2ffbb,
> -       0xbe804100, 0xbe824102,
> -       0xbe844104, 0xbe864106,
> -       0xbe884108, 0xbe8a410a,
> -       0xd7610002, 0x0000f200,
> -       0x80798179, 0xd7610002,
> -       0x0000f201, 0x80798179,
> -       0xd7610002, 0x0000f202,
> -       0x80798179, 0xd7610002,
> -       0x0000f203, 0x80798179,
> -       0xd7610002, 0x0000f204,
> -       0x80798179, 0xd7610002,
> -       0x0000f205, 0x80798179,
> -       0xd7610002, 0x0000f206,
> -       0x80798179, 0xd7610002,
> -       0x0000f207, 0x80798179,
> -       0xd7610002, 0x0000f208,
> -       0x80798179, 0xd7610002,
> -       0x0000f209, 0x80798179,
> -       0xd7610002, 0x0000f20a,
> -       0x80798179, 0xd7610002,
> -       0x0000f20b, 0x80798179,
> -       0xc4068070, 0x008ce802,
> -       0x00000000, 0xbefe00c1,
> -       0x857d9973, 0x8b7d817d,
> -       0xbf06817d, 0xbfa20002,
> -       0xbeff0080, 0xbfa00001,
> -       0xbeff00c1, 0xb8fb4306,
> -       0x8b7bc17b, 0xbfa10044,
> -       0x8b7aff6d, 0x80000000,
> -       0xbfa10041, 0x847b897b,
> -       0xbef6007b, 0xb8f03b05,
> -       0x80708170, 0xbf0d9973,
> -       0xbfa20002, 0x84708970,
> -       0xbfa00001, 0x84708a70,
> -       0xb8fa1e06, 0x847a8a7a,
> -       0x80707a70, 0x8070ff70,
> -       0x00000200, 0x8070ff70,
> -       0x00000080, 0xbef600ff,
> -       0x01000000, 0xd71f0000,
> -       0x000100c1, 0xd7200000,
> -       0x000200c1, 0x16000084,
> -       0x857d9973, 0x8b7d817d,
> -       0xbf06817d, 0xbefd0080,
> -       0xbfa20013, 0xbe8300ff,
> -       0x00000080, 0xbf800000,
> -       0xbf800000, 0xbf800000,
> -       0xd8d80000, 0x01000000,
> -       0xbf8a0000, 0xc4068070,
> -       0x008ce801, 0x00000000,
> -       0x807d037d, 0x80700370,
> -       0xd5250000, 0x0001ff00,
> -       0x00000080, 0xbf0a7b7d,
> -       0xbfa2fff3, 0xbfa00012,
> -       0xbe8300ff, 0x00000100,
> +       0xbef600ff, 0x01000000,
> +       0xd71f0000, 0x000100c1,
> +       0xd7200000, 0x000200c1,
> +       0x16000084, 0x857d9973,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbefd0080, 0xbfa20013,
> +       0xbe8300ff, 0x00000080,
>         0xbf800000, 0xbf800000,
>         0xbf800000, 0xd8d80000,
>         0x01000000, 0xbf8a0000,
>         0xc4068070, 0x008ce801,
>         0x00000000, 0x807d037d,
>         0x80700370, 0xd5250000,
> -       0x0001ff00, 0x00000100,
> +       0x0001ff00, 0x00000080,
>         0xbf0a7b7d, 0xbfa2fff3,
> -       0xbefe00c1, 0x857d9973,
> -       0x8b7d817d, 0xbf06817d,
> -       0xbfa20004, 0xbef000ff,
> -       0x00000200, 0xbeff0080,
> -       0xbfa00003, 0xbef000ff,
> -       0x00000400, 0xbeff00c1,
> -       0xb8fb3b05, 0x807b817b,
> -       0x847b827b, 0x857d9973,
> -       0x8b7d817d, 0xbf06817d,
> -       0xbfa2001b, 0xbef600ff,
> -       0x01000000, 0xbefd0084,
> -       0xbf0a7b7d, 0xbfa10040,
> -       0x7e008700, 0x7e028701,
> -       0x7e048702, 0x7e068703,
> -       0xc4068070, 0x008ce800,
> -       0x00000000, 0xc4068070,
> -       0x008ce801, 0x00008000,
> -       0xc4068070, 0x008ce802,
> -       0x00010000, 0xc4068070,
> -       0x008ce803, 0x00018000,
> -       0x807d847d, 0x8070ff70,
> -       0x00000200, 0xbf0a7b7d,
> -       0xbfa2ffeb, 0xbfa0002a,
> +       0xbfa00012, 0xbe8300ff,
> +       0x00000100, 0xbf800000,
> +       0xbf800000, 0xbf800000,
> +       0xd8d80000, 0x01000000,
> +       0xbf8a0000, 0xc4068070,
> +       0x008ce801, 0x00000000,
> +       0x807d037d, 0x80700370,
> +       0xd5250000, 0x0001ff00,
> +       0x00000100, 0xbf0a7b7d,
> +       0xbfa2fff3, 0xbefe00c1,
> +       0x857d9973, 0x8b7d817d,
> +       0xbf06817d, 0xbfa20004,
> +       0xbef000ff, 0x00000200,
> +       0xbeff0080, 0xbfa00003,
> +       0xbef000ff, 0x00000400,
> +       0xbeff00c1, 0xb8fb3b05,
> +       0x807b817b, 0x847b827b,
> +       0x857d9973, 0x8b7d817d,
> +       0xbf06817d, 0xbfa2001b,
>         0xbef600ff, 0x01000000,
>         0xbefd0084, 0xbf0a7b7d,
> -       0xbfa10015, 0x7e008700,
> +       0xbfa10040, 0x7e008700,
>         0x7e028701, 0x7e048702,
>         0x7e068703, 0xc4068070,
>         0x008ce800, 0x00000000,
>         0xc4068070, 0x008ce801,
> -       0x00010000, 0xc4068070,
> -       0x008ce802, 0x00020000,
> +       0x00008000, 0xc4068070,
> +       0x008ce802, 0x00010000,
>         0xc4068070, 0x008ce803,
> -       0x00030000, 0x807d847d,
> -       0x8070ff70, 0x00000400,
> +       0x00018000, 0x807d847d,
> +       0x8070ff70, 0x00000200,
>         0xbf0a7b7d, 0xbfa2ffeb,
> -       0xb8fb1e06, 0x8b7bc17b,
> -       0xbfa1000d, 0x847b837b,
> -       0x807b7d7b, 0xbefe00c1,
> -       0xbeff0080, 0x7e008700,
> +       0xbfa0002a, 0xbef600ff,
> +       0x01000000, 0xbefd0084,
> +       0xbf0a7b7d, 0xbfa10015,
> +       0x7e008700, 0x7e028701,
> +       0x7e048702, 0x7e068703,
>         0xc4068070, 0x008ce800,
> -       0x00000000, 0x807d817d,
> -       0x8070ff70, 0x00000080,
> -       0xbf0a7b7d, 0xbfa2fff7,
> -       0xbfa0016e, 0xbef4007e,
> -       0x8b75ff7f, 0x0000ffff,
> -       0x8c75ff75, 0x00040000,
> -       0xbef60080, 0xbef700ff,
> -       0x10807fac, 0xbef1007f,
> -       0xb8f20742, 0x84729972,
> -       0x8b6eff7f, 0x04000000,
> -       0xbfa1003b, 0xbefe00c1,
> -       0x857d9972, 0x8b7d817d,
> -       0xbf06817d, 0xbfa20002,
> -       0xbeff0080, 0xbfa00001,
> -       0xbeff00c1, 0xb8ef4306,
> -       0x8b6fc16f, 0xbfa10030,
> -       0x846f896f, 0xbef6006f,
> +       0x00000000, 0xc4068070,
> +       0x008ce801, 0x00010000,
> +       0xc4068070, 0x008ce802,
> +       0x00020000, 0xc4068070,
> +       0x008ce803, 0x00030000,
> +       0x807d847d, 0x8070ff70,
> +       0x00000400, 0xbf0a7b7d,
> +       0xbfa2ffeb, 0xb8fb1e06,
> +       0x8b7bc17b, 0xbfa1000d,
> +       0x847b837b, 0x807b7d7b,
> +       0xbefe00c1, 0xbeff0080,
> +       0x7e008700, 0xc4068070,
> +       0x008ce800, 0x00000000,
> +       0x807d817d, 0x8070ff70,
> +       0x00000080, 0xbf0a7b7d,
> +       0xbfa2fff7, 0xbfa0016e,
> +       0xbef4007e, 0x8b75ff7f,
> +       0x0000ffff, 0x8c75ff75,
> +       0x00040000, 0xbef60080,
> +       0xbef700ff, 0x10807fac,
> +       0xbef1007f, 0xb8f20742,
> +       0x84729972, 0x8b6eff7f,
> +       0x04000000, 0xbfa1003b,
> +       0xbefe00c1, 0x857d9972,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbfa20002, 0xbeff0080,
> +       0xbfa00001, 0xbeff00c1,
> +       0xb8ef4306, 0x8b6fc16f,
> +       0xbfa10030, 0x846f896f,
> +       0xbef6006f, 0xb8f83b05,
> +       0x80788178, 0xbf0d9972,
> +       0xbfa20002, 0x84788978,
> +       0xbfa00001, 0x84788a78,
> +       0xb8ee1e06, 0x846e8a6e,
> +       0x80786e78, 0x8078ff78,
> +       0x00000200, 0x8078ff78,
> +       0x00000080, 0xbef600ff,
> +       0x01000000, 0x857d9972,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbefd0080, 0xbfa2000d,
> +       0xc4050078, 0x0080e800,
> +       0x00000000, 0xbf8a0000,
> +       0xdac00000, 0x00000000,
> +       0x807dff7d, 0x00000080,
> +       0x8078ff78, 0x00000080,
> +       0xbf0a6f7d, 0xbfa2fff4,
> +       0xbfa0000c, 0xc4050078,
> +       0x0080e800, 0x00000000,
> +       0xbf8a0000, 0xdac00000,
> +       0x00000000, 0x807dff7d,
> +       0x00000100, 0x8078ff78,
> +       0x00000100, 0xbf0a6f7d,
> +       0xbfa2fff4, 0xbef80080,
> +       0xbefe00c1, 0x857d9972,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbfa20002, 0xbeff0080,
> +       0xbfa00001, 0xbeff00c1,
> +       0xb8ef3b05, 0x806f816f,
> +       0x846f826f, 0x857d9972,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbfa2002c, 0xbef600ff,
> +       0x01000000, 0xbeee0078,
> +       0x8078ff78, 0x00000200,
> +       0xbefd0084, 0xbf0a6f7d,
> +       0xbfa10061, 0xc4050078,
> +       0x008ce800, 0x00000000,
> +       0xc4050078, 0x008ce801,
> +       0x00008000, 0xc4050078,
> +       0x008ce802, 0x00010000,
> +       0xc4050078, 0x008ce803,
> +       0x00018000, 0xbf8a0000,
> +       0x7e008500, 0x7e028501,
> +       0x7e048502, 0x7e068503,
> +       0x807d847d, 0x8078ff78,
> +       0x00000200, 0xbf0a6f7d,
> +       0xbfa2ffea, 0xc405006e,
> +       0x008ce800, 0x00000000,
> +       0xc405006e, 0x008ce801,
> +       0x00008000, 0xc405006e,
> +       0x008ce802, 0x00010000,
> +       0xc405006e, 0x008ce803,
> +       0x00018000, 0xbf8a0000,
> +       0xbfa0003d, 0xbef600ff,
> +       0x01000000, 0xbeee0078,
> +       0x8078ff78, 0x00000400,
> +       0xbefd0084, 0xbf0a6f7d,
> +       0xbfa10016, 0xc4050078,
> +       0x008ce800, 0x00000000,
> +       0xc4050078, 0x008ce801,
> +       0x00010000, 0xc4050078,
> +       0x008ce802, 0x00020000,
> +       0xc4050078, 0x008ce803,
> +       0x00030000, 0xbf8a0000,
> +       0x7e008500, 0x7e028501,
> +       0x7e048502, 0x7e068503,
> +       0x807d847d, 0x8078ff78,
> +       0x00000400, 0xbf0a6f7d,
> +       0xbfa2ffea, 0xb8ef1e06,
> +       0x8b6fc16f, 0xbfa1000f,
> +       0x846f836f, 0x806f7d6f,
> +       0xbefe00c1, 0xbeff0080,
> +       0xc4050078, 0x008ce800,
> +       0x00000000, 0xbf8a0000,
> +       0x7e008500, 0x807d817d,
> +       0x8078ff78, 0x00000080,
> +       0xbf0a6f7d, 0xbfa2fff6,
> +       0xbeff00c1, 0xc405006e,
> +       0x008ce800, 0x00000000,
> +       0xc405006e, 0x008ce801,
> +       0x00010000, 0xc405006e,
> +       0x008ce802, 0x00020000,
> +       0xc405006e, 0x008ce803,
> +       0x00030000, 0xbf8a0000,
>         0xb8f83b05, 0x80788178,
>         0xbf0d9972, 0xbfa20002,
>         0x84788978, 0xbfa00001,
>         0x84788a78, 0xb8ee1e06,
>         0x846e8a6e, 0x80786e78,
>         0x8078ff78, 0x00000200,
> -       0x8078ff78, 0x00000080,
> -       0xbef600ff, 0x01000000,
> -       0x857d9972, 0x8b7d817d,
> -       0xbf06817d, 0xbefd0080,
> -       0xbfa2000d, 0xc4050078,
> -       0x0080e800, 0x00000000,
> -       0xbf8a0000, 0xdac00000,
> -       0x00000000, 0x807dff7d,
> -       0x00000080, 0x8078ff78,
> -       0x00000080, 0xbf0a6f7d,
> -       0xbfa2fff4, 0xbfa0000c,
> -       0xc4050078, 0x0080e800,
> -       0x00000000, 0xbf8a0000,
> -       0xdac00000, 0x00000000,
> -       0x807dff7d, 0x00000100,
> -       0x8078ff78, 0x00000100,
> -       0xbf0a6f7d, 0xbfa2fff4,
> -       0xbef80080, 0xbefe00c1,
> -       0x857d9972, 0x8b7d817d,
> -       0xbf06817d, 0xbfa20002,
> -       0xbeff0080, 0xbfa00001,
> -       0xbeff00c1, 0xb8ef3b05,
> -       0x806f816f, 0x846f826f,
> -       0x857d9972, 0x8b7d817d,
> -       0xbf06817d, 0xbfa2002c,
> +       0x80f8ff78, 0x00000050,
>         0xbef600ff, 0x01000000,
> -       0xbeee0078, 0x8078ff78,
> -       0x00000200, 0xbefd0084,
> -       0xbf0a6f7d, 0xbfa10061,
> -       0xc4050078, 0x008ce800,
> -       0x00000000, 0xc4050078,
> -       0x008ce801, 0x00008000,
> -       0xc4050078, 0x008ce802,
> -       0x00010000, 0xc4050078,
> -       0x008ce803, 0x00018000,
> -       0xbf8a0000, 0x7e008500,
> -       0x7e028501, 0x7e048502,
> -       0x7e068503, 0x807d847d,
> +       0xbefd00ff, 0x0000006c,
> +       0x80f89078, 0xf462403a,
> +       0xf0000000, 0xbf8a0000,
> +       0x80fd847d, 0xbf800000,
> +       0xbe804300, 0xbe824302,
> +       0x80f8a078, 0xf462603a,
> +       0xf0000000, 0xbf8a0000,
> +       0x80fd887d, 0xbf800000,
> +       0xbe804300, 0xbe824302,
> +       0xbe844304, 0xbe864306,
> +       0x80f8c078, 0xf462803a,
> +       0xf0000000, 0xbf8a0000,
> +       0x80fd907d, 0xbf800000,
> +       0xbe804300, 0xbe824302,
> +       0xbe844304, 0xbe864306,
> +       0xbe884308, 0xbe8a430a,
> +       0xbe8c430c, 0xbe8e430e,
> +       0xbf06807d, 0xbfa1fff0,
> +       0xb980f801, 0x00000000,
> +       0xb8f83b05, 0x80788178,
> +       0xbf0d9972, 0xbfa20002,
> +       0x84788978, 0xbfa00001,
> +       0x84788a78, 0xb8ee1e06,
> +       0x846e8a6e, 0x80786e78,
>         0x8078ff78, 0x00000200,
> -       0xbf0a6f7d, 0xbfa2ffea,
> -       0xc405006e, 0x008ce800,
> -       0x00000000, 0xc405006e,
> -       0x008ce801, 0x00008000,
> -       0xc405006e, 0x008ce802,
> -       0x00010000, 0xc405006e,
> -       0x008ce803, 0x00018000,
> -       0xbf8a0000, 0xbfa0003d,
>         0xbef600ff, 0x01000000,
> -       0xbeee0078, 0x8078ff78,
> -       0x00000400, 0xbefd0084,
> -       0xbf0a6f7d, 0xbfa10016,
> -       0xc4050078, 0x008ce800,
> -       0x00000000, 0xc4050078,
> -       0x008ce801, 0x00010000,
> -       0xc4050078, 0x008ce802,
> -       0x00020000, 0xc4050078,
> -       0x008ce803, 0x00030000,
> -       0xbf8a0000, 0x7e008500,
> -       0x7e028501, 0x7e048502,
> -       0x7e068503, 0x807d847d,
> -       0x8078ff78, 0x00000400,
> -       0xbf0a6f7d, 0xbfa2ffea,
> -       0xb8ef1e06, 0x8b6fc16f,
> -       0xbfa1000f, 0x846f836f,
> -       0x806f7d6f, 0xbefe00c1,
> -       0xbeff0080, 0xc4050078,
> -       0x008ce800, 0x00000000,
> -       0xbf8a0000, 0x7e008500,
> -       0x807d817d, 0x8078ff78,
> -       0x00000080, 0xbf0a6f7d,
> -       0xbfa2fff6, 0xbeff00c1,
> -       0xc405006e, 0x008ce800,
> -       0x00000000, 0xc405006e,
> -       0x008ce801, 0x00010000,
> -       0xc405006e, 0x008ce802,
> -       0x00020000, 0xc405006e,
> -       0x008ce803, 0x00030000,
> -       0xbf8a0000, 0xb8f83b05,
> -       0x80788178, 0xbf0d9972,
> -       0xbfa20002, 0x84788978,
> -       0xbfa00001, 0x84788a78,
> -       0xb8ee1e06, 0x846e8a6e,
> -       0x80786e78, 0x8078ff78,
> -       0x00000200, 0x80f8ff78,
> -       0x00000050, 0xbef600ff,
> -       0x01000000, 0xbefd00ff,
> -       0x0000006c, 0x80f89078,
> -       0xf462403a, 0xf0000000,
> -       0xbf8a0000, 0x80fd847d,
> -       0xbf800000, 0xbe804300,
> -       0xbe824302, 0x80f8a078,
> -       0xf462603a, 0xf0000000,
> -       0xbf8a0000, 0x80fd887d,
> -       0xbf800000, 0xbe804300,
> -       0xbe824302, 0xbe844304,
> -       0xbe864306, 0x80f8c078,
> -       0xf462803a, 0xf0000000,
> -       0xbf8a0000, 0x80fd907d,
> -       0xbf800000, 0xbe804300,
> -       0xbe824302, 0xbe844304,
> -       0xbe864306, 0xbe884308,
> -       0xbe8a430a, 0xbe8c430c,
> -       0xbe8e430e, 0xbf06807d,
> -       0xbfa1fff0, 0xb980f801,
> -       0x00000000, 0xb8f83b05,
> -       0x80788178, 0xbf0d9972,
> -       0xbfa20002, 0x84788978,
> -       0xbfa00001, 0x84788a78,
> -       0xb8ee1e06, 0x846e8a6e,
> -       0x80786e78, 0x8078ff78,
> -       0x00000200, 0xbef600ff,
> -       0x01000000, 0xbeff0071,
> -       0xf4621bfa, 0xf0000000,
> -       0x80788478, 0xf4621b3a,
> +       0xbeff0071, 0xf4621bfa,
>         0xf0000000, 0x80788478,
> -       0xf4621b7a, 0xf0000000,
> -       0x80788478, 0xf4621c3a,
> +       0xf4621b3a, 0xf0000000,
> +       0x80788478, 0xf4621b7a,
>         0xf0000000, 0x80788478,
> -       0xf4621c7a, 0xf0000000,
> -       0x80788478, 0xf4621eba,
> +       0xf4621c3a, 0xf0000000,
> +       0x80788478, 0xf4621c7a,
>         0xf0000000, 0x80788478,
> -       0xf4621efa, 0xf0000000,
> -       0x80788478, 0xf4621e7a,
> +       0xf4621eba, 0xf0000000,
> +       0x80788478, 0xf4621efa,
>         0xf0000000, 0x80788478,
> -       0xf4621cfa, 0xf0000000,
> -       0x80788478, 0xf4621bba,
> +       0xf4621e7a, 0xf0000000,
> +       0x80788478, 0xf4621cfa,
>         0xf0000000, 0x80788478,
> -       0xbf8a0000, 0xb96ef814,
>         0xf4621bba, 0xf0000000,
>         0x80788478, 0xbf8a0000,
> -       0xb96ef815, 0xf4621bba,
> +       0xb96ef814, 0xf4621bba,
>         0xf0000000, 0x80788478,
> -       0xbf8a0000, 0xb96ef812,
> +       0xbf8a0000, 0xb96ef815,
>         0xf4621bba, 0xf0000000,
>         0x80788478, 0xbf8a0000,
> -       0xb96ef813, 0x8b6eff7f,
> -       0x04000000, 0xbfa1000d,
> -       0x80788478, 0xf4621bba,
> +       0xb96ef812, 0xf4621bba,
>         0xf0000000, 0x80788478,
> -       0xbf8a0000, 0xbf0d806e,
> -       0xbfa10006, 0x856e906e,
> -       0x8b6e6e6e, 0xbfa10003,
> -       0xbe804ec1, 0x816ec16e,
> -       0xbfa0fffb, 0xbefd006f,
> -       0xbefe0070, 0xbeff0071,
> -       0xb97b2011, 0x857b867b,
> -       0xb97b0191, 0x857b827b,
> -       0xb97bba11, 0xb973f801,
> -       0xb8ee3b05, 0x806e816e,
> -       0xbf0d9972, 0xbfa20002,
> -       0x846e896e, 0xbfa00001,
> -       0x846e8a6e, 0xb8ef1e06,
> -       0x846f8a6f, 0x806e6f6e,
> -       0x806eff6e, 0x00000200,
> -       0x806e746e, 0x826f8075,
> -       0x8b6fff6f, 0x0000ffff,
> -       0xf4605c37, 0xf8000050,
> -       0xf4605d37, 0xf8000060,
> -       0xf4601e77, 0xf8000074,
> -       0xbf8a0000, 0x8b6dff6d,
> -       0x0000ffff, 0x8bfe7e7e,
> -       0x8bea6a6a, 0xb97af804,
> +       0xbf8a0000, 0xb96ef813,
> +       0x8b6eff7f, 0x04000000,
> +       0xbfa1000d, 0x80788478,
> +       0xf4621bba, 0xf0000000,
> +       0x80788478, 0xbf8a0000,
> +       0xbf0d806e, 0xbfa10006,
> +       0x856e906e, 0x8b6e6e6e,
> +       0xbfa10003, 0xbe804ec1,
> +       0x816ec16e, 0xbfa0fffb,
> +       0xbefd006f, 0xbefe0070,
> +       0xbeff0071, 0xb97b2011,
> +       0x857b867b, 0xb97b0191,
> +       0x857b827b, 0xb97bba11,
> +       0xb973f801, 0xb8ee3b05,
> +       0x806e816e, 0xbf0d9972,
> +       0xbfa20002, 0x846e896e,
> +       0xbfa00001, 0x846e8a6e,
> +       0xb8ef1e06, 0x846f8a6f,
> +       0x806e6f6e, 0x806eff6e,
> +       0x00000200, 0x806e746e,
> +       0x826f8075, 0x8b6fff6f,
> +       0x0000ffff, 0xf4605c37,
> +       0xf8000050, 0xf4605d37,
> +       0xf8000060, 0xf4601e77,
> +       0xf8000074, 0xbf8a0000,
> +       0x8b6dff6d, 0x0000ffff,
> +       0x8bfe7e7e, 0x8bea6a6a,
> +       0xb97af804, 0xbe804ec2,
> +       0xbf94fffe, 0xbe804a6c,
>         0xbe804ec2, 0xbf94fffe,
> -       0xbe804a6c, 0xbe804ec2,
> -       0xbf94fffe, 0xbfb10000,
> +       0xbfb10000, 0xbf9f0000,
>         0xbf9f0000, 0xbf9f0000,
>         0xbf9f0000, 0xbf9f0000,
> -       0xbf9f0000, 0x00000000,
>  };
>
>  static const uint32_t cwsr_trap_gfx9_5_0_hex[] =3D {
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/dri=
vers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index 7b9d36e5fa43..5a1a1b1f897f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -30,6 +30,7 @@
>  #define CHIP_GFX12 37
>
>  #define SINGLE_STEP_MISSED_WORKAROUND 1        //workaround for lost TRA=
P_AFTER_INST exception when SAVECTX raised
> +#define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY =3D=3D CHIP_GFX12)
>
>  var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK   =3D 0x4
>  var SQ_WAVE_STATE_PRIV_SCC_SHIFT               =3D 9
> @@ -351,6 +352,7 @@ L_HAVE_VGPRS:
>         v_writelane_b32 v0, ttmp13, 0xD
>         v_writelane_b32 v0, exec_lo, 0xE
>         v_writelane_b32 v0, exec_hi, 0xF
> +       valu_sgpr_hazard()
>
>         s_mov_b32       exec_lo, 0x3FFF
>         s_mov_b32       exec_hi, 0x0
> @@ -417,7 +419,6 @@ L_SAVE_HWREG:
>         v_mov_b32       v0, 0x0                                          =
       //Offset[31:0] from buffer resource
>         v_mov_b32       v1, 0x0                                          =
       //Offset[63:32] from buffer resource
>         v_mov_b32       v2, 0x0                                          =
       //Set of SGPRs for TCP store
> -       s_mov_b32       m0, 0x0                                          =
       //Next lane of v2 to write to
>
>         // Ensure no further changes to barrier or LDS state.
>         // STATE_PRIV.BARRIER_COMPLETE may change up to this point.
> @@ -430,40 +431,41 @@ L_SAVE_HWREG:
>         s_andn2_b32     s_save_state_priv, s_save_state_priv, SQ_WAVE_STA=
TE_PRIV_BARRIER_COMPLETE_MASK
>         s_or_b32        s_save_state_priv, s_save_state_priv, s_save_tmp
>
> -       write_hwreg_to_v2(s_save_m0)
> -       write_hwreg_to_v2(s_save_pc_lo)
>         s_andn2_b32     s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE=
_MASK
> -       write_hwreg_to_v2(s_save_tmp)
> -       write_hwreg_to_v2(s_save_exec_lo)
> -       write_hwreg_to_v2(s_save_exec_hi)
> -       write_hwreg_to_v2(s_save_state_priv)
> +       v_writelane_b32 v2, s_save_m0, 0x0
> +       v_writelane_b32 v2, s_save_pc_lo, 0x1
> +       v_writelane_b32 v2, s_save_tmp, 0x2
> +       v_writelane_b32 v2, s_save_exec_lo, 0x3
> +       v_writelane_b32 v2, s_save_exec_hi, 0x4
> +       v_writelane_b32 v2, s_save_state_priv, 0x5
> +       v_writelane_b32 v2, s_save_xnack_mask, 0x7
> +       valu_sgpr_hazard()
>
>         s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> -       write_hwreg_to_v2(s_save_tmp)
> +       v_writelane_b32 v2, s_save_tmp, 0x6
>
> -       write_hwreg_to_v2(s_save_xnack_mask)
> +       s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_MODE)
> +       v_writelane_b32 v2, s_save_tmp, 0x8
>
> -       s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_MODE)
> -       write_hwreg_to_v2(s_save_m0)
> +       s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
> +       v_writelane_b32 v2, s_save_tmp, 0x9
>
> -       s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
> -       write_hwreg_to_v2(s_save_m0)
> +       s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
> +       v_writelane_b32 v2, s_save_tmp, 0xA
>
> -       s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
> -       write_hwreg_to_v2(s_save_m0)
> +       s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> +       v_writelane_b32 v2, s_save_tmp, 0xB
>
> -       s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> -       write_hwreg_to_v2(s_save_m0)
> -
> -       s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_TRAP_CTRL)
> -       write_hwreg_to_v2(s_save_m0)
> +       s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_TRAP_CTRL)
> +       v_writelane_b32 v2, s_save_tmp, 0xC
>
>         s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> -       write_hwreg_to_v2(s_save_tmp)
> +       v_writelane_b32 v2, s_save_tmp, 0xD
>
>         s_get_barrier_state s_save_tmp, -1
>         s_wait_kmcnt (0)
> -       write_hwreg_to_v2(s_save_tmp)
> +       v_writelane_b32 v2, s_save_tmp, 0xE
> +       valu_sgpr_hazard()
>
>         // Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this=
.
>         s_mov_b32       exec_lo, 0xFFFF
> @@ -497,10 +499,12 @@ L_SAVE_SGPR_LOOP:
>         s_movrels_b64   s12, s12                                         =
       //s12 =3D s[12+m0], s13 =3D s[13+m0]
>         s_movrels_b64   s14, s14                                         =
       //s14 =3D s[14+m0], s15 =3D s[15+m0]
>
> -       write_16sgpr_to_v2(s0)
> -
> -       s_cmp_eq_u32    ttmp13, 0x20                                     =
       //have 32 VGPR lanes filled?
> -       s_cbranch_scc0  L_SAVE_SGPR_SKIP_TCP_STORE
> +       s_cmp_eq_u32    ttmp13, 0x0
> +       s_cbranch_scc0  L_WRITE_V2_SECOND_HALF
> +       write_16sgpr_to_v2(s0, 0x0)
> +       s_branch        L_SAVE_SGPR_SKIP_TCP_STORE
> +L_WRITE_V2_SECOND_HALF:
> +       write_16sgpr_to_v2(s0, 0x10)
>
>         buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offs=
et scope:SCOPE_SYS
>         s_add_u32       s_save_mem_offset, s_save_mem_offset, 0x80
> @@ -1056,27 +1060,21 @@ L_END_PGM:
>         s_endpgm_saved
>  end
>
> -function write_hwreg_to_v2(s)
> -       // Copy into VGPR for later TCP store.
> -       v_writelane_b32 v2, s, m0
> -       s_add_u32       m0, m0, 0x1
> -end
> -
> -
> -function write_16sgpr_to_v2(s)
> +function write_16sgpr_to_v2(s, lane_offset)
>         // Copy into VGPR for later TCP store.
>         for var sgpr_idx =3D 0; sgpr_idx < 16; sgpr_idx ++
> -               v_writelane_b32 v2, s[sgpr_idx], ttmp13
> -               s_add_u32       ttmp13, ttmp13, 0x1
> +               v_writelane_b32 v2, s[sgpr_idx], sgpr_idx + lane_offset
>         end
> +       valu_sgpr_hazard()
> +       s_add_u32       ttmp13, ttmp13, 0x10
>  end
>
>  function write_12sgpr_to_v2(s)
>         // Copy into VGPR for later TCP store.
>         for var sgpr_idx =3D 0; sgpr_idx < 12; sgpr_idx ++
> -               v_writelane_b32 v2, s[sgpr_idx], ttmp13
> -               s_add_u32       ttmp13, ttmp13, 0x1
> +               v_writelane_b32 v2, s[sgpr_idx], sgpr_idx
>         end
> +       valu_sgpr_hazard()
>  end
>
>  function read_hwreg_from_mem(s, s_rsrc, s_mem_offset)
> @@ -1128,3 +1126,11 @@ function get_wave_size2(s_reg)
>         s_getreg_b32    s_reg, hwreg(HW_REG_WAVE_STATUS,SQ_WAVE_STATUS_WA=
VE64_SHIFT,SQ_WAVE_STATUS_WAVE64_SIZE)
>         s_lshl_b32      s_reg, s_reg, S_WAVE_SIZE
>  end
> +
> +function valu_sgpr_hazard
> +#if HAVE_VALU_SGPR_HAZARD
> +       for var rep =3D 0; rep < 8; rep ++
> +               ds_nop
> +       end
> +#endif
> +end
> --
> 2.34.1
>
