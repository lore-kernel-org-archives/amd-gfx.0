Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E29D711CF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 17:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E7C10E0A3;
	Wed, 20 Nov 2024 17:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nYZSrXtw";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A5110E0A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 17:34:20 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7245f6ee486so5892b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732124060; x=1732728860; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWU5jMM+7fB98fsiQDtu1TZqbuff1Keb3PpFrROgv2M=;
 b=nYZSrXtwmCiYir+Llk2NupQ8WtN6pNZd5kWGjg7PhurunfjyhBRDuSD3pOe1+G+bhn
 n+j4gqrGjmLVPdvxHOS9BlW0Jkpa2sunom7AhSzxGpYbSdGF8eWUhWWo1yi/VMfdMWme
 iKvlL1pI3/ohBkGAqGGJ1vaYn9p/SFW/5wGCnb5VyxV5T2+VhktfeSXOnhRPA/I90dGk
 Es+sS6zv9ZfjWiJ7p6+iQHhh/1PtkvzLRILBrNevdRlSYHojdEDYBcjIpcUwFAww1Hn7
 BQ2q+jLqQnAxRVaIPWSHjQ4iSRRkMfTWz5VmLezZv8a2PrgfzP6NzPOMc9otKp4/WCU4
 UrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732124060; x=1732728860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWU5jMM+7fB98fsiQDtu1TZqbuff1Keb3PpFrROgv2M=;
 b=Q82fsUUESBrg/XaMirw2mrCKMchwB57nYeGlPX+gpK42MAhWXrYb3pLcqy+QFc2FvG
 19oZwTmF3ZjX84Ue1azbR3JmsdsLqd10Hy95eGgSNlXvnJ/HSrYHG9xHserET4xanHNc
 R0LUcAcI0NnCOxUHYWhVAFfLGTQTRR2cL0c8eogFRiHFmdhzZdjhIyUKYrh/kxVcwrH1
 A5dn0REYZLo0c2wTmiWhMzARqG9l0UvBJwLPm07DdIa4am+CZuFhPEqkWFj4LsQqVYkx
 r1QwFfWWYYEDADeRZCv8Z0guzD9zIebZp7i0wv62xxOt+9fnDUHN5J7m5X+I6oUmT2Wq
 PcsA==
X-Gm-Message-State: AOJu0Yy0GRqNhYUr3lrFUmCDV1nOSkapXwEdgOdhjXwwJhFc5c2dUkTa
 gQSMtKnZ8gJyMtN66fErMEA8SfgWOGKEqKp5wZlY8Slkh/K/36OtG2erJmzS0swApbd+z5zu65Y
 dK2Z3NRXqG64cteXBI2ksk+IQiTw=
X-Gm-Gg: ASbGncs5rVOn+dU+piTsvgD+8wE8b+LEw8jay0vQEmm6tDsL50HoVP0CJOm1KNPJgac
 SqJZNVusRu5m6w4LuVdCgn0XU8UVQR40=
X-Google-Smtp-Source: AGHT+IH6q2w/ywEsL0b/k9/Bw0WbsbTkijqkTPGyh6O+neCtEYa75IUwwgUm+g7VJG0A7ZGALXnEL0LoTIEMEP2OOII=
X-Received: by 2002:a05:6a00:b46:b0:71e:6ccb:bb9c with SMTP id
 d2e1a72fcca58-724bed8b246mr2015951b3a.5.1732124060276; Wed, 20 Nov 2024
 09:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20241113214453.17081-1-alexander.deucher@amd.com>
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Nov 2024 12:34:07 -0500
Message-ID: <CADnq5_MVUX4MoCyHG85jB8M3+k=FgodaZb37iDF1aJBH054n4A@mail.gmail.com>
Subject: Re: [PATCH 00/15] VCN instance rework
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series!

On Wed, Nov 13, 2024 at 4:54=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> The original design of amdgpu called for separate IP blocks for each
> instance of an IP on an SoC.  This never really came to be however for
> a variety of reasons.  Boyuan's recent rework was able to get back to
> that model, but in doing so it uncovered a lot of corner cases and
> regressions.  In fxing them up it became clear that at this point it
> was not worth.  This patch set partially reverts that work and reworks
> it to align with the current model of having each IP module handle
> all instances.  While I was working on this, I noticed a few bugs as
> well and they are fixed up.
>
> Patch 1:
> Partially revert the previous VCN instance rework.  This retains the
> smu interface changes to handle per IP powergating.  It only reverts
> the spliting of VCN into per IP instances.  This also reverts some of
> Jesse's vcn sysfs changes as it made the revert easier and there were
> some cut and paste typos in the patches.
>
> Patches 2-3:
> Repply Jesse's sysfs changes with typos fixed.
>
> Patches 4:
> JPEG bug fix I noticed while working on the code.
>
> Patches 5-10:
> Rework the instance handling within the VCN IP modules.
>
> Patch 11:
> Switch the VCN idle work handler to be per instance rather than per IP.
>
> Patch 12:
> Store clockgating status per instance rather than per IP
>
> Patch 13-15:
> Add new IP level per instance powergating callbacks and enable them
> for VCN.
>
> Alex Deucher (13):
>   drm/amdgpu: partially revert VCN IP block instancing support
>   drm/amdgpu/jpeg: cancel the jpeg worker
>   drm/amdgpu/vcn2.5: split code along instances
>   drm/amdgpu/vcn3.0: split code along instances
>   drm/amdgpu/vcn4.0: split code along instances
>   drm/amdgpu/vcn4.0.3: split code along instances
>   drm/amdgpu/vcn4.0.5: split code along instances
>   drm/amdgpu/vcn5.0.0: split code along instances
>   drm/amdgpu/vcn: switch work handler to be per instance
>   drm/amdgpu/vcn: make powergating status per instance
>   drm/amdgpu: add new IP callback for per instance powergating
>   drm/amdgpu/vcn: add new instanced powergating IP callback
>   drm/amdgpu/vcn: update work handler for per instance powergating
>
> Jesse Zhang (1):
>   drm/amdgpu: fix warning when removing sysfs
>
> Jesse.zhang@amd.com (1):
>   drm/amdgpu: Add sysfs interface for vcn reset mask
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   67 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   23 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  334 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   28 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |    8 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |    2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |    2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  146 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  129 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1043 +++++++++--------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  725 ++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  625 +++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  457 ++++----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  585 ++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  534 +++++----
>  drivers/gpu/drm/amd/include/amd_shared.h      |    3 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |    6 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |    8 +-
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
>  .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
>  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   14 +-
>  41 files changed, 2523 insertions(+), 2313 deletions(-)
>
> --
> 2.47.0
>
