Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE9C35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6143F2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM1k2yQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6143F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BA56EAE5;
	Tue, 25 Feb 2020 14:10:50 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3279D6EAE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 14:10:48 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r11so14895663wrq.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TK93QyzPe188JSFPqSf2jsET4Npm7YGQvvHX5JfymBk=;
 b=kM1k2yQbs7M/7gpEEnCVtCt3pt6MIJ6c3Jq6zEFqwLBrB7JEPQUe7Ov1E7ZAGHr/IT
 ojOfqDZN64nZWFpbYzmQXvfC0HHlJ5Po4RqmIU7Gi9mVZfjakP2KXobpTZG29aa5Xgth
 /Kt533CvGMm5vC73JTNHtkWtk/h+2FnXYM4QQC4mKcSjupPfmVJwALPdc1a7oaJ9zzo3
 hCwM3cOL3/3Z5NI8BkcWWE/PirTNewzeemBkIYf0URBr4GMxUxEosjQL3qQEBCaVSt+n
 Zo6F2Gb7mQ7LAhBLaAQGrXvAHP7KcokNS6htfHM7H5C+df5iU0KtTMQvS1y2L93VJoAN
 7Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TK93QyzPe188JSFPqSf2jsET4Npm7YGQvvHX5JfymBk=;
 b=Nm4XXmL/5qA0orSogV3q5r70sXdPl5eoV/J0lCVew7z14Hui+cor/t7aW/8nB3NRnc
 AWvxfPFDHG5H9OS8QpvOsJjS+4D3i6W9BPkBv+fIE+yn8LX6C3yRwXQXFnZ9dG7yxcZ2
 /3S29czHVZz/p3wxRIzYkqoUzfp6ocxNpr188IyOoZqiqKnjmC/rfrSYtJ0IVx/qj59F
 oPCo0uWuer+fwN+O/1SKuxrGwA8c2kPZtd+53qnha87ItbprPFFq8vTNGNHJpIx05lH4
 r4gEoChX0Oa4LWKXRHlHKnfpImZIhTckWdsidzbn5TTb3Ke5RsPIot8R4A924YflZfKU
 xAcQ==
X-Gm-Message-State: APjAAAU202eSKwYlN8FKevdNJW6TXWM5Unree+KkMjITvJiukb8e4oq2
 gRRt107N/VlZVB9Zwb8sfnqjEyHV6tDbVuQz6D4=
X-Google-Smtp-Source: APXvYqx6fehKCl6ifSbQs5W6QkfZmdyVckk0PqYKEM9oCRpXUrakSnhRp9UM65DKTdCyFhkcqnE5iN4qtC1DuM1FJP8=
X-Received: by 2002:adf:b254:: with SMTP id y20mr72271738wra.362.1582639846624; 
 Tue, 25 Feb 2020 06:10:46 -0800 (PST)
MIME-Version: 1.0
References: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2020 09:10:35 -0500
Message-ID: <CADnq5_OQT6FquodRxPLYzX71bj=qMP2E5wnUVJ7rwfbV8x_f0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
To: Huang Rui <ray.huang@amd.com>
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 25, 2020 at 8:58 AM Huang Rui <ray.huang@amd.com> wrote:
>
> Since 6643ba1 frame control packets are only issued in presence of secure IB(s).
> This causes hangs on some hardware (eg: Raven1). This patch restores the
> unconditionnal frame control packets issuing, that's to keep the per-IB logic
> regarding the secure flag.
>
> Fixes: 6643ba1 drm/amdgpu: Move to a per-IB secure flag (TMZ)
>
> Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 41 +++++++++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++-----
>  4 files changed, 43 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 4b2342d..9713a7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -131,7 +131,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>         uint64_t fence_ctx;
>         uint32_t status = 0, alloc_size;
>         unsigned fence_flags = 0;
> -       bool secure;
> +       int secure = -1;
>
>         unsigned i;
>         int r = 0;
> @@ -216,7 +216,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>                 amdgpu_ring_emit_cntxcntl(ring, status);
>         }
>
> -       secure = false;
>         for (i = 0; i < num_ibs; ++i) {
>                 ib = &ibs[i];
>
> @@ -228,27 +227,37 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>                     !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>                         continue;
>
> -               /* If this IB is TMZ, add frame TMZ start packet,
> -                * else, turn off TMZ.
> -                */
> -               if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> -                       if (!secure) {
> -                               secure = true;
> -                               amdgpu_ring_emit_tmz(ring, true);
> +               if (job && ring->funcs->emit_frame_cntl) {
> +                       if (secure == -1) {
> +                               if (ib->flags & AMDGPU_IB_FLAGS_SECURE) {
> +                                       secure = 1;
> +                                       amdgpu_ring_emit_frame_cntl(ring, true, true);
> +                               } else {
> +                                       secure = 0;
> +                                       amdgpu_ring_emit_frame_cntl(ring, true, false);
> +                               }
> +                       } else {
> +                               if (secure == 1 &&
> +                                   !(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
> +                                       secure = 0;
> +                                       amdgpu_ring_emit_frame_cntl(ring, false, true);
> +                                       amdgpu_ring_emit_frame_cntl(ring, true, false);
> +                               } else if (secure == 0 &&
> +                                          ib->flags & AMDGPU_IB_FLAGS_SECURE) {
> +                                       secure = 1;
> +                                       amdgpu_ring_emit_frame_cntl(ring, false, false);
> +                                       amdgpu_ring_emit_frame_cntl(ring, true, true);
> +                               }
>                         }
> -               } else if (secure) {
> -                       secure = false;
> -                       amdgpu_ring_emit_tmz(ring, false);
>                 }
>
>                 amdgpu_ring_emit_ib(ring, job, ib, status);
>                 status &= ~AMDGPU_HAVE_CTX_SWITCH;
>         }
>
> -       if (secure) {
> -               secure = false;
> -               amdgpu_ring_emit_tmz(ring, false);
> -       }
> +       if (job && ring->funcs->emit_frame_cntl)
> +               amdgpu_ring_emit_frame_cntl(ring, false,
> +                                           (secure == 1) ? true : false);
>
>  #ifdef CONFIG_X86_64
>         if (!(adev->flags & AMD_IS_APU))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 24caff0..4d019d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -166,7 +166,8 @@ struct amdgpu_ring_funcs {
>         void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
>                                         uint32_t reg0, uint32_t reg1,
>                                         uint32_t ref, uint32_t mask);
> -       void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
> +       void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
> +                               bool secure);
>         /* priority functions */
>         void (*set_priority) (struct amdgpu_ring *ring,
>                               enum drm_sched_priority priority);
> @@ -247,7 +248,7 @@ struct amdgpu_ring {
>  #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>  #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>  #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> -#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
> +#define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
>  #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
>  #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
>  #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7b61583..748ac35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -256,7 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
>  static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
>  static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
>  static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
>
>  static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>  {
> @@ -4729,12 +4729,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>                                            sizeof(de_payload) >> 2);
>  }
>
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> +                                   bool secure)
>  {
> -       if (amdgpu_is_tmz(ring->adev)) {
> -               amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -               amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> -       }
> +       uint32_t v = secure ? FRAME_TMZ : 0;
> +
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +       amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>  }
>
>  static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> @@ -5188,7 +5189,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>         .init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
>         .patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
>         .preempt_ib = gfx_v10_0_ring_preempt_ib,
> -       .emit_tmz = gfx_v10_0_ring_emit_tmz,
> +       .emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
>         .emit_wreg = gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1c7a16b..fbde712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5230,12 +5230,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>         amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
>  }
>
> -static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> +static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> +                                  bool secure)
>  {
> -       if (amdgpu_is_tmz(ring->adev)) {
> -               amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -               amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> -       }
> +       uint32_t v = secure ? FRAME_TMZ : 0;
> +
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +       amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>  }
>
>  static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
> @@ -6477,7 +6478,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>         .emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>         .init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>         .patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> -       .emit_tmz = gfx_v9_0_ring_emit_tmz,
> +       .emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>         .emit_wreg = gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
