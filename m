Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6367FC4BA06
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 04:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3726A21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 04:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlJrvbGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3726A21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0646E07F;
	Thu, 27 Feb 2020 04:44:57 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F596E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 04:44:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f15so1962451wml.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 20:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Arxj034gHd/v59csz8bThPOKBC7kRQbLeLZyUV0G6c0=;
 b=MlJrvbGyhIbdade63yZZBFrfI4VWBrqwHVS+miselObfOTdjdI17rWPcGFypAcIZgI
 lnOs4shIQNDey89lg6W7WopZKpU3boyznJE+8yHtlNJ8F9XOoB1/FeWe8Fse+7QyvJG6
 BmWA2KYOhn/HOpM3Cgrcpj3rN0CJHoOEWj710Ft4Ad3zRR0wRXP29T0Igv0dyTlwcTqR
 J2RV5Vvqs1drLmB5PmxvibtKqvxYRICqK2gAzcC+Fj1UmgnZUQjfLEOCWIUMa6Nb0PVx
 TZiMj2Kw2v25AMvIwn8Ngj3ZsZ9njcG3YimgtE1s8r5cnjYvlqFYgOcj4FFGetf4a2m7
 w8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Arxj034gHd/v59csz8bThPOKBC7kRQbLeLZyUV0G6c0=;
 b=M8Vu6SjbYMp8q559wv/hA25kaSR+ckdvQ2J8G1TLgiDfPJ581tIbqK6VSOF6nAcLNG
 G6PxjPhatRRXNyVv+opZYk0gzmXE/VZnS1diZoE+RVoNv1kI4S55zHhdHwCwJL894+hx
 i85oOklF/VMiigE6KwgDYsygZg65rh3Q3o/b7gM967XOu6yTZHsTRGCwD5TnUhiLdwQl
 hZaneYzlPTLTQ2XkwvKeQy1wXpNRAvAtGgKTbUejYn54eONW7Ii2b6bfnqe62AquxORZ
 P/js05V6TzuAGY/6BA/tZMQenUSN1NX0mTDzfaEWtZpsErZzQCbHHEOqwFCB5saMeX9h
 qfPQ==
X-Gm-Message-State: APjAAAUChl1J1mMkyc6NSz0zKxKVGj8N8piPQclUsPrD+GV/SRKsgJm1
 VJENAN2qWvCBakIzk90LFF9YAX2akaHwjHm/EVQ=
X-Google-Smtp-Source: APXvYqytjZcb01zpYaiFE28D1VfHQfTnBgAW/fJqimltcKF9rvxfUG+1NmlG+FbrLKuD/yPpufETbBqX0WJKtbA4HjQ=
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr2735923wmm.79.1582778695347; 
 Wed, 26 Feb 2020 20:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-2-nirmoy.das@amd.com>
In-Reply-To: <20200226203730.4621-2-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Feb 2020 23:44:44 -0500
Message-ID: <CADnq5_M2w2W5eSX9m5x0hjY3TB7CxJa9YJfyUemk+mfgMVMMPA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: implement ring init_priority for
 compute ring
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 26, 2020 at 3:34 PM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>
> init_priority will set second compute queue(gfx8 and gfx9) of a pipe to high priority
> and 1st queue to normal priority.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++++++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 24caff085d00..a109373b9fe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -170,6 +170,7 @@ struct amdgpu_ring_funcs {
>         /* priority functions */
>         void (*set_priority) (struct amdgpu_ring *ring,
>                               enum drm_sched_priority priority);
> +       void (*init_priority) (struct amdgpu_ring *ring);
>         /* Try to soft recover the ring to make the fence signal */
>         void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
>         int (*preempt_ib)(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fa245973de12..14bab6e08bd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6334,6 +6334,19 @@ static void gfx_v8_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>         gfx_v8_0_pipe_reserve_resources(adev, ring, acquire);
>  }
>
> +static void gfx_v8_0_ring_init_priority_compute(struct amdgpu_ring *ring)
> +{
> +       /* set pipe 0 to normal priority and pipe 1 to high priority*/
> +       if (ring->queue == 1) {
> +               gfx_v8_0_hqd_set_priority(ring->adev, ring, true);
> +               gfx_v8_0_ring_set_pipe_percent(ring, true);
> +       } else {
> +               gfx_v8_0_hqd_set_priority(ring->adev, ring, false);
> +               gfx_v8_0_ring_set_pipe_percent(ring, false);
> +       }
> +
> +}

We should drop gfx_v8_0_hqd_set_priority() and set the priorities in
the mqd instead.  In gfx_v8_0_mqd_init(), set
mqd->cp_hqd_pipe_priority and mqd->cp_hqd_queue_priority as
appropriate for each queue.  I'm not sure we want to mess with
gfx_v8_0_ring_set_pipe_percent ultimately at all once this lands.
That stuff statically adjusts the priorities between gfx and compute.

> +
>  static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
>                                              u64 addr, u64 seq,
>                                              unsigned flags)
> @@ -6967,6 +6980,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>         .insert_nop = amdgpu_ring_insert_nop,
>         .pad_ib = amdgpu_ring_generic_pad_ib,
>         .set_priority = gfx_v8_0_ring_set_priority_compute,
> +       .init_priority = gfx_v8_0_ring_init_priority_compute,
>         .emit_wreg = gfx_v8_0_ring_emit_wreg,
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1c7a16b91686..0c66743fb6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5143,6 +5143,18 @@ static void gfx_v9_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>         gfx_v9_0_pipe_reserve_resources(adev, ring, acquire);
>  }
>
> +static void gfx_v9_0_ring_init_priority_compute(struct amdgpu_ring *ring)
> +{
> +       /* set pipe 0 to normal priority and pipe 1 to high priority*/
> +       if (ring->queue == 1) {
> +               gfx_v9_0_hqd_set_priority(ring->adev, ring, true);
> +               gfx_v9_0_ring_set_pipe_percent(ring, true);
> +       } else {
> +               gfx_v9_0_hqd_set_priority(ring->adev, ring, false);
> +               gfx_v9_0_ring_set_pipe_percent(ring, true);
> +       }
> +}

Same comment as above.

Alex

> +
>  static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev = ring->adev;
> @@ -6514,6 +6526,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>         .insert_nop = amdgpu_ring_insert_nop,
>         .pad_ib = amdgpu_ring_generic_pad_ib,
>         .set_priority = gfx_v9_0_ring_set_priority_compute,
> +       .init_priority = gfx_v9_0_ring_init_priority_compute,
>         .emit_wreg = gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
