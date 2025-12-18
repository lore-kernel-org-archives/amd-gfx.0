Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C8BD6E2DD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 19:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6800910EA50;
	Thu, 18 Dec 2025 19:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIhardxm";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C376410EA50
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 19:02:27 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7b8c7a4f214so56982b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 11:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766084547; x=1766689347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+mUHZMw1g4Or9sUxIfztMgJ0bdU7LDbTuBZE9aeFzM=;
 b=MIhardxmU+krCG/4lKkz90jCu8azmCozInQRGSsvvBY/bPBLuPcrqPX6iCq5TXRXi/
 FyXB+v+BsHAnL61WtgHPlSaLoXDvvellWw3lyLlVXXNCZZiSbYDTBEn/IgxviuVdSw73
 dBzILUIi1SB6/Ppk9pNGvwGxuzvoJmTF3w6Sw8wn8baaKQaoBrhJTl+bhK8NE63aeVPf
 2OLRupNBJaGxgWBN7tNJNiGzA0i5pCm2IS6B7LyFfmo45UavTnLONGv3lzApn+OOcec+
 aJzcvbRo2B+t9D4Qisg+mG31SOKIx0b5bbhZt4sAUS/h4YMo0N764RCkXrS9t4/OkxRT
 3Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084547; x=1766689347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4+mUHZMw1g4Or9sUxIfztMgJ0bdU7LDbTuBZE9aeFzM=;
 b=f9/dzsmK2MTUDc7U8snUbO+LUnGw5BuJiaWV2NeD2W6vEHKCnEvAloutuvIdQiFf/M
 eXwX1wJ21CGIOn1ADlN+sNdNFHHytYfs+P9CWrVWldSXiGS7ZHkTctiugk6MqQ5IeX9a
 l9FakUJly6I65kJE25dqq1rUA3W4pxX+grJANBihEYaaU7yJH3WhO0lO8VRzgEfagtb1
 kVFemyuSmG7DWt7La6X8Urvz6e/gz6HJHVupOz6U54mq8pndI962Si9erv9jd5qe3UDS
 Kb34N+DQQfrJC+zGcf6Ll6Cpni3HV46pCKfgSy9zxxORuhsY3DOI1kCaQsDMP6Ukh/ee
 QIPA==
X-Gm-Message-State: AOJu0YwMWsXOSZ7+6fWghgg7QVQfrV42HY1AqnQK1dRCLGDvQmQMFPFv
 a/Uv9z3vtPL9Wc5prw1gMLR+8bwwih7HHNCoYN6jext1oG8f9hi0S5fYUyRGRisIdN6A/gPCD5+
 OSW7UDjaAqWLIkF+EKXQEm9BJXtli3FU=
X-Gm-Gg: AY/fxX69m2zHrY0QnH2yScPKYWQWxui+iq3+jCMW6yRkJjRwqvyFrQPWCl0pIgf3Gc0
 23y17civ3NANwJro0nt6TQpUGIbatCenVUsY2eGnT9M7O3iflb7Udw+LwfO9oXGgZrWrKkTk59M
 DGQta0pAHbNpX8N93Dt/MNZcMgwtXCgPDsjKFpex+1jmNBL0YhymODcowqHrPjcKjKgG4SKsNOi
 wbSV2YTUFjFtmzzvT8L5vkt/3fSnP2E7keFlqJzE28ty0FeyhJbYhO5UXUhgCSPrKLk2/iG
X-Google-Smtp-Source: AGHT+IFMr++Cut/H6nogbQDV8RMCOSKvpBQOSZCslZiW4o1jMsPM+PHeY/TdcudVRPHWtJsg8K9o/6f9ErHT3IaMky4=
X-Received: by 2002:a05:7022:42a4:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-121722ecd23mr175560c88.4.1766084546771; Thu, 18 Dec 2025
 11:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <2952111.fDdHjke4Dd@timur-max>
 <CADnq5_OdBWFJJEAH9_YikzVXw-JcGCF1E6OnUhruw+_F0H9E3w@mail.gmail.com>
 <98350545.IzOArtZ34E@timur-max>
In-Reply-To: <98350545.IzOArtZ34E@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Dec 2025 14:02:14 -0500
X-Gm-Features: AQt7F2p7z3DLUywRTcAxZBCLcejlUF2NTL41l1jRZRwpx0qbMh0G_b3pkEWecF8
Message-ID: <CADnq5_OBNXGvJgJ7EuXU1pHydDLbwJZ4P_Hc2tkcxbbpWrEguw@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
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

On Thu, Dec 18, 2025 at 12:03=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On 2025. december 18., cs=C3=BCt=C3=B6rt=C3=B6k 9:58:45 k=C3=B6z=C3=A9ps=
=C5=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> Deucher wrote:
> > On Thu, Dec 18, 2025 at 12:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kris=
tof@gmail.com>
> wrote:
> > > On 2025. december 15., h=C3=A9tf=C5=91 10:07:11 k=C3=B6z=C3=A9ps=C5=
=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> > > Deucher>
> > > wrote:
> > > > GFX ring resets work differently on pre-GFX10 hardware since
> > > > there is no MQD managed by the scheduler.
> > > > For ring reset, you need issue the reset via CP_VMID_RESET
> > > > via KIQ or MMIO and submit the following to the gfx ring to
> > > > complete the reset:
> > > > 1. EOP packet with EXEC bit set
> > > > 2. WAIT_REG_MEM to wait for the fence
> > > > 3. Clear CP_VMID_RESET to 0
> > > > 4. EVENT_WRITE ENABLE_LEGACY_PIPELINE
> > > > 5. EOP packet with EXEC bit set
> > > > 6. WAIT_REG_MEM to wait for the fence
> > > > Once those commands have completed the reset should
> > > > be complete and the ring can accept new packets.
> > > >
> > > > However, because we have a pipeline sync between jobs,
> > > > the PFP is waiting on the fence from the bad job to signal so
> > > > it can't process any of the packets in the reset sequence
> > > > until that pipeline sync clears.  To unblock the PFP, we
> > > > use the KIQ to signal the fence after we reset the queue.
> > > >
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 104 ++++++++++++++++++++++=
+++-
> > > >  1 file changed, 101 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index
> > > > bb1465a98c7ca..9b7073650315e
> > > > 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > @@ -2410,8 +2410,10 @@ static int gfx_v9_0_sw_init(struct
> > > > amdgpu_ip_block
> > > > *ip_block) amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> > > >
> > > >       adev->gfx.compute_supported_reset =3D
> > > >
> > > >               amdgpu_get_soft_full_reset_mask(&adev-
> > > >
> > > >gfx.compute_ring[0]);
> > > >
> > > > -     if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_r=
eset)
> > > > +     if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_r=
eset)
> > >
> > > {
> > >
> > > >               adev->gfx.compute_supported_reset |=3D
> > >
> > > AMDGPU_RESET_TYPE_PER_QUEUE;
> > >
> > > > +             adev->gfx.gfx_supported_reset |=3D
> > >
> > > AMDGPU_RESET_TYPE_PER_QUEUE;
> > >
> > > > +     }
> > > >
> > > >       r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
> > > >       if (r) {
> > > >
> > > > @@ -7163,6 +7165,103 @@ static void gfx_v9_ring_insert_nop(struct
> > > > amdgpu_ring *ring, uint32_t num_nop) amdgpu_ring_insert_nop(ring,
> > > > num_nop -
> > > > 1);
> > > >
> > > >  }
> > > >
> > > > +static void gfx_v9_0_ring_emit_wreg_me(struct amdgpu_ring *ring,
> > > > +                                    uint32_t reg,
> > > > +                                    uint32_t val)
> > > > +{
> > > > +     uint32_t cmd =3D 0;
> > > > +
> > > > +     switch (ring->funcs->type) {
> > > > +     case AMDGPU_RING_TYPE_KIQ:
> > > > +             cmd =3D (1 << 16); /* no inc addr */
> > >
> > > What do you mean by "inc addr" in this context?
> >
> > It's part of the packet.  bit 16 controls whether the address is
> > incremented or not.  This function is basically the same as
> > gfx_v9_0_ring_emit_wreg(), but uses the ME to do the wait rather than
> > the PFP.  I could have alternatively added a new parameter to
> > gfx_v9_0_ring_emit_wreg() to select between PFP and ME.
>
> Thanks. I was just not familiar with this field of the packet.
>
> >
> > > > +             break;
> > > > +     default:
> > > > +             cmd =3D WR_CONFIRM;
> > > > +             break;
> > > > +     }
> > > > +     amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> > > > +     amdgpu_ring_write(ring, cmd);
> > > > +     amdgpu_ring_write(ring, reg);
> > > > +     amdgpu_ring_write(ring, 0);
> > > > +     amdgpu_ring_write(ring, val);
> > > > +}
> > > > +
> > > > +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *rin=
g,
> > > > +                                        uint32_t event_type,
> > > > +                                        uint32_t
> > >
> > > event_index)
> > >
> > > > +{
> > > > +     amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> > > > +     amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> > > > +                       EVENT_INDEX(event_index));
> > > > +}
> > > > +
> > > > +static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
> > > > +                           unsigned int vmid,
> > > > +                           struct amdgpu_fence *timedout_fence)
> > > > +{
> > > > +     struct amdgpu_device *adev =3D ring->adev;
> > > > +     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > > > +     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > > > +     unsigned long flags;
> > > > +     u32 tmp;
> > > > +     int r;
> > > > +
> > > > +     amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > > > +
> > > > +     spin_lock_irqsave(&kiq->ring_lock, flags);
> > > > +
> > > > +     if (amdgpu_ring_alloc(kiq_ring, 5 + 5)) {
> > > > +             spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > > > +             return -ENOMEM;
> > > > +     }
> > > > +
> > > > +     /* send the reset - 5 */
> > > > +     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << v=
mid);
> > > > +     gfx_v9_0_ring_emit_wreg(kiq_ring,
> > > > +                             SOC15_REG_OFFSET(GC, 0,
> > >
> > > mmCP_VMID_RESET), tmp);
> > >
> > > > +     /* emit the fence to clear the pipeline sync - 5 */
> > > > +     gfx_v9_0_ring_emit_fence_kiq(kiq_ring, ring->fence_drv.gpu_ad=
dr,
> > > > +                                  timedout_fence->base.seqno,
> > >
> > > 0);
> > >
> > > As far as I see, this isn't going to work when sched_hw_submission > =
2 and
> > > there are more than two jobs (from various different userspace proces=
ses)
> > > emitted in the ring.
> > >
> > > I can think of two possible solutons:
> > > - Emit each fence individually, with a short delay in between to give=
 a
> > > chance to the GFX ring to catch up with the KIQ.
> > > - Change the wait_reg_mem command used for the pipeline sync to allow
> > > greater than equal instead of just equal. Then it's enough to signal =
just
> > > the last fence on the KIQ ring.
> >
> > That won't work.  The signalling patch is asynchronous so if we signal
> > additional fences other than the bad one, those jobs will end up being
> > seen as successfully completed.
>
> Yeah, I already realized that after I sent the email, and sent a follow-u=
p
> email with a different suggestion, that is to change the pipeline sync to=
 not
> rely on the fence of the previous submission. eg. the pipeline sync could=
 emit
> a separate fence, or even simpler, an ACQUIRE_MEM (gfx9+) / SURFACE_SYNC
> (gfx6-8). Then this becomes a non-issue.
>
> What do you think about that?

We could try it.  We need to verify that the ACQUIRE_MEM semantics
match what we need.
I think the following would also work and not require a WAIT_REG_MEM:

EVENT_WRITE(VS done)
EVENT_WRITE(PS done)
EVENT_WRITE(CS done)
PFP_SYNC_ME

I'll give it a try.

>
> > That said, there is a change coming
> > for the firmware to fix this.
>
> That's very nice to hear that AMD is still willing to fix firmware for ol=
d chips
> like Vega. However,
>
> - Would be nice to solve the problem for users who are still running old
> firmware, as it doesn't seem too difficult to do so.
> - AFAIK gfx7-8 also use the same queue reset mechanism so I think they ma=
y be
> susceptible to the same issue (and I don't think anyone's gonna release n=
ew FW
> for those).
>
> > I'd suggest we just limit the queue
> > depth to 2 until the new firmware is available.
>
> Last I heard of it, the SteamOS kernel set it to 4 due to "CPU bubbles" t=
hat
> they observed with the default setting of 2 on the Steam Deck. I think on=
 the
> long term we should seriously consider increasing the default in upstream=
 as
> well.

Ok.

>
> >
> > > > +     amdgpu_ring_commit(kiq_ring);
> > > > +     r =3D amdgpu_ring_test_ring(kiq_ring);
> > > > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > > > +     if (r)
> > > > +             return r;
> > > > +
> > > > +     if (amdgpu_ring_alloc(ring, 8 + 7 + 5 + 2 + 8 + 7))
> > > > +             return -ENOMEM;
> > > > +     /* emit the fence to finish the reset - 8 */
> > > > +     ring->trail_seq++;
> > > > +     gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > > > +                              ring->trail_seq,
> > >
> > > AMDGPU_FENCE_FLAG_EXEC);
> > >
> > > > +     /* wait for the fence - 7 */
> > > > +     gfx_v9_0_wait_reg_mem(ring, 0, 1, 0,
> > > > +                           lower_32_bits(ring-
> > > >
> > > >trail_fence_gpu_addr),
> > > >
> > > > +                           upper_32_bits(ring-
> > > >
> > > >trail_fence_gpu_addr),
> > > >
> > > > +                           ring->trail_seq, 0xffffffff, 4);
> > > > +     /* clear mmCP_VMID_RESET - 5 */
> > > > +     gfx_v9_0_ring_emit_wreg_me(ring,
> > > > +                                SOC15_REG_OFFSET(GC, 0,
> > >
> > > mmCP_VMID_RESET), 0);
> > >
> > > > +     /* event write ENABLE_LEGACY_PIPELINE - 2 */
> > > > +     gfx_v9_0_ring_emit_event_write(ring, ENABLE_LEGACY_PIPELINE, =
0);
> > > > +     /* emit a regular fence - 8 */
> > > > +     ring->trail_seq++;
> > > > +     gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > > > +                              ring->trail_seq,
> > >
> > > AMDGPU_FENCE_FLAG_EXEC);
> > >
> > > > +     /* wait for the fence - 7 */
> > > > +     gfx_v9_0_wait_reg_mem(ring, 1, 1, 0,
> > > > +                           lower_32_bits(ring-
> > > >
> > > >trail_fence_gpu_addr),
> > > >
> > > > +                           upper_32_bits(ring-
> > > >
> > > >trail_fence_gpu_addr),
> > > >
> > > > +                           ring->trail_seq, 0xffffffff, 4);
> > >
> > > Why is it necessary to emit (and wait for) a regular fence here?
> > > I'm not against it, just curious why it's needed.
> >
> > It's part of the recovery sequence to make sure the
> > ENABLE_LEGACY_PIPELINE event has completed successfully.
>
> Ah, okay. I didn't realize that we needed fences after EVENT_WRITE.
>
> >
> > > > +     amdgpu_ring_commit(ring);
> > > > +     /* wait for the commands to complete */
> > > > +     r =3D amdgpu_ring_test_ring(ring);
> > > > +     if (r)
> > > > +             return r;
> > > > +
> > > > +     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > > +}
> > > > +
> > > >
> > > >  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> > > >
> > > >                             unsigned int vmid,
> > > >                             struct amdgpu_fence *timedout_fence)
> > > >
> > > > @@ -7441,9 +7540,9 @@ static const struct amdgpu_ring_funcs
> > > > gfx_v9_0_ring_funcs_gfx =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wre=
g,
> > > >
> > > >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> > > >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg=
_wait,
> > > >
> > > > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> > >
> > > Can you please split removing the soft recovery into a separate patch=
?
> > >
> > > Can we talk about removing the soft recovery? For the other chips whe=
re it
> > > has already been removed, it is percieved by users as a regression.
> >
> > Queue reset is superset of soft recovery.  There's no need for soft
> > recovery when queue reset is available.
> >
>
> I'm not arguing for or against either approach, just relaying how the cha=
nge
> is percieved by users who tell their experience.
>
> From a user's perspective:
> - queue reset just kills the entire job and the offending process, ie. th=
e user
> sees the game crash
> - soft recovery sometimes allows the guilty process to move on intact, ie=
. the
> user would see a "hitch" in the game but then it would keep working
>

Ah, I see what you mean.  We do set the error on the fence in that
case, but I guess mesa treats it differently (-ENODATA vs. -ETIME).
We can think about bringing it back assuming it doesn't negatively
impact the per queue resets.

Alex

>
> >
> > > >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> > > >       .emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> > > >
> > > > +     .reset =3D gfx_v9_0_reset_kgq,
> > > >
> > > >       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> > > >       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
> > > >
> > > >  };
> > > >
> > > > @@ -7542,7 +7641,6 @@ static const struct amdgpu_ring_funcs
> > > > gfx_v9_0_ring_funcs_compute =3D { .emit_wreg =3D gfx_v9_0_ring_emit=
_wreg,
> > > >
> > > >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> > > >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg=
_wait,
> > > >
> > > > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> > > >
> > > >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> > > >       .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
> > > >       .reset =3D gfx_v9_0_reset_kcq,
>
>
>
>
