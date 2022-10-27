Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C44FFA3742
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 13:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6355310E63D;
	Thu, 27 Oct 2022 13:39:36 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9AD810E63D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 13:39:32 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-13be3ef361dso1968639fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+hpE6ntZhNI5LvRKWtcGtgumGy5LA5/UwuvLyiFb0Q=;
 b=cdOMAD1G41/59H4hprvhS2CJ8F+IzcvQo7dXPfTdle6Fd/rsC49AnafzMS11T+l5Zw
 C4A3cTjEmYwkB/Z3yD6GZ3R2PysWgE8TUmF303GMMMxnlGvxmp8TiL7CvdnDw9CckKO7
 aWts4kFuZHTP7vKD3Pt1FGhX+XYtIahXy1Wxy/VUKbY/vzCbUvtUTybZTPNQ2tQ2E5Ol
 8KsgQRnPL4p8A6OYU+LSe+TZU6oyyW+voo3FdzVyQHijZr070TZZ5tbO8hMlopDNVTFX
 79jn+SHgtLOiubXmWbtTP82xiI4dhLFyD0f+qBowGVgRV6KYSmjzCV/27TY71hNUAxeV
 LSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+hpE6ntZhNI5LvRKWtcGtgumGy5LA5/UwuvLyiFb0Q=;
 b=wKpJaWJysDjfJpdsdOtH6UeaseZ63Qv7+SYvPSFqVg2ywTZWrmvMGLFvUtQYIlP9hY
 qYWDuRydBPmq1isM9MzVm9ivjnYzGlPRqmi3czGshKrjG7PZiA1BBeBytqDcL/DlJerQ
 R1rlk0xpXXaGhv5S103z64+o4kLDH9rf4ZYDnglSWimNXm5Tg7L+8DaSdb+jq7mojr1/
 kJVEWZwqHx3mkqJyfwJ9VRR97hPGmBfJW3uA0oYIB8cNbsmPmnxY15FQtcZSq3hjFuFK
 HWGc0jYqZ9K3ECv4t5qBYImC78d1TWg0T51zvYQnYAErGQ1UkalZZYBJmSDlaeacw/rH
 Bz+A==
X-Gm-Message-State: ACrzQf21TB86BvJtzFWqw1iyneiIvYthyTTzh0rj1Sog6Bg8k8hVZCHR
 Z2vxj7Q3VEfdRGKZHwP6TL01wnUUByOIaOzUGgfdcMvc
X-Google-Smtp-Source: AMsMyM4AddhxiCDEFRXlA1tfm0bw3onTGxRxGJ85tdZ29iEzDEPRsae9ttnzKkqDJ0eka3xJ39PJ/VUKsBJ8GN0zhKM=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr5610846oao.96.1666877971909; Thu, 27
 Oct 2022 06:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221026190355.18166-1-mario.limonciello@amd.com>
 <bd562d26-56cb-4b02-1fad-ba19eaac0b41@amd.com>
In-Reply-To: <bd562d26-56cb-4b02-1fad-ba19eaac0b41@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Oct 2022 09:39:20 -0400
Message-ID: <CADnq5_Oxj_q74AqzcqqHadWUdgxRAOi_B7MmuZO9CXN35JExuA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fail the suspend if resources can't be evicted
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, post@davidak.de,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 27, 2022 at 2:31 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 26.10.22 um 21:03 schrieb Mario Limonciello:
> > If a system does not have swap and memory is under 100% usage,
> > amdgpu will fail to evict resources.  Currently the suspend
> > carries on proceeding to reset the GPU:
> >
> > ```
> > [drm] evicting device resources failed
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP bl=
ock <vcn_v3_0> failed -12
> > [drm] free PSP TMR buffer
> > [TTM] Failed allocating page table
> > [drm] evicting device resources failed
> > amdgpu 0000:03:00.0: amdgpu: MODE1 reset
> > amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
> > amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
> > ```
> >
> > At this point if the suspend actually succeeded I think that amdgpu
> > would have recovered because the GPU would have power cut off and
> > restored.  However the kernel fails to continue the suspend from the
> > memory pressure and amdgpu fails to run the "resume" from the aborted
> > suspend.
> >
> > ```
> > ACPI: PM: Preparing to enter system sleep state S3
> > SLUB: Unable to allocate memory on node -1, gfp=3D0xdc0(GFP_KERNEL|__GF=
P_ZERO)
> >    cache: Acpi-State, object size: 80, buffer size: 80, default order: =
0, min order: 0
> >    node 0: slabs: 22, objs: 1122, free: 0
> > ACPI Error: AE_NO_MEMORY, Could not update object reference count (2021=
0730/utdelete-651)
> >
> > [drm:psp_hw_start [amdgpu]] *ERROR* PSP load kdb failed!
> > [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
> > [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block <psp=
> failed -62
> > amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
> > PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -62
> > amdgpu 0000:03:00.0: PM: failed to resume async: error -62
> > ```
> >
> > To avoid this series of unfortunate events, fail amdgpu's suspend
> > when the memory eviction fails.  This will let the system gracefully
> > recover and the user can try suspend again when the memory pressure
> > is relieved.
>
> Yeah, I've been thinking about that handling for a while now as well.
>
> Failing to suspend when we are OOM is certainly the right thing to do
> from a technical perspective.
>
> But it also means that when users close their laptop it can happen that
> it keeps running and draining the battery.
>
> On the other hand when you don't have swap configured it's your fault
> and not the drivers.
>
> It's a trade off and I'm not sure what's better. Alex any comment here?

Probably better handled in userspace as Mario noted.  Also, at least
the whole driver won't fall apart due to important buffers getting
lost.

Alex


>
> Thanks,
> Christian.
>
> >
> > Reported-by: post@davidak.de
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2223
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 6f958603c8cc2..ae10acede495e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4060,15 +4060,18 @@ void amdgpu_device_fini_sw(struct amdgpu_device=
 *adev)
> >    * at suspend time.
> >    *
> >    */
> > -static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
> > +static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
> >   {
> > +     int ret;
> > +
> >       /* No need to evict vram on APUs for suspend to ram or s2idle */
> >       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
> > -             return;
> > +             return 0;
> >
> > -     if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
> > +     ret =3D amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
> > +     if (ret)
> >               DRM_WARN("evicting device resources failed\n");
> > -
> > +     return ret;
> >   }
> >
> >   /*
> > @@ -4118,7 +4121,9 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool fbcon)
> >       if (!adev->in_s0ix)
> >               amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> >
> > -     amdgpu_device_evict_resources(adev);
> > +     r =3D amdgpu_device_evict_resources(adev);
> > +     if (r)
> > +             return r;
> >
> >       amdgpu_fence_driver_hw_fini(adev);
> >
>
