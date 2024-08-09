Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A61C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 16:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A9A10E025;
	Fri,  9 Aug 2024 16:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RsdeTNET";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0BF10E025
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 16:17:54 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2cb52e2cb33so1728128a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Aug 2024 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723220274; x=1723825074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNTqmi68m0fJPfXqPXlRL8iBqHmBtJaJazF8hUt1nrU=;
 b=RsdeTNETwNxAVyUD8FZPvAhbeRbhH2NJtOFCSexEUvSysEJZs6ypCMA0t771pshgOt
 5msVFJGbk6h9iT/x3lbFEdl625bykggdpjRYNFHYkHxJ83k8dmD9vWx+Y/GYAR4P5K3U
 mAG6mYRYxq1yACqk7ceZlnjTLV6irXCzqJ6aVplNHQ1AIFN9NpNYyjSqLHksHazo2SKo
 02MbX9pRskY3IBsqOD1ou9gzFw1HjoZ8ZyRFlIoC8hN8vbZEyB9HKnyNANW2DUNXFnZr
 Ff7fim5Worusa5gst5alhUS8dnrPgkAPcCrnsvqugoTkFljpNCEMLLgwQvmL3RXe/aP3
 OTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723220274; x=1723825074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNTqmi68m0fJPfXqPXlRL8iBqHmBtJaJazF8hUt1nrU=;
 b=w+7Nuro4FI1JsmWIUL/PdDq1TV0uJe7jhW43kG0xMq9TH+hNDQ1Y91pOKCbpazIw/z
 +PXFEE4s+5cieHpZAlvt8tZa3VtvFLSjwk8if5wqZgWwBKwquT4ArnJUY3HGrFu6RuvI
 LCyFFOD2ZNkkWROKggx1gWbBjCQw/yfE3w9FbPyC5583z8wmMmct0YVFMml2Sb9ArF4V
 dUmqvx+GFAH5jUuM8UYudPTn0tP1jHlGCJ0/TdxLJK34jsaYNQY9xEj3eSppbLYwDEw2
 Oh352x5ODtxFgIUhzy4+fM/PBmIEx0ACY+fAeN23vSrutzE8/XNiyyPGICSu9cgt6WpG
 50Bw==
X-Gm-Message-State: AOJu0Yz99v8U1gh/5EfVyP0MfxDj1FJNeHmyekecI27yYrUHrtDyoELA
 C3DwCdwmHcZFZGaX3/j5hNNksOlT8quYJlZJrg7A2EDEss2/iBJukxViQmjQlqDKdCGvdr7suIe
 nPm8rAb6R4pLBNqOQ6Hw7WdGp1HQX0A==
X-Google-Smtp-Source: AGHT+IHf3N7ZQH+a3HzeGh2cqrkK1E6xdeI3/uHCzBXhFrzlQgrZGEqoX1Bla3DDF/2F4GIb7URAQnNACiT3W/Oa/iU=
X-Received: by 2002:a17:90b:1e0e:b0:2c9:923e:faf1 with SMTP id
 98e67ed59e1d1-2d1e7fd3cd8mr2378582a91.18.1723220274024; Fri, 09 Aug 2024
 09:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240802163813.1800438-1-Jonathan.Kim@amd.com>
 <CADnq5_MbRQ36OD73oWv5o9rGS0X=LkibmdC14m-=VoQMtzeTEw@mail.gmail.com>
 <CY8PR12MB7435163B964B502CE4C7FCF685BA2@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435163B964B502CE4C7FCF685BA2@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Aug 2024 12:17:42 -0400
Message-ID: <CADnq5_M=C6vuRc47iMW+sHr-abEMRXG26XXUDYzjTp8qQuessw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail
 for gfx9
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
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

On Fri, Aug 9, 2024 at 12:12=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.com=
> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, August 9, 2024 11:55 AM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset =
fail for
> > gfx9
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Aug 2, 2024 at 12:38=E2=80=AFPM Jonathan Kim <Jonathan.Kim@amd.=
com>
> > wrote:
> > >
> > > If queue reset fails, tell the CP to reset the pipe.
> > > Since queues multiplex context per pipe and we've issues a device wid=
e
> > > preemption prior to the hang, we can assume the hung pipe only has on=
e
> > > queue to reset on pipe reset.
> >
> > Is there a specific CP or PSP firmware version required for this?  If
> > so, we should check for it before attempting this if it will cause a
> > problem.
>
> Thanks for the review Alex.
> Worst case is that the MMIO reg write doesn't do anything and we end up w=
ith extra CP active poll wait cycles before falling back to adapter reset.
> We may run into scenarios where pipe reset doesn't help anyways even if w=
e did have the right FW.

And I supposed there may be cases where it might help as well beyond
just the case that requires firmware changes.

Thanks,

Alex

>
> Jon
>
> >
> > Other than that:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >
> > >
> > > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > > ---
> > >  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 46
> > +++++++++++++------
> > >  1 file changed, 31 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > index 32f28c12077b..c63528a4e894 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > @@ -1173,12 +1173,30 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
> > amdgpu_device *adev,
> > >         return queue_addr;
> > >  }
> > >
> > > +/* assume queue acquired  */
> > > +static int kgd_gfx_v9_hqd_dequeue_wait(struct amdgpu_device *adev,
> > uint32_t inst,
> > > +                                      unsigned int utimeout)
> > > +{
> > > +       unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffie=
s;
> > > +
> > > +       while (true) {
> > > +               uint32_t temp =3D RREG32_SOC15(GC, GET_INST(GC, inst)=
,
> > mmCP_HQD_ACTIVE);
> > > +
> > > +               if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> > > +                       return 0;
> > > +
> > > +               if (time_after(jiffies, end_jiffies))
> > > +                       return -ETIME;
> > > +
> > > +               usleep_range(500, 1000);
> > > +       }
> > > +}
> > > +
> > >  uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
> > >                               uint32_t pipe_id, uint32_t queue_id,
> > >                               uint32_t inst, unsigned int utimeout)
> > >  {
> > > -       uint32_t low, high, temp;
> > > -       unsigned long end_jiffies;
> > > +       uint32_t low, high, pipe_reset_data =3D 0;
> > >         uint64_t queue_addr =3D 0;
> > >
> > >         kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> > > @@ -1202,25 +1220,23 @@ uint64_t kgd_gfx_v9_hqd_reset(struct
> > amdgpu_device *adev,
> > >         /* assume previous dequeue request issued will take affect af=
ter reset */
> > >         WREG32_SOC15(GC, GET_INST(GC, inst),
> > mmSPI_COMPUTE_QUEUE_RESET, 0x1);
> > >
> > > -       end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
> > > -       while (true) {
> > > -               temp =3D RREG32_SOC15(GC, GET_INST(GC, inst),
> > mmCP_HQD_ACTIVE);
> > > +       if (!kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
> > > +               goto unlock_out;
> > >
> > > -               if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> > > -                       break;
> > > +       pr_debug("Attempting pipe reset on XCC %i pipe id %i\n", inst=
, pipe_id);
> > >
> > > -               if (time_after(jiffies, end_jiffies)) {
> > > -                       queue_addr =3D 0;
> > > -                       break;
> > > -               }
> > > +       pipe_reset_data =3D REG_SET_FIELD(pipe_reset_data, CP_MEC_CNT=
L,
> > MEC_ME1_PIPE0_RESET, 1);
> > > +       pipe_reset_data =3D pipe_reset_data << pipe_id;
> > >
> > > -               usleep_range(500, 1000);
> > > -       }
> > > +       WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL,
> > pipe_reset_data);
> > > +       WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL, 0);
> > >
> > > -       pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> > > -                inst, pipe_id, queue_id, !!queue_addr ? "succeeded!"=
 : "failed!");
> > > +       if (kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
> > > +               queue_addr =3D 0;
> > >
> > >  unlock_out:
> > > +       pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> > > +                inst, pipe_id, queue_id, !!queue_addr ? "succeeded!"=
 : "failed!");
> > >         amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
> > >         kgd_gfx_v9_release_queue(adev, inst);
> > >
> > > --
> > > 2.34.1
> > >
