Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411E8CDB483
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 13:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B026110E2F0;
	Tue, 17 Oct 2023 13:03:35 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A69D10E2F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 13:03:34 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c67060fdfbso3987375a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697547813; x=1698152613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5luxBcmBEhuD4an9l0/cCaiZywhhl1fmOBd3F9wr+0=;
 b=GNAXu355AiAS6JtE65P7GP67ns1TOJH8/J0POgHzBZRArQM1k3ZYXAeMqKFSFcZkck
 tNHxoMOytFb5Ywl7J47lra7A64O6ZJqw3eeb0QZicITYzmirk/Nm3/BVuAevb0hA1uWn
 1gg2puDmTa74LNNSZsxphRiV1wQnSWPzQ+IzC7KcwdxQ4XUErBr0OaGRWhMaHDGbNLeN
 xuuACvWDEdRo0yEEjRfd7+D6EcCCObDuj1ZKd7/HrzsvV5J6l65x/WiTLjW1mDtftZjd
 TgGtkYheHcEVIumERNgCflkzb2Gf+zh42qxJ1FCJ+TnBjT/Hl8msLZSZFyDGYFma1p23
 XWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697547813; x=1698152613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5luxBcmBEhuD4an9l0/cCaiZywhhl1fmOBd3F9wr+0=;
 b=TI+FGk0PthgzN3q8zyp1JL3C1wB1rPfvnQoUu2tarSXfMEEAw+Q+opM6ujYeuEF07K
 Uytr3Y5X2IHwWNF7IenXgyotOoHQZxoLQ7J4l/VKMudoZRw2uSMOHoRmk+N1bOWnAO/r
 mN2W3yOkkhRuUGuSmdFcNwCQlgpt/IRSFqDBXVcHL6Bi1WngrR2/DFrCQN56+tCWbeEN
 z78irfEEeG1j+7QBy6EuHMhePi+GoAY/jis2oVF9DXo+60tK/MTo1g9xnG3GSGqJg0hH
 kpC5YBFSGZrXPhQUNeMsTrttyYe8VI2GSUdNHlRykxrnLyIcVALxHUPkXsYe3NSg3oan
 rMaw==
X-Gm-Message-State: AOJu0YwNeDX7DutxUj8AimLmeSHZNPQ7smTzj95B0rSHbojH1xk0cBAu
 Xy7fFrYTgY08jC2usrcrGtFp7YJEMkVF0/Ze4i4=
X-Google-Smtp-Source: AGHT+IEO73oxvy4XMb/YW6PIg2gezwiJjkqQ6LI+S9aHEIX2TUMYtPkHwTfAovuBaoSZ6HlfYWqo72DDzduDPeL3Spw=
X-Received: by 2002:a05:6871:468d:b0:1ea:69f6:fe09 with SMTP id
 ni13-20020a056871468d00b001ea69f6fe09mr2412861oab.10.1697547813227; Tue, 17
 Oct 2023 06:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231017121015.1336786-1-christian.koenig@amd.com>
 <f7e00a0a-fa67-4391-93fc-402dae14a6ef@amd.com>
In-Reply-To: <f7e00a0a-fa67-4391-93fc-402dae14a6ef@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Oct 2023 09:03:22 -0400
Message-ID: <CADnq5_Nm4fVy=HUbE4DRG7X908G6EaNEc+NfcS=7W3gPoju8Uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: ignore duplicate BOs again
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 17, 2023 at 8:43=E2=80=AFAM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> On 10/17/23 08:10, Christian K=C3=B6nig wrote:
> > Looks like RADV is actually hitting this.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Fixes: ca6c1e210aa7 ("drm/amdgpu: use the new drm_exec object for CS v3=
")
>
> Do you think this will fix the following issue?:
> https://gitlab.freedesktop.org/drm/amd/-/issues/2893

No.  That's a known issue with data migration back to VRAM after
suspend.  There are TTM changes required to fix that properly.

Alex


>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index efdb1c48f431..d93a8961274c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -65,7 +65,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p,
> >       }
> >
> >       amdgpu_sync_create(&p->sync);
> > -     drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> > +     drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> > +                   DRM_EXEC_IGNORE_DUPLICATES);
> >       return 0;
> >   }
> >
> --
> Hamza
>
