Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E84C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 15:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538FC10E4D8;
	Thu, 29 Feb 2024 15:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LfQ6B6Ow";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D164A10E4D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 15:49:26 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so946046a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709221766; x=1709826566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnvT5oQTqGjY0VaQGfW2doUUx9u0AS3HmFr6WHk8tJs=;
 b=LfQ6B6Ow/z/Fz5LQ2fv2PgYNzcHTAJIfpsBafTu7nSGZZM9Cf3dyzyqdVniSQaZECK
 Kja2ToDpKkcCLnhKb3IRgMj/Y9klWagyqdZA76LYuchmjMMbheFrUTnCkZ3TsFr5VKXR
 MO5ef854d119hi618Y7Ue1rw677K7VYacyRcYzHfFRfcvB7ZiUg1UyULp08D/JrHlTSe
 GvgxVaGxrRpDsjM63KZPqvDC+7kZrTDg09xRHYP3ZsjiJwyAuE7bNhki9lus3NtJzm5j
 33LHDeEoU9VgQrHCABkMNoTttE87SyXZydWc0PyTsLSmELtXnuXb7NEx7hTalpsCH9Ya
 XFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709221766; x=1709826566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnvT5oQTqGjY0VaQGfW2doUUx9u0AS3HmFr6WHk8tJs=;
 b=GedjKQcpiIyJ678z1F/1fefaP2MVuw7d83tYdGuogJWM0VUq5QkxWgOceLwk0psKen
 erkFL/PZMJb4FlG/zVr0shebXhWbwDpU/wgUPftAyAL1TlGDV9V4rTiHP1MPsEPS/pJA
 cOjqaLcIcXF4MdNxPt8vonL2P9r+XaruSptbkT22x1gINUf4yuQk2nHiEerHl2XxzON7
 3uQ6sje301i9pr04mj8kCjcSU32pnCJB3e/C3C5RyEjy0Ea2qTBDWWd+KSg9P7RmRb3x
 pn8gCIeQcUsWxhdLe/uoDkpez5rB7+BfaPvd/lRIeMWSrDEPsfVVBVm8rPb6dSwupn96
 5Ujg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXlXjs6kA9NE6On9J5aKVmxhCpV+T+vjvIN3lvMYuq+l+HfGF3xSKAuz8nfAfHeaw482icLPO9m1GFTaRa8qfc+AS2UJmgvQXScH1oGg==
X-Gm-Message-State: AOJu0YwG9by1ylnPrpT+E5H+eW8R+Wgr6XVy1XgSq6cyVVcUjObHAe+9
 JmP4YU3dbwz0vZ90XcSyr8HF28IYskadvmNFEKA5wa5WDUXV1tGMm1PT1Qvp9Mp2a4v0Q/XNiga
 nvnLopN6OiBEtckcBLjW/A9yhZSg=
X-Google-Smtp-Source: AGHT+IEqFQOIvwh4gFnYNle5i0uKugya1gHolmOFhpx6HsVevcfldJAS6tYVXKAJyLIpy/N3CUdUdQ/X4nAypfee/fw=
X-Received: by 2002:a17:90a:c49:b0:29a:8d4f:a19a with SMTP id
 u9-20020a17090a0c4900b0029a8d4fa19amr2514729pje.29.1709221766071; Thu, 29 Feb
 2024 07:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20240227184847.3078099-1-alexander.deucher@amd.com>
 <7e13e8d8-e486-4739-9844-f0b95861d34c@gmail.com>
 <CADnq5_OSLcbSX2H4b72YRVGz7GQqHg-8bcNWxdUdcoqAwP=dsg@mail.gmail.com>
 <d9a450ed-5632-42ce-b53c-e70b71762606@gmail.com>
In-Reply-To: <d9a450ed-5632-42ce-b53c-e70b71762606@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Feb 2024 10:49:14 -0500
Message-ID: <CADnq5_OLyZbFnhkhTAB0MGFexHE3iBuf2XU+KqETwCv9TN7reA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amd: Remove freesync video mode amdgpu
 parameter"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Feb 28, 2024 at 9:45=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 28.02.24 um 15:23 schrieb Alex Deucher:
> > On Wed, Feb 28, 2024 at 2:03=E2=80=AFAM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 27.02.24 um 19:48 schrieb Alex Deucher:
> >>> This reverts commit e94e787e37b99645e7c02d20d0a1ba0f8a18a82a.
> >>>
> >>> This conflicts with how compositors want to handle VRR.  Now
> >>> that compositors actually handle VRR, we probably don't need
> >>> freesync video.
> >>>
> >>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985
> >> Scratching my head what actually happens here? Doesn't the problem the=
n
> >> just depend on a module parameter?
> > Yes.  The problem is that when freesync video is enabled, compositors
> > don't know which modes are actual modes and which are a VRR video
> > mode.  There are still customers that want the vrr video mode smooth
> > video playback, but compositors don't want this by default.  I guess
> > the alternative is to just drop this feature altogether now that
> > compositors and media players are starting to support this properly.
>
> That's what I would suggest as well.
>
> As far as I can see adding those modes is actually buggy behavior and we
> need to avoid it.

Well, they work as expected for the use case they were added for,
video playback with different refresh rates without a modeset.  I'll
apply then as is for now and then work on a set of patches to remove
the functionality.

Alex


>
> Christian.
>
> >
> > Alex
> >
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++++++++++++++=
++++
> >>>    2 files changed, 28 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu.h
> >>> index 0e365cadcc3fc..925026c183f41 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> @@ -194,6 +194,7 @@ extern int amdgpu_emu_mode;
> >>>    extern uint amdgpu_smu_memory_pool_size;
> >>>    extern int amdgpu_smu_pptable_id;
> >>>    extern uint amdgpu_dc_feature_mask;
> >>> +extern uint amdgpu_freesync_vid_mode;
> >>>    extern uint amdgpu_dc_debug_mask;
> >>>    extern uint amdgpu_dc_visual_confirm;
> >>>    extern int amdgpu_dm_abm_level;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_drv.c
> >>> index 15a8a64fc4e28..82b154b103f43 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> @@ -199,6 +199,7 @@ int amdgpu_mes_kiq;
> >>>    int amdgpu_noretry =3D -1;
> >>>    int amdgpu_force_asic_type =3D -1;
> >>>    int amdgpu_tmz =3D -1; /* auto */
> >>> +uint amdgpu_freesync_vid_mode;
> >>>    int amdgpu_reset_method =3D -1; /* auto */
> >>>    int amdgpu_num_kcq =3D -1;
> >>>    int amdgpu_smartshift_bias;
> >>> @@ -883,6 +884,32 @@ module_param_named(damageclips, amdgpu_damage_cl=
ips, int, 0444);
> >>>    MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 =3D auto (default), =
0 =3D off, 1 =3D on)");
> >>>    module_param_named(tmz, amdgpu_tmz, int, 0444);
> >>>
> >>> +/**
> >>> + * DOC: freesync_video (uint)
> >>> + * Enable the optimization to adjust front porch timing to achieve s=
eamless
> >>> + * mode change experience when setting a freesync supported mode for=
 which full
> >>> + * modeset is not needed.
> >>> + *
> >>> + * The Display Core will add a set of modes derived from the base Fr=
eeSync
> >>> + * video mode into the corresponding connector's mode list based on =
commonly
> >>> + * used refresh rates and VRR range of the connected display, when u=
sers enable
> >>> + * this feature. From the userspace perspective, they can see a seam=
less mode
> >>> + * change experience when the change between different refresh rates=
 under the
> >>> + * same resolution. Additionally, userspace applications such as Vid=
eo playback
> >>> + * can read this modeset list and change the refresh rate based on t=
he video
> >>> + * frame rate. Finally, the userspace can also derive an appropriate=
 mode for a
> >>> + * particular refresh rate based on the FreeSync Mode and add it to =
the
> >>> + * connector's mode list.
> >>> + *
> >>> + * Note: This is an experimental feature.
> >>> + *
> >>> + * The default value: 0 (off).
> >>> + */
> >>> +MODULE_PARM_DESC(
> >>> +     freesync_video,
> >>> +     "Enable freesync modesetting optimization feature (0 =3D off (d=
efault), 1 =3D on)");
> >>> +module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0=
444);
> >>> +
> >>>    /**
> >>>     * DOC: reset_method (int)
> >>>     * GPU reset method (-1 =3D auto (default), 0 =3D legacy, 1 =3D mo=
de0, 2 =3D mode1, 3 =3D mode2, 4 =3D baco)
>
