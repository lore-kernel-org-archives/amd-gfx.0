Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056EFC54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 01:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6049310E56B;
	Wed, 28 May 2025 01:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WuSbc8Rj";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D97110E56B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 01:17:52 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b2705e3810cso571219a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748395071; x=1748999871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6B+nYzf84IHBefVZETAwG/YFI4gdFTyep9QFw3LkD0=;
 b=WuSbc8Rj8iXrLoJekXFB7DUz1ZZ1RRBZt0JFapXbs3Me5m1MQo19aSXYOgl+8fFRMo
 vrcOE8/lKT1pth6PxImKpjci/0R5mgV7qtXnpYjpGIfxeoX3Q1rog6woOXjqsQqG9NlT
 y3oaKp4VeHYP3B4SUOreLW57AfLgb4Kz8UTFYDRMPuIRxKIv78UgA70G4318jhxE1DLA
 y4lqgVlrUMSwrK8TbquP1vxfzLQtBmp0smER5eitRXocHFfq2+XnxQslhNBIvCrTjYbX
 6BxPe1zjQLpAifaaEUw3cQINBfLyU0ubyw6eBGahqpcx5em7r8OZ5NBCLlj+qdU3+2x3
 vCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748395071; x=1748999871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6B+nYzf84IHBefVZETAwG/YFI4gdFTyep9QFw3LkD0=;
 b=tWL+RHVqP6d48FXdz3flnyt2AYAUOf7vSef9C6mfGecoXBh78qiwsGTRlqqmDrOFD+
 vqZtBc0CVbKDpWWm0VWTxvVxH64uXuhlL3tw1MCuJrZHAZ5GrhTIquaI4g27mc++TSLH
 9gH2i88QSGZ2Hg/NGJ0oj5DeVqZBkZsLb+ZrMyEPlD3koKinYoGCFGps1R+gl0kf3F25
 RZgtzEaKjzFUNYVUsXcQ73h+g8DondV+k5Zhf4mp82Ox24Fe+CdYHzT3mbgijXqL7Qyf
 OlrrjI0ewf6HqVyGcrhiBpgOUbz8pocITjdjwhqnJBaNcQ1i4grKvmMcmf2LMDe44K3D
 mcXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWSMh64Uz0tblmPPmOrT93P9aMY6DDVJ6Sha5aGDMvMj6INwBbnJ7wclblEpNz64nySpWvJ5xm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT3Du5T40oEMahZmEvHtH4DWzNqlR31SDi9KKycOr4MpHHClS8
 OBTd+IIk2Ozpz89ooedTBTYiqXfi7cPoVINkrm7X9laS80dul41aevceF1Dg8yDKf2GqiB4W/Qf
 zHdQERjABH1cgdA9xSDNSQiYhou/k99t+Rg==
X-Gm-Gg: ASbGncvIjCxBbKdQGFxux2DonZalzCtYHEWzV2rafgTq2voBr/elXvFQ+yJxQRQpo0O
 ++g9S9m6dQqJ3YWJzft01Zh/kb1bOAlBBLS308DlusqQNoi9493atMiTZw8neP2UUCCJfUmlKFt
 /aWVoASklnW/lDzqRkb+FKv/2KI8g2HIyw5w==
X-Google-Smtp-Source: AGHT+IF3HbKODi4yxUaYokt07/yyF+35w1XJexPU8W77FhlLjyKgiUJKLngj/dmM2cAmmRALglqx7NSaMVqUUDSvNO0=
X-Received: by 2002:a17:90b:3912:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-311e1813502mr468877a91.3.1748395071356; Tue, 27 May 2025
 18:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <20250522215559.14677-2-alexander.deucher@amd.com>
 <ifaonlhubwsgbz3xxbkyqhyttuebk4ro2u2kpzrbrvcuhqdgch@zkyr7xci64rv>
In-Reply-To: <ifaonlhubwsgbz3xxbkyqhyttuebk4ro2u2kpzrbrvcuhqdgch@zkyr7xci64rv>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 May 2025 21:17:40 -0400
X-Gm-Features: AX0GCFvY_y_arVEfc_h7w1MZeSFmjZP3DtwZzR2ou7jaRPsvztJ29ba3zI2cfj0
Message-ID: <CADnq5_NqP=2fSidf9B5DY9u3doeRV2cohQDZHRU1EJuB4=FCRg@mail.gmail.com>
Subject: Re: [PATCH 01/10] Revert "drm/amd/amdgpu: add pipe1 hardware support"
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com
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

On Tue, May 27, 2025 at 12:45=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> On 05/22, Alex Deucher wrote:
> > This reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.
> >
> > A user reported stuttering under heavy gfx load with this commit.
> > I suspect it's due to the fact that the gfx contexts are shared
> > between the pipes so if there is alot of load on one pipe, we could
> > end up stalling waiting for a context.
>
> Is there any mechanism to check the load per pipe? Debugfs? UMR?

We expose one queue per pipe, so you can look at the outstanding
fences on each gfx queue in debugfs.

>
> >
> > On top of that, disabling the second pipe may fix the reliability
> > of vmid resets.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519
>
> btw, since this patch addresses an issue with Gitlab, should it be sent
> outside of this series?

I don't know that we ultimately want to apply this patch or not.  I
was thinking it might be helpful to address the issues Christian saw
with his original series and I just kept to reduce the possible
factors involved in validating this.  Ultimately though it's a trade
off between parallel execution and sharing available contexts.

Alex

>
> Thanks
>
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 75ea071744eb5..14cbd1f08eb5c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -4781,7 +4781,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >       case IP_VERSION(10, 3, 3):
> >       case IP_VERSION(10, 3, 7):
> >               adev->gfx.me.num_me =3D 1;
> > -             adev->gfx.me.num_pipe_per_me =3D 2;
> > +             adev->gfx.me.num_pipe_per_me =3D 1;
> >               adev->gfx.me.num_queue_per_pipe =3D 2;
> >               adev->gfx.mec.num_mec =3D 2;
> >               adev->gfx.mec.num_pipe_per_mec =3D 4;
> > --
> > 2.49.0
> >
>
> --
> Rodrigo Siqueira
