Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D631E6916C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 15:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241CA10E048;
	Fri, 22 Nov 2024 15:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lu9UzRi/";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F63D10E048
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 15:59:53 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso301034a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732291193; x=1732895993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsvIL8OATX5DODT1KNON4kIgq9aqC1ap4pzUeZNmEgs=;
 b=lu9UzRi/j+FQwC0fEmpTUSnmpDOFuXNKF35AQ3th9nvURLU24Y4pVVZfaE3JxMPYev
 1e62ju+kGBc2Y51mefSzBaZaYJf6jjLqQzqPSlG4DcbbBM+1j5eIoKoJ787qkFYjh7t9
 f6rvT1oYd+W+IEkOAsF9amFZzJKtO3AffeHZQ6sKLDx5VcbnHqVEZHdIxNr3F8+n/cfK
 9Uy/Ab9QK4ssoxVDGg9PQ0tgMbUWool/JzVtIMgDE1Us9XQUd7UYf5r74hPKfPaOf0k1
 n6v4I7eHv6e8YJZRVdu8heI6F0WWFOM77BFKqd8h8Bzqfy+TSVyilNIdH/GJNRg/jnX5
 1csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732291193; x=1732895993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsvIL8OATX5DODT1KNON4kIgq9aqC1ap4pzUeZNmEgs=;
 b=rYIe2dOwRUSqLt0ON13kjiLqHOrp6yQGpjX9iR0MWH65GcTu3MHgYEnPa+8Vv0MfqH
 ip/rp++qeufowmBhtfOs/BKIOcmSUHU7OiGdA2IVG4d1cgTbzIBcD6qZXHxGPHtGf5XE
 ZJVul/UJ2ArPR1x80Yl7m2PGzEGOOzphLIQ5B32KFJj8/EEu7fMnH0fc7qD6UKpHtLeV
 5Uww2hT7ls+MIe7Da0zFCPG2k6FLxqHZgu3JXFARWUNLflMdaE0vgJtctPg7Mf4/qZWT
 540aUTUvBbcGp+nIRo2ZKcyygKqC1AUKeHXYJG5Rzdv8xbeNSUjkG/jgWVJK8XoqVfqv
 Ck2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLKBamuWHYbQUTRBWiSdyElHpGN72up4OyX7Xp8Pnkw9vXmMPrwP455maOSLspUz0h8xx+o871@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvdL+e9dq2ssTkF5bQU0cmjHvzqussnam7OjaSEFfHtewUtlru
 fREUMuN4sv5Odzc1P86ZdSIQwb5eGSGW7r6OBWXmVT1UVQoDlgsUdPnLaIufOQUcdtQvLOR3PD2
 0sk2vbT3VJPLz09mKIcQW4cCfV/E=
X-Gm-Gg: ASbGnct38YYZxAYNCTTpvdL7jyVBONbB2Vj2l8Pxcc10CrUDibVAymqD3nmMhmosmnx
 WnfsjL6+wb+eTVPfzMQEA/jITs/utqDs=
X-Google-Smtp-Source: AGHT+IExXnIsvsPRIaHFOV0iNCUd8HXEpOW8O/BV6jubKKLReMkCiaQKHirHqtMeTqT9IBMkirYlnoYgChsSJ1ysnV8=
X-Received: by 2002:a17:90b:3852:b0:2ea:6f96:64fa with SMTP id
 98e67ed59e1d1-2eb0e86ceb9mr1708921a91.7.1732291192768; Fri, 22 Nov 2024
 07:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20241118200323.16541-1-mario.limonciello@amd.com>
 <10227541-3d1b-4e48-9a17-b9c0dc25a541@amd.com>
 <01b16cb3-71e0-4f8d-b9ce-1c6b261475ce@amd.com>
In-Reply-To: <01b16cb3-71e0-4f8d-b9ce-1c6b261475ce@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Nov 2024 10:59:40 -0500
Message-ID: <CADnq5_OAxdt6QPn3+2s906iWinCM9--JtAJPnoS3yhSN3K6Eug@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add Suspend/Hibernate notification callback
 support
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Nov 22, 2024 at 10:57=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/22/2024 08:28, Lazar, Lijo wrote:
> >
> >
> > On 11/19/2024 1:33 AM, Mario Limonciello wrote:
> >> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
> >> In order to make suspend/resume more reliable we moved this into
> >> the pmops prepare() callback so that the suspend sequence would fail
> >> but the system could remain operational under high memory usage suspen=
d.
> >>
> >> Another class of issues exist though where due to memory fragementatio=
n
> >> there isn't a large enough contiguous space and swap isn't accessible.
> >>
> >> Add support for a suspend/hibernate notification callback that could
> >> evict VRAM before tasks are frozen. This should allow paging out to sw=
ap
> >> if necessary.
> >>
> >> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> >> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++=
++
> >>   2 files changed, 37 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h
> >> index a37e687acbbc5..e70ca85151046 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -885,6 +885,7 @@ struct amdgpu_device {
> >>      bool                            need_swiotlb;
> >>      bool                            accel_working;
> >>      struct notifier_block           acpi_nb;
> >> +    struct notifier_block           pm_nb;
> >>      struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> >>      struct debugfs_blob_wrapper     debugfs_vbios_blob;
> >>      struct debugfs_blob_wrapper     debugfs_discovery_blob;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index b3ca911e55d61..5a4e9c7daf895 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *a=
dev,
> >>   }
> >>
> >>   static inline void amdgpu_device_stop_pending_resets(struct amdgpu_d=
evice *adev);
> >> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsig=
ned long mode,
> >> +                                 void *data);
> >>
> >>   /**
> >>    * DOC: pcie_replay_count
> >> @@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *ad=
ev,
> >>
> >>      amdgpu_device_check_iommu_direct_map(adev);
> >>
> >> +    adev->pm_nb.notifier_call =3D amdgpu_device_pm_notifier;
> >> +    r =3D register_pm_notifier(&adev->pm_nb);
> >> +    if (r)
> >> +            goto failed;
> >> +
> >>      return 0;
> >>
> >>   release_ras_con:
> >> @@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device =
*adev)
> >>              drain_workqueue(adev->mman.bdev.wq);
> >>      adev->shutdown =3D true;
> >>
> >> +    unregister_pm_notifier(&adev->pm_nb);
> >> +
> >>      /* make sure IB test finished before entering exclusive mode
> >>       * to avoid preemption on IB test
> >>       */
> >> @@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct=
 amdgpu_device *adev)
> >>   /*
> >>    * Suspend & resume.
> >>    */
> >> +/**
> >> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hiberna=
te events
> >> + * @nb: notifier block
> >> + * @mode: suspend mode
> >> + * @data: data
> >> + *
> >> + * This function is called when the system is about to suspend or hib=
ernate.
> >> + * It is used to evict resources from the device before the system go=
es to
> >> + * sleep while there is still access to swap.
> >> + *
> >> + */
> >> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsig=
ned long mode,
> >> +                                 void *data)
> >> +{
> >> +    struct amdgpu_device *adev =3D container_of(nb, struct amdgpu_dev=
ice, pm_nb);
> >> +
> >> +    switch (mode) {
> >> +    case PM_HIBERNATION_PREPARE:
> >> +    case PM_SUSPEND_PREPARE:
> >> +            if (amdgpu_device_evict_resources(adev))
> >
> > This will result in an eviction call on APUs since the flags won't be
> > set by this time. Is that intended?
>
> Very good catch!  I will bump it and modify
> amdgpu_device_evict_resources() to just skip APUs entirely.

We can skip for suspend on APUs, but we need to keep it for hibernation.

Alex

>
> >
> > https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgp=
u/amdgpu_device.c#L4739
> >
> > Thanks,
> > Lijo
> >
> >> +                    return NOTIFY_BAD;
> >> +            break;
> >> +    }
> >> +
> >> +    return NOTIFY_DONE;
> >> +}
> >> +
> >>   /**
> >>    * amdgpu_device_prepare - prepare for device suspend
> >>    *
> >
>
