Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DAAC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BFF10E179;
	Mon,  4 Aug 2025 17:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mDpn+4Nr";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6809810E179
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:19:28 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-32130f6cfbbso219131a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754327968; x=1754932768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyXkypvQ8K0ixFUVQwJ0ZzX6xWZKiFe5shuQDMHlUsM=;
 b=mDpn+4Nr57iUTV3ZYnNdBqGgIJDt0lJJCHagX+yEavqe+5yrnYdLlT8nOQVC6E1tIJ
 vngIieKU0+o7lE+gnzoYTGCiaBi4K1LV4oRjlxGScf15G7S5vr+JqWUe6f5spxqFROsG
 3nGPA5UH7ncU4t2DaOhbwFk6ebXFr8Kceoj0z4Tg3KZeWIRthGM3y8ZGPsLqCpMLcEEA
 fEXfxWhZF7W6CoUw68wYWmsoSkp7zkz69f/DdxKD9snivnNDKbgPlzP99ldsFndOHPdi
 k4anDoCOI5kJ0dDZ1nZkkPEHJaCCqOOyZyZOr9B8HNXjGyfwsn/VTIYVpD109x9ljams
 ZGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754327968; x=1754932768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyXkypvQ8K0ixFUVQwJ0ZzX6xWZKiFe5shuQDMHlUsM=;
 b=eC44hU+de0qlcZvy6tGoh8I2TZjbsi3zkHEsOnEe4HYEORPZ6Zrl9iWhIz1Kni8yzQ
 KaXRbJLSbZP3Be/Vqtj4+MdYiaURpfmE6jiTamYtbde+/NqKu8Bc595l1H2H+2f9ARNC
 BeYBc37DFRjd/RwF+p6XHfniPAKegp87ijlHZkVfshZXwP1cyZQYI6vdWtGMQhP5io6B
 TRNJdBiKqZYkk81jMrqPO8KGA62rA7SmopJrX+zWIv451lk2piicBxw1k/apiF7nQqgN
 1YAYk3tdESICKJ4payNMGSuMDMQFkRNLjJfsjOk5lSHRXQ8PjE+/kcgw2+CIQl+yH0EG
 NRpA==
X-Gm-Message-State: AOJu0Yzu2YkHsnqGLZqf2BH5zE348cac488BiPWKiX3xch2SNoA1HefP
 CaAD5G6P4l5+wNlM+sQ6GmUpaByL15LJ3dgdN3BI0IMeBt6EpxbFIHNbxF8w2lR8p13+K9s2QYX
 jAJCtxaoewGj/Nz00nPq1cKmK9joGEpEHW4hW
X-Gm-Gg: ASbGncviAeDTQJ4R/GZByhQj4C4aqVVd6EKeqgmT1GvPNMdbQWLCBx5/K4FVtFJ7bLk
 kvrUVBuWyNv5nuU9zgMKb/thYeIk6yZwpzamnoLPi2c0WqtCgc3M8Ctmw9sq9XCwjEXx3uHGl7G
 VJ3ie40GEIsh0VNdwTE+5RYbBfnd133AuVw6zyqJcwFWQaGSazDOLgw6UumArH5LPUerpq2r8sN
 t+kxXM2
X-Google-Smtp-Source: AGHT+IHoVXz7Wof13wfaNq4JFFoUgzLc1hK/cLkQQzt2my2owV5N9SxfnY3Dm+Y3eytO/2AbY1/Rj41dYTUrYJEL7Ic=
X-Received: by 2002:a17:90b:3887:b0:31e:ff94:3fae with SMTP id
 98e67ed59e1d1-321162a2892mr5864951a91.4.1754327967455; Mon, 04 Aug 2025
 10:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-9-Jesse.Zhang@amd.com>
In-Reply-To: <20250804084029.863138-9-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:19:14 -0400
X-Gm-Features: Ac12FXzoM_sr9a9iWvOXP69ndF9pVtqgIBsyGqxPkCsc0-pECUaWbyA0T6QRp-k
Message-ID: <CADnq5_MOzVBUDjcimZ+tCXMA4a_h17tUm6U__sUkost6yn0_kg@mail.gmail.com>
Subject: Re: [v6 09/13] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Mon, Aug 4, 2025 at 4:48=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> This commit implements the actual MES (Micro Engine Scheduler) suspend
> and resume gang operations for version 12 hardware. Previously these
> functions were just stubs returning success.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 44 ++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 579720695e9e..9c86dfdef1bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -569,13 +569,53 @@ static int mes_v12_0_unmap_legacy_queue(struct amdg=
pu_mes *mes,
>  static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
>                                   struct mes_suspend_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__SUSPEND mes_suspend_gang_pkt;
> +       int pipe;
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
> +       if (mes->adev->enable_uni_mes)
> +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> +       else
> +               pipe =3D AMDGPU_MES_SCHED_PIPE;

I think this should probably be AMDGPU_MES_SCHED_PIPE always.

> +
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pk=
t),
> +                       offsetof(union MESAPI__SUSPEND, api_status));
>  }
>
>  static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
>                                  struct mes_resume_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__RESUME mes_resume_gang_pkt;
> +       int pipe;
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
> +       if (mes->adev->enable_uni_mes)
> +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> +       else
> +               pipe =3D AMDGPU_MES_SCHED_PIPE;

I think this should probably be AMDGPU_MES_SCHED_PIPE always.

> +
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt)=
,
> +                       offsetof(union MESAPI__RESUME, api_status));
>  }
>
>  static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe=
)
> --
> 2.49.0
>
