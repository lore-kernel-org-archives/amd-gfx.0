Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5DFD30CC2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 21:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C03210E54A;
	Tue, 13 Jan 2026 21:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ply9nB/3";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778DD10E54A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:27:44 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1232de2e2c6so41164c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:27:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768339664; cv=none;
 d=google.com; s=arc-20240605;
 b=K3Bds0f881Zmxb3BFW9o1y2K/gO/CqyFQ3ZGHgq1Y6GmpgiOlkppZ9k5zNg3JCcNiy
 DHDODR4HEUT/YWGrXXVExhCQ/VCB8DybGdyr+IBw2OVCXbTqeS+jgXsEQVPl5uY4n5de
 HoRH0j0O5FDIXN0RovIPWO80dddwUdyT/YByWtXty6bOzn93V6XGL0REGEv0Lm0eKND9
 5r3hoHVRWDrkHqdax1iiHTxEEdSGI38YdVRmdw8R2DCeyLOq5ND6gcY4gmK1XoJkvPE6
 AUVF65pT+axpEJhnVn2BG27u+awfu9Eyukoi3ncAmUgAt9s30ziEG4d1exO8jxwN2LOG
 dhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=58BsIDrICp+NodFaHir3wcHXJQ/3Dx9pD67mgXvAbWk=;
 fh=iccpKRTaQZzl4OW5ogxxwrDEWvn+b36IQOED7deNc0k=;
 b=X1iuSym5LcXal5TmEUGbVBFl/BuvEtxTxXQSASynJW0qI0xcrEuC3YkpBDuJa0MQJF
 Mb8fNiJcowsKmIZOP2XsQprEyO5uwtkgAjbzQh05NdV+T6f2MfQvlffv0M/o5eZDbQ6W
 M2BNBWqIA5JyII0rOIy2IfOqpBj53R4mJavBV037ZhPpUdIYpcIBELLvvsNsUd/++uQZ
 mOZuURWWdW937jiiYhH8EHlmB2cvshwxPHG1Stb/LQgs9JUd35T3K5KsGnbamZ23ioII
 6gASJ/fF3adSGlpLSjA2H7Mp+bd9eoFxFS/MPyAYHtXPtu6t2Nk7LtmwxAPKU9Xa3NlT
 2LbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768339664; x=1768944464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58BsIDrICp+NodFaHir3wcHXJQ/3Dx9pD67mgXvAbWk=;
 b=Ply9nB/31vB+sWGSgssEZaYe6iW4cGZ5p4leAKIDdfEsgjZ9l53rTYjDPw6fn2BxnQ
 Ce8+VET8kE/uBnrLfOThc68R9WqccbdwVLGMwlN1rgnY3hxXCb78o5oAPdlT+jdrn5Sf
 bcxrMkcDqQ7jDB6hfUviVqm1kS57ZL660mhge+T0AmyDfFRqbsSg2y6iKFfB7MzNyTy/
 RDUT6b79UovA3nUku5YIE+puSNyd/kLEmhCdpEUAIYRADOrqiKfag/DlLYBjJp4ndN5n
 JAyYo4qqVHt2KUO6WowOzqyFe9RcWmqFvr7Mih626r1ipCLdggomm0OGT8lY93PUcGXS
 mtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768339664; x=1768944464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=58BsIDrICp+NodFaHir3wcHXJQ/3Dx9pD67mgXvAbWk=;
 b=CsK7R4JrcY6Pyk4ZeV6JujpfWszs8MgaKT56M3LzFywYfuyOLO4N1Z6nOj/1j9wcCS
 vPgqjLAa2CATlGUAp13hOD9qNpvE6FQiErj4gXV/d/M8gJAQ2BW2ZdkeLkbtxa4XdpGj
 viFhrNozxRRU19JU6yUXkf7GWmaoZwqlwKbj1vgJB9KfThNlzAXldTN2S+56F7rOhep0
 eSpX+P8zi5Eb0VheSkV6XjIPnDhFwgrnR85gcZTAIiLLTUjyerXCTkbmVf8u/NpOBmkp
 fkjSBHgjJ0w1u7R44CqQR+xFIg4J0/BkoYTriosBSxzEt6nCvCCAP+a1SUm+E9WvNqIs
 yQHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5jiKijjusjpnSmOH4NivPq3a7mibvORW+UH8yBncl74x7YlKnlpnPOM0raJsQtYpOnecVqXS/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEyIS98C/bBfRAwbMLjaIUjckoDPMIpvskthrCz8+XInOmiw45
 5sCPeAGj1PIj0gxN0BR6AuFCLIZ3tjBQVDVx8Z6DsfY5JQMhWl/GKSCLkfCgqQDI/1ZRNxPElsL
 6/OjJt7kvXJm2dG57HlMO3AW6rdxo3QQ=
X-Gm-Gg: AY/fxX6Y/P2AGhX62e3SU57DX0IyWpkHGEGSKFi8pOvUtfGxwzx+KAfctIWeoYrpMHu
 SIwJt0t+Q6mpOS6Aqd15XfmoTmMKyZj+BEovLJjRmdcT70U8kCw+o2wj7Cbz463PEnmEwY33ypj
 VayrpIVGpTGKi4PH9h4O5xdQduLXHO8kz26jQvM+Qw3h9MdYrTZZSnk0k0QhHd/oyq/MRWLvzxX
 TiDJgBgn74dhEhaXC9cNeab8agSxsEaGCeFVFhhONaNM+A/NO3EgRU2c8rWWnYjMFS7fV9R
X-Received: by 2002:a05:7022:7e82:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-12336a96a3emr167834c88.3.1768339663628; Tue, 13 Jan 2026
 13:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-31-alexander.deucher@amd.com>
 <0426aa4f-869c-484a-b057-a4877fe3d26a@gmail.com>
In-Reply-To: <0426aa4f-869c-484a-b057-a4877fe3d26a@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 16:27:32 -0500
X-Gm-Features: AZwV_QgmxDegpkhlI2eqTMxm7PjwcibDUMlbGmoYO2JqGXinSXSO9ami9Apl4vs
Message-ID: <CADnq5_OA1+hpGFUd1=5sorUKjCK0hYcNPoZR11n+6D67NycjQw@mail.gmail.com>
Subject: Re: [PATCH 30/42] drm/amdgpu: drop drm_sched_increase_karma()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Jan 13, 2026 at 8:42=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> On 1/8/26 15:48, Alex Deucher wrote:
> > It was leftover from when the driver supported drm sched
> > resubmit.  That was dropped long ago, so drop this as well.
>
> We unfortunately still need that to update the guilty flag in the context=
 so that amdgpu_ctx_query2() works correctly.

I don't think it matters?  We don't call this for per queue resets and
the errors seem to make their way up to userspace properly.  Maybe it
would be better to move drm_sched_increase_karma() into
amdgpu_job_timedout() so it covers both queue resets and adapter
resets.

Alex

>
> But we could change the code in amdgpu_ctx_query2() to check the individu=
al entities for error codes instead.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 868ab5314c0d1..c9954dd8d83c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5808,9 +5808,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_de=
vice *adev,
> >
> >       amdgpu_fence_driver_isr_toggle(adev, false);
> >
> > -     if (job && job->vm)
> > -             drm_sched_increase_karma(&job->base);
> > -
> >       r =3D amdgpu_reset_prepare_hwcontext(adev, reset_context);
> >       /* If reset handler not implemented, continue; otherwise return *=
/
> >       if (r =3D=3D -EOPNOTSUPP)
>
