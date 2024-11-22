Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE337D75E54
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 14:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCEA10EBA3;
	Fri, 22 Nov 2024 14:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZK8iYNe";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3E210EBA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 14:05:45 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7247888f092so244409b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 06:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732284345; x=1732889145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcYTaP+gBiWsNspWHGvTj1BfceIltQA+YnFE4v2OGtk=;
 b=lZK8iYNeoSWk7b0th/WR5/boBg3014MfaXEREfrEUC+tzKwChS2vIAedj1MZjT0ZTB
 dDgqpnxqr4wahwoQHdv6FxwM6GDlnJCGM0N15PBgTNREv/qjSgqUyHCIxmBJd6z4FNyP
 jPJooL5JG7oCJ2eQUH/ixdfUuomA3AEropUBnK8BjozfuRmK+4QvdIYD3RFbXpI9aooC
 ylb6e4FZA8nsUgZX883lvpSSYDY34Hz3nmaaoBkK9vafgNENHncR0FF8IqfMTXa2D4eM
 jBKMXAWoJDh8YGkeFEqmtHF+MAEi0+S0M37k00lp+Mntv0MuxIh8gpprVSwW9CYJq7V0
 SOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732284345; x=1732889145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcYTaP+gBiWsNspWHGvTj1BfceIltQA+YnFE4v2OGtk=;
 b=a6cTU/N/w0ySKSF2cP/XRLTvPAREwvysLtP0Cv0KNMjM/ak8jIhmcmzxuGSdPlCa1U
 8MHqcrRHxXs7Acx91IR6BW6+Ge8+gt62dvgpBabnR6+/NJ4tIstoAttqoBgi1h6iccVP
 JRs4fZLtZaSzlpOFp71bs2jsVtHNAz7sor4hj26o/HlUbA5zy/Q4NsfHyopvy/r8J9U+
 6s9x0Wzh/31eznuOicuUp8yLXFvRTQJZl02yYxZkMEcyTx/wOSbiyyBdD72yZLCsNdmn
 Y+KkMxQPEyl9SOAecU+/oDebXOVHG7+PJx41EphZtfXpQ8tCK+HWmfGukLWsDb4xZFbl
 jYLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgTOvUrNNTBGYPFjouDpcyEepeivyI1G0PMKrBPL5GbfTQilVQhUNGdAKP8LEo+5XDhbWjv/b+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS47X34K9d/99EuJ3TdaRcPwvmBKPi0zRbVFh3rNk9W0RquOwL
 fMXtLqIzF6Cyjn5+v1hds3o8QnU5FzSqiwN5JBj9Fb7rSHsRiTLC82ZVUj7XtH0T+2sUBvxFJrT
 l6eKl9Vv96tsWwxDCUYjokfQrV4c=
X-Gm-Gg: ASbGncuA6rOWsWcbHV5wPPpwgOtGdhpS50cj9b9dZQEkOO/qiaNJKA48m6x0DpV549q
 6YiTdEYqVIwX46KZazENKKxNXWnsCDzM=
X-Google-Smtp-Source: AGHT+IG2mMc8FGykqOnTB72zmS/FoKFS73NlCDdVbyt/1P2w8WkERK2IpVjBN0pyAOHtsefO4aIlvc4xt1cZCCgVfak=
X-Received: by 2002:a05:6a00:9299:b0:71e:6650:60f7 with SMTP id
 d2e1a72fcca58-724df677f84mr1611926b3a.5.1732284344837; Fri, 22 Nov 2024
 06:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20241118200323.16541-1-mario.limonciello@amd.com>
 <27b016a8-57e6-4ab2-ab5f-fafe1086e437@gmail.com>
In-Reply-To: <27b016a8-57e6-4ab2-ab5f-fafe1086e437@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Nov 2024 09:05:32 -0500
Message-ID: <CADnq5_NThhRpb-0KYgBcd8CSnuz+Qxh4df-P+aGebU_KK71MbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add Suspend/Hibernate notification callback
 support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <Alexander.Deucher@amd.com>
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

On Fri, Nov 22, 2024 at 5:03=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 18.11.24 um 21:03 schrieb Mario Limonciello:
> > As part of the suspend sequence VRAM needs to be evicted on dGPUs.
> > In order to make suspend/resume more reliable we moved this into
> > the pmops prepare() callback so that the suspend sequence would fail
> > but the system could remain operational under high memory usage suspend=
.
> >
> > Another class of issues exist though where due to memory fragementation
> > there isn't a large enough contiguous space and swap isn't accessible.
> >
> > Add support for a suspend/hibernate notification callback that could
> > evict VRAM before tasks are frozen. This should allow paging out to swa=
p
> > if necessary.
> >
> > Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> I'm absolutely not an expert on that stuff but it looks rather
> reasonable to me.
>
> Alex what do you think?

Yeah, same.  Seems reasonable to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 +++++++++++++++++++++=
+
> >   2 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index a37e687acbbc5..e70ca85151046 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -885,6 +885,7 @@ struct amdgpu_device {
> >       bool                            need_swiotlb;
> >       bool                            accel_working;
> >       struct notifier_block           acpi_nb;
> > +     struct notifier_block           pm_nb;
> >       struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> >       struct debugfs_blob_wrapper     debugfs_vbios_blob;
> >       struct debugfs_blob_wrapper     debugfs_discovery_blob;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index b3ca911e55d61..5a4e9c7daf895 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *ad=
ev,
> >   }
> >
> >   static inline void amdgpu_device_stop_pending_resets(struct amdgpu_de=
vice *adev);
> > +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsign=
ed long mode,
> > +                                  void *data);
> >
> >   /**
> >    * DOC: pcie_replay_count
> > @@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,
> >
> >       amdgpu_device_check_iommu_direct_map(adev);
> >
> > +     adev->pm_nb.notifier_call =3D amdgpu_device_pm_notifier;
> > +     r =3D register_pm_notifier(&adev->pm_nb);
> > +     if (r)
> > +             goto failed;
> > +
> >       return 0;
> >
> >   release_ras_con:
> > @@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *=
adev)
> >               drain_workqueue(adev->mman.bdev.wq);
> >       adev->shutdown =3D true;
> >
> > +     unregister_pm_notifier(&adev->pm_nb);
> > +
> >       /* make sure IB test finished before entering exclusive mode
> >        * to avoid preemption on IB test
> >        */
> > @@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct =
amdgpu_device *adev)
> >   /*
> >    * Suspend & resume.
> >    */
> > +/**
> > + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernat=
e events
> > + * @nb: notifier block
> > + * @mode: suspend mode
> > + * @data: data
> > + *
> > + * This function is called when the system is about to suspend or hibe=
rnate.
> > + * It is used to evict resources from the device before the system goe=
s to
> > + * sleep while there is still access to swap.
> > + *
> > + */
> > +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsign=
ed long mode,
> > +                                  void *data)
> > +{
> > +     struct amdgpu_device *adev =3D container_of(nb, struct amdgpu_dev=
ice, pm_nb);
> > +
> > +     switch (mode) {
> > +     case PM_HIBERNATION_PREPARE:
> > +     case PM_SUSPEND_PREPARE:
> > +             if (amdgpu_device_evict_resources(adev))
> > +                     return NOTIFY_BAD;
> > +             break;
> > +     }
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> >   /**
> >    * amdgpu_device_prepare - prepare for device suspend
> >    *
>
