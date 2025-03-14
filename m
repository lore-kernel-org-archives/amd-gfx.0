Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1179EC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 21:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F26B10E096;
	Fri, 14 Mar 2025 21:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aJeQMPN2";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FCC610E096
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 21:46:40 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso32839a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741988799; x=1742593599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phUJJwuHyWbSMSuWMGCvdr4qg5xV4RCoxdRhJh9G/4c=;
 b=aJeQMPN2guxFxr7gcZ2afzBIiGib4YGnE4A6lmkKiuew2i+qd/QqsTw1Ap5Zhhdca9
 //i6N29OzyXEdtHDM36AQG17FZmi8Ez59Vm/lTJ2yY5+tL0hwYd4MGZn7CCfanozO/6B
 Rv8q0uRT3aOw6cnAGTn9Um576SA2Ku9DFYWrg8bqeIh3Sj68z9cFZ3vs+60lEehVQKbK
 rV574o6zDOpIEc72wJ06j6Do3QeZ4Ve579aRPH+8vx/atCx4dVyJYWsWMPKBAtvPhwII
 +BNiiHSeX9FrpH1/O1zRMaWbFRnf8RYM14PLTZMnsMhDPXkMja8xDh8mYV/+oG/iwVYU
 BD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741988799; x=1742593599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phUJJwuHyWbSMSuWMGCvdr4qg5xV4RCoxdRhJh9G/4c=;
 b=jes4BVPZkmjH4+HeJNi3LBNU0op5dmqe8GKkpY78TK+55go7ykjMd0TCiJGtuyZ7CD
 J3VXNAWp8KkAUyUfCGmE12o1j8ci7L0ENkyNv04sG/7DRGP5Q5sRTss44SYEqFdGs8ff
 r2F8DWz4ISQYZqOJ11qcK7M5ALtt+L7KkH1DSFtdO9giAJSeJKpdskgESGPo8SFrgiDx
 U+RgJJs1SyJBXwsc4JDc6EnbduSTkfJLSXbJyo0ylRgnbpRi8K+KJReGuMQw0EV2kmc4
 fW0IaedsiYyOyw+8YWr1bsG77ufqB2LodlbTqLHCHousHM6MszXCrL0so8Sv0U11UVwX
 xtFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX126Up56tQp0X4UL/OT4fjLiJ0aHU8Pr7QEuVFU9eWDavaR0+foHj8CSIx2bCaMsNdWYUcaD2A@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUbq5QgLI8DyCKKlYWVnG+vOKcslKX/ScGw5cOD1XsfEZr9Jjw
 kQQ9BaXZf8LQXRtS7Am11ManBeX7f0Q9nQ3yACy0mE44h6/Tex5c6vX6Ykx3CNqV+opuyAmt9lx
 dSRQH7ZNvvBtXsrVgTNndRVrVOPfWm2dP
X-Gm-Gg: ASbGncthGcjcMzQfDJFp61l60GJ4ILaYEMqmTjTuhXzxt6Ld9qpIVoy0cWjM3tXQA8e
 57U1x1t1o8zaQiYDKuhkbaeiqky9+HPDMeofZPYr/7DijXAFSBSmgdNkoaw348jqqBG6Dx+85UX
 6lNll2L262RHp4E8QaXbwMQCEh0g==
X-Google-Smtp-Source: AGHT+IGChZ+lgmCswtd0PElY69FF2Eu12d8zB+YBkZoChbWOeZnImE1ZNCy7zEZTXV1S9vCoeN2mrhjT0JZetS9v6Vk=
X-Received: by 2002:a17:90b:1652:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-30151d4c068mr2006848a91.4.1741988799357; Fri, 14 Mar 2025
 14:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
 <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
 <DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
 <dcf2a1b5-f079-41e1-b310-79db0b927272@amd.com>
 <DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_OG3g8fasdXoPRN8UZoqy5vsdnO7Hn9KY3ygbT-Re1zUw@mail.gmail.com>
 <CY8PR12MB7435D0FB256074CE1341DE5B85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435D0FB256074CE1341DE5B85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Mar 2025 17:46:27 -0400
X-Gm-Features: AQ5f1JoFvxbPxiLTsSWkBINN0LVkkiHs3JthE-oIa2wOkpP55PSbMpvHlC9RiO8
Message-ID: <CADnq5_NGjDhmhw+iMiSFLw+uNFveb5Cv6WArq6CPcrT=pN1MYA@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>
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

On Fri, Mar 14, 2025 at 10:43=E2=80=AFAM Kim, Jonathan <Jonathan.Kim@amd.co=
m> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, March 13, 2025 10:38 AM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; amd-
> > gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.co=
m>;
> > Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu, Jiadong
> > <Jiadong.Zhu@amd.com>
> > Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism =
by
> > removing dynamic callbacks
> >
> > I think as long as the locking is correct, the src shouldn't matter.
> > You just need to stop the kernel queues (and save state) and evict the
> > user queues (since HWS is responsible for saving the MQDs of the
> > non-guilty user queues).  If KFD detected the hang (e.g., queue
> > eviction fails when called for memory pressure, etc.), we just need to
> > make sure that it's ok for the sdma reset routine to call evict queues
> > again even if it was already called (presumably it should exit early
> > since the queues are already evicted).  If KGD initiates the reset, it
> > will call into KFD to evict queues.  We just need to make sure the
> > evict queues function we call just evicts the queues and doesn't also
> > try and reset.
>
> If we're removing the src parameter, we need to be careful we don't end u=
p in a double lock scenario in the KFD.
> i.e. kgd inits reset -> kfd detects hang on kgd reset trigger and calls b=
ack to kgd -> amdgpu_amdkfd_suspend gets called again but is blocked on pre=
vious suspend call from original kgd reset (which is holding a bunch of KFD=
 locks) while KFD is trying to clean up immediately.
>

How would this work even with the src parameter?  I think you could
still get into that case.  E.g., KGD detects a hang and initiates an
engine reset.  In parallel, KFD tries to unmap all queues for some
reason and detects a hang, so it tries to reset SDMA.  Assuming there
is a lock that protects SDMA reset, that should work.  However, it
requires that the prerequisites on each side don't attempt to reset
anything.

sdma_engine_reset()
{

KFD pre reset requirements
1. unmap all SDMA queues (CP firmware will save non-guilty state in MQDs)
2. detect guilty queue

KGD pre reset requirements:
1. stop relevant drm schedulers
2. detect guilt queue
3. save non-guilty queue state

Do engine reset

KGD post reset requirements:
1. restore non-guilty queue state
2. start relevant drm schedulers

KFD post reset requirements
1. map all non-guilty SDMA queues

}

I think what we need on the KFD side, if we don't have it already, is
a function to just umap queues and update guilty state, but not to
attempt to reset anything.  Then on the KFD side, in your normal
flows, you could call this function to unamp queues and update queue
state, and then after calling that walk through the queue state and
trigger any resets based on queues flagged as bad.  On the KFD side,
in a normal flow you will have called this unmap and update state
function and now you have a list of bad queues.  You can then initiate
an engine reset for the engine the bad queue is on.  This is safe
because you've already unmapped the queues, so if the unmap queues
function gets called again from the sdma reset function, it will
return early as the queues are already unmapped and marked guilty if
they are.  The engine will reset, the reset sdma reset function will
clean up the KGD side and then call the KFD map_queues().  Once it
returns you are done.  If KGD detects the hang, it will call the sdma
reset function and that will call the KFD unmap queues and update
state function.  This will update the KFD side state, but not initiate
any resets.  The engine will then be reset and then the KGD state will
be restored and finally it will call the KFD map_queues() function to
remap the non-guilty queues.  At completion both sides should be
functional again.  I'm not too familiar with the KFD unmap and reset
flows, but I think they will need to be decoupled if they are
currently intermixed.

Alex

}


> Safest way to remove the parameter seems like to move the KFD suspend/res=
tore outside of the common call and have KGD call suspend/resume when it's =
calling the common call itself.
>



> Jon
>
> >
> > Alex
> >
> > On Wed, Mar 12, 2025 at 5:24=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@=
amd.com>
> > wrote:
> > >
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > >
> > >
> > >
> > >
> > >
> > > From: Koenig, Christian <Christian.Koenig@amd.com>
> > > Sent: Wednesday, March 12, 2025 4:39 PM
> > > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedeskto=
p.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> > <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> > > Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanis=
m by
> > removing dynamic callbacks
> > >
> > >
> > >
> > > Am 12.03.25 um 09:15 schrieb Zhang, Jesse(Jie):
> > >
> > > [SNIP9
> > >
> > > -
> > >
> > > +     gfx_ring->funcs->stop_queue(adev, instance_id);
> > >
> > >
> > >
> > > Yeah that starts to look good. Question here is who is calling
> > amdgpu_sdma_reset_engine()?
> > >
> > >
> > >
> > > If this call comes from engine specific code we might not need the
> > start/stop_queue callbacks all together.
> > >
> > >
> > >
> > >     Kfd and sdma v4/v5/v5_2 will call amdgpu_sdma_reset_engine, and
> > start/stop_queue callbacks are only implemented in sdmav4/sdmav5/sdma5_=
2.
> > >
> > >
> > > Why would the KFD call this as well? Because it detects an issue with=
 a SDMA
> > user queue  If yes I would rather suggest that the KFD calls the reset =
function of
> > the paging queue.
> > >
> > > Since this reset function is specific to the SDMA HW generation anywa=
y you don't
> > need those extra functions to abstract starting and stopping of the que=
ue for each
> > HW generation.
> > >
> > > kfd can't call reset function directly, unless we add a parameter src=
  to distinguish
> > kfd and kgd in reset function, like this:
> > >
> > > int (*reset)(struct amdgpu_ring *ring, unsigned int vmid, int src );
> > >
> > > As Alex said in another thread,
> > >
> > > We need to distinguish  kfd and kgd  in reset.
> > >
> > > If kfd triggers a reset, kgd must save healthy jobs and recover jobs =
after reset.
> > >
> > > If kgd triggers a reset, kgd must abandon bad jobs after reset.(and p=
erhaps kfd
> > needs to save its healthy jobs for recovery).
> > >
> > >
> > >
> > > If we can add a parameter, I am ok for that solution too.
> > >
> > >
> > >
> > > Additionally:
> > >
> > > For sdma6/7, when a queue reset fails, we may need to fall back to an=
 engine
> > reset for a attempt.
> > >
> > >
> > >
> > > Thanks
> > >
> > > Jesse
> > >
> > >
> > > Regards,
> > > Christian.
> > >
> > >
> > >
> > >
> > >
> > >
> > > Thanks
> > >
> > > Jesse
> > >
> > >
> > >
> > > Regards,
> > >
> > > Christian.
> > >
> > >
> > >
> > >       /* Perform the SDMA reset for the specified instance */
> > >
> > >       ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> > >
> > >       if (ret) {
> > >
> > > @@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_devic=
e
> > *adev, uint32_t instance_id, b
> > >
> > >               goto exit;
> > >
> > >       }
> > >
> > >
> > >
> > > -     /* Invoke all registered post_reset callbacks */
> > >
> > > -     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, lis=
t) {
> > >
> > > -             if (funcs->post_reset) {
> > >
> > > -                     ret =3D funcs->post_reset(adev, instance_id);
> > >
> > > -                     if (ret) {
> > >
> > > -                             dev_err(adev->dev,
> > >
> > > -                             "afterReset callback failed for instanc=
e %u: %d\n",
> > >
> > > -                                     instance_id, ret);
> > >
> > > -                             goto exit;
> > >
> > > -                     }
> > >
> > > -             }
> > >
> > > -     }
> > >
> > > +     gfx_ring->funcs->start_queue(adev, instance_id);
> > >
> > >
> > >
> > >  exit:
> > >
> > >       /* Restart the scheduler's work queue for the GFX and page ring=
s
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > >
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > >
> > > index fd34dc138081..c1f7ccff9c4e 100644
> > >
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > >
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > >
> > > @@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs
> > sdma_v4_4_2_ring_funcs =3D {
> > >
> > >       .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
> > >
> > >       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wai=
t_helper,
> > >
> > >       .reset =3D sdma_v4_4_2_reset_queue,
> > >
> > > +     .stop_queue =3D sdma_v4_4_2_stop_queue,
> > >
> > > +     .start_queue =3D sdma_v4_4_2_restore_queue,
> > >
> > >       .is_guilty =3D sdma_v4_4_2_ring_is_guilty,  };
> > >
> > >
> > >
> > >
> > >
> > >
