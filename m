Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF33C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 12:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3A210E5F6;
	Wed, 12 Apr 2023 12:53:23 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D6F10E5F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 12:53:21 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id y69so18441199ybe.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 05:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681303999; x=1683895999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzP3pNOxHozEaWDS3tDFE0vhx9LM5NPXt/O117655y4=;
 b=QR6XHwG5urcTUclqkDWps2Cwiq75QQWX9At0aP8+FUJCN8hBB+Y1gYACpNk+9lSnJc
 3kfW/zvHQIeGeswI3V9SPabVm40jdkAcF5IU19pznxJ+u5JuOL0C/c2GodWcmM/Trv+z
 vNUhwX9KefAGM5GcUrpgHAzILM5iDntBV1EeT2AYxhHPOChIXMkeCqfRpxeaK/h8+ryd
 pUS7hG4MWAuuOHB/O/OBdkHCgOMPXDvDwHg1MippFAkXYcR1/zebiICOLDDcBvJbp2tt
 EZSv/KVDGX4pdW5Evr43Zs5GqBa0RSqRzauMM62sAbgVhPO9dyrj4DBkJLvYa/cxOWte
 nang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681303999; x=1683895999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzP3pNOxHozEaWDS3tDFE0vhx9LM5NPXt/O117655y4=;
 b=r5/gbo7A01CzQo9PbkQybiMUnT3jbyExJLf9PfTnNLnEG0ScFoGD8C2UtMW1aoG07z
 c6M+MV+FMkHR78nvIo59znhRxV8zyT9QqwAcsLvm3KJQ3PJ13EXS8ltglYTLJ3RUf2ZF
 elfT5WN70qK4pGmirK1+Aphu4HXQbX0r7FOHZK7lht1HB77YXQACuSDdxROHgmiSz31s
 fOGIvJaeUUkSABcmHXUdqQMeXSV2upc4RKwDWG6bF3C6OqQ9iflAlCaAIPUOgz5T4vxA
 C78Bpe3asDcrCsYoLxDsTZeySjw5ovD5BwOorSdyGThLHVNebhKFwlFrV4N04xohz4di
 foAQ==
X-Gm-Message-State: AAQBX9fRWXDcUolFw1SiBmLUrj4Dx4fkWNDmqEiZH4yctvxEXw7UeNR4
 +5Z5jrNEIFbev7Hqr4qV2rlohjHi88+FKkzQtDBAJgkNPoAlbfohOdU=
X-Google-Smtp-Source: AKy350bH0smKIokdJdCU5ymRsNtxr5lo+y5857ylAqrZ+VtyCelKOr2aX2AiL9/Op7v4FQFWpRNEeg/i+Z7szM0vPFw=
X-Received: by 2002:a25:e097:0:b0:b8e:dadc:a081 with SMTP id
 x145-20020a25e097000000b00b8edadca081mr1872164ybg.5.1681303999708; Wed, 12
 Apr 2023 05:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
 <4365dd57-f61d-9d19-79c8-697f0554fa26@gmail.com>
In-Reply-To: <4365dd57-f61d-9d19-79c8-697f0554fa26@gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 12 Apr 2023 14:50:57 +0200
Message-ID: <CAP+8YyELApwVc06d29P4hRETdXJoXo2M_GqiKhsPie-MLsAe_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add a max ibs per submission limit.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 12, 2023 at 2:46=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 12.04.23 um 14:18 schrieb Bas Nieuwenhuizen:
> > And ensure each ring supports that many submissions. This makes
> > sure that we don't get surprises after the submission has been
> > scheduled where the ring allocation actually gets rejected.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 25 +++++++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
> >   3 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 7af3041ccd0e..8362738974c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser =
*p,
> >       if (r < 0)
> >               return r;
> >
> > +     if (num_ibs[r] >=3D amdgpu_ring_max_ibs(chunk_ib->ip_type))
> > +             return -EINVAL;
> > +
> >       ++(num_ibs[r]);
> >       p->gang_leader_idx =3D r;
> >       return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index dc474b809604..abd70d2f26f6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -49,6 +49,25 @@
> >    * them until the pointers are equal again.
> >    */
> >
> > +/**
> > + * amdgpu_ring_max_ibs - Return max IBs that fit in a single submissio=
n.
> > + *
> > + * @type: ring type for which to return the limit.
> > + */
> > +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
> > +{
> > +     switch (type) {
> > +     case AMDGPU_RING_TYPE_GFX:
> > +     case AMDGPU_RING_TYPE_COMPUTE:
> > +             /* gfx/compute are often used more extensively and radv
> > +              * has historically assumed the limit was 192.
> > +              */
> > +             return 192;
> > +     default:
> > +             return 50;
> > +     }
> > +}
> > +
> >   /**
> >    * amdgpu_ring_alloc - allocate space on the ring buffer
> >    *
> > @@ -182,6 +201,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, st=
ruct amdgpu_ring *ring,
> >       int sched_hw_submission =3D amdgpu_sched_hw_submission;
> >       u32 *num_sched;
> >       u32 hw_ip;
> > +     unsigned int max_ibs_dw;
> >
> >       /* Set the hw submission limit higher for KIQ because
> >        * it's used for a number of gfx/compute tasks by both
> > @@ -290,6 +310,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, s=
truct amdgpu_ring *ring,
> >               return r;
> >       }
> >
> > +     max_ibs_dw =3D ring->funcs->emit_frame_size +
> > +                  amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs=
->emit_ib_size;
> > +     max_ibs_dw =3D (max_ibs_dw + ring->funcs->align_mask) & ~ring->fu=
ncs->align_mask;
> > +     max_dw =3D max(max_dw, max_ibs_dw);
>
> I think something like "if (WARN_ON(max_ibs_dw > max_dw) max_dw =3D
> max_ibs_dw;" would be more appropriate.

I really like it this way because it automatically does the right
thing. In comparison it is difficult getting the test matrix together
for a WARN_ON on something that differs every generation, and I don't
know what we'd gain from doing it that way?


>
> Apart from that this looks really good to me,
> Christian.
>
> > +
> >       ring->ring_size =3D roundup_pow_of_two(max_dw * 4 * sched_hw_subm=
ission);
> >
> >       ring->buf_mask =3D (ring->ring_size / 4) - 1;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 3989e755a5b4..e6e672727529 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -317,6 +317,7 @@ struct amdgpu_ring {
> >   #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec(=
(r),(o))
> >   #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
> >
> > +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
> >   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> >   void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
> >   void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
>
