Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E5FD7879C
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 16:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326BD10F03A;
	Fri, 19 Dec 2025 16:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bPLz0fC8";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D404E10F03A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 16:33:55 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7c730af8d69so1375531a34.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766162035; x=1766766835; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwlCeIRnkqM4EM2tZw3L6oK0NanH1zxGsc6ox46UU+g=;
 b=bPLz0fC8o2bbHT82jHhkYiJpE3AnxfWfHlzVQuGxKHaQD+l4yZVizrA/cb6R5c53hO
 5KaVWe819hdpNNc79Re2a7Qt012KSoTqVjn8u3D03TjVVbOGk5jymK8pwuv3pCkDCDGg
 NfAhSqBcIY17O6Q0iGyPOHfNC72wD8ZDcCG3PQbCbeQdahvSPtklbEvIIEH6MXjZ11gd
 7X10hsK8zHI1xQOt+iAhDvut+3jYkxwUipvwhYBs9UuDZ/6STh+ifqCm/tKwPTb6FzEh
 NVzDoRrsUShxNTSAQqbIv8cNL/4djfE2vZ9DQ22nr0rNLfkceWHD3aOEkc/ouQgm0qXl
 9QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162035; x=1766766835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nwlCeIRnkqM4EM2tZw3L6oK0NanH1zxGsc6ox46UU+g=;
 b=n9HQ//IeAhjYhq0OANA9qM56ShXug6XfqXLMXrDG+1nH795rB2bQRuzoS5+4UAsGV0
 uzN5y9kx10Ux5WDyoRyerLrAi5jlddmxj1bUTovtXEmVb6Bt+5YOiIzhQ0J0hggwNmgT
 nCYfijOSXdakInn3KcSz5OdOpLKJIgBIB8/mlVbPPoi89o61M3D7SnKDnTiqv2BdAfVx
 57Q9bGjuTzsCkWJSDSI+IxlH9Y38gDc0c1wC6fghn2T4/R0DJhtt6Zjxek40w/EY3/US
 O1cCK4sN9W6A6aOKsAs86zQr6HqoYTsbDLwwPd6vnaAWA6Ev3aaTZdKMB3RtduRlAZ6y
 xwIw==
X-Gm-Message-State: AOJu0YyE+s62rPbSYj0C/6qTsR1bUJ3rVR9qf8sBUo+lncZpWpPab4de
 HilcCGB1a9qyCkSD0Xay2LrvECFYOYJWIQcM2GzbPfeErQ+92/xbIAA2
X-Gm-Gg: AY/fxX4j+YftmOsPIODqJcTR8E+xXZm2gxmhtAE/H70eQ6JAZI5Ek5rxYyL2Hlu6ez5
 W+3jgFVCCKiZa+3zF3sS6A0VzmggoV6+UahWMHQFMIYnB5VB4d+4xnSu1Kdj/FxddZ+yha0Lcqf
 oW36DvuWX/onMn08oBXp8hTvwpvRZK2lUyNh2HP7d+ukR+ueJsNRBZbr+Qngw37U6RIlR7JufoJ
 O2F1vwKktHlIAU8UJ7IgFE6zyBZw+2UUm0hzTb3RwT+r7fj3zYpAhJOFO2XyUnEllNXVWsIpq22
 NGevuJUh2vFViZPAQF+2gAhFk27FfnsaMFUIzzn+qJASg/IK+tgZPskqnkumf7cjGeJD8bwkGFj
 uQhcfKRKYaPeGvZBPIwanV8/liNrXEgbbJWp0aHpd/Ejpjsfqr98iyepPU0RaTWYWFf+UCzB+PZ
 aMYOCY4nQkfDrLNC+cV4p0nV3pE5A=
X-Google-Smtp-Source: AGHT+IHo6uYzLAE9FBtquEe9ajO5XOcL8FpRw3mpSnxZb7nmfba45BK2bRtJKDCRBzm5P7DMKmrlqQ==
X-Received: by 2002:a05:6830:3488:b0:7cc:4d72:5870 with SMTP id
 46e09a7af769-7cc66a4b672mr1583705a34.15.1766162034820; 
 Fri, 19 Dec 2025 08:33:54 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667ec367sm1942634a34.23.2025.12.19.08.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 08:33:54 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6/7] drm/amdgpu/gfx9: rework pipeline sync packet sequence
Date: Fri, 19 Dec 2025 10:33:53 -0600
Message-ID: <7981459.W097sEU6C4@timur-max>
In-Reply-To: <CADnq5_OwQpWwMPywzApHMe-y2TS68217bTh3afwgjPYoOf9jtQ@mail.gmail.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
 <3069977.btlEUcBR6m@timur-max>
 <CADnq5_OwQpWwMPywzApHMe-y2TS68217bTh3afwgjPYoOf9jtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 19., p=C3=A9ntek 9:37:16 k=C3=B6z=C3=A9ps=C5=91 =C3=A1lla=
mokbeli z=C3=B3naid=C5=91 Alex Deucher=20
wrote:
> On Thu, Dec 18, 2025 at 9:36=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com>=20
wrote:
> > On 2025. december 18., cs=C3=BCt=C3=B6rt=C3=B6k 16:41:40 k=C3=B6z=C3=A9=
ps=C5=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> >=20
> > Deucher wrote:
> > > Replace WAIT_REG_MEM with EVENT_WRITE flushes for all
> > > shader types and PFP_SYNC_ME.  That should accomplish
> > > the same thing and avoid having to wait on a fence
> > > preventing any issues with pipeline syncs during
> > > queue resets.
> > >=20
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >=20
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 32 ++++++++++++++++++-------=
=2D-
> > >  1 file changed, 21 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index
> > > 7b012ca1153ea..d9dee3c11a05d
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -5572,15 +5572,26 @@ static void gfx_v9_0_ring_emit_fence(struct
> > > amdgpu_ring *ring, u64 addr, amdgpu_ring_write(ring, 0);
> > >=20
> > >  }
> > >=20
> > > -static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *rin=
g)
> > > +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
> > > +                                        uint32_t event_type,
> > > +                                        uint32_t
> >=20
> > event_index)
> >=20
> > >  {
> > >=20
> > > -     int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
> > > -     uint32_t seq =3D ring->fence_drv.sync_seq;
> > > -     uint64_t addr =3D ring->fence_drv.gpu_addr;
> > > +     amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> > > +     amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> > > +                       EVENT_INDEX(event_index));
> > > +}
> > >=20
> > > -     gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
> > > -                           lower_32_bits(addr),
> >=20
> > upper_32_bits(addr),
> >=20
> > > -                           seq, 0xffffffff, 4);
> > > +static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *rin=
g)
> > > +{
> > > +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) {
> > > +             gfx_v9_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH,
> >=20
> > 4);
> >=20
> > Is VS_PARTIAL_FLUSH necessary when we already have PS_PARTIAL_FLUSH?
> > When we wait for all PS to finish, wouldn't that imply that all VS had
> > already finished as well?
>=20
> I'm not sure.  The CP docs recommend all 3 if you want to wait for the
> engine to idle.

Alright, it doesn't hurt to have it here.

>=20
> > > +             gfx_v9_0_ring_emit_event_write(ring, PS_PARTIAL_FLUSH,
> >=20
> > 4);
> >=20
> > > +             gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH,
> >=20
> > 4);
> >=20
> > > +             amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME,
> >=20
> > 0));
> >=20
> > > +             amdgpu_ring_write(ring, 0x0);
> >=20
> > The above sequence just waits for all shaders to finish, but as far as I
> > understand it doesn't wait for memory writes and cache flushes. Please
> > correct me if I'm wrong about this. For that, I think we do need an
> > ACQUIRE_MEM packet. (And, if the ACQUIRE_MEM is done on the PFP then we
> > won't need the PFP_SYNC_ME.)
>=20
> There is already a RELEASE_MEM (the fence from the previous job) prior
> to this packet that would have flushed the caches.  We just want to
> block the PFP from further fetching until that is complete.  In the
> good case, the RELEASE_MEM would have handled pipeline idling and
> cache flushes so these would be effectively noops and in the reset
> case, we don't care because that bad job is gone anyway.  I guess
> probably all we really need is the PFP_SYNC_ME.
>=20
> Alex

RELEASE_MEM doesn't wait for the GPU to go idle, RELEASE_MEM just promises =
to=20
write to the given fence address when the specified operations (eg. shaders=
 and=20
cache flush) are complete. Here in the pipeline sync, we actually want to w=
ait=20
for the GPU to go idle, and AFAIK we need an ACQUIRE_MEM for that.

>=20
> > > +     } else {
> > > +             gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH,
> >=20
> > 4);
> >=20
> > > +     }
> > >=20
> > >  }
> > > =20
> > >  static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
> > >=20
> > > @@ -7404,7 +7415,7 @@ static const struct amdgpu_ring_funcs
> > > gfx_v9_0_ring_funcs_gfx =3D { .set_wptr =3D gfx_v9_0_ring_set_wptr_gf=
x,
> > >=20
> > >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> > >      =20
> > >               5 +  /* COND_EXEC */
> > >=20
> > > -             7 +  /* PIPELINE_SYNC */
> > > +             8 +  /* PIPELINE_SYNC */
> > >=20
> > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > >               2 + /* VM_FLUSH */
> > >=20
> > > @@ -7460,7 +7471,7 @@ static const struct amdgpu_ring_funcs
> > > gfx_v9_0_sw_ring_funcs_gfx =3D { .set_wptr =3D amdgpu_sw_ring_set_wpt=
r_gfx,
> > >=20
> > >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> > >      =20
> > >               5 +  /* COND_EXEC */
> > >=20
> > > -             7 +  /* PIPELINE_SYNC */
> > > +             8 +  /* PIPELINE_SYNC */
> > >=20
> > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > >               2 + /* VM_FLUSH */
> > >=20
> > > @@ -7521,7 +7532,7 @@ static const struct amdgpu_ring_funcs
> > > gfx_v9_0_ring_funcs_compute =3D { 20 + /* gfx_v9_0_ring_emit_gds_swit=
ch */
> > >=20
> > >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> > >               5 + /* hdp invalidate */
> > >=20
> > > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > > +             2 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > >=20
> > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > >               8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user
> >=20
> > fence, vm fence */
> >=20
> > > @@ -7564,7 +7575,6 @@ static const struct amdgpu_ring_funcs
> > > gfx_v9_0_ring_funcs_kiq =3D { 20 + /* gfx_v9_0_ring_emit_gds_switch */
> > >=20
> > >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> > >               5 + /* hdp invalidate */
> > >=20
> > > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > >=20
> > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > >               8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user
> >=20
> > fence, vm fence */




