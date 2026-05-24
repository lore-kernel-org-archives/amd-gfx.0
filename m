Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C46CD6E47
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FFF10E569;
	Tue, 26 May 2026 07:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fXq/CoBq";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4D110E0B8
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 May 2026 06:38:53 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-43496e6a964so6285322fac.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 May 2026 23:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779604733; cv=none;
 d=google.com; s=arc-20240605;
 b=V7GauR5XZ9xEYhsUUKp+NhVi0WzWYqoHWRiEbg5ft+GopbtQosbfajbo58Q3chNtdq
 n2ZQbDcHvvd7jHDjqtU+cLq1C4ovSn+3OrXbvubjD9PA8QLlmpUrm3X1Bo3LmDtAsTqP
 JkTyV9k15dGAOX3/ZVFBb5cxNNTFsjQMNCXxLPx+YU3N3lYA3EHPgSES1LbgifpMkRyK
 05bP7lSW0EitO+h+gOBxVtX3OqnzYLMuAiDkMQ2ogLR05a/WMJCfqMegFBP6XV6Bpsv1
 oMzuy+L3C19uaqujPvBbHU4d4Iyv63A/6a9GIyNdJ1mFiFY28J7ZAoKdgYZk7zP7C4gf
 PXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QaMfln2ByBFUQ+J3B2UtN1L1gX2XLG038KWWEXFitTI=;
 fh=ek6b5uMEeNDVeRr9FvJqwX5rAOxeGnLDMnth00heuWE=;
 b=bzXf8flQu7/DHFD1WKm4iQlbrK1nMhc0UtfsvOB9fOwrCPeE9W6USC2lph1c+ezmEf
 nXL9+ebphoDoQUsF5O+gXNyLMN0WCBjOtCmRTamKfZyj6yq8OgziUtHjIk84jYGE9mTs
 FtMaBf2Kz8IcoBCKABbZnBEhfeqAmRQBrBxpAxYzj08Q+xmNftwHFs1z9uy4iw9I8aox
 2qDPEkio+XlijlirpVkOAmDhbvosvc+MN8Sf6IexCeW7fZxog/SCtvbThm/M6VebQyt5
 XXVLg59tdByJ2CG9sFqoB2AePcP1h68r3ovehCXNkf4jtwlcWvbmlBZHCmDmow+jE0yJ
 AJkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779604733; x=1780209533; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QaMfln2ByBFUQ+J3B2UtN1L1gX2XLG038KWWEXFitTI=;
 b=fXq/CoBqb5HWMDkhLsfZL35NNC37EQb0Wk+AJNGXljZamyhVG2RheB3rWp9EHKDu/h
 mfmPd4mksotE6xk8kCYgbO3jKHtSv+F+8HtMUdQILmmr1xtrP72AJMgqhJ8UqQOiolAV
 zmoL+1YC3eKmxoHqnAYCRMpso1+tLvdercqftZ0K2vnJxANWAlVngvhKpUbcaTCS2Fxf
 lXHnDQ/W3lpEph5nA4Pf5+oi0ElilUv8LbIuRIF+IODa4ug4snDplReCx02n1IaUbP7O
 paov4nkSQMNk+vqVVtjjGbasckwPqp1y5q5A7lOkRcXtpS+8VKxEUdDbLQubw52wXlz2
 orTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779604733; x=1780209533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaMfln2ByBFUQ+J3B2UtN1L1gX2XLG038KWWEXFitTI=;
 b=j0vcTTU6VGkFrPPRA7SWTEA2cZRIgiN+zH9C/fGAzvZgBIr10GHZ+MoWnKCgxpsFZv
 Z6/THrjo/p0OaprkD2xYKw00SiRyKbNMaTTcfGhW3mS8IPfxzC6DJkDI6ieTwYGYR6M/
 AE34DAc9nmXQfjvlKa2vLZLaS3mVMrfgjyKYVjbMg+5YARpRjavRf3zKdFkUEyPvb5Mx
 jI4i3RZ5LqvafcrPm19VqsDR8XIftGQJhZ5SzQ7DndK6xb5FBaC8o6Re+GURXPWt/iTt
 f5z/nuBsVdDhu2nN9AKYh20dAIfKS+Ov9zZvQ5IhxcHhkAzdJuIktQuBroiX7L1rssnb
 KVLg==
X-Gm-Message-State: AOJu0Yz6FZ05pOkbJzqSyFq3YY+OuxsE2vbabvwLkj7Exuy01edv9qwV
 dzYkuwcryYQkRe5Q5pZJ0nEbbB8hDa5qPnlwSEx9mrbpwSlCNQy8W3WCcLnZtumhL29PpUD+GHi
 Axp3fD7k+jqzNFwNtrYUM32ZlDPaIxYYk2CzFzHU=
X-Gm-Gg: Acq92OHZ+i+pNRWrjz7qZcGD7DM39eOYtUTYg5lK58Z5XUvDeShp228lCO4WSnFmLMJ
 vqyG4VHVGzWap147lCwNEltKejcFq6QrVuDNjV/bleVvYTHJRchs5BkMNAZe2lBZjKyiFyOEwxo
 26IygytvEPPEa6hFcXjcQwSp9C3RNnO2tlIYV8uaDjMxwBiEF5uRgksGNRdeSv5fk4PBEfqe3VK
 UTgDuiNmYg6lS3SV6IvKTqG9vYUKjZ06KnrpuiPz1CwUh5OU4R9S6TgphOrZ5NweL7jyW+Ovp08
 lLaVSvWLxia046H29XvDa+i2inPYBaL4KjjP9KR6XwHZLP6C2Nno
X-Received: by 2002:a05:6870:c292:b0:41b:e633:baf4 with SMTP id
 586e51a60fabf-43b5a9a2430mr6262543fac.3.1779604732811; Sat, 23 May 2026
 23:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260519084158.72960-1-timur.kristof@gmail.com>
In-Reply-To: <20260519084158.72960-1-timur.kristof@gmail.com>
From: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Date: Sun, 24 May 2026 08:38:41 +0200
X-Gm-Features: AVHnY4IbV09zlnkTeMoe1rVsbwWJGog2myT2i81SQicCmWsTA4wyut9YZiVN53E
Message-ID: <CAOGA6Hix7yPkF2o3hapz9zfpRZ5HHjaaJuDcyWjp+Aoihxf9-A@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Cc: timur.kristof@gmail.com
Content-Type: multipart/alternative; boundary="000000000000f09e1d06528a83a1"
X-Mailman-Approved-At: Tue, 26 May 2026 07:53:08 +0000
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

--000000000000f09e1d06528a83a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for my late reply. I tested the patch series (SI laptop
1002:6606) and the problem remains where the clock speeds don't boost upon
switching to AC. Timur and I investigated this and found 2 problems:

1. It seems that it is necessary after all to recompute clock speeds when
toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no effect.
Each ASIC family's apply_state_adjust_rules appears to be responsible for
the switch by setting the max_limits, and this function is only called as
part of computing clocks. I'm considering removing the .notify_ac_dc field
from the IP block entirely and just calling .pm_compute_clocks from
amdgpu_pm_acpi_event_handler, but I only know for certain that this works
for my GPU.
2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU, causing
PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled
erroneously, or we're interpreting its intended usage incorrectly.

Unfortunately we're a bit stumped without either having documentation or a
stack of old laptops and could use some guidance on how to best proceed.
Thankfully the merged series doesn't seem to be causing any regressions at
least. I am currently running this workaround patch on top of the original
5:
https://github.com/luisfonsivevo/linux/commit/d74aa4e6fe4212c0a90467c45646b=
d138cea9a9d

On Tue, May 19, 2026 at 10:42=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com>
wrote:

> Fix various issues with the clocks stuck on SI
> laptop dGPUs:
>
> * vblank mistake when there are no displays connected
> * forgot to notify SMU about DC->AC switch
> * inconsistent values in VBIOS
>
> While we are at it, also implement the DC->AC notification
> for SMU7 as well, which is supposed to work the same way.
>
> Jeremy Klarenbeek (2):
>   drm/amd/pm/si: Fix updating clock limits from power states
>   drm/amd/pm/si: Notify the SMC when switching to AC
>
> Timur Krist=C3=B3f (3):
>   drm/amd/pm/si: Disregard vblank time when no displays are connected
>   drm/amd/pm: Rename enable_bapm() to notify_ac_dc()
>   drm/amd/pm/smu7: Notify SMU7 of DC->AC switch
>
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  8 +--
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  6 +--
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 50 ++++++++++++++-----
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 +++++
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  1 +
>  7 files changed, 74 insertions(+), 20 deletions(-)
>
> --
> 2.54.0
>
>

--000000000000f09e1d06528a83a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Apologies for my late reply. I tested the patch series (SI=
 laptop 1002:6606) and the problem remains where the clock speeds don&#39;t=
 boost upon switching to AC. Timur and I investigated this and found 2 prob=
lems:<br><br>1. It seems that it is necessary after all to recompute clock =
speeds when toggling AC/DC. Sending=C2=A0PPSMC_MSG_RunningOnAC on its own h=
as no effect. Each ASIC family&#39;s=C2=A0apply_state_adjust_rules appears =
to be responsible for the switch by setting the max_limits, and this functi=
on is only called as part of computing clocks. I&#39;m considering removing=
 the .notify_ac_dc field from the IP=C2=A0block=C2=A0entirely and just call=
ing=C2=A0.pm_compute_clocks from amdgpu_pm_acpi_event_handler, but I only k=
now for certain that this works for my GPU.<div>2. The=C2=A0ATOM_PP_PLATFOR=
M_CAP_HARDWAREDC flag is enabled for my GPU, causing PPSMC_MSG_RunningOnAC =
to never be sent. Either the flag is enabled erroneously, or we&#39;re inte=
rpreting its intended usage incorrectly.<br><br>Unfortunately we&#39;re a b=
it stumped without either having documentation or a stack of old laptops an=
d could use some guidance on how to best proceed. Thankfully the merged ser=
ies doesn&#39;t seem to be causing any regressions at least. I am currently=
 running this workaround patch on top of the original 5:=C2=A0<a href=3D"ht=
tps://github.com/luisfonsivevo/linux/commit/d74aa4e6fe4212c0a90467c45646bd1=
38cea9a9d">https://github.com/luisfonsivevo/linux/commit/d74aa4e6fe4212c0a9=
0467c45646bd138cea9a9d</a></div></div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 19, 2026 =
at 10:42=E2=80=AFAM Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@=
gmail.com">timur.kristof@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Fix various issues with the clocks stuck =
on SI<br>
laptop dGPUs:<br>
<br>
* vblank mistake when there are no displays connected<br>
* forgot to notify SMU about DC-&gt;AC switch<br>
* inconsistent values in VBIOS<br>
<br>
While we are at it, also implement the DC-&gt;AC notification<br>
for SMU7 as well, which is supposed to work the same way.<br>
<br>
Jeremy Klarenbeek (2):<br>
=C2=A0 drm/amd/pm/si: Fix updating clock limits from power states<br>
=C2=A0 drm/amd/pm/si: Notify the SMC when switching to AC<br>
<br>
Timur Krist=C3=B3f (3):<br>
=C2=A0 drm/amd/pm/si: Disregard vblank time when no displays are connected<=
br>
=C2=A0 drm/amd/pm: Rename enable_bapm() to notify_ac_dc()<br>
=C2=A0 drm/amd/pm/smu7: Notify SMU7 of DC-&gt;AC switch<br>
<br>
=C2=A0.../gpu/drm/amd/include/kgd_pp_interface.h=C2=A0 =C2=A0 |=C2=A0 2 +-<=
br>
=C2=A0drivers/gpu/drm/amd/pm/amdgpu_dpm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 8 +--<br>
=C2=A0drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c=C2=A0 =C2=A0 |=C2=A0 6 +--=
<br>
=C2=A0drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c=C2=A0 =C2=A0 | 50 ++++++++=
++++++-----<br>
=C2=A0.../gpu/drm/amd/pm/powerplay/amd_powerplay.c=C2=A0 | 12 +++++<br>
=C2=A0.../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c=C2=A0 =C2=A0| 15 ++++++<b=
r>
=C2=A0drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h=C2=A0 |=C2=A0 1 +<br>
=C2=A07 files changed, 74 insertions(+), 20 deletions(-)<br>
<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div>

--000000000000f09e1d06528a83a1--
