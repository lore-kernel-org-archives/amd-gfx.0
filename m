Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA627ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 13:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1146A10E63F;
	Thu, 27 Oct 2022 13:40:02 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2947810E63F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 13:40:00 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id o64so2004487oib.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/g7L+m5NKE67R2i5b+ccq7pzZDlJHlec8AynLY1BxI=;
 b=bQJFJIzBfWsm2hUOUW0sQ17LOpicOOZQQ/2rqerrcmdbcnjAYUubWMkEbR5oSO/O5f
 hLpU+v/eHqy5/hAcQOpBWRL02JD7rCEcwRs3XVWMGKpfgvfTpubjw523bmOaRGhMLBpx
 YQFJq7KyVn1GElg9yuzT6mndzgfLYZ7NThvXugXYk1l2moONVYIWaltKD0RmtOKcuDlH
 qRlUWmRgD9jP0kGyzf5tsLETIwq3TOZx2u5RIAg9HmmEvE6TvQ9jRVIwFDXuvS9Qbj/X
 iiExcYJExRbYny87pwgouGCGV8lU5R9U+lrAlKZNVwqSAkmCdKDP4PLRW/HSfbm647k3
 jTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/g7L+m5NKE67R2i5b+ccq7pzZDlJHlec8AynLY1BxI=;
 b=catgqjE/trZMLv+lFI3Qp+tZ75tHEsuGm3vRWFPH4jq9DD+S0umERoxD2OyvjA+2N1
 12MTpB4luZgptFeH4q3LDgwrJWBXGDzy0Yx9+9UwBnT3RhGe+jo8pRNRwZH/iH8HdkE1
 1p2jDd0GJzP2O4C+Zp3WkuYwYuhOmQeElchdTo3lmB0X5TEGISomeugoIvJOmPGhliZt
 T8lgaCObB6/qPCvlGtLFQWi4AQ+mzhmawkkVyLQWb8NvQ+5pNQ5W7TE9RMUT8If8oyMS
 o/tC2wuXnLWbiWhTILNyTquhobAlbFdgbNANqnhh9GlWmu+6ElDXmzuheXuxGH6B+wuW
 PFUw==
X-Gm-Message-State: ACrzQf0qg0GLbHKe7mgZ4C3WWlpqM84B26RiW+j/RxlTgn+2ayfMFCfF
 5/Oxh1HngxxH2XWgd1lwbthiaZgRauHusV+eM/c=
X-Google-Smtp-Source: AMsMyM4rg6wx5aU4ip2RjTVLS1fpesFQn/pShF7ECgf4NY62IYlzfY6Fru68E5nFNa5bBYOPvQz7p4eWFaN8nVDkLMc=
X-Received: by 2002:a05:6808:998:b0:359:c7f3:1ef8 with SMTP id
 a24-20020a056808099800b00359c7f31ef8mr723351oic.46.1666877999222; Thu, 27 Oct
 2022 06:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221026190355.18166-1-mario.limonciello@amd.com>
 <bd562d26-56cb-4b02-1fad-ba19eaac0b41@amd.com>
 <CADnq5_Oxj_q74AqzcqqHadWUdgxRAOi_B7MmuZO9CXN35JExuA@mail.gmail.com>
In-Reply-To: <CADnq5_Oxj_q74AqzcqqHadWUdgxRAOi_B7MmuZO9CXN35JExuA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Oct 2022 09:39:47 -0400
Message-ID: <CADnq5_N6fNnM0r+2Cih6J35PwR2HiVGvVZeg1zmaFi79K83s_w@mail.gmail.com>
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

Patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Oct 27, 2022 at 9:39 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Oct 27, 2022 at 2:31 AM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 26.10.22 um 21:03 schrieb Mario Limonciello:
> > > If a system does not have swap and memory is under 100% usage,
> > > amdgpu will fail to evict resources.  Currently the suspend
> > > carries on proceeding to reset the GPU:
> > >
> > > ```
> > > [drm] evicting device resources failed
> > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP =
block <vcn_v3_0> failed -12
> > > [drm] free PSP TMR buffer
> > > [TTM] Failed allocating page table
> > > [drm] evicting device resources failed
> > > amdgpu 0000:03:00.0: amdgpu: MODE1 reset
> > > amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
> > > amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
> > > ```
> > >
> > > At this point if the suspend actually succeeded I think that amdgpu
> > > would have recovered because the GPU would have power cut off and
> > > restored.  However the kernel fails to continue the suspend from the
> > > memory pressure and amdgpu fails to run the "resume" from the aborted
> > > suspend.
> > >
> > > ```
> > > ACPI: PM: Preparing to enter system sleep state S3
> > > SLUB: Unable to allocate memory on node -1, gfp=3D0xdc0(GFP_KERNEL|__=
GFP_ZERO)
> > >    cache: Acpi-State, object size: 80, buffer size: 80, default order=
: 0, min order: 0
> > >    node 0: slabs: 22, objs: 1122, free: 0
> > > ACPI Error: AE_NO_MEMORY, Could not update object reference count (20=
210730/utdelete-651)
> > >
> > > [drm:psp_hw_start [amdgpu]] *ERROR* PSP load kdb failed!
> > > [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
> > > [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block <p=
sp> failed -62
> > > amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
> > > PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -62
> > > amdgpu 0000:03:00.0: PM: failed to resume async: error -62
> > > ```
> > >
> > > To avoid this series of unfortunate events, fail amdgpu's suspend
> > > when the memory eviction fails.  This will let the system gracefully
> > > recover and the user can try suspend again when the memory pressure
> > > is relieved.
> >
> > Yeah, I've been thinking about that handling for a while now as well.
> >
> > Failing to suspend when we are OOM is certainly the right thing to do
> > from a technical perspective.
> >
> > But it also means that when users close their laptop it can happen that
> > it keeps running and draining the battery.
> >
> > On the other hand when you don't have swap configured it's your fault
> > and not the drivers.
> >
> > It's a trade off and I'm not sure what's better. Alex any comment here?
>
> Probably better handled in userspace as Mario noted.  Also, at least
> the whole driver won't fall apart due to important buffers getting
> lost.
>
> Alex
>
>
> >
> > Thanks,
> > Christian.
> >
> > >
> > > Reported-by: post@davidak.de
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2223
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++++-----
> > >   1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> > > index 6f958603c8cc2..ae10acede495e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -4060,15 +4060,18 @@ void amdgpu_device_fini_sw(struct amdgpu_devi=
ce *adev)
> > >    * at suspend time.
> > >    *
> > >    */
> > > -static void amdgpu_device_evict_resources(struct amdgpu_device *adev=
)
> > > +static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
> > >   {
> > > +     int ret;
> > > +
> > >       /* No need to evict vram on APUs for suspend to ram or s2idle *=
/
> > >       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU=
))
> > > -             return;
> > > +             return 0;
> > >
> > > -     if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
> > > +     ret =3D amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
> > > +     if (ret)
> > >               DRM_WARN("evicting device resources failed\n");
> > > -
> > > +     return ret;
> > >   }
> > >
> > >   /*
> > > @@ -4118,7 +4121,9 @@ int amdgpu_device_suspend(struct drm_device *de=
v, bool fbcon)
> > >       if (!adev->in_s0ix)
> > >               amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> > >
> > > -     amdgpu_device_evict_resources(adev);
> > > +     r =3D amdgpu_device_evict_resources(adev);
> > > +     if (r)
> > > +             return r;
> > >
> > >       amdgpu_fence_driver_hw_fini(adev);
> > >
> >
