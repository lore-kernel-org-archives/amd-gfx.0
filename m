Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B0710A88FB
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E71DB10EAD7;
	Thu, 26 Mar 2026 18:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KF4hBSjx";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26F910EAD7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:03:49 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12a77005d69so120724c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774548229; cv=none;
 d=google.com; s=arc-20240605;
 b=MmpPuCKeyfDTF9GMhF20A4CS5CG3/Z7CCnR2MsoegOYGrpagMLHH9T4uFxYG/9SjU2
 waXpqewoFBK7i6O0K+Z6M7l3bSqdjVlyyDVzL6aqB3U0H2TSVqm5DQ3Hxn6pUm6P5OLC
 zUUQodED1Ev9Byp1tsVHnnHJF88ISxvD+5GPT7qjpCFNxvGJ5LnqKR9BiBIsbBkemCGi
 WcjmGHjHyaT8TIYuEhcFc7Hr0TJZgbOol7Jq37faVhC1MwH953kGRcOQkbZHlhrJ8URf
 jolt35UsDafdZJn+Lcz7Bmj9Tw2tuC7lNJau18MssQtuQMOwl2puprFbDpN2TtPeQG1s
 cNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lBG4XsdRj1otTiJgGgMtBAe79oyJ7jHJaVr194EFYS4=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=fhGKVJlBD8wt4DvE6HyJRbB6ml69YtsdaxU0bZgC52VJhm8D7bBM1YVg6m1XChmVcG
 SrxPudQ3rITpsCQmc1F6Ex4j/J/PjXdGE3Uc9faVZLYS8JjdTcm4ErZxKg+h9RIfx2lj
 0H3tSkiH2D2aH19qZ8NDBASBfjOvEzm8lloSI51vzCOotcORzT8PWAwkFQmoa1al1VFp
 TUJF64AcYGXGEzcwCKmAMad8/0Jt/g/q7LGjyCw3QRsoQykvRlsdHNst50ikbEEPgDi1
 eZJ1V8PfdajS+lj4DjcYbD1L4zqdawUjpJd/Hb5STcATtsv9ExEjFInSBIKdMYf0DCnR
 jPcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774548229; x=1775153029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBG4XsdRj1otTiJgGgMtBAe79oyJ7jHJaVr194EFYS4=;
 b=KF4hBSjxZ8mn3v8x4d4fak6V00poQLWp8zLAsWO9vmfGSrjI5/OPOJ1lAJYf22InIC
 4/MpS6Ahae/UBExTww7KRo0msddAnM1Xkcoe9CTLfV9/ILxooVelp46sxxj8ZiY7Iku6
 bcbxSld3/YuqNo4WSr2x4IR7LC6nrJpEJki45OhtwFoXEZ9bqGqz/WcqzNx68J7+udF+
 fazKMHZyfStiqAhmtaixKjQtr4ZemmF0+SVZo3oBcDJhemy5ID+muIqIxr1mFSdYlJId
 Bs9/jsM3us2WB5oxr0aqRpJGtBWl1A/f2/hP8MFKCOTL/l+zHjqfIeOFlIqES8ey3s1g
 I1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774548229; x=1775153029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lBG4XsdRj1otTiJgGgMtBAe79oyJ7jHJaVr194EFYS4=;
 b=NwBPJaSnTS9zQ1Q6AlXYZGDKK4ytq1Z4r5sFbwwssl2sIK+zQrOVw84LT7o8srVWQf
 tub17tGT9RBrRF3OdvOEzsZhx/f/VzgNvVITLU57J+a+o7jbM2J/+btQ3E95e7q1gNzy
 41h7gkOfuhmGqJNSNvXqbVllAFaLYj31S4hoAmC5OfpRXM5iIOtjMBVm45T12Yf97XTx
 sJZM+Ka7dPhNWXmPhAuTnIzfqN0NLspe1pBCWWexW+vd+B51yFmBmHozr7SHQ4v5QYlQ
 dMXG4iYoKzrELu3kR6nH6491jP/PDGgYWQ4ljgd5X7zoBM6+jGPOVy6JWIbyRCyB0Cw7
 0Vpw==
X-Gm-Message-State: AOJu0YyAxHBp+sa/1swbaVHoEmz51Vn6oGvP+IXWqD9ADqGUHy+sJ29N
 SJFODvOFws+1JyCFKX11OsblLXkldwkjugU7yZmt1ICGbakziI2JBYa4MOBWVAFNMgmdOXG+dlO
 dOn5tLHrBbWGEo1M7ofikJuVHG57PJmA=
X-Gm-Gg: ATEYQzwUIgzayQpAZaGDj6kqQ2bE32H4AdS4P/jig7o37GBlcCtZGF20S5gw84ZHFlM
 OOvt+D5CWIaxaO7LaXgm1kIuB1a9cS6jIsQjHtK/9UIp/ntEMIh2hTWzS04npWbJt++6enVymKu
 +qmdzgvOSV8jyfo3FCoUwa2GURHPeht6FhR4+qfEMrDJ11+mr57M/f7cS/+8l1jrK91pLZe3+nE
 MfjrwB36F/FC9jXEJTmyBBx4wufJpR2BPbCvYatynh3bBnzAQWzqqBbMwBI4LvHCPSGjcBjOrjb
 LyGZ3GPtfSeKxfb7VvLDCfLQE6K5lbWvZEFxkRTLaIRxxuP1G1jbkYrPhCNyUhzs0HufyA==
X-Received: by 2002:a05:7022:69a7:b0:128:d7b3:6c52 with SMTP id
 a92af1059eb24-12a96ebe2d2mr2094012c88.4.1774548229076; Thu, 26 Mar 2026
 11:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-8-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-8-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 14:03:37 -0400
X-Gm-Features: AQROBzC5I8u_H4oXu4qfX07In21Fv9ETh78Cb5Mqu8bkLr3BIfobSXXv9Mx2bUY
Message-ID: <CADnq5_Ngo+L-4=t6vBUFYqVjv9aDH71vgVzCuUU1s0x=XsbWyQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] drm/amdgpu: Enable suspend/resume gang in mes
 12.1
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
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

On Tue, Mar 24, 2026 at 1:57=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> This patch adds code to mes_v12_1_suspend_gang and mes_v12_1_resume_gang.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 34 ++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 4b279259b9d3..7aea3a50e712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -468,13 +468,43 @@ static int mes_v12_1_unmap_legacy_queue(struct amdg=
pu_mes *mes,
>  static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
>                                   struct mes_suspend_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__SUSPEND mes_suspend_gang_pkt;
> +
> +       memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
> +
> +       mes_suspend_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_suspend_gang_pkt.header.opcode =3D MES_SCH_API_SUSPEND;
> +       mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_suspend_gang_pkt.suspend_all_gangs =3D input->suspend_all_gan=
gs;
> +       mes_suspend_gang_pkt.gang_context_addr =3D input->gang_context_ad=
dr;
> +       mes_suspend_gang_pkt.suspend_fence_addr =3D input->suspend_fence_=
addr;
> +       mes_suspend_gang_pkt.suspend_fence_value =3D input->suspend_fence=
_value;
> +
> +       /* Suspend gang is handled by master MES */
> +       return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_i=
d, AMDGPU_MES_SCHED_PIPE,
> +                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pk=
t),
> +                       offsetof(union MESAPI__SUSPEND, api_status));
>  }
>
>  static int mes_v12_1_resume_gang(struct amdgpu_mes *mes,
>                                  struct mes_resume_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__RESUME mes_resume_gang_pkt;
> +
> +       memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
> +
> +       mes_resume_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_resume_gang_pkt.header.opcode =3D MES_SCH_API_RESUME;
> +       mes_resume_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_resume_gang_pkt.resume_all_gangs =3D input->resume_all_gangs;
> +       mes_resume_gang_pkt.gang_context_addr =3D input->gang_context_add=
r;
> +
> +       /* Resume gang is handled by master MES */
> +       return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_i=
d, AMDGPU_MES_SCHED_PIPE,
> +                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt)=
,
> +                       offsetof(union MESAPI__RESUME, api_status));
>  }
>
>  static int mes_v12_1_query_sched_status(struct amdgpu_mes *mes,
> --
> 2.43.0
>
