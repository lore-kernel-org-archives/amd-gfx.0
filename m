Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FBBD33992
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 14:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C1A10E4C8;
	Mon, 28 Oct 2024 14:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uz3hcqmk";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DB210E4C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 14:41:53 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-71e702c0ac2so274426b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730126513; x=1730731313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=la2exHew+hvO0IJ9e81iOlO6I5GJ9Cfsj+BaSXTZCp0=;
 b=Uz3hcqmk0AynEKvCyXPYKyF2q++pmXqG1W9/lLgauBc3zE6VVMxlhSfVkACVQZtQNo
 nwW0jtqniDf8/xfU2SgLl4E+V5OyczyHBCM5S2RB7mTSw3Q2KmmZrUBTkOBM8SJLhpH9
 VvAkMhm3K79nL2CmCP2IMoAkprHyzshSUFbu0pq+wbfRQNqUBLB9eoN005/Uu/bvxiT4
 xm0vofikbQsGlrLyVqccKhysfQbcmK+u29O7fG4jBtxlDKIGlAIiRqywl1WH8iZq2+CS
 N8lwM0ZJw/9mXT86YC88SvoodpCqO0t9KJC8C4cv2I+lVmHIDwlniV+P04B4A7ldINnu
 fVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730126513; x=1730731313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=la2exHew+hvO0IJ9e81iOlO6I5GJ9Cfsj+BaSXTZCp0=;
 b=SqpH9b88OFE4J19KjZP02rQe3nUGmkcoHQmtC3M6hdaa1LK5k/zWQ3didSGMX6uU4M
 cIyEj53/XUTs+3N7b8/TX43H+DBKHVpyirXsACOuXeYxfAW56JMBh8Qxli7wjzN5Fctw
 67KlkQTlFRqiBaSQkjwzHqmTOZoAMj72xKlxmGvaCwq1/uHueeFmqG42EpDysLRCNWgt
 N6RLuHOqh1MY9AUhvoV+rOgaC2PhNJW6YM0jDVPSw5f5YrapsqCmESdMqVAZYSlce3r8
 eZyCku2hG+2IUdldl8TF2uTleiazTwAvvTApdW/gQSq8oO1V4/mtXlWvZ6+awHf0NaZA
 wMEA==
X-Gm-Message-State: AOJu0Yy3zJz8i8d+0PTfpTjcEzq0JPwX5wZ4/VJhoPMF2Yt0+of87DxY
 NbL6KznKiCUMjt/ItmViVuuPTD1xPuZm8Kmjb1phKBkDnmL/79JP/cJmEJSjPfEGXCJL4DxKZlk
 rNk3LoXodRLDooHH7OSo5qcPMBTtL+g==
X-Google-Smtp-Source: AGHT+IFVvVYYO4bzeUQQ6YeNY6QzFp1DUBSyhauLCuNhRIKtvvqRRbYeFbi4lzAjJk3CtbisJ/4JWkLnBb9NKRpZHrU=
X-Received: by 2002:a05:6a00:998:b0:71e:5033:c6 with SMTP id
 d2e1a72fcca58-7206303212amr5265185b3a.5.1730126512674; Mon, 28 Oct 2024
 07:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241015181541.2457526-1-alexander.deucher@amd.com>
 <CADnq5_NHmJpZLbbrEsN75gkLOctFtS6nyNBHfgM-0=EpdyKFcA@mail.gmail.com>
In-Reply-To: <CADnq5_NHmJpZLbbrEsN75gkLOctFtS6nyNBHfgM-0=EpdyKFcA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 10:41:40 -0400
Message-ID: <CADnq5_MAExjgh8xYzfjSPxFUYV-17Tukh6DgH41ba9t6Pe8EoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add ring reset messages
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Fri, Oct 18, 2024 at 11:47=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Ping?
>
> On Tue, Oct 15, 2024 at 2:28=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Add messages to make it clear when a per ring reset
> > happens.  This is helpful for debugging and aligns with
> > other reset methods.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index 102742f1faa2..2d60552a13ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -137,6 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >         /* attempt a per ring reset */
> >         if (amdgpu_gpu_recovery &&
> >             ring->funcs->reset) {
> > +               dev_err(adev->dev, "Starting %s ring reset\n", s_job->s=
ched->name);
> >                 /* stop the scheduler, but don't mess with the
> >                  * bad job yet because if ring reset fails
> >                  * we'll fall back to full GPU reset.
> > @@ -150,8 +151,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout=
(struct drm_sched_job *s_job)
> >                         amdgpu_fence_driver_force_completion(ring);
> >                         if (amdgpu_ring_sched_ready(ring))
> >                                 drm_sched_start(&ring->sched);
> > +                       dev_err(adev->dev, "Ring reset success\n");
> >                         goto exit;
> >                 }
> > +               dev_err(adev->dev, "Ring reset failure\n");
> >         }
> >
> >         if (amdgpu_device_should_recover_gpu(ring->adev)) {
> > --
> > 2.46.2
> >
