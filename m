Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EAC25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 20:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F93A10F2D3;
	Thu,  9 May 2024 20:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ais1sxB/";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF98910F2D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 20:09:55 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2a78c2e253aso1046019a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715285395; x=1715890195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYA3RwYAxraZtJk8a6jY7nmKH3TXoypzuaXCjLs2P7U=;
 b=Ais1sxB/69//ofKF6vMDMCn1P8JqGAzwf1gKQDYBar8vz9gAQvziRIexsXlqQX/Fwo
 I6DsvxBUoUBMe06f5grIgeNNG8ry7Huq0CrJu/jqvJF8nzug/gQ2ZYwDREl5JR9gjFOo
 TtQ+JKnjYwyQl19sR/KT0JiGPHEvCFUmbVfECUgzLZy4jRHc3W7BWX/WZ1azYSZ8AbY6
 40cMkoO4p1DLS/Iuwx3T+PNCrcM74MZ9itj60T/ILkL0NKDvGN6p3/uOqf9l+CUtPeAq
 21FQv95hvVBdnRiND16c874hdX0Ax3Xl/mbz5kJbDmhMYoFqUTIRRrJFd4ALQWp7VbT1
 UMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715285395; x=1715890195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYA3RwYAxraZtJk8a6jY7nmKH3TXoypzuaXCjLs2P7U=;
 b=Nm5O7xrkDK9irQDEzW4TRHBzw26Lron/S4iDrxtndlEGnexPwcu9T7j2hfN7EhHl35
 T9J5IiL5Uh5CSMGhXwNzZj+j+FOGws2od59NsMc8ezUxlMZEgVNeD/Mk/edpHK+eUAdK
 bJMFReQ6KyrLqwxrFj+ge4CTAnANILOVK1+dcDDLZksUvlUFFHPx24BAFke077y+FN5C
 X9C8v3Z94YRZs/b/RuoFEiLsswJfKK7oA2IrAACdw1WErBt6JWmyRMzGXSJ08kqV7fOc
 BtCnuVyoXZLCaqQ+5EkTBSsnQxPNh6yZfErZfb43OzKUXYohpE1Pg9+//SIjsW5u2JLA
 f+FA==
X-Gm-Message-State: AOJu0YzRUtNeJ60WrU5DQ7DCMIbPTPFdH4kZ4LJVP1EkRUXjMz7WbBkT
 XehnAmokW1SstzkTMjgDPW+8K7XrlKuVtbJzICPNB1xGe+mVnSEMhEqieai51K98mLijJ9cYDrc
 LT4u6zOoMjJ8QuFyYUwES27c4EfU=
X-Google-Smtp-Source: AGHT+IGj6QoSSSYfZ/aersinviWM3bXsStIJ6pqSU1EQKj6qdbRirsKegBAsFlEkf2W/Id758pwFL9ot4loOa0+1QEM=
X-Received: by 2002:a17:90a:858c:b0:2b2:b1a7:9530 with SMTP id
 98e67ed59e1d1-2b6ccef682bmr475475a91.41.1715285395257; Thu, 09 May 2024
 13:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240509184032.1463021-1-David.Wu3@amd.com>
In-Reply-To: <20240509184032.1463021-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 16:09:42 -0400
Message-ID: <CADnq5_OZAAbS2+U74Jui5pcjY+rLV93tCm71BoUg7BZNGhgz1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 9, 2024 at 2:47=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@amd=
.com> wrote:
>
> We do not directly enable/disable VCN IRQ in vcn 5.0.0.
> And we do not handle the IRQ state as well. So the calls to
> disable IRQ and set state are removed. This effectively gets
> rid of the warining of
>       "WARN_ON(!amdgpu_irq_enabled(adev, src, type))"
> in amdgpu_irq_put().
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 851975b5ce29..9b87d6a49b39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -229,8 +229,6 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
> -
> -               amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
>         }
>
>         return 0;
> @@ -1226,22 +1224,6 @@ static int vcn_v5_0_0_set_powergating_state(void *=
handle, enum amd_powergating_s
>         return ret;
>  }
>
> -/**
> - * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
> - *
> - * @adev: amdgpu_device pointer
> - * @source: interrupt sources
> - * @type: interrupt types
> - * @state: interrupt states
> - *
> - * Set VCN block interrupt state
> - */
> -static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device *adev, st=
ruct amdgpu_irq_src *source,
> -       unsigned type, enum amdgpu_interrupt_state state)
> -{
> -       return 0;
> -}
> -
>  /**
>   * vcn_v5_0_0_process_interrupt - process VCN block interrupt
>   *
> @@ -1287,7 +1269,6 @@ static int vcn_v5_0_0_process_interrupt(struct amdg=
pu_device *adev, struct amdgp
>  }
>
>  static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs =3D {
> -       .set =3D vcn_v5_0_0_set_interrupt_state,
>         .process =3D vcn_v5_0_0_process_interrupt,
>  };
>
> --
> 2.34.1
>
