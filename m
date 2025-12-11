Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E418BD4414C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990FE10E58D;
	Fri, 12 Dec 2025 08:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Prj+fKjG";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB8210E77D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 14:02:08 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dRvR05w06z9tW6;
 Thu, 11 Dec 2025 15:02:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1765461724; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMNAhk17c1vHLwvUPvC3V3RCwRRg0tjNYVIFyXPsuiI=;
 b=Prj+fKjGAGJI2s8AgOFk52c5OFQX2LuE4iN8XF6316fhtyaKZnHhisxpP9vKrQSk8Uh1PA
 8xEKhzSkNzzNE9/h/yJTPgEOfRXnKpbHIV3U/4KmwUX5ueYie8CToSju2kuOcmqBDS/Qaj
 UhYn3wQh0O8UowUW/A1v6MoHYpMGt69GeCXsPVAkLfc1sc7zy6qBps5a4MHnVcJpIzs09Y
 rGoGF9Jmisuo8iB3gbUFvwUalDc8SYnS25EQtX7YjQP5hRI3H4afSLktjKtk/90k/dpCKs
 GUG1izu10yJKDkVb6kGktf5QJHI3buBR1wnrmYQWPZx1DTFlGi04zIAk3Zr52w==
Message-ID: <97536119a9dd1fd3b3b77081a00851eaf7636c36.camel@mailbox.org>
Subject: Re: [PATCH] drm/amdgpu: cache the pasid in amdgpu_device_gpu_recover
From: Philipp Stanner <phasta@mailbox.org>
To: Alex Deucher <alexdeucher@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>
Cc: phasta@kernel.org, alexander.deucher@amd.com,
 SRINIVASAN.SHANMUGAM@amd.com,  vitaly.prosyak@amd.com,
 amd-gfx@lists.freedesktop.org, Hans-Kristian Arntzen
 <post@arntzen-software.no>
Date: Thu, 11 Dec 2025 15:02:01 +0100
In-Reply-To: <CADnq5_OBM=E5XPXxFHyR6e4OVWrsa3qrAnqffCrkN9A9mh8eeg@mail.gmail.com>
References: <20251210125740.9551-1-christian.koenig@amd.com>
 <3c90635b46f1a867365fba026edbc28a33ad9d9d.camel@mailbox.org>
 <5f55a311-8924-44cd-af55-c0ccc4d20218@gmail.com>
 <CADnq5_OBM=E5XPXxFHyR6e4OVWrsa3qrAnqffCrkN9A9mh8eeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: j1sxdahwb6ijyskgw8xxa3s4bwhkfian
X-MBO-RS-ID: c41aad498ddab777f9e
X-Mailman-Approved-At: Fri, 12 Dec 2025 08:29:54 +0000
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

On Thu, 2025-12-11 at 08:46 -0500, Alex Deucher wrote:
> On Thu, Dec 11, 2025 at 7:44=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >=20
> > On 12/10/25 14:00, Philipp Stanner wrote:
> > > On Wed, 2025-12-10 at 13:57 +0100, Christian K=C3=B6nig wrote:
> > > > The job might already be freed up here. So cache the pasid for late=
r
> > > > use.
> > > >=20
> > > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Suggested-by: Philipp Stanner <phasta@mailbox.org>
> > >=20
> > > No! :D
> > >=20
> > > You read the wrong quote.
> > > Matthew found your issue (in the middle of my time zone's night, whil=
e
> > > I was peacefully asleep).
> >=20
> > Oh, good point. Sorry the credits go to Matthew of course.
> >=20
> > >=20
> > > > Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
> > >=20
> > > I think there was a gitlab ticket about that a month ago? Could be
> > > added to Closes:
> >=20
> > Yeah, I remember that as well but I can't find it of hand.
> >=20
> > Does anybody have the right link at hand?
>=20
> I looked for it yesterday, but couldn't find it.

I think the original reporter was Hans-Kristian (+Cc).

The link I had seen floating around was

https://github.com/HansKristian-Work/vkd3d-proton/pull/2670


P.

>=20
> Alex
>=20
> >=20
> > Thanks,
> > Christian.
> >=20
> > >=20
> > >=20
> > > P.
> > >=20
> > > > ---
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
> > > > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_device.c
> > > > index 654f4844b7ad..84bb89498e12 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -6506,8 +6506,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_d=
evice *adev,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 struct list_head device_list;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 bool job_signaled =3D false;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_hive_info *hive =3D NULL;
> > > > -=C2=A0=C2=A0=C2=A0 int r =3D 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 bool need_emergency_restart =3D false;
> > > > +=C2=A0=C2=A0=C2=A0 unsigned int pasid =3D job->pasid;
> > > > +=C2=A0=C2=A0=C2=A0 int r =3D 0;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If it reaches here because of hang=
/timeout and a RAS error is
> > > > @@ -6605,7 +6606,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_d=
evice *adev,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct amdgpu_task_info *ti =3D NULL;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (job)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti =3D amdgpu_vm_get_task_=
info_pasid(adev, job->pasid);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti =3D amdgpu_vm_get_task_=
info_pasid(adev, pasid);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti ? &ti->task : =
NULL);
> > >=20
> >=20

