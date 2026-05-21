Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEB5CD4F3C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C0210F22F;
	Thu, 21 May 2026 07:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P08gTjLj";
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2862010E182
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 00:52:51 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-40974bf7781so5144890fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 17:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779324770; cv=none;
 d=google.com; s=arc-20240605;
 b=iTMgXp7f/EbA0kHgydQFh2Bp4rdNRtTto8dNbOjAbRZEw9zLNd0I2dhGg/NFhOTN4m
 24AQEAcHfvCjaZuRdeD8aWiHI/tjhf+AuiIgJb3/9qZ/+DYbG43xRGBYvIzuEQgSbTqM
 3Xs5wOynyN1DcgvPKHoQwD9KEGnGOlr3LROy4VfTFmZVnb7Qg3gWAs5d3YIX12THgkKx
 fzJmEgVeX8YNjPyKAw3AhEsXGcIU6gJqoGEoSOrwtEIRuZmffAkcBsPnEo5MUXrZN5I+
 TZEuSSZHhTZ7QKv3g6mWgzp1bETJuxC/H/fQ4uQ2QHx4lM92XoCcaw+jBo9DPxUYBWUa
 jiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=rfGahdF14NrG0GQy6WnJREawOyO9Fypnn5Px49Fz6I4=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=TRaVwCm/ULr8PQLfq80EeURF6VK12B24zhITg47yOVJBy7UsqWnMr6CZC7TnwR1789
 o5RdTcvGM5XlERkGQaxF7R0rzCBiGntRXuODo9BpnRk0aus3xelTovdtqW40rCVhXscA
 tdb2ux8xGR5uwmJwxO7ID5SrFbGDlnsQRA7aT7ftnpSU0U6HCvhDy0QOH3jpeBIMsFVb
 RA/TVQwjdsBX7K7oDOr3bNSbNBcVxCxFe0u/0RtRNvEd3QlRdWfpMtZuLlwoxGmhGl5V
 PEyYqCPb2/I3qYBDoFBwVlSevPIU81TVvGmTZqUT7VuP/EMxR9KrZR2byvMtDODDC428
 SL6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779324770; x=1779929570; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rfGahdF14NrG0GQy6WnJREawOyO9Fypnn5Px49Fz6I4=;
 b=P08gTjLj9zWt7H1IqPPGAdanQvGpLJ4nS/K/APOfnUtqxMz+oWWDDpPXOOq9IPOMXf
 Hp26+8Gk5Pn4Kf/uXgFBNmYhPrPToV1fljSCKBp1A6IFlV9sDsNDym0tKyWmTPZ+oxjS
 poWLe3uyV75VcMDzLL+lampFxnZpYm/oFY4MtXodE+m+HBfcFMRwhfcEG95MuhoWoC7D
 EhLbWz1H62Wur5ADQo6Eaxi7UMysBYoV5KpdniXFh/CLURxFK3ITDpGN21glssN3NPKl
 c1GdG0VYiJZyq7HJMK+QhPV97TIj1X4jm552VztHUUXJKUk+NZG0alBXV/qlCgUkquDD
 o7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779324770; x=1779929570;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rfGahdF14NrG0GQy6WnJREawOyO9Fypnn5Px49Fz6I4=;
 b=U93qIVASDe+0wVAleh5xNp77jsXA+Q11PPfefFvApq/K4b0T6VvLuMIMGL0PlqeHmC
 G7d4wTUe7gcm4aZrQBTcAvK8B9dVRp6qAYTbyatIaYLdEoQJTb8XFQGg3m27uAwJSd1P
 65kZ3rYSTa2f2wap25x5xE70iABXAmq0r0OVb8mPN5X3g9AgPSu+2HTRidpShY7P3bHe
 TfiZ/NWYaCLsFinVmh1q6CDnwKAIHQpMtoG5NkFoGgjyDTJKFIetohqgyEuEMGflXPK/
 prLBUi8fwzcmVKJ9rlH8g8oEka6Itc+B3iwBlk6FYgdR1YAiQZWCsXMUYU9k5HYak8D6
 YNaA==
X-Gm-Message-State: AOJu0Yw0e0LTTjDhGPdOO/72MRVlqmGwvDjSDJN+oxEQ7WIvpCIk0xpv
 NTXODSGy/jDpDefcRkbd2cvNMySVe+Fw7Sinu5TNPWrcWeIg8nOqZPu2ik1mB5YWQNNbmJIBOJT
 m2985qqovzUIwLCAoTeLMV+G58l3xpo7dHjt32b0=
X-Gm-Gg: Acq92OGgG4cOYVj6dpc4VL2LHLLdFxO9T0b2/Z8SFzg2W3y0RedymbpveZ1wbLTrDZy
 hI9jKUMHmbu62d5UbGmtAhv/NHkQ/6LxzB/wXR9FIAdy5q8NKJ5ZHur7/6ows+cJyJrBFPEHMwF
 RQg6y7WVJL57kp2CtQndf2XD+g6o+ppI6xgkslb93qxdFTcLg5ixcWA3aqAWh8Y25iX5BkSvZF4
 Zb/Xxk9+EaFIXRF1vY3mQryI+88HdYYfqzh5Kbj4O42pg0bRMqXcmmi/+iJCP0kTXG+IOXa5Bxb
 mJlRRHcIvKHFvbFAt1AjBI0F5qrRVUaPKvbBypSCLQ==
X-Received: by 2002:a05:6870:968e:b0:439:d504:1469 with SMTP id
 586e51a60fabf-43b2f88beaemr424420fac.9.1779324770014; Wed, 20 May 2026
 17:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260519084158.72960-1-timur.kristof@gmail.com>
In-Reply-To: <20260519084158.72960-1-timur.kristof@gmail.com>
From: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Date: Thu, 21 May 2026 02:52:37 +0200
X-Gm-Features: AVHnY4JCHGx_dwHeJiibFyjMZHjNcO5E4m59zZEbROjEv0hh2FDQXvHQlrrhK7Q
Message-ID: <CAOGA6Hg3Xp=idx=TM7K+_VPrjMGsf0D49c1=_1QXm+9n54hQdQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000db587506524954d0"
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:28 +0000
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

--000000000000db587506524954d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for pulling this together, Timur and Alex. I just tried compiling
the series of 5 patches and it crashes my FirePro W4170M driver during boot=
:

[   41.095779] amdgpu 0000:01:00.0: [drm] *ERROR* UVD Firmware validate
fail (-22).
[   41.095788] amdgpu 0000:01:00.0: resume of IP block <uvd_v3_1> failed -2=
2
[   41.095792] amdgpu 0000:01:00.0: amdgpu_device_ip_resume failed (-22).

I think it may be required after all to run the entire compute clocks
pipeline, or at least a bit more of it. I've been successfully running this
patch for the past few weeks:
https://github.com/luisfonsivevo/linux/commit/9b6090a4c145c988158d507c7b659=
c8765d9f7da
(I'm not allowed to create forks on the freedesktop GitLab)


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

--000000000000db587506524954d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks for pulling this together, Timur a=
nd Alex. I just tried compiling the series of 5 patches and it crashes my F=
irePro W4170M driver during boot:<br><br>[ =C2=A0 41.095779] amdgpu 0000:01=
:00.0: [drm] *ERROR* UVD Firmware validate fail (-22).<br>[ =C2=A0 41.09578=
8] amdgpu 0000:01:00.0: resume of IP block &lt;uvd_v3_1&gt; failed -22<br>[=
 =C2=A0 41.095792] amdgpu 0000:01:00.0: amdgpu_device_ip_resume failed (-22=
).<br><br>I think it may be required after all to run the entire compute cl=
ocks pipeline, or at least a bit more of it. I&#39;ve been successfully run=
ning this patch for the past few weeks: <a href=3D"https://github.com/luisf=
onsivevo/linux/commit/9b6090a4c145c988158d507c7b659c8765d9f7da">https://git=
hub.com/luisfonsivevo/linux/commit/9b6090a4c145c988158d507c7b659c8765d9f7da=
</a></div><div>(I&#39;m not allowed to create forks on the freedesktop GitL=
ab)</div><br><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, May 19, 2026 at 10:42=E2=80=AFAM Timu=
r Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@gmail.com">timur.kristof=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Fix various issues with the clocks stuck on SI<br>
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
</blockquote></div></div>

--000000000000db587506524954d0--
