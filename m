Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335E7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 17:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B523710E65A;
	Tue, 12 Dec 2023 17:39:57 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5108310E63D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 17:39:55 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5907ded6287so3463378eaf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702402794; x=1703007594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFLAKTHtzrc8PRoIA8Srh/QJ1jIn326xLMeG7PoJ7vU=;
 b=ncyjuD5pFlXXo/JAcBHZGJM8LTnva1c1sl95LS9gJG10tgxFiIxCZf+3+adkBeTM1r
 5Q2kVTrmXxaKNBCZiL6XHnSe3r4pGyMvr/8YVbJxe5aZ/2HHbxIsskQ7fSQzA8fZDkwO
 SCR+RXVpO4Wr+mnkKs0lFuFe+42n83sEuNxX8FtFh1QOTECDuiXzq5MOD4366c1pEvC4
 zUvGMolJv42tVkKFxfTmMdPhs/JH7mdYiRGdZJMPaZmH52kqqGP9v8cfgR+YWfqqRG7z
 2vC7i/D35Na+WAkBtwQ7Qa+uRjxP8eClk9yOBGFrlMzFkbY313FNPcwbHbkhVzF6kK+K
 SJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702402794; x=1703007594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rFLAKTHtzrc8PRoIA8Srh/QJ1jIn326xLMeG7PoJ7vU=;
 b=KvkXKRmdDxKzGXqNAicmEjISxA6KWAo8W+gG6GkeC5zet89iU2Kjri6Zb0JBGbsU49
 R5OWOWuzD5VcplahOSleYmmw8ULK5ZSoeyzJE7u2Gq7sM+KdILhaGIabWGsOSjgrZUUt
 L+OrIclMRLBHXlmqmMRTvUcmJ3bnB1NPiHswMjsp9x2cuB6HTuXFAQkTFWrMKqJABC2o
 wBrUZ1tPQ4SNfgH4VrxTcQCLOg8KBCAkJJIyusH2fjkA600dcl9wKEWxTMyXWWT4l9xB
 pDMxUypbu3jzDARx2IyCIepm5oNh11ETbgOp2VBoHoS1NxNCwOD7BXW567mextKFoy0L
 WGkw==
X-Gm-Message-State: AOJu0YyEkiM84BDciL3ee3iOSKgsAy/7Jo8ZGCremZII4AvNO5/II3R5
 HXguXs0+ABeXzu2+E347IN5uCPgLG6P5Eoi9U/wyxyxf
X-Google-Smtp-Source: AGHT+IEPOeQLbpeC6/HHIxCpBzwUapxz2bJgTS7NYFcW67ZYUHIlpJ+eD3ZMibP0Y661N2/aqKRxBSbyQcpFlbj8f4w=
X-Received: by 2002:a05:6870:c0d1:b0:203:193c:1104 with SMTP id
 e17-20020a056870c0d100b00203193c1104mr35154oad.20.1702402794305; Tue, 12 Dec
 2023 09:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20231212070916.141121-1-mario.limonciello@amd.com>
 <CADnq5_MsKJVMya0n18oOmUFOyq8wYZwAAFuaA13KC-odT5N5Qw@mail.gmail.com>
In-Reply-To: <CADnq5_MsKJVMya0n18oOmUFOyq8wYZwAAFuaA13KC-odT5N5Qw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Dec 2023 12:39:43 -0500
Message-ID: <CADnq5_MkgnVAH+fb_ADvc-3=QarbKBqxJ0G7oai01p-1ot9dbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix a probing order problem on SDMA 2.4
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 12, 2023 at 12:37=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Dec 12, 2023 at 12:30=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > commit 751e293f2c99 ("drm/amd: Move microcode init from sw_init to
> > early_init for SDMA v2.4") made a fateful mistake in
> > `adev->sdma.num_instances` wasn't declared when sdma_v2_4_init_microcod=
e()
> > was run. This caused probing to fail.
> >
> > Move the declaration to right before sdma_v2_4_init_microcode().
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3043
> > Fixes: 751e293f2c99 ("drm/amd: Move microcode init from sw_init to earl=
y_init for SDMA v2.4")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> FWIW, looks like cik_sdma.c and sdma_v3_0.c never switched their
> microcode init to early init.

Nevermind, I had an old branch checked out.

>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v2_4.c
> > index 45377a175250..8d5d86675a7f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > @@ -813,12 +813,12 @@ static int sdma_v2_4_early_init(void *handle)
> >         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >         int r;
> >
> > +       adev->sdma.num_instances =3D SDMA_MAX_INSTANCE;
> > +
> >         r =3D sdma_v2_4_init_microcode(adev);
> >         if (r)
> >                 return r;
> >
> > -       adev->sdma.num_instances =3D SDMA_MAX_INSTANCE;
> > -
> >         sdma_v2_4_set_ring_funcs(adev);
> >         sdma_v2_4_set_buffer_funcs(adev);
> >         sdma_v2_4_set_vm_pte_funcs(adev);
> > --
> > 2.34.1
> >
