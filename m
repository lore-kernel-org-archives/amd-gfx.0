Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54A7C3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 19:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0FA10E1D6;
	Fri,  2 May 2025 19:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzcxcYOf";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4A410E1D6
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 19:16:28 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3087a70557bso382693a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746213386; x=1746818186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2ZqE/50spkT0cZTyd9Q0q0jCIGQ85xgYYJ50I6ianE=;
 b=dzcxcYOftAhXvY/fN5zrkNO2J1V9qT9GLfLrFRCIkzIRU1cc4dhojpR1EHQfhW/aeC
 6ITeVruC8mi69dyjzxSDN3eI03ou/GsZRCRkR+C2lfxROx6AS8rdqoJwp1QCqTGRUezS
 iBmbjjr9py3k+sQd0T4oaZ/3HlVsh3iyBIg40no72d7BkIBlvO7PPHw1zuIjrOqIHLUl
 ST8Z0pTULHMy8wH02EqLGdsB/vGBXJ7i8qOmq8NpLDcfqT9lYXBpj0X6fg3EWt9+sxzX
 RGdEeHKkJzILBDFq6Ir4eth5RIn6/mSetHCpGPh8cNMQ7tXwE4ctgMDFiu7gtO/1FWZX
 jNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746213386; x=1746818186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2ZqE/50spkT0cZTyd9Q0q0jCIGQ85xgYYJ50I6ianE=;
 b=XiaX+FflpTFGl2KgfKnSDbS6BUqhz7ls8f8ItvF+fSbsFth/sKQbtFgI+rgqR2Z06x
 rLimcU8TyaXkzlfLS7b5ebgXPOC3h13/KkTKHbF0XbPEcnoz/22TFc/mcbM1PTCpmccV
 3ooz9iZCg+6RFAYe37vb52NXFr8z9MX3lSxDGYlhk2oFxsp+vSpPhpRoU7SVAQ1/Dez+
 +3gr36XB/EWB1M3t7wCouJYwsicDP23ShJyDsgBe+hy77GBwNOx4nn92W6jKL2ksRK+h
 FCcYd/BMiIhbly/72b+zGaw/lrdEBywnwY9JK3gjeSmk4gLRoiQeU4fgRGl3HerN6YwL
 EvvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW352Tc1u1ObmTcY9v8kAbCOq1hY7HU/fEqYgmSXWks67w4grBKWv5zBGFm+jJGikwQiTGm+Kel@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyxHfiwOpJglzIwGUQtgj3unKJ3imZnTYgPXOi+YcEP8K1tQXc
 xm7S3HF/BeDiJI+LdcYgNVLp6PejhnCwFoKDWcEhWhDgD8btg1REn8VhH7OOHTJfp7cx7kUJnhp
 YAKonUTHYQv8LC2waSjE9U1SO8DE=
X-Gm-Gg: ASbGncvcPE8J7oXjYgThU5SCuDhvjGw0/SUTSMJqwfcNFQ+/93bFFfxY146938KwY4D
 wVb+3UCy/7pAu5LQ/ZVSoAAwWdPTmx1VTaXuk4jcUwPFGCXdolU5e5Rxrp58lTwiFwaF2WEvPcQ
 gTrMKUNKQkVBaRg4ZCjrXHPg==
X-Google-Smtp-Source: AGHT+IHguNJ0/WvW/HXTK//etvCNLvzwwk9VRubvsyn09CvJS/H+gOiZIDlzm1AGF/lYjGrC7h9iQfxOilCV6o2/gCg=
X-Received: by 2002:a17:90b:38c4:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-30a4e4108c1mr2497521a91.0.1746213385809; Fri, 02 May 2025
 12:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
 <591ce362-8150-4c81-a9b0-2752e0f27d15@amd.com>
 <CADnq5_M8KQyCPZ5iXJBqmHyuzHOomXWNfDvxwJnmXZ45a=T-6g@mail.gmail.com>
 <CADnq5_MhNS1Mff2JZqtzuqYg=xmpM_vDtRwka6NcTU1aUvixiw@mail.gmail.com>
 <1dd4060e-456c-4fd9-8e12-4b8eaf2e3bda@amd.com>
In-Reply-To: <1dd4060e-456c-4fd9-8e12-4b8eaf2e3bda@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 15:16:13 -0400
X-Gm-Features: ATxdqUEsNt6QFh0Grz8_SJOLG14uANPfmCV6J3knqPvbJ8VNB97C8GAEYOikB-c
Message-ID: <CADnq5_M2+qQ9fjC_ba86F7Dpdn412W+ZCpWG3P7FCXJXXRFZgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Fri, May 2, 2025 at 12:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/2/2025 8:13 AM, Alex Deucher wrote:
> > On Fri, May 2, 2025 at 8:56=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com> wrote:
> >>
> >> On Thu, May 1, 2025 at 5:19=E2=80=AFPM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>> On 5/1/2025 3:09 PM, Alex Deucher wrote:
> >>>> Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
> >>>> the resource evictions properly in pm prepare based on whether
> >>>> we are suspending or hibernating.  Drop the eviction as processes
> >>>> are not frozen at this time, we we can end up getting stuck trying
> >>>> to evict VRAM while applications continue to submit work which
> >>>> causes the buffers to get pulled back into VRAM.
> >>>>
> >>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> >>>> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification ca=
llback support")
> >>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>
> >>> Rather than removing the callbacks (and thus introducing the "other"
> >>> bugs with memory pressure), I've sent an alternative series.  LMK wha=
t
> >>> you think of this instead.
> >>>
> >>> https://lore.kernel.org/amd-gfx/20250501211734.2434369-1-superm1@kern=
el.org/T/#m6cdc075af911868667ea6fc849bcd196477d6c20
> >>
> >> Series looks good to me, but I think a variant of this patch (with the
> >> evictions still in place) still makes sense so that we can properly
> >> set the suspend and hibernate flags in amdgpu so that we can optimize
> >> the evictions for suspend on APUs.  Will respin.
> >
> > I think this set still makes sense for stable, but then if your patch
> > series lands, we can apply the attached patch on top of that.
>
> OK.  Let me re-look through your series once more and I'll leave
> comments or a tag.

Thanks.

>
> Regarding the patch to re-introduced it you attached, I suppose the
> drm_warn() message doesn't need to talk about freezing processes as a
> solution to eviction failure because freezing is implied with the new
> notifier in use.

Will fix.

Thanks

Alex

>
> >
> > Alex
> >
> >>
> >> Alex
> >>
> >>>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++------=
-----
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++---------------=
--
> >>>>    2 files changed, 15 insertions(+), 32 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_device.c
> >>>> index 71d95f16067a4..d232e4a26d7bf 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> @@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(str=
uct amdgpu_device *adev)
> >>>>     * @data: data
> >>>>     *
> >>>>     * This function is called when the system is about to suspend or=
 hibernate.
> >>>> - * It is used to evict resources from the device before the system =
goes to
> >>>> - * sleep while there is still access to swap.
> >>>> + * It is used to set the appropriate flags so that eviction can be =
optimized
> >>>> + * in the pm prepare callback.
> >>>>     */
> >>>>    static int amdgpu_device_pm_notifier(struct notifier_block *nb, u=
nsigned long mode,
> >>>>                                     void *data)
> >>>>    {
> >>>>        struct amdgpu_device *adev =3D container_of(nb, struct amdgpu=
_device, pm_nb);
> >>>> -     int r;
> >>>>
> >>>>        switch (mode) {
> >>>>        case PM_HIBERNATION_PREPARE:
> >>>>                adev->in_s4 =3D true;
> >>>> -             fallthrough;
> >>>> +             break;
> >>>> +     case PM_POST_HIBERNATION:
> >>>> +             adev->in_s4 =3D false;
> >>>> +             break;
> >>>>        case PM_SUSPEND_PREPARE:
> >>>> -             r =3D amdgpu_device_evict_resources(adev);
> >>>> -             /*
> >>>> -              * This is considered non-fatal at this time because
> >>>> -              * amdgpu_device_prepare() will also fatally evict res=
ources.
> >>>> -              * See https://gitlab.freedesktop.org/drm/amd/-/issues=
/3781
> >>>> -              */
> >>>> -             if (r)
> >>>> -                     drm_warn(adev_to_drm(adev), "Failed to evict r=
esources, freeze active processes if problems occur: %d\n", r);
> >>>> +             if (amdgpu_acpi_is_s0ix_active(adev))
> >>>> +                     adev->in_s0ix =3D true;
> >>>> +             else if (amdgpu_acpi_is_s3_active(adev))
> >>>> +                     adev->in_s3 =3D true;
> >>>> +             break;
> >>>> +     case PM_POST_SUSPEND:
> >>>> +             adev->in_s0ix =3D adev->in_s3 =3D false;
> >>>>                break;
> >>>>        }
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_drv.c
> >>>> index cec041a556013..6599fb6313220 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>> @@ -2572,10 +2572,6 @@ static int amdgpu_pmops_suspend(struct device=
 *dev)
> >>>>        struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>>>        struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >>>>
> >>>> -     if (amdgpu_acpi_is_s0ix_active(adev))
> >>>> -             adev->in_s0ix =3D true;
> >>>> -     else if (amdgpu_acpi_is_s3_active(adev))
> >>>> -             adev->in_s3 =3D true;
> >>>>        if (!adev->in_s0ix && !adev->in_s3) {
> >>>>                /* don't allow going deep first time followed by s2id=
le the next time */
> >>>>                if (adev->last_suspend_state !=3D PM_SUSPEND_ON &&
> >>>> @@ -2608,7 +2604,6 @@ static int amdgpu_pmops_resume(struct device *=
dev)
> >>>>    {
> >>>>        struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>>>        struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >>>> -     int r;
> >>>>
> >>>>        if (!adev->in_s0ix && !adev->in_s3)
> >>>>                return 0;
> >>>> @@ -2617,12 +2612,7 @@ static int amdgpu_pmops_resume(struct device =
*dev)
> >>>>        if (!pci_device_is_present(adev->pdev))
> >>>>                adev->no_hw_access =3D true;
> >>>>
> >>>> -     r =3D amdgpu_device_resume(drm_dev, true);
> >>>> -     if (amdgpu_acpi_is_s0ix_active(adev))
> >>>> -             adev->in_s0ix =3D false;
> >>>> -     else
> >>>> -             adev->in_s3 =3D false;
> >>>> -     return r;
> >>>> +     return amdgpu_device_resume(drm_dev, true);
> >>>>    }
> >>>>
> >>>>    static int amdgpu_pmops_freeze(struct device *dev)
> >>>> @@ -2643,13 +2633,8 @@ static int amdgpu_pmops_freeze(struct device =
*dev)
> >>>>    static int amdgpu_pmops_thaw(struct device *dev)
> >>>>    {
> >>>>        struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>>> -     struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >>>> -     int r;
> >>>>
> >>>> -     r =3D amdgpu_device_resume(drm_dev, true);
> >>>> -     adev->in_s4 =3D false;
> >>>> -
> >>>> -     return r;
> >>>> +     return amdgpu_device_resume(drm_dev, true);
> >>>>    }
> >>>>
> >>>>    static int amdgpu_pmops_poweroff(struct device *dev)
> >>>> @@ -2662,9 +2647,6 @@ static int amdgpu_pmops_poweroff(struct device=
 *dev)
> >>>>    static int amdgpu_pmops_restore(struct device *dev)
> >>>>    {
> >>>>        struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>>> -     struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >>>> -
> >>>> -     adev->in_s4 =3D false;
> >>>>
> >>>>        return amdgpu_device_resume(drm_dev, true);
> >>>>    }
> >>>
>
