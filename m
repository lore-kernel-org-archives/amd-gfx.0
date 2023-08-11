Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3E6C001DB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 13:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FF110E0FA;
	Fri, 11 Aug 2023 13:46:15 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42ECF10E0FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 13:46:12 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1bbf7f7b000so1518179fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691761571; x=1692366371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0HlPy0cDnHyBBdwwy68I9gaziLuZrx9om5hUBEE8a0=;
 b=jt3t8Y+euDPTXvVoLjMtvnrE9zqgrV7vKIoLNRQa27RPgxaeHt2cLsmlm7megxp6SY
 EKekQD68zjA6rVNEBknKFbCQTwKwkxDJiEF9o2DZD8mKGbnqKBRK6QK8xMECiYBnbVsU
 NA2BCL2Gy+Qpypgd+rAOG+JveaNOd/7hc2398hTv+ZzxF6n0CeebBh35QukKhc1w3h1C
 hZPWFzumMPg8FfaVyYc+/WbfX4+jNvYcB7TLiomemnEHusAMhUyUg3R69BUwRbVjLu2B
 ke4kPEl5LIvkU6jZmBb3JyeOL6pIaJRJRtN0OIaJVFWaPyG63J8mNFuYspaSgzN/uA3v
 X/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691761571; x=1692366371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0HlPy0cDnHyBBdwwy68I9gaziLuZrx9om5hUBEE8a0=;
 b=ddphQC9o7un/2ukgOaPwH6oA8AQdqDJAbk6269ETwIIXdUl8eU/Fzo+r06ZfEmbEtd
 QAq/xrOrsuqk0yh9QBzSJh+QlFVUJnfxfNjYz1bbmJOnpnPIZvajPlqiA9SeKui2/7pc
 Dq4ZB2GplVrrFKo2YCZJ3tTScX6qh9IPtouJrmhJgunEr8yx/5F+FN4cFmCb7KpjzxCv
 LWGkDj5hgT3fchd/Ob3sCzIipvCzsUHf3By6OXbXppRdDaMP2VkrG0YpbZxy1Bbtf3D+
 ZclGAjr44QODOrJxsyIQmydtL9jbyV7ozpoR2IkRhXw3/vOkWsrYeB8c/KZV7wWIgFPc
 wSGQ==
X-Gm-Message-State: AOJu0YzLZBLM9pH8A1ug2PFMKpuWDkLlxiCyphVcZzt/bU2MXWAQm0Pc
 pyS2hFMlJM7x67LSsYT8VwLG4efvchm/jQSg+HJLQDDK
X-Google-Smtp-Source: AGHT+IHZ1UWLcR1+z65ASbC/x8dXnz69ObZjTpHs4bwSTgEGijACgwH6ELtSXb1pONtKsMPYBdq5ifK4V4L1umpCe8o=
X-Received: by 2002:a05:6870:4344:b0:1ba:466d:5f9e with SMTP id
 x4-20020a056870434400b001ba466d5f9emr1491801oah.49.1691761571286; Fri, 11 Aug
 2023 06:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230809190956.435068-1-alexander.deucher@amd.com>
 <CADnq5_P3FJN9h_utnm-yHFDKD_bUR5bUhwyyiuLgaGkzFXsQbA@mail.gmail.com>
In-Reply-To: <CADnq5_P3FJN9h_utnm-yHFDKD_bUR5bUhwyyiuLgaGkzFXsQbA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Aug 2023 09:46:00 -0400
Message-ID: <CADnq5_P2GPH7EwxEozJznAcC8cEHbDQorm6PK6vAy1t4U02uew@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't allow userspace to create a doorbell BO
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Thu, Aug 10, 2023 at 11:20=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Ping?
>
> On Wed, Aug 9, 2023 at 3:10=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
> >
> > We need the domains in amdgpu_drm.h for the kernel driver to manage
> > the pool, but we don't want userspace using it until the code
> > is ready.  So reject for now.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index 693b1fd1191a..ca4d2d430e28 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -289,6 +289,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev=
, void *data,
> >         uint32_t handle, initial_domain;
> >         int r;
> >
> > +       /* reject DOORBELLs until userspace code to use it is available=
 */
> > +       if (args->in.domains & AMDGPU_GEM_DOMAIN_DOORBELL)
> > +               return -EINVAL;
> > +
> >         /* reject invalid gem flags */
> >         if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> >                       AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> > --
> > 2.41.0
> >
