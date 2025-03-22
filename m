Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F16C35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 16:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376CD10E12D;
	Sat, 22 Mar 2025 16:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X07GGy4e";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55F610E08C
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 16:16:24 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-51eb1a714bfso3210033e0c.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742660183; x=1743264983; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1ujoFZ1nhUXo1y5lJSEypRSZ6aeOm2LCckQca2iB0k=;
 b=X07GGy4eZaE8dykZoI5ZWzc8cqUnNfACPYOUwL/g6lfy+1O8aGtjohNDNhu8MAdwzq
 8t7U5Kde/IMmuQgU25ivjDmelECCnGH5ZGKoW45w7Hk+7jOxQsjV64sGa6GZSFUeBFGm
 GOcPw3Sd5UDS6vyW8u2X6Ul6N9jWdwOql30GeYQUDrxoJNxb1skBbLBMSPvslPcv4aw+
 uWUiQ0FczpE7SQpYLkRSIFcjiIQPtJczCHKb7ltNW39+JslxLGF5TKIZFj+WCK7Ppk8i
 wQ52ngS3BGM+3aNb1atcdys+4ELtYDNO7NHB6xlZf92PdVm2gZ0lGDlbjdp66bAteksH
 dZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742660183; x=1743264983;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1ujoFZ1nhUXo1y5lJSEypRSZ6aeOm2LCckQca2iB0k=;
 b=di+ZNSGhsEfJJVaz0Rmzonn3THYhRiHe1K28Jjg96d35Kt0kW+Jwkte9791YoD16DJ
 kuf1mXmLStM7M/zgz6fF6k7n5tGUQXKzL0/zorL1wGvWdzUkkUVHQzyLOhsk39wbAoMk
 I2e0rYR9xgRnhwz5LRgHIoROuDO2C0wmjW0Q6HqiORzOXSG1bBnvtg3IWVOLMRyRVY1P
 VVRR/5VzpzRjOwEk+mDNUSt2ILk2ke4NfgHgbmyMcC2wwfWgo5S4zKkXEEVC7n2bZ9w2
 skoS7jAwfaDwZLpPVLowkcm3MEcg5Pr9QvRufHu2RGueRVAysS/ZsOT7YuqJC2I6v5Pc
 Oakw==
X-Gm-Message-State: AOJu0YzTHHfsxZ9INZ7BQfsU7ChAdSiNobRV2FK83Eq7F4FziZ3qgzBL
 1tofSniYBIKr4CHPH3UvXpCPe3HDpf/LlMJOZZyaQWd+YweaXuA4ABoP5IRymEvDNAjonupo/V8
 4Hxu2JVDmZXmw9tJEHR7NjCuMNynDmA==
X-Gm-Gg: ASbGncvsUhONtJI/XQSIM23CdLvZff+45rN0H3UthICyi3z4NELoPBVavSmUdOq++Kp
 bQiFaxis71tHPBW8EZJWgwypnGPFj5RIXPLrwskJ3/aGlPGHWc3DqmULHyOTZutiAnsgAOtMyhO
 njVzAut3H8f5Pl5u488DQkEvdA
X-Google-Smtp-Source: AGHT+IFCWvLLuWdTtkgEljf1xh+d851phQ6Wkb4DDWSl7bQ5trS+/uZZe8emxXBt7/QvhkPKyu7cHB6kiSDzvko2a2E=
X-Received: by 2002:a05:6122:8d1:b0:520:5a87:66ff with SMTP id
 71dfb90a1353d-525a80d27d8mr4913175e0c.0.1742660182635; Sat, 22 Mar 2025
 09:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 22 Mar 2025 12:16:13 -0400
X-Gm-Features: AQ5f1JqAhUul2P11MI0mcw5cSZiLV3O_0wDWmRMn-JFl9Gebygqd1bEUAKGBso8
Message-ID: <CAPEhTTHfjUTHSb+0DkjjrkY8_e59NzKsDfPSBmJd+Dbcx1NOhA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Properly wire defines, shifts and masks in SI
 and cleanup
To: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000267fa10630f0b1b9"
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

--000000000000267fa10630f0b1b9
Content-Type: text/plain; charset="UTF-8"

I should have written "v2" in the title

Alexandre

On Fri., Mar. 21, 2025, 21:47 Alexandre Demers, <
alexandre.f.demers@gmail.com> wrote:

> The following series is intented to remove duplicated defines, shifts and
> masks or
> to classify them where they belong. si_enums.h has been used as a garbage
> can
> for anything and everything when moving SI code from radeon to amdgpu.
>
> Where needed, the defines found under sid.h and si_enums.h were ported to
> DCE6,
> GFX6 and GMC6 defines, shifts and masks. There location was based on CIK
> and
> later.
>
> However, most of them were already available, but not used where they
> could be.
>
> This series is running on my PITCAIRN setup without any visible drawbacks.
>
> V2: Drop unneeded comments.
> Remove "ix" prefix on some defines, since they are not indexes.
> Make sure each patch has a description.
>
> Alexandre Demers (18):
>   drm/amdgpu: move GFX6 defines into gfx_v6_0.c
>   drm/amdgpu: wire up defines, shifts and masks through SI code
>   drm/amdgpu: use proper defines, shifts and masks in DCE6 code
>   drm/amdgpu: remove PACKET3 duplicated defines from si_enums.h
>   drm/admgpu: move si_ih.c away from sid.h defines
>   drm/amdgpu: use GRPH_SECONDARY_SURFACE_ADDRESS_MASK with
>     GRPH_SECONDARY_SURFACE_ADDRESS in DCE6
>   drm/amdgpu: move DCE6 away from sid.h and si_enums.h defines
>   drm/amdgpu: add missing DMA defines, shifts and masks
>   drm/amdgpu: add missing GFX6 defines
>   drm/amdgpu: add missing SMU6 defines, shifts and masks
>   drm/pm/legacy-dpm: move SI away from sid.h and si_enums.h
>   drm/amdgpu: fix GFX6 variables for sid.h cleanup
>   drm/amdgpu: move si.c away from sid.h
>   drm/amdgpu: move si_dma.c away from sid.h and si_enums.h
>   drm/amdgpu: huge sid.h cleanup, drop substituted defines.
>   drm/amdgpu: keep removing sid.h dependency from si_dma.c
>   drm/amdgpu: cleanup DCE6 a bit more
>   drm/amdgpu: continue cleaning up sid.h and si_enums.h
>
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  176 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   15 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/si.c               |  387 +++--
>  drivers/gpu/drm/amd/amdgpu/si_dma.c           |  116 +-
>  drivers/gpu/drm/amd/amdgpu/si_enums.h         |  234 +--
>  drivers/gpu/drm/amd/amdgpu/si_ih.c            |   17 +-
>  drivers/gpu/drm/amd/amdgpu/sid.h              | 1546 ++---------------
>  .../include/asic_reg/dce/dce_6_0_sh_mask.h    |    4 +-
>  .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |    2 +
>  .../drm/amd/include/asic_reg/oss/oss_1_0_d.h  |   23 +-
>  .../include/asic_reg/oss/oss_1_0_sh_mask.h    |   43 +
>  .../drm/amd/include/asic_reg/smu/smu_6_0_d.h  |   44 +
>  .../include/asic_reg/smu/smu_6_0_sh_mask.h    |  190 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  358 ++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c    |   42 +-
>  16 files changed, 1001 insertions(+), 2198 deletions(-)
>
> --
> 2.48.1
>
>

--000000000000267fa10630f0b1b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I should have written &quot;v2&quot; in the title<div dir=
=3D"auto"><br></div><div dir=3D"auto">Alexandre</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri., Mar. 21, 2025, 21:47 Alexandre Demers, &lt;<a href=3D"mailto:ale=
xandre.f.demers@gmail.com">alexandre.f.demers@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">The following series=
 is intented to remove duplicated defines, shifts and masks or<br>
to classify them where they belong. si_enums.h has been used as a garbage c=
an<br>
for anything and everything when moving SI code from radeon to amdgpu. <br>
<br>
Where needed, the defines found under sid.h and si_enums.h were ported to D=
CE6,<br>
GFX6 and GMC6 defines, shifts and masks. There location was based on CIK an=
d<br>
later.<br>
<br>
However, most of them were already available, but not used where they could=
 be.<br>
<br>
This series is running on my PITCAIRN setup without any visible drawbacks.<=
br>
<br>
V2: Drop unneeded comments.<br>
Remove &quot;ix&quot; prefix on some defines, since they are not indexes.<b=
r>
Make sure each patch has a description.<br>
<br>
Alexandre Demers (18):<br>
=C2=A0 drm/amdgpu: move GFX6 defines into gfx_v6_0.c<br>
=C2=A0 drm/amdgpu: wire up defines, shifts and masks through SI code<br>
=C2=A0 drm/amdgpu: use proper defines, shifts and masks in DCE6 code<br>
=C2=A0 drm/amdgpu: remove PACKET3 duplicated defines from si_enums.h<br>
=C2=A0 drm/admgpu: move si_ih.c away from sid.h defines<br>
=C2=A0 drm/amdgpu: use GRPH_SECONDARY_SURFACE_ADDRESS_MASK with<br>
=C2=A0 =C2=A0 GRPH_SECONDARY_SURFACE_ADDRESS in DCE6<br>
=C2=A0 drm/amdgpu: move DCE6 away from sid.h and si_enums.h defines<br>
=C2=A0 drm/amdgpu: add missing DMA defines, shifts and masks<br>
=C2=A0 drm/amdgpu: add missing GFX6 defines<br>
=C2=A0 drm/amdgpu: add missing SMU6 defines, shifts and masks<br>
=C2=A0 drm/pm/legacy-dpm: move SI away from sid.h and si_enums.h<br>
=C2=A0 drm/amdgpu: fix GFX6 variables for sid.h cleanup<br>
=C2=A0 drm/amdgpu: move si.c away from sid.h<br>
=C2=A0 drm/amdgpu: move si_dma.c away from sid.h and si_enums.h<br>
=C2=A0 drm/amdgpu: huge sid.h cleanup, drop substituted defines.<br>
=C2=A0 drm/amdgpu: keep removing sid.h dependency from si_dma.c<br>
=C2=A0 drm/amdgpu: cleanup DCE6 a bit more<br>
=C2=A0 drm/amdgpu: continue cleaning up sid.h and si_enums.h<br>
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/dce_v6_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 176 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A015 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/si.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 387 +++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/si_dma.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 116 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/si_enums.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 234 +--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/si_ih.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A017 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/sid.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 1546 ++---------------<br>
=C2=A0.../include/asic_reg/dce/dce_6_0_sh_mask.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 4 +-<br>
=C2=A0.../drm/amd/include/asic_reg/gca/gfx_6_0_d.h=C2=A0 |=C2=A0 =C2=A0 2 +=
<br>
=C2=A0.../drm/amd/include/asic_reg/oss/oss_1_0_d.h=C2=A0 |=C2=A0 =C2=A023 +=
-<br>
=C2=A0.../include/asic_reg/oss/oss_1_0_sh_mask.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A043 +<br>
=C2=A0.../drm/amd/include/asic_reg/smu/smu_6_0_d.h=C2=A0 |=C2=A0 =C2=A044 +=
<br>
=C2=A0.../include/asic_reg/smu/smu_6_0_sh_mask.h=C2=A0 =C2=A0 |=C2=A0 190 +=
-<br>
=C2=A0drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c=C2=A0 =C2=A0 |=C2=A0 358 +=
+--<br>
=C2=A0drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A042 +-<br>
=C2=A016 files changed, 1001 insertions(+), 2198 deletions(-)<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--000000000000267fa10630f0b1b9--
