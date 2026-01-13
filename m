Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0116D2D10A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 14:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA0D10E4E5;
	Tue, 13 Jan 2026 14:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pCx94eqW";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A1D10E4DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:34:09 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dr9FT1X6Hz9tkX;
 Tue, 13 Jan 2026 14:34:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1768311245; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOD0WjKboRUIeKZRnS0GVhh/+SGEy84scST/0kSATnk=;
 b=pCx94eqWJOPzV8Z5+u3Oc1gBvtdE0q2Rh1b87yLF8aqzFM/bL+p0TXB2zdlbUuOq57Jgtn
 4G3aXFz6R8RHZSvceJjO83f1Ee3RcIVelSu2UxzqD3XntwbYv9JVTsdcvWXvy+CgawAWjW
 ZsAxpNVE/9tVFIga/KX0E7Tk1kaGHZbdCbkCuOScSWyuON8zcEHeyozDwgFjfTApcGPRlb
 Sr6izPubSgG3srJRzG3pBFMacZAcsPKMdRBnKUDjKSuvSVX1fZ2/l94fGtnrTedOBwR4QU
 qPanESTWZU1GabtKr+xniWAeNimfeUYn2dlyGP8Pg2x1ZflCsDqYp7FB9Md/iQ==
Message-ID: <8a8dbf04b6d13d67541dc2bc1fb91769def373c2.camel@mailbox.org>
Subject: Re: [PATCH 29/42] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>
Date: Tue, 13 Jan 2026 14:34:01 +0100
In-Reply-To: <08a6057a-7e95-4007-a4ee-ec8f6e3e5540@gmail.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-30-alexander.deucher@amd.com>
 <08a6057a-7e95-4007-a4ee-ec8f6e3e5540@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 7e6d197f6959147f1a3
X-MBO-RS-META: sjw1qho8yjkbms7dinpck4doizdnkinw
X-Mailman-Approved-At: Tue, 13 Jan 2026 14:12:54 +0000
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
Reply-To: phasta@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 2026-01-13 at 14:17 +0100, Christian K=C3=B6nig wrote:
> On 1/8/26 15:48, Alex Deucher wrote:
> > We only want to stop the work queues, not mess with the
> > pending list so just stop the work queues.

Ideally amdgpu could stop touching the pending_list altogether forever,
as discussed at XDC. Is work for that in the pipe? Is that what this
patch is for?

>=20
> Oh, yes please! I can't remember how long we have worked towards that.
>=20
> But we also need to change the return code so that the scheduler now re-i=
nserts the job into the pending list.

You're referring to false-positive timeouts. Porting users to that
typically consists of adding that return code and also removing
whatever the driver used to do to inject the non-timedout job into the
scheduler again.

How is that being done here?

P.

>=20
> Adding Philip on CC to double check what I say above.
>=20
> Regards,
> Christian.
>=20
> >=20
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 80572f71ff627..868ab5314c0d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6301,7 +6301,7 @@ static void amdgpu_device_halt_activities(struct =
amdgpu_device *adev,
> > =C2=A0			if (!amdgpu_ring_sched_ready(ring))
> > =C2=A0				continue;
> > =C2=A0
> > -			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
> > +			drm_sched_wqueue_stop(&ring->sched);
> > =C2=A0
> > =C2=A0			if (need_emergency_restart)
> > =C2=A0				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> > @@ -6385,7 +6385,7 @@ static int amdgpu_device_sched_resume(struct list=
_head *device_list,
> > =C2=A0			if (!amdgpu_ring_sched_ready(ring))
> > =C2=A0				continue;
> > =C2=A0
> > -			drm_sched_start(&ring->sched, 0);
> > +			drm_sched_wqueue_start(&ring->sched);
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job=
_signaled)
>=20

