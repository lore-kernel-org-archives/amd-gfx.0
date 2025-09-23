Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08713CAC5AC
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 21:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A317110E0FD;
	Tue, 23 Sep 2025 21:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BOL7cPCc";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641B910E0FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 21:18:23 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-267dbd4e189so14650955ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758662303; x=1759267103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loH/mer8uVzX4yEJRX08aYNFOzWZWI26oiZNxoeK7T0=;
 b=BOL7cPCcKphcr7yyLKtgHNKOofXrvb9N4yRzVWmJ9Ls4Hb6MPrfpt0zgZSaMjiYBvY
 FW+i3CPlWca633RXmiQtDQloQNaw93XGD1XpOqH0gmEX39BkT2JTlErZlf6OlwK2KyIV
 SunS+5k32p3Rd9ACJT2hv0eCEp74pO0XS3nvPIvWWHvwGDEpKmt//t2a+1W3gP906Pr2
 IrQs/00yMJNfKVHSIjfMVlQwfQ4jkvr3SMSGdXMMhOVor4CpraZNELVgqSFRf6jaS92w
 4Qkb+xxHTtpFMFyTD299isR3C2yFnkpoZtoe0KPM5+cKoyEVFyEEZK6RkK43JJaOeBRX
 9d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758662303; x=1759267103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loH/mer8uVzX4yEJRX08aYNFOzWZWI26oiZNxoeK7T0=;
 b=bgXVfsAg/5C5kRUQghYi7ZvsQUwg53bTLOalt+sqENLit8FX4mX1Dig9KAw2HGfbRf
 sID55duQevZvVBGbPEkflvobmylq8Y2vKZl8C9E/EYT1kHB9LWeog4qdj+UH2lH+EDPK
 a9CaWQaaz7j+nvtD5TpzXMg6Fw3GwPcVdD9Np4R/S9D57tWrVJT5GNblN6P95d9Q31hb
 128R/H4jUhagJI4YGYowldvSy5ZcTt6R7acdu51QGt4OUqUkUBywfdYquN0U7/m2Ct5+
 iGrE9zASt/2wk8+qE7RqSs0uVVJiUO7euB8KAy+5sJLiiPFZQZyao3MaOdAuiH85v4VA
 6ukQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXelOOc90Gv1SDJyK8Jmx+2pu09d4CRzMn9RLRMerE5bV32ixCx7vi8Xh0EawtOdWJAKXCp6Cei@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd9PbWNbJp/933FpDrTOQANg3MjCypaMxrMH5F8QZorG7MlCyQ
 VgpKn3XbVX5UY7no13v5SXcQZvhB6LZ8uLZJ0J5/0z0Ij0fkqpA4fZ13juJ+WVseSCThrCcG+I8
 NdNorYnEASyLwkyKBR5O+X66SejdEjVY=
X-Gm-Gg: ASbGnct9SOMklHSYamDGSISCTUT/AG8THg7BZHtsDefmQwhofYyrf736ySvJDCD6wOr
 GnUVHomi5YCfFtZUhKvsloXlSb/u9FdU7X4umQgOCQmrQCdoXEsf9CHMSNdqh5JknOlxXKcg2i5
 fm9ERe9JCsYpub4iXT33pFaR2XtVk06DNwAOpMpZBVNz7zabwb4Ck2I1y7XNNlrGmrFbLW3x3JG
 mQvjfg=
X-Google-Smtp-Source: AGHT+IFnwwt/IOCvJsBB6AFgTLceNm7jgMwdkvU8lOGfthr8b/FHASvVJ52WqjVSCsqQpqVc9nC/JOCTScU1YGORn9M=
X-Received: by 2002:a17:902:f693:b0:26a:3c75:5241 with SMTP id
 d9443c01a7336-27cc7f8fa39mr25912755ad.9.1758662302758; Tue, 23 Sep 2025
 14:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250923211216.306525-1-siqueira@igalia.com>
In-Reply-To: <20250923211216.306525-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Sep 2025 17:18:11 -0400
X-Gm-Features: AS18NWAIa1C2HlAoKeIH7Tubx4lYQ2FHjgcsWY5x8ZF9pJqRaukf8Vlb9XVHyVE
Message-ID: <CADnq5_Nk3V=7d4m7nCExc8yLhu1Zz7T08wXpM0qJhJSVAVnuaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org, 
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

On Tue, Sep 23, 2025 at 5:12=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> set of errors happens and the system gets unstable:
>
> [..]
>  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
>  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test=
 failed on gfx_0.0.0 (-110).
>  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> [..]
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comman=
d: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comman=
d: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> [..]
>
> When the driver initializes the GPU, the PSP validates all the firmware
> loaded, and after that, it is not possible to load any other firmware
> unless the device is reset. What is happening in the load/unload
> situation is that PSP halts the GC engine because it suspects that
> something is amiss. To address this issue, this commit ensures that the
> GPU is reset (mode 2 reset) in the load/unload sequence.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 50e77d9b30af..1964aa37c499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -543,6 +543,13 @@ static bool nv_need_reset_on_init(struct amdgpu_devi=
ce *adev)
>  {
>         u32 sol_reg;
>
> +       /* GFX in the SteamDeck hangs when amdgpu module is reloaded, sin=
ce the
> +        * firmware is already loaded. To avoid this issue, ensure that t=
he
> +        * device is reset to put the PSP in a good state.
> +        */
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, =
1))
> +               return true;

This will force a reset every time the driver loads.  That will add a
lot of latency to the driver load sequence.  I think it would be
better to reset on unload or add a check to see if CP firmware is
already loaded here so we only reset if the driver has been previously
loaded.

Alex

> +
>         if (adev->flags & AMD_IS_APU)
>                 return false;
>
> --
> 2.51.0
>
