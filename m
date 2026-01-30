Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E4AE6BF2A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 16:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8088110EA10;
	Fri, 30 Jan 2026 16:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FFA2tdgA";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4407510EA10
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 16:25:37 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2b7063004daso67346eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769790336; cv=none;
 d=google.com; s=arc-20240605;
 b=OfQcBCkx7qDPGhC5Reewm5H+1XRw2iihBwoMe41gl9s4OJN/fFybsa3K5/COFK2vGm
 7I5Xt+FDCWbznBKb9J91/uY9tlRHji8oOaUXAeSGemyE7LtnIRrUL9QLI66fAtuUVzUJ
 dDsLkMKT4I5eKVrgXxL7nTRektOpg9euQ7Q/cZbQgyVJFn+2v19mog1RIk8pY3yQAibq
 yT9c2Zzg9hUZHQ4jMYAjCWDaLtZkylmPdOKHJqocJnVL3y3sL+rplvCMAnBozzQxMqlW
 KNoSpjt/20lE1I4xAcGlAvE+4IgW5Voi1yBsqw9Gr1EuqCCQhfCat9sDVFOSS7Y+K/Rb
 GhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a3trjabmg4o4pm8r1n3GSUbGmKD+cxOTMkveYcpy7cU=;
 fh=UuvBzMRYuX6fMGJO29znqmCDRoKu3egb6vo7fqFxzZQ=;
 b=WB6CTg1/jtHMnNLHJ82nusHK4eABrTxfayVJeSuNZMH5COuoqrfb8MHPC6w1PPqYB+
 VS+hNL3YDl0m+6saS+HeMnxzHuKPhk+JGuFgreZGl0ak9aFqxaZgi5VxcrclAw4O3H4J
 28TCGSyVNHJz4x8g0Lem5/wKeYAkhKViMse+C7y+rQ4z788xODFWEycMK7mevUMDdqec
 rWm2Wi+Qbdo90Xt0oL9uvNK9gkP0M+AOcznIeEK6T28LXoeTfsxuA8wJ2zo6m0pi6vc4
 FcMMYofwKtLPVJ/6lR6JWcBCQkTgFH9mmfSw6yicyW80T+B+Sf2IEJvvDr34YbYaABln
 kkKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769790336; x=1770395136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3trjabmg4o4pm8r1n3GSUbGmKD+cxOTMkveYcpy7cU=;
 b=FFA2tdgA4CusQGwAeho41m/QVDNi02vgQ96f2IeeriJqWu8otuP6myjczEhwSGC0d9
 j+yepi+Ap0bPCK9r9CQx3lZQ0fibkPLG02o0EjzkPNG+wVXU11/M0xOmFyircaKXPb+g
 NdZWVj4ILecNB1livNDZ+3TcfckgdO5HB5TwOQhMW1f8S/z9auVEZXyAeildoXWXi+he
 UmOaAAcx2oTSzEBPsLkRBmiYgaZd76178f56YGm+/j8aq2os1jsw2on4QVKCQc/B1zlg
 6QKjRVGpIa8//nj9r/3G7jSOrGsGln5N70O0u5wjZate94vQ1ux5PEyyprc1iDmCeK9u
 WxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769790336; x=1770395136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a3trjabmg4o4pm8r1n3GSUbGmKD+cxOTMkveYcpy7cU=;
 b=wBSx533VV6GF75MUdmadATH1VjZYqhoF57VNsnb5+nBuE0knpMmy/9E7pcZ/NILtyY
 9O+RpJ0idkXK84su5g1Nfei7UKM582OLF4PoF4EHIMJ4nPVrHg59QcmYYJMXVe0ZkR1m
 RDxTRM+C2t1blTyyUVpQTvxZMLtlIGLa1ZLhYF2puXq951ayXhawceaEQFG/DViaIWXP
 6zt50Le7F3O73aVptRKkqkd8aEjK5HmE0oNpyr934HKSHMuqO5zKSuYlaH7TsN2YYoBm
 ZFfJeVM0aUBh37mfnLKtvjVjuBa/b6bOFPLIyJ/2jtffznBhFDYs3xLEAb3BbByW7S3X
 bZDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvwhHBbEC/CuKLnA1J21n7KTSW791nO53zxXvRO2xs4dl6DqlvQVpV142lUtxNqIho6blSNVix@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2DXKViDlw3xgn93kRm0Hmn2ej9imBLI4jdBQhsaPdHocl5aBM
 jbROGlw1sDcFGKUozvbR+eU6GgJgMpRIYMGTm6fxCYtAFoQGoPiuOke0boIBoxmacPheIr1hKf0
 PMzO2FfGGFil5DVJYffaTdrz6xak+f8s=
X-Gm-Gg: AZuq6aIyk6Ns+NSvYDwSZg6Vd/D3ZNElOK8qRPepwNew9nS2puEYQhQMAk06n52zWKQ
 M/mqq2K5wcxqxw4zArP9UUVGtljVnKJnr8/lUOH3KA8BPq3TQwJQrJ9e4KmjCPxlXWNslIjQ28v
 p3A2raHZjPfleJc8gLCf7ojzSe4iUYZslduo5szypYC3IsVXuAbll5WKQYHTHdtL2Q/fZRa9phw
 3Sxgc+LzztEDzv8QW0NIKobwX2h7GJ2G94HXfxF0Yi8zTfKkfLjw1x0VicJJgR/EEamMRs/
X-Received: by 2002:a05:7022:3b02:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-125c1003434mr725725c88.3.1769790336293; Fri, 30 Jan 2026
 08:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20260129203731.21506-1-alexander.deucher@amd.com>
 <20260129203731.21506-2-alexander.deucher@amd.com>
 <e8bbdbef-8d34-4465-9ad1-aead5e1f9361@amd.com>
In-Reply-To: <e8bbdbef-8d34-4465-9ad1-aead5e1f9361@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jan 2026 11:25:24 -0500
X-Gm-Features: AZwV_QhlUnZ5prMj1K_MqUcPqDbM-smVuTV0SsCrcVupv-XTrdnx9Kb4RB1IsQg
Message-ID: <CADnq5_OczoBiak=MP0dw_3aLLiO4_R__rJz+iV6XnDhYXqCp-Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: re-add the bad job to the pending list
 for ring resets
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Philipp Stanner <phasta@kernel.org>, Jesse Zhang <jesse.zhang@amd.com>
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

On Fri, Jan 30, 2026 at 10:30=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 1/29/26 21:37, Alex Deucher wrote:
> > Need to re-add the bad job to the pending list before we
> > restart the scheduler.
> >
> > Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index aaf5477fcd7ac..9b10470321be3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -135,8 +135,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout=
(struct drm_sched_job *s_job)
> >           ring->funcs->reset) {
> >               dev_err(adev->dev, "Starting %s ring reset\n",
> >                       s_job->sched->name);
> > +             /* Stop the scheduler to prevent anybody else from touchi=
ng the ring buffer. */
> > +             drm_sched_wqueue_stop(&ring->sched);
> >               r =3D amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
> >               if (!r) {
> > +                     /* add the job back to the pending list */
> > +                     list_add(&s_job->list, &s_job->sched->pending_lis=
t);
>
> This is explicitly forbidden by the scheduler maintainer.
>
> So we seriously can't do that here.
>
> Correct approach would be to return the proper code to the scheduler so t=
hat the scheduler does that.

Ah sorry, the tree I was working against didn't have this change yet.
Will fix it up.

Alex

>
> Regards,
> Christian.
>
> > +                     /* Start the scheduler again */
> > +                     drm_sched_wqueue_start(&ring->sched);
> >                       atomic_inc(&ring->adev->gpu_reset_counter);
> >                       dev_err(adev->dev, "Ring %s reset succeeded\n",
> >                               ring->sched.name);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index b82357c657237..129ad51386535 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ri=
ng)
> >  void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> >                                   struct amdgpu_fence *guilty_fence)
> >  {
> > -     /* Stop the scheduler to prevent anybody else from touching the r=
ing buffer. */
> > -     drm_sched_wqueue_stop(&ring->sched);
> >       /* back up the non-guilty commands */
> >       amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> >  }
> > @@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring=
 *ring,
> >                       amdgpu_ring_write(ring, ring->ring_backup[i]);
> >               amdgpu_ring_commit(ring);
> >       }
> > -     /* Start the scheduler again */
> > -     drm_sched_wqueue_start(&ring->sched);
> >       return 0;
> >  }
> >
>
