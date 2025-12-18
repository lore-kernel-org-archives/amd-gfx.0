Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C77FD6E2AA
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 15:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2A510E8B1;
	Thu, 18 Dec 2025 15:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmCVEfNS";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A9410E8B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 15:41:54 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7b8c7a4f214so32863b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766072514; x=1766677314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1Pz0IVrfCAlgi4LLVc32kCrFxP69/M85e7WfWqedCI=;
 b=BmCVEfNSy4L80clZoKECW5PFgdZwC7IAdXmaEIgjiPyukN1ql4qY1x48P5mzs9wdPA
 xsGwbKrNnYXyICFmUJrW6BttrqjYoSx0GvigjAENTz97rCHlrW4fZgaGFkLMsRBIOIrr
 U0kSDEoBRifQIIcADdiNO6SPoL9IS1iIrlNCdIPNWrAeHA2isUBJWMh8qIO9wwxnOVRv
 /AK60QANocb0Ze8eTQbS2yXwmGXU50Zs3aICkWYTU9fcE7iSdjhi12Hj+aTzO/5DChim
 2SE5CK6owCX7HF5jHLCwPvcIY1CTIMKrHe4ueXgLBUvq120l9RmbLDsk2Oqhw9asxqFb
 72hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766072514; x=1766677314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l1Pz0IVrfCAlgi4LLVc32kCrFxP69/M85e7WfWqedCI=;
 b=iz5IaKFJsj481rB3UHxvm9UYIPSZifZzsbhpm5i05qfrnpHEhDl8mg8UyBibWtVT/Z
 8pY6OaZnNQKJ/94lrxjnEGlgpb6pTcLHhw5aUwLSFMVNm7j6YVCdOz+m+zTKJ7FoYbBY
 oNJgEZL711ODKktvPuiBaFU15mJFDro3RyrX6VtI8/dvK4O0KL+E5tIFP+UfsSrBuUgc
 zEg7zr2tuYMEe9mwbyJmhyyXo29TS1L/Ug83eQPz6fPA0HuaD8J9OwpDiJPFitHH0LiG
 NSZnL9CUKKPd8qLd+lQU8jAj0yHm4gBz/SfijZNe2PFIO7CVNZCcXKeJIDuDeAQ9pcj6
 8sxQ==
X-Gm-Message-State: AOJu0YzxmPBdK8oEFd/MucXKF2eZN/iPNjsSFyK/hylRw4ocTN0gtFTn
 L3TVXgiytUs5YNTygGv5tfe52ZWY/MyNiEa1jWgmStWomTmzf7wiXLAuO5kodAE8boHfobZXTRN
 SCAcP6528XhfKXjPjNQ5qZhs7ztGG+PMSKBEM
X-Gm-Gg: AY/fxX6Q7bXTjBHOIpKoBJDOwR49XssZ9Toh+EFZTSMiTE/WoDZgAW8gwbe4B9WBhVO
 6opw3tbJ9cPDarsb90/a4Ljbyh+hDkeoTIYmxOgpwrBHam7Grd0L8LT4wvlMsFFHz7omsvghm7Z
 V0rqw6gWSyGGvoDo8kWrCn0utA2bxwe8crD7rlD5BJzIQdkBVLTCzs0BS0uIoREkNIzX50ujbXN
 PDpvi51ufgvZK5QD3HLImUW/ajtFFBhf8UFamooSuo+dFgxoIE+yewzGzbbvuN3czCgjNoP
X-Google-Smtp-Source: AGHT+IHbT2peNtf214YZv04ZUqYtJNQ5p2jeuhsixm8KCJ1uW8+avFUwXt3b3YylxHMAHnP6j+Lx1SsiaOSdXf3OJ8Y=
X-Received: by 2002:a05:7022:1e05:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-1206289ff38mr1615835c88.7.1766072513700; Thu, 18 Dec 2025
 07:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <20251215160711.11832-4-alexander.deucher@amd.com>
 <6025413.IbC2pHGDlb@timur-max>
In-Reply-To: <6025413.IbC2pHGDlb@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Dec 2025 10:41:41 -0500
X-Gm-Features: AQt7F2ruwpEdPVSpEr9f90KnE_mo2X3IEOVVOSpFozGN6pSt3RAQOLIH6KzxZkY
Message-ID: <CADnq5_PABibVsM+d7UtLcRwDKo+O6thYTge__X3eCFd5u3H0nQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: avoid a warning in timedout job handler
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Dec 18, 2025 at 12:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On 2025. december 15., h=C3=A9tf=C5=91 10:07:09 k=C3=B6z=C3=A9ps=C5=91 =
=C3=A1llamokbeli z=C3=B3naid=C5=91 Alex Deucher
> wrote:
> > Only set an error on the fence if the fence is not
> > signalled.  We can end up with a warning if the
> > per queue reset path signals the fence and sets an error
> > as part of the reset, but fails to recover.
>
> Can you please elaborate why this is necessary?
> I don't entirely see the point of this patch. Why don't want to set an er=
ror
> on the fence when it was signalled by the per queue reset? I would have
> thought that the next patch does that, and also fixes the warning mention=
ed in
> the commit message here.

If you call dma_fence_set_error() on a fence that has already signaled
it triggers a warning.  What could happen is that the queue reset sets
the error on the fence and then signals the fence as part of the reset
sequence.  However if the queue reset ultimately fails, the fence is
already signaled and then we try and set an error again here as we
fall back to adapter reset, triggering the warning.

Alex

>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c index
> > 67fde99724bad..7f5d01164897f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -147,7 +147,8 @@ static enum drm_gpu_sched_stat
> > amdgpu_job_timedout(struct drm_sched_job *s_job) dev_err(adev->dev, "Ri=
ng
> > %s reset failed\n", ring->sched.name); }
> >
> > -     dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> > +     if (dma_fence_get_status(&s_job->s_fence->finished) =3D=3D 0)
> > +             dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> >
> >       amdgpu_vm_put_task_info(ti);
>
>
>
>
