Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B6DC02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 18:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EEC10EB98;
	Fri,  7 Feb 2025 18:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T7jwomrY";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7B310E12E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 18:22:53 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2f9dcc3f944so494950a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2025 10:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738952573; x=1739557373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5kJC5GX5lE4ZlE19f7dT2RP2+7VJSPDvxPOz4Kdgbg=;
 b=T7jwomrYTPCZAowHP66HaIV20PDjMGA5XXw0/7LMnlRu4H7WuIrp1mOXUBEvshb55p
 jntqFSyDUZYMVUJR2AvVwsSIir7KCIzGZeXirzMhvEFOAjjqSfJLyx7OuMnl+kLbIb5y
 NIfCb5By6PrBcUd4c77ETxAMwG9pQkQBp4h/6qJ/VDf/9UVnS8P7ApCVSZYb0Y18lP9e
 9IdctoQaXXpn3IA2I94Slw3opv4XAz2tK1UVyKtyyWqFcZ3jFzS/HFh+I1BG13ohz0jb
 Ut1kbl1OGvAmSf7NsM1xPC0EbGA0jzituXur/K2gqpTkd58FRL4nb0Ag9rArATAA3CSO
 XGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738952573; x=1739557373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5kJC5GX5lE4ZlE19f7dT2RP2+7VJSPDvxPOz4Kdgbg=;
 b=ROuXpU9wquDwAgh5I2V30BuH26mLoQyFh362+ipqAqk/diioygWzonZmz1gseWUY3d
 NakBDPC7jQIl1lnYwFkgjkmZB38Z5uE3S+aAefDPwiMaCOKD83drcSJfHVLhPT0uvxy7
 nZ78khegNATWmrjjSukLazs13LKSKB0Lnu2TVSxFZKQqNhSFhsRgM3EuPl6ETDBV3fsz
 nGGQViyrcYscCDgUoLEglhkkqVZSF69pADnW8HU4z3RuM+oPpxxj+6f9YIosVu2RLiQa
 /y+Ud3agUnOrbrfe+9ZnXTEtMqeYftb/xF85Ts66U4MGyf7BcfjJolG567i5VJxQthen
 QANA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzFC7WeA39hEjFQnxdanXk2tF23RlW4GxOraZWsZG7Dk7LQQ47WFX91hjXiv7ALmQSJSCA/bQi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRLiL1kBYWEytdR5vSZr+Ng7ny5On/kKc59mQj1hUrjxNyZKKH
 uJECPleLgg/9fukDr4Ge/Q4962lwkC1Ll/m6lvSA4LhNND0DFch7R6myRh5VyR3p8fe06gAmJJe
 BqF7Vmy3k2itzbQ+ucFHwzoOYua4=
X-Gm-Gg: ASbGncugusrah/Y8xz0o82pGkfw9oODD3VcHYLUWVdDeQdMfywwjRukyREdzjQMgeRB
 xhYsF5gEgyhj1icZudHTVFGY4t1TtHCHPxvASnFL+JZFm3O4iKFo0S2xpedu3te1+77AXfL+1
X-Google-Smtp-Source: AGHT+IEx3WdsObZEC1Rihm4t1Et73TpFcCi4AwXrIqmi0GZRa1bfwvED9ECO4w12eSslPnpArB6Kjy2vqDUSyvRoego=
X-Received: by 2002:a17:90b:1b44:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fa23f5ea82mr2546931a91.1.1738952572812; Fri, 07 Feb 2025
 10:22:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738909308.git.gerry@linux.alibaba.com>
 <6bc04a402ec50c6b9d95c160d9bd74bb3b419e70.1738909308.git.gerry@linux.alibaba.com>
 <aad42783-d677-4031-bb86-5d02757e9493@amd.com>
In-Reply-To: <aad42783-d677-4031-bb86-5d02757e9493@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Feb 2025 13:22:41 -0500
X-Gm-Features: AWEUYZk0kga7TnZAixH8fduZ6dyQXL7ySNPgeI9Gtbw-_1J5JdTMVnw6gsGEnt0
Message-ID: <CADnq5_N3k3Rui+0vd45rrAt7nnminrqR7bSHm9fj072rp+_F1w@mail.gmail.com>
Subject: Re: [v1 1/4] drm/amdgpu: reset psp->cmd to NULL after releasing the
 buffer
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com, 
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com, 
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Fri, Feb 7, 2025 at 6:17=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 2/7/2025 11:58 AM, Jiang Liu wrote:
> > Reset psp->cmd to NULL after releasing the buffer in function psp_sw_fi=
ni().
> >
> > Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>
>         Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c
> > index babe94ade247..4e9766a1d421 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -533,7 +533,6 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_b=
lock)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       struct psp_context *psp =3D &adev->psp;
> > -     struct psp_gfx_cmd_resp *cmd =3D psp->cmd;
> >
> >       psp_memory_training_fini(psp);
> >
> > @@ -543,8 +542,8 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_b=
lock)
> >       amdgpu_ucode_release(&psp->cap_fw);
> >       amdgpu_ucode_release(&psp->toc_fw);
> >
> > -     kfree(cmd);
> > -     cmd =3D NULL;
> > +     kfree(psp->cmd);
> > +     psp->cmd =3D NULL;
> >
> >       psp_free_shared_bufs(psp);
> >
>
