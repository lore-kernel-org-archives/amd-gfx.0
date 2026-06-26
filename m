Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC85EC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 21:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329B510E3DA;
	Fri, 26 Jun 2026 21:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QLMqXiF3";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4CD10F6B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 21:49:32 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-139ce7c22dbso139211c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 14:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782510572; cv=none;
 d=google.com; s=arc-20260327;
 b=X97gA0fX1lM18tojec/UQOuw/lZtvO7gOWxHMImZq5dPOqf+/wYSClF/o1QIPYachA
 u0NcExGEajwWBLCDYiSRAlcR6h5irnnInSEcW5L01keHcRiSIqPwmt3B2U1wDYcB7w1C
 THpuGRPFJJDzOweMoLjZRK3bew3GyOZ7aN8qvO0V53+s0Rqu7o9Cx/crSNUNLvgsC5xf
 ZZXbz3Syxr5B9tB6r82DrB69Nsx5k1BK5Dj0WIjpe/MPeOJNeDSGnipLchqbFzKsTXTT
 xORHpLEOWcTsBw1ZMGVF83W9M5vnEt8S/tHye993AQFXcBPSGDsk5mAn6Z96ukOB1L7C
 prAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GwWlgxvrw/Wm/U7DbeeEyNi2oClEcjrfWLtOvXaNbXs=;
 fh=G0s/KeybxNqdnK4CDKh+n+S7duh+Hx5YxYfitBz5u4I=;
 b=DpF79g8NcwREeC70Wo3LLBVRHmdvBLItCrtARO639qvjzTEWz9BxqeVSit4W9KYbr9
 dGM7QOTtJnS5bFWsGVeMsf0GFERvOCyRt37aG1yDFBdflVunep3SznED4LXUseJ/Ru5s
 syXTEIHyf3ObTOCX0PmNnVM5gNUFdHQtu49W4x0l8/XpvHkUnQiQ+tkENV2rkQfcNfJV
 hgZ0pJJD54Q7rftS0xXYRxkcP10302ITzRmpUbejKw1jH6Bq/8titMLRMJkSjgN1sO1S
 8vGtlVdJj0GgUSJW2R8QjGi2p+Bv2stv8WGhqPloogFq0ClReELbynPpqEiAKs6NiZRL
 BENg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782510572; x=1783115372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GwWlgxvrw/Wm/U7DbeeEyNi2oClEcjrfWLtOvXaNbXs=;
 b=QLMqXiF3gas3KP9x0vcLqCr+5TY7GrjbBHtJp/r4zIsep1bg9HGNnlEA7laGoB20nU
 es+Z2TA3RaBu4fr9+ptiuIXqNtXC1yQ2Lbl/NpEhmZK++OT+ARbrLyG4nh4LZfQi3F0U
 oPl/GntaOYc12SvsoiheQQSPRaD/lmBt3brS3Gb+RkftZhfZTPtCzJRUYTPVnuQgIOEK
 MRR4oR8+RWrZ2AKF4xon/CVDEr+pASjxnlpiBouxpfrEzSQt0guMdjjR42Ws7F0iPeNA
 9u5N0OQuK4sxk6PqeZjT2w7uhm5TbLcJwPJ5zqhoeNqhknyTICzZ8SFhlrdbIJ7H9oKG
 ElVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782510572; x=1783115372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GwWlgxvrw/Wm/U7DbeeEyNi2oClEcjrfWLtOvXaNbXs=;
 b=Uol3EX1P+U+sIRl/NoU/9IKg8L22hpLKkGj7Fz9ot3GHBRF1K/0rDqG8It7v4NI+cV
 vcX09xNvq1H3VoRurrY6uSIK9nkFxBPXwt04kW0rZUL38EY1+H5j1Dja/gp9TceHVC8D
 2NAskAltMqoF8rkbscfgPBKxmhjhkAI2roGrc9S1vciA+cP98iiaD1AslXJOJwudKhk0
 FihF1Byfyaw/mm2THTK8njTfxmG2sjVghh4hvRx1e0fAdXu+yc6M83iZhWCEV0+86DO3
 rZNEuLHmAu2geyrWN6ucDkaotK/wYrBd8hg1XugmKvgtGlmbTqE3eQvIpqt6DJrHMP9+
 u4tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CIO/NvNPMqQ/ORgNkoL6T4Ls6G9psBViWuhtElAhFUrcrCZIidT2NMFmFwheFZJsW9KXCJGd0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwemPi5tyYJvlxvabQMg02fAkq6PUGiq2IDUIEElMyGWjh8g+Gq
 xrG1RGHGu/+/ZeogUr4ZiU1Gx7+ah3GWj2rHuIHrV5+ipplQyFUGeXmpN5o4STzUHvoavZNa0t+
 IpIkKKG6x1IER6GYIxd3qyedYAFtjb1U=
X-Gm-Gg: AfdE7cm4CMmz5vtPAOY383+/ka33cWewftDIFYDn/pXqQCSIZNS4iTlhYR8RWfCHeH+
 Um1nbIGpytHIGw4dpRMYDP1fPx/KUhrnblCUsBL4gbXgKXPOM053om3/MGK9kbPMZMqZIYuMc+S
 gT4xfJKRSZU1ZEmwYa1kNh2ElOslXgSw9NqPMVhpx6kpAmPA91L6MhK/R0oInQKLFEZVTse+JKJ
 fN84pSYbVrRVm/Z4ipXPpCE0viEWPPujlrZcAES+W33zKHq4BLII6GrMl+1lzB84wGhLkw2KF4Z
 y18jSgwXEiNYt6EdU6uoy6F9LFF1oLdppdHaxiK1C4leFmU08Npli8QjLvw=
X-Received: by 2002:a05:7022:1085:b0:139:90ab:36ac with SMTP id
 a92af1059eb24-139dbb1e039mr2362650c88.7.1782510571709; Fri, 26 Jun 2026
 14:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260626030013.20569-1-tiagodourado@usp.br>
 <20260626030013.20569-2-tiagodourado@usp.br>
 <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
In-Reply-To: <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jun 2026 17:49:19 -0400
X-Gm-Features: AVVi8Cf7sEZtYouWUOPdAwzR66k49DaN5x35HjJ1GOvsJ5itj00iqqvtgBA2e1Y
Message-ID: <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tiago Dourado <tiagodourado@usp.br>, kernel@lists.ime.usp.br,
 airlied@gmail.com, 
 alexander.deucher@amd.com, simona@ffwll.ch, "Liu, Leo" <Leo.Liu@amd.com>, 
 Luiz Fernandes <luiz.f.f.fernandes@usp.br>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Fri, Jun 26, 2026 at 8:14=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/26/26 04:59, Tiago Dourado wrote:
> > The jpeg_v3_0_process_interrupt function is identical to
> > jpeg_v2_0_process_interrupt. Remove the duplicate implementation
> > in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_funcs=
 struct.
> > Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
> > cross-version reuse.
>
> Usually we intentionally don't do any cross IP version reuse, that has ca=
use tons of problems in the past.
>
> @Leo any particular reason why we don't have a separate SRCID file for VC=
N3?
>
> My educated guess is that nothing changed compared to VCN2 and nobody car=
ed to re-generate the file from the HW definition.
>

I think it's the same so no need for a separate one.  There are a
number of existing places where VCN or jpeg use one function
implementation across multiple generations.

Alex

> Regards,
> Christian.
>
> >
> > Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> > Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > ---
> >
> > v2:
> > - Assigned function directly to irq_funcs instead of using a macro.
> >
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
> >  3 files changed, 6 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_0.c
> > index 9fe8d10ab..9006fc57e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amd=
gpu_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> >                                     struct amdgpu_irq_src *source,
> >                                     struct amdgpu_iv_entry *entry)
> >  {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_0.h
> > index 654e43e83..4f400fb47 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_=
ring *ring,
> >  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t r=
eg, uint32_t val);
> >  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
> >
> > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > +                             struct amdgpu_irq_src *source,
> > +                             struct amdgpu_iv_entry *entry);
> > +
> >  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
> >
> >  #endif /* __JPEG_V2_0_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v3_0.c
> > index 98f5e0622..2f3a5a17e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > @@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struct am=
dgpu_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
> > -                                   struct amdgpu_irq_src *source,
> > -                                   struct amdgpu_iv_entry *entry)
> > -{
> > -     DRM_DEBUG("IH: JPEG TRAP\n");
> > -
> > -     switch (entry->src_id) {
> > -     case VCN_2_0__SRCID__JPEG_DECODE:
> > -             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> > -             break;
> > -     default:
> > -             DRM_ERROR("Unhandled interrupt: %d %d\n",
> > -                       entry->src_id, entry->src_data[0]);
> > -             break;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> >                               unsigned int vmid,
> >                               struct amdgpu_fence *timedout_fence)
> > @@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct amd=
gpu_device *adev)
> >
> >  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs =3D {
> >       .set =3D jpeg_v3_0_set_interrupt_state,
> > -     .process =3D jpeg_v3_0_process_interrupt,
> > +     .process =3D jpeg_v2_0_process_interrupt,
> >  };
> >
> >  static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
>
