Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C572C3F2C1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15E9246A0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6Ig9Fxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15E9246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779F76E59F;
	Thu, 27 Feb 2020 21:30:23 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525C86E59F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:30:22 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id t23so1067871wmi.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/0JLOivn5V4ZZyMgJUqssyf95hWvHjz22lsLXeZJVTk=;
 b=h6Ig9FxkKQhGKDtqes0oaOC6D0BJOmT6lPAeyn+QOgMx5xz8jnbRnaytfuozZTdgqx
 tl47tX9Ame8KkgjpLbW3ZuaZYpDJKKUL1+9fITdeEfIf+Ln7xRYU8OAjpJzNs5P/49R7
 a/WZ06O3UVNU6V8s3FPVXwMGSFeVGkrg7+tlyBEvfuIi1O8hf/43d9n0ea82FBg3QPA2
 15+bXAKZiak+vD4Viqi2NYH/ghlpp0sjlf+5xRoncdGXEljiSbjIJSRmkDeN69Hf+1bc
 Wkx6rrOKDUJHotHGCrfKFbCNBaRUhC6ml4TLUBY7q2mqeO2uUfyIUSyaaL1wSNq7CbSi
 IBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/0JLOivn5V4ZZyMgJUqssyf95hWvHjz22lsLXeZJVTk=;
 b=PIm/t3+4XQa0MAbjAhtkVNT8ED8ORFYn1YWwqvazbLAg8tRrr7q0Jk4QvIDY0si7kJ
 3Q1VQ5lQcn/eRok91WOq8fuXK++2FZEQM6LzGp+zUrnIXSc6HrIsAArByoThxDJETJkI
 H9omZ9TvSCFy3ZfVlarEnUWCel7gfWAZ9eyQ6N8OutD0lTV1S43q7EnOuDCHZwmXTKzr
 nWOeGPYmUBsLL8gtGL639/SWSAUOYWVYImWRyq+uRVGnXh9u1JEXMQvQxeMrBjqn73PC
 EFtXo44ix5lPQH61JzFDxgug0kLQUCxNMxb9RuTgn0JchwePPLo/4jnb0yzoTfaJAY+A
 3XKw==
X-Gm-Message-State: APjAAAUZ9cWh3JgneRctKh88zqsUJ6YurXa8KRjZdvdnJxUKbe3gjfhd
 3tK4lbXYbXX8xh8eEz6W32Of88NjRRlOChQyf/g=
X-Google-Smtp-Source: APXvYqxMDcptoo0MQg0Ogsjc/e7k9dhWf9TlrNEZp/0hbDjmP4cvyYNWgB5QIaS9ByKb6jZdfGiK8MftNMN2IlIYwmo=
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr737228wmm.79.1582839020799; 
 Thu, 27 Feb 2020 13:30:20 -0800 (PST)
MIME-Version: 1.0
References: <c062930f-d9bd-bb7b-e75a-3e5b4e0c7de4@amd.com>
 <20200226223903.6088-1-luben.tuikov@amd.com>
 <20200226223903.6088-2-luben.tuikov@amd.com>
 <20200227115647.GB13364@jenkins-Celadon-RN>
 <bb5c3ef4-81ce-d129-bbed-99133c8c602e@amd.com>
In-Reply-To: <bb5c3ef4-81ce-d129-bbed-99133c8c602e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2020 16:30:09 -0500
Message-ID: <CADnq5_MEiEkXcif17pTbRys+O6RPrXf=ksTy9SdH3gFwULyrmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix per-IB secure flag GFX hang
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Huang Rui <ray.huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 4:15 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-02-27 6:56 a.m., Huang Rui wrote:
> > On Thu, Feb 27, 2020 at 06:39:03AM +0800, Tuikov, Luben wrote:
> >> Since commit "Move to a per-IB secure flag (TMZ)",
> >> we've been seeing hangs in GFX. Ray H. pointed out
> >> by sending a patch that we need to send FRAME
> >> CONTROL stop/start back-to-back, every time we
> >> flip the TMZ flag as per each IB we submit. That
> >> is, when we transition from TMZ to non-TMZ we have
> >> to send a stop with TMZ followed by a start with
> >> non-TMZ, and similarly for transitioning from
> >> non-TMZ into TMZ.
> >>
> >> This patch implements this, thus fixing the GFX
> >> hang.
> >>
> >> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 87 +++++++++++++++++-------
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +-
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++--
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 ++--
> >>  4 files changed, 79 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >> index 4b2342d11520..16d6df3304d3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >> @@ -216,40 +216,75 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> >>              amdgpu_ring_emit_cntxcntl(ring, status);
> >>      }
> >>
> >> -    secure = false;
> >> +    /* Find the first non-preamble IB.
> >> +     */
> >>      for (i = 0; i < num_ibs; ++i) {
> >>              ib = &ibs[i];
> >>
> >>              /* drop preamble IBs if we don't have a context switch */
> >> -            if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> >> -                skip_preamble &&
> >> -                !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> >> -                !amdgpu_mcbp &&
> >> -                !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> >> -                    continue;
> >> -
> >> -            /* If this IB is TMZ, add frame TMZ start packet,
> >> -             * else, turn off TMZ.
> >> -             */
> >> -            if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> >> -                    if (!secure) {
> >> -                            secure = true;
> >> -                            amdgpu_ring_emit_tmz(ring, true);
> >> -                    }
> >> -            } else if (secure) {
> >> +            if (!(ib->flags & AMDGPU_IB_FLAG_PREAMBLE) ||
> >> +                !skip_preamble ||
> >> +                (status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) ||
> >> +                amdgpu_mcbp ||
> >> +                amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> >> +                    break;
> >> +    }
> >> +    if (i >= num_ibs)
> >> +            goto Done;
> >> +    /* Setup initial TMZiness and send it off.
> >> +     */
> >> +    secure = false;
> >> +    if (job && ring->funcs->emit_frame_cntl) {
> >> +            if (ib->flags & AMDGPU_IB_FLAGS_SECURE)
> >> +                    secure = true;
> >> +            else
> >>                      secure = false;
> >> -                    amdgpu_ring_emit_tmz(ring, false);
> >> -            }
> >> -
> >> -            amdgpu_ring_emit_ib(ring, job, ib, status);
> >> -            status &= ~AMDGPU_HAVE_CTX_SWITCH;
> >> +            amdgpu_ring_emit_frame_cntl(ring, true, secure);
> >>      }
> >> +    amdgpu_ring_emit_ib(ring, job, ib, status);
> >> +    status &= ~AMDGPU_HAVE_CTX_SWITCH;
> >> +    i += 1;
> >> +    /* Send the rest of the IBs.
> >> +     */
> >> +    if (job && ring->funcs->emit_frame_cntl) {
> >> +            for ( ; i < num_ibs; ++i) {
> >> +                    ib = &ibs[i];
> >> +
> >> +                    /* drop preamble IBs if we don't have a context switch */
> >> +                    if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> >> +                        skip_preamble &&
> >> +                        !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> >> +                        !amdgpu_mcbp &&
> >> +                        !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> >> +                            continue;
> >
> > Snip.
> >
> >> +
> >> +                    if (!!secure ^ !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
> >> +                            amdgpu_ring_emit_frame_cntl(ring, false, secure);
> >> +                            secure = !secure;
> >> +                            amdgpu_ring_emit_frame_cntl(ring, true, secure);
> >> +                    }
> >
> > That's pretty good optimization! I spend quit a few time to understand this.
>
> I know. I know you did. It's called experience.
>
> When I saw you v1, it was a cringe. Seriously?

It may be a good optimization but if it's hard to understand it makes
the code harder to read and comprehend, that can lead to
misinterpretation and maintenance burdens.  It took me a while to
understand what was intended here.

Alex

>
> >
> >>
> >> -    if (secure) {
> >> -            secure = false;
> >> -            amdgpu_ring_emit_tmz(ring, false);
> >> +                    amdgpu_ring_emit_ib(ring, job, ib, status);
> >> +                    status &= ~AMDGPU_HAVE_CTX_SWITCH;
> >> +            }
> >> +            amdgpu_ring_emit_frame_cntl(ring, false, secure);
> >> +    } else {
> >> +            for ( ; i < num_ibs; ++i) {
> >> +                    ib = &ibs[i];
> >> +
> >> +                    /* drop preamble IBs if we don't have a context switch */
> >> +                    if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> >> +                        skip_preamble &&
> >> +                        !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> >> +                        !amdgpu_mcbp &&
> >> +                        !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> >> +                            continue;
> >> +
> >> +                    amdgpu_ring_emit_ib(ring, job, ib, status);
> >> +                    status &= ~AMDGPU_HAVE_CTX_SWITCH;
> >
> > To pull the checking "job && ring->funcs->emit_frame_cntl" out of the loop,
> > that make the implemenation more duplicated like below, we have to write
>
> Yes, that is exactly what we want.
>
> As I explained before and will explain again, and again, and again,
> "job && ring->funcs->emit_frame_cntl" is static to the body of the loop,
> and as such can be pulled OUT of the loop and it should.
>
> This is a *formulaic* optimization exercise. Compilers and optimizers do it first.
>
> To extrapolate, consider that what you'd eventually have is a HUGE long long loop
> and everything inside it. Not good.
>
> Regards,
> Luben
>
>
> > the same codes multiple times. I hope the implementation is more simple and
> > readable. Please see my V2 patch that I just send out. We can try to use
> > minimum changes to fix the issue.
> >
> >               for ( ; i < num_ibs; ++i) {
> >                       ib = &ibs[i];
> >
> >                       /* drop preamble IBs if we don't have a context switch */
> >                       if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> >                           skip_preamble &&
> >                           !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> >                           !amdgpu_mcbp &&
> >                           !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> >                               continue;
> >
> >                         ...
> >                       amdgpu_ring_emit_ib(ring, job, ib, status);
> >
> > Thanks,
> > Ray
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
