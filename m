Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE09C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 10:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8FE10EFA1;
	Wed, 15 Jul 2026 10:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JuJ08DtY";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19E010EFA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 10:36:49 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso40035105e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784111808; x=1784716608; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uwikydqAPNvQJ5O/6QTuNKSRo1ITZWbCAh46fKa20Fw=;
 b=JuJ08DtY4HeaK6NFJf6PyVu7x1JT1aYdra+4841AfWVNe6AUkfIxKedxm+8nFLvx8k
 TdBHmA2qFPaR7XHsMBvQ8IGgD+6FyVVqTZlDMlSk2f9ztah3SkTHQR4nk7TcjXkqlGL5
 CgxfOTd3wAfCXJ3mfJPfbpKsD30nqlAxfE/nn3Eb41hvOK2zeBoEjW4drnchrTjOnvf9
 DOCT5YfqIqaBQ2NnawkG4fgdrA3V5+shrFMrFWva6BJHVPEYDZ17EcrYtK5IGc2Ji8QC
 dzqeq9U7b1B8I5PLZkgeoHJCCAV1d8mx0d84qxejO0YvGCmFGh2snM1Ke1uIYyA7gN+r
 JweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784111808; x=1784716608;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uwikydqAPNvQJ5O/6QTuNKSRo1ITZWbCAh46fKa20Fw=;
 b=alJf2IBL11wnQXDcckfIlUK1FcJVRWl/AVnWyNsQiG53wweWtfBtfz9AL4ejQtuyBr
 QFw+9F5+JmcTvnfO3XNF0r1XYVUyCxADDH09AAUJrTRUcxZ1EXvO1NYrfwTQCSSVtQ3s
 fCk1XibMIonl62qCOBwvigwno7FS0sXT0bMKtPPVdWR9xDGlXu0VQ7IUzCi9zeOFPTXu
 TfeKV+zb9cB48Vc9fjOYRen0DcejWpqFfBlWauCHABwR1rigtAH/WGxutmPPU7JgHHDH
 4/LbrOtdHggfxRWG8lAse0/68TrjIza47AGkl8xGhfA4xKOYXWTg1RQrK0m3/hQs3LDr
 qVrQ==
X-Gm-Message-State: AOJu0Yz4ncwaUcDLtlp6Hm3P1NZLl5G7o1+w0nMD+/o13wI8nLxCh7d9
 AwQ5chMWQhv3ywYFOzqVZqqgsvuzvbex4TImGqpBTbqLPbrzF/MP5gEikJRIYQ==
X-Gm-Gg: AfdE7clgsEGeg5dgszw0LPmkKZ6R2zkUDU3SCKKbznn19/R28nGslsUGFOMlNzAJDOc
 8v6DsbfSxEb4UzWk++uwOhGYTnKyQQnq6kjdIxHB6rmQODFhFmfPlCBCldrMyrKcaJXyva4E6hp
 j9dGIR0x88XgdsisaB4ef0N+7QNPAsaUiWV6BkdM9aAlVVwORJiBPncAT3p2UV63SNh/a5rYuow
 oKWvLsvQo/rWtYn8UdruOyxPBYc0fedLpXjQ5OnKj66W+AKBp16/mS9NEA3BtncG+pQOmJu8Tcj
 Gy8OkOYzibgK4rFVZ54EAcaY0Jm6gzMXgDhAFxMhwERR1jRLn6ZbS7CCIvdzjIPXYcedx/Yty84
 46ci/H51PAGWa/O2D/1mIBuVLg9DywmuSVSC1Z/MyRTgVqPuA62u07uZ0pc/F3MjCDRiIiyWect
 5cy8FIGnILGklmTsSLyTzMi05SHgYp8kFt53lB4vn69s09GF6zB4IBfmaanQKp+HlkI1Rq1+tsK
 hjhNvLN6C3z9g+DsCs=
X-Received: by 2002:a05:600c:1554:b0:493:dad1:e46a with SMTP id
 5b1f17b1804b1-4953c273e38mr24972815e9.21.1784111807734; 
 Wed, 15 Jul 2026 03:36:47 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c599049sm39225385e9.0.2026.07.15.03.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:36:47 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 5/9] drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
Date: Wed, 15 Jul 2026 12:36:45 +0200
Message-ID: <7296917.jJDZkT8p0M@timur-max>
In-Reply-To: <fb4f5735-2ccb-4a75-8d69-d776b3f3bb84@ursulin.net>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-6-timur.kristof@gmail.com>
 <fb4f5735-2ccb-4a75-8d69-d776b3f3bb84@ursulin.net>
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

On 2026. j=C3=BAlius 15., szerda 10:56:38 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > Implement the emit_switch_buffer() function instead of emitting
> > them duing emit_ib, emit_pipeline_sync and emit_vm_flush.
>=20
> during
>=20
> > Note that it isn't necessary to emit these in both
> > emit_pipeline_sync() and emit_vm_flush() because
> > amdgpu_vm_flush() already calls these when calling
> > either of those functions.
>=20
> The amdgpu_vm_flush indeed does emit two switch buffers:
>=20
> 	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC=20
*/
> 	if (ring->funcs->emit_switch_buffer) {
> 		amdgpu_ring_emit_switch_buffer(ring);
> 		amdgpu_ring_emit_switch_buffer(ring);
> 	}
>=20
> Comments are different though:
>=20
> /* sync CE with ME to prevent CE fetch CEIB before context switch done */
>=20
> Are you confident the two emissions are about the same thing?

Yes, I'm confident. One of the comments explains why the SWITCH_BUFFER pack=
et=20
is emitted, the other one explains why it is emitted outside COND_EXEC.

This packet is interpreted by the CE (constant engine). The reason why this=
=20
packet is emitted is basically to make sure the CE can't start executing=20
packets from the next submission until the current one is finished.

(Note that CE is not utilized by any maintained userspace driver and is=20
discontinued in new GPUs. As far as I remember there were experiments to tr=
y=20
to use the CE in Mesa but it didn't yield any noteworthy perf improvement s=
o=20
we just never used it. The old proprietary driver may have used it. It is n=
ow=20
also deprecated in the kernel.)


>=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 32 +++++++++------------------
> >   1 file changed, 10 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index 0ceadb107d26..a93cc02c3400
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -2201,12 +2201,6 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct
> > amdgpu_ring *ring,>=20
> >   	unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
> >   	u32 header, control =3D 0;
> >=20
> > -	/* insert SWITCH_BUFFER packet before first IB in the ring frame */
> > -	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> > -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,=20
0));
> > -		amdgpu_ring_write(ring, 0);
> > -	}
>=20
> Commit message does not explain why the change of ring buffer command
> this creates is okay. Current flow is:
>=20
> amdgpu_ib_schedule()
> {
> ...
>    amdgpu_ring_emit_ib
>      amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
>=20
>=20
> New flow is:
>=20
> ...
>    amdgpu_ring_emit_ib
> ... other ring commands ...
>    amdgpu_ring_emit_switch_buffer
>      amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));

No, that's not what the new flow is. If you check the callers of=20
emit_switch_buffer() you can see that it's called from two places:

=2D amdgpu_vm_flush() emits it before the first IB when necessary
=2D amdgpu_ib_schedule() emits it after the last IB when necessary

> Is this okay? Specifically due the above comment saying "insert
> SWITCH_BUFFER packet before first IB in the ring frame" - is the "first"
> part not important?

amdgpu_vm_flush() emits it before the first IB.

> Also, amdgpu_ib_schedule only emits amdgpu_ring_emit_switch_buffer if
> there is a job. Currently it is always emitted.

I trust that the GFX8+ implementations are more precise and that it's suffi=
cient=20
to emit this packet in the cases where the emit_switch_buffer() function is=
=20
called.

When there is "no job" that's a special case that is only used during=20
initialization (specifically the IB ring tests). In that case we are not=20
executing commands submitted by userspace but rather commands generated by =
the=20
kernel. So we can be sure the CE is not used in those cases.

>=20
> Final interesting part is how amdgpu_ib_schedule clears
> AMDGPU_HAVE_CTX_SWITCH after having called amdgpu_ring_emit_ib.
>=20
> After this change only gfx6 remains the user of that flag in
> gfx_v6_0_ring_emit_ib. Everyone else only use it in emit_cntxcntl. If
> gfx6 was adjusted too (later), amdgpu_ib_schedule could reduce the scope
> of that flag to just the scope where it calls amdgpu_ring_emit_frame_cntl.

I also adjusted the same thing for GFX6 in the next series.
Can clean up the flag later once both series are accepted.


>=20
> > -
> >=20
> >   	if (ib->flags & AMDGPU_IB_FLAG_CE)
> >   =09
> >   		header =3D PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
> >   =09
> >   	else
> >=20
> > @@ -2258,6 +2252,12 @@ static void gfx_v7_0_ring_emit_ib_compute(struct
> > amdgpu_ring *ring,>=20
> >   	amdgpu_ring_write(ring, control);
> >  =20
> >   }
> >=20
> > +static void gfx_v7_0_ring_emit_sb(struct amdgpu_ring *ring)
> > +{
> > +	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
> > +	amdgpu_ring_write(ring, 0);
> > +}
> > +
> >=20
> >   static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint3=
2_t
> >   flags) {
> >  =20
> >   	uint32_t dw2 =3D 0;
> >=20
> > @@ -3111,14 +3111,6 @@ static void gfx_v7_0_ring_emit_pipeline_sync(str=
uct
> > amdgpu_ring *ring)>=20
> >   	amdgpu_ring_write(ring, seq);
> >   	amdgpu_ring_write(ring, 0xffffffff);
> >   	amdgpu_ring_write(ring, 4); /* poll interval */
> >=20
> > -
> > -	if (usepfp) {
> > -		/* sync CE with ME to prevent CE fetch CEIB before=20
context switch done
> > */ -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,=20
0));
> > -		amdgpu_ring_write(ring, 0);
> > -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,=20
0));
> > -		amdgpu_ring_write(ring, 0);
> > -	}
> >=20
> >   }
> >  =20
> >   /*
> >=20
> > @@ -3160,12 +3152,6 @@ static void gfx_v7_0_ring_emit_vm_flush(struct
> > amdgpu_ring *ring,>=20
> >   		/* sync PFP to ME, otherwise we might get invalid PFP=20
reads */
> >   		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME,=20
0));
> >   		amdgpu_ring_write(ring, 0x0);
> >=20
> > -
> > -		/* synce CE with ME to prevent CE fetch CEIB before=20
context switch done
> > */ -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,=20
0));
> > -		amdgpu_ring_write(ring, 0);
> > -		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER,=20
0));
> > -		amdgpu_ring_write(ring, 0);
> >=20
> >   	}
> >  =20
> >   }
> >=20
> > @@ -4954,8 +4940,9 @@ static const struct amdgpu_ring_funcs
> > gfx_v7_0_ring_funcs_gfx =3D {>=20
> >   		7 + /* gfx_v7_0_ring_emit_hdp_flush */
> >   		5 + /* hdp invalidate */
> >   		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for=20
user fence, vm
> >   		fence */>=20
> > -		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
> > -		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /*=20
gfx_v7_0_ring_emit_vm_flush
> > */ +		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
> > +		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /*=20
gfx_v7_0_ring_emit_vm_flush
> > */ +		3 * 2 + /* gfx_v7_0_ring_emit_sb x3 (from=20
amdgpu_vm_flush,
> > amdgpu_ib_schedule) */>=20
> >   		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt=20
flush*/
> >   		5, /* SURFACE_SYNC */
> >   =09
> >   	.emit_ib_size =3D 4, /* gfx_v7_0_ring_emit_ib_gfx */
> >=20
> > @@ -4969,6 +4956,7 @@ static const struct amdgpu_ring_funcs
> > gfx_v7_0_ring_funcs_gfx =3D {>=20
> >   	.test_ib =3D gfx_v7_0_ring_test_ib,
> >   	.insert_nop =3D amdgpu_ring_insert_nop,
> >   	.pad_ib =3D amdgpu_ring_generic_pad_ib,
> >=20
> > +	.emit_switch_buffer =3D gfx_v7_0_ring_emit_sb,
> >=20
> >   	.emit_cntxcntl =3D gfx_v7_ring_emit_cntxcntl,
> >   	.emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> >   	.soft_recovery =3D gfx_v7_0_ring_soft_recovery,




